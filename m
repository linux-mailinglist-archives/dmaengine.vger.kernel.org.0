Return-Path: <dmaengine+bounces-2242-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FBA68D79CD
	for <lists+dmaengine@lfdr.de>; Mon,  3 Jun 2024 03:31:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 808F41C2106D
	for <lists+dmaengine@lfdr.de>; Mon,  3 Jun 2024 01:31:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40E0715D1;
	Mon,  3 Jun 2024 01:31:06 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from njjs-sys-mailin01.njjs.baidu.com (mx311.baidu.com [180.101.52.76])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A4164A05
	for <dmaengine@vger.kernel.org>; Mon,  3 Jun 2024 01:31:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=180.101.52.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717378266; cv=none; b=BBbyQfaNqBW367wfKdWArSQsTWwwz8dXjgsQ8jsfUCK3b8oZgD5okWYpQ+xlVuyVrhAn81mB74hsWfq1a/TnOn3iLWslQzy27mRDLL5XMKmPkL0Rf/wUfiP8wlM52K0G0v+iSKFDf6bLX68PyW6r1DWApmpm1osRz9bdUVk+K1w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717378266; c=relaxed/simple;
	bh=TDNbGF/jPSZgl+H0UnFXX2z4sI7vudlcSTywgZEYoZQ=;
	h=From:To:Cc:Subject:Date:Message-Id; b=tVxcTrfitEGtjYZFgu1LQ++dY3MRyZ1yfrBZQgAB4xtYHou0mfjL/89Lk3/dei3UhNMtO4lRE7Cyj9wXZv2PT6SJIzCXvQcDLJ+owlOtR9thNnybYfGNOat2A+92MCxd38/WXkW8ZxiLVtJaFOOQtYg1SAWS//7bKvs9+hmNx3k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=baidu.com; spf=pass smtp.mailfrom=baidu.com; arc=none smtp.client-ip=180.101.52.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=baidu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baidu.com
Received: from localhost (bjhw-sys-rpm015653cc5.bjhw.baidu.com [10.227.53.39])
	by njjs-sys-mailin01.njjs.baidu.com (Postfix) with ESMTP id 104647F0003D;
	Mon,  3 Jun 2024 09:24:46 +0800 (CST)
From: Li RongQing <lirongqing@baidu.com>
To: fenghua.yu@intel.com,
	dave.jiang@intel.com,
	vkoul@kernel.org,
	dmaengine@vger.kernel.org
Cc: Li RongQing <lirongqing@baidu.com>
Subject: [PATCH][v4] dmaengine: idxd: Fix possible Use-After-Free in irq_process_work_list
Date: Mon,  3 Jun 2024 09:24:44 +0800
Message-Id: <20240603012444.11902-1-lirongqing@baidu.com>
X-Mailer: git-send-email 2.9.4
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>

Use list_for_each_entry_safe() to allow iterating through the list and
deleting the entry in the iteration process. The descriptor is freed via
idxd_desc_complete() and there's a slight chance may cause issue for
the list iterator when the descriptor is reused by another thread
without it being deleted from the list.

Fixes: 16e19e11228b ("dmaengine: idxd: Fix list corruption in description completion")
Signed-off-by: Li RongQing <lirongqing@baidu.com>
Reviewed-by: Dave Jiang <dave.jiang@intel.com>
---
 drivers/dma/idxd/irq.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/dma/idxd/irq.c b/drivers/dma/idxd/irq.c
index 8dc029c..fc049c9 100644
--- a/drivers/dma/idxd/irq.c
+++ b/drivers/dma/idxd/irq.c
@@ -611,11 +611,13 @@ static void irq_process_work_list(struct idxd_irq_entry *irq_entry)
 
 	spin_unlock(&irq_entry->list_lock);
 
-	list_for_each_entry(desc, &flist, list) {
+	list_for_each_entry_safe(desc, n, &flist, list) {
 		/*
 		 * Check against the original status as ABORT is software defined
 		 * and 0xff, which DSA_COMP_STATUS_MASK can mask out.
 		 */
+		list_del(&desc->list);
+
 		if (unlikely(desc->completion->status == IDXD_COMP_DESC_ABORT)) {
 			idxd_desc_complete(desc, IDXD_COMPLETE_ABORT, true);
 			continue;
-- 
2.9.4


