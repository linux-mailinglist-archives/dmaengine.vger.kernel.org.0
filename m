Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 797A22B5D7D
	for <lists+dmaengine@lfdr.de>; Tue, 17 Nov 2020 11:57:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728209AbgKQK5A (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 17 Nov 2020 05:57:00 -0500
Received: from fllv0016.ext.ti.com ([198.47.19.142]:34160 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728186AbgKQK5A (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 17 Nov 2020 05:57:00 -0500
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 0AHAunrt117383;
        Tue, 17 Nov 2020 04:56:49 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1605610609;
        bh=gWwHItEoo4DJVr7FXCMLBP6bV/xJktpY4mjYFaYMosU=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=DNy/+n2iOuq8bLOtdTYZ9s6iDVtaEBKjzTxV5pbvDHy6mIeyKD67L+orRkP7lulbS
         1tzWXw461y8QpetKN+wEfNo4/1nhl5iL8r5nYcnNbn4l0d8Stpw44CyShOR3ZNhYBY
         WiLAHXhx+pUJon2TatAdFaht37VEqg1k75kNul7M=
Received: from DFLE100.ent.ti.com (dfle100.ent.ti.com [10.64.6.21])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 0AHAunVd085888
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 17 Nov 2020 04:56:49 -0600
Received: from DFLE103.ent.ti.com (10.64.6.24) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Tue, 17
 Nov 2020 04:56:49 -0600
Received: from lelv0327.itg.ti.com (10.180.67.183) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Tue, 17 Nov 2020 04:56:49 -0600
Received: from feketebors.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 0AHAu6tx087311;
        Tue, 17 Nov 2020 04:56:46 -0600
From:   Peter Ujfalusi <peter.ujfalusi@ti.com>
To:     <vkoul@kernel.org>, <nm@ti.com>, <ssantosh@kernel.org>,
        <robh+dt@kernel.org>
CC:     <dan.j.williams@intel.com>, <t-kristo@ti.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <dmaengine@vger.kernel.org>, <vigneshr@ti.com>,
        <grygorii.strashko@ti.com>
Subject: [PATCH v2 13/19] dmaengine: ti: k3-psil: Add initial map for AM64
Date:   Tue, 17 Nov 2020 12:56:50 +0200
Message-ID: <20201117105656.5236-14-peter.ujfalusi@ti.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201117105656.5236-1-peter.ujfalusi@ti.com>
References: <20201117105656.5236-1-peter.ujfalusi@ti.com>
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
 drivers/dma/ti/Makefile       |  3 +-
 drivers/dma/ti/k3-psil-am64.c | 75 +++++++++++++++++++++++++++++++++++
 drivers/dma/ti/k3-psil-priv.h |  1 +
 drivers/dma/ti/k3-psil.c      |  1 +
 4 files changed, 79 insertions(+), 1 deletion(-)
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
index 000000000000..e88f57a36ac1
--- /dev/null
+++ b/drivers/dma/ti/k3-psil-am64.c
@@ -0,0 +1,75 @@
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
+	/* SA2UL */
+	PSIL_SAUL(0x4000, 17, 32, 8, 32, 0),
+	PSIL_SAUL(0x4001, 18, 32, 8, 33, 0),
+	PSIL_SAUL(0x4002, 19, 40, 8, 40, 0),
+	PSIL_SAUL(0x4003, 20, 40, 8, 41, 0),
+	/* CPSW3G */
+	PSIL_ETHERNET(0x4500, 16, 16, 16),
+};
+
+/* PSI-L destination thread IDs, used for TX (DMA_MEM_TO_DEV) */
+static struct psil_ep am64_dst_ep_map[] = {
+	/* SA2UL */
+	PSIL_SAUL(0xc000, 24, 80, 8, 80, 1),
+	PSIL_SAUL(0xc001, 25, 88, 8, 88, 1),
+	/* CPSW3G */
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

