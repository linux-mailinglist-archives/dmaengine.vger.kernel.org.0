Return-Path: <dmaengine+bounces-8123-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B5F9D02430
	for <lists+dmaengine@lfdr.de>; Thu, 08 Jan 2026 12:00:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 76484301CD22
	for <lists+dmaengine@lfdr.de>; Thu,  8 Jan 2026 10:58:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F276F421F18;
	Thu,  8 Jan 2026 10:57:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ndMGUbSV"
X-Original-To: dmaengine@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46ED43A4ACC;
	Thu,  8 Jan 2026 10:56:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767869821; cv=none; b=gXb7wXbGnh6FoUXhInrm3M4fFwcLiOuS3FTk1yihfiVBhB8ruG91q8grssTJk+R94vktvIIMcoOpEiEwxpjmTh1V5jVzPdSK8E2iiEemcL/CPfV6ggQrcCmXm3OSQF9pgdQe8Spy0akFQBwsWpH+edopex6bqrwUols7s+hY/sY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767869821; c=relaxed/simple;
	bh=R/veCd+MoZYz+/H4HoR6cR9O2PqmUFTICzNu+LpTN+o=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ctGqSrwaTLdkC1Gkhl4V/9tyT8AF4blei8tz2s8phghAEnlIVgK1Yi7wNB791tDA61gA/Wwov4OoKHBtQNA6JQ083AQlv/Vwu2v3vN24kWkJYUzzUAFpEQvzSh/+zAzS4Go/BvcpeA8MPR0gTL3Q+ayPC/d6CKSzX0Hbx8zTEy8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ndMGUbSV; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1767869814; x=1799405814;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=R/veCd+MoZYz+/H4HoR6cR9O2PqmUFTICzNu+LpTN+o=;
  b=ndMGUbSVLyNwuC06rTIJp0yIERQyjC+1yUbcbjno3ldJe0/CB4+A4d4H
   ixxrPcdKxM35kEM0R8lyjY2S7IKmf+bo/aYN10mw63Tk8Vz2CQ8qMeEnn
   DMhCVCic62X7oyIq3AW/u1Q8PYGpcFK9dXp9qFwtczYQRq7uHCBwFxRGA
   /5MeF6YYHWadpxeu6NnQKytB57SH2jMVCYKEnnM2MNQ8Ei6zuBp5oUE3H
   a9w45/K6EB9m77HDOb3RjXrmnxl8kaPut1xAZId9aHgpg27eYajnKtrRV
   qGJrfWHVcFtRdDFB8Eb+Tbet6OWzEiDU/+oFwWMWh7BwL+RwMr8fxwYls
   Q==;
X-CSE-ConnectionGUID: OEw2tnupQJ+15WH4rRCS0g==
X-CSE-MsgGUID: e3HQ+yLDT4ipJxb4WWIWSA==
X-IronPort-AV: E=McAfee;i="6800,10657,11664"; a="80354590"
X-IronPort-AV: E=Sophos;i="6.21,210,1763452800"; 
   d="scan'208";a="80354590"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jan 2026 02:56:28 -0800
X-CSE-ConnectionGUID: TLQoBmzxTyqlR0Bd+co+kQ==
X-CSE-MsgGUID: q8cFpDAKSr2AxYqPiM0Nmw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,210,1763452800"; 
   d="scan'208";a="203615538"
Received: from black.igk.intel.com ([10.91.253.5])
  by fmviesa009.fm.intel.com with ESMTP; 08 Jan 2026 02:56:21 -0800
Received: by black.igk.intel.com (Postfix, from userid 1003)
	id 3DE2E98; Thu, 08 Jan 2026 11:56:20 +0100 (CET)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Bjorn Andersson <andersson@kernel.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Vinod Koul <vkoul@kernel.org>,
	Bartosz Golaszewski <brgl@kernel.org>,
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
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Ray Jui <rjui@broadcom.com>,
	Scott Branden <sbranden@broadcom.com>,
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
Subject: [PATCH v5 00/13] dmaengine: introduce sg_nents_for_dma() and convert users
Date: Thu,  8 Jan 2026 11:50:11 +0100
Message-ID: <20260108105619.3513561-1-andriy.shevchenko@linux.intel.com>
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

Changelog v5:
- fixed W=1 warning (Vinod)
- `make W=1` the whole folder in allyesconfig and allmodconfig configurations

v4: <20251124121202.424072-1-andriy.shevchenko@linux.intel.com>

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

*** BLURB HERE ***

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

 drivers/dma/altera-msgdma.c                   |  6 ++---
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
 14 files changed, 52 insertions(+), 70 deletions(-)

-- 
2.50.1


