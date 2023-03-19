Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9AEB06C0321
	for <lists+dmaengine@lfdr.de>; Sun, 19 Mar 2023 17:32:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231151AbjCSQcy (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Sun, 19 Mar 2023 12:32:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230515AbjCSQcr (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Sun, 19 Mar 2023 12:32:47 -0400
Received: from mail-il1-f172.google.com (mail-il1-f172.google.com [209.85.166.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BED71EFF2;
        Sun, 19 Mar 2023 09:32:27 -0700 (PDT)
Received: by mail-il1-f172.google.com with SMTP id 4so5405318ilz.6;
        Sun, 19 Mar 2023 09:32:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679243547;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dOGXaArRq4ZZyP8cyGdaWJb+Pur+8PAtmWP3/78HMM8=;
        b=k11DZJ2uE7oU90ueJBNfe0CNi0yzCDwJaqniTU+GRbt5Qdf35cQgqIExqNjI8mm+oG
         TQS9bcpl6GbxAuGdOeDis8dDl1koIUmEw+4RvK1AHr+OGFDEkISgDm4Pk7uBU1GbW9MZ
         MWNhOPolYoYB0hQ00Qsr5a61/ldZk3dq6mLX8Ug7h2LSgbdhQlZRzfz23AWAgiTEv5Il
         gVktl06DzyO5UhNH6W1UA3BTLmixaGjRtUUnA286uSq4tdTOCKsm+38LO9auOEXBdxQs
         9iZfX4wMBzCKTqPUrNw6nsma0IIWstKk6oanaInVd0EWndWST/ufwAl6/lVAVc2/Ra12
         Brzg==
X-Gm-Message-State: AO0yUKXe+63JAl8EUWM9igqNToJNZbZfJWAGaw2F1hgGhs3f20pG7r07
        Z8NCq3YQcwtq1OHPrrAhBEV9qfzMRg==
X-Google-Smtp-Source: AK7set/e/gq8gz7R6YCaK9c1AoNcAk4b2KXHEjOqeKZ2Me2Dp7xVCy6rqG1LsWLqkxPIcqB1DP/XxA==
X-Received: by 2002:a05:6e02:4c8:b0:315:9749:7a0e with SMTP id f8-20020a056e0204c800b0031597497a0emr3938435ils.23.1679243546912;
        Sun, 19 Mar 2023 09:32:26 -0700 (PDT)
Received: from robh_at_kernel.org ([2605:ef80:80c7:2689:137d:d795:47e4:3de1])
        by smtp.gmail.com with ESMTPSA id a6-20020a056638164600b003c4e65fd6dfsm2434348jat.176.2023.03.19.09.32.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Mar 2023 09:32:26 -0700 (PDT)
Received: (nullmailer pid 226421 invoked by uid 1000);
        Sun, 19 Mar 2023 16:32:23 -0000
From:   Rob Herring <robh@kernel.org>
To:     Vinod Koul <vkoul@kernel.org>
Cc:     dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] dmaengine: bestcomm: Use of_address_to_resource()
Date:   Sun, 19 Mar 2023 11:32:22 -0500
Message-Id: <20230319163222.226377-1-robh@kernel.org>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Replace of_get_address() and of_translate_address() calls with single
call to of_address_to_resource().

Signed-off-by: Rob Herring <robh@kernel.org>
---
 drivers/dma/bestcomm/sram.c | 19 ++++++++-----------
 1 file changed, 8 insertions(+), 11 deletions(-)

diff --git a/drivers/dma/bestcomm/sram.c b/drivers/dma/bestcomm/sram.c
index c465758e7193..103174cbda65 100644
--- a/drivers/dma/bestcomm/sram.c
+++ b/drivers/dma/bestcomm/sram.c
@@ -38,7 +38,7 @@ int bcom_sram_init(struct device_node *sram_node, char *owner)
 {
 	int rv;
 	const u32 *regaddr_p;
-	u64 regaddr64, size64;
+	struct resource res;
 	unsigned int psize;
 
 	/* Create our state struct */
@@ -56,21 +56,18 @@ int bcom_sram_init(struct device_node *sram_node, char *owner)
 	}
 
 	/* Get address and size of the sram */
-	regaddr_p = of_get_address(sram_node, 0, &size64, NULL);
-	if (!regaddr_p) {
+	rv = of_address_to_resource(sram_node, 0, &res);
+	if (rv) {
 		printk(KERN_ERR "%s: bcom_sram_init: "
 			"Invalid device node !\n", owner);
-		rv = -EINVAL;
 		goto error_free;
 	}
 
-	regaddr64 = of_translate_address(sram_node, regaddr_p);
-
-	bcom_sram->base_phys = (phys_addr_t) regaddr64;
-	bcom_sram->size = (unsigned int) size64;
+	bcom_sram->base_phys = res.start;
+	bcom_sram->size = resource_size(&res);
 
 	/* Request region */
-	if (!request_mem_region(bcom_sram->base_phys, bcom_sram->size, owner)) {
+	if (!request_mem_region(res.start, resource_size(&res), owner)) {
 		printk(KERN_ERR "%s: bcom_sram_init: "
 			"Couldn't request region !\n", owner);
 		rv = -EBUSY;
@@ -79,7 +76,7 @@ int bcom_sram_init(struct device_node *sram_node, char *owner)
 
 	/* Map SRAM */
 		/* sram is not really __iomem */
-	bcom_sram->base_virt = (void*) ioremap(bcom_sram->base_phys, bcom_sram->size);
+	bcom_sram->base_virt = (void*) ioremap(res.start, resource_size(&res));
 
 	if (!bcom_sram->base_virt) {
 		printk(KERN_ERR "%s: bcom_sram_init: "
@@ -120,7 +117,7 @@ int bcom_sram_init(struct device_node *sram_node, char *owner)
 	return 0;
 
 error_release:
-	release_mem_region(bcom_sram->base_phys, bcom_sram->size);
+	release_mem_region(res.start, resource_size(&res));
 error_free:
 	kfree(bcom_sram);
 	bcom_sram = NULL;
-- 
2.39.2

