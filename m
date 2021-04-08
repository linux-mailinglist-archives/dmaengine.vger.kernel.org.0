Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EE373357D0C
	for <lists+dmaengine@lfdr.de>; Thu,  8 Apr 2021 09:12:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229552AbhDHHMV (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 8 Apr 2021 03:12:21 -0400
Received: from mail.zju.edu.cn ([61.164.42.155]:24494 "EHLO zju.edu.cn"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229517AbhDHHMU (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Thu, 8 Apr 2021 03:12:20 -0400
Received: from localhost.localdomain (unknown [10.192.24.118])
        by mail-app2 (Coremail) with SMTP id by_KCgC3v2++rG5g+g7dAA--.48532S4;
        Thu, 08 Apr 2021 15:12:01 +0800 (CST)
From:   Dinghao Liu <dinghao.liu@zju.edu.cn>
To:     dinghao.liu@zju.edu.cn, kjlu@umn.edu
Cc:     Laxman Dewangan <ldewangan@nvidia.com>,
        Jon Hunter <jonathanh@nvidia.com>,
        Vinod Koul <vkoul@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        dmaengine@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] dmaengine: tegra20: Fix runtime PM imbalance in tegra_dma_issue_pending
Date:   Thu,  8 Apr 2021 15:11:57 +0800
Message-Id: <20210408071158.12565-1-dinghao.liu@zju.edu.cn>
X-Mailer: git-send-email 2.17.1
X-CM-TRANSID: by_KCgC3v2++rG5g+g7dAA--.48532S4
X-Coremail-Antispam: 1UD129KBjvdXoWrZrW3Aw4rurW8GF1kAr48tFb_yoWfuFcEkr
        15Xr4fXws0gF1jyw17J3W5X34FvFyUWw18Wr40v3W3G3WrZrnxJr48WFn5Cw43Xw42kF1q
        yr90qry7AFs5JjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUIcSsGvfJTRUUUb2xFc2x0x2IEx4CE42xK8VAvwI8IcIk0rVWrJVCq3wAFIxvE14AK
        wVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK021l84ACjcxK6xIIjxv20x
        vE14v26w1j6s0DM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26rxl6s0DM28EF7xvwVC2z280
        aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s0DM2AIxVAIcxkEcVAq07
        x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1Y6r17
        McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr4
        1lF7I21c0EjII2zVCS5cI20VAGYxC7MxAIw28IcxkI7VAKI48JMxAIw28IcVCjz48v1sIE
        Y20_GFWkJr1UJwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI
        8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41l
        IxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIx
        AIcVCF04k26cxKx2IYs7xG6Fyj6rWUJwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E
        87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjfUouWlDUUUU
X-CM-SenderInfo: qrrzjiaqtzq6lmxovvfxof0/1tbiAg0JBlZdtTTcOgAGsq
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

pm_runtime_get_sync() will increase the rumtime PM counter
even it returns an error. Thus a pairing decrement is needed
to prevent refcount leak. Fix this by replacing this API with
pm_runtime_resume_and_get(), which will not change the runtime
PM counter on error.

Signed-off-by: Dinghao Liu <dinghao.liu@zju.edu.cn>
---
 drivers/dma/tegra20-apb-dma.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/dma/tegra20-apb-dma.c b/drivers/dma/tegra20-apb-dma.c
index 71827d9b0aa1..73178afaf4c2 100644
--- a/drivers/dma/tegra20-apb-dma.c
+++ b/drivers/dma/tegra20-apb-dma.c
@@ -723,7 +723,7 @@ static void tegra_dma_issue_pending(struct dma_chan *dc)
 		goto end;
 	}
 	if (!tdc->busy) {
-		err = pm_runtime_get_sync(tdc->tdma->dev);
+		err = pm_runtime_resume_and_get(tdc->tdma->dev);
 		if (err < 0) {
 			dev_err(tdc2dev(tdc), "Failed to enable DMA\n");
 			goto end;
-- 
2.17.1

