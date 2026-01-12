Return-Path: <dmaengine+bounces-8223-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B2677D152EF
	for <lists+dmaengine@lfdr.de>; Mon, 12 Jan 2026 21:20:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 09751301F278
	for <lists+dmaengine@lfdr.de>; Mon, 12 Jan 2026 20:19:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 827F1224AE8;
	Mon, 12 Jan 2026 20:19:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="c9zKnXZp"
X-Original-To: dmaengine@vger.kernel.org
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011009.outbound.protection.outlook.com [52.101.70.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E9171E2858
	for <dmaengine@vger.kernel.org>; Mon, 12 Jan 2026 20:19:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768249180; cv=fail; b=Psc7sdVp4frbIDD/+UTxdBnITUuosvEk0QOy1RzsDcwCwFt6Sck7n1CGrA5Z8nMQnoOBjJc8oI4QHBnwn1Wr5A6/av184DsTqXgCvqDTCQtttmbeToONmkpDrOtQ/eiaJM3oea0vK/DlKuWCCe1eIwlS3YVgKTAQ4UExjZVYXdk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768249180; c=relaxed/simple;
	bh=OUeDHFbMrXkTa2UNSd0Q0hmyHxL35JXBlzzKNHe+N14=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=IyCRPey6uaA9ueUTAJzDXza8BFfpyt4Z3Ajo2Sg4P3eolTOtVnaWFA3e8ZPsCpEJ6W6vRlG4RDZyy7yic5Vr+H3X00UegbNSotEmy2VsXsMqiJo91jynj7Ge/pqh01YphJRAoqGIn1dxXkUslM5d8H0y97IgebHbINPLAwdoJRw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=c9zKnXZp; arc=fail smtp.client-ip=52.101.70.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XDKNgMAFR8TMS/M9ZC90RV+4QLxTaqj1J6/vnCPUDC01WDD+iotgBSPx1Z+TB3xi+l0tmnjZ9kEdKBLHyIHovQ1OhEk6BqXJ648OVZLx8hfW70K8zu8bVog+p/+mj4QILiklWB8Nx4d93cCF8qy+HzgeqMkBhWXefAInMyVeVNkj6u7hsC4+azCk0EEN/HSi/N6lo0DOL5ck6M3709XWnOiPDXlOZgoTLFWfqXvLAriuKOe45YTgZt0AO17ieLjNJdg5DNplgv6VVacrAHTp15aldsKCX87oAgY9G5fTlvp2I+v4UI1ChO7ab/csM/puaakPSQI0VW/rp96ZzR80Ww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eI16ndyxdFixZbRz1Q4j0h8+yZ/V4Az72316fnB0V44=;
 b=O1e2Kjeizq1atvTYHTlceyoY6zFEtZtoz7uklXwFGH+iFARW6624oLSyrFVgLQ8a7jHLPn/eGJFHu1XO0O7VAvxSsFE6ZjXvNYmdCRHgxqyMJm3i6rq+TtrWb8qzGCgF+G4dnICy39+JTLvGyquU77UQi6RkFYoPZO5kljeR0QCLLcmOey/JW01TOGs8XevHzCx9Se18qEJz1VJP6VEIJFIiDw2QSKFdDsYyb13AhJ214fYL75ZslrFn7256IzgxAiM0aYBs06DpOtVocuKnJ1n/dHmLjC7Hu+XU5kQ9xZGQxwIpS5Jb+KzDsQrEzOwR67kSbjGVy7EWgtgcaGe6Yg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eI16ndyxdFixZbRz1Q4j0h8+yZ/V4Az72316fnB0V44=;
 b=c9zKnXZpw1mHtpf5pRw7c/r5igAVn0Mpooz8E1wFX4ASkmgTwa5jVZ2msHL1dAo53N97SgqCIaat2uXsW+/2I7Za0lQFRnZwNZgXFabju9tgX7be4oJB/h7rY0mEY/5EdPnQKNIdiKBG1hg4moPjl6ofBfZjtfizzyi1+cS1gDld6o4khA2HGD3l33f0mcC1dT9RuUmjwwMl73JgRoCiReBSwN/mTb/NJRYPBGBca9GFQUeJp0RLVoeLMcYWMcGhqk/ttbdOOSfWfOCqKBiiWLJXJj61DRBSMJoxHqvP15PSrjP1LDhMThzireEyqExRCUtQtWWWxn62dgShZCEQWw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DU2PR04MB8951.eurprd04.prod.outlook.com (2603:10a6:10:2e2::22)
 by GV2PR04MB12216.eurprd04.prod.outlook.com (2603:10a6:150:336::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.7; Mon, 12 Jan
 2026 20:19:36 +0000
Received: from DU2PR04MB8951.eurprd04.prod.outlook.com
 ([fe80::753c:468d:266:196]) by DU2PR04MB8951.eurprd04.prod.outlook.com
 ([fe80::753c:468d:266:196%4]) with mapi id 15.20.9478.004; Mon, 12 Jan 2026
 20:19:35 +0000
Date: Mon, 12 Jan 2026 15:19:29 -0500
From: Frank Li <Frank.li@nxp.com>
To: Logan Gunthorpe <logang@deltatee.com>
Cc: dmaengine@vger.kernel.org, Vinod Koul <vkoul@kernel.org>,
	Kelvin Cao <kelvin.cao@microchip.com>,
	George Ge <George.Ge@microchip.com>,
	Christoph Hellwig <hch@infradead.org>,
	Christophe Jaillet <christophe.jaillet@wanadoo.fr>,
	Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH v12 1/3] dmaengine: switchtec-dma: Introduce Switchtec
 DMA engine skeleton
Message-ID: <aWVXURk95OuKHbEb@lizhi-Precision-Tower-5810>
References: <20260112184017.2601-1-logang@deltatee.com>
 <20260112184017.2601-2-logang@deltatee.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260112184017.2601-2-logang@deltatee.com>
X-ClientProxiedBy: BYAPR11CA0064.namprd11.prod.outlook.com
 (2603:10b6:a03:80::41) To DU2PR04MB8951.eurprd04.prod.outlook.com
 (2603:10a6:10:2e2::22)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PR04MB8951:EE_|GV2PR04MB12216:EE_
X-MS-Office365-Filtering-Correlation-Id: 5988b1fc-3b28-4d44-e26a-08de5217e795
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|19092799006|376014|52116014|366016|7053199007|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?v8WTpvNP7YEZREkIHrlLKY15hYRBKpulydPrIe00o3HXTznzR0rcHB+tMO9J?=
 =?us-ascii?Q?XOQMuoFzQwl0hPph1XKMSnNWBbN4CWJFhblfLi97ogJbtUeX7J3cZ6ckJWak?=
 =?us-ascii?Q?2T//qyZMlXbJXk6Z2hF194nWhvqMn6l2P6nHDnob5yennb65sKJPQWTis7oE?=
 =?us-ascii?Q?YP14IakoJcyoeeYAgmlIHpe6vtsbmYi/H5jqpvVsH2Il0yePWzGa3pVv1Z52?=
 =?us-ascii?Q?4aUmZ7m81yiuetSybC4VOfqxIP6nghYWC1FsYm6WugHxHFYurBquLYsfEVx+?=
 =?us-ascii?Q?/d/i6ujx/Vw6GvhxRAvYwek6onFnMXrVy/vY01i4Ym48mgpzZCaWjqZlFmN3?=
 =?us-ascii?Q?DSR4aTvLmjzEHlpiSud5lDe/nSwY1bycnINbowrlCp9dEpZ3xhq8sMwXv+Lu?=
 =?us-ascii?Q?rWv4qEie5ygB4f+s4diOza/emu5V6Gjqf/Zug5NolR67LgNwwjkAsAOmhOii?=
 =?us-ascii?Q?yy2ZwZhuPkphHGhZ1OJwwaBYmbeTacbI146PTUeTB0qQ3Cnyht+Y06z0IngN?=
 =?us-ascii?Q?ijMqbrUoirvhqdaPDIfguyP7J7BKjr07hFn7ESEJ4KXrfcVgKeJHugvXTqRH?=
 =?us-ascii?Q?zK8yzrewDJdJ7+VBopMAsQcWjiCxlfUfHoocLGkqUfWydMZ5eEmXQ2xNv+ki?=
 =?us-ascii?Q?mUYS2NN8ZwnQ0Ud6PFETebjxzMC25eZI0oJ1Tp3RGzgys0yRzmgwlTooVsyL?=
 =?us-ascii?Q?iM9WzzCu5D5w4ZtG+zkoIBS5s0bIsbPU/xg8YjvhZV3wFuK59fBOQctfLvV6?=
 =?us-ascii?Q?YWdbWHhdS9ZEmo42rD3K5Jx1YX+Y3l3EPiv84AjjvxpYg6tUllVSMv9ZgrFg?=
 =?us-ascii?Q?ZgFWcereTx/sMDD/7OD27SxqIPHiy8PWEavH4lQSEfhvcpuBMJnJrht0QDWG?=
 =?us-ascii?Q?1+jNizj1WApHq13DCPyfT8ti0oZwp9NxlffrfBEIsMCcY/qI3DvP3GZNpRLA?=
 =?us-ascii?Q?cPP/rktLtmB8OSfkgVVOHZ1FCnPSEWq7Gx8dd92l5KoDCqUN+jezdjhLB3nR?=
 =?us-ascii?Q?vPFijR7WmtwHyB6HPMr+ubMbqVfZBnSBWqtnLkJ8Q23h+I/t35u+uvWQfjsp?=
 =?us-ascii?Q?w4Xmlz0Ap0lLXdWL+yCIUPZN0gwUh5wrmBJNpXRICBeMnH3TmAIEvUul3xtG?=
 =?us-ascii?Q?C99QLK7a5MYXH3t0xWYczX8m3YSLXHBW7BOTcJLaS8q8OF+itIlSYBpek3Ol?=
 =?us-ascii?Q?tVjVZ7lECzVoyf/lV++JsCi6qBXjGHpEE+xVff3z9cWP42ySXS8Gui0fPiL/?=
 =?us-ascii?Q?yV33g1tB/eG0IkOaf3tlR720vR8qroW/45ZYdlZsuLJsXwJm+r4/N3lg3d/t?=
 =?us-ascii?Q?rD/9VtVS/kTTjGbFe8dXF1tHdx7DYh0eucUMG3bdHTxTrxWbUXAvDWwsasM1?=
 =?us-ascii?Q?NIrvfYViKqGy0iyULJhlGLDJSRQDLfaCIya22UzLTdC1U72c0jDc4dzo7OO+?=
 =?us-ascii?Q?HsVKDtJaVGypnrQ0yLFrkFlq3nVMaDVEA+xqiDgxV6Xtj5cWWKkKyvyvlHrc?=
 =?us-ascii?Q?UURNuaAOgZNeh3aBpv71SdkgUBf5aU/95dw5?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR04MB8951.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(19092799006)(376014)(52116014)(366016)(7053199007)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Wx9JFoXQVPt3YcDgOkynfE1pLTAw/c+TkOEfisN/m/9zP+0b/LqWYJuLwVuF?=
 =?us-ascii?Q?Zwyt6+aeJqW2ysA2IuRbjhDzHtb10WqEdnKr7Isw41STEqwIz3P1hgkcS/64?=
 =?us-ascii?Q?rRh5sWRONes/PiiA6KsZbKrMykZl7ySASMCT8WnNw2XZ53iZ0XBVplcE0SP5?=
 =?us-ascii?Q?Tg0R8Cafyox0PxLdRj2zqmN5Gb/XSEA6VgsOUlfVrI2NDJVn3GpSJQTwn+3V?=
 =?us-ascii?Q?v63IWtLJAz6kyWV9yx0AjWntKMAVnvp4iJ10fLaxlOaCSa9//Dt7p1mNbzsp?=
 =?us-ascii?Q?Qsuy08rmTRKIdbkJFfZzxB1g3hCGJy4hVFZGuSxWFLIEQBcSdVU2z0XlnVnu?=
 =?us-ascii?Q?WWQ97ecKj0MCpf60h+9YT1Y7CMwx5nO/tPJUqm9UYqMXkJNX4ue9eJe4SJAP?=
 =?us-ascii?Q?ju3F33ms7m3RGH89RHrqE1HijfwPpFukb2qgQUsPK5Ji2cFjVKid60HOuvu+?=
 =?us-ascii?Q?p1FdSSuUTg+k81IkDhB4EF7D8c6+mD9DmB7d4NYu7mCCT+L97KucmEeGGSlC?=
 =?us-ascii?Q?nsGZhx8Ff2vRWk8sgv6lL/qtY4aE3JzkzOlG9ma/dugYO2yzqPfv5KF/IRcm?=
 =?us-ascii?Q?TdvYgRNtSVmVwX5Q7Br8kIICIJKWR+ZvPeS14l4gA73zSB6G9hEZ2ZUzlF9e?=
 =?us-ascii?Q?xwYPWyKYjPJXcEeufefl/slTE5PbBSh/uNeeZekmvY4eSukpFFczevaVatlq?=
 =?us-ascii?Q?0/Kg2wJeYS4jqaVwTUB7d98pHAE5SZdSBuVwOYGT1OOwK+sskPb0MglMcD7Z?=
 =?us-ascii?Q?YXdH8WwI1AZpAQlF5r1nssi6FAYo4GbPE6EaAJDs0E+Z+eV1lKOHLFH3yZBy?=
 =?us-ascii?Q?d7LXGA3ZFvzLy9yu7pxoZSScXTydJ10c3VIaz0yCDFKmTyy7gtaL/xx3/PDp?=
 =?us-ascii?Q?o3e77tLgJgEZ850QhgPzBvPb6n6/j0wHdrVBsorTFeVWeAwECmzcs2pFIuv3?=
 =?us-ascii?Q?R0ZVs8E8KpElarECq+XQYkPGWre0SNjmKDrNWX6RGphqVSGS7hYMeOCxRjhj?=
 =?us-ascii?Q?DDLHWUb0j/J4zssp7e6OxSMSZTUInfArErqwLgJFu7SGgEGiozTLQ8qoOjQE?=
 =?us-ascii?Q?rRshEIdw1YhmVUtH5nAEsl+vJWmmDDA+D31I+UW7mSAAtEFwxYhtzdFBl/0m?=
 =?us-ascii?Q?UEGVm1hNhr3l4Xv8upca93jHolkSV/bUMsFo4cXIrpSHxl+NnvWbSFSB+78M?=
 =?us-ascii?Q?ULLeJOyLtYLjceXiV/fMy2PtjljcnZkzTEdoBJ0kTLDkSxhOkKcaCSJWGx/m?=
 =?us-ascii?Q?zqwCIozfQJJGHnPJkwjXzNKvlq48ohp/Ux7HcxhUSBns+Ipzoxg9hqIlVDtU?=
 =?us-ascii?Q?PfCdBdjTpZmZIHybmhwoouHe7Y1UkVk5FqcZFi/pAS73MqjPnlx8IalYJcpI?=
 =?us-ascii?Q?BRTzblETdASMG398i6cE8HaOKReZ9EtPb+qtsWa0v93nP62Wkr1GAyFoZsz3?=
 =?us-ascii?Q?yIOBDfMJlrxrR6bJ+aau/KNWS3E86z+72nEOkt57vx3HBZWWLXJX+IqrPQ7Z?=
 =?us-ascii?Q?3twDhf/Uaxm5UyvMRladV9+H8CFOY2ACLAtwUk5aZXAlbTURQjwImLqn43uC?=
 =?us-ascii?Q?EZubD8qDRa/qzLOIous7hoG0A0MuhEQWDh/pma0h1QDuuXNBHiYXl3GMywn3?=
 =?us-ascii?Q?2Za5SsVvq1TQo6lViynChTyxEH7ZzSMLns1x4OTMgleyha7ui2WlWOAAinXq?=
 =?us-ascii?Q?epDlQzt9Y5mHNPhlsST3FQBb+zSAgjjzcLscBC2WfSrHESje?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5988b1fc-3b28-4d44-e26a-08de5217e795
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB8951.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jan 2026 20:19:35.8221
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JbhVw6C+0E0VsJBtMHIvOrzsFbjbc2A7qNXaHUhBzzRsrU6lPmxw6JavChCnZDf6pgxBX6JZyOW1R+pfSSKGyA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR04MB12216

On Mon, Jan 12, 2026 at 11:40:15AM -0700, Logan Gunthorpe wrote:
> From: Kelvin Cao <kelvin.cao@microchip.com>
>
> Some Switchtec Switches can expose DMA engines via extra PCI functions
> on the upstream ports. At most one such function can be supported on
> each upstream port. Each function can have one or more DMA channels.
>
> This patch is just the core PCI driver skeleton and dma
> engine registration.
>
> Signed-off-by: Kelvin Cao <kelvin.cao@microchip.com>
> Co-developed-by: George Ge <george.ge@microchip.com>
> Signed-off-by: George Ge <george.ge@microchip.com>
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
> ---
>  MAINTAINERS                 |   7 ++
>  drivers/dma/Kconfig         |   9 ++
>  drivers/dma/Makefile        |   1 +
>  drivers/dma/switchtec_dma.c | 211 ++++++++++++++++++++++++++++++++++++
>  4 files changed, 228 insertions(+)
>  create mode 100644 drivers/dma/switchtec_dma.c
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 0d044a58cbfe..6800f47399a4 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -25217,6 +25217,13 @@ S:	Supported
>  F:	include/net/switchdev.h
>  F:	net/switchdev/
>
> +SWITCHTEC DMA DRIVER
> +M:	Kelvin Cao <kelvin.cao@microchip.com>
> +M:	Logan Gunthorpe <logang@deltatee.com>
> +L:	dmaengine@vger.kernel.org
> +S:	Maintained
> +F:	drivers/dma/switchtec_dma.c
> +
>  SY8106A REGULATOR DRIVER
>  M:	Icenowy Zheng <icenowy@aosc.io>
>  S:	Maintained
> diff --git a/drivers/dma/Kconfig b/drivers/dma/Kconfig
> index 8bb0a119ecd4..85296c5cead9 100644
> --- a/drivers/dma/Kconfig
> +++ b/drivers/dma/Kconfig
> @@ -610,6 +610,15 @@ config SPRD_DMA
>  	help
>  	  Enable support for the on-chip DMA controller on Spreadtrum platform.
>
> +config SWITCHTEC_DMA
> +	tristate "Switchtec PSX/PFX Switch DMA Engine Support"
> +	depends on PCI
> +	select DMA_ENGINE
> +	help
> +	  Some Switchtec PSX/PFX PCIe Switches support additional DMA engines.
> +	  These are exposed via an extra function on the switch's upstream
> +	  port.
> +
>  config TXX9_DMAC
>  	tristate "Toshiba TXx9 SoC DMA support"
>  	depends on MACH_TX49XX
> diff --git a/drivers/dma/Makefile b/drivers/dma/Makefile
> index a54d7688392b..df566c4958b6 100644
> --- a/drivers/dma/Makefile
> +++ b/drivers/dma/Makefile
> @@ -74,6 +74,7 @@ obj-$(CONFIG_SF_PDMA) += sf-pdma/
>  obj-$(CONFIG_SOPHGO_CV1800B_DMAMUX) += cv1800b-dmamux.o
>  obj-$(CONFIG_STE_DMA40) += ste_dma40.o ste_dma40_ll.o
>  obj-$(CONFIG_SPRD_DMA) += sprd-dma.o
> +obj-$(CONFIG_SWITCHTEC_DMA) += switchtec_dma.o
>  obj-$(CONFIG_TXX9_DMAC) += txx9dmac.o
>  obj-$(CONFIG_TEGRA186_GPC_DMA) += tegra186-gpc-dma.o
>  obj-$(CONFIG_TEGRA20_APB_DMA) += tegra20-apb-dma.o
> diff --git a/drivers/dma/switchtec_dma.c b/drivers/dma/switchtec_dma.c
> new file mode 100644
> index 000000000000..cde982db0196
> --- /dev/null
> +++ b/drivers/dma/switchtec_dma.c
> @@ -0,0 +1,211 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Microchip Switchtec(tm) DMA Controller Driver
> + * Copyright (c) 2025, Kelvin Cao <kelvin.cao@microchip.com>
> + * Copyright (c) 2025, Microchip Corporation
> + */
> +
> +#include <linux/bitfield.h>
> +#include <linux/circ_buf.h>
> +#include <linux/dmaengine.h>
> +#include <linux/module.h>
> +#include <linux/pci.h>
> +#include <linux/delay.h>
> +#include <linux/iopoll.h>
> +
> +#include "dmaengine.h"
> +
> +MODULE_DESCRIPTION("Switchtec PCIe Switch DMA Engine");
> +MODULE_LICENSE("GPL");
> +MODULE_AUTHOR("Kelvin Cao");
> +
> +struct switchtec_dma_dev {
> +	struct dma_device dma_dev;
> +	struct pci_dev __rcu *pdev;
> +	void __iomem *bar;
> +};
> +
> +static void switchtec_dma_release(struct dma_device *dma_dev)
> +{
> +	struct switchtec_dma_dev *swdma_dev =
> +		container_of(dma_dev, struct switchtec_dma_dev, dma_dev);
> +
> +	put_device(dma_dev->dev);
> +	kfree(swdma_dev);
> +}
> +
> +static int switchtec_dma_create(struct pci_dev *pdev)
> +{
> +	struct switchtec_dma_dev *swdma_dev;
> +	struct dma_device *dma;
> +	struct dma_chan *chan;
> +	int nr_vecs, rc;
> +
> +	/*
> +	 * Create the switchtec dma device
> +	 */
> +	swdma_dev = kzalloc(sizeof(*swdma_dev), GFP_KERNEL);
> +	if (!swdma_dev)
> +		return -ENOMEM;

why not use devm_kzalloc() and devm_ioremap() to avoid below goto?

> +
> +	swdma_dev->bar = ioremap(pci_resource_start(pdev, 0),
> +				 pci_resource_len(pdev, 0));
> +
> +	RCU_INIT_POINTER(swdma_dev->pdev, pdev);
> +
> +	nr_vecs = pci_msix_vec_count(pdev);
> +	rc = pci_alloc_irq_vectors(pdev, nr_vecs, nr_vecs, PCI_IRQ_MSIX);
> +	if (rc < 0)
> +		goto err_exit;
> +
> +	dma = &swdma_dev->dma_dev;
> +	dma->copy_align = DMAENGINE_ALIGN_8_BYTES;
> +	dma->dev = get_device(&pdev->dev);
> +
> +	dma->device_release = switchtec_dma_release;
> +
> +	rc = dma_async_device_register(dma);
> +	if (rc) {
> +		pci_err(pdev, "Failed to register dma device: %d\n", rc);
> +		goto err_exit;
> +	}
> +
> +	list_for_each_entry(chan, &dma->channels, device_node)
> +		pci_dbg(pdev, "%s\n", dma_chan_name(chan));
> +
> +	pci_set_drvdata(pdev, swdma_dev);
> +
> +	return 0;
> +
> +err_exit:
> +	iounmap(swdma_dev->bar);
> +	kfree(swdma_dev);
> +	return rc;
> +}
> +
> +static int switchtec_dma_probe(struct pci_dev *pdev,
> +			       const struct pci_device_id *id)
> +{
> +	int rc;
> +
> +	rc = pci_enable_device(pdev);
> +	if (rc)
> +		return rc;
> +
> +	rc = dma_set_mask_and_coherent(&pdev->dev, DMA_BIT_MASK(64));
> +	if (rc)
> +		goto err_disable;

dma_set_mask_and_coherent() never return failure when MASK >= 32.

See: Documentation/core-api/dma-api-howto.rst

Frank

> +
> +	rc = pci_request_mem_regions(pdev, KBUILD_MODNAME);
> +	if (rc)
> +		goto err_disable;
> +
> +	pci_set_master(pdev);
> +
> +	rc = switchtec_dma_create(pdev);
> +	if (rc)
> +		goto err_free;
> +
> +	return 0;
> +
> +err_free:
> +	pci_free_irq_vectors(pdev);
> +	pci_release_mem_regions(pdev);
> +
> +err_disable:
> +	pci_disable_device(pdev);
> +
> +	return rc;
> +}
> +
> +static void switchtec_dma_remove(struct pci_dev *pdev)
> +{
> +	struct switchtec_dma_dev *swdma_dev = pci_get_drvdata(pdev);
> +
> +	rcu_assign_pointer(swdma_dev->pdev, NULL);
> +	synchronize_rcu();
> +
> +	pci_free_irq_vectors(pdev);
> +
> +	dma_async_device_unregister(&swdma_dev->dma_dev);
> +
> +	iounmap(swdma_dev->bar);
> +	pci_release_mem_regions(pdev);
> +	pci_disable_device(pdev);
> +}
> +
> +/*
> + * Also use the class code to identify the devices, as some of the
> + * device IDs are also used for other devices with other classes by
> + * Microsemi.
> + */
> +#define SW_ID(vendor_id, device_id) \
> +	{ \
> +		.vendor     = vendor_id, \
> +		.device     = device_id, \
> +		.subvendor  = PCI_ANY_ID, \
> +		.subdevice  = PCI_ANY_ID, \
> +		.class      = PCI_CLASS_SYSTEM_OTHER << 8, \
> +		.class_mask = 0xffffffff, \
> +	}
> +
> +static const struct pci_device_id switchtec_dma_pci_tbl[] = {
> +	SW_ID(PCI_VENDOR_ID_MICROSEMI, 0x4000), /* PFX 100XG4 */
> +	SW_ID(PCI_VENDOR_ID_MICROSEMI, 0x4084), /* PFX 84XG4 */
> +	SW_ID(PCI_VENDOR_ID_MICROSEMI, 0x4068), /* PFX 68XG4 */
> +	SW_ID(PCI_VENDOR_ID_MICROSEMI, 0x4052), /* PFX 52XG4 */
> +	SW_ID(PCI_VENDOR_ID_MICROSEMI, 0x4036), /* PFX 36XG4 */
> +	SW_ID(PCI_VENDOR_ID_MICROSEMI, 0x4028), /* PFX 28XG4 */
> +	SW_ID(PCI_VENDOR_ID_MICROSEMI, 0x4100), /* PSX 100XG4 */
> +	SW_ID(PCI_VENDOR_ID_MICROSEMI, 0x4184), /* PSX 84XG4 */
> +	SW_ID(PCI_VENDOR_ID_MICROSEMI, 0x4168), /* PSX 68XG4 */
> +	SW_ID(PCI_VENDOR_ID_MICROSEMI, 0x4152), /* PSX 52XG4 */
> +	SW_ID(PCI_VENDOR_ID_MICROSEMI, 0x4136), /* PSX 36XG4 */
> +	SW_ID(PCI_VENDOR_ID_MICROSEMI, 0x4128), /* PSX 28XG4 */
> +	SW_ID(PCI_VENDOR_ID_MICROSEMI, 0x4352), /* PFXA 52XG4 */
> +	SW_ID(PCI_VENDOR_ID_MICROSEMI, 0x4336), /* PFXA 36XG4 */
> +	SW_ID(PCI_VENDOR_ID_MICROSEMI, 0x4328), /* PFXA 28XG4 */
> +	SW_ID(PCI_VENDOR_ID_MICROSEMI, 0x4452), /* PSXA 52XG4 */
> +	SW_ID(PCI_VENDOR_ID_MICROSEMI, 0x4436), /* PSXA 36XG4 */
> +	SW_ID(PCI_VENDOR_ID_MICROSEMI, 0x4428), /* PSXA 28XG4 */
> +	SW_ID(PCI_VENDOR_ID_MICROSEMI, 0x5000), /* PFX 100XG5 */
> +	SW_ID(PCI_VENDOR_ID_MICROSEMI, 0x5084), /* PFX 84XG5 */
> +	SW_ID(PCI_VENDOR_ID_MICROSEMI, 0x5068), /* PFX 68XG5 */
> +	SW_ID(PCI_VENDOR_ID_MICROSEMI, 0x5052), /* PFX 52XG5 */
> +	SW_ID(PCI_VENDOR_ID_MICROSEMI, 0x5036), /* PFX 36XG5 */
> +	SW_ID(PCI_VENDOR_ID_MICROSEMI, 0x5028), /* PFX 28XG5 */
> +	SW_ID(PCI_VENDOR_ID_MICROSEMI, 0x5100), /* PSX 100XG5 */
> +	SW_ID(PCI_VENDOR_ID_MICROSEMI, 0x5184), /* PSX 84XG5 */
> +	SW_ID(PCI_VENDOR_ID_MICROSEMI, 0x5168), /* PSX 68XG5 */
> +	SW_ID(PCI_VENDOR_ID_MICROSEMI, 0x5152), /* PSX 52XG5 */
> +	SW_ID(PCI_VENDOR_ID_MICROSEMI, 0x5136), /* PSX 36XG5 */
> +	SW_ID(PCI_VENDOR_ID_MICROSEMI, 0x5128), /* PSX 28XG5 */
> +	SW_ID(PCI_VENDOR_ID_MICROSEMI, 0x5300), /* PFXA 100XG5 */
> +	SW_ID(PCI_VENDOR_ID_MICROSEMI, 0x5384), /* PFXA 84XG5 */
> +	SW_ID(PCI_VENDOR_ID_MICROSEMI, 0x5368), /* PFXA 68XG5 */
> +	SW_ID(PCI_VENDOR_ID_MICROSEMI, 0x5352), /* PFXA 52XG5 */
> +	SW_ID(PCI_VENDOR_ID_MICROSEMI, 0x5336), /* PFXA 36XG5 */
> +	SW_ID(PCI_VENDOR_ID_MICROSEMI, 0x5328), /* PFXA 28XG5 */
> +	SW_ID(PCI_VENDOR_ID_MICROSEMI, 0x5400), /* PSXA 100XG5 */
> +	SW_ID(PCI_VENDOR_ID_MICROSEMI, 0x5484), /* PSXA 84XG5 */
> +	SW_ID(PCI_VENDOR_ID_MICROSEMI, 0x5468), /* PSXA 68XG5 */
> +	SW_ID(PCI_VENDOR_ID_MICROSEMI, 0x5452), /* PSXA 52XG5 */
> +	SW_ID(PCI_VENDOR_ID_MICROSEMI, 0x5436), /* PSXA 36XG5 */
> +	SW_ID(PCI_VENDOR_ID_MICROSEMI, 0x5428), /* PSXA 28XG5 */
> +	SW_ID(PCI_VENDOR_ID_EFAR,      0x1001), /* PCI1001 16XG4 */
> +	SW_ID(PCI_VENDOR_ID_EFAR,      0x1002), /* PCI1002 16XG4 */
> +	SW_ID(PCI_VENDOR_ID_EFAR,      0x1003), /* PCI1003 16XG4 */
> +	SW_ID(PCI_VENDOR_ID_EFAR,      0x1004), /* PCI1004 16XG4 */
> +	SW_ID(PCI_VENDOR_ID_EFAR,      0x1005), /* PCI1005 16XG4 */
> +	SW_ID(PCI_VENDOR_ID_EFAR,      0x1006), /* PCI1006 16XG4 */
> +	{0}
> +};
> +MODULE_DEVICE_TABLE(pci, switchtec_dma_pci_tbl);
> +
> +static struct pci_driver switchtec_dma_pci_driver = {
> +	.name           = KBUILD_MODNAME,
> +	.id_table       = switchtec_dma_pci_tbl,
> +	.probe          = switchtec_dma_probe,
> +	.remove		= switchtec_dma_remove,
> +};
> +module_pci_driver(switchtec_dma_pci_driver);
> --
> 2.47.3
>

