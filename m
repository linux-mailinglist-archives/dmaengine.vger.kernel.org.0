Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4935A21163D
	for <lists+dmaengine@lfdr.de>; Thu,  2 Jul 2020 00:45:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726121AbgGAWpH (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 1 Jul 2020 18:45:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726114AbgGAWpH (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 1 Jul 2020 18:45:07 -0400
Received: from mail-qk1-x72a.google.com (mail-qk1-x72a.google.com [IPv6:2607:f8b0:4864:20::72a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 527FEC08C5C1
        for <dmaengine@vger.kernel.org>; Wed,  1 Jul 2020 15:45:07 -0700 (PDT)
Received: by mail-qk1-x72a.google.com with SMTP id q198so23907397qka.2
        for <dmaengine@vger.kernel.org>; Wed, 01 Jul 2020 15:45:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=timesys-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=pF0xLwtshGKkt1yna4aH5olO9PHhntT2t6nULfEUu/w=;
        b=A8ge2H1cE6a8lb3fCAW9kGNWU5UbkuxTYoU70Jwj6Dhz6e8eivlEPGTSlCXHv9sAQm
         lCYXfJ4VcTBsRO7kuJ/ckI10vfudcJDRqdQXZZ24PoJNL8fEAl7jzxatJswke9tban0r
         lFGFHJlpPuZP9qSbnjKUQpfG1D6f1DLQsueiUNOJ5Wq7vnPsu4nHkIpbvsZTluPzFy7H
         kYwdKQCSUne9ocMELJ52YU3oL2sKcvKgErjwRWIy0F+vDj8GVciROqifxbLAmre/1LdY
         IpJXak4WlXDf1UNzuj46ksdLc6PkG1Mri//vrBCfOs0/iajaiiuLkCetd8PQWW+k4WzR
         6+Ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=pF0xLwtshGKkt1yna4aH5olO9PHhntT2t6nULfEUu/w=;
        b=NnQuX0b2jOi/LkoFv+r+3TxY8M1zeleABUMRDOK/ovj7q0BUFUC8c6WF2JhfMYqFm5
         poqds3NJJqZSLZwYiIite8+nXSecFTDP/0CEfmgrF6owbgInKMnz6N339TbHMjSETkoM
         3BD1tA/jQZfwBMIWCeKZg2wcmgXAv5B8PirD3nEEwBnwQB+YNvr4uzvw5pgc19BDBLVk
         S3f1sBxOZ2MbZecnySvSZGtlhGqWbhaVAVIfAL4SYP3B3JxdqgSxgVz2tTZnP/4U2SUn
         SDuGY1HlqNebNjJdfGfnADdGoPsfofHj4CRvPiJMgsl4B2BSJQvH8OjVLrmeLp1iYtJU
         zDLQ==
X-Gm-Message-State: AOAM532MclJJA1Dvd+d6QYKjuolw/KyokoxxvO5K5kdi2gmX/F2fyuhw
        dL7TLdIsmn1wOVMsO0if4JsZ0g==
X-Google-Smtp-Source: ABdhPJyPGlR3ipW0EVVzzqOod4ZfhRBn1N0pzjvXkiLeMCo9EUxwMqPPRHCVYJLxpQaXY5S6jIeRsg==
X-Received: by 2002:a05:620a:4ca:: with SMTP id 10mr27939097qks.2.1593643506362;
        Wed, 01 Jul 2020 15:45:06 -0700 (PDT)
Received: from dfj.bfc.timesys.com (host-79-30-36-203.retail.telecomitalia.it. [79.30.36.203])
        by smtp.gmail.com with ESMTPSA id x36sm6844742qtb.78.2020.07.01.15.45.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Jul 2020 15:45:05 -0700 (PDT)
From:   Angelo Dureghello <angelo.dureghello@timesys.com>
To:     vkoul@kernel.org
Cc:     dmaengine@vger.kernel.org, peng.ma@nxp.com, maowenan@huawei.com,
        yibin.gong@nxp.com, festevam@gmail.com,
        Angelo Dureghello <angelo.dureghello@timesys.com>,
        kbuild test robot <lkp@intel.com>
Subject: [RESEND v2] dmaengine: fsl-edma: fix wrong tcd endianness for big-endian cpu
Date:   Thu,  2 Jul 2020 00:52:05 +0200
Message-Id: <20200701225205.1674463-1-angelo.dureghello@timesys.com>
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
 1 file changed, 14 insertions(+), 12 deletions(-)

diff --git a/drivers/dma/fsl-edma-common.c b/drivers/dma/fsl-edma-common.c
index 5697c3622699..9285884758b2 100644
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
+	edma_writew(edma, tcd->soff, &regs->tcd[ch].soff);
 
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
-- 
2.26.2

