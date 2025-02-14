Return-Path: <dmaengine+bounces-4468-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0148DA362D0
	for <lists+dmaengine@lfdr.de>; Fri, 14 Feb 2025 17:17:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B9A311635ED
	for <lists+dmaengine@lfdr.de>; Fri, 14 Feb 2025 16:17:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DED5B2753FD;
	Fri, 14 Feb 2025 16:17:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RXJJAEjK"
X-Original-To: dmaengine@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C2032222AC;
	Fri, 14 Feb 2025 16:17:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739549830; cv=none; b=WhqSTcGE7njVDJw/i1h1oSuywCGyZyLWJ+1vJOTPTUMXAz4TmV6FQMlO14bBQrOvzHxN1qZNsrArcm/cw6jkiwHzPsyawOIUWKjQotHEhF6NnV5pmoedFG6ONhE4BUqPR1hb2RzEyQrfr9VEI/7u+MtTXEGCawYm5NWBQgBMtmA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739549830; c=relaxed/simple;
	bh=narZhx3CH9twm8yj5J/9mu3Kl35wd7WluI5BKrpfhgA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GII7AIEDbDoblmrkZ8WmRp1l2T0s//c+2X2xu4FzpUh9lCKCmCzYu+/xKgU4c0p1206CFiBPzS8Xwegcd4DHHrfgGrPzbdEaYrmrYWT3Cpl+8Np8ivLFJk+VpoSDFO6UwJ6VUQhY3qFSruoI6ok7qMbSVXduWU0Wg5ABIDZFbvo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RXJJAEjK; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739549829; x=1771085829;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=narZhx3CH9twm8yj5J/9mu3Kl35wd7WluI5BKrpfhgA=;
  b=RXJJAEjKi+VmU+kRk1T/GBrZ0l6DS0Fup4GGSWLIHX+cKMUFAqXK7e9t
   1R1N9/4Ug28pyXH72tgOKsUkfXwVKYaPI3byAu3s7xKcE4p4Rvxo80sOo
   1b1PHdyQ/gYmsTLC2fJA6coQe/dC7u0TwfLYq/oMK8sJRQiRJUf2aQOW/
   CK5Z77gyv2HU4YzfLZlvdFOvSgkcPiUySlxiVyiZzyxK+L6UdZfudFI8N
   a8ESaa3t/rNmeKtb04CP7z4ZEMBodQojNOv0pgbnGkdiNx23Kw1brnVJE
   k4ZsexUfMPUpdQ12mU4izcfuywjBVQwDNBhy84yKLMnRvb3wd4C6lROi8
   w==;
X-CSE-ConnectionGUID: Jhjl/SnNQ7SvPRCc+35HHg==
X-CSE-MsgGUID: KGQOyrBeQxinokKZauIkyQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11345"; a="43142091"
X-IronPort-AV: E=Sophos;i="6.13,286,1732608000"; 
   d="scan'208";a="43142091"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Feb 2025 08:17:08 -0800
X-CSE-ConnectionGUID: 5WN6r0U+SCaMHM6XrzeoFQ==
X-CSE-MsgGUID: VbLv37+ITOujwuYlVvA3Nw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="150659269"
Received: from lstrano-mobl6.amr.corp.intel.com (HELO [10.125.109.34]) ([10.125.109.34])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Feb 2025 08:17:08 -0800
Message-ID: <65d1408e-816a-4fc0-8382-5314375920c9@intel.com>
Date: Fri, 14 Feb 2025 09:17:07 -0700
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 0/5] dmaengine: idxd: fix memory leak in error handling
 path
To: Shuai Xue <xueshuai@linux.alibaba.com>, vkoul@kernel.org
Cc: dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
 Vinicius Costa Gomes <vinicius.gomes@intel.com>
References: <20250110082237.21135-1-xueshuai@linux.alibaba.com>
 <5814fac9-4b11-4c18-8ab4-70f0f2536c61@linux.alibaba.com>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <5814fac9-4b11-4c18-8ab4-70f0f2536c61@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 2/13/25 11:43 PM, Shuai Xue wrote:
> 
> 
> 在 2025/1/10 16:22, Shuai Xue 写道:
>> Shuai Xue (5):
>>    dmaengine: idxd: fix memory leak in error handling path of
>>      idxd_setup_wqs
>>    dmaengine: idxd: fix memory leak in error handling path of
>>      idxd_setup_engines
>>    dmaengine: idxd: fix memory leak in error handling path of
>>      idxd_setup_groups
>>    dmaengine: idxd: fix memory leak in error handling path of idxd_alloc
>>    dmaengine: idxd: fix memory leak in error handling path of
>>      idxd_pci_probe
>>
>>   drivers/dma/idxd/init.c | 62 ++++++++++++++++++++++++++++++++---------
>>   1 file changed, 49 insertions(+), 13 deletions(-)
>>
> 
> Hi, all,
> 
> Gentle Ping.

- Fenghua, who has left Intel
+ Vinicius, who is the current maintainer


> 
> Thanks.
> Shuai


