Return-Path: <dmaengine+bounces-8220-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4117DD14CA7
	for <lists+dmaengine@lfdr.de>; Mon, 12 Jan 2026 19:40:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 3E72E30069B0
	for <lists+dmaengine@lfdr.de>; Mon, 12 Jan 2026 18:40:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D217737F8A0;
	Mon, 12 Jan 2026 18:40:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=deltatee.com header.i=@deltatee.com header.b="qsEB4H4+"
X-Original-To: dmaengine@vger.kernel.org
Received: from ale.deltatee.com (ale.deltatee.com [204.191.154.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D3893876B4
	for <dmaengine@vger.kernel.org>; Mon, 12 Jan 2026 18:40:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=204.191.154.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768243254; cv=none; b=o/l48QKFO/qeg9l1Qtvb62yhXKyVqWJEnDTLoDCg0/yFCLv/g3WVYB8mOiparQ2WwCA0SSiKMrLHh7ryIneWs3F5S9IxorsaSJrY20RJq0BKxjs7LAXstn2KB810CUwFH4TdaGTrrlBCw/kGSDs4uSM+sP8Rlpg1Y2NMsAGHIfE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768243254; c=relaxed/simple;
	bh=iqIaYmpcOThDUdSEd3vwBy6w1wNaKsrnYhvN3cDvjCw=;
	h=From:To:Cc:Date:Message-ID:In-Reply-To:References:MIME-Version:
	 Subject; b=Z0ui3uec3CD4YE5ZyEtf/K5a/JSL2/HH8RuseQLX/+ypoNhJe1Gu0xtePc2A3OQB1v7kL0BGgLzynX7SxAs9OB41MippzrHtz5ywBwipRk67f1Myfb3FAl7hmL/fYnRBE22jP/JSQs4FIs7fy3JDV0LZ1dGbPB3+cTJKs+FVhX4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=deltatee.com; spf=pass smtp.mailfrom=deltatee.com; dkim=pass (2048-bit key) header.d=deltatee.com header.i=@deltatee.com header.b=qsEB4H4+; arc=none smtp.client-ip=204.191.154.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=deltatee.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=deltatee.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=deltatee.com; s=20200525; h=Subject:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Cc:To:From:content-disposition;
	bh=J1tEasa4fDaZGvvGSqedVZO8MKuHo00OplEwa5px7eg=; b=qsEB4H4+pWKBuW9ISbiXP5lb6i
	WMtFMZP1fms3zyI3TK4MgrRjpO3IVJW72DR+1lyycQEpsWRHvQ/+COylmwLLnxP5jOtDyI3mGaaLD
	bizi8Lnoy26sZ6z7EJvznI9uN8JaKCNhJQIffCeY2hMcubdMTVde76Ocs8ElwfklDNyi5gvS/mVU4
	uLzUBLV5VHeBhpu0jZI6vut7Hc4f2nol84F7yp2kXv8QOQxAqiAHlfJDJBTcvlFyObGgsvIopxYsz
	gtPLH1CYklwpVXoZyQh++IEpjd/xxwu8mxzzV1qV00u7mCHeo/bkMCHm7hRjOFr4Z3qvmelNjazLk
	C7URXJeA==;
Received: from cgy1-donard.priv.deltatee.com ([172.16.1.31])
	by ale.deltatee.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <gunthorp@deltatee.com>)
	id 1vfMqM-000000001Dg-1l9P;
	Mon, 12 Jan 2026 11:40:47 -0700
Received: from gunthorp by cgy1-donard.priv.deltatee.com with local (Exim 4.98.2)
	(envelope-from <gunthorp@deltatee.com>)
	id 1vfMq2-000000000gR-10qC;
	Mon, 12 Jan 2026 11:40:26 -0700
From: Logan Gunthorpe <logang@deltatee.com>
To: dmaengine@vger.kernel.org,
	Vinod Koul <vkoul@kernel.org>
Cc: Kelvin Cao <kelvin.cao@microchip.com>,
	George Ge <George.Ge@microchip.com>,
	Christoph Hellwig <hch@infradead.org>,
	Christophe Jaillet <christophe.jaillet@wanadoo.fr>,
	George Ge <george.ge@microchip.com>,
	Christoph Hellwig <hch@lst.de>,
	Logan Gunthorpe <logang@deltatee.com>
Date: Mon, 12 Jan 2026 11:40:17 -0700
Message-ID: <20260112184017.2601-4-logang@deltatee.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260112184017.2601-1-logang@deltatee.com>
References: <20260112184017.2601-1-logang@deltatee.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 172.16.1.31
X-SA-Exim-Rcpt-To: dmaengine@vger.kernel.org, vkoul@kernel.org, hch@infradead.org, christophe.jaillet@wanadoo.fr, kelvin.cao@microchip.com, George.Ge@microchip.com, george.ge@microchip.com, hch@lst.de, logang@deltatee.com
X-SA-Exim-Mail-From: gunthorp@deltatee.com
X-Spam-Level: 
Subject: [PATCH v12 3/3] dmaengine: switchtec-dma: Implement descriptor submission
X-SA-Exim-Version: 4.2.1 (built Sun, 23 Feb 2025 07:57:16 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)

From: Kelvin Cao <kelvin.cao@microchip.com>

On prep, a spin lock is taken and the next entry in the circular buffer
is filled. On submit, the spin lock just needs to be released as the
requests are already pending.

When switchtec_dma_issue_pending() is called, the sq_tail register
is written to indicate there are new jobs for the dma engine to start
on.

Pause and resume operations are implemented by writing to a control
register.

Signed-off-by: Kelvin Cao <kelvin.cao@microchip.com>
Co-developed-by: George Ge <george.ge@microchip.com>
Signed-off-by: George Ge <george.ge@microchip.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
---
 drivers/dma/switchtec_dma.c | 231 ++++++++++++++++++++++++++++++++++++
 1 file changed, 231 insertions(+)

diff --git a/drivers/dma/switchtec_dma.c b/drivers/dma/switchtec_dma.c
index 78cfeffed9a1..3b75a20e83c9 100644
--- a/drivers/dma/switchtec_dma.c
+++ b/drivers/dma/switchtec_dma.c
@@ -32,6 +32,8 @@ MODULE_AUTHOR("Kelvin Cao");
 #define SWITCHTEC_REG_SE_BUF_CNT	0x98
 #define SWITCHTEC_REG_SE_BUF_BASE	0x9a
 
+#define SWITCHTEC_DESC_MAX_SIZE		0x100000
+
 #define SWITCHTEC_CHAN_CTRL_PAUSE	BIT(0)
 #define SWITCHTEC_CHAN_CTRL_HALT	BIT(1)
 #define SWITCHTEC_CHAN_CTRL_RESET	BIT(2)
@@ -41,6 +43,8 @@ MODULE_AUTHOR("Kelvin Cao");
 #define SWITCHTEC_CHAN_STS_HALTED	BIT(10)
 #define SWITCHTEC_CHAN_STS_PAUSED_MASK	GENMASK(29, 13)
 
+#define SWITCHTEC_INVALID_HFID 0xffff
+
 #define SWITCHTEC_DMA_SQ_SIZE	SZ_32K
 #define SWITCHTEC_DMA_CQ_SIZE	SZ_32K
 
@@ -204,6 +208,11 @@ struct switchtec_dma_hw_se_desc {
 	__le16 sfid;
 };
 
+#define SWITCHTEC_SE_DFM		BIT(5)
+#define SWITCHTEC_SE_LIOF		BIT(6)
+#define SWITCHTEC_SE_BRR		BIT(7)
+#define SWITCHTEC_SE_CID_MASK		GENMASK(15, 0)
+
 #define SWITCHTEC_CE_SC_LEN_ERR		BIT(0)
 #define SWITCHTEC_CE_SC_UR		BIT(1)
 #define SWITCHTEC_CE_SC_CA		BIT(2)
@@ -603,6 +612,220 @@ static void switchtec_dma_synchronize(struct dma_chan *chan)
 	spin_unlock_bh(&swdma_chan->complete_lock);
 }
 
+static struct dma_async_tx_descriptor *
+switchtec_dma_prep_desc(struct dma_chan *c, u16 dst_fid, dma_addr_t dma_dst,
+			u16 src_fid, dma_addr_t dma_src, u64 data,
+			size_t len, unsigned long flags)
+	__acquires(swdma_chan->submit_lock)
+{
+	struct switchtec_dma_chan *swdma_chan =
+		container_of(c, struct switchtec_dma_chan, dma_chan);
+	struct switchtec_dma_desc *desc;
+	int head, tail;
+
+	spin_lock_bh(&swdma_chan->submit_lock);
+
+	if (!swdma_chan->ring_active)
+		goto err_unlock;
+
+	tail = READ_ONCE(swdma_chan->tail);
+	head = swdma_chan->head;
+
+	if (!CIRC_SPACE(head, tail, SWITCHTEC_DMA_RING_SIZE))
+		goto err_unlock;
+
+	desc = swdma_chan->desc_ring[head];
+
+	if (src_fid != SWITCHTEC_INVALID_HFID &&
+	    dst_fid != SWITCHTEC_INVALID_HFID)
+		desc->hw->ctrl |= SWITCHTEC_SE_DFM;
+
+	if (flags & DMA_PREP_INTERRUPT)
+		desc->hw->ctrl |= SWITCHTEC_SE_LIOF;
+
+	if (flags & DMA_PREP_FENCE)
+		desc->hw->ctrl |= SWITCHTEC_SE_BRR;
+
+	desc->txd.flags = flags;
+
+	desc->completed = false;
+	desc->hw->opc = SWITCHTEC_DMA_OPC_MEMCPY;
+	desc->hw->addr_lo = cpu_to_le32(lower_32_bits(dma_src));
+	desc->hw->addr_hi = cpu_to_le32(upper_32_bits(dma_src));
+	desc->hw->daddr_lo = cpu_to_le32(lower_32_bits(dma_dst));
+	desc->hw->daddr_hi = cpu_to_le32(upper_32_bits(dma_dst));
+	desc->hw->byte_cnt = cpu_to_le32(len);
+	desc->hw->tlp_setting = 0;
+	desc->hw->dfid = cpu_to_le16(dst_fid);
+	desc->hw->sfid = cpu_to_le16(src_fid);
+	swdma_chan->cid &= SWITCHTEC_SE_CID_MASK;
+	desc->hw->cid = cpu_to_le16(swdma_chan->cid++);
+	desc->orig_size = len;
+
+	/* return with the lock held, it will be released in tx_submit */
+
+	return &desc->txd;
+
+err_unlock:
+	/*
+	 * Keep sparse happy by restoring an even lock count on
+	 * this lock.
+	 */
+	__acquire(swdma_chan->submit_lock);
+
+	spin_unlock_bh(&swdma_chan->submit_lock);
+	return NULL;
+}
+
+static struct dma_async_tx_descriptor *
+switchtec_dma_prep_memcpy(struct dma_chan *c, dma_addr_t dma_dst,
+			  dma_addr_t dma_src, size_t len, unsigned long flags)
+	__acquires(swdma_chan->submit_lock)
+{
+	if (len > SWITCHTEC_DESC_MAX_SIZE) {
+		/*
+		 * Keep sparse happy by restoring an even lock count on
+		 * this lock.
+		 */
+		__acquire(swdma_chan->submit_lock);
+		return NULL;
+	}
+
+	return switchtec_dma_prep_desc(c, SWITCHTEC_INVALID_HFID, dma_dst,
+				       SWITCHTEC_INVALID_HFID, dma_src, 0, len,
+				       flags);
+}
+
+static dma_cookie_t
+switchtec_dma_tx_submit(struct dma_async_tx_descriptor *desc)
+	__releases(swdma_chan->submit_lock)
+{
+	struct switchtec_dma_chan *swdma_chan =
+		container_of(desc->chan, struct switchtec_dma_chan, dma_chan);
+	dma_cookie_t cookie;
+	int head;
+
+	head = swdma_chan->head + 1;
+	head &= SWITCHTEC_DMA_RING_SIZE - 1;
+
+	/*
+	 * Ensure the desc updates are visible before updating the head index
+	 */
+	smp_store_release(&swdma_chan->head, head);
+
+	cookie = dma_cookie_assign(desc);
+
+	spin_unlock_bh(&swdma_chan->submit_lock);
+
+	return cookie;
+}
+
+static enum dma_status switchtec_dma_tx_status(struct dma_chan *chan,
+		dma_cookie_t cookie, struct dma_tx_state *txstate)
+{
+	struct switchtec_dma_chan *swdma_chan =
+		container_of(chan, struct switchtec_dma_chan, dma_chan);
+	enum dma_status ret;
+
+	ret = dma_cookie_status(chan, cookie, txstate);
+	if (ret == DMA_COMPLETE)
+		return ret;
+
+	/*
+	 * For jobs where the interrupts are disabled, this is the only place
+	 * to process the completions returned by the hardware. Callers that
+	 * disable interrupts must call tx_status() to determine when a job
+	 * is done, so it is safe to process completions here. If a job has
+	 * interrupts enabled, then the completions will normally be processed
+	 * in the tasklet that is triggered by the interrupt and tx_status()
+	 * does not need to be called.
+	 */
+	switchtec_dma_cleanup_completed(swdma_chan);
+
+	return dma_cookie_status(chan, cookie, txstate);
+}
+
+static void switchtec_dma_issue_pending(struct dma_chan *chan)
+{
+	struct switchtec_dma_chan *swdma_chan =
+		container_of(chan, struct switchtec_dma_chan, dma_chan);
+	struct switchtec_dma_dev *swdma_dev = swdma_chan->swdma_dev;
+
+	/*
+	 * Ensure the desc updates are visible before starting the
+	 * DMA engine.
+	 */
+	wmb();
+
+	/*
+	 * The sq_tail register is actually for the head of the
+	 * submisssion queue. Chip has the opposite define of head/tail
+	 * to the Linux kernel.
+	 */
+
+	rcu_read_lock();
+	if (!rcu_dereference(swdma_dev->pdev)) {
+		rcu_read_unlock();
+		return;
+	}
+
+	spin_lock_bh(&swdma_chan->submit_lock);
+	writew(swdma_chan->head, &swdma_chan->mmio_chan_hw->sq_tail);
+	spin_unlock_bh(&swdma_chan->submit_lock);
+
+	rcu_read_unlock();
+}
+
+static int switchtec_dma_pause(struct dma_chan *chan)
+{
+	struct switchtec_dma_chan *swdma_chan =
+		container_of(chan, struct switchtec_dma_chan, dma_chan);
+	struct chan_hw_regs __iomem *chan_hw = swdma_chan->mmio_chan_hw;
+	struct pci_dev *pdev;
+	int ret;
+
+	rcu_read_lock();
+	pdev = rcu_dereference(swdma_chan->swdma_dev->pdev);
+	if (!pdev) {
+		ret = -ENODEV;
+		goto unlock_and_exit;
+	}
+
+	spin_lock(&swdma_chan->hw_ctrl_lock);
+	writeb(SWITCHTEC_CHAN_CTRL_PAUSE, &chan_hw->ctrl);
+	ret = wait_for_chan_status(chan_hw, SWITCHTEC_CHAN_STS_PAUSED, true);
+	spin_unlock(&swdma_chan->hw_ctrl_lock);
+
+unlock_and_exit:
+	rcu_read_unlock();
+	return ret;
+}
+
+static int switchtec_dma_resume(struct dma_chan *chan)
+{
+	struct switchtec_dma_chan *swdma_chan =
+		container_of(chan, struct switchtec_dma_chan, dma_chan);
+	struct chan_hw_regs __iomem *chan_hw = swdma_chan->mmio_chan_hw;
+	struct pci_dev *pdev;
+	int ret;
+
+	rcu_read_lock();
+	pdev = rcu_dereference(swdma_chan->swdma_dev->pdev);
+	if (!pdev) {
+		ret = -ENODEV;
+		goto unlock_and_exit;
+	}
+
+	spin_lock(&swdma_chan->hw_ctrl_lock);
+	writeb(0, &chan_hw->ctrl);
+	ret = wait_for_chan_status(chan_hw, SWITCHTEC_CHAN_STS_PAUSED, false);
+	spin_unlock(&swdma_chan->hw_ctrl_lock);
+
+unlock_and_exit:
+	rcu_read_unlock();
+	return ret;
+}
+
 static void switchtec_dma_desc_task(unsigned long data)
 {
 	struct switchtec_dma_chan *swdma_chan = (void *)data;
@@ -721,6 +944,7 @@ static int switchtec_dma_alloc_desc(struct switchtec_dma_chan *swdma_chan)
 		}
 
 		dma_async_tx_descriptor_init(&desc->txd, &swdma_chan->dma_chan);
+		desc->txd.tx_submit = switchtec_dma_tx_submit;
 		desc->hw = &swdma_chan->hw_sq[i];
 		desc->completed = true;
 
@@ -1047,10 +1271,17 @@ static int switchtec_dma_create(struct pci_dev *pdev)
 
 	dma = &swdma_dev->dma_dev;
 	dma->copy_align = DMAENGINE_ALIGN_8_BYTES;
+	dma_cap_set(DMA_MEMCPY, dma->cap_mask);
+	dma_cap_set(DMA_PRIVATE, dma->cap_mask);
 	dma->dev = get_device(&pdev->dev);
 
 	dma->device_alloc_chan_resources = switchtec_dma_alloc_chan_resources;
 	dma->device_free_chan_resources = switchtec_dma_free_chan_resources;
+	dma->device_prep_dma_memcpy = switchtec_dma_prep_memcpy;
+	dma->device_tx_status = switchtec_dma_tx_status;
+	dma->device_issue_pending = switchtec_dma_issue_pending;
+	dma->device_pause = switchtec_dma_pause;
+	dma->device_resume = switchtec_dma_resume;
 	dma->device_terminate_all = switchtec_dma_terminate_all;
 	dma->device_synchronize = switchtec_dma_synchronize;
 	dma->device_release = switchtec_dma_release;
-- 
2.47.3


