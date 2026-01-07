#include <Geode/Geode.hpp>
#include <Geode/modify/PlayerObject.hpp>

using namespace geode::prelude;

class $modify(PlayerObject) {
    void update(float dt) {
        PlayerObject::update(dt);

        // Solo funciona si el jugador está presionando la pantalla/tecla
        if (this->m_isHolding) {
            auto levelLayer = PlayLayer::get();
            if (levelLayer) {
                auto objects = levelLayer->m_objects;
                
                // Recorremos los objetos cercanos para buscar orbes
                CCARRAY_FOREACH_ROUTINE(objects, obj, {
                    auto gameObject = static_cast<GameObject*>(obj);
                    
                    // Verificamos si es una orbe (tipo 7) y si está activa
                    if (gameObject->m_objectType == GameObjectType::ActivePeripheral) {
                        // Si el jugador está dentro del rango de la orbe
                        if (this->getPosition().getDistance(gameObject->getPosition()) < 50.0f) {
                            // Activamos la orbe automáticamente
                            levelLayer->activateObjectInternal(gameObject, this);
                        }
                    }
                });
            }
        }
    }
};
