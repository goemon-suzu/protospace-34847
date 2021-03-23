class PrototypesController < ApplicationController
  before_action :set_prototype, except: [:index, :new, :create]  #上から順番に読み込まれるので、before_actionの順番はprototypeの宣言を優先する。
  before_action :authenticate_user!, only: [:new, :edit, :destroy]  #アクションを実行する前にログインしていなければログイン画面に遷移。
  before_action :move_to_index, only: [:edit, :update, :destroy]

  def index
    @prototypes = Prototype.includes(:user) #prototypesテーブルの情報に紐づくユーザー情報を1度のアクセスでまとめて取得することができる
  end

  def new
    @prototype = Prototype.new
  end

  def create
    @prototype = Prototype.new(prototype_params)
    if @prototype.save
      redirect_to root_path
    else
      render :new #注 →:newは、:action が省略されて記述してある
    end
  end

  def show
    @comment = Comment.new
    @comments = @prototype.comments
  end

  def edit
  end
  
  def update
      if @prototype.update(prototype_params)
        redirect_to prototype_path(@prototype)
      else
        render :edit
      end
  end

  def destroy
    if @prototype.destroy #保存じゃないから(prototype_params)はいらない
      redirect_to root_path
    end
    
  end
  
  
  private

  def set_prototype
    @prototype = Prototype.find(params[:id])  #変数名（prototype）の中にいれるデーターの個数が単数なのか複数なのかで名前を単数、複数にしているか決めている
  end

  def prototype_params
    params.require(:prototype).permit(:title, :catch_copy, :concept, :image).merge(user_id: current_user.id)
  end

  def move_to_index
    unless @prototype.user == current_user
      redirect_to root_path
    end
  end

end
