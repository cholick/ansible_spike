require 'spec_helper'

describe command('java -version') do
  its(:stderr) { should match /1\.8/ }
  its(:stderr) { should match /HotSpot/ }
end
