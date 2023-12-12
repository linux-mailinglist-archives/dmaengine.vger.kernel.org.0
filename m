Return-Path: <dmaengine+bounces-506-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DA1680F7FE
	for <lists+dmaengine@lfdr.de>; Tue, 12 Dec 2023 21:37:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CBE461C20A78
	for <lists+dmaengine@lfdr.de>; Tue, 12 Dec 2023 20:37:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 494806412A;
	Tue, 12 Dec 2023 20:37:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="gH6EBOro"
X-Original-To: dmaengine@vger.kernel.org
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CF47BC;
	Tue, 12 Dec 2023 12:37:01 -0800 (PST)
Received: from lelv0266.itg.ti.com ([10.180.67.225])
	by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 3BCKavsM006883;
	Tue, 12 Dec 2023 14:36:57 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1702413417;
	bh=aWJk5R05nOAYgRgjsf7Zhl3IhEkyXw6GQF2SA7YHs5w=;
	h=From:To:CC:Subject:Date;
	b=gH6EBOroweqP66yNI8xiDnKIvxOeIb5/8oDjOdMfDoRrVEEZrfBkWysupW2veSRAn
	 vQjW7WYR8JkF85Iwl0hxFvqHaYJLISUNQmHOhjGSSzG8Yl9CY5R3qQyMYd+UMrErze
	 ahGR5Di8Qrz/xSzLUNJjn9wXi+JKSM3l7BzYNzjQ=
Received: from DFLE115.ent.ti.com (dfle115.ent.ti.com [10.64.6.36])
	by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 3BCKavvp101284
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 12 Dec 2023 14:36:57 -0600
Received: from DFLE106.ent.ti.com (10.64.6.27) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 12
 Dec 2023 14:36:57 -0600
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE106.ent.ti.com
 (10.64.6.27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 12 Dec 2023 14:36:57 -0600
Received: from localhost (bb.dhcp.ti.com [128.247.81.12])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 3BCKav6N048674;
	Tue, 12 Dec 2023 14:36:57 -0600
From: Bryan Brattlof <bb@ti.com>
To: Peter Ujfalusi <peter.ujfalusi@gmail.com>, Vinod Koul <vkoul@kernel.org>
CC: Vignesh Raghavendra <vigneshr@ti.com>,
        Vaishnav Achath
	<vaishnav.a@ti.com>,
        Linux Kernel Mailing List
	<linux-kernel@vger.kernel.org>,
        DMA Engine <dmaengine@vger.kernel.org>, Bryan
 Brattlof <bb@ti.com>
Subject: [PATCH] dmaengine: ti: k3-udma: Add PSIL threads for AM62P
Date: Tue, 12 Dec 2023 14:36:56 -0600
Message-ID: <20231212203655.3155565-2-bb@ti.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=7802; i=bb@ti.com; h=from:subject; bh=N8i5ehnXTJVVADeM676vKZWxZ7f9VMceCdOTAPwx4nY=; b=owNCWmg5MUFZJlNZuztATQAAav///7dbvr987i+jrf/u39nH+0q/1v7XP3df0e27qn5O38awA Rsyh3qgA0AADJoGgANAA00AA0BoAAAAAPU0HpA9Ro9T1A0/VNqaaPUaDJ6htE/VEAGmhk9TTI0x NNB6g0aaNHqaA2o0DQGg00DTID1NGg0GgA9Q9TQNGQGhtTIZNBkGJocmmBDJiDQaaNGTTRoNGJk NNBkBowEGhk00AGQyNAAYjRoZDIYTINDQyAwGDLyVwExpESuk5WmkCAQ9AsbRJ1Sk5LiwCVk/Ar tHkIUvB2nvEC7qb7F5y9ca20jAHWqzBg8EjHBJNbfGkw3nD4DXNYkWopGgwjW4Q/iMEn9VR7v26 Mt6N1Gixa2SfDhyEKBHjMwaXxJL4MMUDgTZ2PrgM27zENFkxxWI04xZIcnzKzZx+HpqilIkTmFv g5qnTpikadMaO+sQ7SpQzMWKUuT6hwzxJ5eolyedHulM1nT1rVbTXiCSF3avH85jMezizY2LGcd nkm+rus9b4XBcKK/glqYy8QhxSj/CX/AaIWD/FvnzjAljJQi7aDPUAg/z26gPcKvzAp7aWZIpXz roAJHGvalEoiX7uVAWe1iJHJfIjfAQJkxC3UYNFB9HIFYhiwT8fsCYIv2qSSZ061yhWJwmR9qig BC9615AN8yyqw/xdyRThQkLs7QE0A==
X-Developer-Key: i=bb@ti.com; a=openpgp; fpr=D3D177E40A38DF4D1853FEEF41B90D5D71D56CE0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

From: Vignesh Raghavendra <vigneshr@ti.com>

Add PSIL and PDMA data for AM62P.

Signed-off-by: Vignesh Raghavendra <vigneshr@ti.com>
Signed-off-by: Bryan Brattlof <bb@ti.com>
---
 drivers/dma/ti/Makefile        |   3 +-
 drivers/dma/ti/k3-psil-am62p.c | 196 +++++++++++++++++++++++++++++++++
 drivers/dma/ti/k3-psil-priv.h  |   1 +
 drivers/dma/ti/k3-psil.c       |   1 +
 drivers/dma/ti/k3-udma.c       |   1 +
 5 files changed, 201 insertions(+), 1 deletion(-)
 create mode 100644 drivers/dma/ti/k3-psil-am62p.c

diff --git a/drivers/dma/ti/Makefile b/drivers/dma/ti/Makefile
index acc950bf609c3..d376c117cecf6 100644
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
index 0000000000000..da134ab40a310
--- /dev/null
+++ b/drivers/dma/ti/k3-psil-am62p.c
@@ -0,0 +1,196 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ *  Copyright (C) 2022 Texas Instruments Incorporated - https://www.ti.com
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
index c383723d1c8f6..a577be97e3447 100644
--- a/drivers/dma/ti/k3-psil-priv.h
+++ b/drivers/dma/ti/k3-psil-priv.h
@@ -45,5 +45,6 @@ extern struct psil_ep_map j721s2_ep_map;
 extern struct psil_ep_map am62_ep_map;
 extern struct psil_ep_map am62a_ep_map;
 extern struct psil_ep_map j784s4_ep_map;
+extern struct psil_ep_map am62p_ep_map;
 
 #endif /* K3_PSIL_PRIV_H_ */
diff --git a/drivers/dma/ti/k3-psil.c b/drivers/dma/ti/k3-psil.c
index c11389d67a3f0..5c5b367909902 100644
--- a/drivers/dma/ti/k3-psil.c
+++ b/drivers/dma/ti/k3-psil.c
@@ -26,6 +26,7 @@ static const struct soc_device_attribute k3_soc_devices[] = {
 	{ .family = "AM62X", .data = &am62_ep_map },
 	{ .family = "AM62AX", .data = &am62a_ep_map },
 	{ .family = "J784S4", .data = &j784s4_ep_map },
+	{ .family = "AM62PX", .data = &am62p_ep_map },
 	{ /* sentinel */ }
 };
 
diff --git a/drivers/dma/ti/k3-udma.c b/drivers/dma/ti/k3-udma.c
index 30fd2f386f36a..59a8faf6150f8 100644
--- a/drivers/dma/ti/k3-udma.c
+++ b/drivers/dma/ti/k3-udma.c
@@ -4441,6 +4441,7 @@ static const struct soc_device_attribute k3_soc_devices[] = {
 	{ .family = "AM62X", .data = &am64_soc_data },
 	{ .family = "AM62AX", .data = &am64_soc_data },
 	{ .family = "J784S4", .data = &j721e_soc_data },
+	{ .family = "AM62PX", .data = &am64_soc_data },
 	{ /* sentinel */ }
 };
 

base-commit: abb240f7a2bd14567ab53e602db562bb683391e6
-- 
2.43.0


