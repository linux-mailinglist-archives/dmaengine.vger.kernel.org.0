Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D30902BFE5B
	for <lists+dmaengine@lfdr.de>; Mon, 23 Nov 2020 03:54:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727477AbgKWCvy (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Sun, 22 Nov 2020 21:51:54 -0500
Received: from mga18.intel.com ([134.134.136.126]:60192 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727383AbgKWCvx (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Sun, 22 Nov 2020 21:51:53 -0500
IronPort-SDR: pAjIVyH9n4eX6O8hFk2FJOiVsNrNDiNsslJWdCFomjBL+GhelS62d7r+7idG+PvxAIkYpS0sAN
 KTPPxYPXsR3A==
X-IronPort-AV: E=McAfee;i="6000,8403,9813"; a="159460001"
X-IronPort-AV: E=Sophos;i="5.78,361,1599548400"; 
   d="scan'208";a="159460001"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Nov 2020 18:51:53 -0800
IronPort-SDR: lo3bdf73+EIgtwpyHg4kjtmTwAGihoW/4IErxUXIa45E+X7N4gUmy45gLAjqLNpR0Hz/O/2zAJ
 CcN6XaKXDo+g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.78,361,1599548400"; 
   d="scan'208";a="369879865"
Received: from jsia-hp-z620-workstation.png.intel.com ([10.221.118.135])
  by FMSMGA003.fm.intel.com with ESMTP; 22 Nov 2020 18:51:51 -0800
From:   Sia Jee Heng <jee.heng.sia@intel.com>
To:     vkoul@kernel.org, Eugeniy.Paltsev@synopsys.com, robh+dt@kernel.org
Cc:     andriy.shevchenko@linux.intel.com, dmaengine@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: [PATCH v5 07/16] dmaegine: dw-axi-dmac: Support device_prep_dma_cyclic()
Date:   Mon, 23 Nov 2020 10:34:43 +0800
Message-Id: <20201123023452.7894-8-jee.heng.sia@intel.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20201123023452.7894-1-jee.heng.sia@intel.com>
References: <20201123023452.7894-1-jee.heng.sia@intel.com>
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Add support for device_prep_dma_cyclic() callback function to benefit
DMA cyclic client, for example ALSA.

Existing AxiDMA driver only support data transfer between memory to memory.
Data transfer between device to memory and memory to device in cyclic mode
would failed if this interface is not supported by the AxiDMA driver.

Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: Sia Jee Heng <jee.heng.sia@intel.com>
---
 .../dma/dw-axi-dmac/dw-axi-dmac-platform.c    | 111 ++++++++++++++++--
 drivers/dma/dw-axi-dmac/dw-axi-dmac.h         |   2 +
 2 files changed, 106 insertions(+), 7 deletions(-)

diff --git a/drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c b/drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c
index 1674dcb6fc5b..b5f92f9cb2bc 100644
--- a/drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c
+++ b/drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c
@@ -15,6 +15,8 @@
 #include <linux/err.h>
 #include <linux/interrupt.h>
 #include <linux/io.h>
+#include <linux/iopoll.h>
+#include <linux/io-64-nonatomic-lo-hi.h>
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/of.h>
@@ -549,6 +551,64 @@ static int dw_axi_dma_set_hw_desc(struct axi_dma_chan *chan,
 	return 0;
 }
 
+static struct dma_async_tx_descriptor *
+dw_axi_dma_chan_prep_cyclic(struct dma_chan *dchan, dma_addr_t dma_addr,
+			    size_t buf_len, size_t period_len,
+			    enum dma_transfer_direction direction,
+			    unsigned long flags)
+{
+	struct axi_dma_chan *chan = dchan_to_axi_dma_chan(dchan);
+	struct axi_dma_hw_desc *hw_desc = NULL;
+	struct axi_dma_desc *desc = NULL;
+	dma_addr_t src_addr = dma_addr;
+	u32 num_periods = buf_len / period_len;
+	unsigned int i;
+	int status;
+	u64 llp = 0;
+	u8 lms = 0; /* Select AXI0 master for LLI fetching */
+
+	desc = axi_desc_alloc(num_periods);
+	if (unlikely(!desc))
+		goto err_desc_get;
+
+	chan->direction = direction;
+	desc->chan = chan;
+	chan->cyclic = true;
+
+	for (i = 0; i < num_periods; i++) {
+		hw_desc = &desc->hw_desc[i];
+
+		status = dw_axi_dma_set_hw_desc(chan, hw_desc, src_addr,
+						period_len);
+		if (status < 0)
+			goto err_desc_get;
+
+		/* Set end-of-link to the linked descriptor, so that cyclic
+		 * callback function can be triggered during interrupt.
+		 */
+		set_desc_last(hw_desc);
+
+		src_addr += period_len;
+	}
+
+	llp = desc->hw_desc[0].llp;
+
+	/* Managed transfer list */
+	do {
+		hw_desc = &desc->hw_desc[--num_periods];
+		write_desc_llp(hw_desc, llp | lms);
+		llp = hw_desc->llp;
+	} while (num_periods);
+
+	return vchan_tx_prep(&chan->vc, &desc->vd, flags);
+
+err_desc_get:
+	if (desc)
+		axi_desc_put(desc);
+
+	return NULL;
+}
+
 static struct dma_async_tx_descriptor *
 dw_axi_dma_chan_prep_slave_sg(struct dma_chan *dchan, struct scatterlist *sgl,
 			      unsigned int sg_len,
@@ -773,8 +833,13 @@ static noinline void axi_chan_handle_err(struct axi_dma_chan *chan, u32 status)
 
 static void axi_chan_block_xfer_complete(struct axi_dma_chan *chan)
 {
+	int count = atomic_read(&chan->descs_allocated);
+	struct axi_dma_hw_desc *hw_desc;
+	struct axi_dma_desc *desc;
 	struct virt_dma_desc *vd;
 	unsigned long flags;
+	u64 llp;
+	int i;
 
 	spin_lock_irqsave(&chan->vc.lock, flags);
 	if (unlikely(axi_chan_is_hw_enable(chan))) {
@@ -785,12 +850,32 @@ static void axi_chan_block_xfer_complete(struct axi_dma_chan *chan)
 
 	/* The completed descriptor currently is in the head of vc list */
 	vd = vchan_next_desc(&chan->vc);
-	/* Remove the completed descriptor from issued list before completing */
-	list_del(&vd->node);
-	vchan_cookie_complete(vd);
 
-	/* Submit queued descriptors after processing the completed ones */
-	axi_chan_start_first_queued(chan);
+	if (chan->cyclic) {
+		vchan_cyclic_callback(vd);
+		desc = vd_to_axi_desc(vd);
+		if (desc) {
+			llp = lo_hi_readq(chan->chan_regs + CH_LLP);
+			for (i = 0; i < count; i++) {
+				hw_desc = &desc->hw_desc[i];
+				if (hw_desc->llp == llp) {
+					axi_chan_irq_clear(chan, hw_desc->lli->status_lo);
+					hw_desc->lli->ctl_hi |= CH_CTL_H_LLI_VALID;
+					desc->completed_blocks = i;
+					break;
+				}
+			}
+
+			axi_chan_enable(chan);
+		}
+	} else {
+		/* Remove the completed descriptor from issued list before completing */
+		list_del(&vd->node);
+		vchan_cookie_complete(vd);
+
+		/* Submit queued descriptors after processing the completed ones */
+		axi_chan_start_first_queued(chan);
+	}
 
 	spin_unlock_irqrestore(&chan->vc.lock, flags);
 }
@@ -830,15 +915,25 @@ static irqreturn_t dw_axi_dma_interrupt(int irq, void *dev_id)
 static int dma_chan_terminate_all(struct dma_chan *dchan)
 {
 	struct axi_dma_chan *chan = dchan_to_axi_dma_chan(dchan);
+	u32 chan_active = BIT(chan->id) << DMAC_CHAN_EN_SHIFT;
 	unsigned long flags;
+	u32 val;
+	int ret;
 	LIST_HEAD(head);
 
-	spin_lock_irqsave(&chan->vc.lock, flags);
-
 	axi_chan_disable(chan);
 
+	ret = readl_poll_timeout_atomic(chan->chip->regs + DMAC_CHEN, val,
+					!(val & chan_active), 1000, 10000);
+	if (ret == -ETIMEDOUT)
+		dev_warn(dchan2dev(dchan),
+			 "%s failed to stop\n", axi_chan_name(chan));
+
+	spin_lock_irqsave(&chan->vc.lock, flags);
+
 	vchan_get_all_descriptors(&chan->vc, &head);
 
+	chan->cyclic = false;
 	spin_unlock_irqrestore(&chan->vc.lock, flags);
 
 	vchan_dma_desc_free_list(&chan->vc, &head);
@@ -1090,6 +1185,7 @@ static int dw_probe(struct platform_device *pdev)
 	/* Set capabilities */
 	dma_cap_set(DMA_MEMCPY, dw->dma.cap_mask);
 	dma_cap_set(DMA_SLAVE, dw->dma.cap_mask);
+	dma_cap_set(DMA_CYCLIC, dw->dma.cap_mask);
 
 	/* DMA capabilities */
 	dw->dma.chancnt = hdata->nr_channels;
@@ -1113,6 +1209,7 @@ static int dw_probe(struct platform_device *pdev)
 	dw->dma.device_synchronize = dw_axi_dma_synchronize;
 	dw->dma.device_config = dw_axi_dma_chan_slave_config;
 	dw->dma.device_prep_slave_sg = dw_axi_dma_chan_prep_slave_sg;
+	dw->dma.device_prep_dma_cyclic = dw_axi_dma_chan_prep_cyclic;
 
 	platform_set_drvdata(pdev, chip);
 
diff --git a/drivers/dma/dw-axi-dmac/dw-axi-dmac.h b/drivers/dma/dw-axi-dmac/dw-axi-dmac.h
index ac49f2e14b0c..a26b0a242a93 100644
--- a/drivers/dma/dw-axi-dmac/dw-axi-dmac.h
+++ b/drivers/dma/dw-axi-dmac/dw-axi-dmac.h
@@ -45,6 +45,7 @@ struct axi_dma_chan {
 	struct axi_dma_desc		*desc;
 	struct dma_slave_config		config;
 	enum dma_transfer_direction	direction;
+	bool				cyclic;
 	/* these other elements are all protected by vc.lock */
 	bool				is_paused;
 };
@@ -93,6 +94,7 @@ struct axi_dma_desc {
 
 	struct virt_dma_desc		vd;
 	struct axi_dma_chan		*chan;
+	u32				completed_blocks;
 };
 
 static inline struct device *dchan2dev(struct dma_chan *dchan)
-- 
2.18.0

