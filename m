Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8C55D25776D
	for <lists+dmaengine@lfdr.de>; Mon, 31 Aug 2020 12:37:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726142AbgHaKhZ (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 31 Aug 2020 06:37:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726491AbgHaKhV (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 31 Aug 2020 06:37:21 -0400
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DE64C061573
        for <dmaengine@vger.kernel.org>; Mon, 31 Aug 2020 03:37:21 -0700 (PDT)
Received: by mail-pg1-x541.google.com with SMTP id 31so362686pgy.13
        for <dmaengine@vger.kernel.org>; Mon, 31 Aug 2020 03:37:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=1SRn9uG6B6BHuX88/+wpU7YnuoHcjOxEDg5HXyA8SPY=;
        b=LJ3F7FExYdmyKfhyFY9hHlzygRjO7ifLUZUkgatICduxzlAkQ0KsKZAvb1+pL+5+Ji
         gEg3vWW7pH5G/kwabOcTtb+RiJ5Iuw6gaMfCwEtw+p8oIPUrRUsUzeepc9hxAvadUUk0
         psGZUbQhJogqUo5yPPMX10U/Jpia7swtUL488l36ojho6rqTjykCZ4ErxzUHQXXIC0d+
         6xj7VmZgFE+Q/5RBesODCeX46o+H1Y0bi03jShisMXbkIFVyccpaEe3BJw2LHxxXutJF
         gCxqo2xn2IvxAml2eztzMx97DnwiOz05xbgf3Obc6sOImvQp9XPdlJ2LVDpEnGFUAMqM
         95tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=1SRn9uG6B6BHuX88/+wpU7YnuoHcjOxEDg5HXyA8SPY=;
        b=LTEYGFTWLFxGoTxt/fXe7rvcd+BLoi5qoZQn6AR6seLAOjgd3XXt6kL9XULBZERQHn
         z23L38MbvkJlwXhLzs53SlAR5VEL/0oU4AwsCPuvuMYgtGjRvSV6fgAK7vc0ghnEgJ1D
         4p+Ni1za9+s2/aeJD4qAkNhpcNoEqJZ1kYhrfNhnNymTLFqbu0X0c+5LBu8EWrgZvrWc
         ORh98Sj/C+j2KXlKNj0qoBvVMNP1z97WMlSZxMJPsNghNioXJtz1ei9RfBdxvVpEENEx
         yM4YRpl3AI8demq/3DxrdASYsz/N9FWj/eFb1GPaeUu/wMm3y21NhhNS25h7Y1qKEK2T
         oN4A==
X-Gm-Message-State: AOAM5300sbOquvlZyEzVOV9492WBkgjNNjUcQLmkwLIup++i3C3O4Z8X
        1xrcAwyUeiv9+Ut/CV/y/sI=
X-Google-Smtp-Source: ABdhPJxq1FBSUE4p8fbyExQ6+pxerVoM31FAmuVNGQrDJfI7GT0BEOhPD2E/VojCoTdwkJxZquXBxg==
X-Received: by 2002:a63:33cf:: with SMTP id z198mr784281pgz.348.1598870241223;
        Mon, 31 Aug 2020 03:37:21 -0700 (PDT)
Received: from localhost.localdomain ([49.207.204.90])
        by smtp.gmail.com with ESMTPSA id x6sm6895449pge.61.2020.08.31.03.37.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Aug 2020 03:37:20 -0700 (PDT)
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
Subject: [PATCH v3 15/35] dmaengine: mpc512x: convert tasklets to use new tasklet_setup() API
Date:   Mon, 31 Aug 2020 16:05:22 +0530
Message-Id: <20200831103542.305571-16-allen.lkml@gmail.com>
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
 drivers/dma/mpc512x_dma.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/dma/mpc512x_dma.c b/drivers/dma/mpc512x_dma.c
index dc2cae7bcf69..c1a69149c8bf 100644
--- a/drivers/dma/mpc512x_dma.c
+++ b/drivers/dma/mpc512x_dma.c
@@ -414,9 +414,9 @@ static void mpc_dma_process_completed(struct mpc_dma *mdma)
 }
 
 /* DMA Tasklet */
-static void mpc_dma_tasklet(unsigned long data)
+static void mpc_dma_tasklet(struct tasklet_struct *t)
 {
-	struct mpc_dma *mdma = (void *)data;
+	struct mpc_dma *mdma = from_tasklet(mdma, t, tasklet);
 	unsigned long flags;
 	uint es;
 
@@ -1009,7 +1009,7 @@ static int mpc_dma_probe(struct platform_device *op)
 		list_add_tail(&mchan->chan.device_node, &dma->channels);
 	}
 
-	tasklet_init(&mdma->tasklet, mpc_dma_tasklet, (unsigned long)mdma);
+	tasklet_setup(&mdma->tasklet, mpc_dma_tasklet);
 
 	/*
 	 * Configure DMA Engine:
-- 
2.25.1

