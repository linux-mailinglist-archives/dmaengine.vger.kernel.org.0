Return-Path: <dmaengine+bounces-9321-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +Kx3Lpb2rWnH+AEAu9opvQ
	(envelope-from <dmaengine+bounces-9321-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Sun, 08 Mar 2026 23:22:14 +0100
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 194BB232692
	for <lists+dmaengine@lfdr.de>; Sun, 08 Mar 2026 23:22:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8C3043009CC2
	for <lists+dmaengine@lfdr.de>; Sun,  8 Mar 2026 22:22:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3C353321D4;
	Sun,  8 Mar 2026 22:22:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mBiZufGw"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9FC8279798
	for <dmaengine@vger.kernel.org>; Sun,  8 Mar 2026 22:22:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773008523; cv=none; b=f9z66zavyR0putkeKbhY5QySDX8WjcKiDdC0UmP520uvEI/QhdQjXBxV3HaciwpNY0uKYK8s/J8ddFcMOpek9DmyRvm2QlIrVQvcPaPFzu7LhYqsyn3CfMPcKIi4AtmC2u/EU2btyB53PIuAqQpwo2KCMYzfrhmvxtCpFq+7jug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773008523; c=relaxed/simple;
	bh=nndh+a3GF6Dx34O1Z3osTj/jDZqj7Dm/ms8tc9Udpig=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=hY0C73JtMDo+sfN+DRndDwA93S00Vv5Cz7uwm4QDDwscWBSzq76M8UTXcXIdxd93cZLoYQLnyV/i3193RS2WUTxa3XypZPQGU1GGJQCWjCVc/9ZW562xqJv0klMEbBAt607KikJ+RHnPGP+gOnX2W1UAoNG4eGXLkceTxiJJP+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mBiZufGw; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2ae43042ea7so86479305ad.0
        for <dmaengine@vger.kernel.org>; Sun, 08 Mar 2026 15:22:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773008522; x=1773613322; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=sC+col1RB5k/y2v4aqOHES194K6Qsz6loLkbUW5Pqd8=;
        b=mBiZufGw6OBpTomUaoxprKJ98nIeky/inoAUyf4d5MmbW2aAtzRX9y6eiuQMMWikyC
         iTwVyc6/2s8+m5GTDVdmDlghegRBEPvuXBekOJ7ySSq7Nec/zAFohfNliyHRGLrcsbnv
         qdcCDkdyBjtTff/pjWRUiQ1hqmQe4ToTZYJTK+az1kOxU1+Ksp9R7t6HlEC9FncMKD+m
         BSbAN8MC5dZreCMJwPkxq1WAjZ6MWWD20Fo9cL53h9PJnlPmZsQWX2JCd0+ijOI1F6aS
         ZhJO3CtjNBVfyiuAqe7UN8R5S1EvGpK9ICRX6PBQpx1eivvIEso80tNwdXhwFNh3FVdJ
         c6fA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773008522; x=1773613322;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sC+col1RB5k/y2v4aqOHES194K6Qsz6loLkbUW5Pqd8=;
        b=ccEnfqga9LQ1A5dtYLiaDn8HikT2WV+15w5JNqN7XbKGKFc5Kvp/rWaMzfWWkmoPeF
         UjezMNF+wGrTjeHH8r6Gp63GDL5QzDjQFnNJMwGlt5lkWwjb8aJK9vxag+u4OQ33yo2A
         gyvNQnG/L+mlVSkNoZ28lEeFiXSqVKBb3JKkIdg9RJovX3ice4s86Jy7IZUb3bOvF3PD
         3OvdE/74x6wjiW1MNb7qHl3gTrU3ud3SErhcFwSzkViYcoYtHVnu4J/OUUGuzYWirf7L
         Cy4MkQUrsKhYdUD73aIBeYgCVPe7d0fTQ16bsY3eZHPDak1st82CW2LRXdASEfRKxrS9
         DjXw==
X-Gm-Message-State: AOJu0Yy1EPLDcq2uBcA2itUMFcxI07oR4MeERPJILk++banY9avwSeoM
	AkwM6tnKou4xyFKVRkjaTd/8qAiPEmAPpj+iPh7W7Zgn1BamHYNkCDdqsMGtmwFnCb8=
X-Gm-Gg: ATEYQzxY8Y+Y/YdaOCjVMOf9bnRzW3SDy5JATFIjvLLbxa0pYnyVZRYkkwkb6XU5X+0
	MQqcSIgLikv+vo6GFGFhNAHBqy3GHIJhMObdWqql8Ua91BKxPxGleE6EhvwKoTxigAP8Xiq7k38
	t60D6jEAMrdfkslYJegi1PRFtIHgovq+ZGLGQAdwbdU+17+O59t+LNkOdKIJjlm0UvkpjJOSVwP
	UhrcbWuczWtnLxxINKEFD+OntaSyl+4GWPR3KNeyWpZO4XWzU6Q8S1AClZyPVlPy9Vgb9NW8KII
	BUZlP3fcwb/mNoyiMVzT08TtOWsBsIMZ5kd3AdiGclGVVgZqan+2B5fo1pFmKqK0l45Ve63z50D
	AZVylhA0fdct+VRlz3Y+rEw2rezSOY4DkzdQYCeyfg5MiagxajIzD+lgBcD3zfSYNjKdS+9/5Dr
	JtocijPPJwmjQLimyXkc9suQ3vyDrt7gIP9deSta68PvT36BBeD/wHhg==
X-Received: by 2002:a17:903:234a:b0:2a7:5751:5b30 with SMTP id d9443c01a7336-2ae82366c40mr82171715ad.12.1773008521473;
        Sun, 08 Mar 2026 15:22:01 -0700 (PDT)
Received: from ryzen ([2601:644:8000:56f5::8bd])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ae83e57b1fsm117932915ad.12.2026.03.08.15.22.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Mar 2026 15:22:00 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: dmaengine@vger.kernel.org
Cc: Vinod Koul <vkoul@kernel.org>,
	Frank Li <Frank.Li@kernel.org>,
	Taichi Sugaya <sugaya.taichi@socionext.com>,
	Takao Orito <orito.takao@socionext.com>,
	Kees Cook <kees@kernel.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	linux-arm-kernel@lists.infradead.org (moderated list:ARM/MILBEAUT ARCHITECTURE),
	linux-kernel@vger.kernel.org (open list),
	linux-hardening@vger.kernel.org (open list:KERNEL HARDENING (not covered by other areas):Keyword:\b__counted_by(_le|_be)?\b)
Subject: [PATCH] dmaengine: milbeaut-hdmac: use kzalloc_flex
Date: Sun,  8 Mar 2026 15:21:43 -0700
Message-ID: <20260308222143.50186-1-rosenp@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 194BB232692
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-9321-lists,dmaengine=lfdr.de];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rosenp@gmail.com,dmaengine@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	NEURAL_HAM(-0.00)[-0.958];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_RCPT(0.00)[dmaengine];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Action: no action

Reduces allocation to a single one for simplicity.

Added __counted_by for extra runtime analysis.

Replace loop with memcpy. The loop adds no value here.

Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 drivers/dma/milbeaut-hdmac.c | 16 +++-------------
 1 file changed, 3 insertions(+), 13 deletions(-)

diff --git a/drivers/dma/milbeaut-hdmac.c b/drivers/dma/milbeaut-hdmac.c
index b4ebc09e80d0..2e15a2256b55 100644
--- a/drivers/dma/milbeaut-hdmac.c
+++ b/drivers/dma/milbeaut-hdmac.c
@@ -58,10 +58,10 @@
 
 struct milbeaut_hdmac_desc {
 	struct virt_dma_desc vd;
-	struct scatterlist *sgl;
 	unsigned int sg_len;
 	unsigned int sg_cur;
 	enum dma_transfer_direction dir;
+	struct scatterlist sgl[] __counted_by(sg_len);
 };
 
 struct milbeaut_hdmac_chan {
@@ -260,25 +260,16 @@ milbeaut_hdmac_prep_slave_sg(struct dma_chan *chan, struct scatterlist *sgl,
 {
 	struct virt_dma_chan *vc = to_virt_chan(chan);
 	struct milbeaut_hdmac_desc *md;
-	int i;
 
 	if (!is_slave_direction(direction))
 		return NULL;
 
-	md = kzalloc_obj(*md, GFP_NOWAIT);
+	md = kzalloc_flex(*md, sgl, sg_len, GFP_NOWAIT);
 	if (!md)
 		return NULL;
 
-	md->sgl = kzalloc_objs(*sgl, sg_len, GFP_NOWAIT);
-	if (!md->sgl) {
-		kfree(md);
-		return NULL;
-	}
-
-	for (i = 0; i < sg_len; i++)
-		md->sgl[i] = sgl[i];
-
 	md->sg_len = sg_len;
+	memcpy(md->sgl, sgl, sg_len * sizeof(*sgl));
 	md->dir = direction;
 
 	return vchan_tx_prep(vc, &md->vd, flags);
@@ -395,7 +386,6 @@ static void milbeaut_hdmac_desc_free(struct virt_dma_desc *vd)
 {
 	struct milbeaut_hdmac_desc *md = to_milbeaut_hdmac_desc(vd);
 
-	kfree(md->sgl);
 	kfree(md);
 }
 
-- 
2.53.0


