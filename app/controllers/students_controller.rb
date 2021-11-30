class StudentsController < ApplicationController
rescue_from ActiveRecord::RecordNotFound, with: :render_not_found_response

    def index 
        students = Student.all
        render json: students 
    end 

    def show 
        student = find_student 
        render json: student 
    end

    def create 
        student = Student.new(student_params)
        if student.save 
            render json: student, status: :created 
        else 
            render json: {error: student.errors.full_messages}, status: :unprocessable_entity 
        end
    end

    def update 
        student = find_student
        student.update(student_params)
        render json: student, status: :accepted
    end

    def destroy 
        student = find_student
        student.destroy 
        render json: {}, status: :no_content
    end


    private 

    def find_student 
        student = Student.find(params[:id])
    end

    def student_params 
        params.permit(:name, :major, :age, :instructor_id)
    end

    def render_not_found_response 
        render json: {error: "Record not found"}, status: :not_found
    end
end
