require 'spec_helper'

describe package('emacs23-nox') do
  it { should be_installed }
end

describe file('/usr/local/share/emacs/site-lisp/default.el') do
  it { should be_file }
  it { should contain /backup-by-copying/ }
end

describe command('hostname') do
  its(:stdout) { should match /cholick\.com\.dev/ }
end
