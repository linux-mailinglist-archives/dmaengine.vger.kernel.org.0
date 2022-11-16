Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E0C0762C07F
	for <lists+dmaengine@lfdr.de>; Wed, 16 Nov 2022 15:08:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233207AbiKPOIS (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 16 Nov 2022 09:08:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233106AbiKPOH7 (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 16 Nov 2022 09:07:59 -0500
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 248D9E5C
        for <dmaengine@vger.kernel.org>; Wed, 16 Nov 2022 06:07:27 -0800 (PST)
Received: by mail-wr1-x432.google.com with SMTP id w14so30082808wru.8
        for <dmaengine@vger.kernel.org>; Wed, 16 Nov 2022 06:07:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=zy34VNtqLWyXgm9jc9aJMnFAO1X6qZS3sO7xNHOGNqM=;
        b=mHWMGtVFaMalslGQZnxoS9k8rJyaVZqFIBCUV7DCDIOCwpo9A1dOFQF7cJkiSPsIby
         KTNNJpDaM0oe5sk3da8Cw0IkXG0i/NaQLLv9/qxP0/QvnAOeEEyEXA6NzJD2CW5mKei8
         +T1S3hCTJYFbtWMGyDDKOvnALXoVUMiEcMD6eWbwKS7ZqFWjRdB6ytRv9L0tV0zNcBzJ
         YPJ4mva+UIEf4vgNqFj0xjIh9EyduelsCE0KGRDr+KVc2i9B0L3ROiOhJhmjsMOX4B52
         W+9QA/luFjShT8ov6UK+M/zFLjax9x1Wz9VASxADqv/tOBGfjWL7bFOB4pLO+gP/uJhu
         zeDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zy34VNtqLWyXgm9jc9aJMnFAO1X6qZS3sO7xNHOGNqM=;
        b=F+avf2lCSiaP46XK3noLU5ml2fKM97hfppTXjRwXkCWd+/1Q1VSQ3FuHRqal5oCYz5
         1TtpYl5ijDDU2QxfvmGB8vUP85166fDO21dZHi03sinNz/Ctt/chCklitzYaE5TMHUxW
         1v0ZFiJ0oBRqrgYEsFctXiiz4q8O1QBAshXFs+dW3BvvsoXrqECw3fpo5nnWIPDcL/m+
         hseKi87/6gnDhRg2jGxcAvOeeZtwGDqfjxLZUwoh50H2vOibaWCXTAwmuBbOLsHJm77t
         zUFfX0Rsoowf4ExJi2iztXErk0GMFl5HydQtdJmZPgIiab4Gxj8nBGsStZMq50NYngdW
         TqQw==
X-Gm-Message-State: ANoB5pnDVhvSSuNRsyvIRrkM5VIpQxDV4+FIKT9xYS+iX3SxL3K67tAv
        yLKz0sGZ1DcNOpjUN6HX1qzFzQ==
X-Google-Smtp-Source: AA0mqf5wKTVmy8vggV39mVWVmfUWD1KpjROeBuWt7bUF9bAs8G2fMltbn5Qlu9UK+Q+u4miAtAMx1A==
X-Received: by 2002:adf:ba85:0:b0:22e:3336:1509 with SMTP id p5-20020adfba85000000b0022e33361509mr14634369wrg.710.1668607645686;
        Wed, 16 Nov 2022 06:07:25 -0800 (PST)
Received: from nicolas-Precision-3551.home ([2001:861:5180:dcc0:3f99:5293:49fd:9c5b])
        by smtp.gmail.com with ESMTPSA id j17-20020a5d6191000000b0023657e1b980sm15333850wru.53.2022.11.16.06.07.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Nov 2022 06:07:25 -0800 (PST)
From:   Nicolas Frayer <nfrayer@baylibre.com>
To:     peter.ujfalusi@gmail.com, vkoul@kernel.org,
        dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     khilman@baylibre.com, glaroque@baylibre.com, nfrayer@baylibre.com
Subject: [PATCH v2] dmaengine: ti: k3-udma: Deferring probe when soc_device_match() returns NULL
Date:   Wed, 16 Nov 2022 15:07:12 +0100
Message-Id: <20221116140712.24283-1-nfrayer@baylibre.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

When the k3 socinfo driver is built as a module, there is a possibility
that it will probe after the k3 udma driver and the later returns -ENODEV.
By deferring the k3 udma probe we allow the k3 socinfo to probe and
register the soc_device_attribute structure needed by the k3 udma driver.

Signed-off-by: Nicolas Frayer <nfrayer@baylibre.com>
---
v1->v2:
Extracted this patch from the following series:
https://lore.kernel.org/all/20221108181144.433087-1-nfrayer@baylibre.com/

 drivers/dma/ti/k3-udma.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/dma/ti/k3-udma.c b/drivers/dma/ti/k3-udma.c
index 7b5081989b3d..a6bb5077900b 100644
--- a/drivers/dma/ti/k3-udma.c
+++ b/drivers/dma/ti/k3-udma.c
@@ -5285,7 +5285,7 @@ static int udma_probe(struct platform_device *pdev)
 	soc = soc_device_match(k3_soc_devices);
 	if (!soc) {
 		dev_err(dev, "No compatible SoC found\n");
-		return -ENODEV;
+		return -EPROBE_DEFER;
 	}
 	ud->soc_data = soc->data;
 
-- 
2.25.1

