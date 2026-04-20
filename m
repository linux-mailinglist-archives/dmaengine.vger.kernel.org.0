Return-Path: <dmaengine+bounces-10038-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0GDDH43X5WnWoQEAu9opvQ
	(envelope-from <dmaengine+bounces-10038-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Mon, 20 Apr 2026 09:36:45 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B00FF427CC0
	for <lists+dmaengine@lfdr.de>; Mon, 20 Apr 2026 09:36:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 975133025710
	for <lists+dmaengine@lfdr.de>; Mon, 20 Apr 2026 07:33:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D20C383C8E;
	Mon, 20 Apr 2026 07:33:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="YNh+h+AL"
X-Original-To: dmaengine@vger.kernel.org
Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013029.outbound.protection.outlook.com [52.101.72.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAAAF28641E;
	Mon, 20 Apr 2026 07:33:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.72.29
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776670437; cv=fail; b=IT24f6UZvCZ2LN/obiyaXY4aDpFXotNODq/s84dAjk44Z21LB/RjMCQ6HqiQVBNbblaZvHiXbtcM7hQvTZAkim2LVcZBaeVuWJ28riGepisTjRI+jmz9l26Y6XAh+q7pf4Vb1vPhw9EhVVxlDatSbf3o5nuzraenS6XpkUkV7U4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776670437; c=relaxed/simple;
	bh=xjoyyhtdr9kOQA/fn1DuP5/urNbHM+evyHzrzmu2jSk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=hxFcxA6lb2w+Nf2LTjEYGAzATM9FoVK1LIp4j/Eg+vehSDhKQ2I4/ijGf2c6kopjKt8m4Si02Ml8/W9jgkvKEYVjZsks8vbsMQgB12C/rO2Dy8hyln3HgbpT5p+ygWBy+rp5CGZF0r9WDQ4ZIxQvtUTIl6xI0KwQSVhaKRGU+h0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=YNh+h+AL; arc=fail smtp.client-ip=52.101.72.29
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KGLqoXjaI8gd8ioaFvQgbrE3yHSxgMC8SGi9kvZ+qaiHUE0+9zFWY9NZiRF2d1oFRgkROg666Bhd0clwQNifokZcBJ1OiF6Qpgq9oGXxBbquOcOm2HG0IQmXcZVoARUjp7lpVxFzIQR6tdtcS2VKny1psbhwjvH8sWcorOzlBPCutw0iKiXha/8pX92XlJeEPZsVBIUjLgrQATcBksJCdiz4MVr+3Pzj2RuQgVdZz1XhURsEHhMGKxATcbH+wwzQdl3OuNEXKWwuZ/EdD+eIkpS4rWdG/oVHm3ZdOTVvGWfxNReoLhPj0VICXc26D8lw6KWT/A6X5tVg6VzoCj6CnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iKNpJnEfKnORFFzLz+dH+3D2+1jVZzolMwxVr9yhE0g=;
 b=AetAgbmcs8/fgYkPpFUUffVuTtkIqWbiRXuc0F4tGL3ubcpFNgqQ4N8LSMi3IbN8+oZ9odWCWdNvBfieFX4/+m5qIjDtUwP3gyjFb+wDkWGO8Y8xSG9+onzi+xuCEMgqZ6nW0JVjILMIh19a+6Peb6uMs0Po/l34XdkLSbp0kVACtxZ5IcFumm+d20PZmLZ9wh2CKvTNqEHMu7U598GYfN8S/WY1Pv1UYcZ8vY3CHVo0mhhHhvn9v8ujeypnfcpfyjlmN6iDE6K9zs0hCksYSRsQ+DUKJj+B1OXuSSzKxiUJpa2lhOh9hdCPN2/RbqJSAXZzk2OIxxPB8t/2Don8Lw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iKNpJnEfKnORFFzLz+dH+3D2+1jVZzolMwxVr9yhE0g=;
 b=YNh+h+ALcZdQkrfv4x3Zra9LZXhVifP7XnQccCy/4gesSlihhcSoDg0v/fz8AHNNXupnGiStz+petSQkxn/E73gO7GwByn2kHl68bvg4ehDcpfBdczKgXQ+6viLzV99xD3DOzQNbG/Lcc2ODlJqDccOrsVTjlS8uoVsJvybKVyvy+RwSXoPgG0dgx/m6ZXxcm++v3783Iit0xVhUNpNeL+nUM8q5vjvzhnbLEjaHSHs2+NpJmm1pUALmZenPgbj0ORLYaC0LG9APGU8QgWNOjwmvwrCkgicsFGpxPJnIVQrtubwkqk2o/midOBwFBl1yjLJpR4GVN0AfaKaF1wIMJw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PA4PR04MB9366.eurprd04.prod.outlook.com (2603:10a6:102:2a9::8)
 by GV1PR04MB10396.eurprd04.prod.outlook.com (2603:10a6:150:1c5::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9818.32; Mon, 20 Apr
 2026 07:33:52 +0000
Received: from PA4PR04MB9366.eurprd04.prod.outlook.com
 ([fe80::75e4:8143:ddbc:6588]) by PA4PR04MB9366.eurprd04.prod.outlook.com
 ([fe80::75e4:8143:ddbc:6588%6]) with mapi id 15.20.9818.032; Mon, 20 Apr 2026
 07:33:52 +0000
Date: Mon, 20 Apr 2026 03:33:46 -0400
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
Subject: Re: [PATCH 10/23] dmaengine: sdxi: Complete administrative context
 jump start
Message-ID: <aeXW2pc0S6QBHQpB@lizhi-Precision-Tower-5810>
References: <20260410-sdxi-base-v1-0-1d184cb5c60a@amd.com>
 <20260410-sdxi-base-v1-10-1d184cb5c60a@amd.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260410-sdxi-base-v1-10-1d184cb5c60a@amd.com>
X-ClientProxiedBy: SA1PR04CA0017.namprd04.prod.outlook.com
 (2603:10b6:806:2ce::22) To PA4PR04MB9366.eurprd04.prod.outlook.com
 (2603:10a6:102:2a9::8)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR04MB9366:EE_|GV1PR04MB10396:EE_
X-MS-Office365-Filtering-Correlation-Id: 31457384-c4f8-4063-4802-08de9eaf2b92
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|366016|1800799024|376014|7416014|19092799006|38350700014|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	mljm5tZHMnTPJTpaj8/0XdpBa2HXssEXpbuFeK3KfHrB0Pzn3T4yQ6VfXOUeNtzb8TRUevvceZa+63XLt4KpiI7ViVQi7nPTdUCK3l26BHKbwHqZ0MQicgDfuI++tJyFwiyOu7aRoDjnGw/GemVkTcEM2Do8gKuKmp4XwjrPU0pb1h/FIhD24R5vTWkzKTqpKPlvkbRmJM4bCiaeOtsi3IY4JL5DKoKTpbxCG1KjQ/GrRlBFSw13nZbN747btj76I0sCNtX3/QmQw+ROu2jlnl1Itmu8O6K3MykUGr3coSLsrDtjAp88aNWnhG6WntgVcDfCbzZFLTjfmRHTFlic5PpswYICRUlbntRJXZmkL9fUP5O0GU45izq3jc4A6w+2BKgxteqxYMOc1hKpsbHVx4BR+Zu2OZh8z+nSywItSOrtyBp71eZD7ugYPnhSST+kH0HM/ycFe9Hxr/p2IdyylyBFzl8d3d4c6BcqnkidDr2UeYGK/MJXNuSdvm7OzvROZ4drO/Y3C4n7EjkqjGy8qq6FY5XBCv0WL383/JMlIB2JvROgtVM4N8YY8JP8zb4TP5FTexGiFz/XW493nuhrgK0fR7diC9RgtvHUp45skYf0pzrc7C5TnQGosXN96311E0Gr7fiZLq2JBULntWuyMoI+TW9naD9bCS0dRZK6a2qrreOuWPpcG5/dqiUFnu6f9vtxYEbwi3RIhS0iO+EXAsC6v25BqPRgPY4619MNJ5juyuRcNTQ5X2psbkb3mfCLdcRewXaCqyU+KfW8zug9zKJ3fzRi7EqNxVnYtN8IQ1Q=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB9366.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(366016)(1800799024)(376014)(7416014)(19092799006)(38350700014)(56012099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?2pl78/RiPo845ymWS1xcFIgbRzKXzK68IGWavLYskedtU9uy7AFSW3EC5CCb?=
 =?us-ascii?Q?tQKGYfuBqVS0PGDYiGBXzPoYHsm+Vlh7/dePrAZQ4paLDB58YT/vRZQT6ZLk?=
 =?us-ascii?Q?1EzV6ND4yYD34kSL4L8BrCL9Z7uOfqDK6vRGQEUvwb9kc/gB3e9So8/WAXHt?=
 =?us-ascii?Q?P9kirN8Mn+v2ErggqoupX3rGwJ2xULGo/U5I6HfDIJB+dbNMhrUZqTEZdtgR?=
 =?us-ascii?Q?xnRfc3beWf2R3UeO9tQJ8HzWbo8gV4muGwk/otAm7GeOFerFCVbB1l1IJFg1?=
 =?us-ascii?Q?SBCzo1XNUk3OseFve6SLPskVIv6h/BJ93cC/VrAoCjzguooRth7wXkqen3xD?=
 =?us-ascii?Q?FfMVSk1oTX2IL2TcBg7kwgFUOOTj50INdscOQA2KumURIFd0L+nwSMTO2ZDR?=
 =?us-ascii?Q?YMyUllDuwOloRDh27IlAmSWiJk6qRwVpqp+6B5zxgZFyHKpTBCswWTY8aiRx?=
 =?us-ascii?Q?ffHk0rSopIVnxghuGqF34nnLPYCKEI6mtQHxYGldP682szWdIPEmIcE4u8Jp?=
 =?us-ascii?Q?e3X2T4x9RW/1eaCjB9szJRZkGCLmImyEC2iLPGqw8SGMBKC98CT369w84+9e?=
 =?us-ascii?Q?DBX7aYRHO5BjZwfQXFODocG2459nl4M3IcJEWESIomQgvJrG2H7/HtQkr/e2?=
 =?us-ascii?Q?e7R/AWXPNKVk/oTIYMRyz240sBhIAhjfOkEXe3/YrOeqaS8aTIiwl4YyxaeW?=
 =?us-ascii?Q?IMW0W1YRVJtkeOFMlyefnB4jZhMnIKkEHLrkNMIjHti3yzQcxV5PAZAK8FoV?=
 =?us-ascii?Q?X2rTCShBJ/d7dhIkiy4R9GYIJu5pqbCoYmseqmweDo7IaLFidJKxlTM5QLnr?=
 =?us-ascii?Q?g2ZDCvUpA27vXZCqkWJKS4cMOxLN+EU5wUU6UxX24QCgB06hk4YBFFAASHD8?=
 =?us-ascii?Q?EmCfA5RoyXBEM22j9Oq6Oh5oNrjWven5PZqJMtDVxPYY7IHYyK2oArsv0LZR?=
 =?us-ascii?Q?ctOeMiMlIbi8BBuxO/+ucRu7jp+anKp2IMsCzWO5MR/x2yoA9iBCFEKaCtkX?=
 =?us-ascii?Q?69UUnWik4AUVv9jIT+AkyzzvhaMEX+q8U6kewNMHqL0hfpnjzuT/oPB+BZU7?=
 =?us-ascii?Q?Sz6DG1vNDVw+ehHxOvzAHS8+GCeZ4pckdP0QeCpmzxuz0RYXzCPxV2eew9DR?=
 =?us-ascii?Q?627Thy6nI5nxVA0nCVxRUY6hHhb38kl1yfaYYJSJ9WchnRX3GtLtqGpk2NYZ?=
 =?us-ascii?Q?yiMp4bcVnES3uovxfVdYh1hUGe7n92q52iqR17c+N2TQ47RCSY2AEbcO0r/E?=
 =?us-ascii?Q?r6oJXMltY3JKgxePDCauHlTBepApj9e5CyTjrD0ke/cRZt7djGIeU/k5RATQ?=
 =?us-ascii?Q?mWjYFyGgpJDr4qVndr1jKCqB48mNExrGtDgRGnPDQ6tANY3zCwnmXxZ0k9ps?=
 =?us-ascii?Q?JPQ2aePc0bRXcEUnkmtcCUkvAoGUvzXjsn6co2VPXmLqIdevZGfuCNwMooLz?=
 =?us-ascii?Q?af8BKgRxVU5QfCAE7PtctczxZ8D9fwgHRGAwidtFDqda3jGAaj8RE2kBGt0V?=
 =?us-ascii?Q?GxjNhm+rRoa7wqqzRVAmlSYn5z+L02dWWymWRCAcIocCLBiF2DvmmT4VhESN?=
 =?us-ascii?Q?+CXpWwVHX1agev1ce8c+M8l36xIwjmoMcjCfqbJaQBKBIcLy24oY6D6CdXO6?=
 =?us-ascii?Q?Nv8bz/m+v87jFi1L36B9DesDzmB46drKu0aQDAhEQOlwgatRQ5qZFHNElHKs?=
 =?us-ascii?Q?6TQZjqOqcQTm+U9/DHxqziOJ40M+w3faBOxeqGn/G8lFbrxd4ad95Dvwfp7j?=
 =?us-ascii?Q?pRC+l6KUIQ=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 31457384-c4f8-4063-4802-08de9eaf2b92
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB9366.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Apr 2026 07:33:52.2912
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: m3uDO6IETHCr23xaWhSjCTxoMCAXTrElAHbWk6xPbpc98UgqN9PuvlRZL6Tx1sLLn0vtC1avXrMoTKF+XWL9kw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR04MB10396
X-Spamd-Result: default: False [0.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nxp.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[nxp.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-10038-lists,dmaengine=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[dmaengine];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nxp.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,amd.com:email]
X-Rspamd-Queue-Id: B00FF427CC0
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri, Apr 10, 2026 at 08:07:20AM -0500, Nathan Lynch wrote:
> Now that the SDXI function has been placed in active state, the admin
> context can finally be started by writing its doorbell. Introduce
> sdxi_cxt_push_doorbell() to pair the necessary barrier with the
> doorbell update.
>
> Co-developed-by: Wei Huang <wei.huang2@amd.com>
> Signed-off-by: Wei Huang <wei.huang2@amd.com>
> Signed-off-by: Nathan Lynch <nathan.lynch@amd.com>
> ---
>  drivers/dma/sdxi/context.c |  8 ++++++++
>  drivers/dma/sdxi/context.h |  2 ++
>  drivers/dma/sdxi/device.c  | 15 ++++++++++++++-
>  3 files changed, 24 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/dma/sdxi/context.c b/drivers/dma/sdxi/context.c
> index 097d871e530f..934c487b4774 100644
> --- a/drivers/dma/sdxi/context.c
> +++ b/drivers/dma/sdxi/context.c
> @@ -16,6 +16,7 @@
>  #include <linux/dmapool.h>
>  #include <linux/errno.h>
>  #include <linux/iommu.h>
> +#include <linux/io-64-nonatomic-lo-hi.h>
>  #include <linux/slab.h>
>  #include <linux/types.h>
>  #include <asm/barrier.h>
> @@ -258,6 +259,13 @@ static int sdxi_publish_cxt(const struct sdxi_cxt *cxt)
>  	/* todo: need to send DSC_CXT_UPD to admin */
>  }
>
> +void sdxi_cxt_push_doorbell(struct sdxi_cxt *cxt, u64 index)
> +{
> +	/* Ensure preceding write index increment is visible. */
> +	dma_wmb();

Needn't barrier(), iowrite64() should make sure previous write complete.

See Documentation/memory-barriers.txt

Frank
> +	iowrite64(index, cxt->db);
> +}
> +
>  static void free_admin_cxt(void *ptr)
>  {
>  	struct sdxi_dev *sdxi = ptr;
> diff --git a/drivers/dma/sdxi/context.h b/drivers/dma/sdxi/context.h
> index bbde1fd49af3..c34acd730acb 100644
> --- a/drivers/dma/sdxi/context.h
> +++ b/drivers/dma/sdxi/context.h
> @@ -58,4 +58,6 @@ struct sdxi_cxt {
>
>  int sdxi_admin_cxt_init(struct sdxi_dev *sdxi);
>
> +void sdxi_cxt_push_doorbell(struct sdxi_cxt *cxt, u64 index);
> +
>  #endif /* DMA_SDXI_CONTEXT_H */
> diff --git a/drivers/dma/sdxi/device.c b/drivers/dma/sdxi/device.c
> index 145aa098c269..15f61d1ce490 100644
> --- a/drivers/dma/sdxi/device.c
> +++ b/drivers/dma/sdxi/device.c
> @@ -244,7 +244,20 @@ static int sdxi_fn_activate(struct sdxi_dev *sdxi)
>  	 * SDXI 1.0 4.1.8.9: Set MMIO_CTL0.fn_gsr to GSRV_ACTIVE and
>  	 * wait for MMIO_STS0.fn_gsv to reach GSV_ACTIVE or GSV_ERROR.
>  	 */
> -	return sdxi_dev_start(sdxi);
> +	err = sdxi_dev_start(sdxi);
> +	if (err)
> +		return err;
> +
> +	/*
> +	 * SDXI 1.0 4.1.8.10.b: Start the admin context using method
> +	 * #3 ("Jump Start 1") from 4.3.4 Starting A Context and
> +	 * Context Signaling. We haven't queued any descriptors to the
> +	 * admin context at this point, so the appropriate value for
> +	 * the doorbell is 0.
> +	 */
> +	sdxi_cxt_push_doorbell(sdxi->admin_cxt, 0);
> +
> +	return 0;
>  }
>
>  static int sdxi_create_dma_pool(struct sdxi_dev *sdxi, struct dma_pool **pool,
>
> --
> 2.53.0
>

