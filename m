Return-Path: <dmaengine+bounces-8862-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EJJKCbyTimlzMAAAu9opvQ
	(envelope-from <dmaengine+bounces-8862-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Tue, 10 Feb 2026 03:11:08 +0100
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id DE8F01162CD
	for <lists+dmaengine@lfdr.de>; Tue, 10 Feb 2026 03:11:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B01C93015737
	for <lists+dmaengine@lfdr.de>; Tue, 10 Feb 2026 02:10:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E899E2C3261;
	Tue, 10 Feb 2026 02:10:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="id8wbvrg"
X-Original-To: dmaengine@vger.kernel.org
Received: from OS0P286CU010.outbound.protection.outlook.com (mail-japanwestazon11021118.outbound.protection.outlook.com [40.107.74.118])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 055BF2C2ABF;
	Tue, 10 Feb 2026 02:10:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.74.118
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770689458; cv=fail; b=VJi7wm3I9djn7hCtUwUirAxe6ohgYgSKOZNla2aTQVBngx6OuKs3bvkdwsxt2pWKpW9dHjzUxPnCD3/Gzf7rMzMqMV6HBCjIcxHthjG1NRKPqXHgghwkYUiItsKh+EQIjVhZwZkVOzdNKRL+qbQdb9a500rl70VCcBR8k+FTryU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770689458; c=relaxed/simple;
	bh=7LM07A8bfNoVAejoavPtvP/tJNubXn3gqlnJPBzyEo8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=uwA2tJb6w4YLRLNtNMj0uWwvLlk+h9FvDm6J/NS09Q0GjRNWR9O1Ff9C4Nggr7nfe0gqfnqgOlFs73SSeQ/zV4sGqBPUycfdoFjltC7x9HHDdyZXjvITl23Y8vEqse6FZy5/20zEUTMLId+rZLiZhwp1+UUJ3afyIgTpbTWdcvg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=id8wbvrg; arc=fail smtp.client-ip=40.107.74.118
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KkK0+OcQ29xkAlVpCWhS4O/RHDopG94JYOpQrvr3h2GOcz1W6GrgT/SYixnyPjuRCm9vosOKy/WDNR0nO+ejYlVpZ2b7cOin/gtjmnADkHoGo0NpVdPE8TvZ1zewtUKhpk9nzLTzmxJdALP4Tf1YAa+vtjkHH83r+kX1OYPweDBNevRATR1pYKgbksaykLclWtboakqavpkohaqrIXKret/gElV/Q33sqFybtvCB3h1cUqZ8Ep8g8Yoysy4QulzN4IjzWiPGrPsI8I5ey1QhXo3TkYcT4TRlfUlqKVVdqw5sRZ3T+bI496e/sYkzZW18JINjUG7NeCBsstKvOHKB7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nwDRkO+mVJajmw0BFq5Ty6sTE8eKw71a5YRRZkeA6ME=;
 b=YJOmVT1W9f9raKBrekFxZLcpb6FAoMO29cWRL7FYx1/ljLQjvJQwvdZnv3+FxwRZLwBDzHIGyHGEOQ9UlNKrl9uG432nFpv13SaxotrJsR8W5Srv60vsk77e5tLzpmeOJYJgxYsvin4Gs94IEP7X4QkpVbfD+M03kqL/Axk5mRxJIPOFNN7hkDc2bT5cybHrwmD+aNF039hwZ7KyGw5utjgLVp0RvM4zVAOcLDDbQgU+yY49aDKvqkERQM5KBr2ZBnIhA4h8mzLkDFvOhZJq8xXjLcVo50kF+Qlv4frjcrB/Z9xlhqQtzhNS1t5YKATvMYRp7KEkit5W874QLA3WIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nwDRkO+mVJajmw0BFq5Ty6sTE8eKw71a5YRRZkeA6ME=;
 b=id8wbvrgL/Uqkw6ziSZWsLXl1013va/RKGiI5sGkbX2iawJXSPmUJ3LPAV6qVF5uALsadqfH/eh/ILqmW7CJFaE3ZCg0mdZKoJ7F3fPUcdpzLg7sdzzj5PJqBNrcCuM0FvWJEEkNOMo564fdfmzEmD8ahGAi8jZTNnklChSgMxw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:38f::10)
 by OS7P286MB6507.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:42e::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.19; Tue, 10 Feb
 2026 02:10:53 +0000
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32]) by TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32%5]) with mapi id 15.20.9587.017; Tue, 10 Feb 2026
 02:10:53 +0000
Date: Tue, 10 Feb 2026 11:10:52 +0900
From: Koichiro Den <den@valinux.co.jp>
To: Frank Li <Frank.li@nxp.com>
Cc: vkoul@kernel.org, mani@kernel.org, cassel@kernel.org, 
	jingoohan1@gmail.com, lpieralisi@kernel.org, kwilczynski@kernel.org, robh@kernel.org, 
	bhelgaas@google.com, kishon@kernel.org, jdmason@kudzu.us, allenbh@gmail.com, 
	dmaengine@vger.kernel.org, linux-pci@vger.kernel.org, ntb@lists.linux.dev, 
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 8/8] PCI: endpoint: pci-ep-msi: Add embedded doorbell
 fallback
Message-ID: <ikrvjztquqyxqxnarna5iscixq42jx7jz5r2y34xxyao4ltv3y@7jds64xkzkj3>
References: <20260209125316.2132589-1-den@valinux.co.jp>
 <20260209125316.2132589-9-den@valinux.co.jp>
 <aYoCnEmXYWA0f6TH@lizhi-Precision-Tower-5810>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aYoCnEmXYWA0f6TH@lizhi-Precision-Tower-5810>
X-ClientProxiedBy: TYWP286CA0015.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:178::13) To TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:38f::10)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY7P286MB7722:EE_|OS7P286MB6507:EE_
X-MS-Office365-Filtering-Correlation-Id: e61196f0-716d-4a02-a75b-08de68499eaa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|10070799003|376014|7416014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?vrJYWJ5JpmQ8WYBTztSe0hkIjxghAasFPTelTOdbv7W1jEqKhU7pTNCJNh61?=
 =?us-ascii?Q?ZfqFcJKhsihC4WIGOU7rCzsFSy24T5jKQEMyZrPBb9Y3Wtt8FWoz2tvXxNaX?=
 =?us-ascii?Q?SaZYoHPJ9PX0dJQEBv1z8+G9E+ghrEDOMCINzpEkAgkBbM+eIAMG0aCBJSUO?=
 =?us-ascii?Q?dGnr/AfbPAW++KNegIdKvWY/6XAm/cscK0qaAfYDNesKUcbhI14BXWP3m5gM?=
 =?us-ascii?Q?qwpPiC4Q6d0ieEOhoafHsM1bf9+MmrDpKbHl47bX59FdVBkaSm1IOiyyMnpw?=
 =?us-ascii?Q?lPJnBGgwit/7bMnXaZXOw/Ly72IShGHbs7q37VBM3ddsfny4jI+2ptpgfMJ+?=
 =?us-ascii?Q?1MSlGIftQd7gvkSjDC7lyQpgjbk4p8TC9ihlTzZRyBMbDudlCA8YopirO5x3?=
 =?us-ascii?Q?YEGnfgYRdJGXJGZIibVkPbqPm6eLd55Lo0X8tEtsqObFeGf2YQm/EP3bGyQ5?=
 =?us-ascii?Q?7XY5pTbMZMDz+Yti0HY5/jRtxQxhFiM0xDRAbNAb88zZTn43KfuFV1CNneFG?=
 =?us-ascii?Q?c0+xI+9ZtpmI133abbVAbm+bnDpK8GcObcha5/IaGDwBJpvCYag+HC3QIQkJ?=
 =?us-ascii?Q?lCdrXvlyuvNfTiLzSzvYwAi+64ICpvC/bokkLhKclsFViihlhpY6ZKYWvHTw?=
 =?us-ascii?Q?DCZ2Vk4+7+Mvp366t/y8oF4zMwLXFL99Jjovuoh15mLx2m8vVhRH/swPVAyJ?=
 =?us-ascii?Q?IZ3MiQjwWd2fAyHrku+89uYaKx08zKNQX8yKBbO8ZhLT6ZB4FJpQBVTuyn+v?=
 =?us-ascii?Q?zMtYkTLpZfpWiUPIizk+jrteOGiot82FwEykCWkw4s7kXjISlRfJ51x3MBhD?=
 =?us-ascii?Q?p0FQuBT6+OQVle0ZCjb1lMk2XhjNtsqJnnnWVJNjfRv64hdhSpnFHhI4yez+?=
 =?us-ascii?Q?rOE7mHOEihcWb/vUFR5SA2ytEkcqQrUvVc09C3MWfUrDfmIMoGMF4Kwb8Jj1?=
 =?us-ascii?Q?/s4RrQqVNQa7ZgXFgmSFCuzINQgrW3EYVk8h6mAOr6EKs9cOIANRaw92+uff?=
 =?us-ascii?Q?Y0hvVNh+nQ8PoH6hiXEJc1Mz+c9fvV+/rMGrtiOzGhEAuZNTuJ+6C3XvwOaa?=
 =?us-ascii?Q?13gD93j8s5MXKkJfM8khBU/7eVPv2yWPqGsmWXlrYrG8e4UmQvIlV4do2EZ8?=
 =?us-ascii?Q?RrVJvklhih8NQ72u36+Jmjrv0uV/d3aObfNqAYhj6sgIVIgN9WhLrRlYLOFJ?=
 =?us-ascii?Q?cXkh00+5yU46hmKPaG9ZKTMQenNcTxx3uelxNVEGiaZ1jZOvrpZ+E3zNCUiy?=
 =?us-ascii?Q?zQ21bi0sYdfsP8CxxGTWotL2BcnluLBZ7eA4dfR/efu4m+4tJt/5ntQWP84u?=
 =?us-ascii?Q?sXscS1TBmJJ3Ricn+lkBDi4/mpBriNEsqNaGAyXaVolStXyKXKkAWf1kHZEh?=
 =?us-ascii?Q?s0jx+7Cb1dUje3nsq/gFK4lv8tWOjloETyeuQa2Ii8P98Sd6aQxgqlaV2hdZ?=
 =?us-ascii?Q?PtrYe8xHrzoksgpSUUrQ/9vd3SbpQ0f2D82kjBEJNcNmhdXX+2sHdRsu1lUc?=
 =?us-ascii?Q?6DDVV1/GKMSkUQGeI8//oJKSUxw7IJ3OixbanUblmJDCWYZyz4z490ZNyMfY?=
 =?us-ascii?Q?MOC0ExNr5klCrVzy5sQ=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(10070799003)(376014)(7416014)(1800799024);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?zyIdQcdeBsljvsPpeM38PyttZNABZ28v9QdhxbeDF9M1BfB70/y/4MLjULgC?=
 =?us-ascii?Q?7kdSWukMPixr0wN0iBO9qlfGqv0T4MTHOZi4h9JRXw2I9kQvfsrKLH1LJMK9?=
 =?us-ascii?Q?93Ll9BLpLeGvlS1wMAzeKbvboxGkDBB1Pwy3y4Jc+TukPT3No+9otxiUaJ34?=
 =?us-ascii?Q?9Hhf3GvUG/BsDK/yVMup3Vrdmwnq/ZPv6Hc2CxNn+MCvqoHlbjit41Tr2mHC?=
 =?us-ascii?Q?1vTW7pQ+RBM7G4AndsJT/zueIfEhRJni67suYYS4oiSTc3jHwn3CD9YhPY5i?=
 =?us-ascii?Q?Oappii0Npfk+WoWLQvwQ/2jDNvFC9DzJ+ORure/qEwinlII3ga0GVg3CiK52?=
 =?us-ascii?Q?qqh4H+A3Cevvqb39/XpNezPTX719HDyPrC7xIaV9vmLoGn4J7sSJO3BLNw5K?=
 =?us-ascii?Q?nXXcw1TySFdrOOV19E8/2OkLeE9dM5PzkALucFQheHLERR9by1iLTBGsNmq4?=
 =?us-ascii?Q?wgs4H9JnTzZxgZtnjIDr+kX8iKNtCIUcZf7AtUNVOLpijHeY0NPE5qSuafTG?=
 =?us-ascii?Q?lbetScjAXyGOuVmNR398UruUyNaMRo9VZ7jOjfYAceyEgGxQmH3JjMg8fGWc?=
 =?us-ascii?Q?8ZZ2CS7QEVLTUHbiEslrBAeCRw6piXlAldnGRkPiZQPCIDDiOWs73fCby7cm?=
 =?us-ascii?Q?yv0UoJ3EdKpzLIhKpmAN2bmPMs552u44+/jMgO/w+nUcgqcxtJXOkQVlpoqG?=
 =?us-ascii?Q?6XPhA+p/A6oeFqXac8qqXf1B2lZDm1Yj2Yf5e0NWXN9XoduqGorU57w5NXCF?=
 =?us-ascii?Q?QHoxPMN1rT0aUYwRbyHFiomyGZCchNiRMuSYZAG1w2xqaaM/JAopTVFyHbVZ?=
 =?us-ascii?Q?USTH1nADjAmEEV39mL+WV2Qjxujf9fmaaFj7m5MQKR4F/uymJTaMlVswwt9L?=
 =?us-ascii?Q?og50jGTY/55Wi+bH8pmsbZUs9RuqUTTIzXtbDxDX6DLs2KM+nDOkHJub4lOo?=
 =?us-ascii?Q?Kt2AtJ2tPh51Qehd/0IIJacwcaHgDG1r2cdly7ZpGdZHQD9GHBvFM+dnpLJK?=
 =?us-ascii?Q?re07Ef6H1AGmdFBo+3qv35slOfjQa4WCbEXQorjCa/4v/ribINX7j8/RiTFI?=
 =?us-ascii?Q?JabJ8wx1RU3kWUJ9HplFAEzZsHOsWpBmFW2MBY51rczHq+WlorEOARAc1l+k?=
 =?us-ascii?Q?ZZGu3igHmwA2aBRdfuBSQ66pH6PF2OyyCYDvD4taJCyiySaU/Lgf+xiptL7n?=
 =?us-ascii?Q?hZt9PwOwlc+dV3A4HjZWOKzn2wBKBZmta3+vvXovAmL9a4GJFcjg85GO3cPa?=
 =?us-ascii?Q?PcXu/SzE2ndz6lalINwSdn2oQUPG6JVxCjph8OzZmJMpQrmv5N4M1qWxmtjb?=
 =?us-ascii?Q?3AJkpNCZEe7Ti9qx5rYKpgeiYoqgcCcmW6c6Ny1IpM6DzjdQDPpPt7B+Fbnf?=
 =?us-ascii?Q?Ad4ryl3Kx1pVH+8pziqStz/XEri2lyLy97mZhn7SYdV6PFFOUfcLI75OCAhG?=
 =?us-ascii?Q?MXQ/IKfC0PwB5bLZp/2JNrbV/GtKeoXs9Av2+UvOt2N94xxrRsODkfKQJdTW?=
 =?us-ascii?Q?8l1aScqE33Wy6SI2pAXGncdk3N6c/FxUqRIzhaaWuZ19mZNGYb9/ulv5y90D?=
 =?us-ascii?Q?RKTZvt+8daSoC+LQjRCVjGM3jZiwl8HS2L0X5hauFRizkWwcMgRUdwVfmYT2?=
 =?us-ascii?Q?RAN/+cpmXz/4c9m1ZKICQ6GshzN+UxZZEYJAr7yhtbP69qoI483MONfQKEX7?=
 =?us-ascii?Q?UA16Yr4QRLektwpJqxEu2VhwWJ7efbi7crqChwCZsr9zYA3p9sbvc3xcgmm0?=
 =?us-ascii?Q?/F4dOdPuUpkOQm3TBVgu235cO5WB7IPOSKHrRKJv/gKZJUBvdLup?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: e61196f0-716d-4a02-a75b-08de68499eaa
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Feb 2026 02:10:53.7706
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VqZ9Px3m/rDlY+Ps7s4YIPw36M/MfU3ktfiVY2fgHBvoLA1LG7T9JAP06Y76fMmfLe1CSeHEprvzGlVz1xCpPw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS7P286MB6507
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[valinux.co.jp,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[valinux.co.jp:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-8862-lists,dmaengine=lfdr.de];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[17];
	FREEMAIL_CC(0.00)[kernel.org,gmail.com,google.com,kudzu.us,vger.kernel.org,lists.linux.dev];
	DKIM_TRACE(0.00)[valinux.co.jp:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[den@valinux.co.jp,dmaengine@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[dmaengine];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,valinux.co.jp:email,valinux.co.jp:dkim]
X-Rspamd-Queue-Id: DE8F01162CD
X-Rspamd-Action: no action

On Mon, Feb 09, 2026 at 10:51:56AM -0500, Frank Li wrote:
> On Mon, Feb 09, 2026 at 09:53:16PM +0900, Koichiro Den wrote:
> > pci_epf_alloc_doorbell() currently allocates MSI-backed doorbells using
> > the MSI domain returned by of_msi_map_get_device_domain(...,
> > DOMAIN_BUS_PLATFORM_MSI). On platforms where such an MSI irq domain is
> > not available, EPF drivers cannot provide doorbells to the RC. Even if
> > it's available and MSI device domain successfully created, the write
> > into the message address via BAR inbound mapping might not work for
> > platform-specific reasons (e.g. write into GITS_TRANSLATOR via iATU IB
> > mapping does not reach ITS at least on R-Car Gen4 Spider).
> >
> > Add an "embedded (DMA) doorbell" fallback path that uses EPC-provided
> > auxiliary resources to build doorbell address/data pairs backed by a
> > platform device MMIO region (e.g. dw-edma) and a shared platform IRQ.
> >
> > To let EPF drivers request interrupts correctly, extend struct
> > pci_epf_doorbell_msg with the doorbell type and required IRQ request
> > flags. Update pci-epf-test to handle shared IRQ constraints by using a
> > trivial primary handler to wake the threaded handler, and update
> > pci-epf-vntb to use the required irq_flags.
> >
> > Signed-off-by: Koichiro Den <den@valinux.co.jp>
> > ---
> >  drivers/pci/endpoint/functions/pci-epf-test.c |  29 +++-
> >  drivers/pci/endpoint/functions/pci-epf-vntb.c |   3 +-
> >  drivers/pci/endpoint/pci-ep-msi.c             | 129 ++++++++++++++++--
> >  include/linux/pci-epf.h                       |  17 ++-
> >  4 files changed, 160 insertions(+), 18 deletions(-)
> >
> > diff --git a/drivers/pci/endpoint/functions/pci-epf-test.c b/drivers/pci/endpoint/functions/pci-epf-test.c
> > index 23034f548c90..2f3b2e6a3e29 100644
> > --- a/drivers/pci/endpoint/functions/pci-epf-test.c
> > +++ b/drivers/pci/endpoint/functions/pci-epf-test.c
> > @@ -711,6 +711,26 @@ static irqreturn_t pci_epf_test_doorbell_handler(int irq, void *data)
> >  	return IRQ_HANDLED;
> >  }
> >
> > +/*
> > + * Embedded doorbell fallback uses a platform IRQ which is already owned by a
> > + * platform driver (e.g. dw-edma) and therefore must be requested IRQF_SHARED.
> > + * We cannot add IRQF_ONESHOT here because shared IRQ handlers must agree on
> > + * IRQF_ONESHOT.
> > + *
> > + * request_threaded_irq() with handler == NULL would be rejected for !ONESHOT
> > + * because the default primary handler only wakes the thread and does not
> > + * mask/ack the interrupt, which can livelock on level-triggered IRQs.
> > + *
> > + * In the embedded doorbell fallback, the IRQ owner is responsible for
> > + * acknowledging/deasserting the interrupt source in hardirq context before the
> > + * IRQ line is unmasked. Therefore this driver only needs a trivial primary
> > + * handler to wake the threaded handler.
> > + */
> > +static irqreturn_t pci_epf_test_doorbell_primary(int irq, void *data)
> > +{
> > +	return IRQ_WAKE_THREAD;
> > +}
> > +
> >  static void pci_epf_test_doorbell_cleanup(struct pci_epf_test *epf_test)
> >  {
> >  	struct pci_epf_test_reg *reg = epf_test->reg[epf_test->test_reg_bar];
> > @@ -731,6 +751,7 @@ static void pci_epf_test_enable_doorbell(struct pci_epf_test *epf_test,
> >  	u32 status = le32_to_cpu(reg->status);
> >  	struct pci_epf *epf = epf_test->epf;
> >  	struct pci_epc *epc = epf->epc;
> > +	unsigned long irq_flags;
> >  	struct msi_msg *msg;
> >  	enum pci_barno bar;
> >  	size_t offset;
> > @@ -745,10 +766,14 @@ static void pci_epf_test_enable_doorbell(struct pci_epf_test *epf_test,
> >  	if (bar < BAR_0)
> >  		goto err_doorbell_cleanup;
> >
> > +	irq_flags = epf->db_msg[0].irq_flags;
> > +	if (!(irq_flags & IRQF_SHARED))
> > +		irq_flags |= IRQF_ONESHOT;
> >  	epf_test->db_irq_requested = false;
> >
> > -	ret = request_threaded_irq(epf->db_msg[0].virq, NULL,
> > -				   pci_epf_test_doorbell_handler, IRQF_ONESHOT,
> > +	ret = request_threaded_irq(epf->db_msg[0].virq,
> > +				   pci_epf_test_doorbell_primary,
> > +				   pci_epf_test_doorbell_handler, irq_flags,
> >  				   "pci-ep-test-doorbell", epf_test);
> >  	if (ret) {
> >  		dev_err(&epf->dev,
> > diff --git a/drivers/pci/endpoint/functions/pci-epf-vntb.c b/drivers/pci/endpoint/functions/pci-epf-vntb.c
> > index 3ecc5059f92b..d2fd1e194088 100644
> > --- a/drivers/pci/endpoint/functions/pci-epf-vntb.c
> > +++ b/drivers/pci/endpoint/functions/pci-epf-vntb.c
> > @@ -535,7 +535,8 @@ static int epf_ntb_db_bar_init_msi_doorbell(struct epf_ntb *ntb,
> >
> >  	for (i = 0; i < ntb->db_count; i++) {
> >  		ret = request_irq(epf->db_msg[i].virq, epf_ntb_doorbell_handler,
> > -				  0, "pci_epf_vntb_db", ntb);
> > +				  epf->db_msg[i].irq_flags, "pci_epf_vntb_db",
> > +				  ntb);
> >
> >  		if (ret) {
> >  			dev_err(&epf->dev,
> > diff --git a/drivers/pci/endpoint/pci-ep-msi.c b/drivers/pci/endpoint/pci-ep-msi.c
> > index ad8a81d6ad77..0e93d4789abd 100644
> > --- a/drivers/pci/endpoint/pci-ep-msi.c
> > +++ b/drivers/pci/endpoint/pci-ep-msi.c
> > @@ -8,6 +8,7 @@
> >
> >  #include <linux/device.h>
> >  #include <linux/export.h>
> > +#include <linux/interrupt.h>
> >  #include <linux/irqdomain.h>
> >  #include <linux/module.h>
> >  #include <linux/msi.h>
> > @@ -35,23 +36,84 @@ static void pci_epf_write_msi_msg(struct msi_desc *desc, struct msi_msg *msg)
> >  	pci_epc_put(epc);
> >  }
> >
> > -int pci_epf_alloc_doorbell(struct pci_epf *epf, u16 num_db)
> > +static int pci_epf_alloc_doorbell_embedded(struct pci_epf *epf, u16 num_db)
> >  {
> >  	struct pci_epc *epc = epf->epc;
> > -	struct device *dev = &epf->dev;
> > -	struct irq_domain *domain;
> > -	void *msg;
> > -	int ret;
> > -	int i;
> > +	const struct pci_epc_aux_resource *dma_ctrl = NULL;
> > +	struct pci_epf_doorbell_msg *msg;
> > +	int count, ret, i, db;
> >
> > -	/* TODO: Multi-EPF support */
> > -	if (list_first_entry_or_null(&epc->pci_epf, struct pci_epf, list) != epf) {
> > -		dev_err(dev, "MSI doorbell doesn't support multiple EPF\n");
> > -		return -EINVAL;
> > +	count = pci_epc_get_aux_resources(epc, epf->func_no, epf->vfunc_no,
> > +					  NULL, 0);
> > +	if (count == -EOPNOTSUPP || count == 0)
> > +		return -ENODEV;
> > +	if (count < 0)
> > +		return count;
> > +
> > +	struct pci_epc_aux_resource *res __free(kfree) =
> > +				kcalloc(count, sizeof(*res), GFP_KERNEL);
> > +	if (!res)
> > +		return -ENOMEM;
> > +
> > +	ret = pci_epc_get_aux_resources(epc, epf->func_no, epf->vfunc_no,
> > +					res, count);
> > +	if (ret == -EOPNOTSUPP || ret == 0)
> > +		return -ENODEV;
> > +	if (ret < 0)
> > +		return ret;
> > +
> > +	count = ret;
> > +
> > +	for (i = 0; i < count; i++) {
> > +		if (res[i].type == PCI_EPC_AUX_DMA_CTRL_MMIO) {
> 
> I suggest use PCI_EPC_EMBEDED_DOORBELL_MMIO directly because some vendor
> have really doorbell register space.
> 
> below addr is that phys_addr + res[i].u.dma_chan_desc.db_offset. So vendor
> can easily change to their doorbell register space in future.

That makes sense. I can extend enum pci_epc_aux_resource_type with a
dedicated doorbell MMIO resource type and use it, instead of assuming the
embedded doorbell lives inside the DMA control MMIO window
(PCI_EPC_AUX_DMA_CTRL_MMIO).

With that approach, I plan to drop u.dma_chan_desc.db_offset for now, since
it would always be zero in the current dw-edma v0 case (the INT_STATUS
offset is not channel-specific). If another vendor implementation needs a
channel-specific offset in the future, we can just extend this again when
it's actually needed.

In short, after your feedback, I'm thinking of the following change (diff
against v6):

      enum pci_epc_aux_resource_type {
      	PCI_EPC_AUX_DMA_CTRL_MMIO,
      	PCI_EPC_AUX_DMA_CHAN_DESC,
    + 	PCI_EPC_AUX_DOORBELL_MMIO,
      };
    
      struct pci_epc_aux_resource {
      	enum pci_epc_aux_resource_type type;
      	phys_addr_t phys_addr;
      	resource_size_t size;
      
      	union {
      		/* PCI_EPC_AUX_DMA_CHAN_DESC */
      		struct {
      			int irq;
    - 			resource_size_t db_offset;
      		} dma_chan_desc;
      	} u;
      };

Thanks for the review,
Koichiro

> 
> Frank
> 
> > +			dma_ctrl = &res[i];
> > +			break;
> > +		}
> > +	}
> > +	if (!dma_ctrl)
> > +		return -ENODEV;
> > +
> > +	msg = kcalloc(num_db, sizeof(*msg), GFP_KERNEL);
> > +	if (!msg)
> > +		return -ENOMEM;
> > +
> > +	for (i = 0, db = 0; i < count && db < num_db; i++) {
> > +		u64 addr;
> > +
> > +		if (res[i].type != PCI_EPC_AUX_DMA_CHAN_DESC)
> > +			continue;
> > +
> > +		if (res[i].u.dma_chan_desc.db_offset >= dma_ctrl->size)
> > +			continue;
> > +
> > +		addr = (u64)dma_ctrl->phys_addr + res[i].u.dma_chan_desc.db_offset;
> > +
> > +		msg[db].msg.address_lo = (u32)addr;
> > +		msg[db].msg.address_hi = (u32)(addr >> 32);
> > +		msg[db].msg.data = 0;
> > +		msg[db].virq = res[i].u.dma_chan_desc.irq;
> > +		msg[db].irq_flags = IRQF_SHARED;
> > +		msg[db].type = PCI_EPF_DOORBELL_EMBEDDED;
> > +		db++;
> >  	}
> >
> > -	if (epf->db_msg)
> > -		return -EBUSY;
> > +	if (db != num_db) {
> > +		kfree(msg);
> > +		return -ENOSPC;
> > +	}
> > +
> > +	epf->num_db = num_db;
> > +	epf->db_msg = msg;
> > +	return 0;
> > +}
> > +
> > +static int pci_epf_alloc_doorbell_msi(struct pci_epf *epf, u16 num_db)
> > +{
> 
> suggest create patch, which only add helper function
> pci_epf_alloc_doorbell_msi().
> 
> Then add pci_epf_alloc_doorbell_embedded.
> 
> Frank
> > +	struct pci_epf_doorbell_msg *msg;
> > +	struct device *dev = &epf->dev;
> > +	struct pci_epc *epc = epf->epc;
> > +	struct irq_domain *domain;
> > +	int ret, i;
> >
> >  	domain = of_msi_map_get_device_domain(epc->dev.parent, 0,
> >  					      DOMAIN_BUS_PLATFORM_MSI);
> > @@ -74,6 +136,11 @@ int pci_epf_alloc_doorbell(struct pci_epf *epf, u16 num_db)
> >  	if (!msg)
> >  		return -ENOMEM;
> >
> > +	for (i = 0; i < num_db; i++) {
> > +		msg[i].irq_flags = 0;
> > +		msg[i].type = PCI_EPF_DOORBELL_MSI;
> > +	}
> > +
> >  	epf->num_db = num_db;
> >  	epf->db_msg = msg;
> >
> > @@ -90,13 +157,49 @@ int pci_epf_alloc_doorbell(struct pci_epf *epf, u16 num_db)
> >  	for (i = 0; i < num_db; i++)
> >  		epf->db_msg[i].virq = msi_get_virq(epc->dev.parent, i);
> >
> > +	return 0;
> > +}
> > +
> > +int pci_epf_alloc_doorbell(struct pci_epf *epf, u16 num_db)
> > +{
> > +	struct pci_epc *epc = epf->epc;
> > +	struct device *dev = &epf->dev;
> > +	int ret;
> > +
> > +	/* TODO: Multi-EPF support */
> > +	if (list_first_entry_or_null(&epc->pci_epf, struct pci_epf, list) != epf) {
> > +		dev_err(dev, "Doorbell doesn't support multiple EPF\n");
> > +		return -EINVAL;
> > +	}
> > +
> > +	if (epf->db_msg)
> > +		return -EBUSY;
> > +
> > +	ret = pci_epf_alloc_doorbell_msi(epf, num_db);
> > +	if (!ret)
> > +		return 0;
> > +
> > +	if (ret != -ENODEV)
> > +		return ret;
> > +
> > +	ret = pci_epf_alloc_doorbell_embedded(epf, num_db);
> > +	if (!ret) {
> > +		dev_info(dev, "Using embedded (DMA) doorbell fallback\n");
> > +		return 0;
> > +	}
> > +
> > +	dev_err(dev, "Failed to allocate doorbell: %d\n", ret);
> >  	return ret;
> >  }
> >  EXPORT_SYMBOL_GPL(pci_epf_alloc_doorbell);
> >
> >  void pci_epf_free_doorbell(struct pci_epf *epf)
> >  {
> > -	platform_device_msi_free_irqs_all(epf->epc->dev.parent);
> > +	if (!epf->db_msg)
> > +		return;
> > +
> > +	if (epf->db_msg[0].type == PCI_EPF_DOORBELL_MSI)
> > +		platform_device_msi_free_irqs_all(epf->epc->dev.parent);
> >
> >  	kfree(epf->db_msg);
> >  	epf->db_msg = NULL;
> > diff --git a/include/linux/pci-epf.h b/include/linux/pci-epf.h
> > index 7737a7c03260..e6625198f401 100644
> > --- a/include/linux/pci-epf.h
> > +++ b/include/linux/pci-epf.h
> > @@ -152,14 +152,27 @@ struct pci_epf_bar {
> >  	struct pci_epf_bar_submap	*submap;
> >  };
> >
> > +enum pci_epf_doorbell_type {
> > +	PCI_EPF_DOORBELL_MSI = 0,
> > +	PCI_EPF_DOORBELL_EMBEDDED,
> > +};
> > +
> >  /**
> >   * struct pci_epf_doorbell_msg - represents doorbell message
> > - * @msg: MSI message
> > - * @virq: IRQ number of this doorbell MSI message
> > + * @msg: Doorbell address/data pair to be mapped into BAR space.
> > + *       For MSI-backed doorbells this is the MSI message, while for
> > + *       "embedded" doorbells this represents an MMIO write that asserts
> > + *       an interrupt on the EP side.
> > + * @virq: IRQ number of this doorbell message
> > + * @irq_flags: Required flags for request_irq()/request_threaded_irq().
> > + *             Callers may OR-in additional flags (e.g. IRQF_ONESHOT).
> > + * @type: Doorbell type.
> >   */
> >  struct pci_epf_doorbell_msg {
> >  	struct msi_msg msg;
> >  	int virq;
> > +	unsigned long irq_flags;
> > +	enum pci_epf_doorbell_type type;
> >  };
> >
> >  /**
> > --
> > 2.51.0
> >

