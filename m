Return-Path: <dmaengine+bounces-1807-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A595E89FCC7
	for <lists+dmaengine@lfdr.de>; Wed, 10 Apr 2024 18:25:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C8D2D1C222A8
	for <lists+dmaengine@lfdr.de>; Wed, 10 Apr 2024 16:25:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B26017A934;
	Wed, 10 Apr 2024 16:25:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="WwsMd976"
X-Original-To: dmaengine@vger.kernel.org
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2099.outbound.protection.outlook.com [40.107.105.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DB2A176FD8;
	Wed, 10 Apr 2024 16:25:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.105.99
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712766315; cv=fail; b=laZG/+bf0vEVNG8O3e/FBqcdRy2GTh2F6wj/yzi8IjmaHbQC3ajPpUU7kU8J8JStPf5zUC31ZAIcmbu1Ru78DB70UVQqEKGvVufrcGQoysbUCMa/P7ZgUa5GCLnT2lqP4QaAPyUr2DtBygJd+cfdBKzmMQ98KnfKMzWdb02YaJ4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712766315; c=relaxed/simple;
	bh=97IT4c67BO1VEP28izZd+YU7qgQjlFiBDsuvk0JaVXY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=qzH4xJcoFcboe7Si2txzHUZ/8/VT4WRS+bq1qQH1xRNuELca3JB/p7u8jSL9apJ38XoQqLUw8FCCbLqFoxwR++FAyKlS1Q4n87f/NCU7SIq2Lu2Cv8KW7HWNsXvrXYyl6EGXvRel66s3bfnRs56/kyL2ptpxf81GHWHDxa/j2D8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=WwsMd976; arc=fail smtp.client-ip=40.107.105.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Xn1i3Z3lJZdZqkadivfE2d4vSUs2vZWgNQlNfdFpzWqe+Xw/KMT1QhsmrgZ/LViz5WUflwwniIEOkpTZLJMmRnK0/ltRTcVO6ouddN32OX3G5+rwvjujEchNWffU8HsYnAOXADlUej1dQ+u5AZJusjgc5Bv5kQr+L8WAHAw+FrtQBY/yw2s5l0QK9g6g/4lzkVO9zMa9Tbk/uVJeCIvzhRv3It8PVqaJF9V+h8pGMwtRNAtjC5BKRPFWEG4GaStfkeuulw/brVylCdCBUNtJHdKU3JhocKBHJsoJRWsu77sU3huAJsPYVWGsOIlP7yyE1uGRRI8g4JJYr/GXjrprhA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PqApLD+JLWKRb8j3gf8kl6BShsNcCWgv+IKM1VXaGOs=;
 b=cLvP87wqjBjNuAX6PZiT68/L2GKK8NWqs7VydGs7jv+qlflm3gHOfNIqXij1zhy030T8CqIPvekQC/AD35Ooz+7lav/aw2d2RISAfrdZuJh6Kl18RtO+ER/Nfh3F64+tmO8D6V0C6qzruiagroFwfB1nFj7Faf3T7J3V+LSTETDskyqniB6oW1JKODNclTs4+qc2t6m6peSKK2O1vrR8s4e6VGm0nMfWil9gSmqYQnXTlXmN9NHn66OGXj2/heIGO77QXuXrvDuWNvQBVyp2xMZTmuRt91jeQRpV7po67eFI6O6mOYLUgP9yHVQwPRTN6C0J6XYhW8XH6NRU4vToDg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PqApLD+JLWKRb8j3gf8kl6BShsNcCWgv+IKM1VXaGOs=;
 b=WwsMd976Tng64BcW/5j8sHo75EjH/MngEILNs+R6+pNhewi5vB+lZ3iJvrrK9EY/SaLxZtpxsYWhEwwJ5SmIsjQSW1n0t3KvP5VGc+xhFYsfEVlzbJNRnWBjOkWdKISsD8is7Oq4l6NWpc6p3HuL63aMin/GSOGbvaIvaPkklO4=
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by PAXPR04MB9644.eurprd04.prod.outlook.com (2603:10a6:102:242::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.54; Wed, 10 Apr
 2024 16:25:10 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::3168:91:27c6:edf6]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::3168:91:27c6:edf6%3]) with mapi id 15.20.7409.042; Wed, 10 Apr 2024
 16:25:09 +0000
Date: Wed, 10 Apr 2024 12:24:59 -0400
From: Frank Li <Frank.li@nxp.com>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: conor+dt@kernel.org, devicetree@vger.kernel.org,
	dmaengine@vger.kernel.org, imx@lists.linux.dev,
	krzysztof.kozlowski+dt@linaro.org, linux-kernel@vger.kernel.org,
	peng.fan@nxp.com, robh@kernel.org, vkoul@kernel.org,
	20240409185416.2224609-1-Frank.Li@nxp.com,
	Xu Yang <xu.yang_2@nxp.com>, Shengjiu Wang <shengjiu.wang@nxp.com>,
	Pankaj Gupta <pankaj.gupta@nxp.com>,
	Shenwei Wang <shenwei.wang@nxp.com>
Subject: Re: [PATCH v3 1/2] dt-bindings: dma: fsl-edma: remove 'clocks' from
 required
Message-ID: <Zha9W86zbFe18jnX@lizhi-Precision-Tower-5810>
References: <20240409185416.2224609-1-Frank.Li@nxp.com>
 <b15ad271-037e-4ee3-ad88-e8068d31c8c8@linaro.org>
 <ZhWuetC8bRvDyxgX@lizhi-Precision-Tower-5810>
 <680f8830-6cd8-433b-85b7-439070bc528f@linaro.org>
 <383141cd-7f6f-4ed0-945b-7761833ecc35@linaro.org>
 <6db0c7fc-a94f-4f02-840a-1d64d6e2daa0@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6db0c7fc-a94f-4f02-840a-1d64d6e2daa0@kernel.org>
X-ClientProxiedBy: BY3PR05CA0045.namprd05.prod.outlook.com
 (2603:10b6:a03:39b::20) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|PAXPR04MB9644:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	iOVJjRXGbDDTEiXaQRrcjHmkABzg/nEL8Yt0jnQnJ2cTGZdE8TRdAFfeHczsbZMR8q7nIsxIX03GeW6XQKyBI6CJe90jDMrNSY9sU9JbZblkUldm+CLGPj7/fcqxVWLd8uIpp0SpNK+krjHyewvyP4DPt1GCtyEMCjR27lMsmDXQ5mbO5Qz1f+oPzaZsAs3oZ7cyxKs+/hrITwDJkwz2KL9Hz0NuCVSI8ttIKRyJjU++HJAtu702hdYFsuYxTLRKJBGH2PL4rbTF1My99/poNO34Cfjnqa7E6SUD2R8DY97sB8h/8OSSbBiyoLF7wqDgOhwhwhwPv2+o/CorQPvzC+Z+0g0Uwe+TzsjtwQWbjyWacjSaCnQdUufAEltzOpQ1929vjd+vMTH+QJ+FFKyxWENtNEvVJZZiGfDCKKQFF9yW5BKqdJnu/Rv0DwRS6BX8uLLh+HSChW8sdrjBKJZMWYspMQ5/+vjgpdK12gX1gwBmFtNKc6+oUvldDoTx0kErri1/la+2DdUeUFUQROcT/5DAa9/fNpskoLEJGhiSbG+emHxaJUJ4PXfcPGG74DyGnf1xLG7IVhGE23wkdS2LYuRy8l1/scavJZey5ubo4q9baodxW2GkQC087Gm5HNphhc2PbpPsv1XmLkQ7aGgBINffLInB+ZqYTvwpsBvLB0o=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(52116005)(366007)(1800799015)(376005)(38350700005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?BKHYc9TrI9QRy/wg/MICXrldz1qr4hejAZq2o8CHC6dcDH1jU7SAaCBCJ0lL?=
 =?us-ascii?Q?U0WY9IoJDmt4jrKZojUeuWwoEgbatvPywjAkiyCNpmiAFkkncl3HTKZMVdl/?=
 =?us-ascii?Q?A/5DL9w8sVFP4TiGbRUI/fQ5r3vGtp4aWgzyaf9uUvLU1ARQS/yGwGLr0D1T?=
 =?us-ascii?Q?UDJfHTKecBLRUjjdrfaD5ISHjmgrhz5EgST75hc3pthaV6hNhxoDm1JnA+4L?=
 =?us-ascii?Q?wURCrPTD6PUYjqhcXVABT0fojtV3waOznrvJpTyD6d1vHU1JAnSLf+MUDEBq?=
 =?us-ascii?Q?dX4NpeZw/1B0AngmJQwyEhSGLv6lcpqpCvrNmTmjNFmICv3T8vgd//OY6gJU?=
 =?us-ascii?Q?em7Gp9/lcBQq0kBXgG9RCo/UAJLnV1HYfaaZrvUjO9na8EuD54O7ko1YnSgP?=
 =?us-ascii?Q?+EhnAyuRLjReOlA6Pdqk8X/W5G1Gn4wgCmTVN7W0pbVh1d5s9A/00iS1SQbE?=
 =?us-ascii?Q?dk6rGvkih9ad1lX/FBfVSBEWmapDz2R/fb8kWmH6H0awnkedCSs0C/6i5T4e?=
 =?us-ascii?Q?ltIvv/+ElxGlJPmuysUSaqTR4n5TU0cQe+bYb7nkbWfIBHTctsMa/k5u/Ryk?=
 =?us-ascii?Q?nLZhdgPUZ7eI9tJSCADun1mMToyN1prpV9fdR7cq9lyG3p1lQWQ12XLYywtc?=
 =?us-ascii?Q?chPzDDttpSfbmKdBGN6m7aiV8K2j/bffpSLtjdCgRl6sNPd3olFd1wYCH2kV?=
 =?us-ascii?Q?lFws81f0ncNUrIdi3ScXhcbOMFCxPUasmewJT1tAeqT4Eg8QhBf0eEmksRSO?=
 =?us-ascii?Q?3a+XFVbbP1jMGzRFTw29wv4w+9gIRg6spOwMwQITETzZJTsZFBcPzDsErq4S?=
 =?us-ascii?Q?RLpfhN68Dqf2QLG2tasIqjJLMq5eOqLxWV5OknVPP7GvWJQKGfn3tnXxE3x8?=
 =?us-ascii?Q?w/P09AcCMLZwnrRq46vDqBQqcZ3YBwlwRc+VsIPSPx/31l+iqhLmx/YQhLnk?=
 =?us-ascii?Q?oDJTEDRNdKsy1QA0mkHphdKoE/bcmXHYXQkAfy+Fqu4CtwPfTRHRlnVFxVu3?=
 =?us-ascii?Q?gFQfPTRrqATL4cjsFRtmolUM/1e01TXRK2+6PDbHAkdDpU4zd4nQsJuk6ikY?=
 =?us-ascii?Q?0GoexTbWqSKdq5QSddD/3oTnTMcS2gp2vB8tv7HQSzaXUL+CPaXVXSdzzVGU?=
 =?us-ascii?Q?a1rmsCyED2TudXCZHK9IrpaSkELZhAhwoOPDB1LbNwUEfL5Cqmxp2TWxjPwu?=
 =?us-ascii?Q?wntGF6tQs0YQtX39qD6R2vs7Z/hj8nyAJ0B27fJ162yim+xW20d2tK/aORwR?=
 =?us-ascii?Q?kvRPSHJqoQx7UZQwB8JNVXR11uC84Irhp336qwi+84nuRFuXOabGgNHJb093?=
 =?us-ascii?Q?3TDp8F11M6Bv4unf1MWywnZXUemWn+a1ideV/vnFpunb6sy5wGI0bscuBSoK?=
 =?us-ascii?Q?ReY3EhRFZOuANu6Vt6Eu3VL7HPCvinkiQKKnDpu0vbhGs8B88erdNaCDDjRR?=
 =?us-ascii?Q?FOe+fc76dbznehE7seF0lMf53axWl5sBo2nYVitMAgQ7gaqzN3O0ZB4D/Txl?=
 =?us-ascii?Q?5kMv1gkPpSaUeeoHR7Io/jgPssN/W31xRWs5h79gzBW++rUDtkqA+PSCOTnD?=
 =?us-ascii?Q?r/XiyaNE7JSL5szEHl7zZrh7z+TLi5fNz9IZxDJU?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b8a2a9b1-9c0e-4099-273a-08dc597aca5b
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Apr 2024 16:25:09.6667
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nQRiTQzjlrlWZmSdRsNYcu4EbluCG1DHF1lJoUDMDJ6Ax050ks+hwIhQmfziAniwN3Hkh3WL3+rPlvOi3QU8Rg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB9644

On Wed, Apr 10, 2024 at 08:47:00AM +0200, Krzysztof Kozlowski wrote:
> On 10/04/2024 08:32, Krzysztof Kozlowski wrote:
> > On 10/04/2024 08:30, Krzysztof Kozlowski wrote:
> >> On 09/04/2024 23:09, Frank Li wrote:
> >>> On Tue, Apr 09, 2024 at 10:02:32PM +0200, Krzysztof Kozlowski wrote:
> >>>> On 09/04/2024 20:54, Frank Li wrote:
> >>>>> fsl,imx8qm-adma and fsl,imx8qm-edma don't require 'clocks'. Remove it from
> >>>>> required and add 'if' block for other compatible string to keep the same
> >>>>> restrictions.
> >>>>>
> >>>>> Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> >>>>> Signed-off-by: Frank Li <Frank.Li@nxp.com>
> >>>>> ---
> >>>>>
> >>>>> Notes:
> >>>>>     Change from v2 to v3
> >>>>>       - rebase to dmaengine/next
> >>>>
> >>>> This fails...
> >>>
> >>> What's wrong? 
> >>>
> >>> https://git.kernel.org/pub/scm/linux/kernel/git/vkoul/dmaengine.git/log/?h=next
> >>>
> >>>>
> >>>>>
> >>>>> diff --git a/Documentation/devicetree/bindings/dma/fsl,edma.yaml b/Documentation/devicetree/bindings/dma/fsl,edma.yaml
> >>>>> index 825f4715499e5..657a7d3ebf857 100644
> >>>>> --- a/Documentation/devicetree/bindings/dma/fsl,edma.yaml
> >>>>> +++ b/Documentation/devicetree/bindings/dma/fsl,edma.yaml
> >>>>> @@ -82,7 +82,6 @@ required:
> >>>>>    - compatible
> >>>>>    - reg
> >>>>>    - interrupts
> >>>>> -  - clocks
> >>>>>    - dma-channels
> >>>>>  
> >>>>>  allOf:
> >>>>> @@ -187,6 +186,22 @@ allOf:
> >>>>>          "#dma-cells":
> >>>>>            const: 3
> >>>>>  
> >>>>> +  - if:
> >>>>> +      properties:
> >>>>> +        compatible:
> >>>>> +	  contains:
> >>>>
> >>>> It does not look like you tested the bindings, at least after quick
> >>>> look. Please run `make dt_binding_check` (see
> >>>> Documentation/devicetree/bindings/writing-schema.rst for instructions).
> >>>> Maybe you need to update your dtschema and yamllint.
> >>>
> >>> Strange, Test passed
> >>>
> >>> make ARCH=arm64 CROSS_COMPILE=aarch64-linux-gnu- -j8  dt_binding_check DT_SCHEMA_FILES=fsl,edma.yaml
> >>>   LINT    Documentation/devicetree/bindings
> >>>   DTEX    Documentation/devicetree/bindings/dma/fsl,edma.example.dts
> >>>   CHKDT   Documentation/devicetree/bindings/processed-schema.json
> >>>   SCHEMA  Documentation/devicetree/bindings/processed-schema.json
> >>>   DTC_CHK Documentation/devicetree/bindings/dma/fsl,edma.example.dtb
> >>
> >> Nope, you tested other patch. Just look at your second patch for this.
> >> When reviewer points to errors to your code, please investigate?
> >>
> >> NAK, fix your patches.
> > 
> > And to prove it, so you will stop wasting my time:
> > ../Documentation/devicetree/bindings/dma/fsl,edma.yaml:192:1: found
> > character that cannot start any token
> > 
> > ../Documentation/devicetree/bindings/dma/fsl,edma.yaml:192:1: [error]
> > syntax error: found character '\t' that cannot start any token (syntax)
> > 
> > ../Documentation/devicetree/bindings/dma/fsl,edma.yaml:192:1: found
> > character that cannot start any token
> > 
> > Documentation/devicetree/bindings/dma/fsl,edma.yaml: ignoring, error
> > parsing file
> 
> Dear NXP,
> 
> Quality of patches from NXP is terrible. Several of them are poorly
> coded, not following coding style, their submission is not following the
> process and requires a lot of effort from reviewers. I was already
> complaining about this on mailing lists months ago.
> 
> Things did not improve much.

I understand what's your concern. I just said I run dt_binding_check before
submit patch. Never said I will not take time to inversitage it. Actually
I found the problem yesterday and will fix next version. I also find what's
wrong why success in my side.

I also read many of your email about other thread in dt-binding. Most is
the similar question.

The words in your all email "It does not look like you tested the bindings"
is most frequency words regardless from nxp.com or NOT.

Yaml file look like as document, but actually NOT. Unlike C code, which
can compile and running.  And more people get well trainning at debug C
driver. Actually it takes more time handle binding yaml doc than debug
driver code. Some item is actually quite difficult to understand without
deep into json scheme. It is not simple as what look like. It may cause
many low level error because it it not simple as what look like and even
hard.

The whole reviewer team take great efforts to make dt-binding better. 

I think it should stop complain and start improve tools. 

For example: 

I try to add --check in b4.
https://lore.kernel.org/tools/20240319045332.2304950-1-Frank.Li@nxp.com/T/#t

Some self-auto-bot help filter low lever problem.

And from another point, it means more and more NXP engineer want to take
more time and efforts to do upstream works.

> 
> However another trouble is the quality of responses during review. In
> many patchsets your responses to reviewers comments were half-baked, not
> on actual topic or just with minimal effort to close the topic from your
> side. That's not how it works.

Some background is difference. There are many argument spaces at some side.
'minimal effort' is not exist. I bet the email reply to community is 10x
carefull more than other internal email.

> 
> If you receive comment, you must investigate. Don't respond immediately
> "no, I don't see error" or "but I want something else", but be sure that
> you fixed the problem.

My intention "strange, test pass" just said my suprised "why it success in
my side" and "will check tools and my environment", Not "skip run
dt-binding" before submit. But what your understand is , "my comment is
wrong, and you stop inverstiage it and close this topic".
  
> 
> Such responses of minimal effort or pushing your own patch is
> significant effort on reviewers side. I was complaining about this as
> well. This patch here, which does not even build/test yet you claim in
> response that you test, is perfect example of it. You got comment from
> reviewer and instead really investigating this, you respond that
> everything is good on your side. Typical response with minimal effort on
> your side, but pushing it to the community.
> 
> That's it, that's too much.
> 
> NXP, your contributions are poor quality and put too much effort on
> community.

Many time, I want to help filter out some low level problem for nxp patche.
A long-term illness makes a good doctor. Your team work are too efficency.
before I can do anything, you already provide professional feedback.

> 
> Please improve your process, e.g. by training people interacting with
> community and using extensive internal review. You can also reach to
> experienced community members for help in training and explaining
> upstream work, like Denx, Pengutronix, Bootlin, Linaro, Baylibre,
> Collabora and others.

If you can help do trainning for us, weclome!!

> 
> Till the situation improves, I will be ignoring all patches from @nxp.com.
> 
> Best regards,
> Krzysztof
> 

