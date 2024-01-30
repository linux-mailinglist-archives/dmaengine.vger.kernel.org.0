Return-Path: <dmaengine+bounces-887-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E76878419C0
	for <lists+dmaengine@lfdr.de>; Tue, 30 Jan 2024 03:59:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A42F1283390
	for <lists+dmaengine@lfdr.de>; Tue, 30 Jan 2024 02:59:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7890A37152;
	Tue, 30 Jan 2024 02:58:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Y1vd3WUV"
X-Original-To: dmaengine@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92EC8374E9;
	Tue, 30 Jan 2024 02:58:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706583533; cv=none; b=IrznwPCSRPLZqgSW3m6syVTJ7m1HtMWp2VmMB9DnmeJpB50ddKcz2W5DaOoslFXV4GNzK7xyzr78/0Cj+Cg8oiqETAnAiyaQW1/r5H7Qvq7emuFQhvTKPiKQjqinzCiy5/jcYAx3+XdYV3djvDXnRoFalTYWKk0+leGpPTOwP+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706583533; c=relaxed/simple;
	bh=GmuwNFJzWnA1Oqg0ns6ZK1TFM5ogyUhRCfAnEm9agos=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=OO4h8TN2G986qWk5pojOGs0LR67+GRQCbaWKCjbkwKkIVIwxaanMi1i+ik9CrlwXGbC4Wz2y4W/+0bCYmKnW4e37f1WfNdDT6k+SkrfJMyUeZy8xrhuvIWva+s2x6WuazhYn2p/KRGMzSIvA5xBnOyJ3YgRfP+xMJ8qcRTqAKyQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Y1vd3WUV; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706583531; x=1738119531;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=GmuwNFJzWnA1Oqg0ns6ZK1TFM5ogyUhRCfAnEm9agos=;
  b=Y1vd3WUVOe2fmCAOY4HOVXRn3e6qUsV/k+Djxxu6lEeh0VYM/VROdLd8
   YQ3uJquMGarfuRVGMUNgdVPeuzx+6Xii5DbhWxaEiyF3upwKBxpG6pg6p
   ZkM1DS+BjtGh7IgAXKeOPgQrmlW7aiMQYsemRhyoFgSXLrwypJGLBWl2c
   34R8kGrQn+Rtn6nCkbJIWkfASqS/nlt6aSUuZ1HZp1XTip3Xq/UX2aq7J
   YtJmSefMZMiOxlOVH11QiWZtCOnl83gNip3PLdoKvq4b3JIeAvaL00JmS
   ZCf65iv4LgIfRGtqeIxT6dpk1f6jTyu9M13PsohPsOn2ocv2jopOOPtx5
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10968"; a="9891664"
X-IronPort-AV: E=Sophos;i="6.05,707,1701158400"; 
   d="scan'208";a="9891664"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jan 2024 18:58:50 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,707,1701158400"; 
   d="scan'208";a="3520576"
Received: from fyu1.sc.intel.com ([172.25.103.126])
  by orviesa005.jf.intel.com with ESMTP; 29 Jan 2024 18:58:49 -0800
From: Fenghua Yu <fenghua.yu@intel.com>
To: "Vinod Koul" <vkoul@kernel.org>,
	"Dave Jiang" <dave.jiang@intel.com>
Cc: dmaengine@vger.kernel.org,
	"linux-kernel" <linux-kernel@vger.kernel.org>,
	Fenghua Yu <fenghua.yu@intel.com>,
	Nikhil Rao <nikhil.rao@intel.com>,
	Tony Zhu <tony.zhu@intel.com>
Subject: [PATCH] dmaengine: idxd: Change wmb() to smp_wmb() when copying completion record to user space
Date: Mon, 29 Jan 2024 18:58:06 -0800
Message-Id: <20240130025806.2027284-1-fenghua.yu@intel.com>
X-Mailer: git-send-email 2.37.1
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

wmb() is used to ensure status in the completion record is written
after the rest of the completion record, making it visible to the user.
However, on SMP systems, this may not guarantee visibility across
different CPUs.

Considering this scenario that event log handler is running on CPU1 while
user app is polling completion record (cr) status on CPU2:

	CPU1				CPU2
event log handler			user app

					1. cr = 0 (status = 0)
2. copy X to user cr except "status"
3. wmb()
4. copy Y to user cr "status"
					5. poll status value Y
				 	6. read rest cr which is still 0.
					   cr handling fails
					7. cr value X visible now

Although wmb() ensure value Y is written and visible after X is written
on CPU1, the order is not guaranteed on CPU2. So user app may see status
value Y while cr value X is still not visible yet on CPU2. This will
cause reading 0 from the rest of cr and cr handling fails.

Changing wmb() to smp_wmb() ensures Y is written after X on both CPU1
and CPU2. This guarantees that user app can consume cr in right order.

Fixes: b022f59725f0 ("dmaengine: idxd: add idxd_copy_cr() to copy user completion record during page fault handling")
Suggested-by: Nikhil Rao <nikhil.rao@intel.com>
Tested-by: Tony Zhu <tony.zhu@intel.com>
Signed-off-by: Fenghua Yu <fenghua.yu@intel.com>
---
 drivers/dma/idxd/cdev.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/dma/idxd/cdev.c b/drivers/dma/idxd/cdev.c
index 77f8885cf407..9b7388a23cbe 100644
--- a/drivers/dma/idxd/cdev.c
+++ b/drivers/dma/idxd/cdev.c
@@ -681,9 +681,10 @@ int idxd_copy_cr(struct idxd_wq *wq, ioasid_t pasid, unsigned long addr,
 		 * Ensure that the completion record's status field is written
 		 * after the rest of the completion record has been written.
 		 * This ensures that the user receives the correct completion
-		 * record information once polling for a non-zero status.
+		 * record information on any CPU once polling for a non-zero
+		 * status.
 		 */
-		wmb();
+		smp_wmb();
 		status = *(u8 *)cr;
 		if (put_user(status, (u8 __user *)addr))
 			left += status_size;
-- 
2.37.1


