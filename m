Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C1FA620A502
	for <lists+dmaengine@lfdr.de>; Thu, 25 Jun 2020 20:31:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404154AbgFYSbd (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 25 Jun 2020 14:31:33 -0400
Received: from mga07.intel.com ([134.134.136.100]:22875 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2403987AbgFYSbd (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Thu, 25 Jun 2020 14:31:33 -0400
IronPort-SDR: HEoZPNrwPao21UOJynUmVElvGsIWIgW8Iy3hxVjaXVUkP+uM+CeGmHUiPt48wkONVKTjjxC3Nx
 uTVH8WG/dj0A==
X-IronPort-AV: E=McAfee;i="6000,8403,9663"; a="210114961"
X-IronPort-AV: E=Sophos;i="5.75,280,1589266800"; 
   d="scan'208";a="210114961"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jun 2020 11:31:30 -0700
IronPort-SDR: N1Pr7RhiT2oy2S4TNslCFDR4V/euo2peFHl8T1ULtTQ+KTjnmQiJmBLMJRYW4fF1xTcBVhxcG9
 EqEiXTPcJ9FQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,280,1589266800"; 
   d="scan'208";a="298216436"
Received: from djiang5-mobl1.amr.corp.intel.com (HELO [10.209.91.227]) ([10.209.91.227])
  by orsmga007.jf.intel.com with ESMTP; 25 Jun 2020 11:31:29 -0700
Subject: Re: [PATCH] dmaengine: check device and channel list for empty
To:     Vinod Koul <vkoul@kernel.org>
Cc:     dmaengine@vger.kernel.org, swathi.kovvuri@intel.com
References: <158957055210.11529.14023177009907426289.stgit@djiang5-desk3.ch.intel.com>
 <20200624072911.GL2324254@vkoul-mobl>
From:   Dave Jiang <dave.jiang@intel.com>
Message-ID: <c27b6058-a406-e6bd-55cd-15b67ab89f48@intel.com>
Date:   Thu, 25 Jun 2020 11:31:27 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20200624072911.GL2324254@vkoul-mobl>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org



On 6/24/2020 12:29 AM, Vinod Koul wrote:
> On 15-05-20, 12:22, Dave Jiang wrote:
>> Check dma device list and channel list for empty before iterate as the
>> iteration function assume the list to be not empty. With devices and
>> channels now being hot pluggable this is a condition that needs to be
>> checked. Otherwise it can cause the iterator to spin forever.
> 
> Can you rebase and resend, they dont apply on next

Hi Vinod. I'm trying to figure out how to do all the patches outstanding to 
avoid conflicts for you. Some will go to your fixes branch and some will go to 
the next branch. But next doesn't have the patches in fixes. So when you merge 
next later for 5.9, you are going to hit conflict from my patches that went in 
through the fixes branch for 5.8.

> 
>>
>> Fixes: e81274cd6b52 ("dmaengine: add support to dynamic register/unregister of channels")
> 
> Pls drop this empty line
>>
>> Reported-by: Swathi Kovvuri <swathi.kovvuri@intel.com>
>> Signed-off-by: Dave Jiang <dave.jiang@intel.com>
>> Tested-by: Swathi Kovvuri <swathi.kovvuri@intel.com>
