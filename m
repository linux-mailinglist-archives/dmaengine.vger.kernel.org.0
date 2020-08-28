Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2B9A7255DD0
	for <lists+dmaengine@lfdr.de>; Fri, 28 Aug 2020 17:27:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728236AbgH1P05 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 28 Aug 2020 11:26:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:37800 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728204AbgH1P0v (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Fri, 28 Aug 2020 11:26:51 -0400
Received: from kozik-lap.mshome.net (unknown [194.230.155.216])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 58223208D5;
        Fri, 28 Aug 2020 15:26:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598628411;
        bh=24sRIQKF90KGrD04GnXmBdm+l+GRCZb8x1J9A9FTPeM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=jKrormv2PQjSm9o8tVds65EgrQucz2shYLT66nj51TKUuwiPpsLW0VKYWYP51XrAp
         bGqKIcVfGm5mJ8YD6y46HGXEzgyV25eiiFwG6Y4hvRcIctqvHJ1RW1iY7Y+pyr591J
         SMCbRcCe1VsXP0c1oiOU2WSMc15wnNsgcyqMa4y0=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Vinod Koul <vkoul@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        Michal Simek <michal.simek@xilinx.com>,
        Radhey Shyam Pandey <radhey.shyam.pandey@xilinx.com>,
        Nicholas Graumann <nick.graumann@gmail.com>,
        dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org
Cc:     Krzysztof Kozlowski <krzk@kernel.org>
Subject: [PATCH 3/3] dmaengine: xilinx: Simplify with dev_err_probe()
Date:   Fri, 28 Aug 2020 17:26:37 +0200
Message-Id: <20200828152637.16903-3-krzk@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200828152637.16903-1-krzk@kernel.org>
References: <20200828152637.16903-1-krzk@kernel.org>
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Common pattern of handling deferred probe can be simplified with
dev_err_probe().  Less code and the error value gets printed.

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 drivers/dma/xilinx/xilinx_dma.c | 36 ++++++++-------------------------
 1 file changed, 8 insertions(+), 28 deletions(-)

diff --git a/drivers/dma/xilinx/xilinx_dma.c b/drivers/dma/xilinx/xilinx_dma.c
index 5429497d3560..286cf94a950d 100644
--- a/drivers/dma/xilinx/xilinx_dma.c
+++ b/drivers/dma/xilinx/xilinx_dma.c
@@ -2536,13 +2536,8 @@ static int axidma_clk_init(struct platform_device *pdev, struct clk **axi_clk,
 	*tmp_clk = NULL;
 
 	*axi_clk = devm_clk_get(&pdev->dev, "s_axi_lite_aclk");
-	if (IS_ERR(*axi_clk)) {
-		err = PTR_ERR(*axi_clk);
-		if (err != -EPROBE_DEFER)
-			dev_err(&pdev->dev, "failed to get axi_aclk (%d)\n",
-				err);
-		return err;
-	}
+	if (IS_ERR(*axi_clk))
+		return dev_err_probe(&pdev->dev, PTR_ERR(*axi_clk), "failed to get axi_aclk\n");
 
 	*tx_clk = devm_clk_get(&pdev->dev, "m_axi_mm2s_aclk");
 	if (IS_ERR(*tx_clk))
@@ -2603,22 +2598,12 @@ static int axicdma_clk_init(struct platform_device *pdev, struct clk **axi_clk,
 	*tmp2_clk = NULL;
 
 	*axi_clk = devm_clk_get(&pdev->dev, "s_axi_lite_aclk");
-	if (IS_ERR(*axi_clk)) {
-		err = PTR_ERR(*axi_clk);
-		if (err != -EPROBE_DEFER)
-			dev_err(&pdev->dev, "failed to get axi_clk (%d)\n",
-				err);
-		return err;
-	}
+	if (IS_ERR(*axi_clk))
+		return dev_err_probe(&pdev->dev, PTR_ERR(*axi_clk), "failed to get axi_aclk\n");
 
 	*dev_clk = devm_clk_get(&pdev->dev, "m_axi_aclk");
-	if (IS_ERR(*dev_clk)) {
-		err = PTR_ERR(*dev_clk);
-		if (err != -EPROBE_DEFER)
-			dev_err(&pdev->dev, "failed to get dev_clk (%d)\n",
-				err);
-		return err;
-	}
+	if (IS_ERR(*dev_clk))
+		return dev_err_probe(&pdev->dev, PTR_ERR(*dev_clk), "failed to get dev_clk\n");
 
 	err = clk_prepare_enable(*axi_clk);
 	if (err) {
@@ -2647,13 +2632,8 @@ static int axivdma_clk_init(struct platform_device *pdev, struct clk **axi_clk,
 	int err;
 
 	*axi_clk = devm_clk_get(&pdev->dev, "s_axi_lite_aclk");
-	if (IS_ERR(*axi_clk)) {
-		err = PTR_ERR(*axi_clk);
-		if (err != -EPROBE_DEFER)
-			dev_err(&pdev->dev, "failed to get axi_aclk (%d)\n",
-				err);
-		return err;
-	}
+	if (IS_ERR(*axi_clk))
+		return dev_err_probe(&pdev->dev, PTR_ERR(*axi_clk), "failed to get axi_aclk\n");
 
 	*tx_clk = devm_clk_get(&pdev->dev, "m_axi_mm2s_aclk");
 	if (IS_ERR(*tx_clk))
-- 
2.17.1

