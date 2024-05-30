Return-Path: <dmaengine+bounces-2217-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 429C18D4F94
	for <lists+dmaengine@lfdr.de>; Thu, 30 May 2024 18:06:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 02A0A2869FC
	for <lists+dmaengine@lfdr.de>; Thu, 30 May 2024 16:06:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 803D6208AD;
	Thu, 30 May 2024 16:06:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="qchonpc5"
X-Original-To: dmaengine@vger.kernel.org
Received: from EUR03-VI1-obe.outbound.protection.outlook.com (mail-vi1eur03on2057.outbound.protection.outlook.com [40.107.103.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E587B208A9;
	Thu, 30 May 2024 16:06:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.103.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717085192; cv=fail; b=gnrunJ4nzGB/4h1AIdIdBIDUeQHT73C1dU2mCAgALnPesDZlywN2K6qMHdchL8+BzEjvYYn7sbeiFcJGxTzMPa32D55bq40v59awZQ7BxapxI8A6dS9D7jaoC9qa6Vvd8Mv6msEooxfX3mOeSx7ChpLCEr960h1p/tK2eU68Kh0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717085192; c=relaxed/simple;
	bh=MS0Om8B+WvuB793BsPQlv8XGluAMFEsPvfJk2J+vwVA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=E8FJU1x96jOCOoD0cxPDJl28M32fQstqUgmDOz6RRA/kyuXmricV4dvT5YnAH4LUICEal8nsGezKykRV+IyPF/CnB/SNM3Pnq1NvA9aPIYD0zf1fJ3FOJggTUFF7VbsWBntxsHl4GdCUC9Tafa3oQP8sYM5cmbegyTe/2u2rTtA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=qchonpc5; arc=fail smtp.client-ip=40.107.103.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EJvXSiUWVAkktRW/1kMp0zEJCj90+Hk2FjY+YVhn6syB3GnziBMBbJe0vKk+K2Cwn1CA7S+nQmgIReyrshHik44oO+ZMtvioQWOLRLjmSty5WQ7qYvO844aNRhcwst3LPTCPXBJ198HS7LRTk9BqnvBmWjnXmwO4SUc/VG1DgEQqGNWQ5QXAl7b/L0SjZ4ACRr02/6kgZPN0XSiGnw0/ZKCHh7M/5weC+Zq7t61xvrGB5FcQO0LyiioOT7P5owp1LBOyc8DoDUf6wA4rL9j50UZVZHFlRkIOK4tpcVSl2jhGx5JQOHFWSiSe31uWdYTv/4VdefpkM5POJ3sIpJohiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vvYg98s6lGQaO9ITOPF9dmvyf2BxPY9lru7wuNu0uuY=;
 b=LDUkFqr2aDn1K+t3uySLkmNnLHwpgL7Emeepy7XtylMD579dJWqzd4VUXt5Jd2QFKDyqz0nGzenf4apZmyberkvOUIvUL1D+cgxIMCZeOsZPEI9HWghCFwrfnkRiRdhCHP5RUHWLqDKIJw/0Qf26HrEDkNoig9XSGOGKCy5O0ZgLDHDtL7q7TXQZgmBuNi+c/DAirleH+t+LYOX0QMiq5u7lZQBpWvHlBaSxis30eBvVq/Oem9vHQkvB5AdmVLONEhtdqJICP8Cpo8SsFJ6OxurXtz6PvQfTkBZb0pRu8LYIqKZa/minGHphatyWgnGRTZ1HtFLjoKXDDFL6s64+xA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vvYg98s6lGQaO9ITOPF9dmvyf2BxPY9lru7wuNu0uuY=;
 b=qchonpc5MUVbAzEvIzZ4xFDz1H07Ozlt12YG/tyc/+5Nckjdy91q9f6Eq65b5Zl2/qEmjKvWjZOLUkmEzj+abR4dbsRqBt8NQ9KavBF2Hqj90z7aPMyRHkATX1OTub/PPfXqtQSsKlRFRhl/LmUfcv24BiFwMrKgbwoNGhNpWhk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by PAXPR04MB8749.eurprd04.prod.outlook.com (2603:10a6:102:21f::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.21; Thu, 30 May
 2024 16:06:25 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%2]) with mapi id 15.20.7633.018; Thu, 30 May 2024
 16:06:25 +0000
Date: Thu, 30 May 2024 12:06:16 -0400
From: Frank Li <Frank.li@nxp.com>
To: Animesh Agarwal <animeshagarwal28@gmail.com>
Cc: Vinod Koul <vkoul@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>, dmaengine@vger.kernel.org,
	devicetree@vger.kernel.org, imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: dma: fsl,imx-dma: Convert to dtschema
Message-ID: <Zlij+FgY4ul7ZwbA@lizhi-Precision-Tower-5810>
References: <20240530072113.30410-1-animeshagarwal28@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240530072113.30410-1-animeshagarwal28@gmail.com>
X-ClientProxiedBy: BYAPR08CA0024.namprd08.prod.outlook.com
 (2603:10b6:a03:100::37) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|PAXPR04MB8749:EE_
X-MS-Office365-Filtering-Correlation-Id: bc2d2531-d04f-4860-f8b6-08dc80c274c7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|376005|1800799015|7416005|366007|52116005|38350700005;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?rbYpvclWBMXppoox+X6Gm744Cm4xpZ1kqux6X6t/QMWB+D7md4AeQcwndktg?=
 =?us-ascii?Q?YzVxl+U3W6tepJ06U6088rV5X5XrNDIWEyWTwtLj0X7Z3P+gNCRPiOVdCd/h?=
 =?us-ascii?Q?WZd/hKgoggxoOZCSnnX2SOVWfSf44RsmFtYMVXk9+12Gcz7ifiqSIDARyapY?=
 =?us-ascii?Q?wRL5PsEiI+hMiYZ+eAYXG7AN8JllhbsKC94vNbTQJuECZNeZ/JNrJ3RcydU/?=
 =?us-ascii?Q?/NRCXMF9Bi8OpegKDiRzhqN+6Bj47DQHqBzLL4J7m0dBaJL795+lEa8IkHBb?=
 =?us-ascii?Q?cx2hCz1KEq0s0x4f/YfsJ1xg5HkfrNCtGaXPf9CbdX87aDh8ZK/aKn4ewJ15?=
 =?us-ascii?Q?q/4MJxhi/Fw3nOAylGKHrRsINS/aDvQWOE+06kwuNy1di0uRKyzfVYisT0WU?=
 =?us-ascii?Q?eraJ1JF1hUCDhf+pZGCtVy5aBmnDmZdGpoxYtCbTYXtJMRUIuO7KEj5N9nHY?=
 =?us-ascii?Q?Uw835Y5dDqpHxyDQen1i6C38GdkQUqB3/682YUldTbWNSss9jGoVsl/+jBKd?=
 =?us-ascii?Q?aIVbMNSudaaaYqJOJ2srI1ToXUvTboU4J4WSD2aqT88X2icnWHEaRbB+PIHb?=
 =?us-ascii?Q?BQgMdVnAvfZltB1sXgnO94cAF7Ppu/umSzR348oBFqRAiUtkMNMNFvoifI+Y?=
 =?us-ascii?Q?zwta/W5UJHMN1wqcRL2lRAPzFcBH/Z+XR6/bXBxeExl8NneWlqoH6kdCiReX?=
 =?us-ascii?Q?62DCdGtPFHlTc+6aSOuDubniAMuV5utr6nism/M0SjZxGxkDWAFXlSVJWPq+?=
 =?us-ascii?Q?3IobFdN99M4iE7nKj6LdDMJ+xvbZR20DUT2c/WAMs9ULDoqbAI+xOkhfBucR?=
 =?us-ascii?Q?BH7Qjq4Kokl0opY2nLWySf9L+0nBwCJ/So0A/72nESwk6M9fJBsmROmiUipt?=
 =?us-ascii?Q?qbIxrBFQmYXSgobNcZ48GFbgGNIXwVHocUJIFKw7XUQA6q3nvM/IIODa6cXe?=
 =?us-ascii?Q?CA2WWiIAc1/ZzAKQe2FTBBEEjlgN+cDPfhpMbKWqClCjm7kRF94BEWtXu5/C?=
 =?us-ascii?Q?67NNrTsstEj/+416J3oBrOBMRCam5TvqtAzUPqY1GjnukS774lLqSlzNloag?=
 =?us-ascii?Q?Uk4h4nLKR5k/WvHPHPQzajdwdYUGpE2p52LPa6Y1lXOSvaMfaX3CJYrgUIxk?=
 =?us-ascii?Q?do/Vzec2oK6XUisOhlFZSk/z6/3cAAuR3wX8fnekpm+iVL4JB8gEif8PpQnf?=
 =?us-ascii?Q?MF5h69U1xjaxXmbSo/vrwZBAb3fnb150j2q8WYH5SXAPZwlJ2AIFW1S5oQ6l?=
 =?us-ascii?Q?u84qIsuXiA9JBwidyTmligOXo8DQJWYpGljq9r/9t3knOtOpcF6b8WDo9dyp?=
 =?us-ascii?Q?N30=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(7416005)(366007)(52116005)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?q6t7sVHYJzMgIXGjaEzmaMMQEg7uM/ftibxp/KJYTmBPrq7DOI857/U5y8ZH?=
 =?us-ascii?Q?00a0Oupjrat9MXP+JMvxfcuLBE+8Gr+feuNjRZl3owl1YmXdZuq0zgGUBHWM?=
 =?us-ascii?Q?TkTl94Cu+XDdCUpRT5bAZA+DJHK5yQ5CQOJrdYTuuo7ZerLP4LVsCE7WDi0p?=
 =?us-ascii?Q?Jy0Tv/+GG62mNVLX4qXNeTdF87WncXBFQ4TSdHXxvyS3YKoYYMFAz8EJ+gfW?=
 =?us-ascii?Q?0kz34GCqa6WZYOO3Lu+6+4NvbUJUOZ/iClHB/z03emHHj9iZvM45MFvu/4ST?=
 =?us-ascii?Q?BS0Gm07o6JlPAr3fCcwgzfLfbJlgwOgGniGXEyQ4M0toj+wOJRLdW9JGfrJb?=
 =?us-ascii?Q?oTe7MkqK6+VxC0fF29AIqP9Lo/6EVVfOz4XOu2EK9DCvhxe8m/jvOAr5JT96?=
 =?us-ascii?Q?Fnxe99iwMaL4Sajs/dOwqxuE+Hhcc9WIsjj1FOPZjNTNCvWEuvytb8D9FrwT?=
 =?us-ascii?Q?dI9kMLk/W7RehGuO3PHPuYzmEZcyglO6q4WyFS6vAb0mQyJs/OBzMYtNb/wY?=
 =?us-ascii?Q?cinzgyP2Ug5/pFcjci2dcPtiPjiseQITK2ScFdndGuV2eS59wrVmUZXbW2ya?=
 =?us-ascii?Q?M/MWHBQQN6DUWl4xmHFqCbJCRbcIA1XQf14wPoFoOJk0sS3bcCo+Qw+8Q3SX?=
 =?us-ascii?Q?sUHulDaulYgmpr36239lpeLtGV7L/LBWnhoWr5xH0mhcK3bXVDGfFbn/Bzzo?=
 =?us-ascii?Q?VSauabnMbGYU+Zl7ktp16PgvbO8pIpzTrrzeyFLxiSas4GLeq/em8yjs5Oqa?=
 =?us-ascii?Q?IPckKlVlt4dYQsBJwrDaznI8nqvzB5tXCWrzFQBe7qxZ9DLYk9u5ZkVdnrjb?=
 =?us-ascii?Q?ZEVk+TWQnsbJAVE4IRDYvN5tyiet7/5SDSmsPgtx2ZGlkITGWvtRUeldy4O8?=
 =?us-ascii?Q?9kh08Rj5uO3DK7BlonQY/itzg1W48gtTeG+P00qANQchuT11pgS82/sDW1Hm?=
 =?us-ascii?Q?4frg/NE5LJvENtZFmeIMHugufyUw0OPrJiX/idIKOHZsc5nM/WCi3ped9j6X?=
 =?us-ascii?Q?gQvsj3AUaiz2doC/zPSA5x/AU2/alIhq4+hItSahTbdD+MLAiqubQ/nIc2uP?=
 =?us-ascii?Q?aR1UEcBeYKVXVG/wlnUNGBIb+EIz2G6Qid+pgq5mtsnbVavT+0X0juwea1n5?=
 =?us-ascii?Q?mSzH6AnkCdus1jZBIL8shUeNlaBWS7lNVWApuIqBiba0XvUW8/5P3cN0Q+R9?=
 =?us-ascii?Q?Wh/qu0a8/miJ3WMraURXG3KLXTRAvgqoM8zE844I7PBxwWXkc0lZaH1pYU36?=
 =?us-ascii?Q?8XyNxH5Yj7/IRvYBViUHSn+bYhJqcdjUc7Yji82JiLSbC6kMi2X2YooXPd7g?=
 =?us-ascii?Q?RI4/A7bpwwS4d3m/1MG8JiEZTZFTI2Zs4t9eT2T3HtME8WSibq2Co3yx9go+?=
 =?us-ascii?Q?n4KGGYBROG50y87HidezUkd8aE8Yse99Py7s5tFrCKzDgg3zF7xUXsw6KEzF?=
 =?us-ascii?Q?adNwqmT7hCNB/u5kzNEQGraQBl/CgzfFXMiEDkgs6Edq0mctGGkcczUvye7B?=
 =?us-ascii?Q?usOYV058X4U0sdHJGOIfd3vBTDA99Ajz2hJZVzyFGewgwKPt3nNxZzERLCg3?=
 =?us-ascii?Q?LjeZAuz4/a0/aC0r3+dUC7A59gVMYCMtdbcYkwP7?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bc2d2531-d04f-4860-f8b6-08dc80c274c7
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 May 2024 16:06:25.1952
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MXn/IJZK5Ix7+M5wltFGUNm2s92c2DZHFwFcyBg65HXhXO2xcCRtJ+DV+c834gCEtUp81vd1qhYUniTo0mz0Vg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8749

On Thu, May 30, 2024 at 12:51:07PM +0530, Animesh Agarwal wrote:
> Convert the fsl i.MX DMA controller bindings to DT schema

nit: need "." after sentence.

> 
> Signed-off-by: Animesh Agarwal <animeshagarwal28@gmail.com>
> ---
>  .../devicetree/bindings/dma/fsl,imx-dma.yaml  | 58 +++++++++++++++++++
>  .../devicetree/bindings/dma/fsl-imx-dma.txt   | 50 ----------------
>  2 files changed, 58 insertions(+), 50 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/dma/fsl,imx-dma.yaml
>  delete mode 100644 Documentation/devicetree/bindings/dma/fsl-imx-dma.txt
> 
> diff --git a/Documentation/devicetree/bindings/dma/fsl,imx-dma.yaml b/Documentation/devicetree/bindings/dma/fsl,imx-dma.yaml
> new file mode 100644
> index 000000000000..f36ab5425bdb
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/dma/fsl,imx-dma.yaml
> @@ -0,0 +1,58 @@
> +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/dma/fsl,imx-dma.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Freescale Direct Memory Access (DMA) Controller for i.MX
> +
> +maintainers:
> +  - Animesh Agarwal <animeshagarwal28@gmail.com>
> +
> +allOf:
> +  - $ref: dma-controller.yaml#
> +
> +properties:
> +  compatible:
> +    enum:
> +      - fsl,imx1-dma
> +      - fsl,imx21-dma
> +      - fsl,imx27-dma
> +
> +  reg:
> +    maxItems: 1
> +
> +  interrupts:
> +    description: |
> +      First item should be DMA interrupt, second one is optional and
> +      should contain DMA Error interrupt.

items:
  - description: DMA complete interrupt
  - description: DMA Error interrupt

> +    minItems: 1
> +    maxItems: 2
> +
> +  "#dma-cells":
> +    const: 1
> +
> +  dma-channels:
> +    const: 16

I think it should be maximum: 16

> +
> +  dma-requests:
> +    description: |
> +      Number of DMA requests supported.

No "|" need here.

> +
> +required:
> +  - compatible
> +  - reg
> +  - interrupts
> +  - "#dma-cells"
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    dma: dma-controller@10001000 {

needn't label "dma".

> +      compatible = "fsl,imx27-dma";
> +      reg = <0x10001000 0x1000>;
> +      interrupts = <32 33>;
> +      #dma-cells = <1>;
> +      dma-channels = <16>;
> +    };
> diff --git a/Documentation/devicetree/bindings/dma/fsl-imx-dma.txt b/Documentation/devicetree/bindings/dma/fsl-imx-dma.txt
> deleted file mode 100644
> index 1c9929d53727..000000000000
> --- a/Documentation/devicetree/bindings/dma/fsl-imx-dma.txt
> +++ /dev/null
> @@ -1,50 +0,0 @@
> -* Freescale Direct Memory Access (DMA) Controller for i.MX
> -
> -This document will only describe differences to the generic DMA Controller and
> -DMA request bindings as described in dma/dma.txt .
> -
> -* DMA controller
> -
> -Required properties:
> -- compatible : Should be "fsl,<chip>-dma". chip can be imx1, imx21 or imx27
> -- reg : Should contain DMA registers location and length
> -- interrupts : First item should be DMA interrupt, second one is optional and
> -    should contain DMA Error interrupt
> -- #dma-cells : Has to be 1. imx-dma does not support anything else.
> -
> -Optional properties:
> -- dma-channels : Number of DMA channels supported. Should be 16.
> -- #dma-channels : deprecated
> -- dma-requests : Number of DMA requests supported.
> -- #dma-requests : deprecated
> -
> -Example:
> -
> -	dma: dma@10001000 {
> -		compatible = "fsl,imx27-dma";
> -		reg = <0x10001000 0x1000>;
> -		interrupts = <32 33>;
> -		#dma-cells = <1>;
> -		dma-channels = <16>;
> -	};
> -
> -
> -* DMA client
> -
> -Clients have to specify the DMA requests with phandles in a list.
> -
> -Required properties:
> -- dmas: List of one or more DMA request specifiers. One DMA request specifier
> -    consists of a phandle to the DMA controller followed by the integer
> -    specifying the request line.
> -- dma-names: List of string identifiers for the DMA requests. For the correct
> -    names, have a look at the specific client driver.
> -
> -Example:
> -
> -	sdhci1: sdhci@10013000 {
> -		...
> -		dmas = <&dma 7>;
> -		dma-names = "rx-tx";
> -		...
> -	};
> -- 
> 2.45.1
> 

