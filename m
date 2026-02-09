Return-Path: <dmaengine+bounces-8829-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oDQfIBt/iWl2+AQAu9opvQ
	(envelope-from <dmaengine+bounces-8829-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Mon, 09 Feb 2026 07:30:51 +0100
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 213A910C141
	for <lists+dmaengine@lfdr.de>; Mon, 09 Feb 2026 07:30:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CF219301A720
	for <lists+dmaengine@lfdr.de>; Mon,  9 Feb 2026 06:30:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8835A31D38B;
	Mon,  9 Feb 2026 06:30:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="BPcRcIRm"
X-Original-To: dmaengine@vger.kernel.org
Received: from OS0P286CU010.outbound.protection.outlook.com (mail-japanwestazon11021104.outbound.protection.outlook.com [40.107.74.104])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F6CA31A808;
	Mon,  9 Feb 2026 06:30:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.74.104
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770618604; cv=fail; b=hTioQg0NK0mis/bE0hqwi8Warp3j/Lhzm5T6eIXE9h6/HacPFJ5lZu1MuGMbPzGPOijN22nphYFqLOFzt/uVK420tf1Yv4QyqP8bPwYeeVldNK6D4tiTV8DPULgA94QWaqt4Ff23F2Ub1Xmbg8XVYmD6pMDYDOi/uA6xX0RpiOQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770618604; c=relaxed/simple;
	bh=fTx60twlm8eOQQ0LDmn/cde81YfV1ISdp2/yz1EnxUQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Cs8VBhv/v/tpuH1X3clBGhiW0uyzqqvxG8CilkPpLYriIuMqOJlIS6hCUn+Mxyb4xq8uRhSBsa1Xa88G8MvUZeJ9saAGtvxYIGnKboxJQQAsggxpYgx6wHI1IPGqFyirb17v4gHZxg9JUfaaNZPf0rV4kzBDmpYI4EIOtITBpi4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=BPcRcIRm; arc=fail smtp.client-ip=40.107.74.104
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=f4qnd70agD/57vhRiGZniDD8bFbBJI060cOSpAckx342fNfWAmg/cMF6EMR51EojTsiLoyGdC+PY9XFyyPCswcsA8es6G96/XqmNo2Km7kMKd/4s6SjAGnqAxhn/bNHggpT9m9HW1MI/D8cDQ11cZiBUkz2kdsmykt3LDBaZqa1Mg0D5mabYADlHikr0yX28bpb3I7N6kIXTaCI1ozmwsMnRHKpnrucng/+moRaWAdTaYHMst0By3ACBeOW3NziNAVb7hKA/NCAr7QhZyfXTbxEz3DPuUUQSITsubfztOIykTPCPM0hiSfHWHci5q3WbTZVEeJOZVyui6Ik6JXxPig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=v8yWAfV8AJ5pPwl+Js3pT03l2aqXPjl9XVUFCNdR+xA=;
 b=WyWokjsWFewvGjKete8MIKlbPVaoFN6ixGW6nCNU8HClKivHrBDONeCRSh70tuItzNmU8KJWaM6uyJgAe63Vufqcrm8MQfOeedUWLYGL145Tm7b4P4dkeRuO4B+DBNPjYL/zSyKur+pFqiHXITE+tvOXA+8aFQp3Ez/yAKJ6xpXjJlft5ROWBeOfk3Gqwl7/XLpymFQlfgGMEFjWJEd6MWamWz7PpNewZwZgo3ruWTRaOY8zwojaCjs50c+SXzPUop0z4LEXpTtpsDprHVRZotG0RF7Qj+T9NSqX7TtM5lNgbUVWGBI8aeZyU//nEAQdPCnDVOZMD6ikc8Doqg0doQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=v8yWAfV8AJ5pPwl+Js3pT03l2aqXPjl9XVUFCNdR+xA=;
 b=BPcRcIRmZcA0f7b+EsGDGPJhvlqjmJpl0yCmjQo2eInJ/8SR3SXOPeC4WKhxCMhNHDa9Zk5DpqRsamrNUr7D8twodeMn9nveITdl/M/aSmYNDNOjgp/tOXZfaRSeCtBRl4ZVmjeI2VdaNpWzVpfbNeMbthhyRH+aGNoBY3ERKDg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:38f::10)
 by TYYP286MB4425.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:10b::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.17; Mon, 9 Feb
 2026 06:30:02 +0000
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32]) by TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32%5]) with mapi id 15.20.9587.017; Mon, 9 Feb 2026
 06:30:02 +0000
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
Subject: [PATCH v5 4/8] PCI: dwc: Record integrated eDMA register window
Date: Mon,  9 Feb 2026 15:29:47 +0900
Message-ID: <20260209062952.2049053-5-den@valinux.co.jp>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260209062952.2049053-1-den@valinux.co.jp>
References: <20260209062952.2049053-1-den@valinux.co.jp>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TY4PR01CA0117.jpnprd01.prod.outlook.com
 (2603:1096:405:379::18) To TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:38f::10)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY7P286MB7722:EE_|TYYP286MB4425:EE_
X-MS-Office365-Filtering-Correlation-Id: 9f920666-3448-4842-956b-08de67a4a811
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|366016|1800799024|10070799003|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?YzntVk2X3WthxpFuwDyu1+CELR7io2XhTm9PHTwDccYW2cGRiTJgzKJcePnY?=
 =?us-ascii?Q?Vy8OaPzw4MkacYFbE6x5DxmhbSo7ZWyn3bYTmsNVIPl+g7HR3Vwqw6jv6ROL?=
 =?us-ascii?Q?HlHIT+kvKYaqLYal48fbk5MfJm3J0kxdTWCyTYXhBIrcF6Ex8JI8X3qFQlRd?=
 =?us-ascii?Q?66UdX9OSrfErxnPCh0iyigG8ny5UBGgD65OHrhk6ASwAjeZO+DopE6IK+IGH?=
 =?us-ascii?Q?71TrNASMh/tKlgJlUNPzH50zIjqKJqGpKu6kgnQ7+RWNTpNDjNhLUueZqPGv?=
 =?us-ascii?Q?6al3JQV38PMoQ+HltS8fuu3ijWzmNBDlATqtpnWn/OtxQKbfVnL3ab1U++Io?=
 =?us-ascii?Q?aEdRfio07Rzf7n3q0cKSql+h+a6+Shb5wIzlDhBtMoE8X9Xfzl0SkwUBln9V?=
 =?us-ascii?Q?cLy9S0SYiDdAsfJYh+JAlElqgqkiUGrmMD0imOSLi07LpIrWwqZvR6qxbryM?=
 =?us-ascii?Q?p/xqfUp78nNEL4rO8MdQ+Sa8++HdYcAOUdZ0qyvnldTwsxavUIEJ4ovvgCcv?=
 =?us-ascii?Q?gGYXOfeShdMQ/IRB8ff2V9VDz5KoW8ezBuZnrOASIlssWqzglSwpUD0yhCYf?=
 =?us-ascii?Q?x9biyVwbvVBC++uPbQ9i6hwCX+pm2UypcwQnO+0Mxiyjz2OItWR91Sm4u8gK?=
 =?us-ascii?Q?QdAZkS/b1D8FV/pMdYYYENUfzF/myinXEDzQmbpwMHYIdEXF8QFwc9Ur6mWB?=
 =?us-ascii?Q?brRDxl+zZd++VUxfeQrQMMUqsKjcChqfwcfEIe1E2TECYDGlDMizZg7Dd0jt?=
 =?us-ascii?Q?yIgGx7ZoZj39mnAvn6XC/5NftyB1hsA2XJElpTvy8WtSogPbzYvFqSJJxzXq?=
 =?us-ascii?Q?ja6WN4OTggzJ6dJ/1ZYePMa6PPYqbcjB21/4YgaWIW23ZgCCmDlKKvBib404?=
 =?us-ascii?Q?5WCJrmQmstJHJz4RaYpAmWxgrHjCreoVvWdCqKiKvjSmAw2Bqkjye9D5v/Tp?=
 =?us-ascii?Q?W80/ZotZ6fAzjX57Fe9fPje93Yi/30auXwUS9bt5x2bG4KWA8n0zf58gxHy/?=
 =?us-ascii?Q?9MXmYmWH1EsKoNY6KUC++N+4upMIMWwMjgCtzfm8CaX8EGGFg1Gm9wXJ90XP?=
 =?us-ascii?Q?kjrRxNmtjwLoYj9sXPKNPP6NgWphU6xxi12bwze5PD5/2SgU/zJeu7gJdrGq?=
 =?us-ascii?Q?i+R45/kvq3xfCgIaocISH748t3VsNTs5tR3xUasroUwag1yFEOvjtOLJcszo?=
 =?us-ascii?Q?pchYwcO+Pl9WQE1RIH4Fa/YIB8jUohMV9Js0TrAyIPetTsVe/eiIgR4lduty?=
 =?us-ascii?Q?8973blMTpgs8PDr39sVdf3Toclk64k0IjrKo3qIjfJGf02IhfMMco5Bndgke?=
 =?us-ascii?Q?S+9xndCxD8LoQnvEnEGoIzv/4/Uck936AU1w2mMDG981zKPVRKgB50dH0D8o?=
 =?us-ascii?Q?xaJDQZ+AxaKX7Pekegoyo0vFtcZ469Hb5cTIX+EFTUa08dNOX33Sk2GC3LjN?=
 =?us-ascii?Q?kEUXVLcya/GVBS7MsMWd1ZGabP7r7eivrkMj92vLFdfhWJZLGAcTlL/DeJ7p?=
 =?us-ascii?Q?n/lp+ZzFTYmA1Cjv2+mmMiU9wUV0qdrba0qW//1Ao7C5UXlh5rnuwWoP0Kfg?=
 =?us-ascii?Q?GRaMpZPj45f/ghyk45pcw+nHHxvIzrhq09vWlqC1M/rfSedLBLCaZFT7HHP/?=
 =?us-ascii?Q?YA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(10070799003)(921020);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?09DRxBnLFLyyDwsLh534ikocIbyg2PnVkjVdtpPH7T/QGNH3ngy7chrYt1+v?=
 =?us-ascii?Q?4Rg+62POu5n4S1oMwdhcCZFbd/lwFQaf3VHcwTvFFWsHtqhGFAjDKyJ0ns83?=
 =?us-ascii?Q?uuUvgSnTkyd5c0NhQJ92uQ8AhoxAPXUqPezNMVGy1DNgRrvlp1sw35oDh1Q1?=
 =?us-ascii?Q?k/U5sd8Y6sj1mUHdZCKAM6KwnIdt06Mp6cPbK0BGkq+AqvPdocbq2O9OJBkM?=
 =?us-ascii?Q?k9CB8B7fcW8wh8fdUUDXqxfFXqzwF41PEFmrQWg0wNFbn7eXYg8NKOzb6uMB?=
 =?us-ascii?Q?rI4Tm2b3qXuQXtGaFVyxcOcSi6FxzwbsLQimvrTs5J8tRtU+y7KZxbNF3pC9?=
 =?us-ascii?Q?oB8rumpbCvPms4tcT5sfIJ5tDmmuD6xFkwr55seMY5tWoSg5pVbs4dUpPcbh?=
 =?us-ascii?Q?v3Q82c5NN2cnsS7elTKbP6dlzeCtMQWOi7Ho8j8LdtXEgSQl5zBnCUsOGlpG?=
 =?us-ascii?Q?fJTTKjExdwgUmAhQN5/tRg/Y5HJCFKSQtixZWqEVihZdFd6iLDeK3/+ov199?=
 =?us-ascii?Q?neiUWu9AETC2x8jbpvaK1lK0JuROR22m1+AiOHkvMh9qHXnxJFPzhNJDTahO?=
 =?us-ascii?Q?H9pBtNNM12TjoqJnMIsjRINeB+UCCS1LByoMeKXuV+2WO5jZFgCLQ/gP5rS5?=
 =?us-ascii?Q?WLxSYc/9pUUvfuBJfq6wlOZ2fE1b3bS34lnV6n5qVTP9fPQiF6CeV8PRRqT5?=
 =?us-ascii?Q?TyvjCrMbeVbFoqW26nVlOZZLwrOP+w2u6tCgj/z8h0W7cOpq+NKXsMtjCwrc?=
 =?us-ascii?Q?cdBJAO20EebI1c0zm3u8dMl/wv5IA7uF8vHG1aCI+3BymGQ2Ll4k4ywlh9sq?=
 =?us-ascii?Q?BQZxRC4Y5XafLNatwFlV4NJVF7hLfGwiC2+PHe7ztyxPmN3AX0UErelv6dqi?=
 =?us-ascii?Q?LKrV40/sxskqFq7OgEfCtlDkNbitlfiMjbxTO5G+tnhzN6luTFJfj9nKy/XH?=
 =?us-ascii?Q?Qqx4sB7PIEUrfhRPcTELlF4mP4JM5MKyKzcBnnKu14ZNHm9BRtKcAIJXQwV7?=
 =?us-ascii?Q?3z71EOAwU04pHByC1I0lxIFssWzmC7icEv+ubfjbBLl1S3MVU/I+YTyeLMYS?=
 =?us-ascii?Q?eZtZ/f0aZznFZPV4yLW7K2p8sIkpFkCYxeVLqhvKm6/+ohv1dLKbarorMdqU?=
 =?us-ascii?Q?UzF2eet1xFTVmu3S1xnDBZOuFYS0iGDEomsiwdcCCPSD8ZU0BCpsKcuOW57Y?=
 =?us-ascii?Q?20JSIyQN6vl0gFDD/Nm5F4GbI5lTEeNzTBmeLlkjGTaW5Gd7TSAjci9cyezC?=
 =?us-ascii?Q?22ynzqWKROnN5N3SLgTeOvaMI1h6ISWZY506KxBlB3LzXF+pYedC2dPHunw9?=
 =?us-ascii?Q?YAjYxYd9phs5tZxKLwDYO+oGCSziWWxHfQxcJlxPdCxQhbHsHY6b63DjsEmZ?=
 =?us-ascii?Q?6QG0Usj/vhPgdphB5+AcRl8hBTlWqcImxanUFiVmwmwL3ABArZfcwPupAB9F?=
 =?us-ascii?Q?oHG3nh6P2584LAKY7TuyRgZjF5+npGiG0PnV86yrMlGSyjkfrubQRNmh/WrS?=
 =?us-ascii?Q?CX22tvrVEQQMnLfvr4GsQuc2WKfku68ty82+k2bcPzSQihpRUaunNJb7apvi?=
 =?us-ascii?Q?Voz2Hgjh7DTqaNZY67IhYjYgnXTXZyvp0lUDdOuduKPuta9HlN0nKuqKA10n?=
 =?us-ascii?Q?rrx/zIQEiNiHyBeNGhumQeumkWHDi5Qdi0uzt3ELlRzfifI080nfOdNVxaRx?=
 =?us-ascii?Q?Gp7qaMxguI1cyrj9BlOiHTA7/8pt+FyAXtJ0yF/2cBogh4e6b2gi51LNU5Dp?=
 =?us-ascii?Q?33zxmFlI8lciQig0aaNy2sW34hICA3Id1PlRvbVoKMGIEUTj+1Jr?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: 9f920666-3448-4842-956b-08de67a4a811
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Feb 2026 06:30:02.5686
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3oKEYZYvOIojwpdSX3KcPLVsH4xLzf+MmjTMdSr6AM7gYEbMDhbE4j0h/WXhPfKj03dSvPlKsKDIUzD+OoCFQQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYYP286MB4425
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[valinux.co.jp,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[valinux.co.jp:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-8829-lists,dmaengine=lfdr.de];
	FREEMAIL_TO(0.00)[kernel.org,nxp.com,gmail.com,google.com,kudzu.us];
	DKIM_TRACE(0.00)[valinux.co.jp:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCPT_COUNT_TWELVE(0.00)[17];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[den@valinux.co.jp,dmaengine@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	NEURAL_HAM(-0.00)[-0.998];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[dmaengine];
	DBL_BLOCKED_OPENRESOLVER(0.00)[valinux.co.jp:email,valinux.co.jp:dkim,valinux.co.jp:mid,nxp.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 213A910C141
X-Rspamd-Action: no action

Some DesignWare PCIe controllers integrate an eDMA block whose registers
are located in a dedicated register window. Endpoint function drivers
may need the physical base and size of this window to map/expose it to a
peer.

Record the physical base and size of the integrated eDMA register window
in struct dw_pcie.

Reviewed-by: Frank Li <Frank.Li@nxp.com>
Signed-off-by: Koichiro Den <den@valinux.co.jp>
---
 drivers/pci/controller/dwc/pcie-designware.c | 4 ++++
 drivers/pci/controller/dwc/pcie-designware.h | 2 ++
 2 files changed, 6 insertions(+)

diff --git a/drivers/pci/controller/dwc/pcie-designware.c b/drivers/pci/controller/dwc/pcie-designware.c
index 5741c09dde7f..f82ed189f6ae 100644
--- a/drivers/pci/controller/dwc/pcie-designware.c
+++ b/drivers/pci/controller/dwc/pcie-designware.c
@@ -162,8 +162,12 @@ int dw_pcie_get_resources(struct dw_pcie *pci)
 			pci->edma.reg_base = devm_ioremap_resource(pci->dev, res);
 			if (IS_ERR(pci->edma.reg_base))
 				return PTR_ERR(pci->edma.reg_base);
+			pci->edma_reg_phys = res->start;
+			pci->edma_reg_size = resource_size(res);
 		} else if (pci->atu_size >= 2 * DEFAULT_DBI_DMA_OFFSET) {
 			pci->edma.reg_base = pci->atu_base + DEFAULT_DBI_DMA_OFFSET;
+			pci->edma_reg_phys = pci->atu_phys_addr + DEFAULT_DBI_DMA_OFFSET;
+			pci->edma_reg_size = pci->atu_size - DEFAULT_DBI_DMA_OFFSET;
 		}
 	}
 
diff --git a/drivers/pci/controller/dwc/pcie-designware.h b/drivers/pci/controller/dwc/pcie-designware.h
index 43d7606bc987..88e4a9e514e8 100644
--- a/drivers/pci/controller/dwc/pcie-designware.h
+++ b/drivers/pci/controller/dwc/pcie-designware.h
@@ -542,6 +542,8 @@ struct dw_pcie {
 	int			max_link_speed;
 	u8			n_fts[2];
 	struct dw_edma_chip	edma;
+	phys_addr_t		edma_reg_phys;
+	resource_size_t		edma_reg_size;
 	bool			l1ss_support;	/* L1 PM Substates support */
 	struct clk_bulk_data	app_clks[DW_PCIE_NUM_APP_CLKS];
 	struct clk_bulk_data	core_clks[DW_PCIE_NUM_CORE_CLKS];
-- 
2.51.0


