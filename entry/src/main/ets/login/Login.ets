import { CommonConstants } from '../common/CommonConstants'
import { AppRouter } from '../router/NavRouter'
import { OpenUniDialog } from '../util/OpenUniDialog'

/**
 * 隐私协议弹窗
 */
@Builder
export function PrivacyDialogViewBuilder() {
  PrivacyDialogView()
}

@Component
struct PrivacyDialogView {
  scroller: Scroller = new Scroller()

  build() {
    Column() {
      Text('温馨提示')
        .fontSize(18)
        .fontWeight(FontWeight.Bold)
        .padding({ top: 15, left: 15, right: 15 })
      Scroll(this.scroller) {
        Text() {
          Span('根据《常见类型移动互联网应用程序必要个人信息范围规定》,主要功能为购买商品，' +
            '必要个人信息为：注册用户电话号码；收货人姓名、地址、联系电话;支付时间、支付金额、支付渠道等。' +
            '请您在使用我们的服务前仔细阅读')
          Span('《隐私政策》')
            .fontColor(Color.Orange)
            .fontWeight(FontWeight.Bold)
            .decoration({ type: TextDecorationType.Underline, color: Color.Orange })
            .onClick(() => {
              AppRouter.push(CommonConstants.PRIVACY_PAGE)
            })
          Span('。请您知悉，同意隐私政策仅代表您已了解应用提供功能，以及功能运行所需的必要个人信息。')
          Span('基于您的授权我们可能会获取您的位置等信息，您有权拒绝或取消授权；' +
            '我们会采取业界先进的安全措施保护您的信息安全；' +
            '未经您同意，我们不会从第三方处获取、共享或向其提供您的信息；' +
            '您可以查询、更正、删除您的个人信息')
        }
        .fontSize(16)
        .padding(15)
      }.scrollable(ScrollDirection.Vertical)
      .height(240)

      Button('同意', { type: ButtonType.Capsule })
        .onClick(() => {
          OpenUniDialog.instance.close();
        }).margin({ top: 10, bottom: 10 })
        .width('80%')
      Button('不同意', { stateEffect: false, buttonStyle: ButtonStyleMode.TEXTUAL })
        .onClick(() => {
          OpenUniDialog.instance.close();
        }).margin({ bottom: 10 })
    }
    .backgroundColor(Color.White)
    .borderRadius(15)
    .width(250)
  }
}