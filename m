Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D89386BF851
	for <lists+dmaengine@lfdr.de>; Sat, 18 Mar 2023 07:23:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229769AbjCRGXH (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Sat, 18 Mar 2023 02:23:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229611AbjCRGXF (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Sat, 18 Mar 2023 02:23:05 -0400
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEE3A1F5C1;
        Fri, 17 Mar 2023 23:23:04 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id ja10so7478637plb.5;
        Fri, 17 Mar 2023 23:23:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679120584;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cKdJMrUoPlolt4vt4AIPPI0cbmUo1Rg9dVe242bvHCg=;
        b=nrxWyekKEnSGfYIHR1cs6nORUpHKnKuCFA2jfH4ualXPgsVIrJe94uwLEqw1zzb1Bj
         VshYq/LdR8FeZME8dB9Fi3zlROGA9bMGTz+RjHk4SqKZGmuqIbEB1Dr+yd1V+Cwzkecq
         ACNL/aoBn/bP7VvINX9A3HrIBL9rfUtAShJSoVBFIUTUnMMooTVDNuIgSNsL9rg95qZt
         MTQ5MNEsHJj6Qei+05MbOYgGL0TD5v0xyoFRiGlANGDxYCiO01f1GEWqieN6pveHB7HO
         krOaV2naXmPV2Cq2SIyCWAcEg7KHeqDw6a8XB25gE2+0e8HZ3lbxBo2FenQelGJ9oOPY
         e+hQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679120584;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cKdJMrUoPlolt4vt4AIPPI0cbmUo1Rg9dVe242bvHCg=;
        b=DIzETgcC5QqoFqgu1M3wrtUfO6GUF8pxh0HiaFa1j3MvZxEK+Spx2W3P5YksJ1I6UD
         A/wb8YN7Br9hIKzJXQ9V69v86HKQzlvwM3Q7i8V4TrcdKFDm8xS15pmxNKfsBMbJ8JtG
         40UJ28FZTgTpniyfwSApCRwFvdJGs7r9EaJd94pt+St981TLPErmC2Rzvt1gvnrOMbCn
         Ap+itQqX23RFGVOUOqwwL76F3T9DHTrPMZE6qayi/if095TCxIjiWkWcuqxZdw7o319L
         JOV1VtRKEHu+OGLwByFN3zIZu6Xk6B/4QbqIq0PrKdXKQ3KgxCFbJIyDZGNDbmdILrGq
         riVw==
X-Gm-Message-State: AO0yUKX2zuWCDxlosevqbusT6MGQ5ZRIP8IDPsSB0XIfAVs7/bvMPwg3
        9EQfMHCVG/wwtaAEp9CjmE0I9N0Z3Cqyng==
X-Google-Smtp-Source: AK7set8g0ZgnHCSwRI7NdZBT8AyoI1JpMXmLYPqPiCFbm52wul7ibxTlGC6c5Ti8CSCSEhlkWLKyPw==
X-Received: by 2002:a17:902:ce91:b0:1a1:b7ff:a067 with SMTP id f17-20020a170902ce9100b001a1b7ffa067mr902263plg.63.1679120584270;
        Fri, 17 Mar 2023 23:23:04 -0700 (PDT)
Received: from DESKTOP-HHR6EMI.localdomain ([143.244.50.165])
        by smtp.gmail.com with ESMTPSA id d18-20020a170902aa9200b001a1add0d616sm1471208plr.161.2023.03.17.23.23.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Mar 2023 23:23:03 -0700 (PDT)
From:   void0red <void0red@gmail.com>
To:     vkoul@kernel.org
Cc:     dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
        peter.ujfalusi@gmail.com, void0red@gmail.com
Subject: [PATCH v2 2/2] dmaengine: ti: add null check of devm_kasprintf in edma_probe
Date:   Sat, 18 Mar 2023 14:22:55 +0800
Message-Id: <20230318062255.76-2-void0red@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230318062255.76-1-void0red@gmail.com>
References: <ZBSj/0kIGVROIGi7@matsya>
 <20230318062255.76-1-void0red@gmail.com>
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

From: Kang Chen <void0red@gmail.com>

devm_kasprintf may fails, irq_name might be null and wrong irq
name will be used in request.

Fixes: 2b6b3b742019 ("ARM/dmaengine: edma: Merge the two drivers under drivers/dma/")
Acked-by: Peter Ujfalusi <peter.ujfalusi@gmail.com>
Reviewed-by: Vinod Koul <vkoul@kernel.org>
Signed-off-by: Kang Chen <void0red@gmail.com>
---
v2 -> v1: split into two patches and add some tags

 drivers/dma/ti/edma.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/dma/ti/edma.c b/drivers/dma/ti/edma.c
index fa06d7e6d8e3..85cd72b6401a 100644
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
-- 
2.34.1

