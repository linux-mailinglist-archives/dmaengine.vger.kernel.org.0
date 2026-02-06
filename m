Return-Path: <dmaengine+bounces-8796-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OF06HO8nhmmLKAQAu9opvQ
	(envelope-from <dmaengine+bounces-8796-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Fri, 06 Feb 2026 18:42:07 +0100
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D045A1013BE
	for <lists+dmaengine@lfdr.de>; Fri, 06 Feb 2026 18:42:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 67F5B3009F88
	for <lists+dmaengine@lfdr.de>; Fri,  6 Feb 2026 17:37:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA4DD3A0B29;
	Fri,  6 Feb 2026 17:37:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="gq0tNmum"
X-Original-To: dmaengine@vger.kernel.org
Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013023.outbound.protection.outlook.com [40.107.162.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61BC0335BA7;
	Fri,  6 Feb 2026 17:37:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.23
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770399458; cv=fail; b=aInNLMAM1r+xp2bpi/YGt2l7CT+rKOPoUaQyZ6X5ENO78FXAU0xG0h6JxVQqLAu+k/zyej0Jnn2ckNgMawoX5ABTYD2uPhrkK+7ol4l3541WCLTq2TPwwjIkAf6kBYMFqcVFLrPSCQDuLQNgkN+qOsFp5XMWHkhgGN9jnjcSMXY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770399458; c=relaxed/simple;
	bh=rfrnfowewbUOhLB7pptm6FNQS4G5WZu9addgE6mifFo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=h/+oRem6255Gt1Ziz5gYUeqj44ozWWXsWEYnNhXYXYLRkTdfGTdVoQzz2KGpyvxKdX7O3hiEbdI45sJ8Q9MLoytXggfJ8LryrTiazFijhvU/a2NYoDKQFsfM2oBYsZoOeGhrWUIpfo70XLDujCdfdaryJS8fr9j8MRVf3p/kv/U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=gq0tNmum; arc=fail smtp.client-ip=40.107.162.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qChOs6WWEvKBnnF7wHM2dMadX/igcvDjca6KN+MHXVGtKjzxHtT51SbfyzFtmE1wfpscEic8DBfSTJ9T3Hu+QNGXdxA1+/Lbs112/zaF2HeQzuoLu6k8PYjaq8dBKjwbK5JaSa0Y1ytTEdO5FfU0simO+oMjRFVP8ch6qb5rd9y8e9rC8owkFINKOnBmt9WRenS9tY705HC4Z22RiUbXJI78Mn9KShl5KIBp71G6KJVNuRGxlOXtkYILWAYzkLlzuBWgSrG75f+roKrpittWQedB58AzCUZT3HEojUdVCbEm4t2XAugY3uarQgdWsxBp+O+ARezaC8HzYnh8qi1nTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GenqaM20siOqiLNnnmvyoJDIDrtmaU19Z033a9jtAc4=;
 b=fc34zMFyY6bdfKrNKmRRwfgTAZ1kEevFGxFZdNfEw+rGMZEKGQUcP3Tn+CoTuwtiPbYtjbd9Ykd0a9y94XRVUoJHGp1wBt4a85MYUAehObUZRH5bSrUQ16eXd2eOj2SrRI3I7SqBDvJJbWvCboLSRIo3sSy491O0AkTuULieOLlblcj3Eq+LYWfe413EumomR9qdjd572JPcyOAiBA14jnath74j1vWeEhPl3wz9Q9rpgBbGzAeZj5KPieiutdTMSvcHzTVKhX6gh8BMIPhEybMOlnEGoCB1VXmTDlqsqfXewm84qsDdjOh1227FHoVC9jYBdzM9jFF1m1Jx3byetw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GenqaM20siOqiLNnnmvyoJDIDrtmaU19Z033a9jtAc4=;
 b=gq0tNmum0uFOjwciWYRByGiInaHZLC28iXQkxhuatPQB1h4DjnfYWLaZ5a0sycpZc1SDE91J7M76oF7SCn2yKscfP8H4ZSXCCijoObcT2oTAF+QQZxTTGfyEoy4uJHNn2ekEe8F6M33kj+ra5H/xZVg7ANw/eNEtWq1WiyzHRkj+8/tiaI/xCmL8NuWQr1AgOyTYGv5N5cXV/i7u1enQehey8YixZaMJ8oUdHkOZtD/UKu+8QhXmkHqwes0j24tQ1AqGkhuzEZhKb6xLpW/eUgPA7jGoRb6DzOIUdhrFp03MPz79zMn3Tp6KGurS1737oFFoGj59ABNN2q3pINCrpw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PA4PR04MB9366.eurprd04.prod.outlook.com (2603:10a6:102:2a9::8)
 by PAWPR04MB9837.eurprd04.prod.outlook.com (2603:10a6:102:385::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.14; Fri, 6 Feb
 2026 17:37:35 +0000
Received: from PA4PR04MB9366.eurprd04.prod.outlook.com
 ([fe80::75e4:8143:ddbc:6588]) by PA4PR04MB9366.eurprd04.prod.outlook.com
 ([fe80::75e4:8143:ddbc:6588%6]) with mapi id 15.20.9587.010; Fri, 6 Feb 2026
 17:37:35 +0000
Date: Fri, 6 Feb 2026 12:37:30 -0500
From: Frank Li <Frank.li@nxp.com>
To: Pat Somaru <patso@likewhatevs.io>
Cc: Tejun Heo <tj@kernel.org>, Logan Gunthorpe <logang@deltatee.com>,
	Vinod Koul <vkoul@kernel.org>, dmaengine@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dma: plx_dma: Convert from tasklet to BH workqueue
Message-ID: <aYYm2pA6l-ksXvkk@lizhi-Precision-Tower-5810>
References: <20260206090058.1127675-1-patso@likewhatevs.io>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260206090058.1127675-1-patso@likewhatevs.io>
X-ClientProxiedBy: SA9PR10CA0002.namprd10.prod.outlook.com
 (2603:10b6:806:a7::7) To PA4PR04MB9366.eurprd04.prod.outlook.com
 (2603:10a6:102:2a9::8)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR04MB9366:EE_|PAWPR04MB9837:EE_
X-MS-Office365-Filtering-Correlation-Id: 5348d7bb-9903-430b-f61f-08de65a66a3c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|19092799006|376014|52116014|38350700014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?drRmqi83JC0ssyzBH2hC/1/VQdmwa+0IkyVO5AHIrgEnTaJQKIUeWadcbmMs?=
 =?us-ascii?Q?O/gN9lJBiRprWyZCUer5lU+oP4phjXN8bWxY4Qlq2S3buvw3iOPJgPuj5c8x?=
 =?us-ascii?Q?92U892SBZ8RleaqkGEHMbzPT72f570AiT6tZ3GT57tnRRP2W3CGZdC9eROOZ?=
 =?us-ascii?Q?4qc3ijrMoidEVWCFpz9zeFcORG0IsEdLzzaUNKcAqY+W8jPuiVspY1anrnei?=
 =?us-ascii?Q?hGHJmZWm84oPgBviBfi4l+yYffKQKsFITNjf/BN7u15lt1QblgSh6S3Sx1kd?=
 =?us-ascii?Q?9UCVQQ/9JU/9u0wS1r2dPTV9//ELUrqs2fLMd1N396DWLfxuHR7Samj+EaY2?=
 =?us-ascii?Q?IK1M0XQzS4tH5GgigLUnB1/QdXBzxUmXWie2WeuY8yGqdvysujbloqB+B/FU?=
 =?us-ascii?Q?Gx9uZvqSFY2c6OFNdgwIFidM7dD1Fuh7C2vmmKxtnp3mKTsBN1xwi57AjreJ?=
 =?us-ascii?Q?5IneHPxQkisebLRgCXimxazuXkkgZnozs1uGQee0yHwZWM2iuU4SFjKyFc3z?=
 =?us-ascii?Q?pj79O4O/H6LIzJ63CHWSDCKdSpQPltwJ2F0mDfI150e6+R8KENQ+YGSe1uG4?=
 =?us-ascii?Q?/S9jV9scS77UdHVoDzhwQoFv/lgZzSx05qVXC7ZWLoPL1fARldn+0glRIGEY?=
 =?us-ascii?Q?c1D6ReEVAvu7e5l/zHNo/u1rz0fXdGZBLXjfiFCuq+61z3jIuSgMxwdBJ4/m?=
 =?us-ascii?Q?0QtT54CfcWbXZz/kbbrnwwcptVDXenxdVtxCP0K/9zu7D4cZ35G8K1SWry/0?=
 =?us-ascii?Q?nmUmSKcY/q7H2/C98KX2j/u8LhQSrC/rHOV8vR930gk3w/yUF/kNBCr5qZPC?=
 =?us-ascii?Q?Alq7RAzkYQwxaYLp3qx3ZE36M61Xw0lqzBGnXmgBs7kZRofN6QSdj2NkJMD6?=
 =?us-ascii?Q?q+PSDzhIJqMWrFpPu7IE4iSAJ+g14Uki9xDc/v0lhoOZMU7FhhNtgKP140oQ?=
 =?us-ascii?Q?M7KJE4ZD4WGSPIwvKTG3GLHTNR4LuaC1LIoZhxPoV2NFBNkLk77t9UOim99E?=
 =?us-ascii?Q?BwahGHEro0bzKjX2uEGb3TloaZf7jLJt6uLU8NuPN6D2IexhP5yZq8BCDnHM?=
 =?us-ascii?Q?5+3q6S3Lh1SY4GrzGCdYKY46E0x4d/2V7qkuERXsq/UxbNhJPeUT5F9ZQ8m1?=
 =?us-ascii?Q?6AsSpt8cO1CTOeV0cS3HKeHE8CXf8XAXhQWr9PEdPzvJoZpOe8dOGcM9O5ky?=
 =?us-ascii?Q?ZZpBGZvl4iBxbAavVtnWCatpu4yLq0Dz0Y/4+93bzbm+2vgxxXz9i3+ki1za?=
 =?us-ascii?Q?FUc+i8GgsZQA8cqZBqGEtoZ63/WAwnj4FeUkSYXwyLNbN4LzN32btmTZB3SR?=
 =?us-ascii?Q?lX98UuiJCDo1NFsQYebsW4Pu8nCK3PA16okUSqvykuG/XRLWznHwm3RtjQwa?=
 =?us-ascii?Q?Zvy9vOOafQBLOeWr2N/bPOUURqOiEcw0z9ACr45ijK+dz1DpiSoPTpPo+5n1?=
 =?us-ascii?Q?2wHNis+SHrboZVi5HyQvHZUgX4vRMReaKGRBE8DwDtHofIsNlSdMqU6FvBhy?=
 =?us-ascii?Q?pxBQ7IEq+cf8kGRkXxvgXOs6dMJX8sCzonSwrbmaVNuAEOmWQnpd/gmMST7V?=
 =?us-ascii?Q?FcqXBdPjqPdAcuRQPLa9ms7waV5scSoW7LdRvRiSjYfRZg8Nm+VhSLC8QhxF?=
 =?us-ascii?Q?xIx8oJB1yJXYacPUibb3OCA=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB9366.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(19092799006)(376014)(52116014)(38350700014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?8KsE9xQ8AdhM6LAb4vht0dRiAdRcvrc09fB2xLlnIK9luky/drjQbtZnTTrG?=
 =?us-ascii?Q?wtDQxRH80YDKvcKuitZJ58EX+xWS0pah2y7Yopxr4gzbO7v7NGodR+jlHsTs?=
 =?us-ascii?Q?UBzyGWBFVqBuMlNScqfqervgfHyssStX9x37zmrMj5t+oQHu4iXX+n6cnrK+?=
 =?us-ascii?Q?dwtzKBzAuCbvnlWHpCOS55w//C2pTPXypbYReVmAluXdoe5XqQO7cely48CL?=
 =?us-ascii?Q?iJ7EJY1LTlF8hefRHnT6ltVjm8oKotLX42MnkwjBtvpb916ZAffgnAE+tQKI?=
 =?us-ascii?Q?Bo7LCr2S8ZxmolEojGKgJ5a3tQI1uXqe/gwlENKlu33K6SDQy1UTiZO68eQi?=
 =?us-ascii?Q?FOM240Wdqu7MP2NyTZ/SSK4Af5/csrwXsSjTaFY5Ht8ModllrW5bjz1Zl5b1?=
 =?us-ascii?Q?xTrIBxF7F8rAeT05C8eA6LVz4ppjRoE+GOy5ST0n2ovmvKVSKaFb87/55CgU?=
 =?us-ascii?Q?aipx6ypcK4sFA3Syi51tYZN/tK/AYw9FZxXRDQgxuJMGxDu7YyfrvjgW1VOr?=
 =?us-ascii?Q?LXqpeqGcKDfj9f9M7WE4/oYvAs/q2EOyIEmpMJP9javwY7bS/kCjVPYNj8BD?=
 =?us-ascii?Q?FPTj9WA4F41WL6qiK+GMUE38JD0jjsxTowBZxvik9uoUFaEau7+mBO5bsvEk?=
 =?us-ascii?Q?jPBqUTSRdn1BYgJW4EWK65bdUlcbJfa5nUWRF1nIzXcQOVjKiC7k+7un+gc/?=
 =?us-ascii?Q?rIvWI/FSafOzkvAf7sXciU/Uw8b+BWxGyYzLsPZvfFSm3J+3EuzQGPqMS8oC?=
 =?us-ascii?Q?LGF1J1HNX6rMriMvdtYBK5RwnN9b8Mi8GoLcqLgfstu4QO/C4LGgjbgesOEX?=
 =?us-ascii?Q?oyvLVJVQ24VcBWidxVYceb5Z4HgGXYnU6BBpiJ9K2DVYwiSZmiAkM8/jDpty?=
 =?us-ascii?Q?5PclXS/t+zYQH6POqvLsd4l+eXV5dFK9/n8vHwHReHX2zJu3Egpzi+0LmFnx?=
 =?us-ascii?Q?dmfixUmDvYra3nolgtJ9AYQ+Y4hhjkMWhfAIwqSCHrEH7MTXFyfsk8ZOdFvh?=
 =?us-ascii?Q?JvLKSHuj5wrPmZJqnbJzIcXtp5c1S/n5cX2A3yQEb8nMy+r3hIeApPJXEe2l?=
 =?us-ascii?Q?4+OH+gGuz7vpzv1pv17C2CWvVvFZLMN6Tw8mAYDWP6/YqJZo0RduYb2WnyDq?=
 =?us-ascii?Q?E/3F6KiGxuGeJTqJp7SnKGUF0TPTXvWSwFDuJkhH8L2zsshoLNop6qXq4WlR?=
 =?us-ascii?Q?6//R4JI01UH2qabR2AhoI1J3oV+k3SKefOyALwZcrQ1cm0hWVVWNWAJdtUk4?=
 =?us-ascii?Q?ee8a5905gE9oAXuQ6eUtL/N2hHauFBtaIkpZaBiGHEF6dKDE5GIdFF1yI65i?=
 =?us-ascii?Q?aWuPhFQ6DIku4coladgYBt/cv9JoSKOVjsRqQEr83UgEDL6utAMvSNzvJBT4?=
 =?us-ascii?Q?c/YiFTAqC+9U3hcbozJ1jk9yn3IhiU4Yr93pyUN6OpcBCi9s2z9ZVZVKyB1u?=
 =?us-ascii?Q?gy4ZVQmotbUyYFutgWoVMpbPSCWEvcllfZyC0jtoFJRyvN3ELwTogDNJXfKo?=
 =?us-ascii?Q?NzMR1X/xbN+OE8goKFwHYgE8KVbBFyM6dnbMuk3RTphoSlRkAylg7X6yWi8J?=
 =?us-ascii?Q?EPLlH9PSbAwMo9HDwbR+SDEQNx9DbGBdXwZVVRRS4fQUnfMZ6CW8PFatLspb?=
 =?us-ascii?Q?UBefQDnpERMtkWe22AVonw8mkg1UBpNOahvIZQ8UsfVUHZNU7y5VVbjCDzp4?=
 =?us-ascii?Q?vjI9qyiVionRrgeuwpuWEGMsRnvOuxzxkIXiPzq+ml1Zr9rki3UFxPPDPriv?=
 =?us-ascii?Q?UA4rXB/dhQ=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5348d7bb-9903-430b-f61f-08de65a66a3c
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB9366.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Feb 2026 17:37:35.6852
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mrPAwb0k6wjQFasYlZ4xTMIrCnZZPryX9lX/Lyh3CrscKScySquleDWgGzCizd/29eVElK0XR5CaGKGqppXL3w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR04MB9837
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
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-8796-lists,dmaengine=lfdr.de];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[Frank.li@nxp.com,dmaengine@vger.kernel.org];
	DKIM_TRACE(0.00)[nxp.com:+];
	NEURAL_HAM(-0.00)[-0.995];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[dmaengine];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nxp.com:email,nxp.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: D045A1013BE
X-Rspamd-Action: no action

On Fri, Feb 06, 2026 at 04:00:58AM -0500, Pat Somaru wrote:
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
> This patch converts drivers/dma/plx_dma.c from tasklet to BH workqueue.
>
> The PLX DMA driver uses a single tasklet to process completed DMA
> descriptors in BH context after an interrupt signals descriptor
> completion. This conversion maintains the same execution semantics while
> using the modern BH workqueue infrastructure.
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
>  drivers/dma/plx_dma.c | 13 +++++++------
>  1 file changed, 7 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/dma/plx_dma.c b/drivers/dma/plx_dma.c
> index 34b6416c3287..be13a7fa5763 100644
> --- a/drivers/dma/plx_dma.c
> +++ b/drivers/dma/plx_dma.c
> @@ -13,6 +13,7 @@
>  #include <linux/list.h>
>  #include <linux/module.h>
>  #include <linux/pci.h>
> +#include <linux/workqueue.h>
>
>  MODULE_DESCRIPTION("PLX ExpressLane PEX PCI Switch DMA Engine");
>  MODULE_VERSION("0.1");
> @@ -105,7 +106,7 @@ struct plx_dma_dev {
>  	struct dma_chan dma_chan;
>  	struct pci_dev __rcu *pdev;
>  	void __iomem *bar;
> -	struct tasklet_struct desc_task;
> +	struct work_struct desc_task;
>
>  	spinlock_t ring_lock;
>  	bool ring_active;
> @@ -241,9 +242,9 @@ static void plx_dma_stop(struct plx_dma_dev *plxdev)
>  	rcu_read_unlock();
>  }
>
> -static void plx_dma_desc_task(struct tasklet_struct *t)
> +static void plx_dma_desc_task(struct work_struct *work)
>  {
> -	struct plx_dma_dev *plxdev = from_tasklet(plxdev, t, desc_task);
> +	struct plx_dma_dev *plxdev = from_work(plxdev, work, desc_task);
>
>  	plx_dma_process_desc(plxdev);
>  }
> @@ -366,7 +367,7 @@ static irqreturn_t plx_dma_isr(int irq, void *devid)
>  		return IRQ_NONE;
>
>  	if (status & PLX_REG_INTR_STATUS_DESC_DONE && plxdev->ring_active)
> -		tasklet_schedule(&plxdev->desc_task);
> +		queue_work(system_bh_wq, &plxdev->desc_task);
>
>  	writew(status, plxdev->bar + PLX_REG_INTR_STATUS);
>
> @@ -472,7 +473,7 @@ static void plx_dma_free_chan_resources(struct dma_chan *chan)
>  	if (irq > 0)
>  		synchronize_irq(irq);
>
> -	tasklet_kill(&plxdev->desc_task);
> +	cancel_work_sync(&plxdev->desc_task);
>
>  	plx_dma_abort_desc(plxdev);
>
> @@ -511,7 +512,7 @@ static int plx_dma_create(struct pci_dev *pdev)
>  		goto free_plx;
>
>  	spin_lock_init(&plxdev->ring_lock);
> -	tasklet_setup(&plxdev->desc_task, plx_dma_desc_task);
> +	INIT_WORK(&plxdev->desc_task, plx_dma_desc_task);
>
>  	RCU_INIT_POINTER(plxdev->pdev, pdev);
>  	plxdev->bar = pcim_iomap_table(pdev)[0];
> --
> 2.52.0
>

