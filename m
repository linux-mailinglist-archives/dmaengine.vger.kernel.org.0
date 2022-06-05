Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 308C453D9E0
	for <lists+dmaengine@lfdr.de>; Sun,  5 Jun 2022 06:29:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241280AbiFEE1m (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Sun, 5 Jun 2022 00:27:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233427AbiFEE1l (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Sun, 5 Jun 2022 00:27:41 -0400
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A76D95A9;
        Sat,  4 Jun 2022 21:27:37 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id l7-20020a17090aaa8700b001dd1a5b9965so10076996pjq.2;
        Sat, 04 Jun 2022 21:27:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=WOhTe44VPyoPb87j6MeyPJTEiNbGsMoCFbZmrnQkf2o=;
        b=GETd6oF5tm30LdwNVWK+Fp0SK+v3RgyyYbjDrvuxQxtfzw4ZHtFnuKUDZ/xfv2XTvX
         LCpFwusWQE3vOuOkfq4JOA75r2oUzm/KV6wN3TkM2uOQkCzjE9EIYojZHBHrGurVMycT
         5sbTGdm5R/GICfAgTUuS0pwgh7E3GlTsSWYSrbPHtjZgtKiiJ7U4b55CQAmtWsf4Ib6f
         ogb1i3cOzb4aBytW0Uw5WKZCfqMPZkHPWGx6yqz/5O1Q0q4/wTMp089ZOW+KOdMJtlLv
         +wN5SnWHVvxYlPNyECYI6W+8POalNpxewG1wFaR/qJCFlNhJ6yxaQenvIUcg2uzvE/pD
         t79w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=WOhTe44VPyoPb87j6MeyPJTEiNbGsMoCFbZmrnQkf2o=;
        b=DnM3JJS8Mf3J0O4Q9ss1hfl7XQNsYp1IyrGO+ku5zcuvLwv0EYQZwrjOia3fDnZUAt
         E6cE/Afszcb886uOQIazh691hNdM3fLwtqhT+GECdmc2y+xlJkPSMY5CrBt2AprwTdvq
         E6x6KAFjgK7hoatxXt56QfNbBBaNa12JfrPLEBBobJwQzyi8FHOAuY3QoH77OXM+nSa9
         tZ4kVE4mSy51BcS/y7d8Mf8odiL+x2yMH8sN4iGgoMst2CT+Ybwjglz/SOX0Yz1Gi0zk
         IZl73BJ3Wxj5ulL4h4Mn4z48ECu5m1e7K0ebCy5qBcWkVNbm8lDV3pzX67nO+8ziAMAl
         +l/Q==
X-Gm-Message-State: AOAM531UafW4npck8tQSo27DltSwJDScgB7HrNFdcmTz3sbgOEAjr8k4
        ET/P/yZAMjcWy0LSr2jZ8Co=
X-Google-Smtp-Source: ABdhPJxItlAuBa8dp15/lt8Bh1rRiLMt73CvUBOG3VN/YoqOmfOOG3IorOtvY9t8dnFQ+M6wEcIecw==
X-Received: by 2002:a17:902:db0f:b0:164:597:3382 with SMTP id m15-20020a170902db0f00b0016405973382mr17846121plx.76.1654403256700;
        Sat, 04 Jun 2022 21:27:36 -0700 (PDT)
Received: from localhost.localdomain ([202.120.234.246])
        by smtp.googlemail.com with ESMTPSA id d62-20020a623641000000b0051baaa40028sm8316601pfa.11.2022.06.04.21.27.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 04 Jun 2022 21:27:36 -0700 (PDT)
From:   Miaoqian Lin <linmq006@gmail.com>
To:     Peter Ujfalusi <peter.ujfalusi@gmail.com>,
        Vinod Koul <vkoul@kernel.org>, dmaengine@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     linmq006@gmail.com
Subject: [PATCH v3 2/2] dmaengine: ti: Add missing put_device in ti_dra7_xbar_route_allocate
Date:   Sun,  5 Jun 2022 08:27:22 +0400
Message-Id: <20220605042723.17668-1-linmq006@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

of_find_device_by_node() takes reference, we should use put_device()
to release it when not need anymore.

Fixes: a074ae38f859 ("dmaengine: Add driver for TI DMA crossbar on DRA7x")
Signed-off-by: Miaoqian Lin <linmq006@gmail.com>
---
changes in v3:
- rebase so it can apply with the other patch
changes in v2:
- split v1 into two patches.
v1 link:
https://lore.kernel.org/r/20220512051815.11946-1-linmq006@gmail.com
v2 link:
https://lore.kernel.org/r/20220601110013.55366-1-linmq006@gmail.com/
---
 drivers/dma/ti/dma-crossbar.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/dma/ti/dma-crossbar.c b/drivers/dma/ti/dma-crossbar.c
index e34cfb50d241..f744ddbbbad7 100644
--- a/drivers/dma/ti/dma-crossbar.c
+++ b/drivers/dma/ti/dma-crossbar.c
@@ -245,6 +245,7 @@ static void *ti_dra7_xbar_route_allocate(struct of_phandle_args *dma_spec,
 	if (dma_spec->args[0] >= xbar->xbar_requests) {
 		dev_err(&pdev->dev, "Invalid XBAR request number: %d\n",
 			dma_spec->args[0]);
+		put_device(&pdev->dev);
 		return ERR_PTR(-EINVAL);
 	}
 
@@ -252,12 +253,14 @@ static void *ti_dra7_xbar_route_allocate(struct of_phandle_args *dma_spec,
 	dma_spec->np = of_parse_phandle(ofdma->of_node, "dma-masters", 0);
 	if (!dma_spec->np) {
 		dev_err(&pdev->dev, "Can't get DMA master\n");
+		put_device(&pdev->dev);
 		return ERR_PTR(-EINVAL);
 	}
 
 	map = kzalloc(sizeof(*map), GFP_KERNEL);
 	if (!map) {
 		of_node_put(dma_spec->np);
+		put_device(&pdev->dev);
 		return ERR_PTR(-ENOMEM);
 	}
 
@@ -269,6 +272,7 @@ static void *ti_dra7_xbar_route_allocate(struct of_phandle_args *dma_spec,
 		dev_err(&pdev->dev, "Run out of free DMA requests\n");
 		kfree(map);
 		of_node_put(dma_spec->np);
+		put_device(&pdev->dev);
 		return ERR_PTR(-ENOMEM);
 	}
 	set_bit(map->xbar_out, xbar->dma_inuse);
-- 
2.25.1

