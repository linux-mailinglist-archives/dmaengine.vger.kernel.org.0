Return-Path: <dmaengine+bounces-4795-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DF30A77538
	for <lists+dmaengine@lfdr.de>; Tue,  1 Apr 2025 09:30:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4E7913A5FDD
	for <lists+dmaengine@lfdr.de>; Tue,  1 Apr 2025 07:30:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D26CC126BFA;
	Tue,  1 Apr 2025 07:30:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=thalesgroup.com header.i=@thalesgroup.com header.b="xuFAvJOE"
X-Original-To: dmaengine@vger.kernel.org
Received: from esa.hc1631-21.eu.iphmx.com (esa.hc1631-21.eu.iphmx.com [23.90.123.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33D44F4ED;
	Tue,  1 Apr 2025 07:30:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=23.90.123.40
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743492631; cv=none; b=A0d/OKQ+f7ZaP2ws9DQi8bALOp4nTC4dZnym5HZi3fsooPF7HcOHfw80aM4cX/YxbVSRlRNFYI3Zj/GAHQfTn67nlhUZwvXWZZZ7nv7wHqAh1M4A3AugzYN+L+eFlpYhXOaB5y8fTeioUlW3zUdbEraN+UcuOsdXWaWCLiDoylk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743492631; c=relaxed/simple;
	bh=92GBRweUj1K6ouXoy2w5nifV7LpE8lWvJ5ku1ZBxhCU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=tDjgfubXrvQDsvmO4lgCuYF85bAQk51i/6eC5Mpa8EVX7AqXP9216Hj4xuqCyhRVeDGVTt14p8ctN1mPN6Eorig/o3NZNlHJnxIYZccwKnxaHETkJ6GQuttk2ta5BChxi8bFG1aHM8oJMiihOYeRObqXZDr1wzzhdsfr2wWKf2M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=thalesgroup.com; spf=pass smtp.mailfrom=thalesgroup.com; dkim=pass (2048-bit key) header.d=thalesgroup.com header.i=@thalesgroup.com header.b=xuFAvJOE; arc=none smtp.client-ip=23.90.123.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=thalesgroup.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=thalesgroup.com
X-CSE-ConnectionGUID: Vzm2BLhBRmOkyyXTg4+xrA==
X-CSE-MsgGUID: Nc+mhk4NQIap2K9dhYWSWg==
Authentication-Results: ob1.hc1631-21.eu.iphmx.com; dkim=pass (signature verified) header.i=@thalesgroup.com
X-IronPort-AV: E=McAfee;i="6700,10204,11390"; a="30095313"
X-IronPort-AV: E=Sophos;i="6.14,292,1736809200"; 
   d="scan'208";a="30095313"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=thalesgroup.com; i=@thalesgroup.com; s=bbmfo20230504;
  t=1743492555;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=+ug6tvPhr0FW2BLRItw883TSKhMg5ooqbQO8R5gLYV4=;
  b=xuFAvJOEavCnHS+LXf244LIyr/rPQN1iAi6VCHP93BVoH//3+yGckMG2
   vaCEDXhNdtMsD3dEkVmxa2x7sXIiKOrdPhIlY9w3/qy1/g7R0kUpl54II
   tm0ZNZRhwI/2Mpvwl6vrol1Vb9yxCXBtf9iSBy53pMNftMgpWHQXPcSYW
   Jz7UwaEhYzEJqo6rjEbdvxADgeLbvhywmx4HqCUsSIDarlloaSzrQkqPt
   G/+lUfiRABm9ORFzxGD+sAUfo4XLP2n5saDwiITXjNiCG8/xPhS5/4NF8
   7+CV3Kvt4JT2d63ZRav7t5vQ5ox2ttL/3yM1RR0OceyxhvgqXC3KQ0EE0
   A==;
X-CSE-ConnectionGUID: eHYzShn6RraJvr3wKf4E6w==
X-CSE-MsgGUID: asHFRQQuQA2+80GR5t7KLw==
X-CSE-ConnectionGUID: WzQeuH4mTwmwmIlgJgwwzA==
X-CSE-MsgGUID: 4/g8Nw7vSwq9TqYA2pNOJQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11390"; a="44392242"
X-IronPort-AV: E=Sophos;i="6.14,292,1736809200"; 
   d="scan'208";a="44392242"
From: LECOINTRE Philippe <philippe.lecointre@thalesgroup.com>
To: Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>,
	"dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "LENAIN
 Simon" <simon.lenain@thalesgroup.com>, LEJEUNE Sebastien
	<sebastien.lejeune@thalesgroup.com>, RENAULT Xavier
	<xavier.renault@thalesgroup.com>
Subject: RE: [PATCH] dmaengine: dw-axi-dmac: optional reset support
Thread-Topic: [PATCH] dmaengine: dw-axi-dmac: optional reset support
Thread-Index: Adt3z3Y2yWnkRdAqTHGNYv7obAEStwrBcyjQ
Date: Tue, 1 Apr 2025 07:29:14 +0000
Message-ID: <5e3cb4a130cf4834a48ace99c61bf0e2@thalesgroup.com>
References: <bf8f02ced6604f80acb84e82ea3a9268@thalesgroup.com>
In-Reply-To: <bf8f02ced6604f80acb84e82ea3a9268@thalesgroup.com>
Accept-Language: fr-FR, en-US
Content-Language: fr-FR
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
thales-sensitivity: {TGOPEN}
dlpmanualfileclassification: {64c9cc36-7289-4c96-81d0-25ee8eefd11d}
x-endpointsecurity-0xde81-ev: v:7.9.20.519, d:out, a:y, w:t, t:17,
 sv:1743466818, ts:1743492554
x-ms-exchange-nodisclaimer: 0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Classified as: {OPEN}

Hello,

Do you see any interest in this patch?

I believe it makes the driver more generic to match all current and future =
use cases on SoCs that uses this controller.
Also, I think it simplifies the reading of the driver by removing if statem=
ent.

What do you think?

Regards,
Philippe


{OPEN}

> -----Original Message-----
> From: LECOINTRE Philippe
> Sent: Wednesday, February 5, 2025 2:39 PM
> To: Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>;
> dmaengine@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org; LENAIN Simon
> <simon.lenain@thalesgroup.com>; LEJEUNE Sebastien
> <sebastien.lejeune@thalesgroup.com>; BARBEAU Etienne
> <etienne.barbeau@thalesgroup.com>; RENAULT Xavier
> <xavier.renault@thalesgroup.com>
> Subject: [PATCH] dmaengine: dw-axi-dmac: optional reset support
>=20
> Use optional reset support to avoid having to add a new entry to
> dw_dma_of_id_table for each target requiring reset support
>=20
> Signed-off-by: Philippe Lecointre <philippe.lecointre@thalesgroup.com>
> Acked-by: Simon Lenain <simon.lenain@thalesgroup.com>
> ---
>  .../dma/dw-axi-dmac/dw-axi-dmac-platform.c    | 20 ++++++++-----------
>  1 file changed, 8 insertions(+), 12 deletions(-)
>=20
> diff --git a/drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c
> b/drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c
> index b23536645ff7..186bfb35b9eb 100644
> --- a/drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c
> +++ b/drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c
> @@ -48,8 +48,7 @@
>  	DMA_SLAVE_BUSWIDTH_64_BYTES)
>=20
>  #define AXI_DMA_FLAG_HAS_APB_REGS	BIT(0)
> -#define AXI_DMA_FLAG_HAS_RESETS		BIT(1)
> -#define AXI_DMA_FLAG_USE_CFG2		BIT(2)
> +#define AXI_DMA_FLAG_USE_CFG2		BIT(1)
>=20
>  static inline void
>  axi_dma_iowrite32(struct axi_dma_chip *chip, u32 reg, u32 val) @@ -
> 1498,15 +1497,13 @@ static int dw_probe(struct platform_device *pdev)
>  			return PTR_ERR(chip->apb_regs);
>  	}
>=20
> -	if (flags & AXI_DMA_FLAG_HAS_RESETS) {
> -		resets =3D devm_reset_control_array_get_exclusive(&pdev-
> >dev);
> -		if (IS_ERR(resets))
> -			return PTR_ERR(resets);
> +	resets =3D devm_reset_control_array_get_optional_exclusive(&pdev-
> >dev);
> +	if (IS_ERR(resets))
> +		return PTR_ERR(resets);
>=20
> -		ret =3D reset_control_deassert(resets);
> -		if (ret)
> -			return ret;
> -	}
> +	ret =3D reset_control_deassert(resets);
> +	if (ret)
> +		return ret;
>=20
>  	chip->dw->hdata->use_cfg2 =3D !!(flags &
> AXI_DMA_FLAG_USE_CFG2);
>=20
> @@ -1665,10 +1662,9 @@ static const struct of_device_id
> dw_dma_of_id_table[] =3D {
>  		.data =3D (void *)AXI_DMA_FLAG_HAS_APB_REGS,
>  	}, {
>  		.compatible =3D "starfive,jh7110-axi-dma",
> -		.data =3D (void *)(AXI_DMA_FLAG_HAS_RESETS |
> AXI_DMA_FLAG_USE_CFG2),
> +		.data =3D (void *)AXI_DMA_FLAG_USE_CFG2,
>  	}, {
>  		.compatible =3D "starfive,jh8100-axi-dma",
> -		.data =3D (void *)AXI_DMA_FLAG_HAS_RESETS,
>  	},
>  	{}
>  };
> --
> 2.44.1

