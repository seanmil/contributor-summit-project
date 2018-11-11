require 'spec_helper_acceptance'

describe 'rpm_file_protect type' do
  before(:all) do
    on(default, 'yum install -y less')
  end

  after(:each) do
    on(default, 'yum reinstall -y less')
  end

  context 'when protecting a directory from purging' do
    let(:manifest) do
      <<-EOS
      file { '/etc/profile.d':
        recurse => true,
        purge   => true,
      }

      rpm_file_protect { '/etc/profile.d/*': }
      EOS
    end

    apply_manifest('file { "/etc/profile.d/purgeme": ensure => file }')

    it 'applies with expected changes' do
      apply_manifest(manifest, catch_failures: true)
    end

    describe file('/etc/profile.d/purgeme') do
      it { is_expected.not_to exist }
    end

    describe file('/etc/profile.d/less.sh') do
      it { is_expected.to exist }
    end
  end

  context 'when overriding a protected file' do
    let(:manifest) do
      <<-EOS
      file { '/etc/profile.d':
        recurse => true,
        purge   => true,
      }

      file { mytestfile:
        path    => '/etc/profile.d/less.sh',
        ensure  => 'file',
        content => '# something new',
      }

      rpm_file_protect { '/etc/profile.d/*': }
      EOS
    end

    it 'applies with expected changes' do
      apply_manifest(manifest, catch_failures: true)
    end
  end
end
