Return-Path: <dmaengine+bounces-2189-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E3458D1432
	for <lists+dmaengine@lfdr.de>; Tue, 28 May 2024 08:09:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B3622B21E4C
	for <lists+dmaengine@lfdr.de>; Tue, 28 May 2024 06:09:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F699502B9;
	Tue, 28 May 2024 06:09:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="I/KYSXpG"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33E964D9F4;
	Tue, 28 May 2024 06:09:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716876565; cv=none; b=PSautrxn8KRjZk3cN2+D1BfrSD/1YxCw7WseHR4fFMlbUjud4QYK3C8jpVmS6IUnT6J3dpk888a0yDLFmG+Pr+yehLMdN4QQoykw1fWpxpeXaiW+94dYaVMEu4sbCLAFHZtHGrBdgxb+sA/TX7G31646feWR8Mq23BnRYkjtRqQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716876565; c=relaxed/simple;
	bh=ZSYu74n0jq7FH0Svutdp6klx3j4BlvlPnAQfADz0IqU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Wpgil4JylgbZ/zPZrxZz3kOlN5lLCv4W0/nxifnj8sCErNn42bc+xxl1PFytFPyU1YnBWSNB7/oVHph5mWtvTaigM4ZbqrQo/NCQ0CkdKoCRzp6yKxvjaPTmsWT2MzFFFZ7hEkIVLiVc+B4XRlLm39og3+D4HsqVl4dNEDO8ERA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=I/KYSXpG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id D4EABC32782;
	Tue, 28 May 2024 06:09:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716876564;
	bh=ZSYu74n0jq7FH0Svutdp6klx3j4BlvlPnAQfADz0IqU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=I/KYSXpGK5Y+7Ze7M2UUTZJ196NMmqesbqijHwrYyRNEFIMwNxXgN5DiToUMZ+cD2
	 vYkO3Y5kYzTFRcFya3iMV0Hcwg1GgG2aJu7u3P0rIeXoafmoi4ghCB85eU4tik8l2x
	 OK3SinNpNInFFXDbztZYm3feTSE2bDWGIu3BUxfzh4Rzeb/snjUoZF6jS5bXSw3fNF
	 em+GBDxaFXKTmEN+m1re2Kd08NxhmKK9nqBbNv/UgkywPH4apb93yUF1DNYlOD1Gs5
	 a5x0p8bB9GLeGuYh+Paj4hwv6kEDYxNUEpZ/htEhCuZ2GSB1sx9ISGxefgIrDx3EeH
	 T9QesbKvh6mvQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BECA7C27C44;
	Tue, 28 May 2024 06:09:24 +0000 (UTC)
From: Nikita Shubin via B4 Relay <devnull+n.shubin.yadro.com@kernel.org>
Date: Tue, 28 May 2024 09:09:24 +0300
Subject: [PATCH v2 2/3] dmaengine: ioatdma: Fix error path in
 ioat3_dma_probe()
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240528-ioatdma-fixes-v2-2-a9f2fbe26ab1@yadro.com>
References: <20240528-ioatdma-fixes-v2-0-a9f2fbe26ab1@yadro.com>
In-Reply-To: <20240528-ioatdma-fixes-v2-0-a9f2fbe26ab1@yadro.com>
To: Vinod Koul <vkoul@kernel.org>, Dave Jiang <dave.jiang@intel.com>, 
 Logan Gunthorpe <logang@deltatee.com>
Cc: Andy Shevchenko <andy.shevchenko@gmail.com>, 
 Nikita Shubin <nikita.shubin@maquefel.me>, dmaengine@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux@yadro.com, 
 Nikita Shubin <n.shubin@yadro.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1716876563; l=2344;
 i=n.shubin@yadro.com; s=20230718; h=from:subject:message-id;
 bh=ndoUzkFelZyO92hJgOMyePUbXfzsIUrSz43B8VvnQSw=;
 b=wPSkPuxu2pQ/S9Wnfb/LNOSGOhJ/T6XgcFUSUkg+ERcfklrp/fTuxSQ2uetgygBmRXOPVY0/dI5J
 LdjVOBlmBqYjmezsWEvpefml+CHqRjgOmAPfvUvxxcW0msPMgAed
X-Developer-Key: i=n.shubin@yadro.com; a=ed25519;
 pk=vqf5YIUJ7BJv3EJFaNNxWZgGuMgDH6rwufTLflwU9ac=
X-Endpoint-Received: by B4 Relay for n.shubin@yadro.com/20230718 with
 auth_id=161
X-Original-From: Nikita Shubin <n.shubin@yadro.com>
Reply-To: n.shubin@yadro.com

From: Nikita Shubin <n.shubin@yadro.com>

Make sure we are disabling interrupts and destroying DMA pool if
pcie_capability_read/write_word() call failed.

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



