Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A32B5B4454
	for <lists+dmaengine@lfdr.de>; Sat, 10 Sep 2022 07:47:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229937AbiIJFrU (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Sat, 10 Sep 2022 01:47:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229925AbiIJFrT (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Sat, 10 Sep 2022 01:47:19 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9BB9AF0E8
        for <dmaengine@vger.kernel.org>; Fri,  9 Sep 2022 22:47:16 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id z14-20020a7bc7ce000000b003a5db0388a8so181307wmk.1
        for <dmaengine@vger.kernel.org>; Fri, 09 Sep 2022 22:47:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date;
        bh=ZJI6ORqG8zxYZu2zKJ+oG09ScvKO2aVfOsuZsiN3680=;
        b=Tu4qy0kztYakM/miHZmmtYGaP6yE/1FKs+DVQGKEDmxX8KIBR+z+Y4HBEpDEkbovDx
         8x03b0EGqV8EYTxYzSRizirJu4gKavtWL+KA9HlhPEC6bw+K+/KOUZVQEq088NMKmY+a
         9gvwrRxw/Mru3kyFW1BpdhNM6hXBMbWM6GxM+7ll+wClmzQ25YGX3SX8v28s8xObPM2l
         Pidh/LTTzotago3eA1OPeh0cx+4F1RZOPFDD71+HT6XBuXaB4O2v0tKPfyfGf51ZF0u9
         mKthTKE15winScuboCo0lS0rlb1nLwVtSIWxxiiVEk/3nEsw326teN7TV9LhJpfT2vam
         bAXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=ZJI6ORqG8zxYZu2zKJ+oG09ScvKO2aVfOsuZsiN3680=;
        b=Ga236gH4849CNhe/c7owrgnGqiIwDNXPE2QeZ8+un/oBfGgCZGdZXoMMejw9XN1BP1
         YMTZTW7fEuzxgdoraqYx2GGuYHw6UXBGrrFbdGFvxtjUWcPNqYE1Ihu4BPLzUbxRatK1
         SyWOMXlU1fA1y3EfjbMtTrbOUsH3ICGEMUN2agDG5UtEoPSXD43X0QeOg0IyF/D0TKk4
         pHL6hRobsJtPh36JJGVs3fodwp3g47Y5xTnhNZMyxNJD92iKvCotFJ7XA4fUWySbgPSa
         5ksrm5aA+4UBwx0IBMcj4kdt9jPEn+TsqTpp60WRHjJ7OJZ9mEcADVeK+tZucH3/Ww0V
         nLQw==
X-Gm-Message-State: ACgBeo2ZOy/edHIaP4xnVD8sYGaG7lwujRcAAqnwJLHYZzwD5mIikwpV
        +g87KZI/4SvtYLosuGSlwx6T
X-Google-Smtp-Source: AA6agR7ARJ5rUJ37hddKyqCD7uYAdH5V0KMU435NKXHX5xqcvZ5yr7uJS+/TIDXKb4GdrTCF/XJaGg==
X-Received: by 2002:a1c:f20d:0:b0:3a8:4176:139b with SMTP id s13-20020a1cf20d000000b003a84176139bmr7109594wmc.177.1662788835406;
        Fri, 09 Sep 2022 22:47:15 -0700 (PDT)
Received: from localhost.localdomain ([117.217.182.47])
        by smtp.gmail.com with ESMTPSA id c4-20020adffb44000000b0022a2c600d5csm2031039wrs.55.2022.09.09.22.47.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Sep 2022 22:47:15 -0700 (PDT)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     gustavo.pimentel@synopsys.com, vkoul@kernel.org
Cc:     dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Serge Semin <fancer.lancer@gmail.com>,
        Frank Li <Frank.Li@nxp.com>
Subject: [PATCH v2] dmaengine: dw-edma: Remove runtime PM support
Date:   Sat, 10 Sep 2022 11:17:00 +0530
Message-Id: <20220910054700.12205-1-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Currently, the dw-edma driver enables the runtime_pm for parent device
(chip->dev) and increments/decrements the refcount during alloc/free
chan resources callbacks.

This leads to a problem when the eDMA driver has been probed, but the
channels were not used. This scenario can happen when the DW PCIe driver
probes eDMA driver successfully, but the PCI EPF driver decides not to
use eDMA channels and use iATU instead for PCI transfers.

In this case, the underlying device would be runtime suspended due to
pm_runtime_enable() in dw_edma_probe() and the PCI EPF driver would have
no knowledge of it.

Ideally, the eDMA driver should not be the one doing the runtime PM of
the parent device. The responsibility should instead belong to the client
drivers like PCI EPF.

So let's remove the runtime PM support from eDMA driver.

Cc: Serge Semin <fancer.lancer@gmail.com>
Cc: Frank Li <Frank.Li@nxp.com>
Reviewed-by: Serge Semin <fancer.lancer@gmail.com>
Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---

Changes in v2:

 - Added review tag from Sergey
 - Rebased on top of v6.0.0-rc1

 drivers/dma/dw-edma/dw-edma-core.c | 12 ------------
 1 file changed, 12 deletions(-)

diff --git a/drivers/dma/dw-edma/dw-edma-core.c b/drivers/dma/dw-edma/dw-edma-core.c
index 07f756479663..c54b24ff5206 100644
--- a/drivers/dma/dw-edma/dw-edma-core.c
+++ b/drivers/dma/dw-edma/dw-edma-core.c
@@ -9,7 +9,6 @@
 #include <linux/module.h>
 #include <linux/device.h>
 #include <linux/kernel.h>
-#include <linux/pm_runtime.h>
 #include <linux/dmaengine.h>
 #include <linux/err.h>
 #include <linux/interrupt.h>
@@ -682,15 +681,12 @@ static int dw_edma_alloc_chan_resources(struct dma_chan *dchan)
 	if (chan->status != EDMA_ST_IDLE)
 		return -EBUSY;
 
-	pm_runtime_get(chan->dw->chip->dev);
-
 	return 0;
 }
 
 static void dw_edma_free_chan_resources(struct dma_chan *dchan)
 {
 	unsigned long timeout = jiffies + msecs_to_jiffies(5000);
-	struct dw_edma_chan *chan = dchan2dw_edma_chan(dchan);
 	int ret;
 
 	while (time_before(jiffies, timeout)) {
@@ -703,8 +699,6 @@ static void dw_edma_free_chan_resources(struct dma_chan *dchan)
 
 		cpu_relax();
 	}
-
-	pm_runtime_put(chan->dw->chip->dev);
 }
 
 static int dw_edma_channel_setup(struct dw_edma *dw, bool write,
@@ -977,9 +971,6 @@ int dw_edma_probe(struct dw_edma_chip *chip)
 	if (err)
 		goto err_irq_free;
 
-	/* Power management */
-	pm_runtime_enable(dev);
-
 	/* Turn debugfs on */
 	dw_edma_v0_core_debugfs_on(dw);
 
@@ -1009,9 +1000,6 @@ int dw_edma_remove(struct dw_edma_chip *chip)
 	for (i = (dw->nr_irqs - 1); i >= 0; i--)
 		free_irq(chip->ops->irq_vector(dev, i), &dw->irq[i]);
 
-	/* Power management */
-	pm_runtime_disable(dev);
-
 	/* Deregister eDMA device */
 	dma_async_device_unregister(&dw->wr_edma);
 	list_for_each_entry_safe(chan, _chan, &dw->wr_edma.channels,
-- 
2.25.1

