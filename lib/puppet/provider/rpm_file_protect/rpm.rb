Puppet::Type.type(:rpm_file_protect).provide(:rpm) do
  commands rpm: 'rpm'

  def rpm_get_all_files
    rpm('-q', '-a', '-l').split("\n")
  end

  def files_matching_path(path, files)
    files.select do |file|
      File.fnmatch?(path, file, File::FNM_PATHNAME | File::FNM_DOTMATCH | File::FNM_EXTGLOB)
    end
  end

  def rpm_files_matching_path(path)
    files_matching_path(path, rpm_get_all_files)
  end
end
