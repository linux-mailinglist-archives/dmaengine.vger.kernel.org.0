Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C3B8771957
	for <lists+dmaengine@lfdr.de>; Mon,  7 Aug 2023 07:21:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229487AbjHGFVb (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 7 Aug 2023 01:21:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229590AbjHGFVb (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 7 Aug 2023 01:21:31 -0400
Received: from SHSQR01.spreadtrum.com (unknown [222.66.158.135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9CDE171E;
        Sun,  6 Aug 2023 22:21:27 -0700 (PDT)
Received: from dlp.unisoc.com ([10.29.3.86])
        by SHSQR01.spreadtrum.com with ESMTP id 3775L0LD022298;
        Mon, 7 Aug 2023 13:21:00 +0800 (+08)
        (envelope-from Kaiwei.Liu@unisoc.com)
Received: from SHDLP.spreadtrum.com (shmbx07.spreadtrum.com [10.0.1.12])
        by dlp.unisoc.com (SkyGuard) with ESMTPS id 4RK4P854KHz2K1r9q;
        Mon,  7 Aug 2023 13:19:08 +0800 (CST)
Received: from xm9614pcu.spreadtrum.com (10.13.2.29) by shmbx07.spreadtrum.com
 (10.0.1.12) with Microsoft SMTP Server (TLS) id 15.0.1497.23; Mon, 7 Aug 2023
 13:20:58 +0800
From:   Kaiwei Liu <kaiwei.liu@unisoc.com>
To:     Vinod Koul <vkoul@kernel.org>, Orson Zhai <orsonzhai@gmail.com>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>
CC:     <dmaengine@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        kaiwei liu <liukaiwei086@gmail.com>,
        Wenming Wu <wenming.wu@unisoc.com>
Subject: [PATCH 5/5] dma: add relative interface to support deep sleep
Date:   Mon, 7 Aug 2023 13:20:56 +0800
Message-ID: <20230807052056.2963-1-kaiwei.liu@unisoc.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.13.2.29]
X-ClientProxiedBy: SHCAS03.spreadtrum.com (10.0.1.207) To
 shmbx07.spreadtrum.com (10.0.1.12)
X-MAIL: SHSQR01.spreadtrum.com 3775L0LD022298
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

The DMA doesn't support deep sleep before, here add
relative interface in deep sleep framework.

Signed-off-by: Kaiwei Liu <kaiwei.liu@unisoc.com>
---
 drivers/dma/sprd-dma.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/drivers/dma/sprd-dma.c b/drivers/dma/sprd-dma.c
index 41d427df5098..b1dbbc5f4e70 100644
--- a/drivers/dma/sprd-dma.c
+++ b/drivers/dma/sprd-dma.c
@@ -1339,10 +1339,30 @@ static int __maybe_unused sprd_dma_runtime_resume(struct device *dev)
 	return ret;
 }
 
+static int sprd_dma_suspend_noirq(struct device *dev)
+{
+	if ((pm_runtime_status_suspended(dev)) ||
+	    (atomic_read(&(dev->power.usage_count)) > 1))
+		return 0;
+
+	return sprd_dma_runtime_suspend(dev);
+}
+
+static int sprd_dma_resume_early(struct device *dev)
+{
+	if ((pm_runtime_status_suspended(dev)) ||
+	    (atomic_read(&(dev->power.usage_count)) > 1))
+		return 0;
+
+	return sprd_dma_runtime_resume(dev);
+}
+
 static const struct dev_pm_ops sprd_dma_pm_ops = {
 	SET_RUNTIME_PM_OPS(sprd_dma_runtime_suspend,
 			   sprd_dma_runtime_resume,
 			   NULL)
+	SET_NOIRQ_SYSTEM_SLEEP_PM_OPS(sprd_dma_suspend_noirq,
+				      sprd_dma_resume_early)
 };
 
 static struct platform_driver sprd_dma_driver = {
-- 
2.17.1

