Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A095A3919A
	for <lists+dmaengine@lfdr.de>; Fri,  7 Jun 2019 18:08:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729408AbfFGQIG (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 7 Jun 2019 12:08:06 -0400
Received: from outils.crapouillou.net ([89.234.176.41]:43290 "EHLO
        crapouillou.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729325AbfFGQIG (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 7 Jun 2019 12:08:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
        s=mail; t=1559923684; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-transfer-encoding:content-transfer-encoding:
         in-reply-to:references; bh=pPdct4nxolFWj+t4NKhn66He7yVpfQKpnrZgLcSoTHs=;
        b=CsjYsh8Oe+h3i8kpzDcJxoO8/2u1tkJYw9HsY7aJ01Pt1Prrlr0zODO2A5dIFWdiovSZHx
        8iqmQUzcSPNSuEli1KCMMARlmRpEJ+xTVhdIAeNCnjMaBK2fgAvksewqjoDp1I/lGNwoqr
        ky4QR0SsKlBQwrJg3/arCW1RjYhpBik=
From:   Paul Cercueil <paul@crapouillou.net>
To:     Zubair Lutfullah Kakakhel <Zubair.Kakakhel@imgtec.com>,
        Vinod Koul <vkoul@kernel.org>
Cc:     dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
        od@zcrc.me, Paul Cercueil <paul@crapouillou.net>
Subject: [PATCH] dma: jz4780: Make probe function __init_or_module
Date:   Fri,  7 Jun 2019 18:07:58 +0200
Message-Id: <20190607160758.16794-1-paul@crapouillou.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

This allows the probe function to be dropped after the kernel finished
its initialization, in the case where the driver was not compiled as a
module.

Signed-off-by: Paul Cercueil <paul@crapouillou.net>
---
 drivers/dma/dma-jz4780.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/dma/dma-jz4780.c b/drivers/dma/dma-jz4780.c
index 7204fdeff6c5..b2f7e6660ad6 100644
--- a/drivers/dma/dma-jz4780.c
+++ b/drivers/dma/dma-jz4780.c
@@ -815,7 +815,7 @@ static struct dma_chan *jz4780_of_dma_xlate(struct of_phandle_args *dma_spec,
 	}
 }
 
-static int jz4780_dma_probe(struct platform_device *pdev)
+static int __init_or_module jz4780_dma_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
 	const struct jz4780_dma_soc_data *soc_data;
@@ -966,7 +966,7 @@ static int jz4780_dma_probe(struct platform_device *pdev)
 	return ret;
 }
 
-static int jz4780_dma_remove(struct platform_device *pdev)
+static int __exit jz4780_dma_remove(struct platform_device *pdev)
 {
 	struct jz4780_dma_dev *jzdma = platform_get_drvdata(pdev);
 	int i;
-- 
2.21.0.593.g511ec345e18

