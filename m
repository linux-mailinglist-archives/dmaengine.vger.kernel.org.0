Return-Path: <dmaengine+bounces-1155-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 59EF886B954
	for <lists+dmaengine@lfdr.de>; Wed, 28 Feb 2024 21:50:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0E6D228C050
	for <lists+dmaengine@lfdr.de>; Wed, 28 Feb 2024 20:50:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24341161B75;
	Wed, 28 Feb 2024 20:49:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Y/ITHgv9"
X-Original-To: dmaengine@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5875C15E5B7;
	Wed, 28 Feb 2024 20:49:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709153386; cv=none; b=o2fzdI8b5HG0g8nKKjEYeaTAQDb4qsjbRT+/bAGHLZ7QQNhV6mwA9y31rD5uvXMMem0YyN5gabXLradhf1bCjxzv/NpsfGDhEwUOBPzrnjXVTnss4CXwGIEyIf7ZMCxWwBQGsDQGFKBI4OaWvKIeig+6ccNSy/8Wu06EXlPzZwA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709153386; c=relaxed/simple;
	bh=ChX9iCdEwwQPReQLo1Sn+5tF0+KgHD07SNo+rL4s+7A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ghsZa+7D1cxkcT+0cwbcHfyKsaBf1EoW71HpZf+LSXXPEpztErRU+2GP6xHUtjc5yzCeZ7IxYt3SLLvbZ9D1+Z5iX+DY+BVclAx0XKTNn2Jue+TKvHahkukdaWK1WDEDfpu1jhAbZHvV2Hl4m+8x+gutV5KVvrqjabIM4ZpUcNk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Y/ITHgv9; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709153384; x=1740689384;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ChX9iCdEwwQPReQLo1Sn+5tF0+KgHD07SNo+rL4s+7A=;
  b=Y/ITHgv9+k2jQzkwooRBH/GkgS0d3ftUaXLpRhwrotAT0zoskDVx7jf9
   idC0XvGHvzfPINRwLU+sj8FG3RLc8om2EYUx1uRKdP3vntwVDVoEZ9AVJ
   c07ZcylbXFX801TRLkobEWFbkskeqTOKXm3bjo5tNwMGNQgBA3GvCBmTB
   rzqI7zTRswFvYfc5uXf1Zr5ymcqPuSQIlBuTJYcvb0ADoK/QMBc62UvL6
   Qd2OV5TsnqaipdT4+9yHrn898YqQTQiiM8wBC1BdBXQiTreS0INVIMcvN
   EOSl3bf9JZglh5JgGafIU/iJVlqdiGqmUDJdlqgYqd5G3V10/RMk68AZH
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10998"; a="3428719"
X-IronPort-AV: E=Sophos;i="6.06,191,1705392000"; 
   d="scan'208";a="3428719"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Feb 2024 12:49:40 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10998"; a="937034658"
X-IronPort-AV: E=Sophos;i="6.06,191,1705392000"; 
   d="scan'208";a="937034658"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 28 Feb 2024 12:49:35 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id 2E89B426; Wed, 28 Feb 2024 22:49:34 +0200 (EET)
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
Subject: [PATCH v4 3/8] iio: core: NULLify private pointer when there is no private data
Date: Wed, 28 Feb 2024 22:41:33 +0200
Message-ID: <20240228204919.3680786-4-andriy.shevchenko@linux.intel.com>
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

In iio_device_alloc() when size of the private data is 0,
the private pointer is calculated to behind the valid data.
NULLify it for good.

Fixes: 6d4ebd565d15 ("iio: core: wrap IIO device into an iio_dev_opaque object")
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/iio/industrialio-core.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/industrialio-core.c b/drivers/iio/industrialio-core.c
index 4302093b92c7..bd305fa87093 100644
--- a/drivers/iio/industrialio-core.c
+++ b/drivers/iio/industrialio-core.c
@@ -1654,8 +1654,12 @@ struct iio_dev *iio_device_alloc(struct device *parent, int sizeof_priv)
 		return NULL;
 
 	indio_dev = &iio_dev_opaque->indio_dev;
-	indio_dev->priv = (char *)iio_dev_opaque +
-		ALIGN(sizeof(struct iio_dev_opaque), IIO_DMA_MINALIGN);
+
+	if (sizeof_priv)
+		indio_dev->priv = (char *)iio_dev_opaque +
+			ALIGN(sizeof(struct iio_dev_opaque), IIO_DMA_MINALIGN);
+	else
+		indio_dev->priv = NULL;
 
 	indio_dev->dev.parent = parent;
 	indio_dev->dev.type = &iio_device_type;
-- 
2.43.0.rc1.1.gbec44491f096


