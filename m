Return-Path: <dmaengine+bounces-4546-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D6663A3DA4F
	for <lists+dmaengine@lfdr.de>; Thu, 20 Feb 2025 13:45:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A3ECE189A043
	for <lists+dmaengine@lfdr.de>; Thu, 20 Feb 2025 12:45:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B87BA1F560E;
	Thu, 20 Feb 2025 12:45:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kUyKqhBL"
X-Original-To: dmaengine@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8FE31F463E;
	Thu, 20 Feb 2025 12:45:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740055503; cv=none; b=hjDd0XUpMCjwhO4GrttH6VZ7wqcBAI++763usjVC6nNiIbUg3sNpNTGSyKwd2jWZh4WFty8BsGNunQEYyoPoK5621wJuPbI1lcrg+dypDe2yuS96FTTuGQ4UC2fSDXSbnySojjmcmptDs8M4wmbsikhYtbnvFfXZDMw6QjWGJZ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740055503; c=relaxed/simple;
	bh=oG12uGM2GY0G64yPYTsTHhOODq5EGA/zAcrs+d7VjLA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=i8R80YZPmkdPa4ot3sN6DHhqiSqIA4gnMsSiLN3jv5yUWlRtynYX9dDyX3NPDqGfdDO9aVmhno1VtArUYiv/6iLtlVR+TRxjXet1HeSpj9L9Ph6eWdFCLAlW/zqbe6l7G4KvjKYlbGd6v5C2BbPhaK0WMn1pLI+MBRo61nbB6cA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kUyKqhBL; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740055502; x=1771591502;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=oG12uGM2GY0G64yPYTsTHhOODq5EGA/zAcrs+d7VjLA=;
  b=kUyKqhBLO3PPfT9SA97UTRrAhKctJ76oHZqOX+5Bcv+YeA4cZLNQzNpb
   3QrVFaELgQ93zhfbVk2HKjzpj6U6chSNDBmT6CBknZdoreOkmJKx6fnXf
   saa0beVt7qP9SnAMU/TK7CuOyaRSmzLontpQ/SLeDVflHODbITfgdxrlg
   8b/glO22IeTWefolCII7jXsPEWchXmBcjLrSs4AiDRUg1cwSkLEi7VHYK
   h1L7bL5igOIiVAS5WpB5oG4Tobd02GZod8qxAREa9WjXNSCivLYCsYqla
   NK3CL73Db1ggHLRX/Iy54MaVlRhk0BamN3Luv/CLVaMjmct3nXLAg4Z0e
   Q==;
X-CSE-ConnectionGUID: ahle3U6YSGKV+kDAhUK3OQ==
X-CSE-MsgGUID: 0PWUIABBR9u7qpnNxsEvGg==
X-IronPort-AV: E=McAfee;i="6700,10204,11351"; a="40020774"
X-IronPort-AV: E=Sophos;i="6.13,301,1732608000"; 
   d="scan'208";a="40020774"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Feb 2025 04:45:01 -0800
X-CSE-ConnectionGUID: PVgQ+gq5SXim0/VjzRT96w==
X-CSE-MsgGUID: x7sJihb4SLal0DNwW8R+3w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,301,1732608000"; 
   d="scan'208";a="115564786"
Received: from pg15swiplab1181.png.altera.com ([10.244.232.167])
  by fmviesa010.fm.intel.com with ESMTP; 20 Feb 2025 04:44:59 -0800
From: niravkumar.l.rabara@intel.com
To: Vinod Koul <vkoul@kernel.org>,
	Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>
Cc: Niravkumar L Rabara <niravkumar.l.rabara@intel.com>,
	nirav.rabara@altera.com,
	dmaengine@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Jisheng Zhang <jszhang@kernel.org>
Subject: [PATCH v5] dma: dw-axi-dmac: remove unnecessary axi_dma_enable() calling
Date: Thu, 20 Feb 2025 20:41:22 +0800
Message-Id: <20250220124122.3807306-1-niravkumar.l.rabara@intel.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Niravkumar L Rabara <niravkumar.l.rabara@intel.com>

DMA is always enabled before calling axi_chan_block_xfer_start(),
so it does not need to be enabled again here.

Re-enabling DMA causes random failures in the dmatest test when running
multiple iterations.
e.g.
[   29.600722] dmatest: dma0chan2-copy0: summary 100 tests, 1 failures 160.26 iops 1299 KB/s (0)

Fixes: 1fe20f1b8454 ("dmaengine: Introduce DW AXI DMAC driver")
Tested-by: Niravkumar L Rabara <niravkumar.l.rabara@intel.com>
Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
Signed-off-by: Niravkumar L Rabara <niravkumar.l.rabara@intel.com>
---
Changes in v5:
  * Fixed the Tested-by format.

Changes in v4:
  * Add fixes tag
  * Rebase to v6.14-rc1 

link to v3:
 - https://lore.kernel.org/all/20230521101216.4084-4-jszhang@kernel.org/

 drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c b/drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c
index b23536645ff7..43d30c7b8f03 100644
--- a/drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c
+++ b/drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c
@@ -435,8 +435,6 @@ static void axi_chan_block_xfer_start(struct axi_dma_chan *chan,
 		return;
 	}
 
-	axi_dma_enable(chan->chip);
-
 	config.dst_multblk_type = DWAXIDMAC_MBLK_TYPE_LL;
 	config.src_multblk_type = DWAXIDMAC_MBLK_TYPE_LL;
 	config.tt_fc = DWAXIDMAC_TT_FC_MEM_TO_MEM_DMAC;
-- 
2.25.1


