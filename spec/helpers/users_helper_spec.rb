require 'spec_helper'

describe UsersHelper do
  let(:user) { create(:user, email: 'johndoe@example.com') }

  describe '#gravatar_for' do
    before do
      ENV['DISABLE_GRAVATAR'] = nil
    end

    it "returns the image tag for the specified user's gravtar image" do
      expect(gravatar_for(user)).to eq('<img alt="John Doe" class="gravatar" src="https://secure.gravatar.com/avatar/fd876f8cd6a58277fc664d47ea10ad19?s=48" />')
    end

    it "returns the image tag for the specified user's gravtar image with size" do
      expect(gravatar_for(user, size: 128)).to eq('<img alt="John Doe" class="gravatar" src="https://secure.gravatar.com/avatar/fd876f8cd6a58277fc664d47ea10ad19?s=128" />')
    end

    context "when gravatar is disabled" do
      #app/assets/images/logo.svg
      before do
        ENV['DISABLE_GRAVATAR'] = 'true'
      end

      it "returns the image tag for the chef logo image" do
        expect(gravatar_for(user)).to eq("<img alt=\"John Doe\" class=\"gravatar\" src=\"/images/apple-touch-icon.png\" />")
      end

      after do
        ENV['DISABLE_GRAVATAR'] = nil
      end
    end
  end
end
