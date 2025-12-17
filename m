Return-Path: <dmaengine+bounces-7776-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E0ABCC892C
	for <lists+dmaengine@lfdr.de>; Wed, 17 Dec 2025 16:49:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E4F30324E70B
	for <lists+dmaengine@lfdr.de>; Wed, 17 Dec 2025 15:25:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCE9F3644BC;
	Wed, 17 Dec 2025 15:17:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="rPuhCfeq"
X-Original-To: dmaengine@vger.kernel.org
Received: from TY3P286CU002.outbound.protection.outlook.com (mail-japaneastazon11010013.outbound.protection.outlook.com [52.101.229.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68F4B362157;
	Wed, 17 Dec 2025 15:17:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.229.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765984671; cv=fail; b=cDqnNTkgJeM96Jgk6oDvnKPoLn3+jnR2ccsNYHX3Ws+CbKUzK8idGZ4RplAj7BmjxteyPhOzz0nBW2DSADgk8IY3wHiew0O4sWGKMEUkBRZbg8V/G6XF2t0mxlAAvOh5Dl5W44REWq5CrB7D6SZw49D2BnrugCeR68oP+XaToag=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765984671; c=relaxed/simple;
	bh=a4G9QRnVsPt/uuqkfe9kUrRCGOW9nceP9hOOxskp0WE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=IZxdMC9t3VkINhXyxgWLo6L7g4uNXtEfV39//RhvoD6VHbu7nsCxfZcpRBQjvPjJAVoXHu6YLBGHc8f75jWoJ+AydKb4DYRqeBrBDcjoPECeiMZnGCRdqZ9/6TrXlX8w535F32ZBFnzdZWeYxX61ILF6oMSIn1wiB8mFJ0j/F5k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=rPuhCfeq; arc=fail smtp.client-ip=52.101.229.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jcbFjJdcW9cBdP1aVH3sVRpsiE2CN+LeJLCjjfg7X+7LC5chkQuop50kiZ2RvajXeGoKMoQwWweL05q+XR7uGCHekBcrTexHJWi4NHdLxE2ZIGJlqWY7364el6P6EuGWRLrBXY30YQBDRLFlLTU+MZpsO1LIQNNmgtQPNIumLxSV2pHJXHNn7seOdCC/ARGQRmzDoVzQCMABTahMbn4APoGnZ2IYP6dwr3vk1IeDubVbx+L2tEKIZPDpLILA4Ld5JzlCrUaGXiw8rLVV14FN3DBmBYTbdKHvnYH0Jvt8u1aIwvealnoVzYLhYoU624QFs+Um/4O/nu9MItYDXlHuIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fGCTgygFHcBT4UMiTZRF4kncO36Fu1a7I/tGPUBEN0I=;
 b=cEruZ6sSWHUUWiW+VwS2BP2DB1CM03qc60JxmIxX4EQIXolP9dUGAbEsMp50xlrbtZxVETVz5fHUbzJ6eT/HK7lJ61+b9ih7nkP7ws6KsLW9xoBb8DKjjYnZIfG7p25pl+MwcUo7YOh+t1eJxy76F/Bufw2PxkbWlPWdL5CkNPFAoOUR88PrIrackxgzuLPetAl6C8e5nEqGj6G57d/hHGQt/vOAnlYiyVceuT0m1xGMLEs55ucoJktXrlF1RkHQi94Hvjxh2L8DRpCbRkqZfsY8YIKkCgvIPU5nslvIUB7BziyATw7o9B2CqhTRhZ2rwRmRpzVpfhhvZXNucOFXAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fGCTgygFHcBT4UMiTZRF4kncO36Fu1a7I/tGPUBEN0I=;
 b=rPuhCfeq3Jn8Uo56hRV9IH8kVmavYoOZ28FZNx/H+ll51odi59hFY1V9F8twTDB/O4Vjt4PdfoR+N0q57SSKdUQQ8jhFf9C0ysTX8qR25zhn2AW4a8nyLcliRdpd8T9u+cvXDm3kPGmivQq9wJTP7YBkbzzl13KVuETdlaK9sPA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TYWP286MB2697.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:24c::11)
 by TYCP286MB2863.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:306::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9434.6; Wed, 17 Dec
 2025 15:16:40 +0000
Received: from TYWP286MB2697.JPNP286.PROD.OUTLOOK.COM
 ([fe80::fb7e:f4ed:a580:9d03]) by TYWP286MB2697.JPNP286.PROD.OUTLOOK.COM
 ([fe80::fb7e:f4ed:a580:9d03%5]) with mapi id 15.20.9434.001; Wed, 17 Dec 2025
 15:16:40 +0000
From: Koichiro Den <den@valinux.co.jp>
To: Frank.Li@nxp.com,
	dave.jiang@intel.com,
	ntb@lists.linux.dev,
	linux-pci@vger.kernel.org,
	dmaengine@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: mani@kernel.org,
	kwilczynski@kernel.org,
	kishon@kernel.org,
	bhelgaas@google.com,
	corbet@lwn.net,
	geert+renesas@glider.be,
	magnus.damm@gmail.com,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	vkoul@kernel.org,
	joro@8bytes.org,
	will@kernel.org,
	robin.murphy@arm.com,
	jdmason@kudzu.us,
	allenbh@gmail.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	Basavaraj.Natikar@amd.com,
	Shyam-sundar.S-k@amd.com,
	kurt.schwemmer@microsemi.com,
	logang@deltatee.com,
	jingoohan1@gmail.com,
	lpieralisi@kernel.org,
	utkarsh02t@gmail.com,
	jbrunet@baylibre.com,
	dlemoal@kernel.org,
	arnd@arndb.de,
	elfring@users.sourceforge.net,
	den@valinux.co.jp
Subject: [RFC PATCH v3 29/35] NTB: epf: Add per-SoC quirk to cap MRRS for DWC eDMA (128B for R-Car)
Date: Thu, 18 Dec 2025 00:16:03 +0900
Message-ID: <20251217151609.3162665-30-den@valinux.co.jp>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251217151609.3162665-1-den@valinux.co.jp>
References: <20251217151609.3162665-1-den@valinux.co.jp>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TY4P301CA0005.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:405:26f::9) To TYWP286MB2697.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:24c::11)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYWP286MB2697:EE_|TYCP286MB2863:EE_
X-MS-Office365-Filtering-Correlation-Id: 0a7de7a2-4218-4c83-0d26-08de3d7f4757
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|10070799003|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?qIF/ch9/irPNPtkDzULZ1PKRHG4qAWuaBYjhOT2FnLJnsp3MHMcF5cktBiyL?=
 =?us-ascii?Q?4H5odU8KFmgj4zlyAobvzFow0XsCi6S619AYLWWx5ELsvZSVy9R64dpSa/Fq?=
 =?us-ascii?Q?TZ5n2+s6FMnJpd7keMdyueIc6nzY+G0lQ79c2JeDwSETw9jzNZjVR/fwNUiw?=
 =?us-ascii?Q?D94d25AscRx6S/TZ3vEEUMhHfJkJMmLdsHpFGYwHnCNYw5PWvoC2MCVAW4iN?=
 =?us-ascii?Q?P+BRldJ8kazFkXLPRJidukGhRauKr4FUI0woUjVIf3QKJsZ9ngnikBRiuQ09?=
 =?us-ascii?Q?5arqAaP/v4ms6uf7KRJYLxFfY/sDlCetXgJpFMfPuxFQ5JXNR6w3tWEh95aD?=
 =?us-ascii?Q?RQEyS/BMvQIUpM9i9aAi24N2PgsVRDlIKBuF75zfr8B1XIIEYBPQrBu3V7VC?=
 =?us-ascii?Q?TFZsLozoxKW+6vy3ESxZTormzMoOsjDEd7PkkaxTjAdkvC+SXa/9Xvvdxaee?=
 =?us-ascii?Q?iZZxzz65X3Uznvm5UUA/pdq15cGFn1cAqbMETzJ7+cJj66ySQycZ1EkTVWx9?=
 =?us-ascii?Q?RRM3L+Cwf3/yppRzSpGuMpdhchWNQot+6A6tM9X12zBOzfFwmJS5roUg7epK?=
 =?us-ascii?Q?DqLy9OBDjCzTO7oqbq9fKEY31yUSbEPqY7FUcF4Y91+X9OKXDg56UymBbVvz?=
 =?us-ascii?Q?6F5mZNMdfjRJgICGSOYNPZCYRrJKyX+zDwiSgiymq87FM74roLt7U2Zk8BV0?=
 =?us-ascii?Q?YH5pZKGaWYakhoNMyT5gobzQa3cT5954CtN5WIf+KTlABQC0HhwweIO7YUBe?=
 =?us-ascii?Q?wUCfIMlDPp0Q1b52xyFB12svu3mYeFdLEoYtKskgg8fkB+9fmaVL+n++24sv?=
 =?us-ascii?Q?fFrBdCLl0Jj7OsRS8R+ShEfJTFGxsnMB6w/hU8SdTl5fnyYH5VyZliv2BcOx?=
 =?us-ascii?Q?5e2vfP2hnpctQ+iUDHJU20PlL3kY9RCZrfo+DP1wNAnk/GggirOkmzxsLimp?=
 =?us-ascii?Q?X8/mC36YV7iuDV8TpHi6hPqSUlPgsFp4NMulkPIk7PRLgaDcAqz7rl+kcTKO?=
 =?us-ascii?Q?PG2cO/fqq6NGDtnKVoJZrmmpyn/+JOyYfAnVWqP8PiEo32E9F/T0GHDa1uTz?=
 =?us-ascii?Q?vsAHSrcDkdVTY7cPUtg8nr9oTXyv3ByT8/zloNd92dWpIz9gFeNpbY6HMBpV?=
 =?us-ascii?Q?72mTEjPh+NaWww58/AkgXHEp9fp9SjaJLN770co65WwJ4xomKTCxBWE7Yd/M?=
 =?us-ascii?Q?WYl11GF+5OGeDJpsJt8TGrhZHD2wCmRA/2bu0C8ANpxbKSnkGvtH7cBxNDTg?=
 =?us-ascii?Q?eBxk//Z+XIG0G+XE5EZW8mm/69QWV1mxANIgdHZpg8bvJNAVY1jEYysMNg9C?=
 =?us-ascii?Q?qSXC5hqm8mrw7QGiaQrBLRkGkFxTesON/GHe/RBPBHIZVVNtDbsh6WtV/pIf?=
 =?us-ascii?Q?W+cauoKr4ehRxPBeleH9ACvUJkbjxlxcC3Vtsw3CqG5Xl0deh2ME7CeZoze/?=
 =?us-ascii?Q?jrrBGKmUELKTKdn7iM4nQYCUF2H58BH6?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYWP286MB2697.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(10070799003)(1800799024)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?qiRxN8GdRJwFGPVsFTPfMTuMrQy7M8+ND54WQ1n842IyjXCRIwO0uwzQ37g8?=
 =?us-ascii?Q?ncfVlnwzq15BtLTgS44NBs6JQsmtoWqCBwsd3vjPRt82oiqbQsjvbhLm7GPX?=
 =?us-ascii?Q?O5kmjLdt1svijAShTftK6UT/XznKWnvOnWt3TTwintC0XxnuxfzfUF3Jw5jO?=
 =?us-ascii?Q?uH6Kn1dZquWBbg2Gt/1yhFA+kyQGxSpAn35vmtGcaBnBlV5ofHw2Yl6RQ2v9?=
 =?us-ascii?Q?v+t9HM9d9fst5lHLL5wcDJReUsWNEotyNzKLLq/MxhnkZGtDKbyqdALPt+kc?=
 =?us-ascii?Q?wQHcwvpDDKEW+HW3R02qeJ5N+SB6qiCwRKs5lai22sk04PxG9XogIM98kbRB?=
 =?us-ascii?Q?D1El1n1QEIN5I/QalLF0e29MsLeaDo3rbbYDgxGKtM4631yI+g8r6OQE1t5w?=
 =?us-ascii?Q?AcsOP0NA2BgXCqEq+6NhEr9Y+/3wCNyFX1k530gdv7bxS7CDqNmKEuHakDGJ?=
 =?us-ascii?Q?2gIGoV8vu4jy2jQgevBUHha2Ht+JrbSlw1dChiZK2aJJh/atlGf80Won6gSq?=
 =?us-ascii?Q?fSZDVcQKb0zRnEN6IjiangjJHkz1e1HH1PyaO4Yw8jA6Mp4E5pCGfey+qg5i?=
 =?us-ascii?Q?S4bPkOQ+YfZdRlwdM6+9XOPwvxt4zX6nU9POK2aXrcMNq6JIqUgg9uXKc2Nk?=
 =?us-ascii?Q?qH7WVKHHzENUNc9/FOTaCi9uQv9BgYYoWHpPW9bOzx5Y0QAZDwt8gKoFKgb1?=
 =?us-ascii?Q?AUvT7eibqJp3WJrzEHFgsZATsqvU7AkazMbieQqVihxBPjhcMyxw5VbYkshN?=
 =?us-ascii?Q?6h5xXO5WgHdqhx1u9MyzFM1tulmBeNSxMHk/FNrzPemh1PhkUZGnhxjjAQ20?=
 =?us-ascii?Q?wpdwkrRuX08Sp3kKvrO1HpMYNvtnTu0xk76SEUpt0OYT5efhJwQOEobTk3Nr?=
 =?us-ascii?Q?pn5KFpTIiTmj6jWz5+6RXbmnkGgUjNCLdzfODX6YqHBw71QehvWl1aIbl/xZ?=
 =?us-ascii?Q?sgi7Jx99sddOY9N7qNWuPKe7BNA8PBOQ7fulO89KapxMc1L8a/YbYO0w9hVV?=
 =?us-ascii?Q?41sOhNLncJM43buZSeuobo/33iYFJvRW30M2c32F4/5KbJ9loJWzGsuQPBHG?=
 =?us-ascii?Q?VnXa9d1mcenlX+1FwzdkUBDem3On3zFRlC6kD4rgoS3bMv2dXHeknfD9znW7?=
 =?us-ascii?Q?Zp+MBhg5JyVtZeAtb2+pF6HKsfUYdruO1iN8qlla48R5OFZeRfKpUx35ucSG?=
 =?us-ascii?Q?A5bz17hSqsNB7YjJI8jc9o1nD7VU3PvzEXrYC0CnPpWWWMKVxb3fysLbrPh0?=
 =?us-ascii?Q?MWNa7ncIm3Xoopx1JdWRmYkXk/u8UloUWnBe+DDxJN+ijE1PGGmVilqWMbDs?=
 =?us-ascii?Q?tknrmnDIY4TKCTrCcT33AAAWIkqCjzP5dA74lym7IXSE2HgkVv6iNbC93NDD?=
 =?us-ascii?Q?tUYlw5l1cI9SoFaTo1FXFuv1KbSTf6s2XGJuKe/5V3ed4sIF4BOyb3OjFk8R?=
 =?us-ascii?Q?EoB6oLVD+F4NlreRKDbhInOkqtxI5ez0dh3Zp8+3FMOR5dIysD/pJFTp+umc?=
 =?us-ascii?Q?xt/KLcfDWYOpncjh5SyUL2+JMc9GcOB0s0pnYKg2T4lgye9a/5u6Na9Z/x7v?=
 =?us-ascii?Q?XaCu3iFptKLSSOwlDOy2btX7+Z6mnwWXoLAR8BZQ7sxf0mSQ5gDIwqmOiN9j?=
 =?us-ascii?Q?iWXkI3mnG0ni2a3F5ZQE4Ic=3D?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: 0a7de7a2-4218-4c83-0d26-08de3d7f4757
X-MS-Exchange-CrossTenant-AuthSource: TYWP286MB2697.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Dec 2025 15:16:40.0862
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: F9kQBDRlVH61IbI2v1DnVQAF6q9WKPe2/Sf5dF+pU8zt0yE3t4SAIxHWL8fK38K0J5J/EPx4ZWKkhuu239XybA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCP286MB2863

Some R-Car platforms using Synopsys DesignWare PCIe with the integrated
eDMA exhibit reproducible payload corruption in RC->EP remote DMA read
traffic whenever the endpoint issues 256-byte Memory Read (MRd) TLPs.

The eDMA injects multiple MRd requests of size less than or equal to
min(MRRS, MPS), so constraining the endpoint's MRd request size removes
256-byte MRd TLPs and avoids the issue. This change adds a per-SoC knob
in the ntb_hw_epf driver and sets MRRS=128 on R-Car.

We intentionally do not change the endpoint's MPS. Per PCIe Base
Specification, MPS limits the payload size of TLPs with data transmitted
by the Function, while Max_Read_Request_Size limits the size of read
requests produced by the Function as a Requester. Limiting MRRS is
sufficient to constrain MRd Byte Count, while lowering MPS would also
throttle unrelated traffic (e.g. endpoint-originated Posted Writes and
Completions with Data) without being necessary for this fix.

This quirk is scoped to the affected endpoint only and can be removed
once the underlying issue is resolved in the controller/IP.

Reviewed-by: Frank Li <Frank.Li@nxp.com>
Signed-off-by: Koichiro Den <den@valinux.co.jp>
---
 drivers/ntb/hw/epf/ntb_hw_epf.c | 66 +++++++++++++++++++++++++++++----
 1 file changed, 58 insertions(+), 8 deletions(-)

diff --git a/drivers/ntb/hw/epf/ntb_hw_epf.c b/drivers/ntb/hw/epf/ntb_hw_epf.c
index 5303a8944019..efe540a8c734 100644
--- a/drivers/ntb/hw/epf/ntb_hw_epf.c
+++ b/drivers/ntb/hw/epf/ntb_hw_epf.c
@@ -74,6 +74,12 @@ enum epf_ntb_bar {
 	NTB_BAR_NUM,
 };
 
+struct ntb_epf_soc_data {
+	const enum pci_barno *barno_map;
+	/* non-zero to override MRRS for this SoC */
+	int force_mrrs;
+};
+
 #define NTB_EPF_MAX_MW_COUNT	(NTB_BAR_NUM - BAR_MW1)
 
 struct ntb_epf_dev {
@@ -624,11 +630,12 @@ static int ntb_epf_init_dev(struct ntb_epf_dev *ndev)
 }
 
 static int ntb_epf_init_pci(struct ntb_epf_dev *ndev,
-			    struct pci_dev *pdev)
+			    struct pci_dev *pdev,
+			    const struct ntb_epf_soc_data *soc)
 {
 	struct device *dev = ndev->dev;
 	size_t spad_sz, spad_off;
-	int ret;
+	int ret, cur;
 
 	pci_set_drvdata(pdev, ndev);
 
@@ -646,6 +653,17 @@ static int ntb_epf_init_pci(struct ntb_epf_dev *ndev,
 
 	pci_set_master(pdev);
 
+	if (soc && pci_is_pcie(pdev) && soc->force_mrrs) {
+		cur = pcie_get_readrq(pdev);
+		ret = pcie_set_readrq(pdev, soc->force_mrrs);
+		if (ret)
+			dev_warn(&pdev->dev, "failed to set MRRS=%d: %d\n",
+				 soc->force_mrrs, ret);
+		else
+			dev_info(&pdev->dev, "capped MRRS: %d->%d for ntb-epf\n",
+				 cur, soc->force_mrrs);
+	}
+
 	ret = dma_set_mask_and_coherent(dev, DMA_BIT_MASK(64));
 	if (ret) {
 		ret = dma_set_mask_and_coherent(dev, DMA_BIT_MASK(32));
@@ -720,6 +738,7 @@ static void ntb_epf_cleanup_isr(struct ntb_epf_dev *ndev)
 static int ntb_epf_pci_probe(struct pci_dev *pdev,
 			     const struct pci_device_id *id)
 {
+	const struct ntb_epf_soc_data *soc = (const void *)id->driver_data;
 	struct device *dev = &pdev->dev;
 	struct ntb_epf_dev *ndev;
 	int ret;
@@ -731,16 +750,16 @@ static int ntb_epf_pci_probe(struct pci_dev *pdev,
 	if (!ndev)
 		return -ENOMEM;
 
-	ndev->barno_map = (const enum pci_barno *)id->driver_data;
-	if (!ndev->barno_map)
+	if (!soc || !soc->barno_map)
 		return -EINVAL;
 
+	ndev->barno_map = soc->barno_map;
 	ndev->dev = dev;
 
 	ntb_epf_init_struct(ndev, pdev);
 	mutex_init(&ndev->cmd_lock);
 
-	ret = ntb_epf_init_pci(ndev, pdev);
+	ret = ntb_epf_init_pci(ndev, pdev, soc);
 	if (ret) {
 		dev_err(dev, "Failed to init PCI\n");
 		return ret;
@@ -812,21 +831,52 @@ static const enum pci_barno rcar_barno[NTB_BAR_NUM] = {
 	[BAR_MW4]	= NO_BAR,
 };
 
+static const struct ntb_epf_soc_data j721e_soc = {
+	.barno_map = j721e_map,
+};
+
+static const struct ntb_epf_soc_data mx8_soc = {
+	.barno_map = mx8_map,
+};
+
+static const struct ntb_epf_soc_data rcar_soc = {
+	.barno_map = rcar_barno,
+	/*
+	 * On some R-Car platforms using the Synopsys DWC PCIe + eDMA we
+	 * observe data corruption on RC->EP Remote DMA Read paths whenever
+	 * the EP issues large MRd requests. The corruption consistently
+	 * hits the tail of each 256-byte segment (e.g. offsets
+	 * 0x00E0..0x00FF within a 256B block, and again at 0x01E0..0x01FF
+	 * for larger transfers).
+	 *
+	 * The DMA injects multiple MRd requests of size less than or equal
+	 * to the min(MRRS, MPS) into the outbound request path. By
+	 * lowering MRRS to 128 we prevent 256B MRd TLPs from being
+	 * generated and avoid the issue on the affected hardware. We
+	 * intentionally keep MPS unchanged and scope this quirk to this
+	 * endpoint to avoid impacting unrelated devices.
+	 *
+	 * Remove this once the issue is resolved (maybe controller/IP
+	 * level) or a more preferable workaround becomes available.
+	 */
+	.force_mrrs = 128,
+};
+
 static const struct pci_device_id ntb_epf_pci_tbl[] = {
 	{
 		PCI_DEVICE(PCI_VENDOR_ID_TI, PCI_DEVICE_ID_TI_J721E),
 		.class = PCI_CLASS_MEMORY_RAM << 8, .class_mask = 0xffff00,
-		.driver_data = (kernel_ulong_t)j721e_map,
+		.driver_data = (kernel_ulong_t)&j721e_soc,
 	},
 	{
 		PCI_DEVICE(PCI_VENDOR_ID_FREESCALE, 0x0809),
 		.class = PCI_CLASS_MEMORY_RAM << 8, .class_mask = 0xffff00,
-		.driver_data = (kernel_ulong_t)mx8_map,
+		.driver_data = (kernel_ulong_t)&mx8_soc,
 	},
 	{
 		PCI_DEVICE(PCI_VENDOR_ID_RENESAS, 0x0030),
 		.class = PCI_CLASS_MEMORY_RAM << 8, .class_mask = 0xffff00,
-		.driver_data = (kernel_ulong_t)rcar_barno,
+		.driver_data = (kernel_ulong_t)&rcar_soc,
 	},
 	{ },
 };
-- 
2.51.0


