require 'rails_helper'

RSpec.describe Membership, :type => :model do

  let(:membership){ Membership.new() }

  it 'should be valid' do
    expect(membership).to be_valid
  end

end
