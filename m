Return-Path: <dmaengine+bounces-6698-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E993B95CEF
	for <lists+dmaengine@lfdr.de>; Tue, 23 Sep 2025 14:18:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 040DC163C60
	for <lists+dmaengine@lfdr.de>; Tue, 23 Sep 2025 12:18:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48825313D48;
	Tue, 23 Sep 2025 12:18:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="OLUTESS1"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-106104.protonmail.ch (mail-106104.protonmail.ch [79.135.106.104])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BFF119258E
	for <dmaengine@vger.kernel.org>; Tue, 23 Sep 2025 12:18:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.135.106.104
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758629890; cv=none; b=Zoh4KLBLO8QgANXEE9osF13Mmc8oaUo5XBQHirHyg4jOZYrlDZQzYyUt+19xu0/FA4tyTAuD31jZ4zE2GBqBh9sUE43V0onOK5n54XFheOqSEVMnOw1Y3WPqPygJJ4ZEfKc1JNBZrt108nudwfN7tZKaVQaUSdf2LNS7Ry01RTA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758629890; c=relaxed/simple;
	bh=fgbwTeN4mBqznS0b5v+G7eAnKEwgbBFcZpWyDDDQBEA=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GbZiBOKhw37qlaYWEoNlmIBoBMaQ+QX9SyIym3/SzR3smOidTPQgqb0gbRgz8NprUEpxFMk+TsRzKJwHhZKVzWzTD8slVIVfUYlEZdB9ZsgvAU0dmT5id8Y5mfm965p3A4EIqHQstosgjYWnEDofqYThE87Igm0xHGGq7K2qfU0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=OLUTESS1; arc=none smtp.client-ip=79.135.106.104
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1758629879; x=1758889079;
	bh=fgbwTeN4mBqznS0b5v+G7eAnKEwgbBFcZpWyDDDQBEA=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=OLUTESS1EIxO5wu69Pkg4FbXF0V50+VJj0phn3kui/Cp1rvKW3llyCRylXo3fQsuf
	 zcYc+UTZovXCAxdJpPBfMYqjK6oRL/v8DVbbL03AfIBK7vjyytYzaF0MNyMEe9Ghp7
	 MfjMIVJCsIH/SHVOFrttuZINLZ/GoJPzZfq2qAws+3zu4MVrhN+uWTV8gB0ELCMTTT
	 V7kOD+bnYMP1nqb1xkgRtgWIWhAbT0OoY3JBZFps+1dv4vOhJcWi7/yVoDPJuZQijT
	 hIE4grV89D6Wk7Vm/AY1E4hKhKD2bVS9muXjrdVq6k/AjLlMCgs7G9LieiJ0Fm27Z1
	 27E6xIiNet1ug==
Date: Tue, 23 Sep 2025 12:17:45 +0000
To: Rob Herring <robh@kernel.org>
From: Max Shevchenko <wctrl@proton.me>
Cc: "sean.wang@mediatek.com" <sean.wang@mediatek.com>, "vkoul@kernel.org" <vkoul@kernel.org>, "krzk+dt@kernel.org" <krzk+dt@kernel.org>, "conor+dt@kernel.org" <conor+dt@kernel.org>, "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>, "angelogioacchino.delregno@collabora.com" <angelogioacchino.delregno@collabora.com>, "long.cheng@mediatek.com" <long.cheng@mediatek.com>, "dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-mediatek@lists.infradead.org" <linux-mediatek@lists.infradead.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/3] dt-bindings: dma: mediatek,uart-dma: drop mediatek,dma-33bits property
Message-ID: <OqrpnP1RyPRyuNfMPA0kXp64iZ1Q5a0ZDMKXz4xmzcg9U7s9SvEvuo1jmiNAwTCgCibt0r1EafrFMwj-ML0ByUC1nsh5ZVbsY1pfOF7pzq8=@proton.me>
In-Reply-To: <20250922204756.GA1294776-robh@kernel.org>
References: <20250921-uart-apdma-v1-0-107543c7102c@proton.me> <20250921-uart-apdma-v1-1-107543c7102c@proton.me> <20250922204756.GA1294776-robh@kernel.org>
Feedback-ID: 131238559:user:proton
X-Pm-Message-ID: ea64799d345eab79b1e8b6edd13a26df9a410340
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Monday, September 22nd, 2025 at 11:47 PM, Rob Herring <robh@kernel.org> =
wrote:

> On Sun, Sep 21, 2025 at 02:03:40PM +0300, Max Shevchenko wrote:
>=20
> > Many newer SoCs support more than 33 bits for DMA.
> > Drop the property in order to switch to the platform data.
> >=20
> > The reference SoCs were taken from the downstream kernel (6.6) for
> > the MT6991 SoC.
> >=20
> > Signed-off-by: Max Shevchenko wctrl@proton.me
> > ---
> > Documentation/devicetree/bindings/dma/mediatek,uart-dma.yaml | 11 ++++-=
------
> > 1 file changed, 4 insertions(+), 7 deletions(-)
> >=20
> > diff --git a/Documentation/devicetree/bindings/dma/mediatek,uart-dma.ya=
ml b/Documentation/devicetree/bindings/dma/mediatek,uart-dma.yaml
> > index dab468a88942d694525aa391f695c44d192f0c42..9dfdfe81af7edbe3540e4b7=
57547a5d5e6ae810c 100644
> > --- a/Documentation/devicetree/bindings/dma/mediatek,uart-dma.yaml
> > +++ b/Documentation/devicetree/bindings/dma/mediatek,uart-dma.yaml
> > @@ -22,12 +22,14 @@ properties:
> > - items:
> > - enum:
> > - mediatek,mt2712-uart-dma
> > - - mediatek,mt6795-uart-dma
> > - mediatek,mt8365-uart-dma
> > - mediatek,mt8516-uart-dma
> > - const: mediatek,mt6577-uart-dma
> > - enum:
> > - - mediatek,mt6577-uart-dma
> > + - mediatek,mt6577-uart-dma # 32 bits
> > + - mediatek,mt6795-uart-dma # 33 bits
>=20
>=20
> Unless all existing s/w supported mediatek,mt6795-uart-dma, you just
> broke this platform which was relying on the fallback compatible.
>=20


As of v6.17-rc6 and linux-next 20250922, the only user of the
mediatek,mt6795-uart-dma compatible is the MT6795 itself, which also
uses the mediatek,dma-33bits property. The second patch makes driver
to set the DMA bitmask based on the compatible.
Therefore I don't think it breaks the platform.

> > + - mediatek,mt6779-uart-dma # 34 bits
> > + - mediatek,mt6985-uart-dma # 35 bits
> >=20
> > reg:
> > minItems: 1
> > @@ -56,10 +58,6 @@ properties:
> > Number of virtual channels of the UART APDMA controller
> > maximum: 16
> >=20
> > - mediatek,dma-33bits:
> > - type: boolean
> > - description: Enable 33-bits UART APDMA support
>=20
>=20
> If this is in use, you need to mark it 'deprecated' instead.
>=20


The same question here, third patch removes this property from its
sole user. Does it actually need to be marked as deprecated and
not deleted?

> > -
> > required:
> > - compatible
> > - reg
> > @@ -116,7 +114,6 @@ examples:
> > dma-requests =3D <12>;
> > clocks =3D <&pericfg CLK_PERI_AP_DMA>;
> > clock-names =3D "apdma";
> > - mediatek,dma-33bits;
> > #dma-cells =3D <1>;
> > };
> > };
> >=20
> > --
> > 2.51.0

Sincerely,
Max

