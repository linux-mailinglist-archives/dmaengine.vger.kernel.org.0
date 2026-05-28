Return-Path: <dmaengine+bounces-11022-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cCnlA0XRGGqunggAu9opvQ
	(envelope-from <dmaengine+bounces-11022-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Fri, 29 May 2026 01:35:33 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id A4B825FB74F
	for <lists+dmaengine@lfdr.de>; Fri, 29 May 2026 01:35:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 61BA8300AB1D
	for <lists+dmaengine@lfdr.de>; Thu, 28 May 2026 23:35:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46B66366DB4;
	Thu, 28 May 2026 23:35:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iJF0fj93"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBFFB324B2C
	for <dmaengine@vger.kernel.org>; Thu, 28 May 2026 23:35:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780011328; cv=none; b=UV8Sx76/DQ9fC2SkErDpgNf3JPtvN6Yv//jf7kHgtlw5QIcEhjo1UjmDDUfqNdYjVYB1Ka4Bfm2lNmDvd0jaozy76/jn4ByWB7nBwCMo2DXtFwvEYdJUNbuMirLba73YvsOXI2ShyKKWlCmMNSBmAIJjCChTCDLDi4TLkRm8OhM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780011328; c=relaxed/simple;
	bh=9pKtI2QgcaBOz0lUGXwCQ1mn7dz+nAgtsXGXTfTDCd8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=sg6Hcg7Geq+0Gu2DtEtKiAHDHoP8ikLQDB9+TcenV30pnbUqGEiGLYoNqaOaMtsVlWLgQuSKQaG/7Mnc8bQfiWDE70WbErAyiijDwAkzU0ozMGfGR7WOjAUbYmZ4C9ekKoN4+x/e+j6bGa2OxlaKz2hYe7kjZs2sdrtcrZR2SCU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iJF0fj93; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-82f8893bff3so6237837b3a.2
        for <dmaengine@vger.kernel.org>; Thu, 28 May 2026 16:35:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780011326; x=1780616126; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=sFFR7mhAlYa32tib5Eg4h8cRwr9DtOLR8Gu0te51xXw=;
        b=iJF0fj93JQdIWKig46zgk0DlR+moi4NdSiMH7RYglu3x083jYtE0QtOQePRAW0nNSg
         stwdGQqHF3pPPswjQBcxX0SpJS1HU+FYBBo84yNmkCRfgxJntHHmspaNVQYLbURvl8Gq
         KlKV+XywHc6SEXGsgEC/zSiUNVxY+YryR33pdQrDAAMIk4X5nklf6dNycLkftPE1zl+m
         dPHlzoarq4k6r6vgzOblapUkxuziG3gisOVWcqGaR9KoGOo4hPB8hKSMbj+yY4/XxUuA
         h8DZ6kCi7bXeO2Jwo+/UHd/K1txIAwsJX0QhkcMQMlHdP1jqZ+bvk9sfKfvu0LTNlsDb
         BZ+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780011326; x=1780616126;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sFFR7mhAlYa32tib5Eg4h8cRwr9DtOLR8Gu0te51xXw=;
        b=dPhVUL7XP4fo/iXUSTWg8ZsdOSrZ6FT6Rsw5I4cYBs5JuqeoAQYeJ4ZRbhPBvN5gl4
         Lx7Nc2k9GJfXdr+7xkCYESb50DiPZzCvfRg7vbdOp8j0EoMo2vmVvSEjLDVA5sNj+COP
         dMUE3IW937UYt3HBOM9ap+i5vZa6qeqWFXbhyCDj6OGK+GzlD2+4HkID9RbfsTKcHbuP
         cSGDj9at/Y/8Eo+gdZOl5yXsWudsfrxsMNOOt2Asqjxujh17ApxBH3nC2KMpMyUmPMOH
         JikDncRx2hUr5sCJpNPugPDTEYHE4mADWxuYY/7yNzKBlr1UwIty+PuF5WizFF7ZRffa
         NNEA==
X-Gm-Message-State: AOJu0YwrzmFLd5EcHmIeCQOMAXWF857IomUMiKo125SQHy+F92GPkGue
	PsGI9wn27Qr10Wa90YVB5N2/cR1AbAJaa+AnZbWUbb04GOZR8qGFaujDo3960II6
X-Gm-Gg: Acq92OErLSMNR4N7xxovnfZ7pIxi/pIR+8WSbymxW9abKPgFbjuSLxIb/ftZqI7NW86
	sgd+Eyiboyjwf9AxcJRj5o+QBCeubmw31t64Upj/B3xXdeBJcJijjAls9QeKxXriHQF1N1eFBlg
	EztowguIUJXLCL1sD98J/X+GOH9wsrt+TFPOhZUrP9iArfFNHb42dZAj3P/COJ5y441LV26TL/v
	qv/J+FlJbVmTjnzltfzRGr+xibL3f/upH2yCjwwSbBralYQJds0N9Cz4Xb9w4p5C8D1DpzCOS7C
	QNtR3rgxH5XTpFJG+EChuhwHJs4cjpKq0YQ7z2VcntbIi9SnQlbGSL67GJvobCZJLQChhrQyiIZ
	Y8RmqAPJidYBWZqSXqr38g+vyZY4g65WHS63Gx48T1kQaWJ3/7TtZHN94IfVDB68SY6rLw4VlPl
	HK2e0SQL8qengYEnaEZV/rjtz3Y8MsfckX1yZQPpEfUcM+1wPbXMisdiB66QOH65ZdoNucfehI7
	iFuGcQR6WdEUbiVnjrV7Qsk7Zz4lMqf9/QOczkAtz0G0Q==
X-Received: by 2002:a05:6a00:1906:b0:829:809e:8977 with SMTP id d2e1a72fcca58-84212dab758mr285424b3a.49.1780011325851;
        Thu, 28 May 2026 16:35:25 -0700 (PDT)
Received: from ryzen ([2601:644:8000:5b5d:7285:c2ff:fe45:8a32])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8421310d01dsm78111b3a.15.2026.05.28.16.35.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 May 2026 16:35:25 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: dmaengine@vger.kernel.org
Cc: Peter Ujfalusi <peter.ujfalusi@gmail.com>,
	Vinod Koul <vkoul@kernel.org>,
	Frank Li <Frank.Li@kernel.org>,
	Kees Cook <kees@kernel.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	linux-kernel@vger.kernel.org (open list),
	linux-hardening@vger.kernel.org (open list:KERNEL HARDENING (not covered by other areas):Keyword:\b__counted_by(_le|_be|_ptr)?\b)
Subject: [PATCHv3] dmaengine: ti: omap-dma: turn lch_map into a flexible array
Date: Thu, 28 May 2026 16:35:07 -0700
Message-ID: <20260528233507.305178-1-rosenp@gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,kernel.org,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-11022-lists,dmaengine=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Queue-Id: A4B825FB74F
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

Add some fixes reported by Sashiko. Missing return and missing check for
needs_busy_check. Also a free_irq ordering issue.

Assisted-by: Claude:Opus-4.7
Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 v3: fix sashiko warnings again
 v2: fix sashiko warnings
 drivers/dma/ti/omap-dma.c | 82 ++++++++++++++++++++-------------------
 1 file changed, 42 insertions(+), 40 deletions(-)

diff --git a/drivers/dma/ti/omap-dma.c b/drivers/dma/ti/omap-dma.c
index 55ece7fd0d99..7c46be2755be 100644
--- a/drivers/dma/ti/omap-dma.c
+++ b/drivers/dma/ti/omap-dma.c
@@ -48,7 +48,7 @@ struct omap_dmadev {
 	const struct omap_dma_config *cfg;
 	struct notifier_block nb;
 	struct omap_dma_context context;
-	int lch_count;
+	u32 lch_count;
 	DECLARE_BITMAP(lch_bitmap, OMAP_SDMA_CHANNELS);
 	struct mutex lch_lock;		/* for assigning logical channels */
 	bool legacy;
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
+	u32 lch_count;
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

@@ -1852,17 +1853,18 @@ static void omap_dma_remove(struct platform_device *pdev)
 	struct omap_dmadev *od = platform_get_drvdata(pdev);
 	int irq;

-	if (od->cfg->may_lose_context)
+	if (od->cfg->needs_busy_check || od->cfg->may_lose_context)
 		cpu_pm_unregister_notifier(&od->nb);

 	if (pdev->dev.of_node)
 		of_dma_controller_free(pdev->dev.of_node);

-	irq = platform_get_irq(pdev, 1);
-	devm_free_irq(&pdev->dev, irq, od);
-
 	dma_async_device_unregister(&od->ddev);

+	irq = platform_get_irq(pdev, 1);
+	if (irq > 0)
+		devm_free_irq(&pdev->dev, irq, od);
+
 	if (!omap_dma_legacy(od)) {
 		/* Disable all interrupts */
 		omap_dma_glbl_write(od, IRQENABLE_L0, 0);
--
2.54.0


