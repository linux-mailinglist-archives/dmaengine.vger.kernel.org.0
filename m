Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 144B959182
	for <lists+dmaengine@lfdr.de>; Fri, 28 Jun 2019 04:47:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727070AbfF1Cqx (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 27 Jun 2019 22:46:53 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:40935 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726817AbfF1Cqx (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 27 Jun 2019 22:46:53 -0400
Received: by mail-pl1-f193.google.com with SMTP id a93so2360256pla.7;
        Thu, 27 Jun 2019 19:46:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=04GljEtl2h3DmnTzFw9yoiLkqcADLLyfQ+DeoECtL/g=;
        b=DfYRJv3o9Bcrqrgqw90Ljs1hZlo0ut9UVtzdSkOf+R1UrqOE5qgOpWli4VXM0vexVS
         kcLQdIIY41qtuPt77bpfXCCz78DVSEt8nHQLWrbGGHdvoUJiz0AHcKv0zey3ymekMWQW
         3ZYA8ry/J/fEnLyaQxY/BCrVNKg3WvLn+S+OzgWsXccwFp47WifaGx+EJq/hvLPyjB5T
         MReyTie+sBqblJjpj/MiGCu3GI5I5tLhd2JdRgoeCaOJaKr2J4U4bH/SxUo06oabCEJW
         tSJtSMgB5G+PcmJykIpGyPCl2lY/vlSPJFcP9+0kFoqBvtyZKe04tgqrO4PjH2qf54hN
         q8Xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=04GljEtl2h3DmnTzFw9yoiLkqcADLLyfQ+DeoECtL/g=;
        b=V/wIPX6CW+2PXvu9P1h6h893H9ZSX+9n07VADXMMIUCql8qeJbAD8Qk1U5MnIxt8o3
         IjhGSona3m5xDfVpymk5fvWX2b+8pIxBGJMA+5C4aCfByd9w4nrVpS/Yn8ea1nVXykI2
         3LYHWPl+PzsQs9HfvsmM8pmmZbLkzdb4byfwTMXgWXsLhKghSyPgUtc10jQFOCJuihNT
         WNbhnhLZ+qnXdRIwhr1PjFSe9Xu79+4xm1IPZbz5fFfBl2jsc6LoDkmAFyUGdhLb9p45
         bi7lVFKtMme4DSDCjZEH+vam3UKl6rmNpXcUf4qKreoo7LY4K6oR48lqD+67J5wRpV9Q
         WLFw==
X-Gm-Message-State: APjAAAUkRJpPaoZOk1WieYSC9dDz91lxnttPkBj+HB/rxH0c7HPuBXXG
        qFh33YfBe2S+foEQdu6lth0=
X-Google-Smtp-Source: APXvYqwZWLNOSYNebra3h7VxqKFQWWgskOaNU9GLrmfb1nSa3+umdvA8TKyiTag+IOKEC5NcyTD2Fg==
X-Received: by 2002:a17:902:9a42:: with SMTP id x2mr8693861plv.106.1561690012576;
        Thu, 27 Jun 2019 19:46:52 -0700 (PDT)
Received: from hfq-skylake.ipads-lab.se.sjtu.edu.cn ([202.120.40.82])
        by smtp.googlemail.com with ESMTPSA id j15sm450696pfr.146.2019.06.27.19.46.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 27 Jun 2019 19:46:52 -0700 (PDT)
From:   Fuqian Huang <huangfq.daxian@gmail.com>
Cc:     Fuqian Huang <huangfq.daxian@gmail.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Vinod Koul <vkoul@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Sinan Kaya <okaya@kernel.org>, Andy Gross <agross@kernel.org>,
        David Brown <david.brown@linaro.org>,
        dmaengine@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org
Subject: [PATCH v2 06/27] dma: remove memset after dma_alloc_coherent/dmam_alloc_coherent
Date:   Fri, 28 Jun 2019 10:46:42 +0800
Message-Id: <20190628024642.15089-1-huangfq.daxian@gmail.com>
X-Mailer: git-send-email 2.11.0
To:     unlisted-recipients:; (no To-header on input)
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

In commit af7ddd8a627c
("Merge tag 'dma-mapping-4.21' of git://git.infradead.org/users/hch/dma-mapping"),
dma_alloc_coherent/dmam_alloc_coherent has already zeroed the memory.
So memset is not needed.

Signed-off-by: Fuqian Huang <huangfq.daxian@gmail.com>
---
 drivers/dma/imx-sdma.c      | 4 ----
 drivers/dma/qcom/hidma_ll.c | 2 --
 2 files changed, 6 deletions(-)

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
diff --git a/drivers/dma/qcom/hidma_ll.c b/drivers/dma/qcom/hidma_ll.c
index 5bf8b145c427..bb4471e84e48 100644
--- a/drivers/dma/qcom/hidma_ll.c
+++ b/drivers/dma/qcom/hidma_ll.c
@@ -749,7 +749,6 @@ struct hidma_lldev *hidma_ll_init(struct device *dev, u32 nr_tres,
 	if (!lldev->tre_ring)
 		return NULL;
 
-	memset(lldev->tre_ring, 0, (HIDMA_TRE_SIZE + 1) * nr_tres);
 	lldev->tre_ring_size = HIDMA_TRE_SIZE * nr_tres;
 	lldev->nr_tres = nr_tres;
 
@@ -769,7 +768,6 @@ struct hidma_lldev *hidma_ll_init(struct device *dev, u32 nr_tres,
 	if (!lldev->evre_ring)
 		return NULL;
 
-	memset(lldev->evre_ring, 0, (HIDMA_EVRE_SIZE + 1) * nr_tres);
 	lldev->evre_ring_size = HIDMA_EVRE_SIZE * nr_tres;
 
 	/* the EVRE ring has to be EVRE_SIZE aligned */
-- 
2.11.0

