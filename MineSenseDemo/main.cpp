#include <QApplication>
#include <QQmlApplicationEngine>
#include "controllers/graphcontroller.h"
#include "helpers/csvfilehandler.h"
using  namespace std;

int main(int argc, char *argv[])
{
    QApplication app(argc, argv);

    QQmlApplicationEngine engine;
    engine.load(QUrl(QStringLiteral("qrc:///main.qml")));
    GraphController *controller = new GraphController(0, engine.rootContext());
    engine.rootContext()->setContextProperty("controller", controller);

    return app.exec();
}
