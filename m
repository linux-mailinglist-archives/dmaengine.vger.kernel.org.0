Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DF8261BD75E
	for <lists+dmaengine@lfdr.de>; Wed, 29 Apr 2020 10:36:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726571AbgD2IgE (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 29 Apr 2020 04:36:04 -0400
Received: from mx2.suse.de ([195.135.220.15]:34046 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726543AbgD2IgE (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Wed, 29 Apr 2020 04:36:04 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id D9C5AABCF;
        Wed, 29 Apr 2020 08:36:01 +0000 (UTC)
Subject: Re: [PATCH 1/1] dma: actions: Fix lockdep splat for owl-dma
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Cristian Ciocaltea <cristian.ciocaltea@gmail.com>
Cc:     Vinod Koul <vkoul@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        dmaengine@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-actions@lists.infradead.org
References: <7d503c3dcac2b3ef29d4122a74eacfce142a8f98.1588069418.git.cristian.ciocaltea@gmail.com>
 <20200428164921.GC5259@Mani-XPS-13-9360> <20200428181115.GB26885@BV030612LT>
 <20200428181803.GD5259@Mani-XPS-13-9360>
From:   =?UTF-8?Q?Andreas_F=c3=a4rber?= <afaerber@suse.de>
Organization: SUSE Software Solutions Germany GmbH
Message-ID: <a70a2352-7b22-6b85-848b-94d9ee17c022@suse.de>
Date:   Wed, 29 Apr 2020 10:36:01 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200428181803.GD5259@Mani-XPS-13-9360>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Am 28.04.20 um 20:18 schrieb Manivannan Sadhasivam:
> On Tue, Apr 28, 2020 at 09:11:15PM +0300, Cristian Ciocaltea wrote:
>> On Tue, Apr 28, 2020 at 10:19:21PM +0530, Manivannan Sadhasivam wrote:
>>> On Tue, Apr 28, 2020 at 01:56:12PM +0300, Cristian Ciocaltea wrote:
>>>> When the kernel is build with lockdep support and the owl-dma driver is
>>>> used, the following message is shown:
[...]
>>>> The required fix is to use spin_lock_init() on the pchan lock before
>>>> attempting to call any spin_lock_irqsave() in owl_dma_get_pchan().
>>>
>>> Right, this is a bug. But while looking at the code now, I feel that we don't
>>> need 'pchan->lock'. The idea was to protect 'pchan->vchan', but I think
>>> 'od->lock' is the better candidate for that since it already protects it in
>>> 'owl_dma_terminate_pchan'.
>>>
>>> So I'd be happy if you remove the lock from 'pchan' and just directly use the
>>> one in 'od'.
>>>
>>> Out of curiosity, on which platform you're testing this?
>>
>> Totally agree, I will send a new patch revision as soon as I do some
>> more testing.
> 
> Coo[l], thanks!
> 
>> I'm currently experimenting on an Actions S500 based board (Roseapple Pi)
>> trying to extend, if possible, the existing mainline support for those
>> SoCs.
> 
> Awesome! It's great to see that Actions platform is seeing some attention
> these days :)
> 
>> I don't have much progress so far, since I started quite recently
>> and I also lack experience in the kernel development area, but I do my
>> best to come back with more patches once I get a consistent functionality.
> 
> No worries. Feel free to reach out to me if you have any questions. There is
> a lot of work to do and for sure it will be a good learning curve.
> 
> We do have an IRC channel (##linux-actions) for quick discussions. Fee[l] free
> to join!

Please also CC the linux-actions mailing list on any patches:

https://lists.infradead.org/mailman/listinfo/linux-actions

Mani, do you have a 5.7-rc1 tree set up or should I queue patches this 
round? It still seems missing in MAINTAINERS, and then there's Matheus' 
patches in review.

Thanks,
Andreas

-- 
SUSE Software Solutions Germany GmbH
Maxfeldstr. 5, 90409 Nürnberg, Germany
GF: Felix Imendörffer
HRB 36809 (AG Nürnberg)
