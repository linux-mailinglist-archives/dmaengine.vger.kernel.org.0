Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DDC25539351
	for <lists+dmaengine@lfdr.de>; Tue, 31 May 2022 16:49:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345292AbiEaOtS (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 31 May 2022 10:49:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345299AbiEaOtQ (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 31 May 2022 10:49:16 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C60232C131;
        Tue, 31 May 2022 07:49:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1654008555; x=1685544555;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=u9Z8ZFlRwWPx3bByNpAkkztxDD23bRv+DbFZ3HtAIpM=;
  b=Owb2g0aiTFnSGEx3VcCNj852vW9z0+1S/fRM5wfsB7LUJpp12WusHe71
   feN5erCY79W/XJSGJmWxq26OndsrDEg0gOLqcYlowi93Ez/OSTrioclD+
   MLXWsfJlbEXSZlqcf2RUPJEPJHaBU5zyUiVXwlipjqTWH4SYmWMrjUPMk
   8kEQwHw3LxTrRmTRrXvSo26Wx1izivl6oYQ3OzwawM9F7YZJq7H3p+Us7
   YPj/Vd0ZdB5FjmYshlQdz1XW1DguiJckK8xynAORfswJLHBhn+NCD7TCQ
   ztdiTN3G+Zlx/wY/awqZCknvnmLiSuCMNaT/cu2KNPEkCsbMnZ2zQ5Og9
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10364"; a="274998817"
X-IronPort-AV: E=Sophos;i="5.91,265,1647327600"; 
   d="scan'208";a="274998817"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 May 2022 07:49:15 -0700
X-IronPort-AV: E=Sophos;i="5.91,265,1647327600"; 
   d="scan'208";a="611859531"
Received: from jahern6-mobl1.amr.corp.intel.com (HELO [10.212.125.28]) ([10.212.125.28])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 May 2022 07:49:14 -0700
Message-ID: <ba4ddd60-335b-b80a-68a2-0568c166f82d@intel.com>
Date:   Tue, 31 May 2022 07:49:16 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.9.1
Subject: Re: [PATCH] dmaengine: add verification of DMA_INTERRUPT capability
 for dmatest
Content-Language: en-US
To:     Vinod Koul <vkoul@kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        dmaengine <dmaengine@vger.kernel.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <164978679251.2361020.5856734256126725993.stgit@djiang5-desk3.ch.intel.com>
 <CAMuHMdVjDTAW-84c9Fh21f_GWOhnD4+VW2nqSTQ6EK-m+KG=vQ@mail.gmail.com>
 <YpWmcHtGzrv4oP5L@matsya>
From:   Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <YpWmcHtGzrv4oP5L@matsya>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org


On 5/30/2022 10:24 PM, Vinod Koul wrote:
> On 30-05-22, 10:06, Geert Uytterhoeven wrote:
>> Hi Dave, Vinod,
> Hi Geert,
>
>> On Wed, Apr 13, 2022 at 12:58 AM Dave Jiang <dave.jiang@intel.com> wrote:
>>> Looks like I forgot to add DMA_INTERRUPT cap setting to the idxd driver and
>>> dmatest is still working regardless of this mistake. Add an explicit check
>>> of DMA_INTERRUPT capability for dmatest to make sure the DMA device being used
>>> actually supports interrupt before the test is launched and also that the
>>> driver is programmed correctly.
>>>
>>> Signed-off-by: Dave Jiang <dave.jiang@intel.com>
>> Thanks for your patch, which is now commit a8facc7b988599f8
>> ("dmaengine: add verification of DMA_INTERRUPT capability for
>> dmatest") upstream.
>>
>>> --- a/drivers/dma/dmatest.c
>>> +++ b/drivers/dma/dmatest.c
>>> @@ -675,10 +675,16 @@ static int dmatest_func(void *data)
>>>          /*
>>>           * src and dst buffers are freed by ourselves below
>>>           */
>>> -       if (params->polled)
>>> +       if (params->polled) {
>>>                  flags = DMA_CTRL_ACK;
>>> -       else
>>> -               flags = DMA_CTRL_ACK | DMA_PREP_INTERRUPT;
>>> +       } else {
>>> +               if (dma_has_cap(DMA_INTERRUPT, dev->cap_mask)) {
>>> +                       flags = DMA_CTRL_ACK | DMA_PREP_INTERRUPT;
>>> +               } else {
>>> +                       pr_err("Channel does not support interrupt!\n");
>>> +                       goto err_pq_array;
>>> +               }
>>> +       }
>>>
>>>          ktime = ktime_get();
>>>          while (!(kthread_should_stop() ||
>>> @@ -906,6 +912,7 @@ static int dmatest_func(void *data)
>> Shimoda-san reports that this commit breaks dmatest on rcar-dmac.
>> Like most DMA engine drivers, rcar-dmac does not set the DMA_INTERRUPT
>> capability flag, hence dmatest now fails to start:
>>
>>      dmatest: Channel does not support interrupt!
>>
>> To me, it looks like the new check is bogus, as I believe it confuses
>> two different concepts:
>>
>>    1. Documentation/driver-api/dmaengine/provider.rst says:
>>
>>         - DMA_INTERRUPT
>>
>>           - The device is able to trigger a dummy transfer that will
>>             generate periodic interrupts
>>
>>    2. In non-polled mode, dmatest sets DMA_PREP_INTERRUPT.
>>       include/linux/dmaengine.h says:
>>
>>         * @DMA_PREP_INTERRUPT - trigger an interrupt (callback) upon
>> completion of
>>         *  this transaction
>>
>> As dmatest uses real transfers, I think it does not depend on
>> the ability to use interrupts from dummy transfers.
> Yes this does not look right to me. DMA_INTERRUPT is for a specific
> capability which is linked to dma_prep_interrupt() which dmatest does
> not use so i think it is not correct for dmatest to use this...
>
> I can revert this patch... Dave?
Yes we can revert it.
