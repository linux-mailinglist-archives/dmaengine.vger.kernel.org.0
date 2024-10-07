Return-Path: <dmaengine+bounces-3290-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D93079930C5
	for <lists+dmaengine@lfdr.de>; Mon,  7 Oct 2024 17:11:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8C60B1F22B0D
	for <lists+dmaengine@lfdr.de>; Mon,  7 Oct 2024 15:11:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C350A1D9597;
	Mon,  7 Oct 2024 15:09:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OS+f84JE"
X-Original-To: dmaengine@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42ABD1D79BB;
	Mon,  7 Oct 2024 15:09:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728313790; cv=none; b=frpEeqg2mPuw691VxH/nmCYsdlhj0KBPnkkLc7CL4JAmYXpzMaZOFutHqpPkFGpdlcVC7XrKqYL6QB1yGLH29QoFCGmhhEABPBizuISO/koRP0kJxtWJoopyYwhOb4iNA3jFJasJo42MiH+D000a8kYo7wh0cp981XCObQajeNo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728313790; c=relaxed/simple;
	bh=jjUrqSMvD+TNkk6dISyjVWCLL2O2l9uhCDaFAXlWcKY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Q1KdUQPeCTKwWvpVpOCdmQcqsrE87dWDeRv2c2smcj/z5ogf+g5BWs1os1EVRO2whWvW3Oa4BhfuiR7lynfsbwBLgU8LyFaQPGoG1ggWi3jeAzXlNMVJFTmwRvSA/IobJDsjEpzjRpzoGlkdcPuzTJyGNXbPt6OT7U7CQSwEtIA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OS+f84JE; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1728313790; x=1759849790;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=jjUrqSMvD+TNkk6dISyjVWCLL2O2l9uhCDaFAXlWcKY=;
  b=OS+f84JEVYwiaYFbAOJH/j0CylmIUBUIpGSY+W1CdUUzYem4q1jtbDTc
   E2CHagbbxRDOz6sA0t5KjZUtlZw34Tgtj+whL3kHTc00C0vIR5+Ek1JOx
   hRB4HhfbuCedRAi6G+HVle7oyPD2z34dWu7DjF1gYhqwwNZSS5I+eNB4S
   Ye/ZZ7Iylp1GxYWJkf772YwJ7IISixKptW/MZPsGvc1zTR6oM1zBgATBn
   bn/M0GZxA6iOik7NnzuGx4y2zDVxeX6VPqwsMZ8koLMSEMiW3Nmva0CsR
   WY1zlM305MFY41MQbz60tzu61RDCdWFEwS22sfHdubO8XvDz2wK4qFJp7
   g==;
X-CSE-ConnectionGUID: MKQdVyOhR2qNA6dEK3fTcA==
X-CSE-MsgGUID: Uf7BTGBXSGqg4usreYnMTw==
X-IronPort-AV: E=McAfee;i="6700,10204,11218"; a="27346859"
X-IronPort-AV: E=Sophos;i="6.11,184,1725346800"; 
   d="scan'208";a="27346859"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Oct 2024 08:08:58 -0700
X-CSE-ConnectionGUID: ewQNEzAwQ0GaSUbdLRDDZw==
X-CSE-MsgGUID: VqR2QV4FQVKvxwDO3aRN1A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,184,1725346800"; 
   d="scan'208";a="79494670"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmviesa003.fm.intel.com with ESMTP; 07 Oct 2024 08:08:56 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id EB25556D; Mon, 07 Oct 2024 18:08:53 +0300 (EEST)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Vinod Koul <vkoul@kernel.org>,
	Paul Cercueil <paul@crapouillou.net>,
	dmaengine@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org
Cc: Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>
Subject: [PATCH v1 4/4] dmaengine: Unify checks in dma_request_chan()
Date: Mon,  7 Oct 2024 18:06:48 +0300
Message-ID: <20241007150852.2183722-5-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.43.0.rc1.1336.g36b5255a03ac
In-Reply-To: <20241007150852.2183722-1-andriy.shevchenko@linux.intel.com>
References: <20241007150852.2183722-1-andriy.shevchenko@linux.intel.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use firmware node and unify checks accordingly in dma_request_chan().
As a side effect we get rid of the node dereferencing in struct device.

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


