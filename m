Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2128E2A97BE
	for <lists+dmaengine@lfdr.de>; Fri,  6 Nov 2020 15:37:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727053AbgKFOhZ (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 6 Nov 2020 09:37:25 -0500
Received: from mail.kernel.org ([198.145.29.99]:33832 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726694AbgKFOhY (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Fri, 6 Nov 2020 09:37:24 -0500
Received: from mail-oi1-f177.google.com (mail-oi1-f177.google.com [209.85.167.177])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 38A242087E;
        Fri,  6 Nov 2020 14:37:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604673444;
        bh=dP1smmwQqynJW8vqD8NP9VQ8DjeVdrZFyK1+gpVNs88=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=U+yhaa1ufK/Bal1EEGDAUH6VBZFtPDGfg+7LEzts9I8SAmMYlEfUfpJnOOQQ0pH+e
         LnmXN29eHhv/sVqU/id9Zkkc9eRzLVFrSFTyeCm3UbWpQQI1xdKVuvQpyb4TYziVl4
         BBQGR6gYHvv/mGlNZ6ElQBa5pbHGV0yIfgUZa4uc=
Received: by mail-oi1-f177.google.com with SMTP id t143so1508414oif.10;
        Fri, 06 Nov 2020 06:37:24 -0800 (PST)
X-Gm-Message-State: AOAM5306Kv0KvE9jEXn6oxy3h1lbF+kVCz3YhN8LLJNGsgM6zfmSuCL4
        umGNrXfLmHMhhbfy3iiAJfSsmMHjVc5JDQSM7g==
X-Google-Smtp-Source: ABdhPJw3cWhsCZcPNg4IJyWZN2TL+gofqSa0ncDGvUn4Sw/pJiYFSswPV7OqbFYXSIMNVivDFm7jQfekowUsKhXPfkc=
X-Received: by 2002:aca:5dc2:: with SMTP id r185mr1333493oib.106.1604673443324;
 Fri, 06 Nov 2020 06:37:23 -0800 (PST)
MIME-Version: 1.0
References: <1604571846-14037-1-git-send-email-spujar@nvidia.com>
 <1604571846-14037-5-git-send-email-spujar@nvidia.com> <20201105190508.GB1633758@bogus>
 <8c8c7cc0-881f-5542-f23f-238e5d8608d3@nvidia.com>
In-Reply-To: <8c8c7cc0-881f-5542-f23f-238e5d8608d3@nvidia.com>
From:   Rob Herring <robh@kernel.org>
Date:   Fri, 6 Nov 2020 08:37:12 -0600
X-Gmail-Original-Message-ID: <CAL_JsqKkB03L=jFXTTecpbjS8FqtO72V9EJAWszR12CM4EQChg@mail.gmail.com>
Message-ID: <CAL_JsqKkB03L=jFXTTecpbjS8FqtO72V9EJAWszR12CM4EQChg@mail.gmail.com>
Subject: Re: [PATCH 4/4] dt-bindings: bus: Convert ACONNECT doc to json-schema
To:     Sameer Pujar <spujar@nvidia.com>
Cc:     devicetree@vger.kernel.org,
        Thierry Reding <thierry.reding@gmail.com>,
        Jon Hunter <jonathanh@nvidia.com>, Vinod <vkoul@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <maz@kernel.org>,
        linux-tegra <linux-tegra@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "open list:DMA GENERIC OFFLOAD ENGINE SUBSYSTEM" 
        <dmaengine@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Fri, Nov 6, 2020 at 12:44 AM Sameer Pujar <spujar@nvidia.com> wrote:
>
>
> >> Move ACONNECT documentation to YAML format.
> >>
> >> Signed-off-by: Sameer Pujar <spujar@nvidia.com>
> >> ---
> >>   .../bindings/bus/nvidia,tegra210-aconnect.txt      | 44 -----------
> >>   .../bindings/bus/nvidia,tegra210-aconnect.yaml     | 86 ++++++++++++++++++++++
> >>   2 files changed, 86 insertions(+), 44 deletions(-)
> >>   delete mode 100644 Documentation/devicetree/bindings/bus/nvidia,tegra210-aconnect.txt
> >>   create mode 100644 Documentation/devicetree/bindings/bus/nvidia,tegra210-aconnect.yaml
> >>
>
> ...
>
> >> diff --git a/Documentation/devicetree/bindings/bus/nvidia,tegra210-aconnect.yaml b/Documentation/devicetree/bindings/bus/nvidia,tegra210-aconnect.yaml
> >> new file mode 100644
> >> index 0000000..f0161bc
> >> --- /dev/null
> >> +++ b/Documentation/devicetree/bindings/bus/nvidia,tegra210-aconnect.yaml
> >> @@ -0,0 +1,86 @@
> >> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> >> +%YAML 1.2
> >> +---
> >> +$id: http://devicetree.org/schemas/bus/nvidia,tegra210-aconnect.yaml#
> >> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> >> +
> >> +title: NVIDIA Tegra ACONNECT Bus
> >> +
> >> +description: |
> >> +  The Tegra ACONNECT bus is an AXI switch which is used to connnect various
> >> +  components inside the Audio Processing Engine (APE). All CPU accesses to
> >> +  the APE subsystem go through the ACONNECT via an APB to AXI wrapper. All
> >> +  devices accessed via the ACONNNECT are described by child-nodes.
> >> +
>
> ...
>
> >> +
> >> +patternProperties:
> >> +  "^dma-controller(@[0-9a-f]+)?$":
> >> +    $ref: /schemas/dma/nvidia,tegra210-adma.yaml#
> >> +  "^interrupt-controller(@[0-9a-f]+)?$":
> >> +    $ref: /schemas/interrupt-controller/arm,gic.yaml#
> >> +  "^ahub(@[0-9a-f]+)?$":
> >> +    $ref: /schemas/sound/nvidia,tegra210-ahub.yaml#
> > These all get applied already since they match on compatible strings. So
> > having them here means the schema is applied twice. There's maybe some
> > value to this if it's always going to be these 3 nodes.
>
> 1) May be this could be dropped with "additionalProperties = true", but
> that allows any arbitary property to be added for the device. Without
> this 'make dtbs_check' complains about not matching properties in DT files.

Not if you do what I suggested below. Then only arbitrary nodes can be added.

>
> 2) These may not be the final list of nodes this device can have. In
> future if any new device support gets added under this, above needs to
> be updated. But it will be limited number of devices.
>
> So is [2] fine or you would suggest [1] would be good enough?
>
> >
> > Also, the unit-addresses shouldn't be optional.
> >
> > I'd just do:
> >
> > "@[0-9a-f]+$":
> >    type: object
> >
> >> +
> >> +required:
> >> +  - compatible
> >> +  - clocks
> >> +  - clock-names
> >> +  - power-domains
> >> +  - "#address-cells"
> >> +  - "#size-cells"
> >> +  - ranges
> >> +
> >> +additionalProperties: false
> >> +
> >> +examples:
> >> +  - |
> >> +    #include<dt-bindings/clock/tegra210-car.h>
> >> +
> >> +    aconnect@702c0000 {
> >> +        compatible = "nvidia,tegra210-aconnect";
> >> +        clocks = <&tegra_car TEGRA210_CLK_APE>,
> >> +                 <&tegra_car TEGRA210_CLK_APB2APE>;
> >> +        clock-names = "ape", "apb2ape";
> >> +        power-domains = <&pd_audio>;
> >> +
> >> +        #address-cells = <1>;
> >> +        #size-cells = <1>;
> >> +        ranges = <0x702c0000 0x702c0000 0x00040000>;
> >> +
> >> +        // Child device nodes follow ...
> >> +    };
> >> +
> >> +...
> >> --
> >> 2.7.4
> >>
>
