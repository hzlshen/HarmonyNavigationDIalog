import { HashMap } from '@kit.ArkTS';
import { Callback } from '@kit.BasicServicesKit';

export interface RouterParams {
  name?: string,
  onPop?: (data: PopInfo) => void
}

export class AppRouter {
  private static instance = new AppRouter();
  private pathStack: NavPathStack = new NavPathStack();
  private routeMap: HashMap<string, WrappedBuilder<[object]>> = new HashMap();

  public static getInstance(): AppRouter {
    return AppRouter.instance;
  }

  public getPathStack(): NavPathStack {
    return this.pathStack;
  }

  public addRouteMap(name: string, builder:
    WrappedBuilder<[object]>): void {
    this.routeMap.set(name, builder)
  }

  private pushPath(name: string): void {
    this.pathStack.pushPath({ name: name })
  }

  public static push(name: string): void {
    AppRouter.instance.pushPath(name);
  }

  public static openDialog(name: string, params?: RouterParams): void {
    AppRouter.instance.pathStack.pushPath({
      name: name, param: params, onPop: (data: PopInfo) => {
        if (params?.onPop) {
          params.onPop!(data);
        }
      }
    });
  }

  public static replace(name: string, params?: RouterParams): void {
    AppRouter.instance.pathStack.replacePath({ name: name, param: params });
  }

  public static getParams(name: string): string {
    return JSON.stringify(AppRouter.instance.pathStack.getParamByName(name));
  }

  public static getLastParams(): Object {
    return AppRouter.instance.pathStack.getParamByIndex(AppRouter.instance.pathStack.size()-1) as Object;
  }

  public static pop(): void {
    AppRouter.instance.pathStack.pop();
  }

  public static popWithResult(params: RouterParams): void {
    AppRouter.instance.pathStack.pop(params);
  }
}
