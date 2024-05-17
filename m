Return-Path: <dmaengine+bounces-2068-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C854D8C8D20
	for <lists+dmaengine@lfdr.de>; Fri, 17 May 2024 21:56:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 75B5E289056
	for <lists+dmaengine@lfdr.de>; Fri, 17 May 2024 19:56:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 410A414198A;
	Fri, 17 May 2024 19:56:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="UYp6DGC3"
X-Original-To: dmaengine@vger.kernel.org
Received: from EUR02-DB5-obe.outbound.protection.outlook.com (mail-db5eur02on2059.outbound.protection.outlook.com [40.107.249.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11EE71411EB;
	Fri, 17 May 2024 19:56:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.249.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715975785; cv=fail; b=moKWMQbm45n9DprIWQBgpFPstxAZzOwYA0KondcyhPpwrEcOFkUh5h+P5XNxNVDM804qHui5kgyHVFtPyBMFFVErumSmSzlv9RXX1IjDV9G1pzeDIuGQ+lxiGaedrQh07GESDiHfwlWNed8L9+gj8Ga/tQ0M5wJ+kAvB3lA46Yo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715975785; c=relaxed/simple;
	bh=4USOs6e5rgVAq11WG8zQFlVL1yuIHyijER7SxVGeo3o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=HvivwwJREjAbhk8kXX2wRTqt6ZjUMrLSlreiz78TgGX8/5yDyso+inDM6utJHSwOEUm7IN+opcwzQhPGnbjQvZCpMr1EzpjnXhVBXFLNHfyu65N1vyOVUtff6Pi9iyowkMw4pRhcuuimN/uxQmX8hmCVuVpzyHM+j+5NmUuxPMI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=fail (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=UYp6DGC3 reason="signature verification failed"; arc=fail smtp.client-ip=40.107.249.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UB7COkuo4vLSUcFgSukd8EczvwqI67qxxlv8g8SO8bj+Ql3y+nuIoFYvcybN0FbvUQtfAOUgIboEts8qaZehemuFZNdk/v22AZmt2Z1ipE2kMTPgfs+WClTQpydaNKfJaXRAJ9veiuUoPLlDuu1GoUkYO85mWGWid/vCGz9W2mGGVKZ2bHk7DaH96M+wYPVpUhiixIxjEQvH4SmsaYBX1pBmWwTfwWgsnDpwZCopoHxqbvQMuQGXzNoNc+qbRW5BmRZUWLM6mm3vaD15pbrdg8n8b0RxaqhItNb/lHn7NAHk2rPFMq/jIK//4JFlGpmWmzjXQKKCSARVmQUDYIIi8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fiDjjvcG95XjBZfmZy+xf66hKJX44kDLdGGsbO7wwyQ=;
 b=YsJPmsUJnn86J53e1RaWhXqb5AqyZxWb3kACXrqm/a8Pufi+yQLkTdtgstiNnA168xiO6AfE44Iu2AkLiU4NqxwgGtV7FXqRpPTCxPsLKZ8wKtuLVzyFY3yNUZt04kOqk7Rd1TXGal6FY4H1XiOTmle11H4z7n9vU/H7xw8wBr9qB2D/GTprsuhqRdzkpQmx/bdAoyIOFrbfEYfdZNXbzP8TN2IqhrVNTmQK7f1Uc8TvJyEU2ZVSB1Um636pcOsi/ETaMJdZxjD4yLpolvy1KzFivztX4/uHnAkuq9LhU4ObtcdlKN52i1BMydlE9+3dJlE2f7/2CNjncWI4vMqn+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fiDjjvcG95XjBZfmZy+xf66hKJX44kDLdGGsbO7wwyQ=;
 b=UYp6DGC3NhsQanMXVyRwDLsFm9g6RCQfAARzlhHcx0tZFdeoXQaChPqsdZRXAXP2RsPGnLDmshmjLChajm+ri6o77JLVZzbVg7tnsl8hoS8xykK+cBFDmGL9ca2FZV6LQCaNSlOZaKP5Cgzc4en/MoaMhUcJWdEOr02eUpFKwh4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by PAXPR04MB8336.eurprd04.prod.outlook.com (2603:10a6:102:1c5::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.28; Fri, 17 May
 2024 19:56:20 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::1e67:dfc9:d0c1:fe58]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::1e67:dfc9:d0c1:fe58%7]) with mapi id 15.20.7587.026; Fri, 17 May 2024
 19:56:20 +0000
Date: Fri, 17 May 2024 15:56:13 -0400
From: Frank Li <Frank.li@nxp.com>
To: Miquel Raynal <miquel.raynal@bootlin.com>
Cc: Richard Weinberger <richard@nod.at>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Han Xu <han.xu@nxp.com>,
	Vinod Koul <vkoul@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>, Marek Vasut <marex@denx.de>,
	linux-mtd@lists.infradead.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org,
	imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 3/5] mtd: rawnand: gpmi: add iMX8QXP support.
Message-ID: <Zke2XTKqgKR4sEoY@lizhi-Precision-Tower-5810>
References: <20240517-gpmi_nand-v1-0-73bb8d2cd441@nxp.com>
 <20240517-gpmi_nand-v1-3-73bb8d2cd441@nxp.com>
 <20240517203904.2879419a@xps-13>
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240517203904.2879419a@xps-13>
X-ClientProxiedBy: SA9P221CA0021.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:806:25::26) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|PAXPR04MB8336:EE_
X-MS-Office365-Filtering-Correlation-Id: 1349dfe4-6ce8-4bf6-307c-08dc76ab6bc1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|1800799015|52116005|366007|7416005|376005|38350700005;
X-Microsoft-Antispam-Message-Info:
	=?iso-8859-1?Q?wae67r/p9xtZHWaALkFOOB6taBl5JHqNc7NiJEBzvaPuz1U8mexAy/uHHz?=
 =?iso-8859-1?Q?O+wUo9lRaVNY2bAI7A7TDp0tbsaUD+vel/83tv/f88MLLO6hx1VwYAZhnV?=
 =?iso-8859-1?Q?olzPtGLwgYafliRbpjFA7iENPySsYslS2kd3HG02gbX3/ONEv0lLKBMVd6?=
 =?iso-8859-1?Q?Ws0PadIrxxw/bwMR0ETtwcsNWSMOodAsHGByGX9jIi9VCerWtEho3GVk/X?=
 =?iso-8859-1?Q?/eW7wNO9u0fdSiwdreB6wDc9jlsk+GNQGWX8un7OhgE9EQsmoIieRkjjDS?=
 =?iso-8859-1?Q?Jhba/FBD2JUSGlBbfQK1Hp5aEhMVK+n6OEooiuWbjKeHBbxRTp2ZaoaLid?=
 =?iso-8859-1?Q?t6U13GVynCXrRmtxtqYzQsbIevpYUesyqEkQN98GNA/K8MKfyY9DO3fS5G?=
 =?iso-8859-1?Q?w/Ny0Qc+IAAxZB4p1IxXtNsC2yWT8TNXegsDoX6mx+pIcCCu3b6JASUmm2?=
 =?iso-8859-1?Q?IxuzeBkyiwbI9voyITBWQgnJr5gVBFMsmCQS4wPec7XNjf3tmhSK/h/chd?=
 =?iso-8859-1?Q?TbVT5je9vIVWndc0HLumRx5TA984Fu0uvjy44YFuUmNoZ4lpkYqFK538QH?=
 =?iso-8859-1?Q?8FpKV9HFjTbwhTAaDDVqJ0sGycAc79deQzDb/QHkn+8NhYL0GRLKCILBkB?=
 =?iso-8859-1?Q?Ty8Bk8b/jvFIUIA76SM5AiuUoCLYYVapeRRZCzI5njjpqA2YlzUe7laeen?=
 =?iso-8859-1?Q?e70/g1KIjsPYsG5O782Krzp2eZCWpIQDKkgHyjzjYXl9hd2OmLkm2BpRwA?=
 =?iso-8859-1?Q?Y+h/Qk792TFkephhZKukrkYYM37pAZq9r38Glmzyu8Qb6b+YMiTlWPgz6V?=
 =?iso-8859-1?Q?tLzwLyBr/8F7nnIuqbkB5pJ5Ttqeddglhn56q6qo5qtnj99jJKszTmK61N?=
 =?iso-8859-1?Q?q5LBfh0fGfhLApP23/F4wbF5LzvFbEDJRhuUpUY43kd78bfJtdYfZ1W66A?=
 =?iso-8859-1?Q?aWwpXLYDKO5zsKsEUawffAnG1m3Ha3VkSHBiSA7rEM6IJCQ0RmnPE6uIwy?=
 =?iso-8859-1?Q?fxh92j9YKGmUCSCqmI+yjqbFeZjdIza2VYNPG1lzMso77PA5dGEX9ChURm?=
 =?iso-8859-1?Q?A3XH2rWD06io4dWujCz4ILr3aJWF8beKGj3pPmlgT9pSttg7gRujC4hGUJ?=
 =?iso-8859-1?Q?S7SX3DhdXKQv+xUI6Hk5Qc/iKHyogxTXUq6VSI4gW/JZMUzDRLXsfwzh9i?=
 =?iso-8859-1?Q?XwPmWaS+goW7bJbwgYsV0FfXoCetx78wbXTtOPQtqtWq+BmxD9chLzaRhE?=
 =?iso-8859-1?Q?mNyGKFM9UqoK6gnczqBDk3bhbtLBHuyZZSOsNUd7w4QtoWua7bisqL+ClN?=
 =?iso-8859-1?Q?7phrkBXmO1r80UX9nh8bKTSJ4iZk/mLoDEYcU3imD9A7NeQIi6dfP9NVUo?=
 =?iso-8859-1?Q?6BtOynMNyx?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(52116005)(366007)(7416005)(376005)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?iso-8859-1?Q?7gKvXYJWm9QApjTBqtxTWObwakUT3GDh+eaj7T3WjZP31jwK/lVPam61kO?=
 =?iso-8859-1?Q?fYD4HhDBZS6Cz2Fmc4zM0r8iCAN28n1aTP8YiT+XulGAxiz9EQjJI1EiaA?=
 =?iso-8859-1?Q?sLtznnQ4sFzmAQI6VW87Q3hUE4W3O70o3cJ4YssdU75DhexryOduqTrugl?=
 =?iso-8859-1?Q?cM5r3Cfjoen0u1jKCT77M0kTlw9GzAg1n/UR7CMIqxzfbIr6osA3SQ8Yqd?=
 =?iso-8859-1?Q?KVotxAIlRxjdgJf0crNCUZPr931NFIVzGVSg3VTsVpiU4VM9MMhRkJE/oU?=
 =?iso-8859-1?Q?1n5fseAbQrvC3hFAk3vB0VzhsD5jqu+hVbYnuZ6UpTYZLqdVY7HHSJOQut?=
 =?iso-8859-1?Q?e87mdWTCB1J+m7JJcmumGiszbWTaVjLOwSgmDAXNFoIkdMqeWFjSVRu7/J?=
 =?iso-8859-1?Q?NMtJeSeCY58lNUjVraTEumNwq69B4OEDs235NtwILy/ng6JlXojfn+tJbf?=
 =?iso-8859-1?Q?F9WNt9H0DrkApXL5wCcBVOiNFQcpy1v+2h9C69lGkeW3x84Pf3kCfTlaIl?=
 =?iso-8859-1?Q?xCJiXYvcYRuF0J2X/jcKMxfNIptVBd0JLyyU4VJ8Tsi29EK6gGbTRTqQtP?=
 =?iso-8859-1?Q?6eoYzdWC+uHy8Ou1TZHzsjLTfwASW4Tu5Y+7IFaR5NO7Tt2d9P75HksxaE?=
 =?iso-8859-1?Q?j7cfNqsjSQkZxQeodt5llC/MdpE7NmDhAx8eTMxPDVJeS5SzaRF8p3O8st?=
 =?iso-8859-1?Q?PcfH4Q8ESoXnjcMHLZKqd0kDdVACYh1o7IJxajitGxxc0kYsi6+dGWlEJL?=
 =?iso-8859-1?Q?jtI7LHY23KOO87MvWJIicwT+bvc4g/QB5LzThA12q4n4/CmAFOqD7hVPRm?=
 =?iso-8859-1?Q?OieX1kWi/OoQjxRCAxOwiG2CBkblhppW4s/n4DVsyDqmhWJsNj1hWNWadc?=
 =?iso-8859-1?Q?flRTl4wZ9R6C/Xm2/PcMH5yCl9Wk2VjAXabAWSVVFhZ5M6y7zr7PyTspO2?=
 =?iso-8859-1?Q?dVatBLmEtpnMKQ8wIAK4UU5/u10ACnKKasnP3lrxyDTELJ+4NnHP4myQnp?=
 =?iso-8859-1?Q?xQGnDtOEUg1BGkQVgglwcO8qmFvSz41Tbmx7Tx1zX1SpzOJ3N7Z/bBea5g?=
 =?iso-8859-1?Q?7JmKSZJ97tG2BUajrEPT8GhdyDgBe/VWebOAlA7ccx64je4xdoqwmLSkQg?=
 =?iso-8859-1?Q?zUSCkwI7fjv/w1j+5mDXPFFF1pHv5IyqDpWFrhw+FOj6Q7wBwHP3TeIXgW?=
 =?iso-8859-1?Q?jVVjMVDuY08B8nu8c63L4Owf0R1yAnbwxcvTEDnkt79F0mMHa4DXcjTMBy?=
 =?iso-8859-1?Q?eo1yloMTs/u618bmLgk1K2qHJwfgd1+I9TtDCAXTL82I0VhJnGdOnKpR5d?=
 =?iso-8859-1?Q?HRXHuSeDQVku7UX9Rvv5t74NLuzktlu8JCZMKgIrZIOJXcX+OKtB0Biu72?=
 =?iso-8859-1?Q?9BJR9kyYdBAOFbLLImXL88ibXi4+bD74MRam/l2sKPcWZtDxnnoOzWFIH8?=
 =?iso-8859-1?Q?3EoVP8OfR+x/7nCrZcmjD8YFTY7FzX/x/+Zo8wfT8MYBJC8csq5Zp0/0sF?=
 =?iso-8859-1?Q?AG3YPaOIfBzvzKVh0JXUVGcaHcU3Q6C7rlRzV1cumRi0myOUx9OqPjQQGM?=
 =?iso-8859-1?Q?CTUGd9MPhHu7uwaPnl85fj0ovM/t3BVFlbpotgKCGqfZ1kW5stGrvcx+bM?=
 =?iso-8859-1?Q?iXjyVh+skSzwXfPmi4lFKCwLM806oOpub9?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1349dfe4-6ce8-4bf6-307c-08dc76ab6bc1
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 May 2024 19:56:20.1538
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JlVD8VdnJnPnMoHIo6qAhw+jOpjyCbyED5g9/ABhH9BNygc/RC4+8n9pA9m4ZzVr1BEPwpIuhfknLpFXS6U69Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8336

On Fri, May 17, 2024 at 08:39:04PM +0200, Miquel Raynal wrote:
> Hi Frank,
> 
> Frank.Li@nxp.com wrote on Fri, 17 May 2024 14:09:50 -0400:
> 
> > From: Han Xu <han.xu@nxp.com>
> > 
> > Add "fsl,imx8qxp-gpmi-nand" compatible string. iMX8QXP gpmi nand is similar
> > with iMX7D. But it using 4 clock: "gpmi_io", "gpmi_apb", "gpmi_bch" and
> 
>   to?             is         clocks
> 
> > "gpmi_bch_apb".
> > 
> > Signed-off-by: Han Xu <han.xu@nxp.com>
> > Signed-off-by: Frank Li <Frank.Li@nxp.com>
> > ---
> >  drivers/mtd/nand/raw/gpmi-nand/gpmi-nand.c | 20 +++++++++++++++++---
> >  drivers/mtd/nand/raw/gpmi-nand/gpmi-nand.h |  4 ++++
> >  2 files changed, 21 insertions(+), 3 deletions(-)
> > 
> > diff --git a/drivers/mtd/nand/raw/gpmi-nand/gpmi-nand.c b/drivers/mtd/nand/raw/gpmi-nand/gpmi-nand.c
> > index e71ad2fcec232..f90c5207bacb6 100644
> > --- a/drivers/mtd/nand/raw/gpmi-nand/gpmi-nand.c
> > +++ b/drivers/mtd/nand/raw/gpmi-nand/gpmi-nand.c
> > @@ -983,7 +983,8 @@ static int gpmi_setup_interface(struct nand_chip *chip, int chipnr,
> >  		return PTR_ERR(sdr);
> >  
> >  	/* Only MX28/MX6 GPMI controller can reach EDO timings */
> > -	if (sdr->tRC_min <= 25000 && !GPMI_IS_MX28(this) && !GPMI_IS_MX6(this))
> > +	if (sdr->tRC_min <= 25000 && !GPMI_IS_MX28(this) &&
> > +	    !(GPMI_IS_MX6(this) || GPMI_IS_MX8(this)))
> 
> Feels completely redundant, no? If it's not an imx6 nor an imx28, it
> already returns -ENOTSUPP.

if this is mx8

	sdr->tRC_min <= 25000:   true
        !GPMI_IS_MX28(this):     true
        !GPMI_IS_MX6(this):      true

        so whole statement is true

after change
       sdr->tRC_min <= 25000:   true                                      
       !GPMI_IS_MX28(this):     true                                      
       !(GPMI_IS_MX6(this) || GPMI_IS_MX8(this)): false
        (GPMI_IS_MX6(this) || GPMI_IS_MX8(this)): true
            GPMI_IS_MX6(this):   false
            GPMI_IS_MX8(this):   true

so whole statement is false. Maybe use 

sdr->tRC_min <= 25000 && !GPMI_IS_MX28(this) && !(GPMI_IS_MX6(this) &&
!(GPMI_IS_MX8(this))

looks better.

Or use a drvflag. 
     if (sdr->tRC_min <= 25000 && (!this->drvflag->support_tRC_min))

Frank

> 
> >  		return -ENOTSUPP;
> 
> 
> Fine otherwise.
> 
> Thanks,
> Miquèl

