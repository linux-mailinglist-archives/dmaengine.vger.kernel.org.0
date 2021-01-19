Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CD9D52FC048
	for <lists+dmaengine@lfdr.de>; Tue, 19 Jan 2021 20:48:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729434AbhASTpE (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 19 Jan 2021 14:45:04 -0500
Received: from mga01.intel.com ([192.55.52.88]:50059 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730183AbhASTo6 (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Tue, 19 Jan 2021 14:44:58 -0500
IronPort-SDR: uMptGRmJsDifPK7HrEBn18xInBKa7Q4rng+0VDxbtHhkWw0L7u3U/tL7cqortXvrLn1FxjTQy+
 FBx4p6MHLdOQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9869"; a="197700914"
X-IronPort-AV: E=Sophos;i="5.79,359,1602572400"; 
   d="scan'208";a="197700914"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jan 2021 11:44:10 -0800
IronPort-SDR: tS99ZRoMcKD2HEn4uThzUqMw4f2RfoqhFCxR1WHmX3I6gjaflS1DNPyAlJue+tpwtM3nvLHSQ8
 Th8up8lRIbFg==
X-IronPort-AV: E=Sophos;i="5.79,359,1602572400"; 
   d="scan'208";a="350648746"
Received: from djiang5-mobl1.amr.corp.intel.com (HELO [10.213.191.188]) ([10.213.191.188])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jan 2021 11:44:09 -0800
Subject: Re: [PATCH] dmaengine: idxd: add module parameter to force disable of
 SVA
To:     Vinod Koul <vkoul@kernel.org>
Cc:     dmaengine@vger.kernel.org
References: <161074811013.2184257.13335125853932003159.stgit@djiang5-desk3.ch.intel.com>
 <20210117065115.GL2771@vkoul-mobl>
 <a7b50b40-ee4a-24c3-d4ba-40c770c970f1@intel.com>
 <20210119163822.GC2771@vkoul-mobl>
From:   Dave Jiang <dave.jiang@intel.com>
Message-ID: <425267d2-dd13-5710-65b9-d98beff2b328@intel.com>
Date:   Tue, 19 Jan 2021 12:44:09 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <20210119163822.GC2771@vkoul-mobl>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org


On 1/19/2021 9:38 AM, Vinod Koul wrote:
> On 18-01-21, 10:06, Dave Jiang wrote:
>> On 1/16/2021 11:51 PM, Vinod Koul wrote:
>>> On 15-01-21, 15:01, Dave Jiang wrote:
>>>> Add a module parameter that overrides the SVA feature enabling. This keeps
>>>> the driver in legacy mode even when intel_iommu=sm_on is set. In this mode,
>>>> the descriptor fields must be programmed with dma_addr_t from the Linux DMA
>>>> API for source, destination, and completion descriptors.
>>>>
>>>> Signed-off-by: Dave Jiang <dave.jiang@intel.com>
>>>> ---
>>>>    drivers/dma/idxd/init.c |    8 +++++++-
>>>>    1 file changed, 7 insertions(+), 1 deletion(-)
>>>>
>>>> diff --git a/drivers/dma/idxd/init.c b/drivers/dma/idxd/init.c
>>>> index 25cc947c6179..9687a24ff982 100644
>>>> --- a/drivers/dma/idxd/init.c
>>>> +++ b/drivers/dma/idxd/init.c
>>>> @@ -26,6 +26,10 @@ MODULE_VERSION(IDXD_DRIVER_VERSION);
>>>>    MODULE_LICENSE("GPL v2");
>>>>    MODULE_AUTHOR("Intel Corporation");
>>>> +static bool sva = true;
>>>> +module_param(sva, bool, 0644);
>>>> +MODULE_PARM_DESC(sva, "Toggle SVA support on/off");
>>> Documentation for this please..
>> Just comments or is there somewhere specific for driver module parameter
>> documentations?
> All the parameters are supposed to be documented in Documentation/admin-guide/kernel-parameters.txt

It seems to be for core kernel components and subsystems, and not 
specific device drivers. I'm not seeing any of the dmaengine driver 
module params being in this doc after grepping in drivers/dma.


>
> Thanks
>
