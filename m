Return-Path: <dmaengine+bounces-3294-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F3E05993276
	for <lists+dmaengine@lfdr.de>; Mon,  7 Oct 2024 18:06:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1BC6B1C22DC1
	for <lists+dmaengine@lfdr.de>; Mon,  7 Oct 2024 16:06:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 820631DA0EB;
	Mon,  7 Oct 2024 16:06:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="XOF9g/7m"
X-Original-To: dmaengine@vger.kernel.org
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2051.outbound.protection.outlook.com [40.107.20.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A52321D9673;
	Mon,  7 Oct 2024 16:06:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728317168; cv=fail; b=Xyu1d8l/D9Qgyde7r25JcPKAk6fRSOeXgPUlbtNhTrggVCb9DXRnNXDEikkcmLvGIssBWYaajuZ8Ezsqc/XBfbD16pPkVjxGFYcrWTegf3q+IzziU/4t0srHb21a59M921Tj5M1pRncX3LrqHYy42cuAlYSr2pSOCI1coOpekXI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728317168; c=relaxed/simple;
	bh=iQZZdXrNyHvDq2ZUHrbSMr4AZA0B5FGC2xdXg3/LLGs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=oSuS6dgtZZSfefH4Lx1A04xXbiAk1Ej761IwkqDu+wDCbN0JZOCIhYX9h0f4YiMMuolD78hTu6Jt/2DJkD8zxrKu3JMh1zlVqS9g/A8jekdl1AVUkxVcQy7M2nFqMa4t4Vz/rfLZdNLjeq+U6A6pVbeuOITk/SGzsUpe4vw3IL4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=XOF9g/7m; arc=fail smtp.client-ip=40.107.20.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cc/QIZcrAMmb+aozSNaUop3i7XqOzQulDMjywaUpcOxP1oOUE2N5cfexU/a+PGEN/5IRv/aucaAh8X0iZZpBPXYEfQNDc5kw+GnD+x/MZK52VK1hROInTF527ul+hrHt11ygWAoxbsQtAHsJHHSfGGyVmGFtGcVAYCDcs2k8v13YZ1T2AbeQYmWeoI6UBmZlF8wlfxwv7AMeCdGHXIsjHfxYLrz0YgTweO/j474KGhefLvmOcly3mMlgCIp4kobfrlGz9kI8cRgLWQebk2GWhWjnFvMHucmWzvK/XL3RW9SiLqqAbD2Uxu7LwclOaS2Eyt/n0mEhAEDmZA/aWxzFCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NKbZqsM83kLbhRxoNrd992tuVn/JpNrcCbpkYPNiVT4=;
 b=bfjyN+NZyluoOF4/RSNQ/LjjqEx+eLnYDuwxnc3FL1DVy6BN+mePP7+7Fqo9tLB1kEevY9cjcmqFAIEv2j/Xw2EVO49nP5a6Sk9jFIhVo6wWGgr0S+NEMYL8V30NnIKSpxZ9oVqH4lqF30ORKW+eScTvQ8o4u8Dh/ETIQvk0lPehCt4Cwh5iFDxcdO8/gL/49Q36sxdzBqhYasPfG7rsWTMq6bCftxrZuc4/4GVoCWLuRBWTc6gCD67MUN0scJjWSa/WtnKDTosatUulTEdtDNpC4rYPYgJtTmGzlE08AWDyBPk8cntlLRX203GzmJC7pni+Jtcb9N8eLH9Ph18hnA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NKbZqsM83kLbhRxoNrd992tuVn/JpNrcCbpkYPNiVT4=;
 b=XOF9g/7m0NoImVxzPi7EM6IhqUNv++3PDN7Ojghq6Hx1hhZdn4Ey0ZxgW6h+qe4aRAC1CyAhtUsh+aRDsOuT17/WnkLL9BD4f7KdKcfxBOcd6C4OkIABrM4kRW1RvAnf23l52KSThi1czI0lcKX+RqSC4jB34eibaWZ2wzTYWBXRPpsJkGgKosI7n5UsiDLyRz9cWIhhdswxGvJaUjsj/1eaFedisYfBOcaei0hmkbf5xCdl95tnkQOgy98p+P23QJEVv8C7D/7BqRyzPhS/RFYbbk8r/3zLpfW+qQwhNL+eJyqmNGBWs6Cqy8EM47YkaDFsBZ1PxaeOA3ESNSxYrA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by GV1PR04MB10275.eurprd04.prod.outlook.com (2603:10a6:150:1ad::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.22; Mon, 7 Oct
 2024 16:06:04 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%4]) with mapi id 15.20.8026.019; Mon, 7 Oct 2024
 16:06:03 +0000
Date: Mon, 7 Oct 2024 12:05:56 -0400
From: Frank Li <Frank.li@nxp.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Vinod Koul <vkoul@kernel.org>, Paul Cercueil <paul@crapouillou.net>,
	dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
	imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>
Subject: Re: [PATCH v1 4/4] dmaengine: Unify checks in dma_request_chan()
Message-ID: <ZwQG5II6xsOwKwxz@lizhi-Precision-Tower-5810>
References: <20241007150852.2183722-1-andriy.shevchenko@linux.intel.com>
 <20241007150852.2183722-5-andriy.shevchenko@linux.intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241007150852.2183722-5-andriy.shevchenko@linux.intel.com>
X-ClientProxiedBy: BY5PR16CA0005.namprd16.prod.outlook.com
 (2603:10b6:a03:1a0::18) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|GV1PR04MB10275:EE_
X-MS-Office365-Filtering-Correlation-Id: 878ae9ca-d65e-42d2-f19d-08dce6e9f1b7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|52116014|376014|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?mriXUw0P1CbW3qFpxewjdYemzulGc0xBCi0Crq0e4u/uJYmb0ncxLhaE7Wyn?=
 =?us-ascii?Q?7Zgw+m3U2NSQvFE12bw2YHwP7cictGHr40jIG7TZ699lLwo+OLsr3zuEv6gX?=
 =?us-ascii?Q?yj6fjKNV+tRv5XsvnNDS3+Tr7ELRbFSKeyko5uQK1DOjhFq0PKWvkusGNQRz?=
 =?us-ascii?Q?p0IXQ53Mglyz3J9O5ELq+6cpCC2WK2nqksP0lbp6D6G+dLaRKpDO1ASfFHh5?=
 =?us-ascii?Q?Qm3LaTW4BG570vxiT/lKgEyz/LC0VN7ek+aVixzSXFJCGvNIrvsXyJsc2g+K?=
 =?us-ascii?Q?8LO8pi1ZgJU94m3l1s5ZQoJafKgfrytfgzvUjM0Y8cqhkbxrtfZFrw0LA2MP?=
 =?us-ascii?Q?X7MGEt/gk5wxrDuMRdFSZYLPCn4slFSWMD4PT00YaEsdtLMmHNjaQp7pKPwV?=
 =?us-ascii?Q?3LfWiWmme7HzGmzfaOd0nYVbGXj5uzZF2Sg1THXUZ6ob88WG+NsZaQ8I7MmI?=
 =?us-ascii?Q?25JT7mIwR+GE4R1f/8HooqXCbzNDJdxkyfbvMLWWum2Iv4Hbd4V/mjSUDSsy?=
 =?us-ascii?Q?7UPHoPZIZKvbyfVd4WB13WxpH9JgMb4i1wu7ED0eq8bjBtgHtVOCZMY/KceI?=
 =?us-ascii?Q?iAJKiU3M99TeEfjPene+aele+Aiwe5NyESetUVepwtYlb789xm32pKuFtr6h?=
 =?us-ascii?Q?664HnZ68eN0KfSsO9o7/H4TfWxuTsXqi7WWwULt+2fdVzQhEADYqv9MTAndR?=
 =?us-ascii?Q?rHg11lPpdo24kJaisoAksejbxT5yipGyKYoRbz2Gmo0d8mQb7M1D3+F+8bNF?=
 =?us-ascii?Q?5fgN3SSp2TKy/AAYmeVkdn+Sx2IUF7riBoEZmOy4NVzth+Z+G5+jFSyKXas7?=
 =?us-ascii?Q?2ogQVtbG0JIKYZMSugU2CsQIbfWHJGQILjb6hqF5fyI9/UDHgPIqksxMFYx5?=
 =?us-ascii?Q?0S9vBCUmXy8CartI137kEDBl5LNwK4sqXBHrQNAzwpVnqe+CE3WtoWsd2d+d?=
 =?us-ascii?Q?Q37Ujnx347IpX735ZXpOLAHFw3XAPGfHEKgOUl9GyZrFBC3Qm+Xv8g3nCl/G?=
 =?us-ascii?Q?Go0H2s0KFuZ4FVQO6Mj4F1GzagLj4wbgH0GGh2xSaTJhdzu2WUCkB0qbyrWT?=
 =?us-ascii?Q?nKq7wZt0sF7/ujPPVUVRTLTx58VPVVvA80IhVB1s8OxWSnrJqVQ3AaT7Y/eK?=
 =?us-ascii?Q?n1aygJvJR+TyKTQuZS+0gsTZAC/sagGYjKcNydDctRRuY+G9vR9sFyzUqfOD?=
 =?us-ascii?Q?1H1AvBJWJKKHWkfL6z3pVMs3pFx7M29/3gIKywsBZ6jZDcO+Jjb4058IHmQA?=
 =?us-ascii?Q?hdn2W0pdPgEjulGoCDOPFdpttaA8odaWmx8+Aez4IwrAk6BbRsRJDnTZSnQt?=
 =?us-ascii?Q?WF5fzcsVHFS9yeUFBJPzN3fadIk/nK+Xxze3TNiSIPmoIA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(52116014)(376014)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?kty3EGL/hugDQewwr054OljfE8O7D/AjqJ7+wKaaTZb318OHNVKrmSJSrlG/?=
 =?us-ascii?Q?u1GMHnWJvb+01xyHXULdbYPVUwlCa82n7RuBurgW/Ruo8olE7tbnjpm5T+xi?=
 =?us-ascii?Q?cICD7nkOlYN1gcCHAbstPJxSOu58ewNh3Sy3x9USFKiPnbZzE9pZ0j+KPM//?=
 =?us-ascii?Q?bXPvhPLi96zClbosePgfd3DP4nbG9eMj0W+2yCk2jb18MaEMQRLeoDJ+Y2h2?=
 =?us-ascii?Q?Eq3IEplXjo46sOkcdSssDL13fmyNNfZwLV4bgjUQS4iLluh64bNdGxOalWO4?=
 =?us-ascii?Q?GpbBuzn8kGX0j8ONhYcgGdtDSYzpTNavobWum7PDYhtdV8sTqWsEd/Cf5UtE?=
 =?us-ascii?Q?lMv5PDfsjLLvB0VCvJsJcCAx6F8xI+gNNQytCxGRYe9gKP/9oVOILEdxe1FY?=
 =?us-ascii?Q?12cUaGGX0dmnL5m3yvtm8b3tra07hfwhrJM70nnCi0VX1iZG0SlsW9tk19DF?=
 =?us-ascii?Q?WORykUL+r18KVBlz4MRJ2vlMVjgAwgfmhLCEbkXg26QLrOeJzeepqgUdOt2l?=
 =?us-ascii?Q?vYMSP7Jpowl/2TIICDmPy5oDrSl5zsrEcByMwqeC0kMPz2oc3cql7YKrrbCL?=
 =?us-ascii?Q?SMSW5rxc78kdCLosrHtsYvEFjM+2JComX8rjI/fhKF98QFjGTLQZmR20ku3X?=
 =?us-ascii?Q?WKAYXp8wsavKJWC9cR1284mXH2qza0qKtAk6+N7TNNvhL1nryvWVDReF70o5?=
 =?us-ascii?Q?wd7o9Ayib6eABuxTMyB01ac5Rud6U4lur25cCEmWx9V/K8MGWmbJmfrjIbmd?=
 =?us-ascii?Q?JuK9K6yhMgTQgHMmor6O7OI8z1w9rcA9xp7PRlHZmQUjkZff7B6oxsr56T/8?=
 =?us-ascii?Q?0QU32kduDK+b38/tRKIDD1dKBQoOVO5481xnAu7ODy3tb5u0xFBy3RCEyWR1?=
 =?us-ascii?Q?yvv5kM//8BIkVIvP+FUx5FoE0/T9e9RHorXCtXiDnleQMXwdVydP2/Dy9mhD?=
 =?us-ascii?Q?N6EOAVNietiqwM91E2ICEaP0GqO5A0QkMtlJVsmwKAGhSXpFRKQTaVpkdo+0?=
 =?us-ascii?Q?Iq2aqTWlkFs99teWmWHv8p+qGRL5d6KCYqTFzKN2N4cDZI9qF8O8auyYdqwC?=
 =?us-ascii?Q?1ulGwRSEaCILgcy6SvI7iCkT0ffhUuZS0WACCh8hY7w2R9MA5yefdk28QPXY?=
 =?us-ascii?Q?M7CgCwYoXF2IIo3xZcGS6vj/AhEUGj+hP2hY6o57d7smulzkE0B1DWTYr3M+?=
 =?us-ascii?Q?jBcZGNU6qbCkWyoYSwSjiIG7NRh6lcX4kt6PSoLHWqhUp4I9rLYlQfpA0jmZ?=
 =?us-ascii?Q?9T5HlUdwFHP+fae75VVcFQblvx4fNeprY40EaWTmqFanSN/5+l8VQGkOqv7i?=
 =?us-ascii?Q?2+uPag1sxAI68RCtu7/f3NDATtGwBhPGW8NJCKNsimgzsmnScelcpfAReIKR?=
 =?us-ascii?Q?ne2JM2WskErKShmUWnq4PgUrk0QivoJ5piO5aQ/Ztoh2zm4VEDyFayAAEFPU?=
 =?us-ascii?Q?NfBclZL+0fvaal76Vc7SrqnKkgFbarb+kr5sa5dOsz7R0y7kocWJrPBOpslo?=
 =?us-ascii?Q?YIaJPwlJeBG0gx34qTt44olMuMiLwxo+kYRnR+JchPcV6HU0FRBplPXsL5Ea?=
 =?us-ascii?Q?p7LB7Fo35JOhzrrgcLNgWtCFqydfMNX9HMxO3sHG?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 878ae9ca-d65e-42d2-f19d-08dce6e9f1b7
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Oct 2024 16:06:03.9274
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zkBN294mqLg/CkyjBFuLrbsBixzvJ64A9nMgOoJ16eR8IVCqftnD0X6Z6G44X/gO6c20S/8cJS9dVFo2jYmgzA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR04MB10275

On Mon, Oct 07, 2024 at 06:06:48PM +0300, Andy Shevchenko wrote:
> Use firmware node and unify checks accordingly in dma_request_chan().
> As a side effect we get rid of the node dereferencing in struct device.

suggest:

Use dev_fwnode() to simple check logic for device tree and ACPI in
dma_request_chan().

Frank

>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>  drivers/dma/dmaengine.c | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/dma/dmaengine.c b/drivers/dma/dmaengine.c
> index dd4224d90f07..758fcd0546d8 100644
> --- a/drivers/dma/dmaengine.c
> +++ b/drivers/dma/dmaengine.c
> @@ -40,6 +40,8 @@
>  #include <linux/dmaengine.h>
>  #include <linux/hardirq.h>
>  #include <linux/spinlock.h>
> +#include <linux/of.h>
> +#include <linux/property.h>
>  #include <linux/percpu.h>
>  #include <linux/rcupdate.h>
>  #include <linux/mutex.h>
> @@ -812,15 +814,13 @@ static const struct dma_slave_map *dma_filter_match(struct dma_device *device,
>   */
>  struct dma_chan *dma_request_chan(struct device *dev, const char *name)
>  {
> +	struct fwnode_handle *fwnode = dev_fwnode(dev);
>  	struct dma_device *d, *_d;
>  	struct dma_chan *chan = NULL;
>
> -	/* If device-tree is present get slave info from here */
> -	if (dev->of_node)
> -		chan = of_dma_request_slave_channel(dev->of_node, name);
> -
> -	/* If device was enumerated by ACPI get slave info from here */
> -	if (has_acpi_companion(dev) && !chan)
> +	if (is_of_node(fwnode))
> +		chan = of_dma_request_slave_channel(to_of_node(fwnode), name);
> +	else if (is_acpi_device_node(fwnode))
>  		chan = acpi_dma_request_slave_chan_by_name(dev, name);
>
>  	if (PTR_ERR(chan) == -EPROBE_DEFER)
> --
> 2.43.0.rc1.1336.g36b5255a03ac
>

