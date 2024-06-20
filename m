Return-Path: <dmaengine+bounces-2461-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 36C459110CD
	for <lists+dmaengine@lfdr.de>; Thu, 20 Jun 2024 20:25:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A6BBFB2227A
	for <lists+dmaengine@lfdr.de>; Thu, 20 Jun 2024 18:11:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A5A61BA86F;
	Thu, 20 Jun 2024 17:59:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=timesys-com.20230601.gappssmtp.com header.i=@timesys-com.20230601.gappssmtp.com header.b="OGEufoAX"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E6F51BA090
	for <dmaengine@vger.kernel.org>; Thu, 20 Jun 2024 17:59:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718906362; cv=none; b=cM+zjdRYAXzIxUJUrHiI8P2EZK5aqtSC8ZZSESviYWL+CQDuFlBWwS4YvFcN83GIxMs9kOceI5RAoxnRKcyxfMTlKRl5BzEKplgsjeT+tK5xQGhJaQMV95Q30rXLHxv5ITZIhTzuj+RxgmzJ8k70XiRQ2mEWrNcwlDlL5xjGRY8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718906362; c=relaxed/simple;
	bh=oTww1XOoHQ1WZkCJUUsZn1fHEHSTJ8ydZDprCFOKPl0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=FXXdq9DTCZNrxMJPQ6rcBzWQA/Qam3fPKsuORVocWyaIpS98a8Xw3wx51dmy2gGedFspUV7O8KUDa6BUshQIDK0V0hrcQrKMXzn3uXWrTK/dQ1uHyI03Yt95nlRTLqvVtm21pCcTq1OP85fJLpz5kZonv1uzuRa6BCx1wM7CGA8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=timesys.com; spf=pass smtp.mailfrom=timesys.com; dkim=pass (2048-bit key) header.d=timesys-com.20230601.gappssmtp.com header.i=@timesys-com.20230601.gappssmtp.com header.b=OGEufoAX; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=timesys.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=timesys.com
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-57cbc2a2496so1463907a12.0
        for <dmaengine@vger.kernel.org>; Thu, 20 Jun 2024 10:59:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=timesys-com.20230601.gappssmtp.com; s=20230601; t=1718906359; x=1719511159; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=R+nbkylU75B66T8IPhGtcEUJs01o0nAAuyIYHNhQRcE=;
        b=OGEufoAXxL9IaCsOoTRQCSX68a3AbYH3Vc1UbtZcGseDB/JH3rwGqnuhn3iPUXwfDV
         BM6vfyE73Z2foX92yMl46ia3l8vBynVQlAhxmyg26kumm9PDvyXGX5rXoRNCS3DOwM/i
         nfPWiRtuU9WP3zXgZLTgyDqQXCatlSEoZlLe6gAM4XKBu1GHoWs1UADCMd66LDkoBpFC
         sV6YQh1J48om43ObLI4i3QRAbsl9ElUTO+ioywaqO+TgQ0ITLOvdrICXBhELHLZVl6d1
         wb4UnJnZohTZD8pZqDjsFsZ8zBuw5NIYz4gsF2rlT7bxLKSwYEuyXeJqa+cd+naRkhDg
         Yuxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718906359; x=1719511159;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=R+nbkylU75B66T8IPhGtcEUJs01o0nAAuyIYHNhQRcE=;
        b=bCD5LjcE98JXvD9VUE1XZnrXQQk2bzgoJAsUa4pbLeY3AQoHxUEAPEVRecek0KVnx1
         N7AudftbHz37neq8ojbSNJ/9S30CzHvC159WL8mfazeKLqdZt0fnmegzWHkbyLbh3vcL
         Pf8JIkw7YvvyPq/IR+IVu1P+AC0mYtLhRclmFIz+w5KWix+r68TzRtRUy8hV5wm1b1Sr
         JWV/EbiKXZQ9evne27RmbcK7l677zKfp/hyYwKXG+aoLDUgVKOC8Fb4ss70bFt74H+at
         8B+sJMuYSDRhdfWWqojAX9QV6p5hzq3Zw5ul46iqvOw2fQYmE0xdUbaTXwhiU+lSpDa7
         SuHQ==
X-Forwarded-Encrypted: i=1; AJvYcCUNiu3RmcguQlmVznp6uJctONOaR1crXHbP70HmtF/2Bq7kIaj5G+AAjRXZggpRk51gfXEZRxSK6FTp4mp/IFN12mFZ4u9NVQ+X
X-Gm-Message-State: AOJu0YwEjH2tk6f24IZ+95fp/aKJ6nB8DmBbtRX7GWhfHtOCfMNsSbFz
	TJ68MH4o2BIwte96yF0WMIX+I0jOFsjPy71lZvblgA0eKqIQSwUYMhnQ7nKEDVE=
X-Google-Smtp-Source: AGHT+IGwiD3L95St/ehfaodQi7lOhfrdpQHGauU5aloxC0usOuACZecYTLoGty75spYidqSIKDxV5Q==
X-Received: by 2002:a17:907:7293:b0:a6f:6f4a:b25c with SMTP id a640c23a62f3a-a6fab60a2acmr584690566b.14.1718906359615;
        Thu, 20 Jun 2024 10:59:19 -0700 (PDT)
Received: from localhost.localdomain ([91.216.213.152])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a6f56f42e80sm781370766b.186.2024.06.20.10.59.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Jun 2024 10:59:19 -0700 (PDT)
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
	Michael Ellerman <mpe@ellerman.id.au>,
	Chancel Liu <chancel.liu@nxp.com>,
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
Cc: Markus Elfring <Markus.Elfring@web.de>
Subject: [Patch v4 05/10] clk: lpc32xx: initialize regmap using parent syscon
Date: Thu, 20 Jun 2024 19:56:36 +0200
Message-Id: <20240620175657.358273-6-piotr.wojtaszczyk@timesys.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240620175657.358273-1-piotr.wojtaszczyk@timesys.com>
References: <20240620175657.358273-1-piotr.wojtaszczyk@timesys.com>
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
Changes for v4:
- This patch is new in v4

 drivers/clk/Kconfig           |  1 +
 drivers/clk/nxp/clk-lpc32xx.c | 10 ++--------
 2 files changed, 3 insertions(+), 8 deletions(-)

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
index d0f870eff0d6..2a183a9ded93 100644
--- a/drivers/clk/nxp/clk-lpc32xx.c
+++ b/drivers/clk/nxp/clk-lpc32xx.c
@@ -7,6 +7,7 @@
 #include <linux/clk-provider.h>
 #include <linux/io.h>
 #include <linux/of_address.h>
+#include <linux/mfd/syscon.h>
 #include <linux/regmap.h>
 
 #include <dt-bindings/clock/lpc32xx-clock.h>
@@ -1511,17 +1512,10 @@ static void __init lpc32xx_clk_init(struct device_node *np)
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
 		pr_err("failed to regmap system control block: %ld\n",
 			PTR_ERR(clk_regmap));
-		iounmap(base);
 		return;
 	}
 
-- 
2.25.1


