class FriendsController < InheritedResources::Base
  private

  def friend_params
    params.require(:friend).permit(:name, :name_en, :description, :description_en, :is_authorised, :image)
  end
end
