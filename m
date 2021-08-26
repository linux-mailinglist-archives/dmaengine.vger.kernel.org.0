Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B327B3F84C1
	for <lists+dmaengine@lfdr.de>; Thu, 26 Aug 2021 11:47:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240937AbhHZJsf (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 26 Aug 2021 05:48:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240935AbhHZJsc (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 26 Aug 2021 05:48:32 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D94EAC061796
        for <dmaengine@vger.kernel.org>; Thu, 26 Aug 2021 02:47:45 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mtr@pengutronix.de>)
        id 1mJBz5-0003c4-5T; Thu, 26 Aug 2021 11:47:43 +0200
Received: from [2a0a:edc0:0:1101:1d::39] (helo=dude03.red.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.92)
        (envelope-from <mtr@pengutronix.de>)
        id 1mJBz4-0006kt-98; Thu, 26 Aug 2021 11:47:42 +0200
Received: from mtr by dude03.red.stw.pengutronix.de with local (Exim 4.92)
        (envelope-from <mtr@pengutronix.de>)
        id 1mJBz4-005Siz-8B; Thu, 26 Aug 2021 11:47:42 +0200
From:   Michael Tretter <m.tretter@pengutronix.de>
To:     vkoul@kernel.org, dmaengine@vger.kernel.org
Cc:     linux-arm-kernel@lists.infradead.org, appana.durga.rao@xilinx.com,
        michal.simek@xilinx.com, m.tretter@pengutronix.de,
        kernel@pengutronix.de
Subject: [PATCH 2/7] dmaengine: zynqmp_dma: drop message on probe success
Date:   Thu, 26 Aug 2021 11:47:37 +0200
Message-Id: <20210826094742.1302009-3-m.tretter@pengutronix.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210826094742.1302009-1-m.tretter@pengutronix.de>
References: <20210826094742.1302009-1-m.tretter@pengutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mtr@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: dmaengine@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

There is no need to print a message that the ZynqMP DMA driver probed
successfully, since it carries no additional information. Drop the
message.

Signed-off-by: Michael Tretter <m.tretter@pengutronix.de>
---
 drivers/dma/xilinx/zynqmp_dma.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/dma/xilinx/zynqmp_dma.c b/drivers/dma/xilinx/zynqmp_dma.c
index 8423fbfc20c7..2a8938806b91 100644
--- a/drivers/dma/xilinx/zynqmp_dma.c
+++ b/drivers/dma/xilinx/zynqmp_dma.c
@@ -1104,8 +1104,6 @@ static int zynqmp_dma_probe(struct platform_device *pdev)
 	pm_runtime_mark_last_busy(zdev->dev);
 	pm_runtime_put_sync_autosuspend(zdev->dev);
 
-	dev_info(&pdev->dev, "ZynqMP DMA driver Probe success\n");
-
 	return 0;
 
 free_chan_resources:
-- 
2.30.2

