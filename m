Return-Path: <dmaengine+bounces-2066-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2296D8C8CA9
	for <lists+dmaengine@lfdr.de>; Fri, 17 May 2024 21:16:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CC9A9282027
	for <lists+dmaengine@lfdr.de>; Fri, 17 May 2024 19:16:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CB7713FD91;
	Fri, 17 May 2024 19:16:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="OAx0k3FI"
X-Original-To: dmaengine@vger.kernel.org
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2043.outbound.protection.outlook.com [40.107.7.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44C2A13FD83;
	Fri, 17 May 2024 19:15:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.7.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715973361; cv=fail; b=iGEL1vxcmsuq5UTww6i2Jg20V9VCbBTuUOdOFV4nm57PL7LPnyFnC6Lh8RhiSR9lIyfBvwWSJkvYpyJN7wbDRUggHib3MejYoF9K9h/EAqG01gR9Vh++a7yhLoxWDxuV6mRW7gud+I3kY+go7Nrs/Fo+NXfZcxQzJEHV9mO7pyg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715973361; c=relaxed/simple;
	bh=oly1Aou9eu2QmUHCjJfOu+wZ12iifZ1cph/Eisy+bl0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=K0M7gCYyERRCJc9ox4oU1KsE/UtvOTKNbNNlvMegqGT9oA7AoE1TnKBcdcFMK6OlmOdBxwYNXMPZHjg2pF9p/SR6weN/665tkYclWHR1go63QxHsTaJsXta82xxbnc+ZYlMj82Xv3MmjIrs00mzKGOvMi9pGe4CY2L4QWytD+PQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=fail (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=OAx0k3FI reason="signature verification failed"; arc=fail smtp.client-ip=40.107.7.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZeOnw0wnm/3k+ts5QmYfqHVsQ+4A3qb4Ew0Cqt77mJoQBa4qrFLLiViuzYHdiBKDnslNYXKJ1c9oxBb0jhEpXGj+DIpBVntBDGKkYS/QNJA5T2naBCYUWhX+m0lvh//l6ijexGx3AKaB34qbcVYfywxBHTr1wIDsdNAw57B0lKPtRsrWIbZmmDUXvrTC/5TuC3jdYb1SJFnprz3V4Od6irc8Ty5eU0Hcf+KsOEdTNWKDtOA1GPmO5BRXkopZwIFHeFN2lBxWQM8uEsB3AXTIJn8HQ6nCA/56EaqQlZpke9oRhxJv+vGdQzlBJMGpe2jNjX49eSHGPacgC9qeJZ1H/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=keWmW4QG47c8JlIcSXN0KjUsVGes5DczVPsN2Bbyh98=;
 b=h2Ig+EA7F2J4n6Hx4NGCGcvDAkK8hNLaux4rcCq3PG1+blWGGBgt9Jjlye4ObLincia3S9Wf/FjeNM+Y5X8bg+h61SUaxMo+defCLdLAM4rfX4zufx+2q5HCoUO0Yp/CTcVhPDKyF4g6u9RWtDaH7kC+aVedKIA0hbi4QsNtWtLICE4fyTXuSYPWzq86tR+pgcsaRYQ1Tv0YmEpdPQ7CRFZbjoZRdbMgefN9WK/JWAJJ52RwxgfgEP6LL0TpideNnCA3Wm5x8TQkIPOpJzbbi/+oaW7MEMNoKWNusO2qNQPR1A1Yr+SbKqC3N6VIGcvFmy7WVTO1VpcL2koZU2e+JA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=keWmW4QG47c8JlIcSXN0KjUsVGes5DczVPsN2Bbyh98=;
 b=OAx0k3FIhL7gHlAGjxabeXEJwm+mlw3WAwKpB6Pd7Tg8lZljzT4iEjNP3TydQDIxX7TagHVDa1EEiKMFiRRsfxgd5yjPU1y4kUb9hUv71NjNPcoY6Q+uz3ZDtoPP9agr18LcYqPuRggHqUwc4E63a9GLuXD5XqCcmpl4/EvMJQs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by AS1PR04MB9584.eurprd04.prod.outlook.com (2603:10a6:20b:473::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.27; Fri, 17 May
 2024 19:15:53 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::1e67:dfc9:d0c1:fe58]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::1e67:dfc9:d0c1:fe58%7]) with mapi id 15.20.7587.026; Fri, 17 May 2024
 19:15:52 +0000
Date: Fri, 17 May 2024 15:15:42 -0400
From: Frank Li <Frank.li@nxp.com>
To: Miquel Raynal <miquel.raynal@bootlin.com>
Cc: Richard Weinberger <richard@nod.at>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Han Xu <han.xu@nxp.com>,
	Vinod Koul <vkoul@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>, Marek Vasut <marex@denx.de>,
	linux-mtd@lists.infradead.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org,
	imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 1/5] dt-bindings: mtd: gpmi-nand: Add
 'fsl,imx8qxp-gpmi-nand' compatible string
Message-ID: <Zkes3n6ZLjIFFQUK@lizhi-Precision-Tower-5810>
References: <20240517-gpmi_nand-v1-0-73bb8d2cd441@nxp.com>
 <20240517-gpmi_nand-v1-1-73bb8d2cd441@nxp.com>
 <20240517203621.72b8b9c7@xps-13>
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240517203621.72b8b9c7@xps-13>
X-ClientProxiedBy: SJ0PR03CA0054.namprd03.prod.outlook.com
 (2603:10b6:a03:33e::29) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|AS1PR04MB9584:EE_
X-MS-Office365-Filtering-Correlation-Id: c5b639d9-77fb-417b-f064-08dc76a5c492
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|52116005|7416005|1800799015|376005|366007|38350700005;
X-Microsoft-Antispam-Message-Info:
	=?iso-8859-1?Q?J0XTKNlRrmR2a4/KtqEAXlYeS00p2ihwppkghNJbqBYj+CsKK/N/TZi0wP?=
 =?iso-8859-1?Q?JH11hMs5NBcLsH6naeJNNBK5qofxIgZIYaY9q3ImCAw7EGv/CBjbhTc5NZ?=
 =?iso-8859-1?Q?cCmKXNgT4nPe6napxlzqOqUVRa5W5RN58k8/T6oMNp/dXvJXy93mXUvtH/?=
 =?iso-8859-1?Q?7VVZolwgybSVBH+vqoGYIi8p5un4oq5h1h+XMq/diTrhWE+/lx3K78Ep6z?=
 =?iso-8859-1?Q?YPbByfM4m+L5NxEe78SpnGmizRGo09O6Ln5JsatTcTfeZaFSnu7RV8cZ4O?=
 =?iso-8859-1?Q?rt0Aa/OUSMYKdtJh+/IR7I1Rq6nNr+1cv1C+qhDlCKlrb/CxZU9tNX/gc/?=
 =?iso-8859-1?Q?uUYZniLiISimESwN8AgtxPKTBTfwmnsqJdkB82ndy1/tPe8xJXU4kFbXw7?=
 =?iso-8859-1?Q?WxKcu+hqNuhANxbf6FMM+uIZHoNdeDLs5jsQKS/GPfuQPkpClu/umGjbW7?=
 =?iso-8859-1?Q?zx5ek9ClE2HFGI0DGPKWpLmEYNLjcwPUwGWUcGkkn2+bMukK4cxARDHAf4?=
 =?iso-8859-1?Q?kFwhALhOHQi3BFdwfdyMmAz/eTxGaKYD6XN58eHKkf3qkbM2++5u27axgF?=
 =?iso-8859-1?Q?g17mYK6mx6+Ot/Plq9pCZUOSR1OmA0wJFnquuasCKnurnKXjbrL9/0H8R8?=
 =?iso-8859-1?Q?mRXpmiqIZHo3w/dlsdNFX9or3ojXWC1gwqjB6hgA0mvAFdhv3OGRYV5lIW?=
 =?iso-8859-1?Q?ObZED4Aja5/MjmfvASQ7/MVaXLqDv01DxmdnHTILWn04P0uFdp+cf4NFrM?=
 =?iso-8859-1?Q?OMVNRZRncrMdJFNYyANgDvVnkCdI8NziHYXNBd6swaE0F9XxlKlD4KvaL9?=
 =?iso-8859-1?Q?fyYmdW8QzzptlMyGNOhaz9E3nDr+BYXxvm0htPgr6q9TZdWKA+adKK/vzp?=
 =?iso-8859-1?Q?TDHiXVL9o79aTFutuWd/VkRKeLq3zEddsG7as0+fsZKvlBV0aIbyDT+jnh?=
 =?iso-8859-1?Q?NtAGfYYf+mReUtQa8TWFpjX0nGINyWBkHzlTo9J8KnKP67SVuNZdWQJHVe?=
 =?iso-8859-1?Q?KGCX0NkOo7qIATP7OAmcqrbF1tC3twRvUVm6Mp0BJamfZ2W+Cf4BFoiMiI?=
 =?iso-8859-1?Q?FH8/8ZjP9SKX4v86uKRku+0D393cDaHw6a6jfYuOlouZxIM7oweu11+Rhi?=
 =?iso-8859-1?Q?46vV1u1wkK4pNVqBR5vWKC5kqAYSWe/HK+LBmNETmm3gsFNGfvcrgfZG10?=
 =?iso-8859-1?Q?N4mc5Yk0sEilDK9pkUIHHdF7QHwO9TyhCLTgWWpyMpBP1dpXNT6jevXr2h?=
 =?iso-8859-1?Q?4tajiLiLPDWP9xeqLGovZ0OllF/QLZ0BchBYYnBb3v53TkFGUEKUiy34d8?=
 =?iso-8859-1?Q?TrpUGKK34ic8jd8mN4Ku4S06GtaQhKXpnGWt8GZ5DNKEo783qC6lgJ/mQW?=
 =?iso-8859-1?Q?Pg1FHiViiUgXFjhWYQJJv6+kec2Ask3Q=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(52116005)(7416005)(1800799015)(376005)(366007)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?iso-8859-1?Q?mgZ912TDCpHwyEwCChfXC84XZJWitiCggAae5Y4WZ484kPaGZIXQu3e27/?=
 =?iso-8859-1?Q?iWkQ43NpEgfkBRU+uTaXEo7actuB/FpJX/0kNR5hozDlg6oiE7z5Fubuzk?=
 =?iso-8859-1?Q?OEfn+Qja3MV6+gqD5m4cxaUxO6szmwIJcHzEXNMMjPF2HCOwBrRmiuVUV7?=
 =?iso-8859-1?Q?mSLxpDcS+fjrjOo8r//cMNOH/1Dw1d4nIN5LZ3s5jGm6o7gc6r0UdXmRF2?=
 =?iso-8859-1?Q?KFfiqlOHRa3jXsH4uN+tEiKjP8KVnWkZUO2N3Ac4Ogo9QGlKjmXL7JMq9M?=
 =?iso-8859-1?Q?kWGu9XMDGGqd/Fl6m9AR9T1A/Txeo19L5uCUwcO4+lE16pYPxIQOJBlffW?=
 =?iso-8859-1?Q?b8qrIXfLB3dLH1OpR+BIyWpnkw12MKjniwi072OJlGh0SVA/MZ8Xbxd1g2?=
 =?iso-8859-1?Q?W/3pwO+uBfU4hh364L7E02enCtADRIoMm9gHWfEz1+udEMB2+MQev+LXW/?=
 =?iso-8859-1?Q?rQoctZYjJ1XdCjGvjqw3ZhzI7eJe7OQ+ARohZO8WZ3HO3n2upG4QREtifT?=
 =?iso-8859-1?Q?vgtprXazICbhxPPugI1reEEfTVdLhM6AB0HNb6EXOyGk5KJqn+wY36A655?=
 =?iso-8859-1?Q?K3coztmN3Ij50jKFju+zcgxwXqkpxO29iEArNlmrUh9cTzZAvdoSgdLJLX?=
 =?iso-8859-1?Q?sGOJu+1QkL9+qqQ3tkhUDwevXWHptCd8RzdXI2S29Rn+cChf2kR+C6EI8i?=
 =?iso-8859-1?Q?ve6IGUgHpJ7Rd62+NcJDDiV9xF+n1PPOT2pDWVcZf3J664N39Dm/IU4keX?=
 =?iso-8859-1?Q?OaPUWG7TWS6i2lALtL7VCvU2TErZ1JiNCoDrLNgbPB8f6Q81dHnMW/w6kz?=
 =?iso-8859-1?Q?iiN9UX89ldrIq1Wnew/V6d9sx4BC9yRGe7Pvr4heo86GQ6HdyYKDmHk9x3?=
 =?iso-8859-1?Q?S2rVqWIGGEY20lKzv53aDQTbukdJxZ8ssrjdTR0cmggruZ5GwdIgODDG7v?=
 =?iso-8859-1?Q?cq8kEAbKLqpCFlhYY7JthrZHqwDVz4F1xzeTFsliV2lcUJMsR9jBprLIWN?=
 =?iso-8859-1?Q?q5sZXHT/XpMOC4nQ5AJ+zEemO4SbjxICFaFnaQ5wckm3VZ/HvElbGo6kBn?=
 =?iso-8859-1?Q?ptwRMqZ/Mze1Uv4vEyQqUjtWcgztcPkawBE8ecmbwu2FJFo0+sE0M89AO/?=
 =?iso-8859-1?Q?YgNIT9lgVY2++QBnZKJy/9H8L2nVCli9BBfc4yOUE8SxL9TSLgEBZYZM5d?=
 =?iso-8859-1?Q?gNqxYr5KAUXcFDwu4l67TWsdNDa5rKcR5bVGFp5ftXjg5ntJ2cYj02STQX?=
 =?iso-8859-1?Q?jUlRWU5IioWNpzoJqCbx0KGumiTakMLpxGObdPclziYlF8nVptnrBl6ONM?=
 =?iso-8859-1?Q?c0ECD8mR4UjhsF7F3J1HUMXy+QauDgl+kcRCP8B0RzMH3GDRdtUzpoHhg1?=
 =?iso-8859-1?Q?lYCjCZS3LvDA7ce3WN2kp5Rb+pCU84IZfep5pyZXo6m7Amd7TaSEmgmCcr?=
 =?iso-8859-1?Q?HGaOVjOuOv1mkJOwfu0O65aFVyeCplrO43GcgyNYAB4Xvpjg0tFQP6LBRm?=
 =?iso-8859-1?Q?nd+sMv8MXOAlLi1CohlJeZJukN1/KUxhr+llLu8AfyZRvAexXGBeEMVA1R?=
 =?iso-8859-1?Q?2fZQFnFQXLIVBLtVobCvRcyi+nlZuHkf//ahKibSvkG2FpTKBD2IfsbH9G?=
 =?iso-8859-1?Q?VQPXB1kAwf9+6D7pJqXl6sJOoupMrlRNSX?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c5b639d9-77fb-417b-f064-08dc76a5c492
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 May 2024 19:15:52.0420
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nSbmFAIfbMsVXlEdA+AmcITV5oo/gtSZD2zj+8UV1rx3WxK2XbL7ijVDg2zcdKikm0HDnKnNDEmfb0U5k2LM3A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS1PR04MB9584

On Fri, May 17, 2024 at 08:36:21PM +0200, Miquel Raynal wrote:
> Hi Frank,
> 
> Frank.Li@nxp.com wrote on Fri, 17 May 2024 14:09:48 -0400:
> 
> > Add 'fsl,imx8qxp-gpmi-nand' compatible string and clock-names restriction.
> > 
> > Signed-off-by: Frank Li <Frank.Li@nxp.com>
> > ---
> >  .../devicetree/bindings/mtd/gpmi-nand.yaml         | 22 ++++++++++++++++++++++
> >  1 file changed, 22 insertions(+)
> > 
> > diff --git a/Documentation/devicetree/bindings/mtd/gpmi-nand.yaml b/Documentation/devicetree/bindings/mtd/gpmi-nand.yaml
> > index 021c0da0b072f..f9eb1868ca1f4 100644
> > --- a/Documentation/devicetree/bindings/mtd/gpmi-nand.yaml
> > +++ b/Documentation/devicetree/bindings/mtd/gpmi-nand.yaml
> > @@ -24,6 +24,7 @@ properties:
> >            - fsl,imx6q-gpmi-nand
> >            - fsl,imx6sx-gpmi-nand
> >            - fsl,imx7d-gpmi-nand
> > +          - fsl,imx8qxp-gpmi-nand
> >        - items:
> >            - enum:
> >                - fsl,imx8mm-gpmi-nand
> > @@ -151,6 +152,27 @@ allOf:
> >              - const: gpmi_io
> >              - const: gpmi_bch_apb
> >  
> > +  - if:
> > +      properties:
> > +        compatible:
> > +          contains:
> > +            enum:
> > +              - fsl,imx8qxp-gpmi-nand
> > +    then:
> > +      properties:
> > +        clocks:
> > +          items:
> > +            - description: SoC gpmi io clock
> > +            - description: SoC gpmi apb clock
> 
> I believe these two clocks are mandatory?

minItems default is equal to items numbers, here is 4. So all 4 clock are
mandatory.

Anything wrong here?

Frank

> 
> > +            - description: SoC gpmi bch clock
> > +            - description: SoC gpmi bch apb clock
> > +        clock-names:
> > +          items:
> > +            - const: gpmi_io
> > +            - const: gpmi_apb
> > +            - const: gpmi_bch
> > +            - const: gpmi_bch_apb
> > +
> >  examples:
> >    - |
> >      nand-controller@8000c000 {
> > 
> 
> 
> Thanks,
> Miquèl

