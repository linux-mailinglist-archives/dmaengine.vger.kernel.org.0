Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A282E5F3A06
	for <lists+dmaengine@lfdr.de>; Tue,  4 Oct 2022 01:49:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229719AbiJCXtl (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 3 Oct 2022 19:49:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229785AbiJCXti (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 3 Oct 2022 19:49:38 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56046F11;
        Mon,  3 Oct 2022 16:49:36 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id l1-20020a17090a72c100b0020a6949a66aso6861364pjk.1;
        Mon, 03 Oct 2022 16:49:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date;
        bh=/ZQE0YbM8oJFf6SDRAjLR/KlVyZ+VBklnPQhHMDfHtw=;
        b=AXxzzQlyi+5KPKgsQpKw4F84h3e2xpPElB8JlXcGeggmeEyuV1urIU7SPqYi0sRxCx
         zbtovl4ewse9Cm+PTzL245nRuSKdhax0QTGIynKzzN5uKwC9N+OyfzSK8C72BcEV20cF
         EW6qwF7OuGj7oYU5L2yAnVsmilxxqJ5BuxUzlUaqM1/lr1PIMp0dswuCW80BNUvgUdnt
         LXz4t3fw9cmcFS4wfmjmYFmZnNhHuMIZYLIYmqskLBn9IGE3QNAaywGj8P7cJxSIGZeB
         dUrVvxlhVHcq4LfCJ9aKhAiLWdpifRr3v1V8P4YugszjzGFrHEuyAmkS5Y49Iy8JCBx7
         pTHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=/ZQE0YbM8oJFf6SDRAjLR/KlVyZ+VBklnPQhHMDfHtw=;
        b=eZw6rrJUGoWw+zDvh9VhRYEjRGbKkKgclDYrFQ9obBIL/onLeHp8rrgoeysISujvv5
         PfmL2h01NHnqOIlgBDXx63sRMc37Ylt7L1S22luDQQqbXCTwbZ25MwvVdd+4fottrX8C
         jG1FdrB25qubWTaIoxv4u5oCbH8550e+3CO9jz11mxF9VyemOpcI/rdKEh145S1liYdx
         dPD9/BGOL9FbdGryVfvtYTm2vzgtPnAT0OKcJIc1cL4PhpNkCob59xdJXmkevzAiokQh
         Vcd0EAzsx0dhaL0Pyyrvjm3RQn9vfy7CeJcoaPeLwNzTNhiIcavfdP125sFJuZXeCFRt
         1lqw==
X-Gm-Message-State: ACrzQf1qP+H4XvKEwukq/YUXHgR8hOjjwXSyHCZuQWVPP+xL0jr8QtA0
        czK6VHp+28lluEjkSvOA9QUHVmR20mBIsg==
X-Google-Smtp-Source: AMsMyM4kn3UFmouWshuWHZz3pcs99JFje10bKlPCJRDn/nTctJStRY/44QFEjEBxHvtdPLwvpF3Iqw==
X-Received: by 2002:a17:90b:3c90:b0:20a:b964:b879 with SMTP id pv16-20020a17090b3c9000b0020ab964b879mr4629613pjb.52.1664840975523;
        Mon, 03 Oct 2022 16:49:35 -0700 (PDT)
Received: from localhost ([180.212.64.244])
        by smtp.gmail.com with ESMTPSA id y19-20020a626413000000b0056006908c65sm5146141pfb.157.2022.10.03.16.49.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Oct 2022 16:49:35 -0700 (PDT)
From:   Cixi Geng <gengcixi@gmail.com>
To:     vkoul@kernel.org, orsonzhai@gmail.com,
        baolin.wang@linux.alibaba.com, zhang.lyra@gmail.com
Cc:     dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
        Cixi Geng <cixi.geng1@unisoc.com>
Subject: [PATCH V2] dmaengine: sprd: Support two-stage dma interrupt
Date:   Tue,  4 Oct 2022 07:49:29 +0800
Message-Id: <20221003234929.186290-1-gengcixi@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

From: Cixi Geng <cixi.geng1@unisoc.com>

Audio need to request Audio CP global dma interrupt, so Audio CP
DMA should support two-stage interrupt to adapte it.
It will occur interrupt when two-stage dma channel transfer done.

Signed-off-by: Cixi Geng <cixi.geng1@unisoc.com>
---
Changes in v2:
  fix the condition of 2stage_config config for each channel interrupt.

 drivers/dma/sprd-dma.c       |  8 ++++----
 include/linux/dma/sprd-dma.h | 12 ++++++++++++
 2 files changed, 16 insertions(+), 4 deletions(-)

diff --git a/drivers/dma/sprd-dma.c b/drivers/dma/sprd-dma.c
index 474d3ba8ec9f..dbcfa340a40f 100644
--- a/drivers/dma/sprd-dma.c
+++ b/drivers/dma/sprd-dma.c
@@ -441,7 +441,7 @@ static int sprd_dma_set_2stage_config(struct sprd_dma_chn *schan)
 		val = chn & SPRD_DMA_GLB_SRC_CHN_MASK;
 		val |= BIT(schan->trg_mode - 1) << SPRD_DMA_GLB_TRG_OFFSET;
 		val |= SPRD_DMA_GLB_2STAGE_EN;
-		if (schan->int_type != SPRD_DMA_NO_INT)
+		if (schan->int_type & SPRD_DMA_SRC_CHN0_INT)
 			val |= SPRD_DMA_GLB_SRC_INT;
 
 		sprd_dma_glb_update(sdev, SPRD_DMA_GLB_2STAGE_GRP1, val, val);
@@ -451,7 +451,7 @@ static int sprd_dma_set_2stage_config(struct sprd_dma_chn *schan)
 		val = chn & SPRD_DMA_GLB_SRC_CHN_MASK;
 		val |= BIT(schan->trg_mode - 1) << SPRD_DMA_GLB_TRG_OFFSET;
 		val |= SPRD_DMA_GLB_2STAGE_EN;
-		if (schan->int_type != SPRD_DMA_NO_INT)
+		if (schan->int_type & SPRD_DMA_SRC_CHN1_INT)
 			val |= SPRD_DMA_GLB_SRC_INT;
 
 		sprd_dma_glb_update(sdev, SPRD_DMA_GLB_2STAGE_GRP2, val, val);
@@ -461,7 +461,7 @@ static int sprd_dma_set_2stage_config(struct sprd_dma_chn *schan)
 		val = (chn << SPRD_DMA_GLB_DEST_CHN_OFFSET) &
 			SPRD_DMA_GLB_DEST_CHN_MASK;
 		val |= SPRD_DMA_GLB_2STAGE_EN;
-		if (schan->int_type != SPRD_DMA_NO_INT)
+		if (schan->int_type & SPRD_DMA_DST_CHN0_INT)
 			val |= SPRD_DMA_GLB_DEST_INT;
 
 		sprd_dma_glb_update(sdev, SPRD_DMA_GLB_2STAGE_GRP1, val, val);
@@ -471,7 +471,7 @@ static int sprd_dma_set_2stage_config(struct sprd_dma_chn *schan)
 		val = (chn << SPRD_DMA_GLB_DEST_CHN_OFFSET) &
 			SPRD_DMA_GLB_DEST_CHN_MASK;
 		val |= SPRD_DMA_GLB_2STAGE_EN;
-		if (schan->int_type != SPRD_DMA_NO_INT)
+		if (schan->int_type & SPRD_DMA_DST_CHN1_INT)
 			val |= SPRD_DMA_GLB_DEST_INT;
 
 		sprd_dma_glb_update(sdev, SPRD_DMA_GLB_2STAGE_GRP2, val, val);
diff --git a/include/linux/dma/sprd-dma.h b/include/linux/dma/sprd-dma.h
index d09c6f6f6da5..26de41d6d915 100644
--- a/include/linux/dma/sprd-dma.h
+++ b/include/linux/dma/sprd-dma.h
@@ -101,6 +101,14 @@ enum sprd_dma_req_mode {
  * is done.
  * @SPRD_DMA_CFGERR_INT: configure error interrupt when configuration is
  * incorrect.
+ * @SPRD_DMA_SRC_CHN0_INT: interrupt occurred when source channel0
+ * transfer is done.
+ * @SPRD_DMA_SRC_CHN1_INT: interrupt occurred when source channel1
+ * transfer is done.
+ * @SPRD_DMA_DST_CHN0_INT: interrupt occurred when destination channel0
+ * transfer is done.
+ * @SPRD_DMA_DST_CHN1_INT: interrupt occurred when destination channel1
+ * transfer is done.
  */
 enum sprd_dma_int_type {
 	SPRD_DMA_NO_INT,
@@ -112,6 +120,10 @@ enum sprd_dma_int_type {
 	SPRD_DMA_TRANS_BLK_INT,
 	SPRD_DMA_LIST_INT,
 	SPRD_DMA_CFGERR_INT,
+	SPRD_DMA_SRC_CHN0_INT,
+	SPRD_DMA_SRC_CHN1_INT,
+	SPRD_DMA_DST_CHN0_INT,
+	SPRD_DMA_DST_CHN1_INT,
 };
 
 /*
-- 
2.34.1

