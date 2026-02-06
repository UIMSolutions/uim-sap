/**
 * Tile models
 * 
 * Copyright: Copyright © 2018-2026, Ozan Nurettin Süel
 * License: Apache-2.0
 * Authors: Ozan Nurettin Süel
 */
module uim.sap.fiori.models.tile;

import vibe.data.json;

/**
 * Dynamic tile data
 */
struct TileData {
    string title;
    string subtitle;
    string number;
    string unit;
    string trend;  // Up, Down, Neutral
    string state;  // Neutral, Positive, Negative, Critical
    string targetUrl;
}

/**
 * Tile action
 */
struct TileAction {
    string id;
    string text;
    string icon;
    string press;  // Event handler
}

/**
 * KPI tile configuration
 */
struct KPITile {
    string title;
    string description;
    string serviceUrl;
    string entitySet;
    string measure;
    string dimension;
    string threshold;
    string trend;
}
