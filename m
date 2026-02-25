Return-Path: <dmaengine+bounces-9092-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gD0UFSEon2nmZAQAu9opvQ
	(envelope-from <dmaengine+bounces-9092-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Wed, 25 Feb 2026 17:49:37 +0100
X-Original-To: lists+dmaengine@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BE1AD19AF65
	for <lists+dmaengine@lfdr.de>; Wed, 25 Feb 2026 17:49:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 6E5883011374
	for <lists+dmaengine@lfdr.de>; Wed, 25 Feb 2026 16:49:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7E683DA7F5;
	Wed, 25 Feb 2026 16:49:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="jhSLs3n8"
X-Original-To: dmaengine@vger.kernel.org
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012032.outbound.protection.outlook.com [52.101.66.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A8963D7D98;
	Wed, 25 Feb 2026 16:49:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772038170; cv=fail; b=Eq6fj/Cv8KiWnmEX8ii5PmefGSqOzaHz4yrpQZWFGy5AI/pmrb2/FL7AWvXFrTJ06onct2Tc8NwH72zG6LYXzh4MDfavYw8gQqaRVYyi+M1RpfyrKo48zTfTpaBUDKlansLbSgHB9YCJUzuXhaLrwx3r9bfhaSlAx6OWZa9P5GU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772038170; c=relaxed/simple;
	bh=Uj0Ip0x73mbn7KIQx54St/y16iYkGkuWBhRXyL4u4Aw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=nhD8qJ+MKi47bUtEtyLXCAK8rqMxoZ1h3XYtuQYQogZYBSQwLO7zeRNPS0p0jQtOGamJfqMzAIeDDxORmbj84TJ9W2JyspeiDU0FeB4HCvTK9+CN2wIrxMWHu5GfUFV4emdBQykC1vA21eqfcVkxIcmJXuD3qhNr8QfBixIlZ4g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=jhSLs3n8; arc=fail smtp.client-ip=52.101.66.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dslthr1zPDsQAc2WluJa37/xXWm6CIbz/rNwdUPeExm+tz/ENw7iDqOQ1rC41uuxdcchM9HYVZUOAVCGk/8SJhzHAjWkvG5kVHL/TLtEnKtX+wGsHooN3eElTZkSQ8Eik2NicMuGZQK2g5Yv1CLyw8zN0HKK1PGnEXvbHQtTmbf5V0YJtK2cZP84D8fO6LF8yhEQZ9t+ckUrkTKO7oVVScPMIfqH/6CBHgAb48gnPq/1aQ4y4O95vzj7AbTo1VIBYpq7PdKHNXjlwkaKENy1uqxkOZTio8qe9OawWKfOCaRTh5G4uYtFOlA2ynN4jWzH9LZATs1N/0Cmi+nYruPN4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wRZUUfHIUQ3azQ1suhXiJdstIvJiZMmGZ3Cu4jUqqM4=;
 b=ens8O3mObyQOgNDKps83tof9ujM3XgmmjZuBBtyY4keYcS1lBftMOPxD7Bdtf8d6qDySPCxGmqa63/zDzWkQn2PbDMsFuJjRpfmy3X3kgqANMyNR0ZxRtfo/XdFKTjrwcEKgRdy19ZelZhHwIPzGjGwXB0EXmGUTz9bDnXUS55BWQ23BT+omVCZ249Ssxia10rOn29+MuQKYAsTRQMgRc6iXTY7DezrYuajPJoGAV+bE8AUUpiXDq2DszJD26e9nB/r+5NxTslzbGDYe5pAF7D+wV7cIWUVh3m36EVMrg8cTZlQHSOM6EDuCY8SMCrLEbSb+ZSMxYwMxulu3Syo5Iw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wRZUUfHIUQ3azQ1suhXiJdstIvJiZMmGZ3Cu4jUqqM4=;
 b=jhSLs3n8pbOMTk+8DImJnZc9GnV3u84ZCwGMB5R2eWbuWyk6k7Q5Xl4AaiwtPzwawHVuDlhpaE1gfJ32NFJ39a4qfNOIfnT3gG0NJ69id0QhZVlD+AVFk71/AcBEEbDkI1OHHnOOiJLotcrBh1+Xw3Rq+9DA+xdcBXClZRA7sGaIuz37EEEGeuaAqtqaNEMcWbsCG56T0DBrRxBg90REDRzK0qRq3z5y6NiheLeGDWwk7qGCIC+JBel1es7TAlz7HAWSA/HZ2raOeyBdbruslr7nCJK6MyPJZ/Ndh0x3sUyBZGe1wnk98U1fkK2hfWINmScmxlJok0MwDDZPyY7rlA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PA4PR04MB9366.eurprd04.prod.outlook.com (2603:10a6:102:2a9::8)
 by PA1PR04MB12174.eurprd04.prod.outlook.com (2603:10a6:102:55e::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.21; Wed, 25 Feb
 2026 16:49:26 +0000
Received: from PA4PR04MB9366.eurprd04.prod.outlook.com
 ([fe80::75e4:8143:ddbc:6588]) by PA4PR04MB9366.eurprd04.prod.outlook.com
 ([fe80::75e4:8143:ddbc:6588%6]) with mapi id 15.20.9632.017; Wed, 25 Feb 2026
 16:49:26 +0000
Date: Wed, 25 Feb 2026 11:49:19 -0500
From: Frank Li <Frank.li@nxp.com>
To: Claudiu <claudiu.beznea@tuxon.dev>
Cc: vkoul@kernel.org, geert+renesas@glider.be, biju.das.jz@bp.renesas.com,
	fabrizio.castro.jz@renesas.com,
	prabhakar.mahadev-lad.rj@bp.renesas.com, dmaengine@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Subject: Re: [PATCH v8 8/8] dmaengine: sh: rz-dmac: Add
 device_{pause,resume}() callbacks
Message-ID: <aZ8oD_kcEE6lrTDC@lizhi-Precision-Tower-5810>
References: <20260120133330.3738850-1-claudiu.beznea.uj@bp.renesas.com>
 <20260120133330.3738850-9-claudiu.beznea.uj@bp.renesas.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260120133330.3738850-9-claudiu.beznea.uj@bp.renesas.com>
X-ClientProxiedBy: SN6PR08CA0019.namprd08.prod.outlook.com
 (2603:10b6:805:66::32) To PA4PR04MB9366.eurprd04.prod.outlook.com
 (2603:10a6:102:2a9::8)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR04MB9366:EE_|PA1PR04MB12174:EE_
X-MS-Office365-Filtering-Correlation-Id: 67fc7c32-fb35-440c-a3b0-08de748dd592
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|52116014|366016|19092799006|38350700014;
X-Microsoft-Antispam-Message-Info:
	j/XctvsefWsRxMKjbQFmTuqjKN1qsa3lBRGPh7eEYM635nQ7OLwssqCFgxXAHdV+JpxcL/yUlkgzCW17yQSXVoEt3fd4QRKgUkh2JnreM+J2L9bOXc+6uENC2yJpxWkXtA45a9YWtaEsyaXn0gd2J7KUtTBwwNya6EsErH2NpF92XH05E0sYDhElmZ7+YP2yWvRpLQLW0TZQRey30iCymJxyn2FhbLWYL6eHtPDBxclNMjcySsuLB/NuGXtPSYFQ/sK2ousthnx8o5gcRfggWL9UeZh7x30h4LK7RNdULt46OHFjJBVEfUJmuSS/Jy12FxzEOHEMwW0xSD/Lg/tV2eOPzcdJXyrDG1Y21++O59pms1Wm3KfK3BIJ4ZKnvgRFScxarU5CjqpR6Ft8CKmSCukE0YFW1/uHUB3yIfwafk8b9JJIHML2eCgKg5PZGNA0HPy46HPzQfTynKQ5+6WUss4zVoLbRa7ZEQG5EkoWmVf3zcI6w2kUAdXgnBepNxaUJpsxEVQ+s+mHXRCeJGrL/dOnMdkuU9THYB4DaquUdyPl0qo9acPXAvDqcYYtF7ZFbdp9KF/sq04sVvgHH3bprJbeanNilSjCvTr8ANZxzdstEjmqBt+CsLlN+Th8Yu44EG+Wz1uTmAQoXrPLNE+o+1dSzLxMaaNR+mziTWOE+KIit72vt9mIDHlthaw1RcFPObv+CbUh6BKRwWclT+6+0UuTHNAlHbM80i9Y2iZRucsTgKKQvZNFRNTdjD/VcZUJ2THDsPe8MYVyhXx+7uxsphcJ6ku7JxDmNtSDP/P9Yag=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB9366.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(52116014)(366016)(19092799006)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?g009TCv3s932SA6Pk4KpCM8974k5S+zFttpxnQA+ZGnlnCCd/3bSNb+ttnRo?=
 =?us-ascii?Q?DqIVxMmJDXaG536Vv1He15Iv4LcFScziA1nDsmrC4uGJ4AMKACVMReBqbnOp?=
 =?us-ascii?Q?xNB7Hh3vIZYMoZsbjmmd5kwup/qOdU+jM16Y2CZ0KwdAuKqWsyr998i7+xJK?=
 =?us-ascii?Q?T3JZZKUMJi9E/Qz8dHjDorgm2GCHSHfSQi4edajeorQ4jW24aFtvain/WMM/?=
 =?us-ascii?Q?+ICOiNVgExC8JQcVY9+G8RAwNC18swmg4v8B/VJDi9E/z0lUcBpNxm99qKWd?=
 =?us-ascii?Q?7gNGXytTzCyq0DAo07X89U4o4ZnyG2/9KtVWHsNXcAYLjj8xGuH6fXmG12+o?=
 =?us-ascii?Q?o8L1iJKR813qp2AE6nuUhFifZPeOITj07S8CPZGICrA/IFc5KpgwSHIJOxTy?=
 =?us-ascii?Q?iEf8qsRkqVbHtconqM2Gl6kKaUeWCWVd+hbzIpcUkMariE5D8TZ1rVKTPCd8?=
 =?us-ascii?Q?AoAAuKZqci5xpl62d7cJCjjdXkYSJxECgZqbUthQ1VFlItCDGQGA8T0NEk11?=
 =?us-ascii?Q?FCA4Xjxtg1x5TEVYz6UlL8ZawMTgcdJMCwag5d2NpugolkYR5zbc4CC2Lc7d?=
 =?us-ascii?Q?De2EZj/f6m/zgC4OuW2h5IILSsmjk03t7zihZ1VOYi+iDLnnvxojfhl12t+6?=
 =?us-ascii?Q?QvF78NI/wkb2w+llV/rfXwcDY3dTVB8Zyq4s4jIZY9Fpg/LYPXf3cbmGY7Z9?=
 =?us-ascii?Q?wa8tza8DJJuNgp5s1eTS7g7lozOpjgnx4ZCw1NO5VpozZzbHiltCAJjM0AXM?=
 =?us-ascii?Q?oq2y2pmRTxLOTm5liFzUAfkWcwrQ+IHxKooGpt4Mfmt+HRDP0Iabaf49rQ65?=
 =?us-ascii?Q?ISJabkaCeWCRQ6ej84D/bXlsjYhhiQh51tQA7fj85c4P5Gq9Lz7LEta8DApp?=
 =?us-ascii?Q?hW37y1eZT+l06W3AfysBmp2mKADU/TkGgouQH6yvMfdk2y55XKR90Ynn9dGL?=
 =?us-ascii?Q?ic+EHwpg1AV/gzoS8BZAAROOqE6WqKv61aDxcajl8W75f6bLPvP/ewqt/LrZ?=
 =?us-ascii?Q?QXRZ9F74LyIb6Zw7sioeEg3LsFvRILb7x0UWa+GkCaLfn5vByof1FHiFKfFW?=
 =?us-ascii?Q?DWMnLTKuhhpdV5O5zslVauiIrgmvmkec3C5eWTY+nGKwSV0cKx1tZZxyogKa?=
 =?us-ascii?Q?a5Aga3UBQvlJnF7Sijamj8HG04FzVjzr31oM+ITYr0blCHD+eh0sHqnrPC5O?=
 =?us-ascii?Q?EUG6jvcxAwNp87LGfjMqRqezVnrjRL9quZ+ytj6xCkk5X6fJ9k37Zew2h/Wh?=
 =?us-ascii?Q?74J4SKRZVzJL0BHeoGxaKQufCRrH9loxqUXzjDCAIye0aJPd0+39ot+Bt0fs?=
 =?us-ascii?Q?XaqMUdg3MFM7OF2c8rlsQhhAoiHq9UeZLi3/Gsc9Qv4kkSaNFbnBT3NmRxOT?=
 =?us-ascii?Q?qbep3Bg3b423B4dVPCRmRKs142Ek4fIydPZ2UOt28pHv0RzW4lnkzWS7U/Tq?=
 =?us-ascii?Q?eBHgE8laWtfchyHptFBDk3ooM3cQ2B8f6D8PPqCDcXcPL+d3Hly6EXDDCy6m?=
 =?us-ascii?Q?ulvoH3HD+aW6Wwt5pxAZGZ1WngOkRecJHQPo+xQZuL70GKeNfBmN7+fK97VR?=
 =?us-ascii?Q?zP0YoDAbcfJvTzrkNfwPmYvN7jBSTepMA213+YvPy0mBmnfKuzJ8y5O4ISRz?=
 =?us-ascii?Q?JmyDDP3IBtLQb27k+tSIQ0fzacS1lW1TxbjGZ/YLg2t8C1at4qfg3R1HJenE?=
 =?us-ascii?Q?ThhVYbqkvp5aX9iPh2NvF5LyyCIaBsVbqZxaW3juppnEMozs?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 67fc7c32-fb35-440c-a3b0-08de748dd592
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB9366.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Feb 2026 16:49:25.9302
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: J121H+SQzi4fgyiu+1aadT/+Nt+nFDavud8mEoXVptuSbizGGS7UAu79O+DYOQ5AOMhb1i98yy/Pq+KO4ipe+A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR04MB12174
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nxp.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[nxp.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-9092-lists,dmaengine=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[nxp.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[Frank.li@nxp.com,dmaengine@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[dmaengine,renesas];
	RCPT_COUNT_SEVEN(0.00)[9];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nxp.com:dkim,renesas.com:email,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: BE1AD19AF65
X-Rspamd-Action: no action

On Tue, Jan 20, 2026 at 03:33:30PM +0200, Claudiu wrote:
> From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
>
> Add support for device_{pause, resume}() callbacks. These are required by
> the RZ/G2L SCIFA driver.

"These are required by the RZ/G2L SCIFA driver", is not good enough. Can
you descript why RZ/G2L SCIFA require it?

Frank

>
> Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
> ---
>
> Changes in v8:
> - reported residue for paused channels as well
>
> Changes in v7:
> - use guard() instead of scoped_guard()
> - in rz_dmac_device_pause() checked the channel is enabled
>   before suspending it to avoid read poll timeouts
> - added a comment in rz_dmac_device_resume()
>
> Changes in v6:
> - set CHCTRL_SETSUS for pause and CHCTRL_CLRSUS for resume
> - dropped read-modify-update approach for CHCTRL updates as the
>   HW returns zero when reading CHCTRL
> - moved the read_poll_timeout_atomic() under spin lock to
>   ensure avoid any races b/w pause and resume functionalities
>
> Changes in v5:
> - used suspend capability of the controller to pause/resume
>   the transfers
>
>  drivers/dma/sh/rz-dmac.c | 49 +++++++++++++++++++++++++++++++++++++---
>  1 file changed, 46 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/dma/sh/rz-dmac.c b/drivers/dma/sh/rz-dmac.c
> index 27c963083e29..caa3335bf95d 100644
> --- a/drivers/dma/sh/rz-dmac.c
> +++ b/drivers/dma/sh/rz-dmac.c
> @@ -141,10 +141,12 @@ struct rz_dmac {
>  #define CHANNEL_8_15_COMMON_BASE	0x0700
>
>  #define CHSTAT_ER			BIT(4)
> +#define CHSTAT_SUS			BIT(3)
>  #define CHSTAT_EN			BIT(0)
>
>  #define CHCTRL_CLRINTMSK		BIT(17)
>  #define CHCTRL_CLRSUS			BIT(9)
> +#define CHCTRL_SETSUS			BIT(8)
>  #define CHCTRL_CLRTC			BIT(6)
>  #define CHCTRL_CLREND			BIT(5)
>  #define CHCTRL_CLRRQ			BIT(4)
> @@ -814,11 +816,18 @@ static enum dma_status rz_dmac_tx_status(struct dma_chan *chan,
>  	if (status == DMA_COMPLETE || !txstate)
>  		return status;
>
> -	scoped_guard(spinlock_irqsave, &channel->vc.lock)
> +	scoped_guard(spinlock_irqsave, &channel->vc.lock) {
> +		u32 val;
> +
>  		residue = rz_dmac_chan_get_residue(channel, cookie);
>
> -	/* if there's no residue, the cookie is complete */
> -	if (!residue)
> +		val = rz_dmac_ch_readl(channel, CHSTAT, 1);
> +		if (val & CHSTAT_SUS)
> +			status = DMA_PAUSED;
> +	}
> +
> +	/* if there's no residue and no paused, the cookie is complete */
> +	if (!residue && status != DMA_PAUSED)
>  		return DMA_COMPLETE;
>
>  	dma_set_residue(txstate, residue);
> @@ -826,6 +835,38 @@ static enum dma_status rz_dmac_tx_status(struct dma_chan *chan,
>  	return status;
>  }
>
> +static int rz_dmac_device_pause(struct dma_chan *chan)
> +{
> +	struct rz_dmac_chan *channel = to_rz_dmac_chan(chan);
> +	u32 val;
> +
> +	guard(spinlock_irqsave)(&channel->vc.lock);
> +
> +	val = rz_dmac_ch_readl(channel, CHSTAT, 1);
> +	if (!(val & CHSTAT_EN))
> +		return 0;
> +
> +	rz_dmac_ch_writel(channel, CHCTRL_SETSUS, CHCTRL, 1);
> +	return read_poll_timeout_atomic(rz_dmac_ch_readl, val,
> +					(val & CHSTAT_SUS), 1, 1024,
> +					false, channel, CHSTAT, 1);
> +}
> +
> +static int rz_dmac_device_resume(struct dma_chan *chan)
> +{
> +	struct rz_dmac_chan *channel = to_rz_dmac_chan(chan);
> +	u32 val;
> +
> +	guard(spinlock_irqsave)(&channel->vc.lock);
> +
> +	/* Do not check CHSTAT_SUS but rely on HW capabilities. */
> +
> +	rz_dmac_ch_writel(channel, CHCTRL_CLRSUS, CHCTRL, 1);
> +	return read_poll_timeout_atomic(rz_dmac_ch_readl, val,
> +					!(val & CHSTAT_SUS), 1, 1024,
> +					false, channel, CHSTAT, 1);
> +}
> +
>  /*
>   * -----------------------------------------------------------------------------
>   * IRQ handling
> @@ -1164,6 +1205,8 @@ static int rz_dmac_probe(struct platform_device *pdev)
>  	engine->device_terminate_all = rz_dmac_terminate_all;
>  	engine->device_issue_pending = rz_dmac_issue_pending;
>  	engine->device_synchronize = rz_dmac_device_synchronize;
> +	engine->device_pause = rz_dmac_device_pause;
> +	engine->device_resume = rz_dmac_device_resume;
>
>  	engine->copy_align = DMAENGINE_ALIGN_1_BYTE;
>  	dma_set_max_seg_size(engine->dev, U32_MAX);
> --
> 2.43.0
>

