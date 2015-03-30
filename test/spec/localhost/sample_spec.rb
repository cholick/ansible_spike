require 'spec_helper'

describe command('java -version') do
  its(:stdout) { should match /1\.8/ }
  its(:stdout) { should match /HotSpot/ }
end
