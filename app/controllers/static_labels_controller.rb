class StaticLabelsController < InheritedResources::Base
  private

  def static_label_params
    params.require(:static_label).permit(:key, :value, :scope, :archived)
  end
end
