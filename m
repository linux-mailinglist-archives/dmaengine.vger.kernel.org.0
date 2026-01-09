Return-Path: <dmaengine+bounces-8183-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 74F8CD0BBB8
	for <lists+dmaengine@lfdr.de>; Fri, 09 Jan 2026 18:44:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 448623023550
	for <lists+dmaengine@lfdr.de>; Fri,  9 Jan 2026 17:37:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB1D2368271;
	Fri,  9 Jan 2026 17:37:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TuY8Tdw+"
X-Original-To: dmaengine@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02C45366DA4;
	Fri,  9 Jan 2026 17:37:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767980250; cv=none; b=CPtLwu0IlRqzX/Rmj5cftlW4O1JqGeFjWZKl4If/ZnrzrSkRkl2Hht0RttpI0es7gmeirNEvYZPTrlyy3ksHVoHxk+AS19yeZdlRMIgKuLm6hUKf4XIt8umi1ikaL9PXtCnYmj2Y7kxBEu9X3iob5VEnrjx7jVJvGUlBSIGmXa4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767980250; c=relaxed/simple;
	bh=48VT4rHF/a5urJ4ty3bzTMf56/MA7He4R78XM965gQQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NAKUZaNVOvrkUgzAJEn2Njp2drUJGLLTiUZ1sPLbJKLg7GvKme585MaXzxRS+0tBZOViQdSq9oMJlurBkZhJDzr4NJDHFiBH3XizJfN2CVeeL7n7UgmcKjl7Y1uH/lxcF3ORRxyQwVBx4QLNRGp0SeuzScDIftubHPYqwU+wNg0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TuY8Tdw+; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1767980246; x=1799516246;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=48VT4rHF/a5urJ4ty3bzTMf56/MA7He4R78XM965gQQ=;
  b=TuY8Tdw+5o5XcbyIQXXoKTYoAuqjAGVf6aRr6X5K+qbJmTTTJMQ+cQTm
   XdwKXf0jWeQw9BMoazZUsn2sRJy5HBwreQ0IFQXMhTqggB+p4fpKHRs78
   hQaGLqO4GPRx+vjRI1bAmBCyRmrydF1f43GBKNOCM0hg7ShleNODvfWDM
   3m1tj2IWFewFrpMW+KSPtbR2ZFdFBfgkNPWvJqypvNkQE8t6DarQ8Kifu
   fxLwPoeAapOyBjZUa2IMSLAZJ9X0Z+V7qDKzm9DmrxJq2gbIAKPVGo1Xd
   8/5oFhya2pX/MQG1w970UOH+mtwJgszUd+wfe1tsmLR1izsQAxvNaBLO6
   A==;
X-CSE-ConnectionGUID: lsaOgR2HRJqRSnbDuOKPNw==
X-CSE-MsgGUID: mGHXLjwWQeeUDijpM0pfMQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11666"; a="69296538"
X-IronPort-AV: E=Sophos;i="6.21,214,1763452800"; 
   d="scan'208";a="69296538"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jan 2026 09:37:21 -0800
X-CSE-ConnectionGUID: 6SNxbs1GTVi5z3a2VOpQow==
X-CSE-MsgGUID: wZ6DPVAdQt6ZRWFldNhDHg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,214,1763452800"; 
   d="scan'208";a="204318500"
Received: from black.igk.intel.com ([10.91.253.5])
  by fmviesa010.fm.intel.com with ESMTP; 09 Jan 2026 09:37:20 -0800
Received: by black.igk.intel.com (Postfix, from userid 1003)
	id 3DA589B; Fri, 09 Jan 2026 18:37:19 +0100 (CET)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	dmaengine@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Vinod Koul <vkoul@kernel.org>
Subject: [PATCH v3 3/3] dmaengine: Sort headers alphabetically
Date: Fri,  9 Jan 2026 18:35:43 +0100
Message-ID: <20260109173718.3605829-4-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260109173718.3605829-1-andriy.shevchenko@linux.intel.com>
References: <20260109173718.3605829-1-andriy.shevchenko@linux.intel.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

For better maintenance sort headers alphabetically.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/dma/dmaengine.c | 38 +++++++++++++++++++-------------------
 1 file changed, 19 insertions(+), 19 deletions(-)

diff --git a/drivers/dma/dmaengine.c b/drivers/dma/dmaengine.c
index ca1723a34779..45af455ab2be 100644
--- a/drivers/dma/dmaengine.c
+++ b/drivers/dma/dmaengine.c
@@ -31,29 +31,29 @@
 
 #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
 
-#include <linux/platform_device.h>
-#include <linux/dma-mapping.h>
-#include <linux/init.h>
-#include <linux/module.h>
-#include <linux/mm.h>
-#include <linux/device.h>
-#include <linux/dmaengine.h>
-#include <linux/hardirq.h>
-#include <linux/spinlock.h>
-#include <linux/of.h>
-#include <linux/property.h>
-#include <linux/percpu.h>
-#include <linux/rcupdate.h>
-#include <linux/mutex.h>
-#include <linux/jiffies.h>
-#include <linux/rculist.h>
-#include <linux/idr.h>
-#include <linux/slab.h>
 #include <linux/acpi.h>
 #include <linux/acpi_dma.h>
-#include <linux/of_dma.h>
+#include <linux/device.h>
+#include <linux/dma-mapping.h>
+#include <linux/dmaengine.h>
+#include <linux/hardirq.h>
+#include <linux/idr.h>
+#include <linux/init.h>
+#include <linux/jiffies.h>
 #include <linux/mempool.h>
+#include <linux/mm.h>
+#include <linux/module.h>
+#include <linux/mutex.h>
 #include <linux/numa.h>
+#include <linux/of.h>
+#include <linux/of_dma.h>
+#include <linux/percpu.h>
+#include <linux/platform_device.h>
+#include <linux/property.h>
+#include <linux/rculist.h>
+#include <linux/rcupdate.h>
+#include <linux/slab.h>
+#include <linux/spinlock.h>
 
 #include "dmaengine.h"
 
-- 
2.50.1


