Return-Path: <dmaengine+bounces-1106-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BF0CC862CBE
	for <lists+dmaengine@lfdr.de>; Sun, 25 Feb 2024 21:12:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9DDE0B2127D
	for <lists+dmaengine@lfdr.de>; Sun, 25 Feb 2024 20:12:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E2471B964;
	Sun, 25 Feb 2024 20:11:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nWwBQbqf"
X-Original-To: dmaengine@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9B5B1B94E;
	Sun, 25 Feb 2024 20:11:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708891917; cv=none; b=crrEQs3dzHCEsMMcvmXHV5sQKrdbHVoFcAWQiupECDCBSj/qe18OkXbDsc9ueouTxZRZ4kwQodXg2+KLVkWntCXizNrxkFFhlHSbN4wfvlGAEffnqfANpO+oo8ug15qVNZjNx2GTtGDkCvJqoXqvaN72G3z4vadH0LBmVthM0LQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708891917; c=relaxed/simple;
	bh=RrgThNA6gJ27x/H2iomavl1lACtwfsXPwPzv+anoH2Y=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=qH1S0AtFMpfUyrv8umFZVOz83M0Cc0LyvzLYm5GEXNhael0CxxZf+PngZy9wesS1B3Jhphv3MiPloIy8IYqKiMAyxlcIvBvDM7iL/arkadNOer5i7LSSHVqwF8H7InzZdXLIclElaV+BdJ1pBcm3+5ku7J2wVyoRQR9Mh2a6ULc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nWwBQbqf; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708891916; x=1740427916;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=RrgThNA6gJ27x/H2iomavl1lACtwfsXPwPzv+anoH2Y=;
  b=nWwBQbqfbKLUzUnCpUx48LWGHb49/4H+Q4jXmEGGqrCFiKt/KsV7zHMR
   J9i7iSm3MlfgX7/QxfrSiJImfW1DmG1V/+XGMD7xCh0npI+/g6Jq/5nQV
   wLkp8RQgzAINlIC0elOQC9U0ZxSYwjmJnlyz5N6PW0NvTzvRI1Q+W+8X1
   Zci6M16t/lWCYaNEC4SuWxS3/x/CkLEWxDHtQs9SaHwux+RUtuNFkMMkU
   O/YJ33QbRz1Z9dqrA9NKd14KeY48CCf3FENM/B0hS0W3+8C+mtoAH6YCS
   RURpGTlVgnIATZeWeRgNUZhdAJ6/fFNOBmrPOoY3IryrDuxdUWMIEa8Sg
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10995"; a="25639530"
X-IronPort-AV: E=Sophos;i="6.06,185,1705392000"; 
   d="scan'208";a="25639530"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Feb 2024 12:11:56 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,185,1705392000"; 
   d="scan'208";a="29632551"
Received: from rfredric-mobl.amr.corp.intel.com (HELO tzanussi-mobl1.amr.corp.intel.com) ([10.213.171.152])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Feb 2024 12:11:55 -0800
From: Tom Zanussi <tom.zanussi@linux.intel.com>
To: herbert@gondor.apana.org.au,
	davem@davemloft.net
Cc: rex.zhang@intel.com,
	andre.glover@linux.intel.com,
	linux-kernel@vger.kernel.org,
	linux-crypto@vger.kernel.org,
	dmaengine@vger.kernel.org
Subject: [PATCH 1/2] crypto: iaa - Fix async_disable descriptor leak
Date: Sun, 25 Feb 2024 14:11:33 -0600
Message-Id: <20240225201134.759335-2-tom.zanussi@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240225201134.759335-1-tom.zanussi@linux.intel.com>
References: <20240225201134.759335-1-tom.zanussi@linux.intel.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The disable_async paths of iaa_compress/decompress() don't free idxd
descriptors in the async_disable case. Currently this only happens in
the testcases where req->dst is set to null. Add a test to free them
in those paths.

Signed-off-by: Tom Zanussi <tom.zanussi@linux.intel.com>
---
 drivers/crypto/intel/iaa/iaa_crypto_main.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/crypto/intel/iaa/iaa_crypto_main.c b/drivers/crypto/intel/iaa/iaa_crypto_main.c
index 39a5fc905c4d..85ee4c965ccf 100644
--- a/drivers/crypto/intel/iaa/iaa_crypto_main.c
+++ b/drivers/crypto/intel/iaa/iaa_crypto_main.c
@@ -1222,7 +1222,7 @@ static int iaa_compress(struct crypto_tfm *tfm,	struct acomp_req *req,
 
 	*compression_crc = idxd_desc->iax_completion->crc;
 
-	if (!ctx->async_mode)
+	if (!ctx->async_mode || disable_async)
 		idxd_free_desc(wq, idxd_desc);
 out:
 	return ret;
@@ -1468,7 +1468,7 @@ static int iaa_decompress(struct crypto_tfm *tfm, struct acomp_req *req,
 
 	*dlen = req->dlen;
 
-	if (!ctx->async_mode)
+	if (!ctx->async_mode || disable_async)
 		idxd_free_desc(wq, idxd_desc);
 
 	/* Update stats */
-- 
2.34.1


