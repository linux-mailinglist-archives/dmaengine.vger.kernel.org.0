Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5ADBB43DBC7
	for <lists+dmaengine@lfdr.de>; Thu, 28 Oct 2021 09:15:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229881AbhJ1HRx (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 28 Oct 2021 03:17:53 -0400
Received: from mo4-p01-ob.smtp.rzone.de ([85.215.255.52]:17319 "EHLO
        mo4-p01-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229887AbhJ1HRw (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 28 Oct 2021 03:17:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1635405322;
    s=strato-dkim-0002; d=gerhold.net;
    h=In-Reply-To:References:Message-ID:Subject:Cc:To:From:Date:Cc:Date:
    From:Subject:Sender;
    bh=f2bKLmpMEPwYsfINUl0KzXLR9UAhc4TXoM5ZG4bME2A=;
    b=oaE3hHtnQzgulJTpHvs6GNEdmIG6FV3t+WBxuHuffkkR0VgzCNG2WZRXxevqswwaFO
    S6IWcvbCTPQ2UkzssrFts9yINC1GIBHW1Vai/ARJv6kMbsw0v9TiUmREBLANpiZXYmQc
    gDcOq6naxCCSPCGHVpvHSWyQF9vGppktCOJCf/dMQPEPx7/afIDOv/KeANK0ezP7Jycv
    poVjjphWWi9GMbpAibCe0h9CCzU6qqJFhvdlVA2nEC//X5vMschZwW+608AaVcJTfxd1
    2Wtj78P6aVndVixy2cRLkaHqYuIvT2h25g8WHosc/XrXq099KsFhOgwZ9r0eA+9NIE3j
    pA/A==
Authentication-Results: strato.com;
    dkim=none
X-RZG-AUTH: ":P3gBZUipdd93FF5ZZvYFPugejmSTVR2nRPhVOQ/OcYgojyw4j34+u267FZF9PwpcNKLUrKw7/aY="
X-RZG-CLASS-ID: mo00
Received: from gerhold.net
    by smtp.strato.de (RZmta 47.34.1 AUTH)
    with ESMTPSA id 207811x9S7FL9NZ
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Thu, 28 Oct 2021 09:15:21 +0200 (CEST)
Date:   Thu, 28 Oct 2021 09:15:14 +0200
From:   Stephan Gerhold <stephan@gerhold.net>
To:     Bhupesh Sharma <bhupesh.sharma@linaro.org>
Cc:     Vinod Koul <vkoul@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        MSM <linux-arm-msm@vger.kernel.org>, dmaengine@vger.kernel.org,
        devicetree <devicetree@vger.kernel.org>,
        ~postmarketos/upstreaming@lists.sr.ht
Subject: Re: [PATCH v3 0/2] dmaengine: qcom: bam_dma: Add "powered remotely"
 mode for BAM-DMUX
Message-ID: <YXpOAlTO80A4tZcT@gerhold.net>
References: <20211018102421.19848-1-stephan@gerhold.net>
 <YXZFGFH5lxDKeenw@matsya>
 <YXZL655lHukjar/x@gerhold.net>
 <CAH=2NtzfTqkwZum3owipC0kHvX2BMRssqRFmFAXPFkXK_SmN1w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAH=2NtzfTqkwZum3owipC0kHvX2BMRssqRFmFAXPFkXK_SmN1w@mail.gmail.com>
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Hi Bhupesh,

On Thu, Oct 28, 2021 at 12:20:35PM +0530, Bhupesh Sharma wrote:
> On Mon, 25 Oct 2021 at 11:47, Stephan Gerhold <stephan@gerhold.net> wrote:
> >
> > On Mon, Oct 25, 2021 at 11:18:08AM +0530, Vinod Koul wrote:
> > > On 18-10-21, 12:24, Stephan Gerhold wrote:
> > > > The BAM Data Multiplexer (BAM-DMUX) provides access to the network data
> > > > channels of modems integrated into many older Qualcomm SoCs, e.g.
> > > > Qualcomm MSM8916 or MSM8974.
> > > >
> > > > Shortly said, BAM-DMUX is built using a simple protocol layer on top of
> > > > a DMA engine (Qualcomm BAM DMA). For BAM-DMUX, the BAM DMA engine runs in
> > > > a special mode where the modem/remote side is responsible for powering
> > > > on the BAM when needed but we are responsible to initialize it.
> > > > The BAM is powered off when unneeded by coordinating power control
> > > > via bidirectional interrupts from the BAM-DMUX driver.
> > > >
> > > > This series adds one possible solution for handling the "powered remotely"
> > > > mode in the bam_dma driver.
> > >
> > > This looks good me me. Bhupesh/Stephan what was the conclusion on the
> > > the discussion you folks had?
> > >
> >
> > Basically I said I would wait if you still want to take this for 5.16. :)
> > There is a conflict with the DT schema conversion in Bhupesh's series,
> > but it's trivial to solve no matter which of the patches is applied first.
> >
> > Since Bhupesh still needs to send v5 as far as I can tell (and has a
> > much larger series overall), I think it's fine to apply this one first.
> >
> > Bhupesh, you can just copy-paste this below qcom,controlled-remotely
> > in your DT schema if Vinod applies this patch first:
> >
> >   qcom,powered-remotely:
> >     $ref: /schemas/types.yaml#/definitions/flag
> >     description:
> >       Indicates that the bam is powered up by a remote processor
> >       but must be initialized by the local processor.
> 
> Sure, I can respin my v5 with 'qcom,powered-remotely' property added,
> if this series gets applied first.

Thanks!

> Can I add you S-o-B to the same?

I literally just copy-pasted this from "qcom,controlled-remotely" in
your patch with the description from my dt-bindings change that already
has my S-o-B. I don't think it is necessary to add my S-o-B to your
patch as well just for this. :)

Thanks,
Stephan
