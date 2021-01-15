Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4DD9B2F72A3
	for <lists+dmaengine@lfdr.de>; Fri, 15 Jan 2021 06:59:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728269AbhAOF6v (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 15 Jan 2021 00:58:51 -0500
Received: from mail.kernel.org ([198.145.29.99]:49936 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726019AbhAOF6u (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Fri, 15 Jan 2021 00:58:50 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 66736239EF;
        Fri, 15 Jan 2021 05:58:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1610690290;
        bh=A2xQvZI3cYjFP3+C40z6oPKeq/38VezRg4M7YK6TvpI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ibY2R7ceYe8BqE2hj3mA8qlr2b7m8kLBYZN94Gn+IyG1ykTEfHq32oi7J3Hv7lrOc
         1PuWhBRo9FLeuYe5eoX40NDoJvHMIVBNgH9cJ+1rQHwvkMk1/6pjNisMlHVLBPowp1
         H54rJcRkH44Wwp1kEtO7qae8Q/HYEGhCdoYStdStZHF/cCDRZmvSMifAhAZMU6YJie
         E+S5SkCCfwa40egM9HuwiQz5y+YBc8/z79BxZFTplR45BukmDpJns7WyqxHpFhWN9O
         Q48TNyn+4wIijVkyGSwc+e6asL3nIINHvbhk+MSOoTs62AuaKwTBsD4srhbTmi9Y/M
         9iL3BwSb7XH0w==
Date:   Fri, 15 Jan 2021 11:28:06 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     mdalam@codeaurora.org
Cc:     corbet@lwn.net, agross@kernel.org, bjorn.andersson@linaro.org,
        dan.j.williams@intel.com, dmaengine@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, sricharan@codeaurora.org,
        mdalam=codeaurora.org@codeaurora.org
Subject: Re: [PATCH] dmaengine: qcom: bam_dma: Add LOCK and UNLOCK flag bit
 support
Message-ID: <20210115055806.GE2771@vkoul-mobl>
References: <1608215842-15381-1-git-send-email-mdalam@codeaurora.org>
 <20201221092355.GA3323@vkoul-mobl>
 <efcc74bbdf36b4ddbf764eb6b4ed99f2@codeaurora.org>
 <f7de0117c8ff2e61c09f58acdea0e5b0@codeaurora.org>
 <20210112101056.GI2771@vkoul-mobl>
 <e3cf7c4fc02c54d17fd2fd213f39005b@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e3cf7c4fc02c54d17fd2fd213f39005b@codeaurora.org>
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 14-01-21, 01:20, mdalam@codeaurora.org wrote:
> On 2021-01-12 15:40, Vinod Koul wrote:
> > On 12-01-21, 15:01, mdalam@codeaurora.org wrote:
> > > On 2020-12-21 23:03, mdalam@codeaurora.org wrote:
> > > > On 2020-12-21 14:53, Vinod Koul wrote:
> > > > > Hello,
> > > > >
> > > > > On 17-12-20, 20:07, Md Sadre Alam wrote:
> > > > > > This change will add support for LOCK & UNLOCK flag bit support
> > > > > > on CMD descriptor.
> > > > > >
> > > > > > If DMA_PREP_LOCK flag passed in prep_slave_sg then requester of this
> > > > > > transaction wanted to lock the DMA controller for this transaction so
> > > > > > BAM driver should set LOCK bit for the HW descriptor.
> > > > > >
> > > > > > If DMA_PREP_UNLOCK flag passed in prep_slave_sg then requester
> > > > > > of this
> > > > > > transaction wanted to unlock the DMA controller.so BAM driver
> > > > > > should set
> > > > > > UNLOCK bit for the HW descriptor.
> > > > >
> > > > > Can you explain why would we need to first lock and then unlock..? How
> > > > > would this be used in real world.
> > > > >
> > > > > I have read a bit of documentation but is unclear to me. Also should
> > > > > this be exposed as an API to users, sounds like internal to driver..?
> > > > >
> > > >
> > > > IPQ5018 SoC having only one Crypto Hardware Engine. This Crypto Hardware
> > > > Engine
> > > > will be shared between A53 core & ubi32 core. There is two separate
> > > > driver dedicated
> > > > to A53 core and ubi32 core. So to use Crypto Hardware Engine
> > > > parallelly for encryption/description
> > > > we need bam locking mechanism. if one driver will submit the request
> > > > for encryption/description
> > > > to Crypto then first it has to set LOCK flag bit on command descriptor
> > > > so that other pipes will
> > > > get locked.
> > > >
> > > > The Pipe Locking/Unlocking will be only on command-descriptor. Upon
> > > > encountering a command descriptor
> > 
> > Can you explain what is a cmd descriptor?
> 
>   In BAM pipe descriptor structure there is a field called CMD (Command
> descriptor).
>   CMD allows the SW to create descriptors of type Command which does not
> generate any data transmissions
>   but configures registers in the Peripheral (write operations, and read
> registers operations ).
>   Using command descriptor enables the SW to queue new configurations
> between data transfers in advance.

What and when is the CMD descriptor used for..?

> > 
> > > > with LOCK bit set, The BAM will lock all other pipes not related to
> > > > the current pipe group, and keep
> > > > handling the current pipe only until it sees the UNLOCK set then it
> > > > will release all locked pipes.
> > > > locked pipe will not fetch new descriptors even if it got event/events
> > > > adding more descriptors for
> > > > this pipe (locked pipe).
> > > >
> > > > No need to expose as an API to user because its internal to driver, so
> > > > while preparing command descriptor
> > > > just we have to update the LOCK/UNLOCK flag.
> > 
> > So IIUC, no api right? it would be internal to driver..?
> 
>   Yes its totally internal to deriver.

So no need for this patch then, right?

-- 
~Vinod
