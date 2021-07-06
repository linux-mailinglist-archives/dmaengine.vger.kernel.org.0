Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 16A953BDFF2
	for <lists+dmaengine@lfdr.de>; Wed,  7 Jul 2021 01:56:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229873AbhGFX73 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 6 Jul 2021 19:59:29 -0400
Received: from mx07-00376f01.pphosted.com ([185.132.180.163]:56798 "EHLO
        mx07-00376f01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229834AbhGFX72 (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 6 Jul 2021 19:59:28 -0400
X-Greylist: delayed 766 seconds by postgrey-1.27 at vger.kernel.org; Tue, 06 Jul 2021 19:59:27 EDT
Received: from pps.filterd (m0168889.ppops.net [127.0.0.1])
        by mx07-00376f01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 166NVXxF032557;
        Wed, 7 Jul 2021 00:43:50 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=imgtec.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=dk201812; bh=6sIEkdktuLp0CF85mIfNl/0Pc20aXitC6/5MzOTSrAQ=;
 b=lbrBIyGQZrMT2nn1K2UWzpEx3PpgkUCpD6+vXmdH7X42HPHwdYOlpcOlWdFqWW3G1DBR
 ZnC2QP0CM5LOuA/9IF8CjzeXoj3kjUk4XOWX1H2YniOyZUQ+8mDEgSjOvUI4NfgBm7E/
 OoPbzLLHZYmsUF9LA3IgVYAJh2kbD+NgZ1zNT8DuOYNXOAGLqF57kbfkYlRr9Cql24y/
 +AMTAcd1ORhbIOQckeDywYLnvyv0Kl56tL88Y7EYbFyHRJ30jMR1ei1imKR3r2+HFnPF
 ykvOGd5Tk0kdwQnD4q7eRVR1B96g7Fn/YN6EgYNnAevj/kvoH9Dc/UQQyBGBWqI9FqB8 Cg== 
Received: from hhmail05.hh.imgtec.org ([217.156.249.195])
        by mx07-00376f01.pphosted.com with ESMTP id 39ms1j08cm-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Wed, 07 Jul 2021 00:43:50 +0100
Received: from adrianlarumbe-HP-Elite-7500-Series-MT.hh.imgtec.org
 (10.100.70.86) by HHMAIL05.hh.imgtec.org (10.100.10.120) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14; Wed, 7 Jul 2021 00:43:49 +0100
From:   Adrian Larumbe <adrian.martinezlarumbe@imgtec.com>
To:     <vkoul@kernel.org>, <dmaengine@vger.kernel.org>
CC:     <michal.simek@xilinx.com>, <linux-arm-kernel@lists.infradead.org>,
        <adrian.martinezlarumbe@imgtec.com>
Subject: [PATCH 1/2] dmaengine: xilinx_dma: Restore support for memcpy SG transfers
Date:   Wed, 7 Jul 2021 00:43:37 +0100
Message-ID: <20210706234338.7696-2-adrian.martinezlarumbe@imgtec.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210706234338.7696-1-adrian.martinezlarumbe@imgtec.com>
References: <20210706234338.7696-1-adrian.martinezlarumbe@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.100.70.86]
X-ClientProxiedBy: HHMAIL05.hh.imgtec.org (10.100.10.120) To
 HHMAIL05.hh.imgtec.org (10.100.10.120)
X-EXCLAIMER-MD-CONFIG: 15a78312-3e47-46eb-9010-2e54d84a9631
X-Proofpoint-ORIG-GUID: 4V4uZrccWcXQLD08ELQxfUm-8_NKWGYZ
X-Proofpoint-GUID: 4V4uZrccWcXQLD08ELQxfUm-8_NKWGYZ
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

This is the old DMA_SG interface that was removed in commit
c678fa66341c ("dmaengine: remove DMA_SG as it is dead code in kernel"). It
has been renamed to DMA_MEMCPY_SG to better match the MEMSET and MEMSET_SG
naming convention.

It should only be used for mem2mem copies, either main system memory or
CPU-addressable device memory (like video memory on a PCI graphics card).

Bringing back this interface was prompted by the need to use the Xilinx
CDMA device for mem2mem SG transfers. The current CDMA binding for
device_prep_dma_memcpy_sg was partially borrowed from xlnx kernel tree, and
expanded with extended address space support when linking descriptor
segments and checking for incorrect zero transfer size.

Signed-off-by: Adrian Larumbe <adrian.martinezlarumbe@imgtec.com>
---
 .../driver-api/dmaengine/provider.rst         |  11 ++
 drivers/dma/dmaengine.c                       |   7 +
 drivers/dma/xilinx/xilinx_dma.c               | 122 ++++++++++++++++++
 include/linux/dmaengine.h                     |  20 +++
 4 files changed, 160 insertions(+)

diff --git a/Documentation/driver-api/dmaengine/provider.rst b/Documentation/driver-api/dmaengine/provider.rst
index ddb0a81a796c..9f0efe9e9952 100644
--- a/Documentation/driver-api/dmaengine/provider.rst
+++ b/Documentation/driver-api/dmaengine/provider.rst
@@ -162,6 +162,17 @@ Currently, the types available are:
 
   - The device is able to do memory to memory copies
 
+- - DMA_MEMCPY_SG
+
+  - The device supports memory to memory scatter-gather transfers.
+
+  - Even though a plain memcpy can look like a particular case of a
+    scatter-gather transfer, with a single chunk to transfer, it's a
+    distinct transaction type in the mem2mem transfer case. This is
+    because some very simple devices might be able to do contiguous
+    single-chunk memory copies, but have no support for more
+    complex SG transfers.
+
 - DMA_XOR
 
   - The device is able to perform XOR operations on memory areas
diff --git a/drivers/dma/dmaengine.c b/drivers/dma/dmaengine.c
index af3ee288bc11..c4e3334b04cf 100644
--- a/drivers/dma/dmaengine.c
+++ b/drivers/dma/dmaengine.c
@@ -1160,6 +1160,13 @@ int dma_async_device_register(struct dma_device *device)
 		return -EIO;
 	}
 
+	if (dma_has_cap(DMA_MEMCPY_SG, device->cap_mask) && !device->device_prep_dma_memcpy_sg) {
+		dev_err(device->dev,
+			"Device claims capability %s, but op is not defined\n",
+			"DMA_MEMCPY_SG");
+		return -EIO;
+	}
+
 	if (dma_has_cap(DMA_XOR, device->cap_mask) && !device->device_prep_dma_xor) {
 		dev_err(device->dev,
 			"Device claims capability %s, but op is not defined\n",
diff --git a/drivers/dma/xilinx/xilinx_dma.c b/drivers/dma/xilinx/xilinx_dma.c
index 75c0b8e904e5..0e2bf75d42d3 100644
--- a/drivers/dma/xilinx/xilinx_dma.c
+++ b/drivers/dma/xilinx/xilinx_dma.c
@@ -2108,6 +2108,126 @@ xilinx_cdma_prep_memcpy(struct dma_chan *dchan, dma_addr_t dma_dst,
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
@@ -3094,7 +3214,9 @@ static int xilinx_dma_probe(struct platform_device *pdev)
 					  DMA_RESIDUE_GRANULARITY_SEGMENT;
 	} else if (xdev->dma_config->dmatype == XDMA_TYPE_CDMA) {
 		dma_cap_set(DMA_MEMCPY, xdev->common.cap_mask);
+		dma_cap_set(DMA_MEMCPY_SG, xdev->common.cap_mask);
 		xdev->common.device_prep_dma_memcpy = xilinx_cdma_prep_memcpy;
+		xdev->common.device_prep_dma_memcpy_sg = xilinx_cdma_prep_memcpy_sg;
 		/* Residue calculation is supported by only AXI DMA and CDMA */
 		xdev->common.residue_granularity =
 					  DMA_RESIDUE_GRANULARITY_SEGMENT;
diff --git a/include/linux/dmaengine.h b/include/linux/dmaengine.h
index 004736b6a9c8..7c342f77d8eb 100644
--- a/include/linux/dmaengine.h
+++ b/include/linux/dmaengine.h
@@ -50,6 +50,7 @@ enum dma_status {
  */
 enum dma_transaction_type {
 	DMA_MEMCPY,
+	DMA_MEMCPY_SG,
 	DMA_XOR,
 	DMA_PQ,
 	DMA_XOR_VAL,
@@ -891,6 +892,11 @@ struct dma_device {
 	struct dma_async_tx_descriptor *(*device_prep_dma_memcpy)(
 		struct dma_chan *chan, dma_addr_t dst, dma_addr_t src,
 		size_t len, unsigned long flags);
+	struct dma_async_tx_descriptor *(*device_prep_dma_memcpy_sg)(
+		struct dma_chan *chan,
+		struct scatterlist *dst_sg, unsigned int dst_nents,
+		struct scatterlist *src_sg, unsigned int src_nents,
+		unsigned long flags);
 	struct dma_async_tx_descriptor *(*device_prep_dma_xor)(
 		struct dma_chan *chan, dma_addr_t dst, dma_addr_t *src,
 		unsigned int src_cnt, size_t len, unsigned long flags);
@@ -1053,6 +1059,20 @@ static inline struct dma_async_tx_descriptor *dmaengine_prep_dma_memcpy(
 						    len, flags);
 }
 
+static inline struct dma_async_tx_descriptor *dmaengine_prep_dma_memcpy_sg(
+		struct dma_chan *chan,
+		struct scatterlist *dst_sg, unsigned int dst_nents,
+		struct scatterlist *src_sg, unsigned int src_nents,
+		unsigned long flags)
+{
+	if (!chan || !chan->device || !chan->device->device_prep_dma_memcpy_sg)
+		return NULL;
+
+	return chan->device->device_prep_dma_memcpy_sg(chan, dst_sg, dst_nents,
+						       src_sg, src_nents,
+						       flags);
+}
+
 static inline bool dmaengine_is_metadata_mode_supported(struct dma_chan *chan,
 		enum dma_desc_metadata_mode mode)
 {
-- 
2.17.1

