Return-Path: <dmaengine+bounces-1226-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B1B786F169
	for <lists+dmaengine@lfdr.de>; Sat,  2 Mar 2024 17:47:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D9C591F21FA5
	for <lists+dmaengine@lfdr.de>; Sat,  2 Mar 2024 16:47:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AB742BAFB;
	Sat,  2 Mar 2024 16:47:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="gRgoImfW"
X-Original-To: dmaengine@vger.kernel.org
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04on2077.outbound.protection.outlook.com [40.107.6.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1991422F0D;
	Sat,  2 Mar 2024 16:47:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.6.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709398054; cv=fail; b=CwhvM7Lj3f/JTg7Cz4fBZQQRlF7MVRLpLKiLWulT8QLDi8Yjfw4yqkthB7R3jMYlf6K14rMDqSfgKk90htJYQQF/0DG9gJgw4h4MaWtU0/OA/z5nAfpkzktwX7ZW6FGAxG206D2tc3qTWlIJSkQ4gLhKGT6ANlzBq3s+eK2IuU4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709398054; c=relaxed/simple;
	bh=YNqgsgdJaGIjc5HGvVaaIsctI2PDohhUrI1s8ZEfWEU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=lppMt0dcFchfZSj42R1mt0d7ptlq/kaW6bbKezWoVGLs3q8QWPGISTzNqGN+48AdAE6AFwtjPJm7xEntaYg9mYw4w220h5YUZQRncTdYGQlD+VwwQaROifWCqTvl3LQzL2xee5qf4it2mQ+Lz/0srUUl4C1K8BlNj6La9kbCOBk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=gRgoImfW; arc=fail smtp.client-ip=40.107.6.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eLH4Eww6RsTnTJseSxPxr/KeBMJyGqn09AC2kviQkgR2WxdpYVqpLCvJfpYs2wsOP2EdZPtZ1+Rx8egWibvhInqisnqAf42iL5tw6lCkwNILIe3t4NbVr0OCD8hcB9j/XnUC6NZKf83+APWBIpzq8gG59gvWzcxq4AnuD1Mopqrop9w9WfSQMV+8DKveadKacVb9KXPfYkZnKTViqZcffsF84SiBx+VfZxQWUeQxkqQB4VBCnW1irD241gCdBSK2OoszAX6ImU7UXRuyz3VnuSODwh7TzFfMgBwVCTyxDLVLrepg3LtbpV3obqaWz12P01TulwEzA5V5+bd5O3A8Bw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KgW/qoL6g24dEqlgq99jl3UBJgS7x6x4PL2921EJrH4=;
 b=Ach62UIvEwqekVz7UhY5cAH5u64qa+ZtR1cuLeOaUYKVvTZp5vjRLBhH7CAOVWE5M2sai24XcAOY3aIk+lQLXMPwg0i+QVaB1VIIyf6Ibr078novnU3AQlhdxttwevbA5yaxBHOM12PlO4n77YAaPwimmoDYEdtjw4uHaSo4UYI5tND3oaj0I9leuA1NjFK3DDB5y/285r4vO+3MzNSkNj5ka7SF74PnvplT544w4s9n3dUXtcIhqYpe3LNl3zKDeMISYXlnyOztpQCuU4q7d9l0b+AL4X721rhWF2INCATpdLnCc0mseh3q8iRYCGTi4w3hyh7/cRDJGZXMIKgUHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KgW/qoL6g24dEqlgq99jl3UBJgS7x6x4PL2921EJrH4=;
 b=gRgoImfWFPaoW5Ah4Ph6RXdjv8O2iSDEsF2IykGf1X8kGry6nFrW1F+zy2yIAucNksNYh/8RvgnDupQHScir22hSjqcSW5Ibp8Lqux7R2BomRyGd81a6XgvCtyrXKAg+HiRFJiC1P+YkaNDuvQ3gy3cfyjfwd5CkBxOIaFg2R2M=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by PA4PR04MB9638.eurprd04.prod.outlook.com (2603:10a6:102:273::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7339.37; Sat, 2 Mar
 2024 16:47:28 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::3168:91:27c6:edf6]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::3168:91:27c6:edf6%3]) with mapi id 15.20.7339.033; Sat, 2 Mar 2024
 16:47:28 +0000
Date: Sat, 2 Mar 2024 11:47:23 -0500
From: Frank Li <Frank.li@nxp.com>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: conor+dt@kernel.org, devicetree@vger.kernel.org,
	dmaengine@vger.kernel.org, imx@lists.linux.dev,
	krzysztof.kozlowski+dt@linaro.org, linux-kernel@vger.kernel.org,
	peng.fan@nxp.com, robh@kernel.org, vkoul@kernel.org
Subject: Re: [PATCH v2 2/2] dt-bindings: dma: fsl-edma: allow 'power-domains'
 property
Message-ID: <ZeNYG1IUfniWkhcp@lizhi-Precision-Tower-5810>
References: <20240301214536.958869-1-Frank.Li@nxp.com>
 <20240301214536.958869-2-Frank.Li@nxp.com>
 <885501b5-0364-48bd-bc1d-3bc486d1b4c6@linaro.org>
 <ZeNI1nG1dmbwOqbb@lizhi-Precision-Tower-5810>
 <31e62acf-d605-4786-80a1-df52c8490913@linaro.org>
 <ZeNWXxzFBzNj0gM1@lizhi-Precision-Tower-5810>
 <e1d0aafe-e54f-4331-8505-135b9a8f9bff@linaro.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e1d0aafe-e54f-4331-8505-135b9a8f9bff@linaro.org>
X-ClientProxiedBy: SA1P222CA0090.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:806:35e::22) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|PA4PR04MB9638:EE_
X-MS-Office365-Filtering-Correlation-Id: 4b7cf3ba-162f-49e3-14de-08dc3ad87255
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	KAWa+1T4JY1vz5JfKVFXM4WvPH3Y4Qi+3t3LgmapdrmB3APF30Mb/RDB9fNkTzhjrYUNzX0y2hh6bkysZ6X1fY5TmeUSRp+bv6qDetIoPcV8jeXCsrEuPVWlTNJsAZt9ePodv3N1tLKP81Gsqx3to5iUYttqeqeIyWa3HvcKpvr27KSSM3xXO2RsBDUaFDYThBkcMfd1jUk4XGxf8SqFpoeC3kgifC1zkIQb82Y4sBdEoIwraYQE4UtUmvGhzf1EAxhXiBPwjKYzmR2QSyYwPDD5TgOEvQjAwR3L3WbPbCk8wrbsekf/dERlW0QlETOtzhTY/G1uvEgB4Zy810/T5gP5D3LCHRv/74tkU9fNU3pbBouP6LGBOKdN38sc3dQFPZ+EN0R4U9m2uEI0kVSKe9cufErl99F7BI1+/7T7ap1QEF0X5JCmA0+qaJCTfPBl7wv17kLEHOZUCOdkrt6VWp5LwoJlDdAnywXUSaKUoouojKlcrG5cX/SmVV0g3/Qzezp2GdXp46uFsAgztUk0KWufIFJOoDT2zrmi8FAqNrlFf3TyfTWUyKHZjIr6rZ+kb4i6PV8H9FbOp3HPfRcR622JCsKDNxxsdwioTX/yFlFFV8hOHnDcIA1Kqcy52ALGZy22E5V6j7mnGjmjqbugoYShFvCbvD2O0kE77fvIq/pAt9hwspEI0iQeFZgVGEFHqKLcz1n29VcyMthvAjPz9g==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?fnwftEcSHsFCm+96hnmZ85eQ+jDoRgN+48xZ0ZAHhQTFjoYAGd5JvK8XPnTl?=
 =?us-ascii?Q?kJyfZiELcjdyBwZLUX51DMkUzEmeJnfpl69WQRdZBo7BRxfh+BlE43XCDsoQ?=
 =?us-ascii?Q?Qf5rDjqRVsv4JAw5Tt/T5kaOnfiWxxtSpEa7w1eeHq6ydxRbgA42Lb2mOebg?=
 =?us-ascii?Q?NHkvsLKl+17qiz8ULVNx0p6/UfhzQ6PbgLuZZPXQy5xL6W2dV6iPbpyjUY7U?=
 =?us-ascii?Q?8PRJw4X+W4PKsFyGr95W9FajMtBOrcXYjc7RU+HiTohzh54kxOSeThlXp0+o?=
 =?us-ascii?Q?PrVCrYiuBNBil573bREEmVSEphZ96QQv5JCfJK4ksdYemDdYXRmdJ7Mx4o2A?=
 =?us-ascii?Q?5mjJSp0eNrKIFE11/oR4AAtoDW2fSy5it75OL/CL3Kvf9kXKzczLhOUsIL45?=
 =?us-ascii?Q?BV6+B8b5vpn1aY1HwAL9QKat1/ohdQxh2M7W3HGAIDBHcf4rRc24nDM6NEAR?=
 =?us-ascii?Q?qGuNzj4Hhr+kWjFF3ToQRu4L1HFvfpFxK8l1F64smPbLnlzOCWwr+amZ/WJd?=
 =?us-ascii?Q?SBfVOHQEp5apHt3HSG9kKALV+rONp3s3ObYHMjr7tyT5eiagyYZKxTCnlD4A?=
 =?us-ascii?Q?vrLhD+e4vV1MAJHYmdBDaqqkCfK/x6n/I8G6GsfmGATXEHAdoUbwSBI0Ozsi?=
 =?us-ascii?Q?wwv2uPUZi2a38bwgIGR4VBpjgbgxYDMpqDqqluKewZmA4OYlK/wby4zPFQRO?=
 =?us-ascii?Q?7MWyi/WpAhEODdci5hNlJHW4V26iMv2jP8g+rAuVxMFKnayZtCEjnwkNkZze?=
 =?us-ascii?Q?Vr+VgRfcaRLsB+FtNohFcb+FwNGUuoo0iE7M9Z7PdDMQjiNYDgz8ehpZHRmU?=
 =?us-ascii?Q?nHusBS/H+m39V/5DMgSCEQCFTH1pu3GJpbwRad1x/S2sUmxiS8rbis323J0J?=
 =?us-ascii?Q?BJo6JQ8LIwxQoxhy0WYAYJEP7CVq9CNEfKUXUAVAFA72DmeAAZ8nsc55/Sjc?=
 =?us-ascii?Q?sywibICEcTbD78VK5FvZrJ5igIgRQU1nEa6FXrotbXdwmp1RcwYM89vd9VWz?=
 =?us-ascii?Q?xOO/hz1fMFU8o7uWZQWIfMYUTiuI/DIOrbFb8Y9hUpLxO4afILlo2qpjdKL0?=
 =?us-ascii?Q?yAgXxcr9Fiyy7AdW9P/qFRxe/Gz4+8XpoPHruN84IUPtGAHxpGivtFLrXK04?=
 =?us-ascii?Q?eO12Bax0LZ16UEIQvYsh2J0Qh1gJIonanyjwDwi+8vZqx2I24OxYB315kd2G?=
 =?us-ascii?Q?hEC7FKO6N5a5/ku6GaLZ5zx0QmTN3yyzswHgnrlyq89HMDSQRPkeRgOAm/7O?=
 =?us-ascii?Q?TQBnFG0UcMga7j+nSqZQib+Fujgy7LZaL+nf1lY6LxvsZOd9oFApZPAPweID?=
 =?us-ascii?Q?4vQhdkAbA9BZhgp6soTWs7Z1SVqnZiPaq7hQywANgQ0NpXJfDma4us+TdsAT?=
 =?us-ascii?Q?W9vp+yvez9fLGxCFLxfAJn9dKJ87GEbNuXtEdHPABkDoi6ttGbhT5c2KatHF?=
 =?us-ascii?Q?oxrnQYWHLsPoPYhaNwwHgm+lJsg1RapkijVEjUCGi+LT5qvt/PLG7uuvO9X7?=
 =?us-ascii?Q?2TpdsP2Eq+czpP2FZljYpeqcnqWxixvjQdi4b8iO85KwUysa51883PQc9yLI?=
 =?us-ascii?Q?SkIP9S7RkIrLcvgVoErqmgZ3HQ0LxNtums2jMNUi?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4b7cf3ba-162f-49e3-14de-08dc3ad87255
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Mar 2024 16:47:28.6768
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lkQGvqsrIpBy6CVSNd97MpHihEXNFdb1nHHzf36od2wX1uKfOJ+P4UwMw21Zxs1sOHSDIZLUIb3rLKmaYxk/mg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB9638

On Sat, Mar 02, 2024 at 05:43:01PM +0100, Krzysztof Kozlowski wrote:
> On 02/03/2024 17:39, Frank Li wrote:
> > On Sat, Mar 02, 2024 at 05:20:42PM +0100, Krzysztof Kozlowski wrote:
> >> On 02/03/2024 16:42, Frank Li wrote:
> >>> On Sat, Mar 02, 2024 at 02:59:39PM +0100, Krzysztof Kozlowski wrote:
> >>>> On 01/03/2024 22:45, Frank Li wrote:
> >>>>> Allow 'power-domains' property because i.MX8DXL i.MX8QM and i.MX8QXP need
> >>>>> it.
> >>>>>
> >>>>> Fixed below DTB_CHECK warning:
> >>>>>   dma-controller@599f0000: Unevaluated properties are not allowed ('power-domains' was unexpected)
> >>>>>
> >>>>> Signed-off-by: Frank Li <Frank.Li@nxp.com>
> >>>>> ---
> >>>>>
> >>>>> Notes:
> >>>>>     Change from v1 to v2
> >>>>>     - using maxitem: 64. Each channel have one power domain. Max 64 dmachannel.
> >>>>>     - add power-domains to 'required' when compatible string is fsl,imx8qm-adma
> >>>>>     or fsl,imx8qm-edma
> >>>>>
> >>>>>  .../devicetree/bindings/dma/fsl,edma.yaml         | 15 +++++++++++++++
> >>>>>  1 file changed, 15 insertions(+)
> >>>>>
> >>>>> diff --git a/Documentation/devicetree/bindings/dma/fsl,edma.yaml b/Documentation/devicetree/bindings/dma/fsl,edma.yaml
> >>>>> index cf0aa8e6b9ec3..76c1716b8b95c 100644
> >>>>> --- a/Documentation/devicetree/bindings/dma/fsl,edma.yaml
> >>>>> +++ b/Documentation/devicetree/bindings/dma/fsl,edma.yaml
> >>>>> @@ -59,6 +59,10 @@ properties:
> >>>>>      minItems: 1
> >>>>>      maxItems: 2
> >>>>>  
> >>>>> +  power-domains:
> >>>>> +    minItems: 1
> >>>>> +    maxItems: 64
> >>>>
> >>>> Hm, this is odd. Blocks do not belong to almost infinite number of power
> >>>> domains.
> >>>
> >>> Sorry, what's your means? 'power-domains' belong to 'properties'. 
> >>> 'maxItems' belong to 'power-domains'.It is similar with 'clocks'. what's
> >>> wrong? 
> >>
> >> That one device belong to 64 power domains. That's just random code...
> > 
> > Yes, each dma channel have one power domain. Total 64 dma channel. So
> > there are 64 power-domains.
> 
> OK, then how about extending the example to be complete?

Let's add 8qxp example at next version.

Frank

> 
> Best regards,
> Krzysztof
> 

