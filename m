Return-Path: <dmaengine+bounces-10333-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id XvK+Eo1KAmpaqQEAu9opvQ
	(envelope-from <dmaengine+bounces-10333-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Mon, 11 May 2026 23:30:53 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A5A925164CF
	for <lists+dmaengine@lfdr.de>; Mon, 11 May 2026 23:30:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 45DDC3013786
	for <lists+dmaengine@lfdr.de>; Mon, 11 May 2026 21:30:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99AE02C375E;
	Mon, 11 May 2026 21:30:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="a9g5kJuv"
X-Original-To: dmaengine@vger.kernel.org
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012063.outbound.protection.outlook.com [52.101.66.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B14902701B6;
	Mon, 11 May 2026 21:30:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.63
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778535050; cv=fail; b=hyCLceIliO3ySBQ9xkDo1C+gZ/jDSrX9r17tq+rWrfX96HPfJiFAr1QfnI0z7dREdM5NgFmd/cN0a7MBPbnARE6dw4blTNV12a/0Zk/1Zn+aDE6u0v/m/JFR9qVadnnVkVDACuhtVEvvlH87PD7EBn14Shl+vLThq7C6TxY+0uQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778535050; c=relaxed/simple;
	bh=3TNzo0ou4dC6CSkC24Pu1a6Mc/y3Vu8nUK3XBUJXqQM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=hPphUk34EOsvEBwjWCWJMYi3fuyC5kWWXee1cxH39ljR0YceMbyPqUY5xW+NBXoVh1tSYASdFX47CoTQvLhYEXbu5GgUUePn9xi5vzqB0upqfgroe+Y8goISx/1wMrHiFiqnFt4gs/8ab+LaacpCMmDLyotZ5h8k3FkJrh336nU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=a9g5kJuv; arc=fail smtp.client-ip=52.101.66.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EvQ6NgsOCkDPcspqazphyg0ldbhYYkZbvViNHKigOneNgdRGJevSrnWZ/iNgk5IMjZY7XBOXaPJIHWPxCJcLYu5Lq1Q1yLYwkjolU8S/G4PGTVyCJeWqr6S3FMaiu01gGACt7NoSmzVsRvWf6J9h/YOG5AHEaRzzwVRDfFzzF1L3lAmsUgK0oR72WWpkum2YnL8n8U7+GIpVeIRXXBlAvc6fteyNr6ZAAwA0zu7GbM5ksENXU/LO73rzZYq4kgUAzIS0ltJzk0i6P/FEPAkAErJudOeJ/HFqNhAx2EEZwMvwa35MBSYWh229OG0tOcI0vdue73zii2Bb6GAc6TZcIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YRUYFAyVa5gGqf6/He5LMWXiEWerHfnclwCh32wTHgU=;
 b=n4K5736/wfDqdKRnDVmADn0B5yXdqCaKm3zaOJc1JWGTiAYXKqN0yB/6NZfHiOXTbveUFNAIQ6rr7xVFr4kp4RFHfEPeSXEVNGBqsQpUXRBRT54FPgtYgGJqsieYwsSR8NG9HtGt/aCt0g1RVfTvqzdmA+q4TAcWbJ8LsXUnr9W4SLKxpYFdcnUMnZTbQDilo0RHcZtQOcgUC7UvEFSQc8kmkqENu729szdZ4dYlIdmy4RAaFnBxmsromBKzLQLR+RBizY6ZkVx3PAoZ6sneiO5aTlbCSCg5DemQ1egaYMvEBO7wPEViL0mKUxTSKIeYYyI8KXD2l8PpCSCRAZzboQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YRUYFAyVa5gGqf6/He5LMWXiEWerHfnclwCh32wTHgU=;
 b=a9g5kJuvM5seuD+PxS/Ay1XNpLHJTu3zofgof7lUgVCiDxfbksX/rqO/1mkJYHjy0dzGV6ZvujmaIeF/bJoMBhRWa0ZVESFcKqylWJxF79Jw4h+I5LOPGFrEWGW4YTAuXrLo9YTwrzfMXRmyo8tSjHOWA04uOTH3KeCmzE6nDjjA0dqri+8pmYPB98K4WfiKpUoCpkxQJOlImzLz0Ahh4ZpmO/9F5j+iF4NpKEiiQoqXl6Trd5neQMiDBfKxgIYcZZXd677yHJ4vaQFv+dKgau+0oryHo1p+dkdGZYnxKhVUqTbp16qtIBuMR1p48FF1/reuCZ3rl0S4aPKdjIUEfw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PA4PR04MB9366.eurprd04.prod.outlook.com (2603:10a6:102:2a9::8)
 by AM8PR04MB7745.eurprd04.prod.outlook.com (2603:10a6:20b:234::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.23; Mon, 11 May
 2026 21:30:45 +0000
Received: from PA4PR04MB9366.eurprd04.prod.outlook.com
 ([fe80::75e4:8143:ddbc:6588]) by PA4PR04MB9366.eurprd04.prod.outlook.com
 ([fe80::75e4:8143:ddbc:6588%3]) with mapi id 15.20.9891.021; Mon, 11 May 2026
 21:30:44 +0000
Date: Mon, 11 May 2026 17:30:36 -0400
From: Frank Li <Frank.li@nxp.com>
To: Nathan Lynch <nathan.lynch@amd.com>
Cc: Vinod Koul <vkoul@kernel.org>, Frank Li <Frank.Li@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	David Rientjes <rientjes@google.com>, John.Kariuki@amd.com,
	Kinsey Ho <kinseyho@google.com>,
	Mario Limonciello <mario.limonciello@amd.com>,
	PradeepVineshReddy.Kodamati@amd.com,
	Shivank Garg <shivankg@amd.com>,
	Stephen Bates <Stephen.Bates@amd.com>,
	Wei Huang <wei.huang2@amd.com>, Wei Xu <weixugc@google.com>,
	dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org, Jonathan Cameron <jic23@kernel.org>
Subject: Re: [PATCH v2 04/23] dmaengine: sdxi: Feature discovery and initial
 configuration
Message-ID: <agJKfAjCvWOvTLpV@lizhi-Precision-Tower-5810>
References: <20260511-sdxi-base-v2-0-889cfed17e3f@amd.com>
 <20260511-sdxi-base-v2-4-889cfed17e3f@amd.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260511-sdxi-base-v2-4-889cfed17e3f@amd.com>
X-ClientProxiedBy: PH0PR07CA0118.namprd07.prod.outlook.com
 (2603:10b6:510:4::33) To PA4PR04MB9366.eurprd04.prod.outlook.com
 (2603:10a6:102:2a9::8)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR04MB9366:EE_|AM8PR04MB7745:EE_
X-MS-Office365-Filtering-Correlation-Id: 15ae0ec2-fbe7-4493-7bfc-08deafa48f17
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|52116014|366016|19092799006|1800799024|38350700014|56012099003|18002099003|22082099003|11063799003;
X-Microsoft-Antispam-Message-Info:
	984Z/MbCV6ySoNqXfWhi56ic/KLH83J/VEiWUlNcWcp3hENI1w69VGW8JS4SY+vaRpDetg+ozHGaoxbUpdwu0sRd3HhrNwEwRT0g6gBQh1t7Pn9hPBEwXCNqgmno8Vuz75cQthljTmG1hqkFwwAVAW0y2I03UjOYxukBHMkXBhCMN+p1HdM/Ecu9BYm7bS9dn+CV0TFLJTwjLIApCj5ldEMOUFbo6XLs6gEJw7dgvsWOKVtYXgKOyKa7pNu7iElFFV48SNjqzE0LIqYxYpq6kJ0MdCSZBlSDUbjRLD7a84Z8CQqOWkeQJQ8wURtKw5FdqNs/ZCkK24IApdqroZ0JkvsghGAlxBflPHD+8/tn8REFGLLYqbyEC2qEx8hfko824ixo+mVGvF19KyMNfqAhvsMfnGyrVyh1dfDw31Ne5GJtiC4A7O9VyYImx0Ll5nPRkD83dyuoIcA2/H8xroWAektLKg2zU4GcaEe4TG5/iTl0IlcDthjwGTPzc9zr6hATkQf0YT/mhdeSkDBT78g5+ypJCMhrnY1jM8RZRksV5is8mJkw2qs+vjoiEQ+INtgWT2MP3Scd3HV5l3z2L8SEowXskxFCAzu+mms0+9MiZL41mX7SRz5irZGjFsm7nLDVfLsJoR+wBn+9vsuJAvP+98IJvwj73Qmq+bScotoplJHPKyQyI1ddP/XaFwctIgqHYZEx4W+01M8tpWyFHuPwL4uOKMyTsCS0N29IjKrbuIgfaxFkZdUjY0oidzJvBCis
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB9366.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(52116014)(366016)(19092799006)(1800799024)(38350700014)(56012099003)(18002099003)(22082099003)(11063799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ZvIHQVCdyUnoiYE/b9lfPib7MS81gtrbNrSMQmVK+pNnipGDpMJljJnMWSzz?=
 =?us-ascii?Q?4t1ZI+elSWMjzXlU/YI8aouBX5FiscjREhAa8wLYC+LQV21H5+m1slnUBlNR?=
 =?us-ascii?Q?pJfrtccu4PTa7d8WohWtfs50S9GuLh19jrzDsWuWVT8drah+W7ODtvHr44Bc?=
 =?us-ascii?Q?KzHVZx5bxfS5Ogxyy5au4dJd3/XW1ttatsfC5NRRghwycvRs5oFU95YAstjK?=
 =?us-ascii?Q?pOjfltIMgjS4e+cpucpiHmsUhQCqq0yu7ga9wJuLalMT9CNszXyQHe2xdBU5?=
 =?us-ascii?Q?M5IHy5n6aJyiAtr4Vc0poQh8g6DUrygYWHTqvv/lw31aQfw6Q9u6nW323Seq?=
 =?us-ascii?Q?3xfSIrrolBwXpanOOvdEAuE4hD9WdoaDtqwhXYNjommzsDW3R8tu0TtvsPFg?=
 =?us-ascii?Q?ynagX2pLcooVZC6+TeivKapCbSol5yH0YXk2Mm8Lw0+zJuNSRQyIrxJG4+9j?=
 =?us-ascii?Q?XJCXRKx+NFyLWN0jJe9VTnnGf10ig5hfwR5I0EsZIZDSctLX6v2pEqv+UkiH?=
 =?us-ascii?Q?rGUZ2Ql3Q1U8Yg5moJ3DXYeHKj1hj+tj9A8BY0GvFrsdiHLJhHcRZsv1goJ1?=
 =?us-ascii?Q?3lA601lOogaHAqSrELAfIyeOnWS8SHWDa/r+Pu9k379kmiaR8AKbTe/yYB8O?=
 =?us-ascii?Q?rQfjSPBhCPsuZGludgUBNJ+tHWGAAIonA+01y0K5M4SVYxAIrFr8ekj45jGb?=
 =?us-ascii?Q?7DjlchgklbJOI8EusKckB/XPow7PwUsVKEiUrkMFy4eGuSUt95ny3pW3BvCp?=
 =?us-ascii?Q?irnsuyxI62558JJQ5cd/x0WZhIM3cHwUhPYIdl2qOZ1bhvYRFoN1f2yGxjF0?=
 =?us-ascii?Q?i66sJB+l33G0kV1wT+z+9z3M2yTxojcySjrpkNHclLgSOVuVR/gjRuG8ZxcH?=
 =?us-ascii?Q?FBch6r0RKt1s8Z3PmLUwlaunc1YeziIYvc1VBFooxg+OgkKw3KbZJaqJy5cG?=
 =?us-ascii?Q?gwMDM5ndyYPrDM+BUwOTub7Ds8+IvmiZ1QqGexD+V19lNn468yVlkQAOSi9o?=
 =?us-ascii?Q?1GvskdB+GjqXtyYOprhKTAIy0hY+ZTnjfnasPL7+EM+UsOYj0bmQUbG/1l3c?=
 =?us-ascii?Q?invVFv30I8UBrk+iOnjWcnmx8m66/Sgp+wxpB/lmGR0EsRpsYVC8qN21k3Sx?=
 =?us-ascii?Q?ai/dPdY4bdhYYTZGCnXO4bWYRTIIqHq0mNszf8xcGxaDjiahUWqlemlkF7Re?=
 =?us-ascii?Q?qe5ixoeJBfrbQa573eCvdLooKJL481IvkBdgJqjx6Li4/dmFe4jzlEGti53I?=
 =?us-ascii?Q?Th4M2jmS2Pgk/4EEtkm1kcs/epwoK6vgdODbAsEV+OaGS9xEYqhSB6jrEAf9?=
 =?us-ascii?Q?AYozmjQziXMESbfJxqXf1D3Hy1g8GzUAjtgUID3nxpPm4eFKolKNFDJxcsgt?=
 =?us-ascii?Q?SiNHYXX0Zi26hyC2Ifg8egET83qg0jHoSkwGq30AIQEcJFf/qAaFqWZGxt3v?=
 =?us-ascii?Q?c5hDWinVvpzUPP2VlE/avLDjkdoFBZTl7joXhRfU1vfMV+/vJkKpi+8n6uHF?=
 =?us-ascii?Q?V+418ehjMcwdRjd4fa/58BV00q5T1wZclntkAjjP+ZQhDxrUkLR90ByuR8YR?=
 =?us-ascii?Q?S+tCeuo1iNydkvcmk0YiJxmm2ZzbsgYwgIACCxla+kOEEStCv76Dg+Gzzmg7?=
 =?us-ascii?Q?JK7nrkD6Gd/Bn7Dw1jxjZvl2hpz8BBk4EZxLz0yaxEcyZvkRFs3ap9Nn26mH?=
 =?us-ascii?Q?PAmWkFavY830qM94iiJC6HdYB3sdb2cdRTRuK/CiQVyFQYXK?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 15ae0ec2-fbe7-4493-7bfc-08deafa48f17
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB9366.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 May 2026 21:30:44.6096
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zqZLDUyG1wNA0qyI5t66tS4jMQfpVp1W7HHpHA3ZNNUk6n+ceMdLZ0MbK5Z196Lu2D7gwbYdnQQDs1cgd6G7Rg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB7745
X-Rspamd-Queue-Id: A5A925164CF
X-Rspamd-Server: lfdr
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
	TAGGED_FROM(0.00)[bounces-10333-lists,dmaengine=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[dmaengine];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,nxp.com:email,nxp.com:dkim,amd.com:email]
X-Rspamd-Action: no action

On Mon, May 11, 2026 at 02:16:16PM -0500, Nathan Lynch wrote:
> Discover via the capability registers the doorbell region stride, the
> maximum supported context ID, the operation groups implemented, and
> limits on buffer and control structure sizes. The driver has the
> option of writing more conservative limits to the ctl2 register, but
> it uses those supplied by the implementation for now.
>
> Introduce device register definitions and associated masks via mmio.h.
>
> Add convenience wrappers which are first used here:
> - sdxi_read64()
> - sdxi_write64()
>
> Report the version of the standard to which the device conforms, e.g.
>
>   sdxi 0000:00:03.0: SDXI 1.0 device found
>
> After bus-specific initialization, force the SDXI function to stopped
> state. This is the expected state from reset, but kexec or driver bugs
> can leave a function in other states from which the initialization
> code must be able to recover.
>
> Co-developed-by: Wei Huang <wei.huang2@amd.com>
> Signed-off-by: Wei Huang <wei.huang2@amd.com>
> Signed-off-by: Nathan Lynch <nathan.lynch@amd.com>
> ---

Reviewed-by: Frank Li <Frank.Li@nxp.com>

>  drivers/dma/sdxi/device.c | 172 +++++++++++++++++++++++++++++++++++++++++++++-
>  drivers/dma/sdxi/mmio.h   |  51 ++++++++++++++
>  drivers/dma/sdxi/sdxi.h   |  19 +++++
>  3 files changed, 241 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/dma/sdxi/device.c b/drivers/dma/sdxi/device.c
> index b718ce04afa0..f9a9944ad892 100644
> --- a/drivers/dma/sdxi/device.c
> +++ b/drivers/dma/sdxi/device.c
> @@ -5,14 +5,180 @@
>   * Copyright Advanced Micro Devices, Inc.
>   */
>
> +#include <linux/bitfield.h>
> +#include <linux/delay.h>
>  #include <linux/device.h>
> +#include <linux/iopoll.h>
> +#include <linux/jiffies.h>
>  #include <linux/slab.h>
> +#include <linux/time.h>
>
> +#include "mmio.h"
>  #include "sdxi.h"
>
> +enum sdxi_fn_gsv {
> +	SDXI_GSV_STOP     = 0,
> +	SDXI_GSV_INIT     = 1,
> +	SDXI_GSV_ACTIVE   = 2,
> +	SDXI_GSV_STOPG_SF = 3,
> +	SDXI_GSV_STOPG_HD = 4,
> +	SDXI_GSV_ERROR    = 5,
> +};
> +
> +static const char *const gsv_strings[] = {
> +	[SDXI_GSV_STOP]     = "stopped",
> +	[SDXI_GSV_INIT]     = "initializing",
> +	[SDXI_GSV_ACTIVE]   = "active",
> +	[SDXI_GSV_STOPG_SF] = "soft stopping",
> +	[SDXI_GSV_STOPG_HD] = "hard stopping",
> +	[SDXI_GSV_ERROR]    = "error",
> +};
> +
> +static const char *gsv_str(enum sdxi_fn_gsv gsv)
> +{
> +	if ((size_t)gsv < ARRAY_SIZE(gsv_strings))
> +		return gsv_strings[(size_t)gsv];
> +
> +	WARN_ONCE(1, "unexpected gsv %u\n", gsv);
> +
> +	return "unknown";
> +}
> +
> +enum sdxi_fn_gsr {
> +	SDXI_GSRV_RESET   = 0,
> +	SDXI_GSRV_STOP_SF = 1,
> +	SDXI_GSRV_STOP_HD = 2,
> +	SDXI_GSRV_ACTIVE  = 3,
> +};
> +
> +static enum sdxi_fn_gsv sdxi_dev_gsv(const struct sdxi_dev *sdxi)
> +{
> +	u64 sts0 = sdxi_read64(sdxi, SDXI_MMIO_STS0);
> +	enum sdxi_fn_gsv gsv = FIELD_GET(SDXI_MMIO_STS0_FN_GSV, sts0);
> +
> +	switch (gsv) {
> +	case SDXI_GSV_STOP ... SDXI_GSV_ERROR:
> +		break;
> +	default:
> +		dev_warn_ratelimited(sdxi->dev, "unknown gsv %u\n", gsv);
> +		break;
> +	}
> +
> +	return gsv;
> +}
> +
> +static const unsigned long gsv_poll_interval_us = USEC_PER_MSEC;
> +static const unsigned long gsv_transition_timeout_us = USEC_PER_SEC;
> +
> +#define sdxi_dev_gsv_poll(sdxi, val, cond)				\
> +	read_poll_timeout(sdxi_dev_gsv, val, cond, gsv_poll_interval_us, \
> +			  gsv_transition_timeout_us, false, sdxi)
> +
> +static void sdxi_write_fn_gsr(struct sdxi_dev *sdxi, enum sdxi_fn_gsr cmd)
> +{
> +	u64 ctl0 = sdxi_read64(sdxi, SDXI_MMIO_CTL0);
> +
> +	FIELD_MODIFY(SDXI_MMIO_CTL0_FN_GSR, &ctl0, cmd);
> +	sdxi_write64(sdxi, SDXI_MMIO_CTL0, ctl0);
> +}
> +
> +/* Get the device to the GSV_STOP state. */
> +static int sdxi_dev_stop(struct sdxi_dev *sdxi)
> +{
> +	enum sdxi_fn_gsv status = sdxi_dev_gsv(sdxi);
> +	int ret;
> +
> +	dev_dbg(sdxi->dev, "attempting stop, current state: %s\n",
> +		gsv_str(status));
> +
> +	switch (status) {
> +	case SDXI_GSV_INIT:
> +	case SDXI_GSV_ACTIVE:
> +		sdxi_write_fn_gsr(sdxi, SDXI_GSRV_STOP_SF);
> +		break;
> +	case SDXI_GSV_STOPG_SF:
> +		sdxi_write_fn_gsr(sdxi, SDXI_GSRV_STOP_HD);
> +		break;
> +	case SDXI_GSV_STOPG_HD:
> +	case SDXI_GSV_ERROR:
> +		/*
> +		 * If hard-stopping, there's nothing to do but wait.
> +		 * If in error state, the reset is issued below.
> +		 */
> +		break;
> +	default:
> +		/* Unrecognized state; try a reset. */
> +		sdxi_write_fn_gsr(sdxi, SDXI_GSRV_RESET);
> +		break;
> +	}
> +
> +	/* Wait for transition to either stop or error state. */
> +	ret = sdxi_dev_gsv_poll(sdxi, status,
> +				status == SDXI_GSV_STOP ||
> +				status == SDXI_GSV_ERROR);
> +
> +	if (ret == 0 && status == SDXI_GSV_ERROR) {
> +		sdxi_write_fn_gsr(sdxi, SDXI_GSRV_RESET);
> +		ret = sdxi_dev_gsv_poll(sdxi, status, status == SDXI_GSV_STOP);
> +	}
> +
> +	if (ret) {
> +		dev_err(sdxi->dev, "stop timed out, current state: %s\n",
> +			gsv_str(status));
> +		return ret;
> +	}
> +
> +	return 0;
> +}
> +
> +/*
> + * See SDXI 1.0 4.1.8 Activation of the SDXI Function by Software.
> + */
> +static int sdxi_fn_activate(struct sdxi_dev *sdxi)
> +{
> +	u64 version, cap0, cap1, ctl2;
> +	int err;
> +
> +	/*
> +	 * Clear any existing configuration from MMIO_CTL0 and ensure
> +	 * the function is in GSV_STOP state.
> +	 */
> +	sdxi_write64(sdxi, SDXI_MMIO_CTL0, 0);
> +	err = sdxi_dev_stop(sdxi);
> +	if (err)
> +		return err;
> +
> +	version = sdxi_read64(sdxi, SDXI_MMIO_VERSION);
> +	dev_info(sdxi->dev, "SDXI %llu.%llu device found\n",
> +		  FIELD_GET(SDXI_MMIO_VERSION_MAJOR, version),
> +		  FIELD_GET(SDXI_MMIO_VERSION_MINOR, version));
> +
> +	/* Read capabilities and features. */
> +	cap0 = sdxi_read64(sdxi, SDXI_MMIO_CAP0);
> +	sdxi->db_stride = SZ_4K;
> +	sdxi->db_stride *= 1U << FIELD_GET(SDXI_MMIO_CAP0_DB_STRIDE, cap0);
> +
> +	cap1 = sdxi_read64(sdxi, SDXI_MMIO_CAP1);
> +	sdxi->op_grp_cap = FIELD_GET(SDXI_MMIO_CAP1_OPB_000_CAP, cap1);
> +	sdxi->max_cxtid = FIELD_GET(SDXI_MMIO_CAP1_MAX_CXT, cap1);
> +
> +	/* Apply our configuration. */
> +	ctl2 = FIELD_PREP(SDXI_MMIO_CTL2_MAX_CXT, sdxi->max_cxtid);
> +	ctl2 |= FIELD_PREP(SDXI_MMIO_CTL2_MAX_BUFFER,
> +			   FIELD_GET(SDXI_MMIO_CAP1_MAX_BUFFER, cap1));
> +	ctl2 |= FIELD_PREP(SDXI_MMIO_CTL2_MAX_AKEY_SZ,
> +			   FIELD_GET(SDXI_MMIO_CAP1_MAX_AKEY_SZ, cap1));
> +	ctl2 |= FIELD_PREP(SDXI_MMIO_CTL2_OPB_000_AVL,
> +			   FIELD_GET(SDXI_MMIO_CAP1_OPB_000_CAP, cap1));
> +	sdxi_write64(sdxi, SDXI_MMIO_CTL2, ctl2);
> +
> +	return 0;
> +}
> +
>  int sdxi_register(struct device *dev, const struct sdxi_bus_ops *ops)
>  {
>  	struct sdxi_dev *sdxi;
> +	int err;
>
>  	sdxi = devm_kzalloc(dev, sizeof(*sdxi), GFP_KERNEL);
>  	if (!sdxi)
> @@ -22,5 +188,9 @@ int sdxi_register(struct device *dev, const struct sdxi_bus_ops *ops)
>  	sdxi->bus_ops = ops;
>  	dev_set_drvdata(dev, sdxi);
>
> -	return sdxi->bus_ops->init(sdxi);
> +	err = sdxi->bus_ops->init(sdxi);
> +	if (err)
> +		return err;
> +
> +	return sdxi_fn_activate(sdxi);
>  }
> diff --git a/drivers/dma/sdxi/mmio.h b/drivers/dma/sdxi/mmio.h
> new file mode 100644
> index 000000000000..c9a11c3f2f76
> --- /dev/null
> +++ b/drivers/dma/sdxi/mmio.h
> @@ -0,0 +1,51 @@
> +/* SPDX-License-Identifier: GPL-2.0-only */
> +
> +/*
> + * SDXI MMIO register offsets and layouts.
> + *
> + * Copyright Advanced Micro Devices, Inc.
> + */
> +
> +#ifndef DMA_SDXI_MMIO_H
> +#define DMA_SDXI_MMIO_H
> +
> +#include <linux/bits.h>
> +
> +enum sdxi_reg {
> +	/* SDXI 1.0 9.1 General Control and Status Registers */
> +	SDXI_MMIO_CTL0       = 0x00000,
> +	SDXI_MMIO_CTL2       = 0x00010,
> +	SDXI_MMIO_STS0       = 0x00100,
> +	SDXI_MMIO_CAP0       = 0x00200,
> +	SDXI_MMIO_CAP1       = 0x00208,
> +	SDXI_MMIO_VERSION    = 0x00210,
> +};
> +
> +/* SDXI 1.0 Table 9-2: MMIO_CTL0 */
> +#define SDXI_MMIO_CTL0_FN_GSR         GENMASK_ULL(1, 0)
> +
> +/* SDXI 1.0 Table 9-4: MMIO_CTL2 */
> +#define SDXI_MMIO_CTL2_MAX_BUFFER  GENMASK_ULL(3, 0)
> +#define SDXI_MMIO_CTL2_MAX_AKEY_SZ GENMASK_ULL(15, 12)
> +#define SDXI_MMIO_CTL2_MAX_CXT     GENMASK_ULL(31, 16)
> +#define SDXI_MMIO_CTL2_OPB_000_AVL GENMASK_ULL(63, 32)
> +
> +/* SDXI 1.0 Table 9-5: MMIO_STS0 */
> +#define SDXI_MMIO_STS0_FN_GSV GENMASK_ULL(2, 0)
> +
> +/* SDXI 1.0 Table 9-6: MMIO_CAP0 */
> +#define SDXI_MMIO_CAP0_SFUNC          GENMASK_ULL(15, 0)
> +#define SDXI_MMIO_CAP0_DB_STRIDE      GENMASK_ULL(22, 20)
> +#define SDXI_MMIO_CAP0_MAX_DS_RING_SZ GENMASK_ULL(28, 24)
> +
> +/* SDXI 1.0 Table 9-7: MMIO_CAP1 */
> +#define SDXI_MMIO_CAP1_MAX_BUFFER    GENMASK_ULL(3, 0)
> +#define SDXI_MMIO_CAP1_MAX_AKEY_SZ   GENMASK_ULL(15, 12)
> +#define SDXI_MMIO_CAP1_MAX_CXT       GENMASK_ULL(31, 16)
> +#define SDXI_MMIO_CAP1_OPB_000_CAP   GENMASK_ULL(63, 32)
> +
> +/* SDXI 1.0 Table 9-8: MMIO_VERSION */
> +#define SDXI_MMIO_VERSION_MINOR GENMASK_ULL(7, 0)
> +#define SDXI_MMIO_VERSION_MAJOR GENMASK_ULL(23, 16)
> +
> +#endif  /* DMA_SDXI_MMIO_H */
> diff --git a/drivers/dma/sdxi/sdxi.h b/drivers/dma/sdxi/sdxi.h
> index d4c61ca2f875..84b87066f438 100644
> --- a/drivers/dma/sdxi/sdxi.h
> +++ b/drivers/dma/sdxi/sdxi.h
> @@ -9,8 +9,12 @@
>  #define DMA_SDXI_H
>
>  #include <linux/compiler_types.h>
> +#include <linux/dev_printk.h>
> +#include <linux/io-64-nonatomic-lo-hi.h>
>  #include <linux/types.h>
>
> +#include "mmio.h"
> +
>  struct sdxi_dev;
>
>  /**
> @@ -30,9 +34,24 @@ struct sdxi_dev {
>  	void __iomem *ctrl_regs;	/* virt addr of ctrl registers */
>  	void __iomem *dbs;		/* virt addr of doorbells */
>
> +	/* hardware capabilities (from cap0 & cap1) */
> +	u32 db_stride;			/* doorbell stride in bytes */
> +	u16 max_cxtid;			/* Maximum context ID allowed. */
> +	u32 op_grp_cap;			/* supported operation group cap */
> +
>  	const struct sdxi_bus_ops *bus_ops;
>  };
>
>  int sdxi_register(struct device *dev, const struct sdxi_bus_ops *ops);
>
> +static inline u64 sdxi_read64(const struct sdxi_dev *sdxi, enum sdxi_reg reg)
> +{
> +	return ioread64(sdxi->ctrl_regs + reg);
> +}
> +
> +static inline void sdxi_write64(struct sdxi_dev *sdxi, enum sdxi_reg reg, u64 val)
> +{
> +	iowrite64(val, sdxi->ctrl_regs + reg);
> +}
> +
>  #endif /* DMA_SDXI_H */
>
> --
> 2.54.0
>

