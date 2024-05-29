Return-Path: <dmaengine+bounces-2202-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B4B118D32CA
	for <lists+dmaengine@lfdr.de>; Wed, 29 May 2024 11:18:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 41A82B25308
	for <lists+dmaengine@lfdr.de>; Wed, 29 May 2024 09:18:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A938C161906;
	Wed, 29 May 2024 09:18:43 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from njjs-sys-mailin01.njjs.baidu.com (mx311.baidu.com [180.101.52.76])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46BFD169AE4
	for <dmaengine@vger.kernel.org>; Wed, 29 May 2024 09:18:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=180.101.52.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716974323; cv=none; b=NSFiw+YvEa0tlSuvAw9imQjC9XKxOjxE14hgBMlDdpJ4COF52uTf1rf25Suq78K8KC6+lSvQwar6Fd8LbRqbMAS1F5iAoP3+5cCsGQ4cm7zenwOxqLYN2f/ZNvlBPCv2kROTCIE3HZK3/nXWTzjAtfH5mOB8l3VOWEYLS6N+A68=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716974323; c=relaxed/simple;
	bh=p7wj+opMtZQImIQOqWe9gZRI/icVerMXEae9yJBIOvQ=;
	h=From:To:Cc:Subject:Date:Message-Id; b=jfOXc+OBBQqca6eoY28dfWap+Pf9jrLWo2AWkf3VQP3d+W6NEB9jTI3t1w4ZDsQB7MCCPgFK0AAVIhuJ64K5C+FVYSwUALMLOvyMRgfmrcKgKxkoZxbcFQN1qQWP8S6kYUtFcH5kYFJ1xB8BTJj+5h7lnd5Rt5ycJ+x1f6vAx9M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=baidu.com; spf=pass smtp.mailfrom=baidu.com; arc=none smtp.client-ip=180.101.52.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=baidu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baidu.com
Received: from localhost (bjhw-sys-rpm015653cc5.bjhw.baidu.com [10.227.53.39])
	by njjs-sys-mailin01.njjs.baidu.com (Postfix) with ESMTP id 5DA867F0004B;
	Wed, 29 May 2024 17:18:30 +0800 (CST)
From: Li RongQing <lirongqing@baidu.com>
To: fenghua.yu@intel.com,
	dave.jiang@intel.com,
	vkoul@kernel.org,
	dmaengine@vger.kernel.org
Cc: Li RongQing <lirongqing@baidu.com>
Subject: [PATCH][v2] dmaengine: idxd: Fix possible Use-After-Free in irq_process_work_list
Date: Wed, 29 May 2024 17:18:28 +0800
Message-Id: <20240529091828.40774-1-lirongqing@baidu.com>
X-Mailer: git-send-email 2.9.4
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>

list_for_each_entry_safe() should be used when the descriptor will be
freed in idxd_desc_complete(), Otherwise the freed descriptor will be
dereferenced to get its next, and always deletes freed descriptor from
list firstly

Fixes: 16e19e11228b ("dmaengine: idxd: Fix list corruption in description completion")
Signed-off-by: Li RongQing <lirongqing@baidu.com>
---
 drivers/dma/idxd/irq.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/dma/idxd/irq.c b/drivers/dma/idxd/irq.c
index 8dc029c..5571de1 100644
--- a/drivers/dma/idxd/irq.c
+++ b/drivers/dma/idxd/irq.c
@@ -573,6 +573,8 @@ static void irq_process_pending_llist(struct idxd_irq_entry *irq_entry)
 			 * Check against the original status as ABORT is software defined
 			 * and 0xff, which DSA_COMP_STATUS_MASK can mask out.
 			 */
+			list_del(&desc->list);
+
 			if (unlikely(desc->completion->status == IDXD_COMP_DESC_ABORT)) {
 				idxd_desc_complete(desc, IDXD_COMPLETE_ABORT, true);
 				continue;
@@ -611,11 +613,13 @@ static void irq_process_work_list(struct idxd_irq_entry *irq_entry)
 
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


