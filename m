Return-Path: <dmaengine+bounces-3282-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C3189993085
	for <lists+dmaengine@lfdr.de>; Mon,  7 Oct 2024 17:06:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EB6FC1C22D47
	for <lists+dmaengine@lfdr.de>; Mon,  7 Oct 2024 15:06:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70EDD1D89FF;
	Mon,  7 Oct 2024 15:04:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MjzEQfvs"
X-Original-To: dmaengine@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79A261D86F0;
	Mon,  7 Oct 2024 15:04:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728313487; cv=none; b=nnJjXTE2/UH6smiQyd/8B3SQSJDfhp2++SxvBH7UKAgmcielHZM6v+sqZn7wsYo0zD2ZFNFHDTWzTdMk4osRcx8x7swoBNZ8WtF/8ppO1Vlc7uC7ym7eB0+u8jWy1qMwkr0JuMFSNUT2HPaQ+WvYaJj4qxXa+Uwcc6b+3xKfBP4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728313487; c=relaxed/simple;
	bh=KJGY5oUBDjsW46vaPrEZIFU5m7FmsPsjEeFfIsxnDf0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hkffInEanGLtJCOUpSkZK/pYx6NDaSb7riyYylO21H9CdciCOjFAbghN6AY7+32HYpQpJblrQR2tGCNp3dBRHWCrJHjBew6dOKF+56qXrhMEsoqFx+yT75AFw4y9zS6BcE7ycNFlwjRG4A349PZ6spiJFzruS6f2YB+zLnhSfqU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MjzEQfvs; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1728313486; x=1759849486;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=KJGY5oUBDjsW46vaPrEZIFU5m7FmsPsjEeFfIsxnDf0=;
  b=MjzEQfvsXY9FLRg4UymY94iAzgZXu02bcN6smRxH+iVd4QrZw6X3or9U
   JFUjEAjTmT+FSxpvtuthCPgdPztSY67jsYi7/UuEIwSsLEb8u9FKcJt11
   FCdGlykCGTxT7/dpZ8+qbkqicMZuY4Ki1z5LVgsJerZ8/OehBQucSdE/N
   VHLlYMNCAEg6HkqWXvCSkZnnRYp7Y7Cj5KMnhpvmor87nP56amTxt8F4z
   HUDParwxwOMKMLGAYfsGgla9QutIg9cDIx1+JKV9u5xml6lSpb74P2n3L
   A4KZ6l3t+8kAvfJqAQ99I8YeH/COjf6VrgrnzAcMH1RLtH/WIBS1vcV4F
   A==;
X-CSE-ConnectionGUID: CnNKpodwRaWDPU7C84oWSA==
X-CSE-MsgGUID: YnC9A11oRbqaczckc75h5w==
X-IronPort-AV: E=McAfee;i="6700,10204,11218"; a="27559140"
X-IronPort-AV: E=Sophos;i="6.11,184,1725346800"; 
   d="scan'208";a="27559140"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Oct 2024 08:04:45 -0700
X-CSE-ConnectionGUID: /Kt3DdR5Tt2GesWcj7gIhQ==
X-CSE-MsgGUID: HWdfjWETQVunGp0+xRivJA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,184,1725346800"; 
   d="scan'208";a="106342480"
Received: from black.fi.intel.com ([10.237.72.28])
  by orviesa002.jf.intel.com with ESMTP; 07 Oct 2024 08:04:44 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id 0033B4FB; Mon, 07 Oct 2024 18:04:41 +0300 (EEST)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	dmaengine@vger.kernel.org
Cc: Jonathan Corbet <corbet@lwn.net>,
	Vinod Koul <vkoul@kernel.org>
Subject: [PATCH v1 3/3] dmaengine: acpi: Clean up headers
Date: Mon,  7 Oct 2024 18:03:25 +0300
Message-ID: <20241007150436.2183575-4-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.43.0.rc1.1336.g36b5255a03ac
In-Reply-To: <20241007150436.2183575-1-andriy.shevchenko@linux.intel.com>
References: <20241007150436.2183575-1-andriy.shevchenko@linux.intel.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

There is a few things done:
- include only the headers we are direct user of
- when pointer is in use, provide a forward declaration
- add missing headers
- sort alphabetically

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/dma/acpi-dma.c   | 13 ++++++++-----
 include/linux/acpi_dma.h |  5 +++--
 2 files changed, 11 insertions(+), 7 deletions(-)

diff --git a/drivers/dma/acpi-dma.c b/drivers/dma/acpi-dma.c
index f594ea265c76..2abbe11e797e 100644
--- a/drivers/dma/acpi-dma.c
+++ b/drivers/dma/acpi-dma.c
@@ -9,18 +9,21 @@
  *	    Mika Westerberg <mika.westerberg@linux.intel.com>
  */
 
+#include <linux/acpi.h>
+#include <linux/acpi_dma.h>
 #include <linux/device.h>
 #include <linux/dma-mapping.h>
 #include <linux/err.h>
-#include <linux/module.h>
+#include <linux/errno.h>
+#include <linux/export.h>
+#include <linux/ioport.h>
 #include <linux/kernel.h>
 #include <linux/list.h>
 #include <linux/mutex.h>
-#include <linux/slab.h>
-#include <linux/ioport.h>
-#include <linux/acpi.h>
-#include <linux/acpi_dma.h>
 #include <linux/property.h>
+#include <linux/slab.h>
+#include <linux/string.h>
+#include <linux/types.h>
 
 static LIST_HEAD(acpi_dma_list);
 static DEFINE_MUTEX(acpi_dma_lock);
diff --git a/include/linux/acpi_dma.h b/include/linux/acpi_dma.h
index 3ef1ec7a04cb..e748b2877602 100644
--- a/include/linux/acpi_dma.h
+++ b/include/linux/acpi_dma.h
@@ -11,10 +11,11 @@
 #ifndef __LINUX_ACPI_DMA_H
 #define __LINUX_ACPI_DMA_H
 
-#include <linux/list.h>
-#include <linux/device.h>
 #include <linux/err.h>
 #include <linux/dmaengine.h>
+#include <linux/types.h>
+
+struct device;
 
 /**
  * struct acpi_dma_spec - slave device DMA resources
-- 
2.43.0.rc1.1336.g36b5255a03ac


