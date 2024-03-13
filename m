Return-Path: <dmaengine+bounces-1381-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 16EDC87B3A3
	for <lists+dmaengine@lfdr.de>; Wed, 13 Mar 2024 22:41:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AA1191F23DF8
	for <lists+dmaengine@lfdr.de>; Wed, 13 Mar 2024 21:41:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 679A159B53;
	Wed, 13 Mar 2024 21:41:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IPWqatkV"
X-Original-To: dmaengine@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5707859168;
	Wed, 13 Mar 2024 21:41:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710366065; cv=none; b=WjXfr3J/6mNbyzLgdoFlKv1fhWO9IWYTwBtd0z7mgFNaM19moBtRpt0i4pas8XXC1vUGnu3i8Ig/d44R0qdOaQDa7qBPKlhoX28WnPLqK+k6gmw3X095phIKqow48F69eCna07hDsA2NIEwa5e3CH6O8rPgu+sahx4VJeqkhkqg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710366065; c=relaxed/simple;
	bh=e9/aE3W+B9fWGEJ7kuuXfT+sZG0KdOCHiiwPjqy9t1M=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ZYHXgq/cdQe38bUkeNLgmmwUSeRTEacEGtGfpUueKXozTXed+RLbztdj0peT+A2PeF6LhBlDdLA/5+VzMojKRD9yJwClfJWC1F2Ck3bnG/z+ZqZZOmrXExFRVC85sDGeC07K4DWyO3DSEXrWfkXn3aOb+5UTi8BUtiBA7xOKpDA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=IPWqatkV; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1710366063; x=1741902063;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=e9/aE3W+B9fWGEJ7kuuXfT+sZG0KdOCHiiwPjqy9t1M=;
  b=IPWqatkVU+/r4ouTQVHuxd3ShTgVyRats5ImrrkHS7H4BFn12JE49WVR
   qV+GHIW0YUl9LjObFSDIJbGwvP5fQLR3jLhbrLvsPumMJ45/C8o7C4Z+G
   EmuAXT93+pF/ylXaqh1tTUjDXg3cXLtW+mqOXcAceZADKuZI+h34IJNXH
   X/KPTkeS04RO3tyJ8A63jQz9g0TJqqohYsml3BArlY1gGxI3/H6f/2SKN
   +oAq3WVAsYCjKAR1CNetWiFI9jUo4dvp8WuYcXGwYa5tW/paI7HH9a/4Z
   hYHV2vHnBpqr5U8IgGkdTUBBICM/+zSxKstCT3wlm0tYCRRdlVAIzdSGN
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,11012"; a="22678477"
X-IronPort-AV: E=Sophos;i="6.07,123,1708416000"; 
   d="scan'208";a="22678477"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Mar 2024 14:41:02 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,123,1708416000"; 
   d="scan'208";a="12522193"
Received: from fyu1.sc.intel.com ([172.25.103.126])
  by orviesa007.jf.intel.com with ESMTP; 13 Mar 2024 14:41:02 -0700
From: Fenghua Yu <fenghua.yu@intel.com>
To: "Vinod Koul" <vkoul@kernel.org>,
	"Dave Jiang" <dave.jiang@intel.com>
Cc: dmaengine@vger.kernel.org,
	"linux-kernel" <linux-kernel@vger.kernel.org>,
	Fenghua Yu <fenghua.yu@intel.com>,
	Terrence Xu <terrence.xu@intel.com>
Subject: [PATCH] dmaengine: idxd: Fix oops during rmmod on single-CPU platforms
Date: Wed, 13 Mar 2024 14:40:31 -0700
Message-Id: <20240313214031.1658045-1-fenghua.yu@intel.com>
X-Mailer: git-send-email 2.37.1
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

During the removal of the idxd driver, registered offline callback is
invoked as part of the clean up process. However, on systems with only
one CPU online, no valid target is available to migrate the
perf context, resulting in a kernel oops:

    BUG: unable to handle page fault for address: 000000000002a2b8
    #PF: supervisor write access in kernel mode
    #PF: error_code(0x0002) - not-present page
    PGD 1470e1067 P4D 0 
    Oops: 0002 [#1] PREEMPT SMP NOPTI
    CPU: 0 PID: 20 Comm: cpuhp/0 Not tainted 6.8.0-rc6-dsa+ #57
    Hardware name: Intel Corporation AvenueCity/AvenueCity, BIOS BHSDCRB1.86B.2492.D03.2307181620 07/18/2023
    RIP: 0010:mutex_lock+0x2e/0x50
    ...
    Call Trace:
    <TASK>
    __die+0x24/0x70
    page_fault_oops+0x82/0x160
    do_user_addr_fault+0x65/0x6b0
    __pfx___rdmsr_safe_on_cpu+0x10/0x10
    exc_page_fault+0x7d/0x170
    asm_exc_page_fault+0x26/0x30
    mutex_lock+0x2e/0x50
    mutex_lock+0x1e/0x50
    perf_pmu_migrate_context+0x87/0x1f0
    perf_event_cpu_offline+0x76/0x90 [idxd]
    cpuhp_invoke_callback+0xa2/0x4f0
    __pfx_perf_event_cpu_offline+0x10/0x10 [idxd]
    cpuhp_thread_fun+0x98/0x150
    smpboot_thread_fn+0x27/0x260
    smpboot_thread_fn+0x1af/0x260
    __pfx_smpboot_thread_fn+0x10/0x10
    kthread+0x103/0x140
    __pfx_kthread+0x10/0x10
    ret_from_fork+0x31/0x50
    __pfx_kthread+0x10/0x10
    ret_from_fork_asm+0x1b/0x30
    <TASK>

Fix the issue by preventing the migration of the perf context to an
invalid target.

Fixes: 81dd4d4d6178 ("dmaengine: idxd: Add IDXD performance monitor support")
Reported-by: Terrence Xu <terrence.xu@intel.com>
Tested-by: Terrence Xu <terrence.xu@intel.com>
Signed-off-by: Fenghua Yu <fenghua.yu@intel.com>
---
 drivers/dma/idxd/perfmon.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/drivers/dma/idxd/perfmon.c b/drivers/dma/idxd/perfmon.c
index fdda6d604262..5e94247e1ea7 100644
--- a/drivers/dma/idxd/perfmon.c
+++ b/drivers/dma/idxd/perfmon.c
@@ -528,14 +528,11 @@ static int perf_event_cpu_offline(unsigned int cpu, struct hlist_node *node)
 		return 0;
 
 	target = cpumask_any_but(cpu_online_mask, cpu);
-
 	/* migrate events if there is a valid target */
-	if (target < nr_cpu_ids)
+	if (target < nr_cpu_ids) {
 		cpumask_set_cpu(target, &perfmon_dsa_cpu_mask);
-	else
-		target = -1;
-
-	perf_pmu_migrate_context(&idxd_pmu->pmu, cpu, target);
+		perf_pmu_migrate_context(&idxd_pmu->pmu, cpu, target);
+	}
 
 	return 0;
 }
-- 
2.37.1


