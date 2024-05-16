# app/controllers/api/v1/teachers_controller.rb
module Api
    module V1
        class TeachersController < ApplicationController
            def index
                Rails.logger.info "Entering index action"
                @teachers = Teacher.all
                render json: @teachers
            end

            def show
                @teacher = Teacher.find(params[:id])
                render json:@teacher
            end

            def update
                @teacher = Teacher.find(params[:id])
                if @teacher.update(teacher_params)
                    render json:@teacher
                else
                    render json:@teacher.errors,status: :unprocessable_entity
                end
            end
            

            def create
                @teacher = Teacher.new(teacher_params)
                if @teacher.save
                    render json: @teacher
                else
                    render json: @teacher.errors,status: :unprocessable_entity
                end
            end

            def destroy
                @teacher = Teacher.find(params[:id])
                if @teacher.present?
                    @teacher.destroy
                    render json:@teacher
                else
                    render json: {error:'Teacher not found'},status: :not_found
                end
            end
            
            private
            def teacher_params
                params.require(:teacher).permit(:name,:address)
            end
        end
    end
end
  