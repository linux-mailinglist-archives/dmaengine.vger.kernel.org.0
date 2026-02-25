Return-Path: <dmaengine+bounces-9082-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uK0UDZgdn2lcZAQAu9opvQ
	(envelope-from <dmaengine+bounces-9082-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Wed, 25 Feb 2026 17:04:40 +0100
X-Original-To: lists+dmaengine@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4931319A351
	for <lists+dmaengine@lfdr.de>; Wed, 25 Feb 2026 17:04:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 074333081250
	for <lists+dmaengine@lfdr.de>; Wed, 25 Feb 2026 15:49:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94D79DF59;
	Wed, 25 Feb 2026 15:43:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="E9ab/PZn"
X-Original-To: dmaengine@vger.kernel.org
Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013008.outbound.protection.outlook.com [40.107.159.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A2DB3D7D87;
	Wed, 25 Feb 2026 15:43:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772034230; cv=fail; b=BBdZfcAQ1nCN2H57bR383/3mgb38nJkz849lilB5taZu+nQbdFALsxVnnV47XcoJ7Or4P4l/QgCD+Ht5J9gI+D8wdn4RpxPCpIGNrqR7krJ6oHT9Sxlz+Sf7OqqtpvtVDDTRXqLbUvH8MqoRs/nvuiLzMWE5+4xzIiezKkV/bxk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772034230; c=relaxed/simple;
	bh=iFfP0Eje/DJH4AYu5Qz1PIaPhE7/wr+4QdhvIo1dcgU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=I9ssNn5cVgO6O27IViUiKhcaM2KoqLOMjImP4LfstjBz5zRdUeQHxVJ7HP9cpZvNVLI8fiJu+rRxsXE277ZV8lNO+03tCs8aF3stTyUeYlgQkcFleny5WPKjyWSxYucfEfTR4FoYW5EyQC+GXnvzCWNi0olzkkBh55Uvwb5DObU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=E9ab/PZn; arc=fail smtp.client-ip=40.107.159.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=leMzIHCg+iUHEHUsU0277ZduA4V0pi+I/j/nOqh3YMVXLBBwH9luFGwnW7eM32mrM6De69CESShwpdxAxxrDbedSEU56mYve2t5h8s8pQ3leDCR+o5hXycMTJvu5R5HndNDSZ0gkIo2/mlf9n+48fSVNvuYkPAbaF02Kvo4L/12G4Y44XgN2fx+SgtQFCX/MAYHzgCU/2R9YXkdyKh3kvFZETEspyl4v5kI7Ywis8DWrPmHCgT3tcmA1+AbpG8H9d3urtcKN9aLudnTr2jL9//hYrXOqVNjGKjshy89UWd4JTnTcO6krPEiLn03xNoNPnmgnrfrm9+PIzTpVkiUTLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ix+OQhuWPctyZD88MTg8PxEiIRPpU2JacwwrvkMNGTo=;
 b=fGLUr/bcNF+aNnuiIeQvwYryE9NEkFYxlP5E+QJsn6waIQmq/WqYecvL8LCWJpMO5VFpLBdRw3+JS+H8a0LNZXa+UQgVJj/V32bvpfTYZXjrFR9QVxDEdm28X8U0m6zk20G698FtigojG1/08IXOBOI3m9YmZo/iOgQSEqUr+4ik6MLwff/hG3bGjdWLrRxco0X5c1AkUMTMh1aAu2lFdoIHSRCf2icAf/fC0K9faUmTYJV/b+SAO4VZqP1LoCMnv43J/Rx0Z9dn2PfAUeaOdPgOr7DZen0sPCw4wo9uIXEUQPe5PJhthxxxPShHFPF1wgIVOFSbtGV3NIcnwzSAmw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ix+OQhuWPctyZD88MTg8PxEiIRPpU2JacwwrvkMNGTo=;
 b=E9ab/PZn+YMrcsKwVm2hQMJ11b2vIZYZir45U9BNhDptt0GNz4Kc6CeGcoyZSenkS04cpUIDMC7F5ExMb6ui3l14oMXLlnav50SWxpl7WU6IFXduiVDhMA+anEJUYsV+1XTbBJPGr14WKUFq/Qbl3Waec1lVFefEQpIaDpth8AsPb+yHGOtI7r+LZY/1hwLD3cXVi6BAiTtmmhf76P3HMSpXuB7criJ+7fJuUlxJBGtc5vIa3GbqVhmZP30TaY+vJg6jqHECRL7qzLGA7ZG+p/yeWyvRxUBc4Ik24wc99N4yxqDFjgOh1O5LyT1aZ7VWi9iKs9O+j82IxDi8rAbEwg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PA4PR04MB9366.eurprd04.prod.outlook.com (2603:10a6:102:2a9::8)
 by VI0PR04MB10735.eurprd04.prod.outlook.com (2603:10a6:800:269::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.23; Wed, 25 Feb
 2026 15:43:44 +0000
Received: from PA4PR04MB9366.eurprd04.prod.outlook.com
 ([fe80::75e4:8143:ddbc:6588]) by PA4PR04MB9366.eurprd04.prod.outlook.com
 ([fe80::75e4:8143:ddbc:6588%6]) with mapi id 15.20.9632.017; Wed, 25 Feb 2026
 15:43:43 +0000
Date: Wed, 25 Feb 2026 10:43:32 -0500
From: Frank Li <Frank.li@nxp.com>
To: Koichiro Den <den@valinux.co.jp>
Cc: Manivannan Sadhasivam <mani@kernel.org>, Vinod Koul <vkoul@kernel.org>,
	Gustavo Pimentel <Gustavo.Pimentel@synopsys.com>,
	Kees Cook <kees@kernel.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>, Christoph Hellwig <hch@lst.de>,
	Niklas Cassel <cassel@kernel.org>, dmaengine@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org,
	linux-pci@vger.kernel.org, linux-nvme@lists.infradead.org,
	imx@lists.linux.dev
Subject: Re: [PATCH v2 04/11] dmaengine: dw-edma: Remove ll_max = -1 in
 dw_edma_channel_setup()
Message-ID: <aZ8YpKPqSjzDtomb@lizhi-Precision-Tower-5810>
References: <20260109-edma_ll-v2-0-5c0b27b2c664@nxp.com>
 <20260109-edma_ll-v2-4-5c0b27b2c664@nxp.com>
 <6d6c222faypvbo6fvs7tad2gtzxqqzlsjkrbefwmgxodt5thbc@lylpaqxozrg7>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6d6c222faypvbo6fvs7tad2gtzxqqzlsjkrbefwmgxodt5thbc@lylpaqxozrg7>
X-ClientProxiedBy: SJ0PR03CA0159.namprd03.prod.outlook.com
 (2603:10b6:a03:338::14) To PA4PR04MB9366.eurprd04.prod.outlook.com
 (2603:10a6:102:2a9::8)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR04MB9366:EE_|VI0PR04MB10735:EE_
X-MS-Office365-Filtering-Correlation-Id: bcd6d067-f896-4bf2-cf08-08de7484a782
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|52116014|7416014|376014|366016|19092799006|38350700014;
X-Microsoft-Antispam-Message-Info:
	uCs20F/Ta6NFIKcl9PZzT4/SXEEXrBCd8ht5AnrAB+mh16IJcu9DxbV9YyJ2qU/YXHsGq86RAY+dp4keaTCS8B24sbBqWopEdMsbksw9zhjs5FHM4GD91zGldOMmTzgNrxBLwW1VF/DlWyqBdBd1ZIwZgCj3rUWiiulhUU0u7m7eGYb57iltdX5w4KtZHrp7b9Ufl670wSJzTylbBvww7OUNOxujgw/a/bieauMxr4/ikMASkp0HlmzsKM+JlyE2cXff118/GXsA8RatMJsC5dej+vB3D4PYUelwLbWLhCKYQXKrlZFeVGuGyWOw4ga3Q+rIegb1DbglXFnSjs1o+2SHQTFCLQpBdOy8msiIBlnTSNK451lOnJ1/t5Isq9xDzoUmoO7U4g9hJ+Wfp6+PUuzuBfj9AGcF9ktlupIBlTdms+XVPkdFBWUicIKJgFF5yUX0QL26hi1NzPdTNWYDiW3iaNEhkkYQnJ5wtMZXJjK6LZDVGEcO4ayZcYC9KnqXKdMtOMiugCikrao5USfZJNwGCILQcrjSic7ZokCMLOovJoMAEMT4+vCumnwisf1H7pSbjIrjZVm+1/2AT1mn3zh/N3xxg60ftbLWkIlIQSlVv2gaoKuPHp28nu6iO3SBK79JAHDiMMd4pnYRyBsnUrFo67E/GD/55N62Yj2TjGddPPyVRG3hvulM/jYJMKUQpHGSOkF4691G0I27phgvVkru5mP4dj6EK5t3iVl4am+zUYJ1Sk5tSHE8XcAqT1sRkaP7xELXfm1D5tWoJLhfvIXNqzbvDuYUiJ5Ucf/badM=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB9366.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(52116014)(7416014)(376014)(366016)(19092799006)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?9kEOFaFEq48S+L9+T1VPxOMTp5+lVZzGNwYxGUlDGWwqgfYgPlFSE71OEdmJ?=
 =?us-ascii?Q?zwfGy46rccXk3xuOWEqNLjdMIUsw2uUayOBTNrn6Gb6wZmGQtKgioEa/mEb3?=
 =?us-ascii?Q?Iywe67DBc6/k3zGnbTxO14h/9jvftTmWx0KRjZzFwPWK4pHv6VwxCCfx11rq?=
 =?us-ascii?Q?yGcCdCz+uX/hMn9G8mjT3vaOkj1x3m0FNsSSv6GBd3o/ouZiBfsHRZkSittt?=
 =?us-ascii?Q?yZneOCFwSWp0ZM7prRRiu7IwWpqDLJgAe9GMxgM88OgtLziMtg3YuDaFGvdh?=
 =?us-ascii?Q?X7CV4youTWjl0FxnciWjj9EpqMswbFeTKSrq8xX2UcpSAGafG/iUYC49HBzw?=
 =?us-ascii?Q?c8jGkbNPgiOB1InXtffERDTdo6nyEqzQTIEBbgsIvat2pDrH1p+y8Kaqwg5E?=
 =?us-ascii?Q?ApmGxcROYiNzlMfZ1VO8+uaczpfE1yc4cGcBPESE4rptVp8UBthghrlN72ak?=
 =?us-ascii?Q?ph/1gUt/Bk+iZ7scXtuv3F3+nPmWSIOsknEyLbo5B7Zs1nHpod1WOeksBDVV?=
 =?us-ascii?Q?YUKmVOw3kFPWNB09Fuvy26wFW7F8s2fGt5+LXY8zvmwIVwrnsBmhRxX3IDVm?=
 =?us-ascii?Q?IMRi5n+DOFyTEUnzo5SlcTl9vJ7ftQ+8Qh/NsD7J/ovaq2qrLrAa26yA1yZN?=
 =?us-ascii?Q?v1pukpV0+qDhGq8xZAXH2THK8zYvvXZmM1/q3eSjrupaFV9s4nlpkmt0CYkK?=
 =?us-ascii?Q?EF0repI8WsAzpNNoU6w9QhHXExl7QQQD5Py4le2nrKaRQFTs5XBXm8J9j6ah?=
 =?us-ascii?Q?DiV6Nf7t0mcQ6tlqRWDBr9+MyLXQMpz8ItgqVspN72+MQAhZvPaTGmaJw19G?=
 =?us-ascii?Q?mMetjRvk3Y7mvUQpgotO/keX9huWOPVrcMl62fpamhy9B86GXeRGfrZLulLo?=
 =?us-ascii?Q?svwUljgNShpgn/hLK4Eol6iKUaElVIX30GwB2TwK7sP2HfcJ+CR1o1kOlRJd?=
 =?us-ascii?Q?WqnlhnQ6Vsj6/WOKpUOd+r0z9tQobtuS3zpcwGrKU/cN/WHGF64X+6rCLusS?=
 =?us-ascii?Q?jXW1bUeWO1dsRDfRdc5rQe2Nl0IyeG/JXfjueJBQifAz8NKpbo8gaIfPc//c?=
 =?us-ascii?Q?qqwajNFXWiHvv97+WG4EAeP8aefz1dkGyDp/2sIssgF3kf7OjZpjCfNDtoY3?=
 =?us-ascii?Q?1UkXCQDs0pVmYB4ff01y5MotLpRK5yYVapJUI+CKEQlA7cf+TRhSIIaw9Ept?=
 =?us-ascii?Q?5hCmDP5kQa3DCTC1Z8+QMlDhLCala6EkYbu3a4ugAFFylrTTwZFL/d/as2SH?=
 =?us-ascii?Q?PVlMQtdqiGclELQ5pjAoppfAZh0dZc1GyHbelSgiQGefVdu4Ud696kuNHpMI?=
 =?us-ascii?Q?4KfNJUIwBNQ7acmRyKQO3XTSnHps3WucXRf7z5cd2avRFXI4R12+w1yPPVIh?=
 =?us-ascii?Q?QEjrQfQSDyKt0HX+8KFrAgJioNQTXEL2OvqUDuQBg8LmPOILsueoTX7iNFe/?=
 =?us-ascii?Q?oqovZ87CvjPuyBXbIRmjuy7XznWcYT/E23h3EZcN/z+GD7fFgEQf+fH4vCkD?=
 =?us-ascii?Q?fSdRDsgPdXcsQQbLpEuHHYgxa7Zi793CEZbMDIWhxPMM/RPjb+WI+LGJf1C7?=
 =?us-ascii?Q?JxM9AyHIPBM1bHOJXosqIW0Ma1mdhkJbGOq6bq3+HJf7TiglOS3nFeUD+GQm?=
 =?us-ascii?Q?byQh++vX65zzH5xA8CDp/vmzLm2ALv/bk2Xg6+bk+hLdY99H3bhmjCDL+C73?=
 =?us-ascii?Q?6ca9TJwc2VPRAR647DlyGR2uTLozIGjUo91KbEXJ/vdc9jL4mXiC1ZbLDsFg?=
 =?us-ascii?Q?mu4syEuBXg=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bcd6d067-f896-4bf2-cf08-08de7484a782
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB9366.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Feb 2026 15:43:42.9610
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: u12ZjcZeqKrefwsqQs40NKyZpfIzoVpdhdlOfXxq/Ue3E9soD0ECzR5ZchaptUrYKNHQ/azBOrVR8pmsA5q0QA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR04MB10735
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nxp.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[nxp.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-9082-lists,dmaengine=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[17];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TAGGED_RCPT(0.00)[dmaengine];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nxp.com:email,nxp.com:dkim,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 4931319A351
X-Rspamd-Action: no action

On Wed, Feb 25, 2026 at 05:30:33PM +0900, Koichiro Den wrote:
> On Fri, Jan 09, 2026 at 10:28:24AM -0500, Frank Li wrote:
> > dw_edma_channel_setup() calculates ll_max based on the size of the
> > ll_region, but the value is later overwritten with -1, preventing the
> > code from ever reaching the calculated ll_max.
> >
> > Typically ll_max is around 170 for a 4 KB page and four DMA R/W channels.
> > It is uncommon for a single DMA request to reach this limit, so the issue
> > has not been observed in practice. However, if it occurs, the driver may
> > overwrite adjacent memory before reporting an error.
> >
> > Remove the incorrect assignment so the calculated ll_max is honored
> >
> > Fixes: 31fb8c1ff962d ("dmaengine: dw-edma: Improve the linked list and data blocks definition")
> > Signed-off-by: Frank Li <Frank.Li@nxp.com>
> > ---
> >  drivers/dma/dw-edma/dw-edma-core.c | 1 -
> >  1 file changed, 1 deletion(-)
> >
> > diff --git a/drivers/dma/dw-edma/dw-edma-core.c b/drivers/dma/dw-edma/dw-edma-core.c
> > index c6b014949afe82f10362711fc8a956fe60a72835..b154bdd7f2897d9a28df698a425afc1b1c93698b 100644
> > --- a/drivers/dma/dw-edma/dw-edma-core.c
> > +++ b/drivers/dma/dw-edma/dw-edma-core.c
> > @@ -770,7 +770,6 @@ static int dw_edma_channel_setup(struct dw_edma *dw, u32 wr_alloc, u32 rd_alloc)
> >  			chan->ll_max = (chip->ll_region_wr[chan->id].sz / EDMA_LL_SZ);
> >  		else
> >  			chan->ll_max = (chip->ll_region_rd[chan->id].sz / EDMA_LL_SZ);
> > -		chan->ll_max -= 1;
>
> Just curious: wasn't this to reserve one slot for the final link element?

when calculate avaible entry, always use chan-ll_max -1.  ll_max indicate
memory size, final link element actually occupted a space.

Frank
>
> Best regards,
> Koichiro
>
> >
> >  		dev_vdbg(dev, "L. List:\tChannel %s[%u] max_cnt=%u\n",
> >  			 str_write_read(chan->dir == EDMA_DIR_WRITE),
> >
> > --
> > 2.34.1
> >

