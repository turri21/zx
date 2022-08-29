//-------------------------------------------------------------------------------------------------
module dcm
//-------------------------------------------------------------------------------------------------
(
	input  wire clock50,
	output wire clock56,
	output wire locked,
	input  wire model
);
//-------------------------------------------------------------------------------------------------

wire ci;
IBUFG IBufg(.I(clock50), .O(ci));

//-------------------------------------------------------------------------------------------------

wire b0, c0, o0, l0;

DCM_SP #
(
	.CLKIN_PERIOD          (20.000),
	.CLKFX_DIVIDE          (25    ),
	.CLKFX_MULTIPLY        (28    )
)
Dcm0
(
	.RST                   (1'b0),
	.DSSEN                 (1'b0),
	.PSCLK                 (1'b0),
	.PSEN                  (1'b0),
	.PSINCDEC              (1'b0),
	.CLKIN                 (ci),
	.CLKFB                 (b0),
	.CLK0                  (c0),
	.CLK90                 (),
	.CLK180                (),
	.CLK270                (),
	.CLK2X                 (),
	.CLK2X180              (),
	.CLKFX                 (o0), // 56.000 MHz output
	.CLKFX180              (),
	.CLKDV                 (),
	.PSDONE                (),
	.STATUS                (),
	.LOCKED                (l0)
);

BUFG BufgB0(.I(c0), .O(b0));

//-------------------------------------------------------------------------------------------------

wire b1, c1, l1, o1;

DCM_SP #
(
	.CLKIN_PERIOD          (20.000),
	.CLKFX_DIVIDE          (22    ),
	.CLKFX_MULTIPLY        (25    )
)
Dcm1
(
	.RST                   (1'b0),
	.DSSEN                 (1'b0),
	.PSCLK                 (1'b0),
	.PSEN                  (1'b0),
	.PSINCDEC              (1'b0),
	.CLKIN                 (ci),
	.CLKFB                 (b1),
	.CLK0                  (c1),
	.CLK90                 (),
	.CLK180                (),
	.CLK270                (),
	.CLK2X                 (),
	.CLK2X180              (),
	.CLKFX                 (o1), // 56.7504 MHz output
	.CLKFX180              (),
	.CLKDV                 (),
	.PSDONE                (),
	.STATUS                (),
	.LOCKED                (l1)
);

BUFG BufgB1(.I(c1), .O(b1));

//-------------------------------------------------------------------------------------------------

BUFGMUX_1 BufgMux(.I0(o0), .I1(o1), .O(clock56), .S(model));
assign locked = l0 & l1;

//-------------------------------------------------------------------------------------------------
endmodule
//-------------------------------------------------------------------------------------------------