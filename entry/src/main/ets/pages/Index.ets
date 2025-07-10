import { AppRouter } from '../router/NavRouter'

@Entry
@Component
struct Index {
  build() {
    Navigation(AppRouter.getInstance().getPathStack()) {
      Stack({ alignContent: Alignment.Center }) {
        Column() {
          Button('基于Navigation实现自定义弹窗', { stateEffect: true, type: ButtonType.Capsule })
            .onClick(() => {
              AppRouter.push('dialog')
            })
        }
      }
      .height('100%')
      .width('100%')
    }
    .hideTitleBar(true)
  }
}