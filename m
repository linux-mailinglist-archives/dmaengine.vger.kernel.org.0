Return-Path: <dmaengine+bounces-5208-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F278FABC955
	for <lists+dmaengine@lfdr.de>; Mon, 19 May 2025 23:26:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6DDF63A76AA
	for <lists+dmaengine@lfdr.de>; Mon, 19 May 2025 21:26:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC9972253F2;
	Mon, 19 May 2025 21:22:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gHm5RyHk"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7673B2253A7;
	Mon, 19 May 2025 21:22:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747689730; cv=none; b=SdKaE0wsR4qgkczvzXdrYDRf0Ge/bPxHhKvog0UCs2ndkqO59P2p5+DuUSZ9SumRsXD8yXj6bkwRp1Nc607tarF58XgFvNkFUMPo5CcUJQGJ9IH28ZMLFoB+pq8Cy+JKCbttnw/76avcRxH25fvGH/hUIQzEneHDMyoXtKzU5WA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747689730; c=relaxed/simple;
	bh=5AFh+nC4dlusvO93sPL2HnB9klaOUVlLhZVVa7bQPJ8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=s47VmJQ8GT8+KwF8NSRojVs4bC5Me18Be0f8jVgvcHzio1QEYIyiJIfyhpQ9Top7dMB9LQuqsHgwJLjmP1/4+7VIXFNzo8hY5PKg94MzwJCZT1eXs/5TuzgQenuFEjLCeSwHcSAqujfmKBjlszzDpPqrcOGjfeIb3DJIlOVIHeU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gHm5RyHk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 555FAC4CEE4;
	Mon, 19 May 2025 21:22:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747689730;
	bh=5AFh+nC4dlusvO93sPL2HnB9klaOUVlLhZVVa7bQPJ8=;
	h=From:To:Cc:Subject:Date:From;
	b=gHm5RyHkZLSoDO3k5nP1B7BXt8cSppPWcINl64Wf0rzrFAUE5IHTqPsjbiXq7RCQW
	 YqyszuF/T1GME+r7WskP3RI0kN4+5U0fe/p8OL4TrSBKsGkEcbpyWXDZJzQWfaTTDN
	 mYfxS6AQmnTjYXGAotw49hKfYL5voOqbDdyt6659sDNN29jS/7/qsQ4nwM9IloZTtc
	 dMRsaj4oAhKZe61eRugbLrXdO3NjFJOabPBkovrhuZ+ErR7BXFNxuMID+Tq+VyDeZu
	 4/s/SvDptUiKXAMSjsnadNFOFmWF9UGoxq+RLps8lpz7QHdxMkPGbop2L+e4IXPiyx
	 b5cuXUk/P8jPg==
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
Subject: [PATCH AUTOSEL 6.12 01/18] dmaengine: idxd: cdev: Fix uninitialized use of sva in idxd_cdev_open
Date: Mon, 19 May 2025 17:21:50 -0400
Message-Id: <20250519212208.1986028-1-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.12.29
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
index 57f1bf2ab20be..48210760bdf87 100644
--- a/drivers/dma/idxd/cdev.c
+++ b/drivers/dma/idxd/cdev.c
@@ -225,7 +225,7 @@ static int idxd_cdev_open(struct inode *inode, struct file *filp)
 	struct idxd_wq *wq;
 	struct device *dev, *fdev;
 	int rc = 0;
-	struct iommu_sva *sva;
+	struct iommu_sva *sva = NULL;
 	unsigned int pasid;
 	struct idxd_cdev *idxd_cdev;
 
@@ -322,7 +322,7 @@ static int idxd_cdev_open(struct inode *inode, struct file *filp)
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


