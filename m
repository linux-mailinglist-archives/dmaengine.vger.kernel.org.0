Return-Path: <dmaengine+bounces-11775-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id /DC8LwXvPGp+uggAu9opvQ
	(envelope-from <dmaengine+bounces-11775-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Thu, 25 Jun 2026 11:04:05 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 364B16C40E8
	for <lists+dmaengine@lfdr.de>; Thu, 25 Jun 2026 11:04:05 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=yoseli.org header.s=gm1 header.b=i1FuGi2E;
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-11775-lists+dmaengine=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="dmaengine+bounces-11775-lists+dmaengine=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=yoseli.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 83A85310A2CA
	for <lists+dmaengine@lfdr.de>; Thu, 25 Jun 2026 08:59:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B783A38AC8B;
	Thu, 25 Jun 2026 08:59:45 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC9C4388396;
	Thu, 25 Jun 2026 08:59:43 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782377985; cv=none; b=gFTMZ1gDGZ8w+w5ZzbAmFzWlsOvRi9fBveQqWXxOhwvvtCnEz22twLHZ3eFXB/nnernKR5fQ8CJD15nhrvcmeAyNUzGkiP2J6QJW2q8l/lA9ZB9hW5jTY+nA60eYY+qrySqlUmpc4Ct7aB8VhND5CS7F9r7S++I6Vxg7BL3A0Zw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782377985; c=relaxed/simple;
	bh=CNuZIId4fpCI5iP2XYtd7/BrpyfGAA8Idwgw6Zfv/Cg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=q7IE8jp60nltLB1n6TSZBZqtNdPOmLkgMXZkvOorR/XnwGRaUQeaJBToC6YaabYDgDyPofYuPcE7cvV8mqrIDCaTXjMVDmy4KGK1j4jzgEOOLaEe3CHtTCh9o2Wy34423xJxQjoO54cqYWkWVi9FVLsFvRVGb5AghP1gLgY3Ma8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yoseli.org; spf=pass smtp.mailfrom=yoseli.org; dkim=pass (2048-bit key) header.d=yoseli.org header.i=@yoseli.org header.b=i1FuGi2E; arc=none smtp.client-ip=217.70.183.197
Received: by mail.gandi.net (Postfix) with ESMTPSA id EBD4E3EBA2;
	Thu, 25 Jun 2026 08:59:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yoseli.org; s=gm1;
	t=1782377982;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DJYadGlMtwoKUWMMvK6CNnxdjGblAwr1W4m2hfLQ7PE=;
	b=i1FuGi2EbcbEsruInVzLjTnPuP5jwQbANJwad6jQzOV5ArwSW4vwHccW+TcqfVRaIoxjYi
	UcQZBscIKVMjSrzcNLib4kKHrs3ueIIeJ0l9bZmErpcUoV+vuAtPirUZZqY0g+Qd1jLgP6
	qfDf/lD8CYbwwx2aN+pqKuPcV0KespH01bP2aApIHvrel7rJcgEfLRASjCjO6uPXM7drBY
	yP74Hm+rkoF43vHsO5mYzp94zfJnlt2KVeyZYC/HB4zfOcoyp9Fnp4939fUBcFx6s+MoVQ
	ZWR+e2x95RLO7YFxpSi7popnatHrcAzxVejF5RiwdU9HZbQAxR4gt4wk/3Zeug==
From: Jean-Michel Hautbois <jeanmichel.hautbois@yoseli.org>
Date: Thu, 25 Jun 2026 10:59:39 +0200
Subject: [PATCH v3 3/5] dmaengine: mcf-edma: Fix interrupt handler for 64
 DMA channels
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260625-b4-edma-dmaengine-v3-3-44be00ace37d@yoseli.org>
References: <20260625-b4-edma-dmaengine-v3-0-44be00ace37d@yoseli.org>
In-Reply-To: <20260625-b4-edma-dmaengine-v3-0-44be00ace37d@yoseli.org>
To: Frank Li <Frank.Li@nxp.com>, Vinod Koul <vkoul@kernel.org>, 
 Angelo Dureghello <angelo@sysam.it>
Cc: Frank Li <Frank.Li@kernel.org>, imx@lists.linux.dev, 
 dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Jean-Michel Hautbois <jeanmichel.hautbois@yoseli.org>
X-Mailer: b4 0.15-dev-47773
X-Developer-Signature: v=1; a=ed25519-sha256; t=1782377978; l=1773;
 i=jeanmichel.hautbois@yoseli.org; s=20240925; h=from:subject:message-id;
 bh=CNuZIId4fpCI5iP2XYtd7/BrpyfGAA8Idwgw6Zfv/Cg=;
 b=HpewNZeSWWa/vkI6ORVob9Jxi53wDu1Lot7DQXLssy9qjNhcUBJb5nXRHs8PhSTmE3PV7thFj
 Z4UJSEDKjr8B1JgB4TGRqGwReqbHvOyIT7WvfHc99YzfB73d7fjZ7je
X-Developer-Key: i=jeanmichel.hautbois@yoseli.org; a=ed25519;
 pk=MsMTVmoV69wLIlSkHlFoACIMVNQFyvJzvsJSQsn/kq4=
X-GND-Sasl: jeanmichel.hautbois@yoseli.org
X-GND-Score: -100
X-GND-Cause: dmFkZTEdwKb+ijIxjHFx5x8TU6lg02lhGCjlq6ldY0tHFTa7vxJKhfMlCyFy/0Le+eC95ttCiSBOuzLWlqa94K4yegjifKX7hLbal3Flzv+zpysuut3t2/PiPt+AMU/aegzeguZ3FK4ckbgbQoLuVqCF+LSIJUhaMMPXBT/7GPv0OyqjrnvbkGcVPNeBO/h08Yke6SoPuiU7VHSouPKsxI5LI6laZdv3BpNwe0acmEJKQV1GVi0i1OIs3SdZFJQaK//3/qdZfPGLAM2+lxs68tF1idIthlxrzeI2lvFh6wQbl71t9vcx/TZsechsKXkCZRJFEyUNr3JmyjjdTelgUsio74PhpvI3VDspQiIyQrslVQVBE8RS6HbIzl01uYgwhJ30Bd2bbIZZ5iuhBxkK9SVMWY4dWeVnH7+2l9cfSXQg5huY9UlyRPK4403BtvrJX7Lq/nMSrQiH6Y0yww1ndonqk/PTWV95ef+Y1bRQNc889VpUv9TLziKiSDD5vL+OUmVICb/GILXb14gw1vHC6MU/EbVG4dZUV3phDfCd+D4Irk1S2wRz5PZQEjt0maGprysjsW6RGHFLp5Q5B5z7kqqS8ybpAyrCSm55JSJIJw4z1mh2V03BocZmz7J/ClQ+vh25v1Vv1IpPxtFznVHOAK6SpxD7fHb73rC+8zj8ds/N5iJx2g
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
	TAGGED_FROM(0.00)[bounces-11775-lists,dmaengine=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp,yoseli.org:dkim,yoseli.org:email,yoseli.org:mid,yoseli.org:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 364B16C40E8

Fix the DMA completion interrupt handler to properly handle all 64
channels on MCF54418 ColdFire processors.

The previous code used BIT(ch) to test interrupt status bits, which
causes undefined behavior on 32-bit architectures when ch >= 32 because
unsigned long is 32 bits and the shift would exceed the type width.

Replace with bitmap_from_u64() and for_each_set_bit() which correctly
handle 64-bit values on 32-bit systems by using a proper bitmap
representation.

Fixes: e7a3ff92eaf1 ("dmaengine: fsl-edma: add ColdFire mcf5441x edma support")
Signed-off-by: Jean-Michel Hautbois <jeanmichel.hautbois@yoseli.org>
---
 drivers/dma/mcf-edma-main.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/drivers/dma/mcf-edma-main.c b/drivers/dma/mcf-edma-main.c
index f95114829d80..953b20f99f25 100644
--- a/drivers/dma/mcf-edma-main.c
+++ b/drivers/dma/mcf-edma-main.c
@@ -18,7 +18,8 @@ static irqreturn_t mcf_edma_tx_handler(int irq, void *dev_id)
 {
 	struct fsl_edma_engine *mcf_edma = dev_id;
 	struct edma_regs *regs = &mcf_edma->regs;
-	unsigned int ch;
+	unsigned long ch;
+	DECLARE_BITMAP(status_mask, 64);
 	u64 intmap;
 
 	intmap = ioread32(regs->inth);
@@ -27,11 +28,11 @@ static irqreturn_t mcf_edma_tx_handler(int irq, void *dev_id)
 	if (!intmap)
 		return IRQ_NONE;
 
-	for (ch = 0; ch < mcf_edma->n_chans; ch++) {
-		if (intmap & BIT(ch)) {
-			iowrite8(EDMA_MASK_CH(ch), regs->cint);
-			fsl_edma_tx_chan_handler(&mcf_edma->chans[ch]);
-		}
+	bitmap_from_u64(status_mask, intmap);
+
+	for_each_set_bit(ch, status_mask, mcf_edma->n_chans) {
+		iowrite8(EDMA_MASK_CH(ch), regs->cint);
+		fsl_edma_tx_chan_handler(&mcf_edma->chans[ch]);
 	}
 
 	return IRQ_HANDLED;

-- 
2.39.5


