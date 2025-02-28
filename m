Return-Path: <dmaengine+bounces-4597-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CA7FA496EC
	for <lists+dmaengine@lfdr.de>; Fri, 28 Feb 2025 11:20:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E6D25175290
	for <lists+dmaengine@lfdr.de>; Fri, 28 Feb 2025 10:18:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06E0725E44C;
	Fri, 28 Feb 2025 10:17:38 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-vk1-f181.google.com (mail-vk1-f181.google.com [209.85.221.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6EF125E46C;
	Fri, 28 Feb 2025 10:17:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740737857; cv=none; b=J6sMlXI3EoMfHMHC8FiDvzW7sZ1PpmUb2RMtwATBcVaR9fLUqKPjnOVsjO7JK6tjG8AOGYXQddRMXUExn/2vqmvcmPtsnTHxUpo14hW+W2GgztAAAsFoIqQ8rAS8rlLv+vnXJd7zs/dGJtCinIN7n4ilaBSXsed7/UDOc8kpq3M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740737857; c=relaxed/simple;
	bh=GFa+NuVufK/uGCpLIg299oeIpkh63tsKLsAAaNrx77w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cJzGgFpd8EOqAK3zZ3qzHIOFetmXpWHzcsyykNi5rQ0JjnSk5mzyrZtnY7Pf8nMaslTh54lyIViTINf7eNGSu//lfsLbmNWGY/wdEufqvN1yTxCKUvL3piH/b2UdxKwNBjEWEc0BLkic9NCzktcRC+CvQJJNop36Zm6zNl8OUNM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.221.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f181.google.com with SMTP id 71dfb90a1353d-51f22008544so799782e0c.1;
        Fri, 28 Feb 2025 02:17:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740737854; x=1741342654;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/kUD47B1lI176RCzaL81Lq6+uEk8CLF2tamPfj8ZlAM=;
        b=Gi0SZ27QamWS2IhoCDKi55M9TqRKie3Je1le+yq2qCXEc4AlTzl8tZhbcSRBBLnlBy
         gv5vyBEZ45orA9lAopCKJRC5YHfZLnQ9+5/tb6tK2ypENyofmyojzHfLgFYPbGlK/Gt4
         VLYcUCvIDVDAFMjC2BRdZ9DqRZoE4vkhfP64XE9kJ2obQxZagIx2QUY00+fxEPUULDq6
         i4OW7WtGTZXcVro7d41hXpuoUxn+ZCA8CJhig7wxd4t+Kwkg7WoszkBmI+z93+iDBNkL
         DUcbnvqo33W+k5rwH2BSt+J1A6mp37j98Ad/Rji77gF7cd6HAN6xhSFTaiIVUqr9auCS
         CaVg==
X-Forwarded-Encrypted: i=1; AJvYcCUrPqWZkLXEVZ2CvoBq/ptTtUAsjkOX/qqz+nQiKzPOmCjhC+IvNRXKGBUUqsxC0B61m63mptBw96T9Ggyy@vger.kernel.org, AJvYcCVCxZ8bOSqECt/V7QrBJDn2QNLSQTNLKeRylbAKoBfdKg74vCUCGmfjv9cfgAJhUVh2U0NIeNemDAPg@vger.kernel.org, AJvYcCXcDNoTnJRmFw1AsWeUtWQsDi2yPi+ilPDcKG0FkcTy2leUPKXJr4Ej08sst3hKRYHvi4k2iTqPVFu+ezn252VoX9A=@vger.kernel.org, AJvYcCXwHeC0/Pn5koGg7Z3Wo6ELTIRK4Q9itvC5Xp8IOqxBEYpbqPT3a2s3LIVJzPvfA8OZspEFvZJudBBN@vger.kernel.org
X-Gm-Message-State: AOJu0YzbeoR6z9ge5SRRR9c2WqFcaxcEDyUFXTcnQgDbHhNoB/fKxn8G
	datYMgMdstYw0A5Ja8Qbp05Z/kPdvOA3a/8tOGzJ4kkGTSlPn/vPxKWFmYx0
X-Gm-Gg: ASbGncv+juaeIVlYrI11/+SM2iVxnDa2xki0gIOvxyY6PMQ7qjI6oMaijg1AgfYpLiQ
	wnw4NDDQiFQ7O1bXxNVkfcdCjmq5iTZCnhfZ4YMaeOtT8mRQuoLy6lqu8zK8UATm0lwoDHZ/abh
	ExGfvXw/PWRKU5gpxh9eDQ/GsnjUUONm85m5g3i379rlGuCtOrpBkJCb5rTe2MT2g1cPREk6xYE
	KIdRUNiz6OJAooGDaKTw2IPU3YKgkG9+zaxTLrk0JXuYeOu+jJ8IqnqgrsGeDLt7YYLPjBrsdr5
	6juXnnkumEXX/dqfataOjVMC5J2loU2SyjaLStfBIEFXHGnf4fHzdWfyXY4Y420L
X-Google-Smtp-Source: AGHT+IH9L75/gXYLAs9T9jZdh7ykhdD65oq1QbiMCBXMsDNEY18WQTSEntCyxzCjjcu5TI0lNnvWDQ==
X-Received: by 2002:a05:6122:2897:b0:520:3987:ce0b with SMTP id 71dfb90a1353d-5235b519bf9mr1578864e0c.2.1740737853659;
        Fri, 28 Feb 2025 02:17:33 -0800 (PST)
Received: from mail-ua1-f44.google.com (mail-ua1-f44.google.com. [209.85.222.44])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5234c0b9961sm517912e0c.46.2025.02.28.02.17.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 28 Feb 2025 02:17:33 -0800 (PST)
Received: by mail-ua1-f44.google.com with SMTP id a1e0cc1a2514c-86112ab1ad4so790458241.1;
        Fri, 28 Feb 2025 02:17:33 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCV+A2g79PvclmkknWxskyZu/l6EEePj9FROXVFIW+HhoQDSqY52b4aIyiHErlQ8mFmNDvW+xiAHhlBttLOs@vger.kernel.org, AJvYcCVJiy4cXouVhVkfztzfZTng+l34ieeFW7r+0c9JKIJNWgktXpT5ZrhkW1hUtvAlooQ/wD5zmboNG1kFCeI3gu9FbGM=@vger.kernel.org, AJvYcCVufKI1yBcz5eg2efv0G/vKE12DerPr2g3s72L23gXalLw/A/qmJTFPSd4U6zT9fB7Vjp/JNYRcuLOC@vger.kernel.org, AJvYcCXnMH12VYI2iPMyicD22L6MZNSRHQEZwiqA9imbaw5Jx7rx7K7OR1tlkNlFKzL71D8DWpXLcQMdFN3A@vger.kernel.org
X-Received: by 2002:a05:6102:568a:b0:4ba:95f1:cc83 with SMTP id
 ada2fe7eead31-4c044ed8255mr1633845137.16.1740737852990; Fri, 28 Feb 2025
 02:17:32 -0800 (PST)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250220150110.738619-1-fabrizio.castro.jz@renesas.com>
 <20250220150110.738619-4-fabrizio.castro.jz@renesas.com> <CAMuHMdUjDw923oStxqY+1myEePH9ApHnyd7sH=_4SSCnGMr=sw@mail.gmail.com>
 <TYCPR01MB12093A1002C4F7D7B989D10C4C2CD2@TYCPR01MB12093.jpnprd01.prod.outlook.com>
In-Reply-To: <TYCPR01MB12093A1002C4F7D7B989D10C4C2CD2@TYCPR01MB12093.jpnprd01.prod.outlook.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Fri, 28 Feb 2025 11:17:20 +0100
X-Gmail-Original-Message-ID: <CAMuHMdWzuNz_4LFtNtoiowq31b=wbA_9Qahj1f0EP-9Wq8X4Uw@mail.gmail.com>
X-Gm-Features: AQ5f1JqCbWr36YNaydbu24KJtpDiae4zRcoRgETN25iCQwcUEQYXT2lEPQq0yoE
Message-ID: <CAMuHMdWzuNz_4LFtNtoiowq31b=wbA_9Qahj1f0EP-9Wq8X4Uw@mail.gmail.com>
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

On Thu, 27 Feb 2025 at 19:16, Fabrizio Castro
<fabrizio.castro.jz@renesas.com> wrote:
> > From: Geert Uytterhoeven <geert@linux-m68k.org>
> > Sent: 24 February 2025 12:44
> > Subject: Re: [PATCH v4 3/7] dt-bindings: dma: rz-dmac: Document RZ/V2H(P) family of SoCs
> >
> > On Thu, 20 Feb 2025 at 16:01, Fabrizio Castro
> > <fabrizio.castro.jz@renesas.com> wrote:
> > > Document the Renesas RZ/V2H(P) family of SoCs DMAC block.
> > > The Renesas RZ/V2H(P) DMAC is very similar to the one found on the
> > > Renesas RZ/G2L family of SoCs, but there are some differences:
> > > * It only uses one register area
> > > * It only uses one clock
> > > * It only uses one reset
> > > * Instead of using MID/IRD it uses REQ NO/ACK NO
> > > * It is connected to the Interrupt Control Unit (ICU)
> > >
> > > Signed-off-by: Fabrizio Castro <fabrizio.castro.jz@renesas.com>
> >
> > > v1->v2:
> > > * Removed RZ/V2H DMAC example.
> > > * Improved the readability of the `if` statement.
> >
> > Thanks for the update!
> >
> > > --- a/Documentation/devicetree/bindings/dma/renesas,rz-dmac.yaml
> > > +++ b/Documentation/devicetree/bindings/dma/renesas,rz-dmac.yaml
> > > @@ -61,14 +66,22 @@ properties:
> > >    '#dma-cells':
> > >      const: 1
> > >      description:
> > > -      The cell specifies the encoded MID/RID values of the DMAC port
> > > -      connected to the DMA client and the slave channel configuration
> > > -      parameters.
> > > +      For the RZ/A1H, RZ/Five, RZ/G2{L,LC,UL}, RZ/V2L, and RZ/G3S SoCs, the cell
> > > +      specifies the encoded MID/RID values of the DMAC port connected to the
> > > +      DMA client and the slave channel configuration parameters.
> > >        bits[0:9] - Specifies MID/RID value
> > >        bit[10] - Specifies DMA request high enable (HIEN)
> > >        bit[11] - Specifies DMA request detection type (LVL)
> > >        bits[12:14] - Specifies DMAACK output mode (AM)
> > >        bit[15] - Specifies Transfer Mode (TM)
> > > +      For the RZ/V2H(P) SoC the cell specifies the REQ NO, the ACK NO, and the
> > > +      slave channel configuration parameters.
> > > +      bits[0:9] - Specifies the REQ NO
> >
> > So REQ_NO is the new name for MID/RID.

These are documented in Table 4.7-22 ("DMA Transfer Request Detection
Operation Setting Table").

> It's certainly similar. I would say that REQ_NO + ACK_NO is the new MID_RID.
>
> > > +      bits[10:16] - Specifies the ACK NO
> >
> > This is a new field.
> > However, it is not clear to me which value to specify here, and if this
> > is a hardware property at all, and thus needs to be specified in DT?
>
> It is a HW property. The value to set can be found in Table 4.6-27 from
> the HW User Manual, column "Ack No".

Thanks, but that table only shows values for SPDIF, SCU, SSIU and PFC
(for external DMA requests).  The most familiar DMA clients listed
in Table 4.7-22 are missing.  E.g. RSPI0 uses REQ_NO 0x8C/0x8D, but
which values does it need for ACK_NO?

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

