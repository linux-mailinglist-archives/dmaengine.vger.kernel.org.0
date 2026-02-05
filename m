Return-Path: <dmaengine+bounces-8765-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0IypMEPBhGnG4wMAu9opvQ
	(envelope-from <dmaengine+bounces-8765-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Thu, 05 Feb 2026 17:11:47 +0100
X-Original-To: lists+dmaengine@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 66358F506F
	for <lists+dmaengine@lfdr.de>; Thu, 05 Feb 2026 17:11:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 9CD983004F18
	for <lists+dmaengine@lfdr.de>; Thu,  5 Feb 2026 16:11:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B954942EEDF;
	Thu,  5 Feb 2026 16:11:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="MygwU7BV"
X-Original-To: dmaengine@vger.kernel.org
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011008.outbound.protection.outlook.com [52.101.65.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EC8342B757;
	Thu,  5 Feb 2026 16:11:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770307903; cv=fail; b=dHMml8dfptrwMFMi8EX0CdYzWGWsmMPerpJDO/MmmFAQOUC0QYFBQPs01Zs4pu2jnUBMXAheSvnKEZUoTXfJBlkizUrLvxg/XRMijCp1gnUNuIrUE0FhLBgjLhDdz06tD4KJ1f6lSeiRQd7XSNExj0xxprwA6RYi76+S/ryWD4E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770307903; c=relaxed/simple;
	bh=BqOyc6TZEW/pbDysR4pdVBlj24Hv+XLHyJrPDdlTuOY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=nt29wAjEOBTHHW3QPeuNHYEIgLMqljkPwKkrRnsylN4CKy+dmEzwAdCS6X6DnJsKz3R4BvBc9JdSn34l2Y22KlgW6HIacMHstIdAvbARjaHaRfekykIK81i4t0ZfHquB3TuHtN6ZeS794VsA/EbpQxPG7ZSYkUj0Ag8GsH9CXn0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=MygwU7BV; arc=fail smtp.client-ip=52.101.65.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YYs4uGU5/WnzicIOPO7jXKTWRUHeP5Qqosp/FNw9HsyH52lE89Uz16uYpn+RgUVoz83nGS4MyqE1E2jiHPeWBHTIkp2iOxAYh4vDk0ZQ3cMORVFi4Jg8+kGXhvslJQtps+ejIgmQBGQ/QiqHSfocAXSF+QL0HmdW4XQ1CztkIlpbbgjJLEsFgWE69XL4UK4pbwD2kQokz01eW17TbeKzEmnb1/2qG556W36RRIcaOzzPf+mifT4eXgGKzLKrP3fvBSEHeZhboa/W9l1nOhJdk2wRpDX3isKIwDxblW073BigJveE4zBjMgGViwbKjXOB3YHUZ2RODu82dDGCDb1H6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KM6zXSgLOXp4bl92cE4ns5jrIvIgv+J+HxAQSNcvsFE=;
 b=GUGrmygvqLNxvs7fom8mxqolOPUuop8YgYwzO4NZtJMjSZEsrCPIiwqKY22a1bW3aVfAcQdtciWwrdC2O7Ou7EYzNLMiSHr4nlFpRtP8UlbZHLsEoRbQCFU7sw4y27Hekud+Z5JePe9VYOZeJwjK0GEOPpBmgU0RgDnxZVAxZMAgheEHuUpenI/4uflJvDWEUAI8vcCNuADaY/vu8HrYodGu33p9bAsRDkDGxmFFNwWURhc08XUBwT+Yd0pYeEZk2sPh2zWXUTA+FH3/e0TmD9mKTIExNLzG30mIoOe57hvaIQb5z/S0JMlYxdWYnNq7+ol8+Qv+fGEpQqIyrc2Omw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KM6zXSgLOXp4bl92cE4ns5jrIvIgv+J+HxAQSNcvsFE=;
 b=MygwU7BVnlF/dMQqodSnIujIhDqvxNFKPWaJ8KxJfamVlUFY2EY877gihR5c6ddgjKJD/Xcic36aKduU/0C5eu0xEy7mrpktSzqeY3IDRqGg5+kqp3/6qHOyVf8Z9UxtIduPx7tZyUgsNYVjyI10I4WSu+NeKLAWI5td/KhOPUbzgrd4csV9t1H8z0Jn5szaFCWZYlQyV1AtWXxOSjMuB8RasZnpKvqylXOvLDtKDg4QMu8vAovLoWZ1E55HdJBZXXABUuQ04u1AKsClnSRb65z4ZpG7bIm2Lfl7F35F0Ndixmm31/DlXf5xkou7lX3JBGWEWk+BZ7Ij6jOqqS7DLw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PA4PR04MB9366.eurprd04.prod.outlook.com (2603:10a6:102:2a9::8)
 by FRWPR04MB11104.eurprd04.prod.outlook.com (2603:10a6:d10:173::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.14; Thu, 5 Feb
 2026 16:11:40 +0000
Received: from PA4PR04MB9366.eurprd04.prod.outlook.com
 ([fe80::75e4:8143:ddbc:6588]) by PA4PR04MB9366.eurprd04.prod.outlook.com
 ([fe80::75e4:8143:ddbc:6588%6]) with mapi id 15.20.9587.010; Thu, 5 Feb 2026
 16:11:40 +0000
Date: Thu, 5 Feb 2026 11:11:31 -0500
From: Frank Li <Frank.li@nxp.com>
To: Koichiro Den <den@valinux.co.jp>
Cc: vkoul@kernel.org, mani@kernel.org, jingoohan1@gmail.com,
	lpieralisi@kernel.org, kwilczynski@kernel.org, robh@kernel.org,
	bhelgaas@google.com, dmaengine@vger.kernel.org,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 08/11] PCI: dwc: ep: Report integrated DWC eDMA remote
 resources
Message-ID: <aYTBM5yOnyhy8F2g@lizhi-Precision-Tower-5810>
References: <20260204145440.950609-1-den@valinux.co.jp>
 <20260204145440.950609-9-den@valinux.co.jp>
 <aYOKo1Ep9g9xxeQr@lizhi-Precision-Tower-5810>
 <szak7xkmj7j36jyjyqj3t56uytdubabk4tet6yrgiqa54gwafq@kynruthmumcu>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <szak7xkmj7j36jyjyqj3t56uytdubabk4tet6yrgiqa54gwafq@kynruthmumcu>
X-ClientProxiedBy: BYAPR05CA0009.namprd05.prod.outlook.com
 (2603:10b6:a03:c0::22) To PA4PR04MB9366.eurprd04.prod.outlook.com
 (2603:10a6:102:2a9::8)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR04MB9366:EE_|FRWPR04MB11104:EE_
X-MS-Office365-Filtering-Correlation-Id: 0a8b145b-5289-4c9a-4858-08de64d13f19
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|366016|1800799024|376014|52116014|7416014|38350700014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?UP2ct5Ai9SBbA1Wx21jkyCovRKbyrNtDDJvTVgzmXAOgHlLWZJSWNE5w/tFz?=
 =?us-ascii?Q?ZSBZmh8ztOPnzl4bJ7A5yjnL1RURzmOIhAFyiEVDz6auVq3RlU1UZ51wda/3?=
 =?us-ascii?Q?khSVULGzEYkRukRZz02HcXL52p/CnDtFFeDQYwCjqFkovRPBFFTd0KuFykYK?=
 =?us-ascii?Q?PHuf0NqvoOqgOZejM8fq2wHutnBzbBpw4QC7Yc7kMYciEcEaq9KwyHTbmXBZ?=
 =?us-ascii?Q?kYemfWpiS5KTPWUJpuHWmovdPqqx7JDH5ollx1PQK8eWxHypCI4SomHaTvzJ?=
 =?us-ascii?Q?OM40HM8OVaTBWmYSz+rGYhDWfUys+9bDF/HfVyxeNauItK5WHuIS4zYCH9RO?=
 =?us-ascii?Q?f/vSikHaKKyMDRHt8nAhLgjwsQoh1VxJkyUlICdnWwFrPsa7w1IvEirn6ydb?=
 =?us-ascii?Q?fSiJs0avy2go4x1tJeoFR2E7Popotu9m/oycomEZ4gVt8J/cIR8FT8F4+hh8?=
 =?us-ascii?Q?Npa0JoX2E5QurqezpA8A3/5SwBTQTb+0j6vCg7JbGR3RR5cFahpWKKU7qCAL?=
 =?us-ascii?Q?UbPET/GAoI8EFT8cqS2/CkwEXKv/nlNSHdkWtE3Ai1NTrk42s+CATh4Ws8yG?=
 =?us-ascii?Q?vIBZMziOwFEeUQb3yvYwEU5dXnEwtze4pGtmi/5wqRJzpJgC4YtZDOrH//0z?=
 =?us-ascii?Q?9vFyVt6spkzxXqt3zZNKAeFloi6t/G89DWjsyT5tLvo96msEfmLe1eDwvApk?=
 =?us-ascii?Q?BFFtRMLEEF758xzrVKqLHdCJtLfSkDipVwrzPThEWoSBWH8nVdpG3Fs0Tlgq?=
 =?us-ascii?Q?Il58/N2e0tIMASs+cB33rRd7PVlzmMmU0dwr5m9BJmqXBe339B6zgIsEX46d?=
 =?us-ascii?Q?h21Tb6TOSXVNuglNBjlAugFOJBtVDY+8W5KwcUXcrhXh4TtzMTVNDGgKpTWu?=
 =?us-ascii?Q?gYVpm/hT8eKFqU/ZeWR32mUJAnT+VertOpj738EbNZpnmsDBcQ4+V3uP1cA4?=
 =?us-ascii?Q?dzPVv3f9G6IOEoZK7j26YY/jXfWaraLWjiy73kxk14gMDaREjTAMsbTdQyro?=
 =?us-ascii?Q?mQP6cvNdj+0Tcac1F2vU0fQZoHe1vc8CM9gX8QCDH46x7jIzK057YhtMO4Pc?=
 =?us-ascii?Q?ec+tsxFC6BLzPrJ5VpdZ3JUkDzqOMCGjP/ZUwParTsKraca+E33s2doqgjF8?=
 =?us-ascii?Q?cdqA9EGRYNWM2xJhcAX4JmPGqr+dC15dICZV81R54+/mbQKsvhsdiLCh963w?=
 =?us-ascii?Q?NZPuyR3cOJ0llVZ1bAQPkya//PqDph23PxLpbSfLTtNnHIrzt4ux8bGSwX3B?=
 =?us-ascii?Q?kDq9FHiYWpDeeIGmRsmvXCebRRQirV11XbDBM3r7k07wiSQuf9u4APTen7G2?=
 =?us-ascii?Q?4Y0wKxGx12G7AGRgQRmm3QX3HED9KjgkLd1gcTN4LqlWIS4aOiqfegcZoRBR?=
 =?us-ascii?Q?etVCgw1XlZ5FfLswBzPRJnTk6rPq69PB6j4ufHDdVJ8+5FOVntx2u/g+3uA9?=
 =?us-ascii?Q?6QTP0h8J3WpXE0vpToHebyUP79OmaI1adWbCHecluq3mt2zbOPpVt+P2g/em?=
 =?us-ascii?Q?DCAnD+SD4Hyn1rZ9XJaFmtkP2K8Fct6fyrp1DCsAY++792l6+Mk73xeABoUF?=
 =?us-ascii?Q?kKswvJsU8DjbIKGxnp1AOxIZCAuD4dD4EPETezPJyDGPdXbfKLBsB4E69c4N?=
 =?us-ascii?Q?aKKQOUtqd+hau2AFY3vtwc8=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB9366.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(366016)(1800799024)(376014)(52116014)(7416014)(38350700014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?J1L9xwXpMah7gq1HMiazR0274gxO0eXsyCELBdg2ggiAYnvYMJOdO4wKEBT6?=
 =?us-ascii?Q?e4rFGFikfYyLXOQ8tBFHMNoxKGHiJX/lBHOMkcpK/WTQM0x/hMhn29llK2Cn?=
 =?us-ascii?Q?+c10cyfi4gYgpt1MuQ0xHL+GFMSzzfnS1Z8CMxl0m0w6gH5s0FFzIQL0wYfr?=
 =?us-ascii?Q?X95DMovZFGOsefXwOTvJLGZaRjGHMAqej5kFAgDo2y06j8Ad6Q3jMkeepgWS?=
 =?us-ascii?Q?yYFoeSI1tL+a6/FI92XODiMONWA8lDZQUEL34gGK6te/ux97I8E2EflZDwvn?=
 =?us-ascii?Q?pzEUV1V+CLV/FM20CmDrNEIGkirvYpLdw8jj4ZUnFtTxUvZSChggk1NW7Eqe?=
 =?us-ascii?Q?Dq96E6T/lis+Iq0+JGlQ2lNfpUknpiutLBJOHEtPZIXs14vopDHllc1XkxoL?=
 =?us-ascii?Q?qKUM957AC1yd3AgtAg+hTiwVB2SyJ3MUxiIo9fRq1JyFEaUUYcsoKRI0kmO4?=
 =?us-ascii?Q?87AVn8z1icRZ5kmg0LbqixJmdJP9bbAR0LYzdR218pBzuCOLqPDBhv65xRdE?=
 =?us-ascii?Q?T5Vlk7edu/PbNSOhjegT3+UnYY+dlOim7gdWQeSCGmASvlUjaFhw/nOG8K3g?=
 =?us-ascii?Q?q5V4TX8LN/8nbG9srAgEKVwUiEzjgU4yx2GZdLeqpLpUV19s9X4KQptsCSgN?=
 =?us-ascii?Q?tf8d1xUGpQ2PBcqbfdABazzx2M0uybLiCalbrlAjIJjPpHHZRCtP8d4/i3j9?=
 =?us-ascii?Q?nd4WAEUeTqaadA0SwQdvDFXMaexUtLM/uY8Ovb8ruBlWECbwUmiEgparm+aO?=
 =?us-ascii?Q?uncxZkqYVHU/xbaSRyjWQdZN4JCxJbxKZlY1J3A8syPpFsbmLZVzVzeJa/KC?=
 =?us-ascii?Q?1ReStXPFinJo/G2fVwGtnMXWxgo6dHgtPJowE6zUP9prIlJ47wturFkhQQKz?=
 =?us-ascii?Q?4LAzEfEHp3jiKcqDpn7PrYnVzNi2m9r1UXn/1F15iz+LePHmvyDay44cJyn2?=
 =?us-ascii?Q?45j8a/rqE4KvfaDuGGaFVFWkF31N5vP7BtqXNVyjsHv0+MeppEyhLOPvvztZ?=
 =?us-ascii?Q?r5XabsMywEpd3Sj5awm53UDio9vpGVChGYI3HXoc3CJ2NJqbg1c+hSII8r85?=
 =?us-ascii?Q?jaHuQAIn327t0aTkligiyJV0Vi+vhOPxMsQUi8a+F0nXE3Ox7uKDUiDwc1Ut?=
 =?us-ascii?Q?PecGydVbFN1ph9IoRZv3lRFy5NNhQ+doUv/tAz/9MgeDaYMTba+SCAMZnpFF?=
 =?us-ascii?Q?ei1L01xpslNLjbdpf4NaftfxlrurwbUujYOmdP16FIl0Vkj4jbRsyD3WLuFo?=
 =?us-ascii?Q?1FOcWbJiZDfsi7dY/qC7z2gwn39OXCMudZYD+Vzx7S2fmS5aMoxXiKXp/qdk?=
 =?us-ascii?Q?FRwxdpc2i1eurDGvkoYLpouq2yf7pqHX1mfVA83N55Gx+DY2ctdvQRuqhzcY?=
 =?us-ascii?Q?XUgcusQZik1mokfZWt8GOKfpUmZlQL7Y8E7TUR8sw3XwynUIDC5bjxdOLnzR?=
 =?us-ascii?Q?dtmXefkk7ZGW7owWxPTyZSirOZhQFMRoMwMHMjgg+3SFhpYyJUF0zNF1Z5sl?=
 =?us-ascii?Q?e2XNC7NFTE18D85NdpNrLNROGBKUUVN6VVk3nNdOISnm75/zwK8lpH16hE1S?=
 =?us-ascii?Q?BlpIWaxkB3VZ3PDXXB8EqsOLzT7x/Sdda7lQrQcGFteRquMDs2ru8vru//Ti?=
 =?us-ascii?Q?Bd9DF6LH20sef+o+BACG9O5bXT4xEm7TdR4qjLwRnNA7i7dMRtSXfLg6wfyF?=
 =?us-ascii?Q?ZhaA6z4wV5q0B8sQU62gYxMxYdIn9UhPIKgXJolekuj3/6qw?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0a8b145b-5289-4c9a-4858-08de64d13f19
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB9366.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Feb 2026 16:11:40.4380
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qJYg/UZEg2SJThUhUy1II9I+hbrpSY6YMlZ2fQPP4wPVHgLm9MiYHJzI/5f667f9VkOobFr+8rxvPrSag1sJJg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: FRWPR04MB11104
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nxp.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[nxp.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,gmail.com,google.com,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-8765-lists,dmaengine=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nxp.com:dkim,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,valinux.co.jp:email]
X-Rspamd-Queue-Id: 66358F506F
X-Rspamd-Action: no action

On Thu, Feb 05, 2026 at 03:58:35PM +0900, Koichiro Den wrote:
> On Wed, Feb 04, 2026 at 01:06:27PM -0500, Frank Li wrote:
> > On Wed, Feb 04, 2026 at 11:54:36PM +0900, Koichiro Den wrote:
> > > Implement pci_epc_ops.get_remote_resources() for the DesignWare PCIe
> > > endpoint controller. Report:
> > > - the integrated eDMA control MMIO window
> > > - the per-channel linked-list regions for read/write engines
> > >
> > > This allows endpoint function drivers to discover and map or inform
> > > these resources to a remote peer using the generic EPC API.
> > >
> > > Signed-off-by: Koichiro Den <den@valinux.co.jp>
> > > ---
> > >  .../pci/controller/dwc/pcie-designware-ep.c   | 74 +++++++++++++++++++
> > >  1 file changed, 74 insertions(+)
> > >
> > > diff --git a/drivers/pci/controller/dwc/pcie-designware-ep.c b/drivers/pci/controller/dwc/pcie-designware-ep.c
> > > index 7e7844ff0f7e..5c0dcbf18d07 100644
> > > --- a/drivers/pci/controller/dwc/pcie-designware-ep.c
> > > +++ b/drivers/pci/controller/dwc/pcie-designware-ep.c
> > > @@ -808,6 +808,79 @@ dw_pcie_ep_get_features(struct pci_epc *epc, u8 func_no, u8 vfunc_no)
> > >  	return ep->ops->get_features(ep);
> > >  }
> > >
> > > +static int
> > > +dw_pcie_ep_get_remote_resources(struct pci_epc *epc, u8 func_no, u8 vfunc_no,
> > > +				struct pci_epc_remote_resource *resources,
> > > +				int num_resources)
> > > +{
> > > +	struct dw_pcie_ep *ep = epc_get_drvdata(epc);
> > > +	struct dw_pcie *pci = to_dw_pcie_from_ep(ep);
> > > +	struct dw_edma_chip *edma = &pci->edma;
> > > +	int ll_cnt = 0, needed, idx = 0;
> > > +	resource_size_t dma_size;
> > > +	phys_addr_t dma_phys;
> > > +	unsigned int i;
> > > +
> > > +	if (!pci->edma_reg_size)
> > > +		return 0;
> > > +
> > > +	dma_phys = pci->edma_reg_phys;
> > > +	dma_size = pci->edma_reg_size;
> > > +
> > > +	for (i = 0; i < edma->ll_wr_cnt; i++)
> > > +		if (edma->ll_region_wr[i].sz)
> > > +			ll_cnt++;
> > > +
> > > +	for (i = 0; i < edma->ll_rd_cnt; i++)
> > > +		if (edma->ll_region_rd[i].sz)
> > > +			ll_cnt++;
> > > +
> > > +	needed = 1 + ll_cnt;
> > > +
> > > +	/* Count query mode */
> > > +	if (!resources || !num_resources)
> > > +		return needed;
>
> ^[1] count-query implementation
>
> > > +
> > > +	if (num_resources < needed)
> > > +		return -ENOSPC;
> >
> > How to predict how many 'num_resources' needs?  provide
> > dw_pcie_ep_get_resource_number()?
> >
> > Or dw_pcie_ep_get_remote_resources(struct pci_epc *epc, u8 func_no, u8 vfunc_no,
> >                              struct pci_epc_remote_resource *resources,
> >                              int *num_resources)
> >
> > return number_resource validate.  if resources is NULL, just return how
> > many resource needed.
>
> This is already supported by the current implementation: in
> dw_pcie_ep_get_remote_resources(), if resources is NULL (or num_resources
> is 0), it returns the number of entries required (see [1] above). Callers
> can therefore first query the count and then call again with a properly
> sized array.
>
> This behavior is also documented in the core API added in [PATCH v3 06/11]
> (pci_epc_get_remote_resources()).
>
>     + * Return:
>   > + *   * >= 0: number of resources returned (or required, if @resources is NULL)
>     + *   * -EOPNOTSUPP: backend does not support remote resource queries
>     + *   * other -errno on failure
>     + */
>     +int pci_epc_get_remote_resources(struct pci_epc *epc, u8 func_no, u8 vfunc_no,
>     +                            struct pci_epc_remote_resource *resources,
>     +                            int num_resources)

Sorry, I missed it.

Frank

>
> Thanks,
> Koichiro
>
> >
> > Frank
> > > +
> > > +	resources[idx++] = (struct pci_epc_remote_resource) {
> > > +		.type = PCI_EPC_RR_DMA_CTRL_MMIO,
> > > +		.phys_addr = dma_phys,
> > > +		.size = dma_size,
> > > +	};
> > > +
> > > +	/* One LL region per write channel */
> > > +	for (i = 0; i < edma->ll_wr_cnt; i++) {
> > > +		if (!edma->ll_region_wr[i].sz)
> > > +			continue;
> > > +
> > > +		resources[idx++] = (struct pci_epc_remote_resource) {
> > > +			.type = PCI_EPC_RR_DMA_CHAN_DESC,
> > > +			.phys_addr = edma->ll_region_wr[i].paddr,
> > > +			.size = edma->ll_region_wr[i].sz,
> > > +			.u.dma_chan_desc.hw_chan_id = i,
> > > +			.u.dma_chan_desc.ep2rc = true,
> > > +		};
> > > +	}
> > > +
> > > +	/* One LL region per read channel */
> > > +	for (i = 0; i < edma->ll_rd_cnt; i++) {
> > > +		if (!edma->ll_region_rd[i].sz)
> > > +			continue;
> > > +
> > > +		resources[idx++] = (struct pci_epc_remote_resource) {
> > > +			.type = PCI_EPC_RR_DMA_CHAN_DESC,
> > > +			.phys_addr = edma->ll_region_rd[i].paddr,
> > > +			.size = edma->ll_region_rd[i].sz,
> > > +			.u.dma_chan_desc.hw_chan_id = i,
> > > +			.u.dma_chan_desc.ep2rc = false,
> > > +		};
> > > +	}
> > > +
> > > +	return idx;
> > > +}
> > > +
> > >  static const struct pci_epc_ops epc_ops = {
> > >  	.write_header		= dw_pcie_ep_write_header,
> > >  	.set_bar		= dw_pcie_ep_set_bar,
> > > @@ -823,6 +896,7 @@ static const struct pci_epc_ops epc_ops = {
> > >  	.start			= dw_pcie_ep_start,
> > >  	.stop			= dw_pcie_ep_stop,
> > >  	.get_features		= dw_pcie_ep_get_features,
> > > +	.get_remote_resources	= dw_pcie_ep_get_remote_resources,
> > >  };
> > >
> > >  /**
> > > --
> > > 2.51.0
> > >

