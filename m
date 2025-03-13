Return-Path: <dmaengine+bounces-4742-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 18DF9A5FBE6
	for <lists+dmaengine@lfdr.de>; Thu, 13 Mar 2025 17:36:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 04ED518878FC
	for <lists+dmaengine@lfdr.de>; Thu, 13 Mar 2025 16:36:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2ADD126C03;
	Thu, 13 Mar 2025 16:36:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="k7ftf8Tr"
X-Original-To: dmaengine@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2ED714901B;
	Thu, 13 Mar 2025 16:36:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741883785; cv=none; b=VEXVCKI64acVy6a8wvZrmzOBCqKYzFFMCY1+akY79o3yVNA9dHzT8yvuTBya3vExlhZmcXgraROwJ8DWJN1txgmiK1C90vl9u0qG+4QYfL490iEwLAP8Qe5i6ZUveCRbVzN1xTX/ggLuyUOyTQpIDql34/0Msg2Zop7oxmDM+0g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741883785; c=relaxed/simple;
	bh=ZIbywE+IGj8IDtGcnASQ0vVf6RTPSe9bJdsvE2E7ZKI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=onVfd99y46eiVU5NU1RwriKiv6+P5QHKSs16h1nih9uLbEY1Yidti0OzddBHqaxfjMs8Zv7Fj689uMJIBLtI2XWMw1hzW0T/L96qm6wKNv8lYmtPJP8+IZgGd9ok9iRR6cvXSHaSWnD8Tf6brikACN8eBgMJ36TiARpJGguo+Fk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=k7ftf8Tr; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741883784; x=1773419784;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=ZIbywE+IGj8IDtGcnASQ0vVf6RTPSe9bJdsvE2E7ZKI=;
  b=k7ftf8TrZSEVdiSkXEb1ToCgOxrBjrvDRcHzlz9otyr0iz6qIpI95gcd
   0MVEeBg7lBYBfL4GLutWFc7iz05RwbB8887WuGlOGJlrzclLyuFlxPBNS
   wPN5luym7IB2M+ScH04nrxVszXNvjV7TTLw8jikBu4vlwwLfrex1Fu81s
   st9suCkEXu5cHhKU1F7lwr38ndlUefhGHfjaCRQCvXbz1lN6k9HrfbDgO
   QHZOFf22LDiXYEd4yYiay6z2w7/TBWtdMriRdneCUjy0bnbGbYmW+ymE8
   oUcVG/5hUetbHH53rKY4KgCUuy3KzuXs4cmdWOQGvtYLXdGIx49LwCP/C
   g==;
X-CSE-ConnectionGUID: qMW4c9lwTamM86aazYxSPw==
X-CSE-MsgGUID: 6HHwK5LOQq+bxrtDw1sDDQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11372"; a="43191973"
X-IronPort-AV: E=Sophos;i="6.14,245,1736841600"; 
   d="scan'208";a="43191973"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Mar 2025 09:36:13 -0700
X-CSE-ConnectionGUID: okWXdc77TmG7CCS+c6Yj0w==
X-CSE-MsgGUID: BeuGdPdHSDmwG7tBfuxglA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,245,1736841600"; 
   d="scan'208";a="121511647"
Received: from philliph-desk.amr.corp.intel.com (HELO vcostago-mobl3) ([10.124.222.83])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Mar 2025 09:36:12 -0700
From: Vinicius Costa Gomes <vinicius.gomes@intel.com>
To: Nathan Lynch <nathan.lynch@amd.com>, Vinod Koul <vkoul@kernel.org>,
 dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: dave.jiang@intel.com, kristen.c.accardi@intel.com, kernel test robot
 <oliver.sang@intel.com>
Subject: Re: [PATCH v1] dmaengine: dmatest: Fix dmatest waiting less when
 interrupted
In-Reply-To: <874izx10nx.fsf@AUSNATLYNCH.amd.com>
References: <20250305230007.590178-1-vinicius.gomes@intel.com>
 <878qpa13fe.fsf@AUSNATLYNCH.amd.com> <87senhoq1k.fsf@intel.com>
 <874izx10nx.fsf@AUSNATLYNCH.amd.com>
Date: Thu, 13 Mar 2025 09:36:11 -0700
Message-ID: <87wmcslwg4.fsf@intel.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Nathan Lynch <nathan.lynch@amd.com> writes:

> Hi Vinicius,
>
> Vinicius Costa Gomes <vinicius.gomes@intel.com> writes:
>> Nathan Lynch <nathan.lynch@amd.com> writes:
>>> Vinicius Costa Gomes <vinicius.gomes@intel.com> writes:
>>>> Change the "wait for operation finish" logic to take interrupts into
>>>> account.
>>>>
>>>> When using dmatest with idxd DMA engine, it's possible that during
>>>> longer tests, the interrupt notifying the finish of an operation
>>>> happens during wait_event_freezable_timeout(), which causes dmatest to
>>>> cleanup all the resources, some of which might still be in use.
>>>>
>>>> This fix ensures that the wait logic correctly handles interrupts,
>>>> preventing premature cleanup of resources.
>>>>
>>>> Reported-by: kernel test robot <oliver.sang@intel.com>
>>>> Closes: https://lore.kernel.org/oe-lkp/202502171134.8c403348-lkp@intel.com
>>>
>>> Given the report at the URL above I'm struggling to follow the rationale
>>> for this change. It looks like a use-after-free in idxd while
>>> resetting/unbinding the device, and I can't see how changing whether
>>> dmatest threads perform freezeable waits would change this.
>>>
>>
>> I think that the short version is that the reproducition script triggers
>> different problems on different platforms/configurations.
>>
>> The solution I proposed fixes a problem I was seeing on a SPR system, on
>> a GNR system (that I was only able to get later) I see something more similar
>> to this particular splat (currently working on the fix).
>>
>> Seeing this question, I realize that I should have added a note to the
>> commit detailing this.
>>
>> So I am planning on proposing two (this and another) fixes for the same
>> report, hoping that it's not that confusing/unusual.
>
> I'm still confused... why is wait_event_freezable_timeout() the wrong
> API for dmatest to use, and how could changing it to
> wait_event_timeout() cause it to "take interrupts into account" that it
> didn't before?
>

My understanding (and testing) is that wait_event_timeout() will block
for the duration even in the face of interrupts, 'freezable' will not.

> AFAIK the only change made here is that dmatest threads effectively
> become unfreezeable, which is contrary to prior authors' intentions:
>
> commit 981ed70d8e4f ("dmatest: make dmatest threads freezable")
> commit adfa543e7314 ("dmatest: don't use set_freezable_with_signal()")
>

Cheers,
-- 
Vinicius

