Return-Path: <dmaengine+bounces-5885-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D5A6DB14FED
	for <lists+dmaengine@lfdr.de>; Tue, 29 Jul 2025 17:04:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 46948188C033
	for <lists+dmaengine@lfdr.de>; Tue, 29 Jul 2025 15:04:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C85F62853EA;
	Tue, 29 Jul 2025 15:04:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="d6odanAi"
X-Original-To: dmaengine@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D195288C32;
	Tue, 29 Jul 2025 15:04:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753801442; cv=none; b=HiNR/3fnKax9Rbg1nvxrIXlOeANOojjBops7JwubhVgg4aID2iAnWz163rEObShHBVhtPsww9hIXA+6Xc6RzI84oetrf9xQ/2sTXMCnWVaGTgq1tt8RO8UxKKbaphvF58D22ihj9mzZ0aR9BvQhnFUrq0iVz3TSBTLzEgx079v8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753801442; c=relaxed/simple;
	bh=NDo2MtnREb/2JAL1a20dh5qK/0kehybsC86pu0c1U6U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NOXJd4x9dH0O9omdkmRLMt/8uYWkjSGozbA3dI7lms4Zp5fvu344q3yCCyIvM688qVgtB/om5y7M6gW8MG4CW3f8TgFt2gulBCnNGlwv2FO0tkzHxbH+uUIBzP4bEX2cOadqjo7qB2jujsYMITXppmY99GOLc0HMjIp51UUh26c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=d6odanAi; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1753801441; x=1785337441;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=NDo2MtnREb/2JAL1a20dh5qK/0kehybsC86pu0c1U6U=;
  b=d6odanAiuw/YN9SblYWzLCys2SEzaTdhMehVH7DTk8TEj6nEgmWFkdW+
   oX2WjoM3ViESpsVYjEc/u9FXdatvyfHhaR5fNm1ASRONirBqhM+8xrIOh
   NOASkiz64hax0Iwi2kAD/AUHT6941lG2u9PlxJIXbnH0AgbT5pqRHv9vF
   POn0WBhfca7+n6sOcaoXoonkt+VQvbr7HUf9t+K0zUP/4lSX4XoMnLOSf
   6JvtAHYWgKqrGHZWmPODGeaaj2Bkgsl3yYjzJPk/PY+tcH9pI9+/+QFxC
   tZxJAy85JbfyMXWDTVqiB/LIHNQxcxXu9DDdtG9pwrO4b8WA44Du/FNwn
   w==;
X-CSE-ConnectionGUID: Q/ilcqZsTamSQzI57n4L7Q==
X-CSE-MsgGUID: FA+Z06WCROShhKy3QuXvKg==
X-IronPort-AV: E=McAfee;i="6800,10657,11506"; a="66643485"
X-IronPort-AV: E=Sophos;i="6.16,349,1744095600"; 
   d="scan'208";a="66643485"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jul 2025 08:04:01 -0700
X-CSE-ConnectionGUID: A/XWs6NUTVK/11eKlqr0xw==
X-CSE-MsgGUID: v1b4b8mjQu2qVqiY7Hnycg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,349,1744095600"; 
   d="scan'208";a="163069781"
Received: from ysun46-mobl (HELO YSUN46-MOBL..) ([10.239.96.51])
  by fmviesa009.fm.intel.com with ESMTP; 29 Jul 2025 08:03:59 -0700
From: Yi Sun <yi.sun@intel.com>
To: vinicius.gomes@intel.com,
	vkoul@kernel.org,
	dave.jiang@intel.com,
	fenghuay@nvidia.com,
	xueshuai@linux.alibaba.com
Cc: dmaengine@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	yi.sun@intel.com,
	gordon.jin@intel.com
Subject: [PATCH RESEND v3 2/2] dmaengine: idxd: Fix refcount underflow on module unload
Date: Tue, 29 Jul 2025 23:03:13 +0800
Message-ID: <20250729150313.1934101-3-yi.sun@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250729150313.1934101-1-yi.sun@intel.com>
References: <20250729150313.1934101-1-yi.sun@intel.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A recent refactor introduced a misplaced put_device() call, resulting in a
reference count underflow during module unload.

There is no need to add additional put_device() calls for idxd groups,
engines, or workqueues. Although the commit claims: "Note, this also
fixes the missing put_device() for idxd groups, engines, and wqs."

It appears no such omission actually existed. The required cleanup is
already handled by the call chain:
idxd_unregister_devices() -> device_unregister() -> put_device()

Extend idxd_cleanup() to handle the remaining necessary cleanup and
remove idxd_cleanup_internals(), which duplicates deallocation logic
for idxd, engines, groups, and workqueues. Memory management is also
properly handled through the Linux device model.

Fixes: a409e919ca32 ("dmaengine: idxd: Refactor remove call with idxd_cleanup() helper")
Signed-off-by: Yi Sun <yi.sun@intel.com>
Tested-by: Shuai Xue <xueshuai@linux.alibaba.com>

diff --git a/drivers/dma/idxd/init.c b/drivers/dma/idxd/init.c
index 40cc9c070081..40f4bf446763 100644
--- a/drivers/dma/idxd/init.c
+++ b/drivers/dma/idxd/init.c
@@ -1292,7 +1292,10 @@ static void idxd_remove(struct pci_dev *pdev)
 	device_unregister(idxd_confdev(idxd));
 	idxd_shutdown(pdev);
 	idxd_device_remove_debugfs(idxd);
-	idxd_cleanup(idxd);
+	perfmon_pmu_remove(idxd);
+	idxd_cleanup_interrupts(idxd);
+	if (device_pasid_enabled(idxd))
+		idxd_disable_system_pasid(idxd);
 	pci_iounmap(pdev, idxd->reg_base);
 	put_device(idxd_confdev(idxd));
 	pci_disable_device(pdev);
-- 
2.43.0


