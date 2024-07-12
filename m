Return-Path: <dmaengine+bounces-2687-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B08092FCAB
	for <lists+dmaengine@lfdr.de>; Fri, 12 Jul 2024 16:35:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4FCF0283923
	for <lists+dmaengine@lfdr.de>; Fri, 12 Jul 2024 14:35:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41779171E5A;
	Fri, 12 Jul 2024 14:35:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="RCA9lVVX"
X-Original-To: dmaengine@vger.kernel.org
Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [217.70.183.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E8E6EAC7;
	Fri, 12 Jul 2024 14:35:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720794915; cv=none; b=OOm+K7TQ+N3gOrt5oHbLrb4VBYjsTjpOIDEDYLwR5ezrP/wab+1ZWa7qKeTiCSMOwL9DoS3UIaFklz4QkC6zU79viPuc87U/n9Y8usG0f797HnSlxqKQpcuw/PbJcGbjf4/niLhTcLNEw7CnOEs9/24M/Y+MsZGQlLSICgxzUqI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720794915; c=relaxed/simple;
	bh=+CiVeB36WC3XhinXVvw3aBG/Q6TEMnuDcanTg5z9DXE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=toOsg+tMJpmRJBGaUH3XbM4mxnvsyvPbewK9RnzsfZ4RXdmkh7zpslioZ5VQzPfk6+2mA6Axj4wA1Lw0rAeoCNPwwZrwM9ZO6oPapAJia8TIYxla4Dwlqr1AkmQhKWHIReN9tjKouWdsqW910tNWwIHhV8efebSOEIPIBsSQmAQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=RCA9lVVX; arc=none smtp.client-ip=217.70.183.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 0858B6000B;
	Fri, 12 Jul 2024 14:35:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1720794905;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+CiVeB36WC3XhinXVvw3aBG/Q6TEMnuDcanTg5z9DXE=;
	b=RCA9lVVX1fd75spCVuVahSk1RoqL9eZbgexe3LnZmD+IsA7s0KLR4kU0QT6UQzVSQrcrPX
	hRiL3pPLMNwY4j16hbLtdlG5J+BEEA1PW7OW7sjOjXbSeY14TvMoAj1mIPMbsItiZvowOQ
	piShlvO2atXTdq/ISgShhl/xtRHkX+Z96RhtZHiU1TLZR7Gnw5w1RasNCG0SS+DHpspE3C
	dZUPWp3bNqaTriRX3hgPZNbOHazHGNgNQK8n++DqtMVk37DB13EUCRlel7A9e3Q4Zwg3Ay
	L9g8Ji7Nb82hIJNCnIwTjQT/ej4Az4/PbJYd7xyyek1Zmaaf4T3FbmlAXVsP/w==
Date: Fri, 12 Jul 2024 16:35:03 +0200
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Frank Li <Frank.Li@nxp.com>, Miquel Raynal <miquel.raynal@bootlin.com>,
 Richard Weinberger <richard@nod.at>, Vignesh Raghavendra <vigneshr@ti.com>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Han Xu <han.xu@nxp.com>, Vinod Koul
 <vkoul@kernel.org>, Shawn Guo <shawnguo@kernel.org>, Sascha Hauer
 <s.hauer@pengutronix.de>, Pengutronix Kernel Team <kernel@pengutronix.de>,
 Fabio Estevam <festevam@gmail.com>, Marek Vasut <marex@denx.de>
Cc: linux-mtd@lists.infradead.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org,
 imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2 2/6] dt-bindings: dma: fsl-mxs-dma: Add compatible
 string "fsl,imx8qxp-dma-apbh"
Message-ID: <20240712163503.69dad6b1@xps-13>
In-Reply-To: <20240527121836.178457-1-miquel.raynal@bootlin.com>
References: <20240520-gpmi_nand-v2-2-e3017e4c9da5@nxp.com>
	<20240527121836.178457-1-miquel.raynal@bootlin.com>
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

Hi Vinod,

miquel.raynal@bootlin.com wrote on Mon, 27 May 2024 14:18:36 +0200:

> On Mon, 2024-05-20 at 16:09:13 UTC, Frank Li wrote:
> > Add compatible string "fsl,imx8qxp-dma-apbh". It requires power-domains
> > compared with "fsl,imx28-dma-apbh".
> >=20
> > Allow 'power-domains' property because i.MX8DXL i.MX8QM and i.MX8QXP ne=
ed
> > it.
> >=20
> > Keep the same restriction about 'power-domains' for other compatible
> > strings.
> >=20
> > Signed-off-by: Frank Li <Frank.Li@nxp.com>
> > Reviewed-by: Rob Herring (Arm) <robh@kernel.org> =20
>=20
> Applied to https://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux.git =
nand/next, thanks.

I just realize now I picked this up whereas it was not intended to be
merged through mtd. I'm fine keeping this patch for the next merge
window if I get your explicit agreement otherwise I'll drop it.

Thanks,
Miqu=C3=A8l

