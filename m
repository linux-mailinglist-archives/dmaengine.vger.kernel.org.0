Return-Path: <dmaengine+bounces-10042-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +G2pHQ7i5WnfowEAu9opvQ
	(envelope-from <dmaengine+bounces-10042-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Mon, 20 Apr 2026 10:21:34 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id DCD52428128
	for <lists+dmaengine@lfdr.de>; Mon, 20 Apr 2026 10:21:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8D72D30470D5
	for <lists+dmaengine@lfdr.de>; Mon, 20 Apr 2026 08:19:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65C093815E2;
	Mon, 20 Apr 2026 08:19:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="X/haISnx"
X-Original-To: dmaengine@vger.kernel.org
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010064.outbound.protection.outlook.com [52.101.69.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70067388371;
	Mon, 20 Apr 2026 08:19:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776673179; cv=fail; b=b3r/wLliJbEreqn28uwLTE8aE9jtZXs404B3vNeXVX5Xp5LvzLWEguTeQlfJQdraizBYP0zYEY3iw7dSK6WQOupue8BzmE7O0/9w4/KhZxcU6HbCVzlwbpAw6sTp59RG3yhAqIkOd/EJWo12NcneDlReGSIB03d9kH9n7X66sOg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776673179; c=relaxed/simple;
	bh=3gtxQFKzAuKQvxCo4CjSYLdqT8SH8J+LBTt/BJZ54M4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=nw2RBtsGTdLtvX3QSGhHuyaQPxlZjTT4lubk99zZqNw6oSme7FK9dZ0zLVo7qqQhrPbY+8sYAEfjubeOwHmYM0bnCKnYGSa7i6Vi+qzI85S5oJLf6pq2K769PUfFsh/xdbXAEbswzlKgIN7X+vr1L42zRjyR5imzVFc/OiuTjYc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=X/haISnx; arc=fail smtp.client-ip=52.101.69.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gUC4QZNYDxVOYhE6SiHOqrrMFuf60emtvpTCiOJ+wTmkAVu6d1ED89/sM1Cq/zvLmnKJ+O6ObWI9gp9tBKarOAIh1e1HItE4Pym7VxT5FzU0W0V5L7iGzkZdSQQ4S0+M3pPrJEkIVxktWadbeLXGvX811BoSHOrZlYLXuJ2VH4VNhKfbY+TcBklvnYqg538DBmP6ZY2AT6Mc+xVz/eSPga0GL+s7oojwpotZTdRtkFHgp8cyOk/gP2KBT6HgktAMXujsMHlYhMEbnBQR3QXPc6CeByegxS1aOTciC79b/PMJ74vA0kGLt/2kviR3+q/gIhcnPptZp9DHfgQRS1Wkkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=g+Gf8WzkqnnyqsDC/I27+HjQHJ5WlSbPWSsJkvbHZr4=;
 b=ggRikxVt6huXVn6pxbFneeDPH2rhAAQYrEIp/8nUYg0Iej22BDq3FJjjGW0+42DSMwYp/+tCnwDRqHAIz+uQ4royZveBQiOygJkJ53kJlU8DFsimrluG302WzaF9BfWmivasQShlxt8Hl7R5pLviWfkLuVo12gFVBsciOMRT13yYstJl0tBYDbAe1mU7qu0qXiRL/TJFfBgbf+A2NpV2VJCJ3shLCsBRtkJGYFmlDGp1IVsBiEiXU0uZ14HUa3hBwLqdH3kZHUFBTgNxMLmePd2Crdx9aXH6923btAVom2dq0jBdczwvfzWZKE+xJKbUISqA7ExHJB2hlH/aom3tEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g+Gf8WzkqnnyqsDC/I27+HjQHJ5WlSbPWSsJkvbHZr4=;
 b=X/haISnx8pI6kGuXOfRb2eN+TzslpAazA1330Eejp1RjJbSa+v92I4uQWpPzEeKnj9fBvX7PIEpb50R57k4U8wWilRiYqWoWWyhkUkFahUVl/BGXvvUp6VeMCt3webEFG0nsBpxUOuOF6qzYaFioWWT0YOll5Q6lgmMQXlGddfs93d4/fjRRjX4flZjQlT7whjjHtBok0CtfUL1kAg48OJy5z7LfuzYB8autY0Y0rYee1JCDeFo8xw4c1T7NvSIuI0m95ANEHxisr2xg/WIpE+9cgi0iKxwau+pkn6JyfH3LztiuVZYLBWt8ZdGGVX5reNYMH0e7vQF8Rzc1FEo0Uw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PA4PR04MB9366.eurprd04.prod.outlook.com (2603:10a6:102:2a9::8)
 by DB9PR04MB8283.eurprd04.prod.outlook.com (2603:10a6:10:249::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9818.32; Mon, 20 Apr
 2026 08:19:34 +0000
Received: from PA4PR04MB9366.eurprd04.prod.outlook.com
 ([fe80::75e4:8143:ddbc:6588]) by PA4PR04MB9366.eurprd04.prod.outlook.com
 ([fe80::75e4:8143:ddbc:6588%6]) with mapi id 15.20.9818.032; Mon, 20 Apr 2026
 08:19:34 +0000
Date: Mon, 20 Apr 2026 04:19:28 -0400
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
Subject: Re: [PATCH 11/23] dmaengine: sdxi: Add client context alloc and
 release APIs
Message-ID: <aeXhkIZgwGttlJB0@lizhi-Precision-Tower-5810>
References: <20260410-sdxi-base-v1-0-1d184cb5c60a@amd.com>
 <20260410-sdxi-base-v1-11-1d184cb5c60a@amd.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260410-sdxi-base-v1-11-1d184cb5c60a@amd.com>
X-ClientProxiedBy: SA9PR13CA0050.namprd13.prod.outlook.com
 (2603:10b6:806:22::25) To PA4PR04MB9366.eurprd04.prod.outlook.com
 (2603:10a6:102:2a9::8)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR04MB9366:EE_|DB9PR04MB8283:EE_
X-MS-Office365-Filtering-Correlation-Id: 53a30b58-e3a1-4507-a655-08de9eb58e02
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|366016|1800799024|376014|7416014|19092799006|38350700014|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	yl0VRGjk60br8/MtighJE6P8q37CqcSE/0YctH8MV0xxAEabVVvgsH9IHmK/zyFTJLtLOzWEx3npRcxMN51vOwews7UwNzjJatXHdnMnb0OfhcjhIlr4U6Gh1SNwCnCwJIZCq1+5JMhMeTnz2+6y5JigSNtzn3hzlsRe37JvADQP6scnnIpGCpTb0X+ujYwN14ydeT2Oykm9uTZEpz2qpbRp5H05xkX2yKWj4XpjItUC2ypXvvkkaGYK6M7EKS0iZezBcQi+clYeDXcacNTKNYu1bAcDO6qf06oD3YDirpG8jUTHZcGV2rInMpd3hYKPz08rML5C0Ztcy4vqnax75rkBvKgU23VW0L/bqCWQGAN5xHGpaRqJj8WOJnqRvwdf5tpS4q6tUYFXIdjTFh3ZcFQ1RkfbEeOb07RY6lVSTkoPPuddmZpYSItyvkuEEyMwq2vq0xtrApmWwyFwcWT74g4QIZ7eBEsSVqofZXm26qHyYSBpaBrLwDcGvXcvKdGulTQyvk4quivMYF5CrmkAC9kwHEK+lpd1W0WT5TtDNPXK1w2uYbHGdNWOJtKRTCVi6iHt9KC88/4oeqpizsO74ZJTCXQuEml9tk1t4ln4c3fWQbzcbe/n98Zyc1Fu9BUyH9cObRpbn6vPyh9NYF19ABKl0lQXJLWfjL2zQJpv4MiXyPfbxYHrswiEYJbMHODgP7KZVYCoEPwkAVIK03bh3AJifiNkK4Y9MTWxbZ45OoSZ5qQDPfLtaUgEpQ1POVHchGhI9cyoH+yT1kS7aYlsemXvyccVQsOiep/s23cIJqo=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB9366.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(366016)(1800799024)(376014)(7416014)(19092799006)(38350700014)(56012099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?QgaSNXhbFKNBEpr7adhQEVUjJNZpwncsZnT8TE9iVAuxZA1Rwm7+MqiJmRkg?=
 =?us-ascii?Q?WYpv1C+61AdPrkx7ukR4bjD3y5OFaHsxgdgDz9jTIBI/U8cKe7v8pKIbrCbm?=
 =?us-ascii?Q?w41SznQXI23RqXz3E8Ks5drPOgRNK6vkHgEScQr6pcg9vsZVx393n/X91XI+?=
 =?us-ascii?Q?jhv7D6RDiQsy6K/czN9H2/a5TqUaWZd7+tD+MQr5sjAdC7cNcm/QJOGFRPP5?=
 =?us-ascii?Q?/fcqv7fjB5CVBiT7qzIbXsKCheqGtrFbU/fg1MGcugiyUswg2OiYjQnjmxbH?=
 =?us-ascii?Q?O7qcxVf9bQIWvzWiQEsV1EEMTTTXwd26dq4EHNps5yUeGAn1Mz73QHwZhHfy?=
 =?us-ascii?Q?7J7iyqq2Tq5wlFAkVqPbY3wqUDZaIHGSf9mtst1oGu7kqhkPFEDPT6FxOg9F?=
 =?us-ascii?Q?aby1T0PLojLJQQm/Nu5cmRtC3nLvMR15XCjwgLwktRhOzuBFb1YsnOBkxNSv?=
 =?us-ascii?Q?PbcqT3I4ArGFaM91spFcZt243lN9zF0f+bmM3x+WE/Za27jGpzB4x7U9gF08?=
 =?us-ascii?Q?Vz9KjqnMi2Pm6mMAThW1Q4f9pPoZ7RpF2RcukFZsffNWeYIxLynxj/0bLPlC?=
 =?us-ascii?Q?OFekeZ8t+gI+QkfhJl4PFvk5I/dGq0N1pRKN7bvoY87QhaceIQVxbQeBDQ4D?=
 =?us-ascii?Q?h6gP7r1MpI1ovoVmepQ7/gD2nBHq7yL3KbUjUO5BP9fvE+19lPoSuI2bSfHp?=
 =?us-ascii?Q?USP4RtaOFaoTBw3E87dOQR6HaNnixZbIxgYNXPQpzJawZT5U110nCgIorGEF?=
 =?us-ascii?Q?SBImTdF5TvlK3WLl1AZPHrCfrCce9vtNCqiBxlocmLH8NQyk3TFJ2bIvx/iw?=
 =?us-ascii?Q?xzmpXNf/QUG5i2jCxF0CU2KQIk1KPORzATTpA52Ng89/eruFdoA6gmMLET4d?=
 =?us-ascii?Q?VbD2U4u37hBee0zaJRRZuW72XnUNXHbM1hZUvpeAbFRrCXdDfKLG0F0RXdnV?=
 =?us-ascii?Q?x2lHdKUScXBI6n8KIFyN3tpGzEj+3h30ad0CigemyD1o9J7lcWHTC82kwghF?=
 =?us-ascii?Q?MT9Aeidc5RR4zzmwWWwUzKBanwMTvv8ARSF94B0ejQQbSyu4q+kgjIdRwURU?=
 =?us-ascii?Q?VJzgw2EZO+B9YCeOOGt9tHXZ9QbljBKMBJW34N5n6dsT7U7Fca5ZfJJ/mpRd?=
 =?us-ascii?Q?d1bomRCaOAscds0zoek56sTbrWkxD9dzbR6fPoY/hrnBMK3VY6Ei0ae3y4I7?=
 =?us-ascii?Q?6J2QoiUrkLxJDbZaKMvARQXOao7chdNduMx7GuBVU/z8BMqrwwIAcHHBvlok?=
 =?us-ascii?Q?9es2gazeCsZ9E3ybEn5gytDnOXa1t6xgaa1NI+ieAOQhLF5a0o1jCQTMSBEY?=
 =?us-ascii?Q?/wAiiCEPwTiTzN5fTUDbXnalJxzUf8gzILZWyJSbmuehRKdX4WZMA/8DS+LA?=
 =?us-ascii?Q?UhQhq1sogBif2aNHLACn0obIKH26sSQE5h8aTpXNlw4wNmQZZZLtj12oXC/d?=
 =?us-ascii?Q?DhMwGl5ihxZfridmCphrU/3wi3G4Vxny5gWiir6BTfz4l0SeTaHnpMt3AZzc?=
 =?us-ascii?Q?VxokC5/NvI9qrhxiCirwR7tLGyjIe3x34BbiNm8IKSFg1fG2njJb5aCRUodv?=
 =?us-ascii?Q?Bk6eu6MvvrFitJwl771bQ8L11SZp6iCBhjWKPQNEEMqHr+gx2EoUjgrDsYuw?=
 =?us-ascii?Q?wLUeWGLZ9yKwxk2qOVUto1hyKD1hXkZog7nwANNFc5iwkT4Nj31qu1ECKGQG?=
 =?us-ascii?Q?qk3H+7UeKKE4tH16Nzoi8CrqhQabdgd2JcvSGf+vWakzr40a?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 53a30b58-e3a1-4507-a655-08de9eb58e02
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB9366.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Apr 2026 08:19:34.3606
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OxBAg6KUfBOclKmy2HXrIhgi9lQjAgH2GjrPfoZCzcd6lVqbfbXo41qVxPtnZkjg0c0zLQXwda84hpCFP5VBFA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB8283
X-Spamd-Result: default: False [0.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nxp.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[nxp.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-10042-lists,dmaengine=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[dmaengine];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[amd.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,slot.id:url,nxp.com:dkim]
X-Rspamd-Queue-Id: DCD52428128
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri, Apr 10, 2026 at 08:07:21AM -0500, Nathan Lynch wrote:
> Expose sdxi_cxt_new() and sdxi_cxt_exit(), which are the rest of the
> driver's entry points to creating and releasing SDXI contexts.
>
> Track client contexts in a device-wide allocating xarray, mapping
> context ID to the context object. The admin context always has ID 0,
> so begin allocations at 1. Define a local class for ID allocation to
> facilitate automatic release of an ID if an error is encountered when
> "publishing" a context to the L1 table.
>
> Introduce new code to invalidate a context's entry in the L1 table on
> deallocation.
>
> Support for starting and stopping contexts will be added in changes to
> follow.
>
> The only expected user of sdxi_cxt_new() and sdxi_cxt_exit() at this
> point is the DMA engine provider code where a client context per
> channel will be created.
>
> Co-developed-by: Wei Huang <wei.huang2@amd.com>
> Signed-off-by: Wei Huang <wei.huang2@amd.com>
> Signed-off-by: Nathan Lynch <nathan.lynch@amd.com>
> ---
>  drivers/dma/sdxi/context.c | 111 +++++++++++++++++++++++++++++++++++++++++++++
>  drivers/dma/sdxi/context.h |  13 ++++++
>  drivers/dma/sdxi/device.c  |   8 ++++
>  drivers/dma/sdxi/sdxi.h    |   2 +
>  4 files changed, 134 insertions(+)
>
> diff --git a/drivers/dma/sdxi/context.c b/drivers/dma/sdxi/context.c
> index 934c487b4774..7cae140c0a20 100644
> --- a/drivers/dma/sdxi/context.c
> +++ b/drivers/dma/sdxi/context.c
> @@ -155,6 +155,16 @@ static int configure_cxt_ctl(struct sdxi_cxt_ctl *ctl, const struct sdxi_cxt_ctl
>  	return 0;
>  }
>
> +static void invalidate_cxtl_ctl(struct sdxi_cxt_ctl *ctl)
> +{
> +	u64 ds_ring_ptr = le64_to_cpu(ctl->ds_ring_ptr);
> +
> +	FIELD_MODIFY(SDXI_CXT_CTL_VL, &ds_ring_ptr, 0);
> +	WRITE_ONCE(ctl->ds_ring_ptr, cpu_to_le64(ds_ring_ptr));
> +	dma_wmb();
> +	*ctl = (typeof(*ctl)) { 0 };
> +}
> +
>  /*
>   * Logical representation of CXT_L1_ENT subfields.
>   */
> @@ -209,6 +219,16 @@ static int configure_L1_entry(struct sdxi_cxt_L1_ent *ent,
>  	return 0;
>  }
>
> +static void invalidate_L1_entry(struct sdxi_cxt_L1_ent *ent)
> +{
> +	u64 cxt_ctl_ptr = le64_to_cpu(ent->cxt_ctl_ptr);
> +
> +	FIELD_MODIFY(SDXI_CXT_L1_ENT_VL, &cxt_ctl_ptr, 0);
> +	WRITE_ONCE(ent->cxt_ctl_ptr, cpu_to_le64(cxt_ctl_ptr));
> +	dma_wmb();
> +	*ent = (typeof(*ent)) { 0 };
> +}
> +
>  /*
>   * Make the context control structure hierarchy valid from the POV of
>   * the SDXI implementation. This may eventually involve allocation of
> @@ -259,6 +279,17 @@ static int sdxi_publish_cxt(const struct sdxi_cxt *cxt)
>  	/* todo: need to send DSC_CXT_UPD to admin */
>  }
>
> +/* Invalidate a context. */
> +static void sdxi_rescind_cxt(struct sdxi_cxt *cxt)
> +{
> +	u8 l1_idx = ID_TO_L1_INDEX(cxt->id);
> +	struct sdxi_cxt_L1_ent *ent = &cxt->sdxi->L1_table->entry[l1_idx];
> +
> +	invalidate_L1_entry(ent);
> +	invalidate_cxtl_ctl(cxt->cxt_ctl);
> +	/* todo: need to send DSC_CXT_UPD to admin */
> +}
> +
>  void sdxi_cxt_push_doorbell(struct sdxi_cxt *cxt, u64 index)
>  {
>  	/* Ensure preceding write index increment is visible. */
> @@ -266,6 +297,61 @@ void sdxi_cxt_push_doorbell(struct sdxi_cxt *cxt, u64 index)
>  	iowrite64(index, cxt->db);
>  }
>
> +/* Enable automatic cleanup of an allocated context ID */
> +struct __class_sdxi_cxt_id {
> +	struct sdxi_dev *sdxi;
> +	s32 id;
> +};
> +
> +#define sdxi_cxt_id_null ((struct __class_sdxi_cxt_id){ NULL, -1 })
> +#define take_sdxi_cxt_id(x) __get_and_null(x, sdxi_cxt_id_null)
> +
> +DEFINE_CLASS(sdxi_alloc_cxt_id, struct __class_sdxi_cxt_id,
> +	if (_T.id >= 0)
> +		xa_erase(&_T.sdxi->client_cxts, _T.id),
> +	((struct __class_sdxi_cxt_id){
> +		.sdxi = sdxi,
> +		.id = ({
> +			struct xa_limit limit = XA_LIMIT(1, sdxi->max_cxtid);
> +			u32 id;
> +			int err = xa_alloc(&sdxi->client_cxts, &id, cxt,
> +					   limit, GFP_KERNEL);
> +			err ? err : id;
> +		}),
> +	}),
> +	struct sdxi_dev *sdxi, struct sdxi_cxt *cxt)
> +
> +/*
> + * Allocate the context ID; link the context back to the device;
> + * perform some final initialization of the context based on the ID
> + * allocated; update the context tables.
> + */
> +static int register_cxt(struct sdxi_dev *sdxi, struct sdxi_cxt *cxt)
> +{
> +	int err;
> +
> +	CLASS(sdxi_alloc_cxt_id, slot)(sdxi, cxt);
> +	if (slot.id < 0)
> +		return slot.id;

I like use cleanup to do this. define error macro, like cleanup.h

 *      ACQUIRE(pci_dev_try, lock)(dev);
 *      rc = ACQUIRE_ERR(pci_dev_try, &lock);

so hidden detail "id" in sdxi_alloc_cxt_id.

Or you can refer runtime pm method, save necceary information to "cxt"

DEFINE_GUARD_COND(pm_runtime_active, _try,
		  pm_runtime_get_active(_T, RPM_TRANSPARENT), _RET == 0)

> +
> +	cxt->sdxi = sdxi;
> +	cxt->id = slot.id;
> +	cxt->db = sdxi->dbs + slot.id * sdxi->db_stride;
> +
> +	err = sdxi_publish_cxt(cxt);
> +	if (err)
> +		return err;
> +
> +	take_sdxi_cxt_id(slot);

I undestand try to keep id to avoid call xa_erase. but it hidden too much
detail.

If only one error branch, using cleanup here have not bring too much beneafit.


Idealy logic

	id = __free(your_xa_erase) your_xa_alloc()
	...
	ctx->id = no_free_ptr(id).

Frank
> +	return 0;
> +}
> +
> +static void unregister_cxt(struct sdxi_cxt *cxt)
> +{
> +	sdxi_rescind_cxt(cxt);
> +	xa_erase(&cxt->sdxi->client_cxts, cxt->id);
> +}
> +
>  static void free_admin_cxt(void *ptr)
>  {
>  	struct sdxi_dev *sdxi = ptr;
> @@ -296,3 +382,28 @@ int sdxi_admin_cxt_init(struct sdxi_dev *sdxi)
>
>  	return devm_add_action_or_reset(sdxi_to_dev(sdxi), free_admin_cxt, sdxi);
>  }
> +
> +/*
> + * Allocate a context for in-kernel use. Starting the context is the
> + * caller's responsibility.
> + */
> +struct sdxi_cxt *sdxi_cxt_new(struct sdxi_dev *sdxi)
> +{
> +	struct sdxi_cxt *cxt __free(sdxi_cxt) = sdxi_alloc_cxt(sdxi);
> +	if (!cxt)
> +		return NULL;
> +
> +	if (register_cxt(sdxi, cxt))
> +		return NULL;
> +
> +	return_ptr(cxt);
> +}
> +
> +void sdxi_cxt_exit(struct sdxi_cxt *cxt)
> +{
> +	if (WARN_ON(sdxi_cxt_is_admin(cxt)))
> +		return;
> +
> +	unregister_cxt(cxt);
> +	sdxi_free_cxt(cxt);
> +}
> diff --git a/drivers/dma/sdxi/context.h b/drivers/dma/sdxi/context.h
> index c34acd730acb..5cd78e883c8d 100644
> --- a/drivers/dma/sdxi/context.h
> +++ b/drivers/dma/sdxi/context.h
> @@ -58,6 +58,19 @@ struct sdxi_cxt {
>
>  int sdxi_admin_cxt_init(struct sdxi_dev *sdxi);
>
> +struct sdxi_cxt *sdxi_cxt_new(struct sdxi_dev *sdxi);
> +void sdxi_cxt_exit(struct sdxi_cxt *cxt);
> +
> +static inline struct sdxi_cxt *to_admin_cxt(const struct sdxi_cxt *cxt)
> +{
> +	return cxt->sdxi->admin_cxt;
> +}
> +
> +static inline bool sdxi_cxt_is_admin(const struct sdxi_cxt *cxt)
> +{
> +	return cxt == to_admin_cxt(cxt);
> +}
> +
>  void sdxi_cxt_push_doorbell(struct sdxi_cxt *cxt, u64 index);
>
>  #endif /* DMA_SDXI_CONTEXT_H */
> diff --git a/drivers/dma/sdxi/device.c b/drivers/dma/sdxi/device.c
> index 15f61d1ce490..aaff6b15325a 100644
> --- a/drivers/dma/sdxi/device.c
> +++ b/drivers/dma/sdxi/device.c
> @@ -12,6 +12,7 @@
>  #include <linux/dmapool.h>
>  #include <linux/log2.h>
>  #include <linux/slab.h>
> +#include <linux/xarray.h>
>
>  #include "context.h"
>  #include "hw.h"
> @@ -302,6 +303,7 @@ int sdxi_register(struct device *dev, const struct sdxi_bus_ops *ops)
>
>  	sdxi->dev = dev;
>  	sdxi->bus_ops = ops;
> +	xa_init_flags(&sdxi->client_cxts, XA_FLAGS_ALLOC1);
>  	dev_set_drvdata(dev, sdxi);
>
>  	err = sdxi->bus_ops->init(sdxi);
> @@ -314,6 +316,12 @@ int sdxi_register(struct device *dev, const struct sdxi_bus_ops *ops)
>  void sdxi_unregister(struct device *dev)
>  {
>  	struct sdxi_dev *sdxi = dev_get_drvdata(dev);
> +	struct sdxi_cxt *cxt;
> +	unsigned long index;
> +
> +	xa_for_each(&sdxi->client_cxts, index, cxt)
> +		sdxi_cxt_exit(cxt);
> +	xa_destroy(&sdxi->client_cxts);
>
>  	sdxi_dev_stop(sdxi);
>  }
> diff --git a/drivers/dma/sdxi/sdxi.h b/drivers/dma/sdxi/sdxi.h
> index 426101875334..da33719735ab 100644
> --- a/drivers/dma/sdxi/sdxi.h
> +++ b/drivers/dma/sdxi/sdxi.h
> @@ -12,6 +12,7 @@
>  #include <linux/dev_printk.h>
>  #include <linux/io-64-nonatomic-lo-hi.h>
>  #include <linux/types.h>
> +#include <linux/xarray.h>
>
>  #include "mmio.h"
>
> @@ -61,6 +62,7 @@ struct sdxi_dev {
>  	struct dma_pool *cst_blk_pool;
>
>  	struct sdxi_cxt *admin_cxt;
> +	struct xarray client_cxts; /* context id -> (struct sdxi_cxt *) */
>
>  	const struct sdxi_bus_ops *bus_ops;
>  };
>
> --
> 2.53.0
>

