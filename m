Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB64F6434EE
	for <lists+dmaengine@lfdr.de>; Mon,  5 Dec 2022 20:54:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235191AbiLETxx (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 5 Dec 2022 14:53:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233056AbiLETxI (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 5 Dec 2022 14:53:08 -0500
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46E0511A0C
        for <dmaengine@vger.kernel.org>; Mon,  5 Dec 2022 11:52:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1670269927; x=1701805927;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=VspCtxcmq76OojNuCz1OgPZQhhOj8e1TedXmfNiU/pQ=;
  b=LzE8dGtSGSnQ+KxdiaEK/dojrstVuhV0OjJEmx0CvFdxwr3aZaqkCL7L
   X/hpLcFvhLVqExEOArEvqOqI7hnDz6dagssM35MO/LXj7fDB/OATF+y7Y
   yX9etW+td2AzvB5pr6nPEXbToaEVxfSXyLg8MY/M0Z0olnZhZL4cifYx8
   jfgspUjreFyvJMXW8HMg3lfxlsTvx/ClnUA8vqyx5v2fMhcv5IbQWMHOu
   NYLG+c4D/2vk4Fqqj01RYaNXFwod9uCoDv84iM2EgF2Wh/oaIdQ2rTwq+
   HU/RhhpWf/cJqfTuRPFHRI4hQBoU1fiT1DvWo7HdIxOE97pBxfWHAwNN1
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10552"; a="317592188"
X-IronPort-AV: E=Sophos;i="5.96,220,1665471600"; 
   d="scan'208";a="317592188"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Dec 2022 11:52:00 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10552"; a="770468423"
X-IronPort-AV: E=Sophos;i="5.96,220,1665471600"; 
   d="scan'208";a="770468423"
Received: from djiang5-mobl2.amr.corp.intel.com (HELO [10.212.26.166]) ([10.212.26.166])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Dec 2022 11:52:00 -0800
Message-ID: <cd0e1de2-2769-8b2b-2372-13071abd476d@intel.com>
Date:   Mon, 5 Dec 2022 12:51:59 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.5.1
Subject: Re: poor ptdma performance
Content-Language: en-US
To:     Eric Pilmore <epilmore@gigaio.com>
Cc:     dmaengine@vger.kernel.org
References: <CAOQPn8tHAx1zsgUO7UAuKf1DJYt+fdT6OPAHoxO+HgEPvT5SPg@mail.gmail.com>
 <CAOQPn8v=PWvRWntknEK9pYu3jLgDePWfsjVByYSjUe_tYCpdPA@mail.gmail.com>
 <90f0244b-adb4-bc5e-792d-2ead9fe463d6@intel.com>
 <CAOQPn8vT2eJW_FS_BcR=x0cFKavhse0EdPkDd+7-0Yrnusm=2g@mail.gmail.com>
From:   Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <CAOQPn8vT2eJW_FS_BcR=x0cFKavhse0EdPkDd+7-0Yrnusm=2g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org



On 12/5/2022 12:40 PM, Eric Pilmore wrote:
> On Mon, Dec 5, 2022 at 7:30 AM Dave Jiang <dave.jiang@intel.com> wrote:
>>
>>
>>
>> On 12/3/2022 1:51 AM, Eric Pilmore wrote:
>>> On Fri, Dec 2, 2022 at 1:57 PM Eric Pilmore <epilmore@gigaio.com> wrote:
>>>>
>>>> Was curious if anybody has any expected performance numbers for the
>>>> AMD DMA engine "ptdma"?
>>>>
>>>> I'm doing some testing utilizing the "ntb_netdev" module for TCP/IP
>>>> communication between servers via NTB (Non-Transparent Bridge) using
>>>> "iperf". I find that on Intel based boxes, utilizing IOAT DMA, I can
>>>> get approximately 19-20 Gb/s for a simple untuned single iperf
>>>> instance. However, when running on AMD based boxes (Milan CPUs), and
>>>> running the latest ptdma driver from the Linux tree, I can only
>>>> achieve about 2-3 Gb/s. I'm thinking there must be some driver knob
>>>> that I need to tweek or something.
>>>>
>>>> Any help is greatly appreciated.
>>>>
>>>> Thanks,
>>>> Eric
>>>
>>>
>>> You can disregard this question. The issue turned out to be a bug in
>>> the ntb_netdev module. The module was calling dev_kfree_skb() in an
>>> inappropriate place (interrupt context). Once that was fixed (changed
>>> to dev_kfree_skb_irq()), some assert WARNINGS (that I had previously
>>> missed) went away and the performance is as expected.
>>>
>>
>> Curious why this bug only effected the AMD DMA driver.... It should've
>> impacted all DMA drivers through NTB right? Did it make any difference
>> with the ioatdma after the change?
> 
> That would have been my expectation also, but we have never seen an
> issue with ioatdma. It is only recently that we've started trying out
> ptdma. This particular area of the ntb_netdev module has utilized
> dev_kfree_skb() forever as far as I know. The suspect calls are in
> ntb_netdev_rx_handler() and ntb_netdev_tx_handler(), each of which
> could be called from interrupt context. These handlers are ultimately
> called indirectly via function pointer (struct
> dma_async_tx_descriptor.callback_result).
> 
> I have also seen an issue during driver shutdown where dma_sync_wait()
> is hanging up, when ptdma is utilized. Flow is:
> - device_del()
>    - bus_remove_device()
>      - device_release_driver()
>        - device_release_driver_internal()
>          - ntb_transport_bus_remove()
>            - ntb_netdev_remove()
>              - ntb_transport_free_queue()
>                - dma_sync_wait() <<-- HANG
> 
> I am still investigating this one further in case it is related to
> something in my local logic as I'm using a custom ntb_transport
> module.

Thanks! Look forward to the fix patch on the linux-ntb mailing list. :)

> 
> Eric
