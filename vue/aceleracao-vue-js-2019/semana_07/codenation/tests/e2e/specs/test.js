describe("My First Test", () => {
  it("Visits the app root url", () => {
    cy.visit("/");
    cy.get(".level-right > .button").click();
    cy.get(":nth-child(1) > .control > .input").type("1");
    cy.get(":nth-child(1) > .help").contains(
      "O campo nome é obrigatório e deve conter pelo menos três caracteres"
    );
    cy.get(":nth-child(1) > .control > .input").clear();
  });
});
