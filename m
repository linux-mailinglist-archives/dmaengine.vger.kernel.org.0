Return-Path: <dmaengine+bounces-3991-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7787C9F35CE
	for <lists+dmaengine@lfdr.de>; Mon, 16 Dec 2024 17:22:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C7ED5188CB05
	for <lists+dmaengine@lfdr.de>; Mon, 16 Dec 2024 16:20:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB098203D50;
	Mon, 16 Dec 2024 16:18:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="L4EqLhwT"
X-Original-To: dmaengine@vger.kernel.org
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2040.outbound.protection.outlook.com [40.107.21.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF558202C50;
	Mon, 16 Dec 2024 16:18:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734365935; cv=fail; b=tgfKT0hDZuBcGUAm3kuvEdvuTX50dSZhqKxE/pjxyeZKOA/MuRlRhPSJ+vJZzcW9C8mUvjxdDzmswDIrc2WUstksPEwh4ERy2CCIB5sLzTsb/i/7GKMHW0yWijQvQ4QUJXM5wKzSzTHNSPrvabPgc5vnnlYV2/OEtIP+qCUhuJk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734365935; c=relaxed/simple;
	bh=IUHyDz2xEs/xUHG/M9nTonPuJtNIdPNVPu5EfHmrw3E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=lfXyFWBUROxPy3iJ6owBRu0KpUGirFNVlSer2ucwer+vXkGV0ofKGD0/k81Gc/zv5vFdHV8AeioC1NBMlht4c3vutLdp9f96wzw81C6bAdmUME3rLW6njPMP9lEyO4/k/x8w6zzVQwSbbFATuVXr6s26xcCpjC+wom6/ovOqKlg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=L4EqLhwT; arc=fail smtp.client-ip=40.107.21.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=V/9HMRRjR4cHKkXCdI/IiCWqK8h1vZqjeCGK9o65GLapleE10mQlItlmrYcYfsrSl50uSJGwfvGpZDbps4xG58cTQxg4yHxjuchiOQWJ3gYrP08yIfZySPoze//4OcIpD6/WFWmg8OXhNuklLtGQvZXth1YwUa/ZbOKmTo/Fa6OGpaTULraVHrkgTuHwbXsYHLyGZICKwDRQ4CVkD27N4R6FpFo+8z2jWFXVTjYm3rlDVVClvfROifRIUrZy4JqGGPN7ElCCLBCtQuxLLvQXXu02+jknBbNr3JRJ9S81ICcGOFYRFBLU/lJLYJoZCtEGQ2up59hjVn8SlCeMs852RA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uSEPWmCQyQkv+BDSeYVEwpdHAo+PUmxsr0ROvHpLlJk=;
 b=TSp1IBnFGCGliB/blQa0vrbDW0p7whKUzndEddxW+dTf+r6t6TGuoGD3paLxCpnqNmgkmtOc7dlIqGr05mfjuKMljszudttBbEL1axtejhTQvPzluLr95mt2lMxMzODbU4awDLpI4Kg9cnmjp5eGV5SH2J6QanVtNkFzfbsrYsCnm+BeKpnQXUy11v3LHgappNwZ/lLmifzgu0e5axzZytcPLYSGqosIPnsQhhsbd35CjdDFTXoIcUKVgfhC2DbZq2JW3yKuqs+mYgkZDB8oSx7/zx5BRet5YlDQnW4JrPkq0rj8ePDluIH+quVeHJvhW8mpcbmLHtuDtGFvLHAQCQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uSEPWmCQyQkv+BDSeYVEwpdHAo+PUmxsr0ROvHpLlJk=;
 b=L4EqLhwTZXWReOOlkhGLr24YUWHDQjv4kvDVXCZyHTP67yre2jjjQswDyrIkkU2AZ+2IIerEgR2V3UGliPrTM8ICr7Vew52BTQBYaUMMxouMSmH7klpj2TxiPr//lqcJ2gTD15V1k/gJo2f/qAN5B9Bd9aHi4fR97fv1VEGYmDJFBMWIuWHpqR+WZHbf/NpW8ZukB1TdRZQmFexFKu0ZWtH34OExCoOv+f98GguQQH3aljWMeSgEZdnRFTgeR+D3XodyJM/Q+XvnUMTKFMiCN29BkHIrxUY0YbE4ggIu4coG4U6RYaA+3+th0zCsJhdciZVeUyg18PY40qaayeTasg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by AM9PR04MB7523.eurprd04.prod.outlook.com (2603:10a6:20b:2d6::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.22; Mon, 16 Dec
 2024 16:18:50 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%5]) with mapi id 15.20.8251.008; Mon, 16 Dec 2024
 16:18:50 +0000
Date: Mon, 16 Dec 2024 11:18:43 -0500
From: Frank Li <Frank.li@nxp.com>
To: Larisa Grigore <larisa.grigore@oss.nxp.com>
Cc: dmaengine@vger.kernel.org, imx@lists.linux.dev,
	linux-kernel@vger.kernel.org, s32@nxp.com,
	Christophe Lizzi <clizzi@redhat.com>,
	Alberto Ruiz <aruizrui@redhat.com>,
	Enric Balletbo <eballetb@redhat.com>
Subject: Re: [PATCH 5/8] dt-bindings: dma: fsl-edma: add nxp,s32g2-edma
 compatible string
Message-ID: <Z2BS420NSz6u+Ir6@lizhi-Precision-Tower-5810>
References: <20241216075819.2066772-1-larisa.grigore@oss.nxp.com>
 <20241216075819.2066772-6-larisa.grigore@oss.nxp.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241216075819.2066772-6-larisa.grigore@oss.nxp.com>
X-ClientProxiedBy: BYAPR03CA0023.namprd03.prod.outlook.com
 (2603:10b6:a02:a8::36) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|AM9PR04MB7523:EE_
X-MS-Office365-Filtering-Correlation-Id: f1aef4b3-c1a5-47cf-5185-08dd1ded538f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|52116014|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?hb/mRE2TTYnQZki5JSt+oimU3as5fwCnWZiq1+B4WxJ4JW2dPacJzw60PBP2?=
 =?us-ascii?Q?FnE7S+Djrznk3zLD7Hd3rsB+/ZWgNr2FWNScVDekclf/OGjLhezykSVXEuPW?=
 =?us-ascii?Q?WcF6Z0ZxZZeoT/LV8fz4REn5nWW4q4smXoRmqVVvMR3Yb0wdTGo9jEhMPqQ/?=
 =?us-ascii?Q?xLwAxOpRMz/C/IOPo1zAzNi9A+4vBcGLoxomaab8KFMp2BxoifUjQHBuXwgF?=
 =?us-ascii?Q?nPilseCzShRQpkZlTXuKOSuZ4+7u8lvxwnV3u0hk6Sr+Ru6g+bAlFC4j49+5?=
 =?us-ascii?Q?irKGcHR+KkcLS0z6B/ZzVA8Fl8NxEldbD89XlOUHuZCvKfuk+I8q/B5H4Zn8?=
 =?us-ascii?Q?JtJgbcRa1t3+je0RvyOP8tbDZ46A+9g7TCrLP5KcOxgp3aT/ASGWsVT2dOzv?=
 =?us-ascii?Q?e4KzlTTI44HJJP+8Aj/H+gjgmmT06wTIPhX3JoTdMGscbaBk/BnzIKlgQsUs?=
 =?us-ascii?Q?cr4Jzw/VTvBi6MAaUUYRwKjKmpN7eFGTP13X29il+jv5ok7q45R43hSb5bQm?=
 =?us-ascii?Q?ZkMnlU1Qoj0zgeqN5XJqmaZfuGRif0k7TNJoeGAmlBQU+IMqmFDP3d8U4kxh?=
 =?us-ascii?Q?9iJr/CrMZIFP8qGMPCAUw9UKsM9b2hncFTetBYq3vhT8DCYXBegQACS96KJO?=
 =?us-ascii?Q?S6KgR4DYzvF56RnvPS0Jjo0vdDmOHMOO/KBX7VuKbaSKUAAFAItMt4KKmPWK?=
 =?us-ascii?Q?Zo6n3F8Bo05HbDwIqEOmgBslkIhnC/yYO5uZINPGpF4KbCvrDn4UtSmnYRr5?=
 =?us-ascii?Q?WCPujyGYDFo3sjmL7SquhMNeotjxmswPGsPKDSukJ3IJRlCOTx9TbGAMfrh0?=
 =?us-ascii?Q?OZK+i172V9YKETY4lSDr/eKl+MTs1I6OHEnDRljlwyf3F1CWukvquZbmwQ2R?=
 =?us-ascii?Q?3KpvyO5NQQsiGr/NdHAcTLftSBp55+yyAor1t3SdsF7ghH2mulgIsNoP6uRB?=
 =?us-ascii?Q?9rGSWc1cKB2B08RfjIFZJwFkvrqVFCns4UrhmDLWzejYxDZo9blmzmPNvPnf?=
 =?us-ascii?Q?WQie/eBX6sy9ulHt35icD3ST0hakDHA3Aw1p61hw0r3MSkaLQmUkB3W3Damn?=
 =?us-ascii?Q?MSMXT53eMfoiNMzqSCYsh+ywaCLj1JPUEq3WTaJj9I5jrNorWBpQSQRlvrvk?=
 =?us-ascii?Q?oZbqfkLP/h/QonVVU0op8eIjZFDtQvINr+MAomZwUd+Uo9FP3cJ1SSOJpY1u?=
 =?us-ascii?Q?45dL9P1ioIbYPN6hmcZ5AiM6O7pPxt996QEdzDJbjvzW1kTPd/WeTTw45Sim?=
 =?us-ascii?Q?On6XYgbearqIazzXwGclzVKlWGl1nM2shJhnFNXWgYZN8wfKtzDAlapsE/yU?=
 =?us-ascii?Q?DxkX/AjQ+8fQTEC8idL6TRdVxUrcsgn3qlLOmQa/IS9/gWm5bzBcrBmh07bB?=
 =?us-ascii?Q?Wpw57/IPhA08Z3X2gQdJv6fjaViyG6Sl0Tz5Z45u7RQKZQuXo1w6rMQ/9dJh?=
 =?us-ascii?Q?1mucyLZLQxQkliwZqJopPnXZ/b6PtNMs?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(52116014)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Jh8O/+46JaaVjmKkQPbm6+IE2by+BMXaHtp6RNucga1XxPqlyTFmZGzgz78Z?=
 =?us-ascii?Q?tvXNdXUC5/OSUWTAI7v40a2RtBbx7c/R7VU7bEv0eNVqn55+JesuFCHyhgQi?=
 =?us-ascii?Q?ZWgZN3Ljy5VJSss+0/LP0P67+6GF9PvtLNy0/rLeNLM++x6jW9Sy0GhwyZfV?=
 =?us-ascii?Q?qBFCjs0D6g2+NxXzYfvX7l3Mm21vufZBPtPTdjP4qopMJcIw7FVO7uGI90mF?=
 =?us-ascii?Q?MshoWYONWJZDBksYkFkKcfQIbe5hzfjYo3xZPxcT+AkT+iZHTkKbL6+AqKMy?=
 =?us-ascii?Q?oWa4OsqWwnQwy5zawdn93OcW/DM48yaft0SJY+cbYDKTnYtpUBVXdkBhbM3G?=
 =?us-ascii?Q?W1cbG77J/28tBUgmsTeE7FU2Oye07friDHCQoSYqySGb+ovr/iUDvlyhBVzZ?=
 =?us-ascii?Q?UGbL1AK/FpSzNdC3iC5g5o/ErdLWz0Me09aqvHvnMkM9z+2LaiVKCuG6M81x?=
 =?us-ascii?Q?AG1RVanOLlenFrVZmgbHxphGe/+koPKBliOZtlfOLbxPqtMqQAOJBMZotwto?=
 =?us-ascii?Q?Z4+RKAugHfBaKeFW+CbBXS2dFewofjBTmzUCaqm4zGZnRhi7h4vFtJFcAsSt?=
 =?us-ascii?Q?eeOhoCrcAmhUZ54pEPTNHAHfIoDXcyOovO+/8PCuqU3bkW2hK1Tqt/uiryeb?=
 =?us-ascii?Q?u+bC2ohub172jvvqbca9FpJ9Fp/BCZ+4LizFVlCmRanpR8XomdnOr9nkI7Kh?=
 =?us-ascii?Q?yRmGJZJ5VYePSWT9wJicBP+g8XmF2+SrVMKe0zMXRPQg361hebfHytVwGwCh?=
 =?us-ascii?Q?mhk6+SLv1dUL79MqmjiuLQNDo+XhV9EJ9MKlMlarynJK0SaHoPggk/gsLvrw?=
 =?us-ascii?Q?RywB3APZT13y2dbfJhhTwKeg0/99tWzL8srMUTl5OMxl1pDuYi59FrVCzcwL?=
 =?us-ascii?Q?xsSsRlUT67izSh29yKq1RP/wcpYyXTN2+sXqE4rZiZV2NN2FbhRn6xZ/ev/G?=
 =?us-ascii?Q?ALPgqhWR6qSdtK8E0zJ1cVURipfk4gupy6y1yZqJxcUDMAKqt/n9dqeIfrhS?=
 =?us-ascii?Q?dQCue5+cYjMf4iaayun5AO304Rny8IEhtnpthtbYaoPEHiulHFxjpcxmMnUZ?=
 =?us-ascii?Q?mUdmCKetUwo7Zay4Te+dmPrJ3DOdZsrNFwgrHVDs37sLMExonKb6WnJFlnxF?=
 =?us-ascii?Q?H19RCB1SSVydEdPTZ2jKq6MxIOmCfSVNWPEh021XS9OkO9FNiVD1jMBTv9tV?=
 =?us-ascii?Q?c3arXAx9QH2T7pwAIIR7Q5MfRJXTgIIxqLFSRgGuqOjI3AJSZquFOEsRZIs1?=
 =?us-ascii?Q?7dKVfPyZC3QvRkRemqdGfsXc75DwcKF6kVXWln8CUUgkJj/nqMz3DQLV6itf?=
 =?us-ascii?Q?ShxnXvQg0eRh1Ylg7KV8M6CTAIPDqVMYqVS0XRc4RPfhT1po5Uz9Qz9lx5Ka?=
 =?us-ascii?Q?VIOU3Uk8lqXLy4otfpK8MwJjQ12RC1d/qXJAL7EycZhvVttrTTqxZChxEBL6?=
 =?us-ascii?Q?qu4ahfQe8xL0b3E1MEL2/JQIOK2AN4XrYN2FuJAl1nD5uohORt36ESua/4yr?=
 =?us-ascii?Q?V2+RGHYQXRstBAyO2D5E5gEPRThTOWV7AoE5CqbG5eWFjMdQTpMTSQ1t+3xm?=
 =?us-ascii?Q?5OSwbc5WM/aIqkHHzwZaA2FMpIUVXkZvOhJnfiYd?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f1aef4b3-c1a5-47cf-5185-08dd1ded538f
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Dec 2024 16:18:50.4487
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: F5er3QvgU1G8VFDneeLVFR7eRG6vvKj6iBfRyA36nZ+vKxtVCvXS3NAlg9i8uK3dTplpxL9oiDlB72ieDwGc1g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB7523

On Mon, Dec 16, 2024 at 09:58:15AM +0200, Larisa Grigore wrote:
> Introduce the compatible strings 'nxp,s32g2-edma' and 'nxp,s32g3-edma' to
> enable the support for the eDMAv3 present on S32G2/S32G3 platforms.
>
> The S32G2/S32G3 eDMA architecture features 32 DMA channels. Each of the
> two eDMA instances is integrated with two DMAMUX blocks.
> Another particularity of these SoCs is that the interrupts are shared
> between channels in the following way:
> - DMA Channels 0-15 share the 'tx-0-15' interrupt
> - DMA Channels 16-31 share the 'tx-16-31' interrupt
> - all channels share the 'err' interrupt
>
> Signed-off-by: Larisa Grigore <larisa.grigore@oss.nxp.com>
> ---

Reviewed-by: Frank Li <Frank.Li@nxp.com>

>  .../devicetree/bindings/dma/fsl,edma.yaml     | 34 +++++++++++++++++++
>  1 file changed, 34 insertions(+)
>
> diff --git a/Documentation/devicetree/bindings/dma/fsl,edma.yaml b/Documentation/devicetree/bindings/dma/fsl,edma.yaml
> index d54140f18d34..4f925469533e 100644
> --- a/Documentation/devicetree/bindings/dma/fsl,edma.yaml
> +++ b/Documentation/devicetree/bindings/dma/fsl,edma.yaml
> @@ -26,9 +26,13 @@ properties:
>            - fsl,imx93-edma3
>            - fsl,imx93-edma4
>            - fsl,imx95-edma5
> +          - nxp,s32g2-edma
>        - items:
>            - const: fsl,ls1028a-edma
>            - const: fsl,vf610-edma
> +      - items:
> +          - const: nxp,s32g3-edma
> +          - const: nxp,s32g2-edma
>
>    reg:
>      minItems: 1
> @@ -221,6 +225,36 @@ allOf:
>        properties:
>          power-domains: false
>
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            const: nxp,s32g2-edma
> +    then:
> +      properties:
> +        clocks:
> +          minItems: 2
> +          maxItems: 2
> +        clock-names:
> +          items:
> +            - const: dmamux0
> +            - const: dmamux1
> +        interrupts:
> +          minItems: 3
> +          maxItems: 3
> +        interrupt-names:
> +          items:
> +            - const: tx-0-15
> +            - const: tx-16-31
> +            - const: err
> +        reg:
> +          minItems: 3
> +          maxItems: 3
> +        "#dma-cells":
> +          const: 2
> +        dma-channels:
> +          const: 32
> +
>  unevaluatedProperties: false
>
>  examples:
> --
> 2.47.0
>

