import { NavRouter } from '../router/NavRouter';
import { OpenUniDialog } from '../util/OpenUniDialog';

@Entry
@ComponentV2
struct Index {
  @Local message: string = 'Hello World';

  build() {
    Navigation(NavRouter.getInstance().getPathStack()) {
      Stack({ alignContent: Alignment.Center }) {
        Column() {
          Text(this.message)
            .fontSize(36)
            .fontColor(Color.Red)
          Button('Click Me')
            .onClick(() => {
              this.message = 'Hello ArkUI';
            })

          Button('基于Navigation实现自定义弹窗', { stateEffect: true, type: ButtonType.Capsule })
            .onClick(() => {
              NavRouter.push('dialog')
            })
        }
      }
    }
    .height('100%')
    .width('100%')
  }
}