Return-Path: <dmaengine+bounces-1160-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E82A886B96D
	for <lists+dmaengine@lfdr.de>; Wed, 28 Feb 2024 21:52:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 86A371F21DFF
	for <lists+dmaengine@lfdr.de>; Wed, 28 Feb 2024 20:52:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1FDB7D06A;
	Wed, 28 Feb 2024 20:49:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lzvgQX7d"
X-Original-To: dmaengine@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED8A17290F;
	Wed, 28 Feb 2024 20:49:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709153389; cv=none; b=rhP3ApDz/Ut0GxEWgtkJTe3fF/aZ992W+SYgqpgLgDDDg2AAs0dV27FiLS7DlKpFaUjnpaf6PSqDmyM2YlPEVhuEJWAZuXUNdmhfM2Q+pweWhy+qb3IW9OB+lE4sO2tebiU18hy1YQQtFXKWmDun4agWA48TmbOJ7D6D0Tx3MAM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709153389; c=relaxed/simple;
	bh=R9j+Q0D/kA76h1U7UfPAGebwhkhuz8MuAm681KRIxuM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Pwd96xwLoNVNWozv/agsIctPrz9W6rsbSGv9lgeu2evaJvuBJCNdhVjx9K+7KZvgtpz67g+JOujc97Tg88wfAVIN0lem4kaBj9sXYkLKFvurFzQRAxRSMsqG+yfEmX6vV0G/7hZFJsE1OuuzHixBfbe7VkJgWwvLcNi8XbXRegg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lzvgQX7d; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709153388; x=1740689388;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=R9j+Q0D/kA76h1U7UfPAGebwhkhuz8MuAm681KRIxuM=;
  b=lzvgQX7dZu4f6YrJlOMYTKNoU18zl/LQvhBde5z6BP4SO+LBslH0Fvbf
   pL4rbYBwVqNPOZ2JlK3pIQIPJxStuQU8OxlKiZtJMooZUYnUQjHmnKS5R
   E5eMdUm8JMnfhDPGwZUpnJ6KX3UVosgLsfnJsvX20pCNneksEQiVIvrAi
   uhGqLQ+7q6H4zVBdJMDevYpIDSqYhIWIL6yj3QUWYFNSdRF5zR+oNyI9J
   1f58ogcsphCl5RI/q1XoMm7KKUWLPTM1SyEG1/wg2o6+3ndrfm+tbcTDh
   Zbq5Ykk5mqZZSd8S+O5TSysmz/aFpsyWhBxMLubj59+ptIGc4EPeb1Qkp
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10998"; a="3428774"
X-IronPort-AV: E=Sophos;i="6.06,191,1705392000"; 
   d="scan'208";a="3428774"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Feb 2024 12:49:46 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10998"; a="937034662"
X-IronPort-AV: E=Sophos;i="6.06,191,1705392000"; 
   d="scan'208";a="937034662"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 28 Feb 2024 12:49:41 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id 47C0A537; Wed, 28 Feb 2024 22:49:34 +0200 (EET)
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
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	Nuno Sa <nuno.sa@analog.com>
Subject: [PATCH v4 5/8] iio: core: Use new helpers from overflow.h in iio_device_alloc()
Date: Wed, 28 Feb 2024 22:41:35 +0200
Message-ID: <20240228204919.3680786-6-andriy.shevchenko@linux.intel.com>
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

We have two new helpers struct_size_with_data() and struct_data_pointer()
that we can utilize in iio_device_alloc(). Do it so.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Reviewed-by: Nuno Sa <nuno.sa@analog.com>
---
 drivers/iio/industrialio-core.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/iio/industrialio-core.c b/drivers/iio/industrialio-core.c
index 1986b3386307..223013725e32 100644
--- a/drivers/iio/industrialio-core.c
+++ b/drivers/iio/industrialio-core.c
@@ -1644,7 +1644,7 @@ struct iio_dev *iio_device_alloc(struct device *parent, int sizeof_priv)
 	size_t alloc_size;
 
 	if (sizeof_priv)
-		alloc_size = ALIGN(alloc_size, IIO_DMA_MINALIGN) + sizeof_priv;
+		alloc_size = struct_size_with_data(iio_dev_opaque, IIO_DMA_MINALIGN, sizeof_priv);
 	else
 		alloc_size = sizeof(struct iio_dev_opaque);
 
@@ -1655,8 +1655,7 @@ struct iio_dev *iio_device_alloc(struct device *parent, int sizeof_priv)
 	indio_dev = &iio_dev_opaque->indio_dev;
 
 	if (sizeof_priv)
-		indio_dev->priv = (char *)iio_dev_opaque +
-			ALIGN(sizeof(struct iio_dev_opaque), IIO_DMA_MINALIGN);
+		indio_dev->priv = struct_data_pointer(iio_dev_opaque, IIO_DMA_MINALIGN);
 	else
 		indio_dev->priv = NULL;
 
-- 
2.43.0.rc1.1.gbec44491f096


