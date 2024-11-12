Return-Path: <dmaengine+bounces-3712-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 57B719C4C1B
	for <lists+dmaengine@lfdr.de>; Tue, 12 Nov 2024 02:55:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 35891B26AA8
	for <lists+dmaengine@lfdr.de>; Tue, 12 Nov 2024 01:52:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B26A9202F77;
	Tue, 12 Nov 2024 01:52:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="N0Bm5aqn"
X-Original-To: dmaengine@vger.kernel.org
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2069.outbound.protection.outlook.com [40.107.21.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C485F487A5;
	Tue, 12 Nov 2024 01:52:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.69
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731376366; cv=fail; b=W8shxysXnZWDUtsLbEmg21TgcbMIypx0W4RkDuVjkMg1EHi+AjGwkBEjMdW35rfuU9xK1bBtoD5yxITffRzUZ4cmr53+Hrh2Vb+bVRs4tA6+2po/vsn49SqU4a65xZaolgplaT4pohOAa2NWGxQ3pfbULMaGP4dLzApcBg0Cpa8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731376366; c=relaxed/simple;
	bh=Vv8x5SWzHyCwrLezqv1LzFPCT0RAn3OEecuCa08cjYk=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=gOuHyPanKwKrrnNtp3yPdeubmcI4ndhkPUdexOVyShBhyPxnZs5Ta58uNJY+X5lfAQaX6+dPLtp1ss0CRwZfb75rqQAh2U/VNs5PZq10e0Bf6felRR4paf8bZD4JBQSYRg7AzrG80Wf+htbR32FXX/1sDwy3yiu34pubTRgDWfU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=N0Bm5aqn; arc=fail smtp.client-ip=40.107.21.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QJaUJ/+eqFp06aMCTZszD5mC4/QVWlXkByVfXXLiFDXgQ+uUF2X4fYZ6JLmKJ2miYmZr4Uz5/TX21SqoyZIQ1zfxCVSTl5aYCemw7i9/uKxMm89ivOS5bgB/59vyvPs00VTRDo9efDRXMxdz0gXSX7nndb9/ICn6VKzkjDcUbGyvXX4UgKmBEKkUVRMRKdkyl6BhhhV31Cn5Mw6eyVeTKDy9NhcwBs3Bo2+eA6kXOSEUnWtHpgHxHt/CetU0BwcmPwaflGZKoV/ca5rxlECWKo1EbbGZxHaoqF5I7I/8nLQgA4z4Ktjz5CBGiT/H1oVb9k3UmY4pzvV8jueAulqDyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6YATuycIeYCcvmgnhAemec+hm43bjhr8N0Za554M6mc=;
 b=qwOaTj3rlkpoxSuWebJvQ6/bPlsL8E0Wws0M2vty4Y+Fn8icDZwQvsVV+it0H0FpsF7XVDHPRgWdlhW0fasBhqKmCN4hCh1At3j0SQOM4yNNvQSnKVS4/hRoTqBnNfZ+ZC8/ZO783vekYcgACp6FAWLa3d71qJPJIcNQgzan+K1AqapW6AprWRPUbP/hKp4k9xj/Ddu3oG5Em6tkfqDoyLeENU/NGBtTGL8qggkSs58c6UC2tyI6L2Kc3cz+CL4m5KUUcuVSZ3fPECRwuliRf4b2toWIbxKdPoJMbx7pCX/DTTzh74bBySKt/3xZ/kdjBF1SEkbtJsS7AcdRC/9GCw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6YATuycIeYCcvmgnhAemec+hm43bjhr8N0Za554M6mc=;
 b=N0Bm5aqnQ2TXYSqVXDmRTtUA8MA3ZfkmL4wYJsHlln0kNNXKtkYWZmcHvN8vbPY36eqpL9Js+M0YYHksk6x4ONMJicamCZsoRdJIFwJaoRjEiT2zvq/9FpqHiUt2hVmUwW07CsrQMsNPE2hNP3/vqBjpw95x+8B0BoAuciS0WispXTtCiO2p7jvVL/VT6b4Fv/xDbRS0RrAppzUrlEqgeIHNeD5eKYCyRQjtuTnmTGKhUmX9QbM9svxNGUPeOll44eJfuHGX0onTnsxDA5RpZcvSEdO2f3t8BEAW0WPX+oz1Gvajhn2U/SNAklYPD19UI9FgRmdDhZA3QfGUoYI2nA==
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by AM9PR04MB8939.eurprd04.prod.outlook.com (2603:10a6:20b:40a::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.29; Tue, 12 Nov
 2024 01:52:41 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%6]) with mapi id 15.20.8137.027; Tue, 12 Nov 2024
 01:52:41 +0000
From: Peng Fan <peng.fan@nxp.com>
To: Frank Li <frank.li@nxp.com>, "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
CC: Vinod Koul <vkoul@kernel.org>, "open list:FREESCALE eDMA DRIVER"
	<imx@lists.linux.dev>, "open list:FREESCALE eDMA DRIVER"
	<dmaengine@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH V2 2/2] dmaengine: fsl-edma: free irq correctly in remove
 pathy
Thread-Topic: [PATCH V2 2/2] dmaengine: fsl-edma: free irq correctly in remove
 pathy
Thread-Index: AQHbNFTuXAaavtN6lUmPpiikszzzerKy4X1g
Date: Tue, 12 Nov 2024 01:52:41 +0000
Message-ID:
 <PAXPR04MB84598E5B79A7115A2540A5FF88592@PAXPR04MB8459.eurprd04.prod.outlook.com>
References: <20241111072602.1179457-1-peng.fan@oss.nxp.com>
 <20241111072602.1179457-2-peng.fan@oss.nxp.com>
 <ZzItm7l9pGfrUSK8@lizhi-Precision-Tower-5810>
In-Reply-To: <ZzItm7l9pGfrUSK8@lizhi-Precision-Tower-5810>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR04MB8459:EE_|AM9PR04MB8939:EE_
x-ms-office365-filtering-correlation-id: ef2f5870-7514-4d2f-20ff-08dd02bcb1af
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?F4/amn5osvISP5+TJqMry6PVjyuxcdlV3PQBGdZB03Ayuz5Olx9ZJo0MDuRp?=
 =?us-ascii?Q?ZalhS7nWmabJDNSbyMN7WOD9vbPuEzDssUj67n8WCYGXDmvBZC3FgbpalLi3?=
 =?us-ascii?Q?MGCO6SQJQnhUwd8VWp9ZIt6YyetKH53YoFHLZe5wrU1e0WJdeve9jniCLKmW?=
 =?us-ascii?Q?SO6ivqZ/rJIV41Bt/Zs4/HjX7CZtgO2c/TQ9yrsNOgn65/FiGfmmwkQXuwuG?=
 =?us-ascii?Q?43jv4uElVJ87U+vFZSQdSM83Bh69BzV7ztbXRdfZPG/2IaFN91q2LGbpLL3k?=
 =?us-ascii?Q?N/9QFPrz3IJTh5bT8sPdGRKIuY29HorkggpOrHrqwLd9TnMWe3XEUmcXd6AZ?=
 =?us-ascii?Q?4pDenK3yCuv1fL8oMF2wxdxNCe6XrsL7AxuDJBb5ZAYwFfTlw5pfyBzTJDXi?=
 =?us-ascii?Q?BECf0nFx5stPtVISP4k4e4F9pXvLafTdWgMJlYBoSbS36Tjb4G27WgXrxgdC?=
 =?us-ascii?Q?gGrys6fYE5s/YpdRVDXlD8RrXwVxTSYNTCFSFaTUxOUR7Nn9oyQfqeYfTB1g?=
 =?us-ascii?Q?uUqwH30NMe2DxQuj0xqNOEM4TDHesOzKZCKJnd3IeR8WUtK8hj0GHQJvmd5/?=
 =?us-ascii?Q?Jbpi67j7WtgHdFPy0DBztg5oc+jYNsVEmJEvKg3AHIDj2nemkdbMs8NdF/zE?=
 =?us-ascii?Q?Lc2FYbyZHftJYcrzSCsyJvuqLIeSXjcmZvb3H0JUHzif/giCiD0ZbSqp89x5?=
 =?us-ascii?Q?isfd9Nyj/Aa4AHLPakalUHkDliIuet1xXAWqhEfWbLx5wsqBC50uqlixBctD?=
 =?us-ascii?Q?xsFRvRCW9FFtpqiQyB6x0K3+UyynqDZqcNXDg14Znt5giKxilrjMcdBpi0W9?=
 =?us-ascii?Q?A6+BxcwGXRyeuK7u86RE6C5kyxwBqW2hn9n4IRKae8gdPiC2FHACLtcu/Rh6?=
 =?us-ascii?Q?ojXokBPICeKIpUMKlofkYKE4Gkw8m+rix8I5BuWxT6u/R5C1pPeb6NOQkWHV?=
 =?us-ascii?Q?Wne8KhVBeWkXen7GFwR0XIRpLq9sDEWZQSnPP+fh9YmuSH6vtFZ5o1U8yTLy?=
 =?us-ascii?Q?FJZLSH1dgQv27rFg5m03zDLSmIYwAtfZjQkA2NRG0rfIcY1tnsYW/mRdjGfN?=
 =?us-ascii?Q?NKE/9WteRURC0m01XuE5GDSfAEp9BQS26CV8Px/i32n7ufCGC07nc7i0HYXp?=
 =?us-ascii?Q?cZhleaFsDbbBQG5jnjBxSj+hUUzGCMnqjQGyHTJDkSjChqjYAr+8GE/s4Dor?=
 =?us-ascii?Q?IJ4yeCWm0y2g/SJ+p+0KT84eTcyHN8tWSA/epCx9HLApnM8tLb4xaN2sbvza?=
 =?us-ascii?Q?lZfcv0n2TvdD/uy9CJxguF3iiA2fJXQRHcqln94GjEwfX0/c7XlexwevHKiX?=
 =?us-ascii?Q?dBmSIH2ZgYWpj+V0idDjE/S8HY3L7o5ond9ERQU32uKOPCjK3VwsCKieUgex?=
 =?us-ascii?Q?w/wWLC4=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8459.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?LqTarnDDYt6bVYzUOM5ZBYPEvNzNLhuU93rKZhOTcpO+sm/5648j1Nd4EOUU?=
 =?us-ascii?Q?z1lRpjq+sTt2ibMmhFInCxYqorpMxaUkPfLLtF9tGlhgEVeVRimHHQx+cVfw?=
 =?us-ascii?Q?/r5wi5VpjFGiwhdvH304Hy4OrC4OyGeZCuRKrUXMiZ8NGGFJeHmeGe8cGkED?=
 =?us-ascii?Q?zAw6lqL0RWAMxnMcrsqwc4k4a68k4+3SljHXC19MRc1uEv+5zCXrPvKanq3q?=
 =?us-ascii?Q?GJ+YtImI77Pv1XC1puG21HRAFWTx50K9jAVTq1lNt18NrPs3XZwGSRHnwYTq?=
 =?us-ascii?Q?JGK42YTppbcvmmIyAsS2HfJ24JFZcJNXid+kuF6Uon42VMoKvTY9CKCQHsLO?=
 =?us-ascii?Q?s7hZ9kHnQgyFNLXo/eI07sFPmOyeE+FrB6xgUZ4y0WYpOS0w6j/+fWY5TgJg?=
 =?us-ascii?Q?81WFLmOozmhrcU5LzABec9ju+BkbQHXx201XJdDErcTnpyW0p8VzQKp3OuQ3?=
 =?us-ascii?Q?FN98MTwkBPQMYGq6qe6XeP/ibZE8mUG/0SJcPV/WwyiFVrWdm54Pyej2lqIh?=
 =?us-ascii?Q?7hDPpF9WwaMUWtLXpHTTTTZHLPcC4iJyEIlR3CjzrM+MFJnBGxPgXplzJL6m?=
 =?us-ascii?Q?K7ZKj0YzQhxg1QiSdpikeIIdBdXJn7lIk+nCzPGFjhVJ5zAv3fKRYeYcGlKo?=
 =?us-ascii?Q?beHHXXlpXx1IU/Xuig079bexXiOnNpJGfe4QbwKs3x1/+AnK20iy20eG2VqR?=
 =?us-ascii?Q?5idUzd/YE1mFeNowt0DoBjpEDCe82z2NdPauq8+PdPJW7SSLdl3+/qCv2g2x?=
 =?us-ascii?Q?OJI5uPz1XEcxQNsjuRPGfnmlpFCP2E2KBDhR+U7poBh6c5OkOzTq0MzyHemJ?=
 =?us-ascii?Q?sQFOIe/0I3pVGvR6QFQ8Sz+h8vnOvofeH5414Lupoyxs/fT4nfwkxnGOfoQy?=
 =?us-ascii?Q?SAFv+cjv+B3XKGicrM4l0YJiHQU6DA3CFGHGV0Rtv87A+RMhky5BvVSBFZkA?=
 =?us-ascii?Q?bcMPbIs0h8vR1a3Q0hgGrbwSIgT1EXLM01u1DafMt3kK/s3m2GIaL1g0dYIF?=
 =?us-ascii?Q?VcuTrRndSEUYThYClj5wssBujU2CyldocqKa3+zwYPjMWQTgFm5GrKIhu9G8?=
 =?us-ascii?Q?Q/2jgSoWsBpjqBJnxF0HtEoDq5BazKByGuPVQOglEpnQud1E87LIxuqeVTaU?=
 =?us-ascii?Q?ZlblajWPjCbEPzbZW7jiVTo9Xiz5CpDhAbb+Z8ldnqh3vcx6dgL00pYDB9iz?=
 =?us-ascii?Q?pQwR2P2mrfNwV+dLjNVcANamh4y9HjGRvOGdtazGPy+86BGEdQ3QbhSgzYlP?=
 =?us-ascii?Q?Hgbr5cCtF5LfxrTIzs0jhbz/ttGTCRS95HoTqYpCrLFPVuXM15Q8+JQ6bPZB?=
 =?us-ascii?Q?iXJH+H+ecD6K4N5SLi9PyI+TYgas9n2dipQyzbP953fLKGXY3D9/KQ90EBP8?=
 =?us-ascii?Q?mJCnjcC8qZq5wapVAUplw6SF5lfHjL/a3i3Pu6ZyRaxjjHV3XAcBzn/DPzLp?=
 =?us-ascii?Q?Rxw8tMwfjnhCpzDKPPYhRTGqD1eVlx0oBWdVx0yvFKPmbeKzjU6fDQxzBxf7?=
 =?us-ascii?Q?nTTlT6LnU4eMDQrgdEjBo8Lwx6zhGJ8pYPUlkMK9CAeQAnB8L+b3Kwo0kVrB?=
 =?us-ascii?Q?1tNwHdsB3MuFoG53fDM=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: ef2f5870-7514-4d2f-20ff-08dd02bcb1af
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Nov 2024 01:52:41.4047
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: lkwNtlBrYEMtx/IErdOQUEw1hZWcYsVe4O7yubpv62j5DlfpmAgU6D4pe+ZyP16t3K9peQTA1dUNjzxxZeKw1A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8939

> Subject: Re: [PATCH V2 2/2] dmaengine: fsl-edma: free irq correctly in
> remove pathy
>=20
> On Mon, Nov 11, 2024 at 03:26:01PM +0800, Peng Fan (OSS) wrote:
> > From: Peng Fan <peng.fan@nxp.com>
> >
> > To i.MX9, there is no valid fsl_edma->txirq/errirq, so add a check in
> > fsl_edma_irq_exit to avoid issues.
>=20
> Nik: can you add descript about what's issues?

It should not free an irq that was not requested. So I add a check here.
You wanna to me to add the kernel dump or log in commit log?

Thanks,
Peng.

>=20
> >
> > Fixes: 44eb827264de ("dmaengine: fsl-edma: request per-channel
> IRQ
> > only when channel is allocated")
> > Signed-off-by: Peng Fan <peng.fan@nxp.com>
> > ---
> >
> > V2:
> >  None
> >
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
> >  	fsl_edma->drvdata =3D drvdata;
> >  	fsl_edma->n_chans =3D chans;
> >  	mutex_init(&fsl_edma->fsl_edma_mutex);
> > --
> > 2.37.1
> >

