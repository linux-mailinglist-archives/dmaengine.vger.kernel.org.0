Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E250642BD3
	for <lists+dmaengine@lfdr.de>; Mon,  5 Dec 2022 16:31:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232800AbiLEPbs (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 5 Dec 2022 10:31:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232845AbiLEPbI (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 5 Dec 2022 10:31:08 -0500
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B16BAD2DB
        for <dmaengine@vger.kernel.org>; Mon,  5 Dec 2022 07:30:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1670254212; x=1701790212;
  h=message-id:date:mime-version:subject:to:references:from:
   in-reply-to:content-transfer-encoding;
  bh=jwLmWVYbMtyjUXCZFpgHlU+HWlwcK3pUZKMg4wzTDig=;
  b=W/KVzIisSN6iNFoQapqqr4jD3E/P+uC2jNHFuJLEP2M7kibkjj7FvTqW
   +Tkis8azgAwfFfnpsbaLMLkghdaPJseWOpYarQG9pXw4vGcGUmv4n202R
   rHaGqWEC0LXCSZjL+eJ7aeWgvJr/k9IxgfQWtErQ8kPYoL0JwV5JSWL0s
   nU/EbcR/7JJmsnC7DX0hvgzmrWw6/WMsIl90oD+rp/YRXJaucBAux1LY5
   Bt2iO3NgfThBkKexHALBR2QNPVRnwN1tPo2zrc09bLzLlcXbxjA/Rr/81
   98pMVfqDWWH91M3ctDD5s5feTr4cdLorckFk993aKQzFmnpoegpFYG6Ef
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10552"; a="303995004"
X-IronPort-AV: E=Sophos;i="5.96,219,1665471600"; 
   d="scan'208";a="303995004"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Dec 2022 07:30:12 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10552"; a="788111355"
X-IronPort-AV: E=Sophos;i="5.96,219,1665471600"; 
   d="scan'208";a="788111355"
Received: from djiang5-mobl2.amr.corp.intel.com (HELO [10.212.26.166]) ([10.212.26.166])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Dec 2022 07:30:11 -0800
Message-ID: <90f0244b-adb4-bc5e-792d-2ead9fe463d6@intel.com>
Date:   Mon, 5 Dec 2022 08:29:51 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.5.1
Subject: Re: poor ptdma performance
Content-Language: en-US
To:     Eric Pilmore <epilmore@gigaio.com>, dmaengine@vger.kernel.org
References: <CAOQPn8tHAx1zsgUO7UAuKf1DJYt+fdT6OPAHoxO+HgEPvT5SPg@mail.gmail.com>
 <CAOQPn8v=PWvRWntknEK9pYu3jLgDePWfsjVByYSjUe_tYCpdPA@mail.gmail.com>
From:   Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <CAOQPn8v=PWvRWntknEK9pYu3jLgDePWfsjVByYSjUe_tYCpdPA@mail.gmail.com>
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



On 12/3/2022 1:51 AM, Eric Pilmore wrote:
> On Fri, Dec 2, 2022 at 1:57 PM Eric Pilmore <epilmore@gigaio.com> wrote:
>>
>> Was curious if anybody has any expected performance numbers for the
>> AMD DMA engine "ptdma"?
>>
>> I'm doing some testing utilizing the "ntb_netdev" module for TCP/IP
>> communication between servers via NTB (Non-Transparent Bridge) using
>> "iperf". I find that on Intel based boxes, utilizing IOAT DMA, I can
>> get approximately 19-20 Gb/s for a simple untuned single iperf
>> instance. However, when running on AMD based boxes (Milan CPUs), and
>> running the latest ptdma driver from the Linux tree, I can only
>> achieve about 2-3 Gb/s. I'm thinking there must be some driver knob
>> that I need to tweek or something.
>>
>> Any help is greatly appreciated.
>>
>> Thanks,
>> Eric
> 
> 
> You can disregard this question. The issue turned out to be a bug in
> the ntb_netdev module. The module was calling dev_kfree_skb() in an
> inappropriate place (interrupt context). Once that was fixed (changed
> to dev_kfree_skb_irq()), some assert WARNINGS (that I had previously
> missed) went away and the performance is as expected.
> 

Curious why this bug only effected the AMD DMA driver.... It should've 
impacted all DMA drivers through NTB right? Did it make any difference 
with the ioatdma after the change?

> Eric
