Return-Path: <dmaengine+bounces-5396-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CDE15AD689E
	for <lists+dmaengine@lfdr.de>; Thu, 12 Jun 2025 09:17:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 80A1B1BC0C09
	for <lists+dmaengine@lfdr.de>; Thu, 12 Jun 2025 07:17:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C4502147E7;
	Thu, 12 Jun 2025 07:16:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="sc1CnbZs"
X-Original-To: dmaengine@vger.kernel.org
Received: from fllvem-ot04.ext.ti.com (fllvem-ot04.ext.ti.com [198.47.19.246])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9686C213E69;
	Thu, 12 Jun 2025 07:16:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.246
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749712581; cv=none; b=D5rg4IO9YG8wxuuaU/Z3+p8TJ54LkCt4QD8BFI15JY53+x3yaskBPhNci2HphfiUCg9ADQ/cl5B1cYmI2LZVIaqKw13P32zIkRJI2OvQRNReLNEuqHdabFy9xDpXqbRejUuNkqXS7x7ItbCAGj+wZxD8UiU90ymh5JSVZTBkoos=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749712581; c=relaxed/simple;
	bh=bPaDsD/RAdMjkerVLK5LvTIeE0c8o2OcTQL/SNSyMZM=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=C5O59rQIYTgP46G5A+AmdE2JXU7Ww9ht4Uhmn+Hz82JCi752pSBcQmB4OxxvkxlgdxuDgB3rprUlbT0n0+kuHyRMV5UG/Bwy+XT6IK7xIZ+Pwk/8lAbO9Y0D2/OvApnG3RHWWcRN8TJIetRUJeHfPfNpSOZAQDD4WRU5jelx6z0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=sc1CnbZs; arc=none smtp.client-ip=198.47.19.246
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllvem-sh04.itg.ti.com ([10.64.41.54])
	by fllvem-ot04.ext.ti.com (8.15.2/8.15.2) with ESMTP id 55C7GAcc1615153;
	Thu, 12 Jun 2025 02:16:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1749712570;
	bh=dfnQ77LLT3UOKXsA/qVCfdsLoW+z147jxWKsGhXKd2g=;
	h=From:To:Subject:Date:In-Reply-To:References;
	b=sc1CnbZsKH1PoRz25pRHtC58oJgdrs0hjT0QxIBqkwEyjUkiGsev/S4D70izVsKVs
	 deSW4B5OCyRoRUMs0Bf+EjinvHG/OfL4qaukCSTCBLom0s/BzAUImH50NSOfsUYu+Z
	 PXU8siXYd5AXyi6hcwee91AftowDTQek15xSQccU=
Received: from DLEE106.ent.ti.com (dlee106.ent.ti.com [157.170.170.36])
	by fllvem-sh04.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 55C7GAuS1740664
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
	Thu, 12 Jun 2025 02:16:10 -0500
Received: from DLEE107.ent.ti.com (157.170.170.37) by DLEE106.ent.ti.com
 (157.170.170.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Thu, 12
 Jun 2025 02:16:09 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DLEE107.ent.ti.com
 (157.170.170.37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55 via
 Frontend Transport; Thu, 12 Jun 2025 02:16:09 -0500
Received: from uda0498651.dhcp.ti.com (uda0498651.dhcp.ti.com [172.24.227.7])
	by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 55C7FTKT1608959;
	Thu, 12 Jun 2025 02:16:05 -0500
From: Sai Sree Kartheek Adivi <s-adivi@ti.com>
To: Peter Ujfalusi <peter.ujfalusi@gmail.com>, Vinod Koul <vkoul@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, Nishanth Menon <nm@ti.com>,
        Santosh
 Shilimkar <ssantosh@kernel.org>,
        Sai Sree Kartheek Adivi <s-adivi@ti.com>, <dmaengine@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <praneeth@ti.com>,
        <vigneshr@ti.com>, <u-kumar1@ti.com>, <a-chavda@ti.com>,
        <p-mantena@ti.com>
Subject: [PATCH v2 07/17] dmaengine: ti: k3-udma: move udma utility functions to k3-udma-common.c
Date: Thu, 12 Jun 2025 12:45:11 +0530
Message-ID: <20250612071521.3116831-8-s-adivi@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250612071521.3116831-1-s-adivi@ti.com>
References: <20250612071521.3116831-1-s-adivi@ti.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

Relocate udma utility functions from k3-udma.c to k3-udma-common.c file.

The implementation of these functions is largely shared between K3 UDMA
and K3 UDMA v2. This refactor improves code reuse and maintainability
across multiple variants.

No functional changes intended.

Signed-off-by: Sai Sree Kartheek Adivi <s-adivi@ti.com>
---
 drivers/dma/ti/k3-udma-common.c | 532 +++++++++++++++++++++++++++++++
 drivers/dma/ti/k3-udma.c        | 535 +-------------------------------
 drivers/dma/ti/k3-udma.h        |  31 ++
 3 files changed, 565 insertions(+), 533 deletions(-)

diff --git a/drivers/dma/ti/k3-udma-common.c b/drivers/dma/ti/k3-udma-common.c
index 35a3149f03232..13f3d5cec2135 100644
--- a/drivers/dma/ti/k3-udma-common.c
+++ b/drivers/dma/ti/k3-udma-common.c
@@ -4,6 +4,7 @@
  *  Author: Peter Ujfalusi <peter.ujfalusi@ti.com>
  */
 
+#include <linux/delay.h>
 #include <linux/dmaengine.h>
 #include <linux/dma-mapping.h>
 #include <linux/dmapool.h>
@@ -46,6 +47,27 @@ struct udma_desc *udma_udma_desc_from_paddr(struct udma_chan *uc,
 	return d;
 }
 
+void udma_start_desc(struct udma_chan *uc)
+{
+	struct udma_chan_config *ucc = &uc->config;
+
+	if (uc->ud->match_data->type == DMA_TYPE_UDMA && ucc->pkt_mode &&
+	    (uc->cyclic || ucc->dir == DMA_DEV_TO_MEM)) {
+		int i;
+
+		/*
+		 * UDMA only: Push all descriptors to ring for packet mode
+		 * cyclic or RX
+		 * PKTDMA supports pre-linked descriptor and cyclic is not
+		 * supported
+		 */
+		for (i = 0; i < uc->desc->sglen; i++)
+			udma_push_to_ring(uc, i);
+	} else {
+		udma_push_to_ring(uc, 0);
+	}
+}
+
 void udma_free_hwdesc(struct udma_chan *uc, struct udma_desc *d)
 {
 	if (uc->use_dma_pool) {
@@ -1331,3 +1353,513 @@ void udma_reset_rings(struct udma_chan *uc)
 	}
 }
 
+u8 udma_get_chan_tpl_index(struct udma_tpl *tpl_map, int chan_id)
+{
+	int i;
+
+	for (i = 0; i < tpl_map->levels; i++) {
+		if (chan_id >= tpl_map->start_idx[i])
+			return i;
+	}
+
+	return 0;
+}
+
+void k3_configure_chan_coherency(struct dma_chan *chan, u32 asel)
+{
+	struct device *chan_dev = &chan->dev->device;
+
+	if (asel == 0) {
+		/* No special handling for the channel */
+		chan->dev->chan_dma_dev = false;
+
+		chan_dev->dma_coherent = false;
+		chan_dev->dma_parms = NULL;
+	} else if (asel == 14 || asel == 15) {
+		chan->dev->chan_dma_dev = true;
+
+		chan_dev->dma_coherent = true;
+		dma_coerce_mask_and_coherent(chan_dev, DMA_BIT_MASK(48));
+		chan_dev->dma_parms = chan_dev->parent->dma_parms;
+	} else {
+		dev_warn(chan->device->dev, "Invalid ASEL value: %u\n", asel);
+
+		chan_dev->dma_coherent = false;
+		chan_dev->dma_parms = NULL;
+	}
+}
+
+void udma_reset_uchan(struct udma_chan *uc)
+{
+	memset(&uc->config, 0, sizeof(uc->config));
+	uc->config.remote_thread_id = -1;
+	uc->config.mapped_channel_id = -1;
+	uc->config.default_flow_id = -1;
+	uc->state = UDMA_CHAN_IS_IDLE;
+}
+
+void udma_dump_chan_stdata(struct udma_chan *uc)
+{
+	struct device *dev = uc->ud->dev;
+	u32 offset;
+	int i;
+
+	if (uc->config.dir == DMA_MEM_TO_DEV || uc->config.dir == DMA_MEM_TO_MEM) {
+		dev_dbg(dev, "TCHAN State data:\n");
+		for (i = 0; i < 32; i++) {
+			offset = UDMA_CHAN_RT_STDATA_REG + i * 4;
+			dev_dbg(dev, "TRT_STDATA[%02d]: 0x%08x\n", i,
+				udma_tchanrt_read(uc, offset));
+		}
+	}
+
+	if (uc->config.dir == DMA_DEV_TO_MEM || uc->config.dir == DMA_MEM_TO_MEM) {
+		dev_dbg(dev, "RCHAN State data:\n");
+		for (i = 0; i < 32; i++) {
+			offset = UDMA_CHAN_RT_STDATA_REG + i * 4;
+			dev_dbg(dev, "RRT_STDATA[%02d]: 0x%08x\n", i,
+				udma_rchanrt_read(uc, offset));
+		}
+	}
+}
+
+bool udma_is_chan_running(struct udma_chan *uc)
+{
+	u32 trt_ctl = 0;
+	u32 rrt_ctl = 0;
+
+	if (uc->tchan)
+		trt_ctl = udma_tchanrt_read(uc, UDMA_CHAN_RT_CTL_REG);
+	if (uc->rchan)
+		rrt_ctl = udma_rchanrt_read(uc, UDMA_CHAN_RT_CTL_REG);
+
+	if (trt_ctl & UDMA_CHAN_RT_CTL_EN || rrt_ctl & UDMA_CHAN_RT_CTL_EN)
+		return true;
+
+	return false;
+}
+
+bool udma_chan_needs_reconfiguration(struct udma_chan *uc)
+{
+	/* Only PDMAs have staticTR */
+	if (uc->config.ep_type == PSIL_EP_NATIVE)
+		return false;
+
+	/* Check if the staticTR configuration has changed for TX */
+	if (memcmp(&uc->static_tr, &uc->desc->static_tr, sizeof(uc->static_tr)))
+		return true;
+
+	return false;
+}
+
+void udma_cyclic_packet_elapsed(struct udma_chan *uc)
+{
+	struct udma_desc *d = uc->desc;
+	struct cppi5_host_desc_t *h_desc;
+
+	h_desc = d->hwdesc[d->desc_idx].cppi5_desc_vaddr;
+	cppi5_hdesc_reset_to_original(h_desc);
+	udma_push_to_ring(uc, d->desc_idx);
+	d->desc_idx = (d->desc_idx + 1) % d->sglen;
+}
+
+void udma_check_tx_completion(struct work_struct *work)
+{
+	struct udma_chan *uc = container_of(work, typeof(*uc),
+					    tx_drain.work.work);
+	bool desc_done = true;
+	u32 residue_diff;
+	ktime_t time_diff;
+	unsigned long delay;
+	unsigned long flags;
+
+	while (1) {
+		spin_lock_irqsave(&uc->vc.lock, flags);
+
+		if (uc->desc) {
+			/* Get previous residue and time stamp */
+			residue_diff = uc->tx_drain.residue;
+			time_diff = uc->tx_drain.tstamp;
+			/*
+			 * Get current residue and time stamp or see if
+			 * transfer is complete
+			 */
+			desc_done = udma_is_desc_really_done(uc, uc->desc);
+		}
+
+		if (!desc_done) {
+			/*
+			 * Find the time delta and residue delta w.r.t
+			 * previous poll
+			 */
+			time_diff = ktime_sub(uc->tx_drain.tstamp,
+					      time_diff) + 1;
+			residue_diff -= uc->tx_drain.residue;
+			if (residue_diff) {
+				/*
+				 * Try to guess when we should check
+				 * next time by calculating rate at
+				 * which data is being drained at the
+				 * peer device
+				 */
+				delay = (time_diff / residue_diff) *
+					uc->tx_drain.residue;
+			} else {
+				/* No progress, check again in 1 second  */
+				schedule_delayed_work(&uc->tx_drain.work, HZ);
+				break;
+			}
+
+			spin_unlock_irqrestore(&uc->vc.lock, flags);
+
+			usleep_range(ktime_to_us(delay),
+				     ktime_to_us(delay) + 10);
+			continue;
+		}
+
+		if (uc->desc) {
+			struct udma_desc *d = uc->desc;
+
+			uc->ud->decrement_byte_counters(uc, d->residue);
+			uc->ud->start(uc);
+			vchan_cookie_complete(&d->vd);
+			break;
+		}
+
+		break;
+	}
+
+	spin_unlock_irqrestore(&uc->vc.lock, flags);
+}
+
+int udma_slave_config(struct dma_chan *chan,
+			     struct dma_slave_config *cfg)
+{
+	struct udma_chan *uc = to_udma_chan(chan);
+
+	memcpy(&uc->cfg, cfg, sizeof(uc->cfg));
+
+	return 0;
+}
+
+void udma_issue_pending(struct dma_chan *chan)
+{
+	struct udma_chan *uc = to_udma_chan(chan);
+	unsigned long flags;
+
+	spin_lock_irqsave(&uc->vc.lock, flags);
+
+	/* If we have something pending and no active descriptor, then */
+	if (vchan_issue_pending(&uc->vc) && !uc->desc) {
+		/*
+		 * start a descriptor if the channel is NOT [marked as
+		 * terminating _and_ it is still running (teardown has not
+		 * completed yet)].
+		 */
+		if (!(uc->state == UDMA_CHAN_IS_TERMINATING &&
+		      udma_is_chan_running(uc)))
+			uc->ud->start(uc);
+	}
+
+	spin_unlock_irqrestore(&uc->vc.lock, flags);
+}
+
+int udma_terminate_all(struct dma_chan *chan)
+{
+	struct udma_chan *uc = to_udma_chan(chan);
+	unsigned long flags;
+	LIST_HEAD(head);
+
+	spin_lock_irqsave(&uc->vc.lock, flags);
+
+	if (udma_is_chan_running(uc))
+		uc->ud->stop(uc);
+
+	if (uc->desc) {
+		uc->terminated_desc = uc->desc;
+		uc->desc = NULL;
+		uc->terminated_desc->terminated = true;
+		cancel_delayed_work(&uc->tx_drain.work);
+	}
+
+	uc->paused = false;
+
+	vchan_get_all_descriptors(&uc->vc, &head);
+	spin_unlock_irqrestore(&uc->vc.lock, flags);
+	vchan_dma_desc_free_list(&uc->vc, &head);
+
+	return 0;
+}
+
+void udma_synchronize(struct dma_chan *chan)
+{
+	struct udma_chan *uc = to_udma_chan(chan);
+	unsigned long timeout = msecs_to_jiffies(1000);
+
+	vchan_synchronize(&uc->vc);
+
+	if (uc->state == UDMA_CHAN_IS_TERMINATING) {
+		timeout = wait_for_completion_timeout(&uc->teardown_completed,
+						      timeout);
+		if (!timeout) {
+			dev_warn(uc->ud->dev, "chan%d teardown timeout!\n",
+				 uc->id);
+			udma_dump_chan_stdata(uc);
+			uc->ud->reset_chan(uc, true);
+		}
+	}
+
+	uc->ud->reset_chan(uc, false);
+	if (udma_is_chan_running(uc))
+		dev_warn(uc->ud->dev, "chan%d refused to stop!\n", uc->id);
+
+	cancel_delayed_work_sync(&uc->tx_drain.work);
+	udma_reset_rings(uc);
+}
+
+/*
+ * This tasklet handles the completion of a DMA descriptor by
+ * calling its callback and freeing it.
+ */
+void udma_vchan_complete(struct tasklet_struct *t)
+{
+	struct virt_dma_chan *vc = from_tasklet(vc, t, task);
+	struct virt_dma_desc *vd, *_vd;
+	struct dmaengine_desc_callback cb;
+	LIST_HEAD(head);
+
+	spin_lock_irq(&vc->lock);
+	list_splice_tail_init(&vc->desc_completed, &head);
+	vd = vc->cyclic;
+	if (vd) {
+		vc->cyclic = NULL;
+		dmaengine_desc_get_callback(&vd->tx, &cb);
+	} else {
+		memset(&cb, 0, sizeof(cb));
+	}
+	spin_unlock_irq(&vc->lock);
+
+	udma_desc_pre_callback(vc, vd, NULL);
+	dmaengine_desc_callback_invoke(&cb, NULL);
+
+	list_for_each_entry_safe(vd, _vd, &head, node) {
+		struct dmaengine_result result;
+
+		dmaengine_desc_get_callback(&vd->tx, &cb);
+
+		list_del(&vd->node);
+
+		udma_desc_pre_callback(vc, vd, &result);
+		dmaengine_desc_callback_invoke(&cb, &result);
+
+		vchan_vdesc_fini(vd);
+	}
+}
+
+void udma_mark_resource_ranges(struct udma_dev *ud, unsigned long *map,
+				      struct ti_sci_resource_desc *rm_desc,
+				      char *name)
+{
+	bitmap_clear(map, rm_desc->start, rm_desc->num);
+	bitmap_clear(map, rm_desc->start_sec, rm_desc->num_sec);
+	dev_dbg(ud->dev, "ti_sci resource range for %s: %d:%d | %d:%d\n", name,
+		rm_desc->start, rm_desc->num, rm_desc->start_sec,
+		rm_desc->num_sec);
+}
+
+int udma_setup_rx_flush(struct udma_dev *ud)
+{
+	struct udma_rx_flush *rx_flush = &ud->rx_flush;
+	struct cppi5_desc_hdr_t *tr_desc;
+	struct cppi5_tr_type1_t *tr_req;
+	struct cppi5_host_desc_t *desc;
+	struct device *dev = ud->dev;
+	struct udma_hwdesc *hwdesc;
+	size_t tr_size;
+
+	/* Allocate 1K buffer for discarded data on RX channel teardown */
+	rx_flush->buffer_size = SZ_1K;
+	rx_flush->buffer_vaddr = devm_kzalloc(dev, rx_flush->buffer_size,
+					      GFP_KERNEL);
+	if (!rx_flush->buffer_vaddr)
+		return -ENOMEM;
+
+	rx_flush->buffer_paddr = dma_map_single(dev, rx_flush->buffer_vaddr,
+						rx_flush->buffer_size,
+						DMA_TO_DEVICE);
+	if (dma_mapping_error(dev, rx_flush->buffer_paddr))
+		return -ENOMEM;
+
+	/* Set up descriptor to be used for TR mode */
+	hwdesc = &rx_flush->hwdescs[0];
+	tr_size = sizeof(struct cppi5_tr_type1_t);
+	hwdesc->cppi5_desc_size = cppi5_trdesc_calc_size(tr_size, 1);
+	hwdesc->cppi5_desc_size = ALIGN(hwdesc->cppi5_desc_size,
+					ud->desc_align);
+
+	hwdesc->cppi5_desc_vaddr = devm_kzalloc(dev, hwdesc->cppi5_desc_size,
+						GFP_KERNEL);
+	if (!hwdesc->cppi5_desc_vaddr)
+		return -ENOMEM;
+
+	hwdesc->cppi5_desc_paddr = dma_map_single(dev, hwdesc->cppi5_desc_vaddr,
+						  hwdesc->cppi5_desc_size,
+						  DMA_TO_DEVICE);
+	if (dma_mapping_error(dev, hwdesc->cppi5_desc_paddr))
+		return -ENOMEM;
+
+	/* Start of the TR req records */
+	hwdesc->tr_req_base = hwdesc->cppi5_desc_vaddr + tr_size;
+	/* Start address of the TR response array */
+	hwdesc->tr_resp_base = hwdesc->tr_req_base + tr_size;
+
+	tr_desc = hwdesc->cppi5_desc_vaddr;
+	cppi5_trdesc_init(tr_desc, 1, tr_size, 0, 0);
+	cppi5_desc_set_pktids(tr_desc, 0, CPPI5_INFO1_DESC_FLOWID_DEFAULT);
+	cppi5_desc_set_retpolicy(tr_desc, 0, 0);
+
+	tr_req = hwdesc->tr_req_base;
+	cppi5_tr_init(&tr_req->flags, CPPI5_TR_TYPE1, false, false,
+		      CPPI5_TR_EVENT_SIZE_COMPLETION, 0);
+	cppi5_tr_csf_set(&tr_req->flags, CPPI5_TR_CSF_SUPR_EVT);
+
+	tr_req->addr = rx_flush->buffer_paddr;
+	tr_req->icnt0 = rx_flush->buffer_size;
+	tr_req->icnt1 = 1;
+
+	dma_sync_single_for_device(dev, hwdesc->cppi5_desc_paddr,
+				   hwdesc->cppi5_desc_size, DMA_TO_DEVICE);
+
+	/* Set up descriptor to be used for packet mode */
+	hwdesc = &rx_flush->hwdescs[1];
+	hwdesc->cppi5_desc_size = ALIGN(sizeof(struct cppi5_host_desc_t) +
+					CPPI5_INFO0_HDESC_EPIB_SIZE +
+					CPPI5_INFO0_HDESC_PSDATA_MAX_SIZE,
+					ud->desc_align);
+
+	hwdesc->cppi5_desc_vaddr = devm_kzalloc(dev, hwdesc->cppi5_desc_size,
+						GFP_KERNEL);
+	if (!hwdesc->cppi5_desc_vaddr)
+		return -ENOMEM;
+
+	hwdesc->cppi5_desc_paddr = dma_map_single(dev, hwdesc->cppi5_desc_vaddr,
+						  hwdesc->cppi5_desc_size,
+						  DMA_TO_DEVICE);
+	if (dma_mapping_error(dev, hwdesc->cppi5_desc_paddr))
+		return -ENOMEM;
+
+	desc = hwdesc->cppi5_desc_vaddr;
+	cppi5_hdesc_init(desc, 0, 0);
+	cppi5_desc_set_pktids(&desc->hdr, 0, CPPI5_INFO1_DESC_FLOWID_DEFAULT);
+	cppi5_desc_set_retpolicy(&desc->hdr, 0, 0);
+
+	cppi5_hdesc_attach_buf(desc,
+			       rx_flush->buffer_paddr, rx_flush->buffer_size,
+			       rx_flush->buffer_paddr, rx_flush->buffer_size);
+
+	dma_sync_single_for_device(dev, hwdesc->cppi5_desc_paddr,
+				   hwdesc->cppi5_desc_size, DMA_TO_DEVICE);
+	return 0;
+}
+
+#ifdef CONFIG_DEBUG_FS
+void udma_dbg_summary_show_chan(struct seq_file *s,
+				       struct dma_chan *chan)
+{
+	struct udma_chan *uc = to_udma_chan(chan);
+	struct udma_chan_config *ucc = &uc->config;
+
+	seq_printf(s, " %-13s| %s", dma_chan_name(chan),
+		   chan->dbg_client_name ?: "in-use");
+	if (ucc->tr_trigger_type)
+		seq_puts(s, " (triggered, ");
+	else
+		seq_printf(s, " (%s, ",
+			   dmaengine_get_direction_text(uc->config.dir));
+
+	switch (uc->config.dir) {
+	case DMA_MEM_TO_MEM:
+		if (uc->ud->match_data->type == DMA_TYPE_BCDMA) {
+			seq_printf(s, "bchan%d)\n", uc->bchan->id);
+			return;
+		}
+
+		seq_printf(s, "chan%d pair [0x%04x -> 0x%04x], ", uc->tchan->id,
+			   ucc->src_thread, ucc->dst_thread);
+		break;
+	case DMA_DEV_TO_MEM:
+		seq_printf(s, "rchan%d [0x%04x -> 0x%04x], ", uc->rchan->id,
+			   ucc->src_thread, ucc->dst_thread);
+		if (uc->ud->match_data->type == DMA_TYPE_PKTDMA)
+			seq_printf(s, "rflow%d, ", uc->rflow->id);
+		break;
+	case DMA_MEM_TO_DEV:
+		seq_printf(s, "tchan%d [0x%04x -> 0x%04x], ", uc->tchan->id,
+			   ucc->src_thread, ucc->dst_thread);
+		if (uc->ud->match_data->type == DMA_TYPE_PKTDMA)
+			seq_printf(s, "tflow%d, ", uc->tchan->tflow_id);
+		break;
+	default:
+		seq_printf(s, ")\n");
+		return;
+	}
+
+	if (ucc->ep_type == PSIL_EP_NATIVE) {
+		seq_printf(s, "PSI-L Native");
+		if (ucc->metadata_size) {
+			seq_printf(s, "[%s", ucc->needs_epib ? " EPIB" : "");
+			if (ucc->psd_size)
+				seq_printf(s, " PSDsize:%u", ucc->psd_size);
+			seq_printf(s, " ]");
+		}
+	} else {
+		seq_printf(s, "PDMA");
+		if (ucc->enable_acc32 || ucc->enable_burst)
+			seq_printf(s, "[%s%s ]",
+				   ucc->enable_acc32 ? " ACC32" : "",
+				   ucc->enable_burst ? " BURST" : "");
+	}
+
+	seq_printf(s, ", %s)\n", ucc->pkt_mode ? "Packet mode" : "TR mode");
+}
+
+void udma_dbg_summary_show(struct seq_file *s,
+				  struct dma_device *dma_dev)
+{
+	struct dma_chan *chan;
+
+	list_for_each_entry(chan, &dma_dev->channels, device_node) {
+		if (chan->client_count)
+			udma_dbg_summary_show_chan(s, chan);
+	}
+}
+#endif /* CONFIG_DEBUG_FS */
+
+enum dmaengine_alignment udma_get_copy_align(struct udma_dev *ud)
+{
+	const struct udma_match_data *match_data = ud->match_data;
+	u8 tpl;
+
+	if (!match_data->enable_memcpy_support)
+		return DMAENGINE_ALIGN_8_BYTES;
+
+	/* Get the highest TPL level the device supports for memcpy */
+	if (ud->bchan_cnt)
+		tpl = udma_get_chan_tpl_index(&ud->bchan_tpl, 0);
+	else if (ud->tchan_cnt)
+		tpl = udma_get_chan_tpl_index(&ud->tchan_tpl, 0);
+	else
+		return DMAENGINE_ALIGN_8_BYTES;
+
+	switch (match_data->burst_size[tpl]) {
+	case TI_SCI_RM_UDMAP_CHAN_BURST_SIZE_256_BYTES:
+		return DMAENGINE_ALIGN_256_BYTES;
+	case TI_SCI_RM_UDMAP_CHAN_BURST_SIZE_128_BYTES:
+		return DMAENGINE_ALIGN_128_BYTES;
+	case TI_SCI_RM_UDMAP_CHAN_BURST_SIZE_64_BYTES:
+	fallthrough;
+	default:
+		return DMAENGINE_ALIGN_64_BYTES;
+	}
+}
+
diff --git a/drivers/dma/ti/k3-udma.c b/drivers/dma/ti/k3-udma.c
index db342682edb23..e102f219ce34e 100644
--- a/drivers/dma/ti/k3-udma.c
+++ b/drivers/dma/ti/k3-udma.c
@@ -40,7 +40,7 @@ static const char * const mmr_names[] = {
 	[MMR_TCHANRT] = "tchanrt",
 };
 
-static int navss_psil_pair(struct udma_dev *ud, u32 src_thread, u32 dst_thread)
+int navss_psil_pair(struct udma_dev *ud, u32 src_thread, u32 dst_thread)
 {
 	struct udma_tisci_rm *tisci_rm = &ud->tisci_rm;
 
@@ -50,7 +50,7 @@ static int navss_psil_pair(struct udma_dev *ud, u32 src_thread, u32 dst_thread)
 					      src_thread, dst_thread);
 }
 
-static int navss_psil_unpair(struct udma_dev *ud, u32 src_thread,
+int navss_psil_unpair(struct udma_dev *ud, u32 src_thread,
 			     u32 dst_thread)
 {
 	struct udma_tisci_rm *tisci_rm = &ud->tisci_rm;
@@ -61,92 +61,6 @@ static int navss_psil_unpair(struct udma_dev *ud, u32 src_thread,
 						src_thread, dst_thread);
 }
 
-static void k3_configure_chan_coherency(struct dma_chan *chan, u32 asel)
-{
-	struct device *chan_dev = &chan->dev->device;
-
-	if (asel == 0) {
-		/* No special handling for the channel */
-		chan->dev->chan_dma_dev = false;
-
-		chan_dev->dma_coherent = false;
-		chan_dev->dma_parms = NULL;
-	} else if (asel == 14 || asel == 15) {
-		chan->dev->chan_dma_dev = true;
-
-		chan_dev->dma_coherent = true;
-		dma_coerce_mask_and_coherent(chan_dev, DMA_BIT_MASK(48));
-		chan_dev->dma_parms = chan_dev->parent->dma_parms;
-	} else {
-		dev_warn(chan->device->dev, "Invalid ASEL value: %u\n", asel);
-
-		chan_dev->dma_coherent = false;
-		chan_dev->dma_parms = NULL;
-	}
-}
-
-static u8 udma_get_chan_tpl_index(struct udma_tpl *tpl_map, int chan_id)
-{
-	int i;
-
-	for (i = 0; i < tpl_map->levels; i++) {
-		if (chan_id >= tpl_map->start_idx[i])
-			return i;
-	}
-
-	return 0;
-}
-
-static void udma_reset_uchan(struct udma_chan *uc)
-{
-	memset(&uc->config, 0, sizeof(uc->config));
-	uc->config.remote_thread_id = -1;
-	uc->config.mapped_channel_id = -1;
-	uc->config.default_flow_id = -1;
-	uc->state = UDMA_CHAN_IS_IDLE;
-}
-
-static void udma_dump_chan_stdata(struct udma_chan *uc)
-{
-	struct device *dev = uc->ud->dev;
-	u32 offset;
-	int i;
-
-	if (uc->config.dir == DMA_MEM_TO_DEV || uc->config.dir == DMA_MEM_TO_MEM) {
-		dev_dbg(dev, "TCHAN State data:\n");
-		for (i = 0; i < 32; i++) {
-			offset = UDMA_CHAN_RT_STDATA_REG + i * 4;
-			dev_dbg(dev, "TRT_STDATA[%02d]: 0x%08x\n", i,
-				udma_tchanrt_read(uc, offset));
-		}
-	}
-
-	if (uc->config.dir == DMA_DEV_TO_MEM || uc->config.dir == DMA_MEM_TO_MEM) {
-		dev_dbg(dev, "RCHAN State data:\n");
-		for (i = 0; i < 32; i++) {
-			offset = UDMA_CHAN_RT_STDATA_REG + i * 4;
-			dev_dbg(dev, "RRT_STDATA[%02d]: 0x%08x\n", i,
-				udma_rchanrt_read(uc, offset));
-		}
-	}
-}
-
-static bool udma_is_chan_running(struct udma_chan *uc)
-{
-	u32 trt_ctl = 0;
-	u32 rrt_ctl = 0;
-
-	if (uc->tchan)
-		trt_ctl = udma_tchanrt_read(uc, UDMA_CHAN_RT_CTL_REG);
-	if (uc->rchan)
-		rrt_ctl = udma_rchanrt_read(uc, UDMA_CHAN_RT_CTL_REG);
-
-	if (trt_ctl & UDMA_CHAN_RT_CTL_EN || rrt_ctl & UDMA_CHAN_RT_CTL_EN)
-		return true;
-
-	return false;
-}
-
 static bool udma_is_chan_paused(struct udma_chan *uc)
 {
 	u32 val, pause_mask;
@@ -275,40 +189,6 @@ static int udma_reset_chan(struct udma_chan *uc, bool hard)
 	return 0;
 }
 
-static void udma_start_desc(struct udma_chan *uc)
-{
-	struct udma_chan_config *ucc = &uc->config;
-
-	if (uc->ud->match_data->type == DMA_TYPE_UDMA && ucc->pkt_mode &&
-	    (uc->cyclic || ucc->dir == DMA_DEV_TO_MEM)) {
-		int i;
-
-		/*
-		 * UDMA only: Push all descriptors to ring for packet mode
-		 * cyclic or RX
-		 * PKTDMA supports pre-linked descriptor and cyclic is not
-		 * supported
-		 */
-		for (i = 0; i < uc->desc->sglen; i++)
-			udma_push_to_ring(uc, i);
-	} else {
-		udma_push_to_ring(uc, 0);
-	}
-}
-
-static bool udma_chan_needs_reconfiguration(struct udma_chan *uc)
-{
-	/* Only PDMAs have staticTR */
-	if (uc->config.ep_type == PSIL_EP_NATIVE)
-		return false;
-
-	/* Check if the staticTR configuration has changed for TX */
-	if (memcmp(&uc->static_tr, &uc->desc->static_tr, sizeof(uc->static_tr)))
-		return true;
-
-	return false;
-}
-
 static int udma_start(struct udma_chan *uc)
 {
 	struct virt_dma_desc *vd = vchan_next_desc(&uc->vc);
@@ -453,86 +333,6 @@ static int udma_stop(struct udma_chan *uc)
 	return 0;
 }
 
-static void udma_cyclic_packet_elapsed(struct udma_chan *uc)
-{
-	struct udma_desc *d = uc->desc;
-	struct cppi5_host_desc_t *h_desc;
-
-	h_desc = d->hwdesc[d->desc_idx].cppi5_desc_vaddr;
-	cppi5_hdesc_reset_to_original(h_desc);
-	udma_push_to_ring(uc, d->desc_idx);
-	d->desc_idx = (d->desc_idx + 1) % d->sglen;
-}
-
-static void udma_check_tx_completion(struct work_struct *work)
-{
-	struct udma_chan *uc = container_of(work, typeof(*uc),
-					    tx_drain.work.work);
-	bool desc_done = true;
-	u32 residue_diff;
-	ktime_t time_diff;
-	unsigned long delay;
-	unsigned long flags;
-
-	while (1) {
-		spin_lock_irqsave(&uc->vc.lock, flags);
-
-		if (uc->desc) {
-			/* Get previous residue and time stamp */
-			residue_diff = uc->tx_drain.residue;
-			time_diff = uc->tx_drain.tstamp;
-			/*
-			 * Get current residue and time stamp or see if
-			 * transfer is complete
-			 */
-			desc_done = udma_is_desc_really_done(uc, uc->desc);
-		}
-
-		if (!desc_done) {
-			/*
-			 * Find the time delta and residue delta w.r.t
-			 * previous poll
-			 */
-			time_diff = ktime_sub(uc->tx_drain.tstamp,
-					      time_diff) + 1;
-			residue_diff -= uc->tx_drain.residue;
-			if (residue_diff) {
-				/*
-				 * Try to guess when we should check
-				 * next time by calculating rate at
-				 * which data is being drained at the
-				 * peer device
-				 */
-				delay = (time_diff / residue_diff) *
-					uc->tx_drain.residue;
-			} else {
-				/* No progress, check again in 1 second  */
-				schedule_delayed_work(&uc->tx_drain.work, HZ);
-				break;
-			}
-
-			spin_unlock_irqrestore(&uc->vc.lock, flags);
-
-			usleep_range(ktime_to_us(delay),
-				     ktime_to_us(delay) + 10);
-			continue;
-		}
-
-		if (uc->desc) {
-			struct udma_desc *d = uc->desc;
-
-			uc->ud->decrement_byte_counters(uc, d->residue);
-			uc->ud->start(uc);
-			vchan_cookie_complete(&d->vd);
-			break;
-		}
-
-		break;
-	}
-
-	spin_unlock_irqrestore(&uc->vc.lock, flags);
-}
-
 static irqreturn_t udma_ring_irq_handler(int irq, void *data)
 {
 	struct udma_chan *uc = data;
@@ -2097,38 +1897,6 @@ static int pktdma_alloc_chan_resources(struct dma_chan *chan)
 	return ret;
 }
 
-static int udma_slave_config(struct dma_chan *chan,
-			     struct dma_slave_config *cfg)
-{
-	struct udma_chan *uc = to_udma_chan(chan);
-
-	memcpy(&uc->cfg, cfg, sizeof(uc->cfg));
-
-	return 0;
-}
-
-static void udma_issue_pending(struct dma_chan *chan)
-{
-	struct udma_chan *uc = to_udma_chan(chan);
-	unsigned long flags;
-
-	spin_lock_irqsave(&uc->vc.lock, flags);
-
-	/* If we have something pending and no active descriptor, then */
-	if (vchan_issue_pending(&uc->vc) && !uc->desc) {
-		/*
-		 * start a descriptor if the channel is NOT [marked as
-		 * terminating _and_ it is still running (teardown has not
-		 * completed yet)].
-		 */
-		if (!(uc->state == UDMA_CHAN_IS_TERMINATING &&
-		      udma_is_chan_running(uc)))
-			uc->ud->start(uc);
-	}
-
-	spin_unlock_irqrestore(&uc->vc.lock, flags);
-}
-
 static enum dma_status udma_tx_status(struct dma_chan *chan,
 				      dma_cookie_t cookie,
 				      struct dma_tx_state *txstate)
@@ -2256,98 +2024,6 @@ static int udma_resume(struct dma_chan *chan)
 	return 0;
 }
 
-static int udma_terminate_all(struct dma_chan *chan)
-{
-	struct udma_chan *uc = to_udma_chan(chan);
-	unsigned long flags;
-	LIST_HEAD(head);
-
-	spin_lock_irqsave(&uc->vc.lock, flags);
-
-	if (udma_is_chan_running(uc))
-		uc->ud->stop(uc);
-
-	if (uc->desc) {
-		uc->terminated_desc = uc->desc;
-		uc->desc = NULL;
-		uc->terminated_desc->terminated = true;
-		cancel_delayed_work(&uc->tx_drain.work);
-	}
-
-	uc->paused = false;
-
-	vchan_get_all_descriptors(&uc->vc, &head);
-	spin_unlock_irqrestore(&uc->vc.lock, flags);
-	vchan_dma_desc_free_list(&uc->vc, &head);
-
-	return 0;
-}
-
-static void udma_synchronize(struct dma_chan *chan)
-{
-	struct udma_chan *uc = to_udma_chan(chan);
-	unsigned long timeout = msecs_to_jiffies(1000);
-
-	vchan_synchronize(&uc->vc);
-
-	if (uc->state == UDMA_CHAN_IS_TERMINATING) {
-		timeout = wait_for_completion_timeout(&uc->teardown_completed,
-						      timeout);
-		if (!timeout) {
-			dev_warn(uc->ud->dev, "chan%d teardown timeout!\n",
-				 uc->id);
-			udma_dump_chan_stdata(uc);
-			uc->ud->reset_chan(uc, true);
-		}
-	}
-
-	uc->ud->reset_chan(uc, false);
-	if (udma_is_chan_running(uc))
-		dev_warn(uc->ud->dev, "chan%d refused to stop!\n", uc->id);
-
-	cancel_delayed_work_sync(&uc->tx_drain.work);
-	udma_reset_rings(uc);
-}
-
-/*
- * This tasklet handles the completion of a DMA descriptor by
- * calling its callback and freeing it.
- */
-static void udma_vchan_complete(struct tasklet_struct *t)
-{
-	struct virt_dma_chan *vc = from_tasklet(vc, t, task);
-	struct virt_dma_desc *vd, *_vd;
-	struct dmaengine_desc_callback cb;
-	LIST_HEAD(head);
-
-	spin_lock_irq(&vc->lock);
-	list_splice_tail_init(&vc->desc_completed, &head);
-	vd = vc->cyclic;
-	if (vd) {
-		vc->cyclic = NULL;
-		dmaengine_desc_get_callback(&vd->tx, &cb);
-	} else {
-		memset(&cb, 0, sizeof(cb));
-	}
-	spin_unlock_irq(&vc->lock);
-
-	udma_desc_pre_callback(vc, vd, NULL);
-	dmaengine_desc_callback_invoke(&cb, NULL);
-
-	list_for_each_entry_safe(vd, _vd, &head, node) {
-		struct dmaengine_result result;
-
-		dmaengine_desc_get_callback(&vd->tx, &cb);
-
-		list_del(&vd->node);
-
-		udma_desc_pre_callback(vc, vd, &result);
-		dmaengine_desc_callback_invoke(&cb, &result);
-
-		vchan_vdesc_fini(vd);
-	}
-}
-
 static void udma_free_chan_resources(struct dma_chan *chan)
 {
 	struct udma_chan *uc = to_udma_chan(chan);
@@ -2822,17 +2498,6 @@ static int udma_get_mmrs(struct platform_device *pdev, struct udma_dev *ud)
 	return 0;
 }
 
-static void udma_mark_resource_ranges(struct udma_dev *ud, unsigned long *map,
-				      struct ti_sci_resource_desc *rm_desc,
-				      char *name)
-{
-	bitmap_clear(map, rm_desc->start, rm_desc->num);
-	bitmap_clear(map, rm_desc->start_sec, rm_desc->num_sec);
-	dev_dbg(ud->dev, "ti_sci resource range for %s: %d:%d | %d:%d\n", name,
-		rm_desc->start, rm_desc->num, rm_desc->start_sec,
-		rm_desc->num_sec);
-}
-
 static const char * const range_names[] = {
 	[RM_RANGE_BCHAN] = "ti,sci-rm-range-bchan",
 	[RM_RANGE_TCHAN] = "ti,sci-rm-range-tchan",
@@ -3463,202 +3128,6 @@ static int setup_resources(struct udma_dev *ud)
 	return ch_count;
 }
 
-static int udma_setup_rx_flush(struct udma_dev *ud)
-{
-	struct udma_rx_flush *rx_flush = &ud->rx_flush;
-	struct cppi5_desc_hdr_t *tr_desc;
-	struct cppi5_tr_type1_t *tr_req;
-	struct cppi5_host_desc_t *desc;
-	struct device *dev = ud->dev;
-	struct udma_hwdesc *hwdesc;
-	size_t tr_size;
-
-	/* Allocate 1K buffer for discarded data on RX channel teardown */
-	rx_flush->buffer_size = SZ_1K;
-	rx_flush->buffer_vaddr = devm_kzalloc(dev, rx_flush->buffer_size,
-					      GFP_KERNEL);
-	if (!rx_flush->buffer_vaddr)
-		return -ENOMEM;
-
-	rx_flush->buffer_paddr = dma_map_single(dev, rx_flush->buffer_vaddr,
-						rx_flush->buffer_size,
-						DMA_TO_DEVICE);
-	if (dma_mapping_error(dev, rx_flush->buffer_paddr))
-		return -ENOMEM;
-
-	/* Set up descriptor to be used for TR mode */
-	hwdesc = &rx_flush->hwdescs[0];
-	tr_size = sizeof(struct cppi5_tr_type1_t);
-	hwdesc->cppi5_desc_size = cppi5_trdesc_calc_size(tr_size, 1);
-	hwdesc->cppi5_desc_size = ALIGN(hwdesc->cppi5_desc_size,
-					ud->desc_align);
-
-	hwdesc->cppi5_desc_vaddr = devm_kzalloc(dev, hwdesc->cppi5_desc_size,
-						GFP_KERNEL);
-	if (!hwdesc->cppi5_desc_vaddr)
-		return -ENOMEM;
-
-	hwdesc->cppi5_desc_paddr = dma_map_single(dev, hwdesc->cppi5_desc_vaddr,
-						  hwdesc->cppi5_desc_size,
-						  DMA_TO_DEVICE);
-	if (dma_mapping_error(dev, hwdesc->cppi5_desc_paddr))
-		return -ENOMEM;
-
-	/* Start of the TR req records */
-	hwdesc->tr_req_base = hwdesc->cppi5_desc_vaddr + tr_size;
-	/* Start address of the TR response array */
-	hwdesc->tr_resp_base = hwdesc->tr_req_base + tr_size;
-
-	tr_desc = hwdesc->cppi5_desc_vaddr;
-	cppi5_trdesc_init(tr_desc, 1, tr_size, 0, 0);
-	cppi5_desc_set_pktids(tr_desc, 0, CPPI5_INFO1_DESC_FLOWID_DEFAULT);
-	cppi5_desc_set_retpolicy(tr_desc, 0, 0);
-
-	tr_req = hwdesc->tr_req_base;
-	cppi5_tr_init(&tr_req->flags, CPPI5_TR_TYPE1, false, false,
-		      CPPI5_TR_EVENT_SIZE_COMPLETION, 0);
-	cppi5_tr_csf_set(&tr_req->flags, CPPI5_TR_CSF_SUPR_EVT);
-
-	tr_req->addr = rx_flush->buffer_paddr;
-	tr_req->icnt0 = rx_flush->buffer_size;
-	tr_req->icnt1 = 1;
-
-	dma_sync_single_for_device(dev, hwdesc->cppi5_desc_paddr,
-				   hwdesc->cppi5_desc_size, DMA_TO_DEVICE);
-
-	/* Set up descriptor to be used for packet mode */
-	hwdesc = &rx_flush->hwdescs[1];
-	hwdesc->cppi5_desc_size = ALIGN(sizeof(struct cppi5_host_desc_t) +
-					CPPI5_INFO0_HDESC_EPIB_SIZE +
-					CPPI5_INFO0_HDESC_PSDATA_MAX_SIZE,
-					ud->desc_align);
-
-	hwdesc->cppi5_desc_vaddr = devm_kzalloc(dev, hwdesc->cppi5_desc_size,
-						GFP_KERNEL);
-	if (!hwdesc->cppi5_desc_vaddr)
-		return -ENOMEM;
-
-	hwdesc->cppi5_desc_paddr = dma_map_single(dev, hwdesc->cppi5_desc_vaddr,
-						  hwdesc->cppi5_desc_size,
-						  DMA_TO_DEVICE);
-	if (dma_mapping_error(dev, hwdesc->cppi5_desc_paddr))
-		return -ENOMEM;
-
-	desc = hwdesc->cppi5_desc_vaddr;
-	cppi5_hdesc_init(desc, 0, 0);
-	cppi5_desc_set_pktids(&desc->hdr, 0, CPPI5_INFO1_DESC_FLOWID_DEFAULT);
-	cppi5_desc_set_retpolicy(&desc->hdr, 0, 0);
-
-	cppi5_hdesc_attach_buf(desc,
-			       rx_flush->buffer_paddr, rx_flush->buffer_size,
-			       rx_flush->buffer_paddr, rx_flush->buffer_size);
-
-	dma_sync_single_for_device(dev, hwdesc->cppi5_desc_paddr,
-				   hwdesc->cppi5_desc_size, DMA_TO_DEVICE);
-	return 0;
-}
-
-#ifdef CONFIG_DEBUG_FS
-static void udma_dbg_summary_show_chan(struct seq_file *s,
-				       struct dma_chan *chan)
-{
-	struct udma_chan *uc = to_udma_chan(chan);
-	struct udma_chan_config *ucc = &uc->config;
-
-	seq_printf(s, " %-13s| %s", dma_chan_name(chan),
-		   chan->dbg_client_name ?: "in-use");
-	if (ucc->tr_trigger_type)
-		seq_puts(s, " (triggered, ");
-	else
-		seq_printf(s, " (%s, ",
-			   dmaengine_get_direction_text(uc->config.dir));
-
-	switch (uc->config.dir) {
-	case DMA_MEM_TO_MEM:
-		if (uc->ud->match_data->type == DMA_TYPE_BCDMA) {
-			seq_printf(s, "bchan%d)\n", uc->bchan->id);
-			return;
-		}
-
-		seq_printf(s, "chan%d pair [0x%04x -> 0x%04x], ", uc->tchan->id,
-			   ucc->src_thread, ucc->dst_thread);
-		break;
-	case DMA_DEV_TO_MEM:
-		seq_printf(s, "rchan%d [0x%04x -> 0x%04x], ", uc->rchan->id,
-			   ucc->src_thread, ucc->dst_thread);
-		if (uc->ud->match_data->type == DMA_TYPE_PKTDMA)
-			seq_printf(s, "rflow%d, ", uc->rflow->id);
-		break;
-	case DMA_MEM_TO_DEV:
-		seq_printf(s, "tchan%d [0x%04x -> 0x%04x], ", uc->tchan->id,
-			   ucc->src_thread, ucc->dst_thread);
-		if (uc->ud->match_data->type == DMA_TYPE_PKTDMA)
-			seq_printf(s, "tflow%d, ", uc->tchan->tflow_id);
-		break;
-	default:
-		seq_printf(s, ")\n");
-		return;
-	}
-
-	if (ucc->ep_type == PSIL_EP_NATIVE) {
-		seq_printf(s, "PSI-L Native");
-		if (ucc->metadata_size) {
-			seq_printf(s, "[%s", ucc->needs_epib ? " EPIB" : "");
-			if (ucc->psd_size)
-				seq_printf(s, " PSDsize:%u", ucc->psd_size);
-			seq_printf(s, " ]");
-		}
-	} else {
-		seq_printf(s, "PDMA");
-		if (ucc->enable_acc32 || ucc->enable_burst)
-			seq_printf(s, "[%s%s ]",
-				   ucc->enable_acc32 ? " ACC32" : "",
-				   ucc->enable_burst ? " BURST" : "");
-	}
-
-	seq_printf(s, ", %s)\n", ucc->pkt_mode ? "Packet mode" : "TR mode");
-}
-
-static void udma_dbg_summary_show(struct seq_file *s,
-				  struct dma_device *dma_dev)
-{
-	struct dma_chan *chan;
-
-	list_for_each_entry(chan, &dma_dev->channels, device_node) {
-		if (chan->client_count)
-			udma_dbg_summary_show_chan(s, chan);
-	}
-}
-#endif /* CONFIG_DEBUG_FS */
-
-static enum dmaengine_alignment udma_get_copy_align(struct udma_dev *ud)
-{
-	const struct udma_match_data *match_data = ud->match_data;
-	u8 tpl;
-
-	if (!match_data->enable_memcpy_support)
-		return DMAENGINE_ALIGN_8_BYTES;
-
-	/* Get the highest TPL level the device supports for memcpy */
-	if (ud->bchan_cnt)
-		tpl = udma_get_chan_tpl_index(&ud->bchan_tpl, 0);
-	else if (ud->tchan_cnt)
-		tpl = udma_get_chan_tpl_index(&ud->tchan_tpl, 0);
-	else
-		return DMAENGINE_ALIGN_8_BYTES;
-
-	switch (match_data->burst_size[tpl]) {
-	case TI_SCI_RM_UDMAP_CHAN_BURST_SIZE_256_BYTES:
-		return DMAENGINE_ALIGN_256_BYTES;
-	case TI_SCI_RM_UDMAP_CHAN_BURST_SIZE_128_BYTES:
-		return DMAENGINE_ALIGN_128_BYTES;
-	case TI_SCI_RM_UDMAP_CHAN_BURST_SIZE_64_BYTES:
-	fallthrough;
-	default:
-		return DMAENGINE_ALIGN_64_BYTES;
-	}
-}
-
 static int udma_probe(struct platform_device *pdev)
 {
 	struct device_node *navss_node = pdev->dev.parent->of_node;
diff --git a/drivers/dma/ti/k3-udma.h b/drivers/dma/ti/k3-udma.h
index 67425ed1273aa..ca3d7aebba13b 100644
--- a/drivers/dma/ti/k3-udma.h
+++ b/drivers/dma/ti/k3-udma.h
@@ -617,6 +617,37 @@ int udma_push_to_ring(struct udma_chan *uc, int idx);
 int udma_pop_from_ring(struct udma_chan *uc, dma_addr_t *addr);
 void udma_reset_rings(struct udma_chan *uc);
 
+int navss_psil_pair(struct udma_dev *ud, u32 src_thread, u32 dst_thread);
+int navss_psil_unpair(struct udma_dev *ud, u32 src_thread, u32 dst_thread);
+void udma_start_desc(struct udma_chan *uc);
+u8 udma_get_chan_tpl_index(struct udma_tpl *tpl_map, int chan_id);
+void k3_configure_chan_coherency(struct dma_chan *chan, u32 asel);
+void udma_reset_uchan(struct udma_chan *uc);
+void udma_dump_chan_stdata(struct udma_chan *uc);
+bool udma_is_chan_running(struct udma_chan *uc);
+
+bool udma_chan_needs_reconfiguration(struct udma_chan *uc);
+void udma_cyclic_packet_elapsed(struct udma_chan *uc);
+void udma_check_tx_completion(struct work_struct *work);
+int udma_slave_config(struct dma_chan *chan,
+		struct dma_slave_config *cfg);
+void udma_issue_pending(struct dma_chan *chan);
+int udma_terminate_all(struct dma_chan *chan);
+void udma_synchronize(struct dma_chan *chan);
+void udma_vchan_complete(struct tasklet_struct *t);
+void udma_mark_resource_ranges(struct udma_dev *ud, unsigned long *map,
+		struct ti_sci_resource_desc *rm_desc,
+		char *name);
+int udma_setup_rx_flush(struct udma_dev *ud);
+enum dmaengine_alignment udma_get_copy_align(struct udma_dev *ud);
+
+#ifdef CONFIG_DEBUG_FS
+void udma_dbg_summary_show_chan(struct seq_file *s,
+		struct dma_chan *chan);
+void udma_dbg_summary_show(struct seq_file *s,
+		struct dma_device *dma_dev);
+#endif /* CONFIG_DEBUG_FS */
+
 /* Direct access to UDMA low lever resources for the glue layer */
 int xudma_navss_psil_pair(struct udma_dev *ud, u32 src_thread, u32 dst_thread);
 int xudma_navss_psil_unpair(struct udma_dev *ud, u32 src_thread,
-- 
2.34.1


