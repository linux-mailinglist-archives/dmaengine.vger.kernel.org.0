Return-Path: <dmaengine+bounces-1488-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 35F2388B8C1
	for <lists+dmaengine@lfdr.de>; Tue, 26 Mar 2024 04:38:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DFF8C299134
	for <lists+dmaengine@lfdr.de>; Tue, 26 Mar 2024 03:38:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 714C0129E85;
	Tue, 26 Mar 2024 03:37:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="V9aQyima"
X-Original-To: dmaengine@vger.kernel.org
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04on2125.outbound.protection.outlook.com [40.107.8.125])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E1C0128823;
	Tue, 26 Mar 2024 03:37:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.8.125
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711424279; cv=fail; b=ESNOnDk6bx8L8S2vAEw9+I7vUL4aDI4fVOWgHsnBXtVRM6H2gVS9XmEICWUzddWlLlfWhls9HW0m4f5aOziZfM0anBEE3QTntKZUBS59Cgl6OMn9ir7wClvmlO2jyu6kr7GmBhOWC8kx6KUbO/xfZVQMb5fUK3N2+BY+n8oWf3g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711424279; c=relaxed/simple;
	bh=KxlxPWucOVmmUICZcKj4rXOhDhFeUPCFa8vUz3rdluY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=ceDu1+AgO7BkSv5RlHoqPlz176zYvGLcztKTzWBlXu2jL65sCZP0OBkCidprhqDNt8NB0HV+5IYymPuHobCMp0OvYJvAupz7Yp5QQ0Xm2gTxSdjrAX8XwV1iT4tRGIMRHbGOPImKYxJPLebnLL0dZxOmQVV5dbiq3HQYAfpYAsM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=V9aQyima; arc=fail smtp.client-ip=40.107.8.125
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=R79J9+NpmKKVSS4mfxAUKBzzDQvng04aftOMOEYnjIDauZ64L4z6SAf0fpXxcEBgmoRYMRsmKYb5Y5DNpl2vzXwbNLPdiTDkXYy91PPqRBlDA9diwa/5hpYFNwZJVjFEkPPqmP74g1EyLof+/fqYMYDjmJ2kdDHfL+x0b2CfCvMgsY1RVggYLXJLol4F+Othy1cZf6dj7F3nKa8wvSKE7k+6lNQsYaiPztokwNgPs4Ti+2qANhR1aoFTwYGPudODCGzOVREB2OHU1OHn9oWFKh2XmFIGi8qCuXDA4ZeBjgcnrhdA7QMsUa/KSVMOzUjSkapTkAR+Kr/T4fXBHamsmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DSXyzkWd2h16R0Amw2ippcDC4inAxrpPqtkzmju3Q2o=;
 b=XhBS15mTR+LmD66t956f/9aiFeKkvSv0pirmz2SWx5iWdrxFyFaGr5fGWmdnCe0mxj05xTa/Ng8Xkm5LEc1deSBT7SBQdXtkFVgvfKkL7QMOkhcTzk0CshSZFDdGB4SELBWP1tqKAmpd3zMhqAAYEjrVF/58omqkYnY2HoCUlfqTID/F5eVeOGJwAl0OiRno6DcOf7NjFG8Oj0DUzWehQoeUXuLjNKGEtBO9XLNtbPnFqlMdukLDnLhq76OwaMWIAhnXrS0CyIrQbcaLBHYVmiq1g9KGaiq542wDVhBrZOZa+pR3Qj47d/uY+JKGO1JGLkl8rKoZJ2Ve7hqG1LeMwg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DSXyzkWd2h16R0Amw2ippcDC4inAxrpPqtkzmju3Q2o=;
 b=V9aQyimag515W1Fqe14o97kxP57HfnulPZteFejghfq1xawXeZtVV/jif2rAH8SGA6whoEtb8GSKgnLd123AP3knCcj4xJEjNitZBCl+BfDImaUYx6EcMspqi+85E2oX9PEOnbQsiduj4ySwLwXdp1cXtTZEWHyUSnJwWud8dn4=
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by PR3PR04MB7322.eurprd04.prod.outlook.com (2603:10a6:102:8e::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.24; Tue, 26 Mar
 2024 03:37:54 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::3168:91:27c6:edf6]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::3168:91:27c6:edf6%3]) with mapi id 15.20.7409.028; Tue, 26 Mar 2024
 03:37:52 +0000
Date: Mon, 25 Mar 2024 23:37:44 -0400
From: Frank Li <Frank.li@nxp.com>
To: Inochi Amaoto <inochiama@outlook.com>
Cc: Vinod Koul <vkoul@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Chen Wang <unicorn_wang@outlook.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Jisheng Zhang <jszhang@kernel.org>,
	Liu Gui <kenneth.liu@sophgo.com>,
	Jingbao Qiu <qiujingbao.dlmu@gmail.com>, dlan@gentoo.org,
	dmaengine@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org
Subject: Re: [PATCH v5 1/3] dt-bindings: dmaengine: Add dmamux for
 CV18XX/SG200X series SoC
Message-ID: <ZgJDCL+aq3ZTE6/1@lizhi-Precision-Tower-5810>
References: <IA1PR20MB4953B500D7451964EE37DA4CBB352@IA1PR20MB4953.namprd20.prod.outlook.com>
 <IA1PR20MB4953E2937788D9D92C91ABBBBB352@IA1PR20MB4953.namprd20.prod.outlook.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <IA1PR20MB4953E2937788D9D92C91ABBBBB352@IA1PR20MB4953.namprd20.prod.outlook.com>
X-ClientProxiedBy: BYAPR07CA0009.namprd07.prod.outlook.com
 (2603:10b6:a02:bc::22) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|PR3PR04MB7322:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	N3X+QX5a3Nw4fJYEO5uibxc96CnW+VC0vaWecACVO0nQcONJNgU/kGlnSJ/lYsfSheq41SGDGAOQUCTejYDEQygIIc2IxIfPL3ySalbnxVUjxmT6UF9QVbs+P5L8V5NkrDi8bt1r3jrw6ADzCPoQVQOaxHPsR28wdncRaOykUBm8pdv6X/qTh5KnKH+/LBfhRTJ4tMrFBPdM1hwjx2rKooKbybdaJs7cvJPQjNpPRU61J4Afwzs1rl7dEmPM078zX8mQnvHcD1Qwfmw0oAWsfV85UDaTGZPPI/oBBQ7tkNip3Jm0uWabktkJ1JeV6tVCIUnhmxIMOKBQzwKodNYfTtMV55pwhjJX24UD3PAfTniGO0XtjJk/WRYr8bKiThCbVM15RJls9DA5EuElUzCyoUsedZJqQUCkrF86qN90nvEt5MsK6/f3U0jfdCCF+k3RatOjp9eubZFmFeCDAjkXiqXX0hsb/hwFy4dZGeLJoLyRXMCDuO8xd46GhvKFsTP3VMYgvFhzVFgGtBvJXaBWZuWJaLTMX9eHFPdCuXhVIz8VSc5FuwmbQxO3fkp3oT8dUJrZKTVD6iEqyeVp98Moo40dlRPUf63NYrO3zaFV6xN4Zi6BRo0pbey9GkdHGQksmpEY9NX3eE+aiw8TX/CjuIi/BFkX0BrLBOlrMR4WKU8=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7416005)(52116005)(1800799015)(376005)(366007)(38350700005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?LBEk+TNwtYPuKPCqITSpH2JYsfj814rSSVbylRkdnO29dPNeEPw249iRiEfm?=
 =?us-ascii?Q?MmcgeZBWjAsSOOmoO0NMPdk2m4Jk8Y4JORcIUfjBolbN2rVr2cnoz1Pz+AcK?=
 =?us-ascii?Q?V7loFvP5aKKU9hBZelTzwdMeoiSJ58dutIpkjDLLlkb5dYCxQHWGiUPWWCKf?=
 =?us-ascii?Q?dT4+ll096i2E2xb6O8oD8R2BiDFHgskw0t53H0C6waULVM03qPqgcZXxhKDi?=
 =?us-ascii?Q?StBlZ7lnuhPwt5XCl+hp3lufdQGDyvgHcB1Ok7g+YdxgFXzi/pyOKoMwvqVv?=
 =?us-ascii?Q?6AbPTR6h83Tn+cIkMBl4ITrBkQPHNAwKydwyA5pH+x48bQIq3XMoD5OVozri?=
 =?us-ascii?Q?gX74dHxtQ3O42o1unfgiz6QtB6kGDJEzvFIoOoJARyvfkneSzDhhu1tSV4F6?=
 =?us-ascii?Q?r8f57NI4Q4nH0Mues5Nvr2YqIpKVYj6tRyo6SNL/vPEc/zCMVg3WhgeMCWZ8?=
 =?us-ascii?Q?1+dId0nWzyJ9sS2fZFW61wyUWJxeEcmUvehkmr7PDmlhQwfa4VlsN6soQ5ow?=
 =?us-ascii?Q?zYRIOz2OpOemiD+lU362F7a9UpqDYQsGVFWjmVDZ+5p7Vu/caJBCDui7D1sz?=
 =?us-ascii?Q?m4VLhxYNkFfmttzsp9Ut6UIZnYpX+DwXAnKDgvCmtJrrjqqpWQynw273dmEc?=
 =?us-ascii?Q?tZ+UhfsZuRQ9RR+E3RnkZmvqkcnL6a3PW7hggjzL+0ZjSn6P4kS6OiqQDkBO?=
 =?us-ascii?Q?mIEO01M1Vz/ZWZ/pyWnJrxzM60eY5DAP37I9V1fkpre4XgJou5TeLtgVNMW8?=
 =?us-ascii?Q?tvwQwf0YYpmdMSmtsA6bUdc7ZaUtxrNm2MYLgatYGQa6pIPSbxwbW3CxRDL3?=
 =?us-ascii?Q?2S5CWlwWpTGcWoOdB/FESzRoc+PjmEctMevGaPPt/5HU9f88gDOV4we4hXRg?=
 =?us-ascii?Q?OsCdCQcxyO2LlD/AJZXDeGoNrx3QoPfx6pEIPfBnq9xyg5jirUv1Vo8MTVAA?=
 =?us-ascii?Q?Vjn6cXWSSvGU8sZ0rxDKCYP9zlAfDm/sEu3vplUeq7I4BDTfwgihPhvvn6Tl?=
 =?us-ascii?Q?cODYZTa3rW4R7g0rJZzOnMoj41VD78bVWU9iAUjHIRDn3sG8w9yKPmS0Ik3D?=
 =?us-ascii?Q?iO98omVpI5i+XctIBZV+/Wcq4VfDYv8oK4je3q1kU9C+xVsCC5+JSAUacf3Z?=
 =?us-ascii?Q?BDNkmU0Dz/K6eUvCkQ6Z7IDQMG9mcerOFEavPX+EoUNgJuML5zhUP8KIJLzR?=
 =?us-ascii?Q?YhL1WS40ZVAhR7Sdn3zS9nTpjgjB4LKlXw54W6Ftij/3foxVJF1+vQVdEL6/?=
 =?us-ascii?Q?/yH4plgVSyQkroHpHJ4JoTVOOvKXB2/be9GinO0zBSpK5fNrsgy3T4BYwmfY?=
 =?us-ascii?Q?FMu0YGhV4jlgA7kOmiLy9Uq1+RDAE2TxjWIiaIAYL5h2hJzplIooDuE4HIL+?=
 =?us-ascii?Q?AmXkj1DHg4ZnOo3DCLqfY7p+ICcQ2iJNZtRKb5O6IOUu3k5ivtO/plQ10qyW?=
 =?us-ascii?Q?gBk6AgkoYdqjr28rA2O7H9IpVjrLMxBqMOLCL3J/iHpL5BZ9zWlQKgyKjXkl?=
 =?us-ascii?Q?harpq/+gkGODucvx5IPb4fNikXnc6cVYeNeK+baeA4SeML2j2UFL7a0qnwsH?=
 =?us-ascii?Q?DW7FvCvouUv86XHeE5Pu9jJd+305929Y082nnCWS?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 47ef9c7a-54b2-442f-d408-08dc4d461e16
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Mar 2024 03:37:52.8624
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5Z7HEkjLKScpvLdTkm/hg6pYJiAgXrft/IIttKdBoHTjskm4GfrCCEbRfsmNPllKHq8y8hV58h4vujA8yVxRBg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR04MB7322

On Tue, Mar 26, 2024 at 09:47:03AM +0800, Inochi Amaoto wrote:
> The DMA IP of Sophgo CV18XX/SG200X is based on a DW AXI CORE, with
> an additional channel remap register located in the top system control
> area. The DMA channel is exclusive to each core.
> 
> Add the dmamux binding for CV18XX/SG200X series SoC
> 
> Signed-off-by: Inochi Amaoto <inochiama@outlook.com>
> ---
>  .../bindings/dma/sophgo,cv1800-dmamux.yaml    | 48 ++++++++++++++++
>  include/dt-bindings/dma/cv1800-dma.h          | 55 +++++++++++++++++++

I remember checkpatch.pl require .h have seperate patch.

Frank

>  2 files changed, 103 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/dma/sophgo,cv1800-dmamux.yaml
>  create mode 100644 include/dt-bindings/dma/cv1800-dma.h
> 
> diff --git a/Documentation/devicetree/bindings/dma/sophgo,cv1800-dmamux.yaml b/Documentation/devicetree/bindings/dma/sophgo,cv1800-dmamux.yaml
> new file mode 100644
> index 000000000000..d7256646ea26
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/dma/sophgo,cv1800-dmamux.yaml
> @@ -0,0 +1,48 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/dma/sophgo,cv1800-dmamux.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Sophgo CV1800/SG200 Series DMA mux
> +
> +maintainers:
> +  - Inochi Amaoto <inochiama@outlook.com>
> +
> +allOf:
> +  - $ref: dma-router.yaml#
> +
> +properties:
> +  compatible:
> +    const: sophgo,cv1800-dmamux
> +
> +  reg:
> +    items:
> +      - description: DMA channal remapping register
> +      - description: DMA channel interrupt mapping register
> +

Look like driver have not use it.

Frank

> +  '#dma-cells':
> +    const: 2
> +    description:
> +      The first cells is device id. The second one is the cpu id.
> +
> +  dma-masters:
> +    maxItems: 1
> +
> +  dma-requests:
> +    const: 8
> +
> +required:
> +  - '#dma-cells'
> +  - dma-masters
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    dma-router {
> +      compatible = "sophgo,cv1800-dmamux";
> +      #dma-cells = <2>;
> +      dma-masters = <&dmac>;
> +      dma-requests = <8>;
> +    };
> diff --git a/include/dt-bindings/dma/cv1800-dma.h b/include/dt-bindings/dma/cv1800-dma.h
> new file mode 100644
> index 000000000000..3ce9dac25259
> --- /dev/null
> +++ b/include/dt-bindings/dma/cv1800-dma.h
> @@ -0,0 +1,55 @@
> +/* SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause */
> +
> +#ifndef __DT_BINDINGS_DMA_CV1800_H__
> +#define __DT_BINDINGS_DMA_CV1800_H__
> +
> +#define DMA_I2S0_RX		0
> +#define DMA_I2S0_TX		1
> +#define DMA_I2S1_RX		2
> +#define DMA_I2S1_TX		3
> +#define DMA_I2S2_RX		4
> +#define DMA_I2S2_TX		5
> +#define DMA_I2S3_RX		6
> +#define DMA_I2S3_TX		7
> +#define DMA_UART0_RX		8
> +#define DMA_UART0_TX		9
> +#define DMA_UART1_RX		10
> +#define DMA_UART1_TX		11
> +#define DMA_UART2_RX		12
> +#define DMA_UART2_TX		13
> +#define DMA_UART3_RX		14
> +#define DMA_UART3_TX		15
> +#define DMA_SPI0_RX		16
> +#define DMA_SPI0_TX		17
> +#define DMA_SPI1_RX		18
> +#define DMA_SPI1_TX		19
> +#define DMA_SPI2_RX		20
> +#define DMA_SPI2_TX		21
> +#define DMA_SPI3_RX		22
> +#define DMA_SPI3_TX		23
> +#define DMA_I2C0_RX		24
> +#define DMA_I2C0_TX		25
> +#define DMA_I2C1_RX		26
> +#define DMA_I2C1_TX		27
> +#define DMA_I2C2_RX		28
> +#define DMA_I2C2_TX		29
> +#define DMA_I2C3_RX		30
> +#define DMA_I2C3_TX		31
> +#define DMA_I2C4_RX		32
> +#define DMA_I2C4_TX		33
> +#define DMA_TDM0_RX		34
> +#define DMA_TDM0_TX		35
> +#define DMA_TDM1_RX		36
> +#define DMA_AUDSRC		37
> +#define DMA_SPI_NAND		38
> +#define DMA_SPI_NOR		39
> +#define DMA_UART4_RX		40
> +#define DMA_UART4_TX		41
> +#define DMA_SPI_NOR1		42
> +
> +#define DMA_CPU_A53		0
> +#define DMA_CPU_C906_0		1
> +#define DMA_CPU_C906_1		2
> +
> +
> +#endif // __DT_BINDINGS_DMA_CV1800_H__
> --
> 2.44.0
> 

