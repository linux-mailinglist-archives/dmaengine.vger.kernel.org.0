Return-Path: <dmaengine+bounces-11701-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 6zBeOU9kOGp7bwcAu9opvQ
	(envelope-from <dmaengine+bounces-11701-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Mon, 22 Jun 2026 00:23:11 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 702736ABBF5
	for <lists+dmaengine@lfdr.de>; Mon, 22 Jun 2026 00:23:11 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=NXP1.onmicrosoft.com header.s=selector1-NXP1-onmicrosoft-com header.b=rtOjWoV3;
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-11701-lists+dmaengine=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="dmaengine+bounces-11701-lists+dmaengine=lfdr.de@vger.kernel.org";
	dmarc=fail reason="SPF not aligned (relaxed), DKIM not aligned (relaxed)" header.from=nxp.com (policy=none);
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id DCE9A30022F5
	for <lists+dmaengine@lfdr.de>; Sun, 21 Jun 2026 22:23:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71266371D15;
	Sun, 21 Jun 2026 22:23:10 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013014.outbound.protection.outlook.com [52.101.72.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 545212EF652;
	Sun, 21 Jun 2026 22:23:07 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782080590; cv=fail; b=mSuXzi92KxxdEVXXFvl4in/0+wU2anXrtyx/K9hatkm/3vJBKHX0g+TWyLEnLpPpyCNA42d40hvglxUai/gbo2q87eWA+qzIrhR5iAb36T+0WzELFEWSQYQWeCWLnrAOn/mWgAsLoz+r2yJ8FhCe/LeI7rU97lL08TB26C3/uXk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782080590; c=relaxed/simple;
	bh=87J08lFxfZNKymTlydumBkmFUpKSciZoHzWOAnKyyg8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=MLx8WNL87ISO8roYdId6VWHyB+HBuGh3Dce6trhn12BozY8UnP8qqO8TPIHB+Ny1JW1BmEyzGbrwiN2mG2kcWMa2mDHOpkwx48tdHQZ88HGUfpB3P5HrVlJXdO/aIsWHEtd1HPGRGEkU62d05fY6kHMUl2RR2Mx8cf7UCKJnyik=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=rtOjWoV3; arc=fail smtp.client-ip=52.101.72.14
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sbOUykjA5erULIA5EAsbae9aVxlr8+ToVg/g7ZYtSVRD+UB7S4MC02qUL46gEqakmjI2ILBSpwjp66BSlhkQCrBKkCyLtZlZAJy2q/ljyQxizeHJJzhD8OKdUTMJtj43jqM3E9a5b7vBnSH61QTKl3qJEoJ+0IkztLSmryvNRL4+8wP/10aSdNT1g5z4UN7ikfWta/Jny8jxFztAfg5AYY+HmKvTSUmz3oiQZI+pCbfZdTRZS71Do6J/r9+r4X2Zh1z0Ts3oYTt2M0lp5hU8XsgzvBBjqYXp9h/A5O9ugftIbnZkJHvRPxf//zg+Zw4OViFNbajIlQPfoPgOQajCZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LYtXSB5hxy+ShAOKLpQzRZyv7qEAjEb/ZbbX4O0t/7o=;
 b=lC6Pz6fmtJZSDmnH4AjuxYPRqzcMIKAWfhZK1ryNWWkp+JOQg4Qk3b2OshpEVa+nqqyrb0EcLaG1fwdJkUxfquqZdw1mXJ8i9yrvqGpAflJOwM5LvoKrjkTiZH5i1odbRg4i989ExahPcQ0dd1QCjU7zzxPPm0320f5W53XCk6U3Pw+h8lQh5yiaPgVNOb+rX2F2y5ME8JUJ4iRwfNQfIHGOe1gKi2APD2dcrgpNnqHMaEUxmTCo7q1QKvxxXak5Kcd5485KRwTouQJMisLSOfLD0UjYz49UF6rRdiux3F6IQZc1sFSiUlNbOADgnq32CerB+lOdTbRRdNVvnP78qw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LYtXSB5hxy+ShAOKLpQzRZyv7qEAjEb/ZbbX4O0t/7o=;
 b=rtOjWoV3Y/vuNASpgbly9GvNiL7AFABrSrXmORT18KSCM679tMIfhennILNJYhGBb4dpQnLj3mRM+p5D4X6bSVA+zW+3l0MnkpVuDhFHxrZF0pjhXTbZMIb6sS5fTXwjqSn5Hb7cm9WV/+/xTUAzZHnUZwb+RaxX6BZG1s71Cxb17o5uzrjtMSyKaij2IPz5x8cu226/bermMHSFsquOZEIXqbYq5bLoRdbkOgn34HbUTDXObfXZx3VOzRNNTlK6AzvLV1RCkUaN1VGX8UL9ZiIUYw5+/NY59k7jhuRbSb1nR+zqFQ0JMXtk6elMiyRraaQBXY8YFZ0q3cwaezVBLw==
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com (2603:10a6:150:2cf::9)
 by FRWPR04MB11246.eurprd04.prod.outlook.com (2603:10a6:d10:171::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.19; Sun, 21 Jun
 2026 22:23:04 +0000
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c]) by GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c%6]) with mapi id 15.21.0139.018; Sun, 21 Jun 2026
 22:23:04 +0000
Date: Sun, 21 Jun 2026 17:22:54 -0500
From: Frank Li <Frank.li@oss.nxp.com>
To: Yuanshen Cao <alex.caoys@gmail.com>
Cc: Vinod Koul <vkoul@kernel.org>, Frank Li <Frank.Li@kernel.org>,
	Chen-Yu Tsai <wens@kernel.org>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Samuel Holland <samuel@sholland.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Maxime Ripard <mripard@kernel.org>, dmaengine@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v2 5/5] dmaengine: sun6i-dma: Implement support for
 Allwinner A733 DMA controller
Message-ID: <ajhkPus-ZV9prECQ@SMW015318>
References: <20260621-sun60i-a733-dma-v2-0-340f205891cc@gmail.com>
 <20260621-sun60i-a733-dma-v2-5-340f205891cc@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260621-sun60i-a733-dma-v2-5-340f205891cc@gmail.com>
X-ClientProxiedBy: SA0PR11CA0065.namprd11.prod.outlook.com
 (2603:10b6:806:d2::10) To GV2PR04MB11799.eurprd04.prod.outlook.com
 (2603:10a6:150:2cf::9)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR04MB11799:EE_|FRWPR04MB11246:EE_
X-MS-Office365-Filtering-Correlation-Id: 484b4a12-a52b-41c0-e857-08decfe3a99c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|19092799006|1800799024|23010399003|7416014|376014|18002099003|22082099003|6133799003|4143699003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info:
	2/M5/XPXCtHpeDLaZaFXBF66UbJZsYag/Eefh1hfljUIYjRJifG54EUmyEmPcGJWja/q5Kvqvz8k2+goDcC4rxgaDMCP+zNP8x2f1VAFdespBJqF05pV0Z5lQHEjVWiZN+wASdv7YUpJ+jYx5tzEwn4RKOK7+6haj5qyaESHvd3R8zOGcxLxFZCLHZWWti/ZtVuPeZpx+1Abgo6oAcoR4O56Oo6fmTvf6WmIiYRAhq2GX8ZtRVKgG/3lC5YafYbIMo4lctofKKzKWMCIRBORBRUCDSWIbN89I/CMValqLzBVJJy4RcKCDoO2AhF5iijsx+pJmU/HQ9wE9wUlyueB8Vr0UU2Hrik7nC4iA6/+mSH5nAzUEH4nxlsH7aUG0OMqB6dGvdha2W6wEHAb9jrDNQA8hk4ukhE4ae/U8/T/9CLu+L28RLOe7ZInHz7C8bz4A7H08pu2DTpZ9ZJ6I3dPCqooQgeAgEQHH5v71gJE6dcSY79JfdX8LtDkzyuk0Xu7KckbUWVgnqIeVi4u4dUCWTZYSXSNvv6OHZAn6jtrMTegLFMvcp7GPCYJhfGWPA+X6NzsyRHii+7VbvvSl/wHwPrMDcJqtotjTWwa/0L7WAzLcptmHFyYdA56yg0f4AxUSsg0Y2uoWlekJ2BrkjV0ERiyr75ERbzI58QEj5W90MI=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR04MB11799.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(19092799006)(1800799024)(23010399003)(7416014)(376014)(18002099003)(22082099003)(6133799003)(4143699003)(11063799006)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?XvrK1mjGPibU8+KprjvV6PEPGf+6IHPQ4EkyYBF6Xya25riSCE9eXq1ZeIsm?=
 =?us-ascii?Q?FNviHl5qifSIqwCRRKwu/3MDjnIgyZxl1cfNgBNZl2nGXtwHj9Y3ig7puvRy?=
 =?us-ascii?Q?EEzyKrygiUo5GxGyZRL9U3sUswEuLsl0alsQ7Jfb2mkZ9GpPm7Ky2op9FY6J?=
 =?us-ascii?Q?BvOCTmvdgdBzmv+bfHaDvK/0lbPjm4ScCJiNo1WXi0m4JgI0SLfAMnCC0mn0?=
 =?us-ascii?Q?/5VJp5qQf3V6YB8XlQ9LuTUxj3Fr+4YEP+C/20jYm+sKhiFkWDPMmR4tgKe8?=
 =?us-ascii?Q?fUAaq1hr6W0XpEyGdQE4eikGrKhJHYeAF5MIN9f9tgEnQmeOJ/Dih+Tgr/We?=
 =?us-ascii?Q?SXnN1SCsCseiCgwDxGLwnZ4L5n4AOFA5FBtRg78RX1FfCJ6+9FhQZIUquN5o?=
 =?us-ascii?Q?X8qeMofQr6nF3oabbd4olHeF6FSQpUk30arO4jn8+S9CH3L5VoNxmIMKNkAz?=
 =?us-ascii?Q?WCkYcMSwUIX0ZSWAVsD/S7VuztFBQMuRrfzLAKl1uTfeTcTEmFS2IWJotoYA?=
 =?us-ascii?Q?HkaDMvH5gLh9PC7L8ytlPdgOW5SBjCcuLt4pVvGjRbIoJuBbMq5OMpUmBVs7?=
 =?us-ascii?Q?ykZNz6kLy3VBavurxNg4teo6jqJgxFbSyJaka4QAkA0Zqppz2sKN73noEu76?=
 =?us-ascii?Q?Y7z1v3atUXTn4b0Ms2PWagWmEhvXfBi7XIMfYEHjGhlo1Fp5Ed03oJOxKJT8?=
 =?us-ascii?Q?IbZJaD2RrVwL8trQypC4j00PoGj6CWYoREdVGlk3UjhKwzIBwlOlPe0Tdj2v?=
 =?us-ascii?Q?d5xz2pkfT/XAav4sE/0Cbz9ms6JXfc/5gQGT0RQoiLwVhRHGVr+M32w8/OC+?=
 =?us-ascii?Q?MZoZX2Lm1G1JBvz31wVeafZN6OwHNhjkNGYX3osG/z0TJlCIL3lO0lrh2RLP?=
 =?us-ascii?Q?fcnoj6yH3yeVM9HERC65XIFRfb76HqePom0aqQyos7WqfbCz87VquOCLhg+h?=
 =?us-ascii?Q?f9f4bBRZkVie9gVMWX5eUtcMkwTLV/uK72XaHRs3ptDR22/zrXhaR0B3AE1N?=
 =?us-ascii?Q?PQzkYPhy9IBssTciY8Wcl2JHKT77hKUvCzRiGGcwemcdF0qeWgpsj8nsCO4L?=
 =?us-ascii?Q?tBKYNuAVdv/30xVjK/bFD+3Un8FNGA20UBbBEDOeVPMvD/r/3D6MFC0GNSQW?=
 =?us-ascii?Q?AIeVvvuiSZvOTuVJnc85g9U5YdgeMNtCElyG1+VUoXIpKzCIq09fqcK2xP8d?=
 =?us-ascii?Q?L4Sl7JyJDumzKyLbDH6TfBlN6HyHnI1/2NWD+dux4VPVtpyQM9bbP6F3/yI3?=
 =?us-ascii?Q?64B2o22Okl4A8lB5HThVU6ncC+gs0pCZVSKq9QFYcwbXvk9i11Vnb+7qc57/?=
 =?us-ascii?Q?QueVIfbXknKyy8QqAM8nH7RRBLgbRXUbs0IIXsuWCKRg/c5wV0Mv6eeVmqdw?=
 =?us-ascii?Q?IdoLf0qjCZ9N3hTCOjpM6qT13AHh5DWI4J7vKQYLbB4VzF5/u+cV2+EN6971?=
 =?us-ascii?Q?VoQEa0cLDG+kWChGo3UczzZtIMJuRrU5uiyIjxlqZUZ8UUSdkv7A/3AnLsCM?=
 =?us-ascii?Q?mxQynJb1AThKSbFbS37ixz6kvn8YZRcFxKHtu0ZS8tUaAhtxzTk2ARkv+oVg?=
 =?us-ascii?Q?yPC4k5Njn1Mhka5oZwmnvNkk0li7TaFBvyxZD35/4ERB7KtpwvShGO/za1zq?=
 =?us-ascii?Q?Pu14VOsIjc4VpDm//u0HNZbZwm6qDhtG8RKB+fc7d5txf/UqeXRlsDZbiewO?=
 =?us-ascii?Q?vafMOd955kJ4g1TLvy/1MKA9BzhjejiJ3PprlzOHlzswPWFCZrcHsAw9om0r?=
 =?us-ascii?Q?3u/3BCX2SkHfJWgwfLYcPnkPmDP0SMn7AASzV9IU/mBR+J0qP8tQ?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 484b4a12-a52b-41c0-e857-08decfe3a99c
X-MS-Exchange-CrossTenant-AuthSource: GV2PR04MB11799.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jun 2026 22:23:04.5706
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2HxpUoIhJRu1u+Di+JiJHs8bKF+dC8B2zhBiFfbzBKniheySCXyEZV26u9M+kMDv5DWlie0hjnCJNWhHbyT7bXkwoIgkiLS4EN/eQMJyFYVJUQV7R9sgobV8ikW635ZH
X-MS-Exchange-Transport-CrossTenantHeadersStamped: FRWPR04MB11246
X-Rspamd-Action: no action
X-Spamd-Result: default: False [2.44 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[NXP1.onmicrosoft.com:s=selector1-NXP1-onmicrosoft-com];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[nxp.com : SPF not aligned (relaxed), DKIM not aligned (relaxed),none];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:alex.caoys@gmail.com,m:vkoul@kernel.org,m:Frank.Li@kernel.org,m:wens@kernel.org,m:jernej.skrabec@gmail.com,m:samuel@sholland.org,m:robh@kernel.org,m:krzk+dt@kernel.org,m:conor+dt@kernel.org,m:mripard@kernel.org,m:dmaengine@vger.kernel.org,m:linux-arm-kernel@lists.infradead.org,m:linux-sunxi@lists.linux.dev,m:linux-kernel@vger.kernel.org,m:devicetree@vger.kernel.org,m:alexcaoys@gmail.com,m:jernejskrabec@gmail.com,m:krzk@kernel.org,m:conor@kernel.org,s:lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-11701-lists,dmaengine=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	FORGED_SENDER(0.00)[Frank.li@oss.nxp.com,dmaengine@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,gmail.com,sholland.org,vger.kernel.org,lists.infradead.org,lists.linux.dev];
	DKIM_TRACE(0.00)[NXP1.onmicrosoft.com:+];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[Frank.li@oss.nxp.com,dmaengine@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[dmaengine,dt];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,vger.kernel.org:from_smtp,NXP1.onmicrosoft.com:dkim,oss.nxp.com:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 702736ABBF5

On Sun, Jun 21, 2026 at 09:40:58PM +0000, Yuanshen Cao wrote:
> This patch implements the actual support for the Allwinner A733 DMA

Avoid use words "this patch/commit",

Support Allwinner A733 DMA ...


Frank
> controller. It defines the new register offsets and bitfield mappings
> required for the A733, which slightly differs from the older `sun6i`
> series.
>
> Changes:
> - New register macros for A733 interrupt enable `DMA_IRQ_EN_A733` and
>   status `DMA_IRQ_STAT_A733`.
> - New `SRC_HIGH_ADDR_32G` and `DST_HIGH_ADDR_32G` macro to handle the
>   32G high-address field in the LLI.
> - Implemented `sun6i_dma_set_addr_a733` and A733-specific interrupt
>   register accessors.
> - Added `sun60i_a733_dma_config`, which ties all the refactored
>   functionality together for this specific hardware.
>
> Signed-off-by: Yuanshen Cao <alex.caoys@gmail.com>
> ---
>  drivers/dma/sun6i-dma.c | 87 +++++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 87 insertions(+)
>
> diff --git a/drivers/dma/sun6i-dma.c b/drivers/dma/sun6i-dma.c
> index 196a0d73b221..4808015934cc 100644
> --- a/drivers/dma/sun6i-dma.c
> +++ b/drivers/dma/sun6i-dma.c
> @@ -52,6 +52,15 @@
>  #define SUNXI_H3_SECURE_REG		0x20
>  #define SUNXI_H3_DMA_GATE		0x28
>  #define SUNXI_H3_DMA_GATE_ENABLE	0x4
> +
> +/*
> + * sun60i specific registers
> + */
> +#define DMA_IRQ_EN_A733(x)		((x) * 0x40 + 0x134)
> +#define DMA_IRQ_STAT_A733(x)		((x) * 0x40 + 0x138)
> +
> +#define DMA_IRQ_CHAN_NR_A733		1
> +
>  /*
>   * Channels specific registers
>   */
> @@ -100,6 +109,8 @@
>   */
>  #define SRC_HIGH_ADDR(x)		(((x) & 0x3U) << 16)
>  #define DST_HIGH_ADDR(x)		(((x) & 0x3U) << 18)
> +#define SRC_HIGH_ADDR_32G(x)	(((x) & 0x7U) << 11)
> +#define DST_HIGH_ADDR_32G(x)	(((x) & 0x7U) << 15)
>
>  /*
>   * Various hardware related defines
> @@ -257,6 +268,23 @@ static inline void sun6i_dma_dump_com_regs(struct sun6i_dma_dev *sdev)
>  		DMA_STAT, readl(sdev->base + DMA_STAT));
>  }
>
> +static inline void sun6i_dma_dump_com_regs_a733(struct sun6i_dma_dev *sdev)
> +{
> +	int i;
> +
> +	for (i = 0; i < sdev->num_pchans / sdev->cfg->num_channels_per_reg; i++) {
> +		dev_dbg(sdev->slave.dev, "Common register:\n"
> +			"chan num %d\n"
> +			"\tmask(%04x): 0x%08x\n"
> +			"\tpend(%04x): 0x%08x\n"
> +			"\tstats(%04x): 0x%08x\n",
> +			i,
> +			DMA_IRQ_EN_A733(i), readl(sdev->base + DMA_IRQ_EN_A733(i)),
> +			DMA_IRQ_STAT_A733(i), readl(sdev->base + DMA_IRQ_STAT_A733(i)),
> +			DMA_STAT, readl(sdev->base + DMA_STAT));
> +	}
> +}
> +
>  static inline void sun6i_dma_dump_chan_regs(struct sun6i_dma_dev *sdev,
>  					    struct sun6i_pchan *pchan)
>  {
> @@ -360,21 +388,41 @@ static u32 sun6i_read_irq_en(struct sun6i_dma_dev *sdev, u32 irq_reg)
>  	return readl(sdev->base + DMA_IRQ_EN(irq_reg));
>  }
>
> +static u32 sun6i_read_irq_en_a733(struct sun6i_dma_dev *sdev, u32 irq_reg)
> +{
> +	return readl(sdev->base + DMA_IRQ_EN_A733(irq_reg));
> +}
> +
>  static void sun6i_write_irq_en(struct sun6i_dma_dev *sdev, u32 irq_reg, u32 irq_val)
>  {
>  	writel(irq_val, sdev->base + DMA_IRQ_EN(irq_reg));
>  }
>
> +static void sun6i_write_irq_en_a733(struct sun6i_dma_dev *sdev, u32 irq_reg, u32 irq_val)
> +{
> +	writel(irq_val, sdev->base + DMA_IRQ_EN_A733(irq_reg));
> +}
> +
>  static u32 sun6i_read_irq_stat(struct sun6i_dma_dev *sdev, u32 irq_reg)
>  {
>  	return readl(sdev->base + DMA_IRQ_STAT(irq_reg));
>  }
>
> +static u32 sun6i_read_irq_stat_a733(struct sun6i_dma_dev *sdev, u32 irq_reg)
> +{
> +	return readl(sdev->base + DMA_IRQ_STAT_A733(irq_reg));
> +}
> +
>  static void sun6i_write_irq_stat(struct sun6i_dma_dev *sdev, u32 irq_reg, u32 status)
>  {
>  	writel(status, sdev->base + DMA_IRQ_STAT(irq_reg));
>  }
>
> +static void sun6i_write_irq_stat_a733(struct sun6i_dma_dev *sdev, u32 irq_reg, u32 status)
> +{
> +	writel(status, sdev->base + DMA_IRQ_STAT_A733(irq_reg));
> +}
> +
>  static size_t sun6i_get_chan_size(struct sun6i_pchan *pchan)
>  {
>  	struct sun6i_desc *txd = pchan->desc;
> @@ -695,6 +743,17 @@ static void sun6i_dma_set_addr_a100(struct sun6i_dma_dev *sdev,
>  				DST_HIGH_ADDR(upper_32_bits(dst));
>  }
>
> +static void sun6i_dma_set_addr_a733(struct sun6i_dma_dev *sdev,
> +				      struct sun6i_dma_lli *v_lli,
> +				      dma_addr_t src, dma_addr_t dst)
> +{
> +	v_lli->src = lower_32_bits(src);
> +	v_lli->dst = lower_32_bits(dst);
> +
> +	v_lli->para |= SRC_HIGH_ADDR_32G(upper_32_bits(src)) |
> +				DST_HIGH_ADDR_32G(upper_32_bits(dst));
> +}
> +
>  static inline void sun6i_dma_set_addr(struct sun6i_dma_dev *sdev,
>  				      struct sun6i_dma_lli *v_lli,
>  				      dma_addr_t src, dma_addr_t dst)
> @@ -1339,6 +1398,33 @@ static struct sun6i_dma_config sun50i_h6_dma_cfg = {
>  	SUN6I_DMA_IRQ_A31_COMMON_OPS
>  };
>
> +/*
> + * The A733 binding uses the number of dma channels from the
> + * device tree node.
> + */
> +static struct sun6i_dma_config sun60i_a733_dma_cfg = {
> +	.clock_autogate_enable = sun6i_enable_clock_autogate_h3,
> +	.set_burst_length = sun6i_set_burst_length_h3,
> +	.set_drq          = sun6i_set_drq_h6,
> +	.set_mode         = sun6i_set_mode_h6,
> +	.set_addr         = sun6i_dma_set_addr_a733,
> +	.dump_com_regs    = sun6i_dma_dump_com_regs_a733,
> +	.read_irq_en      = sun6i_read_irq_en_a733,
> +	.write_irq_en     = sun6i_write_irq_en_a733,
> +	.read_irq_stat    = sun6i_read_irq_stat_a733,
> +	.write_irq_stat   = sun6i_write_irq_stat_a733,
> +	.src_burst_lengths = BIT(1) | BIT(4) | BIT(8) | BIT(16),
> +	.dst_burst_lengths = BIT(1) | BIT(4) | BIT(8) | BIT(16),
> +	.src_addr_widths   = BIT(DMA_SLAVE_BUSWIDTH_1_BYTE) |
> +			     BIT(DMA_SLAVE_BUSWIDTH_2_BYTES) |
> +			     BIT(DMA_SLAVE_BUSWIDTH_4_BYTES),
> +	.dst_addr_widths   = BIT(DMA_SLAVE_BUSWIDTH_1_BYTE) |
> +			     BIT(DMA_SLAVE_BUSWIDTH_2_BYTES) |
> +			     BIT(DMA_SLAVE_BUSWIDTH_4_BYTES),
> +	.num_channels_per_reg = DMA_IRQ_CHAN_NR_A733,
> +	.has_mbus_clk = true,
> +};
> +
>  /*
>   * The V3s have only 8 physical channels, a maximum DRQ port id of 23,
>   * and a total of 24 usable source and destination endpoints.
> @@ -1375,6 +1461,7 @@ static const struct of_device_id sun6i_dma_match[] = {
>  	{ .compatible = "allwinner,sun50i-a64-dma", .data = &sun50i_a64_dma_cfg },
>  	{ .compatible = "allwinner,sun50i-a100-dma", .data = &sun50i_a100_dma_cfg },
>  	{ .compatible = "allwinner,sun50i-h6-dma", .data = &sun50i_h6_dma_cfg },
> +	{ .compatible = "allwinner,sun60i-a733-dma", .data = &sun60i_a733_dma_cfg },
>  	{ /* sentinel */ }
>  };
>  MODULE_DEVICE_TABLE(of, sun6i_dma_match);
>
> --
> 2.54.0
>

