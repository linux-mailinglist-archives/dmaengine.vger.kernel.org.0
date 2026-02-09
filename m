Return-Path: <dmaengine+bounces-8827-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WHzxJf1+iWlx+AQAu9opvQ
	(envelope-from <dmaengine+bounces-8827-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Mon, 09 Feb 2026 07:30:21 +0100
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 03F6210C0CD
	for <lists+dmaengine@lfdr.de>; Mon, 09 Feb 2026 07:30:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4A68A300C014
	for <lists+dmaengine@lfdr.de>; Mon,  9 Feb 2026 06:30:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABB21317704;
	Mon,  9 Feb 2026 06:30:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="N33bDQZW"
X-Original-To: dmaengine@vger.kernel.org
Received: from OS0P286CU010.outbound.protection.outlook.com (mail-japanwestazon11021104.outbound.protection.outlook.com [40.107.74.104])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 681AC31281D;
	Mon,  9 Feb 2026 06:30:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.74.104
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770618603; cv=fail; b=mOtI+KVUybzUNQXz3VXOWYRUwpsVT6RkivUcv3jqOZCCXEcyxqASASC+Ym2mD60lc7LiAz4YpMyLfZQCuvCo84+NEVLE9pixRWEkGZHDQZLLAxx8XE2N4gLdpdKy94yR90c6CkfTDbQex1/wLD2+ctellIPJUkmilxLi+t2r6ZI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770618603; c=relaxed/simple;
	bh=HD8OBlQWTHnJnIw3Ox7D7No03nJKPfIIqH2+VVElxQ8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=sR6kLnHnLibJPK9h2Xw7O6uX4hw8yJchqfKeMylUMbAst92bh6FJXb3JGdwrQ8KlI30zz74rAA1Up4XAzEiA2sC7mla+fpXGWYzlRsgfupa52q7UAv9eiHKtVTQ0Z4Vmz+U9e3UqbZnH1j5gKUjbMtdl3UklLyDM6cOosgD4QaE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=N33bDQZW; arc=fail smtp.client-ip=40.107.74.104
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YZY8pWW43t5kYIMTAy5Wx5/9ZdLmRGvsa28QlAEBCZdNfIm3ez/8JfQL79774O+gxH3KfKY43nXCIjbMGS4Bjtx5vy029FAkzukQiCcWQHsq+EqWuY68EFIshjv0jBGeHmSGHywqKjkijXorxGcZ0XhmXHn4lojORNBLXFd0FPQdE4u7HbtCyzl5rgWgexHb0TIkw7Cly319+MKSEZnOzo9DXM452psrjsr1pUYbx86eDKB6Cc44nnJW6Q0FfA677FFmCv/BHQ7pGzUGtXPRjPYTOu48Sjb45c6u1xGRdeZvaQVmQOkuTtl81GAGzGmEYAqn/s2U2XNXF2O8f7UOiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4jNiFyiRP84zNAOUDjXThgyDDoZrcJUDqx+fOsLLy9M=;
 b=wFsclHuYkXkeqf4N9KN3a9jh8Uowg5Gv863nk0PGR3oJ7dENRBFs/s8MVK/8Bsg77I/Bj7SSnAI6CxJTa6qMVM+2M0h1kdPziq3Ooo+TDEcsLhulBxnh6pj3FWgCUdNMvAqcAo+RAWfDYxJhEtg1DNvVqIU65zVklR8SF0GN+bz8W4zGcplImbqgQSSKSXRNEVNg/pVOX8lNRo5X9MjTcT18X5gvGdGZFzJjSP/UBHX2WAKqc8Kjz1BBGVESuf0ngMo2wM3Qr0XPPWBljrY5bkifnDMiLbL+Fu+6TXhVXt6zTnX1GalgsuOVmzQ4xLkf/YSj7j8/w6KHWqw+8Ww0cg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4jNiFyiRP84zNAOUDjXThgyDDoZrcJUDqx+fOsLLy9M=;
 b=N33bDQZWwG2SVlgT4DYSZtIj2v2gDAKd4pgOMZ3hSVZ2G44xykMWLu5VSqlXFQoiskMShTRW5WB9/GjG0kcekAerTH5MfnwmdyaSeYAQ0uPmfICwQ9TyPJXNe5/FlPWYxngBNFXCfkyGxzX1VV4IguySL/bZiRSKAJELsRK/+eU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:38f::10)
 by TYYP286MB4425.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:10b::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.17; Mon, 9 Feb
 2026 06:30:01 +0000
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32]) by TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32%5]) with mapi id 15.20.9587.017; Mon, 9 Feb 2026
 06:30:01 +0000
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
Subject: [PATCH v5 2/8] dmaengine: dw-edma: Cache per-channel IRQ and emulation doorbell offset
Date: Mon,  9 Feb 2026 15:29:45 +0900
Message-ID: <20260209062952.2049053-3-den@valinux.co.jp>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260209062952.2049053-1-den@valinux.co.jp>
References: <20260209062952.2049053-1-den@valinux.co.jp>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCP286CA0318.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:3b7::6) To TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:38f::10)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY7P286MB7722:EE_|TYYP286MB4425:EE_
X-MS-Office365-Filtering-Correlation-Id: 656964d0-ff53-4228-1a3b-08de67a4a711
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|366016|1800799024|10070799003|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?nFjehwBUWNB14tnC/PFmm2+oIPlXPmG5isFEvyifswfX/DQy58IC8G7aeTLX?=
 =?us-ascii?Q?MR8X1wskzF9ijEyJk3Rf2KUx1UN5U1meg++NnsYQ6dHZj2w30rIQr/TNuTu5?=
 =?us-ascii?Q?EKAjnOlsZM4uw+2XcP/2160xojUJY6f0CfIrMs7Qo3aW/ZRoh2Llqx+DVDVk?=
 =?us-ascii?Q?JKThxOkeVi08xYllGiYD2sHb9Qes/c+9wpyu1xG5scIhGCkCiOxjxI5ydDwW?=
 =?us-ascii?Q?mX5e9IMYCUnBXUT2pNO2g3yWB63bpUrydUqCsjfrDfNGatOqIbHiGz2Mz4yo?=
 =?us-ascii?Q?VjqU1Y+WsgAFekr5ExnbMwEgS2SeZTWHRjsv2CcwBphu0p9cb4gW4itD16b1?=
 =?us-ascii?Q?+yRGVw1spVBSx+ODSoRzvlbeCi+gltqDlt9vxTA6lqIdtE4ImBuuSxmg4MuR?=
 =?us-ascii?Q?8RtoGBleT/1u+9thu9ITg7F7tih8BNKr2uk0CCZmAiIII80V3Ma2vSwdg3Ya?=
 =?us-ascii?Q?1PE2dkleH33sggBhaEfZWrCn+IxYnaNoJS8Rc7EGu45aM07vyBsdSVb+S4eS?=
 =?us-ascii?Q?aiYnMqKiFEiRlTdwBE0FmHGRbLAkeWK9aeilyZzPK3b11mLvevhgsIf00VYJ?=
 =?us-ascii?Q?gBGtsZ9iLlSrIw5wys1tJQjw68V+fRe5EfWoC3YJEPQqWCgcefwecOdfd/9s?=
 =?us-ascii?Q?64FEd7DKmoT7NPaPBpjAC9S+q4AO+ursYC63k5QT841w9PZYYdgZkWlq27Ti?=
 =?us-ascii?Q?LvMKAWz149Gy+F3nu4ZbSIjM7/GrMTkIrTcYOu55wuFAoivFo/mXkZOfhNwI?=
 =?us-ascii?Q?LoiQaXZ+21dco6Po13DhSuBfa0eV9b7U6rRlpzO03cLbmeYYycnN2LY3C6sq?=
 =?us-ascii?Q?i66Og52mBuP2RA2uZjpBBWHNo7z7GtsAYTfD76MFjng1npaHmhtzlNg5KgwU?=
 =?us-ascii?Q?I0G5TqhDkXoybpuzDAKTkajp8B+MioWCTzYJlTOVJubgRGKyTAfTtEsnBF2y?=
 =?us-ascii?Q?DhXqMAXmD8hrmtizhHZvLqCvGQabLswvvGT1xlzXhcEF9Mld7ps6fXxG+S/o?=
 =?us-ascii?Q?5upiCbkPPLojAWEVLpPoMqIlrWuaXM/PPkaCQpOZ1kbUac6rOmAPdN+Dj6YV?=
 =?us-ascii?Q?qB66CGIKHzexGHXRgZTjjmX45/vSfYkUL9bsWEVkO3NtIscEdJ1p/usEoBkP?=
 =?us-ascii?Q?gPqAwaZHCF1tYGka2wRNZspzcB0nc/AxgnDl6TX8egp1OUOvALG3GzLBGjGn?=
 =?us-ascii?Q?iZBZ0iep7PBruvn0QCvUo45oVyyR26U7VDWx1++s94ODao99VjKT6cnQTs3e?=
 =?us-ascii?Q?ASj3ZF0Lv3lJyAuo6RHQWvVop2+Sdf8UqSAekNGLHJvOr44s4M3voDsw0pnv?=
 =?us-ascii?Q?efbx0pe+Seh5SsLD53V7Ix5rV4UfTtAKEKwtH3TzlHS5Jxw0zk0c4GLVEk3/?=
 =?us-ascii?Q?fL19PauW+WNK/M9KGSUGuAh4/S4v6IlV4CArzrdG7/I5GqMCOvhtmAOVhrWi?=
 =?us-ascii?Q?MA6D501KfAQfISB9jgFBFXwZnXf/KkcSECSGzrl4LPQ25KGadpkfugqCmMqS?=
 =?us-ascii?Q?NCv9jGwrPZ7hhxpo8pOEfqe+8jEn70/72V6+hMvu4Cm1Qoba6Ny3qUa9Y/yw?=
 =?us-ascii?Q?Cs+YtfZCleCKVqg/ZKB5YD9zQVZnr6qfU1FRkLp1LD/+VnWzEYB++FUB4an6?=
 =?us-ascii?Q?5g=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(10070799003)(921020);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?1mUiUvASKNsRpyK6EdslExakbDBmPkYLjwUXX4UR3CLmxfo7cCt7In+03AMc?=
 =?us-ascii?Q?gidGmEVKbokg4XMdpFooLYZ69GZPvWYj2TwxGBHyvuNR8dLwm+MSR81dWLY/?=
 =?us-ascii?Q?jL++MVDam8kV+FE35RyIum/RTBjbyFsW3bDqnED8XlkGRxHTtdc7KB7xP+Ub?=
 =?us-ascii?Q?q6EsuQO3s2K0zTGn37rrISd0MC/xTDewCZ9nHxnfjG4wOnzYbU8veHx2nZBi?=
 =?us-ascii?Q?6akTAO1BAqRz+GIsaCPNYcCR6RiIb4u7HA2lP9pgr2qCffqmDrEvn/ix/qBv?=
 =?us-ascii?Q?rdXK4isdTwWtMJddsroIaf7UHKQUURXvOljg5HVUefXO6xKQGWbspX5B4IuL?=
 =?us-ascii?Q?6dyIy/mANcB93URQlO4OfDohgadJuSOfgSDXeC8z3xwjQp+GM674F1+O4ayl?=
 =?us-ascii?Q?PbB3szbhGi9qCASeljiCoVFYqtr2bsJIkF+7O7cUMdpCipo84CRdGIDf0O/V?=
 =?us-ascii?Q?/cKfClpvjt9CfaDYaqRjqygXv2d85KGAxnt/Svyiaqhcv56YkBPq8iuCEUho?=
 =?us-ascii?Q?+15Lf/DcHLVkg0bEzJJZhoJ2qvyYV41/4dTNWihjQkcOhwZ0kCWh3om+qcds?=
 =?us-ascii?Q?tK1xocydtICnBcigzjByAMenRFnjFXRFfnl30H5X9mmZERursa+SdUkKMcLM?=
 =?us-ascii?Q?aRVMMp4V5Yv5L24m1PZ2TzscRBdCYRERReI+aasjalQmKIaUCVcuQHws/c5R?=
 =?us-ascii?Q?1jToIp28bWVbKhgXbuakhhM03UpkXFbex1paz/1/1+rfP5vfn3RWmEqwQvoM?=
 =?us-ascii?Q?exHHS1YA6FsvlvBnBuR0sD1O+u+GaJaA4ObpEeNytFX4jccmNzcA6EW8AqhR?=
 =?us-ascii?Q?lsa9r5DGx+bxkOTO6xHXcRL8N0ilIMWGm52fJ3oJ59TMvDwOTlB2qPHLZvjI?=
 =?us-ascii?Q?e7KbpPk8gAe8Qh8CTKRkokWhySAb/BqdKxHJR0pqYn0yt0sEsyzfZw84t6XF?=
 =?us-ascii?Q?aduuNDCsheq8w3D47oOLuGYWJmVeToESznD16kAS2b3U+e8bMkrdFRXTvOR7?=
 =?us-ascii?Q?9CErWqnrr/VPvStbJDrWposu0MmQARo0NEsBNht/a7h+7OO1fQyVHiBmVKBq?=
 =?us-ascii?Q?aUe9yrl6mFpuhdy1R+hfrqrlDKPPYSsz/tLi6QRbtSwD/5GiL7BQLxHRwI8P?=
 =?us-ascii?Q?ne5oQ60fFoSvyJ0Zod03amgV1ATOgwFN5V2VjUbvv2muJfStVTo4hZPLWnxy?=
 =?us-ascii?Q?F7rP3HIvgaBVkXASH7tsXtTFYTYi0zNOhuPFfnwRAZdlIpcIkCIDNlSYKL5/?=
 =?us-ascii?Q?V9JaXw5QtlN2W5pfCnK4uN2GZsBaEjuxK83yB85xOFHhPgTm1UqhW4/q3qWM?=
 =?us-ascii?Q?XCN8jKQFM2symLTzGZWHopi9gpShplGryj7bkrYjd3AKLtiUU/UORGGhkr9d?=
 =?us-ascii?Q?yRFBNUZtrqCNTRX3AHc2T7UFCHtzKyK9/jdLcH5RThe1ttbf5CZerVIhg+NW?=
 =?us-ascii?Q?pjmHcLQ/fvG5ndraLzM5pynk336GWcIiKv435lGKPQILgmHlT3isDjfTrBqd?=
 =?us-ascii?Q?5+0ggJYcitMoDfDRENXt3ovPFOwO8ZZjLNcWnRO7XBBjFd4iwokuMbXt5FPE?=
 =?us-ascii?Q?3A6gfyz5Y+e4+Ve3UuOJWQHtYWqBkVwl0cyQ634FL4XMeaun0Jel/Jgv0xIB?=
 =?us-ascii?Q?FVEqMLeModUVSQ8tGaTcYg0JaCRsrzI505Qc0MMhE0SyJj3mRScNNWIHGmtX?=
 =?us-ascii?Q?FHNIOP6tXiNIGCTH2qB7I4sHwduprweCxAyjRdG+sg3lAYJP/aDLVZTGWsMb?=
 =?us-ascii?Q?tajQW6p3Ob4Jn/eTlsd434jS2laYZjLgIVvkY3dnhQC3Oibl20Yb?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: 656964d0-ff53-4228-1a3b-08de67a4a711
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Feb 2026 06:30:00.8940
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0Jp2DPMWkxbqTH9kapD+r7wOJZ+fCXomOEWyD0Z03CHEGgfhnAvH0uIXpoFXnrrZ99Re+D3BUQ0MeUGPBbwzpg==
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
	TAGGED_FROM(0.00)[bounces-8827-lists,dmaengine=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 03F6210C0CD
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


