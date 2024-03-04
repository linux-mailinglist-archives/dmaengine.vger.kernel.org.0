Return-Path: <dmaengine+bounces-1232-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 537B186F8E1
	for <lists+dmaengine@lfdr.de>; Mon,  4 Mar 2024 04:26:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 89DECB20BCC
	for <lists+dmaengine@lfdr.de>; Mon,  4 Mar 2024 03:26:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A47B4409;
	Mon,  4 Mar 2024 03:26:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="ZpRF8EO6"
X-Original-To: dmaengine@vger.kernel.org
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2042.outbound.protection.outlook.com [40.107.20.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2D40211C;
	Mon,  4 Mar 2024 03:26:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709522781; cv=fail; b=R2QXIWhBtJ7oPNoh+vTccYYUK8tGZ9th7uQAGsDwqlbyyMmqECxXXEaSGTTd/7Cu6jQ8N7TVg7kqOAI2EVEidMrE5fzG2nTo0I2SM79QAxT4eL7iiEbdVhEhtDNHGNMps7vLvUZoe7k44IU5pI4dfpOucrscy1k/t24SfbBOQaA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709522781; c=relaxed/simple;
	bh=+HSiERhQcpDP5lb1soqqaXrOY7A21OC1DBChLZb4I+s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=anciTm7TEppSykVqcDwg+XubI8ygHa6gffo9GY2hAtEmJlIQDJElF5ZyCAQzHm+IwJEMW9xpZB6ZqZ6OswaSRPD2nwIeG4LFhNU1nZPltQuiJfHfNOt+TBCbsL+LPiWMwsenSIiyOB7cunL6+WenAdYTXpOO9gCA5EBCH81SlyU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=ZpRF8EO6; arc=fail smtp.client-ip=40.107.20.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=c7BNQgWronqtZSevmjMYoCZZIlENFDPf9+Wt8a1w3URafHKkhNGYn9fHvkyQw2yXYqUGV4wmyx5PjrSIlucNVhwqHry+s6F6JeqlWgVo4S4UIhQo80J8TBdF6vR/JYFSmwrPxkAabhAZITEtgChpwptpMd0STPVogf7jnZPGFT9LoOgrBNaLaLnQHdKlHZPGC3Tj6frpt4/YHN++yfhNepG92OwIz5/oeSuHt6S5YbUsjf//36FPlFk/+gVXVIWI+q2XfZhm5TIMnfJOH2YQ/Hw522jRph7uQFk2finXLx195/YNFFIwuiZY0jK1qSPFwhCXgKWGvR+a0OQ++ePBIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=j0cSjJaNOO0sNliBrz8g7oG99Uiml8xz7zGUVwGyVUU=;
 b=J6WRcpO9/yT9Y53XFyQCdVwLeTi85SdMjS+tTD65ZyJ+Eqj+q1LtG8LNIxMI7ecCyGKm3X8C/hxbTfNAdqTBinQbXZ+wf/xIUdSLiIm4GflK0x21taRkgeK90CamTg1odLk1HZkLn6Ga0zQeus7S+3VJSGAj122NYoD9RLQmhEqI+9EIy4QWaXNvPMdPr95GLsMpYSYk71lXDegELJd4OGlqW1hwBhq0T5HEaaSAXzFnVWpj9NTyloA+VrJ8SzoqPdSx19tKMfDKJf/vmf+tzn2ndlDZSvfJoARS2NT3e6zqfeW6DR4PJC9G+HrgvsmSmgp6lVQrJVEzDfaXueNsbw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=j0cSjJaNOO0sNliBrz8g7oG99Uiml8xz7zGUVwGyVUU=;
 b=ZpRF8EO6p2lpFKOb+yoBtbqZ08HHCsatZcFQVF45Fk+kWL6XHE8/JgoL8dDeBnxBUkdmvUoslNmLWquaUvJ/GwBm8yMR520+jg2ntr/ZiXoa98PHNv5K67aity6UjK8YRLQd/kgPiLm4V/YjwoFTKBKrzTRq0vrGfz3feQoUE0o=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by AM9PR04MB9016.eurprd04.prod.outlook.com (2603:10a6:20b:40a::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7339.32; Mon, 4 Mar
 2024 03:26:17 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::3168:91:27c6:edf6]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::3168:91:27c6:edf6%3]) with mapi id 15.20.7339.033; Mon, 4 Mar 2024
 03:26:17 +0000
Date: Sun, 3 Mar 2024 22:26:09 -0500
From: Frank Li <Frank.li@nxp.com>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: conor+dt@kernel.org, devicetree@vger.kernel.org,
	dmaengine@vger.kernel.org, imx@lists.linux.dev,
	krzysztof.kozlowski+dt@linaro.org, linux-kernel@vger.kernel.org,
	peng.fan@nxp.com, robh@kernel.org, vkoul@kernel.org
Subject: Re: [PATCH v2 2/2] dt-bindings: dma: fsl-edma: allow 'power-domains'
 property
Message-ID: <ZeU/UQVPj/q4kD3p@lizhi-Precision-Tower-5810>
References: <20240301214536.958869-1-Frank.Li@nxp.com>
 <20240301214536.958869-2-Frank.Li@nxp.com>
 <885501b5-0364-48bd-bc1d-3bc486d1b4c6@linaro.org>
 <ZeNI1nG1dmbwOqbb@lizhi-Precision-Tower-5810>
 <31e62acf-d605-4786-80a1-df52c8490913@linaro.org>
 <ZeNWXxzFBzNj0gM1@lizhi-Precision-Tower-5810>
 <e1d0aafe-e54f-4331-8505-135b9a8f9bff@linaro.org>
 <ZeNYG1IUfniWkhcp@lizhi-Precision-Tower-5810>
 <32d4a6c9-1cc3-4e9a-81a6-744a33bc6bee@linaro.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <32d4a6c9-1cc3-4e9a-81a6-744a33bc6bee@linaro.org>
X-ClientProxiedBy: BYAPR07CA0018.namprd07.prod.outlook.com
 (2603:10b6:a02:bc::31) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|AM9PR04MB9016:EE_
X-MS-Office365-Filtering-Correlation-Id: c2123262-e432-49f2-592e-08dc3bfada50
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	94NwxB8XRFoF1Srhww/p3tikVod9UkSdsMZr1doSYFbQOH1SAuf+VFgugeJDZ+xtGG9r7+zlrrYSxhIizBw5vA1ExdEH0RRj8X76ls2NEM/a99qCzagRbpQnMhZjLCjNsAGuwwqbTGdalT2gVfGdpIwcSsQGEn47Me5zldz+MJQS0SLpZzPdvtjQ6Io21+0+ZZQsOU0i5RuymcC+ckfL3UyS8VhtBUQtca76hJwoY8WvmKWYNWSMepXxFeaITMG5oeVFrxucCVc76/XOvGu1UnjlMOnMM6UOe/e6C0X+tXNltuYZ7WUbFHJbEHJRrUi45z3gUvpyZArHrd1BambfsRkep5BMIWphabHOBJFPxTeTkN1+qwxc6XgbS56BNGijXptf+Xl4v5RJoJDIHzZwyPs5bF15AHPii7wRPHDoACBh47ZYTnHqj/2jXnYmhr9vMUVFKYfPmG+R1uvOmnQl4eLqpT1getqF33r0LNSfyAybpwcVNBuMtIbEnXP1nBiapSOnX4aydn6FdlZbZy9Od4Ieu3ujnOfKfygPhX/omwOPI+MKtZ3cCstaG6wkMIdCm/fePY7LbRwP6zXYi+tMG2/MhFTSRr2y22r5rtK4heY8Hr6xmbHjqQy1ILC0csaLljwCfpNAkY3eUM3pSYm2ScWKdDtIO4F6hf2THABY0h3VCVm106kPFy/JN+K7pack3O8mGl21U+eAjq0s7aspHA==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?jozvtmnuzZjzeU/Em95iP8WRCs8ei86osltjfA6wlsm6NvQI+fl8Kwzk1GLZ?=
 =?us-ascii?Q?AutNtyhKN5MAIZ437J3740qIe/FU8J4xvzbeXt5qbs+pyAvEbXxc+mJqo+md?=
 =?us-ascii?Q?jQ9eA0KMCL8rE0s035pbJOQQGpRkoJzTL4Cndo33GA8uyuDDFYYLDq6Cf8HI?=
 =?us-ascii?Q?tBsIIPpEIBHidC5gxd4ZyZYkd3ypXA7yeUrb3usbvWK2Am52qHAeQiplh53W?=
 =?us-ascii?Q?kyIPtCmWcySae6aYQp47CrBk8i2oR5JySIOGbz4bXp5uAaaOyOqaOcK4iRXu?=
 =?us-ascii?Q?u2oaQ6rDNHMh4nWEPe8/ChiYZQc/VfoeUmuvY3pyIQ3UMugo8MzHungZyyg+?=
 =?us-ascii?Q?xG0u5YDmlvi3rnEtOyx9cGQO2+ShSl8/yNnCy5HOKKsuzAhiPFUnUCFoqVtu?=
 =?us-ascii?Q?jQck5APzy9Udx7jWYy6vhTbMo2qOov3lotfeDjHWg5WG8RvcxE9o/3yG6Thb?=
 =?us-ascii?Q?zu6N0dSgPOIMnJnwNAURCZsWlx3+LBjscDLXLqMfSdtZApevMEO8K6fGD6nx?=
 =?us-ascii?Q?j2skRB3H57ntHMwTYN/LZbt3mWfI9LAxzprElfLhGjIIZBxaA8qMjaqPWo6f?=
 =?us-ascii?Q?yuknlwE65jSLlxB3BQZHvGb3eaR4hmirANde/6/BbzwLSs/Joes4t7VqWuEm?=
 =?us-ascii?Q?dgCp082B+ZbwpX8DaCXL8L4kw1hM+9lC+NLzvdI23IXIIVYvUWwaNdVh7QJW?=
 =?us-ascii?Q?Y4P9a/lO9f39A010e6CZ3s5X6NOmbDQiCeg+r4UvSLft/u7hLsE2BoKhE+nx?=
 =?us-ascii?Q?IlY9LwZ3HgWflo1yh7jImLsVK82bKOchDUHew4rENKEqLtTecZZZ/Nn+PL9X?=
 =?us-ascii?Q?6a39VQ4wdsRkNmnKSz9RwTgEQjNCewE9y33US42s+Ivx364oFTVv9tNXwTcz?=
 =?us-ascii?Q?B8Au7KpBsbyF7nm2WtSAHcG16CX00w1z4CyAlBkv5ytAeNw9b259u7wzFzC/?=
 =?us-ascii?Q?OybIGbUYN2OXvbz3PXuqWlLFI67fdOUyKLxjp6aIwYsTthua+67IStg8LnBy?=
 =?us-ascii?Q?mlMCbbvh81deejepYzr3r6YihDj68OMhT0Gd4mvIzFhjvMs5RXC9gXscglbi?=
 =?us-ascii?Q?sIHp6LUOccAL8tHVMsoNwIaoA0ndCP1BhCgiDA9cVa55CDOoR6AiSs8mQE8f?=
 =?us-ascii?Q?l9acB4p4g6jL6WqI7YZPk7nFp0gwCgTMLWBUj8UUTLpEeNO7c/aWaAHGDNZs?=
 =?us-ascii?Q?BeC/yPWHmKktQfK+tdfUAgOlj9YIZo5FTNZsVpdEGtf9tMemVWlzyRahyJq1?=
 =?us-ascii?Q?mz+uiiqC5dQA5bsGCEGAZvIIvfviRE02HvuqGAFw2DpI4muABMpsaCoBfusL?=
 =?us-ascii?Q?9MNXzwaIL7q4dU9CTA9fe3ZYJyLBxQ/VYbGT0Pc9nr7biFtv/YluJzrt0JKn?=
 =?us-ascii?Q?kJpNM7Y2v6IWblarmCe6ZBdwzEKUvc3ZMga31e/lDZx6/q5irg7rgdRLOu+m?=
 =?us-ascii?Q?ipQ8JOnVS98l3nDQxVYWQtehSjex2G2ug0B6Prha/F4AiXhvhN7mqy9xcBlR?=
 =?us-ascii?Q?dgIsIj/gVNsq29oh9MzXZ7Dd3wHhzBqVV6BFpXOk/J9VXpv+sVPG3lmA2/2w?=
 =?us-ascii?Q?tAQ/o/huB28MS5HrjAE=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c2123262-e432-49f2-592e-08dc3bfada50
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Mar 2024 03:26:17.3957
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GX6OJb3JFNMyGQl897ebFnenJ6j+mnUDZ1fs1BZ3nuoe1bGYbJ8wyuiu/1dvKD7Re+JWgp5H9HE0JEdHqMmxYQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB9016

On Sun, Mar 03, 2024 at 08:55:10AM +0100, Krzysztof Kozlowski wrote:
> On 02/03/2024 17:47, Frank Li wrote:
> > On Sat, Mar 02, 2024 at 05:43:01PM +0100, Krzysztof Kozlowski wrote:
> >> On 02/03/2024 17:39, Frank Li wrote:
> >>> On Sat, Mar 02, 2024 at 05:20:42PM +0100, Krzysztof Kozlowski wrote:
> >>>> On 02/03/2024 16:42, Frank Li wrote:
> >>>>> On Sat, Mar 02, 2024 at 02:59:39PM +0100, Krzysztof Kozlowski wrote:
> >>>>>> On 01/03/2024 22:45, Frank Li wrote:
> >>>>>>> Allow 'power-domains' property because i.MX8DXL i.MX8QM and i.MX8QXP need
> >>>>>>> it.
> >>>>>>>
> >>>>>>> Fixed below DTB_CHECK warning:
> >>>>>>>   dma-controller@599f0000: Unevaluated properties are not allowed ('power-domains' was unexpected)
> >>>>>>>
> >>>>>>> Signed-off-by: Frank Li <Frank.Li@nxp.com>
> >>>>>>> ---
> >>>>>>>
> >>>>>>> Notes:
> >>>>>>>     Change from v1 to v2
> >>>>>>>     - using maxitem: 64. Each channel have one power domain. Max 64 dmachannel.
> >>>>>>>     - add power-domains to 'required' when compatible string is fsl,imx8qm-adma
> >>>>>>>     or fsl,imx8qm-edma
> >>>>>>>
> >>>>>>>  .../devicetree/bindings/dma/fsl,edma.yaml         | 15 +++++++++++++++
> >>>>>>>  1 file changed, 15 insertions(+)
> >>>>>>>
> >>>>>>> diff --git a/Documentation/devicetree/bindings/dma/fsl,edma.yaml b/Documentation/devicetree/bindings/dma/fsl,edma.yaml
> >>>>>>> index cf0aa8e6b9ec3..76c1716b8b95c 100644
> >>>>>>> --- a/Documentation/devicetree/bindings/dma/fsl,edma.yaml
> >>>>>>> +++ b/Documentation/devicetree/bindings/dma/fsl,edma.yaml
> >>>>>>> @@ -59,6 +59,10 @@ properties:
> >>>>>>>      minItems: 1
> >>>>>>>      maxItems: 2
> >>>>>>>  
> >>>>>>> +  power-domains:
> >>>>>>> +    minItems: 1
> >>>>>>> +    maxItems: 64
> >>>>>>
> >>>>>> Hm, this is odd. Blocks do not belong to almost infinite number of power
> >>>>>> domains.
> >>>>>
> >>>>> Sorry, what's your means? 'power-domains' belong to 'properties'. 
> >>>>> 'maxItems' belong to 'power-domains'.It is similar with 'clocks'. what's
> >>>>> wrong? 
> >>>>
> >>>> That one device belong to 64 power domains. That's just random code...
> >>>
> >>> Yes, each dma channel have one power domain. Total 64 dma channel. So
> >>> there are 64 power-domains.
> >>
> >> OK, then how about extending the example to be complete?
> > 
> > Let's add 8qxp example at next version.
> 
> You have already enough of examples there and your change here claims
> they user power domains, so why this cannot be added to existing examples?

Only imx8qxp/8qm need power-domains now. The example in yaml is vf610, 7ulp
and imx93. If add power-domains at existed example, it will mislead reader.

Frank
> 
> Best regards,
> Krzysztof
> 

