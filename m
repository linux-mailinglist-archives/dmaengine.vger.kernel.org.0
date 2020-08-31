Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 44375257767
	for <lists+dmaengine@lfdr.de>; Mon, 31 Aug 2020 12:37:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726507AbgHaKhG (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 31 Aug 2020 06:37:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726305AbgHaKhF (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 31 Aug 2020 06:37:05 -0400
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA362C061573
        for <dmaengine@vger.kernel.org>; Mon, 31 Aug 2020 03:37:05 -0700 (PDT)
Received: by mail-pj1-x1042.google.com with SMTP id 2so2909443pjx.5
        for <dmaengine@vger.kernel.org>; Mon, 31 Aug 2020 03:37:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=mfpjLNeOMh3AoGlg/cBm2M9s7xEKtrK1kYZxmXAugcQ=;
        b=VtyenePqOxdhV0MVVlPJdQsA5HGnCipKBOLgf55Qg16/+dl+xSYlgXASps0s+9Dvxz
         QdKC4WCNGJL4D/CjFMPvEW4qVyMIspXh+UvcPTOk/tyPS0AMOR1p4dIU43W+2xGivU5x
         vkHNCs9r+sL0n6vTcc3t2LWhLkTp8i+Fa5YDvqILume7AlAnz3at8k+vSE5LlkBLgPU7
         rehwyWe2/yglt2T6J5jqeYTbM7Y39em9herNEislQt/UWKCGOOiaIpetFacSXAv02gfk
         3gkj3yDTit1RGmRW7sQRxSGTTw2K+sI6bJvQVzdiCnj9eR0jkyaapZPeT1tq97pVKiMU
         1c0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=mfpjLNeOMh3AoGlg/cBm2M9s7xEKtrK1kYZxmXAugcQ=;
        b=JVtVM40H2DV55BOq/M0tUw2Iq9K5KxSeaxQsJl2jF+a69r7dUW2aHKIyuOmfVgGNR6
         m+xvHSmCbDEVZH8ano6MZPK2lgtTw4UDTkwUrGz8QBECJeGZn6K/OdpnD8xZej5MSwWn
         VBB2oqirahwd2WGP+ZI+3MjotnXFVMkQuRLHCQ6UZrFWHkrwln9UTM9PFI3oJs5Wf46J
         I4Squ4ReqsXCy4H06oXZw5SUkWllmytdEsxoE8w4IA1TVBqgtzRfojY27EC0QCjxF4V2
         8tFVQchae97BghfooFV2WNLdsgy9tFhzE+tM7VEK5p0gt4mkd3b2s0Au6rx5bQ+mVy5N
         Dz8A==
X-Gm-Message-State: AOAM530TqKFDEuRontmugh3JT03DAIjGGpXESAubLQFXVaipyvo/aL6K
        BpbA6erkr96fPAc2gZlOZJM=
X-Google-Smtp-Source: ABdhPJwWeR6Cjg7zGdL/hzwkStfpTHSapfNK41kJSIDQLcmt+7A/ZkHKU5y+zPvFqd0fwYsQMfzZKg==
X-Received: by 2002:a17:90a:39c8:: with SMTP id k8mr829436pjf.19.1598870225542;
        Mon, 31 Aug 2020 03:37:05 -0700 (PDT)
Received: from localhost.localdomain ([49.207.204.90])
        by smtp.gmail.com with ESMTPSA id x6sm6895449pge.61.2020.08.31.03.37.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Aug 2020 03:37:05 -0700 (PDT)
From:   Allen Pais <allen.lkml@gmail.com>
To:     vkoul@kernel.org
Cc:     linus.walleij@linaro.org, vireshk@kernel.org, leoyang.li@nxp.com,
        zw@zh-kernel.org, shawnguo@kernel.org, s.hauer@pengutronix.de,
        sean.wang@mediatek.com, matthias.bgg@gmail.com,
        logang@deltatee.com, agross@kernel.org, jorn.andersson@linaro.org,
        green.wan@sifive.com, baohua@kernel.org, mripard@kernel.org,
        wens@csie.org, dmaengine@vger.kernel.org,
        Allen Pais <allen.lkml@gmail.com>,
        Romain Perier <romain.perier@gmail.com>
Subject: [PATCH v3 12/35] dmaengine: k3dma: convert tasklets to use new tasklet_setup() API
Date:   Mon, 31 Aug 2020 16:05:19 +0530
Message-Id: <20200831103542.305571-13-allen.lkml@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200831103542.305571-1-allen.lkml@gmail.com>
References: <20200831103542.305571-1-allen.lkml@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

In preparation for unconditionally passing the
struct tasklet_struct pointer to all tasklet
callbacks, switch to using the new tasklet_setup()
and from_tasklet() to pass the tasklet pointer explicitly.

Signed-off-by: Romain Perier <romain.perier@gmail.com>
Signed-off-by: Allen Pais <allen.lkml@gmail.com>
---
 drivers/dma/k3dma.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/dma/k3dma.c b/drivers/dma/k3dma.c
index c5c1aa0dcaed..f609a84c493c 100644
--- a/drivers/dma/k3dma.c
+++ b/drivers/dma/k3dma.c
@@ -297,9 +297,9 @@ static int k3_dma_start_txd(struct k3_dma_chan *c)
 	return -EAGAIN;
 }
 
-static void k3_dma_tasklet(unsigned long arg)
+static void k3_dma_tasklet(struct tasklet_struct *t)
 {
-	struct k3_dma_dev *d = (struct k3_dma_dev *)arg;
+	struct k3_dma_dev *d = from_tasklet(d, t, task);
 	struct k3_dma_phy *p;
 	struct k3_dma_chan *c, *cn;
 	unsigned pch, pch_alloc = 0;
@@ -962,7 +962,7 @@ static int k3_dma_probe(struct platform_device *op)
 
 	spin_lock_init(&d->lock);
 	INIT_LIST_HEAD(&d->chan_pending);
-	tasklet_init(&d->task, k3_dma_tasklet, (unsigned long)d);
+	tasklet_setup(&d->task, k3_dma_tasklet);
 	platform_set_drvdata(op, d);
 	dev_info(&op->dev, "initialized\n");
 
-- 
2.25.1

