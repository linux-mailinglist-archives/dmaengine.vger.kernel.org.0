Return-Path: <dmaengine+bounces-9898-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KExZMm1/1GlLugcAu9opvQ
	(envelope-from <dmaengine+bounces-9898-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Tue, 07 Apr 2026 05:52:13 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 35E923A982D
	for <lists+dmaengine@lfdr.de>; Tue, 07 Apr 2026 05:52:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9F16030191A8
	for <lists+dmaengine@lfdr.de>; Tue,  7 Apr 2026 03:51:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9986374E57;
	Tue,  7 Apr 2026 03:51:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qsFa1Rns"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E8DD37474B
	for <dmaengine@vger.kernel.org>; Tue,  7 Apr 2026 03:51:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775533914; cv=none; b=qIBLw1uZB7xFYj4gnHpQXx3+acQQOdAA50W5ovUJzL9aR+kcIvxvMOSreD2BwjkeR2+eTg2tdE1oeafh+4mnWkA9bIChmnWHbKfdOfbaCgO7ghk9Os+ZETgO9+ZYyznpQOaelxSHYpzzIoIJzXTFjmgh20zPxlJsWiIPzeJY4jc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775533914; c=relaxed/simple;
	bh=ZGc+Lx7Q3ImjQIU2MsaptvUr2OjdQPH11+1aygZf1BQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=eTkEMuHEJ2bhaiiSqvkNVZuUG82EzbPSensFKJ8j9+02yAIyCNrahvIt8OHXxcJzqmYI1j1eujswXJVD2ApUMjLTaEFzQ1YRNGJvk5cM4MY+wHrrGe8vzZ05V1Nz32zWJmami7ulXfR1AiLClRRN7mrJchQ/++xuNQHDdFsWxb4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=qsFa1Rns; arc=none smtp.client-ip=209.85.160.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-50d6b9bca48so58729051cf.2
        for <dmaengine@vger.kernel.org>; Mon, 06 Apr 2026 20:51:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775533912; x=1776138712; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=e/TQHykLdF85VtC6CTJ2wonciXUmXtr/iGFz2p1d+iM=;
        b=qsFa1RnsmqIpoiWveTXijEroCfY6YDbyuRPmq/j8gurUFF5XxOJxSbR1N7RGlYfIaO
         DpGxIT4WTWgDfVRGHTJPimjw3DMyu8s7rXdK3jfGA2bvl2mMv0NlnsR1fYiO/A8rrKbm
         ghYcVrv2sYteen6K4Cin73OGtBcuL3JI90fjf3Oyvs0UbWkgYky8a0lyzwVJ4cgZ/7PU
         WiS2vOaxD2k06Bsbh/eMdx3EJoKEHRMMG80lq0jFodWnuysiAZkew3lXj/ryMDgjDwwH
         153d67gnK29wOno2xZueGHfUKdQ7KKL6H6BlqASEtybnG4B7dys38XZr88tGWa3eieN5
         K2aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775533912; x=1776138712;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=e/TQHykLdF85VtC6CTJ2wonciXUmXtr/iGFz2p1d+iM=;
        b=pc8YQEEkXaxklkjNmFULvIAF2fOoL7BBNVh3xTKd7wZt7SQ2izl96ZBa1Fr3i+I2Oi
         O1wZ+faoBV171ciRQcAqLAwsdiWcJtYg9MHRyd9dJMdnkjfkZ43kLxv5wrrApERuFXtU
         smXYk/+7rGQyjS0pcTHCKllJZ/C/Hxhb7tVUvw8WKbkUjAKYyoE5YVAbD2RYXeJPLJ7G
         EKWJyRKF+rnZr6zkWrDUhO6OXWQwfFkdvMjQT5f+sy9N5GhdCa1EsWbQQ2MS2AhkegGl
         IIGBNOJ2rSNo2+SetXM0msp258uULufPL44Ux5oyIzJ9IIs/+1NzDHwISfjyt9hTX5sX
         cLnQ==
X-Gm-Message-State: AOJu0Yxho68Q1y1sdhqLqd0lfh9PZ7axPEvp6c/kuwGSWnBbGAiaFJ40
	1L8OGEx06hiEtWWBOyKyj0g9bYxudM34pf+5FWsCF7aS0wyLpGetv0MuiWCnUw==
X-Gm-Gg: AeBDiesXqqqd17J8aDI66HQ/Lw0En1fkNDc1EYx/dDhmEcL3AVLlV/LZXzFC8paO1dg
	3M4tfZkCHfAfEUbDn6mBbttaX+dRlGHdY5dzEpum+XFWXS/ECTH/1CveVv6EshMqAOQ6AVJwlOj
	os0wX4QpRfFiuzv9o8YbQgCVfFrHcmCFfSNiXQ/R1lnsmoBnacntsIqNG+9bU6UlymwPsDd8H/H
	A7O8gWCaF4ZiY+nJXdbaua+a1kJYEQNb+NxhBBYJgiVCnRIlXSrcDQBzh2Cl6qGZn3NpzLmfGIG
	KztZ2bCBUXB+ogbGU1WKvLXNCyD7f/9yWmFOsKmsJLt3fRBejZtC7UiTywPQrEa8kq8kXmf7AfX
	xzO3uCjx8nEiEe/eyVbG37ME8OtRSUbwe8p81dtt5cbmkSf65Cd7hhSlocehJ78HgepkgFDk/uF
	nkfWHs6B80YcInQ7s39xD4JyXRDZbDZRU8XcvmDQT/yigL3G8Mb2EBEAk=
X-Received: by 2002:a05:622a:1247:b0:50d:8389:c3f3 with SMTP id d75a77b69052e-50d8389c6c4mr146678471cf.54.1775533912203;
        Mon, 06 Apr 2026 20:51:52 -0700 (PDT)
Received: from ryzen ([2601:644:8000:5b5d::8bd])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-50d82afc7d5sm77280341cf.30.2026.04.06.20.51.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Apr 2026 20:51:50 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: dmaengine@vger.kernel.org
Cc: Vinod Koul <vkoul@kernel.org>,
	Frank Li <Frank.Li@kernel.org>,
	Vladimir Zapolskiy <vz@mleia.com>,
	Kees Cook <kees@kernel.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	linux-arm-kernel@lists.infradead.org (moderated list:ARM/LPC18XX ARCHITECTURE),
	linux-kernel@vger.kernel.org (open list),
	linux-hardening@vger.kernel.org (open list:KERNEL HARDENING (not covered by other areas):Keyword:\b__counted_by(_le|_be)?\b)
Subject: [PATCH] dmaengine: lpc18xx-dmamux: simplify allocation
Date: Mon,  6 Apr 2026 20:51:32 -0700
Message-ID: <20260407035132.99037-1-rosenp@gmail.com>
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
	TAGGED_FROM(0.00)[bounces-9898-lists,dmaengine=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 35E923A982D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Use a flexible array member to combine allocations. Requires
preparation, aka reshuffling before the actual allocation to get the
proper size.

Add __counted_by for extra runtime analysis.

Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 drivers/dma/lpc18xx-dmamux.c | 42 +++++++++++++++++-------------------
 1 file changed, 20 insertions(+), 22 deletions(-)

diff --git a/drivers/dma/lpc18xx-dmamux.c b/drivers/dma/lpc18xx-dmamux.c
index d3ff521951b8..5dfefbc496da 100644
--- a/drivers/dma/lpc18xx-dmamux.c
+++ b/drivers/dma/lpc18xx-dmamux.c
@@ -32,11 +32,11 @@ struct lpc18xx_dmamux {
 
 struct lpc18xx_dmamux_data {
 	struct dma_router dmarouter;
-	struct lpc18xx_dmamux *muxes;
 	u32 dma_master_requests;
 	u32 dma_mux_requests;
 	struct regmap *reg;
 	spinlock_t lock;
+	struct lpc18xx_dmamux muxes[] __counted_by(dma_master_requests);
 };
 
 static void lpc18xx_dmamux_free(struct device *dev, void *route_data)
@@ -122,12 +122,30 @@ static int lpc18xx_dmamux_probe(struct platform_device *pdev)
 {
 	struct device_node *dma_np, *np = pdev->dev.of_node;
 	struct lpc18xx_dmamux_data *dmamux;
+	u32 dma_master_requests;
 	int ret;
 
-	dmamux = devm_kzalloc(&pdev->dev, sizeof(*dmamux), GFP_KERNEL);
+	dma_np = of_parse_phandle(np, "dma-masters", 0);
+	if (!dma_np) {
+		dev_err(&pdev->dev, "can't get dma master\n");
+		return -ENODEV;
+	}
+
+	ret = of_property_read_u32(dma_np, "dma-requests",
+				   &dma_master_requests);
+	of_node_put(dma_np);
+	if (ret) {
+		dev_err(&pdev->dev, "missing master dma-requests property\n");
+		return ret;
+	}
+
+	dmamux = devm_kzalloc(&pdev->dev, struct_size(dmamux, muxes, dma_master_requests),
+			GFP_KERNEL);
 	if (!dmamux)
 		return -ENOMEM;
 
+	dmamux->dma_master_requests = dma_master_requests;
+
 	dmamux->reg = syscon_regmap_lookup_by_compatible("nxp,lpc1850-creg");
 	if (IS_ERR(dmamux->reg)) {
 		dev_err(&pdev->dev, "syscon lookup failed\n");
@@ -141,26 +159,6 @@ static int lpc18xx_dmamux_probe(struct platform_device *pdev)
 		return ret;
 	}
 
-	dma_np = of_parse_phandle(np, "dma-masters", 0);
-	if (!dma_np) {
-		dev_err(&pdev->dev, "can't get dma master\n");
-		return -ENODEV;
-	}
-
-	ret = of_property_read_u32(dma_np, "dma-requests",
-				   &dmamux->dma_master_requests);
-	of_node_put(dma_np);
-	if (ret) {
-		dev_err(&pdev->dev, "missing master dma-requests property\n");
-		return ret;
-	}
-
-	dmamux->muxes = devm_kcalloc(&pdev->dev, dmamux->dma_master_requests,
-				     sizeof(struct lpc18xx_dmamux),
-				     GFP_KERNEL);
-	if (!dmamux->muxes)
-		return -ENOMEM;
-
 	spin_lock_init(&dmamux->lock);
 	platform_set_drvdata(pdev, dmamux);
 	dmamux->dmarouter.dev = &pdev->dev;
-- 
2.53.0


