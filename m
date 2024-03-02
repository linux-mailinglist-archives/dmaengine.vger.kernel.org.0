Return-Path: <dmaengine+bounces-1224-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0075086F160
	for <lists+dmaengine@lfdr.de>; Sat,  2 Mar 2024 17:40:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 24AB31C21031
	for <lists+dmaengine@lfdr.de>; Sat,  2 Mar 2024 16:40:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 857F71EB44;
	Sat,  2 Mar 2024 16:40:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="RJ8jLgvP"
X-Original-To: dmaengine@vger.kernel.org
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04on2071.outbound.protection.outlook.com [40.107.8.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6232E1754F;
	Sat,  2 Mar 2024 16:40:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.8.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709397612; cv=fail; b=rzGrMp7qAHpW1LtHne0m13JTL/skKKOEwYEvB3xE/kJaw/loFBQ0TeeEPAxM/4sD6lW8GowbLpnHki/h8+0oonXcSRyd8p4Scup4sFvzZupKdIROcqvZonTYupM9Xst+1/V8VKUfKUjwTzCdbG1uItxl5fS0O8z6diBEt60GgkM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709397612; c=relaxed/simple;
	bh=XCe3KPVgdneoGej/3RXbzsV8BVEoTdzIZyC8DA0UlbI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=lKw3m+7TDyHuqosVvTNZPN0keHYShuQRip56XcGmnW6JvgNC7F43udk/mCU8JGfC710llFY51mUFlpFa7XIJ+4uijksD3Er/q4kfAppLW4g2NcQsUn9ba/QEjOr/ViTOVyrDYd0DjfAHmb9yuGk+vkPvHWVNiWxuHmM1LODnC3M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=RJ8jLgvP; arc=fail smtp.client-ip=40.107.8.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KmleEuNkFh+1MNMgONOX1B9QoQtes6IJR6Y/Sofb21yD8Hg8548669S16Gr2SoWeYBidCBSSttfTziY0Kz9v9sO2NvNLhVtVmpAGVJJVPU9O97clF9K+vo8e8pi/NK6HmLVLIlebOGzA6v0/V9KkFcVxCrhQu16YqEYR2hVTe6MYy3h5CA40apxphUJysbYFuHddYoQUhhQSClKoYdSD62HVM4M3ByCyFEiPoTnH1fPRIlW2aqGqGfnFRtxhb63nlOiSoh8K1QUfPYUn1IrHfniO1GzrGope9bBwZB7u1Ncc6irk8WhjVPnC9okKJ3ohO4x/ihbqvv3UGOZ5aeFFWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wjKx/qym+vxobIAFTS0TUlpBqF6gTkkvt3HSxHaSUgE=;
 b=DAjEUk6neyciYzoGfasHzcvEisafCJYp14oEHPIhfOBEfB+5Hp2OVW6fEw1mQEn6vHIWC+L4hqFVJBnLpoWrPzGIXH9PO63YtkXBBnocNeCfQmMXMGnmzUwyjrWBu8hlZclWxVwrULz78Jj8D8CsqwNwdzmIpfN1aJ/Kzk/SMpdTUW2QX5Jt+tmSWyqqR33Ub5cMN6Dxk+LhwP5OQAKy0Y5o5U4rixetNxKzc8uAg5cu1yjNtN3Q5qyi+4XTJh5ZRHP85WPrmGjn7e8nTvPHFnx78PTcRSGIfQq9elOgeuAaw6qblH0MgrEuEarjw3UHzJNMMCETZ/PFJCpVG5d87Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wjKx/qym+vxobIAFTS0TUlpBqF6gTkkvt3HSxHaSUgE=;
 b=RJ8jLgvPFXGswnRhBRHdSSXuFlhSZ/M89qmRUGZuXvGecQSzmGZKg2PvhQLIJBH3QY5qA/Sky2MnMSAdq749VNfhENMpNWt1lHvZfTQjGTmWSpoSZPgadnNQh1wML2EX8r64eMAFO7XS8HG0vm+7psA8z/u/ht356VcLh+bdBXo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by AM9PR04MB7681.eurprd04.prod.outlook.com (2603:10a6:20b:286::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7339.34; Sat, 2 Mar
 2024 16:40:07 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::3168:91:27c6:edf6]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::3168:91:27c6:edf6%3]) with mapi id 15.20.7339.033; Sat, 2 Mar 2024
 16:40:07 +0000
Date: Sat, 2 Mar 2024 11:39:59 -0500
From: Frank Li <Frank.li@nxp.com>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: conor+dt@kernel.org, devicetree@vger.kernel.org,
	dmaengine@vger.kernel.org, imx@lists.linux.dev,
	krzysztof.kozlowski+dt@linaro.org, linux-kernel@vger.kernel.org,
	peng.fan@nxp.com, robh@kernel.org, vkoul@kernel.org
Subject: Re: [PATCH v2 2/2] dt-bindings: dma: fsl-edma: allow 'power-domains'
 property
Message-ID: <ZeNWXxzFBzNj0gM1@lizhi-Precision-Tower-5810>
References: <20240301214536.958869-1-Frank.Li@nxp.com>
 <20240301214536.958869-2-Frank.Li@nxp.com>
 <885501b5-0364-48bd-bc1d-3bc486d1b4c6@linaro.org>
 <ZeNI1nG1dmbwOqbb@lizhi-Precision-Tower-5810>
 <31e62acf-d605-4786-80a1-df52c8490913@linaro.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <31e62acf-d605-4786-80a1-df52c8490913@linaro.org>
X-ClientProxiedBy: SJ0PR05CA0193.namprd05.prod.outlook.com
 (2603:10b6:a03:330::18) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|AM9PR04MB7681:EE_
X-MS-Office365-Filtering-Correlation-Id: 5180ad05-b4b9-4f9b-5759-08dc3ad76b3b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	oY9qpMeKlWqLXfYoxF+liSwsC91ik1TvhD/eEyn8q1OZKBFoA22DJr483FTdG0uFJw8VuZ8hfSzpYItKZf+O7pYIyzdY3jw1VbHzNfIp50vjTvg940qE5+p2YnbtXMS1/Aw2RWv2e9OdKSLxMgQZpsr8LVsPl1cKnXk1/0ID5lnmajRtXbegXY4ynQCWicVpoCsOMRYaCoNo1wkOGtkDBvIW3kLz+ORmXGW57MloDSxm5AM1OzUkbRDJH5Om5WRPF2Ur6z5o0UXEgzHpmC3Y9tEifsY0whpfLJm5Kfm9fR8ZbzdyKCfXMkIUkqOgcmkpBr6KmntTgN6jgzbODLr2vtQbB9ODEdLFLg7P7sIs+YCI5g6ibcYFB5tIf/I1gwphnKqsHLHPuWg0mVQfnydVxlFlWjoQsTB2NpmteMZiIYhXbInf7LsAKTMGexctoRC5sBDfLnivYydmpHnzUpUBBGemDYElbXwrb/eExrecUokI0WsxI1Jz+DNx6v5yyt0LrvQIqVy7VgHkUjoNimWMPYZ0wLMipsixoQaR9Mjn32MXRvNmUna/IdOupPdO/mSaghxdeEv5W7Z8ZMo3JAmiA21SnRCPrZPMXwak+zjPk6O4kvAIG/OuM1K/kHaJNCH7Fa7O1oNg7E5VlLmaD15sDPgEMxr6R1AxbfayjR4oqNLsvckaEsxeXmWO9zycGD7L6JEybsQplLSXMB2xtn3dbw==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?EGdiLv5QlrAvOg2QzoYK1arYbMoARDDK4riXBFx9CV3ZC/HNcIf7PPTjYEjp?=
 =?us-ascii?Q?2KpPtRhgw8QnP9z42TBhlUv2l6Gww9Nkwb+vB3eD8DMBP3uNGD0di2E5ufRb?=
 =?us-ascii?Q?zBHWdwEi3iC5nWOestsE48HW+nPrYpcUG6NrVNHZ4JkobhfMGPaazbxMIWVH?=
 =?us-ascii?Q?ChkVfc0Dv7N6tQrsfstzAj1Rv6GAhnZ/Fsw6rFyldF+bTniJlLDNrTVfzTcL?=
 =?us-ascii?Q?v8An7xB3yPSPZsnKiRfg70xPueExIcqUDhqX8yxPH2Br8ESsuwvBkN16RyyQ?=
 =?us-ascii?Q?UMmu4VKk4dRpKpSiD2zsi2x0yatqKKG9x0VbE1oBULc9A6OqTjo4gMnBu+Vq?=
 =?us-ascii?Q?CSf0MSq5/Hhfxvp43XI+MHmTcPRrWG8wIXBsMAxg3l8QxBatTykcEKcWDk1R?=
 =?us-ascii?Q?ryHuQ0YEnihpa4g4jF7P5Q4OgC+tHutE2/0fOkfmP9jH3GNtQ/70BJs/ekpD?=
 =?us-ascii?Q?362BNvnuu87QTCeTtuLM8j4wVilsvLMIcx3PluA3a31MB3f4TQTLSDQeKwF3?=
 =?us-ascii?Q?POJX6TTEpXNo7q81G4O9n+gzxKlHRDYUengrBg5Gn73stXChIrUUQU2L7moV?=
 =?us-ascii?Q?ITAJUSUaa0AbNcY73VAZc78lIVgGSbjifqBTKbRYGyFNHL/OwsrDSwV5roRn?=
 =?us-ascii?Q?wKaC6NSoUPEsTBGpCv4mGf0V3b7Cb6/rQmJJGww2KmVcwX0YtPSJ/qrWY7sy?=
 =?us-ascii?Q?PeS43Gt3/1ISgSJD1QmJqdh+FERsOvJk/hewDK1ci6OGuNIcLE/8gxLtW7nV?=
 =?us-ascii?Q?rSMxJC0LK39MkHbWFqY+cXbKJF1KhAzp+4rp95HVK01mGgqq8XMeprPVELke?=
 =?us-ascii?Q?Qy0PA6jVJ1vuZnsQAO4rtFK/k9//mENiAfpF0Ylr9FBaA9kVj3kRmmu0+ijd?=
 =?us-ascii?Q?5mHz3AgecHPJONefP5sFhh7AXP0SA8wcLrYYHImHVsy9O6sY+16tu5iJX9d5?=
 =?us-ascii?Q?E5EVwWrIrakE+atp6Sg5sLtDw4sszYm4MeeV+JpkYOMAnMtryNmK6SFYWbvF?=
 =?us-ascii?Q?JFaSNJK288+C1qkHbjhleHI98/nm0wq5CDsm+smvJh+/9IM1sRor61rTZk2e?=
 =?us-ascii?Q?I1BStFe8LdjNUaiGSAt0SHuNh/sYVTIsYakFEG84GAccIjFrCYVSoUExzaYA?=
 =?us-ascii?Q?twmWugENR/6Vfcd0lVZtFy7ncwEPLpEbzlbSp3RoZ4N7KzlZnA3NYi9RLpU+?=
 =?us-ascii?Q?fd2x7oL2XY3fo3bfvFTCvI8HqHNKkm5pP3CahkBeFyOBCfHTiITlXqzl3rqh?=
 =?us-ascii?Q?k9fhTH4F+cIGTk+mL7JEHpl+NuFfgsn74B2LRpIOwe/Fl8QN705t+uu41ddc?=
 =?us-ascii?Q?JGcK4bD6/br6Mf8Fz4NYdQktMtNKdisvRr/qFDSNw+VEFrw7kDZsGax7+6FV?=
 =?us-ascii?Q?Zz47Y5NEaHb82Lv3hLwOQKHDPBE7JNpEMTU5MVDbot9HZ1tNrPtK8c14dpns?=
 =?us-ascii?Q?3WmGusSa1VpRKWd1IRGNz5Jq/qz2vnqTdlqIzjynPUhR026yJmXJGI69n4vr?=
 =?us-ascii?Q?sJvQkbIyWPpE+82idbvishEEyzCGZLAshLOS5VvdZ5vqLtWmfG1UbmL0dubX?=
 =?us-ascii?Q?Q+hysh5X/P0fjxGNzkvwdg45ivV4Y0jsniSAPvec?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5180ad05-b4b9-4f9b-5759-08dc3ad76b3b
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Mar 2024 16:40:07.2508
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tDVOQp/ZCij5Z9flzpCpt/wfBe/UFKIeo+Ab8XabjjQbdaCEdCM/EhoWkg6CaoLrdQDugNafFHs7uDszz46ffA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB7681

On Sat, Mar 02, 2024 at 05:20:42PM +0100, Krzysztof Kozlowski wrote:
> On 02/03/2024 16:42, Frank Li wrote:
> > On Sat, Mar 02, 2024 at 02:59:39PM +0100, Krzysztof Kozlowski wrote:
> >> On 01/03/2024 22:45, Frank Li wrote:
> >>> Allow 'power-domains' property because i.MX8DXL i.MX8QM and i.MX8QXP need
> >>> it.
> >>>
> >>> Fixed below DTB_CHECK warning:
> >>>   dma-controller@599f0000: Unevaluated properties are not allowed ('power-domains' was unexpected)
> >>>
> >>> Signed-off-by: Frank Li <Frank.Li@nxp.com>
> >>> ---
> >>>
> >>> Notes:
> >>>     Change from v1 to v2
> >>>     - using maxitem: 64. Each channel have one power domain. Max 64 dmachannel.
> >>>     - add power-domains to 'required' when compatible string is fsl,imx8qm-adma
> >>>     or fsl,imx8qm-edma
> >>>
> >>>  .../devicetree/bindings/dma/fsl,edma.yaml         | 15 +++++++++++++++
> >>>  1 file changed, 15 insertions(+)
> >>>
> >>> diff --git a/Documentation/devicetree/bindings/dma/fsl,edma.yaml b/Documentation/devicetree/bindings/dma/fsl,edma.yaml
> >>> index cf0aa8e6b9ec3..76c1716b8b95c 100644
> >>> --- a/Documentation/devicetree/bindings/dma/fsl,edma.yaml
> >>> +++ b/Documentation/devicetree/bindings/dma/fsl,edma.yaml
> >>> @@ -59,6 +59,10 @@ properties:
> >>>      minItems: 1
> >>>      maxItems: 2
> >>>  
> >>> +  power-domains:
> >>> +    minItems: 1
> >>> +    maxItems: 64
> >>
> >> Hm, this is odd. Blocks do not belong to almost infinite number of power
> >> domains.
> > 
> > Sorry, what's your means? 'power-domains' belong to 'properties'. 
> > 'maxItems' belong to 'power-domains'.It is similar with 'clocks'. what's
> > wrong? 
> 
> That one device belong to 64 power domains. That's just random code...

Yes, each dma channel have one power domain. Total 64 dma channel. So
there are 64 power-domains.

Frank
> 
> Best regards,
> Krzysztof
> 

