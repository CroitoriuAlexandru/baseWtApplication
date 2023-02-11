#include "include/App.h"
#include <Wt/WPushButton.h>

// Application is a containerWidget
Application::Application()
	: WContainerWidget()
{
	setStyleClass("m-auto mt-3");
	auto testBtn = addWidget(std::make_unique<Wt::WPushButton>("i work"));
	testBtn->setStyleClass("btn btn-success");
}
