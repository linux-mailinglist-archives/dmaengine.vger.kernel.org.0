Return-Path: <dmaengine+bounces-8182-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A476DD0BB64
	for <lists+dmaengine@lfdr.de>; Fri, 09 Jan 2026 18:38:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id DA381304D37F
	for <lists+dmaengine@lfdr.de>; Fri,  9 Jan 2026 17:37:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71F79366DB5;
	Fri,  9 Jan 2026 17:37:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="iff+aePL"
X-Original-To: dmaengine@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D258A366DCF;
	Fri,  9 Jan 2026 17:37:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767980249; cv=none; b=I0ke74ugn+4yVdn/akHkcY9v0eLoFh/EPn9rngPkv7wwILwV67whRDz9d7leBPIk6DtDdqCTrV+IrajriGER20YOPtmCSwbKNuWOZnXZniiOHH7QmlnKzqZOxIXxJplHebfqPNw2rINvn6W4N/W5EEHz7NovpZblpZl+3OveLrw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767980249; c=relaxed/simple;
	bh=EDHl58cqFLie6AeoM5NdNk10ubUnwvftI6wFbkK3zmw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=E52U+M13iZdASQWgmbjT9E7zw+tE0mhw4e9Txwi96BF3+TG9uin3es4XPY+faOwrp6CcftB8915mjtHnJpLgoTUceo48uuK2o+P7u+l6tLs8gOErViHWTz9NErbtR0+kSZDygVWnTQvRrORWkuSuSHFfVeCOjrJqji7t1nKsgaQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=iff+aePL; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1767980247; x=1799516247;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=EDHl58cqFLie6AeoM5NdNk10ubUnwvftI6wFbkK3zmw=;
  b=iff+aePLAoKy3P4A6E2H9s5Sxl4ZhNo/CzDRD0gqPEMntXmqXgy6a/dd
   bWjLuh9NbgQO+kkfkbv/EMfFqtKUKHfsAajRLhomUsPIg6ohSYiJtDnKC
   fYIR5DkhjhG5GM8koO8xc9ge2kKIEwA+WdfoaPcfhCw4NidGrTSEKjS4X
   qI+1xauMSZhPqngfybNrmTUAUa4LQms6zTqecfwPgkDwSkcK2uo/1VPoi
   TqV2xfOL162iPfEYsvWqYP4rBQiRvM7yubCIfZn7nLAPT9Jw7OJ22y7Rd
   hHqkAs7joLJlviIMCPd0EizzrlRBZbgOM6/BBddDw7ZiQ87eGTIS2KA3Y
   A==;
X-CSE-ConnectionGUID: edCto1tnS/elQWH+jsaVhA==
X-CSE-MsgGUID: foElOl7RSBmnaAYLatiH+w==
X-IronPort-AV: E=McAfee;i="6800,10657,11666"; a="69296540"
X-IronPort-AV: E=Sophos;i="6.21,214,1763452800"; 
   d="scan'208";a="69296540"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jan 2026 09:37:21 -0800
X-CSE-ConnectionGUID: TVhZ19RzT4+bFNTZKqjYzg==
X-CSE-MsgGUID: Rs9E4/vkQzmA8ON1ZlWiLg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,214,1763452800"; 
   d="scan'208";a="204318499"
Received: from black.igk.intel.com ([10.91.253.5])
  by fmviesa010.fm.intel.com with ESMTP; 09 Jan 2026 09:37:20 -0800
Received: by black.igk.intel.com (Postfix, from userid 1003)
	id 3A1F999; Fri, 09 Jan 2026 18:37:19 +0100 (CET)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	dmaengine@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Vinod Koul <vkoul@kernel.org>
Subject: [PATCH v3 2/3] dmaengine: Use device_match_of_node() helper
Date: Fri,  9 Jan 2026 18:35:42 +0100
Message-ID: <20260109173718.3605829-3-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260109173718.3605829-1-andriy.shevchenko@linux.intel.com>
References: <20260109173718.3605829-1-andriy.shevchenko@linux.intel.com>
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
index 8fe552c74eb8..ca1723a34779 100644
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


