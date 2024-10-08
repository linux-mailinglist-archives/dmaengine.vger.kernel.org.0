Return-Path: <dmaengine+bounces-3304-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 697989955B8
	for <lists+dmaengine@lfdr.de>; Tue,  8 Oct 2024 19:34:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 12094B27133
	for <lists+dmaengine@lfdr.de>; Tue,  8 Oct 2024 17:34:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F52620A5F9;
	Tue,  8 Oct 2024 17:34:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WNolwQk0"
X-Original-To: dmaengine@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCF1813BC2F;
	Tue,  8 Oct 2024 17:34:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728408851; cv=none; b=Zi7tYZ9/kitNj9JZMQBs7flvN+ZKqp/o9TDJqtQLZl26vPXkMqpADUoVWRNavj17fYMuJNSO0zVuZf49d22ivYLGmA955aWse1d6sITdUVIKM4JCCpgCuKvOngmDTVlhkF5YcCKjgXhwj6NzccymH0ewA+XVI78YYK1e99mw4vE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728408851; c=relaxed/simple;
	bh=GdFJbEH9FuHcHkDgW9w9j0RlEqZ4KkfewDrDe8HQ5S0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tpMxBvlsDlXBKbd6YcFPzDzR8uI26CitzNI1w0IoOUAGQFdmH7fOo5tSvkJ9wxZ0iaL06bPkx67bBXDq+XVl7jGAySxIjtvsDnXULgSaruVGhHFbugWaxGoBRCjd3MrDwCVdOfkFrK15CDXZoqLUIjwC3jgx6Cdk0pnEtYn/uwk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WNolwQk0; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1728408850; x=1759944850;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=GdFJbEH9FuHcHkDgW9w9j0RlEqZ4KkfewDrDe8HQ5S0=;
  b=WNolwQk0xA5XjkOzRHCVaI7quwA2lFRPYxuVF3vk24fFKVD4cNMmWySn
   aN9gAbIJG8jaQpBDu9HnHzeNFe7iq4eL6hiG6q5h13TTVQzW+CPt/UGCR
   Sc3zVDpWafwAlvSCzRKs2Pf6EGxdNbmbw33viPfom1XrAY3tLVpNCdQzB
   7ct70XQmzYP8IlAqLyCkmZTlEVcoAt4LQfFVEzYoKwdGPFS/HvWBJrEri
   MevUPPVEg3MNStm5RulF6ggY2BcFjZKkvfjmR5/SYKNZ7Ucx7BHoCqNJa
   CX6Z1iG9GE2Ia4hNHHC0mNRT2xEeA287dEXT4S0JGSv+WVI4MUT+pz31G
   w==;
X-CSE-ConnectionGUID: I3DyofyYSay70TNB1/h4XA==
X-CSE-MsgGUID: jZOmaqiVRk61/INnOJEECg==
X-IronPort-AV: E=McAfee;i="6700,10204,11219"; a="39021973"
X-IronPort-AV: E=Sophos;i="6.11,187,1725346800"; 
   d="scan'208";a="39021973"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Oct 2024 10:34:10 -0700
X-CSE-ConnectionGUID: IPfCEXd2RD+i1AMSC6Ycqw==
X-CSE-MsgGUID: wIGVkGbYSHWamGJJjY0pXQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,187,1725346800"; 
   d="scan'208";a="99266644"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmviesa002.fm.intel.com with ESMTP; 08 Oct 2024 10:34:06 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id 806CE26B; Tue, 08 Oct 2024 20:34:05 +0300 (EEST)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Vinod Koul <vkoul@kernel.org>,
	Paul Cercueil <paul@crapouillou.net>,
	dmaengine@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org
Cc: Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v2 1/4] dmaengine: Replace dma_request_slave_channel() by dma_request_chan()
Date: Tue,  8 Oct 2024 20:27:44 +0300
Message-ID: <20241008173351.2246796-2-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.43.0.rc1.1336.g36b5255a03ac
In-Reply-To: <20241008173351.2246796-1-andriy.shevchenko@linux.intel.com>
References: <20241008173351.2246796-1-andriy.shevchenko@linux.intel.com>
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
index 72299a08af44..3a769934c984 100644
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
index b137fdb56093..b4e6de892d34 100644
--- a/include/linux/dmaengine.h
+++ b/include/linux/dmaengine.h
@@ -1632,8 +1632,8 @@ static inline struct dma_chan
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


