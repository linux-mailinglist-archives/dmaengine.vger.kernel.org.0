Return-Path: <dmaengine+bounces-5883-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4552DB14FE6
	for <lists+dmaengine@lfdr.de>; Tue, 29 Jul 2025 17:03:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6AB9A4E59B4
	for <lists+dmaengine@lfdr.de>; Tue, 29 Jul 2025 15:03:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 966951E379B;
	Tue, 29 Jul 2025 15:03:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QaN7KHme"
X-Original-To: dmaengine@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC274195811;
	Tue, 29 Jul 2025 15:03:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753801428; cv=none; b=S3HA+/95CqlkZKPy0o8Bzr4jIIpiydgUEMOEeCTZ2Zj2/44lhueHbTfNEQuSpvPxpLRjOO0OC1P0zkXgFTjkfB8bIcPwqQ3QHwOE5zyPaHnVZyXhVpivhFPn2X5xkNbfyL3riiaj0ZlwqTV7yfsV/KZkZ14FnQIULDfDeEgzAqg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753801428; c=relaxed/simple;
	bh=xuebYECdsdkmXLxozEPMwmdIQi63nyAv31+NWycCDc8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=gbqnVuuec+mtT3jKNGZjSMJuA2tXaLWc1AjsEgcYoxa5t2IQWjHFwlkIgftpkkGN9mPPnnOupJ8L1OXBaXFIP5xEj4a7vx1v709HCJTJ6mjWcaXPrE10P9HqzGGrJZHzYhSRTjStikPswdZvU+LleL2LUsfYczfjNNOr0jL9zpo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QaN7KHme; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1753801427; x=1785337427;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=xuebYECdsdkmXLxozEPMwmdIQi63nyAv31+NWycCDc8=;
  b=QaN7KHme4A6dnAhiWGXJ4kJsV57enXH+XbwGB/j1HNkluMQ/okkUNepT
   EqJ+ffXsVcikVJCQRSJEbvo4E2eZEujT1mIMhiAMuNWRRZCW/7KnIzXp7
   Nqf/H3GJxSIi7PSgfvqnj9g4H691onXBG6phg1iicFL9oFpilGWzNH3uU
   U6wFiWwh7kjZII9STBXArXU8Re8jMa23J7t0RSFXH6gCFdeu6JNLL91uL
   E5kWvCuMr4+fWRgjtgriJqOHa+lCXzsI2A5/HXoUlLzCSn1zNOIp59TMV
   KFaynbXIzE8M/ofVaFGRFz8Aq4gLd1Vt+fjpd11epTRSlfVN5gkKhL6lQ
   g==;
X-CSE-ConnectionGUID: wqMRK5wYQoOob3+Psfcpcw==
X-CSE-MsgGUID: ubG5t/5ORXOhYGUd5TzI3A==
X-IronPort-AV: E=McAfee;i="6800,10657,11506"; a="66643455"
X-IronPort-AV: E=Sophos;i="6.16,349,1744095600"; 
   d="scan'208";a="66643455"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jul 2025 08:03:46 -0700
X-CSE-ConnectionGUID: 67MssSrWTIaF9Jy8qpZw7w==
X-CSE-MsgGUID: 1dpiV5W3SM6MwxIVExukWw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,349,1744095600"; 
   d="scan'208";a="163069679"
Received: from ysun46-mobl (HELO YSUN46-MOBL..) ([10.239.96.51])
  by fmviesa009.fm.intel.com with ESMTP; 29 Jul 2025 08:03:44 -0700
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
Subject: [PATCH RESEND v3 0/2] dmaengine: idxd: Fix refcount and cleanup issues on module unload
Date: Tue, 29 Jul 2025 23:03:11 +0800
Message-ID: <20250729150313.1934101-1-yi.sun@intel.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch series addresses two issues related to the device reference
counting and cleanup path in the idxd driver.

Recent changes introduced improper put_device() calls and duplicated
cleanup logic, leading to refcount underflow and potential use-after-free
during module unload.

Patch 1 removes an unnecessary call to idxd_free(), which could result in a
use-after-free, because the function idxd_conf_device_release already
covers everything done in idxd_free. The newly added idxd_free in commit
90022b3 doesn't resolve any memory leaks, but introduces several duplicated
cleanup.

Patch 2 refactors the cleanup to avoid redundant put_device() calls
introduced in commit a409e919ca3. The existing idxd_unregister_devices()
already handles proper device reference release.

Both patches have been verified on hardware platform.

Both patches have been run through `checkpatch.pl`. Patch 2 gets 1 error
and 1 warning. But these appear to be limitations in the checkpatch script
itself, not reflect issues with the patches.

---
Changes in V3:
- Removed function idxd_disable_sva which got removed recently (Vinicius)
Changes in v2:
- Reworded commit messages supplementing the call traces (Vinicius)
- Explain why the put_device are unnecessary. (Vinicius)

Yi Sun (2):
  dmaengine: idxd: Remove improper idxd_free
  dmaengine: idxd: Fix refcount underflow on module unload

 drivers/dma/idxd/init.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

-- 
2.43.0

