Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 409FA284530
	for <lists+dmaengine@lfdr.de>; Tue,  6 Oct 2020 07:06:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726789AbgJFFFT (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 6 Oct 2020 01:05:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725963AbgJFFFT (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 6 Oct 2020 01:05:19 -0400
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AE3FC0613A7
        for <dmaengine@vger.kernel.org>; Mon,  5 Oct 2020 22:05:19 -0700 (PDT)
Received: by mail-pj1-x1044.google.com with SMTP id a1so1042092pjd.1
        for <dmaengine@vger.kernel.org>; Mon, 05 Oct 2020 22:05:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=BfRnwGdRrJS2YZh4CD27w2xAtyshOOYj96RvXpFQA9k=;
        b=p56CP2HRP6w1yFamtE9CBFfr+QX4dje4VVorXCXKzmqwgxCCv+WI+gxlQ0DIjmkVqW
         a3y259MxumajuGvwlMY4Yf0L6TO6LgM5MAFSym5v7bqMq3N0/m5C79gnPu0yzni/nbdt
         6x0oOMYEi1G9dHclDWibx62i9Eazsr5gLRvVqH3MXUOWMi0VDU89Eux/MXlftx2XLqwo
         vXeBz9D+j+UgetCGjlfZokj2V3zq50hyvlaUWoJiyyqoxgUgsygiYjCsJBxpj6YghnoN
         iaJM5KMj683cY67Dycy+RBrRuwfGhA2wLAV+MO7JArWcPqC+CeZV8UDUcNfcsjsZY3nA
         9yqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=BfRnwGdRrJS2YZh4CD27w2xAtyshOOYj96RvXpFQA9k=;
        b=oqeo3fjZkssEUZdjUAxEzVI9TO8+QTvI3ornVc8sIC9Fn4ZjkK6ZSMReF4ODQVHBnH
         ebC8WvVCLN66HCst0p9c3tbBjECLPJ1t0IroluS5zbm4ztV/E2XqqRBLisyzoBSNbR1P
         fxbeBbnyK+SJyFQPMuw0XuoGsCtZGfMHqcLekv3Ghss0E41B+bT6d/vQDiHWJe7JmFc7
         mbBHyQBjVSvvZbbYHdJ88NmuwYlh+RMuZLmYoZNdvPF9HnovG3kux2/15vWUYlH11qOO
         3/Lqi6FfTH5232d4ayxWYkHBon2KWD/J7fKzOhFIVX33Zpm6Yc0QU4AME2qx1GCQuuUz
         MziQ==
X-Gm-Message-State: AOAM530eGa4n1cwb26jX/mOdhM/UBz/KFn+fD2mW0nbblAnkFab2wSP4
        +SumAQOGsoBUpO6eKgJajJA=
X-Google-Smtp-Source: ABdhPJwguNBz1IBXU8XS+BaELGVnikZyPkwLEY38SAi6oF0+eTcGBq8QoppJWxFpBpGQmtV63N9Ryw==
X-Received: by 2002:a17:90b:795:: with SMTP id l21mr2696387pjz.130.1601960718784;
        Mon, 05 Oct 2020 22:05:18 -0700 (PDT)
Received: from localhost.localdomain ([49.207.197.157])
        by smtp.gmail.com with ESMTPSA id e196sm1755437pfh.128.2020.10.05.22.05.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Oct 2020 22:05:18 -0700 (PDT)
From:   Allen Pais <allen.lkml@gmail.com>
To:     vkoul@kernel.org
Cc:     green.wan@sifive.com, hyun.kwon@xilinx.com,
        dmaengine@vger.kernel.org, Allen Pais <apais@linux.microsoft.com>,
        Romain Perier <romain.perier@gmail.com>
Subject: [PATCH 2/2] dmaengine: xilinx: dpdma: convert tasklets to use new tasklet_setup() API
Date:   Tue,  6 Oct 2020 10:34:58 +0530
Message-Id: <20201006050458.221329-2-allen.lkml@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201006050458.221329-1-allen.lkml@gmail.com>
References: <20201006050458.221329-1-allen.lkml@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

From: Allen Pais <apais@linux.microsoft.com>

In preparation for unconditionally passing the
struct tasklet_struct pointer to all tasklet
callbacks, switch to using the new tasklet_setup()
and from_tasklet() to pass the tasklet pointer explicitly.

Signed-off-by: Romain Perier <romain.perier@gmail.com>
Signed-off-by: Allen Pais <apais@linux.microsoft.com>
---
 drivers/dma/xilinx/xilinx_dpdma.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/dma/xilinx/xilinx_dpdma.c b/drivers/dma/xilinx/xilinx_dpdma.c
index 81ed1e482..55df63dea 100644
--- a/drivers/dma/xilinx/xilinx_dpdma.c
+++ b/drivers/dma/xilinx/xilinx_dpdma.c
@@ -1458,15 +1458,15 @@ static void xilinx_dpdma_disable_irq(struct xilinx_dpdma_device *xdev)
 
 /**
  * xilinx_dpdma_chan_err_task - Per channel tasklet for error handling
- * @data: tasklet data to be casted to DPDMA channel structure
+ * @t: pointer to the tasklet associated with this handler
  *
  * Per channel error handling tasklet. This function waits for the outstanding
  * transaction to complete and triggers error handling. After error handling,
  * re-enable channel error interrupts, and restart the channel if needed.
  */
-static void xilinx_dpdma_chan_err_task(unsigned long data)
+static void xilinx_dpdma_chan_err_task(struct tasklet_struct *t)
 {
-	struct xilinx_dpdma_chan *chan = (struct xilinx_dpdma_chan *)data;
+	struct xilinx_dpdma_chan *chan = from_tasklet(chan, t, err_task);
 	struct xilinx_dpdma_device *xdev = chan->xdev;
 	unsigned long flags;
 
@@ -1555,8 +1555,7 @@ static int xilinx_dpdma_chan_init(struct xilinx_dpdma_device *xdev,
 	spin_lock_init(&chan->lock);
 	init_waitqueue_head(&chan->wait_to_stop);
 
-	tasklet_init(&chan->err_task, xilinx_dpdma_chan_err_task,
-		     (unsigned long)chan);
+	tasklet_setup(&chan->err_task, xilinx_dpdma_chan_err_task);
 
 	chan->vchan.desc_free = xilinx_dpdma_chan_free_tx_desc;
 	vchan_init(&chan->vchan, &xdev->common);
-- 
2.25.1

