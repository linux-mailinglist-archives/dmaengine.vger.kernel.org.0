Return-Path: <dmaengine+bounces-3183-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F370897BCE7
	for <lists+dmaengine@lfdr.de>; Wed, 18 Sep 2024 15:17:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1EE421C21432
	for <lists+dmaengine@lfdr.de>; Wed, 18 Sep 2024 13:17:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6408818A95D;
	Wed, 18 Sep 2024 13:17:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="mIissUwI"
X-Original-To: dmaengine@vger.kernel.org
Received: from out-170.mta1.migadu.com (out-170.mta1.migadu.com [95.215.58.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2745E18A6D3
	for <dmaengine@vger.kernel.org>; Wed, 18 Sep 2024 13:17:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726665449; cv=none; b=mfjfRW3yjfck9whL7BY0PhCLuwDSp2Dzwcyz4o7r4QARqeEOK7Gv1BFfK1K79Wzvk6WCi40KY+tntlC7I4uhcW3cKI5hPASMqMyDP1DAZ5FQ7R8rTCe1aS1Q49PpVVcvHosed/jn5tyISGH2Q1B127mcS8/Y35Yf/KOd5Mq7qh0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726665449; c=relaxed/simple;
	bh=6Vylgkwi2XRLm6vu1hISot4+x5h/VxupX0P7v+5OR1w=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=DEMXf+jRKJF0JITIYQwhCI3NFKMyoIeBrCBk2sH+WiV4nDSP3WzqbVFDXk7ow/zrEcoEzNDuxw7Qd6MLJUXu589egbfF48WYl2XZj9qjiXwQPthRIKHq3d8o/xomTeaIaJDYrXfn2r5GYCMO6XH9Vik0e4Cs6bamocwKbpB8YuU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=mIissUwI; arc=none smtp.client-ip=95.215.58.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1726665440;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=oRaY/hVaVkdY+wxG/AOYN6Y51TdyznGDSjMoavpo0T4=;
	b=mIissUwIFVOBJq9xT+tFoQ0uFfxx+38WKFwVY2ahT1lg0NYV1JVMXPrDsPOh7V4sIHP99t
	0kJzy6RlQTcaofhxUIbllaOC2bDGDXnGtcn+jYtxA9Ga8cyiu3xeY4zWWTP0z5di5n0toP
	eqz6YffiZQPMrjidWC9ljBuiPsq8f90=
From: Jai Luthra <jai.luthra@linux.dev>
Date: Wed, 18 Sep 2024 18:46:55 +0530
Subject: [PATCH] dmaengine: ti: k3-udma: Fix teardown for cyclic PDMA
 transfers
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240918-z_cnt-v1-1-2c58fbfb07d6@linux.dev>
X-B4-Tracking: v=1; b=H4sIAMbS6mYC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIxMDS0ML3ar45LwSXePkRNOUxNRkc7OkNCWg2oKi1LTMCrA50bG1tQCoxqM
 pVwAAAA==
To: Peter Ujfalusi <peter.ujfalusi@gmail.com>, 
 Vinod Koul <vkoul@kernel.org>
Cc: Vignesh Raghavendra <vigneshr@ti.com>, 
 Francesco Dolcini <francesco.dolcini@toradex.com>, 
 Devarsh Thakkar <devarsht@ti.com>, Rishikesh Donadkar <r-donadkar@ti.com>, 
 dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Jai Luthra <j-luthra@ti.com>, Jai Luthra <jai.luthra@linux.dev>
X-Developer-Signature: v=1; a=openpgp-sha256; l=5543; i=jai.luthra@linux.dev;
 h=from:subject:message-id; bh=fTpXpCUpiB900Brzxzj7Zv/lHJjbWeyy//oQHtB/u40=;
 b=owEBbQKS/ZANAwAIAUPekfkkmnFFAcsmYgBm6tLbkEn2tvW138QObUJN6CL1NoaaXRoDrPeQ+
 ybo8F8mUOOJAjMEAAEIAB0WIQRN4NgY5dV16NRar8VD3pH5JJpxRQUCZurS2wAKCRBD3pH5JJpx
 Re6lEACk3O8jRJNBzEAPZFnriefUQ3VjqYZcqSUtv7lfV6o/Yr6bT3zmP9YsDSYUo8teBEx9W6a
 qoVIySMrClpRAqXyNiXSMccXgmPz4MwqKGqW5WaW8/QeIzZRh8SYL/QgYtU/6eBzLOjd6XWD8co
 2vjUcPMCncz/pwxkZXExaatBna4ds+vKFKgttmTOK55VDyYON/ixWZTmnxDv4raAKzCTra1kqqL
 4ASOgu5grpn/sFy81RPulit5MPoxhI+dfiTzxIM8Y40u3eW/Wkd3PpV47W1bTQOSipaz1bS8RO5
 cp/7gBnNAaT5mzBb96uKN/T36a3ajWr/eAYe+iEzPTvJ5UdSEDO6jhztsqFRdDIhkCYi+ZGCxH4
 IACDuwrvRB3T222Lxsr56/Lu+uXp4qlhZQ2714tAWQJkan1GpJ7LG6gWy/CkLUxR63BDEHiUgOo
 L9OTx6P1chZruk6BkuuUJ37bbbYLhq/WNMmPl0V5w0GCpybWj52kKjMAT25Nnq1mvrQuWXnassH
 o7Njym1tby1n1JT5hlDIQk+/uynTikyM7wrvQH1gIl8LNdopZXpIJRNjDmpIVPBA4ujUL/DYKiW
 TQUXsswUo9qepcy2F8Mp/CN6C0wxT+JFYNHOVbNowoD1ufCLZkBbgGMTtutpsgcSRA3Sda7aVIB
 n5NoW19jRHup+MQ==
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
Signed-off-by: Jai Luthra <j-luthra@ti.com>
Signed-off-by: Jai Luthra <jai.luthra@linux.dev>
---
 drivers/dma/ti/k3-udma.c | 61 ++++++++++++++++++++++++++++++++++++------------
 1 file changed, 46 insertions(+), 15 deletions(-)

diff --git a/drivers/dma/ti/k3-udma.c b/drivers/dma/ti/k3-udma.c
index 406ee199c2ac..5a900b63dae5 100644
--- a/drivers/dma/ti/k3-udma.c
+++ b/drivers/dma/ti/k3-udma.c
@@ -3185,27 +3185,39 @@ static int udma_configure_statictr(struct udma_chan *uc, struct udma_desc *d,
 
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
+		   uc->config.dir == DMA_DEV_TO_MEM && !uc->config.pkt_mode &&
+		   uc->cyclic) {
+		/*
+		 * For cyclic TR mode PDMA must close the packet after every TR
+		 * transfer, as we have to set EOP in each TR to prevent short
+		 * packet errors seen on channel teardown.
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
 
@@ -3450,8 +3462,9 @@ udma_prep_slave_sg(struct dma_chan *chan, struct scatterlist *sgl,
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
@@ -3476,6 +3489,7 @@ udma_prep_dma_cyclic_tr(struct udma_chan *uc, dma_addr_t buf_addr,
 	u16 tr0_cnt0, tr0_cnt1, tr1_cnt0;
 	unsigned int i;
 	int num_tr;
+	u32 period_csf = 0;
 
 	num_tr = udma_get_tr_counters(period_len, __ffs(buf_addr), &tr0_cnt0,
 				      &tr0_cnt1, &tr1_cnt0);
@@ -3498,6 +3512,20 @@ udma_prep_dma_cyclic_tr(struct udma_chan *uc, dma_addr_t buf_addr,
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
 
@@ -3525,8 +3553,10 @@ udma_prep_dma_cyclic_tr(struct udma_chan *uc, dma_addr_t buf_addr,
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
@@ -3655,8 +3685,9 @@ udma_prep_dma_cyclic(struct dma_chan *chan, dma_addr_t buf_addr, size_t buf_len,
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


