Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 178A528E54
	for <lists+dmaengine@lfdr.de>; Fri, 24 May 2019 02:29:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727435AbfEXA3D (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 23 May 2019 20:29:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:35810 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731722AbfEXA3D (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Thu, 23 May 2019 20:29:03 -0400
Received: from localhost.localdomain (cpe-70-114-128-244.austin.res.rr.com [70.114.128.244])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E3A072184B;
        Fri, 24 May 2019 00:29:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1558657742;
        bh=uGkMtxhX7YO2eDhvf7fl/k0LrtSWRIv+eGoSDqaqQOY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=UNQDL0H+2M7TjaEQi1B8bX6lLpqV4Y9WkDSUwHbeJPcWeDbLRxkluFvdBrJaBF9a0
         Oo5nSF50ZTDOuT/6kPDGgNZztGZF76NF7PYi28942nKarwY1R5Vszr/pd8qFW58bLl
         a4Rm0eYvluA3yfjyx6ni6KwMFjAtezETzuNExl24=
From:   Dinh Nguyen <dinguyen@kernel.org>
To:     dmaengine@vger.kernel.org
Cc:     dinguyen@kernel.org, robh+dt@kernel.org, mark.rutland@arm.com,
        devicetree@vger.kernel.org, vkoul@kernel.org
Subject: [PATCH 2/2] dmagengine: pl330: add code to get reset property
Date:   Thu, 23 May 2019 19:28:47 -0500
Message-Id: <20190524002847.30961-2-dinguyen@kernel.org>
X-Mailer: git-send-email 2.20.0
In-Reply-To: <20190524002847.30961-1-dinguyen@kernel.org>
References: <20190524002847.30961-1-dinguyen@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

The DMA controller on some SoCs can be held in reset, and thus requires
the reset signal(s) to deasserted. Most SoCs will have just one reset
signal, but there are others, i.e. Arria10/Stratix10 will have an
additional reset signal, referred to as the OCP.

Add code to get the reset property from the device tree for deassert and
assert.

Signed-off-by: Dinh Nguyen <dinguyen@kernel.org>
---
 drivers/dma/pl330.c | 38 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 38 insertions(+)

diff --git a/drivers/dma/pl330.c b/drivers/dma/pl330.c
index 6e6837214210..6018c43e785d 100644
--- a/drivers/dma/pl330.c
+++ b/drivers/dma/pl330.c
@@ -29,6 +29,7 @@
 #include <linux/err.h>
 #include <linux/pm_runtime.h>
 #include <linux/bug.h>
+#include <linux/reset.h>
 
 #include "dmaengine.h"
 #define PL330_MAX_CHAN		8
@@ -500,6 +501,9 @@ struct pl330_dmac {
 	unsigned int num_peripherals;
 	struct dma_pl330_chan *peripherals; /* keep at end */
 	int quirks;
+
+	struct reset_control	*rstc;
+	struct reset_control	*rstc_ocp;
 };
 
 static struct pl330_of_quirks {
@@ -3028,6 +3032,30 @@ pl330_probe(struct amba_device *adev, const struct amba_id *id)
 
 	amba_set_drvdata(adev, pl330);
 
+	pl330->rstc = devm_reset_control_get_optional(&adev->dev, "dma");
+	if (IS_ERR(pl330->rstc)) {
+		dev_err(&adev->dev, "No reset controller specified.\n");
+		return PTR_ERR(pl330->rstc);
+	} else {
+		ret = reset_control_deassert(pl330->rstc);
+		if (ret) {
+			dev_err(&adev->dev, "Couldn't deassert the device from reset!\n");
+			return ret;
+		}
+	}
+
+	pl330->rstc_ocp = devm_reset_control_get_optional(&adev->dev, "dma-ocp");
+	if (IS_ERR(pl330->rstc_ocp)) {
+		dev_err(&adev->dev, "No reset controller specified.\n");
+		return PTR_ERR(pl330->rstc_ocp);
+	} else {
+		ret = reset_control_deassert(pl330->rstc_ocp);
+		if (ret) {
+			dev_err(&adev->dev, "Couldn't deassert the device from OCP reset!\n");
+			return ret;
+		}
+	}
+
 	for (i = 0; i < AMBA_NR_IRQS; i++) {
 		irq = adev->irq[i];
 		if (irq) {
@@ -3168,6 +3196,11 @@ pl330_probe(struct amba_device *adev, const struct amba_id *id)
 probe_err2:
 	pl330_del(pl330);
 
+	if (pl330->rstc_ocp)
+		reset_control_assert(pl330->rstc_ocp);
+
+	if (pl330->rstc)
+		reset_control_assert(pl330->rstc);
 	return ret;
 }
 
@@ -3206,6 +3239,11 @@ static int pl330_remove(struct amba_device *adev)
 
 	pl330_del(pl330);
 
+	if (pl330->rstc_ocp)
+		reset_control_assert(pl330->rstc_ocp);
+
+	if (pl330->rstc)
+		reset_control_assert(pl330->rstc);
 	return 0;
 }
 
-- 
2.20.0

