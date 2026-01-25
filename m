Return-Path: <dmaengine+bounces-8474-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KJP9LeZ3dWnDFQEAu9opvQ
	(envelope-from <dmaengine+bounces-8474-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Sun, 25 Jan 2026 02:54:46 +0100
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B76E7F778
	for <lists+dmaengine@lfdr.de>; Sun, 25 Jan 2026 02:54:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DA97530166CD
	for <lists+dmaengine@lfdr.de>; Sun, 25 Jan 2026 01:54:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DC0119C556;
	Sun, 25 Jan 2026 01:54:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SRqvmVtd"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAA421DE8BB
	for <dmaengine@vger.kernel.org>; Sun, 25 Jan 2026 01:54:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769306058; cv=none; b=EltxZxoduBbpShyzuOQif9yq+4QcD+wlNFwwDnRYRkR0YODr/kqqDy+ozAgXNSSOyOlLNvwMj/T3PwHKZJJeZQkM8QeJeEYd5DraDreO+aO7AgQ60MiVQbBfb81hTHyBcf3vFws1aZsCgbmhtWvGh8pnYx50LwrcUWVNd/YcI5A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769306058; c=relaxed/simple;
	bh=IAtnArcPG5Mo3wR/ak9dhw3GaRCMzAm0TM32/grqYXs=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=U7xlZ59X8NEB/n1gkfsTtPOVUV/HDnpJDHUTzFbYHB44LLPhoM+XXMNzQMSfyGgHzvP3gk65LRM3F4b61AmOUYr9fqAxbJcTUG1QiTXICnwO1+tRAl1Mlcc15S1aDDKIhKRnuUEprSMylcKEtK17bvcvdXn+spDcHC/JCItq5Ew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SRqvmVtd; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-35305538592so3302154a91.0
        for <dmaengine@vger.kernel.org>; Sat, 24 Jan 2026 17:54:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769306056; x=1769910856; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zlerafEI2eGWpN000VkvDNNc/zFObhZpClSrdtY5Luc=;
        b=SRqvmVtdVnwQUdOoWHZr7AiS063jM7GjKsYzkIigJ9w0r8D6wopjJwPqIhs+ToTtZA
         TZkOp94PKXZ+/itz2IZHXHJF1HwtmxzQerc1WQixhbFmfgs5ZAMOl7t9vpAzcSBPsefC
         4DYXi15df29ex25QraDTPSEce+AFga6qwkle3dG8y9QFhSN4nwcWyK1E17HjtY/uubKr
         hc45jxKZ5rjNQHJRZgTCUTNph0KA3w2Iq0mA5uox7TSVSLfLDUWQIDqpyBjaZzIY1Kiv
         BJJwLqRxfdMRi3JV5kn1BT8WA3rXl6cc/LixoSgmlK6Y7c190ZsFq41M8kCSo6GjmwGe
         zCzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769306056; x=1769910856;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=zlerafEI2eGWpN000VkvDNNc/zFObhZpClSrdtY5Luc=;
        b=XBxERBkL+EYeztlvjYnEKCNeRmVqrqJk4L/Y3dJf/u32Phoi5DAWXE4cRycM5Fq2+a
         X4viTMgDKi7+sxV5uhX8e5i8L2L4FmKxlUjq0FZuHF9Vvc/G5+ZAPkDXktQu3Wq+5gF4
         VI/ZonithmIdwtn7yONvlKpnotQvsyF/d0MbMNUje7vBolbyPWqM0BlIbzxcnmOemYDM
         TjDAt4B5GSSAU+OrRqChsczsJxANumpRE2/UA7C1sqy8Etjbyk1rPkvWFiOh9DSMs7uV
         yVreUWnTPaTxpNaf7s0/TaDf5gCzSIANQlyRk3yW/BrHeTgHIKeI4Ax+T5MPiTdNr2Io
         QDng==
X-Forwarded-Encrypted: i=1; AJvYcCW8dMT4jYADRVfltDUtb4hpZUiaakrNaNnmTYVxGLBZJmsYAaS1AP7VufJRpt8meqDxiIj/QiMERAs=@vger.kernel.org
X-Gm-Message-State: AOJu0YybFYkSMbxnd9K468WMb4et945y5srtFm41nYuQ3+FEAqpeF8Tb
	5lkvczn4+rsi/EwXFknO0CSM0hYRNHqQkoVNBsrM6sFdcsvp6yRi+ZzK
X-Gm-Gg: AZuq6aKWj99wspp2Voy3H1ivU8HUTtlssodo4Tv8c4o5goT32NaVbSmb2QqeV4qw0CV
	Jz0ch411cnz2jKUSjw2GMP5wbOGVeK0pDa7cYn74N9KQDTd8JMM3LUu5dmHkt8Sjy3nX5jT5vjg
	/aV4Dkj7cASGkGXK0RDxlgJnA6uXSul3Jkuw1IHX0N1JAzZRGbfpq7zw2Fm6vcJJJzSDc5a0eny
	cOcTUK2hLP23wnzRkq/VZ2EAWtcww7Tzx6fGg9+iu4Ptwp/PUB+7YGjN4hxSlZuLVG1ukP4XdEx
	F1brg2PkZ0dsQ+/I35SADfAEt7MNhRb6NXHSiwEVYlpVVNUoDDyUfLIx+aD3/kJItA7iioaSoX5
	3ON7f7a6zfSlrjDTU0scq3xpc+BCSgQ20esM5kCNF0lIpnU0d/Q7ubl4m5te+CK3NLVcRHi6ZMF
	R8NuKeFNkAU/L+jN4CfOZymZ9MB9tUk8KJU3c=
X-Received: by 2002:a17:90a:c107:b0:34c:2db6:578f with SMTP id 98e67ed59e1d1-353c416261dmr451262a91.19.1769306056147;
        Sat, 24 Jan 2026 17:54:16 -0800 (PST)
Received: from localhost.localdomain ([60.51.11.72])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3536b0300fcsm2689584a91.1.2026.01.24.17.54.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 24 Jan 2026 17:54:14 -0800 (PST)
From: Khairul Anuar Romli <karom.9560@gmail.com>
To: Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>,
	Vinod Koul <vkoul@kernel.org>,
	dmaengine@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Khairul Anuar Romli <karom.9560@gmail.com>
Subject: [PATCH v4 1/3] dmaengine: dw-axi-dmac: fix Alignment should match open parenthesis
Date: Sun, 25 Jan 2026 09:54:05 +0800
Message-ID: <20260125015407.10544-2-karom.9560@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260125015407.10544-1-karom.9560@gmail.com>
References: <20260125015407.10544-1-karom.9560@gmail.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FREEMAIL_TO(0.00)[synopsys.com,kernel.org,vger.kernel.org,gmail.com];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-8474-lists,dmaengine=lfdr.de];
	FREEMAIL_FROM(0.00)[gmail.com];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	PRECEDENCE_BULK(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	FROM_NEQ_ENVFROM(0.00)[karom9560@gmail.com,dmaengine@vger.kernel.org];
	TAGGED_RCPT(0.00)[dmaengine];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 4B76E7F778
X-Rspamd-Action: no action

Correct alignment issues so that continuation lines properly match the
position of the opening parenthesis.

The fix applies to code introduced in:
- 'commit 1fe20f1b8454 ("dmaengine: Introduce DW AXI DMAC driver")'
- 'commit e32634f466a9 ("dma: dw-axi-dmac: support per channel
   interrupt")'

Signed-off-by: Khairul Anuar Romli <karom.9560@gmail.com>
---
 drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c b/drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c
index 493c2a32b0fe..8bb97fb8fd4c 100644
--- a/drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c
+++ b/drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c
@@ -342,8 +342,8 @@ static void axi_desc_put(struct axi_dma_desc *desc)
 	kfree(desc);
 	atomic_sub(descs_put, &chan->descs_allocated);
 	dev_vdbg(chan2dev(chan), "%s: %d descs put, %d still allocated\n",
-		axi_chan_name(chan), descs_put,
-		atomic_read(&chan->descs_allocated));
+		 axi_chan_name(chan), descs_put,
+		 atomic_read(&chan->descs_allocated));
 }
 
 static void vchan_desc_put(struct virt_dma_desc *vdesc)
@@ -353,7 +353,7 @@ static void vchan_desc_put(struct virt_dma_desc *vdesc)
 
 static enum dma_status
 dma_chan_tx_status(struct dma_chan *dchan, dma_cookie_t cookie,
-		  struct dma_tx_state *txstate)
+		   struct dma_tx_state *txstate)
 {
 	struct axi_dma_chan *chan = dchan_to_axi_dma_chan(dchan);
 	struct virt_dma_desc *vdesc;
@@ -491,7 +491,7 @@ static void axi_chan_start_first_queued(struct axi_dma_chan *chan)
 
 	desc = vd_to_axi_desc(vd);
 	dev_vdbg(chan2dev(chan), "%s: started %u\n", axi_chan_name(chan),
-		vd->tx.cookie);
+		 vd->tx.cookie);
 	axi_chan_block_xfer_start(chan, desc);
 }
 
@@ -1162,7 +1162,7 @@ static irqreturn_t dw_axi_dma_interrupt(int irq, void *dev_id)
 		axi_chan_irq_clear(chan, status);
 
 		dev_vdbg(chip->dev, "%s %u IRQ status: 0x%08x\n",
-			axi_chan_name(chan), i, status);
+			 axi_chan_name(chan), i, status);
 
 		if (status & DWAXIDMAC_IRQ_ALL_ERR)
 			axi_chan_handle_err(chan, status);
@@ -1451,7 +1451,7 @@ static int axi_req_irqs(struct platform_device *pdev, struct axi_dma_chip *chip)
 		if (chip->irq[i] < 0)
 			return chip->irq[i];
 		ret = devm_request_irq(chip->dev, chip->irq[i], dw_axi_dma_interrupt,
-				IRQF_SHARED, KBUILD_MODNAME, chip);
+				       IRQF_SHARED, KBUILD_MODNAME, chip);
 		if (ret < 0)
 			return ret;
 	}
@@ -1645,7 +1645,7 @@ static void dw_remove(struct platform_device *pdev)
 	of_dma_controller_free(chip->dev->of_node);
 
 	list_for_each_entry_safe(chan, _chan, &dw->dma.channels,
-			vc.chan.device_node) {
+				 vc.chan.device_node) {
 		list_del(&chan->vc.chan.device_node);
 		tasklet_kill(&chan->vc.task);
 	}
-- 
2.43.0


