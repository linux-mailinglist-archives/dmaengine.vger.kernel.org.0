Return-Path: <dmaengine+bounces-7105-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 586D8C45753
	for <lists+dmaengine@lfdr.de>; Mon, 10 Nov 2025 09:54:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4878C3B3D3B
	for <lists+dmaengine@lfdr.de>; Mon, 10 Nov 2025 08:54:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 730262FD7A5;
	Mon, 10 Nov 2025 08:53:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Cxicmgdv"
X-Original-To: dmaengine@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C986E2F8BCD;
	Mon, 10 Nov 2025 08:53:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762764834; cv=none; b=KHD3bAyn+KiyJa7S4rovMf6yjCr8Rz50Ghp5z8lFPZveK34m+w1ZuCf739gL8xCF4CBrIgyzw9Y6K40UbQjwVb0B4JcyHm2n6RsxHemC41OimEpI255fjv0wSPHlbjMpaHGQUyeM9JgViSjb7sWQvlvbsJaPsXTdtZJbVacc/tI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762764834; c=relaxed/simple;
	bh=qwht3GzK11wQ8hpSg6RKkjg8kNqA3LIUGM0DR5z5u2A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aIXjWzlL/oh4+NgVSZ5vfFKWYGRdnYKziUUNAi8qbl5gEex+uyDUJCV1o/94F0R6PzYPG9ZnNoGAUtF3J3J/ZsJz8hQnfO5UIS0Ifx4KoSYzVhzXAFUsttiVedQVI1kf3sYiHlUm8FRxke69w5msGLnu+I7ycVK+T5BYCYfJL78=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Cxicmgdv; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1762764832; x=1794300832;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=qwht3GzK11wQ8hpSg6RKkjg8kNqA3LIUGM0DR5z5u2A=;
  b=CxicmgdvZYzlRTER+7w5ovS+gIrpKmil3CzpxAuhhB5eN88u7QKr12Xx
   HDXtwSgGlLSckmFWjnCaEE/nHSj6MAQYJzyraMsi5/aUMDjifRdvHCPZT
   MVJ3Dmp0M3uky9bcSmMnXGwY+EPBa1ukGpysaIp4h87//4MUjTM5FYWr2
   ne6T9BOqZR5uCM0nMsUNmS53GBjy0rROObHKey7CbFfm/xpPp5fh1vg4u
   Y6tShqFAYFvLPiNdq15tRPSZUbkwyJiNYwZ9bAWMVbAT813Jt1mWwqd4n
   wZ1ov/2naVNdVnBalsRPEt2IrM54S7EihhGlz32PkM/Iq5UCN4aB8mz4W
   w==;
X-CSE-ConnectionGUID: QyJSBxITTLeDJQ1hHkRhcQ==
X-CSE-MsgGUID: K+qudybDRlKnALkrd8iGnw==
X-IronPort-AV: E=McAfee;i="6800,10657,11608"; a="64017089"
X-IronPort-AV: E=Sophos;i="6.19,293,1754982000"; 
   d="scan'208";a="64017089"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Nov 2025 00:53:52 -0800
X-CSE-ConnectionGUID: o9AiBZPKRO2n8vqBDBx1lg==
X-CSE-MsgGUID: fzkoiaKCQTmzb1KC7Hjptg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,293,1754982000"; 
   d="scan'208";a="188575529"
Received: from black.igk.intel.com ([10.91.253.5])
  by orviesa007.jf.intel.com with ESMTP; 10 Nov 2025 00:53:51 -0800
Received: by black.igk.intel.com (Postfix, from userid 1003)
	id 28F7E97; Mon, 10 Nov 2025 09:53:50 +0100 (CET)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	dmaengine@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Vinod Koul <vkoul@kernel.org>
Subject: [PATCH v2 2/3] dmaengine: Use device_match_of_node() helper
Date: Mon, 10 Nov 2025 09:47:44 +0100
Message-ID: <20251110085349.3414507-3-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20251110085349.3414507-1-andriy.shevchenko@linux.intel.com>
References: <20251110085349.3414507-1-andriy.shevchenko@linux.intel.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Instead of open coding, use device_match_of_node() helper.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/dma/dmaengine.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/dma/dmaengine.c b/drivers/dma/dmaengine.c
index eb27a72cd4c5..e89280587d5d 100644
--- a/drivers/dma/dmaengine.c
+++ b/drivers/dma/dmaengine.c
@@ -765,7 +765,7 @@ struct dma_chan *__dma_request_channel(const dma_cap_mask_t *mask,
 	mutex_lock(&dma_list_mutex);
 	list_for_each_entry_safe(device, _d, &dma_device_list, global_node) {
 		/* Finds a DMA controller with matching device node */
-		if (np && device->dev->of_node && np != device->dev->of_node)
+		if (np && !device_match_of_node(device->dev, np))
 			continue;
 
 		chan = find_candidate(device, mask, fn, fn_param);
-- 
2.50.1


