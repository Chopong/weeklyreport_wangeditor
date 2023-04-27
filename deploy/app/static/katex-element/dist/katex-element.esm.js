import { LitElement, html } from 'lit-element';
import katex from 'katex/dist/katex.mjs';

class KatexElement extends LitElement {

  static get properties() {
      return {
          displayMode: { type: Boolean },
      };
  }

  constructor()
  {
      super();
      this.displayMode = false;
  }

  firstUpdated() {
      this.elSlot = this.shadowRoot.querySelector('slot');
      let slotNode = this.elSlot.assignedNodes()[0];
      let slotData = slotNode.data;

      let elContainer = this.shadowRoot.querySelector('#container');
      katex.render(slotData, elContainer, {
          displayMode: this.displayMode,
          throwOnError: false
      });
  }

  render() {
      return html`
      <link rel="stylesheet" href="/static/katex/katex.min.css" crossorigin="anonymous">

      <div id="container">
          <slot></slot>
      </div>
  `;
  }
}

window.customElements.define('katex-element', KatexElement);

export default KatexElement;
