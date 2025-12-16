Return-Path: <dmaengine+bounces-7707-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B53D7CC4878
	for <lists+dmaengine@lfdr.de>; Tue, 16 Dec 2025 18:04:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id DF4D9302AAD6
	for <lists+dmaengine@lfdr.de>; Tue, 16 Dec 2025 17:02:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F10392D7DE3;
	Tue, 16 Dec 2025 17:01:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sartura.hr header.i=@sartura.hr header.b="N6pxMkEd"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE1C6311596
	for <dmaengine@vger.kernel.org>; Tue, 16 Dec 2025 17:01:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765904477; cv=none; b=sQWSCiTL8nLaPcrOfTGQPUWxpvwEoelYcw6AAtn+97hUYGqUkcW0o3r6VkWO3uac7qHgEaVWiZwdpAfZBQ2Kaour6uOyUhe/0nsz7nNsU87LysyVA44W6IyW7ShEHMSIyu1ysA/cisNqK2A5XsR4QkzBBuE4pbGmTcMRV06VYQk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765904477; c=relaxed/simple;
	bh=FwQQU5q3mw9YrloIZOuHcsfzqU/fokbOnsPKngY00gM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZCgate5WG5w8yNX2u0p2YeIRqHoZ0tC8SlM7IJBFDmD7WZeyHd6d9AsmhtlvxRoSCblC/5xHNWXOe1r/2hQxParMxEbql8NOt9YuqwISrVY/09WP7itDPD6wZOh3UdP/zV0sumBbtie8RPnRV9YJN+Apc1LINMSNQ93Nssg4gNM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sartura.hr; spf=pass smtp.mailfrom=sartura.hr; dkim=pass (2048-bit key) header.d=sartura.hr header.i=@sartura.hr header.b=N6pxMkEd; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sartura.hr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sartura.hr
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-b79d6a70fc8so849546966b.0
        for <dmaengine@vger.kernel.org>; Tue, 16 Dec 2025 09:01:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sartura.hr; s=sartura; t=1765904474; x=1766509274; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=j4BVhGwuqRhR0h5Wvfr3twMpRndihHjDu8cj/PGuiBM=;
        b=N6pxMkEdCE0zY7b8qXrbJEKlw/BdW8A6uV0nIShekTo1OJUHTIjkrgZEannuSYp4iD
         e4qkQOSmjfWADxiRkmXy96eLZp7PPAMSbWW706pULdpF3hdR86gFrdVNe14lwhyDrIM5
         JLCQyN5Fr97W3mXlw6qrmrUKtExVoLgzPigg9cZri0jlrIbZRluWsp2Zyd4Z6s/a5QOb
         C/82TmhhKHa1Nr3dLmXjnHDcory67KfhO8yAX92h6NJamErUr6XHFF4sJPZuo4+625Db
         XPmEPl+1VdMm3tDvSlaFgKS5KWihV3PvA4DPbxkdVsvVtVyjR9XTjpemrRuZGNl00nBL
         5hhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765904474; x=1766509274;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=j4BVhGwuqRhR0h5Wvfr3twMpRndihHjDu8cj/PGuiBM=;
        b=RrbgcEQKoFQr/JLtcB0UNdKT94Qcu1Kzc9dV3fgydhHg1AKmwShIArR4OKrh9hHI3M
         JApSPmrimRnGD4KHynWm4TlxRA3Mu+kY2sQvLmYO44wp7e//dQuEwu3jkHZ26r6VdafA
         2SXgqodhZ9ueU4prXYYz0tXzoOJ4SqNML1EKjpSQRPsRcWvnq5Z0K7EIfGWQVpCDMVNb
         r6qQtNSsN8wdPvoCEn8i0ju6Bo08GjOy2PL8ZcJc9BMg9W8FEqSA5sXaQS4gwHUYjRQk
         OwG/38jYCqNcXASnofSo23PPOlEn/VSxwduHK0JalGBd7IC1mdSJ7A9vYoscv9Pe3Ydt
         ksGQ==
X-Forwarded-Encrypted: i=1; AJvYcCXOcXRTf8iAg/JeJdcp0OTmXbxhITQN9j/4cX+Q0HJtuWlFb1/5RVVaSpa5EAVSj5wgI/HxE1Vuaww=@vger.kernel.org
X-Gm-Message-State: AOJu0YyXx4MGMKeAScp293xZ8FlWay8wd5ixIeF+Mp+tZiVIFpNANTT/
	sRuPWYTFAeiRiUEB6dRxd8Gh2vFUyqwGENMRqDtn4w3ORNb3mVbxjK1AHGip3AhiQvqSn9R7BzB
	DpnTJ0OUIOebUhPettxIIweCvgIT8aJwms9wERhXkSA==
X-Gm-Gg: AY/fxX5h8AnEUFbLVFUvMNhBhV95mekrmzVaGukCG3J2+2qC0vcyKLhT3Rj2m+krjt/
	7EzEdZ1MrQo7t8UwgbNl5zLn6MWylcv/JHiDyoyvl1bW4eOXr8SeKQQHxiTO8k2fEXajfW4aslj
	jQbB7/DrcY6yAKuKU1vn+rZjlqIYkXCTJBSN4twuFNhQ/NTXjY7Ww+JEvHOVaN9Pt9NiM1h79fi
	g6IrAPBkgp2gvmpo5p7xBKX9DuaPpXd50eByLY9Rc9ii8T2iWX40OLtlTo4nWkMKu4kFnt9
X-Google-Smtp-Source: AGHT+IFgWHsN8Jt+GNNh/GtbzMrps7YuiUN4HCSjrLSYBUNl98CacMkEeJqhHxiowRyslb2rMUAVRC886sKdRRnuksE=
X-Received: by 2002:a17:907:608c:b0:b74:352d:6dc1 with SMTP id
 a640c23a62f3a-b7d236b61b4mr1684820166b.28.1765904473954; Tue, 16 Dec 2025
 09:01:13 -0800 (PST)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251215163820.1584926-1-robert.marko@sartura.hr>
 <20251215163820.1584926-5-robert.marko@sartura.hr> <fe15fcce-865a-4969-9b6f-95920fcaa5c7@kernel.org>
In-Reply-To: <fe15fcce-865a-4969-9b6f-95920fcaa5c7@kernel.org>
From: Robert Marko <robert.marko@sartura.hr>
Date: Tue, 16 Dec 2025 18:01:02 +0100
X-Gm-Features: AQt7F2oP6MyGEflW0Nvuzwrgr5iXWpqv_VRgduC1yuFaCXQ7imivVtKDExK377E
Message-ID: <CA+HBbNGNMGRL11kdg14LwkiTazXJYXOZeVCKsmW6-XF6k5+sVA@mail.gmail.com>
Subject: Re: [PATCH v2 05/19] dt-bindings: arm: microchip: move SparX-5 to
 generic Microchip binding
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, 
	nicolas.ferre@microchip.com, alexandre.belloni@bootlin.com, 
	claudiu.beznea@tuxon.dev, Steen.Hegelund@microchip.com, 
	daniel.machon@microchip.com, UNGLinuxDriver@microchip.com, 
	herbert@gondor.apana.org.au, davem@davemloft.net, vkoul@kernel.org, 
	linux@roeck-us.net, andi.shyti@kernel.org, lee@kernel.org, 
	andrew+netdev@lunn.ch, edumazet@google.com, kuba@kernel.org, 
	pabeni@redhat.com, linusw@kernel.org, olivia@selenic.com, 
	radu_nicolae.pirea@upb.ro, richard.genoud@bootlin.com, 
	gregkh@linuxfoundation.org, jirislaby@kernel.org, mturquette@baylibre.com, 
	sboyd@kernel.org, richardcochran@gmail.com, wsa+renesas@sang-engineering.com, 
	romain.sioen@microchip.com, Ryan.Wanner@microchip.com, 
	lars.povlsen@microchip.com, tudor.ambarus@linaro.org, 
	charan.pedumuru@microchip.com, kavyasree.kotagiri@microchip.com, 
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org, 
	dmaengine@vger.kernel.org, linux-hwmon@vger.kernel.org, 
	linux-i2c@vger.kernel.org, netdev@vger.kernel.org, linux-gpio@vger.kernel.org, 
	linux-spi@vger.kernel.org, linux-serial@vger.kernel.org, 
	linux-usb@vger.kernel.org, linux-clk@vger.kernel.org, mwalle@kernel.org, 
	luka.perkov@sartura.hr
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 16, 2025 at 4:58=E2=80=AFPM Krzysztof Kozlowski <krzk@kernel.or=
g> wrote:
>
> On 15/12/2025 17:35, Robert Marko wrote:
> > Now that we have a generic Microchip binding, lets move SparX-5 as well=
 as
> > there is no reason to have specific binding file for each SoC series.
> >
> > The check for AXI node was dropped.
>
> Why?

According to Conor, it is pointless [1]

[1] https://patchwork.kernel.org/project/linux-arm-kernel/patch/20251203122=
313.1287950-2-robert.marko@sartura.hr/#26691879

Regards,
Robert

>
> >
> > Signed-off-by: Robert Marko <robert.marko@sartura.hr>
> > ---
> >  .../bindings/arm/microchip,sparx5.yaml        | 67 -------------------
> >  .../devicetree/bindings/arm/microchip.yaml    | 22 ++++++
> >  2 files changed, 22 insertions(+), 67 deletions(-)
> >  delete mode 100644 Documentation/devicetree/bindings/arm/microchip,spa=
rx5.yaml
> >
> > diff --git a/Documentation/devicetree/bindings/arm/microchip,sparx5.yam=
l b/Documentation/devicetree/bindings/arm/microchip,sparx5.yaml
> > deleted file mode 100644
> > index 9a0d54e9799c..000000000000
> > --- a/Documentation/devicetree/bindings/arm/microchip,sparx5.yaml
> > +++ /dev/null
> > @@ -1,67 +0,0 @@
> > -# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > -%YAML 1.2
> > ----
> > -$id: http://devicetree.org/schemas/arm/microchip,sparx5.yaml#
> > -$schema: http://devicetree.org/meta-schemas/core.yaml#
> > -
> > -title: Microchip Sparx5 Boards
> > -
> > -maintainers:
> > -  - Lars Povlsen <lars.povlsen@microchip.com>
> > -
> > -description: |+
> > -   The Microchip Sparx5 SoC is a ARMv8-based used in a family of
> > -   gigabit TSN-capable gigabit switches.
> > -
> > -   The SparX-5 Ethernet switch family provides a rich set of switching
> > -   features such as advanced TCAM-based VLAN and QoS processing
> > -   enabling delivery of differentiated services, and security through
> > -   TCAM-based frame processing using versatile content aware processor
> > -   (VCAP)
> > -
> > -properties:
> > -  $nodename:
> > -    const: '/'
> > -  compatible:
> > -    oneOf:
> > -      - description: The Sparx5 pcb125 board is a modular board,
> > -          which has both spi-nor and eMMC storage. The modular design
> > -          allows for connection of different network ports.
> > -        items:
> > -          - const: microchip,sparx5-pcb125
> > -          - const: microchip,sparx5
> > -
> > -      - description: The Sparx5 pcb134 is a pizzabox form factor
> > -          gigabit switch with 20 SFP ports. It features spi-nor and
> > -          either spi-nand or eMMC storage (mount option).
> > -        items:
> > -          - const: microchip,sparx5-pcb134
> > -          - const: microchip,sparx5
> > -
> > -      - description: The Sparx5 pcb135 is a pizzabox form factor
> > -          gigabit switch with 48+4 Cu ports. It features spi-nor and
> > -          either spi-nand or eMMC storage (mount option).
> > -        items:
> > -          - const: microchip,sparx5-pcb135
> > -          - const: microchip,sparx5
> > -
> > -  axi@600000000:
> > -    type: object
> > -    description: the root node in the Sparx5 platforms must contain
> > -      an axi bus child node. They are always at physical address
> > -      0x600000000 in all the Sparx5 variants.
> > -    properties:
> > -      compatible:
> > -        items:
> > -          - const: simple-bus
> > -
> > -    required:
> > -      - compatible
> > -
> > -required:
> > -  - compatible
> > -  - axi@600000000
>
> Nothing explains the rationale for doing this.
>
> Best regards,
> Krzysztof



--=20
Robert Marko
Staff Embedded Linux Engineer
Sartura d.d.
Lendavska ulica 16a
10000 Zagreb, Croatia
Email: robert.marko@sartura.hr
Web: www.sartura.hr

