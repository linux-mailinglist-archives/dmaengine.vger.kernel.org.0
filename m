Return-Path: <dmaengine+bounces-6097-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A7516B2F2E6
	for <lists+dmaengine@lfdr.de>; Thu, 21 Aug 2025 10:53:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 897F717F793
	for <lists+dmaengine@lfdr.de>; Thu, 21 Aug 2025 08:51:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2D7A2EB863;
	Thu, 21 Aug 2025 08:51:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UA1x/1g3"
X-Original-To: dmaengine@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21ACD2E88A6;
	Thu, 21 Aug 2025 08:51:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755766289; cv=none; b=WiKAqOYkKiKQJEyIIAy1YcIjx9QVfmk/pzA9xJ8V/jdbJXj/23Fp/A3L9haIGsKdeJ0LhKh1+JM/SFgH7EWTQjpLsaLBMvD1sA0EBoHZ26LtPEpCqjxLk2pEVLnJ9CkEsZzSEJ4G+8yFTb7SnFfPkB0nk09MX9GO8rg9wFFzNQc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755766289; c=relaxed/simple;
	bh=wKuZrvViRuHAjY1cX/Yoa6yyrpLol8N0P8fA7/XKi9Y=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=r4Q+5vngMRK19cPPjuR4umdaXnKQPEwbb5+biJcE+XFgk/zcKtNHVxg9LDrCaQBiDg+5Un3q4PtieCzG0zmXeJkr3F/QhOZCGyk1QDqyQEhtXnTmyGbnwzz7zbbtHkFmkfYXQERGiSbKfs3V5kH42xv0UivmoDt+ifEIVY8GylQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UA1x/1g3; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1755766288; x=1787302288;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=wKuZrvViRuHAjY1cX/Yoa6yyrpLol8N0P8fA7/XKi9Y=;
  b=UA1x/1g3kWAHxE8u6MaKQ0h4hpG7Ho46HoNrqcNTQSQIUgZXUqoMKH0y
   RveGYz2i1H62Cjt9MkDm8xJbxGUHdNHW0keVYyL6fzd2DbjKdBlW4ea4r
   gLzv7X3gInAjaJKJPdA2lh5xi7B6D6q0j6N1yBMw4/8XUbEen5GPtC+Fh
   VxcL95Uuv36dh100IdLXpdAt100DyVyJ4KmdtbdVLXyTtku401k/DHY5v
   fW0XXEbq06vUiitbZ62nLFy2hBRZ3cixB1nPI/aLBT0TCIyERqvM5lseu
   7zzYLqX5AAovfFtugA7w/cYeP+EGfR6I7+imV+szXC+AThXHKdhTgRB64
   w==;
X-CSE-ConnectionGUID: gm58rEvPRWyX2mlPgwGAUA==
X-CSE-MsgGUID: otczJ8++Tuync/FcrOFQiA==
X-IronPort-AV: E=McAfee;i="6800,10657,11527"; a="61877050"
X-IronPort-AV: E=Sophos;i="6.17,306,1747724400"; 
   d="scan'208";a="61877050"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Aug 2025 01:51:27 -0700
X-CSE-ConnectionGUID: qzJlAJP/TUmKajU1GYelWw==
X-CSE-MsgGUID: O7/9XB2eRlyoeUwFI2Jabw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,306,1747724400"; 
   d="scan'208";a="173624780"
Received: from ysun46-mobl (HELO YSUN46-MOBL..) ([10.239.96.51])
  by fmviesa004.fm.intel.com with ESMTP; 21 Aug 2025 01:51:25 -0700
From: Yi Sun <yi.sun@intel.com>
To: vkoul@kernel.org
Cc: vinicius.gomes@intel.com,
	dave.jiang@intel.com,
	dmaengine@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	yi.sun@intel.com,
	gordon.jin@intel.com,
	fenghuay@nvidia.com,
	yi1.lai@intel.com
Subject: [PATCH v3 0/2] dmaengine: idxd: Add basic DSA 3.0 capability and SGL support
Date: Thu, 21 Aug 2025 16:51:09 +0800
Message-ID: <20250821085111.1430076-1-yi.sun@intel.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch series introduces foundational support for DSA 3.0 features,
exposing hardware capability registers to userspace in the IDXD driver.

DSA 3.0 introduces several new features that require awareness and
configuration from both kernel and userspace. It is necessary to
understand the hardware's capabilities for userspace tools (e.g.,
idxd-config, libraries, and applications) to make use of the features
properly, such as supported features, memory layouts, and opcode
compatibility.

Patch 1/2 exposes the three new capability registers (dsacap0-2)
introduced in the DSA 3.0 specification through a new sysfs entry.
This allows tools and users to query hardware capabilities such as
supported SGL formats, floating-point options, and maximum supported
sizes.

Patch 2/2 enables configuration of the maximum SGL size for DSA 3.0
devices. Some DSA 3.0 opcodes (e.g., Gather Copy, Gather Reduce) require
that the workqueue's SGL size is explicitly configured. This patch sets
that value based on hardware capabilities at initialization time,
allowing these opcodes to function without additional user configuration.

---
Changes in v3:
- Rebased the patch series onto v6.17-rc2 (Vinod)
- Added Tested-by and Acked-by tags

Changes in v2:
- Added the link to the DSA 3.0 spec in the commit message (Dave)
- Fixed typos in the commit messages (Fenghua)
- Updated the sysfs ABI documentation for accuracy (Fenghua)
- Renamed the ABI entry from 'dsacap' to 'dsacaps' (Fenghua, Philip)
- Moved the definition of dsacap0_reg from patch #2 to patch #1 (Fenghua)
- Fixed the output format (Fenghua, Philip)
- Reordered the capability registers to match the DSA 3.0 spec (Fenghua)
- Add conditon checking to avoid accessing dsacaps when DSA 3.0 is not
  supported (Fenghua)

Yi Sun (2):
  dmaengine: idxd: Expose DSA3.0 capabilities through sysfs
  dmaengine: idxd: Add Max SGL Size Support for DSA3.0

 .../ABI/stable/sysfs-driver-dma-idxd          | 15 ++++++++++
 drivers/dma/idxd/device.c                     |  5 ++++
 drivers/dma/idxd/idxd.h                       | 19 +++++++++++++
 drivers/dma/idxd/init.c                       | 11 ++++++++
 drivers/dma/idxd/registers.h                  | 28 ++++++++++++++++++-
 drivers/dma/idxd/sysfs.c                      | 24 ++++++++++++++++
 6 files changed, 101 insertions(+), 1 deletion(-)

-- 
2.43.0


