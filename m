Return-Path: <dmaengine+bounces-7440-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 47C95C98E8B
	for <lists+dmaengine@lfdr.de>; Mon, 01 Dec 2025 20:50:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id BB0C534502C
	for <lists+dmaengine@lfdr.de>; Mon,  1 Dec 2025 19:50:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A078F23C4FF;
	Mon,  1 Dec 2025 19:50:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="H6uH0CDH"
X-Original-To: dmaengine@vger.kernel.org
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011014.outbound.protection.outlook.com [52.101.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26984228CB0;
	Mon,  1 Dec 2025 19:50:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764618636; cv=fail; b=s2ylE4Tn6v2Qw23P3x4r+6/cXLi0bRfxewtZV/xGHcxm0BD+xvMs0Ah3kkVyvtuTlZvpew3lFJhdwp3Z5VCfpj/HB14oLbO0f4MuCGOHmnDW4ynaHYpAV7MH0a2Hirww6PJ4TFvEYhET3ZGtus84o0Cwj4BK3oyu9C8TXVEykcM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764618636; c=relaxed/simple;
	bh=cTeTCtW301biY37i9c/R4TVxAmcePm5fa6TP+l8wzEQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=oTSmljlU+HVjo4tiTSM0AR1Tve5w2gKiqp6sZ4RUXy72/kvcnrKPyIkL28BUqZvdzsJn8Q8QEr9U8EygAl4hwBqz/OGDhX+3AciaOjWHdxOvMDbmIUAwwNn3bLY+/TWEesAu4WYMllRIOC9FdHRrnS7c/rMYzBQgFHsP9ixekQ4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=H6uH0CDH; arc=fail smtp.client-ip=52.101.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ll1OjVd1a5EkeMI57BxHiX6EDRpo0uepYcEQ/2B2z7eeR7Bq5u7RROu+HOosyoXftATIVSSf7xeQ3vFRHPBS38PgId0U4yUbCVd0sU8xBkRjd/Sd5iSSBkoc47ZbUNdCaVMDIIUwOyElUwKYtFlj/AUhWRqA9yHUB+AxN/gk3DdBhVjWkCg1IBeWnd8iGfLFpPd7VgtetMvL732mgffJeUfcWgOnKKZrrIjDwjLysba87iEvMr0fA6GASSSIe5cwrSautQMZ9RQ9KOgCYNZObGhJ71CVZBV2jtiZ0Aw+IAgpTxOEYHixS8AcDRc7HpHRJaoUJgslP4rleFhoaxXfpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Wlb60V5RsDbCLoFYY1YMz3u9GGUxNUylrya91hBKfhg=;
 b=gpnH91xM5E5Di5VEvG4JWY5L8wqLYu5hj56euLz0+czJyaLrLu5L7fzNWSWqAjtWObAL4jkgRIYmILf1AGSmyiJvcptpTdpOpnlkrAsddwhVZ1x0kBX/joM2+gZnms6kDcK4qi+0q8W9AGHG+f56MkFYOnJQzsIZVP/1m8FqowR5YMNll6uSp2r3ugfEe3O2283IbV7nBIzKYUGwzzoAMK14awUPrTbfxQLVzQc649wPaIkFTEiDYUGfIUS6JeO19XLGZffeuu+PGRbSA3/wjL1iW9Vky+Jg9vj0gYYu3t11uhwy0vBiwdZWyw8axpyoGEhoTqag2XpMXuF7iDSApw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Wlb60V5RsDbCLoFYY1YMz3u9GGUxNUylrya91hBKfhg=;
 b=H6uH0CDHqH8Xdf+9mscnM0wPoYfIZX3A7muZPATQIlkyh7Jleb7MbBvLP+6b3+n12q7yozaAM1QOuhqNDFlsaXY6YgSdq5IjS/Hf8HwuCrqcyGvHmZxUkgFiKV8vIrDWTTDd2AHXz/9gQH3TAXxo55hw29PQafSbQ8BCOHGU938O0VIgGaWZc4cA1ZwM6blR4tM1lFCB9yUGRck6onoF1fNZxe6dcd6bIwqWWYMO/SlIHv5XCMuUChsdjhkHfPl1dLWuyoU5LtdkYRqUfnG/nYDMUZxXVNr/Ymvp+zNVoVRhOfNCHVY/502sStdKvAXBgXclkNMkcOTRf2gE4vwgYw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DU2PR04MB8951.eurprd04.prod.outlook.com (2603:10a6:10:2e2::22)
 by GVXPR04MB11587.eurprd04.prod.outlook.com (2603:10a6:150:2c3::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.17; Mon, 1 Dec
 2025 19:50:30 +0000
Received: from DU2PR04MB8951.eurprd04.prod.outlook.com
 ([fe80::753c:468d:266:196]) by DU2PR04MB8951.eurprd04.prod.outlook.com
 ([fe80::753c:468d:266:196%4]) with mapi id 15.20.9366.012; Mon, 1 Dec 2025
 19:50:30 +0000
Date: Mon, 1 Dec 2025 14:50:19 -0500
From: Frank Li <Frank.li@nxp.com>
To: Koichiro Den <den@valinux.co.jp>
Cc: ntb@lists.linux.dev, linux-pci@vger.kernel.org,
	dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
	mani@kernel.org, kwilczynski@kernel.org, kishon@kernel.org,
	bhelgaas@google.com, corbet@lwn.net, vkoul@kernel.org,
	jdmason@kudzu.us, dave.jiang@intel.com, allenbh@gmail.com,
	Basavaraj.Natikar@amd.com, Shyam-sundar.S-k@amd.com,
	kurt.schwemmer@microsemi.com, logang@deltatee.com,
	jingoohan1@gmail.com, lpieralisi@kernel.org, robh@kernel.org,
	jbrunet@baylibre.com, fancer.lancer@gmail.com, arnd@arndb.de,
	pstanner@redhat.com, elfring@users.sourceforge.net
Subject: Re: [RFC PATCH v2 13/27] NTB: ntb_transport: Use seq_file for QP
 stats debugfs
Message-ID: <aS3xe0CNHeIMUu7P@lizhi-Precision-Tower-5810>
References: <20251129160405.2568284-1-den@valinux.co.jp>
 <20251129160405.2568284-14-den@valinux.co.jp>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251129160405.2568284-14-den@valinux.co.jp>
X-ClientProxiedBy: SJ0PR03CA0246.namprd03.prod.outlook.com
 (2603:10b6:a03:3a0::11) To DU2PR04MB8951.eurprd04.prod.outlook.com
 (2603:10a6:10:2e2::22)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PR04MB8951:EE_|GVXPR04MB11587:EE_
X-MS-Office365-Filtering-Correlation-Id: ee06f47a-c73b-417f-65f1-08de3112e234
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|19092799006|52116014|376014|7416014|366016|38350700014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?hTJiDKEp2Oq8glgzlPNXUN1YY8pFqjgLoAPsp4jJgUX8byiOgEhdWLDMkfsl?=
 =?us-ascii?Q?pRdswhaIu/eae+S/PFB0g/8HlW1RqlFmsI67E9frejD9km6x7qMV+YJ+V8u3?=
 =?us-ascii?Q?9Yh7KnXoycMIDmfFnAmuf+kig5inRRtF6FBt/jvmjAmsDnABksBqHjd+DHEY?=
 =?us-ascii?Q?e5tb+LCgt36fyE6IEJmkadVkBg9PRF6+QRTGvz7zEU+OYmieVJZzr/USIjBI?=
 =?us-ascii?Q?3h61p2fL8W8TcGqGpGuRolK9CB57UhPyTwoFOaEOsVFf3aTzerj7LpaTzxva?=
 =?us-ascii?Q?Bi8IPrwmyKtsgx9nJm2yU+p4rZMxAMCh4kjbma13WQP+2xlfwzePGismMPnt?=
 =?us-ascii?Q?Y0wod5pkjzDr4XvOj/C9GY1fYQjTKR60jXlGvz/Hdgnu1ROVk0M/IbaErQXF?=
 =?us-ascii?Q?w3AXsrtfwFx3RSL+qcI+bYl+YUKOx6RTtZqwCkw0QRH1A1C3RhNJkEtHlMBy?=
 =?us-ascii?Q?W/4QPNLV5vCk6XBLfFjX8CbLyZDPNMnXTCJL4PyMrAZ9mIyq5BGsW5+sAvf6?=
 =?us-ascii?Q?jVOgHGtkdcTR14s99RStLRqyMuRAcfsDUkSOOm9PBHbGrnBZ4uWcE1ZPusHF?=
 =?us-ascii?Q?X3pfdKAm61oki9gFA9jJ5YVnOc/nhtmahXmHy1kCKb1roAZNJ4CuIno8kXur?=
 =?us-ascii?Q?fm3dQHnTTbuY0t0MSC9n4URN8/5fRukjc3j5EiwuWiWMU5KpKqKUmF8T7Owl?=
 =?us-ascii?Q?Mv82NAwqjFXwg235eHIoe+ldw8mifQDjRKohfgzTsUqCs/Pdty9gs9e5qn28?=
 =?us-ascii?Q?o5SeZtLSbTGAm6lswFqvIb/79L0oPjBp78FsI2Zz+BLOPqDi2iHxsWk+VYxI?=
 =?us-ascii?Q?EUq+DLRqZnmPTpHN+U2eZD/CKoHc78Uhe34t3Iyz2MGTaNrs9hLgfz63artK?=
 =?us-ascii?Q?JUeJvbBo8w7PmNAKFIBbgAIwP7WHUbe5nvhzMbgEoK1ybhNFgOkMQYS4BmXt?=
 =?us-ascii?Q?j+kqubEqZkOxyJsRNpuIydK43SHP16hQqMCBMlWx2OJPYYqVb2HzhTpod48h?=
 =?us-ascii?Q?pQMJ0/4I6qqjqShhJeQ/DBr7u8vOJiC01z887QZ5u4XLmI1QGERtROX28rkU?=
 =?us-ascii?Q?QOIzCBEzLnAboxSRrqDPl50hfYDKm138HlI0FDAgFHetG5+/+HlxAh7IgM3y?=
 =?us-ascii?Q?M4REF1PU8WLukVPma+uNi5mdUrP3Elp84jNnru+QXJOL3cYjug0kWa5/jDR5?=
 =?us-ascii?Q?htoZAXOJvY0gf2xUnSUnWtPOI4EZiV/pZiy1IWZSfHJIe1phdoIJNyRKCP/C?=
 =?us-ascii?Q?UGyvlAesU3HtrmZa8/hcUCyaGJe14CEMzfBQ1g1LgtjoEiS24M9wD4WL/riI?=
 =?us-ascii?Q?J3kN2xMP6ZpEtkp9B1yen4OdVUIxU05Ks15bACL8bOx2S9sOtEI2HBeCy7BB?=
 =?us-ascii?Q?kwl/gnXMK4t6cKZzrrZ5DajvFXKGDrDjznebhysxsCnLi8TDUCXZLP9Jyxac?=
 =?us-ascii?Q?nzyE74QqEkK5GJKfwp6xYLFATyb6FnP60s4G4KjEm+bTq0n+39OJTysl5oGV?=
 =?us-ascii?Q?87CjoNzX2b1Qr6Ha1/Bd+s50AJo7Gvt6JT2s?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR04MB8951.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(19092799006)(52116014)(376014)(7416014)(366016)(38350700014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?XrOM36XIQHR408m9xFIpesA+896UeeAz0ttQTBMDR1yk1lvdoAD9XHegzrMB?=
 =?us-ascii?Q?/3wAps+5gAed58Of6uTEyVBtR+DwH80ImSE1BvTggmjQQH94JqbLe6PEIixc?=
 =?us-ascii?Q?DwuFgRrCLYzeMs4TJrhRBSstnolV87DyZrRn+z0cx0h3+ZtAgLPizodHba/8?=
 =?us-ascii?Q?ss0+zRBf1OVvxoNxhiYPQC58V4Nm3sE+qZo7Y/WbJsUGl/4nQVYohYeSG6Af?=
 =?us-ascii?Q?tE5phWYGuAXt0zQTCZFUFDdwxJrN9K6gb8qjuBn/fk4gqZUWQEsQibmyxKWJ?=
 =?us-ascii?Q?gInOXgxfMt2ug34oMn8m0u/wYShaPWv99PC/LT415oWrNY/8MQEZD/zF6cm9?=
 =?us-ascii?Q?F2c9uUMygymqfQJ7kO9cklB7B+eoMnbGfweTGgynMMK0yr2QSpk5/bCRsUrp?=
 =?us-ascii?Q?xWW0abt+SqAy0xdWbP8HkX9LYRsC1gPFlMvFre47+3qq3MYS0xpthRsjUhDD?=
 =?us-ascii?Q?AVuj7LrH8xjK6M4X662ERnBG4H4c6wgcmn3L7oUcWYkT60ER7zXBRq1zQTtL?=
 =?us-ascii?Q?HNw5MhfY8znSRCfabAp7Et4RN5MQaD5fHjDikENwXKyN5PfYuaUO58ruEEs7?=
 =?us-ascii?Q?c/QFgfewJ8t2OymPOEsnRXQAakORr7MXncZRjUz7sb1ACOIkdlc/2LVWtGT3?=
 =?us-ascii?Q?SEC+aq+ApIItn1HwZF8O+SfLw4pmQkpc9IsyY880Ad6foQHqdB3lBBET9YbX?=
 =?us-ascii?Q?JQRXXzGoXJYcCrJam9h7kRvAysR/Vw5TMRuxkOJ1gH0SK6vmOFflZ5j77JLo?=
 =?us-ascii?Q?+zHQbEpYWAr5HTfmeXV1FsN8jqqhSfKHki1nM7GbEXxp9K3w8j2V6Pac02Bm?=
 =?us-ascii?Q?8G696N7pzsPEoVLCUsJSYQcD+0E9laNGEAPuqkEAA/pWwCLjIg8AIYthbTg4?=
 =?us-ascii?Q?RMAMZKdaMYOrwodGnjyAR6182JVSfntNtldYGSbLhMh6uhu1AeEQsDcor336?=
 =?us-ascii?Q?SVB7H/8dBooZhmhX6VzewRnjd9k2KvDCR2jIMXGVmKdqAtNj3q6iB6ridF2g?=
 =?us-ascii?Q?KITOQxUFreGp/z60PqK5qz8UIfrMgQAVVWi+R1L4QhOxHNQmAlg9Piccy/NI?=
 =?us-ascii?Q?d471DH2p5SNEZLQDtZaoYnrC+QzuOdx+AzJVWftCqG9zXGMS8zsw9QOC8+ca?=
 =?us-ascii?Q?MUd/FRbAMgl7nhS+gupUYrUVEWgEjPlCyV3dpfKm7RhlERAGI2X2UWqHf0MI?=
 =?us-ascii?Q?IcJpBSyrQ2/AyOwk8T9VLjecKGQ5HntMgEXwDDtbU0xEh6XKWGhopjSC4JQM?=
 =?us-ascii?Q?Fikapmpf8e6tabgI/aS1gKHIGoPmWd0aTQtqgU8IV7qNwvGv7ucR6KDZ29XU?=
 =?us-ascii?Q?K2HGOlqrBIeMUc+VfWpcyFsryHmzEQ36VePT0GwLNiBxsYNNTvfmDxGEBFSK?=
 =?us-ascii?Q?/mJa9uHlyC3pHaHDt2zY7blB42CQKNiwvcGSVvcF020IrkRCzh4N9W/c4pw7?=
 =?us-ascii?Q?0ynW2FH0WIAL0XLIgkyFgwbGDTpJTJjtYinw8IsvW+warZlLp3g44chgR3fH?=
 =?us-ascii?Q?KNCccyAFnE/TXzTADwVZjjkEGNJZ5W+kxRiY01KeD64q8ro/6cu3+PllzZ+l?=
 =?us-ascii?Q?u8/pb7LH8ac/F7UU0fAZjAWamezpGDPquRPD7Tdb?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ee06f47a-c73b-417f-65f1-08de3112e234
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB8951.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Dec 2025 19:50:30.8763
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UCM8+AvS+iNOxc3fNq665Uqoj38cxj88kPKEXotWoRfWetrzE9Y07PKaPq8lJ944ohZa1OOWCCkDjDHA5bxWBw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB11587

On Sun, Nov 30, 2025 at 01:03:51AM +0900, Koichiro Den wrote:
> The ./qp*/stats debugfs file for each NTB transport QP is currently
> implemented with a hand-crafted kmalloc() buffer and a series of
> scnprintf() calls. This is a pre-seq_file style pattern and makes future
> extensions easy to truncate.
>
> Convert the stats file to use the seq_file helpers via
> DEFINE_SHOW_ATTRIBUTE(), which simplifies the code and lets the seq_file
> core handle buffering and partial reads.
>
> While touching this area, fix a bug in the per-QP debugfs directory
> naming: the buffer used for "qp%d" was only 4 bytes, which truncates
> names like "qp10" to "qp1" and causes multiple queues to share the same
> directory. Enlarge the buffer and use sizeof() to avoid truncation.
>
> Signed-off-by: Koichiro Den <den@valinux.co.jp>
> ---

This one is indenpented with other,  you may post seperately. So get merge
this simple change quick.

Reviewed-by: Frank Li <Frank.Li@nxp.com>
>  drivers/ntb/ntb_transport.c | 136 +++++++++++-------------------------
>  1 file changed, 41 insertions(+), 95 deletions(-)
>
> diff --git a/drivers/ntb/ntb_transport.c b/drivers/ntb/ntb_transport.c
> index 3f3bc991e667..57b4c0511927 100644
> --- a/drivers/ntb/ntb_transport.c
> +++ b/drivers/ntb/ntb_transport.c
> @@ -57,6 +57,7 @@
>  #include <linux/module.h>
>  #include <linux/pci.h>
>  #include <linux/slab.h>
> +#include <linux/seq_file.h>
>  #include <linux/types.h>
>  #include <linux/uaccess.h>
>  #include <linux/mutex.h>
> @@ -466,104 +467,49 @@ void ntb_transport_unregister_client(struct ntb_transport_client *drv)
>  }
>  EXPORT_SYMBOL_GPL(ntb_transport_unregister_client);
>
> -static ssize_t debugfs_read(struct file *filp, char __user *ubuf, size_t count,
> -			    loff_t *offp)
> +static int ntb_qp_debugfs_stats_show(struct seq_file *s, void *v)
>  {
> -	struct ntb_transport_qp *qp;
> -	char *buf;
> -	ssize_t ret, out_offset, out_count;
> -
> -	qp = filp->private_data;
> +	struct ntb_transport_qp *qp = s->private;
>
>  	if (!qp || !qp->link_is_up)
>  		return 0;
>
> -	out_count = 1000;
> -
> -	buf = kmalloc(out_count, GFP_KERNEL);
> -	if (!buf)
> -		return -ENOMEM;
> +	seq_puts(s, "\nNTB QP stats:\n\n");
> +
> +	seq_printf(s, "rx_bytes - \t%llu\n", qp->rx_bytes);
> +	seq_printf(s, "rx_pkts - \t%llu\n", qp->rx_pkts);
> +	seq_printf(s, "rx_memcpy - \t%llu\n", qp->rx_memcpy);
> +	seq_printf(s, "rx_async - \t%llu\n", qp->rx_async);
> +	seq_printf(s, "rx_ring_empty - %llu\n", qp->rx_ring_empty);
> +	seq_printf(s, "rx_err_no_buf - %llu\n", qp->rx_err_no_buf);
> +	seq_printf(s, "rx_err_oflow - \t%llu\n", qp->rx_err_oflow);
> +	seq_printf(s, "rx_err_ver - \t%llu\n", qp->rx_err_ver);
> +	seq_printf(s, "rx_buff - \t0x%p\n", qp->rx_buff);
> +	seq_printf(s, "rx_index - \t%u\n", qp->rx_index);
> +	seq_printf(s, "rx_max_entry - \t%u\n", qp->rx_max_entry);
> +	seq_printf(s, "rx_alloc_entry - \t%u\n\n", qp->rx_alloc_entry);
> +
> +	seq_printf(s, "tx_bytes - \t%llu\n", qp->tx_bytes);
> +	seq_printf(s, "tx_pkts - \t%llu\n", qp->tx_pkts);
> +	seq_printf(s, "tx_memcpy - \t%llu\n", qp->tx_memcpy);
> +	seq_printf(s, "tx_async - \t%llu\n", qp->tx_async);
> +	seq_printf(s, "tx_ring_full - \t%llu\n", qp->tx_ring_full);
> +	seq_printf(s, "tx_err_no_buf - %llu\n", qp->tx_err_no_buf);
> +	seq_printf(s, "tx_mw - \t0x%p\n", qp->tx_mw);
> +	seq_printf(s, "tx_index (H) - \t%u\n", qp->tx_index);
> +	seq_printf(s, "RRI (T) - \t%u\n", qp->remote_rx_info->entry);
> +	seq_printf(s, "tx_max_entry - \t%u\n", qp->tx_max_entry);
> +	seq_printf(s, "free tx - \t%u\n", ntb_transport_tx_free_entry(qp));
> +	seq_putc(s, '\n');
> +
> +	seq_printf(s, "Using TX DMA - \t%s\n", qp->tx_dma_chan ? "Yes" : "No");
> +	seq_printf(s, "Using RX DMA - \t%s\n", qp->rx_dma_chan ? "Yes" : "No");
> +	seq_printf(s, "QP Link - \t%s\n", qp->link_is_up ? "Up" : "Down");
> +	seq_putc(s, '\n');
>
> -	out_offset = 0;
> -	out_offset += scnprintf(buf + out_offset, out_count - out_offset,
> -			       "\nNTB QP stats:\n\n");
> -	out_offset += scnprintf(buf + out_offset, out_count - out_offset,
> -			       "rx_bytes - \t%llu\n", qp->rx_bytes);
> -	out_offset += scnprintf(buf + out_offset, out_count - out_offset,
> -			       "rx_pkts - \t%llu\n", qp->rx_pkts);
> -	out_offset += scnprintf(buf + out_offset, out_count - out_offset,
> -			       "rx_memcpy - \t%llu\n", qp->rx_memcpy);
> -	out_offset += scnprintf(buf + out_offset, out_count - out_offset,
> -			       "rx_async - \t%llu\n", qp->rx_async);
> -	out_offset += scnprintf(buf + out_offset, out_count - out_offset,
> -			       "rx_ring_empty - %llu\n", qp->rx_ring_empty);
> -	out_offset += scnprintf(buf + out_offset, out_count - out_offset,
> -			       "rx_err_no_buf - %llu\n", qp->rx_err_no_buf);
> -	out_offset += scnprintf(buf + out_offset, out_count - out_offset,
> -			       "rx_err_oflow - \t%llu\n", qp->rx_err_oflow);
> -	out_offset += scnprintf(buf + out_offset, out_count - out_offset,
> -			       "rx_err_ver - \t%llu\n", qp->rx_err_ver);
> -	out_offset += scnprintf(buf + out_offset, out_count - out_offset,
> -			       "rx_buff - \t0x%p\n", qp->rx_buff);
> -	out_offset += scnprintf(buf + out_offset, out_count - out_offset,
> -			       "rx_index - \t%u\n", qp->rx_index);
> -	out_offset += scnprintf(buf + out_offset, out_count - out_offset,
> -			       "rx_max_entry - \t%u\n", qp->rx_max_entry);
> -	out_offset += scnprintf(buf + out_offset, out_count - out_offset,
> -			       "rx_alloc_entry - \t%u\n\n", qp->rx_alloc_entry);
> -
> -	out_offset += scnprintf(buf + out_offset, out_count - out_offset,
> -			       "tx_bytes - \t%llu\n", qp->tx_bytes);
> -	out_offset += scnprintf(buf + out_offset, out_count - out_offset,
> -			       "tx_pkts - \t%llu\n", qp->tx_pkts);
> -	out_offset += scnprintf(buf + out_offset, out_count - out_offset,
> -			       "tx_memcpy - \t%llu\n", qp->tx_memcpy);
> -	out_offset += scnprintf(buf + out_offset, out_count - out_offset,
> -			       "tx_async - \t%llu\n", qp->tx_async);
> -	out_offset += scnprintf(buf + out_offset, out_count - out_offset,
> -			       "tx_ring_full - \t%llu\n", qp->tx_ring_full);
> -	out_offset += scnprintf(buf + out_offset, out_count - out_offset,
> -			       "tx_err_no_buf - %llu\n", qp->tx_err_no_buf);
> -	out_offset += scnprintf(buf + out_offset, out_count - out_offset,
> -			       "tx_mw - \t0x%p\n", qp->tx_mw);
> -	out_offset += scnprintf(buf + out_offset, out_count - out_offset,
> -			       "tx_index (H) - \t%u\n", qp->tx_index);
> -	out_offset += scnprintf(buf + out_offset, out_count - out_offset,
> -			       "RRI (T) - \t%u\n",
> -			       qp->remote_rx_info->entry);
> -	out_offset += scnprintf(buf + out_offset, out_count - out_offset,
> -			       "tx_max_entry - \t%u\n", qp->tx_max_entry);
> -	out_offset += scnprintf(buf + out_offset, out_count - out_offset,
> -			       "free tx - \t%u\n",
> -			       ntb_transport_tx_free_entry(qp));
> -
> -	out_offset += scnprintf(buf + out_offset, out_count - out_offset,
> -			       "\n");
> -	out_offset += scnprintf(buf + out_offset, out_count - out_offset,
> -			       "Using TX DMA - \t%s\n",
> -			       qp->tx_dma_chan ? "Yes" : "No");
> -	out_offset += scnprintf(buf + out_offset, out_count - out_offset,
> -			       "Using RX DMA - \t%s\n",
> -			       qp->rx_dma_chan ? "Yes" : "No");
> -	out_offset += scnprintf(buf + out_offset, out_count - out_offset,
> -			       "QP Link - \t%s\n",
> -			       qp->link_is_up ? "Up" : "Down");
> -	out_offset += scnprintf(buf + out_offset, out_count - out_offset,
> -			       "\n");
> -
> -	if (out_offset > out_count)
> -		out_offset = out_count;
> -
> -	ret = simple_read_from_buffer(ubuf, count, offp, buf, out_offset);
> -	kfree(buf);
> -	return ret;
> -}
> -
> -static const struct file_operations ntb_qp_debugfs_stats = {
> -	.owner = THIS_MODULE,
> -	.open = simple_open,
> -	.read = debugfs_read,
> -};
> +	return 0;
> +}
> +DEFINE_SHOW_ATTRIBUTE(ntb_qp_debugfs_stats);
>
>  static void ntb_list_add(spinlock_t *lock, struct list_head *entry,
>  			 struct list_head *list)
> @@ -1237,15 +1183,15 @@ static int ntb_transport_init_queue(struct ntb_transport_ctx *nt,
>  	qp->tx_max_entry = tx_size / qp->tx_max_frame;
>
>  	if (nt->debugfs_node_dir) {
> -		char debugfs_name[4];
> +		char debugfs_name[8];
>
> -		snprintf(debugfs_name, 4, "qp%d", qp_num);
> +		snprintf(debugfs_name, sizeof(debugfs_name), "qp%d", qp_num);
>  		qp->debugfs_dir = debugfs_create_dir(debugfs_name,
>  						     nt->debugfs_node_dir);
>
>  		qp->debugfs_stats = debugfs_create_file("stats", S_IRUSR,
>  							qp->debugfs_dir, qp,
> -							&ntb_qp_debugfs_stats);
> +							&ntb_qp_debugfs_stats_fops);
>  	} else {
>  		qp->debugfs_dir = NULL;
>  		qp->debugfs_stats = NULL;
> --
> 2.48.1
>

