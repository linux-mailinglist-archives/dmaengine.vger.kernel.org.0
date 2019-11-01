Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 862D5EBF94
	for <lists+dmaengine@lfdr.de>; Fri,  1 Nov 2019 09:41:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728108AbfKAIla (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 1 Nov 2019 04:41:30 -0400
Received: from lelv0143.ext.ti.com ([198.47.23.248]:34874 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728242AbfKAIla (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 1 Nov 2019 04:41:30 -0400
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id xA18fNFi021460;
        Fri, 1 Nov 2019 03:41:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1572597683;
        bh=EhFkztpAXr99tdQOKA4eamtWfuHwfN2ZGnP4SNgOkUE=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=Qzyh9deX5WDxYdL6IHLD9xdkCnJnQUJulNAe+ci4NoZPuCZbheQaK+uhEkpxyhTxu
         C2iLYUcE72XDhp9EjVYIvnbZpCI7mQiARyUK17N6Rm+IWB9A8leoUn5J25jJrjtoO2
         NJQwq2X8Vrh0d0TgzgOZzre+pelTbjzEeIZPhgFk=
Received: from DFLE100.ent.ti.com (dfle100.ent.ti.com [10.64.6.21])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id xA18fNoH047655
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 1 Nov 2019 03:41:23 -0500
Received: from DFLE110.ent.ti.com (10.64.6.31) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5; Fri, 1 Nov
 2019 03:41:09 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DFLE110.ent.ti.com
 (10.64.6.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5 via
 Frontend Transport; Fri, 1 Nov 2019 03:41:09 -0500
Received: from feketebors.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id xA18eP8n036903;
        Fri, 1 Nov 2019 03:41:19 -0500
From:   Peter Ujfalusi <peter.ujfalusi@ti.com>
To:     <vkoul@kernel.org>, <robh+dt@kernel.org>, <nm@ti.com>,
        <ssantosh@kernel.org>
CC:     <dan.j.williams@intel.com>, <dmaengine@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <grygorii.strashko@ti.com>, <lokeshvutla@ti.com>,
        <t-kristo@ti.com>, <tony@atomide.com>, <j-keerthy@ti.com>
Subject: [PATCH v4 14/15] dmaengine: ti: New driver for K3 UDMA - split#6: Kconfig and Makefile
Date:   Fri, 1 Nov 2019 10:41:34 +0200
Message-ID: <20191101084135.14811-15-peter.ujfalusi@ti.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191101084135.14811-1-peter.ujfalusi@ti.com>
References: <20191101084135.14811-1-peter.ujfalusi@ti.com>
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
 drivers/dma/ti/Kconfig  | 14 ++++++++++++++
 drivers/dma/ti/Makefile |  1 +
 2 files changed, 15 insertions(+)

diff --git a/drivers/dma/ti/Kconfig b/drivers/dma/ti/Kconfig
index 72f3d2728178..04c98e215ba6 100644
--- a/drivers/dma/ti/Kconfig
+++ b/drivers/dma/ti/Kconfig
@@ -34,6 +34,20 @@ config DMA_OMAP
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
+	select TI_K3_PSIL
+	default y
+        help
+	  Enable support for the TI UDMA (Unified DMA) controller. This
+	  DMA engine is used in AM65x.
+
 config TI_K3_PSIL
 	bool
 
diff --git a/drivers/dma/ti/Makefile b/drivers/dma/ti/Makefile
index f8d912ad7eaf..9d787f009195 100644
--- a/drivers/dma/ti/Makefile
+++ b/drivers/dma/ti/Makefile
@@ -2,5 +2,6 @@
 obj-$(CONFIG_TI_CPPI41) += cppi41.o
 obj-$(CONFIG_TI_EDMA) += edma.o
 obj-$(CONFIG_DMA_OMAP) += omap-dma.o
+obj-$(CONFIG_TI_K3_UDMA) += k3-udma.o
 obj-$(CONFIG_TI_K3_PSIL) += k3-psil.o k3-psil-am654.o k3-psil-j721e.o
 obj-$(CONFIG_TI_DMA_CROSSBAR) += dma-crossbar.o
-- 
Peter

Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki

