#! /usr/bin/env ruby
begin
  require 'octokit'
rescue LoadError
  puts "This script requires the 'octokit' gem."
  puts "Either install it with:"
  puts "  $ gem install octokit"
  puts
  puts "or run this script with bundler (preferred):"
  puts "  $ gem install bundler"
  puts "  $ bundle install --path vendor/bundle"
  puts "  $ bundle exec #{__FILE__}"
  exit 1
end

def question(message, required=false)
  loop do
    print "#{message} "
    answer = STDIN.gets.strip
    next if required and answer.empty?

    return answer
  end
end

begin
  oauth    = nil
  upstream = 'puppetlabs/contributor-summit-project'
  origin   = `git config --get remote.origin.url`.strip.match(/github.com[\/:]([\w-]+\/[\w-]+)(?:.git)?$/)[1]
  username = origin.split('/').first
  password = question('What is your GitHub password?', true)
  otpcode  = question('Type your two-factor code, or press [enter] to skip:').delete(' ')
rescue => e
  raise "Please run this script from within the Contributor Summit project template repository"
end

begin
  # inspired by https://github.com/TimothyBritt/github-issue-migrate
  client = Octokit::Client.new(:login => username, :password => password)
  unless otpcode.empty?
    # create a temporary oauth token to use while cloning issues
    oauth = client.create_authorization(:scopes  => ['repo'],
                                        :note    => 'Contributor Summit Project',
                                        :headers => { 'X-GitHub-OTP' => otpcode })

    # Creating the authorization isn't enough. Now we've got to re-login with that token
    client = Octokit::Client.new(:access_token => oauth[:token])
  end

  client.auto_paginate = true
  client.edit_repository(origin, options = { :has_issues => true })

  milestones = client.milestones(upstream)
  milestones.each do |source|
    print '.'
    client.create_milestone(origin, source.title, { :description => source.description,
                                                    :due_on      => source.due_on })
  end

  issues = client.issues(upstream).reverse!
  issues.each do |source|
    next if source.pull_request
    print '.'
    client.create_issue(origin, source.title, source.body, { :milestone => source.milestone.number,
                                                             :labels    => source.labels })
  end
rescue => e
  puts
  puts e.message
  puts "Error source: #{e.backtrace.last}"
end

puts
if oauth
  # now let's clean up that oauth token
  otpcode = question('Type your two-factor code again so we can cleanup:').delete(' ')
  client  = Octokit::Client.new(:login => username, :password => password)
  client.delete_authorization(oauth[:id], :headers => { 'X-GitHub-OTP' => otpcode })
end
