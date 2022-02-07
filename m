Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E8F04AB546
	for <lists+dmaengine@lfdr.de>; Mon,  7 Feb 2022 07:56:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232804AbiBGG4M (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 7 Feb 2022 01:56:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236741AbiBGGbR (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 7 Feb 2022 01:31:17 -0500
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF0D1C0401C2
        for <dmaengine@vger.kernel.org>; Sun,  6 Feb 2022 22:30:57 -0800 (PST)
Received: by mail-pf1-x42c.google.com with SMTP id i30so11289019pfk.8
        for <dmaengine@vger.kernel.org>; Sun, 06 Feb 2022 22:30:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=NsFZzRzWxi9SLwITfrc8E6h9ajUabmlo1GhXmJ+C3hc=;
        b=WAlvS5EXiVRFIZe8CQYOYmWuBeX252Ah939fQC4xFyJiOgiQOqKLCEZ9w/rsR6+gi6
         9ofS/fBv7QwPpn/VyFviNxUjm4OSgt5WaUQ38ohiXY8yU3zjlUJ1Yvbtqkq/Q0hEdem+
         vOL4LBrdoiDalFZWuSYY69OLG3uLZfb1ktFR1Bo8AZaDqbbY/rsgggVvLIGRaCKEw8tO
         M6ffn1560ArOL3Xpl5xg0EVvQnm6FsEePBN54U5qe7xAaGTB4ob9FbVdBbdf9fWl+Xe5
         0rS+pkIIUcoKVFmz3iMt4cxeBgkdGefflHbs0Y4BJCec9H7Tu+D3zt+hkDIKrAumXmsr
         epUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=NsFZzRzWxi9SLwITfrc8E6h9ajUabmlo1GhXmJ+C3hc=;
        b=AFetvJKp+UGD0AfNAXEInzv65eYw5wPPD4pMrWR66gcW9T+NGKiOZQqhh/rp40oUaO
         rfPYb9i/W/XUqFHc17IyHHDt0RSvOFpy3l1BFeA1HxMog5V7YlixqsCQOiic2xMuzazp
         BnxqhUwPedKGc0XmrRTFHGAiIV3vilJdCXammRFj5dHoqLegmrSBPh05+QfhB+l2d63Y
         TuM1Ge/Q/rK/8YysLH6bauFQaQh91y3bgREBZdyn2GirJi6zA1A899vQU73PsyQUEyeP
         RK+pJq2g9C8b/0hpt/vPhyO2/aP/U3h92bkbobGH9KbH+xh9Y+onUNKXVwLJcIW6kyEv
         nWHg==
X-Gm-Message-State: AOAM532dtKKcKi4654uRxkpYCOw8dcT/e+5opsVQADWdcq5950VvMWw+
        WA+r37JS9hZUWjIzjtD126N16A==
X-Google-Smtp-Source: ABdhPJztzK0ckN9GMQ0TxEmrpCSlWLQmxoXoG9PxqUVTiaqQJQd7I9kf9tGQI9fcbpFkt9zsEeErKA==
X-Received: by 2002:aa7:84d5:: with SMTP id x21mr14270143pfn.72.1644215456964;
        Sun, 06 Feb 2022 22:30:56 -0800 (PST)
Received: from hsinchu16.internal.sifive.com (59-124-168-89.hinet-ip.hinet.net. [59.124.168.89])
        by smtp.gmail.com with ESMTPSA id i10sm5266634pjd.2.2022.02.06.22.30.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Feb 2022 22:30:56 -0800 (PST)
From:   Zong Li <zong.li@sifive.com>
To:     robh+dt@kernel.org, paul.walmsley@sifive.com, palmer@dabbelt.com,
        aou@eecs.berkeley.edu, krzysztof.kozlowski@canonical.com,
        conor.dooley@microchip.com, geert@linux-m68k.org,
        bin.meng@windriver.com, green.wan@sifive.com, vkoul@kernel.org,
        dmaengine@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org
Cc:     Zong Li <zong.li@sifive.com>
Subject: [PATCH v5 3/3] dmaengine: sf-pdma: Get number of channel by device tree
Date:   Mon,  7 Feb 2022 14:30:40 +0800
Message-Id: <df6c8d1c701b33fa735dd072de3cb585dc60f2c9.1644215230.git.zong.li@sifive.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1644215230.git.zong.li@sifive.com>
References: <cover.1644215230.git.zong.li@sifive.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
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
---
 drivers/dma/sf-pdma/sf-pdma.c | 21 ++++++++++++++-------
 drivers/dma/sf-pdma/sf-pdma.h |  8 ++------
 2 files changed, 16 insertions(+), 13 deletions(-)

diff --git a/drivers/dma/sf-pdma/sf-pdma.c b/drivers/dma/sf-pdma/sf-pdma.c
index f12606aeff87..2ae10b61dfa1 100644
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
@@ -574,6 +580,7 @@ static int sf_pdma_remove(struct platform_device *pdev)
 
 static const struct of_device_id sf_pdma_dt_ids[] = {
 	{ .compatible = "sifive,fu540-c000-pdma" },
+	{ .compatible = "sifive,pdma0" },
 	{},
 };
 MODULE_DEVICE_TABLE(of, sf_pdma_dt_ids);
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

