Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4CF7053A359
	for <lists+dmaengine@lfdr.de>; Wed,  1 Jun 2022 13:00:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345062AbiFALA0 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 1 Jun 2022 07:00:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240188AbiFALAZ (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 1 Jun 2022 07:00:25 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D6D887A18;
        Wed,  1 Jun 2022 04:00:24 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id n13-20020a17090a394d00b001e30a60f82dso5832133pjf.5;
        Wed, 01 Jun 2022 04:00:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=9UICWseTXQDvetgVvOG/qthF2Pq65Utfj44zQBiDUYs=;
        b=A+UH5SS0PzNVOe5vrUrizRzvoqQtjxk5bi9vGXyM80eHcoUocnRm0qLhdt9chTftRO
         gpG1NptJnpBp+9WVtSU3+3qql0J+KFL3iBsJzikKVHwl9bbnPgSc56gX7iEhBQfr1VfK
         ppQP7Az6vnpCwli4Ba9zTRhJOlooP/A+u2kW5S2LI7t8djsBqJRr3cAyECAz/7l7CHYW
         52IbeaTcmkMAyXenCfJYWGmhKBMc20mKGd14Xj1SNiztr4igPlPzyO77lLG0wSOfz4XA
         v4vewlG5k93A73oFmLURmqLbl245LSuf5izEpBuH4d148tcrpPElEv/e2X3fRdR1gp+y
         2BqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=9UICWseTXQDvetgVvOG/qthF2Pq65Utfj44zQBiDUYs=;
        b=4EkXO/pv3Lt8rRHen93oPPkB+BXO0KZBO5XJ62BSdyiemV3h2E5X9hg0Q8VKff1Ai7
         II8MYmrC1dNPCSnU5kwAeWnEcGANukJPfXPKGwtFNewcfVtPm8seyIImoyocV6xbyR68
         ezYGIh46qF1iRc9gjOw991kt7fVS6jPqP4qfTdZXqT2plW+RktGApiMxlJxkfXkXCdRQ
         uPGimhGnhZDXw2gYQcuv77sXnyrY/g1UeTy/lcp9qfgHev38O6u8pQPPsRTo8wcZU82W
         78FSyfxTLnmEqLniLKIwzlPG2nmnQp2ZUne8p6dZI+WstsQ+9QfbYhSh6aJYde9tusac
         6JYQ==
X-Gm-Message-State: AOAM530PsF6YnAiXgH0fMUnQWHEUTqH3Htg7fx6sm/KuqJvZu4Kvmwjy
        iaRR/bs0CUdSYJlRvSKzoQSiG9Dchj7ftQJr
X-Google-Smtp-Source: ABdhPJy99vBpUrgzPoMgQ0qI8GVkF6goMPhkSOfucAwWUcbaYEc9DunL/P2P/43FA6E902zgjfJwEQ==
X-Received: by 2002:a17:902:dad2:b0:162:46a:73ae with SMTP id q18-20020a170902dad200b00162046a73aemr54916931plx.168.1654081223576;
        Wed, 01 Jun 2022 04:00:23 -0700 (PDT)
Received: from localhost.localdomain ([202.120.234.246])
        by smtp.googlemail.com with ESMTPSA id x13-20020a170902820d00b00163c0a1f718sm1223478pln.303.2022.06.01.04.00.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Jun 2022 04:00:22 -0700 (PDT)
From:   Miaoqian Lin <linmq006@gmail.com>
To:     dave.jiang@intel.com, Peter Ujfalusi <peter.ujfalusi@gmail.com>,
        Vinod Koul <vkoul@kernel.org>, dmaengine@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     linmq006@gmail.com
Subject: [PATCH v2] dmaengine: ti: Add missing put_device in ti_dra7_xbar_route_allocate
Date:   Wed,  1 Jun 2022 15:00:13 +0400
Message-Id: <20220601110013.55366-1-linmq006@gmail.com>
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
changes in v2:
- split v1 into two patches.
v1 link:
https://lore.kernel.org/r/20220512051815.11946-1-linmq006@gmail.com
---
 drivers/dma/ti/dma-crossbar.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/dma/ti/dma-crossbar.c b/drivers/dma/ti/dma-crossbar.c
index 71d24fc07c00..06da13b18a7b 100644
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
 
@@ -268,6 +271,7 @@ static void *ti_dra7_xbar_route_allocate(struct of_phandle_args *dma_spec,
 		mutex_unlock(&xbar->mutex);
 		dev_err(&pdev->dev, "Run out of free DMA requests\n");
 		kfree(map);
+		put_device(&pdev->dev);
 		return ERR_PTR(-ENOMEM);
 	}
 	set_bit(map->xbar_out, xbar->dma_inuse);
-- 
2.25.1

