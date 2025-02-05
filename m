Return-Path: <dmaengine+bounces-4306-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D8ED3A2930D
	for <lists+dmaengine@lfdr.de>; Wed,  5 Feb 2025 16:08:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 087F23ADA95
	for <lists+dmaengine@lfdr.de>; Wed,  5 Feb 2025 15:00:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37C0A1DF24B;
	Wed,  5 Feb 2025 14:58:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BAIS/m/r"
X-Original-To: dmaengine@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A40D18C93C;
	Wed,  5 Feb 2025 14:58:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738767487; cv=none; b=NvN974CVJkMWCxbjI8y4J7fYINoROYuIlwApp00KOkrNQb9eK5gm2xhbRPANkEwGd0A+HE87nHys2bSKhtIAUJKfwnErqXdJfwnRzhBDR+l3vqJ/FhtaTL03uZ9cUvaKmpdHOK4qvDB2pYv9RnsqDc5XT/zpttiEPeHLrhE0FpA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738767487; c=relaxed/simple;
	bh=LWWSgceP4b2NC/0ZlJaLRWZ5tS4LiVtbK0mjSJfEAow=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GvX6+umBESP1p8palf6JzeO7iCiIyn+ZaCgU6iOdwfyuqcxMn7FMJyvs2lydY7/h6H1Qoz6izILQ0U1wYm7exUqd+Xl3YjHvblY90s8k5Mow60GyqKCnyx9m5bzmMnQCILj0QpnQDpcyjphh5ekn0jpG3K7Cztfkw9ZhsRtgjoI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BAIS/m/r; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1738767486; x=1770303486;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=LWWSgceP4b2NC/0ZlJaLRWZ5tS4LiVtbK0mjSJfEAow=;
  b=BAIS/m/r2jG7ZMvbTewcq3o6ByGYFSImQeD8iYBKASgy2mAZp9IcNnRp
   I7JQfUA+O10koBCZQ33R3Sfr2nrnXLsW7d3PvzNIsXJ+ODkyUe9cI6NTW
   hAgN9+SpBdAZj0XuGLaHUGNVQn/+Z7NWAeMWcJ9idzlkdf+mVfRpxw0u4
   MMncFM6Th0ppbpwt18Alk9nlJMVFh9gXdF0mdWdBuaXLENdncbVrzze26
   u1y1n7M/kPVy677ngHgGDhRFRSKX72AOjzGhxkYfkeK6oyWuGKXwHjgpo
   OVqXQOeu56/HPv9tGx00ldNjZUxCR/UhHJeUn1GlE4RIQtqdKRoUtrJlY
   w==;
X-CSE-ConnectionGUID: /+kZMUreRM6X33nKYcZ/Qg==
X-CSE-MsgGUID: y1SR6VHTQSqtogm/mS47Dg==
X-IronPort-AV: E=McAfee;i="6700,10204,11336"; a="39599705"
X-IronPort-AV: E=Sophos;i="6.13,261,1732608000"; 
   d="scan'208";a="39599705"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Feb 2025 06:58:03 -0800
X-CSE-ConnectionGUID: K6nc5QcQSXiYTt2XdJuX+A==
X-CSE-MsgGUID: TxFOuydCRDyH9A6DioS8jA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,261,1732608000"; 
   d="scan'208";a="115968401"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmviesa004.fm.intel.com with ESMTP; 05 Feb 2025 06:58:01 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id CD62914E; Wed, 05 Feb 2025 16:57:58 +0200 (EET)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Vinod Koul <vkoul@kernel.org>,
	Amelie Delaunay <amelie.delaunay@foss.st.com>,
	Frank Li <Frank.Li@nxp.com>,
	Paul Cercueil <paul@crapouillou.net>,
	Randy Dunlap <rdunlap@infradead.org>,
	dmaengine@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org
Cc: Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v3 4/4] dmaengine: Unify checks in dma_request_chan()
Date: Wed,  5 Feb 2025 16:57:12 +0200
Message-ID: <20250205145757.889247-5-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.43.0.rc1.1336.g36b5255a03ac
In-Reply-To: <20250205145757.889247-1-andriy.shevchenko@linux.intel.com>
References: <20250205145757.889247-1-andriy.shevchenko@linux.intel.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use dev_fwnode() to simplify the check logic for Device Tree and ACPI
in dma_request_chan().

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/dma/dmaengine.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/dma/dmaengine.c b/drivers/dma/dmaengine.c
index dd4224d90f07..758fcd0546d8 100644
--- a/drivers/dma/dmaengine.c
+++ b/drivers/dma/dmaengine.c
@@ -40,6 +40,8 @@
 #include <linux/dmaengine.h>
 #include <linux/hardirq.h>
 #include <linux/spinlock.h>
+#include <linux/of.h>
+#include <linux/property.h>
 #include <linux/percpu.h>
 #include <linux/rcupdate.h>
 #include <linux/mutex.h>
@@ -812,15 +814,13 @@ static const struct dma_slave_map *dma_filter_match(struct dma_device *device,
  */
 struct dma_chan *dma_request_chan(struct device *dev, const char *name)
 {
+	struct fwnode_handle *fwnode = dev_fwnode(dev);
 	struct dma_device *d, *_d;
 	struct dma_chan *chan = NULL;
 
-	/* If device-tree is present get slave info from here */
-	if (dev->of_node)
-		chan = of_dma_request_slave_channel(dev->of_node, name);
-
-	/* If device was enumerated by ACPI get slave info from here */
-	if (has_acpi_companion(dev) && !chan)
+	if (is_of_node(fwnode))
+		chan = of_dma_request_slave_channel(to_of_node(fwnode), name);
+	else if (is_acpi_device_node(fwnode))
 		chan = acpi_dma_request_slave_chan_by_name(dev, name);
 
 	if (PTR_ERR(chan) == -EPROBE_DEFER)
-- 
2.43.0.rc1.1336.g36b5255a03ac


