Return-Path: <dmaengine+bounces-1153-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C8F9986B949
	for <lists+dmaengine@lfdr.de>; Wed, 28 Feb 2024 21:50:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5A09B28BC94
	for <lists+dmaengine@lfdr.de>; Wed, 28 Feb 2024 20:50:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE6CB15E5D7;
	Wed, 28 Feb 2024 20:49:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WHpRlOAk"
X-Original-To: dmaengine@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F272B73509;
	Wed, 28 Feb 2024 20:49:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709153384; cv=none; b=HFPYCaFoD4epYujifYltNridZL7HCSBOJsLKv4E19HIvnU8BtXot4HL//A8Ym2udkzHBvHyPOI6RKCyh6Die0zQDrQPjuDAQSIOq5tJbGiAPI4hIKuUIkHNz7dePMaPtJ0yPEthTGdUny/W8/qzYxZkkHgepQb4y/JcfqdWj/oM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709153384; c=relaxed/simple;
	bh=5rz+s7/pr5Tr5G4CC4rkjs7MtaG8CkV7L7yDYm59sps=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=e6v6fCKwrhwRR49m848Oj8CLKSFq76dDpSppXxujxotu7XKyQYRbIh+39XOQim2h8Kiehk87e6noZLTyNn3CH+HQdf57hcXY+OeIdbYovKsWglB+pfXsNRp5kvjEm+F/mNbTAYrU2A9xoQcTkpsscqPzmlftLBZWPRkS2wpplws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WHpRlOAk; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709153383; x=1740689383;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=5rz+s7/pr5Tr5G4CC4rkjs7MtaG8CkV7L7yDYm59sps=;
  b=WHpRlOAkmDNw4JVId5nTg1YIaJ/7ucRNRfetXS9EOwurotohsS2OAG3e
   pHXcwLAX2ul5NMMkbH+5ijjodJPgLcSbD9r0KM5VkAuFcdBJtItM0jlLw
   Loh9WP/UK/+PTo2OVQff4U5kyD35wX4deyB2RC3vJg7QWM0FUOUhCkak2
   6u98T5GAEsusbX185qJAUJ7Fd09ha5lQbwfLEZO2fbRpOjsUe8iUU9L0w
   WUkkTnid0P/qrkUtI5X66eExoCLyiK2nwDjQg93qTspnGaokSRjzQpMtx
   lv/9miu7qEPI0y+kzepwfHAu9nMMPKdah4G3EhhzXs9Z3mdfgCpnHpIdQ
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10998"; a="3428690"
X-IronPort-AV: E=Sophos;i="6.06,191,1705392000"; 
   d="scan'208";a="3428690"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Feb 2024 12:49:40 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10998"; a="937034656"
X-IronPort-AV: E=Sophos;i="6.06,191,1705392000"; 
   d="scan'208";a="937034656"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 28 Feb 2024 12:49:35 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id 1D9D5284; Wed, 28 Feb 2024 22:49:34 +0200 (EET)
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
Subject: [PATCH v4 2/8] overflow: Add struct_size_with_data() and struct_data_pointer() helpers
Date: Wed, 28 Feb 2024 22:41:32 +0200
Message-ID: <20240228204919.3680786-3-andriy.shevchenko@linux.intel.com>
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

Introduce two helper macros to calculate the size of the structure
with trailing aligned data and to retrieve the pointer to that data.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 include/linux/overflow.h | 27 ++++++++++++++++++++++++++-
 1 file changed, 26 insertions(+), 1 deletion(-)

diff --git a/include/linux/overflow.h b/include/linux/overflow.h
index bc390f026128..b93bbf1b6aaa 100644
--- a/include/linux/overflow.h
+++ b/include/linux/overflow.h
@@ -2,9 +2,10 @@
 #ifndef __LINUX_OVERFLOW_H
 #define __LINUX_OVERFLOW_H
 
+#include <linux/align.h>
 #include <linux/compiler.h>
-#include <linux/limits.h>
 #include <linux/const.h>
+#include <linux/limits.h>
 
 /*
  * We need to compute the minimum and maximum values representable in a given
@@ -337,6 +338,30 @@ static inline size_t __must_check size_sub(size_t minuend, size_t subtrahend)
  */
 #define array3_size(a, b, c)	size_mul(size_mul(a, b), c)
 
+/**
+ * struct_size_with_data() - Calculate size of structure with trailing aligned data.
+ * @p: Pointer to the structure.
+ * @a: Alignment in bytes before trailing data.
+ * @s: Data size in bytes (must not be 0).
+ *
+ * Calculates size of memory needed for structure of @p followed by an
+ * aligned data of size @s.
+ *
+ * Return: number of bytes needed or SIZE_MAX on overflow.
+ */
+#define struct_size_with_data(p, a, s)	size_add(ALIGN(sizeof(*(p)), (a)), (s))
+
+/**
+ * struct_data_pointer - Calculate offset of the trailing data reserved with
+ * struct_size_with_data().
+ * @p: Pointer to the structure.
+ * @a: Alignment in bytes before trailing data.
+ *
+ * Return: offset in bytes to the trailing data reserved with
+ * struct_size_with_data().
+ */
+#define struct_data_pointer(p, a)	PTR_ALIGN((void *)((p) + 1), (a))
+
 /**
  * flex_array_size() - Calculate size of a flexible array member
  *                     within an enclosing structure.
-- 
2.43.0.rc1.1.gbec44491f096


