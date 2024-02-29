Return-Path: <dmaengine+bounces-1195-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id F195786CE79
	for <lists+dmaengine@lfdr.de>; Thu, 29 Feb 2024 17:14:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 57B46B23138
	for <lists+dmaengine@lfdr.de>; Thu, 29 Feb 2024 16:14:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0931D158D74;
	Thu, 29 Feb 2024 15:54:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="UTfBxvkf"
X-Original-To: dmaengine@vger.kernel.org
Received: from EUR02-DB5-obe.outbound.protection.outlook.com (mail-db5eur02on2072.outbound.protection.outlook.com [40.107.249.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6D4314E2D4;
	Thu, 29 Feb 2024 15:54:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.249.72
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709222061; cv=fail; b=DSJDBiMnO7Hlf/++blIroMtoim2E9I4d7ak722Mz4rXiBy20WNk7t16iP1N6zOvZmSKin3dTm7KoriNDK86HGXgy4/eYThH1cBs+tQn9WhNdCOpZXp75yzYlvjoFL1Uqm2tI/hqO6EatdY3TP1RJsFpf8ddeqyk+RjwM5rgUwjk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709222061; c=relaxed/simple;
	bh=LxWSzkPGTnTlSsh06JFG+PhijJ/YgJNec7AuOB/vArs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=g6ZJOWDrw1TzjkDj0aDCXzkHw5K9aCFbwlLRou/3uIDh4zJqo3vAZwNAZUIlhB5eVNbXU6/lS0u9p1H6So/zR8mIaiyexE625UIepjtAlqws55V5Y8xnRAPGDyeHWbPtyH4/M64wIu/NANAHSAMg7SNRlmDH6pI6/TaojCAvFWA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=UTfBxvkf; arc=fail smtp.client-ip=40.107.249.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=azr1lJHLC2iAEekMLBZa4rBJwxLBonTGq6b4excuJYaZJnycQMaL425WvNtaRB4anwHaKa163/736PrvNde8C+uSIhDl1nGralklmKkG4uda+fviuoHdQ1RhOFLru0DWT5uGdnSLG34rEXsc5OrKBk3281cD965w+Ip746cul51QRxPQdk0CWm5DVF0GjIf7KYDLvl6HNEu8z5X9C5G6o5KBbR1oVs6bCPM0zLV48/7BcY0AcCuJRYrqcTctCywdd3Lj95MYYG2ahezj+QGqrwBkB4V31NWkee42Yh6CqX4ntFvtrCyairlX1/+NKfhuRJanxJkND5w8m0ontvff2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZMBLfJlM7K+vVsdZD6g3zSQ0kXH8eJQ4rqvDqbfWji8=;
 b=jltjVE3iiARlaJNHkWeRwRjaWWSeChGPRR9PLu6PNegVaYnFMTikJsNbBLba77K7l2hP1RwDNmg2aoW73Qiz3ct/APYuNcG48O8ulUXh4VI9og6V6LGPAxRugELyEDVuk3q7vVSjS8H+znUExONTPIhve948X6Heif3ysXEtTUp7pr/67A9eAW/+QmrPwzEu1D+FYcfNQtIuFpUb+A0oMOULAaK7O99+D1UJYN8wJnxBDnnY/S0q5ysZvGyQW6FQtaYFbRnS0wJnijou0ogYZrg5njMupnfqOn5iWsdr80c+LRNJnZ4GNJzNuIUVq4QKCQF8HV5ctmVwek3M+4Vu7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZMBLfJlM7K+vVsdZD6g3zSQ0kXH8eJQ4rqvDqbfWji8=;
 b=UTfBxvkfy5Z/RYobPV06uHFWlUP5XtjAyvT8VC9ROQc9nunwIQUKt3G84m4Z480s8NQItae8hwHGMQzk1LLE8X4c+uJQ1OpUrqFe5HnKxQVO8w3bt/15UVNn+4pPbj+xWiVmTLdpRUPjpWrmeGI/jdxa8gShiHZw4FuKWPTab54=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by PAXPR04MB9641.eurprd04.prod.outlook.com (2603:10a6:102:23f::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.41; Thu, 29 Feb
 2024 15:54:16 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9af4:87e:d74:94aa]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9af4:87e:d74:94aa%7]) with mapi id 15.20.7316.035; Thu, 29 Feb 2024
 15:54:16 +0000
Date: Thu, 29 Feb 2024 10:54:08 -0500
From: Frank Li <Frank.li@nxp.com>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Vinod Koul <vkoul@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>, Peng Fan <peng.fan@nxp.com>,
	imx@lists.linux.dev, dmaengine@vger.kernel.org,
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
	Joy Zou <joy.zou@nxp.com>
Subject: Re: [PATCH 4/5] dt-bindings: fsl-dma: fsl-edma: add fsl,imx8ulp-edma
 compatible string
Message-ID: <ZeCooFQtOK9MuuJn@lizhi-Precision-Tower-5810>
References: <20240227-8ulp_edma-v1-0-7fcfe1e265c2@nxp.com>
 <20240227-8ulp_edma-v1-4-7fcfe1e265c2@nxp.com>
 <bb3b61b6-4f39-4123-be50-0e2c8f07eb99@linaro.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bb3b61b6-4f39-4123-be50-0e2c8f07eb99@linaro.org>
X-ClientProxiedBy: BYAPR21CA0010.namprd21.prod.outlook.com
 (2603:10b6:a03:114::20) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|PAXPR04MB9641:EE_
X-MS-Office365-Filtering-Correlation-Id: 02ab7109-ebe9-4077-80d2-08dc393eaec9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	6mtGTfSEELKfkUGkur/ElI5t3jCCed149yj2z3N8Lxh0YxgRhxGTzxV/lgjpie/ktP/Me8OYsXhyGArBk6NVFCoySPkmn0o5iD0pOKmLj0qJPCYlTlxPAb99PhfG892T5D2/HkJEK8A9rkOL+37qcFhQ72qjQpCWM6XQb7PBrdNtWayQg2isq3iM0ib6F6VeXW2RcgGcEKee8RVT+ztX9LwJv/8QfcCBajqkj6pMJF4vcmMhUm65Hnp2A863qoi+ELozRZHI/vBRjGvnJM2Hfo5ouG/l8oNYOFi9tfl2SZiSEHAsq5X1hxQ64TH4NRTxrgzRF7i+zv8YRX1Ak73osFd5j2zV/otf3Y3Nd/eDRNjSLVNA1Cy+VR5JJfJLzO0EZFGO8VBM1k1OEgjrRgVyNj8YUSTb2cjQxehovzbUIt86BTCx0sZQUnrcHwolY2OaXlzTiqpXQP4g28Dv1bDVwX3LL8FOp99QZV+DWACMPRrQ7Rsb+qpiXw+NnNvsCrrvDp5NPLjOhLiAz8qmjCVkZ+BRE7gJPaUIMmfJy3fCZB4u51OOOk+YTHXrpbTU4EhUdlK5zSh6UTowkDetuWEuRKmCdqQ8GEmUAlQbVN1yLzNT0x6zgmcO9ln4Gee8Qq1Mgc4PAXU4nQ6HKY2biSnwg7jP8dVrnEAJZ7fRUKVozqIcCGkN2gyZ2ermJwhGyXrDIt5s579HpMOiQ+V/676KAQ==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?31TNdK0YK49uEw+h6vnbw0LOpn6G+BeYl3L5a36Hhv5S5oEPc5tL63srC2/3?=
 =?us-ascii?Q?TTcP1YNhtlEIbeihoHVnYTYzDLfvJpQ+dHawJ+kqf+CnLECuZDjOUBIhLnyl?=
 =?us-ascii?Q?l5UmwwcXAbbLkypHeLm5B0vr4wVLQ9QcMASUoJ+IzDn9YN1IvMB5+PDtdGk9?=
 =?us-ascii?Q?C8zQL2tKfCpdg7U3dYuGKMlCm5xkDTAyN3VlRzVRrTDls0Rg+Vgh/WlQc7oJ?=
 =?us-ascii?Q?YNV7PGRZfU57RnDP+ilMAaJODTFKl768+oGyyk5h71qHPvhv71lJJmyj2gew?=
 =?us-ascii?Q?+DjTa9nIaK60/OjgXxL3uoO7THXOuPhfBjn3TV1DSNiasAXveiLfgov4lKWg?=
 =?us-ascii?Q?XHUidw6+sKY+l0xudJgo9oZHc4kF6jHKMKkaJq0WoVa7d4g2ILgzTfnb3PY6?=
 =?us-ascii?Q?B/7ZWOhqCE3kVMiHo+w3YDg81Nqm1bFRVdzgPKJhZRw03mhyAS4p9338QMSZ?=
 =?us-ascii?Q?mmMZ93X1fBLe3T3BKeN9ksf/vZ6zYFyROEIyNXaju0xCw56lcOl/iIrsIoj6?=
 =?us-ascii?Q?8nZjTSycZwQn6np4CaRPmQfA38QesU8ml1EkdjGtLYKo8K/5RRM2GNAC4v23?=
 =?us-ascii?Q?ep7CW/2Db+NsqextYi5+pJF70H1TntwlYaMW+IJmEsIDgayzBaWsDdh4Y/K+?=
 =?us-ascii?Q?yTiwnHAqRqNSrR/i/Y+j2Cb4ksyquD0c1WqPT1xHDgLOXe9Mn+VcJB0Fm2iX?=
 =?us-ascii?Q?jqL2ST33gGv4CTLaTRwsnxz22tAB+dy+YDJUwsKTX34qY0k222DYMbRYBdyo?=
 =?us-ascii?Q?A/C91Nyk/0255CmMLBu54y72drgcdt2omVBWcktoL8WZwBceo8bX+ya8CEPg?=
 =?us-ascii?Q?MZ17sS3hFFHJvEFc7wmq5j0S9UWXygQHDEYO2kZYnzk/POHI02gImDxH5z+5?=
 =?us-ascii?Q?Muy67iY2pBGGiCOoCfrMNZTt1LEJqRVmdB0UozOMYcXJwJrtx3Y9nrDwsQMk?=
 =?us-ascii?Q?nLywM7bEtKgjJ3Ja4vsWez4OBUy0hsFXtLKxj4phug+9acLrSq1iUQoX6M7k?=
 =?us-ascii?Q?v2G34jPbmq/zVpHGPfr5n8LK7xRpSfVRbKWji4FW93vIaIIKIBw6MdpMAEuJ?=
 =?us-ascii?Q?EPVJmhpbSSNnb5EtCHpG/vaaKwYX984KGfZ9WTStPBKzZ2rBV1CWMhtjbqKI?=
 =?us-ascii?Q?zfgT83hvHk/Eux07SJauDoWk5z6D52tI/+kxsUwmGUzfAbZ8BJCttsuaDCup?=
 =?us-ascii?Q?1FlJBWAeA25SEDT+lpp4kxH8WmrDbvybezI1vR3oG0otI/ObiccpfzPKXrsI?=
 =?us-ascii?Q?mCHm6JFIcT/NphskGJLDL7JEERv55DKUMiN81jCxyqZgYKyoeMeux8RZCbXz?=
 =?us-ascii?Q?yPJAKNUnG/9+pNYH1b4J4jDZwc476zR6J29TFYOUYgOCySjnqqaiqvKKCaWS?=
 =?us-ascii?Q?woj2Mxo3tf6QqVUaJ/sj68T4Lj9esZi237Q8v3ue8CrnmQaCre300QGaogVr?=
 =?us-ascii?Q?9SYincF3sf7KvD4G3rp8zSegv3nLTHbCm6WRlKonRu7juaWWeXAh4hbDUyh1?=
 =?us-ascii?Q?T69Vu2RsCRndIGbcunJ0C7IhIN3DiBghsusIbj45aKoRKpKokCrP+pXWs35x?=
 =?us-ascii?Q?cYMDhP0HRZOgaVmBGi6zx1WdcHJoLGZUd5vxtyGx?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 02ab7109-ebe9-4077-80d2-08dc393eaec9
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Feb 2024 15:54:16.4495
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2g/Z6KKlTZP4FEo2mJLdnjlz2Jyvx7hfWN6DkNPbHWzkG8wMdsAay2yaptpf0VgxecMNQVOO5hbwwcc0DQELBQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB9641

On Thu, Feb 29, 2024 at 10:49:43AM +0100, Krzysztof Kozlowski wrote:
> On 27/02/2024 18:21, Frank Li wrote:
> >  
> > +  - if:
> > +      properties:
> > +        compatible:
> > +          contains:
> > +            const: fsl,imx8ulp-edma
> > +    then:
> > +      properties:
> > +        clock:
> > +          maxItems: 33
> > +        clock-names:
> > +          items:
> > +            - const: dma
> > +            - pattern: "^CH[0-31]-clk$"
> > +        interrupt-names: false
> > +        interrupts:
> > +          maxItems: 32
> > +        "#dma-cells":
> > +          const: 3
> 
> Why suddenly fsl,vf610-edma can have from 2 to 33 clocks? Constrain
> properly the variants.

Suppose you talk about 'fsl,imx8ulp-edma' instead 'fsl,vf610-edma'.

imx8ulp each channel have one clk, there are 32 channel. 1 channel for core
controller. So max became 32.

I can add above information in commit message.

> 
> Best regards,
> Krzysztof
> 

