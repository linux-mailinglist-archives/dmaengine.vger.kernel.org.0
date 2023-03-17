Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E2F36BE820
	for <lists+dmaengine@lfdr.de>; Fri, 17 Mar 2023 12:33:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229896AbjCQLdK (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 17 Mar 2023 07:33:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230016AbjCQLdG (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 17 Mar 2023 07:33:06 -0400
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A9CD6EB82
        for <dmaengine@vger.kernel.org>; Fri, 17 Mar 2023 04:32:56 -0700 (PDT)
Received: by mail-pl1-x630.google.com with SMTP id v21so4965528ple.9
        for <dmaengine@vger.kernel.org>; Fri, 17 Mar 2023 04:32:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=igel-co-jp.20210112.gappssmtp.com; s=20210112; t=1679052776;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5sI1q8FeCzoYjS80FmoBFGlXkDMRicrucbVZQV9c508=;
        b=wtuEZ6mlE8yg3VIJrKgHJ8dxGzj9nc/+1LNPpzE/t7m7nzMWHIbgWeb86J9hRAi91l
         72XaVrh9ZwfvmMuoJ8toT+QOBHeTUOVbQY7e59rUy4gqx4UhUHBvwkAel4ljh4iPwMcI
         lnXvt8iO39tYxEYzMfMEGf8tCqLJ2RMovRACyBYEug7De+x3HnSlu9cDdu952iVB1Rmk
         Dw9SW3Vmdp1BveJfi2a2FplQyfknon1qcXKBKcyybzVKeumW/kLaxyhj5MiZwHkG29an
         hbAHQItpw41sOAjdNuHGr6CeItUEFHQxF/o0248m1qTbpxOT6k5YoZhDVo9/A8L9rxZY
         vJ9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679052776;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5sI1q8FeCzoYjS80FmoBFGlXkDMRicrucbVZQV9c508=;
        b=XtEOotZF/24AUA3glYDtCb2ff8m19rVdxcMtyAOYN0xlXzrnggPmf68afcb0EjIRfg
         LoTMmord8cWJrq4VclIHONfa2gdaRbGDGqLCc2v58dZqzrRpD8i1PPlamLUElrnHhIpc
         kG3QwwgF2sjdrmJ+Bn0SHnGmBUzMCRmT3uClDupNraqXUscxcN2W7uO9QOJyQgfVeEQn
         Aix3f+OI7ARMm0uvd6oXLz8NZIbeHmNji9Ju2fjoRYz0ZDhUEQni6eeSSmIAYSAISnML
         hI8HWgOpIkdBx4WVLdBJ4IJnHlzwbKsMcfxZmHQ3a7dOylDrm72qBrI+ZZ2tBkCmIDLQ
         ViTw==
X-Gm-Message-State: AO0yUKW9REDc1EdRx3rI5SYZQkGDREXTjMmt1l1MRT0NWvNpkaGMIvBt
        5EEwWfHO30iJRtl7Z1/HNbc2zQ==
X-Google-Smtp-Source: AK7set8HF6l0jo84zLOB7MX/fRtN4brKhFNLhH2+J96cVLUVYh0wHNh/ZygV2azN5x17QV/AqFWT6w==
X-Received: by 2002:a17:90b:3b4d:b0:233:ee50:d28b with SMTP id ot13-20020a17090b3b4d00b00233ee50d28bmr8170087pjb.16.1679052776174;
        Fri, 17 Mar 2023 04:32:56 -0700 (PDT)
Received: from tyrell.hq.igel.co.jp (napt.igel.co.jp. [219.106.231.132])
        by smtp.gmail.com with ESMTPSA id e3-20020a17090a818300b00233aacab89esm1182904pjn.48.2023.03.17.04.32.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Mar 2023 04:32:55 -0700 (PDT)
From:   Shunsuke Mie <mie@igel.co.jp>
To:     Gustavo Pimentel <gustavo.pimentel@synopsys.com>
Cc:     Vinod Koul <vkoul@kernel.org>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Shunsuke Mie <mie@igel.co.jp>,
        Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        Frank Li <Frank.Li@nxp.com>, linux-kernel@vger.kernel.org,
        dmaengine@vger.kernel.org, linux-pci@vger.kernel.org
Subject: [RFC PATCH 03/11] pci: endpoint: function/pci-epf-test: Unify a range of time measurement
Date:   Fri, 17 Mar 2023 20:32:30 +0900
Message-Id: <20230317113238.142970-4-mie@igel.co.jp>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230317113238.142970-1-mie@igel.co.jp>
References: <20230317113238.142970-1-mie@igel.co.jp>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

This test code measures a time of data transfer. Some measurements include
print, preparation and error checking. Change to measure during data
tansfer.

Signed-off-by: Shunsuke Mie <mie@igel.co.jp>
---
 drivers/pci/endpoint/functions/pci-epf-test.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/drivers/pci/endpoint/functions/pci-epf-test.c b/drivers/pci/endpoint/functions/pci-epf-test.c
index 172e5ac0bd96..6955a3d2eb7e 100644
--- a/drivers/pci/endpoint/functions/pci-epf-test.c
+++ b/drivers/pci/endpoint/functions/pci-epf-test.c
@@ -356,7 +356,6 @@ static int pci_epf_test_copy(struct pci_epf_test *epf_test)
 		goto err_dst_addr;
 	}
 
-	ktime_get_ts64(&start);
 	use_dma = !!(reg->flags & FLAG_USE_DMA);
 	if (use_dma) {
 		if (!epf_test->dma_supported) {
@@ -371,9 +370,11 @@ static int pci_epf_test_copy(struct pci_epf_test *epf_test)
 			goto err_map_addr;
 		}
 
+		ktime_get_ts64(&start);
 		ret = pci_epf_test_data_transfer(epf_test, dst_phys_addr,
 						 src_phys_addr, reg->size, 0,
 						 DMA_MEM_TO_MEM);
+		ktime_get_ts64(&end);
 		if (ret)
 			dev_err(dev, "Data transfer failed\n");
 	} else {
@@ -385,11 +386,13 @@ static int pci_epf_test_copy(struct pci_epf_test *epf_test)
 			goto err_map_addr;
 		}
 
+		ktime_get_ts64(&start);
 		memcpy_fromio(buf, src_addr, reg->size);
 		memcpy_toio(dst_addr, buf, reg->size);
+		ktime_get_ts64(&end);
 		kfree(buf);
 	}
-	ktime_get_ts64(&end);
+
 	pci_epf_test_print_rate("COPY", reg->size, &start, &end, use_dma);
 
 err_map_addr:
@@ -467,9 +470,9 @@ static int pci_epf_test_read(struct pci_epf_test *epf_test)
 		ret = pci_epf_test_data_transfer(epf_test, dst_phys_addr,
 						 phys_addr, reg->size,
 						 reg->src_addr, DMA_DEV_TO_MEM);
+		ktime_get_ts64(&end);
 		if (ret)
 			dev_err(dev, "Data transfer failed\n");
-		ktime_get_ts64(&end);
 
 		dma_unmap_single(dma_dev, dst_phys_addr, reg->size,
 				 DMA_FROM_DEVICE);
@@ -556,14 +559,13 @@ static int pci_epf_test_write(struct pci_epf_test *epf_test)
 		}
 
 		ktime_get_ts64(&start);
-
 		ret = pci_epf_test_data_transfer(epf_test, phys_addr,
 						 src_phys_addr, reg->size,
 						 reg->dst_addr,
 						 DMA_MEM_TO_DEV);
+		ktime_get_ts64(&end);
 		if (ret)
 			dev_err(dev, "Data transfer failed\n");
-		ktime_get_ts64(&end);
 
 		dma_unmap_single(dma_dev, src_phys_addr, reg->size,
 				 DMA_TO_DEVICE);
-- 
2.25.1

