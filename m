Return-Path: <dmaengine+bounces-8992-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kPscDNq5mGkdLgMAu9opvQ
	(envelope-from <dmaengine+bounces-8992-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Fri, 20 Feb 2026 20:45:30 +0100
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id CE46716A6ED
	for <lists+dmaengine@lfdr.de>; Fri, 20 Feb 2026 20:45:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 59C5530A67AC
	for <lists+dmaengine@lfdr.de>; Fri, 20 Feb 2026 19:44:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3C06366DD7;
	Fri, 20 Feb 2026 19:44:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="BLLu/lq1"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F87C368264
	for <dmaengine@vger.kernel.org>; Fri, 20 Feb 2026 19:44:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771616663; cv=none; b=a7UT2f9ybPpdQvPU/tkIsKq32FVer9Y0+V+AX1EfTqXretWaIykCJuvqXbeMEKiVBsus75lPDx3PudnfxHW0wV2HrnELJbHfpJDkj+8p5uwsIL0maOwH4FIaXjoTVsBQWq4a541nARVtbvDMLiw1Cdi0XF9ql/Mxk6e5QTS5owM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771616663; c=relaxed/simple;
	bh=b/XfJRil1bwdPvFvx3l1pKzJDaN4pUj1HhV7xdp0NrE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=AYrOlj3vNzCGI623F607YJ9EWqGagiNpihPK2OtWdQHop+fSUznCeq/0HeiV78IOQXgUpA0YhcXWmPbUtuAzKWpfAb42U3zOSXDZG7vfbnE3gcVakAaCdCwi5DtdSH7QH3LMT+Tx6hg06zRkGOrhIvd1YE75cXSKCBN7LmaVaSA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com; spf=pass smtp.mailfrom=sifive.com; dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b=BLLu/lq1; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-483a233819aso20590125e9.3
        for <dmaengine@vger.kernel.org>; Fri, 20 Feb 2026 11:44:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1771616660; x=1772221460; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=05/VV/lDFeba9RsGotT90a0/zpwPMFfBoAx0Ofiw31M=;
        b=BLLu/lq11cOIO1/CWJW0dBnro+bZ1hEk0GKN07S7guoC6LqDI0H8g2lW7nPhwD+hJu
         wIS8Nhb+b0/jI/R1v1WQjCJTi8fDoEpj7gm3cy3cyA1npRFnrHg73vG2G4N85B7rBm0W
         khMBCgub9NkJWjK9y3zGOGEm1FaCZMf5fR1+FeLPQtmYfuMENp12Hmkka70pq4U5wLpE
         75BWRmE3oM+4IaF7HTATRo5PnwhsqfZXHBHtS88pG+36Ni1RI64H5s7ar4HAn9uQ6vRi
         wqHLHg1j0x+8I8iMIfXdKEKi6izfsxnHrOzc7w+lYr9yr1lPtqlWirSavETSZ2yQsIvQ
         3b8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771616660; x=1772221460;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=05/VV/lDFeba9RsGotT90a0/zpwPMFfBoAx0Ofiw31M=;
        b=jIchkLptRCjwSWRNP63298NbwpHU2v6gGmgAkFdAQacRAI9x2qwwXo/ln2YK45Fmmy
         HA8dH8cueUi1BRMKLaeZw8SSuH6dqc+BBwkEAXTSjNeU40RpMMkfzBjAvxi3+SQvYZJr
         kVY8wYpx92ZxQNpE/tvaUSFCb3HwZVZ+NQ5DlO3nkgqOiVpD16zqkAmJGZxrp2/3oLK3
         plptcwadxDBogHmHtS/NRpxqI/yk86uyiSvZ29/KS5q6YDinQlSwyAhHIGhWwU4agG+E
         5SeuaA10veOqyHKEcBNbdxV/PLwz0i8hthb6Ou/7zsf4kIfn5DgsyEMjG/f4MU5W/3ZU
         SaqA==
X-Forwarded-Encrypted: i=1; AJvYcCV2fr+pAEa7hZs8kixhUT73wbOF1TcEbXX8djT/ej0XOjxlz/tn88ppTZ7ANvTMg6SEjYPG7pNe5U0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyBSTNw2mqHN5ypoVjyJHpFe06O/6REsHAQOFqqLDrbIUs+kEjt
	vO23fBaiuT783shDME01qo36MIWGaR2HuMyMJ+FIHTRc26c35Q5gAYj8qZxqfhORvBQ=
X-Gm-Gg: AZuq6aIvS1LKmpm+jDI69204T+SquUMmL7HNOloSWBuoq/f1nYmeNSS7nODqGySHElV
	gDt44VTHyy0fP9fXo0I1Aaci6ef+06Qp/nuUlfqKP1zESbPQOhNExe9SSdf1BBTR0sF8R0/Ekxm
	m8nBAZpwWXrFUrd9slHMa++6QzCLt0ruISRa59eVG12VXtL2KkFGCcTcUKiSXzt0T5kpn+LPrFe
	5w5lyqBZt1uSrpNRRwOOO7fTlest2bs19ppDJZM30sJwCgS4VeGBD/LqQTwaQpFqfOuPT/sexCE
	lnKzvA9sE1aLBqupRr0Bc/cNmYHe8/U5Nf3wDRHtQBJ4H/3htNIlik8iz9OnrP5wN+HRK4wKfAs
	vvzmfp9Gi1AnAJ8BK+96kUtf79H2QLd96VJsYmH+zELrlkhjRBxUsimLoIPuej3dxDOyPln+o4H
	QxTPfr4CHny97rwVS/zIJs
X-Received: by 2002:a05:600c:c166:b0:483:8e67:e696 with SMTP id 5b1f17b1804b1-483a96088eamr11896155e9.15.1771616659825;
        Fri, 20 Feb 2026 11:44:19 -0800 (PST)
Received: from [127.0.1.1] ([210.176.154.34])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-483a3e1b7ccsm24460755e9.11.2026.02.20.11.44.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Feb 2026 11:44:19 -0800 (PST)
From: Max Hsu <max.hsu@sifive.com>
Date: Sat, 21 Feb 2026 03:43:55 +0800
Subject: [PATCH 3/5] dmaengine: sf-pdma: fix NULL pointer dereference in
 error and done handlers
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260221-pdma-v1-3-838d929c2326@sifive.com>
References: <20260221-pdma-v1-0-838d929c2326@sifive.com>
In-Reply-To: <20260221-pdma-v1-0-838d929c2326@sifive.com>
To: Paul Walmsley <pjw@kernel.org>, 
 Samuel Holland <samuel.holland@sifive.com>, Vinod Koul <vkoul@kernel.org>, 
 Frank Li <Frank.Li@kernel.org>, Green Wan <green.wan@sifive.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Palmer Debbelt <palmer@sifive.com>, 
 Conor Dooley <conor@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>, 
 Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>
Cc: linux-riscv@lists.infradead.org, dmaengine@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Paul Walmsley <paul.walmsley@sifive.com>, 
 devicetree@vger.kernel.org, Max Hsu <max.hsu@sifive.com>, 
 stable@vger.kernel.org
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=3639; i=max.hsu@sifive.com;
 h=from:subject:message-id; bh=b/XfJRil1bwdPvFvx3l1pKzJDaN4pUj1HhV7xdp0NrE=;
 b=owEB7QES/pANAwAKAdID/Z0HeUC9AcsmYgBpmLl7qrlEpbzWDbGuky8nT6UzW0f5jVL+Hu/hW
 iVRTh9Ulb6JAbMEAAEKAB0WIQTqXmcbOhS2KZE9X2jSA/2dB3lAvQUCaZi5ewAKCRDSA/2dB3lA
 vY8NDACxy2OOvQk82FLF/6ENDUqR0VUXpYS61hwdKKk9L4hmAEMmXjyP5/BovrqX3b+34yGCO05
 +Pkx4U3PqbxNcHs+NQHaYGZoZZ8FRdDJ4iS5eKtQiIO/m5VfQAVuI+azxBu5TrFzSePhwpJko0R
 7x0JinBtqmGUTEtA8X7egXlkbd0qkMFE36xltmi6n8LmQTuV65oTkl95SArBYzMVLt6tiQzaYws
 o+0l/9Dk2bKZjyhWc987UGgbyGnKrGm6HzmCJmJrVIRjfFpBhrUOQhhGtDsP3GKSxV2al+7TcuK
 O+p9CvhQ/XS0lmko1kSN8dbtrl81Q68hyRV2IcsvKE6AVig+7TjNsd1aLkF7HctRS26JTJ49cvk
 75uVdQud3BGkNbBqIK5wCcjszzKDqiZAC7Kl7ZINFj0wRrkHwfydyhmeXAy555xdjICf7YBgy91
 SWW/1txoOQT/KdooJP8as+lq8Jk5MIgZLfhRZH90rf1jzO3wRNmeNGc27YsfpRJ7l2tjs=
X-Developer-Key: i=max.hsu@sifive.com; a=openpgp;
 fpr=EA5E671B3A14B629913D5F68D203FD9D077940BD
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[sifive.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[sifive.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[20];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-8992-lists,dmaengine=lfdr.de];
	DKIM_TRACE(0.00)[sifive.com:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[max.hsu@sifive.com,dmaengine@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[dmaengine,dt];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,sifive.com:mid,sifive.com:dkim,sifive.com:email]
X-Rspamd-Queue-Id: CE46716A6ED
X-Rspamd-Action: no action

Fix NULL pointer dereferences in both the error and done tasklets that
can occur due to race conditions during channel termination or completion.

Both tasklets (sf_pdma_errbh_tasklet and sf_pdma_donebh_tasklet)
dereference chan->desc without checking if it's NULL. However,
chan->desc can be NULL in legitimate scenarios:

1. During sf_pdma_terminate_all(): The function sets chan->desc = NULL
   while holding vchan.lock, but interrupts for previously submitted
   transactions could fire after the lock is released, before the
   hardware is fully quiesced. These interrupts can schedule tasklets
   that will run with chan->desc = NULL.

2. During channel cleanup: Similar race condition during
   sf_pdma_free_chan_resources().

The fix adds NULL checks at the beginning of both tasklets, protected
by vchan.lock, using the same lock that terminate_all and
free_chan_resources use when setting chan->desc = NULL. This ensures
that either:
- The descriptor is valid and we can safely process it, or
- The descriptor was already freed and we safely skip processing

Fixes: 6973886ad58e ("dmaengine: sf-pdma: add platform DMA support for HiFive Unleashed A00")
Cc: stable@vger.kernel.org
Signed-off-by: Max Hsu <max.hsu@sifive.com>
---
 drivers/dma/sf-pdma/sf-pdma.c | 43 +++++++++++++++++++++++++++++++++----------
 1 file changed, 33 insertions(+), 10 deletions(-)

diff --git a/drivers/dma/sf-pdma/sf-pdma.c b/drivers/dma/sf-pdma/sf-pdma.c
index ac7d3b127a24..70e4afcda52a 100644
--- a/drivers/dma/sf-pdma/sf-pdma.c
+++ b/drivers/dma/sf-pdma/sf-pdma.c
@@ -298,33 +298,56 @@ static void sf_pdma_free_desc(struct virt_dma_desc *vdesc)
 static void sf_pdma_donebh_tasklet(struct tasklet_struct *t)
 {
 	struct sf_pdma_chan *chan = from_tasklet(chan, t, done_tasklet);
+	struct sf_pdma_desc *desc;
 	unsigned long flags;
 
-	spin_lock_irqsave(&chan->lock, flags);
-	if (chan->xfer_err) {
-		chan->retries = MAX_RETRY;
-		chan->status = DMA_COMPLETE;
-		chan->xfer_err = false;
+	spin_lock_irqsave(&chan->vchan.lock, flags);
+	desc = chan->desc;
+	if (!desc) {
+		/*
+		 * The descriptor was already freed (e.g., by terminate_all
+		 * or completion on another CPU). Nothing to do.
+		 */
+		spin_unlock_irqrestore(&chan->vchan.lock, flags);
+		return;
 	}
-	spin_unlock_irqrestore(&chan->lock, flags);
 
-	spin_lock_irqsave(&chan->vchan.lock, flags);
-	list_del(&chan->desc->vdesc.node);
-	vchan_cookie_complete(&chan->desc->vdesc);
+	list_del(&desc->vdesc.node);
+	vchan_cookie_complete(&desc->vdesc);
 
 	chan->desc = sf_pdma_get_first_pending_desc(chan);
 	if (chan->desc)
 		sf_pdma_xfer_desc(chan);
 
 	spin_unlock_irqrestore(&chan->vchan.lock, flags);
+
+	spin_lock_irqsave(&chan->lock, flags);
+	if (chan->xfer_err) {
+		chan->retries = MAX_RETRY;
+		chan->status = DMA_COMPLETE;
+		chan->xfer_err = false;
+	}
+	spin_unlock_irqrestore(&chan->lock, flags);
 }
 
 static void sf_pdma_errbh_tasklet(struct tasklet_struct *t)
 {
 	struct sf_pdma_chan *chan = from_tasklet(chan, t, err_tasklet);
-	struct sf_pdma_desc *desc = chan->desc;
+	struct sf_pdma_desc *desc;
 	unsigned long flags;
 
+	spin_lock_irqsave(&chan->vchan.lock, flags);
+	desc = chan->desc;
+	if (!desc) {
+		/*
+		 * The descriptor was already freed (e.g., by terminate_all
+		 * or completion on another CPU). Nothing to do.
+		 */
+		spin_unlock_irqrestore(&chan->vchan.lock, flags);
+		return;
+	}
+	spin_unlock_irqrestore(&chan->vchan.lock, flags);
+
 	spin_lock_irqsave(&chan->lock, flags);
 	if (chan->retries <= 0) {
 		/* fail to recover */

-- 
2.43.0


