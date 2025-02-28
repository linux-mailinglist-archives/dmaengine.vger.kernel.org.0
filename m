Return-Path: <dmaengine+bounces-4601-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 93C1CA49D09
	for <lists+dmaengine@lfdr.de>; Fri, 28 Feb 2025 16:16:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 92BA316CE9B
	for <lists+dmaengine@lfdr.de>; Fri, 28 Feb 2025 15:16:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3382A1EF384;
	Fri, 28 Feb 2025 15:16:40 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF9D81EF361;
	Fri, 28 Feb 2025 15:16:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740755800; cv=none; b=iiQnGFF/l9EauwN8L9FjABK32+ti4OEHlK7P5kig4Qrd+gnODIigBIsbTa4BoQjEQglAKjyekgrohdk76SkntR8FdyPbaD/PqbbVieBJkGvnyZBeOAjpHavUGWM2R8TAvRBLDO05rZM+A5YhhLFolckiuDIuOHTzFPWw5O9vVv4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740755800; c=relaxed/simple;
	bh=HUgPDe+NOGqT2dknhuasYSDw5L+p1vj+Lyj115uPLC8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OeN5Z46FiaQ4t3Zy+TGEi6zUhmPPG2h22L0OENQa7tuyDnsoTxhQYguA+9rPrI9w9+xJBny4qhNfPSQpHIz+A4zf8atWIO4wIyPPpfWmn5fPEO70J+EQw+tf16PJxaHeljUvIKeic+8R/6zrxZZ9q96IjfbsziiWgGAsWb0pHV0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.160.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-471eb0e3536so39964291cf.3;
        Fri, 28 Feb 2025 07:16:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740755795; x=1741360595;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AbG0x8vk+DQuXjSs4T7Oeo1hm0T396sYcIRn8+zqydE=;
        b=LfUOoLUpYEaNc2hyS3RvMvaKEpS277eM6FfNAm/lWfweYVcQXT2nncxC0DXxCs98b8
         CRNt1zgv5YAomvO5LCSZvYbizxgPJZMWiQh55dDk6yeEp43SV5vUFBvcGmb5/8qavJIW
         3Nm/zoMNlNZ4WW7tfrB6GNcmY1h1fs0RHWCwClzjL9W4RNsDWhOi+tGV5SD27FIlqEAL
         24DhbTMSg8RS93p9E3wQaXy8IkKffBBMCtRoyD6bWq24rcnhlwjD495nWJZRJLrhZmKg
         Yb1EVKA1cECXyFUohoBfb2DyVv5nrw0QLq/75X65YnKiUSseiI2XiaViaFwV0wmahF5c
         VYWQ==
X-Forwarded-Encrypted: i=1; AJvYcCWEYF0yf7/n/g/ATlbwWg4MlyBwF16B9LfLIMxHpassUDQ1YfhfAkhJUlNHOFeh59SSQwNdxIMW++6hVtgi@vger.kernel.org, AJvYcCWf7m48Hxk3giLR47BFpubXntScYujYTqABrunnoWKuE5F21oEjPPizPBlu99flRW3u9L8AWl5z8mcX@vger.kernel.org, AJvYcCXXTeJpoGhLstFsOsF3qCo+KR0YtwzlpPu5opX1Ayjumrmk/DXxb55JG3oHBK14wQMMNmHvwOrHhVRzCqaBnfj9D9w=@vger.kernel.org, AJvYcCXlaUCQ/KX82Ia2N1L3uU6qilANzyqTIr63IU97YM2R1khUby35ojx2EsZJicvzt0uaAqUi5FoMWEOE@vger.kernel.org
X-Gm-Message-State: AOJu0YxpuOiSwveJOiuTgK5GnxKK5S4/DInTbMvzO9RX4X+Qmh9Qohq4
	lXGZ0I5XVxw3c03DR/46AthgfkHwDW9bA7H1FCaLSpvGy67L1hCOMR/6Pt15
X-Gm-Gg: ASbGnctHzX6npQscUL4jIIjoi1IdhOAhHDsdMiNJI8KmrdUGFxvTxFUA8vqlq/bRMCv
	dYMojkgSoQPdERTw65Rh+DRoGeED+T6GoZr4TxJFOKxwFitjOrNJXJHVtiZMehsfbBgRbwDG5h3
	/fXZYUlTQ9g4Bjudbs+2DLvlx4huZ2zbsYG8T9hCetBPsQSiq6MobHxsIPZ1iwfpT1UVD9CT/k5
	kmC+BNvgbu5BRtTDA9w4cv8xdOlprsLDa1YdX+PfKtk/6QVcE3Zdh8d266y1fZeqewR0/x2QckQ
	ZbSRwbrJCm62S/DnHw7mPobYlZqdiYLTgkJOhSiQLNvtKOOCEYYgSlDHKhg1hmc1
X-Google-Smtp-Source: AGHT+IG7XWmS3mExADjBA3CsnaLEOfAHm2huliOEXcNSUulhDwXvAtoWzs7ac9p+OSYfJG7yWsq5mw==
X-Received: by 2002:a05:622a:1aa1:b0:471:ed0e:ba19 with SMTP id d75a77b69052e-474bc1114e5mr48311571cf.51.1740755795594;
        Fri, 28 Feb 2025 07:16:35 -0800 (PST)
Received: from mail-qv1-f49.google.com (mail-qv1-f49.google.com. [209.85.219.49])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4746b3106b9sm25792851cf.18.2025.02.28.07.16.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 28 Feb 2025 07:16:35 -0800 (PST)
Received: by mail-qv1-f49.google.com with SMTP id 6a1803df08f44-6e8a8d6c38fso7788846d6.3;
        Fri, 28 Feb 2025 07:16:34 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVHyxYKfnSDc8/i/qIEY7rwOcDTN6ROQDD/rihNg/htCs30ghVP/X3qpqVYUDLGoa1NVdt/u1T6QG9G@vger.kernel.org, AJvYcCW9QxgMkoM9CwIrXeo4+fx02LPHXt2FCm5pfLZqUjF/pkJwYW9uNRkEJU41odhMbmIjcbdmVZ5vhVFP@vger.kernel.org, AJvYcCWp70kwb250RED3YYm2JfemUGe6mn3ttwJWRWSqGQ8mHqb3tmadEH7L5v9Wj5TjuMdx5kzybovyTaBL9+NsxAUN3yk=@vger.kernel.org, AJvYcCXJrXEEED4PbEMUyinbXues5YYw382zZfCN78gnaW9G4+RVjdAomiXU5Sq1Sx5FNqtQon7i76nvLHzjt6bL@vger.kernel.org
X-Received: by 2002:a05:6214:2b0b:b0:6e8:9843:ec99 with SMTP id
 6a1803df08f44-6e8a0d6d774mr50803516d6.41.1740755794289; Fri, 28 Feb 2025
 07:16:34 -0800 (PST)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250220150110.738619-1-fabrizio.castro.jz@renesas.com>
 <20250220150110.738619-4-fabrizio.castro.jz@renesas.com> <CAMuHMdUjDw923oStxqY+1myEePH9ApHnyd7sH=_4SSCnGMr=sw@mail.gmail.com>
 <TYCPR01MB12093A1002C4F7D7B989D10C4C2CD2@TYCPR01MB12093.jpnprd01.prod.outlook.com>
 <CAMuHMdWzuNz_4LFtNtoiowq31b=wbA_9Qahj1f0EP-9Wq8X4Uw@mail.gmail.com> <TYCPR01MB12093D1484AD0E755B76FAE35C2CC2@TYCPR01MB12093.jpnprd01.prod.outlook.com>
In-Reply-To: <TYCPR01MB12093D1484AD0E755B76FAE35C2CC2@TYCPR01MB12093.jpnprd01.prod.outlook.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Fri, 28 Feb 2025 16:16:22 +0100
X-Gmail-Original-Message-ID: <CAMuHMdWUdOEjECPAJwKf7UwVs4OsUAEJ49xK+Xdn_bKXhRrt2Q@mail.gmail.com>
X-Gm-Features: AQ5f1JoSyCPUHc04Z2SEMClIkGK3zrCb7imjGbVNwX9TkuAFvSAMmGrVa7n-Gc4
Message-ID: <CAMuHMdWUdOEjECPAJwKf7UwVs4OsUAEJ49xK+Xdn_bKXhRrt2Q@mail.gmail.com>
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

On Fri, 28 Feb 2025 at 15:55, Fabrizio Castro
<fabrizio.castro.jz@renesas.com> wrote:
> > From: Geert Uytterhoeven <geert@linux-m68k.org>
> > Sent: 28 February 2025 10:17
> > Subject: Re: [PATCH v4 3/7] dt-bindings: dma: rz-dmac: Document RZ/V2H(P) family of SoCs
> >
> > Hi Fabrizio,
> >
> > On Thu, 27 Feb 2025 at 19:16, Fabrizio Castro
> > <fabrizio.castro.jz@renesas.com> wrote:
> > > > From: Geert Uytterhoeven <geert@linux-m68k.org>
> > > > Sent: 24 February 2025 12:44
> > > > Subject: Re: [PATCH v4 3/7] dt-bindings: dma: rz-dmac: Document RZ/V2H(P) family of SoCs
> > > >
> > > > On Thu, 20 Feb 2025 at 16:01, Fabrizio Castro
> > > > <fabrizio.castro.jz@renesas.com> wrote:
> > > > > Document the Renesas RZ/V2H(P) family of SoCs DMAC block.
> > > > > The Renesas RZ/V2H(P) DMAC is very similar to the one found on the
> > > > > Renesas RZ/G2L family of SoCs, but there are some differences:
> > > > > * It only uses one register area
> > > > > * It only uses one clock
> > > > > * It only uses one reset
> > > > > * Instead of using MID/IRD it uses REQ NO/ACK NO
> > > > > * It is connected to the Interrupt Control Unit (ICU)
> > > > >
> > > > > Signed-off-by: Fabrizio Castro <fabrizio.castro.jz@renesas.com>
> > > >
> > > > > v1->v2:
> > > > > * Removed RZ/V2H DMAC example.
> > > > > * Improved the readability of the `if` statement.
> > > >
> > > > Thanks for the update!
> > > >
> > > > > --- a/Documentation/devicetree/bindings/dma/renesas,rz-dmac.yaml
> > > > > +++ b/Documentation/devicetree/bindings/dma/renesas,rz-dmac.yaml
> > > > > @@ -61,14 +66,22 @@ properties:
> > > > >    '#dma-cells':
> > > > >      const: 1
> > > > >      description:
> > > > > -      The cell specifies the encoded MID/RID values of the DMAC port
> > > > > -      connected to the DMA client and the slave channel configuration
> > > > > -      parameters.
> > > > > +      For the RZ/A1H, RZ/Five, RZ/G2{L,LC,UL}, RZ/V2L, and RZ/G3S SoCs, the cell
> > > > > +      specifies the encoded MID/RID values of the DMAC port connected to the
> > > > > +      DMA client and the slave channel configuration parameters.
> > > > >        bits[0:9] - Specifies MID/RID value
> > > > >        bit[10] - Specifies DMA request high enable (HIEN)
> > > > >        bit[11] - Specifies DMA request detection type (LVL)
> > > > >        bits[12:14] - Specifies DMAACK output mode (AM)
> > > > >        bit[15] - Specifies Transfer Mode (TM)
> > > > > +      For the RZ/V2H(P) SoC the cell specifies the REQ NO, the ACK NO, and the
> > > > > +      slave channel configuration parameters.
> > > > > +      bits[0:9] - Specifies the REQ NO
> > > >
> > > > So REQ_NO is the new name for MID/RID.
> >
> > These are documented in Table 4.7-22 ("DMA Transfer Request Detection
> > Operation Setting Table").
>
> REQ_NO is documented in both Table 4.7-22 and in Table 4.6-23 (column `DMAC No.`).

Indeed. But not for all of them. E.g. RSPI is missing, IIC is present.
And the numbers are shown in decimal instead of in hex ;-)

> > > It's certainly similar. I would say that REQ_NO + ACK_NO is the new MID_RID.
> > >
> > > > > +      bits[10:16] - Specifies the ACK NO
> > > >
> > > > This is a new field.
> > > > However, it is not clear to me which value to specify here, and if this
> > > > is a hardware property at all, and thus needs to be specified in DT?
> > >
> > > It is a HW property. The value to set can be found in Table 4.6-27 from
> > > the HW User Manual, column "Ack No".
> >
> > Thanks, but that table only shows values for SPDIF, SCU, SSIU and PFC
> > (for external DMA requests).  The most familiar DMA clients listed
> > in Table 4.7-22 are missing.  E.g. RSPI0 uses REQ_NO 0x8C/0x8D, but
> > which values does it need for ACK_NO?
>
> Only a handful of devices need it. For every other device (and use case) only the
> default value is needed.

The default value is RZV2H_ICU_DMAC_ACK_NO_DEFAULT = 0x7f?
Which I believe already causes you to run into the out-of-range DMACKSELk
register offset in rzv2h_icu_register_dma_req_ack()?

> But I'll take this out for now, until we get to support a device that actually
> needs ACK NO.

OK.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

