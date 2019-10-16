Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 853EDD8F46
	for <lists+dmaengine@lfdr.de>; Wed, 16 Oct 2019 13:22:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392730AbfJPLWB (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 16 Oct 2019 07:22:01 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:39216 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728406AbfJPLWB (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 16 Oct 2019 07:22:01 -0400
Received: by mail-wm1-f68.google.com with SMTP id v17so2328687wml.4;
        Wed, 16 Oct 2019 04:21:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=zRhxdHmjKbNFV4Dp6FPLprlBrJ5tAZb6lOIf6RTPo2M=;
        b=Wdvl5OKJ2Nxj91i0pqCFuMQKWWHQjcv0Wnak/SUXv29thBPItcupnVHQpCxMTPoKZm
         wePGB1nQkzukxgV94u1IV0EqOcPM2OmsEvWdKvHI3bqGzoSfdJ9sXMc5wn6J4yDTnC6v
         60QmBMLnGoUzw9KypD+VHUh87THw9y/6Q+620N04YwEeb2UYpzCVfKBSeqaSwgvMXys/
         TE2lLoxpNUXmdbsBgXdQK8AzNfJplDKEryCbHZZsCYgCDxhljfHT53dmccjs/PE3xR3B
         wOfdtl9Yh3MAPZXeswueXTK2pJCori8WCZWpzC9CbNezOt3fEmm/9magXqtlBDp0Oqbq
         MYrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=zRhxdHmjKbNFV4Dp6FPLprlBrJ5tAZb6lOIf6RTPo2M=;
        b=I6ZTWjX8T2AFQgPSqP6lvPKD4dKRaq/KMnSEjQNpTcSoNdY07fc+o7a9jDWmkKPmol
         f1FEATcYVl0S8lmb/BLRIbyA0D67eUiKgbnfEcn6ePAinn9bXlUxodQOPNewcv5FTOlE
         +7RzrMNcrWg76P/HA0y5Ofeyz8N5RnSEUTd1DZlCMQ1dQRM7SxCJ1MNjqAfCF6oQLHDp
         Qf+aMJcPaeahWIf7qnCrgRXMqjijXYOjZaoExENakwPZAS8SbE8rKwLAj/dBij92TNXd
         RDdWkj+TjGT/USoBQasvkjYnyx63MmLN1Ul1U/CN++9cjTAKajPnGMYPG8XWXyt9Q7K1
         HWrA==
X-Gm-Message-State: APjAAAXLlic5iSS3zuKiD1amRZ7qOV6BI0SUPhRh7ldbsDSiW1WxTPUx
        grjudCmUCvhdAj3g/M7GRjtJA7ZR
X-Google-Smtp-Source: APXvYqw+ztdzMngBaKotoRdO5YFsMG5ZDpUSa6HuEjAoSVefx3kWTvhvWyJQf4Ibzf0iOHO7DpYV0w==
X-Received: by 2002:a05:600c:143:: with SMTP id w3mr2800938wmm.35.1571224916382;
        Wed, 16 Oct 2019 04:21:56 -0700 (PDT)
Received: from localhost.localdomain ([213.86.25.14])
        by smtp.googlemail.com with ESMTPSA id 33sm42571968wra.41.2019.10.16.04.21.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Oct 2019 04:21:55 -0700 (PDT)
From:   Alexander Gordeev <a.gordeev.box@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Alexander Gordeev <a.gordeev.box@gmail.com>,
        dmaengine@vger.kernel.org
Subject: [PATCH v3 0/1] dmaengine: avalon: Intel Avalon-MM DMA Interface for PCIe
Date:   Wed, 16 Oct 2019 13:21:52 +0200
Message-Id: <cover.1571224166.git.a.gordeev.box@gmail.com>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

This series is against v5.4-rc3

I am posting "avalon-dma" update alone and going to post "avalon-test"
update as a follow-up or in the next round.

Changes since v2:
- avalon_dma_register() return value bug fixed;
- device_prep_slave_sg() does not crash dmaengine_prep_slave_single() now;
- kernel configuration options removed in favour of module parameters;
- BUG_ONs, WARN_ONs and dev_dbgs removed;
- goto labels renamed, other style issues addressed;
- polling loop in interrupt handler commented;

Changes since v1:
- "avalon-dma" converted to "dmaengine" model;
- "avalon-drv" renamed to "avalon-test";

The Avalon-MM DMA Interface for PCIe is a design used in hard IPs for
Intel Arria, Cyclone or Stratix FPGAs. It transfers data between on-chip
memory and system memory.

Testing was done using a custom FPGA build with Arria 10 FPGA streaming
data to target device RAM:

  +----------+    +----------+    +----------+        +----------+
  | Nios CPU |<-->|   RAM    |<-->|  Avalon  |<-PCIe->| Host CPU |
  +----------+    +----------+    +----------+        +----------+

The RAM was examined for data integrity by examining RAM contents
from host CPU (indirectly - checking data DMAed to the system) and
from Nios CPU that has direct access to the device RAM. A companion
tool using "avalon-test" driver was used to DMA files to the device:
https://github.com/a-gordeev/avalon-tool.git

CC: dmaengine@vger.kernel.org

Alexander Gordeev (1):
  dmaengine: avalon: Intel Avalon-MM DMA Interface for PCIe

 drivers/dma/Kconfig              |   2 +
 drivers/dma/Makefile             |   1 +
 drivers/dma/avalon/Kconfig       |  14 +
 drivers/dma/avalon/Makefile      |   6 +
 drivers/dma/avalon/avalon-core.c | 476 +++++++++++++++++++++++++++++++
 drivers/dma/avalon/avalon-core.h |  92 ++++++
 drivers/dma/avalon/avalon-hw.c   | 186 ++++++++++++
 drivers/dma/avalon/avalon-hw.h   |  85 ++++++
 drivers/dma/avalon/avalon-pci.c  | 144 ++++++++++
 9 files changed, 1006 insertions(+)
 create mode 100644 drivers/dma/avalon/Kconfig
 create mode 100644 drivers/dma/avalon/Makefile
 create mode 100644 drivers/dma/avalon/avalon-core.c
 create mode 100644 drivers/dma/avalon/avalon-core.h
 create mode 100644 drivers/dma/avalon/avalon-hw.c
 create mode 100644 drivers/dma/avalon/avalon-hw.h
 create mode 100644 drivers/dma/avalon/avalon-pci.c

Because the amount of changes since the previous version is quite big,
I am also posting the interdiff.

diff -u b/drivers/dma/avalon/Kconfig b/drivers/dma/avalon/Kconfig
--- b/drivers/dma/avalon/Kconfig
+++ b/drivers/dma/avalon/Kconfig
@@ -15,74 +14,0 @@
-
-if AVALON_DMA
-
-config AVALON_DMA_MASK_WIDTH
-	int "Avalon DMA streaming and coherent bitmask width"
-	range 0 64
-	default 64
-	help
-	  Width of bitmask for streaming and coherent DMA operations
-
-config AVALON_DMA_CTRL_BASE
-	hex "Avalon DMA controllers base"
-	default "0x00000000"
-
-config AVALON_DMA_RD_EP_DST_LO
-	hex "Avalon DMA read controller base low"
-	default "0x80000000"
-	help
-	  Specifies the lower 32-bits of the base address of the read
-	  status and descriptor table in the Root Complex memory.
-
-config AVALON_DMA_RD_EP_DST_HI
-	hex "Avalon DMA read controller base high"
-	default "0x00000000"
-	help
-	  Specifies the upper 32-bits of the base address of the read
-	  status and descriptor table in the Root Complex memory.
-
-config AVALON_DMA_WR_EP_DST_LO
-	hex "Avalon DMA write controller base low"
-	default "0x80002000"
-	help
-	  Specifies the lower 32-bits of the base address of the write
-	  status and descriptor table in the Root Complex memory.
-
-config AVALON_DMA_WR_EP_DST_HI
-	hex "Avalon DMA write controller base high"
-	default "0x00000000"
-	help
-	  Specifies the upper 32-bits of the base address of the write
-	  status and descriptor table in the Root Complex memory.
-
-config AVALON_DMA_PCI_VENDOR_ID
-	hex "PCI vendor ID"
-	default "0x1172"
-
-config AVALON_DMA_PCI_DEVICE_ID
-	hex "PCI device ID"
-	default "0xe003"
-
-config AVALON_DMA_PCI_BAR
-	int "PCI device BAR the Avalon DMA controller is mapped to"
-	range 0 5
-	default 0
-	help
-	  Number of PCI BAR the DMA controller is mapped to
-
-config AVALON_DMA_PCI_MSI_COUNT_ORDER
-	int "Count of MSIs the PCI device provides (order)"
-	range 0 5
-	default 5
-	help
-	  Number of vectors the PCI device uses in multiple MSI mode.
-	  This number is provided as the power of two.
-
-config AVALON_DMA_PCI_MSI_VECTOR
-	int "Vector number the DMA controller is mapped to"
-	range 0 31
-	default 0
-	help
-	  Number of MSI vector the DMA controller is mapped to in
-	  multiple MSI mode.
-
-endif
diff -u b/drivers/dma/avalon/avalon-core.c b/drivers/dma/avalon/avalon-core.c
--- b/drivers/dma/avalon/avalon-core.c
+++ b/drivers/dma/avalon/avalon-core.c
@@ -13,29 +13,56 @@
 #include "avalon-core.h"
 
 #define INTERRUPT_NAME		"avalon_dma"
-#define DMA_MASK_WIDTH		CONFIG_AVALON_DMA_MASK_WIDTH
+
+static unsigned int dma_mask_width = 64;
+module_param(dma_mask_width, uint, 0644);
+MODULE_PARM_DESC(dma_mask_width, "Avalon DMA bitmask width (default: 64)");
+
+unsigned long ctrl_base;
+module_param(ctrl_base, ulong, 0644);
+MODULE_PARM_DESC(ctrl_base, "Avalon DMA controller base (default: 0)");
+
+static unsigned int rd_ep_dst_lo = 0x80000000;
+module_param(rd_ep_dst_lo, uint, 0644);
+MODULE_PARM_DESC(rd_ep_dst_lo,
+		 "Read status and desc table low (default: 0x80000000)");
+
+static unsigned int rd_ep_dst_hi = 0;
+module_param(rd_ep_dst_hi, uint, 0644);
+MODULE_PARM_DESC(rd_ep_dst_hi,
+		 "Read status and desc table hi (default: 0)");
+
+static unsigned int wr_ep_dst_lo = 0x80002000;
+module_param(wr_ep_dst_lo, uint, 0644);
+MODULE_PARM_DESC(wr_ep_dst_lo,
+		 "Write status and desc table low (default: 0x80002000)");
+
+static unsigned int wr_ep_dst_hi = 0;
+module_param(wr_ep_dst_hi, uint, 0644);
+MODULE_PARM_DESC(wr_ep_dst_hi,
+		 "Write status and desc table hi (default: 0)");
 
 static int setup_dma_descs(struct dma_desc *dma_descs,
 			   struct avalon_dma_desc *desc)
 {
-	struct scatterlist *sg_stop;
-	unsigned int sg_set;
+	unsigned int seg_stop;
+	unsigned int seg_set;
 	int ret;
 
 	ret = setup_descs_sg(dma_descs, 0,
 			     desc->direction,
 			     desc->dev_addr,
-			     desc->sg, desc->sg_len,
-			     desc->sg_curr, desc->sg_offset,
-			     &sg_stop, &sg_set);
-	BUG_ON(!ret);
-	if (ret > 0) {
-		if (sg_stop == desc->sg_curr) {
-			desc->sg_offset += sg_set;
-		} else {
-			desc->sg_curr = sg_stop;
-			desc->sg_offset = sg_set;
-		}
+			     desc->seg, desc->nr_segs,
+			     desc->seg_curr, desc->seg_off,
+			     &seg_stop, &seg_set);
+	if (ret < 0)
+		return ret;
+
+	if (seg_stop == desc->seg_curr) {
+		desc->seg_off += seg_set;
+	} else {
+		desc->seg_curr = seg_stop;
+		desc->seg_off = seg_set;
 	}
 
 	return ret;
@@ -57,8 +84,8 @@
 
 		ctrl_off = AVALON_DMA_RD_CTRL_OFFSET;
 
-		ep_dst_hi = AVALON_DMA_RD_EP_DST_HI;
-		ep_dst_lo = AVALON_DMA_RD_EP_DST_LO;
+		ep_dst_hi = rd_ep_dst_hi;
+		ep_dst_lo = rd_ep_dst_lo;
 
 		__last_id = &hw->h2d_last_id;
 	} else if (desc->direction == DMA_FROM_DEVICE) {
@@ -66,19 +93,19 @@
 
 		ctrl_off = AVALON_DMA_WR_CTRL_OFFSET;
 
-		ep_dst_hi = AVALON_DMA_WR_EP_DST_HI;
-		ep_dst_lo = AVALON_DMA_WR_EP_DST_LO;
+		ep_dst_hi = wr_ep_dst_hi;
+		ep_dst_lo = wr_ep_dst_lo;
 
 		__last_id = &hw->d2h_last_id;
 	} else {
-		BUG();
+		return -EINVAL;
 	}
 
 	table = __table->cpu_addr;
 	memset(&table->flags, 0, sizeof(table->flags));
 
 	nr_descs = setup_dma_descs(table->descs, desc);
-	if (WARN_ON(nr_descs < 1))
+	if (nr_descs < 0)
 		return nr_descs;
 
 	last_id = nr_descs - 1;
@@ -97,14 +124,10 @@
 
 static bool is_desc_complete(struct avalon_dma_desc *desc)
 {
-	struct scatterlist *sg_curr = desc->sg_curr;
-	unsigned int sg_len = sg_dma_len(sg_curr);
-
-	if (!sg_is_last(sg_curr))
+	if (desc->seg_curr < (desc->nr_segs - 1))
 		return false;
 
-	BUG_ON(desc->sg_offset > sg_len);
-	if (desc->sg_offset < sg_len)
+	if (desc->seg_off < desc->seg[desc->seg_curr].dma_len)
 		return false;
 
 	return true;
@@ -115,7 +138,6 @@
 	struct avalon_dma *adma = (struct avalon_dma *)dev_id;
 	struct avalon_dma_chan *chan = &adma->chan;
 	struct avalon_dma_hw *hw = &chan->hw;
-	spinlock_t *lock = &chan->vchan.lock;
 	u32 *rd_flags = hw->dma_desc_table_rd.cpu_addr->flags;
 	u32 *wr_flags = hw->dma_desc_table_wr.cpu_addr->flags;
 	struct avalon_dma_desc *desc;
@@ -123,28 +145,40 @@
 	bool rd_done;
 	bool wr_done;
 
-	spin_lock(lock);
+	spin_lock(&chan->vchan.lock);
 
 	rd_done = (hw->h2d_last_id < 0);
 	wr_done = (hw->d2h_last_id < 0);
 
 	if (rd_done && wr_done) {
-		spin_unlock(lock);
+		spin_unlock(&chan->vchan.lock);
 		return IRQ_NONE;
 	}
 
+	/*
+	 * The Intel documentation claims "The Descriptor Controller
+	 * writes a 1 to the done bit of the status DWORD to indicate
+	 * successful completion. The Descriptor Controller also sends
+	 * an MSI interrupt for the final descriptor. After receiving
+	 * this MSI, host software can poll the done bit to determine
+	 * status."
+	 *
+	 * The above could be read like MSI interrupt might be delivered
+	 * before the corresponding done bit is set. But in reality it
+	 * does not happen at all (or happens really rare). So put here
+	 * the done bit polling, just in case.
+	 */
 	do {
 		if (!rd_done && rd_flags[hw->h2d_last_id])
 			rd_done = true;
-
 		if (!wr_done && wr_flags[hw->d2h_last_id])
 			wr_done = true;
+		cpu_relax();
 	} while (!rd_done || !wr_done);
 
 	hw->h2d_last_id = -1;
 	hw->d2h_last_id = -1;
 
-	BUG_ON(!chan->active_desc);
 	desc = chan->active_desc;
 
 	if (is_desc_complete(desc)) {
@@ -162,12 +196,10 @@
 		}
 	}
 
-	if (chan->active_desc) {
-		BUG_ON(desc != chan->active_desc);
+	if (chan->active_desc)
 		start_dma_xfer(hw, desc);
-	}
 
-	spin_unlock(lock);
+	spin_unlock(&chan->vchan.lock);
 
 	return IRQ_HANDLED;
 }
@@ -206,19 +238,17 @@
 	hw->h2d_last_id		= -1;
 	hw->d2h_last_id		= -1;
 
-	ret = dma_set_mask_and_coherent(dev, DMA_BIT_MASK(DMA_MASK_WIDTH));
+	ret = dma_set_mask_and_coherent(dev, DMA_BIT_MASK(dma_mask_width));
 	if (ret)
-		goto dma_set_mask_err;
+		return ret;
 
 	hw->dma_desc_table_rd.cpu_addr = dma_alloc_coherent(
 		dev,
 		sizeof(struct dma_desc_table),
 		&hw->dma_desc_table_rd.dma_addr,
 		GFP_KERNEL);
-	if (!hw->dma_desc_table_rd.cpu_addr) {
-		ret = -ENOMEM;
-		goto alloc_rd_dma_table_err;
-	}
+	if (!hw->dma_desc_table_rd.cpu_addr)
+		return -ENOMEM;
 
 	hw->dma_desc_table_wr.cpu_addr = dma_alloc_coherent(
 		dev,
@@ -227,32 +257,30 @@
 		GFP_KERNEL);
 	if (!hw->dma_desc_table_wr.cpu_addr) {
 		ret = -ENOMEM;
-		goto alloc_wr_dma_table_err;
+		goto free_table_rd;
 	}
 
 	ret = request_irq(irq, avalon_dma_interrupt, IRQF_SHARED,
 			  INTERRUPT_NAME, adma);
 	if (ret)
-		goto req_irq_err;
+		goto free_table_wr;
 
 	return 0;
 
-req_irq_err:
+free_table_wr:
 	dma_free_coherent(
 		dev,
 		sizeof(struct dma_desc_table),
 		hw->dma_desc_table_wr.cpu_addr,
 		hw->dma_desc_table_wr.dma_addr);
 
-alloc_wr_dma_table_err:
+free_table_rd:
 	dma_free_coherent(
 		dev,
 		sizeof(struct dma_desc_table),
 		hw->dma_desc_table_rd.cpu_addr,
 		hw->dma_desc_table_rd.dma_addr);
 
-alloc_rd_dma_table_err:
-dma_set_mask_err:
 	return ret;
 }
 
@@ -262,7 +290,7 @@
 	struct avalon_dma_hw *hw = &chan->hw;
 	struct device *dev = adma->dev;
 
-	free_irq(adma->irq, (void *)adma);
+	free_irq(adma->irq, adma);
 
 	dma_free_coherent(
 		dev,
@@ -282,6 +310,10 @@
 {
 	struct avalon_dma_chan *chan = to_avalon_dma_chan(dma_chan);
 
+	if (!IS_ALIGNED(config->src_addr, sizeof(u32)) ||
+	    !IS_ALIGNED(config->dst_addr, sizeof(u32)))
+		return -EINVAL;
+
 	chan->src_addr = config->src_addr;
 	chan->dst_addr = config->dst_addr;
 
@@ -296,8 +328,8 @@
 {
 	struct avalon_dma_chan *chan = to_avalon_dma_chan(dma_chan);
 	struct avalon_dma_desc *desc;
-	gfp_t gfp_flags = in_interrupt() ? GFP_NOWAIT : GFP_KERNEL;
 	dma_addr_t dev_addr;
+	int i;
 
 	if (direction == DMA_MEM_TO_DEV)
 		dev_addr = chan->dst_addr;
@@ -306,16 +338,30 @@
 	else
 		return NULL;
 
-	desc = kzalloc(sizeof(*desc), gfp_flags);
+	desc = kzalloc(struct_size(desc, seg, sg_len), GFP_NOWAIT);
 	if (!desc)
 		return NULL;
 
 	desc->direction = direction;
 	desc->dev_addr	= dev_addr;
-	desc->sg	= sg;
-	desc->sg_len	= sg_len;
-	desc->sg_curr	= sg;
-	desc->sg_offset	= 0;
+	desc->seg_curr	= 0;
+	desc->seg_off	= 0;
+	desc->nr_segs	= sg_len;
+
+	for (i = 0; i < sg_len; i++) {
+		struct dma_segment *seg = &desc->seg[i];
+		dma_addr_t dma_addr = sg_dma_address(sg);
+		unsigned int dma_len = sg_dma_len(sg);
+
+		if (!IS_ALIGNED(dma_addr, sizeof(u32)) ||
+		    !IS_ALIGNED(dma_len, sizeof(u32)))
+			return NULL;
+
+		seg->dma_addr = dma_addr;
+		seg->dma_len = dma_len;
+
+		sg = sg_next(sg);
+	}
 
 	return vchan_tx_prep(&chan->vchan, &desc->vdesc, flags);
 }
@@ -324,12 +370,11 @@
 {
 	struct avalon_dma_chan *chan = to_avalon_dma_chan(dma_chan);
 	struct avalon_dma_hw *hw = &chan->hw;
-	spinlock_t *lock = &chan->vchan.lock;
 	struct avalon_dma_desc *desc;
 	struct virt_dma_desc *vdesc;
 	unsigned long flags;
 
-	spin_lock_irqsave(lock, flags);
+	spin_lock_irqsave(&chan->vchan.lock, flags);
 
 	if (!vchan_issue_pending(&chan->vchan))
 		goto out;
@@ -339,22 +384,19 @@
 	 * BOTH read and write status must be checked here!
 	 */
 	if (hw->d2h_last_id < 0 && hw->h2d_last_id < 0) {
-		BUG_ON(chan->active_desc);
+		if (chan->active_desc)
+			goto out;
 
 		vdesc = vchan_next_desc(&chan->vchan);
-		BUG_ON(!vdesc);
 		desc = to_avalon_dma_desc(vdesc);
+		chan->active_desc = desc;
 
 		if (start_dma_xfer(hw, desc))
 			goto out;
-
-		chan->active_desc = desc;
-	} else {
-		BUG_ON(!chan->active_desc);
 	}
 
 out:
-	spin_unlock_irqrestore(lock, flags);
+	spin_unlock_irqrestore(&chan->vchan.lock, flags);
 }
 
 static void avalon_dma_desc_free(struct virt_dma_desc *vdesc)
@@ -379,7 +421,7 @@
 
 	ret = avalon_dma_init(adma, dev, regs, irq);
 	if (ret)
-		goto avalon_init_err;
+		goto err;
 
 	dev->dma_parms = &adma->dma_parms;
 	dma_set_max_seg_size(dev, UINT_MAX);
@@ -405,20 +447,22 @@
 	INIT_LIST_HEAD(&dma_dev->channels);
 
 	chan = &adma->chan;
+	chan->src_addr = -1;
+	chan->dst_addr = -1;
 	chan->vchan.desc_free = avalon_dma_desc_free;
+
 	vchan_init(&chan->vchan, dma_dev);
 
 	ret = dma_async_device_register(dma_dev);
 	if (ret)
-		goto dma_dev_reg;
+		goto err;
 
 	return adma;
 
-dma_dev_reg:
-avalon_init_err:
+err:
 	kfree(adma);
 
-	return NULL;
+	return ERR_PTR(ret);
 }
 
 void avalon_dma_unregister(struct avalon_dma *adma)
diff -u b/drivers/dma/avalon/avalon-core.h b/drivers/dma/avalon/avalon-core.h
--- b/drivers/dma/avalon/avalon-core.h
+++ b/drivers/dma/avalon/avalon-core.h
@@ -12,6 +12,8 @@
 
 #include "../virt-dma.h"
 
+#include "avalon-hw.h"
+
 struct avalon_dma_desc {
 	struct virt_dma_desc	vdesc;
 
@@ -19,11 +21,11 @@
 
 	dma_addr_t		dev_addr;
 
-	struct scatterlist	*sg;
-	unsigned int		sg_len;
+	unsigned int		seg_curr;
+	unsigned int		seg_off;
 
-	struct scatterlist	*sg_curr;
-	unsigned int		sg_offset;
+	unsigned int		nr_segs;
+	struct dma_segment	seg[];
 };
 
 struct avalon_dma_hw {
diff -u b/drivers/dma/avalon/avalon-hw.c b/drivers/dma/avalon/avalon-hw.c
--- b/drivers/dma/avalon/avalon-hw.c
+++ b/drivers/dma/avalon/avalon-hw.c
@@ -5,19 +5,14 @@
  * Author: Alexander Gordeev <a.gordeev.box@gmail.com>
  */
 #include <linux/kernel.h>
-#include <linux/delay.h>
 
 #include "avalon-hw.h"
 
-#define DMA_DESC_MAX	AVALON_DMA_DESC_NUM
+#define DMA_DESC_MAX		AVALON_DMA_DESC_NUM
 
 static void setup_desc(struct dma_desc *desc, u32 desc_id,
 		       u64 dest, u64 src, u32 size)
 {
-	BUG_ON(!size);
-	WARN_ON(!IS_ALIGNED(size, sizeof(u32)));
-	BUG_ON(desc_id > (DMA_DESC_MAX - 1));
-
 	desc->src_lo = cpu_to_le32(src & 0xfffffffful);
 	desc->src_hi = cpu_to_le32((src >> 32));
 	desc->dst_lo = cpu_to_le32(dest & 0xfffffffful);
@@ -39,25 +34,17 @@
 	dma_addr_t src;
 	dma_addr_t dest;
 
+	if (desc_id >= DMA_DESC_MAX)
+		return -EINVAL;
+
 	if (direction == DMA_TO_DEVICE) {
 		src = host_addr;
 		dest = dev_addr;
-	} else if (direction == DMA_FROM_DEVICE) {
+	} else {
 		src = dev_addr;
 		dest = host_addr;
-	} else {
-		BUG();
-		return -EINVAL;
-	}
-
-	if (unlikely(desc_id > DMA_DESC_MAX - 1)) {
-		BUG();
-		return -EINVAL;
 	}
 
-	if (WARN_ON(!len))
-		return -EINVAL;
-
 	while (len) {
 		unsigned int xfer_len = min_t(unsigned int, len, AVALON_DMA_MAX_TANSFER_SIZE);
 
@@ -89,111 +76,98 @@
 int setup_descs_sg(struct dma_desc *descs, unsigned int desc_id,
 		   enum dma_data_direction direction,
 		   dma_addr_t dev_addr,
-		   struct scatterlist *__sg, unsigned int __sg_len,
-		   struct scatterlist *sg_start, unsigned int sg_offset,
-		   struct scatterlist **_sg_stop, unsigned int *_sg_set)
+		   struct dma_segment *seg, unsigned int nr_segs,
+		   unsigned int seg_start, unsigned int seg_off,
+		   unsigned int *seg_stop, unsigned int *seg_set)
 {
-	struct scatterlist *sg;
-	dma_addr_t sg_addr;
-	unsigned int sg_len;
-	unsigned int sg_set;
+	unsigned int set = -1;
 	int nr_descs = 0;
 	int ret;
 	int i;
 
-	/*
-	 * Find the SGE that the previous xfer has stopped on -
-	 * it should exist.
-	 */
-	for_each_sg(__sg, sg, __sg_len, i) {
-		if (sg == sg_start)
-			break;
-
-		dev_addr += sg_dma_len(sg);
-	}
-
-	if (WARN_ON(i >= __sg_len))
+	if (seg_start >= nr_segs)
+		return -EINVAL;
+	if ((direction != DMA_TO_DEVICE) && (direction != DMA_FROM_DEVICE))
 		return -EINVAL;
 
 	/*
-	 * The offset can not be longer than the SGE length.
+	 * Skip all SGEs that have been fully transmitted.
 	 */
-	sg_len = sg_dma_len(sg);
-	if (WARN_ON(sg_len < sg_offset))
-		return -EINVAL;
+	for (i = 0; i < seg_start; i++)
+		dev_addr += seg[i].dma_len;
 
 	/*
-	 * Skip the starting SGE if it has been fully transmitted.
+	 * Skip the current SGE if it has been fully transmitted.
 	 */
-	if (sg_offset == sg_len) {
-		if (WARN_ON(sg_is_last(sg)))
-			return -EINVAL;
-
-		dev_addr += sg_len;
-		sg_offset = 0;
-
+	if (seg[i].dma_len == seg_off) {
+		dev_addr += seg_off;
+		seg_off = 0;
 		i++;
-		sg = sg_next(sg);
 	}
 
 	/*
 	 * Setup as many SGEs as the controller is able to transmit.
 	 */
-	BUG_ON(i >= __sg_len);
-	for (; i < __sg_len; i++) {
-		sg_addr = sg_dma_address(sg);
-		sg_len = sg_dma_len(sg);
-
-		if (sg_offset) {
-			if (unlikely(sg_len <= sg_offset)) {
-				BUG();
-				return -EINVAL;
-			}
-
-			dev_addr += sg_offset;
-			sg_addr += sg_offset;
-			sg_len -= sg_offset;
+	for (; i < nr_segs; i++) {
+		dma_addr_t dma_addr = seg[i].dma_addr;
+		unsigned int dma_len = seg[i].dma_len;
+
+		/*
+		 * The offset can not be longer than the SGE length.
+		 */
+		if (dma_len < seg_off)
+			return -EINVAL;
+
+		if (seg_off) {
+			dev_addr += seg_off;
+			dma_addr += seg_off;
+			dma_len -= seg_off;
 
-			sg_offset = 0;
+			seg_off = 0;
 		}
 
 		ret = setup_descs(descs, desc_id, direction,
-				  dev_addr, sg_addr, sg_len, &sg_set);
+				  dev_addr, dma_addr, dma_len, &set);
 		if (ret < 0)
 			return ret;
 
-		if (unlikely((desc_id + ret > DMA_DESC_MAX) ||
-			     (nr_descs + ret > DMA_DESC_MAX))) {
-			BUG();
-			return -ENOMEM;
-		}
+		if ((desc_id + ret > DMA_DESC_MAX) ||
+		    (nr_descs + ret > DMA_DESC_MAX))
+			return -EINVAL;
 
 		nr_descs += ret;
 		desc_id += ret;
 
-		if (desc_id >= DMA_DESC_MAX)
+		/*
+		 * Stop when descriptor table entries are exhausted.
+		 */
+		if (desc_id == DMA_DESC_MAX)
 			break;
 
-		if (unlikely(sg_len != sg_set)) {
-			BUG();
+		/*
+		 * The descriptor table still has free entries, thus
+		 * the current SGE should have fit.
+		 */
+		if (dma_len != set)
 			return -EINVAL;
-		}
 
-		if (sg_is_last(sg))
+		if (i >= nr_segs - 1)
 			break;
 
 		descs += ret;
-		dev_addr += sg_len;
-
-		sg = sg_next(sg);
+		dev_addr += dma_len;
 	}
 
 	/*
-	 * Remember the SGE that next transmission should be started from
+	 * Remember the SGE that next transmission should be started from.
 	 */
-	BUG_ON(!sg);
-	*_sg_stop = sg;
-	*_sg_set = sg_set;
+	if (nr_descs) {
+		*seg_stop = i;
+		*seg_set = set;
+	} else {
+		*seg_stop = seg_start;
+		*seg_set = seg_off;
+	}
 
 	return nr_descs;
 }
diff -u b/drivers/dma/avalon/avalon-hw.h b/drivers/dma/avalon/avalon-hw.h
--- b/drivers/dma/avalon/avalon-hw.h
+++ b/drivers/dma/avalon/avalon-hw.h
@@ -8,21 +8,39 @@
 #define __AVALON_HW_H__
 
 #include <linux/dma-direction.h>
-#include <linux/scatterlist.h>
+#include <linux/io.h>
 
 #define AVALON_DMA_DESC_NUM		128
 
 #define AVALON_DMA_FIXUP_SIZE		0x100
 #define AVALON_DMA_MAX_TANSFER_SIZE	(0x100000 - AVALON_DMA_FIXUP_SIZE)
 
-#define AVALON_DMA_CTRL_BASE		CONFIG_AVALON_DMA_CTRL_BASE
 #define AVALON_DMA_RD_CTRL_OFFSET	0x0
 #define AVALON_DMA_WR_CTRL_OFFSET	0x100
 
-#define AVALON_DMA_RD_EP_DST_LO		CONFIG_AVALON_DMA_RD_EP_DST_LO
-#define AVALON_DMA_RD_EP_DST_HI		CONFIG_AVALON_DMA_RD_EP_DST_HI
-#define AVALON_DMA_WR_EP_DST_LO		CONFIG_AVALON_DMA_WR_EP_DST_LO
-#define AVALON_DMA_WR_EP_DST_HI		CONFIG_AVALON_DMA_WR_EP_DST_HI
+extern unsigned long ctrl_base;
+
+static inline
+u32 __av_read32(void __iomem *base, size_t ctrl_off, size_t reg_off)
+{
+	size_t offset = ctrl_base + ctrl_off + reg_off;
+
+	return ioread32(base + offset);
+}
+
+static inline
+void __av_write32(u32 val,
+		  void __iomem *base, size_t ctrl_off, size_t reg_off)
+{
+	size_t offset = ctrl_base + ctrl_off + reg_off;
+
+	iowrite32(val, base + offset);
+}
+
+#define av_read32(b, o, r) \
+	__av_read32(b, o, offsetof(struct dma_ctrl, r))
+#define av_write32(v, b, o, r) \
+	__av_write32(v, b, o, offsetof(struct dma_ctrl, r))
 
 struct dma_ctrl {
 	u32 rc_src_lo;
@@ -48,36 +66,17 @@
 	struct dma_desc descs[AVALON_DMA_DESC_NUM];
 } __packed;
 
-static inline u32 __av_read32(void __iomem *base,
-			      size_t ctrl_off,
-			      size_t reg_off)
-{
-	size_t offset = AVALON_DMA_CTRL_BASE + ctrl_off + reg_off;
-
-	return ioread32(base + offset);
-}
-
-static inline void __av_write32(u32 value,
-				void __iomem *base,
-				size_t ctrl_off,
-				size_t reg_off)
-{
-	size_t offset = AVALON_DMA_CTRL_BASE + ctrl_off + reg_off;
-
-	iowrite32(value, base + offset);
-}
-
-#define av_read32(b, o, r) \
-	__av_read32(b, o, offsetof(struct dma_ctrl, r))
-#define av_write32(v, b, o, r) \
-	__av_write32(v, b, o, offsetof(struct dma_ctrl, r))
+struct dma_segment {
+	dma_addr_t	dma_addr;
+	unsigned int	dma_len;
+};
 
 int setup_descs_sg(struct dma_desc *descs, unsigned int desc_id,
 		   enum dma_data_direction direction,
 		   dma_addr_t dev_addr,
-		   struct scatterlist *__sg, unsigned int __sg_len,
-		   struct scatterlist *sg_start, unsigned int sg_offset,
-		   struct scatterlist **_sg_stop, unsigned int *_sg_set);
+		   struct dma_segment *seg, unsigned int nr_segs,
+		   unsigned int seg_start, unsigned int sg_off,
+		   unsigned int *seg_stop, unsigned int *seg_set);
 
 void start_xfer(void __iomem *base, size_t ctrl_off,
 		u32 rc_src_hi, u32 rc_src_lo,
diff -u b/drivers/dma/avalon/avalon-pci.c b/drivers/dma/avalon/avalon-pci.c
--- b/drivers/dma/avalon/avalon-pci.c
+++ b/drivers/dma/avalon/avalon-pci.c
@@ -10,40 +10,46 @@
 
 #include "avalon-core.h"
 
-#define DRIVER_NAME		"avalon-dma"
+#define DRIVER_NAME "avalon-dma"
 
-#define PCI_BAR			CONFIG_AVALON_DMA_PCI_BAR
-#define PCI_MSI_VECTOR		CONFIG_AVALON_DMA_PCI_MSI_VECTOR
-#define PCI_MSI_COUNT		BIT(CONFIG_AVALON_DMA_PCI_MSI_COUNT_ORDER)
-
-#define AVALON_DMA_PCI_VENDOR_ID	CONFIG_AVALON_DMA_PCI_VENDOR_ID
-#define AVALON_DMA_PCI_DEVICE_ID	CONFIG_AVALON_DMA_PCI_DEVICE_ID
+static unsigned int pci_bar = 0;
+module_param(pci_bar, uint, 0644);
+MODULE_PARM_DESC(pci_bar,
+		 "PCI BAR number the controller is mapped to (default: 0)");
+
+static unsigned int pci_msi_vector = 0;
+module_param(pci_msi_vector, uint, 0644);
+MODULE_PARM_DESC(pci_msi_vector,
+		 "MSI vector number used for the controller (default: 0)");
+
+static unsigned int pci_msi_count_order = 5;
+module_param(pci_msi_count_order, uint, 0644);
+MODULE_PARM_DESC(pci_msi_count_order,
+		 "Number of MSI vectors (order) device uses (default: 5)");
 
 static int init_interrupts(struct pci_dev *pci_dev)
 {
+	unsigned int nr_vecs = BIT(pci_msi_count_order);
 	int ret;
 
-	ret = pci_alloc_irq_vectors(pci_dev,
-				    PCI_MSI_COUNT, PCI_MSI_COUNT,
-				    PCI_IRQ_MSI);
+	ret = pci_alloc_irq_vectors(pci_dev, nr_vecs, nr_vecs, PCI_IRQ_MSI);
 	if (ret < 0) {
-		goto msi_err;
-	} else if (ret != PCI_MSI_COUNT) {
+		return ret;
+
+	} else if (ret != nr_vecs) {
 		ret = -ENOSPC;
-		goto nr_msi_err;
+		goto disable_msi;
 	}
 
-	ret = pci_irq_vector(pci_dev, PCI_MSI_VECTOR);
+	ret = pci_irq_vector(pci_dev, pci_msi_vector);
 	if (ret < 0)
-		goto vec_err;
+		goto disable_msi;
 
 	return ret;
 
-vec_err:
-nr_msi_err:
+disable_msi:
 	pci_disable_msi(pci_dev);
 
-msi_err:
 	return ret;
 }
 
@@ -52,8 +58,8 @@
 	pci_disable_msi(pci_dev);
 }
 
-static int __init avalon_pci_probe(struct pci_dev *pci_dev,
-				   const struct pci_device_id *id)
+static int avalon_pci_probe(struct pci_dev *pci_dev,
+			    const struct pci_device_id *id)
 {
 	void *adma;
 	void __iomem *regs;
@@ -61,26 +67,26 @@
 
 	ret = pci_enable_device(pci_dev);
 	if (ret)
-		goto enable_err;
+		return ret;
 
 	ret = pci_request_regions(pci_dev, DRIVER_NAME);
 	if (ret)
-		goto reg_err;
+		goto disable_device;
 
-	regs = pci_ioremap_bar(pci_dev, PCI_BAR);
+	regs = pci_ioremap_bar(pci_dev, pci_bar);
 	if (!regs) {
 		ret = -ENOMEM;
-		goto ioremap_err;
+		goto release_regions;
 	}
 
 	ret = init_interrupts(pci_dev);
 	if (ret < 0)
-		goto int_err;
+		goto unmap_bars;
 
 	adma = avalon_dma_register(&pci_dev->dev, regs, ret);
 	if (IS_ERR(adma)) {
 		ret = PTR_ERR(adma);
-		goto dma_err;
+		goto terminate_interrupts;
 	}
 
 	pci_set_master(pci_dev);
@@ -88,23 +94,22 @@
 
 	return 0;
 
-dma_err:
+terminate_interrupts:
 	term_interrupts(pci_dev);
 
-int_err:
+unmap_bars:
 	pci_iounmap(pci_dev, regs);
 
-ioremap_err:
+release_regions:
 	pci_release_regions(pci_dev);
 
-reg_err:
+disable_device:
 	pci_disable_device(pci_dev);
 
-enable_err:
 	return ret;
 }
 
-static void __exit avalon_pci_remove(struct pci_dev *pci_dev)
+static void avalon_pci_remove(struct pci_dev *pci_dev)
 {
 	void *adma = pci_get_drvdata(pci_dev);
 	void __iomem *regs = avalon_dma_mmio(adma);
@@ -122,29 +127,18 @@
-static struct pci_device_id pci_ids[] = {
-	{ PCI_DEVICE(AVALON_DMA_PCI_VENDOR_ID, AVALON_DMA_PCI_DEVICE_ID) },
+static struct pci_device_id avalon_pci_ids[] = {
+	{ PCI_DEVICE(PCI_VENDOR_ID_ALTERA, 0xe003) },
 	{ 0 }
 };
 
-static struct pci_driver dma_driver_ops = {
+static struct pci_driver avalon_pci_driver = {
 	.name		= DRIVER_NAME,
-	.id_table	= pci_ids,
+	.id_table	= avalon_pci_ids,
 	.probe		= avalon_pci_probe,
 	.remove		= avalon_pci_remove,
 };
 
-static int __init avalon_drv_init(void)
-{
-	return pci_register_driver(&dma_driver_ops);
-}
-
-static void __exit avalon_drv_exit(void)
-{
-	pci_unregister_driver(&dma_driver_ops);
-}
-
-module_init(avalon_drv_init);
-module_exit(avalon_drv_exit);
+module_pci_driver(avalon_pci_driver);
 
 MODULE_AUTHOR("Alexander Gordeev <a.gordeev.box@gmail.com>");
 MODULE_DESCRIPTION("Avalon-MM DMA Interface for PCIe");
 MODULE_LICENSE("GPL v2");
-MODULE_DEVICE_TABLE(pci, pci_ids);
+MODULE_DEVICE_TABLE(pci, avalon_pci_ids);


Signed-off-by: Alexander Gordeev <a.gordeev.box@gmail.com>

-- 
2.23.0

