Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4E3F3484DC2
	for <lists+dmaengine@lfdr.de>; Wed,  5 Jan 2022 06:44:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237559AbiAEFoY (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 5 Jan 2022 00:44:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237563AbiAEFoW (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 5 Jan 2022 00:44:22 -0500
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26344C061784
        for <dmaengine@vger.kernel.org>; Tue,  4 Jan 2022 21:44:22 -0800 (PST)
Received: by mail-pf1-x432.google.com with SMTP id b22so34211677pfb.5
        for <dmaengine@vger.kernel.org>; Tue, 04 Jan 2022 21:44:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=gYCrjT384T+qCrcrLtXCLy/4eLs5COm+VZcUyniicZE=;
        b=JDBhwI9bbq1as4Sn5NxIQCtQ0iNed6+ByFwf7cjiwad0mZ/9TAZWPe2ZW/hhPyW464
         8T8zu5JqkxOLVyjCLIJ8XCocG23s20vJU5aqlOEmdYyQTNbZ15c2hR1HuQDrSkeZBC4V
         qUemjLC1qYOTfMSDT5g5C07+pbrbKLXngwtKeqTwojZ8ag11mYLKtp6AirbVe6fjlXD/
         vBbz0J5Iuv5eRPdciFg3hM/FnYmim3CV0tznzsYiY0i95IQqjhzSEj9FpvnnjYv3bk5E
         EWIWc+xFATIkNnh+qEqE6I1NswKMGmnhwM0OuxbGbbgcxs1zjdv7MiezAP9XeFHTg6xY
         RSDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=gYCrjT384T+qCrcrLtXCLy/4eLs5COm+VZcUyniicZE=;
        b=IB7KJFaM+kJsaRollXNXWb8RyLs4HAjckYxAeNKLGLYW772BdR6j8PMIvOLA+IGkVl
         iWwD4HKUH2qS9qOfIwdF1d/XajlUY7lE0U6zM2hggjlg1GWrWCJNO5H5TxhgfaJQqjJp
         SI7H5Ay8BF4ZPjsWCbz4hau7RxutiO5s+qFDTPeiv9heW6sZkOWyXYH0Y4zk2CPUZJ6u
         neh6Ah4idPmJDuLl5wMeCVIOoj6YhkspwrUFOV5cbNSt1nr5XymK0i/wgHpr/U+lBOx3
         i6soevgpEk2iRt98I2oCNqK+ViF5ebSg9a5LMUxeeMZRiVF89MaMQEfNLCJOh8uBW+rd
         2uXg==
X-Gm-Message-State: AOAM5305FN5ZjtbqH5OFrAusFemxp7PqQFgO5uLbMmEc/x6ebDZOZMVY
        0zX3CAekuJgyo29YYAvHkra+NQ==
X-Google-Smtp-Source: ABdhPJyyQ0QdcjtQaZ5nXIIXvrOrCVJIoWRS55wSz1V5EQJqDCCp2soZV7ICOR8x08ZwFRrTbCYxsQ==
X-Received: by 2002:a63:b245:: with SMTP id t5mr1475467pgo.231.1641361461670;
        Tue, 04 Jan 2022 21:44:21 -0800 (PST)
Received: from hsinchu16.internal.sifive.com (59-124-168-89.hinet-ip.hinet.net. [59.124.168.89])
        by smtp.gmail.com with ESMTPSA id cu18sm1000574pjb.53.2022.01.04.21.44.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Jan 2022 21:44:21 -0800 (PST)
From:   Zong Li <zong.li@sifive.com>
To:     robh+dt@kernel.org, paul.walmsley@sifive.com, palmer@dabbelt.com,
        aou@eecs.berkeley.edu, krzysztof.kozlowski@canonical.com,
        conor.dooley@microchip.com, geert@linux-m68k.org,
        bin.meng@windriver.com, green.wan@sifive.com, vkoul@kernel.org,
        dmaengine@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org
Cc:     Zong Li <zong.li@sifive.com>
Subject: [PATCH 3/3] dmaengine: sf-pdma: Get number of channel by device tree
Date:   Wed,  5 Jan 2022 13:44:00 +0800
Message-Id: <5a7786cff08d55d0e084cd28bc2800565fa2dce7.1641289490.git.zong.li@sifive.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1641289490.git.zong.li@sifive.com>
References: <cover.1641289490.git.zong.li@sifive.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

It currently assumes that there are four channels by default, it might
cause the error if there is actually less than four channels. Change
that by getting number of channel from device tree.

Signed-off-by: Zong Li <zong.li@sifive.com>
---
 drivers/dma/sf-pdma/sf-pdma.c | 15 +++++++++------
 drivers/dma/sf-pdma/sf-pdma.h |  8 ++------
 2 files changed, 11 insertions(+), 12 deletions(-)

diff --git a/drivers/dma/sf-pdma/sf-pdma.c b/drivers/dma/sf-pdma/sf-pdma.c
index f12606aeff87..c941150fc830 100644
--- a/drivers/dma/sf-pdma/sf-pdma.c
+++ b/drivers/dma/sf-pdma/sf-pdma.c
@@ -484,21 +484,24 @@ static int sf_pdma_probe(struct platform_device *pdev)
 	struct sf_pdma *pdma;
 	struct sf_pdma_chan *chan;
 	struct resource *res;
-	int len, chans;
-	int ret;
+	int len, ret;
 	const enum dma_slave_buswidth widths =
 		DMA_SLAVE_BUSWIDTH_1_BYTE | DMA_SLAVE_BUSWIDTH_2_BYTES |
 		DMA_SLAVE_BUSWIDTH_4_BYTES | DMA_SLAVE_BUSWIDTH_8_BYTES |
 		DMA_SLAVE_BUSWIDTH_16_BYTES | DMA_SLAVE_BUSWIDTH_32_BYTES |
 		DMA_SLAVE_BUSWIDTH_64_BYTES;
 
-	chans = PDMA_NR_CH;
-	len = sizeof(*pdma) + sizeof(*chan) * chans;
+	len = sizeof(*pdma) + sizeof(*chan) * PDMA_MAX_NR_CH;
 	pdma = devm_kzalloc(&pdev->dev, len, GFP_KERNEL);
 	if (!pdma)
 		return -ENOMEM;
 
-	pdma->n_chans = chans;
+	ret = of_property_read_u32(pdev->dev.of_node, "dma-channels",
+				   &pdma->n_chans);
+	if (ret) {
+		dev_err(&pdev->dev, "failed to read dma-channels\n");
+		return ret;
+	}
 
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	pdma->membase = devm_ioremap_resource(&pdev->dev, res);
@@ -556,7 +559,7 @@ static int sf_pdma_remove(struct platform_device *pdev)
 	struct sf_pdma_chan *ch;
 	int i;
 
-	for (i = 0; i < PDMA_NR_CH; i++) {
+	for (i = 0; i < pdma->n_chans; i++) {
 		ch = &pdma->chans[i];
 
 		devm_free_irq(&pdev->dev, ch->txirq, ch);
diff --git a/drivers/dma/sf-pdma/sf-pdma.h b/drivers/dma/sf-pdma/sf-pdma.h
index 0c20167b097d..8127d792f639 100644
--- a/drivers/dma/sf-pdma/sf-pdma.h
+++ b/drivers/dma/sf-pdma/sf-pdma.h
@@ -22,11 +22,7 @@
 #include "../dmaengine.h"
 #include "../virt-dma.h"
 
-#define PDMA_NR_CH					4
-
-#if (PDMA_NR_CH != 4)
-#error "Please define PDMA_NR_CH to 4"
-#endif
+#define PDMA_MAX_NR_CH					4
 
 #define PDMA_BASE_ADDR					0x3000000
 #define PDMA_CHAN_OFFSET				0x1000
@@ -118,7 +114,7 @@ struct sf_pdma {
 	void __iomem            *membase;
 	void __iomem            *mappedbase;
 	u32			n_chans;
-	struct sf_pdma_chan	chans[PDMA_NR_CH];
+	struct sf_pdma_chan	chans[PDMA_MAX_NR_CH];
 };
 
 #endif /* _SF_PDMA_H */
-- 
2.31.1

