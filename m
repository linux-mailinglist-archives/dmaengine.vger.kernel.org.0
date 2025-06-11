Return-Path: <dmaengine+bounces-5356-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CBB85AD565A
	for <lists+dmaengine@lfdr.de>; Wed, 11 Jun 2025 15:02:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DA5511BC4CEA
	for <lists+dmaengine@lfdr.de>; Wed, 11 Jun 2025 13:00:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38C34286D45;
	Wed, 11 Jun 2025 12:59:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b="kCiWSF46"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EF332836A4
	for <dmaengine@vger.kernel.org>; Wed, 11 Jun 2025 12:59:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749646794; cv=none; b=seu8161CsBEP9keNT3+w88ZseYeUcFBlUODIYmfeupAwV0QNgTBBm65C/+MRko1RHgcZ2uoGAcTi7dWizS9H9bNann/gEu+aO/v9eCQ700OeaM9JmSf7s/YkOjU2twnDaJD/W0LVElyuTgMXWKyMwkoM5mteClz2WcuHJDtIwAw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749646794; c=relaxed/simple;
	bh=w3tQqbAHCuIlmTn7bB97ckFjqMR0odxo/xEDlJG2tEI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nABX4v1sNvx9MOZZ0rSHeeBaknGhG27Sr79xcsFbuEMvRBntVdMZVsWQpUlZatJ7U/72nvIl0DNyWQpQ1xjYHAl5rftBmgdkFx6AZL7vTM8y4J6tgQwYMerKPyp7ayX59dkMkVSKxUDihyycslpAFyFv3mEJeiGOLApbYXYG1rs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com; spf=pass smtp.mailfrom=riscstar.com; dkim=pass (2048-bit key) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b=kCiWSF46; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=riscstar.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2350b1b9129so43990185ad.0
        for <dmaengine@vger.kernel.org>; Wed, 11 Jun 2025 05:59:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=riscstar-com.20230601.gappssmtp.com; s=20230601; t=1749646791; x=1750251591; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7o24DxeXgIvRNvf36TN4y++evYbOInZZuq385XvrXzk=;
        b=kCiWSF46Pjz/6TAZmn0K0JgMhTH6SCSjTVn+NCUT8ACm1eY6unJAgMzpZCW26iH7V2
         +/1NOtnj+4Y52szSohkiAN8156HtI5rel5FMnjKOnHnmaf+x2xW9wmKHloS+5ZCPjILt
         s/QWJA5KciHgLhcLGcI0kFAA58xF66RqbLMeWAeHgCxekbTcOPqkX+K8gvst8G9GB4hX
         V4p8KFyWAzOfkwWQHq5qw80zTNyvBweOkAkiWumMd6+e44ccawVDr9qXyLJnrma+YwJI
         m/7GyX2hPLaVbRqG699OHVdHSFAyV5y5AMY63xrDu0aBGrVw08ijZa57i42HGZ6OaTms
         NZAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749646791; x=1750251591;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7o24DxeXgIvRNvf36TN4y++evYbOInZZuq385XvrXzk=;
        b=HXng2zRim8n85WasEFe6uvfI7Cq5uuVymmwAqRWfjWL/Nsm5tDdX7HR5Jyk7N+cefb
         PMlqd4r6/ez3OL2s2ullO4ki8VGlzvDEZx6AV2ZTvdfeWCL/K37Tymo9eYzlHpwWwZw4
         sMIr1vtVNrACpyZHEGrshDxbmPvLS+5OFLUf8cZjJtVx92brAt+ZMadZnrOmXLKsQLL3
         cNbboBDwQySWUBOop5CoT68vOB+Uulz8S6/z+fOWbd2uH7azYDxHsyreeFm5/HIG16c6
         X9dfsNFtugUfu8Of1gEqO4BAmJpWEQmf5LNMjBZTpQ6DHlefv6XUsCbvEB5MYrjpyghX
         TVeg==
X-Forwarded-Encrypted: i=1; AJvYcCUeUQyHR8zLkk5xsYpx59/YZbMHG/fHfn9yD+1Us7pXLT7kW8XX+Afold450Qe3wsLB83n8BUHTgvo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx5sieEozxQfufrVJsNx2PL819YSrsZsWyDhH1rJtCGnCD2l67k
	DXlqdKKaZcDgXQfCFrJVH4T43HKYwx1JmIP2oIyveUAUyO6o5q6a63bhU+f+KGq7HYsiGVHaY5t
	3hXpUZR21VtNV
X-Gm-Gg: ASbGncuTRJ8qj0O3YZXdakw0jx8FmBesDVcpliGLKRDZVj4aRwHeIzZfzziANEQV9uN
	rd7DC6n3SXosq4dlOpBgVDMNqCwH1iOL77ypCPVZBMsTGovCO0DHfDLy7yGKzGDT1iMFVM4Xg+9
	W7tFVEz15Gd0zug0pi6vM1GBf7LOU4PjPgvDdpVpjtPmD9pKqlOikft3t8ePb2+hiPPOnmiW2ps
	oRMHXtuedigu7Ha2uTpyktr/mE7ZZiOZ8MctzVSaX7vp0QRmx0QklUmV15TltLnMEllMYgREKcl
	6pJdQ9DpB4sDd8nfM3VLSbkvanHwsZ+JeE0zBbEXawpwRWCMQ8RWRyIR3GDSyNUZyNcjh7QXMhP
	osA0QvQozVl3Eo51/fN+be++A2Lzyw1EU
X-Google-Smtp-Source: AGHT+IH7USNXfR5sNsfQYnJhCwki/U4RwupJq6yD1CeMplQGSscMAoiL9MAMbLTMCcEmy+9woSzN4g==
X-Received: by 2002:a17:902:f70f:b0:234:a139:1203 with SMTP id d9443c01a7336-23642683ebfmr42207415ad.32.1749646791610;
        Wed, 11 Jun 2025 05:59:51 -0700 (PDT)
Received: from localhost.localdomain ([2409:8a00:31a4:6520:3d67:ceb1:7c60:9098])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-236030925e3sm86984115ad.53.2025.06.11.05.59.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Jun 2025 05:59:51 -0700 (PDT)
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
Subject: [PATCH 3/8] dma: mmp_pdma: Add optional reset controller support
Date: Wed, 11 Jun 2025 20:57:18 +0800
Message-ID: <20250611125723.181711-4-guodong@riscstar.com>
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

Add support for hardware reset control in the MMP PDMA driver using the
devm_reset_control_get_optional_exclusive_deasserted() API.

The reset controller is retrieved without a specific reset name,
allowing platforms to define a single default reset line for the
PDMA controller.

Signed-off-by: Guodong Xu <guodong@riscstar.com>
---
 drivers/dma/mmp_pdma.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/dma/mmp_pdma.c b/drivers/dma/mmp_pdma.c
index 4a6dbf558237..fe627efeaff0 100644
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


