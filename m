Return-Path: <dmaengine+bounces-10034-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OGQAIp3R5Wl6oQEAu9opvQ
	(envelope-from <dmaengine+bounces-10034-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Mon, 20 Apr 2026 09:11:25 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id F18C14279F8
	for <lists+dmaengine@lfdr.de>; Mon, 20 Apr 2026 09:11:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 784E6300E62C
	for <lists+dmaengine@lfdr.de>; Mon, 20 Apr 2026 07:11:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18BA737FF67;
	Mon, 20 Apr 2026 07:11:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="PTdgzwSt"
X-Original-To: dmaengine@vger.kernel.org
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011011.outbound.protection.outlook.com [52.101.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 316AE40DFB6;
	Mon, 20 Apr 2026 07:11:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776669080; cv=fail; b=KOwxPIz7z2slb37yBqBd3bw/5OMFNoZhLy4Xx0r58wB0eFiNnAEA1J5UlS6un5AfW8wdhNVz7N4H4Itl0f/90Afw2Lq4V7tPAwe+JdUbR3Vpc+qqwM8LFquEn89RGX9IH4JT3TbPjrt4FzM5Xk7gyfjH1MhxqM30uHivM4I0q9U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776669080; c=relaxed/simple;
	bh=ArmNXmqBGGJ9QU5ZwS2U4JrSzkSFQhAUPHtHU2VHGhs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=CYTDUiM/wforVrdt2GBF9QBLbSQ/X8f52VOmQstjGseNHvH+Rufw8JG6GbShyMM4A5kcGBSNwRCJJ4Va+FKjI8wdlk9JTf1lKFBINJEbxh0z0FzsN98m5bxBODJv/z5t5dJavf7BQxYqeFsh8FrKMpxY+kPHlOGeE67P8XrrghE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=PTdgzwSt; arc=fail smtp.client-ip=52.101.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iggss0+H8qHBDIx4polr88k5md0pggtw+2GjWuQP949xN577stRvn2kcBBR2oosIqJxEWk99ht/CZw/WLvrKlVB9PJyWKWuN6VRcwfqDXIHQx2l/v+/ViEpgqJ4mWCZv4vRIX4TAz2tkuRkL9wKKHYlBOUcds5JPfa3gVZArUG9jP/ecfIvGpZLpOBbF9XfVbKmLTJ6cY3ZXZooVijCFAF+v8OmP+8KfhsADKZPiNO+X6VCT7uadFMBX7f+QKHpveo92LskK8vxnxeNNp9RcpvYAR/jI+/iwNIRg4ymmtqZ4I9Ik0cs9npR5kWqjqYwRrWkjGkLML+tFp4nJ6vv44w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TUWJ2iSwQ92vq8gNXX69vLXLiP0dgbwwTnpHp1DLm3w=;
 b=RVXJhjiczZRQg0uMLUR8mYv2vylj0N9bXJjR/1gD4kzzSfsz673lvGMuKp/+aytFx8mF4jEjtsULFoU6wv+BXupQl7OMLW9opVxomet/Qrif6kpedyH76yfzXFzGTPaPu1aDH+UXkq6JyMI7gGoPFoU5w6C/zSxVHy+bN8TTu0lwyagxgt+Olqyzi1QITR2s1pFGnMZMzVy24+MX1XgTBv6NWnO4IQj4uq5C88nuC1syHDQPfxVkHpYLWxBsW9biBvVyoem4/t22xDRAt2YlPVwkFhoKnpBpolG2lCyv6FWvFiH7HMuQE1WtBvWEVmwMyNMrEKTkbJ4xRepkpscbHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TUWJ2iSwQ92vq8gNXX69vLXLiP0dgbwwTnpHp1DLm3w=;
 b=PTdgzwSttd7q+XuwSShiRcT3UfPtYU/oRtU53fVhYbhBSSq1Lm4gzsrgD/0Do3/bpr8ZmAsaqPOAx+3xs7bVT0dUPnFZFoiVAYzsL2NX+fMYVKXSu5cmA8npFNGMBljtUVyQ58qUhXYO/zYCh2OatXr/X3wZ+BN2jYk98e5yzXF5tYlZ8iOPnc/1DEHdm+guwwWBC/LHXNJxt+GsZ34OHRT9ntn2Yjl3U2c5Cc4jeVP9E0S9ahgjlhYInySw1CAAgRoIwsuceMPqniIwgjjofOSLYKvQYYFizyRRagvyZbZXxfRqz5XViN5Nbla2mGFpPPMw5XNZdZvZ1EX5SHUaRg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PA4PR04MB9366.eurprd04.prod.outlook.com (2603:10a6:102:2a9::8)
 by DU6PR04MB11229.eurprd04.prod.outlook.com (2603:10a6:10:5c4::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9818.32; Mon, 20 Apr
 2026 07:11:15 +0000
Received: from PA4PR04MB9366.eurprd04.prod.outlook.com
 ([fe80::75e4:8143:ddbc:6588]) by PA4PR04MB9366.eurprd04.prod.outlook.com
 ([fe80::75e4:8143:ddbc:6588%6]) with mapi id 15.20.9818.032; Mon, 20 Apr 2026
 07:11:14 +0000
Date: Mon, 20 Apr 2026 03:11:08 -0400
From: Frank Li <Frank.li@nxp.com>
To: Nathan Lynch <nathan.lynch@amd.com>
Cc: Vinod Koul <vkoul@kernel.org>, Wei Huang <wei.huang2@amd.com>,
	Mario Limonciello <mario.limonciello@amd.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Jonathan Cameron <jonathan.cameron@huawei.com>,
	Stephen Bates <Stephen.Bates@amd.com>,
	PradeepVineshReddy.Kodamati@amd.com, John.Kariuki@amd.com,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	dmaengine@vger.kernel.org
Subject: Re: [PATCH 07/23] dmaengine: sdxi: Allocate administrative context
Message-ID: <aeXRjNHi6dRjbV1-@lizhi-Precision-Tower-5810>
References: <20260410-sdxi-base-v1-0-1d184cb5c60a@amd.com>
 <20260410-sdxi-base-v1-7-1d184cb5c60a@amd.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260410-sdxi-base-v1-7-1d184cb5c60a@amd.com>
X-ClientProxiedBy: SN6PR05CA0035.namprd05.prod.outlook.com
 (2603:10b6:805:de::48) To PA4PR04MB9366.eurprd04.prod.outlook.com
 (2603:10a6:102:2a9::8)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR04MB9366:EE_|DU6PR04MB11229:EE_
X-MS-Office365-Filtering-Correlation-Id: 0ad9ac7b-be14-45d2-35b5-08de9eac0241
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|7416014|376014|366016|19092799006|1800799024|38350700014|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	7UTBlotm0DDtUO7Kg2VHCNDF6d7So2/g5Z6bxPutcB+pRHSiL/iHLXVil+ARKGNOJAAwJCnHJC1YaSdG/R2bZ2JgLXP/4L55ofHRPexfxQOoguYjO2WYp+PMWM2afc7U9pdJIgg9wkciVecoKjr4oJjz2Of1bAZIfeicVMnouKM/egJBvCFdC62huhWj8z6IewmoKGAOwFVKmkmcC56CAjiHTQSMWtyCV+uS9Ma3nP62PajgrqkwQ4tgtSues/07YWEemKUNhPb1KHh1kI6+Ztu7p9CyhXi98Ka7DBSC8sFBI55K1KOJPUgiQ695SB4DoOazzgeqEVHNk5DaEhvb3pE9o76tkGebAXjA6mltyw2Y5ARucTE/NkLDb4exWJ2xx9jETBNJElh/U6u3vw8ICvusfHPtUr+qDZJO4LWAtk5cs6IaPildhefObA6Y2yY7R9k7xdrmKolbM7ybMQVa3VyKGIdMScYFl7pnKBDPqUfdHlxg118eM1dG2Awl1bWq+hRtZlRWhZLOPoF1BCQP5/u+wvoxuZXul7szRQaMQW8J0Vi6sWIdr+s1CmSasc/VvGK0oCaeEYpLkt393kfHIfSxtKGmwh+ZhEXbV+ohCecfHZ8P6xFi/VuRInfcZSaphLmpTeoDqOfW5vNlpAMxtdfnPKJavxLOuoLypOPbxI15w/xWs4S1RwiEKQ3nrTh3bCXXY7Zg55SJ/CQpiApXRxS+2wZvL0kH2fgKrmvZmzet0COp3DhbFzdpFgiXlZB62656Lrg4ZXIz20PSHezdgePQoPLdqrfu+lB+MMuINyo=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB9366.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(7416014)(376014)(366016)(19092799006)(1800799024)(38350700014)(56012099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?6fEKd9cNgWy1jMACwTWkYgAe33C+pz0K/MT0CVkiYi2d1JbMF72AQK7FLTlX?=
 =?us-ascii?Q?9WKViL6B8cixG1jv8NW66uf3n/2+tDdvWtyD455cXCsJMzBixCJ3q99vMDfW?=
 =?us-ascii?Q?ArI112SKv8SqxXmfk16/V9t5AwzcKa4E4eR8iV4a/VXBR4bY5vo+BpvBx2BV?=
 =?us-ascii?Q?GbasVxxsDLMuV8YAn8FF15rKEsl7uj44MtcnMEMdoFngQzrG7mPHYlJu2dcn?=
 =?us-ascii?Q?e6jyg8KS/8L7WywvFwe1CrmsOHC9yJDxHtKuLA7rkF67caVy+rvARo4AMp74?=
 =?us-ascii?Q?FWJMesY4Y89x1BeZd3ZP7McypP/aqCkSzU2b4uZBzqCIGcXket7M9Ot+f6IL?=
 =?us-ascii?Q?i8ubBY7CAW71EDrmovFyRsKwL78IPoBlFqUEDuBV6PfrqwM4NxDQiIN9eDDC?=
 =?us-ascii?Q?SBa0GA7w9Dn7WeRSder/VItrE4F7FzOnkzBavndbD5pcrZij7NNq5u7ZMt7G?=
 =?us-ascii?Q?uBPLB+Zio4btT8eHTFUR6dwggcODk/jTWYlrxinFfFBW443D7FCnfW2+c+rz?=
 =?us-ascii?Q?P40Ex18KP3kCdaKOJGX7OEZJpsyPsnLDQsYfb+QYVidjxwGHAgNbC2sTmgKA?=
 =?us-ascii?Q?hY/rWJaxi7Jh7W9MDRXdJxs4jaYu3Ca5BTwfcvoXCF3T+EJKMoD2t+njUJHp?=
 =?us-ascii?Q?hcr0ynxneV+umWgqIBlt0NDkU67WPMI8L2CJTSX2kj9KgNMMIrpf9pbdodsU?=
 =?us-ascii?Q?odMJvt5vpimSKAuBL8UBFB/RgYKLNs5Bex28nm408LcbZyvfPGomeTSJhyNz?=
 =?us-ascii?Q?2O0qtqe5HpFJakFY4qHFK1Dyp1jQHN9jgEcIVCJZHBNQTdISbVnChhzmablS?=
 =?us-ascii?Q?4G6EoUerkwOp1SQ5Jg6Z8m86h8u6hn8J7eCVRFumDXYSgDyHrU0fJhUI+W8D?=
 =?us-ascii?Q?uNmBCGpHLspBhUKPck2luqfzdleKQPpu3sHn+2GqA3sS0G2qfu32cf6SIOIe?=
 =?us-ascii?Q?GJ6DvM4G9WBCbBD3i5+25JGz10RXDiehRBQZbDJzJXYDgnaYxeYwOrLcTm8R?=
 =?us-ascii?Q?qTGQN7Cp+LFLisV53v0LI0wWMgaW7ADnDzyz5kSNGn3UG6XUMqT/GadSOU9n?=
 =?us-ascii?Q?ljZuDKrvtjdvar6EmmpfuWvM1YLeVFAcgTHExp/6f4E3DMXwsTz1/9fFnwt9?=
 =?us-ascii?Q?vISeZXeKQQV/pQKAowI9VlYdL04HrmTdHmcFoE6s33hbxH8a0PA9QTOi3gCU?=
 =?us-ascii?Q?ym/a0bEAFHGaevXGtG3yqTQLTIYbvf+ssCOLtteWh4z/PcrEfsjRp3Yj5c0J?=
 =?us-ascii?Q?PXQ2f+wLpY6x1an5wC4IJ3m4fOIdz5OkdIab6FhNHrbpYSVX0ciQYKlH/eEd?=
 =?us-ascii?Q?9c5vG0LgzFLQ8rXC8yqLBNBH1opfDfd8ZOr/gVe32BAWlX4vZhKKAoFB0T2D?=
 =?us-ascii?Q?bQV5pv26ugvnExgpvemuhk3zwRqloPVVOKFjkoDBHE1PuW7Ry5z8qKLUJ2rJ?=
 =?us-ascii?Q?hpQmtNWsWUUqWMI86JBuhrsr/XybaVBX/FpATCc+W3G1+VWApl0hF5R9KFgv?=
 =?us-ascii?Q?Lwofukxc7b7pmJPOBArsZqdEa2rciQBOsTEKvHUsI3fKOnbedkoMuPM1Y58B?=
 =?us-ascii?Q?VPxfaEAiceaQ8EH/Ox3TDw5BERR3856YrurBgxHki5eAnXT8ZmE5DeXlZ7Jy?=
 =?us-ascii?Q?XMuADom9DYp58FchVdc+VTQNhmqxGf0oqVtOeOOA/Pv4Opz+ZSeLcldfxeBW?=
 =?us-ascii?Q?kpRNay4W47x+Diui4ILUHULXXep0Xc5I5OKbixSi+mPBb4jEbtTD5uxV+X1n?=
 =?us-ascii?Q?wac1r3F5Ow=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0ad9ac7b-be14-45d2-35b5-08de9eac0241
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB9366.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Apr 2026 07:11:14.5589
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uWniNf4sQUuf1iXdh1IHXuBDcvQ3ZDXM5/kXR+cmfS52W7RwRMw8PK+D/4BxvLaLPVkoGlSx3DofqiOka4jlUA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU6PR04MB11229
X-Spamd-Result: default: False [0.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nxp.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[nxp.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-10034-lists,dmaengine=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[12];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[Frank.li@nxp.com,dmaengine@vger.kernel.org];
	DKIM_TRACE(0.00)[nxp.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[dmaengine];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[amd.com:email,nxp.com:dkim,nxp.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: F18C14279F8
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri, Apr 10, 2026 at 08:07:17AM -0500, Nathan Lynch wrote:
> Create the control structure hierarchy in memory for the per-function
> administrative context. Use devres to queue the corresponding cleanup
> since the admin context is a device-scope resource. The context is
> inert for now; changes to follow will make it functional.
>
> Co-developed-by: Wei Huang <wei.huang2@amd.com>
> Signed-off-by: Wei Huang <wei.huang2@amd.com>
> Signed-off-by: Nathan Lynch <nathan.lynch@amd.com>
> ---
Reviewed-by: Frank Li <Frank.Li@nxp.com>
>  drivers/dma/sdxi/Makefile  |   4 +-
>  drivers/dma/sdxi/context.c | 128 +++++++++++++++++++++++++++++++++++++++++++++
>  drivers/dma/sdxi/context.h |  54 +++++++++++++++++++
>  drivers/dma/sdxi/device.c  |  11 ++++
>  drivers/dma/sdxi/hw.h      |  43 +++++++++++++++
>  drivers/dma/sdxi/sdxi.h    |   2 +
>  6 files changed, 241 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/dma/sdxi/Makefile b/drivers/dma/sdxi/Makefile
> index f84b87d53e27..2178f274831c 100644
> --- a/drivers/dma/sdxi/Makefile
> +++ b/drivers/dma/sdxi/Makefile
> @@ -1,6 +1,8 @@
>  # SPDX-License-Identifier: GPL-2.0
>  obj-$(CONFIG_SDXI) += sdxi.o
>
> -sdxi-objs += device.o
> +sdxi-objs += \
> +	context.o     \
> +	device.o
>
>  sdxi-$(CONFIG_PCI_MSI) += pci.o
> diff --git a/drivers/dma/sdxi/context.c b/drivers/dma/sdxi/context.c
> new file mode 100644
> index 000000000000..0a6821992776
> --- /dev/null
> +++ b/drivers/dma/sdxi/context.c
> @@ -0,0 +1,128 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * SDXI context management
> + *
> + * Copyright Advanced Micro Devices, Inc.
> + */
> +
> +#define pr_fmt(fmt)     "SDXI: " fmt
> +
> +#include <linux/bug.h>
> +#include <linux/cleanup.h>
> +#include <linux/device/devres.h>
> +#include <linux/dma-mapping.h>
> +#include <linux/dmapool.h>
> +#include <linux/errno.h>
> +#include <linux/slab.h>
> +#include <linux/types.h>
> +
> +#include "context.h"
> +#include "sdxi.h"
> +
> +#define DEFAULT_DESC_RING_ENTRIES 1024
> +
> +enum {
> +	/*
> +	 * The admin context always has ID 0. See SDXI 1.0 3.5
> +	 * Administrative Context (Context 0).
> +	 */
> +	SDXI_ADMIN_CXT_ID = 0,
> +};
> +
> +/*
> + * Free context and its resources. @cxt may be partially allocated but
> + * must have ->sdxi set.
> + */
> +static void sdxi_free_cxt(struct sdxi_cxt *cxt)
> +{
> +	struct sdxi_dev *sdxi = cxt->sdxi;
> +	struct sdxi_sq *sq = cxt->sq;
> +
> +	if (cxt->cxt_ctl)
> +		dma_pool_free(sdxi->cxt_ctl_pool, cxt->cxt_ctl,
> +			      cxt->cxt_ctl_dma);
> +	if (cxt->akey_table)
> +		dma_free_coherent(sdxi_to_dev(sdxi), sizeof(*cxt->akey_table),
> +				  cxt->akey_table, cxt->akey_table_dma);
> +	if (sq && sq->write_index)
> +		dma_pool_free(sdxi->write_index_pool, sq->write_index,
> +			      sq->write_index_dma);
> +	if (sq && sq->cxt_sts)
> +		dma_pool_free(sdxi->cxt_sts_pool, sq->cxt_sts, sq->cxt_sts_dma);
> +	if (sq && sq->desc_ring)
> +		dma_free_coherent(sdxi_to_dev(sdxi), sq->ring_size,
> +				  sq->desc_ring, sq->ring_dma);
> +	kfree(cxt->sq);
> +	kfree(cxt);
> +}
> +
> +DEFINE_FREE(sdxi_cxt, struct sdxi_cxt *, if (_T) sdxi_free_cxt(_T))
> +
> +/* Allocate a context and its control structure hierarchy in memory. */
> +static struct sdxi_cxt *sdxi_alloc_cxt(struct sdxi_dev *sdxi)
> +{
> +	struct device *dev = sdxi_to_dev(sdxi);
> +	struct sdxi_sq *sq;
> +	struct sdxi_cxt *cxt __free(sdxi_cxt) = kzalloc(sizeof(*cxt), GFP_KERNEL);
> +
> +	if (!cxt)
> +		return NULL;
> +
> +	cxt->sdxi = sdxi;
> +
> +	cxt->sq = kzalloc_obj(*cxt->sq, GFP_KERNEL);
> +	if (!cxt->sq)
> +		return NULL;
> +
> +	cxt->akey_table = dma_alloc_coherent(dev, sizeof(*cxt->akey_table),
> +					     &cxt->akey_table_dma, GFP_KERNEL);
> +	if (!cxt->akey_table)
> +		return NULL;
> +
> +	cxt->cxt_ctl = dma_pool_zalloc(sdxi->cxt_ctl_pool, GFP_KERNEL,
> +				       &cxt->cxt_ctl_dma);
> +	if (!cxt->cxt_ctl_dma)
> +		return NULL;
> +
> +	sq = cxt->sq;
> +
> +	sq->ring_entries = DEFAULT_DESC_RING_ENTRIES;
> +	sq->ring_size = sq->ring_entries * sizeof(sq->desc_ring[0]);
> +	sq->desc_ring = dma_alloc_coherent(dev, sq->ring_size, &sq->ring_dma,
> +					   GFP_KERNEL);
> +	if (!sq->desc_ring)
> +		return NULL;
> +
> +	sq->cxt_sts = dma_pool_zalloc(sdxi->cxt_sts_pool, GFP_KERNEL,
> +				      &sq->cxt_sts_dma);
> +	if (!sq->cxt_sts)
> +		return NULL;
> +
> +	sq->write_index = dma_pool_zalloc(sdxi->write_index_pool, GFP_KERNEL,
> +					  &sq->write_index_dma);
> +	if (!sq->write_index)
> +		return NULL;
> +
> +	return_ptr(cxt);
> +}
> +
> +static void free_admin_cxt(void *ptr)
> +{
> +	struct sdxi_dev *sdxi = ptr;
> +
> +	sdxi_free_cxt(sdxi->admin_cxt);
> +}
> +
> +int sdxi_admin_cxt_init(struct sdxi_dev *sdxi)
> +{
> +	struct sdxi_cxt *cxt __free(sdxi_cxt) = sdxi_alloc_cxt(sdxi);
> +	if (!cxt)
> +		return -ENOMEM;
> +
> +	cxt->id = SDXI_ADMIN_CXT_ID;
> +	cxt->db = sdxi->dbs + cxt->id * sdxi->db_stride;
> +
> +	sdxi->admin_cxt = no_free_ptr(cxt);
> +
> +	return devm_add_action_or_reset(sdxi_to_dev(sdxi), free_admin_cxt, sdxi);
> +}
> diff --git a/drivers/dma/sdxi/context.h b/drivers/dma/sdxi/context.h
> new file mode 100644
> index 000000000000..800b4ead1dd9
> --- /dev/null
> +++ b/drivers/dma/sdxi/context.h
> @@ -0,0 +1,54 @@
> +/* SPDX-License-Identifier: GPL-2.0-only */
> +/*
> + * Copyright Advanced Micro Devices, Inc.
> + */
> +
> +#ifndef DMA_SDXI_CONTEXT_H
> +#define DMA_SDXI_CONTEXT_H
> +
> +#include <linux/dma-mapping.h>
> +#include <linux/types.h>
> +
> +#include "hw.h"
> +#include "sdxi.h"
> +
> +/*
> + * The size of the AKey table is flexible, from 4KB to 1MB. Always use
> + * the minimum size for now.
> + */
> +struct sdxi_akey_table {
> +	struct sdxi_akey_ent entry[SZ_4K / sizeof(struct sdxi_akey_ent)];
> +};
> +
> +/* Submission Queue */
> +struct sdxi_sq {
> +	u32 ring_entries;
> +	u32 ring_size;
> +	struct sdxi_desc *desc_ring;
> +	dma_addr_t ring_dma;
> +
> +	__le64 *write_index;
> +	dma_addr_t write_index_dma;
> +
> +	struct sdxi_cxt_sts *cxt_sts;
> +	dma_addr_t cxt_sts_dma;
> +};
> +
> +struct sdxi_cxt {
> +	struct sdxi_dev *sdxi;
> +	unsigned int id;
> +
> +	__le64 __iomem *db;
> +
> +	struct sdxi_cxt_ctl *cxt_ctl;
> +	dma_addr_t cxt_ctl_dma;
> +
> +	struct sdxi_akey_table *akey_table;
> +	dma_addr_t akey_table_dma;
> +
> +	struct sdxi_sq *sq;
> +};
> +
> +int sdxi_admin_cxt_init(struct sdxi_dev *sdxi);
> +
> +#endif /* DMA_SDXI_CONTEXT_H */
> diff --git a/drivers/dma/sdxi/device.c b/drivers/dma/sdxi/device.c
> index 80bd1bbd9c7c..636abc410dcd 100644
> --- a/drivers/dma/sdxi/device.c
> +++ b/drivers/dma/sdxi/device.c
> @@ -13,6 +13,7 @@
>  #include <linux/log2.h>
>  #include <linux/slab.h>
>
> +#include "context.h"
>  #include "hw.h"
>  #include "mmio.h"
>  #include "sdxi.h"
> @@ -186,6 +187,16 @@ static int sdxi_fn_activate(struct sdxi_dev *sdxi)
>  			       sdxi->L1_dma >> ilog2(SZ_4K));
>  	L2_ent->lv01_ptr = cpu_to_le64(lv01_ptr);
>
> +	/*
> +	 * SDXI 1.0 4.1.8.4 Administrative Context
> +	 *
> +	 * The admin context will not consume descriptors until we
> +	 * write its doorbell later.
> +	 */
> +	err = sdxi_admin_cxt_init(sdxi);
> +	if (err)
> +		return err;
> +
>  	return 0;
>  }
>
> diff --git a/drivers/dma/sdxi/hw.h b/drivers/dma/sdxi/hw.h
> index 846c671c423f..b66eb22f7f90 100644
> --- a/drivers/dma/sdxi/hw.h
> +++ b/drivers/dma/sdxi/hw.h
> @@ -23,6 +23,7 @@
>
>  #include <linux/bits.h>
>  #include <linux/build_bug.h>
> +#include <linux/stddef.h>
>  #include <linux/types.h>
>  #include <asm/byteorder.h>
>
> @@ -72,12 +73,39 @@ static_assert(sizeof(struct sdxi_cxt_ctl) == 64);
>  /* SDXI 1.0 Table 3-5: Context Status (CXT_STS) */
>  struct sdxi_cxt_sts {
>  	__u8 state;
> +#define SDXI_CXT_STS_STATE GENMASK(3, 0)
>  	__u8 misc0;
>  	__u8 rsvd_0[6];
>  	__le64 read_index;
>  } __packed;
>  static_assert(sizeof(struct sdxi_cxt_sts) == 16);
>
> +/* SDXI 1.0 Table 3-6: CXT_STS.state Encoding */
> +/* Valid values for FIELD_GET(SDXI_CXT_STS_STATE, sdxi_cxt_sts.state). */
> +enum cxt_sts_state {
> +	CXTV_STOP_SW  = 0x0,
> +	CXTV_RUN      = 0x1,
> +	CXTV_STOPG_SW = 0x2,
> +	CXTV_STOP_FN  = 0x4,
> +	CXTV_STOPG_FN = 0x6,
> +	CXTV_ERR_FN   = 0xf,
> +};
> +
> +/* SDXI 1.0 Table 3-7: AKey Table Entry (AKEY_ENT) */
> +struct sdxi_akey_ent {
> +	__le16 intr_num;
> +#define SDXI_AKEY_ENT_VL BIT(0)
> +#define SDXI_AKEY_ENT_IV BIT(1)
> +#define SDXI_AKEY_ENT_INTR_NUM GENMASK(14, 4)
> +	__le16 tgt_sfunc;
> +	__le32 pasid;
> +	__le16 stag;
> +	__u8   rsvd_0[2];
> +	__le16 rkey;
> +	__u8   rsvd_1[2];
> +} __packed;
> +static_assert(sizeof(struct sdxi_akey_ent) == 16);
> +
>  /* SDXI 1.0 Table 6-4: CST_BLK (Completion Status Block) */
>  struct sdxi_cst_blk {
>  	__le64 signal;
> @@ -86,4 +114,19 @@ struct sdxi_cst_blk {
>  } __packed;
>  static_assert(sizeof(struct sdxi_cst_blk) == 32);
>
> +struct sdxi_desc {
> +	union {
> +		/*
> +		 * SDXI 1.0 Table 6-3: DSC_GENERIC SDXI Descriptor
> +		 * Common Header and Footer Format
> +		 */
> +		struct_group_tagged(sdxi_dsc_generic, generic,
> +			__le32 opcode;
> +			__u8 operation[52];
> +			__le64 csb_ptr;
> +		);
> +	};
> +} __packed;
> +static_assert(sizeof(struct sdxi_desc) == 64);
> +
>  #endif /* DMA_SDXI_HW_H */
> diff --git a/drivers/dma/sdxi/sdxi.h b/drivers/dma/sdxi/sdxi.h
> index 6cda60bb33c4..4ef893ae15f3 100644
> --- a/drivers/dma/sdxi/sdxi.h
> +++ b/drivers/dma/sdxi/sdxi.h
> @@ -51,6 +51,8 @@ struct sdxi_dev {
>  	struct dma_pool *cxt_ctl_pool;
>  	struct dma_pool *cst_blk_pool;
>
> +	struct sdxi_cxt *admin_cxt;
> +
>  	const struct sdxi_bus_ops *bus_ops;
>  };
>
>
> --
> 2.53.0
>

