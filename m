Return-Path: <dmaengine+bounces-6108-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id AB3D2B309BA
	for <lists+dmaengine@lfdr.de>; Fri, 22 Aug 2025 01:00:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 3259C4E1085
	for <lists+dmaengine@lfdr.de>; Thu, 21 Aug 2025 23:00:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 413C42EB5CC;
	Thu, 21 Aug 2025 23:00:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="joO4I71/"
X-Original-To: dmaengine@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A88B2EA46E;
	Thu, 21 Aug 2025 23:00:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755817214; cv=none; b=aQVroCxeO/2YslC7Bj4EAJIQDgp9wuklxt/uu4EjR5UGk39BhfVWFKyZXcVZT/7Zc+MknqPwEhlefoo+48fTFdpGMtO6j3kEtL52aD4lXrSzClYgYQdXjw51k69q9ATzpTFjjFeTl4Nn06rTOflA12XEaGsnJ1T4h6UPhv/3PQU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755817214; c=relaxed/simple;
	bh=jnUpxiVQ2K9IeAsLKQJQuwj4wopCBvx82O8espnIa2U=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=qgBaPs4AERGj7uP2HCnaFlYd4zrNvgVm90xzOXn/EH4mD6o+8iGnXhTbrQFT83J5KmAdNvMoKCx1c0THU7DburkzgYinpqqZLo85I3BcCivPthn31OQxXvLO54QwxowGVSvpbPg73gqRKx561mfQGsd/Emm14K532Z2RLD1qOj0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=joO4I71/; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1755817213; x=1787353213;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=jnUpxiVQ2K9IeAsLKQJQuwj4wopCBvx82O8espnIa2U=;
  b=joO4I71/7SQVVZW69j61A6qkHFEpaXIJ0vN8UA017+p/xNGeY9PZlFxx
   Y16CaoOFCCOJ6NzZcdvv6wVVmei/jimnBADcLT96oBYPGTLmDsVx36wuR
   dcL9LKxFOeF7pOo+LRRw4b9YMoLqN8lO9LA6VfQjx80utMC9wlCmPrF6n
   xDwPLl5lugT1zCImIVr+uikw8vY1RYxzfrtfhSbXziYg5CbfppQQbTRVM
   GSwpHBq6+sqEZECFw39C9jjvMwzYprr75Gu1WGbGChM9h6++C0Np8E4b7
   KdB/0oGXuL3RtGwLH5Yi7OTdvbTwd/uVJVW+o4JdLp7FDjugeyeV8R7MU
   A==;
X-CSE-ConnectionGUID: 2PMWiS0kTeuQePkdHai7rg==
X-CSE-MsgGUID: O0AvZ0cXSf2PfG0ta4U8EQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11529"; a="60748488"
X-IronPort-AV: E=Sophos;i="6.17,309,1747724400"; 
   d="scan'208";a="60748488"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Aug 2025 16:00:10 -0700
X-CSE-ConnectionGUID: xbUIQ4uXRtGY91IDFq9lIw==
X-CSE-MsgGUID: op30307URzOWAke36WRw8w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,309,1747724400"; 
   d="scan'208";a="168444350"
Received: from vcostago-mobl3.jf.intel.com (HELO [10.98.24.157]) ([10.98.24.157])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Aug 2025 16:00:10 -0700
From: Vinicius Costa Gomes <vinicius.gomes@intel.com>
Date: Thu, 21 Aug 2025 15:59:37 -0700
Subject: [PATCH v2 03/10] dmaengine: idxd: Fix possible invalid memory
 access after FLR
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250821-idxd-fix-flr-on-kernel-queues-v3-v2-3-595d48fa065c@intel.com>
References: <20250821-idxd-fix-flr-on-kernel-queues-v3-v2-0-595d48fa065c@intel.com>
In-Reply-To: <20250821-idxd-fix-flr-on-kernel-queues-v3-v2-0-595d48fa065c@intel.com>
To: Dave Jiang <dave.jiang@intel.com>, Vinod Koul <vkoul@kernel.org>, 
 Fenghua Yu <fenghua.yu@intel.com>, Dan Williams <dan.j.williams@intel.com>
Cc: dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Vinicius Costa Gomes <vinicius.gomes@intel.com>
X-Mailer: b4 0.15-dev-2e5ae
X-Developer-Signature: v=1; a=ed25519-sha256; t=1755817209; l=957;
 i=vinicius.gomes@intel.com; s=20230921; h=from:subject:message-id;
 bh=jnUpxiVQ2K9IeAsLKQJQuwj4wopCBvx82O8espnIa2U=;
 b=OkWShZlspGaFjVyeVMuBU0AYuRNqQGr+5PCVQuMXmMNDHGfRSQnhe4M3WTz9IpHY1cAyDR6WI
 Kh4sMCMqvFtB4gxJlUecCrEC7PmXCFJbjPRN026nkS1yOyGYJt3Q9J3
X-Developer-Key: i=vinicius.gomes@intel.com; a=ed25519;
 pk=aJkrtgqgT6TZ8iIHSG8/rTPsmlYnjMrUjCsMYvCzntk=

In the case that the first Function Level Reset (FLR) concludes
correctly, but in the second FLR the scratch area for the saved
configuration cannot be allocated, it's possible for a invalid memory
access to happen.

Always set the deallocated scratch area to NULL after FLR completes.

Fixes: 98d187a98903 ("dmaengine: idxd: Enable Function Level Reset (FLR) for halt")
Reviewed-by: Dave Jiang <dave.jiang@intel.com>
Signed-off-by: Vinicius Costa Gomes <vinicius.gomes@intel.com>
---
 drivers/dma/idxd/init.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/dma/idxd/init.c b/drivers/dma/idxd/init.c
index e9fe5471f722..a5f4c80bf7a6 100644
--- a/drivers/dma/idxd/init.c
+++ b/drivers/dma/idxd/init.c
@@ -1134,6 +1134,7 @@ static void idxd_reset_done(struct pci_dev *pdev)
 	}
 out:
 	kfree(idxd->idxd_saved);
+	idxd->idxd_saved = NULL;
 }
 
 static const struct pci_error_handlers idxd_error_handler = {

-- 
2.50.1


