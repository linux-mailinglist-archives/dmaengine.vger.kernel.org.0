Return-Path: <dmaengine+bounces-10192-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oKiJGWIG8mnNmgEAu9opvQ
	(envelope-from <dmaengine+bounces-10192-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Wed, 29 Apr 2026 15:23:46 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DE4B8494BCA
	for <lists+dmaengine@lfdr.de>; Wed, 29 Apr 2026 15:23:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0C45230B4A72
	for <lists+dmaengine@lfdr.de>; Wed, 29 Apr 2026 13:17:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECF583FCB1F;
	Wed, 29 Apr 2026 13:17:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aMj4FQhW"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 353B93F23A3
	for <dmaengine@vger.kernel.org>; Wed, 29 Apr 2026 13:17:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777468653; cv=none; b=kdq0YLSiH+omU5mY+VQ8M+8pJo5hHCqKhkSlaHzx6I77QZYNBMCdLdlZzNM2aabKbBooHsztmne6L5abZR2pJsSp/G7BVo8RIP/5/MtckBTL9Pn5ZyE4L2F32FkjX7l11uTmiBmp6vZ87R2Hotq7Nfin75VxabhhdlCK2enxorw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777468653; c=relaxed/simple;
	bh=8zDzl40BaE6A2qSxEiS15J6sZUI2R9MUGecR7Jcykuk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=jHfwq5vrGJxxqHh0OzuXdek2GX9Vb5Kybo0ZVnCcbNJ9WKwdimKPQ0GRbFHxopP72jcMu+mEDnmS1+xjHCezmbVuaNRzdhGAg1kgUV1xZ+Vj7KfHpwbuJZ4Nlf7QS4qCd2b8SzM64LFpIpqTb0VLPrOm2L1WUn1Ait1aFQpoi8Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aMj4FQhW; arc=none smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-5a62a049c1fso10102062e87.3
        for <dmaengine@vger.kernel.org>; Wed, 29 Apr 2026 06:17:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777468649; x=1778073449; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=0uZhjPbSdYNEfdJ2xmxocjlnV7uXSsw+wopBLD2OHSc=;
        b=aMj4FQhWraoFdFq4e0CMYeXqdpmXbViqbEiBpAKpCxegKWMeHYOiLwNLfUfFbhcagj
         t4BDpUhu2oPxuVMjl+EfAJE467W0T0okYOgxtjkKX5JQlH6NhM9BKbqdQOn3MHCeI1Pt
         +4O4Rm9BnIg4zGJaBv/Pl5cHJr/Ja/ASL+F8+6YIbn12IE6juj2o31lBa0tLll9wtZgI
         krLksiU35BTpKt3u5rw7QDyK0+Zx2w6e9WL+WuJ/yqIhgzPYZxAI7ABtIyzidookZrgn
         q/hcebSbFfAT2tNeXfLNUYqFfSxZ8utPuWVHkVH30/qq5tXS9gEflSXv6Du3/ZQzJ3yG
         yk5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777468649; x=1778073449;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0uZhjPbSdYNEfdJ2xmxocjlnV7uXSsw+wopBLD2OHSc=;
        b=cOKMvfYWDkPs9BOLFOv22NC292Bs9/CCgIitbWZbCrf8xtbhVDY68BWwUKrAO61awl
         DecaOGi65nCV5147I/noZnGapLfOKtD1KGDTo85B6qBq648X6wAXnrk+4kkvdVEq3EeO
         BKaWq1sEPHUFca1xAfDbYlqON48r+fzqubtYtwVipkiyF8iymGESOhUtrHElt18GqDWT
         3D9CIdkxh52lFoZr7GO5O3/ixUmKunnbNU4T5joz4be7v0N1hqY+HhZsPV3458um50Iw
         SfABySnIrqXq8i/Jn9kYBETyYStTYRLOJshi2jV2mF2q+fuBdLmRjHzTjgCKzwYzO5O9
         zWiQ==
X-Forwarded-Encrypted: i=1; AFNElJ/siTf/7akNt1MIoUyWW2LKgsEzEHW8QRkhAtFse+kqrpouD+C48l/Nn70bt3PPRBrvAOsGmAmQgDM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyoF43E75N7gRMBwWtO5Wgmr9cJOdWHONjyrYF9lg/3RtThixdB
	deMfwAUd/BnzSCKDIoFlXCPXSuOrdiRFg467OODW+9Xz5SnDkNb8YUNU
X-Gm-Gg: AeBDievmD1s1hCG2xNCtMgEOG3k5I6iwuRtMdc4bIEPTC9YpSEXkxr77z+4VVaJLecY
	vZeWXUqtakaGruNIpOIuFK2zV1WacwDECrd63jagaQLDOI9BfbZ6VBFMwTKxVFkFnlXJMSyWV3/
	HNhth80HgjSX8/tWDukN1Y5zk+wI3tRJG9ClgRV4T7BfLJa2UEwYe+v27BrlT5lt2SlWXdECGfm
	e+NWWYKNAIxrt4S7mnN4FKnHCLnSJkwT3xJ2195u1N1JIS87tOKK0o999PGrWXPaGI5My2gY7VW
	vPhrkdeQt1hgfzaJES0eisB1qsDAMGb1rofRHW9ykCvjJnSEqsV1+AmT4ONFiR9V7LeJ9/lLv9W
	Qsjm/39SKGXI17kwFawUry8WPmCVKO8YfjPbRRayoUxoiRizW5WA+SFnbs4X4QNNc+XxUWXyjL+
	y8UZNMIDCLAGrEcz7hh52drHcZHLRZWdCPzhxVtUXCt3NTORf9qQ==
X-Received: by 2002:a05:6512:3ca1:b0:5a2:a36f:3ef4 with SMTP id 2adb3069b0e04-5a749d1fa92mr1719854e87.31.1777468649159;
        Wed, 29 Apr 2026 06:17:29 -0700 (PDT)
Received: from localhost.localdomain ([62.76.73.208])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5a74a6f318bsm558820e87.23.2026.04.29.06.17.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Apr 2026 06:17:28 -0700 (PDT)
From: Ilya Polyvyanyy <il.polyvyanyy@gmail.com>
To: Eugeniy.Paltsev@synopsys.com,
	vkoul@kernel.org
Cc: Frank.Li@kernel.org,
	dmaengine@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Ilya Polyvyanyy <il.polyvyanyy@gmail.com>
Subject: [PATCH] dmaengine: dw-axi-dmac: fix vchan teardown races and LLI dump bounds
Date: Wed, 29 Apr 2026 16:17:15 +0300
Message-ID: <20260429131718.2557247-1-il.polyvyanyy@gmail.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: DE4B8494BCA
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-10192-lists,dmaengine=lfdr.de];
	FREEMAIL_CC(0.00)[kernel.org,vger.kernel.org,gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ilpolyvyanyy@gmail.com,dmaengine@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[dmaengine];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_HAS_DN(0.00)[]

The channel teardown paths free descriptors/pools without synchronizing
virt-dma callbacks first. If the vchan tasklet is still running, descriptor
cleanup may race with callback processing and trigger use-after-free.

Call vchan_synchronize() in free_chan_resources() and terminate_all() to
drain pending tasklet activity before/after descriptor list cleanup.

Also fix axi_chan_list_dump_lli() to iterate over desc_head->nr_hw_descs
instead of the channel-wide descs_allocated counter. The old bound could
exceed the current descriptor array and cause out-of-bounds access in the
error-dump path.

Signed-off-by: Ilya Polyvyanyy <il.polyvyanyy@gmail.com>
---
 drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c b/drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c
index 4d53f077e..4c317ee82 100644
--- a/drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c
+++ b/drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c
@@ -553,6 +553,7 @@ static void dma_chan_free_chan_resources(struct dma_chan *dchan)
 
 	axi_chan_disable(chan);
 	axi_chan_irq_disable(chan, DWAXIDMAC_IRQ_ALL);
+	vchan_synchronize(&chan->vc);
 
 	vchan_free_chan_resources(&chan->vc);
 
@@ -1049,9 +1050,13 @@ static void axi_chan_dump_lli(struct axi_dma_chan *chan,
 static void axi_chan_list_dump_lli(struct axi_dma_chan *chan,
 				   struct axi_dma_desc *desc_head)
 {
-	int count = atomic_read(&chan->descs_allocated);
+	int count;
 	int i;
 
+	if (!desc_head || !desc_head->hw_desc)
+		return;
+
+	count = desc_head->nr_hw_descs;
 	for (i = 0; i < count; i++)
 		axi_chan_dump_lli(chan, &desc_head->hw_desc[i]);
 }
@@ -1206,6 +1211,7 @@ static int dma_chan_terminate_all(struct dma_chan *dchan)
 	spin_unlock_irqrestore(&chan->vc.lock, flags);
 
 	vchan_dma_desc_free_list(&chan->vc, &head);
+	vchan_synchronize(&chan->vc);
 
 	dev_vdbg(dchan2dev(dchan), "terminated: %s\n", axi_chan_name(chan));
 
-- 
2.54.0


