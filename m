Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7BBA9368A65
	for <lists+dmaengine@lfdr.de>; Fri, 23 Apr 2021 03:30:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240007AbhDWBbO (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 22 Apr 2021 21:31:14 -0400
Received: from mx07-00376f01.pphosted.com ([185.132.180.163]:62176 "EHLO
        mx07-00376f01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S240006AbhDWBbN (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 22 Apr 2021 21:31:13 -0400
Received: from pps.filterd (m0168889.ppops.net [127.0.0.1])
        by mx07-00376f01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 13N0xc8B008391;
        Fri, 23 Apr 2021 02:19:27 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=imgtec.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=dk201812; bh=XlA+4FJwvL4EmuhKI3jEajb+NI7k0i/aj8fKtHDXVuY=;
 b=EiQ+vftHhrWze6/8+KrZfd/wTJyJ2ea2ojkHtonStb4OfZRevfonDJOUv8/KEUffSXIP
 LU4YYViuINwRfzgaZ0Ya8RsuZVIM43kEA9E6OvNjhNeyq8T3GOa6vnLFLf+U6CUAI336
 tsWVj5iOJc7mmOOaCUN7kWckuzClj236rp0Ayg0EeY+LeSBOc7XvePbkPPotkQ4mvOkG
 g19qoklXwTgqoSojUK4Fhg6qGsMO4BazkGn/5RbbI3Uy5lgz4y2YggPxVAIccxZdW/0n
 NAVH/bQOgo7VvNUvP8bPeOsbnXfPX0AXpWhwI0HchCLU4d+DmDS7Fl4OKQzp3oUI7b0J Eg== 
Received: from hhmail05.hh.imgtec.org ([217.156.249.195])
        by mx07-00376f01.pphosted.com with ESMTP id 382p9395yh-4
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Fri, 23 Apr 2021 02:19:27 +0100
Received: from adrianlarumbe-HP-Elite-7500-Series-MT.hh.imgtec.org
 (10.100.70.86) by HHMAIL05.hh.imgtec.org (10.100.10.120) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Fri, 23 Apr 2021 02:19:25 +0100
From:   Adrian Larumbe <adrian.martinezlarumbe@imgtec.com>
To:     <vkoul@kernel.org>, <dmaengine@vger.kernel.org>
CC:     <michal.simek@xilinx.com>, <linux-arm-kernel@lists.infradead.org>,
        <adrian.martinezlarumbe@imgtec.com>
Subject: [PATCH 3/4] dmaengine: xilinx_dma: Add CDMA SG transfer support
Date:   Fri, 23 Apr 2021 02:19:12 +0100
Message-ID: <20210423011913.13122-4-adrian.martinezlarumbe@imgtec.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210423011913.13122-1-adrian.martinezlarumbe@imgtec.com>
References: <20210423011913.13122-1-adrian.martinezlarumbe@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.100.70.86]
X-ClientProxiedBy: HHMAIL05.hh.imgtec.org (10.100.10.120) To
 HHMAIL05.hh.imgtec.org (10.100.10.120)
X-EXCLAIMER-MD-CONFIG: 15a78312-3e47-46eb-9010-2e54d84a9631
X-Proofpoint-GUID: pKvPiUeNmStKTaGDpMW4RbWm-ygOPVd9
X-Proofpoint-ORIG-GUID: pKvPiUeNmStKTaGDpMW4RbWm-ygOPVd9
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

CDMA devices have built-in SG capability, but it was not leveraged by the
driver. It adds a new binding for CDMA's device_prep_slave_sg, which
looks up the memory address supplied in a previous call to
dmaengine_slave_config as the beginning of a contiguous chunk of memory,
for either the source or destination of the transfer.

DMA_PRIVATE capability needs to be set for a CDMA channel too, or else
the DMA Engine core will take a reference upon registration, and it
won't be further available for callers of dma_request_chan.

Signed-off-by: Adrian Larumbe <adrian.martinezlarumbe@imgtec.com>
---
 drivers/dma/xilinx/xilinx_dma.c | 131 +++++++++++++++++++++++++++++++-
 1 file changed, 127 insertions(+), 4 deletions(-)

diff --git a/drivers/dma/xilinx/xilinx_dma.c b/drivers/dma/xilinx/xilinx_dma.c
index 49c7093e2487..40c6cf8bf0e6 100644
--- a/drivers/dma/xilinx/xilinx_dma.c
+++ b/drivers/dma/xilinx/xilinx_dma.c
@@ -2433,6 +2433,130 @@ xilinx_mcdma_prep_slave_sg(struct dma_chan *dchan, struct scatterlist *sgl,
 	return NULL;
 }
 
+/**
+ * xilinx_cdma_prep_slave_sg - prepare descriptors for a DMA_SLAVE transaction
+ * @dchan: DMA channel
+ * @sgl: scatterlist to transfer to/from
+ * @sg_len: number of entries in @scatterlist
+ * @direction: DMA direction
+ * @flags: transfer ack flags
+ * @context: APP words of the descriptor
+ *
+ * Return: Async transaction descriptor on success and NULL on failure
+ */
+static struct dma_async_tx_descriptor
+*xilinx_cdma_prep_slave_sg(struct dma_chan *dchan, struct scatterlist *sgl,
+						   unsigned int sg_len,
+						   enum dma_transfer_direction direction,
+						   unsigned long flags, void *context)
+{
+	struct xilinx_dma_chan *chan = to_xilinx_chan(dchan);
+	struct xilinx_cdma_tx_segment *segment, *prev = NULL;
+	struct xilinx_dma_tx_descriptor *desc;
+	struct xilinx_cdma_desc_hw *hw;
+	dma_addr_t dma_dst, dma_src, dma_addr;
+	size_t len, avail;
+
+	(void)flags;
+	(void)context;
+
+	if (!is_slave_direction(direction)) {
+		dev_err(chan->xdev->dev,
+			"%s: bad direction?\n", __func__);
+		return NULL;
+	}
+
+	if (unlikely(sg_len == 0 || !sgl))
+		return NULL;
+
+	dma_src = 0;
+	dma_dst = 0;
+
+	if (direction == DMA_DEV_TO_MEM)
+		dma_src = chan->cfg.src_addr;
+	else
+		dma_dst = chan->cfg.dst_addr;
+
+	desc = xilinx_dma_alloc_tx_descriptor(chan);
+	if (!desc)
+		return NULL;
+
+	dma_async_tx_descriptor_init(&desc->async_tx, &chan->common);
+	desc->async_tx.tx_submit = xilinx_dma_tx_submit;
+
+	avail = sg_dma_len(sgl);
+	/*
+	 * Loop until there is either no more source or no more
+	 * destination scatterlist entries
+	 */
+	while (true) {
+		len = min_t(size_t, avail, chan->xdev->max_buffer_len);
+		if (len == 0)
+			goto fetch;
+
+		/* Allocate the link descriptor from DMA pool */
+		segment = xilinx_cdma_alloc_tx_segment(chan);
+		if (!segment)
+			goto error;
+
+		dma_addr = sg_dma_address(sgl) + sg_dma_len(sgl) - avail;
+
+		if (direction == DMA_DEV_TO_MEM)
+			dma_dst = dma_addr;
+		else
+			dma_src = dma_addr;
+
+		hw = &segment->hw;
+		hw->control = len;
+		hw->src_addr = dma_src;
+		hw->dest_addr = dma_dst;
+		if (chan->ext_addr) {
+			hw->src_addr_msb = upper_32_bits(dma_src);
+			hw->dest_addr_msb = upper_32_bits(dma_dst);
+		}
+
+		if (prev) {
+			prev->hw.next_desc = segment->phys;
+			if (chan->ext_addr)
+				prev->hw.next_desc_msb = upper_32_bits(segment->phys);
+		}
+
+		prev = segment;
+		avail -= len;
+		list_add_tail(&segment->node, &desc->segments);
+
+		if (direction == DMA_DEV_TO_MEM)
+			dma_src += len;
+		else
+			dma_dst += len;
+fetch:
+		/* Fetch the next scatterlist entry */
+		if (avail == 0) {
+			if (sg_len == 0)
+				break;
+			sgl = sg_next(sgl);
+			if (!sgl)
+				break;
+			sg_len--;
+			avail = sg_dma_len(sgl);
+		}
+	}
+
+	/* Link the last hardware descriptor with the first. */
+	segment = list_first_entry(&desc->segments,
+							   struct xilinx_cdma_tx_segment, node);
+	desc->async_tx.phys = segment->phys;
+	prev->hw.next_desc = segment->phys;
+	if (chan->ext_addr)
+		prev->hw.next_desc_msb = upper_32_bits(segment->phys);
+
+	return &desc->async_tx;
+
+error:
+	xilinx_dma_free_tx_descriptor(chan, desc);
+	return NULL;
+}
+
 /**
  * xilinx_dma_terminate_all - Halt the channel and free descriptors
  * @dchan: Driver specific DMA Channel pointer
@@ -3100,10 +3224,8 @@ static int xilinx_dma_probe(struct platform_device *pdev)
 	xdev->common.dev = &pdev->dev;
 
 	INIT_LIST_HEAD(&xdev->common.channels);
-	if (!(xdev->dma_config->dmatype == XDMA_TYPE_CDMA)) {
-		dma_cap_set(DMA_SLAVE, xdev->common.cap_mask);
-		dma_cap_set(DMA_PRIVATE, xdev->common.cap_mask);
-	}
+	dma_cap_set(DMA_SLAVE, xdev->common.cap_mask);
+	dma_cap_set(DMA_PRIVATE, xdev->common.cap_mask);
 
 	xdev->common.device_alloc_chan_resources =
 				xilinx_dma_alloc_chan_resources;
@@ -3124,6 +3246,7 @@ static int xilinx_dma_probe(struct platform_device *pdev)
 	} else if (xdev->dma_config->dmatype == XDMA_TYPE_CDMA) {
 		dma_cap_set(DMA_MEMCPY, xdev->common.cap_mask);
 		xdev->common.device_prep_dma_memcpy = xilinx_cdma_prep_memcpy;
+		xdev->common.device_prep_slave_sg = xilinx_cdma_prep_slave_sg;
 		/* Residue calculation is supported by only AXI DMA and CDMA */
 		xdev->common.residue_granularity =
 					  DMA_RESIDUE_GRANULARITY_SEGMENT;
-- 
2.17.1

