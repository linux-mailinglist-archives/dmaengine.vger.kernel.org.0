Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 77AB1546326
	for <lists+dmaengine@lfdr.de>; Fri, 10 Jun 2022 12:07:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346745AbiFJKHL (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 10 Jun 2022 06:07:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245351AbiFJKHL (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 10 Jun 2022 06:07:11 -0400
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 068AEB8BEF
        for <dmaengine@vger.kernel.org>; Fri, 10 Jun 2022 03:07:09 -0700 (PDT)
Received: by mail-lf1-x131.google.com with SMTP id y32so42046381lfa.6
        for <dmaengine@vger.kernel.org>; Fri, 10 Jun 2022 03:07:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=93d6DqUA/7jSSSmvLVQKG+5AvGpCv+ZVhrUAJzlXb/k=;
        b=xL3/8t2OIOwKGzhDK86Kg417LeorfI804QeNbeL9siG0nUKxUHR5oSZseLFRFthjT3
         3qrrJDuJtIydsEX6t9oUmTOVFtvvhksXt56jNTmfosLL0UUYHU+M0d4x4nkM+EPSuuyj
         DonL80ZRPUq7LmR8o4SzSQ6tDeYiX+/7hNzr40fJSjVgi2EjK/m+tKHeZOuY5DxaNUBB
         N0vHGXNM9VLPyOZIMLDikoGQlB4LxnBrxqQt1ac8DRBxTC84lLiurQqzseAHkF7G/mm5
         51jx3ETRO8Ktsz6/dVruwdgDoRmg388S3pomTHtuFTNAZ661GyyS4v7bzYRlOAgB0jpR
         lN9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=93d6DqUA/7jSSSmvLVQKG+5AvGpCv+ZVhrUAJzlXb/k=;
        b=EIcazde5jqk0oK5IckqRewSfIlbDqLt84QW22jkoT1iAVgJR6ytd6f+dQbhz8LJ17E
         SihHB3/6FTcI3EI86Es39AgovF9EqON3Xw7BxvuyiSXRMo4/i8tZfwsNNwTTOF7X7Yyy
         TqTDQElEz8r3A1DDr/kJAu03UCHtknKg6SWBmRcQwyG8+hnMQV12hIOp0yoIZEXFN9AH
         75/BGLUth2bjp7XW/6fXrfxC9eIabuSJTnZIStOlcbeMIfsGnWKi6yDIKhM4lBSU2qmz
         meKEcOdPLBP0EC9dgLsklv/XuP9BPkH6ysGdLUXU9LNIvRyv3xbYmi4EFWoBnApPNpaT
         jj0Q==
X-Gm-Message-State: AOAM5310ePmScuiITTLuhlzHEUbKkd7jf6npvfyenx2ESrTIHl80EdKG
        AwDSPTPuxTMfpswcxBUCMQ51kw==
X-Google-Smtp-Source: ABdhPJxm7R3qxew+MyVOfEF6O2Mw55iIjL1fe169JVGd5tDuiFWqEnnjoiFyhsWch8zxRphQb5MN4w==
X-Received: by 2002:a05:6512:3ba7:b0:479:2fbe:8b8 with SMTP id g39-20020a0565123ba700b004792fbe08b8mr18792247lfv.9.1654855627324;
        Fri, 10 Jun 2022 03:07:07 -0700 (PDT)
Received: from localhost.localdomain (88-112-131-206.elisa-laajakaista.fi. [88.112.131.206])
        by smtp.gmail.com with ESMTPSA id n5-20020a2ea5c5000000b00255b16a1521sm1423749ljp.41.2022.06.10.03.07.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jun 2022 03:07:07 -0700 (PDT)
From:   Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>
To:     Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Vinod Koul <vkoul@kernel.org>
Cc:     Herve Codina <herve.codina@bootlin.com>, dmaengine@vger.kernel.org
Subject: [PATCH] dmaengine: dw-edma: remove a macro conditional with similar branches
Date:   Fri, 10 Jun 2022 13:07:00 +0300
Message-Id: <20220610100700.2295522-1-vladimir.zapolskiy@linaro.org>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

After adding commit 8fc5133d6d4d ("dmaengine: dw-edma: Fix unaligned
64bit access") two branches under macro conditional become identical,
thus the code can be simplified without any functional change.

Signed-off-by: Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>
---
 drivers/dma/dw-edma/dw-edma-v0-core.c | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/drivers/dma/dw-edma/dw-edma-v0-core.c b/drivers/dma/dw-edma/dw-edma-v0-core.c
index 33bc1e6c4cf2..c73b9ed1ce74 100644
--- a/drivers/dma/dw-edma/dw-edma-v0-core.c
+++ b/drivers/dma/dw-edma/dw-edma-v0-core.c
@@ -414,19 +414,11 @@ void dw_edma_v0_core_start(struct dw_edma_chunk *chunk, bool first)
 		SET_CH_32(dw, chan->dir, chan->id, ch_control1,
 			  (DW_EDMA_V0_CCS | DW_EDMA_V0_LLE));
 		/* Linked list */
-
-		#ifdef CONFIG_64BIT
 		/* llp is not aligned on 64bit -> keep 32bit accesses */
 		SET_CH_32(dw, chan->dir, chan->id, llp.lsb,
 			  lower_32_bits(chunk->ll_region.paddr));
 		SET_CH_32(dw, chan->dir, chan->id, llp.msb,
 			  upper_32_bits(chunk->ll_region.paddr));
-		#else /* CONFIG_64BIT */
-		SET_CH_32(dw, chan->dir, chan->id, llp.lsb,
-			  lower_32_bits(chunk->ll_region.paddr));
-		SET_CH_32(dw, chan->dir, chan->id, llp.msb,
-			  upper_32_bits(chunk->ll_region.paddr));
-		#endif /* CONFIG_64BIT */
 	}
 	/* Doorbell */
 	SET_RW_32(dw, chan->dir, doorbell,
-- 
2.33.0

