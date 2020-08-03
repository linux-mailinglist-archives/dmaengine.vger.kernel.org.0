Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F2AF623A6EA
	for <lists+dmaengine@lfdr.de>; Mon,  3 Aug 2020 14:56:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728052AbgHCM4F (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 3 Aug 2020 08:56:05 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:52110 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726823AbgHCM4F (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 3 Aug 2020 08:56:05 -0400
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 073CtwPk080457;
        Mon, 3 Aug 2020 07:55:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1596459359;
        bh=hw6nXMUmk+LBuIvVT95q0uNknKPIcE11TqEvUoAtGHY=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=e6COsrW8/K7tt2QcjFXPFOd4ghunxx7QMJ6sDqeHbsuIBW4VbGWUUJ5hk8eqrocXr
         Gn5ypnHVYtSmK9JNf4tAqAxSHCBmOYGCCHV7TieJAyhF5S7b5K3h/el5MRRBv+tQNj
         FSI7GWcV6MU/YwwIl5OD8TCR4dauJGh5HdjqXm3s=
Received: from DFLE100.ent.ti.com (dfle100.ent.ti.com [10.64.6.21])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTP id 073CtwQV007692;
        Mon, 3 Aug 2020 07:55:58 -0500
Received: from DFLE101.ent.ti.com (10.64.6.22) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Mon, 3 Aug
 2020 07:55:58 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE101.ent.ti.com
 (10.64.6.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Mon, 3 Aug 2020 07:55:58 -0500
Received: from feketebors.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 073CtoMj090290;
        Mon, 3 Aug 2020 07:55:56 -0500
From:   Peter Ujfalusi <peter.ujfalusi@ti.com>
To:     <vkoul@kernel.org>
CC:     <dmaengine@vger.kernel.org>, <dan.j.williams@intel.com>,
        <linux-arm-kernel@lists.infradead.org>, <nm@ti.com>,
        <grygorii.strashko@ti.com>, <lokeshvutla@ti.com>, <nsekhar@ti.com>,
        <kishon@ti.com>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 2/2] dmaengine: ti: k3-psil: add map for j7200
Date:   Mon, 3 Aug 2020 15:57:13 +0300
Message-ID: <20200803125713.17829-3-peter.ujfalusi@ti.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200803125713.17829-1-peter.ujfalusi@ti.com>
References: <20200803125713.17829-1-peter.ujfalusi@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Add new PSI-L map file for the new TI j7200 SoC.

The DMA hardware in j7200 is the same as in j721e with different
set of peripherals resulting different PSI-L thread map compered
to j721e.

See J7200 Technical Reference Manual (SPRUIU1, June 2020)
for further details: https://www.ti.com/lit/pdf/spruiu1

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 drivers/dma/ti/Makefile        |   5 +-
 drivers/dma/ti/k3-psil-j7200.c | 175 +++++++++++++++++++++++++++++++++
 drivers/dma/ti/k3-psil-priv.h  |   1 +
 drivers/dma/ti/k3-psil.c       |   1 +
 4 files changed, 181 insertions(+), 1 deletion(-)
 create mode 100644 drivers/dma/ti/k3-psil-j7200.c

diff --git a/drivers/dma/ti/Makefile b/drivers/dma/ti/Makefile
index 9a29a107e374..0c67254caee6 100644
--- a/drivers/dma/ti/Makefile
+++ b/drivers/dma/ti/Makefile
@@ -4,5 +4,8 @@ obj-$(CONFIG_TI_EDMA) += edma.o
 obj-$(CONFIG_DMA_OMAP) += omap-dma.o
 obj-$(CONFIG_TI_K3_UDMA) += k3-udma.o
 obj-$(CONFIG_TI_K3_UDMA_GLUE_LAYER) += k3-udma-glue.o
-obj-$(CONFIG_TI_K3_PSIL) += k3-psil.o k3-psil-am654.o k3-psil-j721e.o
+obj-$(CONFIG_TI_K3_PSIL) += k3-psil.o \
+			    k3-psil-am654.o \
+			    k3-psil-j721e.o \
+			    k3-psil-j7200.o
 obj-$(CONFIG_TI_DMA_CROSSBAR) += dma-crossbar.o
diff --git a/drivers/dma/ti/k3-psil-j7200.c b/drivers/dma/ti/k3-psil-j7200.c
new file mode 100644
index 000000000000..5ea63ea74822
--- /dev/null
+++ b/drivers/dma/ti/k3-psil-j7200.c
@@ -0,0 +1,175 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ *  Copyright (C) 2019 Texas Instruments Incorporated - http://www.ti.com
+ *  Author: Peter Ujfalusi <peter.ujfalusi@ti.com>
+ */
+
+#include <linux/kernel.h>
+
+#include "k3-psil-priv.h"
+
+#define PSIL_PDMA_XY_TR(x)				\
+	{						\
+		.thread_id = x,				\
+		.ep_config = {				\
+			.ep_type = PSIL_EP_PDMA_XY,	\
+		},					\
+	}
+
+#define PSIL_PDMA_XY_PKT(x)				\
+	{						\
+		.thread_id = x,				\
+		.ep_config = {				\
+			.ep_type = PSIL_EP_PDMA_XY,	\
+			.pkt_mode = 1,			\
+		},					\
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
+#define PSIL_ETHERNET(x)				\
+	{						\
+		.thread_id = x,				\
+		.ep_config = {				\
+			.ep_type = PSIL_EP_NATIVE,	\
+			.pkt_mode = 1,			\
+			.needs_epib = 1,		\
+			.psd_size = 16,			\
+		},					\
+	}
+
+#define PSIL_SA2UL(x, tx)				\
+	{						\
+		.thread_id = x,				\
+		.ep_config = {				\
+			.ep_type = PSIL_EP_NATIVE,	\
+			.pkt_mode = 1,			\
+			.needs_epib = 1,		\
+			.psd_size = 64,			\
+			.notdpkt = tx,			\
+		},					\
+	}
+
+/* PSI-L source thread IDs, used for RX (DMA_DEV_TO_MEM) */
+static struct psil_ep j7200_src_ep_map[] = {
+	/* PDMA_MCASP - McASP0-2 */
+	PSIL_PDMA_MCASP(0x4400),
+	PSIL_PDMA_MCASP(0x4401),
+	PSIL_PDMA_MCASP(0x4402),
+	/* PDMA_SPI_G0 - SPI0-3 */
+	PSIL_PDMA_XY_PKT(0x4600),
+	PSIL_PDMA_XY_PKT(0x4601),
+	PSIL_PDMA_XY_PKT(0x4602),
+	PSIL_PDMA_XY_PKT(0x4603),
+	PSIL_PDMA_XY_PKT(0x4604),
+	PSIL_PDMA_XY_PKT(0x4605),
+	PSIL_PDMA_XY_PKT(0x4606),
+	PSIL_PDMA_XY_PKT(0x4607),
+	PSIL_PDMA_XY_PKT(0x4608),
+	PSIL_PDMA_XY_PKT(0x4609),
+	PSIL_PDMA_XY_PKT(0x460a),
+	PSIL_PDMA_XY_PKT(0x460b),
+	PSIL_PDMA_XY_PKT(0x460c),
+	PSIL_PDMA_XY_PKT(0x460d),
+	PSIL_PDMA_XY_PKT(0x460e),
+	PSIL_PDMA_XY_PKT(0x460f),
+	/* PDMA_SPI_G1 - SPI4-7 */
+	PSIL_PDMA_XY_PKT(0x4610),
+	PSIL_PDMA_XY_PKT(0x4611),
+	PSIL_PDMA_XY_PKT(0x4612),
+	PSIL_PDMA_XY_PKT(0x4613),
+	PSIL_PDMA_XY_PKT(0x4614),
+	PSIL_PDMA_XY_PKT(0x4615),
+	PSIL_PDMA_XY_PKT(0x4616),
+	PSIL_PDMA_XY_PKT(0x4617),
+	PSIL_PDMA_XY_PKT(0x4618),
+	PSIL_PDMA_XY_PKT(0x4619),
+	PSIL_PDMA_XY_PKT(0x461a),
+	PSIL_PDMA_XY_PKT(0x461b),
+	PSIL_PDMA_XY_PKT(0x461c),
+	PSIL_PDMA_XY_PKT(0x461d),
+	PSIL_PDMA_XY_PKT(0x461e),
+	PSIL_PDMA_XY_PKT(0x461f),
+	/* PDMA_USART_G0 - UART0-1 */
+	PSIL_PDMA_XY_PKT(0x4700),
+	PSIL_PDMA_XY_PKT(0x4701),
+	/* PDMA_USART_G1 - UART2-3 */
+	PSIL_PDMA_XY_PKT(0x4702),
+	PSIL_PDMA_XY_PKT(0x4703),
+	/* PDMA_USART_G2 - UART4-9 */
+	PSIL_PDMA_XY_PKT(0x4704),
+	PSIL_PDMA_XY_PKT(0x4705),
+	PSIL_PDMA_XY_PKT(0x4706),
+	PSIL_PDMA_XY_PKT(0x4707),
+	PSIL_PDMA_XY_PKT(0x4708),
+	PSIL_PDMA_XY_PKT(0x4709),
+	/* CPSW5 */
+	PSIL_ETHERNET(0x4a00),
+	/* CPSW0 */
+	PSIL_ETHERNET(0x7000),
+	/* MCU_PDMA_MISC_G0 - SPI0 */
+	PSIL_PDMA_XY_PKT(0x7100),
+	PSIL_PDMA_XY_PKT(0x7101),
+	PSIL_PDMA_XY_PKT(0x7102),
+	PSIL_PDMA_XY_PKT(0x7103),
+	/* MCU_PDMA_MISC_G1 - SPI1-2 */
+	PSIL_PDMA_XY_PKT(0x7200),
+	PSIL_PDMA_XY_PKT(0x7201),
+	PSIL_PDMA_XY_PKT(0x7202),
+	PSIL_PDMA_XY_PKT(0x7203),
+	PSIL_PDMA_XY_PKT(0x7204),
+	PSIL_PDMA_XY_PKT(0x7205),
+	PSIL_PDMA_XY_PKT(0x7206),
+	PSIL_PDMA_XY_PKT(0x7207),
+	/* MCU_PDMA_MISC_G2 - UART0 */
+	PSIL_PDMA_XY_PKT(0x7300),
+	/* MCU_PDMA_ADC - ADC0-1 */
+	PSIL_PDMA_XY_TR(0x7400),
+	PSIL_PDMA_XY_TR(0x7401),
+	/* SA2UL */
+	PSIL_SA2UL(0x7500, 0),
+	PSIL_SA2UL(0x7501, 0),
+	PSIL_SA2UL(0x7502, 0),
+	PSIL_SA2UL(0x7503, 0),
+};
+
+/* PSI-L destination thread IDs, used for TX (DMA_MEM_TO_DEV) */
+static struct psil_ep j7200_dst_ep_map[] = {
+	/* CPSW5 */
+	PSIL_ETHERNET(0xca00),
+	PSIL_ETHERNET(0xca01),
+	PSIL_ETHERNET(0xca02),
+	PSIL_ETHERNET(0xca03),
+	PSIL_ETHERNET(0xca04),
+	PSIL_ETHERNET(0xca05),
+	PSIL_ETHERNET(0xca06),
+	PSIL_ETHERNET(0xca07),
+	/* CPSW0 */
+	PSIL_ETHERNET(0xf000),
+	PSIL_ETHERNET(0xf001),
+	PSIL_ETHERNET(0xf002),
+	PSIL_ETHERNET(0xf003),
+	PSIL_ETHERNET(0xf004),
+	PSIL_ETHERNET(0xf005),
+	PSIL_ETHERNET(0xf006),
+	PSIL_ETHERNET(0xf007),
+	/* SA2UL */
+	PSIL_SA2UL(0xf500, 1),
+	PSIL_SA2UL(0xf501, 1),
+};
+
+struct psil_ep_map j7200_ep_map = {
+	.name = "j7200",
+	.src = j7200_src_ep_map,
+	.src_count = ARRAY_SIZE(j7200_src_ep_map),
+	.dst = j7200_dst_ep_map,
+	.dst_count = ARRAY_SIZE(j7200_dst_ep_map),
+};
diff --git a/drivers/dma/ti/k3-psil-priv.h b/drivers/dma/ti/k3-psil-priv.h
index a1f389ca371e..b4b0fb359eff 100644
--- a/drivers/dma/ti/k3-psil-priv.h
+++ b/drivers/dma/ti/k3-psil-priv.h
@@ -39,5 +39,6 @@ struct psil_endpoint_config *psil_get_ep_config(u32 thread_id);
 /* SoC PSI-L endpoint maps */
 extern struct psil_ep_map am654_ep_map;
 extern struct psil_ep_map j721e_ep_map;
+extern struct psil_ep_map j7200_ep_map;
 
 #endif /* K3_PSIL_PRIV_H_ */
diff --git a/drivers/dma/ti/k3-psil.c b/drivers/dma/ti/k3-psil.c
index fa106e8bd56b..837853aab95a 100644
--- a/drivers/dma/ti/k3-psil.c
+++ b/drivers/dma/ti/k3-psil.c
@@ -19,6 +19,7 @@ static const struct psil_ep_map *soc_ep_map;
 static const struct soc_device_attribute k3_soc_devices[] = {
 	{ .family = "AM65X", .data = &am654_ep_map },
 	{ .family = "J721E", .data = &j721e_ep_map },
+	{ .family = "J7200", .data = &j7200_ep_map },
 	{ /* sentinel */ }
 };
 
-- 
Peter

Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki

