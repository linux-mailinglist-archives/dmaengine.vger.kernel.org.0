Return-Path: <dmaengine+bounces-6473-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CA9FB54000
	for <lists+dmaengine@lfdr.de>; Fri, 12 Sep 2025 03:53:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E5D614871A1
	for <lists+dmaengine@lfdr.de>; Fri, 12 Sep 2025 01:53:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88F9215747D;
	Fri, 12 Sep 2025 01:53:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="HbwoiNNC"
X-Original-To: dmaengine@vger.kernel.org
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010020.outbound.protection.outlook.com [52.101.69.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97A6126281;
	Fri, 12 Sep 2025 01:53:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757641993; cv=fail; b=HnOmOWFXnsUw1npXcTxxrOQvQR871YBOqYtLn8gFpS4amnhoj9s6grahYGxr23pfrpgsqaN4gOsQfe57ZFdh3eM81NaoIZqzfhesugXglexf32uom7a98aM4LTsT2YBzSjddntS311Zk2L4ccK85PJ9r3awN/JGK2GQwPAoijGY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757641993; c=relaxed/simple;
	bh=XAo8RkuA7g22H+2562n+MP/NWLvTNhDl0y+Qnlkevu8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=UzTzMMUPdSHan/psiSec2Qb8ifgYs7dCjSatUk1mvW8isBWCzb3z1c/WQmN8xA8akupPsoet8CGLdUY7WKgTdB1AWtCTnbMjyCq+6CCtriOz9pRVNrHkRtRm0dBC76nyRP6NRnHTtFpNHqWdWYZFX4Mmj+DvrrXSvuLitgz2NS8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=HbwoiNNC; arc=fail smtp.client-ip=52.101.69.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=l+dUbjxDyAid8uowHow3a3cqDJcuODd7ycDExR+EKGRKCgEZwJFtFbpyVNUOARgwflP7Ps4609sDTpRpOv4DP8zimQuJmY02vAVxzxJaG/cEB85o+A0T3FWhRMe97tEoYeaunnO95cFAmLSP4O4+ZLU3sWo6FKcXXnMit7DvQ+hrLHWb7VOKkE3rfXEGjl7bJJ1t4uloCLfUgkx7Gs3p+pCJEvKsH9xv6JSgbGmVPDI87iJmBhZDE5Dnd8W6NRiHRWvqjwsTE+Xuy1u+BW9O7nnN+mAYGNDsf+rxE5q3ciKs0mGJLzIqVciOoqXHBq5PkTSg0Ec7uryI6FXntWCDcw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XAo8RkuA7g22H+2562n+MP/NWLvTNhDl0y+Qnlkevu8=;
 b=m9zI+QFGEtcegDuN2LMPtePWJsElZziw0BFX0sqoc3g1g/3tyUZJN4vCiC3t+vr/6MUy5bgMqFyaYEtOcIio4AocY//l9w+2lXM5PdOPHMFmEsAwbh6es2b+B5Weh9nZLjfiqLY8nNDBLo/wtPdiDtOgZbl97yoaRFnqn9orb35uGlOYJKXc2idhKVZI+kgj9AWEC9K9qR6TCdCBx9Yr8KDH6cLaw//Y7aVGMIXDDnLupNUpTlvl50ewJtcN5GA+YyYbJNHdHf3nFiquzTKrAFB8rSO4Ryh+MmjVGiQOclNxf/lSylPCPiQnZjt3C0o/qtQehyLVImyEg8WTXtED7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XAo8RkuA7g22H+2562n+MP/NWLvTNhDl0y+Qnlkevu8=;
 b=HbwoiNNC23LySHVXzoBvktI8I0zHZemPEVe5jTCzGtbV+3d7Go3fD1FI8YLr9X7nKdELKYyiY6wcoRM4iZU2c5pR1zyl5Ngv1aMS0wrZ/M8osrIvZ9hCN8AtKvgubyXTBjtkTVLntdzBU9rahZ1T9XGSFbfvv0hlIhERzmR0lvd5aZXPHM5RlecJPPJdR0cp3t+iRsKqqk0IcptWnx7L0AhA+eDTP1uS1xJLxYcfy5JQabf8puO0YBVPUkslGfWf0fHUsJKYhZc6YlDwq/lp4xhG7usx7Pva0PoB4FO2ErT9BwWpAdeUDeJbgTvURR/SV8LmNn9Z0rFMHGrxvN+oAQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by PA1PR04MB11333.eurprd04.prod.outlook.com (2603:10a6:102:4f3::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9115.18; Fri, 12 Sep
 2025 01:53:04 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%4]) with mapi id 15.20.9115.010; Fri, 12 Sep 2025
 01:53:04 +0000
Date: Fri, 12 Sep 2025 11:04:33 +0800
From: Peng Fan <peng.fan@oss.nxp.com>
To: Marco Felsch <m.felsch@pengutronix.de>
Cc: Vinod Koul <vkoul@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Jiada Wang <jiada_wang@mentor.com>, dmaengine@vger.kernel.org,
	imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, Frank Li <Frank.Li@nxp.com>
Subject: Re: [PATCH v2 03/10] dmaengine: imx-sdma: drop legacy device_node np
 check
Message-ID: <20250912030433.GC5808@nxa18884-linux.ap.freescale.net>
References: <20250911-v6-16-topic-sdma-v2-0-d315f56343b5@pengutronix.de>
 <20250911-v6-16-topic-sdma-v2-3-d315f56343b5@pengutronix.de>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250911-v6-16-topic-sdma-v2-3-d315f56343b5@pengutronix.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-ClientProxiedBy: SGXP274CA0019.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b8::31)
 To PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|PA1PR04MB11333:EE_
X-MS-Office365-Filtering-Correlation-Id: 1c9f2213-b1be-447d-3a64-08ddf19f1cd5
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|366016|376014|7416014|1800799024|19092799006|7053199007|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?YSktsm52NOyS8s0LCoXKFCI4PNb0E8z3m15jY8knOv2dTwPth7r6pw9C6ygu?=
 =?us-ascii?Q?i1F4wBKbHJii1G8m0ugC74WcOE6Ccuo5S1ET2+MmuMALMcwSYIate8jbe8hJ?=
 =?us-ascii?Q?gaORHXqGhYAJio8C4RvZmDWc9oSwzsIx5/qqygCveS6HxzGZ65MbiyRm7YrC?=
 =?us-ascii?Q?hucLejsJnTzcUAY0A9VG9ItAFDtaC6LYx271RUmYa0OE8nyS1r+HSnOxPKFE?=
 =?us-ascii?Q?JlYbzq8oC7W8upmntsgl253vMuy3iqfu2h6omINQhwQRkUuzIheB6QE296bt?=
 =?us-ascii?Q?T8O/tfM2v5RbUnzcv9feAOIG6W+kDZLvkYnLl+tWfZZ60PczaFqmVVfEwUjM?=
 =?us-ascii?Q?JtDuo0GvzPojI1uWWVfXwZwWGZACDwLy8T2TzE3ETHJYv8eTrFumlai7a2fi?=
 =?us-ascii?Q?2Rjd4IBSn5x60Imaz0zBmdemS9quiL4ODNONL9HGQAX7YKEcGO3ivHCkY0DN?=
 =?us-ascii?Q?cgenoCCtUoWTO/tx4lRj//x8M0/aj94FbfGw86tU3uCIjunB5LXDdARr3N2L?=
 =?us-ascii?Q?JrCBGUtikZRYnxY3jL/SQit0P2CBeuk87TACOClFZN8AcI6IJAhUVdyJciXV?=
 =?us-ascii?Q?WLlcgCWTG7CJXFSN51KWW34kUuVpRKBMtp/tijhf8oFSv6+Xn1XW2B34M1za?=
 =?us-ascii?Q?q5vP3HJc8E3jhMDrTxG0blMZ9nQf/d5snwchTw50HcqVLSKAb407uaif/byH?=
 =?us-ascii?Q?kBAcZRcoHfxEVjoP6LF18Ai+aELTnakopxQ+faMj6ZNePWidMQ5jrXLPUF0r?=
 =?us-ascii?Q?Y0dc3H5NwF4kSEHyH9XIHrEOV/vlZ4kQdLJc2dO1mEReBfq7TjDCj+Z/16SQ?=
 =?us-ascii?Q?T9AzilwvihX7oUyIh1AG/LJwpoPT5DxpxU6eAKvY9JPKHxlcbjxKzEEWyaNN?=
 =?us-ascii?Q?MRMjwa+LCEPnzeWi/8I/bKKASTvi8qFCfzRJNi6spFKEGHwZV7sIpfXCeIdU?=
 =?us-ascii?Q?CGmAwTMEicdjVWTip7ALhOkR2Kt22RJxmZ/u7v+PzLOLRalMEtBrHXMxSjWX?=
 =?us-ascii?Q?ky8INf4SJTiuwH62N6ahQUZjPVFFlz7v9X3gyn17ATR9mkNnjpvXkFHbRj6i?=
 =?us-ascii?Q?ss2pSRqquTaKOdfe87NI56H4N+4PvRj7X8qWTcIG65JVWAaT+/XKNPlTJ2P6?=
 =?us-ascii?Q?JlJqJsfKSfJGRZKeq9SwSi+80NomFf+xFiposl0xBI26DMq0vQUa+QwKo3ZW?=
 =?us-ascii?Q?ARhDMnETm6ZJIJCAr4FEO7bzQ2SdqJGDFBkKLVceZ0MsJzN3Fz9yBkaQ+h/e?=
 =?us-ascii?Q?pwPRNS/2+J0LdIjvC/cDMQu/LUYBiRPzHu+CxzuU3ksOoU8oemxMgwqKjuhq?=
 =?us-ascii?Q?WTu/7DnocpEM5YTy63pb1uxLjUx/xDINZ1e+ZLDQbc5ORRlL9PGAKBlfuHVC?=
 =?us-ascii?Q?7o2tQWffpJUOKzBUnHb95mlOoqH/nTWVOTCpnIn0pMS0pj1Oh/xJK47tcNbi?=
 =?us-ascii?Q?B0D14dXpw9T7+9Z5tGIQ4EYysFV2cKes/2ofEun6De3fhu6pK75RcQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8459.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(366016)(376014)(7416014)(1800799024)(19092799006)(7053199007)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Up/JdzzxSxZ8WU0K3WPjTiP6mhEB4nFcvFFaIRPE13J7ghtS//wdWuY2ihCB?=
 =?us-ascii?Q?4oy2sS9NZYfTsUZ8npoaL7mcAkC6V9fS9rfttQ9Bfk4L5kLcXlU3DgOJIOj2?=
 =?us-ascii?Q?JpYXZAMv4hsnl0JHmzntmGjTrogDFwj0gs7akkXUSfhJi/rBOtn0rHUL4g/v?=
 =?us-ascii?Q?3fOABAAxQEU8fN6orGWOkcyajzdvlhVd0FtV05kaVV5gJ9/9MK0R99KFUjzN?=
 =?us-ascii?Q?HRO1xw5wxyhH05jI6UtBf05KvOPqVQ7Ah2ljo/tytAbQkAxDgVAzgY+VrbE+?=
 =?us-ascii?Q?tFTAe/wMh4082YeiyTR0Eck+QlnWlGqH//qCywZHwrSORBzmKQFze4r51dgY?=
 =?us-ascii?Q?+h30l//goVijcu9CmR593pacJMWzno+ptGQI/WWSKPNhe+XYn8cgp4JpI9MA?=
 =?us-ascii?Q?Im94HXqM7JkHy1HgYilshsHs3bwJjcSgNtgzAGT5/5b9z2RlIplsiJgmycRD?=
 =?us-ascii?Q?CL0RL9MsdVYdXRSCdGMZW+d5v3ihI22YYMqXi3yp4hYowGXVap/zYmLtkAep?=
 =?us-ascii?Q?ANjc5X8YXWL0hJQhdcUU0yczdt5pwhmEw3LpHoR7U5PyEu+bZOAERmK+g6qL?=
 =?us-ascii?Q?gsriX9g/w7nxKENj+KE/E7fxf6eSGDmZinv0uBjyU3ERhnqhHeCASCf0Ky0U?=
 =?us-ascii?Q?wckHgRibaRACGnEJKB87zgSSIjY87eWYZmEUd0m+3QsoPxTthQtutox/dbUg?=
 =?us-ascii?Q?pwJAVTwJO6W9+3O/W1iRhlXgQVKtj4DSSg0ctHw6oABGdEog5mU8R8fb/Gqw?=
 =?us-ascii?Q?AImyfLXkbJMOB+5QQ6dG5U5FCpxYFuOGURlvIspM1a1K9Vdw24A/tNeucbx3?=
 =?us-ascii?Q?yGkRS1fcJUx3hCu3jd9+WSW2D1r/vzFxPfD7xfIPqexBeQRypdPELyAvIhfZ?=
 =?us-ascii?Q?Fd+MEGQILoJMyqxPx3Zw6DcHnZfNKQcs/ibw03A4OTESe3l7Cx91qmhrwRT/?=
 =?us-ascii?Q?wRTFWtdugNPn++vneMpsX+EXTUtCbzGcbfM6fk3y4dhc58tqftd1+1vGgKuC?=
 =?us-ascii?Q?a+Ov2lLffpcF9LqFqxcLLb51eFvAr9L7K+WqGhFOOVuW3rBQZRt9syvb+aC4?=
 =?us-ascii?Q?wKLC3bMbBJ2Tnk3gN+rJv8DQve6G+sBDnhDhr0W5PIwne3ZQ7rXlxJLnuV0Z?=
 =?us-ascii?Q?p5MCR0zD3WY6JTEUrrjoB1yrOGy9/qcmkMwFzRNomvKy2KvIAKe8XSwVE2cr?=
 =?us-ascii?Q?+PepDwpgg4sIx0UDKj3vnfpdqtRfQoMyJ5jJ6gIynphoolG/fe5BGMK7AdwM?=
 =?us-ascii?Q?iIHV1iVoPKkOZ+bvaxcMDOTDjYkbXl+eDskkmS40sBHND0uH5qbysWTtVUDp?=
 =?us-ascii?Q?a2oWdV08zaDl74Ix9lLbJJL3gXXoqkI3J0i9c9hz15uIBY0hS2QqDdKaIj5P?=
 =?us-ascii?Q?Ei8bGVoM7+fkBU4ewBZPgNk4MnLNfaByE/Ak6vl9LmwJ9RarPLdF+VzhLrNk?=
 =?us-ascii?Q?KSRE7wGZSMXlniMkCjhBaMRAcxdXADZ4RKOQsgAXsk0DjG4WZseM3sb8c5J6?=
 =?us-ascii?Q?2/F89DaULWbq4E+3kSshLVja51kDV7MGMalsZYNgNeupRUHUvKP1CJ54Cd8r?=
 =?us-ascii?Q?Hh56YgHufG3//apZCUM706e7K3/M9JJknVb9jnGN?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1c9f2213-b1be-447d-3a64-08ddf19f1cd5
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Sep 2025 01:53:04.3955
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1WvH/16PTykiB5P1kROWk0egQ/SgjWkC5vxpo/Qd67r9lRxcaJrNmjbKeRBEIdNpZZiOOvJ43c+czzA7v0fW8g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR04MB11333

On Thu, Sep 11, 2025 at 11:56:44PM +0200, Marco Felsch wrote:
>The legacy 'if (np)' was required in past where we had pdata and dt.
>Nowadays the driver binds only to dt platforms. So using a new kernel
>but still use pdata is not possible, therefore we can drop the legacy
>'if' code path.
>
>Reviewed-by: Frank Li <Frank.Li@nxp.com>
>Signed-off-by: Marco Felsch <m.felsch@pengutronix.de>

Reviewed-by: Peng Fan <peng.fan@nxp.com>

