Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 10F88442010
	for <lists+dmaengine@lfdr.de>; Mon,  1 Nov 2021 19:31:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231636AbhKASeE (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 1 Nov 2021 14:34:04 -0400
Received: from neon-v2.ccupm.upm.es ([138.100.198.70]:41129 "EHLO
        neon-v2.ccupm.upm.es" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229760AbhKASeD (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 1 Nov 2021 14:34:03 -0400
Received: from localhost.localdomain (62-3-70-206.dsl.in-addr.zen.co.uk [62.3.70.206] (may be forged))
        (user=adrianml@alumnos.upm.es mech=LOGIN bits=0)
        by neon-v2.ccupm.upm.es (8.15.2/8.15.2/neon-v2-001) with ESMTPSA id 1A1I8fSQ016585
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Mon, 1 Nov 2021 18:08:54 GMT
From:   Adrian Larumbe <adrianml@alumnos.upm.es>
To:     vkoul@kernel.org, dmaengine@vger.kernel.org
Cc:     michal.simek@xilinx.com, linux-arm-kernel@lists.infradead.org,
        Adrian Larumbe <adrianml@alumnos.upm.es>
Subject: [PATCH 3/3] dmaengine: Add consumer for the new DMA_MEMCPY_SG API function.
Date:   Mon,  1 Nov 2021 18:08:25 +0000
Message-Id: <20211101180825.241048-4-adrianml@alumnos.upm.es>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20211101180825.241048-1-adrianml@alumnos.upm.es>
References: <20210706234338.7696-1-adrian.martinezlarumbe@imgtec.com>
 <20211101180825.241048-1-adrianml@alumnos.upm.es>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

This new CDMA binding for device_prep_dma_memcpy_sg was partially borrowed
from xlnx kernel tree, an expanded with extended address space support when
linking descriptor segments and checking for incorrect zero transfer size.

Signed-off-by: Adrian Larumbe <adrianml@alumnos.upm.es>
---
 drivers/dma/xilinx/xilinx_dma.c | 122 ++++++++++++++++++++++++++++++++
 1 file changed, 122 insertions(+)

diff --git a/drivers/dma/xilinx/xilinx_dma.c b/drivers/dma/xilinx/xilinx_dma.c
index 4677ce08ed40..61618148f9d4 100644
--- a/drivers/dma/xilinx/xilinx_dma.c
+++ b/drivers/dma/xilinx/xilinx_dma.c
@@ -2127,6 +2127,126 @@ xilinx_cdma_prep_memcpy(struct dma_chan *dchan, dma_addr_t dma_dst,
 	return NULL;
 }
 
+/**
+ * xilinx_cdma_prep_memcpy_sg - prepare descriptors for a memcpy_sg transaction
+ * @dchan: DMA channel
+ * @dst_sg: Destination scatter list
+ * @dst_sg_len: Number of entries in destination scatter list
+ * @src_sg: Source scatter list
+ * @src_sg_len: Number of entries in source scatter list
+ * @flags: transfer ack flags
+ *
+ * Return: Async transaction descriptor on success and NULL on failure
+ */
+static struct dma_async_tx_descriptor *xilinx_cdma_prep_memcpy_sg(
+			struct dma_chan *dchan, struct scatterlist *dst_sg,
+			unsigned int dst_sg_len, struct scatterlist *src_sg,
+			unsigned int src_sg_len, unsigned long flags)
+{
+	struct xilinx_dma_chan *chan = to_xilinx_chan(dchan);
+	struct xilinx_dma_tx_descriptor *desc;
+	struct xilinx_cdma_tx_segment *segment, *prev = NULL;
+	struct xilinx_cdma_desc_hw *hw;
+	size_t len, dst_avail, src_avail;
+	dma_addr_t dma_dst, dma_src;
+
+	if (unlikely(dst_sg_len == 0 || src_sg_len == 0))
+		return NULL;
+
+	if (unlikely(!dst_sg  || !src_sg))
+		return NULL;
+
+	desc = xilinx_dma_alloc_tx_descriptor(chan);
+	if (!desc)
+		return NULL;
+
+	dma_async_tx_descriptor_init(&desc->async_tx, &chan->common);
+	desc->async_tx.tx_submit = xilinx_dma_tx_submit;
+
+	dst_avail = sg_dma_len(dst_sg);
+	src_avail = sg_dma_len(src_sg);
+	/*
+	 * loop until there is either no more source or no more destination
+	 * scatterlist entry
+	 */
+	while (true) {
+		len = min_t(size_t, src_avail, dst_avail);
+		len = min_t(size_t, len, chan->xdev->max_buffer_len);
+		if (len == 0)
+			goto fetch;
+
+		/* Allocate the link descriptor from DMA pool */
+		segment = xilinx_cdma_alloc_tx_segment(chan);
+		if (!segment)
+			goto error;
+
+		dma_dst = sg_dma_address(dst_sg) + sg_dma_len(dst_sg) -
+			dst_avail;
+		dma_src = sg_dma_address(src_sg) + sg_dma_len(src_sg) -
+			src_avail;
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
+				prev->hw.next_desc_msb =
+					upper_32_bits(segment->phys);
+		}
+
+		prev = segment;
+		dst_avail -= len;
+		src_avail -= len;
+		list_add_tail(&segment->node, &desc->segments);
+
+fetch:
+		/* Fetch the next dst scatterlist entry */
+		if (dst_avail == 0) {
+			if (dst_sg_len == 0)
+				break;
+			dst_sg = sg_next(dst_sg);
+			if (dst_sg == NULL)
+				break;
+			dst_sg_len--;
+			dst_avail = sg_dma_len(dst_sg);
+		}
+		/* Fetch the next src scatterlist entry */
+		if (src_avail == 0) {
+			if (src_sg_len == 0)
+				break;
+			src_sg = sg_next(src_sg);
+			if (src_sg == NULL)
+				break;
+			src_sg_len--;
+			src_avail = sg_dma_len(src_sg);
+		}
+	}
+
+	if (list_empty(&desc->segments)) {
+		dev_err(chan->xdev->dev,
+			"%s: Zero-size SG transfer requested\n", __func__);
+		goto error;
+	}
+
+	/* Link the last hardware descriptor with the first. */
+	segment = list_first_entry(&desc->segments,
+				struct xilinx_cdma_tx_segment, node);
+	desc->async_tx.phys = segment->phys;
+	prev->hw.next_desc = segment->phys;
+
+	return &desc->async_tx;
+
+error:
+	xilinx_dma_free_tx_descriptor(chan, desc);
+	return NULL;
+}
+
 /**
  * xilinx_dma_prep_slave_sg - prepare descriptors for a DMA_SLAVE transaction
  * @dchan: DMA channel
@@ -3115,7 +3235,9 @@ static int xilinx_dma_probe(struct platform_device *pdev)
 					  DMA_RESIDUE_GRANULARITY_SEGMENT;
 	} else if (xdev->dma_config->dmatype == XDMA_TYPE_CDMA) {
 		dma_cap_set(DMA_MEMCPY, xdev->common.cap_mask);
+		dma_cap_set(DMA_MEMCPY_SG, xdev->common.cap_mask);
 		xdev->common.device_prep_dma_memcpy = xilinx_cdma_prep_memcpy;
+		xdev->common.device_prep_dma_memcpy_sg = xilinx_cdma_prep_memcpy_sg;
 		/* Residue calculation is supported by only AXI DMA and CDMA */
 		xdev->common.residue_granularity =
 					  DMA_RESIDUE_GRANULARITY_SEGMENT;
-- 
2.33.1

