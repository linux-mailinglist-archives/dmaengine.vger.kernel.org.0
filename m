Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 22551F1B4E
	for <lists+dmaengine@lfdr.de>; Wed,  6 Nov 2019 17:32:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727625AbfKFQcK (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 6 Nov 2019 11:32:10 -0500
Received: from mail.kernel.org ([198.145.29.99]:44076 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727321AbfKFQcK (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Wed, 6 Nov 2019 11:32:10 -0500
Received: from localhost.localdomain (unknown [223.226.46.117])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A39F22067B;
        Wed,  6 Nov 2019 16:32:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573057930;
        bh=UPtPfF84kJmerAR8ODzUcUrcSkzXPV5RdNC910/MOrA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Q3j94BBoGTEvkJE8Oa0DtJRiNDJax2881WdNcXl+7Ud2OhX7PEUzuwIpY+IW9JyBo
         hhcCQfiqZUZzWnDBl65pcPuEssgahKuFoXHUYrmvPQxfX27Wea56YXbBCn0jYR0En4
         uKlUfYHAFfreM7BqTdo8BWY0FCG1+7ziiSD5KG+o=
From:   Vinod Koul <vkoul@kernel.org>
To:     dmaengine@vger.kernel.org
Cc:     jaswinder.singh@linaro.org, Vinod Koul <vkoul@kernel.org>,
        kbuild test robot <lkp@intel.com>
Subject: [PATCH 2/2] dmaengine: milbeaut-xdmac: remove redundant error log
Date:   Wed,  6 Nov 2019 22:01:28 +0530
Message-Id: <20191106163128.1980714-2-vkoul@kernel.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191106163128.1980714-1-vkoul@kernel.org>
References: <20191106163128.1980714-1-vkoul@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

platform_get_irq() prints the error message, so caller need not do so,
remove the error line in this driver for platform_get_irq()

Reported-by: kbuild test robot <lkp@intel.com>
Signed-off-by: Vinod Koul <vkoul@kernel.org>
---
 drivers/dma/milbeaut-xdmac.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/dma/milbeaut-xdmac.c b/drivers/dma/milbeaut-xdmac.c
index 3d5b1926a58d..ab3d2f395378 100644
--- a/drivers/dma/milbeaut-xdmac.c
+++ b/drivers/dma/milbeaut-xdmac.c
@@ -269,11 +269,8 @@ static int milbeaut_xdmac_chan_init(struct platform_device *pdev,
 	int irq, ret;
 
 	irq = platform_get_irq(pdev, chan_id);
-	if (irq < 0) {
-		dev_err(&pdev->dev, "failed to get IRQ number for ch%d\n",
-			chan_id);
+	if (irq < 0)
 		return irq;
-	}
 
 	irq_name = devm_kasprintf(dev, GFP_KERNEL, "milbeaut-xdmac-%d",
 				  chan_id);
-- 
2.23.0

