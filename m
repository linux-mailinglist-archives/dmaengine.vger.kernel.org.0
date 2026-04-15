Return-Path: <dmaengine+bounces-10016-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +Ah8D9MF32lLNwAAu9opvQ
	(envelope-from <dmaengine+bounces-10016-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Wed, 15 Apr 2026 05:28:19 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 999583FFFB9
	for <lists+dmaengine@lfdr.de>; Wed, 15 Apr 2026 05:28:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7D6C03018D71
	for <lists+dmaengine@lfdr.de>; Wed, 15 Apr 2026 03:28:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8E27314B9A;
	Wed, 15 Apr 2026 03:28:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="scHr2tsG"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-qk1-f181.google.com (mail-qk1-f181.google.com [209.85.222.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66CB4313532
	for <dmaengine@vger.kernel.org>; Wed, 15 Apr 2026 03:28:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776223695; cv=none; b=ApXMzoF0V9rrv2c1SR7HcWL2x/Xuo+NFLWL/DSi66yf7BrzqNWzwvRTvUOdV2vTcCHzkaeKMAD0JhyWZ6lsdZ/I9tTufL5DBMIsaaOKOc7ZgZDX+VYAvW7joV4Czz7wtJ5RP9+8FLbK6KV1L9cYjdIXtWXbc2Uw97Hv2XeaGFAQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776223695; c=relaxed/simple;
	bh=tCSW40mdJktOK1h1VfrP3QQE4ZWe+0q0/kLHOByHApk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=GTAPXA1qu2nMCeSh6A0tWoTcXprFVdQy/+NgEBHOgajkaZgOYS1VI2lkPNF3/QuYcBSIQcyTqW3UzpkGUH8aOjNwoDmMyRBv7sgEdWR8Yd0KDJ3Adx+U/BZJEA9CbXMejy/CkyEIi3mJkAlvR3k+Vof4QApSOJ5DvqktlaboR8g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=scHr2tsG; arc=none smtp.client-ip=209.85.222.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f181.google.com with SMTP id af79cd13be357-8d67a483d3eso672259985a.1
        for <dmaengine@vger.kernel.org>; Tue, 14 Apr 2026 20:28:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776223693; x=1776828493; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=rLKjOgt0prGno2etyoUy7FVuq/6O60livyoOWpMDLDg=;
        b=scHr2tsGPNkK0eklazc83dke/VS8irTYyGPxqKBfopPNepWMbvV1fpaf3p580DjFEm
         5rMXdhaysAAsPgts9ydlq4uyDJUJ6RNIvTR1Yv+3qwYvjjWljVoDv8TdO2OiMYJYRAnU
         +Xldqv0bawAhi07m21K5vtdwMWJDgc3SeVvEJE9xGRDVogJWypYSRx5oUPMQJYH1wo8H
         y207mW+yyiBzEuDmVUfCvK9QBokXDZfelieqPWMISNAKCZSvkbMWcSn7A/+htwsvLLvB
         yCJFq7eaSjAMqANQnS6VLVCydPbPPDvkwx7aXPT/riVTe/CHd2XUrp7o99SKX1+KT+r9
         DVZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776223693; x=1776828493;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rLKjOgt0prGno2etyoUy7FVuq/6O60livyoOWpMDLDg=;
        b=JPDkNuTK+eWJ4bT5+cNgpIpoRjLBdX5xEEAq/zMeYhKZwwCLJoHylbBsk6FfTU64Ax
         +RelkmFw/U81RspnqkFI3iA/yGCEejqorHQFgOvMsAjYz6mJiUSKw9quoNV8Msqd/s1M
         4ZxV1KB4mondXWA06lBAXqVFdapuh1uPI3QSdw/lV0kosfGDQChOOnLX4m9GmphqbgvE
         Sjnk6LPw3aCDFKttk8QhEwqP3FdDO7xKtna8+sZTxd8p6yosMtBu+AQcTjZP505WIOiF
         V6RV+U/J1VqjqF2odcAp2L0nW5dk5Z9uC8kEYcuKV7V8JC2dygnLZ9XxApLZNo9oYLJV
         uq1w==
X-Gm-Message-State: AOJu0YwcRKLOWKVqgQ2DTMBoqDsi8uMAoIMXGvZiKAFLn3zOFumeOev3
	ka24TEqbmRHPLiM+r2xdeUNlopGgxV+0yXkMB6ypzZj6KZ7YfZmC+MsHKCEUAA==
X-Gm-Gg: AeBDiesuKDZTjpp1lAXjrCYQtZ8y1QG1PhDPky4qZks7zGkpoO+p4ZMgAWhrH7nJHVG
	uXbFlFQuFTFPQELjjKkYB64i8PYMmR+Z8NJ0HSXK6K1Z7usOFtmgv92gli2xl6qRzZR5UP1Wm4u
	jjhOABbBIXGtF+SbsRwLKcI/+EeAppegs7B8FLAIagcUT7ngcLazKPqsto6zLHxIy55ZsYfqADL
	LxYc1ALvyemlsujDhBzbr3oIdMvWqbGugtZesmSyAYesFMm1d64BE27mMPZclhKbI4bxBzS0AxA
	FrXYf2jbD9z3UaXRzMKbxkLD1GIY4gzL8GHOR7CBZ2VqZ6eIAf4+u5azwEeM5hKlFAv8C0OVYl0
	Qjpt2vz/pqx8Q5kNsw5Bmv0qepjvdKD1+csCFkiBDwWu/5fJhuyIU0y1FZ4xLKprpl82fwm2OCV
	nPc/tV84pm/u7wt74lc7+9fA65Z5/wCf4iV5uU7NODfs2vcJN1i+LWQuI=
X-Received: by 2002:ac8:5f88:0:b0:50d:6838:964c with SMTP id d75a77b69052e-50dd5af0776mr330945371cf.18.1776223693139;
        Tue, 14 Apr 2026 20:28:13 -0700 (PDT)
Received: from ryzen ([2601:644:8000:5b5d::8bf])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8ae6c974c2esm2578556d6.17.2026.04.14.20.28.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Apr 2026 20:28:12 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: dmaengine@vger.kernel.org
Cc: Andy Shevchenko <andy@kernel.org>,
	Vinod Koul <vkoul@kernel.org>,
	Frank Li <Frank.Li@kernel.org>,
	Kees Cook <kees@kernel.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	linux-kernel@vger.kernel.org (open list:INTEL MID (Mobile Internet Device) PLATFORM),
	linux-hardening@vger.kernel.org (open list:KERNEL HARDENING (not covered by other areas):Keyword:\b__counted_by(_le|_be)?\b)
Subject: [PATCHv4] dmaengine: hsu: use kzalloc_flex()
Date: Tue, 14 Apr 2026 20:27:53 -0700
Message-ID: <20260415032753.6006-1-rosenp@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-10016-lists,dmaengine=lfdr.de];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rosenp@gmail.com,dmaengine@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_RCPT(0.00)[dmaengine];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 999583FFFB9
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Simplifies allocations by using a flexible array member in this struct.

Remove hsu_dma_alloc_desc(). It now offers no readability advantages in
this single usage.

Add __counted_by to get extra runtime analysis.

Apply the exact same treatment to struct hsu_dma and devm_kzalloc().

Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 v4: move back counting variable assignment, as requested.
 v3: update description.
 v2: address review comments.
 drivers/dma/hsu/hsu.c | 43 +++++++++++--------------------------------
 drivers/dma/hsu/hsu.h |  4 ++--
 2 files changed, 13 insertions(+), 34 deletions(-)

diff --git a/drivers/dma/hsu/hsu.c b/drivers/dma/hsu/hsu.c
index f62d60d7bc6b..b1dd4fd1109b 100644
--- a/drivers/dma/hsu/hsu.c
+++ b/drivers/dma/hsu/hsu.c
@@ -241,28 +241,10 @@ int hsu_dma_do_irq(struct hsu_dma_chip *chip, unsigned short nr, u32 status)
 }
 EXPORT_SYMBOL_GPL(hsu_dma_do_irq);

-static struct hsu_dma_desc *hsu_dma_alloc_desc(unsigned int nents)
-{
-	struct hsu_dma_desc *desc;
-
-	desc = kzalloc_obj(*desc, GFP_NOWAIT);
-	if (!desc)
-		return NULL;
-
-	desc->sg = kzalloc_objs(*desc->sg, nents, GFP_NOWAIT);
-	if (!desc->sg) {
-		kfree(desc);
-		return NULL;
-	}
-
-	return desc;
-}
-
 static void hsu_dma_desc_free(struct virt_dma_desc *vdesc)
 {
 	struct hsu_dma_desc *desc = to_hsu_dma_desc(vdesc);

-	kfree(desc->sg);
 	kfree(desc);
 }

@@ -276,10 +258,15 @@ static struct dma_async_tx_descriptor *hsu_dma_prep_slave_sg(
 	struct scatterlist *sg;
 	unsigned int i;

-	desc = hsu_dma_alloc_desc(sg_len);
+	desc = kzalloc_flex(*desc, sg, sg_len, GFP_NOWAIT);
 	if (!desc)
 		return NULL;

+	desc->nents = sg_len;
+	desc->direction = direction;
+	/* desc->active = 0 by kzalloc */
+	desc->status = DMA_IN_PROGRESS;
+
 	for_each_sg(sgl, sg, sg_len, i) {
 		desc->sg[i].addr = sg_dma_address(sg);
 		desc->sg[i].len = sg_dma_len(sg);
@@ -287,11 +274,6 @@ static struct dma_async_tx_descriptor *hsu_dma_prep_slave_sg(
 		desc->length += sg_dma_len(sg);
 	}

-	desc->nents = sg_len;
-	desc->direction = direction;
-	/* desc->active = 0 by kzalloc */
-	desc->status = DMA_IN_PROGRESS;
-
 	return vchan_tx_prep(&hsuc->vchan, &desc->vdesc, flags);
 }

@@ -428,22 +410,19 @@ int hsu_dma_probe(struct hsu_dma_chip *chip)
 {
 	struct hsu_dma *hsu;
 	void __iomem *addr = chip->regs + chip->offset;
+	unsigned short nr_channels;
 	unsigned short i;
 	int ret;

-	hsu = devm_kzalloc(chip->dev, sizeof(*hsu), GFP_KERNEL);
+	/* Calculate nr_channels from the IO space length */
+	nr_channels = (chip->length - chip->offset) / HSU_DMA_CHAN_LENGTH;
+	hsu = devm_kzalloc(chip->dev, struct_size(hsu, chan, nr_channels), GFP_KERNEL);
 	if (!hsu)
 		return -ENOMEM;

 	chip->hsu = hsu;

-	/* Calculate nr_channels from the IO space length */
-	hsu->nr_channels = (chip->length - chip->offset) / HSU_DMA_CHAN_LENGTH;
-
-	hsu->chan = devm_kcalloc(chip->dev, hsu->nr_channels,
-				 sizeof(*hsu->chan), GFP_KERNEL);
-	if (!hsu->chan)
-		return -ENOMEM;
+	hsu->nr_channels = nr_channels;

 	INIT_LIST_HEAD(&hsu->dma.channels);
 	for (i = 0; i < hsu->nr_channels; i++) {
diff --git a/drivers/dma/hsu/hsu.h b/drivers/dma/hsu/hsu.h
index 3bca577b98a1..f6ca1014bccf 100644
--- a/drivers/dma/hsu/hsu.h
+++ b/drivers/dma/hsu/hsu.h
@@ -71,11 +71,11 @@ struct hsu_dma_sg {
 struct hsu_dma_desc {
 	struct virt_dma_desc vdesc;
 	enum dma_transfer_direction direction;
-	struct hsu_dma_sg *sg;
 	unsigned int nents;
 	size_t length;
 	unsigned int active;
 	enum dma_status status;
+	struct hsu_dma_sg sg[] __counted_by(nents);
 };

 static inline struct hsu_dma_desc *to_hsu_dma_desc(struct virt_dma_desc *vdesc)
@@ -115,8 +115,8 @@ struct hsu_dma {
 	struct dma_device		dma;

 	/* channels */
-	struct hsu_dma_chan		*chan;
 	unsigned short			nr_channels;
+	struct hsu_dma_chan		chan[] __counted_by(nr_channels);
 };

 static inline struct hsu_dma *to_hsu_dma(struct dma_device *ddev)
--
2.53.0


