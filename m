Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 168B05841C1
	for <lists+dmaengine@lfdr.de>; Thu, 28 Jul 2022 16:36:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232677AbiG1OgX (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 28 Jul 2022 10:36:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232672AbiG1OfN (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 28 Jul 2022 10:35:13 -0400
Received: from mail.baikalelectronics.com (unknown [87.245.175.230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id D24533ED7C
        for <dmaengine@vger.kernel.org>; Thu, 28 Jul 2022 07:34:33 -0700 (PDT)
Received: from mail (mail.baikal.int [192.168.51.25])
        by mail.baikalelectronics.com (Postfix) with ESMTP id 2057616DE;
        Thu, 28 Jul 2022 17:31:16 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.baikalelectronics.com 2057616DE
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baikalelectronics.ru; s=mail; t=1659018676;
        bh=gKOPr/xuLhCELjptpSfrnNROEmHdQ+xNEmt1j+Bk/Hg=;
        h=From:To:CC:Subject:Date:In-Reply-To:References:From;
        b=S8IMNbXpcqYOR+CcR0xYN8KD9oHG//MyDIk+aJYJMX/TRdE9dDqrU4Q1W/JtcoKmv
         T7ol2cgC1KOq0OYav9kfsX3oP3K5yB0j5qwXb6NbIUwYWPgzljBUjgWK2SQlhqR6aa
         7evjMs7wdU3usya1u8kMZ2KdqjT8XnNEB+h7PKzM=
Received: from localhost (192.168.53.207) by mail (192.168.51.25) with
 Microsoft SMTP Server (TLS) id 15.0.1395.4; Thu, 28 Jul 2022 17:28:51 +0300
From:   Serge Semin <Sergey.Semin@baikalelectronics.ru>
To:     Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Vinod Koul <vkoul@kernel.org>, Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Jingoo Han <jingoohan1@gmail.com>, Frank Li <Frank.Li@nxp.com>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
CC:     Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        Serge Semin <fancer.lancer@gmail.com>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Pavel Parkhomenko <Pavel.Parkhomenko@baikalelectronics.ru>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        <linux-pci@vger.kernel.org>, <dmaengine@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v4 07/24] dmaengine: dw-edma: Add CPU to PCIe bus address translation
Date:   Thu, 28 Jul 2022 17:28:24 +0300
Message-ID: <20220728142841.12305-8-Sergey.Semin@baikalelectronics.ru>
In-Reply-To: <20220728142841.12305-1-Sergey.Semin@baikalelectronics.ru>
References: <20220728142841.12305-1-Sergey.Semin@baikalelectronics.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MAIL.baikal.int (192.168.51.25) To mail (192.168.51.25)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,T_SPF_PERMERROR
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Starting from commit 9575632052ba ("dmaengine: make slave address
physical") the source and destination addresses of the DMA-slave device
have been converted to being defined in CPU address space. It's DMA-device
driver responsibility to properly convert them to the reachable DMA bus
spaces. In case of the DW eDMA device, the source or destination
peripheral (slave) devices reside PCIe bus space. Thus we need to perform
the PCIe Host/EP windows-based (i.e. ranges DT-property) addresses
translation otherwise the eDMA transactions won't work as expected (or can
be even harmful) in case if the CPU and PCIe address spaces don't match.

Note 1. Even though the DMA interleaved template has both source and
destination addresses declared of dma_addr_t type only CPU memory range is
supposed to be mapped in a way so to be seen by the DMA device since it's
a subject of the DMA getting towards the system side. The device part must
not be mapped since slave device resides in the PCIe bus space, which
isn't affected by IOMMUs or iATU translations. DW PCIe eDMA generates
corresponding MWr/MRd TLPs on its own.

Note 2. This functionality is mainly required for the remote eDMA setup
since the CPU address must be manually translated into the PCIe bus space
before being written to LLI.{SAR,DAR}. If eDMA is embedded into the
locally accessible DW PCIe RP/EP software-based translation isn't required
since it will be done by hardware by means of the Outbound iATU as long as
the DMA_BYPASS flag is cleared. If the later flag is set or there is no
Outbound iATU entry found to which the SAR or DAR falls in (for Read and
Write channel respectfully), there won't be any translation performed but
DMA will proceed with the corresponding source/destination address as is.

Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>
Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Tested-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Acked-By: Vinod Koul <vkoul@kernel.org>
---
 drivers/dma/dw-edma/dw-edma-core.c | 18 +++++++++++++++++-
 include/linux/dma/edma.h           | 15 +++++++++++++++
 2 files changed, 32 insertions(+), 1 deletion(-)

diff --git a/drivers/dma/dw-edma/dw-edma-core.c b/drivers/dma/dw-edma/dw-edma-core.c
index ef49deb5a7f3..be466b781376 100644
--- a/drivers/dma/dw-edma/dw-edma-core.c
+++ b/drivers/dma/dw-edma/dw-edma-core.c
@@ -40,6 +40,17 @@ struct dw_edma_desc *vd2dw_edma_desc(struct virt_dma_desc *vd)
 	return container_of(vd, struct dw_edma_desc, vd);
 }
 
+static inline
+u64 dw_edma_get_pci_address(struct dw_edma_chan *chan, phys_addr_t cpu_addr)
+{
+	struct dw_edma_chip *chip = chan->dw->chip;
+
+	if (chip->ops->pci_address)
+		return chip->ops->pci_address(chip->dev, cpu_addr);
+
+	return cpu_addr;
+}
+
 static struct dw_edma_burst *dw_edma_alloc_burst(struct dw_edma_chunk *chunk)
 {
 	struct dw_edma_burst *burst;
@@ -328,11 +339,11 @@ dw_edma_device_transfer(struct dw_edma_transfer *xfer)
 {
 	struct dw_edma_chan *chan = dchan2dw_edma_chan(xfer->dchan);
 	enum dma_transfer_direction dir = xfer->direction;
-	phys_addr_t src_addr, dst_addr;
 	struct scatterlist *sg = NULL;
 	struct dw_edma_chunk *chunk;
 	struct dw_edma_burst *burst;
 	struct dw_edma_desc *desc;
+	u64 src_addr, dst_addr;
 	size_t fsz = 0;
 	u32 cnt = 0;
 	int i;
@@ -407,6 +418,11 @@ dw_edma_device_transfer(struct dw_edma_transfer *xfer)
 		dst_addr = chan->config.dst_addr;
 	}
 
+	if (dir == DMA_DEV_TO_MEM)
+		src_addr = dw_edma_get_pci_address(chan, (phys_addr_t)src_addr);
+	else
+		dst_addr = dw_edma_get_pci_address(chan, (phys_addr_t)dst_addr);
+
 	if (xfer->type == EDMA_XFER_CYCLIC) {
 		cnt = xfer->xfer.cyclic.cnt;
 	} else if (xfer->type == EDMA_XFER_SCATTER_GATHER) {
diff --git a/include/linux/dma/edma.h b/include/linux/dma/edma.h
index 7102a870a159..52046b74c0a0 100644
--- a/include/linux/dma/edma.h
+++ b/include/linux/dma/edma.h
@@ -23,8 +23,23 @@ struct dw_edma_region {
 	size_t		sz;
 };
 
+/**
+ * struct dw_edma_core_ops - platform-specific eDMA methods
+ * @irq_vector:		Get IRQ number of the passed eDMA channel. Note the
+ *                      method accepts the channel id in the end-to-end
+ *                      numbering with the eDMA write channels being placed
+ *                      first in the row.
+ * @pci_address:	Get PCIe bus address corresponding to the passed CPU
+ *			address. Note there is no need in specifying this
+ *			function if the address translation is performed by
+ *			the DW PCIe RP/EP controller with the DW eDMA device in
+ *			subject and DMA_BYPASS isn't set for all the outbound
+ *			iATU windows. That will be done by the controller
+ *			automatically.
+ */
 struct dw_edma_core_ops {
 	int (*irq_vector)(struct device *dev, unsigned int nr);
+	u64 (*pci_address)(struct device *dev, phys_addr_t cpu_addr);
 };
 
 enum dw_edma_map_format {
-- 
2.35.1

