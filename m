Return-Path: <dmaengine+bounces-7307-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E0C96C8069B
	for <lists+dmaengine@lfdr.de>; Mon, 24 Nov 2025 13:15:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 556683A11C0
	for <lists+dmaengine@lfdr.de>; Mon, 24 Nov 2025 12:12:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B92CB2FFDD2;
	Mon, 24 Nov 2025 12:12:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JxUyjHoN"
X-Original-To: dmaengine@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C39732EB866;
	Mon, 24 Nov 2025 12:12:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763986334; cv=none; b=UK+/waw8yqPCFRFzQBpeQCAVdDhAPf8EEWDJhTVLfA+wf8UqvNotEhVih0MFBFDVGrp2QHyHfCHa/OT1/j73uXfPZhEFsiRu9V8JHGO8te6pswc+VYR1NEBKxk3JFwzY2vCC3ZJZqkS+WIt6noYhIIdMQOXXzPIpSa1r2Jxt6Wg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763986334; c=relaxed/simple;
	bh=VbgYR7rJ09xzyKkM2zSKZNmY3X4tqd/TmXvi9Q2VLzw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=MTzgU/zsYFqsOdTRRdW+QbYUs4N8KiaKR3Wzy0VvUwsNQsCgY4o+f7qVjG9YoZ65UqSD0gRa+qrH9DXed22JLb9j0AoKOehrw8ScMNue6iC9jDYxHCt3Xkr5Ci9lsm7xHyUOt/kWk+2BXzvglXmC8nCtaGKMcDsGL2KhikPYsi4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JxUyjHoN; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1763986332; x=1795522332;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=VbgYR7rJ09xzyKkM2zSKZNmY3X4tqd/TmXvi9Q2VLzw=;
  b=JxUyjHoNzGJtrcVg90z1gX5cH9WWniEd8hWZVZ1j1Uu/L8J5gPah8NC6
   mDEhMFf9Im46gQH5LGVw7E+i8X5NMI00pPYGYgaBGv83Mx7iwjC/vzsTA
   sX49gCktxKJ+y1xdyJm2AFjB2/jEK6dn02nOfWkCPx6eq5GRvodG7CN0a
   OWS3hWqRdtAxztNnpVvhAXcXpblhaw4s5MezLj782cnvyUiAJVScGhHuq
   /aFfDxJuWbWQG1yTkvRb4tNNXrJ7ibre7j84MpmgiRQrTcAhk4fUYukWB
   O1QauvkhDTfchsmJcFfGDKbVVlMKbpx2inZSVoEH4OhK0j9rYBmlcrFPS
   Q==;
X-CSE-ConnectionGUID: 1MM8hMNLTIC6g3J0RmcKOw==
X-CSE-MsgGUID: d8DTAz/+SHqpy5zpfqD31Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11622"; a="69847537"
X-IronPort-AV: E=Sophos;i="6.20,222,1758610800"; 
   d="scan'208";a="69847537"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Nov 2025 04:12:09 -0800
X-CSE-ConnectionGUID: 83r+lxHpRIaFo44hbpipxw==
X-CSE-MsgGUID: jmYxulCUSdORUvLiN/9xPA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.20,222,1758610800"; 
   d="scan'208";a="222970325"
Received: from black.igk.intel.com ([10.91.253.5])
  by orviesa002.jf.intel.com with ESMTP; 24 Nov 2025 04:12:04 -0800
Received: by black.igk.intel.com (Postfix, from userid 1003)
	id 45B41A0; Mon, 24 Nov 2025 13:12:03 +0100 (CET)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Bjorn Andersson <andersson@kernel.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Stefan Wahren <wahrenst@gmx.net>,
	Vinod Koul <vkoul@kernel.org>,
	Thomas Andreatta <thomasandreatta2000@gmail.com>,
	Caleb Sander Mateos <csander@purestorage.com>,
	dmaengine@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-rpi-kernel@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	linux-arm-msm@vger.kernel.org
Cc: Olivier Dautricourt <olivierdautricourt@gmail.com>,
	Stefan Roese <sr@denx.de>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Ray Jui <rjui@broadcom.com>,
	Scott Branden <sbranden@broadcom.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>,
	Daniel Mack <daniel@zonque.org>,
	Haojian Zhuang <haojian.zhuang@gmail.com>,
	Robert Jarzmik <robert.jarzmik@free.fr>,
	Lizhi Hou <lizhi.hou@amd.com>,
	Brian Xu <brian.xu@amd.com>,
	Raj Kumar Rampelli <raj.kumar.rampelli@amd.com>,
	Michal Simek <michal.simek@amd.com>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH v4 0/13] dmaengine: introduce sg_nents_for_dma() and convert users
Date: Mon, 24 Nov 2025 13:09:18 +0100
Message-ID: <20251124121202.424072-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A handful of the DMAengine drivers use same routine to calculate the number of
SG entries needed for the given DMA transfer. Provide a common helper for them
and convert.

I left the new helper on SG level of API because brief grepping shows potential
candidates outside of DMA engine, e.g.:

  drivers/crypto/chelsio/chcr_algo.c:154:  nents += DIV_ROUND_UP(less, entlen);
  drivers/spi/spi-stm32.c:1495:  /* Count the number of entries needed */

Changelog v4:
- fixed compilation errors (Vinod)

v3: <20251113151603.3031717-1-andriy.shevchenko@linux.intel.com>

Changelog v3:
- added missed EXPORT_SYMBOL() (Bjorn)
- left the return type as signed int (as agreed with Bjorn)
- collected tags (Bjorn)

v2: <20251110103805.3562136-1-andriy.shevchenko@linux.intel.com>

Changelog v2:
- dropped outdated patches (only 9 years passed :-)
- rebased on top of the current kernel
- left API SG wide It might

v1: https://patchwork.kernel.org/project/linux-dmaengine/patch/20161021173535.100245-1-andriy.shevchenko@linux.intel.com/

Andy Shevchenko (13):
  scatterlist: introduce sg_nents_for_dma() helper
  dmaengine: altera-msgdma: use sg_nents_for_dma() helper
  dmaengine: axi-dmac: use sg_nents_for_dma() helper
  dmaengine: bcm2835-dma: use sg_nents_for_dma() helper
  dmaengine: dw-axi-dmac: use sg_nents_for_dma() helper
  dmaengine: k3dma: use sg_nents_for_dma() helper
  dmaengine: lgm: use sg_nents_for_dma() helper
  dmaengine: pxa-dma: use sg_nents_for_dma() helper
  dmaengine: qcom: adm: use sg_nents_for_dma() helper
  dmaengine: qcom: bam_dma: use sg_nents_for_dma() helper
  dmaengine: sa11x0: use sg_nents_for_dma() helper
  dmaengine: sh: use sg_nents_for_dma() helper
  dmaengine: xilinx: xdma: use sg_nents_for_dma() helper

 drivers/dma/altera-msgdma.c                   |  5 ++--
 drivers/dma/bcm2835-dma.c                     | 19 +-------------
 drivers/dma/dma-axi-dmac.c                    |  5 +---
 .../dma/dw-axi-dmac/dw-axi-dmac-platform.c    |  6 ++---
 drivers/dma/k3dma.c                           |  9 ++-----
 drivers/dma/lgm/lgm-dma.c                     |  9 ++-----
 drivers/dma/pxa_dma.c                         |  5 ++--
 drivers/dma/qcom/bam_dma.c                    |  9 ++-----
 drivers/dma/qcom/qcom_adm.c                   |  9 +++----
 drivers/dma/sa11x0-dma.c                      |  6 ++---
 drivers/dma/sh/shdma-base.c                   |  5 ++--
 drivers/dma/xilinx/xdma.c                     |  6 ++---
 include/linux/scatterlist.h                   |  2 ++
 lib/scatterlist.c                             | 26 +++++++++++++++++++
 14 files changed, 52 insertions(+), 69 deletions(-)

-- 
2.50.1


