Return-Path: <dmaengine+bounces-5942-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3159CB1AC00
	for <lists+dmaengine@lfdr.de>; Tue,  5 Aug 2025 03:28:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 600AB17C3DC
	for <lists+dmaengine@lfdr.de>; Tue,  5 Aug 2025 01:28:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C823C194C75;
	Tue,  5 Aug 2025 01:28:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bUgGVh7Y"
X-Original-To: dmaengine@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC251A41;
	Tue,  5 Aug 2025 01:28:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754357293; cv=none; b=CMN3VHOxVopxJJb+hnnhpm3b1chsPQVd5CYRZNepymL56jWL+KgfOojgR++pt7/XZi5C0laWsn7kYMhlTYz8VXeb9k4GdJsFkz5jNenIcySWuWYYx+A7e92zAEQBxpBQX8Oz0BJmCGyJt7H90SBte9aypewVDPx+oIBgNo/IyE4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754357293; c=relaxed/simple;
	bh=R6li662MYtyEUcIljidNKO2Q5AgbLnRkpnxHq0Gu5ms=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=TZFXBOhCeXGwFALuOldD+sWhwvBmgOz+HxQ6UQRLWe7m5aFB6uELhxZx+7gMknO4gidSqVS4toz5uDvTmlwd8KAakqlZQYQzKpDQxeqfjfG7sNXbWMH1CbrfKBsx4bQNqaCHpOdUbaujEqNcaoOpapxtHWWs8FAsCXqeAjjEVJ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bUgGVh7Y; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1754357292; x=1785893292;
  h=from:subject:date:message-id:mime-version:
   content-transfer-encoding:to:cc;
  bh=R6li662MYtyEUcIljidNKO2Q5AgbLnRkpnxHq0Gu5ms=;
  b=bUgGVh7YyC2+8Y7l8SqmAVXyq4Kvf5VU9QgWLEwmygtj/d89VddlZi8N
   rJsuFhpolhYnRv+3jtRu3niyUXgUOFxiyTaMo09J245TO4dWrD5bUPsKc
   QmPwBZBqCuMNBbZgVTG0Sq7LmpqAkuz9xzZghBv36G8Vmt1vCoifrasZs
   UyYllAWPTN7uCaPbijnY4d8M0P/5ndZrDHDHxefOUCVVr44KFgixCWCXM
   oM1bI4ELk/VI2giYRF6JeWvreViJX4sWD/n/E0w2QFQ92CB3CpN3IG1yS
   XZHB8e1a6Qcb/fOOkhNP4nk+n2eKoladsJg8vbELztmYbiQbsd1CIWbnD
   w==;
X-CSE-ConnectionGUID: iJb89Fj7T3GSVG9bhZgBBg==
X-CSE-MsgGUID: tN06heMNTgSz86IHmyEV5A==
X-IronPort-AV: E=McAfee;i="6800,10657,11512"; a="68085350"
X-IronPort-AV: E=Sophos;i="6.17,265,1747724400"; 
   d="scan'208";a="68085350"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Aug 2025 18:28:11 -0700
X-CSE-ConnectionGUID: ySeqyIlZRMaNv5Hpz98KHQ==
X-CSE-MsgGUID: igA6UgCKTPyhmMvcZJiFeQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,265,1747724400"; 
   d="scan'208";a="169699533"
Received: from vcostago-mobl3.jf.intel.com (HELO [10.98.32.147]) ([10.98.32.147])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Aug 2025 18:28:11 -0700
From: Vinicius Costa Gomes <vinicius.gomes@intel.com>
Subject: [PATCH 0/9] dmaengine: idxd: Memory leak and FLR fixes
Date: Mon, 04 Aug 2025 18:27:51 -0700
Message-Id: <20250804-idxd-fix-flr-on-kernel-queues-v3-v1-0-4e020fbf52c1@intel.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIABdekWgC/x3NUQqDMBCE4avIPnchMZZIr1L6oM2kXSqx3aAI4
 t27+PjBz8xOFSqodGt2UqxSZS4Gf2no+R7KCyzJTK1rr653nXFLnGXjPCnPhT/Qgol/CxZUXgP
 7kEMcxhR97MlmvgrLz4v74zj+8g/Gr3IAAAA=
X-Change-ID: 20250804-idxd-fix-flr-on-kernel-queues-v3-13f37abd7178
To: Dave Jiang <dave.jiang@intel.com>, Vinod Koul <vkoul@kernel.org>, 
 Fenghua Yu <fenghua.yu@intel.com>, Dan Williams <dan.j.williams@intel.com>
Cc: dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Vinicius Costa Gomes <vinicius.gomes@intel.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1754357291; l=1439;
 i=vinicius.gomes@intel.com; s=20230921; h=from:subject:message-id;
 bh=R6li662MYtyEUcIljidNKO2Q5AgbLnRkpnxHq0Gu5ms=;
 b=aU++KRw/A8nqVZnuCXxiRADzcU7rXQrMqPX7X2ahBBg4frEdcjwqq2n6t0CMf7bhPA8SwLXRM
 6p1n2zMoShiCDUvksDNLTyNOtgkjlnniQlPLqAaJvCOjtey81LpL/Y3
X-Developer-Key: i=vinicius.gomes@intel.com; a=ed25519;
 pk=aJkrtgqgT6TZ8iIHSG8/rTPsmlYnjMrUjCsMYvCzntk=

Hi,

During testing some not so happy code paths in a debugging (lockdep,
kmemleak, etc) kernel, found a few issues.

There's still a crash that happens when doing a PCI unbind, but I
don't have a patch at this time.

Cheers,

Signed-off-by: Vinicius Costa Gomes <vinicius.gomes@intel.com>
---
Vinicius Costa Gomes (9):
      dmaengine: idxd: Fix lockdep warnings when calling idxd_device_config()
      dmaengine: idxd: Fix crash when the event log is disabled
      dmaengine: idxd: Fix possible invalid memory access after FLR
      dmaengine: idxd: Flush kernel workqueues on Field Level Reset
      dmaengine: idxd: Allow DMA clients to empty the pending queue
      dmaengine: idxd: Fix not releasing workqueue on .release()
      dmaengine: idxd: Fix memory leak when a wq is reset
      dmaengine: idxd: Fix freeing the allocated ida too late
      dmaengine: idxd: Fix leaking event log memory

 drivers/dma/idxd/cdev.c   |  8 ++++----
 drivers/dma/idxd/device.c | 30 ++++++++++++++++++++++++++----
 drivers/dma/idxd/dma.c    | 10 ++++++++++
 drivers/dma/idxd/idxd.h   |  1 +
 drivers/dma/idxd/init.c   |  6 +++++-
 drivers/dma/idxd/irq.c    |  7 +++++++
 drivers/dma/idxd/sysfs.c  |  1 +
 7 files changed, 54 insertions(+), 9 deletions(-)
---
base-commit: e3a9ccd21897a59d02cf2b7a95297086249306d6
change-id: 20250804-idxd-fix-flr-on-kernel-queues-v3-13f37abd7178

Best regards,
-- 
Vinicius


