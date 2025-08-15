Return-Path: <dmaengine+bounces-6031-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 671AFB273FF
	for <lists+dmaengine@lfdr.de>; Fri, 15 Aug 2025 02:34:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0FB0B1CE4064
	for <lists+dmaengine@lfdr.de>; Fri, 15 Aug 2025 00:32:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B669835962;
	Fri, 15 Aug 2025 00:27:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b="nUJUSTOA"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-yb1-f171.google.com (mail-yb1-f171.google.com [209.85.219.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA71D1E89C
	for <dmaengine@vger.kernel.org>; Fri, 15 Aug 2025 00:26:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755217621; cv=none; b=ir8HErbHaT/g0IBPw6LrPhMVAvPizjaip0M+u9p6xXQENMg47D4BpKYh/GL+GCkOmNtmZ9Qb2aPDJ+mekN6or12rVV/YpnnjSAW13OfpjktTrq+khu9gFYkgnoFcn6xGevD+tUW7jdN/QTYEy/89kvqIZdUIgxykRp5lTb/iQZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755217621; c=relaxed/simple;
	bh=zqCXdHxKTeKB9ROaf4knn6ibcDXe7aVLUkOaaUaIpUs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pOg8wAcesiGOmNZzhWkaI+OYI5F9u/eSpjJv90HjtQ+26Ugwvl9zVa8Fuu3LwnaWSFMIU1Rvo044qEE58TNejDThDpUA62wTd7MiHXMdd1piv51D6Q+LTEzMK61EwOeinTVh0LZJXJW4o1v3v6e/NyMK+OAWk34iAs6zKbdLBSg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com; spf=pass smtp.mailfrom=riscstar.com; dkim=pass (2048-bit key) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b=nUJUSTOA; arc=none smtp.client-ip=209.85.219.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=riscstar.com
Received: by mail-yb1-f171.google.com with SMTP id 3f1490d57ef6-e931cb0385eso1381398276.1
        for <dmaengine@vger.kernel.org>; Thu, 14 Aug 2025 17:26:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=riscstar-com.20230601.gappssmtp.com; s=20230601; t=1755217619; x=1755822419; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=chtqaOACUmcKvoVs4ArIxzTVDCSfAD6YVqxbH3Chc5Y=;
        b=nUJUSTOAs8ofB9Chw42tcJx+26/UsXLyGbUe/8K6vMo/Lct98PHXgZZfZvtMJqSbPR
         6tg/8fegJ+48xpl1f7sXIyQaR+rd9cWXYgC8iG1Vb2mNvqpANDU9+hi/s1fi9ZhjA0Qg
         XGSPXFfAvwJmZOJjF1yvDBuuAEZekIwFeiU3+3rwba6e4KDqQxNJeM8nU8XVpVAjdM0H
         KRJqWAMg/Ge2zMR3ejIH5HTXUIEjrpPE8dRSfep+tF66exgkZUSr7sW6qWNj2rybNTmf
         s6mHP8Yqf0Xunh+m7UOhZFmrHDavWpxsMgHs/3DiSFG7zj7AOfqx4KgSkQZwv3DD5OzE
         xHzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755217619; x=1755822419;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=chtqaOACUmcKvoVs4ArIxzTVDCSfAD6YVqxbH3Chc5Y=;
        b=dNYRDN8wqb4qm2X7sKUxw7rSSE6GBqX/p+y9RQcnJJ6n9z2gxgWFwU+1u5APU4ffBn
         3oW134PwirZ1ks1WtZPkUI7zoaiTjjLYkbiw/Uacpk2NrCftmEwOByH3grHYDQWI2LqO
         me3gU3nXR7vc9xCmCONUGICwJGd5fiDYOyJoNDVWtXP0YDUjh4oxe3G2wj/HfnBT5Wb7
         ZnW3KxCriTM5PEsq3HIBMYT9Dv+UQHKrLQWD0i95Gf6nKMVMw5D1mmQ/MXz1eDA7KMWt
         UBshh2qzv8dvPA9U014AzqWWMk6jNMusb7g+POX/G+chsHATEm/5t28H7dZUpyWKyJ21
         VVZw==
X-Forwarded-Encrypted: i=1; AJvYcCVoEbboEfR3k6MBfFMOt/VIO4mKFBD/Xv0ykka6DEGXdy5QXNiLHyEomqCab41IwXoDhYEByo3utiQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxcibJ0qOXsbflqJfevlHXsVUx06cSElug1M/U/bsR9X0RAaXjO
	jMF96hcTIV08GUXN7DYX7eRLHt8MghnnDmkmYyvYlcUkvBYLgbzGAb0uz01bgQuN6s1rL2oMySB
	NxQ22Z3253nUQK8r+Z17lVM1uE3yfk55NDFqNKlYlCPeaECUrE6/kTfhXig==
X-Gm-Gg: ASbGnctSZTRzeogzeecgjx1W1UbJ1euQX74K9WgDPfW71sdyxCDiVq4oUCg4lUjJCWv
	6mGlsF6UynfKCTeBQT1MRYJM2xH/1bc/WpAMTS3dk9XhEuuJeOB+nv3a1eZEI+KqARrsASgN9oR
	Ow2vHxoT5F1JEDnj7rAe9VVZhIBMPX7Gx7whndSOGSN5ewRgEJWgVKWuIZFGiDJ5azDzxlBFpUI
	nx5fPfV
X-Google-Smtp-Source: AGHT+IFyC6XchyD488oOCFrdXunJc7qGIapZSIGWdcX99KZIq/zeH1vE8qmFombtGx4qUvJV13AHJXqkXJEjvfp+pqA=
X-Received: by 2002:a05:6902:2b8b:b0:e90:637a:cb36 with SMTP id
 3f1490d57ef6-e933235e5e4mr362916276.6.1755217618710; Thu, 14 Aug 2025
 17:26:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250714-working_dma_0701_v2-v3-0-8b0f5cd71595@riscstar.com>
 <20250714-working_dma_0701_v2-v3-6-8b0f5cd71595@riscstar.com> <20250724121916-GYA748228@gentoo>
In-Reply-To: <20250724121916-GYA748228@gentoo>
From: Guodong Xu <guodong@riscstar.com>
Date: Fri, 15 Aug 2025 08:26:47 +0800
X-Gm-Features: Ac12FXyMVuK9-KHf4Hpw5gXtsQxmq2I0BGB7NnpjNngaho2sXqjxjvKEDgl5mV0
Message-ID: <CAH1PCMZejR5AxmJC1mRi7KSAXEtOQzfSD99G8+0PFbbASJxW-A@mail.gmail.com>
Subject: Re: [PATCH v3 6/8] riscv: dts: spacemit: Add PDMA0 node for K1 SoC
To: Yixun Lan <dlan@gentoo.org>
Cc: Vinod Koul <vkoul@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	=?UTF-8?Q?Duje_Mihanovi=C4=87?= <duje.mihanovic@skole.hr>, 
	Philipp Zabel <p.zabel@pengutronix.de>, Paul Walmsley <paul.walmsley@sifive.com>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Alexandre Ghiti <alex@ghiti.fr>, Alex Elder <elder@riscstar.com>, 
	Vivian Wang <wangruikang@iscas.ac.cn>, dmaengine@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-riscv@lists.infradead.org, spacemit@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 24, 2025 at 8:19=E2=80=AFPM Yixun Lan <dlan@gentoo.org> wrote:
>
> Hi Guodong,
>
> On 17:39 Mon 14 Jul     , Guodong Xu wrote:
> > Add PDMA0 dma-controller node under dma_bus for SpacemiT K1 SoC.
> >
> > The PDMA0 node is marked as disabled by default, allowing board-specifi=
c
> > device trees to enable it as needed.
> >
> > Signed-off-by: Guodong Xu <guodong@riscstar.com>
> > ---
> > v3:
> > - adjust pdma0 position, ordering by device address
> > - update properties according to the newly created schema binding
> > v2:
> > - Updated the compatible string.
> > - Rebased. Part of the changes in v1 is now in this patchset:
> >    - "riscv: dts: spacemit: Add DMA translation buses for K1"
> >    - Link: https://lore.kernel.org/all/20250623-k1-dma-buses-rfc-wip-v1=
-0-c0144082061f@iscas.ac.cn/
> > ---
> >  arch/riscv/boot/dts/spacemit/k1.dtsi | 11 +++++++++++
> >  1 file changed, 11 insertions(+)
> >
> > diff --git a/arch/riscv/boot/dts/spacemit/k1.dtsi b/arch/riscv/boot/dts=
/spacemit/k1.dtsi
> > index abde8bb07c95c5a745736a2dd6f0c0e0d7c696e4..46dc002af947893cc2c234e=
e61e63c371cd966ca 100644
> > --- a/arch/riscv/boot/dts/spacemit/k1.dtsi
> > +++ b/arch/riscv/boot/dts/spacemit/k1.dtsi
> > @@ -660,6 +660,17 @@ dma-bus {
> >                       dma-ranges =3D <0x0 0x00000000 0x0 0x00000000 0x0=
 0x80000000>,
> >                                    <0x1 0x00000000 0x1 0x80000000 0x3 0=
x00000000>;
> >
> > +                     pdma0: dma-controller@d4000000 {
> does K1 has more than one pdma controller? No? as I checked..
> so, I'd suggest simply naming it as 'pdma' - which clear the confusion
> that there will be more than one pdma nodes..
>

Thanks Yixun. I will name it 'pdma'.

> > +                             compatible =3D "spacemit,k1-pdma";
> > +                             reg =3D <0x0 0xd4000000 0x0 0x4000>;
> ..
> > +                             interrupts =3D <72>;
> for consistency in this dtsi file, I'd suggest moving "interrupts" after =
"clocks",
> or even after "resets"? leave "clocks & resets" together..
>

That makes sense. Will do.

Thanks.
Guodong


> > +                             clocks =3D <&syscon_apmu CLK_DMA>;
> > +                             resets =3D <&syscon_apmu RESET_DMA>;
> > +                             dma-channels =3D <16>;
> > +                             #dma-cells=3D <1>;
> > +                             status =3D "disabled";
> > +                     };
> > +
> >                       uart0: serial@d4017000 {
> >                               compatible =3D "spacemit,k1-uart",
> >                                            "intel,xscale-uart";
> >
> > --
> > 2.43.0
> >
>
> --
> Yixun Lan (dlan)

