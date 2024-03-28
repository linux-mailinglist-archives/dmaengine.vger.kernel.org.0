Return-Path: <dmaengine+bounces-1626-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 98ED589075D
	for <lists+dmaengine@lfdr.de>; Thu, 28 Mar 2024 18:45:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4D0FA295187
	for <lists+dmaengine@lfdr.de>; Thu, 28 Mar 2024 17:45:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9DB08172D;
	Thu, 28 Mar 2024 17:45:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TjEzPczO"
X-Original-To: dmaengine@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF32426AF6;
	Thu, 28 Mar 2024 17:45:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711647907; cv=none; b=UhJ+Df7Ry/7U+fDp77tWqRgLp2/6RsJJkTnCtVxPKrlDMXyRQwer6bDmU9/pUUrVHAeAw8JSsh9TwMF5GJ2AaSsImQYRAldLXZ/MAm7VZmiENd0qil+BwMcnT+iR8UFNQ+1M7BPrDmgptoTeCB3qg906iboTtfJaJu1xjVcYpBU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711647907; c=relaxed/simple;
	bh=njo01UyIuCS4hJErYPZdC79rPyF1110IDRpOnxYG0K0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=H07QDQvVyZaLN+9KIH9o+qCh2BxR/VoTGlwBrrjY3pk6X99Zm4DaCvPdVzyi9Ua6LH2O8XPVNgKqTnUYbzgpSHA6ubW7QGcCqDDPpK/JGzl9eboUvHuEjbn9nc0KVuFvO6ntH5uY9iNqq5x+MVeXGznePcvNcjOKaJO+H9H769Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TjEzPczO; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1711647906; x=1743183906;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=njo01UyIuCS4hJErYPZdC79rPyF1110IDRpOnxYG0K0=;
  b=TjEzPczOrfyLnTJ+rAOcj4pIP8/N+ybP8xNfr/tOdIvHVdk0AbQivpYo
   R34uyu7dKHEoNf3ymc1ZzRSZv8QxxlhAcMerwopNjDZrMMwRbycT+aznQ
   LJ073iwW4nHviTNq6stigd4ncVJyDHvwIKt0qIb3ouGNxk9GoShmVgezp
   VKLShyheirxO5/Tdy/i0JyFs7V8wonIH5fq9Geh63K1MKxOYH/x2Z6N/A
   JgL3IfOv1BaNW/rAzCBsSxpPM/o9bX5L3iTpzUV546009si4Qlvmh6GVv
   X+DcQkRJPAZ3u8ejNI7u+HQ4on3aSwgZgUb5Op6gsCaxRgt+GYdV4oz1I
   A==;
X-CSE-ConnectionGUID: mozWwTXBRlSf8jc3KwBplg==
X-CSE-MsgGUID: Hf1mjSBnSVub/4wzwOBAJA==
X-IronPort-AV: E=McAfee;i="6600,9927,11027"; a="10631342"
X-IronPort-AV: E=Sophos;i="6.07,162,1708416000"; 
   d="scan'208";a="10631342"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Mar 2024 10:44:57 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,162,1708416000"; 
   d="scan'208";a="16675562"
Received: from jf5300-b11a264t.jf.intel.com ([10.242.51.89])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Mar 2024 10:44:57 -0700
From: Andre Glover <andre.glover@linux.intel.com>
To: tom.zanussi@linux.intel.com,
	herbert@gondor.apana.org.au,
	davem@davemloft.net
Cc: dave.jiang@intel.com,
	fenghua.yu@intel.com,
	wajdi.k.feghali@intel.com,
	james.guilford@intel.com,
	vinodh.gopal@intel.com,
	tony.luck@intel.com,
	linux-crypto@vger.kernel.org,
	dmaengine@vger.kernel.org,
	andre.glover@linux.intel.com
Subject: [PATCH 0/4] crypto: Add new compression modes for zlib and IAA 
Date: Thu, 28 Mar 2024 10:44:41 -0700
Message-Id: <cover.1710969449.git.andre.glover@linux.intel.com>
X-Mailer: git-send-email 2.27.0
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

This patch series adds 'canned' compression for Intel IAA and zlib. It
also adds 'dynamic' compression for Intel IAA which is compatible with zlib
deflate algorithms. 

The original IAA crypto submissions [1] included a 'canned' compression
mode, but support for 'canned' compression was removed during the review
because it didn't have an equivalent software implementation available [2].

Deflate compression can be done in a variety of modes. The dynamic mode
uses Huffman tables that are generated/optimized for that particular
input. This gives the best compression ratio but has the longest latency.
The fixed mode uses Huffman tables that are defined by the Deflate
standard. It generally gives the best latency but with a lower compression
ratio. The 'canned' compression mode implements a compression scheme that
uses a statically defined set of Huffman tables, but where the Deflate
Block Header is implied rather than stored with the compressed data. 

The 'canned' mode results in lower compression/decompression latencies
compared to using the dynamic mode, but it results in a better compression
ratio than using the fixed mode.

Below is a table showing the latency improvements with zlib, between
zlib dynamic and zlib canned modes, and the compression ratio for 
each mode while using a set of 4300 4KB pages sampled from SPEC 
CPU17 workloads:
_________________________________________________________
| Zlib Level |  Canned Latency Gain  |    Comp Ratio    |
|------------|-----------------------|------------------|
|            | compress | decompress | dynamic | canned |
|____________|__________|____________|_________|________|
|     1      |    49%   |    29%     |  3.16   |  2.92  |
|------------|----------|------------|---------|--------|
|     6	     |    27%   |    28%     |  3.35   |  3.09  |
|------------|----------|------------|---------|--------|
|     9      |    12%   |    29%     |  3.36   |  3.11  |
|____________|__________|____________|_________|________|

Using the same data set as for the above table, IAA fixed-mode compression
results in a compression ratio of 2.69. Using IAA canned-mode compression
results in a ratio of 2.88, which is a 7% improvement. This data shows that
the canned mode results in better latencies than the dynamic mode, but a
better ratio than the fixed mode. Thus, the canned mode would be preferred
when compression and decompression latencies are valued more than the
compression ratio.

'Dynamic' mode IAA compression is a HW accelerated dynamic Deflate that is
fully compatible with software decompress implementations, including zlib.
'Dynamic' IAA compression allows users to perform hardware-accelerated
compression that achieves a higher compression ratio than both 'canned'
and 'fixed' compression modes. Thus, Dynamic IAA compression should be
used when the goal is to produce the best compression ratio while
minimizing latencies by using IAA hardware acceleration.  IAA
decompression is fully compatible with software compress implementations,
when the uncompressed size is no more than 4KB.

Below is a table showing the compression ratio seen when compressing a
data set of 4300 4KB pages sampled from SPEC CPU17 workloads via various
IAA compression modes:

|---------------------------------------|
|		 Intel IAA              |
|---------------------------------------|
| compression mode | compression ratio  |
|---------------------------------------|
| fixed	           |	2.69            |
|---------------------------------------|
| canned           |	2.88		|
|---------------------------------------|
| dynamic          |	3.14		|
|---------------------------------------|

Patch 1/4 adds a software implementation of “canned’ mode to the
existing zlib software library and exposes it as “deflate-canned”.
This was done instead of creating a new canned-mode library to avoid a lot
of code duplication. Testing shows that this change has no performance
impact to the existing zlib algorithms.

Patch 2/4 adds IAA 'canned' support which is based on the original
implementation [1] and will be exposed as 'deflate-iaa-canned'

Patch 3/4 adds 'dynamic' mode IAA compression support and will be exposed
as 'deflate-iaa-dynamic'.

Patch 4/4 adds software compression stats to the optional debugfs
statistics support for IAA.

[1] https://lore.kernel.org/lkml/20230605201536.738396-1-tom.zanussi@linux.intel.com/
[2] https://lore.kernel.org/lkml/ZIw%2Fjtxdg6O1O0j3@gondor.apana.org.au/

Andre Glover (4):
  crypto: Add 'canned' compression mode for zlib
  crypto: iaa - Add deflate-canned compression algorithm
  crypto: iaa - Add deflate-iaa-dynamic compression algorithm
  crypto: iaa - Add Software Compression stats to IAA Compression
    Accelerator stats

 .../driver-api/crypto/iaa/iaa-crypto.rst      |  36 +-
 crypto/deflate.c                              |  72 +++-
 crypto/testmgr.c                              |  30 ++
 crypto/testmgr.h                              | 220 +++++++++++
 drivers/crypto/intel/iaa/Kconfig              |   1 +
 drivers/crypto/intel/iaa/Makefile             |   2 +-
 drivers/crypto/intel/iaa/iaa_crypto.h         |  44 ++-
 .../crypto/intel/iaa/iaa_crypto_comp_canned.c | 116 ++++++
 .../intel/iaa/iaa_crypto_comp_dynamic.c       |  22 ++
 .../crypto/intel/iaa/iaa_crypto_comp_fixed.c  |   1 +
 drivers/crypto/intel/iaa/iaa_crypto_main.c    | 361 ++++++++++++++++--
 drivers/crypto/intel/iaa/iaa_crypto_stats.c   |   8 +
 drivers/crypto/intel/iaa/iaa_crypto_stats.h   |   2 +
 include/linux/zlib.h                          |  10 +
 lib/Kconfig                                   |   9 +
 lib/zlib_deflate/defcanned.h                  | 118 ++++++
 lib/zlib_deflate/deflate.c                    |   8 +-
 lib/zlib_deflate/deftree.c                    |  15 +-
 lib/zlib_inflate/infcanned.h                  | 191 +++++++++
 lib/zlib_inflate/inflate.c                    |  15 +-
 lib/zlib_inflate/inflate.h                    |   5 +-
 lib/zlib_inflate/infutil.h                    |  16 +
 22 files changed, 1255 insertions(+), 47 deletions(-)
 create mode 100644 drivers/crypto/intel/iaa/iaa_crypto_comp_canned.c
 create mode 100644 drivers/crypto/intel/iaa/iaa_crypto_comp_dynamic.c
 create mode 100644 lib/zlib_deflate/defcanned.h
 create mode 100644 lib/zlib_inflate/infcanned.h

-- 
2.27.0


