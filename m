Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3ADA658881
	for <lists+dmaengine@lfdr.de>; Thu, 27 Jun 2019 19:35:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726550AbfF0Rfn (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 27 Jun 2019 13:35:43 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:44858 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726542AbfF0Rfn (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 27 Jun 2019 13:35:43 -0400
Received: by mail-pl1-f195.google.com with SMTP id t7so1660019plr.11;
        Thu, 27 Jun 2019 10:35:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=swE2uPeKQhZkn33ToHN0/DGisXtpeV3c7xG1CSkw2+k=;
        b=Miy6dVwuphqr0+9kYCyN1mdCjUPNegKo3U/+jmoyKUClmFp7MPluirtH8Z+Nw+RKBN
         3eXqH5NvFlFjeLHWjlhaTdvYVEk28pRatoMtSHwEN0fG3I7pIxLan/nZ+xXIygT9qB2i
         SsYL3BUCqVLpX3Y0c0pBJ6wW60QbBFvwq1uK+kS0PFokK64IRKEo2bo8XgxTxyrLEPoF
         BLsDUjEoVc8s4x6BXDSp0zqnSZjPZbwdDVeZwEfv/Apa97ih8qy2cnu8zqI56FBKe+NY
         04RfHsEwz8iH0uzJUsuyugOC54n4B2Zp4bELVfl2HkNF9KychUb+JnOpPcIhUGSyFcpR
         PKfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=swE2uPeKQhZkn33ToHN0/DGisXtpeV3c7xG1CSkw2+k=;
        b=mO88xnwKIRSXWRyMGttQs0G7nWqUefacy/pKM7TD42LJqDJEGKacwPNdHHqzuBZKKj
         HLav0z5NU+6iJRrhGMthDWgB8SRxiLgYe5r6s7A0XlIOqShX8ndIKpR3YSR9Mel1Em4W
         zMHpe2dLxDIVoTJq0QEzuBxyw7PqA5BpI6lZ0nmrmTnPwp6kJeJmclxxccPINh9woco/
         4nD/U8540rLWJ7zzvOwrLIsyrvXFEgHAdbg6BqF5HhuvYmcJGI04hRIKPv2YrobcdJTN
         XF6Lxd0gi8ykW8i0MD5Jt7ZIG4XN9VPrFIGFA6LIky+rZJyinDIf6CBPbAoTObe2HHiD
         9Jow==
X-Gm-Message-State: APjAAAUi3PjZ+yuGwJSh/+DxQwKZak+yd4NgneJLdLn3Kkxb+20mZB5/
        3jlkZuxUkmdI6l2dKOBgnf4=
X-Google-Smtp-Source: APXvYqw4m8q2FPtXEiZooJ1RVdH5A46FRMsZhFAfyz6Kp2srD4Txv/gFtWJs5K+G/1ZWXnU6AHUaDA==
X-Received: by 2002:a17:902:d88e:: with SMTP id b14mr5839060plz.153.1561656943033;
        Thu, 27 Jun 2019 10:35:43 -0700 (PDT)
Received: from hfq-skylake.ipads-lab.se.sjtu.edu.cn ([202.120.40.82])
        by smtp.googlemail.com with ESMTPSA id t11sm3479203pgb.33.2019.06.27.10.35.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 27 Jun 2019 10:35:42 -0700 (PDT)
From:   Fuqian Huang <huangfq.daxian@gmail.com>
Cc:     Fuqian Huang <huangfq.daxian@gmail.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Vinod Koul <vkoul@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        dmaengine@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 12/87] dma: imx-sdma: Remove call to memset after dma_alloc_coherent
Date:   Fri, 28 Jun 2019 01:35:35 +0800
Message-Id: <20190627173536.2457-1-huangfq.daxian@gmail.com>
X-Mailer: git-send-email 2.11.0
To:     unlisted-recipients:; (no To-header on input)
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

    In commit af7ddd8a627c
("Merge tag 'dma-mapping-4.21' of git://git.infradead.org/users/hch/dma-mapping"),
    dma_alloc_coherent has already zeroed the memory.
    So memset is not needed.

Signed-off-by: Fuqian Huang <huangfq.daxian@gmail.com>
---
 drivers/dma/imx-sdma.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/dma/imx-sdma.c b/drivers/dma/imx-sdma.c
index 99d9f431ae2c..54d86359bdf8 100644
--- a/drivers/dma/imx-sdma.c
+++ b/drivers/dma/imx-sdma.c
@@ -1886,10 +1886,6 @@ static int sdma_init(struct sdma_engine *sdma)
 	sdma->context_phys = ccb_phys +
 		MAX_DMA_CHANNELS * sizeof (struct sdma_channel_control);
 
-	/* Zero-out the CCB structures array just allocated */
-	memset(sdma->channel_control, 0,
-			MAX_DMA_CHANNELS * sizeof (struct sdma_channel_control));
-
 	/* disable all channels */
 	for (i = 0; i < sdma->drvdata->num_events; i++)
 		writel_relaxed(0, sdma->regs + chnenbl_ofs(sdma, i));
-- 
2.11.0

