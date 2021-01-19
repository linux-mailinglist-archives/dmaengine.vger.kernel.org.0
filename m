Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CA07D2FC218
	for <lists+dmaengine@lfdr.de>; Tue, 19 Jan 2021 22:20:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730564AbhASSsQ (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 19 Jan 2021 13:48:16 -0500
Received: from mail.kernel.org ([198.145.29.99]:49914 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730161AbhASS23 (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Tue, 19 Jan 2021 13:28:29 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id A584A2339E;
        Tue, 19 Jan 2021 16:45:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1611074720;
        bh=hsbY9jVVjxPkTDo+83FR143J+Trhf5rfoVu0rt8eaRU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Hm2fl8vSTHyel68vvy54BFEYGnKKKObPD/GYX2P3MobIpRoPpKvqSzY1QvCiSboxN
         Atbr+nOgyM5E6Ak1Tn2YDiYEwZQ1elcqJ3vKfj87oTm5IWkPVZHivOHUyi0op2Ui3+
         rFv882mtsvqOkDXby9VRaoxXU+TPenjGAGlc+jwnQMbZ9nDbAfaAfIdBVXXiXgA8dm
         sEePE7usRv/pyhTYuqzHx8zbAPl3d0MNbnzq+l6MhwwjtK9C1DcZmf07jLgG/EOfbn
         IkNUlVH7H0QQrjmUZKLGXaB5LDyJXd3Fju03xRLM+dpaS4uxVMKMkNj5cqyqOrsRcy
         z/j89Bn7TZGxg==
Date:   Tue, 19 Jan 2021 22:15:11 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     mdalam@codeaurora.org
Cc:     corbet@lwn.net, agross@kernel.org, bjorn.andersson@linaro.org,
        dan.j.williams@intel.com, dmaengine@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, sricharan@codeaurora.org,
        mdalam=codeaurora.org@codeaurora.org
Subject: Re: [PATCH] dmaengine: qcom: bam_dma: Add LOCK and UNLOCK flag bit
 support
Message-ID: <20210119164511.GE2771@vkoul-mobl>
References: <1608215842-15381-1-git-send-email-mdalam@codeaurora.org>
 <20201221092355.GA3323@vkoul-mobl>
 <efcc74bbdf36b4ddbf764eb6b4ed99f2@codeaurora.org>
 <f7de0117c8ff2e61c09f58acdea0e5b0@codeaurora.org>
 <20210112101056.GI2771@vkoul-mobl>
 <e3cf7c4fc02c54d17fd2fd213f39005b@codeaurora.org>
 <20210115055806.GE2771@vkoul-mobl>
 <97ce29b230164a5848a38f6448d1be60@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <97ce29b230164a5848a38f6448d1be60@codeaurora.org>
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 18-01-21, 09:21, mdalam@codeaurora.org wrote:
> On 2021-01-15 11:28, Vinod Koul wrote:
> > On 14-01-21, 01:20, mdalam@codeaurora.org wrote:
> > > On 2021-01-12 15:40, Vinod Koul wrote:
> > > > On 12-01-21, 15:01, mdalam@codeaurora.org wrote:
> > > > > On 2020-12-21 23:03, mdalam@codeaurora.org wrote:
> > > > > > On 2020-12-21 14:53, Vinod Koul wrote:
> > > > > > > Hello,
> > > > > > >
> > > > > > > On 17-12-20, 20:07, Md Sadre Alam wrote:
> > > > > > > > This change will add support for LOCK & UNLOCK flag bit support
> > > > > > > > on CMD descriptor.
> > > > > > > >
> > > > > > > > If DMA_PREP_LOCK flag passed in prep_slave_sg then requester of this
> > > > > > > > transaction wanted to lock the DMA controller for this transaction so
> > > > > > > > BAM driver should set LOCK bit for the HW descriptor.
> > > > > > > >
> > > > > > > > If DMA_PREP_UNLOCK flag passed in prep_slave_sg then requester
> > > > > > > > of this
> > > > > > > > transaction wanted to unlock the DMA controller.so BAM driver
> > > > > > > > should set
> > > > > > > > UNLOCK bit for the HW descriptor.
> > > > > > >
> > > > > > > Can you explain why would we need to first lock and then unlock..? How
> > > > > > > would this be used in real world.
> > > > > > >
> > > > > > > I have read a bit of documentation but is unclear to me. Also should
> > > > > > > this be exposed as an API to users, sounds like internal to driver..?
> > > > > > >
> > > > > >
> > > > > > IPQ5018 SoC having only one Crypto Hardware Engine. This Crypto Hardware
> > > > > > Engine
> > > > > > will be shared between A53 core & ubi32 core. There is two separate
> > > > > > driver dedicated
> > > > > > to A53 core and ubi32 core. So to use Crypto Hardware Engine
> > > > > > parallelly for encryption/description
> > > > > > we need bam locking mechanism. if one driver will submit the request
> > > > > > for encryption/description
> > > > > > to Crypto then first it has to set LOCK flag bit on command descriptor
> > > > > > so that other pipes will
> > > > > > get locked.
> > > > > >
> > > > > > The Pipe Locking/Unlocking will be only on command-descriptor. Upon
> > > > > > encountering a command descriptor
> > > >
> > > > Can you explain what is a cmd descriptor?
> > > 
> > >   In BAM pipe descriptor structure there is a field called CMD
> > > (Command
> > > descriptor).
> > >   CMD allows the SW to create descriptors of type Command which does
> > > not
> > > generate any data transmissions
> > >   but configures registers in the Peripheral (write operations, and
> > > read
> > > registers operations ).
> > >   Using command descriptor enables the SW to queue new configurations
> > > between data transfers in advance.
> > 
> > What and when is the CMD descriptor used for..?
> 
>   CMD descriptor is mainly used for configuring controller register.
>   We can read/write controller register via BAM using CMD descriptor only.
>   CMD descriptor use command pipe for the transaction.

In which use cases would you need to issue cmd descriptors..?

> > 
> > > >
> > > > > > with LOCK bit set, The BAM will lock all other pipes not related to
> > > > > > the current pipe group, and keep
> > > > > > handling the current pipe only until it sees the UNLOCK set then it
> > > > > > will release all locked pipes.
> > > > > > locked pipe will not fetch new descriptors even if it got event/events
> > > > > > adding more descriptors for
> > > > > > this pipe (locked pipe).
> > > > > >
> > > > > > No need to expose as an API to user because its internal to driver, so
> > > > > > while preparing command descriptor
> > > > > > just we have to update the LOCK/UNLOCK flag.
> > > >
> > > > So IIUC, no api right? it would be internal to driver..?
> > > 
> > >   Yes its totally internal to deriver.
> > 
> > So no need for this patch then, right?
> 
>   This patch is needed , because if some hardware will shared between
>   multiple core like A53 and ubi32 for example. In IPQ5018 there is
>   only one crypto engine and this will be shared between A53 core and
>   ubi32 core and in A53 core & ubi32 core there are different drivers
>   is getting used. So if encryption/decryption request come at same
>   time from both the driver then things will get messed up. So here we
>   need LOCKING mechanism.  If first request is from A53 core driver
>   then this driver should lock all the pipes other than pipe dedicated
>   to A53 core. So while preparing CMD descriptor driver should used
>   this flag "DMA_PREP_LOCK", Since LOCK and UNLOCK flag bit we can set
>   only on CMD descriptor. Once request processed then driver will set
>   UNLOCK flag on CMD descriptor. Driver should use this flag
>   "DMA_PREP_UNLOCK" while preparing CMD descriptor. Same logic will be
>   apply for ubi32 core driver as well.

Why cant this be applied at driver level, based on txn being issued it
can lock issue the txn and then unlock when done. I am not convinced yet
that this needs to be exported to users and can be managed by dmaengine
driver.

Thanks
-- 
~Vinod
