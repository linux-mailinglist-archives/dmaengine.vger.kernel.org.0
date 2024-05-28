Return-Path: <dmaengine+bounces-2187-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C4B688D1430
	for <lists+dmaengine@lfdr.de>; Tue, 28 May 2024 08:09:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 838631F229B7
	for <lists+dmaengine@lfdr.de>; Tue, 28 May 2024 06:09:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 564915027F;
	Tue, 28 May 2024 06:09:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="in+WL5mo"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E876DF6B;
	Tue, 28 May 2024 06:09:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716876565; cv=none; b=tyjcgKRmZJ/ZxJ3efVVNCBldLnTW0YciY+QP5v94VtdIAqh7Vj9E/g2P3P8dmdaVYGc24bdYntN+51YW7eo4sMRcGvocFxOK5k+Kxmyjj2w2hkLcv+sXsyYMOTFEZ5mRTEXPcTRluL/FVhiWqOVcNlJXKiE/CwFEMIImesKKO14=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716876565; c=relaxed/simple;
	bh=nKrlwxVQZ9JWwpGEnhgFrcVm0BXTkJ1KgeGuEWOqKj8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=hT9IZvq1fw6v3LHjyco15exRiw+S9mCywojOab/KqecPcktfp89ZPR30TQ0n8iOC/oEldWsgNAph6sVV+QrZEdhUl+X+0GdcWPIosNhtaOtKQR2Rk+HMTYRO85oHVdvFOd29C6g+uXboawWe5nlfqG/Z6ixHOjw84YiE0WQfHeI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=in+WL5mo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id CAA5FC32786;
	Tue, 28 May 2024 06:09:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716876564;
	bh=nKrlwxVQZ9JWwpGEnhgFrcVm0BXTkJ1KgeGuEWOqKj8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=in+WL5mous3ATfr/+7DOLw07nAg78gfEuavJmC7UPmOOqUNO5ut+txv2j8/x/v8CM
	 l6L66bVFW3OEw1wWmjkVOcT6BPfcWwoed7+aa2yO0SwYJ0xFQ7CxGrleb+FNWh/vMw
	 oh7MFiQslGW9M6ZtuDlNJ9ipZme6TaQTfWLC6YTet0uOV8fdbAZhaNB3Fgveb3lL8F
	 y/2DT7JD+xYa/sX3fPuz0aZGFTB8gAfkTctUWQyaeB54e4naMO/p2XntKKytg7MYej
	 82iIbErXcihXmOErJy43MpZ3S7eZBH/LCi2gS3EXmV3GSRURPVVJdLfn1a07C0kxIW
	 DDAei6h2fBHrQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0E2AC25B7E;
	Tue, 28 May 2024 06:09:24 +0000 (UTC)
From: Nikita Shubin via B4 Relay <devnull+n.shubin.yadro.com@kernel.org>
Date: Tue, 28 May 2024 09:09:23 +0300
Subject: [PATCH v2 1/3] dmaengine: ioatdma: Fix leaking on version mismatch
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240528-ioatdma-fixes-v2-1-a9f2fbe26ab1@yadro.com>
References: <20240528-ioatdma-fixes-v2-0-a9f2fbe26ab1@yadro.com>
In-Reply-To: <20240528-ioatdma-fixes-v2-0-a9f2fbe26ab1@yadro.com>
To: Vinod Koul <vkoul@kernel.org>, Dave Jiang <dave.jiang@intel.com>, 
 Logan Gunthorpe <logang@deltatee.com>
Cc: Andy Shevchenko <andy.shevchenko@gmail.com>, 
 Nikita Shubin <nikita.shubin@maquefel.me>, dmaengine@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux@yadro.com, 
 Nikita Shubin <n.shubin@yadro.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1716876563; l=1829;
 i=n.shubin@yadro.com; s=20230718; h=from:subject:message-id;
 bh=ASVt6+nzAUVivKjUfhTrAzVsAPEzKEYVziXwIRDAuFU=;
 b=vpo6veO0EiOXKv0hYhTJJNEvRbRU1sbfQMuG2vWjy3lqgJHqU2tqnTVFSN2z+ubGZBVJX9qAa3xx
 v7zI2MRnCM0apPH/L8dPZb4icGLoAUz5mBQ0Q4nL3QtIGKaDJ/Yy
X-Developer-Key: i=n.shubin@yadro.com; a=ed25519;
 pk=vqf5YIUJ7BJv3EJFaNNxWZgGuMgDH6rwufTLflwU9ac=
X-Endpoint-Received: by B4 Relay for n.shubin@yadro.com/20230718 with
 auth_id=161
X-Original-From: Nikita Shubin <n.shubin@yadro.com>
Reply-To: n.shubin@yadro.com

From: Nikita Shubin <n.shubin@yadro.com>

Fix leaking ioatdma_device if I/OAT version is less than IOAT_VER_3_0.

Fixes: bf453a0a18b2 ("dmaengine: ioat: Support in-use unbind")
Signed-off-by: Nikita Shubin <n.shubin@yadro.com>
---
 drivers/dma/ioat/init.c | 17 ++++++++++-------
 1 file changed, 10 insertions(+), 7 deletions(-)

diff --git a/drivers/dma/ioat/init.c b/drivers/dma/ioat/init.c
index 9c364e92cb82..e76e507ae898 100644
--- a/drivers/dma/ioat/init.c
+++ b/drivers/dma/ioat/init.c
@@ -1350,6 +1350,7 @@ static int ioat_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 	void __iomem * const *iomap;
 	struct device *dev = &pdev->dev;
 	struct ioatdma_device *device;
+	u8 version;
 	int err;
 
 	err = pcim_enable_device(pdev);
@@ -1363,6 +1364,10 @@ static int ioat_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 	if (!iomap)
 		return -ENOMEM;
 
+	version = readb(iomap[IOAT_MMIO_BAR] + IOAT_VER_OFFSET);
+	if (version < IOAT_VER_3_0)
+		return -ENODEV;
+
 	err = dma_set_mask_and_coherent(&pdev->dev, DMA_BIT_MASK(64));
 	if (err)
 		return err;
@@ -1373,16 +1378,14 @@ static int ioat_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 	pci_set_master(pdev);
 	pci_set_drvdata(pdev, device);
 
-	device->version = readb(device->reg_base + IOAT_VER_OFFSET);
+	device->version = version;
 	if (device->version >= IOAT_VER_3_4)
 		ioat_dca_enabled = 0;
-	if (device->version >= IOAT_VER_3_0) {
-		if (is_skx_ioat(pdev))
-			device->version = IOAT_VER_3_2;
-		err = ioat3_dma_probe(device, ioat_dca_enabled);
-	} else
-		return -ENODEV;
 
+	if (is_skx_ioat(pdev))
+		device->version = IOAT_VER_3_2;
+
+	err = ioat3_dma_probe(device, ioat_dca_enabled);
 	if (err) {
 		dev_err(dev, "Intel(R) I/OAT DMA Engine init failed\n");
 		return -ENODEV;

-- 
2.43.2



