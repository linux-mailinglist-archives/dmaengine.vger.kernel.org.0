Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9618E10077F
	for <lists+dmaengine@lfdr.de>; Mon, 18 Nov 2019 15:37:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726654AbfKROhE (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 18 Nov 2019 09:37:04 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:33326 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727007AbfKROhE (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 18 Nov 2019 09:37:04 -0500
Received: by mail-pf1-f193.google.com with SMTP id c184so10499403pfb.0
        for <dmaengine@vger.kernel.org>; Mon, 18 Nov 2019 06:37:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=mvcfD7jITpqxjPheoMWCVxZTnjlcuW9ormSnkwSOmcw=;
        b=gx9t8ngLd1CKC2pOlKZxYKX/nb5b9Fla8ZmjaRV/f8hRHqcWzKT0SkQjuOeLUjkKzn
         bFiG1jbyJFszN6zUVehwdvnzDa7wZFbptFOlC8GAokKRZ3Q+zT4GLa1Dc5f2kvdflX5K
         +M+f/XLEWA3bayoKRh2Nze4IHteHT7+NASZQ8d29w77i2HMTvYoB2mSW8SALJd3zeKJm
         SBVQv3hzaaye8Qo/qR4EM4KkduTQLorIhb0ox4uMXRTsllk1x22dGuN2bKMV/fkDCMGp
         h9eaKaNwdcjjSMo77ClhglL2Ih9Xy7ydV2KvQq7MbYshPYZ3HtTJZIAAQqepUV5ttn64
         jhnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=mvcfD7jITpqxjPheoMWCVxZTnjlcuW9ormSnkwSOmcw=;
        b=hL/8NdUvkyDPjr+bWtbXzoOOusSQ3Q2myCNV+CFdtDb8Vkxd9pR2c4NPZrh6Qd4yos
         FTXDdsWfyWx2UBzkedf+UTiAxFa0W5bm8mgTJhkYFjKGeD59Nw8g7CQL8S3UzeIqBywa
         zd3TjZxPeRhyncrtiz8x4/iab2IJskj+EvRcIwHMgYLNfqY0SekKFVU+T+ubaLAr59rp
         zdQyQrt6elQs0BnXwjQyHJ+sZCsJfBGrD/81pDqvDzByrfC8VbDupPL+xj0bjHtgWxbT
         +e0ZBStpcWmugXPeZD/UCHgE9bikAfSYO17RD2TZ0kBX23DpBMHihOQyU6DQt5VhIY3l
         ffpg==
X-Gm-Message-State: APjAAAUTmymRNY1QA0Sgr6K3geCRuw6nPGihX6gM52RnySyON1IbaJ+M
        z1137sAFEzmMMbY/zHT0doHDLA==
X-Google-Smtp-Source: APXvYqynVHo9DCmHG04AdxQEaRenl+NyG/k0fpAYb6SsXQrD+cOLuHrcjkW15y7tKXTly3zWYi5gEw==
X-Received: by 2002:a63:5b0c:: with SMTP id p12mr5854647pgb.196.1574087823195;
        Mon, 18 Nov 2019 06:37:03 -0800 (PST)
Received: from localhost.localdomain (1-169-21-101.dynamic-ip.hinet.net. [1.169.21.101])
        by smtp.gmail.com with ESMTPSA id x10sm21910996pfn.36.2019.11.18.06.37.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Nov 2019 06:37:02 -0800 (PST)
From:   Green Wan <green.wan@sifive.com>
Cc:     Green Wan <green.wan@sifive.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Vinod Koul <vkoul@kernel.org>, dmaengine@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] dmaengine: sf-pdma: move macro to header file
Date:   Mon, 18 Nov 2019 22:35:53 +0800
Message-Id: <20191118143554.16129-2-green.wan@sifive.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191118143554.16129-1-green.wan@sifive.com>
References: <20191118143554.16129-1-green.wan@sifive.com>
To:     unlisted-recipients:; (no To-header on input)
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

The place where the macro, SF_PDMA_REG_BASE(), is cause kernel-doc
using wrong function declaration. Move it to header file.

Signed-off-by: Green Wan <green.wan@sifive.com>
---
 drivers/dma/sf-pdma/sf-pdma.c | 1 -
 drivers/dma/sf-pdma/sf-pdma.h | 2 ++
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/dma/sf-pdma/sf-pdma.c b/drivers/dma/sf-pdma/sf-pdma.c
index e8b9770dcfba..465256fe8b1f 100644
--- a/drivers/dma/sf-pdma/sf-pdma.c
+++ b/drivers/dma/sf-pdma/sf-pdma.c
@@ -435,7 +435,6 @@ static int sf_pdma_irq_init(struct platform_device *pdev, struct sf_pdma *pdma)
  *
  * Return: none
  */
-#define SF_PDMA_REG_BASE(ch)	(pdma->membase + (PDMA_CHAN_OFFSET * (ch)))
 static void sf_pdma_setup_chans(struct sf_pdma *pdma)
 {
 	int i;
diff --git a/drivers/dma/sf-pdma/sf-pdma.h b/drivers/dma/sf-pdma/sf-pdma.h
index aab65a0bdfcc..0c20167b097d 100644
--- a/drivers/dma/sf-pdma/sf-pdma.h
+++ b/drivers/dma/sf-pdma/sf-pdma.h
@@ -57,6 +57,8 @@
 /* Error Recovery */
 #define MAX_RETRY					1
 
+#define SF_PDMA_REG_BASE(ch)	(pdma->membase + (PDMA_CHAN_OFFSET * (ch)))
+
 struct pdma_regs {
 	/* read-write regs */
 	void __iomem *ctrl;		/* 4 bytes */
-- 
2.17.1

