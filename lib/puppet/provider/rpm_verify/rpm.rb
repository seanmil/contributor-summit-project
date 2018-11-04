Puppet::Type.type(:rpm_verify).provide(:rpm) do
  commands rpm: 'rpm'

  def run_verify(package)
    Puppet::Util::Execution.execute(['rpm', '-q', '--verify', package], combined: true)
  end

  def parse_verify(output)
    # From the RPM documentation:
    #
    # The format of the output is a string of 9 characters, a possible attribute marker:
    #
    # c %config configuration file.
    # d %doc documentation file.
    # g %ghost file (i.e. the file contents are not included in the package payload).
    # l %license license file.
    # r %readme readme file.
    #
    # from  the  package  header,  followed  by  the  file name.  Each of the 9 characters denotes the result
    # of a comparison of attribute(s) of the file to the value of those attribute(s) recorded in the database.
    # A single "." (period) means the test passed, while a single "?" (question mark) indicates the test could
    # not be  performed  (e.g. file permissions prevent reading). Otherwise, the (mnemonically emBoldened)
    # character denotes failure of the corresponding --verify test:
    #
    # S file Size differs
    # M Mode differs (includes permissions and file type)
    # 5 digest (formerly MD5 sum) differs
    # D Device major/minor number mismatch
    # L readLink(2) path mismatch
    # U User ownership differs
    # G Group ownership differs
    # T mTime differs
    # P caPabilities differ

    @results = {}
    if output =~ %r{is not installed$}
      @results[:error] = 'package is not installed'
    end
    output.each_line do |line|
      match = line.match(%r{^(missing |.........)  (.) (.*)$})
      if match
        tests, attribute, file = match.captures
      else
        warning("Unknown RPM verify output line: '#{line}', skipping")
        next
      end
      @results[file] = {
        attribute: attribute,
        tests: tests,
      }
    end
    @results
  end

  def exists?
    results = parse_verify(run_verify(resource[:package]))

    if results.empty?
      true
    else
      false
    end
  end

  def create
    raise Puppet::Error, 'RPM package validation failed'
  end
end
