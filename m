Return-Path: <dmaengine+bounces-1253-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A966870C4D
	for <lists+dmaengine@lfdr.de>; Mon,  4 Mar 2024 22:20:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 56F9D1C22023
	for <lists+dmaengine@lfdr.de>; Mon,  4 Mar 2024 21:20:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1369861675;
	Mon,  4 Mar 2024 21:20:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="eMY5O0ev"
X-Original-To: dmaengine@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68B341CA94;
	Mon,  4 Mar 2024 21:20:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709587219; cv=none; b=TDhzIzzsTln+PFjRKWqSPBkyU1HJ+Bc5EsJqBk4V1oM/RQHBvVCzq1rduUMwCRt7wBrUhQ4wMMsVPKkAlrNjXPdshGcSnaqnsSk9OBU0apLcpMpBj1MflgYL6VL1nsAGBZO8WTDiXwEXqTUtqGs/bGdOC6E6s0kI7Vf7ny7Er+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709587219; c=relaxed/simple;
	bh=eU7Jo/MR9r3fRg1e0tpJ5oBtSYejjJ4b+4ybyBP5Qwc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Yhrvq2Lyf1MSINMsxzy+gIaCEdkHoitEQjGeJDHRvcqoCxfenUbrygKgYfcIoc5klegKfHTNuQdcqwfdwpILrQvsTcNG2s0jlpzZlgXCvnWP1X5Y2SPAfJ8r40v69xeNCNCf/3pltwTME6qoEFe9PEf+W6enG9KaGLU+FlRl/cw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=eMY5O0ev; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709587218; x=1741123218;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=eU7Jo/MR9r3fRg1e0tpJ5oBtSYejjJ4b+4ybyBP5Qwc=;
  b=eMY5O0evWu5phIhOl4sdZMd4LA2d7uS01jNKrjhRG26N6JktoMV+6Wir
   vh2cQSWM7HPuuu3qKxwvwWxDe+1jSYkxL3gczSlC7vtmfZEuBwV7AeHZh
   lhnaItrci96ktM4GxkQxOe38+GAleD1l+jnfblx41/6caxmtqO9ZTqPKx
   4wf8+xbk5074AazS7dnqFgC6CWy8RnChM2JoZac7+bOb/qpPWyw/OiFlQ
   S+bVdPeG5zb8JILU7/PZmYqBiv+s+XvMRN7ETZljlPadd2sQ/Kly6vvjA
   hLU7+u4R7sQkP/hgRiXWABpYIPIFOCdFJdnC1CPbbvgeYkALqmb9opfOG
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,11003"; a="4271342"
X-IronPort-AV: E=Sophos;i="6.06,204,1705392000"; 
   d="scan'208";a="4271342"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Mar 2024 13:20:17 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,204,1705392000"; 
   d="scan'208";a="9040245"
Received: from skedaras-mobl1.amr.corp.intel.com (HELO tzanussi-mobl1.amr.corp.intel.com) ([10.212.77.241])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Mar 2024 13:20:16 -0800
From: Tom Zanussi <tom.zanussi@linux.intel.com>
To: herbert@gondor.apana.org.au,
	davem@davemloft.net
Cc: andre.glover@linux.intel.com,
	linux-kernel@vger.kernel.org,
	linux-crypto@vger.kernel.org,
	dmaengine@vger.kernel.org
Subject: [PATCH 1/4] crypto: iaa - fix decomp_bytes_in stats
Date: Mon,  4 Mar 2024 15:20:08 -0600
Message-Id: <20240304212011.1525003-2-tom.zanussi@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240304212011.1525003-1-tom.zanussi@linux.intel.com>
References: <20240304212011.1525003-1-tom.zanussi@linux.intel.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Decomp stats should use slen, not dlen.  Change both the global and
per-wq stats to use the correct value.

Signed-off-by: Tom Zanussi <tom.zanussi@linux.intel.com>
---
 drivers/crypto/intel/iaa/iaa_crypto_main.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/crypto/intel/iaa/iaa_crypto_main.c b/drivers/crypto/intel/iaa/iaa_crypto_main.c
index b54f93c64033..466bd0c71816 100644
--- a/drivers/crypto/intel/iaa/iaa_crypto_main.c
+++ b/drivers/crypto/intel/iaa/iaa_crypto_main.c
@@ -1075,8 +1075,8 @@ static void iaa_desc_complete(struct idxd_desc *idxd_desc,
 		update_total_comp_bytes_out(ctx->req->dlen);
 		update_wq_comp_bytes(iaa_wq->wq, ctx->req->dlen);
 	} else {
-		update_total_decomp_bytes_in(ctx->req->dlen);
-		update_wq_decomp_bytes(iaa_wq->wq, ctx->req->dlen);
+		update_total_decomp_bytes_in(ctx->req->slen);
+		update_wq_decomp_bytes(iaa_wq->wq, ctx->req->slen);
 	}
 
 	if (ctx->compress && compression_ctx->verify_compress) {
-- 
2.34.1


