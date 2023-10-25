Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 304727D6ADF
	for <lists+dmaengine@lfdr.de>; Wed, 25 Oct 2023 14:10:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233804AbjJYMKw (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 25 Oct 2023 08:10:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232666AbjJYMKv (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 25 Oct 2023 08:10:51 -0400
Received: from SHSQR01.spreadtrum.com (mx1.unisoc.com [222.66.158.135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A7B98F;
        Wed, 25 Oct 2023 05:10:43 -0700 (PDT)
Received: from dlp.unisoc.com ([10.29.3.86])
        by SHSQR01.spreadtrum.com with ESMTP id 39PCA9VF000805;
        Wed, 25 Oct 2023 20:10:09 +0800 (+08)
        (envelope-from Kaiwei.Liu@unisoc.com)
Received: from SHDLP.spreadtrum.com (shmbx07.spreadtrum.com [10.0.1.12])
        by dlp.unisoc.com (SkyGuard) with ESMTPS id 4SFngp65f4z2LYmVb;
        Wed, 25 Oct 2023 20:05:42 +0800 (CST)
Received: from xm9614pcu.spreadtrum.com (10.13.2.29) by shmbx07.spreadtrum.com
 (10.0.1.12) with Microsoft SMTP Server (TLS) id 15.0.1497.23; Wed, 25 Oct
 2023 20:10:08 +0800
From:   Kaiwei Liu <kaiwei.liu@unisoc.com>
To:     Vinod Koul <vkoul@kernel.org>, Orson Zhai <orsonzhai@gmail.com>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>
CC:     <dmaengine@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        kaiwei liu <liukaiwei086@gmail.com>,
        Wenming Wu <wenming.wu@unisoc.com>
Subject: [PATCH 1/3] dmaengine: sprd: support dma device suspend/resume
Date:   Wed, 25 Oct 2023 20:05:00 +0800
Message-ID: <20231025120500.8914-1-kaiwei.liu@unisoc.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.13.2.29]
X-ClientProxiedBy: SHCAS03.spreadtrum.com (10.0.1.207) To
 shmbx07.spreadtrum.com (10.0.1.12)
X-MAIL: SHSQR01.spreadtrum.com 39PCA9VF000805
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

From: "kaiwei.liu" <kaiwei.liu@unisoc.com>

The DMA doesn't support device suspend/resume before, now
some modules using DMA have add device suspend/resume which
may invalidate the DMA runtime suspend/reusume mechanism and
result in abnormal DMA suspend/resume. So here add relative
interface for DMA device suspend/resume.

Signed-off-by: kaiwei.liu <kaiwei.liu@unisoc.com>
---
 drivers/dma/sprd-dma.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/drivers/dma/sprd-dma.c b/drivers/dma/sprd-dma.c
index 08fcf1ec368c..0fa950dfa4f0 100644
--- a/drivers/dma/sprd-dma.c
+++ b/drivers/dma/sprd-dma.c
@@ -1291,10 +1291,30 @@ static int __maybe_unused sprd_dma_runtime_resume(struct device *dev)
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

