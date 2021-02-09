Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C2D6631553B
	for <lists+dmaengine@lfdr.de>; Tue,  9 Feb 2021 18:39:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233312AbhBIRiP (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 9 Feb 2021 12:38:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233156AbhBIRgY (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 9 Feb 2021 12:36:24 -0500
Received: from mail-ot1-x335.google.com (mail-ot1-x335.google.com [IPv6:2607:f8b0:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F959C06121F
        for <dmaengine@vger.kernel.org>; Tue,  9 Feb 2021 09:35:33 -0800 (PST)
Received: by mail-ot1-x335.google.com with SMTP id q4so8572064otm.9
        for <dmaengine@vger.kernel.org>; Tue, 09 Feb 2021 09:35:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=2frGZv9MpWB5lKgC9m9OF/K9NIuBbPrL9HEmWyY/ZXM=;
        b=tFsX5hNXjRip+gDiFP26/8Y6n3Ujr7r2J/g7QT/wCIpPnNkhBWcIuMMko68VFPs8O7
         iUehhxmDexfrqbRcEDYUrFYueQ3iEEnEcn5g5wCSe/r6Sae6rlswtsB9Qemj344SRPKA
         Y4T6r3HBxIH30RVjEKh19VsL7m3QtCJDuXOXG3OcfCabtyrXYzjTWH6UTtb8X5cYm/SR
         8+uQ9XTY7JZWhs3A8WWeFlb4cnWsk3RrgdUyllSBTl/fi1hcHJ0EJ56fAfZbvvj0njOb
         ZxDWnVj0FBGoE7UW0RCt4KHX1toGfxIylClT41By93xJGg/wnooTHZqZPn8I6SmOrJ76
         ECPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=2frGZv9MpWB5lKgC9m9OF/K9NIuBbPrL9HEmWyY/ZXM=;
        b=IQ0A/xkR+C/7uuQfFZKDaxEutGzDKfpRnBNjVS2KLC7kVavPnGL8QRRyDIeCR5gSrr
         4Zr7szVDXddGtNZx8zNYUk/MwR4V9TB52JiZ1WWeYRCZQQcwoOeYBu4frngdv7DLSijd
         i7R6hTFf7UuI3wnd76+EBBgRfG8N1OfJkYW72d+T4xgrSUSisTyGriTM0beNCwesZsaf
         Zfzk3nlHQv35FaLom8DF/Xd5mfHl79sNwDCKjsw5cj3GwZWDpBXA2YV7RJxBoimip+M+
         xtnMKW4Nw7CGBTveItxTURx/sCpSmYReUcaSTSOg3AGhfH93suOjtBTViSMHqmXmnrAc
         /aQQ==
X-Gm-Message-State: AOAM532vJSlv1tOopAinVqAq/XLEX6P5anhwDePiswmeMakKjd7VllUI
        qDu4WSwDoOHF2OdXfyuWcXfvEw==
X-Google-Smtp-Source: ABdhPJz/03ffuC6poRQA2jg3nh3UAaz74Jb0+oLSH1BzKUkjmuUdZcGJUXR4cbsa8XJhGLqFuOIeNQ==
X-Received: by 2002:a05:6830:1342:: with SMTP id r2mr17237593otq.216.1612892132157;
        Tue, 09 Feb 2021 09:35:32 -0800 (PST)
Received: from builder.lan (104-57-184-186.lightspeed.austtx.sbcglobal.net. [104.57.184.186])
        by smtp.gmail.com with ESMTPSA id x187sm4489883oig.3.2021.02.09.09.35.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Feb 2021 09:35:31 -0800 (PST)
Date:   Tue, 9 Feb 2021 11:35:29 -0600
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     mdalam@codeaurora.org
Cc:     Vinod Koul <vkoul@kernel.org>, corbet@lwn.net, agross@kernel.org,
        dan.j.williams@intel.com, dmaengine@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, sricharan@codeaurora.org,
        mdalam=codeaurora.org@codeaurora.org
Subject: Re: [PATCH] dmaengine: qcom: bam_dma: Add LOCK and UNLOCK flag bit
 support
Message-ID: <YCLH4ZOMjLbywl4u@builder.lan>
References: <20210112101056.GI2771@vkoul-mobl>
 <e3cf7c4fc02c54d17fd2fd213f39005b@codeaurora.org>
 <20210115055806.GE2771@vkoul-mobl>
 <97ce29b230164a5848a38f6448d1be60@codeaurora.org>
 <20210119164511.GE2771@vkoul-mobl>
 <534308caab7c18730ad0cc25248d116f@codeaurora.org>
 <20210201060508.GK2771@vkoul-mobl>
 <9d33d73682f24d92338757e1823ccd88@codeaurora.org>
 <20210201064314.GM2771@vkoul-mobl>
 <73c871d3d674607fafc7b79e602ec587@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <73c871d3d674607fafc7b79e602ec587@codeaurora.org>
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Mon 01 Feb 09:50 CST 2021, mdalam@codeaurora.org wrote:

> On 2021-02-01 12:13, Vinod Koul wrote:
> > On 01-02-21, 11:52, mdalam@codeaurora.org wrote:
> > > On 2021-02-01 11:35, Vinod Koul wrote:
> > > > On 27-01-21, 23:56, mdalam@codeaurora.org wrote:
> > 
> > > > >   The actual LOCK/UNLOCK flag should be set on hardware command
> > > > > descriptor.
> > > > >   so this flag setting should be done in DMA engine driver. The user
> > > > > of the
> > > > > DMA
> > > > >   driver like (in case of IPQ5018) Crypto can use flag
> > > > > "DMA_PREP_LOCK" &
> > > > > "DMA_PREP_UNLOCK"
> > > > >   while preparing CMD descriptor before submitting to the DMA
> > > > > engine. In DMA
> > > > > engine driver
> > > > >   we are checking these flasgs on CMD descriptor and setting actual
> > > > > LOCK/UNLOCK flag on hardware
> > > > >   descriptor.
> > > >
> > > >
> > > > I am not sure I comprehend this yet.. when is that we would need to do
> > > > this... is this for each txn submitted to dmaengine.. or something
> > > > else..
> > > 
> > >  Its not for each transaction submitted to dmaengine. We have to set
> > > this
> > > only
> > >  once on CMD descriptor. So when A53 crypto driver need to change
> > > the crypto
> > > configuration
> > >  then first it will lock the all other pipes using setting the LOCK
> > > flag bit
> > > on CMD
> > >  descriptor and then it can start the transaction , on data
> > > descriptor this
> > > flag will
> > >  not get set once all transaction will be completed the A53 crypto
> > > driver
> > > release the lock on
> > >  all other pipes using UNLOCK flag on CMD descriptor. So LOCK/UNLOCK
> > > will be
> > > only once and not for
> > >  the each transaction.
> > 
> > Okay so why cant the bam driver check cmd descriptor and do lock/unlock
> > as below, why do we need users to do this.
> > 
> >         if (flags & DMA_PREP_CMD) {
> >                 do_lock_bam();
> 
>  User will not decide to do this LOCK/UNLOCK mechanism. It depends on
>  use case.  This LOCK/UNLOCK mechanism not required always. It needs
>  only when hardware will be shared between different core with
>  different driver.

So you have a single piece of crypto hardware and you're using the BAM's
LOCK/UNLOCK feature to implement a "mutex" on a particular BAM channel?

>  The LOCK/UNLOCK flags provides SW to enter ordering between pipes
> execution.
>  (Generally, the BAM pipes are total independent from each other and work in
> parallel manner).
>  This LOCK/UNLOCK flags are part of actual pipe hardware descriptor.
> 
>  Pipe descriptor having the following flags:
>  INT : Interrupt
>  EOT: End of transfer
>  EOB: End of block
>  NWD: Notify when done
>  CMD: Command
>  LOCK: Lock
>  UNLOCK: Unlock
>  etc.
> 
>  Here the BAM driver is common driver for (QPIC, Crypto, QUP etc. in
> IPQ5018)
>  So here only Crypto will be shared b/w multiple cores so For crypto request
> only the LOCK/UNLOCK
>  mechanism required.
>  For other request like for QPIC driver, QUPT driver etc. its not required.
> So Crypto driver has to raise the flag for
>  LOCK/UNLOCK while preparing CMD descriptor. The actual locking will happen
> in BAM driver only using condition
>  if (flags & DMA_PREP_CMD) {
>      if (flags & DMA_PREP_LOCK)
>         desc->flags |= cpu_to_le16(DESC_FLAG_LOCK);
>  }
> 
>  So Crypto driver should set this flag DMA_PREP_LOCK while preparing CMD
> descriptor.
>  So LOCK should be set on actual hardware pipe descriptor with descriptor
> type CMD.
> 

It sounds fairly clear that the actual descriptor modification must
happen in the BAM driver, but the question in my mind is how this is
exposed to the DMAengine clients (e.g. crypto, QPIC etc).

What is the life span of the locked state? Do you always provide a
series of descriptors that starts with a LOCK and ends with an UNLOCK?
Or do you envision that the crypto driver provides a LOCK descriptor and
at some later point provides a UNLOCK descriptor?


Finally, this patch just adds the BAM part of things, where is the patch
that actually makes use of this feature?

Regards,
Bjorn

> > 
> > The point here is that this seems to be internal to dma and should be
> > handled by dma driver.
> > 
>   This LOCK/UNLOK flags are part of actual hardware descriptor so this
> should be handled by BAM driver only.
>   If we set condition like this
>   if (flags & DMA_PREP_CMD) {
>                 do_lock_bam();
>   Then LOCK/UNLOCK will be applied for all the CMD descriptor including
> (QPIC driver, QUP driver , Crypto driver etc.).
>   So this is not our intension. So we need to set this LOCK/UNLOCK only for
> the drivers it needs. So Crypto driver needs
>   locking mechanism so we will set LOCK/UNLOCK flag on Crypto driver request
> only for other driver request like QPIC driver,
>   QUP driver will not set this.
> 
> > Also if we do this, it needs to be done for specific platforms..
> > 
> 
> 
> 
> 
> 
> 
> 
> > Thanks
