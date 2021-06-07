Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0E6B439D4F3
	for <lists+dmaengine@lfdr.de>; Mon,  7 Jun 2021 08:32:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229498AbhFGGeh (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 7 Jun 2021 02:34:37 -0400
Received: from szxga03-in.huawei.com ([45.249.212.189]:4373 "EHLO
        szxga03-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230128AbhFGGeh (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 7 Jun 2021 02:34:37 -0400
Received: from dggemv703-chm.china.huawei.com (unknown [172.30.72.55])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4Fz3Nl3KJbz69P9;
        Mon,  7 Jun 2021 14:28:55 +0800 (CST)
Received: from dggema755-chm.china.huawei.com (10.1.198.197) by
 dggemv703-chm.china.huawei.com (10.3.19.46) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.1.2176.2; Mon, 7 Jun 2021 14:32:43 +0800
Received: from huawei.com (10.90.53.225) by dggema755-chm.china.huawei.com
 (10.1.198.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2; Mon, 7 Jun
 2021 14:32:43 +0800
From:   Zhang Qilong <zhangqilong3@huawei.com>
To:     <vkoul@kernel.org>, <mcoquelin.stm32@gmail.com>,
        <alexandre.torgue@foss.st.com>, <pierre-yves.mordret@st.com>
CC:     <amelie.delaunay@st.com>, <dmaengine@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>
Subject: [PATCH -next 3/3] dmaengine: tegra210-adma: Using pm_runtime_resume_and_get to replace open coding
Date:   Mon, 7 Jun 2021 14:46:40 +0800
Message-ID: <20210607064640.121394-4-zhangqilong3@huawei.com>
X-Mailer: git-send-email 2.26.0.106.g9fadedd
In-Reply-To: <20210607064640.121394-1-zhangqilong3@huawei.com>
References: <20210607064640.121394-1-zhangqilong3@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.90.53.225]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggema755-chm.china.huawei.com (10.1.198.197)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

use pm_runtime_resume_and_get() to replace pm_runtime_get_sync and
pm_runtime_put_noidle. this change is just to simplify the code,
there is no actual functional change.

Signed-off-by: Zhang Qilong <zhangqilong3@huawei.com>
---
 drivers/dma/tegra210-adma.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/dma/tegra210-adma.c b/drivers/dma/tegra210-adma.c
index 4735742e826d..b1115a6d1935 100644
--- a/drivers/dma/tegra210-adma.c
+++ b/drivers/dma/tegra210-adma.c
@@ -655,9 +655,8 @@ static int tegra_adma_alloc_chan_resources(struct dma_chan *dc)
 		return ret;
 	}
 
-	ret = pm_runtime_get_sync(tdc2dev(tdc));
+	ret = pm_runtime_resume_and_get(tdc2dev(tdc));
 	if (ret < 0) {
-		pm_runtime_put_noidle(tdc2dev(tdc));
 		free_irq(tdc->irq, tdc);
 		return ret;
 	}
@@ -869,10 +868,8 @@ static int tegra_adma_probe(struct platform_device *pdev)
 	pm_runtime_enable(&pdev->dev);
 
 	ret = pm_runtime_get_sync(&pdev->dev);
-	if (ret < 0) {
-		pm_runtime_put_noidle(&pdev->dev);
+	if (ret < 0)
 		goto rpm_disable;
-	}
 
 	ret = tegra_adma_init(tdma);
 	if (ret)
-- 
2.31.1

