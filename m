Return-Path: <dmaengine+bounces-12445-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 8oBDDeK2VWqUrwAAu9opvQ
	(envelope-from <dmaengine+bounces-12445-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Tue, 14 Jul 2026 06:11:14 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 396A5750BFF
	for <lists+dmaengine@lfdr.de>; Tue, 14 Jul 2026 06:11:13 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=intel.com header.s=Intel header.b=cZKudavU;
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-12445-lists+dmaengine=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="dmaengine+bounces-12445-lists+dmaengine=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=intel.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0AA21302DF70
	for <lists+dmaengine@lfdr.de>; Tue, 14 Jul 2026 04:11:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7336533B6F1;
	Tue, 14 Jul 2026 04:11:11 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C30C31C56D;
	Tue, 14 Jul 2026 04:11:08 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784002271; cv=none; b=JCktXjD+QVRuA0KxNflJySFVGNMx/wxcNZ3HSmQ2QNzGi3LmnNfe2HQII9+M1Qhv1SIGoJCQmn24R4HPudkstu8wfo5gzatRNGFD1lYEk9Qy4hxfoLuXO06gnarSeU/aSqe+HmCJDgDmkvc/ZU6XOv724VLwtx6KN0CsR/pqAgM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784002271; c=relaxed/simple;
	bh=EkMrq2fq+kdV/RvjKR48hty+vUzZfNwFC7L29I8jEjE=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=j1jPx4cHAwCRYZlEvupY6FkyUOJ5j3Y8mQDOWPYvEFL98Na8+sNOpqKrJEn48p4cXuU+tcKCaq3Ra9v5JkkMkwqNpnQjqs2CQLkXNhyO9reJFMmKgtwmUVZt0bfb0zrMF4if+oe1hyfgmIFTElq45FMJD8QiLtS1b/85fvDaf5g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cZKudavU; arc=none smtp.client-ip=198.175.65.11
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1784002270; x=1815538270;
  h=from:subject:date:message-id:mime-version:
   content-transfer-encoding:to:cc;
  bh=EkMrq2fq+kdV/RvjKR48hty+vUzZfNwFC7L29I8jEjE=;
  b=cZKudavUNa5jVHfiZuCqaC89C4J/GMnZ3wGSC+AdPVkgf7+98gY0l3e1
   hyeXyxCr+9DK4Qdcm/tSQiB93AcHk0NepmEPyEP1Iu1Cy7vq4cSaYTiMm
   W2/0cawRvubzdBCEvbyDzBLbEs/6rjhtSPnHqiLdhQAvl2l8cT4GtDVq6
   PJh+ZvXWlnTmbhVepkkPUQSOQKRcCA8/dZqL0w2py5UFX+CoyCjHVoZHO
   OhyYkbNeyCnj64CGiVzzk3zgc3JIFGQQ3L4Pn4JS6ZTpaRw6dM5Q08JiA
   OdYdjmlST0joGeCZfaYtJJ5NRwSGW7cPl2QYNITuQW1sv6I+VPZyajK6k
   w==;
X-CSE-ConnectionGUID: IlOg9RR0S7SEoz9x6/JfOQ==
X-CSE-MsgGUID: iMKno+jgR6OwrF85NeNQvQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11841"; a="94970471"
X-IronPort-AV: E=Sophos;i="6.25,154,1779174000"; 
   d="scan'208";a="94970471"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jul 2026 21:11:09 -0700
X-CSE-ConnectionGUID: 5tmtqeLTRY6+6KzlpEmOwA==
X-CSE-MsgGUID: fIV8zmubSaOlJ6p/83A+9A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,154,1779174000"; 
   d="scan'208";a="249383510"
Received: from vcostago-desk1.jf.intel.com (HELO [10.88.27.144]) ([10.88.27.144])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jul 2026 21:11:08 -0700
From: Vinicius Costa Gomes <vinicius.gomes@intel.com>
Subject: [PATCH 0/4] crypto: iaa - Fixes for multi entry SG lists
Date: Mon, 13 Jul 2026 21:10:52 -0700
Message-Id: <20260713-iaa-crypto-fixes-zswap-v1-0-65cac23c684d@intel.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yXMywqDQAyF4VeRrA0YRQt9ldJFHDM2XegwsV4qv
 nvHuvw4/GcHk6hicM92iDKr6TgkUJ6Be/HQC2qXDGVRNsWNKlRmdHEL04heVzH82sIBva9bZqm
 IOoIUhyj/ObWP52X7tG9x0/kGx/EDXCZXRXoAAAA=
X-Change-ID: 20260713-iaa-crypto-fixes-zswap-ff5baae311d1
To: Dave Jiang <dave.jiang@intel.com>, Vinod Koul <vkoul@kernel.org>, 
 Frank Li <Frank.Li@kernel.org>, 
 Kristen Accardi <kristen.c.accardi@intel.com>, 
 Herbert Xu <herbert@gondor.apana.org.au>, 
 "David S. Miller" <davem@davemloft.net>, 
 Andrew Morton <akpm@linux-foundation.org>, Yosry Ahmed <yosry@kernel.org>, 
 Nhat Pham <nphamcs@gmail.com>
Cc: dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-crypto@vger.kernel.org, 
 Vinicius Costa Gomes <vinicius.gomes@intel.com>, 
 Giovanni Cabiddu <giovanni.cabiddu@intel.com>
X-Mailer: b4 0.16-dev-4217c
X-Developer-Signature: v=1; a=ed25519-sha256; t=1784002267; l=1925;
 i=vinicius.gomes@intel.com; s=20230921; h=from:subject:message-id;
 bh=EkMrq2fq+kdV/RvjKR48hty+vUzZfNwFC7L29I8jEjE=;
 b=VXL0glBcu49y0XSDNxfckPJ4DcurDH/Pajc594Rz9rPh4ZE6rMbZC3jJ1XB9ipoE2UE6O8rnM
 VkFb1KfFnzOBcEiezRttOMVS+HzGX8r9ud84iWfljiNwlh6GUewpjrB
X-Developer-Key: i=vinicius.gomes@intel.com; a=ed25519;
 pk=aJkrtgqgT6TZ8iIHSG8/rTPsmlYnjMrUjCsMYvCzntk=
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-5.16 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[intel.com:d:+,kernel.org:s:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[14];
	FORGED_RECIPIENTS(0.00)[m:dave.jiang@intel.com,m:vkoul@kernel.org,m:Frank.Li@kernel.org,m:kristen.c.accardi@intel.com,m:herbert@gondor.apana.org.au,m:davem@davemloft.net,m:akpm@linux-foundation.org,m:yosry@kernel.org,m:nphamcs@gmail.com,m:dmaengine@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-crypto@vger.kernel.org,m:vinicius.gomes@intel.com,m:giovanni.cabiddu@intel.com,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[intel.com,kernel.org,gondor.apana.org.au,davemloft.net,linux-foundation.org,gmail.com];
	FORGED_SENDER(0.00)[vinicius.gomes@intel.com,dmaengine@vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-12445-lists,dmaengine=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[vinicius.gomes@intel.com,dmaengine@vger.kernel.org];
	DKIM_TRACE(0.00)[intel.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[dmaengine];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 396A5750BFF

Since commit e2c3b6b21c77 ("mm: zswap: use SG list decompression APIs
from zsmalloc"), iaa_crypto started seeing some failures with
multi-entry scatter lists.

For that we introduce software fallback, in patch 2/4, to iaa-crypto
when SG lists have more than one entry, for both input and output.
Patch 4/4 adds a bounce buffer so small/simple requests can be
linearized and sent to the hardware. This recovers most of the
performance.

Patch 1/4 updates the default resources reserved to iaa-crypto so more
engines are associated to the iaa_crypto group, resulting in better
utilization by default. Patch 3/4 fixes so software requests are not
double counted. As the idxd changes only affect iaa_crypto, sending
them here makes more sense.

It should be noted that as the software and hardware implementations
have different expectations for the window size, something like patch
[1] or the future 'set_params()' API are needed to verify that patch
2/4 works without patch 4/4.

[1] https://lore.kernel.org/linux-crypto/20260326100433.57324-1-giovanni.cabiddu@intel.com/

Cheers,

Signed-off-by: Vinicius Costa Gomes <vinicius.gomes@intel.com>
---
Giovanni Cabiddu (4):
      dmaengine: idxd: assign all engines to group 0 in IAA defaults
      crypto: iaa - fall back to software for multi-entry scatterlists
      crypto: iaa - avoid counting fallback decompression bytes
      crypto: iaa - use bounce buffer for multi-sg decompress input

 drivers/crypto/intel/iaa/iaa_crypto_main.c  | 236 ++++++++++++++++++++--------
 drivers/crypto/intel/iaa/iaa_crypto_stats.c |  11 +-
 drivers/crypto/intel/iaa/iaa_crypto_stats.h |   2 +
 drivers/dma/idxd/defaults.c                 |  12 +-
 4 files changed, 186 insertions(+), 75 deletions(-)
---
base-commit: b73b71df4cb4ca241165ad31218c82dfe489147c
change-id: 20260713-iaa-crypto-fixes-zswap-ff5baae311d1

Best regards,
--  
Vinicius


