Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7B4783D8DE2
	for <lists+dmaengine@lfdr.de>; Wed, 28 Jul 2021 14:34:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235009AbhG1MeW (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 28 Jul 2021 08:34:22 -0400
Received: from mail-ua1-f54.google.com ([209.85.222.54]:38474 "EHLO
        mail-ua1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234881AbhG1MeP (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 28 Jul 2021 08:34:15 -0400
Received: by mail-ua1-f54.google.com with SMTP id j15so1034301uaa.5;
        Wed, 28 Jul 2021 05:34:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=RJnvbp302V8g4MXsKkIo2aa2JuBdgfaxIAgOR6bdlVw=;
        b=I1583ivdGOqpBjP1uDSJUpjkZLuTB+nHfGvFD9uphLRYeGa6jDe3WUYX1iSyT1E0PD
         ed7zRkAeikwY7BYKhL0GnibkietlbR0NF1g9AnIr3K5UR1Nl8LIallC9ugUFVKkRcn2y
         vBG1+Imf64M4rVDKMYRgkBog0VE7LupGyX2KVVsU5kL9ICA8GfYdmtiW3USRsbgvk+N0
         U2jOOGyNuzFzdDCe5r5Y5flUv8pvPAjkHXMcTxLRcTQNzqCyHjybHDb7rl/8oOhf+iYt
         ZGDMH6RaZVs8iZ4QRE45xPcKFx0Il9Uokb1PimceG39bAGuKh5km5rgML+9TxmsaB689
         fTgg==
X-Gm-Message-State: AOAM532v+8tmVXRJHkh079n6EoYQ+ugCEHqrgAR9AWBPJf62ESNGwut0
        unpq03wEU+DcWx6RQLoF18DvOVM3ODrv6zJpO6o=
X-Google-Smtp-Source: ABdhPJyCGnmAa+yadKaSMnlo5+UqY/rV51WLE1QRqyO88p7RKvwyq9/NmlCbywIN3jETwghKH1r8mLqlIOneDsr+qTs=
X-Received: by 2002:a9f:3649:: with SMTP id s9mr22098399uad.2.1627475651870;
 Wed, 28 Jul 2021 05:34:11 -0700 (PDT)
MIME-Version: 1.0
References: <20210719092535.4474-1-biju.das.jz@bp.renesas.com>
 <20210719092535.4474-3-biju.das.jz@bp.renesas.com> <YP/+r4HzCaAZbUWh@matsya>
 <OS0PR01MB59224844C17A1EE620E2D18786E99@OS0PR01MB5922.jpnprd01.prod.outlook.com>
 <YQD3FLN0YEVk6rnr@matsya> <OS0PR01MB59228D6F0AD7A51DAFFB512A86EA9@OS0PR01MB5922.jpnprd01.prod.outlook.com>
 <YQE542kiEGcYCCFO@matsya> <OS0PR01MB592222F26C8684E8D88DA55486EA9@OS0PR01MB5922.jpnprd01.prod.outlook.com>
In-Reply-To: <OS0PR01MB592222F26C8684E8D88DA55486EA9@OS0PR01MB5922.jpnprd01.prod.outlook.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Wed, 28 Jul 2021 14:34:00 +0200
Message-ID: <CAMuHMdUFr8FWk_i2hG3HJ1vTz7wjdHc=Sr8eYtzU20AwcA+2+g@mail.gmail.com>
Subject: Re: [PATCH v4 2/4] drivers: dma: sh: Add DMAC driver for RZ/G2L SoC
To:     Biju Das <biju.das.jz@bp.renesas.com>
Cc:     Vinod Koul <vkoul@kernel.org>,
        Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Chris Paterson <Chris.Paterson2@renesas.com>,
        "dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>,
        Chris Brandt <Chris.Brandt@renesas.com>,
        "linux-renesas-soc@vger.kernel.org" 
        <linux-renesas-soc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Hi Biju,

On Wed, Jul 28, 2021 at 1:58 PM Biju Das <biju.das.jz@bp.renesas.com> wrote:
> > On 28-07-21, 07:00, Biju Das wrote:
> > > > Sorry I dont like passing numbers like this :(
> > > >
> > > > Can you explain what is meant by each of the above values and looks
> > > > like some (if not all) can be derived (slave config as well as
> > > > transaction
> > > > properties)
> > >
> > >
> > > 0x11228 (Tx)
> > > 0x11220 (Rx)
> > >
> > > BIT 22:- TM :- Transfer Mode
> >
> > What are the values, here it seems 0
>
> Yes, that is correct single bit. 0 means single transfer mode, 1 block transfer mode.
>
> >
> > > Bits 16->19 :- DDS(Destination Data Size) --> 0x0001 (16 bits) Bits
> > > 12->15 :- SDS(Source Data size)--> 0x0001 (16 bits)
> >
> > use src_addr_width/dst_addr_width ..?
>
> We support 128,256,512 and 1024 bits as well. I will extend enum dma_slave_buswidth to support this in another patch.
> Is it ok?
>
> >
> > > Bit  11     :- Reserved
> > > Bits 8->10 :- Ack mode  --> 0x010 (Bus cycle mode)
> >
> > What does this mean?
>
> DMAACK output mode is coming from HW manual, A big table of around 230 entries for on chip request with dedicated values for the above bits.
>
> 0x000 -- Initial value
> 0x001 -- 001 (LEVEL Mode) (001 for MTU,PWM,CAN etccc
> 0x01x -- Bus cycle mode (010 for OSTM,I2C, SSIF)
> 0x1xx -- DMAACK not to output(SCIF)
>
> >
> > > Bit 7 :-  Reserved
> > > Bit 6:- LVL -->  Level -->0 (DMA request based on edge of thesignal)
> > > Bit 5:- HIEN -->  High Enable --> 1 (Detects a DMA request on rising
> > > edge of the signal) Bit 4:- LOEN --> Low Enable -->0 (Does not DMA
> > > request on falling edge of the signal) Bit 3:- REQD --> Request
> > > Direction ->1 (DMAREQ is Destination)
> >
> > how and what decides these values
> > It is now hardcoded in the client driver,
>
> It is SoC specific, coming from HW manual. Each on chip peripheral has it's own values.
> Even source address/Destination address of the on chip module is also part of that table.
>
> can we do that in dma driver
> > instead? While deriving most of the values?
>
> If we add this in DMA driver, it won't be generic. We need to prepare a big LUT(based on MID +RID) for all the peripherals
> If SSI then use a value from LUT, SCIF then another value like that.
>
> So please let me know how do we want to proceed here?

Looks like we should pass this in the dmas properties in DT instead,
either by increasing #dma-cells, or by encoding it with the MID/RID
value in the existing cell?

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
