Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7FFA245DFC
	for <lists+dmaengine@lfdr.de>; Fri, 14 Jun 2019 15:21:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727737AbfFNNVM (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 14 Jun 2019 09:21:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:57308 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727696AbfFNNVM (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Fri, 14 Jun 2019 09:21:12 -0400
Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7F5F121537;
        Fri, 14 Jun 2019 13:21:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1560518470;
        bh=zSqDfvTWi/91oRnFPmD+sDE1OD8meYbhenxAA0rkJpQ=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=R/OivYycKXCrR4qbnGPXhaeUCc8L4u/YFYrA52THSyhzc7IZ/wON5glZJ4BYkkz28
         cM5y1K7zmj5znbVPQ+rM+TGktxk5HKIq8cBKMnjEirB7nBD5wAU2x7Zo2fEayOuA1b
         9uyJnkaPsk0m63CXpFrWN38NQwOUSd8J1wr282ZI=
Received: by mail-qt1-f181.google.com with SMTP id a15so2372779qtn.7;
        Fri, 14 Jun 2019 06:21:10 -0700 (PDT)
X-Gm-Message-State: APjAAAWmQDFpaIyIbrVi3zBueyUJigPC0jRCM0qSLAg+bMtNqajvFrQ+
        TOOBSy+JbXcLrg6VJoYjF4Tb7ZSgN944/fNT0w==
X-Google-Smtp-Source: APXvYqwPY5Ii8d7b9MpE2fLLzqMQruglLqs18oegyUlcZ2uGTJsB4Rwfi7XLE6zjZcAEozwYHNHmqcKgnXfo9XquaAc=
X-Received: by 2002:aed:3f10:: with SMTP id p16mr15589221qtf.110.1560518469746;
 Fri, 14 Jun 2019 06:21:09 -0700 (PDT)
MIME-Version: 1.0
References: <20190506123456.6777-1-peter.ujfalusi@ti.com> <20190506123456.6777-10-peter.ujfalusi@ti.com>
 <20190613181626.GA7039@bogus> <e0d6a264-96b5-31a6-e70b-3b1c2d863988@ti.com>
In-Reply-To: <e0d6a264-96b5-31a6-e70b-3b1c2d863988@ti.com>
From:   Rob Herring <robh@kernel.org>
Date:   Fri, 14 Jun 2019 07:20:57 -0600
X-Gmail-Original-Message-ID: <CAL_JsqJNMkKL_FubZfjKY6jLebMetmgR24EoendHoPM2ckrUQA@mail.gmail.com>
Message-ID: <CAL_JsqJNMkKL_FubZfjKY6jLebMetmgR24EoendHoPM2ckrUQA@mail.gmail.com>
Subject: Re: [PATCH 09/16] dt-bindings: dma: ti: Add document for K3 UDMA
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
        Tero Kristo <t-kristo@ti.com>, Tony Lindgren <tony@atomide.com>
Content-Type: text/plain; charset="UTF-8"
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Thu, Jun 13, 2019 at 2:33 PM Peter Ujfalusi <peter.ujfalusi@ti.com> wrote:
>
> Rob,
>
> On 13/06/2019 21.16, Rob Herring wrote:
> >> +Remote PSI-L endpoint
> >> +
> >> +Required properties:
> >> +--------------------
> >> +- ti,psil-base:             PSI-L thread ID base of the endpoint
> >> +
> >> +Within the PSI-L endpoint node thread configuration subnodes must present with:
> >> +ti,psil-configX naming convention, where X is the thread ID offset.
> >
> > Don't use vendor prefixes on node names.
>
> OK.
>
> >> +
> >> +Configuration node Required properties:
> >> +--------------------
> >> +- linux,udma-mode:  Channel mode, can be:
> >> +                    - UDMA_PKT_MODE: for Packet mode channels (peripherals)
> >> +                    - UDMA_TR_MODE: for Third-Party mode
> >
> > This is hardly a common linux thing. What determines the value here.
>
> Unfortunately it is.

No, it's a feature of your h/w and in no way is something linux
defined which is the point of 'linux' prefix.

> Each channel can be configured to Packet or TR mode. For some
> peripherals it is true that they only support packet mode, these are the
> newer PSI-L native peripherals.
> For these channels a udma-mode property would be correct.
>
> But we have legacy peripherals as well and they are serviced by PDMA
> (which is a native peripheral designed to talk to the given legacy IP).
> We can use either packet or TR mode in UDMAP to talk to PDMAs, it is in
> most cases clear what to use, but for example for audio (McASP) channels
> Linux is using TR channel because we need cyclic DMA while for example
> RTOS is using Packet mode as it fits their needs better.
>
> Here I need to prefix the udma-mode with linux as the mode is used by
> Linux, but other OS might opt to use different channel mode.

So you'd need <os>,udma-mode? That doesn't work... If the setting is
per OS, then it belongs in the OS because the same dtb should work
across OS's.

> The reason why this needs to be in the DT is that when the channel is
> requested we need to configure the mode and it can not be swapped
> runtime easily between Packet and TR mode.

So when the client makes the channel request, why doesn't it specify the mode?

Rob
