Return-Path: <dmaengine+bounces-8537-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OOz6On3LeGnBtQEAu9opvQ
	(envelope-from <dmaengine+bounces-8537-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Tue, 27 Jan 2026 15:28:13 +0100
X-Original-To: lists+dmaengine@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id AD2AD95A5D
	for <lists+dmaengine@lfdr.de>; Tue, 27 Jan 2026 15:28:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D6837301981F
	for <lists+dmaengine@lfdr.de>; Tue, 27 Jan 2026 14:27:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5DD235B14C;
	Tue, 27 Jan 2026 14:27:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IUC1yEVX"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5782334F47D
	for <dmaengine@vger.kernel.org>; Tue, 27 Jan 2026 14:27:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769524065; cv=none; b=f8/sDrCWNrUsnx9e3kTscgLi80qzBnh1vRKHakmJrOPZT5y2s2IQ7rtNdWI1+HQZ/7GezlR16NQe/kLa8t3ZXJbVlUYcHi6k9JndzU5C1j8Sxm50o5U/M1Dr+mBzeddQteefo4YULqAGr1dRSUATjhDJGqpa9NO+2waM6UjvD2A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769524065; c=relaxed/simple;
	bh=D9QQEcZLcY6Oi3B4wcpkDjmCFBlIhllqHVwREsq4KI8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=c3TIx8+fNIhfXUAsEZbmbS2laNAaQWC3lemt/vMkXm0TiRPZbGWZCHsmmEk41t2KWB7h3fEveM7+8VznK2w/Ln8T4X++Acxclaa3zvxR7H8166zuO5zU8Wqd0BQyTsWbYAYV0ljV2GEUvXkse/Sa2EKJPMjr9xrxXa9Fd2Rucqs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IUC1yEVX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 0CF4CC2BCAF;
	Tue, 27 Jan 2026 14:27:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769524065;
	bh=D9QQEcZLcY6Oi3B4wcpkDjmCFBlIhllqHVwREsq4KI8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=IUC1yEVX69ZzyMX1esm8C+Io5KhDG/bRulkJFsvnckD6Eqhqb8yACM2wi7TNGZvnz
	 vIT/0baWx+aM8JKAxe9mA1mN53144XjI1Jenbo0z77842ltIQZHrkIcFCfKegBy7hf
	 5Pzpb6TVbmO8qAVBRYyU59Uw6AUXm7c7DjqRxnnh6j4o8OemmKVsHAtEXN1ffEWFA6
	 FA6jzAT7ywW4g6ZOU3/hrjQQslThuotMGEvmgRdvKxG3zIWUW9YcLaTXidMg2oksOD
	 MAWWMc1U03CXQfMUK9LsZomrSG1eLzbPFlju6+QPYObQfwwG4QUSRyeLiW2EQxyzfb
	 M4C2DbeEQdapg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3844D2F037;
	Tue, 27 Jan 2026 14:27:44 +0000 (UTC)
From: =?utf-8?q?Nuno_S=C3=A1_via_B4_Relay?= <devnull+nuno.sa.analog.com@kernel.org>
Date: Tue, 27 Jan 2026 14:28:26 +0000
Subject: [PATCH 5/5] dma: dma-axi-dmac: gracefully terminate HW cyclic
 transfers
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260127-axi-dac-cyclic-support-v1-5-b32daca4b3c7@analog.com>
References: <20260127-axi-dac-cyclic-support-v1-0-b32daca4b3c7@analog.com>
In-Reply-To: <20260127-axi-dac-cyclic-support-v1-0-b32daca4b3c7@analog.com>
To: dmaengine@vger.kernel.org
Cc: Lars-Peter Clausen <lars@metafoo.de>, Vinod Koul <vkoul@kernel.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1769524107; l=7718;
 i=nuno.sa@analog.com; s=20231116; h=from:subject:message-id;
 bh=8CEZSa4VL7GZn2O+RmMjKDO10v/9d1ku83V4UCm+pKI=;
 b=R7nSjQ1Wc/JvnkwO8lnXbspuAu3UOpmCmDtnqd9OlHNjKI/aiSUyR2/vthLZ6s2AUWsfnUEPx
 fc57CS0VQcyAHHjoaju49Tx4UfBpFeeFGAZo6l9sRaB0FgHmqY9lilh
X-Developer-Key: i=nuno.sa@analog.com; a=ed25519;
 pk=3NQwYA013OUYZsmDFBf8rmyyr5iQlxV/9H4/Df83o1E=
X-Endpoint-Received: by B4 Relay for nuno.sa@analog.com/20231116 with
 auth_id=100
X-Original-From: =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>
Reply-To: nuno.sa@analog.com
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-8537-lists,dmaengine=lfdr.de,nuno.sa.analog.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[devnull@kernel.org,dmaengine@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[dmaengine];
	HAS_REPLYTO(0.00)[nuno.sa@analog.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,analog.com:replyto,analog.com:email,analog.com:mid]
X-Rspamd-Queue-Id: AD2AD95A5D
X-Rspamd-Action: no action

From: Nuno Sá <nuno.sa@analog.com>

Add support for gracefully terminating hardware cyclic DMA transfers when
a new transfer is queued and is flagged with DMA_PREP_LOAD_EOT. Without
this, cyclic transfers would continue indefinitely until we brute force
it with .device_terminate_all().

When a new descriptor is queued while a cyclic transfer is active, mark
the cyclic transfer for termination. For hardware with scatter-gather
support, modify the last segment flags to trigger end-of-transfer. For
non-SG hardware, clear the CYCLIC flag to allow natural completion.

Older IP core versions (pre-4.6.a) can prefetch data when clearing the
CYCLIC flag, causing corruption in the next transfer. Work around this
by disabling and re-enabling the core to flush prefetched data.

The cyclic_eot flag tracks transfers marked for termination, preventing
new transfers from starting until the cyclic one completes. Non-EOT
transfers submitted after cyclic transfers are discarded with a warning.

Also note that for hardware cyclic transfers not using SG, we need to
make sure that chan->next_desc is also set to NULL (so we can look at
possible EOT transfers) and we also need to move the queue check to
after axi_dmac_get_next_desc() because with hardware based cyclic
transfers we might get the queue marked as full and hence we would not
be able to check for cyclic termination.

Signed-off-by: Nuno Sá <nuno.sa@analog.com>
---
 drivers/dma/dma-axi-dmac.c | 104 +++++++++++++++++++++++++++++++++++++++------
 1 file changed, 91 insertions(+), 13 deletions(-)

diff --git a/drivers/dma/dma-axi-dmac.c b/drivers/dma/dma-axi-dmac.c
index 638625647152..731fa59dc3e7 100644
--- a/drivers/dma/dma-axi-dmac.c
+++ b/drivers/dma/dma-axi-dmac.c
@@ -134,6 +134,7 @@ struct axi_dmac_desc {
 	struct axi_dmac_chan *chan;
 
 	bool cyclic;
+	bool cyclic_eot;
 	bool have_partial_xfer;
 
 	unsigned int num_submitted;
@@ -162,6 +163,7 @@ struct axi_dmac_chan {
 	bool hw_cyclic;
 	bool hw_2d;
 	bool hw_sg;
+	bool hw_cyclic_hotfix;
 };
 
 struct axi_dmac {
@@ -227,11 +229,26 @@ static bool axi_dmac_check_addr(struct axi_dmac_chan *chan, dma_addr_t addr)
 	return true;
 }
 
+static struct axi_dmac_desc *axi_dmac_active_desc(struct axi_dmac_chan *chan)
+{
+	return list_first_entry_or_null(&chan->active_descs,
+					struct axi_dmac_desc, vdesc.node);
+}
+
 static struct axi_dmac_desc *axi_dmac_get_next_desc(struct axi_dmac *dmac,
 						    struct axi_dmac_chan *chan)
 {
+	struct axi_dmac_desc *active = axi_dmac_active_desc(chan);
 	struct virt_dma_desc *vdesc;
 	struct axi_dmac_desc *desc;
+	unsigned int val;
+
+	/*
+	 * Just play safe and ignore any SOF if we have an active cyclic transfer
+	 * flagged to end. We'll start it as soon as the current cyclic one ends.
+	 */
+	if (active && active->cyclic_eot)
+		return NULL;
 
 	/*
 	 * It means a SW cyclic transfer is in place so we should just return
@@ -245,11 +262,43 @@ static struct axi_dmac_desc *axi_dmac_get_next_desc(struct axi_dmac *dmac,
 	if (!vdesc)
 		return NULL;
 
+	if (active && active->cyclic && !(vdesc->tx.flags & DMA_PREP_LOAD_EOT)) {
+		struct device *dev = chan_to_axi_dmac(chan)->dma_dev.dev;
+
+		dev_warn(dev, "Discarding non EOT transfer after cyclic\n");
+		list_del(&vdesc->node);
+		return NULL;
+	}
+
 	list_move_tail(&vdesc->node, &chan->active_descs);
 	desc = to_axi_dmac_desc(vdesc);
 	chan->next_desc = desc;
 
-	return desc;
+	if (!active || !active->cyclic)
+		return desc;
+
+	active->cyclic_eot = true;
+
+	if (chan->hw_sg) {
+		unsigned long flags = AXI_DMAC_HW_FLAG_IRQ | AXI_DMAC_HW_FLAG_LAST;
+		/*
+		 * Let's then stop the current cyclic transfer by making sure we
+		 * get an EOT interrupt and to open the cyclic loop by marking
+		 * the last segment.
+		 */
+		active->sg[active->num_sgs - 1].hw->flags = flags;
+		return NULL;
+	}
+
+	/*
+	 * Clear the cyclic bit if there's no Scatter-Gather HW so that we get
+	 * at the end of the transfer.
+	 */
+	val = axi_dmac_read(dmac, AXI_DMAC_REG_FLAGS);
+	val &= ~AXI_DMAC_FLAG_CYCLIC;
+	axi_dmac_write(dmac, AXI_DMAC_REG_FLAGS, val);
+
+	return NULL;
 }
 
 static void axi_dmac_start_transfer(struct axi_dmac_chan *chan)
@@ -260,14 +309,14 @@ static void axi_dmac_start_transfer(struct axi_dmac_chan *chan)
 	unsigned int flags = 0;
 	unsigned int val;
 
-	val = axi_dmac_read(dmac, AXI_DMAC_REG_START_TRANSFER);
-	if (val) /* Queue is full, wait for the next SOT IRQ */
-		return;
-
 	desc = axi_dmac_get_next_desc(dmac, chan);
 	if (!desc)
 		return;
 
+	val = axi_dmac_read(dmac, AXI_DMAC_REG_START_TRANSFER);
+	if (val) /* Queue is full, wait for the next SOT IRQ */
+		return;
+
 	sg = &desc->sg[desc->num_submitted];
 
 	/* Already queued in cyclic mode. Wait for it to finish */
@@ -309,10 +358,12 @@ static void axi_dmac_start_transfer(struct axi_dmac_chan *chan)
 	 * call, enable hw cyclic mode to avoid unnecessary interrupts.
 	 */
 	if (chan->hw_cyclic && desc->cyclic && !desc->vdesc.tx.callback) {
-		if (chan->hw_sg)
+		if (chan->hw_sg) {
 			desc->sg[desc->num_sgs - 1].hw->flags &= ~AXI_DMAC_HW_FLAG_IRQ;
-		else if (desc->num_sgs == 1)
+		} else if (desc->num_sgs == 1) {
+			chan->next_desc = NULL;
 			flags |= AXI_DMAC_FLAG_CYCLIC;
+		}
 	}
 
 	if (chan->hw_partial_xfer)
@@ -330,12 +381,6 @@ static void axi_dmac_start_transfer(struct axi_dmac_chan *chan)
 	axi_dmac_write(dmac, AXI_DMAC_REG_START_TRANSFER, 1);
 }
 
-static struct axi_dmac_desc *axi_dmac_active_desc(struct axi_dmac_chan *chan)
-{
-	return list_first_entry_or_null(&chan->active_descs,
-		struct axi_dmac_desc, vdesc.node);
-}
-
 static inline unsigned int axi_dmac_total_sg_bytes(struct axi_dmac_chan *chan,
 	struct axi_dmac_sg *sg)
 {
@@ -425,6 +470,35 @@ static bool axi_dmac_handle_cyclic_eot(struct axi_dmac_chan *chan,
 	/* wrap around */
 	active->num_completed = 0;
 
+	if (active->cyclic_eot) {
+		/*
+		 * It means an HW cyclic transfer was marked to stop. And we
+		 * know we have something to schedule, so start the next
+		 * transfer now the cyclic one is done.
+		 */
+		list_del(&active->vdesc.node);
+		vchan_cookie_complete(&active->vdesc);
+
+		if (chan->hw_cyclic_hotfix) {
+			struct axi_dmac *dmac = chan_to_axi_dmac(chan);
+			/*
+			 * In older IP cores, ending a cyclic transfer by clearing
+			 * the CYCLIC flag does not guarantee a graceful end.
+			 * It can happen that some data (of the next frame) is
+			 * already prefetched and will be wrongly visible in the
+			 * next transfer. To workaround this, we need to reenable
+			 * the core so everything is flushed. Newer cores handles
+			 * this correctly and do not require this "hotfix". The
+			 * SG IP also does not require this.
+			 */
+			dev_dbg(dev, "HW cyclic hotfix\n");
+			axi_dmac_write(dmac, AXI_DMAC_REG_CTRL, 0);
+			axi_dmac_write(dmac, AXI_DMAC_REG_CTRL, AXI_DMAC_CTRL_ENABLE);
+		}
+
+		return true;
+	}
+
 	vdesc = vchan_next_desc(&chan->vchan);
 	if (!vdesc)
 		return false;
@@ -460,6 +534,7 @@ static bool axi_dmac_transfer_done(struct axi_dmac_chan *chan,
 	if (chan->hw_sg) {
 		if (active->cyclic) {
 			vchan_cyclic_callback(&active->vdesc);
+			start_next = axi_dmac_handle_cyclic_eot(chan, active);
 		} else {
 			list_del(&active->vdesc.node);
 			vchan_cookie_complete(&active->vdesc);
@@ -1103,6 +1178,9 @@ static int axi_dmac_detect_caps(struct axi_dmac *dmac, unsigned int version)
 		chan->length_align_mask = chan->address_align_mask;
 	}
 
+	if (version < ADI_AXI_PCORE_VER(4, 6, 'a') && !chan->hw_sg)
+		chan->hw_cyclic_hotfix = true;
+
 	return 0;
 }
 

-- 
2.52.0



