class LessonsController < ApplicationController
  before_action :set_course
  before_action :set_lesson, only: %i[ show edit update destroy ]

  # GET /lessons or /lessons.json
  def index
    @lessons = @course&.lessons&.all || []
  end

  # GET /lessons/1 or /lessons/1.json
  def show
  end

  # GET /lessons/new
  def new
    @lesson = @course.lessons.build
  end

  # GET /lessons/1/edit
  def edit
  end

  # POST /lessons or /lessons.json
  def create
    @lesson = @course.lessons.build(lesson_params)

    respond_to do |format|
      if @lesson.save
        format.html { redirect_to [@course,@lesson], notice: "Lesson was successfully created." }
        format.json { render :show, status: :created, location: @lesson }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @lesson.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /lessons/1 or /lessons/1.json
  def update
    respond_to do |format|
      if @lesson.update(lesson_params)
        format.html { redirect_to [@course,@lesson], notice: "Lesson was successfully updated." }
        format.json { render :show, status: :ok, location: @lesson }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @lesson.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /lessons/1 or /lessons/1.json
  def destroy
    @lesson.destroy!

    respond_to do |format|
      format.html { redirect_to course_lessons_url(@course), notice: "Lesson was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    def set_course
      @course = Course.find_by(id: params[:course_id])
    end
    # Use callbacks to share common setup or constraints between actions.
    def set_lesson
      @lesson = @course.lessons.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def lesson_params
      params.require(:lesson).permit(:title, :content)
    end
end
