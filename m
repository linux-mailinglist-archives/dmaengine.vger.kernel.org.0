Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 424493CC3E1
	for <lists+dmaengine@lfdr.de>; Sat, 17 Jul 2021 16:48:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234303AbhGQOvm (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Sat, 17 Jul 2021 10:51:42 -0400
Received: from phobos.denx.de ([85.214.62.61]:48804 "EHLO phobos.denx.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234234AbhGQOvm (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Sat, 17 Jul 2021 10:51:42 -0400
Received: from [IPv6:::1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: marex@denx.de)
        by phobos.denx.de (Postfix) with ESMTPSA id 60F8B80C68;
        Sat, 17 Jul 2021 16:48:39 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
        s=phobos-20191101; t=1626533324;
        bh=HrYp+lDZ9IBbPadiUFrdoTcHaCH/AdtmFONkS2XHVwc=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=WwbSF621mthTB3+1Rc7cabqDIa2Fg+B+356AwMInO9vxxWoPaKFYmPc2p1EWUaQ6F
         bzK4TUBoDhFGTLf5aH3KVpJQO6C5jJK6ZJwx6YxOMuqzQfBFYfv/3fFWLUZb8Y4Us2
         fMnTKdKHW/vR73X7IAX+wr6pmG/85RFPbjXLq6J19WOv6JdmQyQ17ZCui+QtmzR9Cj
         TXC1OhKRLoF2DzjsoRH792J7nN0fGUjSKpkYbDFIiUZ6dU0VrY4mCfx5W1TUDcaSCI
         pPbh2T6hXqbRnx59W9aTcwRrra/lqCa+fPS2lHTnThyxxWaqbrWN61lTE4WHDrS3VE
         y1pDQIpPrUv9A==
Subject: Re: [PATCH] dmaengine: xilinx: Add empty device_config function
To:     Vinod Koul <vkoul@kernel.org>
Cc:     dmaengine@vger.kernel.org, Akinobu Mita <akinobu.mita@gmail.com>,
        Kedareswara rao Appana <appana.durga.rao@xilinx.com>,
        Michal Simek <monstr@monstr.eu>,
        Vinod Koul <vinod.koul@intel.com>
References: <20210716182241.218705-1-marex@denx.de> <YPLAs49jy3OGF1aT@matsya>
 <d0009412-abc1-68cb-e7c4-1a11d6ea0fe4@denx.de> <YPLqisxSMe6wzQuk@matsya>
From:   Marek Vasut <marex@denx.de>
Message-ID: <0aa86cfb-09e7-df99-1a28-dd9086d64058@denx.de>
Date:   Sat, 17 Jul 2021 16:48:38 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <YPLqisxSMe6wzQuk@matsya>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Virus-Scanned: clamav-milter 0.103.2 at phobos.denx.de
X-Virus-Status: Clean
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 7/17/21 4:34 PM, Vinod Koul wrote:
> On 17-07-21, 14:01, Marek Vasut wrote:
>> On 7/17/21 1:36 PM, Vinod Koul wrote:
>>> On 16-07-21, 20:22, Marek Vasut wrote:
>>>> Various DMA users call the dmaengine_slave_config() and expect it to
>>>> succeed, but that can only succeed if .device_config is implemented.
>>>> Add empty device_config function rather than patching all the places
>>>> which use dmaengine_slave_config().
>>>
>>> .device_config is optional, Yes the dmaengine_slave_config() will check
>>> and return error...
>>>
>>> I think it would make sense to handle this in caller... (ignore
>>> ENOSYS..) rather than add a dummy one
>>
>> That's what I was trying to avoid -- patching all the places in kernel which
>> might fail. Why handle it in caller ?
> 
> And how many places would that be..? The xilinx driver using xilinx
> dma right>

git grep indicates around 170 matches on dmaengine_slave_config. In my 
case, it is generic PCM DMA in sound/soc/soc-generic-dmaengine-pcm.c .

>>>> Signed-off-by: Marek Vasut <marex@denx.de>
>>>> Cc: Akinobu Mita <akinobu.mita@gmail.com>
>>>> Cc: Kedareswara rao Appana <appana.durga.rao@xilinx.com>
>>>> Cc: Michal Simek <monstr@monstr.eu>
>>>> Cc: Vinod Koul <vinod.koul@intel.com>
>>>
>>> ummm..? you really need to update this :)
>>
>> I had the patch around for a while indeed, it fell through the cracks.
> 
> This has to be more than 3 yrs old then!

Four
