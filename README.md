# CI/CDの実現

このプロジェクトではCirlceCIを用いての自動テスト、自動デプロイを行っている。

流れは以下の通り。

    masterブランチからmainブランチにプッシュする。(masterからでなくても良いが、その場合は諸々の修正が必要)
    ↓
    CircleCIによってtestが実行される。
    ↓
    testが通ればAWSのインスタンスにsshで入る。
    testが失敗すればこの時点で終了する。
    ↓
    インスタンス内部でシェルスクリプトを実行。
    ↓
    masterブランチをpull。(testが通っていることは2番目のフローで確認済み)
    ↓
    pullした内容でビルドし、作成するdockerimageの中に実行ファイルをエントリーポイントとして配置する。その後dockerhubにpush。
    ↓
    アプリケーション起動。

正直なところ、dockerhubへのpushは冗長。ただ、pushされたdockerimageをpullしてしまえば、起動するだけでアプリケーションが実行できるので、この流れを組み込んだ。(マイクロサービスなどではこうなっている気がしたので)

インスタンスでは`deploy-me.sh`を実行している。

circleci.ymlではcircleciに設定した環境変数を使っているため、プロジェクトごとに対応が必要。

注意:
mainにプッシュすると回る`deploy`は終了しないので注意。
(springbootアプリケーションを起動させて終わっているため)

---
シェルで実行する`rmi.sh`

`rmi.sh`
```console
ids=$(docker images -q)
childId=$(
    for i in ${ids}; do
    docker history $i | grep -q $1 && echo $i
    done | sort -u
    )
docker rmi ${childId}
```