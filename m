Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8892D24817E
	for <lists+dmaengine@lfdr.de>; Tue, 18 Aug 2020 11:09:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726165AbgHRJJH (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 18 Aug 2020 05:09:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726043AbgHRJJG (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 18 Aug 2020 05:09:06 -0400
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFE8EC061389
        for <dmaengine@vger.kernel.org>; Tue, 18 Aug 2020 02:09:06 -0700 (PDT)
Received: by mail-pj1-x1041.google.com with SMTP id c10so9122088pjn.1
        for <dmaengine@vger.kernel.org>; Tue, 18 Aug 2020 02:09:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=MNsn+KIrzPWCkkACLUaTpczD1K+bZF0NZOkHpu9iBlw=;
        b=tSb7n9NbiFP+xIMnveSZTnsZIKvC/zSlPC5JoTVG+neiwqBrCrenMvo+HPoUOPA/KJ
         zdha0VnlKVBasxxVA67DU6n8gqlCe3cqADptDMnpvg6bIYTrpJPQAIC3BPyHUbBT7R+Y
         e/e7CayWagFaIRsf3FZChmTPwTw144//Z4FCsrOk4WaOOyMTtaPoMIJWB6nU2yhlOnR4
         YRrDu0oKQHa7v6r9sFQOGxScN9Lh6pf0UylZfOWSs32YwYvlog+TkCDLnu44qMCsl676
         +WuTkitE3q6Bye+lOPfXTwPvBrAwWN6daDhbso2TRfnKxSC6yNBnOL4NMmoM908SrgbM
         NKxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=MNsn+KIrzPWCkkACLUaTpczD1K+bZF0NZOkHpu9iBlw=;
        b=cFpUq9xZ6OQSH4fK9Wlwcki5ba+MYaJ50X9xqXJy2xeXWnTIVUl2F04QqP/iyLTmIG
         SCyPMmi+crReP2kI5zrm/lOFWgXyC8YVambNdySP2tN0oqZNEkwESoZFddF5/fFo5vpL
         Aw2npU31rHpy7o8ZvpmUWjfqIAOGx/uM4ITDeI1S2BcA7oTjiJVJOpceOsJgsbxN21ot
         JLggZWvuHOnNujV2st6xTWKf0R7rRvASm2XPiWIHTZlNWqwKiYJi3AObbAb0+q4rzdrA
         xNLqfIpsciFMiz7ILbjoduakE4NDOJ39gqVFIOIfqWp9shg4dV/yx6DO1DYqil3S3VCG
         NtWA==
X-Gm-Message-State: AOAM531oo8AWMd2rdKzcYC0i6zlD8pxCPUZ78V/jEOkvrOEdo8G/p/Y1
        eMFY5Dm9PY7Vl3nrJHm1AILKZ9AoYw5olA==
X-Google-Smtp-Source: ABdhPJzAMNO0cTkZ03oPTbYtMwOzwJE3GjIpdmejVSYHEJ06ajsvz6atBQfe0YfQ1L/DBbMkF7u2eQ==
X-Received: by 2002:a17:902:c3c9:: with SMTP id j9mr14984776plj.62.1597741746387;
        Tue, 18 Aug 2020 02:09:06 -0700 (PDT)
Received: from localhost.localdomain ([49.207.196.79])
        by smtp.gmail.com with ESMTPSA id na14sm20280788pjb.6.2020.08.18.02.09.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Aug 2020 02:09:05 -0700 (PDT)
From:   Allen Pais <allen.lkml@gmail.com>
To:     vkoul@kernel.org, linus.walleij@linaro.org, vireshk@kernel.org,
        leoyang.li@nxp.com, zw@zh-kernel.org, shawnguo@kernel.org,
        s.hauer@pengutronix.de, matthias.bgg@gmail.com, agross@kernel.org,
        bjorn.andersson@linaro.org, baohua@kernel.org, wens@csie.org
Cc:     dmaengine@vger.kernel.org, Allen Pais <allen.lkml@gmail.com>,
        Romain Perier <romain.perier@gmail.com>
Subject: [PATCH 28/35] dma: timb_dma: convert tasklets to use new tasklet_setup() API
Date:   Tue, 18 Aug 2020 14:36:31 +0530
Message-Id: <20200818090638.26362-29-allen.lkml@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200818090638.26362-1-allen.lkml@gmail.com>
References: <20200818090638.26362-1-allen.lkml@gmail.com>
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
 drivers/dma/timb_dma.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/dma/timb_dma.c b/drivers/dma/timb_dma.c
index 68e48bf54d78..3f524be69efb 100644
--- a/drivers/dma/timb_dma.c
+++ b/drivers/dma/timb_dma.c
@@ -563,9 +563,9 @@ static int td_terminate_all(struct dma_chan *chan)
 	return 0;
 }
 
-static void td_tasklet(unsigned long data)
+static void td_tasklet(struct tasklet_struct *t)
 {
-	struct timb_dma *td = (struct timb_dma *)data;
+	struct timb_dma *td = from_tasklet(td, t, tasklet);
 	u32 isr;
 	u32 ipr;
 	u32 ier;
@@ -658,7 +658,7 @@ static int td_probe(struct platform_device *pdev)
 	iowrite32(0x0, td->membase + TIMBDMA_IER);
 	iowrite32(0xFFFFFFFF, td->membase + TIMBDMA_ISR);
 
-	tasklet_init(&td->tasklet, td_tasklet, (unsigned long)td);
+	tasklet_setup(&td->tasklet, td_tasklet);
 
 	err = request_irq(irq, td_irq, IRQF_SHARED, DRIVER_NAME, td);
 	if (err) {
-- 
2.17.1

