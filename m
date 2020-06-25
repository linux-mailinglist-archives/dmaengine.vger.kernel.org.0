Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 290DE2097BF
	for <lists+dmaengine@lfdr.de>; Thu, 25 Jun 2020 02:42:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388942AbgFYAma (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 24 Jun 2020 20:42:30 -0400
Received: from mga14.intel.com ([192.55.52.115]:50377 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388830AbgFYAm0 (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Wed, 24 Jun 2020 20:42:26 -0400
IronPort-SDR: dhmuzB9G3PPCPnugLVTyx8IiYAxr7T4jbhFazGzMMwtET9aZHFTlGJMISZXskM5jPriorICLUb
 b41H7b5IHu0g==
X-IronPort-AV: E=McAfee;i="6000,8403,9662"; a="143789085"
X-IronPort-AV: E=Sophos;i="5.75,277,1589266800"; 
   d="scan'208";a="143789085"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jun 2020 17:42:25 -0700
IronPort-SDR: zdjQKndy7Dp+7g0lGPf/NZ03uqInuOzQUle0mkWa3LpVSznuEb917yLqMuNNWvUk7Nyaf2OOAV
 IGQ/cIynfLxg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,277,1589266800"; 
   d="scan'208";a="265219337"
Received: from djiang5-mobl1.amr.corp.intel.com (HELO [10.251.31.242]) ([10.251.31.242])
  by fmsmga008.fm.intel.com with ESMTP; 24 Jun 2020 17:42:24 -0700
Subject: Re: DMA Engine: Transfer From Userspace
To:     Vinod Koul <vkoul@kernel.org>
Cc:     Federico Vaga <federico.vaga@cern.ch>,
        Dan Williams <dan.j.williams@intel.com>,
        dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Kumar, Sanjay K" <sanjay.k.kumar@intel.com>,
        "Luck, Tony" <tony.luck@intel.com>
References: <5614531.lOV4Wx5bFT@harkonnen>
 <fe199e18-be45-cadc-8bad-4a83ed87bfba@intel.com>
 <20200621072457.GA2324254@vkoul-mobl>
From:   Dave Jiang <dave.jiang@intel.com>
Message-ID: <581f1761-e582-c770-169a-ee3374baf25c@intel.com>
Date:   Wed, 24 Jun 2020 17:42:24 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20200621072457.GA2324254@vkoul-mobl>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org



On 6/21/2020 12:24 AM, Vinod Koul wrote:
> On 19-06-20, 16:31, Dave Jiang wrote:
>>
>>
>> On 6/19/2020 3:47 PM, Federico Vaga wrote:
>>> Hello,
>>>
>>> is there the possibility of using a DMA engine channel from userspace?
>>>
>>> Something like:
>>> - configure DMA using ioctl() (or whatever configuration mechanism)
>>> - read() or write() to trigger the transfer
>>>
>>
>> I may have supposedly promised Vinod to look into possibly providing
>> something like this in the future. But I have not gotten around to do that
>> yet. Currently, no such support.
> 
> And I do still have serious reservations about this topic :) Opening up
> userspace access to DMA does not sound very great from security point of
> view.

What about doing it with DMA engine that supports PASID? That way the user can 
really only trash its own address space and kernel is protected.


> 
> Federico, what use case do you have in mind?
> 
> We should keep in mind dmaengine is an in-kernel interface providing
> services to various subsystems, so you go thru the respective subsystem
> kernel interface (network, display, spi, audio etc..) which would in
> turn use dmaengine.
> 
