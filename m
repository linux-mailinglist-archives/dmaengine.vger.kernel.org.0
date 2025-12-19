Return-Path: <dmaengine+bounces-7842-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E5AFFCD057F
	for <lists+dmaengine@lfdr.de>; Fri, 19 Dec 2025 15:45:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 69D5530A7A57
	for <lists+dmaengine@lfdr.de>; Fri, 19 Dec 2025 14:39:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE770322A24;
	Fri, 19 Dec 2025 14:39:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="BD/A165k"
X-Original-To: dmaengine@vger.kernel.org
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012020.outbound.protection.outlook.com [52.101.66.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 828B1246BB2;
	Fri, 19 Dec 2025 14:39:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766155193; cv=fail; b=sbb1NTxq9ueFQPDdjefEXhrpffgpMDoJsZGeWFvAFstGCYUr7+xOeQiluBWD7RoLe58UJ8Oo21lxCTFr1NWKjm4qPE452BSdiLL26rKh0FDcEDCuH78F+xxIf2FBf38fiqE9+BjgKyxIoc+1blvOxco309aGxW6e+sQOqwmY6Zk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766155193; c=relaxed/simple;
	bh=kXgiYrON4eiLK3kwKNVNWO6DcEY9pVjtvOqtd4dnjPU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=d2xty7j0p8EKIoaGk7RS40s/wQ3QyRs3XDGY2MNPWnj4Iu6o5qSrMV8P2330e1XBLT5QPiqd9WBVZm3WXPsVsyVHWwgvo5ABRQu438PTs9MubCeSaD5RbasCS8V5UkM/W/pmcebrJn7fFcRPIYQ5FS0jqJ6HQ/DF0YFkIMfvJSU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=BD/A165k; arc=fail smtp.client-ip=52.101.66.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VNSrWKc2SC1o3LGZQkh2EOaVzwa2vV7gN2XUvKyQT1h/n4d1NPcvpFzrSrgE6HwcBfWZCDdOxK1RaOAu0wBdwnqFQnaZ93zqiyc1j6sMIijaO1CBANAv9k30IKgOegt3kQm/pikUDl86FawP2bxsTHoYgIctl0q58/ivLV5Z2UKBis944Xsu1aNsdmjz7K0fC/m/lQH46NODe6yYZ38xoJEWYIFAaL31dveEOiwSQmGYoX+dSYqcwtBVTP4FgEChY/cUoMfAJpp8Fg42WJy7K7s//rtn3Jl9dmkjx3OFIQuPyUawaxTJVGzekrcja2MffITDoSvzvV2LHyhqEWOYJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QUmXneIOMNJssUKDzBnJUFF/ilxJ4V+kQyoHRIal90E=;
 b=Y6wYukoCLrHFy8fYBFhjQMAyPW1cT9h+6J4fsVwbgy9pQThgKOvopgyVCFrjNKpR8iy3ZyqAlJLgcSyfsLrUK6BauxiVdNSB9JOlVc8D/0TNoeOTE1oawPpenFZSs3tsC6FuKPzwRyaIQwDIHMaHWxVeJyXlM+Xs+QifwxhWhkJYE0iZIyvzlTbpTLdgsWSFSslSfQu7DyYyXo3RP103TCL29lnMk8mdtZRhRtVyTwSLoaKyNot05XpzwUw1HUI6VcJFCmepDSdle5t3EhV24il/CkiZsBDv/6b4Ce38KukPmEc5HjozOvLE78YLqrQ+jhVemDXeS9gQfRgNPakDww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QUmXneIOMNJssUKDzBnJUFF/ilxJ4V+kQyoHRIal90E=;
 b=BD/A165kt7g/V8Li8DpVb+0UCup2r67iHqWptyn1z+Fn19XVCeXzYy7C/54TdoNYQiUAbEPa9nl2j5TAkvenKvf+jZSYJFBXrC+bCqclJ7zxLfaAjJeYFVDnXUqUmDfdOv6floxBJWRosO7IM3fopZc4xEK6qZd886TBnlFHcFvrtI6MnCXqkulBN0U2ufRSqMq3FCNrcVDMwDuwAjyBIHt9WIRMZREHbh1DRnJtnxrfOM37jCI9iichgijao9dB5sI0lSDLPePpIX36MTPI8ns08Sl+emh2tUIa56ep40Y6AQsQbKK1pURTES37ahVsUb68SG9lrq1AJqIJ55OsVQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DU2PR04MB8951.eurprd04.prod.outlook.com (2603:10a6:10:2e2::22)
 by PA6PR04MB11951.eurprd04.prod.outlook.com (2603:10a6:102:515::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9434.8; Fri, 19 Dec
 2025 14:39:48 +0000
Received: from DU2PR04MB8951.eurprd04.prod.outlook.com
 ([fe80::753c:468d:266:196]) by DU2PR04MB8951.eurprd04.prod.outlook.com
 ([fe80::753c:468d:266:196%4]) with mapi id 15.20.9434.001; Fri, 19 Dec 2025
 14:39:48 +0000
Date: Fri, 19 Dec 2025 09:39:37 -0500
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
Subject: Re: [RFC PATCH v3 22/35] dmaengine: dw-edma: Serialize RMW on shared
 interrupt registers
Message-ID: <aUVjqbk1tQjJ1AEh@lizhi-Precision-Tower-5810>
References: <20251217151609.3162665-1-den@valinux.co.jp>
 <20251217151609.3162665-23-den@valinux.co.jp>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251217151609.3162665-23-den@valinux.co.jp>
X-ClientProxiedBy: PH8PR02CA0014.namprd02.prod.outlook.com
 (2603:10b6:510:2d0::6) To DU2PR04MB8951.eurprd04.prod.outlook.com
 (2603:10a6:10:2e2::22)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PR04MB8951:EE_|PA6PR04MB11951:EE_
X-MS-Office365-Filtering-Correlation-Id: 583aff54-c4cb-435e-0af6-08de3f0c75d6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|19092799006|376014|52116014|7416014|366016|38350700014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?kI2yZcALdUY66vAuoCLuUa7bzhBkDlPA+ERbDpBDKkDqPFEjOuCW//xwqNjb?=
 =?us-ascii?Q?CH8U6dUgI6Lwi5/gSkLK9INmxQCcdLgcRHFuQ4/NtjnGLPXXYDO+K5UC8GT6?=
 =?us-ascii?Q?4aW063owhyK1LD0raHDdaCFFiMghuS2nCbbNRJJgHDndvvghDESLrCVP5xZ6?=
 =?us-ascii?Q?IiyQXPGKEpdakenJoArvuB5XQLnM2pled/Fp3E96RA/gAwpqvFsf6oSDJuaS?=
 =?us-ascii?Q?zMRcqU0e05ZUCgj0NRUS4tBYFh1Q7shun7cQjXL7qhzeOmHO0S+HDksIYHe1?=
 =?us-ascii?Q?dxDAB9VmrI6nOrE+ZjvPfez7r8JtFCW2tq0AkZLCwvQvswsaDgEKRpBp+4Bd?=
 =?us-ascii?Q?JMvXxLE/l3BTCBYiHOdyQXnR8GWofO1+sVTIuVMNBOlKoJKUQk3YbMiA8h8F?=
 =?us-ascii?Q?t4P4x9FbMul7Mv3qJkwT2gzeS65FaQIIWN17E3wAjh2F0UicKeAzjbfX5cuO?=
 =?us-ascii?Q?6/lBby4Sc+MZrik2DAw3kMCktdV1yy7wnw3CKsLEIuinp4Qq6FYSMmPj5hYG?=
 =?us-ascii?Q?wIKdFAcCANVjj2VRQSxTG7nbSARmU69s6/QVA2/Xz+AA2LIwQCOa3q/bVlUH?=
 =?us-ascii?Q?qmScRFCHsGN9H1NR3W6Z/W8hzK8B2BcZOsyCzYIk7dH4zYJxokWe2EGjD9HW?=
 =?us-ascii?Q?gNdgLl9g0S7AE/OBduKGyeRNKmP2FNl21aQpwMZCi3EkrT4s8nWr2CbmLrNF?=
 =?us-ascii?Q?bM9oPVn/bBdsyaGNDOE6rzU8lpS6gZp2/M2vFbNkMdiCQtamdSRqvJHiXL0y?=
 =?us-ascii?Q?eHrCcHSuhHPhsEIWXNfJCfTXkscTbe1rhQWi9W520kJ806kA/cbN/ZX/2TF7?=
 =?us-ascii?Q?OlRsObLlCwUtgSC4GuKY59G+YxBw2dy9c/bz8CP3G7MH0kLWAbpPIu/ok7LT?=
 =?us-ascii?Q?8f/m54gjJUDxaPtd3J8R2tNxVjZqU9cH0TIl+qsDFMrOGZTXLBZ0wPNiEvp9?=
 =?us-ascii?Q?+HktcV+uVHAGZVc1bn3GJnFhczlguZsnt4ZS80RU7l/OxQP8zx8f8OA0PmAa?=
 =?us-ascii?Q?K6ASO5SDPtK6Zoy6gcxMC02VdXP+bA58gIMzUXtLYrljYoKBl3aSrdlTmEQj?=
 =?us-ascii?Q?ZVuOzvYmlJSyQxIAC7IeDu+3ln+91ov2nCTntC7deq/Yah92dvJhsDmPJyuh?=
 =?us-ascii?Q?wVJoDGvgbwV1ReUZ7wEwKlYXKB0tlPzfjxTk3af+9YI33YyEs8ObEb1GqY+z?=
 =?us-ascii?Q?dt83ixRaCyUtnlPxj1IZTaB/0ctCtDj1TGwQ95suWpAR1hBkg7eZ0icu8o5v?=
 =?us-ascii?Q?3nOyV4VWyveRMRhPYX4ZD7Wom3VE92M7vV+ykC/EhrLVx9PosSkesZLid4PO?=
 =?us-ascii?Q?zioz+/l10MMKu7PZ84lMLVHdc+6PpFDIDAS0u7vJRuzOpPBa6eT0ST9JmBgP?=
 =?us-ascii?Q?mhNoB7gU4M/P7iWECaC/YYhVkvmBGBp4BnC9RIEAn3hBDKWL6t83KsPoMCwG?=
 =?us-ascii?Q?S0CaKjkpYRaYhKytXJMuTGuSSAu5q8KqfDX89j/N4EE0QyBQ1Wob6v30rdgI?=
 =?us-ascii?Q?aXzp2aiiNiDh9zLu5nuX21sBcLXKUjhPQ+X2?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR04MB8951.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(19092799006)(376014)(52116014)(7416014)(366016)(38350700014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?MPZas5xSKfkgLPddC6taeiVG4/YXRWU+JuEKyD+NIrX8ZXkcpdJaDN8+jpPR?=
 =?us-ascii?Q?PWHH4p8SUjsOgpySthic/rWlCgz9qg8Vl4pLm2cRNR0ilc4DikInxMxPWJ0E?=
 =?us-ascii?Q?eFgBiqMStnY8ESvXDNWEXDAQjBwcyobLf03NVGH0SlJMHwVaYXB3MRh77Yjt?=
 =?us-ascii?Q?8zekz63NZysf2MTRFjomTwYEtyEe6zEHUx8Mv+37Bra+YGU1OziY+CNUMTiJ?=
 =?us-ascii?Q?job4Uzy7iTos5DMsXToUzL8j534p5OqKrsRbV5b0MUj3ODmMWEQ5M/FxOeHb?=
 =?us-ascii?Q?yUnGWyBb1n38VN+K55vfDgUvGVCZyZUXPkp1h6LK/aFBPnG/xw2RiZBxExdZ?=
 =?us-ascii?Q?kpSIW630j3RZ5BedimqmZT2SiUIFmrVJ0rlfMIYqm2VI7Vg3QpTR/xADaIyV?=
 =?us-ascii?Q?OnTuLsqcbkp/OCw1SwOgArnGgeBjOrytKliOfSCRM7aRaklBreYwhY2Cj0rX?=
 =?us-ascii?Q?C0KJ0QUKYfW2WnppeRCeXqKD0W4PoSORcqILNoqRdZAjFHrgLb+bNK4dyz+Y?=
 =?us-ascii?Q?1a5RyYVk5HW5lYK8AVlvIgGueUniDHuMJAYw/C5DKATqSr4LuBEJVeHViOjb?=
 =?us-ascii?Q?qKRjHHr+0hiEl/t7QsazC13HgyHfuDyt0IgxymqsJ3TcifD7RiIUw1a+zi6U?=
 =?us-ascii?Q?eRwWAAIT5DR2eUA9QAdYQPz/CiuyOcWCDuwrTD/L7AIFYu7V+BaNqncIttHE?=
 =?us-ascii?Q?JjGxk+FYRqgZ0LImjMDdscyGiGvlZDscbAAM+hL60sb//9JbKrD4kIShdKwx?=
 =?us-ascii?Q?E/Y0Hq0e1g2COJiKOPeGl8sAtCSetiTU3GUB/JBW3/A/AXh9sQyQ2cek3llv?=
 =?us-ascii?Q?P46unD2OjdIr5yQp6glWKOoECHiyMLvMCbNX+CNYLX4btfaaxGfXYaUQFmMR?=
 =?us-ascii?Q?yXTRSpeP9vt4bTavgy+Ssge6aaYFERZKB+D6jVfneBNmbXxNsj6DPfoiMyaX?=
 =?us-ascii?Q?c6ojd8gpFV57VkpzDzRMOgv98UXEqTOgvjE1l4JsS6APZop7J5ofta+GK8aJ?=
 =?us-ascii?Q?1myF2tLEQkL593Sm2VDUveRUCBPDOFW+c67Ui/MaGIaybn0jFdMe2wloq72F?=
 =?us-ascii?Q?PwtfWKveDxBj1JnRpwgABG1QmnE492U2lqDNyH8DJq9fmKyHIolGSHnGooBm?=
 =?us-ascii?Q?QMtjXJy7JyoBKC3gYLq3jy1rHhX6aSjxtvF17hwT1xzcEF8vkAnxC22lQmFU?=
 =?us-ascii?Q?SfKrHHWDktMzLwjTxzrWxQ/o7xyO1/PH8YiSD5DRkcsMRdYPqAcKiPpF4lvO?=
 =?us-ascii?Q?s3ecKCofjq6aeJ0EBRY8opEEwVpN7woeucoUOl5UTYxBGhm145B8JrHCX0jp?=
 =?us-ascii?Q?+NxThXst5EImmFbXgkplOpXdqh1URiGjiBBsMzbejPKUq6QzMMhBs92h5V0d?=
 =?us-ascii?Q?+xmxebNLxyCC2R4vO06pjnJHibrqSD9ZIYvt9W66pb5MpbEvkJaXCoTkDT1a?=
 =?us-ascii?Q?PSo7iXTi/Ee8yDgiBM1r5WNsDN6LJaz8AacQfm40lFy9S3ZKOo2hz1fo15eX?=
 =?us-ascii?Q?N1dWNKcKAwbP1RtreFjnTVv9K7Ko8/g+rfTELRQaJh18KVjQfo67N0m9u4D6?=
 =?us-ascii?Q?WoMpEh2Xvoqg9bk2SDiY0nt60i/pCEtFYOOToIiK?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 583aff54-c4cb-435e-0af6-08de3f0c75d6
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB8951.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Dec 2025 14:39:48.3604
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: X61kZzpJ71BUMGxLnRWacvtmuwBL3sg9VautrykprB+AaZRMt3y9wjokjNsxdrrswZzCK8JqqTyuiEW4iB0HSg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA6PR04MB11951

On Thu, Dec 18, 2025 at 12:15:56AM +0900, Koichiro Den wrote:
> The per-direction int_mask and linked_list_err_en registers are shared
> between all channels. Updating them requires a read-modify-write
> sequence, which can lose concurrent updates when multiple channels are
> started in parallel. This may leave interrupts masked and stall
> transfers under high load.
>
> Protect the RMW sequences with dw->lock.
>
> Signed-off-by: Koichiro Den <den@valinux.co.jp>
> ---

I just posted a similar patch
https://lore.kernel.org/imx/20251212-edma_ll-v1-1-fc863d9f5ca3@nxp.com/

It change some method and I am working on add new request during dma engine
running.

At least, you can base on above thread.

Frank

>  drivers/dma/dw-edma/dw-edma-core.h    |  3 ++-
>  drivers/dma/dw-edma/dw-edma-v0-core.c | 13 ++++++++++---
>  2 files changed, 12 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/dma/dw-edma/dw-edma-core.h b/drivers/dma/dw-edma/dw-edma-core.h
> index f652d2e38843..d393976a8bfc 100644
> --- a/drivers/dma/dw-edma/dw-edma-core.h
> +++ b/drivers/dma/dw-edma/dw-edma-core.h
> @@ -118,7 +118,8 @@ struct dw_edma {
>
>  	struct dw_edma_chan		*chan;
>
> -	raw_spinlock_t			lock;		/* Only for legacy */
> +	/* For legacy + shared regs RMW among channels */
> +	raw_spinlock_t			lock;
>
>  	struct dw_edma_chip             *chip;
>
> diff --git a/drivers/dma/dw-edma/dw-edma-v0-core.c b/drivers/dma/dw-edma/dw-edma-v0-core.c
> index 42a254eb9379..770b011ba3e4 100644
> --- a/drivers/dma/dw-edma/dw-edma-v0-core.c
> +++ b/drivers/dma/dw-edma/dw-edma-v0-core.c
> @@ -369,7 +369,8 @@ static void dw_edma_v0_core_start(struct dw_edma_chunk *chunk, bool first)
>  {
>  	struct dw_edma_chan *chan = chunk->chan;
>  	struct dw_edma *dw = chan->dw;
> -	u32 tmp;
> +	unsigned long flags;
> +	u32 tmp, orig;
>
>  	dw_edma_v0_core_write_chunk(chunk);
>
> @@ -413,7 +414,9 @@ static void dw_edma_v0_core_start(struct dw_edma_chunk *chunk, bool first)
>  			}
>  		}
>  		/* Interrupt mask/unmask - done, abort */
> +		raw_spin_lock_irqsave(&dw->lock, flags);
>  		tmp = GET_RW_32(dw, chan->dir, int_mask);
> +		orig = tmp;
>  		if (chan->irq_mode == DW_EDMA_CH_IRQ_REMOTE) {
>  			tmp |= FIELD_PREP(EDMA_V0_DONE_INT_MASK, BIT(chan->id));
>  			tmp |= FIELD_PREP(EDMA_V0_ABORT_INT_MASK, BIT(chan->id));
> @@ -421,11 +424,15 @@ static void dw_edma_v0_core_start(struct dw_edma_chunk *chunk, bool first)
>  			tmp &= ~FIELD_PREP(EDMA_V0_DONE_INT_MASK, BIT(chan->id));
>  			tmp &= ~FIELD_PREP(EDMA_V0_ABORT_INT_MASK, BIT(chan->id));
>  		}
> -		SET_RW_32(dw, chan->dir, int_mask, tmp);
> +		if (tmp != orig)
> +			SET_RW_32(dw, chan->dir, int_mask, tmp);
>  		/* Linked list error */
>  		tmp = GET_RW_32(dw, chan->dir, linked_list_err_en);
> +		orig = tmp;
>  		tmp |= FIELD_PREP(EDMA_V0_LINKED_LIST_ERR_MASK, BIT(chan->id));
> -		SET_RW_32(dw, chan->dir, linked_list_err_en, tmp);
> +		if (tmp != orig)
> +			SET_RW_32(dw, chan->dir, linked_list_err_en, tmp);
> +		raw_spin_unlock_irqrestore(&dw->lock, flags);
>  		/* Channel control */
>  		SET_CH_32(dw, chan->dir, chan->id, ch_control1,
>  			  (DW_EDMA_V0_CCS | DW_EDMA_V0_LLE));
> --
> 2.51.0
>

