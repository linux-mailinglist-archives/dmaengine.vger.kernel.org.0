Return-Path: <dmaengine+bounces-4308-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EC97A292FA
	for <lists+dmaengine@lfdr.de>; Wed,  5 Feb 2025 16:07:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0A1AD16D859
	for <lists+dmaengine@lfdr.de>; Wed,  5 Feb 2025 15:00:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFCB11FC0E0;
	Wed,  5 Feb 2025 14:58:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hwdmDFsR"
X-Original-To: dmaengine@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BABA1DDA0C;
	Wed,  5 Feb 2025 14:58:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738767487; cv=none; b=FcGupI68LWSKMW4jmVTsyuGFHGv0oJbpwWl4MMB7aKaMzempeba3toeMkAjH2+ea7PU+yVb0EOF5vvILlVwn4Q5eJU0F4IODovOvCijglTA1xjr7U0vZSbuGCM2erOQsYsn1/jaBIuNjkzBp+bibdfSSu817KR7S3x/7PzgpZqA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738767487; c=relaxed/simple;
	bh=uvnNcC/P2j4xylOfl/Tcg9K+1wXoPmdsdMK/xVegdEE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KM7pA/fpNVOzQSRCWwa5Zula/hsW/SPdzWwl9tn3scoBjUbCj6HUj7KkyYHokSQyVVFg5UYn34tHRNuE9loGN1JwrK40Cb+UstgnqK15zHxIO2G/kfu280sQOu7dq5xMYn3DkEf1QHjzeGoNzca/EpIBRiy2ITJYp/gQxf5AuC0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hwdmDFsR; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1738767486; x=1770303486;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=uvnNcC/P2j4xylOfl/Tcg9K+1wXoPmdsdMK/xVegdEE=;
  b=hwdmDFsRS98kpLMH5PtB6zrZP6pvjly0Yk2NRNRZNd4VwMhsRhK8wjbB
   loSckU5anpKMXgUZwa5VuK+pvf1HACRGbUTUu6Fno50zFhxzObZ4R1NLB
   RXHBeEqg88btOMYKSHQcCUOTY0HdlgOx/B2WX693aStg8+zGS7Y+JSflJ
   KrY/JTChJxlLk1vyd41PcD58TZGJBPu8asoesjUay6odgelMU4/A5UwO+
   QQbTjuMYLufbZSliLFjIyl+kzhnyajTTAAYDl5BpvTjpM+epmyWP5Ep8X
   TZFf0PKDaPrkuYkg6qq94NSvoCOVkFRmaBwyEx7Eosj03lDxp72tzWpgm
   w==;
X-CSE-ConnectionGUID: Ibip8meeT2mePsPrrGP1sA==
X-CSE-MsgGUID: mszqPtG6QMe/mH6zlMOtUA==
X-IronPort-AV: E=McAfee;i="6700,10204,11336"; a="39232344"
X-IronPort-AV: E=Sophos;i="6.13,261,1732608000"; 
   d="scan'208";a="39232344"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Feb 2025 06:58:04 -0800
X-CSE-ConnectionGUID: ve7rhMT8RhOcIscPbAcCeQ==
X-CSE-MsgGUID: 4IezkWDmRTGdOzeqUX5fIw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="111806976"
Received: from black.fi.intel.com ([10.237.72.28])
  by orviesa008.jf.intel.com with ESMTP; 05 Feb 2025 06:58:00 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id AE98D10A; Wed, 05 Feb 2025 16:57:58 +0200 (EET)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Vinod Koul <vkoul@kernel.org>,
	Amelie Delaunay <amelie.delaunay@foss.st.com>,
	Frank Li <Frank.Li@nxp.com>,
	Paul Cercueil <paul@crapouillou.net>,
	Randy Dunlap <rdunlap@infradead.org>,
	dmaengine@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org
Cc: Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v3 1/4] dmaengine: Replace dma_request_slave_channel() by dma_request_chan()
Date: Wed,  5 Feb 2025 16:57:09 +0200
Message-ID: <20250205145757.889247-2-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.43.0.rc1.1336.g36b5255a03ac
In-Reply-To: <20250205145757.889247-1-andriy.shevchenko@linux.intel.com>
References: <20250205145757.889247-1-andriy.shevchenko@linux.intel.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Replace dma_request_slave_channel() by dma_request_chan() as suggested
since the former is deprecated.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/dma/imx-sdma.c    | 5 ++---
 include/linux/dmaengine.h | 4 ++--
 2 files changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/dma/imx-sdma.c b/drivers/dma/imx-sdma.c
index 3449006cd14b..02a85d6f1bea 100644
--- a/drivers/dma/imx-sdma.c
+++ b/drivers/dma/imx-sdma.c
@@ -1459,9 +1459,8 @@ static int sdma_alloc_chan_resources(struct dma_chan *chan)
 	 * dmatest, thus create 'struct imx_dma_data mem_data' for this case.
 	 * Please note in any other slave case, you have to setup chan->private
 	 * with 'struct imx_dma_data' in your own filter function if you want to
-	 * request dma channel by dma_request_channel() rather than
-	 * dma_request_slave_channel(). Othwise, 'MEMCPY in case?' will appear
-	 * to warn you to correct your filter function.
+	 * request DMA channel by dma_request_channel(), otherwise, 'MEMCPY in
+	 * case?' will appear to warn you to correct your filter function.
 	 */
 	if (!data) {
 		dev_dbg(sdmac->sdma->dev, "MEMCPY in case?\n");
diff --git a/include/linux/dmaengine.h b/include/linux/dmaengine.h
index 346251bf1026..83cbf7197a76 100644
--- a/include/linux/dmaengine.h
+++ b/include/linux/dmaengine.h
@@ -1639,8 +1639,8 @@ static inline struct dma_chan
 {
 	struct dma_chan *chan;
 
-	chan = dma_request_slave_channel(dev, name);
-	if (chan)
+	chan = dma_request_chan(dev, name);
+	if (!IS_ERR(chan))
 		return chan;
 
 	if (!fn || !fn_param)
-- 
2.43.0.rc1.1336.g36b5255a03ac


