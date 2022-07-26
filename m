Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 373DC5814CD
	for <lists+dmaengine@lfdr.de>; Tue, 26 Jul 2022 16:09:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232851AbiGZOJu (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 26 Jul 2022 10:09:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230430AbiGZOJt (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 26 Jul 2022 10:09:49 -0400
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com [IPv6:2a00:1450:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7ACBA25C5F
        for <dmaengine@vger.kernel.org>; Tue, 26 Jul 2022 07:09:48 -0700 (PDT)
Received: by mail-lj1-x233.google.com with SMTP id b34so11438296ljr.7
        for <dmaengine@vger.kernel.org>; Tue, 26 Jul 2022 07:09:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=satlab.com; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=BTBbqqiM/PK3GRtHICviYykRQJ4dL6+jUIF8I+88mdA=;
        b=jvNttcbihaLvLEMci4ebdNJFlBXBVMXQI5RT+Kwqf26vtxyRtynk2uJTLjunFrJR09
         b28qyX0g7c33U0LN8CEnjuvYiHE1rkoifVL9RjJ+8aFgH1KiiMFYFjzcXfuacQqBobRy
         MKuX+btD+zN15PO0NLuajixRLL6JTkW/PGbZjzf/lrg2hlmU1pC1hagxhtewyBljyhSk
         07iJNEbPXcnVxRsSnBb788eIzDGKBVEzot0pJsn/6G54B89rx0bJKbFuosRtegutTwWC
         WjeGBIoUOcUj7nppS/qXmgCHoo+7YWh5ND6xZUXSVCmaT50wryQPhLjrMsHNe317e4Hk
         YAyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=BTBbqqiM/PK3GRtHICviYykRQJ4dL6+jUIF8I+88mdA=;
        b=y27TiPezFQnikw/RscKFU2d5nWu5P6amwC4PvzJUNOwt/vhUPOTuOEUnrTF1C3apo2
         APdbtoEgwPIEMUbsaTLgyXuF76Z2jcj8l9FNvIg5OWsHUwk5fVYVVjl2dhVCIbw8Z/BO
         VMxgtkbfD6QnbN5AHin6n5MVlZ2W4etuy/+0Ph+YVPDp4zbi1mTdbe7OxeWqRg3gTCPJ
         gY9lcUF9jEn4I9bvX3oaKpHNqLpxrByt28K4ajfBO65wfsNQXof0HVj+ik0vnodluqoJ
         KXx8lqyc7lVhLOwLdR7CEF49rzUkTx+ExbUolTpvqkw2PzCS2tkArmhnKanu5TxVGIYi
         CX7Q==
X-Gm-Message-State: AJIora+SUeZTlnwRGdeuFuv1kPeb+YDCPiQiN60pFYD8MTsrxCtaiKTZ
        vQiftDlhV0guVfb0rWQ1QwTnxGfLI/SMHNzteJ0=
X-Google-Smtp-Source: AGRyM1uJm3P98z7OvKuihKQZu6VEJvMmtBv5uMa/Cvd4ze5hG5V+eajkDxA7jUoFKbNujifkyscJ3A==
X-Received: by 2002:a2e:8247:0:b0:25d:b515:92e with SMTP id j7-20020a2e8247000000b0025db515092emr6105080ljh.527.1658844586812;
        Tue, 26 Jul 2022 07:09:46 -0700 (PDT)
Received: from tausen-desktop.satlab.com ([77.243.61.235])
        by smtp.gmail.com with ESMTPSA id 25-20020a2e1459000000b0025de9a05176sm3033509lju.111.2022.07.26.07.09.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Jul 2022 07:09:46 -0700 (PDT)
From:   Mathias Tausen <mta@satlab.com>
To:     dmaengine@vger.kernel.org
Cc:     Mathias Tausen <mta@satlab.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Vinod Koul <vkoul@kernel.org>,
        =?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>
Subject: [PATCH v2] dmaengine: axi-dmac: check cache coherency register
Date:   Tue, 26 Jul 2022 16:02:12 +0200
Message-Id: <20220726140213.786939-1-mta@satlab.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Marking the DMA as cache coherent (dma-coherent in devicetree) is only
safe with versions of axi_dmac that have this feature enabled.

Cc: Lars-Peter Clausen <lars@metafoo.de>
Cc: Vinod Koul <vkoul@kernel.org>
Acked-by: Nuno Sá <nuno.sa@analog.com>
Signed-off-by: Mathias Tausen <mta@satlab.com>
---
Changelog:

  v2: Cc: Vinod, Acked-by: Nuno

For context, this patch is related to a recent change to the HDL:

  https://github.com/analogdevicesinc/hdl/pull/925

And has been discussed in the Analog Devices tree:

  https://github.com/analogdevicesinc/linux/pull/1908

 drivers/dma/dma-axi-dmac.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/drivers/dma/dma-axi-dmac.c b/drivers/dma/dma-axi-dmac.c
index 5161b73c30c4..f30dabc99795 100644
--- a/drivers/dma/dma-axi-dmac.c
+++ b/drivers/dma/dma-axi-dmac.c
@@ -18,6 +18,7 @@
 #include <linux/module.h>
 #include <linux/of.h>
 #include <linux/of_dma.h>
+#include <linux/of_address.h>
 #include <linux/platform_device.h>
 #include <linux/regmap.h>
 #include <linux/slab.h>
@@ -55,6 +56,9 @@
 #define   AXI_DMAC_DMA_DST_TYPE_GET(x)	FIELD_GET(AXI_DMAC_DMA_DST_TYPE_MSK, x)
 #define   AXI_DMAC_DMA_DST_WIDTH_MSK	GENMASK(3, 0)
 #define   AXI_DMAC_DMA_DST_WIDTH_GET(x)	FIELD_GET(AXI_DMAC_DMA_DST_WIDTH_MSK, x)
+#define AXI_DMAC_REG_COHERENCY_DESC	0x14
+#define   AXI_DMAC_DST_COHERENT_MSK	BIT(0)
+#define   AXI_DMAC_DST_COHERENT_GET(x)	FIELD_GET(AXI_DMAC_DST_COHERENT_MSK, x)
 
 #define AXI_DMAC_REG_IRQ_MASK		0x80
 #define AXI_DMAC_REG_IRQ_PENDING	0x84
@@ -979,6 +983,18 @@ static int axi_dmac_probe(struct platform_device *pdev)
 
 	axi_dmac_write(dmac, AXI_DMAC_REG_IRQ_MASK, 0x00);
 
+	if (of_dma_is_coherent(pdev->dev.of_node)) {
+		ret = axi_dmac_read(dmac, AXI_DMAC_REG_COHERENCY_DESC);
+
+		if (version < ADI_AXI_PCORE_VER(4, 4, 'a') ||
+		    !AXI_DMAC_DST_COHERENT_GET(ret)) {
+			dev_err(dmac->dma_dev.dev,
+				"Coherent DMA not supported in hardware");
+			ret = -EINVAL;
+			goto err_clk_disable;
+		}
+	}
+
 	ret = dma_async_device_register(dma_dev);
 	if (ret)
 		goto err_clk_disable;
-- 
2.36.1

