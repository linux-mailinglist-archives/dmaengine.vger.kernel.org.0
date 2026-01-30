Return-Path: <dmaengine+bounces-8615-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id INl6DkjJfGnaOgIAu9opvQ
	(envelope-from <dmaengine+bounces-8615-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Fri, 30 Jan 2026 16:07:52 +0100
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 844E1BBDF0
	for <lists+dmaengine@lfdr.de>; Fri, 30 Jan 2026 16:07:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 04AFF300E73E
	for <lists+dmaengine@lfdr.de>; Fri, 30 Jan 2026 15:07:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78BBC314A83;
	Fri, 30 Jan 2026 15:07:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="MkaH8CCX"
X-Original-To: dmaengine@vger.kernel.org
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010029.outbound.protection.outlook.com [52.101.69.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70C1E155A5D;
	Fri, 30 Jan 2026 15:07:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.29
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769785637; cv=fail; b=Lp+ZhW9x6nr2V+JQHjwqR0gGl1qxL57UTBzKKrAwezoLMZqdyZZcy/K394t9Xy9r5ZTIV7u6TNKv7VquXXlxfNOnCPT/ACrhGtKQh0CSwI5mbPJHaSAI5NXfrxXtOPfCmzdWRfYGRXUbaPa++lU9X8tRKVKkVb/8L6LVZV6LkQg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769785637; c=relaxed/simple;
	bh=Z44jbM9F4J08VzlWBs+vuyGQO0F4A1Dtc8XzopJXXPQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=dQ4boxjhltNGK9F4gKESILAS69zhOw5BJLJ2u8eJ4YR46ES+Z4NYKosTCUowByYhfjM+IEtTRQomXltPhTEflfukYuhX6jMnl+55KMndaxTc2Eqo4thINg8o+bdcdDtEAYhvPoMb/xj54Tk3IuqVwqIFp4TNJFYtBWlDJb/xdmE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=MkaH8CCX; arc=fail smtp.client-ip=52.101.69.29
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HvtzQpGaJ/octkl3201vm3RM0pZ1vzIOaSfJkMveahelbPN/h6WOpD4yfXKeFa83JAmG0mA90V8TAERfBy/eTq7Iv83RF22tDwsrBh1YTYg8AtZ/WyhHNz3Jm4cXCNcmrGGK6o7zvgzE9MljHuM9bZjkAWRlnkEqJo8fE0kmcRPHaNXVF2z6mz32JSRHhBYol2Rl+lhOfQQR6hXRxjQYMej0sbGkvPyPY2H+FahF3MXkuupYJbj8oE6Wy5imZhVBvbvvRR22PqEcftvecxPWgFT8iHnPe+pAjmwZVnTVVCx8HcKjPkR8Yfw/RcmX23psmn0xzANp70PR5wAktUUdVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XjN42SQDhzUZ1gApfa/htdozNBHHNMukXm7obLonGRE=;
 b=YRJK/BhMUJwa9h9glRrr7Rv1LTekAMo4odArSimljS4+UuY+i0CgM1DxUv6ydaCMkG9fCNqXlBR9g1piDvptmPZ0o03ZaFbM28itSo5a9g/h1f8lZDh01JNmuGChciZ0thbyO5gYiTx8I2OpPVRjCngt6sDf4WByCOnZp35C6Jp8awEDflhT2CSS0Wo82xbuVzfUFrSZ6MrfKV287IV0YagHea+BG9UEu2GvHQShrNsWA3eVV8LbF0KHC9BkemMft4fjlEPgvNOeIjmmoug/6POnP5mtOrSqIkwMX2y63/VHOFRz0z4BuQYZ5ACqcz7Pcooo3DUACcY2lW7PZ8uIfg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XjN42SQDhzUZ1gApfa/htdozNBHHNMukXm7obLonGRE=;
 b=MkaH8CCX7tIS9Naas4T4Kc/K6ILqSVRRhovl1juq9ratDN4FXzDt7Ki66kmLhaV81AsAZFSzVHpycVfVClJmrAAtK1v7qVPcsfLMmaJorg5HUZyHEH60uLOTn8glWIQ3uJGDe4Yll5dZi9XTta0WFpJNMH4lyp4XW9/2sQZiqhlRM+3HYNiywbXQbjO1dujl7wQqsUao23UFEM5zvIkVE61TSPcx1I6Jdb/Kcoc/x9Ufx5MzMwJFs56I8RFr2fcxv5Ew265S4Eenq/Xs4fRJzdMAv75g+vieLB7nn7QNXwb5lOKQKCwsBct5AwHmrDC5oNs/XvfNvaVQ2Hl4BY/H3A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PA4PR04MB9366.eurprd04.prod.outlook.com (2603:10a6:102:2a9::8)
 by PA2PR04MB10160.eurprd04.prod.outlook.com (2603:10a6:102:407::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.15; Fri, 30 Jan
 2026 15:07:12 +0000
Received: from PA4PR04MB9366.eurprd04.prod.outlook.com
 ([fe80::75e4:8143:ddbc:6588]) by PA4PR04MB9366.eurprd04.prod.outlook.com
 ([fe80::75e4:8143:ddbc:6588%6]) with mapi id 15.20.9564.010; Fri, 30 Jan 2026
 15:07:11 +0000
Date: Fri, 30 Jan 2026 10:07:02 -0500
From: Frank Li <Frank.li@nxp.com>
To: Koichiro Den <den@valinux.co.jp>
Cc: mani@kernel.org, vkoul@kernel.org, jingoohan1@gmail.com,
	lpieralisi@kernel.org, kwilczynski@kernel.org, robh@kernel.org,
	bhelgaas@google.com, dmaengine@vger.kernel.org,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 7/7] PCI: dwc: Add helper to query integrated dw-edma
 linked-list region
Message-ID: <aXzJFhcYCqTE5ma9@lizhi-Precision-Tower-5810>
References: <20260127033420.3460579-1-den@valinux.co.jp>
 <20260127033420.3460579-8-den@valinux.co.jp>
 <aXovtOcilRrkA0Ot@lizhi-Precision-Tower-5810>
 <dpx4s35dqvhp54sloixxsn3qcf3g2k745wieaefdc2svgkbtr6@4vuqgp46czi7>
 <aXrXJbjKiAFXaxOX@lizhi-Precision-Tower-5810>
 <zqcu3awadvqbtil3vudcmgjyjpku7divrhqyox72k43nfzcoo7@hflaengfjy27>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <zqcu3awadvqbtil3vudcmgjyjpku7divrhqyox72k43nfzcoo7@hflaengfjy27>
X-ClientProxiedBy: BYAPR02CA0029.namprd02.prod.outlook.com
 (2603:10b6:a02:ee::42) To PA4PR04MB9366.eurprd04.prod.outlook.com
 (2603:10a6:102:2a9::8)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR04MB9366:EE_|PA2PR04MB10160:EE_
X-MS-Office365-Filtering-Correlation-Id: 914d4bc8-1ed6-44c0-b8f1-08de60113e47
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|52116014|7416014|376014|366016|1800799024|38350700014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?tWiSITE0PjFKCJqecZSYJiZfpro6gJguDVvEKpVouVOfL//nft1RZaIvxDUc?=
 =?us-ascii?Q?1xLDz9a1OYGcTJSnMLgnGiYAhnZeWSbvMxMe/oXn/OeP/zF76RlHe6sbLt04?=
 =?us-ascii?Q?7IS2t2WQKE9dVyBJ/Dw7Q0852Y9vr41bgayqmaCqFjCtaTuibx+/zDfMRUMe?=
 =?us-ascii?Q?LkF30eORl4yA/dJTgcvkJD1NlZMqHi5fVtnZL2SLyPWYWZ9lG2RC4OMJlBwi?=
 =?us-ascii?Q?Oef+YYe3j8Fu9UEeUO/desvgmBRJR+J5Ty9bbNSR781eBfayEegRigvfoPZ8?=
 =?us-ascii?Q?KFO+f9/tZN4R7XMc18837ujR4NBNK97340J4kKqG8og6Rwdrhwy5C8p5DS+q?=
 =?us-ascii?Q?4T+WhvEgdKwwuDsIat6fGxUkPetrA1Ot6E82ECvm5VBj+eufKeiDxx9+Ag1X?=
 =?us-ascii?Q?1pr0LJ1bOmakjAodnB1gNMufaBE1dxKtrSx+qgouzIMyK7iMURCoSC/dLk/I?=
 =?us-ascii?Q?GQP4CY0oYC1SofndO+psASd7ycwijkTF21CSkL9JEj3R6DT6DmtjDmixb4C/?=
 =?us-ascii?Q?HsRHCwO5iEXxMXEqY/uo8dc+kfAfhsFtX5ukjhizr+l6ZzM6uQIajGpfZOWl?=
 =?us-ascii?Q?Ai4tdDyrFJPAOymnSsOEk+JBsXHzVKM6rXZZXVA9xGNS/jhM33c0I2x254xY?=
 =?us-ascii?Q?nTyM+/Ebx4aKQM48ACQH5zWSKTuleEtdP94g2SCTUzi8MUBOhCx5RX0mIS/8?=
 =?us-ascii?Q?jLF6dQBjT8Q3jmoxkvILM1+0CW+T3jY80GiERuIlHnU+rQQUqilVyHBJD2I0?=
 =?us-ascii?Q?kpfmUpiP5w/FmNYn+xpvSYd9um8KR2DUKeO3cUofV5GEwQ+hkjqYeR2jcM5j?=
 =?us-ascii?Q?lnK+8GQQNDsusQXWE4P51PYqUtCVBTgDiTEA9BC4KlV02+fd4a+O10Mvi1Jk?=
 =?us-ascii?Q?car66r9fuZzKadSU1iK2sH0OpwdM5JFx+BTq3uCggKfSIhIGJZN1P/5JAPX3?=
 =?us-ascii?Q?VtYwAbAVOljbx89Lva8SRpgFh5u4+bJWApEN+5AglcC729WAFTeAEBO9mpox?=
 =?us-ascii?Q?hNk7qtySNWSN87uWUoh+iOOEkDxfG/OzfgfGmHF/afUPGMv/vhS4FM9QJYiU?=
 =?us-ascii?Q?IlX97j/XaVZVGn5XQ0paY3aIXPU83om6ej/4I/0g16XTRiPbKuMDp5J5uQJP?=
 =?us-ascii?Q?q3kfHf7NzEwZYIhOnRy4j5Mr8hER90pHiM9IjAHE21x9b4FjcCkK604EuFfG?=
 =?us-ascii?Q?jWRl00mpiR75nQMBdLroALCUKtsTvokV9Itq1RBbfiSobi9FX4lvdG+o59nJ?=
 =?us-ascii?Q?hfz2NjoMk/WP0jogvGB7RDUUOUeqSz+cUB1+Rh5jnyBo3l+9ohmkzvZC6+aN?=
 =?us-ascii?Q?4B6/WumSrk4P8hajFCFf/19Usb1VmHw54ZBg/coYM76pzseeVHMfatKZHgIV?=
 =?us-ascii?Q?iDxPJJryMIY6xQFUoZltyrs4F8MGUbkMmeqUGM4535mwxF9WpQaKF0N9b4iC?=
 =?us-ascii?Q?P5Q2+jwrOqAn5t9ZtPujNNL4ne+viI25NEWH/3MzWm/P/pSLXmmFzp3het0e?=
 =?us-ascii?Q?I+gHC8KwL2R/fWmDfzu27QIeKTNvVV44Q35LBhW+BN8V75ZHjYDJzzYbRwVC?=
 =?us-ascii?Q?sHDVrailUUuSNjyDZeFoydY99HiPIUydFmPmY8aIGrWVKLbRbZth0DOkhgwv?=
 =?us-ascii?Q?jUfuVpskisfGh+0Qt6wbqTw=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB9366.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(52116014)(7416014)(376014)(366016)(1800799024)(38350700014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?3Lvdl2pzTSltjcxevPm3p7jSGMqsxFy4rjWlvSOZ7m8OGXE6KSXzrSltwSF/?=
 =?us-ascii?Q?7NjWTNM4uwKpBFg9cEkVqlscqLIrvmoOkHKyMEqedz2m5rVbRowE7vTkDHDx?=
 =?us-ascii?Q?xZfs4o4VTOcMafu4hs5UtTJbX6yNEKDZDMV0wrbhH1wNFpeMYdUDd2gsEvZN?=
 =?us-ascii?Q?AVx/y/PRl+uy0s7eHLmVSHQSHcdjrsQYVUBVB2qnH3ODN6lEvw/x0QPEsoIz?=
 =?us-ascii?Q?7dGU3m3z7BfAhjBSWwxVp869+k0a1/AhtirFPoIyreIdpa0jEIlbU4syZGTp?=
 =?us-ascii?Q?x82Gt0lbiM65Z1RaFQp8LNPLa0R5dUM/xGoMPMrggrROOU6K/2g+rPNt9cod?=
 =?us-ascii?Q?2cBYu5npYnvDcsUqbGd89WzgWT3X0UWN5xHXoVX4RW2RZ0UCwI988ZEYhYsn?=
 =?us-ascii?Q?QwPFyVSTgSJtfLC82Otl7EyNHNmBvDJfFUxx5rzaMxZO4nDQaXvvlCsJKeTp?=
 =?us-ascii?Q?29eKgwAHL4sN6FR8BcWL08a9n/K8M+H7Zz5sKN2ZMWgZho2r2h5A40ZMoTAw?=
 =?us-ascii?Q?UP5RbAL4PcTYFPRtmmEITFvkniLcUQZ7pcxnFg4gzqceOheo2S12PjhC8EaI?=
 =?us-ascii?Q?O+3juGBGA5wcPEw85kA6HLSWHLIXZ2oMPVWKMa9gZ6tEnRqEA9Jt11cRIto+?=
 =?us-ascii?Q?hEtOa90tF+H1n/VZt5+/k9jDw6agPF/0KRxL42KI1tpEQVHSGwBSnRwOLhww?=
 =?us-ascii?Q?+Z1FKaQYbi7o31Hi8Oopxon5knXvH+SmskwHpQ+A0TbkJ9LzwwLQRPmzp+NW?=
 =?us-ascii?Q?E0+QOeb9SgEtOv0pEWa2McazkVG30YlqMn1tBe5Q5Hx+S0CiC2OHhPcQsJHl?=
 =?us-ascii?Q?k8muHwQ3HZutuDTiuSurJQx3L6WSVynwjXsnhmAFZc1Pt4kzk6MpFqwCqbY5?=
 =?us-ascii?Q?iStoMMOVo1e5/f8W9bjR4cUvaOw0KiJxnepuBVZMCkch7Og7vhpOG+ey8FP0?=
 =?us-ascii?Q?JdcOSUTv8Y9LRaM6d4Wn79BGNBNxoyii1e+jz/gj24I2UF8WsldhMybA0azx?=
 =?us-ascii?Q?CwzPXWencM09rsdUNDUIZTIeWUKs29otcBH4/8Rkcdf4CLMkHyTsDrSVpZdM?=
 =?us-ascii?Q?gMxYVYL8lCuoogacJ4J7hdufqDzsA8HWb9oLz+XyJLdwAO/6wh35rkY7dwRQ?=
 =?us-ascii?Q?ZExImAlND6TeRHEUMTjSSBn7cVXZ2UAHFvYSpjhCMsaAix7zT2vvYylRWeMo?=
 =?us-ascii?Q?C1ejCp9y7sSJfQ4zR5YZ/Yo9w/k0FpyWHEG64wuHqs2cbx9dP/8ChLZA5eJh?=
 =?us-ascii?Q?hlG7sRnoB5kA2sg8KqT2PK9Tp338MNTJmRpamJ8MOeneL36XPkcKQBuBeeTV?=
 =?us-ascii?Q?lvHfpyTaSxBrH3vRpgvCRGlBfRjFrYDxIWYI7PPJQRCvoLvbicn3eS8VX0rf?=
 =?us-ascii?Q?k0GeVZybLzGWmCEDPFpI7G6QUspnZM/0oo27Oh031Do6uvnqsCVuuv+MsTTC?=
 =?us-ascii?Q?L8ZWoES0hbckBFcnIDB8EwBtGdiydalFDHX0ujf0DKbYJKPOcAc97vI0AUPv?=
 =?us-ascii?Q?1iJypwICvbcW5Z9v73kboM3xL8qjBKIdCVpHVyUbhzgUlJzXGG1gDsvNizBd?=
 =?us-ascii?Q?9hFV7SvDux+smI4FVOqRONAT2pVlN0NXAUcXCiUH+1yUtKS8u1DJERUrLVzN?=
 =?us-ascii?Q?kLHr5Ik4AS7sud1Ku8UGZebIGyhJG8qJRMtBU5dXjSjYkrlBgZ1o0oLv6M71?=
 =?us-ascii?Q?7yS4nqlG6uYAEcE8elIx7GXO7QHapbjTj9ruOg+lmFZPqgC4?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 914d4bc8-1ed6-44c0-b8f1-08de60113e47
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB9366.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jan 2026 15:07:11.0742
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Hawz3CHfx+9rF0sIEvm9XV9qH+2sa6P1+PudNNSTSUV71gBKnRmbodZDNwVogQcoW5pP7mBW+nlGLLIap20mYA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA2PR04MB10160
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
	FREEMAIL_CC(0.00)[kernel.org,gmail.com,google.com,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-8615-lists,dmaengine=lfdr.de];
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
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[dmaengine];
	RCPT_COUNT_SEVEN(0.00)[11];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[valinux.co.jp:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,nxp.com:dkim]
X-Rspamd-Queue-Id: 844E1BBDF0
X-Rspamd-Action: no action

On Fri, Jan 30, 2026 at 04:16:11PM +0900, Koichiro Den wrote:
> On Wed, Jan 28, 2026 at 10:42:29PM -0500, Frank Li wrote:
> > On Thu, Jan 29, 2026 at 01:25:30AM +0900, Koichiro Den wrote:
> > > On Wed, Jan 28, 2026 at 10:48:04AM -0500, Frank Li wrote:
> > > > On Tue, Jan 27, 2026 at 12:34:20PM +0900, Koichiro Den wrote:
> > > > > Some DesignWare PCIe endpoint controllers integrate a DesignWare eDMA
> > > > > instance and allocate per-channel linked-list (LL) regions. Remote eDMA
> > > > > providers may need to expose those LL regions to the host so it can
> > > > > build descriptors against the remote view.
> > > > >
> > > > > Export dwc_pcie_edma_get_ll_region() to allow higher-level code to query
> > > > > the LL region (base/size) for a given EPC, transfer direction
> > > > > (DMA_DEV_TO_MEM / DMA_MEM_TO_DEV) and hardware channel identifier. The
> > > > > helper maps the request to the appropriate read/write LL region
> > > > > depending on whether the integrated eDMA is the local or the remote
> > > > > view.
> > > > >
> > > > > Signed-off-by: Koichiro Den <den@valinux.co.jp>
> > > > > ---
> > > > >  drivers/pci/controller/dwc/pcie-designware.c | 45 ++++++++++++++++++++
> > > > >  include/linux/pcie-dwc-edma.h                | 33 ++++++++++++++
> > > > >  2 files changed, 78 insertions(+)
> > > > >
> > > > > diff --git a/drivers/pci/controller/dwc/pcie-designware.c b/drivers/pci/controller/dwc/pcie-designware.c
> > > > > index bbaeecce199a..e8617873e832 100644
> > > > > --- a/drivers/pci/controller/dwc/pcie-designware.c
> > > > > +++ b/drivers/pci/controller/dwc/pcie-designware.c
> > > > > @@ -1369,3 +1369,48 @@ int dwc_pcie_edma_get_reg_window(struct pci_epc *epc, phys_addr_t *phys,
> > > > >  	return 0;
> > > > >  }
> > > > >  EXPORT_SYMBOL_GPL(dwc_pcie_edma_get_reg_window);
> > > > > +
> > > > > +int dwc_pcie_edma_get_ll_region(struct pci_epc *epc,
> > > > > +				enum dma_transfer_direction dir, int hw_id,
> > > > > +				struct dw_edma_region *region)
> > > >
> > > > These APIs need an user, A simple method is that add one test case in
> > > > pci-epf-test.
> > >
> > > Thanks for the feedback.
> > >
> > > I'm unsure whether adding DesignWare-specific coverage to pci-epf-test
> > > would be acceptable. I'd appreciate your guidance on the preferred
> > > approach.
> > >
> > > One possible direction I had in mind is to keep pci-epf-test.c generic and
> >
> > Add a EPC/EPF API, so dynatmic check if support DMA region or other feature.
>
> Thank you for the comment.
>
> Ok, I have drafted an API ([1] below).
>
> One thing I'm unsure about is how far the pci-epf-test validation should
> go. Since the API (pci_epc_get_remote_resources() in [1]) is generic and
> only returns a list of (type, phys_addr, size, and type-specific fields), a
> fully end-to-end validation (i.e. "are these resources actually usable from
> the host?") would require controller-specific (DW-eDMA-specific) knowledge
> and also depends on how those resources are exposed (e.g. for a eDMA LL
> region, it may be sufficient to inform the host of EP-local address, while
> the eDMA register block would need to be fully exposed via BAR mapping).
>
> Do you think a "smoke test" would be sufficient for now (e.g. testing
> whether the new API returns a sane / well-formed list of resources),
> or are
> you expecting the test to actually program the DMA eingine from the host?
> Personally, I think the former would suffice, since the latter would be
> very close to re-implementing the real user (e.g. ntb_dw_edma [2]) itself.

Smoke test should be enough now.

Frank
>
> [1]:
>
> diff --git a/include/linux/pci-epc.h b/include/linux/pci-epc.h
> index c021c7af175f..4cb5e634daba 100644
> --- a/include/linux/pci-epc.h
> +++ b/include/linux/pci-epc.h
> @@ -61,6 +61,35 @@ struct pci_epc_map {
>         void __iomem    *virt_addr;
>  };
>
> +/**
> + * enum pci_epc_remote_resource_type - remote resource type identifiers
> + */
> +enum pci_epc_remote_resource_type {
> +       PCI_EPC_RR_DMA_CTRL_MMIO,
> +       PCI_EPC_RR_DMA_CHAN_DESC,
> +};
> +
> +/**
> + * struct pci_epc_remote_resource - a physical resource that can be exposed
> + * @type:      resource type, see enum pci_epc_remote_resource_type
> + * @phys_addr: physical base address of the resource
> + * @size:      size of the resource in bytes
> + * @u:         type-specific metadata
> + */
> +struct pci_epc_remote_resource {
> +       enum pci_epc_remote_resource_type type;
> +       phys_addr_t phys_addr;
> +       size_t size;
> +
> +       union {
> +               /* PCI_EPC_RR_DMA_CHAN_DESC */
> +               struct {
> +                       u16 hw_chan_id;
> +                       bool ep2rc;
> +               } dma_chan_desc;
> +       } u;
> +};
> +
>  /**
>   * struct pci_epc_ops - set of function pointers for performing EPC operations
>   * @write_header: ops to populate configuration space header
> @@ -84,6 +113,8 @@ struct pci_epc_map {
>   * @start: ops to start the PCI link
>   * @stop: ops to stop the PCI link
>   * @get_features: ops to get the features supported by the EPC
> + * @get_remote_resources: ops to retrieve controller-owned resources that can be
> + *                       exposed to the remote host (optional)
>   * @owner: the module owner containing the ops
>   */
>  struct pci_epc_ops {
> @@ -115,6 +146,9 @@ struct pci_epc_ops {
>         void    (*stop)(struct pci_epc *epc);
>         const struct pci_epc_features* (*get_features)(struct pci_epc *epc,
>                                                        u8 func_no, u8 vfunc_no);
> +       int     (*get_remote_resources)(struct pci_epc *epc, u8 func_no, u8 vfunc_no,
> +                                       struct pci_epc_remote_resource *resources,
> +                                       int num_resources);
>         struct module *owner;
>  };
>
> @@ -309,6 +343,9 @@ int pci_epc_start(struct pci_epc *epc);
>  void pci_epc_stop(struct pci_epc *epc);
>  const struct pci_epc_features *pci_epc_get_features(struct pci_epc *epc,
>                                                     u8 func_no, u8 vfunc_no);
> +int pci_epc_get_remote_resources(struct pci_epc *epc, u8 func_no, u8 vfunc_no,
> +                                struct pci_epc_remote_resource *resources,
> +                                int num_resources);
>  enum pci_barno
>  pci_epc_get_first_free_bar(const struct pci_epc_features *epc_features);
>  enum pci_barno pci_epc_get_next_free_bar(const struct pci_epc_features
>
> ---8<---
>
> Notes:
> * The naming ("pci_epc_get_remote_resources") is still TBD, but the intent
>   is to return everything needed to support remote use of an EPC-integraed
>   DMA engine.
> * With this API, [PATCH v2 1/7] and [PATCH v2 2/7] are no longer needed,
>   since API caller does not need to know the low-level DMA channel id
>   (hw_id).
>
> [2] https://lore.kernel.org/all/20260118135440.1958279-26-den@valinux.co.jp/
>
> Thanks for the review,
> Koichiro
>
> >
> > Frank
> >
> > > add an optional DesignWare-specific extension, selected via Kconfig, to
> > > exercise these helpers. Likewise on the host side
> > > (drivers/misc/pci_endpoint_test.c and kselftest pci_endpoint_test.c).
> > >
> > > Koichiro
> > >
> > > >
> > > > Frank
> > > >
> > > > > +{
> > > > > +	struct dw_edma_chip *chip;
> > > > > +	struct dw_pcie_ep *ep;
> > > > > +	struct dw_pcie *pci;
> > > > > +	bool dir_read;
> > > > > +
> > > > > +	if (!epc || !region)
> > > > > +		return -EINVAL;
> > > > > +	if (dir != DMA_DEV_TO_MEM && dir != DMA_MEM_TO_DEV)
> > > > > +		return -EINVAL;
> > > > > +	if (hw_id < 0)
> > > > > +		return -EINVAL;
> > > > > +
> > > > > +	ep = epc_get_drvdata(epc);
> > > > > +	if (!ep)
> > > > > +		return -ENODEV;
> > > > > +
> > > > > +	pci = to_dw_pcie_from_ep(ep);
> > > > > +	chip = &pci->edma;
> > > > > +
> > > > > +	if (!chip->dev)
> > > > > +		return -ENODEV;
> > > > > +
> > > > > +	if (chip->flags & DW_EDMA_CHIP_LOCAL)
> > > > > +		dir_read = (dir == DMA_DEV_TO_MEM);
> > > > > +	else
> > > > > +		dir_read = (dir == DMA_MEM_TO_DEV);
> > > > > +
> > > > > +	if (dir_read) {
> > > > > +		if (hw_id >= chip->ll_rd_cnt)
> > > > > +			return -EINVAL;
> > > > > +		*region = chip->ll_region_rd[hw_id];
> > > > > +	} else {
> > > > > +		if (hw_id >= chip->ll_wr_cnt)
> > > > > +			return -EINVAL;
> > > > > +		*region = chip->ll_region_wr[hw_id];
> > > > > +	}
> > > > > +
> > > > > +	return 0;
> > > > > +}
> > > > > +EXPORT_SYMBOL_GPL(dwc_pcie_edma_get_ll_region);
> > > > > diff --git a/include/linux/pcie-dwc-edma.h b/include/linux/pcie-dwc-edma.h
> > > > > index a5b0595603f4..36afb4df1998 100644
> > > > > --- a/include/linux/pcie-dwc-edma.h
> > > > > +++ b/include/linux/pcie-dwc-edma.h
> > > > > @@ -6,6 +6,8 @@
> > > > >  #ifndef LINUX_PCIE_DWC_EDMA_H
> > > > >  #define LINUX_PCIE_DWC_EDMA_H
> > > > >
> > > > > +#include <linux/dma/edma.h>
> > > > > +#include <linux/dmaengine.h>
> > > > >  #include <linux/errno.h>
> > > > >  #include <linux/kconfig.h>
> > > > >  #include <linux/pci-epc.h>
> > > > > @@ -27,6 +29,29 @@
> > > > >   */
> > > > >  int dwc_pcie_edma_get_reg_window(struct pci_epc *epc, phys_addr_t *phys,
> > > > >  				 resource_size_t *sz);
> > > > > +
> > > > > +/**
> > > > > + * dwc_pcie_edma_get_ll_region() - get linked-list (LL) region for a HW channel
> > > > > + * @epc:    EPC device associated with the integrated eDMA instance
> > > > > + * @dir:    DMA transfer direction (%DMA_DEV_TO_MEM or %DMA_MEM_TO_DEV)
> > > > > + * @hw_id:  hardware channel identifier (equals to dw_edma_chan.id)
> > > > > + * @region: pointer to a region descriptor to fill in
> > > > > + *
> > > > > + * Some integrated DesignWare eDMA instances allocate per-channel linked-list
> > > > > + * (LL) regions for descriptor storage. This helper returns the LL region
> > > > > + * corresponding to @dir and @hw_id.
> > > > > + *
> > > > > + * The mapping between @dir and the underlying eDMA read/write LL region
> > > > > + * depends on whether the integrated eDMA instance represents a local or a
> > > > > + * remote view.
> > > > > + *
> > > > > + * Return: 0 on success, -EINVAL on invalid arguments (including out-of-range
> > > > > + *         @hw_id), or -ENODEV if the integrated eDMA instance is not present
> > > > > + *         or not initialized.
> > > > > + */
> > > > > +int dwc_pcie_edma_get_ll_region(struct pci_epc *epc,
> > > > > +				enum dma_transfer_direction dir, int hw_id,
> > > > > +				struct dw_edma_region *region);
> > > > >  #else
> > > > >  static inline int
> > > > >  dwc_pcie_edma_get_reg_window(struct pci_epc *epc, phys_addr_t *phys,
> > > > > @@ -34,6 +59,14 @@ dwc_pcie_edma_get_reg_window(struct pci_epc *epc, phys_addr_t *phys,
> > > > >  {
> > > > >  	return -ENODEV;
> > > > >  }
> > > > > +
> > > > > +static inline int
> > > > > +dwc_pcie_edma_get_ll_region(struct pci_epc *epc,
> > > > > +			    enum dma_transfer_direction dir, int hw_id,
> > > > > +			    struct dw_edma_region *region)
> > > > > +{
> > > > > +	return -ENODEV;
> > > > > +}
> > > > >  #endif /* CONFIG_PCIE_DW */
> > > > >
> > > > >  #endif /* LINUX_PCIE_DWC_EDMA_H */
> > > > > --
> > > > > 2.51.0
> > > > >

