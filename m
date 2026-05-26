Return-Path: <dmaengine+bounces-10906-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cDcSCvdfFWp7UgcAu9opvQ
	(envelope-from <dmaengine+bounces-10906-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Tue, 26 May 2026 10:55:19 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AA4E5D2C77
	for <lists+dmaengine@lfdr.de>; Tue, 26 May 2026 10:55:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 254C430C7409
	for <lists+dmaengine@lfdr.de>; Tue, 26 May 2026 08:48:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A292F3CF039;
	Tue, 26 May 2026 08:48:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PpuIXhNY"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 620FA3CEBBD;
	Tue, 26 May 2026 08:48:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779785289; cv=none; b=rbHtUuvEdLQNKJfEfhCZ5sVfJD84GLI4Y9RpgU/6aMVFGygVfyepyjvDnGlb89dWFq32bbRsR19D6HF0sdynn3X5JP3PsHbL5gM9zD94ZyoIvfFSiUt+f8iZprOVD94j+QCYdigp+ISg9M999DnXHCK8bpdQ1T8oAPaUlUaqmfw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779785289; c=relaxed/simple;
	bh=/mPYLQlMXC+E68sfWJk8pFpnC8M5M3d7l3tjusv6WRg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZcZsRcXQYLqUXcSQVwKgCc6zK18Z9VQmKDlzJh3rIB8qAbFLs8zo1ab3rTAKGz6RA0F0rAo1qLX1qf8iSMyadPWuIdLOBNJtDNEEEHAuY6qVfcURPiB3aOuDfpknzU5KLUa0jwnJ16hFPhZNYw38J1QUOHEbSVUkK5Wc34akOVo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PpuIXhNY; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 86F291F000E9;
	Tue, 26 May 2026 08:48:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779785286;
	bh=k91dWFt0ymKodPPvZmmR55xgb4aQRHNzFX1xgTdltT4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=PpuIXhNYSLYLME8JkSRYSuSV+doRlQc+Z9CpZrOZLZ7zhnT+E2Ee1p6eHZBNdNzwn
	 Y6j2H5DiCyNV4UwzUbUAm8/82ysoc4JMFnvi5hLI+v2CxVLKvNtsS99JNdPnXpHlhf
	 lLa0o/14B+D/klK2cZOp5hnp9Nx83NJA+QDBcQOzVGP8SDvv4ztVDzwxZTQNSDVvB+
	 waxnC9qMr+y1dPnkz96lRyIKAwp5NFkqGt4L/GiIRpWtfaTGTD0DsAMn62O1H2zEuO
	 E+1VQTrw7OW/QTTKOEoiqDkmLn9ImPC1OKpFTJlVSo87ew6deARlVVNETl3RcJn1xF
	 rvUDkaMxR368g==
From: Claudiu Beznea <claudiu.beznea@kernel.org>
To: vkoul@kernel.org,
	Frank.Li@kernel.org,
	lgirdwood@gmail.com,
	broonie@kernel.org,
	perex@perex.cz,
	tiwai@suse.com,
	biju.das.jz@bp.renesas.com,
	prabhakar.mahadev-lad.rj@bp.renesas.com,
	p.zabel@pengutronix.de,
	geert+renesas@glider.be,
	kuninori.morimoto.gx@renesas.com,
	long.luu.ur@renesas.com
Cc: claudiu.beznea@kernel.org,
	claudiu.beznea@tuxon.dev,
	dmaengine@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-sound@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>,
	John Madieu <john.madieu.xa@bp.renesas.com>
Subject: [PATCH v6 09/18] dmaengine: sh: rz-dmac: Use virt-dma APIs for channel descriptor processing
Date: Tue, 26 May 2026 11:47:01 +0300
Message-ID: <20260526084710.3491480-10-claudiu.beznea@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260526084710.3491480-1-claudiu.beznea@kernel.org>
References: <20260526084710.3491480-1-claudiu.beznea@kernel.org>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-10906-lists,dmaengine=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[20];
	FREEMAIL_TO(0.00)[kernel.org,gmail.com,perex.cz,suse.com,bp.renesas.com,pengutronix.de,glider.be,renesas.com];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[claudiu.beznea@kernel.org,dmaengine@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.985];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[dmaengine,renesas];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 7AA4E5D2C77
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

The driver used a mix of virt-dma APIs and driver specific logic to
process descriptors. It maintained three internal queues: ld_free,
ld_queue, and ld_active as follows:
- ld_free: stores the descriptors pre-allocated at probe time
- ld_queue: stores descriptors after they are taken from ld_free and
  prepared. At the same time, vchan_tx_prep() queues them to
  vc->desc_allocated. The vc->desc_allocated list is then checked in
  rz_dmac_issue_pending() and rz_dmac_irq_handler_thread() before
  starting a new transfer via rz_dmac_xfer_desc(). In turn,
  rz_dmac_xfer_desc() grabs the next descriptor from vc->desc_issued and
  submits it for transfer
- ld_active: stores the descriptors currently being transferred

The interrupt handler moved a completed descriptor to ld_free before
invoking its completion callback. Once returned to ld_free, the
descriptor can be reused to prepare a new transfer. In theory, this
means the descriptor could be re-prepared before its completion
callback is called.

Commit fully back the driver by the virt-dma APIs. With this, only ld_free
need to be kept to track how many free descriptors are available. This
is now done as follows:
- the prepare stage removes the first descriptor from the ld_free and
  prepares it
- the completion calls for it vc->desc_free() (rz_dmac_virt_desc_free())
  which re-adds the descriptor at the end of ld_free

With this, the critical areas in prepare callbacks were minimized to only
getting the descriptor from the ld_free list.

Introduce struct rz_dmac_chan::desc to keep track of the currently
transferred descriptor. It is cleared in rz_dmac_terminate_all(),
referenced from rz_dmac_issue_pending() to determine whether a new transfer
can be started, and from rz_dmac_irq_handler_thread() once a descriptor has
completed. Finally, the rz_dmac_device_synchronize() was updated with
vchan_synchronize() call to ensure the terminated descriptor is freed and
the tasklet is killed.

With this, residue computation is also simplified, as it can now be
handled entirely through the virt-dma APIs.

The spin_lock/unlock operations from rz_dmac_irq_handler_thread() were
replaced by guard as the final code after rework is simpler this way.

As subsequent commits will set the Link End bit on the last descriptor
of a transfer, rz_dmac_enable_hw() is also adjusted as part of the full
conversion to virt-dma APIs. It no longer checks the channel enable
status itself; instead, its callers verify whether the channel is
enabled and whether the previous transfer has completed before starting
a new one.

Tested-by: John Madieu <john.madieu.xa@bp.renesas.com>
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---

Changes in v6:
- updated patch description as suggested in the review process
- collected tags

Changes in v5:
- none

Changes in v4:
- in rz_dmac_tx_status(): return DMA_PAUSED if the channel is paused;
  call rz_dmac_chan_get_residue() only if status is not complete

Changes in v3:
- none, this patch is new

 drivers/dma/sh/rz-dmac.c | 233 +++++++++++++++------------------------
 1 file changed, 86 insertions(+), 147 deletions(-)

diff --git a/drivers/dma/sh/rz-dmac.c b/drivers/dma/sh/rz-dmac.c
index 217657513fa7..1f884ec101f8 100644
--- a/drivers/dma/sh/rz-dmac.c
+++ b/drivers/dma/sh/rz-dmac.c
@@ -79,8 +79,6 @@ struct rz_dmac_chan {
 	int mid_rid;
 
 	struct list_head ld_free;
-	struct list_head ld_queue;
-	struct list_head ld_active;
 
 	struct {
 		struct rz_lmdesc *base;
@@ -299,7 +297,6 @@ static void rz_dmac_enable_hw(struct rz_dmac_chan *channel)
 	struct rz_dmac *dmac = to_rz_dmac(chan->device);
 	u32 nxla;
 	u32 chctrl;
-	u32 chstat;
 
 	dev_dbg(dmac->dev, "%s channel %d\n", __func__, channel->index);
 
@@ -307,14 +304,11 @@ static void rz_dmac_enable_hw(struct rz_dmac_chan *channel)
 
 	nxla = rz_dmac_lmdesc_addr(channel, channel->lmdesc.head);
 
-	chstat = rz_dmac_ch_readl(channel, CHSTAT, 1);
-	if (!(chstat & CHSTAT_EN)) {
-		chctrl = (channel->chctrl | CHCTRL_SETEN);
-		rz_dmac_ch_writel(channel, nxla, NXLA, 1);
-		rz_dmac_ch_writel(channel, channel->chcfg, CHCFG, 1);
-		rz_dmac_ch_writel(channel, CHCTRL_SWRST, CHCTRL, 1);
-		rz_dmac_ch_writel(channel, chctrl, CHCTRL, 1);
-	}
+	chctrl = (channel->chctrl | CHCTRL_SETEN);
+	rz_dmac_ch_writel(channel, nxla, NXLA, 1);
+	rz_dmac_ch_writel(channel, channel->chcfg, CHCFG, 1);
+	rz_dmac_ch_writel(channel, CHCTRL_SWRST, CHCTRL, 1);
+	rz_dmac_ch_writel(channel, chctrl, CHCTRL, 1);
 }
 
 static void rz_dmac_disable_hw(struct rz_dmac_chan *channel)
@@ -426,18 +420,20 @@ static void rz_dmac_prepare_descs_for_slave_sg(struct rz_dmac_chan *channel)
 	channel->chctrl = CHCTRL_SETEN;
 }
 
-static int rz_dmac_xfer_desc(struct rz_dmac_chan *chan)
+static void rz_dmac_xfer_desc(struct rz_dmac_chan *chan)
 {
-	struct rz_dmac_desc *d = chan->desc;
 	struct virt_dma_desc *vd;
 
 	vd = vchan_next_desc(&chan->vc);
-	if (!vd)
-		return 0;
+	if (!vd) {
+		chan->desc = NULL;
+		return;
+	}
 
 	list_del(&vd->node);
+	chan->desc = to_rz_dmac_desc(vd);
 
-	switch (d->type) {
+	switch (chan->desc->type) {
 	case RZ_DMAC_DESC_MEMCPY:
 		rz_dmac_prepare_desc_for_memcpy(chan);
 		break;
@@ -445,14 +441,9 @@ static int rz_dmac_xfer_desc(struct rz_dmac_chan *chan)
 	case RZ_DMAC_DESC_SLAVE_SG:
 		rz_dmac_prepare_descs_for_slave_sg(chan);
 		break;
-
-	default:
-		return -EINVAL;
 	}
 
 	rz_dmac_enable_hw(chan);
-
-	return 0;
 }
 
 /*
@@ -494,8 +485,6 @@ static void rz_dmac_free_chan_resources(struct dma_chan *chan)
 	rz_lmdesc_setup(channel, channel->lmdesc.base);
 
 	rz_dmac_disable_hw(channel);
-	list_splice_tail_init(&channel->ld_active, &channel->ld_free);
-	list_splice_tail_init(&channel->ld_queue, &channel->ld_free);
 
 	if (channel->mid_rid >= 0) {
 		clear_bit(channel->mid_rid, dmac->modules);
@@ -504,13 +493,19 @@ static void rz_dmac_free_chan_resources(struct dma_chan *chan)
 
 	spin_unlock_irqrestore(&channel->vc.lock, flags);
 
+	vchan_free_chan_resources(&channel->vc);
+
+	spin_lock_irqsave(&channel->vc.lock, flags);
+
 	list_for_each_entry_safe(desc, _desc, &channel->ld_free, node) {
+		list_del(&desc->node);
 		kfree(desc);
 		channel->descs_allocated--;
 	}
 
 	INIT_LIST_HEAD(&channel->ld_free);
-	vchan_free_chan_resources(&channel->vc);
+
+	spin_unlock_irqrestore(&channel->vc.lock, flags);
 }
 
 static struct dma_async_tx_descriptor *
@@ -529,15 +524,15 @@ rz_dmac_prep_dma_memcpy(struct dma_chan *chan, dma_addr_t dest, dma_addr_t src,
 		if (!desc)
 			return NULL;
 
-		desc->type = RZ_DMAC_DESC_MEMCPY;
-		desc->src = src;
-		desc->dest = dest;
-		desc->len = len;
-		desc->direction = DMA_MEM_TO_MEM;
-
-		list_move_tail(channel->ld_free.next, &channel->ld_queue);
+		list_del(&desc->node);
 	}
 
+	desc->type = RZ_DMAC_DESC_MEMCPY;
+	desc->src = src;
+	desc->dest = dest;
+	desc->len = len;
+	desc->direction = DMA_MEM_TO_MEM;
+
 	return vchan_tx_prep(&channel->vc, &desc->vd, flags);
 }
 
@@ -558,22 +553,22 @@ rz_dmac_prep_slave_sg(struct dma_chan *chan, struct scatterlist *sgl,
 		if (!desc)
 			return NULL;
 
-		for_each_sg(sgl, sg, sg_len, i)
-			dma_length += sg_dma_len(sg);
+		list_del(&desc->node);
+	}
 
-		desc->type = RZ_DMAC_DESC_SLAVE_SG;
-		desc->sg = sgl;
-		desc->sgcount = sg_len;
-		desc->len = dma_length;
-		desc->direction = direction;
+	for_each_sg(sgl, sg, sg_len, i)
+		dma_length += sg_dma_len(sg);
 
-		if (direction == DMA_DEV_TO_MEM)
-			desc->src = channel->src_per_address;
-		else
-			desc->dest = channel->dst_per_address;
+	desc->type = RZ_DMAC_DESC_SLAVE_SG;
+	desc->sg = sgl;
+	desc->sgcount = sg_len;
+	desc->len = dma_length;
+	desc->direction = direction;
 
-		list_move_tail(channel->ld_free.next, &channel->ld_queue);
-	}
+	if (direction == DMA_DEV_TO_MEM)
+		desc->src = channel->src_per_address;
+	else
+		desc->dest = channel->dst_per_address;
 
 	return vchan_tx_prep(&channel->vc, &desc->vd, flags);
 }
@@ -588,8 +583,11 @@ static int rz_dmac_terminate_all(struct dma_chan *chan)
 	rz_dmac_disable_hw(channel);
 	rz_lmdesc_setup(channel, channel->lmdesc.base);
 
-	list_splice_tail_init(&channel->ld_active, &channel->ld_free);
-	list_splice_tail_init(&channel->ld_queue, &channel->ld_free);
+	if (channel->desc) {
+		vchan_terminate_vdesc(&channel->desc->vd);
+		channel->desc = NULL;
+	}
+
 	vchan_get_all_descriptors(&channel->vc, &head);
 	spin_unlock_irqrestore(&channel->vc.lock, flags);
 	vchan_dma_desc_free_list(&channel->vc, &head);
@@ -600,25 +598,16 @@ static int rz_dmac_terminate_all(struct dma_chan *chan)
 static void rz_dmac_issue_pending(struct dma_chan *chan)
 {
 	struct rz_dmac_chan *channel = to_rz_dmac_chan(chan);
-	struct rz_dmac *dmac = to_rz_dmac(chan->device);
-	struct rz_dmac_desc *desc;
 	unsigned long flags;
 
 	spin_lock_irqsave(&channel->vc.lock, flags);
 
-	if (!list_empty(&channel->ld_queue)) {
-		desc = list_first_entry(&channel->ld_queue,
-					struct rz_dmac_desc, node);
-		channel->desc = desc;
-		if (vchan_issue_pending(&channel->vc)) {
-			if (rz_dmac_xfer_desc(channel) < 0)
-				dev_warn(dmac->dev, "ch: %d couldn't issue DMA xfer\n",
-					 channel->index);
-			else
-				list_move_tail(channel->ld_queue.next,
-					       &channel->ld_active);
-		}
-	}
+	/*
+	 * Issue the descriptor. If another transfer is already in progress, the
+	 * issued descriptor will be handled after the current transfer finishes.
+	 */
+	if (vchan_issue_pending(&channel->vc) && !channel->desc)
+		rz_dmac_xfer_desc(channel);
 
 	spin_unlock_irqrestore(&channel->vc.lock, flags);
 }
@@ -676,13 +665,13 @@ static int rz_dmac_config(struct dma_chan *chan,
 
 static void rz_dmac_virt_desc_free(struct virt_dma_desc *vd)
 {
-	/*
-	 * Place holder
-	 * Descriptor allocation is done during alloc_chan_resources and
-	 * get freed during free_chan_resources.
-	 * list is used to manage the descriptors and avoid any memory
-	 * allocation/free during DMA read/write.
-	 */
+	struct rz_dmac_chan *channel = to_rz_dmac_chan(vd->tx.chan);
+	struct virt_dma_chan *vc = to_virt_chan(vd->tx.chan);
+	struct rz_dmac_desc *desc = to_rz_dmac_desc(vd);
+
+	guard(spinlock_irqsave)(&vc->lock);
+
+	list_add_tail(&desc->node, &channel->ld_free);
 }
 
 static void rz_dmac_device_synchronize(struct dma_chan *chan)
@@ -692,6 +681,8 @@ static void rz_dmac_device_synchronize(struct dma_chan *chan)
 	u32 chstat;
 	int ret;
 
+	vchan_synchronize(&channel->vc);
+
 	ret = read_poll_timeout(rz_dmac_ch_readl, chstat, !(chstat & CHSTAT_EN),
 				100, 100000, false, channel, CHSTAT, 1);
 	if (ret < 0)
@@ -739,58 +730,22 @@ static u32 rz_dmac_calculate_residue_bytes_in_vd(struct rz_dmac_chan *channel,
 static u32 rz_dmac_chan_get_residue(struct rz_dmac_chan *channel,
 				    dma_cookie_t cookie)
 {
-	struct rz_dmac_desc *current_desc, *desc;
-	enum dma_status status;
+	struct rz_dmac_desc *desc = NULL;
+	struct virt_dma_desc *vd;
 	u32 crla, crtb, i;
 
-	/* Get current processing virtual descriptor */
-	current_desc = list_first_entry_or_null(&channel->ld_active,
-						struct rz_dmac_desc, node);
-	if (!current_desc)
-		return 0;
-
-	/*
-	 * If the cookie corresponds to a descriptor that has been completed
-	 * there is no residue. The same check has already been performed by the
-	 * caller but without holding the channel lock, so the descriptor could
-	 * now be complete.
-	 */
-	status = dma_cookie_status(&channel->vc.chan, cookie, NULL);
-	if (status == DMA_COMPLETE)
-		return 0;
-
-	/*
-	 * If the cookie doesn't correspond to the currently processing virtual
-	 * descriptor then the descriptor hasn't been processed yet, and the
-	 * residue is equal to the full descriptor size. Also, a client driver
-	 * is possible to call this function before rz_dmac_irq_handler_thread()
-	 * runs. In this case, the running descriptor will be the next
-	 * descriptor, and will appear in the done list. So, if the argument
-	 * cookie matches the done list's cookie, we can assume the residue is
-	 * zero.
-	 */
-	if (cookie != current_desc->vd.tx.cookie) {
-		list_for_each_entry(desc, &channel->ld_free, node) {
-			if (cookie == desc->vd.tx.cookie)
-				return 0;
-		}
-
-		list_for_each_entry(desc, &channel->ld_queue, node) {
-			if (cookie == desc->vd.tx.cookie)
-				return desc->len;
-		}
-
-		list_for_each_entry(desc, &channel->ld_active, node) {
-			if (cookie == desc->vd.tx.cookie)
-				return desc->len;
-		}
+	vd = vchan_find_desc(&channel->vc, cookie);
+	if (vd) {
+		/* Descriptor has been issued but not yet processed. */
+		desc = to_rz_dmac_desc(vd);
+		return desc->len;
+	} else if (channel->desc && channel->desc->vd.tx.cookie == cookie) {
+		/* Descriptor is currently processed. */
+		desc = channel->desc;
+	}
 
-		/*
-		 * No descriptor found for the cookie, there's thus no residue.
-		 * This shouldn't happen if the calling driver passes a correct
-		 * cookie value.
-		 */
-		WARN(1, "No descriptor for cookie!");
+	if (!desc) {
+		/* Descriptor was not found. May be already completed by now. */
 		return 0;
 	}
 
@@ -813,7 +768,7 @@ static u32 rz_dmac_chan_get_residue(struct rz_dmac_chan *channel,
 	 * Calculate number of bytes transferred in processing virtual descriptor.
 	 * One virtual descriptor can have many lmdesc.
 	 */
-	return crtb + rz_dmac_calculate_residue_bytes_in_vd(channel, current_desc, crla);
+	return crtb + rz_dmac_calculate_residue_bytes_in_vd(channel, desc, crla);
 }
 
 static enum dma_status rz_dmac_tx_status(struct dma_chan *chan,
@@ -824,21 +779,17 @@ static enum dma_status rz_dmac_tx_status(struct dma_chan *chan,
 	enum dma_status status;
 	u32 residue;
 
-	status = dma_cookie_status(chan, cookie, txstate);
-	if (status == DMA_COMPLETE || !txstate)
-		return status;
-
 	scoped_guard(spinlock_irqsave, &channel->vc.lock) {
+		status = dma_cookie_status(chan, cookie, txstate);
+		if (status == DMA_COMPLETE || !txstate)
+			return status;
+
 		residue = rz_dmac_chan_get_residue(channel, cookie);
 
-		if (rz_dmac_chan_is_paused(channel))
+		if (status == DMA_IN_PROGRESS && rz_dmac_chan_is_paused(channel))
 			status = DMA_PAUSED;
 	}
 
-	/* if there's no residue and no paused, the cookie is complete */
-	if (!residue && status != DMA_PAUSED)
-		return DMA_COMPLETE;
-
 	dma_set_residue(txstate, residue);
 
 	return status;
@@ -918,28 +869,18 @@ static irqreturn_t rz_dmac_irq_handler(int irq, void *dev_id)
 static irqreturn_t rz_dmac_irq_handler_thread(int irq, void *dev_id)
 {
 	struct rz_dmac_chan *channel = dev_id;
-	struct rz_dmac_desc *desc = NULL;
-	unsigned long flags;
+	struct rz_dmac_desc *desc;
 
-	spin_lock_irqsave(&channel->vc.lock, flags);
+	guard(spinlock_irqsave)(&channel->vc.lock);
 
-	if (list_empty(&channel->ld_active)) {
-		/* Someone might have called terminate all */
-		goto out;
-	}
+	desc = channel->desc;
+	if (!desc)
+		return IRQ_HANDLED;
 
-	desc = list_first_entry(&channel->ld_active, struct rz_dmac_desc, node);
 	vchan_cookie_complete(&desc->vd);
-	list_move_tail(channel->ld_active.next, &channel->ld_free);
-	if (!list_empty(&channel->ld_queue)) {
-		desc = list_first_entry(&channel->ld_queue, struct rz_dmac_desc,
-					node);
-		channel->desc = desc;
-		if (rz_dmac_xfer_desc(channel) == 0)
-			list_move_tail(channel->ld_queue.next, &channel->ld_active);
-	}
-out:
-	spin_unlock_irqrestore(&channel->vc.lock, flags);
+	channel->desc = NULL;
+
+	rz_dmac_xfer_desc(channel);
 
 	return IRQ_HANDLED;
 }
@@ -1021,9 +962,7 @@ static int rz_dmac_chan_probe(struct rz_dmac *dmac,
 
 	channel->vc.desc_free = rz_dmac_virt_desc_free;
 	vchan_init(&channel->vc, &dmac->engine);
-	INIT_LIST_HEAD(&channel->ld_queue);
 	INIT_LIST_HEAD(&channel->ld_free);
-	INIT_LIST_HEAD(&channel->ld_active);
 
 	/* Initialize register for each channel */
 	rz_dmac_disable_hw(channel);
-- 
2.43.0


