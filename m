Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6304526EC8F
	for <lists+dmaengine@lfdr.de>; Fri, 18 Sep 2020 04:15:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728848AbgIRCM4 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 17 Sep 2020 22:12:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:39660 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728382AbgIRCMz (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Thu, 17 Sep 2020 22:12:55 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A20252388D;
        Fri, 18 Sep 2020 02:12:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600395174;
        bh=+bQuNrwBC+2CCwgy9Vn+XlWdoQkontIttZ1dYvINHiU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=n2+3s9oPL7ZzWKUt5a8q//Q1tNZfCplvPCZX+AkGS1+GIVCXDduJCp4Aw9nEVoGUI
         zpprunLXscb8NNJzSa7bj7DC8syUfll36lk5B2cEAtKARbMvEAV3rPHUhFb+O1EIve
         nlpyhzsUhHEBbAyylF7KvbupnL3iw6HtiuTpvoAM=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Matthias Fend <matthias.fend@wolfvision.net>,
        Vinod Koul <vkoul@kernel.org>, Sasha Levin <sashal@kernel.org>,
        dmaengine@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: [PATCH AUTOSEL 4.14 030/127] dmaengine: zynqmp_dma: fix burst length configuration
Date:   Thu, 17 Sep 2020 22:10:43 -0400
Message-Id: <20200918021220.2066485-30-sashal@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200918021220.2066485-1-sashal@kernel.org>
References: <20200918021220.2066485-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

From: Matthias Fend <matthias.fend@wolfvision.net>

[ Upstream commit cc88525ebffc757e00cc5a5d61da6271646c7f5f ]

Since the dma engine expects the burst length register content as
power of 2 value, the burst length needs to be converted first.
Additionally add a burst length range check to avoid corrupting unrelated
register bits.

Signed-off-by: Matthias Fend <matthias.fend@wolfvision.net>
Link: https://lore.kernel.org/r/20200115102249.24398-1-matthias.fend@wolfvision.net
Signed-off-by: Vinod Koul <vkoul@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/dma/xilinx/zynqmp_dma.c | 24 +++++++++++++++---------
 1 file changed, 15 insertions(+), 9 deletions(-)

diff --git a/drivers/dma/xilinx/zynqmp_dma.c b/drivers/dma/xilinx/zynqmp_dma.c
index 6d86d05e53aa1..66d6640766ed8 100644
--- a/drivers/dma/xilinx/zynqmp_dma.c
+++ b/drivers/dma/xilinx/zynqmp_dma.c
@@ -125,10 +125,12 @@
 /* Max transfer size per descriptor */
 #define ZYNQMP_DMA_MAX_TRANS_LEN	0x40000000
 
+/* Max burst lengths */
+#define ZYNQMP_DMA_MAX_DST_BURST_LEN    32768U
+#define ZYNQMP_DMA_MAX_SRC_BURST_LEN    32768U
+
 /* Reset values for data attributes */
 #define ZYNQMP_DMA_AXCACHE_VAL		0xF
-#define ZYNQMP_DMA_ARLEN_RST_VAL	0xF
-#define ZYNQMP_DMA_AWLEN_RST_VAL	0xF
 
 #define ZYNQMP_DMA_SRC_ISSUE_RST_VAL	0x1F
 
@@ -527,17 +529,19 @@ static void zynqmp_dma_handle_ovfl_int(struct zynqmp_dma_chan *chan, u32 status)
 
 static void zynqmp_dma_config(struct zynqmp_dma_chan *chan)
 {
-	u32 val;
+	u32 val, burst_val;
 
 	val = readl(chan->regs + ZYNQMP_DMA_CTRL0);
 	val |= ZYNQMP_DMA_POINT_TYPE_SG;
 	writel(val, chan->regs + ZYNQMP_DMA_CTRL0);
 
 	val = readl(chan->regs + ZYNQMP_DMA_DATA_ATTR);
+	burst_val = __ilog2_u32(chan->src_burst_len);
 	val = (val & ~ZYNQMP_DMA_ARLEN) |
-		(chan->src_burst_len << ZYNQMP_DMA_ARLEN_OFST);
+		((burst_val << ZYNQMP_DMA_ARLEN_OFST) & ZYNQMP_DMA_ARLEN);
+	burst_val = __ilog2_u32(chan->dst_burst_len);
 	val = (val & ~ZYNQMP_DMA_AWLEN) |
-		(chan->dst_burst_len << ZYNQMP_DMA_AWLEN_OFST);
+		((burst_val << ZYNQMP_DMA_AWLEN_OFST) & ZYNQMP_DMA_AWLEN);
 	writel(val, chan->regs + ZYNQMP_DMA_DATA_ATTR);
 }
 
@@ -551,8 +555,10 @@ static int zynqmp_dma_device_config(struct dma_chan *dchan,
 {
 	struct zynqmp_dma_chan *chan = to_chan(dchan);
 
-	chan->src_burst_len = config->src_maxburst;
-	chan->dst_burst_len = config->dst_maxburst;
+	chan->src_burst_len = clamp(config->src_maxburst, 1U,
+		ZYNQMP_DMA_MAX_SRC_BURST_LEN);
+	chan->dst_burst_len = clamp(config->dst_maxburst, 1U,
+		ZYNQMP_DMA_MAX_DST_BURST_LEN);
 
 	return 0;
 }
@@ -873,8 +879,8 @@ static int zynqmp_dma_chan_probe(struct zynqmp_dma_device *zdev,
 		return PTR_ERR(chan->regs);
 
 	chan->bus_width = ZYNQMP_DMA_BUS_WIDTH_64;
-	chan->dst_burst_len = ZYNQMP_DMA_AWLEN_RST_VAL;
-	chan->src_burst_len = ZYNQMP_DMA_ARLEN_RST_VAL;
+	chan->dst_burst_len = ZYNQMP_DMA_MAX_DST_BURST_LEN;
+	chan->src_burst_len = ZYNQMP_DMA_MAX_SRC_BURST_LEN;
 	err = of_property_read_u32(node, "xlnx,bus-width", &chan->bus_width);
 	if (err < 0) {
 		dev_err(&pdev->dev, "missing xlnx,bus-width property\n");
-- 
2.25.1

