Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4076D28AD20
	for <lists+dmaengine@lfdr.de>; Mon, 12 Oct 2020 06:39:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725941AbgJLEjM (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 12 Oct 2020 00:39:12 -0400
Received: from mga14.intel.com ([192.55.52.115]:21612 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726556AbgJLEjL (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Mon, 12 Oct 2020 00:39:11 -0400
IronPort-SDR: s+4JGdrARrkcqSo2QIDSe2SBDiYbOyDkYBBiC8m+bZFByWIFqzqgKDg+kwYvKdny2lzNO951e5
 pP82nSDOhw2Q==
X-IronPort-AV: E=McAfee;i="6000,8403,9771"; a="164903172"
X-IronPort-AV: E=Sophos;i="5.77,365,1596524400"; 
   d="scan'208";a="164903172"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Oct 2020 21:39:11 -0700
IronPort-SDR: dUMdH3y670GM/PLXAakLkAo0WxvCoDlZ6B8lvMiAoYathS4DsQOLYk4Y8FZWHUz2+0JEoQKKEx
 yQTdOBpESHnA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,365,1596524400"; 
   d="scan'208";a="313321298"
Received: from unknown (HELO jsia-HP-Z620-Workstation.png.intel.com) ([10.221.118.135])
  by orsmga003.jf.intel.com with ESMTP; 11 Oct 2020 21:39:09 -0700
From:   Sia Jee Heng <jee.heng.sia@intel.com>
To:     vkoul@kernel.org, Eugeniy.Paltsev@synopsys.com
Cc:     andriy.shevchenko@linux.intel.com, dmaengine@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 07/15] dmaegine: dw-axi-dmac: Support device_prep_dma_cyclic()
Date:   Mon, 12 Oct 2020 12:21:52 +0800
Message-Id: <20201012042200.29787-8-jee.heng.sia@intel.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20201012042200.29787-1-jee.heng.sia@intel.com>
References: <20201012042200.29787-1-jee.heng.sia@intel.com>
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
 .../dma/dw-axi-dmac/dw-axi-dmac-platform.c    | 182 +++++++++++++++++-
 drivers/dma/dw-axi-dmac/dw-axi-dmac.h         |   2 +
 2 files changed, 177 insertions(+), 7 deletions(-)

diff --git a/drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c b/drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c
index 1124c97025f2..9e574753aaf0 100644
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
@@ -575,6 +577,135 @@ dma_chan_prep_dma_memcpy(struct dma_chan *dchan, dma_addr_t dst_adr,
 	return NULL;
 }
 
+static struct dma_async_tx_descriptor *
+dw_axi_dma_chan_prep_cyclic(struct dma_chan *dchan, dma_addr_t dma_addr,
+			    size_t buf_len, size_t period_len,
+			    enum dma_transfer_direction direction,
+			    unsigned long flags)
+{
+	struct axi_dma_chan *chan = dchan_to_axi_dma_chan(dchan);
+	u32 data_width = BIT(chan->chip->dw->hdata->m_data_width);
+	struct axi_dma_hw_desc *hw_desc = NULL;
+	struct axi_dma_desc *desc = NULL;
+	dma_addr_t src_addr = dma_addr;
+	u32 num_periods = buf_len / period_len;
+	unsigned int reg_width;
+	unsigned int mem_width;
+	dma_addr_t reg;
+	unsigned int i;
+	u32 ctllo, ctlhi;
+	size_t block_ts;
+	u64 llp = 0;
+	u8 lms = 0; /* Select AXI0 master for LLI fetching */
+
+	block_ts = chan->chip->dw->hdata->block_size[chan->id];
+
+	mem_width = __ffs(data_width | dma_addr | period_len);
+	if (mem_width > DWAXIDMAC_TRANS_WIDTH_32)
+		mem_width = DWAXIDMAC_TRANS_WIDTH_32;
+
+	desc = axi_desc_alloc(num_periods);
+	if (unlikely(!desc))
+		goto err_desc_get;
+
+	chan->direction = direction;
+	desc->chan = chan;
+	chan->cyclic = true;
+
+	switch (direction) {
+	case DMA_MEM_TO_DEV:
+		reg_width = __ffs(chan->config.dst_addr_width);
+		reg = chan->config.dst_addr;
+		ctllo = reg_width << CH_CTL_L_DST_WIDTH_POS |
+			DWAXIDMAC_CH_CTL_L_NOINC << CH_CTL_L_DST_INC_POS |
+			DWAXIDMAC_CH_CTL_L_INC << CH_CTL_L_SRC_INC_POS;
+		break;
+	case DMA_DEV_TO_MEM:
+		reg_width = __ffs(chan->config.src_addr_width);
+		reg = chan->config.src_addr;
+		ctllo = reg_width << CH_CTL_L_SRC_WIDTH_POS |
+			DWAXIDMAC_CH_CTL_L_INC << CH_CTL_L_DST_INC_POS |
+			DWAXIDMAC_CH_CTL_L_NOINC << CH_CTL_L_SRC_INC_POS;
+		break;
+	default:
+		return NULL;
+	}
+
+	for (i = 0; i < num_periods; i++) {
+		hw_desc = &desc->hw_desc[i];
+
+		hw_desc->lli = axi_desc_get(chan, &hw_desc->llp);
+		if (unlikely(!hw_desc->lli))
+			goto err_desc_get;
+
+		if (direction == DMA_MEM_TO_DEV)
+			block_ts = period_len >> mem_width;
+		else
+			block_ts = period_len >> reg_width;
+
+		ctlhi = CH_CTL_H_LLI_VALID;
+		if (chan->chip->dw->hdata->restrict_axi_burst_len) {
+			u32 burst_len = chan->chip->dw->hdata->axi_rw_burst_len;
+
+			ctlhi |= (CH_CTL_H_ARLEN_EN |
+				burst_len << CH_CTL_H_ARLEN_POS |
+				CH_CTL_H_AWLEN_EN |
+				burst_len << CH_CTL_H_AWLEN_POS);
+		}
+
+		hw_desc->lli->ctl_hi = cpu_to_le32(ctlhi);
+
+		if (direction == DMA_MEM_TO_DEV)
+			ctllo |= mem_width << CH_CTL_L_SRC_WIDTH_POS;
+		else
+			ctllo |= mem_width << CH_CTL_L_DST_WIDTH_POS;
+
+		if (direction == DMA_MEM_TO_DEV) {
+			write_desc_sar(hw_desc, src_addr);
+			write_desc_dar(hw_desc, reg);
+		} else {
+			write_desc_sar(hw_desc, reg);
+			write_desc_dar(hw_desc, src_addr);
+		}
+
+		hw_desc->lli->block_ts_lo = cpu_to_le32(block_ts - 1);
+
+		ctllo |= (DWAXIDMAC_BURST_TRANS_LEN_4 << CH_CTL_L_DST_MSIZE_POS |
+			  DWAXIDMAC_BURST_TRANS_LEN_4 << CH_CTL_L_SRC_MSIZE_POS);
+		hw_desc->lli->ctl_lo = cpu_to_le32(ctllo);
+
+		set_desc_src_master(hw_desc);
+
+		/*
+		 * Set end-of-link to the linked descriptor, so that cyclic
+		 * callback function can be triggered during interrupt.
+		 */
+		set_desc_last(hw_desc);
+
+		src_addr += period_len;
+	}
+
+	if (unlikely(!desc))
+		return NULL;
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
@@ -761,8 +892,13 @@ static noinline void axi_chan_handle_err(struct axi_dma_chan *chan, u32 status)
 
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
@@ -773,12 +909,32 @@ static void axi_chan_block_xfer_complete(struct axi_dma_chan *chan)
 
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
@@ -818,15 +974,25 @@ static irqreturn_t dw_axi_dma_interrupt(int irq, void *dev_id)
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
@@ -1078,6 +1244,7 @@ static int dw_probe(struct platform_device *pdev)
 	/* Set capabilities */
 	dma_cap_set(DMA_MEMCPY, dw->dma.cap_mask);
 	dma_cap_set(DMA_SLAVE, dw->dma.cap_mask);
+	dma_cap_set(DMA_CYCLIC, dw->dma.cap_mask);
 
 	/* DMA capabilities */
 	dw->dma.chancnt = hdata->nr_channels;
@@ -1101,6 +1268,7 @@ static int dw_probe(struct platform_device *pdev)
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

