Return-Path: <dmaengine+bounces-8721-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eBvDNeJeg2mJlQMAu9opvQ
	(envelope-from <dmaengine+bounces-8721-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Wed, 04 Feb 2026 15:59:46 +0100
X-Original-To: lists+dmaengine@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 315AFE7B5C
	for <lists+dmaengine@lfdr.de>; Wed, 04 Feb 2026 15:59:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id D1264303EAA3
	for <lists+dmaengine@lfdr.de>; Wed,  4 Feb 2026 14:55:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC2D041C2FB;
	Wed,  4 Feb 2026 14:54:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="qNI532DW"
X-Original-To: dmaengine@vger.kernel.org
Received: from TY3P286CU002.outbound.protection.outlook.com (mail-japaneastazon11020123.outbound.protection.outlook.com [52.101.229.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73A0741C2E3;
	Wed,  4 Feb 2026 14:54:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.229.123
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770216892; cv=fail; b=MnaiFzzo7Rzj7oprB8bGjWHxKfsSkldWTg8bqpTjRI2wZXbpT19JrbJXOpUm2NPtwAaKYP43Rme3GetIXXkCVjR88ysP7YePWhIftu4D0H33Hvc0ukx31IkAqOF7TGcCN+shLo9UQqedQhnyWhPcycCe2s2T8027wSobCu4+lV0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770216892; c=relaxed/simple;
	bh=wgkBBFcTA6KfbHUStJVjEyCthBQPrzXc3efL5bcsnVQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=XNcHV7gZkfisxApkDwSIQOd1HhhZJnhYcVc2Bl+h0CPSD2BstxYQLqE+ZnC/TIoyGAOqrWb+yFUsauJNyPdpUgxI9RP6xZ9pkq5JrgzP0N3fddl8h9YplUjnZhM4om35WL3prrE6KyG1IlcWbxQ8aYzoVDwPSp6osY7NCrP3eac=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=qNI532DW; arc=fail smtp.client-ip=52.101.229.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xBXUseJc2Cp9TplPSvmTYi1O+Ta/nQIxBYaCnIaVOym4RvlOR7GHRCBe36XdmkISWA19MXPhYZI9mUiaq3Kmcvuzkt7/Mxgnh31jrz6izaybt+TrmDC8b0TJMdHNXobfrLBfxJY1IvJpSc7KiyYoo9o5bbQ+L+UCG6Saw6u1FFAlsslXyXfFkgenExwwxl4xfZ8zq84IW8sTcsI45h6vaqNpJrNfAOzzg3esOmtITMdW1/Kskv1lZLZZjnEw7jOzYXDjbMTfGT8v5FpoM6djKLfIdaD7YRM6GcglQuM8DPzP2b1Ofu5n/CKrlMKaXGQSac1UMMyD84dc72aMp+6exg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3Hflq1SXvtncDpYac4dxU6ZvDfZZlKQ13Gaic95laoQ=;
 b=oAnU7yzrV7yMbtxp90RkhF7psHuLVw6J0b73jO7PBsSxqTfdB++8DQUCBde34P9RjaWk/j5J3Lk+Pg+1VSgOsaJsvwgo/F7zsoqTWyDZ6FNv0xYETPClRH7hPkcggr5UMbtPvvF6Mr+SokGI+BdISgikCTe11IvvKZ23Q5S5bhjD2/kiYnr2hgU2ImJwmeuYvPUPzUtfLD34bgPqVdVkQELTNnyz8ebC+6DY5e9SxwHTaHHEBbYYq8jOoPnv9tgnmUQkLORtb7I/8javB8nBTLSp+vXKXI5ATpJUBOVyR/sdMM1jF17odTvnE7ekuWG4XoD9QGNOtPepVHFMEPWcZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3Hflq1SXvtncDpYac4dxU6ZvDfZZlKQ13Gaic95laoQ=;
 b=qNI532DWRWSNHNgv7FHYl9lluHuqGh93L8B02HduvRE3O5k4AaCaiayQHkWAiOWYUOrdvIUJiD35ON/islBu7IsY5PVqjI9w/RzGpiqnD3J93bN6R5Qc6uH8xRWYB2zrwkL3ahGrhYayBQjtfIO2a4jhgKmtfmnDtL0ViKeQrJ0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:38f::10)
 by TYCP286MB2976.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:302::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.12; Wed, 4 Feb
 2026 14:54:49 +0000
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32]) by TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32%5]) with mapi id 15.20.9587.010; Wed, 4 Feb 2026
 14:54:49 +0000
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
Subject: [PATCH v3 03/11] dmaengine: dw-edma: Add per-channel interrupt routing control
Date: Wed,  4 Feb 2026 23:54:31 +0900
Message-ID: <20260204145440.950609-4-den@valinux.co.jp>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260204145440.950609-1-den@valinux.co.jp>
References: <20260204145440.950609-1-den@valinux.co.jp>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TY4PR01CA0100.jpnprd01.prod.outlook.com
 (2603:1096:405:378::6) To TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:38f::10)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY7P286MB7722:EE_|TYCP286MB2976:EE_
X-MS-Office365-Filtering-Correlation-Id: e603ee89-f78f-4840-451b-08de63fd589f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|10070799003|7416014|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?c/MU86J3meqylJPGwuBVB4akq9AiUCmVhuHOVd4i18+QckeCpydofMKKGTu6?=
 =?us-ascii?Q?1g5imp/qeuX0+X2BpA1+y77iFwfd4I0aZTyAi+HBPoLGtUIHbbTvuDq5T/fc?=
 =?us-ascii?Q?d3VD+K7DUKLanMTaOFB6Sipw/dUQs2h8JbtZE3ujfnjgu/o1f0ReDarcThTT?=
 =?us-ascii?Q?GP+QnUbq+VElAlGtEKwem0rqLw1PoLw8HFbQf69GGJ0UHBQ3nvycpLzGICAv?=
 =?us-ascii?Q?Ah94jGry/tFRj3+mPNoOCi1xAsLBb4Jr2rdsyQRUi+D4LeAg+lpOveCK2MRo?=
 =?us-ascii?Q?7fzJYY1nqBWJBi9NLuGDfgIg/murYL91Yt/TQ7t3e8bZ/k/G1SFgR5ewTTzf?=
 =?us-ascii?Q?IdaUy4o5PrJBc0e8cOnbH9MH4tQQ5XrXjGMfNWcSxM/9J6iXmqZ8Da2NpxRG?=
 =?us-ascii?Q?y+r855zaVeAnCf2JJuEgGc4vU+h2pHlZ+bGaAjGDJKQSh28OTDJ7F7MuSDQ7?=
 =?us-ascii?Q?ET/GVANViI2QFhd9QcrRF7e8crXg1OuUSomWy/fG9Fj0l0xsmFkUrMb/hO+r?=
 =?us-ascii?Q?QCmlpyirUZoACB5u4xqXAoyIlxHSWYwbkT/zH7RkMaY/TEyuWIRuQyBqYMJ4?=
 =?us-ascii?Q?hQIlUjf6GMlPahyQYt60GJDpLBTWMmXK+Pbts0NLmoCkoQ9Gh6qqTcphaCv0?=
 =?us-ascii?Q?uVyMA8qVrio/Ojy+AMORGWdVamkoogCtRbku4s2wgiQmtNBWaqUxkq39tamV?=
 =?us-ascii?Q?P/FaFLSN6UY5yJgR/lI43Vc94SVZgZr/oG5HD2R9orEfup4aGVVU+WvCO37m?=
 =?us-ascii?Q?w/bRo3Pb3j9QJzmTl/InPcreYeQNzEZKiYTktqOFxx4czvLPHHmU1XVLWEjz?=
 =?us-ascii?Q?Ph13qDSwTjvS7MXM/ZZyuN1MtKvWhs32HUWwEOb2sZfvR/5F5UvcKNbEmmyx?=
 =?us-ascii?Q?GPebKzsC9IIgqvj+nterMg7cPMZwQ2rqZpDX11t8XkVBaYT10pgGsKkdph80?=
 =?us-ascii?Q?9NncxqJ8ySaODk8WevgJV+uJScGxZIRgk41ETXCA3hybpXx+IBI1+tSJmceX?=
 =?us-ascii?Q?zQhdRIWpyLrIJa/RKkhDuwKL5QnmvTAqGXir/1PoK+4jt+ZL9QxSrNBE5EPV?=
 =?us-ascii?Q?GStgkhxoVSDXRvpxet2Cwoj8eCzqdwEaM+6Q3HO+yH8vVzY5qeUvtG9uUnPh?=
 =?us-ascii?Q?8jXZ8nCmgW/1B+EGbF2VQ0qLE5fnwyuhkMjw2HEffsqGfNnpOOAsRwd5dFnp?=
 =?us-ascii?Q?kzRxn0LXPfJkr8dvOeOkQ0zRQGC4PyFQMMisuAFHRUurV+MfbkenDiooXmsA?=
 =?us-ascii?Q?9VT943wxlgaWFv4xwOmdic/lH/Tozi+sV4BaM/AzSa4yj9OxVoeCZWHNiEaj?=
 =?us-ascii?Q?NowdUzhWHyGPhZ7qNtEv4e8GY0ezWPQVcs5raMSJAwfQsqJsnnhoYm6/WcFw?=
 =?us-ascii?Q?G8FpM3Foo5SGavZQay6jjdiqI3n0cRoRbBhXyT55RnsGjRZKEMd4UJkg5ejl?=
 =?us-ascii?Q?epXA4zJs0vGDSuKvY74BwupgBOVaf7L4mRuJXyQoJejQ0vkg+w1vT1MOiqGO?=
 =?us-ascii?Q?7NpJ8UaHhnHB6ZCBnkbgF+wh7zbyB70tlCV926pw0bDLfyb7GKOfkZmvhjpf?=
 =?us-ascii?Q?Iog1QT9TTV9TxeKDM/A=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(10070799003)(7416014)(376014)(366016);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?dfULy7YGRgZKf6m7HLdKgKrpuerMs7U1tetN/hy9uMNgpUZQSXzXFQ8t7RYJ?=
 =?us-ascii?Q?QQtjD0zMRz/V9Ag8Tgz5r1L6pJqPSnXIog+6q53An48YXxNgGd8wKWDKMURe?=
 =?us-ascii?Q?k1C0UO1YfIgdCbWaRm+S/hnqomLy0sT2shtrxeSZXaOb1HRRkSXOFKHjF0//?=
 =?us-ascii?Q?L5Py1UBHZZTGMKOQc+puL+G9qzAeXEEijcRZmBv0q/We3tWoR2S7S+N+kn4o?=
 =?us-ascii?Q?14LlDE8nqABUlTJLFtoycJFHUc1Z6EuAfk5/eJagzxsUsRm7nfZL0PIbAdp3?=
 =?us-ascii?Q?AB9rHwhpE/U2akie+VjFvYD4BFDGfxC4p4OwzKQTtDLMBt+6QF5XmhgCv/cK?=
 =?us-ascii?Q?FUGv/bfCbSpgKafMMZXe/81Orz0szzzIYfMJ+AHCICu+qF9su7eLWrgSORGG?=
 =?us-ascii?Q?BtUDNczgKY5fTIFPg5a+lemVl3fW6wzLyS3RCeua/rLGiQbfoR/7rNp+slkD?=
 =?us-ascii?Q?rRZStIs0ZeP8fbWcG+LQTwqGUpBY40FrW/XC3CHpDh88bmqKFy2PivvW5mbs?=
 =?us-ascii?Q?WazfoHMDyfncDFyfda4++uNFgmEOXZDInE+QID3fG76jF+VI8uxBHzoa4OWp?=
 =?us-ascii?Q?etVFfZZY3gdDI7inyjq0e6dDIZuE/V1RXY1u57p5oaa+4cqUWIVew6Ug+hzp?=
 =?us-ascii?Q?O867UhRNXcFj2wCRxuiSIb36h+NnhTyPDAH2RueyJ5/5ORVB/COe8H2FpOY8?=
 =?us-ascii?Q?QBlXZwwFm/MOQyaNQOfbna+JFrRttZkPk0heAWOvEqV6ms8onaQgE8Abm7fm?=
 =?us-ascii?Q?CW8R+EvyYPWfO1m/Gx1s+9jrqnwEA6cq9TkDivaAZs0KEe1ZU2/NY642D+uj?=
 =?us-ascii?Q?++MWsTXGtJOyCNh1CGxQMoSzKRJCeVkY+EZwFoR7zUZHqAqElg72AzLN0nWM?=
 =?us-ascii?Q?wkxk6GJWqM3sDHQ+iMAxD9G8y4l69ZqV/pxAppvet/c18IJnTEkzShtRMvx/?=
 =?us-ascii?Q?SvZhlkC0JhjzV9y0Y8XvwD+sitJjKdr+Qk4RvXe1JXHF8fVmn4kCuMkqrYkb?=
 =?us-ascii?Q?soC5foSSM6LHmNKHVLs6bKE6t+cMwD2z6pAJ+wtCLq8hyc3p1+P60H57LCWQ?=
 =?us-ascii?Q?4cU3oom8p+0z///FgXAfOL3xkey5lwzzLOqaRNYTheXxEDuu1xY6meEq+3rd?=
 =?us-ascii?Q?3t6J/GtlkPb5Z+CSh5W1wEholSX7f8WctLowqMCqulhYC/TIg31bhekmrfzr?=
 =?us-ascii?Q?odzwhmImcTqQpQ3CvNSJCTcbGppnOktWM3i5OV0ltSclSO35xYLboLS42JGO?=
 =?us-ascii?Q?OHWeASPAadS2HKUkV3gld9i59l3ssipiznLTH3y2InvMoqCLqKluL7sAT9vx?=
 =?us-ascii?Q?G5jQMhvAoWNFIPHneo8QITjeqivtpdfWNd2Xv/XgL8Mwk1M/q1w2gGgS/Yoo?=
 =?us-ascii?Q?GJFrV/5x8McbRRKovsjwttO8TxFOT0J+NNtzy2j/ougw32BpPtdy5ak3NE3i?=
 =?us-ascii?Q?q1KVn05snqL/0GuxxGXPfz6/twK+oKESBKsWTNVf/4rT8+XCOXshBrXUN1Xt?=
 =?us-ascii?Q?YLDoFOOBYFzolhOWh687Ih2F6TNMIHGKA9EvLa9ithjAs8HMCc3ao4PFzl+2?=
 =?us-ascii?Q?WCsGV7TWLBeHOOXkmD0NpIYvbIdjZlgTaHRQVi5VXCqsWkC4fZEDcy7uppQt?=
 =?us-ascii?Q?Qf27QRBA6EVbfvwB+9+c/I1CPFAjlg2fZPDewtTaVAw7bn0uq77kImxvQVAj?=
 =?us-ascii?Q?tDvVV8osQlPZ//ZyKJxR5GOv1cRsVuBpH4diYfXmTdH90dolO0UJ8s3hh+Rf?=
 =?us-ascii?Q?X+9RfAWcbzhfr+3uDzqIGhOw71Op5Ipf6Vu3QWXkkayL4cOSSajM?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: e603ee89-f78f-4840-451b-08de63fd589f
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Feb 2026 14:54:49.8362
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DM7HMfdTbWKAKrEQpN19ArMMR6cW4gADmqj/GlXUDnOZw9FtaglYEIeUytSx6unTh7ekkd7QfEc/QA/TILcpWA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCP286MB2976
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[valinux.co.jp,none];
	R_DKIM_ALLOW(-0.20)[valinux.co.jp:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_NONE(0.00)[];
	TAGGED_FROM(0.00)[bounces-8721-lists,dmaengine=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,valinux.co.jp:email,valinux.co.jp:dkim,valinux.co.jp:mid]
X-Rspamd-Queue-Id: 315AFE7B5C
X-Rspamd-Action: no action

DesignWare EP eDMA can generate interrupts both locally and remotely
(LIE/RIE). Remote eDMA users need to decide, per channel, whether
completions should be handled locally, remotely, or both. Unless
carefully configured, the endpoint and host would race to ack the
interrupt.

Introduce a dw_edma_peripheral_config that holds per-channel interrupt
routing mode. Update v0 programming so that RIE and local done/abort
interrupt masking follow the selected mode. The default mode keeps the
original behavior, so unless the new peripheral_config is explicitly
used and set, no functional changes.

For now, HDMA is not supported for the peripheral_config. Until the
support is implemented and validated, explicitly reject it for HDMA to
avoid silently misconfiguring interrupt routing.

Signed-off-by: Koichiro Den <den@valinux.co.jp>
---
 drivers/dma/dw-edma/dw-edma-core.c    | 24 +++++++++++++++++++++++
 drivers/dma/dw-edma/dw-edma-core.h    | 13 +++++++++++++
 drivers/dma/dw-edma/dw-edma-v0-core.c | 26 +++++++++++++++++--------
 include/linux/dma/edma.h              | 28 +++++++++++++++++++++++++++
 4 files changed, 83 insertions(+), 8 deletions(-)

diff --git a/drivers/dma/dw-edma/dw-edma-core.c b/drivers/dma/dw-edma/dw-edma-core.c
index 38832d9447fd..b4cb02d545bd 100644
--- a/drivers/dma/dw-edma/dw-edma-core.c
+++ b/drivers/dma/dw-edma/dw-edma-core.c
@@ -224,6 +224,29 @@ static int dw_edma_device_config(struct dma_chan *dchan,
 				 struct dma_slave_config *config)
 {
 	struct dw_edma_chan *chan = dchan2dw_edma_chan(dchan);
+	const struct dw_edma_peripheral_config *pcfg;
+
+	/* peripheral_config is optional, default keeps legacy behaviour. */
+	chan->irq_mode = DW_EDMA_CH_IRQ_DEFAULT;
+
+	if (config->peripheral_config) {
+		if (chan->dw->chip->mf == EDMA_MF_HDMA_NATIVE)
+			return -EOPNOTSUPP;
+
+		if (config->peripheral_size < sizeof(*pcfg))
+			return -EINVAL;
+
+		pcfg = config->peripheral_config;
+		switch (pcfg->irq_mode) {
+		case DW_EDMA_CH_IRQ_DEFAULT:
+		case DW_EDMA_CH_IRQ_LOCAL:
+		case DW_EDMA_CH_IRQ_REMOTE:
+			chan->irq_mode = pcfg->irq_mode;
+			break;
+		default:
+			return -EINVAL;
+		}
+	}
 
 	memcpy(&chan->config, config, sizeof(*config));
 	chan->configured = true;
@@ -750,6 +773,7 @@ static int dw_edma_channel_setup(struct dw_edma *dw, u32 wr_alloc, u32 rd_alloc)
 		chan->configured = false;
 		chan->request = EDMA_REQ_NONE;
 		chan->status = EDMA_ST_IDLE;
+		chan->irq_mode = DW_EDMA_CH_IRQ_DEFAULT;
 
 		if (chan->dir == EDMA_DIR_WRITE)
 			chan->ll_max = (chip->ll_region_wr[chan->id].sz / EDMA_LL_SZ);
diff --git a/drivers/dma/dw-edma/dw-edma-core.h b/drivers/dma/dw-edma/dw-edma-core.h
index 71894b9e0b15..0608b9044a08 100644
--- a/drivers/dma/dw-edma/dw-edma-core.h
+++ b/drivers/dma/dw-edma/dw-edma-core.h
@@ -81,6 +81,8 @@ struct dw_edma_chan {
 
 	struct msi_msg			msi;
 
+	enum dw_edma_ch_irq_mode	irq_mode;
+
 	enum dw_edma_request		request;
 	enum dw_edma_status		status;
 	u8				configured;
@@ -206,4 +208,15 @@ void dw_edma_core_debugfs_on(struct dw_edma *dw)
 	dw->core->debugfs_on(dw);
 }
 
+static inline
+bool dw_edma_core_ch_ignore_irq(struct dw_edma_chan *chan)
+{
+	struct dw_edma *dw = chan->dw;
+
+	if (dw->chip->flags & DW_EDMA_CHIP_LOCAL)
+		return chan->irq_mode == DW_EDMA_CH_IRQ_REMOTE;
+	else
+		return chan->irq_mode == DW_EDMA_CH_IRQ_LOCAL;
+}
+
 #endif /* _DW_EDMA_CORE_H */
diff --git a/drivers/dma/dw-edma/dw-edma-v0-core.c b/drivers/dma/dw-edma/dw-edma-v0-core.c
index b75fdaffad9a..a0441e8aa3b3 100644
--- a/drivers/dma/dw-edma/dw-edma-v0-core.c
+++ b/drivers/dma/dw-edma/dw-edma-v0-core.c
@@ -256,8 +256,10 @@ dw_edma_v0_core_handle_int(struct dw_edma_irq *dw_irq, enum dw_edma_dir dir,
 	for_each_set_bit(pos, &val, total) {
 		chan = &dw->chan[pos + off];
 
-		dw_edma_v0_core_clear_done_int(chan);
-		done(chan);
+		if (!dw_edma_core_ch_ignore_irq(chan)) {
+			dw_edma_v0_core_clear_done_int(chan);
+			done(chan);
+		}
 
 		ret = IRQ_HANDLED;
 	}
@@ -267,8 +269,10 @@ dw_edma_v0_core_handle_int(struct dw_edma_irq *dw_irq, enum dw_edma_dir dir,
 	for_each_set_bit(pos, &val, total) {
 		chan = &dw->chan[pos + off];
 
-		dw_edma_v0_core_clear_abort_int(chan);
-		abort(chan);
+		if (!dw_edma_core_ch_ignore_irq(chan)) {
+			dw_edma_v0_core_clear_abort_int(chan);
+			abort(chan);
+		}
 
 		ret = IRQ_HANDLED;
 	}
@@ -331,7 +335,8 @@ static void dw_edma_v0_core_write_chunk(struct dw_edma_chunk *chunk)
 		j--;
 		if (!j) {
 			control |= DW_EDMA_V0_LIE;
-			if (!(chan->dw->chip->flags & DW_EDMA_CHIP_LOCAL))
+			if (!(chan->dw->chip->flags & DW_EDMA_CHIP_LOCAL) &&
+			    chan->irq_mode != DW_EDMA_CH_IRQ_LOCAL)
 				control |= DW_EDMA_V0_RIE;
 		}
 
@@ -407,10 +412,15 @@ static void dw_edma_v0_core_start(struct dw_edma_chunk *chunk, bool first)
 				break;
 			}
 		}
-		/* Interrupt unmask - done, abort */
+		/* Interrupt mask/unmask - done, abort */
 		tmp = GET_RW_32(dw, chan->dir, int_mask);
-		tmp &= ~FIELD_PREP(EDMA_V0_DONE_INT_MASK, BIT(chan->id));
-		tmp &= ~FIELD_PREP(EDMA_V0_ABORT_INT_MASK, BIT(chan->id));
+		if (chan->irq_mode == DW_EDMA_CH_IRQ_REMOTE) {
+			tmp |= FIELD_PREP(EDMA_V0_DONE_INT_MASK, BIT(chan->id));
+			tmp |= FIELD_PREP(EDMA_V0_ABORT_INT_MASK, BIT(chan->id));
+		} else {
+			tmp &= ~FIELD_PREP(EDMA_V0_DONE_INT_MASK, BIT(chan->id));
+			tmp &= ~FIELD_PREP(EDMA_V0_ABORT_INT_MASK, BIT(chan->id));
+		}
 		SET_RW_32(dw, chan->dir, int_mask, tmp);
 		/* Linked list error */
 		tmp = GET_RW_32(dw, chan->dir, linked_list_err_en);
diff --git a/include/linux/dma/edma.h b/include/linux/dma/edma.h
index 3080747689f6..16e9adc60eb8 100644
--- a/include/linux/dma/edma.h
+++ b/include/linux/dma/edma.h
@@ -60,6 +60,34 @@ enum dw_edma_chip_flags {
 	DW_EDMA_CHIP_LOCAL	= BIT(0),
 };
 
+/*
+ * enum dw_edma_ch_irq_mode - per-channel interrupt routing control
+ * @DW_EDMA_CH_IRQ_DEFAULT:   LIE=1/RIE=1, local interrupt unmasked
+ * @DW_EDMA_CH_IRQ_LOCAL:     LIE=1/RIE=0
+ * @DW_EDMA_CH_IRQ_REMOTE:    LIE=1/RIE=1, local interrupt masked
+ *
+ * Some implementations require using LIE=1/RIE=1 with the local interrupt
+ * masked to generate a remote-only interrupt (rather than LIE=0/RIE=1).
+ * See the DesignWare endpoint databook 5.40, "Hint" below "Figure 8-22
+ * Write Interrupt Generation".
+ */
+enum dw_edma_ch_irq_mode {
+	DW_EDMA_CH_IRQ_DEFAULT	= 0,
+	DW_EDMA_CH_IRQ_LOCAL,
+	DW_EDMA_CH_IRQ_REMOTE,
+};
+
+/**
+ * struct dw_edma_peripheral_config - dw-edma specific slave configuration
+ * @irq_mode: per-channel interrupt routing control.
+ *
+ * Pass this structure via dma_slave_config.peripheral_config and
+ * dma_slave_config.peripheral_size.
+ */
+struct dw_edma_peripheral_config {
+	enum dw_edma_ch_irq_mode irq_mode;
+};
+
 /**
  * struct dw_edma_chip - representation of DesignWare eDMA controller hardware
  * @dev:		 struct device of the eDMA controller
-- 
2.51.0


