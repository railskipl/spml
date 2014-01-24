class MrConsumersController < ApplicationController
  
  def index
  	query =  params["sub_cluster_cont"]["sub_cluster_cont"]
   	@consumers = MrConsumer.find_all_by_sub_cluster(query)
    @consumers = @consumers.sort_by {|i| i.walking_seq_sr_no}
  	respond_to do |format|
     format.html
     format.xls
    end
  end

  def add_csv
    # @search = MrConsumer.search(params[:q])
    # @sub_cluster = MrConsumer.all.uniq.pluck(:sub_cluster)
  end

  def import
  MrConsumer.import(params[:file])
  redirect_to readings_path, notice: "Consumer imported."
end

 # def consumer
 #   @consumer = Consumer.find_by_consno(params[:consno])
 #    respond_to do |format|
 #         format.html
 #         format.json { render json:  @consumer }
 #    end
 # end

end
