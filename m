Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0FB782603F0
	for <lists+dmaengine@lfdr.de>; Mon,  7 Sep 2020 19:56:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730123AbgIGR4y (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 7 Sep 2020 13:56:54 -0400
Received: from foss.arm.com ([217.140.110.172]:33116 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728622AbgIGLUG (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Mon, 7 Sep 2020 07:20:06 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A055712FC;
        Mon,  7 Sep 2020 04:02:57 -0700 (PDT)
Received: from [10.57.13.150] (unknown [10.57.13.150])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 7EAD53F66E;
        Mon,  7 Sep 2020 04:02:56 -0700 (PDT)
Subject: Re: 6b41030fdc790 broke dmatest badly
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        dmaengine@vger.kernel.org
Cc:     Vinod Koul <vkoul@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Peter Ujfalusi <peter.ujfalusi@ti.com>
References: <20200904173401.GH1891694@smile.fi.intel.com>
From:   Vladimir Murzin <vladimir.murzin@arm.com>
Message-ID: <d95f1b54-2a62-7b79-c53c-c8179324e935@arm.com>
Date:   Mon, 7 Sep 2020 12:03:26 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20200904173401.GH1891694@smile.fi.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Hi,

On 9/4/20 6:34 PM, Andy Shevchenko wrote:
> It becomes a bit annoying to fix dmatest after almost each release.
> The commit 6b41030fdc79 ("dmaengine: dmatest: Restore default for channel")
> broke my use case when I tried to start busy channel.
> 
> So, before this patch
> 	...
> 	echo "busy_chan" > channel
> 	echo 1 > run
> 	sh: write error: Device or resource busy
> 	[ 1013.868313] dmatest: Could not start test, no channels configured
> 
> After I have got it run on *ALL* available channels.

Is not that controlled with max_channels? 

> 
> dmatest compiled as a module.
> 
> Fix this ASAP, otherwise I will send revert of this and followed up patch next
> week.
>

I don't quite get it, you are sending revert and then a fix rather then helping
with a fix? What is reason for such extreme (and non-cooperative) flow?

P.S.
Unfortunately, I do not have access to hardware to run reproducer.

Cheers
Vladimir
