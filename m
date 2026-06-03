Return-Path: <dmaengine+bounces-11135-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id xzS0JdGbH2oRnwAAu9opvQ
	(envelope-from <dmaengine+bounces-11135-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Wed, 03 Jun 2026 05:13:21 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E9FCD633CBC
	for <lists+dmaengine@lfdr.de>; Wed, 03 Jun 2026 05:13:20 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=AkJj2lKP;
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-11135-lists+dmaengine=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="dmaengine+bounces-11135-lists+dmaengine=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 647B530DF14A
	for <lists+dmaengine@lfdr.de>; Wed,  3 Jun 2026 03:08:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97AA63E5ECF;
	Wed,  3 Jun 2026 03:08:30 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F5083E8322
	for <dmaengine@vger.kernel.org>; Wed,  3 Jun 2026 03:08:28 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780456110; cv=none; b=Rt/WcCBo88wxBXj1AH6Xo8iy8pqGDzLcL9cD+YgzZbzaA20v0nSdbBev0PcCCtLMyYJ9/4N2HndwgPZTLWXlV+cFov9Nl0jbESELQt5UWfRjHRs7B6rVgDs+eu5DRuiFHDqR4Qzx1RqPyF9zyfgEwqDUrjllFqqg5T6Z3szp6eg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780456110; c=relaxed/simple;
	bh=34Zm3W7woqTMi8w3X3JA5sjumybeyKNHi38eRAQVT+w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KlHJPceutKFdFQHwdWhx5q79sG04b0aGDNiPfhd5stqCmltzcgGS7DQ9Di7zI+Az1q+zT17BOrow3sA4w9iFo181dkR04stzTKgkICii13JDizyxs97CXenczG/bfW9K/erF92Paaorpa7qocDnhksXyfVK9Vqk+R2qHgAAZuNA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AkJj2lKP; arc=none smtp.client-ip=209.85.216.53
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-36ad15213fbso6056578a91.0
        for <dmaengine@vger.kernel.org>; Tue, 02 Jun 2026 20:08:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780456108; x=1781060908; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=USwZ93J2NNYew7Ti1RVaXMO67Ur9p4DSXE1j33WNuVA=;
        b=AkJj2lKPM8B0v0YonJE34FMtNClizjxYTrInkqFDett8hGvPe2Tc7Wk9jcsjdF9xpE
         90eJtXS2owcBDYj5+9h/nYlwhXXfPUJyzPfkNUJhs9AoL5WbL/5LBmSq15kCwgCwIgoR
         0MAPkm4TdSMFgsh7h+bsEw5s1sOpnqr0+d6BWBK3vYtGoZomy0EDS9Z9fgf4SRZSQ5BT
         8rTsmBfL/GdTv1Eby6GXi9h628uq1JlC9N3kdoqxSguLw9tWqxStaw76h27HYhPg/+ZR
         hyJd0oTYjdk6t+nc3ZiX2kLJwy9B0SBHRnxEgb+ZAbcJ3UCeLH0xGi1KGA0Tg+ezkixQ
         8eyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780456108; x=1781060908;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=USwZ93J2NNYew7Ti1RVaXMO67Ur9p4DSXE1j33WNuVA=;
        b=pOx439R3BjodCGDLr/bqSnQOTGSzHKiqBaEDlUjjAe7niWMDJQ/6yFmeK3F9zMERPs
         XskKWk9N323hgz3j2FniFpxcfEihdeU34GjXNQvly/6aCMwZLp6InTNaK8XzM+gseCbY
         yBpc/I3Pe6vXZCLHNfHrVQJDyOzqE/n3mssY209W9k5aw+0VuGU+OCk7Viadf5zr7sbu
         PZcyIleWB1SjIfw4N9nwZmrxhFzccCGNDBtXxmThmA4Z25Vck9BOV7RW+og5pR1Kxshy
         JobnU1GrfTgy1OConS2UftzDz0mBomg2d6DhUhDRd/R2yhGy1Ci/SX6NSX2yDUiNtyW4
         Mk2g==
X-Gm-Message-State: AOJu0YxFCHwvYcWJ41TjDUbJzQpRh/Eb9dcE8Kjfh2X/Ypto0+alEqAg
	DdgdcbeiYa9gnGxzPvpW8dew93WnmBWbt8/x8OQKF7BPp4dRnuuB9u24EFU1Yj3Y
X-Gm-Gg: Acq92OHa5DeHu25HyPfNdkk+LPecGTRLyD21Y2aMWnANmq4tRlfz29Za1yRn4eazZBA
	qjUX0haleoEBHbJIG2LW15LyNL6JZb2BkyASaYwVlJI84LW2hfNgXrByeAY0iwB9Zdx/g/TKd/x
	5UbrB1ZxeLDnV/Ibt9ilbm+/6a/gmabBHHj/lk5gsSO9+KEq+/TABvRPoqtwmUjOgbEwaFaNssj
	zrKmeUxFVvzdlVCpSxNpzxq+tSXPkqb3ljLdzrghPrmnuYXgMgBl5uXi6Df9DxhfciArneLqLkw
	JUXrxCvkykKTN2RX+8OZ/KAI+i23xcjOGMwOnraJdK8uE8tk+17r/WqX+yE9Pgq+Y2ySn4zAtJI
	qEzWonVK0KU6y5A9zL4OyC1MA5rZTVzXb45Bs8GV+je21jQ0yheMv9cvTjiD7B3vekb8QJBSt+3
	b3lcmTboi/wZWTFPTMgONSa6nw2l32NSIn0QBBt+gnG2fjPG/OewFc/7tO8IiXms9209N/BB8ai
	nQrWdWEEM1o1RbqNuNWCaojwRcMvH+5+tGo6vZbBf0LWQ==
X-Received: by 2002:a17:90b:1c0a:b0:369:7f25:cec0 with SMTP id 98e67ed59e1d1-36e2dc53790mr1396861a91.0.1780456108116;
        Tue, 02 Jun 2026 20:08:28 -0700 (PDT)
Received: from ryzen ([2601:644:8000:5b5d:7285:c2ff:fe45:8a32])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-36e0a186741sm1247102a91.8.2026.06.02.20.08.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jun 2026 20:08:26 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: dmaengine@vger.kernel.org
Cc: Peter Ujfalusi <peter.ujfalusi@gmail.com>,
	Vinod Koul <vkoul@kernel.org>,
	Frank Li <Frank.Li@kernel.org>,
	Kees Cook <kees@kernel.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	Haotian Zhang <vulab@iscas.ac.cn>,
	Tony Lindgren <tony@atomide.com>,
	Russell King <rmk+kernel@arm.linux.org.uk>,
	linux-kernel@vger.kernel.org (open list),
	linux-hardening@vger.kernel.org (open list:KERNEL HARDENING (not covered by other areas):Keyword:\b__counted_by(_le|_be|_ptr)?\b)
Subject: [PATCHv3 8/8] dmaengine: ti: omap-dma: turn lch_map into a flexible array
Date: Tue,  2 Jun 2026 20:07:54 -0700
Message-ID: <20260603030754.288757-9-rosenp@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260603030754.288757-1-rosenp@gmail.com>
References: <20260603030754.288757-1-rosenp@gmail.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,kernel.org,iscas.ac.cn,atomide.com,arm.linux.org.uk,vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-11135-lists,dmaengine=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:dmaengine@vger.kernel.org,m:peter.ujfalusi@gmail.com,m:vkoul@kernel.org,m:Frank.Li@kernel.org,m:kees@kernel.org,m:gustavoars@kernel.org,m:vulab@iscas.ac.cn,m:tony@atomide.com,m:rmk+kernel@arm.linux.org.uk,m:linux-kernel@vger.kernel.org,m:linux-hardening@vger.kernel.org,m:peterujfalusi@gmail.com,m:rmk@arm.linux.org.uk,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[rosenp@gmail.com,dmaengine@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_HAS_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rosenp@gmail.com,dmaengine@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[dmaengine,kernel];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: E9FCD633CBC

Convert the separately-allocated lch_map pointer array to a C99
flexible array member at the end of struct omap_dmadev and annotate it
with __counted_by(lch_count). The probe is reordered so platform_data
lookup and the lch_count determination happen before the parent
allocation, letting struct_size() size the FAM and the dedicated
devm_kcalloc() for lch_map go away.

Two allocations collapse into one and the runtime bounds checks from
__counted_by now apply to every lch_map[] access.

Assisted-by: Opencode:BigPickle
Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 drivers/dma/ti/omap-dma.c | 72 +++++++++++++++++++--------------------
 1 file changed, 36 insertions(+), 36 deletions(-)

diff --git a/drivers/dma/ti/omap-dma.c b/drivers/dma/ti/omap-dma.c
index 7343325ce2b1..dab600604572 100644
--- a/drivers/dma/ti/omap-dma.c
+++ b/drivers/dma/ti/omap-dma.c
@@ -49,7 +49,7 @@ struct omap_dmadev {
 	const struct omap_dma_config *cfg;
 	struct notifier_block nb;
 	struct omap_dma_context context;
-	int lch_count;
+	u32 lch_count;
 	DECLARE_BITMAP(lch_bitmap, OMAP_SDMA_CHANNELS);
 	struct mutex lch_lock;		/* for assigning logical channels */
 	bool legacy;
@@ -58,7 +58,7 @@ struct omap_dmadev {
 	unsigned dma_requests;
 	spinlock_t irq_lock;
 	uint32_t irq_enable_mask;
-	struct omap_chan **lch_map;
+	struct omap_chan *lch_map[] __counted_by(lch_count);
 };
 
 struct omap_chan {
@@ -1661,36 +1661,55 @@ static const struct omap_dma_config default_cfg;
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
@@ -1735,19 +1754,6 @@ static int omap_dma_probe(struct platform_device *pdev)
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
@@ -1759,12 +1765,6 @@ static int omap_dma_probe(struct platform_device *pdev)
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


