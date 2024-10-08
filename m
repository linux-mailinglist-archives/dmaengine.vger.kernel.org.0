Return-Path: <dmaengine+bounces-3308-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B29949955C1
	for <lists+dmaengine@lfdr.de>; Tue,  8 Oct 2024 19:35:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7080028B85F
	for <lists+dmaengine@lfdr.de>; Tue,  8 Oct 2024 17:35:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E64BC20B201;
	Tue,  8 Oct 2024 17:34:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WRODlFWZ"
X-Original-To: dmaengine@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6520920ADED;
	Tue,  8 Oct 2024 17:34:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728408889; cv=none; b=QX/9rrDD3dbPO379nmvMxPBSRni1QFZDvi8mxsLMKTlwKAPFaIxMMhTzxzPo7x5rOfPPpOuvGW7pVXyFyLuJCV4suaSZcXYAaV2/tJ+0H3lhrICJjsqNJTYTfQohVKXeC6J9AlcFTM/tF83n9XJADgqsQN5xljApYNJscoqSDDE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728408889; c=relaxed/simple;
	bh=LWWSgceP4b2NC/0ZlJaLRWZ5tS4LiVtbK0mjSJfEAow=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oRxVOAy3xSnTjej9zYYOdeWSU6nLkjPDmLOL7B+tfF4wjbA2AIh6tiYNuxo9YKLheZOI5qN3K1KXypPBAxN0SLuzKA97bj4CUMdlc4kDV8tKyQhPb/1hH2glvoF75f43O411ZRNws4jSR7qrKztJyLge0/LRyxiYyStxiFE/eT0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WRODlFWZ; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1728408888; x=1759944888;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=LWWSgceP4b2NC/0ZlJaLRWZ5tS4LiVtbK0mjSJfEAow=;
  b=WRODlFWZ1WJl8b8c5/Ubqi6MSCT6tiKDMiEMt0OzvvvZySW/tS11NOFu
   GzhbwU1wzCJyfyyn+RfA4GQ4HPWSJgDgb8e7BtAs12RUBiJFmk/CLL14Y
   fhsUD/u1jv2pAIhvNUrJVwGPNj4/vawJ4uLTaZqNahcuzspWc87kESkyG
   XHIh1TMsMnw5i5dHlmaBjJTQ/+f5Y7ZL0jw8FWowUY+KNAlKr/w3m11PF
   2CuwMiq9VRZqXCURo7Kygmkd76sIgSPUmMX3wPmaFYj4Z1yFnWlsUzw/Z
   BH1ibKbbo0OcmWRglcwWt4S1rzJ6S6RoE1Mmfy1fbwy/5ZjutKwmToEXc
   A==;
X-CSE-ConnectionGUID: nCNGfjiRTBeNGYOajGFJqA==
X-CSE-MsgGUID: TJDYri34Q9CoAvJr/9cM7w==
X-IronPort-AV: E=McAfee;i="6700,10204,11219"; a="27510145"
X-IronPort-AV: E=Sophos;i="6.11,187,1725346800"; 
   d="scan'208";a="27510145"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Oct 2024 10:34:11 -0700
X-CSE-ConnectionGUID: xy4Hx6riRemFUqYdFdVEjg==
X-CSE-MsgGUID: cCAzOXxJStCN7+sdvRCcCQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,187,1725346800"; 
   d="scan'208";a="106677525"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmviesa001.fm.intel.com with ESMTP; 08 Oct 2024 10:34:08 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id 19901430; Tue, 08 Oct 2024 20:34:07 +0300 (EEST)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Vinod Koul <vkoul@kernel.org>,
	Paul Cercueil <paul@crapouillou.net>,
	dmaengine@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org
Cc: Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v2 4/4] dmaengine: Unify checks in dma_request_chan()
Date: Tue,  8 Oct 2024 20:27:47 +0300
Message-ID: <20241008173351.2246796-5-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.43.0.rc1.1336.g36b5255a03ac
In-Reply-To: <20241008173351.2246796-1-andriy.shevchenko@linux.intel.com>
References: <20241008173351.2246796-1-andriy.shevchenko@linux.intel.com>
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


