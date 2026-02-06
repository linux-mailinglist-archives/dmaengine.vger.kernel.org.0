Return-Path: <dmaengine+bounces-8799-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IL3KOdoshmnkKAQAu9opvQ
	(envelope-from <dmaengine+bounces-8799-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Fri, 06 Feb 2026 19:03:06 +0100
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 45760101959
	for <lists+dmaengine@lfdr.de>; Fri, 06 Feb 2026 19:03:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C357F301AA67
	for <lists+dmaengine@lfdr.de>; Fri,  6 Feb 2026 18:01:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4598E36EAB4;
	Fri,  6 Feb 2026 18:01:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="OzGYkJe5"
X-Original-To: dmaengine@vger.kernel.org
Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazon11013066.outbound.protection.outlook.com [52.101.83.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1A4217993;
	Fri,  6 Feb 2026 18:01:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.83.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770400904; cv=fail; b=saH6XJiKJSIbi/UuLx8RzeBO8yjM87dkPOlIMM71TSw0vmxeSyyi5EVFJ2a3pHkTUWUSv8NZuNkb9ITM9m8WB/FJwzoEGNqZJhKWwlTu1lwM5Encg2VFU2SkKjnSPIjYt9qV1TPvNTDEmfsO5kUCpXm3ys999TpG/QFlLboA5R0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770400904; c=relaxed/simple;
	bh=aKYeYcPmnJ7eZXLsoJMX2BrctTHkLh0FI516bUglqGo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=GWn2/5BdUPrH3+6VBcjOxo0BaWolanXOJnY+fMA+/dR2fQTbDs7QaWSFppS4Q0SQPbZfWGMwpnlvFJ1Wpo+TBBMJEdjRFn74OEnG1XarrUMH7ytViBMAlO1MuWlq/JIZLGLHl3CZLFAU09YOekQ8fzl1hXNuIOYcrJPHyN7/lUM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=OzGYkJe5; arc=fail smtp.client-ip=52.101.83.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LoTBzztASCuZTsurNWJaTDn3SWFzaT+R8w1eviz0oUaA25DZE5alA/f3p/BPmD6J84sJR2Bl1janBV/9STdzGEmBr2KD5tJgFEMGyTKo+3l2m8KK4y5Uw6ebMK7dpIgT3QL9h7E+CMb6w0UH5cRgWqEUe/8W5ol6H+qnCIGXDi4sII1+KOyz+79dnUOwoVq0skU/HKpM0w6GwAkrMZHlqyxEAcnoNIIjsrRieCH2cAquz4aJ3zNfzH3Ek2/73v6Z2C7mIa7Ce2mZ4OqlrkYBM37TtP1Xgk06M1a9+JVdiAQl9mPB7/JUVDKgoM3hPYvxgATDI2p6ovNCms4/AoeQMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5mS/hUFrJ7YiDVDa6PJlj0u25mBoqQvboXD2Ghy+jOQ=;
 b=m3VJxtPiN5GIJncd8s9jtAn1NwRAtAjL51h9+Gy1EYbaYUgnFZQ/Veztr62EH+gAiG/+e/muir2s7lMy80+t9elv6KqF1O0RnpF41wGVqvvqFQLo2HS4FvaqoA3GqM62RJJnyAlh2z8iFgu7e6TSYvv5bPjojlwQ5rHHAKfP/wvtQepnUbh8nmXw6H2JsObz6J5Bxa8VDguudEyxwbxYnLj09RtA2qeB+0PgyXoJ0BIWgvOs3630iSmQNnymzZU2KFFm1kt0OZMu8Tv5uKvW37FmzPdUs4AHLo4yVRwGQIUK/ih7/kj3ut6e6vWpcYfCBUskyWTMaCG4QvevB/A/Rg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5mS/hUFrJ7YiDVDa6PJlj0u25mBoqQvboXD2Ghy+jOQ=;
 b=OzGYkJe5lx4WCVOyjktIhPftHWBn6wTupWfOJh7aean0eGpPUOJYZCvsMz5nhBrKSIuApnIYaivVTw8ow1vwxkzeo0n+F9t5Es+ntDl6vk9T2fKbTs2ykyhuclRmRb4IuhNvT57jlAK4gg1T+cS8uhqX0Mh3ri/A5Yrz+WYR4hdVvIo4OJvXoVWY5WFtGMtz7IOA4ZcaFEFONGnsMcFStQGC3ZVjVYD9f25N4XojlE65wtjsaF9DcuL+ynANm4LQ46T4U20mviJBov22vXqtHb3HLHzZQXntblaS5baKi/hcWf0ilSHqYr56nlz0f49B/DL6eYPMA/Va1L4XzDmPrg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PA4PR04MB9366.eurprd04.prod.outlook.com (2603:10a6:102:2a9::8)
 by PAXPR04MB8208.eurprd04.prod.outlook.com (2603:10a6:102:1c7::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.15; Fri, 6 Feb
 2026 18:01:40 +0000
Received: from PA4PR04MB9366.eurprd04.prod.outlook.com
 ([fe80::75e4:8143:ddbc:6588]) by PA4PR04MB9366.eurprd04.prod.outlook.com
 ([fe80::75e4:8143:ddbc:6588%6]) with mapi id 15.20.9587.010; Fri, 6 Feb 2026
 18:01:40 +0000
Date: Fri, 6 Feb 2026 13:01:33 -0500
From: Frank Li <Frank.li@nxp.com>
To: Koichiro Den <den@valinux.co.jp>
Cc: vkoul@kernel.org, mani@kernel.org, jingoohan1@gmail.com,
	lpieralisi@kernel.org, kwilczynski@kernel.org, robh@kernel.org,
	bhelgaas@google.com, dmaengine@vger.kernel.org,
	linux-pci@vger.kernel.org, linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 4/9] PCI: endpoint: Add remote resource query API
Message-ID: <aYYsfSTrrLbR_txR@lizhi-Precision-Tower-5810>
References: <20260206172646.1556847-1-den@valinux.co.jp>
 <20260206172646.1556847-5-den@valinux.co.jp>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260206172646.1556847-5-den@valinux.co.jp>
X-ClientProxiedBy: SN6PR01CA0016.prod.exchangelabs.com (2603:10b6:805:b6::29)
 To PA4PR04MB9366.eurprd04.prod.outlook.com (2603:10a6:102:2a9::8)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR04MB9366:EE_|PAXPR04MB8208:EE_
X-MS-Office365-Filtering-Correlation-Id: 08807126-7cb8-4cac-7adc-08de65a9c764
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|52116014|7416014|366016|19092799006|38350700014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ySSA8qNZoXWxTiaFcdCH3CVo9KryY2zJM7Bn0jEWmJDUINNsfO6HuM2dhR/r?=
 =?us-ascii?Q?1u1TAJcEEi9MxjH7wZWk7LxV78T92YiegYMs/EzhudABLK/dIGrz6DUhdaoM?=
 =?us-ascii?Q?HZjXiM9X4pFQsmEwfFHFze+/12B+DhoaPd+VTxr55GteyJZXk4neEjHE909Z?=
 =?us-ascii?Q?ZCkTztW91PqffbGGNQcF+ZfStWql+t1wH6NCvYrWqDVPdVjQ18OH9HYtlBC+?=
 =?us-ascii?Q?oAfg1oLrHsycZwldyv88a8w9+YsdywKA2Tz6MRoOked5fyUTtxr78M1Cve6q?=
 =?us-ascii?Q?GgCDWeSbE0k4ozHXoS2IGJNM4kKNVeGEXTC4m+oJ4yjyOxkx6qRixYFFYJrr?=
 =?us-ascii?Q?OYe08GCWPviYhqIcTBzhjUi9gjWW7OmEvEtNyBQiXHm6fuz70fja/0H1M8Yi?=
 =?us-ascii?Q?uUWj+yRjO+IivcJVwU2gUgj9zRQL3e9pWUMDG3hhm8KhoAYPSZuv9lREVs4p?=
 =?us-ascii?Q?iEvOUUJf9Dd72v+UPEHAxAWOOt+OjlLLR1aMl9K5hfZbprKpxbtu8pb8y+A2?=
 =?us-ascii?Q?Ku9lWVktLFk8SBV4XBWCkUxGvhvC/RKA4non7As5wu1lNgBzQKlgOU18cKF8?=
 =?us-ascii?Q?9l1IUM5h8dGGQGOCRjQwrq+EcHWblZLEDP6nHF3Pgde1x7tVYtg6jbnaDIW6?=
 =?us-ascii?Q?SPXeyeD+n60dKdRemj9C4lChGxnYQeZRZEvV6rSEf/TGflVGGtCvHKK1DGFK?=
 =?us-ascii?Q?L62uGlnkz+cXf8ORlA1N317Wv77RDESYkUVfpJSH0mFI8C+uDDb0NOtCkGGP?=
 =?us-ascii?Q?xudRBwCK3WPL32J7WRMvnljyDtOGY4eVAgzmsCcbseIbhoHiFanlGgQ/B8hj?=
 =?us-ascii?Q?QJKxxVfygZO7ttQwtmbWgIsx8txhs+wL497aOgsnW7Ohesvow+EC64Vq67r3?=
 =?us-ascii?Q?5+SW+oOroBI2vmRi0JUf0DcjIJ7wiMcPid0yeYpywckRc7qzSpb61COBMsre?=
 =?us-ascii?Q?XerqV/Dxn7fcFvKE6FZIl0RPTbWTQBFMGf0gYWmLugLFlAQ8V/kmhuND2E7z?=
 =?us-ascii?Q?Eyw2pVWYkdV7xAmSu1HwLFQsyA067XsglQzaQAarQ0Cy8g0hwllZb9smX8S2?=
 =?us-ascii?Q?XVY9VZaDfabf6EezlwOvToAoMMZ4lsbysvhivzu0yelOvrE3UC8gGtIbUyG9?=
 =?us-ascii?Q?BgmTXZi/z4A7uX+Am6TX2ID2UeFM4oqRhoblk9bLC1AnxYeXSZtVcDgglMwX?=
 =?us-ascii?Q?TJewLwwOuiop5YaXZIhXsOxk7jT95wq7W/D6FamhDVQO3A5W3OQ4CzQ4njwC?=
 =?us-ascii?Q?AuiUuyz8yj8umlKLthFypgJapJczTjyIyIJsGGUbjMak6m3Y6z2sluKSqljo?=
 =?us-ascii?Q?lkyl4Q0ki/hZDJp9r4G7Vs55T6aJV65BTQxtH+shihEmJerRyzeGGFhBHeZ5?=
 =?us-ascii?Q?KTqAoqiWA75tNHakYEyeZ0+jPhiyYRDdNWO7t1VgmnFB/9UN8imqkZw9Gsmm?=
 =?us-ascii?Q?CUYZ1ykITQxHiX+CFKgxSiGg1+2rPHsSS5sQ5wjFsheB3tHXMqhxTiOEG5hl?=
 =?us-ascii?Q?UWWdXZkBskfxPOKV6U3FkbZ8GWiB3gnfl+A7gZSnjSsU6NrGGK/jAjGqCA9J?=
 =?us-ascii?Q?dW10EjvUAstArO2GO7oi6wgt3E8/GWYAscMbRrc1G9N6sf2Sa87gcbFv0KMj?=
 =?us-ascii?Q?ekp4Z893eyZt4oOK/etMDDo=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB9366.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(52116014)(7416014)(366016)(19092799006)(38350700014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?jxHdFj0rUbY37TlDAdw6GScjTsYEvkO4tgpUBDSohs1ep46PZW+g772SGQ9V?=
 =?us-ascii?Q?+DysCQRx37iUSjnxhm0We9UelNJOi2+u75Spn/1JzSAJMGc2FHPwgm/7vvHO?=
 =?us-ascii?Q?4ms1cCkLyqc+NsiHX7z11uYZ5+if0LuHICg+a3E2OtXAwL/3vz7rlmbVRZxF?=
 =?us-ascii?Q?jm+EVTly8Wr18oNDdL5EDkmIBsr8RkQ3j/2dvZ0mI1NKLUpr9VzpYutH0RM3?=
 =?us-ascii?Q?o3r4P88dYOdfQUctHy/90chWN4LTMurI+jqIW4umI4W5L16eXHfFqqbGEqz0?=
 =?us-ascii?Q?Yrq0h8fFNhfwOoXDVT9cSkcr3iCKVtgzgshX5qzggBHAv+vrsLjPSlSMhi4v?=
 =?us-ascii?Q?E96FIB5nZzEQ7ekR/IkWc5nnL383dINO3y0GlfZaI86nlo4YWn/fxTDZEuQM?=
 =?us-ascii?Q?JJMxBMch/vk6Yx3bJSQsHa8zZhA6Ypys3aW3uykM1UVUzJA5xF4eS5H2aBfS?=
 =?us-ascii?Q?rJ5vZMqaSHd9QG1R47EoAsVh71ViTYjUD9TS7ADCjeZm00sUOx01oAG+demu?=
 =?us-ascii?Q?uK5Lsz660F0I6pGAM5y/nWwgjUMvl+WW6jRvGSpuJ7xInEsOAmnUyNFDGlqj?=
 =?us-ascii?Q?mQhek3hk8cI0KYwsnYL/LI/xQ5VblKYCf8VjfQZCoOYMrBWS7nWqd1w+oPzS?=
 =?us-ascii?Q?FgEYEKOh4lg8/jNuLythsCv/l2fnHWvHXhZnDjkYlt+ShAaBmXCq5f2ZziJe?=
 =?us-ascii?Q?8VNS2ch6nRzVQf4ZHey69qZZ7PSUm6c6c/JLRU+oQUSK/UJJ8pHZB1c72kmW?=
 =?us-ascii?Q?ajXpZBK2yqJoyfPIJrilwMI2xNxectTgONaZi8d+LHJRvWgQG7+d7oVFQSj0?=
 =?us-ascii?Q?cF8mnPWvKdDbwJLyQ+ohzot7WzkQ5ECAyZKlKRAmy8GbwluvuGukWDZkk3Ss?=
 =?us-ascii?Q?WfeWNUEXJDgUDanXJXOxoo4aR0xOaeSs2taimZzDCoGlT7ucZ1qfZLD9P5IL?=
 =?us-ascii?Q?xHczWeBd97Ml5CMAlRaYDqvXy64/GC2UVr6Z0YQrvFY7f9zSElAD9MA0kQQF?=
 =?us-ascii?Q?cnk0dVAxfZDky3vcIppbZkdV1i5zNR7JId5kxvn+Q012rWtX3r+YSUlOKcah?=
 =?us-ascii?Q?2uCCv09GeedyNCxIAOINDZ6NURiAzsKfCMbUUL+5xIN9JQB5VED8jahCz92c?=
 =?us-ascii?Q?FOrYjtd9m7uRYmFpFGGu0YKR7jEmhz4O2XUn4760h5IBWDdJ2rGD3GRTGbgR?=
 =?us-ascii?Q?zbwHv5Ce5xEyfj05Kht6wAk45bp1y20aH6fv2hIEijNgcfrG0GWgw053/H/I?=
 =?us-ascii?Q?Ju0qtfKVDVBt9yHdTxryweqa16ooPxSTeaCILzMZ9WsA5r6M4mvEsPJQhslN?=
 =?us-ascii?Q?MsUd2dCLonQri0q2uIDeTRuCnxrzmhkLzGvZmpixB33iKsz8oBZAaKpMOPTb?=
 =?us-ascii?Q?jqGu8+OoScBdb34BF7jftyKTIrNcgZ19Y9XhRQ5uqGdo8Xq3Wejn3KM52q2E?=
 =?us-ascii?Q?N+Un6doeC0pXalZaQO7zZ3Ud3BZjVRQf0Aqkhzy+1O0+oC5QC/X3Ydl2iKEf?=
 =?us-ascii?Q?HSB/2d0VrlA4xZW72KB4pX5L8vzLUt+5yXx587D8PYlg1Ha/Xz52KttxNerI?=
 =?us-ascii?Q?DcWYfP9wmpF6Ri2z1piF0MU1DXeCixWQVv3vCWrbFI2tQM6gTn5Qd/CWfvE3?=
 =?us-ascii?Q?/FtJvqj+KtyRH6nkJMI5nVMHyi0igafKpam9CmOYW0aVW0YsIpEg4aOjSPDN?=
 =?us-ascii?Q?9wV/9529MFUHqboBLoXzp0V15RWc7RvUgrDcqAXeJQICkeb6LWwK5gFbsyKs?=
 =?us-ascii?Q?H7cSOvec6w=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 08807126-7cb8-4cac-7adc-08de65a9c764
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB9366.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Feb 2026 18:01:40.4091
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0IKMh4JE2wVpngavBaxmwp++H8d1AANuNcz5r2XA4ATu20TEJ1T27nZ+vT6xMuH3sUD+OEavsdhjpUTwWpkKWg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8208
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nxp.com,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[nxp.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,gmail.com,google.com,vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-8799-lists,dmaengine=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[Frank.li@nxp.com,dmaengine@vger.kernel.org];
	DKIM_TRACE(0.00)[nxp.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[dmaengine];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 45760101959
X-Rspamd-Action: no action

On Sat, Feb 07, 2026 at 02:26:41AM +0900, Koichiro Den wrote:
> Endpoint controller drivers may integrate auxiliary blocks (e.g. DMA
> engines) whose register windows and descriptor memories metadata need to
> be exposed to a remote peer. Endpoint function drivers need a generic
> way to discover such resources without hard-coding controller-specific
> helpers.
>
> Add pci_epc_get_remote_resources() and the corresponding pci_epc_ops
> get_remote_resources() callback. The API returns a list of resources
> described by type, physical address and size, plus type-specific
> metadata.
>
> Passing resources == NULL (or num_resources == 0) returns the required
> number of entries.
>
> Signed-off-by: Koichiro Den <den@valinux.co.jp>
> ---
>  drivers/pci/endpoint/pci-epc-core.c | 41 +++++++++++++++++++++++++
>  include/linux/pci-epc.h             | 46 +++++++++++++++++++++++++++++
>  2 files changed, 87 insertions(+)
>
> diff --git a/drivers/pci/endpoint/pci-epc-core.c b/drivers/pci/endpoint/pci-epc-core.c
> index 068155819c57..fa161113e24c 100644
> --- a/drivers/pci/endpoint/pci-epc-core.c
> +++ b/drivers/pci/endpoint/pci-epc-core.c
> @@ -155,6 +155,47 @@ const struct pci_epc_features *pci_epc_get_features(struct pci_epc *epc,
>  }
>  EXPORT_SYMBOL_GPL(pci_epc_get_features);
>
> +/**
> + * pci_epc_get_remote_resources() - query EPC-provided remote resources

I am not sure if it good naming, pci_epc_get_additional_resources().
Niklas Cassel may have good suggest, I just find you forget cc him.

Frank
> + * @epc: EPC device
> + * @func_no: function number
> + * @vfunc_no: virtual function number
> + * @resources: output array (may be NULL to query required count)
> + * @num_resources: size of @resources array in entries (0 when querying count)
> + *
> + * Some EPC backends integrate auxiliary blocks (e.g. DMA engines) whose control
> + * registers and/or descriptor memories can be exposed to the host by mapping
> + * them into BAR space. This helper queries the backend for such resources.
> + *
> + * Return:
> + *   * >= 0: number of resources returned (or required, if @resources is NULL)
> + *   * -EOPNOTSUPP: backend does not support remote resource queries
> + *   * other -errno on failure
> + */
> +int pci_epc_get_remote_resources(struct pci_epc *epc, u8 func_no, u8 vfunc_no,
> +				 struct pci_epc_remote_resource *resources,
> +				 int num_resources)
> +{
> +	int ret;
> +
> +	if (!epc || !epc->ops)
> +		return -EINVAL;
> +
> +	if (func_no >= epc->max_functions)
> +		return -EINVAL;
> +
> +	if (!epc->ops->get_remote_resources)
> +		return -EOPNOTSUPP;
> +
> +	mutex_lock(&epc->lock);
> +	ret = epc->ops->get_remote_resources(epc, func_no, vfunc_no,
> +					     resources, num_resources);
> +	mutex_unlock(&epc->lock);
> +
> +	return ret;
> +}
> +EXPORT_SYMBOL_GPL(pci_epc_get_remote_resources);
> +
>  /**
>   * pci_epc_stop() - stop the PCI link
>   * @epc: the link of the EPC device that has to be stopped
> diff --git a/include/linux/pci-epc.h b/include/linux/pci-epc.h
> index c021c7af175f..7d2fce9f3a63 100644
> --- a/include/linux/pci-epc.h
> +++ b/include/linux/pci-epc.h
> @@ -61,6 +61,44 @@ struct pci_epc_map {
>  	void __iomem	*virt_addr;
>  };
>
> +/**
> + * enum pci_epc_remote_resource_type - remote resource type identifiers
> + * @PCI_EPC_RR_DMA_CTRL_MMIO: Integrated DMA controller register window (MMIO)
> + * @PCI_EPC_RR_DMA_CHAN_DESC: Per-channel DMA descriptor
> + *
> + * EPC backends may expose auxiliary blocks (e.g. DMA engines) by mapping their
> + * register windows and descriptor memories into BAR space. This enum
> + * identifies the type of each exposable resource.
> + */
> +enum pci_epc_remote_resource_type {
> +	PCI_EPC_RR_DMA_CTRL_MMIO,
> +	PCI_EPC_RR_DMA_CHAN_DESC,
> +};
> +
> +/**
> + * struct pci_epc_remote_resource - a physical resource that can be exposed
> + * @type:      resource type, see enum pci_epc_remote_resource_type
> + * @phys_addr: physical base address of the resource
> + * @size:      size of the resource in bytes
> + * @u:         type-specific metadata
> + *
> + * For @PCI_EPC_RR_DMA_CHAN_DESC, @u.dma_chan_desc provides per-channel
> + * information.
> + */
> +struct pci_epc_remote_resource {
> +	enum pci_epc_remote_resource_type type;
> +	phys_addr_t phys_addr;
> +	resource_size_t size;
> +
> +	union {
> +		/* PCI_EPC_RR_DMA_CHAN_DESC */
> +		struct {
> +			int irq;
> +			resource_size_t db_offset;
> +		} dma_chan_desc;
> +	} u;
> +};
> +
>  /**
>   * struct pci_epc_ops - set of function pointers for performing EPC operations
>   * @write_header: ops to populate configuration space header
> @@ -84,6 +122,8 @@ struct pci_epc_map {
>   * @start: ops to start the PCI link
>   * @stop: ops to stop the PCI link
>   * @get_features: ops to get the features supported by the EPC
> + * @get_remote_resources: ops to retrieve controller-owned resources that can be
> + *			  exposed to the remote host (optional)
>   * @owner: the module owner containing the ops
>   */
>  struct pci_epc_ops {
> @@ -115,6 +155,9 @@ struct pci_epc_ops {
>  	void	(*stop)(struct pci_epc *epc);
>  	const struct pci_epc_features* (*get_features)(struct pci_epc *epc,
>  						       u8 func_no, u8 vfunc_no);
> +	int	(*get_remote_resources)(struct pci_epc *epc, u8 func_no, u8 vfunc_no,
> +					struct pci_epc_remote_resource *resources,
> +					int num_resources);
>  	struct module *owner;
>  };
>
> @@ -309,6 +352,9 @@ int pci_epc_start(struct pci_epc *epc);
>  void pci_epc_stop(struct pci_epc *epc);
>  const struct pci_epc_features *pci_epc_get_features(struct pci_epc *epc,
>  						    u8 func_no, u8 vfunc_no);
> +int pci_epc_get_remote_resources(struct pci_epc *epc, u8 func_no, u8 vfunc_no,
> +				 struct pci_epc_remote_resource *resources,
> +				 int num_resources);
>  enum pci_barno
>  pci_epc_get_first_free_bar(const struct pci_epc_features *epc_features);
>  enum pci_barno pci_epc_get_next_free_bar(const struct pci_epc_features
> --
> 2.51.0
>

