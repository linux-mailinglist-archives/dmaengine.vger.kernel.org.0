Return-Path: <dmaengine+bounces-8876-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EL43BJ47i2neRgAAu9opvQ
	(envelope-from <dmaengine+bounces-8876-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Tue, 10 Feb 2026 15:07:26 +0100
X-Original-To: lists+dmaengine@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A4C4611BB5F
	for <lists+dmaengine@lfdr.de>; Tue, 10 Feb 2026 15:07:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 3E1F03008D6F
	for <lists+dmaengine@lfdr.de>; Tue, 10 Feb 2026 14:07:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33D48366813;
	Tue, 10 Feb 2026 14:07:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="KutZFyr/"
X-Original-To: dmaengine@vger.kernel.org
Received: from OS0P286CU011.outbound.protection.outlook.com (mail-japanwestazon11020139.outbound.protection.outlook.com [52.101.228.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C619328B58;
	Tue, 10 Feb 2026 14:07:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.228.139
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770732443; cv=fail; b=U+XQjuoV4BsiycgD1HnVKM/STo+t4IDeP5D0gt0chkh/MuvnhIAdFWzcGKiiZlRBjNd2Bm0MLXnJ7oFzhZpkAkNymFzM9YTmyrp5PWrN5k/QW6fkvwKV4YK2vdv6H3K2ka6DtmxTi7sCxcboolo4aVUp5/y3J7q7I7nivNsorvg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770732443; c=relaxed/simple;
	bh=ODIAsLFC5WOhNc28K7/v1g92PKzf9wY+Ci+Vn5/U+/c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=DTV6G0P6wOq8rW9kMS018qLBl07Rh4eXj/WAwSdQY+ioETN2GvkiSn3pR6zeELM8tbpYYKVkUOsLOEtO5CjSCED/1XfYnntZFNRQCwPZcPwkmyOZ4MBduFPORRs0/kUIpcG4SQ3JfAI7My7TIEEo2OIIAsyLbkR02GzqtoqvxH4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=KutZFyr/; arc=fail smtp.client-ip=52.101.228.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XLo8zMno2JNRZ6nvxXTYFy1jYuWqICWRLL9eDK0dholxEd7hH9rB9eQDa9A6HvPVQZZrze08AKm7qv3cHOrW5hh3LKdfXTMiJz2v91Nh2lCsnvF0t9EizMaf+kBoYX9B0YV/eITy1CVrOGAKe+Fl6bdwsR0dRFGHapGTwp7pAqqeb4K030KnPF6S63PqN017CHVyOULevgNKvI8PbldZUiEi7a3HXc99zmUyRuoV4bdnW/oJ6S8awcDw9gVuSN9sKNB3t0wKoQ6IayoIHqBLbJrKUxMQh0EjWjfpAuNlHmeIBzxQjAsgE5xq6u3ySnll9imOzSaBKIdxCSFhxcJ3AQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mUeufMD70YQ1NtfQzh/zQESeAypCA+1Hzm4LkFP8hsY=;
 b=ImYMjq4qsiaztvJvJ0LRTvMU1KzCVcIMLbbj3bm8syBaKIv90egUEasGqLIvtpaE2vzP683r6qe8+PM5TPFbcUxMpuJFEeuo3uRFk2bZA9jrW3AmpvtdDg2ghAA2MjqV9/iHp92Vvl38lRhrfS4bGDRlEEXGs0EOvmi4iFYVofCpPGBwB2tbvXAewagkP//z0VjmQh3QydGy4T0EJU/p6GVDNJRh+K8MAebvnJ+vF0UgK823Po6ke7jgO8Nxezns4xOf1AAChFLGhgKGxMlWhNZ5Mh94FOtYTiXif3tBTluOFsO+UPzpKUgQaSI9LSUZN4b9cqR3z4oIhkYcwS5hVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mUeufMD70YQ1NtfQzh/zQESeAypCA+1Hzm4LkFP8hsY=;
 b=KutZFyr/yudmKg5OlAV3E6b8Umizz2va91zRct+iAE/iIF4NzAOFIcYXJBJYlUxU6pVUsVqWu0Inl++bgZhh83dtfUTzb+OsSn3J6VTUwc/8I8jAykRaqHKJq169jRErntc0J9+3ac9Livtl5ZYTyiU4voc+bT2J+wfQJBNRv48=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:38f::10)
 by TYTP286MB3915.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:182::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.19; Tue, 10 Feb
 2026 14:07:19 +0000
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32]) by TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32%5]) with mapi id 15.20.9587.017; Tue, 10 Feb 2026
 14:07:17 +0000
Date: Tue, 10 Feb 2026 23:07:16 +0900
From: Koichiro Den <den@valinux.co.jp>
To: Niklas Cassel <cassel@kernel.org>
Cc: vkoul@kernel.org, mani@kernel.org, Frank.Li@nxp.com, 
	jingoohan1@gmail.com, lpieralisi@kernel.org, kwilczynski@kernel.org, robh@kernel.org, 
	bhelgaas@google.com, kishon@kernel.org, jdmason@kudzu.us, allenbh@gmail.com, 
	dmaengine@vger.kernel.org, linux-pci@vger.kernel.org, ntb@lists.linux.dev, 
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 0/8] PCI: endpoint: pci-ep-msi: Add embedded doorbell
 fallback
Message-ID: <2lii3hhzie5n2kkoan7hvittid2bo2jgvkb2fndyscc527xglp@dubt3ie7exdq>
References: <20260209125316.2132589-1-den@valinux.co.jp>
 <aYsjfTtA0EsXwh69@ryzen>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aYsjfTtA0EsXwh69@ryzen>
X-ClientProxiedBy: TY4P286CA0086.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:369::16) To TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:38f::10)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY7P286MB7722:EE_|TYTP286MB3915:EE_
X-MS-Office365-Filtering-Correlation-Id: 30f9d5ba-19e3-404c-8ed4-08de68adb319
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|10070799003|7416014|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?U7Bo/LwouLCINwV2cfjyhDLSVpIyucy7VSkiN5fe6dNwGfYA7QOdIhk3KIwV?=
 =?us-ascii?Q?82jTgHnk9qlgLd4dSkpArVHgpPoOSbLvHNDhs3NzgGlo3hst1Kdlc/pr+rN1?=
 =?us-ascii?Q?E3YRpqx0L3YQMWBBAMl47pW6nlxeqnF8gdat2RBFjU9TR51yhg98H60eXv3B?=
 =?us-ascii?Q?x3Y+cPQoBaQRgIJejBDmkOwQwzpjZCjaEhBDD6gKK2dFcYn8dSsz4m0leDO+?=
 =?us-ascii?Q?4wrkjsuuB1JnwbdKjxDrCO+AmWzSYZsI5gEunUUx/aaZe4W8IZdl2KQ8whtC?=
 =?us-ascii?Q?JunQorZWWYSGPsjpjEWwuTHcn7JntWGYK+KtP5Q7QbwgmjwPkS0Els4NiDus?=
 =?us-ascii?Q?O5pQWv8FuUtUECWNJXHMsK1DpubezhhQWWwR8zqmD+dWDs5yEDEne08PTtIS?=
 =?us-ascii?Q?btpnBn+PkHMrwY0KLOTo5yoITEA/IRtWfEVLSJusLvXHoKdHFeQskbVoNNk8?=
 =?us-ascii?Q?8eDCk0HM3yuAWXE5jd3NtAyFSiqlkjT/ZLFXy2NU/pC6qMDWx8e997aHRtym?=
 =?us-ascii?Q?LwcPf65fLxVbEcadBW51RogAfAOIhFaI2EYJbeyo5ve92hql6fogDMHXaiea?=
 =?us-ascii?Q?YCzcdHZXuuAaP4sfbTs82FSZomc2UND3IK2F0tfZYDJ1DYa994H47TZfyVui?=
 =?us-ascii?Q?MXQswxYB4TxxZbcv6ZfkoJ5J4esf0nyQZGz9DY/4pfyg/hVUS5986PdCBTIe?=
 =?us-ascii?Q?me0uTI5Mbp7UH8bmwlnwTIR/5zTUtR9IUFmOS3Kmjs3KHnaetKnVvbXBII1x?=
 =?us-ascii?Q?6OydZk1rEnL5jKKy7+/Tt2JcIO8EHiK7qSeuEkMwgEIccRxpkJbVnHezzbhS?=
 =?us-ascii?Q?rOnFeVew6v+fevVxfPu65Cos33qJYBrsLpPm7GyfdDDBk/tYKnCvKg+IMCRu?=
 =?us-ascii?Q?yFeI8UCzaPpfQMrfghqgWihIAXQ9UlbCCCldvG+eC6U6nXjhj7p9sasReNsV?=
 =?us-ascii?Q?lSZRqSDlDABmKexkOrHgU0fVb52xRj3WgWWRID/ahiAABdw4nz1HpnppU9Cg?=
 =?us-ascii?Q?ZefqNu7gfnQ99cpyGdroucLS0soUxQ8kSlscS1B8ispSSmua0RTeu5exWFSv?=
 =?us-ascii?Q?9BVLV4vvj35MhGFz6GfApI4xE95gA+GBwJvJ1COFBHsFkEBbFtV+A2DEzR+S?=
 =?us-ascii?Q?Sj1t337IIcU9n26qirfE3OQILcPqymo7sDDFmqgcCZmeD07ON2gd+2x5yms+?=
 =?us-ascii?Q?BiV6BdWAM7wqhYOnW1Hd9PKrz76VPGo1sRV6wa9E4i/CFN2IpC6xObNPZzoq?=
 =?us-ascii?Q?NgXGXPG+XQds9OULmskpRCRkmMzOYSeo+hzLIrhOsCtEvjlrvuQOFTFV/r5R?=
 =?us-ascii?Q?OPwEfIfFyRttsCjT1mTSPL8LuNHOILoXs4kA4cfcCK5xfru4dCtuBq2js94m?=
 =?us-ascii?Q?NIBqvp2ZL6Bv21dyfxCwHRP3btJBOaVxVEfBhYCqgIDAG7dB4akEUzk4OgwU?=
 =?us-ascii?Q?pJ0lqXWaBMEK5Rq9VPtFULmD9JAJlAc2H683PAd0rGQxqD0Bu3CyVXFwrbGh?=
 =?us-ascii?Q?c58xAAXpWZUSH9RUUu5rW8JCE2+YcjY26XogR7wg/WjezQXcMRiB28mZxdep?=
 =?us-ascii?Q?Zee4YeSSTcKPMl+rapM=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(10070799003)(7416014)(376014)(366016);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?RNum8xzBm8r2Xv06BNDgFCAjrwHm75KxldHNHMfSjZgUXWjpy8cQ/OxygX89?=
 =?us-ascii?Q?ppZ1A7WrGZUp/AI2IB6u2ZDavrJOFKjLTOfYGhuQyVxUUdrfzLjIi+L9ucgm?=
 =?us-ascii?Q?HEFJYX6II7V80U3v7UZhCePjSvIvBFrii7C/2EHgVix694FUnVvfjDBSqMUF?=
 =?us-ascii?Q?dNNoKFSyH9dNW+4YKec6P6OpVAqsrclgyI65JpQmhOA1oYNiAgZrQsT9fciV?=
 =?us-ascii?Q?Xjc2Bm7v+smssVdPfHYHuxU4PdBJ9jUKHScJAU6/sdfiImAwTtmB5sAqbxhO?=
 =?us-ascii?Q?yRTdROzXY0mEkzgIcmsRVTALZFvfDtw94AvLmDwy9CORfUOXDF4BavczuaNt?=
 =?us-ascii?Q?sDHhJ7CjpyFyTaAdZmBrwNuLno4fYe2VCZDhZDY4Vtt+Wh2QF3p6bcQupGCS?=
 =?us-ascii?Q?h8nXekeHE9ELyzKbI0GsMsApL+D/V3i3Qp77lAlNEXSGPfEvffreEI0Lgqkm?=
 =?us-ascii?Q?7oBbarSrDr3iShUWlqAuNbrrcRGg3+yR9fNQg/xwsZ0fYBiFjQfYWlJxDm8q?=
 =?us-ascii?Q?bQtweIHENFckATzqbKg1rUJVQjQjL58KnRtLEyoYnoEMtHrvY7wJZIfh9bgV?=
 =?us-ascii?Q?K2+mPyB7h6PmQkexhgIoISEBXSJHPaqGhk/fdbizE+bID2+0xfOvBMzCLNSs?=
 =?us-ascii?Q?8BFCYW2e62XNxYkcQmvzlF7ZjtBLKeIptU9cl6G43rqUIFUWgKBrOe3Z9Pyg?=
 =?us-ascii?Q?UKYd5QImLpC4YXuzsAhqoohIdTyP9WWQ+mrs2D77CIXn9fHkbYJNb6tlMkh5?=
 =?us-ascii?Q?Vq8R15zHsX+0ADsIkWKd85i8zTsZZQeZw/+iCS8m3Q9kiLzd3EdQULc9kvQ/?=
 =?us-ascii?Q?FElILeqmG20bVOiXVC2LZ5yVK+ZL9gedZ28FISjG4f0DhbC0eCk7g5vXy5wa?=
 =?us-ascii?Q?9NiarAsQsHbTGpb/Mh7NK2K9wmvvfitZVN/s6zdV+q/kBgVX9OdVKpUQJOO2?=
 =?us-ascii?Q?BcqFJRVTh/9V1ttTwaH4EGfttxhwEU1m58lFjnhyedEJ1Uwr7xf8TdYeMYj8?=
 =?us-ascii?Q?iun0vTzXE+GRQWaFiDx64mPOKtxSTx9MD22RDJru0/juEZoh/ZuNSwI93JK9?=
 =?us-ascii?Q?rGqcRBjT6uf8qqbEQtelqAINw4j9BF8MrdLODzc6K/olIbyZOsZvICi++SlK?=
 =?us-ascii?Q?LLNU5snyf300cyXkmT0t37a24I7DoHTImGaaa+1LSc1wGPqpbKKhoFXfkLbM?=
 =?us-ascii?Q?r+GqiTuDJGbdFB6xtJj/yI7tfiYE/scTrV9HmkC9BrmB7UxjJUZvJQvPc7RC?=
 =?us-ascii?Q?sIyeSSC9VZUpEAgzkkjYr6c2KebTMSiKWtXgLT4EtslP4qQP7btUuqpf9JUd?=
 =?us-ascii?Q?Wpj1Xwk5B0fCUB6vS3Kvd2/tZreO4HJVs7cO6/j9w3XhOyIf/UlvybKftr4h?=
 =?us-ascii?Q?iYrUz0Rf31zO41telONdG+xsg/HWs9z+4IkBhT8ksXbw5rDqRE6E1m7aPn+N?=
 =?us-ascii?Q?iQCrg8vIY8LXIvV6uaUw1jl0bEgWqDupfDzDv4AmQeHqMnrLdQTPiUOQ72mJ?=
 =?us-ascii?Q?zoA45ocpB98HyMSL7b21+6Q3JTCjMNMwKVeSUN0iqbqD0a0xypxX/1908DCf?=
 =?us-ascii?Q?L/VoNk70asLpYy6VWmv6Vs+MAndr8/Y9DkD+v6lBVcmQXRSMeHNnvqazZh19?=
 =?us-ascii?Q?8YlHc9/XB4jRMyGHmLjArffmAZ68ckLlqT1OBcHt3vPKFosMB5V379WrAF8x?=
 =?us-ascii?Q?yNyBUWjQi4VBH6B4cEOPWku1LkGPNYjiPGqBex4pLrpvTbgsQeK4icptPoRx?=
 =?us-ascii?Q?AVaVxLjsLUa3WTeEE0QwtGvKYwbvGVT3apYp7jMU29K9/Worb8Kx?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: 30f9d5ba-19e3-404c-8ed4-08de68adb319
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Feb 2026 14:07:17.7786
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1dqye8TkOHk6jpCS67og82K36CAbGrMd3c+xgytPI93pLWbLn8CCV2Z2iqA2Ckyx5Z9u21uJyKfungwQy5y8Fw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYTP286MB3915
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[valinux.co.jp,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[valinux.co.jp:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-8876-lists,dmaengine=lfdr.de];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[17];
	FREEMAIL_CC(0.00)[kernel.org,nxp.com,gmail.com,google.com,kudzu.us,vger.kernel.org,lists.linux.dev];
	DKIM_TRACE(0.00)[valinux.co.jp:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[den@valinux.co.jp,dmaengine@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TAGGED_RCPT(0.00)[dmaengine];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[valinux.co.jp:dkim,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: A4C4611BB5F
X-Rspamd-Action: no action

On Tue, Feb 10, 2026 at 01:24:29PM +0100, Niklas Cassel wrote:
> On Mon, Feb 09, 2026 at 09:53:08PM +0900, Koichiro Den wrote:
> > Tested on
> > =========
> > 
> > I tested the embedded (DMA) doorbell fallback path (via pci-epf-test) on
> > R-Car Spider boards:
> > 
> >   $ ./pci_endpoint_test -t DOORBELL_TEST
> >   TAP version 13
> >   1..1
> >   # Starting 1 tests from 1 test cases.
> >   #  RUN           pcie_ep_doorbell.DOORBELL_TEST ...
> >   #            OK  pcie_ep_doorbell.DOORBELL_TEST
> >   ok 1 pcie_ep_doorbell.DOORBELL_TEST
> >   # PASSED: 1 / 1 tests passed.
> >   # Totals: pass:1 fail:0 xfail:0 xpass:0 skip:0 error:0
> > 
> > with the following message observed on the EP side:
> > 
> >   [   80.464653] pci_epf_test pci_epf_test.0: Using embedded (DMA) doorbell fallback
> > 
> > (Note: for the test to pass on R-Car Spider, one of the following was required:
> >  - echo 1048576 > functions/pci_epf_test/func1/pci_epf_test.0/bar2_size
> >  - apply https://lore.kernel.org/all/20251023072217.901888-1-den@valinux.co.jp/)
> 
> I applied this series on top of branch pci/controller/dwc
> on Rock 5B (pcie-dw-rockchip.c).
> 
> On EP side:
> [   39.218533] pci_epf_test pci_epf_test.0: Can't find MSI domain for EPC
> [   39.219125] pci_epf_test pci_epf_test.0: Using embedded (DMA) doorbell fallback
> 
> On RC side:
> #  RUN           pcie_ep_doorbell.DOORBELL_TEST ...
> [   40.297892] pci-endpoint-test 0000:01:00.0: Failed to trigger doorbell in endpoint
> # pci_endpoint_test.c:279:DOORBELL_TEST:Expected 0 (0) == ret (-22)
> # pci_endpoint_test.c:279:DOORBELL_TEST:Test failed for Doorbell
> 
> # DOORBELL_TEST: Test failed
> #          FAIL  pcie_ep_doorbell.DOORBELL_TEST
> not ok 23 pcie_ep_doorbell.DOORBELL_TEST
> 
> Any suggestions?
> 
> (All BARs in pcie-dw-rockchip.c is marked as BAR_RESIZABLE.)

Thank you for testing.

If the failure was observed in a scenario other than a plain
`./pci_endpoint_test -t DOORBELL_TEST`, could you please try again with [1]
applied as well?

[1] https://lore.kernel.org/linux-pci/20260202145407.503348-1-den@valinux.co.jp/

Best regards,
Koichiro

> 
> 
> Kind regards,
> Niklas
> 

