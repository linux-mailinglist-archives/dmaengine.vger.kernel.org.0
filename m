Return-Path: <dmaengine+bounces-2065-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A6EB8C8C4E
	for <lists+dmaengine@lfdr.de>; Fri, 17 May 2024 20:39:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7D93D1C2117E
	for <lists+dmaengine@lfdr.de>; Fri, 17 May 2024 18:39:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CDBC13DBA8;
	Fri, 17 May 2024 18:39:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="IFUQN0+f"
X-Original-To: dmaengine@vger.kernel.org
Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [217.70.183.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 475CA433A6;
	Fri, 17 May 2024 18:39:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715971152; cv=none; b=go5zxfueeAwavQlqX+fD6YaLyiwoywMdl5HBVNQodlVjodLRHbHfLiNjNrb5mQ5nnJei1Xn4zyHmtVoz8qq31R5ycQo9/qlXXbxA8tnMHYhQkGp1YhHLYNgXuKuU1Qg9fA07893uSfFObIhsqTxwy4BZTHCOEF3woUz0/64YbR4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715971152; c=relaxed/simple;
	bh=XjbV/dDMibbGeaSWigHuyPox9WqyXpKxSJ9Fnk5PmIg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SJo8joEoZHg8LvFjkjRgQiwrto8IWj/6dNd5Pp+s5rW/EWp276tNNH5v7UiZOMOQp84vmRj4TWHtK1av7t6JsKSAfI8jy1KScBaABk/z3WctjIA7qRmmdAdbU3Fyy6GqRlp9VVHcAD0K2ayWpluIsaBuFrMFJBWeX9yoNoLVJIQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=IFUQN0+f; arc=none smtp.client-ip=217.70.183.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 6343F60005;
	Fri, 17 May 2024 18:39:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1715971148;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MQ7u9L9F7F+dadEFYVniuXHGpmQQ9IaDZC1coQKlN20=;
	b=IFUQN0+fQySFvQs40/92OM4Rw9bpLf2T3FAWIbtByl/HZ1fSz6CflMrs1uuekDlGVkf+rH
	XivWXqepQgAO8O4sQ0VXDcPV44h/OSCdX5nA/uaOFb2UxpLSvdL8jE6kSAFhzb2CKVEbaR
	6ghyt/pnaqxnFJD3I9RH4K8ebiojEepfpmBQbqW/COW+Kkcx31zG6RTstU8umeRaBxR6gC
	+Y7kPqIm1RNkrkfSaCRT1n1vgJJ896xM+6Oj6P6+zUv6zZvys4KkePGixR3kvg8RdAUrDI
	Bmb9MSoetIJIzJ6zIbKZFKieN8pF6hNRs579apctpFv2FKMVQrxYoxvcImulDw==
Date: Fri, 17 May 2024 20:39:04 +0200
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
Subject: Re: [PATCH 3/5] mtd: rawnand: gpmi: add iMX8QXP support.
Message-ID: <20240517203904.2879419a@xps-13>
In-Reply-To: <20240517-gpmi_nand-v1-3-73bb8d2cd441@nxp.com>
References: <20240517-gpmi_nand-v1-0-73bb8d2cd441@nxp.com>
	<20240517-gpmi_nand-v1-3-73bb8d2cd441@nxp.com>
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

Frank.Li@nxp.com wrote on Fri, 17 May 2024 14:09:50 -0400:

> From: Han Xu <han.xu@nxp.com>
>=20
> Add "fsl,imx8qxp-gpmi-nand" compatible string. iMX8QXP gpmi nand is simil=
ar
> with iMX7D. But it using 4 clock: "gpmi_io", "gpmi_apb", "gpmi_bch" and

  to?             is         clocks

> "gpmi_bch_apb".
>=20
> Signed-off-by: Han Xu <han.xu@nxp.com>
> Signed-off-by: Frank Li <Frank.Li@nxp.com>
> ---
>  drivers/mtd/nand/raw/gpmi-nand/gpmi-nand.c | 20 +++++++++++++++++---
>  drivers/mtd/nand/raw/gpmi-nand/gpmi-nand.h |  4 ++++
>  2 files changed, 21 insertions(+), 3 deletions(-)
>=20
> diff --git a/drivers/mtd/nand/raw/gpmi-nand/gpmi-nand.c b/drivers/mtd/nan=
d/raw/gpmi-nand/gpmi-nand.c
> index e71ad2fcec232..f90c5207bacb6 100644
> --- a/drivers/mtd/nand/raw/gpmi-nand/gpmi-nand.c
> +++ b/drivers/mtd/nand/raw/gpmi-nand/gpmi-nand.c
> @@ -983,7 +983,8 @@ static int gpmi_setup_interface(struct nand_chip *chi=
p, int chipnr,
>  		return PTR_ERR(sdr);
> =20
>  	/* Only MX28/MX6 GPMI controller can reach EDO timings */
> -	if (sdr->tRC_min <=3D 25000 && !GPMI_IS_MX28(this) && !GPMI_IS_MX6(this=
))
> +	if (sdr->tRC_min <=3D 25000 && !GPMI_IS_MX28(this) &&
> +	    !(GPMI_IS_MX6(this) || GPMI_IS_MX8(this)))

Feels completely redundant, no? If it's not an imx6 nor an imx28, it
already returns -ENOTSUPP.

>  		return -ENOTSUPP;


Fine otherwise.

Thanks,
Miqu=C3=A8l

