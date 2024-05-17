Return-Path: <dmaengine+bounces-2064-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id F3BC68C8C46
	for <lists+dmaengine@lfdr.de>; Fri, 17 May 2024 20:36:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 80376B22093
	for <lists+dmaengine@lfdr.de>; Fri, 17 May 2024 18:36:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E829F4597F;
	Fri, 17 May 2024 18:36:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="XIVoHlL+"
X-Original-To: dmaengine@vger.kernel.org
Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [217.70.183.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5520A14273;
	Fri, 17 May 2024 18:36:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715970990; cv=none; b=flBvkatubHSpKBN26i8DIN20BBRJVgegV7luwTaZkAqDDmjmkwfm/WflBpvuLrKVg1bIeklgyyOb8Mb9D0Oqrqp6x0SRyZTH2kdXTCKG+8DvZbg8gYxYuF2rM9WInaMUDZLMbi+Jy71KkCjZrRt7PKvZVN8FTMAyfBfe3ixpLwU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715970990; c=relaxed/simple;
	bh=afHr6vcYGE6+c2wcjc3RuskM/1BHQYoKya2tnQkT3Tk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SbIxqRtbolRhIXC41UC+snnGpm1nHc7yCv+j3LixKyP6m+6U7+JdlhDi3J7WlfRXLcKEy+F7BtwshtXCI3zTe282hYu5WGy2fg8URZCb9KGAGt2K5tWCYCT8BXVQB2EHAw8p68cbF40zlzowcfII1MdRvXYDMQ74cI6InKgiMJo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=XIVoHlL+; arc=none smtp.client-ip=217.70.183.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 7048740004;
	Fri, 17 May 2024 18:36:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1715970986;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=aakjMiXrIK1SMo9a5spsETuysQuqYvFsuHtJGNipjLc=;
	b=XIVoHlL+HvLfXAVErilHWu7Ml5HtDRH+tBzVUn8AYOu5kOkUIIaaQUhc5cUzEu8wKW3ofY
	GS96wap5ixRrjAFlQpjwDAhKXSt1QkZIMT0BdQRZPYutWwaEFJ0HImnrkFJ6HcC9z+IwTP
	WDeWAfAGGzLlxppRzyFZc8qmlaMeghP7hY+wa06ozngQhfY5SBRh2mX/wbDWLFwiqfWzmq
	Bm9LlqkshhpMmVwVaIj22vqgFcqIGSmk+xloNklHiSfOEk0QNp0eXREBAKd9inQaOYVo9a
	jkG1DdO01MmGnbXh8jQX/Q3IuyprBJGju9Y0g/RaA02fXeCHxfc0fGmhvzNzRA==
Date: Fri, 17 May 2024 20:36:21 +0200
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Frank Li <Frank.Li@nxp.com>
Cc: Richard Weinberger <richard@nod.at>, Vignesh Raghavendra
 <vigneshr@ti.com>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski
 <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Han Xu
 <han.xu@nxp.com>, Vinod Koul <vkoul@kernel.org>, Shawn Guo
 <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, Pengutronix
 Kernel Team <kernel@pengutronix.de>, Fabio Estevam <festevam@gmail.com>,
 Marek Vasut <marex@denx.de>, linux-mtd@lists.infradead.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 dmaengine@vger.kernel.org, imx@lists.linux.dev,
 linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 1/5] dt-bindings: mtd: gpmi-nand: Add
 'fsl,imx8qxp-gpmi-nand' compatible string
Message-ID: <20240517203621.72b8b9c7@xps-13>
In-Reply-To: <20240517-gpmi_nand-v1-1-73bb8d2cd441@nxp.com>
References: <20240517-gpmi_nand-v1-0-73bb8d2cd441@nxp.com>
	<20240517-gpmi_nand-v1-1-73bb8d2cd441@nxp.com>
Organization: Bootlin
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-GND-Sasl: miquel.raynal@bootlin.com

Hi Frank,

Frank.Li@nxp.com wrote on Fri, 17 May 2024 14:09:48 -0400:

> Add 'fsl,imx8qxp-gpmi-nand' compatible string and clock-names restriction.
>=20
> Signed-off-by: Frank Li <Frank.Li@nxp.com>
> ---
>  .../devicetree/bindings/mtd/gpmi-nand.yaml         | 22 ++++++++++++++++=
++++++
>  1 file changed, 22 insertions(+)
>=20
> diff --git a/Documentation/devicetree/bindings/mtd/gpmi-nand.yaml b/Docum=
entation/devicetree/bindings/mtd/gpmi-nand.yaml
> index 021c0da0b072f..f9eb1868ca1f4 100644
> --- a/Documentation/devicetree/bindings/mtd/gpmi-nand.yaml
> +++ b/Documentation/devicetree/bindings/mtd/gpmi-nand.yaml
> @@ -24,6 +24,7 @@ properties:
>            - fsl,imx6q-gpmi-nand
>            - fsl,imx6sx-gpmi-nand
>            - fsl,imx7d-gpmi-nand
> +          - fsl,imx8qxp-gpmi-nand
>        - items:
>            - enum:
>                - fsl,imx8mm-gpmi-nand
> @@ -151,6 +152,27 @@ allOf:
>              - const: gpmi_io
>              - const: gpmi_bch_apb
> =20
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            enum:
> +              - fsl,imx8qxp-gpmi-nand
> +    then:
> +      properties:
> +        clocks:
> +          items:
> +            - description: SoC gpmi io clock
> +            - description: SoC gpmi apb clock

I believe these two clocks are mandatory?

> +            - description: SoC gpmi bch clock
> +            - description: SoC gpmi bch apb clock
> +        clock-names:
> +          items:
> +            - const: gpmi_io
> +            - const: gpmi_apb
> +            - const: gpmi_bch
> +            - const: gpmi_bch_apb
> +
>  examples:
>    - |
>      nand-controller@8000c000 {
>=20


Thanks,
Miqu=C3=A8l

