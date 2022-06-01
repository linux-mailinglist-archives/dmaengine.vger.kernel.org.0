Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A7F5953A34D
	for <lists+dmaengine@lfdr.de>; Wed,  1 Jun 2022 12:56:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352235AbiFAK4B (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 1 Jun 2022 06:56:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352202AbiFAK4A (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 1 Jun 2022 06:56:00 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F27CF546AD;
        Wed,  1 Jun 2022 03:55:59 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id l20-20020a17090a409400b001dd2a9d555bso1743380pjg.0;
        Wed, 01 Jun 2022 03:55:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=cQYlXoGDywk+3GdfKjepz9XHgwe5hFSMlVKeZfjQrNE=;
        b=hTQgEKWKGjIVhZCCo2lCFCkMpMrcK+x/YoAhVD6QE7lAop6icY0EQq1dOWZnG1mXV5
         fKGPzRcEvXeryt4fWSXWWRZC+bL2qf67zW1M0ETZ5qagUu+/Y+1YmWtkqtLfuNzkgXRx
         k4AyUYGau5T0ig9rTHdNkvpfwTwJgytG+UFSJs643ZZCN7wHnWHNseai7ZbMyAlUBn1R
         LMso3hSfGcg8/jy2PcTsDluW8BOeE9eUxsKiYRLzuGizl8KyoodcRK8qbf1YjGE/6BlZ
         fuyvJDig73OFMG2iYCTMEYmrk1/kRMlrg5uLza7BOZg4pCHz5qHZL0jad7YBbDur8z5T
         ykMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=cQYlXoGDywk+3GdfKjepz9XHgwe5hFSMlVKeZfjQrNE=;
        b=JqddhPnyXMIaD5bZWG4v74skYlM/w7Pq2GJeu5uXXlQZNbHHcvAC/2mcYhZSK8b8F4
         yTJltq2cWP7nYwBSk0X1Sl1jBHu5D3sJ4MF8MlueQ0XLeOhy63xrBT9fcNphDmcJK73s
         /yQZV+DEhfU4L56sGjFv51ikJXqmpQYlyVcbdPQ8XwL98st4CZI8E27c4H7BAY6DgVvB
         9QbXYMayoafrtZOXaQcL85Z5kKnscczKSSt78iCf+0FKLfJ7au1CM1u2+xL3oNH/ONVJ
         hHOJk1NiQnuNo6ULj6VVUWE2UwSNi1dhRPUCNtiUolDkaxxL9TRfmrKr7Oqqo88Pwyqa
         +Fpw==
X-Gm-Message-State: AOAM533GEUB6gTBC/JyMfYWRnbo8qOZ8uPruXbQ3RSrg/BEkcc0FWzP4
        QgfJaqGJPnO2G5CM0WKZ858=
X-Google-Smtp-Source: ABdhPJym1X3sQfx6g0N+7PgV1oBquYAy8tkYdP4yj0xMzPVDty8AZe+/sHkSTzU65Y386lntfJbcWw==
X-Received: by 2002:a17:902:f686:b0:163:d8c9:18f3 with SMTP id l6-20020a170902f68600b00163d8c918f3mr15466340plg.64.1654080959295;
        Wed, 01 Jun 2022 03:55:59 -0700 (PDT)
Received: from localhost.localdomain ([202.120.234.246])
        by smtp.googlemail.com with ESMTPSA id l12-20020a170903004c00b00161929fb1adsm1235268pla.54.2022.06.01.03.55.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Jun 2022 03:55:58 -0700 (PDT)
From:   Miaoqian Lin <linmq006@gmail.com>
To:     dave.jiang@intel.com, Peter Ujfalusi <peter.ujfalusi@gmail.com>,
        Vinod Koul <vkoul@kernel.org>, dmaengine@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     linmq006@gmail.com
Subject: [PATCH v2] dmaengine: ti: Fix refcount leak in ti_dra7_xbar_route_allocate
Date:   Wed,  1 Jun 2022 14:55:46 +0400
Message-Id: <20220601105546.53068-1-linmq006@gmail.com>
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

of_parse_phandle() returns a node pointer with refcount
incremented, we should use of_node_put() on it when not needed anymore.

Add missing of_node_put() in to fix this.

Fixes: ec9bfa1e1a79 ("dmaengine: ti-dma-crossbar: dra7: Use bitops instead of idr")
Signed-off-by: Miaoqian Lin <linmq006@gmail.com>
---
- split v1 into two patches.
v1 link: https://lore.kernel.org/r/20220512051815.11946-1-linmq006@gmail.com
---
 drivers/dma/ti/dma-crossbar.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/dma/ti/dma-crossbar.c b/drivers/dma/ti/dma-crossbar.c
index 71d24fc07c00..e34cfb50d241 100644
--- a/drivers/dma/ti/dma-crossbar.c
+++ b/drivers/dma/ti/dma-crossbar.c
@@ -268,6 +268,7 @@ static void *ti_dra7_xbar_route_allocate(struct of_phandle_args *dma_spec,
 		mutex_unlock(&xbar->mutex);
 		dev_err(&pdev->dev, "Run out of free DMA requests\n");
 		kfree(map);
+		of_node_put(dma_spec->np);
 		return ERR_PTR(-ENOMEM);
 	}
 	set_bit(map->xbar_out, xbar->dma_inuse);
-- 
2.25.1

