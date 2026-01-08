Return-Path: <dmaengine+bounces-8096-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EE66D00706
	for <lists+dmaengine@lfdr.de>; Thu, 08 Jan 2026 01:03:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 2C4843001FE8
	for <lists+dmaengine@lfdr.de>; Thu,  8 Jan 2026 00:03:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A0FB3D76;
	Thu,  8 Jan 2026 00:03:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ESuM1qR5"
X-Original-To: dmaengine@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A149D20311;
	Thu,  8 Jan 2026 00:03:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767830584; cv=none; b=Yn+l6peif6z/b+EE7HL0JneCHeB7JANNlj6laqPvUR0/Hqyhs+epAevQR7V9XQO3SfSHE3M6+qVvMU3cWTg8PELxYSv3K/senPaOFUxpkUWAGevREGeFpSCeUB0DjOiQcX0Acmyg6fRxG1OnBlHNgPpxPwxlOZ5IkTpcL6aD9Z0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767830584; c=relaxed/simple;
	bh=k2r9TxWGolnWBMH/hT2rWaNuuU/FH0Ny6P1h+avfF4c=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=NMhIc05PRBqTjAqD+xlVEBm1FVOqMRRP+uA4x2AmjcgyvRHExccxW5q0Tdfyk5k+tEKdI7FBULDmoW74ntCmL33W2gI3BcHJiqEoHWBG08OLyVuBD6ilgAP33KxJwn9mn13Iccb0XUE6/5tPVTjRnzQVdnEyAvUo7ZKNRq2H7BI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ESuM1qR5; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1767830582; x=1799366582;
  h=from:subject:date:message-id:mime-version:
   content-transfer-encoding:to:cc;
  bh=k2r9TxWGolnWBMH/hT2rWaNuuU/FH0Ny6P1h+avfF4c=;
  b=ESuM1qR50T+AR3N2XBc9WzNCvumv7hQBiEdtGnkiZ1s24i0pnlUHM30I
   3HERWjZqdjEPBkhGc0Mu+BLsxLn/NjcvZ495990QolRaMQUeqJHQFcIK4
   nuaMZHHwky1JMLIllmYHDLbz0nE2U+Hb4GB0DA0pns1OEaBZs6lsldfJh
   635UHOVZItiIsfHTCvhe5v1ZDZiasfKjqdRVumFH7/V0gBE+b7jB10ZNK
   f0YnfNYiLO3wdHdOBrwPGspj/uAZQmMp8o7rmmMyIgkS1gk+jAxf4+Kfa
   iaGbxfT1JCSyGbyCRNqDtGm+TilojhejJ10dFLjr3qG1VshUgE8sep8//
   Q==;
X-CSE-ConnectionGUID: 6tJ0NYcMRH6FrN3NSCbtXw==
X-CSE-MsgGUID: gtkn7xU4TjWn/aQCTJ3xEQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11664"; a="68214633"
X-IronPort-AV: E=Sophos;i="6.21,209,1763452800"; 
   d="scan'208";a="68214633"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jan 2026 16:03:00 -0800
X-CSE-ConnectionGUID: eyfINGbYQ0y+/5FwIJi3PQ==
X-CSE-MsgGUID: FFTCwjpgQ32cIK2tO0LU4Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,209,1763452800"; 
   d="scan'208";a="203074577"
Received: from vcostago-desk1.jf.intel.com (HELO [10.88.27.144]) ([10.88.27.144])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jan 2026 16:03:01 -0800
From: Vinicius Costa Gomes <vinicius.gomes@intel.com>
Subject: [PATCH RESEND v2 0/2] dmaengine: idxd: Add basic DSA 3.0
 capability and SGL support
Date: Wed, 07 Jan 2026 16:02:21 -0800
Message-Id: <20260107-idxd-yi-sun-dsa3-sgl-size-v2-0-dbef8f559e48@intel.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAA70XmkC/yXMMQ+CMBCG4b9CbvaStsSGOMvqoCNxqNyBZ0wxP
 SEo4b9bdXy+5HsXUE7CCrtigcSTqAwxw20KaK8h9oxC2eCM88aabeZM+BLUMSJpKFH7O6q8GUt
 LVFUcOm895P8jcSfzr93AsT7Vhz2c/7uOlxu3z28Y1vUDEJAujoUAAAA=
X-Change-ID: 20260105-idxd-yi-sun-dsa3-sgl-size-31dd88eaf616
To: Vinicius Costa Gomes <vinicius.gomes@intel.com>, 
 Dave Jiang <dave.jiang@intel.com>, Vinod Koul <vkoul@kernel.org>
Cc: linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org, 
 Yi Sun <yi.sun@intel.com>, 
 Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>, 
 Yi Lai <yi1.lai@intel.com>
X-Mailer: b4 0.15-dev-47773
X-Developer-Signature: v=1; a=ed25519-sha256; t=1767830580; l=2686;
 i=vinicius.gomes@intel.com; s=20230921; h=from:subject:message-id;
 bh=k2r9TxWGolnWBMH/hT2rWaNuuU/FH0Ny6P1h+avfF4c=;
 b=lH2Wz+bMIG6G1KTp/HYM0ZldsQTPFln1AtZOSEvTvCRjc3NpL+seZcvPwElLUye3WCa+qUOc3
 +7E5to5m4i3Diii4cZF+qQ+csuIWjWdrF9EvcHKoCN4F3dS7LdlE9nD
X-Developer-Key: i=vinicius.gomes@intel.com; a=ed25519;
 pk=aJkrtgqgT6TZ8iIHSG8/rTPsmlYnjMrUjCsMYvCzntk=

Note: Marking as "resend" because the only modifications are the
"Date" and "KernelVersion" in the sysfs docs.

Original cover letter:

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

Signed-off-by: Vinicius Costa Gomes <vinicius.gomes@intel.com>

---
Yi Sun (2):
      dmaengine: idxd: Expose DSA3.0 capabilities through sysfs
      dmaengine: idxd: Add Max SGL Size Support for DSA3.0

 Documentation/ABI/stable/sysfs-driver-dma-idxd | 15 ++++++++++++++
 drivers/dma/idxd/device.c                      |  5 +++++
 drivers/dma/idxd/idxd.h                        | 19 +++++++++++++++++
 drivers/dma/idxd/init.c                        | 11 ++++++++++
 drivers/dma/idxd/registers.h                   | 28 +++++++++++++++++++++++++-
 drivers/dma/idxd/sysfs.c                       | 24 ++++++++++++++++++++++
 6 files changed, 101 insertions(+), 1 deletion(-)
---
base-commit: 8049f77fd820f47a2727c805de629a7433538eab
change-id: 20260105-idxd-yi-sun-dsa3-sgl-size-31dd88eaf616

Best regards,
--  
Vinicius


