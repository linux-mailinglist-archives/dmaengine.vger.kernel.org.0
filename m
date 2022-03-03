Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA2054CB51C
	for <lists+dmaengine@lfdr.de>; Thu,  3 Mar 2022 03:52:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231786AbiCCCoe (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 2 Mar 2022 21:44:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231775AbiCCCoe (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 2 Mar 2022 21:44:34 -0500
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D4EF50070;
        Wed,  2 Mar 2022 18:43:50 -0800 (PST)
Received: by mail-wm1-x329.google.com with SMTP id 19so2046020wmy.3;
        Wed, 02 Mar 2022 18:43:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id;
        bh=X4lL1PvOagfTI9D2Cq0N1Z99LjMee5r39OHywdd0uu8=;
        b=Qw9e3RXwingIRwGEOQG1r7xPywiwHiyTC2+iiblBghPVdrEE6vs1HXQ4OVuavFolk9
         hw33KZbgyJo+G1wgw46v2VhQzteuHiXcnS9PJ/gPUe3oigd9DTKS1fx8PXpE+opGQ3NB
         xryT5B6EjLgCNBiRIbN30YmQpMJR+G38zxaHd7PKRSWi3pKEk7dL+mjiTpWET2P6F+G+
         JmFksjC48cfv22Ap1DjX7ED4xq8nrRS7o1Pq5pda0H3/baQ+Wq6w3ASxWA1imAe4hsGu
         7meFP3SDA0ea1RvurF6flgsVV1mHVIUm1ejivgQ9zNHiK4NO9mSrLcP8CIeMn36cZyk8
         +Zng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=X4lL1PvOagfTI9D2Cq0N1Z99LjMee5r39OHywdd0uu8=;
        b=Rv36eQ0cMf9uvnBuOvzmbLUZiZjN8suH4CbtNMKm0QaPpijE0aMobx9SkB0FbYCGrA
         6iXs9uAAQYh499BZvXr7UayVCpdCpMrBfmDgkqNOiFbCSxPTCx4metocKh1Xv1jRhLop
         aW3CDRLhsQJM3wqQ/oQ622e2BnxH3YC4aH74tsjOFbhE/QeH4CMpBJafySN6fVtpY+pX
         CrHUajZQP27J70s/ewLU1JFj2kK72b6HGSSAowUYflrx2cWv5uLgdYTwx4mo8rTx9L0f
         gMZ2o7wp1eAVPBYz5hCWuAK2HiPf5tf7IyRgcPTW6rw/54T1lr/sEfhpfTyq/JHjZ0Fz
         mDvw==
X-Gm-Message-State: AOAM533TOoOvdK4hLTD8oAI7Y68G08EsI3Y/cObSA2sNPm3RT/bnWeRa
        zgcNIqZhnZVctg2MpRh+CnY=
X-Google-Smtp-Source: ABdhPJxoj+S2W0yqu83WsZhNy6k07kS+Sq8CCCc5eOJevVcQneDb1UEN4cL4PZw8yE5BR8c4sdxIbQ==
X-Received: by 2002:a05:600c:4182:b0:381:42:ac91 with SMTP id p2-20020a05600c418200b003810042ac91mr2055013wmh.116.1646275428817;
        Wed, 02 Mar 2022 18:43:48 -0800 (PST)
Received: from localhost.localdomain ([64.64.123.48])
        by smtp.gmail.com with ESMTPSA id f22-20020a1cc916000000b00380d3e49e89sm649222wmb.22.2022.03.02.18.43.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Mar 2022 18:43:48 -0800 (PST)
From:   Jia-Ju Bai <baijiaju1990@gmail.com>
To:     vkoul@kernel.org, michal.simek@xilinx.com,
        m.tretter@pengutronix.de, yukuai3@huawei.com, lars@metafoo.de,
        libaokun1@huawei.com
Cc:     dmaengine@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Jia-Ju Bai <baijiaju1990@gmail.com>
Subject: [PATCH] dma: xilinx: check the return value of dma_set_mask() in zynqmp_dma_probe()
Date:   Wed,  2 Mar 2022 18:43:34 -0800
Message-Id: <20220303024334.813-1-baijiaju1990@gmail.com>
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
 drivers/dma/xilinx/zynqmp_dma.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/dma/xilinx/zynqmp_dma.c b/drivers/dma/xilinx/zynqmp_dma.c
index 7aa63b652027..963fb1de93af 100644
--- a/drivers/dma/xilinx/zynqmp_dma.c
+++ b/drivers/dma/xilinx/zynqmp_dma.c
@@ -1050,7 +1050,8 @@ static int zynqmp_dma_probe(struct platform_device *pdev)
 	zdev->dev = &pdev->dev;
 	INIT_LIST_HEAD(&zdev->common.channels);
 
-	dma_set_mask(&pdev->dev, DMA_BIT_MASK(44));
+	if (dma_set_mask(&pdev->dev, DMA_BIT_MASK(44)))
+		return -EIO;
 	dma_cap_set(DMA_MEMCPY, zdev->common.cap_mask);
 
 	p = &zdev->common;
-- 
2.17.1

