Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4D8AE2F2EC5
	for <lists+dmaengine@lfdr.de>; Tue, 12 Jan 2021 13:14:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731104AbhALMOW (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 12 Jan 2021 07:14:22 -0500
Received: from mail.kernel.org ([198.145.29.99]:43304 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729496AbhALMOW (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Tue, 12 Jan 2021 07:14:22 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 176B023107;
        Tue, 12 Jan 2021 12:13:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1610453621;
        bh=wuHLfnLcvy3yXSEFwBhGu8I1LDuCTdYPKyRsQjTlsO8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=qjtfzhShrvDe0ED02eEQv5pC4BI3TK5/dpHuhCJMdpPZfa2hRgQmM+N4/rTJ7h4r7
         c9fdJNYjbuFxzMSxuH5/uThWwcv44nI/Q6NNFSKw4g45J74L4NeIEjkCRPmCfolwvy
         xiD8Rir7HGNjZmJrGg1vX4udcUHSaI5/OiaZI28crpc/ctBZkpZ0EfqrC/VxRRvtws
         tYVYXhesWUj1u6OvpFcUrCyMZOb55fiNarVW+FmW07vMyArvI9NFZu+tqsV3DNQl52
         jspwlmKANMmx/bbI8EzZtCMHxwSQmrQyp9GqLfnedvSChFrrSWRuILFSpz39N5uaW+
         syiI35+B5IpDA==
Date:   Tue, 12 Jan 2021 17:43:33 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Rob Herring <robh@kernel.org>
Cc:     EastL <EastL.Lee@mediatek.com>, Sean Wang <sean.wang@mediatek.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        "open list:DMA GENERIC OFFLOAD ENGINE SUBSYSTEM" 
        <dmaengine@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>, devicetree@vger.kernel.org,
        wsd_upstream <wsd_upstream@mediatek.com>,
        CC Hwang <cc.hwang@mediatek.com>
Subject: Re: [PATCH v8 1/4] dt-bindings: dmaengine: Add MediaTek
 Command-Queue DMA controller bindings
Message-ID: <20210112121333.GQ2771@vkoul-mobl>
References: <1608715847-28956-1-git-send-email-EastL.Lee@mediatek.com>
 <1608715847-28956-2-git-send-email-EastL.Lee@mediatek.com>
 <20210103165842.GA4024251@robh.at.kernel.org>
 <1609925140.5373.5.camel@mtkswgap22>
 <CAL_JsqLjgJUNJiE8uri9MKqTdik=7BBGP9bZSkD1mF+Sk3YfmQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAL_JsqLjgJUNJiE8uri9MKqTdik=7BBGP9bZSkD1mF+Sk3YfmQ@mail.gmail.com>
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 06-01-21, 16:53, Rob Herring wrote:

> > > > +  dma-channel-mask:
> > > > +    description:
> > > > +       For DMA capability, We will know the addressing capability of
> > > > +       MediaTek Command-Queue DMA controller through dma-channel-mask.
> > > > +      minimum: 1
> > > > +      maximum: 63
> > >
> > > Indentation is wrong here so this has no effect.
> > I'll fix it
> > >
> > > A mask of 63 is 6 channels...
> > In my opinion, kernel dma mask if for 32/64 bit capability...
> > If I don't set dma mask I will get fail on DMATEST.
> 
> As in the kernel's 'dma_mask'? That's something entirely different.
> The driver should set the mask to the max the device supports.
> Typically this is a 32-bit or 64-bit mask. The default is 32-bit. If
> the SoC has limitations in its buses, then you need to use
> 'dma-ranges' in DT which will in turn set the bus_dma_limit.

Correct, dma_mask tells dmatest the capability of the device and should
be set accordingly

dma-channel-mask defines the 'Bitmask of available DMA channels' and is
deined in dma-common.yaml

-- 
~Vinod
