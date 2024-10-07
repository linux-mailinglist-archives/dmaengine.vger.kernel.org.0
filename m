Return-Path: <dmaengine+bounces-3284-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3153499308A
	for <lists+dmaengine@lfdr.de>; Mon,  7 Oct 2024 17:06:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 62E851C230B3
	for <lists+dmaengine@lfdr.de>; Mon,  7 Oct 2024 15:06:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A4801D90C4;
	Mon,  7 Oct 2024 15:04:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Yl6pZo6W"
X-Original-To: dmaengine@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 752AD1D8A09;
	Mon,  7 Oct 2024 15:04:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728313488; cv=none; b=YArSBYi7+pig4G3Og8tT+2NBzsVSAEpy9xx7xiZ1XUc8JVons9xZ1UGpIJE3/j914BppM6gVsBKbbYHfYVq2I4Ad1R/AhvMt9hgYGxbdz90JKzCszyVY5tTgihMLxLT350m/f4F4SCSSWni7RrxYHZlRVRyc3hn+gKgfweOdJnQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728313488; c=relaxed/simple;
	bh=d24Hu2RJOoM40sVPPDRXUIVnKIl8dW596VcFY5jbpTE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YNCq358VpYUb89ucK86MjvP+ekiUqTGdIJnZ7mf40ILX3UbMEzGzRhAgLOBbunI9rZXWQUqbv1KG01tM50TCuETcXD98qw9jNczT5Ooie5nbU+yigG3am1Aod88YfsXOd3fOn0TfRg/2XwWJ8LMeEH05UudGliTpUfYBRGNcnTM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Yl6pZo6W; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1728313488; x=1759849488;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=d24Hu2RJOoM40sVPPDRXUIVnKIl8dW596VcFY5jbpTE=;
  b=Yl6pZo6W8+StlTvz7iQIIJW303bVBCXFcJArqMJpshf4oFQ02cuRmSVv
   onJSIMB0P9fCrXVWemBhqy0+voY1eSJQNmhUpWoWKoe8C61twxpTkRdgA
   i+pV81/wpNW9sGnz1bLhHBwC7S2gOpZpDG/xrxieI8m4uZrK2X/xX7x8B
   Gix8RD9jVXyKyGsFmhZqbPRpUVwPIDwPGW8n62JPhYay2C4/HqCc7Lt2+
   VmFf9aPM+nLufUfDMs5gX+cYFW/Z7IwyOhmmf9evIbaBgZQkRysqDZlvP
   RrJ9fovhJxVKucLAAVmSt5DiceuHwbNKIYc/+1x4vFDNBhd6HaHXLFiRY
   A==;
X-CSE-ConnectionGUID: T6D2K7RPSZG0uBlkoCXZrA==
X-CSE-MsgGUID: 0NrZLHG9TDy9Q/lCyvgPeQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11218"; a="27559144"
X-IronPort-AV: E=Sophos;i="6.11,184,1725346800"; 
   d="scan'208";a="27559144"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Oct 2024 08:04:45 -0700
X-CSE-ConnectionGUID: IZsAPazmTzyPIPiev799Pw==
X-CSE-MsgGUID: PoEoj8fQRWKIt4zqY8rZVw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,184,1725346800"; 
   d="scan'208";a="106342482"
Received: from black.fi.intel.com ([10.237.72.28])
  by orviesa002.jf.intel.com with ESMTP; 07 Oct 2024 08:04:44 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id DC58227C; Mon, 07 Oct 2024 18:04:41 +0300 (EEST)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	dmaengine@vger.kernel.org
Cc: Jonathan Corbet <corbet@lwn.net>,
	Vinod Koul <vkoul@kernel.org>
Subject: [PATCH v1 1/3] dmaengine: acpi: Drop unused devm_acpi_dma_controller_free()
Date: Mon,  7 Oct 2024 18:03:23 +0300
Message-ID: <20241007150436.2183575-2-andriy.shevchenko@linux.intel.com>
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

After introduction a few years ago the devm_acpi_dma_controller_free()
was never used. Drop it.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 Documentation/driver-api/driver-model/devres.rst |  1 -
 drivers/dma/acpi-dma.c                           | 15 ---------------
 include/linux/acpi_dma.h                         |  4 ----
 3 files changed, 20 deletions(-)

diff --git a/Documentation/driver-api/driver-model/devres.rst b/Documentation/driver-api/driver-model/devres.rst
index 5f2ee8d717b1..f23dbe5d6606 100644
--- a/Documentation/driver-api/driver-model/devres.rst
+++ b/Documentation/driver-api/driver-model/devres.rst
@@ -459,7 +459,6 @@ SERDEV
 
 SLAVE DMA ENGINE
   devm_acpi_dma_controller_register()
-  devm_acpi_dma_controller_free()
 
 SPI
   devm_spi_alloc_master()
diff --git a/drivers/dma/acpi-dma.c b/drivers/dma/acpi-dma.c
index a58a1600dd65..d5beb96ef510 100644
--- a/drivers/dma/acpi-dma.c
+++ b/drivers/dma/acpi-dma.c
@@ -276,21 +276,6 @@ int devm_acpi_dma_controller_register(struct device *dev,
 }
 EXPORT_SYMBOL_GPL(devm_acpi_dma_controller_register);
 
-/**
- * devm_acpi_dma_controller_free - resource managed acpi_dma_controller_free()
- * @dev:	device that is unregistering as DMA controller
- *
- * Unregister a DMA controller registered with
- * devm_acpi_dma_controller_register(). Normally this function will not need to
- * be called and the resource management code will ensure that the resource is
- * freed.
- */
-void devm_acpi_dma_controller_free(struct device *dev)
-{
-	WARN_ON(devres_release(dev, devm_acpi_dma_release, NULL, NULL));
-}
-EXPORT_SYMBOL_GPL(devm_acpi_dma_controller_free);
-
 /**
  * acpi_dma_update_dma_spec - prepare dma specifier to pass to translation function
  * @adma:	struct acpi_dma of DMA controller
diff --git a/include/linux/acpi_dma.h b/include/linux/acpi_dma.h
index 72cedb916a9c..3ef1ec7a04cb 100644
--- a/include/linux/acpi_dma.h
+++ b/include/linux/acpi_dma.h
@@ -65,7 +65,6 @@ int devm_acpi_dma_controller_register(struct device *dev,
 		struct dma_chan *(*acpi_dma_xlate)
 		(struct acpi_dma_spec *, struct acpi_dma *),
 		void *data);
-void devm_acpi_dma_controller_free(struct device *dev);
 
 struct dma_chan *acpi_dma_request_slave_chan_by_index(struct device *dev,
 						      size_t index);
@@ -94,9 +93,6 @@ static inline int devm_acpi_dma_controller_register(struct device *dev,
 {
 	return -ENODEV;
 }
-static inline void devm_acpi_dma_controller_free(struct device *dev)
-{
-}
 
 static inline struct dma_chan *acpi_dma_request_slave_chan_by_index(
 		struct device *dev, size_t index)
-- 
2.43.0.rc1.1336.g36b5255a03ac


