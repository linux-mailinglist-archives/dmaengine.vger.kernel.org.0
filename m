Return-Path: <dmaengine+bounces-1250-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C5F7887055A
	for <lists+dmaengine@lfdr.de>; Mon,  4 Mar 2024 16:24:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7A7051F21A7F
	for <lists+dmaengine@lfdr.de>; Mon,  4 Mar 2024 15:24:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77B7D45BFD;
	Mon,  4 Mar 2024 15:24:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="YKnS1CNy"
X-Original-To: dmaengine@vger.kernel.org
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04on2074.outbound.protection.outlook.com [40.107.8.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A14C3FE58;
	Mon,  4 Mar 2024 15:24:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.8.74
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709565874; cv=fail; b=I4pEInw9MC8Ik8jwrVcQpdcyDwL54IOc29RsdgX6/l6bq+5xwjhw26nMZpx9BikmwbD5Bn7ZRNjy3tT6wUFCGK5pwEUzhL9TCq9kXKUtIkTBCYT2yUk9GTH4OLLV1EiyKuXPMWc6TITeNIOo2Vz0Hw8AS2uMm0A4Bf1hxEq7WF0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709565874; c=relaxed/simple;
	bh=UX9IV85/eXtvmim6tpltA662qF09T+3a1hrUs5ZDq1A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=WcTucbC/FZfU5StiXhCSyCsSCvo/M97AvHq7DhDdG7BR0LrA2SpI45DW3XVEEeZLJ3vMlsP8ogt5YTEZwP9Uz6YXKI0DPuiFcYHPBpY0IhGuBbk+MWcyAcc4QZHnQ/mvmlEi8ZNBZlcDAwciyqqeJtUmVbmX9eRYQ2a+aohJqBY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=YKnS1CNy; arc=fail smtp.client-ip=40.107.8.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HI40gFd+BxK2z69Da45YrghmwT5GylMo7qPxnXx+KZe5tvCeNLZddSbt56wWcsqEEj9uuEUJ0kQnlqzaxhFfQlk0uwwR6ii995s3lSmTJbwPQKx8sQmo91N/r3V0aAXLdv+nwWDWG6XOTjXqU5dRVIOiPKrYZdN7L6iHlbWZtU3pcarUdcDkOC/snFwqVg/CFQkPxd3LrY7M2QweJPCZhH2qBMlmUQzcHOBQj7ojdQ8LrJK4q85FxMv0Z/MTufzTg4yPZgzLVqPJwudB0l9+ErPtwDrzC9VhozDjuA2b9LfmbHKTjE+R2jZkPQDnXA3i1bZ/CfEJid902DODewA40w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=06gDI4Ld6FfIA2ZnmN6KabdMmGvE7O3Aw3ll2kQHWOg=;
 b=J4jGMWslZRSlOCtyUp1VVXmylrRs8FO+jOD4ACLD2dqfzErsm8IvdkPBzgnXQHq42AJmRs0KDGOZElCLxREZYPJen2P1g5NzWWjpdrjbENVMBc51/52I1A07sh9cisp/Z1bNsi4z/bsbH+vDTO99197wFg/+PjCY9Lpx4eReUP5SlWqaId2oyop+U6Uv1mVc+07BYGO1kgWbdejJj9woFNfp0vX8qiqkxOhUdnke9Kr76L0wCiyQ87zvBRehGAtJrcr5di/nKxjVKcaIZf8LuTDQm4uOEe20+kxZNVdUl3pjJOfP7x771XXt8xZtJ+zBfPHAl/Ap7tR3wbX2rUZJXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=06gDI4Ld6FfIA2ZnmN6KabdMmGvE7O3Aw3ll2kQHWOg=;
 b=YKnS1CNyUJ6hbR09VO01MxEjsGdmGwFeq5bjQU5Ce045sP/WFXLbh4le26Sw3xSlHJAOTFPQVA0sR9kO0koM/rb46QVxx0CwXISf9bCQ6cDGqL+N1kCN/ZR46nS8Pua4WclEPERSu4TulO+Srb1hBu5Bxz8DBWe+ZFTNp7JR+aI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by PAXPR04MB8237.eurprd04.prod.outlook.com (2603:10a6:102:1cc::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.39; Mon, 4 Mar
 2024 15:24:29 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::3168:91:27c6:edf6]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::3168:91:27c6:edf6%3]) with mapi id 15.20.7339.033; Mon, 4 Mar 2024
 15:24:29 +0000
Date: Mon, 4 Mar 2024 10:24:22 -0500
From: Frank Li <Frank.li@nxp.com>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: conor+dt@kernel.org, devicetree@vger.kernel.org,
	dmaengine@vger.kernel.org, imx@lists.linux.dev,
	krzysztof.kozlowski+dt@linaro.org, linux-kernel@vger.kernel.org,
	peng.fan@nxp.com, robh@kernel.org, vkoul@kernel.org
Subject: Re: [PATCH v2 2/2] dt-bindings: dma: fsl-edma: allow 'power-domains'
 property
Message-ID: <ZeXnpln7y1T4QBMd@lizhi-Precision-Tower-5810>
References: <20240301214536.958869-2-Frank.Li@nxp.com>
 <885501b5-0364-48bd-bc1d-3bc486d1b4c6@linaro.org>
 <ZeNI1nG1dmbwOqbb@lizhi-Precision-Tower-5810>
 <31e62acf-d605-4786-80a1-df52c8490913@linaro.org>
 <ZeNWXxzFBzNj0gM1@lizhi-Precision-Tower-5810>
 <e1d0aafe-e54f-4331-8505-135b9a8f9bff@linaro.org>
 <ZeNYG1IUfniWkhcp@lizhi-Precision-Tower-5810>
 <32d4a6c9-1cc3-4e9a-81a6-744a33bc6bee@linaro.org>
 <ZeU/UQVPj/q4kD3p@lizhi-Precision-Tower-5810>
 <9c1f74b9-468b-4243-a21e-fd18183aa4b1@linaro.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9c1f74b9-468b-4243-a21e-fd18183aa4b1@linaro.org>
X-ClientProxiedBy: BYAPR11CA0102.namprd11.prod.outlook.com
 (2603:10b6:a03:f4::43) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|PAXPR04MB8237:EE_
X-MS-Office365-Filtering-Correlation-Id: 92cd6f59-331d-46fd-cd90-08dc3c5f2f23
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	yF/OBHEnw1auR3mXr9Jy7smeMNFLifJBbZOtFaBtEIh1QXbX1n8yJ0VorsAidWkFhW1kfhyQmJ7R0dU+KwyEp2KI1eHrkEIv9qV/XbtGdzBz8GIJZbl/vPVqUGwjZR8YLerwVP5JWD0yD1R7KYmDVeBJMePMTXhh88MTQU0fN8EqeL/QUht2OvTmGV13byZ1XkpMMeEsk5pf+vd+p0tUX9xb0/hI1hMG1fjZm16d15fLfQ1UV5wSVHxdWfMv4yQ2WDLJpafsmw3e1b0V7VPAX8MqzdLnHFTL3fJvjGzYp0IRr+lj1fJqigKIM1EgWG/4NlBKn7OCXihivj22GRcZyVcseZznd42TtBB9taMUE7ezYJ3L2xoFcVsUxYXXLU80hiPmHclLT4IN14sKOZDBur9uKvzJ5JduNgnC+eK72kc65dmyt+E72qhDL5KxvuOWtzrQd0VJrxRjoDw7JFOpjCdbbivx3nsE3A3gkrP4HOvuxd2BgXhBccGRo/nMqNWeUUZ8/FRt7UdEho6kBctDsZ3C5E1XIBuqBvj2CgYkZU4QFSfyxXabuyMyveBAieJAOYHWWf8N5PwshD6Tsq4L2A2Brc8HYjB+AR5Fy4nQZuI9TVxi9kooYi210q7hvUwuQBKJnpV12ktIqZfMXFikykXKz/llrc/a+MVkobNM5Nsuh4bGk4Oo0zm2Enax3lVKdoTl3bS+V6G+tZxzczi9dg==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?uK8GZ5DyfOmrmWjOu3nY+glhzbJciSDMGL62YojfvLhMStz2NyIlkdyOkTqA?=
 =?us-ascii?Q?7FQQlr1kCJnV3IxMJZCQ0XqegfX1nwZrdoF6PEmnx859KuwRYTBsXqNl3X+N?=
 =?us-ascii?Q?IGz9A5kZBis2lR3yQT6oyoKk93Re2pW0NvhKzlpy/S9A5BUTn0FCF0Cz/ueX?=
 =?us-ascii?Q?UXkoIhwGTQ/2pZR1NOCZbwTXHCKeVCponfkk7rZtjmWs+aVkktQu7tO7/rXg?=
 =?us-ascii?Q?tZAB735MqQcXPQGbnsJSz7D561P0mEa1qNUYQ0b+y7dS+blmfiWVFJxmKU+A?=
 =?us-ascii?Q?tl4T79my55EPrILt7yercaqFXEyC9cffkcBSJwzhwXy1VWHZdfIOOOscnpZF?=
 =?us-ascii?Q?dgl4tgcwmClSAMxsS03Zab/30WgdIHvqpJi68YtbHm4TlcILSUmsJVvEHSiu?=
 =?us-ascii?Q?v+/U3gJ5WNX5YkGNVVHhkViEd6GLSg6WOAWDwqNbYA7soE/HYRsJkhDfAHbZ?=
 =?us-ascii?Q?y9XJt1zU5bfwL9Cbl9lM2lQ1n7u5Io3aI2ZI2TQKF3xIVExViGLorOZaAtzT?=
 =?us-ascii?Q?+BkiXInWM5d6p+lHwbIP23RjsbbcUgrKeQVI8i65u1FwklxyKEfPfOdZJuz3?=
 =?us-ascii?Q?VdteSZEewwbEgdyFGm/jlxGA2swRBW4cB0zVExExjZUEG7YDsldZi/sZSvaM?=
 =?us-ascii?Q?ckO+bzIuDj5pMQJZwGjMQvr2mZgyS5mTwt+FUYBSlE9sNQKiKFWrzcCvLe/D?=
 =?us-ascii?Q?YSDt/+nMjnUvQU0TXkOcGw+3X/PIObXEdK0Fiu8hJGhBLh3rfpzc7YiHG78g?=
 =?us-ascii?Q?/6EDKJKllVs+AsmvfwHQWnIWyjaroJWBTGui6dsDH90iVR2D5LJbVwffVfij?=
 =?us-ascii?Q?jaIgTaDUO76HXBReeiR5esDoESTe9xM8KOgS+w+ZRoO/kJEBoafc36yO21gD?=
 =?us-ascii?Q?9xjE2kT6dAQ14DfFdaNKIRgYqoMCIKRFDrUa4BUzrFhko1VubP36s1gdhNCs?=
 =?us-ascii?Q?pOWVDXLjUGF3ZEPLvqqbysmgleP9hMQVzXNcLq0BY/l0hrJiRmnXyPMR7DqN?=
 =?us-ascii?Q?5lpDwXeZbFK78JyFK190TQv7hH411OfhB26Qohfc5JQ0o7qi8LqBTyxF2+Zh?=
 =?us-ascii?Q?LbdIKUgqUw2KxuyZAYGfSwRQimNUhIpVF1egIHGMl3zijSxIhzR2ZINCsUAB?=
 =?us-ascii?Q?wYj/2weyvVH6xyjlA6EZpKjUBVoDNalwxA0jdVVx5b2wxWYszoCdtupfK4i9?=
 =?us-ascii?Q?4UiH/0XZ+I/gyTN+zhr7M1daQtduMtjT8gszohPpW+T15k9hrn7VS/H92gv1?=
 =?us-ascii?Q?JzZf8TRX9N3xMK4KwfCITcH9KB28TACwcXLLqPt4bMvL67cYk+cBdPu3vFSX?=
 =?us-ascii?Q?4zDpQHvRcl6hVJwB/0hnWpjJZNlE/0k5pk+q0FX4rmBQaPJHQNtkfB+8tk7I?=
 =?us-ascii?Q?C0DINiahSZLIuCuvOJrgiHHH3pk2M+cEpIoV2u5hwouXjYzBI9KTLNv07Tby?=
 =?us-ascii?Q?PwFq2a3cVF8jsOJkUKwF5JC3lNAS89jHPyN+WRHmkzvEFcQ81zQCMfFMfvDp?=
 =?us-ascii?Q?FbwFuX4gbF8bs6NXjbVA2rtN6vs1fhgFWAJaAs/p6B8Ls9slK4tbxfPkxJW4?=
 =?us-ascii?Q?9OQXT1wGIVIHs8DV/jM=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 92cd6f59-331d-46fd-cd90-08dc3c5f2f23
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Mar 2024 15:24:29.2066
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2hNImhyXIZ8ugHakfKKNAR8+IKCW8s7oS2DyCmhFog7pWkD6kGi/+jhXca6Z3lFZTqL+wyFVTPKDE9FfLCwwGA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8237

On Mon, Mar 04, 2024 at 08:23:20AM +0100, Krzysztof Kozlowski wrote:
> On 04/03/2024 04:26, Frank Li wrote:
> > On Sun, Mar 03, 2024 at 08:55:10AM +0100, Krzysztof Kozlowski wrote:
> >> On 02/03/2024 17:47, Frank Li wrote:
> >>> On Sat, Mar 02, 2024 at 05:43:01PM +0100, Krzysztof Kozlowski wrote:
> >>>> On 02/03/2024 17:39, Frank Li wrote:
> >>>>> On Sat, Mar 02, 2024 at 05:20:42PM +0100, Krzysztof Kozlowski wrote:
> >>>>>> On 02/03/2024 16:42, Frank Li wrote:
> >>>>>>> On Sat, Mar 02, 2024 at 02:59:39PM +0100, Krzysztof Kozlowski wrote:
> >>>>>>>> On 01/03/2024 22:45, Frank Li wrote:
> >>>>>>>>> Allow 'power-domains' property because i.MX8DXL i.MX8QM and i.MX8QXP need
> >>>>>>>>> it.
> >>>>>>>>>
> >>>>>>>>> Fixed below DTB_CHECK warning:
> >>>>>>>>>   dma-controller@599f0000: Unevaluated properties are not allowed ('power-domains' was unexpected)
> >>>>>>>>>
> >>>>>>>>> Signed-off-by: Frank Li <Frank.Li@nxp.com>
> >>>>>>>>> ---
> >>>>>>>>>
> >>>>>>>>> Notes:
> >>>>>>>>>     Change from v1 to v2
> >>>>>>>>>     - using maxitem: 64. Each channel have one power domain. Max 64 dmachannel.
> >>>>>>>>>     - add power-domains to 'required' when compatible string is fsl,imx8qm-adma
> >>>>>>>>>     or fsl,imx8qm-edma
> >>>>>>>>>
> >>>>>>>>>  .../devicetree/bindings/dma/fsl,edma.yaml         | 15 +++++++++++++++
> >>>>>>>>>  1 file changed, 15 insertions(+)
> >>>>>>>>>
> >>>>>>>>> diff --git a/Documentation/devicetree/bindings/dma/fsl,edma.yaml b/Documentation/devicetree/bindings/dma/fsl,edma.yaml
> >>>>>>>>> index cf0aa8e6b9ec3..76c1716b8b95c 100644
> >>>>>>>>> --- a/Documentation/devicetree/bindings/dma/fsl,edma.yaml
> >>>>>>>>> +++ b/Documentation/devicetree/bindings/dma/fsl,edma.yaml
> >>>>>>>>> @@ -59,6 +59,10 @@ properties:
> >>>>>>>>>      minItems: 1
> >>>>>>>>>      maxItems: 2
> >>>>>>>>>  
> >>>>>>>>> +  power-domains:
> >>>>>>>>> +    minItems: 1
> >>>>>>>>> +    maxItems: 64
> >>>>>>>>
> >>>>>>>> Hm, this is odd. Blocks do not belong to almost infinite number of power
> >>>>>>>> domains.
> >>>>>>>
> >>>>>>> Sorry, what's your means? 'power-domains' belong to 'properties'. 
> >>>>>>> 'maxItems' belong to 'power-domains'.It is similar with 'clocks'. what's
> >>>>>>> wrong? 
> >>>>>>
> >>>>>> That one device belong to 64 power domains. That's just random code...
> >>>>>
> >>>>> Yes, each dma channel have one power domain. Total 64 dma channel. So
> >>>>> there are 64 power-domains.
> >>>>
> >>>> OK, then how about extending the example to be complete?
> >>>
> >>> Let's add 8qxp example at next version.
> >>
> >> You have already enough of examples there and your change here claims
> >> they user power domains, so why this cannot be added to existing examples?
> > 
> > Only imx8qxp/8qm need power-domains now. The example in yaml is vf610, 7ulp
> 
> Need? Hardware is either part of power domain or not. It's not dual-state.
> 
> > and imx93. If add power-domains at existed example, it will mislead reader.
> 
> Then please disallow the domains for other variants. You can convert
> imx93 to imx95 example, because it's no different than other one. There
> is little point in putting so many same examples in the binding. You are
> just duplicating DTS.

both imx93 and imx95 have not power domain now. Do you means 'imx95' as
'imx8qxp' ?

Frank?

> 
> Best regards,
> Krzysztof
> 

