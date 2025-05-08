Return-Path: <dmaengine+bounces-5116-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EC71AB0106
	for <lists+dmaengine@lfdr.de>; Thu,  8 May 2025 19:06:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D803B1C042AB
	for <lists+dmaengine@lfdr.de>; Thu,  8 May 2025 17:06:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3ACFA2857DB;
	Thu,  8 May 2025 17:05:58 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 238602853EE
	for <dmaengine@vger.kernel.org>; Thu,  8 May 2025 17:05:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746723958; cv=none; b=XuVaUFlwyPwb7lUR61//obVeCT0y+UBvbye7bYSZYfmf231gESBRLqsqEzPdnrodrCmFFMsu+TmoQa6R7jjW7Nu7jwagH0GAehPOXMp+bJm4yLTskDxXuNPrsU7z9FdFBSmqudhZejVsx+Y3EUtL/RY7UQw8g8XhpkYHpzLolqc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746723958; c=relaxed/simple;
	bh=mGcTGG94r+Kx46AgD7+YwRHB0gx5gpXP/g40ZOrgQyk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=N1Qcbo0/olbACsOCNhz8fm46eApYDVJC4dWkYIYbDPuz00oNzV2YRRn9q9zBJ9nruBxxwx5DMgdLN5METGv2HvfKIzEm/Tgqctlt4TYnmv2s+gZwecF02vWB67eiFcM+ucutI00rAAGYsy/NPdz3uoq0vLkNa7NN9fMGJXhSgDs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 75C13C4CEE7;
	Thu,  8 May 2025 17:05:57 +0000 (UTC)
From: Dave Jiang <dave.jiang@intel.com>
To: vkoul@kernel.org,
	dmaengine@vger.kernel.org
Cc: vinicius.gomes@intel.com,
	kernel test robot <lkp@intel.com>
Subject: [PATCH] dmaengine: idxd: Fix ->poll() return value
Date: Thu,  8 May 2025 10:05:48 -0700
Message-ID: <20250508170548.2747425-1-dave.jiang@intel.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The fix to block access from different address space did not return a
correct value for ->poll() change.  kernel test bot reported that a
return value of type __poll_t is expected rather than int. Fix to return
POLLNVAL to indicate invalid request.

Fixes: 8dfa57aabff6 ("dmaengine: idxd: Fix allowing write() from different address spaces")
Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202505081851.rwD7jVxg-lkp@intel.com/
Signed-off-by: Dave Jiang <dave.jiang@intel.com>
---

Hi Vinod, this fixes a patch that's queued in dmaengine/fixes.

 drivers/dma/idxd/cdev.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/dma/idxd/cdev.c b/drivers/dma/idxd/cdev.c
index a2fb2b847752..6d12033649f8 100644
--- a/drivers/dma/idxd/cdev.c
+++ b/drivers/dma/idxd/cdev.c
@@ -500,7 +500,7 @@ static __poll_t idxd_cdev_poll(struct file *filp,
 	__poll_t out = 0;
 
 	if (current->mm != ctx->mm)
-		return -EPERM;
+		return POLLNVAL;
 
 	poll_wait(filp, &wq->err_queue, wait);
 	spin_lock(&idxd->dev_lock);

base-commit: 305245a2e1d633e5f821178c98c6d6132cea2bdb
-- 
2.49.0


