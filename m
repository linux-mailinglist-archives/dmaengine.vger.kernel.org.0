Return-Path: <dmaengine+bounces-5024-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A41FCA9E913
	for <lists+dmaengine@lfdr.de>; Mon, 28 Apr 2025 09:21:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CF7313BA83B
	for <lists+dmaengine@lfdr.de>; Mon, 28 Apr 2025 07:21:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 572421DDC23;
	Mon, 28 Apr 2025 07:21:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="r0heJAOv"
X-Original-To: dmaengine@vger.kernel.org
Received: from lelvem-ot01.ext.ti.com (lelvem-ot01.ext.ti.com [198.47.23.234])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71A861D5AC6;
	Mon, 28 Apr 2025 07:21:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.234
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745824889; cv=none; b=aneRc0k2xnqRq74AEv5aE5mW6TnEe3jioOM3ff9CEKHrp5cPJ55vfQNj0FaVvMqecokIS6vb9ilx2mpjI3E2hIpoBytqE05/bCoDqszcCgFRrLLc1lVanwCtoEaATmWUmtNfu7ZAEdSCil2dRgr9uSf1BtPsZbZQ8ukxAh7RafM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745824889; c=relaxed/simple;
	bh=b4gr6GJDTCdFqz+GIIsR8/t+wBTMzYnL6Bpxe2rVhmw=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tYH0otynE/2be+lPplf+gqJw0AS9ZXpkZWQeIaVZjxdvCdpLGZ6U/B9HqZnjvxev5uzbm2ejbg6IJFoaaPrK+6Cv8kG0iLrbJ9Q+qYp3MIMeS1gOa+s1wXTM+4bbSMUDxK763C8xZAbyf66W0WdqpN/Bxo/Iu63ZghakgNYQvgc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=r0heJAOv; arc=none smtp.client-ip=198.47.23.234
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
	by lelvem-ot01.ext.ti.com (8.15.2/8.15.2) with ESMTPS id 53S7LFp02713999
	(version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 28 Apr 2025 02:21:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1745824875;
	bh=FazsueVaj+YhhF+9bYhnapWdoUDSbmNSp2aLiF/uiLo=;
	h=From:To:Subject:Date:In-Reply-To:References;
	b=r0heJAOviv+TG126zn1S1REfyWVEpYO/OF4Vh8lzX+hB8Q4N2zVIpJHk0k8RKtBPk
	 IDBNL2FAZ1G+s5lZoUejr9VysNLc+VTuRw3Q/4hVqIDV7KyOuWdv3SOXIIvJXljWOD
	 wispgbMOLoVIYNHMebXgp16ti6GdMnABHwojy5vA=
Received: from DFLE102.ent.ti.com (dfle102.ent.ti.com [10.64.6.23])
	by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 53S7LEbs003563
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 28 Apr 2025 02:21:14 -0500
Received: from DFLE107.ent.ti.com (10.64.6.28) by DFLE102.ent.ti.com
 (10.64.6.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 28
 Apr 2025 02:21:14 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE107.ent.ti.com
 (10.64.6.28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 28 Apr 2025 02:21:14 -0500
Received: from uda0498651.dhcp.ti.com (uda0498651.dhcp.ti.com [172.24.227.7])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 53S7KdMd068873;
	Mon, 28 Apr 2025 02:21:10 -0500
From: Sai Sree Kartheek Adivi <s-adivi@ti.com>
To: <peter.ujfalusi@gmail.com>, <vkoul@kernel.org>, <robh@kernel.org>,
        <krzk+dt@kernel.org>, <conor+dt@kernel.org>, <nm@ti.com>,
        <ssantosh@kernel.org>, <s-adivi@ti.com>, <dmaengine@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <praneeth@ti.com>,
        <vigneshr@ti.com>, <u-kumar1@ti.com>, <a-chavda@ti.com>
Subject: [PATCH 4/8] dmaengine: ti: k3-psil-am62l: Add AM62Lx PSIL and PDMA data
Date: Mon, 28 Apr 2025 12:50:28 +0530
Message-ID: <20250428072032.946008-5-s-adivi@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250428072032.946008-1-s-adivi@ti.com>
References: <20250428072032.946008-1-s-adivi@ti.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

Add PSIL and PDMA data for AM62Lx SoC.

Signed-off-by: Sai Sree Kartheek Adivi <s-adivi@ti.com>
---
 drivers/dma/ti/Makefile        |   1 +
 drivers/dma/ti/k3-psil-am62l.c | 132 +++++++++++++++++++++++++++++++++
 drivers/dma/ti/k3-psil-priv.h  |   1 +
 drivers/dma/ti/k3-psil.c       |   1 +
 4 files changed, 135 insertions(+)
 create mode 100644 drivers/dma/ti/k3-psil-am62l.c

diff --git a/drivers/dma/ti/Makefile b/drivers/dma/ti/Makefile
index 257e8141d7fe0..b03235a78d6cc 100644
--- a/drivers/dma/ti/Makefile
+++ b/drivers/dma/ti/Makefile
@@ -12,6 +12,7 @@ k3-psil-lib-objs := k3-psil.o \
 		    k3-psil-j721s2.o \
 		    k3-psil-am62.o \
 		    k3-psil-am62a.o \
+		    k3-psil-am62l.o \
 		    k3-psil-j784s4.o \
 		    k3-psil-am62p.o
 obj-$(CONFIG_TI_K3_PSIL) += k3-psil-lib.o
diff --git a/drivers/dma/ti/k3-psil-am62l.c b/drivers/dma/ti/k3-psil-am62l.c
new file mode 100644
index 0000000000000..45f5aac32f6a0
--- /dev/null
+++ b/drivers/dma/ti/k3-psil-am62l.c
@@ -0,0 +1,132 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ *  Copyright (C) 2024-2025 Texas Instruments Incorporated - https://www.ti.com
+ */
+
+#include <linux/kernel.h>
+
+#include "k3-psil-priv.h"
+
+#define PSIL_PDMA_XY_TR(x, ch)					\
+	{							\
+		.thread_id = x,					\
+		.ep_config = {					\
+			.ep_type = PSIL_EP_PDMA_XY,		\
+			.mapped_channel_id = ch,		\
+			.default_flow_id = -1,			\
+		},						\
+	}
+
+#define PSIL_PDMA_XY_PKT(x, ch)					\
+	{							\
+		.thread_id = x,					\
+		.ep_config = {					\
+			.ep_type = PSIL_EP_PDMA_XY,		\
+			.mapped_channel_id = ch,		\
+			.pkt_mode = 1,				\
+			.default_flow_id = -1			\
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
+#define PSIL_PDMA_MCASP(x, ch)				\
+	{						\
+		.thread_id = x,				\
+		.ep_config = {				\
+			.ep_type = PSIL_EP_PDMA_XY,	\
+			.pdma_acc32 = 1,		\
+			.pdma_burst = 1,		\
+			.mapped_channel_id = ch,	\
+		},					\
+	}
+
+/* PSI-L source thread IDs, used for RX (DMA_DEV_TO_MEM) */
+static struct psil_ep am62l_src_ep_map[] = {
+	/* PDMA_MAIN1 - UART0-6 */
+	PSIL_PDMA_XY_PKT(0x4400, 0),
+	PSIL_PDMA_XY_PKT(0x4401, 2),
+	PSIL_PDMA_XY_PKT(0x4402, 4),
+	PSIL_PDMA_XY_PKT(0x4403, 6),
+	PSIL_PDMA_XY_PKT(0x4404, 8),
+	PSIL_PDMA_XY_PKT(0x4405, 10),
+	PSIL_PDMA_XY_PKT(0x4406, 12),
+	/* PDMA_MAIN0 - SPI0 - CH0-3 */
+	PSIL_PDMA_XY_TR(0x4300, 16),
+	/* PDMA_MAIN0 - SPI1 - CH0-3 */
+	PSIL_PDMA_XY_TR(0x4301, 24),
+	/* PDMA_MAIN0 - SPI2 - CH0-3 */
+	PSIL_PDMA_XY_TR(0x4302, 32),
+	/* PDMA_MAIN0 - SPI3 - CH0-3 */
+	PSIL_PDMA_XY_TR(0x4303, 40),
+	/* PDMA_MAIN2 - MCASP0-2 */
+	PSIL_PDMA_MCASP(0x4500, 48),
+	PSIL_PDMA_MCASP(0x4501, 50),
+	PSIL_PDMA_MCASP(0x4502, 52),
+	/* PDMA_MAIN0 - AES */
+	PSIL_PDMA_XY_TR(0x4700, 65),
+	/* PDMA_MAIN0 - ADC */
+	PSIL_PDMA_XY_TR(0x4503, 80),
+	PSIL_PDMA_XY_TR(0x4504, 81),
+	PSIL_ETHERNET(0x4600, 96, 96, 16),
+};
+
+/* PSI-L destination thread IDs, used for TX (DMA_MEM_TO_DEV) */
+static struct psil_ep am62l_dst_ep_map[] = {
+	/* PDMA_MAIN1 - UART0-6 */
+	PSIL_PDMA_XY_PKT(0xC400, 1),
+	PSIL_PDMA_XY_PKT(0xC401, 3),
+	PSIL_PDMA_XY_PKT(0xC402, 5),
+	PSIL_PDMA_XY_PKT(0xC403, 7),
+	PSIL_PDMA_XY_PKT(0xC404, 9),
+	PSIL_PDMA_XY_PKT(0xC405, 11),
+	PSIL_PDMA_XY_PKT(0xC406, 13),
+	/* PDMA_MAIN0 - SPI0 - CH0-3 */
+	PSIL_PDMA_XY_TR(0xC300, 17),
+	/* PDMA_MAIN0 - SPI1 - CH0-3 */
+	PSIL_PDMA_XY_TR(0xC301, 25),
+	/* PDMA_MAIN0 - SPI2 - CH0-3 */
+	PSIL_PDMA_XY_TR(0xC302, 33),
+	/* PDMA_MAIN0 - SPI3 - CH0-3 */
+	PSIL_PDMA_XY_TR(0xC303, 41),
+	/* PDMA_MAIN2 - MCASP0-2 */
+	PSIL_PDMA_MCASP(0xC500, 49),
+	PSIL_PDMA_MCASP(0xC501, 51),
+	PSIL_PDMA_MCASP(0xC502, 53),
+	/* PDMA_MAIN0 - SHA */
+	PSIL_PDMA_XY_TR(0xC700, 64),
+	/* PDMA_MAIN0 - AES */
+	PSIL_PDMA_XY_TR(0xC701, 66),
+	/* PDMA_MAIN0 - CRC32 - CH0-1 */
+	PSIL_PDMA_XY_TR(0xC702, 67),
+	/* CPSW3G */
+	PSIL_ETHERNET(0xc600, 64, 64, 2),
+	PSIL_ETHERNET(0xc601, 66, 66, 2),
+	PSIL_ETHERNET(0xc602, 68, 68, 2),
+	PSIL_ETHERNET(0xc603, 70, 70, 2),
+	PSIL_ETHERNET(0xc604, 72, 72, 2),
+	PSIL_ETHERNET(0xc605, 74, 74, 2),
+	PSIL_ETHERNET(0xc606, 76, 76, 2),
+	PSIL_ETHERNET(0xc607, 78, 78, 2),
+};
+
+struct psil_ep_map am62l_ep_map = {
+	.name = "am62l",
+	.src = am62l_src_ep_map,
+	.src_count = ARRAY_SIZE(am62l_src_ep_map),
+	.dst = am62l_dst_ep_map,
+	.dst_count = ARRAY_SIZE(am62l_dst_ep_map),
+};
diff --git a/drivers/dma/ti/k3-psil-priv.h b/drivers/dma/ti/k3-psil-priv.h
index a577be97e3447..b2eb6d3b63e1b 100644
--- a/drivers/dma/ti/k3-psil-priv.h
+++ b/drivers/dma/ti/k3-psil-priv.h
@@ -44,6 +44,7 @@ extern struct psil_ep_map am64_ep_map;
 extern struct psil_ep_map j721s2_ep_map;
 extern struct psil_ep_map am62_ep_map;
 extern struct psil_ep_map am62a_ep_map;
+extern struct psil_ep_map am62l_ep_map;
 extern struct psil_ep_map j784s4_ep_map;
 extern struct psil_ep_map am62p_ep_map;
 
diff --git a/drivers/dma/ti/k3-psil.c b/drivers/dma/ti/k3-psil.c
index c4b6f0df46861..27c1bf347b248 100644
--- a/drivers/dma/ti/k3-psil.c
+++ b/drivers/dma/ti/k3-psil.c
@@ -25,6 +25,7 @@ static const struct soc_device_attribute k3_soc_devices[] = {
 	{ .family = "J721S2", .data = &j721s2_ep_map },
 	{ .family = "AM62X", .data = &am62_ep_map },
 	{ .family = "AM62AX", .data = &am62a_ep_map },
+	{ .family = "AM62LX", .data = &am62l_ep_map },
 	{ .family = "J784S4", .data = &j784s4_ep_map },
 	{ .family = "AM62PX", .data = &am62p_ep_map },
 	{ .family = "J722S", .data = &am62p_ep_map },
-- 
2.34.1


