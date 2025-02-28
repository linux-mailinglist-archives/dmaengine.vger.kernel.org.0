Return-Path: <dmaengine+bounces-4607-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BD982A49E24
	for <lists+dmaengine@lfdr.de>; Fri, 28 Feb 2025 16:57:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 17B6D7A759A
	for <lists+dmaengine@lfdr.de>; Fri, 28 Feb 2025 15:56:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFA05271277;
	Fri, 28 Feb 2025 15:57:08 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-vk1-f178.google.com (mail-vk1-f178.google.com [209.85.221.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B130C2702B1;
	Fri, 28 Feb 2025 15:57:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740758228; cv=none; b=Nn8qhZX5aVH2YovsiVZqaNhbO2uuVHm1LuL9JbCun/NNvwFtMYr+7wSfSsLQDCu98U+j+AWV/zRQCoP8/ypwWi8Sl5RmE3IXe57ag54ztNNimyhuoLkBnqnVosxsVNV6yVTAijCGKGndIxsZWKzK53ayNIGHktZ7tULFd9/R060=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740758228; c=relaxed/simple;
	bh=cwQm+Cj57JzUKKfj1O10gB0/JWUcjyW0UfIvHpZAH3k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XbMrCDwy+ziI9MnlEInj0FFwe3+A1ykp9MJ3eIRatLiEztyc0E6CkS2FnfiGH0w3/d8NPrjY+UXSdRFZoVdqqVEggoiHU9D3bjXCHaTz7iw5gg6Aucy5l+9u9+MPOh2bPTekB3WZJxardvOl/+RPZZpASFbGVyHX2eCl2BHwbAo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.221.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f178.google.com with SMTP id 71dfb90a1353d-51eb1a6ca1bso886759e0c.1;
        Fri, 28 Feb 2025 07:57:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740758223; x=1741363023;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2G0vU8Rq6c84B/9Y29hmpks/69aHQnjdEb/z06wUAUY=;
        b=cpOSZRZfvWKC4iCI+h2pLRohQDseGOvzoUna+qt/Ny+Elv4eO+VMyFrTPQivCon5q6
         xN0u1LK9lOgH2GrzruDVxouQ12Awt+kLx7mMoFpc8Z7vDAbvTaomuPmyFJKxOGkLaCtk
         YJK88YnawzcEeFb4zuogo0QYX89ziAaWnIJx4F6JMKAGB5dqyzInC7yDPyw9MhJMcaUi
         mTUoYrRecYEinwGxEp8Fj6VVetfEUlI8cr86iBP9S9/n9Ii0PIWHK8ptHIj/ucjP6QC6
         A0iQsUEkZuOyTYcBcsEZQh+XI/tyD9NxfEYsg/CkJI44Y2/F6XOnUIN3vcpGQ7PiDwaC
         QlcA==
X-Forwarded-Encrypted: i=1; AJvYcCVBZtlcSQ9O9fkvJMjTXtsWIDSm4e/ttLAIHGeUTgE28vCdzBB4zyIB8ixWZH83nFQMtdnwoIuK7CAR5Ot75KjwGho=@vger.kernel.org, AJvYcCVSEMFlVTHkGRLcCTBaPe6mhccSLT7z1vr51xKvRLU/MeU+HuV1cYQ08a6oP1uB7jq1EBGXyPWbTL/K@vger.kernel.org, AJvYcCVg6Y3PvSECDPTd8ZaRc8miQ2xrxULoZ+eDJTgDYH6D1vP+c/wAQ8MnFI34T2AZOrr2rfGbgBQCyHPuKKvk@vger.kernel.org, AJvYcCXzpJApeVAP+dnbI/OHEUd/THtmgeRUG/ge1zEr5f42XcF7Zr/0J+aZTqCUJoYC9hRoKn2KkjxfhlZf@vger.kernel.org
X-Gm-Message-State: AOJu0Yys4Q55WfgNJjZhtogHO2SXAegXJJVQH3fMDHZfbOPu0sq4YwdU
	WWW0jtG2iGuNGx07ShqZkSfA/Vd1pJV0ozRwCfZBxI52tm8+09QuDz53XS9c
X-Gm-Gg: ASbGncs5MGgqMI1pTmnqVPff372KNolf/TsCZ2AU1oAiwVDmG+R5NhogUUFfBftyXCF
	OHR5TtOMc+xfZqPZfC1s+XkkJFj8BhxEvONGyoGCrLtr7DjNXq838CqZgkTsRAUlAYEbjpAnt7D
	h0F0TdBJepZS8m0kJkGCdF9MmLCjTAvkT369Cu03lgM6NdS1YVQ8nN7Pl9rXDf0cphXOCMXJEQi
	0LEBK3xa0/lgzFFd0hsQyUDPl5/+QaZtytQcGXoyQvrT6WQcE2kkhsqY9xsiHuZGpn71+M7OeBu
	k27y7jA968lsqvCrjPVUiPdCreM04je8CB+SH6f8ccQcKiXIr68p1TkAbFg91xI+
X-Google-Smtp-Source: AGHT+IGyjOu06I0NN9WsKcfVjrA790CQIRxjiKjRg8eB0f79nAy2nLAMdRnfbegysKoNvub2Uy7YiA==
X-Received: by 2002:a05:6122:3a11:b0:516:230b:eec with SMTP id 71dfb90a1353d-5235b76fb2dmr2696702e0c.5.1740758223505;
        Fri, 28 Feb 2025 07:57:03 -0800 (PST)
Received: from mail-ua1-f52.google.com (mail-ua1-f52.google.com. [209.85.222.52])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5234bf39480sm622589e0c.21.2025.02.28.07.57.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 28 Feb 2025 07:57:02 -0800 (PST)
Received: by mail-ua1-f52.google.com with SMTP id a1e0cc1a2514c-86714f41f5bso981164241.3;
        Fri, 28 Feb 2025 07:57:02 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCU71S5j1K4fpcRybSSrdaHwk0MpdRo340ciloyH3yfqHRdi2sx2cE9mMP3xrii3Re47DbL9yNs9VfW4dAjZ@vger.kernel.org, AJvYcCVjxRYqQOccwXuIhe35pbo/rVVI4PqJA4WeBNEyAO2u5udyDi+Ad5NEiufL16z8VnzKAZ5r1rjofqX6@vger.kernel.org, AJvYcCWcP/De/x1rrUaPMveffXEyxheCM6kBlzc0joZHBAwJgTl8oF/pJRD1JBHXLUW6Gr+sgtfkRqkiPM4yiQP9MIKXN+A=@vger.kernel.org, AJvYcCXhpd0ssIXGqbYTV8O1W4Cq9HCapMvUulnDf4AcxkCRHm1G2KB9OQH1dRHjshbIhTRXPKP4fwezu3RX@vger.kernel.org
X-Received: by 2002:a05:6102:1626:b0:4bb:d7f0:6e7d with SMTP id
 ada2fe7eead31-4c044fbc94dmr2848825137.25.1740758222518; Fri, 28 Feb 2025
 07:57:02 -0800 (PST)
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
 <CAMuHMdWUdOEjECPAJwKf7UwVs4OsUAEJ49xK+Xdn_bKXhRrt2Q@mail.gmail.com> <TYCPR01MB12093BE16360C82F9CB853AF4C2CC2@TYCPR01MB12093.jpnprd01.prod.outlook.com>
In-Reply-To: <TYCPR01MB12093BE16360C82F9CB853AF4C2CC2@TYCPR01MB12093.jpnprd01.prod.outlook.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Fri, 28 Feb 2025 16:56:50 +0100
X-Gmail-Original-Message-ID: <CAMuHMdXkgK-EdGhyrE6PRzskRXkJ8u+xQ=c5x1-=couedtcmqw@mail.gmail.com>
X-Gm-Features: AQ5f1Jqh5PiS9QO2zKO20WUKxRlP2hyuDNVJ1z4RYhHQm3YEMTC5gqqz5dI3neA
Message-ID: <CAMuHMdXkgK-EdGhyrE6PRzskRXkJ8u+xQ=c5x1-=couedtcmqw@mail.gmail.com>
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

On Fri, 28 Feb 2025 at 16:38, Fabrizio Castro
<fabrizio.castro.jz@renesas.com> wrote:
> > From: Geert Uytterhoeven <geert@linux-m68k.org>
> > On Fri, 28 Feb 2025 at 15:55, Fabrizio Castro
> > <fabrizio.castro.jz@renesas.com> wrote:
> > > > From: Geert Uytterhoeven <geert@linux-m68k.org>
> > > > On Thu, 27 Feb 2025 at 19:16, Fabrizio Castro
> > > > <fabrizio.castro.jz@renesas.com> wrote:
> > > > > > From: Geert Uytterhoeven <geert@linux-m68k.org>
> > > > > > Sent: 24 February 2025 12:44
> > > > > > Subject: Re: [PATCH v4 3/7] dt-bindings: dma: rz-dmac: Document RZ/V2H(P) family of SoCs
> > > > > >
> > > > > > On Thu, 20 Feb 2025 at 16:01, Fabrizio Castro
> > > > > > <fabrizio.castro.jz@renesas.com> wrote:
> > > > > > > Document the Renesas RZ/V2H(P) family of SoCs DMAC block.
> > > > > > > The Renesas RZ/V2H(P) DMAC is very similar to the one found on the
> > > > > > > Renesas RZ/G2L family of SoCs, but there are some differences:
> > > > > > > * It only uses one register area
> > > > > > > * It only uses one clock
> > > > > > > * It only uses one reset
> > > > > > > * Instead of using MID/IRD it uses REQ NO/ACK NO
> > > > > > > * It is connected to the Interrupt Control Unit (ICU)
> > > > > > >
> > > > > > > Signed-off-by: Fabrizio Castro <fabrizio.castro.jz@renesas.com>
> > > > > >
> > > > > > > v1->v2:
> > > > > > > * Removed RZ/V2H DMAC example.
> > > > > > > * Improved the readability of the `if` statement.
> > > > > >
> > > > > > Thanks for the update!
> > > > > >
> > > > > > > --- a/Documentation/devicetree/bindings/dma/renesas,rz-dmac.yaml
> > > > > > > +++ b/Documentation/devicetree/bindings/dma/renesas,rz-dmac.yaml
> > > > > > > @@ -61,14 +66,22 @@ properties:
> > > > > > >    '#dma-cells':
> > > > > > >      const: 1
> > > > > > >      description:
> > > > > > > -      The cell specifies the encoded MID/RID values of the DMAC port
> > > > > > > -      connected to the DMA client and the slave channel configuration
> > > > > > > -      parameters.
> > > > > > > +      For the RZ/A1H, RZ/Five, RZ/G2{L,LC,UL}, RZ/V2L, and RZ/G3S SoCs, the cell
> > > > > > > +      specifies the encoded MID/RID values of the DMAC port connected to the
> > > > > > > +      DMA client and the slave channel configuration parameters.
> > > > > > >        bits[0:9] - Specifies MID/RID value
> > > > > > >        bit[10] - Specifies DMA request high enable (HIEN)
> > > > > > >        bit[11] - Specifies DMA request detection type (LVL)
> > > > > > >        bits[12:14] - Specifies DMAACK output mode (AM)
> > > > > > >        bit[15] - Specifies Transfer Mode (TM)
> > > > > > > +      For the RZ/V2H(P) SoC the cell specifies the REQ NO, the ACK NO, and the
> > > > > > > +      slave channel configuration parameters.
> > > > > > > +      bits[0:9] - Specifies the REQ NO
> > > > > >
> > > > > > So REQ_NO is the new name for MID/RID.
> > > >
> > > > These are documented in Table 4.7-22 ("DMA Transfer Request Detection
> > > > Operation Setting Table").
> > >
> > > REQ_NO is documented in both Table 4.7-22 and in Table 4.6-23 (column `DMAC No.`).
> >
> > Indeed. But not for all of them. E.g. RSPI is missing, IIC is present.
>
> I can see the RSPI related `REQ No.` in the version of the manual I am using,
> although one must be very careful to look at the right entry in the table,
> as the table is quite big, and the entries are ordered by `SPI No.`.
>
> For some devices, the SPI numbers are not contiguous therefore the device specific
> bits may end up scattered.
> For example, for `Name` `RSPI_CH0_sp_rxintpls_n` (mind that the `pls_n` substring
> is on a new line in the table) you can see from Table 4.6-23 that
> its `DMAC No.` is 140 (as you said, in decimal...).

Thanks, I had missed it because the RSPI interrupts are spread across
two places...

> > And the numbers are shown in decimal instead of in hex ;-)
> >
> > > > > It's certainly similar. I would say that REQ_NO + ACK_NO is the new MID_RID.
> > > > >
> > > > > > > +      bits[10:16] - Specifies the ACK NO
> > > > > >
> > > > > > This is a new field.
> > > > > > However, it is not clear to me which value to specify here, and if this
> > > > > > is a hardware property at all, and thus needs to be specified in DT?
> > > > >
> > > > > It is a HW property. The value to set can be found in Table 4.6-27 from
> > > > > the HW User Manual, column "Ack No".
> > > >
> > > > Thanks, but that table only shows values for SPDIF, SCU, SSIU and PFC
> > > > (for external DMA requests).  The most familiar DMA clients listed
> > > > in Table 4.7-22 are missing.  E.g. RSPI0 uses REQ_NO 0x8C/0x8D, but
> > > > which values does it need for ACK_NO?
> > >
> > > Only a handful of devices need it. For every other device (and use case) only the
> > > default value is needed.
> >
> > The default value is RZV2H_ICU_DMAC_ACK_NO_DEFAULT = 0x7f?

If you take this out, how to distinguish between ACK_NO = 0 and
the default?

> > Which I believe already causes you to run into the out-of-range DMACKSELk
> > register offset in rzv2h_icu_register_dma_req_ack()?
> >
> > > But I'll take this out for now, until we get to support a device that actually
> > > needs ACK NO.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

