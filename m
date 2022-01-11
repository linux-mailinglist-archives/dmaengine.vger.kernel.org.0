Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8B62A48A9E2
	for <lists+dmaengine@lfdr.de>; Tue, 11 Jan 2022 09:51:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349028AbiAKIvx (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 11 Jan 2022 03:51:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349040AbiAKIvs (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 11 Jan 2022 03:51:48 -0500
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D077C061748
        for <dmaengine@vger.kernel.org>; Tue, 11 Jan 2022 00:51:48 -0800 (PST)
Received: by mail-pj1-x102e.google.com with SMTP id y16-20020a17090a6c9000b001b13ffaa625so3925657pjj.2
        for <dmaengine@vger.kernel.org>; Tue, 11 Jan 2022 00:51:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=3iqaAGZ9UzBXUbLAm4bUUdw8nwdBCobmyXaVuD0M1O8=;
        b=BpcDwsI7iX5IWglV3CB1erV4tmyiRc9yjg3obRAkqf97ex0fO8QIkyZB4JKnkKsGK0
         y2nhSqynYnnhVdX5cnBklZx9kCSAqUZXdX9XhMSaEbVFCPg6ePgwqHceFqH1Hy0bIp8Y
         BLEIfvvTOO57qMoHfRBjXeONJr4t/GNVvuA1iOK/8Kw0hZxf/EQpI7SAj2Cqwh429fEU
         +Kabee08MPoy+9fQnGwGzQxm1qEZq5mGgagui3qiUoVXtWkgWU20Fn19m9QNYPK3UiMP
         28aGeAnp87bJOWx+Zdk3iOwiBzbsQ6fTlB6iUuE0w5RktZ4VIsI/cEtk9g0oywwLHWIa
         h6FQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=3iqaAGZ9UzBXUbLAm4bUUdw8nwdBCobmyXaVuD0M1O8=;
        b=TsoSDoZC1NoLgUfxEAqcfGQYq1bRzban4Lc1D95Zl7nrrJ+ukx7hGA4EKblHnZOW4/
         bPcsxrFUN6nR6jN+Sfg2iFXSpiQnHLo+ikhZCN/i5WtZ4oEqNhfGekc9AhcD8uEjQcJH
         jPFb7x6Nf8y3flCtZmOBN1SzoZynIr/3h8xdmh+S62yXExU3aBaYYnEuEK/naIKrSkJv
         2OFoVDarxhVNyPKL8GkMf83iSwl7O5bdYmqggaKBtwRik5tMP6lw5gysda0/UsFp2W6k
         4o2TfD7HQHqDW85pIy8+FvK7YMxL/WIdO/IsWlqajvMEjth9weOf8HesuZArmqXVRD//
         oIoQ==
X-Gm-Message-State: AOAM532pkWN82jDwajq1SzW+vTtX/3Pce3aTTet/d1qMusOQGGuhWqg+
        qPipNg2BPCH6nDSs8NHV3SrH8Q==
X-Google-Smtp-Source: ABdhPJy+SBuFVm1a11AHzLGbXIf7gcDDLh5LomRsKXxKTX1T+LtK0Vr6OvMTpoaP93jRT/soiExCTA==
X-Received: by 2002:aa7:84c1:0:b0:4bf:379:1d85 with SMTP id x1-20020aa784c1000000b004bf03791d85mr3546334pfn.5.1641891107790;
        Tue, 11 Jan 2022 00:51:47 -0800 (PST)
Received: from hsinchu16.internal.sifive.com (59-124-168-89.hinet-ip.hinet.net. [59.124.168.89])
        by smtp.gmail.com with ESMTPSA id j4sm9447598pfa.149.2022.01.11.00.51.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Jan 2022 00:51:47 -0800 (PST)
From:   Zong Li <zong.li@sifive.com>
To:     robh+dt@kernel.org, paul.walmsley@sifive.com, palmer@dabbelt.com,
        aou@eecs.berkeley.edu, krzysztof.kozlowski@canonical.com,
        conor.dooley@microchip.com, geert@linux-m68k.org,
        bin.meng@windriver.com, green.wan@sifive.com, vkoul@kernel.org,
        dmaengine@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org
Cc:     Zong Li <zong.li@sifive.com>
Subject: [PATCH v2 3/3] dmaengine: sf-pdma: Get number of channel by device tree
Date:   Tue, 11 Jan 2022 16:51:27 +0800
Message-Id: <78cfa00a02cbd10202040058af22a73caa9c5ae8.1641890718.git.zong.li@sifive.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1641890718.git.zong.li@sifive.com>
References: <cover.1641890718.git.zong.li@sifive.com>
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
 drivers/dma/sf-pdma/sf-pdma.c | 15 +++++++++------
 drivers/dma/sf-pdma/sf-pdma.h |  8 ++------
 2 files changed, 11 insertions(+), 12 deletions(-)

diff --git a/drivers/dma/sf-pdma/sf-pdma.c b/drivers/dma/sf-pdma/sf-pdma.c
index f12606aeff87..5d386037bf36 100644
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
+		dev_notice(&pdev->dev, "set number of channels to default value: 4\n");
+		pdma->n_chans = PDMA_MAX_NR_CH;
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

