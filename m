Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7150C67657
	for <lists+dmaengine@lfdr.de>; Fri, 12 Jul 2019 23:58:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727492AbfGLV6D (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 12 Jul 2019 17:58:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:56506 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727421AbfGLV6D (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Fri, 12 Jul 2019 17:58:03 -0400
Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A5113217D4;
        Fri, 12 Jul 2019 21:49:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1562968185;
        bh=d8UFAnisx41TCLT0SWr7IGBmSao6kWDr5m7t3tFM3Mg=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=DG2DF9rLOyCuXKtTDnOe7KcseUW92ILfUMF6GNRr6sGvSa5Qq8nDzYbkDB51x/dlC
         EsLLDHqS9eRVSLERYdmhbHTDxEpD4gKDTFENMRQZ+BnP+2A145Cd4qs8nG9ugK7hX9
         hsNfHgMq+RB8oJcjVN2ygBXsOX8XTwWRgYeeAd98=
Received: by mail-qt1-f175.google.com with SMTP id h21so9664654qtn.13;
        Fri, 12 Jul 2019 14:49:45 -0700 (PDT)
X-Gm-Message-State: APjAAAXxPyVUaNDDyWurBHEbH43CaYvObrAkeX0Hoou8ll2IUcI4h5j9
        T3cNGK+Htk9HFWBKEy4neIwoQtOcHc3nNX7UEQ==
X-Google-Smtp-Source: APXvYqyeGL6inig9PTJWvCQORSIrZ3T5dsiButx96ewl7Mswi11GC+7fBrsMVr47bLSOh86OnzXLZqeLgm/VF8jqsLI=
X-Received: by 2002:a0c:b786:: with SMTP id l6mr8765642qve.148.1562968184927;
 Fri, 12 Jul 2019 14:49:44 -0700 (PDT)
MIME-Version: 1.0
References: <20190711092158.14678-1-maxime.ripard@bootlin.com>
 <CAL_JsqLh8QEwa-3v9-Vs=e55k3GyyvwsNVxmdBMWMD_VxqKMyA@mail.gmail.com> <28a776e2-52fa-60e9-a7d9-8caeec78f1d1@ti.com>
In-Reply-To: <28a776e2-52fa-60e9-a7d9-8caeec78f1d1@ti.com>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Fri, 12 Jul 2019 15:49:32 -0600
X-Gmail-Original-Message-ID: <CAL_JsqL37NzqbVqqbG-z0RHE=uwqP_8VGF42ABgy24DiucSODA@mail.gmail.com>
Message-ID: <CAL_JsqL37NzqbVqqbG-z0RHE=uwqP_8VGF42ABgy24DiucSODA@mail.gmail.com>
Subject: Re: [PATCH 1/3] dt-bindings: dma: Add YAML schemas for the generic
 DMA bindings
To:     Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc:     Maxime Ripard <maxime.ripard@bootlin.com>,
        Jon Hunter <jonathanh@nvidia.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Frank Rowand <frowand.list@gmail.com>,
        Vinod Koul <vkoul@kernel.org>, devicetree@vger.kernel.org,
        "open list:DMA GENERIC OFFLOAD ENGINE SUBSYSTEM" 
        <dmaengine@vger.kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Fri, Jul 12, 2019 at 3:24 PM Peter Ujfalusi <peter.ujfalusi@ti.com> wrote:
>
>
>
> On 11.7.2019 20.33, Rob Herring wrote:
> > On Thu, Jul 11, 2019 at 3:34 AM Maxime Ripard <maxime.ripard@bootlin.com> wrote:
> >>
> >> The DMA controllers and consumers have a bunch of generic properties that
> >> are needed in a device tree. Add a YAML schemas for those.
> >>
> >> Signed-off-by: Maxime Ripard <maxime.ripard@bootlin.com>
> >> ---
> >>  .../devicetree/bindings/dma/dma-consumer.yaml |  60 +++++++++
> >
> > This already exists in the dt-schema/schemas/dma/dma.yaml though not
> > the descriptions because that needs relicensing.
> >
> > Looks like we need NVidia's (Jon H) and TI's (Peter U) permission.
>
> If I'm not mistaken the new license is GPL-2.0, if so I don't see any
> issue, but I'll ask our legal to be sure.

To move it to the schema repository we need it to be (GPL-2.0 OR
BSD-2-Clause). I'd prefer to have the core bindings in the dt-schema
repo rather than add to the kernel.

Rob
