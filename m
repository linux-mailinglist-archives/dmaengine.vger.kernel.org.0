Return-Path: <dmaengine+bounces-886-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BDE0784187F
	for <lists+dmaengine@lfdr.de>; Tue, 30 Jan 2024 02:40:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5CA1A1F27C95
	for <lists+dmaengine@lfdr.de>; Tue, 30 Jan 2024 01:40:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C3723611F;
	Tue, 30 Jan 2024 01:40:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IdAnebLX"
X-Original-To: dmaengine@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8728536102;
	Tue, 30 Jan 2024 01:40:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706578835; cv=none; b=sA90cmOzcIWgOoVHZQOMW6vsnKCd6cQVCAmxHypRTbsaqfDvmilV/x4jVia3sqhoUhzKgLMvmXQwvrCaDx7mZxK6aDg6sQz7tkuXlutOFHWnEhuIQqDxnsIeCQQ0/wMhXT/jkjOaj2P6tG48g6Z1Vx2+uA/ThXlIY89Ne2fXl78=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706578835; c=relaxed/simple;
	bh=9nLhA8tc2Ea4K4PEhVy6i7mywoj/BoVhDHAl5Sae9OU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=YUAmvB9EBHelf/usMgVTrXBL0aH4RAkqT0WsobH9kr0w6oGFrwUxD/ZAdWHjM/SmVQd11wzuX9Xg8dwiWsR6BL42CfWD6sLE2RQt31I1abB+PlDXm+lJXUQIlRcyvK1ZFbzUSLrDGUTKQQyCu6/iTU4f+Ns4l37u0FR3BM2wtNo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=IdAnebLX; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706578833; x=1738114833;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=9nLhA8tc2Ea4K4PEhVy6i7mywoj/BoVhDHAl5Sae9OU=;
  b=IdAnebLXcSu1ECGugbZCJxkOnnhN5/jP2EyMYZPMl2cVvXdY055dnVjF
   rIGPizZLZpZRcNVd5j7J/f7a/EdA8f3opbIQS3buFkzzsKqsK3cRaolGc
   eqPvLlDbIXZguPZmy0ntcuVGxge/2SwyI8kOMAfBs/MBN3ovmCh9Zw6jk
   cNyJ4SOsMHhUkIMA4dRmjUNcsNTFfHY5p+mIeClejA+WDpNbIzSPv3Zab
   ZTmUU9Ii0d2DSGyUV8Pjy01nlsbT8cTu8j2g58Vm+GffoGmI36dg6A5Fk
   3IRI0BkEL0Posgx+r36thM1eaRJzzdNeIJbSXMNtnXf5PjVTlhsGQ92Sz
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10968"; a="24613155"
X-IronPort-AV: E=Sophos;i="6.05,227,1701158400"; 
   d="scan'208";a="24613155"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jan 2024 17:40:33 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,227,1701158400"; 
   d="scan'208";a="22276867"
Received: from fyu1.sc.intel.com ([172.25.103.126])
  by fmviesa002.fm.intel.com with ESMTP; 29 Jan 2024 17:40:32 -0800
From: Fenghua Yu <fenghua.yu@intel.com>
To: "Vinod Koul" <vkoul@kernel.org>,
	"Dave Jiang" <dave.jiang@intel.com>
Cc: dmaengine@vger.kernel.org,
	"linux-kernel" <linux-kernel@vger.kernel.org>,
	Fenghua Yu <fenghua.yu@intel.com>,
	Lijun Pan <lijun.pan@intel.com>
Subject: [PATCH] dmaengine: idxd: Avoid unnecessary destruction of file_ida
Date: Mon, 29 Jan 2024 17:39:54 -0800
Message-Id: <20240130013954.2024231-1-fenghua.yu@intel.com>
X-Mailer: git-send-email 2.37.1
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

file_ida is allocated during cdev open and is freed accordingly
during cdev release. This sequence is guaranteed by driver file
operations. Therefore, there is no need to destroy an already empty
file_ida when the WQ cdev is removed.

Worse, ida_free() in cdev release may happen after destruction of 
file_ida per WQ cdev. This can lead to accessing an id in file_ida
after it has been destroyed, resulting in a kernel panic.

Remove ida_destroy(&file_ida) to address these issues.

Fixes: e6fd6d7e5f0f ("dmaengine: idxd: add a device to represent the file opened")
Signed-off-by: Lijun Pan <lijun.pan@intel.com>
Signed-off-by: Fenghua Yu <fenghua.yu@intel.com>
---
 drivers/dma/idxd/cdev.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/dma/idxd/cdev.c b/drivers/dma/idxd/cdev.c
index baa51927675c..3311c920f47a 100644
--- a/drivers/dma/idxd/cdev.c
+++ b/drivers/dma/idxd/cdev.c
@@ -1272,7 +1272,6 @@ void idxd_wq_del_cdev(struct idxd_wq *wq)
 	struct idxd_cdev *idxd_cdev;
 
 	idxd_cdev = wq->idxd_cdev;
-	ida_destroy(&file_ida);
 	wq->idxd_cdev = NULL;
 	cdev_device_del(&idxd_cdev->cdev, cdev_dev(idxd_cdev));
 	put_device(cdev_dev(idxd_cdev));
-- 
2.37.1


