class InstructorsController < ApplicationController
rescue_from ActiveRecord::RecordNotFound, with: :render_not_found_response

    def index 
        instructors = Instructor.all 
        render json: instructors
    end

    def show 
        instructor = find_instructor
        render json: instructor 
    end

    def create 
        instructor = Instructor.new(instructor_params)
        if instructor.save 
            render json: instructor, status: :created 
        else 
            render json: {error: instructor.errors.full_messages}, status: :unprocessable_entity 
        end
    end

    def update 
        instructor = find_instructor
        instructor.update(instructor_params)
        render json: instructor, status: :accepted
    end

    def destroy 
        instructor = find_instructor
        instructor.destroy
        render json: {}, status: :no_content
    end

    private 

    def find_instructor 
        instructor = Instructor.find(params[:id])
    end

    def instructor_params 
        params.permit(:name)
    end

    def render_not_found_response 
        render json: {error: "Record not found"}, status: :not_found
    end
end
