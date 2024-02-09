Return-Path: <dmaengine+bounces-991-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A25C284FCB7
	for <lists+dmaengine@lfdr.de>; Fri,  9 Feb 2024 20:20:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 429371F24AA1
	for <lists+dmaengine@lfdr.de>; Fri,  9 Feb 2024 19:20:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0178B8288B;
	Fri,  9 Feb 2024 19:20:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TgskkbuH"
X-Original-To: dmaengine@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 628072E3F7;
	Fri,  9 Feb 2024 19:20:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707506406; cv=none; b=m3NHEe/wngo2KzscDLJ7PIu0ERGvODjYvcYam1s8lF0hdcuM9EfoZQp9iZ5LoSvJlzRdf1fRj39AnmyY3GKQMrSoZSPjVL2+le4h8ArGjMCqFtn4pZVYIaNyyGDICXtlNeVOEVPD3W0gAx27HWHkv8Rm867Gp78lA9TJBeAQvmQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707506406; c=relaxed/simple;
	bh=/scsUM1RgXZzQBhcLxf4S2Tcz7R+LGWlrGZHqnYQWx4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=GFgcUbZqqjzWgvhgzhqZX5SHzlCZHbT9zFiy8wB3QFntsRcdOzvvW9auHZ1d4/nY4xCMoDw3wvD07D01d/v2jgPPlreDEhov5C4KnV8H5axsF/kEKvTgADAGUHmH6aCwQieBQY+1l/QD5X01wcfbzmoNMN0CvsTIwayIvb3hgUc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TgskkbuH; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707506406; x=1739042406;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=/scsUM1RgXZzQBhcLxf4S2Tcz7R+LGWlrGZHqnYQWx4=;
  b=TgskkbuHrDIs9UkqXnlJyJeKDqMH8ZY7Pzts/KD7stEOGZOehBR1NBz5
   vhYB5yJC9kW3P1LGYAZRRvtcuqBZ2q36OglSczxq7g+H5WjY5l2uI306+
   G8uyAt6HAHeQr1Y6ztQRnPCwyfBie81UhGaNNFvkvjQH+Sd8m9s9ZXSam
   1hf7oOCXu0CLQ7wSyFTofMOOxIuwJXHCJZwvTnj7HjSP1zgM8Yhc1hg3u
   0Wun5hE+FKo9sVBgnRLgE6YCWpQoVbXZ8BjI19M0jfzXG2OnoIp3F1qUs
   opQ9hpTIbPNltCqEZ2onfohCidMAhsRESr+0yHEaBJ1b1cS/MydblT8/y
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10979"; a="18900285"
X-IronPort-AV: E=Sophos;i="6.05,257,1701158400"; 
   d="scan'208";a="18900285"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Feb 2024 11:20:05 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,257,1701158400"; 
   d="scan'208";a="2356550"
Received: from fyu1.sc.intel.com ([172.25.103.126])
  by orviesa006.jf.intel.com with ESMTP; 09 Feb 2024 11:20:04 -0800
From: Fenghua Yu <fenghua.yu@intel.com>
To: "Vinod Koul" <vkoul@kernel.org>,
	"Dave Jiang" <dave.jiang@intel.com>
Cc: dmaengine@vger.kernel.org,
	"linux-kernel" <linux-kernel@vger.kernel.org>,
	Fenghua Yu <fenghua.yu@intel.com>,
	Lingyan Guo <lingyan.guo@intel.com>
Subject: [PATCH] dmaengine: idxd: Clear Event Log head in idxd upon completion of the Enable Device command
Date: Fri,  9 Feb 2024 11:18:51 -0800
Message-Id: <20240209191851.1050501-1-fenghua.yu@intel.com>
X-Mailer: git-send-email 2.37.1
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

If Event Log is supported, upon completion of the Enable Device command,
the Event Log head in the variable idxd->evl->head should be cleared to
match the state of the EVLSTATUS register. But the variable is not reset
currently, leading mismatch of the variable and the register state.
The mismatch causes incorrect processing of Event Log entries.

Fix the issue by clearing the variable after completion of the command.

Fixes: 2f431ba908d2 ("dmaengine: idxd: add interrupt handling for event log")
Tested-by: Lingyan Guo <lingyan.guo@intel.com>
Signed-off-by: Fenghua Yu <fenghua.yu@intel.com>
---
 drivers/dma/idxd/device.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/dma/idxd/device.c b/drivers/dma/idxd/device.c
index ecfdf4a8f1f8..7c9fb9b3e110 100644
--- a/drivers/dma/idxd/device.c
+++ b/drivers/dma/idxd/device.c
@@ -546,6 +546,14 @@ int idxd_device_enable(struct idxd_device *idxd)
 		return -ENXIO;
 	}
 
+	/*
+	 * If Event Log is supported, Event Log Status register was
+	 * cleared after the Enable Device command. Clear Event Log
+	 * head value that is stored in idxd to match the register state.
+	 */
+	if (idxd->evl)
+		idxd->evl->head = 0;
+
 	idxd->state = IDXD_DEV_ENABLED;
 	return 0;
 }
-- 
2.37.1


