Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 51E7C45667F
	for <lists+dmaengine@lfdr.de>; Fri, 19 Nov 2021 00:35:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233217AbhKRXiX (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 18 Nov 2021 18:38:23 -0500
Received: from mail.kernel.org ([198.145.29.99]:42264 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231231AbhKRXiX (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Thu, 18 Nov 2021 18:38:23 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 5EB5F61A86;
        Thu, 18 Nov 2021 23:35:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1637278522;
        bh=Fqau0dqCEINzmMkwJjTEgzqPnrOEmI3UQprV38RXFd0=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=ucRdJNh0JXxmrs6RFed71fSHkitIRuiPVywHVpbADH9wJn5rFo9NaESSCr88xfb52
         R4OA09akXeyN2c5XGNgJ0m86J2qusiU41LSRAXgfZ9WcKuZFRBPlHd2oTpOvkWQ4pz
         GB6L3s0HEccYXM7G19W6AB7ZLX4vEzQuL8OYsGn8IH91yugl6Q3gHbPzKpvgR2073k
         /iEmv6ho1jXDxK80FgY0TjYc6MhDJel4Cl5+QEO6Yy42WWF739pWPpy9z9s1pALXEu
         OnxRsIhI8F61Zc0t82NwNoH/caNkc9XIY2GHGe3j8EaEZ5gvgI5Xl+oeyMJ6oBjIJF
         s7A9s6vYvySmw==
Received: by mail-ed1-f50.google.com with SMTP id l25so17941603eda.11;
        Thu, 18 Nov 2021 15:35:22 -0800 (PST)
X-Gm-Message-State: AOAM531FW8EZLl1T0ejNaPSEfW0YyDE50Rgh+mHXph+Yu0qxMTaJvpkR
        7ICzqQrHvYzEd7E7IPbgYc4+OtNER6wGf0jE/g==
X-Google-Smtp-Source: ABdhPJwcyGfkHDNwA//qQiBHvHR4tBMsbq6RlSr5Nv+iHL3iTM86rng209dGFSMwRijpZAJ/aoi0m/llJIz5W6hdbFk=
X-Received: by 2002:aa7:cd5c:: with SMTP id v28mr17372154edw.6.1637278520762;
 Thu, 18 Nov 2021 15:35:20 -0800 (PST)
MIME-Version: 1.0
References: <1635427419-22478-1-git-send-email-akhilrajeev@nvidia.com>
 <1635427419-22478-2-git-send-email-akhilrajeev@nvidia.com>
 <YYE7D2W721a1L4Mb@robh.at.kernel.org> <BN9PR12MB5273887DC5A3153A434432ADC08C9@BN9PR12MB5273.namprd12.prod.outlook.com>
In-Reply-To: <BN9PR12MB5273887DC5A3153A434432ADC08C9@BN9PR12MB5273.namprd12.prod.outlook.com>
From:   Rob Herring <robh@kernel.org>
Date:   Thu, 18 Nov 2021 17:35:09 -0600
X-Gmail-Original-Message-ID: <CAL_JsqKqG79kZCT97pRnDHxztoq6rfJ9LDjn_iiuyvQksNnR4A@mail.gmail.com>
Message-ID: <CAL_JsqKqG79kZCT97pRnDHxztoq6rfJ9LDjn_iiuyvQksNnR4A@mail.gmail.com>
Subject: Re: [PATCH v11 1/4] dt-bindings: dmaengine: Add doc for tegra gpcdma
To:     Akhil R <akhilrajeev@nvidia.com>
Cc:     "dan.j.williams@intel.com" <dan.j.williams@intel.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Krishna Yarlagadda <kyarlagadda@nvidia.com>,
        Laxman Dewangan <ldewangan@nvidia.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>,
        "p.zabel@pengutronix.de" <p.zabel@pengutronix.de>,
        Rajesh Gumasta <rgumasta@nvidia.com>,
        "thierry.reding@gmail.com" <thierry.reding@gmail.com>,
        "vkoul@kernel.org" <vkoul@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Wed, Nov 3, 2021 at 5:34 AM Akhil R <akhilrajeev@nvidia.com> wrote:
>
> > On Thu, Oct 28, 2021 at 06:53:36PM +0530, Akhil R wrote:
> > > Add DT binding document for Nvidia Tegra GPCDMA controller.
> > >
> > > Signed-off-by: Rajesh Gumasta <rgumasta@nvidia.com>
> > > Signed-off-by: Akhil R <akhilrajeev@nvidia.com>
> > > Reviewed-by: Jon Hunter <jonathanh@nvidia.com>
> > > ---
> > >  .../bindings/dma/nvidia,tegra186-gpc-dma.yaml      | 115
> > +++++++++++++++++++++
> > >  1 file changed, 115 insertions(+)
> > >  create mode 100644
> > > Documentation/devicetree/bindings/dma/nvidia,tegra186-gpc-dma.yaml
> > >
> > > diff --git
> > > a/Documentation/devicetree/bindings/dma/nvidia,tegra186-gpc-dma.yaml
> > > b/Documentation/devicetree/bindings/dma/nvidia,tegra186-gpc-dma.yaml
> > > new file mode 100644
> > > index 0000000..bc97efc
> > > --- /dev/null
> > > +++ b/Documentation/devicetree/bindings/dma/nvidia,tegra186-gpc-dma.ya
> > > +++ ml
> > > @@ -0,0 +1,115 @@
> > > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause) %YAML 1.2
> > > +---
> > > +$id: http://devicetree.org/schemas/dma/nvidia,tegra186-gpc-dma.yaml#
> > > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > > +
> > > +title: NVIDIA Tegra GPC DMA Controller Device Tree Bindings
> > > +
> > > +description: |
> > > +  The Tegra General Purpose Central (GPC) DMA controller is used for
> > > +faster
> > > +  data transfers between memory to memory, memory to device and
> > > +device to
> > > +  memory.
> > > +
> > > +maintainers:
> > > +  - Jon Hunter <jonathanh@nvidia.com>
> > > +  - Rajesh Gumasta <rgumasta@nvidia.com>
> > > +
> > > +allOf:
> > > +  - $ref: "dma-controller.yaml#"
> > > +
> > > +properties:
> > > +  compatible:
> > > +    oneOf:
> > > +      - enum:
> > > +          - nvidia,tegra186-gpcdma
> > > +          - nvidia,tegra194-gpcdma
> > > +      - items:
> > > +          - const: nvidia,tegra186-gpcdma
> > > +          - const: nvidia,tegra194-gpcdma
> >
> > One of these is wrong. Either 186 has a fallback to 194 or it doesn't.
> Not sure if I understood this correctly. Tegra186 and 194 have different chip data
> inside driver based on the compatible. I guess, it then needs to be one of these.
> Or is the mistake something related to formatting?

It's not about what the driver uses, but what is valid in a DT file.
Either you say the 2 implementations are different and in no way
compatible with each other:

enum:
  - nvidia,tegra186-gpcdma
  - nvidia,tegra194-gpcdma

Or you say 186 is backwards compatible with 194 (meaning 186 is a
superset of 194 so a driver written for 194 still works on 186 (though
not any new features)).

oneOf:
  - const: nvidia,tegra194-gpcdma
  - items:
    - const: nvidia,tegra186-gpcdma
    - const: nvidia,tegra194-gpcdma

Rob
