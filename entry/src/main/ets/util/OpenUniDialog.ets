import { NavRouter } from "../router/NavRouter";

export class OpenUniDialog {
  static instance: OpenUniDialog;
  private lastIndex: number = 0;
  private options?: OpenUniDialogOption;

  public static buildWithOptions(options?: OpenUniDialogOption): OpenUniDialog {
    let instance: OpenUniDialog = new OpenUniDialog();
    // 记录当前路由栈
    instance.lastIndex = NavRouter.getInstance().getPathStack().size() - 1;
    instance.options = options;
    OpenUniDialog.instance = instance;
    return instance;
  }

  // 使用builder
  public static build(builder: WrappedBuilder<object []>): OpenUniDialog {
    let options = new OpenUniDialogOption();
    options.view = builder;
    return OpenUniDialog.buildWithOptions(options);
  }

  // 显示弹窗
  public open(): OpenUniDialog {
    NavRouter.getInstance().getPathStack().pushPathByName('DEFAULT_DIALOG', this.options)
    return this;
  }

  // 返回
  public onBackPressed(callback: () => boolean): OpenUniDialog {
    this.options!.onBackPressed = callback;
    return this;
  }

  // 关闭所有弹窗
  public static closeAll(): void {
    NavRouter.getInstance().getPathStack().removeByName('DEFAULT_DIALOG');
  }

  // 关闭当前弹窗
  public close(): void {
    if (NavRouter.getInstance().getPathStack().size() >= this.lastIndex) {
      NavRouter.getInstance().getPathStack().popToIndex(OpenUniDialog.instance.lastIndex)
    }
  }
}


// 弹窗参数
export class OpenUniDialogOption {
  view?: WrappedBuilder<object[]>; // 弹窗内容
  params?: Object // 弹窗参数
  onClose?: () => void // 关闭回调
  onPop?: (data: PopInfo) => void // 弹窗返回回调 带参
  onBackPressed?: () => boolean // 侧滑返回拦截
  styles?: OpenUniDialogStyle = new OpenUniDialogStyle() // 弹窗样式
}

// 弹窗样式
export class OpenUniDialogStyle {
  transparent: boolean = false // 透明
  background: string = 'rgba(0,0,0,0.5)' // 背景色
  radius: Length = 5 // 圆角
  align: Alignment = Alignment.Center // 对齐
}