Return-Path: <dmaengine+bounces-7100-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 192F0C44924
	for <lists+dmaengine@lfdr.de>; Sun, 09 Nov 2025 23:30:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 3733A4E6038
	for <lists+dmaengine@lfdr.de>; Sun,  9 Nov 2025 22:30:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 959CC270EC1;
	Sun,  9 Nov 2025 22:29:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="P/zQEsIW"
X-Original-To: dmaengine@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFE84264612;
	Sun,  9 Nov 2025 22:29:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762727390; cv=none; b=YCOgl63lQoLDC5Ue4smX539nHdX8qtX/Rq6KMgmtjCQyY0DITu5l0vAKxfVNWlMvc2VFKa+LPJnCp/Mr13ymIrEdDrp8ntvpTc9u8g4N4uovTk4bKZ7e5TPxTcq7AcqbR7E7KDxfebC44ss+3g0P+XfKHVyXQGb7NP8QOMSabWg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762727390; c=relaxed/simple;
	bh=wB2oLiYJhWbEh314qe85aEpv43yhhmfA/0tWeb6KnqY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UzMURI1uZHGGQ5ESe+e9U3xml7tRkaodCY3VTKGuoSRja0C8KHLLywe66CuxTcjx9ZbQHX20tnTwVbrJ45wvs4bYl4QKqoL7/FE9SzyRYqL5AR+YWgkfhSgWXrWyT7qDErYgWFQxKfwK9vhjPrRplZUEvJL718WaK9f+WXDnV3g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=P/zQEsIW; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1762727388; x=1794263388;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=wB2oLiYJhWbEh314qe85aEpv43yhhmfA/0tWeb6KnqY=;
  b=P/zQEsIW6F4bPJtvSK/AOJXh3HOZ2gCxs5Nr5GSFNfJ7LicTPdA0QLl+
   IGN+sjH24dx6NS1/5Dx++kp3CBKqWbeNgqw4g7m6tZ+3mqE3Aw0u3eTmW
   6QzvGjfDq/3OOyJUXljxwQ2WAK5WGlrhhS2NVQv+z3V/TYKhKfGNrbhE6
   Ctpbp3a+QgxccgfhVfO3FxxMlKEkA2K/c2+/FQS7qL8W8oKMqp4hrY1Bu
   2GYrNhGQ6Aun7KUtvsS5qquHNj9p5Js2LuPsW7Y2CW+mkLllHaIn45C4t
   MttvBHsLBWvKoJ3eElwgdAMaTZhOID/Zinr1fDDjbQEgMYy6QC4SYWfpU
   w==;
X-CSE-ConnectionGUID: Ve1u8B+aQBCzCHvnPYORoA==
X-CSE-MsgGUID: tgSozo3yStSxPK3LvmLB2Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11608"; a="63990501"
X-IronPort-AV: E=Sophos;i="6.19,292,1754982000"; 
   d="scan'208";a="63990501"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Nov 2025 14:29:47 -0800
X-CSE-ConnectionGUID: VTRA7nvgQIyYs3xdP5Z/0Q==
X-CSE-MsgGUID: A0xgFt7SR2qIvTiw1SaJtw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,292,1754982000"; 
   d="scan'208";a="219174259"
Received: from black.igk.intel.com ([10.91.253.5])
  by orviesa002.jf.intel.com with ESMTP; 09 Nov 2025 14:29:46 -0800
Received: by black.igk.intel.com (Postfix, from userid 1003)
	id 4FD8B99; Sun, 09 Nov 2025 23:29:45 +0100 (CET)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	dmaengine@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Vinod Koul <vkoul@kernel.org>
Subject: [PATCH v1 4/4] dmaengine: Sort headers alphabetically
Date: Sun,  9 Nov 2025 23:28:37 +0100
Message-ID: <20251109222944.3222436-5-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20251109222944.3222436-1-andriy.shevchenko@linux.intel.com>
References: <20251109222944.3222436-1-andriy.shevchenko@linux.intel.com>
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
index 9e2ce7054e8a..6d940c4c0c4e 100644
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


