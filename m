Return-Path: <dmaengine+bounces-8804-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4NkWAjBBhmmbLQQAu9opvQ
	(envelope-from <dmaengine+bounces-8804-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Fri, 06 Feb 2026 20:29:52 +0100
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 771DB102BF7
	for <lists+dmaengine@lfdr.de>; Fri, 06 Feb 2026 20:29:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5F8023009F82
	for <lists+dmaengine@lfdr.de>; Fri,  6 Feb 2026 19:25:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 797172FF651;
	Fri,  6 Feb 2026 19:25:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="TgBXMLkp"
X-Original-To: dmaengine@vger.kernel.org
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011056.outbound.protection.outlook.com [52.101.65.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1557A23BF9F;
	Fri,  6 Feb 2026 19:25:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770405948; cv=fail; b=tcf7CL/r2zpav2gU0GlOzrWwGrZa0F63QcfgAk7O4RKsh6RU0sJoeoj51wZQhguC2LCSDxLwE6cogn5ksP4iVBy7OkGzpjd5J7eQn7porSi7V0dEz+9tdwVIO5EZL2nEWKR24egJgmDsiorsCYV/U572pUhVxWibksMbc2xhnJ0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770405948; c=relaxed/simple;
	bh=l0fvriboSo7hU3TJUzxrchUVzMSL3j6z6PXsVVrjO/Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=AU8c0bagYvNU3/5jecTp4iNs7+91qEnRL2bKdv+0+ZXdWH8kluhAQhRXNP3OVKkYJ8xSPkQE+JwjyPX02vzcIPZ0ijeu3cY+YTLa1rY8InbMqdMWSIxAMHzJ1DjAH9BZ0q/wmO0iTj766q3VN8TOsf4ipwPxpd+3GML/y0Rul+s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=TgBXMLkp; arc=fail smtp.client-ip=52.101.65.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=l+XlCiq5UVFbpklZ/ufySJxe5SHS4emOca/NPFpMpaCddrbScUJ9s59f5sqldaAVa1O4BD1aPvQWyUKKcQIUZQ+XpTCRtGzeNpAcgtL9KtsQ1MGtc8IT/sZlsKZgF3Hbx+P4xs2cbzRWGmMnhPTXk3sWsRhmVCMQeyASWQY8AUfadrCnDJSQ3EQeGJH7VZczKLmLKVs9nZHDEVIwb4ZxjVK9C2+vAvp5GbfkgW7EuNFfwfr7eaWa2svKahhoZ7d6cuCJe1a2AVMquOstt61RhRYo9FP4ukBO0x0wHGPigJLC6OoZKFWBqaao+cOjrMGPlAIAyNdyNLOfNWb4iPoK9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=s1WBAjUR4A0qGikeGK5VJ75j8l+n1Ieo6GoAx3jvZLw=;
 b=WJr6soVVCSvE2acs73GceZDhQD9NoIfFFIV+9VSfP64OvrH/LgCUvQrgztJoWXXOf5HkNuuCmfZoZggUB0LxxNU9aN9ib5oyNG18bR0bb2DYBrwIuTWb7heoPj/aeg9k7ap2IUT+LZ7BebaEjjumwAkNqGVjDvlJzvtLpJc6/jKJUMd/DjxyPmWwfEHXTFbYrWd+jFNkDBUK/266cneosOoysnFUs+7tuP/hXyHeDTlUGZzkTqTSsxOM08ZWQ4aSxSk96ztxVawo1n+IV8S8WdN+dkEh0Qu98m+y05SEqOm9Af8P8+YGi/C8dUJfnLvcznNmfpX3XoAWq/4GKzhndQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s1WBAjUR4A0qGikeGK5VJ75j8l+n1Ieo6GoAx3jvZLw=;
 b=TgBXMLkpd0VSekpYeWSI10Xx4VKCdrtxTAytp94lxxrJd4ps4FQUySOLpRlVNNqgvgNyolGkWtqLygF/Ma7fKqIfjyGX+6RCnImECxpLOeFprBv7aejfzUoYI7/39KO3CbVofzI5t9emAdTlzHSiqC7GgmwD5bmR9gyhhixeZAXBthPbHa2fHJkp1WrqJFg1y+i+AagA6dMzrzF22iKpkKd0Fz3iNylK9ShLwekESQEcVzFk+APA3DaHtqgeT+ht/QXad5frtUndRt7zTKfU3om8gVUf98aDLcuXua/SgkhCHYeWpvsiYp8LF1Qbj5LNpzW5WFKuS2BhZHcb/5bwbQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PA4PR04MB9366.eurprd04.prod.outlook.com (2603:10a6:102:2a9::8)
 by DU4PR04MB10402.eurprd04.prod.outlook.com (2603:10a6:10:55b::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.13; Fri, 6 Feb
 2026 19:25:45 +0000
Received: from PA4PR04MB9366.eurprd04.prod.outlook.com
 ([fe80::75e4:8143:ddbc:6588]) by PA4PR04MB9366.eurprd04.prod.outlook.com
 ([fe80::75e4:8143:ddbc:6588%6]) with mapi id 15.20.9587.010; Fri, 6 Feb 2026
 19:25:45 +0000
Date: Fri, 6 Feb 2026 14:25:36 -0500
From: Frank Li <Frank.li@nxp.com>
To: Pat Somaru <patso@likewhatevs.io>
Cc: Tejun Heo <tj@kernel.org>, Sven Peter <sven@kernel.org>,
	Janne Grunau <j@jannau.net>, Vinod Koul <vkoul@kernel.org>,
	Neal Gompa <neal@gompa.dev>, asahi@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, dmaengine@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dma: apple-admac: Convert from tasklet to BH workqueue
Message-ID: <aYZAMPX8tLU0fV1v@lizhi-Precision-Tower-5810>
References: <20260206090137.1127897-1-patso@likewhatevs.io>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260206090137.1127897-1-patso@likewhatevs.io>
X-ClientProxiedBy: SJ0PR03CA0377.namprd03.prod.outlook.com
 (2603:10b6:a03:3a1::22) To PA4PR04MB9366.eurprd04.prod.outlook.com
 (2603:10a6:102:2a9::8)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR04MB9366:EE_|DU4PR04MB10402:EE_
X-MS-Office365-Filtering-Correlation-Id: e90a0ef3-c13b-43b0-82da-08de65b58641
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|7416014|376014|1800799024|19092799006|366016|38350700014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?bTa5A1xPT3GbQk6b6M4DgoFj+DNJp6uqosygtlZ8N0qiOy0lUJlriH/wnywN?=
 =?us-ascii?Q?uCBFt+yqNIiNzS2zUxh8xd1tSyw5YnEcVIq2q0KPo2pGspuppCnzGOy2Vk4P?=
 =?us-ascii?Q?9kMXS56hpBg6HDljRu3V7cUbjZcf4Nlj/rWZJUL9wGX7/QhoqDI4jGDMKXCe?=
 =?us-ascii?Q?HwDcnkgEVK6Xg4N14ymE4bt4muD0Q/0N+DVp55srUtCnfbm0rpZjXtSgDrbD?=
 =?us-ascii?Q?+9Iys44IAF1kzW3W65RCZJ/O4BpcYa09whtTWqoINd6gJZY4Z1CYP5mBgCwc?=
 =?us-ascii?Q?E/4jsYv0sCCO2M4ePaqQo5Q5sI3bydo7qoh19sUa3Px35FeqrAN+EAVI3fQP?=
 =?us-ascii?Q?UndKM5/4fbMeDaz2xUI/ngLwCaG3HQ4QA4tLWrgFbB1pn6Ge9Hi71c0ZnpNo?=
 =?us-ascii?Q?WIFKjq91GlX7gGecLJnU0L5c4Wj5lUAe5ktHR8CsNjErD1z9FnKQ9aBbCjum?=
 =?us-ascii?Q?Uu7NPmkSGTJsL5FPt9S8k7UHP5GGNFZkuF1mQBNcWcon8zzfdXxARdrroF+A?=
 =?us-ascii?Q?DgDG6Y9E9//dryGeyGGeANvhgP22gP5CB+CPTy3bYoE5eK9zJX0/RSKYsYcw?=
 =?us-ascii?Q?IU/nNUxULo37LWcVLIMsLBp8LQ+aBjhBNzjbCyrsBBHqKqMZnehlym0LVQpl?=
 =?us-ascii?Q?9cvAhvI1yEmgJF3PSiSg5vkDwaTdyVlErRErCRptdPWY/rxTbuN83vlxByON?=
 =?us-ascii?Q?ZDDZ3P+KmsCpegYk2y0B25NBlQGkQBUo/6JXBlAQXu2jmZ5xGI9dFSfw9l8v?=
 =?us-ascii?Q?cdQGZbkqUAjxaS3QOfpkjjWzDhLw+y6dFLKE98Rlwt4iT4lNwg1F20EKIKS4?=
 =?us-ascii?Q?7UKwWN3TYuIOSM8zRVo6p4v1uDVMXRXIMC9qI9lAa0zZ7RepmbJDYKLNuoHk?=
 =?us-ascii?Q?Vds+Zo9Z93DDCk7w7nDEr3xOtrvhamwrVicRihq+KYb6nte8103Rr7+612XF?=
 =?us-ascii?Q?T7Q7G9oNvWnhzDkiIbcVmKPDVOCE53SCd7Gfw1ELTaeHKAjQUxVNoYIE2Irw?=
 =?us-ascii?Q?wysPs1lgSua03ogFrYRsHJGuVnyqOQT2tI/NzJbwVnTbamctDslj8jGt2tlz?=
 =?us-ascii?Q?wef2eREWBtf1WZjv8BTsSF2xDShmPBLGS//21CXvdFPZ/Gz9e157GzyFSoAk?=
 =?us-ascii?Q?ShppGVvPeA6Bpc0xZW3+dmfSxg56Wcj16EIP7snnuDKjA46FPT2O2CAETRqg?=
 =?us-ascii?Q?OrLRmGmcWwXbjyzpOD3M11a/BbNAmX31TZx2lM0gWgzG0dh5G3ox7fzr8+8U?=
 =?us-ascii?Q?PytURza8u4zD7CX5NIMJvaxZ9gxkidcppMK5SYX7ekCG/KjbQ1EO5KqXmuSG?=
 =?us-ascii?Q?OFD2PAs/0RbvlLhwPhinUh5HwCg82rBGPAtbkvMTXy1hxU31Imk8MRGo2ISi?=
 =?us-ascii?Q?E8rAEwlNdvsUm46IpGMDb6g618SjwliVpAUKFz45XCaLmCRbEKwZdLnOhnZp?=
 =?us-ascii?Q?0A+zYAJUR7itQprMWfvLhO2zqhjxE8xHbUk5ehi+rI2Uff1TnfZnRPSwhBaK?=
 =?us-ascii?Q?iFlQDQ0cpbNjL5vLpV6PFdKVzYzpMm7wOWMr7k1TDST0PGYgH/urye9PXaVA?=
 =?us-ascii?Q?3owb45DyWaGDpfMUvfYfzJC4ekQ8x+3PWcqChFtmCgdANYj/hlPs29Ry9B+N?=
 =?us-ascii?Q?hN64ao3yi1bVAhMafsKNw/s=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB9366.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(7416014)(376014)(1800799024)(19092799006)(366016)(38350700014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?N8xpAWPxSm7Pgo0RM7ylYRMAwxvixAxWQ6zftWVaVcRub3QSCjbRQahiCaQv?=
 =?us-ascii?Q?gaM8m+VIGDghuaL94MAeV54mocTCNuSi7UiWzX/D8X6dkr+D+L0juEZ9KyMv?=
 =?us-ascii?Q?qhVwEXHGt1ca3Hmg6YCZF4uAQecv0eGXpMF9r202paOdG++IiWRyatxyW3SE?=
 =?us-ascii?Q?5Sy1Aa+SP0W1XYLe+H3a0n5gEfz1VFCEqxXttEkfeha1lfRnUw1lSpcaTisl?=
 =?us-ascii?Q?j2F9zDSifeusRezc5Pso6mIkWLu1UhAKh/8zt6UyjFqjqjedx3mN/b5VKpVC?=
 =?us-ascii?Q?mWKZn5Xk+ammv9+aGCf1l0bkd9i6e2qq4CBa1uIhyUb45qzkZk1cD32uWF5N?=
 =?us-ascii?Q?DerpBpTsfKpuW8lw1Ov2T1UxeATm9aSl7OKo3Mp4VqGJP1eS4iVKRmawzrX3?=
 =?us-ascii?Q?X9AIg7o2qFg9SkhOIeiU0ct5MOWACBrIiJNE+OpXOdsZwLcP0wj4g6MnET/i?=
 =?us-ascii?Q?ydaqgnCQXh/evWLLXYIYC39PXFjW6Kw7+h06V/P1WkJlgyn7qq17D1fKZnIQ?=
 =?us-ascii?Q?hszjochfuDexmfh+YXJOz7IQ0JYQKRtOwalLBfSI6whEtel6+6/wE0jHtzc2?=
 =?us-ascii?Q?54Shc76IltVPdcB4ggB70WNJ0gi3RCnzC143cWj/8oQaZqRVKD1Ly+8zO1IF?=
 =?us-ascii?Q?B39fGiY8sxbpFAkLikSTVOV8IlYnWum7zyAKm4wXhfHdEhUWZ0SIw56jihLg?=
 =?us-ascii?Q?iT4JPdkbW4pKZ3CgkpDFqc0O5/qNIq+4tfWnabGmytA4y28P6uT8NnAiVseb?=
 =?us-ascii?Q?uauyx0UfVglneyiIbtC/cKUVBFM/+U0Lv4YujPsWDf+1/VJrROVYhENkF2Oq?=
 =?us-ascii?Q?xCOE3QkS4qPjT9AUySTEzMKg1CMDetb1P1iSXKBdhLcKE2Tg6o2d856mEY75?=
 =?us-ascii?Q?7X+ICyOrl5vk3HdPTS1yFOmn/f7DRiNpRl7chGs/o5y34Ict9s71le37e9zr?=
 =?us-ascii?Q?IXXY5KJswHnoZQt9VMWifsI9Qqr0lLCKMcHiUpx4/2hrO3Kgv8znAg1SetCV?=
 =?us-ascii?Q?ecqdyhRLqkqfJNTwPpII1IaWGxn3WTsooSlzlJ7/tphcUzJmDre44ItgB9WJ?=
 =?us-ascii?Q?1YJDLXpdEdIstsz3MnBw+vq6RbMjjjnjSfAdQnMamAAI0vN9s/qxwaKMqVPE?=
 =?us-ascii?Q?kDno4FVVyyPEOWrnkEegVcXbANsWLL9ElRtHT7j0CKj0OlW4eXuRl713sS/T?=
 =?us-ascii?Q?wUmjEFBx0jjPJnuX7YTB0fd5NmQ5VRLDj9b8q3clKamqiBNgdQ0M/QRMwgsw?=
 =?us-ascii?Q?2Av9dcCW0GsbJ+lU0fsKumqYIY+Z92xvAGHe5q7lltJG7JGORIJj33dXdB8Q?=
 =?us-ascii?Q?WX3DKWrJPtXoskW/cPuyZqgIZZyfvt5rQpQyM5LfzJT7L8lliT3rrWtF71bR?=
 =?us-ascii?Q?ONY6C1947/8nVcqE7MLGrKa1+6KrI4gIbAT1tKANzjYPuTwJYbzuE/mXOr9H?=
 =?us-ascii?Q?GWj2fKvGcoeUHgdDZER3wC1eJ5UD7hnmOKNuM+rHBv+C5M92lm0DVH8CMMEj?=
 =?us-ascii?Q?gy6TWCQqaN5xKEA3koNCDsox+kzCV/OSUlmUBny/E+CQoGvPNco+kb3S4yjF?=
 =?us-ascii?Q?6I8rEg6HISW+R3oCtQNiZy0zUju3fB7kCHmyr/HRhyw6syU19gIq7ErKySPb?=
 =?us-ascii?Q?E7rbRlKGd80zHM3TvOp6cyksHL0rYZCGaEk6IJA3XPgjWSrQGhhcPtDs8sEM?=
 =?us-ascii?Q?2nRWrZF2CkGPAEmBD15SrQU7wWudG2dlwoAYgmbRkdk+bxpNyiKgugLjuYCf?=
 =?us-ascii?Q?Y6YsBRTMDQ=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e90a0ef3-c13b-43b0-82da-08de65b58641
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB9366.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Feb 2026 19:25:45.0941
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QqgzuEK4loeU+gSey8zkqEU3wz02iKrjLqDJlW4GX1c6OgjfOm1vRYGS2k7F1zjBwmpzNV6w4JuI1J70CR+yuQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR04MB10402
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
	TAGGED_FROM(0.00)[bounces-8804-lists,dmaengine=lfdr.de];
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
	NEURAL_HAM(-0.00)[-0.996];
	TAGGED_RCPT(0.00)[dmaengine];
	RCPT_COUNT_SEVEN(0.00)[10];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nxp.com:email,nxp.com:dkim,likewhatevs.io:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 771DB102BF7
X-Rspamd-Action: no action

On Fri, Feb 06, 2026 at 04:01:37AM -0500, Pat Somaru wrote:
> The only generic interface to execute asynchronously in the BH context
> is tasklet; however, it's marked deprecated and has some design flaws
> such as the execution code accessing the tasklet item after the
> execution is complete which can lead to subtle use-after-free in certain
> usage scenarios and less-developed flush and cancel mechanisms.
>
> To replace tasklets, BH workqueue support was recently added. A BH
> workqueue behaves similarly to regular workqueues except that the queued
> work items are executed in the BH context.
>
> This patch converts drivers/dma/apple-admac.c from tasklet to BH
> workqueue.
>
> The Apple ADMAC driver uses a per-channel tasklet to invoke DMA
> completion callbacks for cyclic transactions. This conversion maintains
> the same execution semantics while using the modern BH workqueue
> infrastructure.
>
> This patch was tested by:
>     - Building with allmodconfig: no new warnings (compared to v6.18)
>     - Building with allyesconfig: no new warnings (compared to v6.18)
>     - Booting defconfig kernel via vng and running `uname -a`:
>     Linux virtme-ng 6.18.0-virtme #1 SMP PREEMPT_DYNAMIC 0 x86_64 GNU/Linux
>
> Semantically, this is an equivalent conversion and there shouldn't be
> any user-visible behavior changes. The BH workqueue implementation uses
> the same softirq infrastructure, and performance-critical networking
> conversions have shown no measurable performance impact.
>
> Maintainers can apply this directly to the DMA subsystem tree or ack it
> for the workqueue tree to carry.
>
> Signed-off-by: Pat Somaru <patso@likewhatevs.io>
> ---
Reviewed-by: Frank Li <Frank.Li@nxp.com>
>  drivers/dma/apple-admac.c | 17 +++++++++--------
>  1 file changed, 9 insertions(+), 8 deletions(-)
>
> diff --git a/drivers/dma/apple-admac.c b/drivers/dma/apple-admac.c
> index bd49f0374291..8a0e100d5aaf 100644
> --- a/drivers/dma/apple-admac.c
> +++ b/drivers/dma/apple-admac.c
> @@ -16,6 +16,7 @@
>  #include <linux/reset.h>
>  #include <linux/spinlock.h>
>  #include <linux/interrupt.h>
> +#include <linux/workqueue.h>
>
>  #include "dmaengine.h"
>
> @@ -89,7 +90,7 @@ struct admac_chan {
>  	unsigned int no;
>  	struct admac_data *host;
>  	struct dma_chan chan;
> -	struct tasklet_struct tasklet;
> +	struct work_struct work;
>
>  	u32 carveout;
>
> @@ -522,8 +523,8 @@ static int admac_terminate_all(struct dma_chan *chan)
>  		adchan->current_tx = NULL;
>  	}
>  	/*
> -	 * Descriptors can only be freed after the tasklet
> -	 * has been killed (in admac_synchronize).
> +	 * Descriptors can only be freed after the work
> +	 * has been cancelled (in admac_synchronize).
>  	 */
>  	list_splice_tail_init(&adchan->submitted, &adchan->to_free);
>  	list_splice_tail_init(&adchan->issued, &adchan->to_free);
> @@ -543,7 +544,7 @@ static void admac_synchronize(struct dma_chan *chan)
>  	list_splice_tail_init(&adchan->to_free, &head);
>  	spin_unlock_irqrestore(&adchan->lock, flags);
>
> -	tasklet_kill(&adchan->tasklet);
> +	cancel_work_sync(&adchan->work);
>
>  	list_for_each_entry_safe(adtx, _adtx, &head, node) {
>  		list_del(&adtx->node);
> @@ -662,7 +663,7 @@ static void admac_handle_status_desc_done(struct admac_data *ad, int channo)
>  		tx->reclaimed_pos %= 2 * tx->buf_len;
>
>  		admac_cyclic_write_desc(ad, channo, tx);
> -		tasklet_schedule(&adchan->tasklet);
> +		queue_work(system_bh_wq, &adchan->work);
>  	}
>  	spin_unlock_irqrestore(&adchan->lock, flags);
>  }
> @@ -712,9 +713,9 @@ static irqreturn_t admac_interrupt(int irq, void *devid)
>  	return IRQ_HANDLED;
>  }
>
> -static void admac_chan_tasklet(struct tasklet_struct *t)
> +static void admac_chan_work(struct work_struct *work)
>  {
> -	struct admac_chan *adchan = from_tasklet(adchan, t, tasklet);
> +	struct admac_chan *adchan = from_work(adchan, work, work);
>  	struct admac_tx *adtx;
>  	struct dmaengine_desc_callback cb;
>  	struct dmaengine_result tx_result;
> @@ -886,7 +887,7 @@ static int admac_probe(struct platform_device *pdev)
>  		INIT_LIST_HEAD(&adchan->issued);
>  		INIT_LIST_HEAD(&adchan->to_free);
>  		list_add_tail(&adchan->chan.device_node, &dma->channels);
> -		tasklet_setup(&adchan->tasklet, admac_chan_tasklet);
> +		INIT_WORK(&adchan->work, admac_chan_work);
>  	}
>
>  	err = reset_control_reset(ad->rstc);
> --
> 2.52.0
>

