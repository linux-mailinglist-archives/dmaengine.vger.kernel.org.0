Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9E0A918C811
	for <lists+dmaengine@lfdr.de>; Fri, 20 Mar 2020 08:14:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726614AbgCTHOl (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 20 Mar 2020 03:14:41 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:12169 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725802AbgCTHOl (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Fri, 20 Mar 2020 03:14:41 -0400
Received: from DGGEMS404-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 2D561D47507366A7B8F7;
        Fri, 20 Mar 2020 15:14:32 +0800 (CST)
Received: from localhost (10.173.223.234) by DGGEMS404-HUB.china.huawei.com
 (10.3.19.204) with Microsoft SMTP Server id 14.3.487.0; Fri, 20 Mar 2020
 15:14:25 +0800
From:   YueHaibing <yuehaibing@huawei.com>
To:     <ldewangan@nvidia.com>, <jonathanh@nvidia.com>,
        <dan.j.williams@intel.com>, <vkoul@kernel.org>,
        <thierry.reding@gmail.com>, <swarren@wwwdotorg.org>
CC:     <dmaengine@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <digetx@gmail.com>,
        YueHaibing <yuehaibing@huawei.com>
Subject: [PATCH -next] dmaengine: tegra-apb: mark PM functions as __maybe_unused
Date:   Fri, 20 Mar 2020 15:13:37 +0800
Message-ID: <20200320071337.59756-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.10.2.windows.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.173.223.234]
X-CFilter-Loop: Reflected
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

When CONFIG_PM is disabled, gcc warning this:

drivers/dma/tegra20-apb-dma.c:1587:12: warning: 'tegra_dma_runtime_resume' defined but not used [-Wunused-function]
drivers/dma/tegra20-apb-dma.c:1578:12: warning: 'tegra_dma_runtime_suspend' defined but not used [-Wunused-function]

Make it as __maybe_unused to fix the warnings,
also remove unneeded function declarations.

Fixes: ec8a1586780c ("dma: tegra: add dmaengine based dma driver")
Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 drivers/dma/tegra20-apb-dma.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/dma/tegra20-apb-dma.c b/drivers/dma/tegra20-apb-dma.c
index 4e295d121be6..b33000976f66 100644
--- a/drivers/dma/tegra20-apb-dma.c
+++ b/drivers/dma/tegra20-apb-dma.c
@@ -263,8 +263,6 @@ static inline struct device *tdc2dev(struct tegra_dma_channel *tdc)
 }
 
 static dma_cookie_t tegra_dma_tx_submit(struct dma_async_tx_descriptor *tx);
-static int tegra_dma_runtime_suspend(struct device *dev);
-static int tegra_dma_runtime_resume(struct device *dev);
 
 /* Get DMA desc from free list, if not there then allocate it.  */
 static struct tegra_dma_desc *tegra_dma_desc_get(struct tegra_dma_channel *tdc)
@@ -1575,7 +1573,7 @@ static int tegra_dma_remove(struct platform_device *pdev)
 	return 0;
 }
 
-static int tegra_dma_runtime_suspend(struct device *dev)
+static int __maybe_unused tegra_dma_runtime_suspend(struct device *dev)
 {
 	struct tegra_dma *tdma = dev_get_drvdata(dev);
 
@@ -1584,7 +1582,7 @@ static int tegra_dma_runtime_suspend(struct device *dev)
 	return 0;
 }
 
-static int tegra_dma_runtime_resume(struct device *dev)
+static int __maybe_unused tegra_dma_runtime_resume(struct device *dev)
 {
 	struct tegra_dma *tdma = dev_get_drvdata(dev);
 
-- 
2.17.1


