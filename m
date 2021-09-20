Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 235DC41118C
	for <lists+dmaengine@lfdr.de>; Mon, 20 Sep 2021 11:06:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234961AbhITJHS (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 20 Sep 2021 05:07:18 -0400
Received: from www.zeus03.de ([194.117.254.33]:54174 "EHLO mail.zeus03.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236080AbhITJHI (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Mon, 20 Sep 2021 05:07:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple; d=sang-engineering.com; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=k1; bh=v+d2EKH5Hm5rpn
        klW0GzaZ84yipAYJED4MgP1hNorRw=; b=ENT1r8KQ+FnFXriV0P7EoLlZR5qLmH
        4EOYIViXe50IwSpt8xAZqjd/BTaHNLa2HBMyuczSsS5CrB6fR6SgiWtgbCpPPdDe
        uLB7SYVDrfMhxPNElI7Oa7CoAH33R8I5BsLwrEVeKLJ8MbAxrAMpg0g4p8wUekPo
        1Q2x9yeDyWprg=
Received: (qmail 2412559 invoked from network); 20 Sep 2021 11:05:23 +0200
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 20 Sep 2021 11:05:23 +0200
X-UD-Smtp-Session: l3s3148p1@z9vIlGnMCIsgAwDPXwlxANIWpbLKE1Uh
From:   Wolfram Sang <wsa+renesas@sang-engineering.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-renesas-soc@vger.kernel.org,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Vinod Koul <vkoul@kernel.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        dmaengine@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH 1/9] dmaengine: stm32-dmamux: simplify getting .driver_data
Date:   Mon, 20 Sep 2021 11:05:13 +0200
Message-Id: <20210920090522.23784-2-wsa+renesas@sang-engineering.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210920090522.23784-1-wsa+renesas@sang-engineering.com>
References: <20210920090522.23784-1-wsa+renesas@sang-engineering.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

We should get 'driver_data' from 'struct device' directly. Going via
platform_device is an unneeded step back and forth.

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---

Build tested only. buildbot is happy.

 drivers/dma/stm32-dmamux.c | 14 +++++---------
 1 file changed, 5 insertions(+), 9 deletions(-)

diff --git a/drivers/dma/stm32-dmamux.c b/drivers/dma/stm32-dmamux.c
index a42164389ebc..175f06749df6 100644
--- a/drivers/dma/stm32-dmamux.c
+++ b/drivers/dma/stm32-dmamux.c
@@ -305,8 +305,7 @@ static int stm32_dmamux_probe(struct platform_device *pdev)
 #ifdef CONFIG_PM
 static int stm32_dmamux_runtime_suspend(struct device *dev)
 {
-	struct platform_device *pdev = to_platform_device(dev);
-	struct stm32_dmamux_data *stm32_dmamux = platform_get_drvdata(pdev);
+	struct stm32_dmamux_data *stm32_dmamux = dev_get_drvdata(dev);
 
 	clk_disable_unprepare(stm32_dmamux->clk);
 
@@ -315,13 +314,12 @@ static int stm32_dmamux_runtime_suspend(struct device *dev)
 
 static int stm32_dmamux_runtime_resume(struct device *dev)
 {
-	struct platform_device *pdev = to_platform_device(dev);
-	struct stm32_dmamux_data *stm32_dmamux = platform_get_drvdata(pdev);
+	struct stm32_dmamux_data *stm32_dmamux = dev_get_drvdata(dev);
 	int ret;
 
 	ret = clk_prepare_enable(stm32_dmamux->clk);
 	if (ret) {
-		dev_err(&pdev->dev, "failed to prepare_enable clock\n");
+		dev_err(dev, "failed to prepare_enable clock\n");
 		return ret;
 	}
 
@@ -332,8 +330,7 @@ static int stm32_dmamux_runtime_resume(struct device *dev)
 #ifdef CONFIG_PM_SLEEP
 static int stm32_dmamux_suspend(struct device *dev)
 {
-	struct platform_device *pdev = to_platform_device(dev);
-	struct stm32_dmamux_data *stm32_dmamux = platform_get_drvdata(pdev);
+	struct stm32_dmamux_data *stm32_dmamux = dev_get_drvdata(dev);
 	int i, ret;
 
 	ret = pm_runtime_resume_and_get(dev);
@@ -353,8 +350,7 @@ static int stm32_dmamux_suspend(struct device *dev)
 
 static int stm32_dmamux_resume(struct device *dev)
 {
-	struct platform_device *pdev = to_platform_device(dev);
-	struct stm32_dmamux_data *stm32_dmamux = platform_get_drvdata(pdev);
+	struct stm32_dmamux_data *stm32_dmamux = dev_get_drvdata(dev);
 	int i, ret;
 
 	ret = pm_runtime_force_resume(dev);
-- 
2.30.2

