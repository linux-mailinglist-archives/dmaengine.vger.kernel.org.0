Return-Path: <dmaengine+bounces-11772-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id nU4dMNjuPGptuggAu9opvQ
	(envelope-from <dmaengine+bounces-11772-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Thu, 25 Jun 2026 11:03:20 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 37B0A6C40C6
	for <lists+dmaengine@lfdr.de>; Thu, 25 Jun 2026 11:03:20 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=yoseli.org header.s=gm1 header.b=OXKLXghz;
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-11772-lists+dmaengine=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="dmaengine+bounces-11772-lists+dmaengine=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=yoseli.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8417830470FE
	for <lists+dmaengine@lfdr.de>; Thu, 25 Jun 2026 08:59:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03EBA38888C;
	Thu, 25 Jun 2026 08:59:44 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 439A0387345;
	Thu, 25 Jun 2026 08:59:41 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782377983; cv=none; b=s5Or8YKNxkhN1+Ly51zJIXB+UsxnlkPSxkARCP3yBQDKsD/5567K+mXEJRZCkHB4VbZFKUhWvUIQz0ymxEIlkPMgEESJzgPnwsBxwKL3GBY9SYAi82jAKKYdzRrTetTTkfDAAYEneixYiE/kl9FGnmOv/bX3slnRZmSOHqpxen4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782377983; c=relaxed/simple;
	bh=e/2rnKpCeIVZssQggJLnbZXTCrHVAz/NPfW+nKRPin0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=b9MQ6ra9xHo0l9/sB64plgfvCnWDg69iK/WHD36t8MAhmmdSMyD63enFU1+rYZoA7NCqU4Q1rD5gfjpFXaqG5Z23L77UKq3amz1qXGPFt/aFduquqY9IHSKU/rqWusu4LaaheRVFCUzr8hH/vJLfkmFSjfwAx6jZGMl1p+STy10=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yoseli.org; spf=pass smtp.mailfrom=yoseli.org; dkim=pass (2048-bit key) header.d=yoseli.org header.i=@yoseli.org header.b=OXKLXghz; arc=none smtp.client-ip=217.70.183.197
Received: by mail.gandi.net (Postfix) with ESMTPSA id 175313EBBB;
	Thu, 25 Jun 2026 08:59:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yoseli.org; s=gm1;
	t=1782377980;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zEMsk8DLPdcsuda1vhWw6oSZHPS1DB/ks4bLgM5CJfo=;
	b=OXKLXghz9AAtkS9LVkwxumJ4UjaNv7Csi1xvRoaIu6kaGKGnA7CaMgRisdDKSDZVSwOMPf
	iFp1gFcL/KxzdTZW+iugikVForCYgLTTqffG6rxkUp8hi9SBGAm5G5950G8I0WDsbaHdUo
	NvRYXR9OhXwI6RPNFMkvYaovoBRL1UfvLWUZhz7qOeU/8Pz1zMSg7OrQ1ftZwGh7I6LkHF
	0uMB9T4zOx2pwPfNlk8fWkGjyWw1isCjj8d8AMeKgshzCn6JexnPLM7W2HttCGIfLV0hPd
	NzuStgT69HNjUIwQ3DFhsZDQZuLm+ugA0V3cpTM0P6vqBhyfMviESqGM/b5mbw==
From: Jean-Michel Hautbois <jeanmichel.hautbois@yoseli.org>
Date: Thu, 25 Jun 2026 10:59:37 +0200
Subject: [PATCH v3 1/5] dmaengine: fsl-edma: Move error handler out of
 header file
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260625-b4-edma-dmaengine-v3-1-44be00ace37d@yoseli.org>
References: <20260625-b4-edma-dmaengine-v3-0-44be00ace37d@yoseli.org>
In-Reply-To: <20260625-b4-edma-dmaengine-v3-0-44be00ace37d@yoseli.org>
To: Frank Li <Frank.Li@nxp.com>, Vinod Koul <vkoul@kernel.org>, 
 Angelo Dureghello <angelo@sysam.it>
Cc: Frank Li <Frank.Li@kernel.org>, imx@lists.linux.dev, 
 dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Jean-Michel Hautbois <jeanmichel.hautbois@yoseli.org>
X-Mailer: b4 0.15-dev-47773
X-Developer-Signature: v=1; a=ed25519-sha256; t=1782377978; l=1740;
 i=jeanmichel.hautbois@yoseli.org; s=20240925; h=from:subject:message-id;
 bh=e/2rnKpCeIVZssQggJLnbZXTCrHVAz/NPfW+nKRPin0=;
 b=BFjYzGy9ecwqlQaNIuUuGzneVoz8h9ARN+ReX9196+DdCkESCW9dsVgG0GTnV16vYIfFu1ozE
 nUsx6ksBkykBNueWyHQ/pRDmkNKMCasnYzlbHAxh2+lOlxTGaE0ONWD
X-Developer-Key: i=jeanmichel.hautbois@yoseli.org; a=ed25519;
 pk=MsMTVmoV69wLIlSkHlFoACIMVNQFyvJzvsJSQsn/kq4=
X-GND-Sasl: jeanmichel.hautbois@yoseli.org
X-GND-Score: -100
X-GND-Cause: dmFkZTERfnVehNAXUaQWJD0/6HJbgJtZl0Ej3OYaeHof8oDy1WB86V/78PQoPiPsUkMAlLJSzMa32RwYG0O7jJl+U4XeipYvUQD7YfunmGQPzf9T1GMhnJVE3XTdMMDTQYQM1NHSJ0Pe7NaHwLPFtefdoHse0N5UTpmZUux+iEWKv1OFgiFioAehx1wOQX+5jvl8e8XLYNNYaKByfpia8KxVMb06K+oUQwzDskJt2ZrW4fFJO5ncIkEfkR41qn6zsImliiXoF3w0CU5wasgCKIrQcmBCjhO4koX1KW97HomtLjfkrG3wGHoGXZrujKxrRMacqCDkrt7pZOPJALw8QekhuJJ7O1NOKC1d9q1tmnUwPQmEMwA1osRZ1XYE54HHII0Ng+DgY7lbk2n28fcWoEGVs1ZgimbSOgl8SQz9gqbHW106WXAneE/cXPJgDEqWlSa2a62h6ouWquu9xgKOw+u5PkmjK+jCQA3qmb9p3P3e9Fy6PW6SKIn/9OHmhLvY6mBPV8wLKNVMYDegwNaMam15mgWkT14Xl2ZUZOSIgQyRCyRt8wllpDCY3Wl+NHMpIFs0hs9hcSAdII+tKjkKUa+qZJkp/1Za17YVZEfzmhDKT8ywUQWxdWgi+aGv5JmhllmTFynaz84PJUii7cEs1a96QcfJ0OE6hkDfUOhGEEA5x566Uw
X-GND-State: clean
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[yoseli.org,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[yoseli.org:s=gm1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-11772-lists,dmaengine=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[jeanmichel.hautbois@yoseli.org,dmaengine@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:Frank.Li@nxp.com,m:vkoul@kernel.org,m:angelo@sysam.it,m:Frank.Li@kernel.org,m:imx@lists.linux.dev,m:dmaengine@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:jeanmichel.hautbois@yoseli.org,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[yoseli.org:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jeanmichel.hautbois@yoseli.org,dmaengine@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	TAGGED_RCPT(0.00)[dmaengine];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp,yoseli.org:dkim,yoseli.org:email,yoseli.org:mid,yoseli.org:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 37B0A6C40C6

Move fsl_edma_err_chan_handler from an inline function in the header
to a proper function in fsl-edma-common.c. This prepares for MCF
ColdFire eDMA support where the error handler needs to be called from
the MCF-specific error interrupt handler.

No functional change for existing users.

Signed-off-by: Jean-Michel Hautbois <jeanmichel.hautbois@yoseli.org>
---
 drivers/dma/fsl-edma-common.c | 5 +++++
 drivers/dma/fsl-edma-common.h | 6 +-----
 2 files changed, 6 insertions(+), 5 deletions(-)

diff --git a/drivers/dma/fsl-edma-common.c b/drivers/dma/fsl-edma-common.c
index bb7531c456df..1b1a0496b5e6 100644
--- a/drivers/dma/fsl-edma-common.c
+++ b/drivers/dma/fsl-edma-common.c
@@ -44,6 +44,11 @@
 #define EDMA64_ERRH		0x28
 #define EDMA64_ERRL		0x2c
 
+void fsl_edma_err_chan_handler(struct fsl_edma_chan *fsl_chan)
+{
+	fsl_chan->status = DMA_ERROR;
+}
+
 void fsl_edma_tx_chan_handler(struct fsl_edma_chan *fsl_chan)
 {
 	spin_lock(&fsl_chan->vchan.lock);
diff --git a/drivers/dma/fsl-edma-common.h b/drivers/dma/fsl-edma-common.h
index 205a96489094..abc8f7805515 100644
--- a/drivers/dma/fsl-edma-common.h
+++ b/drivers/dma/fsl-edma-common.h
@@ -475,11 +475,7 @@ static inline struct fsl_edma_desc *to_fsl_edma_desc(struct virt_dma_desc *vd)
 	return container_of(vd, struct fsl_edma_desc, vdesc);
 }
 
-static inline void fsl_edma_err_chan_handler(struct fsl_edma_chan *fsl_chan)
-{
-	fsl_chan->status = DMA_ERROR;
-}
-
+void fsl_edma_err_chan_handler(struct fsl_edma_chan *fsl_chan);
 void fsl_edma_tx_chan_handler(struct fsl_edma_chan *fsl_chan);
 void fsl_edma_disable_request(struct fsl_edma_chan *fsl_chan);
 void fsl_edma_chan_mux(struct fsl_edma_chan *fsl_chan,

-- 
2.39.5


