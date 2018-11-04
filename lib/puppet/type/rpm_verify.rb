Puppet::Type.newtype(:rpm_verify) do
  @doc = 'Perform RPM package verifications as a resource'

  ensurable do
    defaultvalues
    defaultto :present
  end

  newparam(:package) do
    desc 'The name of the package to run verify on'
    isnamevar
  end

  autorequire(:package) { catalog.resource(:package, self[:package]) }
end
