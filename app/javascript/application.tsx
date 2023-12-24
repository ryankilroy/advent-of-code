import { Application } from "@hotwired/stimulus";
import "@hotwired/turbo-rails";
import React from "react";
import StarCompletion from "./components/star_completion";

// Use Turbo, Stimulus, React, and ReactDOM in a no-op to avoid unused import warnings
console.log(Application, React, StarCompletion);