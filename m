Return-Path: <dmaengine+bounces-8191-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id E1E02D0C41A
	for <lists+dmaengine@lfdr.de>; Fri, 09 Jan 2026 22:08:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 182813019690
	for <lists+dmaengine@lfdr.de>; Fri,  9 Jan 2026 21:07:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E927D31A813;
	Fri,  9 Jan 2026 21:07:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FsUBpakJ"
X-Original-To: dmaengine@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFBA531984E;
	Fri,  9 Jan 2026 21:07:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767992863; cv=none; b=QVHjvVw8JO6KnhtEIeWHxOoPZKk0r04YWNmZIV70RmheLoLtPh6ctFZAlVFpdb3XNUjqPKk8rQALSdGjsnSb07hZ1tyswAcVxDjZQ34UKrE5enJOuS2VlBO7QQfM2HNUxQBIDi2oRz0A9HC45NQssF0+cXSRFF1bci6H4NjRF10=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767992863; c=relaxed/simple;
	bh=9ktMGKzUhCgLRekaGYgNJAEAgssAt/9xoX4g2yhrA14=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cllfelPbwS3L1yUyefZBpIK7hebaaYkibMxUrq5szHvwZ2CnGiydLAIldBdL6IBJcpeoL07IBwpUmVpuboyOXM7Fwx1+SfogQxnXHgaRSpzvtqcXjHHlyOkJCpvmzwnVyW+gK8PVpYA3UWPFuPaoxm6AByoMObnYTayTVPNkAio=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FsUBpakJ; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1767992863; x=1799528863;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=9ktMGKzUhCgLRekaGYgNJAEAgssAt/9xoX4g2yhrA14=;
  b=FsUBpakJCQxafZKNHJGgB2ABzWHaF9lWJfLRAHPxk6Cxiy51iTlVymsx
   1lI02UWAbu14DfAaYT5FyGlkfZRv0LK26HGWv4994oKDZARpoq2fBwIdR
   /v8KG3C03HUl8+8gQzCBrKnpft4fU3vs3iEII1Bjyk1rDSo8T15V0MPLi
   sW6jhP9OMngGJsGNOAQx11q/XIQ1+YbKuRnDYaYj4fIuhQMCFHR0QbVc1
   nXJqhK0oB94kcZ7uIiLGt26jINuw0Qkv6xN34HKM7lTsjkj2j3ATtUUph
   YuO4jt+NfYzCUg57u1s2myEaKAxXaVDy6fIO6rTo/T7NjTxf3DRl31F/9
   g==;
X-CSE-ConnectionGUID: qqv7r025STmmu+FPHL3Xuw==
X-CSE-MsgGUID: 8UGTFHUfRcecIt+OZaznxQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11666"; a="69113025"
X-IronPort-AV: E=Sophos;i="6.21,214,1763452800"; 
   d="scan'208";a="69113025"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jan 2026 13:07:43 -0800
X-CSE-ConnectionGUID: q0yQnKUaQv29TBh/fiiQeA==
X-CSE-MsgGUID: RZYGCafZTiWmqptBHwZRgg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,214,1763452800"; 
   d="scan'208";a="234257250"
Received: from agladkov-desk.ger.corp.intel.com (HELO [10.125.110.37]) ([10.125.110.37])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jan 2026 13:07:42 -0800
Message-ID: <2e143786-7a51-459f-8caf-5f3beefe0a18@intel.com>
Date: Fri, 9 Jan 2026 14:07:41 -0700
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/3] dmaengine: A little cleanup and refactoring
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Vinod Koul <vkoul@kernel.org>
References: <20260109173718.3605829-1-andriy.shevchenko@linux.intel.com>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20260109173718.3605829-1-andriy.shevchenko@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 1/9/26 10:35 AM, Andy Shevchenko wrote:
> This just a set of small almost ad-hoc cleanups and refactoring.
> Nothing special and nothing that changes behaviour.
> 
> Changelog v3:
> - fixed checkpatch warning (mixed tabs and spaces) (Vinod)
> 
> v2: 20251110085349.3414507-1-andriy.shevchenko@linux.intel.com
> 
> Changelog v2:
> - dropped not very good (and not compilable) change (LKP)
> 
> Andy Shevchenko (3):
>   dmaengine: Refactor devm_dma_request_chan() for readability
>   dmaengine: Use device_match_of_node() helper
>   dmaengine: Sort headers alphabetically
> 
>  drivers/dma/dmaengine.c | 50 +++++++++++++++++++++--------------------
>  1 file changed, 26 insertions(+), 24 deletions(-)
> 

for the series
Reviewed-by: Dave Jiang <dave.jiang@intel.com>


