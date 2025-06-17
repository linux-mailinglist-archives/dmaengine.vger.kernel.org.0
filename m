Return-Path: <dmaengine+bounces-5513-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EF24ADC82E
	for <lists+dmaengine@lfdr.de>; Tue, 17 Jun 2025 12:27:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 21C953B6996
	for <lists+dmaengine@lfdr.de>; Tue, 17 Jun 2025 10:27:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AD752900BA;
	Tue, 17 Jun 2025 10:27:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="eAuAh7WW"
X-Original-To: dmaengine@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 624017262B;
	Tue, 17 Jun 2025 10:27:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750156055; cv=none; b=Z9/D+V5q3I/DEuI/uzdZCkCTzXP9aG6EhMS/suPeBZ7KqGrC5AmZ1TSTUUgqjnMwKKAD8P0eCsxC0QKIVyMsDyeFCV1URZQRm1fGUvuoJFwIBFWVHFiJm6GgaI2U/32hxbqJkDB/ASUoYzddyBggR57xFYgQ294QdNmTugslY8U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750156055; c=relaxed/simple;
	bh=2tZwtsmmZ89rixmQAEOd6QkHBjBjpGHUSoMUF1n7xEk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ILkN+Q4vgcxZMwzF8zsVE4+nUpmZZ+9AZcpxPWTER9zU8fPbcgGJVysxuGqUEgURSOtIIeW8uoPtBtZd9HM2Wze2mfcYlChUcfRchYvBu61joKUs6bu2aK8AB4sG4JFXZ9YDogX4no/xOnSA72AiSa/avmj/68UWStQFq5ElpJQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=eAuAh7WW; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1750156054; x=1781692054;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=2tZwtsmmZ89rixmQAEOd6QkHBjBjpGHUSoMUF1n7xEk=;
  b=eAuAh7WWmdjCdbATAEsPK1LbwIOucBMCCnbt7jy5M1j5f2pKzIALZJX1
   C96D85QuFHwkH90TuHsSG6s30CC6FBTWhsUxnF7UsJ5TzE+6RmudKGKDj
   1v4h6rw4dQ0t+cMyYWQCWLQDbD31KWqTb0EGSrRNyzUzJ+BwN30Fcx8Y2
   apWA5M0Rg9WkQ02c/EXzmoDfxB59zLRqYCpe4WLra3x6LW0jTK7/COCoy
   XNz5NfLSQdkfPc1L5GhL4KYy/YrhArYZ/w+aTIAO6ex/HLGMhOxBvom6G
   JUxQcBb5zoDTaiEknZC7fdR59O9Rg0cY2z2MUF0w5Q8RGsFFVNL7P/kwu
   w==;
X-CSE-ConnectionGUID: zNj8nQEPQtKXGRTt4ct8fQ==
X-CSE-MsgGUID: MiwU3IyOQN6iQ/2z75I+DA==
X-IronPort-AV: E=McAfee;i="6800,10657,11465"; a="52462044"
X-IronPort-AV: E=Sophos;i="6.16,243,1744095600"; 
   d="scan'208";a="52462044"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jun 2025 03:27:32 -0700
X-CSE-ConnectionGUID: 6KS2sxHcR/6jOhhDIhs04Q==
X-CSE-MsgGUID: FdpfRI4FTsST35tQ3MfDDg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,243,1744095600"; 
   d="scan'208";a="154033928"
Received: from ysun46-mobl (HELO YSUN46-MOBL..) ([10.239.96.51])
  by orviesa005.jf.intel.com with ESMTP; 17 Jun 2025 03:27:30 -0700
From: Yi Sun <yi.sun@intel.com>
To: vinicius.gomes@intel.com,
	dmaengine@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: dave.jiang@intel.com,
	yi.sun@intel.com,
	gordon.jin@intel.com,
	fenghuay@nvidia.com
Subject: [PATCH v3 0/2] dmaengine: idxd: Fix refcount and cleanup issues on module unload
Date: Tue, 17 Jun 2025 18:27:10 +0800
Message-ID: <20250617102712.727333-1-yi.sun@intel.com>
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

