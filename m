Return-Path: <dmaengine+bounces-3681-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B6F5A9BAB1B
	for <lists+dmaengine@lfdr.de>; Mon,  4 Nov 2024 04:13:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C0C012820EF
	for <lists+dmaengine@lfdr.de>; Mon,  4 Nov 2024 03:13:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E3601632EB;
	Mon,  4 Nov 2024 03:13:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="Ra2TlE4Z"
X-Original-To: dmaengine@vger.kernel.org
Received: from EUR02-DB5-obe.outbound.protection.outlook.com (mail-db5eur02on2045.outbound.protection.outlook.com [40.107.249.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9487115C139;
	Mon,  4 Nov 2024 03:13:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.249.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730689990; cv=fail; b=iB7JOcDck7g8v5qNsq8db19OYJeNMyzuxqQ47t9IN5BF2IjokINOljg5iidDfPbUl0fTXRdJiyUGFVbzzUOQBsAb3U5dRCRTUVgReQar0L5t92r2TfsHIKLVHSOSmCe+PlVIIm2Hr+aLlvOroFAISxpPbN+sTF2ZZFHDLORc6lI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730689990; c=relaxed/simple;
	bh=pR8ilTuJjBtVtffMqExGjtSz+Bwbf2v5/U3r+kqYQz0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=WmH1ySJtWnkQ6sO3uc1bo/bPqnzj5qWCTjm8MtaZ0UHsJf55D/H9/iQH9wP9ImnlbpkLCOtVXB29oZbP285OSBfjO/DD//AkiAvOvSQ2G7+qdj4Gu2umoX+bd3ocDtxLsmwF/NVT6/pX6Z1DqRzQWRIJcscTM9sNBbSvXRxGouk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=Ra2TlE4Z; arc=fail smtp.client-ip=40.107.249.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=snrQm35xNdEDtymxywVZ0iUu3bZD47wiIm8QycGwQlTaKIRnHBvlKYF3q6Kewu/FhzbpODTbl6ughP2i/5dboS7OkTezq0jZ8VHjb82ReGpcP22RztwrxYgZgZ8mRsrYu1uf1j8NbWgbs9x5zDQGgaLhCI9AVtLcKRMWeiZvduNpR061XtGi7caWPis2Q9Q7WOXwyP39yqIOLhlM/9xGjA0bmgqDNXn4jEjGOj+jfW7XU2neqDQAkg/QiYvZO6J87yot1c53Oz3eyvAQtIM64a/iFUcns/yTyLFNTJOZCdyGZZOynVbTyYrSHpRo27P5cXSLMhlqVFwZKNLlxAAgFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iWsYuoTjBxz6bPzzFq3WpE86OIXCi5ozg20UdkVFz4Y=;
 b=couPg8OTrIcE+eDT39lzzsgltiibsbG26QbBa3xDGAIBB965FWJduXdy+/TFF+iWgxbUnmQFlFut6EcHwW7RxkzxoAy5f6ZVEqBCK91+PmOKb2meXQ3dSYeTAUHpyyveeq/y4NUoMa0VQMww9mn5WuhKGy0AYXC+ybd0F0eSJrzEixfbUQjOtVuH5F5FSYONMb/ERUywGPhCktvu9fIakgwkyQ172ZK9zF1PcMWBkzzaO3hXqIOYK0NKxnF2MEY88AaJjQgSTl/AiNNLi6BeT0A2B8Kdjb8jzkpvJY1b8yX3yfsPd2fjrg9FM+hyI5ZPdOfXRceXQ4ve7Nfx/UEGaw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iWsYuoTjBxz6bPzzFq3WpE86OIXCi5ozg20UdkVFz4Y=;
 b=Ra2TlE4ZK7FmKpCL6fIGp6O86gIZ4nDh9BtSwxfRUFUYlFnBcjEN7tsAOlUFps5mq51Mw9FnS9Q8nA01Ttz1pbYO6KCaupj2+0ktYMLoEU6JIzuORwWM6NfLfLKcciV5OMyYjrKO4YBu9RUP0mU7xHpcBSg/uXhvr/fMOztpUQC99ji2ykqSo6Ry+3tR2kThRidknhRjP2Wa9H2Sxh2gGETTnwO8mJwZp++EOrvHiGfaROA5OWIDzKr690zbynXtVOtd6Gf1qJs5t7qdqTePRfQLtCKxIn5pJU5SaMsQ9CvPAxf2hVm+jGGiCRSgdGNY5U9rcgvz39Y9rbdBnnwTuw==
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by PAXPR04MB8206.eurprd04.prod.outlook.com (2603:10a6:102:1cb::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.30; Mon, 4 Nov
 2024 03:13:04 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%5]) with mapi id 15.20.8114.028; Mon, 4 Nov 2024
 03:13:04 +0000
From: Peng Fan <peng.fan@nxp.com>
To: Frank Li <frank.li@nxp.com>, "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
CC: Vinod Koul <vkoul@kernel.org>, "open list:FREESCALE eDMA DRIVER"
	<imx@lists.linux.dev>, "open list:FREESCALE eDMA DRIVER"
	<dmaengine@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 2/2] dmaengine: fsl-edma: free irq correctly in remove
 pathy
Thread-Topic: [PATCH 2/2] dmaengine: fsl-edma: free irq correctly in remove
 pathy
Thread-Index: AQHbLIv9TqS74KtC1UGQOEW0zuAyMbKmdbYQ
Date: Mon, 4 Nov 2024 03:13:04 +0000
Message-ID:
 <PAXPR04MB8459CF8A7632A0164994E1D788512@PAXPR04MB8459.eurprd04.prod.outlook.com>
References: <20241101101410.1449891-1-peng.fan@oss.nxp.com>
 <20241101101410.1449891-2-peng.fan@oss.nxp.com>
 <ZyUeAc6rNbGDLKfO@lizhi-Precision-Tower-5810>
In-Reply-To: <ZyUeAc6rNbGDLKfO@lizhi-Precision-Tower-5810>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR04MB8459:EE_|PAXPR04MB8206:EE_
x-ms-office365-filtering-correlation-id: f370227f-29c5-45e5-cd4c-08dcfc7e995f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?wAWeCPKNhZdwjgkWhcdTXbGgO4K9CBKOgFwU+knWX4ReZ7JyiP65buSQ7BRy?=
 =?us-ascii?Q?xo8WIunojT5uj7gQZUfBZf4Uhw1harXkRBxtPYYr7zAXyF1AwPJlrLclCDJb?=
 =?us-ascii?Q?CTZ4sM5pO9kDPbvULeVHBLazz/nk+7+0m9JiiL5MYvJa+fl2uV+RHWuM79Oe?=
 =?us-ascii?Q?emw6gYSKlyAdoHqSAogcryO5Zp/SxBFUB65gIXjd2MdUU9XhK+nkq2hx8lc8?=
 =?us-ascii?Q?RfDH5miTlgSXz9H6BijXlRwnWh0rdhqERe7h7nrZdwaTjyZYRNaLIMn6QS+D?=
 =?us-ascii?Q?H1UAPDhjxGZSvw5tyY4apY5JLlRxCwNdKp2g0nSDepXvfhbl8fkldPglnAWd?=
 =?us-ascii?Q?1293dlF+nfE0ODTTGaOr+XOdaxCHbsTo9VhZTUa1rWOa9llkENZngIFwIViP?=
 =?us-ascii?Q?lbk23TxYCfV2/elihbiymqJtE3YxtZ7hluCM86Qf+Od0lPpEszcn9/GIlt+T?=
 =?us-ascii?Q?oEXueglSPs609Gfa2SNCKPOevUwbZb4KvlJAvGpKT7DOW2m4QsC1nRCdGV0c?=
 =?us-ascii?Q?UcUxWq7hFGnythfhn+seqqnIv0t2BCLbqEebDJ0+w0mxkYKmLwdTdvIR3+M6?=
 =?us-ascii?Q?gQVt+Q7lVsQC9/i5EqWekMxlgGN1bcBtcfVV2+EsQqdqqGjMf3/L6MPIKSET?=
 =?us-ascii?Q?/OcT1yHbqSQY2CEcUI4G54UMpoRprM3xyTMLkuVEa74nAUzh6KlI+y7cMWts?=
 =?us-ascii?Q?4iSczPShiyIrj21ZF8zzGt6cCq6Act9Ruyc8Z9wXpQAk/WsaNtCm/og6Ku/7?=
 =?us-ascii?Q?IWdL43u2nh7DzHi2Vo43Ov9I+te1aZZzsBWmP2++9+vgfETO8JLZjCQQr14R?=
 =?us-ascii?Q?qsyNhBvaXfc2Wj6NiftpUjGzvqB+aFPoQmYW2v5tKDHu69sdPsdaz6emMpeL?=
 =?us-ascii?Q?bvIVDIcNR4ngEzyHh90bqGObPy8BD7HoYnp1qzcXvQrSz/zMDqRLowHrX1l4?=
 =?us-ascii?Q?uKDXhKFYHHZaae9QYXKrm8ESVqexfbSJFpaEJcmPnOJoR/k6N+D9pOUkPQIO?=
 =?us-ascii?Q?1lvS9vake0WXmsdfQU7bDG8XhMgaZCJIVOb/iRels8LHC2joOnRyurs6qMuH?=
 =?us-ascii?Q?1cum6wZwTZdAhutmANU79PynsXgwa8UlcWfXpg6Fxv2IpwJm5dYvaN5bIXBP?=
 =?us-ascii?Q?g6F3bitkCsuqwLenSuK3HpgsswVa8DelIMqCvwhzdL2QpFAULrIDWI7t+GcK?=
 =?us-ascii?Q?tDg/qVX3DOyJyhKLZ2ce24R3em0vSUmjdQdlS2DO+FAUvg85XvA6zmOPrt3p?=
 =?us-ascii?Q?/oREsM2IIT7Dph3RCxKdMiMAJrmyKlfNeOHJIBQDASwWEW0idOWvOX2gw511?=
 =?us-ascii?Q?sT72j/Zcsw8BnTP2Gfw7EgHneXCOwTxKAl0Uqzd/77ffRZOLPW+8a3khJggo?=
 =?us-ascii?Q?JLT6/9I=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8459.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?Z+lYkVHyRf57n9P9E3kH2C4QoMuUDDeu9sR4pN//iotHMBR1Y4AKPR3xeEN5?=
 =?us-ascii?Q?Iw2ykhhP4Sgaay0tcAReFkQNUwQlFTSIDT78a1jnumrVrxaVuU38F2P0W5cj?=
 =?us-ascii?Q?nDq+6dpNKr2Gq5bElZ51J2KaS2ygQiUF4UDC6MYtbSqvjPYROADpYpylTPuJ?=
 =?us-ascii?Q?tVeHJPSMh3wW+2L/26canVcR37QOplMKCc8e/qqePN74J9od3vrlojthCgZk?=
 =?us-ascii?Q?zyjkdhQUOEWe0sNjZ9VVgbmpuIClRnMDUBen+5hKFv0ZNSDtdVpHykvvKDY8?=
 =?us-ascii?Q?J0qiiA1AlDQWlO2wAe0u6+Ae3WzQ4mlayzgwcHIwwzxguWHFZOAc0KV0o5a4?=
 =?us-ascii?Q?kv6fJ13h0lV7sGCgjbfnsfargHEW2uRZlTewW/hqzHB1OsG3AndIjHyGMYIW?=
 =?us-ascii?Q?LoloOJpkp+qSuIXyQzMDFfR23AtsaghfSMlTKfhnxNwm+tYsXqhYa5Eu34il?=
 =?us-ascii?Q?JCF6ITdM/gkWrGorSj2HhJH/Okw8EEZGU8vk+zSKncUd+Y0JePLPFLWnMorF?=
 =?us-ascii?Q?d56c1rSjT8dbCsJ8mhivkFTmXHPjDvvitldXJ8mLb9+Fj+9bshRcc71qkv8p?=
 =?us-ascii?Q?Nob5AdSSa6YfelCM/9hbfV4j33UcwxYmvge+/+t1SReSJGIJr3O8RBlUTx6N?=
 =?us-ascii?Q?P+YT7CQII0Z8n7GUlB6hYi6hbZjrDk6gMqCBtLmElDgUm90ccX6l2I56tzxC?=
 =?us-ascii?Q?jjOQndSRtDr0sw0ZZqGNEhFopVzenjVfgDMPeL0f2fCosXLadBO9RBSF5JXC?=
 =?us-ascii?Q?0oywQzS2dAmEZ/StDwvk29fkxCdyjme3f8dvbg/tEXWZfDTFJsNwBuXfTOfs?=
 =?us-ascii?Q?meu2xtFFUNaMWcaCZ2dkm5QwF25uYd8GGiX8ZR3TIfv9yS1K6HgUrXPILiOW?=
 =?us-ascii?Q?lUx/dR0wdQ544Qc7/DRoHJjLSEJhLgAHw3hZdwvVpwRFPAwqEB93TA2noOnn?=
 =?us-ascii?Q?iUQtOCyWOw3/sn6utHNcbed26FMMc+yxOWbSXEBhN+tdkacoKusICZzHRzDi?=
 =?us-ascii?Q?spHuvHhwi0ZTAGJJAZjWsr/zEQbuM9Akp/SEi8upL+hRYp5e53LvPQpinzaY?=
 =?us-ascii?Q?HDkRQR8CeT+jMNU36HgceQjFJ0rdMbBOBd6d+LjNn8M7QO3f8AAFs2uFsFRC?=
 =?us-ascii?Q?A4kPb2fep+sihc5rgb/ii/ojoTJ5mPzIghYhlDyJBfZ5BacydVfU9d27FgtR?=
 =?us-ascii?Q?de36zKWA+GpC1voZ2UPF3JNXKOVk2HSi0KdZAcV/V2MuNZsJPjZwynWnnMAk?=
 =?us-ascii?Q?T0G2FK4syznbTem/EBByUq6+SC7Lo7SfZ3nzrbUSYJ6uBaIT6gr+t+zacSIq?=
 =?us-ascii?Q?9H3YWJKN0XikQ3j7w3inOyyksjEVEfZiM8dO73KIrnOi3y6sqr/M1vz/qciS?=
 =?us-ascii?Q?+cfqObgmiqFFGA39uhRKB5DADHZUbdg6+Iv6XMO8eRsK9UKgcpu4c++y5pKt?=
 =?us-ascii?Q?xE1JRvKc9arsVVptkqdp7J3DQ1rruezo9qyOAUDNBV/Oo2LpUv08db9HFqRv?=
 =?us-ascii?Q?GYIzrREMLXBeBT5cgH7/U1A+ri2/N0Lk3C6ifAyCRgLK77/9xuhzZD4QgZ+a?=
 =?us-ascii?Q?Pqeqv8nQ0BSsWTRkoHo=3D?=
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
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f370227f-29c5-45e5-cd4c-08dcfc7e995f
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Nov 2024 03:13:04.8917
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: bIHzvrhypB2WufzEhFqVltXEpD6qNFkMdWnM07HqC3Be9CfHIpOdxN5WfDwSbUtVnAKizmZPRXmcRy+Qb4fMoQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8206

> Subject: Re: [PATCH 2/2] dmaengine: fsl-edma: free irq correctly in
> remove pathy
>=20
> On Fri, Nov 01, 2024 at 06:14:10PM +0800, Peng Fan (OSS) wrote:
> > From: Peng Fan <peng.fan@nxp.com>
> >
> > To i.MX9, there is no valid fsl_edma->txirq/errirq, so add a check in
> > fsl_edma_irq_exit to avoid issues.
> >
> > Fixes: 44eb827264de ("dmaengine: fsl-edma: request per-channel
> IRQ
> > only when channel is allocated")
> > Signed-off-by: Peng Fan <peng.fan@nxp.com>
> > ---
> >  drivers/dma/fsl-edma-main.c | 12 +++++++++---
> >  1 file changed, 9 insertions(+), 3 deletions(-)
> >
> > diff --git a/drivers/dma/fsl-edma-main.c b/drivers/dma/fsl-edma-
> main.c
> > index 01bd5cb24a49..89c54eeb4925 100644
> > --- a/drivers/dma/fsl-edma-main.c
> > +++ b/drivers/dma/fsl-edma-main.c
> > @@ -303,6 +303,7 @@ fsl_edma2_irq_init(struct platform_device
> *pdev,
> >
> >  		/* The last IRQ is for eDMA err */
> >  		if (i =3D=3D count - 1) {
> > +			fsl_edma->errirq =3D irq;
> >  			ret =3D devm_request_irq(&pdev->dev, irq,
> >
> 	fsl_edma_err_handler,
> >  						0, "eDMA2-ERR",
> fsl_edma);
> > @@ -322,10 +323,13 @@ static void fsl_edma_irq_exit(
> >  		struct platform_device *pdev, struct fsl_edma_engine
> *fsl_edma)  {
> >  	if (fsl_edma->txirq =3D=3D fsl_edma->errirq) {
> > -		devm_free_irq(&pdev->dev, fsl_edma->txirq,
> fsl_edma);
> > +		if (fsl_edma->txirq >=3D 0)
> > +			devm_free_irq(&pdev->dev, fsl_edma->txirq,
> fsl_edma);
> >  	} else {
> > -		devm_free_irq(&pdev->dev, fsl_edma->txirq,
> fsl_edma);
> > -		devm_free_irq(&pdev->dev, fsl_edma->errirq,
> fsl_edma);
> > +		if (fsl_edma->txirq >=3D 0)
> > +			devm_free_irq(&pdev->dev, fsl_edma->txirq,
> fsl_edma);
> > +		if (fsl_edma->errirq >=3D 0)
> > +			devm_free_irq(&pdev->dev, fsl_edma->errirq,
> fsl_edma);
> >  	}
> >  }
> >
> > @@ -485,6 +489,8 @@ static int fsl_edma_probe(struct
> platform_device *pdev)
> >  	if (!fsl_edma)
> >  		return -ENOMEM;
> >
> > +	fsl_edma->errirq =3D -EINVAL;
> > +	fsl_edma->txirq =3D -EINVAL;
>=20
> why not use 0 as invalidate?

I think 0 might be a valid value. So use -EINVAL here.

Thanks,
Peng.

>=20
> Frank
>=20
> >  	fsl_edma->drvdata =3D drvdata;
> >  	fsl_edma->n_chans =3D chans;
> >  	mutex_init(&fsl_edma->fsl_edma_mutex);
> > --
> > 2.37.1
> >

