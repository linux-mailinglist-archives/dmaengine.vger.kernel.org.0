Return-Path: <dmaengine+bounces-4304-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 33BD4A292EF
	for <lists+dmaengine@lfdr.de>; Wed,  5 Feb 2025 16:07:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EB8AC1693C7
	for <lists+dmaengine@lfdr.de>; Wed,  5 Feb 2025 15:00:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 817E518C337;
	Wed,  5 Feb 2025 14:58:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fuDeX3Ty"
X-Original-To: dmaengine@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 790CF1547E9;
	Wed,  5 Feb 2025 14:58:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738767485; cv=none; b=A1EZDgGZRoQaHAe4XsiItMtxQ6R7mZAgpijk86CT+C4jkHfh8NceBU7VSf/kk3uZavv5DyIg54i8izXwwPXp9PO0byUdb114O1CmiBZw6VB1Dm/sOoN+EtPo2pN2bIy78ifhFy8ISVwBaK+0YhTMKUiBqE6epE5Zn/bRJUrAE6Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738767485; c=relaxed/simple;
	bh=3EDPzq+QRjtF8ntIcn0E9PwMJhWnjlNrTN7MIeR80jo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gEgontPymk0LYhuQV2ch1uBLoWbLUMT391kgo650+oFbokP9TWkLPeLOUEWzEUtRQjEv0jMT7b3oAWG1TGlIi6jfQLTpbAQPzs7bO6ZXhNRPfNPub6LmoxxdQTFEIoVAaySg3nPggPSm/AFikDY4Ussy/b0X7AT65ItsMtKPLQA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fuDeX3Ty; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1738767484; x=1770303484;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=3EDPzq+QRjtF8ntIcn0E9PwMJhWnjlNrTN7MIeR80jo=;
  b=fuDeX3TyaKrq78n0hv1djII8ph8BWdw1f2dbTM3vGGYVIGAn5rccS2vC
   7C+nwvBz37e9h3v4Bj6Axqn6cQjOdOFR2BqdGULiaJ3S0/CbjJhX36ulU
   VeXRRN/n6qNkvR81laTzU7jTzlhD3q3wTPUynxup9do/GeCyQcIjEHnLs
   g8nIpef9B3P9q63yMAV1umGqBFkq8ulKokEadHq7Hk/3Mre7tdAPlmTt4
   Al6W1FF76+c0ZAL70inXP53VEoUmObO267m2dHjUUgJnC/CO2PKqCyjAz
   +d9h2OeEU2QvlLwHMhx42LNMIXYP6nqkDEjQBMk4JZK3MzGvsowWTwM4R
   w==;
X-CSE-ConnectionGUID: 3cyhpVFBSDiWB+4+HGAT+A==
X-CSE-MsgGUID: G8fqZEFRQtWDYx9YTDj5KA==
X-IronPort-AV: E=McAfee;i="6700,10204,11336"; a="39599695"
X-IronPort-AV: E=Sophos;i="6.13,261,1732608000"; 
   d="scan'208";a="39599695"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Feb 2025 06:58:03 -0800
X-CSE-ConnectionGUID: LMxD6/3vSq6Xcb2+iczw9g==
X-CSE-MsgGUID: TDg2oATYSdCw/H5cHCpDSA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,261,1732608000"; 
   d="scan'208";a="115968400"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmviesa004.fm.intel.com with ESMTP; 05 Feb 2025 06:58:00 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id B93DE13E; Wed, 05 Feb 2025 16:57:58 +0200 (EET)
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
Subject: [PATCH v3 2/4] dmaengine: Use dma_request_channel() instead of __dma_request_channel()
Date: Wed,  5 Feb 2025 16:57:10 +0200
Message-ID: <20250205145757.889247-3-andriy.shevchenko@linux.intel.com>
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

Reduce use of internal __dma_request_channel() function in public
dmaengine.h.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 include/linux/dmaengine.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/dmaengine.h b/include/linux/dmaengine.h
index 83cbf7197a76..a360e0330436 100644
--- a/include/linux/dmaengine.h
+++ b/include/linux/dmaengine.h
@@ -1646,7 +1646,7 @@ static inline struct dma_chan
 	if (!fn || !fn_param)
 		return NULL;
 
-	return __dma_request_channel(&mask, fn, fn_param, NULL);
+	return dma_request_channel(mask, fn, fn_param);
 }
 
 static inline char *
-- 
2.43.0.rc1.1336.g36b5255a03ac


