Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 11A7A34C035
	for <lists+dmaengine@lfdr.de>; Mon, 29 Mar 2021 01:58:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231782AbhC1X6V (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Sun, 28 Mar 2021 19:58:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231911AbhC1X6I (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Sun, 28 Mar 2021 19:58:08 -0400
Received: from mail-qt1-x836.google.com (mail-qt1-x836.google.com [IPv6:2607:f8b0:4864:20::836])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE0D9C061756;
        Sun, 28 Mar 2021 16:58:07 -0700 (PDT)
Received: by mail-qt1-x836.google.com with SMTP id g24so8231530qts.6;
        Sun, 28 Mar 2021 16:58:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=NJwGboF3RRjxp++ZERmPQjReWWVKr/czZXPuA+ZJx80=;
        b=YL9DmbE2fe0BApSWAt2uHCdURo+Rz+Rr5GPOuD10WlMJxvjxgDIyyDM3ifIcvvFf0U
         gcHFBmE54d+3KH4GKg8iBAbwJWZlANd7lr6vJAYD4G9J3iSs9fFEc0DzrVMnX38/kG6P
         RJbrTE5VSk49lSyEs8UvPXBlWiDPiTcK4eOBOcIgR1St56TAKdCSryZn0q84c3m+KGM7
         s8XD83myVeBcsZjrO6SlOUShzdK8/g4TPaF96Oa/YASCcUSk06hFuZSxlBgiMcaJpQKm
         i06egdkTzyqoTyu9lUskiJSdlxdgPxtUPgPXwD0kgeJVE3IOcizvkW/yV7TLUyM+fCMH
         j1Tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=NJwGboF3RRjxp++ZERmPQjReWWVKr/czZXPuA+ZJx80=;
        b=YiNXl8oj1mIpkRiG0crKYzybquc17C+i08Uzy0s5OvkFKaKjx4+MiVDEYHGWLvv8qk
         ypUlhAOR9n0H2m0ZIdhwGm7aMp2YEMWmg2FIRjyWZXJHaRQJxpsYCQL0WDfajFjCb5JI
         CfOOtp48Q7tbM3YM794BgvRg8S6LN8HeVAPS8++CdZ24rAJjucVyhCygyaaJhR5wmYiF
         mWVAqIVjFrPcEcKPt9vBTD3NdAbtW6OKoXMOOHzoARJp4Xp7PsiYG6qhPT6T6GzNltEl
         rZb3X9lbPQbuAu7fVkw12Zm/Wpa+lJg/61LXRCYsKAkXCIyZQ05zHN/UE0YqMTAgdho+
         2uWQ==
X-Gm-Message-State: AOAM531dwxkPCnlOrUFR691n6hX5FgepIR8lA4W9YBN0PQBLf0rquzyD
        Y6MnuMlGXnVETVS/ymU/IRso8ENJ/VgcpT2Q
X-Google-Smtp-Source: ABdhPJx9IaqtHu2JrNlJIS8s9C3nSt+b7/qaYIDs+xEjbuoo0gr+h5DM6WDJ9l2kCetRDAOn+2QZpA==
X-Received: by 2002:ac8:46cc:: with SMTP id h12mr21317176qto.105.1616975886810;
        Sun, 28 Mar 2021 16:58:06 -0700 (PDT)
Received: from localhost.localdomain ([156.146.58.24])
        by smtp.gmail.com with ESMTPSA id y19sm12153061qky.111.2021.03.28.16.58.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Mar 2021 16:58:06 -0700 (PDT)
From:   Bhaskar Chowdhury <unixbhaskar@gmail.com>
To:     dmaengine@vger.kernel.org, dri-devel@lists.freedesktop.org,
        hch@lst.de, iommu@lists.linux-foundation.org,
        linuxppc-dev@lists.ozlabs.org, dave.jiang@intel.com,
        dan.j.williams@intel.com
Cc:     Bhaskar Chowdhury <unixbhaskar@gmail.com>, rdunlap@infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 26/30] dw-axi-dmac-platform.c: Few typos fixed
Date:   Mon, 29 Mar 2021 05:23:22 +0530
Message-Id: <01f2fed34eca736091a46dfee38381882e5dc5e9.1616971780.git.unixbhaskar@gmail.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <cover.1616971780.git.unixbhaskar@gmail.com>
References: <cover.1616971780.git.unixbhaskar@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

s/configurarion/configuration/
s/inerrupts/interrupts/
s/chanels/channels/  ....two different places.
s/Synopsys/Synopsis/

Signed-off-by: Bhaskar Chowdhury <unixbhaskar@gmail.com>
---
 drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c b/drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c
index d9e4ac3edb4e..ef4da10361a7 100644
--- a/drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c
+++ b/drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c
@@ -35,7 +35,7 @@
 /*
  * The set of bus widths supported by the DMA controller. DW AXI DMAC supports
  * master data bus width up to 512 bits (for both AXI master interfaces), but
- * it depends on IP block configurarion.
+ * it depends on IP block configuration.
  */
 #define AXI_DMA_BUSWIDTHS		  \
 	(DMA_SLAVE_BUSWIDTH_1_BYTE	| \
@@ -1056,10 +1056,10 @@ static irqreturn_t dw_axi_dma_interrupt(int irq, void *dev_id)

 	u32 status, i;

-	/* Disable DMAC inerrupts. We'll enable them after processing chanels */
+	/* Disable DMAC interrupts. We'll enable them after processing channels */
 	axi_dma_irq_disable(chip);

-	/* Poll, clear and process every chanel interrupt status */
+	/* Poll, clear and process every channel interrupt status */
 	for (i = 0; i < dw->hdata->nr_channels; i++) {
 		chan = &dw->chan[i];
 		status = axi_chan_irq_read(chan);
@@ -1511,5 +1511,5 @@ static struct platform_driver dw_driver = {
 module_platform_driver(dw_driver);

 MODULE_LICENSE("GPL v2");
-MODULE_DESCRIPTION("Synopsys DesignWare AXI DMA Controller platform driver");
+MODULE_DESCRIPTION("Synopsis DesignWare AXI DMA Controller platform driver");
 MODULE_AUTHOR("Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>");
--
2.26.3

