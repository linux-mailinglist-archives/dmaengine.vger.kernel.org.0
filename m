Return-Path: <dmaengine+bounces-11722-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 8D5SDrtJOWr5pwcAu9opvQ
	(envelope-from <dmaengine+bounces-11722-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Mon, 22 Jun 2026 16:42:03 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BF266B0691
	for <lists+dmaengine@lfdr.de>; Mon, 22 Jun 2026 16:42:02 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=NXP1.onmicrosoft.com header.s=selector1-NXP1-onmicrosoft-com header.b=jvPCXo+8;
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-11722-lists+dmaengine=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="dmaengine+bounces-11722-lists+dmaengine=lfdr.de@vger.kernel.org";
	dmarc=fail reason="SPF not aligned (relaxed), DKIM not aligned (relaxed)" header.from=nxp.com (policy=none);
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 4BCD93040022
	for <lists+dmaengine@lfdr.de>; Mon, 22 Jun 2026 14:35:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A941A3BA24E;
	Mon, 22 Jun 2026 14:35:41 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013053.outbound.protection.outlook.com [40.107.162.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE3DE3BADA7;
	Mon, 22 Jun 2026 14:35:39 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782138941; cv=fail; b=Eb0KmrsuLMHVEbDWkebn15yvjtoR836zc7UnzOEplh3R95ql43nXxJ2ZNL56iF5y9Y1Fzhktj7lRMfCXwP+mwxjnqs3bh5cIL8Uv4i3QCOxJUp8sahPCxk7NdE15v/2UkGtp7gZgeU8wBfToEphEfG1eXRjzcaBv79HZbrDgyjI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782138941; c=relaxed/simple;
	bh=74+eRKNECZWx8esXmBhtMFetS/Ksb95CeM5VK0uBhz0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=UJgyeC9HY74wncGhf6PHELivo7pIlSjPckKldI70z69MNb4fADmTZBT4svAZ+FKzaRUirE5oQ0GU8ZhVxMVVtTX39y7AuJvxrTDkgNv3/NUPtS+QLX810OWe1HqedJbS+VCf+yjquP51ulTiSazzHKQ4qw0CrYownPMUHCFTtQc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=jvPCXo+8; arc=fail smtp.client-ip=40.107.162.53
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Q3xdSiRu9zvNieewsT1zhyD8VG4GZxltHgx/keawI494YgBOWUn4R+RHot6XO7UNiedIaEMHzf78oDsm3jovEA3YDYAoKe/GTmvaAD35Smuiif8iwf6ER7LN9cVHBVE09A3BSwh+rfb5vfNhzwhPlNbXIH0pZgPJVEawwX5wFdeHalVe9HIsGhgWuLVNn5MQoefHnfB5EqHSLYRIELeVIBSTOYBq9HAAdAy0mbfmkN5FPluT36sKr3EUIolgd1DDK8YwGI+WWll5dleKn1yYTMEkJ0AiQvbZxmZDq1FqkLKFJbS9oOf7PFYmlsIzcddE73RiQpk39m0m5XsEW8JXZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=69KndXKzUOqKyPGigwi4mP17g46k7wk7JWL7PxcvU0k=;
 b=w194ZJ4/uCqcHxlq8pTpJLWLzCHHKvXfRZjPclbviok6F7kpe20nL6bii0WZRZLgq4GlPhBda5uRoZ5CSozpg+6BSHzxCCXp3EkVDmZhMxRJebUNa+a8VHRa0zMYaIPUBHVgubi2cUHS5XBnmktMhXdUWLa67oYzCHO0DsaELgvrfQ6f/dvUiMmxlMxMwc8dTy2ilwaLkXX0ke0stwuK+WVFnC57Haflv/I54WCZise7U4zbNpy4DDgm3EFG96wK2j58omHgnd3VaPeD6n32X6cZDhqG6RIvSy5xjqT0fSlXKSuIEMsrxDj85RvScYab06/adJREwA3mplxcf+Do4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=69KndXKzUOqKyPGigwi4mP17g46k7wk7JWL7PxcvU0k=;
 b=jvPCXo+8PaL+ewihehBeM31pjxT0eqck7IppdQlIH0pbLBJm+AbZ6DF1U9Yupnwizs707z68TXB7SOuAEr47hSjhDjPrgpsQZoDxd+zOmxb4FkaeUJ5BE8nXVbwTcyoP3bdwIAcQ8QSP96Q12fEq3d9tUXytIZmb/o8VJ8NBZaFY/xaVEagvMWDVoiPer/5eULPj9MQF0SPYFDKYSUad3Y0nWOOCoT1RVnPfCFU6+q+caFKFJ6Dgq41mCDhxXniWY8/Wjwj70rRAGmGaNqlmRdLL9uAQaZ4Bob1EXfcBUVMT6G60OOZF+lXj03MN9qi992PmrO8wNx/XE5+6cDaxYA==
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com (2603:10a6:150:2cf::9)
 by GV1PR04MB11038.eurprd04.prod.outlook.com (2603:10a6:150:211::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.20; Mon, 22 Jun
 2026 14:35:33 +0000
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c]) by GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c%6]) with mapi id 15.21.0139.018; Mon, 22 Jun 2026
 14:35:33 +0000
Date: Mon, 22 Jun 2026 09:35:21 -0500
From: Frank Li <Frank.li@oss.nxp.com>
To: Yuanshen Cao <alex.caoys@gmail.com>
Cc: conor+dt@kernel.org, mripard@kernel.org, krzk+dt@kernel.org,
	robh@kernel.org, samuel@sholland.org, wens@kernel.org,
	jernej.skrabec@gmail.com, Frank.Li@kernel.org, vkoul@kernel.org,
	dmaengine@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-sunxi@lists.linux.dev, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 5/5] dmaengine: sun6i-dma: Add support for Allwinner
 A733 DMA controller
Message-ID: <ajlIKQeGY-iJg2sc@SMW015318>
References: <20260622-sun60i-a733-dma-v3-0-f697ef296cbc@gmail.com>
 <20260622-sun60i-a733-dma-v3-5-f697ef296cbc@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260622-sun60i-a733-dma-v3-5-f697ef296cbc@gmail.com>
X-ClientProxiedBy: PH1PEPF000132EE.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:518:1::36) To GV2PR04MB11799.eurprd04.prod.outlook.com
 (2603:10a6:150:2cf::9)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR04MB11799:EE_|GV1PR04MB11038:EE_
X-MS-Office365-Filtering-Correlation-Id: 7b6bd9d7-8e5f-456c-25db-08ded06b8454
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|19092799006|23010399003|7416014|376014|18002099003|22082099003|6133799003|56012099006|4143699003|11063799006;
X-Microsoft-Antispam-Message-Info:
	qEw/0yZ1ep+3Jw56w9/jWkBtGtfeUNg7oOyf6mAoPbNTFo1PsGSWYfXvL9Q8RiDW6rpdlkXPC7jglhCXeSKUeE7BV6hcF07X+jKDAiGhhqrBR308mv/fpzOqHKL6vdbMMvpQ9UvotsAMcTaKg11e8eWdEah9E20NMDIjQTqY6ssIQtU8p6nS0U941XXQF9jLdWA2cJHIYWzpr0Rc172oFMTGp4gAHBM1wR+6PRh4RFCWYcoBWJ/RvhUh03tUwl+wVyHIiI11eHXPmZAHMDbZ30Ngs9Yw8Be5y1lKo1YeNrztFNgtlCqjuDBnVyqThKhr8/L/xVv6DnpKIQkRufHcCJPDylnhQS8S+wsPEikT+DE5nNkZLJDKvnjos/lkl5Z3q5Y3E2huXcdeVkdqASXa1kezzPEuvJQwGWyfgFJ/Wn8eS9Gn7UChj9VeL9FuuYKuJKyAiar/KdKgMBTEzNj8Z8DD2H6xcANyUB474hERVV+hYC8sVlStKIgT9Ih29Bfv3Ou+jnqtNTaINi1tV/0Wr7zps/1b0L2eh35oCJwIG+wpHkXspFEEFbkmSYiMs7wgCy6TzYMeLP8HlWkPuZiUBLHlYZjqnBEFZJPhDtbURGFXib+8K+U97C0apIaldeKAuTjIBIChdIjdMaaJoNWCXs/kcq4pvzEFN5BoAXHtaEA=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR04MB11799.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(19092799006)(23010399003)(7416014)(376014)(18002099003)(22082099003)(6133799003)(56012099006)(4143699003)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?LFzyG0QbzWKMgj6+xJ5bT//kK+j3p2ng3OFcJiJVPHBLI0wxfA5eKqlIGGK7?=
 =?us-ascii?Q?luRNYxgDuE5gN8Ie/gbc4rT5ypM1NzJ5wModBn/YmjzXVmsCfMUmHvECYnLX?=
 =?us-ascii?Q?pBH2TfLxxe5pqmxYHk98DoTOJahAtXx84wpEpkEY0VKlrNLg3Epj/KQ+WnUy?=
 =?us-ascii?Q?a6DeaqhM3z5gzc3Ux0ersnzqhh6ZuVXIGuOp39s4ftnO7ZtfSLZ7V4RzLzit?=
 =?us-ascii?Q?tR+eehFX1+/BJRV+OWoOZigKO5QzXDR2+GSbUT+95sFtDY6Sql79c9+uXRre?=
 =?us-ascii?Q?zNLOrNUoik/iC+cqI6/n80wPaF6Pd2R9giYEosd2WUEk18NgSvS/1VARo6xx?=
 =?us-ascii?Q?uG7bGfUjCEpIKzmLulV5ImMNqFHsttiIfVOYh+qRTaiibnvXmZQ0dhq4IFED?=
 =?us-ascii?Q?R5rxvYJExtKAyviR2GhrhGLbjgdd59zRjpcDIahg0U77QN5fee5EQlzqrmA5?=
 =?us-ascii?Q?KmxFt+RJd9urAL6xyOzADn65PN5jIi3SVaONJO81Ea3VojwtYYt5c1T9+mmK?=
 =?us-ascii?Q?Kw20OljwW9kNw2ORsiwT8arbM5C7TgbmgwXNT3t752jJ6Qbm2PKiJ+Tx+8Jz?=
 =?us-ascii?Q?xN501mR0ikljTInxcuG32c5KhjQDN+yMRXgHOHGvLE38ounuTM0q/JPK1rPB?=
 =?us-ascii?Q?vMKTLjKYWcT+iROL6+WhYiKKSAxHrwODb51CMW8BEkYGIapjS9ony/YslrwY?=
 =?us-ascii?Q?xZvQcczru+F/4H35BKpvFi8wWSkCCkHhUuTnMpGnQsR4H/pWY/knkkJuYz0g?=
 =?us-ascii?Q?R/bltuZEKL0KuhyPghrhm1EfDNaP4MPm9dvlQzoE+RM9Q6MhwfV0TruOZLhN?=
 =?us-ascii?Q?kp9oYw7PSJlHwsAwlWzqvi0CfYER0AXA/O14e1qzcCTcU7Kb4XgQ8Ajs2Q5p?=
 =?us-ascii?Q?shxlSsjO0vTj9sKr7FY0RGTDFniRk41KsgegzJVxMWkbr1otDgh77/xvP38k?=
 =?us-ascii?Q?GEWXTy+AT3wduAH3oYciK+uLEXHI1V8tnhj1qzp5nGA4G19LWfls8vdUlKxp?=
 =?us-ascii?Q?rXk9CHJWrVNJviicCw/AkqP7TemFKvmkwGjey85jtFsW5WEeDik8hbjRmHs6?=
 =?us-ascii?Q?zjCQLn3uwQInRkWypjGthJZsIMbyfA158wqTkXzuAAIqxC7fGi6fkMUFjrix?=
 =?us-ascii?Q?PpFwII6EJ76l5AjH4CMedzxZFR6gjsP0fcYV7XYs77qZJhrAydIlc39rad57?=
 =?us-ascii?Q?WpMkF4ZSlLS1XGZSEdVKQkgTGyZvYHweVLjQ/z/971+oYxufOkqMo4C+oC8c?=
 =?us-ascii?Q?FkmDUybI7ZDquzTUXzaIH9HhgbyxWOheDBLcCeyJ57KMLNkauRuDkWn/tMfO?=
 =?us-ascii?Q?YzswEF5SV6OJT9wkmvZJCYmk3pRJ9RKVIgLJdDHiChj/2G5RFWnFUksqy5aC?=
 =?us-ascii?Q?Ppuhj3Rp6FDKOkjetoIkculOq0Su8GXHhoGwzfPBmLwPrPt/XdZiBb53oKXf?=
 =?us-ascii?Q?BekDRjZxrbMeZkM0pbtb0FqK5iEKdq8rfe9VcleuAEAb2cmzY3uvIysxKDhU?=
 =?us-ascii?Q?eemI9nbC0PBD1PI8PTwJtYOTrOrG+N+84ugcP2y95e3ijth6d0tbe68cB+o2?=
 =?us-ascii?Q?396Rp10eA+bZpKVsBArZT3wka9I12+AUQXQqFh9Rqnh49WFYxP4jxmbz+S10?=
 =?us-ascii?Q?s8cpwAkb0sBZlwHKUw50/vGCaI8KmR0NIPSlmJFHJbdZopeJiU7+4YcZXTKO?=
 =?us-ascii?Q?jwaz0Szmvc+Xj38zij7y18q3skDXzgmqcSYWJIP9z7RgOo/CTPaXK8pgGgBV?=
 =?us-ascii?Q?Zw5PPEurEz71SpjS1+16exFYW64E+HZH+ZZcx5HRU3iQoPeCAHer?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7b6bd9d7-8e5f-456c-25db-08ded06b8454
X-MS-Exchange-CrossTenant-AuthSource: GV2PR04MB11799.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jun 2026 14:35:33.6519
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4JYHvApvkcczfj2G6SIyY4Pt1EYYpktXqPDOzyrV5GKA22g3ItQr8rxD5XSfhtrLk7iCIKGhoSja9Wg7TK46n4IWcw/ihtmKkrFr12iG3cCPcofcmbTtrQKhCBrYmGrb
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR04MB11038
X-Rspamd-Action: no action
X-Spamd-Result: default: False [2.44 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[NXP1.onmicrosoft.com:s=selector1-NXP1-onmicrosoft-com];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[nxp.com : SPF not aligned (relaxed), DKIM not aligned (relaxed),none];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-11722-lists,dmaengine=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[Frank.li@oss.nxp.com,dmaengine@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:alex.caoys@gmail.com,m:conor+dt@kernel.org,m:mripard@kernel.org,m:krzk+dt@kernel.org,m:robh@kernel.org,m:samuel@sholland.org,m:wens@kernel.org,m:jernej.skrabec@gmail.com,m:Frank.Li@kernel.org,m:vkoul@kernel.org,m:dmaengine@vger.kernel.org,m:linux-arm-kernel@lists.infradead.org,m:linux-sunxi@lists.linux.dev,m:devicetree@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:alexcaoys@gmail.com,m:conor@kernel.org,m:krzk@kernel.org,m:jernejskrabec@gmail.com,s:lists@lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[NXP1.onmicrosoft.com:+];
	RCPT_COUNT_TWELVE(0.00)[15];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[Frank.li@oss.nxp.com,dmaengine@vger.kernel.org];
	FREEMAIL_CC(0.00)[kernel.org,sholland.org,gmail.com,vger.kernel.org,lists.infradead.org,lists.linux.dev];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[dmaengine,dt];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_SOME(0.00)[]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 9BF266B0691

On Mon, Jun 22, 2026 at 01:36:27AM +0000, Yuanshen Cao wrote:
> Support Allwinner A733 DMA controller. Define new register offsets,
> bitfield mappings and dma_config required for the A733, which slightly
> differs from the older `sun6i` DMA controllers.
>
> Changes:
> - New register macros for A733 interrupt enable `DMA_IRQ_EN_A733`,
>   status `DMA_IRQ_STAT_A733`, and channel count `DMA_IRQ_CHAN_NR_A733`.
> - New `SRC_HIGH_ADDR_32G` and `DST_HIGH_ADDR_32G` macro to handle the
>   32G high-address field in the LLI.
> - Implemented `sun6i_dma_set_addr_a733` and A733-specific interrupt
>   register accessors.
> - Added `sun60i_a733_dma_cfg`, which ties all the refactored
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

Because the previous code use this pattern, I provide my reviewed-by tags.
I suggest change to use GEN_MASK and FIELD_PREP macro in future.

Reviewed-by: Frank Li <Frank.Li@nxp.com>
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

