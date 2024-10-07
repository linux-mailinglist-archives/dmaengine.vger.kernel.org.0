Return-Path: <dmaengine+bounces-3283-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CA869993088
	for <lists+dmaengine@lfdr.de>; Mon,  7 Oct 2024 17:06:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 08A331C233D9
	for <lists+dmaengine@lfdr.de>; Mon,  7 Oct 2024 15:06:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C3281D8DF9;
	Mon,  7 Oct 2024 15:04:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="c2uOiJVI"
X-Original-To: dmaengine@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5D531D88C6;
	Mon,  7 Oct 2024 15:04:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728313488; cv=none; b=gmB74RntMgJshv+KM6dves8JHmy1UT5qLzGzI7JJGhcjhlEeEZ9yPPf5yAm3Je2BwGqWde8+2NSvtmZQX16H5SF7X17NNmSk38NuCNhUNSi9EjRtWnd+HA7yFj+A/49M0FEriKMMQbXm/kksiNSuwK0jV7TO7DM+L4/Jpm1pzug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728313488; c=relaxed/simple;
	bh=V6pWj5+cKd5iNf5dSk1Rts8AMVaHwFQZq+XBE2d4NiQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kxvEU9oS2Xb95HxBJyH+lSKcysBDRZZ0e/oGXqXWn2qtyGeO5BzobWjdicsq67FA4Hz1h+xzRKP9o3gubTKN0int6nosLmxiTqtITj9Z+PPkR1FjQ7Bd0dU8/y9/vO7adyeQRKNsGc5M42JUGbrTpgSEIffM+4u+7QXjBLbfHGI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=c2uOiJVI; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1728313487; x=1759849487;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=V6pWj5+cKd5iNf5dSk1Rts8AMVaHwFQZq+XBE2d4NiQ=;
  b=c2uOiJVIjCdV/lRR0ZDVnhCGqV7GH2Bss390JNguXYxe5CbEEMPCSDVG
   yOZClaDNpZWOTc+YCfxExueusKSdyVnKiw/4lZa5/j9CBa1nkO5AGKLbd
   N6tbGGLKGnpCpk3D26d9y/WZic5kWUM1FHsIxia1A3cA+MliGEZYB5fUj
   T6Ky8rsK+VsbeHUA4MH+M/uduqTgAXXyesdPmHdXUAPuje+wy4zHp5uXB
   TJhmBf/Y56miqMS2a+dnBn3bYjNQJ8WKee8g/nDMSamJtEyfK28nggbTb
   tc5awDYTV4JSqSE8ZS55fI1flTDFJ+OchfcxBcViO0tjUID7INSoPBcTC
   g==;
X-CSE-ConnectionGUID: 70V6lp0/Qbeh+0PLSEEDYw==
X-CSE-MsgGUID: I/4/bavLRPyVT4T6soFt3g==
X-IronPort-AV: E=McAfee;i="6700,10204,11218"; a="27593252"
X-IronPort-AV: E=Sophos;i="6.11,184,1725346800"; 
   d="scan'208";a="27593252"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Oct 2024 08:04:45 -0700
X-CSE-ConnectionGUID: rlfJYJJ1TwmZgV+RFD5t/Q==
X-CSE-MsgGUID: lhrCYT82R56GTWHaJAaboQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,184,1725346800"; 
   d="scan'208";a="75463529"
Received: from black.fi.intel.com ([10.237.72.28])
  by orviesa009.jf.intel.com with ESMTP; 07 Oct 2024 08:04:43 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id E18A237D; Mon, 07 Oct 2024 18:04:41 +0300 (EEST)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	dmaengine@vger.kernel.org
Cc: Jonathan Corbet <corbet@lwn.net>,
	Vinod Koul <vkoul@kernel.org>
Subject: [PATCH v1 2/3] dmaengine: acpi: Simplify devm_acpi_dma_controller_register()
Date: Mon,  7 Oct 2024 18:03:24 +0300
Message-ID: <20241007150436.2183575-3-andriy.shevchenko@linux.intel.com>
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

Use devm_add_action_or_reset() instead of devres_alloc() and
devres_add(), which works the same. This will simplify the
code. There is no functional changes.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/dma/acpi-dma.c | 15 ++++-----------
 1 file changed, 4 insertions(+), 11 deletions(-)

diff --git a/drivers/dma/acpi-dma.c b/drivers/dma/acpi-dma.c
index d5beb96ef510..f594ea265c76 100644
--- a/drivers/dma/acpi-dma.c
+++ b/drivers/dma/acpi-dma.c
@@ -236,7 +236,7 @@ int acpi_dma_controller_free(struct device *dev)
 }
 EXPORT_SYMBOL_GPL(acpi_dma_controller_free);
 
-static void devm_acpi_dma_release(struct device *dev, void *res)
+static void devm_acpi_dma_free(void *dev)
 {
 	acpi_dma_controller_free(dev);
 }
@@ -259,20 +259,13 @@ int devm_acpi_dma_controller_register(struct device *dev,
 		(struct acpi_dma_spec *, struct acpi_dma *),
 		void *data)
 {
-	void *res;
 	int ret;
 
-	res = devres_alloc(devm_acpi_dma_release, 0, GFP_KERNEL);
-	if (!res)
-		return -ENOMEM;
-
 	ret = acpi_dma_controller_register(dev, acpi_dma_xlate, data);
-	if (ret) {
-		devres_free(res);
+	if (ret)
 		return ret;
-	}
-	devres_add(dev, res);
-	return 0;
+
+	return devm_add_action_or_reset(dev, devm_acpi_dma_free, dev);
 }
 EXPORT_SYMBOL_GPL(devm_acpi_dma_controller_register);
 
-- 
2.43.0.rc1.1336.g36b5255a03ac


