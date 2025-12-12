Return-Path: <dmaengine+bounces-7604-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D7327CBA099
	for <lists+dmaengine@lfdr.de>; Sat, 13 Dec 2025 00:12:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BD2B230A8B3B
	for <lists+dmaengine@lfdr.de>; Fri, 12 Dec 2025 23:12:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88A2830DED5;
	Fri, 12 Dec 2025 23:12:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nx9JydFp"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34C712459FD;
	Fri, 12 Dec 2025 23:12:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765581139; cv=none; b=CX2MEM21rmSFXuKJQeiUnvw91esmsWt2tCWDCjbnzP9hPbMCXQ3W/LPsn8eukP2tL/ycFLoD1p3ripTP0RQULPahJpyF3z3Otlr6zOo7/7a3+wEJLNRrpJZN58QCO0/uRlw63/FDisEuIyrsMndSFEhKqoXp2Uhe/4Di3CtRiJ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765581139; c=relaxed/simple;
	bh=xfjEX7gQ/YJEsMsi6W1W6mk0tcH+0gxpXaepGDcP9qk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ttHFPcOk9wBfTQ7XYnlU7CXo/+VPEmXe8QQDFnS6Ga7SA4OwyMEVQrryrcYO73D1w0/ukSXX0De7YXg/wMLkpsM5q90R9vmgcU5bB58uJ9K0O77ZkGdsLmXHWGNAqlmHAl1mzDX0Bah4lBaxMYxYqJe2mDw/yK7AtktraXolP1s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nx9JydFp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 358C2C4CEF1;
	Fri, 12 Dec 2025 23:12:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765581138;
	bh=xfjEX7gQ/YJEsMsi6W1W6mk0tcH+0gxpXaepGDcP9qk=;
	h=From:To:Cc:Subject:Date:From;
	b=nx9JydFpWG6ip01afHW9tu0Qmkz7Sl3SVeV/HOiKP4Ly7abSE8b4JEh4Mi30+zsu4
	 +qt+Spd3YFMmkhNvlKqz2A7xTWXU0kif1/h3m9lQSBjzS6koLRjdJ0lzF08o1z10v/
	 Y94mAH1pROcnrCgJZV8OPO84ZXh4+9Zm48msW0jfzpfiQB71IN6wb4O6MDrcbqQddt
	 e6Z1RYWxplrfklyJLlvSEzyUn4HZFoKyWQe15G2Gh2gpHPaK7PRNWsz3S+L8SLuh9a
	 TfrKyzeBpSwB08CUmslEssI3iHh0R0lwebIf87V8DMh1/5f6QWr3lFKZFw9X89O87n
	 X0Uc5pfZC3QcA==
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Michal Simek <michal.simek@amd.com>,
	Vinod Koul <vkoul@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Yong Wu <yong.wu@mediatek.com>,
	Peter Rosin <peda@axentia.se>,
	Linus Walleij <linusw@kernel.org>,
	Chen-Yu Tsai <wens@kernel.org>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Samuel Holland <samuel@sholland.org>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>
Cc: linux-kernel@vger.kernel.org,
	linux-clk@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-arm-msm@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	dmaengine@vger.kernel.org,
	linux-mediatek@lists.infradead.org,
	linux-iio@vger.kernel.org,
	iommu@lists.linux.dev,
	linux-gpio@vger.kernel.org,
	linux-sunxi@lists.linux.dev,
	imx@lists.linux.dev,
	linux-sound@vger.kernel.org
Subject: [PATCH] dt-bindings: Remove unused includes
Date: Fri, 12 Dec 2025 17:11:52 -0600
Message-ID: <20251212231203.727227-1-robh@kernel.org>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Remove includes which are not referenced by either DTS files or drivers.

There's a few more which are new, so they are excluded for now.

Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
---
 include/dt-bindings/clock/oxsemi,ox810se.h    |  19 --
 include/dt-bindings/clock/oxsemi,ox820.h      |  29 --
 include/dt-bindings/clock/qcom,mss-sc7180.h   |  12 -
 include/dt-bindings/clock/xlnx-versal-clk.h   | 123 ---------
 include/dt-bindings/clock/xlnx-zynqmp-clk.h   | 133 ---------
 include/dt-bindings/dma/jz4775-dma.h          |  44 ---
 include/dt-bindings/dma/x2000-dma.h           |  54 ----
 include/dt-bindings/gce/mt6779-gce.h          | 222 ---------------
 .../dt-bindings/iio/qcom,spmi-adc7-pmr735b.h  |  30 --
 .../dt-bindings/iio/qcom,spmi-adc7-smb139x.h  |  19 --
 include/dt-bindings/memory/mt6779-larb-port.h | 206 --------------
 include/dt-bindings/mux/ti-serdes.h           | 190 -------------
 include/dt-bindings/pinctrl/mt6397-pinfunc.h  | 257 ------------------
 .../power/allwinner,sun20i-d1-ppu.h           |  10 -
 include/dt-bindings/reset/bcm6318-reset.h     |  20 --
 include/dt-bindings/reset/imx8ulp-pcc-reset.h |  59 ----
 include/dt-bindings/reset/oxsemi,ox810se.h    |  42 ---
 include/dt-bindings/reset/oxsemi,ox820.h      |  42 ---
 include/dt-bindings/sound/audio-jack-events.h |  10 -
 19 files changed, 1521 deletions(-)
 delete mode 100644 include/dt-bindings/clock/oxsemi,ox810se.h
 delete mode 100644 include/dt-bindings/clock/oxsemi,ox820.h
 delete mode 100644 include/dt-bindings/clock/qcom,mss-sc7180.h
 delete mode 100644 include/dt-bindings/clock/xlnx-versal-clk.h
 delete mode 100644 include/dt-bindings/clock/xlnx-zynqmp-clk.h
 delete mode 100644 include/dt-bindings/dma/jz4775-dma.h
 delete mode 100644 include/dt-bindings/dma/x2000-dma.h
 delete mode 100644 include/dt-bindings/gce/mt6779-gce.h
 delete mode 100644 include/dt-bindings/iio/qcom,spmi-adc7-pmr735b.h
 delete mode 100644 include/dt-bindings/iio/qcom,spmi-adc7-smb139x.h
 delete mode 100644 include/dt-bindings/memory/mt6779-larb-port.h
 delete mode 100644 include/dt-bindings/mux/ti-serdes.h
 delete mode 100644 include/dt-bindings/pinctrl/mt6397-pinfunc.h
 delete mode 100644 include/dt-bindings/power/allwinner,sun20i-d1-ppu.h
 delete mode 100644 include/dt-bindings/reset/bcm6318-reset.h
 delete mode 100644 include/dt-bindings/reset/imx8ulp-pcc-reset.h
 delete mode 100644 include/dt-bindings/reset/oxsemi,ox810se.h
 delete mode 100644 include/dt-bindings/reset/oxsemi,ox820.h
 delete mode 100644 include/dt-bindings/sound/audio-jack-events.h

diff --git a/include/dt-bindings/clock/oxsemi,ox810se.h b/include/dt-bindings/clock/oxsemi,ox810se.h
deleted file mode 100644
index 7256365160f8..000000000000
--- a/include/dt-bindings/clock/oxsemi,ox810se.h
+++ /dev/null
@@ -1,19 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0-only */
-/*
- * Copyright (C) 2016 Neil Armstrong <narmstrong@baylibre.com>
- */
-
-#ifndef DT_CLOCK_OXSEMI_OX810SE_H
-#define DT_CLOCK_OXSEMI_OX810SE_H
-
-#define CLK_810_LEON		0
-#define CLK_810_DMA_SGDMA	1
-#define CLK_810_CIPHER		2
-#define CLK_810_SATA		3
-#define CLK_810_AUDIO		4
-#define CLK_810_USBMPH		5
-#define CLK_810_ETHA		6
-#define CLK_810_PCIEA		7
-#define CLK_810_NAND		8
-
-#endif /* DT_CLOCK_OXSEMI_OX810SE_H */
diff --git a/include/dt-bindings/clock/oxsemi,ox820.h b/include/dt-bindings/clock/oxsemi,ox820.h
deleted file mode 100644
index 55f4226e2f3f..000000000000
--- a/include/dt-bindings/clock/oxsemi,ox820.h
+++ /dev/null
@@ -1,29 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0-only */
-/*
- * Copyright (C) 2016 Neil Armstrong <narmstrong@baylibre.com>
- */
-
-#ifndef DT_CLOCK_OXSEMI_OX820_H
-#define DT_CLOCK_OXSEMI_OX820_H
-
-/* PLLs */
-#define CLK_820_PLLA		0
-#define CLK_820_PLLB		1
-
-/* Gate Clocks */
-#define CLK_820_LEON		2
-#define CLK_820_DMA_SGDMA	3
-#define CLK_820_CIPHER		4
-#define CLK_820_SD		5
-#define CLK_820_SATA		6
-#define CLK_820_AUDIO		7
-#define CLK_820_USBMPH		8
-#define CLK_820_ETHA		9
-#define CLK_820_PCIEA		10
-#define CLK_820_NAND		11
-#define CLK_820_PCIEB		12
-#define CLK_820_ETHB		13
-#define CLK_820_REF600		14
-#define CLK_820_USBDEV		15
-
-#endif /* DT_CLOCK_OXSEMI_OX820_H */
diff --git a/include/dt-bindings/clock/qcom,mss-sc7180.h b/include/dt-bindings/clock/qcom,mss-sc7180.h
deleted file mode 100644
index f15a9ded2961..000000000000
--- a/include/dt-bindings/clock/qcom,mss-sc7180.h
+++ /dev/null
@@ -1,12 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0-only */
-/*
- * Copyright (c) 2020, The Linux Foundation. All rights reserved.
- */
-
-#ifndef _DT_BINDINGS_CLK_QCOM_MSS_SC7180_H
-#define _DT_BINDINGS_CLK_QCOM_MSS_SC7180_H
-
-#define MSS_AXI_CRYPTO_CLK	0
-#define MSS_AXI_NAV_CLK		1
-
-#endif
diff --git a/include/dt-bindings/clock/xlnx-versal-clk.h b/include/dt-bindings/clock/xlnx-versal-clk.h
deleted file mode 100644
index 264d634d226e..000000000000
--- a/include/dt-bindings/clock/xlnx-versal-clk.h
+++ /dev/null
@@ -1,123 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-/*
- *  Copyright (C) 2019 Xilinx Inc.
- *
- */
-
-#ifndef _DT_BINDINGS_CLK_VERSAL_H
-#define _DT_BINDINGS_CLK_VERSAL_H
-
-#define PMC_PLL					1
-#define APU_PLL					2
-#define RPU_PLL					3
-#define CPM_PLL					4
-#define NOC_PLL					5
-#define PLL_MAX					6
-#define PMC_PRESRC				7
-#define PMC_POSTCLK				8
-#define PMC_PLL_OUT				9
-#define PPLL					10
-#define NOC_PRESRC				11
-#define NOC_POSTCLK				12
-#define NOC_PLL_OUT				13
-#define NPLL					14
-#define APU_PRESRC				15
-#define APU_POSTCLK				16
-#define APU_PLL_OUT				17
-#define APLL					18
-#define RPU_PRESRC				19
-#define RPU_POSTCLK				20
-#define RPU_PLL_OUT				21
-#define RPLL					22
-#define CPM_PRESRC				23
-#define CPM_POSTCLK				24
-#define CPM_PLL_OUT				25
-#define CPLL					26
-#define PPLL_TO_XPD				27
-#define NPLL_TO_XPD				28
-#define APLL_TO_XPD				29
-#define RPLL_TO_XPD				30
-#define EFUSE_REF				31
-#define SYSMON_REF				32
-#define IRO_SUSPEND_REF				33
-#define USB_SUSPEND				34
-#define SWITCH_TIMEOUT				35
-#define RCLK_PMC				36
-#define RCLK_LPD				37
-#define WDT					38
-#define TTC0					39
-#define TTC1					40
-#define TTC2					41
-#define TTC3					42
-#define GEM_TSU					43
-#define GEM_TSU_LB				44
-#define MUXED_IRO_DIV2				45
-#define MUXED_IRO_DIV4				46
-#define PSM_REF					47
-#define GEM0_RX					48
-#define GEM0_TX					49
-#define GEM1_RX					50
-#define GEM1_TX					51
-#define CPM_CORE_REF				52
-#define CPM_LSBUS_REF				53
-#define CPM_DBG_REF				54
-#define CPM_AUX0_REF				55
-#define CPM_AUX1_REF				56
-#define QSPI_REF				57
-#define OSPI_REF				58
-#define SDIO0_REF				59
-#define SDIO1_REF				60
-#define PMC_LSBUS_REF				61
-#define I2C_REF					62
-#define TEST_PATTERN_REF			63
-#define DFT_OSC_REF				64
-#define PMC_PL0_REF				65
-#define PMC_PL1_REF				66
-#define PMC_PL2_REF				67
-#define PMC_PL3_REF				68
-#define CFU_REF					69
-#define SPARE_REF				70
-#define NPI_REF					71
-#define HSM0_REF				72
-#define HSM1_REF				73
-#define SD_DLL_REF				74
-#define FPD_TOP_SWITCH				75
-#define FPD_LSBUS				76
-#define ACPU					77
-#define DBG_TRACE				78
-#define DBG_FPD					79
-#define LPD_TOP_SWITCH				80
-#define ADMA					81
-#define LPD_LSBUS				82
-#define CPU_R5					83
-#define CPU_R5_CORE				84
-#define CPU_R5_OCM				85
-#define CPU_R5_OCM2				86
-#define IOU_SWITCH				87
-#define GEM0_REF				88
-#define GEM1_REF				89
-#define GEM_TSU_REF				90
-#define USB0_BUS_REF				91
-#define UART0_REF				92
-#define UART1_REF				93
-#define SPI0_REF				94
-#define SPI1_REF				95
-#define CAN0_REF				96
-#define CAN1_REF				97
-#define I2C0_REF				98
-#define I2C1_REF				99
-#define DBG_LPD					100
-#define TIMESTAMP_REF				101
-#define DBG_TSTMP				102
-#define CPM_TOPSW_REF				103
-#define USB3_DUAL_REF				104
-#define OUTCLK_MAX				105
-#define REF_CLK					106
-#define PL_ALT_REF_CLK				107
-#define MUXED_IRO				108
-#define PL_EXT					109
-#define PL_LB					110
-#define MIO_50_OR_51				111
-#define MIO_24_OR_25				112
-
-#endif
diff --git a/include/dt-bindings/clock/xlnx-zynqmp-clk.h b/include/dt-bindings/clock/xlnx-zynqmp-clk.h
deleted file mode 100644
index f0f7ddd3dcbd..000000000000
--- a/include/dt-bindings/clock/xlnx-zynqmp-clk.h
+++ /dev/null
@@ -1,133 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-/*
- * Xilinx Zynq MPSoC Firmware layer
- *
- *  Copyright (C) 2014-2018 Xilinx, Inc.
- *
- */
-
-#ifndef _DT_BINDINGS_CLK_ZYNQMP_H
-#define _DT_BINDINGS_CLK_ZYNQMP_H
-
-/*
- * These bindings are deprecated, because they do not match the actual
- * concept of bindings but rather contain pure firmware values.
- * Instead include the header in the DTS source directory.
- */
-#warning "These bindings are deprecated. Instead use the header in the DTS source directory."
-
-#define IOPLL			0
-#define RPLL			1
-#define APLL			2
-#define DPLL			3
-#define VPLL			4
-#define IOPLL_TO_FPD		5
-#define RPLL_TO_FPD		6
-#define APLL_TO_LPD		7
-#define DPLL_TO_LPD		8
-#define VPLL_TO_LPD		9
-#define ACPU			10
-#define ACPU_HALF		11
-#define DBF_FPD			12
-#define DBF_LPD			13
-#define DBG_TRACE		14
-#define DBG_TSTMP		15
-#define DP_VIDEO_REF		16
-#define DP_AUDIO_REF		17
-#define DP_STC_REF		18
-#define GDMA_REF		19
-#define DPDMA_REF		20
-#define DDR_REF			21
-#define SATA_REF		22
-#define PCIE_REF		23
-#define GPU_REF			24
-#define GPU_PP0_REF		25
-#define GPU_PP1_REF		26
-#define TOPSW_MAIN		27
-#define TOPSW_LSBUS		28
-#define GTGREF0_REF		29
-#define LPD_SWITCH		30
-#define LPD_LSBUS		31
-#define USB0_BUS_REF		32
-#define USB1_BUS_REF		33
-#define USB3_DUAL_REF		34
-#define USB0			35
-#define USB1			36
-#define CPU_R5			37
-#define CPU_R5_CORE		38
-#define CSU_SPB			39
-#define CSU_PLL			40
-#define PCAP			41
-#define IOU_SWITCH		42
-#define GEM_TSU_REF		43
-#define GEM_TSU			44
-#define GEM0_TX			45
-#define GEM1_TX			46
-#define GEM2_TX			47
-#define GEM3_TX			48
-#define GEM0_RX			49
-#define GEM1_RX			50
-#define GEM2_RX			51
-#define GEM3_RX			52
-#define QSPI_REF		53
-#define SDIO0_REF		54
-#define SDIO1_REF		55
-#define UART0_REF		56
-#define UART1_REF		57
-#define SPI0_REF		58
-#define SPI1_REF		59
-#define NAND_REF		60
-#define I2C0_REF		61
-#define I2C1_REF		62
-#define CAN0_REF		63
-#define CAN1_REF		64
-#define CAN0			65
-#define CAN1			66
-#define DLL_REF			67
-#define ADMA_REF		68
-#define TIMESTAMP_REF		69
-#define AMS_REF			70
-#define PL0_REF			71
-#define PL1_REF			72
-#define PL2_REF			73
-#define PL3_REF			74
-#define WDT			75
-#define IOPLL_INT		76
-#define IOPLL_PRE_SRC		77
-#define IOPLL_HALF		78
-#define IOPLL_INT_MUX		79
-#define IOPLL_POST_SRC		80
-#define RPLL_INT		81
-#define RPLL_PRE_SRC		82
-#define RPLL_HALF		83
-#define RPLL_INT_MUX		84
-#define RPLL_POST_SRC		85
-#define APLL_INT		86
-#define APLL_PRE_SRC		87
-#define APLL_HALF		88
-#define APLL_INT_MUX		89
-#define APLL_POST_SRC		90
-#define DPLL_INT		91
-#define DPLL_PRE_SRC		92
-#define DPLL_HALF		93
-#define DPLL_INT_MUX		94
-#define DPLL_POST_SRC		95
-#define VPLL_INT		96
-#define VPLL_PRE_SRC		97
-#define VPLL_HALF		98
-#define VPLL_INT_MUX		99
-#define VPLL_POST_SRC		100
-#define CAN0_MIO		101
-#define CAN1_MIO		102
-#define ACPU_FULL		103
-#define GEM0_REF		104
-#define GEM1_REF		105
-#define GEM2_REF		106
-#define GEM3_REF		107
-#define GEM0_REF_UNG		108
-#define GEM1_REF_UNG		109
-#define GEM2_REF_UNG		110
-#define GEM3_REF_UNG		111
-#define LPD_WDT			112
-
-#endif
diff --git a/include/dt-bindings/dma/jz4775-dma.h b/include/dt-bindings/dma/jz4775-dma.h
deleted file mode 100644
index 8d27e2c69dca..000000000000
--- a/include/dt-bindings/dma/jz4775-dma.h
+++ /dev/null
@@ -1,44 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0-only */
-/*
- * This header provides macros for JZ4775 DMA bindings.
- *
- * Copyright (c) 2020 周琰杰 (Zhou Yanjie) <zhouyanjie@wanyeetech.com>
- */
-
-#ifndef __DT_BINDINGS_DMA_JZ4775_DMA_H__
-#define __DT_BINDINGS_DMA_JZ4775_DMA_H__
-
-/*
- * Request type numbers for the JZ4775 DMA controller (written to the DRTn
- * register for the channel).
- */
-#define JZ4775_DMA_I2S0_TX	0x6
-#define JZ4775_DMA_I2S0_RX	0x7
-#define JZ4775_DMA_AUTO		0x8
-#define JZ4775_DMA_SADC_RX	0x9
-#define JZ4775_DMA_UART3_TX	0x0e
-#define JZ4775_DMA_UART3_RX	0x0f
-#define JZ4775_DMA_UART2_TX	0x10
-#define JZ4775_DMA_UART2_RX	0x11
-#define JZ4775_DMA_UART1_TX	0x12
-#define JZ4775_DMA_UART1_RX	0x13
-#define JZ4775_DMA_UART0_TX	0x14
-#define JZ4775_DMA_UART0_RX	0x15
-#define JZ4775_DMA_SSI0_TX	0x16
-#define JZ4775_DMA_SSI0_RX	0x17
-#define JZ4775_DMA_MSC0_TX	0x1a
-#define JZ4775_DMA_MSC0_RX	0x1b
-#define JZ4775_DMA_MSC1_TX	0x1c
-#define JZ4775_DMA_MSC1_RX	0x1d
-#define JZ4775_DMA_MSC2_TX	0x1e
-#define JZ4775_DMA_MSC2_RX	0x1f
-#define JZ4775_DMA_PCM0_TX	0x20
-#define JZ4775_DMA_PCM0_RX	0x21
-#define JZ4775_DMA_SMB0_TX	0x24
-#define JZ4775_DMA_SMB0_RX	0x25
-#define JZ4775_DMA_SMB1_TX	0x26
-#define JZ4775_DMA_SMB1_RX	0x27
-#define JZ4775_DMA_SMB2_TX	0x28
-#define JZ4775_DMA_SMB2_RX	0x29
-
-#endif /* __DT_BINDINGS_DMA_JZ4775_DMA_H__ */
diff --git a/include/dt-bindings/dma/x2000-dma.h b/include/dt-bindings/dma/x2000-dma.h
deleted file mode 100644
index db2cd4830b00..000000000000
--- a/include/dt-bindings/dma/x2000-dma.h
+++ /dev/null
@@ -1,54 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0-only */
-/*
- * This header provides macros for X2000 DMA bindings.
- *
- * Copyright (c) 2020 周琰杰 (Zhou Yanjie) <zhouyanjie@wanyeetech.com>
- */
-
-#ifndef __DT_BINDINGS_DMA_X2000_DMA_H__
-#define __DT_BINDINGS_DMA_X2000_DMA_H__
-
-/*
- * Request type numbers for the X2000 DMA controller (written to the DRTn
- * register for the channel).
- */
-#define X2000_DMA_AUTO		0x8
-#define X2000_DMA_UART5_TX	0xa
-#define X2000_DMA_UART5_RX	0xb
-#define X2000_DMA_UART4_TX	0xc
-#define X2000_DMA_UART4_RX	0xd
-#define X2000_DMA_UART3_TX	0xe
-#define X2000_DMA_UART3_RX	0xf
-#define X2000_DMA_UART2_TX	0x10
-#define X2000_DMA_UART2_RX	0x11
-#define X2000_DMA_UART1_TX	0x12
-#define X2000_DMA_UART1_RX	0x13
-#define X2000_DMA_UART0_TX	0x14
-#define X2000_DMA_UART0_RX	0x15
-#define X2000_DMA_SSI0_TX	0x16
-#define X2000_DMA_SSI0_RX	0x17
-#define X2000_DMA_SSI1_TX	0x18
-#define X2000_DMA_SSI1_RX	0x19
-#define X2000_DMA_I2C0_TX	0x24
-#define X2000_DMA_I2C0_RX	0x25
-#define X2000_DMA_I2C1_TX	0x26
-#define X2000_DMA_I2C1_RX	0x27
-#define X2000_DMA_I2C2_TX	0x28
-#define X2000_DMA_I2C2_RX	0x29
-#define X2000_DMA_I2C3_TX	0x2a
-#define X2000_DMA_I2C3_RX	0x2b
-#define X2000_DMA_I2C4_TX	0x2c
-#define X2000_DMA_I2C4_RX	0x2d
-#define X2000_DMA_I2C5_TX	0x2e
-#define X2000_DMA_I2C5_RX	0x2f
-#define X2000_DMA_UART6_TX	0x30
-#define X2000_DMA_UART6_RX	0x31
-#define X2000_DMA_UART7_TX	0x32
-#define X2000_DMA_UART7_RX	0x33
-#define X2000_DMA_UART8_TX	0x34
-#define X2000_DMA_UART8_RX	0x35
-#define X2000_DMA_UART9_TX	0x36
-#define X2000_DMA_UART9_RX	0x37
-#define X2000_DMA_SADC_RX	0x38
-
-#endif /* __DT_BINDINGS_DMA_X2000_DMA_H__ */
diff --git a/include/dt-bindings/gce/mt6779-gce.h b/include/dt-bindings/gce/mt6779-gce.h
deleted file mode 100644
index 06101316ace4..000000000000
--- a/include/dt-bindings/gce/mt6779-gce.h
+++ /dev/null
@@ -1,222 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-/*
- * Copyright (c) 2019 MediaTek Inc.
- * Author: Dennis-YC Hsieh <dennis-yc.hsieh@mediatek.com>
- */
-
-#ifndef _DT_BINDINGS_GCE_MT6779_H
-#define _DT_BINDINGS_GCE_MT6779_H
-
-#define CMDQ_NO_TIMEOUT		0xffffffff
-
-/* GCE HW thread priority */
-#define CMDQ_THR_PRIO_LOWEST	0
-#define CMDQ_THR_PRIO_1		1
-#define CMDQ_THR_PRIO_2		2
-#define CMDQ_THR_PRIO_3		3
-#define CMDQ_THR_PRIO_4		4
-#define CMDQ_THR_PRIO_5		5
-#define CMDQ_THR_PRIO_6		6
-#define CMDQ_THR_PRIO_HIGHEST	7
-
-/* GCE subsys table */
-#define SUBSYS_1300XXXX		0
-#define SUBSYS_1400XXXX		1
-#define SUBSYS_1401XXXX		2
-#define SUBSYS_1402XXXX		3
-#define SUBSYS_1502XXXX		4
-#define SUBSYS_1880XXXX		5
-#define SUBSYS_1881XXXX		6
-#define SUBSYS_1882XXXX		7
-#define SUBSYS_1883XXXX		8
-#define SUBSYS_1884XXXX		9
-#define SUBSYS_1000XXXX		10
-#define SUBSYS_1001XXXX		11
-#define SUBSYS_1002XXXX		12
-#define SUBSYS_1003XXXX		13
-#define SUBSYS_1004XXXX		14
-#define SUBSYS_1005XXXX		15
-#define SUBSYS_1020XXXX		16
-#define SUBSYS_1028XXXX		17
-#define SUBSYS_1700XXXX		18
-#define SUBSYS_1701XXXX		19
-#define SUBSYS_1702XXXX		20
-#define SUBSYS_1703XXXX		21
-#define SUBSYS_1800XXXX		22
-#define SUBSYS_1801XXXX		23
-#define SUBSYS_1802XXXX		24
-#define SUBSYS_1804XXXX		25
-#define SUBSYS_1805XXXX		26
-#define SUBSYS_1808XXXX		27
-#define SUBSYS_180aXXXX		28
-#define SUBSYS_180bXXXX		29
-#define CMDQ_SUBSYS_OFF		32
-
-/* GCE hardware events */
-#define CMDQ_EVENT_DISP_RDMA0_SOF		0
-#define CMDQ_EVENT_DISP_RDMA1_SOF		1
-#define CMDQ_EVENT_MDP_RDMA0_SOF		2
-#define CMDQ_EVENT_MDP_RDMA1_SOF		3
-#define CMDQ_EVENT_MDP_RSZ0_SOF			4
-#define CMDQ_EVENT_MDP_RSZ1_SOF			5
-#define CMDQ_EVENT_MDP_TDSHP_SOF		6
-#define CMDQ_EVENT_MDP_WROT0_SOF		7
-#define CMDQ_EVENT_MDP_WROT1_SOF		8
-#define CMDQ_EVENT_DISP_OVL0_SOF		9
-#define CMDQ_EVENT_DISP_2L_OVL0_SOF		10
-#define CMDQ_EVENT_DISP_2L_OVL1_SOF		11
-#define CMDQ_EVENT_DISP_WDMA0_SOF		12
-#define CMDQ_EVENT_DISP_COLOR0_SOF		13
-#define CMDQ_EVENT_DISP_CCORR0_SOF		14
-#define CMDQ_EVENT_DISP_AAL0_SOF		15
-#define CMDQ_EVENT_DISP_GAMMA0_SOF		16
-#define CMDQ_EVENT_DISP_DITHER0_SOF		17
-#define CMDQ_EVENT_DISP_PWM0_SOF		18
-#define CMDQ_EVENT_DISP_DSI0_SOF		19
-#define CMDQ_EVENT_DISP_DPI0_SOF		20
-#define CMDQ_EVENT_DISP_POSTMASK0_SOF		21
-#define CMDQ_EVENT_DISP_RSZ0_SOF		22
-#define CMDQ_EVENT_MDP_AAL_SOF			23
-#define CMDQ_EVENT_MDP_CCORR_SOF		24
-#define CMDQ_EVENT_DISP_DBI0_SOF		25
-#define CMDQ_EVENT_ISP_RELAY_SOF		26
-#define CMDQ_EVENT_IPU_RELAY_SOF		27
-#define CMDQ_EVENT_DISP_RDMA0_EOF		28
-#define CMDQ_EVENT_DISP_RDMA1_EOF		29
-#define CMDQ_EVENT_MDP_RDMA0_EOF		30
-#define CMDQ_EVENT_MDP_RDMA1_EOF		31
-#define CMDQ_EVENT_MDP_RSZ0_EOF			32
-#define CMDQ_EVENT_MDP_RSZ1_EOF			33
-#define CMDQ_EVENT_MDP_TDSHP_EOF		34
-#define CMDQ_EVENT_MDP_WROT0_W_EOF		35
-#define CMDQ_EVENT_MDP_WROT1_W_EOF		36
-#define CMDQ_EVENT_DISP_OVL0_EOF		37
-#define CMDQ_EVENT_DISP_2L_OVL0_EOF		38
-#define CMDQ_EVENT_DISP_2L_OVL1_EOF		39
-#define CMDQ_EVENT_DISP_WDMA0_EOF		40
-#define CMDQ_EVENT_DISP_COLOR0_EOF		41
-#define CMDQ_EVENT_DISP_CCORR0_EOF		42
-#define CMDQ_EVENT_DISP_AAL0_EOF		43
-#define CMDQ_EVENT_DISP_GAMMA0_EOF		44
-#define CMDQ_EVENT_DISP_DITHER0_EOF		45
-#define CMDQ_EVENT_DISP_DSI0_EOF		46
-#define CMDQ_EVENT_DISP_DPI0_EOF		47
-#define CMDQ_EVENT_DISP_RSZ0_EOF		49
-#define CMDQ_EVENT_MDP_AAL_FRAME_DONE		50
-#define CMDQ_EVENT_MDP_CCORR_FRAME_DONE		51
-#define CMDQ_EVENT_DISP_POSTMASK0_FRAME_DONE	52
-#define CMDQ_EVENT_MUTEX0_STREAM_EOF		130
-#define CMDQ_EVENT_MUTEX1_STREAM_EOF		131
-#define CMDQ_EVENT_MUTEX2_STREAM_EOF		132
-#define CMDQ_EVENT_MUTEX3_STREAM_EOF		133
-#define CMDQ_EVENT_MUTEX4_STREAM_EOF		134
-#define CMDQ_EVENT_MUTEX5_STREAM_EOF		135
-#define CMDQ_EVENT_MUTEX6_STREAM_EOF		136
-#define CMDQ_EVENT_MUTEX7_STREAM_EOF		137
-#define CMDQ_EVENT_MUTEX8_STREAM_EOF		138
-#define CMDQ_EVENT_MUTEX9_STREAM_EOF		139
-#define CMDQ_EVENT_MUTEX10_STREAM_EOF		140
-#define CMDQ_EVENT_MUTEX11_STREAM_EOF		141
-#define CMDQ_EVENT_DISP_RDMA0_UNDERRUN		142
-#define CMDQ_EVENT_DISP_RDMA1_UNDERRUN		143
-#define CMDQ_EVENT_DISP_RDMA2_UNDERRUN		144
-#define CMDQ_EVENT_DISP_RDMA3_UNDERRUN		145
-#define CMDQ_EVENT_DSI0_TE			146
-#define CMDQ_EVENT_DSI0_IRQ_EVENT		147
-#define CMDQ_EVENT_DSI0_DONE_EVENT		148
-#define CMDQ_EVENT_DISP_POSTMASK0_RST_DONE	150
-#define CMDQ_EVENT_DISP_WDMA0_RST_DONE		151
-#define CMDQ_EVENT_MDP_WROT0_RST_DONE		153
-#define CMDQ_EVENT_MDP_RDMA0_RST_DONE		154
-#define CMDQ_EVENT_DISP_OVL0_RST_DONE		155
-#define CMDQ_EVENT_DISP_OVL0_2L_RST_DONE	156
-#define CMDQ_EVENT_DISP_OVL1_2L_RST_DONE	157
-#define CMDQ_EVENT_DIP_CQ_THREAD0_EOF		257
-#define CMDQ_EVENT_DIP_CQ_THREAD1_EOF		258
-#define CMDQ_EVENT_DIP_CQ_THREAD2_EOF		259
-#define CMDQ_EVENT_DIP_CQ_THREAD3_EOF		260
-#define CMDQ_EVENT_DIP_CQ_THREAD4_EOF		261
-#define CMDQ_EVENT_DIP_CQ_THREAD5_EOF		262
-#define CMDQ_EVENT_DIP_CQ_THREAD6_EOF		263
-#define CMDQ_EVENT_DIP_CQ_THREAD7_EOF		264
-#define CMDQ_EVENT_DIP_CQ_THREAD8_EOF		265
-#define CMDQ_EVENT_DIP_CQ_THREAD9_EOF		266
-#define CMDQ_EVENT_DIP_CQ_THREAD10_EOF		267
-#define CMDQ_EVENT_DIP_CQ_THREAD11_EOF		268
-#define CMDQ_EVENT_DIP_CQ_THREAD12_EOF		269
-#define CMDQ_EVENT_DIP_CQ_THREAD13_EOF		270
-#define CMDQ_EVENT_DIP_CQ_THREAD14_EOF		271
-#define CMDQ_EVENT_DIP_CQ_THREAD15_EOF		272
-#define CMDQ_EVENT_DIP_CQ_THREAD16_EOF		273
-#define CMDQ_EVENT_DIP_CQ_THREAD17_EOF		274
-#define CMDQ_EVENT_DIP_CQ_THREAD18_EOF		275
-#define CMDQ_EVENT_DIP_DMA_ERR_EVENT		276
-#define CMDQ_EVENT_AMD_FRAME_DONE		277
-#define CMDQ_EVENT_MFB_DONE			278
-#define CMDQ_EVENT_WPE_A_EOF			279
-#define CMDQ_EVENT_VENC_EOF			289
-#define CMDQ_EVENT_VENC_CMDQ_PAUSE_DONE		290
-#define CMDQ_EVENT_JPEG_ENC_EOF			291
-#define CMDQ_EVENT_VENC_MB_DONE			292
-#define CMDQ_EVENT_VENC_128BYTE_CNT_DONE	293
-#define CMDQ_EVENT_ISP_FRAME_DONE_A		321
-#define CMDQ_EVENT_ISP_FRAME_DONE_B		322
-#define CMDQ_EVENT_ISP_FRAME_DONE_C		323
-#define CMDQ_EVENT_ISP_CAMSV_0_PASS1_DONE	324
-#define CMDQ_EVENT_ISP_CAMSV_0_2_PASS1_DONE	325
-#define CMDQ_EVENT_ISP_CAMSV_1_PASS1_DONE	326
-#define CMDQ_EVENT_ISP_CAMSV_2_PASS1_DONE	327
-#define CMDQ_EVENT_ISP_CAMSV_3_PASS1_DONE	328
-#define CMDQ_EVENT_ISP_TSF_DONE			329
-#define CMDQ_EVENT_SENINF_0_FIFO_FULL		330
-#define CMDQ_EVENT_SENINF_1_FIFO_FULL		331
-#define CMDQ_EVENT_SENINF_2_FIFO_FULL		332
-#define CMDQ_EVENT_SENINF_3_FIFO_FULL		333
-#define CMDQ_EVENT_SENINF_4_FIFO_FULL		334
-#define CMDQ_EVENT_SENINF_5_FIFO_FULL		335
-#define CMDQ_EVENT_SENINF_6_FIFO_FULL		336
-#define CMDQ_EVENT_SENINF_7_FIFO_FULL		337
-#define CMDQ_EVENT_TG_OVRUN_A_INT_DLY		338
-#define CMDQ_EVENT_TG_OVRUN_B_INT_DLY		339
-#define CMDQ_EVENT_TG_OVRUN_C_INT		340
-#define CMDQ_EVENT_TG_GRABERR_A_INT_DLY		341
-#define CMDQ_EVENT_TG_GRABERR_B_INT_DLY		342
-#define CMDQ_EVENT_TG_GRABERR_C_INT		343
-#define CMDQ_EVENT_CQ_VR_SNAP_A_INT_DLY		344
-#define CMDQ_EVENT_CQ_VR_SNAP_B_INT_DLY		345
-#define CMDQ_EVENT_CQ_VR_SNAP_C_INT		346
-#define CMDQ_EVENT_DMA_R1_ERROR_A_INT_DLY	347
-#define CMDQ_EVENT_DMA_R1_ERROR_B_INT_DLY	348
-#define CMDQ_EVENT_DMA_R1_ERROR_C_INT		349
-#define CMDQ_EVENT_APU_GCE_CORE0_EVENT_0	353
-#define CMDQ_EVENT_APU_GCE_CORE0_EVENT_1	354
-#define CMDQ_EVENT_APU_GCE_CORE0_EVENT_2	355
-#define CMDQ_EVENT_APU_GCE_CORE0_EVENT_3	356
-#define CMDQ_EVENT_APU_GCE_CORE1_EVENT_0	385
-#define CMDQ_EVENT_APU_GCE_CORE1_EVENT_1	386
-#define CMDQ_EVENT_APU_GCE_CORE1_EVENT_2	387
-#define CMDQ_EVENT_APU_GCE_CORE1_EVENT_3	388
-#define CMDQ_EVENT_VDEC_EVENT_0			416
-#define CMDQ_EVENT_VDEC_EVENT_1			417
-#define CMDQ_EVENT_VDEC_EVENT_2			418
-#define CMDQ_EVENT_VDEC_EVENT_3			419
-#define CMDQ_EVENT_VDEC_EVENT_4			420
-#define CMDQ_EVENT_VDEC_EVENT_5			421
-#define CMDQ_EVENT_VDEC_EVENT_6			422
-#define CMDQ_EVENT_VDEC_EVENT_7			423
-#define CMDQ_EVENT_VDEC_EVENT_8			424
-#define CMDQ_EVENT_VDEC_EVENT_9			425
-#define CMDQ_EVENT_VDEC_EVENT_10		426
-#define CMDQ_EVENT_VDEC_EVENT_11		427
-#define CMDQ_EVENT_VDEC_EVENT_12		428
-#define CMDQ_EVENT_VDEC_EVENT_13		429
-#define CMDQ_EVENT_VDEC_EVENT_14		430
-#define CMDQ_EVENT_VDEC_EVENT_15		431
-#define CMDQ_EVENT_FDVT_DONE			449
-#define CMDQ_EVENT_FE_DONE			450
-#define CMDQ_EVENT_RSC_EOF			451
-#define CMDQ_EVENT_DVS_DONE_ASYNC_SHOT		452
-#define CMDQ_EVENT_DVP_DONE_ASYNC_SHOT		453
-#define CMDQ_EVENT_DSI0_TE_INFRA		898
-
-#endif
diff --git a/include/dt-bindings/iio/qcom,spmi-adc7-pmr735b.h b/include/dt-bindings/iio/qcom,spmi-adc7-pmr735b.h
deleted file mode 100644
index fdb8dd9ae541..000000000000
--- a/include/dt-bindings/iio/qcom,spmi-adc7-pmr735b.h
+++ /dev/null
@@ -1,30 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0-only */
-/*
- * Copyright (c) 2020 The Linux Foundation. All rights reserved.
- */
-
-#ifndef _DT_BINDINGS_QCOM_SPMI_VADC_PMR735B_H
-#define _DT_BINDINGS_QCOM_SPMI_VADC_PMR735B_H
-
-#ifndef PMR735B_SID
-#define PMR735B_SID					5
-#endif
-
-#include <dt-bindings/iio/qcom,spmi-vadc.h>
-
-/* ADC channels for PMR735B_ADC for PMIC7 */
-#define PMR735B_ADC7_REF_GND			(PMR735B_SID << 8 | ADC7_REF_GND)
-#define PMR735B_ADC7_1P25VREF			(PMR735B_SID << 8 | ADC7_1P25VREF)
-#define PMR735B_ADC7_VREF_VADC			(PMR735B_SID << 8 | ADC7_VREF_VADC)
-#define PMR735B_ADC7_DIE_TEMP			(PMR735B_SID << 8 | ADC7_DIE_TEMP)
-
-#define PMR735B_ADC7_GPIO1			(PMR735B_SID << 8 | ADC7_GPIO1)
-#define PMR735B_ADC7_GPIO2			(PMR735B_SID << 8 | ADC7_GPIO2)
-#define PMR735B_ADC7_GPIO3			(PMR735B_SID << 8 | ADC7_GPIO3)
-
-/* 100k pull-up2 */
-#define PMR735B_ADC7_GPIO1_100K_PU		(PMR735B_SID << 8 | ADC7_GPIO1_100K_PU)
-#define PMR735B_ADC7_GPIO2_100K_PU		(PMR735B_SID << 8 | ADC7_GPIO2_100K_PU)
-#define PMR735B_ADC7_GPIO3_100K_PU		(PMR735B_SID << 8 | ADC7_GPIO3_100K_PU)
-
-#endif /* _DT_BINDINGS_QCOM_SPMI_VADC_PMR735B_H */
diff --git a/include/dt-bindings/iio/qcom,spmi-adc7-smb139x.h b/include/dt-bindings/iio/qcom,spmi-adc7-smb139x.h
deleted file mode 100644
index c0680d1285cf..000000000000
--- a/include/dt-bindings/iio/qcom,spmi-adc7-smb139x.h
+++ /dev/null
@@ -1,19 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0-only OR BSD-3-Clause */
-/*
- * Copyright (c) 2020 The Linux Foundation. All rights reserved.
- */
-
-#ifndef _DT_BINDINGS_QCOM_SPMI_VADC_SMB139X_H
-#define _DT_BINDINGS_QCOM_SPMI_VADC_SMB139X_H
-
-#include <dt-bindings/iio/qcom,spmi-vadc.h>
-
-#define SMB139x_1_ADC7_SMB_TEMP			(SMB139x_1_SID << 8 | ADC7_SMB_TEMP)
-#define SMB139x_1_ADC7_ICHG_SMB			(SMB139x_1_SID << 8 | ADC7_ICHG_SMB)
-#define SMB139x_1_ADC7_IIN_SMB			(SMB139x_1_SID << 8 | ADC7_IIN_SMB)
-
-#define SMB139x_2_ADC7_SMB_TEMP			(SMB139x_2_SID << 8 | ADC7_SMB_TEMP)
-#define SMB139x_2_ADC7_ICHG_SMB			(SMB139x_2_SID << 8 | ADC7_ICHG_SMB)
-#define SMB139x_2_ADC7_IIN_SMB			(SMB139x_2_SID << 8 | ADC7_IIN_SMB)
-
-#endif
diff --git a/include/dt-bindings/memory/mt6779-larb-port.h b/include/dt-bindings/memory/mt6779-larb-port.h
deleted file mode 100644
index 3fb438a96e35..000000000000
--- a/include/dt-bindings/memory/mt6779-larb-port.h
+++ /dev/null
@@ -1,206 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-/*
- * Copyright (c) 2019 MediaTek Inc.
- * Author: Chao Hao <chao.hao@mediatek.com>
- */
-
-#ifndef _DT_BINDINGS_MEMORY_MT6779_LARB_PORT_H_
-#define _DT_BINDINGS_MEMORY_MT6779_LARB_PORT_H_
-
-#include <dt-bindings/memory/mtk-memory-port.h>
-
-#define M4U_LARB0_ID			 0
-#define M4U_LARB1_ID			 1
-#define M4U_LARB2_ID			 2
-#define M4U_LARB3_ID			 3
-#define M4U_LARB4_ID			 4
-#define M4U_LARB5_ID			 5
-#define M4U_LARB6_ID			 6
-#define M4U_LARB7_ID			 7
-#define M4U_LARB8_ID			 8
-#define M4U_LARB9_ID			 9
-#define M4U_LARB10_ID			 10
-#define M4U_LARB11_ID			 11
-
-/* larb0 */
-#define M4U_PORT_DISP_POSTMASK0		 MTK_M4U_ID(M4U_LARB0_ID, 0)
-#define M4U_PORT_DISP_OVL0_HDR		 MTK_M4U_ID(M4U_LARB0_ID, 1)
-#define M4U_PORT_DISP_OVL1_HDR		 MTK_M4U_ID(M4U_LARB0_ID, 2)
-#define M4U_PORT_DISP_OVL0		 MTK_M4U_ID(M4U_LARB0_ID, 3)
-#define M4U_PORT_DISP_OVL1		 MTK_M4U_ID(M4U_LARB0_ID, 4)
-#define M4U_PORT_DISP_PVRIC0		 MTK_M4U_ID(M4U_LARB0_ID, 5)
-#define M4U_PORT_DISP_RDMA0		 MTK_M4U_ID(M4U_LARB0_ID, 6)
-#define M4U_PORT_DISP_WDMA0		 MTK_M4U_ID(M4U_LARB0_ID, 7)
-#define M4U_PORT_DISP_FAKE0		 MTK_M4U_ID(M4U_LARB0_ID, 8)
-
-/* larb1 */
-#define M4U_PORT_DISP_OVL0_2L_HDR	 MTK_M4U_ID(M4U_LARB1_ID, 0)
-#define M4U_PORT_DISP_OVL1_2L_HDR	 MTK_M4U_ID(M4U_LARB1_ID, 1)
-#define M4U_PORT_DISP_OVL0_2L		 MTK_M4U_ID(M4U_LARB1_ID, 2)
-#define M4U_PORT_DISP_OVL1_2L		 MTK_M4U_ID(M4U_LARB1_ID, 3)
-#define M4U_PORT_DISP_RDMA1		 MTK_M4U_ID(M4U_LARB1_ID, 4)
-#define M4U_PORT_MDP_PVRIC0		 MTK_M4U_ID(M4U_LARB1_ID, 5)
-#define M4U_PORT_MDP_PVRIC1		 MTK_M4U_ID(M4U_LARB1_ID, 6)
-#define M4U_PORT_MDP_RDMA0		 MTK_M4U_ID(M4U_LARB1_ID, 7)
-#define M4U_PORT_MDP_RDMA1		 MTK_M4U_ID(M4U_LARB1_ID, 8)
-#define M4U_PORT_MDP_WROT0_R		 MTK_M4U_ID(M4U_LARB1_ID, 9)
-#define M4U_PORT_MDP_WROT0_W		 MTK_M4U_ID(M4U_LARB1_ID, 10)
-#define M4U_PORT_MDP_WROT1_R		 MTK_M4U_ID(M4U_LARB1_ID, 11)
-#define M4U_PORT_MDP_WROT1_W		 MTK_M4U_ID(M4U_LARB1_ID, 12)
-#define M4U_PORT_DISP_FAKE1		 MTK_M4U_ID(M4U_LARB1_ID, 13)
-
-/* larb2-VDEC */
-#define M4U_PORT_HW_VDEC_MC_EXT          MTK_M4U_ID(M4U_LARB2_ID, 0)
-#define M4U_PORT_HW_VDEC_UFO_EXT         MTK_M4U_ID(M4U_LARB2_ID, 1)
-#define M4U_PORT_HW_VDEC_PP_EXT          MTK_M4U_ID(M4U_LARB2_ID, 2)
-#define M4U_PORT_HW_VDEC_PRED_RD_EXT     MTK_M4U_ID(M4U_LARB2_ID, 3)
-#define M4U_PORT_HW_VDEC_PRED_WR_EXT     MTK_M4U_ID(M4U_LARB2_ID, 4)
-#define M4U_PORT_HW_VDEC_PPWRAP_EXT      MTK_M4U_ID(M4U_LARB2_ID, 5)
-#define M4U_PORT_HW_VDEC_TILE_EXT        MTK_M4U_ID(M4U_LARB2_ID, 6)
-#define M4U_PORT_HW_VDEC_VLD_EXT         MTK_M4U_ID(M4U_LARB2_ID, 7)
-#define M4U_PORT_HW_VDEC_VLD2_EXT        MTK_M4U_ID(M4U_LARB2_ID, 8)
-#define M4U_PORT_HW_VDEC_AVC_MV_EXT      MTK_M4U_ID(M4U_LARB2_ID, 9)
-#define M4U_PORT_HW_VDEC_UFO_ENC_EXT     MTK_M4U_ID(M4U_LARB2_ID, 10)
-#define M4U_PORT_HW_VDEC_RG_CTRL_DMA_EXT MTK_M4U_ID(M4U_LARB2_ID, 11)
-
-/* larb3-VENC */
-#define M4U_PORT_VENC_RCPU		 MTK_M4U_ID(M4U_LARB3_ID, 0)
-#define M4U_PORT_VENC_REC		 MTK_M4U_ID(M4U_LARB3_ID, 1)
-#define M4U_PORT_VENC_BSDMA		 MTK_M4U_ID(M4U_LARB3_ID, 2)
-#define M4U_PORT_VENC_SV_COMV		 MTK_M4U_ID(M4U_LARB3_ID, 3)
-#define M4U_PORT_VENC_RD_COMV		 MTK_M4U_ID(M4U_LARB3_ID, 4)
-#define M4U_PORT_VENC_NBM_RDMA		 MTK_M4U_ID(M4U_LARB3_ID, 5)
-#define M4U_PORT_VENC_NBM_RDMA_LITE	 MTK_M4U_ID(M4U_LARB3_ID, 6)
-#define M4U_PORT_JPGENC_Y_RDMA		 MTK_M4U_ID(M4U_LARB3_ID, 7)
-#define M4U_PORT_JPGENC_C_RDMA		 MTK_M4U_ID(M4U_LARB3_ID, 8)
-#define M4U_PORT_JPGENC_Q_TABLE		 MTK_M4U_ID(M4U_LARB3_ID, 9)
-#define M4U_PORT_JPGENC_BSDMA		 MTK_M4U_ID(M4U_LARB3_ID, 10)
-#define M4U_PORT_JPGDEC_WDMA		 MTK_M4U_ID(M4U_LARB3_ID, 11)
-#define M4U_PORT_JPGDEC_BSDMA		 MTK_M4U_ID(M4U_LARB3_ID, 12)
-#define M4U_PORT_VENC_NBM_WDMA		 MTK_M4U_ID(M4U_LARB3_ID, 13)
-#define M4U_PORT_VENC_NBM_WDMA_LITE	 MTK_M4U_ID(M4U_LARB3_ID, 14)
-#define M4U_PORT_VENC_CUR_LUMA		 MTK_M4U_ID(M4U_LARB3_ID, 15)
-#define M4U_PORT_VENC_CUR_CHROMA	 MTK_M4U_ID(M4U_LARB3_ID, 16)
-#define M4U_PORT_VENC_REF_LUMA		 MTK_M4U_ID(M4U_LARB3_ID, 17)
-#define M4U_PORT_VENC_REF_CHROMA	 MTK_M4U_ID(M4U_LARB3_ID, 18)
-
-/* larb4-dummy */
-
-/* larb5-IMG */
-#define M4U_PORT_IMGI_D1		 MTK_M4U_ID(M4U_LARB5_ID, 0)
-#define M4U_PORT_IMGBI_D1		 MTK_M4U_ID(M4U_LARB5_ID, 1)
-#define M4U_PORT_DMGI_D1		 MTK_M4U_ID(M4U_LARB5_ID, 2)
-#define M4U_PORT_DEPI_D1		 MTK_M4U_ID(M4U_LARB5_ID, 3)
-#define M4U_PORT_LCEI_D1		 MTK_M4U_ID(M4U_LARB5_ID, 4)
-#define M4U_PORT_SMTI_D1		 MTK_M4U_ID(M4U_LARB5_ID, 5)
-#define M4U_PORT_SMTO_D2		 MTK_M4U_ID(M4U_LARB5_ID, 6)
-#define M4U_PORT_SMTO_D1		 MTK_M4U_ID(M4U_LARB5_ID, 7)
-#define M4U_PORT_CRZO_D1		 MTK_M4U_ID(M4U_LARB5_ID, 8)
-#define M4U_PORT_IMG3O_D1		 MTK_M4U_ID(M4U_LARB5_ID, 9)
-#define M4U_PORT_VIPI_D1		 MTK_M4U_ID(M4U_LARB5_ID, 10)
-#define M4U_PORT_WPE_RDMA1		 MTK_M4U_ID(M4U_LARB5_ID, 11)
-#define M4U_PORT_WPE_RDMA0		 MTK_M4U_ID(M4U_LARB5_ID, 12)
-#define M4U_PORT_WPE_WDMA		 MTK_M4U_ID(M4U_LARB5_ID, 13)
-#define M4U_PORT_TIMGO_D1		 MTK_M4U_ID(M4U_LARB5_ID, 14)
-#define M4U_PORT_MFB_RDMA0		 MTK_M4U_ID(M4U_LARB5_ID, 15)
-#define M4U_PORT_MFB_RDMA1		 MTK_M4U_ID(M4U_LARB5_ID, 16)
-#define M4U_PORT_MFB_RDMA2		 MTK_M4U_ID(M4U_LARB5_ID, 17)
-#define M4U_PORT_MFB_RDMA3		 MTK_M4U_ID(M4U_LARB5_ID, 18)
-#define M4U_PORT_MFB_WDMA		 MTK_M4U_ID(M4U_LARB5_ID, 19)
-#define M4U_PORT_RESERVE1		 MTK_M4U_ID(M4U_LARB5_ID, 20)
-#define M4U_PORT_RESERVE2		 MTK_M4U_ID(M4U_LARB5_ID, 21)
-#define M4U_PORT_RESERVE3		 MTK_M4U_ID(M4U_LARB5_ID, 22)
-#define M4U_PORT_RESERVE4		 MTK_M4U_ID(M4U_LARB5_ID, 23)
-#define M4U_PORT_RESERVE5		 MTK_M4U_ID(M4U_LARB5_ID, 24)
-#define M4U_PORT_RESERVE6		 MTK_M4U_ID(M4U_LARB5_ID, 25)
-
-/* larb6-IMG-VPU */
-#define M4U_PORT_IMG_IPUO		 MTK_M4U_ID(M4U_LARB6_ID, 0)
-#define M4U_PORT_IMG_IPU3O		 MTK_M4U_ID(M4U_LARB6_ID, 1)
-#define M4U_PORT_IMG_IPUI		 MTK_M4U_ID(M4U_LARB6_ID, 2)
-
-/* larb7-DVS */
-#define M4U_PORT_DVS_RDMA		 MTK_M4U_ID(M4U_LARB7_ID, 0)
-#define M4U_PORT_DVS_WDMA		 MTK_M4U_ID(M4U_LARB7_ID, 1)
-#define M4U_PORT_DVP_RDMA		 MTK_M4U_ID(M4U_LARB7_ID, 2)
-#define M4U_PORT_DVP_WDMA		 MTK_M4U_ID(M4U_LARB7_ID, 3)
-
-/* larb8-IPESYS */
-#define M4U_PORT_FDVT_RDA		 MTK_M4U_ID(M4U_LARB8_ID, 0)
-#define M4U_PORT_FDVT_RDB		 MTK_M4U_ID(M4U_LARB8_ID, 1)
-#define M4U_PORT_FDVT_WRA		 MTK_M4U_ID(M4U_LARB8_ID, 2)
-#define M4U_PORT_FDVT_WRB		 MTK_M4U_ID(M4U_LARB8_ID, 3)
-#define M4U_PORT_FE_RD0			 MTK_M4U_ID(M4U_LARB8_ID, 4)
-#define M4U_PORT_FE_RD1			 MTK_M4U_ID(M4U_LARB8_ID, 5)
-#define M4U_PORT_FE_WR0			 MTK_M4U_ID(M4U_LARB8_ID, 6)
-#define M4U_PORT_FE_WR1			 MTK_M4U_ID(M4U_LARB8_ID, 7)
-#define M4U_PORT_RSC_RDMA0		 MTK_M4U_ID(M4U_LARB8_ID, 8)
-#define M4U_PORT_RSC_WDMA		 MTK_M4U_ID(M4U_LARB8_ID, 9)
-
-/* larb9-CAM */
-#define M4U_PORT_CAM_IMGO_R1_C		 MTK_M4U_ID(M4U_LARB9_ID, 0)
-#define M4U_PORT_CAM_RRZO_R1_C		 MTK_M4U_ID(M4U_LARB9_ID, 1)
-#define M4U_PORT_CAM_LSCI_R1_C		 MTK_M4U_ID(M4U_LARB9_ID, 2)
-#define M4U_PORT_CAM_BPCI_R1_C		 MTK_M4U_ID(M4U_LARB9_ID, 3)
-#define M4U_PORT_CAM_YUVO_R1_C		 MTK_M4U_ID(M4U_LARB9_ID, 4)
-#define M4U_PORT_CAM_UFDI_R2_C		 MTK_M4U_ID(M4U_LARB9_ID, 5)
-#define M4U_PORT_CAM_RAWI_R2_C		 MTK_M4U_ID(M4U_LARB9_ID, 6)
-#define M4U_PORT_CAM_RAWI_R5_C		 MTK_M4U_ID(M4U_LARB9_ID, 7)
-#define M4U_PORT_CAM_CAMSV_1		 MTK_M4U_ID(M4U_LARB9_ID, 8)
-#define M4U_PORT_CAM_CAMSV_2		 MTK_M4U_ID(M4U_LARB9_ID, 9)
-#define M4U_PORT_CAM_CAMSV_3		 MTK_M4U_ID(M4U_LARB9_ID, 10)
-#define M4U_PORT_CAM_CAMSV_4		 MTK_M4U_ID(M4U_LARB9_ID, 11)
-#define M4U_PORT_CAM_CAMSV_5		 MTK_M4U_ID(M4U_LARB9_ID, 12)
-#define M4U_PORT_CAM_CAMSV_6		 MTK_M4U_ID(M4U_LARB9_ID, 13)
-#define M4U_PORT_CAM_AAO_R1_C		 MTK_M4U_ID(M4U_LARB9_ID, 14)
-#define M4U_PORT_CAM_AFO_R1_C		 MTK_M4U_ID(M4U_LARB9_ID, 15)
-#define M4U_PORT_CAM_FLKO_R1_C		 MTK_M4U_ID(M4U_LARB9_ID, 16)
-#define M4U_PORT_CAM_LCESO_R1_C		 MTK_M4U_ID(M4U_LARB9_ID, 17)
-#define M4U_PORT_CAM_CRZO_R1_C		 MTK_M4U_ID(M4U_LARB9_ID, 18)
-#define M4U_PORT_CAM_LTMSO_R1_C		 MTK_M4U_ID(M4U_LARB9_ID, 19)
-#define M4U_PORT_CAM_RSSO_R1_C		 MTK_M4U_ID(M4U_LARB9_ID, 20)
-#define M4U_PORT_CAM_CCUI		 MTK_M4U_ID(M4U_LARB9_ID, 21)
-#define M4U_PORT_CAM_CCUO		 MTK_M4U_ID(M4U_LARB9_ID, 22)
-#define M4U_PORT_CAM_FAKE		 MTK_M4U_ID(M4U_LARB9_ID, 23)
-
-/* larb10-CAM_A */
-#define M4U_PORT_CAM_IMGO_R1_A		 MTK_M4U_ID(M4U_LARB10_ID, 0)
-#define M4U_PORT_CAM_RRZO_R1_A		 MTK_M4U_ID(M4U_LARB10_ID, 1)
-#define M4U_PORT_CAM_LSCI_R1_A		 MTK_M4U_ID(M4U_LARB10_ID, 2)
-#define M4U_PORT_CAM_BPCI_R1_A		 MTK_M4U_ID(M4U_LARB10_ID, 3)
-#define M4U_PORT_CAM_YUVO_R1_A		 MTK_M4U_ID(M4U_LARB10_ID, 4)
-#define M4U_PORT_CAM_UFDI_R2_A		 MTK_M4U_ID(M4U_LARB10_ID, 5)
-#define M4U_PORT_CAM_RAWI_R2_A		 MTK_M4U_ID(M4U_LARB10_ID, 6)
-#define M4U_PORT_CAM_RAWI_R5_A		 MTK_M4U_ID(M4U_LARB10_ID, 7)
-#define M4U_PORT_CAM_IMGO_R1_B		 MTK_M4U_ID(M4U_LARB10_ID, 8)
-#define M4U_PORT_CAM_RRZO_R1_B		 MTK_M4U_ID(M4U_LARB10_ID, 9)
-#define M4U_PORT_CAM_LSCI_R1_B		 MTK_M4U_ID(M4U_LARB10_ID, 10)
-#define M4U_PORT_CAM_BPCI_R1_B		 MTK_M4U_ID(M4U_LARB10_ID, 11)
-#define M4U_PORT_CAM_YUVO_R1_B		 MTK_M4U_ID(M4U_LARB10_ID, 12)
-#define M4U_PORT_CAM_UFDI_R2_B		 MTK_M4U_ID(M4U_LARB10_ID, 13)
-#define M4U_PORT_CAM_RAWI_R2_B		 MTK_M4U_ID(M4U_LARB10_ID, 14)
-#define M4U_PORT_CAM_RAWI_R5_B		 MTK_M4U_ID(M4U_LARB10_ID, 15)
-#define M4U_PORT_CAM_CAMSV_0		 MTK_M4U_ID(M4U_LARB10_ID, 16)
-#define M4U_PORT_CAM_AAO_R1_A		 MTK_M4U_ID(M4U_LARB10_ID, 17)
-#define M4U_PORT_CAM_AFO_R1_A		 MTK_M4U_ID(M4U_LARB10_ID, 18)
-#define M4U_PORT_CAM_FLKO_R1_A		 MTK_M4U_ID(M4U_LARB10_ID, 19)
-#define M4U_PORT_CAM_LCESO_R1_A		 MTK_M4U_ID(M4U_LARB10_ID, 20)
-#define M4U_PORT_CAM_CRZO_R1_A		 MTK_M4U_ID(M4U_LARB10_ID, 21)
-#define M4U_PORT_CAM_AAO_R1_B		 MTK_M4U_ID(M4U_LARB10_ID, 22)
-#define M4U_PORT_CAM_AFO_R1_B		 MTK_M4U_ID(M4U_LARB10_ID, 23)
-#define M4U_PORT_CAM_FLKO_R1_B		 MTK_M4U_ID(M4U_LARB10_ID, 24)
-#define M4U_PORT_CAM_LCESO_R1_B		 MTK_M4U_ID(M4U_LARB10_ID, 25)
-#define M4U_PORT_CAM_CRZO_R1_B		 MTK_M4U_ID(M4U_LARB10_ID, 26)
-#define M4U_PORT_CAM_LTMSO_R1_A		 MTK_M4U_ID(M4U_LARB10_ID, 27)
-#define M4U_PORT_CAM_RSSO_R1_A		 MTK_M4U_ID(M4U_LARB10_ID, 28)
-#define M4U_PORT_CAM_LTMSO_R1_B		 MTK_M4U_ID(M4U_LARB10_ID, 29)
-#define M4U_PORT_CAM_RSSO_R1_B		 MTK_M4U_ID(M4U_LARB10_ID, 30)
-
-/* larb11-CAM-VPU */
-#define M4U_PORT_CAM_IPUO		 MTK_M4U_ID(M4U_LARB11_ID, 0)
-#define M4U_PORT_CAM_IPU2O		 MTK_M4U_ID(M4U_LARB11_ID, 1)
-#define M4U_PORT_CAM_IPU3O		 MTK_M4U_ID(M4U_LARB11_ID, 2)
-#define M4U_PORT_CAM_IPUI		 MTK_M4U_ID(M4U_LARB11_ID, 3)
-#define M4U_PORT_CAM_IPU2I		 MTK_M4U_ID(M4U_LARB11_ID, 4)
-
-#endif
diff --git a/include/dt-bindings/mux/ti-serdes.h b/include/dt-bindings/mux/ti-serdes.h
deleted file mode 100644
index b0b1091aad6d..000000000000
--- a/include/dt-bindings/mux/ti-serdes.h
+++ /dev/null
@@ -1,190 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-/*
- * This header provides constants for SERDES MUX for TI SoCs
- */
-
-#ifndef _DT_BINDINGS_MUX_TI_SERDES
-#define _DT_BINDINGS_MUX_TI_SERDES
-
-/*
- * These bindings are deprecated, because they do not match the actual
- * concept of bindings but rather contain pure constants values used only
- * in DTS board files.
- * Instead include the header in the DTS source directory.
- */
-#warning "These bindings are deprecated. Instead, use the header in the DTS source directory."
-
-/* J721E */
-
-#define J721E_SERDES0_LANE0_QSGMII_LANE1	0x0
-#define J721E_SERDES0_LANE0_PCIE0_LANE0		0x1
-#define J721E_SERDES0_LANE0_USB3_0_SWAP		0x2
-#define J721E_SERDES0_LANE0_IP4_UNUSED		0x3
-
-#define J721E_SERDES0_LANE1_QSGMII_LANE2	0x0
-#define J721E_SERDES0_LANE1_PCIE0_LANE1		0x1
-#define J721E_SERDES0_LANE1_USB3_0		0x2
-#define J721E_SERDES0_LANE1_IP4_UNUSED		0x3
-
-#define J721E_SERDES1_LANE0_QSGMII_LANE3	0x0
-#define J721E_SERDES1_LANE0_PCIE1_LANE0		0x1
-#define J721E_SERDES1_LANE0_USB3_1_SWAP		0x2
-#define J721E_SERDES1_LANE0_SGMII_LANE0		0x3
-
-#define J721E_SERDES1_LANE1_QSGMII_LANE4	0x0
-#define J721E_SERDES1_LANE1_PCIE1_LANE1		0x1
-#define J721E_SERDES1_LANE1_USB3_1		0x2
-#define J721E_SERDES1_LANE1_SGMII_LANE1		0x3
-
-#define J721E_SERDES2_LANE0_IP1_UNUSED		0x0
-#define J721E_SERDES2_LANE0_PCIE2_LANE0		0x1
-#define J721E_SERDES2_LANE0_USB3_1_SWAP		0x2
-#define J721E_SERDES2_LANE0_SGMII_LANE0		0x3
-
-#define J721E_SERDES2_LANE1_IP1_UNUSED		0x0
-#define J721E_SERDES2_LANE1_PCIE2_LANE1		0x1
-#define J721E_SERDES2_LANE1_USB3_1		0x2
-#define J721E_SERDES2_LANE1_SGMII_LANE1		0x3
-
-#define J721E_SERDES3_LANE0_IP1_UNUSED		0x0
-#define J721E_SERDES3_LANE0_PCIE3_LANE0		0x1
-#define J721E_SERDES3_LANE0_USB3_0_SWAP		0x2
-#define J721E_SERDES3_LANE0_IP4_UNUSED		0x3
-
-#define J721E_SERDES3_LANE1_IP1_UNUSED		0x0
-#define J721E_SERDES3_LANE1_PCIE3_LANE1		0x1
-#define J721E_SERDES3_LANE1_USB3_0		0x2
-#define J721E_SERDES3_LANE1_IP4_UNUSED		0x3
-
-#define J721E_SERDES4_LANE0_EDP_LANE0		0x0
-#define J721E_SERDES4_LANE0_IP2_UNUSED		0x1
-#define J721E_SERDES4_LANE0_QSGMII_LANE5	0x2
-#define J721E_SERDES4_LANE0_IP4_UNUSED		0x3
-
-#define J721E_SERDES4_LANE1_EDP_LANE1		0x0
-#define J721E_SERDES4_LANE1_IP2_UNUSED		0x1
-#define J721E_SERDES4_LANE1_QSGMII_LANE6	0x2
-#define J721E_SERDES4_LANE1_IP4_UNUSED		0x3
-
-#define J721E_SERDES4_LANE2_EDP_LANE2		0x0
-#define J721E_SERDES4_LANE2_IP2_UNUSED		0x1
-#define J721E_SERDES4_LANE2_QSGMII_LANE7	0x2
-#define J721E_SERDES4_LANE2_IP4_UNUSED		0x3
-
-#define J721E_SERDES4_LANE3_EDP_LANE3		0x0
-#define J721E_SERDES4_LANE3_IP2_UNUSED		0x1
-#define J721E_SERDES4_LANE3_QSGMII_LANE8	0x2
-#define J721E_SERDES4_LANE3_IP4_UNUSED		0x3
-
-/* J7200 */
-
-#define J7200_SERDES0_LANE0_QSGMII_LANE3	0x0
-#define J7200_SERDES0_LANE0_PCIE1_LANE0		0x1
-#define J7200_SERDES0_LANE0_IP3_UNUSED		0x2
-#define J7200_SERDES0_LANE0_IP4_UNUSED		0x3
-
-#define J7200_SERDES0_LANE1_QSGMII_LANE4	0x0
-#define J7200_SERDES0_LANE1_PCIE1_LANE1		0x1
-#define J7200_SERDES0_LANE1_IP3_UNUSED		0x2
-#define J7200_SERDES0_LANE1_IP4_UNUSED		0x3
-
-#define J7200_SERDES0_LANE2_QSGMII_LANE1	0x0
-#define J7200_SERDES0_LANE2_PCIE1_LANE2		0x1
-#define J7200_SERDES0_LANE2_IP3_UNUSED		0x2
-#define J7200_SERDES0_LANE2_IP4_UNUSED		0x3
-
-#define J7200_SERDES0_LANE3_QSGMII_LANE2	0x0
-#define J7200_SERDES0_LANE3_PCIE1_LANE3		0x1
-#define J7200_SERDES0_LANE3_USB			0x2
-#define J7200_SERDES0_LANE3_IP4_UNUSED		0x3
-
-/* AM64 */
-
-#define AM64_SERDES0_LANE0_PCIE0		0x0
-#define AM64_SERDES0_LANE0_USB			0x1
-
-/* J721S2 */
-
-#define J721S2_SERDES0_LANE0_EDP_LANE0		0x0
-#define J721S2_SERDES0_LANE0_PCIE1_LANE0	0x1
-#define J721S2_SERDES0_LANE0_IP3_UNUSED		0x2
-#define J721S2_SERDES0_LANE0_IP4_UNUSED		0x3
-
-#define J721S2_SERDES0_LANE1_EDP_LANE1		0x0
-#define J721S2_SERDES0_LANE1_PCIE1_LANE1	0x1
-#define J721S2_SERDES0_LANE1_USB		0x2
-#define J721S2_SERDES0_LANE1_IP4_UNUSED		0x3
-
-#define J721S2_SERDES0_LANE2_EDP_LANE2		0x0
-#define J721S2_SERDES0_LANE2_PCIE1_LANE2	0x1
-#define J721S2_SERDES0_LANE2_IP3_UNUSED		0x2
-#define J721S2_SERDES0_LANE2_IP4_UNUSED		0x3
-
-#define J721S2_SERDES0_LANE3_EDP_LANE3		0x0
-#define J721S2_SERDES0_LANE3_PCIE1_LANE3	0x1
-#define J721S2_SERDES0_LANE3_USB		0x2
-#define J721S2_SERDES0_LANE3_IP4_UNUSED		0x3
-
-/* J784S4 */
-
-#define J784S4_SERDES0_LANE0_IP1_UNUSED		0x0
-#define J784S4_SERDES0_LANE0_PCIE1_LANE0	0x1
-#define J784S4_SERDES0_LANE0_IP3_UNUSED		0x2
-#define J784S4_SERDES0_LANE0_IP4_UNUSED		0x3
-
-#define J784S4_SERDES0_LANE1_IP1_UNUSED		0x0
-#define J784S4_SERDES0_LANE1_PCIE1_LANE1	0x1
-#define J784S4_SERDES0_LANE1_IP3_UNUSED		0x2
-#define J784S4_SERDES0_LANE1_IP4_UNUSED		0x3
-
-#define J784S4_SERDES0_LANE2_PCIE3_LANE0	0x0
-#define J784S4_SERDES0_LANE2_PCIE1_LANE2	0x1
-#define J784S4_SERDES0_LANE2_IP3_UNUSED		0x2
-#define J784S4_SERDES0_LANE2_IP4_UNUSED		0x3
-
-#define J784S4_SERDES0_LANE3_PCIE3_LANE1	0x0
-#define J784S4_SERDES0_LANE3_PCIE1_LANE3	0x1
-#define J784S4_SERDES0_LANE3_USB		0x2
-#define J784S4_SERDES0_LANE3_IP4_UNUSED		0x3
-
-#define J784S4_SERDES1_LANE0_QSGMII_LANE3	0x0
-#define J784S4_SERDES1_LANE0_PCIE0_LANE0	0x1
-#define J784S4_SERDES1_LANE0_IP3_UNUSED		0x2
-#define J784S4_SERDES1_LANE0_IP4_UNUSED		0x3
-
-#define J784S4_SERDES1_LANE1_QSGMII_LANE4	0x0
-#define J784S4_SERDES1_LANE1_PCIE0_LANE1	0x1
-#define J784S4_SERDES1_LANE1_IP3_UNUSED		0x2
-#define J784S4_SERDES1_LANE1_IP4_UNUSED		0x3
-
-#define J784S4_SERDES1_LANE2_QSGMII_LANE1	0x0
-#define J784S4_SERDES1_LANE2_PCIE0_LANE2	0x1
-#define J784S4_SERDES1_LANE2_PCIE2_LANE0	0x2
-#define J784S4_SERDES1_LANE2_IP4_UNUSED		0x3
-
-#define J784S4_SERDES1_LANE3_QSGMII_LANE2	0x0
-#define J784S4_SERDES1_LANE3_PCIE0_LANE3	0x1
-#define J784S4_SERDES1_LANE3_PCIE2_LANE1	0x2
-#define J784S4_SERDES1_LANE3_IP4_UNUSED		0x3
-
-#define J784S4_SERDES2_LANE0_QSGMII_LANE5	0x0
-#define J784S4_SERDES2_LANE0_IP2_UNUSED		0x1
-#define J784S4_SERDES2_LANE0_IP3_UNUSED		0x2
-#define J784S4_SERDES2_LANE0_IP4_UNUSED		0x3
-
-#define J784S4_SERDES2_LANE1_QSGMII_LANE6	0x0
-#define J784S4_SERDES2_LANE1_IP2_UNUSED		0x1
-#define J784S4_SERDES2_LANE1_IP3_UNUSED		0x2
-#define J784S4_SERDES2_LANE1_IP4_UNUSED		0x3
-
-#define J784S4_SERDES2_LANE2_QSGMII_LANE7	0x0
-#define J784S4_SERDES2_LANE2_QSGMII_LANE1	0x1
-#define J784S4_SERDES2_LANE2_IP3_UNUSED		0x2
-#define J784S4_SERDES2_LANE2_IP4_UNUSED		0x3
-
-#define J784S4_SERDES2_LANE3_QSGMII_LANE8	0x0
-#define J784S4_SERDES2_LANE3_QSGMII_LANE2	0x1
-#define J784S4_SERDES2_LANE3_IP3_UNUSED		0x2
-#define J784S4_SERDES2_LANE3_IP4_UNUSED		0x3
-
-#endif /* _DT_BINDINGS_MUX_TI_SERDES */
diff --git a/include/dt-bindings/pinctrl/mt6397-pinfunc.h b/include/dt-bindings/pinctrl/mt6397-pinfunc.h
deleted file mode 100644
index f393fbd68905..000000000000
--- a/include/dt-bindings/pinctrl/mt6397-pinfunc.h
+++ /dev/null
@@ -1,257 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-#ifndef __DTS_MT6397_PINFUNC_H
-#define __DTS_MT6397_PINFUNC_H
-
-#include <dt-bindings/pinctrl/mt65xx.h>
-
-#define MT6397_PIN_0_INT__FUNC_GPIO0 (MTK_PIN_NO(0) | 0)
-#define MT6397_PIN_0_INT__FUNC_INT (MTK_PIN_NO(0) | 1)
-
-#define MT6397_PIN_1_SRCVOLTEN__FUNC_GPIO1 (MTK_PIN_NO(1) | 0)
-#define MT6397_PIN_1_SRCVOLTEN__FUNC_SRCVOLTEN (MTK_PIN_NO(1) | 1)
-#define MT6397_PIN_1_SRCVOLTEN__FUNC_TEST_CK1 (MTK_PIN_NO(1) | 6)
-
-#define MT6397_PIN_2_SRCLKEN_PERI__FUNC_GPIO2 (MTK_PIN_NO(2) | 0)
-#define MT6397_PIN_2_SRCLKEN_PERI__FUNC_SRCLKEN_PERI (MTK_PIN_NO(2) | 1)
-#define MT6397_PIN_2_SRCLKEN_PERI__FUNC_TEST_CK2 (MTK_PIN_NO(2) | 6)
-
-#define MT6397_PIN_3_RTC_32K1V8__FUNC_GPIO3 (MTK_PIN_NO(3) | 0)
-#define MT6397_PIN_3_RTC_32K1V8__FUNC_RTC_32K1V8 (MTK_PIN_NO(3) | 1)
-#define MT6397_PIN_3_RTC_32K1V8__FUNC_TEST_CK3 (MTK_PIN_NO(3) | 6)
-
-#define MT6397_PIN_4_WRAP_EVENT__FUNC_GPIO4 (MTK_PIN_NO(4) | 0)
-#define MT6397_PIN_4_WRAP_EVENT__FUNC_WRAP_EVENT (MTK_PIN_NO(4) | 1)
-
-#define MT6397_PIN_5_SPI_CLK__FUNC_GPIO5 (MTK_PIN_NO(5) | 0)
-#define MT6397_PIN_5_SPI_CLK__FUNC_SPI_CLK (MTK_PIN_NO(5) | 1)
-
-#define MT6397_PIN_6_SPI_CSN__FUNC_GPIO6 (MTK_PIN_NO(6) | 0)
-#define MT6397_PIN_6_SPI_CSN__FUNC_SPI_CSN (MTK_PIN_NO(6) | 1)
-
-#define MT6397_PIN_7_SPI_MOSI__FUNC_GPIO7 (MTK_PIN_NO(7) | 0)
-#define MT6397_PIN_7_SPI_MOSI__FUNC_SPI_MOSI (MTK_PIN_NO(7) | 1)
-
-#define MT6397_PIN_8_SPI_MISO__FUNC_GPIO8 (MTK_PIN_NO(8) | 0)
-#define MT6397_PIN_8_SPI_MISO__FUNC_SPI_MISO (MTK_PIN_NO(8) | 1)
-
-#define MT6397_PIN_9_AUD_CLK_MOSI__FUNC_GPIO9 (MTK_PIN_NO(9) | 0)
-#define MT6397_PIN_9_AUD_CLK_MOSI__FUNC_AUD_CLK (MTK_PIN_NO(9) | 1)
-#define MT6397_PIN_9_AUD_CLK_MOSI__FUNC_TEST_IN0 (MTK_PIN_NO(9) | 6)
-#define MT6397_PIN_9_AUD_CLK_MOSI__FUNC_TEST_OUT0 (MTK_PIN_NO(9) | 7)
-
-#define MT6397_PIN_10_AUD_DAT_MISO__FUNC_GPIO10 (MTK_PIN_NO(10) | 0)
-#define MT6397_PIN_10_AUD_DAT_MISO__FUNC_AUD_MISO (MTK_PIN_NO(10) | 1)
-#define MT6397_PIN_10_AUD_DAT_MISO__FUNC_TEST_IN1 (MTK_PIN_NO(10) | 6)
-#define MT6397_PIN_10_AUD_DAT_MISO__FUNC_TEST_OUT1 (MTK_PIN_NO(10) | 7)
-
-#define MT6397_PIN_11_AUD_DAT_MOSI__FUNC_GPIO11 (MTK_PIN_NO(11) | 0)
-#define MT6397_PIN_11_AUD_DAT_MOSI__FUNC_AUD_MOSI (MTK_PIN_NO(11) | 1)
-#define MT6397_PIN_11_AUD_DAT_MOSI__FUNC_TEST_IN2 (MTK_PIN_NO(11) | 6)
-#define MT6397_PIN_11_AUD_DAT_MOSI__FUNC_TEST_OUT2 (MTK_PIN_NO(11) | 7)
-
-#define MT6397_PIN_12_COL0__FUNC_GPIO12 (MTK_PIN_NO(12) | 0)
-#define MT6397_PIN_12_COL0__FUNC_COL0_USBDL (MTK_PIN_NO(12) | 1)
-#define MT6397_PIN_12_COL0__FUNC_EINT10_1X (MTK_PIN_NO(12) | 2)
-#define MT6397_PIN_12_COL0__FUNC_PWM1_3X (MTK_PIN_NO(12) | 3)
-#define MT6397_PIN_12_COL0__FUNC_TEST_IN3 (MTK_PIN_NO(12) | 6)
-#define MT6397_PIN_12_COL0__FUNC_TEST_OUT3 (MTK_PIN_NO(12) | 7)
-
-#define MT6397_PIN_13_COL1__FUNC_GPIO13 (MTK_PIN_NO(13) | 0)
-#define MT6397_PIN_13_COL1__FUNC_COL1 (MTK_PIN_NO(13) | 1)
-#define MT6397_PIN_13_COL1__FUNC_EINT11_1X (MTK_PIN_NO(13) | 2)
-#define MT6397_PIN_13_COL1__FUNC_SCL0_2X (MTK_PIN_NO(13) | 3)
-#define MT6397_PIN_13_COL1__FUNC_TEST_IN4 (MTK_PIN_NO(13) | 6)
-#define MT6397_PIN_13_COL1__FUNC_TEST_OUT4 (MTK_PIN_NO(13) | 7)
-
-#define MT6397_PIN_14_COL2__FUNC_GPIO14 (MTK_PIN_NO(14) | 0)
-#define MT6397_PIN_14_COL2__FUNC_COL2 (MTK_PIN_NO(14) | 1)
-#define MT6397_PIN_14_COL2__FUNC_EINT12_1X (MTK_PIN_NO(14) | 2)
-#define MT6397_PIN_14_COL2__FUNC_SDA0_2X (MTK_PIN_NO(14) | 3)
-#define MT6397_PIN_14_COL2__FUNC_TEST_IN5 (MTK_PIN_NO(14) | 6)
-#define MT6397_PIN_14_COL2__FUNC_TEST_OUT5 (MTK_PIN_NO(14) | 7)
-
-#define MT6397_PIN_15_COL3__FUNC_GPIO15 (MTK_PIN_NO(15) | 0)
-#define MT6397_PIN_15_COL3__FUNC_COL3 (MTK_PIN_NO(15) | 1)
-#define MT6397_PIN_15_COL3__FUNC_EINT13_1X (MTK_PIN_NO(15) | 2)
-#define MT6397_PIN_15_COL3__FUNC_SCL1_2X (MTK_PIN_NO(15) | 3)
-#define MT6397_PIN_15_COL3__FUNC_TEST_IN6 (MTK_PIN_NO(15) | 6)
-#define MT6397_PIN_15_COL3__FUNC_TEST_OUT6 (MTK_PIN_NO(15) | 7)
-
-#define MT6397_PIN_16_COL4__FUNC_GPIO16 (MTK_PIN_NO(16) | 0)
-#define MT6397_PIN_16_COL4__FUNC_COL4 (MTK_PIN_NO(16) | 1)
-#define MT6397_PIN_16_COL4__FUNC_EINT14_1X (MTK_PIN_NO(16) | 2)
-#define MT6397_PIN_16_COL4__FUNC_SDA1_2X (MTK_PIN_NO(16) | 3)
-#define MT6397_PIN_16_COL4__FUNC_TEST_IN7 (MTK_PIN_NO(16) | 6)
-#define MT6397_PIN_16_COL4__FUNC_TEST_OUT7 (MTK_PIN_NO(16) | 7)
-
-#define MT6397_PIN_17_COL5__FUNC_GPIO17 (MTK_PIN_NO(17) | 0)
-#define MT6397_PIN_17_COL5__FUNC_COL5 (MTK_PIN_NO(17) | 1)
-#define MT6397_PIN_17_COL5__FUNC_EINT15_1X (MTK_PIN_NO(17) | 2)
-#define MT6397_PIN_17_COL5__FUNC_SCL2_2X (MTK_PIN_NO(17) | 3)
-#define MT6397_PIN_17_COL5__FUNC_TEST_IN8 (MTK_PIN_NO(17) | 6)
-#define MT6397_PIN_17_COL5__FUNC_TEST_OUT8 (MTK_PIN_NO(17) | 7)
-
-#define MT6397_PIN_18_COL6__FUNC_GPIO18 (MTK_PIN_NO(18) | 0)
-#define MT6397_PIN_18_COL6__FUNC_COL6 (MTK_PIN_NO(18) | 1)
-#define MT6397_PIN_18_COL6__FUNC_EINT16_1X (MTK_PIN_NO(18) | 2)
-#define MT6397_PIN_18_COL6__FUNC_SDA2_2X (MTK_PIN_NO(18) | 3)
-#define MT6397_PIN_18_COL6__FUNC_GPIO32K_0 (MTK_PIN_NO(18) | 4)
-#define MT6397_PIN_18_COL6__FUNC_GPIO26M_0 (MTK_PIN_NO(18) | 5)
-#define MT6397_PIN_18_COL6__FUNC_TEST_IN9 (MTK_PIN_NO(18) | 6)
-#define MT6397_PIN_18_COL6__FUNC_TEST_OUT9 (MTK_PIN_NO(18) | 7)
-
-#define MT6397_PIN_19_COL7__FUNC_GPIO19 (MTK_PIN_NO(19) | 0)
-#define MT6397_PIN_19_COL7__FUNC_COL7 (MTK_PIN_NO(19) | 1)
-#define MT6397_PIN_19_COL7__FUNC_EINT17_1X (MTK_PIN_NO(19) | 2)
-#define MT6397_PIN_19_COL7__FUNC_PWM2_3X (MTK_PIN_NO(19) | 3)
-#define MT6397_PIN_19_COL7__FUNC_GPIO32K_1 (MTK_PIN_NO(19) | 4)
-#define MT6397_PIN_19_COL7__FUNC_GPIO26M_1 (MTK_PIN_NO(19) | 5)
-#define MT6397_PIN_19_COL7__FUNC_TEST_IN10 (MTK_PIN_NO(19) | 6)
-#define MT6397_PIN_19_COL7__FUNC_TEST_OUT10 (MTK_PIN_NO(19) | 7)
-
-#define MT6397_PIN_20_ROW0__FUNC_GPIO20 (MTK_PIN_NO(20) | 0)
-#define MT6397_PIN_20_ROW0__FUNC_ROW0 (MTK_PIN_NO(20) | 1)
-#define MT6397_PIN_20_ROW0__FUNC_EINT18_1X (MTK_PIN_NO(20) | 2)
-#define MT6397_PIN_20_ROW0__FUNC_SCL0_3X (MTK_PIN_NO(20) | 3)
-#define MT6397_PIN_20_ROW0__FUNC_TEST_IN11 (MTK_PIN_NO(20) | 6)
-#define MT6397_PIN_20_ROW0__FUNC_TEST_OUT11 (MTK_PIN_NO(20) | 7)
-
-#define MT6397_PIN_21_ROW1__FUNC_GPIO21 (MTK_PIN_NO(21) | 0)
-#define MT6397_PIN_21_ROW1__FUNC_ROW1 (MTK_PIN_NO(21) | 1)
-#define MT6397_PIN_21_ROW1__FUNC_EINT19_1X (MTK_PIN_NO(21) | 2)
-#define MT6397_PIN_21_ROW1__FUNC_SDA0_3X (MTK_PIN_NO(21) | 3)
-#define MT6397_PIN_21_ROW1__FUNC_AUD_TSTCK (MTK_PIN_NO(21) | 4)
-#define MT6397_PIN_21_ROW1__FUNC_TEST_IN12 (MTK_PIN_NO(21) | 6)
-#define MT6397_PIN_21_ROW1__FUNC_TEST_OUT12 (MTK_PIN_NO(21) | 7)
-
-#define MT6397_PIN_22_ROW2__FUNC_GPIO22 (MTK_PIN_NO(22) | 0)
-#define MT6397_PIN_22_ROW2__FUNC_ROW2 (MTK_PIN_NO(22) | 1)
-#define MT6397_PIN_22_ROW2__FUNC_EINT20_1X (MTK_PIN_NO(22) | 2)
-#define MT6397_PIN_22_ROW2__FUNC_SCL1_3X (MTK_PIN_NO(22) | 3)
-#define MT6397_PIN_22_ROW2__FUNC_TEST_IN13 (MTK_PIN_NO(22) | 6)
-#define MT6397_PIN_22_ROW2__FUNC_TEST_OUT13 (MTK_PIN_NO(22) | 7)
-
-#define MT6397_PIN_23_ROW3__FUNC_GPIO23 (MTK_PIN_NO(23) | 0)
-#define MT6397_PIN_23_ROW3__FUNC_ROW3 (MTK_PIN_NO(23) | 1)
-#define MT6397_PIN_23_ROW3__FUNC_EINT21_1X (MTK_PIN_NO(23) | 2)
-#define MT6397_PIN_23_ROW3__FUNC_SDA1_3X (MTK_PIN_NO(23) | 3)
-#define MT6397_PIN_23_ROW3__FUNC_TEST_IN14 (MTK_PIN_NO(23) | 6)
-#define MT6397_PIN_23_ROW3__FUNC_TEST_OUT14 (MTK_PIN_NO(23) | 7)
-
-#define MT6397_PIN_24_ROW4__FUNC_GPIO24 (MTK_PIN_NO(24) | 0)
-#define MT6397_PIN_24_ROW4__FUNC_ROW4 (MTK_PIN_NO(24) | 1)
-#define MT6397_PIN_24_ROW4__FUNC_EINT22_1X (MTK_PIN_NO(24) | 2)
-#define MT6397_PIN_24_ROW4__FUNC_SCL2_3X (MTK_PIN_NO(24) | 3)
-#define MT6397_PIN_24_ROW4__FUNC_TEST_IN15 (MTK_PIN_NO(24) | 6)
-#define MT6397_PIN_24_ROW4__FUNC_TEST_OUT15 (MTK_PIN_NO(24) | 7)
-
-#define MT6397_PIN_25_ROW5__FUNC_GPIO25 (MTK_PIN_NO(25) | 0)
-#define MT6397_PIN_25_ROW5__FUNC_ROW5 (MTK_PIN_NO(25) | 1)
-#define MT6397_PIN_25_ROW5__FUNC_EINT23_1X (MTK_PIN_NO(25) | 2)
-#define MT6397_PIN_25_ROW5__FUNC_SDA2_3X (MTK_PIN_NO(25) | 3)
-#define MT6397_PIN_25_ROW5__FUNC_TEST_IN16 (MTK_PIN_NO(25) | 6)
-#define MT6397_PIN_25_ROW5__FUNC_TEST_OUT16 (MTK_PIN_NO(25) | 7)
-
-#define MT6397_PIN_26_ROW6__FUNC_GPIO26 (MTK_PIN_NO(26) | 0)
-#define MT6397_PIN_26_ROW6__FUNC_ROW6 (MTK_PIN_NO(26) | 1)
-#define MT6397_PIN_26_ROW6__FUNC_EINT24_1X (MTK_PIN_NO(26) | 2)
-#define MT6397_PIN_26_ROW6__FUNC_PWM3_3X (MTK_PIN_NO(26) | 3)
-#define MT6397_PIN_26_ROW6__FUNC_GPIO32K_2 (MTK_PIN_NO(26) | 4)
-#define MT6397_PIN_26_ROW6__FUNC_GPIO26M_2 (MTK_PIN_NO(26) | 5)
-#define MT6397_PIN_26_ROW6__FUNC_TEST_IN17 (MTK_PIN_NO(26) | 6)
-#define MT6397_PIN_26_ROW6__FUNC_TEST_OUT17 (MTK_PIN_NO(26) | 7)
-
-#define MT6397_PIN_27_ROW7__FUNC_GPIO27 (MTK_PIN_NO(27) | 0)
-#define MT6397_PIN_27_ROW7__FUNC_ROW7 (MTK_PIN_NO(27) | 1)
-#define MT6397_PIN_27_ROW7__FUNC_EINT3_1X (MTK_PIN_NO(27) | 2)
-#define MT6397_PIN_27_ROW7__FUNC_CBUS (MTK_PIN_NO(27) | 3)
-#define MT6397_PIN_27_ROW7__FUNC_GPIO32K_3 (MTK_PIN_NO(27) | 4)
-#define MT6397_PIN_27_ROW7__FUNC_GPIO26M_3 (MTK_PIN_NO(27) | 5)
-#define MT6397_PIN_27_ROW7__FUNC_TEST_IN18 (MTK_PIN_NO(27) | 6)
-#define MT6397_PIN_27_ROW7__FUNC_TEST_OUT18 (MTK_PIN_NO(27) | 7)
-
-#define MT6397_PIN_28_PWM1__FUNC_GPIO28 (MTK_PIN_NO(28) | 0)
-#define MT6397_PIN_28_PWM1__FUNC_PWM1 (MTK_PIN_NO(28) | 1)
-#define MT6397_PIN_28_PWM1__FUNC_EINT4_1X (MTK_PIN_NO(28) | 2)
-#define MT6397_PIN_28_PWM1__FUNC_GPIO32K_4 (MTK_PIN_NO(28) | 4)
-#define MT6397_PIN_28_PWM1__FUNC_GPIO26M_4 (MTK_PIN_NO(28) | 5)
-#define MT6397_PIN_28_PWM1__FUNC_TEST_IN19 (MTK_PIN_NO(28) | 6)
-#define MT6397_PIN_28_PWM1__FUNC_TEST_OUT19 (MTK_PIN_NO(28) | 7)
-
-#define MT6397_PIN_29_PWM2__FUNC_GPIO29 (MTK_PIN_NO(29) | 0)
-#define MT6397_PIN_29_PWM2__FUNC_PWM2 (MTK_PIN_NO(29) | 1)
-#define MT6397_PIN_29_PWM2__FUNC_EINT5_1X (MTK_PIN_NO(29) | 2)
-#define MT6397_PIN_29_PWM2__FUNC_GPIO32K_5 (MTK_PIN_NO(29) | 4)
-#define MT6397_PIN_29_PWM2__FUNC_GPIO26M_5 (MTK_PIN_NO(29) | 5)
-#define MT6397_PIN_29_PWM2__FUNC_TEST_IN20 (MTK_PIN_NO(29) | 6)
-#define MT6397_PIN_29_PWM2__FUNC_TEST_OUT20 (MTK_PIN_NO(29) | 7)
-
-#define MT6397_PIN_30_PWM3__FUNC_GPIO30 (MTK_PIN_NO(30) | 0)
-#define MT6397_PIN_30_PWM3__FUNC_PWM3 (MTK_PIN_NO(30) | 1)
-#define MT6397_PIN_30_PWM3__FUNC_EINT6_1X (MTK_PIN_NO(30) | 2)
-#define MT6397_PIN_30_PWM3__FUNC_COL0 (MTK_PIN_NO(30) | 3)
-#define MT6397_PIN_30_PWM3__FUNC_GPIO32K_6 (MTK_PIN_NO(30) | 4)
-#define MT6397_PIN_30_PWM3__FUNC_GPIO26M_6 (MTK_PIN_NO(30) | 5)
-#define MT6397_PIN_30_PWM3__FUNC_TEST_IN21 (MTK_PIN_NO(30) | 6)
-#define MT6397_PIN_30_PWM3__FUNC_TEST_OUT21 (MTK_PIN_NO(30) | 7)
-
-#define MT6397_PIN_31_SCL0__FUNC_GPIO31 (MTK_PIN_NO(31) | 0)
-#define MT6397_PIN_31_SCL0__FUNC_SCL0 (MTK_PIN_NO(31) | 1)
-#define MT6397_PIN_31_SCL0__FUNC_EINT7_1X (MTK_PIN_NO(31) | 2)
-#define MT6397_PIN_31_SCL0__FUNC_PWM1_2X (MTK_PIN_NO(31) | 3)
-#define MT6397_PIN_31_SCL0__FUNC_TEST_IN22 (MTK_PIN_NO(31) | 6)
-#define MT6397_PIN_31_SCL0__FUNC_TEST_OUT22 (MTK_PIN_NO(31) | 7)
-
-#define MT6397_PIN_32_SDA0__FUNC_GPIO32 (MTK_PIN_NO(32) | 0)
-#define MT6397_PIN_32_SDA0__FUNC_SDA0 (MTK_PIN_NO(32) | 1)
-#define MT6397_PIN_32_SDA0__FUNC_EINT8_1X (MTK_PIN_NO(32) | 2)
-#define MT6397_PIN_32_SDA0__FUNC_TEST_IN23 (MTK_PIN_NO(32) | 6)
-#define MT6397_PIN_32_SDA0__FUNC_TEST_OUT23 (MTK_PIN_NO(32) | 7)
-
-#define MT6397_PIN_33_SCL1__FUNC_GPIO33 (MTK_PIN_NO(33) | 0)
-#define MT6397_PIN_33_SCL1__FUNC_SCL1 (MTK_PIN_NO(33) | 1)
-#define MT6397_PIN_33_SCL1__FUNC_EINT9_1X (MTK_PIN_NO(33) | 2)
-#define MT6397_PIN_33_SCL1__FUNC_PWM2_2X (MTK_PIN_NO(33) | 3)
-#define MT6397_PIN_33_SCL1__FUNC_TEST_IN24 (MTK_PIN_NO(33) | 6)
-#define MT6397_PIN_33_SCL1__FUNC_TEST_OUT24 (MTK_PIN_NO(33) | 7)
-
-#define MT6397_PIN_34_SDA1__FUNC_GPIO34 (MTK_PIN_NO(34) | 0)
-#define MT6397_PIN_34_SDA1__FUNC_SDA1 (MTK_PIN_NO(34) | 1)
-#define MT6397_PIN_34_SDA1__FUNC_EINT0_1X (MTK_PIN_NO(34) | 2)
-#define MT6397_PIN_34_SDA1__FUNC_TEST_IN25 (MTK_PIN_NO(34) | 6)
-#define MT6397_PIN_34_SDA1__FUNC_TEST_OUT25 (MTK_PIN_NO(34) | 7)
-
-#define MT6397_PIN_35_SCL2__FUNC_GPIO35 (MTK_PIN_NO(35) | 0)
-#define MT6397_PIN_35_SCL2__FUNC_SCL2 (MTK_PIN_NO(35) | 1)
-#define MT6397_PIN_35_SCL2__FUNC_EINT1_1X (MTK_PIN_NO(35) | 2)
-#define MT6397_PIN_35_SCL2__FUNC_PWM3_2X (MTK_PIN_NO(35) | 3)
-#define MT6397_PIN_35_SCL2__FUNC_TEST_IN26 (MTK_PIN_NO(35) | 6)
-#define MT6397_PIN_35_SCL2__FUNC_TEST_OUT26 (MTK_PIN_NO(35) | 7)
-
-#define MT6397_PIN_36_SDA2__FUNC_GPIO36 (MTK_PIN_NO(36) | 0)
-#define MT6397_PIN_36_SDA2__FUNC_SDA2 (MTK_PIN_NO(36) | 1)
-#define MT6397_PIN_36_SDA2__FUNC_EINT2_1X (MTK_PIN_NO(36) | 2)
-#define MT6397_PIN_36_SDA2__FUNC_TEST_IN27 (MTK_PIN_NO(36) | 6)
-#define MT6397_PIN_36_SDA2__FUNC_TEST_OUT27 (MTK_PIN_NO(36) | 7)
-
-#define MT6397_PIN_37_HDMISD__FUNC_GPIO37 (MTK_PIN_NO(37) | 0)
-#define MT6397_PIN_37_HDMISD__FUNC_HDMISD (MTK_PIN_NO(37) | 1)
-#define MT6397_PIN_37_HDMISD__FUNC_TEST_IN28 (MTK_PIN_NO(37) | 6)
-#define MT6397_PIN_37_HDMISD__FUNC_TEST_OUT28 (MTK_PIN_NO(37) | 7)
-
-#define MT6397_PIN_38_HDMISCK__FUNC_GPIO38 (MTK_PIN_NO(38) | 0)
-#define MT6397_PIN_38_HDMISCK__FUNC_HDMISCK (MTK_PIN_NO(38) | 1)
-#define MT6397_PIN_38_HDMISCK__FUNC_TEST_IN29 (MTK_PIN_NO(38) | 6)
-#define MT6397_PIN_38_HDMISCK__FUNC_TEST_OUT29 (MTK_PIN_NO(38) | 7)
-
-#define MT6397_PIN_39_HTPLG__FUNC_GPIO39 (MTK_PIN_NO(39) | 0)
-#define MT6397_PIN_39_HTPLG__FUNC_HTPLG (MTK_PIN_NO(39) | 1)
-#define MT6397_PIN_39_HTPLG__FUNC_TEST_IN30 (MTK_PIN_NO(39) | 6)
-#define MT6397_PIN_39_HTPLG__FUNC_TEST_OUT30 (MTK_PIN_NO(39) | 7)
-
-#define MT6397_PIN_40_CEC__FUNC_GPIO40 (MTK_PIN_NO(40) | 0)
-#define MT6397_PIN_40_CEC__FUNC_CEC (MTK_PIN_NO(40) | 1)
-#define MT6397_PIN_40_CEC__FUNC_TEST_IN31 (MTK_PIN_NO(40) | 6)
-#define MT6397_PIN_40_CEC__FUNC_TEST_OUT31 (MTK_PIN_NO(40) | 7)
-
-#endif /* __DTS_MT6397_PINFUNC_H */
diff --git a/include/dt-bindings/power/allwinner,sun20i-d1-ppu.h b/include/dt-bindings/power/allwinner,sun20i-d1-ppu.h
deleted file mode 100644
index 23cfb57256d6..000000000000
--- a/include/dt-bindings/power/allwinner,sun20i-d1-ppu.h
+++ /dev/null
@@ -1,10 +0,0 @@
-/* SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause) */
-
-#ifndef _DT_BINDINGS_POWER_SUN20I_D1_PPU_H_
-#define _DT_BINDINGS_POWER_SUN20I_D1_PPU_H_
-
-#define PD_CPU			0
-#define PD_VE			1
-#define PD_DSP			2
-
-#endif /* _DT_BINDINGS_POWER_SUN20I_D1_PPU_H_ */
diff --git a/include/dt-bindings/reset/bcm6318-reset.h b/include/dt-bindings/reset/bcm6318-reset.h
deleted file mode 100644
index f882662505ea..000000000000
--- a/include/dt-bindings/reset/bcm6318-reset.h
+++ /dev/null
@@ -1,20 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0+ */
-
-#ifndef __DT_BINDINGS_RESET_BCM6318_H
-#define __DT_BINDINGS_RESET_BCM6318_H
-
-#define BCM6318_RST_SPI		0
-#define BCM6318_RST_EPHY	1
-#define BCM6318_RST_SAR		2
-#define BCM6318_RST_ENETSW	3
-#define BCM6318_RST_USBD	4
-#define BCM6318_RST_USBH	5
-#define BCM6318_RST_PCIE_CORE	6
-#define BCM6318_RST_PCIE	7
-#define BCM6318_RST_PCIE_EXT	8
-#define BCM6318_RST_PCIE_HARD	9
-#define BCM6318_RST_ADSL	10
-#define BCM6318_RST_PHYMIPS	11
-#define BCM6318_RST_HOSTMIPS	12
-
-#endif /* __DT_BINDINGS_RESET_BCM6318_H */
diff --git a/include/dt-bindings/reset/imx8ulp-pcc-reset.h b/include/dt-bindings/reset/imx8ulp-pcc-reset.h
deleted file mode 100644
index e99a4735c3c4..000000000000
--- a/include/dt-bindings/reset/imx8ulp-pcc-reset.h
+++ /dev/null
@@ -1,59 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0-only */
-/*
- * Copyright 2021 NXP
- */
-
-#ifndef DT_BINDING_PCC_RESET_IMX8ULP_H
-#define DT_BINDING_PCC_RESET_IMX8ULP_H
-
-/* PCC3 */
-#define PCC3_WDOG3_SWRST	0
-#define PCC3_WDOG4_SWRST	1
-#define PCC3_LPIT1_SWRST	2
-#define PCC3_TPM4_SWRST		3
-#define PCC3_TPM5_SWRST		4
-#define PCC3_FLEXIO1_SWRST	5
-#define PCC3_I3C2_SWRST		6
-#define PCC3_LPI2C4_SWRST	7
-#define PCC3_LPI2C5_SWRST	8
-#define PCC3_LPUART4_SWRST	9
-#define PCC3_LPUART5_SWRST	10
-#define PCC3_LPSPI4_SWRST	11
-#define PCC3_LPSPI5_SWRST	12
-
-/* PCC4 */
-#define PCC4_FLEXSPI2_SWRST	0
-#define PCC4_TPM6_SWRST		1
-#define PCC4_TPM7_SWRST		2
-#define PCC4_LPI2C6_SWRST	3
-#define PCC4_LPI2C7_SWRST	4
-#define PCC4_LPUART6_SWRST	5
-#define PCC4_LPUART7_SWRST	6
-#define PCC4_SAI4_SWRST		7
-#define PCC4_SAI5_SWRST		8
-#define PCC4_USDHC0_SWRST	9
-#define PCC4_USDHC1_SWRST	10
-#define PCC4_USDHC2_SWRST	11
-#define PCC4_USB0_SWRST		12
-#define PCC4_USB0_PHY_SWRST	13
-#define PCC4_USB1_SWRST		14
-#define PCC4_USB1_PHY_SWRST	15
-#define PCC4_ENET_SWRST		16
-
-/* PCC5 */
-#define PCC5_TPM8_SWRST		0
-#define PCC5_SAI6_SWRST		1
-#define PCC5_SAI7_SWRST		2
-#define PCC5_SPDIF_SWRST	3
-#define PCC5_ISI_SWRST		4
-#define PCC5_CSI_REGS_SWRST	5
-#define PCC5_CSI_SWRST		6
-#define PCC5_DSI_SWRST		7
-#define PCC5_WDOG5_SWRST	8
-#define PCC5_EPDC_SWRST		9
-#define PCC5_PXP_SWRST		10
-#define PCC5_GPU2D_SWRST	11
-#define PCC5_GPU3D_SWRST	12
-#define PCC5_DC_NANO_SWRST	13
-
-#endif /*DT_BINDING_RESET_IMX8ULP_H */
diff --git a/include/dt-bindings/reset/oxsemi,ox810se.h b/include/dt-bindings/reset/oxsemi,ox810se.h
deleted file mode 100644
index e943187e6527..000000000000
--- a/include/dt-bindings/reset/oxsemi,ox810se.h
+++ /dev/null
@@ -1,42 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0-only */
-/*
- * Copyright (C) 2016 Neil Armstrong <narmstrong@baylibre.com>
- */
-
-#ifndef DT_RESET_OXSEMI_OX810SE_H
-#define DT_RESET_OXSEMI_OX810SE_H
-
-#define RESET_ARM	0
-#define RESET_COPRO	1
-/* Reserved		2 */
-/* Reserved		3 */
-#define RESET_USBHS	4
-#define RESET_USBHSPHY	5
-#define RESET_MAC	6
-#define RESET_PCI	7
-#define RESET_DMA	8
-#define RESET_DPE	9
-#define RESET_DDR	10
-#define RESET_SATA	11
-#define RESET_SATA_LINK	12
-#define RESET_SATA_PHY	13
- /* Reserved		14 */
-#define RESET_NAND	15
-#define RESET_GPIO	16
-#define RESET_UART1	17
-#define RESET_UART2	18
-#define RESET_MISC	19
-#define RESET_I2S	20
-#define RESET_AHB_MON	21
-#define RESET_UART3	22
-#define RESET_UART4	23
-#define RESET_SGDMA	24
-/* Reserved		25 */
-/* Reserved		26 */
-/* Reserved		27 */
-/* Reserved		28 */
-/* Reserved		29 */
-/* Reserved		30 */
-#define RESET_BUS	31
-
-#endif /* DT_RESET_OXSEMI_OX810SE_H */
diff --git a/include/dt-bindings/reset/oxsemi,ox820.h b/include/dt-bindings/reset/oxsemi,ox820.h
deleted file mode 100644
index 54b58e09c1c0..000000000000
--- a/include/dt-bindings/reset/oxsemi,ox820.h
+++ /dev/null
@@ -1,42 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0-only */
-/*
- * Copyright (C) 2016 Neil Armstrong <narmstrong@baylibre.com>
- */
-
-#ifndef DT_RESET_OXSEMI_OX820_H
-#define DT_RESET_OXSEMI_OX820_H
-
-#define RESET_SCU	0
-#define RESET_LEON	1
-#define RESET_ARM0	2
-#define RESET_ARM1	3
-#define RESET_USBHS	4
-#define RESET_USBPHYA	5
-#define RESET_MAC	6
-#define RESET_PCIEA	7
-#define RESET_SGDMA	8
-#define RESET_CIPHER	9
-#define RESET_DDR	10
-#define RESET_SATA	11
-#define RESET_SATA_LINK	12
-#define RESET_SATA_PHY	13
-#define RESET_PCIEPHY	14
-#define RESET_NAND	15
-#define RESET_GPIO	16
-#define RESET_UART1	17
-#define RESET_UART2	18
-#define RESET_MISC	19
-#define RESET_I2S	20
-#define RESET_SD	21
-#define RESET_MAC_2	22
-#define RESET_PCIEB	23
-#define RESET_VIDEO	24
-#define RESET_DDR_PHY	25
-#define RESET_USBPHYB	26
-#define RESET_USBDEV	27
-/* Reserved		29 */
-#define RESET_ARMDBG	29
-#define RESET_PLLA	30
-#define RESET_PLLB	31
-
-#endif /* DT_RESET_OXSEMI_OX820_H */
diff --git a/include/dt-bindings/sound/audio-jack-events.h b/include/dt-bindings/sound/audio-jack-events.h
deleted file mode 100644
index 1b29b295126a..000000000000
--- a/include/dt-bindings/sound/audio-jack-events.h
+++ /dev/null
@@ -1,10 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-#ifndef __AUDIO_JACK_EVENTS_H
-#define __AUDIO_JACK_EVENTS_H
-
-#define JACK_HEADPHONE		1
-#define JACK_MICROPHONE		2
-#define JACK_LINEOUT		3
-#define JACK_LINEIN		4
-
-#endif /* __AUDIO_JACK_EVENTS_H */
-- 
2.51.0


