Return-Path: <dmaengine+bounces-11975-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id iVF7JJOERmrlXgsAu9opvQ
	(envelope-from <dmaengine+bounces-11975-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Thu, 02 Jul 2026 17:32:35 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 2483F6F972E
	for <lists+dmaengine@lfdr.de>; Thu, 02 Jul 2026 17:32:35 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20201202 header.b=bil6EqVa;
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-11975-lists+dmaengine=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="dmaengine+bounces-11975-lists+dmaengine=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id A9C643034028
	for <lists+dmaengine@lfdr.de>; Thu,  2 Jul 2026 15:28:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1141137A824;
	Thu,  2 Jul 2026 15:28:11 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFAEA3FCC;
	Thu,  2 Jul 2026 15:28:10 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783006091; cv=none; b=FaGpwzIq/2PVrtlBgvaMOwQ603NPkQ0B+I40ptAu7aDZymA7IdXUCZ38pPZBmRbyG7Q3lQrs8QbbGzNlBvjm+MU2TY6pwlTAA70UuG5PbMQ8xsuPvBtnlNvsLHujjxNsjhQyDuf5iJ0QCEjyl6btraHSEc3ZC7MB1KdsqATMrYE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783006091; c=relaxed/simple;
	bh=wviL27NRl327KGDR0BmJPJJ56A3cdlfcV3c2ED4Jls8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=mB+UXUIlrUxSP1plnAZjzfGNwRoIa5zfFD1C4sKup3YSVtOxa6J45YvLzf13jLL5Jh2nvIoNKpe6Cbg27bXrCpfZDbtg6XqBcrXNZf+AAlG6R/hIW+Qev4yr/TovtBOCpsAN3bwDoAAeE/5LMmINEz9wVuIwMH7V4PM9oCJKRhY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bil6EqVa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 8D9FFC2BCC7;
	Thu,  2 Jul 2026 15:28:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1783006090;
	bh=wviL27NRl327KGDR0BmJPJJ56A3cdlfcV3c2ED4Jls8=;
	h=From:Date:Subject:To:Cc:Reply-To:From;
	b=bil6EqVajk2Zqpm+mDR5iVYnFZLBRWVg0O2wEuReWosBySmR0xpp9xfTpNn/Knj8i
	 XZglHMIdT173QV54eTXHzHuJKBklXnyVZ8grMOcuQhYjUqx8gsdxIQYNBDfAoWp7S6
	 T+452S8P29OL9UE46uD1oMgAwzFNB03Fs2Br0zY1yOQstldxoLlOE4NNliy48OOO5e
	 0dvfakGzhpYVkD6Lt6ZoKQJYCfKif1aqF+J8cgEOLCxaqsJ0MM83BaaHQOrX+WxS0f
	 SfJjznMcYizc+gyI3F88yFWiqsqbJ38FgFYJGS2esjrcaFu/sEj/DHjLVUiEpSjpl7
	 EY0RoTmfyh17Q==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B616C43458;
	Thu,  2 Jul 2026 15:28:10 +0000 (UTC)
From: Christian Taedcke via B4 Relay <devnull+christian.taedcke.weidmueller.com@kernel.org>
Date: Thu, 02 Jul 2026 17:28:03 +0200
Subject: [PATCH v2] dmaengine: nbpfaxi: Fix setting channel irqs in probe()
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260702-upstreaming-nbpfaxi-v1-v2-1-e6d6b178a278@weidmueller.com>
X-B4-Tracking: v=1; b=H4sIAIKDRmoC/4WNQQqDMBREryJ/3ZQYqw1deY/iIsYf/UUTSdRax
 Ls32gMUZvNgZt4GAT1hgEeygceFAjkbQVwS0J2yLTJqIoPgouB3Ltg8hsmjGsi2zNajUSuxJWU
 8K26Y5bkyMoc4Hj0aWs/jZ/XjMNcv1NPxdjQ6CpPzn9O8pEfvryQmZaaRqKTMuEZVvpGaYca+R
 3/VboBq3/cvNKXPpdQAAAA=
X-Change-ID: 20260702-upstreaming-nbpfaxi-v1-0364e355af85
To: Vinod Koul <vkoul@kernel.org>, Frank Li <Frank.Li@kernel.org>, 
 Dan Carpenter <error27@gmail.com>, christian.taedcke-oss@weidmueller.com
Cc: dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org, 
 stable@vger.kernel.org, 
 Christian Taedcke <christian.taedcke@weidmueller.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1783006089; l=2082;
 i=christian.taedcke@weidmueller.com; s=20260702;
 h=from:subject:message-id;
 bh=IzUQu+E8VTZ8ZfkMwN9i9MqRhpTxuocHqQC40gcbdj4=;
 b=zXjAubGaROb2J3AtoN9zBnEjeOfeexMILJ4jDci7kkqlVT59SDtPLUATpTo7oS7kiAbIJhFR6
 QYEo87v7d0QD9wqXvRA8sU//UrioR6OPMm7DxrE2WXYlC+UkmDbcC6I
X-Developer-Key: i=christian.taedcke@weidmueller.com; a=ed25519;
 pk=fVCoBhFV3uMogA2nxIOU/rynNY+O2TDJgWvWjR06TrQ=
X-Endpoint-Received: by B4 Relay for
 christian.taedcke@weidmueller.com/20260702 with auth_id=847
X-Original-From: Christian Taedcke <christian.taedcke@weidmueller.com>
Reply-To: christian.taedcke@weidmueller.com
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-5.16 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-11975-lists,dmaengine=lfdr.de,christian.taedcke.weidmueller.com];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:vkoul@kernel.org,m:Frank.Li@kernel.org,m:error27@gmail.com,m:christian.taedcke-oss@weidmueller.com,m:dmaengine@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:stable@vger.kernel.org,m:christian.taedcke@weidmueller.com,s:lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[devnull@kernel.org,dmaengine@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	FREEMAIL_TO(0.00)[kernel.org,gmail.com,weidmueller.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	HAS_REPLYTO(0.00)[christian.taedcke@weidmueller.com];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[devnull@kernel.org,dmaengine@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TAGGED_RCPT(0.00)[dmaengine];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,vger.kernel.org:from_smtp,msgid.link:url,weidmueller.com:replyto,weidmueller.com:email,weidmueller.com:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 2483F6F972E

From: Christian Taedcke <christian.taedcke@weidmueller.com>

When one irq is used for errors and each channel gets a dedicated irq,
the total number of irqs is num_channels + 1. If the error irq is not
the last entry in irqbuf[] but an earlier one, the loop assigning
per-channel irqs terminates one iteration too early and the last
channel is left without an irq.

Iterate over all collected irqs instead of num_channels so the
error-irq skip does not shorten the effective channel count.

Fixes: 188c6ba1dd92 ("dmaengine: nbpfaxi: Fix memory corruption in probe()")
Cc: stable@vger.kernel.org
Signed-off-by: Christian Taedcke <christian.taedcke@weidmueller.com>
---
Changes in v2:
- Advance chan only when assigning a real irq to fix out-of-bounds
  memory access.
- Remove now redundant ARRAY_SIZE(irqbuf) check.
- Link to v1: https://patch.msgid.link/20260702-upstreaming-nbpfaxi-v1-v1-1-fd8ea8830cea@weidmueller.com

To: christian.taedcke-oss@weidmueller.com
To: Vinod Koul <vkoul@kernel.org>
To: Frank Li <Frank.Li@kernel.org>
To: Dan Carpenter <error27@gmail.com>
Cc: dmaengine@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
---
 drivers/dma/nbpfaxi.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/dma/nbpfaxi.c b/drivers/dma/nbpfaxi.c
index 05d7321629cc..bcfab62a71d7 100644
--- a/drivers/dma/nbpfaxi.c
+++ b/drivers/dma/nbpfaxi.c
@@ -1374,14 +1374,12 @@ static int nbpf_probe(struct platform_device *pdev)
 		if (irqs == num_channels + 1) {
 			struct nbpf_channel *chan;
 
-			for (i = 0, chan = nbpf->chan; i < num_channels;
-			     i++, chan++) {
+			for (i = 0, chan = nbpf->chan; i < irqs; i++) {
 				/* Skip the error IRQ */
 				if (irqbuf[i] == eirq)
-					i++;
-				if (i >= ARRAY_SIZE(irqbuf))
-					return -EINVAL;
+					continue;
 				chan->irq = irqbuf[i];
+				chan++;
 			}
 		} else {
 			/* 2 IRQs and more than one channel */

---
base-commit: dc59e4fea9d83f03bad6bddf3fa2e52491777482
change-id: 20260702-upstreaming-nbpfaxi-v1-0364e355af85

Best regards,
--  
Christian Taedcke <christian.taedcke@weidmueller.com>



