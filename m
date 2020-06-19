Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8C162201A1F
	for <lists+dmaengine@lfdr.de>; Fri, 19 Jun 2020 20:15:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388767AbgFSSPs (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 19 Jun 2020 14:15:48 -0400
Received: from mga12.intel.com ([192.55.52.136]:63533 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731978AbgFSSPr (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Fri, 19 Jun 2020 14:15:47 -0400
IronPort-SDR: NwX2QgBf1SRESzi+RRskWV+stnYLYiQwFeCUQQ+6BzWk9tvs/sgoDsWmANB4qALmZAc+qCr2hn
 Mx3bvc31ddZQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9657"; a="122768492"
X-IronPort-AV: E=Sophos;i="5.75,256,1589266800"; 
   d="scan'208";a="122768492"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jun 2020 11:15:47 -0700
IronPort-SDR: npqhfMWARGKb8wiWXyTRQiQFlguHJ+tr6DwmqD/5yAttoDlbzA4SL5kAnZGExGTLWfw0IotFMq
 egCVgeKQhVoA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,256,1589266800"; 
   d="scan'208";a="477699409"
Received: from djiang5-mobl1.amr.corp.intel.com (HELO [10.209.171.94]) ([10.209.171.94])
  by fmsmga006.fm.intel.com with ESMTP; 19 Jun 2020 11:15:47 -0700
Subject: Re: [PATCH v5] dmaengine: cookie bypass for out of order completion
To:     Vinod Koul <vkoul@kernel.org>
Cc:     dmaengine@vger.kernel.org, swathi.kovvuri@intel.com,
        peter.ujfalusi@ti.com
References: <158939557151.20335.12404113976045569870.stgit@djiang5-desk3.ch.intel.com>
 <20200617141526.GV2324254@vkoul-mobl>
From:   Dave Jiang <dave.jiang@intel.com>
Message-ID: <7cf3f322-787b-1aaa-227c-11c603e6d663@intel.com>
Date:   Fri, 19 Jun 2020 11:15:46 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20200617141526.GV2324254@vkoul-mobl>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org



On 6/17/2020 7:15 AM, Vinod Koul wrote:
> On 13-05-20, 11:47, Dave Jiang wrote:
>> The cookie tracking in dmaengine expects all submissions completed in
>> order. Some DMA devices like Intel DSA can complete submissions out of
>> order, especially if configured with a work queue sharing multiple DMA
>> engines. Add a status DMA_OUT_OF_ORDER that tx_status can be returned for
>> those DMA devices. The user should use callbacks to track the completion
>> rather than the DMA cookie. This would address the issue of dmatest
>> complaining that descriptors are "busy" when the cookie count goes
>> backwards due to out of order completion. Add DMA_COMPLETION_NO_ORDER
>> DMA capability to allow the driver to flag the device's ability to complete
>> operations out of order.
> 
> Applied, thanks
> 

Thanks Vinod. I'm trying to find your branch that has this commit so I can 
rebase against it, and I can't seem to find it.
