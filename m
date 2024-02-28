Return-Path: <dmaengine+bounces-1159-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 64D9186B969
	for <lists+dmaengine@lfdr.de>; Wed, 28 Feb 2024 21:51:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A4B47B27188
	for <lists+dmaengine@lfdr.de>; Wed, 28 Feb 2024 20:51:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29E9976F00;
	Wed, 28 Feb 2024 20:49:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="F/gkgw7Y"
X-Original-To: dmaengine@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E9BD70043;
	Wed, 28 Feb 2024 20:49:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709153389; cv=none; b=rLt5856WQuBj8mieEEjC43sLL244EwMtjO1Wx4B4+zHO5h29rCNQ8dVjJq6xVWuV2yGHevkYyd+miykkLWRb+xbUWeJ6XnHZHVmWenKjYtBIsC9uku3q4KFFfsBqJb39bR8UhBjDmrKkUKdrX/P6Ch7xXiYtiB4teQYeh/zfKlw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709153389; c=relaxed/simple;
	bh=F4b2geX9W5KhXMqEu52b1/d3qPI5zOp6cxLtiYLUnNE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SqnoIAWR5oJNPkQss2PxqD+CUoxEOce/LfejPiVyWmVzORnozwPwlYOEY+3Byfg8NANbcMN6D2Isf6Lf+JbKxGjWQ2S1RM6fPGHiWjbaYgDUNpfjG3ElsB8g4GB69Y6E9vkJUl8eufVGP1KYfTVJmXs/2YjwVFptJvm6gFs9W6g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=F/gkgw7Y; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709153387; x=1740689387;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=F4b2geX9W5KhXMqEu52b1/d3qPI5zOp6cxLtiYLUnNE=;
  b=F/gkgw7YM9B+7loM2W0xpqJ6jU57HuXvleaDALSY3xUIkht9c2Uqq2if
   1aCwAGj6DK5nwW7qgwzqB/VqHjhle1XB9yMxqu3/x0eiADWoVNNu3rTpm
   sqoeXt2/sj8R2OYBn27EIOl0d0F4FRN4FPoIAzAPHYac+E89ShrkltgIU
   qsOAujLc7sR2VoDzzr82BeHQTz/SyFzcQ/lP+G4RAYwNP7P4w7NKvp/bO
   4mmqY/mOZWHCxcaXViIKhC7OrKpdGUGCmoYE+V2Yy6ofYV+v+DyXCBKDF
   cQ8fJYmxhMjhrrUIzP1S5rmCy1JB/eiFzFT0FbhCv7wz0DJ7XGyPzEN2Y
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10998"; a="3428771"
X-IronPort-AV: E=Sophos;i="6.06,191,1705392000"; 
   d="scan'208";a="3428771"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Feb 2024 12:49:46 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10998"; a="937034664"
X-IronPort-AV: E=Sophos;i="6.06,191,1705392000"; 
   d="scan'208";a="937034664"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 28 Feb 2024 12:49:41 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id 5F749631; Wed, 28 Feb 2024 22:49:34 +0200 (EET)
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
Subject: [PATCH v4 7/8] net-device: Use new helpers from overflow.h in netdevice APIs
Date: Wed, 28 Feb 2024 22:41:37 +0200
Message-ID: <20240228204919.3680786-8-andriy.shevchenko@linux.intel.com>
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
that we can utilize in alloc_netdev_mqs() and netdev_priv(). Do it so.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 include/linux/netdevice.h |  3 ++-
 net/core/dev.c            | 10 +++++-----
 2 files changed, 7 insertions(+), 6 deletions(-)

diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
index c41019f34179..d046dca18854 100644
--- a/include/linux/netdevice.h
+++ b/include/linux/netdevice.h
@@ -25,6 +25,7 @@
 #include <linux/bug.h>
 #include <linux/delay.h>
 #include <linux/atomic.h>
+#include <linux/overflow.h>
 #include <linux/prefetch.h>
 #include <asm/cache.h>
 #include <asm/byteorder.h>
@@ -2668,7 +2669,7 @@ void dev_net_set(struct net_device *dev, struct net *net)
  */
 static inline void *netdev_priv(const struct net_device *dev)
 {
-	return (char *)dev + ALIGN(sizeof(struct net_device), NETDEV_ALIGN);
+	return struct_data_pointer(dev, NETDEV_ALIGN);
 }
 
 /* Set the sysfs physical device reference for the network logical device
diff --git a/net/core/dev.c b/net/core/dev.c
index 69c3e3613372..80b765bb8ba2 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -10859,12 +10859,12 @@ struct net_device *alloc_netdev_mqs(int sizeof_priv, const char *name,
 		return NULL;
 	}
 
-	alloc_size = sizeof(struct net_device);
-	if (sizeof_priv) {
+	if (sizeof_priv)
 		/* ensure 32-byte alignment of private area */
-		alloc_size = ALIGN(alloc_size, NETDEV_ALIGN);
-		alloc_size += sizeof_priv;
-	}
+		alloc_size = struct_size_with_data(p, NETDEV_ALIGN, sizeof_priv);
+	else
+		alloc_size = sizeof(struct net_device);
+
 	/* ensure 32-byte alignment of whole construct */
 	alloc_size += NETDEV_ALIGN - 1;
 
-- 
2.43.0.rc1.1.gbec44491f096


