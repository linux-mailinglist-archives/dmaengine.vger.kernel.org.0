Return-Path: <dmaengine+bounces-1001-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DA0668519C9
	for <lists+dmaengine@lfdr.de>; Mon, 12 Feb 2024 17:42:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 191D11C21FE5
	for <lists+dmaengine@lfdr.de>; Mon, 12 Feb 2024 16:42:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8648D3EA87;
	Mon, 12 Feb 2024 16:39:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZyxTWdzl"
X-Original-To: dmaengine@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B658B3E496;
	Mon, 12 Feb 2024 16:39:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707755968; cv=none; b=NIq+qwS14pBBysVjjGVVny+pcPP0tKWJzlKejHGDZiDMyxkR/EMsPyrkISPBHq/46YAAiQpO1UZK/jcTW/7tR8Sv3GpHDJN7XiM5ogNBqBfS6vy1Pzrr3ZXpcRF+yVM7on/zFGCNCl980KaJm8f6sOBbiZWW2vAfWQCUWfvrTks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707755968; c=relaxed/simple;
	bh=709knkAaP8MjULstfYL4E5uSLG2m2pepQhQRAsUmO4M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pg7u/kGfIHGXsJAA0V6f3M2hith2AKOZfRAK6Dk/F+zKgAMbNaRHb+FKww5d9U5HKJubywxZuhqwsv2KRuAqYB3hsk53Bgddp9Y074Ejwg45SUfeQmYozshrro3tt1bgcitQWOUO9Cpj86k3hNNevY9z3q/QhDZi0u3M2dbBMCA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZyxTWdzl; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707755967; x=1739291967;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=709knkAaP8MjULstfYL4E5uSLG2m2pepQhQRAsUmO4M=;
  b=ZyxTWdzlk5pTvAItvtZ2XpDq6TEjT1zP98Qtgc4Sftt752Z36TJYg1Jq
   mDLGz8PWkq96X1YViA9AHGeVAeVzJN8dysQSfsILTtGZ2zB8Lqm8veiId
   pCf0Vr6mU020YdFyuIUSMQMWrKV85d+oRWBBg0bp0jQkt1TtK+qGW09Rl
   qoF8V+TOHPtYBadAJysUJR6jTSA+/auYbXMb075ydHoT6s9EhASim67XZ
   XmP+cjzU4yTUsdCb2amNa2zMaLTMQic22xqkAwAHrfJNGolEqUn+T1MPb
   S8wTmq2zFb7z7jQSg93hDsnGaoJQ8nTa/Abz+baMHnjhjaRwh1lWzqMMW
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10982"; a="1646427"
X-IronPort-AV: E=Sophos;i="6.06,264,1705392000"; 
   d="scan'208";a="1646427"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Feb 2024 08:39:26 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,264,1705392000"; 
   d="scan'208";a="2815060"
Received: from djiang5-mobl3.amr.corp.intel.com (HELO [10.246.113.42]) ([10.246.113.42])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Feb 2024 08:39:25 -0800
Message-ID: <c643b6a3-0f41-416f-9268-3072f76939e3@intel.com>
Date: Mon, 12 Feb 2024 09:39:24 -0700
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] dmaengine: idxd: Clear Event Log head in idxd upon
 completion of the Enable Device command
To: Fenghua Yu <fenghua.yu@intel.com>, Vinod Koul <vkoul@kernel.org>
Cc: dmaengine@vger.kernel.org, linux-kernel <linux-kernel@vger.kernel.org>,
 Lingyan Guo <lingyan.guo@intel.com>
References: <20240209191851.1050501-1-fenghua.yu@intel.com>
 <36895817-8f71-461a-93e0-5db1a39cd3c4@intel.com>
 <18761e12-822a-16b4-fdc5-0ac889b1693c@intel.com>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <18761e12-822a-16b4-fdc5-0ac889b1693c@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 2/10/24 6:49 PM, Fenghua Yu wrote:
> Hi, Dave,
> 
> On 2/9/24 12:17, Dave Jiang wrote:
>>
>>
>> On 2/9/24 12:18 PM, Fenghua Yu wrote:
>>> If Event Log is supported, upon completion of the Enable Device command,
>>> the Event Log head in the variable idxd->evl->head should be cleared to
>>> match the state of the EVLSTATUS register. But the variable is not reset
>>> currently, leading mismatch of the variable and the register state.
>>> The mismatch causes incorrect processing of Event Log entries.
>>>
>>> Fix the issue by clearing the variable after completion of the command.
>>
>> Should this be done in idxd_device_clear_state() instead?
> 
> If clear evl->head in idxd_device_clear_state(), evl->head still mismatches head in EVLSTATUS in some cases.
> 
> For exmample, when a few event log entries are logged and then device is disabled, head in EVLSTATUS is still a valid non-zero value. Clearing evl->head in idxd_device_clear_state() when disabling device makes evl->head and head in EVLSTATUS mismatched.
> 
> I haven't thought a failure test case when they mismatch in these cases though.
> 
> But while thinking evl->head more, I wonder why is it even needed?
> 
> head of event log can always be read from EVLSTATUS instead of from its shadow evl->head. And reading head from EVLSTATUS won't degrade performance because tail is always read from EVLSTATUS whenever head is read (no matter from evl->head or from EVLSATUS).
> 
> To avoid any mismatch issue/trouble, I think the right fix is to remove head definition in struct idxd_evl and always read head from EVLSTATUS.
> 
> Do you think this is the right fix?

I was to avoid register reads during event processing. But if you think there's no performance impact then feel free to read directly from the register. 

> 
> Thanks.
> 
> -Fenghua

