Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E84270552A
	for <lists+dmaengine@lfdr.de>; Tue, 16 May 2023 19:43:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229534AbjEPRnY (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 16 May 2023 13:43:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229533AbjEPRnX (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 16 May 2023 13:43:23 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10754FC
        for <dmaengine@vger.kernel.org>; Tue, 16 May 2023 10:43:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9747463702
        for <dmaengine@vger.kernel.org>; Tue, 16 May 2023 17:43:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A0F85C433D2;
        Tue, 16 May 2023 17:43:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684259002;
        bh=B7nu6savByPD5M2ysgnbtz4Gwiq6135teNm+8dkHIVA=;
        h=From:To:Cc:Subject:Date:From;
        b=a6gy9qLFSKp4Ef/Ae3tcmZqbITMQlVUYX4wm16nZkhuz0rzYl2ImMGtBcNN26B3w1
         NcVgGhR2o+C3jNNCM3otbcoPvkA4f3GPN7VgSwKgRXe0CnlYzcHEFpIUFb0oepXBsg
         0iGy/feqU2qtm9vAv6fg3N5GowQ1TGxWcT6SH1bVDLY6SE98Havoi050B6RAj7yWMt
         LG5AJE2g17qXCbgmjIY/evRkhihmoeXWQAAIkHMtaZ0GHgnImNgqcGo65Zmdw2urY7
         knpZLXE8XCporDT7m+MAn4TQGPt/DL7PhPtcmLUI9TFA+I3dggwOfajmq8AMXQuEkz
         lICZ5qiu3gXBA==
From:   Vinod Koul <vkoul@kernel.org>
To:     dmaengine@vger.kernel.org,
        Peter Ujfalusi <peter.ujfalusi@gmail.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Georgi Vlaev <g-vlaev@ti.com>
Cc:     Vinod Koul <vkoul@kernel.org>, Randy Dunlap <rdunlap@infradead.org>
Subject: [PATCH] dmaengine: ti: k3-udma: annotate pm function with __maybe_unused
Date:   Tue, 16 May 2023 23:13:11 +0530
Message-Id: <20230516174311.117264-1-vkoul@kernel.org>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

We get a warning when PM is not set:

../drivers/dma/ti/k3-udma.c:5552:12: warning: 'udma_pm_resume' defined but not used [-Wunused-function]
 5552 | static int udma_pm_resume(struct device *dev)
      |            ^~~~~~~~~~~~~~
../drivers/dma/ti/k3-udma.c:5530:12: warning: 'udma_pm_suspend' defined but not used [-Wunused-function]
 5530 | static int udma_pm_suspend(struct device *dev)
      |            ^~~~~~~~~~~~~~~

Fix this by annotating pm function with __maybe_unused

Fixes: fbe05149e40b ("dmaengine: ti: k3-udma: Add system suspend/resume support")
Reported-by: Randy Dunlap <rdunlap@infradead.org>
Signed-off-by: Vinod Koul <vkoul@kernel.org>
---
 drivers/dma/ti/k3-udma.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/dma/ti/k3-udma.c b/drivers/dma/ti/k3-udma.c
index fc3a2a05ab7b..b8329a23728d 100644
--- a/drivers/dma/ti/k3-udma.c
+++ b/drivers/dma/ti/k3-udma.c
@@ -5527,7 +5527,7 @@ static int udma_probe(struct platform_device *pdev)
 	return ret;
 }
 
-static int udma_pm_suspend(struct device *dev)
+static int __maybe_unused udma_pm_suspend(struct device *dev)
 {
 	struct udma_dev *ud = dev_get_drvdata(dev);
 	struct dma_device *dma_dev = &ud->ddev;
@@ -5549,7 +5549,7 @@ static int udma_pm_suspend(struct device *dev)
 	return 0;
 }
 
-static int udma_pm_resume(struct device *dev)
+static int __maybe_unused udma_pm_resume(struct device *dev)
 {
 	struct udma_dev *ud = dev_get_drvdata(dev);
 	struct dma_device *dma_dev = &ud->ddev;
-- 
2.40.1

