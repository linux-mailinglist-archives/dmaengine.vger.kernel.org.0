Return-Path: <dmaengine+bounces-12446-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 2003Ova2VWqYrwAAu9opvQ
	(envelope-from <dmaengine+bounces-12446-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Tue, 14 Jul 2026 06:11:34 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BD64750C0E
	for <lists+dmaengine@lfdr.de>; Tue, 14 Jul 2026 06:11:34 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=intel.com header.s=Intel header.b="AaehM/n+";
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-12446-lists+dmaengine=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="dmaengine+bounces-12446-lists+dmaengine=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=intel.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3ED323064718
	for <lists+dmaengine@lfdr.de>; Tue, 14 Jul 2026 04:11:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C67F73A0E93;
	Tue, 14 Jul 2026 04:11:12 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 401E533260D;
	Tue, 14 Jul 2026 04:11:10 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784002272; cv=none; b=B2Ysij2V36CXoFH2YSk/SVwH55IPznoAESF2U/Xe2OK6xqtBnUkxcfnNaW9vJ5eAa9Oz6z/E8pRveZOLw01npChrs1AflOBy6+AEXaGtwfTRSjm2AXtdWFHb+xh6z5WbP24hkaBkkcKHp1rxumlyeVd2kXG38RqBvJsMIQxQQ8c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784002272; c=relaxed/simple;
	bh=L3Y/ZhlIUAdgtnzQ8lUOWFMcEcKiOgfI+ea8lVssSmA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=h//ydWTU/hZhPT3EFMfFkiXLT6467kbcpYJ2Jffs8di4aZCN7jQ6+kmoUUOiLOsD1JprNWkCEsYgaIvCWTWBEu8ziR13s8FgqwibkTYWa6pLtYoxWKGW+fmj7rAXObpXW/qAtS2cnYdxhHJSf9yQy/J73FrN5O9lAPrbp9aVo3k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=AaehM/n+; arc=none smtp.client-ip=198.175.65.11
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1784002271; x=1815538271;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=L3Y/ZhlIUAdgtnzQ8lUOWFMcEcKiOgfI+ea8lVssSmA=;
  b=AaehM/n+B2n8hEnathO+HSjTdP/rI0tDVuhR4xnNjzlV8PVgNxAEgE2v
   X7DoCmcJLoLrxNOkPeZ8SlijZ9jZpjgFKnif0mNwbMF+13mKNqZ4I9Guz
   gIBRRwQPBfNVIviO2eR2g+TCFhkp2AgewhKUze9ud/+RxSA7CfLMcSmte
   M4jwOm7MDLwjn5c9ZBVnj+f9NPHq7MmYTDe02H2ukaeQ1BZ3hLpUjfFnV
   xwyHFnMmAN7g1BW68ULvtT8vj0Qk65KOFBypVopjyNGSS9xSR7ZlkhgAD
   BwLMjSIpW8VUr6WlEdK60u54aP0BHgfeiXJ2ZlgAW10b7kWVhT4w1A8+Z
   Q==;
X-CSE-ConnectionGUID: miEbIP2xR9epszjUC4zuvQ==
X-CSE-MsgGUID: EvGUMusRSJqyfUcSYAHWcg==
X-IronPort-AV: E=McAfee;i="6800,10657,11841"; a="94970475"
X-IronPort-AV: E=Sophos;i="6.25,154,1779174000"; 
   d="scan'208";a="94970475"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jul 2026 21:11:09 -0700
X-CSE-ConnectionGUID: odysYgFMRKOoBMNAGYmqaw==
X-CSE-MsgGUID: P+KZyl3DTPCvt9IndM10Sg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,154,1779174000"; 
   d="scan'208";a="249383514"
Received: from vcostago-desk1.jf.intel.com (HELO [10.88.27.144]) ([10.88.27.144])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jul 2026 21:11:08 -0700
From: Vinicius Costa Gomes <vinicius.gomes@intel.com>
Date: Mon, 13 Jul 2026 21:10:53 -0700
Subject: [PATCH 1/4] dmaengine: idxd: assign all engines to group 0 in IAA
 defaults
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260713-iaa-crypto-fixes-zswap-v1-1-65cac23c684d@intel.com>
References: <20260713-iaa-crypto-fixes-zswap-v1-0-65cac23c684d@intel.com>
In-Reply-To: <20260713-iaa-crypto-fixes-zswap-v1-0-65cac23c684d@intel.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1784002267; l=1499;
 i=vinicius.gomes@intel.com; s=20230921; h=from:subject:message-id;
 bh=xEF5rE7vTRk6IDCo/9ghupdOtafn6T+gs8mY4/r6VAw=;
 b=N6Mw9Q1NKOEhwmlGvfA96K5AEcH6ElUOu9RTH1fesoeFaQrwVNyXc9ioi1SsD2gRhppk7AHRO
 SCUVYSb0rH3BZZi8A101C/N3/ZNEhrAOooUX5iujkeHsSVTGY8kqBPA
X-Developer-Key: i=vinicius.gomes@intel.com; a=ed25519;
 pk=aJkrtgqgT6TZ8iIHSG8/rTPsmlYnjMrUjCsMYvCzntk=
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-5.16 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[intel.com:d:+,kernel.org:s:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
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
	TAGGED_FROM(0.00)[bounces-12446-lists,dmaengine=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[dmaengine];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 4BD64750C0E

From: Giovanni Cabiddu <giovanni.cabiddu@intel.com>

The IAA device defaults only assigned engine 0 to group 0, leaving
engines 1 through max_engines-1 unassigned (group_id = -1). This means
that by default only a single engine processed descriptors, limiting
throughput to one engine's capacity.

Assign all available engines to group 0 so that the full hardware
parallelism is used out of the box without requiring manual
accel-config setup.

Signed-off-by: Giovanni Cabiddu <giovanni.cabiddu@intel.com>
---
 drivers/dma/idxd/defaults.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/drivers/dma/idxd/defaults.c b/drivers/dma/idxd/defaults.c
index 2bbbcd02a0da..26ebfa2ca144 100644
--- a/drivers/dma/idxd/defaults.c
+++ b/drivers/dma/idxd/defaults.c
@@ -8,6 +8,7 @@ int idxd_load_iaa_device_defaults(struct idxd_device *idxd)
 	struct idxd_engine *engine;
 	struct idxd_group *group;
 	struct idxd_wq *wq;
+	int i;
 
 	if (!test_bit(IDXD_FLAG_CONFIGURABLE, &idxd->flags))
 		return 0;
@@ -41,11 +42,12 @@ int idxd_load_iaa_device_defaults(struct idxd_device *idxd)
 	/* set driver_name to "crypto" */
 	strscpy_pad(wq->driver_name, "crypto");
 
-	engine = idxd->engines[0];
-
-	/* set engine group to 0 */
-	engine->group = idxd->groups[0];
-	engine->group->num_engines++;
+	/* assign all engines to group 0 */
+	for (i = 0; i < idxd->max_engines; i++) {
+		engine = idxd->engines[i];
+		engine->group = group;
+		group->num_engines++;
+	}
 
 	return 0;
 }

-- 
2.55.0


