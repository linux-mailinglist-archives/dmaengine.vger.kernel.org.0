Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 162DC4CE3F8
	for <lists+dmaengine@lfdr.de>; Sat,  5 Mar 2022 10:31:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230226AbiCEJcd (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Sat, 5 Mar 2022 04:32:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229590AbiCEJcc (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Sat, 5 Mar 2022 04:32:32 -0500
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A289C21D087;
        Sat,  5 Mar 2022 01:31:42 -0800 (PST)
Received: by mail-wr1-x434.google.com with SMTP id b5so15997232wrr.2;
        Sat, 05 Mar 2022 01:31:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id;
        bh=vaa9FvdTpNZqd2d6Oc0OE/r/3v+vyBiqAeaP9xPqhtk=;
        b=PLt55TC8ooVxjZu9AvFK2v1j+G96W0UgGdDzbdJRgr574mn+3ocI/XWPIag0brCkqh
         qPKm0QIt2TIZqgFcKeMnuhntUPRKpS5dZXt2P/ybJzgaFM3WFhMOBNSm1H1Oi0b9XJDF
         f8+5CFiiULzuSpnjgXgR5NP5Xi9GxHuvqjaZBjCP7tBAedD4HS4DYlLNWtyLtQ6Z04L7
         ELg6kfnDOF1ZBI8P3DS0pfJ7j34kYRtCyP/ydIQ4gXJMWl1O5IW7xlnX4Uao70I7k6BF
         aCfjLCg7QrTHDTup7nIziH6xieH+cwjwAfGe/iBwusKIArVJJrWFOBrK4np5aAIIHyrM
         0lCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=vaa9FvdTpNZqd2d6Oc0OE/r/3v+vyBiqAeaP9xPqhtk=;
        b=WkXkWhTt5RKn4JFbcUPeo/VIJI7uFv83P2iY3nDm0J5F4cUeTSDX9ZmtfvV/0qlb0T
         TVqVrD9eHRkuzImCcce3F/can+3y/urSsl8C4WJZOEtObV0wstN+ktN9T+44s3BrAU/6
         5NxKWGmD7VZlMLZlTkhQ4OZhcSrMMLjY4AEeS53foQpxJMpu+PpPPrWb4/hrH3TwaZso
         o+gWloh969i0WYEOYlr5YVJ+RMMJTHffGm3ZcvcRXSrrn+tQDsZR9Ey9AAUWe4SxLYl9
         PsCExQ/PuaB054BHTWWV6JPgpNKAYhL1CSy15hRIxJK9GiByqJGU5+sHKnumeIdeMLSH
         YXgA==
X-Gm-Message-State: AOAM533Y0iZpdSdZHHewlXbHTPa/HoWcya9CIdCdeFCrWxwtV7bYP4a4
        mEd2n9twEK7kcuuhUuVH81aqdVfR1yNluQ==
X-Google-Smtp-Source: ABdhPJy/tC4m3vdDhR0KEM6zPir0uboL2kBiAzK6ABjxHV5vi4YaMGIV0n45OnWHEnCDxV2XvT9hEQ==
X-Received: by 2002:a05:6000:137a:b0:1f1:d6ec:7b69 with SMTP id q26-20020a056000137a00b001f1d6ec7b69mr1837889wrz.78.1646472701182;
        Sat, 05 Mar 2022 01:31:41 -0800 (PST)
Received: from localhost.localdomain ([64.64.123.48])
        by smtp.gmail.com with ESMTPSA id r15-20020a05600c35cf00b003808165fbc2sm7909863wmq.25.2022.03.05.01.31.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 05 Mar 2022 01:31:40 -0800 (PST)
From:   Jia-Ju Bai <baijiaju1990@gmail.com>
To:     vkoul@kernel.org, michal.simek@xilinx.com,
        m.tretter@pengutronix.de, lars@metafoo.de, libaokun1@huawei.com,
        yukuai3@huawei.com
Cc:     dmaengine@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Jia-Ju Bai <baijiaju1990@gmail.com>
Subject: [PATCH v2] dma: xilinx: check the return value of dma_set_mask() in zynqmp_dma_probe()
Date:   Sat,  5 Mar 2022 01:31:20 -0800
Message-Id: <20220305093120.28999-1-baijiaju1990@gmail.com>
X-Mailer: git-send-email 2.17.1
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

The function dma_set_mask() in zynqmp_dma_probe() can fail, so its
return value should be checked.

Fixes: b0cc417c1637 ("dmaengine: Add Xilinx zynqmp dma engine driver support")
Reported-by: TOTE Robot <oslab@tsinghua.edu.cn>
Signed-off-by: Jia-Ju Bai <baijiaju1990@gmail.com>
---
v2:
* Print an error message and forward the return value of dma_set_mask().
  Thank Michael for good advice.

---
 drivers/dma/xilinx/zynqmp_dma.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/dma/xilinx/zynqmp_dma.c b/drivers/dma/xilinx/zynqmp_dma.c
index 7aa63b652027..2791e9c6a4ea 100644
--- a/drivers/dma/xilinx/zynqmp_dma.c
+++ b/drivers/dma/xilinx/zynqmp_dma.c
@@ -1050,7 +1050,10 @@ static int zynqmp_dma_probe(struct platform_device *pdev)
 	zdev->dev = &pdev->dev;
 	INIT_LIST_HEAD(&zdev->common.channels);
 
-	dma_set_mask(&pdev->dev, DMA_BIT_MASK(44));
+	ret = dma_set_mask(&pdev->dev, DMA_BIT_MASK(44));
+	if (ret)
+		return dev_err_probe(&pdev->dev, ret, "No usable DMA available\n");
+
 	dma_cap_set(DMA_MEMCPY, zdev->common.cap_mask);
 
 	p = &zdev->common;
-- 
2.17.1

