Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4CF934D2879
	for <lists+dmaengine@lfdr.de>; Wed,  9 Mar 2022 06:34:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229524AbiCIFfn (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 9 Mar 2022 00:35:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229502AbiCIFfm (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 9 Mar 2022 00:35:42 -0500
Received: from mail-qk1-x732.google.com (mail-qk1-x732.google.com [IPv6:2607:f8b0:4864:20::732])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 237131480F4;
        Tue,  8 Mar 2022 21:34:44 -0800 (PST)
Received: by mail-qk1-x732.google.com with SMTP id c7so936135qka.7;
        Tue, 08 Mar 2022 21:34:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=eEOiHkHLw1HT7AI83/RNoNHRJV8b25WUhn8TCsdl8iw=;
        b=MLzta2Ud4ZYjpzEm9qBps4Ic1bwLSV2sHprzrery/2uH9yyBBgO5gyO6Q6WWTA/uqz
         v9+4b/QY2khNUDS5o+6xVYBlTJfpYBcbhU39r26BaQSfVNybUv8YqjOvzx/A694pgmAl
         GJUCJb8fl2v4VoyQU2TsaIvWpPBMP/hRzDmCWuWXJ6xIAr1UIMoTnWkeeHbDPnecqmv4
         rd1yWB0AAQL1gV0P5k/exMR78XeoipWVvrwja3DWP25EK0EgKGMfFMDJeAUUH3zTix7T
         2w6C/omXTGiSZT3BugY1tkcbOHknDIsjcUVzmfmKsttgOp6flGcKXMuuIow49ArqIgI5
         gpsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=eEOiHkHLw1HT7AI83/RNoNHRJV8b25WUhn8TCsdl8iw=;
        b=01KbuAZRSYXKheRUqp7dG75Hqvb+pYmQ+26Lx8AiR0Gq1MSOLaAfLokgGm4FihBQAb
         XJFnF7q8vmWwpkk8NafBdBnGOC1gY08Ctc5Am9VFrkMTJGfVxIcYYkRrmd9MJBHqiT78
         9GQC2pBvvdH2n8ye7U51zaemFKBvNj8Kdoy9JVIfH5L8skc1FKb5WCKUWPikUN1HlxSM
         kFhn8OsFO0Ej5Oh/R1LFg3ZJ3ZFen+SDysQV5nYPuU1B0OYhossIOAK+RfDR8ZZNMGPE
         3c73xj4LVjHH0lNmn+JNTRO2gxYj6lSOhYzxVcEwlffyT4TRRn+DJxpPmew7z7VSAa62
         GXCg==
X-Gm-Message-State: AOAM533/jSou5dcJ3eNHQHQKQqtPn2kocWxX7RNWB3U3A/zD/sBJ6cI0
        ZBDveUM6fc5xVSmFVEzJsVs=
X-Google-Smtp-Source: ABdhPJz6MrSiIRkLEG2ik06dKmSz8fLFV7GhsXEvrJMqJtuAUqIyHx/nnW2rnOLYMQLguq0jOIGgNg==
X-Received: by 2002:a05:620a:24d6:b0:67a:f179:984a with SMTP id m22-20020a05620a24d600b0067af179984amr11963508qkn.474.1646804083270;
        Tue, 08 Mar 2022 21:34:43 -0800 (PST)
Received: from localhost.localdomain ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id 186-20020a370cc3000000b0067d36e3481dsm302003qkm.17.2022.03.08.21.34.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Mar 2022 21:34:42 -0800 (PST)
From:   cgel.zte@gmail.com
X-Google-Original-From: chi.minghao@zte.com.cn
To:     sean.wang@mediatek.com
Cc:     vkoul@kernel.org, matthias.bgg@gmail.com,
        dmaengine@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        Minghao Chi <chi.minghao@zte.com.cn>
Subject: [PATCH] dmaengine: mediatek: mtk-hsdma: Use platform_get_irq() to get the interrupt
Date:   Wed,  9 Mar 2022 05:34:36 +0000
Message-Id: <20220309053436.2081066-1-chi.minghao@zte.com.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
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

From: Minghao Chi <chi.minghao@zte.com.cn>

It is not recommened to use platform_get_resource(pdev, IORESOURCE_IRQ)
for requesting IRQ's resources any more, as they can be not ready yet in
case of DT-booting.

platform_get_irq() instead is a recommended way for getting IRQ even if
it was not retrieved earlier.

It also makes code simpler because we're getting "int" value right away
and no conversion from resource to int is required.

Signed-off-by: Minghao Chi <chi.minghao@zte.com.cn>
---
 drivers/dma/mediatek/mtk-hsdma.c | 14 ++++++--------
 1 file changed, 6 insertions(+), 8 deletions(-)

diff --git a/drivers/dma/mediatek/mtk-hsdma.c b/drivers/dma/mediatek/mtk-hsdma.c
index 6ad8afbb95f2..d04d09016e83 100644
--- a/drivers/dma/mediatek/mtk-hsdma.c
+++ b/drivers/dma/mediatek/mtk-hsdma.c
@@ -897,7 +897,7 @@ static int mtk_hsdma_probe(struct platform_device *pdev)
 	struct mtk_hsdma_vchan *vc;
 	struct dma_device *dd;
 	struct resource *res;
-	int i, err;
+	int i, err, irq;
 
 	hsdma = devm_kzalloc(&pdev->dev, sizeof(*hsdma), GFP_KERNEL);
 	if (!hsdma)
@@ -923,13 +923,11 @@ static int mtk_hsdma_probe(struct platform_device *pdev)
 		return PTR_ERR(hsdma->clk);
 	}
 
-	res = platform_get_resource(pdev, IORESOURCE_IRQ, 0);
-	if (!res) {
-		dev_err(&pdev->dev, "No irq resource for %s\n",
-			dev_name(&pdev->dev));
-		return -EINVAL;
-	}
-	hsdma->irq = res->start;
+	irq = platform_get_irq(pdev, 0);
+	if (irq < 0)
+		return irq;
+
+	hsdma->irq = irq;
 
 	refcount_set(&hsdma->pc_refcnt, 0);
 	spin_lock_init(&hsdma->lock);
-- 
2.25.1

