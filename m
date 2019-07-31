Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 194527CAA2
	for <lists+dmaengine@lfdr.de>; Wed, 31 Jul 2019 19:37:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728362AbfGaRhI (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 31 Jul 2019 13:37:08 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:33361 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727125AbfGaRhI (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 31 Jul 2019 13:37:08 -0400
Received: by mail-pg1-f195.google.com with SMTP id n190so952698pgn.0;
        Wed, 31 Jul 2019 10:37:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=fovcjXjS+SQSLt0zbH4OXuaUHccPIpQLVLIxfCRGuVc=;
        b=ke0qwDJQa094m996Q4z4dCyY4CkF9zHTkSsGFzV93mRB/QdgfGqaggV303riaya25p
         6hnS4MZx3y7S00BG7aF06PmLDxyWuMRT9MGiFQ6KNtLaqojfXWaSb6vXjGgVujriuyP6
         h2v/5O+w5oDtnBekoQmRqTJFR7youuKrvVN+DMmTp5HORKPHUiM/F4gL9XMB/ykRVayg
         QpErOpILmBGoPAOKzJ4SdX8roh8Rz1AM/unP1s4jRvmGbsLP+JJyv9i5wRcK0y1kCyEa
         REW5BqKNatt2SwQc462R0KxymeZthCMmyj2BxK/fMTM+7pgRFXu5N8DYdvmK9k80Ikrg
         5d4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=fovcjXjS+SQSLt0zbH4OXuaUHccPIpQLVLIxfCRGuVc=;
        b=AVWpJpl/DBp8zgjgLg5obr1wLcFAemm7W3HZAZtr9AhryYy/1fLIG+LoxzwDxdQQ05
         iKAkv+aGuyevJDm5M+hIzODsSXpc3eoYHfRmm/5G/uWx5rUbnSTXHeKfJrF/rET7GTTC
         t/jyOtRKJsFQ7ahNK476vPj/5Bz+oq+4VNiCoYHoC0vysTxoZy1vdieAExqHlhEnV+Zx
         8MLG6G1sD4gJZ3NSaKgdDUWs/1nyZ3WnHe/RzcTLFqqkPLRchjT+zEhEPrfsdnm5nJgb
         ZpfUHY/dOCM+tl+j5gaY1AkQo7r3CuLNi+9l3/E9XrV/7vG/Jnq/fm0jORKmyPZjEM2n
         +ZMg==
X-Gm-Message-State: APjAAAV0cafhrxylfkHrQ7m4xWWyUs049+eVqk1OU71RfC6VSGLiZtHi
        VPb3yEyU3+//bvwV9nHIuuZcPdqL
X-Google-Smtp-Source: APXvYqwhkZAw1wHXUM+vQnAK/0pT3Y6tucx5LyNYOTnCNBw9j94JVIkDCIfPVuFOK92tiA7MAXDV7g==
X-Received: by 2002:aa7:9a01:: with SMTP id w1mr47003873pfj.262.1564594626662;
        Wed, 31 Jul 2019 10:37:06 -0700 (PDT)
Received: from localhost.localdomain ([2607:fb90:4ad:5a0b:2aff:6e0f:8973:5a26])
        by smtp.gmail.com with ESMTPSA id r2sm87106926pfl.67.2019.07.31.10.37.05
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 31 Jul 2019 10:37:06 -0700 (PDT)
From:   Andrey Smirnov <andrew.smirnov@gmail.com>
To:     dmaengine@vger.kernel.org
Cc:     Andrey Smirnov <andrew.smirnov@gmail.com>,
        Stefan Agner <stefan@agner.ch>,
        Chris Healy <cphealy@gmail.com>, Vinod Koul <vkoul@kernel.org>,
        linux-imx@nxp.com, linux-kernel@vger.kernel.org
Subject: [PATCH] dmaengine: fsl-edma: implement .device_synchronize callback
Date:   Wed, 31 Jul 2019 10:36:59 -0700
Message-Id: <20190731173659.14778-1-andrew.smirnov@gmail.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Implement .device_synchronize callback in order to be able to use
dmaengine_terminate_sync() and other primitives relying on said
callback.

Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
Cc: Stefan Agner <stefan@agner.ch>
Cc: Chris Healy <cphealy@gmail.com>
Cc: Vinod Koul <vkoul@kernel.org>
Cc: linux-imx@nxp.com
Cc: dmaengine@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
---
 drivers/dma/fsl-edma.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/dma/fsl-edma.c b/drivers/dma/fsl-edma.c
index fcbad6ae954a..191fa71f67a3 100644
--- a/drivers/dma/fsl-edma.c
+++ b/drivers/dma/fsl-edma.c
@@ -20,6 +20,13 @@
 
 #include "fsl-edma-common.h"
 
+static void fsl_edma_synchronize(struct dma_chan *chan)
+{
+	struct fsl_edma_chan *fsl_chan = to_fsl_edma_chan(chan);
+
+	vchan_synchronize(&fsl_chan->vchan);
+}
+
 static irqreturn_t fsl_edma_tx_handler(int irq, void *dev_id)
 {
 	struct fsl_edma_engine *fsl_edma = dev_id;
@@ -302,6 +309,7 @@ static int fsl_edma_probe(struct platform_device *pdev)
 	fsl_edma->dma_dev.device_pause = fsl_edma_pause;
 	fsl_edma->dma_dev.device_resume = fsl_edma_resume;
 	fsl_edma->dma_dev.device_terminate_all = fsl_edma_terminate_all;
+	fsl_edma->dma_dev.device_synchronize = fsl_edma_synchronize;
 	fsl_edma->dma_dev.device_issue_pending = fsl_edma_issue_pending;
 
 	fsl_edma->dma_dev.src_addr_widths = FSL_EDMA_BUSWIDTHS;
-- 
2.21.0

