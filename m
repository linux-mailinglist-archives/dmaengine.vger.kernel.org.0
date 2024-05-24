Return-Path: <dmaengine+bounces-2150-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A57468CE41F
	for <lists+dmaengine@lfdr.de>; Fri, 24 May 2024 12:24:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 610142822EB
	for <lists+dmaengine@lfdr.de>; Fri, 24 May 2024 10:24:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0C1685926;
	Fri, 24 May 2024 10:24:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RNvsIetB"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8FB485659;
	Fri, 24 May 2024 10:24:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716546288; cv=none; b=J1VZkwvKEZ4+wGnVNDUXR+hpmJDphJU9/LYzZRq9U4j0Iylvx0VX/L6OW1uZq/PPu5Hwx7Inu6mNr639W5rjpIX37WfaTzGMYocggJrkdMALJQf5Ow9aqbb02TVM5UAI0lRIfJcRgViTiSMn3y7sqIaLuxtweg7NeTa3FY+MglA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716546288; c=relaxed/simple;
	bh=+Xwg1obtahMG+OMmYPo9UZE7TNKBTAgy+LkWtie3B+M=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=HUTXLCl1J/+AkKQXV3hcHUJdssyR9e+LFKeL7bVvYBzRAViM4Y+AeBeqwzuw0HHidfpozMBCSUh1e7mDO11OBg936KpYlW52GNpchjR41NuA8o+Ea5Na42tVozjlqpddtHEjF+p0UlqY+TQzY1WiRori9QGkzOWDq4JEW6ZIKh4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RNvsIetB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 46FEAC32786;
	Fri, 24 May 2024 10:24:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716546288;
	bh=+Xwg1obtahMG+OMmYPo9UZE7TNKBTAgy+LkWtie3B+M=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=RNvsIetBhbS+viIV06Po5VgAZE7gm86xqkeN/idpQnz82YJr3bvKMJG93ZLC8lOp8
	 BLKa9FHWHlWyKMgo/d/cJNXLn3WtjL+eSWP2/wgQHI7dtrttMqmFbYkRlHls7St2BA
	 LCpsG7naJXwbMpmsoHyJxraiK7qVqAGl/8ORxuExXD9PyGq+3cN7EWYvC+w/aIPgG/
	 iAooaF6wq78yOhzK7/9NE+xCErkL00R4FgtrmVvzf5mJDPTt13Tuzpj1FDbLB6rlOJ
	 iFhbqTCD3XMXBHFHjhDDsDlYJzMvGieZzyUlEPFHsNPrOQIRJd5Fdr/56bygAwR2Dy
	 iQsLrbe1MIerw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39B10C25B7D;
	Fri, 24 May 2024 10:24:48 +0000 (UTC)
From: Nikita Shubin via B4 Relay <devnull+n.shubin.yadro.com@kernel.org>
Date: Fri, 24 May 2024 13:24:47 +0300
Subject: [PATCH 2/3] dmaengine: ioatdma: Fix error path in
 ioat3_dma_probe()
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240524-ioatdma-fixes-v1-2-b785f1f7accc@yadro.com>
References: <20240524-ioatdma-fixes-v1-0-b785f1f7accc@yadro.com>
In-Reply-To: <20240524-ioatdma-fixes-v1-0-b785f1f7accc@yadro.com>
To: Vinod Koul <vkoul@kernel.org>, Dave Jiang <dave.jiang@intel.com>, 
 Logan Gunthorpe <logang@deltatee.com>
Cc: dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Nikita Shubin <n.shubin@yadro.com>, 
 Andy Shevchenko <andy.shevchenko@gmail.com>
X-Mailer: b4 0.12.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1716546287; l=2339;
 i=n.shubin@yadro.com; s=20230718; h=from:subject:message-id;
 bh=1J9pYoSRMAKIsykWrRlecq2P2EWahYir9dwIgjGtL/M=;
 b=3mT6Q6/jDE+ihQbicBccjH2ookRbsf79eAyo5qhgQRY3x09G5cdUiFCS5G0ehZku6VqBUNXvAfhc
 OE+GrUPFDCAYwKViG88wlhcDrXOcB4rqSq1WRHJC+ewlktkGZXif
X-Developer-Key: i=n.shubin@yadro.com; a=ed25519;
 pk=vqf5YIUJ7BJv3EJFaNNxWZgGuMgDH6rwufTLflwU9ac=
X-Endpoint-Received: by B4 Relay for n.shubin@yadro.com/20230718 with
 auth_id=161
X-Original-From: Nikita Shubin <n.shubin@yadro.com>
Reply-To: n.shubin@yadro.com

From: Nikita Shubin <n.shubin@yadro.com>

Make sure we are disabling interrupts and destroying DMA pool if
pcie_capability_read/write_word() failes.

Fixes: 511deae0261c ("dmaengine: ioatdma: disable relaxed ordering for ioatdma")
Signed-off-by: Nikita Shubin <n.shubin@yadro.com>
---
 drivers/dma/ioat/init.c | 33 +++++++++++++++------------------
 1 file changed, 15 insertions(+), 18 deletions(-)

diff --git a/drivers/dma/ioat/init.c b/drivers/dma/ioat/init.c
index e76e507ae898..26964b7c8cf1 100644
--- a/drivers/dma/ioat/init.c
+++ b/drivers/dma/ioat/init.c
@@ -534,18 +534,6 @@ static int ioat_probe(struct ioatdma_device *ioat_dma)
 	return err;
 }
 
-static int ioat_register(struct ioatdma_device *ioat_dma)
-{
-	int err = dma_async_device_register(&ioat_dma->dma_dev);
-
-	if (err) {
-		ioat_disable_interrupts(ioat_dma);
-		dma_pool_destroy(ioat_dma->completion_pool);
-	}
-
-	return err;
-}
-
 static void ioat_dma_remove(struct ioatdma_device *ioat_dma)
 {
 	struct dma_device *dma = &ioat_dma->dma_dev;
@@ -1181,9 +1169,9 @@ static int ioat3_dma_probe(struct ioatdma_device *ioat_dma, int dca)
 		       ioat_chan->reg_base + IOAT_DCACTRL_OFFSET);
 	}
 
-	err = ioat_register(ioat_dma);
+	err = dma_async_device_register(&ioat_dma->dma_dev);
 	if (err)
-		return err;
+		goto err_disable_interrupts;
 
 	ioat_kobject_add(ioat_dma, &ioat_ktype);
 
@@ -1192,20 +1180,29 @@ static int ioat3_dma_probe(struct ioatdma_device *ioat_dma, int dca)
 
 	/* disable relaxed ordering */
 	err = pcie_capability_read_word(pdev, PCI_EXP_DEVCTL, &val16);
-	if (err)
-		return pcibios_err_to_errno(err);
+	if (err) {
+		err = pcibios_err_to_errno(err);
+		goto err_disable_interrupts;
+	}
 
 	/* clear relaxed ordering enable */
 	val16 &= ~PCI_EXP_DEVCTL_RELAX_EN;
 	err = pcie_capability_write_word(pdev, PCI_EXP_DEVCTL, val16);
-	if (err)
-		return pcibios_err_to_errno(err);
+	if (err) {
+		err = pcibios_err_to_errno(err);
+		goto err_disable_interrupts;
+	}
 
 	if (ioat_dma->cap & IOAT_CAP_DPS)
 		writeb(ioat_pending_level + 1,
 		       ioat_dma->reg_base + IOAT_PREFETCH_LIMIT_OFFSET);
 
 	return 0;
+
+err_disable_interrupts:
+	ioat_disable_interrupts(ioat_dma);
+	dma_pool_destroy(ioat_dma->completion_pool);
+	return err;
 }
 
 static void ioat_shutdown(struct pci_dev *pdev)

-- 
2.43.2



