Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DF3D0117C61
	for <lists+dmaengine@lfdr.de>; Tue, 10 Dec 2019 01:25:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726495AbfLJAYq (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 9 Dec 2019 19:24:46 -0500
Received: from ale.deltatee.com ([207.54.116.67]:38052 "EHLO ale.deltatee.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727456AbfLJAYq (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Mon, 9 Dec 2019 19:24:46 -0500
Received: from cgy1-donard.priv.deltatee.com ([172.16.1.31])
        by ale.deltatee.com with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <gunthorp@deltatee.com>)
        id 1ieTKS-0002Cy-6g; Mon, 09 Dec 2019 17:24:44 -0700
Received: from gunthorp by cgy1-donard.priv.deltatee.com with local (Exim 4.92)
        (envelope-from <gunthorp@deltatee.com>)
        id 1ieTKR-0000lv-H5; Mon, 09 Dec 2019 17:24:39 -0700
From:   Logan Gunthorpe <logang@deltatee.com>
To:     linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org,
        Vinod Koul <vkoul@kernel.org>
Cc:     Dan Williams <dan.j.williams@intel.com>,
        Kit Chow <kchow@gigaio.com>,
        Logan Gunthorpe <logang@deltatee.com>
Date:   Mon,  9 Dec 2019 17:24:37 -0700
Message-Id: <20191210002437.2907-6-logang@deltatee.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191210002437.2907-1-logang@deltatee.com>
References: <20191210002437.2907-1-logang@deltatee.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 172.16.1.31
X-SA-Exim-Rcpt-To: linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org, vkoul@kernel.org, dan.j.williams@intel.com, kchow@gigaio.com, logang@deltatee.com
X-SA-Exim-Mail-From: gunthorp@deltatee.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on ale.deltatee.com
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        GREYLIST_ISWHITE,MYRULES_FREE,MYRULES_NO_TEXT autolearn=ham
        autolearn_force=no version=3.4.2
Subject: [PATCH v2 5/5] dmaengine: plx-dma: Implement descriptor submission
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On prep, a spin lock is taken and the next entry in the circular buffer
is filled. On submit, the valid bit is set in the hardware descriptor
and the lock is released.

The DMA engine is started (if it's not already running) when the client
calls dma_async_issue_pending().

Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
---
 drivers/dma/plx_dma.c | 119 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 119 insertions(+)

diff --git a/drivers/dma/plx_dma.c b/drivers/dma/plx_dma.c
index d3c2319e2fad..21e4d7634eeb 100644
--- a/drivers/dma/plx_dma.c
+++ b/drivers/dma/plx_dma.c
@@ -7,6 +7,7 @@
 
 #include "dmaengine.h"
 
+#include <linux/circ_buf.h>
 #include <linux/dmaengine.h>
 #include <linux/kref.h>
 #include <linux/list.h>
@@ -122,6 +123,11 @@ static struct plx_dma_dev *chan_to_plx_dma_dev(struct dma_chan *c)
 	return container_of(c, struct plx_dma_dev, dma_chan);
 }
 
+static struct plx_dma_desc *to_plx_desc(struct dma_async_tx_descriptor *txd)
+{
+	return container_of(txd, struct plx_dma_desc, txd);
+}
+
 static struct plx_dma_desc *plx_dma_get_desc(struct plx_dma_dev *plxdev, int i)
 {
 	return plxdev->desc_ring[i & (PLX_DMA_RING_COUNT - 1)];
@@ -244,6 +250,113 @@ static void plx_dma_desc_task(unsigned long data)
 	plx_dma_process_desc(plxdev);
 }
 
+static struct dma_async_tx_descriptor *plx_dma_prep_memcpy(struct dma_chan *c,
+		dma_addr_t dma_dst, dma_addr_t dma_src, size_t len,
+		unsigned long flags)
+	__acquires(plxdev->ring_lock)
+{
+	struct plx_dma_dev *plxdev = chan_to_plx_dma_dev(c);
+	struct plx_dma_desc *plxdesc;
+
+	spin_lock_bh(&plxdev->ring_lock);
+	if (!plxdev->ring_active)
+		goto err_unlock;
+
+	if (!CIRC_SPACE(plxdev->head, plxdev->tail, PLX_DMA_RING_COUNT))
+		goto err_unlock;
+
+	if (len > PLX_DESC_SIZE_MASK)
+		goto err_unlock;
+
+	plxdesc = plx_dma_get_desc(plxdev, plxdev->head);
+	plxdev->head++;
+
+	plxdesc->hw->dst_addr_lo = cpu_to_le32(lower_32_bits(dma_dst));
+	plxdesc->hw->dst_addr_hi = cpu_to_le16(upper_32_bits(dma_dst));
+	plxdesc->hw->src_addr_lo = cpu_to_le32(lower_32_bits(dma_src));
+	plxdesc->hw->src_addr_hi = cpu_to_le16(upper_32_bits(dma_src));
+
+	plxdesc->orig_size = len;
+
+	if (flags & DMA_PREP_INTERRUPT)
+		len |= PLX_DESC_FLAG_INT_WHEN_DONE;
+
+	plxdesc->hw->flags_and_size = cpu_to_le32(len);
+	plxdesc->txd.flags = flags;
+
+	/* return with the lock held, it will be released in tx_submit */
+
+	return &plxdesc->txd;
+
+err_unlock:
+	/*
+	 * Keep sparse happy by restoring an even lock count on
+	 * this lock.
+	 */
+	__acquire(plxdev->ring_lock);
+
+	spin_unlock_bh(&plxdev->ring_lock);
+	return NULL;
+}
+
+static dma_cookie_t plx_dma_tx_submit(struct dma_async_tx_descriptor *desc)
+	__releases(plxdev->ring_lock)
+{
+	struct plx_dma_dev *plxdev = chan_to_plx_dma_dev(desc->chan);
+	struct plx_dma_desc *plxdesc = to_plx_desc(desc);
+	dma_cookie_t cookie;
+
+	cookie = dma_cookie_assign(desc);
+
+	/*
+	 * Ensure the descriptor updates are visible to the dma device
+	 * before setting the valid bit.
+	 */
+	wmb();
+
+	plxdesc->hw->flags_and_size |= cpu_to_le32(PLX_DESC_FLAG_VALID);
+
+	spin_unlock_bh(&plxdev->ring_lock);
+
+	return cookie;
+}
+
+static enum dma_status plx_dma_tx_status(struct dma_chan *chan,
+		dma_cookie_t cookie, struct dma_tx_state *txstate)
+{
+	struct plx_dma_dev *plxdev = chan_to_plx_dma_dev(chan);
+	enum dma_status ret;
+
+	ret = dma_cookie_status(chan, cookie, txstate);
+	if (ret == DMA_COMPLETE)
+		return ret;
+
+	plx_dma_process_desc(plxdev);
+
+	return dma_cookie_status(chan, cookie, txstate);
+}
+
+static void plx_dma_issue_pending(struct dma_chan *chan)
+{
+	struct plx_dma_dev *plxdev = chan_to_plx_dma_dev(chan);
+
+	rcu_read_lock();
+	if (!rcu_dereference(plxdev->pdev)) {
+		rcu_read_unlock();
+		return;
+	}
+
+	/*
+	 * Ensure the valid bits are visible before starting the
+	 * DMA engine.
+	 */
+	wmb();
+
+	writew(PLX_REG_CTRL_START_VAL, plxdev->bar + PLX_REG_CTRL);
+
+	rcu_read_unlock();
+}
+
 static irqreturn_t plx_dma_isr(int irq, void *devid)
 {
 	struct plx_dma_dev *plxdev = devid;
@@ -307,7 +420,9 @@ static int plx_dma_alloc_desc(struct plx_dma_dev *plxdev)
 			goto free_and_exit;
 
 		dma_async_tx_descriptor_init(&desc->txd, &plxdev->dma_chan);
+		desc->txd.tx_submit = plx_dma_tx_submit;
 		desc->hw = &plxdev->hw_ring[i];
+
 		plxdev->desc_ring[i] = desc;
 	}
 
@@ -428,11 +543,15 @@ static int plx_dma_create(struct pci_dev *pdev)
 	dma = &plxdev->dma_dev;
 	dma->chancnt = 1;
 	INIT_LIST_HEAD(&dma->channels);
+	dma_cap_set(DMA_MEMCPY, dma->cap_mask);
 	dma->copy_align = DMAENGINE_ALIGN_1_BYTE;
 	dma->dev = get_device(&pdev->dev);
 
 	dma->device_alloc_chan_resources = plx_dma_alloc_chan_resources;
 	dma->device_free_chan_resources = plx_dma_free_chan_resources;
+	dma->device_prep_dma_memcpy = plx_dma_prep_memcpy;
+	dma->device_issue_pending = plx_dma_issue_pending;
+	dma->device_tx_status = plx_dma_tx_status;
 
 	chan = &plxdev->dma_chan;
 	chan->device = dma;
-- 
2.20.1

