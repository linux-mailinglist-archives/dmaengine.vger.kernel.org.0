Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A5A3F2D2716
	for <lists+dmaengine@lfdr.de>; Tue,  8 Dec 2020 10:06:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728912AbgLHJGU (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 8 Dec 2020 04:06:20 -0500
Received: from fllv0016.ext.ti.com ([198.47.19.142]:51910 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728905AbgLHJGU (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 8 Dec 2020 04:06:20 -0500
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 0B894cfc130524;
        Tue, 8 Dec 2020 03:04:38 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1607418278;
        bh=/iof+Y+20nKAIGDls8esCI4NaFhSAXGPE1/n56ieVF8=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=mcD7tpvGISGVNs8fBVdwQg2d4aOzJxvVhWDtExfeUQ0IInqDXkRHVv1muskcv/gWY
         ZWjSxPTx9pF/6SU4poJJxt5CVj9Kqfn5+Y9bztmiDnLQ7hescmKBm6Oii4J8OontAr
         QowK0VvS57UZZn8l1ohB7d8Fl20PqZpVts5V5EnA=
Received: from DFLE115.ent.ti.com (dfle115.ent.ti.com [10.64.6.36])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 0B894cBG117700
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 8 Dec 2020 03:04:38 -0600
Received: from DFLE100.ent.ti.com (10.64.6.21) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Tue, 8 Dec
 2020 03:04:37 -0600
Received: from fllv0040.itg.ti.com (10.64.41.20) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Tue, 8 Dec 2020 03:04:38 -0600
Received: from feketebors.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 0B893dcJ120112;
        Tue, 8 Dec 2020 03:04:34 -0600
From:   Peter Ujfalusi <peter.ujfalusi@ti.com>
To:     <vkoul@kernel.org>, <nm@ti.com>, <ssantosh@kernel.org>,
        <robh+dt@kernel.org>
CC:     <dan.j.williams@intel.com>, <t-kristo@ti.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <dmaengine@vger.kernel.org>, <vigneshr@ti.com>,
        <grygorii.strashko@ti.com>
Subject: [PATCH v3 14/20] dmaengine: ti: k3-psil: Add initial map for AM64
Date:   Tue, 8 Dec 2020 11:04:34 +0200
Message-ID: <20201208090440.31792-15-peter.ujfalusi@ti.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201208090440.31792-1-peter.ujfalusi@ti.com>
References: <20201208090440.31792-1-peter.ujfalusi@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Add initial PSI-L map file for AM64.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 drivers/dma/ti/Makefile       |   3 +-
 drivers/dma/ti/k3-psil-am64.c | 158 ++++++++++++++++++++++++++++++++++
 drivers/dma/ti/k3-psil-priv.h |   1 +
 drivers/dma/ti/k3-psil.c      |   1 +
 4 files changed, 162 insertions(+), 1 deletion(-)
 create mode 100644 drivers/dma/ti/k3-psil-am64.c

diff --git a/drivers/dma/ti/Makefile b/drivers/dma/ti/Makefile
index 0c67254caee6..bd496efadff7 100644
--- a/drivers/dma/ti/Makefile
+++ b/drivers/dma/ti/Makefile
@@ -7,5 +7,6 @@ obj-$(CONFIG_TI_K3_UDMA_GLUE_LAYER) += k3-udma-glue.o
 obj-$(CONFIG_TI_K3_PSIL) += k3-psil.o \
 			    k3-psil-am654.o \
 			    k3-psil-j721e.o \
-			    k3-psil-j7200.o
+			    k3-psil-j7200.o \
+			    k3-psil-am64.o
 obj-$(CONFIG_TI_DMA_CROSSBAR) += dma-crossbar.o
diff --git a/drivers/dma/ti/k3-psil-am64.c b/drivers/dma/ti/k3-psil-am64.c
new file mode 100644
index 000000000000..9fdeaa11a4fc
--- /dev/null
+++ b/drivers/dma/ti/k3-psil-am64.c
@@ -0,0 +1,158 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ *  Copyright (C) 2020 Texas Instruments Incorporated - https://www.ti.com
+ *  Author: Peter Ujfalusi <peter.ujfalusi@ti.com>
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
+/* PSI-L source thread IDs, used for RX (DMA_DEV_TO_MEM) */
+static struct psil_ep am64_src_ep_map[] = {
+	/* SAUL */
+	PSIL_SAUL(0x4000, 17, 32, 8, 32, 0),
+	PSIL_SAUL(0x4001, 18, 32, 8, 33, 0),
+	PSIL_SAUL(0x4002, 19, 40, 8, 40, 0),
+	PSIL_SAUL(0x4003, 20, 40, 8, 41, 0),
+	/* ICSS_G0 */
+	PSIL_ETHERNET(0x4100, 21, 48, 16),
+	PSIL_ETHERNET(0x4101, 22, 64, 16),
+	PSIL_ETHERNET(0x4102, 23, 80, 16),
+	PSIL_ETHERNET(0x4103, 24, 96, 16),
+	/* ICSS_G1 */
+	PSIL_ETHERNET(0x4200, 25, 112, 16),
+	PSIL_ETHERNET(0x4201, 26, 128, 16),
+	PSIL_ETHERNET(0x4202, 27, 144, 16),
+	PSIL_ETHERNET(0x4203, 28, 160, 16),
+	/* PDMA_MAIN0 - SPI0-3 */
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
+	PSIL_PDMA_XY_PKT(0x430c),
+	PSIL_PDMA_XY_PKT(0x430d),
+	PSIL_PDMA_XY_PKT(0x430e),
+	PSIL_PDMA_XY_PKT(0x430f),
+	/* PDMA_MAIN0 - USART0-1 */
+	PSIL_PDMA_XY_PKT(0x4310),
+	PSIL_PDMA_XY_PKT(0x4311),
+	/* PDMA_MAIN1 - SPI4 */
+	PSIL_PDMA_XY_PKT(0x4400),
+	PSIL_PDMA_XY_PKT(0x4401),
+	PSIL_PDMA_XY_PKT(0x4402),
+	PSIL_PDMA_XY_PKT(0x4403),
+	/* PDMA_MAIN1 - USART2-6 */
+	PSIL_PDMA_XY_PKT(0x4404),
+	PSIL_PDMA_XY_PKT(0x4405),
+	PSIL_PDMA_XY_PKT(0x4406),
+	PSIL_PDMA_XY_PKT(0x4407),
+	PSIL_PDMA_XY_PKT(0x4408),
+	/* PDMA_MAIN1 - ADCs */
+	PSIL_PDMA_XY_TR(0x440f),
+	PSIL_PDMA_XY_TR(0x4410),
+	/* CPSW2 */
+	PSIL_ETHERNET(0x4500, 16, 16, 16),
+};
+
+/* PSI-L destination thread IDs, used for TX (DMA_MEM_TO_DEV) */
+static struct psil_ep am64_dst_ep_map[] = {
+	/* SAUL */
+	PSIL_SAUL(0xc000, 24, 80, 8, 80, 1),
+	PSIL_SAUL(0xc001, 25, 88, 8, 88, 1),
+	/* ICSS_G0 */
+	PSIL_ETHERNET(0xc100, 26, 96, 1),
+	PSIL_ETHERNET(0xc101, 27, 97, 1),
+	PSIL_ETHERNET(0xc102, 28, 98, 1),
+	PSIL_ETHERNET(0xc103, 29, 99, 1),
+	PSIL_ETHERNET(0xc104, 30, 100, 1),
+	PSIL_ETHERNET(0xc105, 31, 101, 1),
+	PSIL_ETHERNET(0xc106, 32, 102, 1),
+	PSIL_ETHERNET(0xc107, 33, 103, 1),
+	/* ICSS_G1 */
+	PSIL_ETHERNET(0xc200, 34, 104, 1),
+	PSIL_ETHERNET(0xc201, 35, 105, 1),
+	PSIL_ETHERNET(0xc202, 36, 106, 1),
+	PSIL_ETHERNET(0xc203, 37, 107, 1),
+	PSIL_ETHERNET(0xc204, 38, 108, 1),
+	PSIL_ETHERNET(0xc205, 39, 109, 1),
+	PSIL_ETHERNET(0xc206, 40, 110, 1),
+	PSIL_ETHERNET(0xc207, 41, 111, 1),
+	/* CPSW2 */
+	PSIL_ETHERNET(0xc500, 16, 16, 8),
+	PSIL_ETHERNET(0xc501, 17, 24, 8),
+	PSIL_ETHERNET(0xc502, 18, 32, 8),
+	PSIL_ETHERNET(0xc503, 19, 40, 8),
+	PSIL_ETHERNET(0xc504, 20, 48, 8),
+	PSIL_ETHERNET(0xc505, 21, 56, 8),
+	PSIL_ETHERNET(0xc506, 22, 64, 8),
+	PSIL_ETHERNET(0xc507, 23, 72, 8),
+};
+
+struct psil_ep_map am64_ep_map = {
+	.name = "am64",
+	.src = am64_src_ep_map,
+	.src_count = ARRAY_SIZE(am64_src_ep_map),
+	.dst = am64_dst_ep_map,
+	.dst_count = ARRAY_SIZE(am64_dst_ep_map),
+};
diff --git a/drivers/dma/ti/k3-psil-priv.h b/drivers/dma/ti/k3-psil-priv.h
index b4b0fb359eff..b74e192e3c2d 100644
--- a/drivers/dma/ti/k3-psil-priv.h
+++ b/drivers/dma/ti/k3-psil-priv.h
@@ -40,5 +40,6 @@ struct psil_endpoint_config *psil_get_ep_config(u32 thread_id);
 extern struct psil_ep_map am654_ep_map;
 extern struct psil_ep_map j721e_ep_map;
 extern struct psil_ep_map j7200_ep_map;
+extern struct psil_ep_map am64_ep_map;
 
 #endif /* K3_PSIL_PRIV_H_ */
diff --git a/drivers/dma/ti/k3-psil.c b/drivers/dma/ti/k3-psil.c
index 837853aab95a..13ce7367d870 100644
--- a/drivers/dma/ti/k3-psil.c
+++ b/drivers/dma/ti/k3-psil.c
@@ -20,6 +20,7 @@ static const struct soc_device_attribute k3_soc_devices[] = {
 	{ .family = "AM65X", .data = &am654_ep_map },
 	{ .family = "J721E", .data = &j721e_ep_map },
 	{ .family = "J7200", .data = &j7200_ep_map },
+	{ .family = "AM64X", .data = &am64_ep_map },
 	{ /* sentinel */ }
 };
 
-- 
Peter

Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki

