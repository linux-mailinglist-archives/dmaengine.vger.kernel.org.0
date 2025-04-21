Return-Path: <dmaengine+bounces-4927-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BB48A954FF
	for <lists+dmaengine@lfdr.de>; Mon, 21 Apr 2025 19:04:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D6C757A4EA4
	for <lists+dmaengine@lfdr.de>; Mon, 21 Apr 2025 17:03:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9746E19DFA2;
	Mon, 21 Apr 2025 17:04:17 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7ECEF19CD1D
	for <dmaengine@vger.kernel.org>; Mon, 21 Apr 2025 17:04:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745255057; cv=none; b=jK5BiNcdfubZO2i/p7r2kYX20qihg7YuvpYNPJ0cCJsNKaN1q66DQb8VtKRgQoIUY0WquC7WoHzufRL1nGXyEbKukyW+pcY+UI1aJueX+cw9Np8xA2oAJIX2c9vMuksJEnopGyNkAn7RM5EzJHXyTXZb+rktKduH0sX8vH60Vec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745255057; c=relaxed/simple;
	bh=uWX7tlDGHRK1xqfA6Y+LSa2WYj/nxCvAR2GpCYiB+/k=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=AyuRM+blP+QDMS9+Mmyle/iyqh3xfj+eCfEiZ980oZyauaqGkvqTLEjYXlRkhi82rsSVxZbkcfh9GKTdvUra6vJClOG3GyX6aR4+bot5RDULbgCe6XWp5In5SAtmXsAIC7nC5mT0trV8i8iOPpNLIxSHJRChwsS0o6Ymb9hMnS0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CACADC4CEE4;
	Mon, 21 Apr 2025 17:04:16 +0000 (UTC)
From: Dave Jiang <dave.jiang@intel.com>
To: dmaengine@vger.kernel.org
Cc: vinicius.gomes@intel.com,
	vkoul@kernel.org,
	arjan@linux.intel.com,
	nathan.lynch@amd.com
Subject: [PATCH v2] dmaengine: idxd: Fix allowing write() from different address spaces
Date: Mon, 21 Apr 2025 10:03:37 -0700
Message-ID: <20250421170337.3008875-1-dave.jiang@intel.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Vinicius Costa Gomes <vinicius.gomes@intel.com>

Check if the process submitting the descriptor belongs to the same
address space as the one that opened the file, reject otherwise.

Fixes: 6827738dc684 ("dmaengine: idxd: add a write() method for applications to submit work")
Signed-off-by: Vinicius Costa Gomes <vinicius.gomes@intel.com>
Signed-off-by: Dave Jiang <dave.jiang@intel.com>
---
v2:
- Add check also for mmap() and poll(). (Nathan)
---
 drivers/dma/idxd/cdev.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/dma/idxd/cdev.c b/drivers/dma/idxd/cdev.c
index ff94ee892339..b847b74949f1 100644
--- a/drivers/dma/idxd/cdev.c
+++ b/drivers/dma/idxd/cdev.c
@@ -407,6 +407,9 @@ static int idxd_cdev_mmap(struct file *filp, struct vm_area_struct *vma)
 	if (!idxd->user_submission_safe && !capable(CAP_SYS_RAWIO))
 		return -EPERM;
 
+	if (current->mm != ctx->mm)
+		return -EPERM;
+
 	rc = check_vma(wq, vma, __func__);
 	if (rc < 0)
 		return rc;
@@ -473,6 +476,9 @@ static ssize_t idxd_cdev_write(struct file *filp, const char __user *buf, size_t
 	ssize_t written = 0;
 	int i;
 
+	if (current->mm != ctx->mm)
+		return -EPERM;
+
 	for (i = 0; i < len/sizeof(struct dsa_hw_desc); i++) {
 		int rc = idxd_submit_user_descriptor(ctx, udesc + i);
 
@@ -493,6 +499,9 @@ static __poll_t idxd_cdev_poll(struct file *filp,
 	struct idxd_device *idxd = wq->idxd;
 	__poll_t out = 0;
 
+	if (current->mm != ctx->mm)
+		return -EPERM;
+
 	poll_wait(filp, &wq->err_queue, wait);
 	spin_lock(&idxd->dev_lock);
 	if (idxd->sw_err.valid)
-- 
2.49.0


