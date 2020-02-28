Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 41AF91734D3
	for <lists+dmaengine@lfdr.de>; Fri, 28 Feb 2020 11:01:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726969AbgB1KBn (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 28 Feb 2020 05:01:43 -0500
Received: from fllv0016.ext.ti.com ([198.47.19.142]:48436 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726063AbgB1KBn (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 28 Feb 2020 05:01:43 -0500
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 01SA1aHF119895;
        Fri, 28 Feb 2020 04:01:36 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1582884096;
        bh=6z/8/PPg+3rpyYmmH9G+0e+u0vjhkZL9wyT6kVUOkdA=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=mSMXNYrHoruBwHDcCpJ0qbk5rsGBcSJsrHx9UC35V2BvsDUZRsXFWshs1WSpmEWG8
         asovcEaNX1Sb96UV1osT242t00BABUKEOJwyMFk+z5cGAzPlhsxRP/nCUqXmhaOZcq
         iXMEId8jMOufG5ntlUr3h8nnhV2lVkj2zogcctUk=
Received: from DFLE111.ent.ti.com (dfle111.ent.ti.com [10.64.6.32])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 01SA1abV035337
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 28 Feb 2020 04:01:36 -0600
Received: from DFLE113.ent.ti.com (10.64.6.34) by DFLE111.ent.ti.com
 (10.64.6.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3; Fri, 28
 Feb 2020 04:01:35 -0600
Received: from localhost.localdomain (10.64.41.19) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3 via
 Frontend Transport; Fri, 28 Feb 2020 04:01:35 -0600
Received: from [192.168.2.6] (ileax41-snat.itg.ti.com [10.172.224.153])
        by localhost.localdomain (8.15.2/8.15.2) with ESMTP id 01SA1XTu123395;
        Fri, 28 Feb 2020 04:01:34 -0600
Subject: Re: [PATCH v3] dmaengine: Add basic debugfs support
To:     Vinod Koul <vkoul@kernel.org>
CC:     <dmaengine@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <dan.j.williams@intel.com>, <geert@linux-m68k.org>
References: <20200205111557.24125-1-peter.ujfalusi@ti.com>
 <20200224163707.GA2618@vkoul-mobl>
 <71231b0e-a9a2-4795-da71-b484f4992278@ti.com>
 <20200228044704.GC2618@vkoul-mobl>
From:   Peter Ujfalusi <peter.ujfalusi@ti.com>
Message-ID: <970899d9-1491-78e8-1e7a-14e40915d061@ti.com>
Date:   Fri, 28 Feb 2020 12:01:34 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20200228044704.GC2618@vkoul-mobl>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Hi Vinod,

On 28/02/2020 6.47, Vinod Koul wrote:
> Hi Peter,
> 
> On 26-02-20, 14:10, Peter Ujfalusi wrote:
> 
>>>  do we really want a custom dbg_show()..? Drivers can add their own
>>> files...
>>
>> They could do that already ;)
>>
>> With the custom dbg_show() DMA drivers can save on the surrounding
>> code and just fill in the information regarding to their HW.
>> Again, on am654 the default information is:
>> # cat /sys/kernel/debug/dmaengine 
>> dma0 (285c0000.dma-controller): number of channels: 96
>>
>> dma1 (31150000.dma-controller): number of channels: 267
>>  dma1chan0    | 2b00000.mcasp:tx
>>  dma1chan1    | 2b00000.mcasp:rx
>>  dma1chan2    | in-use
>>  dma1chan3    | in-use
>>  dma1chan4    | in-use
>>  dma1chan5    | in-use
>>
>> With my current .dbg_show implementation for k3-udma:
>> # cat /sys/kernel/debug/dmaengine 
>> dma0 (285c0000.dma-controller): number of channels: 96
>>
>> dma1 (31150000.dma-controller): number of channels: 267
>>  dma1chan0    | 2b00000.mcasp:tx (MEM_TO_DEV, tchan8 [0x1008 -> 0xc400], PDMA, TR mode)
>>  dma1chan1    | 2b00000.mcasp:rx (DEV_TO_MEM, rchan8 [0x4400 -> 0x9008], PDMA, TR mode)
>>  dma1chan2    | in-use (MEM_TO_MEM, chan2 pair [0x1002 -> 0x9002], PSI-L Native, TR mode)
>>  dma1chan3    | in-use (MEM_TO_MEM, chan3 pair [0x1003 -> 0x9003], PSI-L Native, TR mode)
>>  dma1chan4    | in-use (MEM_TO_MEM, chan4 pair [0x1004 -> 0x9004], PSI-L Native, TR mode)
>>  dma1chan5    | in-use (MEM_TO_MEM, chan5 pair [0x1005 -> 0x9005], PSI-L Native, TR mode)
>>
>> For me this makes a huge difference.
> 
> Ok
> 
>>>> +DEFINE_SHOW_ATTRIBUTE(dmaengine_debugfs);
>>>> +
>>>> +static int __init dmaengine_debugfs_init(void)
>>>> +{
>>>> +	/* /sys/kernel/debug/dmaengine */
>>>> +	debugfs_create_file("dmaengine", 0444, NULL, NULL,
>>>> +			    &dmaengine_debugfs_fops);
>>>
>>> Should we add a directory? That way we can keep adding stuff into that
>>> one
>>
>> and have this file as 'summary' underneath?
> 
> Correct

/sys/kernel/debug/dmaengine/summary, right?

>> I like the fact hat I can get all the information via one file.
>> Saves a lot of time (and explaining to users) on finding the correct
>> one to cat...
> 
> But am sure we can come with more data to show, so having a directory
> helps :)

OK, so we need to store the dbgfs rootdir and add an API so DMA drivers
can get the dentry of it, so they can implement their custom
files/directories underneath.

- Péter

Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
