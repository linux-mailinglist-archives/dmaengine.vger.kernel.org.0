Return-Path: <dmaengine+bounces-10778-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QEZOJpFmEmojzAYAu9opvQ
	(envelope-from <dmaengine+bounces-10778-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Sun, 24 May 2026 04:46:41 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BADF5C1278
	for <lists+dmaengine@lfdr.de>; Sun, 24 May 2026 04:46:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 0DC8C3006024
	for <lists+dmaengine@lfdr.de>; Sun, 24 May 2026 02:46:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2859825B098;
	Sun, 24 May 2026 02:46:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XtEhhAgq"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A494223EAA4
	for <dmaengine@vger.kernel.org>; Sun, 24 May 2026 02:46:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779590794; cv=none; b=IIaY/l3+JzSgrYiwcTFXmesGnfP2jHMnQt3d4kuJ5FvF6wbxLakHcVqvsih1nUNILaMC1I++CGyLcIr79vBn2E4kcPIkTH6FbFR6hAj/UFynlHOfsDf7qBytls1PHmX2rRFYt132n7jrIXQuF2ZP6VuG3S+VBfooEyDhaI5juq0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779590794; c=relaxed/simple;
	bh=sd0brhKuTlvue1GF0dLTVV6+UoCkGinBIuinD5unjEQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=BO9tfKfML9cg15Y/x7YTe00L3zn0LUBlmZ1Fn81w1m7/NDvqXEtKlJRYQNKDQMKqP7bXd7s78RomGdFCnMstP/FLOdgtsvdbKgPNf9xCmgNRP7ZJRwk8HyAmt2vUergYnILs7TT9CwlKRL11lij2ZmJljLBjQM+jqPyv6OFJXl0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XtEhhAgq; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-834f1075805so6658317b3a.2
        for <dmaengine@vger.kernel.org>; Sat, 23 May 2026 19:46:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779590792; x=1780195592; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ciC6AwMqgRoG5tvc6gb6RBuyhx3t8/VvHt7IHCf9iAc=;
        b=XtEhhAgqYnOQmND9BxFvLocCL3b1cSimjJ1rIkNdPm4LBxFpcQeCXnr+VB6y+3e5MW
         vn/eNPIL5MTV/r+6LFiwsuYX1oJbpBQRwr5iB31DuJNIC8hDvVIQBzndtV12Xc4IHJlC
         JrBW95e6EkHxBmCN26uP5ARGk1rz0EKT6ry7WS4JlcnfFUojiZTXX53pbrMZd3TIVw7e
         e1hGOOwrYS1bM+wh75TZeZHQLoOdueLDo7b/OhDkVM73Y2/Fj/5MXgS6mzXYQ3W7yYYx
         yKBWVyqBHu88C6JZm0gzppjw6H2IBSsuHi0lsddlBC6Sg1Rf3BXtBE7CWyM7SKGtQrgv
         g74Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779590792; x=1780195592;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ciC6AwMqgRoG5tvc6gb6RBuyhx3t8/VvHt7IHCf9iAc=;
        b=LV4sGZsWIeLFXjtsdZIpnad4rkDjoVIlQ9vNcSLxaTOB+Db85Ev1yTjJTSFwcRgJhx
         k1MevQWlmfKXGUydiB1rNPzP99vE0ZcK5jdZZH41d44th5QbHDilrB1K72utteLj02Kh
         G72D6KzHCu6R+AmO6fjpruKOtspYAT/XxEn+1ZO3gZPEEuRnGyVH4+IFdjBStl3RRMch
         0P1qThm5Y6ln1ogLLYtP8qpxvV2QNNn31dDoW0uQCsQIIE1XNvbFHZJ3ZNyioPtt/1So
         56zN6KVhD8NjIXuwRwzSAqIgJgraI4xw3EecO6a5hqpZzIVnnUeulvKF6vYQzCbDkAp+
         NO4Q==
X-Gm-Message-State: AOJu0YxS77/geE7VzvRnM8O2rHWYJtClRZhxdRTGZlxqKZ3f5senZlci
	etg3XLMAuvwIp9xSUhqYz71ao1A9DAgoYyNhtcUKhQH4bifkWMdi7UpkOJ2ABQ==
X-Gm-Gg: Acq92OFqKZdP2w4CpnzTa2ydqo5QpcCcb2Q+X9tTajPG3l4Sbxqb5+b9xDQ5hcBNxL2
	TU/iWUl+b3MgJHUMowaKlo3xDq6swQd3Ghrsjb6M/xM23Mg/S76UgHuvZL1PGSKoL+e4sCPN0Le
	K1Jtfd+HKOCNSkto6ArPv+bjgpNJvgSZf2vsYwdbVtWN5Eyx0UdxTQJyY/FADW+1okVSGONVWAf
	D0dweoSLD7U0tMQRgddXwX6pUMfB9oeouAMSua+BDAzUw0LKKiSJ6jjR6O3YXfK0IaN/TBzLRsS
	cUHTTOVxg9DV11yDBXfWLrOimh8PXQQs3G+2J38vzrmcpr2oZMxi8seTP1Nxo9APVEWNHb3+1da
	RoUHcof6HhsxzmEo1SrXawKi4EXUxJzwuZqgZ+RqCge7Ug6Yl/Tjf9ui5ip2SzRd/j+2lyK8AKU
	cxhA/VZl/nNO7B9MRtgfYQE0EQWD4jtwad/qD36n8HBkbtVHTFi63MUD4L9dwTaZOSuF+q3EHXW
	EKOIKij0mByvoxwD6Fb+6wXmtH+rpzJ9PE=
X-Received: by 2002:a05:6a00:4f94:b0:83d:b11f:796c with SMTP id d2e1a72fcca58-8415f3d3adbmr9102216b3a.49.1779590791854;
        Sat, 23 May 2026 19:46:31 -0700 (PDT)
Received: from ryzen ([2601:644:8000:5b5d:7285:c2ff:fe45:8a32])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84164fc6e8esm5490202b3a.47.2026.05.23.19.46.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 23 May 2026 19:46:31 -0700 (PDT)
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
Subject: [PATCH] dmaengine: ti: omap-dma: turn lch_map into a flexible array
Date: Sat, 23 May 2026 19:46:14 -0700
Message-ID: <20260524024614.182126-1-rosenp@gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,kernel.org,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-10778-lists,dmaengine=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 8BADF5C1278
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
 drivers/dma/ti/omap-dma.c | 68 +++++++++++++++++++--------------------
 1 file changed, 33 insertions(+), 35 deletions(-)

diff --git a/drivers/dma/ti/omap-dma.c b/drivers/dma/ti/omap-dma.c
index 55ece7fd0d99..901e38b08962 100644
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
@@ -1656,36 +1656,53 @@ static const struct omap_dma_config default_cfg;
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
+	} else if (of_property_read_u32(pdev->dev.of_node, "dma-channels",
+					&lch_count)) {
+		dev_info(&pdev->dev,
+			 "Missing dma-channels property, using %u.\n",
+			 OMAP_SDMA_CHANNELS);
+		lch_count = OMAP_SDMA_CHANNELS;
+	}
+
+	od = devm_kzalloc(&pdev->dev, struct_size(od, lch_map, lch_count),
+			  GFP_KERNEL);
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
@@ -1730,19 +1747,6 @@ static int omap_dma_probe(struct platform_device *pdev)
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
@@ -1754,12 +1758,6 @@ static int omap_dma_probe(struct platform_device *pdev)
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
-- 
2.54.0


