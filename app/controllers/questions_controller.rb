class QuestionsController < ApplicationController
  before_action :set_lesson
  before_action :set_question, only: %i[ show edit update destroy ]

  # GET /questions or /questions.json
  def index
    @questions = @lesson.questions.all || []
  end

  # GET /questions/1 or /questions/1.json
  def show
  end

  # GET /questions/new
  def new
    @question = @lesson.questions.build
  end

  # GET /questions/1/edit
  def edit
  end

  # POST /questions or /questions.json
  def create
    @question = @lesson.questions.build(question_params)

    respond_to do |format|
      if @question.save
        format.turbo_stream
        format.html { redirect_to [@lesson,@question], notice: "Question was successfully created." }
        format.json { render :show, status: :created, location: @question }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @question.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /questions/1 or /questions/1.json
  def update
    respond_to do |format|
      if @question.update(question_params)
        format.html { redirect_to [@lesson,@question], notice: "Question was successfully updated." }
        format.json { render :show, status: :ok, location: @question }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @question.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /questions/1 or /questions/1.json
  def destroy
    @question.destroy!

    respond_to do |format|
      format.html { redirect_to lesson_questions_url(@lesson), notice: "Question was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    def set_lesson
      @lesson = Lesson.find_by(id: params[:lesson_id])
    end
    # Use callbacks to share common setup or constraints between actions.
    def set_question
      @question = @lesson.questions.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def question_params
      params.require(:question).permit(:lesson_id, :content)
    end
end
