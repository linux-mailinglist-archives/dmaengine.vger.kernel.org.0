Return-Path: <dmaengine+bounces-5794-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D1A43B03B0A
	for <lists+dmaengine@lfdr.de>; Mon, 14 Jul 2025 11:41:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 41F611A6054D
	for <lists+dmaengine@lfdr.de>; Mon, 14 Jul 2025 09:41:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11D67244668;
	Mon, 14 Jul 2025 09:40:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b="05u/1uny"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 268DE244673
	for <dmaengine@vger.kernel.org>; Mon, 14 Jul 2025 09:40:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752486033; cv=none; b=PfFlmQd9SDXpO2jNxTCQAv2cB8hzxkQDZRfZCjupvnixbTmzWKNuXMjXTKTZgajlQPl4hMXKH7tUizUscBEwl/gVjrM4dbHhsfX46k4mpEBU/TeR/ZOQyWhkx2BbGdGJOxPnZsWo4zTWyKtmlWniz6WP+u44C3pvswevPhwDwoU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752486033; c=relaxed/simple;
	bh=Rnvq7ILXDlYn7NCyNrMKelcmx8kPHn08CJvMC7C4paI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Girg8KdNx5NxsrCghqoXGsy6wA5kCfQgQ+DFLtUCqpzRLFk6d9lDnByuzp0BnEjMyAzCryl4KDzEKXDud9OTXd/z4ulOMrKnczAPSthC8LY0Y6e6b9loLcE/Won0hSbPjcZOHF51IbPypKH4/r6CzLRfMU8f5c4oWwWiHn9Kpgc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com; spf=pass smtp.mailfrom=riscstar.com; dkim=pass (2048-bit key) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b=05u/1uny; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=riscstar.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-4561a4a8bf2so8298905e9.1
        for <dmaengine@vger.kernel.org>; Mon, 14 Jul 2025 02:40:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=riscstar-com.20230601.gappssmtp.com; s=20230601; t=1752486030; x=1753090830; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OERStMpxFd1oXz1mhimWCIXZsdyaGxN/N1YtYf02ffU=;
        b=05u/1unyDoWhpxfJaRp+DbVH5Z0MtRjys9KbOZbfg79QZdu43Kw2d+5pSUJNjOZuaq
         RahcbRYqgMX4o1cE7jUWsvHOqoretF0xNkKn5ruS9in2tJr5yiII+37lVHAqRIzqqyHu
         atvoYyMIMpe5rM1oit5kwKkwP/yHscYF8xV05d/Fy4kdctxn8BIUZahGaN96lVJaJcCh
         BFHWqO+tj1KrViutmDyKAeX4t5A+MwbA3TKR9ec068GI6n7USDOYZCKCgkv5Hojd+y5+
         dPDtXLfaU5GYTmMhBk72/zRZleKlw5dwwzNiUrcDK+VW0z1eSfdXAvGEN12nyE+1/Tki
         vaEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752486030; x=1753090830;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OERStMpxFd1oXz1mhimWCIXZsdyaGxN/N1YtYf02ffU=;
        b=sTbqxpknoVTNdIcHYkqlPfS3LipPu2BOMp2UGPrkcYhJtjkBGNivYJz0+HDhZuMOWa
         hPkQK/mgg90BgbuYKD1S33dpijLzRVssHZwPGecFTWetcOar2SDCJ5lBW8zYHfFTsPzN
         1ySVgINGWDVyTFQ9nfvjmHIBOITPVkOibj9sS7ifqziID1hXdKTUjufW+yIR2euKRlzE
         SV6RqFRy+19EGQu25e0erUHiAJCZhxQAVJ2K6ZAxetJ4LGUS7wKrYGu1oTDggQ1tanE4
         r0rfVWtD8Z1bN0a4aZd7m8wrGEkK4LFApYp9TqXg9g0lVthSAq/qYzJ8m5AsW9Oyhfcd
         1pnw==
X-Forwarded-Encrypted: i=1; AJvYcCUfYdFTH+y2IEE4B2cX0EgCATy6qyvU2h41NJ8zOqz36NVcIdUPdeQXM1lBB7XnnU2O4NMuEXbasGw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx+bu6XSXrF4MMgPi9kNjwL2imw42IQ9YHa1Ofa4jxnM2a9nVd/
	wzZM+t6hRbotCwXHcLGFbp22PdhotfrgCNxaHvBhdYcgjgSZ2eFncboHKznc7gbV6t7Yf4vBqgQ
	pfM5U6ynFfjnf
X-Gm-Gg: ASbGncu3lh3Zg15SCaY4p06zYtNWqpz+6Q4EQt4SnhmnKsmLMlt6i6RNs85C8bZdl5K
	vhP/4Iyepyj8K6zeXSE25Z2TAnIzUbFFTYJE9noLPEBn04o2GdTUsDzdRDU0s32U525comZ30VW
	Uns5QERwvZkn8hmPNLsfloX2c5zvMGTwlsfjcmJRzFWSCDhMPqpNFb+9VWlXrZZuW5nGwA9hIjU
	0mTzuaXKi18q7NZTbzOk75qR4P39jFlW9ONYfTHT74EtJ+t2LeiegsBZ22ecxIpOjt3nfH2495K
	uJXIHje0KMBc5ar3wSAOcdihRRAxbSCYK7tOSIMvNuRCRG9hF9ohPl3Zx5aiYPuwFKJ9JK7sTA=
	=
X-Google-Smtp-Source: AGHT+IFjyUYE1dOQ8JxazLI7iDjsE8P/QTDlCi2i9qu5IYfCUbgHi3kKfOduLMWkN27Rdg061Q9fig==
X-Received: by 2002:a05:600c:a08e:b0:453:745:8534 with SMTP id 5b1f17b1804b1-454ec128c22mr110575145e9.12.1752486030219;
        Mon, 14 Jul 2025 02:40:30 -0700 (PDT)
Received: from [127.0.1.1] ([2a09:0:1:2::3035])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4561b25a948sm24989035e9.35.2025.07.14.02.40.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Jul 2025 02:40:29 -0700 (PDT)
From: Guodong Xu <guodong@riscstar.com>
Date: Mon, 14 Jul 2025 17:39:30 +0800
Subject: [PATCH v3 3/8] dmaengine: mmp_pdma: Add optional reset controller
 support
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250714-working_dma_0701_v2-v3-3-8b0f5cd71595@riscstar.com>
References: <20250714-working_dma_0701_v2-v3-0-8b0f5cd71595@riscstar.com>
In-Reply-To: <20250714-working_dma_0701_v2-v3-0-8b0f5cd71595@riscstar.com>
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

Add support to acquire and deassert an optional hardware reset controller
during mmp_pdma_probe().

Signed-off-by: Guodong Xu <guodong@riscstar.com>
---
v3: No change.
v2: No change.
---
 drivers/dma/mmp_pdma.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/dma/mmp_pdma.c b/drivers/dma/mmp_pdma.c
index 4a6dbf55823722d26cc69379d22aaa88fbe19313..fe627efeaff07436647f86ab5ec5333144a3c92d 100644
--- a/drivers/dma/mmp_pdma.c
+++ b/drivers/dma/mmp_pdma.c
@@ -16,6 +16,7 @@
 #include <linux/platform_data/mmp_dma.h>
 #include <linux/dmapool.h>
 #include <linux/clk.h>
+#include <linux/reset.h>
 #include <linux/of_dma.h>
 #include <linux/of.h>
 
@@ -1021,6 +1022,7 @@ static int mmp_pdma_probe(struct platform_device *op)
 	struct mmp_pdma_device *pdev;
 	struct mmp_dma_platdata *pdata = dev_get_platdata(&op->dev);
 	struct clk *clk;
+	struct reset_control *rst;
 	int i, ret, irq = 0;
 	int dma_channels = 0, irq_num = 0;
 	const enum dma_slave_buswidth widths =
@@ -1043,6 +1045,11 @@ static int mmp_pdma_probe(struct platform_device *op)
 	if (IS_ERR(clk))
 		return PTR_ERR(clk);
 
+	rst = devm_reset_control_get_optional_exclusive_deasserted(pdev->dev,
+								   NULL);
+	if (IS_ERR(rst))
+		return PTR_ERR(rst);
+
 	if (pdev->dev->of_node) {
 		/* Parse new and deprecated dma-channels properties */
 		if (of_property_read_u32(pdev->dev->of_node, "dma-channels",

-- 
2.43.0


