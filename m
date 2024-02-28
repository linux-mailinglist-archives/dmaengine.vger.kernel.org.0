Return-Path: <dmaengine+bounces-1157-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8214086B95E
	for <lists+dmaengine@lfdr.de>; Wed, 28 Feb 2024 21:51:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1336F1F29F95
	for <lists+dmaengine@lfdr.de>; Wed, 28 Feb 2024 20:51:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5B8472903;
	Wed, 28 Feb 2024 20:49:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UTuIpcQ2"
X-Original-To: dmaengine@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F75C161B5E;
	Wed, 28 Feb 2024 20:49:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709153387; cv=none; b=ji1YIzy2udDDd5L7hUBEfHPX1xUtVP2x5oFI5hZ6HPM9wn2ASvL9/CapDb5a0OmIqKgDEjquK7mLWqYCnUF3QeKy+KAyZe/JG4PLRXvibf8oEtzMvJOXga9NcAoYoMnnKKfyJ1VRtabO08pF0QIa4hDuAy+Mpq9qcaFGMAFNCXs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709153387; c=relaxed/simple;
	bh=fln8BdnmbmK5Zmrs6qz4ah5cZtVSbnFVhGrQ/3X00RA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bR7qa05MAhi3G2dw3jxnruL91zj34tLoh58VHmIAKBJrGhvh2EQtvof3OqaVptcXBPXO5LPN0AdpHqLkX0Z/eZOWXuJbhSvVzvii6WmGQQdLnjm1p3/qmsp/bBn653AjNVhQvAuwDMQZbNoguFylNgIrFCKFFxvA7CnQC2RC2/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UTuIpcQ2; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709153386; x=1740689386;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=fln8BdnmbmK5Zmrs6qz4ah5cZtVSbnFVhGrQ/3X00RA=;
  b=UTuIpcQ230LmuxNDCIdadBUqS+tHM90i9tt8na+4IkYKQFw3HtqNRfz2
   jmsoUS3mKEwHsG66ovYl59pC2pD2HT3ajEpNvx7ZJyiNGOE5keefIplPX
   IQoAOlsvMejxbTM3APXI9YYRNMjK3z8JHSPnX4eI84zfJst/1qiPxzoB0
   L0LYz7yVyvtqYPOBHmubs6pZ8U/ECJ4VcDhJtmYJ6cHsqrSjrYWv6p0wM
   fpY3cR/sOlB0v8J5WTmLzCZ0bIBSneWOF70MC0DT6LHI81IiUZNIrzc1H
   mEm/nh9Isvt1rxRBxzgAPBE+efrR3ZMWoY/elnag/+mak+Bdx4cM6THK2
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10998"; a="3428740"
X-IronPort-AV: E=Sophos;i="6.06,191,1705392000"; 
   d="scan'208";a="3428740"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Feb 2024 12:49:45 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10998"; a="937034661"
X-IronPort-AV: E=Sophos;i="6.06,191,1705392000"; 
   d="scan'208";a="937034661"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 28 Feb 2024 12:49:41 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id 538665F5; Wed, 28 Feb 2024 22:49:34 +0200 (EET)
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
Subject: [PATCH v4 6/8] spi: Use new helpers from overflow.h in __spi_alloc_controller()
Date: Wed, 28 Feb 2024 22:41:36 +0200
Message-ID: <20240228204919.3680786-7-andriy.shevchenko@linux.intel.com>
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
that we can utilize in __spi_alloc_controller(). Do it so.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/spi/spi.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
index ba4d3fde2054..de7a23da58c6 100644
--- a/drivers/spi/spi.c
+++ b/drivers/spi/spi.c
@@ -3089,12 +3089,12 @@ struct spi_controller *__spi_alloc_controller(struct device *dev,
 					      unsigned int size, bool slave)
 {
 	struct spi_controller	*ctlr;
-	size_t ctlr_size = ALIGN(sizeof(*ctlr), dma_get_cache_alignment());
+	int align = dma_get_cache_alignment();
 
 	if (!dev)
 		return NULL;
 
-	ctlr = kzalloc(size + ctlr_size, GFP_KERNEL);
+	ctlr = kzalloc(struct_size_with_data(ctlr, align, size), GFP_KERNEL);
 	if (!ctlr)
 		return NULL;
 
@@ -3114,7 +3114,7 @@ struct spi_controller *__spi_alloc_controller(struct device *dev,
 		ctlr->dev.class = &spi_master_class;
 	ctlr->dev.parent = dev;
 	pm_suspend_ignore_children(&ctlr->dev, true);
-	spi_controller_set_devdata(ctlr, (void *)ctlr + ctlr_size);
+	spi_controller_set_devdata(ctlr, struct_data_pointer(ctlr, align));
 
 	return ctlr;
 }
-- 
2.43.0.rc1.1.gbec44491f096


