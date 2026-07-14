Return-Path: <dmaengine+bounces-12447-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id XEFeFOi2VWqWrwAAu9opvQ
	(envelope-from <dmaengine+bounces-12447-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Tue, 14 Jul 2026 06:11:20 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B6C19750C06
	for <lists+dmaengine@lfdr.de>; Tue, 14 Jul 2026 06:11:19 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=intel.com header.s=Intel header.b=CSmEQYGz;
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-12447-lists+dmaengine=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="dmaengine+bounces-12447-lists+dmaengine=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=intel.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 580BC304168F
	for <lists+dmaengine@lfdr.de>; Tue, 14 Jul 2026 04:11:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 553FB3B9D9A;
	Tue, 14 Jul 2026 04:11:13 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9A4E36AB77;
	Tue, 14 Jul 2026 04:11:11 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784002273; cv=none; b=Q5VeEBNrkhDLZzdEHwQohrlTKBER4mF0o03d2z3nq1l7t//TMv5I9RapklxvD2CCkA1RjvzHyXPuYBwRkKue4THoEKSwcmCuDuNgFEztoe9Ot+Gj2b9rLoz1jwzHHpe926Mj3UXaSTHAPthGi9LM6cssC2oLadt6wWHXI5fblsk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784002273; c=relaxed/simple;
	bh=DimQniesOwePrAQW8cknWA9ZqhNGU3Pe01x+pNQhS2w=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=r/mxyEsyUg7Zl5dCrzH0HIXZc2h59v+1BZFbyj9GTYQFuTmBux5v04+VVeXecVyA4lJXAGNQhoia3CAHm6UJzBZWMPZecd4sGpOj6jcWu3GscnQdC/maesz+0tea3xBFA4onduciOuFPdxfyjYxsLQw6A9yUFhMW0GDaa82PU00=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CSmEQYGz; arc=none smtp.client-ip=198.175.65.11
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1784002272; x=1815538272;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=DimQniesOwePrAQW8cknWA9ZqhNGU3Pe01x+pNQhS2w=;
  b=CSmEQYGzIq8IHCPxhqzhl6IutPivQMinfoTw2H9DeN/HdZN6aZVXq0xR
   ixjP3lognvdl5MyvUCdtT/Sf0CwiOUARqHtNJhVR0DZVb8Sy771mQcSTV
   sz2Dk02MBhhdEidlLDgrZJEJbI917NKeEv60D9yy0yA7VRipOuT7c1aqS
   YmBKnMJPWnE9arEUw80LOhx1eZhMEu/AJNQAf1F1ateV2m1EOsIdC800t
   gsFcxTjrwupvBOHmbDZ4icTjE/ck7ED7+vE107lV5mulK0HkLeRXvq4Km
   heFWYaisVBeymDVHnymW7HKNe4aplf9uuaXzcG1Mf7CXs3gKpy6UpSE4A
   A==;
X-CSE-ConnectionGUID: VICxpeFRSM2UOKjnxTni7w==
X-CSE-MsgGUID: dthsovrtSoeIqIJpmwWd0w==
X-IronPort-AV: E=McAfee;i="6800,10657,11841"; a="94970487"
X-IronPort-AV: E=Sophos;i="6.25,154,1779174000"; 
   d="scan'208";a="94970487"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jul 2026 21:11:10 -0700
X-CSE-ConnectionGUID: JYn3O0UXR0KxeqAW3xbqaA==
X-CSE-MsgGUID: df/vGAT3S42mrFH0iBy5TA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,154,1779174000"; 
   d="scan'208";a="249383520"
Received: from vcostago-desk1.jf.intel.com (HELO [10.88.27.144]) ([10.88.27.144])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jul 2026 21:11:09 -0700
From: Vinicius Costa Gomes <vinicius.gomes@intel.com>
Date: Mon, 13 Jul 2026 21:10:55 -0700
Subject: [PATCH 3/4] crypto: iaa - avoid counting fallback decompression
 bytes
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260713-iaa-crypto-fixes-zswap-v1-3-65cac23c684d@intel.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1784002267; l=1906;
 i=vinicius.gomes@intel.com; s=20230921; h=from:subject:message-id;
 bh=Bzzsxw3x1+Awdq1YVut9OLn/yRKJ1WIjPIJmOnYqEXs=;
 b=jcqR1EHjhR2o3aNkqtGmNPbjADHFM/OXYYkPRUBbe8ylwoaFOvv+3NpmqKMgiTsJ+2RWgFNSp
 yi3C0wYFidkCEWTrr+IEC+9EyxeqBdCYuyt1hXv9EpwvWYijnmRXq5/
X-Developer-Key: i=vinicius.gomes@intel.com; a=ed25519;
 pk=aJkrtgqgT6TZ8iIHSG8/rTPsmlYnjMrUjCsMYvCzntk=
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-5.16 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[intel.com:d:+,kernel.org:s:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
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
	TAGGED_FROM(0.00)[bounces-12447-lists,dmaengine=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[dmaengine];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: B6C19750C06

From: Giovanni Cabiddu <giovanni.cabiddu@intel.com>

When decompression falls back to deflate-generic after an analytics
error, the request no longer completes through IAA.

Move decompression byte accounting into the successful IAA completion
path in both the synchronous and asynchronous flows so decomp_bytes only
reflects bytes actually processed by IAA.

Signed-off-by: Giovanni Cabiddu <giovanni.cabiddu@intel.com>
---
 drivers/crypto/intel/iaa/iaa_crypto_main.c | 16 +++++++++-------
 1 file changed, 9 insertions(+), 7 deletions(-)

diff --git a/drivers/crypto/intel/iaa/iaa_crypto_main.c b/drivers/crypto/intel/iaa/iaa_crypto_main.c
index fb154959c2aa..8f68b1478476 100644
--- a/drivers/crypto/intel/iaa/iaa_crypto_main.c
+++ b/drivers/crypto/intel/iaa/iaa_crypto_main.c
@@ -1084,15 +1084,17 @@ static void iaa_desc_complete(struct idxd_desc *idxd_desc,
 		}
 	} else {
 		ctx->req->dlen = idxd_desc->iax_completion->output_size;
+
+		if (!ctx->compress) {
+			update_total_decomp_bytes_in(ctx->req->slen);
+			update_wq_decomp_bytes(iaa_wq->wq, ctx->req->slen);
+		}
 	}
 
 	/* Update stats */
 	if (ctx->compress) {
 		update_total_comp_bytes_out(ctx->req->dlen);
 		update_wq_comp_bytes(iaa_wq->wq, ctx->req->dlen);
-	} else {
-		update_total_decomp_bytes_in(ctx->req->slen);
-		update_wq_decomp_bytes(iaa_wq->wq, ctx->req->slen);
 	}
 
 	if (ctx->compress && compression_ctx->verify_compress) {
@@ -1475,16 +1477,16 @@ static int iaa_decompress(struct crypto_tfm *tfm, struct acomp_req *req,
 		}
 	} else {
 		req->dlen = idxd_desc->iax_completion->output_size;
+
+		/* Update stats */
+		update_total_decomp_bytes_in(slen);
+		update_wq_decomp_bytes(wq, slen);
 	}
 
 	*dlen = req->dlen;
 
 	if (!ctx->async_mode)
 		idxd_free_desc(wq, idxd_desc);
-
-	/* Update stats */
-	update_total_decomp_bytes_in(slen);
-	update_wq_decomp_bytes(wq, slen);
 out:
 	return ret;
 err:

-- 
2.55.0


