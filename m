Return-Path: <dmaengine+bounces-11963-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id kp1wK0tcRmqqRgsAu9opvQ
	(envelope-from <dmaengine+bounces-11963-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Thu, 02 Jul 2026 14:40:43 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 22A3E6F7BF5
	for <lists+dmaengine@lfdr.de>; Thu, 02 Jul 2026 14:40:43 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=bootlin.com header.s=dkim header.b="ttZeE/N1";
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-11963-lists+dmaengine=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="dmaengine+bounces-11963-lists+dmaengine=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=bootlin.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 26C8F305CAD4
	for <lists+dmaengine@lfdr.de>; Thu,  2 Jul 2026 12:34:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDB3848097B;
	Thu,  2 Jul 2026 12:34:39 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 804AA47DFB6;
	Thu,  2 Jul 2026 12:34:36 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782995679; cv=none; b=VxML7IOZVQ0rl12xWBintYffls5v7b+gcokPmIEXqb2lIANSTsJSVnaARWiSypMfSwgTPV3GE0182hIxIDtardT+npM4ZnDX4iAQAsPaKs3ZOO864hv0xCMKm8yLzNTOnttOu34U9LLNHaAGakrCtOKFrGpJtdo2NXbsd1eZPKY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782995679; c=relaxed/simple;
	bh=JBidQyToPgq/Heh6FBQEZB0gs8rurptz/JSX5ZuMLF0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=M16Log/OQyaWWULCt3oUfgeXp3Ak9HNhnAAYNSM20uySuc+U7QEFdE/8QnRoBJGn+1V+vO0VngvMUmBbQEkCkZDKSL0gbimOae6fWEvh0X1Ilh3CBTZ7fdqx2ODX7aVAywlNNZmppY7tFMud878+6Fth4yk+PWvIn8Du14AWR+k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=ttZeE/N1; arc=none smtp.client-ip=185.246.84.56
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 43A051A0DF0;
	Thu,  2 Jul 2026 12:34:35 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 11D915FF03;
	Thu,  2 Jul 2026 12:34:35 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id EA7AD104C954E;
	Thu,  2 Jul 2026 14:34:33 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1782995674; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=HUM3MhDA3LMO5Vhb5PmHnSmyWsfq2kjj/K5Qlgk4b2Q=;
	b=ttZeE/N1iFd7R6B0FQMP8KW8Y3QE7FpIHfG4mOuFcOQYnYjAgUR8vNGLTAf5s2G95nrljI
	OECkxnh2XyIsKLUvoXseagdsqlWNMQ2w1JIs3/+r6vEWFkOMmmzS2Rf4GMKYGACIFmuPbN
	+KjakvuWq7YVDWjgLP1tnL+hL16OyPaeV89cSfWSU5+2D8YJcWxrAzCcfT5U5ZCioGSQqZ
	YJeKFVmPD4j/HWxZdp3Rz6zjCsud0elgGT+S1NjrvhxRIoSjQNnH6ENmz0LPnTCEwVjVwz
	/e5/1bNTWkLADwqMylVw4Bl75xTgmW97FP9ao+2C/GqP7y5xdmiGbrAV2E+9rw==
From: =?utf-8?q?Beno=C3=AEt_Monin?= <benoit.monin@bootlin.com>
Date: Thu, 02 Jul 2026 14:34:24 +0200
Subject: [PATCH v5 1/2] dmaengine: fsl-edma: Implement
 device_prep_peripheral_dma_vec
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260702-fsl-edma-dyn-sg-v5-1-16787185be49@bootlin.com>
References: <20260702-fsl-edma-dyn-sg-v5-0-16787185be49@bootlin.com>
In-Reply-To: <20260702-fsl-edma-dyn-sg-v5-0-16787185be49@bootlin.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[bootlin.com:s=dkim];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[bootlin.com:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-11963-lists,dmaengine=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER(0.00)[benoit.monin@bootlin.com,dmaengine@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:Frank.Li@nxp.com,m:vkoul@kernel.org,m:thomas.petazzoni@bootlin.com,m:Frank.Li@kernel.org,m:imx@lists.linux.dev,m:dmaengine@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:benoit.monin@bootlin.com,s:lists@lfdr.de];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[benoit.monin@bootlin.com,dmaengine@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[dmaengine];
	TO_DN_SOME(0.00)[]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 22A3E6F7BF5

Add implementation of .device_prep_peripheral_dma_vec() callback to setup
a scatter/gather DMA transfer from an array of dma_vec structures. Setup
a cyclic transfer if the DMA_PREP_REPEAT flag is set.

Reviewed-by: Frank Li <Frank.Li@nxp.com>
Signed-off-by: Benoît Monin <benoit.monin@bootlin.com>
---
 drivers/dma/fsl-edma-common.c | 109 ++++++++++++++++++++++++++++++++++++++++++
 drivers/dma/fsl-edma-common.h |   4 ++
 drivers/dma/fsl-edma-main.c   |   2 +
 3 files changed, 115 insertions(+)

diff --git a/drivers/dma/fsl-edma-common.c b/drivers/dma/fsl-edma-common.c
index bb7531c456df..c10190164926 100644
--- a/drivers/dma/fsl-edma-common.c
+++ b/drivers/dma/fsl-edma-common.c
@@ -673,6 +673,115 @@ struct dma_async_tx_descriptor *fsl_edma_prep_dma_cyclic(
 	return vchan_tx_prep(&fsl_chan->vchan, &fsl_desc->vdesc, flags);
 }
 
+struct dma_async_tx_descriptor *
+fsl_edma_prep_peripheral_dma_vec(struct dma_chan *chan, const struct dma_vec *vecs,
+				 size_t nb, enum dma_transfer_direction direction,
+				 unsigned long flags)
+{
+	struct fsl_edma_chan *fsl_chan = to_fsl_edma_chan(chan);
+	dma_addr_t src_addr, dst_addr, last_sg;
+	struct fsl_edma_desc *fsl_desc;
+	u16 soff, doff, iter;
+	u32 nbytes;
+	int i;
+
+	if (!is_slave_direction(direction))
+		return NULL;
+
+	if (!fsl_edma_prep_slave_dma(fsl_chan, direction))
+		return NULL;
+
+	fsl_desc = fsl_edma_alloc_desc(fsl_chan, nb);
+	if (!fsl_desc)
+		return NULL;
+	fsl_desc->iscyclic = flags & DMA_PREP_REPEAT;
+	fsl_desc->dirn = direction;
+
+	if (direction == DMA_MEM_TO_DEV) {
+		if (!fsl_chan->cfg.src_addr_width)
+			fsl_chan->cfg.src_addr_width = fsl_chan->cfg.dst_addr_width;
+		fsl_chan->attr =
+			fsl_edma_get_tcd_attr(fsl_chan->cfg.src_addr_width,
+					      fsl_chan->cfg.dst_addr_width);
+		nbytes = fsl_chan->cfg.dst_addr_width * fsl_chan->cfg.dst_maxburst;
+	} else {
+		if (!fsl_chan->cfg.dst_addr_width)
+			fsl_chan->cfg.dst_addr_width = fsl_chan->cfg.src_addr_width;
+		fsl_chan->attr =
+			fsl_edma_get_tcd_attr(fsl_chan->cfg.src_addr_width,
+					      fsl_chan->cfg.dst_addr_width);
+		nbytes = fsl_chan->cfg.src_addr_width * fsl_chan->cfg.src_maxburst;
+	}
+
+	for (i = 0; i < nb; i++) {
+		if (direction == DMA_MEM_TO_DEV) {
+			src_addr = vecs[i].addr;
+			dst_addr = fsl_chan->dma_dev_addr;
+			soff = fsl_chan->cfg.dst_addr_width;
+			doff = 0;
+		} else if (direction == DMA_DEV_TO_MEM) {
+			src_addr = fsl_chan->dma_dev_addr;
+			dst_addr = vecs[i].addr;
+			soff = 0;
+			doff = fsl_chan->cfg.src_addr_width;
+		} else {
+			/* DMA_DEV_TO_DEV */
+			src_addr = fsl_chan->cfg.src_addr;
+			dst_addr = fsl_chan->cfg.dst_addr;
+			soff = 0;
+			doff = 0;
+		}
+
+		/*
+		 * Choose the suitable burst length if dma_vec length is not
+		 * multiple of burst length so that the whole transfer length is
+		 * multiple of minor loop(burst length).
+		 */
+		if (vecs[i].len % nbytes) {
+			u32 width = (direction == DMA_DEV_TO_MEM) ? doff : soff;
+			u32 burst = (direction == DMA_DEV_TO_MEM) ?
+						fsl_chan->cfg.src_maxburst :
+						fsl_chan->cfg.dst_maxburst;
+			int j;
+
+			for (j = burst; j > 1; j--) {
+				if (!(vecs[i].len % (j * width))) {
+					nbytes = j * width;
+					break;
+				}
+			}
+			/* Set burst size as 1 if there's no suitable one */
+			if (j == 1)
+				nbytes = width;
+		}
+
+		iter = vecs[i].len / nbytes;
+		if (i < nb - 1) {
+			last_sg = fsl_desc->tcd[(i + 1)].ptcd;
+			fsl_edma_fill_tcd(fsl_chan, fsl_desc->tcd[i].vtcd, src_addr,
+					  dst_addr, fsl_chan->attr, soff,
+					  nbytes, 0, iter, iter, doff, last_sg,
+					  false, false, true);
+		} else {
+			if (fsl_desc->iscyclic) {
+				last_sg = fsl_desc->tcd[0].ptcd;
+				fsl_edma_fill_tcd(fsl_chan, fsl_desc->tcd[i].vtcd, src_addr,
+						  dst_addr, fsl_chan->attr, soff,
+						  nbytes, 0, iter, iter, doff, last_sg,
+						  true, false, true);
+			} else {
+				last_sg = 0;
+				fsl_edma_fill_tcd(fsl_chan, fsl_desc->tcd[i].vtcd, src_addr,
+						  dst_addr, fsl_chan->attr, soff,
+						  nbytes, 0, iter, iter, doff, last_sg,
+						  true, true, false);
+			}
+		}
+	}
+
+	return vchan_tx_prep(&fsl_chan->vchan, &fsl_desc->vdesc, flags);
+}
+
 struct dma_async_tx_descriptor *fsl_edma_prep_slave_sg(
 		struct dma_chan *chan, struct scatterlist *sgl,
 		unsigned int sg_len, enum dma_transfer_direction direction,
diff --git a/drivers/dma/fsl-edma-common.h b/drivers/dma/fsl-edma-common.h
index 205a96489094..0d028048701d 100644
--- a/drivers/dma/fsl-edma-common.h
+++ b/drivers/dma/fsl-edma-common.h
@@ -496,6 +496,10 @@ struct dma_async_tx_descriptor *fsl_edma_prep_dma_cyclic(
 		struct dma_chan *chan, dma_addr_t dma_addr, size_t buf_len,
 		size_t period_len, enum dma_transfer_direction direction,
 		unsigned long flags);
+struct dma_async_tx_descriptor *fsl_edma_prep_peripheral_dma_vec(
+		struct dma_chan *chan, const struct dma_vec *vecs,
+		size_t nb, enum dma_transfer_direction direction,
+		unsigned long flags);
 struct dma_async_tx_descriptor *fsl_edma_prep_slave_sg(
 		struct dma_chan *chan, struct scatterlist *sgl,
 		unsigned int sg_len, enum dma_transfer_direction direction,
diff --git a/drivers/dma/fsl-edma-main.c b/drivers/dma/fsl-edma-main.c
index 36155ab1602a..6693b4270a1a 100644
--- a/drivers/dma/fsl-edma-main.c
+++ b/drivers/dma/fsl-edma-main.c
@@ -841,6 +841,8 @@ static int fsl_edma_probe(struct platform_device *pdev)
 	fsl_edma->dma_dev.device_free_chan_resources
 		= fsl_edma_free_chan_resources;
 	fsl_edma->dma_dev.device_tx_status = fsl_edma_tx_status;
+	fsl_edma->dma_dev.device_prep_peripheral_dma_vec
+		= fsl_edma_prep_peripheral_dma_vec;
 	fsl_edma->dma_dev.device_prep_slave_sg = fsl_edma_prep_slave_sg;
 	fsl_edma->dma_dev.device_prep_dma_cyclic = fsl_edma_prep_dma_cyclic;
 	fsl_edma->dma_dev.device_prep_dma_memcpy = fsl_edma_prep_memcpy;

-- 
2.54.0


