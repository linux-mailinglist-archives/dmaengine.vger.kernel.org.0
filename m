Return-Path: <dmaengine+bounces-568-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 62437817C3A
	for <lists+dmaengine@lfdr.de>; Mon, 18 Dec 2023 21:48:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5668FB2282C
	for <lists+dmaengine@lfdr.de>; Mon, 18 Dec 2023 20:48:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E86BB768ED;
	Mon, 18 Dec 2023 20:47:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Q0b0Jcxh"
X-Original-To: dmaengine@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73525760B8;
	Mon, 18 Dec 2023 20:47:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702932445; x=1734468445;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=H3CG4H1LUs2Woscc050DD/D/Uqec+fLNo2IJXSopJ5k=;
  b=Q0b0Jcxh9qdIk2DdiP1G/KKjs1rBKHgwDhPCfEIdN7B/aXRWXXvyg8yW
   k04XRVIMq5t8iB1jr+lYjqsYwEHPf2rfFzJ4MblnGpvHqZz7EWnLrjLPo
   zeftC2TFEXHRwpHhuh6/UQ4PBvylXWozsY133IEgYAaC77SqF7AHBLOrV
   ufURkTm2h3sNe1PPqlWjAKDNpfMvbkbk+y52zYLo70SCMb3JTUpyPxqcr
   OcyJUGJrWARz4SUtPt+jJPdwHr57yLPZ0AlhYXgud3pHYCLiFIpgCOjQs
   fSbFyFSu899nXThrfr7UPtO7TNpINDI6NpIORhx8IvBKafJDi4zflYouT
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10928"; a="462015894"
X-IronPort-AV: E=Sophos;i="6.04,286,1695711600"; 
   d="scan'208";a="462015894"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Dec 2023 12:47:25 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10928"; a="899101534"
X-IronPort-AV: E=Sophos;i="6.04,286,1695711600"; 
   d="scan'208";a="899101534"
Received: from ssomasun-mobl1.amr.corp.intel.com (HELO tzanussi-mobl1.hsd1.il.comcast.net) ([10.212.116.107])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Dec 2023 12:47:24 -0800
From: Tom Zanussi <tom.zanussi@linux.intel.com>
To: herbert@gondor.apana.org.au,
	davem@davemloft.net,
	fenghua.yu@intel.com
Cc: dave.jiang@intel.com,
	tony.luck@intel.com,
	jacob.jun.pan@intel.com,
	christophe.jaillet@wanadoo.fr,
	linux-kernel@vger.kernel.org,
	linux-crypto@vger.kernel.org,
	dmaengine@vger.kernel.org
Subject: [PATCH 2/2] crypto: iaa - Remove unneeded newline in update_max_adecomp_delay_ns()
Date: Mon, 18 Dec 2023 14:47:15 -0600
Message-Id: <20231218204715.220299-3-tom.zanussi@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231218204715.220299-1-tom.zanussi@linux.intel.com>
References: <20231218204715.220299-1-tom.zanussi@linux.intel.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Remove a stray newline in update_max_adecomp_delay_ns().

Reported-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Signed-off-by: Tom Zanussi <tom.zanussi@linux.intel.com>
---
 drivers/crypto/intel/iaa/iaa_crypto_stats.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/crypto/intel/iaa/iaa_crypto_stats.c b/drivers/crypto/intel/iaa/iaa_crypto_stats.c
index 0279edc6194e..2e3b7b73af20 100644
--- a/drivers/crypto/intel/iaa/iaa_crypto_stats.c
+++ b/drivers/crypto/intel/iaa/iaa_crypto_stats.c
@@ -109,7 +109,6 @@ void update_max_adecomp_delay_ns(u64 start_time_ns)
 	time_diff = ktime_get_ns() - start_time_ns;
 
 	if (time_diff > max_adecomp_delay_ns)
-
 		max_adecomp_delay_ns = time_diff;
 }
 
-- 
2.34.1


