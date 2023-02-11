#include "include/App.h"
#include <Wt/WApplication.h>
#include <Wt/WServer.h>
#include <Wt/Dbo/Exception.h>

std::unique_ptr<Wt::WApplication> createApplication(const Wt::WEnvironment& env)
{
	auto app = std::make_unique<Wt::WApplication>(env);
	// Set up application resourses and settings
	app->setTitle("Base Wt Application");
	app->setTheme(std::make_shared<Wt::WBootstrap5Theme>());

	// import resources
	app->useStyleSheet("resources/styles/dist/style.css");
	app->messageResourceBundle().use(app->appRoot() + "resources/templates/general");
	app->require("resources/styles/script/script.js");

	// Application content
	app->root()->addWidget(std::make_unique<Application>());
	
	return app;
}

int main(int argc, char** argv)
{
	try {
		// Server setup
		Wt::WServer server{ argc, argv, WTHTTP_CONFIGURATION };

		server.addEntryPoint(Wt::EntryPointType::Application, createApplication);

		server.run();
	}
	catch (Wt::WServer::Exception& e) {
		std::cerr << e.what() << std::endl;
	}
	catch (Wt::Dbo::Exception& e) {
		std::cerr << "Dbo exception: " << e.what() << std::endl;
	}
	catch (std::exception& e) {
		std::cerr << "exception: " << e.what() << std::endl;
	}
}
