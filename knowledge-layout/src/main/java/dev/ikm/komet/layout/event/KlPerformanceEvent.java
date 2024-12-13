package dev.ikm.komet.layout.event;

import dev.ikm.komet.layout.component.KlComponentPaneSingle;
import dev.ikm.komet.layout.selection.Selection;

/**
 * Represents a performance event within the Kl framework. This event is triggered
 * by the execution of a specific action within a component.
 */
public interface KlPerformanceEvent extends KlEvent {
     /**
      * Retrieves the component that performed the specific action or event.
      *
      * @return a KlComponentPaneSingle instance related to the performance event
      */
     KlComponentPaneSingle<?,?> performer();

     /**
      * Retrieves the selection on which the event's action was performed.
      *
      * @return a Selection instance for the performance event
      */
     Selection performanceSelection();
}