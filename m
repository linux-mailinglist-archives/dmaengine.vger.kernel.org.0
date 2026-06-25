Return-Path: <dmaengine+bounces-11777-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id EnSGHh7uPGpKuggAu9opvQ
	(envelope-from <dmaengine+bounces-11777-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Thu, 25 Jun 2026 11:00:14 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CE1546C4062
	for <lists+dmaengine@lfdr.de>; Thu, 25 Jun 2026 11:00:13 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=yoseli.org header.s=gm1 header.b="pQtEuy3/";
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-11777-lists+dmaengine=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="dmaengine+bounces-11777-lists+dmaengine=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=yoseli.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 0E5F630269FC
	for <lists+dmaengine@lfdr.de>; Thu, 25 Jun 2026 08:59:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5881D3876B7;
	Thu, 25 Jun 2026 08:59:50 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E50DC3A6F1B;
	Thu, 25 Jun 2026 08:59:45 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782377990; cv=none; b=cAxhbiskPPZv+1+5GgQHmJfns6V+7d3w2KoxzWZVmJUBSKrlqtYnORN4jbULLqOJ3e38+P/15Tcsrok7UGR+czy4h3uxj3q+/fkpTKzej2u6nnW0uVR5pkqyrxAMpQ2XC0E65m1meEKk67qZUQWoVh2ppKtbIe6hQ/VKirz9auw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782377990; c=relaxed/simple;
	bh=ipduYrTDxXxlk439FugvjGvm/Pmtyx80AMLIO4/acbw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=cHLJ7u/G0wBncdjsIULRTK6Suly4HhfZpJmtmiTbnZbiNMuYOW9aKCpZiRw6ajPasdOU2QW1LAhNb8X2dJ0Yf0KLeYhi8gkms8hfdJfmEYcxTvaumRRzWHW2NNgIjxddfJ3gWJXw8EvEtrM2XPCmNgQbip5tTixTa2CHaK8VLjI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yoseli.org; spf=pass smtp.mailfrom=yoseli.org; dkim=pass (2048-bit key) header.d=yoseli.org header.i=@yoseli.org header.b=pQtEuy3/; arc=none smtp.client-ip=217.70.183.197
Received: by mail.gandi.net (Postfix) with ESMTPSA id D10B43EBFB;
	Thu, 25 Jun 2026 08:59:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yoseli.org; s=gm1;
	t=1782377984;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ukvOm3bcCLiPQClxijKiroreAgInSO9drfY7SQITE9U=;
	b=pQtEuy3/28rmn2shqZh7z2XfZ6g8qR5NrRtIPAEjvizVZF6fiFmqGuCsZC1nEb6ibbZJV3
	rhQ/r/H0kFr6lBn8Hnq3XUeRPxAQhN+bBAh7FU9fcfx7/VbD3Fq3n47gb8eUv/3FUAz0He
	4A8TUHBwCbrDj+M8p7GghHJBi5o/JVPERlUtwKCtKc6+oK0Mi6R2l84/jvNcGcINwnUYLP
	x7xkdzzrAcatmobz+T7DrmXC0fvqGsPPWdz8b9GH1ZJ2qTZOF/MNRbbr5AwO8P5saEtZV9
	nV/r/GwtwXUQ2O/eEJM4VGvDPxLIeJMMPX757JwqgOMRTBgotgnYbMCBU4cBfg==
From: Jean-Michel Hautbois <jeanmichel.hautbois@yoseli.org>
Date: Thu, 25 Jun 2026 10:59:41 +0200
Subject: [PATCH v3 5/5] dmaengine: mcf-edma: Use devm for per-channel IRQ
 registration
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260625-b4-edma-dmaengine-v3-5-44be00ace37d@yoseli.org>
References: <20260625-b4-edma-dmaengine-v3-0-44be00ace37d@yoseli.org>
In-Reply-To: <20260625-b4-edma-dmaengine-v3-0-44be00ace37d@yoseli.org>
To: Frank Li <Frank.Li@nxp.com>, Vinod Koul <vkoul@kernel.org>, 
 Angelo Dureghello <angelo@sysam.it>
Cc: Frank Li <Frank.Li@kernel.org>, imx@lists.linux.dev, 
 dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Jean-Michel Hautbois <jeanmichel.hautbois@yoseli.org>
X-Mailer: b4 0.15-dev-47773
X-Developer-Signature: v=1; a=ed25519-sha256; t=1782377978; l=5226;
 i=jeanmichel.hautbois@yoseli.org; s=20240925; h=from:subject:message-id;
 bh=ipduYrTDxXxlk439FugvjGvm/Pmtyx80AMLIO4/acbw=;
 b=KC6RWsoDPEcPwNB3rvLjLjVxYSPxfbVReuKyBSnR4evfxCgZ9rKBaO697qa2sEsSQeNvhpk2g
 m2gu5IVJnaEAFg4/4TM0WEh+1Z/A7W7EbNE/APddzENO2kuiXoKm52l
X-Developer-Key: i=jeanmichel.hautbois@yoseli.org; a=ed25519;
 pk=MsMTVmoV69wLIlSkHlFoACIMVNQFyvJzvsJSQsn/kq4=
X-GND-Sasl: jeanmichel.hautbois@yoseli.org
X-GND-Score: -100
X-GND-Cause: dmFkZTEdwKb+ijIxjHFx5x8TU6lg02lhGCjlq6ldY0tHFTa7vxJKhfMlCyFy/0Le+eC95ttCiSBOuzLWlqa94K4yegjifKX7hLbal3Flzv+zpysuut3t2/PiPt+AMU/aegzeguZ3FK4ckbgbQoLuVqCF+LSIJUhaMMPXBT/7GPv0OyqjrnvbkGcVPNeBO/h08Yke6SoPuiU7VHSouPKsxI5LI6laZdv3BpNwe0acmEJKQV1GVi0i1OIs3SdZFJQaK//3/qdZfPGLAM2+lxs68tF1idIthlxrzeI2lvFh6wQbl71t9vcx/TZsechsKXkCZRJFEyUNr3JmyjjdTelgUsio74PhqAdv+SztRkGKBxwoB7nTQ6af1eaRfqjn+7uvVbD/NAv7zSFnS963H79xT5G+QHS5LnVLqVaJIJLcvtC8iTRnV9APl3obQr2WzhV6yN9COU17S39rAdFpY+DX8Od8AQbnm+/8yob+BRsrJg54lYFL9y2YVxjYWro9So7R4vW2ekGRBrnYW2DkyW+3EZ5/DlykvWweV+pcwwxWIVtYBbYyyqIolv8v6ePs5/IdC1GH79yKOzo2DD27xMGIFydK+zg2Kle4qwW0uor7dgzYcRPV40QXr3PZiQu7yI9j4YG5CWFc+HR/YafKafqWvEOEtEhrLUzigaaiYsZDGuPuk3qT8Q
X-GND-State: clean
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[yoseli.org,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[yoseli.org:s=gm1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-11777-lists,dmaengine=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[jeanmichel.hautbois@yoseli.org,dmaengine@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:Frank.Li@nxp.com,m:vkoul@kernel.org,m:angelo@sysam.it,m:Frank.Li@kernel.org,m:imx@lists.linux.dev,m:dmaengine@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:jeanmichel.hautbois@yoseli.org,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[yoseli.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,yoseli.org:dkim,yoseli.org:email,yoseli.org:mid,yoseli.org:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: CE1546C4062

Register each eDMA transfer interrupt with a per-channel name
("eDMA-<n>") so /proc/interrupts and debugging tools can identify the
channel behind each line, and switch the whole IRQ setup to
devm_request_irq().

Using the managed API lets devres release the handlers on probe
failure or device removal, which removes the manual mcf_edma_irq_free()
teardown and the IRQ leak / dangling irqaction that the previous error
paths left behind. The devm_kasprintf() result is now checked for NULL
before being used as the IRQ name.

Because devres only frees the handlers after mcf_edma_remove() returns,
the controller must be quiesced at the start of remove(): disable every
channel's request and acknowledge any pending interrupt before tearing
down the virtual channels. Otherwise an interrupt could fire into a
partially torn-down state while the handlers are still registered.

Signed-off-by: Jean-Michel Hautbois <jeanmichel.hautbois@yoseli.org>
---
 drivers/dma/mcf-edma-main.c | 84 ++++++++++++++++++++++-----------------------
 1 file changed, 41 insertions(+), 43 deletions(-)

diff --git a/drivers/dma/mcf-edma-main.c b/drivers/dma/mcf-edma-main.c
index 3dab5d475d1b..119d49c829fb 100644
--- a/drivers/dma/mcf-edma-main.c
+++ b/drivers/dma/mcf-edma-main.c
@@ -66,7 +66,7 @@ static irqreturn_t mcf_edma_err_handler(int irq, void *dev_id)
 static int mcf_edma_irq_init(struct platform_device *pdev,
 				struct fsl_edma_engine *mcf_edma)
 {
-	int ret = 0, i;
+	int ret, i, chan = 0;
 	struct resource *res;
 
 	res = platform_get_resource_byname(pdev,
@@ -74,33 +74,47 @@ static int mcf_edma_irq_init(struct platform_device *pdev,
 	if (!res)
 		return -1;
 
-	for (ret = 0, i = res->start; i <= res->end; ++i)
-		ret |= request_irq(i, mcf_edma_tx_handler, 0, "eDMA", mcf_edma);
-	if (ret)
-		return ret;
+	for (i = res->start; i <= res->end; ++i) {
+		char *irq_name;
+
+		irq_name = devm_kasprintf(&pdev->dev, GFP_KERNEL, "eDMA-%d", chan++);
+		if (!irq_name)
+			return -ENOMEM;
+		ret = devm_request_irq(&pdev->dev, i, mcf_edma_tx_handler, 0,
+				       irq_name, mcf_edma);
+		if (ret)
+			return ret;
+	}
 
 	res = platform_get_resource_byname(pdev,
 			IORESOURCE_IRQ, "edma-tx-16-55");
 	if (!res)
 		return -1;
 
-	for (ret = 0, i = res->start; i <= res->end; ++i)
-		ret |= request_irq(i, mcf_edma_tx_handler, 0, "eDMA", mcf_edma);
-	if (ret)
-		return ret;
+	for (i = res->start; i <= res->end; ++i) {
+		char *irq_name;
+
+		irq_name = devm_kasprintf(&pdev->dev, GFP_KERNEL, "eDMA-%d", chan++);
+		if (!irq_name)
+			return -ENOMEM;
+		ret = devm_request_irq(&pdev->dev, i, mcf_edma_tx_handler, 0,
+				       irq_name, mcf_edma);
+		if (ret)
+			return ret;
+	}
 
 	ret = platform_get_irq_byname(pdev, "edma-tx-56-63");
 	if (ret != -ENXIO) {
-		ret = request_irq(ret, mcf_edma_tx_handler,
-				  0, "eDMA", mcf_edma);
+		ret = devm_request_irq(&pdev->dev, ret, mcf_edma_tx_handler, 0,
+				       "eDMA-tx-56-63", mcf_edma);
 		if (ret)
 			return ret;
 	}
 
 	ret = platform_get_irq_byname(pdev, "edma-err");
 	if (ret != -ENXIO) {
-		ret = request_irq(ret, mcf_edma_err_handler,
-				  0, "eDMA", mcf_edma);
+		ret = devm_request_irq(&pdev->dev, ret, mcf_edma_err_handler, 0,
+				       "eDMA-err", mcf_edma);
 		if (ret)
 			return ret;
 	}
@@ -108,35 +122,6 @@ static int mcf_edma_irq_init(struct platform_device *pdev,
 	return 0;
 }
 
-static void mcf_edma_irq_free(struct platform_device *pdev,
-				struct fsl_edma_engine *mcf_edma)
-{
-	int irq;
-	struct resource *res;
-
-	res = platform_get_resource_byname(pdev,
-			IORESOURCE_IRQ, "edma-tx-00-15");
-	if (res) {
-		for (irq = res->start; irq <= res->end; irq++)
-			free_irq(irq, mcf_edma);
-	}
-
-	res = platform_get_resource_byname(pdev,
-			IORESOURCE_IRQ, "edma-tx-16-55");
-	if (res) {
-		for (irq = res->start; irq <= res->end; irq++)
-			free_irq(irq, mcf_edma);
-	}
-
-	irq = platform_get_irq_byname(pdev, "edma-tx-56-63");
-	if (irq != -ENXIO)
-		free_irq(irq, mcf_edma);
-
-	irq = platform_get_irq_byname(pdev, "edma-err");
-	if (irq != -ENXIO)
-		free_irq(irq, mcf_edma);
-}
-
 static struct fsl_edma_drvdata mcf_data = {
 	.flags = FSL_EDMA_DRV_EDMA64 | FSL_EDMA_DRV_MCF,
 	.setup_irq = mcf_edma_irq_init,
@@ -249,8 +234,21 @@ static int mcf_edma_probe(struct platform_device *pdev)
 static void mcf_edma_remove(struct platform_device *pdev)
 {
 	struct fsl_edma_engine *mcf_edma = platform_get_drvdata(pdev);
+	struct edma_regs *regs = &mcf_edma->regs;
+	int i;
+
+	/*
+	 * The per-channel interrupts are requested with devm and are only
+	 * freed after this function returns.  Quiesce the controller first so
+	 * that no interrupt can fire while the virtual channels are torn down:
+	 * disable every channel's request and acknowledge any pending
+	 * interrupt.
+	 */
+	for (i = 0; i < mcf_edma->n_chans; i++)
+		fsl_edma_disable_request(&mcf_edma->chans[i]);
+	iowrite32(~0, regs->inth);
+	iowrite32(~0, regs->intl);
 
-	mcf_edma_irq_free(pdev, mcf_edma);
 	fsl_edma_cleanup_vchan(&mcf_edma->dma_dev);
 	dma_async_device_unregister(&mcf_edma->dma_dev);
 }

-- 
2.39.5


