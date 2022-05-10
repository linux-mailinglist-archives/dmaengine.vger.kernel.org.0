Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4FE3D522142
	for <lists+dmaengine@lfdr.de>; Tue, 10 May 2022 18:31:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347393AbiEJQfV (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 10 May 2022 12:35:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347410AbiEJQfV (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 10 May 2022 12:35:21 -0400
Received: from mail-oa1-x2b.google.com (mail-oa1-x2b.google.com [IPv6:2001:4860:4864:20::2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B560E2638;
        Tue, 10 May 2022 09:31:23 -0700 (PDT)
Received: by mail-oa1-x2b.google.com with SMTP id 586e51a60fabf-d39f741ba0so18889988fac.13;
        Tue, 10 May 2022 09:31:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=l5yuYOcXtxFPnT+hSOFk4R+Wx1UD+Dnz+QCt4jIhDJw=;
        b=LmrWGeBWEt6za4DxWeML4RnphfpC9X2RedlPwpf/mArpHbqUS9knZIfSxU2FfRBeU7
         OFNM+DDKRUBZOyWmZFj1NPwnSfyWJQzS2aLsA6fkj8RZCSCpNrF7lydudkAAS74mFeyl
         eBbkxGlw6ULkxDP0ASKghMeyYYnZQnTGWPo2rN5/xGUWUf3c80FO4fM/MUZHNyKHYiiM
         8JPM1MDtA/BI8R0ZpgK/8bjkE07CsZGA/gc3lZkpHvbOzvd7CGHUwNM9aWqaSRCCMAsB
         nRNcdH1ivhlhf8jQ/AsjDlEnM005SWpK2Ulon5PQPtBZGph1ZXMZZgTePyWpgUyzV6kR
         +3UA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=l5yuYOcXtxFPnT+hSOFk4R+Wx1UD+Dnz+QCt4jIhDJw=;
        b=fajTqIeclH0gDgxEJuxNLqiuOexL6eSwxbOOz7Cw+6S7zwW0cVFMB3MvYBrOJMQkvE
         Gb+bCbIs7hDLH4BoO7o/BL41h4GPZ1JLm50sQWIQl5q8vI82ZaoD0b6zT4V6hzjeKK4B
         p3zSS9tU30HFuK8DIaiIkdCwA6FTc6jm5BqTvwXJ1Eio2CHKw2aNYBHx0+XSTx3d8Ius
         9Ig3P9tvpm0+Zinu5MD/D1zX+ndPCzTV9t3VWTsPMHZw4JrJ0nXTNqeIgVTrph53u+Gy
         awWvlS0bnJfi4gY25gHjtD+t0tIz7V5/wrRhi42NDz/Mp5zJH2EH8qjM3opcBcgmGKVd
         vCIg==
X-Gm-Message-State: AOAM5329SkzjCucRCjKUhKmXz3BjWJXwp+vXg3zAVmxH65EO2L417cM1
        XPnG6JBrFB6qzh9EVDJMjg==
X-Google-Smtp-Source: ABdhPJwpO40ipWzNEk3kXh2782CfFm6Rqcu6mb2kcWt3XIrWXGjjupQQO9kDGk7dRvWzajrm+/u0Ww==
X-Received: by 2002:a05:6870:f149:b0:de:e873:4a46 with SMTP id l9-20020a056870f14900b000dee8734a46mr506532oac.286.1652200282912;
        Tue, 10 May 2022 09:31:22 -0700 (PDT)
Received: from localhost.localdomain (072-177-087-193.res.spectrum.com. [72.177.87.193])
        by smtp.gmail.com with ESMTPSA id k2-20020a056870570200b000edae17a8cesm5815755oap.3.2022.05.10.09.31.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 May 2022 09:31:22 -0700 (PDT)
From:   Ruiqi Li <guywithanaxe42@gmail.com>
To:     gustavo.pimentel@synopsys.com, vkoul@kernel.org,
        dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Ruiqi Li <guywithanaxe42@gmail.com>
Subject: [PATCH 1/1] dmaengine: dw-edma: Removed redundant #ifdef check for 64-bit
Date:   Tue, 10 May 2022 11:31:17 -0500
Message-Id: <20220510163117.1761625-1-guywithanaxe42@gmail.com>
X-Mailer: git-send-email 2.36.1
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

Commit at 8fc5133d fixed unaligned memory access, which caused both 32
and 64 bit to be the same.

    #ifdef CONFIG_64BIT
    /* llp is not aligned on 64bit -> keep 32bit accesses */
    SET_CH_32(dw, chan->dir, chan->id, llp.lsb,
              lower_32_bits(chunk->ll_region.paddr));
    SET_CH_32(dw, chan->dir, chan->id, llp.msb,
              upper_32_bits(chunk->ll_region.paddr));
    #else /* CONFIG_64BIT */
    SET_CH_32(dw, chan->dir, chan->id, llp.lsb,
              lower_32_bits(chunk->ll_region.paddr));
    SET_CH_32(dw, chan->dir, chan->id, llp.msb,
              upper_32_bits(chunk->ll_region.paddr));
    #endif /* CONFIG_64BIT */

This patch removes redundant preprocessor check for 64 bit.

Signed-off-by: Ruiqi Li <guywithanaxe42@gmail.com>
---
 drivers/dma/dw-edma/dw-edma-v0-core.c | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/drivers/dma/dw-edma/dw-edma-v0-core.c b/drivers/dma/dw-edma/dw-edma-v0-core.c
index 33bc1e6c4cf2..d34f344a094b 100644
--- a/drivers/dma/dw-edma/dw-edma-v0-core.c
+++ b/drivers/dma/dw-edma/dw-edma-v0-core.c
@@ -415,18 +415,11 @@ void dw_edma_v0_core_start(struct dw_edma_chunk *chunk, bool first)
 			  (DW_EDMA_V0_CCS | DW_EDMA_V0_LLE));
 		/* Linked list */
 
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
2.36.1

