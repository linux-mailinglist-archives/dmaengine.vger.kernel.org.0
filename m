Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 95828574B8F
	for <lists+dmaengine@lfdr.de>; Thu, 14 Jul 2022 13:09:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237749AbiGNLJd (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 14 Jul 2022 07:09:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237942AbiGNLJc (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 14 Jul 2022 07:09:32 -0400
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 061B81839F
        for <dmaengine@vger.kernel.org>; Thu, 14 Jul 2022 04:09:30 -0700 (PDT)
Received: by mail-lj1-x22a.google.com with SMTP id u14so1768393ljh.2
        for <dmaengine@vger.kernel.org>; Thu, 14 Jul 2022 04:09:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=satlab.com; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=7TK3Nq5JH0pryvBE632F025mqP82mcFaNlXo0essfFU=;
        b=JfFfo/wKdCe6o8KhGzcf6iaWaHuTdliwdK9LcB6suepy0KjAvMEv0FQuTOxQi3CDhc
         OMENUzOXYPos1ll88zPZXV7l6JZkSgw7HGJERaSU41IJfCtryr7vURW0C1Dl00vypKAl
         /jitHs+uXTrqLncpW195UOBX03TwKVvQLyOa5JYuGzvloBtugIoeogfAPzmgI/KjdnlR
         8V/7FQ6QzDBZRuDK0eINe6WiwpV2lbdbazmloh2gambjXXuK25A8MhOSSCXubICZaWW7
         ZQ8h71KeC5FOxg29r615zs+YdJo8r7jNzAvw6jXnBTDI/pwOEVOYQ442ELeNTZVC2y2U
         DK8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=7TK3Nq5JH0pryvBE632F025mqP82mcFaNlXo0essfFU=;
        b=xzDFYUbAyPzrQTO6O2UopE4kg/AFvD5OUJ1lVIavv/z89642xx57NT2vABwXrlv66B
         o44ReP0D7sge3adNBeAQwxXPJVoUbRmcK1lH2vcvXeyCxYTxs9cqyqPNL7Ee7pNFIDUJ
         78T2idq4qxgcsgo+kp54od7UUp1UpwlE5QOTW1y8Ej2aRjRpqi1dQ4+XPPaelFDCUeWW
         o/KTKUpK/EsdH6h6WF2bUbInkxRRQg9D7ATxC6w9OAUV7ege1C1R807VWN8ZVoP5oI6q
         qivdPm/+BmrZpfOlWpeIRbfs8QKSPZihPHtSpOeOXef1YhVVFGKG9y/LFslCFxgpEm6F
         nZQQ==
X-Gm-Message-State: AJIora+D9PU3kKRys2txlpC7tu+wJr4/K+gr/uieVY9fG9aL5Fs5XUeL
        fo1LlGb74rhZG5a41XFJuDK+BNpmKO+wNvfv8ws=
X-Google-Smtp-Source: AGRyM1tQSwvy6V0qiORAR4Ii1RbvV9EeDyJ6zPw7vLjqt78snc06Jr0LYXlBRgdj48Ga9zLz/sS2rg==
X-Received: by 2002:a2e:9b0b:0:b0:25d:866b:5de7 with SMTP id u11-20020a2e9b0b000000b0025d866b5de7mr4248987lji.50.1657796968368;
        Thu, 14 Jul 2022 04:09:28 -0700 (PDT)
Received: from tausen-desktop.satlab.com ([77.243.61.235])
        by smtp.gmail.com with ESMTPSA id f10-20020ac2532a000000b0047255d21171sm302619lfh.160.2022.07.14.04.09.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Jul 2022 04:09:27 -0700 (PDT)
From:   Mathias Tausen <mta@satlab.com>
To:     dmaengine@vger.kernel.org
Cc:     Mathias Tausen <mta@satlab.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        =?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>
Subject: [PATCH] dmaengine: axi-dmac: check cache coherency register
Date:   Thu, 14 Jul 2022 13:06:44 +0200
Message-Id: <20220714110644.2849191-1-mta@satlab.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

Marking the DMA as cache coherent (dma-coherent in devicetree) is only
safe with versions of axi_dmac that have this feature enabled.

Cc: Lars-Peter Clausen <lars@metafoo.de>
Cc: Nuno Sá <nuno.sa@analog.com>
Signed-off-by: Mathias Tausen <mta@satlab.com>
---
For context, this patch is related to a recent change to the HDL:

  https://github.com/analogdevicesinc/hdl/pull/925

And has been discussed in the Analog Devices tree:

  https://github.com/analogdevicesinc/linux/pull/1908

 drivers/dma/dma-axi-dmac.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/drivers/dma/dma-axi-dmac.c b/drivers/dma/dma-axi-dmac.c
index 6aa5d383da21..1b78e54c2630 100644
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
@@ -1006,6 +1010,18 @@ static int axi_dmac_probe(struct platform_device *pdev)
 
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

