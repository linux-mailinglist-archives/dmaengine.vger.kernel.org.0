Return-Path: <dmaengine+bounces-566-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 83FAF817C32
	for <lists+dmaengine@lfdr.de>; Mon, 18 Dec 2023 21:48:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 95E1B1C21D2C
	for <lists+dmaengine@lfdr.de>; Mon, 18 Dec 2023 20:48:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C6D7740A2;
	Mon, 18 Dec 2023 20:47:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FUR2z7/u"
X-Original-To: dmaengine@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C65A8740B4;
	Mon, 18 Dec 2023 20:47:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702932440; x=1734468440;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=xtwR1W3kmoc6IwExPrsk/qKdEPkgQCfat8S+OdCL8pE=;
  b=FUR2z7/uzvL7rWOilKervWEOtrFNju51SPF+UUet8pd1fcbtwPVHCeuT
   hpGQAd3kPg2hOlsBpZX2GdQ1WrJoifcKZSI5NR783DaTY+GwvWW79nuoX
   pRtz42yxeTGf2armkywwRPELgLH8NL+uHrqX9Ti3Xrw52QAYb/kbEvMRs
   wb0TJGmal0eEbe+AVxphY031Wxb1AU6Cjhsy5ltrpEV8vMyDjjQoaCmEf
   W5hSf0ZCYbpr/L9m1vUN2x9pUMVANuXy3wv2B7G0qVVku0RWQHdvxdAUm
   xWGRfctTA+m35UOd+nG7PZ2FcdgSGEQKL0Qj6rbUMQ1XLXfmbPtAMx8Xl
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10928"; a="462015868"
X-IronPort-AV: E=Sophos;i="6.04,286,1695711600"; 
   d="scan'208";a="462015868"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Dec 2023 12:47:20 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10928"; a="899101489"
X-IronPort-AV: E=Sophos;i="6.04,286,1695711600"; 
   d="scan'208";a="899101489"
Received: from ssomasun-mobl1.amr.corp.intel.com (HELO tzanussi-mobl1.hsd1.il.comcast.net) ([10.212.116.107])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Dec 2023 12:47:18 -0800
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
Subject: [PATCH 0/2] crypto: Intel Analytics Accelerator (IAA) updates
Date: Mon, 18 Dec 2023 14:47:13 -0600
Message-Id: <20231218204715.220299-1-tom.zanussi@linux.intel.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Herbert,

Here are a couple patches that didn't make it into the last version of
the IAA crypto driver.

Tested using both shared and dedicated workqueues, with no problems
seen.

Thanks,

Tom

Tom Zanussi (2):
  crypto: iaa - Change desc->priv to 0
  crypto: iaa - Remove unneeded newline in update_max_adecomp_delay_ns()

 drivers/crypto/intel/iaa/iaa_crypto_main.c  | 8 ++++----
 drivers/crypto/intel/iaa/iaa_crypto_stats.c | 1 -
 2 files changed, 4 insertions(+), 5 deletions(-)

-- 
2.34.1


