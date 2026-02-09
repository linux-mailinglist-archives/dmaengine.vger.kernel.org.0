Return-Path: <dmaengine+bounces-8830-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SKIAEAJ/iWl2+AQAu9opvQ
	(envelope-from <dmaengine+bounces-8830-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Mon, 09 Feb 2026 07:30:26 +0100
X-Original-To: lists+dmaengine@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DCF0310C0ED
	for <lists+dmaengine@lfdr.de>; Mon, 09 Feb 2026 07:30:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 76468300AED2
	for <lists+dmaengine@lfdr.de>; Mon,  9 Feb 2026 06:30:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 122AA322C77;
	Mon,  9 Feb 2026 06:30:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="OmO+UQ3m"
X-Original-To: dmaengine@vger.kernel.org
Received: from OS0P286CU010.outbound.protection.outlook.com (mail-japanwestazon11021104.outbound.protection.outlook.com [40.107.74.104])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A203C31A56B;
	Mon,  9 Feb 2026 06:30:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.74.104
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770618604; cv=fail; b=XzTmdputVTPj1NiFNZtz9Q4lHdIFGyK6icylVnHK2p3g5phJ6FxokJZeJC3cPC4T1KGVR0gh9r/8yS1FN5dXtLB+sUEUl48xELoNYhNLazpq8KDYTxxk+U8jRtSt+20hXItrmfr5nNRQWm0C6q8jgSwe91AanpMnkV6pgXiO0gQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770618604; c=relaxed/simple;
	bh=m7gNzrd3xshvHeDWmQT6H7u+Yg0bDwxNQTJuH0FSzNw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=HYlWXidcFB8+XhOYUmkehzal89kF9QsFN0z3xUIflDWVJbeSvvaavHikFtOzcvzj2EqxOwnemvXHetqD/6jhUX1rqED+4euoW5kwCIzug9cAB2Q8RNvSgsvdXIuh/wuavg0u8iQW2T05ywccOt391mMqwyW3/tdIdPAL+AF9NfU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=OmO+UQ3m; arc=fail smtp.client-ip=40.107.74.104
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=K8QiB1aaKqjWBMHqmoRk8e4OSqp0md0Yc9hErt0ENdVbHBgAAHI+biOV1ystOcjNJeXCmUJOMRf2PSlp8+8TfKI9cVaX4nQE05BVnCG/WKnbzBQ0JiDNfPDtgY6deriYyFcfhWfr7pmQbTxY6Z/pPZL/sLoyJNiHFriLE20N7xkvXMykTE1ehjV7s0TmjA4Mu3Om8xDctPV7+Qh33b3i4WO4zhTrKLm7IwR2+Yq2mCSeBM6ym0VU5a1yHjObU4L2XS9eNbENj1pHKw1/W/dUfWZmIHOD/vhA8eBmKMvyuOKSMknxv/tFJR9pyx+j1+AahjNEOJT4g0BOi5w33AFGPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZxG6ojMrkmLKQRceuNfassnYLg0CvoRYtyz0JIbPhgM=;
 b=dOWP44EQ6HFGfb5EicXcgDEVabO6RLYt1SJweyu9//ii53MbnE2vSe1XvADcdskXb0Zq1V9j9HzeYcQI2ZrUbYPNQ3faP5TjWaBDPwR4T8hP8hozVwej/yYlr+6usofOIVl+GSvGJadLsf4+t4MUGXFZpO5yP4TDFQgQeSWzJepG1I+Uu570i+G7nJJ+jyK5v4K7ydiFP2M5Bnqd4Sd00SYKzkVdHfNkTJSK+roFW7gYbC6RapGvnjqQPnLHpJqIPiARGxS2af5xh7nsf59eICOKVuilm93vIowTr5ga6LuJvs9l/zh/Vjc/qF0V4vYidsC7KbhGZOn2aok1+1EZGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZxG6ojMrkmLKQRceuNfassnYLg0CvoRYtyz0JIbPhgM=;
 b=OmO+UQ3mH5m2qcpAXol1PK7jPgJW53Bv7Uxp/yhiCmtxYO8LGnqVSpIkdvET5Ns6sCsULWuF9wRqKWuIKJ+FIYDerKuavOgBAzgARVXp0zGMvz5ZJ4dcYNa7UN4K9ok2RV1R+3VGVCyIt3AiIDRxAt9WOHcfP34/jzlEWgelrEQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:38f::10)
 by TYYP286MB4425.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:10b::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.17; Mon, 9 Feb
 2026 06:30:03 +0000
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32]) by TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32%5]) with mapi id 15.20.9587.017; Mon, 9 Feb 2026
 06:30:03 +0000
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
Subject: [PATCH v5 5/8] PCI: dwc: ep: Report integrated eDMA resources via EPC aux-resource API
Date: Mon,  9 Feb 2026 15:29:48 +0900
Message-ID: <20260209062952.2049053-6-den@valinux.co.jp>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260209062952.2049053-1-den@valinux.co.jp>
References: <20260209062952.2049053-1-den@valinux.co.jp>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCP286CA0070.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:31a::14) To TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:38f::10)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY7P286MB7722:EE_|TYYP286MB4425:EE_
X-MS-Office365-Filtering-Correlation-Id: 8bb6b9a4-ef02-41fa-e220-08de67a4a87f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|366016|1800799024|10070799003|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?p3o4vUo8OHFvVpIT58ISiw4P7A2sEnDhzC3z6aS0bXWZzAy1Ecfp3y+xZipP?=
 =?us-ascii?Q?Ve0qwKcc+SNxVblg3cewNUto3G9VauiPLKbw0a0aHcWoaQhQ850j4ziRxfDT?=
 =?us-ascii?Q?/xgM6OonlNrAV1PX63BYVNyZJN9B07QFftdn7nGBzrBKuAepPR1JbG2Tgoh7?=
 =?us-ascii?Q?PFl/ES9GuDx6/Cjj60XWB2AIH8FaklwtWSu6caiIuHqFwdO/RbO0DcbFX8ZA?=
 =?us-ascii?Q?inu0jzWZ47fDObvaW7VihjrvbU59VGUyJf2gqtRNF9MOTH5fjaQDw0wny+H6?=
 =?us-ascii?Q?klopvrLhpNztXvqosM1SxBjUwlUkzxmKFvr3Fx2d8LJMd26hFoD3OWAHgpu8?=
 =?us-ascii?Q?93OHcXFxcixBW2XLoQn1lYwvq0tIW6CirR7j2hgQ0VOVBnTAda1kCowfM4DX?=
 =?us-ascii?Q?teBgiVWb+xNpko3jIYQSo+ZnL+jwSzJTQGpcs6FiHW4C6nWqIuZzmXpfeUKu?=
 =?us-ascii?Q?hDmD7ijR9YEYUytu9J1pZUNtRQYvjzPCvKxO9Uyi6+/ma0VzZGbi7SyPX8n5?=
 =?us-ascii?Q?gqs/UIg/yklpaC/PE4Y2ymP+RcolJIwPEiazbbE7O6T4YLT+/0RkNflcyLRp?=
 =?us-ascii?Q?Mg2lXCQ9hHhaCs64kMF/f1aGvYFuW47JzRvl7PcDYy2CAnnyM1t/hMS2kBWJ?=
 =?us-ascii?Q?GNbYg8PpBZJvmwN/+9ZzQwMZf6lxjNp4dUg+9mkJa4qHDOz+tgVehNfTICE3?=
 =?us-ascii?Q?xWoY4olYEEN2Z9KrZ6KQVQaITCzAZ+eDzk9X0D/x2KH7P2xZgfrr9i3fGkMr?=
 =?us-ascii?Q?PR45CyA784roSVEKxRHGBTbZroAKREH8OdzcPk0HdHQdiFfNBn4UpQQbiyxh?=
 =?us-ascii?Q?NNU3PfhBwr2T7fjuTrFvOrfEZrsrxfp+C28PbhYrCvQWA5hG/ROciJGbWHcu?=
 =?us-ascii?Q?pZf4SESFYcJIYDF3HPHALs/9mddvpojYspYFuaNBDdW+DGnj/K32Sjl9+cnv?=
 =?us-ascii?Q?Df+I8KbTS4ee8laAvSChN0ljlNVrxAndlHMxJHelzsLGvzezdTRhSdykU6ZT?=
 =?us-ascii?Q?FAOhAnXo0+4TVPMWjrWNSG0z+NEY9JI97o20c+4TKZfqd9xbd3RZQ4zBKV88?=
 =?us-ascii?Q?bH1OmDsYhwathbLjTm/4lf7vAqDLcdwgj3K5OsxdsiIQ4Sds6fQBR1apn0dr?=
 =?us-ascii?Q?GWp3Ie7Fk0rPcYHmPBljpWSjFF4ZnkKtMNrttFGu0R8mwxaU1GsnLE07aLY2?=
 =?us-ascii?Q?1zUG4JlcR8ffG9lT2Md5fR3b8BLxTzvgI/O4FLw/eG3V3bG1UZHpWWrlLn3N?=
 =?us-ascii?Q?I1eGmQml+cJ0ZFr4CmueixR5UUBZE0D4TPfFCGRje7Yt080qtkDCpI5VVaDG?=
 =?us-ascii?Q?ecn1PippztGpMcMrsdyoPNFispy0kEhJNjWJDjx/NaGXQVqg/768A0bhDnbS?=
 =?us-ascii?Q?0wJ9uU7SSVQJQhPTQsXJgotkJRRckUgbiPkMWftXB6vE4RK+1UpnV/Jts9cI?=
 =?us-ascii?Q?8lTj2CB3mpug2KuRryR9IavuaLRfXeYFwW+Um5YiGVYzyffmUIJaJDVSsX0+?=
 =?us-ascii?Q?Q/4pkLNeuzxf//6P5tAV5mqThMFX9mVYgGBggRRC8K80orLF/YtS6NYHhdYr?=
 =?us-ascii?Q?Q4+ZzgNvktHmX94W8wTWZL2anJK9Suht0S09qOnHiDNUTuzSUlGo1F91xNgA?=
 =?us-ascii?Q?6Q=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(10070799003)(921020);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?4C2RSfIkQRzY1wHRlzMl9yt4FxicYXPGrNXFWW3LyfHMHECZPnj/bN2GaNA/?=
 =?us-ascii?Q?OwwKl9D5Vg/4/uGEgLpRYemsg4ZR9//dytcLIWc2LC9nmv6HQL/0M9oGQZC0?=
 =?us-ascii?Q?/kEMfPcA/2xD2LN2HKSaJ6PoDosATWPebkkZQYu5nTdzxWD4U9VMp1++Bmka?=
 =?us-ascii?Q?u9mqTLC8q/wqOC7A7TEZitrfGAGuMAch2lLIEqQEmgQJYQexGx/7x3y1bsi3?=
 =?us-ascii?Q?Q0tVtK7w2P2wGMag2qtew727RYqM7RkmwXXNUd8/u/xZQ5eg0+x0qytLE+Yd?=
 =?us-ascii?Q?QwAWXzexz9WxWHslYoCgQpfk0SpgwAbgNrxX7tL4HjykIRuwwKiQafTq/d+h?=
 =?us-ascii?Q?gyaRHbjJh4Y83hlQVYOpq1M2GeFtyEbYSU4jzXmAHpxk/xfO1aTFmo/zj1be?=
 =?us-ascii?Q?eX46q2t9RS6Vi92jmvqNRGVVXEkISk6AMyNf6zy7YEVDPo8VHgN8yX0iTSvs?=
 =?us-ascii?Q?a/8wAB60t1POYTHJeHNSkawbf792Msf6VysMT+f0iLnavLtxoZueNhe1HOFE?=
 =?us-ascii?Q?nt2BTCVdeWVGNXFD1s5ujdRDQ3V3zl80d0BUlDakP+wERHdW3blbOqLVqMDB?=
 =?us-ascii?Q?y8i8rF52h4gFjaBvlFptLvTDnCHZ9Ccn2KBuiH2UtYMFls6DSRrhj4Xg1Z/z?=
 =?us-ascii?Q?SDOqL6TNkOC3Pfv4LuATjjSw49p/v2goeDoN+4ALO1WMIFMyrs2i2j7j+lEX?=
 =?us-ascii?Q?KkurPI3Wni051Sg5HjpnYByVw5emlGYe48nWtSXzqr1aBWmlj1AExL/AOlwL?=
 =?us-ascii?Q?r9Rc3pSnQjojxX5WGHSCvh/80GjNdH4NpOp/MnKtbYWeAP+4oWMevJIli4l0?=
 =?us-ascii?Q?dWP2YsIl3wCULH11L5bLMomSKbi+BMHNgo31wFGc67fAO+KQ0L1mivqNrYnC?=
 =?us-ascii?Q?CvTfvegDloBSHeYLS9LfkRTv0I07Mf77mckFBwZlNeZ1ePeTbHYqXwPrAp6h?=
 =?us-ascii?Q?9O54Mxop1FcNPyQK3KIuG0Rombqw/G7M3Esr7x0l2xO3veyZ5CZyaZRdKhSc?=
 =?us-ascii?Q?xtan3CSMrct8YY9/WZdITUd5XzWj07hl10WmdD4FeYV/otPYQcPKrabUZ44X?=
 =?us-ascii?Q?0FQ8bHb3noNnxgy1CsVcdjo0AItcdkZkZE9e25nw/xzQlbaZv+pqa6lFY1nv?=
 =?us-ascii?Q?o92cEjFB5YDMn+d3tCdT0OnA/ctIo8hcBVJBauJyaddBXWmboeBAxU5mD7UL?=
 =?us-ascii?Q?SKoVWDUqzOGjj3VPcfXygHyYMzuqbJ58MluJCbp/RedtbL4gXBs3ShW6jcJ3?=
 =?us-ascii?Q?Mp693cyciB/GCXIexjLyG7XriL6SdpQNx8gUVqDamNOBFLcDxXjpBkq5eR/M?=
 =?us-ascii?Q?DkcrKpyWtxygKuxDkQCO3uP2WeVr4xHF3gXtl5pSpQ10tSnVIJqbqRAs5Yw8?=
 =?us-ascii?Q?EBLE6B5jBC4YUtYkbfZz6bZwTd3U5PV2ZZPKHgymZWSd+pGlC9AqjCR7ClXC?=
 =?us-ascii?Q?pZJWfoQhKs6lKN1tB3vuDb17lQAe5OwAchXmKwiOQVOf8zNXEVYUm38IJGNj?=
 =?us-ascii?Q?knDNFrxyuBQaAIp+Jf99W4cH3JZyKDnmD43TNe1qvifQO3A59JwNbbSAHC3b?=
 =?us-ascii?Q?006krHATvZz0Pu6AjhxjYlVCLPqGcIKfmvcDmh6P2BOtjENiK+Nq9jfHz//5?=
 =?us-ascii?Q?ZXkHuXBVIadrnu5ZNXSeIESl1qPcd+ckQ+9PiVRfN+Mji0Gblk53SbkGn52t?=
 =?us-ascii?Q?iGz8oy9xIdFyIFzWFKk4in5EOqEOjifdI6QKe5Raoo8VHCJBfGslsw9yEzAA?=
 =?us-ascii?Q?K6edUqs7R6kGkG2F9dp1X7wsFzv8pSPjYHJdK4fPT6fJWBtmpsiJ?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: 8bb6b9a4-ef02-41fa-e220-08de67a4a87f
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Feb 2026 06:30:03.2922
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VrLk5HAtkvUAycRRSQgzuK7zfebcGY5Z/BF5v7M5OL30iMAsp66Fa+dMwugfUJODrLl5Kpbgvldo5ybUOiaRbQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYYP286MB4425
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[valinux.co.jp,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[valinux.co.jp:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-8830-lists,dmaengine=lfdr.de];
	FREEMAIL_TO(0.00)[kernel.org,nxp.com,gmail.com,google.com,kudzu.us];
	DKIM_TRACE(0.00)[valinux.co.jp:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCPT_COUNT_TWELVE(0.00)[17];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[den@valinux.co.jp,dmaengine@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	NEURAL_HAM(-0.00)[-0.998];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[dmaengine];
	DBL_BLOCKED_OPENRESOLVER(0.00)[valinux.co.jp:email,valinux.co.jp:dkim,valinux.co.jp:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: DCF0310C0ED
X-Rspamd-Action: no action

Implement pci_epc_ops.get_aux_resources() for DesignWare PCIe endpoint
controllers with integrated eDMA.

Report:
  - the eDMA controller MMIO window (physical base + size),
  - each non-empty per-channel linked-list region, along with
    per-channel metadata such as the Linux IRQ number and the
    interrupt-emulation doorbell register offset.

This allows endpoint function drivers (e.g. pci-epf-test) to discover
the eDMA resources and map a suitable doorbell target into BAR space.

Signed-off-by: Koichiro Den <den@valinux.co.jp>
---
 .../pci/controller/dwc/pcie-designware-ep.c   | 78 +++++++++++++++++++
 1 file changed, 78 insertions(+)

diff --git a/drivers/pci/controller/dwc/pcie-designware-ep.c b/drivers/pci/controller/dwc/pcie-designware-ep.c
index 7e7844ff0f7e..c99ba1b85da4 100644
--- a/drivers/pci/controller/dwc/pcie-designware-ep.c
+++ b/drivers/pci/controller/dwc/pcie-designware-ep.c
@@ -808,6 +808,83 @@ dw_pcie_ep_get_features(struct pci_epc *epc, u8 func_no, u8 vfunc_no)
 	return ep->ops->get_features(ep);
 }
 
+static int
+dw_pcie_ep_get_aux_resources(struct pci_epc *epc, u8 func_no, u8 vfunc_no,
+			     struct pci_epc_aux_resource *resources,
+			     int num_resources)
+{
+	struct dw_pcie_ep *ep = epc_get_drvdata(epc);
+	struct dw_pcie *pci = to_dw_pcie_from_ep(ep);
+	struct dw_edma_chip *edma = &pci->edma;
+	int ll_cnt = 0, needed, idx = 0;
+	resource_size_t dma_size;
+	phys_addr_t dma_phys;
+	unsigned int i;
+
+	if (!pci->edma_reg_size)
+		return 0;
+
+	dma_phys = pci->edma_reg_phys;
+	dma_size = pci->edma_reg_size;
+
+	for (i = 0; i < edma->ll_wr_cnt; i++)
+		if (edma->ll_region_wr[i].sz)
+			ll_cnt++;
+
+	for (i = 0; i < edma->ll_rd_cnt; i++)
+		if (edma->ll_region_rd[i].sz)
+			ll_cnt++;
+
+	needed = 1 + ll_cnt;
+
+	/* Count query mode */
+	if (!resources || !num_resources)
+		return needed;
+
+	if (num_resources < needed)
+		return -ENOSPC;
+
+	resources[idx++] = (struct pci_epc_aux_resource) {
+		.type = PCI_EPC_AUX_DMA_CTRL_MMIO,
+		.phys_addr = dma_phys,
+		.size = dma_size,
+	};
+
+	/* One LL region per write channel */
+	for (i = 0; i < edma->ll_wr_cnt; i++) {
+		if (!edma->ll_region_wr[i].sz)
+			continue;
+
+		resources[idx++] = (struct pci_epc_aux_resource) {
+			.type = PCI_EPC_AUX_DMA_CHAN_DESC,
+			.phys_addr = edma->ll_region_wr[i].paddr,
+			.size = edma->ll_region_wr[i].sz,
+			.u.dma_chan_desc = {
+				.irq = edma->ch_info_wr[i].irq,
+				.db_offset = edma->ch_info_wr[i].db_offset,
+			},
+		};
+	}
+
+	/* One LL region per read channel */
+	for (i = 0; i < edma->ll_rd_cnt; i++) {
+		if (!edma->ll_region_rd[i].sz)
+			continue;
+
+		resources[idx++] = (struct pci_epc_aux_resource) {
+			.type = PCI_EPC_AUX_DMA_CHAN_DESC,
+			.phys_addr = edma->ll_region_rd[i].paddr,
+			.size = edma->ll_region_rd[i].sz,
+			.u.dma_chan_desc = {
+				.irq = edma->ch_info_rd[i].irq,
+				.db_offset = edma->ch_info_rd[i].db_offset,
+			},
+		};
+	}
+
+	return idx;
+}
+
 static const struct pci_epc_ops epc_ops = {
 	.write_header		= dw_pcie_ep_write_header,
 	.set_bar		= dw_pcie_ep_set_bar,
@@ -823,6 +900,7 @@ static const struct pci_epc_ops epc_ops = {
 	.start			= dw_pcie_ep_start,
 	.stop			= dw_pcie_ep_stop,
 	.get_features		= dw_pcie_ep_get_features,
+	.get_aux_resources	= dw_pcie_ep_get_aux_resources,
 };
 
 /**
-- 
2.51.0


