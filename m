Return-Path: <dmaengine+bounces-10282-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0NJiLMmU/mlZtAAAu9opvQ
	(envelope-from <dmaengine+bounces-10282-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Sat, 09 May 2026 03:58:33 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id F0CB34FD7A4
	for <lists+dmaengine@lfdr.de>; Sat, 09 May 2026 03:58:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 28B30300EF77
	for <lists+dmaengine@lfdr.de>; Sat,  9 May 2026 01:58:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 683CF1DF25C;
	Sat,  9 May 2026 01:58:30 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C29FF2F8EAD;
	Sat,  9 May 2026 01:58:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778291910; cv=none; b=r+W5/e4kPc6cjQJDfAg/8Zo/yexygcTFXfMhiVM0AABnEKfwL9N4zguMr+fCbUfErClNlNTPk9ShlVk3Jmqin///823/PfJIRpYfXLNTrtUR1iqL5Mt77hSgaJwleHAJ6x19mxFyDvtm/ysXt1w1ndmwCmZfjrUv6SQ9YOb41E8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778291910; c=relaxed/simple;
	bh=Ed8YrfRkDajAVP/ktDPb5JuzG57pwg+U/dHt94KGmN4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=sNhazAFwlVTsNSFvrMXWwNXM/KQdf5fzg54XePPxBhaaon4pGp5gMxKVXUbqfLh4kUUWRILVMJE/FJ8qV7mIugsbeyaR6dNI51pnooiRDtzp7uhV7OdUXXWDDDaVGRlHWU0D6j2pUZfjiqXy9ArSHs9an5O2uXMpedWrvZz/2ew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 8c67eba64b4a11f1aa26b74ffac11d73-20260509
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.12,REQID:0ea005ae-7fb7-4154-9146-acd13c0d652e,IP:0,U
	RL:0,TC:0,Content:-5,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:-5
X-CID-META: VersionHash:e7bac3a,CLOUDID:ca3915bee17de698a45232aca036f56a,BulkI
	D:nil,BulkQuantity:0,Recheck:0,SF:102|850|898,TC:nil,Content:0|15|50,EDM:-
	3,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,A
	V:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 8c67eba64b4a11f1aa26b74ffac11d73-20260509
X-User: zenghongling@kylinos.cn
Received: from localhost.localdomain [(10.44.16.150)] by mailgw.kylinos.cn
	(envelope-from <zenghongling@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 818485729; Sat, 09 May 2026 09:58:18 +0800
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
	Hongling Zeng <zenghongling@kylinos.cn>
Subject: [PATCH v1] dma: at_hdmac: Use stored IRQ in error path
Date: Sat,  9 May 2026 09:58:12 +0800
Message-Id: <20260509015812.19834-1-zenghongling@kylinos.cn>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: F0CB34FD7A4
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.04 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_FROM(0.00)[bounces-10282-lists,dmaengine=lfdr.de];
	DMARC_NA(0.00)[kylinos.cn];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,126.com,kylinos.cn];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FROM_NEQ_ENVFROM(0.00)[zenghongling@kylinos.cn,dmaengine@vger.kernel.org];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-0.952];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[dmaengine];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Action: no action

When request_irq() succeeds but a later error occurs in at_dma_probe(),
the error handling path attempts to free the IRQ by calling
platform_get_irq() again instead of using the already stored IRQ number
in the local variable 'irq'.

Use the stored 'irq' variable directly in free_irq() to make the
code clearer and eliminate smatch warnings about potential IRQ leaks.

While platform_get_irq() is deterministic, using the stored value
makes the error handling more robust against future code changes and
clearly shows the relationship between request_irq() and free_irq().

Signed-off-by: Hongling Zeng <zenghongling@kylinos.cn>
---
Changes in v1:
  - Update commit message
  - Remove Fixes: tag per reviewer feedback
---
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


