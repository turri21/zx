//-------------------------------------------------------------------------------------------------
module mmcm0
//-------------------------------------------------------------------------------------------------
(
	input  wire ci,
	output wire co0,
	output wire locked
);
//-------------------------------------------------------------------------------------------------

wire fi0, fo0;

MMCME2_BASE #
(
	.CLKIN1_PERIOD   (20.000),
	.DIVCLK_DIVIDE   ( 1    ),
	.CLKFBOUT_MULT_F (21.000),
	.CLKOUT0_DIVIDE_F(18.750)
)
mmcm0
(
	.CLKIN1          (ci),
	.CLKFBIN         (fi0),

	.PWRDWN          (1'b0),
	.RST             (1'b0),

	.CLKFBOUT        (fo0),
	.CLKFBOUTB       (),
	.CLKOUT0         (co0),
	.CLKOUT0B        (),
	.CLKOUT1         (),
	.CLKOUT1B        (),
	.CLKOUT2         (),
	.CLKOUT2B        (),
	.CLKOUT3         (),
	.CLKOUT3B        (),
	.CLKOUT4         (),
	.CLKOUT5         (),
	.CLKOUT6         (),
	.LOCKED          (locked)
);

BUFG bufgfb0(.I(fo0), .O(fi0));

//-------------------------------------------------------------------------------------------------
endmodule
//-------------------------------------------------------------------------------------------------
