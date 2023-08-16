class Public::MembersController < ApplicationController

  before_action :authenticate_member!, unless: :admin_signed_in?
  before_action :set_current_member,  except: [:index, :show, :favorite]
  before_action :valid_id?,           only: [:show]
  before_action :ensure_guest_member, only: [:edit]

  def index
    @posts = current_member.posts.all.page(params[:page]).per(12)
  end

  def show
    @member = Member.find(params[:id])
    @posts =  @member.posts.all.page(params[:page]).per(12)
  end

  def edit
  end

  def update
    if @member.update(member_params)
      redirect_to members_path, notice: "プロフィールを変更しました。"
    else
      if @member.nickname.blank?
        flash[:notice] = "ニックネームを入力してください。"
      else
        flash[:notice] = "このメールアドレスは既に使われています。"
      end
      render :edit
    end
  end

  def favorite
    favorites =       Favorite.where(member_id: current_member.id).pluck(:post_id)
    @favorite_posts = Post.find(favorites)
    @favorite_posts = Kaminari.paginate_array(@favorite_posts).page(params[:page]).per(6)
  end

  def deal
    @rooms = @member.rooms.page(params[:page]).per(6)
  end

  def quit_form
  end

  def confirm
    @member = Member.new(
      nickname:              current_member.nickname,
      reason_for_quit_genre: params[:member][:reason_for_quit_genre],
      reason_for_quit:       params[:member][:reason_for_quit]
    )
  end

  def quit
    @member.update!(
      status: :inactive,
      reason_for_quit_genre: params[:member][:reason_for_quit_genre],
      reason_for_quit:       params[:member][:reason_for_quit]
    )
    reset_session
    redirect_to root_path, notice: "またのご利用お待ちしております"
  end

  private

  def member_params
    params.require(:member).permit(:nickname,
                                   :email,
                                   :introduction,
                                   :icon,
                                   :status,
                                   :reason_for_quit_genre,
                                   :reason_for_quit
    )
  end

  def ensure_guest_member
    if current_member.guest_member?
      redirect_to member_path(current_member), notice: "ゲストユーザーはプロフィール編集画面へ遷移できません。"
    end
  end

  def set_current_member
    @member = current_member
  end

  def valid_id? # リロード対策
    if params[:id].to_s == "confirm" || params[:id].to_s == "information"
      redirect_to request.referer, notice: "現在のページでのリロードは処理が無効となります。"
      return
    end
  end
end
