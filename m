Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3FCB71D9D6D
	for <lists+dmaengine@lfdr.de>; Tue, 19 May 2020 19:03:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729316AbgESRDB (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 19 May 2020 13:03:01 -0400
Received: from mga17.intel.com ([192.55.52.151]:8236 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729001AbgESRDB (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Tue, 19 May 2020 13:03:01 -0400
IronPort-SDR: gtSMzOF/S7bWBm5LhK2X8g1UB3unIa5zjixuiQA/vrI2wT29Oo4J7iusw3sX10RFVtOqGmYvWE
 UaKdBI//S/nA==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 May 2020 10:02:13 -0700
IronPort-SDR: CbRR9w49pMCJw7nMNaM5wD66CPd2kPvfV7CUsTEQjx4ElTt5a3/2wRXcmpfFz4d5m8/i4Ia2Yi
 6GL45LFXsIOg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,410,1583222400"; 
   d="scan'208";a="267950976"
Received: from djiang5-mobl1.amr.corp.intel.com (HELO [10.212.30.183]) ([10.212.30.183])
  by orsmga006.jf.intel.com with ESMTP; 19 May 2020 10:02:12 -0700
Subject: Re: [PATCH v4] dmaengine: cookie bypass for out of order completion
To:     Vinod Koul <vkoul@kernel.org>
Cc:     Peter Ujfalusi <peter.ujfalusi@ti.com>, dmaengine@vger.kernel.org,
        swathi.kovvuri@intel.com
References: <158924063387.26270.4363255780049839915.stgit@djiang5-desk3.ch.intel.com>
 <4d279eb4-baf8-f504-da30-6a6a963bc521@ti.com>
 <f63a0895-914c-3509-1521-f978f30fb39b@intel.com>
 <20200515064811.GJ333670@vkoul-mobl>
 <4e17fbe4-62cc-d596-f15c-5d3a7105cdcb@intel.com>
 <20200519165959.GR374218@vkoul-mobl.Dlink>
From:   Dave Jiang <dave.jiang@intel.com>
Message-ID: <7a174bd3-b95f-ee45-c1ce-b738a709545f@intel.com>
Date:   Tue, 19 May 2020 10:02:11 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200519165959.GR374218@vkoul-mobl.Dlink>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org



On 5/19/2020 9:59 AM, Vinod Koul wrote:
> On 15-05-20, 09:21, Dave Jiang wrote:
>>
>>
>> On 5/14/2020 11:48 PM, Vinod Koul wrote:
>>> On 13-05-20, 09:35, Dave Jiang wrote:
>>>>
>>>>
>>>> On 5/13/2020 12:30 AM, Peter Ujfalusi wrote:
>>>>>
>>>>>
>>>>> On 12/05/2020 2.47, Dave Jiang wrote:
>>>>>> The cookie tracking in dmaengine expects all submissions completed in
>>>>>> order. Some DMA devices like Intel DSA can complete submissions out of
>>>>>> order, especially if configured with a work queue sharing multiple DMA
>>>>>> engines. Add a status DMA_OUT_OF_ORDER that tx_status can be returned for
>>>>>> those DMA devices. The user should use callbacks to track the completion
>>>>>> rather than the DMA cookie. This would address the issue of dmatest
>>>>>> complaining that descriptors are "busy" when the cookie count goes
>>>>>> backwards due to out of order completion. Add DMA_COMPLETION_NO_ORDER
>>>>>> DMA capability to allow the driver to flag the device's ability to complete
>>>>>> operations out of order.
>>>>>
>>>>> I'm still a bit hesitant around this.
>>>>> If the DMA only support out of order completion then it is mandatory
>>>>> that each descriptor must have unique callback parameter in order the
>>>>> client could know which transfer has been completed.
>>>
>>> Maybe we can still use the cookie to indicate that, or leave it to users
>>> to manage? They can add an id in the callback params?
>>>
>>> Using former is easy, but still user needs to keep track... later can be
>>> possibly more suited here?
>>>
>>
>> Is there anything else I need to do with this patch?
> 
> Not really atm, but i am going to defer this after merge window.
> 

Fair enough. Thanks.
