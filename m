Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8BECE1DFD61
	for <lists+dmaengine@lfdr.de>; Sun, 24 May 2020 08:02:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726331AbgEXGC6 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Sun, 24 May 2020 02:02:58 -0400
Received: from spam.zju.edu.cn ([61.164.42.155]:63402 "EHLO zju.edu.cn"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725782AbgEXGC6 (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Sun, 24 May 2020 02:02:58 -0400
Received: from localhost.localdomain (unknown [222.205.77.158])
        by mail-app4 (Coremail) with SMTP id cS_KCgC3nwrwDcpee6wbAg--.17220S4;
        Sun, 24 May 2020 14:02:27 +0800 (CST)
From:   Dinghao Liu <dinghao.liu@zju.edu.cn>
To:     dinghao.liu@zju.edu.cn, kjlu@umn.edu
Cc:     Vinod Koul <vkoul@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        dmaengine@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] dmaengine: stm32-dmamux: Fix runtime PM imbalance on error
Date:   Sun, 24 May 2020 14:02:23 +0800
Message-Id: <20200524060224.16189-1-dinghao.liu@zju.edu.cn>
X-Mailer: git-send-email 2.17.1
X-CM-TRANSID: cS_KCgC3nwrwDcpee6wbAg--.17220S4
X-Coremail-Antispam: 1UD129KBjvJXoW7Kw47Zr18AF13Cr1fXrWDArb_yoW8uFW7pr
        W8tFWFvr4jqaySy3yDJr4kXFZa934fKr97trW8Gwn3Zw45XFyDt3WrJrWj9F18XF95Ar4D
        Kr17A3yxCF1UuFUanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUU9l1xkIjI8I6I8E6xAIw20EY4v20xvaj40_Wr0E3s1l1IIY67AE
        w4v_Jr0_Jr4l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2
        IY67AKxVWDJVCq3wA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxVW8Jr0_Cr1UM28EF7xvwVC2
        z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s0DM2AIxVAIcxkEcV
        Aq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1j
        6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64
        vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7M4IIrI8v6xkF7I0E8cxan2IY04v7MxkIecxE
        wVAFwVW8AwCF04k20xvY0x0EwIxGrwCF04k20xvE74AGY7Cv6cx26r4fKr1UJr1l4I8I3I
        0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWU
        GVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI
        0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0
        rVWrJr0_WFyUJwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r
        4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjfUndb1UUUUU
X-CM-SenderInfo: qrrzjiaqtzq6lmxovvfxof0/1tbiAgEJBlZdtORShQAbsb
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

In stm32_dmamux_route_allocate(),  pm_runtime_get_sync() increments
the runtime PM usage counter even when it returns an error code.
Thus a pairing decrement is needed on the error handling path to
keep the counter balanced.

In stm32_dmamux_probe(), when platform_get_resource() returns an
error code, a pairing runtime PM usage counter decrement is needed
to keep the counter balanced. For error paths after this call,
things are the same.

Signed-off-by: Dinghao Liu <dinghao.liu@zju.edu.cn>
---
 drivers/dma/stm32-dmamux.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/dma/stm32-dmamux.c b/drivers/dma/stm32-dmamux.c
index 12f7637e13a1..e68e7078ff94 100644
--- a/drivers/dma/stm32-dmamux.c
+++ b/drivers/dma/stm32-dmamux.c
@@ -139,6 +139,7 @@ static void *stm32_dmamux_route_allocate(struct of_phandle_args *dma_spec,
 	spin_lock_irqsave(&dmamux->lock, flags);
 	ret = pm_runtime_get_sync(&pdev->dev);
 	if (ret < 0) {
+		pm_runtime_put_noidle(&pdev->dev);
 		spin_unlock_irqrestore(&dmamux->lock, flags);
 		goto error;
 	}
@@ -246,8 +247,10 @@ static int stm32_dmamux_probe(struct platform_device *pdev)
 
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	iomem = devm_ioremap_resource(&pdev->dev, res);
-	if (IS_ERR(iomem))
+	if (IS_ERR(iomem)) {
+		pm_runtime_put_noidle(&pdev->dev);
 		return PTR_ERR(iomem);
+	}
 
 	spin_lock_init(&stm32_dmamux->lock);
 
@@ -256,12 +259,14 @@ static int stm32_dmamux_probe(struct platform_device *pdev)
 		ret = PTR_ERR(stm32_dmamux->clk);
 		if (ret != -EPROBE_DEFER)
 			dev_err(&pdev->dev, "Missing clock controller\n");
+		pm_runtime_put_noidle(&pdev->dev);
 		return ret;
 	}
 
 	ret = clk_prepare_enable(stm32_dmamux->clk);
 	if (ret < 0) {
 		dev_err(&pdev->dev, "clk_prep_enable error: %d\n", ret);
+		pm_runtime_put_noidle(&pdev->dev);
 		return ret;
 	}
 
@@ -300,6 +305,7 @@ static int stm32_dmamux_probe(struct platform_device *pdev)
 	return 0;
 
 err_clk:
+	pm_runtime_put_noidle(&pdev->dev);
 	clk_disable_unprepare(stm32_dmamux->clk);
 
 	return ret;
-- 
2.17.1

