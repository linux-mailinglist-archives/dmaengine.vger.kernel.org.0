Return-Path: <dmaengine+bounces-3243-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DA63498AA83
	for <lists+dmaengine@lfdr.de>; Mon, 30 Sep 2024 19:04:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 31E2BB254A2
	for <lists+dmaengine@lfdr.de>; Mon, 30 Sep 2024 17:04:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AAFDD126C03;
	Mon, 30 Sep 2024 17:03:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="lxUdhQY1"
X-Original-To: dmaengine@vger.kernel.org
Received: from out-183.mta0.migadu.com (out-183.mta0.migadu.com [91.218.175.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 488A317DFFD
	for <dmaengine@vger.kernel.org>; Mon, 30 Sep 2024 17:03:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727715811; cv=none; b=lusVdsoKLrcnrYgaAvq/PON38P9TPco8ZVGUniRBjtsOBRzy2uPcN+xs0YYZncqLIT9CCNAY6fe0pFYXvBRXyst12pVj4KZpy18RUjQk2BOMV/6RZTjfAfP0WVuivD+O09K4B1KZQpqmA4jc7nGNSSOTlRAVyARlIxKa1mLZomQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727715811; c=relaxed/simple;
	bh=AYG6mKT39KJDy8WIIaejnpebZV5LnzE0BUOjr6OOjqo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=Lr6pTVeGg4RlqOVDjD4xikjiPVGnuC08M/kveohw53zzQIHY0Ah7sTAO7UC1rEUw1WyIpNv3Aj7aNEbWsptqyJuq6tUBwrmV+wHioE0d21AJ4ndANEsQrVTIrfZhCkdfogEXqfQVb59mX239IOo8ed6CQ2UWAnAnsVGDJQ4Ngjg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=lxUdhQY1; arc=none smtp.client-ip=91.218.175.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1727715807;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=LW2icFXcZTQf0XeMDyw+/f1SXM7/Ac7aqFGfwE9/Rpw=;
	b=lxUdhQY1pzwKKkTOF+ISTKyFoRB4zpATWiLkbr1Yd6z4Vk25jaBtebYXa+nXoAVHZc+H+Y
	16aYIaVdBFq7HDFJ3BYzwF8UjM34zwpVr2hFpMhsuq8qaC0X9NYWHi9zOUTYFDWguTmGJs
	zi8+39Zu55HnC67XmZq2NQjOqoRjVE0=
From: Jai Luthra <jai.luthra@linux.dev>
Date: Mon, 30 Sep 2024 13:02:54 -0400
Subject: [PATCH v2] dmaengine: ti: k3-udma: Set EOP for all TRs in cyclic
 BCDMA transfer
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240930-z_cnt-v2-1-9d38aba149a2@linux.dev>
X-B4-Tracking: v=1; b=H4sIAL3Z+mYC/13MSwrCMBSF4a2UOzaSpPahI/dRiuRxYy9IKkkN1
 ZK9Gzt0+B8O3wYRA2GES7VBwESRZl9CHiowk/J3ZGRLg+TyxM+iZ5+b8QurjWqsQtO12kH5PgM
 6WndnGEtPFJc5vHc2id/6LyTBBJOm6Z12mne2vT7Iv9ajxQRjzvkLtZzuQpoAAAA=
X-Change-ID: 20240918-z_cnt-3ca5daec76bf
To: Peter Ujfalusi <peter.ujfalusi@gmail.com>, 
 Vinod Koul <vkoul@kernel.org>
Cc: Vignesh Raghavendra <vigneshr@ti.com>, 
 Francesco Dolcini <francesco.dolcini@toradex.com>, 
 Devarsh Thakkar <devarsht@ti.com>, Rishikesh Donadkar <r-donadkar@ti.com>, 
 dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Jai Luthra <jai.luthra@linux.dev>
X-Developer-Signature: v=1; a=openpgp-sha256; l=5981; i=jai.luthra@linux.dev;
 h=from:subject:message-id; bh=bKQmJJGbCxqbNiNFO/8G/J9sCgM79F2SWOAfyfxVQpQ=;
 b=owEBbQKS/ZANAwAIAUPekfkkmnFFAcsmYgBm+tnWp+xOwf94y4ObpsFAhk+ZM8phVdmaIfs+V
 0aebYC0u8+JAjMEAAEIAB0WIQRN4NgY5dV16NRar8VD3pH5JJpxRQUCZvrZ1gAKCRBD3pH5JJpx
 RY2VD/0YJmq7A+FxU2KxJlDB/xiMchcXozDkJG5hOadNu6SFKfw0/yFg2PtlRI3rK+EoPkVSjI0
 p6CrxT/1sc83jiL8JjZLwnK4UT8YcBYy9Pdbez51dvqsXCtBvBx5emVH2P00bXUcFKGXJRTZAb+
 BVIs0DFhj6HLB5hI6IZE5VXEipn7rmnqLORI17n2KV1svDzMO6z82S5JzY/avLi1qQr+pgKYqe+
 f8gWM/sfp03RkVLkVNseofmfGWyny26k4IcmjvEqPTVchsdKwtfrMAYrWz6+xKb4+QlWiQtCwSe
 7RCvr/ool3NKcF1lyKFh4ZrKKHu9gKHdTMFkem/DbI+5vxjd8+h9vSzVyEAayi3018YS7s9T2SI
 98fDCcsDHYbyfB8T2S6pSCIkw7eRmZHScLtLmDe24rJuCNBzF+nAoLBz6gAdqzZxGWW2i8ApvGc
 l50JOJHHsOI+NA/Vgvmt0VeL+58xsVVISVOnheiW6KU+8hj/9QuZ5DgnLgC9E2ASVdjoXUfjPGX
 JVNqVn8GrqUGhCzotYRYndadKLaoX+DmH4Y1uvLJcT+DaJOAqlu/B/PAbFpbEDZGZhH10QmC9l8
 Iwl5n44DYzRQp2aqpuEb/A8Ap69IusunC1wOzUJpOzaug2P1WIdgM8ddwHvZOZ5h/x3tK2kQ9bc
 DP7GpJKcQxBL2GA==
X-Developer-Key: i=jai.luthra@linux.dev; a=openpgp;
 fpr=4DE0D818E5D575E8D45AAFC543DE91F9249A7145
X-Migadu-Flow: FLOW_OUT

From: Jai Luthra <j-luthra@ti.com>

When receiving data in cyclic mode from PDMA peripherals, where reload
count is set to infinite, any TR in the set can potentially be the last
one of the overall transfer. In such cases, the EOP flag needs to be set
in each TR and PDMA's Static TR "Z" parameter should be set, matching
the size of the TR.

This is required for the teardown to function properly and cleanup the
internal state memory. This only affects platforms using BCDMA and not
those using UDMA-P, which could set EOP flag in the teardown TR
automatically.

Similarly when transmitting data in cyclic mode to PDMA peripherals, the
EOP flag needs to be set to get the teardown completion signal
correctly.

Fixes: 017794739702 ("dmaengine: ti: k3-udma: Initial support for K3 BCDMA")
Tested-by: Francesco Dolcini <francesco.dolcini@toradex.com> # Toradex Verdin AM62
Signed-off-by: Jai Luthra <j-luthra@ti.com>
Signed-off-by: Jai Luthra <jai.luthra@linux.dev>
---
Changes in v2:
- Fix commit message and comments to make it clear that this change is
  only needed for BCDMA
- Drop the redundant pkt_mode check
- Link to v1: https://lore.kernel.org/r/20240918-z_cnt-v1-1-2c58fbfb07d6@linux.dev
---
 drivers/dma/ti/k3-udma.c | 62 ++++++++++++++++++++++++++++++++++++------------
 1 file changed, 47 insertions(+), 15 deletions(-)

diff --git a/drivers/dma/ti/k3-udma.c b/drivers/dma/ti/k3-udma.c
index 406ee199c2ac1cffc29edb475df574cf9f0cf222..b3f27b3f92098a65afe9656ca31f9b8027294c16 100644
--- a/drivers/dma/ti/k3-udma.c
+++ b/drivers/dma/ti/k3-udma.c
@@ -3185,27 +3185,40 @@ static int udma_configure_statictr(struct udma_chan *uc, struct udma_desc *d,
 
 	d->static_tr.elcnt = elcnt;
 
-	/*
-	 * PDMA must to close the packet when the channel is in packet mode.
-	 * For TR mode when the channel is not cyclic we also need PDMA to close
-	 * the packet otherwise the transfer will stall because PDMA holds on
-	 * the data it has received from the peripheral.
-	 */
 	if (uc->config.pkt_mode || !uc->cyclic) {
+		/*
+		 * PDMA must close the packet when the channel is in packet mode.
+		 * For TR mode when the channel is not cyclic we also need PDMA
+		 * to close the packet otherwise the transfer will stall because
+		 * PDMA holds on the data it has received from the peripheral.
+		 */
 		unsigned int div = dev_width * elcnt;
 
 		if (uc->cyclic)
 			d->static_tr.bstcnt = d->residue / d->sglen / div;
 		else
 			d->static_tr.bstcnt = d->residue / div;
+	} else if (uc->ud->match_data->type == DMA_TYPE_BCDMA &&
+		   uc->config.dir == DMA_DEV_TO_MEM &&
+		   uc->cyclic) {
+		/*
+		 * For cyclic mode with BCDMA we have to set EOP in each TR to
+		 * prevent short packet errors seen on channel teardown. So the
+		 * PDMA must close the packet after every TR transfer by setting
+		 * burst count equal to the number of bytes transferred.
+		 */
+		struct cppi5_tr_type1_t *tr_req = d->hwdesc[0].tr_req_base;
 
-		if (uc->config.dir == DMA_DEV_TO_MEM &&
-		    d->static_tr.bstcnt > uc->ud->match_data->statictr_z_mask)
-			return -EINVAL;
+		d->static_tr.bstcnt =
+			(tr_req->icnt0 * tr_req->icnt1) / dev_width;
 	} else {
 		d->static_tr.bstcnt = 0;
 	}
 
+	if (uc->config.dir == DMA_DEV_TO_MEM &&
+	    d->static_tr.bstcnt > uc->ud->match_data->statictr_z_mask)
+		return -EINVAL;
+
 	return 0;
 }
 
@@ -3450,8 +3463,9 @@ udma_prep_slave_sg(struct dma_chan *chan, struct scatterlist *sgl,
 	/* static TR for remote PDMA */
 	if (udma_configure_statictr(uc, d, dev_width, burst)) {
 		dev_err(uc->ud->dev,
-			"%s: StaticTR Z is limited to maximum 4095 (%u)\n",
-			__func__, d->static_tr.bstcnt);
+			"%s: StaticTR Z is limited to maximum %u (%u)\n",
+			__func__, uc->ud->match_data->statictr_z_mask,
+			d->static_tr.bstcnt);
 
 		udma_free_hwdesc(uc, d);
 		kfree(d);
@@ -3476,6 +3490,7 @@ udma_prep_dma_cyclic_tr(struct udma_chan *uc, dma_addr_t buf_addr,
 	u16 tr0_cnt0, tr0_cnt1, tr1_cnt0;
 	unsigned int i;
 	int num_tr;
+	u32 period_csf = 0;
 
 	num_tr = udma_get_tr_counters(period_len, __ffs(buf_addr), &tr0_cnt0,
 				      &tr0_cnt1, &tr1_cnt0);
@@ -3498,6 +3513,20 @@ udma_prep_dma_cyclic_tr(struct udma_chan *uc, dma_addr_t buf_addr,
 		period_addr = buf_addr |
 			((u64)uc->config.asel << K3_ADDRESS_ASEL_SHIFT);
 
+	/*
+	 * For BCDMA <-> PDMA transfers, the EOP flag needs to be set on the
+	 * last TR of a descriptor, to mark the packet as complete.
+	 * This is required for getting the teardown completion message in case
+	 * of TX, and to avoid short-packet error in case of RX.
+	 *
+	 * As we are in cyclic mode, we do not know which period might be the
+	 * last one, so set the flag for each period.
+	 */
+	if (uc->config.ep_type == PSIL_EP_PDMA_XY &&
+	    uc->ud->match_data->type == DMA_TYPE_BCDMA) {
+		period_csf = CPPI5_TR_CSF_EOP;
+	}
+
 	for (i = 0; i < periods; i++) {
 		int tr_idx = i * num_tr;
 
@@ -3525,8 +3554,10 @@ udma_prep_dma_cyclic_tr(struct udma_chan *uc, dma_addr_t buf_addr,
 		}
 
 		if (!(flags & DMA_PREP_INTERRUPT))
-			cppi5_tr_csf_set(&tr_req[tr_idx].flags,
-					 CPPI5_TR_CSF_SUPR_EVT);
+			period_csf |= CPPI5_TR_CSF_SUPR_EVT;
+
+		if (period_csf)
+			cppi5_tr_csf_set(&tr_req[tr_idx].flags, period_csf);
 
 		period_addr += period_len;
 	}
@@ -3655,8 +3686,9 @@ udma_prep_dma_cyclic(struct dma_chan *chan, dma_addr_t buf_addr, size_t buf_len,
 	/* static TR for remote PDMA */
 	if (udma_configure_statictr(uc, d, dev_width, burst)) {
 		dev_err(uc->ud->dev,
-			"%s: StaticTR Z is limited to maximum 4095 (%u)\n",
-			__func__, d->static_tr.bstcnt);
+			"%s: StaticTR Z is limited to maximum %u (%u)\n",
+			__func__, uc->ud->match_data->statictr_z_mask,
+			d->static_tr.bstcnt);
 
 		udma_free_hwdesc(uc, d);
 		kfree(d);

---
base-commit: 8400291e289ee6b2bf9779ff1c83a291501f017b
change-id: 20240918-z_cnt-3ca5daec76bf

Best regards,
-- 
Jai Luthra <jai.luthra@linux.dev>


