Return-Path: <dmaengine+bounces-6122-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3974AB30C48
	for <lists+dmaengine@lfdr.de>; Fri, 22 Aug 2025 05:09:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 44D3A564697
	for <lists+dmaengine@lfdr.de>; Fri, 22 Aug 2025 03:07:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F947275AFC;
	Fri, 22 Aug 2025 03:06:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b="0PssIhJK"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0B57273D6B
	for <dmaengine@vger.kernel.org>; Fri, 22 Aug 2025 03:06:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755832007; cv=none; b=MZu3L6jSx5jPp3o0QVz1Bik69S2yKBJuPuZiXyWP/tox8AcoobpitmMSQRh3iM0V+4yOulzK7Mq72VrljBonHKfXsLWzL7EBsDbofUjNfDpWgYd1kUme/mfDtaxS2PSLUHYUXNl6VtaJBb3ZP3LSDoE9YuKQn4eD7KQGxaqGY28=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755832007; c=relaxed/simple;
	bh=6B1EWWWNBC0BcU5DjOwniaBZ2haD4jvXMC5b4w6KDZs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=TnyyjcgZC/z6vYea49HjGZ7ClBODlEsR3eNddKTJoxPKvm10kIxbukdn35p70yIUzrNjIWradTz/96/MsNCfaK/61DKEH2+/bX2jDdOJDUsK+X1ZHtbzdYotl62qxg4EJ40k9jSY+D/XDR3FMhQ87OsVdGY/iSjUtksHnRoqhXg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com; spf=pass smtp.mailfrom=riscstar.com; dkim=pass (2048-bit key) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b=0PssIhJK; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=riscstar.com
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-32519b32b6cso344736a91.0
        for <dmaengine@vger.kernel.org>; Thu, 21 Aug 2025 20:06:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=riscstar-com.20230601.gappssmtp.com; s=20230601; t=1755832005; x=1756436805; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZNSJ2mPLuZ8B3CyF3qAdwHZOD3xnp4hT+na7SYM4Trs=;
        b=0PssIhJKONXkOMoY67F3UDVdTd/ixRwfNEy9BTr/Dg9e1gCnWbS0HFXzmpxWBasIhA
         IUe9dunwbTTXZk0R9JUDj23Hp1qMiSKkp+8hX+mOlbf/s/c5zlG8xN7UvZtAL2QW8FX3
         ZEBDlFEzSkG1WTqetYA6pjxtXchjuxy0LH2ev47K58sM7/0ZpZ4GXsOj8yqLJJCaY+Z7
         1ECCr0AVWsSJjyDfLE5vU0Krz/SBu527HPSlvZ9saw1jv6NHZC9wLlA4HtRTfyIlWChD
         vtbbYQsNrjUape+PbSWF2o7q54mDmQO7+mQCiYxwpirmTdMZojXsyGhDuiSfyeIEy+WK
         dGvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755832005; x=1756436805;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZNSJ2mPLuZ8B3CyF3qAdwHZOD3xnp4hT+na7SYM4Trs=;
        b=NR3RIAMZmgnl0VRNXDfQEo92RGk21puCoYtc+tlcXWJEip5Y8dQgM2hWh7v3xjhiyV
         9QSVTnpjxLPz4E8W+87P0NUc1aiTnXJUbQ+6IlYuU6ZsQA0OaRRBzXrHMkhy6uSyvnBA
         7owQ8MQepTWVXkMP+Z4tx/wdhgF46AVN7xIxvGK/uywXFnWJnoY8caCulZBf5vtPuvy5
         OjVHyF4XAsojpEdnVmb5SGabKrxYOa70G0svoLpmSffy22ER9e4UQLzzglWeyIOu0vDN
         J2l14/GNvMicmlsKaY+V8py7yosfhCNBNvnQhnH+YKn5KP9A+iSZ6xYvuwLgzJzOchRk
         UFZg==
X-Forwarded-Encrypted: i=1; AJvYcCUrW7+Fp/5m0/wBg6jqNz8U8oBOgjZWLpvfZGcBCPTacvxBMetdRdPnhJHcJAC9+PxiXpunLpjsXpM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwEnoLzDZ6XrBXNUaRhZ2LJy3q8FKIzwNd5LCroiqJebyV757uS
	ZSm/ygGYdFA+s6DGFUBGy4ztWjryx06Gh16lrfH3FqZPbn/QQYUHUQ3P3ecQNAS+oO8=
X-Gm-Gg: ASbGncvmx6NzKO5B3cxK0ivjUcL4AbsOUWKVxRIY9yQwrc/Har8gD2PdNamJ9f+4vnk
	zgIswSSIygQZe7ihLaZigdSv6YbNzabxs3/ZU3prZSGSGZwlpXL7gbRnRVW+nXrprvgwBuiROoE
	YhmLq2PeVTU5WnLLz+uiO7iDWLXBe5L+BCypqq0/8pxG1f7Ee2W7yefXNV/+O0fY3Q/YiuBhxHQ
	TIEsxdPOIsTwjB4JC1BrpHR06VlayR27nhoVxGwKqEPWxnSCW1q7ATF1fQQj3ljPsOJcjTlw9sW
	N1gppK5oDtwrPoT3yuUXapRM7e6ipHN5sFUNuphxf3yCoWCtIFRC04QbrQL/FGMQx65hoALa51b
	wM/BY8gT3kF7EeI6gTMRMcZIljoxvr+6tOw==
X-Google-Smtp-Source: AGHT+IFm4R14mG8VZTD2qtlcugXo9bV6lRrUZXdMxf/jLK5A59pmBdn675N88wWnNFsP+MW07XoLbQ==
X-Received: by 2002:a17:90a:e703:b0:31f:6d95:8f76 with SMTP id 98e67ed59e1d1-325177456famr2245633a91.29.1755832005018;
        Thu, 21 Aug 2025 20:06:45 -0700 (PDT)
Received: from [127.0.1.1] ([222.71.237.178])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b47769afc1bsm2756777a12.19.2025.08.21.20.06.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Aug 2025 20:06:44 -0700 (PDT)
From: Guodong Xu <guodong@riscstar.com>
Date: Fri, 22 Aug 2025 11:06:28 +0800
Subject: [PATCH v5 2/8] dmaengine: mmp_pdma: Add clock support
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250822-working_dma_0701_v2-v5-2-f5c0eda734cc@riscstar.com>
References: <20250822-working_dma_0701_v2-v5-0-f5c0eda734cc@riscstar.com>
In-Reply-To: <20250822-working_dma_0701_v2-v5-0-f5c0eda734cc@riscstar.com>
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
v5: No change.
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


