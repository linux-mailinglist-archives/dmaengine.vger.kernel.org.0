Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F1C8F1454B
	for <lists+dmaengine@lfdr.de>; Mon,  6 May 2019 09:30:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726365AbfEFH3Q (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 6 May 2019 03:29:16 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:40607 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726468AbfEFH3L (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 6 May 2019 03:29:11 -0400
Received: by mail-pf1-f195.google.com with SMTP id u17so6280963pfn.7
        for <dmaengine@vger.kernel.org>; Mon, 06 May 2019 00:29:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=211d8ZTQI3btAur7YnSUlr/RUpH4zvR8vL+Saj1rS5o=;
        b=jo3K4Scdrs1k7OvhlUC3Vu6KN+wS+aF0U3qudxCeN/Ts9VlRxCjFMr46/su1MGI9mX
         B0I01reNOOD0ZaHGwco7gr4FJEycBmyHjrgjB07y+GEf+NVM1lLsbzAl3Qr5gulmikdj
         uXIBABZq+91UQZ8NFVIO/bkfFlr7jv0PgZvAemLVWFjoH+9+a3KT7mH1nQuyqXXcZ4w6
         zie4wrpqjqHhXytnykFQHis0Y/66Wq3JVD0ZIiRXGfxkWnCKzWH00MK5kQA4RQ6LQu6t
         8Gj30YLpIu1qPXyFyhtZWQ/cgOeplpaBP5FvMx6XM4wIqI9yM91uhnJjppwLhjkU/a0q
         5bCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=211d8ZTQI3btAur7YnSUlr/RUpH4zvR8vL+Saj1rS5o=;
        b=ezaTgpldTBLC2bxRAzDIdqBdxCjmWcITp4IcI+h0/PAyk1yA9lYc6zPeNH7YpjSk5u
         Icwez9hk6TISEJ65ECWrPLJaI8Mh1bK/gPH5w72icaxCARBFzNbwFVk/g7GRUAR+OZE8
         u7EHtj5dDOKLcg2bY7SBEkM5cdC+QONXOaKlfwVdHdQfmqoHOR7whlPDlaQkOuANbZYX
         RijlECsWm/Ax4kr4OBcxM9Mt/JSWw8YDZXcZsTmeiCTYKyEMLZ5TUOutpw+vRHh/c72z
         CfV58Jrxt2LWX7qb6/1qecMKs+st1cBkFJnqpDlLQ1xr777eaX9FLzNIaR3SvM53HGsm
         wl4Q==
X-Gm-Message-State: APjAAAVbXcXtyuAHRBkForsKxjf5Zeg6q1ayL1voQnvRdDbVSdpGYoxT
        BkgUUmMffhurfSGDRJyopC2IEA==
X-Google-Smtp-Source: APXvYqxuZVpXjI9hNU1TBDdPuWhKxlPJ1PqiM3uimd5q/iX+ojTZItgChQGwubcXQg5brQKglhy9Rw==
X-Received: by 2002:a63:1cf:: with SMTP id 198mr22124192pgb.155.1557127750187;
        Mon, 06 May 2019 00:29:10 -0700 (PDT)
Received: from baolinwangubtpc.spreadtrum.com ([117.18.48.102])
        by smtp.gmail.com with ESMTPSA id w38sm21700894pgk.90.2019.05.06.00.29.07
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 06 May 2019 00:29:09 -0700 (PDT)
From:   Baolin Wang <baolin.wang@linaro.org>
To:     dan.j.williams@intel.com, vkoul@kernel.org
Cc:     eric.long@unisoc.com, orsonzhai@gmail.com, zhang.lyra@gmail.com,
        vincent.guittot@linaro.org, baolin.wang@linaro.org,
        dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 6/6] dmaengine: sprd: Add interrupt support for 2-stage transfer
Date:   Mon,  6 May 2019 15:28:33 +0800
Message-Id: <23f960d05bc30a93fb128cde53ad798cc6c7c19d.1557127239.git.baolin.wang@linaro.org>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <cover.1557127239.git.baolin.wang@linaro.org>
References: <cover.1557127239.git.baolin.wang@linaro.org>
In-Reply-To: <cover.1557127239.git.baolin.wang@linaro.org>
References: <cover.1557127239.git.baolin.wang@linaro.org>
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

For 2-stage transfer, some users like Audio still need transaction interrupt
to notify when the 2-stage transfer is completed. Thus we should enable
2-stage transfer interrupt to support this feature.

Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
---
 drivers/dma/sprd-dma.c |   22 +++++++++++++++++++++-
 1 file changed, 21 insertions(+), 1 deletion(-)

diff --git a/drivers/dma/sprd-dma.c b/drivers/dma/sprd-dma.c
index 01abed5..baac476 100644
--- a/drivers/dma/sprd-dma.c
+++ b/drivers/dma/sprd-dma.c
@@ -62,6 +62,8 @@
 /* SPRD_DMA_GLB_2STAGE_GRP register definition */
 #define SPRD_DMA_GLB_2STAGE_EN		BIT(24)
 #define SPRD_DMA_GLB_CHN_INT_MASK	GENMASK(23, 20)
+#define SPRD_DMA_GLB_DEST_INT		BIT(22)
+#define SPRD_DMA_GLB_SRC_INT		BIT(20)
 #define SPRD_DMA_GLB_LIST_DONE_TRG	BIT(19)
 #define SPRD_DMA_GLB_TRANS_DONE_TRG	BIT(18)
 #define SPRD_DMA_GLB_BLOCK_DONE_TRG	BIT(17)
@@ -135,6 +137,7 @@
 /* define DMA channel mode & trigger mode mask */
 #define SPRD_DMA_CHN_MODE_MASK		GENMASK(7, 0)
 #define SPRD_DMA_TRG_MODE_MASK		GENMASK(7, 0)
+#define SPRD_DMA_INT_TYPE_MASK		GENMASK(7, 0)
 
 /* define the DMA transfer step type */
 #define SPRD_DMA_NONE_STEP		0
@@ -190,6 +193,7 @@ struct sprd_dma_chn {
 	u32			dev_id;
 	enum sprd_dma_chn_mode	chn_mode;
 	enum sprd_dma_trg_mode	trg_mode;
+	enum sprd_dma_int_type	int_type;
 	struct sprd_dma_desc	*cur_desc;
 };
 
@@ -429,6 +433,9 @@ static int sprd_dma_set_2stage_config(struct sprd_dma_chn *schan)
 		val = chn & SPRD_DMA_GLB_SRC_CHN_MASK;
 		val |= BIT(schan->trg_mode - 1) << SPRD_DMA_GLB_TRG_OFFSET;
 		val |= SPRD_DMA_GLB_2STAGE_EN;
+		if (schan->int_type != SPRD_DMA_NO_INT)
+			val |= SPRD_DMA_GLB_SRC_INT;
+
 		sprd_dma_glb_update(sdev, SPRD_DMA_GLB_2STAGE_GRP1, val, val);
 		break;
 
@@ -436,6 +443,9 @@ static int sprd_dma_set_2stage_config(struct sprd_dma_chn *schan)
 		val = chn & SPRD_DMA_GLB_SRC_CHN_MASK;
 		val |= BIT(schan->trg_mode - 1) << SPRD_DMA_GLB_TRG_OFFSET;
 		val |= SPRD_DMA_GLB_2STAGE_EN;
+		if (schan->int_type != SPRD_DMA_NO_INT)
+			val |= SPRD_DMA_GLB_SRC_INT;
+
 		sprd_dma_glb_update(sdev, SPRD_DMA_GLB_2STAGE_GRP2, val, val);
 		break;
 
@@ -443,6 +453,9 @@ static int sprd_dma_set_2stage_config(struct sprd_dma_chn *schan)
 		val = (chn << SPRD_DMA_GLB_DEST_CHN_OFFSET) &
 			SPRD_DMA_GLB_DEST_CHN_MASK;
 		val |= SPRD_DMA_GLB_2STAGE_EN;
+		if (schan->int_type != SPRD_DMA_NO_INT)
+			val |= SPRD_DMA_GLB_DEST_INT;
+
 		sprd_dma_glb_update(sdev, SPRD_DMA_GLB_2STAGE_GRP1, val, val);
 		break;
 
@@ -450,6 +463,9 @@ static int sprd_dma_set_2stage_config(struct sprd_dma_chn *schan)
 		val = (chn << SPRD_DMA_GLB_DEST_CHN_OFFSET) &
 			SPRD_DMA_GLB_DEST_CHN_MASK;
 		val |= SPRD_DMA_GLB_2STAGE_EN;
+		if (schan->int_type != SPRD_DMA_NO_INT)
+			val |= SPRD_DMA_GLB_DEST_INT;
+
 		sprd_dma_glb_update(sdev, SPRD_DMA_GLB_2STAGE_GRP2, val, val);
 		break;
 
@@ -911,11 +927,15 @@ static int sprd_dma_fill_linklist_desc(struct dma_chan *chan,
 		schan->linklist.virt_addr = 0;
 	}
 
-	/* Set channel mode and trigger mode for 2-stage transfer */
+	/*
+	 * Set channel mode, interrupt mode and trigger mode for 2-stage
+	 * transfer.
+	 */
 	schan->chn_mode =
 		(flags >> SPRD_DMA_CHN_MODE_SHIFT) & SPRD_DMA_CHN_MODE_MASK;
 	schan->trg_mode =
 		(flags >> SPRD_DMA_TRG_MODE_SHIFT) & SPRD_DMA_TRG_MODE_MASK;
+	schan->int_type = flags & SPRD_DMA_INT_TYPE_MASK;
 
 	sdesc = kzalloc(sizeof(*sdesc), GFP_NOWAIT);
 	if (!sdesc)
-- 
1.7.9.5

