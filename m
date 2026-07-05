Return-Path: <dmaengine+bounces-12031-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id KXZXCIkOSmqa9wAAu9opvQ
	(envelope-from <dmaengine+bounces-12031-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Sun, 05 Jul 2026 09:58:01 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 254A9709463
	for <lists+dmaengine@lfdr.de>; Sun, 05 Jul 2026 09:58:00 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=none;
	dmarc=none;
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-12031-lists+dmaengine=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="dmaengine+bounces-12031-lists+dmaengine=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B9996300638A
	for <lists+dmaengine@lfdr.de>; Sun,  5 Jul 2026 07:57:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D345E3624B2;
	Sun,  5 Jul 2026 07:57:56 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38A7E35E1A5;
	Sun,  5 Jul 2026 07:57:53 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783238276; cv=none; b=OLeENynl9QIytSfBGX9Cr1hjhGT1axuGiNj8HxVamSqBfPgDILGI6a/trLH47oQuvH0Ee6sTEuKh9JQUMv6Am5aO8PMbBUCLGVECc7kc2md7y7Lcgppw6E52CjK3JTvwvFhmFY4IAwE3toXge+oFr21hSIEzBQK5Xqo5mTX5ynE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783238276; c=relaxed/simple;
	bh=tFeesKG8XuVOwny1VBR+fnpr3ScvxX6H341Mpa6xfws=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=n6FycsAE+bulippgwUyIPiZ8Aq8CnqAosLjxcQ0DuSnE3frm0cb1JDqq32JcV3YpirCc8Rsohw9xlqqjeZkUrX1xiJUmRZAJP+O44iRfDMP0INz2jTDBGqf6ZRiEeOq+GArcpTIZFfND6QxsafnY7TM29CrLLHwfE0KuY4vFBfw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
X-UUID: 3353b854784711f1aa26b74ffac11d73-20260705
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.12,REQID:a6fc6c02-e40b-4e53-b58f-7af923fdfb6f,IP:0,U
	RL:0,TC:0,Content:-5,EDM:-25,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTI
	ON:release,TS:-30
X-CID-META: VersionHash:e7bac3a,CLOUDID:c97a6a94ed67e26f58b4136fe0846417,BulkI
	D:nil,BulkQuantity:0,Recheck:0,SF:102|850|865|898,TC:nil,Content:0|15|50,E
	DM:2,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:
	0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 3353b854784711f1aa26b74ffac11d73-20260705
X-User: zenghongling@kylinos.cn
Received: from localhost.localdomain [(10.44.16.150)] by mailgw.kylinos.cn
	(envelope-from <zenghongling@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 1267926036; Sun, 05 Jul 2026 15:57:42 +0800
From: Hongling Zeng <zenghongling@kylinos.cn>
To: vkoul@kernel.org,
	Frank.Li@kernel.org,
	wens@kernel.org,
	jernej.skrabec@gmail.com,
	samuel@sholland.org
Cc: dmaengine@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-sunxi@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	zhongling0719@126.com,
	Hongling Zeng <zenghongling@kylinos.cn>,
	stable@vger.kernel.org
Subject: [PATCH] dmaengine: sun6i: Fix potential deadlock in sun6i_dma_terminate_all()
Date: Sun,  5 Jul 2026 15:57:38 +0800
Message-Id: <20260705075738.10639-1-zenghongling@kylinos.cn>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [1.54 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[12];
	DMARC_NA(0.00)[kylinos.cn];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:vkoul@kernel.org,m:Frank.Li@kernel.org,m:wens@kernel.org,m:jernej.skrabec@gmail.com,m:samuel@sholland.org,m:dmaengine@vger.kernel.org,m:linux-arm-kernel@lists.infradead.org,m:linux-sunxi@lists.linux.dev,m:linux-kernel@vger.kernel.org,m:zhongling0719@126.com,m:zenghongling@kylinos.cn,m:stable@vger.kernel.org,m:jernejskrabec@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[zenghongling@kylinos.cn,dmaengine@vger.kernel.org];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_TO(0.00)[kernel.org,gmail.com,sholland.org];
	TAGGED_FROM(0.00)[bounces-12031-lists,dmaengine=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[zenghongling@kylinos.cn,dmaengine@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,lists.infradead.org,lists.linux.dev,126.com,kylinos.cn];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[dmaengine];
	R_DKIM_NA(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp,kylinos.cn:from_mime,kylinos.cn:email,kylinos.cn:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 254A9709463

sun6i_dma_terminate_all() acquires sdev->lock with plain spin_lock()
from process context. Since interrupts remain enabled, a DMA interrupt
can fire on the same CPU while the lock is held. The interrupt handler
schedules sun6i_dma_tasklet(), which attempts to acquire the same lock
with spin_lock_irq(), causing a deadlock.

Fix by using spin_lock_irq() to disable interrupts while holding
sdev->lock, consistent with other call sites.

Fixes: ba489fd46ab6 ("dmaengine: sun6i: Add support for Allwinner A31 DMA controller")
Cc: stable@vger.kernel.org
Signed-off-by: Hongling Zeng <zenghongling@kylinos.cn>
---
 drivers/dma/sun6i-dma.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/dma/sun6i-dma.c b/drivers/dma/sun6i-dma.c
index a9a254dbf8cb..840f7276ad5d 100644
--- a/drivers/dma/sun6i-dma.c
+++ b/drivers/dma/sun6i-dma.c
@@ -939,9 +939,9 @@ static int sun6i_dma_terminate_all(struct dma_chan *chan)
 	unsigned long flags;
 	LIST_HEAD(head);
 
-	spin_lock(&sdev->lock);
+	spin_lock_irq(&sdev->lock);
 	list_del_init(&vchan->node);
-	spin_unlock(&sdev->lock);
+	spin_unlock_irq(&sdev->lock);
 
 	spin_lock_irqsave(&vchan->vc.lock, flags);
 
-- 
2.25.1


