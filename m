Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A948454B973
	for <lists+dmaengine@lfdr.de>; Tue, 14 Jun 2022 20:59:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358151AbiFNSzC (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 14 Jun 2022 14:55:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358265AbiFNSyr (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 14 Jun 2022 14:54:47 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFF1F289A9;
        Tue, 14 Jun 2022 11:48:03 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id x6-20020a1c7c06000000b003972dfca96cso5279903wmc.4;
        Tue, 14 Jun 2022 11:48:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ZGq6EoefxPbFtF1LY8I5mjem8e38X9O1LMTR9lksIbU=;
        b=eKBKM9FNockAANSZ38+BfFdCvxvuc7vP7DTowuFFVSb/Z3814bLCJz/mn4QVASzwZE
         Jofzjg1eglWhZBYCtnQqsI9C8/gI2oFX7sMVNHe2wa6X+9gE+SAINpsJxkE2H4zuuaen
         Tvc+RhplEeh4mJPviyY9JbbeSixBKrHQQAT0FymDNyo7BcF1rmykEN5OlXyICJFWskWu
         0aac9qOBqpRru9+AOVaM14bA2Hf1blQfOeWjWyhFrIJf7jPq6Fn+v4XMoSFYp/8c1IdM
         gx2ytXQZwgaZW2wj2je0uLjBB8gh/vVBl2e0UY7sVdy9x48N72Ndq67t1bassygknDUo
         r74w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ZGq6EoefxPbFtF1LY8I5mjem8e38X9O1LMTR9lksIbU=;
        b=nXnCjoU0Xl4tnn3vKGjJHQoFDP/UV2iHyuYPlKHKquYlKzNXSGS/b4IZfBfAhPbpH9
         AGjNvaRk7tIBEmY2dcnhHiV85qFvaSpY4qWgFKeInQ56ozNexfqyWxo6HGqSwbM5TKI1
         hPF2ZUnWEPXBC3VW9A41SGn4bRP/TOPqfabOgQzRRyZNQcHTZZaFRSMp2opoioUEQChV
         UQcrILCXXoLRuPBSU6n6i/GmTPk6Sinx4Xf5cCRNPXYzbnnCSaJi7131XKXgO4zBkGVb
         LY/KSjR1OXU2oq6a8sCCh/hcSqJPBn5JY7vPxSMk4UxnIVUGf4rrZy6V/mHfnownd+BI
         Op3A==
X-Gm-Message-State: AOAM531XBnYRnY9UX5IGA3KH1IL3J7FbqMERmcrE60gHphICslU56Fxl
        LMIn+D8terGAur9ixHy+1Y0=
X-Google-Smtp-Source: ABdhPJyN/hZcupEtYYhdwsR7sUr2cuKzMaSiadhh38ZplgCRxmrsH6p5MaUDlH8mYoDwJKflzZQVaQ==
X-Received: by 2002:a05:600c:58a:b0:39c:80ed:68be with SMTP id o10-20020a05600c058a00b0039c80ed68bemr5624291wmd.150.1655232481288;
        Tue, 14 Jun 2022 11:48:01 -0700 (PDT)
Received: from localhost (cpc154979-craw9-2-0-cust193.16-3.cable.virginm.net. [80.193.200.194])
        by smtp.gmail.com with ESMTPSA id d34-20020a05600c4c2200b0039c5b4ab1b0sm12960218wmp.48.2022.06.14.11.47.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jun 2022 11:48:00 -0700 (PDT)
From:   Colin Ian King <colin.i.king@gmail.com>
To:     Vinod Koul <vkoul@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        dmaengine@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] dmaengine: fsl-edma: remove redundant assignment to pointer last_sg
Date:   Tue, 14 Jun 2022 19:47:59 +0100
Message-Id: <20220614184759.164379-1-colin.i.king@gmail.com>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

The pointer last_sg is being assigned a value at the start of a loop
however it is never read and is being re-assigned later on in both
brances of an if-statement. The assignment is redundant and can be
removed.

Cleans up clang scan-build warning:
drivers/dma/fsl-edma-common.c:563:3: warning: Value stored to 'last_sg'
is never read [deadcode.DeadStores]

Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---
 drivers/dma/fsl-edma-common.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/dma/fsl-edma-common.c b/drivers/dma/fsl-edma-common.c
index 3ae05d1446a5..a06a1575a2a5 100644
--- a/drivers/dma/fsl-edma-common.c
+++ b/drivers/dma/fsl-edma-common.c
@@ -559,9 +559,6 @@ struct dma_async_tx_descriptor *fsl_edma_prep_slave_sg(
 	}
 
 	for_each_sg(sgl, sg, sg_len, i) {
-		/* get next sg's physical address */
-		last_sg = fsl_desc->tcd[(i + 1) % sg_len].ptcd;
-
 		if (direction == DMA_MEM_TO_DEV) {
 			src_addr = sg_dma_address(sg);
 			dst_addr = fsl_chan->dma_dev_addr;
-- 
2.35.3

