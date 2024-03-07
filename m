Return-Path: <dmaengine+bounces-1301-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E567875987
	for <lists+dmaengine@lfdr.de>; Thu,  7 Mar 2024 22:42:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 13BF9287E7B
	for <lists+dmaengine@lfdr.de>; Thu,  7 Mar 2024 21:42:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4ED6E13BAC4;
	Thu,  7 Mar 2024 21:41:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="DkIm7QIK"
X-Original-To: dmaengine@vger.kernel.org
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04on2078.outbound.protection.outlook.com [40.107.8.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFFEE13A25F;
	Thu,  7 Mar 2024 21:41:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.8.78
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709847709; cv=fail; b=LlIj82jp3yrafN9fqmRFvdMkpj8V6oiVZa5Aps38WIRlvPJqC6woAOUJYPrPHCkIf9hLI6n6eyMtP241TDYpFnpjG0GB9psTBKBZQbheKR2A8Chzb3h6bdXb8xLBtzbWmjc14u+A8/0Bt42nPje/s62PZghjXokEJVZeFkiYEcg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709847709; c=relaxed/simple;
	bh=TQ4NTimwZxG+EyRYrm68B1xbnOOQ48dMJEUiKU3DyzI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=RMeEDxPv/yvK8g3Fd+dkEIsBZwHWFSsx/iyG3RN2sVEFb4sRQ6/WfZ0wxNQM0wf0noV+bXbgOaPA9T5QeQ1KlIyiC/cM/tCl25tB/GjmPaRf6DW2/Uuqwyb1eQkGPAFU7RdTzEiUb+ScyozDQtUvDwiDb0pxPBBORKkQfo2cjlY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=DkIm7QIK; arc=fail smtp.client-ip=40.107.8.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mbilK1j+tERH+jA/vvJ/Lx6jXCCCeHjXsYBRbg+g6fju8Sp6mW0V/SJ8FvvZiTIzlrugOhnDvHtBSW42cuuNBTRdYLitLytmUZ/UICS3dYQxoRlWbH5aaQI/fU5bEXLfkUzrkhsvrGFeCNGuM/fLZWRS5e7WCDO+TpXb0u1u/A95lcRPlUcQ13FOnp+eXcpgItIBfyJKXLdFud/yCUVmf9r27YEps7xiWJz+/8cJunhfAa0kgQzlZCyOzSr7cnQaUUy2yLgMhnoLZlTlBHlegsGxqxPOVL38JohRKGH/50usPVJMKbhbFovS/dkV0Fy5wqH3CQ50Zj5+4ml0OymNig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DIpRJNkZFwKoqt2ypVTyFcx9QN8hfNOmzqHKX43LUdQ=;
 b=PU2laABRmPA+nrf6EthtesbSlnKxRWRCvkDwc0MFVhbDA+ZpMAy5dSKxqBriGVqhWyR+Rjek1sNdxEEoIIlOPM2I916jenxSeChiPjpuBLk8qv44Gt+uDxgIJWpunrPVXT/TZvRogLLDc7PU+92RUWL85/4yX53RgpFXnA8DYXpsOhsTL/D3AiYi8pR697u/AOperm8JR5pwKAfZVD4n/W2LxEL4r0GvtyiEJqz+4Ie5gxjMeuQD9pnXONL7P+21JIXpmbTTLG0ID/ciuXCPR85QotP45daT15c/IrnbUWOsJwAevFcHM9vEUksBBfAC1jYiHZgEUmZ00CE332ASWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DIpRJNkZFwKoqt2ypVTyFcx9QN8hfNOmzqHKX43LUdQ=;
 b=DkIm7QIKy18WTyd7XKhvu/Qd8pdm9FPy1aoRx/lhfmzEa0pVrIRbVtWDLxXH69Pykh+9i8xGPfNP5vXidxtvnT0LDNGPeDIHYsxmG3hdHM7EeLNHPg81lLPX+23b0e3dmI09tD0AeaVdq4iqGCEf2cI0n2JErTC000ZSODBwRB0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by AS8PR04MB9079.eurprd04.prod.outlook.com (2603:10a6:20b:446::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.24; Thu, 7 Mar
 2024 21:41:43 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::3168:91:27c6:edf6]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::3168:91:27c6:edf6%3]) with mapi id 15.20.7362.024; Thu, 7 Mar 2024
 21:41:43 +0000
Date: Thu, 7 Mar 2024 16:41:36 -0500
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
Message-ID: <Zeo0kBo4BDTTdKoU@lizhi-Precision-Tower-5810>
References: <20240229-8ulp_edma-v2-0-9d12f883c8f7@nxp.com>
 <20240229-8ulp_edma-v2-4-9d12f883c8f7@nxp.com>
 <20240304164423.GA626742-robh@kernel.org>
 <ZeZZyTU8FWACW9aj@lizhi-Precision-Tower-5810>
 <CAL_JsqKU=Qay75i1zaasaNHCV2jkseX94fzfe-4AwrV093NOLA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAL_JsqKU=Qay75i1zaasaNHCV2jkseX94fzfe-4AwrV093NOLA@mail.gmail.com>
X-ClientProxiedBy: SJ0PR05CA0001.namprd05.prod.outlook.com
 (2603:10b6:a03:33b::6) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|AS8PR04MB9079:EE_
X-MS-Office365-Filtering-Correlation-Id: c6bf1cf2-5950-4ff9-4a39-08dc3eef6169
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	42qOpNEAynDWeQyOYBzz0GhMtiDkR0KbiNmqp/lTm0yKOB0zFw2aYLCNAy9DcUJr4OS6hbD78m5QBg0U2OX3Tha0KlcyDUAWvtX/u3auS239MVbQ71ZjUOviFRH2nfE4BR1Ba40vYhFixAvGL6CYKNYoAgtwlrpGDDShbUjiDLbBLK+Ti876a3zbvCpfIB/QmUSK90tE/Ec48MY5Pg7431uOyiC3FPIeBVe022BjJuE+ljRXmh0YdqJ0OJUWeGCssRtCPQ8/BSBo43Lnz2Bv0bVmnsylInJnIMJ8yHzysVgzpprt5wO3jk/W4HRDiNjWDWZvV+/kYuuRzcH+q0VYUazVEjAsFfPS6umETJzsWBfSdKozVzRadLZJMHrNc+v6yvp2eHD3/NEPfcWj/U6PtCCwFKNVH9fDgNSp68OIyIhjOQqwMSdh0XsVFc8gvh2JBMw5CX6xzQ+hXyRFLVj1cnmv7B11I2KY9976wppF3L5DiugEm9yhI2PeaALedPYaWT+IhDSxHiQJKxCYvZuJkVEOXG5lsf3Br4y+KIBRylmVxbA1gdxr1HA5J0ThJoyfbYwniBpG1n4xCXddRK/3PcGWt7gSBlh9zSZQM6bQJxr7olWu9KoOdUGEP1bDbXmuVq4bfSjbzTG3HhxjkmL5oyn02JFCJOnkGZPcB4xRFh4J6XEZ0fqYjYPh41YtBhR95a4aKy1ueI4RmiBt2DAu/vFhPu6rE2qLrvFx4kxPNfA=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UWdTTkszSUdWRVp0NzBGQnRpdENlMUhJckhyVUJQN1ZtTDVnZkJXVDNJbkZ4?=
 =?utf-8?B?dE5jck5uYWZLbEZXUGtobElTL1JKRjlITzk3T2hYdDJrRmVTYk9uU2VVdFNJ?=
 =?utf-8?B?TzJoYVhleHdRa1JCdjdFQkNLaU1ub2JWeXk2dkIwNHpKcEo1MjFSRGd3ZS9C?=
 =?utf-8?B?amk2NHJnb0pLMkR4bjgxeXkrWThndzNTVXNGd0lsMm1BVzZrbTF3RnptblZz?=
 =?utf-8?B?YlIzbDVOTnlucXlGS2krNXVYVDI3OTVrZi9FUVF4c3VYR0lMbUwyNThtRUI0?=
 =?utf-8?B?Q1kyQlRMSHNjMDl1Ni9ob2M0anJjSTk1QUpha2xOaWdwaVR6UzJ3YUwxbG5i?=
 =?utf-8?B?WE42cndDdmlibm9EUWNaeW00TVg1Mk5CYzhZRVo1dk1LeTZsY2ZqN3pyQkdh?=
 =?utf-8?B?ZU1zMjZ4VC9GN0NRd2F2eFZkVjgvMzVDSTJLSHI3eDlSVlYzZTlPdHhKRExY?=
 =?utf-8?B?azRHaUs1NlRIM3cyQzMrU1hxUHFnQ1Q1ZUptQVE0U1gzWDA5U1pBUkxIajdH?=
 =?utf-8?B?eVBBUTJ1SWtqcFBNVmFNcGNQYmMxQ3NSTjJrRktiRUd2THhEU3NmY2N3UmdR?=
 =?utf-8?B?USs4ZFltZjZGK2VEdUw2TzFpZ2dwL0tiamNZY3FYNzlsMWVzeDZxSTRIT3Nq?=
 =?utf-8?B?akJUa0FrSTR2a1RrN2JuS2xWUklDOVFzMkkxYlJkdnpQOERabmJuRUZRcm9X?=
 =?utf-8?B?U0dZNVBkNzlWb3hzUVBDTDhxVnR5blhhajhvUXYwaThWMktNakU0bnRNZHdh?=
 =?utf-8?B?NGY1amV3Zk1vcmF2V2xta1dUVERDcHQwWTZXNGsrOUNhUDF2NEhxQmN2Qm1I?=
 =?utf-8?B?ZGZlODJaakFreHIvOExEdndOay9nLzlqNDNSZlFPRStWQ3JDdlduaThOb0ti?=
 =?utf-8?B?Ri9acm5MU1h0cy81T3V4RFJ3NzZEMXhJMkZNWUVuQmV4MWpabEJJaHJXWlpv?=
 =?utf-8?B?UVJHVnFMRmM1K3FmRmtkcnN4SHplTmZaaCtlTmxGR0UzZjZDSE5jSytTbkds?=
 =?utf-8?B?U3JjUmVTMW9IeElCeENwZkxmQzZqbm9QL2xZQTBjclR4VFYxSnQvYmN4OWgz?=
 =?utf-8?B?R1NQR0dyaVptc0paUytiQW5DQm1sZkU3SjZoTlg5UUR6WlBBZG8xaE5MaG55?=
 =?utf-8?B?Vm1BMmpnRGZObVZraERRclM5SGIvYm0zclFHUmlJR2IyYTE3TnJzWlRzMGg4?=
 =?utf-8?B?dmZOODJsdlpsYUprbnV1WXdKNVorMTJNNFFJVFM5eHovWk0wYUNNMUloOXdl?=
 =?utf-8?B?QnB6MEVKREI4Z1JEL0tMckhnOW9FNE9mQWNRUzN5L2hBeGV1WGN5VVA5TStr?=
 =?utf-8?B?TWxvcU1XeDk5aTgxOUN5VWxOR2s0K1JRLzdPeEltVjZsVzdMTTZUamRBL3pK?=
 =?utf-8?B?WE1rVXZRajh3aTIrVVdKdWpBZWhGaXJrQ0FXUk10dXorbSs0WUZka0xlM0VR?=
 =?utf-8?B?cCtQZzVwS0FmS1o1cmFjeVdrOUo1a21OTTJvR3VwNmd4czYvNFZDS0ZHM2tP?=
 =?utf-8?B?NnNSRWJoNXhSbU4zd2FHc2Z3WHI3VGJLVWdXNUhKVWlEc0hxTjVSUXZNVTJr?=
 =?utf-8?B?a3JxNEdIWnBEOFRheUQ1UE1OUG5KaHRLNm5HZEMyRWhQTVl5Nkl2TDA3ZVM3?=
 =?utf-8?B?K1grc25oWDZJK1BpcDZqdEdZOXI3alA2RFNyL2R2MnNGbFVka2lPT2VXV0l6?=
 =?utf-8?B?RUt2Snc1NkRuczlIdUJSYkd1L1BkQm1tQVZ1Ui9RT3hhYmd5amx5MmN1QUFQ?=
 =?utf-8?B?cVl0cjJvaEx4RXhBaEwwa050TkFYMjViRVJVQzZaZ0JVWnFyZElXNWQxekJu?=
 =?utf-8?B?dk1pNFVPc0VtejdlNEplUERZeHZkL0ZKSyt5OFlIM04rNm1zN2N4cHQ3a1lV?=
 =?utf-8?B?SUpnWXVuQ3VPN2xaMkQzZitxZkJZOVJ2Q0k3VUlOTTFuR2FXSXBmNnNhUHQv?=
 =?utf-8?B?RFl0d2U4VUI3YVhaZVNRa1ZnUy9rakdEWVZwWW15NXR3OC9zNCtMVlJoL3BL?=
 =?utf-8?B?c3FvUUtSK2Y3UjhvR0k3b002RWU2MFd5UGpmZVBBdkVlVVlKTXVhS21xMDFy?=
 =?utf-8?B?azV3R24wTTkvSmpOQmdUWGhjbTVESFlOV1dVa1lwTG5FSURYN0J0aHFxSnBP?=
 =?utf-8?Q?RFNi08YE6V+aghkP0B1o0/4vx?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c6bf1cf2-5950-4ff9-4a39-08dc3eef6169
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Mar 2024 21:41:43.3299
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TUBA2gNv8LfLQvDr0ZuTDHygRMCk2CJypl6bZ2PgXm7o+Dv57YoS+uVPyMHNhXaSbQxZoQupYW5VuIY0cV14WQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB9079

On Wed, Mar 06, 2024 at 02:40:23PM -0600, Rob Herring wrote:
> On Mon, Mar 4, 2024 at 5:31 PM Frank Li <Frank.li@nxp.com> wrote:
> >
> > On Mon, Mar 04, 2024 at 10:44:23AM -0600, Rob Herring wrote:
> > > On Thu, Feb 29, 2024 at 03:58:10PM -0500, Frank Li wrote:
> > > > From: Joy Zou <joy.zou@nxp.com>
> > > >
> > > > Introduce the compatible string 'fsl,imx8ulp-edma' to enable support for
> > > > the i.MX8ULP's eDMA, alongside adjusting the clock numbering. The i.MX8ULP
> > > > eDMA architecture features one clock for each DMA channel and an additional
> > > > clock for the core controller. Given a maximum of 32 DMA channels, the
> > > > maximum clock number consequently increases to 33.
> > > >
> > > > Signed-off-by: Joy Zou <joy.zou@nxp.com>
> > > > Signed-off-by: Frank Li <Frank.Li@nxp.com>
> > > > ---
> > > >  .../devicetree/bindings/dma/fsl,edma.yaml          | 26 ++++++++++++++++++++--
> > > >  1 file changed, 24 insertions(+), 2 deletions(-)
> > > >
> > > > diff --git a/Documentation/devicetree/bindings/dma/fsl,edma.yaml b/Documentation/devicetree/bindings/dma/fsl,edma.yaml
> > > > index aa51d278cb67b..55cce79c759f8 100644
> > > > --- a/Documentation/devicetree/bindings/dma/fsl,edma.yaml
> > > > +++ b/Documentation/devicetree/bindings/dma/fsl,edma.yaml
> > > > @@ -23,6 +23,7 @@ properties:
> > > >            - fsl,imx7ulp-edma
> > > >            - fsl,imx8qm-adma
> > > >            - fsl,imx8qm-edma
> > > > +          - fsl,imx8ulp-edma
> > > >            - fsl,imx93-edma3
> > > >            - fsl,imx93-edma4
> > > >            - fsl,imx95-edma5
> > > > @@ -53,11 +54,11 @@ properties:
> > > >
> > > >    clocks:
> > > >      minItems: 1
> > > > -    maxItems: 2
> > > > +    maxItems: 33
> > > >
> > > >    clock-names:
> > > >      minItems: 1
> > > > -    maxItems: 2
> > > > +    maxItems: 33
> > > >
> > > >    big-endian:
> > > >      description: |
> > > > @@ -108,6 +109,7 @@ allOf:
> > > >        properties:
> > > >          clocks:
> > > >            minItems: 2
> > > > +          maxItems: 2
> > > >          clock-names:
> > > >            items:
> > > >              - const: dmamux0
> > > > @@ -136,6 +138,7 @@ allOf:
> > > >        properties:
> > > >          clock:
> > > >            minItems: 2
> > > > +          maxItems: 2
> > > >          clock-names:
> > > >            items:
> > > >              - const: dma
> > > > @@ -151,6 +154,25 @@ allOf:
> > > >          dma-channels:
> > > >            const: 32
> > > >
> > > > +  - if:
> > > > +      properties:
> > > > +        compatible:
> > > > +          contains:
> > > > +            const: fsl,imx8ulp-edma
> > > > +    then:
> > > > +      properties:
> > > > +        clock:
> > >
> > > clocks
> > >
> > > > +          maxItems: 33
> > >
> > > That is already the max. I think you want 'minItems: 33' here.
> > >
> > > > +        clock-names:
> > > > +          items:
> > > > +            - const: dma
> > > > +            - pattern: "^CH[0-31]-clk$"
> > >
> > > '-clk' is redundant. [0-31] is not how you do a range of numbers with
> > > regex.
> > >
> > > This doesn't cover clocks 3-33. Not a great way to express in
> > > json-schema, but this should do it:
> > >
> > > allOf:
> > >   - items:
> > >       - const: dma
> > >   - items:
> > >       oneOf:
> > >         - const: dma
> > >         - pattern: "^ch([0-9]|[1-2][0-9]|[3[01])$"
> >
> > I understand pattern is wrong. But I don't understand why need 'allOf'.
> 
> The first 'items' says the 1st entry must be 'dma'. (It might need a
> 'maxItems: 33' too now that I look at it.) The 2nd 'items' says all
> entries must be either 'dma' or the CHn pattern.
> 
> > 8ulp need clock 'dma" and "ch*". I think
> >
> > items:
> >     - const: dma
> >     - pattern: "^CH[0-31]-clk$"
> >
> > should be enough.
> 
> If it was, then I would not have said anything. If you don't believe
> me see if this passes validation:
> 
> clock-names = "dma", "CH0", "foobar";

        clock-names:                                                       
          minItems: 33                                                     
          items:                                                           
            oneOf:                                                         
              - const: dma                                                 
              - pattern: "^ch(0[0-9]|[1-2][0-9]|3[01])$"   

Above code can pass check and detect error of "foobar", it should miss
restriction about first item must be 'dma'.


Your previous allOf block, 
 allOf:                                                               
   - items:                                                           
       - const: dma                                                   
   - items:                                                           
       oneOf:                                                         
         - const: dma                                                 
         - pattern: "^ch([0-9]|[1-2][0-9]|[3[01])$" 

It reported clock-names too long.

Frank


> 
> > If you means put on top allOf, other platform use clock name such as
> > 'dmamux0'.
> 
> What? It's under an if/then schema.
> 
> Rob

