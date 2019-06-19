Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DA0F24BAAC
	for <lists+dmaengine@lfdr.de>; Wed, 19 Jun 2019 16:04:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726143AbfFSOEl (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 19 Jun 2019 10:04:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:53504 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726047AbfFSOEl (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Wed, 19 Jun 2019 10:04:41 -0400
Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D9C3421783;
        Wed, 19 Jun 2019 14:04:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1560953080;
        bh=97TXVH65mMfV5w2HMYzAftt020yRE8J8woo9idTWyrg=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=GQZtA9m+aghgtLbTJCTLcGQ2xOJmpH9TSP6kwXyqDJH8/KylAnsD4ksi6rh2PBElb
         G4NgmXmOXpadOPgNMQVx3mLhNE/5Dpvjtrq6LHqg9kkEJeCRQ6KMdKoBryc+XUcEyi
         XYNUrXyBXJ5191ROp35tXbR3dWhCMEJkziIBE9mU=
Received: by mail-qk1-f179.google.com with SMTP id g18so10973899qkl.3;
        Wed, 19 Jun 2019 07:04:39 -0700 (PDT)
X-Gm-Message-State: APjAAAWrMpW4SlPmlOOBuklVyNRu5S+xi+twFI52+yqbbrqFfZwSmfIS
        YEGn1MnFOBCHzNea8ewuxcUz/1vG2598ZAdOhw==
X-Google-Smtp-Source: APXvYqwi/+mIBYNi4WCbUWLHb/9h3vhdYu6+esugFSfRU1ol2StHjeOdJMtIkOrVHWDAo5UnQj67m17DYpcF1eu6pDg=
X-Received: by 2002:a05:620a:5b1:: with SMTP id q17mr33634246qkq.174.1560953079014;
 Wed, 19 Jun 2019 07:04:39 -0700 (PDT)
MIME-Version: 1.0
References: <20190506123456.6777-1-peter.ujfalusi@ti.com> <20190506123456.6777-10-peter.ujfalusi@ti.com>
 <20190613181626.GA7039@bogus> <e0d6a264-96b5-31a6-e70b-3b1c2d863988@ti.com>
 <CAL_JsqJNMkKL_FubZfjKY6jLebMetmgR24EoendHoPM2ckrUQA@mail.gmail.com> <e811d674-b79f-4da8-c632-c7a90844b6c5@ti.com>
In-Reply-To: <e811d674-b79f-4da8-c632-c7a90844b6c5@ti.com>
From:   Rob Herring <robh@kernel.org>
Date:   Wed, 19 Jun 2019 08:04:26 -0600
X-Gmail-Original-Message-ID: <CAL_JsqJTWNKTB1D2wNysonzasgL9awLLvr1HdOckUnQbpgsDQw@mail.gmail.com>
Message-ID: <CAL_JsqJTWNKTB1D2wNysonzasgL9awLLvr1HdOckUnQbpgsDQw@mail.gmail.com>
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
Content-Transfer-Encoding: quoted-printable
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Fri, Jun 14, 2019 at 7:42 AM Peter Ujfalusi <peter.ujfalusi@ti.com> wrot=
e:
>
>
> On 14/06/2019 16.20, Rob Herring wrote:
> > On Thu, Jun 13, 2019 at 2:33 PM Peter Ujfalusi <peter.ujfalusi@ti.com> =
wrote:
> >>
> >> Rob,
> >>
> >> On 13/06/2019 21.16, Rob Herring wrote:
> >>>> +Remote PSI-L endpoint
> >>>> +
> >>>> +Required properties:
> >>>> +--------------------
> >>>> +- ti,psil-base:             PSI-L thread ID base of the endpoint
> >>>> +
> >>>> +Within the PSI-L endpoint node thread configuration subnodes must p=
resent with:
> >>>> +ti,psil-configX naming convention, where X is the thread ID offset.
> >>>
> >>> Don't use vendor prefixes on node names.
> >>
> >> OK.
> >>
> >>>> +
> >>>> +Configuration node Required properties:
> >>>> +--------------------
> >>>> +- linux,udma-mode:  Channel mode, can be:
> >>>> +                    - UDMA_PKT_MODE: for Packet mode channels (peri=
pherals)
> >>>> +                    - UDMA_TR_MODE: for Third-Party mode
> >>>
> >>> This is hardly a common linux thing. What determines the value here.
> >>
> >> Unfortunately it is.
> >
> > No, it's a feature of your h/w and in no way is something linux
> > defined which is the point of 'linux' prefix.
>
> The channel can be either Packet or TR mode. The HW is really flexible
> on this (and on other things as well).
> It just happens that Linux need to use specific channels in a specific mo=
de.
>
> Would it help if we assume that all channels are used in Packet mode,
> but we have linux,tr-mode bool to indicate that the given channel in
> Linux need to be used in TR mode.

Your use of 'linux' prefix is wrong. Stop using it.

> >> Each channel can be configured to Packet or TR mode. For some
> >> peripherals it is true that they only support packet mode, these are t=
he
> >> newer PSI-L native peripherals.
> >> For these channels a udma-mode property would be correct.
> >>
> >> But we have legacy peripherals as well and they are serviced by PDMA
> >> (which is a native peripheral designed to talk to the given legacy IP)=
.
> >> We can use either packet or TR mode in UDMAP to talk to PDMAs, it is i=
n
> >> most cases clear what to use, but for example for audio (McASP) channe=
ls
> >> Linux is using TR channel because we need cyclic DMA while for example
> >> RTOS is using Packet mode as it fits their needs better.
> >>
> >> Here I need to prefix the udma-mode with linux as the mode is used by
> >> Linux, but other OS might opt to use different channel mode.
> >
> > So you'd need <os>,udma-mode? That doesn't work... If the setting is
> > per OS, then it belongs in the OS because the same dtb should work
> > across OS's.
>
> So I should have a table for the thread IDs in the DMA driver and mark
> channels as TR or Packet in there for Linux use?

Perhaps. I haven't heard any reasons why you need this in DT. If Linux
is dictating the modes, then sounds like it should be in Linux.

But really, I don't fully understand what you are doing here to tell
you what to do beyond using 'linux' prefix is wrong.

> Or just an array which would mark the non packet PSI-L thread IDs?
>
> I still prefer to have this coming via DT as a Linux parameter as other
> OS is free to ignore the linux,udma-mode, but as I said there are
> certain channels which must be used in Linux in certain mode while
> others in different mode.

A DT client is free to ignore any DT property. You don't need a client
prefix for that.

> >> The reason why this needs to be in the DT is that when the channel is
> >> requested we need to configure the mode and it can not be swapped
> >> runtime easily between Packet and TR mode.
> >
> > So when the client makes the channel request, why doesn't it specify th=
e mode?
>
> This is UDMAP internal information on what type of Descriptors the
> channel will expect and how it is going to dispatch the work.
>
> Packet and TR mode at the end does the same thing, but in a completely
> different way.
>
> - P=C3=A9ter
>
> Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
> Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
