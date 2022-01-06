Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 197C4485F15
	for <lists+dmaengine@lfdr.de>; Thu,  6 Jan 2022 04:10:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229462AbiAFDKI (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 5 Jan 2022 22:10:08 -0500
Received: from smtp25.cstnet.cn ([159.226.251.25]:49778 "EHLO cstnet.cn"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229456AbiAFDKH (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Wed, 5 Jan 2022 22:10:07 -0500
Received: from localhost.localdomain (unknown [124.16.138.126])
        by APP-05 (Coremail) with SMTP id zQCowADX3n50XdZhtLuwBQ--.53024S2;
        Thu, 06 Jan 2022 11:09:41 +0800 (CST)
From:   Jiasheng Jiang <jiasheng@iscas.ac.cn>
To:     vkoul@kernel.org, geert+renesas@glider.be,
        yoshihiro.shimoda.uh@renesas.com,
        laurent.pinchart@ideasonboard.com,
        wsa+renesas@sang-engineering.com, zou_wei@huawei.com
Cc:     dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jiasheng Jiang <jiasheng@iscas.ac.cn>
Subject: [PATCH] dmaengine: sh: rcar-dmac: Check for error num after setting mask
Date:   Thu,  6 Jan 2022 11:09:39 +0800
Message-Id: <20220106030939.2644320-1-jiasheng@iscas.ac.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: zQCowADX3n50XdZhtLuwBQ--.53024S2
X-Coremail-Antispam: 1UD129KBjvdXoWrtr45Cw13Aw1rGFyDCrW5Awb_yoWDZwb_KF
        n7uF1FgF98GrWDtw1UCr13Arnagr4DXrnIvFWvg3ZayFWDJFnxJr4UA3s5A3y8Za97Kry7
        KrnrXrWfJ3y8ZjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUIcSsGvfJTRUUUb48FF20E14v26r4j6ryUM7CY07I20VC2zVCF04k26cxKx2IYs7xG
        6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8w
        A2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr0_
        Cr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x0267AKxVWxJr
        0_GcWle2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
        2Ix0cI8IcVAFwI0_Jrv_JF1lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJV
        W8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lc2xSY4AK67AK6r48
        MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr
        0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0E
        wIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JV
        WxJwCI42IY6xAIw20EY4v20xvaj40_Wr1j6rW3Jr1lIxAIcVC2z280aVAFwI0_Jr0_Gr1l
        IxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7VUjCtC7UUUU
        U==
X-Originating-IP: [124.16.138.126]
X-CM-SenderInfo: pmld2xxhqjqxpvfd2hldfou0/
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Because of the possible failure of the dma_supported(), the
dma_set_mask_and_coherent() may return error num.
Therefore, it should be better to check it and return the error if
fails.

Fixes: dc312349e875 ("dmaengine: rcar-dmac: Widen DMA mask to 40 bits")
Signed-off-by: Jiasheng Jiang <jiasheng@iscas.ac.cn>
---
 drivers/dma/sh/rcar-dmac.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/dma/sh/rcar-dmac.c b/drivers/dma/sh/rcar-dmac.c
index 6885b3dcd7a9..79901d0e9fbf 100644
--- a/drivers/dma/sh/rcar-dmac.c
+++ b/drivers/dma/sh/rcar-dmac.c
@@ -1869,7 +1869,9 @@ static int rcar_dmac_probe(struct platform_device *pdev)
 	dmac->dev = &pdev->dev;
 	platform_set_drvdata(pdev, dmac);
 	dma_set_max_seg_size(dmac->dev, RCAR_DMATCR_MASK);
-	dma_set_mask_and_coherent(dmac->dev, DMA_BIT_MASK(40));
+	ret = dma_set_mask_and_coherent(dmac->dev, DMA_BIT_MASK(40));
+	if (ret)
+		return ret;
 
 	ret = rcar_dmac_parse_of(&pdev->dev, dmac);
 	if (ret < 0)
-- 
2.25.1

