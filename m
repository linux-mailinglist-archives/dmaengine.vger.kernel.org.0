Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 23DDD490004
	for <lists+dmaengine@lfdr.de>; Mon, 17 Jan 2022 02:35:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236769AbiAQBfv (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Sun, 16 Jan 2022 20:35:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236790AbiAQBfr (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Sun, 16 Jan 2022 20:35:47 -0500
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CE3CC061749
        for <dmaengine@vger.kernel.org>; Sun, 16 Jan 2022 17:35:44 -0800 (PST)
Received: by mail-pf1-x431.google.com with SMTP id f144so8031379pfa.6
        for <dmaengine@vger.kernel.org>; Sun, 16 Jan 2022 17:35:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=OqMpSNI9o/wkUts3PmMeUCyav5wo+up/ZcTRwyLImaU=;
        b=gPRlR1Hf1DlVbJZaGtmNkw21jKWi4su9kEjnfc5X377q7Nd2Y7HtBZ8vt7o0fPFteE
         OnSEKYrRPfCyC+GNzQBc5ldetBk0daHxdb3Lxbb2kSvLFTtfMnrai26rR6lfsiJhA5Wh
         ZG3abik8TZjlyWBQ3+2YgYRT7TtoLmhp+gqoNM/89EpwrKyOXju1Je6li41y6FXwPrJH
         dMJPV+RtTQIrMVx5XXr6iEbXB/ffBTzSh66nJcqwLpN0A/uXf2sg77dt2oyTc+D1BQQh
         jMIqejCOwnTteD3HvNIxv5WFJwq0OotlC0m99621XL3g5wInYZe8k9DeWd3ha9CepGAn
         Sz/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=OqMpSNI9o/wkUts3PmMeUCyav5wo+up/ZcTRwyLImaU=;
        b=P0x/0GPMUi51m7yFtMQMgPjzdhchjbI97LSsQlGWZa83+9yKhDRZm+EAIqoBl0MKcY
         29isEybNkTTKJolbOF3aXp+oji5469UvYsbM0W35VmoXX5pncoJIas6mVUQagg6NkDtY
         q0X0+y+6diKf8fYLnPZbiN44PYjTmNJ4sDdm5kwoUmegBwkME4DqFLNcPPWiocKWgsxY
         WyKHTAWJ1DhV9+ayHlBJ9LSuPizTIIEXG5FYfCAfBnkwQJl2Kk3jnKGlropcHa6nehnc
         2STB1d1gM9LrvsdNPkLc1oEIyRNrI93GK/9FwsInfpnTMbzN1gh7uIVPD6QjxO+Kr7Vg
         /YRA==
X-Gm-Message-State: AOAM532dorthON0ESF5ktOX+uYO9bYIKsmuOSEQX5oo1s1aD5toOEMVO
        F/d3xC+ArtK+yYe1ClZ3NmN0jg==
X-Google-Smtp-Source: ABdhPJwuYjavF52j9NgVoipdfAqM8ttzlG86FOpEh3FLfEagU2BCeR800imtawrLV3moDeYClwsDHQ==
X-Received: by 2002:aa7:92d1:0:b0:4bb:9d7:6951 with SMTP id k17-20020aa792d1000000b004bb09d76951mr18916569pfa.40.1642383343595;
        Sun, 16 Jan 2022 17:35:43 -0800 (PST)
Received: from hsinchu16.internal.sifive.com (59-124-168-89.hinet-ip.hinet.net. [59.124.168.89])
        by smtp.gmail.com with ESMTPSA id l1sm10008335pgn.35.2022.01.16.17.35.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 16 Jan 2022 17:35:43 -0800 (PST)
From:   Zong Li <zong.li@sifive.com>
To:     robh+dt@kernel.org, paul.walmsley@sifive.com, palmer@dabbelt.com,
        aou@eecs.berkeley.edu, krzysztof.kozlowski@canonical.com,
        conor.dooley@microchip.com, geert@linux-m68k.org,
        bin.meng@windriver.com, green.wan@sifive.com, vkoul@kernel.org,
        dmaengine@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org
Cc:     Zong Li <zong.li@sifive.com>
Subject: [PATCH v4 3/3] dmaengine: sf-pdma: Get number of channel by device tree
Date:   Mon, 17 Jan 2022 09:35:28 +0800
Message-Id: <0d0b0a3ad703f5ef50611e2dd80439675bda666a.1642383007.git.zong.li@sifive.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1642383007.git.zong.li@sifive.com>
References: <cover.1642383007.git.zong.li@sifive.com>
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
 drivers/dma/sf-pdma/sf-pdma.c | 20 +++++++++++++-------
 drivers/dma/sf-pdma/sf-pdma.h |  8 ++------
 2 files changed, 15 insertions(+), 13 deletions(-)

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

