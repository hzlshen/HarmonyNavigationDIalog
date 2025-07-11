import { AppRouter } from '../router/NavRouter'

@Entry
@ComponentV2
struct Index {
  @Local selectedIndex: number = 0
  @Local targetIndex: number = 0
  private controller: TabsController = new TabsController();

  @Builder
  tabBuilder(title: string, targetIndex: number) {
    Column() {
      Image(this.selectedIndex === this.targetIndex ? $r('app.media.activeStar') : $r('app.media.star'))
        .width(24)
        .height(24)
        .margin({ bottom: 4 })
        .objectFit(ImageFit.Contain)
      Text(title).fontColor(this.selectedIndex === this.targetIndex ? '#1698CE' : '#6B6B6B')
    }
    .width('100%')
    .justifyContent(FlexAlign.Center)
    .height(50)
  }

  build() {
    Navigation(AppRouter.getInstance().getPathStack()) {
      Stack({ alignContent: Alignment.Center }) {
        Column() {
          // Button('基于Navigation实现自定义弹窗', { stateEffect: true, type: ButtonType.Capsule })
          //   .onClick(() => {
          //     AppRouter.push('dialog')
          //   })
          Tabs({ barPosition: BarPosition.End }) {
            TabContent() {
              Text('首页')
            }
            .tabBar(this.tabBuilder('首页', 0))

            TabContent() {
              Text('分类')
            }
            .tabBar(this.tabBuilder('分类', 1))

            TabContent() {
              Text('发现')
            }
            .tabBar(this.tabBuilder('发现', 2))

            TabContent() {
              Text('我的')
            }
            .tabBar(this.tabBuilder('我的', 3))
          }
        }
        .height('100%')
        .width('100%')
      }
    }
    .hideTitleBar(true)
  }
}