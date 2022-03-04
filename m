Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 760DE4CD057
	for <lists+dmaengine@lfdr.de>; Fri,  4 Mar 2022 09:43:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234793AbiCDIoC (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 4 Mar 2022 03:44:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233982AbiCDIoB (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 4 Mar 2022 03:44:01 -0500
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A257E66FB1
        for <dmaengine@vger.kernel.org>; Fri,  4 Mar 2022 00:43:13 -0800 (PST)
Received: by mail-pg1-x52f.google.com with SMTP id 6so2407042pgg.0
        for <dmaengine@vger.kernel.org>; Fri, 04 Mar 2022 00:43:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=SjzY9j/Keh5kcP1plUzMyATlCp3344jlI/9GvjcvYoo=;
        b=hJspy1/zqbuYIy7Y0JcXpLgEZ4LaeXRf1V/d38KWyaUJxyyIsgFJrTx+GbgWmAVdoM
         nSIZCT+jRFS4ipOU7erO7Dvrn8u7624EbHpI+KnD82BuAbScaajWmVpaCmCFyaQ+B7jI
         fT6+vcxHFNEHa1caSdXwzgOfeobfiVLFSQXwyMSUxpa+MIZhnOI2tiLeBQu4LB4hgrBW
         q4fpQzAbmpQFanBjQg3QSM5wLpx49uFzRH6JVZda6B0w2tP0Ga9WIG64eFB3ZFceNaYX
         5pSSUZt6Yr3agxSoXN5ImRQs4jXC3AIILRyoSUyMseEUsPRZA+90V61UHGD/fw6zQf8T
         TI4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=SjzY9j/Keh5kcP1plUzMyATlCp3344jlI/9GvjcvYoo=;
        b=vv5gBE64Gws9H1XWQw/IjH/GSViRfHdH7lqie0vsGNc0AeAGBEWUOxW83kub7YkZdA
         r3K3SD4gLdL80ZMc5nEBGB6Pc5e31gZ0VVkw+6lpV1vX+HuC0yuZAup2LViI+pmb7tYf
         yCfaus155TfHvPWDoNF1ahdLbEN7U6dscJA/XAPnnvDssvSuiPcFcaEDiXIjTgamoE1d
         1k+oiKUoKJGAXmz8VSA5Q6ejltcvzK9trW1g1SLqBCS/6QnQFeJQvqYLbfJqnEl8ShDz
         jw97Qr6KdtwWwOoyS0HQru9tl/hp5M80TB0zjXbT8Tvn+i3IfYxO1jZMCIT2VPgurJGQ
         zQ4A==
X-Gm-Message-State: AOAM531Z0AdffcGWJj7PcRGQOg5YBmEfuwYT1kz/BNlnej65DYktnm5V
        a5V0xEe1eyyIdw/kx3i7a46jzA==
X-Google-Smtp-Source: ABdhPJxz6/k/qi7D2lE+uC+vHsr6OFEJAKnQEm3xgi1poTgu0ti/Snnmg4f5psDZA2jmuoST/mcY6A==
X-Received: by 2002:a63:dc11:0:b0:37c:942d:cff0 with SMTP id s17-20020a63dc11000000b0037c942dcff0mr2170447pgg.484.1646383393169;
        Fri, 04 Mar 2022 00:43:13 -0800 (PST)
Received: from hsinchu16.internal.sifive.com (59-124-168-89.hinet-ip.hinet.net. [59.124.168.89])
        by smtp.gmail.com with ESMTPSA id mu1-20020a17090b388100b001bedddf2000sm4245191pjb.14.2022.03.04.00.43.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Mar 2022 00:43:12 -0800 (PST)
From:   Zong Li <zong.li@sifive.com>
To:     robh+dt@kernel.org, paul.walmsley@sifive.com, palmer@dabbelt.com,
        aou@eecs.berkeley.edu, krzysztof.kozlowski@canonical.com,
        conor.dooley@microchip.com, geert@linux-m68k.org,
        bin.meng@windriver.com, green.wan@sifive.com, vkoul@kernel.org,
        dmaengine@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org
Cc:     Zong Li <zong.li@sifive.com>, Palmer Dabbelt <palmer@rivosinc.com>
Subject: [PATCH v6 3/3] dmaengine: sf-pdma: Get number of channel by device tree
Date:   Fri,  4 Mar 2022 16:42:57 +0800
Message-Id: <5d5bb0c13cee78210e4fd1ce80e23127304e1825.1646383150.git.zong.li@sifive.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1646383150.git.zong.li@sifive.com>
References: <cover.1646383150.git.zong.li@sifive.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

It currently assumes that there are always four channels, it would
cause the error if there is actually less than four channels. Change
that by getting number of channel from device tree.

For backwards-compatibility, it uses the default value (i.e. 4) when
there is no 'dma-channels' information in dts.

Signed-off-by: Zong Li <zong.li@sifive.com>
Acked-by: Palmer Dabbelt <palmer@rivosinc.com>
---
 drivers/dma/sf-pdma/sf-pdma.c | 24 ++++++++++++++++--------
 drivers/dma/sf-pdma/sf-pdma.h |  8 ++------
 2 files changed, 18 insertions(+), 14 deletions(-)

diff --git a/drivers/dma/sf-pdma/sf-pdma.c b/drivers/dma/sf-pdma/sf-pdma.c
index f12606aeff87..db5a4ef76077 100644
--- a/drivers/dma/sf-pdma/sf-pdma.c
+++ b/drivers/dma/sf-pdma/sf-pdma.c
@@ -482,23 +482,30 @@ static void sf_pdma_setup_chans(struct sf_pdma *pdma)
 static int sf_pdma_probe(struct platform_device *pdev)
 {
 	struct sf_pdma *pdma;
-	struct sf_pdma_chan *chan;
 	struct resource *res;
-	int len, chans;
-	int ret;
+	int ret, n_chans;
 	const enum dma_slave_buswidth widths =
 		DMA_SLAVE_BUSWIDTH_1_BYTE | DMA_SLAVE_BUSWIDTH_2_BYTES |
 		DMA_SLAVE_BUSWIDTH_4_BYTES | DMA_SLAVE_BUSWIDTH_8_BYTES |
 		DMA_SLAVE_BUSWIDTH_16_BYTES | DMA_SLAVE_BUSWIDTH_32_BYTES |
 		DMA_SLAVE_BUSWIDTH_64_BYTES;
 
-	chans = PDMA_NR_CH;
-	len = sizeof(*pdma) + sizeof(*chan) * chans;
-	pdma = devm_kzalloc(&pdev->dev, len, GFP_KERNEL);
+	ret = of_property_read_u32(pdev->dev.of_node, "dma-channels", &n_chans);
+	if (ret) {
+		/* backwards-compatibility for no dma-channels property */
+		dev_dbg(&pdev->dev, "set number of channels to default value: 4\n");
+		n_chans = PDMA_MAX_NR_CH;
+	} else if (n_chans > PDMA_MAX_NR_CH) {
+		dev_err(&pdev->dev, "the number of channels exceeds the maximum\n");
+		return -EINVAL;
+	}
+
+	pdma = devm_kzalloc(&pdev->dev, struct_size(pdma, chans, n_chans),
+			    GFP_KERNEL);
 	if (!pdma)
 		return -ENOMEM;
 
-	pdma->n_chans = chans;
+	pdma->n_chans = n_chans;
 
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	pdma->membase = devm_ioremap_resource(&pdev->dev, res);
@@ -556,7 +563,7 @@ static int sf_pdma_remove(struct platform_device *pdev)
 	struct sf_pdma_chan *ch;
 	int i;
 
-	for (i = 0; i < PDMA_NR_CH; i++) {
+	for (i = 0; i < pdma->n_chans; i++) {
 		ch = &pdma->chans[i];
 
 		devm_free_irq(&pdev->dev, ch->txirq, ch);
@@ -574,6 +581,7 @@ static int sf_pdma_remove(struct platform_device *pdev)
 
 static const struct of_device_id sf_pdma_dt_ids[] = {
 	{ .compatible = "sifive,fu540-c000-pdma" },
+	{ .compatible = "sifive,pdma0" },
 	{},
 };
 MODULE_DEVICE_TABLE(of, sf_pdma_dt_ids);
diff --git a/drivers/dma/sf-pdma/sf-pdma.h b/drivers/dma/sf-pdma/sf-pdma.h
index 0c20167b097d..dcb3687bd5da 100644
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
+	struct sf_pdma_chan	chans[];
 };
 
 #endif /* _SF_PDMA_H */
-- 
2.31.1

