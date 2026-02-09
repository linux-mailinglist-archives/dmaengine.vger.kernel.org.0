Return-Path: <dmaengine+bounces-8845-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iMDSLw3ZiWlUCQAAu9opvQ
	(envelope-from <dmaengine+bounces-8845-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Mon, 09 Feb 2026 13:54:37 +0100
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 60E9010F328
	for <lists+dmaengine@lfdr.de>; Mon, 09 Feb 2026 13:54:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8BE9630329B1
	for <lists+dmaengine@lfdr.de>; Mon,  9 Feb 2026 12:53:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 708DF37880A;
	Mon,  9 Feb 2026 12:53:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="LFDiPEjc"
X-Original-To: dmaengine@vger.kernel.org
Received: from OS0P286CU011.outbound.protection.outlook.com (mail-japanwestazon11020117.outbound.protection.outlook.com [52.101.228.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2913937757C;
	Mon,  9 Feb 2026 12:53:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.228.117
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770641605; cv=fail; b=U2DRRkmb/T0e68OD2RQHP2b3qK2jO8cXPMnr1joDBv0zDlpKf8wVBKUyxpn8xTnn31k/iSKzJjGLWJjHI9rWIaJQTdmYrRydI0IX/XqLKF3ZOwjjDAM4XU8ny9e9Zpja/gBj7fplFDnUkbvNUSylpR2R52cI1uOZY5Fn58crSLg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770641605; c=relaxed/simple;
	bh=IzccJqE7Lm912wY0VygQRmfcaqtAjyn8prFD5KjsMS4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=NcuckspTRxrU1nnnnEFTqCkSi4CwnKcPWRg/YDDgyaf5P9WPM29bBzQsWlmR6KNIJT1trWnPv4ziGCavTDIA65ufdNsdMILDzFNHq8Ovs6vDUzo/WSG+oGHVtjuG1aFU+Qyd3T3xPuCX7L4mmz9dHE9EWid73V3p0iW7TdtEOLE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=LFDiPEjc; arc=fail smtp.client-ip=52.101.228.117
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Cehior5sNQH47v1IXhahoLtPkY8yNByoaky6w+kao2+z22gpEo/b6GUs6mOKgdg3cA1TKYthr9FaOlbNKpA12lbc5eVG8M5PWsJXZNmpnC8O1wRsWPuAcDFVtm028w4x5IC1bntHy1F6pXdt8PYyEko6cV9Y+m1/rpO0/zb/YG/yeau7edLy+Ml2zYSpbyoqzCaZphctQLI9PfjPzi16TtAqnny1y8uz0F0mFH4zJ9NaSLzqVYJfdVDBdVB5DuDQkQfFw/XThDbd6CeRD++8NlSlU3Lh4KFNgVMmKV4YZrKF9LWUJJjL0RhADPJfJfoT/PWsqZolik6XvZ6Xvw5bYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=usXujhdztx84mPQSgni/ZWDOTKEq4ka90KIk3iW/c2k=;
 b=Kbc1V35f0u5+F+gS7J/pdL6nm31hog8N68jY59oOKYgR6b5CkCP9NiCGIlGKwv6CYSZlnIXVKDnZNHIcLGgcHRJicP6iQP4uVu5XkJxOoU3KaLYICb9PJhJFKUHd4g0FcpamVXOfNTDOtwp8bo1TmB55aR+MOkrd75eN9SuaTHisf1EI3iC85kg54r67k6wu0UhhncA3bIlBA8i80QYTVrwSmT8fdkZ5LGAVjYNERojF0a9/mauXhdkcjggM0ACnWVWqB2KpAru3JBZ2d3sCPCpJ5cy2G3ah6h3svR+Qdy5J9eBfWZEp1K44dvaDu4DTvedzfYHNlA3gJrXLsPCZig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=usXujhdztx84mPQSgni/ZWDOTKEq4ka90KIk3iW/c2k=;
 b=LFDiPEjcxr0jIS9hFtP4ZKU6q/q/2jwAu3rhvfLyfSLXfp3PgNt+9EAY+gu58wxnwtvE57GkySakCMxrelrGSoceY9cEYhX1SZ9NB1AcmYbnrlQL5kfghKuV76GaKXtk9BtzX51EJUW6aQray4wTiI2bLUbJR2NtecMJ82NYZMw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:38f::10)
 by OS7P286MB3742.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:237::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.18; Mon, 9 Feb
 2026 12:53:23 +0000
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32]) by TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32%5]) with mapi id 15.20.9587.017; Mon, 9 Feb 2026
 12:53:23 +0000
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
Subject: [PATCH v6 6/8] PCI: endpoint: pci-epf-test: Don't free doorbell IRQ unless requested
Date: Mon,  9 Feb 2026 21:53:14 +0900
Message-ID: <20260209125316.2132589-7-den@valinux.co.jp>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260209125316.2132589-1-den@valinux.co.jp>
References: <20260209125316.2132589-1-den@valinux.co.jp>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TY4PR01CA0020.jpnprd01.prod.outlook.com
 (2603:1096:405:2bf::6) To TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:38f::10)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY7P286MB7722:EE_|OS7P286MB3742:EE_
X-MS-Office365-Filtering-Correlation-Id: 2199132a-724a-4c1a-1b44-08de67da35d5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|10070799003|376014|7416014|366016|1800799024|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?jA82E6QJqBVxcOaf7jLCwE57fHKSkrWSTbp6gXOisl1AAhTwWjLMGIexsLke?=
 =?us-ascii?Q?8qvPjN3JdSL73vUol23P0BfYNrf8E6pDIZ3OPgj+DgN7ZMrK1roZ18LeuSRl?=
 =?us-ascii?Q?mY/EszzWutPADjY3eqT/gfHPvhw0wuYIHKVSI8aC56KqvcJbfjV1lIhc/eP3?=
 =?us-ascii?Q?ft640vHLJhe3r49HwvvgCnhtf8vkYZd5cpfAJmI9daNzoXun/l2koZygmxOf?=
 =?us-ascii?Q?pQnVeoxLFrMKVzNl8aSM2EUGB/gU2/wRfRJHVY39RZZOilOT4mKfmFgDW3In?=
 =?us-ascii?Q?TofNeXIpzWw8GP8Zgy3+eexyc/eqkngGhfXm5QzxtP4Xab7Wj2zUqxY7z3+n?=
 =?us-ascii?Q?DQM/N+11Qv16rQsyVOdJLOcD0V9B7s52G+NjzkPIf+VVI1FsLpz+GcgrwrN7?=
 =?us-ascii?Q?lW9UT6zaadYVxFP8XtnEqUbMMNI1kQtP3sZbinMGxJOcWHk3+6JMD6iCQ4LC?=
 =?us-ascii?Q?+Hoa1oCLUcneMSLu18fVp7y6OWTWbRuyJfijMEiL9yCwa9Sayds3oCctwnzU?=
 =?us-ascii?Q?llKG89yfvqGUYYljPLActXsctRMxzsdTQw1/Oy2UXuq7TzaVJAJYRT7PwHi1?=
 =?us-ascii?Q?PF/+/YNhQ8AQU+30+COcy94MNHgycdiczd7+zerRjRAHNQkIJrCkLgNEGh5S?=
 =?us-ascii?Q?+R7m+FUFr3TSkiZSdhn1mU62uUGT2IgFXMOI9B4Vw59qLbhNI2wXsymn+3l1?=
 =?us-ascii?Q?j3p1jYBoswJxJ3mwxXZboXe8mfNpgnWi1wi/TaVQoG+L/Hy9e+i361whC8Ly?=
 =?us-ascii?Q?TbH/kB5INnpAFuVA3NJ44Te+RiQw6sxscvuy2o3ViGJkGJy12A8lEb6rADAV?=
 =?us-ascii?Q?8jOHZmkH6lRO1zX7rlXxETiJvk8Gm3MZLpNlRnhGRXFmQqyAOnWWe4rl+d0A?=
 =?us-ascii?Q?rGCJ9yPe0+PBjmAU0ZpLXjpYKGmPDp49FKSEOQfvldZu+V9IIiMhVV4Kmody?=
 =?us-ascii?Q?dRglNnoGa3utXTnReAasAFOLSYs15zFzPWdktdtiLZqkq9p+1pDyvKo/RIga?=
 =?us-ascii?Q?Okm2Sw0ARWTPxS5Vg7+1BMAiX6Nv/p6oF1Cvgin2P2sn4ID9oSM7iuZWKRmR?=
 =?us-ascii?Q?XyG5vZ1xtVOrqmMx4UF7p5YiYUqy8qLZZGI0w8875joe9As6DL4P54j+gQKv?=
 =?us-ascii?Q?cL5V92qBh6T0XtD59pN9Qk6xiBjAYKYCY0RnDAbQAneM8no++r+8+Wlgh6le?=
 =?us-ascii?Q?YZyTBWYI/j17zqKP/6HbC/5EmULCqSbaQUVxZQuMdGJ1JMP6sfnjlh3y0odJ?=
 =?us-ascii?Q?lqiUIB+TQMtNzLTQOVQnGUVPrfqOrbXYjsLOn11B0V2gHmQl+h3bcHDkLjyP?=
 =?us-ascii?Q?qu+FOyOKAADi6JDQ/hH71/tZpyyduTDGdouoqHqQXLpxGkZwJrR2VdV/jwF6?=
 =?us-ascii?Q?FFElsDBmCwXhwLyZyQ0NG51X9RM0JyDvNHQodbfnV53PJjGXVRLD1k/WDdO6?=
 =?us-ascii?Q?gKJK7n/H3Atm9su+n1MTuRSoNR60flD1vVbTt57capORQHta/udCp+GnIR50?=
 =?us-ascii?Q?l6pJcdnUbIowC7l75kjej51tbOKwXFS9ofEfMBapjfb1QHnvy5J5WySIhXa7?=
 =?us-ascii?Q?UlK5WxYOH3VfYyiUvk8axEnrNf/uhBJSfO7/6pJZruJ8z7ZzsRA3nww9A7Dn?=
 =?us-ascii?Q?aA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(376014)(7416014)(366016)(1800799024)(921020);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?657D82g/my5dKUHSDdHNFQQBH36sjPqL7h9jY7uP+Nl/TFmbIpZNCS9GCZ6T?=
 =?us-ascii?Q?vV6RF2LHkDipI+zvo5S6wIo2wuHo56ybnXLRTTcw0f49gwmFnGoCr8hvMfKK?=
 =?us-ascii?Q?HM9pppguRoE6mbYOV7j2B3xqGyyNgJUUZC19pGPBFQzmJiZC6RxaLFlE+Nws?=
 =?us-ascii?Q?MCI5Alp65oJb9vhbOGkAYApYbJ+l/oglAIY56pcn8by5xS9Il9CHoGrEIPmc?=
 =?us-ascii?Q?Ua0yzREQciTq+Y9cx6GAKuzo0PEVAqik2kbmeRs/em6RfFcB6vp5GTfPwJ/3?=
 =?us-ascii?Q?iIwTaVmXCVJdJiaK3r6mpo5nywp5s/A71TdWkugg/oEaVAI8ta3B8++w/gJN?=
 =?us-ascii?Q?0JnCCpfIVv38jAXs3iBbgIWHcteQLWJblmFOu3+mQTpMR4GOfONSnDJlJ5LU?=
 =?us-ascii?Q?+lMr+AMRJ6ZkZzLX6rmi9aFlEfRpkslQEySA6TjTvJZLJEuMTT9InJ3KwpXE?=
 =?us-ascii?Q?z2vFjxtjghnSjde26/BE1ld8T6uq8my4XuodbownFBV9JXx8g4Chv1+Raspu?=
 =?us-ascii?Q?d1IiWt0mmttWZZEzF7an+9ZLLOOEs8Jw63EbbpssvJpsrvHoeY3E2c8YlZ96?=
 =?us-ascii?Q?4IEmMC1Ci7j1XN/if4MxHvqCE0B4vB5h3mgNxEA0rEMmCzuBFXGGu6EpfCuy?=
 =?us-ascii?Q?XdwWS076WIkZUy/cPIPDU5fXp/Tz9e35FGxlUYzAMFXraTUqQd4oUSXEZn6Q?=
 =?us-ascii?Q?PQ6iCIcBQ5IXBRMrbECVgHt/B4e1CxqZsnHfd9Sp9BC2OU158pFfyNkPNwyX?=
 =?us-ascii?Q?aLozqQcDcy0ic8SNNcquaypjavfbNwVZmDka4b/WHXpa6JFK/n8L2MJ8DD2n?=
 =?us-ascii?Q?nygk9SVT2B+k7C+15Uak5aoBgAts/zr9OEVTcBP0hBiZ9wwg9WaWF+0/6OoW?=
 =?us-ascii?Q?LJlWSrppLyjWYNdG40nq/kJ3h7/kla9TVFr/QEhXNhSSoTwwXofUOVVjHbl4?=
 =?us-ascii?Q?6DQDFSqQ+yBOvht/TIBISiW/Ybh//VXHfCUvZT/BulACYjzzbRtPUwBFVgtl?=
 =?us-ascii?Q?3ulk0H3dKbZtLiWWwXuxY21RimcMV9LWwhJQ1E8szk7S34ubwbpDLWuGWpjZ?=
 =?us-ascii?Q?EXJY724tbDbm8lPzy+2rpk4X2lu5xPLKtPbg9ubHVveh/0tkmOH3nT/IlALv?=
 =?us-ascii?Q?nMKsHHKtny51tmcVDSEwNMH/BO0OzeVcl9LtYeMoXXJTGmc04N/aToHeujQA?=
 =?us-ascii?Q?VIoDSJmAf8K0vTVGIackhYVuIs1Hp0Zg80rLbIfcKTbUq7MS7Uf2UxN249HF?=
 =?us-ascii?Q?xcg3L3fQ/y8yGdSoLGMcHVWfY2XI/XXM1I5IeLX5TKbARN5Eb/CwnwsAATxC?=
 =?us-ascii?Q?ZB8VqzjLU344YRzuB4TeGFdcqUVbbipO0OUd1tOhZAPr+NIoYKdogJU2+ERW?=
 =?us-ascii?Q?pdvvX6E+ynpx7KTkJlVZ3/KpE3+igVe+izOvKX6Yo/YGVpD0O5UUqgAtsabZ?=
 =?us-ascii?Q?tYuZo54aUYmIteGvwWL3//IMWEWYZfzrPpVF3ONlBSmeg87z2gt4yReYkgMM?=
 =?us-ascii?Q?pwDTkCI21MvR/Bihl2j+3TNuiDFPXuZcY0lEjP84eeAYGSGT/jxx0O6SB1wb?=
 =?us-ascii?Q?6z5XyEotjDupUqVNp7Z8gynxYjiwWZwx8duZq0BPJM7qX2jEYEAwBxwCJWOX?=
 =?us-ascii?Q?5gEf+0gcZpmrUvGzEMiIx6B1tvQ+vTTT3DKCFtJ59jGvVrKY87b3bgukohat?=
 =?us-ascii?Q?rtBWwPkP3Qu3i7Lbs9yC4B0vw9VKfOSOk66QnM887HMkLbpAx+yXtkc8Atyq?=
 =?us-ascii?Q?XGQ12BQwq2Debg7jY8ZPRjcQkZYpnGdrkJUfd5f41E1cy+M+jDW8?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: 2199132a-724a-4c1a-1b44-08de67da35d5
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Feb 2026 12:53:23.7370
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gwc1kr+iKDFtNXvIpEj9AJU/73AITViO3ak9vg9yCsAjSBCrWOKBGzcN8d578PtBRtpM1ksVcYAHBYhH4eI4vQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS7P286MB3742
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[valinux.co.jp,none];
	R_DKIM_ALLOW(-0.20)[valinux.co.jp:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-8845-lists,dmaengine=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[valinux.co.jp:mid,valinux.co.jp:dkim,valinux.co.jp:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 60E9010F328
X-Rspamd-Action: no action

pci_epf_test_enable_doorbell() allocates a doorbell and then installs
the interrupt handler with request_threaded_irq(). On failures before
the IRQ is successfully requested (e.g. no free BAR,
request_threaded_irq() failure), the error path jumps to
err_doorbell_cleanup and calls pci_epf_test_doorbell_cleanup().

pci_epf_test_doorbell_cleanup() unconditionally calls free_irq() for the
doorbell virq, which can trigger "Trying to free already-free IRQ"
warnings when the IRQ was never requested.

Track whether the doorbell IRQ has been successfully requested and only
call free_irq() when it has.

Fixes: eff0c286aa91 ("PCI: endpoint: pci-epf-test: Add doorbell test support")
Signed-off-by: Koichiro Den <den@valinux.co.jp>
---
 drivers/pci/endpoint/functions/pci-epf-test.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/endpoint/functions/pci-epf-test.c b/drivers/pci/endpoint/functions/pci-epf-test.c
index 6952ee418622..23034f548c90 100644
--- a/drivers/pci/endpoint/functions/pci-epf-test.c
+++ b/drivers/pci/endpoint/functions/pci-epf-test.c
@@ -86,6 +86,7 @@ struct pci_epf_test {
 	bool			dma_private;
 	const struct pci_epc_features *epc_features;
 	struct pci_epf_bar	db_bar;
+	bool			db_irq_requested;
 	size_t			bar_size[PCI_STD_NUM_BARS];
 };
 
@@ -715,7 +716,10 @@ static void pci_epf_test_doorbell_cleanup(struct pci_epf_test *epf_test)
 	struct pci_epf_test_reg *reg = epf_test->reg[epf_test->test_reg_bar];
 	struct pci_epf *epf = epf_test->epf;
 
-	free_irq(epf->db_msg[0].virq, epf_test);
+	if (epf_test->db_irq_requested && epf->db_msg) {
+		free_irq(epf->db_msg[0].virq, epf_test);
+		epf_test->db_irq_requested = false;
+	}
 	reg->doorbell_bar = cpu_to_le32(NO_BAR);
 
 	pci_epf_free_doorbell(epf);
@@ -741,6 +745,8 @@ static void pci_epf_test_enable_doorbell(struct pci_epf_test *epf_test,
 	if (bar < BAR_0)
 		goto err_doorbell_cleanup;
 
+	epf_test->db_irq_requested = false;
+
 	ret = request_threaded_irq(epf->db_msg[0].virq, NULL,
 				   pci_epf_test_doorbell_handler, IRQF_ONESHOT,
 				   "pci-ep-test-doorbell", epf_test);
@@ -751,6 +757,7 @@ static void pci_epf_test_enable_doorbell(struct pci_epf_test *epf_test,
 		goto err_doorbell_cleanup;
 	}
 
+	epf_test->db_irq_requested = true;
 	reg->doorbell_data = cpu_to_le32(msg->data);
 	reg->doorbell_bar = cpu_to_le32(bar);
 
-- 
2.51.0


