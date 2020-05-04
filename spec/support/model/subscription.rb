shared_examples_for 'Subscriptionable' do
  it { should have_many(:subscriptions).dependent(:destroy) }
end
