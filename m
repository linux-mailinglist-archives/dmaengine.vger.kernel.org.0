Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F22E14FC0F5
	for <lists+dmaengine@lfdr.de>; Mon, 11 Apr 2022 17:36:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347942AbiDKPiq (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 11 Apr 2022 11:38:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348032AbiDKPip (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 11 Apr 2022 11:38:45 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 123053A5E7;
        Mon, 11 Apr 2022 08:36:31 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id ay36-20020a05600c1e2400b0038ebc885115so181707wmb.1;
        Mon, 11 Apr 2022 08:36:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=SLNLIgAztxFLrjX98bBOPpDCgmeIBOw+sPwS1eWryvU=;
        b=UOph7iwMAPryYJQM5t3httN8DjoAflSeCVstrwCvqUO6d7fjB9VplSFa6NFvbOzPpr
         QLa/vpR5z6HKRgKYelEPmwdQ7cccpfROAOpDA3XkSj/Sl5A8T9Hoq8XcVaPQTR/ndlaY
         fJg5/SdXmHJOGiGqIXBe+RljbcnYFoHkYbXl6SgcbnpgnZXoBWeNIQoDYOQ9qfkiqIpv
         sVw1nx/1SL5InqcKHO9VF3Z9mm8vhqUyuGpdOuH2FUrSmE0R+rKcB5y42+LL8fuAwC8X
         GdAcRbYhWsGkNAGIZAVhvPzqVnL4sBj9qTPhBTitpGHNHCr57/PPksimidd76wfMJmPa
         irXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=SLNLIgAztxFLrjX98bBOPpDCgmeIBOw+sPwS1eWryvU=;
        b=62La/llz2/4u5ywz4EK1/Ds59azRxGj+iPD+qlQPq6BmF7ERwGzD2T+BJFdel220Bm
         csnrp2pzP17PgJIVI/m55eWMzkECBG04gER5KEkVmC+1lxFxtXPRCqeza66tT2wU88pX
         eQl9liduulV9Eg69obRQK9bX+6l6b4iLmdRhZ6h9w8FVJNpZaQSZNY/94ahLAwaF4KWP
         YahzKmaD6tCxI/WwKkRdOpr/kIMniKkVT6bPTGWspI3reN/7vEnH7Z2+4xD2e9bpGCI9
         EvurmB+q7fTICS3N/e7Ew+u4W3CCVB+eiBUpTwT3imGZclDYh+ulA06Lg42k5KEl04VB
         6MBA==
X-Gm-Message-State: AOAM530qEGeWyVTyY2/Jp8VD/eyQNoSu1XPh0JvV5hUFxjPOaTPBWfC1
        J6KB8G5JPEZqRAJPRIN9qoM=
X-Google-Smtp-Source: ABdhPJy2WtwqxmlMvBMosTiNoX/M+q/nLamP1ovzSDcok06XmYlFBZIDDLcyooBH1QPqt+ZF2Wdy0w==
X-Received: by 2002:a1c:44c5:0:b0:38e:abd1:d894 with SMTP id r188-20020a1c44c5000000b0038eabd1d894mr13177203wma.40.1649691389591;
        Mon, 11 Apr 2022 08:36:29 -0700 (PDT)
Received: from localhost (92.40.202.92.threembb.co.uk. [92.40.202.92])
        by smtp.gmail.com with ESMTPSA id p8-20020a5d4e08000000b002054b5437f2sm26232868wrt.115.2022.04.11.08.36.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Apr 2022 08:36:29 -0700 (PDT)
From:   Aidan MacDonald <aidanmacdonald.0x0@gmail.com>
To:     paul@crapouillou.net, vkoul@kernel.org
Cc:     linux-mips@vger.kernel.org, dmaengine@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] dmaengine: jz4780: set DMA maximum segment size
Date:   Mon, 11 Apr 2022 16:36:18 +0100
Message-Id: <20220411153618.49876-1-aidanmacdonald.0x0@gmail.com>
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

Set the maximum segment size, since the hardware can do transfers larger
than the default 64 KiB returned by dma_get_max_seg_size().

The maximum segment size is limited by the 24-bit transfer count field
in DMA descriptors. The number of bytes is equal to the transfer count
times the transfer size unit, which is selected by the driver based on
the DMA buffer address and length of the transfer. The size unit can be
as small as 1 byte, so set the maximum segment size to 2^24-1 bytes to
ensure the transfer count will not overflow regardless of the size unit
selected by the driver.

Signed-off-by: Aidan MacDonald <aidanmacdonald.0x0@gmail.com>
---
 drivers/dma/dma-jz4780.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/dma/dma-jz4780.c b/drivers/dma/dma-jz4780.c
index fc513eb2b289..e2ec540e6519 100644
--- a/drivers/dma/dma-jz4780.c
+++ b/drivers/dma/dma-jz4780.c
@@ -8,6 +8,7 @@
 
 #include <linux/clk.h>
 #include <linux/dmapool.h>
+#include <linux/dma-mapping.h>
 #include <linux/init.h>
 #include <linux/interrupt.h>
 #include <linux/module.h>
@@ -911,6 +912,14 @@ static int jz4780_dma_probe(struct platform_device *pdev)
 
 	dd = &jzdma->dma_device;
 
+	/*
+	 * The real segment size limit is dependent on the size unit selected
+	 * for the transfer. Because the size unit is selected automatically
+	 * and may be as small as 1 byte, use a safe limit of 2^24-1 bytes to
+	 * ensure the 24-bit transfer count in the descriptor cannot overflow.
+	 */
+	dma_set_max_seg_size(dev, 0xffffff);
+
 	dma_cap_set(DMA_MEMCPY, dd->cap_mask);
 	dma_cap_set(DMA_SLAVE, dd->cap_mask);
 	dma_cap_set(DMA_CYCLIC, dd->cap_mask);
-- 
2.35.1

