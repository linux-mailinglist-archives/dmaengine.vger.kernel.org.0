Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D96CE4C8B2
	for <lists+dmaengine@lfdr.de>; Thu, 20 Jun 2019 09:54:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725953AbfFTHye (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 20 Jun 2019 03:54:34 -0400
Received: from hqemgate16.nvidia.com ([216.228.121.65]:17944 "EHLO
        hqemgate16.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725912AbfFTHyd (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 20 Jun 2019 03:54:33 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate16.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5d0b3bb80001>; Thu, 20 Jun 2019 00:54:32 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Thu, 20 Jun 2019 00:54:32 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Thu, 20 Jun 2019 00:54:32 -0700
Received: from HQMAIL111.nvidia.com (172.20.187.18) by HQMAIL108.nvidia.com
 (172.18.146.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Thu, 20 Jun
 2019 07:54:32 +0000
Received: from HQMAIL106.nvidia.com (172.18.146.12) by HQMAIL111.nvidia.com
 (172.20.187.18) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Thu, 20 Jun
 2019 07:54:32 +0000
Received: from hqnvemgw01.nvidia.com (172.20.150.20) by HQMAIL106.nvidia.com
 (172.18.146.12) with Microsoft SMTP Server (TLS) id 15.0.1473.3 via Frontend
 Transport; Thu, 20 Jun 2019 07:54:32 +0000
Received: from moonraker.nvidia.com (Not Verified[10.21.132.148]) by hqnvemgw01.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5d0b3bb60001>; Thu, 20 Jun 2019 00:54:31 -0700
From:   Jon Hunter <jonathanh@nvidia.com>
To:     Laxman Dewangan <ldewangan@nvidia.com>,
        Vinod Koul <vkoul@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>
CC:     <dmaengine@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
        Sameer Pujar <spujar@nvidia.com>,
        Jonathan Hunter <jonathanh@nvidia.com>
Subject: [PATCH] dmaengine: tegra210-adma: Don't program FIFO threshold
Date:   Thu, 20 Jun 2019 08:54:24 +0100
Message-ID: <20190620075424.14795-1-jonathanh@nvidia.com>
X-Mailer: git-send-email 2.17.1
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1561017272; bh=nX2lBw9O+l1b+Konix9NLyufXp4wIM5FCYsggZnn+sM=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         X-NVConfidentiality:MIME-Version:Content-Type;
        b=blkBkj9GbxwMWDFJ6UjTqSbDpm5OWCVMc9FPQvxycD7vpP5Ik+L8SI7AkaiWWi1Ji
         kMs+xYvdeQ1a4oGYjcCPWWoWWQjOOREMhu4YFzK5SUV9yv68bV28/ZWpCJC6uTZfYt
         PJ3rWjy48yLwr28vaDVJE0pXdyWAVTfWdStuGVnjGrgIA/pqdC/8XH5grzDglGl1DS
         X1NljxWhZ+iFkSFdTHa6VogHabPasHevMFWarhGYFDwYFpl+l8Zwgc0/KvytL1NcFO
         xsXl51r+OLptrgnEa8bH/oJAhAwPJfMICwz6rsRu8wYfyx0TM7TkPgNjJ8XI9fnfjk
         PMUJ1WZfouvvQ==
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
---
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

