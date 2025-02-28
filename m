Return-Path: <dmaengine+bounces-4609-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 59CD1A49F2E
	for <lists+dmaengine@lfdr.de>; Fri, 28 Feb 2025 17:44:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 066A03A5C72
	for <lists+dmaengine@lfdr.de>; Fri, 28 Feb 2025 16:44:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3FF42702B7;
	Fri, 28 Feb 2025 16:44:11 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-vk1-f173.google.com (mail-vk1-f173.google.com [209.85.221.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3276257430;
	Fri, 28 Feb 2025 16:44:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740761051; cv=none; b=LPFt6ofVvs7seh0hruKeq0OmJZeRDdQbmTrfkbb392OwVjW9L5qHoiLBaC1uYl7zS53I3K1gFJMQ5yYM3nJlPaxloZ7B63b//uZyLP/HmJon/6fN+N7y/CSVp3guiExap7MeR03jDWKHZZ7YBV/dshOqbFd9F+6FsaO7ujexHKE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740761051; c=relaxed/simple;
	bh=rf3m6v1r74fRweU0q1PXsT9I9UyzsTiIrux0xoUMKMY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Kk2liYUi6cnjyRFkOhP/mQ9mxpYHEkd8cYW6rYH3fOaRf2ETT1Y8dOJkkV7jc+F/8R6NRsehg+fJQ3J69zeOxgiB5FtqBh5Sd91XwZfQifZDFz6fVy/bNPTraax87CUAqNucHBwQcABUzWD/CcrL9+jBc/ZqinF1Kak51Rurg9E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.221.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f173.google.com with SMTP id 71dfb90a1353d-520aede8ae3so1103394e0c.0;
        Fri, 28 Feb 2025 08:44:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740761047; x=1741365847;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wZmsTExTN/j4WLtlXf53YNm76oJhWdLwjJkLBAO41lg=;
        b=a2Txmw04H08+cQOF2aK0wpJjpo+HKXKI4jp6HtSWATKrCIr94EQsSE2WyPtbVtbo4o
         Cpj38x2ACs4HDi8BmEynXOQvpYoowHhJK+LofiOeBrZ5csJUK1g7JA7uLUJfum36cPqt
         mr3RRJ+Omne6vXHxzcuVTgv9ntk96biRl4bgdEDYv5oMKu4xIhZ8vF3gSGuZvBINLPnZ
         IOgIXblOnhGcP/Q8qN0Gyi1T9PSw5/hak7ZPI9iO9pDaAIyO25y9oEQ0yHdEnIns6KxR
         bmNb7rKnbZ32iMhUKh3RQLC7HgPrCM6RzxifR9FNQKN4h7KU3EDhMGa1xcYsIMr/Q7xM
         sPkw==
X-Forwarded-Encrypted: i=1; AJvYcCUQhHZg8XMsPu7ZX8ICVzKJexb6njOcLR3qmbzGQfCG/uPsR0FvvKDxftnloksRwrCQ9/kYkQ+6qGuU@vger.kernel.org, AJvYcCUeeFp8jsvh4WpRIjdvtmNb97h9AKDwF9BD9mL3QqI3j83Hc4axtR3mYJWrHbAHOEzURlr/S/bgFC4gRl8KT++OLWs=@vger.kernel.org, AJvYcCWSvVQMJgiqPeMk5Hu9VTEnCx0El6sHWiLUkiBfzkFPV8yjMYMbYGu3f3YZ0XIAn5iPPbAKvTNqxJh0S61R@vger.kernel.org, AJvYcCX+hng0wrY2zrto53ctaLqz6M0orXnx+mThkQVo0stpGHuhSkxXnQjE56UKQo7vB1gNwzlDi/DdhVm1@vger.kernel.org
X-Gm-Message-State: AOJu0YwaF58nXNlhhJQvoQIh1+J2VWZRIqVqhI+zQYCX9L+B6PBEx1ME
	/ckS4vQYh7Bl3cTD5KQx7IF4qvoKyMvFo9r3agIeTzawPo1Hp1NOxpQDWVrm
X-Gm-Gg: ASbGncs/W6u82ABLisOsUZJGm0/7Isf8mu+YNfK16m88ge3a7kSJ83jfOkP/9Pw4Vx1
	j6flowGkyjlaAXnt1FNzbpFX7WebxBsfmlXfiFRX+D0sxIqEiOOausy/nYYx8bM6j9uD9EReNkh
	5+x2OHVuBD0q1GvIxN0zDa+hxhuDBp2S6GTIIuGwVoP+vzkuEpWf1/4L9O+fdpvgFN8VbTBit+9
	Xn0soDVUC8885Nz3U6vlWyfgRBWd6nf/ugPrViIvs0+TxG06n69/TfuR72BqXue9oD0RaqwgIh9
	Q7A7uAPld/44OfJcfRgEDJ6bpUSfFMgD8feGHRuv8Hrp3dAeixqqGtoYc7YzS09VRlBf
X-Google-Smtp-Source: AGHT+IG8RXSvKIMrvgqfdujKmAoSNjsr32gwiYZKAgnvTQW5Z4XnXqJt7XsrBAx/9w9RIKq8I4O2NQ==
X-Received: by 2002:a05:6102:3f0c:b0:4bb:e8c5:b164 with SMTP id ada2fe7eead31-4c044a0afc4mr3208679137.7.1740761045712;
        Fri, 28 Feb 2025 08:44:05 -0800 (PST)
Received: from mail-vk1-f171.google.com (mail-vk1-f171.google.com. [209.85.221.171])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-86b3dd048d7sm562733241.23.2025.02.28.08.44.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 28 Feb 2025 08:44:05 -0800 (PST)
Received: by mail-vk1-f171.google.com with SMTP id 71dfb90a1353d-51eb1a6ca1bso908785e0c.1;
        Fri, 28 Feb 2025 08:44:04 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWIxZX6/NAaK8i7YcggE2GQYP2kGvh5bqu9GF+6yA//fq0uob5ueSXGUMsPIcQ32qgdqhjUKjiO7OeRtlyc@vger.kernel.org, AJvYcCWgX0JwFL45Dz74XLk3978hELanCHjjz+r64AaEq0MJZRqNH7OefaUbuXh0EcIw6JMJQxj9uHKfUGsr7zgxLvsYvYE=@vger.kernel.org, AJvYcCWjWFfXdJAMfGLoYPENKp3tCvsY4win29dFTkZOdW961HYcYKjKTKFlriAvL+0sc3T1tCM62WJUMf/i@vger.kernel.org, AJvYcCXlNRlxNClTmFWGIp7KduY5jZ51dLKcs+KL54hAhyY3b8zW17cAgwNno4LFX6XC9T2oHXXMkwq0UFap@vger.kernel.org
X-Received: by 2002:a05:6102:6e89:b0:4c1:6feb:83aa with SMTP id
 ada2fe7eead31-4c16feb907bmr1367676137.9.1740761044598; Fri, 28 Feb 2025
 08:44:04 -0800 (PST)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250220150110.738619-1-fabrizio.castro.jz@renesas.com>
 <20250220150110.738619-4-fabrizio.castro.jz@renesas.com> <CAMuHMdUjDw923oStxqY+1myEePH9ApHnyd7sH=_4SSCnGMr=sw@mail.gmail.com>
 <TYCPR01MB12093A1002C4F7D7B989D10C4C2CD2@TYCPR01MB12093.jpnprd01.prod.outlook.com>
 <CAMuHMdWzuNz_4LFtNtoiowq31b=wbA_9Qahj1f0EP-9Wq8X4Uw@mail.gmail.com>
 <TYCPR01MB12093D1484AD0E755B76FAE35C2CC2@TYCPR01MB12093.jpnprd01.prod.outlook.com>
 <CAMuHMdWUdOEjECPAJwKf7UwVs4OsUAEJ49xK+Xdn_bKXhRrt2Q@mail.gmail.com>
 <TYCPR01MB12093BE16360C82F9CB853AF4C2CC2@TYCPR01MB12093.jpnprd01.prod.outlook.com>
 <CAMuHMdXkgK-EdGhyrE6PRzskRXkJ8u+xQ=c5x1-=couedtcmqw@mail.gmail.com> <TYCPR01MB120935A45DD8D9E414D869453C2CC2@TYCPR01MB12093.jpnprd01.prod.outlook.com>
In-Reply-To: <TYCPR01MB120935A45DD8D9E414D869453C2CC2@TYCPR01MB12093.jpnprd01.prod.outlook.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Fri, 28 Feb 2025 17:43:52 +0100
X-Gmail-Original-Message-ID: <CAMuHMdXaQ727Z9iTtZQ-jXfKV7=CN9Kootc8xtgqKazxP2XmAw@mail.gmail.com>
X-Gm-Features: AQ5f1JqUjSj3XKk5vEOPOzlGpPhcerwgQOUvaXb7BuaBVldjXjsVJ49hpyOk6Go
Message-ID: <CAMuHMdXaQ727Z9iTtZQ-jXfKV7=CN9Kootc8xtgqKazxP2XmAw@mail.gmail.com>
Subject: Re: [PATCH v4 3/7] dt-bindings: dma: rz-dmac: Document RZ/V2H(P)
 family of SoCs
To: Fabrizio Castro <fabrizio.castro.jz@renesas.com>
Cc: Vinod Koul <vkoul@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Magnus Damm <magnus.damm@gmail.com>, Biju Das <biju.das.jz@bp.renesas.com>, 
	"dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>, 
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"linux-renesas-soc@vger.kernel.org" <linux-renesas-soc@vger.kernel.org>, 
	Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>
Content-Type: text/plain; charset="UTF-8"

Hi Fabrizio,

On Fri, 28 Feb 2025 at 17:32, Fabrizio Castro
<fabrizio.castro.jz@renesas.com> wrote:
> > From: Geert Uytterhoeven <geert@linux-m68k.org>
> > On Fri, 28 Feb 2025 at 16:38, Fabrizio Castro
> > <fabrizio.castro.jz@renesas.com> wrote:
> > > > From: Geert Uytterhoeven <geert@linux-m68k.org>
> > > > On Fri, 28 Feb 2025 at 15:55, Fabrizio Castro
> > > > <fabrizio.castro.jz@renesas.com> wrote:
> > > > > > From: Geert Uytterhoeven <geert@linux-m68k.org>
> > > > > > On Thu, 27 Feb 2025 at 19:16, Fabrizio Castro
> > > > > > <fabrizio.castro.jz@renesas.com> wrote:
> > > > > > > > From: Geert Uytterhoeven <geert@linux-m68k.org>
> > > > > > > > Sent: 24 February 2025 12:44
> > > > > > > > Subject: Re: [PATCH v4 3/7] dt-bindings: dma: rz-dmac: Document RZ/V2H(P) family of SoCs
> > > > > > > >
> > > > > > > > On Thu, 20 Feb 2025 at 16:01, Fabrizio Castro
> > > > > > > > <fabrizio.castro.jz@renesas.com> wrote:
> > > > > > > > > Document the Renesas RZ/V2H(P) family of SoCs DMAC block.
> > > > > > > > > The Renesas RZ/V2H(P) DMAC is very similar to the one found on the
> > > > > > > > > Renesas RZ/G2L family of SoCs, but there are some differences:
> > > > > > > > > * It only uses one register area
> > > > > > > > > * It only uses one clock
> > > > > > > > > * It only uses one reset
> > > > > > > > > * Instead of using MID/IRD it uses REQ NO/ACK NO
> > > > > > > > > * It is connected to the Interrupt Control Unit (ICU)
> > > > > > > > >
> > > > > > > > > Signed-off-by: Fabrizio Castro <fabrizio.castro.jz@renesas.com>
> > > > > > > >
> > > > > > > > > v1->v2:
> > > > > > > > > * Removed RZ/V2H DMAC example.
> > > > > > > > > * Improved the readability of the `if` statement.
> > > > > > > >
> > > > > > > > Thanks for the update!
> > > > > > > >
> > > > > > > > > --- a/Documentation/devicetree/bindings/dma/renesas,rz-dmac.yaml
> > > > > > > > > +++ b/Documentation/devicetree/bindings/dma/renesas,rz-dmac.yaml
> > > > > > > > > @@ -61,14 +66,22 @@ properties:
> > > > > > > > >    '#dma-cells':
> > > > > > > > >      const: 1
> > > > > > > > >      description:
> > > > > > > > > -      The cell specifies the encoded MID/RID values of the DMAC port
> > > > > > > > > -      connected to the DMA client and the slave channel configuration
> > > > > > > > > -      parameters.
> > > > > > > > > +      For the RZ/A1H, RZ/Five, RZ/G2{L,LC,UL}, RZ/V2L, and RZ/G3S SoCs, the cell
> > > > > > > > > +      specifies the encoded MID/RID values of the DMAC port connected to the
> > > > > > > > > +      DMA client and the slave channel configuration parameters.
> > > > > > > > >        bits[0:9] - Specifies MID/RID value
> > > > > > > > >        bit[10] - Specifies DMA request high enable (HIEN)
> > > > > > > > >        bit[11] - Specifies DMA request detection type (LVL)
> > > > > > > > >        bits[12:14] - Specifies DMAACK output mode (AM)
> > > > > > > > >        bit[15] - Specifies Transfer Mode (TM)
> > > > > > > > > +      For the RZ/V2H(P) SoC the cell specifies the REQ NO, the ACK NO, and the
> > > > > > > > > +      slave channel configuration parameters.
> > > > > > > > > +      bits[0:9] - Specifies the REQ NO
> > > > > > > >
> > > > > > > > So REQ_NO is the new name for MID/RID.
> > > > > >
> > > > > > These are documented in Table 4.7-22 ("DMA Transfer Request Detection
> > > > > > Operation Setting Table").
> > > > >
> > > > > REQ_NO is documented in both Table 4.7-22 and in Table 4.6-23 (column `DMAC No.`).
> > > >
> > > > Indeed. But not for all of them. E.g. RSPI is missing, IIC is present.
> > >
> > > I can see the RSPI related `REQ No.` in the version of the manual I am using,
> > > although one must be very careful to look at the right entry in the table,
> > > as the table is quite big, and the entries are ordered by `SPI No.`.
> > >
> > > For some devices, the SPI numbers are not contiguous therefore the device specific
> > > bits may end up scattered.
> > > For example, for `Name` `RSPI_CH0_sp_rxintpls_n` (mind that the `pls_n` substring
> > > is on a new line in the table) you can see from Table 4.6-23 that
> > > its `DMAC No.` is 140 (as you said, in decimal...).
> >
> > Thanks, I had missed it because the RSPI interrupts are spread across
> > two places...
> >
> > > > And the numbers are shown in decimal instead of in hex ;-)
> > > >
> > > > > > > It's certainly similar. I would say that REQ_NO + ACK_NO is the new MID_RID.
> > > > > > >
> > > > > > > > > +      bits[10:16] - Specifies the ACK NO
> > > > > > > >
> > > > > > > > This is a new field.
> > > > > > > > However, it is not clear to me which value to specify here, and if this
> > > > > > > > is a hardware property at all, and thus needs to be specified in DT?
> > > > > > >
> > > > > > > It is a HW property. The value to set can be found in Table 4.6-27 from
> > > > > > > the HW User Manual, column "Ack No".
> > > > > >
> > > > > > Thanks, but that table only shows values for SPDIF, SCU, SSIU and PFC
> > > > > > (for external DMA requests).  The most familiar DMA clients listed
> > > > > > in Table 4.7-22 are missing.  E.g. RSPI0 uses REQ_NO 0x8C/0x8D, but
> > > > > > which values does it need for ACK_NO?
> > > > >
> > > > > Only a handful of devices need it. For every other device (and use case) only the
> > > > > default value is needed.
> > > >
> > > > The default value is RZV2H_ICU_DMAC_ACK_NO_DEFAULT = 0x7f?
> >
> > If you take this out, how to distinguish between ACK_NO = 0 and
> > the default?
>
> I am not sure I understand what you mean, so my answer here may be completely off.
>
> ACK No. 0 corresponds to SPDIF, CH0, TX, while ACK No. 0x7F is not valid.

OK, that was my understanding, too.

> My understanding of this is that there is a DACK_SEL field per ACK No (23 ICU_DMACKSELk
> registers, 4 DACK_SEL fields per ICU_DMACKSELk registers -> 23 * 4 = 92 DACK_SEL fields),
> to match the 92 ACK numbers listed in Table 4.6-27.
>
> Each DACK_SEL field should contain the global channel index (5 DMACs, 16 channels per DMAC
> -> 5 * 16 = 80 channels in total) associated to the ACK No.
> If DACK_SEL contains a valid channel number (0-79), then the corresponding signal
> gets controlled accordingly, otherwise a fixed output is generated instead.
>
> Mind that the code I sent wasn't dealing with it properly, but wasn't spotted due
> to limited testing capabilities, and it's safe to take out, as the DACK_SEL fields
> will all contain invalid channel numbers by default.
>
> Looking ahead, there is a similar scenario with the TEND signals as well.
>
> So for now the plan is to upstream support for memory/memory and device/memory (REQ No.,
> tested with RSPI), add support for ACK No later (perhaps testing it with audio, or via
> an external device), and finally TEND No if we get to it.

So which values will you put in the dmas property for RSPI?
I assume:
       bits[0:9] - Specifies REQ_NO value
       bit[10] - Specifies DMA request high enable (HIEN)
       bit[11] - Specifies DMA request detection type (LVL)
       bits[12:14] - Specifies DMAACK output mode (AM)
       bit[15] - Specifies Transfer Mode (TM)
i.e. all remaining bits will be zero?

How do you plan to handle adding ACK_NO bits later?
I.e. how to distinguish between remaining bits zero and remaining
bits containing a valid ACK_NO value (which can be zero, for SPDIF)?

I hope I made myself clear this time.
If not, weekend time ;-)

Have a nice weekend!

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

