Return-Path: <dmaengine+bounces-1114-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A7DE867131
	for <lists+dmaengine@lfdr.de>; Mon, 26 Feb 2024 11:34:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EAE7228F76D
	for <lists+dmaengine@lfdr.de>; Mon, 26 Feb 2024 10:34:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E1971D539;
	Mon, 26 Feb 2024 10:21:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="flq+W0cB"
X-Original-To: dmaengine@vger.kernel.org
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [217.70.183.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB3031DA5F;
	Mon, 26 Feb 2024 10:21:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708942898; cv=none; b=SExQlQgR6IeJTAqnEUOUZc4RMz0jCCvUC3V7GmJrU+oXQ7BzeD+k9frBMaafsNaP3a0CMnG4DUz5efhczJHRiiIychOcgpe/Y/mv7mADVaB5fKe0TA0f67e//Xl2BIpVlaJZk7ET4rNQ9PfbQhKzGTZEPjSJd/EPelnbiXHcnsQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708942898; c=relaxed/simple;
	bh=SwiyHIwfGQrvt0Oqe1FIHKsCmZZ1KCNl9qFWlS3AVyE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KQcj+tL5YDod9ZgzQTLGSj5KCz4JPEbjSe3Yiq4AouEJMToERlTk3pnEM/ITZtWb0zD7E1Wt9MbdUt+ur2R9bcRwDWS0fRKGB2UoNEehZeIlldI5vQZWoT9RVuLgWPwsYXDqmu6R9A6mbzbE5tZCCLAte2YZm87fMk0ExmEnx7s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=flq+W0cB; arc=none smtp.client-ip=217.70.183.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 307D520017;
	Mon, 26 Feb 2024 10:21:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1708942893;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9atkydl0QJMpqVx+Mp3qMYN15UNdxqngzP9FbgdYuuw=;
	b=flq+W0cBjqqwu9qC+BNB8to/cq+RAlZHyxmQ1+h1Przde1RcY+49LPEUVueQt0aTLNaZUJ
	xAmRjhb0A7U33bY4D6gaTkp8l0grxp3eaNbx3z1ugRgW0JLivVZ1A8WDwmc4WoD98pyW6w
	zWTRwu+xF7c2AWaL1vAtD8J+GOFaMHvUSpgC7cp0YZkD+AqaLfD/pm9SWbJknsj3GHcAt/
	fR8QAfNG+eR5n4Kn3D/UrRZpJeuR0Jehi6DL99UxxKGF/tQfQzqkWdjRYhEYOCV9QhA1kV
	SozyTh3q7ofJrXbycMdCeIIxLhSGeq9Qso3pnj7iumZqjz6unY3X/tN7aRtjug==
Date: Mon, 26 Feb 2024 11:21:32 +0100
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Tudor Ambarus <tudor.ambarus@linaro.org>
Cc: claudiu.beznea@tuxon.dev, nicolas.ferre@microchip.com,
 dmaengine@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-mtd@lists.infradead.org, linux-crypto@vger.kernel.org
Subject: Re: [PATCH] MAINTAINERS: Remove T Ambarus from few mchp entries
Message-ID: <20240226112132.22025454@xps-13>
In-Reply-To: <20240226094718.29104-1-tudor.ambarus@linaro.org>
References: <20240226094718.29104-1-tudor.ambarus@linaro.org>
Organization: Bootlin
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-GND-Sasl: miquel.raynal@bootlin.com

Hi Tudor,

tudor.ambarus@linaro.org wrote on Mon, 26 Feb 2024 11:47:18 +0200:

> I have been no longer at Microchip for more than a year and I'm no
> longer interested in maintaining these drivers. Let other mchp people
> step up, thus remove myself. Thanks for the nice collaboration everyone!
>=20
> Signed-off-by: Tudor Ambarus <tudor.ambarus@linaro.org>
> ---
> Shall be queued through the at91 tree.
>=20
>  MAINTAINERS | 14 --------------
>  1 file changed, 14 deletions(-)
>=20
> diff --git a/MAINTAINERS b/MAINTAINERS
> index e1475ca38ff2..fd4d4e58fead 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -14350,7 +14350,6 @@ F:	drivers/misc/xilinx_tmr_manager.c
> =20
>  MICROCHIP AT91 DMA DRIVERS
>  M:	Ludovic Desroches <ludovic.desroches@microchip.com>
> -M:	Tudor Ambarus <tudor.ambarus@linaro.org>
>  L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
>  L:	dmaengine@vger.kernel.org
>  S:	Supported
> @@ -14398,12 +14397,6 @@ S:	Supported
>  F:	Documentation/devicetree/bindings/media/microchip,csi2dc.yaml
>  F:	drivers/media/platform/microchip/microchip-csi2dc.c
> =20
> -MICROCHIP ECC DRIVER
> -M:	Tudor Ambarus <tudor.ambarus@linaro.org>
> -L:	linux-crypto@vger.kernel.org
> -S:	Maintained
> -F:	drivers/crypto/atmel-ecc.*
> -
>  MICROCHIP EIC DRIVER
>  M:	Claudiu Beznea <claudiu.beznea@tuxon.dev>
>  L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
> @@ -14505,13 +14498,6 @@ M:	Aubin Constans <aubin.constans@microchip.com>
>  S:	Maintained
>  F:	drivers/mmc/host/atmel-mci.c
> =20
> -MICROCHIP NAND DRIVER
> -M:	Tudor Ambarus <tudor.ambarus@linaro.org>
> -L:	linux-mtd@lists.infradead.org
> -S:	Supported
> -F:	Documentation/devicetree/bindings/mtd/atmel-nand.txt
> -F:	drivers/mtd/nand/raw/atmel/*

Could we mark these entries orphaned instead of removing them?

> -
>  MICROCHIP OTPC DRIVER
>  M:	Claudiu Beznea <claudiu.beznea@tuxon.dev>
>  L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)


Thanks,
Miqu=C3=A8l

