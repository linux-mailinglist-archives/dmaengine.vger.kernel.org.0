Return-Path: <dmaengine+bounces-8800-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gCrMJMkthmn4KAQAu9opvQ
	(envelope-from <dmaengine+bounces-8800-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Fri, 06 Feb 2026 19:07:05 +0100
X-Original-To: lists+dmaengine@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A296E101A25
	for <lists+dmaengine@lfdr.de>; Fri, 06 Feb 2026 19:07:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 90DF03007208
	for <lists+dmaengine@lfdr.de>; Fri,  6 Feb 2026 18:07:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FCED426D11;
	Fri,  6 Feb 2026 18:07:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="G3KklNus"
X-Original-To: dmaengine@vger.kernel.org
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011017.outbound.protection.outlook.com [52.101.70.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4EDF309DD2;
	Fri,  6 Feb 2026 18:06:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770401220; cv=fail; b=ZQKguAWibRnFneAfS9Q8qxxaRMDbf5iyOeHPjNhkWIJGxvheWepzc6z25gzkFKNcdivIqSjFfvRY4Dvlp5+UnvTIu1NO99hvXkpnason73Qm+YB4d4pGq0O/gnu3FAPFQVEi0YYjw0/KgpgO21kUgaU7LWQ6hQWDpcSpQImx01c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770401220; c=relaxed/simple;
	bh=Jv9lAqRZMtkAUZddzQA7k0VYytlF9RVUowpw2h3hlgE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=lTqtW/R9wvEI6WF5p7HSsNXnL6D8PMOGyoIhLZJq+W8I+bk1lA3jDZ8YMFyz8CDYKHhWgA5u41kuGTNM2tD0kFClgqqz1jrCfnJyOunPz+LyMYfExzqAME/Zj6mDhWH6Obr2G28qc+FR3drCvUEP6jn9UqDaR8nDrjN8EcmJRzo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=G3KklNus; arc=fail smtp.client-ip=52.101.70.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HuNusW/eSaKROahqA4mOmWVTQrq6rti3jWkcRJKJD0Xh3Q7/nl5dngvb1pFiK6rlbRks1aPPeKvQs0meu2pShw6lRyfTtLypm+7SteiqN7HjtM9pMlaOvtDr2ZatqBN18PeEaAZ8ow8SCdjX9F5ydYTUzIBxhnSrhIPhyomonNKcxeLZPvo8UamFsjKYREDnN7yMmvQURoCneJe6YqMCKsF5xmW5DMONPfyWdTeiYyVdvjPFTnJ6YM4v0sJaLK6vN50TDyrI1P6Jy0Ig6Uk1j/vVLOwxZf56/n2p6vxz0KLCzBns+TGnZQmVhqqyCNsiQzN4u55OP5pjh36ocmw5nQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bBfow7NX2NfQgs+UCQ0jlLkD+eDgXA7BLx1vw1pF5Gc=;
 b=l4DKXYIQzYE+6xz7dHI6OFrNn/Gxj695K3V6Vqa4meY8KHVas73RhYd58IHlZohHlKnHKAHJ3a6NFb4P3MDrW/FKg0g6MTRQRIBWsKfstJHnKEeu5wUtSA0HTTJhEURNEa6p9a0ng5yEOuuGpmML45a/ZibpUeqPvsQf1bbIxcD/aesALlSm1ct8WGNQsgr5tKyeqtanhUW3iM5yjPcvBSHxbsqBPIkkg/aCSZHvE058Yk31OlV4j9nB8zZ8Lw1dCuGbaWXrREX26rU6m6+loXpAiAc0xqwe6GXb6sNVIBZYyWCd9y+Pp3wX/bslUGCXm13LTFDGErGWqxkWXO6K/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bBfow7NX2NfQgs+UCQ0jlLkD+eDgXA7BLx1vw1pF5Gc=;
 b=G3KklNusBkhxd+jwiS/atzfBgh7OGhqvkVVKxbr/11dt/WLXJVHnyJ6XgDT2xJJk0G0sm1nTWusOG0VdieTNer+QtcdOkoYvJJZD5OCXBy9jXQCi7lgFiAjhNq3O4BfcEKkyiZZCOlRYjgDezxgyn/AyzFpmKtfeTvBdzEwgCvcTW5Mh/+KNvKWb5FMJK9Q88pWAIFm4hAVSXygPKRDwGyyv/LgiFGvanlcMy+GIkiC05tF3+N9sqeYspejqZ9C201yoLbRIM1PmEEEChSGy0SCWzJ21I7xMZ8ZuvylRUruiqSL9amV+fky54MoxgDPJevd0pRutynpNtZ6Xs/Pgng==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PA4PR04MB9366.eurprd04.prod.outlook.com (2603:10a6:102:2a9::8)
 by PA4PR04MB7982.eurprd04.prod.outlook.com (2603:10a6:102:c4::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.15; Fri, 6 Feb
 2026 18:06:53 +0000
Received: from PA4PR04MB9366.eurprd04.prod.outlook.com
 ([fe80::75e4:8143:ddbc:6588]) by PA4PR04MB9366.eurprd04.prod.outlook.com
 ([fe80::75e4:8143:ddbc:6588%6]) with mapi id 15.20.9587.010; Fri, 6 Feb 2026
 18:06:53 +0000
Date: Fri, 6 Feb 2026 13:06:46 -0500
From: Frank Li <Frank.li@nxp.com>
To: Koichiro Den <den@valinux.co.jp>
Cc: vkoul@kernel.org, mani@kernel.org, jingoohan1@gmail.com,
	lpieralisi@kernel.org, kwilczynski@kernel.org, robh@kernel.org,
	bhelgaas@google.com, dmaengine@vger.kernel.org,
	linux-pci@vger.kernel.org, linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 6/9] PCI: dwc: ep: Report integrated eDMA resources
 via EPC remote-resource API
Message-ID: <aYYttmm9alHg6LAY@lizhi-Precision-Tower-5810>
References: <20260206172646.1556847-1-den@valinux.co.jp>
 <20260206172646.1556847-7-den@valinux.co.jp>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260206172646.1556847-7-den@valinux.co.jp>
X-ClientProxiedBy: PH7P220CA0056.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:510:32b::14) To PA4PR04MB9366.eurprd04.prod.outlook.com
 (2603:10a6:102:2a9::8)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR04MB9366:EE_|PA4PR04MB7982:EE_
X-MS-Office365-Filtering-Correlation-Id: d6f8f00e-5e41-4c9f-eefa-08de65aa823e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|7416014|376014|19092799006|1800799024|366016|7053199007|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ATof7GbnGKksehTE31hqRtcN2x3y2p40jHFLiivpThrC+wdRfUdDHBsTKHi6?=
 =?us-ascii?Q?pwNz8SyNNm1j/2XFLRFcXJkeXl6Ja9bxo3ITsMDjBH8YtjWtF2lBNaDC5O+i?=
 =?us-ascii?Q?73zUvMs3b0MBvz7/KsYBsVJjpdNa7sZE5Flj1rNPLF6FrhIHwP13DjTnQmYQ?=
 =?us-ascii?Q?ADW12zn0WemoOwhRJWsebhQQEUL3IjEzS9YUR+Prvy7jlg4cWGRJKZVkLP2k?=
 =?us-ascii?Q?vlsUZ44Nn2UgUb+NKr2U5GH9fT2KGAhddpdPVsKImG3KYFfKitm1GXgHqxKR?=
 =?us-ascii?Q?VpFVwu5wJ/TT0kmztG/aghMbrkD4Obb1n9GawnKnz4sus2NJW2A4TzOmbYoX?=
 =?us-ascii?Q?2HVwdYffWUrhhUWGT/ax8v289WkAr+SsR3B7pF57buBk0xkGVoJDKh4REwjN?=
 =?us-ascii?Q?kfHNvdTfaTuFSUNow4NOqROmeAgjlZa6vrfR39FBS1V3Ohk4zhfo13Ss2BvY?=
 =?us-ascii?Q?GI2DhfBYGm9WcNdSu8OydxfCW6PjwaZJd3ScvLNWSO0+tj/7rk/k/9KKBRNF?=
 =?us-ascii?Q?6nDvQDb918a4hOyEQYkvvtyfvE21X4e8M+qBWH3yb3DlQmcGDX5nZUaLcl2o?=
 =?us-ascii?Q?/pQMhZwOIr699mK5PFjLerkQf1SS1FveX0sLhhUlQrbrJntWL82AW5rajri4?=
 =?us-ascii?Q?bdl5pmAyLWLhHPZE6+C0lAOjPqgBnA46+jbghu6YPR4Wxj7EeMN3M1kjkK4R?=
 =?us-ascii?Q?KTWsZMASip0Qvz3mptc//H0lYhWGHLpkA0WYySiCovz/JM30YtNGShoQ2d1w?=
 =?us-ascii?Q?EbKcvGgS9JtswzUYoUuemCDVR/brXbPelRs2qXyOqN3GoU3Bvpov9ajajFz4?=
 =?us-ascii?Q?ZYEaUMsdtBG4DZHaI/RDhikU6SBkHdqmXvJrg9ADh5j5nFiZeoCufyhcSWzu?=
 =?us-ascii?Q?nL730x1q8qxxXBltu+y5WfPm+8SJvDxxHNLxiBDHFY/kr3vMfBzpbH2cWGfh?=
 =?us-ascii?Q?xyjdDHezeeWaQhHfxCeI6fVkkdK1ZYb/s2VbIMDiO5FgTWKreXeAgJ5Y5wLp?=
 =?us-ascii?Q?CXpNB+Fnj/Ia+9MKa8o/qWv0uuDmH8xcGAlOQ/ufb+5c4qGbt8ptdes5yrs/?=
 =?us-ascii?Q?6v0JkapnLGEQ8/N82Eyr28yzH8t1qfSMXQTt8snkU9QhrxPhp0rNCEQx7h6R?=
 =?us-ascii?Q?4D7smQoiKgl18VzbS9QC35SCc5AVrD0M/WKi/OacWTSuv82nEddKgb0TSjRe?=
 =?us-ascii?Q?eIma/sTREea7HrvgcsnESGHOYWp1fctzVXyJRO4V7IxN4u4GHMRZ9AUMEr1d?=
 =?us-ascii?Q?o1UMA2AzO7Lr45ykp0L2pfI6+BZJFNV0O1BJxAKA7aFTmDYxqQ1OwZz6u0sy?=
 =?us-ascii?Q?mxJCWcQtkEIqDC1Ytn1YC7vhztSMruFm+NwopaozfeD4ujz7my9Xthsbj7FN?=
 =?us-ascii?Q?FeRJRlJMWLUHnSvzE4FzOp9EbmgfjvSp56yskz8hkm2KUhTAyhji604ggjws?=
 =?us-ascii?Q?Fiz4W+lNnlHvhfiHRp+jmNVlzvuV15rsjuAOHAf67mZMxHh0Ly99GdmqF/J5?=
 =?us-ascii?Q?qujcP92bULbl+7m4Q490vxhFa8wwAWaUaZwAaPQAUgONZuWjqJa3EBuapV6a?=
 =?us-ascii?Q?xk40Vr6zQVDXbm5gjlCB8BFXHdvo5AlXyzUlcnlDfKIBokm6v1GXPlJH+viv?=
 =?us-ascii?Q?Lqcfb1vlWHx6CcRov4lyiVo=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB9366.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(7416014)(376014)(19092799006)(1800799024)(366016)(7053199007)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?nkOYd4NuGLv6apNNj0PfKhP0jx2+/px5TjzcJK8mYjJRw9qMI8gD6lVCATGw?=
 =?us-ascii?Q?k86s0KwqA+a5zGLklUWeF4VY66fZw01PQoMxN06u6JYQZFHWMjam3HbcoxI5?=
 =?us-ascii?Q?RGtDvk7feCDPC/m0vYZJFD1C96/WC7ZvvNkkk90akUuSc4UCtNMRLnVJiz3L?=
 =?us-ascii?Q?MgS3WwseoHr379wABCuO5naBuYUwUMuatelDGOGD5h1Fag76y4qxh977JkqV?=
 =?us-ascii?Q?37kkgbsCHfZkrIEcD5kvwCOZDnllcqzVg5TKva3ARgcSGFL35sJwTm53Nyhr?=
 =?us-ascii?Q?K55axbG2R944Pwc5px5vHZa1naqMxdcNCa1W9Fhc4Joq97/GohzhWs7psItR?=
 =?us-ascii?Q?UjYKdBSKi/azMu74hkG5dpUPRoUxT216cY5V1R0d3AXCISX3CTWS8KMxPHWE?=
 =?us-ascii?Q?KrLhSCXfrH6Ip7ZOy5fOY+Khb+Ki0z5NckAibLc0zmH6t3t0wXuVTbKj7zk0?=
 =?us-ascii?Q?Fpg90k2LrUDjbJhXvjM4MGpERg6kmFzq6QXHsPjD7Vb1asNcK3XyCIYgeOO4?=
 =?us-ascii?Q?YnsAtocxjnbEkbpdbOeBnxe19+HHgEc5KvHO2zadGChS6iJFbvZuEbhvUrPE?=
 =?us-ascii?Q?onjQ7n0fPrGoQJ4p3+fe7p9RG1jR/pAMhN6Zw4siYK2aL23Cdqp+6ZpbhkfB?=
 =?us-ascii?Q?MwqOsq0OT0Kli28QMKyHw/bGkgCHFpw2uisc/RRfAR3sY8l+VjAJA8NteczK?=
 =?us-ascii?Q?GT7L1/xxToP7BC3XG11njfzP3a8Q9hogDusMYrMqKchgK6kKMZDQjn7QHyeW?=
 =?us-ascii?Q?C3WnQlfhxK7jxhHdCUhpgIeCyTEFFbqdgCZ6HppvV01rOwmv//ROMLRnJkGX?=
 =?us-ascii?Q?ZZUXe2RrnW97lsJWXOxB7r2h5Ojj9pr/bb/Gb50BpDDjfL7bj2ke5NJ7kfFK?=
 =?us-ascii?Q?PO8uzcWpJfJmsgNSUxONv2H5zVhFoteV2zWQC1fuSf7qZDyxVBsLci3nG4nG?=
 =?us-ascii?Q?2KEWsq8lTjZJaa1I+57g5i2USjmn4qN7VrJsl9bZtYovt1RuYs/WuzULtQ0K?=
 =?us-ascii?Q?fiYNvN+FoeDFj5iqIkqGee93f9YIjE3weux9M3jyDPSO9XNdzqGba9RlHwOM?=
 =?us-ascii?Q?M2ph5qavOtqHFTjTGNIDR6x5n3YyEH71zM6t9xnIwINJg/vMBf/x4xrYsIxx?=
 =?us-ascii?Q?PZlqAvGee8anWWSFacIy3EOuZWGZ/nH42iqJPPIIfHDFf4uQySqW+Bv4n5Yi?=
 =?us-ascii?Q?pukrcRhnL04nHoL2yInFDmAbAqUtT7O+ySbAW4gCl5nUWnajHPqTrtDXRInC?=
 =?us-ascii?Q?jsVjt9DBtQiLPsc7XY+ET9GFS2MGQTXrJjd7V+sS9p/sgga7KwY2Pd91p8IH?=
 =?us-ascii?Q?fS7b+biZ9dQ/lTpzGI27VEKD/SqG1jJsEnsny1GT4jCcxgj9FyVIdpuGu1GM?=
 =?us-ascii?Q?/xt1oWbd7jLczK+aVHWdOSCjN/gOOW+7MyHiLHPCXeUSVCFqof+bZwpXUTQv?=
 =?us-ascii?Q?gTSRfomdkN8A6Y2YKxl/bYFa+9Ws9POO8KQeaLD1t0lzeUwp7B9t1yrZPEHO?=
 =?us-ascii?Q?Y9NkJsv8FhPACjj04R3jYoC31OoBLeKRSO9uQnvHHmGRO1iPzB8HBMWdgurE?=
 =?us-ascii?Q?+PeBAQRaYtMiTbvMUu2FtWs5r7AS9+lCNT+Lxr2OmjDQBDJeY1PlbZGw6hRI?=
 =?us-ascii?Q?Zi6baILFT54c5p2J3BJxsK1+79q63mcw1iyeKwal/drNP7gp2adnWU6TRuzP?=
 =?us-ascii?Q?+uZUoGfU5LnH57ZhOPLGulU5tOUXg77UmYSCU9ICcdT/ASPR?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d6f8f00e-5e41-4c9f-eefa-08de65aa823e
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB9366.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Feb 2026 18:06:53.8651
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YsNvHYlEnQMluhM1PwLwgzAv6qyCLHU3tyMtrL4yfUt7wdr+PVzqtnP3+31S38kNSIFOkqTKdgi+AAJcBPVShg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB7982
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
	TAGGED_FROM(0.00)[bounces-8800-lists,dmaengine=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[12];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[kernel.org,gmail.com,google.com,vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[Frank.li@nxp.com,dmaengine@vger.kernel.org];
	DKIM_TRACE(0.00)[nxp.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TAGGED_RCPT(0.00)[dmaengine];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nxp.com:dkim,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: A296E101A25
X-Rspamd-Action: no action

On Sat, Feb 07, 2026 at 02:26:43AM +0900, Koichiro Den wrote:
> Implement pci_epc_ops.get_remote_resources() for DesignWare PCIe
> endpoint controllers with integrated eDMA.
>
> Report:
>   - the eDMA controller MMIO window (physical base + size),
>   - each non-empty per-channel linked-list region, along with
>     per-channel metadata such as the Linux IRQ number and the
>     interrupt-emulation doorbell register offset.
>
> This allows endpoint function drivers (e.g. pci-epf-test) to discover
> the eDMA resources and map a suitable doorbell target into BAR space.
>
> Signed-off-by: Koichiro Den <den@valinux.co.jp>
> ---
>  .../pci/controller/dwc/pcie-designware-ep.c   | 85 +++++++++++++++++++
>  1 file changed, 85 insertions(+)
>
> diff --git a/drivers/pci/controller/dwc/pcie-designware-ep.c b/drivers/pci/controller/dwc/pcie-designware-ep.c
> index 7e7844ff0f7e..29dedac86190 100644
> --- a/drivers/pci/controller/dwc/pcie-designware-ep.c
> +++ b/drivers/pci/controller/dwc/pcie-designware-ep.c
> @@ -8,6 +8,7 @@
>
>  #include <linux/align.h>
>  #include <linux/bitfield.h>
> +#include <linux/dma/edma.h>
>  #include <linux/of.h>
>  #include <linux/platform_device.h>
>
> @@ -808,6 +809,89 @@ dw_pcie_ep_get_features(struct pci_epc *epc, u8 func_no, u8 vfunc_no)
>  	return ep->ops->get_features(ep);
>  }
>
> +static int
> +dw_pcie_ep_get_remote_resources(struct pci_epc *epc, u8 func_no, u8 vfunc_no,
> +				struct pci_epc_remote_resource *resources,
> +				int num_resources)
> +{
> +	struct dw_pcie_ep *ep = epc_get_drvdata(epc);
> +	struct dw_pcie *pci = to_dw_pcie_from_ep(ep);
> +	struct dw_edma_chip *edma = &pci->edma;
> +	struct dw_edma_chan_info info;
> +	int ll_cnt = 0, needed, idx = 0;
> +	resource_size_t dma_size;
> +	phys_addr_t dma_phys;
> +	unsigned int i;
> +	int ret;
> +
> +	if (!pci->edma_reg_size)
> +		return 0;
> +
> +	dma_phys = pci->edma_reg_phys;
> +	dma_size = pci->edma_reg_size;
> +
> +	for (i = 0; i < edma->ll_wr_cnt; i++)
> +		if (edma->ll_region_wr[i].sz)
> +			ll_cnt++;
> +
> +	for (i = 0; i < edma->ll_rd_cnt; i++)
> +		if (edma->ll_region_rd[i].sz)
> +			ll_cnt++;
> +
> +	needed = 1 + ll_cnt;
> +
> +	/* Count query mode */
> +	if (!resources || !num_resources)
> +		return needed;
> +
> +	if (num_resources < needed)
> +		return -ENOSPC;
> +
> +	resources[idx++] = (struct pci_epc_remote_resource) {
> +		.type = PCI_EPC_RR_DMA_CTRL_MMIO,
> +		.phys_addr = dma_phys,
> +		.size = dma_size,
> +	};
> +
> +	/* One LL region per write channel */
> +	for (i = 0; i < edma->ll_wr_cnt; i++) {
> +		if (!edma->ll_region_wr[i].sz)
> +			continue;
> +
> +		ret = dw_edma_chan_info(edma, i, &info);
> +		if (ret)
> +			return ret;
> +
> +		resources[idx++] = (struct pci_epc_remote_resource) {
> +			.type = PCI_EPC_RR_DMA_CHAN_DESC,
> +			.phys_addr = edma->ll_region_wr[i].paddr,
> +			.size = edma->ll_region_wr[i].sz,
> +			.u.dma_chan_desc.irq = info.irq,
> +			.u.dma_chan_desc.db_offset = info.db_offset,
> +		};
> +	}
> +
> +	/* One LL region per read channel */
> +	for (i = 0; i < edma->ll_rd_cnt; i++) {
> +		if (!edma->ll_region_rd[i].sz)
> +			continue;
> +
> +		ret = dw_edma_chan_info(edma, i + edma->ll_wr_cnt, &info);

edma's information is what dw-EP pass to edma driver, supposed dw-ep know
irq and HDMI or EDMA's information, I think needn't go around to EDMA again
to fetch this information back.

Frank
> +		if (ret)
> +			return ret;
> +
> +		resources[idx++] = (struct pci_epc_remote_resource) {
> +			.type = PCI_EPC_RR_DMA_CHAN_DESC,
> +			.phys_addr = edma->ll_region_rd[i].paddr,
> +			.size = edma->ll_region_rd[i].sz,
> +			.u.dma_chan_desc.irq = info.irq,
> +			.u.dma_chan_desc.db_offset = info.db_offset,
> +		};
> +	}
> +
> +	return idx;
> +}
> +
>  static const struct pci_epc_ops epc_ops = {
>  	.write_header		= dw_pcie_ep_write_header,
>  	.set_bar		= dw_pcie_ep_set_bar,
> @@ -823,6 +907,7 @@ static const struct pci_epc_ops epc_ops = {
>  	.start			= dw_pcie_ep_start,
>  	.stop			= dw_pcie_ep_stop,
>  	.get_features		= dw_pcie_ep_get_features,
> +	.get_remote_resources	= dw_pcie_ep_get_remote_resources,
>  };
>
>  /**
> --
> 2.51.0
>

