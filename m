Return-Path: <dmaengine+bounces-1252-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2AB4F870C49
	for <lists+dmaengine@lfdr.de>; Mon,  4 Mar 2024 22:20:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5D2771C2135E
	for <lists+dmaengine@lfdr.de>; Mon,  4 Mar 2024 21:20:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 794261E4AA;
	Mon,  4 Mar 2024 21:20:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mz0KGFUy"
X-Original-To: dmaengine@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B0F27B3F4;
	Mon,  4 Mar 2024 21:20:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709587217; cv=none; b=RUeK/41v3WRtvsC++MW0qfrspYdrV2GxFC7WNcqsiHRxpCvqyv+Ah+K6eZwO3WdvucYuu+UTexlM+1T9DJZJoMUXEDYu7hV9zjQnjcynha+eny8zfU3Co+O86Gu6legfdssxjRQ6K5oXeMfx+cwvNJefEnukS/wD8a/F/J0vHpY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709587217; c=relaxed/simple;
	bh=CjRP8c1rJZOPP0w5hkNyy0g9w8I51C+7vfHV17b8QeM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=qA1dv+RvNw0TuYOm0mneZOfgFbK3D8et2p8dKFZ+0AMgrNqBjVfEOkGq/KoKeQC8sw+zemTgTSQY/LIH4azuCBoUNjhjIJeh5Nt5/6lLEFIO9kv+qWf2Ztv4RazZe2osG0u2YporYCIMqWEv3XZq4w0Iv8Hdumqt+wr0uOH2aLU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mz0KGFUy; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709587216; x=1741123216;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=CjRP8c1rJZOPP0w5hkNyy0g9w8I51C+7vfHV17b8QeM=;
  b=mz0KGFUyTZY7litY+UM7HyiTgp7BJmBpaUNRiK0urFAB9ZXE09axi2Fb
   fi+V+B6+7yauJXNiJemSGUE8R91kE6cBz+NrO1Mdjz9ROs9jWSkKT4tKI
   DyIztvhbIgmugiiaWpFQIRWb7YKE7YxKAZTVmwK/JIuxTIhYs8v92dMY3
   LDR02s2+kVpYmjTHlMP8bVr8wcn0SA48x2aYQ8m9GAveEWKhpigHdPAqo
   tNbbP4l+aQOkgujAMBNUKWxG605bPtwXNRIuxu5q2z/WYrTILaYZoJRoV
   LtXe9uvS0zeXMok7LfrmyBhmJQMFs/1cZNaT+X9QDPbMbuIa1MUWveWwU
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,11003"; a="4271336"
X-IronPort-AV: E=Sophos;i="6.06,204,1705392000"; 
   d="scan'208";a="4271336"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Mar 2024 13:20:15 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,204,1705392000"; 
   d="scan'208";a="9040227"
Received: from skedaras-mobl1.amr.corp.intel.com (HELO tzanussi-mobl1.amr.corp.intel.com) ([10.212.77.241])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Mar 2024 13:20:14 -0800
From: Tom Zanussi <tom.zanussi@linux.intel.com>
To: herbert@gondor.apana.org.au,
	davem@davemloft.net
Cc: andre.glover@linux.intel.com,
	linux-kernel@vger.kernel.org,
	linux-crypto@vger.kernel.org,
	dmaengine@vger.kernel.org
Subject: [PATCH 0/4] crypto: IAA stats bugfixes and simplifications
Date: Mon,  4 Mar 2024 15:20:07 -0600
Message-Id: <20240304212011.1525003-1-tom.zanussi@linux.intel.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Herbert,

While doing some testing, I noticed a discrepancy in the
decomp_bytes_in stat, which the first patch in this series (crypto:
iaa - fix decomp_bytes_in stats) fixes.

I also realized that there were some other problems unrelated to that
but also that the stats code could be simplified in a number of ways
and that some of it wasn't really useful.  The stats code is debugging
code and has been helpful to quickly verify whether things are
basically working, but since it's there we should make it as accurate
and actually useful as possible.

I realize the second patch (crypto: iaa - Remove comp/decomp delay
statistics) removes the code I just fixed up in a patch you just
merged (crypto: iaa - Fix comp/decomp delay statistics) - let me know
if you want me to combine those if you want to remove the latter from
your branch...

Thanks,

Tom


*** BLURB HERE ***

Tom Zanussi (4):
  crypto: iaa - fix decomp_bytes_in stats
  crypto: iaa - Remove comp/decomp delay statistics
  crypto: iaa - Add global_stats file and remove individual stat files
  crypto: iaa - Change iaa statistics to atomic64_t

 .../driver-api/crypto/iaa/iaa-crypto.rst      |  76 +++++---
 drivers/crypto/intel/iaa/iaa_crypto.h         |  16 +-
 drivers/crypto/intel/iaa/iaa_crypto_main.c    |  13 +-
 drivers/crypto/intel/iaa/iaa_crypto_stats.c   | 183 ++++++++----------
 drivers/crypto/intel/iaa/iaa_crypto_stats.h   |   8 -
 5 files changed, 140 insertions(+), 156 deletions(-)

-- 
2.34.1


