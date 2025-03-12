Return-Path: <dmaengine+bounces-4794-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D2978A75C29
	for <lists+dmaengine@lfdr.de>; Sun, 30 Mar 2025 22:18:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 20CE53A6356
	for <lists+dmaengine@lfdr.de>; Sun, 30 Mar 2025 20:18:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B7551DDA17;
	Sun, 30 Mar 2025 20:18:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=folker-schwesinger.de header.i=@folker-schwesinger.de header.b="MNQ2d/x/"
X-Original-To: dmaengine@vger.kernel.org
Received: from www522.your-server.de (www522.your-server.de [195.201.215.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 917F22AE8E;
	Sun, 30 Mar 2025 20:18:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.201.215.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743365900; cv=none; b=KYW89ZIwh6rOxecKD0eesJ2G+sw41tk56IM5XQ6H/DsGCF4vj5KgBK9Zis85pt3plwLLuoAMUMxJ9oUhcZllRMcsLGMeHTo01iML6odDVz3ddo3skxG2YZmDewLMYfzYvAZgcXlXFJjDCjQc1sJrWO+gOIcRo99qu95yMKY5zdo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743365900; c=relaxed/simple;
	bh=+bfG6qOlEQh5eLBGNJMznpv39k1A6x5V8I6QJ40ClqQ=;
	h=Message-Id:Cc:To:From:Date:Subject; b=W83qDoqWUqO5BeUWw/2hoRE6QJK6jH3cPGZ0ULw9EM+ARiHjnrGb0Eq10nlk3pHleVGRUF+g+sVTqSpc3FwPjIo+sbmCXnqHx5cIIqjmOtAhavLgkfZD7IC4GsSJfX13fPdu5tUxjkrlXOpHuG96CmYaRGKB3vyVFMwAhA5uUa8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=folker-schwesinger.de; spf=pass smtp.mailfrom=folker-schwesinger.de; dkim=pass (2048-bit key) header.d=folker-schwesinger.de header.i=@folker-schwesinger.de header.b=MNQ2d/x/; arc=none smtp.client-ip=195.201.215.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=folker-schwesinger.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=folker-schwesinger.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=folker-schwesinger.de; s=default2212; h=Subject:Date:From:To:Cc:Message-Id:
	Sender:Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References;
	bh=MFq0jSVBn19OTS0DWVYSuHMK3dPFrth1ryZM4cH58tw=; b=MNQ2d/x/j/Q65sgi7kGZIo+CWM
	OqGKeuEKQmFZdCVaMvtemnHu/pLMImJQaLIJod7goj0oUc04Nrj3LB0Bmrg8kjvfBaoiF/2huV7Tn
	VsD3RuqSXGd/tOyrUDeVrBFojBF653eS78zSDj8f6TBd5mmNKhaJOUiX7SbYX8Uz/sFL10igMDcOv
	iutHQnfWr4fotJiCL6uk7A9MkPfFuXEOrrgN7LZGLwc/XW07DkkE3avYJOCKwSXcmczU0hF+nsQuL
	sTTCx9PxemcdnNTPYwtMsae5pdKOg7XJtUoMSYCm/rp1DRaSqkOsaTyGyxHa4rORR87u2CSS54J6t
	vLTu20aw==;
Received: from sslproxy03.your-server.de ([88.198.220.132])
	by www522.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96.2)
	(envelope-from <dev@folker-schwesinger.de>)
	id 1tyyhK-000Gux-2y;
	Sun, 30 Mar 2025 21:51:58 +0200
Received: from [170.62.100.233] (helo=localhost)
	by sslproxy03.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <dev@folker-schwesinger.de>)
	id 1tyyhK-000118-1J;
	Sun, 30 Mar 2025 21:51:58 +0200
Message-Id: <D8TV2MP99NTE.1842MMA04VB9N@folker-schwesinger.de>
Cc: "Vinod Koul" <vkoul@kernel.org>, "Michal Simek" <michal.simek@amd.com>,
 "Jernej Skrabec" <jernej.skrabec@gmail.com>, "Manivannan Sadhasivam"
 <manivannan.sadhasivam@linaro.org>, "Krzysztof Kozlowski"
 <krzysztof.kozlowski@linaro.org>, =?utf-8?q?Uwe_Kleine-K=C3=B6nig?=
 <u.kleine-koenig@baylibre.com>, "Marek Vasut" <marex@denx.de>, "Radhey
 Shyam Pandey" <radhey.shyam.pandey@amd.com>
To: <dmaengine@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
 <linux-kernel@vger.kernel.org>
From: "Folker Schwesinger" <dev@folker-schwesinger.de>
Date: Wed, 12 Mar 2025 16:59:26 +0100
Subject: [PATCH] dmaengine: xilinx_dma: Support descriptor setup from dma_vecs
X-Authenticated-Sender: dev@folker-schwesinger.de
X-Virus-Scanned: Clear (ClamAV 1.0.7/27593/Sun Mar 30 10:30:26 2025)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>

The DMAEngine provides an interface for obtaining DMA transaction
descriptors from an array of scatter gather buffers represented by
struct dma_vec.
Add support for this interface in the Xilinx DMA driver by implementing
the .device_prep_peripheral_dma_vec() callback of struct dma_device.

Signed-off-by: Folker Schwesinger <dev@folker-schwesinger.de>
---
 drivers/dma/xilinx/xilinx_dma.c | 94 +++++++++++++++++++++++++++++++++
 1 file changed, 94 insertions(+)

diff --git a/drivers/dma/xilinx/xilinx_dma.c b/drivers/dma/xilinx/xilinx_dma.c
index 3ad44afd0e74..2d4658b02d93 100644
--- a/drivers/dma/xilinx/xilinx_dma.c
+++ b/drivers/dma/xilinx/xilinx_dma.c
@@ -2172,6 +2172,99 @@ xilinx_cdma_prep_memcpy(struct dma_chan *dchan, dma_addr_t dma_dst,
 	return NULL;
 }
 
+/**
+ * xilinx_dma_prep_peripheral_dma_vec - prepare descriptors for a DMA_SLAVE
+ *	transaction from DMA vectors
+ * @dchan: DMA channel
+ * @vecs: Array of DMA vectors that should be transferred
+ * @nb: number of entries in @vecs
+ * @direction: DMA direction
+ * @flags: transfer ack flags
+ *
+ * Return: Async transaction descriptor on success and NULL on failure
+ */
+static struct dma_async_tx_descriptor *xilinx_dma_prep_peripheral_dma_vec(
+	struct dma_chan *dchan, const struct dma_vec *vecs, size_t nb,
+	enum dma_transfer_direction direction, unsigned long flags)
+{
+	struct xilinx_dma_chan *chan = to_xilinx_chan(dchan);
+	struct xilinx_dma_tx_descriptor *desc;
+	struct xilinx_axidma_tx_segment *segment, *head, *prev = NULL;
+	size_t copy;
+	size_t sg_used;
+	unsigned int i;
+
+	if (!is_slave_direction(direction) || direction != chan->direction)
+		return NULL;
+
+	desc = xilinx_dma_alloc_tx_descriptor(chan);
+	if (!desc)
+		return NULL;
+
+	dma_async_tx_descriptor_init(&desc->async_tx, &chan->common);
+	desc->async_tx.tx_submit = xilinx_dma_tx_submit;
+
+	/* Build transactions using information from DMA vectors */
+	for (i = 0; i < nb; i++) {
+		sg_used = 0;
+
+		/* Loop until the entire dma_vec entry is used */
+		while (sg_used < vecs[i].len) {
+			struct xilinx_axidma_desc_hw *hw;
+
+			/* Get a free segment */
+			segment = xilinx_axidma_alloc_tx_segment(chan);
+			if (!segment)
+				goto error;
+
+			/*
+			 * Calculate the maximum number of bytes to transfer,
+			 * making sure it is less than the hw limit
+			 */
+			copy = xilinx_dma_calc_copysize(chan, vecs[i].len,
+					sg_used);
+			hw = &segment->hw;
+
+			/* Fill in the descriptor */
+			xilinx_axidma_buf(chan, hw, vecs[i].addr, sg_used, 0);
+			hw->control = copy;
+
+			if (prev)
+				prev->hw.next_desc = segment->phys;
+
+			prev = segment;
+			sg_used += copy;
+
+			/*
+			 * Insert the segment into the descriptor segments
+			 * list.
+			 */
+			list_add_tail(&segment->node, &desc->segments);
+		}
+	}
+
+	head = list_first_entry(&desc->segments, struct xilinx_axidma_tx_segment, node);
+	desc->async_tx.phys = head->phys;
+
+	/* For the last DMA_MEM_TO_DEV transfer, set EOP */
+	if (chan->direction == DMA_MEM_TO_DEV) {
+		segment->hw.control |= XILINX_DMA_BD_SOP;
+		segment = list_last_entry(&desc->segments,
+					  struct xilinx_axidma_tx_segment,
+					  node);
+		segment->hw.control |= XILINX_DMA_BD_EOP;
+	}
+
+	if (chan->xdev->has_axistream_connected)
+		desc->async_tx.metadata_ops = &xilinx_dma_metadata_ops;
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
@@ -3176,6 +3269,7 @@ static int xilinx_dma_probe(struct platform_device *pdev)
 	xdev->common.device_config = xilinx_dma_device_config;
 	if (xdev->dma_config->dmatype == XDMA_TYPE_AXIDMA) {
 		dma_cap_set(DMA_CYCLIC, xdev->common.cap_mask);
+		xdev->common.device_prep_peripheral_dma_vec = xilinx_dma_prep_peripheral_dma_vec;
 		xdev->common.device_prep_slave_sg = xilinx_dma_prep_slave_sg;
 		xdev->common.device_prep_dma_cyclic =
 					  xilinx_dma_prep_dma_cyclic;

base-commit: 6565439894570a07b00dba0b739729fe6b56fba4
-- 
2.49.0

