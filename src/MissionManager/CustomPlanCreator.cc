/****************************************************************************
 *
 *   (c) 2009-2016 QGROUNDCONTROL PROJECT <http://www.qgroundcontrol.org>
 *
 * QGroundControl is licensed according to the terms in the file
 * COPYING.md in the root of the source code directory.
 *
 ****************************************************************************/

#include "CustomPlanCreator.h"
#include "PlanMasterController.h"
#include "MissionSettingsItem.h"
#include "FixedWingLandingComplexItem.h"

CustomPlanCreator::CustomPlanCreator(PlanMasterController* planMasterController, QObject* parent)
    : PlanCreator(planMasterController, tr("Custom"), QStringLiteral("/qmlimages/PlanCreator/CustomPlanCreator.png"), parent)
{

}

void CustomPlanCreator::createPlan(const QGeoCoordinate& mapCenterCoord)
{
    _planMasterController->removeAll();
    VisualMissionItem* takeoffItem = _missionController->insertSimpleMissionItem(mapCenterCoord, -1);
    takeoffItem->setWizardMode(true);
    _missionController->insertSimpleMissionItem(mapCenterCoord.atDistanceAndAzimuth(50, 135), -1)->setWizardMode(true);
    _missionController->insertSimpleMissionItem(mapCenterCoord.atDistanceAndAzimuth(50, -135),-1)->setWizardMode(true);
    if (_planMasterController->managerVehicle()->fixedWing()) {
        FixedWingLandingComplexItem* landingItem = qobject_cast<FixedWingLandingComplexItem*>(_missionController->insertComplexMissionItem(MissionController::patternFWLandingName, mapCenterCoord, -1));
        landingItem->setWizardMode(true);
        landingItem->setLoiterDragAngleOnly(true);
    } else {
        MissionSettingsItem* settingsItem = _missionController->visualItems()->value<MissionSettingsItem*>(0);
        settingsItem->setMissionEndRTL(true);
    }
    _missionController->setCurrentPlanViewIndex(takeoffItem->sequenceNumber(), true);

}
