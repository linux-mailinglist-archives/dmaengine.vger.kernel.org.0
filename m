Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 57C5E2AFE93
	for <lists+dmaengine@lfdr.de>; Thu, 12 Nov 2020 06:39:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728801AbgKLFjM (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 12 Nov 2020 00:39:12 -0500
Received: from mga14.intel.com ([192.55.52.115]:64728 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728058AbgKLDJ2 (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Wed, 11 Nov 2020 22:09:28 -0500
IronPort-SDR: 8+U7I84nBee6i0C2mi3uiDN0Jg1g6NdWPAmhQqSwgCIPD18c3HKBa9RvmsMNSwxBMATglWOa27
 06QVdSccoQug==
X-IronPort-AV: E=McAfee;i="6000,8403,9802"; a="169466800"
X-IronPort-AV: E=Sophos;i="5.77,471,1596524400"; 
   d="scan'208";a="169466800"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Nov 2020 19:09:28 -0800
IronPort-SDR: YQ0fl6eD8xzAlX5XyQoASRTeAWj6hbJWPziPg5YG+qeRgpDsmQIOTA6wnkA/nSx6jlUMHzP9FP
 yW3u+JGYTkOw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,471,1596524400"; 
   d="scan'208";a="356938853"
Received: from linux.intel.com ([10.54.29.200])
  by fmsmga004.fm.intel.com with ESMTP; 11 Nov 2020 19:09:27 -0800
Received: from [10.215.242.65] (mreddy3x-MOBL.gar.corp.intel.com [10.215.242.65])
        by linux.intel.com (Postfix) with ESMTP id 5279D580B99;
        Wed, 11 Nov 2020 19:09:24 -0800 (PST)
Subject: Re: [PATCH v7 1/2] dt-bindings: dma: Add bindings for intel LGM SOC
To:     Thomas Langer <tlanger@maxlinear.com>,
        "dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>,
        "vkoul@kernel.org" <vkoul@kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Shevchenko, Andriy" <andriy.shevchenko@intel.com>,
        "chuanhua.lei@linux.intel.com" <chuanhua.lei@linux.intel.com>,
        "Kim, Cheol Yong" <Cheol.Yong.Kim@intel.com>,
        "Wu, Qiming" <qi-ming.wu@intel.com>,
        "malliamireddy009@gmail.com" <malliamireddy009@gmail.com>,
        "peter.ujfalusi@ti.com" <peter.ujfalusi@ti.com>,
        "Langer, Thomas" <thomas.langer@intel.com>
References: <cover.1600827061.git.mallikarjunax.reddy@linux.intel.com>
 <f298715ab197ae72ab9b33caee2a19cc3e8be3f5.1600827061.git.mallikarjunax.reddy@linux.intel.com>
 <DM6PR19MB3594E466A1B76229EC1395BABB160@DM6PR19MB3594.namprd19.prod.outlook.com>
 <9882db7a-755b-84c9-b132-1839dea5e6b8@linux.intel.com>
 <DM6PR19MB397705C898DE2FBA755B2D80BBE90@DM6PR19MB3977.namprd19.prod.outlook.com>
From:   "Reddy, MallikarjunaX" <mallikarjunax.reddy@linux.intel.com>
Message-ID: <31bc9cd9-c1aa-b816-b632-e0433d0ad8cc@linux.intel.com>
Date:   Thu, 12 Nov 2020 11:09:23 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.1
MIME-Version: 1.0
In-Reply-To: <DM6PR19MB397705C898DE2FBA755B2D80BBE90@DM6PR19MB3977.namprd19.prod.outlook.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Hi Thomas,

On 11/11/2020 1:39 AM, Thomas Langer wrote:
>
>> -----Original Message-----
>> From: Reddy, MallikarjunaX <mallikarjunax.reddy@linux.intel.com>
>> Sent: Montag, 2. November 2020 15:42
>> To: Thomas Langer <tlanger@maxlinear.com>; dmaengine@vger.kernel.org;
>> vkoul@kernel.org; devicetree@vger.kernel.org; robh+dt@kernel.org
>> Cc: linux-kernel@vger.kernel.org; Shevchenko, Andriy
>> <andriy.shevchenko@intel.com>; chuanhua.lei@linux.intel.com; Kim,
>> Cheol Yong <Cheol.Yong.Kim@intel.com>; Wu, Qiming <qi-
>> ming.wu@intel.com>; malliamireddy009@gmail.com; peter.ujfalusi@ti.com;
>> Langer, Thomas <thomas.langer@intel.com>
>> Subject: Re: [PATCH v7 1/2] dt-bindings: dma: Add bindings for intel
>> LGM SOC
>>
>> This email was sent from outside of MaxLinear.
>>
>>
>> Hi Thomas,
>> Thanks for the review, my comments inline.
>>
>> On 10/28/2020 3:24 AM, Thomas Langer wrote:
>>> Hello Reddy,
>>>
>>> I think "Intel" should always be written with a capital "I" (like in
>> the Subject, but except in the binding below)
>> OK.
>>>> + compatible:
>>>> +  oneOf:
>>>> +   - const: intel,lgm-cdma
>>>> +   - const: intel,lgm-dma2tx
>>>> +   - const: intel,lgm-dma1rx
>>>> +   - const: intel,lgm-dma1tx
>>>> +   - const: intel,lgm-dma0tx
>>>> +   - const: intel,lgm-dma3
>>>> +   - const: intel,lgm-toe-dma30
>>>> +   - const: intel,lgm-toe-dma31
>>> Bindings are normally not per instance.
>>> What if next generation chip gets more DMA modules but has no other
>> changes in the HW block?
>>> What is wrong with
>>>     - const: intel,lgm-cdma
>>>     - const: intel,lgm-hdma
>>> and extra attributes to define the rx/tx restriction (or what do it
>> mean?)?
>>>   From the driver code I saw that "toe" is also just of type "hdma"
>> and no further differences in code are done.
>> We had a discussion on the same in the previous patches and Rob
>> Herring
>> said Okay using Different compatibles.
>> below the snippet.
>> ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
>> +
>>   >>> + compatible:
>>   >>> +  anyOf:
>>   >>> +   - const: intel,lgm-cdma
>>   >>> +   - const: intel,lgm-dma2tx
>>   >>> +   - const: intel,lgm-dma1rx
>>   >>> +   - const: intel,lgm-dma1tx
>>   >>> +   - const: intel,lgm-dma0tx
>>   >>> +   - const: intel,lgm-dma3
>>   >>> +   - const: intel,lgm-toe-dma30
>>   >>> +   - const: intel,lgm-toe-dma31
>>   >> Please explain why you need so many different compatible strings.
>>   > This hw dma has 7 DMA instances.
>>   > Some for datapath, some for memcpy  and some for TOE.
>>   > Some for TX only, some for RX only, and some for TX/RX(memcpy and
>> ToE).
>>   >
>>   > dma TX/RX type we considered as driver specific data of each
>> instance and
>>   > used different compatible strings for each instance.
>>   > And also idea is in future if any driver specific data of any
>> particular
>>   > instance we can handle.
>>   >
>>   > Here if dma name and type(tx or rx) will be accepted as devicetree
>>   > attributes then we can move .name = "toe_dma31", & .type =
>> DMA_TYPE_MCPY
>>   > to devicetree. So that the compatible strings can be limited to
>> two.
>>   > intel,lgm-cdma & intel,lgm-hdma .
>>
>> [Rob]
>> Different compatibles are okay if the instances are different and we
>> don't have properties to describe the differences.
> Okay, but then explain what the differences are, that cannot be described
> by other properties/attributes. In the driver code I cannot see anything,
> except the "name". But for printouts in driver, "drv_dbg" or similar will
> just use the node path for the instance.
On patch4 series we had the same discussion.
i will brief it here again.

This hw dma has 7 DMA instances, and each Some for TX only, some for RX 
only, and some for TX/RX.

dma TX/RX type we considered as driver specific data and it cant be used 
as dt property as per the previous reviewers.

So i moved it to driver specific data.

If type(tx or rx) will be accepted as devicetree attributes then we can 
move it to devicetree.

So as you said we can limit compatible strings can be limited to two. 
intel,lgm-cdma & intel,lgm-hdma .

One more advantage i see with this model is in future if any driver 
specific data of any particular instance we can handle easily.
>
>> For some of what you have in this binding, I think it should be part
>> of
>> the consumer cells.
>> ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
>> ++
>>> Best regards,
>>> Thomas
>>>
