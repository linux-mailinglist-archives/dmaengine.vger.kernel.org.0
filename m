Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6089730A23E
	for <lists+dmaengine@lfdr.de>; Mon,  1 Feb 2021 07:51:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229557AbhBAGus (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 1 Feb 2021 01:50:48 -0500
Received: from mail.kernel.org ([198.145.29.99]:33434 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232172AbhBAGoC (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Mon, 1 Feb 2021 01:44:02 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 9EC9464E11;
        Mon,  1 Feb 2021 06:43:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1612161799;
        bh=VWrcrRLqYlZ43SypcWSC4Ova6HDDDLuVvN9BU0monik=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=aoy3nVlkmtWO6sr8qsxlqIrnH0enDrOBLP0XdomN8RSDqY0LPrQv4bUbRE4vtm+Sw
         GKWz4mxX6zeIN1kOmkUcHwBhPuUX8tR/iCdC7boCQlH0eH+o1AqJUmIOevgBlGT6+h
         Sx7j/lgSmF+gQx7FyIx2AbI5+TewLUGfsNDJS5fpo8WhVULrZg3WoiLg/SJmscFbWh
         w91KGEXCDSlRdktdaVnWmp6WmCjhSEpBV1zoB3DZtTNIR1ovEZ0i7lKxizoYDCjMyR
         DgNig9yf3sMfwW0dRjYYxYv4qC2xpkd0+iVD24ZMtuAJrmLrvkgyS+1DstZH3TLRHT
         kHpbI1fFmLv8w==
Date:   Mon, 1 Feb 2021 12:13:14 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     mdalam@codeaurora.org
Cc:     corbet@lwn.net, agross@kernel.org, bjorn.andersson@linaro.org,
        dan.j.williams@intel.com, dmaengine@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, sricharan@codeaurora.org,
        mdalam=codeaurora.org@codeaurora.org
Subject: Re: [PATCH] dmaengine: qcom: bam_dma: Add LOCK and UNLOCK flag bit
 support
Message-ID: <20210201064314.GM2771@vkoul-mobl>
References: <efcc74bbdf36b4ddbf764eb6b4ed99f2@codeaurora.org>
 <f7de0117c8ff2e61c09f58acdea0e5b0@codeaurora.org>
 <20210112101056.GI2771@vkoul-mobl>
 <e3cf7c4fc02c54d17fd2fd213f39005b@codeaurora.org>
 <20210115055806.GE2771@vkoul-mobl>
 <97ce29b230164a5848a38f6448d1be60@codeaurora.org>
 <20210119164511.GE2771@vkoul-mobl>
 <534308caab7c18730ad0cc25248d116f@codeaurora.org>
 <20210201060508.GK2771@vkoul-mobl>
 <9d33d73682f24d92338757e1823ccd88@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9d33d73682f24d92338757e1823ccd88@codeaurora.org>
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 01-02-21, 11:52, mdalam@codeaurora.org wrote:
> On 2021-02-01 11:35, Vinod Koul wrote:
> > On 27-01-21, 23:56, mdalam@codeaurora.org wrote:

> > >   The actual LOCK/UNLOCK flag should be set on hardware command
> > > descriptor.
> > >   so this flag setting should be done in DMA engine driver. The user
> > > of the
> > > DMA
> > >   driver like (in case of IPQ5018) Crypto can use flag
> > > "DMA_PREP_LOCK" &
> > > "DMA_PREP_UNLOCK"
> > >   while preparing CMD descriptor before submitting to the DMA
> > > engine. In DMA
> > > engine driver
> > >   we are checking these flasgs on CMD descriptor and setting actual
> > > LOCK/UNLOCK flag on hardware
> > >   descriptor.
> > 
> > 
> > I am not sure I comprehend this yet.. when is that we would need to do
> > this... is this for each txn submitted to dmaengine.. or something
> > else..
> 
>  Its not for each transaction submitted to dmaengine. We have to set this
> only
>  once on CMD descriptor. So when A53 crypto driver need to change the crypto
> configuration
>  then first it will lock the all other pipes using setting the LOCK flag bit
> on CMD
>  descriptor and then it can start the transaction , on data descriptor this
> flag will
>  not get set once all transaction will be completed the A53 crypto driver
> release the lock on
>  all other pipes using UNLOCK flag on CMD descriptor. So LOCK/UNLOCK will be
> only once and not for
>  the each transaction.

Okay so why cant the bam driver check cmd descriptor and do lock/unlock
as below, why do we need users to do this.

        if (flags & DMA_PREP_CMD) {
                do_lock_bam();

The point here is that this seems to be internal to dma and should be
handled by dma driver.

Also if we do this, it needs to be done for specific platforms..

Thanks

-- 
~Vinod
