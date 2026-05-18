Return-Path: <dmaengine+bounces-10512-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mNHWKJ8JC2o0/gQAu9opvQ
	(envelope-from <dmaengine+bounces-10512-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Mon, 18 May 2026 14:44:15 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4887256CEBE
	for <lists+dmaengine@lfdr.de>; Mon, 18 May 2026 14:44:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 81E4D30473A6
	for <lists+dmaengine@lfdr.de>; Mon, 18 May 2026 12:36:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EDB7413D6A;
	Mon, 18 May 2026 12:36:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="2opEB9Ci"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE2E13F871F
	for <dmaengine@vger.kernel.org>; Mon, 18 May 2026 12:36:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779107815; cv=none; b=tfHuyXOz9nCsDBxvU8iDTclWTDYb1Uzm1fkfVaHE5I5PCjqqD+SJvmW59q39yuROgIM/dwZIXO9EQcIofHxeGaYIcssajobI8R7ZshgY0xGnk1HJ+F5uIZKVQuRcCg7vzu1byp2mjZ3XCyaj6Pgcr3vidA5tG+M9+j6Sfc2hOqY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779107815; c=relaxed/simple;
	bh=G7RMPyishAieeB8BYJsbiqtbGJJSNDe3OdP3a3YfKMA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=i6Hrzry6bysci7VzgHrFLNJ2WO+a6bbqCImeXaBfOfwgJaXSUY12c9ULBW3tatuaxWMY0Fb3hytr0o5JNeKF6m+WAMxWCL3vXfbQ1lrEA3r/wJ6SiI2Il5ZKDnCkDeQst2M0GvQ6YdHTtgXy76H6mohC2IDGgIvEyZ/O5p8hSzo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=2opEB9Ci; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 8F8161A3609;
	Mon, 18 May 2026 12:36:52 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 63D3F5FFA3;
	Mon, 18 May 2026 12:36:52 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 0C9C211AF8B33;
	Mon, 18 May 2026 14:36:51 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1779107811; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=fS5jED2APYID6ACtGXnR88TqQ9pgAD4ONbbk9HSWgmM=;
	b=2opEB9CiqtgfLj2wA73JbNFxid9Q1IS4772mMWybrumJib0vh//fq+1e2dkBn7Dm1ZaEUL
	hOeClOiJkfc/g4pJE/r4gaqN201xgC67FU78qJDzfPdEHmWfClw8f3Yp0JyaGqYQMVLRoq
	VQao6pXpKbl5momtsQjLnYdUqBcEIUhE0szEqE4cWKJkTLc7Vsso215EaNSLetepfagv7I
	FEJeTTRtI6TPw9OQ3ogmbIjZDQuDnPz6+sabL0rAO8G/2hcsVtitwENCfkRiWFH0/Xxl2a
	obH9SWE2vSVHkqAKxk24J6zi0/nRBiNFLnk/IJvHDRRBq8k+XN5q+yyxBHMUFA==
From: =?utf-8?q?Beno=C3=AEt_Monin?= <benoit.monin@bootlin.com>
Date: Mon, 18 May 2026 14:36:45 +0200
Subject: [PATCH v4 2/2] dmaengine: fsl-edma: Support dynamic scatter/gather
 chaining
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260518-fsl-edma-dyn-sg-v4-2-8ce7d95b1ce9@bootlin.com>
References: <20260518-fsl-edma-dyn-sg-v4-0-8ce7d95b1ce9@bootlin.com>
In-Reply-To: <20260518-fsl-edma-dyn-sg-v4-0-8ce7d95b1ce9@bootlin.com>
To: Frank Li <Frank.Li@nxp.com>, Vinod Koul <vkoul@kernel.org>
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 Frank Li <Frank.Li@kernel.org>, imx@lists.linux.dev, 
 dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org, 
 =?utf-8?q?Beno=C3=AEt_Monin?= <benoit.monin@bootlin.com>
X-Mailer: b4 0.15.2
X-Last-TLS-Session-Version: TLSv1.3
X-Rspamd-Queue-Id: 4887256CEBE
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[bootlin.com,reject];
	R_DKIM_ALLOW(-0.20)[bootlin.com:s=dkim];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[bootlin.com:+];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	TAGGED_FROM(0.00)[bounces-10512-lists,dmaengine=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[dmaengine];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[benoit.monin@bootlin.com,dmaengine@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_FIVE(0.00)[6];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[8];
	TO_DN_SOME(0.00)[]
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
index c10190164926..6e5820051f29 100644
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
+	vdesc = list_last_entry_or_null(&fsl_chan->vchan.desc_submitted,
+					struct virt_dma_desc, node);
+	if (!vdesc)
+		vdesc = list_last_entry_or_null(&fsl_chan->vchan.desc_issued,
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


