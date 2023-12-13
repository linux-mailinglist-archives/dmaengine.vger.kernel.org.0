Return-Path: <dmaengine+bounces-508-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 870EB810C21
	for <lists+dmaengine@lfdr.de>; Wed, 13 Dec 2023 09:13:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0706C1F210AB
	for <lists+dmaengine@lfdr.de>; Wed, 13 Dec 2023 08:13:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 333E11CF94;
	Wed, 13 Dec 2023 08:13:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="OUYCerCp"
X-Original-To: dmaengine@vger.kernel.org
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02B84DC;
	Wed, 13 Dec 2023 00:13:30 -0800 (PST)
Received: from lelv0266.itg.ti.com ([10.180.67.225])
	by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 3BD8DKG5005768;
	Wed, 13 Dec 2023 02:13:20 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1702455200;
	bh=hAbFxcZUa/lCbBdI2WQlGWfmp3gC7PIy2nXSIHx33Z0=;
	h=From:To:CC:Subject:Date;
	b=OUYCerCp0MuQl7yg5ceG1Al1MgBNasBuk3tdVCeLxOL+3Ts7q+AZS26iSVfnVUGu5
	 08WW0bIC+WlIzqcIq2LfWy8vyUNcI3q6u3ADM1vbWWm2qzkqAfJIDuhqQzWQktBrhX
	 YQBm/cwJeOuyo2S8STuIbE7JkxVXZ0s0BqcTd0i4=
Received: from DLEE105.ent.ti.com (dlee105.ent.ti.com [157.170.170.35])
	by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 3BD8DKUS003492
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 13 Dec 2023 02:13:20 -0600
Received: from DLEE114.ent.ti.com (157.170.170.25) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 13
 Dec 2023 02:13:20 -0600
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 13 Dec 2023 02:13:20 -0600
Received: from localhost ([10.24.69.141])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 3BD8DJZR100788;
	Wed, 13 Dec 2023 02:13:19 -0600
From: Vaishnav Achath <vaishnav.a@ti.com>
To: <vkoul@kernel.org>, <peter.ujfalusi@gmail.com>,
        <dmaengine@vger.kernel.org>
CC: <linux-kernel@vger.kernel.org>, <bb@ti.com>, <vigneshr@ti.com>,
        <j-choudhary@ti.com>, <j-luthra@ti.com>, <u-kumar1@ti.com>,
        <vaishnav.a@ti.com>
Subject: [PATCH v2] dmaengine: ti: k3-udma: Add PSIL threads for AM62P and J722S
Date: Wed, 13 Dec 2023 13:43:18 +0530
Message-ID: <20231213081318.26203-1-vaishnav.a@ti.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

From: Vignesh Raghavendra <vigneshr@ti.com>

Add PSIL thread information and enable UDMA support for AM62P
and J722S SoC. J722S SoC family is a superset of AM62P, thus
common PSIL thread ID map is reused for both devices.

For those interested, more details about the SoC can be found
in the Technical Reference Manual here:
	AM62P - https://www.ti.com/lit/pdf/spruj83
	J722S -	https://www.ti.com/lit/zip/sprujb3

Signed-off-by: Vignesh Raghavendra <vigneshr@ti.com>
Signed-off-by: Bryan Brattlof <bb@ti.com>
Signed-off-by: Vaishnav Achath <vaishnav.a@ti.com>
---
V1: https://lore.kernel.org/all/20231212203655.3155565-2-bb@ti.com/
J722S Bootlog with DMA enabled : https://gist.github.com/vaishnavachath/46b56dab34dfea3a171d3ad266160780

V1->V2:
	* Add J722S support and additional CSI2RX channels
	* Update copyright year to 2023 and update commit message.

 drivers/dma/ti/Makefile        |   3 +-
 drivers/dma/ti/k3-psil-am62p.c | 325 +++++++++++++++++++++++++++++++++
 drivers/dma/ti/k3-psil-priv.h  |   1 +
 drivers/dma/ti/k3-psil.c       |   2 +
 drivers/dma/ti/k3-udma.c       |   2 +
 5 files changed, 332 insertions(+), 1 deletion(-)
 create mode 100644 drivers/dma/ti/k3-psil-am62p.c

diff --git a/drivers/dma/ti/Makefile b/drivers/dma/ti/Makefile
index acc950bf609c..d376c117cecf 100644
--- a/drivers/dma/ti/Makefile
+++ b/drivers/dma/ti/Makefile
@@ -12,6 +12,7 @@ k3-psil-lib-objs := k3-psil.o \
 		    k3-psil-j721s2.o \
 		    k3-psil-am62.o \
 		    k3-psil-am62a.o \
-		    k3-psil-j784s4.o
+		    k3-psil-j784s4.o \
+		    k3-psil-am62p.o
 obj-$(CONFIG_TI_K3_PSIL) += k3-psil-lib.o
 obj-$(CONFIG_TI_DMA_CROSSBAR) += dma-crossbar.o
diff --git a/drivers/dma/ti/k3-psil-am62p.c b/drivers/dma/ti/k3-psil-am62p.c
new file mode 100644
index 000000000000..0f338e16d971
--- /dev/null
+++ b/drivers/dma/ti/k3-psil-am62p.c
@@ -0,0 +1,325 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ *  Copyright (C) 2023 Texas Instruments Incorporated - https://www.ti.com
+ */
+
+#include <linux/kernel.h>
+
+#include "k3-psil-priv.h"
+
+#define PSIL_PDMA_XY_TR(x)					\
+	{							\
+		.thread_id = x,					\
+		.ep_config = {					\
+			.ep_type = PSIL_EP_PDMA_XY,		\
+			.mapped_channel_id = -1,		\
+			.default_flow_id = -1,			\
+		},						\
+	}
+
+#define PSIL_PDMA_XY_PKT(x)					\
+	{							\
+		.thread_id = x,					\
+		.ep_config = {					\
+			.ep_type = PSIL_EP_PDMA_XY,		\
+			.mapped_channel_id = -1,		\
+			.default_flow_id = -1,			\
+			.pkt_mode = 1,				\
+		},						\
+	}
+
+#define PSIL_ETHERNET(x, ch, flow_base, flow_cnt)		\
+	{							\
+		.thread_id = x,					\
+		.ep_config = {					\
+			.ep_type = PSIL_EP_NATIVE,		\
+			.pkt_mode = 1,				\
+			.needs_epib = 1,			\
+			.psd_size = 16,				\
+			.mapped_channel_id = ch,		\
+			.flow_start = flow_base,		\
+			.flow_num = flow_cnt,			\
+			.default_flow_id = flow_base,		\
+		},						\
+	}
+
+#define PSIL_SAUL(x, ch, flow_base, flow_cnt, default_flow, tx)	\
+	{							\
+		.thread_id = x,					\
+		.ep_config = {					\
+			.ep_type = PSIL_EP_NATIVE,		\
+			.pkt_mode = 1,				\
+			.needs_epib = 1,			\
+			.psd_size = 64,				\
+			.mapped_channel_id = ch,		\
+			.flow_start = flow_base,		\
+			.flow_num = flow_cnt,			\
+			.default_flow_id = default_flow,	\
+			.notdpkt = tx,				\
+		},						\
+	}
+
+#define PSIL_PDMA_MCASP(x)				\
+	{						\
+		.thread_id = x,				\
+		.ep_config = {				\
+			.ep_type = PSIL_EP_PDMA_XY,	\
+			.pdma_acc32 = 1,		\
+			.pdma_burst = 1,		\
+		},					\
+	}
+
+#define PSIL_CSI2RX(x)					\
+	{						\
+		.thread_id = x,				\
+		.ep_config = {				\
+			.ep_type = PSIL_EP_NATIVE,	\
+		},					\
+	}
+
+/* PSI-L source thread IDs, used for RX (DMA_DEV_TO_MEM) */
+static struct psil_ep am62p_src_ep_map[] = {
+	/* SAUL */
+	PSIL_SAUL(0x7504, 20, 35, 8, 35, 0),
+	PSIL_SAUL(0x7505, 21, 35, 8, 36, 0),
+	PSIL_SAUL(0x7506, 22, 43, 8, 43, 0),
+	PSIL_SAUL(0x7507, 23, 43, 8, 44, 0),
+	/* PDMA_MAIN0 - SPI0-2 */
+	PSIL_PDMA_XY_PKT(0x4300),
+	PSIL_PDMA_XY_PKT(0x4301),
+	PSIL_PDMA_XY_PKT(0x4302),
+	PSIL_PDMA_XY_PKT(0x4303),
+	PSIL_PDMA_XY_PKT(0x4304),
+	PSIL_PDMA_XY_PKT(0x4305),
+	PSIL_PDMA_XY_PKT(0x4306),
+	PSIL_PDMA_XY_PKT(0x4307),
+	PSIL_PDMA_XY_PKT(0x4308),
+	PSIL_PDMA_XY_PKT(0x4309),
+	PSIL_PDMA_XY_PKT(0x430a),
+	PSIL_PDMA_XY_PKT(0x430b),
+	/* PDMA_MAIN1 - UART0-6 */
+	PSIL_PDMA_XY_PKT(0x4400),
+	PSIL_PDMA_XY_PKT(0x4401),
+	PSIL_PDMA_XY_PKT(0x4402),
+	PSIL_PDMA_XY_PKT(0x4403),
+	PSIL_PDMA_XY_PKT(0x4404),
+	PSIL_PDMA_XY_PKT(0x4405),
+	PSIL_PDMA_XY_PKT(0x4406),
+	/* PDMA_MAIN2 - MCASP0-2 */
+	PSIL_PDMA_MCASP(0x4500),
+	PSIL_PDMA_MCASP(0x4501),
+	PSIL_PDMA_MCASP(0x4502),
+	/* CPSW3G */
+	PSIL_ETHERNET(0x4600, 19, 19, 16),
+	/* CSI2RX */
+	PSIL_CSI2RX(0x5000),
+	PSIL_CSI2RX(0x5001),
+	PSIL_CSI2RX(0x5002),
+	PSIL_CSI2RX(0x5003),
+	PSIL_CSI2RX(0x5004),
+	PSIL_CSI2RX(0x5005),
+	PSIL_CSI2RX(0x5006),
+	PSIL_CSI2RX(0x5007),
+	PSIL_CSI2RX(0x5008),
+	PSIL_CSI2RX(0x5009),
+	PSIL_CSI2RX(0x500a),
+	PSIL_CSI2RX(0x500b),
+	PSIL_CSI2RX(0x500c),
+	PSIL_CSI2RX(0x500d),
+	PSIL_CSI2RX(0x500e),
+	PSIL_CSI2RX(0x500f),
+	PSIL_CSI2RX(0x5010),
+	PSIL_CSI2RX(0x5011),
+	PSIL_CSI2RX(0x5012),
+	PSIL_CSI2RX(0x5013),
+	PSIL_CSI2RX(0x5014),
+	PSIL_CSI2RX(0x5015),
+	PSIL_CSI2RX(0x5016),
+	PSIL_CSI2RX(0x5017),
+	PSIL_CSI2RX(0x5018),
+	PSIL_CSI2RX(0x5019),
+	PSIL_CSI2RX(0x501a),
+	PSIL_CSI2RX(0x501b),
+	PSIL_CSI2RX(0x501c),
+	PSIL_CSI2RX(0x501d),
+	PSIL_CSI2RX(0x501e),
+	PSIL_CSI2RX(0x501f),
+	PSIL_CSI2RX(0x5000),
+	PSIL_CSI2RX(0x5001),
+	PSIL_CSI2RX(0x5002),
+	PSIL_CSI2RX(0x5003),
+	PSIL_CSI2RX(0x5004),
+	PSIL_CSI2RX(0x5005),
+	PSIL_CSI2RX(0x5006),
+	PSIL_CSI2RX(0x5007),
+	PSIL_CSI2RX(0x5008),
+	PSIL_CSI2RX(0x5009),
+	PSIL_CSI2RX(0x500a),
+	PSIL_CSI2RX(0x500b),
+	PSIL_CSI2RX(0x500c),
+	PSIL_CSI2RX(0x500d),
+	PSIL_CSI2RX(0x500e),
+	PSIL_CSI2RX(0x500f),
+	PSIL_CSI2RX(0x5010),
+	PSIL_CSI2RX(0x5011),
+	PSIL_CSI2RX(0x5012),
+	PSIL_CSI2RX(0x5013),
+	PSIL_CSI2RX(0x5014),
+	PSIL_CSI2RX(0x5015),
+	PSIL_CSI2RX(0x5016),
+	PSIL_CSI2RX(0x5017),
+	PSIL_CSI2RX(0x5018),
+	PSIL_CSI2RX(0x5019),
+	PSIL_CSI2RX(0x501a),
+	PSIL_CSI2RX(0x501b),
+	PSIL_CSI2RX(0x501c),
+	PSIL_CSI2RX(0x501d),
+	PSIL_CSI2RX(0x501e),
+	PSIL_CSI2RX(0x501f),
+	/* CSIRX 1-3 (only for J722S) */
+	PSIL_CSI2RX(0x5100),
+	PSIL_CSI2RX(0x5101),
+	PSIL_CSI2RX(0x5102),
+	PSIL_CSI2RX(0x5103),
+	PSIL_CSI2RX(0x5104),
+	PSIL_CSI2RX(0x5105),
+	PSIL_CSI2RX(0x5106),
+	PSIL_CSI2RX(0x5107),
+	PSIL_CSI2RX(0x5108),
+	PSIL_CSI2RX(0x5109),
+	PSIL_CSI2RX(0x510a),
+	PSIL_CSI2RX(0x510b),
+	PSIL_CSI2RX(0x510c),
+	PSIL_CSI2RX(0x510d),
+	PSIL_CSI2RX(0x510e),
+	PSIL_CSI2RX(0x510f),
+	PSIL_CSI2RX(0x5110),
+	PSIL_CSI2RX(0x5111),
+	PSIL_CSI2RX(0x5112),
+	PSIL_CSI2RX(0x5113),
+	PSIL_CSI2RX(0x5114),
+	PSIL_CSI2RX(0x5115),
+	PSIL_CSI2RX(0x5116),
+	PSIL_CSI2RX(0x5117),
+	PSIL_CSI2RX(0x5118),
+	PSIL_CSI2RX(0x5119),
+	PSIL_CSI2RX(0x511a),
+	PSIL_CSI2RX(0x511b),
+	PSIL_CSI2RX(0x511c),
+	PSIL_CSI2RX(0x511d),
+	PSIL_CSI2RX(0x511e),
+	PSIL_CSI2RX(0x511f),
+	PSIL_CSI2RX(0x5200),
+	PSIL_CSI2RX(0x5201),
+	PSIL_CSI2RX(0x5202),
+	PSIL_CSI2RX(0x5203),
+	PSIL_CSI2RX(0x5204),
+	PSIL_CSI2RX(0x5205),
+	PSIL_CSI2RX(0x5206),
+	PSIL_CSI2RX(0x5207),
+	PSIL_CSI2RX(0x5208),
+	PSIL_CSI2RX(0x5209),
+	PSIL_CSI2RX(0x520a),
+	PSIL_CSI2RX(0x520b),
+	PSIL_CSI2RX(0x520c),
+	PSIL_CSI2RX(0x520d),
+	PSIL_CSI2RX(0x520e),
+	PSIL_CSI2RX(0x520f),
+	PSIL_CSI2RX(0x5210),
+	PSIL_CSI2RX(0x5211),
+	PSIL_CSI2RX(0x5212),
+	PSIL_CSI2RX(0x5213),
+	PSIL_CSI2RX(0x5214),
+	PSIL_CSI2RX(0x5215),
+	PSIL_CSI2RX(0x5216),
+	PSIL_CSI2RX(0x5217),
+	PSIL_CSI2RX(0x5218),
+	PSIL_CSI2RX(0x5219),
+	PSIL_CSI2RX(0x521a),
+	PSIL_CSI2RX(0x521b),
+	PSIL_CSI2RX(0x521c),
+	PSIL_CSI2RX(0x521d),
+	PSIL_CSI2RX(0x521e),
+	PSIL_CSI2RX(0x521f),
+	PSIL_CSI2RX(0x5300),
+	PSIL_CSI2RX(0x5301),
+	PSIL_CSI2RX(0x5302),
+	PSIL_CSI2RX(0x5303),
+	PSIL_CSI2RX(0x5304),
+	PSIL_CSI2RX(0x5305),
+	PSIL_CSI2RX(0x5306),
+	PSIL_CSI2RX(0x5307),
+	PSIL_CSI2RX(0x5308),
+	PSIL_CSI2RX(0x5309),
+	PSIL_CSI2RX(0x530a),
+	PSIL_CSI2RX(0x530b),
+	PSIL_CSI2RX(0x530c),
+	PSIL_CSI2RX(0x530d),
+	PSIL_CSI2RX(0x530e),
+	PSIL_CSI2RX(0x530f),
+	PSIL_CSI2RX(0x5310),
+	PSIL_CSI2RX(0x5311),
+	PSIL_CSI2RX(0x5312),
+	PSIL_CSI2RX(0x5313),
+	PSIL_CSI2RX(0x5314),
+	PSIL_CSI2RX(0x5315),
+	PSIL_CSI2RX(0x5316),
+	PSIL_CSI2RX(0x5317),
+	PSIL_CSI2RX(0x5318),
+	PSIL_CSI2RX(0x5319),
+	PSIL_CSI2RX(0x531a),
+	PSIL_CSI2RX(0x531b),
+	PSIL_CSI2RX(0x531c),
+	PSIL_CSI2RX(0x531d),
+	PSIL_CSI2RX(0x531e),
+	PSIL_CSI2RX(0x531f),
+};
+
+/* PSI-L destination thread IDs, used for TX (DMA_MEM_TO_DEV) */
+static struct psil_ep am62p_dst_ep_map[] = {
+	/* SAUL */
+	PSIL_SAUL(0xf500, 27, 83, 8, 83, 1),
+	PSIL_SAUL(0xf501, 28, 91, 8, 91, 1),
+	/* PDMA_MAIN0 - SPI0-2 */
+	PSIL_PDMA_XY_PKT(0xc300),
+	PSIL_PDMA_XY_PKT(0xc301),
+	PSIL_PDMA_XY_PKT(0xc302),
+	PSIL_PDMA_XY_PKT(0xc303),
+	PSIL_PDMA_XY_PKT(0xc304),
+	PSIL_PDMA_XY_PKT(0xc305),
+	PSIL_PDMA_XY_PKT(0xc306),
+	PSIL_PDMA_XY_PKT(0xc307),
+	PSIL_PDMA_XY_PKT(0xc308),
+	PSIL_PDMA_XY_PKT(0xc309),
+	PSIL_PDMA_XY_PKT(0xc30a),
+	PSIL_PDMA_XY_PKT(0xc30b),
+	/* PDMA_MAIN1 - UART0-6 */
+	PSIL_PDMA_XY_PKT(0xc400),
+	PSIL_PDMA_XY_PKT(0xc401),
+	PSIL_PDMA_XY_PKT(0xc402),
+	PSIL_PDMA_XY_PKT(0xc403),
+	PSIL_PDMA_XY_PKT(0xc404),
+	PSIL_PDMA_XY_PKT(0xc405),
+	PSIL_PDMA_XY_PKT(0xc406),
+	/* PDMA_MAIN2 - MCASP0-2 */
+	PSIL_PDMA_MCASP(0xc500),
+	PSIL_PDMA_MCASP(0xc501),
+	PSIL_PDMA_MCASP(0xc502),
+	/* CPSW3G */
+	PSIL_ETHERNET(0xc600, 19, 19, 8),
+	PSIL_ETHERNET(0xc601, 20, 27, 8),
+	PSIL_ETHERNET(0xc602, 21, 35, 8),
+	PSIL_ETHERNET(0xc603, 22, 43, 8),
+	PSIL_ETHERNET(0xc604, 23, 51, 8),
+	PSIL_ETHERNET(0xc605, 24, 59, 8),
+	PSIL_ETHERNET(0xc606, 25, 67, 8),
+	PSIL_ETHERNET(0xc607, 26, 75, 8),
+};
+
+struct psil_ep_map am62p_ep_map = {
+	.name = "am62p",
+	.src = am62p_src_ep_map,
+	.src_count = ARRAY_SIZE(am62p_src_ep_map),
+	.dst = am62p_dst_ep_map,
+	.dst_count = ARRAY_SIZE(am62p_dst_ep_map),
+};
diff --git a/drivers/dma/ti/k3-psil-priv.h b/drivers/dma/ti/k3-psil-priv.h
index c383723d1c8f..a577be97e344 100644
--- a/drivers/dma/ti/k3-psil-priv.h
+++ b/drivers/dma/ti/k3-psil-priv.h
@@ -45,5 +45,6 @@ extern struct psil_ep_map j721s2_ep_map;
 extern struct psil_ep_map am62_ep_map;
 extern struct psil_ep_map am62a_ep_map;
 extern struct psil_ep_map j784s4_ep_map;
+extern struct psil_ep_map am62p_ep_map;
 
 #endif /* K3_PSIL_PRIV_H_ */
diff --git a/drivers/dma/ti/k3-psil.c b/drivers/dma/ti/k3-psil.c
index c11389d67a3f..25148d952472 100644
--- a/drivers/dma/ti/k3-psil.c
+++ b/drivers/dma/ti/k3-psil.c
@@ -26,6 +26,8 @@ static const struct soc_device_attribute k3_soc_devices[] = {
 	{ .family = "AM62X", .data = &am62_ep_map },
 	{ .family = "AM62AX", .data = &am62a_ep_map },
 	{ .family = "J784S4", .data = &j784s4_ep_map },
+	{ .family = "AM62PX", .data = &am62p_ep_map },
+	{ .family = "J722S", .data = &am62p_ep_map },
 	{ /* sentinel */ }
 };
 
diff --git a/drivers/dma/ti/k3-udma.c b/drivers/dma/ti/k3-udma.c
index 30fd2f386f36..2841a539c264 100644
--- a/drivers/dma/ti/k3-udma.c
+++ b/drivers/dma/ti/k3-udma.c
@@ -4441,6 +4441,8 @@ static const struct soc_device_attribute k3_soc_devices[] = {
 	{ .family = "AM62X", .data = &am64_soc_data },
 	{ .family = "AM62AX", .data = &am64_soc_data },
 	{ .family = "J784S4", .data = &j721e_soc_data },
+	{ .family = "AM62PX", .data = &am64_soc_data },
+	{ .family = "J722S", .data = &am64_soc_data },
 	{ /* sentinel */ }
 };
 
-- 
2.17.1


