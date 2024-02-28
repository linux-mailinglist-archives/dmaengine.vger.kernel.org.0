Return-Path: <dmaengine+bounces-1156-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4142586B959
	for <lists+dmaengine@lfdr.de>; Wed, 28 Feb 2024 21:50:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EFAAB28C2BD
	for <lists+dmaengine@lfdr.de>; Wed, 28 Feb 2024 20:50:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE6507002B;
	Wed, 28 Feb 2024 20:49:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XyqdnPOP"
X-Original-To: dmaengine@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D00915E5DD;
	Wed, 28 Feb 2024 20:49:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709153386; cv=none; b=tI9w45675iuATpmJW7Cn16uKal7ZdmNR2+YEkyzNyD4F5fBNU9cheL9aMmU4cVF9NyxFR09VVafurXp0vpEsh3sHR8DUz9KAeVH4Che6gw+0SLTNaoKjXKjGmwqMfaRUlSzYvVb4i5MdK6+MQ2/RawDeqAI9m4r7pzoBDVoKprQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709153386; c=relaxed/simple;
	bh=E3/6TZHqz4QzVouyFU4/0yUH2cIdu7rmw3fp5xSFDhI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=j4kCB5nZBkKCeDWqG2aMuiFQdYhYfcbcImtoIgK4p+ChHBdwH9MMy0WYOxNnCSGOTh69dykdmxJkOuNyUTqnpjCOTSq/Egd4q5Y14UkMddgvFnZ0T8WGaw8sIxOjhHmVlFF5V1Od99eaisro+uCOSabw1u98arVXlGq1ZqyhMSM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XyqdnPOP; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709153385; x=1740689385;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=E3/6TZHqz4QzVouyFU4/0yUH2cIdu7rmw3fp5xSFDhI=;
  b=XyqdnPOPTr+1yiY8sg4u81oaK4a85KqOgMyO/fe225KNkHqdBoqotuQa
   olsBOSF86OKAzGipD6PW9j7kCVzNcfSxbOzpNFXOZI2fF136Zh32t3P0P
   X1lf76/TI89OxoXzXy0756W15rLINNL9W5ewIS+ZaZKmTlZvAWoFRGMXt
   yNIyhmvuqLCKR7+/7uRL1QTuRIV2pljxVXAcJxnjeiaaw2qV/9t5kWXyx
   NPPrgyW+yCIrbnv0xmsLQh7IEWMatB4jiFIdxUyppCGqFhXoKMvc+YEBK
   e0hJ8wwzsBUhwg5GCGhL9+LugBbpZX+Y5c4rv+0J10iD0PFeKhCsHF3E3
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10998"; a="3428721"
X-IronPort-AV: E=Sophos;i="6.06,191,1705392000"; 
   d="scan'208";a="3428721"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Feb 2024 12:49:41 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10998"; a="937034660"
X-IronPort-AV: E=Sophos;i="6.06,191,1705392000"; 
   d="scan'208";a="937034660"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 28 Feb 2024 12:49:35 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id 0BAAD192; Wed, 28 Feb 2024 22:49:34 +0200 (EET)
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
Subject: [PATCH v4 1/8] overflow: Use POD in check_shl_overflow()
Date: Wed, 28 Feb 2024 22:41:31 +0200
Message-ID: <20240228204919.3680786-2-andriy.shevchenko@linux.intel.com>
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

The check_shl_overflow() uses u64 type that is defined in types.h.
Instead of including that header, just switch to use POD type
directly.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 include/linux/overflow.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/overflow.h b/include/linux/overflow.h
index dede374832c9..bc390f026128 100644
--- a/include/linux/overflow.h
+++ b/include/linux/overflow.h
@@ -197,7 +197,7 @@ static inline bool __must_check __must_check_overflow(bool overflow)
 	typeof(a) _a = a;						\
 	typeof(s) _s = s;						\
 	typeof(d) _d = d;						\
-	u64 _a_full = _a;						\
+	unsigned long long _a_full = _a;				\
 	unsigned int _to_shift =					\
 		is_non_negative(_s) && _s < 8 * sizeof(*d) ? _s : 0;	\
 	*_d = (_a_full << _to_shift);					\
-- 
2.43.0.rc1.1.gbec44491f096


