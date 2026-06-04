Return-Path: <dmaengine+bounces-11153-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id JPYuITYrIWoVAAEAu9opvQ
	(envelope-from <dmaengine+bounces-11153-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Thu, 04 Jun 2026 09:37:26 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id CC33763DAB8
	for <lists+dmaengine@lfdr.de>; Thu, 04 Jun 2026 09:37:25 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=none;
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-11153-lists+dmaengine=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="dmaengine+bounces-11153-lists+dmaengine=lfdr.de@vger.kernel.org";
	dmarc=none;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 17192300EF94
	for <lists+dmaengine@lfdr.de>; Thu,  4 Jun 2026 07:31:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25A4838A734;
	Thu,  4 Jun 2026 07:31:06 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 924A835B644;
	Thu,  4 Jun 2026 07:31:00 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780558266; cv=none; b=O5TpEopxTbRmPawrya4s2WDMa4ut87C9POcvoioV2nLp8A1a6Ri/G9rfc8Q6CjXmDKfddRbEb5UqiB+aqWU7o7TMtktxsP7hgie5uBEm5iGDgyKQtk32WwPu+vsfB+mw7duej+nWKklLIM2SVdG3WFC+G/7ywoKJ2NdZxw5ni7Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780558266; c=relaxed/simple;
	bh=9K38i5iiZBUZN5ToqqS0MOuqo8E81faIWoJZJfOpSCU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=JYFzkYkmJHYDT3gPVFCfyfem3m35FV83kx3CifGJE1c5pDxg/wAhz5QavRnX8jFiH+MsbkRCtqbNj49HdCGvr66l9QalMkIn90oU9Rurbh6jiATabe9e84N+hDi+Nj5Bh01e8yNQV6RHK+MKzZYSTP+ckevyI9MhMSHJDiiKrtk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
X-UUID: 4e1b60605fe711f1aa26b74ffac11d73-20260604
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.12,REQID:c350d492-f4e8-4782-aa72-3c4b45ed0e78,IP:0,U
	RL:0,TC:0,Content:-5,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:-5
X-CID-META: VersionHash:e7bac3a,CLOUDID:27bb9555dc1ae4f9131e46ef5f041e06,BulkI
	D:nil,BulkQuantity:0,Recheck:0,SF:102|136|850|865|898,TC:nil,Content:0|15|
	50,EDM:-3,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0
	,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 4e1b60605fe711f1aa26b74ffac11d73-20260604
X-User: zenghongling@kylinos.cn
Received: from localhost.localdomain [(10.44.16.150)] by mailgw.kylinos.cn
	(envelope-from <zenghongling@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 180388503; Thu, 04 Jun 2026 15:30:47 +0800
From: Hongling Zeng <zenghongling@kylinos.cn>
To: ludovic.desroches@microchip.com,
	vkoul@kernel.org,
	Frank.Li@kernel.org,
	djbw@kernel.org,
	nicolas.ferre@microchip.com,
	maciej.sosnowski@intel.com
Cc: dmaengine@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	zhongling0719@126.com,
	Hongling Zeng <zenghongling@kylinos.cn>,
	Frank Li <Frank.Li@nxp.com>
Subject: [PATCH v2] dma: at_hdmac: Use stored IRQ in error path
Date: Thu,  4 Jun 2026 15:30:43 +0800
Message-Id: <20260604073043.207844-1-zenghongling@kylinos.cn>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.04 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-11153-lists,dmaengine=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_NA(0.00)[kylinos.cn];
	FREEMAIL_CC(0.00)[vger.kernel.org,126.com,kylinos.cn,nxp.com];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[zenghongling@kylinos.cn,dmaengine@vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS(0.00)[m:ludovic.desroches@microchip.com,m:vkoul@kernel.org,m:Frank.Li@kernel.org,m:djbw@kernel.org,m:nicolas.ferre@microchip.com,m:maciej.sosnowski@intel.com,m:dmaengine@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:zhongling0719@126.com,m:zenghongling@kylinos.cn,m:Frank.Li@nxp.com,s:lists@lfdr.de];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[zenghongling@kylinos.cn,dmaengine@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	R_DKIM_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[dmaengine];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp,nxp.com:email,kylinos.cn:mid,kylinos.cn:from_mime,kylinos.cn:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: CC33763DAB8

When request_irq() succeeds but a later error occurs in at_dma_probe(),
the error handling path attempts to free the IRQ by calling
platform_get_irq() again instead of using the already stored IRQ number
in the local variable 'irq'.

Use the stored 'irq' variable directly in free_irq() to make the
code clearer and eliminate smatch warnings about potential IRQ leaks.

While platform_get_irq() is deterministic, using the stored value
makes the error handling more robust against future code changes and
clearly shows the relationship between request_irq() and free_irq().

Reviewed-by: Frank Li <Frank.Li@nxp.com>
Signed-off-by: Hongling Zeng <zenghongling@kylinos.cn>

---
 Change in v2:
 -Add pre-review
---
 drivers/dma/at_hdmac.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/dma/at_hdmac.c b/drivers/dma/at_hdmac.c
index e5b30a57c477..2a860679b9e1 100644
--- a/drivers/dma/at_hdmac.c
+++ b/drivers/dma/at_hdmac.c
@@ -2109,7 +2109,7 @@ static int __init at_dma_probe(struct platform_device *pdev)
 err_memset_pool_create:
 	dma_pool_destroy(atdma->lli_pool);
 err_desc_pool_create:
-	free_irq(platform_get_irq(pdev, 0), atdma);
+	free_irq(irq, atdma);
 err_irq:
 	clk_disable_unprepare(atdma->clk);
 	return err;
-- 
2.25.1


