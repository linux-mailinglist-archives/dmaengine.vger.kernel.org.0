Return-Path: <dmaengine+bounces-2562-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AC0291AA4B
	for <lists+dmaengine@lfdr.de>; Thu, 27 Jun 2024 17:04:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9EA931C2234F
	for <lists+dmaengine@lfdr.de>; Thu, 27 Jun 2024 15:04:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 326831974FA;
	Thu, 27 Jun 2024 15:03:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=timesys-com.20230601.gappssmtp.com header.i=@timesys-com.20230601.gappssmtp.com header.b="WXTSZ5gL"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CCA7198A01
	for <dmaengine@vger.kernel.org>; Thu, 27 Jun 2024 15:03:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719500626; cv=none; b=mpVZsb9WR0mDyE/YIjpdYyPWEa5NPR/c6BdPNE87vJiFnRfB4J+/AmDYbwin50wm7TDDX5N7daGrWdbHvcN9BSPBko20ALKAixXt/p32e1f3V4XburfLDnpQ9HDX/8raUR87rvqj9kfCMgZplQUjp5pQAksZ5zhTK25GjjnuqqA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719500626; c=relaxed/simple;
	bh=hz9vMGQkJCRjJHzyKADPoZQ1+W9Qq2q+0aeL6AyIwwE=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=UlKsFgEmItrE9Rnja5XLq0eoh+aCokqD0dR1GUibroulvq03wXtWc7ToNuozQvxJngWSVb9tdeHFNxhmR4iVB3jFkkSmyXRr98h1tfkik/UT0Lq2Ig22MocGHx2FfLrARaIzh9ZEzcppYPlcIhE3mJodEnXstS4KY/O+1huvo5o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=timesys.com; spf=pass smtp.mailfrom=timesys.com; dkim=pass (2048-bit key) header.d=timesys-com.20230601.gappssmtp.com header.i=@timesys-com.20230601.gappssmtp.com header.b=WXTSZ5gL; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=timesys.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=timesys.com
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-a72420e84feso734207966b.0
        for <dmaengine@vger.kernel.org>; Thu, 27 Jun 2024 08:03:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=timesys-com.20230601.gappssmtp.com; s=20230601; t=1719500623; x=1720105423; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HK3YnwUakD5I0BhgcE6EqxKNTh3E2b909JJ6LJOQWzo=;
        b=WXTSZ5gLXCbzMHUx9pbcLusKQp5Li61OY1n5N2DlmVJI3KHgxuIGy6lNZPdbPybKEA
         9o8fKETuWjIXlpFygS1wknH5ECCwz9K+Ifao2ivxt+zaUjnfIXJQmhe9w2CN2TKQXIk7
         fKq+RmjqYYIV7pGnYUUIaDCDxeiUpOZmr0LlDb97s3UvQR+5zBBJeAPLa1PFnYG0LjWX
         K30KXX1xNklc7dK9q8dRQOeSxdL7vM6xdHKtmWCcJbtEBUBXw8PWMHB5FH8qQv8U9jU/
         /SkmO7nZ65XHJAaxzxd7zx7LVrA4CDtey97X2u0DcDiJ8D6SUYjFlPBgzc71Lq2F2Pgw
         qjQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719500623; x=1720105423;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HK3YnwUakD5I0BhgcE6EqxKNTh3E2b909JJ6LJOQWzo=;
        b=va4mQOnxco6SHl5/BqB21ldO/2UCQF23NlM57z83sCp64l5NHiJJSzn7wrAhTi91ee
         2a9B2cqcaEDl4RBNKLnkW2gjXH/2C/kHgpuxVmwU5K7/AFd1Qgo9ZP/ib3Tfao0mkJd8
         O6iFPEKuS7LmA9JuG89L9Ekkhqa+rqC62r87if7g2S2XyuK0QKqwQi1diop1S4KKjfTA
         TLgnQgmd67gWYze4iC1nMjslBPJm7g43wR2FdgoFO30lmkcM/Ycsbryr52DIMa3jouTB
         4j1gtZDi8wCZ3v2qR9e60dznEhkJ9m5SEsznW5ndeolm5tmT9TkT4rDjqogR+/OOjqDM
         lnlA==
X-Forwarded-Encrypted: i=1; AJvYcCXn5ri8XwBtxcsO7+DExXzokWMso9lQbRZ4h0E1usUpuNUa9acDkmVJRFNcfLANf3dBWOE86MmXryMgA8d7A3WjdHs0LmLsfG6+
X-Gm-Message-State: AOJu0YyYSs87hGu9eOQFkdc9EIzmJWLCz0uc+XvMVtGA3IGa53Y4D+Z3
	crf3u+Xhfp8HdSZ+ahVarH6t2DkZ+JtRyKK+hEzhBcniwfuJBNDCFSiNSQeDcPc=
X-Google-Smtp-Source: AGHT+IEAPzD6OW6I5gXrK5R5rKDBnBfIPb8ujVS2DyQUrkTnzInDvDleYelSt4/XGlIg6GkZNz/Tdg==
X-Received: by 2002:a17:907:d386:b0:a72:8d4f:6720 with SMTP id a640c23a62f3a-a728d4f6df3mr385836766b.69.1719500620657;
        Thu, 27 Jun 2024 08:03:40 -0700 (PDT)
Received: from localhost.localdomain ([91.216.213.152])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a729d7ca289sm67189066b.222.2024.06.27.08.03.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Jun 2024 08:03:40 -0700 (PDT)
From: Piotr Wojtaszczyk <piotr.wojtaszczyk@timesys.com>
To: Vinod Koul <vkoul@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	"J.M.B. Downing" <jonathan.downing@nautel.com>,
	Piotr Wojtaszczyk <piotr.wojtaszczyk@timesys.com>,
	Vladimir Zapolskiy <vz@mleia.com>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Russell King <linux@armlinux.org.uk>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Andi Shyti <andi.shyti@kernel.org>,
	Miquel Raynal <miquel.raynal@bootlin.com>,
	Richard Weinberger <richard@nod.at>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Yangtao Li <frank.li@vivo.com>,
	Li Zetao <lizetao1@huawei.com>,
	Chancel Liu <chancel.liu@nxp.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Corentin Labbe <clabbe@baylibre.com>,
	dmaengine@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	alsa-devel@alsa-project.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-sound@vger.kernel.org,
	linux-clk@vger.kernel.org,
	linux-i2c@vger.kernel.org,
	linux-mtd@lists.infradead.org
Subject: [Patch v5 07/12] clk: lpc32xx: initialize regmap using parent syscon
Date: Thu, 27 Jun 2024 17:00:25 +0200
Message-Id: <20240627150046.258795-8-piotr.wojtaszczyk@timesys.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240627150046.258795-1-piotr.wojtaszczyk@timesys.com>
References: <20240627150046.258795-1-piotr.wojtaszczyk@timesys.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This allows to share the regmap with other simple-mfd devices like
nxp,lpc32xx-dmamux

Signed-off-by: Piotr Wojtaszczyk <piotr.wojtaszczyk@timesys.com>
---
Changes for v5:
- Add fallback regmap for previous simple-bus DT entry

Changes for v4:
- This patch is new in v4

 drivers/clk/Kconfig           |  1 +
 drivers/clk/nxp/clk-lpc32xx.c | 26 +++++++++++++++-----------
 2 files changed, 16 insertions(+), 11 deletions(-)

diff --git a/drivers/clk/Kconfig b/drivers/clk/Kconfig
index 3e9099504fad..85ef57d5cccf 100644
--- a/drivers/clk/Kconfig
+++ b/drivers/clk/Kconfig
@@ -346,6 +346,7 @@ config COMMON_CLK_LOONGSON2
 config COMMON_CLK_NXP
 	def_bool COMMON_CLK && (ARCH_LPC18XX || ARCH_LPC32XX)
 	select REGMAP_MMIO if ARCH_LPC32XX
+	select MFD_SYSCON if ARCH_LPC32XX
 	select MFD_SYSCON if ARCH_LPC18XX
 	help
 	  Support for clock providers on NXP platforms.
diff --git a/drivers/clk/nxp/clk-lpc32xx.c b/drivers/clk/nxp/clk-lpc32xx.c
index d0f870eff0d6..b8de7f66d1b5 100644
--- a/drivers/clk/nxp/clk-lpc32xx.c
+++ b/drivers/clk/nxp/clk-lpc32xx.c
@@ -7,6 +7,7 @@
 #include <linux/clk-provider.h>
 #include <linux/io.h>
 #include <linux/of_address.h>
+#include <linux/mfd/syscon.h>
 #include <linux/regmap.h>
 
 #include <dt-bindings/clock/lpc32xx-clock.h>
@@ -1511,18 +1512,21 @@ static void __init lpc32xx_clk_init(struct device_node *np)
 		return;
 	}
 
-	base = of_iomap(np, 0);
-	if (!base) {
-		pr_err("failed to map system control block registers\n");
-		return;
-	}
-
-	clk_regmap = regmap_init_mmio(NULL, base, &lpc32xx_scb_regmap_config);
+	clk_regmap = syscon_node_to_regmap(np->parent);
 	if (IS_ERR(clk_regmap)) {
-		pr_err("failed to regmap system control block: %ld\n",
-			PTR_ERR(clk_regmap));
-		iounmap(base);
-		return;
+		/* fallback to mmio if syscon fails */
+		base = of_iomap(np, 0);
+		if (!base) {
+			pr_err("failed to map system control block registers\n");
+			return;
+		}
+		clk_regmap = regmap_init_mmio(NULL, base, &lpc32xx_scb_regmap_config);
+		if (IS_ERR(clk_regmap)) {
+			pr_err("failed to regmap system control block: %ld\n",
+			       PTR_ERR(clk_regmap));
+			iounmap(base);
+			return;
+		}
 	}
 
 	/*
-- 
2.25.1


