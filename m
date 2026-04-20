Return-Path: <dmaengine+bounces-10048-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QIlMIaLp5WnxpAEAu9opvQ
	(envelope-from <dmaengine+bounces-10048-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Mon, 20 Apr 2026 10:53:54 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 0226A428846
	for <lists+dmaengine@lfdr.de>; Mon, 20 Apr 2026 10:53:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EA3223015C88
	for <lists+dmaengine@lfdr.de>; Mon, 20 Apr 2026 08:48:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6644A38911F;
	Mon, 20 Apr 2026 08:48:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="nXlSl03R"
X-Original-To: dmaengine@vger.kernel.org
Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazon11013071.outbound.protection.outlook.com [52.101.83.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D5903859D6;
	Mon, 20 Apr 2026 08:48:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.83.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776674898; cv=fail; b=JgaiuW5IT2S5/MR0j8Fw3ASuyx/gSAWTgc7Jo9yGHhhw9O5Y6VOLMC/NX9LIramknI72FfyjZmR+i8u0drmn1qIOhohNLLDEo+2a/HJ0qWpNcCAJb4W3bNHSmiJ/TB6YhagFi1lVZZ6NG+v+QFZqb0JViTKaFy5oyhxGZIi8e1s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776674898; c=relaxed/simple;
	bh=HV3IWtGk63aF+/Tu5iG4bOKwoR7WEr2D/goQQoKy/q0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Zf1lKEorx7mKTlLq69mO6k/u7ZtkuqEMo4W5/ZeQFF8vk8xvWCiJCJ6B2CkMSS+bkTepHMr6rwd1Hvdlfu0w8yBxnBELoWYsjSk4NJz17I7wqn+IqC8FKCYuN5k5Ohy5WGjG4DsIJLg5tblX5jOyxcDF5SpXZEIMnfvrdv703Eg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=nXlSl03R; arc=fail smtp.client-ip=52.101.83.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZB7iuiXmyMdiyXp1w+XKxuEUoybTwGdFizx2EqMDVbiOFWZby3i8Kdi0XxCLc3xFUL/v8dZm2hQa4K37l2o01gTyx17rGftJIRnJXY8uZkv4q3dB0nVtahwk0V7P4RRkTYyj2ZyZZ5lXyIc+GXi0pDWibFQULqt1xhMTHPCqNoL2fnfOqJPyqRBUo1LvZboIUhqFusAtocehRXc7Sto/R8AzN1Q1yWyPKqY8IA70xAYgLXB7crQzig4DqvFD5dcVOfmyEZFJjQXinQvtsxiBaVm40DQEoG9CrRVk0mlsXnCrW9ljrV+2u/hF8Kkwinn1eYKqU1z9Sgumcec2Xe1e9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ibBjq3GC14uD5houFzHZ7vCTmz9l00Uc5CcsPUsu3p0=;
 b=mk+jvdZh2vstNyeeaPcK8nhqjcnTE3tOh2fYFfDl22oK9x6f20VT+sABNdegsgDoRfKzF9WSRxwNewzoKTnwdCeYerlQpgN+mMEzbXd+a/WZdoCO0vABZ4dfh7xs/ZraTg+EkaeJacBMo3w40jO4qnPzWWjFgrz64b0kGnmTkXtp4Ed42WLQYGvcSnSAhQ+8KPciD94X2ztRmVJtuU1G31U5uCZUDzdsOBt1JYw7F9NExDCIlmMjV/NA4KdiuQMdVOErkAf6ErfTrShUSmVPcyn4k9XzCee6EwQHxVVbdClAzTLVo96I2z85ERW0Kmka7lkwG/7W5VIvxFLGYfCXVQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ibBjq3GC14uD5houFzHZ7vCTmz9l00Uc5CcsPUsu3p0=;
 b=nXlSl03RHxF/ZhLQdSuiUbIdqLtb2uCi6IWrawnnaCqgq3QsVHkJYjpJ3fv2fRuGTp66/RP3Lxe5EDflx+LjBhMlcSIpK1Bb15glDdPhrHszItC4ffO6c07oTvPoPxxRWUVHPec93ZRJkB3wn3co8RioygCQjk3sh9NxaiqRNJPGAUB3MXJCP51+cERiEdOPxn6ygY4GPIa0cNxitJJ63FSjP7uXXr/I+wyiE7jX2k0EjAxoL/poRymqG/PDAwT0CMxjaE1HKULxIHM8F+pIk4sjMUMLnpPS/WByt7hRxPAGna/EB5u7Nfr3DpIO49iwI3XGFMS5aDB14EyzrQ59KA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PA4PR04MB9366.eurprd04.prod.outlook.com (2603:10a6:102:2a9::8)
 by AS8PR04MB9143.eurprd04.prod.outlook.com (2603:10a6:20b:44a::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9818.32; Mon, 20 Apr
 2026 08:48:11 +0000
Received: from PA4PR04MB9366.eurprd04.prod.outlook.com
 ([fe80::75e4:8143:ddbc:6588]) by PA4PR04MB9366.eurprd04.prod.outlook.com
 ([fe80::75e4:8143:ddbc:6588%6]) with mapi id 15.20.9818.032; Mon, 20 Apr 2026
 08:48:11 +0000
Date: Mon, 20 Apr 2026 04:48:05 -0400
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
Subject: Re: [PATCH 18/23] dmaengine: sdxi: Encode context start, stop, and
 sync descriptors
Message-ID: <aeXoRQISDAuG_RxF@lizhi-Precision-Tower-5810>
References: <20260410-sdxi-base-v1-0-1d184cb5c60a@amd.com>
 <20260410-sdxi-base-v1-18-1d184cb5c60a@amd.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260410-sdxi-base-v1-18-1d184cb5c60a@amd.com>
X-ClientProxiedBy: SA0PR11CA0158.namprd11.prod.outlook.com
 (2603:10b6:806:1bb::13) To PA4PR04MB9366.eurprd04.prod.outlook.com
 (2603:10a6:102:2a9::8)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR04MB9366:EE_|AS8PR04MB9143:EE_
X-MS-Office365-Filtering-Correlation-Id: 661e199d-e1ef-4b1a-4558-08de9eb98db5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|7416014|52116014|19092799006|38350700014|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	RBE0BESV3nquCslFNl1CV/Z3kztUPA49l2o5pbaWB6gQu+R4K9+BOhkG2EgxL8IfFL/6otaKn/Dr5E8ZoBuGwsHuyD6SVwYlc6lZg2eaJXEJnRU335/i+DmpYQutx9jcjMZtAJv5RFXU3OUQQRoNdiN8xd3LfKax3q0xBiys1JVyXYGFvwd/K7ccc+vqLVjfGLizObWpQ+KTm1VzwEA5K49MfqLCLQq0TdRbI3dNMTLUj2n6cVX1bBDv1lzB2YfxnSZzyC1G90x4vn6MVSjMPV+Ll76x++QoimkrBa+zSUxgYV7Znk7CP1Vpz3jCVReqIJ6JlaQ1bRwxerd74+aP9rqrrhBOvmmRTvoyPgEgDNtKfZ35LXnXZeeSr56A22grUSOov1WDGs4SHQTrEOy7XYcTZ4gzW/GkHxjMUC6qx0WoKJe80Brcmx/0Qdj7+jV/t3tcAYLFC4YDWJuGkjr4FbzYpiwCH11z8ULxMSgkHTJaU6fQn7kto65ZUmx4Cm7W6RPeDgYtW9MQfaHu1nd+yYiHol7HfsYQZSgb255Jtd+vGt8TxLjDOChPjlzVpDRdRjMfkAt0Lr5QbEoe1CQXB3uNz4kphd7hT5zWf2ONgKH/yqpibhvTwk/Hu+dM3x3ZW9kQVsMoG2ZimlR7VQBrKVQYqdVdcoi9MiBQCwr/ykH3CrmMSi/8HCRee+me6/VvE1nAzcCRmMxURTXSMhnsy3xTE0jxADuOwpXzSi0/0eIq0v9+HGPhMeDrMnxpQYC8xe+xX7GtqMPBAvnjISTkebP3eZq2zLDWGY1g8C+fp0w=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB9366.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(52116014)(19092799006)(38350700014)(56012099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?K7k55B2SqItRthSzAsfJI1bSsUTm2QchOXFYxdjVgg10bxpBNLSDDaLIReQ5?=
 =?us-ascii?Q?mlqNARXJ2rCgODAvUJcKS8T0qGQDhayQPeQHtVXn9odi6D5tka8LwUwYpdC1?=
 =?us-ascii?Q?AKMVutESIjIQ622slpba2wkbweGjneRduaedx4Y5B7WnXDyQ5Un4OPwKIVYT?=
 =?us-ascii?Q?qItSHsTaFIbuJGIcUNrCrTR7I3IgwqFn7rD0tmKrls8p13xWNC2m74mofAN7?=
 =?us-ascii?Q?AeehI69InYEytRszKYRnU4Z+MoYxoVIs8ZDCtnNSSnN8A6teZU19f70EPhf4?=
 =?us-ascii?Q?3nvw3c6G8PqIN+jdyseLQdSXxb+bxxUy3KxhriOygRqN4WpiuUH7SqEwsoJW?=
 =?us-ascii?Q?AaQYe/LMmPrGr87iyk/7nX3mxALYK8SGdRvke2PtOXYt6l6nbr3JK1zQMdTN?=
 =?us-ascii?Q?72WcUfH7BIVua6u4ido1Dc89q/qpOA6Dh1wIrGt6QVZXM557axd+DYMgjOiB?=
 =?us-ascii?Q?lk3moC9m3iCe+N5bM6rQ8xGfuXSvsqxEAJa71EmR7nBU1CGZYwBH3CjL/tBN?=
 =?us-ascii?Q?VKyZPgWwKJlo3doNVG+SJe0RyWyrysMYuN/eTdI4KEarJ00xGNe6LJpbjceC?=
 =?us-ascii?Q?N3wZWaHegDzZofoycMaJApt+dZyW/0IpYMGrdlGVV2OS0VklTFy/XQmwfocs?=
 =?us-ascii?Q?MLi+2Sk5DK8w7BgVZABS6oBkPHLEicCcXBANKqx/jGc8ITmIlVT4fj8Smfwo?=
 =?us-ascii?Q?2Znqqj9Yaq7y4eiOKhZJoR9oJtrlVB1Qxy3Vd3IOau/Z4SaKzYTZzEtvMZHD?=
 =?us-ascii?Q?H46xeQJSNN6NzWoigCAnrJzlGohCV4fw0AhGFgq8GUXf3y4ptvPdVBYM9l+5?=
 =?us-ascii?Q?86cFJ3KYDcrIZadP4jOhz8g1j9vbejz6E8aHliUkxv7fvmgdkA2TPhvKuDWE?=
 =?us-ascii?Q?O1/ZTxEPDa+VU532p8LwSfL0b72IKvTe0J3+xvYx5kcqET+dslaki7wNrmyW?=
 =?us-ascii?Q?XyXrPIEMKDZEnfqp6CfBiripxh/w3VnGh1Mkv8JaMBmCZFHhJDbzMt2OlAnc?=
 =?us-ascii?Q?17QvY68N2+F5RZpzLIMgajwK/LKUo75U6MWRfh7YykHujboldOaM3+7hz+8z?=
 =?us-ascii?Q?j+wXjW34KW/pdpLH/x7te2pI8M/oe8b9QS/MP/7SzHC0mejg7/np6OoLY23M?=
 =?us-ascii?Q?ck2GCRZUW74OrlgrJuBuOI6r9bYvWSeYCf8NbBnlHdWw2zJXNWo+Wqxfjffg?=
 =?us-ascii?Q?YZ4vBGXtgNb0U5hugXgbLPu2T6XzdAZ6B3n6z1GpyLbfXrO9IQfSXODXuwKM?=
 =?us-ascii?Q?QK4GudosLhQLm00oCiUn8fW8sOjK2HpWdDbV915jwlg4OqqTb1SI8fRyKfVU?=
 =?us-ascii?Q?HEtQy7F+OEE3m3mdY+bGMIOJufON+Imqtnpa7s9IVMpDUvJrgqaSTG3hoYiW?=
 =?us-ascii?Q?f7Td8w5hNHqs5OkgubNB2l+zwBtVecwQHiftYomUU3mi4s6YpscS0GLlrVz+?=
 =?us-ascii?Q?6KwRQvyB3L5LJRLPPjF+Z9A4zIPdDV0GkmPTJXXc361TC0v7TCPQ73EMyqij?=
 =?us-ascii?Q?kOy/t2t/UzXLDbfA4EkgPwMSy0FfBac3Iaq/kUQW6Wd/x0Tg9BLPRCdF3LXv?=
 =?us-ascii?Q?F6kk/TbBDv+dDg8z1vN1qC263ROSTzCBQ8KGsy8oOxCJslExMXI6+E518Ixb?=
 =?us-ascii?Q?K91/98VA6naFRGcGYLYMtXjOCeHHRWBgrPt2+brIrH80vyZtPQwgqMd3lPfJ?=
 =?us-ascii?Q?KtbR1Y/a/MNmeiEkZrn6LCy5qZfjQVp77TyDEG3cPB6EU1tp?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 661e199d-e1ef-4b1a-4558-08de9eb98db5
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB9366.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Apr 2026 08:48:11.7930
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eM3a8DLXBoT9yBQ3sL8zq/ywH9X7Kur81As27c86KWAmgA44zOpwPem4i8/3WLossxvPM6lqDYdEa533dhYe7Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB9143
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
	TAGGED_FROM(0.00)[bounces-10048-lists,dmaengine=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[amd.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,nxp.com:dkim,nxp.com:email]
X-Rspamd-Queue-Id: 0226A428846
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri, Apr 10, 2026 at 08:07:28AM -0500, Nathan Lynch wrote:
> Introduce the low-level support for serializing three operation types
> to the descriptor ring of the admin context: context start, context
> stop, and sync. Each operation has its own distinct type that overlays
> the generic struct sdxi_desc, along with a dedicated encoder function
> that accepts an operation-specific parameter struct.
>
> The parameter structs (sdxi_cxt_start, sdxi_cxt_stop, sdxi_sync)
> expose only a necessary subset of the available descriptor fields to
> callers, i.e. the target context range. These can be expanded over
> time as needed.
>
> Each encoder function is intended to 1) set any mandatory field values
> for the descriptor type (e.g. SDXI_DSC_FE=1 for context start); and 2)
> translate conventional kernel types (dma_addr_t, CPU-endian values)
> from the parameter block to the descriptor in memory. While they're
> expected to operate directly on descriptor ring memory, they do not
> set the descriptor validity bit. That is left to the caller, which may
> need to make other modifictions to the descriptor, such as attaching a
> completion block, before releasing it to the SDXI implementation.
>
> Co-developed-by: Wei Huang <wei.huang2@amd.com>
> Signed-off-by: Wei Huang <wei.huang2@amd.com>
> Signed-off-by: Nathan Lynch <nathan.lynch@amd.com>
> ---

Reviewed-by: Frank Li <Frank.Li@nxp.com>

>  drivers/dma/sdxi/Makefile     |  1 +
>  drivers/dma/sdxi/descriptor.c | 91 +++++++++++++++++++++++++++++++++++++++++++
>  drivers/dma/sdxi/descriptor.h | 46 ++++++++++++++++++++++
>  drivers/dma/sdxi/hw.h         | 64 ++++++++++++++++++++++++++++++
>  4 files changed, 202 insertions(+)
>
> diff --git a/drivers/dma/sdxi/Makefile b/drivers/dma/sdxi/Makefile
> index dd08f4a5f723..08dd73a45dc7 100644
> --- a/drivers/dma/sdxi/Makefile
> +++ b/drivers/dma/sdxi/Makefile
> @@ -4,6 +4,7 @@ obj-$(CONFIG_SDXI) += sdxi.o
>  sdxi-objs += \
>  	completion.o  \
>  	context.o     \
> +	descriptor.o  \
>  	device.o      \
>  	ring.o
>
> diff --git a/drivers/dma/sdxi/descriptor.c b/drivers/dma/sdxi/descriptor.c
> new file mode 100644
> index 000000000000..be2a9244ce19
> --- /dev/null
> +++ b/drivers/dma/sdxi/descriptor.c
> @@ -0,0 +1,91 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * SDXI descriptor encoding.
> + *
> + * Copyright Advanced Micro Devices, Inc.
> + */
> +
> +#include <kunit/visibility.h>
> +#include <linux/bitfield.h>
> +#include <linux/types.h>
> +#include <asm/byteorder.h>
> +
> +#include "hw.h"
> +#include "descriptor.h"
> +
> +int sdxi_encode_cxt_start(struct sdxi_desc *desc,
> +			  const struct sdxi_cxt_start *params)
> +{
> +	u64 csb_ptr;
> +	u32 opcode;
> +
> +	opcode = (FIELD_PREP(SDXI_DSC_FE, 1) |
> +		  FIELD_PREP(SDXI_DSC_SUBTYPE, SDXI_DSC_OP_SUBTYPE_CXT_START_NM) |
> +		  FIELD_PREP(SDXI_DSC_TYPE, SDXI_DSC_OP_TYPE_ADMIN));
> +
> +	csb_ptr = FIELD_PREP(SDXI_DSC_NP, 1);
> +
> +	*desc = (typeof(*desc)) {
> +		.cxt_start = (typeof(desc->cxt_start)) {
> +			.opcode = cpu_to_le32(opcode),
> +			.cxt_start = cpu_to_le16(params->range.cxt_start),
> +			.cxt_end = cpu_to_le16(params->range.cxt_end),
> +			.csb_ptr = cpu_to_le64(csb_ptr),
> +		},
> +	};
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL_IF_KUNIT(sdxi_encode_cxt_start);
> +
> +int sdxi_encode_cxt_stop(struct sdxi_desc *desc,
> +			  const struct sdxi_cxt_stop *params)
> +{
> +	u64 csb_ptr;
> +	u32 opcode;
> +
> +	opcode = (FIELD_PREP(SDXI_DSC_FE, 1) |
> +		  FIELD_PREP(SDXI_DSC_SUBTYPE, SDXI_DSC_OP_SUBTYPE_CXT_STOP) |
> +		  FIELD_PREP(SDXI_DSC_TYPE, SDXI_DSC_OP_TYPE_ADMIN));
> +
> +	csb_ptr = FIELD_PREP(SDXI_DSC_NP, 1);
> +
> +	*desc = (typeof(*desc)) {
> +		.cxt_stop = (typeof(desc->cxt_stop)) {
> +			.opcode = cpu_to_le32(opcode),
> +			.cxt_start = cpu_to_le16(params->range.cxt_start),
> +			.cxt_end = cpu_to_le16(params->range.cxt_end),
> +			.csb_ptr = cpu_to_le64(csb_ptr),
> +		},
> +	};
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL_IF_KUNIT(sdxi_encode_cxt_stop);
> +
> +int sdxi_encode_sync(struct sdxi_desc *desc, const struct sdxi_sync *params)
> +{
> +	u64 csb_ptr;
> +	u32 opcode;
> +	u8 cflags;
> +
> +	opcode = (FIELD_PREP(SDXI_DSC_SUBTYPE, SDXI_DSC_OP_SUBTYPE_SYNC) |
> +		  FIELD_PREP(SDXI_DSC_TYPE, SDXI_DSC_OP_TYPE_ADMIN));
> +
> +	cflags = FIELD_PREP(SDXI_DSC_SYNC_FLT, params->filter);
> +
> +	csb_ptr = FIELD_PREP(SDXI_DSC_NP, 1);
> +
> +	*desc = (typeof(*desc)) {
> +		.sync = (typeof(desc->sync)) {
> +			.opcode = cpu_to_le32(opcode),
> +			.cflags = cflags,
> +			.cxt_start = cpu_to_le16(params->range.cxt_start),
> +			.cxt_end = cpu_to_le16(params->range.cxt_end),
> +			.csb_ptr = cpu_to_le64(csb_ptr),
> +		},
> +	};
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL_IF_KUNIT(sdxi_encode_sync);
> diff --git a/drivers/dma/sdxi/descriptor.h b/drivers/dma/sdxi/descriptor.h
> index c0f01b1be726..5b8fd7cbaa03 100644
> --- a/drivers/dma/sdxi/descriptor.h
> +++ b/drivers/dma/sdxi/descriptor.h
> @@ -9,6 +9,7 @@
>   */
>
>  #include <linux/bitfield.h>
> +#include <linux/minmax.h>
>  #include <linux/ratelimit.h>
>  #include <linux/types.h>
>  #include <asm/byteorder.h>
> @@ -61,4 +62,49 @@ static inline void sdxi_desc_set_sequential(struct sdxi_desc *desc)
>  	desc->opcode = cpu_to_le32(opcode);
>  }
>
> +struct sdxi_cxt_range {
> +	u16 cxt_start;
> +	u16 cxt_end;
> +};
> +
> +static inline struct sdxi_cxt_range sdxi_cxt_range(u16 a, u16 b)
> +{
> +	return (struct sdxi_cxt_range) {
> +		.cxt_start = min(a, b),
> +		.cxt_end   = max(a, b),
> +	};
> +}
> +
> +static inline struct sdxi_cxt_range sdxi_cxt_range_single(u16 nr)
> +{
> +	return sdxi_cxt_range(nr, nr);
> +}
> +
> +struct sdxi_cxt_start {
> +	struct sdxi_cxt_range range;
> +};
> +
> +int sdxi_encode_cxt_start(struct sdxi_desc *desc,
> +			  const struct sdxi_cxt_start *params);
> +
> +struct sdxi_cxt_stop {
> +	struct sdxi_cxt_range range;
> +};
> +
> +int sdxi_encode_cxt_stop(struct sdxi_desc *desc,
> +			  const struct sdxi_cxt_stop *params);
> +
> +struct sdxi_sync {
> +	enum sdxi_sync_filter  {
> +		SDXI_SYNC_FLT_CXT  = 0x0,
> +		SDXI_SYNC_FLT_STOP = 0x1,
> +		SDXI_SYNC_FLT_AKEY = 0x2,
> +		SDXI_SYNC_FLT_RKEY = 0x3,
> +		SDXI_SYNC_FLT_FN   = 0x4,
> +	} filter;
> +	struct sdxi_cxt_range range;
> +};
> +
> +int sdxi_encode_sync(struct sdxi_desc *desc, const struct sdxi_sync *params);
> +
>  #endif /* DMA_SDXI_DESCRIPTOR_H */
> diff --git a/drivers/dma/sdxi/hw.h b/drivers/dma/sdxi/hw.h
> index 178161588bd0..4dcd0a3ff0fd 100644
> --- a/drivers/dma/sdxi/hw.h
> +++ b/drivers/dma/sdxi/hw.h
> @@ -146,12 +146,76 @@ struct sdxi_desc {
>  #define SDXI_DSC_VL  BIT(0)
>  #define SDXI_DSC_SE  BIT(1)
>  #define SDXI_DSC_FE  BIT(2)
> +#define SDXI_DSC_SUBTYPE GENMASK(15, 8)
> +#define SDXI_DSC_TYPE    GENMASK(26, 16)
>
>  /* For csb_ptr field */
> +#define SDXI_DSC_NP BIT_ULL(0)
>  #define SDXI_DSC_CSB_PTR GENMASK_ULL(63, 5)
>
> +#define define_sdxi_dsc(tag_, name_, op_body_)				\
> +	struct tag_ {							\
> +		__le32 opcode;						\
> +		op_body_						\
> +		__le64 csb_ptr;						\
> +	} __packed name_;						\
> +	static_assert(sizeof(struct tag_) ==				\
> +		      sizeof(struct sdxi_dsc_generic));			\
> +	static_assert(offsetof(struct tag_, csb_ptr) ==			\
> +		      offsetof(struct sdxi_dsc_generic, csb_ptr))
> +
> +		/* SDXI 1.0 Table 6-14: DSC_CXT_START Descriptor Format */
> +		define_sdxi_dsc(sdxi_dsc_cxt_start, cxt_start,
> +			__u8 rsvd_0;
> +			__u8 vflags;
> +			__le16 vf_num;
> +			__le16 cxt_start;
> +			__le16 cxt_end;
> +			__u8 rsvd_1[4];
> +			__le64 db_value;
> +			__u8 rsvd_2[32];
> +		);
> +
> +		/* SDXI 1.0 Table 6-15: DSC_CXT_STOP Descriptor Format */
> +		define_sdxi_dsc(sdxi_dsc_cxt_stop, cxt_stop,
> +			__u8 rsvd_0;
> +			__u8 vflags;
> +			__le16 vf_num;
> +			__le16 cxt_start;
> +			__le16 cxt_end;
> +			__u8 rsvd_1[44];
> +		);
> +
> +		/* SDXI 1.0 Table 6-22: DSC_SYNC Descriptor Format */
> +		define_sdxi_dsc(sdxi_dsc_sync, sync,
> +			__u8 cflags;
> +			__u8 vflags;
> +			__le16 vf_num;
> +			__le16 cxt_start;
> +			__le16 cxt_end;
> +			__le16 key_start;
> +			__le16 key_end;
> +			__u8 rsvd_0[40];
> +		);
> +/* For use with sync.cflags */
> +#define SDXI_DSC_SYNC_FLT GENMASK(2, 0)
> +
> +#undef define_sdxi_dsc
>  	};
>  } __packed;
>  static_assert(sizeof(struct sdxi_desc) == 64);
>
> +/* SDXI 1.0 Table 6-1: SDXI Operation Groups */
> +enum sdxi_dsc_type {
> +	SDXI_DSC_OP_TYPE_ADMIN   = 0x002,
> +};
> +
> +/* SDXI 1.0 Table 6-2: SDXI Operation Groups, Types, and Subtypes */
> +enum sdxi_dsc_subtype {
> +	/* Administrative */
> +	SDXI_DSC_OP_SUBTYPE_CXT_START_NM = 0x03,
> +	SDXI_DSC_OP_SUBTYPE_CXT_STOP     = 0x04,
> +	SDXI_DSC_OP_SUBTYPE_SYNC         = 0x06,
> +};
> +
>  #endif /* DMA_SDXI_HW_H */
>
> --
> 2.53.0
>

