Return-Path: <dmaengine+bounces-4636-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 626D0A4C5C0
	for <lists+dmaengine@lfdr.de>; Mon,  3 Mar 2025 16:53:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7BBDC3A31AE
	for <lists+dmaengine@lfdr.de>; Mon,  3 Mar 2025 15:51:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A44BA1C84A8;
	Mon,  3 Mar 2025 15:51:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MtaeKwbd"
X-Original-To: dmaengine@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEEB81F4166
	for <dmaengine@vger.kernel.org>; Mon,  3 Mar 2025 15:51:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741017104; cv=none; b=XwRRpCmobgOTlj/HQAg1CFsSH/NLuLydx8s7E9khcMePQmdSF9/0az+3cKuuzMM0ygw44VFeg5TEOP2gzO2ti10X5PRy6kfh6YanpYudP9XFYfQiwPbJGOqxBgrn+ylVghTW3jVzj0VY4cS6Tn7bg7fxPK7zuyzRLP6L8DPNAbA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741017104; c=relaxed/simple;
	bh=BHfxXs24EfeneVkjBXQwhFXVDCOT+vocFBZOKvwDRF0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IMQ98+35uOn8UEuvyVmpUSARLJw+JyF/cXfjrxqil91nIF3Oys3zOaWM1hDd/BGCp7rhKTRgJN5Fk6nFykW0SqGg728BdazrAzezAPfPgJXg9tDNbCEDGTE08UcMxC5BP97kPhpM3t+jh8p6q0VUtkgSrtCaEDDpDI/G/87m7w8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MtaeKwbd; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741017103; x=1772553103;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=BHfxXs24EfeneVkjBXQwhFXVDCOT+vocFBZOKvwDRF0=;
  b=MtaeKwbdPf345XaH+XV7p9dtdSiyZiX21n2POX3m9HMYmeonjrfEDsYg
   s7vVxD3lVH3+i+9hh4/6FfntpjGeKMCCT2oToKxhM6fcDsObHzumkYces
   1kLjsNkCzFQyYxBRATPgWC9RhCi+pgAtRVO2nqHQEkGJYvaJmtpFyqSpI
   2sGU5CNZhMRjkxw6Sms7agsdsmTCBiFMNusZ6+smEIUTNyyoBxUL5uJN8
   rd/ya/Mv7npCA+Qi6BXTEwmZ/kY5P2s+KESNWF0CXDZHDekwJB/sxPG+c
   y8OyjIQ0/kCE9N39feK96VCoTQdsDHWrf9NqdbfFO2PCYwpFj6/TpOPII
   A==;
X-CSE-ConnectionGUID: i9gM0lCgTR2HIBMatWcqLw==
X-CSE-MsgGUID: b3iI7dL/Qa+x6Y/btx/lSA==
X-IronPort-AV: E=McAfee;i="6700,10204,11362"; a="42090095"
X-IronPort-AV: E=Sophos;i="6.13,330,1732608000"; 
   d="scan'208";a="42090095"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Mar 2025 07:51:42 -0800
X-CSE-ConnectionGUID: uwWdifVQSKuWIt/1PmoyZQ==
X-CSE-MsgGUID: hUE3ssvsR7mBd9VFO2CtnA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,330,1732608000"; 
   d="scan'208";a="123067653"
Received: from kcaccard-desk.amr.corp.intel.com (HELO [10.125.109.29]) ([10.125.109.29])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Mar 2025 07:51:42 -0800
Message-ID: <9714cb6c-8b37-4fc6-bb09-a1fb4a5bb1b8@intel.com>
Date: Mon, 3 Mar 2025 08:51:41 -0700
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: dma_find_channel(DMA_MEMCPY) on ioat
To: Carlos Sergio Bederian <carlos.bederian@unc.edu.ar>
Cc: dmaengine@vger.kernel.org
References: <CAFRNPix2JH2De8Hjxwi7EiBnyUVkMvKw7KeowV+EGvd_SuxrfA@mail.gmail.com>
 <4e32d831-b4d1-4a5a-905e-05858ce0be2a@intel.com>
 <CAFRNPiyLijU41EMZ6X0j4ooPP27L3DcRWwJwcJQ_zJHrvbAmpg@mail.gmail.com>
 <1b58f456-8e24-4a3a-b93c-687baed3ce93@intel.com>
 <CAFRNPiyiQQRaFjkzaXDTOQgxjYWRbkDnRBAwrFAe9cdpeuBSVQ@mail.gmail.com>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <CAFRNPiyiQQRaFjkzaXDTOQgxjYWRbkDnRBAwrFAe9cdpeuBSVQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 3/3/25 8:41 AM, Carlos Sergio Bederian wrote:
> On Mon, Mar 3, 2025 at 12:25 PM Dave Jiang <dave.jiang@intel.com> wrote:
>>
>>
>>
>> On 3/1/25 8:17 AM, Carlos Sergio Bederian wrote:
>>> On Fri, Feb 28, 2025 at 6:39 PM Dave Jiang <dave.jiang@intel.com> wrote:
>>>>
>>>>
>>>>
>>>> On 2/28/25 2:23 PM, Carlos Sergio Bederian wrote:
>>>>> I work at an HPC center and I've been trying to figure out why the
>>>>> knem intra-node communication kernel module stopped being able to use
>>>>> IOAT to offload memcpy at some point in time, presumably a long time
>>>>> ago.
>>>>> The knem module uses dma_find_channel(DMA_MEMCPY) to get a dma_chan so
>>>>> I wrote a test kernel module that tries to grab a dma_chan using both
>>>>> dma_find_channel and dma_request_channel and then submits a memcpy.
>>>>> dma_request_channel succeeds in returning a DMA_MEMCPY channel, but
>>>>> dma_find_channel never does, regardless of order. This is on a Debian
>>>>> 6.12.9 kernel.
>>>>> Is there anything I'm missing?
>>>>
>>>> Does dmatest work for you?
>>> Yup, I've just compiled 6.12.17 with dmatest and it ran fine on every channel
>>> listed in /sys/class/dma. No changes wrt dma_find_channel.
>>
>> If dmatest is working then there does not appear to be any kernel
>> regressions AFAICT. You can either try to do a git bisect and figure out
>> what changed for you, or you can do some code tracing with
>> dma_find_channel() and see why your code is failing to locate a channel.
>> You can also compare your code with dmatest and see if there is anything
>> you may need to tweak for your code.
> 
> AFAICT dmatest only calls dma_request_channel(), it doesn't cover
> dma_find_channel().

I think what changed was setting the channels in ioat with DMA_PRIVATE, which made them unavailable with channel_table that dma_find_channel() is expecting. I suggest you switch your code to use dma_request_channel().

https://elixir.bootlin.com/linux/v6.14-rc4/source/drivers/dma/ioat/init.c#L1160


 
> 
>>
>> DJ
>>
>>>
>>>> Also, make sure dmatest isn't loaded when you have your module loaded.
>>> dmatest wasn't even built.
>>>
>>>> Or any other kernel module that uses dma like ntb_transport isn't claiming
>>>> the channels.
>>> No users AFAICT.
>>>
>>>>
>>>> DJ
>>>>>
>>>>> static struct dma_chan* dma_req(void) {
>>>>>     struct dma_chan* chan = NULL;
>>>>>     dma_cap_mask_t mask;
>>>>>     dma_cap_zero(mask);
>>>>>     dma_cap_set(DMA_MEMCPY, mask);
>>>>>     chan = dma_request_channel(mask, NULL, NULL);
>>>>>     if (!chan) {
>>>>>         pr_err("dmacopy: dma_request_channel didn't return a channel");
>>>>>     } else {
>>>>>         pr_info("dmacopy: dma_request_channel succeeded");
>>>>>     }
>>>>>     return chan;
>>>>> }
>>>>>
>>>>> static struct dma_chan* dma_find(void) {
>>>>>     struct dma_chan* chan = NULL;
>>>>>     dmaengine_get();
>>>>>     chan = dma_find_channel(DMA_MEMCPY);
>>>>>     if (!chan) {
>>>>>         pr_err("dmacopy: dma_find_channel didn't return a channel");
>>>>>         dmaengine_put();
>>>>>     } else {
>>>>>         pr_info("dmacopy: dma_find_channel succeeded");
>>>>>     }
>>>>>     return chan;
>>>>> }
>>>>>
>>>>
>>


