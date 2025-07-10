import { CommonConstants } from '../common/CommonConstants';
import { AppRouter } from '../router/NavRouter';

export class OpenUniDialog {
  static instance: OpenUniDialog;
  private lastIndex: number = 0;
  private options?: OpenUniDialogOption;

  public static buildWithOptions(options?: OpenUniDialogOption): OpenUniDialog {
    let instance: OpenUniDialog = new OpenUniDialog();
    //获取并保存弹窗的路由栈序号
    instance.lastIndex = AppRouter.getInstance().getPathStack().size() - 1;
    instance.options = options;
    OpenUniDialog.instance = instance;
    return instance;
  }

  public static build(builder: WrappedBuilder<Object[]>): OpenUniDialog {
    let options: OpenUniDialogOption = new OpenUniDialogOption();
    options.view = builder;
    return OpenUniDialog.buildWithOptions(options);
  }

  public static closeAll(): void {
    AppRouter.getInstance().getPathStack().removeByName(CommonConstants.DEFAULT_DIALOG);
  }

  public open(): OpenUniDialog {
    AppRouter.getInstance().getPathStack().pushPathByName(CommonConstants.DEFAULT_DIALOG, this.options);
    return this;
  }

  public onBackPressed(callback: () => boolean): OpenUniDialog {
    this.options!.onBackPressed = callback;
    return this;
  }

  public close(): void {
    if (AppRouter.getInstance().getPathStack().size() >= this.lastIndex) {
      AppRouter.getInstance().getPathStack().popToIndex(this.lastIndex);
    }
  }
}

//定义弹窗选项类
export class OpenUniDialogOption {
  view?: WrappedBuilder<Object[]> //自定义弹窗内容组件
  params?: Object //打开时传递参数
  onClose?: () => void //
  onPop?: (data: PopInfo) => void //接收上一个弹窗关闭时的参数回调
  onBackPressed?: () => boolean //侧滑返回拦截
  styles?: OpenUniDialogStyle = new OpenUniDialogStyle() //弹窗样式
}

//定义弹窗样式类
export class OpenUniDialogStyle {
  transparent: boolean = false
  background: string = 'rgba(0,0,0,0.5)'
  radius: Length = 5
  align: Alignment = Alignment.Center
}