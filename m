Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7606F7BE25
	for <lists+dmaengine@lfdr.de>; Wed, 31 Jul 2019 12:16:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727612AbfGaKQs (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 31 Jul 2019 06:16:48 -0400
Received: from hqemgate14.nvidia.com ([216.228.121.143]:10109 "EHLO
        hqemgate14.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725914AbfGaKQs (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 31 Jul 2019 06:16:48 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate14.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5d416a900002>; Wed, 31 Jul 2019 03:16:48 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Wed, 31 Jul 2019 03:16:47 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Wed, 31 Jul 2019 03:16:47 -0700
Received: from HQMAIL107.nvidia.com (172.20.187.13) by HQMAIL106.nvidia.com
 (172.18.146.12) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Wed, 31 Jul
 2019 10:16:47 +0000
Received: from hqnvemgw01.nvidia.com (172.20.150.20) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3 via Frontend
 Transport; Wed, 31 Jul 2019 10:16:47 +0000
Received: from moonraker.nvidia.com (Not Verified[10.21.132.148]) by hqnvemgw01.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5d416a8d0002>; Wed, 31 Jul 2019 03:16:47 -0700
From:   Jon Hunter <jonathanh@nvidia.com>
To:     Laxman Dewangan <ldewangan@nvidia.com>,
        Vinod Koul <vkoul@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>
CC:     <dmaengine@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
        Sameer Pujar <spujar@nvidia.com>,
        Jonathan Hunter <jonathanh@nvidia.com>
Subject: [PATCH RESEND] dmaengine: tegra210-adma: Don't program FIFO threshold
Date:   Wed, 31 Jul 2019 11:16:39 +0100
Message-ID: <20190731101639.22755-1-jonathanh@nvidia.com>
X-Mailer: git-send-email 2.17.1
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1564568209; bh=Z/XxGbf8H23hxKmAimlpyBrKz/7kO6KG4JjNj5Maab8=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         X-NVConfidentiality:MIME-Version:Content-Type;
        b=hwIBXHwpIZBHB0MSk6Md2g7FvmIEWksEOX67Yzq0whffjJqx7Z90qH4XZf5xUcNlA
         qpxsXLY0Jvmr65uhkPZYMsRvdOIzDIW5XW8h1RrCE0yHiu1aRLlhn5c1umBmUqsoyr
         ZHeCFDU+WX9Xrq2vPnspXEXtBhKoe0uVoPAgvSUE4wuB1R0miO9M/yYCb4TFdh3PuE
         U0VO22Btbf3+xCiw9J2UkjUoZNr/7gF8+HRE3bdfJ1fGWs2WrKniT0WapINEsFHJ5Y
         Io/G8JLwbQ6wic6P14OmUONNNIWsbFukJJAbyBMB1aiB4uKyKb0QsRjwjUb1hI5KdQ
         i8Cy8BywbuQWw==
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

From: Jonathan Hunter <jonathanh@nvidia.com>

The Tegra210 ADMA supports two modes for transferring data to a FIFO
which are ...

1. Transfer data to/from the FIFO as soon as a single burst can be
   transferred.
2. Transfer data to/from the FIFO based upon FIFO thresholds, where
   the FIFO threshold is specified in terms on multiple bursts.

Currently, the ADMA driver programs the FIFO threshold values in the
FIFO_CTRL register, but never enables the transfer mode that uses
these threshold values. Given that these have never been used so far,
simplify the ADMA driver by removing the programming of these threshold
values.

Signed-off-by: Jonathan Hunter <jonathanh@nvidia.com>
Acked-by: Thierry Reding <treding@nvidia.com>
---
 drivers/dma/tegra210-adma.c | 12 ++----------
 1 file changed, 2 insertions(+), 10 deletions(-)

diff --git a/drivers/dma/tegra210-adma.c b/drivers/dma/tegra210-adma.c
index b33cf6e8ab8e..5f8adf5c1f20 100644
--- a/drivers/dma/tegra210-adma.c
+++ b/drivers/dma/tegra210-adma.c
@@ -42,12 +42,8 @@
 #define ADMA_CH_CONFIG_MAX_BUFS				8
 
 #define ADMA_CH_FIFO_CTRL				0x2c
-#define TEGRA210_ADMA_CH_FIFO_CTRL_OFLWTHRES(val)	(((val) & 0xf) << 24)
-#define TEGRA210_ADMA_CH_FIFO_CTRL_STRVTHRES(val)	(((val) & 0xf) << 16)
 #define TEGRA210_ADMA_CH_FIFO_CTRL_TXSIZE(val)		(((val) & 0xf) << 8)
 #define TEGRA210_ADMA_CH_FIFO_CTRL_RXSIZE(val)		((val) & 0xf)
-#define TEGRA186_ADMA_CH_FIFO_CTRL_OFLWTHRES(val)	(((val) & 0x1f) << 24)
-#define TEGRA186_ADMA_CH_FIFO_CTRL_STRVTHRES(val)	(((val) & 0x1f) << 16)
 #define TEGRA186_ADMA_CH_FIFO_CTRL_TXSIZE(val)		(((val) & 0x1f) << 8)
 #define TEGRA186_ADMA_CH_FIFO_CTRL_RXSIZE(val)		((val) & 0x1f)
 
@@ -64,14 +60,10 @@
 
 #define TEGRA_ADMA_BURST_COMPLETE_TIME			20
 
-#define TEGRA210_FIFO_CTRL_DEFAULT (TEGRA210_ADMA_CH_FIFO_CTRL_OFLWTHRES(1) | \
-				    TEGRA210_ADMA_CH_FIFO_CTRL_STRVTHRES(1) | \
-				    TEGRA210_ADMA_CH_FIFO_CTRL_TXSIZE(3)    | \
+#define TEGRA210_FIFO_CTRL_DEFAULT (TEGRA210_ADMA_CH_FIFO_CTRL_TXSIZE(3) | \
 				    TEGRA210_ADMA_CH_FIFO_CTRL_RXSIZE(3))
 
-#define TEGRA186_FIFO_CTRL_DEFAULT (TEGRA186_ADMA_CH_FIFO_CTRL_OFLWTHRES(1) | \
-				    TEGRA186_ADMA_CH_FIFO_CTRL_STRVTHRES(1) | \
-				    TEGRA186_ADMA_CH_FIFO_CTRL_TXSIZE(3)    | \
+#define TEGRA186_FIFO_CTRL_DEFAULT (TEGRA186_ADMA_CH_FIFO_CTRL_TXSIZE(3) | \
 				    TEGRA186_ADMA_CH_FIFO_CTRL_RXSIZE(3))
 
 #define ADMA_CH_REG_FIELD_VAL(val, mask, shift)	(((val) & mask) << shift)
-- 
2.17.1

