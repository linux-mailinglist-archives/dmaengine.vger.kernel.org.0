Return-Path: <dmaengine+bounces-1152-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4702986B944
	for <lists+dmaengine@lfdr.de>; Wed, 28 Feb 2024 21:49:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 77ADB1C237DA
	for <lists+dmaengine@lfdr.de>; Wed, 28 Feb 2024 20:49:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB99515D5B7;
	Wed, 28 Feb 2024 20:49:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="meZNFtV5"
X-Original-To: dmaengine@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEF7571ECC;
	Wed, 28 Feb 2024 20:49:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709153383; cv=none; b=m8LSTPq2wBCb7SoxzMBdwHmD4HKdIRMRgjnUljy+EllwmqCQxmYpFEczQ6dPAB8lyLo9Tjsuv5Vu/CToM8NT4KALhZxGdMavdQPhrXDgN5hYI4m7neyJUoww9E2LxjEFeIt/gcMb7UWcdDawxa67/+PuFdmaRBAO4B2zLOZ1qoo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709153383; c=relaxed/simple;
	bh=bSX7yIwX43d/OsXwr5kkmyf++rin8N4VYe4LXrJgvRQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZfKuravMgxafUKTyd1bSNrP7z9CSkQKTfapA3lpVUzW/BS6a5rFcvRwX3NSSpSUrnkbXL6Cn55zjbEHbdOST9st7yM37fMflg64HOWytexJ6YEFrij6IrVaXPP2FM3qwKJNp4KPYgM04gbCUlYekSgRS4yOpPX/WtMxToJ7UJIU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=meZNFtV5; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709153382; x=1740689382;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=bSX7yIwX43d/OsXwr5kkmyf++rin8N4VYe4LXrJgvRQ=;
  b=meZNFtV5g+j2wCZ08yPnnZHrTFvEiDWp9jjC61JRCsnEULFXkiNEavbI
   9jqeyrq5Rk3jXXyXTLchwtDQ815eC6XDhpnM17zuX7pic5EjWRmD+SHI8
   mEkfkJExm+OrXeiIzWEpVd/88roMLXerSGV8nGK06kt6Eb1pPf/OIL4Co
   PbGBZv+/5zIzpp3dunlKn1tvARMViE7499Ehu1YqftNnQGlSrPnr/YKmI
   YldSbMsb6LS+SjwrZty8giyYaQ+g6MJp7kplrA6aj9zfPCjR4KryQdAJZ
   Pxxu5KCkJ4H6NZ71jUX1CeNRCTkPfHrTrr9FMS6HJX/7qw1iii/XCiJ31
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10998"; a="3428674"
X-IronPort-AV: E=Sophos;i="6.06,191,1705392000"; 
   d="scan'208";a="3428674"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Feb 2024 12:49:40 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10998"; a="937034659"
X-IronPort-AV: E=Sophos;i="6.06,191,1705392000"; 
   d="scan'208";a="937034659"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 28 Feb 2024 12:49:35 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id 3AD28524; Wed, 28 Feb 2024 22:49:34 +0200 (EET)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Vinod Koul <vkoul@kernel.org>,
	Linus Walleij <linus.walleij@linaro.org>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Mark Brown <broonie@kernel.org>,
	Kees Cook <keescook@chromium.org>,
	linux-arm-kernel@lists.infradead.org,
	dmaengine@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-iio@vger.kernel.org,
	linux-spi@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-hardening@vger.kernel.org
Cc: Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>
Subject: [PATCH v4 4/8] iio: core: Calculate alloc_size only once in iio_device_alloc()
Date: Wed, 28 Feb 2024 22:41:34 +0200
Message-ID: <20240228204919.3680786-5-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.43.0.rc1.1.gbec44491f096
In-Reply-To: <20240228204919.3680786-1-andriy.shevchenko@linux.intel.com>
References: <20240228204919.3680786-1-andriy.shevchenko@linux.intel.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

No need to rewrite the value, instead use 'else' branch.
This will also help further refactoring the code later on.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/iio/industrialio-core.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/iio/industrialio-core.c b/drivers/iio/industrialio-core.c
index bd305fa87093..1986b3386307 100644
--- a/drivers/iio/industrialio-core.c
+++ b/drivers/iio/industrialio-core.c
@@ -1643,11 +1643,10 @@ struct iio_dev *iio_device_alloc(struct device *parent, int sizeof_priv)
 	struct iio_dev *indio_dev;
 	size_t alloc_size;
 
-	alloc_size = sizeof(struct iio_dev_opaque);
-	if (sizeof_priv) {
-		alloc_size = ALIGN(alloc_size, IIO_DMA_MINALIGN);
-		alloc_size += sizeof_priv;
-	}
+	if (sizeof_priv)
+		alloc_size = ALIGN(alloc_size, IIO_DMA_MINALIGN) + sizeof_priv;
+	else
+		alloc_size = sizeof(struct iio_dev_opaque);
 
 	iio_dev_opaque = kzalloc(alloc_size, GFP_KERNEL);
 	if (!iio_dev_opaque)
-- 
2.43.0.rc1.1.gbec44491f096


