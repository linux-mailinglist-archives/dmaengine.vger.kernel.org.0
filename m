Return-Path: <dmaengine+bounces-990-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6325B84FCAC
	for <lists+dmaengine@lfdr.de>; Fri,  9 Feb 2024 20:14:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 18AAA1F23996
	for <lists+dmaengine@lfdr.de>; Fri,  9 Feb 2024 19:14:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8743780C17;
	Fri,  9 Feb 2024 19:14:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ht1FmSxF"
X-Original-To: dmaengine@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C48F92E3F7;
	Fri,  9 Feb 2024 19:14:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=134.134.136.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707506085; cv=none; b=ICBOwSQXG6BAavB8MKGBJ4pPhU3rYdgebBZ/sMC6yZVkXpC/esExymuLiXmDKSNU3Di8v5RMFJoOvLu4lBefrvtDqsiPrGuFHl7/MevjZzglfZJRWohra5jZtLvrTgRr46WCoksioVJJ1iPfi8JXv1oSZD9uNhcmWTXO+y/T+M0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707506085; c=relaxed/simple;
	bh=cuWVx9+N3vCjYtc3CF8Dq5cb491rUnag1dMdVqSrZio=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Zid3L/O/PhdZi+8tyk5C9d19q+Pw8Ez7Zd9zN9n59Td+TQfKQEBMFjbPRRWwuaxeV7TBU8lXW3pBo5IfU882iF8zZOzlHkVKF1psm60CKW9l9/v6taIVixNZhb2PYdqd7AunWGrNaB1578UBn9EQe1eDlt/EEcWy0u3ZJcHaHdo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ht1FmSxF; arc=none smtp.client-ip=134.134.136.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707506083; x=1739042083;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=cuWVx9+N3vCjYtc3CF8Dq5cb491rUnag1dMdVqSrZio=;
  b=ht1FmSxFG1Mxtn1J/kRCCes+VW96hpnBtv4CH1SIlEgmQn8EMr5g+77V
   I57fv10o1Mk64kXcMHc8S+ODQOIpkfWXTe/exRKoa2/Ui/hSNnHCCZWHa
   7334130I4SAvoL/sU0IzjY4NHeh1TOA9gNjvzg0WOKunatUl2VM6+aWb4
   TgxijRKDAmeehhjMEKuiGS6/J3hq8hLOby1vvDG1u0wzuRu++jDMxtjyz
   tfQ5bBeXNSBNKD3tleGGEK9FHdZ1LXHXbC2QOhl1bj+LkusAWwNnzlcD9
   71qfOJLR1qJruQq1l3t2xu2fuJBFryZQ0cmCsG5QsdUb+NM5wVVvM+fTA
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10979"; a="395914183"
X-IronPort-AV: E=Sophos;i="6.05,257,1701158400"; 
   d="scan'208";a="395914183"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Feb 2024 11:14:42 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,257,1701158400"; 
   d="scan'208";a="6658211"
Received: from fyu1.sc.intel.com ([172.25.103.126])
  by orviesa003.jf.intel.com with ESMTP; 09 Feb 2024 11:14:42 -0800
From: Fenghua Yu <fenghua.yu@intel.com>
To: "Vinod Koul" <vkoul@kernel.org>,
	"Dave Jiang" <dave.jiang@intel.com>
Cc: dmaengine@vger.kernel.org,
	"linux-kernel" <linux-kernel@vger.kernel.org>,
	Fenghua Yu <fenghua.yu@intel.com>,
	Tony Zhu <tony.zhu@intel.com>
Subject: [PATCH] dmaengine: idxd: Ensure safe user copy of completion record
Date: Fri,  9 Feb 2024 11:14:12 -0800
Message-Id: <20240209191412.1050270-1-fenghua.yu@intel.com>
X-Mailer: git-send-email 2.37.1
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

If CONFIG_HARDENED_USERCOPY is enabled, copying completion record from
event log cache to user triggers a kernel bug.

[ 1987.159822] usercopy: Kernel memory exposure attempt detected from SLUB object 'dsa0' (offset 74, size 31)!
[ 1987.170845] ------------[ cut here ]------------
[ 1987.176086] kernel BUG at mm/usercopy.c:102!
[ 1987.180946] invalid opcode: 0000 [#1] PREEMPT SMP NOPTI
[ 1987.186866] CPU: 17 PID: 528 Comm: kworker/17:1 Not tainted 6.8.0-rc2+ #5
[ 1987.194537] Hardware name: Intel Corporation AvenueCity/AvenueCity, BIOS BHSDCRB1.86B.2492.D03.2307181620 07/18/2023
[ 1987.206405] Workqueue: wq0.0 idxd_evl_fault_work [idxd]
[ 1987.212338] RIP: 0010:usercopy_abort+0x72/0x90
[ 1987.217381] Code: 58 65 9c 50 48 c7 c2 17 85 61 9c 57 48 c7 c7 98 fd 6b 9c 48 0f 44 d6 48 c7 c6 b3 08 62 9c 4c 89 d1 49 0f 44 f3 e8 1e 2e d5 ff <0f> 0b 49 c7 c1 9e 42 61 9c 4c 89 cf 4d 89 c8 eb a9 66 66 2e 0f 1f
[ 1987.238505] RSP: 0018:ff62f5cf20607d60 EFLAGS: 00010246
[ 1987.244423] RAX: 000000000000005f RBX: 000000000000001f RCX: 0000000000000000
[ 1987.252480] RDX: 0000000000000000 RSI: ffffffff9c61429e RDI: 00000000ffffffff
[ 1987.260538] RBP: ff62f5cf20607d78 R08: ff2a6a89ef3fffe8 R09: 00000000fffeffff
[ 1987.268595] R10: ff2a6a89eed00000 R11: 0000000000000003 R12: ff2a66934849c89a
[ 1987.276652] R13: 0000000000000001 R14: ff2a66934849c8b9 R15: ff2a66934849c899
[ 1987.284710] FS:  0000000000000000(0000) GS:ff2a66b22fe40000(0000) knlGS:0000000000000000
[ 1987.293850] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[ 1987.300355] CR2: 00007fe291a37000 CR3: 000000010fbd4005 CR4: 0000000000f71ef0
[ 1987.308413] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[ 1987.316470] DR3: 0000000000000000 DR6: 00000000fffe07f0 DR7: 0000000000000400
[ 1987.324527] PKRU: 55555554
[ 1987.327622] Call Trace:
[ 1987.330424]  <TASK>
[ 1987.332826]  ? show_regs+0x6e/0x80
[ 1987.336703]  ? die+0x3c/0xa0
[ 1987.339988]  ? do_trap+0xd4/0xf0
[ 1987.343662]  ? do_error_trap+0x75/0xa0
[ 1987.347922]  ? usercopy_abort+0x72/0x90
[ 1987.352277]  ? exc_invalid_op+0x57/0x80
[ 1987.356634]  ? usercopy_abort+0x72/0x90
[ 1987.360988]  ? asm_exc_invalid_op+0x1f/0x30
[ 1987.365734]  ? usercopy_abort+0x72/0x90
[ 1987.370088]  __check_heap_object+0xb7/0xd0
[ 1987.374739]  __check_object_size+0x175/0x2d0
[ 1987.379588]  idxd_copy_cr+0xa9/0x130 [idxd]
[ 1987.384341]  idxd_evl_fault_work+0x127/0x390 [idxd]
[ 1987.389878]  process_one_work+0x13e/0x300
[ 1987.394435]  ? __pfx_worker_thread+0x10/0x10
[ 1987.399284]  worker_thread+0x2f7/0x420
[ 1987.403544]  ? _raw_spin_unlock_irqrestore+0x2b/0x50
[ 1987.409171]  ? __pfx_worker_thread+0x10/0x10
[ 1987.414019]  kthread+0x107/0x140
[ 1987.417693]  ? __pfx_kthread+0x10/0x10
[ 1987.421954]  ret_from_fork+0x3d/0x60
[ 1987.426019]  ? __pfx_kthread+0x10/0x10
[ 1987.430281]  ret_from_fork_asm+0x1b/0x30
[ 1987.434744]  </TASK>

The issue arises because event log cache is created using
kmem_cache_create() which is not suitable for user copy.

Fix the issue by creating event log cache with
kmem_cache_create_usercopy(), ensuring safe user copy.

Fixes: c2f156bf168f ("dmaengine: idxd: create kmem cache for event log fault items")
Reported-by: Tony Zhu <tony.zhu@intel.com>
Tested-by: Tony Zhu <tony.zhu@intel.com>
Signed-off-by: Fenghua Yu <fenghua.yu@intel.com>
---
 drivers/dma/idxd/init.c | 15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

diff --git a/drivers/dma/idxd/init.c b/drivers/dma/idxd/init.c
index 14df1f1347a8..4954adc6bb60 100644
--- a/drivers/dma/idxd/init.c
+++ b/drivers/dma/idxd/init.c
@@ -343,7 +343,9 @@ static void idxd_cleanup_internals(struct idxd_device *idxd)
 static int idxd_init_evl(struct idxd_device *idxd)
 {
 	struct device *dev = &idxd->pdev->dev;
+	unsigned int evl_cache_size;
 	struct idxd_evl *evl;
+	const char *idxd_name;
 
 	if (idxd->hw.gen_cap.evl_support == 0)
 		return 0;
@@ -355,9 +357,16 @@ static int idxd_init_evl(struct idxd_device *idxd)
 	spin_lock_init(&evl->lock);
 	evl->size = IDXD_EVL_SIZE_MIN;
 
-	idxd->evl_cache = kmem_cache_create(dev_name(idxd_confdev(idxd)),
-					    sizeof(struct idxd_evl_fault) + evl_ent_size(idxd),
-					    0, 0, NULL);
+	idxd_name = dev_name(idxd_confdev(idxd));
+	evl_cache_size = sizeof(struct idxd_evl_fault) + evl_ent_size(idxd);
+	/*
+	 * Since completion record in evl_cache will be copied to user
+	 * when handling completion record page fault, need to create
+	 * the cache suitable for user copy.
+	 */
+	idxd->evl_cache = kmem_cache_create_usercopy(idxd_name, evl_cache_size,
+						     0, 0, 0, evl_cache_size,
+						     NULL);
 	if (!idxd->evl_cache) {
 		kfree(evl);
 		return -ENOMEM;
-- 
2.37.1


