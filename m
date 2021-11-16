Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 224F445255C
	for <lists+dmaengine@lfdr.de>; Tue, 16 Nov 2021 02:47:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357930AbhKPBuE (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 15 Nov 2021 20:50:04 -0500
Received: from smtp21.cstnet.cn ([159.226.251.21]:44472 "EHLO cstnet.cn"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1381608AbhKPBqj (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Mon, 15 Nov 2021 20:46:39 -0500
X-Greylist: delayed 586 seconds by postgrey-1.27 at vger.kernel.org; Mon, 15 Nov 2021 20:46:39 EST
Received: from localhost.localdomain (unknown [124.16.141.244])
        by APP-01 (Coremail) with SMTP id qwCowACnrQloCpNhgpCmBw--.11161S2;
        Tue, 16 Nov 2021 09:33:29 +0800 (CST)
From:   Xu Wang <vulab@iscas.ac.cn>
To:     agross@kernel.org, bjorn.andersson@linaro.org, vkoul@kernel.org
Cc:     linux-arm-msm@vger.kernel.org, dmaengine@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] dmaengine: qcom: gpi: Remove unnecessary print function dev_err()
Date:   Tue, 16 Nov 2021 01:33:06 +0000
Message-Id: <20211116013306.784-1-vulab@iscas.ac.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qwCowACnrQloCpNhgpCmBw--.11161S2
X-Coremail-Antispam: 1UD129KBjvdXoWrZrWrWF45tw4UXF1fKF18Grg_yoW3JrcEk3
        W8urZ3Wr40yFyqvr1Ikw13AryvvF90vrs5uws2qa13t3s8X3saq39rAF4kAr48X3yjkryj
        kr98ur43Cr4fAjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUIcSsGvfJTRUUUbwxYjsxI4VWDJwAYFVCjjxCrM7AC8VAFwI0_Jr0_Gr1l1xkIjI8I
        6I8E6xAIw20EY4v20xvaj40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l8cAvFVAK0II2c7xJM2
        8CjxkF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVW5JVW7JwA2z4x0Y4vE2Ix0
        cI8IcVCY1x0267AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIE14v26r4UJVWxJr1l84ACjcxK6I
        8E87Iv6xkF7I0E14v26r4UJVWxJr1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xv
        F2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r
        4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x0EwIxGrwCF04k20xvY0x0EwIxGrwCF
        x2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14
        v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw1lIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY
        67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr1lIxAIcVCF04k26cxKx2
        IYs7xG6rW3Jr0E3s1lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AK
        xVWUJVW8JbIYCTnIWIevJa73UjIFyTuYvjxUcVWlDUUUU
X-Originating-IP: [124.16.141.244]
X-CM-SenderInfo: pyxotu46lvutnvoduhdfq/1tbiBgcHA10TfwQQVwAAs3
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

The print function dev_err() is redundant because
platform_get_irq() already prints an error.

Signed-off-by: Xu Wang <vulab@iscas.ac.cn>
---
 drivers/dma/qcom/gpi.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/dma/qcom/gpi.c b/drivers/dma/qcom/gpi.c
index 1a1b7d8458c9..94f3648f7483 100644
--- a/drivers/dma/qcom/gpi.c
+++ b/drivers/dma/qcom/gpi.c
@@ -2206,10 +2206,8 @@ static int gpi_probe(struct platform_device *pdev)
 
 		/* set up irq */
 		ret = platform_get_irq(pdev, i);
-		if (ret < 0) {
-			dev_err(gpi_dev->dev, "platform_get_irq failed for %d:%d\n", i, ret);
+		if (ret < 0)
 			return ret;
-		}
 		gpii->irq = ret;
 
 		/* set up channel specific register info */
-- 
2.25.1

