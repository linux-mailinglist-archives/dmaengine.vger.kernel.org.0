Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9AF033CC319
	for <lists+dmaengine@lfdr.de>; Sat, 17 Jul 2021 14:12:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234852AbhGQMOs (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Sat, 17 Jul 2021 08:14:48 -0400
Received: from phobos.denx.de ([85.214.62.61]:38586 "EHLO phobos.denx.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233723AbhGQMOa (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Sat, 17 Jul 2021 08:14:30 -0400
Received: from [IPv6:::1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: marex@denx.de)
        by phobos.denx.de (Postfix) with ESMTPSA id 73818800D0;
        Sat, 17 Jul 2021 14:11:30 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
        s=phobos-20191101; t=1626523890;
        bh=iKswL++90DVxozQtFTUc+lTwbmLWD8sTI01RiimFHtE=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=bSpkUSVeVaulk8YOhmnWa4WWI7/KBnarODyEkgHts8GpqOOA1Sg8OeKu7K4JoNLr6
         EutsgKLLpf2X0+J3sPYzy2ohg39ZM/ANPyrH8YECgZ8wUbnaij/QqnyzQ2WltIzgFy
         7HenlXNHUawpyGN7bzJfbEdj2bp3zwzFSy4UckrX2X/nAxEamjLMgKaMiJz6U6cEE7
         kKl+u4WdKJF/1LDPFgOCYWHQvVCJt7K8S9e2cKnj2bX+V/XCzSd7rNzooS1w6gI7Yo
         wlgCVd6qSSHCHQOV2eL67iaMRTF6oXei13gyywCR+2jePImeR3g23wGHq3dd686isQ
         BulldRikvfKnA==
Subject: Re: [PATCH] dmaengine: xilinx: Add empty device_config function
To:     Vinod Koul <vkoul@kernel.org>
Cc:     dmaengine@vger.kernel.org, Akinobu Mita <akinobu.mita@gmail.com>,
        Kedareswara rao Appana <appana.durga.rao@xilinx.com>,
        Michal Simek <monstr@monstr.eu>,
        Vinod Koul <vinod.koul@intel.com>
References: <20210716182241.218705-1-marex@denx.de> <YPLAs49jy3OGF1aT@matsya>
From:   Marek Vasut <marex@denx.de>
Message-ID: <d0009412-abc1-68cb-e7c4-1a11d6ea0fe4@denx.de>
Date:   Sat, 17 Jul 2021 14:01:41 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <YPLAs49jy3OGF1aT@matsya>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Virus-Scanned: clamav-milter 0.103.2 at phobos.denx.de
X-Virus-Status: Clean
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 7/17/21 1:36 PM, Vinod Koul wrote:
> On 16-07-21, 20:22, Marek Vasut wrote:
>> Various DMA users call the dmaengine_slave_config() and expect it to
>> succeed, but that can only succeed if .device_config is implemented.
>> Add empty device_config function rather than patching all the places
>> which use dmaengine_slave_config().
> 
> .device_config is optional, Yes the dmaengine_slave_config() will check
> and return error...
> 
> I think it would make sense to handle this in caller... (ignore
> ENOSYS..) rather than add a dummy one

That's what I was trying to avoid -- patching all the places in kernel 
which might fail. Why handle it in caller ?

>> Signed-off-by: Marek Vasut <marex@denx.de>
>> Cc: Akinobu Mita <akinobu.mita@gmail.com>
>> Cc: Kedareswara rao Appana <appana.durga.rao@xilinx.com>
>> Cc: Michal Simek <monstr@monstr.eu>
>> Cc: Vinod Koul <vinod.koul@intel.com>
> 
> ummm..? you really need to update this :)

I had the patch around for a while indeed, it fell through the cracks.
