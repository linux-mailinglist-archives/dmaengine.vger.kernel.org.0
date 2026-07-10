Return-Path: <dmaengine+bounces-12316-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id /9VdMK3hUGqD7AIAu9opvQ
	(envelope-from <dmaengine+bounces-12316-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Fri, 10 Jul 2026 14:12:29 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C48D73A96E
	for <lists+dmaengine@lfdr.de>; Fri, 10 Jul 2026 14:12:29 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=bootlin.com header.s=dkim header.b=nsh6W54V;
	dmarc=pass (policy=reject) header.from=bootlin.com;
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-12316-lists+dmaengine=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="dmaengine+bounces-12316-lists+dmaengine=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 766BD3022B1C
	for <lists+dmaengine@lfdr.de>; Fri, 10 Jul 2026 12:07:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 093143F5BCF;
	Fri, 10 Jul 2026 12:07:11 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 043AD3112A5
	for <dmaengine@vger.kernel.org>; Fri, 10 Jul 2026 12:07:08 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783685230; cv=none; b=rn3up9Ewe5vqnqkFBrkI3f6SBebvJVKB8E7Y4/iyVMWfXP4y81+zxC7xbuKxRablN/WYHheyVGG2Mq07XcfnaBeHiYzUCFc5nf5QmKSBpfZEXWaZY+QYseDZAWMf88yEklG9pqtBjqgk+YtqQg/dCbE9dDr+9+ei0cN3RhEdxGY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783685230; c=relaxed/simple;
	bh=1TGnEiaiPJRSnGMS3u3hurE8aJfozeqUA+ZB8a+EPyQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=UMuzyBqA3xlfXucDovrdTB1B4zKkdR8NR5fslijdDn+Rc/BnMJnWdVsof2ivfM/tSHQdsj1GApf1Jc4iA+MLjXLIls1eH0cQcJPlGqdE9zDfoAUMqD3b1nO3JRlGe2y+aGE0taqgylqvOVoPvPz45clhHDubi3YnnaUEWNE40N8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=nsh6W54V; arc=none smtp.client-ip=185.171.202.116
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id 6F1CCC2C642
	for <dmaengine@vger.kernel.org>; Fri, 10 Jul 2026 12:07:22 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 98A1960342;
	Fri, 10 Jul 2026 12:07:07 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id DCC8311BD0C3D;
	Fri, 10 Jul 2026 14:07:05 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1783685226; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=wEK3XB5VZhWeeheBkJA5rGOSCh6O6usVB1usCpOhd+8=;
	b=nsh6W54VqNVS00qUuogMtsECzv4UzcN1QXfctJcMazNFElLHWnYVADpvzezJG8yZ5URoxq
	6D40/bTZrTJsTGGpBhUmDTwfWFAIEyzaCn1RiiAFw8LCfqT/fur4WrjzXLzeWygoGx08sR
	ZCcthNnG/BZ59YIKKJKbZgdFcMZ09M2mti8x4zIA/cenu5HvhbUr2aZTPa62aj0wgZG1yn
	vbcSo8P4MtWa3afN7KDP9zcVh8a++s4au4GU5/XFDWL7AC5935Oni5FmDdXSERZZKiII1t
	fw1xELibYwAI8X/iNwqDrHGUFc1zbxVf+C6ngXadfC2tNGgQQa/V2KhWQjrZ0Q==
From: =?utf-8?q?Beno=C3=AEt_Monin?= <benoit.monin@bootlin.com>
Date: Fri, 10 Jul 2026 14:07:01 +0200
Subject: [PATCH v6 2/2] dmaengine: fsl-edma: Support dynamic scatter/gather
 chaining
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260710-fsl-edma-dyn-sg-v6-2-831b96be3f31@bootlin.com>
References: <20260710-fsl-edma-dyn-sg-v6-0-831b96be3f31@bootlin.com>
In-Reply-To: <20260710-fsl-edma-dyn-sg-v6-0-831b96be3f31@bootlin.com>
To: Frank Li <Frank.Li@nxp.com>, Vinod Koul <vkoul@kernel.org>
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 Frank Li <Frank.Li@kernel.org>, imx@lists.linux.dev, 
 dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org, 
 =?utf-8?q?Beno=C3=AEt_Monin?= <benoit.monin@bootlin.com>
X-Mailer: b4 0.15.2
X-Last-TLS-Session-Version: TLSv1.3
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[bootlin.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[bootlin.com:s=dkim];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-12316-lists,dmaengine=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:Frank.Li@nxp.com,m:vkoul@kernel.org,m:thomas.petazzoni@bootlin.com,m:Frank.Li@kernel.org,m:imx@lists.linux.dev,m:dmaengine@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:benoit.monin@bootlin.com,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[bootlin.com:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[benoit.monin@bootlin.com,dmaengine@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[benoit.monin@bootlin.com,dmaengine@vger.kernel.org];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[dmaengine];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,vger.kernel.org:from_smtp,bootlin.com:from_mime,bootlin.com:email,bootlin.com:mid,bootlin.com:dkim]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 9C48D73A96E

Implement dynamic linking of scatter/gather transfers to enable
chaining multiple DMA descriptors without stopping the channel.
This avoids waiting for the channel to go idle if there is another
transaction already issued.

Add fsl_edma_link_sg() to dynamically link the last TCD of a previously
submitted descriptor to the first TCD of a new descriptor by setting
the scatter/gather address and the E_SG flag, and keeping the channel
active by clearing the DREQ bit.

Also in fsl_edma_link_sg(), we assign an identifier to the new descriptor
that is stored in the EDMA_TCD_CSR_LINKCH field of the CSR of the
first TCD, after checking that the descriptors are not using channel
linking. The use of this field (MAJORLINKCH in the datasheet) as an
identifier for dynamic scatter/gather is suggested in the i.MX93 datasheet.

Linking is done in fsl_edma_issue_pending(), which iterates over the
submitted descriptors, links each one to the previously issued
descriptor via fsl_edma_link_sg(), and then moves it to the issued
list. This ensures that transactions are linked in the order they were
submitted. Linking of a descriptor is limited to MAX_LINK_SG (31)
outstanding descriptors on the issued list.

Update fsl_edma_xfer_desc() to avoid re-initializing the hardware when a
transfer is already in progress, allowing seamless chaining of descriptors.

Modify the transfer completion handler to check the DONE flag in the
channel CSR before marking the transfer complete. Since this flag is
only available on SoC with the split registers layout, we only link
transactions for DMA controllers flagged with FSL_EDMA_DRV_SPLIT_REG.

The completion handler also reaps issued descriptors whose link channel ID
(EDMA_TCD_CSR_LINKCH) has already been passed by the hardware, marking
them as completed even if their corresponding interrupt has been missed.

Add trace event for scatter/gather linking operations.

Signed-off-by: Benoît Monin <benoit.monin@bootlin.com>
---
 drivers/dma/fsl-edma-common.c | 98 ++++++++++++++++++++++++++++++++++++++++---
 drivers/dma/fsl-edma-common.h |  3 ++
 drivers/dma/fsl-edma-trace.h  |  5 +++
 3 files changed, 100 insertions(+), 6 deletions(-)

diff --git a/drivers/dma/fsl-edma-common.c b/drivers/dma/fsl-edma-common.c
index c10190164926..6cca5dca8d60 100644
--- a/drivers/dma/fsl-edma-common.c
+++ b/drivers/dma/fsl-edma-common.c
@@ -44,6 +44,9 @@
 #define EDMA64_ERRH		0x28
 #define EDMA64_ERRL		0x2c
 
+/* Maximum number of linked sg descriptors in issued state */
+#define MAX_LINK_SG		31
+
 void fsl_edma_tx_chan_handler(struct fsl_edma_chan *fsl_chan)
 {
 	spin_lock(&fsl_chan->vchan.lock);
@@ -58,11 +61,29 @@ void fsl_edma_tx_chan_handler(struct fsl_edma_chan *fsl_chan)
 		list_del(&fsl_chan->edesc->vdesc.node);
 		vchan_cookie_complete(&fsl_chan->edesc->vdesc);
 		fsl_chan->edesc = NULL;
-		fsl_chan->status = DMA_COMPLETE;
+		if (!(fsl_edma_drvflags(fsl_chan) & FSL_EDMA_DRV_SPLIT_REG) ||
+		    (edma_readl_chreg(fsl_chan, ch_csr) & EDMA_V3_CH_CSR_DONE)) {
+			fsl_chan->status = DMA_COMPLETE;
+		}
 	} else {
 		vchan_cyclic_callback(&fsl_chan->edesc->vdesc);
 	}
 
+	if (!fsl_chan->edesc && fsl_chan->status != DMA_COMPLETE) {
+		u8 link_sg_id = FIELD_GET(EDMA_TCD_CSR_LINKCH, edma_read_tcdreg(fsl_chan, csr));
+		struct virt_dma_desc *vdesc, *tmp;
+
+		list_for_each_entry_safe(vdesc, tmp, &fsl_chan->vchan.desc_issued, node) {
+			struct fsl_edma_desc *fsl_desc = to_fsl_edma_desc(vdesc);
+
+			if (link_sg_id == fsl_desc->link_sg_id)
+				break;
+
+			list_del(&vdesc->node);
+			vchan_cookie_complete(vdesc);
+		}
+	}
+
 	if (!fsl_chan->edesc)
 		fsl_edma_xfer_desc(fsl_chan);
 
@@ -788,9 +809,9 @@ struct dma_async_tx_descriptor *fsl_edma_prep_slave_sg(
 		unsigned long flags, void *context)
 {
 	struct fsl_edma_chan *fsl_chan = to_fsl_edma_chan(chan);
+	dma_addr_t src_addr, dst_addr, last_sg;
 	struct fsl_edma_desc *fsl_desc;
 	struct scatterlist *sg;
-	dma_addr_t src_addr, dst_addr, last_sg;
 	u16 soff, doff, iter;
 	u32 nbytes;
 	int i;
@@ -924,14 +945,74 @@ void fsl_edma_xfer_desc(struct fsl_edma_chan *fsl_chan)
 	if (!vdesc)
 		return;
 	fsl_chan->edesc = to_fsl_edma_desc(vdesc);
-	fsl_edma_set_tcd_regs(fsl_chan, fsl_chan->edesc->tcd[0].vtcd);
-	fsl_edma_enable_request(fsl_chan);
-	fsl_chan->status = DMA_IN_PROGRESS;
+
+	if (fsl_chan->status != DMA_IN_PROGRESS) {
+		fsl_edma_set_tcd_regs(fsl_chan, fsl_chan->edesc->tcd[0].vtcd);
+		fsl_edma_enable_request(fsl_chan);
+		fsl_chan->status = DMA_IN_PROGRESS;
+	}
+}
+
+static void fsl_edma_link_sg(struct fsl_edma_chan *fsl_chan, struct fsl_edma_desc *fsl_desc)
+{
+	u32 flags = fsl_edma_drvflags(fsl_chan);
+	struct fsl_edma_hw_tcd *first_tcd, *last_tcd;
+	struct fsl_edma_desc *prev_desc;
+	struct virt_dma_desc *vdesc;
+	u16 first_csr, last_csr;
+
+	lockdep_assert_held(&fsl_chan->vchan.lock);
+
+	if (!(flags & FSL_EDMA_DRV_SPLIT_REG) || fsl_desc->iscyclic)
+		return;
+
+	vdesc = list_last_entry_or_null(&fsl_chan->vchan.desc_issued,
+					struct virt_dma_desc, node);
+	if (!vdesc)
+		return;
+
+	prev_desc = to_fsl_edma_desc(vdesc);
+	if (prev_desc->iscyclic)
+		return;
+
+	first_tcd = fsl_desc->tcd[0].vtcd;
+	last_tcd = prev_desc->tcd[prev_desc->n_tcds - 1].vtcd;
+	first_csr = fsl_edma_get_tcd_to_cpu(fsl_chan, first_tcd, csr);
+	last_csr = fsl_edma_get_tcd_to_cpu(fsl_chan, last_tcd, csr);
+
+	if (!(last_csr & EDMA_TCD_CSR_D_REQ) ||
+	    last_csr & EDMA_TCD_CSR_E_LINK ||
+	    first_csr & EDMA_TCD_CSR_E_LINK ||
+	    list_count_nodes(&fsl_chan->vchan.desc_issued) >= MAX_LINK_SG)
+		return;
+
+	first_csr |= FIELD_PREP(EDMA_TCD_CSR_LINKCH, fsl_chan->link_sg_id++);
+	fsl_edma_set_tcd_to_le(fsl_chan, first_tcd, first_csr, csr);
+	fsl_desc->link_sg_id = FIELD_GET(EDMA_TCD_CSR_LINKCH, first_csr);
+
+	fsl_edma_set_tcd_to_le(fsl_chan, last_tcd, fsl_desc->tcd[0].ptcd, dlast_sga);
+
+	dma_wmb();
+
+	last_csr &= ~EDMA_TCD_CSR_D_REQ;
+	last_csr |= EDMA_TCD_CSR_E_SG;
+	fsl_edma_set_tcd_to_le(fsl_chan, last_tcd, last_csr, csr);
+
+	if (prev_desc == fsl_chan->edesc &&
+	    prev_desc->n_tcds == 1 &&
+	    !(flags & FSL_EDMA_DRV_CLEAR_DONE_E_SG)) {
+		edma_cp_tcd_to_reg(fsl_chan, last_tcd, dlast_sga);
+		edma_cp_tcd_to_reg(fsl_chan, last_tcd, csr);
+	}
+
+	trace_edma_link_sg(fsl_chan, last_tcd);
+	trace_edma_link_sg(fsl_chan, first_tcd);
 }
 
 void fsl_edma_issue_pending(struct dma_chan *chan)
 {
 	struct fsl_edma_chan *fsl_chan = to_fsl_edma_chan(chan);
+	struct virt_dma_desc *vdesc, *tmp;
 	unsigned long flags;
 
 	spin_lock_irqsave(&fsl_chan->vchan.lock, flags);
@@ -942,7 +1023,12 @@ void fsl_edma_issue_pending(struct dma_chan *chan)
 		return;
 	}
 
-	if (vchan_issue_pending(&fsl_chan->vchan) && !fsl_chan->edesc)
+	list_for_each_entry_safe(vdesc, tmp, &fsl_chan->vchan.desc_submitted, node) {
+		fsl_edma_link_sg(fsl_chan, to_fsl_edma_desc(vdesc));
+		list_move_tail(&vdesc->node, &fsl_chan->vchan.desc_issued);
+	}
+
+	if (!list_empty(&fsl_chan->vchan.desc_issued) && !fsl_chan->edesc)
 		fsl_edma_xfer_desc(fsl_chan);
 
 	spin_unlock_irqrestore(&fsl_chan->vchan.lock, flags);
diff --git a/drivers/dma/fsl-edma-common.h b/drivers/dma/fsl-edma-common.h
index 0d028048701d..ab7ec43f93cf 100644
--- a/drivers/dma/fsl-edma-common.h
+++ b/drivers/dma/fsl-edma-common.h
@@ -42,6 +42,7 @@
 #define EDMA_TCD_CSR_E_LINK		BIT(5)
 #define EDMA_TCD_CSR_ACTIVE		BIT(6)
 #define EDMA_TCD_CSR_DONE		BIT(7)
+#define EDMA_TCD_CSR_LINKCH		GENMASK(12, 8)
 
 #define EDMA_V3_TCD_NBYTES_MLOFF_NBYTES(x) ((x) & GENMASK(9, 0))
 #define EDMA_V3_TCD_NBYTES_MLOFF(x)        (x << 10)
@@ -169,6 +170,7 @@ struct fsl_edma_chan {
 	struct dma_slave_config		cfg;
 	u32				attr;
 	bool                            is_sw;
+	u8				link_sg_id;
 	struct dma_pool			*tcd_pool;
 	dma_addr_t			dma_dev_addr;
 	u32				dma_dev_size;
@@ -199,6 +201,7 @@ struct fsl_edma_desc {
 	struct virt_dma_desc		vdesc;
 	struct fsl_edma_chan		*echan;
 	bool				iscyclic;
+	u8				link_sg_id;
 	enum dma_transfer_direction	dirn;
 	unsigned int			n_tcds;
 	struct fsl_edma_sw_tcd		tcd[];
diff --git a/drivers/dma/fsl-edma-trace.h b/drivers/dma/fsl-edma-trace.h
index d3541301a247..ac319d2dbb90 100644
--- a/drivers/dma/fsl-edma-trace.h
+++ b/drivers/dma/fsl-edma-trace.h
@@ -119,6 +119,11 @@ DEFINE_EVENT(edma_log_tcd, edma_fill_tcd,
 	TP_ARGS(chan, tcd)
 );
 
+DEFINE_EVENT(edma_log_tcd, edma_link_sg,
+	     TP_PROTO(struct fsl_edma_chan *chan, void *tcd),
+	     TP_ARGS(chan, tcd)
+);
+
 #endif
 
 /* this part must be outside header guard */

-- 
2.54.0


