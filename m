Return-Path: <dmaengine+bounces-6220-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C6803B372C7
	for <lists+dmaengine@lfdr.de>; Tue, 26 Aug 2025 21:01:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CBB2D1738C1
	for <lists+dmaengine@lfdr.de>; Tue, 26 Aug 2025 19:01:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFEC613635E;
	Tue, 26 Aug 2025 19:01:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=folker-schwesinger.de header.i=@folker-schwesinger.de header.b="FGZJxi8H"
X-Original-To: dmaengine@vger.kernel.org
Received: from www522.your-server.de (www522.your-server.de [195.201.215.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CF153728AB;
	Tue, 26 Aug 2025 19:01:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.201.215.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756234907; cv=none; b=eM1bvIJgxURu5DvlI82eHaWMW9KEm/zMuxMgydWqDMiIxcAoeAlpyW14rhC2YZ9LPK7T4uyt8ouyRStqLIN4lnSXAFekfF6rlX2UZZe8fG/mYMUz9+xnL5ONdKYY1XWUoj6TiswILE/x43L4G2+/rM0KPZEYkhqBMdp0qpbEl68=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756234907; c=relaxed/simple;
	bh=Dk9gd17A7wKJsBScvUs9gPzoMfnhQ+9tKlslyC+CQ+E=;
	h=Message-Id:Cc:To:From:Date:Subject; b=FnS2RPJxtT8J6zk5y6qQpM8NXfxEyVOx978QSxAejukhx/jUe6s6l2XHql162sBBys+7Dvwkf5F7kiglhFcs0IiptZ7TByhlWwmyxAeJA8UuLq0zP15Cz5kgJu5HkTID0NhQNskvbz4oFA8OlMJuEhSyidxUCpRnVh0zn8j9WdM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=folker-schwesinger.de; spf=pass smtp.mailfrom=folker-schwesinger.de; dkim=pass (2048-bit key) header.d=folker-schwesinger.de header.i=@folker-schwesinger.de header.b=FGZJxi8H; arc=none smtp.client-ip=195.201.215.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=folker-schwesinger.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=folker-schwesinger.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=folker-schwesinger.de; s=default2212; h=Subject:Date:From:To:Cc:Message-Id:
	Sender:Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References;
	bh=32t3WA5lY1KbS0J1wGQdYzWvxfSQThAPTyTv0/UUv9Y=; b=FGZJxi8H5ZpSK/A0ycz+GJmB6p
	WTxipNwpVMeRNkW8b03SENtZt66Ln9nT63Rc/pa/pKIDQMn4rhooGy4D13eAmodGBXC03fYZ5HHX6
	6TtZLAgUDem9OxdivHB2ShzWZY1ux1Cr4cCPLSwlTk6jP/pLJ6M+iKDp1eFYo58iIRb9O9z/7EY/H
	UOTCh1PBIDGrs7wJfJvOPdNLifIqhOsDaokSOFPViqYjcni6SS4fs25wtwMT8bVOfk9N4nTA5DonO
	EMm175skPcGL5kSpJ0ECCdTfyfIPKu7vPR5Xxko/ISymQ80/a3EGZUcWL+I/2EAZqQ+VF5RWp1uUa
	lO94+bTg==;
Received: from sslproxy06.your-server.de ([78.46.172.3])
	by www522.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96.2)
	(envelope-from <dev@folker-schwesinger.de>)
	id 1uqyVD-000HFG-2F;
	Tue, 26 Aug 2025 20:34:39 +0200
Received: from localhost ([127.0.0.1])
	by sslproxy06.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <dev@folker-schwesinger.de>)
	id 1uqyVD-0009Bg-0V;
	Tue, 26 Aug 2025 20:34:39 +0200
Message-Id: <DCCKQLKOZC06.2H6LJ8RJQJNV2@folker-schwesinger.de>
Cc: "Vinod Koul" <vkoul@kernel.org>, "Michal Simek" <michal.simek@amd.com>,
 "Jernej Skrabec" <jernej.skrabec@gmail.com>, "Krzysztof Kozlowski"
 <krzysztof.kozlowski@linaro.org>, =?utf-8?q?Uwe_Kleine-K=C3=B6nig?=
 <u.kleine-koenig@baylibre.com>, "Marek Vasut" <marex@denx.de>, "Radhey
 Shyam Pandey" <radhey.shyam.pandey@amd.com>
To: <dmaengine@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
 <linux-kernel@vger.kernel.org>
From: "Folker Schwesinger" <dev@folker-schwesinger.de>
Date: Tue, 26 Aug 2025 20:21:10 +0200
Subject: [PATCH v4] dmaengine: xilinx_dma: Support descriptor setup from
 dma_vecs
X-Virus-Scanned: Clear (ClamAV 1.0.7/27744/Tue Aug 26 10:26:45 2025)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>

The DMAEngine provides an interface for obtaining DMA transaction
descriptors from an array of scatter gather buffers represented by
struct dma_vec. This interface is used in the DMABUF API of the IIO
framework [1][2].
To enable DMABUF support through the IIO framework for the Xilinx DMA,
implement callback .device_prep_peripheral_dma_vec() of struct
dma_device in the driver.

[1]: 7a86d469983a ("iio: buffer-dmaengine: Support new DMABUF based userspace API")
[2]: 5878853fc938 ("dmaengine: Add API function dmaengine_prep_peripheral_dma_vec()")

Signed-off-by: Folker Schwesinger <dev@folker-schwesinger.de>
Reviewed-by: Suraj Gupta <suraj.gupta2@amd.com>
Reviewed-by: Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>

---
Changes in v4:
- Replace external link to relevant source code with commit ids of the
  changes introducing dmaengine_prep_peripheral_dma_vec() and the IIO
  DMABUF-based API (suggested by Radhey Shyam Pandey).
- Collect R-b tags from v3.
- Link to v3: https://lore.kernel.org/dmaengine/DBZUIRI5Q4A3.1OIBMF9Z5EQ0X@folker-schwesinger.de/

Changes in v3:
- Collect R-b tags from v2.
- Rebase onto v6.17-rc1.
- Link to v2: https://lore.kernel.org/dmaengine/DAQB7EU7UXR3.Z07Q6JQ1V67Y@folker-schwesinger.de/

Changes in v2:
- Improve commit message to include reasoning behind the change.
- Rebase onto v6.16-rc1.
- Link to v1: https://lore.kernel.org/dmaengine/D8TV2MP99NTE.1842MMA04VB9N@folker-schwesinger.de/
---
 drivers/dma/xilinx/xilinx_dma.c | 94 +++++++++++++++++++++++++++++++++
 1 file changed, 94 insertions(+)

diff --git a/drivers/dma/xilinx/xilinx_dma.c b/drivers/dma/xilinx/xilinx_dma.c
index a34d8f0ceed8..fabff602065f 100644
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
@@ -3180,6 +3273,7 @@ static int xilinx_dma_probe(struct platform_device *pdev)
 	xdev->common.device_config = xilinx_dma_device_config;
 	if (xdev->dma_config->dmatype == XDMA_TYPE_AXIDMA) {
 		dma_cap_set(DMA_CYCLIC, xdev->common.cap_mask);
+		xdev->common.device_prep_peripheral_dma_vec = xilinx_dma_prep_peripheral_dma_vec;
 		xdev->common.device_prep_slave_sg = xilinx_dma_prep_slave_sg;
 		xdev->common.device_prep_dma_cyclic =
 					  xilinx_dma_prep_dma_cyclic;

base-commit: 8f5ae30d69d7543eee0d70083daf4de8fe15d585
-- 
2.50.1

