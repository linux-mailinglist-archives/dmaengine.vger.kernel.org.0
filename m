Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 95DE8602F9
	for <lists+dmaengine@lfdr.de>; Fri,  5 Jul 2019 11:16:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727383AbfGEJQC (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 5 Jul 2019 05:16:02 -0400
Received: from hqemgate15.nvidia.com ([216.228.121.64]:9843 "EHLO
        hqemgate15.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726116AbfGEJQC (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 5 Jul 2019 05:16:02 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate15.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5d1f15550001>; Fri, 05 Jul 2019 02:16:06 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Fri, 05 Jul 2019 02:16:01 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Fri, 05 Jul 2019 02:16:01 -0700
Received: from HQMAIL104.nvidia.com (172.18.146.11) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Fri, 5 Jul
 2019 09:16:01 +0000
Received: from hqnvemgw02.nvidia.com (172.16.227.111) by HQMAIL104.nvidia.com
 (172.18.146.11) with Microsoft SMTP Server (TLS) id 15.0.1473.3 via Frontend
 Transport; Fri, 5 Jul 2019 09:16:01 +0000
Received: from moonraker.nvidia.com (Not Verified[10.26.11.221]) by hqnvemgw02.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5d1f15500002>; Fri, 05 Jul 2019 02:16:01 -0700
From:   Jon Hunter <jonathanh@nvidia.com>
To:     Laxman Dewangan <ldewangan@nvidia.com>,
        Vinod Koul <vkoul@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>
CC:     <dmaengine@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
        Sameer Pujar <spujar@nvidia.com>,
        Jonathan Hunter <jonathanh@nvidia.com>
Subject: [RESEND PATCH] dmaengine: tegra210-adma: Don't program FIFO threshold
Date:   Fri, 5 Jul 2019 10:15:57 +0100
Message-ID: <20190705091557.726-1-jonathanh@nvidia.com>
X-Mailer: git-send-email 2.17.1
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1562318166; bh=jiguMpEBj30ZH+O4x/4BoXH1jweBXXuBplQDNP+ZChM=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         X-NVConfidentiality:MIME-Version:Content-Type;
        b=MIlGRls/tay6RGJh0NwBlVrQAPL9wgzw4bBFyCyXZGHRK04zpCccNhZIzlD7O63kv
         5scxknnikx29ipbJVC/ILwUJAdagWRzvGuVF4EpGENaVFyCiCUcMVA8RmUvLrc7RdI
         dGicy7kOETvv6sUaKiUcl+0uoawB7VfXUjRn2YKewFI0UYHdj7LR50cNXEkgpanSqG
         AQprjj+sM0bUnQUPep9XTEj1xivp98tDHojmnFrLv/ijTKbLeNdamgo1kO4QvDM85r
         Opc1RkxNgX3x+PhSSMOq+u9l4UBelOTxK4sCFuQrQgm6H2v4G+ZpYEQn+4HAq8iiYO
         5z3JWMUrAMxVg==
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

Resending the patch rebased on top next-20190704. I have added Thierry's
ACK as well.

 drivers/dma/tegra210-adma.c | 12 ++----------
 1 file changed, 2 insertions(+), 10 deletions(-)

diff --git a/drivers/dma/tegra210-adma.c b/drivers/dma/tegra210-adma.c
index 2805853e963f..d8646a49ba5b 100644
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

