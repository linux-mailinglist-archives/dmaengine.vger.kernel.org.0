Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 25E294E91FE
	for <lists+dmaengine@lfdr.de>; Mon, 28 Mar 2022 11:52:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240042AbiC1Jya (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 28 Mar 2022 05:54:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240052AbiC1Jy2 (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 28 Mar 2022 05:54:28 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4109754BF4
        for <dmaengine@vger.kernel.org>; Mon, 28 Mar 2022 02:52:47 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id bx24-20020a17090af49800b001c6872a9e4eso14923528pjb.5
        for <dmaengine@vger.kernel.org>; Mon, 28 Mar 2022 02:52:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=oFYJu8bdS9lTnagtGk2u5UISyqGssJEWeZR75J4CCQ4=;
        b=GntnHgow6kb2bhuinGrTFT6S/X9qym/s0sFSEUkJXDmNQl82e2NCI1Dma+l72P+0wm
         9XMVcbHiRuxmvVtSPBZ7tQKj3M9CwbQN8u0YrhUHuwLJA0xwxOAP/iwP5HG2ieL5yBOB
         riyl5rYiqhApthbGtlZAOlL61VBJIcvqO1QaO37Z7lv9H4vxQ+xubqdQx26xXUVGFD8d
         gxMFYcwX+olVPgEM1Ntshiy1FnwUIwyiKDhK2pqaCM1mSHd6b1m0g9+oLCrcBHPeLggT
         +UMQ6lX6a6VxpFVHvdyINtwXFxyfB2gkIAq5wYTXNjWGzZ4XNOPo3g7YIa1sPy5P0hSU
         vILg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=oFYJu8bdS9lTnagtGk2u5UISyqGssJEWeZR75J4CCQ4=;
        b=zxzX1qmRbW9XOAzyakj6z2/cnqgZIt8GYRMCd7onlgAGkRjWwrVPc25Z6ft/Lfd7cS
         fkZC2lsn1+wrIXSAmmvRvj6QPbQcSR4V0ux9J73Tgyd8MC+6FsxI5nDVgToD9/kvMbdI
         OEZPYW1B3g2S1WQoQG56yv3BzZnYbluKPpIb18iEsekF/kqKM7VA8hnPAA/m0UEm7zgq
         0xXbAc1i7i5scKl4AYYHKGafTR9XnJU2KXZUn7mFNh0tQWoQ/vFL3rstjEfWZ2FPq27v
         jqA4UjEMoayZc24eCzo51JgMnarI7LQwkHveO3jedFE2ZKoNsz/rbxWrmsz/imfRSg0W
         +9cQ==
X-Gm-Message-State: AOAM531nRK0im++QpR31o4jE0XnNf6on5ORijdisfv1mLS7N2c9UK6hz
        uyWhO7ZZ41b3925LgC+7DyyPkA==
X-Google-Smtp-Source: ABdhPJwLen54FYCTR5UKlde92eYTDiJhw3WeUWHMHtaUWkB4DnSeea8SCaamC7zkpBJAESiySUP9EA==
X-Received: by 2002:a17:90b:1c01:b0:1c6:dc49:d146 with SMTP id oc1-20020a17090b1c0100b001c6dc49d146mr39288419pjb.29.1648461166701;
        Mon, 28 Mar 2022 02:52:46 -0700 (PDT)
Received: from hsinchu16.internal.sifive.com (59-124-168-89.hinet-ip.hinet.net. [59.124.168.89])
        by smtp.gmail.com with ESMTPSA id g4-20020a633744000000b00381efba48b0sm12255117pgn.44.2022.03.28.02.52.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Mar 2022 02:52:46 -0700 (PDT)
From:   Zong Li <zong.li@sifive.com>
To:     robh+dt@kernel.org, paul.walmsley@sifive.com, palmer@dabbelt.com,
        aou@eecs.berkeley.edu, krzysztof.kozlowski@canonical.com,
        conor.dooley@microchip.com, geert@linux-m68k.org,
        bin.meng@windriver.com, green.wan@sifive.com, vkoul@kernel.org,
        dmaengine@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org
Cc:     Zong Li <zong.li@sifive.com>, Palmer Dabbelt <palmer@rivosinc.com>
Subject: [PATCH v8 4/4] dmaengine: sf-pdma: Get number of channel by device tree
Date:   Mon, 28 Mar 2022 17:52:25 +0800
Message-Id: <f08a95b6582a51712c5b2c3cb859136d07bfa8b9.1648461096.git.zong.li@sifive.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <cover.1648461096.git.zong.li@sifive.com>
References: <cover.1648461096.git.zong.li@sifive.com>
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
2.35.1

