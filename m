Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A70D4E9CBF
	for <lists+dmaengine@lfdr.de>; Mon, 28 Mar 2022 18:52:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243410AbiC1QqS (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 28 Mar 2022 12:46:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242943AbiC1QqE (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 28 Mar 2022 12:46:04 -0400
Received: from mail.baikalelectronics.ru (mail.baikalelectronics.com [87.245.175.226])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 7AF962251A;
        Mon, 28 Mar 2022 09:44:17 -0700 (PDT)
Received: from mail.baikalelectronics.ru (unknown [192.168.51.25])
        by mail.baikalelectronics.ru (Postfix) with ESMTP id 15FF11E493B;
        Thu, 24 Mar 2022 04:48:39 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.baikalelectronics.ru 15FF11E493B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baikalelectronics.ru; s=mail; t=1648086519;
        bh=qeD0LQB5yz0tEnI7peM/retOGT3xKLiWnq9l84RaXtg=;
        h=From:To:CC:Subject:Date:In-Reply-To:References:From;
        b=pxMDwJ2d7YWS6glR8disDs7jCpmDaCgVA+5xJkDkOkmGxoz2qgRmveWL/Gu+8h+DS
         PVLhOsTKdCB/8/sfAGRbN9vLfWr0naiLFzI3GpZSKHllo1KcseFSI0z5btzIEztT5D
         3qHlEjo6fE/SDvrCCK2B9sNCaHfz1Y1UkXRXDum8=
Received: from localhost (192.168.168.10) by mail (192.168.51.25) with
 Microsoft SMTP Server (TLS) id 15.0.1395.4; Thu, 24 Mar 2022 04:48:38 +0300
From:   Serge Semin <Sergey.Semin@baikalelectronics.ru>
To:     Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Vinod Koul <vkoul@kernel.org>,
        Jingoo Han <jingoohan1@gmail.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Frank Li <Frank.Li@nxp.com>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
CC:     Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        Serge Semin <fancer.lancer@gmail.com>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Pavel Parkhomenko <Pavel.Parkhomenko@baikalelectronics.ru>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        <linux-pci@vger.kernel.org>, <dmaengine@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH 01/25] dmaengine: dw-edma: Drop dma_slave_config.direction field usage
Date:   Thu, 24 Mar 2022 04:48:12 +0300
Message-ID: <20220324014836.19149-2-Sergey.Semin@baikalelectronics.ru>
In-Reply-To: <20220324014836.19149-1-Sergey.Semin@baikalelectronics.ru>
References: <20220324014836.19149-1-Sergey.Semin@baikalelectronics.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MAIL.baikal.int (192.168.51.25) To mail (192.168.51.25)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

The dma_slave_config.direction field usage in the DW eDMA driver has been
introduced in the commit bd96f1b2f43a ("dmaengine: dw-edma: support local
dma device transfer semantics"). Mainly the change introduced there was
correct (indeed DEV_TO_MEM means using RD-channel and MEM_TO_DEV -
WR-channel for the case of having eDMA accessed locally from
CPU/Application side), but providing an additional
MEM_TO_MEM/DEV_TO_DEV-based semantics was quite redundant if not to say
potentially harmful (when it comes to removing the denoted field). First
of all since the dma_slave_config.direction field has been marked as
obsolete (see [1] and the structure dc [2]) and will be discarded in
future, using it especially in a non-standard way is discouraged. Secondly
in accordance with the commit denoted above the default
dw_edma_device_transfer() semantics has been changed despite what it's
message said. So claiming that the method was left backward compatible was
wrong.

Anyway let's fix the problems denoted above and simplify the
dw_edma_device_transfer() method by dropping the parsing of the
DMA-channel direction field. Instead of having that implicit
dma_slave_config.direction field semantic we can use the recently added
DW_EDMA_CHIP_LOCAL flag to distinguish between the local and remote DW
eDMA setups thus preserving both cases support. In addition to that an
ASCII-figure has been added to clarify the complication out.

[1] Documentation/driver-api/dmaengine/provider.rst
[2] include/linux/dmaengine.h: dma_slave_config.direction

Co-developed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>

---

In accordance with agreement with Frank and Manivannan this patch is
supposed to be moved to the series:
Link: https://lore.kernel.org/dmaengine/20220310192457.3090-1-Frank.Li@nxp.com/
in place of the patch:
[PATCH v5 6/9] dmaengine: dw-edma: Don't rely on the deprecated "direction" member
Link: https://lore.kernel.org/dmaengine/20220310192457.3090-7-Frank.Li@nxp.com/
---
 drivers/dma/dw-edma/dw-edma-core.c | 49 +++++++++++++++++++++---------
 1 file changed, 34 insertions(+), 15 deletions(-)

diff --git a/drivers/dma/dw-edma/dw-edma-core.c b/drivers/dma/dw-edma/dw-edma-core.c
index 5be8a5944714..e9e32ed74aa9 100644
--- a/drivers/dma/dw-edma/dw-edma-core.c
+++ b/drivers/dma/dw-edma/dw-edma-core.c
@@ -339,21 +339,40 @@ dw_edma_device_transfer(struct dw_edma_transfer *xfer)
 	if (!chan->configured)
 		return NULL;
 
-	switch (chan->config.direction) {
-	case DMA_DEV_TO_MEM: /* local DMA */
-		if (dir == DMA_DEV_TO_MEM && chan->dir == EDMA_DIR_READ)
-			break;
-		return NULL;
-	case DMA_MEM_TO_DEV: /* local DMA */
-		if (dir == DMA_MEM_TO_DEV && chan->dir == EDMA_DIR_WRITE)
-			break;
-		return NULL;
-	default: /* remote DMA */
-		if (dir == DMA_MEM_TO_DEV && chan->dir == EDMA_DIR_READ)
-			break;
-		if (dir == DMA_DEV_TO_MEM && chan->dir == EDMA_DIR_WRITE)
-			break;
-		return NULL;
+	/*
+	 * Local Root Port/End-point              Remote End-point
+	 * +-----------------------+ PCIe bus +----------------------+
+	 * |                       |    +-+   |                      |
+	 * |    DEV_TO_MEM   Rx Ch <----+ +---+ Tx Ch  DEV_TO_MEM    |
+	 * |                       |    | |   |                      |
+	 * |    MEM_TO_DEV   Tx Ch +----+ +---> Rx Ch  MEM_TO_DEV    |
+	 * |                       |    +-+   |                      |
+	 * +-----------------------+          +----------------------+
+	 *
+	 * 1. Normal logic:
+	 * If eDMA is embedded into the DW PCIe RP/EP and controlled from the
+	 * CPU/Application side, the Rx channel (EDMA_DIR_READ) will be used
+	 * for the device read operations (DEV_TO_MEM) and the Tx channel
+	 * (EDMA_DIR_WRITE) - for the write operations (MEM_TO_DEV).
+	 *
+	 * 2. Inverted logic:
+	 * If eDMA is embedded into a Remote PCIe EP and is controlled by the
+	 * MWr/MRd TLPs sent from the CPU's PCIe host controller, the Tx
+	 * channel (EDMA_DIR_WRITE) will be used for the device read operations
+	 * (DEV_TO_MEM) and the Rx channel (EDMA_DIR_READ) - for the write
+	 * operations (MEM_TO_DEV).
+	 *
+	 * It is the client driver responsibility to choose a proper channel
+	 * for the DMA transfers.
+	 */
+	if (chan->dw->chip->flags & DW_EDMA_CHIP_LOCAL) {
+		if ((chan->dir == EDMA_DIR_READ && dir != DMA_DEV_TO_MEM) ||
+		    (chan->dir == EDMA_DIR_WRITE && dir != DMA_MEM_TO_DEV))
+			return NULL;
+	} else {
+		if ((chan->dir == EDMA_DIR_WRITE && dir != DMA_DEV_TO_MEM) ||
+		    (chan->dir == EDMA_DIR_READ && dir != DMA_MEM_TO_DEV))
+			return NULL;
 	}
 
 	if (xfer->type == EDMA_XFER_CYCLIC) {
-- 
2.35.1

