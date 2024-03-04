Return-Path: <dmaengine+bounces-1257-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 952E887110E
	for <lists+dmaengine@lfdr.de>; Tue,  5 Mar 2024 00:31:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4CC1128430F
	for <lists+dmaengine@lfdr.de>; Mon,  4 Mar 2024 23:31:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E13627CF29;
	Mon,  4 Mar 2024 23:31:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="djzluZWf"
X-Original-To: dmaengine@vger.kernel.org
Received: from EUR01-VE1-obe.outbound.protection.outlook.com (mail-ve1eur01on2084.outbound.protection.outlook.com [40.107.14.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEC4E7C6DB;
	Mon,  4 Mar 2024 23:31:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.14.84
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709595093; cv=fail; b=me0iPeo+tcHUoGXNMJzoejG81FgUauCoRBYocm7MwCysy32x3ArpRSowBTca6z/EjKqj1wKjQXGFMz7bnmlIiKZERFXY+2k4jj+fa871k+gE/yfOECI0hkK2WhexGtHHpkWbHVCOt+VwqQ/2PyTIZonwogX41kQUtmFCDTU40QI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709595093; c=relaxed/simple;
	bh=DbK8Efts4UwblN93q49P8xVX8BTB1VnQnlPd4Aht52Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=pUv94BBKqSEtkJAfXrVj5bQ846wimA5doMFdrZA5DTQ+lENU1vI0cBpFMBln6qpg3M6SEL7A2EYuTlQoVBKF/lR5GKgPB6p+CimjXOD27h/d8iEDhjTG68Uwo9Jx/hDuMGcrJxtuRigkTLSs7bAr5so3BffSoZFj/jAR2fQUlqY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=djzluZWf; arc=fail smtp.client-ip=40.107.14.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gNSBCfpfHoXZEdAUVq7ylcV5WRDPT299XxVaq+f+uuvzPYYZ16XJKd4HUZOsMcvspGQ8jmebS5ybXzbpiHdIcrBs1rC2qZRf2DHBEv/DmNMSsKUncizglT7hDX3koitNTeDahihUkh1x+0U11YHPeBmAUDS2TYw4BBEF5WVVruogtF6Ai6UK61sd45i1I9ga0gK2Svq8xT69zirmI6sA9yEh9ZfqaCr40TjtyaE6sgX8voR+fwe9pD7sNQv07TYZ/rwi2zaojPU6fzzPcjXDqP9hsaVec0sNS4KetvNaKuFUoJUIemkMv0+xN0Zsxlm/QhfWUifpiOEWf+y+nLfC7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Z6kwgEU0eUz9a6KTOvfnNyA2CsHtkRgtOce3ACTxS9s=;
 b=LePeIjdy7jSmSkvH7m5VFkH/uyw0032xtfaBQwqOE5Bzyug8hS+5OtFmWDhYQ+RGKJMYguNZFua4bXRQoJHoopanmY225QHxldn+qy+n5w/D0zkV9AFvPSBgrP6zvVznTni5PYrkRnJcEg1qD4Ir/enY6teZX+cGWeCWFxO/yTB/sY3IDO4t79GdkCjRPm5ZN/NvDgd4aL8eZFdZHtC41GvczMPbDsFFj/FfCBXDPDcmPbW2M5nyGmELHXSjZXnapjEVDewr6BROnMw//8FTTC34mN+yqEDPMMHoJ30t012I6LUrQ92C9eBKz7LkPIt0xi3uqu6I9XibgPvGKWs8gA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z6kwgEU0eUz9a6KTOvfnNyA2CsHtkRgtOce3ACTxS9s=;
 b=djzluZWfLyEzmWW2lxU+ykjiOMgz18sDRMnk43yMtGXzDRHkax3uefRdMNPU/BDm4ogU/z9JqlNV6ALKae/XyqPUcPkmX64i7xZ3QozuJCtaywef8vVSPW0FEgSipXB7Vexm+jgTc+oNRbM8we44TFwYCrBo9piDPWTsV8USxnY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by DB9PR04MB8091.eurprd04.prod.outlook.com (2603:10a6:10:245::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7339.39; Mon, 4 Mar
 2024 23:31:28 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::3168:91:27c6:edf6]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::3168:91:27c6:edf6%3]) with mapi id 15.20.7339.033; Mon, 4 Mar 2024
 23:31:28 +0000
Date: Mon, 4 Mar 2024 18:31:21 -0500
From: Frank Li <Frank.li@nxp.com>
To: Rob Herring <robh@kernel.org>
Cc: Vinod Koul <vkoul@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>, Peng Fan <peng.fan@nxp.com>,
	imx@lists.linux.dev, dmaengine@vger.kernel.org,
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
	Joy Zou <joy.zou@nxp.com>
Subject: Re: [PATCH v2 4/5] dt-bindings: dma: fsl-edma: add fsl,imx8ulp-edma
 compatible string
Message-ID: <ZeZZyTU8FWACW9aj@lizhi-Precision-Tower-5810>
References: <20240229-8ulp_edma-v2-0-9d12f883c8f7@nxp.com>
 <20240229-8ulp_edma-v2-4-9d12f883c8f7@nxp.com>
 <20240304164423.GA626742-robh@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240304164423.GA626742-robh@kernel.org>
X-ClientProxiedBy: SJ0PR03CA0163.namprd03.prod.outlook.com
 (2603:10b6:a03:338::18) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|DB9PR04MB8091:EE_
X-MS-Office365-Filtering-Correlation-Id: 70dae424-a6bf-4c06-b4dc-08dc3ca3373d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	UkGdVO6rV3J+SWjdHn8DU+Lhxe3QkE0gNh12unyQZ6bi9w3//K6B7C7M4tA+GKefaHwqj09+5Aq2jHTRidN0iy8RRoNNCagBqacKX+Fr8PrgPPsNytpj86DaGpbYgwq5Pi1dbhslwmafFXI8Jwbn2EostkHrBvsmqwm4z1Cnb3cGvhQt4j1pcsfI7XsQBaAE4Ymd5gMAfN8AnMoGKeIx+51vL01YSOQhJ1UhjGG5aAuS2PRufJ/RNlR5b3lo2AYD0cD+1AU5oRGwFatvgfYPyl+GXLUHneBd5yu/bPElzx8ukeSrfmWIdRNcMu6S6bCXwvi+JI/7xZxER1Ah9VW4FazGRq7teBpXx2xteNx3Zgo7TjBs40pen35WU50I7Rs2D8NI1WHjUZzZUBiWTMKfoFUko46GhW5O44qYIL3kbSgQ/X0pxR1gKxbTQuKDImW8bGTa6Z740c1/YctcrumJHTvjhGkHWTstqM5/vXlGfFMejSKtnyjo1XSqat6vGAAOHnZjtVPN0Qp8zsbvSIze4otSd1CMvT2rqnrx4TQ2KsKT7Tko0GeI8rXatQRG+CQbjIqva8kS3/qgBrE290qqDtGZsUnJ7i3N/Hfb2JRgM3Mzg6fpMIHQc3l1LGHj2k1Sro1Df6r81fx82mIueKOPAP4QYe7ToO4NSnqzSinnBvcd4ZDUE7mWktsV9952kHAEz4x616M2AXC+ZxEkYMRQlLKCzHzeO2VwOFmluS6fdAc=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?lDY1aHMFE9aJYgwl10SbeaJQ5c2LkJeUEtHR6vRuUfrQD0tI6XpNitEL0TpV?=
 =?us-ascii?Q?8qzPS3EZpwmCvpVAlReTYb4999rXbic0gmepejJ594XwykP761mV45pjVGrh?=
 =?us-ascii?Q?7sTshTgkjkkjn6n1SU4NutI8SRPlj9fYCzfQX3YSRCsrrfPrBjpZhb0Msf1o?=
 =?us-ascii?Q?TNcOUQdeuhwtWhVf4EG/PFTxtfKNMjJNm6ZqRURDUFJbmvmbe8fIrt1Pr02r?=
 =?us-ascii?Q?HY4Ms5lFhmKs/hx0w8EiWKs/xyNz4W38jIUih7QWvLKMOeVf2CrqDygk0U+1?=
 =?us-ascii?Q?NNsfQ+GuK4dv6/7p3dccyMDF7EuAA3n3xuAwe+heAuoWkVIqYW7ivN70y/d9?=
 =?us-ascii?Q?pCVFI0nIvcXMe8Im/i3svQYSaARaezFbndGNyQpqZEP3oZ9Qfbezj/0aAHqB?=
 =?us-ascii?Q?29RYbEmzzsn5GLDR2Tpo8GycESbpPCmU+Z5OvwpvqllIuOAtFaXmMllvZvhv?=
 =?us-ascii?Q?MFpFXDuCXuMx8RSr3MoKM67vdxAfll4JYupH9OHJKzX8/yyAOpuVERR/FY3s?=
 =?us-ascii?Q?+E/hhrvUwaClj/rSu6VKifFgNrpSxlQmNWy7xAPBIjr55jDp1yFNRCjty/wi?=
 =?us-ascii?Q?OfEs5pEPb4J9XP2L22rsMJa6ecMpbdYBl1V65+YXxnqlIFM89c18K26EMD6d?=
 =?us-ascii?Q?5Xf5fq4vKI5TmvLv/SYZv5g4Ojn9/r6oWBckU6iC4WFFKREg3Uf4A2JCw20f?=
 =?us-ascii?Q?FRO+Or7lXvXC5ZLhihVs4qK4tt4fu3hQoQgmlLwWjfUQ/8dVQ7xZyryHwK6W?=
 =?us-ascii?Q?67ZJLjBhL7VXPn0Ehn7HXvAHuORgOrDvP9cl56qQgu/m0NWro17JoeOEiStJ?=
 =?us-ascii?Q?7mAmhu9w4wCani0ryesYmd67XkyzOYB+cDrspsqB9HWjRHqTUefKqYREE4Xy?=
 =?us-ascii?Q?u7rdOTmuHcZKgnpszpFPt1HEWlAo3eQOMPhD1FkzkFjKvR1nDV1GDTN47rRD?=
 =?us-ascii?Q?G0xYVYUJ0xC+qajSYogVMqUHJHq0lDsCEz+KHPMy4Fdgy3Sn1EBwJGA+l7kr?=
 =?us-ascii?Q?7N1mxDVMXXvp2d5BovEOWkz245TVYshUAbU/gt3k3ayZlmykia7cZrQUYMWZ?=
 =?us-ascii?Q?WwfmcWIRUs+Pzebvr/S0xGnUdguswnAKxDK69SDqt2pPthwK6nyuS/1uAtIm?=
 =?us-ascii?Q?1B0isBk6z4iAfENi2YBjRnUrep1vK2g73mYuOjU0hwljaxGtmtdZVc+81x+f?=
 =?us-ascii?Q?LepnkLD6corNrOI6jZqwSOopZdQQdaoDoAFrPklvVlWH1l9bRvtc5A+AHCqy?=
 =?us-ascii?Q?ynbxbwfzWJPCN/KKYvyX631mk6f1dRISltUR1TZuGkq2Tn/vp+alXpfv7YRt?=
 =?us-ascii?Q?WatH8Nc15g745anxj4UbhIn3WR6/W4YyEMj7hHljN2Sg8+xD8XpZT5x1B6R6?=
 =?us-ascii?Q?O+9g9XlPf9rTKTfajN5Hzew324t8y6693jXAO1GX9ZV7GeN1uHqMvgqlvvqB?=
 =?us-ascii?Q?UYTk5AbwoEeT8rjljFLzg+yIILNUGlQZbZNbU7gmhHVQY0lSWP2VWHgQkk3a?=
 =?us-ascii?Q?ohLTOg3rKZFremwJQGjiGGPUcrWwI6anJQdiD9A29EFcFoOrEGnG+z28laTZ?=
 =?us-ascii?Q?6Hb3m6jp9CPln9wXNRw=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 70dae424-a6bf-4c06-b4dc-08dc3ca3373d
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Mar 2024 23:31:28.6624
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sQHfQe5spmSs5n2U5QMvFaHjyozxJtQ7u3Z3Ry32rI0sMPhLJnErsT0vQ5aBEJ9A5K4fDTNizsBy6ga+biR4dw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB8091

On Mon, Mar 04, 2024 at 10:44:23AM -0600, Rob Herring wrote:
> On Thu, Feb 29, 2024 at 03:58:10PM -0500, Frank Li wrote:
> > From: Joy Zou <joy.zou@nxp.com>
> > 
> > Introduce the compatible string 'fsl,imx8ulp-edma' to enable support for
> > the i.MX8ULP's eDMA, alongside adjusting the clock numbering. The i.MX8ULP
> > eDMA architecture features one clock for each DMA channel and an additional
> > clock for the core controller. Given a maximum of 32 DMA channels, the
> > maximum clock number consequently increases to 33.
> > 
> > Signed-off-by: Joy Zou <joy.zou@nxp.com>
> > Signed-off-by: Frank Li <Frank.Li@nxp.com>
> > ---
> >  .../devicetree/bindings/dma/fsl,edma.yaml          | 26 ++++++++++++++++++++--
> >  1 file changed, 24 insertions(+), 2 deletions(-)
> > 
> > diff --git a/Documentation/devicetree/bindings/dma/fsl,edma.yaml b/Documentation/devicetree/bindings/dma/fsl,edma.yaml
> > index aa51d278cb67b..55cce79c759f8 100644
> > --- a/Documentation/devicetree/bindings/dma/fsl,edma.yaml
> > +++ b/Documentation/devicetree/bindings/dma/fsl,edma.yaml
> > @@ -23,6 +23,7 @@ properties:
> >            - fsl,imx7ulp-edma
> >            - fsl,imx8qm-adma
> >            - fsl,imx8qm-edma
> > +          - fsl,imx8ulp-edma
> >            - fsl,imx93-edma3
> >            - fsl,imx93-edma4
> >            - fsl,imx95-edma5
> > @@ -53,11 +54,11 @@ properties:
> >  
> >    clocks:
> >      minItems: 1
> > -    maxItems: 2
> > +    maxItems: 33
> >  
> >    clock-names:
> >      minItems: 1
> > -    maxItems: 2
> > +    maxItems: 33
> >  
> >    big-endian:
> >      description: |
> > @@ -108,6 +109,7 @@ allOf:
> >        properties:
> >          clocks:
> >            minItems: 2
> > +          maxItems: 2
> >          clock-names:
> >            items:
> >              - const: dmamux0
> > @@ -136,6 +138,7 @@ allOf:
> >        properties:
> >          clock:
> >            minItems: 2
> > +          maxItems: 2
> >          clock-names:
> >            items:
> >              - const: dma
> > @@ -151,6 +154,25 @@ allOf:
> >          dma-channels:
> >            const: 32
> >  
> > +  - if:
> > +      properties:
> > +        compatible:
> > +          contains:
> > +            const: fsl,imx8ulp-edma
> > +    then:
> > +      properties:
> > +        clock:
> 
> clocks
> 
> > +          maxItems: 33
> 
> That is already the max. I think you want 'minItems: 33' here.
> 
> > +        clock-names:
> > +          items:
> > +            - const: dma
> > +            - pattern: "^CH[0-31]-clk$"
> 
> '-clk' is redundant. [0-31] is not how you do a range of numbers with 
> regex. 
> 
> This doesn't cover clocks 3-33. Not a great way to express in 
> json-schema, but this should do it:
> 
> allOf:
>   - items:
>       - const: dma
>   - items:
>       oneOf:
>         - const: dma
>         - pattern: "^ch([0-9]|[1-2][0-9]|[3[01])$"

I understand pattern is wrong. But I don't understand why need 'allOf'.
8ulp need clock 'dma" and "ch*". I think 

items:
    - const: dma 
    - pattern: "^CH[0-31]-clk$"

should be enough.

If you means put on top allOf, other platform use clock name such as
'dmamux0'.

Frank

> 
> That doesn't enforce the order of 'chN' entries though. Probably good 
> enough.
> 
> 
> > +        interrupt-names: false
> > +        interrupts:
> > +          maxItems: 32
> 
> minItems
> 
> > +        "#dma-cells":
> > +          const: 3
> 
> Is what is in each cell defined somewhere? If not, you need a 
> description with those details.
> 
> Rob

