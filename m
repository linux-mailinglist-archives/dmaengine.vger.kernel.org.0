Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 85B8024A13F
	for <lists+dmaengine@lfdr.de>; Wed, 19 Aug 2020 16:08:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728600AbgHSOFx (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 19 Aug 2020 10:05:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:52900 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728203AbgHSOCt (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Wed, 19 Aug 2020 10:02:49 -0400
Received: from mail-oi1-f169.google.com (mail-oi1-f169.google.com [209.85.167.169])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4BF03204FD;
        Wed, 19 Aug 2020 14:02:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597845769;
        bh=hIHLV4cOF8AgV5MQLy5f4Vy87/PZEGKL0hxscBGc+gU=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=FIKLAputS/I4c2U1zr0YJRhToTkWAF4Wgaxd9YkGul9N09Xcq/NqL2KS7Q4wHdH3Z
         7sDTFe2XNYlIN8PpjxE2jjEzmAMbvADRRfYr1l0bSvd87yUSErDcbQWU7vc9Xutzmf
         HABBiDY93Nwm4rZQ+3gn1fe3Xwr4XvaQkLJKEK3w=
Received: by mail-oi1-f169.google.com with SMTP id u24so19947017oic.7;
        Wed, 19 Aug 2020 07:02:49 -0700 (PDT)
X-Gm-Message-State: AOAM531YoGmOwtO5RnxnDTwwRjHxPMImpG2J0gKfqk7S6anjZOGsU2S8
        KwXf6H273xqETsSExvWHGyjwEw3McJg+cXDl8w==
X-Google-Smtp-Source: ABdhPJwEuXEemEZiUqYvno+DnR9HNhcBW8VWF3alaPB45jQ7e8T7cLXTiuC51U+Q1kwMXOw6ubpK4QLrTvpO4SI7asQ=
X-Received: by 2002:aca:90a:: with SMTP id 10mr3316933oij.106.1597845768614;
 Wed, 19 Aug 2020 07:02:48 -0700 (PDT)
MIME-Version: 1.0
References: <20200731200826.9292-1-Sergey.Semin@baikalelectronics.ru>
 <20200731200826.9292-2-Sergey.Semin@baikalelectronics.ru> <20200803215147.GA3201744@bogus>
 <20200817100014.GG1891694@smile.fi.intel.com>
In-Reply-To: <20200817100014.GG1891694@smile.fi.intel.com>
From:   Rob Herring <robh@kernel.org>
Date:   Wed, 19 Aug 2020 08:02:37 -0600
X-Gmail-Original-Message-ID: <CAL_JsqKGqRs7DGiBcy-Ta_WkajGv-xg8GYMiDe13nQiyLj2VfA@mail.gmail.com>
Message-ID: <CAL_JsqKGqRs7DGiBcy-Ta_WkajGv-xg8GYMiDe13nQiyLj2VfA@mail.gmail.com>
Subject: Re: [PATCH v2 1/5] dt-bindings: dma: dw: Add optional DMA-channels
 mask cell support
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        Serge Semin <fancer.lancer@gmail.com>,
        Viresh Kumar <vireshk@kernel.org>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        "open list:DMA GENERIC OFFLOAD ENGINE SUBSYSTEM" 
        <dmaengine@vger.kernel.org>, devicetree@vger.kernel.org,
        Vinod Koul <vkoul@kernel.org>,
        Peter Ujfalusi <peter.ujfalusi@ti.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Pavel Parkhomenko <Pavel.Parkhomenko@baikalelectronics.ru>
Content-Type: text/plain; charset="UTF-8"
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Mon, Aug 17, 2020 at 4:17 AM Andy Shevchenko
<andy.shevchenko@gmail.com> wrote:
>
> On Mon, Aug 03, 2020 at 03:51:47PM -0600, Rob Herring wrote:
> > On Fri, 31 Jul 2020 23:08:22 +0300, Serge Semin wrote:
> > > Each DW DMA controller channel can be synthesized with different
> > > parameters like maximum burst-length, multi-block support, maximum data
> > > width, etc. Most of these parameters determine the DW DMAC channels
> > > performance in its own aspect. On the other hand these parameters can
> > > be implicitly responsible for the channels performance degradation
> > > (for instance multi-block support is a very useful feature, but having
> > > it disabled during the DW DMAC synthesize will provide a more optimized
> > > core). Since DMA slave devices may have critical dependency on the DMA
> > > engine performance, let's provide a way for the slave devices to have
> > > the DMA-channels allocated from a pool of the channels, which according
> > > to the system engineer fulfill their performance requirements.
> > >
> > > The pool is determined by a mask optionally specified in the fifth
> > > DMA-cell of the DMA DT-property. If the fifth cell is omitted from the
> > > phandle arguments or the mask is zero, then the allocation will be
> > > performed from a set of all channels provided by the DMA controller.
> >
> > Reviewed-by: Rob Herring <robh@kernel.org>
>
> Rob, I have a question to clarify (it's not directly related to the series,
> but to this schema and property names).
>
> We have two drivers for DMA controllers from Synopsys (they are different)
> where properties with the same semantics (like block_size or data-width) have
> different pattern of naming (okay, block_size for older driver even has _
> instead of -), i.e. block_size vs. snps,block-size and data-width vs.
> snps,data-width.
>
> I would like to unify them (*) in both drivers and would like to know which
> naming pattern is preferred in such case?

Unless there's some sign we'd use it with other vendors, I'd generally
keep the vendor prefix. But I don't think it's worth supporting 3
variants of 'data-width' in the name of unification.

Also, if they don't have a vendor prefix, then they should be in some
standard units rather than an encoded register value. (Which seems to
be the case here).

Rob
