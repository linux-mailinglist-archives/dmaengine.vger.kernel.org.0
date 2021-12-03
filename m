Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0641A4671CB
	for <lists+dmaengine@lfdr.de>; Fri,  3 Dec 2021 07:11:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350423AbhLCGOw (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 3 Dec 2021 01:14:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238272AbhLCGOv (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 3 Dec 2021 01:14:51 -0500
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B4F4C06174A;
        Thu,  2 Dec 2021 22:11:27 -0800 (PST)
Received: by mail-pj1-x102c.google.com with SMTP id np6-20020a17090b4c4600b001a90b011e06so1614119pjb.5;
        Thu, 02 Dec 2021 22:11:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Qe9TsMPoc9Li6+dUgwQtyeT32RNAnDmS4X1L/pUrWR8=;
        b=nCkVuC2ZxAKGT0FNO/lfEwz+llY5WO5JxM9G5Q25is+6dflVNvNraPGCjV+GRp3sR7
         jObfAmYF0YYxQ4zCOKW6yKb/S2FUTNNDy3bYUps5lnlCCuGPz357KqSUurGTQosXKAK3
         xNWM5LIkqdcWRVvOxG3zBroSJOc2V41XR2owuGTMK+UL8j4YVwot8Fh9N+KXJQZypZjr
         kAO3sd/SrqYnN/pNM0Kletuw3U8JDSUewL7Gsnl97sdvIiDy5JvHa38r8+ldJbcC6A+x
         GzMp7l7fs1z9j9AHeRqRaZJ8RSeVWMbKWCcV6Pc8yc4nh1DKrdCn0HZSbEgeoYwZjA1R
         61sQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Qe9TsMPoc9Li6+dUgwQtyeT32RNAnDmS4X1L/pUrWR8=;
        b=N35kZnha+BydPbdLG6N9jfLAehUDmprYfrn591gd6URmCRC897l43Uje5siAmsEn6l
         SqehJDIPSTM0KlfdNo9ePUNzsIbWXBvLBlAKNt6siamYdvc7vnpCs0mhdpIs2qj+zsoo
         dTvmLMpyFQoWTALDppLiSv61Z6Ape59exJKBoYDAYo80BTwENCAWEVQ1Xc3LVEWGP7M9
         UHPQ3OA0kKZAw7GYpn4Yi8DIx5XIvthLeIsz+Pj0wDuFyOsb1q48HMtuAo7bYkCo4DlJ
         csQGVy66SwrmdjZvD1pKM9UkXQBNXhSzQfI8iz7aNYCIHVGXXvDQIOFcFNymfz7nQgVz
         28bg==
X-Gm-Message-State: AOAM533purttWvDkeeg1r0410p5tDMIg/sBJ20fWDbTLZ4mJuSnCu2fA
        eRNNyaDjf+nxE5tAJMp75A==
X-Google-Smtp-Source: ABdhPJx9oW6yrUXXx5Nyk1wOX9/D/Es4lkJxt/ROQWOPEAqNLUHWf8onuCZDn8d1hiQ1otNwHfw99g==
X-Received: by 2002:a17:903:10d:b0:142:6343:a48e with SMTP id y13-20020a170903010d00b001426343a48emr20546375plc.29.1638511886980;
        Thu, 02 Dec 2021 22:11:26 -0800 (PST)
Received: from localhost.localdomain ([202.112.238.128])
        by smtp.gmail.com with ESMTPSA id y23sm1216315pgf.86.2021.12.02.22.11.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Dec 2021 22:11:26 -0800 (PST)
From:   Zheyu Ma <zheyuma97@gmail.com>
To:     gustavo.pimentel@synopsys.com, vkoul@kernel.org
Cc:     dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
        Zheyu Ma <zheyuma97@gmail.com>
Subject: [PATCH] dmaengine: dw-edma: Fix error handling in dw_edma_pcied_probe()
Date:   Fri,  3 Dec 2021 06:11:15 +0000
Message-Id: <20211203061115.19458-1-zheyuma97@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

When err is a non-zero value, it means failure.

Signed-off-by: Zheyu Ma <zheyuma97@gmail.com>
---
 drivers/dma/dw-edma/dw-edma-pcie.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/dma/dw-edma/dw-edma-pcie.c b/drivers/dma/dw-edma/dw-edma-pcie.c
index 198f6cd8ac1b..92c4f5b7d229 100644
--- a/drivers/dma/dw-edma/dw-edma-pcie.c
+++ b/drivers/dma/dw-edma/dw-edma-pcie.c
@@ -187,12 +187,10 @@ static int dw_edma_pcie_probe(struct pci_dev *pdev,
 
 	/* DMA configuration */
 	err = dma_set_mask_and_coherent(&pdev->dev, DMA_BIT_MASK(64));
-	if (!err) {
+	if (err) {
 		pci_err(pdev, "DMA mask 64 set failed\n");
 		return err;
 	} else {
-		pci_err(pdev, "DMA mask 64 set failed\n");
-
 		err = dma_set_mask_and_coherent(&pdev->dev, DMA_BIT_MASK(32));
 		if (err) {
 			pci_err(pdev, "DMA mask 32 set failed\n");
-- 
2.25.1

