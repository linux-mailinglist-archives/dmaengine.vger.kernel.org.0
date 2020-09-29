Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0EBAF27D1F5
	for <lists+dmaengine@lfdr.de>; Tue, 29 Sep 2020 16:56:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729934AbgI2Oz5 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 29 Sep 2020 10:55:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:52320 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728599AbgI2Oz4 (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Tue, 29 Sep 2020 10:55:56 -0400
Received: from mail-oi1-f179.google.com (mail-oi1-f179.google.com [209.85.167.179])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0239F20759;
        Tue, 29 Sep 2020 14:55:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1601391356;
        bh=rRoIRoEtvKiTxqLBDCdJgd1vsV6WDXH8vqiw37EJFYA=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=dPznjLDIaJpJChnMBlyMr9U65GihWzprmxsqEfcFO6syoe1QeDYMdtdEY24nUv6C5
         G2+T7OTTyY2TfxrA0rzNaNVd352e42a+G/Czw8N9a9xSMAjByfzDW58Jy8TSGQykHx
         OJAXVbqztgfMHk3ZclOgvMcOMFd5hKjEBfuJHDPs=
Received: by mail-oi1-f179.google.com with SMTP id v20so5783384oiv.3;
        Tue, 29 Sep 2020 07:55:55 -0700 (PDT)
X-Gm-Message-State: AOAM532Rxdd7QaO2xxh59pn4ZQU3Ig+Q6tlx64Z9RxtIxnBnyx1riLf6
        ZLlDaV/L6ovDrfnn+mrtwcyilLkxaZzzpPg+zA==
X-Google-Smtp-Source: ABdhPJyUldfh8e5nBb7FCRtHZXShFRNUVuLZZfubdhoGCMHltLk6gRwvdq1tHkbGaKdvxwT4Kr+Mf9uzd0Eu9PdR/KQ=
X-Received: by 2002:aca:fc07:: with SMTP id a7mr2845041oii.106.1601391354877;
 Tue, 29 Sep 2020 07:55:54 -0700 (PDT)
MIME-Version: 1.0
References: <20200928155953.2819930-1-robh@kernel.org> <68d57be8-c2e9-4bfd-4f7f-041aa3ce2e92@xilinx.com>
In-Reply-To: <68d57be8-c2e9-4bfd-4f7f-041aa3ce2e92@xilinx.com>
From:   Rob Herring <robh@kernel.org>
Date:   Tue, 29 Sep 2020 09:55:43 -0500
X-Gmail-Original-Message-ID: <CAL_JsqL6z5zarTv4e1aWCi0rVoyoDOvZYpYLEuxMJF5a1i7yHQ@mail.gmail.com>
Message-ID: <CAL_JsqL6z5zarTv4e1aWCi0rVoyoDOvZYpYLEuxMJF5a1i7yHQ@mail.gmail.com>
Subject: Re: [PATCH] dt-bindings: Fix 'reg' size issues in zynqmp examples
To:     Michal Simek <michal.simek@xilinx.com>
Cc:     devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Hyun Kwon <hyun.kwon@xilinx.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Vinod Koul <vkoul@kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        "open list:DMA GENERIC OFFLOAD ENGINE SUBSYSTEM" 
        <dmaengine@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Tue, Sep 29, 2020 at 1:55 AM Michal Simek <michal.simek@xilinx.com> wrote:
>
> Hi Rob,
>
> On 28. 09. 20 17:59, Rob Herring wrote:
> > The default sizes in examples for 'reg' are 1 cell each. Fix the
> > incorrect sizes in zynqmp examples:
> >
> > Documentation/devicetree/bindings/dma/xilinx/xlnx,zynqmp-dpdma.example.dt.yaml: example-0: dma-controller@fd4c0000:reg:0: [0, 4249616384, 0, 4096] is too long
> >       From schema: /usr/local/lib/python3.8/dist-packages/dtschema/schemas/reg.yaml
> > Documentation/devicetree/bindings/display/xlnx/xlnx,zynqmp-dpsub.example.dt.yaml: example-0: display@fd4a0000:reg:0: [0, 4249485312, 0, 4096] is too long
> >       From schema: /usr/local/lib/python3.8/dist-packages/dtschema/schemas/reg.yaml
> > Documentation/devicetree/bindings/display/xlnx/xlnx,zynqmp-dpsub.example.dt.yaml: example-0: display@fd4a0000:reg:1: [0, 4249526272, 0, 4096] is too long
> >       From schema: /usr/local/lib/python3.8/dist-packages/dtschema/schemas/reg.yaml
> > Documentation/devicetree/bindings/display/xlnx/xlnx,zynqmp-dpsub.example.dt.yaml: example-0: display@fd4a0000:reg:2: [0, 4249530368, 0, 4096] is too long
> >       From schema: /usr/local/lib/python3.8/dist-packages/dtschema/schemas/reg.yaml
> > Documentation/devicetree/bindings/display/xlnx/xlnx,zynqmp-dpsub.example.dt.yaml: example-0: display@fd4a0000:reg:3: [0, 4249534464, 0, 4096] is too long
> >       From schema: /usr/local/lib/python3.8/dist-packages/dtschema/schemas/reg.yaml
> >
> > Cc: Hyun Kwon <hyun.kwon@xilinx.com>
> > Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> > Cc: Michal Simek <michal.simek@xilinx.com>
> > Cc: Vinod Koul <vkoul@kernel.org>
> > Cc: dri-devel@lists.freedesktop.org
> > Cc: dmaengine@vger.kernel.org
> > Signed-off-by: Rob Herring <robh@kernel.org>
> > ---
> >  .../bindings/display/xlnx/xlnx,zynqmp-dpsub.yaml          | 8 ++++----
> >  .../devicetree/bindings/dma/xilinx/xlnx,zynqmp-dpdma.yaml | 2 +-
> >  2 files changed, 5 insertions(+), 5 deletions(-)
> >
> > diff --git a/Documentation/devicetree/bindings/display/xlnx/xlnx,zynqmp-dpsub.yaml b/Documentation/devicetree/bindings/display/xlnx/xlnx,zynqmp-dpsub.yaml
> > index 52a939cade3b..7b9d468c3e52 100644
> > --- a/Documentation/devicetree/bindings/display/xlnx/xlnx,zynqmp-dpsub.yaml
> > +++ b/Documentation/devicetree/bindings/display/xlnx/xlnx,zynqmp-dpsub.yaml
> > @@ -145,10 +145,10 @@ examples:
> >
> >      display@fd4a0000 {
> >          compatible = "xlnx,zynqmp-dpsub-1.7";
> > -        reg = <0x0 0xfd4a0000 0x0 0x1000>,
> > -              <0x0 0xfd4aa000 0x0 0x1000>,
> > -              <0x0 0xfd4ab000 0x0 0x1000>,
> > -              <0x0 0xfd4ac000 0x0 0x1000>;
> > +        reg = <0xfd4a0000 0x1000>,
> > +              <0xfd4aa000 0x1000>,
> > +              <0xfd4ab000 0x1000>,
> > +              <0xfd4ac000 0x1000>;
> >          reg-names = "dp", "blend", "av_buf", "aud";
> >          interrupts = <0 119 4>;
> >          interrupt-parent = <&gic>;
> > diff --git a/Documentation/devicetree/bindings/dma/xilinx/xlnx,zynqmp-dpdma.yaml b/Documentation/devicetree/bindings/dma/xilinx/xlnx,zynqmp-dpdma.yaml
> > index 5de510f8c88c..2a595b18ff6c 100644
> > --- a/Documentation/devicetree/bindings/dma/xilinx/xlnx,zynqmp-dpdma.yaml
> > +++ b/Documentation/devicetree/bindings/dma/xilinx/xlnx,zynqmp-dpdma.yaml
> > @@ -57,7 +57,7 @@ examples:
> >
> >      dma: dma-controller@fd4c0000 {
> >        compatible = "xlnx,zynqmp-dpdma";
> > -      reg = <0x0 0xfd4c0000 0x0 0x1000>;
> > +      reg = <0xfd4c0000 0x1000>;
> >        interrupts = <GIC_SPI 122 IRQ_TYPE_LEVEL_HIGH>;
> >        interrupt-parent = <&gic>;
> >        clocks = <&dpdma_clk>;
> >
>
> I would prefer to keep 64bit version.
> I use this style.

I prefer to keep the examples simple. The address size is outside the
scope of the binding.

Rob
