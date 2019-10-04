Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BFDFACBEA1
	for <lists+dmaengine@lfdr.de>; Fri,  4 Oct 2019 17:08:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389539AbfJDPIg (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 4 Oct 2019 11:08:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:50750 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389677AbfJDPIg (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Fri, 4 Oct 2019 11:08:36 -0400
Received: from localhost.localdomain (unknown [194.230.155.145])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B96F4207FF;
        Fri,  4 Oct 2019 15:08:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570201715;
        bh=Eg8FPQK/Pm2Om/sdAfQzaKVl6unvVYSCem396Vm+o6w=;
        h=From:To:Subject:Date:From;
        b=ZoIdYutkRB5Cyh3nYJanzPbDkuKVJqj5dQnA7g2sBmgqIT4oTMmodiHj4pO5gNu5w
         yr5Lc/3eQuieBvvVfQT40vBz2lKp7J07gIs0uSDMIhNfoUWe0togEh8exe8+W5nlcr
         M2hRc4fmfQjvcrwvF5dtfNbf6nPh9kc6TuypYRZY=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Vinod Koul <vkoul@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Peng Ma <peng.ma@nxp.com>, Wen He <wen.he_1@nxp.com>,
        Jiaheng Fan <jiaheng.fan@nxp.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [RFT] dmaengine: fsl-qdma: Handle invalid qdma-queue0 IRQ
Date:   Fri,  4 Oct 2019 17:08:26 +0200
Message-Id: <20191004150826.6656-1-krzk@kernel.org>
X-Mailer: git-send-email 2.17.1
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

platform_get_irq_byname() might return -errno which later would be cast
to an unsigned int and used in IRQ handling code leading to usage of
wrong ID and errors about wrong irq_base.

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>

---

Not marking as cc-stable as this was not reproduced and not tested.
---
 drivers/dma/fsl-qdma.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/dma/fsl-qdma.c b/drivers/dma/fsl-qdma.c
index 06664fbd2d91..89792083d62c 100644
--- a/drivers/dma/fsl-qdma.c
+++ b/drivers/dma/fsl-qdma.c
@@ -1155,6 +1155,9 @@ static int fsl_qdma_probe(struct platform_device *pdev)
 		return ret;
 
 	fsl_qdma->irq_base = platform_get_irq_byname(pdev, "qdma-queue0");
+	if (fsl_qdma->irq_base < 0)
+		return fsl_qdma->irq_base;
+
 	fsl_qdma->feature = of_property_read_bool(np, "big-endian");
 	INIT_LIST_HEAD(&fsl_qdma->dma_dev.channels);
 
-- 
2.17.1

