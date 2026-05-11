Return-Path: <dmaengine+bounces-10292-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2FRLBa/hAWrklwEAu9opvQ
	(envelope-from <dmaengine+bounces-10292-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Mon, 11 May 2026 16:03:27 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A8DBB50F961
	for <lists+dmaengine@lfdr.de>; Mon, 11 May 2026 16:03:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E0EE9304A67C
	for <lists+dmaengine@lfdr.de>; Mon, 11 May 2026 13:58:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE8583FE644;
	Mon, 11 May 2026 13:57:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="ZEiFWH4s"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B63FC3FBED1;
	Mon, 11 May 2026 13:57:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.171.202.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778507862; cv=none; b=fpxIKVTd3hUj/7OPuwbOT49YZ9ak/2wnduedshNrkUn2s7x0+zN9AX3qMfP4J1dlrjNwOQqlqsAoU5yDKtEzTF3UqL33bvrMGs3ll/Lqa/lUjMqUeVUUKKuH9A8syUKnCqdGb5EilbsEJ90sIwf3baqc+MPSM9ttS4CR+yRBSv4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778507862; c=relaxed/simple;
	bh=zC2ID6l8GFBR4BwqI17VFWdO/ilVRuNe2iMT31YrZko=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=m/7K0tE9iPBufQ5GrParACHA+b/a3aDTbmwrkaCXnxbTOO9bgqOM2BDTfudYDGcT13sFEtLtl4Zcv8ZgYaLYjHJJrnt/EKxg1sLhU+1JdxtZiziGFF4qVE0JW4iAH3Ox6e8EpKi6GLWdcmN5sJSzB3+SMfmolKzL5a+zqK8PFic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=ZEiFWH4s; arc=none smtp.client-ip=185.171.202.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id 26E58C5E157;
	Mon, 11 May 2026 13:58:17 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 9882160646;
	Mon, 11 May 2026 13:57:27 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 64ED311AF9DE3;
	Mon, 11 May 2026 15:57:26 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1778507847; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=DZJQYNOuRsWLR9PD9/2j37j4WivCD7wFTOz83ku666g=;
	b=ZEiFWH4sHQTRT8m8N0k6tThuYFmm0q66cxYnIe0fLpPnouwdbJnDAuavG3MTjQugQ9ppSp
	Ov7RLdPyVbS0vnAny26t1jEYoxtA11zFEMNTU/Jh8QlwiL+H4KEXA8Yx2KZCJKYYeoLQmt
	lAtgrjHhr7H1FZfan0OahLmN+BnuF0hj6Wkbj3EnBJxE9XWRPqQBM4EWMUhP46GHTQVL+T
	YcITbEtQeGVFoezm8FyDzjIzevDDjdXDCzsTd8FF1xDdOSOmGc2L5zGeHq9wJgmLQBzvgM
	77kt4R5jH1jAVZvSGfQGllfcBxK1qX2glgZvCV1wBmBdySdQLZZMRxPSdPPCJg==
From: =?utf-8?q?Beno=C3=AEt_Monin?= <benoit.monin@bootlin.com>
Date: Mon, 11 May 2026 15:57:20 +0200
Subject: [PATCH v3 2/2] dmaengine: fsl-edma: Support dynamic scatter/gather
 chaining
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260511-fsl-edma-dyn-sg-v3-2-98a181775dae@bootlin.com>
References: <20260511-fsl-edma-dyn-sg-v3-0-98a181775dae@bootlin.com>
In-Reply-To: <20260511-fsl-edma-dyn-sg-v3-0-98a181775dae@bootlin.com>
To: Frank Li <Frank.Li@nxp.com>, Vinod Koul <vkoul@kernel.org>
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 Frank Li <Frank.Li@kernel.org>, imx@lists.linux.dev, 
 dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org, 
 =?utf-8?q?Beno=C3=AEt_Monin?= <benoit.monin@bootlin.com>
X-Mailer: b4 0.15.2
X-Last-TLS-Session-Version: TLSv1.3
X-Rspamd-Queue-Id: A8DBB50F961
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[bootlin.com,reject];
	R_DKIM_ALLOW(-0.20)[bootlin.com:s=dkim];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[bootlin.com:+];
	TAGGED_FROM(0.00)[bounces-10292-lists,dmaengine=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[benoit.monin@bootlin.com,dmaengine@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[8];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[dmaengine];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,bootlin.com:email,bootlin.com:mid,bootlin.com:dkim]
X-Rspamd-Action: no action

Implement dynamic linking of scatter/gather transfers to enable
chaining multiple DMA descriptors without stopping the channel.
This avoids waiting for the channel to go idle if there is another
transaction already issued.

Add fsl_edma_link_sg() to dynamically link the last TCD of a previously
submitted descriptor to the first TCD of a new descriptor by setting
the scatter/gather address and the E_SG flag, and keeping the channel
active by clearing the DREQ bit.

Linking is done when the transaction is submitted by fsl_edma_tx_submit().
To do so, the .tx_submit() callback is overridden for non-cyclic
transactions prepared by fsl_edma_prep_peripheral_dma_vec() and
fsl_edma_prep_slave_sg(). This ensures that transactions are linked
in the order they are submitted.

Update fsl_edma_xfer_desc() to avoid re-initializing the hardware when a
transfer is already in progress, allowing seamless chaining of descriptors.

Modify the transfer completion handler to check the DONE flag in the
channel CSR before marking the transfer complete. Since this flag is
only available on SoC with the split registers layout, we only link
transactions for DMA controllers flagged with FSL_EDMA_DRV_SPLIT_REG.

Add trace event for scatter/gather linking operations.

Signed-off-by: Benoît Monin <benoit.monin@bootlin.com>
---
 drivers/dma/fsl-edma-common.c | 90 +++++++++++++++++++++++++++++++++++++++----
 drivers/dma/fsl-edma-trace.h  |  5 +++
 2 files changed, 88 insertions(+), 7 deletions(-)

diff --git a/drivers/dma/fsl-edma-common.c b/drivers/dma/fsl-edma-common.c
index c10190164926..b83d1b91dca2 100644
--- a/drivers/dma/fsl-edma-common.c
+++ b/drivers/dma/fsl-edma-common.c
@@ -58,7 +58,10 @@ void fsl_edma_tx_chan_handler(struct fsl_edma_chan *fsl_chan)
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
@@ -673,6 +676,68 @@ struct dma_async_tx_descriptor *fsl_edma_prep_dma_cyclic(
 	return vchan_tx_prep(&fsl_chan->vchan, &fsl_desc->vdesc, flags);
 }
 
+static void fsl_edma_link_sg(struct fsl_edma_chan *fsl_chan, struct fsl_edma_desc *fsl_desc)
+{
+	u32 flags = fsl_edma_drvflags(fsl_chan);
+	struct fsl_edma_hw_tcd *last_tcd;
+	struct fsl_edma_desc *prev_desc;
+	struct virt_dma_desc *vdesc;
+	u16 csr;
+
+	lockdep_assert_held(&fsl_chan->vchan.lock);
+
+	if (!(flags & FSL_EDMA_DRV_SPLIT_REG))
+		return;
+
+	vdesc = list_last_entry_or_null(&fsl_chan->vchan.desc_issued,
+					struct virt_dma_desc, node);
+	if (!vdesc)
+		vdesc = list_last_entry_or_null(&fsl_chan->vchan.desc_submitted,
+						struct virt_dma_desc, node);
+	if (!vdesc)
+		return;
+
+	prev_desc = to_fsl_edma_desc(vdesc);
+	last_tcd = prev_desc->tcd[prev_desc->n_tcds - 1].vtcd;
+
+	csr = fsl_edma_get_tcd_to_cpu(fsl_chan, last_tcd, csr);
+	if (!(csr & EDMA_TCD_CSR_D_REQ))
+		return;
+
+	fsl_edma_set_tcd_to_le(fsl_chan, last_tcd, fsl_desc->tcd[0].ptcd, dlast_sga);
+
+	csr &= ~EDMA_TCD_CSR_D_REQ;
+	csr |= EDMA_TCD_CSR_E_SG;
+	fsl_edma_set_tcd_to_le(fsl_chan, last_tcd, csr, csr);
+
+	if (prev_desc == fsl_chan->edesc && prev_desc->n_tcds == 1) {
+		if (flags & FSL_EDMA_DRV_CLEAR_DONE_E_SG)
+			edma_writel_chreg(fsl_chan, edma_readl_chreg(fsl_chan, ch_csr), ch_csr);
+
+		edma_cp_tcd_to_reg(fsl_chan, last_tcd, dlast_sga);
+		edma_cp_tcd_to_reg(fsl_chan, last_tcd, csr);
+	}
+
+	trace_edma_link_sg(fsl_chan, last_tcd);
+}
+
+static dma_cookie_t fsl_edma_tx_submit(struct dma_async_tx_descriptor *tx)
+{
+	struct virt_dma_desc *vd = container_of(tx, struct virt_dma_desc, tx);
+	struct fsl_edma_chan *fsl_chan = to_fsl_edma_chan(tx->chan);
+	struct fsl_edma_desc *fsl_desc = to_fsl_edma_desc(vd);
+	struct virt_dma_chan *vc = to_virt_chan(tx->chan);
+	dma_cookie_t cookie;
+
+	guard(spinlock_irqsave)(&fsl_chan->vchan.lock);
+
+	fsl_edma_link_sg(fsl_chan, fsl_desc);
+	cookie = dma_cookie_assign(tx);
+	list_move_tail(&vd->node, &vc->desc_submitted);
+
+	return cookie;
+}
+
 struct dma_async_tx_descriptor *
 fsl_edma_prep_peripheral_dma_vec(struct dma_chan *chan, const struct dma_vec *vecs,
 				 size_t nb, enum dma_transfer_direction direction,
@@ -680,6 +745,7 @@ fsl_edma_prep_peripheral_dma_vec(struct dma_chan *chan, const struct dma_vec *ve
 {
 	struct fsl_edma_chan *fsl_chan = to_fsl_edma_chan(chan);
 	dma_addr_t src_addr, dst_addr, last_sg;
+	struct dma_async_tx_descriptor *tx;
 	struct fsl_edma_desc *fsl_desc;
 	u16 soff, doff, iter;
 	u32 nbytes;
@@ -779,7 +845,10 @@ fsl_edma_prep_peripheral_dma_vec(struct dma_chan *chan, const struct dma_vec *ve
 		}
 	}
 
-	return vchan_tx_prep(&fsl_chan->vchan, &fsl_desc->vdesc, flags);
+	tx = vchan_tx_prep(&fsl_chan->vchan, &fsl_desc->vdesc, flags);
+	if (!fsl_desc->iscyclic)
+		tx->tx_submit = fsl_edma_tx_submit;
+	return tx;
 }
 
 struct dma_async_tx_descriptor *fsl_edma_prep_slave_sg(
@@ -788,9 +857,10 @@ struct dma_async_tx_descriptor *fsl_edma_prep_slave_sg(
 		unsigned long flags, void *context)
 {
 	struct fsl_edma_chan *fsl_chan = to_fsl_edma_chan(chan);
+	dma_addr_t src_addr, dst_addr, last_sg;
+	struct dma_async_tx_descriptor *tx;
 	struct fsl_edma_desc *fsl_desc;
 	struct scatterlist *sg;
-	dma_addr_t src_addr, dst_addr, last_sg;
 	u16 soff, doff, iter;
 	u32 nbytes;
 	int i;
@@ -882,7 +952,10 @@ struct dma_async_tx_descriptor *fsl_edma_prep_slave_sg(
 		}
 	}
 
-	return vchan_tx_prep(&fsl_chan->vchan, &fsl_desc->vdesc, flags);
+	tx = vchan_tx_prep(&fsl_chan->vchan, &fsl_desc->vdesc, flags);
+	tx->tx_submit = fsl_edma_tx_submit;
+
+	return tx;
 }
 
 struct dma_async_tx_descriptor *fsl_edma_prep_memcpy(struct dma_chan *chan,
@@ -924,9 +997,12 @@ void fsl_edma_xfer_desc(struct fsl_edma_chan *fsl_chan)
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
 }
 
 void fsl_edma_issue_pending(struct dma_chan *chan)
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


