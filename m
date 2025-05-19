Return-Path: <dmaengine+bounces-5207-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 15F2DABC901
	for <lists+dmaengine@lfdr.de>; Mon, 19 May 2025 23:21:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B91F44A1B83
	for <lists+dmaengine@lfdr.de>; Mon, 19 May 2025 21:21:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C39E2163BD;
	Mon, 19 May 2025 21:21:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Cx4QMIwj"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 449772147E3;
	Mon, 19 May 2025 21:21:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747689695; cv=none; b=q47Bs4KwPuDgx9mVMWAgHkt8CTzl6VkQf8Qjq+fwVjPZ9vCVJ8P4A03YuolfoF5u6npfkm+moitjpg6a57Aw7Wq6pg35EWHfScRFLB4tVF7rXLO49/5dfggBz3niQxn2qI7CVbYCq2az0w74lk0qJ3RGbc3hXHcznonAEO+XYn8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747689695; c=relaxed/simple;
	bh=bDtecZjKTbaLHO+lu0f0b899YCLPuy/seha4FHlWQdk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=nEoxOQP0y5E2WoBhXTAcjiAQPk+6VxsnVg8zox/SRfEWokTB1qN2mjz+YA5wx7lORvXWsoKGzKvTWILuaGwhS1MCg6I7WoWgU7lFCjEMj3Mba9P8tBHIV85xk1NZffVPDLqAxdkivIjGjyKU7n8kV5VtXlCOdAeSnFT3DvkiTVg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Cx4QMIwj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A82F7C4CEE9;
	Mon, 19 May 2025 21:21:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747689693;
	bh=bDtecZjKTbaLHO+lu0f0b899YCLPuy/seha4FHlWQdk=;
	h=From:To:Cc:Subject:Date:From;
	b=Cx4QMIwjrDo0MesJYT7yYMiSKsds9vvLKzlw71BgjmOoMlEzqtMzi8FtMmVlRa/xI
	 oJ1FajLFDz5m0qDWxmvS6lZeni8C/iLkuiR8iDjh0VxphPBDTqwwgivoWSGIglaDMv
	 n5a6uSs0ttgTGavcUUVII4WMS4UemY/CUb40FyPw/AtmopRwXsG+BvnUIihj3UnxrZ
	 r42gpYnijkb8ebBs0+zDogZxGFJetn0QLD0ZXsVObjRGYRBpQtR0mI6ZiwrHmzB2K/
	 TjUuaN0mmyPYkDvze5uCIFM7pYShxQ/o07b51wPW/rWTHEJCD6zN9PqxKBze0p82g+
	 Z+D3yUQwaBSVw==
From: Sasha Levin <sashal@kernel.org>
To: patches@lists.linux.dev,
	stable@vger.kernel.org
Cc: Purva Yeshi <purvayeshi550@gmail.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Vinicius Costa Gomes <vinicius.gomes@intel.com>,
	Vinod Koul <vkoul@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	dmaengine@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH AUTOSEL 6.14 01/23] dmaengine: idxd: cdev: Fix uninitialized use of sva in idxd_cdev_open
Date: Mon, 19 May 2025 17:21:08 -0400
Message-Id: <20250519212131.1985647-1-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.14.7
Content-Transfer-Encoding: 8bit

From: Purva Yeshi <purvayeshi550@gmail.com>

[ Upstream commit 97994333de2b8062d2df4e6ce0dc65c2dc0f40dc ]

Fix Smatch-detected issue:
drivers/dma/idxd/cdev.c:321 idxd_cdev_open() error:
uninitialized symbol 'sva'.

'sva' pointer may be used uninitialized in error handling paths.
Specifically, if PASID support is enabled and iommu_sva_bind_device()
returns an error, the code jumps to the cleanup label and attempts to
call iommu_sva_unbind_device(sva) without ensuring that sva was
successfully assigned. This triggers a Smatch warning about an
uninitialized symbol.

Initialize sva to NULL at declaration and add a check using
IS_ERR_OR_NULL() before unbinding the device. This ensures the
function does not use an invalid or uninitialized pointer during
cleanup.

Signed-off-by: Purva Yeshi <purvayeshi550@gmail.com>
Reviewed-by: Dave Jiang <dave.jiang@intel.com>
Acked-by: Vinicius Costa Gomes <vinicius.gomes@intel.com>
Link: https://lore.kernel.org/r/20250410110216.21592-1-purvayeshi550@gmail.com
Signed-off-by: Vinod Koul <vkoul@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/dma/idxd/cdev.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/dma/idxd/cdev.c b/drivers/dma/idxd/cdev.c
index ff94ee892339d..7bd031a608943 100644
--- a/drivers/dma/idxd/cdev.c
+++ b/drivers/dma/idxd/cdev.c
@@ -222,7 +222,7 @@ static int idxd_cdev_open(struct inode *inode, struct file *filp)
 	struct idxd_wq *wq;
 	struct device *dev, *fdev;
 	int rc = 0;
-	struct iommu_sva *sva;
+	struct iommu_sva *sva = NULL;
 	unsigned int pasid;
 	struct idxd_cdev *idxd_cdev;
 
@@ -317,7 +317,7 @@ static int idxd_cdev_open(struct inode *inode, struct file *filp)
 	if (device_user_pasid_enabled(idxd))
 		idxd_xa_pasid_remove(ctx);
 failed_get_pasid:
-	if (device_user_pasid_enabled(idxd))
+	if (device_user_pasid_enabled(idxd) && !IS_ERR_OR_NULL(sva))
 		iommu_sva_unbind_device(sva);
 failed:
 	mutex_unlock(&wq->wq_lock);
-- 
2.39.5


