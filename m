Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DBF8A1E88A1
	for <lists+dmaengine@lfdr.de>; Fri, 29 May 2020 22:10:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728025AbgE2UKP (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 29 May 2020 16:10:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727947AbgE2UKN (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 29 May 2020 16:10:13 -0400
Received: from mail-qv1-xf42.google.com (mail-qv1-xf42.google.com [IPv6:2607:f8b0:4864:20::f42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70ECEC08C5C9
        for <dmaengine@vger.kernel.org>; Fri, 29 May 2020 13:10:13 -0700 (PDT)
Received: by mail-qv1-xf42.google.com with SMTP id f89so1694337qva.3
        for <dmaengine@vger.kernel.org>; Fri, 29 May 2020 13:10:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=timesys-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=sI6+t2RGnqdJI+o2QtkR9Ijh9FqP2N7+xShI+lBQcQM=;
        b=O8qgaeezwWhc9JYET9j/IedalUKv+OogfcY31UvGHw4AM/QnRc6VjbNGhVjrlCvkGz
         nttsx71m/1EJjNx3SISEoHq5+32QLXaVq1raDx4vz83+qPh5U0ZOBw622ug5r8Qx7m0x
         c02RfRJ8PONu4albkSOGpX05oQNjKHVaYRiylLE6cpn7p6xo2dm/dhCyLczTrDLKRfHm
         1FiYPi2pwumS/a+L4+7r3i1LjuXf+szA9G6f5Tcmd6ij1bA3LI/QcHLDFWYYZ46WgEgu
         CuyJdzbVkdv3nAC4hTEjj2vxraDgDGe6ezqzmyKGdjeFjZCWA8K0Ax05zFYbYr2YvFE/
         Yy2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=sI6+t2RGnqdJI+o2QtkR9Ijh9FqP2N7+xShI+lBQcQM=;
        b=Jxcam0dZAY9frLcnTf/qs2m1DhRuyY495Z/bjfm9uOBk/+PYED2UQ9pP/+xRDqO1fT
         q0btDrRvrKuS+5ezCOGhxCam9QGNkD/rvCemakRoLlrp38K+X1XwNVAYNJeZ4Sk+9hwd
         j2fPf3XmQLOPr9vgPxEkX14d4UNkOdyNekJUzcCje8hJXmwT5XlqpAw+RcG8xaM/Q4Bv
         xXfttwJvlKJhTftekEz5Srjuh4ay4iOySkC/ZAl3ZGViDXtIRNDRlUKtVfP9EakLXLd+
         D84Ttj6NqMJRvFVhXueK0EPcLhzZcmW28xj5pOG7pAZB888mHHEHE7F4/X9qe2fqHLvV
         NI8w==
X-Gm-Message-State: AOAM53306oaZkWOcy7tlEIwEm/eSn0h0yy89/uIbpjLhIgJG/k4fyyJ9
        Us36XDUFxzfpz8Jf9CQuCSNRaA==
X-Google-Smtp-Source: ABdhPJxP908DBJqJmmX05IExIi0uGCK/+3h8CiPFy12rPdcMKC2Qcc2wGLLhjrfcHedU9JGb/NViCA==
X-Received: by 2002:a0c:dd8e:: with SMTP id v14mr9853524qvk.169.1590783012673;
        Fri, 29 May 2020 13:10:12 -0700 (PDT)
Received: from dfj.bfc.timesys.com (host203-36-dynamic.30-79-r.retail.telecomitalia.it. [79.30.36.203])
        by smtp.gmail.com with ESMTPSA id u16sm7879759qkm.107.2020.05.29.13.10.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 May 2020 13:10:12 -0700 (PDT)
From:   Angelo Dureghello <angelo.dureghello@timesys.com>
To:     vkoul@kernel.org
Cc:     dmaengine@vger.kernel.org, peng.ma@nxp.com, maowenan@huawei.com,
        yibin.gong@nxp.com, festevam@gmail.com,
        Angelo Dureghello <angelo.dureghello@timesys.com>
Subject: [PATCH] dmaengine: fsl-edma: fix wrong tcd endianness for big-endian cpu
Date:   Fri, 29 May 2020 22:15:45 +0200
Message-Id: <20200529201545.192901-1-angelo.dureghello@timesys.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Due to recent fixes in m68k arch-specific I/O accessor macros, this
driver is not working anymore for ColdFire. Fix wrong tcd endianness
removing additional swaps, since edma_xxx() functions should already
take care of any eventual swap when needed.

Note, i could only test the change in ColdFire mcf54415 and Vybrid
vf50 / Colibri where i don't see any issue. So, every feedback and
test for all other SoCs involved is really appreciated.

Signed-off-by: Angelo Dureghello <angelo.dureghello@timesys.com>
---
 drivers/dma/fsl-edma-common.c | 25 ++++++++++++-------------
 1 file changed, 12 insertions(+), 13 deletions(-)

diff --git a/drivers/dma/fsl-edma-common.c b/drivers/dma/fsl-edma-common.c
index 5697c3622699..2008d0cedb66 100644
--- a/drivers/dma/fsl-edma-common.c
+++ b/drivers/dma/fsl-edma-common.c
@@ -353,25 +353,24 @@ static void fsl_edma_set_tcd_regs(struct fsl_edma_chan *fsl_chan,
 	 * TCD parameters are stored in struct fsl_edma_hw_tcd in little
 	 * endian format. However, we need to load the TCD registers in
 	 * big- or little-endian obeying the eDMA engine model endian.
+	 * The swap, when needed, is performed from edma_xxx() functions.
 	 */
 	edma_writew(edma, 0,  &regs->tcd[ch].csr);
-	edma_writel(edma, le32_to_cpu(tcd->saddr), &regs->tcd[ch].saddr);
-	edma_writel(edma, le32_to_cpu(tcd->daddr), &regs->tcd[ch].daddr);
+	edma_writel(edma, tcd->saddr, &regs->tcd[ch].saddr);
+	edma_writel(edma, tcd->daddr, &regs->tcd[ch].daddr);
 
-	edma_writew(edma, le16_to_cpu(tcd->attr), &regs->tcd[ch].attr);
-	edma_writew(edma, le16_to_cpu(tcd->soff), &regs->tcd[ch].soff);
+	edma_writew(edma, tcd->attr, &regs->tcd[ch].attr);
+	edma_writew(edma, tcd->soff, &regs->tcd[ch].soff);
 
-	edma_writel(edma, le32_to_cpu(tcd->nbytes), &regs->tcd[ch].nbytes);
-	edma_writel(edma, le32_to_cpu(tcd->slast), &regs->tcd[ch].slast);
+	edma_writel(edma, tcd->nbytes, &regs->tcd[ch].nbytes);
+	edma_writel(edma, tcd->slast, &regs->tcd[ch].slast);
 
-	edma_writew(edma, le16_to_cpu(tcd->citer), &regs->tcd[ch].citer);
-	edma_writew(edma, le16_to_cpu(tcd->biter), &regs->tcd[ch].biter);
-	edma_writew(edma, le16_to_cpu(tcd->doff), &regs->tcd[ch].doff);
+	edma_writew(edma, tcd->citer, &regs->tcd[ch].citer);
+	edma_writew(edma, tcd->biter, &regs->tcd[ch].biter);
+	edma_writew(edma, tcd->doff, &regs->tcd[ch].doff);
+	edma_writel(edma, tcd->dlast_sga, &regs->tcd[ch].dlast_sga);
 
-	edma_writel(edma, le32_to_cpu(tcd->dlast_sga),
-			&regs->tcd[ch].dlast_sga);
-
-	edma_writew(edma, le16_to_cpu(tcd->csr), &regs->tcd[ch].csr);
+	edma_writew(edma, tcd->csr, &regs->tcd[ch].csr);
 }
 
 static inline
-- 
2.26.2

