Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C82274FB166
	for <lists+dmaengine@lfdr.de>; Mon, 11 Apr 2022 03:35:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240938AbiDKBh1 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Sun, 10 Apr 2022 21:37:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239728AbiDKBh0 (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Sun, 10 Apr 2022 21:37:26 -0400
Received: from mail-qt1-x82d.google.com (mail-qt1-x82d.google.com [IPv6:2607:f8b0:4864:20::82d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13B81434AB;
        Sun, 10 Apr 2022 18:35:14 -0700 (PDT)
Received: by mail-qt1-x82d.google.com with SMTP id o18so8062069qtk.7;
        Sun, 10 Apr 2022 18:35:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=5q+TBxfRiuRLiZyvkflF0zE5W4Uud4G5UjolfJsOqO0=;
        b=aJHc+ESMg2kCTb9q/UjaX19bNdhMmz4JmkNQ1u7qZWzwjwHaV8i5rKjcrcrqWM5OgQ
         8B2zoMPVi08dzv+f4p0Ihj8mP3XETqqzfVXcVEf6+S/53MLM3TWyDOx+8SF/T6prdVXV
         d8EKm5ry7SHKNKQl7c/bjneIUkeDFGsEJ+f7O1Sj1r8pi8/MjteUo1W5DE7BOf4Gby5V
         XjUzPDxscEpJX7zP1Kaicpq9FmA5UC5oFMXBb+dnzooaikC1IR4YoH8F+1hq+xVA9aoD
         M6iBZX9ltGQTwGd5Vds9Y7ejATbslqj4Yp77H2aB2oAOfoEM9+mcEZPkravyJtGhZcri
         Y2GA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=5q+TBxfRiuRLiZyvkflF0zE5W4Uud4G5UjolfJsOqO0=;
        b=NmnXvpFbsoW9wDZrbYFdkom4C4DvvuuNWD1x9wKMEf00GIz15p2q/2VQ34cwD7O19B
         XFNca8z1K7RAfCrf8ixCRGEtga1siHzyGXoqBBecpdH2OnzUoCUp2YosYpOog0anNY7i
         D7DHGRiqOqH0eiyuYjIWEbdNqp5J0rWZTYb4zLpJaVTa4VPIibaTmPx7F/hH8zYbbeYp
         s/ST2lRKz6rih+ccWfM68qdBoC5okY/1RYp6z3CJAoYGPmtOyusxKk58dg7qvhFt97jB
         xHAQHpGwgQjlhik4kQGq50dD6D6Az+mB68NXXfoSjOqf0HiDE8RTesE8KctCwiEnPoLb
         0vtA==
X-Gm-Message-State: AOAM53293WLgCjfvLaHrFGTPzhcyfzNZQeLgSHajcmxMsSkq/wy6wm4Q
        PYzGJuyyL9HSGYjTFx7HHcw=
X-Google-Smtp-Source: ABdhPJwTr+7fLDNRrpGR4ByX37LRikwp7wsj/JUZ7U4iu5eTwWsV9A4sWxtRJlIF3JSXzWMd7IDd3Q==
X-Received: by 2002:ac8:5ac9:0:b0:2e0:6cd3:c8a2 with SMTP id d9-20020ac85ac9000000b002e06cd3c8a2mr23444675qtd.302.1649640913252;
        Sun, 10 Apr 2022 18:35:13 -0700 (PDT)
Received: from localhost.localdomain ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id v3-20020a05622a014300b002e1dcd4cfa9sm25475083qtw.64.2022.04.10.18.35.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 Apr 2022 18:35:12 -0700 (PDT)
From:   cgel.zte@gmail.com
X-Google-Original-From: chi.minghao@zte.com.cn
To:     sean.wang@mediatek.com
Cc:     vkoul@kernel.org, matthias.bgg@gmail.com,
        dmaengine@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        Minghao Chi <chi.minghao@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>
Subject: [PATCH] drivers: dma: using pm_runtime_resume_and_get instead of pm_runtime_get_sync
Date:   Mon, 11 Apr 2022 01:35:04 +0000
Message-Id: <20220411013504.2517012-1-chi.minghao@zte.com.cn>
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

Using pm_runtime_resume_and_get is more appropriate
for simplifing code

Reported-by: Zeal Robot <zealci@zte.com.cn>
Signed-off-by: Minghao Chi <chi.minghao@zte.com.cn>
---
 drivers/dma/mediatek/mtk-uart-apdma.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/dma/mediatek/mtk-uart-apdma.c b/drivers/dma/mediatek/mtk-uart-apdma.c
index 375e7e647df6..64bad5681447 100644
--- a/drivers/dma/mediatek/mtk-uart-apdma.c
+++ b/drivers/dma/mediatek/mtk-uart-apdma.c
@@ -274,11 +274,9 @@ static int mtk_uart_apdma_alloc_chan_resources(struct dma_chan *chan)
 	unsigned int status;
 	int ret;
 
-	ret = pm_runtime_get_sync(mtkd->ddev.dev);
-	if (ret < 0) {
-		pm_runtime_put_noidle(chan->device->dev);
+	ret = pm_runtime_resume_and_get(mtkd->ddev.dev);
+	if (ret < 0)
 		return ret;
-	}
 
 	mtk_uart_apdma_write(c, VFF_ADDR, 0);
 	mtk_uart_apdma_write(c, VFF_THRE, 0);
-- 
2.25.1

