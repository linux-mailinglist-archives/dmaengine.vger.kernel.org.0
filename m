Return-Path: <dmaengine+bounces-2149-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A88AB8CE41E
	for <lists+dmaengine@lfdr.de>; Fri, 24 May 2024 12:24:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 730F31C21AA2
	for <lists+dmaengine@lfdr.de>; Fri, 24 May 2024 10:24:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94A0C85268;
	Fri, 24 May 2024 10:24:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TE1XoAkJ"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69A5353E31;
	Fri, 24 May 2024 10:24:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716546288; cv=none; b=kyt+wKAe8Vqd9zOpRNCNEGJ6GBCOjWWW1xCNau2TnR5SLUvm0Ro0EIuAQ5W064QKI6eVbiWlUn7Xs1d7dUZQqzI8estibGvmoHVHZ0nm3YTkxsX7vtQB/Gi8zklixRa6GoO3XeSuWycyv/mgrz4tZrXrf0lT7BhskzgVw86x4WA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716546288; c=relaxed/simple;
	bh=nKrlwxVQZ9JWwpGEnhgFrcVm0BXTkJ1KgeGuEWOqKj8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=MvWif52xNhz189Q6JFzVqKwg4ZI3J/eHFKiDc7iWh0CaXCPCtoQlCiFyz+sElMuB5DjvGMc+K3B2Ntd364yTECc7rBnDfqTMrZAg2fOyYszNuL8RSej7yfVGwGCBJ2FdAdv0C2aVsAHaHI3pHBs2NOpEImbnSTaNPGOM1qlgXp4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TE1XoAkJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 3D688C3277B;
	Fri, 24 May 2024 10:24:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716546288;
	bh=nKrlwxVQZ9JWwpGEnhgFrcVm0BXTkJ1KgeGuEWOqKj8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=TE1XoAkJF3UIdueK/th6PTUq4JV6jvPJwopZ03Vmg96fqwJ0+ReUErbbR3Pr7+SAh
	 SZqX3mbF3PxPwXQkKjf8YPx8AF+tZGT6LAo1sYYlDJ7TII0cS26MWjPyDPNRRkwUUq
	 TdV/JJhD9kZznFw855k5413k67eHJHjEoEi9Rg7jJ6Qfho4R6UrnYHT74lhjdIWP7q
	 N/w5wZ9B8zTVCC5+SmUEMybTOo+Qo3womMIDskFoAAND5gQ7gcMcKgJoynX5XoYY9R
	 REeAmRzUijQDjRJMVycSLZJeqhq/97YLhMU5K8ooR+KjYP7916jRifU8FSBXhY1o0+
	 6zzoxWirh8pjg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BDF6C25B7C;
	Fri, 24 May 2024 10:24:48 +0000 (UTC)
From: Nikita Shubin via B4 Relay <devnull+n.shubin.yadro.com@kernel.org>
Date: Fri, 24 May 2024 13:24:46 +0300
Subject: [PATCH 1/3] dmaengine: ioatdma: Fix leaking on version mismatch
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240524-ioatdma-fixes-v1-1-b785f1f7accc@yadro.com>
References: <20240524-ioatdma-fixes-v1-0-b785f1f7accc@yadro.com>
In-Reply-To: <20240524-ioatdma-fixes-v1-0-b785f1f7accc@yadro.com>
To: Vinod Koul <vkoul@kernel.org>, Dave Jiang <dave.jiang@intel.com>, 
 Logan Gunthorpe <logang@deltatee.com>
Cc: dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Nikita Shubin <n.shubin@yadro.com>, 
 Andy Shevchenko <andy.shevchenko@gmail.com>
X-Mailer: b4 0.12.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1716546287; l=1829;
 i=n.shubin@yadro.com; s=20230718; h=from:subject:message-id;
 bh=ASVt6+nzAUVivKjUfhTrAzVsAPEzKEYVziXwIRDAuFU=;
 b=XdFjbO1C+F4RPvuUhl70SgRp5TAmjOw0er3PeydKwZ6a0TMrJ8hxcVT1EdTQ2Uay47pohcjT7bbf
 HH7eDqy+COYafUho+mNi7U9FxeznZlsBC8bgnV83ptzoYEG5Gpou
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



