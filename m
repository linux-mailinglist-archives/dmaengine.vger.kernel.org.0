Return-Path: <dmaengine+bounces-8840-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CIrLKcXYiWlUCQAAu9opvQ
	(envelope-from <dmaengine+bounces-8840-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Mon, 09 Feb 2026 13:53:25 +0100
X-Original-To: lists+dmaengine@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CBA210F208
	for <lists+dmaengine@lfdr.de>; Mon, 09 Feb 2026 13:53:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 59669300748D
	for <lists+dmaengine@lfdr.de>; Mon,  9 Feb 2026 12:53:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7120D376483;
	Mon,  9 Feb 2026 12:53:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="WeuOcIe9"
X-Original-To: dmaengine@vger.kernel.org
Received: from OS0P286CU011.outbound.protection.outlook.com (mail-japanwestazon11020117.outbound.protection.outlook.com [52.101.228.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FC93372B5B;
	Mon,  9 Feb 2026 12:53:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.228.117
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770641603; cv=fail; b=sUC6SqYMQ2K/bVxdF24kW4nDsVV6MldspUZd6+5P1K4dv5ZOhMNlU0VvctTgYEoW3XhRL5AVtuNdI9/JLqVU38nTZs3/VpW8Sx06aDSlMam0W8JU6fgYhSbLZJmFfUbXGWyjf0ExL+FwIDeRQL207OYczI95LfwGQPITN9ukKSw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770641603; c=relaxed/simple;
	bh=HD8OBlQWTHnJnIw3Ox7D7No03nJKPfIIqH2+VVElxQ8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Ir5vvdwVJkko1Y1RzeUgNuLc6FISP4JTXm6M4StceR7TAyaelgptN6CgZcLw72Ir1AxIKSPT0Noq0O5x9b9Gay58FqPRyazFpE1ioMyeY86GFm9rSXxveqR94SkNt9qmlsOzaKJnYMHjKzc+HT6RTE0xEa5x+lldS1Yq6bSEP9U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=WeuOcIe9; arc=fail smtp.client-ip=52.101.228.117
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ewsc1e3bXB2UbI/FZpfve+MQkhXau/Yz9lO+NC79Bx0GRoSCQsMRzdLsfICfR7vx4+C2nLBYfvhnIcsZcKUnEDPtp16ieYw3fD6Vykb42yfUyQY/Tc4XLVBV7ZhrvYm0fyb667wJl1AKwXRJusWYt8uyeCD4VwyFQttfb+NNoX3s9gsksav1yB0NDyukJqOxvR2E4uaOEspjZuB13tcQQ4am50iXeHQIngA/ruBVdGl+i/Tou8+cRO9HJoymzdSmgxbDIr6iqzalK6GpogGjOHxGgXT4y2HCkg/Ofn7G6pHgMDvytilJRx+dimulaY3kyVjBo1mu9DW/3UcDwHYAmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4jNiFyiRP84zNAOUDjXThgyDDoZrcJUDqx+fOsLLy9M=;
 b=OSb81HDxrBQSTftkc3aX0xYQ3gew8tr+wowtAl4sq9p/6OCoXDY62dkCnFmMfQ8jzlqtYo/qSDATJDwMD4QNybkb/+PXXkXcbJfeeeBRfrEQvLLiPZQQV7n8nopgbMLneaoVZ7yh1HYqSX2oqHnvlrw7CDK+3RMboYVzRkLL5GPAngtzAfx9NS2zMqUbKDAT60qvBI2jWY0nmh4k4I15yr+qiZu0FrIv/aFt66s8aH/BryGSIrEUWvYc21m6WI2vcWt8P9XrmYnPV/H2IkC4+Sq6BsVRMd9hIbWTHQbO4mzdNL+DqPQly614NIZMmTmn0Qm8AJE4l4x0EetMfBGT2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4jNiFyiRP84zNAOUDjXThgyDDoZrcJUDqx+fOsLLy9M=;
 b=WeuOcIe9O5zmYddSIP8sxytkBEapRVXX9onTDXxkiJpTcAEXGKD6see/mqKJ4Lrdp0WdlMJDCR62Kf4ENk7W+nACWnoxxk5dA/XMSPnK6Y4afWuWLxztJsQp7EGS9adAHEOPyppqC7l8dK+ZF21Lq/Ye2jZrB0QhpPP+fyas1S8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:38f::10)
 by OS7P286MB3742.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:237::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.18; Mon, 9 Feb
 2026 12:53:20 +0000
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32]) by TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32%5]) with mapi id 15.20.9587.017; Mon, 9 Feb 2026
 12:53:20 +0000
From: Koichiro Den <den@valinux.co.jp>
To: vkoul@kernel.org,
	mani@kernel.org,
	Frank.Li@nxp.com,
	cassel@kernel.org,
	jingoohan1@gmail.com,
	lpieralisi@kernel.org,
	kwilczynski@kernel.org,
	robh@kernel.org,
	bhelgaas@google.com,
	kishon@kernel.org,
	jdmason@kudzu.us,
	allenbh@gmail.com
Cc: dmaengine@vger.kernel.org,
	linux-pci@vger.kernel.org,
	ntb@lists.linux.dev,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v6 2/8] dmaengine: dw-edma: Cache per-channel IRQ and emulation doorbell offset
Date: Mon,  9 Feb 2026 21:53:10 +0900
Message-ID: <20260209125316.2132589-3-den@valinux.co.jp>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260209125316.2132589-1-den@valinux.co.jp>
References: <20260209125316.2132589-1-den@valinux.co.jp>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCP286CA0347.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:7c::7) To TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:38f::10)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY7P286MB7722:EE_|OS7P286MB3742:EE_
X-MS-Office365-Filtering-Correlation-Id: 5c959ed9-cdd8-411e-aefa-08de67da33f8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|10070799003|376014|7416014|366016|1800799024|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?fxy6ltLJugPSOLasYivETk82KHDwHDRr5kaPYPAyTB7dsZlIqW3HXQiDZsE6?=
 =?us-ascii?Q?jv3LHA34/caT5cV2W44wKQDz/zlgqJM8JQLj7tTehJP0fD4We00MQPwvdmJF?=
 =?us-ascii?Q?prVNFQOnsif+JlxEbFx3tjbvU5gJ8ADlRJIwBIjiVTI2QZBn+myUVyX71kAp?=
 =?us-ascii?Q?NauoAZwWKDMlBFrR4eALUCb7kawbpazdNg1Y2talj1lGmQhfDOJ+4EMWgtxx?=
 =?us-ascii?Q?JnF98KZYGhy0T0APUgw5nt2SDNGd0QkhLRzMuckFxM9mCLjuQyJVRNltBvUo?=
 =?us-ascii?Q?60LoqGtlx9UHKmt2CftQof9/inolbVDOMRg4Z623S8b2bzBTNgSp+F0+bAB6?=
 =?us-ascii?Q?hAhKEEp8CHV1w85EJ+zkHbNiB3pear41owYSvvU6uJrL3U4eA6HcwQ8roVV+?=
 =?us-ascii?Q?nikGrDZO5eguOi3MC6x+Ja2Ceyt25MwRl2JmLb45rmxhF0ofwDPjMY2h7xyX?=
 =?us-ascii?Q?b98io+VJdGvdzi0esOWKidy18fQNTGUNP8iCyUqBC2TN5mMGqvyLknon7JYI?=
 =?us-ascii?Q?x/VZPXpVEoT7KC3KZgp8sMH1YiQ1taNE1c1/FPzbLInOMc+VJKE3m5lDJrL7?=
 =?us-ascii?Q?rUPo6expMJZ+dokM1soDNnCNWa1RmS191j2DMLiSU6us2qclkxqH/THZscSQ?=
 =?us-ascii?Q?krHpvokq0w+6KcxJop3PhhQPem8oAllkf+21pSHTKi5Fdh8LjTfGryOZiv4h?=
 =?us-ascii?Q?J+cGOxSbE9Fvcfo0Sp5xvt2WG+pH0QYP/zu0E4GNpqcsMFQoDj5qDcsKPwW5?=
 =?us-ascii?Q?8zZSODhMoQ8oy2gur5/yrSZPDYyJkt4AT6QLGQ8wOn9Up6c8DYIvXnDDVZ+F?=
 =?us-ascii?Q?YIsmM4DbAJ+QZm8k77LUc5Cx/K5fbSj1OYZNrKZqwiGMGrE4DsDKMt28jjGC?=
 =?us-ascii?Q?OSo5y20ZTMZusiR1W4AH/QSP802Cd7Y2d1m+8cqqQQz8thZy6lDcu3QDsnWW?=
 =?us-ascii?Q?9TZSzTdHuHmq4eVT1w0lx4B8A/C7utJIrRvTrQFCEADh+wQ7MWDd5o+6L8bd?=
 =?us-ascii?Q?yJzdrapYDqK115BUZ4s+mnP4PCreiq33Ys8Hi1uKEnCua6NtYhh7OY3lBNer?=
 =?us-ascii?Q?fMLiz10MHATLoXSfM1NAzNZ3w5my24DAhJFrO6OoD39nx8eLqzRo6iDF8XOQ?=
 =?us-ascii?Q?Oib/6PRbgYBd80cYEp58JXDRfhwVbrVYEF9BwudTVNgVWjrhrOi7RgkBiQp2?=
 =?us-ascii?Q?zodq1iJO9EKbmAOjuYQopmPj2Q20RAp0J8Nqj0FbeXKp6oJVlXxFusfhbLsS?=
 =?us-ascii?Q?RsMLujz5E8Ouw6zxPdRhOZO08zbbtTO32y4wTWm2OxPkNY8tbsWyZbTDF9fz?=
 =?us-ascii?Q?z4q5KP4Q8GUs7sQWMyP2YR7OFOtVGHMN8MoGDAtwVTdnaXdkgxtTV1SKvHvX?=
 =?us-ascii?Q?ubBVne+YX86F+ggUgpoMi+DaGqc3wSZo7rNOSK6yJCLBkRViFPTXbR9Spb1Y?=
 =?us-ascii?Q?cASLwZNpeKZMzv/xZlU4CVMLpVi/8LXWSRHdQmIL4az818LwTjN64rpuoRAy?=
 =?us-ascii?Q?bJEwlZ4Xz8yA/1V67W0hgRurbE2KoTGf76t6kJJab8Z1e++MGmJpFv7mDxsj?=
 =?us-ascii?Q?WzunmiEX2iIKUfIkDnlEovHThqKclTeIIcIFM1KObVdX18LTRRGPBi1nPxe0?=
 =?us-ascii?Q?mA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(376014)(7416014)(366016)(1800799024)(921020);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?EQEHYTOBp3yjIGkIWAzzaHgzN0feVOXPJLjMHaR1RvvCsnMcxgQ0kfOVaEtR?=
 =?us-ascii?Q?N3BYljmNdC9JGjmhUJ3gbEXwOIUK7Wg3sPDhx6c71bQEnjWA0sAbbV6sA9RX?=
 =?us-ascii?Q?vE8MQxvgEj2pA0sSTsZV72Xn1yVpfP1VUH9W81rZG3frzgh0BLZdwOAbDGRH?=
 =?us-ascii?Q?iv2bb33lzjL5ZR7yg4JNaGs0qlQ6fmrzzirwhBkRZqDrhq1M7k6EzH/eG23w?=
 =?us-ascii?Q?NJobvilA1g/gcsh0CgMLqqeBiWTrpKUdN3UV9nOxLaQHLM/o7h+xxxOQK6aD?=
 =?us-ascii?Q?+1R8ooNYpPiBdoNVc6VXcR4mIWD8G4TY6lAeVVKJvJ6NCSZDc2AYHPerh3TH?=
 =?us-ascii?Q?WH4+rAMVY1Vye4F/GUPTWNXrkBjV6QeRD3oJxYqLtjq3CkDCtp+ufOpwHN1Y?=
 =?us-ascii?Q?06sth8C0bl+3Ks/uqpHVY9lYbjQJxBdagUmkwF6tNAcb2EqUZUS7njuNjNyH?=
 =?us-ascii?Q?Ae4wIkv4ylwtJvLjkHe+Hj4kQJ73Gzm92KtGfssjwqToRyfGl8deTVDgpxY6?=
 =?us-ascii?Q?EF2qAR47hrfvlc/cCJjBa7jK+SiQbor7YnuQQVZA0/nUYhAm26VTM8Vz5mH4?=
 =?us-ascii?Q?PsiCtORhUtos2Z5Qa8Zj7QsKtmkvVnL579pqiCKhVlJAuk8bSFOuZNz3uh3N?=
 =?us-ascii?Q?SruOadTdGccgIWypWh25AYZr+5sawjIMwdVVnFcthAzHcO1XGdRfuL3u/tUl?=
 =?us-ascii?Q?dVFV90968DQlWDjeFrgBF6FWgaGt3bguno8ujtK++xmj4wIlSA/1/tnIA/oj?=
 =?us-ascii?Q?06mB9TR63vQAoU7rSZ9PmIhJjLddnp1QEqAly6Hyhou0px+EwG1THNO23kgZ?=
 =?us-ascii?Q?49EQZpwXKDmDuZX0v3BQOWd+523xF6IlUY4CKGc3wJClmXTmLZEkd3Jd9TPL?=
 =?us-ascii?Q?xuIRtjPFWDqEmpNoG34z+qUyinX1/s6kgPll20J1mMVrPUIE8f4mZqAIbDg+?=
 =?us-ascii?Q?phEv3X49h1vFF5mexrsN09BEKzFwF6qClJTLlSKU3R7Jehq3rzRS+ik+2qsk?=
 =?us-ascii?Q?R9WsWB94usWWVgIV0Zp/wn5WLkqBDHbGR36XjTBjY1iC/Z7H8PIDjJ2doc6J?=
 =?us-ascii?Q?Hy8oCEzH2unpMYFJ1kEKfZsS4shN4Ce51npqmkg0zy3m5NntESA6YTOIMuJo?=
 =?us-ascii?Q?xGu9A5tQGOLK/WEKlly5uFZomZPy2kkRarZqj8f6dIp1jYurArrSuRYU15OB?=
 =?us-ascii?Q?Sg6scTMHCi/tEns8TfLXNBa6d2jls4OnX3s/Q7eyKN+er68kGV7Pe0MmpNnO?=
 =?us-ascii?Q?Q8y1xCq0LCrjp8Hdg84VBvxLfrxAOvkj/9VfUpcgi9XiDTGWvHN5rx/SLeaT?=
 =?us-ascii?Q?y3UjcB/3+ljok+WOgVDciiH+xUq48bmUetJCp9qPKGm6A9SWw7pJGBIT2iZS?=
 =?us-ascii?Q?M/g4OX7BPfvIe1f9hD3aS2UiPEO+Te9xTfL379zTTNbj+7ekajzJ329pH34w?=
 =?us-ascii?Q?VgbSFEFat0G+nlIjqhUcHEjGxR5yIrHaBX8x1fUB1jfme17chw7w3pggI+PD?=
 =?us-ascii?Q?sKZlYszKq+OiAZL5Cxw7fyGSe+Vffl4Lz9GU1Mc+zOIryq7qSRrwSS8sX2CQ?=
 =?us-ascii?Q?IyhZL0lvBmeQGpRAYamDQy0vdDettkcpleyJLRcB/NV40359U5+hq/aOrw0U?=
 =?us-ascii?Q?Z7Xzo7RZQw+UTl0i0x/5watNKKMljbnyLGK2KHtUMmUgeOvVRyCU7Dvl06Gr?=
 =?us-ascii?Q?p2duNb0zkjCPFhIrqI4cTDUSijEH7N6xVb9zlmeHpxchZEYi1GimKbOU0yqj?=
 =?us-ascii?Q?mNKP30MH+1wndDOMWB0EirE4PFLam99zyjHa2QppbbLHg2xr/cOC?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: 5c959ed9-cdd8-411e-aefa-08de67da33f8
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Feb 2026 12:53:20.6093
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vQsn8Ttcw8rOGCWxthwyGjuAgQJHHme4HhqfLHMWgRYDAATDL8FjLkheyUKdBe3zJV5Kf44EkPIanom4TRTmlA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS7P286MB3742
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[valinux.co.jp,none];
	R_DKIM_ALLOW(-0.20)[valinux.co.jp:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-8840-lists,dmaengine=lfdr.de];
	FREEMAIL_TO(0.00)[kernel.org,nxp.com,gmail.com,google.com,kudzu.us];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[17];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[den@valinux.co.jp,dmaengine@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[valinux.co.jp:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[dmaengine];
	TO_DN_NONE(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 2CBA210F208
X-Rspamd-Action: no action

Some DesignWare PCIe endpoint controllers integrate a DesignWare
eDMA/HDMA instance. In remote eDMA use cases (e.g. exposing the eDMA
MMIO window and per-channel linked-list regions to a peer via BARs),
consumers need a stable way to discover:
  - the Linux IRQ number associated with a given channel's interrupt
    vector,
  - an offset within the eDMA register window that can be used as an
    interrupt-emulation doorbell for that channel.

Store the requested Linux IRQ number in struct dw_edma_irq at IRQ
request time and cache per-channel metadata in struct dw_edma_chip
(ch_info_wr/rd) during channel setup. Add a core callback, .ch_info(),
to fill core-specific metadata such as the doorbell register offset;
implement it for the v0 eDMA core (use rd_int_status as a suitable
doorbell target) and provide a placeholder for HDMA until the correct
offset is known.

No functional change for normal DMA operation. This only makes the
metadata available to controller/platform drivers that need to expose or
consume eDMA-related resources.

Signed-off-by: Koichiro Den <den@valinux.co.jp>
---
 drivers/dma/dw-edma/dw-edma-core.c    |  9 +++++++++
 drivers/dma/dw-edma/dw-edma-core.h    |  9 +++++++++
 drivers/dma/dw-edma/dw-edma-v0-core.c | 11 +++++++++++
 drivers/dma/dw-edma/dw-hdma-v0-core.c |  8 ++++++++
 include/linux/dma/edma.h              | 17 +++++++++++++++++
 5 files changed, 54 insertions(+)

diff --git a/drivers/dma/dw-edma/dw-edma-core.c b/drivers/dma/dw-edma/dw-edma-core.c
index fe131abf1ca3..bd5ff4a4431a 100644
--- a/drivers/dma/dw-edma/dw-edma-core.c
+++ b/drivers/dma/dw-edma/dw-edma-core.c
@@ -760,6 +760,7 @@ static int dw_edma_channel_setup(struct dw_edma *dw, u32 wr_alloc, u32 rd_alloc)
 {
 	struct dw_edma_chip *chip = dw->chip;
 	struct device *dev = chip->dev;
+	struct dw_edma_ch_info *info;
 	struct dw_edma_chan *chan;
 	struct dw_edma_irq *irq;
 	struct dma_device *dma;
@@ -779,9 +780,11 @@ static int dw_edma_channel_setup(struct dw_edma *dw, u32 wr_alloc, u32 rd_alloc)
 		if (i < dw->wr_ch_cnt) {
 			chan->id = i;
 			chan->dir = EDMA_DIR_WRITE;
+			info = &chip->ch_info_wr[chan->id];
 		} else {
 			chan->id = i - dw->wr_ch_cnt;
 			chan->dir = EDMA_DIR_READ;
+			info = &chip->ch_info_rd[chan->id];
 		}
 
 		chan->configured = false;
@@ -807,6 +810,10 @@ static int dw_edma_channel_setup(struct dw_edma *dw, u32 wr_alloc, u32 rd_alloc)
 
 		irq = &dw->irq[pos];
 
+		/* cache channel-specific info */
+		dw_edma_core_ch_info(dw, chan, info);
+		info->irq = irq->irq;
+
 		if (chan->dir == EDMA_DIR_WRITE)
 			irq->wr_mask |= BIT(chan->id);
 		else
@@ -910,6 +917,7 @@ static int dw_edma_irq_request(struct dw_edma *dw,
 		if (irq_get_msi_desc(irq))
 			get_cached_msi_msg(irq, &dw->irq[0].msi);
 
+		dw->irq[0].irq = irq;
 		dw->nr_irqs = 1;
 	} else {
 		/* Distribute IRQs equally among all channels */
@@ -936,6 +944,7 @@ static int dw_edma_irq_request(struct dw_edma *dw,
 
 			if (irq_get_msi_desc(irq))
 				get_cached_msi_msg(irq, &dw->irq[i].msi);
+			dw->irq[i].irq = irq;
 		}
 
 		dw->nr_irqs = i;
diff --git a/drivers/dma/dw-edma/dw-edma-core.h b/drivers/dma/dw-edma/dw-edma-core.h
index 50b87b63b581..82f8f3b38752 100644
--- a/drivers/dma/dw-edma/dw-edma-core.h
+++ b/drivers/dma/dw-edma/dw-edma-core.h
@@ -93,6 +93,7 @@ struct dw_edma_irq {
 	u32				wr_mask;
 	u32				rd_mask;
 	struct dw_edma			*dw;
+	int				irq;
 };
 
 struct dw_edma {
@@ -127,6 +128,7 @@ struct dw_edma_core_ops {
 	void (*ch_config)(struct dw_edma_chan *chan);
 	void (*debugfs_on)(struct dw_edma *dw);
 	void (*ack_emulated_irq)(struct dw_edma *dw);
+	void (*ch_info)(struct dw_edma_chan *chan, struct dw_edma_ch_info *info);
 };
 
 struct dw_edma_sg {
@@ -216,4 +218,11 @@ static inline int dw_edma_core_ack_emulated_irq(struct dw_edma *dw)
 	return 0;
 }
 
+static inline void
+dw_edma_core_ch_info(struct dw_edma *dw, struct dw_edma_chan *chan,
+		     struct dw_edma_ch_info *info)
+{
+	dw->core->ch_info(chan, info);
+}
+
 #endif /* _DW_EDMA_CORE_H */
diff --git a/drivers/dma/dw-edma/dw-edma-v0-core.c b/drivers/dma/dw-edma/dw-edma-v0-core.c
index 82b9c063c10f..0b8d4b6a5e26 100644
--- a/drivers/dma/dw-edma/dw-edma-v0-core.c
+++ b/drivers/dma/dw-edma/dw-edma-v0-core.c
@@ -519,6 +519,16 @@ static void dw_edma_v0_core_ack_emulated_irq(struct dw_edma *dw)
 	SET_BOTH_32(dw, int_clear, 0);
 }
 
+static void dw_edma_v0_core_ch_info(struct dw_edma_chan *chan,
+				    struct dw_edma_ch_info *info)
+{
+	/*
+	 * rd_int_status is chosen arbitrarily, but wr_int_status would be
+	 * equally suitable.
+	 */
+	info->db_offset = offsetof(struct dw_edma_v0_regs, rd_int_status);
+}
+
 static const struct dw_edma_core_ops dw_edma_v0_core = {
 	.off = dw_edma_v0_core_off,
 	.ch_count = dw_edma_v0_core_ch_count,
@@ -528,6 +538,7 @@ static const struct dw_edma_core_ops dw_edma_v0_core = {
 	.ch_config = dw_edma_v0_core_ch_config,
 	.debugfs_on = dw_edma_v0_core_debugfs_on,
 	.ack_emulated_irq = dw_edma_v0_core_ack_emulated_irq,
+	.ch_info = dw_edma_v0_core_ch_info,
 };
 
 void dw_edma_v0_core_register(struct dw_edma *dw)
diff --git a/drivers/dma/dw-edma/dw-hdma-v0-core.c b/drivers/dma/dw-edma/dw-hdma-v0-core.c
index e3f8db4fe909..1076b394c45f 100644
--- a/drivers/dma/dw-edma/dw-hdma-v0-core.c
+++ b/drivers/dma/dw-edma/dw-hdma-v0-core.c
@@ -283,6 +283,13 @@ static void dw_hdma_v0_core_debugfs_on(struct dw_edma *dw)
 	dw_hdma_v0_debugfs_on(dw);
 }
 
+static void dw_hdma_v0_core_ch_info(struct dw_edma_chan *chan,
+				    struct dw_edma_ch_info *info)
+{
+	/* Implement once the correct offset is known. */
+	info->db_offset = ~0;
+}
+
 static const struct dw_edma_core_ops dw_hdma_v0_core = {
 	.off = dw_hdma_v0_core_off,
 	.ch_count = dw_hdma_v0_core_ch_count,
@@ -291,6 +298,7 @@ static const struct dw_edma_core_ops dw_hdma_v0_core = {
 	.start = dw_hdma_v0_core_start,
 	.ch_config = dw_hdma_v0_core_ch_config,
 	.debugfs_on = dw_hdma_v0_core_debugfs_on,
+	.ch_info = dw_hdma_v0_core_ch_info,
 };
 
 void dw_hdma_v0_core_register(struct dw_edma *dw)
diff --git a/include/linux/dma/edma.h b/include/linux/dma/edma.h
index 3080747689f6..921250204a08 100644
--- a/include/linux/dma/edma.h
+++ b/include/linux/dma/edma.h
@@ -60,6 +60,19 @@ enum dw_edma_chip_flags {
 	DW_EDMA_CHIP_LOCAL	= BIT(0),
 };
 
+/**
+ * struct dw_edma_ch_info - DW eDMA channel metadata
+ * @irq:	Linux IRQ number used by this channel's interrupt vector
+ * @db_offset:	offset within the eDMA register window that can be used as
+ *		an interrupt-emulation doorbell for this channel
+ */
+struct dw_edma_ch_info {
+	int			irq;
+
+	/* Fields below are filled in by dw_edma_core_ops->ch_info() */
+	resource_size_t		db_offset;
+};
+
 /**
  * struct dw_edma_chip - representation of DesignWare eDMA controller hardware
  * @dev:		 struct device of the eDMA controller
@@ -96,6 +109,10 @@ struct dw_edma_chip {
 	struct dw_edma_region	dt_region_wr[EDMA_MAX_WR_CH];
 	struct dw_edma_region	dt_region_rd[EDMA_MAX_RD_CH];
 
+	/* cached channel info */
+	struct dw_edma_ch_info	ch_info_wr[EDMA_MAX_WR_CH];
+	struct dw_edma_ch_info	ch_info_rd[EDMA_MAX_RD_CH];
+
 	enum dw_edma_map_format	mf;
 
 	struct dw_edma		*dw;
-- 
2.51.0


