Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B177125775B
	for <lists+dmaengine@lfdr.de>; Mon, 31 Aug 2020 12:36:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726446AbgHaKgK (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 31 Aug 2020 06:36:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726081AbgHaKgJ (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 31 Aug 2020 06:36:09 -0400
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDCF1C061573
        for <dmaengine@vger.kernel.org>; Mon, 31 Aug 2020 03:36:07 -0700 (PDT)
Received: by mail-pg1-x544.google.com with SMTP id l191so377629pgd.5
        for <dmaengine@vger.kernel.org>; Mon, 31 Aug 2020 03:36:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=JUgypnrklX+WS7+RXf4i6hKrqncDmin14CiCTmnSXgY=;
        b=INHVEXyGK3jfZBuTZCRxHjaIQ0jdu/qreXdbfEw77K6rJLJjftkKE3Qmh3ICSuzXQm
         IXKoZka8AOBaJPjsP8zcDRWfBn7so3C6OxccPq1bEwifXjoIW0mZO4K62oySFzsiR6tQ
         q6axvu8cGLbdR+hKhgskCViG3JMiezK7ZrZNaSNl1PMaDjdMBrbiCGFAA0ojNsf2Ke6t
         Z/pqH2YRipFEDC4TRZS+tDV+SEdY+L4SsMOMz4WWxh/56AR+mBrgsqq+EYLAfrrmvJCB
         IfCIV9+EEWwp66htX3ccBNrgZUxWsEEtQmXpKcOeQ/gBLcYIwpJ8w5etY7mNsXhTTW01
         Oj4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=JUgypnrklX+WS7+RXf4i6hKrqncDmin14CiCTmnSXgY=;
        b=sVN8hG8j1b360Qt6vtoMfbGodx2UNJPkzkv5bJsoTlSX0FEIgvhpdVkbHVwtvfZSWU
         8M2IeX0gA+aNZWar/rPRmggGasW6gki5E8Bz36vI2G2l2wQG2MwtjRQI5I0awASVaXa4
         3c9aDgwvis9MNrZhnP2oq8pjbWr73UjnsOBcdhWZptxvxGQIDkClrb1vJOQ9+8KB/iJc
         xtSA5O4x96A1GTggQBwYaKGzdZS09/V71NrQnc/vwyE9W7nz2jG6ezuwnSyPZgf8uWsu
         4DsNWAkc8xbGia6ExO2rN4czsLPJGAuYOUod5nld2LNCCzdlHl9bdMU7IlrXlHvnJohM
         VO7g==
X-Gm-Message-State: AOAM533oGrMUMVGeOR5UQ4cVQ/7z5msrTeFz5ySjL35btieO8CcPUISW
        aZ8hxlqTjKsiTWcpeYHf1oQ=
X-Google-Smtp-Source: ABdhPJyVbV4zVpFb9T/9pZB7C0Kz/GFw8J6lyPf8XSBAB0LLLvoR59uQ/U5Gp/AdEI6+VMeH2RhEJw==
X-Received: by 2002:a63:1b65:: with SMTP id b37mr763669pgm.453.1598870167423;
        Mon, 31 Aug 2020 03:36:07 -0700 (PDT)
Received: from localhost.localdomain ([49.207.204.90])
        by smtp.gmail.com with ESMTPSA id x6sm6895449pge.61.2020.08.31.03.36.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Aug 2020 03:36:06 -0700 (PDT)
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
Subject: [PATCH v3 01/35] dmaengine: altera-msgdma: convert tasklets to use new tasklet_setup() API
Date:   Mon, 31 Aug 2020 16:05:08 +0530
Message-Id: <20200831103542.305571-2-allen.lkml@gmail.com>
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
 drivers/dma/altera-msgdma.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/dma/altera-msgdma.c b/drivers/dma/altera-msgdma.c
index 321ac3a7aa41..4d6751bf6f11 100644
--- a/drivers/dma/altera-msgdma.c
+++ b/drivers/dma/altera-msgdma.c
@@ -680,9 +680,9 @@ static int msgdma_alloc_chan_resources(struct dma_chan *dchan)
  * msgdma_tasklet - Schedule completion tasklet
  * @data: Pointer to the Altera sSGDMA channel structure
  */
-static void msgdma_tasklet(unsigned long data)
+static void msgdma_tasklet(struct tasklet_struct *t)
 {
-	struct msgdma_device *mdev = (struct msgdma_device *)data;
+	struct msgdma_device *mdev = from_tasklet(mdev, t, irq_tasklet);
 	u32 count;
 	u32 __maybe_unused size;
 	u32 __maybe_unused status;
@@ -830,7 +830,7 @@ static int msgdma_probe(struct platform_device *pdev)
 	if (ret)
 		return ret;
 
-	tasklet_init(&mdev->irq_tasklet, msgdma_tasklet, (unsigned long)mdev);
+	tasklet_setup(&mdev->irq_tasklet, msgdma_tasklet);
 
 	dma_cookie_init(&mdev->dmachan);
 
-- 
2.25.1

