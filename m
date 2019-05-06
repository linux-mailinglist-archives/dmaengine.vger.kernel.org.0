Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8361A149C2
	for <lists+dmaengine@lfdr.de>; Mon,  6 May 2019 14:36:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726506AbfEFMfv (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 6 May 2019 08:35:51 -0400
Received: from lelv0142.ext.ti.com ([198.47.23.249]:51652 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726504AbfEFMfu (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 6 May 2019 08:35:50 -0400
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id x46CZfDV017952;
        Mon, 6 May 2019 07:35:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1557146141;
        bh=8aDyln+tva0twlHMQ4A9ci2qDy3svDO4SbE9n9FaL0E=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=ZXbFznSfybn+a3X80pspSyGWIv2xuyxSbGsOm70jnGNpbsIptk8XyK7COR19qsRRx
         91R5b5/QoYJkSgS4TFdWEHQ6gkeljIteLrwFo2uE8X3Xm8HCkFH8gL/jAVpFIqMGDw
         5QZGmsOrClwwnEF4YcIwD53cBBKJTFClqnX0S8BA=
Received: from DLEE104.ent.ti.com (dlee104.ent.ti.com [157.170.170.34])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x46CZf2Y024842
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 6 May 2019 07:35:41 -0500
Received: from DLEE112.ent.ti.com (157.170.170.23) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5; Mon, 6 May
 2019 07:35:40 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DLEE112.ent.ti.com
 (157.170.170.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5 via
 Frontend Transport; Mon, 6 May 2019 07:35:40 -0500
Received: from feketebors.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id x46CYpUL110286;
        Mon, 6 May 2019 07:35:38 -0500
From:   Peter Ujfalusi <peter.ujfalusi@ti.com>
To:     <vkoul@kernel.org>, <robh+dt@kernel.org>, <nm@ti.com>,
        <ssantosh@kernel.org>
CC:     <dan.j.williams@intel.com>, <dmaengine@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <grygorii.strashko@ti.com>, <lokeshvutla@ti.com>,
        <t-kristo@ti.com>, <tony@atomide.com>
Subject: [PATCH 15/16] dmaengine: ti: New driver for K3 UDMA - split#6: Kconfig and Makefile
Date:   Mon, 6 May 2019 15:34:55 +0300
Message-ID: <20190506123456.6777-16-peter.ujfalusi@ti.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190506123456.6777-1-peter.ujfalusi@ti.com>
References: <20190506123456.6777-1-peter.ujfalusi@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Split patch for review containing:
Kconfig and Makefile changes

DMA driver for
Texas Instruments K3 NAVSS Unified DMA – Peripheral Root Complex (UDMA-P)

The UDMA-P is intended to perform similar (but significantly upgraded) functions
as the packet-oriented DMA used on previous SoC devices. The UDMA-P module
supports the transmission and reception of various packet types. The UDMA-P is
architected to facilitate the segmentation and reassembly of SoC DMA data
structure compliant packets to/from smaller data blocks that are natively
compatible with the specific requirements of each connected peripheral. Multiple
Tx and Rx channels are provided within the DMA which allow multiple segmentation
or reassembly operations to be ongoing. The DMA controller maintains state
information for each of the channels which allows packet segmentation and
reassembly operations to be time division multiplexed between channels in order
to share the underlying DMA hardware. An external DMA scheduler is used to
control the ordering and rate at which this multiplexing occurs for Transmit
operations. The ordering and rate of Receive operations is indirectly controlled
by the order in which blocks are pushed into the DMA on the Rx PSI-L interface.

The UDMA-P also supports acting as both a UTC and UDMA-C for its internal
channels. Channels in the UDMA-P can be configured to be either Packet-Based or
Third-Party channels on a channel by channel basis.

The initial driver supports:
- MEM_TO_MEM (TR mode)
- DEV_TO_MEM (Packet / TR mode)
- MEM_TO_DEV (Packet / TR mode)
- Cyclic (Packet / TR mode)
- Metadata for descriptors

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 drivers/dma/ti/Kconfig  | 13 +++++++++++++
 drivers/dma/ti/Makefile |  1 +
 2 files changed, 14 insertions(+)

diff --git a/drivers/dma/ti/Kconfig b/drivers/dma/ti/Kconfig
index e5e74e1361dc..4542eae64cf2 100644
--- a/drivers/dma/ti/Kconfig
+++ b/drivers/dma/ti/Kconfig
@@ -33,5 +33,18 @@ config DMA_OMAP
 	  Enable support for the TI sDMA (System DMA or DMA4) controller. This
 	  DMA engine is found on OMAP and DRA7xx parts.
 
+config TI_K3_UDMA
+	tristate "Texas Instruments UDMA support"
+	depends on ARCH_K3 || COMPILE_TEST
+	depends on TI_SCI_PROTOCOL
+	depends on TI_SCI_INTA_IRQCHIP
+	select DMA_ENGINE
+	select DMA_VIRTUAL_CHANNELS
+	select TI_K3_RINGACC
+	default y
+        help
+	  Enable support for the TI UDMA (Unified DMA) controller. This
+	  DMA engine is used in AM65x.
+
 config TI_DMA_CROSSBAR
 	bool
diff --git a/drivers/dma/ti/Makefile b/drivers/dma/ti/Makefile
index 113e59ec9c32..ebd4822e064e 100644
--- a/drivers/dma/ti/Makefile
+++ b/drivers/dma/ti/Makefile
@@ -2,4 +2,5 @@
 obj-$(CONFIG_TI_CPPI41) += cppi41.o
 obj-$(CONFIG_TI_EDMA) += edma.o
 obj-$(CONFIG_DMA_OMAP) += omap-dma.o
+obj-$(CONFIG_TI_K3_UDMA) += k3-udma.o
 obj-$(CONFIG_TI_DMA_CROSSBAR) += dma-crossbar.o
-- 
Peter

Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki

