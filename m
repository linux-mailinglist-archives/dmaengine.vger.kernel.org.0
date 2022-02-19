Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2749E4BC6F9
	for <lists+dmaengine@lfdr.de>; Sat, 19 Feb 2022 09:33:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241747AbiBSIdD (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Sat, 19 Feb 2022 03:33:03 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:33116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241745AbiBSIdC (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Sat, 19 Feb 2022 03:33:02 -0500
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A279673ED;
        Sat, 19 Feb 2022 00:32:44 -0800 (PST)
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 21J8WblU103062;
        Sat, 19 Feb 2022 02:32:37 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1645259557;
        bh=5ukqsI9c13W9UDeLypN1OMS2HcptnMB+DQlJuUFTFdk=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=mZUMsqtmhO4ONCIb72H+X/zweaugXn1HwyknoCidFXfYAU65aRD9KfOiJDRB/a9X0
         l1LFwYrlvgq7+ukPXsMAaqRyKCPbvgNZf28Rlti6Yjd+axo45IUtGAPkKRXm+nIhjf
         jaV830Jo70scw9drSTw6Z1w+cTKx7Ok/UJLtW6jQ=
Received: from DLEE112.ent.ti.com (dlee112.ent.ti.com [157.170.170.23])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 21J8Wbfx001713
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Sat, 19 Feb 2022 02:32:37 -0600
Received: from DLEE114.ent.ti.com (157.170.170.25) by DLEE112.ent.ti.com
 (157.170.170.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14; Sat, 19
 Feb 2022 02:32:35 -0600
Received: from lelv0326.itg.ti.com (10.180.67.84) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14 via
 Frontend Transport; Sat, 19 Feb 2022 02:32:35 -0600
Received: from ula0132425.ent.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 21J8WRX8017343;
        Sat, 19 Feb 2022 02:32:33 -0600
From:   Vignesh Raghavendra <vigneshr@ti.com>
To:     Peter Ujfalusi <peter.ujfalusi@gmail.com>,
        Vinod Koul <vkoul@kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <dmaengine@vger.kernel.org>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Linux ARM Mailing List <linux-arm-kernel@lists.infradead.org>
Subject: [PATCH 2/2] dmaengine: ti: k3-psil: Add AM62x PSIL and PDMA data
Date:   Sat, 19 Feb 2022 14:02:20 +0530
Message-ID: <20220219083220.489420-3-vigneshr@ti.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220219083220.489420-1-vigneshr@ti.com>
References: <20220219083220.489420-1-vigneshr@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Add PSIL EP data and PDMA data for AM62x.

[p.yadav@ti.com: Add CSIRX data]
Signed-off-by: Pratyush Yadav <p.yadav@ti.com>
Signed-off-by: Vignesh Raghavendra <vigneshr@ti.com>
---
 drivers/dma/ti/Makefile       |   3 +-
 drivers/dma/ti/k3-psil-am62.c | 186 ++++++++++++++++++++++++++++++++++
 drivers/dma/ti/k3-psil-priv.h |   1 +
 drivers/dma/ti/k3-psil.c      |   1 +
 4 files changed, 190 insertions(+), 1 deletion(-)
 create mode 100644 drivers/dma/ti/k3-psil-am62.c

diff --git a/drivers/dma/ti/Makefile b/drivers/dma/ti/Makefile
index 1d4081a049b7c..d3a303f0d7c62 100644
--- a/drivers/dma/ti/Makefile
+++ b/drivers/dma/ti/Makefile
@@ -9,5 +9,6 @@ obj-$(CONFIG_TI_K3_PSIL) += k3-psil.o \
 			    k3-psil-j721e.o \
 			    k3-psil-j7200.o \
 			    k3-psil-am64.o \
-			    k3-psil-j721s2.o
+			    k3-psil-j721s2.o \
+			    k3-psil-am62.o
 obj-$(CONFIG_TI_DMA_CROSSBAR) += dma-crossbar.o
diff --git a/drivers/dma/ti/k3-psil-am62.c b/drivers/dma/ti/k3-psil-am62.c
new file mode 100644
index 0000000000000..d431e20332378
--- /dev/null
+++ b/drivers/dma/ti/k3-psil-am62.c
@@ -0,0 +1,186 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ *  Copyright (C) 2022 Texas Instruments Incorporated - https://www.ti.com
+ */
+
+#include <linux/kernel.h>
+
+#include "k3-psil-priv.h"
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
+static struct psil_ep am62_src_ep_map[] = {
+	/* SAUL */
+	PSIL_SAUL(0x7500, 20, 35, 8, 35, 0),
+	PSIL_SAUL(0x7501, 21, 35, 8, 36, 0),
+	PSIL_SAUL(0x7502, 22, 43, 8, 43, 0),
+	PSIL_SAUL(0x7503, 23, 43, 8, 44, 0),
+	/* PDMA_MAIN0 - SPI0-3 */
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
+	PSIL_CSI2RX(0x4700),
+	PSIL_CSI2RX(0x4701),
+	PSIL_CSI2RX(0x4702),
+	PSIL_CSI2RX(0x4703),
+	PSIL_CSI2RX(0x4704),
+	PSIL_CSI2RX(0x4705),
+	PSIL_CSI2RX(0x4706),
+	PSIL_CSI2RX(0x4707),
+	PSIL_CSI2RX(0x4708),
+	PSIL_CSI2RX(0x4709),
+	PSIL_CSI2RX(0x470a),
+	PSIL_CSI2RX(0x470b),
+	PSIL_CSI2RX(0x470c),
+	PSIL_CSI2RX(0x470d),
+	PSIL_CSI2RX(0x470e),
+	PSIL_CSI2RX(0x470f),
+	PSIL_CSI2RX(0x4710),
+	PSIL_CSI2RX(0x4711),
+	PSIL_CSI2RX(0x4712),
+	PSIL_CSI2RX(0x4713),
+	PSIL_CSI2RX(0x4714),
+	PSIL_CSI2RX(0x4715),
+	PSIL_CSI2RX(0x4716),
+	PSIL_CSI2RX(0x4717),
+	PSIL_CSI2RX(0x4718),
+	PSIL_CSI2RX(0x4719),
+	PSIL_CSI2RX(0x471a),
+	PSIL_CSI2RX(0x471b),
+	PSIL_CSI2RX(0x471c),
+	PSIL_CSI2RX(0x471d),
+	PSIL_CSI2RX(0x471e),
+	PSIL_CSI2RX(0x471f),
+};
+
+/* PSI-L destination thread IDs, used for TX (DMA_MEM_TO_DEV) */
+static struct psil_ep am62_dst_ep_map[] = {
+	/* SAUL */
+	PSIL_SAUL(0xf500, 27, 83, 8, 83, 1),
+	PSIL_SAUL(0xf501, 28, 91, 8, 91, 1),
+	/* PDMA_MAIN0 - SPI0-3 */
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
+	PSIL_PDMA_XY_PKT(0xc30c),
+	PSIL_PDMA_XY_PKT(0xc30d),
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
+struct psil_ep_map am62_ep_map = {
+	.name = "am62",
+	.src = am62_src_ep_map,
+	.src_count = ARRAY_SIZE(am62_src_ep_map),
+	.dst = am62_dst_ep_map,
+	.dst_count = ARRAY_SIZE(am62_dst_ep_map),
+};
diff --git a/drivers/dma/ti/k3-psil-priv.h b/drivers/dma/ti/k3-psil-priv.h
index e51e179cdb567..74fa9ec02968f 100644
--- a/drivers/dma/ti/k3-psil-priv.h
+++ b/drivers/dma/ti/k3-psil-priv.h
@@ -42,5 +42,6 @@ extern struct psil_ep_map j721e_ep_map;
 extern struct psil_ep_map j7200_ep_map;
 extern struct psil_ep_map am64_ep_map;
 extern struct psil_ep_map j721s2_ep_map;
+extern struct psil_ep_map am62_ep_map;
 
 #endif /* K3_PSIL_PRIV_H_ */
diff --git a/drivers/dma/ti/k3-psil.c b/drivers/dma/ti/k3-psil.c
index 8867b4bd0c51d..761a384093d20 100644
--- a/drivers/dma/ti/k3-psil.c
+++ b/drivers/dma/ti/k3-psil.c
@@ -22,6 +22,7 @@ static const struct soc_device_attribute k3_soc_devices[] = {
 	{ .family = "J7200", .data = &j7200_ep_map },
 	{ .family = "AM64X", .data = &am64_ep_map },
 	{ .family = "J721S2", .data = &j721s2_ep_map },
+	{ .family = "AM62X", .data = &am62_ep_map },
 	{ /* sentinel */ }
 };
 
-- 
2.35.1

