Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C7A2E6A2F02
	for <lists+dmaengine@lfdr.de>; Sun, 26 Feb 2023 10:40:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229536AbjBZJkt (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Sun, 26 Feb 2023 04:40:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbjBZJks (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Sun, 26 Feb 2023 04:40:48 -0500
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0ED1C1041B;
        Sun, 26 Feb 2023 01:40:46 -0800 (PST)
Received: by mail-pj1-x102d.google.com with SMTP id nw10-20020a17090b254a00b00233d7314c1cso7137214pjb.5;
        Sun, 26 Feb 2023 01:40:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=7fHwmrCRCxm2Kglss2PSZMaGgwhyeQygsMnvaMvHoa0=;
        b=cslYMk0gyd3EEsE8+9ioTOMDqscQXZRHyVJuqP79QqL2jQJBS0hhjHjz3mW+o+CRS4
         Q/lkXjHyTc/zGaUpjAfFXbQggCR3ZEvPgfkKDdP8TL0KOSG3tn4WLXz7W3+ywkYgMOhl
         LhmtKYxSVD45mcmDqYqOpeCROX36DD4jlGdD98i4IE95n1u8FE23u6sHAqpcm3i+WODJ
         v4qkNngjLw8y5S2RSKPza4Ph50ytTdtVXjBkUp1Fsy5OxA7k7xtGCLluoMpsj1IFez9w
         PuovoQ4+sv/9kq9v4EkY8xeyflqZaG/YuoSC7hbx7u8UkKU+M7M4Bkz1PJrbHcM8jN3g
         j6HA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7fHwmrCRCxm2Kglss2PSZMaGgwhyeQygsMnvaMvHoa0=;
        b=VNZxRNpUqQZ45HTJeDqPoZDnev4RXYoIm21HL159mZc8Y58A4dMW4h5vHpZw7xn9Lq
         YoPTboFYEAoQUU7jRdMt51820FHX75C5Wszruz8FjXC/aHT/afTIDzo004tkF31ySkfB
         adzo7DZpP+jHiymfwuG+Vk1CKHnNwHR4N9swQc+/Kqv/86h984S1yQ6uTsAUCxlrgIRV
         GiZ/ia8yGBe0eg/XTg+QYiCraU5IF9Ud1QoMGqDSkfX4g5TNs6Sbr2DAFbbGIzasrlGQ
         nmvWlHnNKPPHN0hj6upIPlj7gdtkRRQJrvbl2z8sifTDcDxfpn5+/2Xza0Peveri3z2c
         F3sw==
X-Gm-Message-State: AO0yUKUAwVqqPPjdPDg618Ukc1i3zmdD5G7m0+s1KPhtyMvF/EStWXMR
        j9/5qm4k5fvApNQlvT+g/fnUF2tRdQsATo4+
X-Google-Smtp-Source: AK7set+dFUFPxr0bAdTB9AXnq3YP45AzvRNMPw2W1SzQs6TFUEu5nMH9qZBNfLTGg45ryBOUQox9fw==
X-Received: by 2002:a17:90b:4aca:b0:237:9f75:6937 with SMTP id mh10-20020a17090b4aca00b002379f756937mr7743616pjb.28.1677404445540;
        Sun, 26 Feb 2023 01:40:45 -0800 (PST)
Received: from passwd123-ThinkStation-P920.. ([222.20.94.23])
        by smtp.gmail.com with ESMTPSA id p5-20020a17090b010500b002349fcf17f8sm4206453pjz.15.2023.02.26.01.40.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Feb 2023 01:40:45 -0800 (PST)
From:   Kang Chen <void0red@gmail.com>
To:     peter.ujfalusi@gmail.com
Cc:     vkoul@kernel.org, dmaengine@vger.kernel.org,
        linux-kernel@vger.kernel.org, Kang Chen <void0red@gmail.com>
Subject: [PATCH] dmaengine: ti: add null check of devm_kasprintf in edma_probe and udma_probe
Date:   Sun, 26 Feb 2023 17:40:38 +0800
Message-Id: <20230226094038.3227062-1-void0red@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

devm_kasprintf may fails, irq_name and uc->name might be null and wrong irq
name will be used in request.

Signed-off-by: Kang Chen <void0red@gmail.com>
---
 drivers/dma/ti/edma.c    | 8 ++++++++
 drivers/dma/ti/k3-udma.c | 2 ++
 2 files changed, 10 insertions(+)

diff --git a/drivers/dma/ti/edma.c b/drivers/dma/ti/edma.c
index fa06d7e6d..85cd72b64 100644
--- a/drivers/dma/ti/edma.c
+++ b/drivers/dma/ti/edma.c
@@ -2413,6 +2413,10 @@ static int edma_probe(struct platform_device *pdev)
 	if (irq >= 0) {
 		irq_name = devm_kasprintf(dev, GFP_KERNEL, "%s_ccint",
 					  dev_name(dev));
+		if (!irq_name) {
+			ret = -ENOMEM;
+			goto err_disable_pm;
+		}
 		ret = devm_request_irq(dev, irq, dma_irq_handler, 0, irq_name,
 				       ecc);
 		if (ret) {
@@ -2429,6 +2433,10 @@ static int edma_probe(struct platform_device *pdev)
 	if (irq >= 0) {
 		irq_name = devm_kasprintf(dev, GFP_KERNEL, "%s_ccerrint",
 					  dev_name(dev));
+		if (!irq_name) {
+			ret = -ENOMEM;
+			goto err_disable_pm;
+		}
 		ret = devm_request_irq(dev, irq, dma_ccerr_handler, 0, irq_name,
 				       ecc);
 		if (ret) {
diff --git a/drivers/dma/ti/k3-udma.c b/drivers/dma/ti/k3-udma.c
index 7e23a6fde..692d1d25c 100644
--- a/drivers/dma/ti/k3-udma.c
+++ b/drivers/dma/ti/k3-udma.c
@@ -5494,6 +5494,8 @@ static int udma_probe(struct platform_device *pdev)
 		uc->config.dir = DMA_MEM_TO_MEM;
 		uc->name = devm_kasprintf(dev, GFP_KERNEL, "%s chan%d",
 					  dev_name(dev), i);
+		if (!uc->name)
+			return -ENOMEM;
 
 		vchan_init(&uc->vc, &ud->ddev);
 		/* Use custom vchan completion handling */
-- 
2.34.1

