Return-Path: <dmaengine+bounces-3682-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D57A9BAC14
	for <lists+dmaengine@lfdr.de>; Mon,  4 Nov 2024 06:35:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6956E1C20A82
	for <lists+dmaengine@lfdr.de>; Mon,  4 Nov 2024 05:35:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E6FA17D8A9;
	Mon,  4 Nov 2024 05:35:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="Rbn5Q9Ck"
X-Original-To: dmaengine@vger.kernel.org
Received: from EUR02-DB5-obe.outbound.protection.outlook.com (mail-db5eur02on2061.outbound.protection.outlook.com [40.107.249.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A96B4501A;
	Mon,  4 Nov 2024 05:35:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.249.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730698508; cv=fail; b=NCvg1iOdKgj36YIQcIqhdt9RFqNbbRvihh1VkdeZumU6/+SrvH1jrwdWB30pAdc/dSA+hU5JBeh/+A4T3V4aR0POVSPiszdhxJxfrwRRQ9LCb+uu2jf+9kgxxPNYZtBXMIaYcV7uKGJBE4hVmfFYiIrjyW0S95qiSHQ2PwTl+3A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730698508; c=relaxed/simple;
	bh=/Wn6m7CI4ZUCEunB7MGTT+qm3x0+mwgkArXLzPLg1DY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=JM1UhthaPwBjl+ZjGO827LzLxx66+O+MhFZ68KUWCf5dFTm/ruRuCX9fzg3TVgD6UR05L0B/92vIiBQ84NA8PwjQsup5A2ai8oxRrw325JYpjOzXNGJNEXjwPImws4xk/lziZs9geyiQC80qW88tjMQQuIrLNJc3j818BpV1WSs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=Rbn5Q9Ck; arc=fail smtp.client-ip=40.107.249.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AT5dOoaMXwQBrCyfuiDFIzMW22cprLMoBXFC1+IuOWmbJwds0cITg8nfjT02VRIuDQT5k2JYGseOQpVzLUWP4c9CrudsoghAa1Fd6AGLeyV3CtHaa76h7ztx/Nr2cpjzNw3bJivR7eyC/Aaj+b9DDQTcipO/hrFx82ThP3GFcPpbXZVWGVPSOpUCw3LDfr8wdYyPbq26C/hagSHqRs7Ajzxy5/JzQ8FSAxTfcf1Gs5mgXukOuRNC35H+uKzTsJ07mWbddtteBwjn5vsNvQtI8kzU5ARDgyoPfThIAAxb+m81b/l44oaBMCF3U0hB80V19pPNR06LH/84kzE6IgFz1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wxHKjSG0ocv9N8uhs4JsO+mKPjCCiEdQNQXD77dtU8U=;
 b=QVii/vvOW2softbnj1ogV7oEeTWwMfbB7nhCXj9VBlSKR3bJNhf9TJA8ft8jyY9Cw4Qyhuznj8OEkZDBi6V2IWq2chiv6muZ8xgKy60HMAeVjRSNdnBMuJU3fNUrhElYgTMMgnD1dBgBEGCsUSEQZYmxCpHjkLBQK8ZaY2qioo6NwDxbtNuPmKhQCuORjduzm6iPQm8W8nmTDNHq/Wq5TWLcVyEZPObwgPPXmtB+LXYb29onY9BR0jqJnXEVkhrffs/tLTaSmZwYdKNLfo8jMTpynEEqcq1wgW2t2vz0C1dTHy1rroZJTirj5DHw9e+TGriRlHYS9sssQo6hr2W7Qg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wxHKjSG0ocv9N8uhs4JsO+mKPjCCiEdQNQXD77dtU8U=;
 b=Rbn5Q9CkGS0yQXtakmAYZdjuerQ7HtXGtOpOVKogw3IZqvz/QIZrmWsGG5r+J3Jj6G5oYlRQTmuXQMZ/2pB/8pU2giWoF7mNENAuz6TZrDs0iOGH+2G91KS03ch3wVhi2AXc6vKsUQMu7/f4RrYWE8LwgVW0L5EnEndIzj0uJhyfLx0VJktFF96eDjcd/+YAEL+KdX2FOotFadX0dnuluAJjWnEHPSutDMKv2KdUZYQEqXLsAvXkrzFd9QZUXilK5jZZC0g5yN5QWscjyk1SbmLsDdToJsP3tc35514iES2YDRCvjY+QRHfC7Abgf3FWZWdqMEzmoIvyUcUqhvQCgw==
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by DB9PR04MB8139.eurprd04.prod.outlook.com (2603:10a6:10:248::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.30; Mon, 4 Nov
 2024 05:35:03 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%5]) with mapi id 15.20.8114.028; Mon, 4 Nov 2024
 05:35:02 +0000
From: Peng Fan <peng.fan@nxp.com>
To: Frank Li <frank.li@nxp.com>, "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
CC: Vinod Koul <vkoul@kernel.org>, "open list:FREESCALE eDMA DRIVER"
	<imx@lists.linux.dev>, "open list:FREESCALE eDMA DRIVER"
	<dmaengine@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 1/2] dmaengine: fsl-edma: cleanup chan after
 dma_async_device_unregister
Thread-Topic: [PATCH 1/2] dmaengine: fsl-edma: cleanup chan after
 dma_async_device_unregister
Thread-Index: AQHbLEVl7w85I+9/RkyP6CkC9gzd17KivuAAgAPeZbA=
Date: Mon, 4 Nov 2024 05:35:02 +0000
Message-ID:
 <PAXPR04MB845988B45C8408112563764E88512@PAXPR04MB8459.eurprd04.prod.outlook.com>
References: <20241101101410.1449891-1-peng.fan@oss.nxp.com>
 <ZyUdktvfqAK5IIG9@lizhi-Precision-Tower-5810>
In-Reply-To: <ZyUdktvfqAK5IIG9@lizhi-Precision-Tower-5810>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR04MB8459:EE_|DB9PR04MB8139:EE_
x-ms-office365-filtering-correlation-id: 4c23e81d-129f-4398-ce27-08dcfc926e6e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?H6woFMugi47QqZFoytY42LSyIBj60KUguOfc6KYIoI7m0p9GMVhjRrDHvATd?=
 =?us-ascii?Q?LS98aE0POvW+6Z4jc7m1jHAYm7bPe5VxX+ysWULUAEcj1uUy3fzqI9LdaqAj?=
 =?us-ascii?Q?D3ZZwlpJ6pEN1ljH3EP/YuGSfr6SHkjVEjrS1uYRNy2Ehq/vFyw9Vr5Yy2wQ?=
 =?us-ascii?Q?+MYOtSSmmPrtRMqXwrOGhF0+cUQKY1FFOXTSNz81Pj/MiS/45U9fhG6H+fej?=
 =?us-ascii?Q?GY8RsDalDxo71rcR5Sn7oIV/l7IPVFrax2ihuxxXdpMcsPPMEQAbq+usVxf8?=
 =?us-ascii?Q?M6hbkwrf40tY3DxNC7kEClw8sYJIPkBFNjLNpfYiB0hm3e+0M93lcdSpu/4y?=
 =?us-ascii?Q?IjpyobiZCMrk1+IPdih1TgaquwBwO+LRN1jhMpzlAVPoaa/KXSjluR1Q77WA?=
 =?us-ascii?Q?h9Si55MNth98VZJYT3mJ3Jf1Mc3hn5fiKCTQ1b3z4XWsXpvAlyuWgnxg7Mp2?=
 =?us-ascii?Q?Ub05BjzDurXe/70v0jezOtSi6P303uB1tiSRV4mOS16Bl2ZkXkBg0LeczFZ+?=
 =?us-ascii?Q?bmtyQes5SKyDo/IZI5VdtRI38dyjAjHkT9og8WlxORsr/j191Y0SOCZLXRAn?=
 =?us-ascii?Q?ek5prBebqOG8DfVMeTGXmylBaCdwdon/oNwix+ckb0+3TqUhex1kJVAKqjWj?=
 =?us-ascii?Q?eVN/CfBcfZgs+2OM8RlCfcD9lPG4dTM1EvqJPCbn7bC2GJF++lhqPwAIuyzl?=
 =?us-ascii?Q?SvzZXh3wj8KU6lXpdM7KhjHDjNSLHU9dB5IfmaMgG97TZdZ+C19gRknn7JP4?=
 =?us-ascii?Q?cfow8OxRxTMK+Q1ZS1Cn5uD77p97mzZ/UwD2aUg+YBaKsUF66dP21Wl1qC3R?=
 =?us-ascii?Q?ricR8RprqI1VyCjznAse+p+xVRdnzfoUicK9qFAHkrJMkYKfiq54hSJx85HI?=
 =?us-ascii?Q?/MUCQPcvlfn9uDl223NPH+JzroVp/sjH52Eq9lh9pGRzAue93S8b8ZFKdyA/?=
 =?us-ascii?Q?tcLlY3EPSIsMbDbKOrEDAEBTg4IB4lqljRp7ab0cjNyXFSIZRJIwriccKN+U?=
 =?us-ascii?Q?+V1lcUmOacxXX8WXwqSB2xGgXmM3BeXkJnf9ooS0FRlPRgqbcb7BwcvE4YCN?=
 =?us-ascii?Q?a86iERWgzKbnD3RW0YnSCf0pwOGnpBIZeLjtpIDsqowPgDxwsmTcllwlsFjc?=
 =?us-ascii?Q?Op5RnJIoeBJsadj+BeWriFVZbOLdRKBtd3TqoGNWikc1N9011lXubUoAg/NW?=
 =?us-ascii?Q?FaLZxtiJMRZ+Vt2ex3v9eY8RX9hj1Gw9kYhleju/BgTDx8ddvG/5Vt2Sf539?=
 =?us-ascii?Q?1SWKoLSJM9QYceWHr2I+53S58gGIgPKPOh3q0XnSs5zoDgoxLluA5JRx5G6Z?=
 =?us-ascii?Q?L248TMmesB5cuL0rIkFdSQHzGIyjmE2tXI5ZySj+/jBKjFp4ARXFHCTGhgY8?=
 =?us-ascii?Q?G+P9lPg=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8459.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?LlCceu/tzS00icINOMv9bsDFXq77IYvNWsImiM8l7ZwEfunjrXndbwZGhVOW?=
 =?us-ascii?Q?pJ8FwMi6NQzurgoMEWtfI7M3STe6Z+YXbWM3VghR/Ij0il63WByU5/47KDVo?=
 =?us-ascii?Q?dYhkqwxn4UVFCgmzuS8gIwgAltqAR8bAN7rV5qof1bUZgP/JJcPrk5mIplPM?=
 =?us-ascii?Q?MovmKaidwFf+jOJSS9JpYTYMxTDx08oiLENzxDwCVbpvqCKCZPUfpKjePspN?=
 =?us-ascii?Q?tn7h+nZmJ82FJSkwvbtx/TKdtYJHSzi+BRgRLcWnEQGtW7x49i0h6qf6boiR?=
 =?us-ascii?Q?e3DdpQGCWuLK4wF8QKdb9INwiKwV2WJLl80tJcyU8zdguiOwD5ALlsPyLS0E?=
 =?us-ascii?Q?QBTn6t05ioS3YmUEtwTcT39ByvjbliPlcK4BIi9Gn4ze0SzwMp/1gN12VzDK?=
 =?us-ascii?Q?sbo3CUacRv8QhvI0HdBwokU+e82saPHAhmMMhPwzIUVR7bPaJsT8T9VWGk55?=
 =?us-ascii?Q?2vS6V+rQnZ69UPMOCuimZxow5LvYuVfMVKvH9PGkJUpQTMKac+Rc5owfS7rp?=
 =?us-ascii?Q?WhqwbS7139XYy+vOvzb/6lB+ZZ2toGQy3ZZwbFDLbTldgpYCEJxGYbSdt4NE?=
 =?us-ascii?Q?F1VuAp0pdUqsiUwYtrQHpjtFXIQn5GBa2FCv1bC3vEtMzSHWZqHdXd1m/fIn?=
 =?us-ascii?Q?kDmc+MME061XVotZieev6lFjrRETXsVjVjUSC893UYn5is3qfgbp42vWBcsY?=
 =?us-ascii?Q?JDt2ND4SFqQtj2IP3rXHKBXYyxw11h1ccAqxy3+i951/Hm4O2KZO5y/VuJ8S?=
 =?us-ascii?Q?HO2rgqORKFTqHgffG6lC75IOY8mc4BA32DJUT+R/1P+uT/efAkpCC2Qtz9GM?=
 =?us-ascii?Q?ARM7iJj5ZxCHP1t+bgJ1DaPP6/b7xdXyuJwj7DdlJL+2UoE/OSQt3kx3eX8r?=
 =?us-ascii?Q?ZaWdeot76Zp6Q5WFvQGfxdDIUlnoNZVc0gAibrPc6d1tTgRQl60o9HeqXv5+?=
 =?us-ascii?Q?ys7kM4RoU58MvVvE7IshzAtYf9+oMGPTpF/VxWca6mP24bDDL40O/U89ODZN?=
 =?us-ascii?Q?tB8GO28H9RcXiD1DO8JGKxj/szBnacflFQhypRHQBPTyVBmwsbndjXZ6ssXr?=
 =?us-ascii?Q?0G1meIZtQtksi0FGno1iXlgus4uwjFKXfMHPiQD6b/PMAmmBwt7D9Jbt49tr?=
 =?us-ascii?Q?zI8kJnqhUe2igXbx0NOto5x6DnxWxhGnfBX/I4ijDYyrg7e48n9Cgm2hddjt?=
 =?us-ascii?Q?WuM6woZE3MqPK+NPrAp07MxDaam0P7VW4h5sHtiH+wNk95+luzAosX1Tg7/P?=
 =?us-ascii?Q?IEQA6MlA2ft+g6ZARn9tNiFSic7KBa5kosTqWmyDvR7ANlG+yKqYXGqaObI2?=
 =?us-ascii?Q?0gUf7+NLGXGOzWNKOQdWK97/HRAVnAX0i9t1qQh1Wf5ojexhzFefq+BvMEx3?=
 =?us-ascii?Q?Bcx86pCsbBDjq9y6bctuIeWpTcKyTQDF0tfo7jU3zzKxpn/aEnRMj9NHOqkI?=
 =?us-ascii?Q?DpxcbofcouRPi45nbmDpPhytgT+Jwxop8c6p7jkCZImMvLnvIjEhrGOVVXb7?=
 =?us-ascii?Q?gyBDjcDIb73ERpoowlvUq8FfiXmX8qGIXduDwUVpebHkb3dcG3uTKPM6sie6?=
 =?us-ascii?Q?IboBMSWRIKx6i4cnMIQ=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 4c23e81d-129f-4398-ce27-08dcfc926e6e
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Nov 2024 05:35:02.7778
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: FJCLfdfvwC9NQ8TkScARNEArqA4fnb/ssAcw2bcqpPXv1TINu0KRcC/W/6kXnjIyNks1n0/jLIpBWX6IkWKFrQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB8139

> Subject: Re: [PATCH 1/2] dmaengine: fsl-edma: cleanup chan after
> dma_async_device_unregister
>=20
> On Fri, Nov 01, 2024 at 06:14:09PM +0800, Peng Fan (OSS) wrote:
> > From: Peng Fan <peng.fan@nxp.com>
> >
> > There is kernel dump when do module test:
> > sysfs: cannot create duplicate filename
> '/devices/platform/soc@0/44000000.bus/44000000.dma-
> controller/dma/dma0chan0'
> >  __dma_async_device_channel_register+0x128/0x19c
> >  dma_async_device_register+0x150/0x454
> >  fsl_edma_probe+0x6cc/0x8a0
> >  platform_probe+0x68/0xc8
> >
> > Clean up chan after dma_async_device_unregister to address this.
>=20
> Can you explan why move it after dma_async_device_unregiste() can
> fix this problem?

fsl_edma_cleanup_vchan will unlink vchan.chan.device_node,
while dma_async_device_unregister  needs the link to do
__dma_async_device_channel_unregister. So need move
fsl_edma_cleanup_vchan after dma_async_device_unregister
to make sure channel could be freed.

I will include this in V2 commit log.

Thanks,
Peng.

>=20
> Frank
> >
> > Fixes: 6f93b93b2a1b ("dmaengine: fsl-edma: kill the tasklets upon
> > exit")
> > Signed-off-by: Peng Fan <peng.fan@nxp.com>
> > ---
> >  drivers/dma/fsl-edma-main.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/dma/fsl-edma-main.c b/drivers/dma/fsl-edma-
> main.c
> > index f9f1eda79254..01bd5cb24a49 100644
> > --- a/drivers/dma/fsl-edma-main.c
> > +++ b/drivers/dma/fsl-edma-main.c
> > @@ -668,9 +668,9 @@ static void fsl_edma_remove(struct
> platform_device *pdev)
> >  	struct fsl_edma_engine *fsl_edma =3D
> platform_get_drvdata(pdev);
> >
> >  	fsl_edma_irq_exit(pdev, fsl_edma);
> > -	fsl_edma_cleanup_vchan(&fsl_edma->dma_dev);
> >  	of_dma_controller_free(np);
> >  	dma_async_device_unregister(&fsl_edma->dma_dev);
> > +	fsl_edma_cleanup_vchan(&fsl_edma->dma_dev);
> >  	fsl_disable_clocks(fsl_edma, fsl_edma->drvdata->dmamuxs);  }
> >
> > --
> > 2.37.1
> >

