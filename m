Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 37D46BCA7C
	for <lists+dmaengine@lfdr.de>; Tue, 24 Sep 2019 16:44:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731067AbfIXOos (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 24 Sep 2019 10:44:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:33896 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726130AbfIXOos (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Tue, 24 Sep 2019 10:44:48 -0400
Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7034E20640;
        Tue, 24 Sep 2019 14:44:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1569336286;
        bh=hsYmAgy4HUyqWVE3XYU8otCVEWiUKOZy0obIq0KY9fc=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=fY5Pw4VpEqdzsU4EX8RtSjM9czFmKim+EQIzlwMydEam/t89uAfwiDt8YO2U2ksZv
         dO9ciKLlwZOpmjdd/0q1ymBadmtBBJnkZMcinczzE9Na8qm5JOtktaAYLGh/aJs5NK
         H7IErRieGE+4K+Bmsfhggv/a3iRKwn+VlvpVJD3Y=
Received: by mail-qt1-f180.google.com with SMTP id x5so2434892qtr.7;
        Tue, 24 Sep 2019 07:44:46 -0700 (PDT)
X-Gm-Message-State: APjAAAXb8BFjtnD74Ra4l9uSM+0Og4TyliVEnMwzUdPGWzUirCKtThRX
        KN6qQBFnj3zTGV/Jnf5wl3QJ4PgnLUktYYsjcw==
X-Google-Smtp-Source: APXvYqzQBwQZq9kQYPNN0Kyc/fhj2qS/SrpDIz9/+J5rKVq0Ej/70VauM4kI1FV1RPFaEgictUsNkC4ch7tW4xPWQz0=
X-Received: by 2002:ac8:6915:: with SMTP id e21mr3238306qtr.224.1569336285554;
 Tue, 24 Sep 2019 07:44:45 -0700 (PDT)
MIME-Version: 1.0
References: <20190910115037.23539-1-peter.ujfalusi@ti.com> <20190910115037.23539-2-peter.ujfalusi@ti.com>
 <5d7ba96c.1c69fb81.ee467.32b9@mx.google.com> <82254a3e-12fe-14d8-d49a-6627dd1d3559@ti.com>
In-Reply-To: <82254a3e-12fe-14d8-d49a-6627dd1d3559@ti.com>
From:   Rob Herring <robh@kernel.org>
Date:   Tue, 24 Sep 2019 09:44:33 -0500
X-Gmail-Original-Message-ID: <CAL_JsqLZ-fNvFcgTorat=TX9Fmexrw3o3iv=Z5hTb3GX6iKgxg@mail.gmail.com>
Message-ID: <CAL_JsqLZ-fNvFcgTorat=TX9Fmexrw3o3iv=Z5hTb3GX6iKgxg@mail.gmail.com>
Subject: Re: [PATCH 1/3] dt-bindings: dma: Add documentation for DMA domains
To:     Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc:     Vinod <vkoul@kernel.org>,
        "open list:DMA GENERIC OFFLOAD ENGINE SUBSYSTEM" 
        <dmaengine@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Mon, Sep 16, 2019 at 6:21 AM Peter Ujfalusi <peter.ujfalusi@ti.com> wrote:
>
>
>
> On 13/09/2019 17.36, Rob Herring wrote:
> > On Tue, Sep 10, 2019 at 02:50:35PM +0300, Peter Ujfalusi wrote:
> >> On systems where multiple DMA controllers available, non Slave (for example
> >> memcpy operation) users can not be described in DT as there is no device
> >> involved from the DMA controller's point of view, DMA binding is not usable.
> >> However in these systems still a peripheral might need to be serviced by or
> >> it is better to serviced by specific DMA controller.
> >> When a memcpy is used to/from a memory mapped region for example a DMA in the
> >> same domain can perform better.
> >> For generic software modules doing mem 2 mem operations it also matter that
> >> they will get a channel from a controller which is faster in DDR to DDR mode
> >> rather then from the first controller happen to be loaded.
> >>
> >> This property is inherited, so it may be specified in a device node or in any
> >> of its parent nodes.
> >
> > If a device needs mem2mem dma, I think we should just use the existing
> > dma binding. The provider will need a way to define cell values which
> > mean mem2mem.
>
> But isn't it going to be an abuse of the binding? Each DMA controller
> would hack this in different ways, probably using out of range DMA
> request/trigger number or if they have direction in the binding or some
> other parameter would be set to something invalid...

What's in the cells is defined by the provider which can define
whatever they want. We do standardize that in some cases.

I think we have some cases where we set the channel priority in the
cells. What if someone wants to do that for mem2mem as well?

> > For generic s/w, it should be able to query the dma speed or get a
> > preferred one IMO. It's not a DT problem.
> >
> > We measure memcpy speeds at boot time to select the fastest
> > implementation for a chip, why not do that for mem2mem DMA?
>
> It would make an impact on boot time since the tests would need to be
> done with a large enough copy to be able to see clearly which one is faster.

Have you measured it? It could be done in parallel and may have little
to no impact.

> Also we should be able to handle different probing orders:
> client1 should have mem2mem channel from dma2.
>
> - dma1 probes
> - client1 probes and asks for a mem2mem channel
> - dma2 probes
>
> Here client1 should deffer until dma2 is probed.

Depending on the driver, don't make the decision in probe, but when
you start using the driver. For example, serial drivers decide on DMA
or no DMA in open().

> Probably the property should be dma-mem2mem-domain to be more precise on
> it's purpose and avoid confusion?
>
> >
> >>
> >> Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
> >> ---
> >>  .../devicetree/bindings/dma/dma-domain.yaml   | 88 +++++++++++++++++++
> >>  1 file changed, 88 insertions(+)
> >>  create mode 100644 Documentation/devicetree/bindings/dma/dma-domain.yaml
> >
> > Note that you have several errors in your schema. Run 'make dt_bindings_check'.
>
> That does not do anything on my system, but git dt-doc-validate running
> via https://github.com/robherring/yaml-bindings.git.

It should do *something*... Do you have libyaml-dev installed?

BTW, while I still mirror to that repo, use
https://github.com/devicetree-org/dt-schema instead.

Rob
