Return-Path: <dmaengine+bounces-6036-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 43047B2783B
	for <lists+dmaengine@lfdr.de>; Fri, 15 Aug 2025 07:18:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A78D71C24C07
	for <lists+dmaengine@lfdr.de>; Fri, 15 Aug 2025 05:18:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9ED5C28135F;
	Fri, 15 Aug 2025 05:17:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b="MkBPYSmP"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA80C244664
	for <dmaengine@vger.kernel.org>; Fri, 15 Aug 2025 05:17:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755235070; cv=none; b=SmOabskJLJBU0+/0TISTXPTs6W8yp41NFJtIGbvwP5O0oxmGN6ry9+NE0+SzuHJ0tErnn+iDBfCdZ764zGv1ij1Fi7JigRXNGf/uB8Ylt68jjugK2qWsRXSTKQCX0FgFtvNNGSIYIpdCx6WxCO7QIH4eoL1/x0mU42TQP98/jOc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755235070; c=relaxed/simple;
	bh=b06tSPkNPOsymxZcIQh4cvJ5PfLzXSKhYEO4BFFGJ1Y=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=P2ksmr0hQY2NLE1d3hd9kNX8y/fuMezP6c/RMK5gumjcMlZsq2RAfrnwf5Rxk80nWGcPIPJSQEwK8wdsNzgwj/gA72tWsbv8eODhdCssdaRDFH/FiM3G1EAo9WOjyiRMUHJLbtiGkqvBG8m6wdChy7O1plk3cOP1ayqX+H57RPE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com; spf=pass smtp.mailfrom=riscstar.com; dkim=pass (2048-bit key) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b=MkBPYSmP; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=riscstar.com
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-323267b7dfcso1836851a91.1
        for <dmaengine@vger.kernel.org>; Thu, 14 Aug 2025 22:17:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=riscstar-com.20230601.gappssmtp.com; s=20230601; t=1755235068; x=1755839868; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UzJqrcT6Sr4Domw6gSg6TRk14H0do5SxSGJ7BY074bk=;
        b=MkBPYSmPm+vjaAtNFzPc7pasTi8HWZ+/XuqjalBCFZ7T8/hfx2Fsf3tCdwiC8wXWvt
         6QXhRsDd4Q4DBlhNfB6VlQYbGu+z1Nc571Qx8rmZdfk8QUzbvxcDE9zEuIhh9/GDhTZz
         aG79raa8e21ZjDD+X0EWPiXb6GJq+w29+47HLtN3FIYqlqCEbNcV2VCIRDfO2vJGuHoR
         gYwHCQH3m0RXlkeeP3geo4tzsjBiLiPjQgBe9dCXmhGPpf7nKthwp9k0WsfgU1Ws7Lbq
         jpK6B6zYc18WVEJ/tKJPOUv8J5hRjwzUR4V1RpI1TWuNsTuCJJdkx5et1KgCf+Oxcr7d
         vUnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755235068; x=1755839868;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UzJqrcT6Sr4Domw6gSg6TRk14H0do5SxSGJ7BY074bk=;
        b=SGpJQCp/5gOJaHao78rB+L6SOgjeafcFC55Z4ZGlXwwSxZjdxcektwqtBP1idCkkxt
         Cpd0scrGXdopi5hNoxmB6316yuBvDdgkqPdp9CvEo5j83I5RFazKeUkmYDbHwxM2ZuFy
         CFWRbG1LzaiHKrIDKnJJM7v5YMABcuRrfk/2ORxXcCUcHe9WT8WSMxXo4Qus4rZ+m8Cc
         BodM2HvpdUmcsp3K7HzsVGTw8qB3iOohkouTJ5uZ0pYW8GQhnNDc+9kFgJ2YZyiKPv2+
         aqg9n51dKcfSht1X8PE8T9vDAJ6cr1KYVP6YY4rYuf36LOEe13jvQCAomZL+NBqWmdSR
         x6IQ==
X-Forwarded-Encrypted: i=1; AJvYcCURlnIjz4nz2vV/Kvhxe6B4hLhfFmeKKixLNNZy5MQvf6fVw7M+NPFnqYgrCsr7aMUjVpSlsl8Us3E=@vger.kernel.org
X-Gm-Message-State: AOJu0YygTi2NnB5HikniH7SmHDHeZ93F3f5ryxeFCaDwSbWSRb61P5fa
	7rjqKqy++B5tabgqyoH3I6YNXIRBb471AmDya9FhFG3uC1VoAYNRNH/RoOAu1HOx/k8=
X-Gm-Gg: ASbGncvO9M+QRpZoSJ4L1IRz0d5V4JfP52UMJfgczvtfN5wNpejYAtWib9XCRRTZHcz
	t7zbASYyxZXCz/mwT3mU/SqikCU5gJT+RYaroPU+iia56xWcasbpMiHt1lqtTfmYuci6g4E5+Zj
	t9j+6076XCrlWerdQCbdBTUQ1A+SNrOz3yw2OirOycx7DQNbQ6yOt/obLt0e6HjtJwbygeN8GBr
	0E0dH1ymvQsnAqMJN65zz2lPn3DjewlcL5Z0pqkOoO6B/EjvcSAnYOvFCqBKx2cgKrDUw042YNp
	mMlMGZ3W2/3ldRkIydaBMaA4y6qUe0yIv9pp1aEmVDEyGaJIk2lS4x6zF0BCVi/eQAxjO+ZiFD6
	cVPm21oqaF+oDJF6GUZ+YMg==
X-Google-Smtp-Source: AGHT+IGEpJzSAAi5oYh5J4I/dYuHH3xIHOFcQzFYpHxGCez4ecdeF62QFwuHOYZn933LvQXIM7H3KA==
X-Received: by 2002:a17:90b:224f:b0:321:9366:5865 with SMTP id 98e67ed59e1d1-323421217cbmr1522970a91.33.1755235068158;
        Thu, 14 Aug 2025 22:17:48 -0700 (PDT)
Received: from [127.0.1.1] ([103.88.46.155])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-323439978a4sm373212a91.10.2025.08.14.22.17.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Aug 2025 22:17:47 -0700 (PDT)
From: Guodong Xu <guodong@riscstar.com>
Date: Fri, 15 Aug 2025 13:16:24 +0800
Subject: [PATCH v4 2/8] dmaengine: mmp_pdma: Add clock support
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250815-working_dma_0701_v2-v4-2-62145ab6ea30@riscstar.com>
References: <20250815-working_dma_0701_v2-v4-0-62145ab6ea30@riscstar.com>
In-Reply-To: <20250815-working_dma_0701_v2-v4-0-62145ab6ea30@riscstar.com>
To: Vinod Koul <vkoul@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Yixun Lan <dlan@gentoo.org>, 
 Philipp Zabel <p.zabel@pengutronix.de>, 
 Paul Walmsley <paul.walmsley@sifive.com>, 
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
 Alexandre Ghiti <alex@ghiti.fr>, duje@dujemihanovic.xyz
Cc: Alex Elder <elder@riscstar.com>, Vivian Wang <wangruikang@iscas.ac.cn>, 
 dmaengine@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org, 
 spacemit@lists.linux.dev, Guodong Xu <guodong@riscstar.com>, 
 Troy Mitchell <troy.mitchell@linux.spacemit.com>
X-Mailer: b4 0.14.2

Add support for retrieving and enabling an optional clock during
mmp_pdma_probe(). It is optional because in Marvell devices
such as "marvell,pdma-1.0" the clocks property is not a required
property. But in SpacemiT K1 PDMA, "spacemit,k1-pdma" as the dt
binding schema file stated, clocks is required.

Signed-off-by: Guodong Xu <guodong@riscstar.com>
---
v4: Update the commit message, no source code change.
v3: No change.
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


