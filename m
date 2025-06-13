Return-Path: <dmaengine+bounces-5448-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B4A27AD8FA7
	for <lists+dmaengine@lfdr.de>; Fri, 13 Jun 2025 16:36:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 68D9A179677
	for <lists+dmaengine@lfdr.de>; Fri, 13 Jun 2025 14:36:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C0B219047A;
	Fri, 13 Jun 2025 14:36:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ndLY/46N"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com [209.85.208.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86B591CFBC;
	Fri, 13 Jun 2025 14:36:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749825375; cv=none; b=ZAqIZGoC7Mpm2BbiOCS2agx2gQex39+lhDp7BU/qgl0gBcIi/k/3G0CNzQZY9UR8qQdSmKo+YSintBnj3a5Un2IwymmURRZvCPx5atVqU/IlcSmBa3IJ6rWVvU5rsPwBaehCZIHoX+BRMTiTCdw7OxmsrtC5+lWMOvq29xwqtH8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749825375; c=relaxed/simple;
	bh=sG48iV8d+qqPPnq3NQkA2sSLoG7JHppT/L4+5YNmhhs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=OIMeIq/ONqQif4eVfbTSKAVeQNz0AUv762UOh8KTwTyzD+tPE5NZLC5bJhOGg3SxT1JYGHTy9MeLau4ObRJHIjHlEy2mTz4lkTB6be8lkFwY/41IofiRH5SL4wH7u+hmU3CBVQlG84jZRcbq22Kdp+eeZRokF9MmP/rVTXrqIVY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ndLY/46N; arc=none smtp.client-ip=209.85.208.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-32b42935293so3701441fa.1;
        Fri, 13 Jun 2025 07:36:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749825372; x=1750430172; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=L/dusadzFeGxTWxgb6C5US/XQb1kLNY5Mn1HK4umVkk=;
        b=ndLY/46NmO+2BgqsskRapnI3vIt51G6Wa6tJ1hTdeiQjxlMzXOZ96oNR+yrUEA3Awe
         8On6MtPnYAoHrNdiSuybyhvKyBQfezMwQ9Kg5ltxTOELfxAVl4JFj2RJIPvGwgtmfKRf
         2utAnyXlwPgCBMRaWBziKGUGhBUzq7RaFLy4dLgqMOJ0hByYkEORnzEBX/w0zmrIEV6r
         r2BEBsfb+gcA24ZTuVIzBbWEfeypzAnlsZyh1esSQx7Z+92ht0JNiHevwNeyLaaPpEk6
         VBTTC4WN993WIWG978B6RE8WhR/z09QTR/zLNj0/WqPSCK6VaT9k4qPP0GOSenJNlyqm
         mrfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749825372; x=1750430172;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=L/dusadzFeGxTWxgb6C5US/XQb1kLNY5Mn1HK4umVkk=;
        b=s4VnJ2z3olNmUP4vY/jxAzCLL3WONDKEVn4MhiDnpOIlowH0I56o+n0qxtylMdV4tu
         DTaTmcQijFjjP5UV9CfBYw67tQSu2JFtOysCFIaMRCdG3NI8qj4fANy0cVj8mJZbirOT
         1GQfgmdzFuIJomnfkZfQ9Q78AICxbT1Tatnk3Vk5E/ESrGdBQF3yhli8DMoxOzoskxIk
         QHHUtaR6IUHPEgVWBO0Iyke0HWY0K5zQ3tuM0qaiD5T52LBz9oWyPfQDWBBTu8whLc4l
         BVKoIyHcwztVdNGr6ZlisEZ5oOwcbkZwMPMJOMmJjO5yb9UdWUJYnK5rplmB/JcV1miT
         epVA==
X-Forwarded-Encrypted: i=1; AJvYcCW3ajK99OsoQBkZBpRPTK270UXToWInEyeTAHgv2ojVdmfbJtPdCVP/n5JYAENRZp5or+KTOFFi5I9cML+9@vger.kernel.org, AJvYcCWEUK0qyNLNpUYyRrqlNQg2k7SgR6P80ikCdYx00idiJO2oAGoYWA0Kmk1nNieAW6TAUQ2sqFOAXOQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy8to0C84+YCn1QdkkSpehuAJBYAuiEtxu+mSVDCOFdqzRHZyx0
	7cEW56R0EkdFbhqW3ezxAsnAIwBAgTPh0BjvVtHiOzMy8W6rtMtlqQo+
X-Gm-Gg: ASbGncupfq+eqbJnpyGdxqYluXNj5A2vdLW7tfsF9gKtp1hEafBmx2h52Za0Q4vkxn4
	6NXFFnl9jaRv5oYgt2U5UQfAa34QqmNbm0rIzUuyZUo82avKExCV/3MjCS5l/dncSNMF/FMzaug
	0c5OtF3pVbMo2sB4bO5EQSvo8P9S+CKANVj3LMbznnvfw0GauPYZhSyyQFOEp0tNcBlCT9cVCnT
	KYYOauj0eL0oohgutmtW3aYCkwlsWBTZoXt7xmn3GKnzOOtvNnOpi2340F0WNzbjyQD5fY5LPYD
	Ccv/N7sTq6vYWI+HkqhW38eg8ChRNLfMoQ1uVhFxdwq1eUsbeZQjjhC8SpDu8RkzLY22+UyM
X-Google-Smtp-Source: AGHT+IGMDnnMIp1PruaSG65JY1zmOfV/4m3eto6pT076GWvEARJHtobguBVgox12705Lz7dwnryyKg==
X-Received: by 2002:a2e:bc0e:0:b0:32a:7f39:1a2a with SMTP id 38308e7fff4ca-32b3ea82cfcmr9354391fa.16.1749825371249;
        Fri, 13 Jun 2025 07:36:11 -0700 (PDT)
Received: from localhost.localdomain ([89.22.142.19])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-32b331c94ffsm5586411fa.94.2025.06.13.07.36.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Jun 2025 07:36:10 -0700 (PDT)
From: Alexander Kochetkov <al.kochet@gmail.com>
To: Vinod Koul <vkoul@kernel.org>,
	dmaengine@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Nishad Saraf <nishads@amd.com>,
	Lizhi Hou <lizhi.hou@amd.com>,
	Jacky Huang <ychuang3@nuvoton.com>,
	Shan-Chun Hung <schung@nuvoton.com>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Ray Jui <rjui@broadcom.com>,
	Scott Branden <sbranden@broadcom.com>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Paul Cercueil <paul@crapouillou.net>,
	Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Frank Li <Frank.Li@nxp.com>,
	Zhou Wang <wangzhou1@hisilicon.com>,
	Longfang Liu <liulongfang@huawei.com>,
	Andy Shevchenko <andy@kernel.org>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Keguang Zhang <keguang.zhang@gmail.com>,
	Sean Wang <sean.wang@mediatek.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	=?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>,
	Daniel Mack <daniel@zonque.org>,
	Haojian Zhuang <haojian.zhuang@gmail.com>,
	Robert Jarzmik <robert.jarzmik@free.fr>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Samuel Holland <samuel.holland@sifive.com>,
	Orson Zhai <orsonzhai@gmail.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	Chunyan Zhang <zhang.lyra@gmail.com>,
	Patrice Chotard <patrice.chotard@foss.st.com>,
	=?UTF-8?q?Am=C3=A9lie=20Delaunay?= <amelie.delaunay@foss.st.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Chen-Yu Tsai <wens@csie.org>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Laxman Dewangan <ldewangan@nvidia.com>,
	Jon Hunter <jonathanh@nvidia.com>,
	Thierry Reding <thierry.reding@gmail.com>,
	Peter Ujfalusi <peter.ujfalusi@gmail.com>,
	Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Dave Jiang <dave.jiang@intel.com>,
	Amit Vadhavana <av2082000@gmail.com>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	Md Sadre Alam <quic_mdalam@quicinc.com>,
	Alexander Kochetkov <al.kochet@gmail.com>,
	Casey Connolly <casey.connolly@linaro.org>,
	Kees Cook <kees@kernel.org>,
	Fenghua Yu <fenghua.yu@intel.com>,
	Jyothi Kumar Seerapu <quic_jseerapu@quicinc.com>
Subject: [PATCH 0/1] dmaengine: virt-dma: convert tasklet to BH workqueue for callback invocation
Date: Fri, 13 Jun 2025 14:34:43 +0000
Message-ID: <20250613143605.5748-1-al.kochet@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hello!

I have Pine64 (Allwinner A64 ARMv8) board.

I've migrated from 5.4 kernel to 6.12 and noticed that DMA callback latencies
became very high. I noticed that sometimes callbacks get called from
ksoftirqd thread and in that case latencies are about 10 ms.
I found out that tasklet bacame deprecated and decided to rewrite DMA
callback code to use BH workqueue. In my case, that fixed high latencies.

My change affects a lot of drivers, but the change is trivial. I've verified
that affected drivers compile after change. But I cannot test it on all
platforms.


Alexander Kochetkov (1):
  dmaengine: virt-dma: convert tasklet to BH workqueue for callback
    invocation

 drivers/dma/amd/qdma/qdma.c                    |  1 +
 drivers/dma/arm-dma350.c                       |  1 +
 drivers/dma/bcm2835-dma.c                      |  2 +-
 drivers/dma/dma-axi-dmac.c                     |  8 ++++----
 drivers/dma/dma-jz4780.c                       |  2 +-
 drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c |  2 +-
 drivers/dma/dw-edma/dw-edma-core.c             |  2 +-
 drivers/dma/fsl-edma-common.c                  |  2 +-
 drivers/dma/fsl-edma-common.h                  |  1 +
 drivers/dma/fsl-qdma.c                         |  3 ++-
 drivers/dma/hisi_dma.c                         |  2 +-
 drivers/dma/hsu/hsu.c                          |  2 +-
 drivers/dma/idma64.c                           |  3 ++-
 drivers/dma/img-mdc-dma.c                      |  2 +-
 drivers/dma/imx-sdma.c                         |  2 +-
 drivers/dma/k3dma.c                            |  2 +-
 drivers/dma/loongson1-apb-dma.c                |  2 +-
 drivers/dma/mediatek/mtk-cqdma.c               |  2 +-
 drivers/dma/mediatek/mtk-hsdma.c               |  3 ++-
 drivers/dma/mediatek/mtk-uart-apdma.c          |  4 ++--
 drivers/dma/owl-dma.c                          |  2 +-
 drivers/dma/pxa_dma.c                          |  2 +-
 drivers/dma/qcom/bam_dma.c                     |  4 ++--
 drivers/dma/qcom/gpi.c                         |  1 +
 drivers/dma/qcom/qcom_adm.c                    |  2 +-
 drivers/dma/sa11x0-dma.c                       |  2 +-
 drivers/dma/sf-pdma/sf-pdma.c                  |  3 ++-
 drivers/dma/sprd-dma.c                         |  2 +-
 drivers/dma/st_fdma.c                          |  2 +-
 drivers/dma/stm32/stm32-dma.c                  |  1 +
 drivers/dma/stm32/stm32-dma3.c                 |  1 +
 drivers/dma/stm32/stm32-mdma.c                 |  1 +
 drivers/dma/sun6i-dma.c                        |  2 +-
 drivers/dma/tegra186-gpc-dma.c                 |  2 +-
 drivers/dma/tegra210-adma.c                    |  3 ++-
 drivers/dma/ti/edma.c                          |  2 +-
 drivers/dma/ti/k3-udma.c                       | 10 +++++-----
 drivers/dma/ti/omap-dma.c                      |  2 +-
 drivers/dma/uniphier-xdmac.c                   |  1 +
 drivers/dma/virt-dma.c                         |  6 +++---
 drivers/dma/virt-dma.h                         | 10 +++++-----
 41 files changed, 61 insertions(+), 48 deletions(-)

-- 
2.43.0


