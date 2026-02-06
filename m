Return-Path: <dmaengine+bounces-8790-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aH7pFnEkhmlSKAQAu9opvQ
	(envelope-from <dmaengine+bounces-8790-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Fri, 06 Feb 2026 18:27:13 +0100
X-Original-To: lists+dmaengine@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CB4DE100ED8
	for <lists+dmaengine@lfdr.de>; Fri, 06 Feb 2026 18:27:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A48A3301FC88
	for <lists+dmaengine@lfdr.de>; Fri,  6 Feb 2026 17:27:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8903541B37D;
	Fri,  6 Feb 2026 17:27:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="s+i0KRfx"
X-Original-To: dmaengine@vger.kernel.org
Received: from OS0P286CU010.outbound.protection.outlook.com (mail-japanwestazon11021088.outbound.protection.outlook.com [40.107.74.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24CAC40FD89;
	Fri,  6 Feb 2026 17:27:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.74.88
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770398820; cv=fail; b=orDlfFS1x8c+QHhrNeBczU5A7SFIt/NxHOcvdnx7j7jb3aitYRQEkAihc2e8J4GeqMXFWONaRmrAvRq7mVMbefvSEdshh9P4VGTWLYpbqlngNGssdgNHR1Nrn3gzG5aDMhrICR/71GQbLBiu2kee7gzsYuMbLLc0sP2O8zwZcp0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770398820; c=relaxed/simple;
	bh=NG8MUtgi+Z82M5ynmWLRNyGPWtBA66rbgMgrW4mH45Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=E3LuxYlCURdChW3f7q71l7z6PKWagEv4B94xXvhFMgNJb2wLV0OD6WpHlU3ffE5UuFj84nIsYplu3Oi6sfqNAIBxd2nfu857qW/jnMXABG0wSK6E5Nxvofb96SlOgyP3qN81dBCO/wZ4j4obC15Qzk96KYg4KIj/N8rRfw2J078=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=s+i0KRfx; arc=fail smtp.client-ip=40.107.74.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NTLdl/mobazsYoAD0KQp5Kk7AByXu2PqbalKCbp7jC24UDpEmnee9T89KpGIbVA0lw8RlKtLaNrM9MpMFpHS6aOdLrKrqOvaGQ2eR0w3U5jUU/zMgN2Jq21OANtq7lotr3W45Rlnv1sPak9k/syLMbFYr+OZoaSn0apd51EHYumbmQ2scnnMHrMAwCBbdLB6Dh1K/A+10qXGyDVxVGi8vqNoWaMEvmZi2Rmy1mgVjO+BC8eXaG8AbUDl30IHSmTFPCXCM6IqWCUb5ezmBRJJbnLPOWPQ6DcriuCYKIYggJ3WRq5Qc+lE6IQDKFVetqOPZ0vyFD/lAKkw6dv3a/LuWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iwMzAitgI3gaeKehwnCdYVc3sFzOJyu5rJRAVbsPsW8=;
 b=bAUPqf3g186DVlCSfyg0vyrxLRaYHmk7PB6eMkTwytIULFteDwWpSnUQD56rmySWrRuGeNZIrj+Ld8I1gY3JP0AVI4XagZR36MFMQ+nhYVlnpIto5p+zCsal6srGaxtV3F/H8P0Ac74U7+LF8LKQa106vayH1oNRCFkvHD5GSAy1eyPM8hzzxc0MCGwzdPqYVae7xb+mCLNLq/2z6nyM4t4eRdwbFXzZWGkcyY+SSRxzXzlYz8J0re+l9raWsAVeMbshfckZ3/BMwRfsNdpiI8baM8DZjKmNhQHXmRVO9j37ou3oRzW3rYOih1Aot5Uzfhy8IyvRBnUUY4xujfHYrA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iwMzAitgI3gaeKehwnCdYVc3sFzOJyu5rJRAVbsPsW8=;
 b=s+i0KRfxj5NRlq3ynE25QGNLk5kY7TZf7o2Tad4WBSvGKJZbgv49TmLV7y6xA/Vx4PKfyYAvXG4pRyc6FwfAIX8E/LTKyh7a5FoKTOYa5H2qEUypny6DAzbfpuJVEBk76vng/8MPMv9miF0sh3sYD79Vke97w3+kEU33qBIqyFk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:38f::10)
 by TY7P286MB5571.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:1f1::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.15; Fri, 6 Feb
 2026 17:26:56 +0000
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32]) by TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32%5]) with mapi id 15.20.9587.010; Fri, 6 Feb 2026
 17:26:56 +0000
From: Koichiro Den <den@valinux.co.jp>
To: vkoul@kernel.org,
	mani@kernel.org,
	Frank.Li@nxp.com,
	jingoohan1@gmail.com,
	lpieralisi@kernel.org,
	kwilczynski@kernel.org,
	robh@kernel.org,
	bhelgaas@google.com
Cc: dmaengine@vger.kernel.org,
	linux-pci@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v4 4/9] PCI: endpoint: Add remote resource query API
Date: Sat,  7 Feb 2026 02:26:41 +0900
Message-ID: <20260206172646.1556847-5-den@valinux.co.jp>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260206172646.1556847-1-den@valinux.co.jp>
References: <20260206172646.1556847-1-den@valinux.co.jp>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TY4PR01CA0052.jpnprd01.prod.outlook.com
 (2603:1096:405:372::10) To TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:38f::10)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY7P286MB7722:EE_|TY7P286MB5571:EE_
X-MS-Office365-Filtering-Correlation-Id: 62cb6ab7-271c-4744-3698-08de65a4ed94
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|7416014|10070799003;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?njodKtSvooG7J1vHw6ou5Omg2H2IyQc6k0OiTpatA1gIgsjJAoKi6GppfvmB?=
 =?us-ascii?Q?YTEhCCUzCVLpKnyhxKZDIPbjkGn4rwV+EJdipsRfJqRJTgEGi2EjDg97bm2s?=
 =?us-ascii?Q?EQDFEd2i1F0gA0u9np6/w1Fuiof3qYIlMJFVRY6Q6cICZ1DTCPe++bgxi8Ns?=
 =?us-ascii?Q?qgPCMa5CyJX+NVcEoOf7tE/IjsW6bZNRgwePdHIc4IP/O0qsCCQQf0OxEB1A?=
 =?us-ascii?Q?BVMH+b72WTJiM6LI+g6uELDWWpW4oOEz9NMcNJl+KOpP5pQOAMOTLgs94GgX?=
 =?us-ascii?Q?lAkOP/+Gwq01eQVOfgy2Q+1htXcgVrxkjF03FoOJZATH01w5qC8u19iz30Px?=
 =?us-ascii?Q?4KHeD0AdYfok2wAWMXeo9kEF7tlG03uZebXY+/8A42WF7YBhnO3oCR3bCgar?=
 =?us-ascii?Q?88YOGyPeK+T03KzNiOc+29/ix+HGzJakM9vJ/lQ6ganOhtFFGkIQI0be3kVE?=
 =?us-ascii?Q?BngWrZjHwIzrNoAVuIDW+YjoOal30rTVKxCMfysorwrJronydDLZCjql6hpO?=
 =?us-ascii?Q?3DqeMiD+QWDJ02KduPTqnSilKCUu1BYPyIBU9C/FeflTED1yVpWA0lGCk7st?=
 =?us-ascii?Q?fvlBx5fguli5l6z1H4cDsAGkEkgGlsWf+ynPVHMZajzHhRnFMIyvHoJR7UK4?=
 =?us-ascii?Q?/XledwluQI5keKQF5E51nZalZ/PC/D325jt0Y7nl+nJDuBXZDtgmIbf+74ma?=
 =?us-ascii?Q?y+b+ZcLycgUIYeu3Id8Ds0ea5QokFdpE+efjzgeCjxxDZMk9yVeJ9ig9fOVr?=
 =?us-ascii?Q?FID2JWjZnMbnQsEUcsyximuoSJFjv9s6+P/O3sw9DVAIu6PEHMNUIjHn85e3?=
 =?us-ascii?Q?2u7RScZ4sRHKsebl1fyJnjO5pvA1zHlg2iWcrjjU/tGTROhFd6x96Vm78T3b?=
 =?us-ascii?Q?qi0s03U3HWeL/5jPILPbYQl0NOlLe4zARCInejfsqbN6kYl8ohGKEKnSM1jL?=
 =?us-ascii?Q?UyftHxY0+tdZ2M0+919ptomskIFoHGfZ4MZTcYWrdRRURK46A/2lppJgUePr?=
 =?us-ascii?Q?4Yw+5WJLIbYq0m5X0DkRGcF6lxizWelprR5vMrXdffZEsmVxLdfQVDCLX13R?=
 =?us-ascii?Q?eJFF2U5qC/HzwxtNOkp8WX5HNpgy5KVzySfgSN2rFkv7jEBxv3IQB+aL5ETh?=
 =?us-ascii?Q?r+uopabVE4V1T0IB086GjyJ8t++iOofy7Pl7/xqNVViy37FBTim7eBv2mxZ7?=
 =?us-ascii?Q?TwVe33BLxGLkxnmbrY/ckpoNXrgAAaMG8CXDTuXwXUMLxM1WsiHVQlBodXCj?=
 =?us-ascii?Q?eMO+C/EeZj6l40rLAb8HZd6GxIhkTTNEoZmV3LWKBLCL3+N0HEKZOqf/Yzzt?=
 =?us-ascii?Q?568TkgnnOAWFZiSJHtx1CLfmWNZ5XEjiHKnAau+2/xzIt0hkh9jdsia6rGRA?=
 =?us-ascii?Q?+DSZY6brso2f6NqTzuCPvlJUismpY3Op894rF5crtkQ4Hp8sKio+Or5IXR5o?=
 =?us-ascii?Q?YcwQS3IzXVcpE81SCQUz0rc7SGhC+dPfXy9bE+Zownk2kx7qAFU9zYvxS9Rl?=
 =?us-ascii?Q?We/wWdx7V/8Z/seu62UOlsAGc6hAPnHONPirBzKfhyAM7y7Jehk/2E0AgRvi?=
 =?us-ascii?Q?buCAsel3Kx/xuHIxjeo=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(10070799003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?oQPKdG0GLoXbSuSq/ol6ETaaqKSNHmKpmvRLZ/7iykgO+D2PNSP5S+TGkyj1?=
 =?us-ascii?Q?hU2qr1U/qAbUUEynBHsexuczPuPK2cv+ul1iQjwj2HyshAAR3FeVK1gD5cbY?=
 =?us-ascii?Q?Dazh33fR2yH809Jvvu8ntP0FEuK1LnilQLJGM+phkYJyInrB3npOv3fs4jop?=
 =?us-ascii?Q?DsSe/3OURsrM1dHQk9kNbOdMUEwYpMhz2TUrQDLVHlYNUex/6bP0Cv457OFi?=
 =?us-ascii?Q?UdeQtLknubUli+U35Gy/rvy5gvr/5Gs/0kAZ4/HYougLEcX9vD5JyLdugcwR?=
 =?us-ascii?Q?4oTbrOG/k0TzFKSx+CmyTPpZni5SGyYQYccTMlUQxva7ADDM4rVTM/n2jICk?=
 =?us-ascii?Q?Uy+W40/xayPPSIvUtdrkMOAlvjldJLIV7oIfndzHtMGMGBGOqEhIX/SrUg3P?=
 =?us-ascii?Q?2en/WBJWd3eWHw1+bziEqR0dWACz0CVUpQs9Hg+oOwo/0VdeYo0xfQotPppD?=
 =?us-ascii?Q?+Ps4L86gQ1OKmcQ0Jyaq0JYY/0hVF65qiQQjQSn08udE1uCxX4ssR9mIko98?=
 =?us-ascii?Q?bUXvKElE0tEQ6KwxyB8zpVAwVXRPbUp1SGG3lDdYUskspBi0VI+9YuxZ2KNd?=
 =?us-ascii?Q?qnT0usyxJd1ioKelA5fstJ9wnEjP2hrKckGIuYqJ2jYW4wi1ojkUBIizrLzx?=
 =?us-ascii?Q?qC8bTN3owZ4ihKeHBxcjL46vUu+7KnYsBWP3H8Rr7wX31EhBel4cLygrfGqD?=
 =?us-ascii?Q?NMpp3Qf+K19ShctfSffWVa8Qn0FkbfC1mDRHw9Iumfw0LCbk3fCqHnGO6PS8?=
 =?us-ascii?Q?IaeLphVzTsFAMsuniS3FiUZCppAuG1M/ymTrndN0X6/wOPAX5nlhsSJ098aX?=
 =?us-ascii?Q?5XbRfAlfahWY84deP9l7APiukjP671FON0LouMfmoS1BUPsK2mA+vggAAB2T?=
 =?us-ascii?Q?5rCMIjAoEjCqVeL1wJAUQzfMFEA5j2RhjdEZ+Y85bOpErPPZwwvoiFCam/E/?=
 =?us-ascii?Q?RWMqFufhD5dwSKE6c0QfhzKVSIQB3e5WueSFjA4AsFnNYfkvoQ/PTiGFHyrl?=
 =?us-ascii?Q?942O1XhSyVdXzuSCgTM8eDB2YsG1k1zlhFua88DtStQrN26fp7+RWsLVk9Lr?=
 =?us-ascii?Q?To990BQUiGhAeooK9NYKKAVjIMDZyfyCM3WY3KWcXzFFUxKYvGeIsVzZKOQE?=
 =?us-ascii?Q?3lugGdchzmKsG3wGNSJp87twIetNjH2kCzV3bFChkh0NacYV6yKr8OezLOX0?=
 =?us-ascii?Q?Fb8npSmeb84dOyAtjkZpC4BSwiLkTLR65zkX6v2pOgxUMP0w0l/uipW8SJB7?=
 =?us-ascii?Q?a3m//OVevnVMq7N9YqqBeUgFlp50pNnqCppe1YB1Yn+CP6p6uJk04skWTD77?=
 =?us-ascii?Q?HggxcncmQFOgNn1huY6Jas61Z2pXCscgRrLNm3zaE60g6521ljha+5jvqobZ?=
 =?us-ascii?Q?J/mab3vU/KBJyTe+OdQpmuZx5g5j5RaAe5wPgMLnI0JLiuO2D1sPMcMurIRM?=
 =?us-ascii?Q?W7hOlfVePd/9jScWEfdMFEvwY6SN795txCT+f+L2HYEvXkmntWCvkfiGQ5qk?=
 =?us-ascii?Q?MhkwzGo0Q9+gOwaJVj6HRcqCfnm9P4cL3R5yPADfCNyeMOV3eMFPTRS3FvM9?=
 =?us-ascii?Q?YVemjLSZT8xP4RoMTDzEOkl/kXtREpY6jZnNWQmdnNunSZRT2INcLUA0IAfh?=
 =?us-ascii?Q?3TRHhY66Xt95b3Hr3xxOWnkDhLW3nj0uhE7WSplG5MGkH2YXzbEIznGPUDsU?=
 =?us-ascii?Q?Xr1RWbaVY/BnUboPiFho3JFtAUepnZ58ReRkDPW6LOlhu6k/gulqahNXyNdJ?=
 =?us-ascii?Q?JzYxSTN5Vi4Aju7jxlG/BPcx8tv2g6SmqWYmh8BmVwca+iILNsXk?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: 62cb6ab7-271c-4744-3698-08de65a4ed94
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Feb 2026 17:26:56.8556
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JqVM/UgBE7hYmHdKnFx4aZmWqFhkNK9RJybcPjlNyR/8NR85mUQXQgoJsX6m8Y3lt2YA5l+ndokw/h2MAqOWgg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY7P286MB5571
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[valinux.co.jp,none];
	R_DKIM_ALLOW(-0.20)[valinux.co.jp:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-8790-lists,dmaengine=lfdr.de];
	FREEMAIL_TO(0.00)[kernel.org,nxp.com,gmail.com,google.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[den@valinux.co.jp,dmaengine@vger.kernel.org];
	DKIM_TRACE(0.00)[valinux.co.jp:+];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[dmaengine];
	NEURAL_HAM(-0.00)[-0.998];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: CB4DE100ED8
X-Rspamd-Action: no action

Endpoint controller drivers may integrate auxiliary blocks (e.g. DMA
engines) whose register windows and descriptor memories metadata need to
be exposed to a remote peer. Endpoint function drivers need a generic
way to discover such resources without hard-coding controller-specific
helpers.

Add pci_epc_get_remote_resources() and the corresponding pci_epc_ops
get_remote_resources() callback. The API returns a list of resources
described by type, physical address and size, plus type-specific
metadata.

Passing resources == NULL (or num_resources == 0) returns the required
number of entries.

Signed-off-by: Koichiro Den <den@valinux.co.jp>
---
 drivers/pci/endpoint/pci-epc-core.c | 41 +++++++++++++++++++++++++
 include/linux/pci-epc.h             | 46 +++++++++++++++++++++++++++++
 2 files changed, 87 insertions(+)

diff --git a/drivers/pci/endpoint/pci-epc-core.c b/drivers/pci/endpoint/pci-epc-core.c
index 068155819c57..fa161113e24c 100644
--- a/drivers/pci/endpoint/pci-epc-core.c
+++ b/drivers/pci/endpoint/pci-epc-core.c
@@ -155,6 +155,47 @@ const struct pci_epc_features *pci_epc_get_features(struct pci_epc *epc,
 }
 EXPORT_SYMBOL_GPL(pci_epc_get_features);
 
+/**
+ * pci_epc_get_remote_resources() - query EPC-provided remote resources
+ * @epc: EPC device
+ * @func_no: function number
+ * @vfunc_no: virtual function number
+ * @resources: output array (may be NULL to query required count)
+ * @num_resources: size of @resources array in entries (0 when querying count)
+ *
+ * Some EPC backends integrate auxiliary blocks (e.g. DMA engines) whose control
+ * registers and/or descriptor memories can be exposed to the host by mapping
+ * them into BAR space. This helper queries the backend for such resources.
+ *
+ * Return:
+ *   * >= 0: number of resources returned (or required, if @resources is NULL)
+ *   * -EOPNOTSUPP: backend does not support remote resource queries
+ *   * other -errno on failure
+ */
+int pci_epc_get_remote_resources(struct pci_epc *epc, u8 func_no, u8 vfunc_no,
+				 struct pci_epc_remote_resource *resources,
+				 int num_resources)
+{
+	int ret;
+
+	if (!epc || !epc->ops)
+		return -EINVAL;
+
+	if (func_no >= epc->max_functions)
+		return -EINVAL;
+
+	if (!epc->ops->get_remote_resources)
+		return -EOPNOTSUPP;
+
+	mutex_lock(&epc->lock);
+	ret = epc->ops->get_remote_resources(epc, func_no, vfunc_no,
+					     resources, num_resources);
+	mutex_unlock(&epc->lock);
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(pci_epc_get_remote_resources);
+
 /**
  * pci_epc_stop() - stop the PCI link
  * @epc: the link of the EPC device that has to be stopped
diff --git a/include/linux/pci-epc.h b/include/linux/pci-epc.h
index c021c7af175f..7d2fce9f3a63 100644
--- a/include/linux/pci-epc.h
+++ b/include/linux/pci-epc.h
@@ -61,6 +61,44 @@ struct pci_epc_map {
 	void __iomem	*virt_addr;
 };
 
+/**
+ * enum pci_epc_remote_resource_type - remote resource type identifiers
+ * @PCI_EPC_RR_DMA_CTRL_MMIO: Integrated DMA controller register window (MMIO)
+ * @PCI_EPC_RR_DMA_CHAN_DESC: Per-channel DMA descriptor
+ *
+ * EPC backends may expose auxiliary blocks (e.g. DMA engines) by mapping their
+ * register windows and descriptor memories into BAR space. This enum
+ * identifies the type of each exposable resource.
+ */
+enum pci_epc_remote_resource_type {
+	PCI_EPC_RR_DMA_CTRL_MMIO,
+	PCI_EPC_RR_DMA_CHAN_DESC,
+};
+
+/**
+ * struct pci_epc_remote_resource - a physical resource that can be exposed
+ * @type:      resource type, see enum pci_epc_remote_resource_type
+ * @phys_addr: physical base address of the resource
+ * @size:      size of the resource in bytes
+ * @u:         type-specific metadata
+ *
+ * For @PCI_EPC_RR_DMA_CHAN_DESC, @u.dma_chan_desc provides per-channel
+ * information.
+ */
+struct pci_epc_remote_resource {
+	enum pci_epc_remote_resource_type type;
+	phys_addr_t phys_addr;
+	resource_size_t size;
+
+	union {
+		/* PCI_EPC_RR_DMA_CHAN_DESC */
+		struct {
+			int irq;
+			resource_size_t db_offset;
+		} dma_chan_desc;
+	} u;
+};
+
 /**
  * struct pci_epc_ops - set of function pointers for performing EPC operations
  * @write_header: ops to populate configuration space header
@@ -84,6 +122,8 @@ struct pci_epc_map {
  * @start: ops to start the PCI link
  * @stop: ops to stop the PCI link
  * @get_features: ops to get the features supported by the EPC
+ * @get_remote_resources: ops to retrieve controller-owned resources that can be
+ *			  exposed to the remote host (optional)
  * @owner: the module owner containing the ops
  */
 struct pci_epc_ops {
@@ -115,6 +155,9 @@ struct pci_epc_ops {
 	void	(*stop)(struct pci_epc *epc);
 	const struct pci_epc_features* (*get_features)(struct pci_epc *epc,
 						       u8 func_no, u8 vfunc_no);
+	int	(*get_remote_resources)(struct pci_epc *epc, u8 func_no, u8 vfunc_no,
+					struct pci_epc_remote_resource *resources,
+					int num_resources);
 	struct module *owner;
 };
 
@@ -309,6 +352,9 @@ int pci_epc_start(struct pci_epc *epc);
 void pci_epc_stop(struct pci_epc *epc);
 const struct pci_epc_features *pci_epc_get_features(struct pci_epc *epc,
 						    u8 func_no, u8 vfunc_no);
+int pci_epc_get_remote_resources(struct pci_epc *epc, u8 func_no, u8 vfunc_no,
+				 struct pci_epc_remote_resource *resources,
+				 int num_resources);
 enum pci_barno
 pci_epc_get_first_free_bar(const struct pci_epc_features *epc_features);
 enum pci_barno pci_epc_get_next_free_bar(const struct pci_epc_features
-- 
2.51.0


