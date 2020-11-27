Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CB7E52C61F7
	for <lists+dmaengine@lfdr.de>; Fri, 27 Nov 2020 10:41:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729107AbgK0JlS (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 27 Nov 2020 04:41:18 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:8131 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728056AbgK0JlS (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 27 Nov 2020 04:41:18 -0500
Received: from DGGEMS402-HUB.china.huawei.com (unknown [172.30.72.58])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4Cj8ks6T81z15TQ7;
        Fri, 27 Nov 2020 17:40:53 +0800 (CST)
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 DGGEMS402-HUB.china.huawei.com (10.3.19.202) with Microsoft SMTP Server id
 14.3.487.0; Fri, 27 Nov 2020 17:41:09 +0800
From:   Qinglang Miao <miaoqinglang@huawei.com>
To:     Vinod Koul <vkoul@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>
CC:     <dmaengine@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Qinglang Miao <miaoqinglang@huawei.com>
Subject: [PATCH 1/3] dmaengine: stm32-dma: fix reference leak in stm32_dma
Date:   Fri, 27 Nov 2020 17:45:23 +0800
Message-ID: <20201127094525.121388-2-miaoqinglang@huawei.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20201127094525.121388-1-miaoqinglang@huawei.com>
References: <20201127094525.121388-1-miaoqinglang@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.113.25]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

pm_runtime_get_sync will increment pm usage counter even it
failed. Forgetting to putting operation will result in a
reference leak here.

A new function pm_runtime_resume_and_get is introduced in
[0] to keep usage counter balanced. So We fix the reference
leak by replacing it with new funtion.

[0] dd8088d5a896 ("PM: runtime: Add  pm_runtime_resume_and_get to deal with usage counter")

Fixes: 05f8740a0e6f ("dmaengine: stm32-dma: add suspend/resume power management support")
Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: Qinglang Miao <miaoqinglang@huawei.com>
---
 drivers/dma/stm32-dma.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/dma/stm32-dma.c b/drivers/dma/stm32-dma.c
index d0055d2f0..1150aa90e 100644
--- a/drivers/dma/stm32-dma.c
+++ b/drivers/dma/stm32-dma.c
@@ -1187,7 +1187,7 @@ static int stm32_dma_alloc_chan_resources(struct dma_chan *c)
 
 	chan->config_init = false;
 
-	ret = pm_runtime_get_sync(dmadev->ddev.dev);
+	ret = pm_runtime_resume_and_get(dmadev->ddev.dev);
 	if (ret < 0)
 		return ret;
 
@@ -1455,7 +1455,7 @@ static int stm32_dma_suspend(struct device *dev)
 	struct stm32_dma_device *dmadev = dev_get_drvdata(dev);
 	int id, ret, scr;
 
-	ret = pm_runtime_get_sync(dev);
+	ret = pm_runtime_resume_and_get(dev);
 	if (ret < 0)
 		return ret;
 
-- 
2.23.0

