Return-Path: <dmaengine+bounces-1975-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 19CDB8B911D
	for <lists+dmaengine@lfdr.de>; Wed,  1 May 2024 23:46:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C4B59284144
	for <lists+dmaengine@lfdr.de>; Wed,  1 May 2024 21:46:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 448B6165FB6;
	Wed,  1 May 2024 21:46:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FqTQ3fkq"
X-Original-To: dmaengine@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 626904D5BF;
	Wed,  1 May 2024 21:46:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714599995; cv=none; b=GulRn3YGyra5WP2w+YyevxD9w+vbfaZWFPcBW9QX/Cqg+OEPqVIRajpoyOGX8J5Kln1C5M71ZPSmHPQISQ6gwNEwZaCbEE3NCi1mZAg9Bb98t0z0eo9NQK9mHDs/Lx/DH7YGdmQeEshkK3l9cEWf8baJFcfgBqEoqLb7Hlke0Bk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714599995; c=relaxed/simple;
	bh=RO7P29qn1M22iniMK6HK7Pgb3F+22AoEOD8lP3wry/8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=NhBVYDTcQis8wySL2XmNLcNeYUzDOtT0MddDOGGxoM8Pz/Oks5dv3I31ceUbh8Kf3z2RcDWHyl3kKYqM2NDAoyDH1f2QizjtYrj6rUYetJ2e7oAe3rCZTP0N6byOBVTT560ClVcJ+0iN5+QH7GXRwkX1FcRJGyb4GQFov0VYpso=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FqTQ3fkq; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1714599994; x=1746135994;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=RO7P29qn1M22iniMK6HK7Pgb3F+22AoEOD8lP3wry/8=;
  b=FqTQ3fkqtyS1T1XxpdWv0lz+FlT43uXhorN5SVT2KO9UGpLULHNG+Lp9
   kJUwKnWQBnUhvMCRL7QELNHTtHsewh1pBPraaMK7rk1cA/bmwiZ2PUZmy
   0ZTywUvKy7/4PvibKkbEIpDnnWSwQdlC71Yu/Q318KgnXM3EeTAlVeuZG
   PMWHZy5Sg/cCzPC5va8PAT45gXTNKhKdihfGOToIpYZAeVw1tkyJRtFGB
   PytIHfYkbBrKIp9+487A2hOfmbwQeSxLFPhHaEHGVgOO0iBTr8yt2oOTq
   Wx3dI3+nkSpcpJbz0IbYUH5B+ke3GVO6IONeOrbI+ginGGRfSRaR4qyy9
   Q==;
X-CSE-ConnectionGUID: CMrm34nTSBq9+CpZ5PyUEg==
X-CSE-MsgGUID: ktHYlBMMQRq6U8eCZAFQXg==
X-IronPort-AV: E=McAfee;i="6600,9927,11061"; a="14130135"
X-IronPort-AV: E=Sophos;i="6.07,246,1708416000"; 
   d="scan'208";a="14130135"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 May 2024 14:46:31 -0700
X-CSE-ConnectionGUID: OSxaXT7pSuqsbWgzOTMAhQ==
X-CSE-MsgGUID: sZ1yQv1gTr+bEFQ0mcTVDQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,246,1708416000"; 
   d="scan'208";a="31726356"
Received: from jf5300-b11a264t.jf.intel.com ([10.242.51.89])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 May 2024 14:46:30 -0700
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
Subject: [RFC PATCH 0/3] by_n compression and decompression with Intel IAA 
Date: Wed,  1 May 2024 14:46:26 -0700
Message-Id: <cover.1714581792.git.andre.glover@linux.intel.com>
X-Mailer: git-send-email 2.27.0
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit


With the introduction of the 'canned' compression algorithm [1], we
see better latencies than the 'dynamic' Deflate, and a better compression
ratio than 'fixed' Deflate.

When using IAA hardware accelerated 'canned' compression, we are able to
take advantage of the IAA architecture and initiate independent
parallel operations for both compress and decompress. In support of mTHP
and large folio swap in/out, we have developed an algorithm based on
'canned' compression, called 'canned-by_n' that takes advantage of the IAA
hardware that has multiple compression and decompression engines which
creates parallelism for each single compress and/or decompress operation
thus greatly reducing latency.

When using the 'canned-by_n' algorithm, the user provides an input buffer,
an output buffer, and a parameter N. The 'canned-by_n' crypto algorithm
compresses (or decompresses) a single input buffer into a single output
buffer. This is done in such a way that the compress and decompress
operations can be parallelized into up to N parallel operations from a
single input buffer into a single output buffer.

Usage
=====

With the introduction of the 'canned-by_n' algorithm, the user would
simply do the following to initiate an operation:

struct crypto_acomp *tfm;
struct acomp_req *req;
tfm = crypto_alloc_acomp("deflate-iaa-canned-by_n", 0, 0);

....

// Ignored by non 'by_n' algorithms

req->by_n = N;

err = crypto_wait_req(crypto_acomp_compress(req), &wait);

In the above example, the only new initialization for an acomp_req would be
to specify the by_n number N, where N is a power of 2 and 1 <= N <= 64 (64
is the current limit but this can be changed to a greater value based on
the hardware capability).

Performance
===========

'Canned-by_n' compression shows promising performance improvements when
applied to recent patches pertaining to multi-sized THPs in mm-unstable
(7cca940d) -- swapping out the large folios and storing them in zram as
outlined in [2] and swapping them back in as large folios [3]. Our results
with a simple madvise-based benchmark swapping out/in folios comprised of
data folios collected from SPEC benchmarks shows an over 16x improvement in
compression latency and close to 10x in decompression latency over lzo-rle
on 64KB mTHPs. This translates to a greater than 10x improvement in zram
write latency and 7x improvement in zram read latency. The achieved
compression ratio, at 2.8 is better than that of lzo-rle. These are
achieved with 'canned-by_n' compression by_n setting of 8. See table below
for additional data.

With larger values of N, the latency of compression and decompression
drops, due to more parallelism. Concurrently, the overheads also increase
with larger N values, and start to dominate the cost after a point.
Compression ratio also drops with the increased splitting with larger
values of N.

Performance comparison for each 64KB folio with zram on Sapphire Rapids,
whose core frequency is fixed at 2500MHz, is shown below:

+------------+-------------+---------+-------------+----------+----------+
|            | Compression | Decomp  | Compression | zram     | zram     |
| Algorithm  | latency     | latency | ratio       | write    | read     |
+------------+-------------+---------+-------------+----------+----------+
|            |       Median (ns)     |             |      Median (ns)    |
+------------+-------------+---------+-------------+----------+----------+
|            |             |         |             |          |          |
| IAA by_1   | 34,493      | 20,038  | 2.93        | 40,130   | 24,478   |
| IAA by_2   | 18,830      | 11,888  | 2.93        | 24,149   | 15,536   |
| IAA by_4   | 11,364      |  8,146  | 2.90        | 16,735   | 11,469   |
| IAA by_8   |  8,344      |  6,342  | 2.77        | 13,527   |  9,177   |
| IAA by_16  |  8,837      |  6,549  | 2.33        | 15,309   |  9,547   |
| IAA by_32  | 11,153      |  9,641  | 2.19        | 16,457   | 14,086   |
| IAA by_64  | 18,272      | 16,696  | 1.96        | 24,294   | 20,048   |
|            |             |         |             |          |          |
| lz4        | 139,190     | 33,687  | 2.40        | 144,940  | 37,312   |
|            |             |         |             |          |          |
| lzo-rle    | 138,235     | 61,055  | 2.52        | 143,666  | 64,321   |
|            |             |         |             |          |          |
| zstd       | 251,820     | 90,878  | 3.40        | 256,384  | 94,328   |
+------------+-------------+---------+-------------+----------+----------+

[1] https://lore.kernel.org/all/cover.1710969449.git.andre.glover@linux.intel.com/
[2] https://lore.kernel.org/linux-mm/20240327214816.31191-1-21cnbao@gmail.com/
[3] https://lore.kernel.org/linux-mm/20240304081348.197341-1-21cnbao@gmail.com/

Andre Glover (3):
  crypto: Add pre_alloc and post_free callbacks for acomp algorithms
  crypto: add by_n attribute to acomp_req
  crypto: Add deflate-canned-byN algorithm to IAA

 crypto/acompress.c                         |  13 +
 drivers/crypto/intel/iaa/iaa_crypto.h      |   9 +
 drivers/crypto/intel/iaa/iaa_crypto_main.c | 402 ++++++++++++++++++++-
 include/crypto/acompress.h                 |   4 +
 include/crypto/internal/acompress.h        |   6 +
 5 files changed, 421 insertions(+), 13 deletions(-)

-- 
2.27.0


