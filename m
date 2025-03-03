Return-Path: <dmaengine+bounces-4634-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BAB3A4C52C
	for <lists+dmaengine@lfdr.de>; Mon,  3 Mar 2025 16:34:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 26D2218856B9
	for <lists+dmaengine@lfdr.de>; Mon,  3 Mar 2025 15:33:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A6DD217F54;
	Mon,  3 Mar 2025 15:25:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Kgi34Em4"
X-Original-To: dmaengine@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49C392139BF
	for <dmaengine@vger.kernel.org>; Mon,  3 Mar 2025 15:25:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741015543; cv=none; b=ZzQdS2I/73XMn4318Rp8nayrA1xgk93q/Ss5szDQ78rEyWLHO4tdfwR7KYCijwXkhy9SBmZg6ofX1w/hj6M0F2FIwKAB97Yd2ptPBAOX/7EXDKmZ9ssNrypHOFLzM/5YTUZ8M/oRDfScqVI7zWxggMN6jl/f5waVzA0w81GhfDk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741015543; c=relaxed/simple;
	bh=ctDClF43dFsnZQf4t5F1+owm4NRy7C32KCmkfHQxT6g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Q9hj4brkuady9/Mfz4DCl3C5T0IT3o31LpiyVXdTfMTN/bXBzul5y6qLxG24xeqgGBQdTYsgGzbGwR3P5CgZXEZKLPo3OzIxOzg+eGutP4BceY6d7CBWhOW4eO60ER/RJ3hsjqsgaCyVaRnu24m7RCRR/j6/0E2xxbp0xhv1Enc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Kgi34Em4; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741015541; x=1772551541;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=ctDClF43dFsnZQf4t5F1+owm4NRy7C32KCmkfHQxT6g=;
  b=Kgi34Em4hb3e7kfD9yamh0/PkzTyMhVTv+JL0Fs3+ZKI+BKMdm2Wul8E
   aw9Tw6dofPIfs3Gee2T7DoYddPaeUiXL2eX/OomHw01L+M2tYytjOuGZg
   wb4cWsDZVZWn1nw+TzgZV4/7N5oPuP0MaNcwnzvJqz/upLY6AX+JdTm3C
   0LM98RWOnwVEyx43U30r+caSecVbydtNYMru0iJ5eM9rHtSDShDvi0CBC
   rQNWB1AQlh/oRbCqeGWGIGN7NVzRPij/+0ZHKYwoM9PN4tHvOzMGDC7VM
   uUjPXfmL/qaNQVTBANbAXTBt+dIjLVSCa0pbDXDsboxERLlm5B6nQ/Qil
   w==;
X-CSE-ConnectionGUID: 4xiC93gJQ8W1fVN7NOvTQQ==
X-CSE-MsgGUID: rfH5dKkzTlynyaYgcMkfXw==
X-IronPort-AV: E=McAfee;i="6700,10204,11362"; a="44707712"
X-IronPort-AV: E=Sophos;i="6.13,330,1732608000"; 
   d="scan'208";a="44707712"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Mar 2025 07:25:39 -0800
X-CSE-ConnectionGUID: /L+JYXH3RnymleF8Wuum5w==
X-CSE-MsgGUID: nNAmgtpKRAmFK0FEeZxJkA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,330,1732608000"; 
   d="scan'208";a="123184598"
Received: from kcaccard-desk.amr.corp.intel.com (HELO [10.125.109.29]) ([10.125.109.29])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Mar 2025 07:25:39 -0800
Message-ID: <1b58f456-8e24-4a3a-b93c-687baed3ce93@intel.com>
Date: Mon, 3 Mar 2025 08:25:37 -0700
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
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <CAFRNPiyLijU41EMZ6X0j4ooPP27L3DcRWwJwcJQ_zJHrvbAmpg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 3/1/25 8:17 AM, Carlos Sergio Bederian wrote:
> On Fri, Feb 28, 2025 at 6:39 PM Dave Jiang <dave.jiang@intel.com> wrote:
>>
>>
>>
>> On 2/28/25 2:23 PM, Carlos Sergio Bederian wrote:
>>> I work at an HPC center and I've been trying to figure out why the
>>> knem intra-node communication kernel module stopped being able to use
>>> IOAT to offload memcpy at some point in time, presumably a long time
>>> ago.
>>> The knem module uses dma_find_channel(DMA_MEMCPY) to get a dma_chan so
>>> I wrote a test kernel module that tries to grab a dma_chan using both
>>> dma_find_channel and dma_request_channel and then submits a memcpy.
>>> dma_request_channel succeeds in returning a DMA_MEMCPY channel, but
>>> dma_find_channel never does, regardless of order. This is on a Debian
>>> 6.12.9 kernel.
>>> Is there anything I'm missing?
>>
>> Does dmatest work for you?
> Yup, I've just compiled 6.12.17 with dmatest and it ran fine on every channel
> listed in /sys/class/dma. No changes wrt dma_find_channel.

If dmatest is working then there does not appear to be any kernel regressions AFAICT. You can either try to do a git bisect and figure out what changed for you, or you can do some code tracing with dma_find_channel() and see why your code is failing to locate a channel. You can also compare your code with dmatest and see if there is anything you may need to tweak for your code.  

DJ

> 
>> Also, make sure dmatest isn't loaded when you have your module loaded.
> dmatest wasn't even built.
> 
>> Or any other kernel module that uses dma like ntb_transport isn't claiming
>> the channels.
> No users AFAICT.
> 
>>
>> DJ
>>>
>>> static struct dma_chan* dma_req(void) {
>>>     struct dma_chan* chan = NULL;
>>>     dma_cap_mask_t mask;
>>>     dma_cap_zero(mask);
>>>     dma_cap_set(DMA_MEMCPY, mask);
>>>     chan = dma_request_channel(mask, NULL, NULL);
>>>     if (!chan) {
>>>         pr_err("dmacopy: dma_request_channel didn't return a channel");
>>>     } else {
>>>         pr_info("dmacopy: dma_request_channel succeeded");
>>>     }
>>>     return chan;
>>> }
>>>
>>> static struct dma_chan* dma_find(void) {
>>>     struct dma_chan* chan = NULL;
>>>     dmaengine_get();
>>>     chan = dma_find_channel(DMA_MEMCPY);
>>>     if (!chan) {
>>>         pr_err("dmacopy: dma_find_channel didn't return a channel");
>>>         dmaengine_put();
>>>     } else {
>>>         pr_info("dmacopy: dma_find_channel succeeded");
>>>     }
>>>     return chan;
>>> }
>>>
>>


