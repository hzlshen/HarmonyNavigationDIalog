import { HashMap } from '@kit.ArkTS';

export interface RouterParams {
  name?: string,
  onPop?: (data: PopInfo) => void
}

export class NavRouter {
  private static instance = new NavRouter();
  private pathStack: NavPathStack = new NavPathStack();
  private routeMap: HashMap<string, WrappedBuilder<[object]>> = new HashMap();

  public static getInstance(): NavRouter {
    return NavRouter.instance;
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
    NavRouter.instance.pushPath(name);
  }

  public static openDialog(name: string, params?: RouterParams): void {
    NavRouter.instance.pathStack.pushPath({
      name: name, param: params, onPop: (data: PopInfo) => {
        if (params?.onPop) {
          params.onPop!(data);
        }
      }
    });
  }

  public static replace(name: string, params?: RouterParams): void {
    NavRouter.instance.pathStack.replacePath({ name: name, param: params });
  }

  public static getParams(name: string): string {
    return JSON.stringify(NavRouter.instance.pathStack.getParamByName(name));
  }

  public static getLastParams(): Object {
    return NavRouter.instance.pathStack.getParamByIndex(NavRouter.instance.pathStack.size()-1) as Object;
  }

  public static pop(): void {
    NavRouter.instance.pathStack.pop();
  }

  public static popWithResult(params: RouterParams): void {
    NavRouter.instance.pathStack.pop(params);
  }
}
