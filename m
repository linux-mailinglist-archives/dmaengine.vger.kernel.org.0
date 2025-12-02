Return-Path: <dmaengine+bounces-7472-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 7698CC9C1D5
	for <lists+dmaengine@lfdr.de>; Tue, 02 Dec 2025 17:08:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 9812B34A569
	for <lists+dmaengine@lfdr.de>; Tue,  2 Dec 2025 16:07:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A013D248896;
	Tue,  2 Dec 2025 16:07:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="lvWqMhWW"
X-Original-To: dmaengine@vger.kernel.org
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010013.outbound.protection.outlook.com [52.101.69.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12F0D2727FD;
	Tue,  2 Dec 2025 16:07:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764691663; cv=fail; b=Or0cPAU3DimdWb1hTKJC1rhNBppdhhkQfSWqvS3F9jjvuKeIaxSzYDhnSYEhRqveXc3bel3KpzOOVNqmK9fJ5GOwCGoGybwSL0kkxXyzucfAgxs8tkOWYL8/tyHk+AMxS2WmDMG+0LVYtPo272QV5/0WBuSoiMKkWu8ZcuJUnXE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764691663; c=relaxed/simple;
	bh=e+UmWc4ZqCIpKlbmn8CjOiYoO1nWlZ09fkdfkj1RWas=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=j9v9LL5GhVv0+fc2uyzbvJ5W0z1akU27dCipCs4/DWBmXi/ue8GKXcp1PjedHPcrvmtbGAWreZMmPITc2fzjJrHUx1K8/nmyWdNI5Qk9JO6qo9+/RAVmeaPx0W7xkY3IuAzcRTiFecyV1QOKNHHZnkMyEEYIoh7eLhD0faQa7mo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=lvWqMhWW; arc=fail smtp.client-ip=52.101.69.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RND891X+48ulfEyj9NSD8mfLBYxKD7NJcjBu8blhv1gGHjyoVexOw8FUhF9/BbGYwN3mAadfAvFpwFexhbFjpLkdvDcoPiIsRUGWAJ92zN2/8tLS57J1MYnN2hGe4t1IVo1mEXINLXAxNdhZBAwq9ylNwjGDmF/zvKq4R2W/BLVCgtAUPIfELNBYt5eeJylsokinQZJcCQ1TyviaWmxGBc7mGaGl3ldmDku62Ee4bTKGcTMHR4zhWzLDf4Jcgk6BXbzGQAsDhIZbukZ1453c3S3z7XZvVKuhZy97WWQiD721UMRVFTC3xow3i11TDvd9Rs5XnQsfA3QHIBs5u4uXEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DOJIS8YXiE8qUb66H0T0sUZ3K9kFWBCpgDKmYUJPjyw=;
 b=grIEZIfCgsJmKteqdPgfLZnpL3dHsphbK9FZiK9S+wigI4PffzAKIC55NLj/ykrbfoC0pxV+rxjBncK29AVOPYacn78EeALVWX4gsPwWPrBEY8i7OV3zrvTDxoH8kdHPgvZBKPdUFgbH9SkKD+ob0I1zQ2RHfIF9qPtftjNUIHw1XBVkheTzbpt1Wqs/sDYEeOk+aacfCIXAf6E2p33AeQCe+V2tudn8+dbyw8XnFy3bV7ZQP8yEeVmjeysudeAZbNmHZ8+MsbdIbsGFTaaTwZuP6RbuAT677tVY1rugkFAGQo/aXDRuYRwdlw4MaIpn8F0NnKgHRFwt7/zZ1gNKIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DOJIS8YXiE8qUb66H0T0sUZ3K9kFWBCpgDKmYUJPjyw=;
 b=lvWqMhWWOaXrS+MCKjXsOgGvsmYcrmuSPjeiybXW39gRjIC55XF+JtNzm1Jdh0bAez7or3LYzUf4bP8uxsgpxwSjQbDx9NTE2SUi2pYHTMVEkX8c8zbMmW07B6Ud6gZzigYHMYx98xmz1V2HERIQ+A9u8at83P5r+7Xl6fTE9w51ZeAvGVQ/NjYX8Qb1eW9NBuMIE5NNyUHJpO5CijF6PFGXwj6cR4kI8+1OfyvZHVLTQaiABS3OfC1eyEiFiEgfvInIfxSpzjDDxtMXojjWfgLx2KxE23LHqaQVyn2S+pRupl3mOAKg3W0h/lDXiKjbK2empaanQO+6nbhV1dskUg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DU2PR04MB8951.eurprd04.prod.outlook.com (2603:10a6:10:2e2::22)
 by PA1PR04MB10866.eurprd04.prod.outlook.com (2603:10a6:102:488::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9388.9; Tue, 2 Dec
 2025 16:07:34 +0000
Received: from DU2PR04MB8951.eurprd04.prod.outlook.com
 ([fe80::753c:468d:266:196]) by DU2PR04MB8951.eurprd04.prod.outlook.com
 ([fe80::753c:468d:266:196%4]) with mapi id 15.20.9366.012; Tue, 2 Dec 2025
 16:07:34 +0000
Date: Tue, 2 Dec 2025 11:07:23 -0500
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
Subject: Re: [RFC PATCH v2 00/27] NTB transport backed by remote DW eDMA
Message-ID: <aS8Ou7YacTs2yLqk@lizhi-Precision-Tower-5810>
References: <20251129160405.2568284-1-den@valinux.co.jp>
 <aS4QkYn+aKphlRFm@lizhi-Precision-Tower-5810>
 <hp4shyyqwjddo54vac6gtau44qyshqw3ez5cqswtu4qhgg3ji3@6bi3rlnbqfz6>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <hp4shyyqwjddo54vac6gtau44qyshqw3ez5cqswtu4qhgg3ji3@6bi3rlnbqfz6>
X-ClientProxiedBy: SJ0PR03CA0187.namprd03.prod.outlook.com
 (2603:10b6:a03:2ef::12) To DU2PR04MB8951.eurprd04.prod.outlook.com
 (2603:10a6:10:2e2::22)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PR04MB8951:EE_|PA1PR04MB10866:EE_
X-MS-Office365-Filtering-Correlation-Id: 770dc714-2df2-413c-c6b7-08de31bce756
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|19092799006|52116014|7416014|376014|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?rXXHlyIiOKokPV3KZHMLVQTStXduyJpQ3xiDjNC3VHB7he3ZnSWYFM1Gtwna?=
 =?us-ascii?Q?SRsSlA5tdqm8yYXmaLCvyDG10dByRPPO/e4ykV8tsrzg+KJRYilWHH3xBtB+?=
 =?us-ascii?Q?VfbVRXLZ6ZZwCa9/fjfgWp2ULyAMqVVfMygCU9RJ/QapHEU3cD48nMNsl1mP?=
 =?us-ascii?Q?AqUVxrfOf2ManrE/GQTp+c+zVC/NrSmdVWf4G1rKFZHkrC3ZZM2K8+/LI2+v?=
 =?us-ascii?Q?ceNzZ96WKrXfWqgdUlF8XD70Kzzk3eHSwVIwLUJ+vBJCdjjRlLFsMeqSvQRM?=
 =?us-ascii?Q?06xUt1evVaMl8oau8oI3QHvl2Z3Wx/3Hx8EnkvuCaidpkci1otuR6y17yA/6?=
 =?us-ascii?Q?qE8TDSNNuDncA6+Qk481tuM+VOhGhOEVL6soQ9s2hCAolzMpNhQBq+x4riCA?=
 =?us-ascii?Q?8b9/6OxeMNGtKhKCgCuFDbvF/HLoWQ6W1VX1V0pjJ2Tj/LXJMM2JwUlnCkCh?=
 =?us-ascii?Q?HCp4zgaNccOrwIn48AxohQ27PhAkyNauyIkcN1wcjRSoxSWp2gfGgb3UjGt2?=
 =?us-ascii?Q?jJifdJt4AcUlsvfv/Mm1uB0VR29X9s6AV6MCDuUgKjdA1xuLtAPfU1bH3V5d?=
 =?us-ascii?Q?d7M1BKPDuhJYc3/GTLFAK87F0MwU1yWkrdrJCw9zXCTtKZdGLQDnShDvA3tk?=
 =?us-ascii?Q?iyihzpuU6M1ciZHoKXSDGv6KK5MnNuDx0Wni4zYiMX9Fp5kib1k7B6z0rmen?=
 =?us-ascii?Q?sgUvzDjJlJYn0NG3EH5OP5VTIne+VtSgYlH+lcFJDilo/nvA1uXfgBRWyfCB?=
 =?us-ascii?Q?9lSpSyogwbKXB1IFsY1YZE+BOJM0bs6UsILtbUbTBLZ8IeMnGGP8k8iFJbIF?=
 =?us-ascii?Q?WThdnibQDqLVXmU+pzxAZ689kYvWKb0X5YTWsotTVdbkL9j9nOomFiAtoK4g?=
 =?us-ascii?Q?3zvbatyG3fHCbWqFOQAyZBqkS+LG4qC9JA2gEJPF9fImAwhoqYFh8QgPAtAH?=
 =?us-ascii?Q?0df5mISiYR7g3iYgeJpguHXnorM+2P3mVjGGKddWb9nooFW51HwUE7wdA2N7?=
 =?us-ascii?Q?Uy5jv2+ebTJNmu1Om9rHMWt77mEVYbELSpgVyt+bEbAGMGYYeAfqXTLYykP+?=
 =?us-ascii?Q?Gft7S79zU3XUU80I56MhUi+pLZBIkmFPX+fueT0I1lP1DMGoZmPTcOfan0Vf?=
 =?us-ascii?Q?ywA02ORDF7l8O7NTsIOIXInXl4XZQ16/hMeWWC1vQr/U3LF5bKRbTsmvRIHR?=
 =?us-ascii?Q?yUS/uJGS99FIwLdVW0+i4HELehjvSzYiOqVirYwHdGS89akQ3rpgAXSjxDQe?=
 =?us-ascii?Q?rccJy+N2ZLiKdYC2Pjv+5QWZZQSD4SbuUOxa0kqoAildf4jqyoB4b7EGkWz+?=
 =?us-ascii?Q?hEZXWDbqjY2D3/IYp2meU/qBPdfKieB5mA+Hme+s/3UoOMvazxRqXqZvDT2g?=
 =?us-ascii?Q?kChYTv2WDNXT5kGZGj96mC6jAVcGXdtpaR4bls7SvCqEijH9EGNjTmiEsETW?=
 =?us-ascii?Q?wLBDrglmLTpzv3rNfAQG6sMEHDZS1XRfROtwiVCq0hLmB79k1GZCHYZ6OgK1?=
 =?us-ascii?Q?J+UwcRT8oHwIz+cvmJF5jqf6yGqO2/CiLgyn?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR04MB8951.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(19092799006)(52116014)(7416014)(376014)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?IeZ2t+Tt9PC7Ty2N3vc9gVHO3PQkTwTgF2r4twyflReYTHyZhxaADpki9g+Y?=
 =?us-ascii?Q?L9x+xl73mbAFbek2YkQL8h65n4tQOI6hKfnf/yA3PV7+GujHVXIuTJCu7LV+?=
 =?us-ascii?Q?39nka52eZghpMpIMeiCBnoM2YPZaN4um+MSQZSKlgTEgyabYf7Uwn/jXmZlC?=
 =?us-ascii?Q?8p6B238L5HZ0lbWfp7R0NIr4e61n7ABB7TKwO1TqllcVfyOGyQ70QfTlF9AX?=
 =?us-ascii?Q?ojgvt5LftMJit330i5ofDaAK68J6mBhslGYHs6teZLk0xTXyH1XS0rFwG14O?=
 =?us-ascii?Q?ZrdrA87EcNAERwKsK4DkbHszdaWesv/aSjVE7kbs+7hTZG+erIiOmIqUvOjL?=
 =?us-ascii?Q?ST+jVMBUCJh76WsxoPHwG4jthoTScSwUfYs4ba6wx04yIyCJaXVhNPKEn3VE?=
 =?us-ascii?Q?a0aHYQIaRUeotg5kkLAIDBzYgrAycOYIasnSpTPKdk3VHT7gjUV4fWY3QNRk?=
 =?us-ascii?Q?ACG88/fMQY4GuDyDo9QRbbnxt76IXXpLrW3pSgqk2P/EFtDwIEuloybI3E66?=
 =?us-ascii?Q?pvzCc0p2gG+NbRadvAJgvn5hptuTFkkEQcP5DVyvtMr7VNqyiRMnQAWrEqF+?=
 =?us-ascii?Q?0+LN3IxNIw+98eYSety1Toe/nFnefwX9EOHdMXXbsdmwBQYJGJqwoxjB47gb?=
 =?us-ascii?Q?Nym5XWgFb4EyoIBH/E6Q46vjh52x6p0N1GA6Cdjxt/Ris54xjWDScKhXrtLD?=
 =?us-ascii?Q?g3QgJM+3X2eZKIaW9KZNR3jFEDu887XOyzv6fCTR3iwjQpQZ4ASm0nN0oIi5?=
 =?us-ascii?Q?Am9T3U4RHPSorcPciaKyJecn4sA5HsmR7SZfi7zvGN4qYYHztHKctJWz/4yt?=
 =?us-ascii?Q?/FbYXhWIGR5N5VNPDmv8Ce9RkiXfLstgup1jBmkQA7Etwrs4oKy5vQHfOSXc?=
 =?us-ascii?Q?0fjlYnsTilvigaRS6lsNpYO5j2dVuzuSZTZWbpZtugYudbvZeFs6B98RZtPi?=
 =?us-ascii?Q?GksGFqZns1jCuXVjffceLhwqrDXnIqptGs+xtvRtWW5E8kwUv83xUuOLa2DA?=
 =?us-ascii?Q?0vwAEpX+IZwdk4GMfI/cbDBvJYro6blPNNSLr15AHtlpjEWAKxLU/ErXfbhC?=
 =?us-ascii?Q?DGeEEeazyJkjtgDI0nGmBZ4lkv8x1h67Q+IkqDyLKgr7VZfCOjDbrzT0gWf3?=
 =?us-ascii?Q?cuLvWvAcGFF2FM7WtZ02rUUOilH75GMSIvVUSzypbQYqOW+XMQLlen/ECjrS?=
 =?us-ascii?Q?rHBRIe2z6Dzscvn0jjLOAkl9NZ+q4a55pYshibcAWsn6EEvxhryhI+xEjT0N?=
 =?us-ascii?Q?QBet7HRQIFvS1O3hti/OcFhtV28YWHUnLhpgDB3jIOdKzAIAmhxuj5mva3pw?=
 =?us-ascii?Q?AEUwLpDLDX5g9Aif+XSEFLyrWOV46V3JlWk7eGins+Z6GRLjrwUaskE6Lw7r?=
 =?us-ascii?Q?f3thfSy08yCU1NzWZsL4rUy+oLUn046l4h9ZAiFRCuXi3OTiQSYpAIokiqRt?=
 =?us-ascii?Q?Pd/tkN8jpNhpSTfsgzCQFWmSnQpbE0AJZC0nWRHKQ35tWS5TZ03BZzmFLqiu?=
 =?us-ascii?Q?wc1OxdLkd213OI92Xhtk77jxUXbOhUbq/SlfiKuhFboKs5EbILJlXiVtU+PT?=
 =?us-ascii?Q?5A+zsP24aIPnx5kS39YXMKfxUYkQSpucfeKPC+mE?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 770dc714-2df2-413c-c6b7-08de31bce756
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB8951.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Dec 2025 16:07:34.1461
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7sHKPLFXR0KS0EgGicIiKcgNsl6ODfH5FhfWIYyBjeqJKvBgg4jB3f/3baVCS/l4W10QoLIZXC7WtL6rpRKSLg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR04MB10866

On Tue, Dec 02, 2025 at 03:20:01PM +0900, Koichiro Den wrote:
> On Mon, Dec 01, 2025 at 05:02:57PM -0500, Frank Li wrote:
> > On Sun, Nov 30, 2025 at 01:03:38AM +0900, Koichiro Den wrote:
> > > Hi,
> > >
> > > This is RFC v2 of the NTB/PCI series for Renesas R-Car S4. The ultimate
> > > goal is unchanged, i.e. to improve performance between RC and EP
> > > (with vNTB) over ntb_transport, but the approach has changed drastically.
> > > Based on the feedback from Frank Li in the v1 thread, in particular:
> > > https://lore.kernel.org/all/aQEsip3TsPn4LJY9@lizhi-Precision-Tower-5810/
> > > this RFC v2 instead builds an NTB transport backed by remote eDMA
> > > architecture and reshapes the series around it. The RC->EP interruption
> > > is now achieved using a dedicated eDMA read channel, so the somewhat
> > > "hack"-ish approach in RFC v1 is no longer needed.
> > >
> > > Compared to RFC v1, this v2 series enables NTB transport backed by
> > > remote DW eDMA, so the current ntb_transport handling of Memory Window
> > > is no longer needed, and direct DMA transfers between EP and RC are
> > > used.
> > >
> > > I realize this is quite a large series. Sorry for the volume, but for
> > > the RFC stage I believe presenting the full picture in a single set
> > > helps with reviewing the overall architecture. Once the direction is
> > > agreed, I will respin it split by subsystem and topic.
> > >
> > >
> > ...
> > >
> > > - Before this change:
> > >
> > >   * ping
> > >     64 bytes from 10.0.0.11: icmp_seq=1 ttl=64 time=12.3 ms
> > >     64 bytes from 10.0.0.11: icmp_seq=2 ttl=64 time=6.58 ms
> > >     64 bytes from 10.0.0.11: icmp_seq=3 ttl=64 time=1.26 ms
> > >     64 bytes from 10.0.0.11: icmp_seq=4 ttl=64 time=7.43 ms
> > >     64 bytes from 10.0.0.11: icmp_seq=5 ttl=64 time=1.39 ms
> > >     64 bytes from 10.0.0.11: icmp_seq=6 ttl=64 time=7.38 ms
> > >     64 bytes from 10.0.0.11: icmp_seq=7 ttl=64 time=1.42 ms
> > >     64 bytes from 10.0.0.11: icmp_seq=8 ttl=64 time=7.41 ms
> > >
> > >   * RC->EP (`sudo iperf3 -ub0 -l 65480 -P 2`)
> > >     [ ID] Interval           Transfer     Bitrate         Jitter    Lost/Total Datagrams
> > >     [  5]   0.00-10.01  sec   344 MBytes   288 Mbits/sec  3.483 ms  51/5555 (0.92%)  receiver
> > >     [  6]   0.00-10.01  sec   342 MBytes   287 Mbits/sec  3.814 ms  38/5517 (0.69%)  receiver
> > >     [SUM]   0.00-10.01  sec   686 MBytes   575 Mbits/sec  3.648 ms  89/11072 (0.8%)  receiver
> > >
> > >   * EP->RC (`sudo iperf3 -ub0 -l 65480 -P 2`)
> > >     [  5]   0.00-10.03  sec   334 MBytes   279 Mbits/sec  3.164 ms  390/5731 (6.8%)  receiver
> > >     [  6]   0.00-10.03  sec   334 MBytes   279 Mbits/sec  2.416 ms  396/5741 (6.9%)  receiver
> > >     [SUM]   0.00-10.03  sec   667 MBytes   558 Mbits/sec  2.790 ms  786/11472 (6.9%)  receiver
> > >
> > >     Note: with `-P 2`, the best total bitrate (receiver side) was achieved.
> > >
> > > - After this change (use_remote_edma=1) [1]:
> > >
> > >   * ping
> > >     64 bytes from 10.0.0.11: icmp_seq=1 ttl=64 time=1.48 ms
> > >     64 bytes from 10.0.0.11: icmp_seq=2 ttl=64 time=1.03 ms
> > >     64 bytes from 10.0.0.11: icmp_seq=3 ttl=64 time=0.931 ms
> > >     64 bytes from 10.0.0.11: icmp_seq=4 ttl=64 time=0.910 ms
> > >     64 bytes from 10.0.0.11: icmp_seq=5 ttl=64 time=1.07 ms
> > >     64 bytes from 10.0.0.11: icmp_seq=6 ttl=64 time=0.986 ms
> > >     64 bytes from 10.0.0.11: icmp_seq=7 ttl=64 time=0.910 ms
> > >     64 bytes from 10.0.0.11: icmp_seq=8 ttl=64 time=0.883 ms
> > >
> > >   * RC->EP (`sudo iperf3 -ub0 -l 65480 -P 4`)
> > >     [  5]   0.00-10.01  sec  3.54 GBytes  3.04 Gbits/sec  0.030 ms  0/58007 (0%)  receiver
> > >     [  6]   0.00-10.01  sec  3.71 GBytes  3.19 Gbits/sec  0.453 ms  0/60909 (0%)  receiver
> > >     [  9]   0.00-10.01  sec  3.85 GBytes  3.30 Gbits/sec  0.027 ms  0/63072 (0%)  receiver
> > >     [ 11]   0.00-10.01  sec  3.26 GBytes  2.80 Gbits/sec  0.070 ms  1/53512 (0.0019%)  receiver
> > >     [SUM]   0.00-10.01  sec  14.4 GBytes  12.3 Gbits/sec  0.145 ms  1/235500 (0.00042%)  receiver
> > >
> > >   * EP->RC (`sudo iperf3 -ub0 -l 65480 -P 4`)
> > >     [  5]   0.00-10.03  sec  3.40 GBytes  2.91 Gbits/sec  0.104 ms  15467/71208 (22%)  receiver
> > >     [  6]   0.00-10.03  sec  3.08 GBytes  2.64 Gbits/sec  0.176 ms  12097/62609 (19%)  receiver
> > >     [  9]   0.00-10.03  sec  3.38 GBytes  2.90 Gbits/sec  0.270 ms  17212/72710 (24%)  receiver
> > >     [ 11]   0.00-10.03  sec  2.56 GBytes  2.19 Gbits/sec  0.200 ms  11193/53090 (21%)  receiver
> >
> > Almost 10x fast, 2.9G vs 279M? high light this one will bring more peopole
> > interesting about this topic.
>
> Thank you for the review!
>
> OK, I'll highlight this in the next iteration.
> By the way, my impression is that we can achieve even higher with this remote
> eDMA architecture.

eDMA can reduce one memory copy and longer TLP data length. Previously, I
tried use RDMA framework some year ago, but it is over complex and stop the
work.

>
> >
> > >     [SUM]   0.00-10.03  sec  12.4 GBytes  10.6 Gbits/sec  0.188 ms  55969/259617 (22%)  receiver
> > >
> > >   [1] configfs settings:
> > >       # modprobe pci_epf_vntb dyndbg=+pmf
> > >       # cd /sys/kernel/config/pci_ep/
> > >       # mkdir functions/pci_epf_vntb/func1
> > >       # echo 0x1912 >   functions/pci_epf_vntb/func1/vendorid
> > >       # echo 0x0030 >   functions/pci_epf_vntb/func1/deviceid
> > >       # echo 32 >       functions/pci_epf_vntb/func1/msi_interrupts
> > >       # echo 16 >       functions/pci_epf_vntb/func1/pci_epf_vntb.0/db_count
> > >       # echo 128 >      functions/pci_epf_vntb/func1/pci_epf_vntb.0/spad_count
> > >       # echo 2 >        functions/pci_epf_vntb/func1/pci_epf_vntb.0/num_mws
> > >       # echo 0xe0000 >  functions/pci_epf_vntb/func1/pci_epf_vntb.0/mw1
> > >       # echo 0x20000 >  functions/pci_epf_vntb/func1/pci_epf_vntb.0/mw2
> > >       # echo 0xe0000 >  functions/pci_epf_vntb/func1/pci_epf_vntb.0/mw2_offset
> >
> > look like, you try to create sub-small mw windows.
> >
> > Is it more clean ?
> >
> > echo 0xe0000 >  functions/pci_epf_vntb/func1/pci_epf_vntb.0/mw1.0
> > echo 0x20000 >  functions/pci_epf_vntb/func1/pci_epf_vntb.0/mw1.1
> >
> > so wm1.1 natively continue from prevous one.
>
> Thanks for the suggestion.
>
> I was trying to keep the sub-small mw windows referred to in the same way
> as normal windows for simplicity and readability, but I agree your proposal
> looks intuitive from a User-eXperience point of view.
>
> My only concern is that e.g. {mw1.0, mw1.1, mw2.0} may translate internally
> into something like {mw1, mw2, mw3} effectively, and that numbering
> mismatch might become confusing when reading or debugging the code.

If there are enough bars, you can try use one dedicate bar for EDMA register
space, LL space shared with bar0 (control bar) to reduce complex, and get
better performace firstly.

Frank

>
> -Koichiro
>
> >
> > Frank
> >
> > >       # echo 0x1912 >   functions/pci_epf_vntb/func1/pci_epf_vntb.0/vntb_vid
> > >       # echo 0x0030 >   functions/pci_epf_vntb/func1/pci_epf_vntb.0/vntb_pid
> > >       # echo 0x10 >     functions/pci_epf_vntb/func1/pci_epf_vntb.0/vbus_number
> > >       # echo 0 >        functions/pci_epf_vntb/func1/pci_epf_vntb.0/ctrl_bar
> > >       # echo 4 >        functions/pci_epf_vntb/func1/pci_epf_vntb.0/db_bar
> > >       # echo 2 >        functions/pci_epf_vntb/func1/pci_epf_vntb.0/mw1_bar
> > >       # echo 2 >        functions/pci_epf_vntb/func1/pci_epf_vntb.0/mw2_bar
> > >       # ln -s controllers/e65d0000.pcie-ep functions/pci_epf_vntb/func1/primary/
> > >       # echo 1 > controllers/e65d0000.pcie-ep/start
> > >
> > >
> > > Thanks for taking a look.
> > >
> > >
> > > Koichiro Den (27):
> > >   PCI: endpoint: pci-epf-vntb: Use array_index_nospec() on mws_size[]
> > >     access
> > >   PCI: endpoint: pci-epf-vntb: Add mwN_offset configfs attributes
> > >   NTB: epf: Handle mwN_offset for inbound MW regions
> > >   PCI: endpoint: Add inbound mapping ops to EPC core
> > >   PCI: dwc: ep: Implement EPC inbound mapping support
> > >   PCI: endpoint: pci-epf-vntb: Use pci_epc_map_inbound() for MW mapping
> > >   NTB: Add offset parameter to MW translation APIs
> > >   PCI: endpoint: pci-epf-vntb: Propagate MW offset from configfs when
> > >     present
> > >   NTB: ntb_transport: Support offsetted partial memory windows
> > >   NTB: core: Add .get_pci_epc() to ntb_dev_ops
> > >   NTB: epf: vntb: Implement .get_pci_epc() callback
> > >   damengine: dw-edma: Fix MSI data values for multi-vector IMWr
> > >     interrupts
> > >   NTB: ntb_transport: Use seq_file for QP stats debugfs
> > >   NTB: ntb_transport: Move TX memory window setup into setup_qp_mw()
> > >   NTB: ntb_transport: Dynamically determine qp count
> > >   NTB: ntb_transport: Introduce get_dma_dev() helper
> > >   NTB: epf: Reserve a subset of MSI vectors for non-NTB users
> > >   NTB: ntb_transport: Introduce ntb_transport_backend_ops
> > >   PCI: dwc: ep: Cache MSI outbound iATU mapping
> > >   NTB: ntb_transport: Introduce remote eDMA backed transport mode
> > >   NTB: epf: Provide db_vector_count/db_vector_mask callbacks
> > >   ntb_netdev: Multi-queue support
> > >   NTB: epf: Add per-SoC quirk to cap MRRS for DWC eDMA (128B for R-Car)
> > >   iommu: ipmmu-vmsa: Add PCIe ch0 to devices_allowlist
> > >   iommu: ipmmu-vmsa: Add support for reserved regions
> > >   arm64: dts: renesas: Add Spider RC/EP DTs for NTB with remote DW PCIe
> > >     eDMA
> > >   NTB: epf: Add an additional memory window (MW2) barno mapping on
> > >     Renesas R-Car
> > >
> > >  arch/arm64/boot/dts/renesas/Makefile          |    2 +
> > >  .../boot/dts/renesas/r8a779f0-spider-ep.dts   |   46 +
> > >  .../boot/dts/renesas/r8a779f0-spider-rc.dts   |   52 +
> > >  drivers/dma/dw-edma/dw-edma-core.c            |   28 +-
> > >  drivers/iommu/ipmmu-vmsa.c                    |    7 +-
> > >  drivers/net/ntb_netdev.c                      |  341 ++-
> > >  drivers/ntb/Kconfig                           |   11 +
> > >  drivers/ntb/Makefile                          |    3 +
> > >  drivers/ntb/hw/amd/ntb_hw_amd.c               |    6 +-
> > >  drivers/ntb/hw/epf/ntb_hw_epf.c               |  177 +-
> > >  drivers/ntb/hw/idt/ntb_hw_idt.c               |    3 +-
> > >  drivers/ntb/hw/intel/ntb_hw_gen1.c            |    6 +-
> > >  drivers/ntb/hw/intel/ntb_hw_gen1.h            |    2 +-
> > >  drivers/ntb/hw/intel/ntb_hw_gen3.c            |    3 +-
> > >  drivers/ntb/hw/intel/ntb_hw_gen4.c            |    6 +-
> > >  drivers/ntb/hw/mscc/ntb_hw_switchtec.c        |    6 +-
> > >  drivers/ntb/msi.c                             |    6 +-
> > >  drivers/ntb/ntb_edma.c                        |  628 ++++++
> > >  drivers/ntb/ntb_edma.h                        |  128 ++
> > >  .../{ntb_transport.c => ntb_transport_core.c} | 1829 ++++++++++++++---
> > >  drivers/ntb/test/ntb_perf.c                   |    4 +-
> > >  drivers/ntb/test/ntb_tool.c                   |    6 +-
> > >  .../pci/controller/dwc/pcie-designware-ep.c   |  287 ++-
> > >  drivers/pci/controller/dwc/pcie-designware.h  |    7 +
> > >  drivers/pci/endpoint/functions/pci-epf-vntb.c |  229 ++-
> > >  drivers/pci/endpoint/pci-epc-core.c           |   44 +
> > >  include/linux/ntb.h                           |   39 +-
> > >  include/linux/ntb_transport.h                 |   21 +
> > >  include/linux/pci-epc.h                       |   11 +
> > >  29 files changed, 3415 insertions(+), 523 deletions(-)
> > >  create mode 100644 arch/arm64/boot/dts/renesas/r8a779f0-spider-ep.dts
> > >  create mode 100644 arch/arm64/boot/dts/renesas/r8a779f0-spider-rc.dts
> > >  create mode 100644 drivers/ntb/ntb_edma.c
> > >  create mode 100644 drivers/ntb/ntb_edma.h
> > >  rename drivers/ntb/{ntb_transport.c => ntb_transport_core.c} (59%)
> > >
> > > --
> > > 2.48.1
> > >

