Return-Path: <dmaengine+bounces-5325-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BDF84AD0D86
	for <lists+dmaengine@lfdr.de>; Sat,  7 Jun 2025 15:06:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CBAF23AD6BB
	for <lists+dmaengine@lfdr.de>; Sat,  7 Jun 2025 13:06:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E788020CCED;
	Sat,  7 Jun 2025 13:06:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ExUtRFb6"
X-Original-To: dmaengine@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F28E1CA5A;
	Sat,  7 Jun 2025 13:06:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749301586; cv=none; b=ew3rXNdTFR1wlMoNbHRrP9D3YsMCm+DvLFED7dIj+Xauc57BZVd8UgtK66mrNwdUb6nmOx+Ep6s8P/UqigQZN8MRwmak42JHvXvOh7bpDm4TalMKHp4akO/LCp5vhPV+cBbayXDwf/mF0kKJnR1IFSWEoFj9grFkL39KwFVN+rk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749301586; c=relaxed/simple;
	bh=Y57lSQnZNK8/F6EEIhYJDWEIE7sOJBCODtzIKvw+xSA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=CVUj4ZWlAhK67NUnm61UJwMagtnfwRLyIWEUl3cO2yEMPFHk0SRp4dOZK2P5kSZu8Orlh8cc/PFPg8EyV87gfC3rbG0iZ2Hv8oR7IQxLjxBggdZw35xKApuTw4dWzilkwjN51KLwTw2DWU9rAzzZlPMXcT3TXoIZQdtMlm7LGSE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ExUtRFb6; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1749301585; x=1780837585;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=Y57lSQnZNK8/F6EEIhYJDWEIE7sOJBCODtzIKvw+xSA=;
  b=ExUtRFb63afQbX1GGfvNNP5nZJDzst+rNipRigHlY/G/a2HNfDXEXcPJ
   vReLXuNhZ3K1C9Vgf6EbIXGVJQ2rWuMJ0oLz5QqxfE00Oa9z+BLfenigV
   LJHUOscjZvWRhg/2d3XHVJblDGyUv8X4F/IBuhmWJTUwnUtChiSy8yTk0
   vgq+ptvFAOe0ilVKTMiTFi3cpgqozxLIkORwa85joNQ8mcYag7ttYyPFV
   YSr2VNEPnQJcA80zHIeq8i63cWqJNM+p3y/C3UXGjVixBPnSWhwP5dpZA
   Joct+ax3GDY5W4J1dvxBt7K38e/WiQwip9KL2AgmCLgAItTqXgj4AioUw
   w==;
X-CSE-ConnectionGUID: CJCEx8zuQ8O55Zs0uL8DlA==
X-CSE-MsgGUID: +wtAGFJWTl2VYGgRSUwJ6w==
X-IronPort-AV: E=McAfee;i="6800,10657,11457"; a="55242773"
X-IronPort-AV: E=Sophos;i="6.16,218,1744095600"; 
   d="scan'208";a="55242773"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jun 2025 06:06:25 -0700
X-CSE-ConnectionGUID: HtC6G8GhTSygAq5V/S/nVg==
X-CSE-MsgGUID: 9X5CjBmUQbqXDrMwcNkt7Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,218,1744095600"; 
   d="scan'208";a="151074654"
Received: from ysun46-mobl (HELO YSUN46-MOBL..) ([10.239.96.51])
  by orviesa004.jf.intel.com with ESMTP; 07 Jun 2025 06:06:23 -0700
From: Yi Sun <yi.sun@intel.com>
To: vinicius.gomes@intel.com,
	dmaengine@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: yi.sun@intel.com,
	gordon.jin@intel.com
Subject: [PATCH v2 0/2] dmaengine: idxd: Fix refcount and cleanup issues on module unload
Date: Sat,  7 Jun 2025 21:06:14 +0800
Message-ID: <20250607130616.514984-1-yi.sun@intel.com>
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
use-after-free when paired with asynchronous put_device().

Patch 2 refactors the cleanup path to avoid redundant put_device() calls
introduced in commit a409e919ca3. The existing idxd_unregister_devices()
already handles proper device reference release.

Both patches have been verified on hardware platform.

Both patches have been run through `checkpatch.pl`. Patch 2 gets 1 error
and 1 warning. But these appear to be limitations in the checkpatch script
itself, not reflect issues with the patches.

---
Changes in v2:
- Reworded commit messages supplementing the call traces (Vinicius)
- Explain why the put_device are unnecessary. (Vinicius)

Yi Sun (2):
  dmaengine: idxd: Remove improper idxd_free
  dmaengine: idxd: Fix refcount underflow on module unload

 drivers/dma/idxd/init.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

-- 
2.43.0


