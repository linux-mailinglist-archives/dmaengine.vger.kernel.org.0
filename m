Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 06AAF5F0453
	for <lists+dmaengine@lfdr.de>; Fri, 30 Sep 2022 07:54:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229479AbiI3Fyc (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 30 Sep 2022 01:54:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229498AbiI3Fyb (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 30 Sep 2022 01:54:31 -0400
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5468B1FBCAB;
        Thu, 29 Sep 2022 22:54:30 -0700 (PDT)
Received: by mail-pg1-x52a.google.com with SMTP id 3so3328131pga.1;
        Thu, 29 Sep 2022 22:54:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date;
        bh=mMla8qCrMLjnlPkIDgBir+wXYj1Zc/1eiSyiQWCV6G0=;
        b=VNj3Hcn9y0aPmE1nNn973o/skfilArCE60NPJpTpaQkBF7FrZhvwGHfn+MGMNtfgXD
         iTppUJf6FDskwxdnb4OWwp9hUaOHccMHSxok6pFSyBGZ9VzTUEhj23KXrkrPWCMg/ZuK
         N4NeCZ6GetB46nu5UhY9BrVTxIt0WTmryZDsfYQ8I1fPf0kRVg6cliWL3oWHMn2iZwDG
         z5sOk+xT16CBpf8knSzQckrqZ+7xLPq11sY8nZ07NacGyR9N4V2g8NLYbd8yVhjj1l/W
         JjM3YOcP4M94my+4gcB8hK7LX8meBBsycijBM0MgggnI2K3RA951SwSQGr77aenKPXty
         W+4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=mMla8qCrMLjnlPkIDgBir+wXYj1Zc/1eiSyiQWCV6G0=;
        b=XHRoJwtQv0pK9QZ6mCYriR5BHq+ftRN1dxfYBIyJ4K7ORgTjw0zpHwLb7VUudg1dFx
         FuRUbJ1p3Qqccc6/Ikt5EKwFOsVOTvAP/+yXkze3TYoKYoeHSXqpAAFQz4Pw+TkZMW1d
         UPxIWNXo5f7WyB6aZapqG3su6TKa6PwQ/PHnph/WHbTiIerkf6e7Q8+r4IMZzByI8PQ8
         QyTmXM6LInCRLnKoJlENg6MnA/h65YN1OQVOtGqaZJXq77fyItcDQ5AouTmYZU0fwfpQ
         mlifLqtnDRyB6pcsqKFJVjnaV0yE0eNUG6z46YJkl1gom8hGnvgMBsyd/K3tv2vHpiEe
         ETCQ==
X-Gm-Message-State: ACrzQf3xome1Q41jojE7BOBG5lz9trfTh6aB78Vzs6XFPENIWamFTCKc
        SAwdTB1fT2bu2l2h/78enpc=
X-Google-Smtp-Source: AMsMyM4EngzK8I/XurK1P002ilWwL1ClIYaiyIytQlnUCsjsmRry6xZf2+WtosQGW9/E9/pQrfznIQ==
X-Received: by 2002:a05:6a00:24d2:b0:542:f6e3:e18d with SMTP id d18-20020a056a0024d200b00542f6e3e18dmr7086871pfv.36.1664517269750;
        Thu, 29 Sep 2022 22:54:29 -0700 (PDT)
Received: from tj10039pcu.spreadtrum.com ([117.18.48.102])
        by smtp.gmail.com with ESMTPSA id r18-20020a170903411200b00176b84eb29asm896738pld.301.2022.09.29.22.54.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Sep 2022 22:54:29 -0700 (PDT)
From:   Cixi Geng <gengcixi@gmail.com>
To:     vkoul@kernel.org, orsonzhai@gmail.com,
        baolin.wang@linux.alibaba.com, zhang.lyra@gmail.com
Cc:     dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] dmaengine: sprd: Support two-stage dma interrupt
Date:   Fri, 30 Sep 2022 13:53:31 +0800
Message-Id: <20220930055331.138868-1-gengcixi@gmail.com>
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
 drivers/dma/sprd-dma.c       |  8 ++++----
 include/linux/dma/sprd-dma.h | 12 ++++++++++++
 2 files changed, 16 insertions(+), 4 deletions(-)

diff --git a/drivers/dma/sprd-dma.c b/drivers/dma/sprd-dma.c
index 474d3ba8ec9f..7a9ade422a00 100644
--- a/drivers/dma/sprd-dma.c
+++ b/drivers/dma/sprd-dma.c
@@ -441,7 +441,7 @@ static int sprd_dma_set_2stage_config(struct sprd_dma_chn *schan)
 		val = chn & SPRD_DMA_GLB_SRC_CHN_MASK;
 		val |= BIT(schan->trg_mode - 1) << SPRD_DMA_GLB_TRG_OFFSET;
 		val |= SPRD_DMA_GLB_2STAGE_EN;
-		if (schan->int_type != SPRD_DMA_NO_INT)
+		if (schan->int_type != SPRD_DMA_SRC_CHN0_INT)
 			val |= SPRD_DMA_GLB_SRC_INT;
 
 		sprd_dma_glb_update(sdev, SPRD_DMA_GLB_2STAGE_GRP1, val, val);
@@ -451,7 +451,7 @@ static int sprd_dma_set_2stage_config(struct sprd_dma_chn *schan)
 		val = chn & SPRD_DMA_GLB_SRC_CHN_MASK;
 		val |= BIT(schan->trg_mode - 1) << SPRD_DMA_GLB_TRG_OFFSET;
 		val |= SPRD_DMA_GLB_2STAGE_EN;
-		if (schan->int_type != SPRD_DMA_NO_INT)
+		if (schan->int_type != SPRD_DMA_SRC_CHN1_INT)
 			val |= SPRD_DMA_GLB_SRC_INT;
 
 		sprd_dma_glb_update(sdev, SPRD_DMA_GLB_2STAGE_GRP2, val, val);
@@ -461,7 +461,7 @@ static int sprd_dma_set_2stage_config(struct sprd_dma_chn *schan)
 		val = (chn << SPRD_DMA_GLB_DEST_CHN_OFFSET) &
 			SPRD_DMA_GLB_DEST_CHN_MASK;
 		val |= SPRD_DMA_GLB_2STAGE_EN;
-		if (schan->int_type != SPRD_DMA_NO_INT)
+		if (schan->int_type != SPRD_DMA_DST_CHN0_INT)
 			val |= SPRD_DMA_GLB_DEST_INT;
 
 		sprd_dma_glb_update(sdev, SPRD_DMA_GLB_2STAGE_GRP1, val, val);
@@ -471,7 +471,7 @@ static int sprd_dma_set_2stage_config(struct sprd_dma_chn *schan)
 		val = (chn << SPRD_DMA_GLB_DEST_CHN_OFFSET) &
 			SPRD_DMA_GLB_DEST_CHN_MASK;
 		val |= SPRD_DMA_GLB_2STAGE_EN;
-		if (schan->int_type != SPRD_DMA_NO_INT)
+		if (schan->int_type != SPRD_DMA_DST_CHN1_INT)
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

