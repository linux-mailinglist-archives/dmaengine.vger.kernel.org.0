Return-Path: <dmaengine+bounces-11776-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id /JH8HDjvPGqPuggAu9opvQ
	(envelope-from <dmaengine+bounces-11776-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Thu, 25 Jun 2026 11:04:56 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CAB3B6C40FD
	for <lists+dmaengine@lfdr.de>; Thu, 25 Jun 2026 11:04:55 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=yoseli.org header.s=gm1 header.b=TgBIzhub;
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-11776-lists+dmaengine=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="dmaengine+bounces-11776-lists+dmaengine=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=yoseli.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 36DD1312246B
	for <lists+dmaengine@lfdr.de>; Thu, 25 Jun 2026 08:59:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 381CB3B47EC;
	Thu, 25 Jun 2026 08:59:47 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22FEA3921D5;
	Thu, 25 Jun 2026 08:59:44 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782377987; cv=none; b=uMPi70DimkK6QQxwrnSJQd7huph3+mjLiqKgIwkcYDS/2d9ttVPEOIEQ1CQ+QEn0s1Tz6vEoSn4ab38DkjvZ6hcpdpw+BmPGlbub32zAsV0gK/thZZ3sZrWoqonok6jxgT3mI6shXCCcBsB7sCJwogSR6jbAXCchBb24apq1Q1s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782377987; c=relaxed/simple;
	bh=0XFxWtIfGJK03FBZVs3k1tAsbb7Mv+36MkzUTDfYF6U=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=PUZV+gxl0MePHGhDBtL9nlhJqxBdNQSoMrODDBclNGwB6f/jUnCTiIudYEtdCLAeqvlVCgrKqP5S6bW4Zq+sWGVZrMlJkGBVPV1OyZ95Y2LyeLN2W72x01MYSqYM8AG91SGNy9NIgndgQfQ1LMA0oE8LWse+SxyQMTEE/aMiAIg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yoseli.org; spf=pass smtp.mailfrom=yoseli.org; dkim=pass (2048-bit key) header.d=yoseli.org header.i=@yoseli.org header.b=TgBIzhub; arc=none smtp.client-ip=217.70.183.197
Received: by mail.gandi.net (Postfix) with ESMTPSA id DDF8C3EBF7;
	Thu, 25 Jun 2026 08:59:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yoseli.org; s=gm1;
	t=1782377983;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Q1Xt8mfmCZ0B892ghZxoLvMJZC0B3A8xwFKYr8b+Xhc=;
	b=TgBIzhubsVnHA8gzJxoAXkiFkKA1K7AEESu/ElZ1d2zy3VUjhNoeFPM0xUFTXcZO0mqC6k
	x5I1lIoXPPmp5FXjnPR4iLRjmBM4esTFkY49QovXuIk/zL+LHYBhPOtUMfPDsxds2W+AF5
	41lis+OTznta+23dPSsHcpbRkCntgmFBvcQ4KfyLYsGKJPoHDnx+QpK9JlGGWttai8aNSJ
	MMd2eJf3WkHK89ibSHGex0jJL220JhyqomnAvZUUiRudqgzTLs29pMbR92HclIfFy/U+XR
	zCCGYEAU8KU+dH6MCCqc1JRXIy7vu3dOYg4flTySj9K7lOurA60Rj80df5C+Og==
From: Jean-Michel Hautbois <jeanmichel.hautbois@yoseli.org>
Date: Thu, 25 Jun 2026 10:59:40 +0200
Subject: [PATCH v3 4/5] dmaengine: mcf-edma: Fix error handler for all 64
 DMA channels
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260625-b4-edma-dmaengine-v3-4-44be00ace37d@yoseli.org>
References: <20260625-b4-edma-dmaengine-v3-0-44be00ace37d@yoseli.org>
In-Reply-To: <20260625-b4-edma-dmaengine-v3-0-44be00ace37d@yoseli.org>
To: Frank Li <Frank.Li@nxp.com>, Vinod Koul <vkoul@kernel.org>, 
 Angelo Dureghello <angelo@sysam.it>
Cc: Frank Li <Frank.Li@kernel.org>, imx@lists.linux.dev, 
 dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Jean-Michel Hautbois <jeanmichel.hautbois@yoseli.org>
X-Mailer: b4 0.15-dev-47773
X-Developer-Signature: v=1; a=ed25519-sha256; t=1782377978; l=2334;
 i=jeanmichel.hautbois@yoseli.org; s=20240925; h=from:subject:message-id;
 bh=0XFxWtIfGJK03FBZVs3k1tAsbb7Mv+36MkzUTDfYF6U=;
 b=ivd/fUmSEGIq0x7UPp4xXTEffxnUd09+IBBnbUH/DlPpSmYqOXJknYDvgDyAVhyWPa4BTV+2e
 UPZ1t6bx/OUDKtBp/3UZ+kTdaNzOHC+OFcCPexSmXVAU3nswa6bXXpd
X-Developer-Key: i=jeanmichel.hautbois@yoseli.org; a=ed25519;
 pk=MsMTVmoV69wLIlSkHlFoACIMVNQFyvJzvsJSQsn/kq4=
X-GND-Sasl: jeanmichel.hautbois@yoseli.org
X-GND-Score: -100
X-GND-Cause: dmFkZTFCvc4RUUn0180QbLM/wCY6mampz/UIYERUaH1vUZnwbReI4uzI1lQ5r5PDkYwCTr1a1tshtBLbiFe0BmH9h4J/CdeYzKT2c4t3fu9R69C/F9qiyl9Qxrfe0tfk7qLK0Kvp2oPOikx4jhwcdiC+QSUfmXnTGobPcEEPCc6dZ+l/zcuatviXQEDqV/8rtMtAbnt12YiVXCnjSdYLnYSPtgWJJ5SF+eaSZSHnij0OjFY9ahroCJoAt/C/qxpgiBtLtmworEhMGcGd6SndiUlhJjl34vPfdneDitsgN3QtsigFHrUUV6n9fT5ZK/t4Ejdwo//3rJQeuI/akwwIIXnhhOIZTE4OmBLSLGtLiqVOIcMbFOAvZGr4IDo9AGnsMJ93pI5dBpsydXi+EQI2OK3lWfPyixUNl3G+eWS1GPTgrpEsw9Sc7taiVJq1MgblYGXuZUBzHgdWCEFRYIIqWVH97xaqLiDj6QqrPvc02fhFeNue+V13r5+hYiRTfPxqN/2cE7cuvGuI1N2qOXaAhYPnivwN0RDquFZONMXljpoLzwa3DHkuUYM5LgP+HoU910uw86HXD/oZuRELe9x0kHS8iWEO+8CR6I7Ya4se+Ym6/NALtZ3Yl5cBhdcphxijU1kiLQt/4c7hSiptVPHECx4VOaIiL5pzeKKFgeh9ABwiGMwh+A
X-GND-State: clean
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[yoseli.org,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[yoseli.org:s=gm1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-11776-lists,dmaengine=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[jeanmichel.hautbois@yoseli.org,dmaengine@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:Frank.Li@nxp.com,m:vkoul@kernel.org,m:angelo@sysam.it,m:Frank.Li@kernel.org,m:imx@lists.linux.dev,m:dmaengine@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:jeanmichel.hautbois@yoseli.org,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[yoseli.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,yoseli.org:dkim,yoseli.org:email,yoseli.org:mid,yoseli.org:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: CAB3B6C40FD

Fix the DMA error interrupt handler to properly handle errors on all
64 channels. The previous implementation had several issues:

1. Returned IRQ_NONE if low channels had no errors, even if high
   channels did
2. Used direct status assignment instead of fsl_edma_err_chan_handler()
   for high channels

Split the error handling into two separate loops for the low (0-31)
and high (32-63) channel groups, using for_each_set_bit() for cleaner
iteration. Both groups now consistently use fsl_edma_err_chan_handler()
for proper error status reporting.

Fixes: e7a3ff92eaf1 ("dmaengine: fsl-edma: add ColdFire mcf5441x edma support")
Signed-off-by: Jean-Michel Hautbois <jeanmichel.hautbois@yoseli.org>
---
 drivers/dma/mcf-edma-main.c | 32 ++++++++++++--------------------
 1 file changed, 12 insertions(+), 20 deletions(-)

diff --git a/drivers/dma/mcf-edma-main.c b/drivers/dma/mcf-edma-main.c
index 953b20f99f25..3dab5d475d1b 100644
--- a/drivers/dma/mcf-edma-main.c
+++ b/drivers/dma/mcf-edma-main.c
@@ -42,30 +42,22 @@ static irqreturn_t mcf_edma_err_handler(int irq, void *dev_id)
 {
 	struct fsl_edma_engine *mcf_edma = dev_id;
 	struct edma_regs *regs = &mcf_edma->regs;
-	unsigned int err, ch;
+	unsigned long ch;
+	DECLARE_BITMAP(err_mask, 64);
+	u64 errmap;
 
-	err = ioread32(regs->errl);
-	if (!err)
+	errmap = ioread32(regs->errh);
+	errmap <<= 32;
+	errmap |= ioread32(regs->errl);
+	if (!errmap)
 		return IRQ_NONE;
 
-	for (ch = 0; ch < (EDMA_CHANNELS / 2); ch++) {
-		if (err & BIT(ch)) {
-			fsl_edma_disable_request(&mcf_edma->chans[ch]);
-			iowrite8(EDMA_CERR_CERR(ch), regs->cerr);
-			fsl_edma_err_chan_handler(&mcf_edma->chans[ch]);
-		}
-	}
-
-	err = ioread32(regs->errh);
-	if (!err)
-		return IRQ_NONE;
+	bitmap_from_u64(err_mask, errmap);
 
-	for (ch = (EDMA_CHANNELS / 2); ch < EDMA_CHANNELS; ch++) {
-		if (err & (BIT(ch - (EDMA_CHANNELS / 2)))) {
-			fsl_edma_disable_request(&mcf_edma->chans[ch]);
-			iowrite8(EDMA_CERR_CERR(ch), regs->cerr);
-			mcf_edma->chans[ch].status = DMA_ERROR;
-		}
+	for_each_set_bit(ch, err_mask, mcf_edma->n_chans) {
+		fsl_edma_disable_request(&mcf_edma->chans[ch]);
+		iowrite8(EDMA_MASK_CH(ch), regs->cerr);
+		fsl_edma_err_chan_handler(&mcf_edma->chans[ch]);
 	}
 
 	return IRQ_HANDLED;

-- 
2.39.5


