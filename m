Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 648261BEACF
	for <lists+dmaengine@lfdr.de>; Wed, 29 Apr 2020 23:58:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727963AbgD2V6R (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 29 Apr 2020 17:58:17 -0400
Received: from relmlor2.renesas.com ([210.160.252.172]:20937 "EHLO
        relmlie6.idc.renesas.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727108AbgD2V6Q (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 29 Apr 2020 17:58:16 -0400
X-IronPort-AV: E=Sophos;i="5.73,333,1583161200"; 
   d="scan'208";a="45795843"
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie6.idc.renesas.com with ESMTP; 30 Apr 2020 06:58:14 +0900
Received: from localhost.localdomain (unknown [10.226.36.204])
        by relmlir6.idc.renesas.com (Postfix) with ESMTP id 49CBE40ECBAC;
        Thu, 30 Apr 2020 06:58:10 +0900 (JST)
From:   Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To:     Geert Uytterhoeven <geert+renesas@glider.be>,
        Magnus Damm <magnus.damm@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Vinod Koul <vkoul@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <maz@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Russell King <linux@armlinux.org.uk>
Cc:     Lad Prabhakar <prabhakar.csengg@gmail.com>,
        devicetree@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org,
        linux-gpio@vger.kernel.org, linux-serial@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH 07/18] ARM: dts: r8a7742: Initial SoC device tree
Date:   Wed, 29 Apr 2020 22:56:44 +0100
Message-Id: <1588197415-13747-8-git-send-email-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1588197415-13747-1-git-send-email-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <1588197415-13747-1-git-send-email-prabhakar.mahadev-lad.rj@bp.renesas.com>
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Basic support for the RZ/G1H (R8A7742) SoC. Added placeholders
for the peripherals supported by the SoC which will be filled up
by incremental patches.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Reviewed-by: Marian-Cristian Rotariu <marian-cristian.rotariu.rb@bp.renesas.com>
---
 arch/arm/boot/dts/r8a7742.dtsi | 715 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 715 insertions(+)
 create mode 100644 arch/arm/boot/dts/r8a7742.dtsi

diff --git a/arch/arm/boot/dts/r8a7742.dtsi b/arch/arm/boot/dts/r8a7742.dtsi
new file mode 100644
index 0000000..a2c858e
--- /dev/null
+++ b/arch/arm/boot/dts/r8a7742.dtsi
@@ -0,0 +1,715 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Device Tree Source for the r8a7742 SoC
+ *
+ * Copyright (C) 2020 Renesas Electronics Corp.
+ */
+
+#include <dt-bindings/interrupt-controller/irq.h>
+#include <dt-bindings/interrupt-controller/arm-gic.h>
+#include <dt-bindings/clock/r8a7742-cpg-mssr.h>
+#include <dt-bindings/power/r8a7742-sysc.h>
+
+/ {
+	compatible = "renesas,r8a7742";
+	#address-cells = <2>;
+	#size-cells = <2>;
+
+	/*
+	 * The external audio clocks are configured as 0 Hz fixed frequency
+	 * clocks by default.
+	 * Boards that provide audio clocks should override them.
+	 */
+	audio_clk_a: audio_clk_a {
+		compatible = "fixed-clock";
+		#clock-cells = <0>;
+		clock-frequency = <0>;
+	};
+
+	audio_clk_b: audio_clk_b {
+		compatible = "fixed-clock";
+		#clock-cells = <0>;
+		clock-frequency = <0>;
+	};
+
+	audio_clk_c: audio_clk_c {
+		compatible = "fixed-clock";
+		#clock-cells = <0>;
+		clock-frequency = <0>;
+	};
+
+	/* External CAN clock */
+	can_clk: can {
+		compatible = "fixed-clock";
+		#clock-cells = <0>;
+		/* This value must be overridden by the board. */
+		clock-frequency = <0>;
+	};
+
+	/* External root clock */
+	extal_clk: extal {
+		compatible = "fixed-clock";
+		#clock-cells = <0>;
+		/* This value must be overridden by the board. */
+		clock-frequency = <0>;
+	};
+
+	/* External PCIe clock - can be overridden by the board */
+	pcie_bus_clk: pcie_bus {
+		compatible = "fixed-clock";
+		#clock-cells = <0>;
+		clock-frequency = <0>;
+	};
+
+	/* External SCIF clock */
+	scif_clk: scif {
+		compatible = "fixed-clock";
+		#clock-cells = <0>;
+		/* This value must be overridden by the board. */
+		clock-frequency = <0>;
+	};
+
+	/* External USB clock - can be overridden by the board */
+	usb_extal_clk: usb_extal {
+		compatible = "fixed-clock";
+		#clock-cells = <0>;
+		clock-frequency = <48000000>;
+	};
+
+	cpus {
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		cpu0: cpu@0 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a15";
+			reg = <0>;
+			clock-frequency = <1400000000>;
+			clocks = <&cpg CPG_CORE R8A7742_CLK_Z>;
+			power-domains = <&sysc R8A7742_PD_CA15_CPU0>;
+			next-level-cache = <&L2_CA15>;
+			capacity-dmips-mhz = <1024>;
+			voltage-tolerance = <1>; /* 1% */
+			clock-latency = <300000>; /* 300 us */
+
+			/* kHz - uV - OPPs unknown yet */
+			operating-points = <1400000 1000000>,
+					   <1225000 1000000>,
+					   <1050000 1000000>,
+					   < 875000 1000000>,
+					   < 700000 1000000>,
+					   < 350000 1000000>;
+		};
+
+		cpu1: cpu@1 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a15";
+			reg = <1>;
+			clock-frequency = <1400000000>;
+			clocks = <&cpg CPG_CORE R8A7742_CLK_Z>;
+			power-domains = <&sysc R8A7742_PD_CA15_CPU1>;
+			next-level-cache = <&L2_CA15>;
+			capacity-dmips-mhz = <1024>;
+			voltage-tolerance = <1>; /* 1% */
+			clock-latency = <300000>; /* 300 us */
+
+			/* kHz - uV - OPPs unknown yet */
+			operating-points = <1400000 1000000>,
+					   <1225000 1000000>,
+					   <1050000 1000000>,
+					   < 875000 1000000>,
+					   < 700000 1000000>,
+					   < 350000 1000000>;
+		};
+
+		cpu2: cpu@2 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a15";
+			reg = <2>;
+			clock-frequency = <1400000000>;
+			clocks = <&cpg CPG_CORE R8A7742_CLK_Z>;
+			power-domains = <&sysc R8A7742_PD_CA15_CPU2>;
+			next-level-cache = <&L2_CA15>;
+			capacity-dmips-mhz = <1024>;
+			voltage-tolerance = <1>; /* 1% */
+			clock-latency = <300000>; /* 300 us */
+
+			/* kHz - uV - OPPs unknown yet */
+			operating-points = <1400000 1000000>,
+					   <1225000 1000000>,
+					   <1050000 1000000>,
+					   < 875000 1000000>,
+					   < 700000 1000000>,
+					   < 350000 1000000>;
+		};
+
+		cpu3: cpu@3 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a15";
+			reg = <3>;
+			clock-frequency = <1400000000>;
+			clocks = <&cpg CPG_CORE R8A7742_CLK_Z>;
+			power-domains = <&sysc R8A7742_PD_CA15_CPU3>;
+			next-level-cache = <&L2_CA15>;
+			capacity-dmips-mhz = <1024>;
+			voltage-tolerance = <1>; /* 1% */
+			clock-latency = <300000>; /* 300 us */
+
+			/* kHz - uV - OPPs unknown yet */
+			operating-points = <1400000 1000000>,
+					   <1225000 1000000>,
+					   <1050000 1000000>,
+					   < 875000 1000000>,
+					   < 700000 1000000>,
+					   < 350000 1000000>;
+		};
+
+		cpu4: cpu@100 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a7";
+			reg = <0x100>;
+			clock-frequency = <780000000>;
+			clocks = <&cpg CPG_CORE R8A7742_CLK_Z2>;
+			power-domains = <&sysc R8A7742_PD_CA7_CPU0>;
+			next-level-cache = <&L2_CA7>;
+		};
+
+		cpu5: cpu@101 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a7";
+			reg = <0x101>;
+			clock-frequency = <780000000>;
+			clocks = <&cpg CPG_CORE R8A7742_CLK_Z2>;
+			power-domains = <&sysc R8A7742_PD_CA7_CPU1>;
+			next-level-cache = <&L2_CA7>;
+		};
+
+		cpu6: cpu@102 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a7";
+			reg = <0x102>;
+			clock-frequency = <780000000>;
+			clocks = <&cpg CPG_CORE R8A7742_CLK_Z2>;
+			power-domains = <&sysc R8A7742_PD_CA7_CPU2>;
+			next-level-cache = <&L2_CA7>;
+		};
+
+		cpu7: cpu@103 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a7";
+			reg = <0x103>;
+			clock-frequency = <780000000>;
+			clocks = <&cpg CPG_CORE R8A7742_CLK_Z2>;
+			power-domains = <&sysc R8A7742_PD_CA7_CPU3>;
+			next-level-cache = <&L2_CA7>;
+		};
+
+		L2_CA15: cache-controller-0 {
+			compatible = "cache";
+			power-domains = <&sysc R8A7742_PD_CA15_SCU>;
+			cache-unified;
+			cache-level = <2>;
+		};
+
+		L2_CA7: cache-controller-1 {
+			compatible = "cache";
+			power-domains = <&sysc R8A7742_PD_CA7_SCU>;
+			cache-unified;
+			cache-level = <2>;
+		};
+	};
+
+	pmu-0 {
+		compatible = "arm,cortex-a15-pmu";
+		interrupts-extended = <&gic GIC_SPI 72 IRQ_TYPE_LEVEL_HIGH>,
+				      <&gic GIC_SPI 73 IRQ_TYPE_LEVEL_HIGH>,
+				      <&gic GIC_SPI 74 IRQ_TYPE_LEVEL_HIGH>,
+				      <&gic GIC_SPI 75 IRQ_TYPE_LEVEL_HIGH>;
+		interrupt-affinity = <&cpu0>, <&cpu1>, <&cpu2>, <&cpu3>;
+	};
+
+	pmu-1 {
+		compatible = "arm,cortex-a7-pmu";
+		interrupts-extended = <&gic GIC_SPI 82 IRQ_TYPE_LEVEL_HIGH>,
+				      <&gic GIC_SPI 83 IRQ_TYPE_LEVEL_HIGH>,
+				      <&gic GIC_SPI 84 IRQ_TYPE_LEVEL_HIGH>,
+				      <&gic GIC_SPI 85 IRQ_TYPE_LEVEL_HIGH>;
+		interrupt-affinity = <&cpu4>, <&cpu5>, <&cpu6>, <&cpu7>;
+	};
+
+	soc {
+		compatible = "simple-bus";
+		interrupt-parent = <&gic>;
+
+		#address-cells = <2>;
+		#size-cells = <2>;
+		ranges;
+
+		gpio0: gpio@e6050000 {
+			compatible = "renesas,gpio-r8a7742",
+				     "renesas,rcar-gen2-gpio";
+			reg = <0 0xe6050000 0 0x50>;
+			#gpio-cells = <2>;
+			gpio-controller;
+			#interrupt-cells = <2>;
+			interrupt-controller;
+			/* placeholder */
+		};
+
+		gpio1: gpio@e6051000 {
+			compatible = "renesas,gpio-r8a7742",
+				     "renesas,rcar-gen2-gpio";
+			reg = <0 0xe6051000 0 0x50>;
+			#gpio-cells = <2>;
+			gpio-controller;
+			#interrupt-cells = <2>;
+			interrupt-controller;
+			/* placeholder */
+		};
+
+		gpio2: gpio@e6052000 {
+			compatible = "renesas,gpio-r8a7742",
+				     "renesas,rcar-gen2-gpio";
+			reg = <0 0xe6052000 0 0x50>;
+			#gpio-cells = <2>;
+			gpio-controller;
+			#interrupt-cells = <2>;
+			interrupt-controller;
+			/* placeholder */
+		};
+
+		gpio3: gpio@e6053000 {
+			compatible = "renesas,gpio-r8a7742",
+				     "renesas,rcar-gen2-gpio";
+			reg = <0 0xe6053000 0 0x50>;
+			#gpio-cells = <2>;
+			gpio-controller;
+			#interrupt-cells = <2>;
+			interrupt-controller;
+			/* placeholder */
+		};
+
+		gpio4: gpio@e6054000 {
+			compatible = "renesas,gpio-r8a7742",
+				     "renesas,rcar-gen2-gpio";
+			reg = <0 0xe6054000 0 0x50>;
+			#gpio-cells = <2>;
+			gpio-controller;
+			#interrupt-cells = <2>;
+			interrupt-controller;
+			/* placeholder */
+		};
+
+		gpio5: gpio@e6055000 {
+			compatible = "renesas,gpio-r8a7742",
+				     "renesas,rcar-gen2-gpio";
+			reg = <0 0xe6055000 0 0x50>;
+			#gpio-cells = <2>;
+			gpio-controller;
+			#interrupt-cells = <2>;
+			interrupt-controller;
+			/* placeholder */
+		};
+
+		pfc: pin-controller@e6060000 {
+			compatible = "renesas,pfc-r8a7742";
+			reg = <0 0xe6060000 0 0x250>;
+		};
+
+		cpg: clock-controller@e6150000 {
+			compatible = "renesas,r8a7742-cpg-mssr";
+			reg = <0 0xe6150000 0 0x1000>;
+			clocks = <&extal_clk>, <&usb_extal_clk>;
+			clock-names = "extal", "usb_extal";
+			#clock-cells = <2>;
+			#power-domain-cells = <0>;
+			#reset-cells = <1>;
+		};
+
+		rst: reset-controller@e6160000 {
+			compatible = "renesas,r8a7742-rst";
+			reg = <0 0xe6160000 0 0x100>;
+		};
+
+		sysc: system-controller@e6180000 {
+			compatible = "renesas,r8a7742-sysc";
+			reg = <0 0xe6180000 0 0x200>;
+			#power-domain-cells = <1>;
+		};
+
+		icram0:	sram@e63a0000 {
+			compatible = "mmio-sram";
+			reg = <0 0xe63a0000 0 0x12000>;
+			#address-cells = <1>;
+			#size-cells = <1>;
+			ranges = <0 0 0xe63a0000 0x12000>;
+		};
+
+		icram1:	sram@e63c0000 {
+			compatible = "mmio-sram";
+			reg = <0 0xe63c0000 0 0x1000>;
+			#address-cells = <1>;
+			#size-cells = <1>;
+			ranges = <0 0 0xe63c0000 0x1000>;
+
+			smp-sram@0 {
+				compatible = "renesas,smp-sram";
+				reg = <0 0x100>;
+			};
+		};
+
+		icram2:	sram@e6300000 {
+			compatible = "mmio-sram";
+			reg = <0 0xe6300000 0 0x40000>;
+			#address-cells = <1>;
+			#size-cells = <1>;
+			ranges = <0 0 0xe6300000 0x40000>;
+		};
+
+		i2c0: i2c@e6508000 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <0 0xe6508000 0 0x40>;
+			/* placeholder */
+		};
+
+		i2c1: i2c@e6518000 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <0 0xe6518000 0 0x40>;
+			/* placeholder */
+		};
+
+		i2c2: i2c@e6530000 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <0 0xe6530000 0 0x40>;
+			/* placeholder */
+		};
+
+		i2c3: i2c@e6540000 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <0 0xe6540000 0 0x40>;
+			/* placeholder */
+		};
+
+		iic0: i2c@e6500000 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <0 0xe6500000 0 0x425>;
+			/* placeholder */
+		};
+
+		iic1: i2c@e6510000 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <0 0xe6510000 0 0x425>;
+			/* placeholder */
+		};
+
+		iic2: i2c@e6520000 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <0 0xe6520000 0 0x425>;
+			/* placeholder */
+		};
+
+		iic3: i2c@e60b0000 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <0 0xe60b0000 0 0x425>;
+			/* placeholder */
+		};
+
+		hsusb: usb@e6590000 {
+			reg = <0 0xe6590000 0 0x100>;
+			/* placeholder */
+		};
+
+		usbphy: usb-phy@e6590100 {
+			reg = <0 0xe6590100 0 0x100>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			/* placeholder */
+		};
+
+		avb: ethernet@e6800000 {
+			reg = <0 0xe6800000 0 0x800>, <0 0xee0e8000 0 0x4000>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			/* placeholder */
+		};
+
+		scifa0: serial@e6c40000 {
+			reg = <0 0xe6c40000 0 0x40>;
+			/* placeholder */
+		};
+
+		scifa1: serial@e6c50000 {
+			reg = <0 0xe6c50000 0 0x40>;
+			/* placeholder */
+		};
+
+		scifa2: serial@e6c60000 {
+			reg = <0 0xe6c60000 0 0x40>;
+			/* placeholder */
+		};
+
+		scifb0: serial@e6c20000 {
+			reg = <0 0xe6c20000 0 0x100>;
+			/* placeholder */
+		};
+
+		scifb1: serial@e6c30000 {
+			reg = <0 0xe6c30000 0 0x100>;
+			/* placeholder */
+		};
+
+		scifb2: serial@e6ce0000 {
+			reg = <0 0xe6ce0000 0 0x100>;
+			/* placeholder */
+		};
+
+		scif0: serial@e6e60000 {
+			reg = <0 0xe6e60000 0 0x40>;
+			/* placeholder */
+		};
+
+		scif1: serial@e6e68000 {
+			reg = <0 0xe6e68000 0 0x40>;
+			/* placeholder */
+		};
+
+		hscif0: serial@e62c0000 {
+			reg = <0 0xe62c0000 0 0x60>;
+			/* placeholder */
+		};
+
+		hscif1: serial@e62c8000 {
+			reg = <0 0xe62c8000 0 0x60>;
+			/* placeholder */
+		};
+
+		can0: can@e6e80000 {
+			reg = <0 0xe6e80000 0 0x1000>;
+			/* placeholder */
+		};
+
+		can1: can@e6e88000 {
+			reg = <0 0xe6e88000 0 0x1000>;
+			/* placeholder */
+		};
+
+		rcar_sound: sound@ec500000 {
+			reg = <0 0xec500000 0 0x1000>, /* SCU */
+			      <0 0xec5a0000 0 0x100>,  /* ADG */
+			      <0 0xec540000 0 0x1000>, /* SSIU */
+			      <0 0xec541000 0 0x280>;  /* SSI */
+
+			rcar_sound,dvc {
+				dvc0: dvc-0 {};
+				dvc1: dvc-1 {};
+			};
+
+			rcar_sound,mix {
+				mix0: mix-0 { };
+				mix1: mix-1 { };
+			};
+
+			rcar_sound,ctu {
+				ctu00: ctu-0 { };
+				ctu01: ctu-1 { };
+				ctu02: ctu-2 { };
+				ctu03: ctu-3 { };
+				ctu10: ctu-4 { };
+				ctu11: ctu-5 { };
+				ctu12: ctu-6 { };
+				ctu13: ctu-7 { };
+			};
+
+			rcar_sound,src {
+				src0: src-0 {};
+				src1: src-1 {};
+				src2: src-2 {};
+				src3: src-3 {};
+				src4: src-4 {};
+				src5: src-5 {};
+				src6: src-6 {};
+				src7: src-7 {};
+				src8: src-8 {};
+				src9: src-9 {};
+			};
+
+			rcar_sound,ssi {
+				ssi0: ssi-0 {};
+				ssi1: ssi-1 {};
+				ssi2: ssi-2 {};
+				ssi3: ssi-3 {};
+				ssi4: ssi-4 {};
+				ssi5: ssi-5 {};
+				ssi6: ssi-6 {};
+				ssi7: ssi-7 {};
+				ssi8: ssi-8 {};
+				ssi9: ssi-9 {};
+			};
+			/* placeholder */
+		};
+
+		pci0: pci@ee090000 {
+			reg = <0 0xee090000 0 0xc00>,
+			      <0 0xee080000 0 0x1100>;
+			bus-range = <0 0>;
+			#address-cells = <3>;
+			#size-cells = <2>;
+			#interrupt-cells = <1>;
+			/* placeholder */
+		};
+
+		pci1: pci@ee0b0000 {
+			reg = <0 0xee0b0000 0 0xc00>,
+			      <0 0xee0a0000 0 0x1100>;
+			bus-range = <1 1>;
+			#address-cells = <3>;
+			#size-cells = <2>;
+			#interrupt-cells = <1>;
+			/* placeholder */
+		};
+
+		pci2: pci@ee0d0000 {
+			reg = <0 0xee0d0000 0 0xc00>,
+			      <0 0xee0c0000 0 0x1100>;
+			bus-range = <2 2>;
+			#address-cells = <3>;
+			#size-cells = <2>;
+			#interrupt-cells = <1>;
+			/* placeholder */
+		};
+
+		pciec: pcie@fe000000 {
+			reg = <0 0xfe000000 0 0x80000>;
+			#address-cells = <3>;
+			#size-cells = <2>;
+			bus-range = <0x00 0xff>;
+			#interrupt-cells = <1>;
+			/* placeholder */
+		};
+
+		sdhi0: sd@ee100000 {
+			reg = <0 0xee100000 0 0x328>;
+			/* placeholder */
+		};
+
+		sdhi1: sd@ee120000 {
+			reg = <0 0xee120000 0 0x328>;
+			/* placeholder */
+		};
+
+		sdhi2: sd@ee140000 {
+			reg = <0 0xee140000 0 0x100>;
+			/* placeholder */
+		};
+
+		sdhi3: sd@ee160000 {
+			reg = <0 0xee160000 0 0x100>;
+			/* placeholder */
+		};
+
+		gic: interrupt-controller@f1001000 {
+			compatible = "arm,gic-400";
+			#interrupt-cells = <3>;
+			#address-cells = <0>;
+			interrupt-controller;
+			reg = <0 0xf1001000 0 0x1000>, <0 0xf1002000 0 0x2000>,
+			      <0 0xf1004000 0 0x2000>, <0 0xf1006000 0 0x2000>;
+			interrupts = <GIC_PPI 9 (GIC_CPU_MASK_SIMPLE(8) | IRQ_TYPE_LEVEL_HIGH)>;
+			clocks = <&cpg CPG_MOD 408>;
+			clock-names = "clk";
+			power-domains = <&sysc R8A7742_PD_ALWAYS_ON>;
+			resets = <&cpg 408>;
+		};
+
+		du: display@feb00000 {
+			reg = <0 0xfeb00000 0 0x70000>;
+
+			ports {
+				#address-cells = <1>;
+				#size-cells = <0>;
+
+				port@0 {
+					reg = <0>;
+					du_out_rgb: endpoint {
+					};
+				};
+				port@1 {
+					reg = <1>;
+					du_out_lvds0: endpoint {
+					};
+				};
+				port@2 {
+					reg = <2>;
+					du_out_lvds1: endpoint {
+					};
+				};
+				/* placeholder */
+			};
+		};
+
+		lvds0: lvds@feb90000 {
+			reg = <0 0xfeb90000 0 0x1c>;
+
+			ports {
+				#address-cells = <1>;
+				#size-cells = <0>;
+
+				port@0 {
+					reg = <0>;
+					lvds0_in: endpoint {
+					};
+				};
+				port@1 {
+					reg = <1>;
+					lvds0_out: endpoint {
+					};
+				};
+			};
+			/* placeholder */
+		};
+
+		lvds1: lvds@feb94000 {
+			reg = <0 0xfeb94000 0 0x1c>;
+
+			ports {
+				#address-cells = <1>;
+				#size-cells = <0>;
+
+				port@0 {
+					reg = <0>;
+					lvds1_in: endpoint {
+					};
+				};
+				port@1 {
+					reg = <1>;
+					lvds1_out: endpoint {
+					};
+				};
+			};
+			/* placeholder */
+		};
+
+		prr: chipid@ff000044 {
+			compatible = "renesas,prr";
+			reg = <0 0xff000044 0 4>;
+		};
+
+	};
+
+	timer {
+		compatible = "arm,armv7-timer";
+		interrupts-extended = <&gic GIC_PPI 13 (GIC_CPU_MASK_SIMPLE(8) | IRQ_TYPE_LEVEL_LOW)>,
+				      <&gic GIC_PPI 14 (GIC_CPU_MASK_SIMPLE(8) | IRQ_TYPE_LEVEL_LOW)>,
+				      <&gic GIC_PPI 11 (GIC_CPU_MASK_SIMPLE(8) | IRQ_TYPE_LEVEL_LOW)>,
+				      <&gic GIC_PPI 10 (GIC_CPU_MASK_SIMPLE(8) | IRQ_TYPE_LEVEL_LOW)>;
+	};
+
+};
-- 
2.7.4

