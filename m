Return-Path: <dmaengine+bounces-10964-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UGYRHwD/FWozgwcAu9opvQ
	(envelope-from <dmaengine+bounces-10964-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Tue, 26 May 2026 22:13:52 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A8C0F5DC3EC
	for <lists+dmaengine@lfdr.de>; Tue, 26 May 2026 22:13:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 585353036414
	for <lists+dmaengine@lfdr.de>; Tue, 26 May 2026 20:13:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1300B3B7773;
	Tue, 26 May 2026 20:13:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I6IncZVV"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88B503B2FD4
	for <dmaengine@vger.kernel.org>; Tue, 26 May 2026 20:13:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779826428; cv=none; b=gFv3LQPD/NjCAFVw/4BA/Z9qQJ2t6CsTw1XyOIN1a2GmUoCmbMsKADMt3MbjQewkFIlerFnEJBiznSZi46OSnW/zEKOWtSlACCRA94uu2rGhXg0ItCwWfHIosP8EXCzQmena5Ybp7WukBvyQVeWUVKGUFPsGjyeIlno7ENy7Ok0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779826428; c=relaxed/simple;
	bh=0yozOr3YMMLvIJ7Pg2i20S4dujIxpKQywfb9wu2kFuU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=PrNLOCj4JOqEJya6SqAg+NMLgL7N8P1Pk9j5EuvROwwk4e7dowyCBKlYPWfly+dZorselvucGh0Vp+HY2xFXAnHWeh1cldExYjWSqAuMP+nDZkYhX2DwKMcF5NjEQ0Jd67J77qRcNOwY8I5f0aodP5bLI6TTCXuMPxtMGM6lBS8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=I6IncZVV; arc=none smtp.client-ip=209.85.160.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-50e614fdb42so85761351cf.3
        for <dmaengine@vger.kernel.org>; Tue, 26 May 2026 13:13:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779826425; x=1780431225; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=AWd93ZUjTZ6c+vkNq74krCnjTZmGTPFD0wYAFgGdBDk=;
        b=I6IncZVVMPbK8qkIkNla8FiG+HVGxUDKYhD/3gr+T7fKtXtHqBgxfzrBr3RkjeT6D1
         kgxgMqV90GhpkpY/vvjttREv3OugL5UxQ+hvZH64Jbvm5XOHlBx+JyTk5aPEunU9S7t3
         4pD2gImFalLPVS6BS05diuIGsSQ9geMdTygFxlVC7+a084oc+HXZ0AOUo4qRfySFGk2f
         WPKSr3m+BJhnlMbfOzrub4qomWk0zskIOJjiNpTThGNLE+V8RY+h/TKYmM69hQDaCCHg
         mBLRp3N17Bey7sbnIh5u//YFMBDYh3VLyADerV6UnkmsjgeDDp6J4yeqD+aLoOln0KcL
         MeKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779826425; x=1780431225;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AWd93ZUjTZ6c+vkNq74krCnjTZmGTPFD0wYAFgGdBDk=;
        b=DbMRegSqmzA1wzrWWopCcmQCpdcSvLYlNbySF0rkO8XSMn1MTbX/vp0Ql2XR0KPSUF
         oPNoAICjwVtbntd0gUuMGCAFnKGZR+gby59kaYQZbJVUAK6bkf1WYVr8DWuQd2swygHR
         wm7jsfIfN1Gk9UQxOvmvxeS/CK+IsZYo7xEm+s3/YRHigolrs1FkFpxIGVMNHu3PaLAQ
         HQ9aEF7GQ2BAUS8sfJJOdxqBCVTvAAFGIeuGGkXdsdibrSCm6kyNwiiqxv0JphD4s+vs
         ZeZ0sYfQFxwp4Wszy98wJOmn/calxv1yjRG+hcb6XMkVGpsAK7uHEEFPdZtu8bSh7av+
         nNlA==
X-Gm-Message-State: AOJu0YxGIZS2zfoAMjRImdsG5ZJd1oWoA4QzvCgxVGJFGPDwMfW+SZMg
	2L+wBkMTqYJoOEYgAwQ0cgxSt1MfQd6SZsBjCKOE2LJmgM5X7p7Gqt0HRZtynbQm
X-Gm-Gg: Acq92OFSGS4EeXQauxbSFQ762Uv+3w57CAG9JL/A8eBgbzQgrygUU2YtVDwubEV/y1w
	Cu99QgsxqQeMp9tT7Y82zMfM3sd4qh0gsW+3IZ5b87KuYnk8R5l3AFg8/49ZLT0vo+Ny81SBdS6
	FWeqssH4KEt6IJavq1hmYzKvQAy3z6bvgFOaFRcDm9ga870QXgWH6IaWbz3E69aXwDzq+zrjJ0O
	GH5HMGHxyTboRujArP9SEqROLu7jjw3MKyxZ3k4Kp6bgoAnDH6DqAm5pQmZ9yd5I9XlVBwZu8/u
	WDYwrPTDeYiplgzwhlleD5CpHFQ/UFt7J6F5kT4DWDIwVknN2miheGibfW4oSiZW/mT5YZ4MTPw
	gkIB4nklbgFrH32nhCpyvpZlzpqMYP998TwuHx0JKAg1nWNWplfeyGDs1p/3g9EiBcYXshvVrWl
	UWGNGxLr9Rc+M0p/lRhFo4TWeX06FTk9L3C3lVsUCyltOcB6L3J3kgbD/KqI8nziH4WAXC0Ub+u
	zj8XgDUTzszhMbb4UKNSAdjTbatTyUKyBI=
X-Received: by 2002:a05:622a:8597:b0:50e:601a:2183 with SMTP id d75a77b69052e-516d440a362mr225416341cf.41.1779826424957;
        Tue, 26 May 2026 13:13:44 -0700 (PDT)
Received: from ryzen ([2601:644:8000:5b5d:7285:c2ff:fe45:8a32])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-5170b691d15sm15563071cf.11.2026.05.26.13.13.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 May 2026 13:13:44 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: dmaengine@vger.kernel.org
Cc: Peter Ujfalusi <peter.ujfalusi@gmail.com>,
	linusw@kernel.org,
	Vinod Koul <vkoul@kernel.org>,
	Frank Li <Frank.Li@kernel.org>,
	Kees Cook <kees@kernel.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	linux-kernel@vger.kernel.org (open list),
	linux-hardening@vger.kernel.org (open list:KERNEL HARDENING (not covered by other areas):Keyword:\b__counted_by(_le|_be|_ptr)?\b)
Subject: [PATCHv2] dmaengine: ti: omap-dma: turn lch_map into a flexible array
Date: Tue, 26 May 2026 13:13:27 -0700
Message-ID: <20260526201327.13225-1-rosenp@gmail.com>
X-Mailer: git-send-email 2.54.0
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
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,kernel.org,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-10964-lists,dmaengine=lfdr.de];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rosenp@gmail.com,dmaengine@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_RCPT(0.00)[dmaengine];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: A8C0F5DC3EC
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Convert the separately-allocated lch_map pointer array to a C99
flexible array member at the end of struct omap_dmadev and annotate it
with __counted_by(lch_count). The probe is reordered so platform_data
lookup and the lch_count determination happen before the parent
allocation, letting struct_size() size the FAM and the dedicated
devm_kcalloc() for lch_map go away.

Two allocations collapse into one and the runtime bounds checks from
__counted_by now apply to every lch_map[] access.

Assisted-by: Claude:Opus-4.7
Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 v2: fix sashiko warnings
 drivers/dma/ti/omap-dma.c | 73 ++++++++++++++++++++-------------------
 1 file changed, 37 insertions(+), 36 deletions(-)

diff --git a/drivers/dma/ti/omap-dma.c b/drivers/dma/ti/omap-dma.c
index 55ece7fd0d99..0cccd6663628 100644
--- a/drivers/dma/ti/omap-dma.c
+++ b/drivers/dma/ti/omap-dma.c
@@ -57,7 +57,7 @@ struct omap_dmadev {
 	unsigned dma_requests;
 	spinlock_t irq_lock;
 	uint32_t irq_enable_mask;
-	struct omap_chan **lch_map;
+	struct omap_chan *lch_map[] __counted_by(lch_count);
 };
 
 struct omap_chan {
@@ -1656,36 +1656,55 @@ static const struct omap_dma_config default_cfg;
 static int omap_dma_probe(struct platform_device *pdev)
 {
 	const struct omap_dma_config *conf;
+	struct omap_system_dma_plat_info *plat;
 	struct omap_dmadev *od;
+	int lch_count;
 	int rc, i, irq;
 	u32 val;
 
-	od = devm_kzalloc(&pdev->dev, sizeof(*od), GFP_KERNEL);
-	if (!od)
-		return -ENOMEM;
-
-	od->base = devm_platform_ioremap_resource(pdev, 0);
-	if (IS_ERR(od->base))
-		return PTR_ERR(od->base);
-
 	conf = of_device_get_match_data(&pdev->dev);
 	if (conf) {
-		od->cfg = conf;
-		od->plat = dev_get_platdata(&pdev->dev);
-		if (!od->plat) {
+		plat = dev_get_platdata(&pdev->dev);
+		if (!plat) {
 			dev_err(&pdev->dev, "omap_system_dma_plat_info is missing");
 			return -ENODEV;
 		}
 	} else if (IS_ENABLED(CONFIG_ARCH_OMAP1)) {
-		od->cfg = &default_cfg;
-
-		od->plat = omap_get_plat_info();
-		if (!od->plat)
+		plat = omap_get_plat_info();
+		if (!plat)
 			return -EPROBE_DEFER;
 	} else {
 		return -ENODEV;
 	}
 
+	/* Number of available logical channels */
+	if (!pdev->dev.of_node) {
+		lch_count = plat->dma_attr->lch_count;
+		if (unlikely(!lch_count))
+			lch_count = OMAP_SDMA_CHANNELS;
+	} else if (of_property_read_u32(pdev->dev.of_node, "dma-channels", &lch_count)) {
+		dev_info(&pdev->dev, "Missing dma-channels property, using %u.\n",
+			 OMAP_SDMA_CHANNELS);
+		lch_count = OMAP_SDMA_CHANNELS;
+	}
+
+	if (lch_count > OMAP_SDMA_CHANNELS) {
+		dev_err(&pdev->dev, "invalid dma-channels value %u\n", lch_count);
+		return -EINVAL;
+	}
+
+	od = devm_kzalloc(&pdev->dev, struct_size(od, lch_map, lch_count), GFP_KERNEL);
+	if (!od)
+		return -ENOMEM;
+
+	od->lch_count = lch_count;
+	od->plat = plat;
+	od->cfg = conf ? conf : &default_cfg;
+
+	od->base = devm_platform_ioremap_resource(pdev, 0);
+	if (IS_ERR(od->base))
+		return PTR_ERR(od->base);
+
 	od->reg_map = od->plat->reg_map;
 
 	dma_cap_set(DMA_SLAVE, od->ddev.cap_mask);
@@ -1730,19 +1749,6 @@ static int omap_dma_probe(struct platform_device *pdev)
 			 OMAP_SDMA_REQUESTS);
 	}
 
-	/* Number of available logical channels */
-	if (!pdev->dev.of_node) {
-		od->lch_count = od->plat->dma_attr->lch_count;
-		if (unlikely(!od->lch_count))
-			od->lch_count = OMAP_SDMA_CHANNELS;
-	} else if (of_property_read_u32(pdev->dev.of_node, "dma-channels",
-					&od->lch_count)) {
-		dev_info(&pdev->dev,
-			 "Missing dma-channels property, using %u.\n",
-			 OMAP_SDMA_CHANNELS);
-		od->lch_count = OMAP_SDMA_CHANNELS;
-	}
-
 	/* Mask of allowed logical channels */
 	if (pdev->dev.of_node && !of_property_read_u32(pdev->dev.of_node,
 						       "dma-channel-mask",
@@ -1754,12 +1760,6 @@ static int omap_dma_probe(struct platform_device *pdev)
 	if (od->plat->dma_attr->dev_caps & HS_CHANNELS_RESERVED)
 		bitmap_set(od->lch_bitmap, 0, 2);
 
-	od->lch_map = devm_kcalloc(&pdev->dev, od->lch_count,
-				   sizeof(*od->lch_map),
-				   GFP_KERNEL);
-	if (!od->lch_map)
-		return -ENOMEM;
-
 	for (i = 0; i < od->dma_requests; i++) {
 		rc = omap_dma_chan_init(od);
 		if (rc) {
@@ -1828,6 +1828,7 @@ static int omap_dma_probe(struct platform_device *pdev)
 			if (od->ll123_supported)
 				dma_pool_destroy(od->desc_pool);
 			omap_dma_free(od);
+			return rc;
 		}
 	}
 
@@ -1852,7 +1853,7 @@ static void omap_dma_remove(struct platform_device *pdev)
 	struct omap_dmadev *od = platform_get_drvdata(pdev);
 	int irq;
 
-	if (od->cfg->may_lose_context)
+	if (od->cfg->needs_busy_check || od->cfg->may_lose_context)
 		cpu_pm_unregister_notifier(&od->nb);
 
 	if (pdev->dev.of_node)
-- 
2.54.0


