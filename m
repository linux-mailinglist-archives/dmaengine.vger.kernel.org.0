Return-Path: <dmaengine+bounces-8935-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MDbcJgPHlGnCHgIAu9opvQ
	(envelope-from <dmaengine+bounces-8935-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Tue, 17 Feb 2026 20:52:35 +0100
X-Original-To: lists+dmaengine@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FC1414FBFE
	for <lists+dmaengine@lfdr.de>; Tue, 17 Feb 2026 20:52:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 0D2E93039F79
	for <lists+dmaengine@lfdr.de>; Tue, 17 Feb 2026 19:52:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF1343783CB;
	Tue, 17 Feb 2026 19:52:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="kYaiW1XW"
X-Original-To: dmaengine@vger.kernel.org
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011044.outbound.protection.outlook.com [52.101.65.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DEE0374738;
	Tue, 17 Feb 2026 19:52:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771357950; cv=fail; b=LYgvs8lsYB8kSLA7KEjYR6BGg64DjYfbV9cQmNN8evQ3Ux5J5DsxXDQHCPZ1ThOmpBJ+bwrHcsFf0BNK/kblP7eD9iHI0SjE4xzbp+bz3RsXQmcEvypMRS7/EzMd0ShYMnagS9GbNcUtsX+Rx3wZnNLrxK2l1FNAqKdRE5tjWIw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771357950; c=relaxed/simple;
	bh=8KI4Ak9+g9jlRUnjjcMWdOgJCumleJhovDWqO4Wk9SI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=kCmep6f/z0UntO/eAMDNKwjwCJeqH5//evP7vehNTgiiM0NQdbe7ja8P8QBloOS5cRjre8g07R6p/hPNMbDx76+jbSxgGQ28kUwPoV8qjSInEcN9Lpwg1+ss8HFVI4oIBTr8M4ujvNC69amvyh3m5u3D545Hb4adzMXwuwGOnjo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=kYaiW1XW; arc=fail smtp.client-ip=52.101.65.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=A5K5yt5AbEp32F4+lxh3SmJZq3N+yxe6X2Rj3zpHBk0yaYAunulpp43nr7q9YtBSLvNEIfhzOgyjll16VVdba1bUjKknBtVF/P08gtQJp0N7bPOCizCOtIhEXxPMUit4BjILETqwoL5fs/RT9o8otsuBheuTEcwI6ktb+U6iiKhXJsfO+LVSKO7zpJ2FpG09MbZoNtdtgdfOrBXlrjiMrYeSxTP1yUY0kl66HsWdq3Egmv2MFtvr8R8uKCPhpZ2I28aTGUt3HYMuzwjsjMjA6ULeg/yllxDO7zLVYTCrLxZcxbfdbByU4m2CsxgORSpW2wXaqkGcf2wPzSfXC7XzUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eSr1lFYOGdRt/dk8QYf2iIXvEaLl++6DzG1mA+C60To=;
 b=FA9N3Rp+uGmoieyKwoB72gz8Eo/21bT4GmPUar7Y03Jv/O7DXD6T4oY+Ndp7E6+d5xiWcKzTfo60Sx0K1st0NDijocpb6C5P2WK1p1OyuROS4C8W7ZPUwDtm1s4sI75TvPtEZkGHQL5zlas6ME/XeN9j8VClHAsKCHfL3N+DpSqa7uszIOMuHByfSK7/sbUDYV1C/rBBFIHAkEy5e4rWyRKSV4CH75wBZmwVHnWqUtRdA96iltuAfdU86eOKFn2DRh1Jm+uMWiCJn1PzSnjCTIJs6lghTZpC1czq58IOv7D05nZc8FpVeUUHLE70y23qWeMKzNotJqTKynNWkDXLkA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eSr1lFYOGdRt/dk8QYf2iIXvEaLl++6DzG1mA+C60To=;
 b=kYaiW1XWkrIBMHGpMa5w5pqLcYyFQxANRu2EoBQXox3EkjU3MyknOwPn/jCmUrymTBjbxGT3NdksO+tISta8uWlawu33HjRGifw/rb7D1gQeH/YCK+pbLqhvWFw+XQcUaenK1nPRR61uYIIu4Fr/ZRXnePqsenT/rtV+r/wknS8dJ+rxEA8Y2P6SLTl7s8IYKAwQcrbKM8VwKuhO7RQCNnqaHZm6+Vzvi6L5I9sj1ICEe0csKlEfdLp9LawnyMWDMn3x4UvLxuR+OLblP0mxE4qwVa9mWcLrFSaVCeTdf1Fh9kwDg/QPP8BL1TP3YUd43qXPm1LaJclZ0Wa0s1EJpA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PA4PR04MB9366.eurprd04.prod.outlook.com (2603:10a6:102:2a9::8)
 by VI1PR04MB9931.eurprd04.prod.outlook.com (2603:10a6:800:1d4::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9611.16; Tue, 17 Feb
 2026 19:52:24 +0000
Received: from PA4PR04MB9366.eurprd04.prod.outlook.com
 ([fe80::75e4:8143:ddbc:6588]) by PA4PR04MB9366.eurprd04.prod.outlook.com
 ([fe80::75e4:8143:ddbc:6588%6]) with mapi id 15.20.9611.013; Tue, 17 Feb 2026
 19:52:24 +0000
Date: Tue, 17 Feb 2026 14:52:17 -0500
From: Frank Li <Frank.li@nxp.com>
To: Akhil R <akhilrajeev@nvidia.com>
Cc: dmaengine@vger.kernel.org, linux-tegra@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	vkoul@kernel.org, Frank.Li@kernel.org, robh@kernel.org,
	krzk+dt@kernel.org, conor+dt@kernel.org, thierry.reding@gmail.com,
	jonathanh@nvidia.com, p.zabel@pengutronix.de
Subject: Re: [PATCH 6/8] dmaengine: tegra: Use iommu-map for stream ID
Message-ID: <aZTG8af4O-wosg4N@lizhi-Precision-Tower-5810>
References: <20260217173457.18628-1-akhilrajeev@nvidia.com>
 <20260217173457.18628-7-akhilrajeev@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260217173457.18628-7-akhilrajeev@nvidia.com>
X-ClientProxiedBy: PH8PR02CA0005.namprd02.prod.outlook.com
 (2603:10b6:510:2d0::13) To PA4PR04MB9366.eurprd04.prod.outlook.com
 (2603:10a6:102:2a9::8)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR04MB9366:EE_|VI1PR04MB9931:EE_
X-MS-Office365-Filtering-Correlation-Id: b058d3ea-5176-41b0-a30b-08de6e5e1251
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|1800799024|366016|7416014|376014|52116014|38350700014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?l6iHwowRF3K+6Mp38b7QKZ3CQDfe+68huT5GgjeNbH0ASP+Hij+rOEuK8kFL?=
 =?us-ascii?Q?0rsf2Ys//X+r1ovAKSm6MgjxzjesKIn5JH41nzYl/fLmF04Tod/eCbSqI3qD?=
 =?us-ascii?Q?nmAhlXnyGwDDECcQ1Oa1t8XkIk6gb3Qq113CHU8xxKEfoMxC+n1PdGaZUuu/?=
 =?us-ascii?Q?BRIRfyd1jfJk5R3SR3v0A+ODvD6qtQaatVyHM2bjVTAmFkCCMgpKBe44QB7D?=
 =?us-ascii?Q?bo7rpnx5HkhSpxRRD6WOgI8M3xOGEfzCqGMv3eZ62br/6wA5+LbEDgyVI3Xl?=
 =?us-ascii?Q?asbABA67A2KKtvcqSmpEJmaL3vfkIoF9Y24ZMlYZYS0ov8N5dsiVi/Y5lyfz?=
 =?us-ascii?Q?nou0gLoi7X6tNXkV3qOQ6o0mtGua4/R6C7oiVcIrjcVFeZHeHZjhQFW1ZMBT?=
 =?us-ascii?Q?+uwT5rR+z0ZMq4tsuiuHJGH763ZO4o+GnAwE1KW8RwsutQohNp36PK5rl6xm?=
 =?us-ascii?Q?LYA7M6gn66jNrBZa5/TU5qMZV45JNLtMjG3yFto5B8kDuY2D+dQ7hn939zPp?=
 =?us-ascii?Q?ryeIK+Mpf3m+jBDWy5ZgEoc86RJh0NGFVwhjC0aijOwf4vtklPxGBSGg1g2W?=
 =?us-ascii?Q?LvntX/YOokNx427GqiHHSjNjEANlXfq8URWxqoKKHP+ZYS8dK0EjC5c/0hLl?=
 =?us-ascii?Q?7Wt3A98jcPBa2v63WmVqPigaop+xGFD1RKSVKGbxNuF+GIks4S/R98uDWqDu?=
 =?us-ascii?Q?4FD2R5Kxr/4pJvHHk4x9M1QkCWrwiXguLlEHoW3JRs3rckoDSCA+ePk14laH?=
 =?us-ascii?Q?CLn1LXQymq1cX29kcBH3SktKlTzSIhSfEM3jsGPPGajE1l8Z4rXQwEMOP1s/?=
 =?us-ascii?Q?f3XcIu8nP79wyGTyA501UoOLTO3aM2k91qxdiUlGWoVGHuuJa9XyphZY7LlM?=
 =?us-ascii?Q?MMc82+3ef79VUz9U4mjmBBb7h7O1iCL6iFyTnUS4dPprVys454T7wADMBuLb?=
 =?us-ascii?Q?ALFIYJyxKBZOZu9zuxziLGOSuM+h+pC9fQ7CkeKV3EHt+yqNLNbh02gLBj3h?=
 =?us-ascii?Q?1rB99F4IirTPsN83TWKH+Q+mYTD9RDLTz3hPLoII4YQAnNGgMR6YbiUWbpsd?=
 =?us-ascii?Q?nOjieALNtR4gMB+b23CmQqQx79KZSIeqN2J8JIegwLi/NTEW1Ye5w1vHk7GA?=
 =?us-ascii?Q?prNTRQePtmV9OEEAHs3/EZ0vsLLuUnUneb2DZaaaGI9nLkbglGdDte8vs9Zx?=
 =?us-ascii?Q?EgKqrRXPBnmTtUWFguJ1/NAvfa2UXez05xfQbHt4kh2NOrlYw6BVSfUNyI9m?=
 =?us-ascii?Q?/O79O0IwMWyMj2NaCArBFRA/lHbSJW2IulbaSfLWdtw82wfAAybXNV3R1ZMj?=
 =?us-ascii?Q?dLAkSeJFvB3Uu3fon/MpaQ6nj6PfB8zVWA0u4/dc+Q7h5V+1n0cuy7s3FQiv?=
 =?us-ascii?Q?vxR+q32rf/UkWuuqbO9l+HgI037xE9mQh24+Wi35C3ZPaZ1/qE4hMocnuF/4?=
 =?us-ascii?Q?q7UbfCHufdfocjhnkrGo8OrYLNKgmDrhwChMos+BTsy/gb73ned/wGgmzb6E?=
 =?us-ascii?Q?5mKTC+ksAoUEiqk4ezrrrwhjP5BcE6BSkrYEgmu9Li9M/japnTP34PXGEQ7U?=
 =?us-ascii?Q?39FeWC3meOcqrKsSD7RFvepUwuQKEMt7D1SUp4DWq9WjotJqDOaTCVAgWUtS?=
 =?us-ascii?Q?Ldz/7BH1WpA3w3G0R7s/PEk=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB9366.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(1800799024)(366016)(7416014)(376014)(52116014)(38350700014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?dDTNZVGylYt8n8pwTRv/TURAf9dRMSaADI1XIYY4gU1oZn0FqU1pki+BcbCf?=
 =?us-ascii?Q?sO2jArcZlhGBa5pYIQZUbHo2hhXXsSVKwxAckYA4ybcNvIfgTGngMuUAj5rZ?=
 =?us-ascii?Q?DkRzJibXffOH3W6080uJ3Xscdmaq2mNGyMFfDfdrJG3GvSj3ayLxE123Zm11?=
 =?us-ascii?Q?d8QtYeh+zmeogNrKlalGOihac2Q2fwFlIpkUuAmN4SkhvVfc5Qno34TqVUO3?=
 =?us-ascii?Q?m4X/KcFYg4nL7RZk+MLl4vCkivDt8VthW2Nfe2iDg7Cztd6vpfuAi/0H+h7F?=
 =?us-ascii?Q?WdtUJEU0ucgF+5XUR/vNXq3vdS1xjbsj+2UJR/1oxW9qEGqSUIfhgFhf8IXH?=
 =?us-ascii?Q?KbYprUHjbR59OJdwzvGf6u3xeqChaWlUPqBlpsaVhuaL810L/v9eUeH9aSI0?=
 =?us-ascii?Q?6N+TPl8mSBb8abf6BHEZT8gQam6s0sucqhJqJdhpNLUWCHoq9x03GRTo/OtQ?=
 =?us-ascii?Q?Q3oozEdwLcydrlq5bRJTHBfV18OFbCLFWZyVv81p5I3DO6WLuux0O+X6VEgC?=
 =?us-ascii?Q?CAq36ivjj7OXwMuU8waWwNkdiEqwGBkAt/CwxVRuP5ALN9thvPqqeER5bz9d?=
 =?us-ascii?Q?aDGjhBmT1SZwN/dzqADyFjaocg94ojYli4DOrXrhF7B4tq0akcdcBbzzhToW?=
 =?us-ascii?Q?oeG2q8nO5u3FvgyAtCihPCo1ihHj5xMVIFIHt92cyPnk4X1mcp+4PToj65d9?=
 =?us-ascii?Q?eXXkYhfIxqHlPvk1kS+v7u38q+wTsmGtvAYV1ZJmeuP7+LEcbi2UE5io5bA+?=
 =?us-ascii?Q?vL3tHaA6uR3I2s0Dx24WmzSGVpBdcYQijrFm8jkdCPKtM54ILGk5DCFucNSf?=
 =?us-ascii?Q?6z4M0Ga0lwbdyxSdZnpbscrJnbQcTYU+Ym9a8D4JoY/SRbX6zI+qrykAYNqf?=
 =?us-ascii?Q?mcfzY78e5FfA3HGpboU1vqLsyul3Tlbrclj+ysDq4ZyNK5NIy4oZJz+76ju8?=
 =?us-ascii?Q?Nv1/ECjjoh5W3aMYXL81vAKWRPdkAoGIn2/bMRWY6ZRIG3S4OhXnYjBFI4MT?=
 =?us-ascii?Q?YxCMxvyP+MhtZ77J0W3Rf1adSRPOpWzkALToy37uYqUqpSPGL7m8wCax/J6x?=
 =?us-ascii?Q?DpLH+Ir6Cl6tpaqxjTxcjURDoPza6kTWa803xy68tLhwr0rQ41V57qG/nuWT?=
 =?us-ascii?Q?dWMYT1165pqvHfE78F8ZaKHEr45OZlsSsNc6d5AeKcTcZCLalU9GQnO+3bnq?=
 =?us-ascii?Q?+6AErv/kA89pFT1fhfsfu2nNTYebStGDshRijYzp7xuRN/KoOWklozt4K3PP?=
 =?us-ascii?Q?e0KLxbUbbUnRv3nppvhtzXc+IRUQ7jX24Wk1OEhMtaghsz6LLaOKBHblQIV9?=
 =?us-ascii?Q?8l15uB2SZCgYYYCsF9hyB60U1rnNB4m7rNn4c396Z1IUGbgvCiWLrJTt6eg6?=
 =?us-ascii?Q?qXoCvdzNjJllfg2woSBI52GFiVEjnr8ZNXPHB4mZifRfgaf3EE0rKR+yUZZZ?=
 =?us-ascii?Q?h0gKmSVv8GjkZyeW63f3L/Cs2kqD/O9mGnDp/G3thI7Vdd2QxdscGJkandsm?=
 =?us-ascii?Q?dbVWrdNsua0SNiBuBI3Kc2TwdJXuJ5AvAjoRFv4HpgxW/7R8dBLvyRmI8CN5?=
 =?us-ascii?Q?bK4kgShDN06EQg+orXR7PljQFDGAcO528FNasGqED0mhhZ8hyD+hDe1FKUCf?=
 =?us-ascii?Q?QGS7nMkVA00qMYtX2G4Z+7X1IXkQKvb/d2eE6ZxU4Dx2el1M1uSajNubynlH?=
 =?us-ascii?Q?ogpho7HiexlN1zWtPq4hyA5Ss9PrvirShwe9iwTRhoxJkvNTMvw5stxNXeYY?=
 =?us-ascii?Q?i6DrKgC8xA=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b058d3ea-5176-41b0-a30b-08de6e5e1251
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB9366.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Feb 2026 19:52:24.7963
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: znbm5B7xQuz7PNDm/y+3CuH3qu1WfLCBWiuznedbgso+2TsmDbvGLJc+pMyeIBY2PAXAR+e12rK4Ph3CQsEawA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB9931
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nxp.com,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[nxp.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-8935-lists,dmaengine=lfdr.de];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	FREEMAIL_CC(0.00)[vger.kernel.org,kernel.org,gmail.com,nvidia.com,pengutronix.de];
	DKIM_TRACE(0.00)[nxp.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[Frank.li@nxp.com,dmaengine@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[dmaengine,dt];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nxp.com:dkim,nvidia.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 1FC1414FBFE
X-Rspamd-Action: no action

On Tue, Feb 17, 2026 at 11:04:55PM +0530, Akhil R wrote:
> Use iommu-map, when provided, to get the stream ID to be programmed
> for each channel. Register each channel separately for allowing it
> to use a separate IOMMU domain for the transfer.
>
> Channels will continue to use the same global stream ID if iommu-map
> property is not present in the device tree.
>
> Signed-off-by: Akhil R <akhilrajeev@nvidia.com>
> ---
>  drivers/dma/tegra186-gpc-dma.c | 62 +++++++++++++++++++++++++++-------
>  1 file changed, 49 insertions(+), 13 deletions(-)
>
> diff --git a/drivers/dma/tegra186-gpc-dma.c b/drivers/dma/tegra186-gpc-dma.c
> index ce3b1dd52bb3..b8ca269fa3ba 100644
> --- a/drivers/dma/tegra186-gpc-dma.c
> +++ b/drivers/dma/tegra186-gpc-dma.c
> @@ -15,6 +15,7 @@
>  #include <linux/module.h>
>  #include <linux/of.h>
>  #include <linux/of_dma.h>
> +#include <linux/of_device.h>
>  #include <linux/platform_device.h>
>  #include <linux/reset.h>
>  #include <linux/slab.h>
> @@ -1403,9 +1404,12 @@ static int tegra_dma_program_sid(struct tegra_dma_channel *tdc, int stream_id)
>  static int tegra_dma_probe(struct platform_device *pdev)
>  {
>  	const struct tegra_dma_chip_data *cdata = NULL;
> +	struct tegra_dma_channel *tdc;
> +	struct tegra_dma *tdma;
> +	struct dma_chan *chan;
> +	bool use_iommu_map = false;
>  	unsigned int i;
>  	u32 stream_id;
> -	struct tegra_dma *tdma;
>  	int ret;
>
>  	cdata = of_device_get_match_data(&pdev->dev);
> @@ -1433,9 +1437,12 @@ static int tegra_dma_probe(struct platform_device *pdev)
>
>  	tdma->dma_dev.dev = &pdev->dev;
>
> -	if (!tegra_dev_iommu_get_stream_id(&pdev->dev, &stream_id)) {
> -		dev_err(&pdev->dev, "Missing iommu stream-id\n");
> -		return -EINVAL;
> +	use_iommu_map = of_property_present(pdev->dev.of_node, "iommu-map");
> +	if (!use_iommu_map) {
> +		if (!tegra_dev_iommu_get_stream_id(&pdev->dev, &stream_id)) {
> +			dev_err(&pdev->dev, "Missing iommu stream-id\n");
> +			return -EINVAL;
> +		}
>  	}
>
>  	ret = device_property_read_u32(&pdev->dev, "dma-channel-mask",
> @@ -1449,7 +1456,7 @@ static int tegra_dma_probe(struct platform_device *pdev)
>
>  	INIT_LIST_HEAD(&tdma->dma_dev.channels);
>  	for (i = 0; i < cdata->nr_channels; i++) {
> -		struct tegra_dma_channel *tdc = &tdma->channels[i];
> +		tdc = &tdma->channels[i];
>
>  		/* Check for channel mask */
>  		if (!(tdma->chan_mask & BIT(i)))
> @@ -1469,10 +1476,6 @@ static int tegra_dma_probe(struct platform_device *pdev)
>
>  		vchan_init(&tdc->vc, &tdma->dma_dev);
>  		tdc->vc.desc_free = tegra_dma_desc_free;
> -
> -		/* program stream-id for this channel */
> -		tegra_dma_program_sid(tdc, stream_id);
> -		tdc->stream_id = stream_id;
>  	}
>
>  	ret = dma_set_mask_and_coherent(&pdev->dev, DMA_BIT_MASK(cdata->addr_bits));
> @@ -1517,20 +1520,53 @@ static int tegra_dma_probe(struct platform_device *pdev)
>  		return ret;
>  	}
>
> +	list_for_each_entry(chan, &tdma->dma_dev.channels, device_node) {
> +		struct device *chdev = &chan->dev->device;

why no use
	for (i = 0; i < cdata->nr_channels; i++) {
		struct tegra_dma_channel *tdc = &tdma->channels[i];
> +
> +		tdc = to_tegra_dma_chan(chan);
> +		if (use_iommu_map) {
> +			chdev->coherent_dma_mask = pdev->dev.coherent_dma_mask;
> +			chdev->dma_mask = &chdev->coherent_dma_mask;
> +			chdev->bus = pdev->dev.bus;
> +
> +			ret = of_dma_configure_id(chdev, pdev->dev.of_node,
> +						  true, &tdc->id);
> +			if (ret) {
> +				dev_err(chdev, "Failed to configure IOMMU for channel %d: %d\n",
> +					tdc->id, ret);
> +				goto err_unregister;
> +			}
> +
> +			if (!tegra_dev_iommu_get_stream_id(chdev, &stream_id)) {
> +				dev_err(chdev, "Failed to get stream ID for channel %d\n",
> +					tdc->id);
> +				goto err_unregister;
> +			}
> +
> +			chan->dev->chan_dma_dev = true;
> +		}
> +
> +		/* program stream-id for this channel */
> +		tegra_dma_program_sid(tdc, stream_id);
> +		tdc->stream_id = stream_id;
> +	}
> +
>  	ret = of_dma_controller_register(pdev->dev.of_node,
>  					 tegra_dma_of_xlate, tdma);
>  	if (ret < 0) {
>  		dev_err_probe(&pdev->dev, ret,
>  			      "GPC DMA OF registration failed\n");
> -
> -		dma_async_device_unregister(&tdma->dma_dev);
> -		return ret;
> +		goto err_unregister;
>  	}
>
> -	dev_info(&pdev->dev, "GPC DMA driver register %lu channels\n",
> +	dev_info(&pdev->dev, "GPC DMA driver registered %lu channels\n",
>  		 hweight_long(tdma->chan_mask));
>
>  	return 0;
> +
> +err_unregister:
> +	dma_async_device_unregister(&tdma->dma_dev);

Can you use dmaenginem_async_device_register() to simple error path?

Frank
> +	return ret;
>  }
>
>  static void tegra_dma_remove(struct platform_device *pdev)
> --
> 2.50.1
>

