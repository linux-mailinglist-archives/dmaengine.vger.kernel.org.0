Return-Path: <dmaengine+bounces-1222-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A06986F0E8
	for <lists+dmaengine@lfdr.de>; Sat,  2 Mar 2024 16:42:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BD4E51C20A91
	for <lists+dmaengine@lfdr.de>; Sat,  2 Mar 2024 15:42:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A70718B15;
	Sat,  2 Mar 2024 15:42:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="CjSxx4Fn"
X-Original-To: dmaengine@vger.kernel.org
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2060.outbound.protection.outlook.com [40.107.105.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2650618643;
	Sat,  2 Mar 2024 15:42:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.105.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709394148; cv=fail; b=R6SHoZNBE9wEgUnbUDskJVujoKzu6ta4uHai/XFHlS/9AyvcAycfimDN6dLeYvXK3EaNtWRmPNc9yuQ4cb/QQ/Xv3asYpnzbILSxBWX4SUBUK0SQbWSKRB6S7yNcu4jJhbJyU4c/0QYDPIj2CjFB0kZ8fhE2/8hPphE+3xjvn8M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709394148; c=relaxed/simple;
	bh=kpWNcoVGAGW2Uewp5u+CeHnZ4Lz6J12SSYxRHphvHVA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=bvhxqAUmWJL5wEoYXjnlm5Jhp01rxyI48KckLd4wOHD1L9ObTTVr8ie38W8x+nzbCxppPyROmUXJvVgq3DC8OTpsDTd6eVS4tmWRk16IlBundtbSkGpek3VLALFflXBRpS4Pup4AGgNFpdnKSAC7cPQWnDhwOUF/4tyaP64ePuU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=CjSxx4Fn; arc=fail smtp.client-ip=40.107.105.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ccszj7k0uIKHx8kYxyyYK26F3IDFCQaiAC3yWsz6orpUi7ZgOis8jXPoQ/5KH/NJt8/syJ7Ia1Ymdtc0nvwZ8bPFVOB6Ytmy9RUIMnhJIXOM3EqovsYKuaf3rLEWJ+IQoNQ9Oj+xPE9NE7aJRHSWgEJye4ET1kW0A3fUuOPlVH3fSpmV9SFFSnEgVnJhBo/9gBfBQwm2sDMIfVngQ8Zqpk/XwF5cIw/Bti7JU61hxXVy48E2dO06d2jJhxeRDUZF3cZLhICc2/CtPWLPPG/potF+TqEHwT1Zn7FW+nIJYhSmpRvmDEJwlyhYjcgeUggLYRrhO2t+bMOBktHm3isyNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=U0kU3NmwqTgtGqCGCI0PUU2VNccQGYIpFuR6mLWBffk=;
 b=dFIjRizPezVAkWi7VjDXnTlGyAhrZhJpFBvKiYoUA3Pc3bbrtHLcjo0O4DIMQaJGjDMm3r47VTkJ8N3F/t/m+Iya6BQKx3v4bA+Jht39IKPdAppMqL5vWvRtbrgVKVG1XVMYJte5bHSt3r5woxiCq/IgB/DOJxdjS7sO5eHVXYPXTtFe6+J3QpsnhUvCJR7ohy2SO6Xa6jkllQrsAMyNjqY/9Rsd4ITWY6hVkBbchVqllQVWMDSLKa9/n1D+bh53PL1JSLoVd84EBB26vQJxDPS71YLTRTl6t5IvCqccp/Qwo0xLktUUNcyl3h+4vXxjFCIewvK81b0phdLKiJ5r8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=U0kU3NmwqTgtGqCGCI0PUU2VNccQGYIpFuR6mLWBffk=;
 b=CjSxx4FnXh8QJ8M/QzF0/xzwPJvkz8H41SbkI62cjsvfVXkJ/eK/VM088znlOB68xbfDRO9fgnTuiSsYt6qcMP6+hq0VVf8x88XHmdDESDifCR+C9pj9qCw8AJgcdtQK5jvG6O0L8xZsRA9c4q3tKhH3pzbUz0EvR9TXQzEJXj8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by DU2PR04MB8648.eurprd04.prod.outlook.com (2603:10a6:10:2df::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7339.37; Sat, 2 Mar
 2024 15:42:23 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::3168:91:27c6:edf6]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::3168:91:27c6:edf6%3]) with mapi id 15.20.7339.033; Sat, 2 Mar 2024
 15:42:23 +0000
Date: Sat, 2 Mar 2024 10:42:14 -0500
From: Frank Li <Frank.li@nxp.com>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: conor+dt@kernel.org, devicetree@vger.kernel.org,
	dmaengine@vger.kernel.org, imx@lists.linux.dev,
	krzysztof.kozlowski+dt@linaro.org, linux-kernel@vger.kernel.org,
	peng.fan@nxp.com, robh@kernel.org, vkoul@kernel.org
Subject: Re: [PATCH v2 2/2] dt-bindings: dma: fsl-edma: allow 'power-domains'
 property
Message-ID: <ZeNI1nG1dmbwOqbb@lizhi-Precision-Tower-5810>
References: <20240301214536.958869-1-Frank.Li@nxp.com>
 <20240301214536.958869-2-Frank.Li@nxp.com>
 <885501b5-0364-48bd-bc1d-3bc486d1b4c6@linaro.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <885501b5-0364-48bd-bc1d-3bc486d1b4c6@linaro.org>
X-ClientProxiedBy: BYAPR03CA0013.namprd03.prod.outlook.com
 (2603:10b6:a02:a8::26) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|DU2PR04MB8648:EE_
X-MS-Office365-Filtering-Correlation-Id: da8e4114-92f2-4379-af81-08dc3acf5a65
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	rQ7gOoYQZtl3ocmtGLmogx1BV6L476cVUv5jnBexz53acC1gC3fZNt5aZPYwxgcOjeqmVlUwsfNvCWjDtOROFr5CvesXQYYR+tzzAyEG4DxH5yPBZgbqpfwDmYIvWbeosll0q65pNAlcY50yZ39koPgRZNcg7WArquStkNzSqPtIoa2jgKW282JB4dFgfqUtL4bm5VxM4lZ57gaIfem9obSOM6RDREZmN/UESUwfe/toSvPYJYblt+DzwB/o8P+hqunzC/rXxg0t3hLy0BUygkT/p+dlxJU0GfGD4HI28nCXHGmAcEvg4FjCktNbqBS7p/xZl8YGGyjXHya4YNudIQxO5BMLHUvE6/5sjrkpikxOXVpHU6WDw+D5qW+ZCcz9W3ETe4+q6UfWElqvbFi+R58Xrg2qRDwrRIep1JIK/SQMRVezKqNlbams3c2F95+24+LNKi1P7m2zzPiVLTsSN5kLowL4Gc3P/y44NGGEJ4ec5kb6Ul670gfZMFeiiZ60f5mP3te/YDtV58GPvAW2eCeXs4qVAtfn4Szw57kZKL1O2MB0gCTp3Q0mryMvYxCV8oaQEat6HnTjbn+r+JGy9kWJ/fhw3Xw5YFIJlLjr+yBBtFX4zTXj6c/9mBf75wzDSKnNSz4fce/buvlUWKbeTaS6vGUHXYvonnGoAyIFWaWeZFhUVu1UHstQ6xC8B1ZGd5aYFvwLUuFj4sbArugArvQSjp+xCjFhB+cJptHTzgQ=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?xvcnxJmCEJ2s2Vq22H2ZuObSOMpEvguJqLHSeTGINhKV/jtGKEzDmvN9jERe?=
 =?us-ascii?Q?v7E9+4lQTyL6WyE5jpzTqD8SoSB5R8qEVXUB5P2z16kZSXiOiNt1ZVufHZMk?=
 =?us-ascii?Q?0jp0jvj/vsgg4b/K1waGRHATGVTCLqFNxabcDMbONBSlnUEpv1wrlV7bNdUf?=
 =?us-ascii?Q?rRIqaFI4tIdDupNXGG8wi7IWeHL0Pl7rV+06ZVgQ4xy62hpTliao0tzvGuc4?=
 =?us-ascii?Q?sMqAk6hMdzWHFq3Nl4M8zAtM6406tPSzExGGBnKm/KTBpGiceOkXR1SYkDB8?=
 =?us-ascii?Q?i6wz7phKhL5jf19HMn2kqD1pacnRksCz3ZxdsmPcnCx2/7UDLmUZTMiamcZd?=
 =?us-ascii?Q?kWxcN0u+ZtVB5R8WulKzlirk4naGxRHZ+vr/xxrFYSqhLVgrA2/NyE6ufEfm?=
 =?us-ascii?Q?QnpzoamFeCIkFJYY4IoipljNEAHKiKgffHALjc5dpy8/YbtGyaMFWB9R466G?=
 =?us-ascii?Q?RaCHoDlIo2TZd0/WbjobwV2iupX17/ell9qB7RbwclZedqAJVoDzpve30mLP?=
 =?us-ascii?Q?/f2pgmigExlTkVkBR3vsHev+n+nfXxaukd/hG0K422M6LFgs4IEYbm4IhRxu?=
 =?us-ascii?Q?OtDZEIhzaZYRL+WI5PWhhddCup5GxIP/7eKn9V8XG6rEcIwZ0+urnb+btXp/?=
 =?us-ascii?Q?87zSnM7iyXPRtaDsgNqm7BnbbCyAJ5sM+cJOKHLod88/4SDdNnTM3nyeWUiN?=
 =?us-ascii?Q?i+RhtNeZAMcimUD+1HUIaV6EANNDIyT6gmzhbwb0tKNi1Z9qXbmvGrJcwv2I?=
 =?us-ascii?Q?hOmQVH1FZhPd8VYtz/SEuQMaDqtjWy2dLfRTzpaDP7vCjlMSWc8CdMS/hkXQ?=
 =?us-ascii?Q?12YQ4fP2nLzZ12R2kbPRkQz+WL9/THNc5vHzSvyJ/Ts9shli0bwgIkm1UQs2?=
 =?us-ascii?Q?XPmeMuMz9VuwZt1fV+9Dc+09A3wM5ydGtxB42aJHScEhlvwI9xWdxz8eMaLv?=
 =?us-ascii?Q?iWwMoNQf5wB1mmZp5d19ubO/TnAbKRCqdu+uJuW5t95O/0eaEdo+bL2xmjK2?=
 =?us-ascii?Q?e+Ni1I7N18P6vIOD3/qE7xZIAxX6OvALoBqHzdGqQayE0OGXIC2WwkMIlTh2?=
 =?us-ascii?Q?+pzuE4xf0dmXHaTC6HksTPThlxkzFIQqDqZhzyRkeM/ATgJSeBYD4Iy4Qt2c?=
 =?us-ascii?Q?LxsJgcUUtamZC/QzjhuASP3bp08K4vP36+PXWOwhoJlCHBXzqcG0p/vkGqOG?=
 =?us-ascii?Q?jCZ/jtUEOF+B//3ME0sp+1gaB05kJ+vYfs7kiryicVAwQ6rrdH6gwYIq2yvF?=
 =?us-ascii?Q?Iv/7RpHQpPRi4yyGy1JFzQBv2AYNW/ehqobDeJDt1qHgge+uuGiDNB+9Iu3t?=
 =?us-ascii?Q?vOISXJwytgnyufTheKz2ErbLwrpOMA7NsqXEtn6PB9Fhns64U4S/G1sPqv9A?=
 =?us-ascii?Q?IxidkdPa1Iojs4hp06L+uQMoCi0f28I3zmH1sJbNaIcXSCddA2vkOu4GuY7d?=
 =?us-ascii?Q?2gnTHopIyp+ZDuHOW6tXdzIx9CvHkWz+vePkffjLCzSLXIZgytLpTb4NZbat?=
 =?us-ascii?Q?I33YFSfBrbZ8ZVj1bl0BTdTO1KGJNP528+m8LDfX1aubdQ55Gtd94+/cptT8?=
 =?us-ascii?Q?HMXyhNRNEjFwMa2oeJI=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: da8e4114-92f2-4379-af81-08dc3acf5a65
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Mar 2024 15:42:23.3320
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bFHWbwAcn8nfTVzOTJcaWmkhgiIWXahGCd3og5j/dPtHiEZP0Vvv5+kCu8n5M6EQ5um6P4VHpOa/3Sr0aH9mrA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB8648

On Sat, Mar 02, 2024 at 02:59:39PM +0100, Krzysztof Kozlowski wrote:
> On 01/03/2024 22:45, Frank Li wrote:
> > Allow 'power-domains' property because i.MX8DXL i.MX8QM and i.MX8QXP need
> > it.
> > 
> > Fixed below DTB_CHECK warning:
> >   dma-controller@599f0000: Unevaluated properties are not allowed ('power-domains' was unexpected)
> > 
> > Signed-off-by: Frank Li <Frank.Li@nxp.com>
> > ---
> > 
> > Notes:
> >     Change from v1 to v2
> >     - using maxitem: 64. Each channel have one power domain. Max 64 dmachannel.
> >     - add power-domains to 'required' when compatible string is fsl,imx8qm-adma
> >     or fsl,imx8qm-edma
> > 
> >  .../devicetree/bindings/dma/fsl,edma.yaml         | 15 +++++++++++++++
> >  1 file changed, 15 insertions(+)
> > 
> > diff --git a/Documentation/devicetree/bindings/dma/fsl,edma.yaml b/Documentation/devicetree/bindings/dma/fsl,edma.yaml
> > index cf0aa8e6b9ec3..76c1716b8b95c 100644
> > --- a/Documentation/devicetree/bindings/dma/fsl,edma.yaml
> > +++ b/Documentation/devicetree/bindings/dma/fsl,edma.yaml
> > @@ -59,6 +59,10 @@ properties:
> >      minItems: 1
> >      maxItems: 2
> >  
> > +  power-domains:
> > +    minItems: 1
> > +    maxItems: 64
> 
> Hm, this is odd. Blocks do not belong to almost infinite number of power
> domains.

Sorry, what's your means? 'power-domains' belong to 'properties'. 
'maxItems' belong to 'power-domains'.It is similar with 'clocks'. what's
wrong? 

Frank

> 
> Best regards,
> Krzysztof
> 

