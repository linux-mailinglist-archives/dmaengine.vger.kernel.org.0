Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6B5DE3AAEA2
	for <lists+dmaengine@lfdr.de>; Thu, 17 Jun 2021 10:21:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230039AbhFQIXb (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 17 Jun 2021 04:23:31 -0400
Received: from szxga03-in.huawei.com ([45.249.212.189]:7347 "EHLO
        szxga03-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229842AbhFQIXb (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 17 Jun 2021 04:23:31 -0400
Received: from dggemv711-chm.china.huawei.com (unknown [172.30.72.53])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4G5FKF2wzYz6vxm;
        Thu, 17 Jun 2021 16:17:21 +0800 (CST)
Received: from dggpemm500006.china.huawei.com (7.185.36.236) by
 dggemv711-chm.china.huawei.com (10.1.198.66) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Thu, 17 Jun 2021 16:21:21 +0800
Received: from thunder-town.china.huawei.com (10.174.179.0) by
 dggpemm500006.china.huawei.com (7.185.36.236) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Thu, 17 Jun 2021 16:21:21 +0800
From:   Zhen Lei <thunder.leizhen@huawei.com>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Vinod Koul <vkoul@kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        dmaengine <dmaengine@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
CC:     Zhen Lei <thunder.leizhen@huawei.com>
Subject: [PATCH 1/1] dmaengine: qcom: Fix possible memory leak
Date:   Thu, 17 Jun 2021 16:20:58 +0800
Message-ID: <20210617082058.955-1-thunder.leizhen@huawei.com>
X-Mailer: git-send-email 2.26.0.windows.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.174.179.0]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggpemm500006.china.huawei.com (7.185.36.236)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

When krealloc() fails to expand the memory and returns NULL, the original
memory is not released. In addition, subsequent memcpy() operation will
overwrite the entire valid memory space, so using krealloc() to preserve
the old content is not necessary.

Change to release the old memory and then apply for new memory.

Fixes: 5d0c3533a19f ("dmaengine: qcom: Add GPI dma driver")
Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
---
 drivers/dma/qcom/gpi.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/dma/qcom/gpi.c b/drivers/dma/qcom/gpi.c
index 43ac3ab23d4c..e24fe64f3b63 100644
--- a/drivers/dma/qcom/gpi.c
+++ b/drivers/dma/qcom/gpi.c
@@ -1625,7 +1625,8 @@ gpi_peripheral_config(struct dma_chan *chan, struct dma_slave_config *config)
 	if (!config->peripheral_config)
 		return -EINVAL;
 
-	gchan->config = krealloc(gchan->config, config->peripheral_size, GFP_NOWAIT);
+	kfree(gchan->config);
+	gchan->config = kmalloc(config->peripheral_size, GFP_NOWAIT);
 	if (!gchan->config)
 		return -ENOMEM;
 
-- 
2.25.1


