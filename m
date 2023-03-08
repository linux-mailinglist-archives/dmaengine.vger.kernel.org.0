Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B7AD16B12C6
	for <lists+dmaengine@lfdr.de>; Wed,  8 Mar 2023 21:15:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230259AbjCHUP4 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 8 Mar 2023 15:15:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230280AbjCHUPj (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 8 Mar 2023 15:15:39 -0500
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11A9F62861;
        Wed,  8 Mar 2023 12:15:22 -0800 (PST)
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 328KFGvQ059412;
        Wed, 8 Mar 2023 14:15:16 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1678306516;
        bh=TTsWbvj7vtn7u8e2jqz0jLkB4HaszYsOuga/IAGX7Lg=;
        h=From:To:CC:Subject:Date;
        b=sqQCOYBG77R6VbRdkzxDUekKCr+7z0PvnoTeSWIjm/a/4T+TuKS0okzIGyuHn4M/I
         swSXGfls7kHF3lpAVHylGDw1YTJP7s1RXqV4pezadMkmiYoBuCj+eWGOp8wuW5isw5
         ZZeOO+OitlDzdlb7L/gYyPWnA6sbIODtIuQXJRPA=
Received: from DLEE105.ent.ti.com (dlee105.ent.ti.com [157.170.170.35])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 328KFGEb011087
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 8 Mar 2023 14:15:16 -0600
Received: from DLEE107.ent.ti.com (157.170.170.37) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16; Wed, 8
 Mar 2023 14:15:15 -0600
Received: from fllv0040.itg.ti.com (10.64.41.20) by DLEE107.ent.ti.com
 (157.170.170.37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16 via
 Frontend Transport; Wed, 8 Mar 2023 14:15:15 -0600
Received: from localhost (ileaxei01-snat.itg.ti.com [10.180.69.5])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 328KFEP7065639;
        Wed, 8 Mar 2023 14:15:15 -0600
From:   Jayesh Choudhary <j-choudhary@ti.com>
To:     <vkoul@kernel.org>, <peter.ujfalusi@gmail.com>
CC:     <a-nandan@ti.com>, <hnagalla@ti.com>, <s-vadapalli@ti.com>,
        <vigneshr@ti.com>, <vaishnav.a@ti.com>,
        <linux-kernel@vger.kernel.org>, <dmaengine@vger.kernel.org>,
        <j-choudhary@ti.com>
Subject: [PATCH] dmaengine: ti: k3-psil: Add PSI-L thread support for J784s4
Date:   Thu, 9 Mar 2023 01:45:13 +0530
Message-ID: <20230308201513.116638-1-j-choudhary@ti.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

From: Apurva Nandan <a-nandan@ti.com>

Add psil thread IDs for J784s4 and include J784s4 in the set of
"k3_soc_devices" in k3-psil.c.

Signed-off-by: Apurva Nandan <a-nandan@ti.com>
Signed-off-by: Hari Nagalla <hnagalla@ti.com>
Signed-off-by: Siddharth Vadapalli <s-vadapalli@ti.com>
Signed-off-by: Vignesh Raghavendra <vigneshr@ti.com>
[vaishnav.a@ti.com: add MCSPI-TX and 3rd CSI2RX instance entries]
Signed-off-by: Vaishnav Achath <vaishnav.a@ti.com>
[j-choudhary@ti.com: add sa2ul entries, minor cleanups]
Signed-off-by: Jayesh Choudhary <j-choudhary@ti.com>
---
 drivers/dma/ti/Makefile         |   3 +-
 drivers/dma/ti/k3-psil-j784s4.c | 354 ++++++++++++++++++++++++++++++++
 drivers/dma/ti/k3-psil-priv.h   |   1 +
 drivers/dma/ti/k3-psil.c        |   1 +
 drivers/dma/ti/k3-udma.c        |   1 +
 5 files changed, 359 insertions(+), 1 deletion(-)
 create mode 100644 drivers/dma/ti/k3-psil-j784s4.c

diff --git a/drivers/dma/ti/Makefile b/drivers/dma/ti/Makefile
index bd1e07fda559..acc950bf609c 100644
--- a/drivers/dma/ti/Makefile
+++ b/drivers/dma/ti/Makefile
@@ -11,6 +11,7 @@ k3-psil-lib-objs := k3-psil.o \
 		    k3-psil-am64.o \
 		    k3-psil-j721s2.o \
 		    k3-psil-am62.o \
-		    k3-psil-am62a.o
+		    k3-psil-am62a.o \
+		    k3-psil-j784s4.o
 obj-$(CONFIG_TI_K3_PSIL) += k3-psil-lib.o
 obj-$(CONFIG_TI_DMA_CROSSBAR) += dma-crossbar.o
diff --git a/drivers/dma/ti/k3-psil-j784s4.c b/drivers/dma/ti/k3-psil-j784s4.c
new file mode 100644
index 000000000000..12bfa2478f92
--- /dev/null
+++ b/drivers/dma/ti/k3-psil-j784s4.c
@@ -0,0 +1,354 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ *  Copyright (C) 2021 Texas Instruments Incorporated - https://www.ti.com
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
+#define PSIL_CSI2RX(x)					\
+	{						\
+		.thread_id = x,				\
+		.ep_config = {				\
+			.ep_type = PSIL_EP_NATIVE,	\
+		},					\
+	}
+
+/* PSI-L source thread IDs, used for RX (DMA_DEV_TO_MEM) */
+static struct psil_ep j784s4_src_ep_map[] = {
+	/* PDMA_MCASP - McASP0-4 */
+	PSIL_PDMA_MCASP(0x4400),
+	PSIL_PDMA_MCASP(0x4401),
+	PSIL_PDMA_MCASP(0x4402),
+	PSIL_PDMA_MCASP(0x4403),
+	PSIL_PDMA_MCASP(0x4404),
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
+	PSIL_PDMA_XY_PKT(0x4620),
+	PSIL_PDMA_XY_PKT(0x4621),
+	PSIL_PDMA_XY_PKT(0x4622),
+	PSIL_PDMA_XY_PKT(0x4623),
+	PSIL_PDMA_XY_PKT(0x4624),
+	PSIL_PDMA_XY_PKT(0x4625),
+	PSIL_PDMA_XY_PKT(0x4626),
+	PSIL_PDMA_XY_PKT(0x4627),
+	PSIL_PDMA_XY_PKT(0x4628),
+	PSIL_PDMA_XY_PKT(0x4629),
+	PSIL_PDMA_XY_PKT(0x462a),
+	PSIL_PDMA_XY_PKT(0x462b),
+	PSIL_PDMA_XY_PKT(0x462c),
+	PSIL_PDMA_XY_PKT(0x462d),
+	PSIL_PDMA_XY_PKT(0x462e),
+	PSIL_PDMA_XY_PKT(0x462f),
+	/* MAIN_CPSW2G */
+	PSIL_ETHERNET(0x4640),
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
+	/* CSI2RX */
+	PSIL_CSI2RX(0x4900),
+	PSIL_CSI2RX(0x4901),
+	PSIL_CSI2RX(0x4902),
+	PSIL_CSI2RX(0x4903),
+	PSIL_CSI2RX(0x4940),
+	PSIL_CSI2RX(0x4941),
+	PSIL_CSI2RX(0x4942),
+	PSIL_CSI2RX(0x4943),
+	PSIL_CSI2RX(0x4944),
+	PSIL_CSI2RX(0x4945),
+	PSIL_CSI2RX(0x4946),
+	PSIL_CSI2RX(0x4947),
+	PSIL_CSI2RX(0x4948),
+	PSIL_CSI2RX(0x4949),
+	PSIL_CSI2RX(0x494a),
+	PSIL_CSI2RX(0x494b),
+	PSIL_CSI2RX(0x494c),
+	PSIL_CSI2RX(0x494d),
+	PSIL_CSI2RX(0x494e),
+	PSIL_CSI2RX(0x494f),
+	PSIL_CSI2RX(0x4950),
+	PSIL_CSI2RX(0x4951),
+	PSIL_CSI2RX(0x4952),
+	PSIL_CSI2RX(0x4953),
+	PSIL_CSI2RX(0x4954),
+	PSIL_CSI2RX(0x4955),
+	PSIL_CSI2RX(0x4956),
+	PSIL_CSI2RX(0x4957),
+	PSIL_CSI2RX(0x4958),
+	PSIL_CSI2RX(0x4959),
+	PSIL_CSI2RX(0x495a),
+	PSIL_CSI2RX(0x495b),
+	PSIL_CSI2RX(0x495c),
+	PSIL_CSI2RX(0x495d),
+	PSIL_CSI2RX(0x495e),
+	PSIL_CSI2RX(0x495f),
+	PSIL_CSI2RX(0x4960),
+	PSIL_CSI2RX(0x4961),
+	PSIL_CSI2RX(0x4962),
+	PSIL_CSI2RX(0x4963),
+	PSIL_CSI2RX(0x4964),
+	PSIL_CSI2RX(0x4965),
+	PSIL_CSI2RX(0x4966),
+	PSIL_CSI2RX(0x4967),
+	PSIL_CSI2RX(0x4968),
+	PSIL_CSI2RX(0x4969),
+	PSIL_CSI2RX(0x496a),
+	PSIL_CSI2RX(0x496b),
+	PSIL_CSI2RX(0x496c),
+	PSIL_CSI2RX(0x496d),
+	PSIL_CSI2RX(0x496e),
+	PSIL_CSI2RX(0x496f),
+	PSIL_CSI2RX(0x4970),
+	PSIL_CSI2RX(0x4971),
+	PSIL_CSI2RX(0x4972),
+	PSIL_CSI2RX(0x4973),
+	PSIL_CSI2RX(0x4974),
+	PSIL_CSI2RX(0x4975),
+	PSIL_CSI2RX(0x4976),
+	PSIL_CSI2RX(0x4977),
+	PSIL_CSI2RX(0x4978),
+	PSIL_CSI2RX(0x4979),
+	PSIL_CSI2RX(0x497a),
+	PSIL_CSI2RX(0x497b),
+	PSIL_CSI2RX(0x497c),
+	PSIL_CSI2RX(0x497d),
+	PSIL_CSI2RX(0x497e),
+	PSIL_CSI2RX(0x497f),
+	PSIL_CSI2RX(0x4980),
+	PSIL_CSI2RX(0x4981),
+	PSIL_CSI2RX(0x4982),
+	PSIL_CSI2RX(0x4983),
+	PSIL_CSI2RX(0x4984),
+	PSIL_CSI2RX(0x4985),
+	PSIL_CSI2RX(0x4986),
+	PSIL_CSI2RX(0x4987),
+	PSIL_CSI2RX(0x4988),
+	PSIL_CSI2RX(0x4989),
+	PSIL_CSI2RX(0x498a),
+	PSIL_CSI2RX(0x498b),
+	PSIL_CSI2RX(0x498c),
+	PSIL_CSI2RX(0x498d),
+	PSIL_CSI2RX(0x498e),
+	PSIL_CSI2RX(0x498f),
+	PSIL_CSI2RX(0x4990),
+	PSIL_CSI2RX(0x4991),
+	PSIL_CSI2RX(0x4992),
+	PSIL_CSI2RX(0x4993),
+	PSIL_CSI2RX(0x4994),
+	PSIL_CSI2RX(0x4995),
+	PSIL_CSI2RX(0x4996),
+	PSIL_CSI2RX(0x4997),
+	PSIL_CSI2RX(0x4998),
+	PSIL_CSI2RX(0x4999),
+	PSIL_CSI2RX(0x499a),
+	PSIL_CSI2RX(0x499b),
+	PSIL_CSI2RX(0x499c),
+	PSIL_CSI2RX(0x499d),
+	PSIL_CSI2RX(0x499e),
+	PSIL_CSI2RX(0x499f),
+	/* MAIN_CPSW9G */
+	PSIL_ETHERNET(0x4a00),
+	/* MAIN-SA2UL */
+	PSIL_SA2UL(0x4a40, 0),
+	PSIL_SA2UL(0x4a41, 0),
+	PSIL_SA2UL(0x4a42, 0),
+	PSIL_SA2UL(0x4a43, 0),
+	/* MCU_CPSW0 */
+	PSIL_ETHERNET(0x7000),
+	/* MCU_PDMA0 (MCU_PDMA_MISC_G0) - SPI0 */
+	PSIL_PDMA_XY_PKT(0x7100),
+	PSIL_PDMA_XY_PKT(0x7101),
+	PSIL_PDMA_XY_PKT(0x7102),
+	PSIL_PDMA_XY_PKT(0x7103),
+	/* MCU_PDMA1 (MCU_PDMA_MISC_G1) - SPI1-2 */
+	PSIL_PDMA_XY_PKT(0x7200),
+	PSIL_PDMA_XY_PKT(0x7201),
+	PSIL_PDMA_XY_PKT(0x7202),
+	PSIL_PDMA_XY_PKT(0x7203),
+	PSIL_PDMA_XY_PKT(0x7204),
+	PSIL_PDMA_XY_PKT(0x7205),
+	PSIL_PDMA_XY_PKT(0x7206),
+	PSIL_PDMA_XY_PKT(0x7207),
+	/* MCU_PDMA2 (MCU_PDMA_MISC_G2) - UART0 */
+	PSIL_PDMA_XY_PKT(0x7300),
+	/* MCU_PDMA_ADC - ADC0-1 */
+	PSIL_PDMA_XY_TR(0x7400),
+	PSIL_PDMA_XY_TR(0x7401),
+	PSIL_PDMA_XY_TR(0x7402),
+	PSIL_PDMA_XY_TR(0x7403),
+	/* MCU_SA2UL */
+	PSIL_SA2UL(0x7500, 0),
+	PSIL_SA2UL(0x7501, 0),
+	PSIL_SA2UL(0x7502, 0),
+	PSIL_SA2UL(0x7503, 0),
+};
+
+/* PSI-L destination thread IDs, used for TX (DMA_MEM_TO_DEV) */
+static struct psil_ep j784s4_dst_ep_map[] = {
+	/* MAIN_CPSW2G */
+	PSIL_ETHERNET(0xc640),
+	PSIL_ETHERNET(0xc641),
+	PSIL_ETHERNET(0xc642),
+	PSIL_ETHERNET(0xc643),
+	PSIL_ETHERNET(0xc644),
+	PSIL_ETHERNET(0xc645),
+	PSIL_ETHERNET(0xc646),
+	PSIL_ETHERNET(0xc647),
+	/* MAIN_CPSW9G */
+	PSIL_ETHERNET(0xca00),
+	PSIL_ETHERNET(0xca01),
+	PSIL_ETHERNET(0xca02),
+	PSIL_ETHERNET(0xca03),
+	PSIL_ETHERNET(0xca04),
+	PSIL_ETHERNET(0xca05),
+	PSIL_ETHERNET(0xca06),
+	PSIL_ETHERNET(0xca07),
+	/* MAIN-SA2UL */
+	PSIL_SA2UL(0xca40, 1),
+	PSIL_SA2UL(0xca41, 1),
+	/* PDMA_SPI_G0 - SPI0-3 */
+	PSIL_PDMA_XY_PKT(0xc600),
+	PSIL_PDMA_XY_PKT(0xc601),
+	PSIL_PDMA_XY_PKT(0xc602),
+	PSIL_PDMA_XY_PKT(0xc603),
+	PSIL_PDMA_XY_PKT(0xc604),
+	PSIL_PDMA_XY_PKT(0xc605),
+	PSIL_PDMA_XY_PKT(0xc606),
+	PSIL_PDMA_XY_PKT(0xc607),
+	PSIL_PDMA_XY_PKT(0xc608),
+	PSIL_PDMA_XY_PKT(0xc609),
+	PSIL_PDMA_XY_PKT(0xc60a),
+	PSIL_PDMA_XY_PKT(0xc60b),
+	PSIL_PDMA_XY_PKT(0xc60c),
+	PSIL_PDMA_XY_PKT(0xc60d),
+	PSIL_PDMA_XY_PKT(0xc60e),
+	PSIL_PDMA_XY_PKT(0xc60f),
+	/* PDMA_SPI_G1 - SPI4-7 */
+	PSIL_PDMA_XY_PKT(0xc620),
+	PSIL_PDMA_XY_PKT(0xc621),
+	PSIL_PDMA_XY_PKT(0xc622),
+	PSIL_PDMA_XY_PKT(0xc623),
+	PSIL_PDMA_XY_PKT(0xc624),
+	PSIL_PDMA_XY_PKT(0xc625),
+	PSIL_PDMA_XY_PKT(0xc626),
+	PSIL_PDMA_XY_PKT(0xc627),
+	PSIL_PDMA_XY_PKT(0xc628),
+	PSIL_PDMA_XY_PKT(0xc629),
+	PSIL_PDMA_XY_PKT(0xc62a),
+	PSIL_PDMA_XY_PKT(0xc62b),
+	PSIL_PDMA_XY_PKT(0xc62c),
+	PSIL_PDMA_XY_PKT(0xc62d),
+	PSIL_PDMA_XY_PKT(0xc62e),
+	PSIL_PDMA_XY_PKT(0xc62f),
+	/* MCU_CPSW0 */
+	PSIL_ETHERNET(0xf000),
+	PSIL_ETHERNET(0xf001),
+	PSIL_ETHERNET(0xf002),
+	PSIL_ETHERNET(0xf003),
+	PSIL_ETHERNET(0xf004),
+	PSIL_ETHERNET(0xf005),
+	PSIL_ETHERNET(0xf006),
+	PSIL_ETHERNET(0xf007),
+	/* MCU_PDMA_MISC_G0 - SPI0 */
+	PSIL_PDMA_XY_PKT(0xf100),
+	PSIL_PDMA_XY_PKT(0xf101),
+	PSIL_PDMA_XY_PKT(0xf102),
+	PSIL_PDMA_XY_PKT(0xf103),
+	/* MCU_PDMA_MISC_G1 - SPI1-2 */
+	PSIL_PDMA_XY_PKT(0xf200),
+	PSIL_PDMA_XY_PKT(0xf201),
+	PSIL_PDMA_XY_PKT(0xf202),
+	PSIL_PDMA_XY_PKT(0xf203),
+	PSIL_PDMA_XY_PKT(0xf204),
+	PSIL_PDMA_XY_PKT(0xf205),
+	PSIL_PDMA_XY_PKT(0xf206),
+	PSIL_PDMA_XY_PKT(0xf207),
+	/* MCU_SA2UL */
+	PSIL_SA2UL(0xf500, 1),
+	PSIL_SA2UL(0xf501, 1),
+};
+
+struct psil_ep_map j784s4_ep_map = {
+	.name = "j784s4",
+	.src = j784s4_src_ep_map,
+	.src_count = ARRAY_SIZE(j784s4_src_ep_map),
+	.dst = j784s4_dst_ep_map,
+	.dst_count = ARRAY_SIZE(j784s4_dst_ep_map),
+};
diff --git a/drivers/dma/ti/k3-psil-priv.h b/drivers/dma/ti/k3-psil-priv.h
index abd650bb7600..c383723d1c8f 100644
--- a/drivers/dma/ti/k3-psil-priv.h
+++ b/drivers/dma/ti/k3-psil-priv.h
@@ -44,5 +44,6 @@ extern struct psil_ep_map am64_ep_map;
 extern struct psil_ep_map j721s2_ep_map;
 extern struct psil_ep_map am62_ep_map;
 extern struct psil_ep_map am62a_ep_map;
+extern struct psil_ep_map j784s4_ep_map;
 
 #endif /* K3_PSIL_PRIV_H_ */
diff --git a/drivers/dma/ti/k3-psil.c b/drivers/dma/ti/k3-psil.c
index 2da6988a0e7b..c11389d67a3f 100644
--- a/drivers/dma/ti/k3-psil.c
+++ b/drivers/dma/ti/k3-psil.c
@@ -25,6 +25,7 @@ static const struct soc_device_attribute k3_soc_devices[] = {
 	{ .family = "J721S2", .data = &j721s2_ep_map },
 	{ .family = "AM62X", .data = &am62_ep_map },
 	{ .family = "AM62AX", .data = &am62a_ep_map },
+	{ .family = "J784S4", .data = &j784s4_ep_map },
 	{ /* sentinel */ }
 };
 
diff --git a/drivers/dma/ti/k3-udma.c b/drivers/dma/ti/k3-udma.c
index 7e23a6fdef95..158568b96026 100644
--- a/drivers/dma/ti/k3-udma.c
+++ b/drivers/dma/ti/k3-udma.c
@@ -4412,6 +4412,7 @@ static const struct soc_device_attribute k3_soc_devices[] = {
 	{ .family = "J721S2", .data = &j721e_soc_data},
 	{ .family = "AM62X", .data = &am64_soc_data },
 	{ .family = "AM62AX", .data = &am64_soc_data },
+	{ .family = "J784S4", .data = &j721e_soc_data },
 	{ /* sentinel */ }
 };
 
-- 
2.25.1

