# Project Suggestions

These are intended to be more inspirational than prescriptive. If this list prompts
a different idea, that's even better than snagging one of these. But if you'd like,
feel free to run with anything on this list. Before claiming one, check the [forks](../../network/members)
and see if you can join forces with someone already working on it.

* Puppet 6 introduces [Deferred functions](https://github.com/puppetlabs/puppet-specifications/blob/master/language/types_values_variables.md#deferrednew),
  which are evaluated during catalog application time -- eg, agent-side functions.
  This provides functionality for all kinds of exciting things: secret management,
  data that must be looked up by the agent, registering with some service that responds
  with an authentication token, etc. What kind of exciting things could you think of?
  See an example project at [puppet-vault-demo](https://github.com/puppetlabs/puppet-vault-demo).

* PQL is awesome and powerful, and like many things powerful it can be difficult to use.
  It would be great to have a graphical PQL editor and/or explainer. You can see some neat
  examples of something similar at https://regexr.com or at http://buildregex.com.

* Bolt offers some intriguing new possibilities for deploying configuration changes.
  Write up a proposal for a workflow for applying ad-hoc but still repeatable
  configuration changes on-demand.

* Speaking of Bolt, wouldn't it be great to have a Bolt-based acceptance test framework
  that's much easier to use than Beaker?

* Types and Providers have long been a dark art. Recently though, we've released 
  [a new library to simplify the job](https://puppet.com/docs/puppet/6.0/create_types_and_providers_resource_api.html).
  If there's always been that job you knew was suited for a type and provider, but didn't
  have the time to learn how -- now's the time. Build a new T&P or port an existing
  defined type to the Resource API.

* The Puppet Server stack has been containerized, which opens us up to all sorts of nifty
  ideas. Perhaps you could put together a quick acceptance test automation framework using
  [Pupperware](https://github.com/puppetlabs/pupperware). What else can you imagine?

* Puppet Server now comes with a new [CA command line tool and gem](https://puppet.com/docs/puppetserver/6.0/release_notes.html).
  It might be nice to have an open source graphical/web certificate management interface.

* Do you have a favorite open source project? How are its docs? What about that one
  project? You know, the one with the default `README.md` created by GitHub... Maybe
  your project for this month could be writing documentation and a user guide.

* Creating a `Puppetfile` is sometimes a tedious exercise. It would be much better if
  dependencies were resolved for you automatically. For that matter, there are many
  places in the Puppet ecosystem which would benefit from a dependency resolver.
  Perhaps you could build this in such a way that r10k could use it, the PDK could
  use it, etc. Maybe you could even wire up [an external library](https://github.com/CocoaPods/Molinillo)
  to do the hard work for you.


* Make it possible to store the CA on object storage to make the Puppet stack
  fully "cloud native" and stateless.

* None of these look exciting? Check the [forks](../../network/members) and see if you
  can join an existing project.
