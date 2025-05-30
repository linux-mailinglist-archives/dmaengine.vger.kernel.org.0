Return-Path: <dmaengine+bounces-5280-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 572EEAC85DE
	for <lists+dmaengine@lfdr.de>; Fri, 30 May 2025 03:07:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8D5D93B4FCC
	for <lists+dmaengine@lfdr.de>; Fri, 30 May 2025 01:07:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A43441C69;
	Fri, 30 May 2025 01:07:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="G7yrO3+O"
X-Original-To: dmaengine@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F61310E4;
	Fri, 30 May 2025 01:07:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748567272; cv=none; b=ntM/Q7EV5ssdVz0zeSvGNiGyhEwH4gTAUmgXRHD9seNFDeYU1MbvE0qW45CrFCA5jgouad0+bf2wcL0Jag3c+Ryjj6L/x2cVyAFmfM42zsUchOR255A1TEjxmhI8M26IaeMqjWzaeMS9Bn1qSW4r0+mYM4ijrxv/VDA+soOAgDY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748567272; c=relaxed/simple;
	bh=ng1a30jRQCNsOPKFlWO0SNghGIXAmeoWP6kNMriyI5Q=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=bhH09JlVxkaSvv/AVNAbbvA1F8bnMQaF5Wiv/AzuXvpzIFKGWGZ7u52oHBDE6weRfDAmsNbyQhAwWUKqm54vQsRflCaqCA30XwK8sCNZaMHuiZvxPf30z3A+u00STEBYssYQfjxpZ0MXU7GXKZO8a7/0kXE/fIieN26drMTQ+S0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=G7yrO3+O; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1748567271; x=1780103271;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=ng1a30jRQCNsOPKFlWO0SNghGIXAmeoWP6kNMriyI5Q=;
  b=G7yrO3+OnlinziPUCYbvYGMEO1l1c9GVaTqeulZN0O9UI8zMJP8JfBa3
   NOPbY3zXRuxUeqhdOX2FmTfyVwq9iv7OW7+o0GUAKot/y/G8PZygk/haQ
   JMLe4U+Vfn9z3qBPgO0jK1H6L2FiU3RUP6k6ut1iKvDXSS7lJt2u/8LKI
   NDVqW63fAbJQroU7obz7/tRGcsam7synCtnA/Cj29I3Cg5puJf1W0sgny
   +Y9Xp+FDZK2vJdLofAkdq5xJGRYhYgNfS4GvW/StfRqqEeHewDmABapWj
   pgzw3SZTOLhmKAxKP/UqH90kfBHJM3bBFUUwz0vX1jO7KpzzXy4hUKWVm
   A==;
X-CSE-ConnectionGUID: 7oHnkRoDSiGLejWue6MbfQ==
X-CSE-MsgGUID: bQRH7E1XRq+Fqre8ijCtVQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11448"; a="53277262"
X-IronPort-AV: E=Sophos;i="6.16,194,1744095600"; 
   d="scan'208";a="53277262"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 May 2025 18:07:44 -0700
X-CSE-ConnectionGUID: WDusKGTPRqqx5d/ZD4e6Xw==
X-CSE-MsgGUID: uoCOzQ48QMus8v33s4SR3g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,194,1744095600"; 
   d="scan'208";a="144206033"
Received: from unknown (HELO vcostago-mobl3) ([10.241.225.241])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 May 2025 18:07:35 -0700
From: Vinicius Costa Gomes <vinicius.gomes@intel.com>
To: Yi Sun <yi.sun@intel.com>
Cc: dave.jiang@intel.com, dmaengine@vger.kernel.org,
 linux-kernel@vger.kernel.org, xueshuai@linux.alibaba.com,
 gordon.jin@intel.com
Subject: Re: [PATCH 1/2] dmaengine: idxd: Remove improper idxd_free
In-Reply-To: <aDj60tJeJ-bYPFEX@ysun46-mobl.ccr.corp.intel.com>
References: <20250529153431.1160067-1-yi.sun@intel.com>
 <87r0079wyy.fsf@intel.com>
 <aDj60tJeJ-bYPFEX@ysun46-mobl.ccr.corp.intel.com>
Date: Thu, 29 May 2025 18:07:33 -0700
Message-ID: <87frgmaotm.fsf@intel.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Yi Sun <yi.sun@intel.com> writes:

> On 29.05.2025 09:56, Vinicius Costa Gomes wrote:
>>Hi,
>>
>>Yi Sun <yi.sun@intel.com> writes:
>>
>>> The put_device() call can be asynchronous cleanup via schedule_delayed_work
>>> when CONFIG_DEBUG_KOBJECT_RELEASE is set. This results in a use-after-free
>>> failure during module unloading if invoking idxd_free() immediately
>>> afterward.
>>>
>>
>>I think that adding the relevant part of the log would be helpful. (I am
>>looking at either a similar, or this exact problem, so at least to me it
>>would be helpful)
>>
> The issue is easily reproducible: unloading the module with 'modprobe -r idxd'
> can trigger the call trace so long as a idxd_free() is called immediately
> after the put_device().
>

Most probably the same issue I am looking at then. 

> I can include the call trace in the next version commit log if it's helpful.
>

Yes, that's helpful. Usually it's better to include more information in
the commit message.

> [ 1957.463315] refcount_t: underflow; use-after-free.
> [ 1957.463337] WARNING: CPU: 15 PID: 4428 at lib/refcount.c:28 refcount_warn_saturate+0xbe/0x110
> ... ...
> [ 1957.463424] RIP: 0010:refcount_warn_saturate+0xbe/0x110
> ... ...
> [ 1957.463445] Call Trace:
> [ 1957.463450]  <TASK>
> [ 1957.463458]  idxd_remove+0xe4/0x120 [idxd]
> [ 1957.463497]  pci_device_remove+0x3f/0xb0
> [ 1957.463505]  device_release_driver_internal+0x197/0x200
> [ 1957.463513]  driver_detach+0x48/0x90
> [ 1957.463515]  bus_remove_driver+0x74/0xf0
> [ 1957.463521]  pci_unregister_driver+0x2e/0xb0
> [ 1957.463524]  idxd_exit_module+0x34/0x7a0 [idxd]
> [ 1957.463529]  __do_sys_delete_module.constprop.0+0x183/0x280
> [ 1957.463536]  ? syscall_trace_enter+0x163/0x1c0
> [ 1957.463540]  do_syscall_64+0x54/0xd70
> [ 1957.463549]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
> [ 1957.463555] RIP: 0033:0x7fb52b10ee2b
>
>>> Removes the improper call idxd_free() to prevent potential memory
>>> corruption.
>>
>>Thinking if it would be worth a Fixes: tag.
>>
> Yes, sure. Will add Fixes: tag next version.
>
> Thanks
>     --Sun, Yi


Thank you,
-- 
Vinicius

