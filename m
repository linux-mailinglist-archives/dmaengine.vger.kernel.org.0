Return-Path: <dmaengine+bounces-8092-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E245CFE950
	for <lists+dmaengine@lfdr.de>; Wed, 07 Jan 2026 16:31:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 2922430010F7
	for <lists+dmaengine@lfdr.de>; Wed,  7 Jan 2026 15:31:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB9B934DCEE;
	Wed,  7 Jan 2026 15:05:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="Awho8U+1"
X-Original-To: dmaengine@vger.kernel.org
Received: from TY3P286CU002.outbound.protection.outlook.com (mail-japaneastazon11020078.outbound.protection.outlook.com [52.101.229.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97C1334A3CB;
	Wed,  7 Jan 2026 15:05:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.229.78
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767798354; cv=fail; b=krmKK32feHjTUK27w7K2Ha3LOT7V8f7p5dCURvg7binYNDhJhnV7TdvkZdZhwFr/JIoaUzDqohBDDmnif8/1d8cgRFDEQrAj73aAc6Ff6u8Es5fndBahAXPtVCNx3fuMDrTeCYGP3AE7RAALl9C5RyJdQz8LgbkkT3SoKwWYewY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767798354; c=relaxed/simple;
	bh=edwkCTr7pRxd2KvfEccHtdeya0otd7ZxBnoNgCgijjo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=rgD6lk1tJPsn1RspUveaOO5wW0SIiUh/mntKlceB2XWejI86DipyjD9sxTbxdS8k1D8M4TFbti7NW+75xSvYOH05ieg7NNpwNnJ1R5t3oA4Lx+//6QOv7XaRFTJd26rzvC6/tUHNYTLyPuyNb2pWhWXj1F3QSu+ncgfLzP8ofk0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=Awho8U+1; arc=fail smtp.client-ip=52.101.229.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fBouaXS0puuUpx92/zLmF/MFnVk99bUYGL/lPx4TnTmZpG9w57IAjlgyZWr6bw/NUuqeOR88p5GJU9BL74a3AdMCwPXqEaonsJpuXeXPpg3q4wLVo4moG7m5/JENwGWJ06aJT1jp7vuIiqW0/RyxpH1C2b0JFSoeBhBppbWCVW8QVerLZ39dKWN5i+fa+K3ZIDd30zuR8V1ErN7vFW/T6YAt4ZOClJqUx95n05azWL2D4ot+vjwIJgkRRrE6/+DN06npBBwcZvq20e5dVfsIZ4fgUHDrPFSrrkOy4AyP0+hwUmRBz426TbqC11mFX4tHxM4rkBl6Iz7djYrN/dWGtg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nwldanmE/BmBEEy9j68dj9QmmEPGhXt+A4WcC/LcDlc=;
 b=pfaL5DEXzcjNBZTrIM3Cww1A/BKzOc0/MJseK26Ss3nJI+kUSqYLpRgcuW5EYPoTa9AQksxSsysyFPEzITqxlf6+RyHyx1MkZoBNS2f1J+4ZeorvnLzo9O1WP6BmlwngDUo+NHWAsM7/s7/RKR4WsZyKrSMT6cc5rCDB4e9qsC0DeFzrfJKi2Jbh1Y2BjQyVvDJy3V9SHB+Dl22n9LMigN23314vJ7c/iKLgMt/Bx0/1NZVO3S6o1kYsgs7g24/qv5uSiVVy8Mxxs8GWSifbP7in37qEL0gM48AQxDuBIfzLAgf6GidXDjARXsG5cPXRIKk0QOD0MwWEP/lEEFdSuA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nwldanmE/BmBEEy9j68dj9QmmEPGhXt+A4WcC/LcDlc=;
 b=Awho8U+1rjT2X/HeKFsEDmcHbE0GuCcoN3GlgIvBsi+lluc5u/LyegPHyN2HLKYY2Rj1ERbFBklDwZ91WHYB/ExUuujcJJk1/xzrwRKnMyaXXMjC2IrUw7fHyc8ofXyUE+zwhotaJVoD57SEaenDOYdobqUTljErfZkaz/rirB0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:38f::10)
 by TYWP286MB2618.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:249::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.2; Wed, 7 Jan
 2026 15:05:48 +0000
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32]) by TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32%5]) with mapi id 15.20.9499.002; Wed, 7 Jan 2026
 15:05:48 +0000
Date: Thu, 8 Jan 2026 00:05:47 +0900
From: Koichiro Den <den@valinux.co.jp>
To: Dave Jiang <dave.jiang@intel.com>
Cc: Frank Li <Frank.li@nxp.com>, ntb@lists.linux.dev, 
	linux-pci@vger.kernel.org, dmaengine@vger.kernel.org, linux-renesas-soc@vger.kernel.org, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, mani@kernel.org, 
	kwilczynski@kernel.org, kishon@kernel.org, bhelgaas@google.com, corbet@lwn.net, 
	geert+renesas@glider.be, magnus.damm@gmail.com, robh@kernel.org, krzk+dt@kernel.org, 
	conor+dt@kernel.org, vkoul@kernel.org, joro@8bytes.org, will@kernel.org, 
	robin.murphy@arm.com, jdmason@kudzu.us, allenbh@gmail.com, andrew+netdev@lunn.ch, 
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, 
	Basavaraj.Natikar@amd.com, Shyam-sundar.S-k@amd.com, kurt.schwemmer@microsemi.com, 
	logang@deltatee.com, jingoohan1@gmail.com, lpieralisi@kernel.org, 
	utkarsh02t@gmail.com, jbrunet@baylibre.com, dlemoal@kernel.org, arnd@arndb.de, 
	elfring@users.sourceforge.net
Subject: Re: [RFC PATCH v3 26/35] NTB: ntb_transport: Introduce DW eDMA
 backed transport mode
Message-ID: <464boaywnbpuhnnydmfah7ru246sxebdwuoc7r42gqwv35iu7c@7w7bgid2ds4m>
References: <20251217151609.3162665-1-den@valinux.co.jp>
 <20251217151609.3162665-27-den@valinux.co.jp>
 <aUVopEgFmxsMIPpI@lizhi-Precision-Tower-5810>
 <anjphdkxqxkjdgjf3ylngtt6dtgtgur3gnqpwaafn5wf4qqfzu@4jiziokytosb>
 <1696a452-f1ca-4bb0-b5a2-6dcaf84c514e@intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1696a452-f1ca-4bb0-b5a2-6dcaf84c514e@intel.com>
X-ClientProxiedBy: TY4PR01CA0028.jpnprd01.prod.outlook.com
 (2603:1096:405:2bf::17) To TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:38f::10)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY7P286MB7722:EE_|TYWP286MB2618:EE_
X-MS-Office365-Filtering-Correlation-Id: ee1c2002-6195-4ad4-3457-08de4dfe3db8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|7416014|10070799003|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?v928qbUZy6MdGxkck/EAZS/hk1ENx/4UxUgHIH2GNn4gpe3Uig27OysWpq0G?=
 =?us-ascii?Q?drb2J4kELorK05SagQGxkdAROGoU93h7VIIyqRrbkBAc2tTh3K/HXv4lnSMf?=
 =?us-ascii?Q?OMueAmsVhwxuepJXXZEhPMm8DP95U+pms8m9VgJRThU/gfm5cFaKpi/tQZSy?=
 =?us-ascii?Q?6c4DjzYlCIKiF1XOK4aQllLqiEoY8o863m2+JLvNglFR4GmqS+vpVpnIX+Z0?=
 =?us-ascii?Q?5i987hoQ/qUqMXbGNLAVC3hj/u1TmK6lcX24TqImVSN3nv4/y4QXfiZhy1jz?=
 =?us-ascii?Q?31Jsl1nbwBJmRfhon2fTq4RbGd5+Pp8jrjy8O1Ve6PnDINxEGpNUZzxOo8RG?=
 =?us-ascii?Q?81jOxhCoo+eVThyrKaCZNIyKnaBipYop9EMNXTfslBei4v+sz5WRWHWbBnrB?=
 =?us-ascii?Q?3AsDAdMSdHoF4eKw3ADmmOZVp94CBKsvRVNGxaEMdnzzQ6eD3EMnVkp6HfyX?=
 =?us-ascii?Q?3ziV6xJhxYc+bSRA7F3Zg90Bs4C+ZwDJvKImMf3dzlxdkRWPegJS6Ijpvspe?=
 =?us-ascii?Q?S/QTHYe79c83Uph+hNEsQ6muIIeI0nPj88wSKYmlJ7HYoDoCI4X7U/HlHBAy?=
 =?us-ascii?Q?5iSiXUZBi3kF5Z8eo/BlkAKm5For9mXwje37E5cA+Ceryw2/GmMb50JEhTEE?=
 =?us-ascii?Q?FGw5O2+PKV0E48/B7ayJhMjreM5QyX4kNUZX+qATdtXCaAnipp/sp290A3Ae?=
 =?us-ascii?Q?AkKCcCHvtWbC4sDxUQbgie9iQoIPnQC8XkdueQdZUnqJwpA/N9QCU6Mh928l?=
 =?us-ascii?Q?YliV9Qzn30J/L38NYPfRsyJXQDGpjAcdHj2uYBdPpBahfYmJSKEWBTbqEPQK?=
 =?us-ascii?Q?ENRVcW+uW+uN4oOGdjFdiOOgfuTapcRSAyVN3EcjB6KWsD2kTGwlu+DrkAWc?=
 =?us-ascii?Q?M/OXZwA55yeFuHOSDhheceeIyWj4SKR8t0HKVt2SpWrQl0VJNw3SEnSTdSzL?=
 =?us-ascii?Q?HOtOFmG9KRDn4VuNt4u3O1VzMpkoGdgC31w4bKszOFfJYCOGMTSiAGHabC8S?=
 =?us-ascii?Q?MkszbV/zMxRX8oF/lkzTu9vmE27XkQ9iND+4dLIERH+C94z0av9xOLYhnagJ?=
 =?us-ascii?Q?theN+PKw5VX2V8VcvXqkxbna0teylfo1dgGkfdgdOFpqq4sG7wIOU+7Z8crr?=
 =?us-ascii?Q?W/wdtwneEJgSiDN+54d0ezdfTd70wEZavBQCPp7ALR3uNh4e0u+hQuP58Rk4?=
 =?us-ascii?Q?yei1TdXMR2UPkAVG6uOBqF1T7LYM2ZypFknlbF87qa2aVDv/bvR6PmejPDs2?=
 =?us-ascii?Q?+epHJ1AbJ/UazAOO+9Y6t7QsQVDiq3pjZeNh6gH+YXwJvOPfDDXt6eho9dcb?=
 =?us-ascii?Q?qSO17k51jFthldc7FxpPhm0aPkqwS0kJ6Xd16yWzXXrcTsRETIDL6wVBIIi9?=
 =?us-ascii?Q?NKY5nDYKxOqzMjqkIw+2XIdp5Zj239KlmDLS475bY0saQkkfPNZd33u4um6B?=
 =?us-ascii?Q?SDjtAo6/XemC192DuRPPDpZurnBQJGIX?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(10070799003)(376014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?6iLmFx4FiKHvJrriTaXc98Nj3RuvN+y8wNex/nOw5l8GKN5tqntziM1BzCiI?=
 =?us-ascii?Q?QEA/IbDTy/MvCVuqohw578XWebqnNwPJehlVTFAL3iVY0Ko+CPZKXpJKVusO?=
 =?us-ascii?Q?hAD6xJTB3QRzpNBBup40CNWv6iOVxghQD8WqVaOqu8C+dqjdgPB2c29LbMpR?=
 =?us-ascii?Q?2UEWa7YgcTwxGQQcyeMEsaBoS5PGc4sQseRAPFOvEIVM3X5Y0WLLo5LrlIV+?=
 =?us-ascii?Q?c09mfpuK7ksBdScQOUZh+WMpNG2LeFj+/kNUPFM/V3G+k3eTNwQdNbcHSy+l?=
 =?us-ascii?Q?3l0b5vHewejeEbftffBSsN0xlsY2SwUSU2WsqGnUmrQgslRB7MA4GTuztX2j?=
 =?us-ascii?Q?jiLqGwp3+I2wEnIlLIV2ZY2CmTi6x+el8+fgD8sFt03E8/aBO23tLLIv6vZ0?=
 =?us-ascii?Q?ttAs9dWpNKtifc9VMGIk57I4aep4ON2hBz0HIhQ6WbOdVy1bH2cS4PnDd5I5?=
 =?us-ascii?Q?x/X7rlxUShdXLdMQIzR3GWNcdUL7bJhijiAaqXAdQ83jaTTxVl6teAjrjDMJ?=
 =?us-ascii?Q?59Jnuco3DKOH6JN2yN+YCXzWrvm/0vvx+zuJehzACN+dkqU+8oCQ0/xNd/Cq?=
 =?us-ascii?Q?pwAW7EMwme0jUBCCPKXvf+VMUrq3GV/6pr3EqC/vQegFfBYvAyjMXr1gb4lZ?=
 =?us-ascii?Q?46/HH5l/0CzK7ehjPufllE9wqKqJjvVo7pGMK3z0dJivNQuaa8JjzTcUwYTl?=
 =?us-ascii?Q?h3M1YJfFgdyMmVnyG2EKP/QJcuZ4RWECAokfk59oAzt+01vWvodevOXvPQf9?=
 =?us-ascii?Q?JNHb4ahk89vmgLPU/zZmDN0dFqyYsCB8Yq0u2zD3tOL6g7zXipTmAZ04pEtj?=
 =?us-ascii?Q?THkEUQ/69F+67mdtz5SEArkjacw3jplZAZzsfx8ZnzajQQbVwudBV98BUnJD?=
 =?us-ascii?Q?77J/CsMlKh+5J1SIb02ZRiZsJA4v8/c3o3DaGk7h6LJb+EOoAsBWiDJyRQCE?=
 =?us-ascii?Q?woB+if79YRZRIQN82KfLqD/opivQKEij6iuKL3VMTlIYV/u1TSOoZr127/Xd?=
 =?us-ascii?Q?ext2jRNPa7nkamfaKcmQDRKnOfF+1vsTcs4Z9Cknnj4bj+UzfAOXlZ5fYaxq?=
 =?us-ascii?Q?BMapDKju+8y4ty2hRx6vN0XcUmjbELulgo4Py+s9vPUvSpn4mmBP/y3kqs9O?=
 =?us-ascii?Q?oc/30486jYI4Ro+iLKOX8cnLeYxaruEECf/y/bvAVl9luNqTFfFoE4yhVJMR?=
 =?us-ascii?Q?TQRdH7glIhOAJEA66a5QSg5wbJgTuSt4R6ykZkP4t7R7RW3r+IuOnv1E6Ri9?=
 =?us-ascii?Q?SL7JBmYZ8NLOA19bHQt6atbk0l9oKQvxycx/NBXoXQAdNhpCrWLyw9nFaB3F?=
 =?us-ascii?Q?AVfHLxikdxZNHzhq9LJ2CmMe1b8STKSj9THzUm7FOQYI3gamd0ZfSn6DQlcr?=
 =?us-ascii?Q?KtM2ICrY/M+SwVxxPo5wipHx+50EDK4UrwXDGYHgyfuYeUSK7xoNfvsp1XEj?=
 =?us-ascii?Q?ZXUkmLm0czLWbIirA7NstSSxBOO2CVW6Z5oXtPM1zjjIZw1NJFbLRh19sOiy?=
 =?us-ascii?Q?nAs4hgOc2TTjAHZG43cX8bWKk9M5RNYUktpdvjXXN6XTzqbZlTkjgLg4Sdd3?=
 =?us-ascii?Q?pgXgnOsvTjBfPxrdnC8yVDQhlLwA48kbyT2ZShgJAVpmbxDLQHAYAVwm1/Ut?=
 =?us-ascii?Q?9tkcmR8kgvjkh0e1ULf3wZgW6Y7w+oDdr9AkWY1VVbcqxM1UkKERRs3OsupC?=
 =?us-ascii?Q?6pH9QsvJ5konUDDYYwf89WHoBqqEP/ekjpfQNSpafaAphozmbJmxf8Q2ULVP?=
 =?us-ascii?Q?Umdkykw0hAr46ez0do2uS6mg91MlxXA3rP0N77tloBahoNZYiVH6?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: ee1c2002-6195-4ad4-3457-08de4dfe3db8
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jan 2026 15:05:48.6387
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kNJ+jw5amWcsrjzCDoSxP0hBX+4cBJjfH/VmfWDNt8z5hDLzq5zzML/PNtPaXMHKlac/GyBebFbbju24sUuzcw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYWP286MB2618

On Tue, Jan 06, 2026 at 11:46:23AM -0700, Dave Jiang wrote:
> 
> 
> On 12/20/25 8:28 AM, Koichiro Den wrote:
> > On Fri, Dec 19, 2025 at 10:00:52AM -0500, Frank Li wrote:
> >> On Thu, Dec 18, 2025 at 12:16:00AM +0900, Koichiro Den wrote:
> >>> Add a new ntb_transport backend that uses a DesignWare eDMA engine
> >>> located on the endpoint, to be driven by both host and endpoint.
> >>>
> >>> The endpoint exposes a dedicated memory window which contains the eDMA
> >>> register block, a small control structure (struct ntb_edma_info) and
> >>> per-channel linked-list (LL) rings for read channels. Endpoint drives
> >>> its local eDMA write channels for its transmission, while host side
> >>> uses the remote eDMA read channels for its transmission.
> >>
> >> I just glace the code. Look likes you use standard DMA API and
> >> per-channel linked-list (LL) ring, which can be pure software.
> >>
> >> So it is not nessasry to binding to Designware EDMA. Maybe other vendor
> >> PCIe's build DMA can work with this code?
> > 
> > Yes, the DesignWare-specific parts are encapsulated under
> > drivers/ntb/hw/edma/, so the ntb_transport_edma itself is not tightly
> > coupled to DesignWare eDMA. In other words, if it's not the case and
> > something remains, that's just my mistake.
> > 
> > I intentionally avoided introducing an extra abstraction layer prematurely.
> > If we later want to support other vendors' PCIe built-in DMA engines for
> > edma_backend_ops, an additional internal abstraction under the
> > 'edma_backend_ops' implementation can be introduced at that point.
> > Do you think I should do so now?
> 
> I agree with Frank. Make it generic to allow future other vendors to utilize since this is the generic transport part.

Thank you for your feedback.
So I plan to introduce an additional internal abstraction 'ntb_edma_backend'.
ntb_transport_edma selects one specific ntb_edma_backend implementation.
For now, dw-edma (drivers/ntb/hw/edma/ntb_dw_edma.c) is the only choise,
but some drivers/ntb/hw/edma/ntb_xyz.c might show up in the future.

Regards,
Koichiro

> 
> DJ
> 
> > 
> > Koichiro
> > 
> >>
> >> Frank
> >>>
> >>> A key benefit of this backend is that the memory window no longer needs
> >>> to carry data-plane payload. This makes the design less sensitive to
> >>> limited memory window space and allows scaling to multiple queue pairs.
> >>> The memory window layout is specific to the eDMA-backed backend, so
> >>> there is no automatic fallback to the memcpy-based default transport
> >>> that requires the different layout.
> >>>
> >>> Signed-off-by: Koichiro Den <den@valinux.co.jp>
> >>> ---
> >>>  drivers/ntb/Kconfig                  |  12 +
> >>>  drivers/ntb/Makefile                 |   2 +
> >>>  drivers/ntb/ntb_transport_core.c     |  15 +-
> >>>  drivers/ntb/ntb_transport_edma.c     | 987 +++++++++++++++++++++++++++
> >>>  drivers/ntb/ntb_transport_internal.h |  15 +
> >>>  5 files changed, 1029 insertions(+), 2 deletions(-)
> >>>  create mode 100644 drivers/ntb/ntb_transport_edma.c
> >>>
> >>> diff --git a/drivers/ntb/Kconfig b/drivers/ntb/Kconfig
> >>> index df16c755b4da..5ba6d0b7f5ba 100644
> >>> --- a/drivers/ntb/Kconfig
> >>> +++ b/drivers/ntb/Kconfig
> >>> @@ -37,4 +37,16 @@ config NTB_TRANSPORT
> >>>
> >>>  	 If unsure, say N.
> >>>
> >>> +config NTB_TRANSPORT_EDMA
> >>> +	bool "NTB Transport backed by remote eDMA"
> >>> +	depends on NTB_TRANSPORT
> >>> +	depends on PCI
> >>> +	select DMA_ENGINE
> >>> +	select NTB_EDMA
> >>> +	help
> >>> +	  Enable a transport backend that uses a remote DesignWare eDMA engine
> >>> +	  exposed through a dedicated NTB memory window. The host uses the
> >>> +	  endpoint's eDMA engine to move data in both directions.
> >>> +	  Say Y here if you intend to use the 'use_remote_edma' module parameter.
> >>> +
> >>>  endif # NTB
> >>> diff --git a/drivers/ntb/Makefile b/drivers/ntb/Makefile
> >>> index 9b66e5fafbc0..b9086b32ecde 100644
> >>> --- a/drivers/ntb/Makefile
> >>> +++ b/drivers/ntb/Makefile
> >>> @@ -6,3 +6,5 @@ ntb-y			:= core.o
> >>>  ntb-$(CONFIG_NTB_MSI)	+= msi.o
> >>>
> >>>  ntb_transport-y		:= ntb_transport_core.o
> >>> +ntb_transport-$(CONFIG_NTB_TRANSPORT_EDMA)	+= ntb_transport_edma.o
> >>> +ntb_transport-$(CONFIG_NTB_TRANSPORT_EDMA)	+= hw/edma/ntb_hw_edma.o
> >>> diff --git a/drivers/ntb/ntb_transport_core.c b/drivers/ntb/ntb_transport_core.c
> >>> index 40c2548f5930..bd21232f26fe 100644
> >>> --- a/drivers/ntb/ntb_transport_core.c
> >>> +++ b/drivers/ntb/ntb_transport_core.c
> >>> @@ -104,6 +104,12 @@ module_param(use_msi, bool, 0644);
> >>>  MODULE_PARM_DESC(use_msi, "Use MSI interrupts instead of doorbells");
> >>>  #endif
> >>>
> >>> +bool use_remote_edma;
> >>> +#ifdef CONFIG_NTB_TRANSPORT_EDMA
> >>> +module_param(use_remote_edma, bool, 0644);
> >>> +MODULE_PARM_DESC(use_remote_edma, "Use remote eDMA mode (when enabled, use_msi is ignored)");
> >>> +#endif
> >>> +
> >>>  static struct dentry *nt_debugfs_dir;
> >>>
> >>>  /* Only two-ports NTB devices are supported */
> >>> @@ -156,7 +162,7 @@ enum {
> >>>  #define drv_client(__drv) \
> >>>  	container_of((__drv), struct ntb_transport_client, driver)
> >>>
> >>> -#define NTB_QP_DEF_NUM_ENTRIES	100
> >>> +#define NTB_QP_DEF_NUM_ENTRIES	128
> >>>  #define NTB_LINK_DOWN_TIMEOUT	10
> >>>
> >>>  static void ntb_transport_rxc_db(unsigned long data);
> >>> @@ -1189,7 +1195,11 @@ static int ntb_transport_probe(struct ntb_client *self, struct ntb_dev *ndev)
> >>>
> >>>  	nt->ndev = ndev;
> >>>
> >>> -	rc = ntb_transport_default_init(nt);
> >>> +	if (use_remote_edma)
> >>> +		rc = ntb_transport_edma_init(nt);
> >>> +	else
> >>> +		rc = ntb_transport_default_init(nt);
> >>> +
> >>>  	if (rc)
> >>>  		return rc;
> >>>
> >>> @@ -1950,6 +1960,7 @@ ntb_transport_create_queue(void *data, struct device *client_dev,
> >>>
> >>>  	nt->qp_bitmap_free &= ~qp_bit;
> >>>
> >>> +	qp->qp_bit = qp_bit;
> >>>  	qp->cb_data = data;
> >>>  	qp->rx_handler = handlers->rx_handler;
> >>>  	qp->tx_handler = handlers->tx_handler;
> >>> diff --git a/drivers/ntb/ntb_transport_edma.c b/drivers/ntb/ntb_transport_edma.c
> >>> new file mode 100644
> >>> index 000000000000..6ae5da0a1367
> >>> --- /dev/null
> >>> +++ b/drivers/ntb/ntb_transport_edma.c
> >>> @@ -0,0 +1,987 @@
> >>> +// SPDX-License-Identifier: GPL-2.0-only
> >>> +/*
> >>> + * NTB transport backend for remote DesignWare eDMA.
> >>> + *
> >>> + * This implements the backend_ops used when use_remote_edma=1 and
> >>> + * relies on drivers/ntb/hw/edma/ for low-level eDMA/MW programming.
> >>> + */
> >>> +
> >>> +#include <linux/bug.h>
> >>> +#include <linux/compiler.h>
> >>> +#include <linux/debugfs.h>
> >>> +#include <linux/dmaengine.h>
> >>> +#include <linux/dma-mapping.h>
> >>> +#include <linux/errno.h>
> >>> +#include <linux/io-64-nonatomic-lo-hi.h>
> >>> +#include <linux/ntb.h>
> >>> +#include <linux/pci.h>
> >>> +#include <linux/pci-epc.h>
> >>> +#include <linux/seq_file.h>
> >>> +#include <linux/slab.h>
> >>> +
> >>> +#include "hw/edma/ntb_hw_edma.h"
> >>> +#include "ntb_transport_internal.h"
> >>> +
> >>> +#define NTB_EDMA_RING_ORDER	7
> >>> +#define NTB_EDMA_RING_ENTRIES	(1U << NTB_EDMA_RING_ORDER)
> >>> +#define NTB_EDMA_RING_MASK	(NTB_EDMA_RING_ENTRIES - 1)
> >>> +
> >>> +#define NTB_EDMA_MAX_POLL	32
> >>> +
> >>> +/*
> >>> + * Remote eDMA mode implementation
> >>> + */
> >>> +struct ntb_transport_ctx_edma {
> >>> +	remote_edma_mode_t remote_edma_mode;
> >>> +	struct device *dma_dev;
> >>> +	struct workqueue_struct *wq;
> >>> +	struct ntb_edma_chans chans;
> >>> +};
> >>> +
> >>> +struct ntb_transport_qp_edma {
> >>> +	struct ntb_transport_qp *qp;
> >>> +
> >>> +	/*
> >>> +	 * For ensuring peer notification in non-atomic context.
> >>> +	 * ntb_peer_db_set might sleep or schedule.
> >>> +	 */
> >>> +	struct work_struct db_work;
> >>> +
> >>> +	u32 rx_prod;
> >>> +	u32 rx_cons;
> >>> +	u32 tx_cons;
> >>> +	u32 tx_issue;
> >>> +
> >>> +	spinlock_t rx_lock;
> >>> +	spinlock_t tx_lock;
> >>> +
> >>> +	struct work_struct rx_work;
> >>> +	struct work_struct tx_work;
> >>> +};
> >>> +
> >>> +struct ntb_edma_desc {
> >>> +	u32 len;
> >>> +	u32 flags;
> >>> +	u64 addr; /* DMA address */
> >>> +	u64 data;
> >>> +};
> >>> +
> >>> +struct ntb_edma_ring {
> >>> +	struct ntb_edma_desc desc[NTB_EDMA_RING_ENTRIES];
> >>> +	u32 head;
> >>> +	u32 tail;
> >>> +};
> >>> +
> >>> +static inline bool ntb_qp_edma_is_rc(struct ntb_transport_qp *qp)
> >>> +{
> >>> +	struct ntb_transport_ctx_edma *ctx = qp->transport->priv;
> >>> +
> >>> +	return ctx->remote_edma_mode == REMOTE_EDMA_RC;
> >>> +}
> >>> +
> >>> +static inline bool ntb_qp_edma_is_ep(struct ntb_transport_qp *qp)
> >>> +{
> >>> +	struct ntb_transport_ctx_edma *ctx = qp->transport->priv;
> >>> +
> >>> +	return ctx->remote_edma_mode == REMOTE_EDMA_EP;
> >>> +}
> >>> +
> >>> +static inline bool ntb_qp_edma_enabled(struct ntb_transport_qp *qp)
> >>> +{
> >>> +	return ntb_qp_edma_is_rc(qp) || ntb_qp_edma_is_ep(qp);
> >>> +}
> >>> +
> >>> +static inline unsigned int ntb_edma_ring_sel(struct ntb_transport_qp *qp,
> >>> +					     unsigned int n)
> >>> +{
> >>> +	return n ^ !!ntb_qp_edma_is_ep(qp);
> >>> +}
> >>> +
> >>> +static inline struct ntb_edma_ring *
> >>> +ntb_edma_ring_local(struct ntb_transport_qp *qp, unsigned int n)
> >>> +{
> >>> +	unsigned int r = ntb_edma_ring_sel(qp, n);
> >>> +
> >>> +	return &((struct ntb_edma_ring *)qp->rx_buff)[r];
> >>> +}
> >>> +
> >>> +static inline struct ntb_edma_ring __iomem *
> >>> +ntb_edma_ring_remote(struct ntb_transport_qp *qp, unsigned int n)
> >>> +{
> >>> +	unsigned int r = ntb_edma_ring_sel(qp, n);
> >>> +
> >>> +	return &((struct ntb_edma_ring __iomem *)qp->tx_mw)[r];
> >>> +}
> >>> +
> >>> +static inline struct ntb_edma_desc *
> >>> +ntb_edma_desc_local(struct ntb_transport_qp *qp, unsigned int n, unsigned int i)
> >>> +{
> >>> +	return &ntb_edma_ring_local(qp, n)->desc[i];
> >>> +}
> >>> +
> >>> +static inline struct ntb_edma_desc __iomem *
> >>> +ntb_edma_desc_remote(struct ntb_transport_qp *qp, unsigned int n,
> >>> +		     unsigned int i)
> >>> +{
> >>> +	return &ntb_edma_ring_remote(qp, n)->desc[i];
> >>> +}
> >>> +
> >>> +static inline u32 *ntb_edma_head_local(struct ntb_transport_qp *qp,
> >>> +				       unsigned int n)
> >>> +{
> >>> +	return &ntb_edma_ring_local(qp, n)->head;
> >>> +}
> >>> +
> >>> +static inline u32 __iomem *ntb_edma_head_remote(struct ntb_transport_qp *qp,
> >>> +						unsigned int n)
> >>> +{
> >>> +	return &ntb_edma_ring_remote(qp, n)->head;
> >>> +}
> >>> +
> >>> +static inline u32 *ntb_edma_tail_local(struct ntb_transport_qp *qp,
> >>> +				       unsigned int n)
> >>> +{
> >>> +	return &ntb_edma_ring_local(qp, n)->tail;
> >>> +}
> >>> +
> >>> +static inline u32 __iomem *ntb_edma_tail_remote(struct ntb_transport_qp *qp,
> >>> +						unsigned int n)
> >>> +{
> >>> +	return &ntb_edma_ring_remote(qp, n)->tail;
> >>> +}
> >>> +
> >>> +/* The 'i' must be generated by ntb_edma_ring_idx() */
> >>> +#define NTB_DESC_TX_O(qp, i)	ntb_edma_desc_remote(qp, 0, i)
> >>> +#define NTB_DESC_TX_I(qp, i)	ntb_edma_desc_local(qp, 0, i)
> >>> +#define NTB_DESC_RX_O(qp, i)	ntb_edma_desc_remote(qp, 1, i)
> >>> +#define NTB_DESC_RX_I(qp, i)	ntb_edma_desc_local(qp, 1, i)
> >>> +
> >>> +#define NTB_HEAD_TX_I(qp)	ntb_edma_head_local(qp, 0)
> >>> +#define NTB_HEAD_RX_O(qp)	ntb_edma_head_remote(qp, 1)
> >>> +
> >>> +#define NTB_TAIL_TX_O(qp)	ntb_edma_tail_remote(qp, 0)
> >>> +#define NTB_TAIL_RX_I(qp)	ntb_edma_tail_local(qp, 1)
> >>> +
> >>> +/* ntb_edma_ring helpers */
> >>> +static __always_inline u32 ntb_edma_ring_idx(u32 v)
> >>> +{
> >>> +	return v & NTB_EDMA_RING_MASK;
> >>> +}
> >>> +
> >>> +static __always_inline u32 ntb_edma_ring_used_entry(u32 head, u32 tail)
> >>> +{
> >>> +	if (head >= tail) {
> >>> +		WARN_ON_ONCE((head - tail) > (NTB_EDMA_RING_ENTRIES - 1));
> >>> +		return head - tail;
> >>> +	}
> >>> +
> >>> +	WARN_ON_ONCE((U32_MAX - tail + head + 1) > (NTB_EDMA_RING_ENTRIES - 1));
> >>> +	return U32_MAX - tail + head + 1;
> >>> +}
> >>> +
> >>> +static __always_inline u32 ntb_edma_ring_free_entry(u32 head, u32 tail)
> >>> +{
> >>> +	return NTB_EDMA_RING_ENTRIES - ntb_edma_ring_used_entry(head, tail) - 1;
> >>> +}
> >>> +
> >>> +static __always_inline bool ntb_edma_ring_full(u32 head, u32 tail)
> >>> +{
> >>> +	return ntb_edma_ring_free_entry(head, tail) == 0;
> >>> +}
> >>> +
> >>> +static unsigned int ntb_transport_edma_tx_free_entry(struct ntb_transport_qp *qp)
> >>> +{
> >>> +	struct ntb_transport_qp_edma *edma = qp->priv;
> >>> +	unsigned int head, tail;
> >>> +
> >>> +	scoped_guard(spinlock_irqsave, &edma->tx_lock) {
> >>> +		/* In this scope, only 'head' might proceed */
> >>> +		tail = READ_ONCE(edma->tx_issue);
> >>> +		head = READ_ONCE(*NTB_HEAD_TX_I(qp));
> >>> +	}
> >>> +	/*
> >>> +	 * 'used' amount indicates how much the other end has refilled,
> >>> +	 * which are available for us to use for TX.
> >>> +	 */
> >>> +	return ntb_edma_ring_used_entry(head, tail);
> >>> +}
> >>> +
> >>> +static void ntb_transport_edma_debugfs_stats_show(struct seq_file *s,
> >>> +						  struct ntb_transport_qp *qp)
> >>> +{
> >>> +	seq_printf(s, "rx_bytes - \t%llu\n", qp->rx_bytes);
> >>> +	seq_printf(s, "rx_pkts - \t%llu\n", qp->rx_pkts);
> >>> +	seq_printf(s, "rx_err_no_buf - %llu\n", qp->rx_err_no_buf);
> >>> +	seq_printf(s, "rx_buff - \t0x%p\n", qp->rx_buff);
> >>> +	seq_printf(s, "rx_max_entry - \t%u\n", qp->rx_max_entry);
> >>> +	seq_printf(s, "rx_alloc_entry - \t%u\n\n", qp->rx_alloc_entry);
> >>> +
> >>> +	seq_printf(s, "tx_bytes - \t%llu\n", qp->tx_bytes);
> >>> +	seq_printf(s, "tx_pkts - \t%llu\n", qp->tx_pkts);
> >>> +	seq_printf(s, "tx_ring_full - \t%llu\n", qp->tx_ring_full);
> >>> +	seq_printf(s, "tx_err_no_buf - %llu\n", qp->tx_err_no_buf);
> >>> +	seq_printf(s, "tx_mw - \t0x%p\n", qp->tx_mw);
> >>> +	seq_printf(s, "tx_max_entry - \t%u\n", qp->tx_max_entry);
> >>> +	seq_printf(s, "free tx - \t%u\n", ntb_transport_tx_free_entry(qp));
> >>> +	seq_putc(s, '\n');
> >>> +
> >>> +	seq_puts(s, "Using Remote eDMA - Yes\n");
> >>> +	seq_printf(s, "QP Link - \t%s\n", qp->link_is_up ? "Up" : "Down");
> >>> +}
> >>> +
> >>> +static void ntb_transport_edma_uninit(struct ntb_transport_ctx *nt)
> >>> +{
> >>> +	struct ntb_transport_ctx_edma *ctx = nt->priv;
> >>> +
> >>> +	if (ctx->wq)
> >>> +		destroy_workqueue(ctx->wq);
> >>> +	ctx->wq = NULL;
> >>> +
> >>> +	ntb_edma_teardown_chans(&ctx->chans);
> >>> +
> >>> +	switch (ctx->remote_edma_mode) {
> >>> +	case REMOTE_EDMA_EP:
> >>> +		ntb_edma_teardown_mws(nt->ndev);
> >>> +		break;
> >>> +	case REMOTE_EDMA_RC:
> >>> +		ntb_edma_teardown_peer(nt->ndev);
> >>> +		break;
> >>> +	case REMOTE_EDMA_UNKNOWN:
> >>> +	default:
> >>> +		break;
> >>> +	}
> >>> +
> >>> +	ctx->remote_edma_mode = REMOTE_EDMA_UNKNOWN;
> >>> +}
> >>> +
> >>> +static void ntb_transport_edma_db_work(struct work_struct *work)
> >>> +{
> >>> +	struct ntb_transport_qp_edma *edma =
> >>> +			container_of(work, struct ntb_transport_qp_edma, db_work);
> >>> +	struct ntb_transport_qp *qp = edma->qp;
> >>> +
> >>> +	ntb_peer_db_set(qp->ndev, qp->qp_bit);
> >>> +}
> >>> +
> >>> +static void ntb_transport_edma_notify_peer(struct ntb_transport_qp_edma *edma)
> >>> +{
> >>> +	struct ntb_transport_qp *qp = edma->qp;
> >>> +	struct ntb_transport_ctx_edma *ctx = qp->transport->priv;
> >>> +
> >>> +	if (!ntb_edma_notify_peer(&ctx->chans, qp->qp_num))
> >>> +		return;
> >>> +
> >>> +	/*
> >>> +	 * Called from contexts that may be atomic. Since ntb_peer_db_set()
> >>> +	 * may sleep, delegate the actual doorbell write to a workqueue.
> >>> +	 */
> >>> +	queue_work(system_highpri_wq, &edma->db_work);
> >>> +}
> >>> +
> >>> +static void ntb_transport_edma_isr(void *data, int qp_num)
> >>> +{
> >>> +	struct ntb_transport_ctx *nt = data;
> >>> +	struct ntb_transport_qp_edma *edma;
> >>> +	struct ntb_transport_ctx_edma *ctx;
> >>> +	struct ntb_transport_qp *qp;
> >>> +
> >>> +	if (qp_num < 0 || qp_num >= nt->qp_count)
> >>> +		return;
> >>> +
> >>> +	qp = &nt->qp_vec[qp_num];
> >>> +	if (WARN_ON(!qp))
> >>> +		return;
> >>> +
> >>> +	ctx = (struct ntb_transport_ctx_edma *)qp->transport->priv;
> >>> +	edma = qp->priv;
> >>> +
> >>> +	queue_work(ctx->wq, &edma->rx_work);
> >>> +	queue_work(ctx->wq, &edma->tx_work);
> >>> +}
> >>> +
> >>> +static int ntb_transport_edma_rc_init(struct ntb_transport_ctx *nt)
> >>> +{
> >>> +	struct ntb_transport_ctx_edma *ctx = nt->priv;
> >>> +	struct ntb_dev *ndev = nt->ndev;
> >>> +	struct pci_dev *pdev = ndev->pdev;
> >>> +	int peer_mw;
> >>> +	int rc;
> >>> +
> >>> +	if (!use_remote_edma || ctx->remote_edma_mode != REMOTE_EDMA_UNKNOWN)
> >>> +		return 0;
> >>> +
> >>> +	peer_mw = ntb_peer_mw_count(ndev);
> >>> +	if (peer_mw <= 0)
> >>> +		return -ENODEV;
> >>> +
> >>> +	rc = ntb_edma_setup_peer(ndev, peer_mw - 1, nt->qp_count);
> >>> +	if (rc) {
> >>> +		dev_err(&pdev->dev, "Failed to enable remote eDMA: %d\n", rc);
> >>> +		return rc;
> >>> +	}
> >>> +
> >>> +	rc = ntb_edma_setup_chans(get_dma_dev(ndev), &ctx->chans, true);
> >>> +	if (rc) {
> >>> +		dev_err(&pdev->dev, "Failed to setup eDMA channels: %d\n", rc);
> >>> +		goto err_teardown_peer;
> >>> +	}
> >>> +
> >>> +	rc = ntb_edma_setup_intr_chan(get_dma_dev(ndev), &ctx->chans);
> >>> +	if (rc) {
> >>> +		dev_err(&pdev->dev, "Failed to setup eDMA notify channel: %d\n",
> >>> +			rc);
> >>> +		goto err_teardown_chans;
> >>> +	}
> >>> +
> >>> +	ctx->remote_edma_mode = REMOTE_EDMA_RC;
> >>> +	return 0;
> >>> +
> >>> +err_teardown_chans:
> >>> +	ntb_edma_teardown_chans(&ctx->chans);
> >>> +err_teardown_peer:
> >>> +	ntb_edma_teardown_peer(ndev);
> >>> +	return rc;
> >>> +}
> >>> +
> >>> +
> >>> +static int ntb_transport_edma_ep_init(struct ntb_transport_ctx *nt)
> >>> +{
> >>> +	struct ntb_transport_ctx_edma *ctx = nt->priv;
> >>> +	struct ntb_dev *ndev = nt->ndev;
> >>> +	struct pci_dev *pdev = ndev->pdev;
> >>> +	int peer_mw;
> >>> +	int rc;
> >>> +
> >>> +	if (!use_remote_edma || ctx->remote_edma_mode == REMOTE_EDMA_EP)
> >>> +		return 0;
> >>> +
> >>> +	/**
> >>> +	 * This check assumes that the endpoint (pci-epf-vntb.c)
> >>> +	 * ntb_dev_ops implements .get_private_data() while the host side
> >>> +	 * (ntb_hw_epf.c) does not.
> >>> +	 */
> >>> +	if (!ntb_get_private_data(ndev))
> >>> +		return 0;
> >>> +
> >>> +	peer_mw = ntb_peer_mw_count(ndev);
> >>> +	if (peer_mw <= 0)
> >>> +		return -ENODEV;
> >>> +
> >>> +	rc = ntb_edma_setup_mws(ndev, peer_mw - 1, nt->qp_count,
> >>> +				ntb_transport_edma_isr, nt);
> >>> +	if (rc) {
> >>> +		dev_err(&pdev->dev,
> >>> +			"Failed to set up memory window for eDMA: %d\n", rc);
> >>> +		return rc;
> >>> +	}
> >>> +
> >>> +	rc = ntb_edma_setup_chans(get_dma_dev(ndev), &ctx->chans, false);
> >>> +	if (rc) {
> >>> +		dev_err(&pdev->dev, "Failed to setup eDMA channels: %d\n", rc);
> >>> +		ntb_edma_teardown_mws(ndev);
> >>> +		return rc;
> >>> +	}
> >>> +
> >>> +	ctx->remote_edma_mode = REMOTE_EDMA_EP;
> >>> +	return 0;
> >>> +}
> >>> +
> >>> +
> >>> +static int ntb_transport_edma_setup_qp_mw(struct ntb_transport_ctx *nt,
> >>> +					  unsigned int qp_num)
> >>> +{
> >>> +	struct ntb_transport_qp *qp = &nt->qp_vec[qp_num];
> >>> +	struct ntb_dev *ndev = nt->ndev;
> >>> +	struct ntb_queue_entry *entry;
> >>> +	struct ntb_transport_mw *mw;
> >>> +	unsigned int mw_num, mw_count, qp_count;
> >>> +	unsigned int qp_offset, rx_info_offset;
> >>> +	unsigned int mw_size, mw_size_per_qp;
> >>> +	unsigned int num_qps_mw;
> >>> +	size_t edma_total;
> >>> +	unsigned int i;
> >>> +	int node;
> >>> +
> >>> +	mw_count = nt->mw_count;
> >>> +	qp_count = nt->qp_count;
> >>> +
> >>> +	mw_num = QP_TO_MW(nt, qp_num);
> >>> +	mw = &nt->mw_vec[mw_num];
> >>> +
> >>> +	if (!mw->virt_addr)
> >>> +		return -ENOMEM;
> >>> +
> >>> +	if (mw_num < qp_count % mw_count)
> >>> +		num_qps_mw = qp_count / mw_count + 1;
> >>> +	else
> >>> +		num_qps_mw = qp_count / mw_count;
> >>> +
> >>> +	mw_size = min(nt->mw_vec[mw_num].phys_size, mw->xlat_size);
> >>> +	if (max_mw_size && mw_size > max_mw_size)
> >>> +		mw_size = max_mw_size;
> >>> +
> >>> +	mw_size_per_qp = round_down((unsigned int)mw_size / num_qps_mw, SZ_64);
> >>> +	qp_offset = mw_size_per_qp * (qp_num / mw_count);
> >>> +	rx_info_offset = mw_size_per_qp - sizeof(struct ntb_rx_info);
> >>> +
> >>> +	qp->tx_mw_size = mw_size_per_qp;
> >>> +	qp->tx_mw = nt->mw_vec[mw_num].vbase + qp_offset;
> >>> +	if (!qp->tx_mw)
> >>> +		return -EINVAL;
> >>> +	qp->tx_mw_phys = nt->mw_vec[mw_num].phys_addr + qp_offset;
> >>> +	if (!qp->tx_mw_phys)
> >>> +		return -EINVAL;
> >>> +	qp->rx_info = qp->tx_mw + rx_info_offset;
> >>> +	qp->rx_buff = mw->virt_addr + qp_offset;
> >>> +	qp->remote_rx_info = qp->rx_buff + rx_info_offset;
> >>> +
> >>> +	/* Due to housekeeping, there must be at least 2 buffs */
> >>> +	qp->tx_max_frame = min(transport_mtu, mw_size_per_qp / 2);
> >>> +	qp->rx_max_frame = min(transport_mtu, mw_size_per_qp / 2);
> >>> +
> >>> +	/* In eDMA mode, decouple from MW sizing and force ring-sized entries */
> >>> +	edma_total = 2 * sizeof(struct ntb_edma_ring);
> >>> +	if (rx_info_offset < edma_total) {
> >>> +		dev_err(&ndev->dev, "Ring space requires %zuB (>=%uB)\n",
> >>> +			edma_total, rx_info_offset);
> >>> +		return -EINVAL;
> >>> +	}
> >>> +	qp->tx_max_entry = NTB_EDMA_RING_ENTRIES;
> >>> +	qp->rx_max_entry = NTB_EDMA_RING_ENTRIES;
> >>> +
> >>> +	/*
> >>> +	 * Checking to see if we have more entries than the default.
> >>> +	 * We should add additional entries if that is the case so we
> >>> +	 * can be in sync with the transport frames.
> >>> +	 */
> >>> +	node = dev_to_node(&ndev->dev);
> >>> +	for (i = qp->rx_alloc_entry; i < qp->rx_max_entry; i++) {
> >>> +		entry = kzalloc_node(sizeof(*entry), GFP_KERNEL, node);
> >>> +		if (!entry)
> >>> +			return -ENOMEM;
> >>> +
> >>> +		entry->qp = qp;
> >>> +		ntb_list_add(&qp->ntb_rx_q_lock, &entry->entry,
> >>> +			     &qp->rx_free_q);
> >>> +		qp->rx_alloc_entry++;
> >>> +	}
> >>> +
> >>> +	memset(qp->rx_buff, 0, edma_total);
> >>> +
> >>> +	qp->rx_pkts = 0;
> >>> +	qp->tx_pkts = 0;
> >>> +
> >>> +	return 0;
> >>> +}
> >>> +
> >>> +static int ntb_transport_edma_rx_complete(struct ntb_transport_qp *qp)
> >>> +{
> >>> +	struct device *dma_dev = get_dma_dev(qp->ndev);
> >>> +	struct ntb_transport_qp_edma *edma = qp->priv;
> >>> +	struct ntb_queue_entry *entry;
> >>> +	struct ntb_edma_desc *in;
> >>> +	unsigned int len;
> >>> +	bool link_down;
> >>> +	u32 idx;
> >>> +
> >>> +	if (ntb_edma_ring_used_entry(READ_ONCE(*NTB_TAIL_RX_I(qp)),
> >>> +				     edma->rx_cons) == 0)
> >>> +		return 0;
> >>> +
> >>> +	idx = ntb_edma_ring_idx(edma->rx_cons);
> >>> +	in = NTB_DESC_RX_I(qp, idx);
> >>> +	if (!(in->flags & DESC_DONE_FLAG))
> >>> +		return 0;
> >>> +
> >>> +	link_down = in->flags & LINK_DOWN_FLAG;
> >>> +	in->flags = 0;
> >>> +	len = in->len; /* might be smaller than entry->len */
> >>> +
> >>> +	entry = (struct ntb_queue_entry *)(uintptr_t)in->data;
> >>> +	if (WARN_ON(!entry))
> >>> +		return 0;
> >>> +
> >>> +	if (link_down) {
> >>> +		ntb_qp_link_down(qp);
> >>> +		edma->rx_cons++;
> >>> +		ntb_list_add(&qp->ntb_rx_q_lock, &entry->entry, &qp->rx_free_q);
> >>> +		return 1;
> >>> +	}
> >>> +
> >>> +	dma_unmap_single(dma_dev, entry->addr, entry->len, DMA_FROM_DEVICE);
> >>> +
> >>> +	qp->rx_bytes += len;
> >>> +	qp->rx_pkts++;
> >>> +	edma->rx_cons++;
> >>> +
> >>> +	if (qp->rx_handler && qp->client_ready)
> >>> +		qp->rx_handler(qp, qp->cb_data, entry->cb_data, len);
> >>> +
> >>> +	ntb_list_add(&qp->ntb_rx_q_lock, &entry->entry, &qp->rx_free_q);
> >>> +	return 1;
> >>> +}
> >>> +
> >>> +static void ntb_transport_edma_rx_work(struct work_struct *work)
> >>> +{
> >>> +	struct ntb_transport_qp_edma *edma = container_of(
> >>> +				work, struct ntb_transport_qp_edma, rx_work);
> >>> +	struct ntb_transport_qp *qp = edma->qp;
> >>> +	struct ntb_transport_ctx_edma *ctx = qp->transport->priv;
> >>> +	unsigned int i;
> >>> +
> >>> +	for (i = 0; i < NTB_EDMA_MAX_POLL; i++) {
> >>> +		if (!ntb_transport_edma_rx_complete(qp))
> >>> +			break;
> >>> +	}
> >>> +
> >>> +	if (ntb_transport_edma_rx_complete(qp))
> >>> +		queue_work(ctx->wq, &edma->rx_work);
> >>> +}
> >>> +
> >>> +static void ntb_transport_edma_tx_work(struct work_struct *work)
> >>> +{
> >>> +	struct ntb_transport_qp_edma *edma = container_of(
> >>> +				work, struct ntb_transport_qp_edma, tx_work);
> >>> +	struct ntb_transport_qp *qp = edma->qp;
> >>> +	struct ntb_edma_desc *in, __iomem *out;
> >>> +	struct ntb_queue_entry *entry;
> >>> +	unsigned int len;
> >>> +	void *cb_data;
> >>> +	u32 idx;
> >>> +
> >>> +	while (ntb_edma_ring_used_entry(READ_ONCE(edma->tx_issue),
> >>> +					edma->tx_cons) != 0) {
> >>> +		/* Paired with smp_wmb() in ntb_transport_edma_tx_enqueue_inner() */
> >>> +		smp_rmb();
> >>> +
> >>> +		idx = ntb_edma_ring_idx(edma->tx_cons);
> >>> +		in = NTB_DESC_TX_I(qp, idx);
> >>> +		entry = (struct ntb_queue_entry *)(uintptr_t)in->data;
> >>> +		if (!entry || !(entry->flags & DESC_DONE_FLAG))
> >>> +			break;
> >>> +
> >>> +		in->data = 0;
> >>> +
> >>> +		cb_data = entry->cb_data;
> >>> +		len = entry->len;
> >>> +
> >>> +		out = NTB_DESC_TX_O(qp, idx);
> >>> +
> >>> +		WRITE_ONCE(edma->tx_cons, edma->tx_cons + 1);
> >>> +
> >>> +		/*
> >>> +		 * No need to add barrier in-between to enforce ordering here.
> >>> +		 * The other side proceeds only after both flags and tail are
> >>> +		 * updated.
> >>> +		 */
> >>> +		iowrite32(entry->flags, &out->flags);
> >>> +		iowrite32(edma->tx_cons, NTB_TAIL_TX_O(qp));
> >>> +
> >>> +		ntb_transport_edma_notify_peer(edma);
> >>> +
> >>> +		ntb_list_add(&qp->ntb_tx_free_q_lock, &entry->entry,
> >>> +			     &qp->tx_free_q);
> >>> +
> >>> +		if (qp->tx_handler)
> >>> +			qp->tx_handler(qp, qp->cb_data, cb_data, len);
> >>> +
> >>> +		/* stat updates */
> >>> +		qp->tx_bytes += len;
> >>> +		qp->tx_pkts++;
> >>> +	}
> >>> +}
> >>> +
> >>> +static void ntb_transport_edma_tx_cb(void *data,
> >>> +				     const struct dmaengine_result *res)
> >>> +{
> >>> +	struct ntb_queue_entry *entry = data;
> >>> +	struct ntb_transport_qp *qp = entry->qp;
> >>> +	struct ntb_transport_ctx *nt = qp->transport;
> >>> +	struct device *dma_dev = get_dma_dev(qp->ndev);
> >>> +	enum dmaengine_tx_result dma_err = res->result;
> >>> +	struct ntb_transport_ctx_edma *ctx = nt->priv;
> >>> +	struct ntb_transport_qp_edma *edma = qp->priv;
> >>> +
> >>> +	switch (dma_err) {
> >>> +	case DMA_TRANS_READ_FAILED:
> >>> +	case DMA_TRANS_WRITE_FAILED:
> >>> +	case DMA_TRANS_ABORTED:
> >>> +		entry->errors++;
> >>> +		entry->len = -EIO;
> >>> +		break;
> >>> +	case DMA_TRANS_NOERROR:
> >>> +	default:
> >>> +		break;
> >>> +	}
> >>> +	dma_unmap_sg(dma_dev, &entry->sgl, 1, DMA_TO_DEVICE);
> >>> +	sg_dma_address(&entry->sgl) = 0;
> >>> +
> >>> +	entry->flags |= DESC_DONE_FLAG;
> >>> +
> >>> +	queue_work(ctx->wq, &edma->tx_work);
> >>> +}
> >>> +
> >>> +static int ntb_transport_edma_submit(struct device *d, struct dma_chan *chan,
> >>> +				     size_t len, void *rc_src, dma_addr_t dst,
> >>> +				     struct ntb_queue_entry *entry)
> >>> +{
> >>> +	struct scatterlist *sgl = &entry->sgl;
> >>> +	struct dma_async_tx_descriptor *txd;
> >>> +	struct dma_slave_config cfg;
> >>> +	dma_cookie_t cookie;
> >>> +	int nents, rc;
> >>> +
> >>> +	if (!d)
> >>> +		return -ENODEV;
> >>> +
> >>> +	if (!chan)
> >>> +		return -ENXIO;
> >>> +
> >>> +	if (WARN_ON(!rc_src || !dst))
> >>> +		return -EINVAL;
> >>> +
> >>> +	if (WARN_ON(sg_dma_address(sgl)))
> >>> +		return -EINVAL;
> >>> +
> >>> +	sg_init_one(sgl, rc_src, len);
> >>> +	nents = dma_map_sg(d, sgl, 1, DMA_TO_DEVICE);
> >>> +	if (nents <= 0)
> >>> +		return -EIO;
> >>> +
> >>> +	memset(&cfg, 0, sizeof(cfg));
> >>> +	cfg.dst_addr       = dst;
> >>> +	cfg.src_addr_width = DMA_SLAVE_BUSWIDTH_4_BYTES;
> >>> +	cfg.dst_addr_width = DMA_SLAVE_BUSWIDTH_4_BYTES;
> >>> +	cfg.direction      = DMA_MEM_TO_DEV;
> >>> +
> >>> +	txd = dmaengine_prep_slave_sg_config(chan, sgl, 1, DMA_MEM_TO_DEV,
> >>> +				      DMA_CTRL_ACK | DMA_PREP_INTERRUPT, &cfg);
> >>> +	if (!txd) {
> >>> +		rc = -EIO;
> >>> +		goto out_unmap;
> >>> +	}
> >>> +
> >>> +	txd->callback_result = ntb_transport_edma_tx_cb;
> >>> +	txd->callback_param = entry;
> >>> +
> >>> +	cookie = dmaengine_submit(txd);
> >>> +	if (dma_submit_error(cookie)) {
> >>> +		rc = -EIO;
> >>> +		goto out_unmap;
> >>> +	}
> >>> +	dma_async_issue_pending(chan);
> >>> +	return 0;
> >>> +out_unmap:
> >>> +	dma_unmap_sg(d, sgl, 1, DMA_TO_DEVICE);
> >>> +	return rc;
> >>> +}
> >>> +
> >>> +static int ntb_transport_edma_tx_enqueue_inner(struct ntb_transport_qp *qp,
> >>> +					       struct ntb_queue_entry *entry)
> >>> +{
> >>> +	struct device *dma_dev = get_dma_dev(qp->ndev);
> >>> +	struct ntb_transport_qp_edma *edma = qp->priv;
> >>> +	struct ntb_transport_ctx *nt = qp->transport;
> >>> +	struct ntb_edma_desc *in, __iomem *out;
> >>> +	struct ntb_transport_ctx_edma *ctx = nt->priv;
> >>> +	unsigned int len = entry->len;
> >>> +	struct dma_chan *chan;
> >>> +	u32 issue, idx, head;
> >>> +	dma_addr_t dst;
> >>> +	int rc;
> >>> +
> >>> +	WARN_ON_ONCE(entry->flags & DESC_DONE_FLAG);
> >>> +
> >>> +	scoped_guard(spinlock_irqsave, &edma->tx_lock) {
> >>> +		head = READ_ONCE(*NTB_HEAD_TX_I(qp));
> >>> +		issue = edma->tx_issue;
> >>> +		if (ntb_edma_ring_used_entry(head, issue) == 0) {
> >>> +			qp->tx_ring_full++;
> >>> +			return -ENOSPC;
> >>> +		}
> >>> +
> >>> +		/*
> >>> +		 * ntb_transport_edma_tx_work() checks entry->flags
> >>> +		 * so it needs to be set before tx_issue++.
> >>> +		 */
> >>> +		idx = ntb_edma_ring_idx(issue);
> >>> +		in = NTB_DESC_TX_I(qp, idx);
> >>> +		in->data = (uintptr_t)entry;
> >>> +
> >>> +		/* Make in->data visible before tx_issue++ */
> >>> +		smp_wmb();
> >>> +
> >>> +		WRITE_ONCE(edma->tx_issue, edma->tx_issue + 1);
> >>> +	}
> >>> +
> >>> +	/* Publish the final transfer length to the other end */
> >>> +	out = NTB_DESC_TX_O(qp, idx);
> >>> +	iowrite32(len, &out->len);
> >>> +	ioread32(&out->len);
> >>> +
> >>> +	if (unlikely(!len)) {
> >>> +		entry->flags |= DESC_DONE_FLAG;
> >>> +		queue_work(ctx->wq, &edma->tx_work);
> >>> +		return 0;
> >>> +	}
> >>> +
> >>> +	/* Paired with dma_wmb() in ntb_transport_edma_rx_enqueue_inner() */
> >>> +	dma_rmb();
> >>> +
> >>> +	/* kick remote eDMA read transfer */
> >>> +	dst = (dma_addr_t)in->addr;
> >>> +	chan = ntb_edma_pick_chan(&ctx->chans, qp->qp_num);
> >>> +	rc = ntb_transport_edma_submit(dma_dev, chan, len,
> >>> +					      entry->buf, dst, entry);
> >>> +	if (rc) {
> >>> +		entry->errors++;
> >>> +		entry->len = -EIO;
> >>> +		entry->flags |= DESC_DONE_FLAG;
> >>> +		queue_work(ctx->wq, &edma->tx_work);
> >>> +	}
> >>> +	return 0;
> >>> +}
> >>> +
> >>> +static int ntb_transport_edma_tx_enqueue(struct ntb_transport_qp *qp,
> >>> +					 struct ntb_queue_entry *entry,
> >>> +					 void *cb, void *data, unsigned int len,
> >>> +					 unsigned int flags)
> >>> +{
> >>> +	struct device *dma_dev;
> >>> +
> >>> +	if (entry->addr) {
> >>> +		/* Deferred unmap */
> >>> +		dma_dev = get_dma_dev(qp->ndev);
> >>> +		dma_unmap_single(dma_dev, entry->addr, entry->len,
> >>> +				 DMA_TO_DEVICE);
> >>> +	}
> >>> +
> >>> +	entry->cb_data = cb;
> >>> +	entry->buf = data;
> >>> +	entry->len = len;
> >>> +	entry->flags = flags;
> >>> +	entry->errors = 0;
> >>> +	entry->addr = 0;
> >>> +
> >>> +	WARN_ON_ONCE(!ntb_qp_edma_enabled(qp));
> >>> +
> >>> +	return ntb_transport_edma_tx_enqueue_inner(qp, entry);
> >>> +}
> >>> +
> >>> +static int ntb_transport_edma_rx_enqueue_inner(struct ntb_transport_qp *qp,
> >>> +					       struct ntb_queue_entry *entry)
> >>> +{
> >>> +	struct device *dma_dev = get_dma_dev(qp->ndev);
> >>> +	struct ntb_transport_qp_edma *edma = qp->priv;
> >>> +	struct ntb_edma_desc *in, __iomem *out;
> >>> +	unsigned int len = entry->len;
> >>> +	void *data = entry->buf;
> >>> +	dma_addr_t dst;
> >>> +	u32 idx;
> >>> +	int rc;
> >>> +
> >>> +	dst = dma_map_single(dma_dev, data, len, DMA_FROM_DEVICE);
> >>> +	rc = dma_mapping_error(dma_dev, dst);
> >>> +	if (rc)
> >>> +		return rc;
> >>> +
> >>> +	guard(spinlock_bh)(&edma->rx_lock);
> >>> +
> >>> +	if (ntb_edma_ring_full(READ_ONCE(edma->rx_prod),
> >>> +			       READ_ONCE(edma->rx_cons))) {
> >>> +		rc = -ENOSPC;
> >>> +		goto out_unmap;
> >>> +	}
> >>> +
> >>> +	idx = ntb_edma_ring_idx(edma->rx_prod);
> >>> +	in = NTB_DESC_RX_I(qp, idx);
> >>> +	out = NTB_DESC_RX_O(qp, idx);
> >>> +
> >>> +	iowrite32(len, &out->len);
> >>> +	iowrite64(dst, &out->addr);
> >>> +
> >>> +	WARN_ON(in->flags & DESC_DONE_FLAG);
> >>> +	in->data = (uintptr_t)entry;
> >>> +	entry->addr = dst;
> >>> +
> >>> +	/* Ensure len/addr are visible before the head update */
> >>> +	dma_wmb();
> >>> +
> >>> +	WRITE_ONCE(edma->rx_prod, edma->rx_prod + 1);
> >>> +	iowrite32(edma->rx_prod, NTB_HEAD_RX_O(qp));
> >>> +
> >>> +	return 0;
> >>> +out_unmap:
> >>> +	dma_unmap_single(dma_dev, dst, len, DMA_FROM_DEVICE);
> >>> +	return rc;
> >>> +}
> >>> +
> >>> +static int ntb_transport_edma_rx_enqueue(struct ntb_transport_qp *qp,
> >>> +					 struct ntb_queue_entry *entry)
> >>> +{
> >>> +	int rc;
> >>> +
> >>> +	rc = ntb_transport_edma_rx_enqueue_inner(qp, entry);
> >>> +	if (rc) {
> >>> +		ntb_list_add(&qp->ntb_rx_q_lock, &entry->entry,
> >>> +			     &qp->rx_free_q);
> >>> +		return rc;
> >>> +	}
> >>> +
> >>> +	ntb_list_add(&qp->ntb_rx_q_lock, &entry->entry, &qp->rx_pend_q);
> >>> +
> >>> +	if (qp->active)
> >>> +		tasklet_schedule(&qp->rxc_db_work);
> >>> +
> >>> +	return 0;
> >>> +}
> >>> +
> >>> +static void ntb_transport_edma_rx_poll(struct ntb_transport_qp *qp)
> >>> +{
> >>> +	struct ntb_transport_ctx *nt = qp->transport;
> >>> +	struct ntb_transport_ctx_edma *ctx = nt->priv;
> >>> +	struct ntb_transport_qp_edma *edma = qp->priv;
> >>> +
> >>> +	queue_work(ctx->wq, &edma->rx_work);
> >>> +	queue_work(ctx->wq, &edma->tx_work);
> >>> +}
> >>> +
> >>> +static int ntb_transport_edma_qp_init(struct ntb_transport_ctx *nt,
> >>> +				      unsigned int qp_num)
> >>> +{
> >>> +	struct ntb_transport_qp *qp = &nt->qp_vec[qp_num];
> >>> +	struct ntb_transport_qp_edma *edma;
> >>> +	struct ntb_dev *ndev = nt->ndev;
> >>> +	int node;
> >>> +
> >>> +	node = dev_to_node(&ndev->dev);
> >>> +
> >>> +	qp->priv = kzalloc_node(sizeof(*edma), GFP_KERNEL, node);
> >>> +	if (!qp->priv)
> >>> +		return -ENOMEM;
> >>> +
> >>> +	edma = (struct ntb_transport_qp_edma *)qp->priv;
> >>> +	edma->qp = qp;
> >>> +	edma->rx_prod = 0;
> >>> +	edma->rx_cons = 0;
> >>> +	edma->tx_cons = 0;
> >>> +	edma->tx_issue = 0;
> >>> +
> >>> +	spin_lock_init(&edma->rx_lock);
> >>> +	spin_lock_init(&edma->tx_lock);
> >>> +
> >>> +	INIT_WORK(&edma->db_work, ntb_transport_edma_db_work);
> >>> +	INIT_WORK(&edma->rx_work, ntb_transport_edma_rx_work);
> >>> +	INIT_WORK(&edma->tx_work, ntb_transport_edma_tx_work);
> >>> +
> >>> +	return 0;
> >>> +}
> >>> +
> >>> +static void ntb_transport_edma_qp_free(struct ntb_transport_qp *qp)
> >>> +{
> >>> +	struct ntb_transport_qp_edma *edma = qp->priv;
> >>> +
> >>> +	cancel_work_sync(&edma->db_work);
> >>> +	cancel_work_sync(&edma->rx_work);
> >>> +	cancel_work_sync(&edma->tx_work);
> >>> +
> >>> +	kfree(qp->priv);
> >>> +}
> >>> +
> >>> +static int ntb_transport_edma_pre_link_up(struct ntb_transport_ctx *nt)
> >>> +{
> >>> +	struct ntb_dev *ndev = nt->ndev;
> >>> +	struct pci_dev *pdev = ndev->pdev;
> >>> +	int rc;
> >>> +
> >>> +	rc = ntb_transport_edma_ep_init(nt);
> >>> +	if (rc)
> >>> +		dev_err(&pdev->dev, "Failed to init EP: %d\n", rc);
> >>> +
> >>> +	return rc;
> >>> +}
> >>> +
> >>> +static int ntb_transport_edma_post_link_up(struct ntb_transport_ctx *nt)
> >>> +{
> >>> +	struct ntb_dev *ndev = nt->ndev;
> >>> +	struct pci_dev *pdev = ndev->pdev;
> >>> +	int rc;
> >>> +
> >>> +	rc = ntb_transport_edma_rc_init(nt);
> >>> +	if (rc)
> >>> +		dev_err(&pdev->dev, "Failed to init RC: %d\n", rc);
> >>> +
> >>> +	return rc;
> >>> +}
> >>> +
> >>> +static int ntb_transport_edma_enable(struct ntb_transport_ctx *nt,
> >>> +				     unsigned int *mw_count)
> >>> +{
> >>> +	struct ntb_dev *ndev = nt->ndev;
> >>> +	struct ntb_transport_ctx_edma *ctx = nt->priv;
> >>> +
> >>> +	if (!use_remote_edma)
> >>> +		return 0;
> >>> +
> >>> +	/*
> >>> +	 * We need at least one MW for the transport plus one MW reserved
> >>> +	 * for the remote eDMA window (see ntb_edma_setup_mws/peer).
> >>> +	 */
> >>> +	if (*mw_count <= 1) {
> >>> +		dev_err(&ndev->dev,
> >>> +			"remote eDMA requires at least two MWS (have %u)\n",
> >>> +			*mw_count);
> >>> +		return -ENODEV;
> >>> +	}
> >>> +
> >>> +	ctx->wq = alloc_workqueue("ntb-edma-wq", WQ_UNBOUND | WQ_SYSFS, 0);
> >>> +	if (!ctx->wq) {
> >>> +		ntb_transport_edma_uninit(nt);
> >>> +		return -ENOMEM;
> >>> +	}
> >>> +
> >>> +	/* Reserve the last peer MW exclusively for the eDMA window. */
> >>> +	*mw_count -= 1;
> >>> +
> >>> +	return 0;
> >>> +}
> >>> +
> >>> +static void ntb_transport_edma_disable(struct ntb_transport_ctx *nt)
> >>> +{
> >>> +	ntb_transport_edma_uninit(nt);
> >>> +}
> >>> +
> >>> +static const struct ntb_transport_backend_ops edma_backend_ops = {
> >>> +	.enable = ntb_transport_edma_enable,
> >>> +	.disable = ntb_transport_edma_disable,
> >>> +	.qp_init = ntb_transport_edma_qp_init,
> >>> +	.qp_free = ntb_transport_edma_qp_free,
> >>> +	.pre_link_up = ntb_transport_edma_pre_link_up,
> >>> +	.post_link_up = ntb_transport_edma_post_link_up,
> >>> +	.setup_qp_mw = ntb_transport_edma_setup_qp_mw,
> >>> +	.tx_free_entry = ntb_transport_edma_tx_free_entry,
> >>> +	.tx_enqueue = ntb_transport_edma_tx_enqueue,
> >>> +	.rx_enqueue = ntb_transport_edma_rx_enqueue,
> >>> +	.rx_poll = ntb_transport_edma_rx_poll,
> >>> +	.debugfs_stats_show = ntb_transport_edma_debugfs_stats_show,
> >>> +};
> >>> +
> >>> +int ntb_transport_edma_init(struct ntb_transport_ctx *nt)
> >>> +{
> >>> +	struct ntb_dev *ndev = nt->ndev;
> >>> +	int node;
> >>> +
> >>> +	node = dev_to_node(&ndev->dev);
> >>> +	nt->priv = kzalloc_node(sizeof(struct ntb_transport_ctx_edma), GFP_KERNEL,
> >>> +				node);
> >>> +	if (!nt->priv)
> >>> +		return -ENOMEM;
> >>> +
> >>> +	nt->backend_ops = edma_backend_ops;
> >>> +	/*
> >>> +	 * On remote eDMA mode, one DMA read channel is used for Host side
> >>> +	 * to interrupt EP.
> >>> +	 */
> >>> +	use_msi = false;
> >>> +	return 0;
> >>> +}
> >>> diff --git a/drivers/ntb/ntb_transport_internal.h b/drivers/ntb/ntb_transport_internal.h
> >>> index 51ff08062d73..9fff65980d3d 100644
> >>> --- a/drivers/ntb/ntb_transport_internal.h
> >>> +++ b/drivers/ntb/ntb_transport_internal.h
> >>> @@ -8,6 +8,7 @@
> >>>  extern unsigned long max_mw_size;
> >>>  extern unsigned int transport_mtu;
> >>>  extern bool use_msi;
> >>> +extern bool use_remote_edma;
> >>>
> >>>  #define QP_TO_MW(nt, qp)	((qp) % nt->mw_count)
> >>>
> >>> @@ -29,6 +30,11 @@ struct ntb_queue_entry {
> >>>  		struct ntb_payload_header __iomem *tx_hdr;
> >>>  		struct ntb_payload_header *rx_hdr;
> >>>  	};
> >>> +
> >>> +#ifdef CONFIG_NTB_TRANSPORT_EDMA
> >>> +	dma_addr_t addr;
> >>> +	struct scatterlist sgl;
> >>> +#endif
> >>>  };
> >>>
> >>>  struct ntb_rx_info {
> >>> @@ -202,4 +208,13 @@ int ntb_transport_init_queue(struct ntb_transport_ctx *nt,
> >>>  			     unsigned int qp_num);
> >>>  struct device *get_dma_dev(struct ntb_dev *ndev);
> >>>
> >>> +#ifdef CONFIG_NTB_TRANSPORT_EDMA
> >>> +int ntb_transport_edma_init(struct ntb_transport_ctx *nt);
> >>> +#else
> >>> +static inline int ntb_transport_edma_init(struct ntb_transport_ctx *nt)
> >>> +{
> >>> +	return -EOPNOTSUPP;
> >>> +}
> >>> +#endif /* CONFIG_NTB_TRANSPORT_EDMA */
> >>> +
> >>>  #endif /* _NTB_TRANSPORT_INTERNAL_H_ */
> >>> --
> >>> 2.51.0
> >>>
> 

