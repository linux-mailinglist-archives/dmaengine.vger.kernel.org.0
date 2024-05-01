Return-Path: <dmaengine+bounces-1977-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C18BB8B9123
	for <lists+dmaengine@lfdr.de>; Wed,  1 May 2024 23:46:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 617561F2399D
	for <lists+dmaengine@lfdr.de>; Wed,  1 May 2024 21:46:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48F1C168AF3;
	Wed,  1 May 2024 21:46:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lvbBfk9R"
X-Original-To: dmaengine@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 978B4165FC7;
	Wed,  1 May 2024 21:46:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714599997; cv=none; b=P7o60ukJkLa3WNyFq1MeImwbhQ2P/mh/F4F9M6Nakfba/s/k3c9V7KXFmUI4ASJY8WaR+iaIw8ilKvv0cpjr9oDYud3NDcjU0aGKVH62zV1OZK0PfnmpUbk5dGt7jCDOUma+Rcg1KgbtK2F12fSEfP+voAep2g4KwNQH8HExMko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714599997; c=relaxed/simple;
	bh=hACSXKwjUfbBQK1SZQtJKTIslnAmtEzEsEUXgKqVCk4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=NVRRfG5hGR3zazVBteedSlvVp3DM0vlY/M0QBCI2jNZ+7d033ydX3n/73xrSyWzOKzi23dZkjNC9P+xxTcsbN3wRnbcjnO9/oeFFCFhl6VwKR3fvctGakaIwQOkMjSuqXIykgONf4HZXbfgziXmzay/+9I/ubte+EFbGPzqcOMY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lvbBfk9R; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1714599996; x=1746135996;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=hACSXKwjUfbBQK1SZQtJKTIslnAmtEzEsEUXgKqVCk4=;
  b=lvbBfk9Rv6Bhu7FB1DUBePskz+2cgTawFWEvsrekd6dh6CFAZE5qQJFL
   WJT8Jylv7shmt8n+L7eGMY7pJsufpqQCiO9syPCBHsR+EW9y/V/FxIY6U
   n9JtzUOtiv/VS4iAUug/mC6Nw/vaGamP9TslTopDV2dHX2ATkEyCpDgc9
   W3f02enOZO+g50W2qZ1ZQBPY0nom+L35FgshGR84eTEA9pQ+p233T0A4R
   DHbPt49h02I/6ZyGFsipWrNqVnJogq5Nx0zNQjfkZEYFERocHa4YsNxI6
   lizqQ0tQY2avGMdNYrtCHWQs5PZWESxHu5bDQxN+4m3NY9zZzi5GH53oS
   Q==;
X-CSE-ConnectionGUID: qBHbahdCSd20HCFPoWmzKQ==
X-CSE-MsgGUID: MaMKSrQuSHCHEWM3IZUj3Q==
X-IronPort-AV: E=McAfee;i="6600,9927,11061"; a="14130158"
X-IronPort-AV: E=Sophos;i="6.07,246,1708416000"; 
   d="scan'208";a="14130158"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 May 2024 14:46:36 -0700
X-CSE-ConnectionGUID: 11aTBIVSRM66jHJjDTB57Q==
X-CSE-MsgGUID: fdwANjsYQoKoqEWm32GAbg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,246,1708416000"; 
   d="scan'208";a="31726391"
Received: from jf5300-b11a264t.jf.intel.com ([10.242.51.89])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 May 2024 14:46:35 -0700
From: Andre Glover <andre.glover@linux.intel.com>
To: tom.zanussi@linux.intel.com,
	minchan@kernel.org,
	senozhatsky@chromium.org,
	hannes@cmpxchg.org,
	yosryahmed@google.com,
	nphamcs@gmail.com,
	chengming.zhou@linux.dev,
	herbert@gondor.apana.org.au,
	davem@davemloft.net,
	fenghua.yu@intel.com,
	dave.jiang@intel.com
Cc: wajdi.k.feghali@intel.com,
	james.guilford@intel.com,
	vinodh.gopal@intel.com,
	bala.seshasayee@intel.com,
	heath.caldwell@intel.com,
	kanchana.p.sridhar@intel.com,
	andre.glover@linux.intel.com,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	21cnbao@gmail.com,
	ryan.roberts@arm.com,
	linux-crypto@vger.kernel.org,
	dmaengine@vger.kernel.org
Subject: [RFC PATCH 2/3] crypto: add by_n attribute to acomp_req
Date: Wed,  1 May 2024 14:46:28 -0700
Message-Id: <8fe04e86f0907588d210885ac91965960f97f450.1714581792.git.andre.glover@linux.intel.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <cover.1714581792.git.andre.glover@linux.intel.com>
References: <cover.1714581792.git.andre.glover@linux.intel.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add the 'by_n' attribute to the acomp_req. The 'by_n' attribute can be
used a directive by acomp crypto algorithms for splitting compress and
decompress operations into "n" separate jobs.
 
Signed-off-by: Andre Glover <andre.glover@linux.intel.com>
---
 include/crypto/acompress.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/crypto/acompress.h b/include/crypto/acompress.h
index 2b73cef2f430..c687729e1966 100644
--- a/include/crypto/acompress.h
+++ b/include/crypto/acompress.h
@@ -25,6 +25,7 @@
  * @slen:	Size of the input buffer
  * @dlen:	Size of the output buffer and number of bytes produced
  * @flags:	Internal flags
+ * @by_n:	by_n setting used by acomp alg
  * @__ctx:	Start of private context data
  */
 struct acomp_req {
@@ -34,6 +35,7 @@ struct acomp_req {
 	unsigned int slen;
 	unsigned int dlen;
 	u32 flags;
+	u32 by_n;
 	void *__ctx[] CRYPTO_MINALIGN_ATTR;
 };
 
-- 
2.27.0


