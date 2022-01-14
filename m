Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 96EA548E745
	for <lists+dmaengine@lfdr.de>; Fri, 14 Jan 2022 10:18:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239791AbiANJR7 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 14 Jan 2022 04:17:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239790AbiANJR6 (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 14 Jan 2022 04:17:58 -0500
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DF80C06161C
        for <dmaengine@vger.kernel.org>; Fri, 14 Jan 2022 01:17:58 -0800 (PST)
Received: by mail-pl1-x631.google.com with SMTP id b3so3706103plc.7
        for <dmaengine@vger.kernel.org>; Fri, 14 Jan 2022 01:17:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=UnDHOgPgHxrpEfq7DGKwHo/JXpf5Q25m6hL15BhwKxo=;
        b=niPVQetGLY/pUlNg30eKEQ/IYzZi4OmcTVvIzI0ERhmfvbGC8tWx782CbK2myBiWXh
         dmzulVUdZMrKW47do7EuMg6wUDNXv71UCjEbNTFKIO7SdOeIfCSjmqWv4+plJOE/2Nki
         1tOU3eImAfPdcEO1IzToFlneunoUKpMmvlBmlJ7dgLSJH7kcJhSac2WMRzTksKJuDVX2
         xUP74Td3sketHGJhWiqo4o6+yymg+fw4M+AqLdaPMbqrD33oyirXdSaROio6fM7YpQJm
         Q27snM7DzwdyrU632YbM8zvumymhdPZ1W/tiNff6HxXyn/bKh0VlSM1XUyb7673CULw7
         FSMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=UnDHOgPgHxrpEfq7DGKwHo/JXpf5Q25m6hL15BhwKxo=;
        b=bi3E7pzHPsLB58t49Ze60uMLVM0dNIISQNII7rJX/qOK55h8jGBNgeFClXt/xVHZEL
         plUGoB7tv8lvmzGE/rU3rVgNmdF8LYpI0vsTxCuN2hr//xtYkbsIgb5ZnQESAacFwUC7
         Vx+o8o64dHZVyI4ymrLEUSdp3dCbceDC547jbuzs+gVFT/98Ag46KvYpvNkSuQ6bmHYf
         ItokHImkPhaKmN2RPcljOZ7A+OLhnsu2ewU/2CvQwzBpkkeRHZioh38RcGKNipsiWge+
         ZAMizzj/wzlLLfIKK93eUJiBvS7wdF0CEwEqEJUFVR18pokmppuEYC7gVey6mUbGMsHC
         zjLw==
X-Gm-Message-State: AOAM533IA7War0nm0YBDe1cS9wAgTmms13gEcuTiAqQwXOvwAEA0WMCx
        IbFcTaxT+u1Ov2eP4Glp02ZLBg==
X-Google-Smtp-Source: ABdhPJyzg2ZT4GxwLjdse984P77qAjIRC7yU7HACLQpYCuRh79FQtcfOgBxIrntqjqdoRZkaHFHl3Q==
X-Received: by 2002:a17:90a:3846:: with SMTP id l6mr19256262pjf.7.1642151877575;
        Fri, 14 Jan 2022 01:17:57 -0800 (PST)
Received: from hsinchu16.internal.sifive.com (59-124-168-89.hinet-ip.hinet.net. [59.124.168.89])
        by smtp.gmail.com with ESMTPSA id z3sm4237179pgc.45.2022.01.14.01.17.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Jan 2022 01:17:57 -0800 (PST)
From:   Zong Li <zong.li@sifive.com>
To:     robh+dt@kernel.org, paul.walmsley@sifive.com, palmer@dabbelt.com,
        aou@eecs.berkeley.edu, krzysztof.kozlowski@canonical.com,
        conor.dooley@microchip.com, geert@linux-m68k.org,
        bin.meng@windriver.com, green.wan@sifive.com, vkoul@kernel.org,
        dmaengine@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org
Cc:     Zong Li <zong.li@sifive.com>
Subject: [PATCH v3 3/3] dmaengine: sf-pdma: Get number of channel by device tree
Date:   Fri, 14 Jan 2022 17:17:41 +0800
Message-Id: <91a8fb6dff811b36db951ee98d955ad14a2a30eb.1642151791.git.zong.li@sifive.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1642151791.git.zong.li@sifive.com>
References: <cover.1642151791.git.zong.li@sifive.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

It currently assumes that there are always four channels, it would
cause the error if there is actually less than four channels. Change
that by getting number of channel from device tree.

For backwards-compatible, it uses the default value (i.e. 4) when there
is no 'dma-channels' information in dts.

Signed-off-by: Zong Li <zong.li@sifive.com>
---
 drivers/dma/sf-pdma/Makefile  |  2 ++
 drivers/dma/sf-pdma/sf-pdma.c | 20 +++++++++++++-------
 drivers/dma/sf-pdma/sf-pdma.h |  8 ++------
 3 files changed, 17 insertions(+), 13 deletions(-)

diff --git a/drivers/dma/sf-pdma/Makefile b/drivers/dma/sf-pdma/Makefile
index 764552ab8d0a..cf1daff7e445 100644
--- a/drivers/dma/sf-pdma/Makefile
+++ b/drivers/dma/sf-pdma/Makefile
@@ -1 +1,3 @@
 obj-$(CONFIG_SF_PDMA)   += sf-pdma.o
+
+CFLAGS_sf-pdma.o += -O0
diff --git a/drivers/dma/sf-pdma/sf-pdma.c b/drivers/dma/sf-pdma/sf-pdma.c
index f12606aeff87..1264add9897e 100644
--- a/drivers/dma/sf-pdma/sf-pdma.c
+++ b/drivers/dma/sf-pdma/sf-pdma.c
@@ -482,9 +482,7 @@ static void sf_pdma_setup_chans(struct sf_pdma *pdma)
 static int sf_pdma_probe(struct platform_device *pdev)
 {
 	struct sf_pdma *pdma;
-	struct sf_pdma_chan *chan;
 	struct resource *res;
-	int len, chans;
 	int ret;
 	const enum dma_slave_buswidth widths =
 		DMA_SLAVE_BUSWIDTH_1_BYTE | DMA_SLAVE_BUSWIDTH_2_BYTES |
@@ -492,13 +490,21 @@ static int sf_pdma_probe(struct platform_device *pdev)
 		DMA_SLAVE_BUSWIDTH_16_BYTES | DMA_SLAVE_BUSWIDTH_32_BYTES |
 		DMA_SLAVE_BUSWIDTH_64_BYTES;
 
-	chans = PDMA_NR_CH;
-	len = sizeof(*pdma) + sizeof(*chan) * chans;
-	pdma = devm_kzalloc(&pdev->dev, len, GFP_KERNEL);
+	pdma = devm_kzalloc(&pdev->dev, sizeof(*pdma), GFP_KERNEL);
 	if (!pdma)
 		return -ENOMEM;
 
-	pdma->n_chans = chans;
+	ret = of_property_read_u32(pdev->dev.of_node, "dma-channels",
+				   &pdma->n_chans);
+	if (ret) {
+		dev_notice(&pdev->dev, "set number of channels to default value: 4\n");
+		pdma->n_chans = PDMA_MAX_NR_CH;
+	}
+
+	if (pdma->n_chans > PDMA_MAX_NR_CH) {
+		dev_err(&pdev->dev, "the number of channels exceeds the maximum\n");
+		return -EINVAL;
+	}
 
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	pdma->membase = devm_ioremap_resource(&pdev->dev, res);
@@ -556,7 +562,7 @@ static int sf_pdma_remove(struct platform_device *pdev)
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

