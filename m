Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F03A3253CE8
	for <lists+dmaengine@lfdr.de>; Thu, 27 Aug 2020 06:50:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726924AbgH0Eu6 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 27 Aug 2020 00:50:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:53292 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725909AbgH0Eu6 (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Thu, 27 Aug 2020 00:50:58 -0400
Received: from localhost (unknown [122.171.38.130])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 83FFD2078A;
        Thu, 27 Aug 2020 04:50:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598503857;
        bh=+cpPEpRHrWea3EaXA37NXtLOxUHiIVISGIFqHu9YHYw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ogmDvo7BcJBBKkhGnmqRFROqzQy/a8OAbIU8Iwychd6fiwTamTOOyJ5pOmAz9VL1d
         PHwNdUTwTLuxlEeq7iry4xV7gpWBBxdiOdkqhPv6lSekSwSkiOuQzcuJZ0eNpSCW2X
         3A6FtZqYGw5wuC2xzTv6uBJ5/DgOUPY3laT9jRSs=
Date:   Thu, 27 Aug 2020 10:20:53 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Rob Herring <robh@kernel.org>
Cc:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "open list:DMA GENERIC OFFLOAD ENGINE SUBSYSTEM" 
        <dmaengine@vger.kernel.org>
Subject: Re: [PATCH 1/3] dt-bindings: dmaengine: Document qcom,gpi dma binding
Message-ID: <20200827045053.GG2639@vkoul-mobl>
References: <20200824084712.2526079-1-vkoul@kernel.org>
 <20200824084712.2526079-2-vkoul@kernel.org>
 <20200824174009.GA2948650@bogus>
 <20200825145131.GS2639@vkoul-mobl>
 <20200826063246.GW2639@vkoul-mobl>
 <CAL_JsqKwwirYhrQxCkoUCVnZa_7yNsBDaqgc5TWbLLpeGv17Zw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAL_JsqKwwirYhrQxCkoUCVnZa_7yNsBDaqgc5TWbLLpeGv17Zw@mail.gmail.com>
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 26-08-20, 08:35, Rob Herring wrote:
> On Wed, Aug 26, 2020 at 12:32 AM Vinod Koul <vkoul@kernel.org> wrote:
> >
> > On 25-08-20, 20:21, Vinod Koul wrote:
> > > Hey Rob,
> > >
> > > On 24-08-20, 11:40, Rob Herring wrote:
> > > > On Mon, 24 Aug 2020 14:17:10 +0530, Vinod Koul wrote:
> > > > > Add devicetree binding documentation for GPI DMA controller
> > > > > implemented on Qualcomm SoCs
> > > > >
> > > > > Signed-off-by: Vinod Koul <vkoul@kernel.org>
> > > > > ---
> > > > >  .../devicetree/bindings/dma/qcom-gpi.yaml     | 87 +++++++++++++++++++
> > > > >  1 file changed, 87 insertions(+)
> > > > >  create mode 100644 Documentation/devicetree/bindings/dma/qcom-gpi.yaml
> > > > >
> > > >
> > > >
> > > > My bot found errors running 'make dt_binding_check' on your patch:
> > > >
> > > > /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/dma/qcom-gpi.yaml: properties:qcom,ev-factor: {'description': 'Event ring transfer size compare to channel transfer ring. Event ring length = ev-factor * transfer ring size', 'maxItems': 1} is not valid under any of the given schemas (Possible causes of the failure):
> > > >     /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/dma/qcom-gpi.yaml: properties:qcom,ev-factor: 'not' is a required property
> > >
> > > Okay updating dt-schema I do see this, now the question is what is this
> > > and what does it mean ;-) I am not sure I comprehend the error message.
> > > I see this for all the new properties I added as required for this
> > > device node
> >
> > Okay I think I have figured it out, I need to provide ref to
> > /schemas/types.yaml#definitions/uint32 for this to work, which does
> > makes sense to me.
> >
> >   qcom,max-num-gpii:
> >     $ref: /schemas/types.yaml#definitions/uint32
> >     maxItems: 1
> 
> uint32 is always 1 item, so drop. Is there a max value you can define?

Sorry not sure I follow, to clarify you mean drop uint32, if so which
type to use u8? I can use u8 as max wont be beyond 255.

Yes I will define min as well max values too.

> Otherwise, up to 2^32 - 1 is valid.

I see one more warning given by your bot which I am able to reproduce as
well:
Documentation/devicetree/bindings/dma/qcom,gpi.example.dt.yaml: example-0: dma-controller@800000:reg:0: [0, 8388608, 0, 393216] is too long

So to fix this I added the #address-cells and #size-cells

        #address-cells = <2>;
        #size-cells = <2>;
        reg = <0x0 0x00800000 0x0 0x60000>;

But I am getting the warning, what am I doing incorrect

-- 
~Vinod
