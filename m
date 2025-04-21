Return-Path: <dmaengine+bounces-4926-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 22948A953C8
	for <lists+dmaengine@lfdr.de>; Mon, 21 Apr 2025 17:58:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E9BE8188FE59
	for <lists+dmaengine@lfdr.de>; Mon, 21 Apr 2025 15:58:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E487885931;
	Mon, 21 Apr 2025 15:57:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TjYO10e4"
X-Original-To: dmaengine@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7D4B1A3177;
	Mon, 21 Apr 2025 15:57:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745251078; cv=none; b=fTw989YV9ZmrX5mm49/VOOsqowtqFIN2gaXZWhw9ZWYJr9dlzEFg/Q0HyupA5ipWTiGEZiUHyoW75h5HjQwbl/OyJRzFY2s+RPzn4KlpdU/LeoN6Aaikvdolc9VoxTBlBw15O9M4hmOvlSW1NsQ52hWTloGc1ueodU4wgDwkc9g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745251078; c=relaxed/simple;
	bh=KrEUT7dHuff1u70nLEWlMRKQ2AKaoUJreC8uWwZYyxI=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=kWl82iCZFcjiosJaTa/O6RpJTxMXh3lKvR9nP+HM7M6P1+F9NbVdezeJaE6eKLZIRPH9vp6K+bXbuCXrQtdO/OfF/zmYwwdTbQixNyA1+ykVBgKpZeWkaNSfb8SFPNmOOeZ1fZ6nFdajRNnnrAztP6LG97GeHW030XFh3z4ih4Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TjYO10e4; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1745251077; x=1776787077;
  h=message-id:date:mime-version:subject:to:references:from:
   in-reply-to:content-transfer-encoding;
  bh=KrEUT7dHuff1u70nLEWlMRKQ2AKaoUJreC8uWwZYyxI=;
  b=TjYO10e44b9HOoeEXfKGmgXTmvgRwRyFG/wbjJzIT7hQfVZHvfwzjNJl
   aZIdwTaWWQvc6DAxppXZfPmQZe5/NWLxINbv5Wi+1ZLi6ZDAcHcel6mVc
   H8VGZi9JcsO9EAO7n/lo4/tQZl3Phu69cFKpkqzh9WXNjWu7px2WzlnHH
   Sdbbc5i4iIfsZysNuMmlqR8kscbW0ODq0iradi5FZcC64TW9K1Ovlw3os
   Yvp1wtQMrV6NL/C0XM55nbHy+GQAn8OBUNN216eK2nZ+I1WWrYpEil3GX
   5DI6sw5K1LPJna3nr+l9rokiI4DpWN6qA973Oy+CHWHrlaXogWGEaRtFB
   w==;
X-CSE-ConnectionGUID: lL1HEYZSS8WxNx4fKUK1xA==
X-CSE-MsgGUID: eqYCv522Qtu9Av0Zbhtxag==
X-IronPort-AV: E=McAfee;i="6700,10204,11410"; a="58162284"
X-IronPort-AV: E=Sophos;i="6.15,228,1739865600"; 
   d="scan'208";a="58162284"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Apr 2025 08:57:56 -0700
X-CSE-ConnectionGUID: 0+opOQkoTKWfr+nEWigltw==
X-CSE-MsgGUID: yv0Qs9/4TQKnS8o3CDCCJw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,228,1739865600"; 
   d="scan'208";a="136616657"
Received: from dnelso2-mobl.amr.corp.intel.com (HELO [10.125.111.68]) ([10.125.111.68])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Apr 2025 08:57:56 -0700
Message-ID: <90296464-fec1-4885-a8bb-0f1fd21b6dab@intel.com>
Date: Mon, 21 Apr 2025 08:57:54 -0700
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] dmaengine: idxd: Fix allowing write() from different
 address spaces
To: Nathan Lynch <nathan.lynch@amd.com>,
 Vinicius Costa Gomes <vinicius.gomes@intel.com>,
 Vinod Koul <vkoul@kernel.org>, Arjan van de Ven <arjan@linux.intel.com>,
 Nikhil Rao <nikhil.rao@intel.com>, dmaengine@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20250416025201.15753-1-vinicius.gomes@intel.com>
 <87mscgkuqf.fsf@AUSNATLYNCH.amd.com>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <87mscgkuqf.fsf@AUSNATLYNCH.amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 4/16/25 8:10 AM, Nathan Lynch wrote:
> Vinicius Costa Gomes <vinicius.gomes@intel.com> writes:
>> Check if the process submitting the descriptor belongs to the same
>> address space as the one that opened the file, reject otherwise.
> 
> I assume this can happen after a fork.
> 
> Do idxd_cdev_mmap() and idxd_cdev_poll() need similar protection?

Seems reasonable. Vinicius is on sabbatical. I'll respin his code and add the suggested checks. Thanks Nathan.

DJ

> 
>>
>> Fixes: 6827738dc684 ("dmaengine: idxd: add a write() method for applications to submit work")
>> Signed-off-by: Vinicius Costa Gomes <vinicius.gomes@intel.com>
>> ---
>>  drivers/dma/idxd/cdev.c | 3 +++
>>  1 file changed, 3 insertions(+)
>>
>> diff --git a/drivers/dma/idxd/cdev.c b/drivers/dma/idxd/cdev.c
>> index ff94ee892339..373c622fcddc 100644
>> --- a/drivers/dma/idxd/cdev.c
>> +++ b/drivers/dma/idxd/cdev.c
>> @@ -473,6 +473,9 @@ static ssize_t idxd_cdev_write(struct file *filp, const char __user *buf, size_t
>>  	ssize_t written = 0;
>>  	int i;
>>  
>> +	if (current->mm != ctx->mm)
>> +		return -EPERM;
>> +
>>  	for (i = 0; i < len/sizeof(struct dsa_hw_desc); i++) {
>>  		int rc = idxd_submit_user_descriptor(ctx, udesc + i);
>>  
>> -- 
>> 2.49.0


