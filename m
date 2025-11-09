Return-Path: <dmaengine+bounces-7098-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 93C0CC44915
	for <lists+dmaengine@lfdr.de>; Sun, 09 Nov 2025 23:29:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 59C344E3B94
	for <lists+dmaengine@lfdr.de>; Sun,  9 Nov 2025 22:29:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EDDF26C3A2;
	Sun,  9 Nov 2025 22:29:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SG68zfun"
X-Original-To: dmaengine@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B869C2594B9;
	Sun,  9 Nov 2025 22:29:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762727389; cv=none; b=kgrsauav6dcCao04jny5rTUgxavLJd6qfpjsn/jRB3sNqpZuShypjPRU/HMTwFJM4A4TGxj1BkKKceP9s+3rx4/ub2Dsvs5Shhf+EY8Grmiu95QesJtCJDqUOkxkNTM0VhuqgCea6447PsGkTT426bpoqyfuTbE4HWd/Edu9hOA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762727389; c=relaxed/simple;
	bh=S31vUDXbZGNJn21eptsG8d6SMTJbfXW6dEnraGq59nE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=eCnyndk5+6XEzsdbUWv1RUJzf4u/Ci6xMlES5Yce3180nwqiylwS42x3sAeGPKK8cuH17WnebDSqHSeda2ay6TY6sYgZqnGNF6EsaaemI/QuhP1QNB7jz/PaSPHyAX3aqCxj0q0njVsPIzWQ3WutHhPZpNM0+HqKAO91aXoV1GQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SG68zfun; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1762727388; x=1794263388;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=S31vUDXbZGNJn21eptsG8d6SMTJbfXW6dEnraGq59nE=;
  b=SG68zfunRNmuWPkYK7IRAKNcZZhCorXpR2fvRUv7cJ5t59WJNyH2Gfvx
   lBpIIxY2a48bGn3RO1yYy3awQP6lYJZTkiH6YcUaj3Gh9IuJZRPOwRgc9
   3mw+irap6S8uLC+ncJT6aUZSV1kFNBwG8aXXSXmWEx+cxfzbpq9AVG757
   brwFaCGHdS1aa3rgByjf2b5SU18yHILw+Uf4ODl0PFtE/ScZcl7n3LgTt
   nRqN5DDCSEKXv55FqtEfR4FTp9/ZFr9697GsMEIRvRhQ6kKCB2ZaApWSj
   jQoKqUEIBaTLr/aulOXT8/O/+CsdIlm9v7WPOJGfB8JJc8+GD1fBg3tpJ
   w==;
X-CSE-ConnectionGUID: YceoJxITTpartxcFqlzm9g==
X-CSE-MsgGUID: wyflor2+TR+3FxHZCVsuKQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11608"; a="76133417"
X-IronPort-AV: E=Sophos;i="6.19,292,1754982000"; 
   d="scan'208";a="76133417"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Nov 2025 14:29:47 -0800
X-CSE-ConnectionGUID: nKIj2mdcQl2Q58vYl7OHwA==
X-CSE-MsgGUID: l1TWzquqSMia8cNIKMS/jw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,292,1754982000"; 
   d="scan'208";a="192633502"
Received: from black.igk.intel.com ([10.91.253.5])
  by orviesa003.jf.intel.com with ESMTP; 09 Nov 2025 14:29:46 -0800
Received: by black.igk.intel.com (Postfix, from userid 1003)
	id 4047495; Sun, 09 Nov 2025 23:29:45 +0100 (CET)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	dmaengine@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Vinod Koul <vkoul@kernel.org>
Subject: [PATCH v1 0/4] dmaengine; A little cleanup and refactoring
Date: Sun,  9 Nov 2025 23:28:33 +0100
Message-ID: <20251109222944.3222436-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This just a set of small almost ad-hoc cleanups and refactoring.
Nothing special and nothing that changes behaviour.

Andy Shevchenko (4):
  dmaengine: Use dma_request_channel() instead of
    __dma_request_channel()
  dmaengine: Refactor devm_dma_request_chan() for readability
  dmaengine: Use device_match_of_node() helper
  dmaengine: Sort headers alphabetically

 drivers/dma/dmaengine.c | 52 +++++++++++++++++++++--------------------
 1 file changed, 27 insertions(+), 25 deletions(-)

-- 
2.50.1


