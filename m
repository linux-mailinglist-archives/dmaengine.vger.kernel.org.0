Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B174C211630
	for <lists+dmaengine@lfdr.de>; Thu,  2 Jul 2020 00:40:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726121AbgGAWk4 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 1 Jul 2020 18:40:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725817AbgGAWk4 (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 1 Jul 2020 18:40:56 -0400
Received: from mail-qt1-x844.google.com (mail-qt1-x844.google.com [IPv6:2607:f8b0:4864:20::844])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56555C08C5C1
        for <dmaengine@vger.kernel.org>; Wed,  1 Jul 2020 15:40:56 -0700 (PDT)
Received: by mail-qt1-x844.google.com with SMTP id g13so19783404qtv.8
        for <dmaengine@vger.kernel.org>; Wed, 01 Jul 2020 15:40:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=timesys-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=oBo8xy4ydTY3CUuRue4PEYfhF7EozU+5QzAOQrR51DE=;
        b=UKY29/dDYl6GDa7f+eWwC1ZjeB1AHyLc7F2QikCQVlpd6K8tsypWmk+f8WDI5hgvBv
         f9nhBSfUTeNxaccdF6DnXWIwyisi1A9nc1V4YwK2SLiPzNHxZoV+4HXYACEHMEfkPlHZ
         7JqGL4g8W37mG1UTMnHgQiDDlQnlgP6FTRkFcHlu18XDP7oiCdR+DRfAKhIGXoFzDKsp
         cjRI3oY6y8JFdnEfoThjqsqkt7Po9ZM9Pegh57V78X85zYSI6jjtb80t0Y+QiL5v8O79
         N/YpLX/E47KBVbz1La/BKtyiURY1fDNKPxEe25ZS41dGYUqsf/frpYCZtY66DhSroVb5
         P0PQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=oBo8xy4ydTY3CUuRue4PEYfhF7EozU+5QzAOQrR51DE=;
        b=PPb1M+0SlzLgi5TF+2SDhy2L3c+RM1SDNX1OuikQLMcxUZecmp0kk9d0hXrbfET5DZ
         qbLu62oyG0iqOECd7xisiAnJzHlLtbnBfBcSgtStuz7lUixRclpkipHJxqzWA1y2VCBu
         VWRiafp7m91IMEv7JJKs5ADIr3fx0bRvckI8+B9yx+Iz9qpa0rd/bARWtipcFej5rGuN
         sfoiXweunLzutSqYirPZ0kIoYQ+Nh4h/8Bdj4XywYPC5oppin+jX5EyxGGNg7r+gTeOW
         gLsqGOWevTiugbVfEQ2DRcT8HINDphGcsrbuhj1It/lT1UAiAopGT85Ju/oHOTE8421F
         AQUw==
X-Gm-Message-State: AOAM5330vpaJfl3NSM0SMXwhvkex98EKg1vlrHk+4zTOuyA+JHbjL1co
        1FwUzAfXhfm0o7gqQuJjmaiYhg==
X-Google-Smtp-Source: ABdhPJzvcRuooctl8K6lDKRIiKyw7xQkvXXUszAq84eTWOuzHk1hyBKhMj+2al27O02IYbazODRgwg==
X-Received: by 2002:ac8:18a5:: with SMTP id s34mr27557206qtj.210.1593643255518;
        Wed, 01 Jul 2020 15:40:55 -0700 (PDT)
Received: from dfj.bfc.timesys.com (host-79-30-36-203.retail.telecomitalia.it. [79.30.36.203])
        by smtp.gmail.com with ESMTPSA id o50sm7404982qtc.64.2020.07.01.15.40.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Jul 2020 15:40:54 -0700 (PDT)
From:   Angelo Dureghello <angelo.dureghello@timesys.com>
To:     vkoul@kernel.org
Cc:     dmaengine@vger.kernel.org, peng.ma@nxp.com, maowenan@huawei.com,
        yibin.gong@nxp.com, festevam@gmail.com,
        Angelo Dureghello <angelo.dureghello@timesys.com>,
        kbuild test robot <lkp@intel.com>
Subject: [PATCH v2] dmaengine: fsl-edma: fix wrong tcd endianness for big-endian cpu
Date:   Thu,  2 Jul 2020 00:47:40 +0200
Message-Id: <20200701224740.1672903-1-angelo.dureghello@timesys.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Due to recent fixes in m68k arch-specific I/O accessor macros, this
driver is not working anymore for ColdFire. Fix wrong tcd endianness
removing additional swaps, since edma_writex() functions should already
take care of any eventual swap if needed.

Note, i could only test the change in ColdFire mcf54415 and Vybrid
vf50 / Colibri where i don't see any issue. So, every feedback and
test for all other SoCs involved is really appreciated.
---
Changes for v2:
- fix build robot (sparse) wrong endianness warnings

Signed-off-by: Angelo Dureghello <angelo.dureghello@timesys.com>
Reported-by: kbuild test robot <lkp@intel.com>
---
 drivers/dma/fsl-edma-common.c | 26 ++++++++++++++------------
 drivers/spi/spi-fsl-dspi.c    |  2 +-
 2 files changed, 15 insertions(+), 13 deletions(-)

diff --git a/drivers/dma/fsl-edma-common.c b/drivers/dma/fsl-edma-common.c
index 5697c3622699..8570e122e61e 100644
--- a/drivers/dma/fsl-edma-common.c
+++ b/drivers/dma/fsl-edma-common.c
@@ -352,26 +352,28 @@ static void fsl_edma_set_tcd_regs(struct fsl_edma_chan *fsl_chan,
 	/*
 	 * TCD parameters are stored in struct fsl_edma_hw_tcd in little
 	 * endian format. However, we need to load the TCD registers in
-	 * big- or little-endian obeying the eDMA engine model endian.
+	 * big- or little-endian obeying the eDMA engine model endian,
+	 * and this is performed from specific edma_write functions
 	 */
 	edma_writew(edma, 0,  &regs->tcd[ch].csr);
-	edma_writel(edma, le32_to_cpu(tcd->saddr), &regs->tcd[ch].saddr);
-	edma_writel(edma, le32_to_cpu(tcd->daddr), &regs->tcd[ch].daddr);
 
-	edma_writew(edma, le16_to_cpu(tcd->attr), &regs->tcd[ch].attr);
-	edma_writew(edma, le16_to_cpu(tcd->soff), &regs->tcd[ch].soff);
+	edma_writel(edma, (s32)tcd->saddr, &regs->tcd[ch].saddr);
+	edma_writel(edma, (s32)tcd->daddr, &regs->tcd[ch].daddr);
 
-	edma_writel(edma, le32_to_cpu(tcd->nbytes), &regs->tcd[ch].nbytes);
-	edma_writel(edma, le32_to_cpu(tcd->slast), &regs->tcd[ch].slast);
+	edma_writew(edma, (s16)tcd->attr, &regs->tcd[ch].attr);
+	edma_writew(edma, (s16)tcd->soff, &regs->tcd[ch].soff);
 
-	edma_writew(edma, le16_to_cpu(tcd->citer), &regs->tcd[ch].citer);
-	edma_writew(edma, le16_to_cpu(tcd->biter), &regs->tcd[ch].biter);
-	edma_writew(edma, le16_to_cpu(tcd->doff), &regs->tcd[ch].doff);
+	edma_writel(edma, (s32)tcd->nbytes, &regs->tcd[ch].nbytes);
+	edma_writel(edma, (s32)tcd->slast, &regs->tcd[ch].slast);
 
-	edma_writel(edma, le32_to_cpu(tcd->dlast_sga),
+	edma_writew(edma, (s16)tcd->citer, &regs->tcd[ch].citer);
+	edma_writew(edma, (s16)tcd->biter, &regs->tcd[ch].biter);
+	edma_writew(edma, (s16)tcd->doff, &regs->tcd[ch].doff);
+
+	edma_writel(edma, (s32)tcd->dlast_sga,
 			&regs->tcd[ch].dlast_sga);
 
-	edma_writew(edma, le16_to_cpu(tcd->csr), &regs->tcd[ch].csr);
+	edma_writew(edma, (s16)tcd->csr, &regs->tcd[ch].csr);
 }
 
 static inline
diff --git a/drivers/spi/spi-fsl-dspi.c b/drivers/spi/spi-fsl-dspi.c
index 58190c94561f..2a2bc7ae8e02 100644
--- a/drivers/spi/spi-fsl-dspi.c
+++ b/drivers/spi/spi-fsl-dspi.c
@@ -189,7 +189,7 @@ static const struct fsl_dspi_devtype_data devtype_data[] = {
 		.fifo_size		= 4,
 	},
 	[MCF5441X] = {
-		.trans_mode		= DSPI_EOQ_MODE,
+		.trans_mode		= DSPI_DMA_MODE,
 		.max_clock_factor	= 8,
 		.fifo_size		= 16,
 	},
-- 
2.26.2

