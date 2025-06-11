Return-Path: <dmaengine+bounces-5355-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 207C3AD5635
	for <lists+dmaengine@lfdr.de>; Wed, 11 Jun 2025 15:00:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 638AC3A2705
	for <lists+dmaengine@lfdr.de>; Wed, 11 Jun 2025 12:59:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31F7A28688D;
	Wed, 11 Jun 2025 12:59:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b="lTRfHecJ"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 548C8284B32
	for <dmaengine@vger.kernel.org>; Wed, 11 Jun 2025 12:59:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749646779; cv=none; b=FcMGfCQAbsHCNYDDwv8CUPqrsG7wIFqXX3R8tOTXeZdQbiWfgO6usMISniw9FhzOsCxFyiLFzZ8FbB0ecg6zONovBxSyXfgeocAbhs/mkUvD/nHqLepuEMILc/RurfugCR5m7vYHWOvclcN8zBaY1VZgp0g9vOmVH7pNG95eMi0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749646779; c=relaxed/simple;
	bh=IEX/J2M3ey3rn2zFNEOh92droBLT2UE1LPg1xMt9/e4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UqZwAoqTjaqjLNNKF12NIRRqdjh3fXvA3Pg5oBpM4kVEoSGQ89r9KHXJima2JJJd0J39hLcpu6NkIx7AZi6WPy0Lf935PHV6gYewxJXAwEQS4IU6tGHciw0G1k6apJh1+39Rr7YboXJeX4vLB//GT8P8ANwzjlTmFID5X+OSuVA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com; spf=pass smtp.mailfrom=riscstar.com; dkim=pass (2048-bit key) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b=lTRfHecJ; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=riscstar.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-234d366e5f2so75542615ad.1
        for <dmaengine@vger.kernel.org>; Wed, 11 Jun 2025 05:59:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=riscstar-com.20230601.gappssmtp.com; s=20230601; t=1749646776; x=1750251576; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bbUdwqpOjgljwseuYvc1wSTutki3xIN9U2HpImhqa58=;
        b=lTRfHecJUkMB8uoMD6ldh/GTRvUjMllY+Rlp8OrXqklCYynZ4Uqpr5fEzCHEwenTR6
         LLbprdYp7gyiTiT22iHeeQGHoIoJC3ESPty5n8LZP2oY1BDy49q36XAC1hLnMnxjcFBk
         sxqvCcq8XRtiyo3h/JL61L8UMD3wMDA8k5TN2E1aHUBiRiZIhPIK5o1vlTQ8BrNxKl1/
         DIu2ptgHA1vGDMuDSxfKBwBPSrUDNjAwJhXQZDOK2GK3jbVsnFRfqY1Ce5CzqZdkwldX
         wBHPZkxjn9AwL48lz2ZFoZlr0aFx+X+CPPvJdEQ4muLVAHPqPJbCAvx8lXyq/AfqxPdV
         dxLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749646776; x=1750251576;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bbUdwqpOjgljwseuYvc1wSTutki3xIN9U2HpImhqa58=;
        b=LjzmLl0Tw7r9uO77aXgykJpYZRX7C8epROLGf4PwAsloM5AEcxjUwv3Qu7nzYOB+wV
         BqPyn4YbCgUzzH9vKLJ008wmts8IF64YudpWuZup4sajkm7tOI4SfK1/3P8nmDtpNmdh
         0JfpM0ivz0u36nR7RSZXAGMLDb062PtD39pP8E5Sdr3m92hvnwEomAfYgQ0e87FBoVTY
         hTw0WKeVAoM6eAfFBJ/NdhCLp8J6LvBjLS0HzfBClAdat8dufjdn4YuLzwsYZ5qnc8C5
         LFuAh291MLJ2flbzlmkqby95SPXEr2NUhZuIdUGXcUiNFAz9YRvlKEV6e5Ic1CTkpGaT
         dD4Q==
X-Forwarded-Encrypted: i=1; AJvYcCXHtMu2YDuyPhYxrjul+MCVIQO9B9nZuYK6/dLXd3Xyf0c7toNJTFn0sVPTSB59HbPlSkBBo0w/+1Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YwOEr/UmqmDKDsHJRrCNRAkw7/1Uzc0UzwYp5CgW2Gd9neGMZBb
	6k8uxGqQDmIkho14Ctaf09xxqvwb56SAeHOdeqF9vvXQp4cLxrIXC/5FXL6veGKBrbw=
X-Gm-Gg: ASbGncvtvv1J3tz5pEPvKosgVp92zU5/HSJrKA9IFjxiXygYIq4jcpD3zGgJBUGnf9Z
	ktkuf0OIk/v0UpoPz3v+SAHRsDAZ14xHdxCecBqtaKlKlJxqUxiJ3kZEGcFd07QLQmbt7z+2oUO
	udb2OyX7sVhiBNxcj1AvWOdPwkxqfMPfNX+QpKOHqAhuEclIDQM4rn64OhRbElaC5TsQe8xpowY
	Y8EJgyfFnu2u3F1VEmVazp/fu06J414ty1KocQBN7LcOin3XH71wKpjp59qIeql1+f/2AGU1A8S
	8plbnA3J4pUr+htueHEpQMU2fhJCK/rUGflugXtE/gz0wjz5aN8JH6eFzrG+Usp4+ofwOsrF0gk
	ycA35k8X0T7IeSis8pblmRA==
X-Google-Smtp-Source: AGHT+IFwmOGY2tPNuPQv/TIROenh+j1fH/hIa0++yIAIoLEcfqCONIj2DYpz4kpbLhhFofJZJXqRvQ==
X-Received: by 2002:a17:902:cf0f:b0:234:986c:66d5 with SMTP id d9443c01a7336-23641a8ba0bmr41504395ad.5.1749646776539;
        Wed, 11 Jun 2025 05:59:36 -0700 (PDT)
Received: from localhost.localdomain ([2409:8a00:31a4:6520:3d67:ceb1:7c60:9098])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-236030925e3sm86984115ad.53.2025.06.11.05.59.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Jun 2025 05:59:36 -0700 (PDT)
From: Guodong Xu <guodong@riscstar.com>
To: vkoul@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	dlan@gentoo.org,
	paul.walmsley@sifive.com,
	palmer@dabbelt.com,
	aou@eecs.berkeley.edu,
	alex@ghiti.fr,
	p.zabel@pengutronix.de,
	drew@pdp7.com,
	emil.renner.berthing@canonical.com,
	inochiama@gmail.com,
	geert+renesas@glider.be,
	tglx@linutronix.de,
	hal.feng@starfivetech.com,
	joel@jms.id.au,
	duje.mihanovic@skole.hr
Cc: guodong@riscstar.com,
	elder@riscstar.com,
	dmaengine@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	spacemit@lists.linux.dev
Subject: [PATCH 2/8] dma: mmp_pdma: Add optional clock support
Date: Wed, 11 Jun 2025 20:57:17 +0800
Message-ID: <20250611125723.181711-3-guodong@riscstar.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250611125723.181711-1-guodong@riscstar.com>
References: <20250611125723.181711-1-guodong@riscstar.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add support for retrieving and enabling an optional clock using
devm_clk_get_optional_enabled() during mmp_pdma_probe().

Signed-off-by: Guodong Xu <guodong@riscstar.com>
---
 drivers/dma/mmp_pdma.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/dma/mmp_pdma.c b/drivers/dma/mmp_pdma.c
index a95d31103d30..4a6dbf558237 100644
--- a/drivers/dma/mmp_pdma.c
+++ b/drivers/dma/mmp_pdma.c
@@ -15,6 +15,7 @@
 #include <linux/device.h>
 #include <linux/platform_data/mmp_dma.h>
 #include <linux/dmapool.h>
+#include <linux/clk.h>
 #include <linux/of_dma.h>
 #include <linux/of.h>
 
@@ -1019,6 +1020,7 @@ static int mmp_pdma_probe(struct platform_device *op)
 {
 	struct mmp_pdma_device *pdev;
 	struct mmp_dma_platdata *pdata = dev_get_platdata(&op->dev);
+	struct clk *clk;
 	int i, ret, irq = 0;
 	int dma_channels = 0, irq_num = 0;
 	const enum dma_slave_buswidth widths =
@@ -1037,6 +1039,10 @@ static int mmp_pdma_probe(struct platform_device *op)
 	if (IS_ERR(pdev->base))
 		return PTR_ERR(pdev->base);
 
+	clk = devm_clk_get_optional_enabled(pdev->dev, NULL);
+	if (IS_ERR(clk))
+		return PTR_ERR(clk);
+
 	if (pdev->dev->of_node) {
 		/* Parse new and deprecated dma-channels properties */
 		if (of_property_read_u32(pdev->dev->of_node, "dma-channels",
-- 
2.43.0


