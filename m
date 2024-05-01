Return-Path: <dmaengine+bounces-1976-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 429CD8B911F
	for <lists+dmaengine@lfdr.de>; Wed,  1 May 2024 23:46:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EC8F12840A9
	for <lists+dmaengine@lfdr.de>; Wed,  1 May 2024 21:46:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3BF8165FCA;
	Wed,  1 May 2024 21:46:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IdNHO6+q"
X-Original-To: dmaengine@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42D204F898;
	Wed,  1 May 2024 21:46:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714599995; cv=none; b=p/4QgMsPMYclWQMwvY8OPC+E7Lfxtqd1dOZtdnY+zSQ2dTJNk1nqTKnnprE12ihZMoTrN+A9mk3AqHY3kz28X9ldQy+C6TF5T6U6vSIFx/XUKjF+uoTX9w5sK+BqDaG3gyjuqN0UPYJ0qQ33upILwgKSL3VfrOa39bmZYjtXCuY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714599995; c=relaxed/simple;
	bh=2f5vPdonutO4FVTDMf62pMfW1qZlAhqJA03iBuAYN+0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=qAUZZxkTG2ibSUjLXyf45+8B/G1s7eRnOotHPVkvEEuAAYNeV3ku3WhyNgy4U1rDcOb+Ia7phmh4BvUNcHOk4jO2EstnZGyudHSy7hflw5ZMBWWz/4LicJT4hcGG8iPdULrEw5OQh19t90uNCqadTwATRFqTj3jndiysPhSZNew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=IdNHO6+q; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1714599995; x=1746135995;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=2f5vPdonutO4FVTDMf62pMfW1qZlAhqJA03iBuAYN+0=;
  b=IdNHO6+qi+uqqIflzkupDeX3hq0yh1YWWZ5vbDgwuhzUJ3GcFn0UPFca
   ejxGb1sIVzN7GyeLlY7+5toZOAkV65v9i/gPG7mQlalFeNvYJs45jcRSr
   dQeazzFBCVw28nxGTWqXXxgGeDs1EelTicV9oLHIHQZRUUYNwwGbvprO+
   8em06jABLnEaAUqeB/7u3nLDKFGyTJoh9JT1FehGX0d8sClI0KtV+hwZd
   hVsfWdbqLfhTyNlI+dRep0iK69F5EMIG4EMwwod7ApPl8sUdEX2QVX59C
   KLxiR0fD9E51eczFog7Uay3G491MGQghcm9Gp1mGKcKd3x4n39uKMPosi
   Q==;
X-CSE-ConnectionGUID: Wn0Afj7iSh+Gq40NNwf3Ig==
X-CSE-MsgGUID: juZmCfUwSiOBu1iHtW7+qQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11061"; a="14130147"
X-IronPort-AV: E=Sophos;i="6.07,246,1708416000"; 
   d="scan'208";a="14130147"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 May 2024 14:46:34 -0700
X-CSE-ConnectionGUID: vvcWl59ZSqq0x/bFRbB61g==
X-CSE-MsgGUID: GO8/KGW5RUelpqqTZehRTg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,246,1708416000"; 
   d="scan'208";a="31726379"
Received: from jf5300-b11a264t.jf.intel.com ([10.242.51.89])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 May 2024 14:46:33 -0700
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
Subject: [RFC PATCH 1/3] crypto: Add pre_alloc and post_free callbacks for acomp algorithms
Date: Wed,  1 May 2024 14:46:27 -0700
Message-Id: <4f6ebdb42f3a999cc77e81dc1ceeb4ea46f615df.1714581792.git.andre.glover@linux.intel.com>
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

Add callbacks to acomp crypto algorithms that facilitate the allocation and
subsequent freeing of resources required by an acomp_req before and after
a series of compress and/or decompress operations.

Signed-off-by: Andre Glover <andre.glover@linux.intel.com>
---
 crypto/acompress.c                  | 13 +++++++++++++
 include/crypto/acompress.h          |  2 ++
 include/crypto/internal/acompress.h |  6 ++++++
 3 files changed, 21 insertions(+)

diff --git a/crypto/acompress.c b/crypto/acompress.c
index 6fdf0ff9f3c0..873918be75cc 100644
--- a/crypto/acompress.c
+++ b/crypto/acompress.c
@@ -71,9 +71,13 @@ static int crypto_acomp_init_tfm(struct crypto_tfm *tfm)
 
 	acomp->compress = alg->compress;
 	acomp->decompress = alg->decompress;
+
 	acomp->dst_free = alg->dst_free;
 	acomp->reqsize = alg->reqsize;
 
+	acomp->pre_alloc = alg->pre_alloc;
+	acomp->post_free = alg->post_free;
+
 	if (alg->exit)
 		acomp->base.exit = crypto_acomp_exit_tfm;
 
@@ -129,6 +133,12 @@ struct acomp_req *acomp_request_alloc(struct crypto_acomp *acomp)
 	struct acomp_req *req;
 
 	req = __acomp_request_alloc(acomp);
+
+	if (req && (acomp->pre_alloc && acomp->pre_alloc(req))) {
+		__acomp_request_free(req);
+		return NULL;
+	}
+
 	if (req && (tfm->__crt_alg->cra_type != &crypto_acomp_type))
 		return crypto_acomp_scomp_alloc_ctx(req);
 
@@ -144,6 +154,9 @@ void acomp_request_free(struct acomp_req *req)
 	if (tfm->__crt_alg->cra_type != &crypto_acomp_type)
 		crypto_acomp_scomp_free_ctx(req);
 
+	if (acomp->post_free)
+		acomp->post_free(req);
+
 	if (req->flags & CRYPTO_ACOMP_ALLOC_OUTPUT) {
 		acomp->dst_free(req->dst);
 		req->dst = NULL;
diff --git a/include/crypto/acompress.h b/include/crypto/acompress.h
index 54937b615239..2b73cef2f430 100644
--- a/include/crypto/acompress.h
+++ b/include/crypto/acompress.h
@@ -51,6 +51,8 @@ struct acomp_req {
 struct crypto_acomp {
 	int (*compress)(struct acomp_req *req);
 	int (*decompress)(struct acomp_req *req);
+	int (*pre_alloc)(struct acomp_req *req);
+	void (*post_free)(struct acomp_req *req);
 	void (*dst_free)(struct scatterlist *dst);
 	unsigned int reqsize;
 	struct crypto_tfm base;
diff --git a/include/crypto/internal/acompress.h b/include/crypto/internal/acompress.h
index d00392d1988e..081e1cf5235f 100644
--- a/include/crypto/internal/acompress.h
+++ b/include/crypto/internal/acompress.h
@@ -29,6 +29,10 @@
  * @exit:	Deinitialize the cryptographic transformation object. This is a
  *		counterpart to @init, used to remove various changes set in
  *		@init.
+ * @pre_alloc:	Function that performs any pre-allocation and setup that an
+ *		algorithm may require on a per req basis.
+ * @post_free:	Function that performs any post freeing that an algorithm
+ *		may require on a per req basis.
  *
  * @reqsize:	Context size for (de)compression requests
  * @base:	Common crypto API algorithm data structure
@@ -40,6 +44,8 @@ struct acomp_alg {
 	void (*dst_free)(struct scatterlist *dst);
 	int (*init)(struct crypto_acomp *tfm);
 	void (*exit)(struct crypto_acomp *tfm);
+	int (*pre_alloc)(struct acomp_req *req);
+	void (*post_free)(struct acomp_req *req);
 
 	unsigned int reqsize;
 
-- 
2.27.0


