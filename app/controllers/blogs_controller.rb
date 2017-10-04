class BlogsController < ApplicationController
  before_action :set_blog, only:[:show,:edit,:update,:destroy]
  #DRYより
  
  def index
    @blogs = Blog.all
  end

  # 追記する
  def new
      @blog = Blog.new
      #追記２(このインスタンス変数は、型をビューに与える役割でしかない？)
  end
  
  def create
    @blog = Blog.new(blog_params)
    if @blog.save
      #バリデーション成功時にTRUE
      redirect_to blogs_path, notice:"ブログを作成しました！"
    else
    # 入力フォームを再描画します。
    #エラーが発生した場合、エラー情報を@blogに格納
    render 'new'
    end
  end
  
  def show
  end
  
  def edit
  end
  
  def update
    #データベースの既存の。
    if @blog.update(blog_params)
      redirect_to blogs_path,notice: "ブログを編集しました"
    else
      render "edit"
    end
  end
  
  def destroy
    @blog.destroy
    redirect_to blogs_path, notice:"ブログを削除しました"
  end
  
  private
  # private method
  # private配下にメソッドを記述するとそのクラス内からしか呼び出せなくなる。
  
  def blog_params
  #ストロングパラメータで取得するメソッドです。
  #更新機能でも使用する
    params.require(:blog).permit(:title, :content)
  end
  
  def set_blog
  #DRYの原則により重複するコードをメソッド化
    @blog = Blog.find(params[:id])
  end
end

