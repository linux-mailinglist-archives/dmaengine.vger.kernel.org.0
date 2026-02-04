Return-Path: <dmaengine+bounces-8720-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oODOBaBfg2mJlQMAu9opvQ
	(envelope-from <dmaengine+bounces-8720-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Wed, 04 Feb 2026 16:02:56 +0100
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F763E7CCC
	for <lists+dmaengine@lfdr.de>; Wed, 04 Feb 2026 16:02:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7F9473083ACC
	for <lists+dmaengine@lfdr.de>; Wed,  4 Feb 2026 14:54:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CD1041C2EE;
	Wed,  4 Feb 2026 14:54:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="i+XQfidU"
X-Original-To: dmaengine@vger.kernel.org
Received: from TY3P286CU002.outbound.protection.outlook.com (mail-japaneastazon11020123.outbound.protection.outlook.com [52.101.229.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15EB841C2E2;
	Wed,  4 Feb 2026 14:54:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.229.123
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770216892; cv=fail; b=lk8UTN07iyrLQ7xkbFm3g3hbvc1iE4VjzKsju7g99nkmIICjuWjAwFKSFsMHFxzc3RA8KrVKfCejuK+mObvEtj8ex/oHHdQiD5xCFrNtN2k0I489nNMwZufn3/bJI5ne7wnuntRDbom6tbrxBkvyJT36SwdBP0UqMjZ61DpF1Zw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770216892; c=relaxed/simple;
	bh=51Qf6qtqpHPSrOevyQgT2E7D6WnkVcrLw44/aVXHoCc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=QXrVEmAVV5GHAlc5wDQve+0h17+u5AyoK2wUabNgPPJ/aSSBWUYKSVY0KB5PO+vhVKnC1L3OwU7kvT7Pn/60toBFBtZCzRlLf1cp3lR8c8u++p8pCNBLmXECz2eoOF2QpMeBv2na0HHBDN/YOe2+ANb8W+i0LFR5ke0fsg81LJE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=i+XQfidU; arc=fail smtp.client-ip=52.101.229.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Hj9Nz/AzEn7Thfw5e/j3b2rqoWA0yikcsD3+FSj8jrtmhxhhRzdeSLBZW3OR0dXLGVT79tb6iH6DSXnjq14BBgXee5lgz3enLh1m20p8QZfgufPjfux7fdDPDhTLymqDoSbBYBBj8ZSQ84u4cRY33YkFO30i4TwgpHOTnTFHRKKG4zgFCk4q8OxIs+hnZoU8XLoEIeAyx/eb08IfBt2QE5l/LFfGSOm0nCy6m0AsBdfySMUb1npXGM4AmHWB9bnZuOaCeC8o5bWtXpH2kJBxAQOEEcWeKtb91yKz2eJE457w1D/VwCfG3/tZFXmCvqlPY007pKLv7tsjzNdu+GrLyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dxSyS2mhCqhW3G6O9AwHIc0j2k4qcGaEtcjBNZM1SLE=;
 b=NZuHVD9IL+cNqxOYhmOL3SXqzTqEoBHPenaq/cTGSuRoLef0f/xJI50pR0d1Hh+obccgrYi9sZCc5Kf6GDQfGlR+MfFoR7DtZiy7bowXpquJbnC349Plh3uM5r3R5o7MimJ+IKSvmbwBN+tCsFILCkW4YwRnBUSCZ/hUIX9hZJl6uFcXsIKUsBxblDlhhTrdOqrrceRhpt4dOGLDf4HTS9WvM7Opkn+KwxUYepBm+vSV1LM9f2iYIDzqJzlFYqUe4bAy/Po0RET1qp/dV3WL+XpH4zlHrDxO1Kk0vmJOUOnD1y26VY7XZeObefKsp71BOiekaesJSm/i3BxRnP9crA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dxSyS2mhCqhW3G6O9AwHIc0j2k4qcGaEtcjBNZM1SLE=;
 b=i+XQfidU7mQAUMhDz3wZ5qMteWQ+6ypZpZ5VbECO6KQF5FXywfms70ynR948mipzWff+1M909o3YMyFzhWxjFkB+siSKABFZxIUBTnEpZn/wMLpgpJTrCCnBlb2ArpXO0A0GYp9WusSUVHsiVJ3mf3rJ0om1INyXIXt1xx54ZgE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:38f::10)
 by TYCP286MB2976.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:302::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.12; Wed, 4 Feb
 2026 14:54:48 +0000
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32]) by TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32%5]) with mapi id 15.20.9587.010; Wed, 4 Feb 2026
 14:54:48 +0000
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
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 01/11] dmaengine: Add hw_id to dma_slave_caps
Date: Wed,  4 Feb 2026 23:54:29 +0900
Message-ID: <20260204145440.950609-2-den@valinux.co.jp>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260204145440.950609-1-den@valinux.co.jp>
References: <20260204145440.950609-1-den@valinux.co.jp>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCP301CA0089.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:405:7b::11) To TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:38f::10)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY7P286MB7722:EE_|TYCP286MB2976:EE_
X-MS-Office365-Filtering-Correlation-Id: 3d1d9a18-9ff5-4a9c-259d-08de63fd578f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|10070799003|7416014|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?HMkk/bmXLxK3Y8HnOZHSQQykSFE3c2SYxcSapdq8MSJTJ+Nyp4s9/bOOj/yi?=
 =?us-ascii?Q?OM1mvP8VUqdhRsrW4xkIwKF/kYMb0mGucyhng2rjP6PAA9QVS1eJ8Oj/kHap?=
 =?us-ascii?Q?+fpMEGqgNJuvSwAHsqskRJiBR+jusfMEG1FxK4EesAW8jutFhkT8nSLJ3/Ny?=
 =?us-ascii?Q?aFT8+9wuWfsPrBTg42kInKPG/2LbMg4F0TxAGS7KbXDXCeoiBqQ3XZCOlPhJ?=
 =?us-ascii?Q?BzvnPtI1fKvrqZOIWVuq6nbN95lZbthGxr6N1/Z7aA6d66/SEzX2iyEQ9n5J?=
 =?us-ascii?Q?6brZw1pYjuTE0DaRtVSCfU7IcZ9v6IXCOc1j314KZggXwQX0tD3b9YXaGY6X?=
 =?us-ascii?Q?AYSC3+RgzsiIlBgCH9I9ZfMT+gpWa1+Ebm+woVTM+uOLcuPEoJZjlWN8jyR4?=
 =?us-ascii?Q?7EAyrMXaejDayg9EnXjtXwKfK1mjsGe/5aV1qcw0bLvcsZQ2HaQwPgtgxlBY?=
 =?us-ascii?Q?T5qnAM3LeuQF3D/eahuk0BxSUH39LRdlW3y1JysSG1XKaR/dysZ3msQCEozw?=
 =?us-ascii?Q?onsO6v2pProRydKV/c+cVx5iVPSxgKd89IaC/j2TqIZwz/ZcA9c/ykomklSF?=
 =?us-ascii?Q?HHSNKqSUApHeuQskqKGLjXHJzidsDtEcbOge7d1gBqVUqKda6/W8zF/lZPGr?=
 =?us-ascii?Q?iOGhK6+5oS2U7Jv4jO9Gg8y7VT2UwqNtz0p4dNekVGHdDknoMSPKMcsriSxi?=
 =?us-ascii?Q?h9RPzaMlj4C0LPdw3MvhiOSYG59NrZC+ybW/YTc/iht59/LgAl58d+jDIL56?=
 =?us-ascii?Q?PpewBpmK1+vfeGeWR/cvv1hWENdlCTRsL44JM13jZTcHExT9WwtxeUJTBqaR?=
 =?us-ascii?Q?OQsszMySQ/AGvWlYjPsUVnUZSiewSVRvpfHE59T/35Hgb8Cs7RTQhWerR0Jj?=
 =?us-ascii?Q?YGLnlTkbAFLUowzt7a7a+rTd415YRqwEgZgffX65+4NvUFB8h+cGWmU2/+LF?=
 =?us-ascii?Q?qiIAlZikgXd/Sexifvv0umGGuRcSO/bvvqRIl0H6ANZ2ILumdcZhb9MSoOfJ?=
 =?us-ascii?Q?EsTT8JxN1bY5DEqCqj2dgDNXDnYjSfhVpKuCcOqQyUT2W18Nay5aqg05KZE0?=
 =?us-ascii?Q?CJSYh6MWOt8lGOx5UetVC7GhnHKionssgsvFZ+1xG+r7cBMKzLv5fUbvjHEA?=
 =?us-ascii?Q?13peMXid/Iy0owQdbU3htmEqsBiygAYJiLXkKlijvFEO6G5rwCoqk/JSYdmu?=
 =?us-ascii?Q?vbAdlVS5aIO0zrbE83ZCgiuPkrXD5LWTtc/eJqGM9QE9kO+ZEPRG+kOaT2QE?=
 =?us-ascii?Q?Cmqt3ju4ILBwIYtZ3N0L6xVbno9/W4lML1o9RlU7dQZ56glrkwo+lFL1GS2q?=
 =?us-ascii?Q?R8AxjXw7Kv73Z7wFm2RbPGuOsAtfE+C1nJsbCKYwmqQcIUuYQ34JdttO56m3?=
 =?us-ascii?Q?VKzPGIjDmUc4KdvjAfFbMX0wUR6UT5cnyb4yESDelriCcGQWOxrFozU9yitd?=
 =?us-ascii?Q?1W+f4bE0kwM5Wz2Oy8TvwaGCp/ZC24Uj3Y+OB8IgwwqQf0RyeJGX0Vz2NDIZ?=
 =?us-ascii?Q?FqWhODUdE0q1xfC/ZfOV392Q2LbcBku/tvW8uA2mwFoq9sVxnTsDcRPXgqQl?=
 =?us-ascii?Q?wnLuaUCQqXnIm7Wy5fU=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(10070799003)(7416014)(376014)(366016);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?wn2CstZCh4l8XNxhXLSg51zOnPhlfC1+YcA+W9N8Ztm4U9KvGl2sIeJERAOh?=
 =?us-ascii?Q?xDqz7noVFRvO7IDCjc0Dp9pPjvlGx456pmhj6iveWZi02rRt78IzztDeic+9?=
 =?us-ascii?Q?JGcrxvsSm9uzAMedZys5qgkCxH8JsArtaGWqGkCPch63zHEObm9WBDP9iLlV?=
 =?us-ascii?Q?a0VKdHwJq6wr+7uyX0Yxgefq4egm+McDAEC3VhZOy0LVsY4kwnEv6KPTpwRV?=
 =?us-ascii?Q?j62P3Ef2ifJNwTTzUydhesrQDaIOljPOeuCF8vPSLNYpbaEssUmqgGJ5CcDI?=
 =?us-ascii?Q?KtuG3UiQtcOYe8oXtD7UlqfT5h6ef+QebnfvayKd1/TQJe4n4GvAyauIX0yk?=
 =?us-ascii?Q?GSrHiPOY3cWJqYNwG1R4tQAQDVtUXOMBpvAMLGTDA+ZhhexQEVgJDeRNLBZM?=
 =?us-ascii?Q?/fsZd3fYpOX7n2mRbMkpe+hrWLLJf8eL43Xo7UzNDT4I16iKhHTYfIZ2f3eH?=
 =?us-ascii?Q?qTCFWoSYRXvSrQssm9tOs1vQnCIHN8VgavdaWJJ/ROxP05kF+iXok9HiEaId?=
 =?us-ascii?Q?LWSwihiIIjhKPMAyzPoMpQza/XuROMucUY0acoVkiiR5nthxHcoLgbKd26CZ?=
 =?us-ascii?Q?PIX/sQcc098jr9/rIU+X+4T0yxbVqZgu0hur3NnFgzhmr6g/wQIo9YwoVHAR?=
 =?us-ascii?Q?CuRhyzyZFfZKiptS7R8LGxdoHss+TgdLSBTEmo8etkGBu4ykjCaSjQ9g9zM+?=
 =?us-ascii?Q?NZMUy0GHL4+rdneFJfy+onpf7mu781OrdALkG90Fw5ZUpSj0g8XJzP/K3AUx?=
 =?us-ascii?Q?xfSm9COW3LwTpqxvTv1wq8KxmB/xRhf+X+uzkfyd1cnv2XhYBoJydoLbOfLn?=
 =?us-ascii?Q?n97ZXJnwJrAl8Y1POCak6TtadUwFlz00xxGLwTWleEwI1WWX5w9cjGHKjKFO?=
 =?us-ascii?Q?yv4kKaOEsX2yxUpOhYLuIOjRt7txxQXfLV9gpDlbE9C1u8bfrXmJ6TT5MJWG?=
 =?us-ascii?Q?Nnhw5Gvkz89BZf/UK9Zo9i/z0smy7G0ZeOcQzz63VJK/GIpsVUQwqID/+gB4?=
 =?us-ascii?Q?AFOuo2TPSyaqYYaShJkC051G8MICU7vIcL/pAUq3eTMm9UHQEsft9vDQQ3PJ?=
 =?us-ascii?Q?tVHL5gmwVoiCff72nMY2pXeX4cq8pc63HufHCiRSLehXpdf8ykpmajHzP+tU?=
 =?us-ascii?Q?H/fnykr2ZDdW3uyoJIlr5JWQSvFCEBNJysqoLtDprQ3NDjtjxRvy7xM16xI+?=
 =?us-ascii?Q?jHyfjWbKyyOrP53+TMbXSwq5ORQpQ2vWt57DnoQTHl7ot8CykbA5mlVFx7A7?=
 =?us-ascii?Q?JrHKBDiunNl4EhXwxMHqe4BWNg1QW7jXFjkBtqbadeSmio194kvqbvXrWIGb?=
 =?us-ascii?Q?1Q9+H2FgEqdJoWbrT1esKXtJr8OB8n4yDnLBC3qJefgw6KitHiZTrws2t1c/?=
 =?us-ascii?Q?UpV0KCvMV4yzXw2r6k4KN+DTL95AuKw2nobYzr3rq3hurdQVmshBYcJ21GDf?=
 =?us-ascii?Q?b1bqEhLM/JwpxP8szQj0lrrBnz74vRd1cqmkYgGaXCJJMPkILokz44RKbuIu?=
 =?us-ascii?Q?Z0fc9yqWZm7TfbZeAzdF0V13qdkNJ9o40tzcsayyGeV4uhu7QUUvfJbYSc3e?=
 =?us-ascii?Q?IqeDMe9uSxHNErSH3MAe3CwZc6kIWFMFcICdibYHQZNH2BisIN/6IVgs6kxn?=
 =?us-ascii?Q?I2h30t3q1J3K68J4A0BwSn+Hvxzs6OF7jwo4opL/yOuyLn/X9lynd2fIhS52?=
 =?us-ascii?Q?QKwq0YmK32yDYYxCLJIKCFbuz7W6P/9ZTfbyDb3yQStc2xomDc292z35Bx4H?=
 =?us-ascii?Q?0x5ox3uMcf8c0oy/RILVq//8QI0NDG6AdqqM6ArudizdesROz3if?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: 3d1d9a18-9ff5-4a9c-259d-08de63fd578f
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Feb 2026 14:54:48.0507
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OuGdttuc+XBzVSjp/n7Lz0HNaVI0ghEABZJups5/pSJBR1+DBbfPHZvgLFzLamTE8GRPvnVXV4Ub/OGW3LtRqA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCP286MB2976
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[valinux.co.jp,none];
	R_DKIM_ALLOW(-0.20)[valinux.co.jp:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_NONE(0.00)[];
	TAGGED_FROM(0.00)[bounces-8720-lists,dmaengine=lfdr.de];
	FROM_NEQ_ENVFROM(0.00)[den@valinux.co.jp,dmaengine@vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[kernel.org,nxp.com,gmail.com,google.com];
	PRECEDENCE_BULK(0.00)[];
	DKIM_TRACE(0.00)[valinux.co.jp:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[dmaengine];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,valinux.co.jp:email,valinux.co.jp:dkim,valinux.co.jp:mid]
X-Rspamd-Queue-Id: 6F763E7CCC
X-Rspamd-Action: no action

Remote DMA users may need to map or otherwise correlate DMA resources on
a per-hardware-channel basis (e.g. DWC EP eDMA linked-list windows).
However, struct dma_chan does not expose a provider-defined hardware
channel identifier.

Add an optional dma_slave_caps.hw_id field to allow DMA engine drivers
to report a provider-specific hardware channel identifier to clients.
Initialize the field to -1 in dma_get_slave_caps() so drivers that do
not populate it continue to behave as before.

Signed-off-by: Koichiro Den <den@valinux.co.jp>
---
 drivers/dma/dmaengine.c   | 1 +
 include/linux/dmaengine.h | 2 ++
 2 files changed, 3 insertions(+)

diff --git a/drivers/dma/dmaengine.c b/drivers/dma/dmaengine.c
index ca13cd39330b..b544eb99359d 100644
--- a/drivers/dma/dmaengine.c
+++ b/drivers/dma/dmaengine.c
@@ -603,6 +603,7 @@ int dma_get_slave_caps(struct dma_chan *chan, struct dma_slave_caps *caps)
 	caps->cmd_pause = !!device->device_pause;
 	caps->cmd_resume = !!device->device_resume;
 	caps->cmd_terminate = !!device->device_terminate_all;
+	caps->hw_id = -1;
 
 	/*
 	 * DMA engine device might be configured with non-uniformly
diff --git a/include/linux/dmaengine.h b/include/linux/dmaengine.h
index 99efe2b9b4ea..71bc2674567f 100644
--- a/include/linux/dmaengine.h
+++ b/include/linux/dmaengine.h
@@ -507,6 +507,7 @@ enum dma_residue_granularity {
  * @residue_granularity: granularity of the reported transfer residue
  * @descriptor_reuse: if a descriptor can be reused by client and
  * resubmitted multiple times
+ * @hw_id: provider-specific hardware channel identifier (-1 if unknown)
  */
 struct dma_slave_caps {
 	u32 src_addr_widths;
@@ -520,6 +521,7 @@ struct dma_slave_caps {
 	bool cmd_terminate;
 	enum dma_residue_granularity residue_granularity;
 	bool descriptor_reuse;
+	int hw_id;
 };
 
 static inline const char *dma_chan_name(struct dma_chan *chan)
-- 
2.51.0


