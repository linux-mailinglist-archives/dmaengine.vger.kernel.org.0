Return-Path: <dmaengine+bounces-2209-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B04588D450C
	for <lists+dmaengine@lfdr.de>; Thu, 30 May 2024 07:56:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 635591F22934
	for <lists+dmaengine@lfdr.de>; Thu, 30 May 2024 05:56:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AB532D792;
	Thu, 30 May 2024 05:56:01 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from njjs-sys-mailin01.njjs.baidu.com (mx316.baidu.com [180.101.52.236])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F28A8142E85
	for <dmaengine@vger.kernel.org>; Thu, 30 May 2024 05:55:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=180.101.52.236
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717048561; cv=none; b=SVBpqhqRUkkBFP2ukzahxXYr64sHvRcwE+NRnNzIDqKtFlOlN7/4WTXDCNNo0NAKIkkOmwwtZBPiKJndL37t4e+kCTeu0PGk18NhUvkNiF84kQHDnG6UL3+mfA8NwXYSwFPzFya80OETAxm7Xub/+ue2aHrctKHAclT73RZn9oI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717048561; c=relaxed/simple;
	bh=ezeyo9pUYHTBrMKNO8PvhilotStPFNH0H4/+9wVt/50=;
	h=From:To:Cc:Subject:Date:Message-Id; b=mU4QozZ+eozavW9dcgzeLN9OgMN4Uck8DhaiKIp1wLVgzzL4sM0vwvDy1qd+YfKaqDzvMQpV6xZtkauuboR/gxhtcJEsc6GgBi1Jnp4gwthbwlx0XMrDP5Tz7ghPCZIBe+ZDgqvEWnGqnQ9g75JkaqtcQ35ngGCbHcOhwihw+gs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=baidu.com; spf=pass smtp.mailfrom=baidu.com; arc=none smtp.client-ip=180.101.52.236
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=baidu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baidu.com
Received: from localhost (bjhw-sys-rpm015653cc5.bjhw.baidu.com [10.227.53.39])
	by njjs-sys-mailin01.njjs.baidu.com (Postfix) with ESMTP id 736387F0005C;
	Thu, 30 May 2024 13:48:54 +0800 (CST)
From: Li RongQing <lirongqing@baidu.com>
To: fenghua.yu@intel.com,
	dave.jiang@intel.com,
	vkoul@kernel.org,
	dmaengine@vger.kernel.org
Cc: Li RongQing <lirongqing@baidu.com>
Subject: [PATCH][v3] dmaengine: idxd: Fix possible Use-After-Free in irq_process_work_list
Date: Thu, 30 May 2024 13:48:52 +0800
Message-Id: <20240530054852.8858-1-lirongqing@baidu.com>
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


