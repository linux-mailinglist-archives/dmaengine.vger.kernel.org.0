Return-Path: <dmaengine+bounces-5451-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 38AD9AD92B8
	for <lists+dmaengine@lfdr.de>; Fri, 13 Jun 2025 18:19:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BFB2F7AB0A3
	for <lists+dmaengine@lfdr.de>; Fri, 13 Jun 2025 16:18:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B016202C4E;
	Fri, 13 Jun 2025 16:19:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DhJeKLpz"
X-Original-To: dmaengine@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2A571A4F12;
	Fri, 13 Jun 2025 16:19:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749831555; cv=none; b=PEwLg9rFsl5DSoZ55wHp5Yh3v/5L62QUgvdCFix9if/FB34I4pVXICp/ard5iV0C5ktflsbzBHwHdbG+u8WnHumALfLIoyFtLnwNQT1FePqibkmFUxTZ5QH4FYAj5lfXjYkatJ9zU5zp4NkzbfkdrBjs+NXDQyr8s5hbpTbGYMc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749831555; c=relaxed/simple;
	bh=L/XF9J7R3jz39bk9YEll2C/WvMDcbohimaoDlBJQT+g=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=BIDI8yY/kk3Hc56s8vfA2a6tXG02T8Jg9DOcCSiWRnGC/cHkfb2uov69yz6eUtu5Hu/+NqcUL2NA+7XE+jHvr2RTVDqmlgWZWr5iWGW0aQ9uMYBKO9qhnJEDlY5/e7d7YIfXE8Y9kJYlpT2hZnFWx7FCJ3q4qpsDLKFBzaO8/yM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DhJeKLpz; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1749831555; x=1781367555;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=L/XF9J7R3jz39bk9YEll2C/WvMDcbohimaoDlBJQT+g=;
  b=DhJeKLpzMIBiJDLycZoy5vCt8D1h4LLzF3RSQVyzbq5aTGcs9FLJLF/1
   qY/MLl8gc5GrYVhuSzDOEsnVMIS/BrXp8h70jar6hrpTZiIBvZBrDxicn
   prN/+weM22stjnxVXz9Z/+Zr/ViBK4N1qwFaezAHmKEaBAaYyUT73/Q7t
   Hk8H3nS+uRgMS4YHqaMfh1327pqXn2XhAzc10bJCrbU/xAwM4H119xKSP
   SXWEC30dxKvbXonMgTRjht79EouplBR88QeqDTU4rRCoYV/2J8n3cDBXe
   41juIqK6k90AK/aoZGs1qh3JifLim8nPqCP3uzry1sBqXkkUDSjIJC6mU
   w==;
X-CSE-ConnectionGUID: jhYe7vnSS8qm5QJplENjtg==
X-CSE-MsgGUID: zk0cnaDyQLaPJO2jUMFpSA==
X-IronPort-AV: E=McAfee;i="6800,10657,11463"; a="52149219"
X-IronPort-AV: E=Sophos;i="6.16,234,1744095600"; 
   d="scan'208";a="52149219"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jun 2025 09:19:14 -0700
X-CSE-ConnectionGUID: bcY7EXy5SPuqueZ6bNA79Q==
X-CSE-MsgGUID: /pTMyZd2Tdy1PYjdU52AiQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,234,1744095600"; 
   d="scan'208";a="147859214"
Received: from ysun46-mobl (HELO YSUN46-MOBL..) ([10.239.96.51])
  by orviesa009.jf.intel.com with ESMTP; 13 Jun 2025 09:19:10 -0700
From: Yi Sun <yi.sun@intel.com>
To: dave.jiang@intel.com,
	vinicius.gomes@intel.com,
	dmaengine@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: yi.sun@intel.com,
	gordon.jin@intel.com,
	fenghuay@nvidia.com,
	anil.s.keshavamurthy@intel.com,
	philip.lantz@intel.com
Subject: [PATCH 0/2] dmaengine: idxd: Add basic DSA 3.0 capability and SGL support
Date: Sat, 14 Jun 2025 00:18:32 +0800
Message-ID: <20250613161834.2912353-1-yi.sun@intel.com>
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

Yi Sun (2):
  dmaengine: idxd: Expose DSA3.0 capabilities through sysfs
  dmaengine: idxd: Add Max SGL Size Support for DSA3.0

 .../ABI/stable/sysfs-driver-dma-idxd          | 15 ++++++++++
 drivers/dma/idxd/device.c                     |  5 ++++
 drivers/dma/idxd/idxd.h                       | 19 +++++++++++++
 drivers/dma/idxd/init.c                       |  9 ++++++
 drivers/dma/idxd/registers.h                  | 28 ++++++++++++++++++-
 drivers/dma/idxd/sysfs.c                      | 27 ++++++++++++++++++
 6 files changed, 102 insertions(+), 1 deletion(-)

-- 
2.43.0


