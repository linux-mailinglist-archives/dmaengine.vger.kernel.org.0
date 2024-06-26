Return-Path: <dmaengine+bounces-2539-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E776E917B9D
	for <lists+dmaengine@lfdr.de>; Wed, 26 Jun 2024 11:02:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5F4E61F27757
	for <lists+dmaengine@lfdr.de>; Wed, 26 Jun 2024 09:02:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43FF916630E;
	Wed, 26 Jun 2024 09:02:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="e1QRhIcs"
X-Original-To: dmaengine@vger.kernel.org
Received: from EUR02-DB5-obe.outbound.protection.outlook.com (mail-db5eur02on2070.outbound.protection.outlook.com [40.107.249.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D63515B97E;
	Wed, 26 Jun 2024 09:02:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.249.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719392534; cv=fail; b=LljYZ0baYJ+QEUM/1LFezSZy/ylxOrtTweTVfyG2vSJIKBEU8bQg0Rwgxd2KCQpPZDcdYzGG5vJIzTYm5PXw7egi1IFLw+39VT0Ai0H/3DSV6Ulw81sr3pPXFnq6EdMfQSX2lIlwkk33nwfD2bW1wbtU3i+iws7SwNIzoTT11a8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719392534; c=relaxed/simple;
	bh=TOGzJbMdfYMZ8S7KZ8P78JCQjsf6MvNQ8TN0adlxFH0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=aoOKqdjkPZBGFv2797lSXe5HZtcWMDUGG8GL0nM1RqcAv3/ZojWak9Ru3y1Hr8cPsCySlrREw1VBhLEs+EAOsMcIoBSZ5Z+/SL7q6C6lBFfy6dNK/m21Lz27MMJc/QDqxtW9/+G8aji34EayWGfU+YVAZB2zu6Jp8k2MHaRW0Jk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=e1QRhIcs; arc=fail smtp.client-ip=40.107.249.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ARQqQqsVtBbBS6J0z1hq7CG7e8Dd0Otm8Cczl+jPC/o6moWk3Vsg9K1LOQUD+gX84irqQc9c9PeXlCPW9elHjZK0VBVAGYHxAMWwTNyLCDfVqUXGd92SlPHs+0Fneh7+s6ct0+GzB1FpFe/7fVBRpAJCJedCb1vmAnIlIWOHsq48nPKx1ypPnYTKnz2/CpU9/P37RNuzTFtR5V0Y8KSuC4S9XHFGxIlrUN4mC3sxPoj5uRbxaiWAPnd0tfIA6VsRfYkgcErWZKT4/HeggZqABpbbIJXStSEtAMCSRr5UP2X9Lall1aVPX/ujea87MmGuDApD8gBQ4Z7GWVSg/ZLZ2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Dsk7f5SF4NtyIilKoLJC8UGHQXW3e1wkIRtuBdYRkn4=;
 b=YOQJPWAcDej+o0r++4ACFrmsYDEltwySgVER174b8eXiP1F1lADY1RS8QzRWKYeV4gjjrAB8u4keE6P2XJhNj11Ldey8yqeyYQ2R0nkOZE7jeU/KQSLuxNULjYvDRnY0zGpNA7bFHdbyNJ7xNmtBIPoppiewe5rjAK2m+3lNRL0IcIpT+jp9csy4sDYRpcO/4HVKRw4R67YTu3LO6vX9b2cLbtbqi4082nDjbFEPoiswhUlkXUoL0d/fvPFn0DIJfmZXJxo/7FyIC35+qGpGUYxpxhhkT35BsQcEO0dzUyuDn8i+rIvyDG4KypNCUo0Iwd2X2nuDY1zXcDZzS68Zeg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Dsk7f5SF4NtyIilKoLJC8UGHQXW3e1wkIRtuBdYRkn4=;
 b=e1QRhIcsHzDa+djESBO7+BkqNigexid3RC4N/9GcGNlYMLJj91TTFXhVQrmjX0A0HXRvJPooGHyUANaEHFHiSFxBd4bwMpSTaKp6m0FjPSOo8MrNMTIyMqQf0QOVoR6cHGpJEgjgNMDveHBtoA/ZqID4KRT8jvSL8XbMDEO3xcw=
Received: from AM6PR04MB5941.eurprd04.prod.outlook.com (2603:10a6:20b:9e::16)
 by PA2PR04MB10278.eurprd04.prod.outlook.com (2603:10a6:102:408::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.30; Wed, 26 Jun
 2024 09:02:09 +0000
Received: from AM6PR04MB5941.eurprd04.prod.outlook.com
 ([fe80::9f4e:b695:f5f0:5256]) by AM6PR04MB5941.eurprd04.prod.outlook.com
 ([fe80::9f4e:b695:f5f0:5256%4]) with mapi id 15.20.7698.025; Wed, 26 Jun 2024
 09:02:09 +0000
From: Peng Fan <peng.fan@nxp.com>
To: Ma Ke <make24@iscas.ac.cn>, "vkoul@kernel.org" <vkoul@kernel.org>,
	"shawnguo@kernel.org" <shawnguo@kernel.org>, "s.hauer@pengutronix.de"
	<s.hauer@pengutronix.de>, "kernel@pengutronix.de" <kernel@pengutronix.de>,
	"festevam@gmail.com" <festevam@gmail.com>
CC: "dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>,
	"imx@lists.linux.dev" <imx@lists.linux.dev>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] dmaengine: mxs-dma: Add check for dma_set_max_seg_size in
 mxs_dma_probe()
Thread-Topic: [PATCH] dmaengine: mxs-dma: Add check for dma_set_max_seg_size
 in mxs_dma_probe()
Thread-Index: AQHax6U6K3n1xgA4ak+cFYNyaLS+5rHZv5Vg
Date: Wed, 26 Jun 2024 09:02:09 +0000
Message-ID:
 <AM6PR04MB594141B66F1DEB2354ADDF7B88D62@AM6PR04MB5941.eurprd04.prod.outlook.com>
References: <20240626084515.2829595-1-make24@iscas.ac.cn>
In-Reply-To: <20240626084515.2829595-1-make24@iscas.ac.cn>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM6PR04MB5941:EE_|PA2PR04MB10278:EE_
x-ms-office365-filtering-correlation-id: da59e4a9-d426-40f9-cf25-08dc95bea900
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230038|1800799022|366014|7416012|376012|38070700016;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?hTzcZJ2/BbQmPSREVa3gZBdCTpb2d/xNJycHgMPK2/Mevt9EXf65yf0EtSqC?=
 =?us-ascii?Q?nYvJ0yvnUGD/oQ0g/GLzMYinyOY1cOjRCQo2FRME5dV5Q/2VtlIq3BZWPu3j?=
 =?us-ascii?Q?/olZi/5JrS5mYcTqA5gVFWMOd4YIxNA2YGAzhfNxmRnny8jiWDolp36uOmo4?=
 =?us-ascii?Q?WkUM9q3EhZP7mYm0t4hl/fpHVLYN8riDk3k9P6+cx6x8KExJAOWUxW1ArYS3?=
 =?us-ascii?Q?TCtsLr5V2rl1eWQzx8+42EgB+nbFoDZhV/f8+rBsp5ETwGyKnrXmoELTWAuj?=
 =?us-ascii?Q?0F2xbzAn6McJlAAgunraFcwQsvmbmlLWcT08ridSIsZKfaTUc7hFPw37ZZns?=
 =?us-ascii?Q?b+KScJk/UCUsLwWhipHUMU0Bs0FpmAgzJzuDez+HjUMirRyFRXfLFrVy5NjM?=
 =?us-ascii?Q?msF0YeBXpgN4I/QyBKfWeYaQDCbLhscVpGyJAwORtu62Jvne2/fIabUAS/Xw?=
 =?us-ascii?Q?kC6qKZbckDTgn2/LYU0BS5IXStQuv6k0Y7Cl2ICTv8QaqJzPS3s1KFgWW4no?=
 =?us-ascii?Q?nSH1mmsKoa4MTz8KhtLXCxKrb3J0fWRUDZpz0/4PP/DrpOYRNQt2hJ3LVSsY?=
 =?us-ascii?Q?WVVh743ImJRiY1BkmCaqssLZpZg4mNTSPA2A1GuO+doCTlhIPfQIK9kG5jhs?=
 =?us-ascii?Q?YYMlxhf4nks7dIVlqgCYayL7PGWdQgRwaUJ9Sh6cCOAIYEFwMWk4nUFkPs+Q?=
 =?us-ascii?Q?fnYhalI1+KLc2GzZIJKvn1GZE1c6bFlpYI4DR9oBcoholhHHENKcaQDLt8oS?=
 =?us-ascii?Q?m4oZa82WDE6u/rSuNSLxXLXRWm2BfEMUrBp7l7kF+T+JRF50i7dnpOA08Aqi?=
 =?us-ascii?Q?8scuEXpArZYpefgM88iaq7It6gFM0S8CJD8/lyRe9qm6IWTbJnvDAx0B/wxv?=
 =?us-ascii?Q?LN9/z4mNfPaAssDchg4feCIJI5m1RywUtrTTctrLdg/WlXJigsgoI7qmYrZm?=
 =?us-ascii?Q?i9rFL5p1AMKeAyybNw5976xFgg30Dn5pkfSmNq4BA9oy9s66CE7ONVSvb0eQ?=
 =?us-ascii?Q?63ZCS3EUf+f1rYxwY39O4MSfinoOLYU5Owi8RmChmV2jhDwByo+XrHSyhuT9?=
 =?us-ascii?Q?JO+P3MWFqe31TKkZEoWIU8IS3ed6YBCVia0YQ06XMwmn/rRl+dgSRcZs90pG?=
 =?us-ascii?Q?lVthvbV8qhMLVUEtNv0lchXhRy9xd3IR3PZPCw+j1Upk7JD4GvQ4grEUSN0x?=
 =?us-ascii?Q?BxgxZ+yTftx3p65Y/OmTz7ch2czdyndk02op2kWomsLBA4SZB0rskpNhJFXz?=
 =?us-ascii?Q?vNTuRLgLy2eDF/V16+sZw1rX3AcKOUVGHNEp5K9tcKUH/Izd81o8eoF1MgzI?=
 =?us-ascii?Q?New8j+r3U5dhAUtnaHRgYmnW?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB5941.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230038)(1800799022)(366014)(7416012)(376012)(38070700016);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?LSh5K3rQ57inFgusQsUaZqy+ugtXDuV/dTRS8vGHaX6fuCkJhdGptd5L7nJM?=
 =?us-ascii?Q?eO6aWYJaXa4kZ/LHzKE9lICq+G82NMkG0fm/qPu9G9ytErDdQjoGy4AQ9Pal?=
 =?us-ascii?Q?37RWZ6UpdaN//BQFOCUyuqVP/F4dxrJl+j9BHzxEH/KgP6o4LYMs5fP2EINt?=
 =?us-ascii?Q?vCi5RNldt3Q2H2Bb5EliZsOXspFFblHG2Ce7884547x/qZwkdZFqOXXxa37p?=
 =?us-ascii?Q?1IpYEfgidc1WoIwlMsRo43n2EYgCjEz5MIVFHOYeBKMDoKXAA26vu6kRTgVd?=
 =?us-ascii?Q?/PJ8cbswXyM3FYE37JktR1gurdJPeTertt+5clhdGAYZqGu8Rw45eREAaGiP?=
 =?us-ascii?Q?D3Ah2ZojdeBUPnuDKOydjpyYyyX+dg4W1TkhKxh1eHyNUFw6zcdvxGq5ubz2?=
 =?us-ascii?Q?vKrHKajibtkEMsjb9wKY9UTLBZyGF4GD6Wy38/Qqf04cJY8eSCGmElgdE5sn?=
 =?us-ascii?Q?3E9RMocU6Uc6J/Q2eBBvlYBZlL87JEtBQF1lSYCm0JZpzTjq/ekwrOkt0WNY?=
 =?us-ascii?Q?b++4xvOXOQZqwm7vyLZ7gBt8cJ58Alxj4obchQ1laYErv+S2bEDsaGKTaPlY?=
 =?us-ascii?Q?U/4Amiyr+cyCYAePZFNtLd3zkm/s1enRP9C/E0g9liK6q58KKj1H1YNBa74q?=
 =?us-ascii?Q?Sw45+4bVEOCTna4dROb+xZbuMI1aCB0WlsXOXrZZl5QfYAKI40gLYud98FZ/?=
 =?us-ascii?Q?8MzgFJNPh+Egw54LYzf36xXCrwxSsvX24H5ua6kqUgAIMghQXfL6c6mU2F6T?=
 =?us-ascii?Q?eoEwsupAmL8PysSfpdChjrCOTcZppo8gVYqLv/qS6q/nARmX0COGa9MVt6mB?=
 =?us-ascii?Q?UThwS/1vCslEPJADd3Ieo7DggFMX2DWuOwjXN+tZGxPG8XLyWBPUz0PzpAd1?=
 =?us-ascii?Q?PRYGlwmNN2e29lDUXs+qCuwqOL5Dd+kaFYVGbMBm92HH3Lo7ATrTiaV/ocK3?=
 =?us-ascii?Q?cHKEsBozBj6mRO4JKVS+0yGGLWcgGmUj3OGqFRHzBdw3IsxXtlw/u/gdgB8F?=
 =?us-ascii?Q?9Tan4wOmuu5gA7KgnSivvM3p0xglruNAk9EE4KqqAD8LuPmoJEDx9QoAFYl8?=
 =?us-ascii?Q?xBKxvxpQekwYaIDwbswm5CifFvfe2dgSHQH731CwDAi8az4DE7QQr1C7OtWF?=
 =?us-ascii?Q?IwN+Z5XaMJPcQ23d/XCUVXouWNMfwwc088mkkM45FbnAV5/5/Hhj4+y4Qezj?=
 =?us-ascii?Q?3zPYpKdZ3ja86ukquBTh+RuNAKU+/iq3jwv9vxH/GPtdkBvUJP+c6PKcg5/V?=
 =?us-ascii?Q?2kD51JRaL2IHn/XFhr2G5GoN4gOABzjH2/8PNoMRhTMTYvTgH+WFQZ06IPHq?=
 =?us-ascii?Q?zwT3qsLraASZldw7HhoEgKbpyZxg0HXMTCG8lhnAi8MQhoV0ynITxEY1nspY?=
 =?us-ascii?Q?obiBhfQJmFbGOF9Wxjn7wanYiRC2y9cpNaSMe1o1F+kUU97BnMh3fH4UaisG?=
 =?us-ascii?Q?Q88DYaIlDfhPBnbdrcS6i5q1rMmLd8/8FImm5jvPsHNG1cRu/OENHXVqssgS?=
 =?us-ascii?Q?PGpMe74lsCfSNjzg6vHJ/xK4PJPQcJcLe9ejPh8M/kgXSjXceFDOgkyEGc5q?=
 =?us-ascii?Q?T/AyF6nf1ivjqxRJxyU=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB5941.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: da59e4a9-d426-40f9-cf25-08dc95bea900
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Jun 2024 09:02:09.1046
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: FRs0IT7ctGgTYfE6fCNP9AbDpffpN7qZuv+IMkaPzQSXbTKNuZe2Vn8+wViHJs1zn4IwdE7S7hC2XLFDrOCmog==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA2PR04MB10278

> Subject: [PATCH] dmaengine: mxs-dma: Add check for
> dma_set_max_seg_size in mxs_dma_probe()

Please read
https://lore.kernel.org/all/ZiocjS6tbeTt2mPD@matsya/

Regards,
Peng.

>=20
> As the possible failure of the dma_set_max_seg_size(), we should
> better check the return value of the dma_set_max_seg_size().
>=20
> Fixes: a580b8c5429a ("dmaengine: mxs-dma: add dma support for
> i.MX23/28")
> Signed-off-by: Ma Ke <make24@iscas.ac.cn>
> ---
>  drivers/dma/mxs-dma.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/dma/mxs-dma.c b/drivers/dma/mxs-dma.c index
> cfb9962417ef..90cbb9b04b02 100644
> --- a/drivers/dma/mxs-dma.c
> +++ b/drivers/dma/mxs-dma.c
> @@ -798,7 +798,9 @@ static int mxs_dma_probe(struct
> platform_device *pdev)
>  	mxs_dma->dma_device.dev =3D &pdev->dev;
>=20
>  	/* mxs_dma gets 65535 bytes maximum sg size */
> -	dma_set_max_seg_size(mxs_dma->dma_device.dev,
> MAX_XFER_BYTES);
> +	ret =3D dma_set_max_seg_size(mxs_dma->dma_device.dev,
> MAX_XFER_BYTES);
> +	if (ret)
> +		return ret;
>=20
>  	mxs_dma->dma_device.device_alloc_chan_resources =3D
> mxs_dma_alloc_chan_resources;
>  	mxs_dma->dma_device.device_free_chan_resources =3D
> mxs_dma_free_chan_resources;
> --
> 2.25.1
>=20


