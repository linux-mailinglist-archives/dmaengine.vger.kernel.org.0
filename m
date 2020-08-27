Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ECD822546A1
	for <lists+dmaengine@lfdr.de>; Thu, 27 Aug 2020 16:17:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727996AbgH0OFs (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 27 Aug 2020 10:05:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:42550 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727103AbgH0OFj (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Thu, 27 Aug 2020 10:05:39 -0400
Received: from mail-oi1-f176.google.com (mail-oi1-f176.google.com [209.85.167.176])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D1C5322BEB;
        Thu, 27 Aug 2020 14:04:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598537073;
        bh=1Q7icZS15ds10bV/JJK72QK64oZ3hVx5Gs5UoRmJ98Y=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=tl+yRPpvVOC0YrftA4sgCJVWFb/LkR2nLxpNX/VePMfSIVcRbEGhau8fsoeZ/d0OI
         xZVlxtTFY0i9XDknPddK0qCJFqCIZIVnM5Jy8AdvN+sYQySrA7Gyqi1qPPd0cpud5u
         A+WpomofAz4jpRAwffXZ2g9Nlh3BGC56idJL5K74=
Received: by mail-oi1-f176.google.com with SMTP id u24so4683389oic.7;
        Thu, 27 Aug 2020 07:04:33 -0700 (PDT)
X-Gm-Message-State: AOAM532y2h6usRQxL5jap9cB06BgUtqUreMOzehGtv0elTye4BBOOhZ8
        Cp/nc3r64PSAj4oZfD9CHL1abLAc0Pa+uze9tQ==
X-Google-Smtp-Source: ABdhPJySPH2tJLgDSKWk2U/55xGLS0GwXwFCXhvqFf81XQitZVSXlRxK+ZH8toMGrmTkit0oRI8rP5SnLYAKkUAuRpc=
X-Received: by 2002:aca:e1d6:: with SMTP id y205mr7123657oig.152.1598537073171;
 Thu, 27 Aug 2020 07:04:33 -0700 (PDT)
MIME-Version: 1.0
References: <20200824084712.2526079-1-vkoul@kernel.org> <20200824084712.2526079-2-vkoul@kernel.org>
 <20200824174009.GA2948650@bogus> <20200825145131.GS2639@vkoul-mobl>
 <20200826063246.GW2639@vkoul-mobl> <CAL_JsqKwwirYhrQxCkoUCVnZa_7yNsBDaqgc5TWbLLpeGv17Zw@mail.gmail.com>
 <20200827045053.GG2639@vkoul-mobl>
In-Reply-To: <20200827045053.GG2639@vkoul-mobl>
From:   Rob Herring <robh@kernel.org>
Date:   Thu, 27 Aug 2020 08:04:21 -0600
X-Gmail-Original-Message-ID: <CAL_JsqJw0q4QLGr+Akaxm8YUnLMnUtgJdO5uMqJF7yKuSrX_YA@mail.gmail.com>
Message-ID: <CAL_JsqJw0q4QLGr+Akaxm8YUnLMnUtgJdO5uMqJF7yKuSrX_YA@mail.gmail.com>
Subject: Re: [PATCH 1/3] dt-bindings: dmaengine: Document qcom,gpi dma binding
To:     Vinod Koul <vkoul@kernel.org>
Cc:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "open list:DMA GENERIC OFFLOAD ENGINE SUBSYSTEM" 
        <dmaengine@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Wed, Aug 26, 2020 at 10:50 PM Vinod Koul <vkoul@kernel.org> wrote:
>
> On 26-08-20, 08:35, Rob Herring wrote:
> > On Wed, Aug 26, 2020 at 12:32 AM Vinod Koul <vkoul@kernel.org> wrote:
> > >
> > > On 25-08-20, 20:21, Vinod Koul wrote:
> > > > Hey Rob,
> > > >
> > > > On 24-08-20, 11:40, Rob Herring wrote:
> > > > > On Mon, 24 Aug 2020 14:17:10 +0530, Vinod Koul wrote:
> > > > > > Add devicetree binding documentation for GPI DMA controller
> > > > > > implemented on Qualcomm SoCs
> > > > > >
> > > > > > Signed-off-by: Vinod Koul <vkoul@kernel.org>
> > > > > > ---
> > > > > >  .../devicetree/bindings/dma/qcom-gpi.yaml     | 87 +++++++++++=
++++++++
> > > > > >  1 file changed, 87 insertions(+)
> > > > > >  create mode 100644 Documentation/devicetree/bindings/dma/qcom-=
gpi.yaml
> > > > > >
> > > > >
> > > > >
> > > > > My bot found errors running 'make dt_binding_check' on your patch=
:
> > > > >
> > > > > /builds/robherring/linux-dt-review/Documentation/devicetree/bindi=
ngs/dma/qcom-gpi.yaml: properties:qcom,ev-factor: {'description': 'Event ri=
ng transfer size compare to channel transfer ring. Event ring length =3D ev=
-factor * transfer ring size', 'maxItems': 1} is not valid under any of the=
 given schemas (Possible causes of the failure):
> > > > >     /builds/robherring/linux-dt-review/Documentation/devicetree/b=
indings/dma/qcom-gpi.yaml: properties:qcom,ev-factor: 'not' is a required p=
roperty
> > > >
> > > > Okay updating dt-schema I do see this, now the question is what is =
this
> > > > and what does it mean ;-) I am not sure I comprehend the error mess=
age.
> > > > I see this for all the new properties I added as required for this
> > > > device node
> > >
> > > Okay I think I have figured it out, I need to provide ref to
> > > /schemas/types.yaml#definitions/uint32 for this to work, which does
> > > makes sense to me.
> > >
> > >   qcom,max-num-gpii:
> > >     $ref: /schemas/types.yaml#definitions/uint32
> > >     maxItems: 1
> >
> > uint32 is always 1 item, so drop. Is there a max value you can define?
>
> Sorry not sure I follow, to clarify you mean drop uint32, if so which
> type to use u8? I can use u8 as max wont be beyond 255.

maxItems applies to arrays. A uint32 is not an array, so drop 'maxItems'.

>
> Yes I will define min as well max values too.
>
> > Otherwise, up to 2^32 - 1 is valid.
>
> I see one more warning given by your bot which I am able to reproduce as
> well:
> Documentation/devicetree/bindings/dma/qcom,gpi.example.dt.yaml: example-0=
: dma-controller@800000:reg:0: [0, 8388608, 0, 393216] is too long
>
> So to fix this I added the #address-cells and #size-cells
>
>         #address-cells =3D <2>;
>         #size-cells =3D <2>;
>         reg =3D <0x0 0x00800000 0x0 0x60000>;
>
> But I am getting the warning, what am I doing incorrect

The cell sizes for reg come from the parent node. The default for
examples is 1 cell each. The easiest thing to do is change reg to
'<0x00800000 0x60000>'. Otherwise, you'd need to define a parent bus
node.

Rob
