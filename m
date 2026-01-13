Return-Path: <dmaengine+bounces-8237-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 95F11D1B284
	for <lists+dmaengine@lfdr.de>; Tue, 13 Jan 2026 21:10:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 37E863043932
	for <lists+dmaengine@lfdr.de>; Tue, 13 Jan 2026 20:09:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 096AA38B7A0;
	Tue, 13 Jan 2026 20:09:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sartura.hr header.i=@sartura.hr header.b="zIz8nYJt"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD9D8369960
	for <dmaengine@vger.kernel.org>; Tue, 13 Jan 2026 20:09:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768334995; cv=none; b=DZQ8ds6NwYfl5Ja7ltxHedpWUJ2tigPoL3DvaKZ8XyM96SF0KiwenLmlBn8Y0kS5imi9xBQ9atKcCDy/HD84l5cfOcqEf321vWoZb5al2DB8JoFeOuKZeQi6d/GuSML1dum2YTHHZL6QeWD2TtaDtaHpeG7Uof2D10f6V4pTjm8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768334995; c=relaxed/simple;
	bh=pyMp5oFQEzQGlgpWodh5m5sUhmJKSJMmcF9EpqTle4o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ixXeueN/SEFzSezfOCIJqo/jqAmNd0SsohAtbUvo8qMisjsAnZYZuj8AFiHkzxMioz0p/KVnmfEn/U6RHyuEwGRPVyX+dzhDFmZnE3DRyt1IdqGq30wWUHV9+XTQ+E7xrNPq1C42UhEKexSZP44+gaODLJREiahvU1tfQzRgxYk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sartura.hr; spf=pass smtp.mailfrom=sartura.hr; dkim=pass (2048-bit key) header.d=sartura.hr header.i=@sartura.hr header.b=zIz8nYJt; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sartura.hr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sartura.hr
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-b87003e998bso31426166b.1
        for <dmaengine@vger.kernel.org>; Tue, 13 Jan 2026 12:09:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sartura.hr; s=sartura; t=1768334991; x=1768939791; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=X3PB19UpbesWMeT0R3+l59gQeDUb0GCMAUDX3FFcChs=;
        b=zIz8nYJtuj84rCwrR4h2rYUNtQy0kQi3Vs6Pa4eyUFvYBSmR3JdcK91Z5LcbNLJJbd
         KBv1zpWpctONSZSIZfox4XBRJ3RoOniV3X3ufcycnUMgiQws9qL2iJTLfcYz/6ywcGtF
         IEbL5rTF894Idp+8ULCgygVGYo7r2T+AndIh1IP7v3vgatT1IQO43J17idGJA2xunR2Y
         7fJ9k/8LfGQoxc/GCDnq0d/fOOs+esgxOp4GdBC/tXJBsPbMEB8jlL/iIMNJVyMCIozF
         aMqv/iMccUIy3JOOqaYhzVETvgeYFGAbN22kE3vQ40Dtdd6YFQhBIm6KtULuMQfYbl9n
         eBaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768334991; x=1768939791;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=X3PB19UpbesWMeT0R3+l59gQeDUb0GCMAUDX3FFcChs=;
        b=jffMDONFSeTK5CcE4WzUj7Em8I4AA3pZBk6+iUA0VocP2Sw7vD4APc4oUwAHs4k6XD
         ynYV3iIUYSkLUKiY0sNw1+VNjbmgB6ZMuU9pb0UdheNqQoAp6ebsC7FQv2XPzSom/tth
         j6nq+t4dWTlTcueiSEvhTYkXjEkvNE1ydwYrPu72tkDMMj/gNHzyQJW1JcdN/Iiynt3P
         CAAB+C8fTKCHz0cLd6tfY/aNOs3AUFKJSc99V5azXxF5MQdd0LLaQtsKLEEzAiNmlUqG
         jT+EaJ32Et+G5XOMW79OCpsWRDnMNEWyMNjovJt9wZEjzkeQNOPs5czxaBVC4AtHwnAc
         7uyA==
X-Forwarded-Encrypted: i=1; AJvYcCUSwb18XglutPIYhM49k0SF15xlpL0c7GiAdF+mydLd1UTiX5o/vYUGQG1yK7neuvNIAkNvOIFhZpM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz5Ax0nQLDlMOmFS64/jQyk4GZODup5jCMuer93NStWeDM7WB6h
	rJnJRKIryo1dzJwae7S6X4h/oCotLNOchLs+kJf/4B9bW9EPPCH6TuvtQPX5V6QR0YtIrIDDqM2
	3q+o+IUWOmPobFpRNJDPnAhCmwUWh531uabJnoTtoYg==
X-Gm-Gg: AY/fxX6R/ezoNzbuXb21yhGbheZA+dKTAaGPQeatDFrq8xxdCqc+ks58dWX3VDjMxjX
	bVs9WYVNfqiY6U6vjVcKG26lwTD++CpzdU3Z0zw7CnVHA6MPuB7TWqqxuMocjHWxPmeeGjssJjk
	2uKRma7wp/OOMMH5AoA9UJtgp7OiVe/eXRdf5K4BtTfq2lrF06xvlyahU5IJ0G+m73kQCP6hwOO
	IKmDY/mlAdhascYXTUFHGNS7lj/qVvzIFfgAIX5w2aTnUfmBnws2yirv2kMDzPulR3cbcsJYK/W
	GjTtNkmumASg0nD3mq6TddDYSvWbB34mbjSUbA0ZLvTKRgBNHMVoIXdF7Kbj
X-Received: by 2002:a17:907:9483:b0:b87:191f:4fab with SMTP id
 a640c23a62f3a-b8761d928b1mr18947166b.26.1768334991113; Tue, 13 Jan 2026
 12:09:51 -0800 (PST)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251229184004.571837-1-robert.marko@sartura.hr>
 <20251229184004.571837-16-robert.marko@sartura.hr> <858ca139-61c5-45e3-a2c9-d0af414e3592@tuxon.dev>
In-Reply-To: <858ca139-61c5-45e3-a2c9-d0af414e3592@tuxon.dev>
From: Robert Marko <robert.marko@sartura.hr>
Date: Tue, 13 Jan 2026 21:09:40 +0100
X-Gm-Features: AZwV_QhCSNrQ25JXSm6moAYHvYjCfUUDQoR1FC1MV_mP0oSiXaM4vWsMWx6MKV0
Message-ID: <CA+HBbNFYBhtvUxd45O7eP_1JYENxeGZOkA+yUsEdztOSSi9Gdg@mail.gmail.com>
Subject: Re: [PATCH v4 15/15] arm64: dts: microchip: add EV23X71A board
To: claudiu beznea <claudiu.beznea@tuxon.dev>
Cc: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, 
	nicolas.ferre@microchip.com, alexandre.belloni@bootlin.com, 
	herbert@gondor.apana.org.au, davem@davemloft.net, vkoul@kernel.org, 
	andi.shyti@kernel.org, lee@kernel.org, andrew+netdev@lunn.ch, 
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, linusw@kernel.org, 
	Steen.Hegelund@microchip.com, daniel.machon@microchip.com, 
	UNGLinuxDriver@microchip.com, olivia@selenic.com, radu_nicolae.pirea@upb.ro, 
	richard.genoud@bootlin.com, gregkh@linuxfoundation.org, jirislaby@kernel.org, 
	broonie@kernel.org, lars.povlsen@microchip.com, devicetree@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-crypto@vger.kernel.org, dmaengine@vger.kernel.org, 
	linux-i2c@vger.kernel.org, netdev@vger.kernel.org, linux-gpio@vger.kernel.org, 
	linux-spi@vger.kernel.org, linux-serial@vger.kernel.org, 
	linux-usb@vger.kernel.org, luka.perkov@sartura.hr
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Jan 11, 2026 at 3:42=E2=80=AFPM claudiu beznea <claudiu.beznea@tuxo=
n.dev> wrote:
>
> Hi, Robert,
>
> On 12/29/25 20:37, Robert Marko wrote:
> > Microchip EV23X71A is an LAN9696 based evaluation board.
> >
> > Signed-off-by: Robert Marko <robert.marko@sartura.hr>
> > ---
> > Changes in v2:
> > * Split from SoC DTSI commit
> > * Apply DTS coding style
> > * Enclose array in i2c-mux
> > * Alphanumericaly sort nodes
> > * Change management port mode to RGMII-ID
> >
> >   arch/arm64/boot/dts/microchip/Makefile        |   1 +
> >   .../boot/dts/microchip/lan9696-ev23x71a.dts   | 757 +++++++++++++++++=
+
> >   2 files changed, 758 insertions(+)
> >   create mode 100644 arch/arm64/boot/dts/microchip/lan9696-ev23x71a.dts
> >
> > diff --git a/arch/arm64/boot/dts/microchip/Makefile b/arch/arm64/boot/d=
ts/microchip/Makefile
> > index c6e0313eea0f..09d16fc1ce9a 100644
> > --- a/arch/arm64/boot/dts/microchip/Makefile
> > +++ b/arch/arm64/boot/dts/microchip/Makefile
> > @@ -1,4 +1,5 @@
> >   # SPDX-License-Identifier: GPL-2.0
> > +dtb-$(CONFIG_ARCH_LAN969X) +=3D lan9696-ev23x71a.dtb
> >   dtb-$(CONFIG_ARCH_SPARX5) +=3D sparx5_pcb125.dtb
> >   dtb-$(CONFIG_ARCH_SPARX5) +=3D sparx5_pcb134.dtb sparx5_pcb134_emmc.d=
tb
> >   dtb-$(CONFIG_ARCH_SPARX5) +=3D sparx5_pcb135.dtb sparx5_pcb135_emmc.d=
tb
> > diff --git a/arch/arm64/boot/dts/microchip/lan9696-ev23x71a.dts b/arch/=
arm64/boot/dts/microchip/lan9696-ev23x71a.dts
> > new file mode 100644
> > index 000000000000..435df455b078
> > --- /dev/null
> > +++ b/arch/arm64/boot/dts/microchip/lan9696-ev23x71a.dts
>
> [ ...]
>
> > +&gpio {
> > +     emmc_sd_pins: emmc-sd-pins {
> > +             /* eMMC_SD - CMD, CLK, D0, D1, D2, D3, D4, D5, D6, D7, RS=
TN */
> > +             pins =3D "GPIO_14", "GPIO_15", "GPIO_16", "GPIO_17",
> > +                    "GPIO_18", "GPIO_19", "GPIO_20", "GPIO_21",
> > +                    "GPIO_22", "GPIO_23", "GPIO_24";
> > +             function =3D "emmc_sd";
> > +     };
> > +
> > +     fan_pins: fan-pins {
> > +             pins =3D "GPIO_25", "GPIO_26";
> > +             function =3D "fan";
> > +     };
> > +
> > +     fc0_pins: fc0-pins {
> > +             pins =3D "GPIO_3", "GPIO_4";
> > +             function =3D "fc";
> > +     };
> > +
> > +     fc2_pins: fc2-pins {
> > +             pins =3D "GPIO_64", "GPIO_65", "GPIO_66";
> > +             function =3D "fc";
> > +     };
> > +
> > +     fc3_pins: fc3-pins {
> > +             pins =3D "GPIO_55", "GPIO_56";
> > +             function =3D "fc";
> > +     };
> > +
> > +     mdio_pins: mdio-pins {
> > +             pins =3D "GPIO_9", "GPIO_10";
> > +             function =3D "miim";
> > +     };
> > +
> > +     mdio_irq_pins: mdio-irq-pins {
> > +             pins =3D "GPIO_11";
> > +             function =3D "miim_irq";
> > +     };
> > +
> > +     sgpio_pins: sgpio-pins {
> > +             /* SCK, D0, D1, LD */
> > +             pins =3D "GPIO_5", "GPIO_6", "GPIO_7", "GPIO_8";
> > +             function =3D "sgpio_a";
> > +     };
> > +
> > +     usb_ulpi_pins: usb-ulpi-pins {
> > +             pins =3D "GPIO_30", "GPIO_31", "GPIO_32", "GPIO_33",
> > +                    "GPIO_34", "GPIO_35", "GPIO_36", "GPIO_37",
> > +                    "GPIO_38", "GPIO_39", "GPIO_40", "GPIO_41";
> > +             function =3D "usb_ulpi";
> > +     };
> > +
> > +     usb_rst_pins: usb-rst-pins {
> > +             pins =3D "GPIO_12";
> > +             function =3D "usb2phy_rst";
> > +     };
> > +
> > +     usb_over_pins: usb-over-pins {
> > +             pins =3D "GPIO_13";
> > +             function =3D "usb_over_detect";
> > +     };
> > +
> > +     usb_power_pins: usb-power-pins {
> > +             pins =3D "GPIO_1";
> > +             function =3D "usb_power";
> > +     };
> > +
> > +     ptp_out_pins: ptp-out-pins {
> > +             pins =3D "GPIO_58";
> > +             function =3D "ptpsync_4";
> > +     };
>
> Could you please move this one upper to have all the entries in the gpio
> container alphanumerically sorted?
>
> > +
> > +     ptp_ext_pins: ptp-ext-pins {
> > +             pins =3D "GPIO_59";
> > +             function =3D "ptpsync_5";
> > +     };
>
> Same here.

Sure, I will make sure that pin nodes are alphabetical (I found some
more that are not) in v5.

>
> [ ...]
>
> > +             port29: port@29 {
> > +                     reg =3D <29>;
> > +                     phys =3D <&serdes 11>;
> > +                     phy-handle =3D <&phy3>;
> > +                     phy-mode =3D "rgmii-id";
> > +                     microchip,bandwidth =3D <1000>;
>
> There are some questions around this node from Andrew in v1 of this serie=
s,
> which I don't see an answer for in any of the following versions. Could y=
ou
> please clarify?

Sure, as for the RGMII I switched to rgmii-id so the PHY is adding the dela=
ys.
Though, I am not sure if its better to add them via MAC as it can add
the delays instead of the PHY,
so I am open to suggestions here.

As for the phys property, yes that is not required here as RGMII ports
are dedicated, there are no
SERDES lanes being used for them.

I have updated the bindings to account for this and it will be part of v5.

Regards,
Robert

>
> The rest looks good to me.
>
> Thank you,
> Claudiu
>


--=20
Robert Marko
Staff Embedded Linux Engineer
Sartura d.d.
Lendavska ulica 16a
10000 Zagreb, Croatia
Email: robert.marko@sartura.hr
Web: www.sartura.hr

