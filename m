Return-Path: <dmaengine+bounces-4744-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B101BA6054B
	for <lists+dmaengine@lfdr.de>; Fri, 14 Mar 2025 00:29:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9C26E19C4BE0
	for <lists+dmaengine@lfdr.de>; Thu, 13 Mar 2025 23:29:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9B6D1F3FE3;
	Thu, 13 Mar 2025 23:29:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YfnOorzl"
X-Original-To: dmaengine@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A07D154C04;
	Thu, 13 Mar 2025 23:29:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741908553; cv=none; b=kQ+E60vfWFVz8EGf4vO1AVDu8v7fd+U8ratyZI79NVlyhiv7e4ZnttmOd70vgPcQuiac5htBKLATn/NwEpGMkuxAKMGWM5oseuRjZvw9MTdzJ9Ew0FjkTXZSW//AL7VaWx0hg5Y093Ca5rIEJiiIYweYX0mSkdgftF3QQcomlv0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741908553; c=relaxed/simple;
	bh=7OL19V8QvGyEj3D1qqdQDk2ZmmAsVQ4HgWQt23MbCdQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=kNItqAjFXjEMddOUSREytZi8EOxrz7BALbdqqaJ6QN3B3n4y6xz7iTplMNs10hBoNPqsRNafDSwkDSlzw13RLyFDBl6+WbGZTpB1rJtBXaoM1O4/U6fYiLACFFk8MziKXuabi2jbMxdT5DhCwUYpFK6BA3u2ekCpnOA8I/OByCw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YfnOorzl; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741908549; x=1773444549;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=7OL19V8QvGyEj3D1qqdQDk2ZmmAsVQ4HgWQt23MbCdQ=;
  b=YfnOorzl3n5/RoawFK2Dl7WBiHR/fhTcA1sfyuXips23ASjqrIfucbtl
   bNGaFqJQ8N++7H9Mw3YqNSGDVHfuRRWdfoDq7Dx10Lmzh4fwto6FMy3Ww
   WzPcGfYB07clSElYgqJsn76GccpHy/REec9z0yOSCeFTEfu/JVL9oa8D1
   lFGVT4k+Vre1mftpEateCAND4fQ4o9ggnu6Uld2dNnIKqWCorcYZZklQz
   +2LPi65Tl4JPzH7teViqDloRMQ6BF5rfsLSsIa01FkqbAoirW1Tjn+ORe
   Aea6chMAIZd3h/jD2tRvgeN9vWv3IwnUgcAVQWqHSnBVIjl47I6waeP6u
   w==;
X-CSE-ConnectionGUID: AxxT9Y0zTO6hw+WSqTLNng==
X-CSE-MsgGUID: 1rwPYTBhRim39NHGYzFD7Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11372"; a="53688475"
X-IronPort-AV: E=Sophos;i="6.14,245,1736841600"; 
   d="scan'208";a="53688475"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Mar 2025 16:29:08 -0700
X-CSE-ConnectionGUID: lRIqvr29TbunDK8++YePHg==
X-CSE-MsgGUID: v0LtyT1ZSgmVLhEr9ZiYsQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,245,1736841600"; 
   d="scan'208";a="121806021"
Received: from philliph-desk.amr.corp.intel.com (HELO vcostago-mobl3) ([10.124.222.83])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Mar 2025 16:29:08 -0700
From: Vinicius Costa Gomes <vinicius.gomes@intel.com>
To: Nathan Lynch <nathan.lynch@amd.com>, Vinod Koul <vkoul@kernel.org>,
 dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: dave.jiang@intel.com, kristen.c.accardi@intel.com, kernel test robot
 <oliver.sang@intel.com>
Subject: Re: [PATCH v1] dmaengine: dmatest: Fix dmatest waiting less when
 interrupted
In-Reply-To: <871pv01vaz.fsf@AUSNATLYNCH.amd.com>
References: <20250305230007.590178-1-vinicius.gomes@intel.com>
 <878qpa13fe.fsf@AUSNATLYNCH.amd.com> <87senhoq1k.fsf@intel.com>
 <874izx10nx.fsf@AUSNATLYNCH.amd.com> <87wmcslwg4.fsf@intel.com>
 <871pv01vaz.fsf@AUSNATLYNCH.amd.com>
Date: Thu, 13 Mar 2025 16:29:07 -0700
Message-ID: <87r030ldbw.fsf@intel.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Nathan Lynch <nathan.lynch@amd.com> writes:

> Vinicius Costa Gomes <vinicius.gomes@intel.com> writes:
>> Nathan Lynch <nathan.lynch@amd.com> writes:
>>
>>> Hi Vinicius,
>>>
>>> Vinicius Costa Gomes <vinicius.gomes@intel.com> writes:
>>>> Nathan Lynch <nathan.lynch@amd.com> writes:
>>>>> Vinicius Costa Gomes <vinicius.gomes@intel.com> writes:
>>>>>> Change the "wait for operation finish" logic to take interrupts into
>>>>>> account.
>>>>>>
>>>>>> When using dmatest with idxd DMA engine, it's possible that during
>>>>>> longer tests, the interrupt notifying the finish of an operation
>>>>>> happens during wait_event_freezable_timeout(), which causes dmatest to
>>>>>> cleanup all the resources, some of which might still be in use.
>>>>>>
>>>>>> This fix ensures that the wait logic correctly handles interrupts,
>>>>>> preventing premature cleanup of resources.
>>>>>>
>>>>>> Reported-by: kernel test robot <oliver.sang@intel.com>
>>>>>> Closes: https://lore.kernel.org/oe-lkp/202502171134.8c403348-lkp@intel.com
>>>>>
>>>>> Given the report at the URL above I'm struggling to follow the rationale
>>>>> for this change. It looks like a use-after-free in idxd while
>>>>> resetting/unbinding the device, and I can't see how changing whether
>>>>> dmatest threads perform freezeable waits would change this.
>>>>>
>>>>
>>>> I think that the short version is that the reproducition script triggers
>>>> different problems on different platforms/configurations.
>>>>
>>>> The solution I proposed fixes a problem I was seeing on a SPR system, on
>>>> a GNR system (that I was only able to get later) I see something more similar
>>>> to this particular splat (currently working on the fix).
>>>>
>>>> Seeing this question, I realize that I should have added a note to the
>>>> commit detailing this.
>>>>
>>>> So I am planning on proposing two (this and another) fixes for the same
>>>> report, hoping that it's not that confusing/unusual.
>>>
>>> I'm still confused... why is wait_event_freezable_timeout() the wrong
>>> API for dmatest to use, and how could changing it to
>>> wait_event_timeout() cause it to "take interrupts into account" that it
>>> didn't before?
>>>
>>
>> My understanding (and testing) is that wait_event_timeout() will block
>> for the duration even in the face of interrupts, 'freezable' will not.
>
> They have different behaviors with respect to *signals* and the
> wake_up() variant used, but not device interrupts.
>

Ah! That's something that I wasn't considering. That it could be
something other than interrupts that were unblocking wait_event_*().

> dmatest_callback() employs wake_up_all(), which means this change
> introduces no beneficial difference in the wakeup behavior. The dmatest
> thread gets woken on receipt of the completion interrupt either way.
>
> And to reiterate, the change regresses the combination of dmatest and
> the task freezer, which is a use case people have cared about,
> apparently.
>

If this change in behavior causes a regression for others, glad to send
a revert and find another solution.

>>> AFAIK the only change made here is that dmatest threads effectively
>>> become unfreezeable, which is contrary to prior authors' intentions:
>>>
>>> commit 981ed70d8e4f ("dmatest: make dmatest threads freezable")
>>> commit adfa543e7314 ("dmatest: don't use set_freezable_with_signal()")


Cheers,
-- 
Vinicius

