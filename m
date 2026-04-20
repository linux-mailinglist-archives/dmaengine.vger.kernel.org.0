Return-Path: <dmaengine+bounces-10052-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IAXLN1vt5WnxpAEAu9opvQ
	(envelope-from <dmaengine+bounces-10052-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Mon, 20 Apr 2026 11:09:47 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DB7D428ABD
	for <lists+dmaengine@lfdr.de>; Mon, 20 Apr 2026 11:09:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 994D2300CE75
	for <lists+dmaengine@lfdr.de>; Mon, 20 Apr 2026 09:08:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 342E638A70B;
	Mon, 20 Apr 2026 09:08:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="QoCKZfcI"
X-Original-To: dmaengine@vger.kernel.org
Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazon11013002.outbound.protection.outlook.com [52.101.83.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAE0A3859D6;
	Mon, 20 Apr 2026 09:08:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.83.2
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776676094; cv=fail; b=aMAr8ohG3HN8jytr7U4Nyx3fl0cZmwQjzF/bLjhZrbfnV1nBu6A446eLwtzGE/PgPmh7mUbbgUKLQPNotISEwloT3sHpe05qR9w2u2+Po4c8nDKqkuTy03RsaLbShNZewDgqYhUYewxoCmnPkYhnX/6xhIr8zTrsrsuRyaIWAvQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776676094; c=relaxed/simple;
	bh=MaOS2rctREHH5PkN/3OPnNn/rsGjlLBa6i9/nccQah8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=IU7Z8ZZZUx4hjz6BrQvZTjz9BFtGiwP94HK7RYLPk+e3orq3JkyAqIMnwT2kNfJ8GvE6UTm6NqJFmt9X4ZdzKJB84GDybTnRGgaD4DoAVByyNOJarZfY+Y0iJoOFW/AShv1C0dSf8Iqw+1X2VayQr4ArHXCFA6sfqwvoqSh4xAk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=QoCKZfcI; arc=fail smtp.client-ip=52.101.83.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yDDEZUmrbOT4D0brarbas4hhjNOHirgHmUfBpsHltGePiILvf2BPLwHu1wenE/2yTr/sMvURB8LThD2vbDQNFkCgWiS93IHcYJa/EyqiNLxgUpr+eL6sg00p9R5aTWBtpK6taZtcdEo41Wikh+kfwvXO2SFHvf1OwTAq/6B9V+kV1+vAEVl1Nn0NCCx6UQQde2vWxAL49ehGVZ1uKagfaP9U4pgRoJzv7jegn7qYFDzORCz5VAOsfirZEf622D04FFBiYOgInQQLhArBq1d3mXdAEGC7RokT2LvqM5KIlPcvOWN+OR9MFi0pqU+3iN0SSntPluFzm+BCcqZmeYcvkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MaOS2rctREHH5PkN/3OPnNn/rsGjlLBa6i9/nccQah8=;
 b=k1BtwquiOlKSmLwbObwMQChbF9mUC94mBPKA8arPboADUEZlfWQWrknG6X4oOQ5Ek0S9fPl0CZnRMgEvLS8SrJABmeElPsRy49BA/RxSGvBnTP8tFdSpVuBydLR9n+N83OU0CxAggq+FRHz+/uSSBWFl3uZdTwXNn3LdT2mZKbAKPOXVCPzza9YA9opZRPgYtLPjN/NcVm1gWyEWs8cMk33bFkQ3EhCZYb083cXZJqAxkjHY2/O9qgOHs/eNg3psLOIZKU64bj/969a247in/K0aoalXAUrOtf8juML916DLk6mOURwyHiRUGSnQf87an67KFJSaTkM4uM89UmtfYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MaOS2rctREHH5PkN/3OPnNn/rsGjlLBa6i9/nccQah8=;
 b=QoCKZfcILgYi4kDdmISWQ7M7Ohy9Qqtz4wZchGoAwlSCDFhoSsxmrTbwzZx0ioJYAXGGyK42kW3++SPb7Vq8VMPG/QWo4hFUHworSb6uDhA13N8CkN8YSI+XbF8DdSNSWGXNwIxa6Q3y3HKoa6JBAsHifyqYv6FA5WR5u/c7bIfWRfE2KEaE99FINLPEwc/WaCftrR1df3SO9B7zVv1ZC9dyzga2DUxDi/kVI4KzEtkyrFElG2EfkuELbh0VkRPf2qKaLbAWCrbtxr1yoXsSGHG133ulNkgTXKmBR5FE/1jDlISdCUqDEjkdxEfYsQKL3mxNLh4Lm21m/+CkV7nXKQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PA4PR04MB9366.eurprd04.prod.outlook.com (2603:10a6:102:2a9::8)
 by AM0PR04MB6963.eurprd04.prod.outlook.com (2603:10a6:208:18b::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9818.32; Mon, 20 Apr
 2026 09:08:09 +0000
Received: from PA4PR04MB9366.eurprd04.prod.outlook.com
 ([fe80::75e4:8143:ddbc:6588]) by PA4PR04MB9366.eurprd04.prod.outlook.com
 ([fe80::75e4:8143:ddbc:6588%6]) with mapi id 15.20.9818.032; Mon, 20 Apr 2026
 09:08:09 +0000
Date: Mon, 20 Apr 2026 05:08:02 -0400
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
Subject: Re: [PATCH 23/23] dmaengine: sdxi: Add DMA engine provider
Message-ID: <aeXs8pehnHIbPZd_@lizhi-Precision-Tower-5810>
References: <20260410-sdxi-base-v1-0-1d184cb5c60a@amd.com>
 <20260410-sdxi-base-v1-23-1d184cb5c60a@amd.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260410-sdxi-base-v1-23-1d184cb5c60a@amd.com>
X-ClientProxiedBy: SA9PR13CA0035.namprd13.prod.outlook.com
 (2603:10b6:806:22::10) To PA4PR04MB9366.eurprd04.prod.outlook.com
 (2603:10a6:102:2a9::8)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR04MB9366:EE_|AM0PR04MB6963:EE_
X-MS-Office365-Filtering-Correlation-Id: c887481c-8715-47f4-ba9e-08de9ebc57a6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|366016|1800799024|376014|7416014|19092799006|38350700014|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	RAc/lp/jfpVeIsTVg+sw6iDld3n3QRKLBCs3ndpFPxgQAayE1da+Fzr5gTR8dB6smvOa081XKArq98WuGSy/WqmiyonH7tO6jDyy6km8JLCQRqwdhMQHHsxZozjRlKpRNWeb+XEMr2gw3kfZPGtUNGs61Jbd7bZ1bKcMi53umtCTh9ZK03KTppc7CYYRsKitAIzCoehixsiXoSmdShfBsp5+J7XPh33ujaGu9CTbu0mnA1SJVt5D9FbDlMaAPahahpBH2VWbX3PzBr1LMahzUaoszN3hI6O2xEnf9DQNdSGbFYjZMP+IQMPMIp4kmpIxZKVyp/fyiZxGkMz39xBnwTiJhpRxr/SU/Vyxlkrm+TLZoE2L2DteQXBYCx3N9veWyQ1ePdCtprXiIKmR2K+hWFc05wXfyq5/4LhfZ4T0KuZXJaNGPQY+qAcp3jarDqpVYyhcSnYaDFxIK/AlXxL5k66Sgs/05kbxfku8hxTXZHHDZ9nk6tn1wfjUP7JnlrYE34joe84Vrn7TKjc2LDgrlaiHYlBSIMv79IjoHggnAuK2g4JXjlh9Jve0rePtBoY2F8u+P98ZT/OBY9cuzaqj0fr8iO/abdgiypIa3MwTcGUwUYl1TtnZ7VunxUjpdIxqUxd8Wzezl4i44TyXIKHZ56yIF2vQOWA8VaXRXChlmKLrnoL/5WpToTzUVruehzPtvwzZXEKiT3mqZeonUTEWcGtgDT1ZFPelNYmDEswBTXFPJp85ePayqwANMWE9Nks1kdRAIV9izt1modtKU4Z7zbeO2KUwPR9j1+5cJ2YNbOo=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB9366.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(366016)(1800799024)(376014)(7416014)(19092799006)(38350700014)(56012099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?NHhCy5QLzeMqN9VdmAMvDvSMD1OKXtBxKF81MnjYxoSQCQl6OBsoyO74IeCO?=
 =?us-ascii?Q?DwEtpiR5X1jTqzrjHFICmG492HXHADKefMkDie6lLTVh24G9gSSglpHcbvg5?=
 =?us-ascii?Q?7wp+SjYK6ri5tcJn90/sSjvZ4dkHfgLlpBUw/WehPvdnyycYZiFW/6rEyFmG?=
 =?us-ascii?Q?l3WLpKGLkHX1XsSvH1mz0SsAeWTDhb9CYlaK7mXQ5Wv/wMnjtV8s/awPDhgr?=
 =?us-ascii?Q?EiApDmsDAoKc0GskTwebB6I2dTnNepmQ7wBH+RQS2sPh+eCA1GLNjRa4QDiL?=
 =?us-ascii?Q?HLtEmxqwUExfDhozO9EjPXnS2NrH2O4mfp5xo1Q6+/8GMC/pDYw12l8QLA3k?=
 =?us-ascii?Q?PE2MlDaL3vsAo+ISh6P5zfoxa557OodGwBXwHItLSdL4WfduXDvSfur4kBUz?=
 =?us-ascii?Q?Ud2ze/1o3tAhbuIQbts+xS8oWsaA5hk5GWt2FujWFMToP9rlvDAru3qvmX25?=
 =?us-ascii?Q?hxGM5YlQMYlzOsvrMPWvqn65gLnM2iGwOKwZDqNysQtCKOWu+C6NXYu1bQLb?=
 =?us-ascii?Q?F5aRteF6Fiu4H6cpxO57iHCyP05qB93oX2T5xeL8Gb2sJcCLy5vaJmDucud+?=
 =?us-ascii?Q?PefKpnJQ6wjrLzRp6+kV98dX5Q43LhFTMIH8XtTa6gOPEtNnPt76u6QZaIB3?=
 =?us-ascii?Q?A3rST1SQUbpVAtrRC8shlkxI9dWq5hN3yEPgEE22ld9+NWbLMIW3GV976YY/?=
 =?us-ascii?Q?FQN6cpPsEub7NbRaq+AfRmlqXWYJkFxgsEKYgPNvUZdMWciTSIXZSlnMrb23?=
 =?us-ascii?Q?oyVuTgs5Bp+zWa3We+PdTkkm3UcoyGyZ5CtasEsNf2fzhLwrSGgCkBXmhVpm?=
 =?us-ascii?Q?Iucy/koiuE7Do+rfEAFM7gTnHdA7/eVpkB/SNCLDq5z7jThlsQr0W/j94IjS?=
 =?us-ascii?Q?BBjTn+6rc6GfJf2g/LCkO22jVSzGZojs0IY0F25bghW+KTsOCkIrIxbAxFVh?=
 =?us-ascii?Q?WADbmzdoUGw1giwH9TuusjRupwSK+WNMMy0CE4q/BZRGtNtNeDd51mIBuwkh?=
 =?us-ascii?Q?BYUE3t/2rJhnqzpX4s5ZLYijardNAyIM0IQEy8DmAOFIXC6W0c9SWWAXI2Xq?=
 =?us-ascii?Q?rZWTft5xlrtJLFkqBbpwsjIsuc25GbywpN7zHVvwkoQHEBUCFQJjHPBQz12q?=
 =?us-ascii?Q?fwanY5JmiKMCDu4ZLC2yI2cwh7iaKQZ1hzdP7qQyUDwKvJW+LcoHshldlo1B?=
 =?us-ascii?Q?+2rx3sseQepSwAcLFi4h/N230Bn0PMJJDvk3R2A3VMvFQcqwItnFeLcWAFHg?=
 =?us-ascii?Q?zPhcFFrMGi3fj5OFpCPn1NtZ8el+bFuyB1ffFt/IHqt0PEoTnyf96Br1vBdk?=
 =?us-ascii?Q?k/MeHsAYVnv1i8mvzKx1GBmbl1V1N0vf/FAKlpM9IGXI/SPlz0SjxPJxUnuG?=
 =?us-ascii?Q?sEdxkAx5fOIOUB+VHwuvEuW01zUsfwDqIo4FAyOhSut0kRVqBcmKtXfOLlLL?=
 =?us-ascii?Q?1kvLHWLn78+Uz1dTOEHQO0vRbY/aHNy5GEcqj9115+oEoKpuaIqCkCIYHjDC?=
 =?us-ascii?Q?x8MoP/KecwGthhjqFVtq67t6WI8+F5xtl//RxYlyZ4ti/SmFd2rh+9Nl60QS?=
 =?us-ascii?Q?JhjbaDKFkvOHQp4SN8IWq3WP1/HGP9xBMjhoYYWoKdtrg785f01x8G5RWPnE?=
 =?us-ascii?Q?5m/5xn726yB0GDNdvgiTIDclX0/AmqhcU5XEz1pKr3wp7JQ9NQNEStE1I3xP?=
 =?us-ascii?Q?51ads7h8GJ6jVLiXzZWbLQP7QYBj5fKhvciNNd++8s0oK34nxBnrQelrNN80?=
 =?us-ascii?Q?gByKofmMrQ=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c887481c-8715-47f4-ba9e-08de9ebc57a6
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB9366.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Apr 2026 09:08:09.6709
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dObaAYRZhNDZYLtgK3ubiYxXQhhsNopjHnLirFdo0P0Uh9EsvDeNdMnltEaRqJh9DKhnxSull2+gBEKo26trkg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB6963
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
	TAGGED_FROM(0.00)[bounces-10052-lists,dmaengine=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[nxp.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 8DB7D428ABD
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri, Apr 10, 2026 at 08:07:33AM -0500, Nathan Lynch wrote:
> Register a DMA engine provider that implements memcpy. The number of
> channels per SDXI function can be controlled via a module
> parameter (dma_channels). The provider uses the virt-dma library.
>
> This survives dmatest runs with both polled and interrupt-signaled
> completion modes, with the following debug options and sanitizers
> enabled:
>
> CONFIG_DEBUG_KMEMLEAK=y
> CONFIG_KASAN=y
> CONFIG_PROVE_LOCKING=y
> CONFIG_SLUB_DEBUG_ON=y
> CONFIG_UBSAN=y
>
...
> +}
> diff --git a/drivers/dma/sdxi/dma.h b/drivers/dma/sdxi/dma.h
> new file mode 100644
> index 000000000000..4ff3c2cb67fc
> --- /dev/null
> +++ b/drivers/dma/sdxi/dma.h
> @@ -0,0 +1,12 @@
> +/* SPDX-License-Identifier: GPL-2.0-only */
> +/* Copyright Advanced Micro Devices, Inc. */
> +
> +#ifndef DMA_SDXI_DMA_H
> +#define DMA_SDXI_DMA_H
> +
> +struct sdxi_dev;
> +
> +int sdxi_dma_register(struct sdxi_dev *sdxi);
> +void sdxi_dma_unregister(struct sdxi_dev *sdxi);

where use this it ?

Frank
> +
> +#endif /* DMA_SDXI_DMA_H */
>
> --
> 2.53.0
>

