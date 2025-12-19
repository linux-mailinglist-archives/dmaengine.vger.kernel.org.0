Return-Path: <dmaengine+bounces-7844-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FB46CD0784
	for <lists+dmaengine@lfdr.de>; Fri, 19 Dec 2025 16:15:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6963B306AE10
	for <lists+dmaengine@lfdr.de>; Fri, 19 Dec 2025 15:12:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5B6633A030;
	Fri, 19 Dec 2025 15:12:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="mY8juFPg"
X-Original-To: dmaengine@vger.kernel.org
Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11011012.outbound.protection.outlook.com [40.107.130.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C526722A4E9;
	Fri, 19 Dec 2025 15:12:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.130.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766157150; cv=fail; b=FDaHa5ag9jgstWjLWdx4hMKkUCRfMkaVuNW3DBx8HtVNvR2xJxAYkc8zpBpOYJ0zYL9vwu0pcp5PqRM+9wIV0gIoBBZc1skJ7HZxxPXk9QN0kI5zjK5WRDGnkM6MMzAIOxHWm0dwlnKzTRmgm528R90zvGmkOfxKbBQENjnfTTY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766157150; c=relaxed/simple;
	bh=3Lg2I0/R9W0Xc+R3iT9vnWLzzuh/sm5GntzEHfEr8Mg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=EGAEerPp1WvmuZdu4Sr9g/5r7neT4bqe65hVi3J1y4IBNJiR6n3Ct7+TjePEpMRtt88OKBiWXeiuo+569PwT2d8Xp4vi3La6laGjZOo2IY2CBZ7h1kpn/mRhfurgNviWS+TO0vlLqkDyShTVKMTWICpYXdeI8z5Vb4vuf5WS03I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=mY8juFPg; arc=fail smtp.client-ip=40.107.130.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MRMuegfPS7BHkVX22za4O0fcJBzqUzIGA2Q20bSrDqE23JpeEz46YA73gaFIQUarGQGAX3cgLr4+m53+XaPz5pFXfsl+eBy+Z1yTzQqfaMDeZ+cbtntCdbcZteghbrHyrPsVfGCXEHtBwqsGpTnfkTcl03UFbNmYiSTUV+/TSBt3JDhRypzp+6Q85hD+h1sKw49XJGGJe7gc/hlFICXEQRynZlhuW45TFllqlCvQ280urZez9yYI2glsWzcY6RpdrFiX48nAzMji/QUPQOgKjaYTDztapbAzUOYaDfpeby/nQZzzKGU09PiMPDnjARqWT9w0Ujce3d+MfBnzW41DlQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GA+tUiiQcuIHXMAE2HMLiZrNGsISkGjCgh8jPR7pUDM=;
 b=SkfsWreC2/KXv6l8iCsE+UNJaJZPmSNMy9VgSsHO8ShgDBag37f27fNiqOzz+1NGvwYib81Z3uHQZAET4TXzeSyUaFd6PUEiMdG7Q48HWJFfLPTvf2fF+dthFUafXAW/l2LjzVc4zSrUZuUaKziv6ipOU1Ksuksn/UnEbwqlisNK4Rq2H+I26H3A9/XkJr3Hx7+N124uqsG/mS897WvIqmf4Lq2TKiiPciUZsUf3YScX5Yy1oWvaWUEbwDQMS82WTUlCKd+yniFj9tzd2s4JQ47MV+JbQ9PR3DM0OtkcCFIK3aQglEkGDoqHUOpKpJkNXtsnLU+vnN8RKJQjFtBJ8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GA+tUiiQcuIHXMAE2HMLiZrNGsISkGjCgh8jPR7pUDM=;
 b=mY8juFPg7bMuoFfsVxoP0FlDRz0Vzp/M+hArDtaKMXSGI+9HRjTiiQTem9nK+VYWjhGTrceaKJHAfvBM37Jg0TBusUODgjg5xLI3hntB98169Gq2tEsFPZcY1WhMpYo60yLt3juL3k0ClmNMy+O/o4W9uiYZfgB1v7aFbf7ZztNgRklKPzx39hnEziJzYHoo2MWc5G1aRKu1IjJ94XTtkcc08C/UfrSPqsl57vL7iB/wJMMTLB79YenWvtwCGUFb35aMp1SkTBd78IjFw8o/lQgRZqapWwipR+fvqOVXONgJa2fdLW5f95ka91Wt/0ckW0+E8052hZ2UCYtHasN8Tg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DU2PR04MB8951.eurprd04.prod.outlook.com (2603:10a6:10:2e2::22)
 by DBAPR04MB7480.eurprd04.prod.outlook.com (2603:10a6:10:1a3::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9434.8; Fri, 19 Dec
 2025 15:12:23 +0000
Received: from DU2PR04MB8951.eurprd04.prod.outlook.com
 ([fe80::753c:468d:266:196]) by DU2PR04MB8951.eurprd04.prod.outlook.com
 ([fe80::753c:468d:266:196%4]) with mapi id 15.20.9434.001; Fri, 19 Dec 2025
 15:12:23 +0000
Date: Fri, 19 Dec 2025 10:12:11 -0500
From: Frank Li <Frank.li@nxp.com>
To: Koichiro Den <den@valinux.co.jp>
Cc: dave.jiang@intel.com, ntb@lists.linux.dev, linux-pci@vger.kernel.org,
	dmaengine@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	mani@kernel.org, kwilczynski@kernel.org, kishon@kernel.org,
	bhelgaas@google.com, corbet@lwn.net, geert+renesas@glider.be,
	magnus.damm@gmail.com, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, vkoul@kernel.org, joro@8bytes.org,
	will@kernel.org, robin.murphy@arm.com, jdmason@kudzu.us,
	allenbh@gmail.com, andrew+netdev@lunn.ch, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	Basavaraj.Natikar@amd.com, Shyam-sundar.S-k@amd.com,
	kurt.schwemmer@microsemi.com, logang@deltatee.com,
	jingoohan1@gmail.com, lpieralisi@kernel.org, utkarsh02t@gmail.com,
	jbrunet@baylibre.com, dlemoal@kernel.org, arnd@arndb.de,
	elfring@users.sourceforge.net
Subject: Re: [RFC PATCH v3 00/35] NTB transport backed by endpoint DW eDMA
Message-ID: <aUVrS/R+DM30UEhC@lizhi-Precision-Tower-5810>
References: <20251217151609.3162665-1-den@valinux.co.jp>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251217151609.3162665-1-den@valinux.co.jp>
X-ClientProxiedBy: PH7P220CA0156.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:510:33b::12) To DU2PR04MB8951.eurprd04.prod.outlook.com
 (2603:10a6:10:2e2::22)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PR04MB8951:EE_|DBAPR04MB7480:EE_
X-MS-Office365-Filtering-Correlation-Id: f42a0092-d838-400e-5661-08de3f1102fc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|52116014|19092799006|7416014|376014|1800799024|38350700014|13003099007|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?pV5Jf4+WMRz+Q5RTStnxDk56HliGOJ+rrOFSPBMbUoUGNIqUA8124My/lQYy?=
 =?us-ascii?Q?kpPIYi4v2mBTJcLqtBVTCYzDsdbtBw3EL7AlxPFsdFczy4WeJ2uTpwxP7KXW?=
 =?us-ascii?Q?7WVSwjaEdPZtgH13/DiP4jv+5vuRhYlLDv5M8WmV8TYm/GAUZ7c/EBT7SmPV?=
 =?us-ascii?Q?U1B2wWbHnw0BXOCZ+v86Pk27FuQ8h2SdUrzdWKkuJ4p+2JRfPtuGOVUCkqUB?=
 =?us-ascii?Q?tkox6J5tn83qWw2vXCYl/vRjwkTUIQfUVca/0rXoP8kHF+sPNyE2Td8Sf4pp?=
 =?us-ascii?Q?RgFagcftsOrqNYNTjnAOsmPsZ5fK73GpUgAkwp71edScSI6OcEfbqo6uqvTY?=
 =?us-ascii?Q?JKsmPeUjYSIvp4FMMdvfDM+0MLieo4GCq5lOVvYcd+phZlbl6Hjt1g1aRqQ2?=
 =?us-ascii?Q?fGal9cBTJkf6ilBOYVk6ON5LXefLs1hNYD9ul/q1GoVCJovlWXlLwKoYIWTD?=
 =?us-ascii?Q?1NUIWznhHb6pVDqI1f7R7q1xYhJdoFlw4lnP2E5iEbkPB/p5XhVWsfvaIIhn?=
 =?us-ascii?Q?vHsCh220MNkdzppyoaXHnISGV0DLNhew0IM2hX6BBr/tiC6/bmY3EQ/gwuyu?=
 =?us-ascii?Q?d5ADkXvd0Sg8Eu3ct8+FRITxRsgbwHbVJ4oZdCuym5X/R3l4bxCzB+oVngj8?=
 =?us-ascii?Q?bV0PA8MYorcxMPzIsum2ADJ9kZTUgMKcBstc6oz0mVK1NScFRhrFCRi2wnvh?=
 =?us-ascii?Q?sUi6JMAnaFvgDbhUHCZnLrOM2vgW75TTgdl1RNex1Uv5dbph7BXDzKviz9ow?=
 =?us-ascii?Q?osGN2+rhphESB9Np09Q56j5pMG+8WrNgPXXn5EQsyK5MPJ0ybpJVmOLOiZDN?=
 =?us-ascii?Q?dLEE4B1N7FoONHfA/4JAswl4uhRUH1F0eVCtcdO2baubPf6La9e0BihtM7mK?=
 =?us-ascii?Q?87tVQMS//ZsuD9qp6rLw2T0IY7QUPewrWgd4KzDyT9MarWQqnXAA9pIeUa2C?=
 =?us-ascii?Q?DSA0sbKZssmEDIBV2WxHRGuDQ1nGAI75hFDGJyDoXMlmTQF9wiLOiK6Jc2gg?=
 =?us-ascii?Q?vvt8QlSyTy9dUajXqaQFI50AJ5zaMknXGqMBlEWOclEMDEKYBVgTNkZ7GrgU?=
 =?us-ascii?Q?RxzufZfD7vs6J2JxZBqAph4jdP9O63P8pVJrovzCvvjY/5XWX06yPYWTNPtU?=
 =?us-ascii?Q?bBl4kI3cThdGAX9o4uRL8KsvMRFM9bC+Z0Z5qC5tB/xyL3P26fJyXfiTHbbo?=
 =?us-ascii?Q?aIilol2m4fa+1t+mHr92u2zfoHceT70V5bX4gr1mSocyVEe1M6Wdn0w8Fait?=
 =?us-ascii?Q?2o6Btrtpk9jNFsNtESOTXuLcxkF1UEWBMFxBWQ6Pn4uzk6JZLZNqY521dcqb?=
 =?us-ascii?Q?mObBizTRkeKBBjH1WdRXRMrSGEUouq9ocre3mM1byghiLRSUTVRNfDmQgjuK?=
 =?us-ascii?Q?tR2t4ow5mfznvGnUU+AqdQTWmAITjUk8nO321wD/1NsHe+dfkk5Qv3c9ESRX?=
 =?us-ascii?Q?i00havevVJdqbz+b/O5HQQUaVtFQLIjeUbu3XT2Lbpj80IBxMXYoLdh5giWQ?=
 =?us-ascii?Q?VvwVKmO8eqLOzp5yzRMLSvkSLCI03KtYGsNo?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR04MB8951.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(52116014)(19092799006)(7416014)(376014)(1800799024)(38350700014)(13003099007)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?wvzG81F8T3g060uKC+UW1a0if0LhbBSf0aJVoCeP5lYSZNdqqt1aWT9XKsFs?=
 =?us-ascii?Q?V9he9S2FaYRQ/Ra3wdVF50FWppugxEmhykoPTc0joMhF40UpcTDldyTzU8Aq?=
 =?us-ascii?Q?9pUtJxRGdBHVwLqDX1CB1m5IOLoH8q7qPE9Hqz+oPvD/uKZAovjvpCzj6xln?=
 =?us-ascii?Q?3Cmz9WdUooojbftKbyI3Csug1tbwH6TX6tUZ8SHPPgzDN8Z316TOBCBljILT?=
 =?us-ascii?Q?d+jmn5LVNhp7AAnomd7Hix8nXBTBqjYlUO19XaFeKp7FWNN9ybTThEnXbwBr?=
 =?us-ascii?Q?DtbIRlQsT8TKf7TvDe7wRjM1ysi18bRHNmutZHoKsIU5zIZXT+lkirrllHNm?=
 =?us-ascii?Q?E8JqkzpGBBBefjOgtxe5HGjN+uLFDz52csSC8eO8sggXhpLLUXLWR7uN/4bV?=
 =?us-ascii?Q?JCY0n7xgmRqClbtO9dw816rYNi74S1iaARgECDCz4m0yyXC/yOHhekIFMeOo?=
 =?us-ascii?Q?QwiCXmAwGigtDFlwvROvIKCkfw9M6uoLlYFesxoU22ZGXOwEUysCup5tU31D?=
 =?us-ascii?Q?LB4D7UFphqcxGUdMdr7zCUs/h/brLwN596SgdS0+vfNn4C7KEYeFELfQUcoT?=
 =?us-ascii?Q?TTiRllMeR8NOpQzfxz6UjxELZHXHneA5MSbRMq/8n5Vxkhq2P0pZFX8pEXDp?=
 =?us-ascii?Q?x7ZGuYa0FyVInz+q57dTmtqPx1e5PdHIk1HNRH3+YZrZiNbl/8EX1Y4Y7nL4?=
 =?us-ascii?Q?0LGrUTuLD//qM0Ssr4N0LhIh5p16/W+cM7TFkbx0KCqq+k8DgOmuhffEIr+y?=
 =?us-ascii?Q?mQTZii3kV5xQOJ/KwVISAGTHhFezUU8zsE1Fq2VIGEMPmgLZHReK2gHBVWVK?=
 =?us-ascii?Q?G8jh2J/BkDIltMPTwDAosW+3V8/OaUQjHpNYaeEH+YH5J2g0iHlih9NCz6Sd?=
 =?us-ascii?Q?dS5PQw+H+DDMq87Fs8JyxgIkSEQAuBE+SVWbgNIHxptQP3N8kuDgOMeQVXML?=
 =?us-ascii?Q?Xp+eFm23HEeXYzHrELOQu+w9VUvCJ0jmd5rTEHR1F1Kv/FjZ/cvCf6ybcb/o?=
 =?us-ascii?Q?oSc8vd4SazTgCc0cP/BE37RsBBTQMlBv6gK/9c5Yz454Sslv7vRtfru+iLVO?=
 =?us-ascii?Q?kGtDp5vxRyVMaWyJyjbWhDVX6bDvw1GllGV2CbIbS08471RewlrKBDJ9mjq4?=
 =?us-ascii?Q?aUCQAjGvDiPCRb6cLWW/8zPEl68GfD+ZQALPlpGHu9TA4TqqkipeqeKNguKp?=
 =?us-ascii?Q?E2SK011u3FsWedg3nSHKmvaCrsjOunip3Pxrhkw+eqfHCA1J4H8Wh+eOZ8ry?=
 =?us-ascii?Q?juhvGoMSagGDZvspYm4+/ZHWP0MJ87LrBi3k91lRcVsD00ksnCIel+h9v6mM?=
 =?us-ascii?Q?0fsLDtiAz0uqLPSVHbZzyZsq6i5uIcn2DUeL52GRkwef5ubyzNQUlRKPYHz3?=
 =?us-ascii?Q?fNMqt/jysnY7Isrq57tsVE3OdaWujG1kuFZhhMMjAbcXT4k/BCOCE9H4ris1?=
 =?us-ascii?Q?XZ66FsP34seXWIJKolVdSwZFuWFmPLyZCFRpNpU8eW3l6HZOYD9LyTz2sO7E?=
 =?us-ascii?Q?0dHOVblC7DpRLDtri6xRd075iKoNsiTaelu22wQrDIqHOI8cpBUI80A0CMxV?=
 =?us-ascii?Q?NDjHawsVEHaDkQzftCZPE05YPAZyrPi63cCB65Kn5TW87hTtsmRfLbtZS8Cb?=
 =?us-ascii?Q?hz4LXe2W3et8vsK2qq3NSz0aj1YyeglATKYUIrRf1mb9yPbz7vMb32v2tZ5c?=
 =?us-ascii?Q?m5xL0/gAZx11fl+/7GY51nov4arCX5su5ZKjrS/hz1+LyyZd?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f42a0092-d838-400e-5661-08de3f1102fc
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB8951.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Dec 2025 15:12:23.2918
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GV/v8ojfrg1SgLapXRooEHdur70PlKmGUZTTExYUyFePHJAfE3YmWVQXUmELzMpEDqQNyHRa+XMckysOvNkO3A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBAPR04MB7480

On Thu, Dec 18, 2025 at 12:15:34AM +0900, Koichiro Den wrote:
> Hi,
>
> This is RFC v3 of the NTB/PCI series that introduces NTB transport backed
> by DesignWare PCIe integrated eDMA.
>
>   RFC v2: https://lore.kernel.org/all/20251129160405.2568284-1-den@valinux.co.jp/
>   RFC v1: https://lore.kernel.org/all/20251023071916.901355-1-den@valinux.co.jp/
>
> The goal is to improve performance between a host and an endpoint over
> ntb_transport (typically with ntb_netdev on top). On R-Car S4, preliminary
> iperf3 results show 10~20x throughput improvement. Latency improvements are
> also observed.

Great!

>
> In this approach, payload is transferred by DMA directly between host and
> endpoint address spaces, and the NTB Memory Window is primarily used as a
> control/metadata window (and to expose the eDMA register/LL regions).
> Compared to the memcpy-based transport, this avoids extra copies and
> enables deeper rings and scales out to multiple queue pairs.
>
> Compared to RFC v2, data plane works in a symmetric manner in both
> directions (host-to-endpoint and endpoint-to-host). The host side drives
> remote read channels for its TX transfer while the endpoint drives local
> write channels.
>
> Again, I recognize that this is quite a large series. Sorry for the volume,
> but for the RFC stage I believe presenting the full picture in a single set
> helps with reviewing the overall architecture (Of course detail feedback
> would be appreciated as well). Once the direction is agreed, I will respin
> it split by subsystem and topic.
>
> Many thanks for all the reviews and feedback from multiple perspectives.

In next two weeks, it is holiday, I have not much time to review this long
thread. I glace for over all.

You can do some prepare work to speed up this great work's upstream.

Split prepare work for ntb change to new thread.
Split fix/code cleanup to new thread.

Beside some simple clean up,
- you start iatu for address mode match support first.
- eDMA some change, such as export reg base and LL region to support
remote DMA mode.  (you can add it to pci-epf-test.c to do base test).

Frank
>
>
> Data flow overview
> ==================
>
>     Figure 1. RC->EP traffic via ntb_netdev+ntb_transport
>                      backed by Remote eDMA
>
>           EP                                   RC
>        phys addr                            phys addr
>          space                                space
>           +-+                                  +-+
>           | |                                  | |
>           | |                ||                | |
>           +-+-----.          ||                | |
>  EDMA REG | |      \    [A]  ||                | |
>           +-+----.  '---+-+  ||                | |
>           | |     \     | |<---------[0-a]----------
>           +-+-----------| |<----------[2]----------.
>   EDMA LL | |           | |  ||                | | :
>           | |           | |  ||                | | :
>           +-+-----------+-+  ||  [B]           | | :
>           | |                ||  ++            | | :
>        ---------[0-b]----------->||----------------'
>           | |            ++  ||  ||            | |
>           | |            ||  ||  ++            | |
>           | |            ||<----------[4]-----------
>           | |            ++  ||                | |
>           | |           [C]  ||                | |
>        .--|#|<------------------------[3]------|#|<-.
>        :  |#|                ||                |#|  :
>       [5] | |                ||                | | [1]
>        :  | |                ||                | |  :
>        '->|#|                                  |#|--'
>           |#|                                  |#|
>           | |                                  | |
>
>
>     Figure 2. EP->RC traffic via ntb_netdev+ntb_transport
>                      backed by EP-Local eDMA
>
>           EP                                   RC
>        phys addr                            phys addr
>          space                                space
>           +-+                                  +-+
>           | |                                  | |
>           | |                ||                | |
>           +-+                ||                | |
>  EDMA REG | |                ||                | |
>           +-+                ||                | |
> ^         | |                ||                | |
> :         +-+                ||                | |
> : EDMA LL | |                ||                | |
> :         | |                ||                | |
> :         +-+                ||  [C]           | |
> :         | |                ||  ++            | |
> :      -----------[4]----------->||            | |
> :         | |            ++  ||  ||            | |
> :         | |            ||  ||  ++            | |
> '----------------[2]-----||<--------[0-b]-----------
>           | |            ++  ||                | |
>           | |           [B]  ||                | |
>        .->|#|--------[3]---------------------->|#|--.
>        :  |#|                ||                |#|  :
>       [1] | |                ||                | | [5]
>        :  | |                ||                | |  :
>        '--|#|                                  |#|<-'
>           |#|                                  |#|
>           | |                                  | |
>
>
>       0-a. configure Remote eDMA
>       0-b. DMA-map and produce DAR
>       1.   memcpy while building skb in ntb_netdev case
>       2.   consume DAR, DMA-map SAR and kick DMA read transfer
>       3.   DMA transfer
>       4.   consume (commit)
>       5.   memcpy to application side
>
>       [A]: MemoryWindow that aggregates eDMA regs and LL.
>            IB iATU translations (Address Match Mode).
>       [B]: Control plane ring buffer (for "produce")
>       [C]: Control plane ring buffer (for "consume")
>
>   Note:
>     - Figure 1 is unchanged from RFC v2.
>     - Figure 2 differs from the one depicted in RFC v2 cover letter.
>
>
> Changes since RFC v2
> ====================
>
> RFCv2->RFCv3 changes:
>   - Architecture
>     - Have EP side use its local write channels, while leaving RC side to
>       use remote read channels.
>     - Abstraction/HW-specific stuff encapsulation improved.
>   - Added control/config region versioning for the vNTB/EPF control region
>     so that mismatched RC/EP kernels fail early instead of silently using an
>     incompatible layout.
>   - Reworked BAR subrange / multi-region mapping support:
>     - Dropped the v2 approach that added new inbound mapping ops in the EPC
>       core.
>     - Introduced `struct pci_epf_bar.submap` and extended DesignWare EP to
>       support BAR subrange inbound mapping via Address Match Mode IB iATU.
>     - pci-epf-vntb now provides a subrange mapping hint to the EPC driver
>       when offsets are used.
>   - Changed .get_pci_epc() to .get_private_data()
>   - Dropped two commits from RFC v2 that should be submitted separately:
>     (1) ntb_transport debugfs seq_file conversion
>     (2) DWC EP outbound iATU MSI mapping/cache fix (will be re-posted separately)
>   - Added documentation updates.
>   - Addressed assorted review nits from the RFC v2 thread (naming/structure).
>
> RFCv1->RFCv2 changes:
>   - Architecture
>     - Drop the generic interrupt backend + DW eDMA test-interrupt backend
>       approach and instead adopt the remote eDMA-backed ntb_transport mode
>       proposed by Frank Li. The BAR-sharing / mwN_offset / inbound
>       mapping (Address Match Mode) infrastructure from RFC v1 is largely
>       kept, with only minor refinements and code motion where necessary
>       to fit the new transport-mode design.
>   - For Patch 01
>     - Rework the array_index_nospec() conversion to address review
>       comments on "[RFC PATCH 01/25]".
>
> RFCv2: https://lore.kernel.org/all/20251129160405.2568284-1-den@valinux.co.jp/
> RFCv1: https://lore.kernel.org/all/20251023071916.901355-1-den@valinux.co.jp/
>
>
> Patch layout
> ============
>
>   Patch 01-25 : preparation for Patch 26
>                 - 01-07: support multiple MWs in a BAR
> 		- 08-25: other misc preparations
>   Patch 26    : main and most important patch, adds eDMA-backed transport
>   Patch 27-28 : multi-queue use, thanks to the remote eDMA, performance
>                 scales
>   Patch 29-33 : handle several SoC-specific issues so that remote eDMA
>                 mode ntb_transport works on R-Car S4
>   Patch 34-35 : kernel doc updates
>
>
> Tested on
> =========
>
> * 2x Renesas R-Car S4 Spider (RC<->EP connected with OcuLink cable)
> * Kernel base: next-20251216 + [1] + [2] + [3]
>
>   [1]: https://lore.kernel.org/all/20251210071358.2267494-2-cassel@kernel.org/
>        (this is a spin-out patch from
>         https://lore.kernel.org/linux-pci/20251129160405.2568284-20-den@valinux.co.jp/)
>   [2]: https://lore.kernel.org/all/20251208-dma_prep_config-v1-0-53490c5e1e2a@nxp.com/
>        (while it appears to still be under active discussion)
>   [3]: https://lore.kernel.org/all/20251217081955.3137163-1-den@valinux.co.jp/
>        (this is a spin-out patch from
>         https://lore.kernel.org/all/20251129160405.2568284-14-den@valinux.co.jp/)
>
>
> Performance measurement
> =======================
>
> No serious measurements yet, because:
>   * For "before the change", even use_dma/use_msi does not work on the
>     upstream kernel unless we apply some patches for R-Car S4. With some
>     unmerged patch series I had posted earlier (but superseded by this RFC
>     attempt), it was observed that we can achieve about 7 Gbps for the
>     RC->EP direction. Pure upstream kernel can achieve around 500 Mbps
>     though.
>   * For "after the change", measurements are not mature because this
>     RFC v3 patch series is not yet performance-optimized at this stage.
>
> Here are the rough measurements showing the achievable performance on
> the R-Car S4:
>
> - Before this change:
>
>   * ping
>     64 bytes from 10.0.0.11: icmp_seq=1 ttl=64 time=12.3 ms
>     64 bytes from 10.0.0.11: icmp_seq=2 ttl=64 time=6.58 ms
>     64 bytes from 10.0.0.11: icmp_seq=3 ttl=64 time=1.26 ms
>     64 bytes from 10.0.0.11: icmp_seq=4 ttl=64 time=7.43 ms
>     64 bytes from 10.0.0.11: icmp_seq=5 ttl=64 time=1.39 ms
>     64 bytes from 10.0.0.11: icmp_seq=6 ttl=64 time=7.38 ms
>     64 bytes from 10.0.0.11: icmp_seq=7 ttl=64 time=1.42 ms
>     64 bytes from 10.0.0.11: icmp_seq=8 ttl=64 time=7.41 ms
>
>   * RC->EP (`sudo iperf3 -ub0 -l 65480 -P 2`)
>     [ ID] Interval           Transfer     Bitrate         Jitter    Lost/Total Datagrams
>     [  5]   0.00-10.01  sec   344 MBytes   288 Mbits/sec  3.483 ms  51/5555 (0.92%)  receiver
>     [  6]   0.00-10.01  sec   342 MBytes   287 Mbits/sec  3.814 ms  38/5517 (0.69%)  receiver
>     [SUM]   0.00-10.01  sec   686 MBytes   575 Mbits/sec  3.648 ms  89/11072 (0.8%)  receiver
>
>   * EP->RC (`sudo iperf3 -ub0 -l 65480 -P 2`)
>     [  5]   0.00-10.03  sec   334 MBytes   279 Mbits/sec  3.164 ms  390/5731 (6.8%)  receiver
>     [  6]   0.00-10.03  sec   334 MBytes   279 Mbits/sec  2.416 ms  396/5741 (6.9%)  receiver
>     [SUM]   0.00-10.03  sec   667 MBytes   558 Mbits/sec  2.790 ms  786/11472 (6.9%)  receiver
>
>     Note: with `-P 2`, the best total bitrate (receiver side) was achieved.
>
> - After this change (use_remote_edma=1):
>
>   * ping
>     64 bytes from 10.0.0.11: icmp_seq=1 ttl=64 time=1.42 ms
>     64 bytes from 10.0.0.11: icmp_seq=2 ttl=64 time=1.38 ms
>     64 bytes from 10.0.0.11: icmp_seq=3 ttl=64 time=1.21 ms
>     64 bytes from 10.0.0.11: icmp_seq=4 ttl=64 time=1.02 ms
>     64 bytes from 10.0.0.11: icmp_seq=5 ttl=64 time=1.06 ms
>     64 bytes from 10.0.0.11: icmp_seq=6 ttl=64 time=0.995 ms
>     64 bytes from 10.0.0.11: icmp_seq=7 ttl=64 time=0.964 ms
>     64 bytes from 10.0.0.11: icmp_seq=8 ttl=64 time=1.49 ms
>
>   * RC->EP (`sudo iperf3 -ub0 -l 65480 -P 4`)
>     [  5]   0.00-10.02  sec  3.00 GBytes  2.58 Gbits/sec  0.437 ms  33053/82329 (40%)  receiver
>     [  6]   0.00-10.02  sec  3.00 GBytes  2.58 Gbits/sec  0.174 ms  46379/95655 (48%)  receiver
>     [  9]   0.00-10.02  sec  2.88 GBytes  2.47 Gbits/sec  0.106 ms  47672/94924 (50%)  receiver
>     [ 11]   0.00-10.02  sec  2.87 GBytes  2.46 Gbits/sec  0.364 ms  23694/70817 (33%)  receiver
>     [SUM]   0.00-10.02  sec  11.8 GBytes  10.1 Gbits/sec  0.270 ms  150798/343725 (44%)  receiver
>
>   * EP->RC (`sudo iperf3 -ub0 -l 65480 -P 4`)
>     [  5]   0.00-10.01  sec  3.28 GBytes  2.82 Gbits/sec  0.380 ms  38578/92355 (42%)  receiver
>     [  6]   0.00-10.01  sec  3.24 GBytes  2.78 Gbits/sec  0.430 ms  14268/67340 (21%)  receiver
>     [  9]   0.00-10.01  sec  2.92 GBytes  2.51 Gbits/sec  0.074 ms  0/47890 (0%)  receiver
>     [ 11]   0.00-10.01  sec  4.76 GBytes  4.09 Gbits/sec  0.037 ms  0/78073 (0%)  receiver
>     [SUM]   0.00-10.01  sec  14.2 GBytes  12.2 Gbits/sec  0.230 ms  52846/285658 (18%)  receiver
>
>   * configfs settings:
>       # modprobe pci_epf_vntb
>       # cd /sys/kernel/config/pci_ep/
>       # mkdir functions/pci_epf_vntb/func1
>       # echo 0x1912 >   functions/pci_epf_vntb/func1/vendorid
>       # echo 0x0030 >   functions/pci_epf_vntb/func1/deviceid
>       # echo 32 >       functions/pci_epf_vntb/func1/msi_interrupts
>       # echo 16 >       functions/pci_epf_vntb/func1/pci_epf_vntb.0/db_count
>       # echo 128 >      functions/pci_epf_vntb/func1/pci_epf_vntb.0/spad_count
>       # echo 2 >        functions/pci_epf_vntb/func1/pci_epf_vntb.0/num_mws
>       # echo 0xe0000 >  functions/pci_epf_vntb/func1/pci_epf_vntb.0/mw1
>       # echo 0x20000 >  functions/pci_epf_vntb/func1/pci_epf_vntb.0/mw2
>       # echo 0xe0000 >  functions/pci_epf_vntb/func1/pci_epf_vntb.0/mw2_offset
>       # echo 0x1912 >   functions/pci_epf_vntb/func1/pci_epf_vntb.0/vntb_vid
>       # echo 0x0030 >   functions/pci_epf_vntb/func1/pci_epf_vntb.0/vntb_pid
>       # echo 0x10 >     functions/pci_epf_vntb/func1/pci_epf_vntb.0/vbus_number
>       # echo 0 >        functions/pci_epf_vntb/func1/pci_epf_vntb.0/ctrl_bar
>       # echo 4 >        functions/pci_epf_vntb/func1/pci_epf_vntb.0/db_bar
>       # echo 2 >        functions/pci_epf_vntb/func1/pci_epf_vntb.0/mw1_bar
>       # echo 2 >        functions/pci_epf_vntb/func1/pci_epf_vntb.0/mw2_bar
>       # ln -s controllers/e65d0000.pcie-ep functions/pci_epf_vntb/func1/primary/
>       # echo 1 > controllers/e65d0000.pcie-ep/start
>
>
>
> Thank you for reviewing,
>
>
> Koichiro Den (35):
>   PCI: endpoint: pci-epf-vntb: Use array_index_nospec() on mws_size[]
>     access
>   NTB: epf: Add mwN_offset support and config region versioning
>   PCI: dwc: ep: Support BAR subrange inbound mapping via address match
>     iATU
>   NTB: Add offset parameter to MW translation APIs
>   PCI: endpoint: pci-epf-vntb: Propagate MW offset from configfs when
>     present
>   NTB: ntb_transport: Support partial memory windows with offsets
>   PCI: endpoint: pci-epf-vntb: Hint subrange mapping preference to EPC
>     driver
>   NTB: core: Add .get_private_data() to ntb_dev_ops
>   NTB: epf: vntb: Implement .get_private_data() callback
>   dmaengine: dw-edma: Fix MSI data values for multi-vector IMWr
>     interrupts
>   NTB: ntb_transport: Move TX memory window setup into setup_qp_mw()
>   NTB: ntb_transport: Dynamically determine qp count
>   NTB: ntb_transport: Introduce get_dma_dev() helper
>   NTB: epf: Reserve a subset of MSI vectors for non-NTB users
>   NTB: ntb_transport: Move internal types to ntb_transport_internal.h
>   NTB: ntb_transport: Introduce ntb_transport_backend_ops
>   dmaengine: dw-edma: Add helper func to retrieve register base and size
>   dmaengine: dw-edma: Add per-channel interrupt routing mode
>   dmaengine: dw-edma: Poll completion when local IRQ handling is
>     disabled
>   dmaengine: dw-edma: Add notify-only channels support
>   dmaengine: dw-edma: Add a helper to retrieve LL (Linked List) region
>   dmaengine: dw-edma: Serialize RMW on shared interrupt registers
>   NTB: ntb_transport: Split core into ntb_transport_core.c
>   NTB: ntb_transport: Add additional hooks for DW eDMA backend
>   NTB: hw: Introduce DesignWare eDMA helper
>   NTB: ntb_transport: Introduce DW eDMA backed transport mode
>   NTB: epf: Provide db_vector_count/db_vector_mask callbacks
>   ntb_netdev: Multi-queue support
>   NTB: epf: Add per-SoC quirk to cap MRRS for DWC eDMA (128B for R-Car)
>   iommu: ipmmu-vmsa: Add PCIe ch0 to devices_allowlist
>   iommu: ipmmu-vmsa: Add support for reserved regions
>   arm64: dts: renesas: Add Spider RC/EP DTs for NTB with remote DW PCIe
>     eDMA
>   NTB: epf: Add an additional memory window (MW2) barno mapping on
>     Renesas R-Car
>   Documentation: PCI: endpoint: pci-epf-vntb: Update and add mwN_offset
>     usage
>   Documentation: driver-api: ntb: Document remote eDMA transport backend
>
>  Documentation/PCI/endpoint/pci-vntb-howto.rst |  16 +-
>  Documentation/driver-api/ntb.rst              |  58 +
>  arch/arm64/boot/dts/renesas/Makefile          |   2 +
>  .../boot/dts/renesas/r8a779f0-spider-ep.dts   |  37 +
>  .../boot/dts/renesas/r8a779f0-spider-rc.dts   |  52 +
>  drivers/dma/dw-edma/dw-edma-core.c            | 233 ++++-
>  drivers/dma/dw-edma/dw-edma-core.h            |  13 +-
>  drivers/dma/dw-edma/dw-edma-v0-core.c         |  39 +-
>  drivers/iommu/ipmmu-vmsa.c                    |   7 +-
>  drivers/net/ntb_netdev.c                      | 341 ++++--
>  drivers/ntb/Kconfig                           |  12 +
>  drivers/ntb/Makefile                          |   4 +
>  drivers/ntb/hw/amd/ntb_hw_amd.c               |   6 +-
>  drivers/ntb/hw/edma/ntb_hw_edma.c             | 754 +++++++++++++
>  drivers/ntb/hw/edma/ntb_hw_edma.h             |  76 ++
>  drivers/ntb/hw/epf/ntb_hw_epf.c               | 187 +++-
>  drivers/ntb/hw/idt/ntb_hw_idt.c               |   3 +-
>  drivers/ntb/hw/intel/ntb_hw_gen1.c            |   6 +-
>  drivers/ntb/hw/intel/ntb_hw_gen1.h            |   2 +-
>  drivers/ntb/hw/intel/ntb_hw_gen3.c            |   3 +-
>  drivers/ntb/hw/intel/ntb_hw_gen4.c            |   6 +-
>  drivers/ntb/hw/mscc/ntb_hw_switchtec.c        |   6 +-
>  drivers/ntb/msi.c                             |   6 +-
>  .../{ntb_transport.c => ntb_transport_core.c} | 482 ++++-----
>  drivers/ntb/ntb_transport_edma.c              | 987 ++++++++++++++++++
>  drivers/ntb/ntb_transport_internal.h          | 220 ++++
>  drivers/ntb/test/ntb_perf.c                   |   4 +-
>  drivers/ntb/test/ntb_tool.c                   |   6 +-
>  .../pci/controller/dwc/pcie-designware-ep.c   | 198 +++-
>  drivers/pci/controller/dwc/pcie-designware.c  |  25 +
>  drivers/pci/controller/dwc/pcie-designware.h  |   2 +
>  drivers/pci/endpoint/functions/pci-epf-vntb.c | 246 ++++-
>  drivers/pci/endpoint/pci-epc-core.c           |   2 +-
>  include/linux/dma/edma.h                      | 106 ++
>  include/linux/ntb.h                           |  38 +-
>  include/linux/ntb_transport.h                 |   5 +
>  include/linux/pci-epf.h                       |  27 +
>  37 files changed, 3716 insertions(+), 501 deletions(-)
>  create mode 100644 arch/arm64/boot/dts/renesas/r8a779f0-spider-ep.dts
>  create mode 100644 arch/arm64/boot/dts/renesas/r8a779f0-spider-rc.dts
>  create mode 100644 drivers/ntb/hw/edma/ntb_hw_edma.c
>  create mode 100644 drivers/ntb/hw/edma/ntb_hw_edma.h
>  rename drivers/ntb/{ntb_transport.c => ntb_transport_core.c} (91%)
>  create mode 100644 drivers/ntb/ntb_transport_edma.c
>  create mode 100644 drivers/ntb/ntb_transport_internal.h
>
> --
> 2.51.0
>

