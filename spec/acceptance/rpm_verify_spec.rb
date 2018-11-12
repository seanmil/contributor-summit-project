require 'spec_helper_acceptance'

describe 'rpm_verify type' do
  let(:manifest) { 'rpm_verify{ "crontabs": }' }

  install_package(default, 'crontabs')

  it 'applies with no failures' do
    apply_manifest(manifest, catch_failures: true)
  end

  it 'raises a failure on a bad checksum' do
    shell('echo "# foo" >> /etc/crontab')

    apply_manifest(manifest, expect_failures: true)
  end
end
