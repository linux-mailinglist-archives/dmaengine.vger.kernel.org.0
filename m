Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D2A0B5247F4
	for <lists+dmaengine@lfdr.de>; Thu, 12 May 2022 10:37:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351494AbiELIgg (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 12 May 2022 04:36:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351500AbiELIge (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 12 May 2022 04:36:34 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31AE16C0D0
        for <dmaengine@vger.kernel.org>; Thu, 12 May 2022 01:36:33 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id t11-20020a17090ad50b00b001d95bf21996so7197052pju.2
        for <dmaengine@vger.kernel.org>; Thu, 12 May 2022 01:36:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Dh19HuOfdtK2F7eKYedy/v965tHvbFT9B9mkJwtbUA0=;
        b=ybdu7ry7HXCU7gGsSZu0YTKwUSYrXBhCLjTzqhOhdYB6oEtZt83jU75Hd8NsvZ4v2O
         6OIMD6U6a75r7Hnpy+2q5aZzaIlswA+/AaLrTuZc/g0kh3tTTsnqvnWc7yE6rYQhchCl
         pyYS6VYPdhVw9LaagT9s4dttQC6HDBdRQaO95ns7AOISeqX6qrJTSj6kYzU47hICkF/O
         kvudo84ZJa2ZklmQeCrO2qenpV6QeocUlKkmrjf9M8PsEtlVdfwoQjjPbEvmKuQQMRJd
         5rGCO33pYjXm9RnwfPlOVm3csyYjTA9CTd3ieXiCZd1juQVmqHoIrpHQ5HQzd64o4EoQ
         QD5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Dh19HuOfdtK2F7eKYedy/v965tHvbFT9B9mkJwtbUA0=;
        b=mY8nOliHwDb0DS3R0+0c7RQEWOeN/WRonaQyWuqoaaKsDXAMdPj7bn3NvOS52XaLVu
         jkSmHy99gx0r0a+g4cx+0qaLf47BqjNtM7MCl4vyO6MUKN3Z4qHtA5hUUdsZ+EATu4F4
         jsuez9Bo8BeAkpvMwpEz6d/0QsefsYQtdfLilbq4buct1zc81C7ZoC0PO64ZqkiOpbmc
         Zrb+QQJfvlgXUhHIc7zknUVjfgh4okLt4+0IM3R+3hcZDJMZYdeUOTV+acaiOhPqwY1j
         ajwjpQVkQ/Ut1TN6tBxF79LE4u2TtC6ULdSVqFkpxN+acht1/d/nfStJx8rsgcdUfpVc
         3rMQ==
X-Gm-Message-State: AOAM531I1asGsyK7ZwhlDIeL67A2Cvd+cqpHiVdNUo0fQyBSXuga2Aj9
        Rm++PPDTU0a8j7Hdv7EqQraW
X-Google-Smtp-Source: ABdhPJxHqU9RDjZHsCVgXg2pFU8sr7sS56Tx2FcU2aVqX5YLafxlcziyqOPAH18cBfk6Xi+lXkzl2Q==
X-Received: by 2002:a17:902:ed83:b0:15c:e82a:e84f with SMTP id e3-20020a170902ed8300b0015ce82ae84fmr30095746plj.96.1652344592650;
        Thu, 12 May 2022 01:36:32 -0700 (PDT)
Received: from localhost.localdomain ([117.217.183.109])
        by smtp.gmail.com with ESMTPSA id q10-20020a170902f34a00b0015e8d4eb1d8sm3258222ple.34.2022.05.12.01.36.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 May 2022 01:36:32 -0700 (PDT)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     gustavo.pimentel@synopsys.com, vkoul@kernel.org
Cc:     dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Serge Semin <fancer.lancer@gmail.com>,
        Frank Li <Frank.Li@nxp.com>
Subject: [PATCH] dmaengine: dw-edma: Remove runtime PM support
Date:   Thu, 12 May 2022 14:06:12 +0530
Message-Id: <20220512083612.122824-1-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
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
Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---

Note: This patch is made on top of Frank and Serge's edma work, but should
be applicable independently also.

[PATCH v10 0/9] Enable designware PCI EP EDMA locally
[PATCH v2 00/26] dmaengine: dw-edma: Add RP/EP local DMA controllers support

 drivers/dma/dw-edma/dw-edma-core.c | 12 ------------
 1 file changed, 12 deletions(-)

diff --git a/drivers/dma/dw-edma/dw-edma-core.c b/drivers/dma/dw-edma/dw-edma-core.c
index 561686b51915..b2b5077d380b 100644
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
@@ -731,15 +730,12 @@ static int dw_edma_alloc_chan_resources(struct dma_chan *dchan)
 		dchan->dev->chan_dma_dev = false;
 	}
 
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
@@ -752,8 +748,6 @@ static void dw_edma_free_chan_resources(struct dma_chan *dchan)
 
 		cpu_relax();
 	}
-
-	pm_runtime_put(chan->dw->chip->dev);
 }
 
 static int dw_edma_channel_setup(struct dw_edma *dw, u32 wr_alloc, u32 rd_alloc)
@@ -1010,9 +1004,6 @@ int dw_edma_probe(struct dw_edma_chip *chip)
 	if (err)
 		goto err_irq_free;
 
-	/* Power management */
-	pm_runtime_enable(dev);
-
 	/* Turn debugfs on */
 	dw_edma_v0_core_debugfs_on(dw);
 
@@ -1046,9 +1037,6 @@ int dw_edma_remove(struct dw_edma_chip *chip)
 	for (i = (dw->nr_irqs - 1); i >= 0; i--)
 		free_irq(chip->ops->irq_vector(dev, i), &dw->irq[i]);
 
-	/* Power management */
-	pm_runtime_disable(dev);
-
 	/* Deregister eDMA device */
 	dma_async_device_unregister(&dw->dma);
 	list_for_each_entry_safe(chan, _chan, &dw->dma.channels,
-- 
2.25.1

