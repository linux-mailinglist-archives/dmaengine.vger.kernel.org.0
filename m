Return-Path: <dmaengine+bounces-5694-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E6BDAEEDCA
	for <lists+dmaengine@lfdr.de>; Tue,  1 Jul 2025 07:38:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 54669164D2E
	for <lists+dmaengine@lfdr.de>; Tue,  1 Jul 2025 05:38:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D764E2459D9;
	Tue,  1 Jul 2025 05:37:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b="ebfiRMjU"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C055245029
	for <dmaengine@vger.kernel.org>; Tue,  1 Jul 2025 05:37:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751348271; cv=none; b=Lp2ag2MjNwV8t/5V4s2spGYUzjHgn2s+D4aixmzP7yKQaOuFW9gs8xDxRWVgj8s5B2QA0zcKZnmujUA6ysEsjASDNfhiOu/5R1hVmxUuvhE60eh5PM+FRSamSD7LZH6whBJ5I7Y3l/1IkTCxpnbINKuJEJCO9iXxqseJO+vV3BY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751348271; c=relaxed/simple;
	bh=cvJMbBhCxqZy7PEHIdbrxOx/t31kggur4xA0D6K3PIU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=pDA7RiAOHy/HFPcQ2TD10YH5MdowN0UeMo2PYBi6tud6rV0mSjPlX4nEQgjFSOZMgUJow1tgNjyKH2fDn6A/s1hpDjGWBtBh+CBeTYlowxdwZ1EVerhNKRn09esduPTqo4msE0WssanTtUOvsmwnyouQ/1sllqOoS6VzdUt62a8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com; spf=pass smtp.mailfrom=riscstar.com; dkim=pass (2048-bit key) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b=ebfiRMjU; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=riscstar.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2352400344aso48825155ad.2
        for <dmaengine@vger.kernel.org>; Mon, 30 Jun 2025 22:37:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=riscstar-com.20230601.gappssmtp.com; s=20230601; t=1751348269; x=1751953069; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SIPMZwIjwsVXUr19w5dAJ2kyFpb+jn5E1yMbGJ484tE=;
        b=ebfiRMjUsj7KnaD3yzoYEIf1cRZanPi7VrtOx1REX2ojZtRcFnvZUkiPRuJWdAg01U
         VW/R2HDXJuk4OE/rCMHpLR5gTOxhq+x6stc5hz96outdNz7MfLjsAzex4e7r0CSK/ekC
         GHtD7sun4/3s1e3d7d0CmjzEh/yp7hqPROGF7XoRFGLFMintD5XOwUB3dhAsT6QLFcW3
         mdy7avP43pm3vuHernYHyt/OR1H3HuEe22a/2hvewIxhkNCuEHg3diMdRTEwHxtAgjjw
         eP6CWfZw0X7bSQ+QOLoU88fFSf4JZiJ2sUIAy7ekShMHiCy2DXDXiTgRjsiPZ8HLX6EU
         KXPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751348269; x=1751953069;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SIPMZwIjwsVXUr19w5dAJ2kyFpb+jn5E1yMbGJ484tE=;
        b=j77Oft1C3+J0Q3Q4+0eIl+HcVNRApJmSOwruVwwd4CgfPaJV0Q6kJktCTeMkDvPnFW
         s8sSyms6poOxf0EpTZuKep1/naGAmu/TYoQabHjFjinAklHZa3RtjTHBKj4KxfZzECV6
         niYYTvLVgLUVialUlUzm902wIR6NIuYAnhuC7FO2gSjvlank5BuqWwJ92etzd3yUsBVR
         ShWXJMMCckIvFHP8EUmR1EdlDBoUMpes1vOkonOYrSwsXE3RIonctk+h9qG6ppG/r1WI
         moG5N2AMigOWXbLOOQTKnBKgrzOP/E8gOXG8AODiUcCy75038ctoTA6r/8Ir4m90sz36
         2LkQ==
X-Forwarded-Encrypted: i=1; AJvYcCUccPXtf/yUl/1zAy7CRvwelhbMZiwCOxGikMOg4AAiONLvjPUMgpsE5wxtnMqo6QZJ60pqoe+6qCs=@vger.kernel.org
X-Gm-Message-State: AOJu0YzP07ohWTd/7j1dCmeduq8MIDkrU3U/mKIf7gqYiRYqGa6C4vRA
	Xgjv5NhkTxArl0Rvx0/g7LVAKVEFlKLN4XUlrSigL/ePvmIcU+mfFLRK4Dkc7wvaLgw=
X-Gm-Gg: ASbGncsilU7es0Qu2SBJSUszTrhvubqvtFdAmULjxc6LfjlnqHV4qYnwcMWAMtqi5+A
	VWXC5wEWcySMajgc6d8862Kj/ErGVpvqvleRT17hNzTo1FCXf5Dlp2NipqY5v8Dyr2rKNK5Lgid
	lsEGYPIfT5SbSw2rxfc+GgExu5upN2a6NnsOD4Lqp1GMOpW01u75rmK5ED5x/lQKAGYSPmljZ2Z
	nLRxDAoCdRskv+yTOhGFHY8euoq4uTSIKVlnFI1QLQFPc/yg8DncIHGXYZx5lIElQnG2kqXwQ/i
	ky1cQIMsR8c4bchQ4o9ggq4DPSm7iBrz4Ef6Jao=
X-Google-Smtp-Source: AGHT+IE16tX1sCq4DSpvKgkQxnN+PHXsI78p3M94DOvhTbzRw8dgntEK2GQnFLXWQ+awumOj/AFs5g==
X-Received: by 2002:a17:903:244c:b0:224:910:23f6 with SMTP id d9443c01a7336-23ac463e8d8mr248581755ad.45.1751348269319;
        Mon, 30 Jun 2025 22:37:49 -0700 (PDT)
Received: from [127.0.1.1] ([2403:2c80:6::3092])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23acb39bf5fsm101729865ad.115.2025.06.30.22.37.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Jun 2025 22:37:49 -0700 (PDT)
From: Guodong Xu <guodong@riscstar.com>
Date: Tue, 01 Jul 2025 13:36:56 +0800
Subject: [PATCH v2 2/8] dmaengine: mmp_pdma: Add optional clock support
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250701-working_dma_0701_v2-v2-2-ab6ee9171d26@riscstar.com>
References: <20250701-working_dma_0701_v2-v2-0-ab6ee9171d26@riscstar.com>
In-Reply-To: <20250701-working_dma_0701_v2-v2-0-ab6ee9171d26@riscstar.com>
To: Vinod Koul <vkoul@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Yixun Lan <dlan@gentoo.org>, 
 =?utf-8?q?Duje_Mihanovi=C4=87?= <duje.mihanovic@skole.hr>, 
 Philipp Zabel <p.zabel@pengutronix.de>, 
 Paul Walmsley <paul.walmsley@sifive.com>, 
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
 Alexandre Ghiti <alex@ghiti.fr>
Cc: Alex Elder <elder@riscstar.com>, Vivian Wang <wangruikang@iscas.ac.cn>, 
 dmaengine@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org, 
 spacemit@lists.linux.dev, Guodong Xu <guodong@riscstar.com>
X-Mailer: b4 0.14.2

Add support for retrieving and enabling an optional clock during
mmp_pdma_probe().

Signed-off-by: Guodong Xu <guodong@riscstar.com>
---
v2: No change.
---
 drivers/dma/mmp_pdma.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/dma/mmp_pdma.c b/drivers/dma/mmp_pdma.c
index a95d31103d3063a1d11177a1a37b89ac2fd213e9..4a6dbf55823722d26cc69379d22aaa88fbe19313 100644
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


