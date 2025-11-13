Return-Path: <dmaengine+bounces-7159-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BEA6BC5867D
	for <lists+dmaengine@lfdr.de>; Thu, 13 Nov 2025 16:34:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B9B823BBC75
	for <lists+dmaengine@lfdr.de>; Thu, 13 Nov 2025 15:26:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17804355800;
	Thu, 13 Nov 2025 15:16:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="EnmetsOF"
X-Original-To: dmaengine@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49EDA3557F5;
	Thu, 13 Nov 2025 15:16:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763046980; cv=none; b=hoKwg1Hz43nromqhrDhss/7khIfAzMSx2tcn9WYFwFXNRHhcf2ggIVDpQuE1q+T63z6ytgRVocaT79aBpgV6vuqBbO3s1PgF6KDO8P0hwaxAwV2Cl9Ala0fJEFIdDgk1Fh3grRuVhn2BOHrEZpIEWZOAV/nJqM4x1cgTg1B+emI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763046980; c=relaxed/simple;
	bh=YgPrha/FWL+rx0Hr+rnyQmwA7SuU4BQbCsM9ur+PqQ4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Iio+cqmXCM++Y07aqVmmyT9t/Zh+lM3FjwTp1jv174r5eteKCylHadPq+mrJVJX0VywS+BaIQNvcKH6eaxljZeX+hUwdN3kAc+U+iXt20wNJJFEw9penZHbmQqLNS49v2Sl5DZ9kpGaZM1/5zMVn9zL4cs1PfhQvOUx8S42fkys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=EnmetsOF; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1763046978; x=1794582978;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=YgPrha/FWL+rx0Hr+rnyQmwA7SuU4BQbCsM9ur+PqQ4=;
  b=EnmetsOFkrMhnjqsZFPawIS8LrNbGsq6CEo6fLmzBbSQuXy0BzQJTklE
   kgduaTuFf5Nlv70+V4hNVh8w4+kQwNbhwfNzOJlwQL2+k4hNIH7qBtAme
   LpAmVQYz0KrU+FNMcJMXa58r4g3dx7qHXiqbbAOsbF5aC/NOMKLDkebDP
   hlHxZ2a7cuQ0dPmOt/xtYBttlf5n0C4IiWe0DEZ0pmtKWfwPHrRdeXlIk
   zGYHfzdEQerLZFVca2teih6+LYv6O9H84CDRmKp18v2rzq4UrsRaUQpod
   d6ZdE6R+LYdQFNv2RLeu5wJADKSgFYy7l3y4Mm1F1QF/gW/cBna5Q/+g1
   w==;
X-CSE-ConnectionGUID: Xtr1oeDOTt6IrASZofrMjA==
X-CSE-MsgGUID: HdlVYgJDSvuYRamaF8arww==
X-IronPort-AV: E=McAfee;i="6800,10657,11612"; a="75809634"
X-IronPort-AV: E=Sophos;i="6.19,302,1754982000"; 
   d="scan'208";a="75809634"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Nov 2025 07:16:11 -0800
X-CSE-ConnectionGUID: bviZ6KxzTBKFZEORJuB7qA==
X-CSE-MsgGUID: VwK7v3k3SYeEve+g81JZqw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,302,1754982000"; 
   d="scan'208";a="194684640"
Received: from black.igk.intel.com ([10.91.253.5])
  by orviesa005.jf.intel.com with ESMTP; 13 Nov 2025 07:16:05 -0800
Received: by black.igk.intel.com (Postfix, from userid 1003)
	id AE7A996; Thu, 13 Nov 2025 16:16:04 +0100 (CET)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Bjorn Andersson <andersson@kernel.org>,
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
Subject: [PATCH v3 00/13] dmaengine: introduce sg_nents_for_dma() and convert users
Date: Thu, 13 Nov 2025 16:12:56 +0100
Message-ID: <20251113151603.3031717-1-andriy.shevchenko@linux.intel.com>
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


