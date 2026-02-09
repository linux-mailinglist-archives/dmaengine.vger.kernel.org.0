Return-Path: <dmaengine+bounces-8833-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yDfqBot/iWlx+AQAu9opvQ
	(envelope-from <dmaengine+bounces-8833-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Mon, 09 Feb 2026 07:32:43 +0100
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 34B5B10C1D6
	for <lists+dmaengine@lfdr.de>; Mon, 09 Feb 2026 07:32:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CCCAC3037140
	for <lists+dmaengine@lfdr.de>; Mon,  9 Feb 2026 06:30:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91B8732B98C;
	Mon,  9 Feb 2026 06:30:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="lLGrPLGj"
X-Original-To: dmaengine@vger.kernel.org
Received: from OS0P286CU010.outbound.protection.outlook.com (mail-japanwestazon11021075.outbound.protection.outlook.com [40.107.74.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A817329C70;
	Mon,  9 Feb 2026 06:30:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.74.75
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770618607; cv=fail; b=sweDVDpez+3NSWs5b88SpMOD6+YchdP/pBG32DuE8aAhjZj8BLyY7iub32V+QptEdA5f+gziImMqgd8LXhuAlUUmGX65RyBuo8YHHD71azmSgPrN9sUNLnB5dqxsQlabQDmTatROb9aaHmM/SVd1Cpv5ZxqPbIjmO3P9Ni42N2g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770618607; c=relaxed/simple;
	bh=a+Si3byFhAbFNwm6vIGylH4T6U5kBsgAetdVIMTYl0Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=sLGlZ7PZ8Jla0b75CGGUUopyPs7is/4f64pcudsRQeMuDTszYyLyaPkPMrTzIPjuWJK5Ee5H/x8CETXSyurKq7fYc6xO7cDtOk3lAJZ/lGqvSdi1lHfBFL4eIeaa+0QPWC1lDbmPhq5lOB7SeI5acs6mnJ6sasvUH3e2A2dmeEU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=lLGrPLGj; arc=fail smtp.client-ip=40.107.74.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tTZWe7MKLbRc2au1Rh/0SCJ5+QutHRjULEiBPPWdWBzFYEFRmBDEbA5nge/EI9+bLUTWJcssSbl7j8Hoq4xWhsaCthVWfXZjqPydtIMFCp1EyUC/y/qJa9YRnuxKqtW3/FIeDztUIux/hCGNGKuKZd5WuaOFmTscb396Zsahvbx4o0sEWgWeaGpKEpuhDXvlZrI1k9vOmfgrnEs3wdBUt5ClNRrfLhSXFs5g+PsACf26dCBfKiLX+udPpaK1NmVg7svvKSGzYZlqrPdLaq1AMyHd8kv8NkhjOUaea7+E7lKVrlXDnXeUx3CL8ix9Jdl6notRsrormzNmieW3Y0BSvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iUEjAzmRjNkLbrKJXwiXFi/PoiRu0jia8RIZPv1V3eI=;
 b=lJU1v5D/JA7L4iwSf+Ao/gs6DT/a2TuWAEXcWQ9n+4tPfySu8bK/Z3NgE61UWsz0OpOeuVMf4+P7+3+ImgzdwUjvVf2K6tQZ6qKQcLeX2QBngLl+tbny1ElRX7Ptx8+HO/9JxQ31Y16TMBVexOE4lvPGt4GmYZ08iWqtGUDWIkPIVMpgFElebUIcMgIcgnceV3j/JEYGrsL2iEMI7iYC9qcTvYjpIauZS46e6qCwLfv1FrLV216b4Ur5qrICxcQtbqdIBI6OJenjATvAciaAdGC/jl6rNWj+fqS8beO9fVAYFdPF6b4bR5PM8qcmgx76SpNluPNuAVKbH2n9S9cJkw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iUEjAzmRjNkLbrKJXwiXFi/PoiRu0jia8RIZPv1V3eI=;
 b=lLGrPLGjupl4EuRKnsAzsHgYgZh+7ncIgWHVOFvymvM5lkC53o46c7UPht/JQdSM7tp0vCXwrAkz8Q8SQgUTSH+5gGBonODeKfYP1+AE6Zgh+kKpp5wo3O3rV37wraU+8iXjvkzCR/u6Xwys8wJF4jyuISYutvYg4Jk9J2KQd/0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:38f::10)
 by TYYP286MB4425.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:10b::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.17; Mon, 9 Feb
 2026 06:30:06 +0000
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32]) by TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32%5]) with mapi id 15.20.9587.017; Mon, 9 Feb 2026
 06:30:06 +0000
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
Subject: [PATCH v5 8/8] PCI: endpoint: pci-ep-msi: Add embedded doorbell fallback
Date: Mon,  9 Feb 2026 15:29:51 +0900
Message-ID: <20260209062952.2049053-9-den@valinux.co.jp>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260209062952.2049053-1-den@valinux.co.jp>
References: <20260209062952.2049053-1-den@valinux.co.jp>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCP286CA0015.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:26c::19) To TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:38f::10)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY7P286MB7722:EE_|TYYP286MB4425:EE_
X-MS-Office365-Filtering-Correlation-Id: 5755ddb5-1371-454e-406f-08de67a4aa1c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|366016|1800799024|10070799003|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?y5VY2b5RTIKJA91iaxTjGkRm0BP8V1wtVkLZToyQgy6zYIeR/LPPEGDh55Yi?=
 =?us-ascii?Q?N0VIutqIUuEwBtaGPiVOn0LoC3lkHLr+wu5tNSTOxGIVcqW3nN97vqooex0m?=
 =?us-ascii?Q?rENv5lHgIbp56O3E5CVEJD24PVX2jrbhcU+sxqqdyPOSaHZGpoHKGRtjewB9?=
 =?us-ascii?Q?CMKPRumRjxTpS786/FLPCgmNhmMMOZqnpld0N8EUkgJd4hDjSdCiMbqlGL1p?=
 =?us-ascii?Q?F1ir/oQVIgirpKZ2M9uoetAjcJvwYhCvFulGjLMyHoofeXFZQKLL1SaDXZBw?=
 =?us-ascii?Q?rRuTD8TpE7WUZvbmPVeDGHkqlmw0eR1bqmteUfxxkn6U3QHXFU4dfYltVCId?=
 =?us-ascii?Q?1OL7h0x0x6WNB08jPDktNTJngk9RyKTpELGOgT908eNcWUG42jtiAq4rcN8D?=
 =?us-ascii?Q?bXG7t6AQVXk+4ZpwMBdoNr7era/H3h5v3Aqk6mRxAd5OG1JlvWt0xfnUNd3+?=
 =?us-ascii?Q?8ce9Hu78hR43qYegAyWks0wxal1b36G2TcCyWCtJBp3oeekE2igVufEOfsWc?=
 =?us-ascii?Q?6lKLL7on/x76w+litPGuEjHnRzeaH0XT/8GNfJAGNApMN2VDc8pThmNHxdb8?=
 =?us-ascii?Q?UmouuOT+WWqQ3sN+guyxxM7zak91d9QsrYOfB8o4xWwZlW5X5yUKGVYdHWDW?=
 =?us-ascii?Q?pswJ0EvK7I/vyFMPUq4QVhHPvUE7qcHc/o0prB4GyFyBR148Cxe1twjZVswi?=
 =?us-ascii?Q?0Ihz0NonsVT0CpAECgIHwHoMg0Z8CdGddPiI5u4zO5Yf1kNQ/R9vo29Iar66?=
 =?us-ascii?Q?lG/C1aj5RrOhGrGUrTICsPhCUOxVFe3C7AGxHH3hlykIaytk/iye5Uc59/UY?=
 =?us-ascii?Q?xV4AbOxl2m5F6m06mVFw1+N/qM2QXwLzr2jukGEQsnk/YN00GJZ8M/ZMULXp?=
 =?us-ascii?Q?Wh64IUUg8nAkeBzpDoLSNGAPHPf2N1OPDjtuEhY4NJyIjxCQKm5SU/nxAw6/?=
 =?us-ascii?Q?d+ZmhKOa2HPCe2EKtYGisTRRhQfIwChjMFN7TN408EEBb2Gmy39fMgZhDT5e?=
 =?us-ascii?Q?PdmVMMhMl9f+ahdgLzYDbvoy/7hZSUvK3kM+0nkx/217jsRabIiWIzWDo0BV?=
 =?us-ascii?Q?wqF7GzIR3DE4qqw5aBAwOgQmv/wkP4Qf2nlcuV9zfAMnh8c97jBrKeCQnFiF?=
 =?us-ascii?Q?wt1uFaJOAoxMu/cgDh9gpl9i7cJQ8iylVcUiIn+tr3FQwTH5fR2EUHlANXxN?=
 =?us-ascii?Q?48iwSWQQxiXlnBI50BJOQslSFNwWJ6Oq1SslXVg3tIE0nJqwdko8dJHBA2dA?=
 =?us-ascii?Q?Ok0oq+4wq6SPdneYE5XJjzqwQouPvyuc1ClW0uNrgVUeohnuZO9cgFPm01qM?=
 =?us-ascii?Q?OhvYimsf3+h2XUjHyGr6CF4eZI7aQBJ1MrmwfiuH0TAqLfg7eCSM5Hf8lEnq?=
 =?us-ascii?Q?nt4VSYAYYDPUSKBVZ2zem3ZEZpuQi9WiNuq5zRHFWOgrBZXztOXqwYFarx4E?=
 =?us-ascii?Q?hEz1eMw49/bQSeU3Y0DAEFEyUqpMWFiOoEplEdDMscAlHbBUJwAJIJYtl6x7?=
 =?us-ascii?Q?VS3rpilW03wVfYoydgBSO7to+WsP1Jfh3/zcNs0rUEI2mLHZwHYe06kdS1Jx?=
 =?us-ascii?Q?NASI93YqcL3cx3IiuJa6nfxA+jQEWW5HIKsPYZd9W15m15P9+nZeO2iqf8wV?=
 =?us-ascii?Q?pg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(10070799003)(921020);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?cJoEDO9BvN0XYU1PcFs9/jVRwbKUSF5ByJXY3IoktVODZar9F4GmXYo7U22z?=
 =?us-ascii?Q?NkzCNj8v6Jmu3S4apR2cBp4klI1pvkDbA7Lw40L6DzYhpF9jZPtmzF0fbC/X?=
 =?us-ascii?Q?uYlflVYNdau/oHFwPHAR/Zdyy9JXth/PNcWOxpI7BPK/8ffyt0Yrp8CM5XrY?=
 =?us-ascii?Q?uXzmWYoWbvSPlfNuobwO858cv4NIQqL+WOTz+Ksbm/qJgIDb3+hmIpzn6nvD?=
 =?us-ascii?Q?DfCryw5X35DsGcjwX/4nb6vyVjmVOhLzjZlHBtiODCpbzO/KsbNIbKGj+uoL?=
 =?us-ascii?Q?VW1XuiurUwo/UR0FXIGaWaWLzWfR0ilJDrTj+xNd0wtDGG9YudkzxLJkDroS?=
 =?us-ascii?Q?42riBRTqwPbprWb8XzbJ7M9/NiV57i4u69dsS/7rtSjGtGc/7q4fo3qx/4gv?=
 =?us-ascii?Q?+U4dpe+1DCDPK8z9lnaSLVmlMzeuSFoHeO16YG8L6W908k/zlgtj9YY0bXrm?=
 =?us-ascii?Q?yypsiQkF3BzeX+TpMeNr/t4rRoJzXWRZUO6R87X0Esax8V3f3ibuxPWb0vb7?=
 =?us-ascii?Q?qFVwAKEUDjYQYc0CdA5C1PA+hoWcb6npMoIfRZ793VJRDFVn10I7TwWaYdPV?=
 =?us-ascii?Q?yf35+Xgj6CBW5i3ZuEOdjiWgemWt5lmAb+e6zBllkDwZS9UpcTFGcTRUU2zK?=
 =?us-ascii?Q?fazzAwVXxwciM5V/lS3FN6rZ8JHIZSZfBmCxDKtnB1YEW7aGc1X3AgDmK4E3?=
 =?us-ascii?Q?qwwoOtCH6xDjz2Teke/jpkfPybGS4O0s7HL5YFqxw9MGm4DiwUrzRoDqky9m?=
 =?us-ascii?Q?K5vfBaqVGTP5rZAcBQAnKbNsRWxq3WEkiOxubWBBd6yhiZBrF+uBkt9X2yph?=
 =?us-ascii?Q?jus19k8OXP7A1o8HhbzoPzcCdV5ArXV+2K9w63ugW6A7QJvrl1X+5jMdAXB/?=
 =?us-ascii?Q?Vkk3rAtHZwwIIJJeD/UZAZ8m0xkc0jFU71EsgySFjrU1qupqGj8xz1yrp/kB?=
 =?us-ascii?Q?F2Ajv+3ldu+SsxJsrZNBZCh59i4DrTCC+LdX/F8441sQHJIuYSyL0IpXq9/4?=
 =?us-ascii?Q?tyjiSiaQ8ArJtu6Lv0HSrWp1rj4m9Pd9wjW4cIeob2QOCBQqZMcvh/LYnJLe?=
 =?us-ascii?Q?XtqiNznd71mj+f+rlAjvB5Qj75k6sXoNJkqg9Nw+AHIs8vOtNgvCldNh618M?=
 =?us-ascii?Q?7Sjy4Gkb2td0smcVmgw+w6fMWhNmGVh40/shRoEqrGcoBsW6+hyMhNEQVATP?=
 =?us-ascii?Q?GVvh89P1plscqQsmYYDBtMp8lZ1CSKIN0McIv6LQNtFGeqR3+/sfaKHwzZN7?=
 =?us-ascii?Q?nNRAv7A9kH1hAPCg9i9T+K1PvbBYkRhKHePfla+vOUXhpWg6aiG+2eICt+nA?=
 =?us-ascii?Q?DawP1aRLkD6eKLzYXMqtnmyMW/FZy3/IUzumFqxBwEmo+VAxZUhlBhjJ7cnZ?=
 =?us-ascii?Q?vvFqrLaX/4knTHArO6rpBJuHarQtTe2RH6KHfup+VsDBHAYG5o/ZO0mvgaK+?=
 =?us-ascii?Q?m6aUdDskHABZiBZGah09HKBkbQwDig8zAikZaxyLCzb2h63rE9iWBBbX4d03?=
 =?us-ascii?Q?/ZDu5pxv75xW9HsOJUNWhcRZiyPmz7opj5pbqp5aLO93YSW/dJ7GhDS45urN?=
 =?us-ascii?Q?tVv68Hz3dgx1aHSycn/AsydKBNEOdUO9jkIzlr9O7JnV1g73yGVs/8rop4kw?=
 =?us-ascii?Q?o9KbS/3ICXAW37OOpudcYbYiWkgynL5kUvaZXzjADUDyKK9MNW4lcmJD2CSt?=
 =?us-ascii?Q?Cimu/y05zAparI65bHCxlHfqjLBhmbUcV3XJ90xt2ci4ot7x/c5lPml6i2kL?=
 =?us-ascii?Q?1ZPR7dSDJzL2e1sZVSwMKvRGYjWKjI8LNuO7cA+oUm4UuRLjr2rz?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: 5755ddb5-1371-454e-406f-08de67a4aa1c
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Feb 2026 06:30:06.0095
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ayi/qmZ4PnV9NaCq6V/UD4hu/oxUXgCys+lW0Z2UL1KuK1Q+uNOjzP/EIHY9Co018cHWbBP7JtVDxuU/j8nXfw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYYP286MB4425
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[valinux.co.jp,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[valinux.co.jp:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-8833-lists,dmaengine=lfdr.de];
	FREEMAIL_TO(0.00)[kernel.org,nxp.com,gmail.com,google.com,kudzu.us];
	DKIM_TRACE(0.00)[valinux.co.jp:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCPT_COUNT_TWELVE(0.00)[17];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[den@valinux.co.jp,dmaengine@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	NEURAL_HAM(-0.00)[-0.998];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[dmaengine];
	DBL_BLOCKED_OPENRESOLVER(0.00)[valinux.co.jp:email,valinux.co.jp:dkim,valinux.co.jp:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 34B5B10C1D6
X-Rspamd-Action: no action

pci_epf_alloc_doorbell() currently allocates MSI-backed doorbells using
the MSI domain returned by of_msi_map_get_device_domain(...,
DOMAIN_BUS_PLATFORM_MSI). On platforms where such an MSI irq domain is
not available, EPF drivers cannot provide doorbells to the RC. Even if
it's available and MSI device domain successfully created, the write
into the message address via BAR inbound mapping might not work for
platform-specific reasons (e.g. write into GITS_TRANSLATOR via iATU IB
mapping does not reach ITS at least on R-Car Gen4 Spider).

Add an "embedded (DMA) doorbell" fallback path that uses EPC-provided
auxiliary resources to build doorbell address/data pairs backed by a
platform device MMIO region (e.g. dw-edma) and a shared platform IRQ.

To let EPF drivers request interrupts correctly, extend struct
pci_epf_doorbell_msg with the doorbell type and required IRQ request
flags. Update pci-epf-test to handle shared IRQ constraints by using a
trivial primary handler to wake the threaded handler, and update
pci-epf-vntb to use the required irq_flags.

Signed-off-by: Koichiro Den <den@valinux.co.jp>
---
 drivers/pci/endpoint/functions/pci-epf-test.c |  29 +++-
 drivers/pci/endpoint/functions/pci-epf-vntb.c |   3 +-
 drivers/pci/endpoint/pci-ep-msi.c             | 140 ++++++++++++++++--
 include/linux/pci-epf.h                       |  17 ++-
 4 files changed, 171 insertions(+), 18 deletions(-)

diff --git a/drivers/pci/endpoint/functions/pci-epf-test.c b/drivers/pci/endpoint/functions/pci-epf-test.c
index 23034f548c90..2f3b2e6a3e29 100644
--- a/drivers/pci/endpoint/functions/pci-epf-test.c
+++ b/drivers/pci/endpoint/functions/pci-epf-test.c
@@ -711,6 +711,26 @@ static irqreturn_t pci_epf_test_doorbell_handler(int irq, void *data)
 	return IRQ_HANDLED;
 }
 
+/*
+ * Embedded doorbell fallback uses a platform IRQ which is already owned by a
+ * platform driver (e.g. dw-edma) and therefore must be requested IRQF_SHARED.
+ * We cannot add IRQF_ONESHOT here because shared IRQ handlers must agree on
+ * IRQF_ONESHOT.
+ *
+ * request_threaded_irq() with handler == NULL would be rejected for !ONESHOT
+ * because the default primary handler only wakes the thread and does not
+ * mask/ack the interrupt, which can livelock on level-triggered IRQs.
+ *
+ * In the embedded doorbell fallback, the IRQ owner is responsible for
+ * acknowledging/deasserting the interrupt source in hardirq context before the
+ * IRQ line is unmasked. Therefore this driver only needs a trivial primary
+ * handler to wake the threaded handler.
+ */
+static irqreturn_t pci_epf_test_doorbell_primary(int irq, void *data)
+{
+	return IRQ_WAKE_THREAD;
+}
+
 static void pci_epf_test_doorbell_cleanup(struct pci_epf_test *epf_test)
 {
 	struct pci_epf_test_reg *reg = epf_test->reg[epf_test->test_reg_bar];
@@ -731,6 +751,7 @@ static void pci_epf_test_enable_doorbell(struct pci_epf_test *epf_test,
 	u32 status = le32_to_cpu(reg->status);
 	struct pci_epf *epf = epf_test->epf;
 	struct pci_epc *epc = epf->epc;
+	unsigned long irq_flags;
 	struct msi_msg *msg;
 	enum pci_barno bar;
 	size_t offset;
@@ -745,10 +766,14 @@ static void pci_epf_test_enable_doorbell(struct pci_epf_test *epf_test,
 	if (bar < BAR_0)
 		goto err_doorbell_cleanup;
 
+	irq_flags = epf->db_msg[0].irq_flags;
+	if (!(irq_flags & IRQF_SHARED))
+		irq_flags |= IRQF_ONESHOT;
 	epf_test->db_irq_requested = false;
 
-	ret = request_threaded_irq(epf->db_msg[0].virq, NULL,
-				   pci_epf_test_doorbell_handler, IRQF_ONESHOT,
+	ret = request_threaded_irq(epf->db_msg[0].virq,
+				   pci_epf_test_doorbell_primary,
+				   pci_epf_test_doorbell_handler, irq_flags,
 				   "pci-ep-test-doorbell", epf_test);
 	if (ret) {
 		dev_err(&epf->dev,
diff --git a/drivers/pci/endpoint/functions/pci-epf-vntb.c b/drivers/pci/endpoint/functions/pci-epf-vntb.c
index 3ecc5059f92b..d2fd1e194088 100644
--- a/drivers/pci/endpoint/functions/pci-epf-vntb.c
+++ b/drivers/pci/endpoint/functions/pci-epf-vntb.c
@@ -535,7 +535,8 @@ static int epf_ntb_db_bar_init_msi_doorbell(struct epf_ntb *ntb,
 
 	for (i = 0; i < ntb->db_count; i++) {
 		ret = request_irq(epf->db_msg[i].virq, epf_ntb_doorbell_handler,
-				  0, "pci_epf_vntb_db", ntb);
+				  epf->db_msg[i].irq_flags, "pci_epf_vntb_db",
+				  ntb);
 
 		if (ret) {
 			dev_err(&epf->dev,
diff --git a/drivers/pci/endpoint/pci-ep-msi.c b/drivers/pci/endpoint/pci-ep-msi.c
index ad8a81d6ad77..ebbd24b82ae6 100644
--- a/drivers/pci/endpoint/pci-ep-msi.c
+++ b/drivers/pci/endpoint/pci-ep-msi.c
@@ -8,6 +8,7 @@
 
 #include <linux/device.h>
 #include <linux/export.h>
+#include <linux/interrupt.h>
 #include <linux/irqdomain.h>
 #include <linux/module.h>
 #include <linux/msi.h>
@@ -35,23 +36,95 @@ static void pci_epf_write_msi_msg(struct msi_desc *desc, struct msi_msg *msg)
 	pci_epc_put(epc);
 }
 
-int pci_epf_alloc_doorbell(struct pci_epf *epf, u16 num_db)
+static int pci_epf_alloc_doorbell_embedded(struct pci_epf *epf, u16 num_db)
 {
 	struct pci_epc *epc = epf->epc;
-	struct device *dev = &epf->dev;
-	struct irq_domain *domain;
-	void *msg;
-	int ret;
-	int i;
+	const struct pci_epc_aux_resource *dma_ctrl = NULL;
+	struct pci_epf_doorbell_msg *msg;
+	int count, ret, i, db;
 
-	/* TODO: Multi-EPF support */
-	if (list_first_entry_or_null(&epc->pci_epf, struct pci_epf, list) != epf) {
-		dev_err(dev, "MSI doorbell doesn't support multiple EPF\n");
-		return -EINVAL;
+	count = pci_epc_get_aux_resources(epc, epf->func_no, epf->vfunc_no,
+					  NULL, 0);
+	if (count == -EOPNOTSUPP || count == 0)
+		return -ENODEV;
+	if (count < 0)
+		return count;
+
+	struct pci_epc_aux_resource *res __free(kfree) =
+				kcalloc(count, sizeof(*res), GFP_KERNEL);
+	if (!res)
+		return -ENOMEM;
+
+	ret = pci_epc_get_aux_resources(epc, epf->func_no, epf->vfunc_no,
+					res, count);
+	if (ret == -EOPNOTSUPP || ret == 0) {
+		ret = -ENODEV;
+		goto out_free_res;
 	}
+	if (ret < 0)
+		goto out_free_res;
 
-	if (epf->db_msg)
-		return -EBUSY;
+	count = ret;
+
+	for (i = 0; i < count; i++) {
+		if (res[i].type == PCI_EPC_AUX_DMA_CTRL_MMIO) {
+			dma_ctrl = &res[i];
+			break;
+		}
+	}
+	if (!dma_ctrl) {
+		ret = -ENODEV;
+		goto out_free_res;
+	}
+
+	msg = kcalloc(num_db, sizeof(*msg), GFP_KERNEL);
+	if (!msg) {
+		ret = -ENOMEM;
+		goto out_free_res;
+	}
+
+	for (i = 0, db = 0; i < count && db < num_db; i++) {
+		u64 addr;
+
+		if (res[i].type != PCI_EPC_AUX_DMA_CHAN_DESC)
+			continue;
+
+		if (res[i].u.dma_chan_desc.db_offset >= dma_ctrl->size)
+			continue;
+
+		addr = (u64)dma_ctrl->phys_addr + res[i].u.dma_chan_desc.db_offset;
+
+		msg[db].msg.address_lo = (u32)addr;
+		msg[db].msg.address_hi = (u32)(addr >> 32);
+		msg[db].msg.data = 0;
+		msg[db].virq = res[i].u.dma_chan_desc.irq;
+		msg[db].irq_flags = IRQF_SHARED;
+		msg[db].type = PCI_EPF_DOORBELL_EMBEDDED;
+		db++;
+	}
+
+	if (db != num_db) {
+		ret = -ENOSPC;
+		kfree(msg);
+		goto out_free_res;
+	}
+
+	epf->num_db = num_db;
+	epf->db_msg = msg;
+	ret = 0;
+
+out_free_res:
+	kfree(res);
+	return ret;
+}
+
+static int pci_epf_alloc_doorbell_msi(struct pci_epf *epf, u16 num_db)
+{
+	struct pci_epf_doorbell_msg *msg;
+	struct device *dev = &epf->dev;
+	struct pci_epc *epc = epf->epc;
+	struct irq_domain *domain;
+	int ret, i;
 
 	domain = of_msi_map_get_device_domain(epc->dev.parent, 0,
 					      DOMAIN_BUS_PLATFORM_MSI);
@@ -74,6 +147,11 @@ int pci_epf_alloc_doorbell(struct pci_epf *epf, u16 num_db)
 	if (!msg)
 		return -ENOMEM;
 
+	for (i = 0; i < num_db; i++) {
+		msg[i].irq_flags = 0;
+		msg[i].type = PCI_EPF_DOORBELL_MSI;
+	}
+
 	epf->num_db = num_db;
 	epf->db_msg = msg;
 
@@ -90,13 +168,49 @@ int pci_epf_alloc_doorbell(struct pci_epf *epf, u16 num_db)
 	for (i = 0; i < num_db; i++)
 		epf->db_msg[i].virq = msi_get_virq(epc->dev.parent, i);
 
+	return 0;
+}
+
+int pci_epf_alloc_doorbell(struct pci_epf *epf, u16 num_db)
+{
+	struct pci_epc *epc = epf->epc;
+	struct device *dev = &epf->dev;
+	int ret;
+
+	/* TODO: Multi-EPF support */
+	if (list_first_entry_or_null(&epc->pci_epf, struct pci_epf, list) != epf) {
+		dev_err(dev, "Doorbell doesn't support multiple EPF\n");
+		return -EINVAL;
+	}
+
+	if (epf->db_msg)
+		return -EBUSY;
+
+	ret = pci_epf_alloc_doorbell_msi(epf, num_db);
+	if (!ret)
+		return 0;
+
+	if (ret != -ENODEV)
+		return ret;
+
+	ret = pci_epf_alloc_doorbell_embedded(epf, num_db);
+	if (!ret) {
+		dev_info(dev, "Using embedded (DMA) doorbell fallback\n");
+		return 0;
+	}
+
+	dev_err(dev, "Failed to allocate doorbell: %d\n", ret);
 	return ret;
 }
 EXPORT_SYMBOL_GPL(pci_epf_alloc_doorbell);
 
 void pci_epf_free_doorbell(struct pci_epf *epf)
 {
-	platform_device_msi_free_irqs_all(epf->epc->dev.parent);
+	if (!epf->db_msg)
+		return;
+
+	if (epf->db_msg[0].type == PCI_EPF_DOORBELL_MSI)
+		platform_device_msi_free_irqs_all(epf->epc->dev.parent);
 
 	kfree(epf->db_msg);
 	epf->db_msg = NULL;
diff --git a/include/linux/pci-epf.h b/include/linux/pci-epf.h
index 7737a7c03260..e6625198f401 100644
--- a/include/linux/pci-epf.h
+++ b/include/linux/pci-epf.h
@@ -152,14 +152,27 @@ struct pci_epf_bar {
 	struct pci_epf_bar_submap	*submap;
 };
 
+enum pci_epf_doorbell_type {
+	PCI_EPF_DOORBELL_MSI = 0,
+	PCI_EPF_DOORBELL_EMBEDDED,
+};
+
 /**
  * struct pci_epf_doorbell_msg - represents doorbell message
- * @msg: MSI message
- * @virq: IRQ number of this doorbell MSI message
+ * @msg: Doorbell address/data pair to be mapped into BAR space.
+ *       For MSI-backed doorbells this is the MSI message, while for
+ *       "embedded" doorbells this represents an MMIO write that asserts
+ *       an interrupt on the EP side.
+ * @virq: IRQ number of this doorbell message
+ * @irq_flags: Required flags for request_irq()/request_threaded_irq().
+ *             Callers may OR-in additional flags (e.g. IRQF_ONESHOT).
+ * @type: Doorbell type.
  */
 struct pci_epf_doorbell_msg {
 	struct msi_msg msg;
 	int virq;
+	unsigned long irq_flags;
+	enum pci_epf_doorbell_type type;
 };
 
 /**
-- 
2.51.0


