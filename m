Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 653B11DE082
	for <lists+dmaengine@lfdr.de>; Fri, 22 May 2020 08:59:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728137AbgEVG6y (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 22 May 2020 02:58:54 -0400
Received: from aliyun-cloud.icoremail.net ([47.90.88.95]:22639 "HELO
        aliyun-sdnproxy-1.icoremail.net" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with SMTP id S1726578AbgEVG6y (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 22 May 2020 02:58:54 -0400
X-Greylist: delayed 349 seconds by postgrey-1.27 at vger.kernel.org; Fri, 22 May 2020 02:58:52 EDT
Received: from localhost.localdomain (unknown [222.205.77.158])
        by mail-app4 (Coremail) with SMTP id cS_KCgCHFAi8dsdeZVr9AQ--.53060S4;
        Fri, 22 May 2020 14:52:48 +0800 (CST)
From:   Dinghao Liu <dinghao.liu@zju.edu.cn>
To:     dinghao.liu@zju.edu.cn, kjlu@umn.edu
Cc:     Dan Williams <dan.j.williams@intel.com>,
        Vinod Koul <vkoul@kernel.org>,
        Orson Zhai <orsonzhai@gmail.com>,
        Baolin Wang <baolin.wang7@gmail.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] dmaengine: sprd: Fix runtime PM imbalance on error
Date:   Fri, 22 May 2020 14:52:43 +0800
Message-Id: <20200522065243.19590-1-dinghao.liu@zju.edu.cn>
X-Mailer: git-send-email 2.17.1
X-CM-TRANSID: cS_KCgCHFAi8dsdeZVr9AQ--.53060S4
X-Coremail-Antispam: 1UD129KBjvJXoWrKrW7ZFW3Gr18JF1xZFy5urg_yoW8JryDpa
        1UWa45urW0vayavryDAF18XF95Ca43t3y3WrWDG3y7ZrWrXFy0qr4rJFyjqF18XFykGF47
        J3WDJ3y5uF4fCr7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUva1xkIjI8I6I8E6xAIw20EY4v20xvaj40_Wr0E3s1l1IIY67AE
        w4v_Jr0_Jr4l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2
        IY67AKxVWDJVCq3wA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxVWxJr0_GcWl84ACjcxK6I8E
        87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_GcCE3s1le2I262IYc4CY6c
        8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jr0_
        Jr4lYx0Ex4A2jsIE14v26r4j6F4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x0EwI
        xGrwACjI8F5VA0II8E6IAqYI8I648v4I1lc2xSY4AK67AK6r47MxAIw28IcxkI7VAKI48J
        MxAIw28IcVCjz48v1sIEY20_GFWkJr1UJwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c
        02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_
        GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7
        CjxVAFwI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6rWUJVWrZr1UMIIF0xvEx4A2jsIE
        14v26r4j6F4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr1j6F4UJbIYCTnIWIevJa73UjIFyT
        uYvjfU1uc_DUUUU
X-CM-SenderInfo: qrrzjiaqtzq6lmxovvfxof0/1tbiAggIBlZdtOQP3QABsM
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

pm_runtime_get_sync() increments the runtime PM usage counter even
when it returns an error code. Thus a pairing decrement is needed on
the error handling path to keep the counter balanced.

Also, call pm_runtime_disable() when pm_runtime_get_sync() returns
an error code.

Signed-off-by: Dinghao Liu <dinghao.liu@zju.edu.cn>
---
 drivers/dma/sprd-dma.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/dma/sprd-dma.c b/drivers/dma/sprd-dma.c
index 0ef5ca81ba4d..275d83768d0d 100644
--- a/drivers/dma/sprd-dma.c
+++ b/drivers/dma/sprd-dma.c
@@ -1210,7 +1210,7 @@ static int sprd_dma_probe(struct platform_device *pdev)
 	ret = dma_async_device_register(&sdev->dma_dev);
 	if (ret < 0) {
 		dev_err(&pdev->dev, "register dma device failed:%d\n", ret);
-		goto err_register;
+		goto err_rpm;
 	}
 
 	sprd_dma_info.dma_cap = sdev->dma_dev.cap_mask;
@@ -1224,10 +1224,9 @@ static int sprd_dma_probe(struct platform_device *pdev)
 
 err_of_register:
 	dma_async_device_unregister(&sdev->dma_dev);
-err_register:
+err_rpm:
 	pm_runtime_put_noidle(&pdev->dev);
 	pm_runtime_disable(&pdev->dev);
-err_rpm:
 	sprd_dma_disable(sdev);
 	return ret;
 }
-- 
2.17.1

