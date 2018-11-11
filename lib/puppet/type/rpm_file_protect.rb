Puppet::Type.newtype(:rpm_file_protect) do
  @doc = 'Use RPM metadata to enforce and protect files.'

  newparam(:path) do
    desc 'The fully qualified filesystem path to match. Accepts Ruby globs as specified by File.fnmatch?.'
    isnamevar
  end

  def generate
    resources = []

    files = provider.rpm_files_matching_path(self[:path])

    files.each do |file|
      res = Puppet::Type.type(:file).new(
        path: file,
      )

      resources << res unless catalog.resource_refs.include?(res)
    end

    resources
  end
end
