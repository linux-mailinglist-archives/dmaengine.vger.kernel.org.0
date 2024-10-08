Return-Path: <dmaengine+bounces-3306-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 410089955BE
	for <lists+dmaengine@lfdr.de>; Tue,  8 Oct 2024 19:35:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0179E28B65B
	for <lists+dmaengine@lfdr.de>; Tue,  8 Oct 2024 17:35:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEE8A41C64;
	Tue,  8 Oct 2024 17:34:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GnCUVh4c"
X-Original-To: dmaengine@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A01820A5F5;
	Tue,  8 Oct 2024 17:34:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728408887; cv=none; b=VM7qTatx8OusvynBw+L84hFpoPGemRGPzvj9jY84kUu4OJFsvYKkCjiz08rm/c/SvdcC7l71SqvETk050ph1bDTgSequMsJjOKo7s2yHGniE8V+UgD65oFnNPMs1hc4+rwf4uNqB8X52zC00gqyD9FejXvpPqU2mLu26Gx9cSWQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728408887; c=relaxed/simple;
	bh=B/TiYEZ7U+o3cYkTkBVn+Bib/ZVSeLTnOP2By0iGMbw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Rit3PxSS0yQHtoSMZ500HUbe3LV/I3GiiY3hrRWpbf8OmmqbYNhftBMrl+rBUke05WdoNKJgngInCbdLbyvYj8oX2Ptho2g1K99XLOPlneUhLXo2tqy5z7yrBXtNq2Ef9VkTNqV2f1594+tp2Vona5vAqG++pI7/FZbr2lSOSxY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GnCUVh4c; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1728408886; x=1759944886;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=B/TiYEZ7U+o3cYkTkBVn+Bib/ZVSeLTnOP2By0iGMbw=;
  b=GnCUVh4clao6OkTO0EEcw/0wwgGJExSCdqSI+EQfzJ2k7AtJoWTwWEW+
   udj/D0btXKyCF/WxMXenu/O2yhMoGO8v6LEGgo1nU3Ww7P5cNv+FfEkBY
   /xXGgsQKXn+aOuA5thFFA7nzIQtZyy9OyexJze/NCfc1ste0FnPXLe5n9
   hOV/yHvazULw0qqetXTQcuaS+ASeZJrdQfvMCIUZyO5lxlFC+kRDX7Xbf
   cCK0G2jtS0RoTTOe9/mzvq2QH9ePG/eNR3SNwPTfQtuGy4TCyLtMY8G8/
   vUTf97eSB1ziWmicAPDxjs1nJnCYsH5vvuaqkrFr88M1XWmcP5MzVB+Ye
   g==;
X-CSE-ConnectionGUID: CQnJEboOTRqXUnsh86Rx4g==
X-CSE-MsgGUID: XiYP/GrkTwi+GqptWPoBHw==
X-IronPort-AV: E=McAfee;i="6700,10204,11219"; a="27510131"
X-IronPort-AV: E=Sophos;i="6.11,187,1725346800"; 
   d="scan'208";a="27510131"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Oct 2024 10:34:09 -0700
X-CSE-ConnectionGUID: J0il/t0ETkOzzu2NEWoWNQ==
X-CSE-MsgGUID: YANwed6LQT2JXyVpxKC+Kg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,187,1725346800"; 
   d="scan'208";a="106677514"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmviesa001.fm.intel.com with ESMTP; 08 Oct 2024 10:34:07 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id 30F1F28E; Tue, 08 Oct 2024 20:34:06 +0300 (EEST)
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
Subject: [PATCH v2 2/4] dmaengine: Use dma_request_channel() instead of __dma_request_channel()
Date: Tue,  8 Oct 2024 20:27:45 +0300
Message-ID: <20241008173351.2246796-3-andriy.shevchenko@linux.intel.com>
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

Reduce use of internal __dma_request_channel() function in public
dmaengine.h.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 include/linux/dmaengine.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/dmaengine.h b/include/linux/dmaengine.h
index b4e6de892d34..2f46056096d6 100644
--- a/include/linux/dmaengine.h
+++ b/include/linux/dmaengine.h
@@ -1639,7 +1639,7 @@ static inline struct dma_chan
 	if (!fn || !fn_param)
 		return NULL;
 
-	return __dma_request_channel(&mask, fn, fn_param, NULL);
+	return dma_request_channel(mask, fn, fn_param);
 }
 
 static inline char *
-- 
2.43.0.rc1.1336.g36b5255a03ac


