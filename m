Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B03A12729AD
	for <lists+dmaengine@lfdr.de>; Mon, 21 Sep 2020 17:13:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727760AbgIUPNc (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 21 Sep 2020 11:13:32 -0400
Received: from mga05.intel.com ([192.55.52.43]:50719 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726413AbgIUPNc (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Mon, 21 Sep 2020 11:13:32 -0400
IronPort-SDR: g9rUCueUgy7STz7p2BuVjiNPkYlSahn6Y+5PotgS2qKpj30MvauUMj7yR/6lkvtCDUy89YFdRq
 sqwr/pmzO+8A==
X-IronPort-AV: E=McAfee;i="6000,8403,9751"; a="245236770"
X-IronPort-AV: E=Sophos;i="5.77,286,1596524400"; 
   d="scan'208";a="245236770"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Sep 2020 08:13:29 -0700
IronPort-SDR: evHvP/WUYitjOm2oxlHWZO9ukc8IkQ1fE6TM22CEVZcIVVcUxjr1i4LXOFpfQ4xzqzU21jv6W2
 xbgI46sYyhfg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,286,1596524400"; 
   d="scan'208";a="346587140"
Received: from linux.intel.com ([10.54.29.200])
  by FMSMGA003.fm.intel.com with ESMTP; 21 Sep 2020 08:13:27 -0700
Received: from [10.215.245.98] (mreddy3x-MOBL.gar.corp.intel.com [10.215.245.98])
        by linux.intel.com (Postfix) with ESMTP id 26DF358058B;
        Mon, 21 Sep 2020 08:13:23 -0700 (PDT)
Subject: Re: [PATCH v6 2/2] Add Intel LGM soc DMA support.
To:     Andy Shevchenko <andriy.shevchenko@intel.com>
Cc:     dmaengine@vger.kernel.org, vkoul@kernel.org,
        devicetree@vger.kernel.org, robh+dt@kernel.org,
        linux-kernel@vger.kernel.org, chuanhua.lei@linux.intel.com,
        cheol.yong.kim@intel.com, qi-ming.wu@intel.com,
        malliamireddy009@gmail.com, peter.ujfalusi@ti.com
References: <cover.1599605765.git.mallikarjunax.reddy@linux.intel.com>
 <748370a51af0ab768e542f1537d1aa3aeefebe8a.1599605765.git.mallikarjunax.reddy@linux.intel.com>
 <20200909111424.GQ1891694@smile.fi.intel.com>
 <36a42016-3260-3933-bbf9-9203c4124115@linux.intel.com>
 <20200918122029.GX3956970@smile.fi.intel.com>
From:   "Reddy, MallikarjunaX" <mallikarjunax.reddy@linux.intel.com>
Message-ID: <bc6499da-1179-25c1-a624-bf2566354ead@linux.intel.com>
Date:   Mon, 21 Sep 2020 23:13:22 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20200918122029.GX3956970@smile.fi.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Hi Andy,
Thanks for your comments. My comments are in line.

On 9/18/2020 8:20 PM, Andy Shevchenko wrote:
> On Fri, Sep 18, 2020 at 11:42:54AM +0800, Reddy, MallikarjunaX wrote:
>> On 9/9/2020 7:14 PM, Andy Shevchenko wrote:
>>> On Wed, Sep 09, 2020 at 07:07:34AM +0800, Amireddy Mallikarjuna reddy wrote:
> ...
>
>>>> +	help
>>>> +	  Enable support for intel Lightning Mountain SOC DMA controllers.
>>>> +	  These controllers provide DMA capabilities for a variety of on-chip
>>>> +	  devices such as SSC, HSNAND and GSWIP.
>>> And how module will be called?
>>   are you expecting to include 'default y' ?
> I'm expecting to see something like "if you choose M the module will be called
> bla-foo-bar." Look at the existing examples in the kernel.
ok, i will change bool to tristate.
>
> ...
>
>>>> +ldma_update_bits(struct ldma_dev *d, u32 mask, u32 val, u32 ofs)
>>>> +{
>>>> +	u32 old_val, new_val;
>>>> +
>>>> +	old_val = readl(d->base +  ofs);
>>>> +	new_val = (old_val & ~mask) | (val & mask);
>>> With bitfield.h you will have this as u32_replace_bits().
>> -  new_val = (old_val & ~mask) | (val & mask);
>> + new_val = old_val;
>> + u32_replace_bits(new_val, val, mask);
>>
>> I think in this function we cant use this because of compilation issues
>> thrown by bitfield.h . Expecting 2nd and 3rd arguments as constant numbers
>> not as type variables.
>>
>> ex:
>> 	u32_replace_bits(val, 0, IPA_REG_ENDP_ROUTER_HASH_MSK_ALL);
> How comes these are constants? In the above you have a function which does
> r-m-w approach to the register. It should be something like
>
> 	old = read();
> 	new = u32_replace_bits(old, ...);
> 	write(new);
>
>> ./include/linux/bitfield.h:131:3: error: call to '__field_overflow' declared
>> with attribute error: value doesn't fit into mask
>>     __field_overflow();     \
>>     ^~~~~~~~~~~~~~~~~~
>>
>> ./include/linux/bitfield.h:119:3: error: call to '__bad_mask' declared with
>> attribute error: bad bitfield mask
>>     __bad_mask();
>>     ^~~~~~~~~~~~
> So, even with constants u32_replace_bits() must work. Maybe you didn't get how?

Thanks Andy, now i know how u32_replace_bits() is working.

The mask is not the continuous bits in some cases. Due to the mask bits 
are not continuous u32_replace_bits() can't be used here.
Ex:
         u32 mask = DMA_CPOLL_EN | DMA_CPOLL_CNT;

Comes to __field_overflow error, update bits in the 'val' are aligned 
with mask bits. Because of the this reason in u32_replace_bits() 'val'  
exceeds the 'mask' in some cases which is causing __field_overflow error.

>>>> +	if (new_val != old_val)
>>>> +		writel(new_val, d->base + ofs);
>>>> +}
> ...
>
>>>> +	/* High 4 bits */
>>> Why only 4?
>> this is higher 4 bits of 36 bit addressing..
> Make it clear in the comment.
ok.
>
> ...
>
>>>> +device_initcall(intel_ldma_init);
>>> Each _initcall() in general should be explained.
>> ok. is it fine?
>>
>> /* Perform this driver as device_initcall to make sure initialization
>> happens
>>   * before its dma clients of some are platform specific. make sure to
>> provice
>>   * registered dma channels and dma capabilities to client before their
>>   * initialization.
>>   */
> /*
>   * Just follow proper multi-line comment style.
>   * And use dma -> DMA.
>   */
Ok.
