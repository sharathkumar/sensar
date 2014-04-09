object @user
node(:some_count) { |m| @user.name }
child(@user) { attribute :name }