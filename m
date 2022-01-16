Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9242048FC56
	for <lists+dmaengine@lfdr.de>; Sun, 16 Jan 2022 12:32:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234853AbiAPLcv (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Sun, 16 Jan 2022 06:32:51 -0500
Received: from zg8tmtyylji0my4xnjeumjiw.icoremail.net ([162.243.161.220]:60041
        "HELO zg8tmtyylji0my4xnjeumjiw.icoremail.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with SMTP id S232797AbiAPLcv (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Sun, 16 Jan 2022 06:32:51 -0500
X-Greylist: delayed 21321 seconds by postgrey-1.27 at vger.kernel.org; Sun, 16 Jan 2022 06:32:51 EST
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=pku.edu.cn; s=dkim; h=Received:From:To:Cc:Subject:Date:
        Message-Id; bh=4qtF5pTLgHrEtS/8byluABFgtK1z5IUdOHuMX+F5kgw=; b=A
        gpwgqDGv4gr0ssKHhJ3wqZ4uhsqWVe5I44dY0ari+e0sXuhdyWaSb++2TTeYJ6G6
        5cRYWBpqAI1fOtJEijJGxMqkvxYxeCX6uLi1ASgZy71xd1mSM6ebOadb+T9NPDcA
        NVpS5c/R2d+GtKF6sbKa+555zST/3Y4GN1gTiJ7JZQ=
Received: from localhost (unknown [10.129.21.144])
        by front01 (Coremail) with SMTP id 5oFpogAXHTkgAuRh8vdaAA--.26418S2;
        Sun, 16 Jan 2022 19:31:44 +0800 (CST)
From:   Yongzhi Liu <lyz_cs@pku.edu.cn>
To:     peter.ujfalusi@gmail.com, vkoul@kernel.org
Cc:     dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
        Yongzhi Liu <lyz_cs@pku.edu.cn>
Subject: [PATCH] dmaengine: ti: Fix runtime PM imbalance on error
Date:   Sun, 16 Jan 2022 03:31:42 -0800
Message-Id: <1642332702-126304-1-git-send-email-lyz_cs@pku.edu.cn>
X-Mailer: git-send-email 2.7.4
X-CM-TRANSID: 5oFpogAXHTkgAuRh8vdaAA--.26418S2
X-Coremail-Antispam: 1UD129KBjvdXoWrKrW7ZFW7WF1rGrW8GF4rKrg_yoWfAFb_Cr
        1rZrWxXrnxWF4Dtw17AwnxZFy0qF4UXr1DuF4Fv343trWjyrs8JrWYvFnYyws3X3yjyr1q
        ya1v9F17CrWDWjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUIcSsGvfJTRUUUb4xFc2x0x2IEx4CE42xK8VAvwI8IcIk0rVWrJVCq3wAFIxvE14AK
        wVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK021l84ACjcxK6xIIjxv20x
        vE14v26w1j6s0DM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26F4UJVW0owA2z4x0Y4vEx4A2
        jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oVCq3wAS0I0E0xvYzxvE52
        x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUJVWU
        GwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI4
        8JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwCY02Avz4vE-syl42xK82IYc2Ij64vIr41l42xK
        82IY6x8ErcxFaVAv8VWkJr1UJwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14
        v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw1lIxkG
        c2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI
        0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4U
        MIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x0JUdHUDUUU
        UU=
X-CM-SenderInfo: irzqijirqukmo6sn3hxhgxhubq/1tbiAwEEBlPy7t9+qgASsW
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

pm_runtime_get_sync() increments the runtime PM usage counter even
when it returns an error code, thus a matching decrement is needed on
the error handling path to keep the counter balanced.

Signed-off-by: Yongzhi Liu <lyz_cs@pku.edu.cn>
---
 drivers/dma/ti/edma.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/dma/ti/edma.c b/drivers/dma/ti/edma.c
index 08e47f4..a73f779 100644
--- a/drivers/dma/ti/edma.c
+++ b/drivers/dma/ti/edma.c
@@ -2398,9 +2398,9 @@ static int edma_probe(struct platform_device *pdev)
 	platform_set_drvdata(pdev, ecc);
 
 	pm_runtime_enable(dev);
-	ret = pm_runtime_get_sync(dev);
+	ret = pm_runtime_resume_and_get(dev);
 	if (ret < 0) {
-		dev_err(dev, "pm_runtime_get_sync() failed\n");
+		dev_err(dev, "pm_runtime_resume_and_get() failed\n");
 		pm_runtime_disable(dev);
 		return ret;
 	}
-- 
2.7.4

