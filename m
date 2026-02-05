Return-Path: <dmaengine+bounces-8762-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yE9QH2XBhGnG4wMAu9opvQ
	(envelope-from <dmaengine+bounces-8762-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Thu, 05 Feb 2026 17:12:21 +0100
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 15380F50A9
	for <lists+dmaengine@lfdr.de>; Thu, 05 Feb 2026 17:12:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 76E77303A915
	for <lists+dmaengine@lfdr.de>; Thu,  5 Feb 2026 16:06:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C385142314A;
	Thu,  5 Feb 2026 16:06:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="cyRcOgw9"
X-Original-To: dmaengine@vger.kernel.org
Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazon11013003.outbound.protection.outlook.com [52.101.83.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 356F1279DAB;
	Thu,  5 Feb 2026 16:06:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.83.3
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770307562; cv=fail; b=gW6Xm7H2r/zSHaxHuiYsq12i0XR3/MHOEKJ/089XEz3rs1skkjTWiz1ThOISuuraFXJPQvWX8lgQbgLmZAs1SdwEMPFY7DTBSrOMDiBI7HF6DD3W9z1kgyhjdGCtp0l0BqntB+O1HX2Phgr7E8qzTF0s9vT19ZitGf/a7oHcKfI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770307562; c=relaxed/simple;
	bh=+Wv2CjjSnkWd4PW0w/9V20Ol7Spkmgpj/sBTcKAVD6o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Y4TqCyy0svyPFTFG9Ajf1qe+37dAKeQZEkt/0rVgDBG7/bIdsDnvrSJbQR6HVfHEBy9lvbXZmvWZb4zVugWx0bbiftUNCg1qGz3rxKRXotxA8Z5U71ZOZ404U16zh9inM9axKHe/LQfKCg3O+QtMsthgo/F0+t1p+E5WfrS0Qms=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=cyRcOgw9; arc=fail smtp.client-ip=52.101.83.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KTsLXUF8/8obyBWZswOimCgA5oGPmYweH/sLDAQBXbwH2ozhBa0TvUJRqjb2x1Htn4vXfyPd7K3f4LBjGp11DcC0pslSsAwlAtF6s+aL4QhtCL8ZGZiyjujrY6rywNTbDph9RocY42R5EvyeJVKHyfVAEwqLx+HTX2tX/9ktC+f6FzOQe+97na92Ol1NR5XavBMGM8LE3Z8Mt8FpzjDEAe54JckJEPCGildFuJhzjah1FcsiLrbL9U0WIvqXqoT0U9ZBqp/GHDDYxU0lrUFb8rY+cN+Pn6mfdlSeKe2DervsrqVEfEPf9ehfETA5TSA+1IGEyIOhuGC0RAgHLO4bdw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UuSTT2cq/G4LR+krUT8j8O84ZygPPmznG5x3yq2BVOQ=;
 b=AxHUYbu6nwf9K9zjjKJLAK4mFYDSinEoKZ/m42iV8CMVuKao4ufAw9oXR3GcQt4zVau9SydlX+s611MPCNfjApXGYigb4uFCw4LEovyr8a1sTsfMFLyuXc18RZ87shTwvq79dIBT3SY+OTPpAA0i3JMSOElVCmYeaG3u7UealUMJ29zAny8PvMxbXq9ld78Fp51hc1mrW8/gI4psYHMutRjktx/Z4ym89SwPsdCI+xd/ANfb5tHGKtJnKZ2/PJtLbbT5UIw47Gj1oP8R101UR8WFx+vBU4Tr4we3u88l3DrvYNcvpEPTpyqBWG1sdvSmHShoUUSmugc21XfS4dIMwA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UuSTT2cq/G4LR+krUT8j8O84ZygPPmznG5x3yq2BVOQ=;
 b=cyRcOgw984me/Pxovi3+h2RJiGXnQq98tsJ5J/rsQNdeQIasPYCp679mwDbmHM7vAR7hxuALxTUVaPgVIJk6mw3xrfll6tGEDGTBMbMCzTPt2jTkX42srEx0WpkrywpP46lljkKHgtAJ4PvYLx/scUEwjmwZGNZi6kNr3Pm97s3YVP7xLTKClSUHxgaO4LCgEwULXDMG7NEy3STACjZnEq51sKaXLOLw0o81h8DKoBFnfNmouCQEr/xrX7HuPgdOrRQ4xI+9Se4n5wX2l5XY8iqdRg1WB6K7UaZJG+I5e12A+SRZJcqtRjL4Gs/J5UE+7jrjmIQp4MdrYxAjrQzX7g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PA4PR04MB9366.eurprd04.prod.outlook.com (2603:10a6:102:2a9::8)
 by DUZPR04MB9899.eurprd04.prod.outlook.com (2603:10a6:10:4de::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.13; Thu, 5 Feb
 2026 16:05:59 +0000
Received: from PA4PR04MB9366.eurprd04.prod.outlook.com
 ([fe80::75e4:8143:ddbc:6588]) by PA4PR04MB9366.eurprd04.prod.outlook.com
 ([fe80::75e4:8143:ddbc:6588%6]) with mapi id 15.20.9587.010; Thu, 5 Feb 2026
 16:05:59 +0000
Date: Thu, 5 Feb 2026 11:05:52 -0500
From: Frank Li <Frank.li@nxp.com>
To: Koichiro Den <den@valinux.co.jp>
Cc: vkoul@kernel.org, mani@kernel.org, jingoohan1@gmail.com,
	lpieralisi@kernel.org, kwilczynski@kernel.org, robh@kernel.org,
	bhelgaas@google.com, dmaengine@vger.kernel.org,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 03/11] dmaengine: dw-edma: Add per-channel interrupt
 routing control
Message-ID: <aYS_4Axy9Ts7WDDb@lizhi-Precision-Tower-5810>
References: <20260204145440.950609-1-den@valinux.co.jp>
 <20260204145440.950609-4-den@valinux.co.jp>
 <aYOFEe-zyu4ZHTAl@lizhi-Precision-Tower-5810>
 <2akk754wgro2fgs6wradkqtuzu3tfq5klidvy4qhosnk6lbgqs@7c7thld5kqn3>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2akk754wgro2fgs6wradkqtuzu3tfq5klidvy4qhosnk6lbgqs@7c7thld5kqn3>
X-ClientProxiedBy: PH7P220CA0150.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:510:327::13) To PA4PR04MB9366.eurprd04.prod.outlook.com
 (2603:10a6:102:2a9::8)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR04MB9366:EE_|DUZPR04MB9899:EE_
X-MS-Office365-Filtering-Correlation-Id: 90728dee-8049-4eca-f19c-08de64d073dd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|366016|1800799024|52116014|7416014|376014|7053199007|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?9SoFLXycYNUmPj8HcfOnvaXn/bwpOIwMrFJfoc2BkTPKE+L6deWXZtVBwwbg?=
 =?us-ascii?Q?TcBnNqoJdH8Zg5YYF17FPYTLpBfuX/i6DwqE8Vrym2et+jK0O/FweW1d1onk?=
 =?us-ascii?Q?p8Bh4R+pidqnMpNyJlWUG79Wjj/wL21U8yV0xcgwUCvI7lJCR689CZ1F/TZ9?=
 =?us-ascii?Q?8hhH90NclZ5I/RFt2iq/D0ccMROhFHGzzaX2kDqS2IluVw4gf3PQ0eamTvy2?=
 =?us-ascii?Q?SF/fiwFz5W/VFToE4OyMPBMlPcxtgBJERqWCaZA5kWJ28Dxg051f+48laMws?=
 =?us-ascii?Q?N3LMFdPQaBT3QH1Xny/vfILGCpZrJRpykoeCibWKiGQd8C0tOfmtO6H/uuCU?=
 =?us-ascii?Q?jFionoNirqvm0SBeEz9yIB/h1OW0D5UOTIFgLkNcgYUozVwDPS4j0G9tP6HC?=
 =?us-ascii?Q?3nLwv5PjyIHdigNBfOQ/uaIzA7Bdz1VfBXZKqzEWfASxWeEIl5CUJuvIni0a?=
 =?us-ascii?Q?/i/80oZSXv784NzXXAtktWnC+jYrN4Tlr2FLPg0DY5+gKeawFCBJx9FMOcCf?=
 =?us-ascii?Q?qIRBq08pVjI5N3JD6DYjqRnsUu4VyUbkC6lb+oADRr9m87phffBMzmOewYKI?=
 =?us-ascii?Q?sS5qJeuop/8/A06uWFo+r5BhdWi2Xj71/0uQcgo27ufFQKwff1dn1KfiuKaV?=
 =?us-ascii?Q?GYMy+wNA5Wa5sWWWZyUItyl39p/cqDBhm6sbHc+CUUlq1cCnePwIDZe++8Pd?=
 =?us-ascii?Q?On5iNT2ior1q28axpWFcBMm5Q+BnrGwIbHw9zcPlXYKX2/DmzuKB+4SiH2/u?=
 =?us-ascii?Q?aZpYkK/c4rGIE6X969j5hWKMk/ypKjkUjeYfIzTzhGkc5IVIdVptqAez5Zo5?=
 =?us-ascii?Q?U2NrVn1o9uDXk0gSscpVvkZQNNhj57+ybgsgWLiPYbV0bSAWYtHId5yGQs8u?=
 =?us-ascii?Q?3L3lxOQKCm+PaKVnqJybszEscBeSSINrkQADbeRI1zxHDm/W1+UF50ge1zrw?=
 =?us-ascii?Q?+ldfySJ+MoLFwg+nFyw9O5YFils0SKAXlmck+dUuFBV+L8mq4IdhXzkjAF74?=
 =?us-ascii?Q?9801WWyvC5HYDUFxT4l2u/nQmdkYVXFUyyH+z0Yz42EzHqx3hEzf+tY76rko?=
 =?us-ascii?Q?ODbSbv8NFiXbypZ9QasHnNlkcfUAkZesSrOKm62+EPPWSKwS4QufUioEpyTX?=
 =?us-ascii?Q?G/uyJ4BbMMC3rJBdOy6wAlNlFfSg89NmDeNFH3K3s33mie9NQjFncua7Grnd?=
 =?us-ascii?Q?iRcq/astpnkvCuYsgC69Hm67C8I4VnuQRgoZnipq0NQi04svk+ixtN0QwdX9?=
 =?us-ascii?Q?BAmHLWyb0rX6BVLQQmhuviYT6/zO0RyOOOIu6TXxT9MM2P7E9iaZd36ZuWHr?=
 =?us-ascii?Q?wPDK+HT3GjTOm5vkbxOlP9dTn3cpy+2zi5m3plHl90Y0gizqXkXdI9GnXK9f?=
 =?us-ascii?Q?OAuRZMl/pDxJTroGU3g8Ua5a1fuZVSeKMHFgsfbME2C6CT59wDjRK95zGn3I?=
 =?us-ascii?Q?ZA6ot/choRkzoSWWnJ84CLlar58Kza19Zihws7YbELHPuh0XKuHbIMzmFJE0?=
 =?us-ascii?Q?hqLazlb6cw+boJDzW0Emp2/ny3Wi6K1kJ64nEnp7k8Tjj0pj6/ycQtwvRjqV?=
 =?us-ascii?Q?UAiJYSjk9+2z0zeQK4Z5VmPqrXYYqeVDmTv5+YJ0eLYS/bMTMOkfpETK2W/x?=
 =?us-ascii?Q?2l7xuU1llgkhc1d/RudDH6w=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB9366.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(366016)(1800799024)(52116014)(7416014)(376014)(7053199007)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?xYKWzcVqwZF1m99RKbA4R6iNc9oLulVH6hb7ATf0M0EKc3AUJCLojTnuGQE3?=
 =?us-ascii?Q?GSS/85jxQQy2BGFAWUoavOUZjNuS1i/tjbLAzUMmSptqeLwqdKlG3O5Ty8wK?=
 =?us-ascii?Q?XfDFdi77UUxD7ZLsGqqTXJbUI3u/L9F/n3fIblBnbZSEq0SFuIuE/Dbwq43k?=
 =?us-ascii?Q?nAevSNRHSoqLttk6n1k2XXhPVc3izUNDxG1hk1wIDj2pkIQePDumGInI3m+D?=
 =?us-ascii?Q?CVUkfbqn/qn+h/xGFbMd8RAwm7r+VmxNxwnlMhktTkmVJPSY2WFD/Fb0NdNM?=
 =?us-ascii?Q?gbLfXPjfIU9iCg6SQWSkaPWbGxlaTl+7yrcSpjFd8Cx1TgP+Ume+4PtMK+P9?=
 =?us-ascii?Q?LFzNMYpvSotYbICI/GkIm9xNKXuhNRTTQc2OzG55ez6AIBxC0mMuf/QF6u1T?=
 =?us-ascii?Q?LMKmjx5M00aQXkEH2TN2B4x4UqXDmQaq2YtO7WHCjrgYofZ61aE3j4BgdrvP?=
 =?us-ascii?Q?ToD7kR5xf3LVwCAb30lFxAqmEkrDKczAHrAkaYHiLznQx8U1hlEfHKgMzCYZ?=
 =?us-ascii?Q?RprxT15+4nEKdrGFxNCifOw2ES2xtxdhs4MMxv1FXzGixzbKPYsGqgBmIwQC?=
 =?us-ascii?Q?efEMXD/nZt45tF6NJIsDpOF8EsnhGCZ14RSmZTu2GDK1R4tUqnzLXktVdJUf?=
 =?us-ascii?Q?SssNfCcJw+oVOVi9dxyXaykYOj9uMo37MiOg5V9LpcQGpxWaRerOwUopw6kK?=
 =?us-ascii?Q?Ns+0AMtjmjAkkFTHRGuE3w0izkhIOb7CwW15As4tvqjdbX26tb0mJEfHEnNC?=
 =?us-ascii?Q?kkU5PBI80f0H8tDq9aLty7d8MU31+E0kFlP97rnVvefeFkSxFh7w7QwuixjU?=
 =?us-ascii?Q?G5YVVlHRY2y5eqV/NUewSGIFFnI9yEU4vUVeg+M03uDwCXFSCXzmxtUz1mDI?=
 =?us-ascii?Q?tET+LClYNAQno6+ppX3Znogti06nxct/bPSDdnPmMZ6basJez5CqtGMHe4Q8?=
 =?us-ascii?Q?bAJxkPxKTrqLXmRYx1Qv4o79/oR6IKEFifZmBGztAQalU+9cw25Reb8ZYpJ3?=
 =?us-ascii?Q?VKjL1BG2awma09RX7onIITYnF9Ywtu4f4sMwkssxs5a6CuOK/99Goe7Y2cxt?=
 =?us-ascii?Q?AZaKUqLQEIMQTUX1mJLhCUKvMPAXh7ffl/Ne9lW8gmzmX8bNLcBV4ZU8foAz?=
 =?us-ascii?Q?ir21eGnyrg5nWIOhXMnXQt4h+z5rHikRvGkf61zgcuAn1OLf2d8T0gpO+SKU?=
 =?us-ascii?Q?2Ef+93sBMhZYcKCIz9pT3k6YEMjf8sVRrmDj8jm5Usn0xFY/lNjvDpejs8Tm?=
 =?us-ascii?Q?IDXbKj0BUkkPZUP1LBeISbYTG5wgizV+gkJozKLcqSR++nnFRmGpNA3CWIVP?=
 =?us-ascii?Q?Tj3CwHiAO1NK6aGJCOY73Aj/+NadRQIAgfsNvgOAeTrsrnUElxdCXq/lWsWh?=
 =?us-ascii?Q?Gc5/I5YGtyX9kwm8pAnH9ISaotT+ESA76a9dZF0TPlHCjL5FUDno85YSyHoo?=
 =?us-ascii?Q?IY8EZULt7ne6UhFwYTzjeVw+/x9es5g8h8qVmaIXb2xnj/TabyJb9I7wReEI?=
 =?us-ascii?Q?lGfuWtxva8bFjTKcZuCVyaa4wyOglDf4KVnJHKStv4EtgAOc7HymJQIRWVVa?=
 =?us-ascii?Q?Xf5pOiCgjLlrssTIi5ICcS4k5+tlZK/pRtQZ7QUvFBbRd140mL40pSV1rxnZ?=
 =?us-ascii?Q?Yud+LNLYEjWdBeqtHY+Ij5R29lIzTU8j8HER4jFjQooItO8Xbi86/ytyiv53?=
 =?us-ascii?Q?JeGG5KXDqG9CsaiGKrqcPNOXbsuHmxsLyFcr2BDcg1MTFq7s?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 90728dee-8049-4eca-f19c-08de64d073dd
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB9366.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Feb 2026 16:05:59.4813
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wWBVdNteheJUknVdh3hdJdy0cuVbCX44vlU18GmCKmdLYt9fqDFsWDKJVrhaK+IHUruap6R4jsJpxjKWQU06uA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DUZPR04MB9899
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nxp.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[nxp.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,gmail.com,google.com,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-8762-lists,dmaengine=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,valinux.co.jp:email,nxp.com:dkim]
X-Rspamd-Queue-Id: 15380F50A9
X-Rspamd-Action: no action

On Thu, Feb 05, 2026 at 03:48:30PM +0900, Koichiro Den wrote:
> On Wed, Feb 04, 2026 at 12:42:41PM -0500, Frank Li wrote:
> > On Wed, Feb 04, 2026 at 11:54:31PM +0900, Koichiro Den wrote:
> > > DesignWare EP eDMA can generate interrupts both locally and remotely
> > > (LIE/RIE). Remote eDMA users need to decide, per channel, whether
> > > completions should be handled locally, remotely, or both. Unless
> > > carefully configured, the endpoint and host would race to ack the
> > > interrupt.
> > >
> > > Introduce a dw_edma_peripheral_config that holds per-channel interrupt
> > > routing mode. Update v0 programming so that RIE and local done/abort
> > > interrupt masking follow the selected mode. The default mode keeps the
> > > original behavior, so unless the new peripheral_config is explicitly
> > > used and set, no functional changes.
> > >
> > > For now, HDMA is not supported for the peripheral_config. Until the
> > > support is implemented and validated, explicitly reject it for HDMA to
> > > avoid silently misconfiguring interrupt routing.
> > >
> > > Signed-off-by: Koichiro Den <den@valinux.co.jp>
> > > ---
> > >  drivers/dma/dw-edma/dw-edma-core.c    | 24 +++++++++++++++++++++++
> > >  drivers/dma/dw-edma/dw-edma-core.h    | 13 +++++++++++++
> > >  drivers/dma/dw-edma/dw-edma-v0-core.c | 26 +++++++++++++++++--------
> > >  include/linux/dma/edma.h              | 28 +++++++++++++++++++++++++++
> > >  4 files changed, 83 insertions(+), 8 deletions(-)
> > >
> > > diff --git a/drivers/dma/dw-edma/dw-edma-core.c b/drivers/dma/dw-edma/dw-edma-core.c
> > > index 38832d9447fd..b4cb02d545bd 100644
> > > --- a/drivers/dma/dw-edma/dw-edma-core.c
> > > +++ b/drivers/dma/dw-edma/dw-edma-core.c
> > > @@ -224,6 +224,29 @@ static int dw_edma_device_config(struct dma_chan *dchan,
> > >  				 struct dma_slave_config *config)
> > >  {
> > >  	struct dw_edma_chan *chan = dchan2dw_edma_chan(dchan);
> > > +	const struct dw_edma_peripheral_config *pcfg;
> > > +
> > > +	/* peripheral_config is optional, default keeps legacy behaviour. */
> > > +	chan->irq_mode = DW_EDMA_CH_IRQ_DEFAULT;
> > > +
> > > +	if (config->peripheral_config) {
> > > +		if (chan->dw->chip->mf == EDMA_MF_HDMA_NATIVE)
> > > +			return -EOPNOTSUPP;
> > > +
> > > +		if (config->peripheral_size < sizeof(*pcfg))
> > > +			return -EINVAL;
> >
> > It is good to check here.
> >
> > > +
> > > +		pcfg = config->peripheral_config;
> >
> > save whole peripheral_config in case need more special peripheral
> > configuration in future.
>
> Ok, while I initially thought a deep copy (snapshot) was unnecessary for
> now, I agree it makes future extensions easier. I'll do so.


>
> >
> > > +		switch (pcfg->irq_mode) {
> > > +		case DW_EDMA_CH_IRQ_DEFAULT:
> > > +		case DW_EDMA_CH_IRQ_LOCAL:
> > > +		case DW_EDMA_CH_IRQ_REMOTE:
> > > +			chan->irq_mode = pcfg->irq_mode;
> > > +			break;
> > > +		default:
> > > +			return -EINVAL;
> > > +		}
> > > +	}
> >
> > use helper function to get irq_mode. [...]
>
> Ok, my current plan is to keep chan->irq_mode as sticky per-channel state,
> and factor out the parsing/validation of irq_mode (from
> config->peripheral_config) into a small helper used by
> dw_edma_device_config() and the new prep_config path.
>
> Does this match what you meant by "helper function"?

yes.

Frank
>
> > [...] I posted combine config and prep by
> > one call.
> >
> > https://lore.kernel.org/dmaengine/20260105-dma_prep_config-v3-0-a8480362fd42@nxp.com/
> >
> > So we use such helper to get irq node after above patch merge. It is not
> > big deal, I can change it later. If provide helper funtions, it will be
> > slice better.
> >
> > >
> > >  	memcpy(&chan->config, config, sizeof(*config));
> > >  	chan->configured = true;
> > > @@ -750,6 +773,7 @@ static int dw_edma_channel_setup(struct dw_edma *dw, u32 wr_alloc, u32 rd_alloc)
> > >  		chan->configured = false;
> > >  		chan->request = EDMA_REQ_NONE;
> > >  		chan->status = EDMA_ST_IDLE;
> > > +		chan->irq_mode = DW_EDMA_CH_IRQ_DEFAULT;
> > >
> > >  		if (chan->dir == EDMA_DIR_WRITE)
> > >  			chan->ll_max = (chip->ll_region_wr[chan->id].sz / EDMA_LL_SZ);
> > ...
> > >
> > > +/*
> > > + * enum dw_edma_ch_irq_mode - per-channel interrupt routing control
> > > + * @DW_EDMA_CH_IRQ_DEFAULT:   LIE=1/RIE=1, local interrupt unmasked
> > > + * @DW_EDMA_CH_IRQ_LOCAL:     LIE=1/RIE=0
> >
> > keep consistent after "," for each enum
>
> Ok, will add ", local interrupt unmasked" for it.
>
> Thanks for the review,
> Koichiro
>
> >
> > Frank
> >
> > > + * @DW_EDMA_CH_IRQ_REMOTE:    LIE=1/RIE=1, local interrupt masked
> > > + *
> > > + * Some implementations require using LIE=1/RIE=1 with the local interrupt
> > > + * masked to generate a remote-only interrupt (rather than LIE=0/RIE=1).
> > > + * See the DesignWare endpoint databook 5.40, "Hint" below "Figure 8-22
> > > + * Write Interrupt Generation".
> > > + */
> > > +enum dw_edma_ch_irq_mode {
> > > +	DW_EDMA_CH_IRQ_DEFAULT	= 0,
> > > +	DW_EDMA_CH_IRQ_LOCAL,
> > > +	DW_EDMA_CH_IRQ_REMOTE,
> > > +};
> > > +
> > > +/**
> > > + * struct dw_edma_peripheral_config - dw-edma specific slave configuration
> > > + * @irq_mode: per-channel interrupt routing control.
> > > + *
> > > + * Pass this structure via dma_slave_config.peripheral_config and
> > > + * dma_slave_config.peripheral_size.
> > > + */
> > > +struct dw_edma_peripheral_config {
> > > +	enum dw_edma_ch_irq_mode irq_mode;
> > > +};
> > > +
> > >  /**
> > >   * struct dw_edma_chip - representation of DesignWare eDMA controller hardware
> > >   * @dev:		 struct device of the eDMA controller
> > > --
> > > 2.51.0
> > >

