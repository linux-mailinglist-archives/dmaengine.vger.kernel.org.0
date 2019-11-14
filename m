Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B367FFCC2E
	for <lists+dmaengine@lfdr.de>; Thu, 14 Nov 2019 18:54:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726567AbfKNRxz (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 14 Nov 2019 12:53:55 -0500
Received: from mail.kernel.org ([198.145.29.99]:55184 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726444AbfKNRxz (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Thu, 14 Nov 2019 12:53:55 -0500
Received: from mail-qv1-f42.google.com (mail-qv1-f42.google.com [209.85.219.42])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 87F1820727;
        Thu, 14 Nov 2019 17:53:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573754033;
        bh=FoOAY9hvViKgsLTmMcUUrky6j/lBk2/WL9cdhbynSys=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=pPnZ1tFP/zb5Uf2eZitrrBr8+RHnAG6QVR8CxikW4VkVO1PQH5mYV+oXMOM6ld38T
         YIVr5/twVsXxuIgPVQCnP0xAutIdwUNJZ2xec42lOyGSrfE7vgFvjAMsNYqtZZ/0aF
         hEvOg0fKelyt6wpN22J/RyxKzwUpHKEPbh2L1f0w=
Received: by mail-qv1-f42.google.com with SMTP id x14so2720318qvu.0;
        Thu, 14 Nov 2019 09:53:53 -0800 (PST)
X-Gm-Message-State: APjAAAXWXTRVBQM6CWboTRV//sk+7waxIBKaYOqyVMaJ5uTNnqg+nGU7
        tbH7daUoZxTYADmYuypB5CqkkFA7zNZfyCs45A==
X-Google-Smtp-Source: APXvYqxn0/HOay449gy4df/pZe6Fvu/CaSWw8Nv4yCJSz4K/ab7BUtNCox5hzRHIyowoAHUW18uT482SqJVnK3bZG+o=
X-Received: by 2002:ad4:42b4:: with SMTP id e20mr9393130qvr.85.1573754032554;
 Thu, 14 Nov 2019 09:53:52 -0800 (PST)
MIME-Version: 1.0
References: <20191101084135.14811-1-peter.ujfalusi@ti.com> <20191101084135.14811-9-peter.ujfalusi@ti.com>
 <20191105021900.GA17829@bogus> <fc1ea525-54f1-ff1a-7e1c-61b54f5be862@ti.com>
In-Reply-To: <fc1ea525-54f1-ff1a-7e1c-61b54f5be862@ti.com>
From:   Rob Herring <robh@kernel.org>
Date:   Thu, 14 Nov 2019 11:53:41 -0600
X-Gmail-Original-Message-ID: <CAL_JsqJbV7Zd40admW-x2SSveMqMkG0tM6RFTwjCJyYxX4Cxtw@mail.gmail.com>
Message-ID: <CAL_JsqJbV7Zd40admW-x2SSveMqMkG0tM6RFTwjCJyYxX4Cxtw@mail.gmail.com>
Subject: Re: [PATCH v4 08/15] dt-bindings: dma: ti: Add document for K3 UDMA
To:     Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc:     Vinod <vkoul@kernel.org>, Nishanth Menon <nm@ti.com>,
        Santosh Shilimkar <ssantosh@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        "open list:DMA GENERIC OFFLOAD ENGINE SUBSYSTEM" 
        <dmaengine@vger.kernel.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>, devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Grygorii Strashko <grygorii.strashko@ti.com>,
        Lokesh Vutla <lokeshvutla@ti.com>,
        Tero Kristo <t-kristo@ti.com>,
        Tony Lindgren <tony@atomide.com>, Keerthy <j-keerthy@ti.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Tue, Nov 5, 2019 at 4:07 AM Peter Ujfalusi <peter.ujfalusi@ti.com> wrote=
:
>
>
>
> On 05/11/2019 4.19, Rob Herring wrote:
> > On Fri, Nov 01, 2019 at 10:41:28AM +0200, Peter Ujfalusi wrote:
> >> New binding document for
> >> Texas Instruments K3 NAVSS Unified DMA =E2=80=93 Peripheral Root Compl=
ex (UDMA-P).
> >>
> >> UDMA-P is introduced as part of the K3 architecture and can be found i=
n
> >> AM654 and j721e.
> >>
> >> Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
> >> ---
> >> Rob,
> >>
> >> can you give me some hint on how to fix these two warnings from dt_bin=
ding_check:
> >>
> >>   DTC     Documentation/devicetree/bindings/dma/ti/k3-udma.example.dt.=
yaml
> >> Documentation/devicetree/bindings/dma/ti/k3-udma.example.dts:23.13-72:=
 Warning (ranges_format): /example-0/interconnect@30800000:ranges: "ranges"=
 property has invalid length (24 bytes) (parent #address-cells =3D=3D 1, ch=
ild #address-cells =3D=3D 2, #size-cells =3D=3D 2)
> >>   CHECK   Documentation/devicetree/bindings/dma/ti/k3-udma.example.dt.=
yaml
> >
> > The default #address-cells is 1 for examples. So you need to
> > either override it or change ranges parent address size.
>
> wrapping the cbass_main_navss inside:
> cbass_main {
>     #address-cells =3D <2>;
>     #size-cells =3D <2>;
>     ...
> };
>
> fixes it.
>
> >>
> >> Documentation/devicetree/bindings/dma/ti/k3-udma.example.dt.yaml: inte=
rconnect@30800000: $nodename:0: 'interconnect@30800000' does not match '^(b=
us|soc|axi|ahb|apb)(@[0-9a-f]+)?$'
> >
> > Use 'bus' for the node name of 'simple-bus'.
>
> I took the navss node from the upstream dts (I'm going to fix it there
> as well).
> It has simple-bus for the navss, which is not quite right as NAVSS is
> not a bus, but a big subsystem with multiple components (UDMAP, ringacc,
> INTA, INTR, timers, etc).
>
> What about to change the binding doc to simple-mfd like this

That's really for things not memory-mapped (I'm sure you can probably
find an example to contradict me), so better to keep simple-bus if all
the child nodes have addresses.

Do you need the node name to be 'navss' for some reason? If so, then
better have a compatible string in there to identify it. If not, just
use 'bus' and be done with it.

> cbass_main_navss: navss@30800000 {
>     compatible =3D "simple-mfd";
>     #address-cells =3D <2>;
>     #size-cells =3D <2>;
>     ...
> };
>
> and fix up the DT when I got to the point when I can send the patches to
> enable DMA for am654 and j721e?

There's no requirement yet for DTS files to not have warnings.

> >> +  compatible:
> >> +    oneOf:
> >> +      - const: ti,am654-navss-main-udmap
> >> +      - const: ti,am654-navss-mcu-udmap
> >> +      - const: ti,j721e-navss-main-udmap
> >> +      - const: ti,j721e-navss-mcu-udmap
> >
> > enum works better than oneOf+const. Better error messages.
>
> Like this:
>   compatible:
>     oneOf:
>       - description: for AM654
>         items:
>           - enum:
>               - ti,am654-navss-main-udmap
>               - ti,am654-navss-mcu-udmap
>
>       - description: for J721E
>         items:
>           - enum:
>               - ti,j721e-navss-main-udmap
>               - ti,j721e-navss-mcu-udmap

If the 'description' was useful, but it's not. Just:

compatible:
  enum:
    - ti,am654-navss-main-udmap
    - ti,am654-navss-mcu-udmap
    - ti,j721e-navss-main-udmap
    - ti,j721e-navss-mcu-udmap


Rob
