Return-Path: <dmaengine+bounces-8852-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oN//KsgFimluFQAAu9opvQ
	(envelope-from <dmaengine+bounces-8852-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Mon, 09 Feb 2026 17:05:28 +0100
X-Original-To: lists+dmaengine@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EF9F1124D9
	for <lists+dmaengine@lfdr.de>; Mon, 09 Feb 2026 17:05:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id B12CB300514D
	for <lists+dmaengine@lfdr.de>; Mon,  9 Feb 2026 16:05:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6D973806AB;
	Mon,  9 Feb 2026 16:05:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="F4QzvJHh"
X-Original-To: dmaengine@vger.kernel.org
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011058.outbound.protection.outlook.com [52.101.70.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 638FF3806AF;
	Mon,  9 Feb 2026 16:05:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770653123; cv=fail; b=XSWbh5pGTt8Bi8zfhKnpt7Awes+3yd8peEU0/4gjZgitJAs1I3Xzpwn1l1Q7KwnxjAOl+gejucQwDuvQU4Dzah4cHVkicQvn+HzatVJepkEebOuthSAuSCa1sGTerU1rJzE6z/qXW1u2ZmHgKn3vPTLaI2QvWg7lVBBMTY6ZyL8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770653123; c=relaxed/simple;
	bh=EIz7B/sjSCP+7jO3xLcHCI9iIknGYtgEt7UznimBVSk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=LPbVE/13M5JWxzDsbPCeayAmsI36N8Hpay3V+lQziGcHOCGQDDVCOTEnCcbuFHSPIMRwvsvfLODPmIDE4yhiy+a1zxP4Qm9wWeA4W4T9B2z8FeOkkQGbiPrEYYmZ1ffzjkn0Cx/hxhW80tKSjdZPgQoh8wMdMD7CjnUUTQ3cL1A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=F4QzvJHh; arc=fail smtp.client-ip=52.101.70.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kLymJkTAtSOxzuh5BW9kf55I4DFUgK27vNQF3Z8YmMg80lmWSzO1kuUGDD3isVj7s07rcMvtlPUWpHhRcLc0NbjsEXw2V4rnowABxhImmcjFQPR7gS49ZK90P6bZeyIjUmEBNJuLhkc/hrCP5gCTapeE49fP7kqpd9e3MPrxIKXVUuKjro6wZ03NyxPyBQzxxaIgtYNmFMTRHmuvVwKzTSGn4qtYR7m3leDhjcVb5rA+8kqjVymY+OOTPE72qES3xf5XbJ8sWHULhx9WVzqP3RvYO4ORN2KeaG7+xBhaI845Tiovl3hXfitpf4xTeruKtAUcB66q1YZN1F2nDo+esQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=M0/gA/aRh0v75FKSpWmXz3xhaFYZG9uDmw9Pw0fq1/w=;
 b=k83orpxnQX1wZfG1MDURmwrKVOSJH+tj0nbcHd29Q49Lmw1GQ5WSnRyJtMmEzobRveMpuRyBPKduq/eTstITegOFI/PZ1gRBzEYR9uE/2Z1FHZcPuHPbD2+DZPXdVUjptTQrKCHDXDrg62LuAmZ2qfuYZt+GInxZuRpstOT7oebkrC51hGgwDkSz55pXt55aaeGl81oA9E1KHW2vy/2ukD7R8wVW3lUpckQX4Q6nuCXv51wrjKdf64dqLtTbDQ0vahm051q9W2KXRr5RAgZwCN2SUVUywuav9eEwMuvlep9IckRa8djx2WhREb9jhuKJGoV+t1CuC9dzD4NgcpP/kA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M0/gA/aRh0v75FKSpWmXz3xhaFYZG9uDmw9Pw0fq1/w=;
 b=F4QzvJHh4yDnsoHFu6Zr3Gx7C4gbsiA5CKycnLDePeV/btn7eBpqBK94nSm4J1auHmX+d/4EiGipTLR4m/mE+oTaT37tGHoXy9hUkGu7beAGrtenYkoANNRrLOpldUXOAh36J1m63No+COamyWsBIRSbXRpf73a9FxXOccdxQHSwYJiI9zG0VRuWJRV+OkuvvppHRTOtQe4pWTeuZVJabevDTvySIzrawjYsgbGPyW7nPTv57rHHfMe9WMTRqOI0H+Hy9zaMhpoileuiF+q2tj7ZIE7rsO6miJVTQWLTby4KADsRG8crKQl97iFzgYnt21bThy7KizjtIDH8IYtuYw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PA4PR04MB9366.eurprd04.prod.outlook.com (2603:10a6:102:2a9::8)
 by GVXPR04MB10684.eurprd04.prod.outlook.com (2603:10a6:150:218::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.18; Mon, 9 Feb
 2026 16:05:18 +0000
Received: from PA4PR04MB9366.eurprd04.prod.outlook.com
 ([fe80::75e4:8143:ddbc:6588]) by PA4PR04MB9366.eurprd04.prod.outlook.com
 ([fe80::75e4:8143:ddbc:6588%6]) with mapi id 15.20.9587.010; Mon, 9 Feb 2026
 16:05:14 +0000
Date: Mon, 9 Feb 2026 11:05:04 -0500
From: Frank Li <Frank.li@nxp.com>
To: Koichiro Den <den@valinux.co.jp>
Cc: vkoul@kernel.org, mani@kernel.org, cassel@kernel.org,
	jingoohan1@gmail.com, lpieralisi@kernel.org, kwilczynski@kernel.org,
	robh@kernel.org, bhelgaas@google.com, kishon@kernel.org,
	jdmason@kudzu.us, allenbh@gmail.com, dmaengine@vger.kernel.org,
	linux-pci@vger.kernel.org, ntb@lists.linux.dev,
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 1/8] dmaengine: dw-edma: Deassert emulated interrupts
 in the IRQ handler
Message-ID: <aYoFsMclytqtkc9N@lizhi-Precision-Tower-5810>
References: <20260209125316.2132589-1-den@valinux.co.jp>
 <20260209125316.2132589-2-den@valinux.co.jp>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260209125316.2132589-2-den@valinux.co.jp>
X-ClientProxiedBy: BYAPR11CA0037.namprd11.prod.outlook.com
 (2603:10b6:a03:80::14) To PA4PR04MB9366.eurprd04.prod.outlook.com
 (2603:10a6:102:2a9::8)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR04MB9366:EE_|GVXPR04MB10684:EE_
X-MS-Office365-Filtering-Correlation-Id: d82ab92a-468c-47d0-dd4c-08de67f502d3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|19092799006|52116014|7416014|376014|7053199007|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?veTRQFdLH8PAzysCDwqr6Q1UQp/Me6N7ILNyXu8XtO3yeBOV3c6Ynt7RzJOH?=
 =?us-ascii?Q?G3Ev94SLkuViEEQn8twiIiwsUs6qwIBCdTKy/pLSqa+A+rnoE1J/LIAuUFnc?=
 =?us-ascii?Q?UNhy3XjIQPJTYFXETKZECK7ztGXN4o5cEzILsfhT0s27kaKhdzK99hYr88w6?=
 =?us-ascii?Q?gGndxmxOVZTwMLNiIcO8pwWOpOwEw0kH0lJQ9tKnMcpUrVq3ZgTDlbMYRj87?=
 =?us-ascii?Q?6HIc6WnROM4INIFq/Ys/IgZbX5gfNfHd52c1omRINFBzmdLvYAa3WRlJ5eIG?=
 =?us-ascii?Q?XdnN8fjb5sIMu9uwa3vBJchm4GQfEUfnhmgrvQOMWH8U3l9vXpU7KePIr590?=
 =?us-ascii?Q?+zWYZpOcvVhOZIdFenp4upM4XZm7UuCFkHSpm5ZejvuITeXC9i8KRDY9DvhL?=
 =?us-ascii?Q?WJyYfI0KZNdADyN22a6QkETdHlO75246cuQ3dBDr6Rlzyow6pgwgDMYKbO+L?=
 =?us-ascii?Q?JBu1YmAHdmX1xU9RUPfM+vdzcPv29tniLRSJfNOonoHeRmbFU7AD62g61E7L?=
 =?us-ascii?Q?o/xC7JW76J1fctheSFuBclCAInttA8HIA5MUOg2vseAvsxQTpwSRCel7ZTjL?=
 =?us-ascii?Q?kQGFGRQ1pRdRNy1ksdoTP0zwaW16kOL+3KzDvMttiGji8u5YvzQ9vQZYnm2g?=
 =?us-ascii?Q?hrD136srIVCw0XfIKS0HFW9VdtODJQs/cdXzkdmblwqW0I2U5iiK37c8nf6N?=
 =?us-ascii?Q?Wpijm59F8LxOy44B3632YnBQIqcVlqTups0uVr0p86rju2doH8nRskJOSTMR?=
 =?us-ascii?Q?jleyu6+mIWo1Kldg1RYiFmNZpIbFmquYVeMVcGgzowYEL147rk1zQ9D94yPd?=
 =?us-ascii?Q?JPRcKe1fIY9ujJSiuA5o8PHV8RlUub7f7A9OZFT2hZgXDmwk4YkbJxnCwwDo?=
 =?us-ascii?Q?/aC+kTG3zmtMuvfECjY2U3FSXrdkR4sZaX1jldOPsXnLgiQEXo985c8fbbwm?=
 =?us-ascii?Q?uf6/2xluaJF6tcNZbHln4H2z2RbZz6fNrmADxYCcqozU499sckad6apZjCgJ?=
 =?us-ascii?Q?w0tMAdW3oarz6IMbpip/2KAJ9vqw5Ul2IdZmwPFNw13aoFfUcJ89xSR/n/Tg?=
 =?us-ascii?Q?oBXMznigd3/Ybhy4es7dxrIwMiCPT9VPAsW47DTUgl2wJXVaq/taWzjIZtXi?=
 =?us-ascii?Q?JvkX88o3h5Df+bGlAc6Cjju+PNBLOP30t8/OLCyEGFsOSXZzw5QGBMekV5QD?=
 =?us-ascii?Q?FTFw9lVuFvVb6rvVs8jC1gVA6lVjT2NQRVgm9W5RPuMMcEQg3nRVdRpTKH4v?=
 =?us-ascii?Q?XGw1iUHJmkCSWApEZ1OUUiPFxNfaVil+Oc/MDFdPPuN2ECHWsE5bcMVN2xP/?=
 =?us-ascii?Q?52hIjj0bjXvVaItvng/1C3w5NiUiUu2gCj+n6cxcw8KPQZTOxeRiyx9rHM9h?=
 =?us-ascii?Q?rVsSExPjJ9Z3hYLBuUiuDm7i8821aVEuzsLRqv+TGJM0ECB+F36BvVrXeXLZ?=
 =?us-ascii?Q?MhkNmSFAF0/q1M8gguhDH7s/vjpVnWsER+IMU7csE6oLgI8qWUJ8xivsqxyC?=
 =?us-ascii?Q?p6Kwi6y5S9NuuC70gfIh7GbOudxCKVbCXbDrNRi2V7PGxGssUhiNc1q8gTO7?=
 =?us-ascii?Q?oVVfJZSndHbbtPp+nd32lgtg1gXExj3XuQH5e48ntDwFB2UMTIZAUabcKxXQ?=
 =?us-ascii?Q?UQHzlBoBg5RRIP9FhkcFUPo=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB9366.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(19092799006)(52116014)(7416014)(376014)(7053199007)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?LnLl1Sl7dEzZxjqvEGHxXXtsn9FJKMUlNbQjye1w1w1vm20vcWLSX4Lpv3hc?=
 =?us-ascii?Q?iBWbtERBwhGemiQAUicdY7wZ//qtuLAu3MYC/DvMgFFiWTqbJ88akLdMcifT?=
 =?us-ascii?Q?Iam+4QGQzuqYvqMvk+Iw76JMELXKVbAD94i0VBtC6VdOxcRp6DIOBCaUFhjs?=
 =?us-ascii?Q?n04ENBu4MFif0uZDPP7YRg77oqizNTBGAIeqPEM1ONTJiaLZna8NOFy9jXKW?=
 =?us-ascii?Q?hQMUbJkGGOF311DBoDVcqGja13ODrnsrLjrPhfKsmPDl5P0t/iUy2/KE2Y+A?=
 =?us-ascii?Q?FrX6dlRCiNHc6t6YxoyzF078plYqE/nPRRAkPLn0UVUyxU4et8WPqBA1tGKw?=
 =?us-ascii?Q?nQR74XoaAmIanQxtkuX50gefKVIBBizkfgfnWgXj+vxQ29fQ+gdW1rEtUt9O?=
 =?us-ascii?Q?/0KMqeHJwW3IrPCyW4Ap5SzDpR5t+FsreP6vny3TPbaq6m463oZQekTXue5p?=
 =?us-ascii?Q?MZpe72N6X3NTJ2y0Osr4UTHBmo5s5T4qgMsEBAi8iJXb+tvqV65WW7DjuOB4?=
 =?us-ascii?Q?LgwvvVxaNBn3u40Arllf2Zuz5nTfLhKpCS4SaVekd4Nh8dkEPBqv4dEkXQ0+?=
 =?us-ascii?Q?1iC1jx4FNBxiJggOoGkSzPs3TqOAUENvE26810W3hcx8YoBdF8jlYOGyMOVI?=
 =?us-ascii?Q?B4Txe1qMKueRpfmjPq3xute2JR6dmxsFe+t33QFl9iGMvhLcIn/5MJBb7pdG?=
 =?us-ascii?Q?5CNK0vk6pipfyJueaf34vfJIxA2mFvRFoP/RyZwmRQOsGuYqyLn83l+x9UDv?=
 =?us-ascii?Q?bn3Y/9kWARBk4tVBJMYjI3s3o/92azhz5xURFcYHdIu8X2GF+HC2KUverwko?=
 =?us-ascii?Q?JfdbySIW16AAS9R6u1IVW3QGxgb3UID1YaqXPKffqFa8cL3yUA7pSTHvOBON?=
 =?us-ascii?Q?OlgRMWwjBp8+6ISzDI50ce61iqr5EIyoKqUi0ijgTX1ojftNk7taVetRYLd6?=
 =?us-ascii?Q?DljRAJOvwSMBpPDWqvOQwfNmxXbP8ma6+u6t1nVMYVYoBq89NIeuk2oXS+qO?=
 =?us-ascii?Q?LE+SAQBgleZrRdz08eMLUgdpwxh8LktxacVakRR8rUM2SIOeFUdN20Q7QlNt?=
 =?us-ascii?Q?cU1tWxciIVYm7RyaD/J5dPA6iseU/HOtlMDUEx9rfM5NPX2tsr+RZWd4tK20?=
 =?us-ascii?Q?BXiAz/QUeuTC3CGb8e/uvddTxEYCgAaph1mxeMkpkNby7r/EXkzd8hrHFNJP?=
 =?us-ascii?Q?eZE+SplY+kO6v6VVxunoy4C2HxYxgBKxF+OX9oqj4YjGORpIAK5BdVlDe8NB?=
 =?us-ascii?Q?g60p2RJYkv0KaBWmGwb+xEuPlDPK2t0IsASi1u/uBC2YdwT2onQHQqBVrHeZ?=
 =?us-ascii?Q?BAa89L7PrjhU+QtFaagmDSmVn7NzmqjipjftKkU0rWgRxLiQtqRwJrBy+ApR?=
 =?us-ascii?Q?fNkH63KK8QnQQhilAYaRoZDdz1qaonl6dHdXV0f3KrqYzwLezdgaPTsZKULS?=
 =?us-ascii?Q?VLQCuEzz89OD51KbtEYCNiakjvviaDCe1ibgvf+LuF7E80UsW+QWPRQtXQAB?=
 =?us-ascii?Q?Y9pBBeOMCpWt7EKImNGC004jZeELKDQx0Eoqgrrhw80nwnswZu5i1PX5AcBI?=
 =?us-ascii?Q?90Nhp3N0py199NuKsO5KugmAKAED/tHr5Ib9PeqjUWJ6ljjn57cndVZGSWlS?=
 =?us-ascii?Q?WXnLB8+F/6mlfPlm1w0dBANMo4EZ16vHpL5IvKThfRSEOp37QOUaculRsIxA?=
 =?us-ascii?Q?IYxD/BhXEQfrx3OTlb++HTJ5oTA3WMXgH48PWj6MN+hycWApxxxJ1Yn2p/EZ?=
 =?us-ascii?Q?X1WcuKyMcw=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d82ab92a-468c-47d0-dd4c-08de67f502d3
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB9366.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Feb 2026 16:05:14.7041
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BMhZk4ZvnYZQ4rKlP3Bj2q7PgMflY7K2wBmJ5cfIHdhIM+bSGGC46vAeGIBcXsLsvG2i2Hw0q8rgU9/kj+N+7g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB10684
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nxp.com,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[nxp.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-8852-lists,dmaengine=lfdr.de];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[17];
	FREEMAIL_CC(0.00)[kernel.org,gmail.com,google.com,kudzu.us,vger.kernel.org,lists.linux.dev];
	DKIM_TRACE(0.00)[nxp.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[Frank.li@nxp.com,dmaengine@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TAGGED_RCPT(0.00)[dmaengine];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,nxp.com:email,nxp.com:dkim]
X-Rspamd-Queue-Id: 9EF9F1124D9
X-Rspamd-Action: no action

On Mon, Feb 09, 2026 at 09:53:09PM +0900, Koichiro Den wrote:
> Some DesignWare eDMA instances support "interrupt emulation", where a
> software write can assert the IRQ line without setting the normal
> DONE/ABORT status bits.
>
> With a shared IRQ handler the driver cannot reliably distinguish an
> emulated interrupt from a real one by only looking at DONE/ABORT status
> bits. Leaving the emulated IRQ asserted may leave a level-triggered IRQ
> line permanently asserted.
>
> Add a core callback, .ack_emulated_irq(), to perform the core-specific
> deassert sequence and call it from the read/write/common IRQ handlers.
> Note that previously a direct software write could assert the emulated
> IRQ without DMA activity, leading to the interrupt never getting
> deasserted. This patch resolves it.
>
> For v0, a zero write to INT_CLEAR deasserts the emulated IRQ and is a
> no-op for real interrupts. HDMA is not tested or verified and is
> therefore unsupported for now.
>
> Signed-off-by: Koichiro Den <den@valinux.co.jp>
> ---

Reviewed-by: Frank Li <Frank.Li@nxp.com>

>  drivers/dma/dw-edma/dw-edma-core.c    | 48 ++++++++++++++++++++++++---
>  drivers/dma/dw-edma/dw-edma-core.h    | 10 ++++++
>  drivers/dma/dw-edma/dw-edma-v0-core.c | 11 ++++++
>  3 files changed, 64 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/dma/dw-edma/dw-edma-core.c b/drivers/dma/dw-edma/dw-edma-core.c
> index 8e5f7defa6b6..fe131abf1ca3 100644
> --- a/drivers/dma/dw-edma/dw-edma-core.c
> +++ b/drivers/dma/dw-edma/dw-edma-core.c
> @@ -663,7 +663,24 @@ static void dw_edma_abort_interrupt(struct dw_edma_chan *chan)
>  	chan->status = EDMA_ST_IDLE;
>  }
>
> -static inline irqreturn_t dw_edma_interrupt_write(int irq, void *data)
> +static inline irqreturn_t dw_edma_interrupt_emulated(void *data)
> +{
> +	struct dw_edma_irq *dw_irq = data;
> +	struct dw_edma *dw = dw_irq->dw;
> +
> +	/*
> +	 * Interrupt emulation may assert the IRQ line without updating the
> +	 * normal DONE/ABORT status bits. With a shared IRQ handler we
> +	 * cannot reliably detect such events by status registers alone, so
> +	 * always perform the core-specific deassert sequence.
> +	 */
> +	if (dw_edma_core_ack_emulated_irq(dw))
> +		return IRQ_NONE;
> +
> +	return IRQ_HANDLED;
> +}
> +
> +static inline irqreturn_t dw_edma_interrupt_write_inner(int irq, void *data)
>  {
>  	struct dw_edma_irq *dw_irq = data;
>
> @@ -672,7 +689,7 @@ static inline irqreturn_t dw_edma_interrupt_write(int irq, void *data)
>  				       dw_edma_abort_interrupt);
>  }
>
> -static inline irqreturn_t dw_edma_interrupt_read(int irq, void *data)
> +static inline irqreturn_t dw_edma_interrupt_read_inner(int irq, void *data)
>  {
>  	struct dw_edma_irq *dw_irq = data;
>
> @@ -681,12 +698,33 @@ static inline irqreturn_t dw_edma_interrupt_read(int irq, void *data)
>  				       dw_edma_abort_interrupt);
>  }
>
> -static irqreturn_t dw_edma_interrupt_common(int irq, void *data)
> +static inline irqreturn_t dw_edma_interrupt_write(int irq, void *data)
> +{
> +	irqreturn_t ret = IRQ_NONE;
> +
> +	ret |= dw_edma_interrupt_write_inner(irq, data);
> +	ret |= dw_edma_interrupt_emulated(data);
> +
> +	return ret;
> +}
> +
> +static inline irqreturn_t dw_edma_interrupt_read(int irq, void *data)
> +{
> +	irqreturn_t ret = IRQ_NONE;
> +
> +	ret |= dw_edma_interrupt_read_inner(irq, data);
> +	ret |= dw_edma_interrupt_emulated(data);
> +
> +	return ret;
> +}
> +
> +static inline irqreturn_t dw_edma_interrupt_common(int irq, void *data)
>  {
>  	irqreturn_t ret = IRQ_NONE;
>
> -	ret |= dw_edma_interrupt_write(irq, data);
> -	ret |= dw_edma_interrupt_read(irq, data);
> +	ret |= dw_edma_interrupt_write_inner(irq, data);
> +	ret |= dw_edma_interrupt_read_inner(irq, data);
> +	ret |= dw_edma_interrupt_emulated(data);
>
>  	return ret;
>  }
> diff --git a/drivers/dma/dw-edma/dw-edma-core.h b/drivers/dma/dw-edma/dw-edma-core.h
> index 71894b9e0b15..50b87b63b581 100644
> --- a/drivers/dma/dw-edma/dw-edma-core.h
> +++ b/drivers/dma/dw-edma/dw-edma-core.h
> @@ -126,6 +126,7 @@ struct dw_edma_core_ops {
>  	void (*start)(struct dw_edma_chunk *chunk, bool first);
>  	void (*ch_config)(struct dw_edma_chan *chan);
>  	void (*debugfs_on)(struct dw_edma *dw);
> +	void (*ack_emulated_irq)(struct dw_edma *dw);
>  };
>
>  struct dw_edma_sg {
> @@ -206,4 +207,13 @@ void dw_edma_core_debugfs_on(struct dw_edma *dw)
>  	dw->core->debugfs_on(dw);
>  }
>
> +static inline int dw_edma_core_ack_emulated_irq(struct dw_edma *dw)
> +{
> +	if (!dw->core->ack_emulated_irq)
> +		return -EOPNOTSUPP;
> +
> +	dw->core->ack_emulated_irq(dw);
> +	return 0;
> +}
> +
>  #endif /* _DW_EDMA_CORE_H */
> diff --git a/drivers/dma/dw-edma/dw-edma-v0-core.c b/drivers/dma/dw-edma/dw-edma-v0-core.c
> index b75fdaffad9a..82b9c063c10f 100644
> --- a/drivers/dma/dw-edma/dw-edma-v0-core.c
> +++ b/drivers/dma/dw-edma/dw-edma-v0-core.c
> @@ -509,6 +509,16 @@ static void dw_edma_v0_core_debugfs_on(struct dw_edma *dw)
>  	dw_edma_v0_debugfs_on(dw);
>  }
>
> +static void dw_edma_v0_core_ack_emulated_irq(struct dw_edma *dw)
> +{
> +	/*
> +	 * Interrupt emulation may assert the IRQ without setting
> +	 * DONE/ABORT status bits. A zero write to INT_CLEAR deasserts the
> +	 * emulated IRQ, while being a no-op for real interrupts.
> +	 */
> +	SET_BOTH_32(dw, int_clear, 0);
> +}
> +
>  static const struct dw_edma_core_ops dw_edma_v0_core = {
>  	.off = dw_edma_v0_core_off,
>  	.ch_count = dw_edma_v0_core_ch_count,
> @@ -517,6 +527,7 @@ static const struct dw_edma_core_ops dw_edma_v0_core = {
>  	.start = dw_edma_v0_core_start,
>  	.ch_config = dw_edma_v0_core_ch_config,
>  	.debugfs_on = dw_edma_v0_core_debugfs_on,
> +	.ack_emulated_irq = dw_edma_v0_core_ack_emulated_irq,
>  };
>
>  void dw_edma_v0_core_register(struct dw_edma *dw)
> --
> 2.51.0
>

