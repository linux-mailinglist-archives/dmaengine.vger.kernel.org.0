Return-Path: <dmaengine+bounces-11662-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id kAT2A2TJNmqJEwcAu9opvQ
	(envelope-from <dmaengine+bounces-11662-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Sat, 20 Jun 2026 19:09:56 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 857E06A950E
	for <lists+dmaengine@lfdr.de>; Sat, 20 Jun 2026 19:09:55 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=valinux.co.jp header.s=selector1 header.b=dhM+uqQ9;
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-11662-lists+dmaengine=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="dmaengine+bounces-11662-lists+dmaengine=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=valinux.co.jp;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7C2EC3010B84
	for <lists+dmaengine@lfdr.de>; Sat, 20 Jun 2026 17:08:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 771BC2DB7B9;
	Sat, 20 Jun 2026 17:08:56 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from TY3P286CU002.outbound.protection.outlook.com (mail-japaneastazon11020102.outbound.protection.outlook.com [52.101.229.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 838DD2C3757;
	Sat, 20 Jun 2026 17:08:54 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781975336; cv=fail; b=oBl+a5wO1Edg2owUVce0b9tnhQaBEJfhKnek988wyu7TH+g47rGd5opiX11PQeSk6h1wECyGWgzyMfMoHa2QSQh+KMQemcb6vf/XexZtZTol9hKoH4OMgA25QTwjBYHoa+qnCFa8r2gfpCdWWFZ5LiTysQy5sSUsJF+cSBEpmHI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781975336; c=relaxed/simple;
	bh=onSpwG7jl28EOq+Fck1E2wnpCizmaqU5KcOITvmVW28=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=QjkROIUwq2qTg/S5p/VsPIT6P2hKC86SqSRURcgLQY3KNDyDcr+/YSW4+QrbReJUaBJobIO7YXoDeQsRtVP7T7/kGp5IOLG2rZRr91Jr4opO6jkj42rIwpe5eY/OX2lPXHig7T1+tQ/wrV3fwWY7JT36mWChlrOUI5rRh12p2E4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=dhM+uqQ9; arc=fail smtp.client-ip=52.101.229.102
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Eghs1FebLF4YFqrcHm0MI95nBHxGKECsCBhy4XFqFGUAS0lDWm2VlZV1JehaRiKeMpBTJUK0XTdX06RHfWVnO3PG3qythoFJXF2yoq0jOtcFfQku81NG9urqJjMOKYGT/RVIA5O1TIFv6tI1gm0dCgHn/ON26SWtUNFA1H0Z8mRCHkeVJDHeEzO2xYFdpWs2N1IHUUxbDf9tbqkZvFYwN6aYts6wYhYQx7lCV/wLuHmVxck4qjMnIG4K4teJAHWc+fxrl3qQOAJhU4nVBYlQ+YIucQxVkWhTwKpVIa+LLLK3qMzJlncRhMMnJo47q+3thfQzlgj5MGf3aWjl3jPamg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hFdwKOTYjlouwC/Pwo7cWbcNcbZ0UIZCf9Ff8tms8Dk=;
 b=W8LTvZcEgG7JPkoJevrwaCGFd5Fv2DSAoE0oHT5m1wdOir5FLxeb5wNNJMN9DiJvtI/0W2aNhPRrzQUbGz6ylGM2ptWLfszeUcY4qsHW4gb2um64bM1Z2pqi2qYmfLOKkQZinyPzpNpX/QqKuL0/6cSI0COfPM7dw3By1pw2nSRudcsVCp8LVzouLW4Z23JH+G3E+A9qQ2HRIID55W20EsrSdSftg38YMptq4Mr+KQjFIGNyGAC0+JvN1paxpw4aB0dn2zv8l2OWuzvpJ7MVEiqwYOQnSo1CHXzd40Uk+FbgR7JTcDofqnAsoVaYSqN7Jk9xaCCkU0MLh+KbIVol5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hFdwKOTYjlouwC/Pwo7cWbcNcbZ0UIZCf9Ff8tms8Dk=;
 b=dhM+uqQ9YXqJAzChSwI2HiZ82/P4OkVu2wjkK6UHoIx4/5LiLJCXXly18/4I8bvfZhsEKUdSlKKOey1oi9p0adGx3fMa6RzBh9jes2rf8gJI+gwKwucEzobnoXALm1WHAJMXs3ixqRMuFSdQmJ4SNqDwEWD/6oNFSDsB+NRWJoE=
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:38f::10)
 by OS9P286MB4352.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:2c6::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.18; Sat, 20 Jun
 2026 17:08:52 +0000
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32]) by TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32%5]) with mapi id 15.21.0139.009; Sat, 20 Jun 2026
 17:08:52 +0000
From: Koichiro Den <den@valinux.co.jp>
To: Manivannan Sadhasivam <mani@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Vinod Koul <vkoul@kernel.org>,
	Frank Li <Frank.Li@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Damien Le Moal <dlemoal@kernel.org>,
	Niklas Cassel <cassel@kernel.org>
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
	Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
	linux-pci@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	dmaengine@vger.kernel.org
Subject: [PATCH v3 1/3] dmaengine: dw-edma-pcie: Discover endpoint DMA metadata
Date: Sun, 21 Jun 2026 02:08:42 +0900
Message-ID: <20260620170844.3757241-2-den@valinux.co.jp>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260620170844.3757241-1-den@valinux.co.jp>
References: <20260620170844.3757241-1-den@valinux.co.jp>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TY4PR01CA0009.jpnprd01.prod.outlook.com
 (2603:1096:405:26e::12) To TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:38f::10)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY7P286MB7722:EE_|OS9P286MB4352:EE_
X-MS-Office365-Filtering-Correlation-Id: 9e99d9a9-ebd7-4a2f-726c-08deceee9a84
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|7416014|1800799024|10070799003|23010399003|22082099003|18002099003|56012099006|921020|3023799007;
X-Microsoft-Antispam-Message-Info:
	AGhLtE2d9DrYb50VNKngo8GZgPBGnK7/p8Gvvx0kLCMYv+L/49rSpAqgkfpHPrWog2zcQ/T4qaXyQkzZVDvv8FIRKQZSiungBlqGRygvfT+akMfy6B/H5ETfUluKgfADqljn323PtQCDynaXN5TNMcxcyi/IpG01H3pWjNUMMpZ0x+3zf7Tucd5M8f658DnD3y0AUj9hwXSnxuXrqknNBfxHMqu0zyfPLfPjjOIp9uQRUB8YL9S+1oE4rfm7dSyVPjwYe6A/zFfGFogW0p8b8trTM/nswiuEtAiESPwGY+70f9rvcKYG5eN1JmwFDcRYzYOZgyuNYg7RGqFWY+TEM97ToGzrRETd0ZJYH6t3nRzQh3jLg+muTAKt+Vq8gJQW+ogMPqwIXVR1tqdROzLuZCPLYxvwXsIlh6jvxql0A1HH4D6j8QK71iJXA2ttcIe4TfcPQt/ZGj7BOYR6CPYssE2Ddh+w7+QmNjJZYqRh5PAHMj/tJEqUS6fZS6rrc9Y2IjEWciCrryqNKUqtXhfTbwN+Z86gxRq57x5w0Z3xOd85pjmm+GBFNfdG/cWPewP/6bkmHrsVp4HIRpKK6t2CtXsvwDJeyizUvQK80ysNbfuQwRaHdC4PAk8rAXSHwYwBqdESDHLCLfi19BrjhSzPmGlT0xiDJPzd4EV63c6Eg+iemAlCJhNHf7KcS/IRRY6LE9vD9IuICak34PBHDPh8oA==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024)(10070799003)(23010399003)(22082099003)(18002099003)(56012099006)(921020)(3023799007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?p5z6EW5y8N43cbMZkHGb6b5W9/q91oFCvZRxBRD7vA7gYNTWxO7dZiFhij3b?=
 =?us-ascii?Q?nLhcegarkeoSi1RI8gqNO28eNiJ7CQOVMsG8Y8J+xVPWt6Ntf1GWuKyIqO2u?=
 =?us-ascii?Q?Ov+6jgxMQpYPfNSewl1eCEO5L6a7fqOsQtZJzCgg1DAsW/USdQ9DWvKG3vDr?=
 =?us-ascii?Q?lN9Kzc6/4wUqXzmBnBJxvzCykW8/fM+0HBmaOHzCf1Tt/0XRIXsTGPVxCnL2?=
 =?us-ascii?Q?6FR0nQKYOnqeA2NNodYdT8CP1SSX8u/D6bgkMQO06g6hmkSYoXtafoZnS3b8?=
 =?us-ascii?Q?0AlAfkM2okq3tOpf+Gz9xUcLRDHETOMOoCTLCeEGiIh68yUip0bEkW5dXweN?=
 =?us-ascii?Q?/MfhiiMzf8Eq9oHX6oROoaoKh+dBVu9DU2HTO5S7+DgPrJyinWtLYznHBG7z?=
 =?us-ascii?Q?e6MUTExGJ+Y0Ltk9HInPYPx53gKvPfmM/m40yS6kg6yrR4E8zJVxJE7HcfAn?=
 =?us-ascii?Q?YRK7vVcrDT9AXSFAeMj655rwTq0nczcMdfOOPVeS3XRKhf3OWiCh5LC9O0Bb?=
 =?us-ascii?Q?EuXEAXBZO5gFp5lMyW9CeUtEq3X8wweVLUkAgzR7XV3QndEQZr85/3/wKTda?=
 =?us-ascii?Q?t0j0JSpdZiLPG1mwtkojw4Vfc3nGZWz38onMSSbwgKTxk8OlBP+Clm3ztf6Z?=
 =?us-ascii?Q?7tZJ2Qkh0yZpMm2d6F6t5DzVe7DfhenvBFRsv3JhdLC+ZVquiMotXyEqaD5z?=
 =?us-ascii?Q?b0HhAf2M7ClRKJDAK/f7NoWgxvGYlxVN6rrYGoXLKt+M8g5Q4omMSI5F2t3v?=
 =?us-ascii?Q?DvFAHBc/gXLP8nON+GwRXqX2eqOoIPPswp12M164NcvhEs2NBG/tDYR21k9o?=
 =?us-ascii?Q?YbsOZFnrZqwCHUB9+KxtNioQd/JwR9ZF7sd7kud9S6DPYJJc2cEfge1Zy00Q?=
 =?us-ascii?Q?n/Q5Rg1h4ZwxdXYJgoq7RTY+sKjIAsIaueHrhpvEST3KKFU7u7WlsTckO4Zl?=
 =?us-ascii?Q?9rXGf66FQYT6gwphy0v7kzUl5fl8+Uvi3+/b1u3+a2HJ0v+W7UsfeA4l78VU?=
 =?us-ascii?Q?vQcGcMVYz2ptAxqU8sIOyZXFldIgVZ1OpXv5n59BHj/d3CpwyKGFid4aP5re?=
 =?us-ascii?Q?InYaQJ24aB5D/dJNVFE0hlX4S/GB9tL0kglTTBKvK6xcBWVCo+AjFAt1OkA6?=
 =?us-ascii?Q?jAXyMu6dcvFovLGwFyOfeFOCsKyuUSNU2emxzGtj3t+gFOTxAlACFz5iFV1L?=
 =?us-ascii?Q?P3RGL1MgTl9Eor8Fzf0Ec2Oj/u/O5hIQV1A/jK5fOtOB6XZsN/7kSAbeZVza?=
 =?us-ascii?Q?XtufXmlDz7c3o3owi3oYdhPK8BwTLceEXXSFtoy8IMujlb/X37bhnYDbSAMf?=
 =?us-ascii?Q?dt1361i+bipNHFCrMHTiAoo58Jt886sFR8Kj87+5IzPnPupLazNTMRtBJgSo?=
 =?us-ascii?Q?TwiJ+Qy+AK7fp4yqKQjPAcYuMH3qC8Jl2iC3waR3ogu/s/OzVT/UYD2DF1wE?=
 =?us-ascii?Q?euWD8g+FOozbHKDRw7EFHqc++lRKAo4KwcnNds2/F1YymxDAjA02JCHxlzN2?=
 =?us-ascii?Q?7Arah/OsiSJmF5h1t6Iun3bP7eMZriq+ekvczG5VYY68WqpJWSNIRp/8EQ+G?=
 =?us-ascii?Q?nUgpYWdBQ+q3Fe9SSRNeEIAEYLwMrC3M+2XMzsV05WPtrFcdaO3qTsBKbpkk?=
 =?us-ascii?Q?8tuk/nFG1gn8lVo4hWAQVJJsOtezEbR024rjMzZy6U7Vwj0fnLMnVrLkROCz?=
 =?us-ascii?Q?g7jp8kwPyaLIOsk4oDDWjKBqDrk4tNxWebawIZhFdUKUytSRlcllOz+3dJgZ?=
 =?us-ascii?Q?7TV7fU8gbhShx6oMgIlc9+atK+i+TPfzL5pL1p5CNyKG0ccxfunv?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: 9e99d9a9-ebd7-4a2f-726c-08deceee9a84
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jun 2026 17:08:52.3533
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VOC/E7tZgwQpfVnR3vRAVm1CRCmp6+aNUGhWARniAYRd8I+DJHV36fl41mqNvmgl9DGhV+Ddx7pnJoKvGJ4bFg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS9P286MB4352
X-Rspamd-Action: no action
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[valinux.co.jp,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[valinux.co.jp:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER(0.00)[den@valinux.co.jp,dmaengine@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[17];
	TAGGED_FROM(0.00)[bounces-11662-lists,dmaengine=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:mani@kernel.org,m:kwilczynski@kernel.org,m:kishon@kernel.org,m:bhelgaas@google.com,m:corbet@lwn.net,m:skhan@linuxfoundation.org,m:vkoul@kernel.org,m:Frank.Li@kernel.org,m:arnd@arndb.de,m:dlemoal@kernel.org,m:cassel@kernel.org,m:marek.vasut+renesas@mailbox.org,m:yoshihiro.shimoda.uh@renesas.com,m:linux-pci@vger.kernel.org,m:linux-doc@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:dmaengine@vger.kernel.org,m:marek.vasut@mailbox.org,s:lists@lfdr.de];
	DKIM_TRACE(0.00)[valinux.co.jp:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[den@valinux.co.jp,dmaengine@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[dmaengine,renesas];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,valinux.co.jp:dkim,valinux.co.jp:email,valinux.co.jp:mid,valinux.co.jp:from_mime,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 857E06A950E

Teach dw-edma-pcie to discover a PCI endpoint DMA function from
BAR-resident metadata. The metadata supplies the DMA register window,
channel counts, descriptor windows, optional auxiliary windows, and
endpoint-local descriptor and auxiliary addresses. Accept DesignWare
eDMA unroll, HDMA compatible, and HDMA native linked-list layouts.

Endpoint-provided DMA channels use raw slave addresses because the host
programs transfers against endpoint physical addresses, not PCI BAR
addresses. The host-side dw-edma-pcie instance is remote-routed by
default, so delegated channels report completions through IMWr/MSI.

Endpoint DMA metadata currently has no static PCI ID. Let an explicit
driver_override bind use the generic endpoint DMA metadata parser, but
do not treat arbitrary dynamic IDs without driver data as endpoint DMA
devices.

The endpoint polls HOST_REQ at a low idle rate before programming DMA
window submaps and setting READY. Let the host wait for several endpoint
poll periods before treating the READY handshake as timed out.

Signed-off-by: Koichiro Den <den@valinux.co.jp>
---
Changes in v3:
  - Select endpoint DMA match data before copying DMA data (Sashiko).
  - Require driver_override for the generic endpoint DMA fallback
    (Sashiko).
  - Accept HDMA native linked-list endpoint DMA metadata.

 drivers/dma/dw-edma/dw-edma-pcie.c | 380 ++++++++++++++++++++++++++++-
 1 file changed, 378 insertions(+), 2 deletions(-)

diff --git a/drivers/dma/dw-edma/dw-edma-pcie.c b/drivers/dma/dw-edma/dw-edma-pcie.c
index 1e75fefae9b8..2a56ee19d4cb 100644
--- a/drivers/dma/dw-edma/dw-edma-pcie.c
+++ b/drivers/dma/dw-edma/dw-edma-pcie.c
@@ -11,9 +11,13 @@
 #include <linux/pci.h>
 #include <linux/device.h>
 #include <linux/dma/edma.h>
+#include <linux/iopoll.h>
 #include <linux/pci-epf.h>
 #include <linux/msi.h>
 #include <linux/bitfield.h>
+#include <linux/io.h>
+#include <linux/overflow.h>
+#include <linux/pci-ep-dma.h>
 #include <linux/sizes.h>
 
 #include "dw-edma-core.h"
@@ -45,6 +49,9 @@
 #define DW_PCIE_XILINX_MDB_DT_OFF_GAP		0x100000
 #define DW_PCIE_XILINX_MDB_DT_SIZE		0x800
 
+#define DW_PCIE_EP_DMA_READY_POLL_US		1000
+#define DW_PCIE_EP_DMA_READY_TIMEOUT_US		2000000
+
 #define DW_BLOCK(a, b, c) \
 	{ \
 		.bar = a, \
@@ -94,6 +101,12 @@ struct dw_edma_pcie_match_data {
 #define DW_EDMA_PCIE_F_DEVMEM_PHYS_OFF	BIT(0)
 #define DW_EDMA_PCIE_F_REG_OFFSET	BIT(1)
 
+struct dw_edma_pcie_ep_dma_view {
+	struct pci_dev *pdev;
+	void __iomem *base;
+	resource_size_t limit;
+};
+
 static const struct dw_edma_pcie_data snps_edda_data = {
 	/* eDMA registers location */
 	.rg.bar				= BAR_0,
@@ -158,6 +171,13 @@ static const struct dw_edma_pcie_data xilinx_cpm6_dma_data = {
 	.rd_ch_cnt			= 8,
 };
 
+static const struct dw_edma_pcie_data ep_dma_data = {
+	.mf				= EDMA_MF_EDMA_UNROLL,
+	.irqs				= EDMA_MAX_WR_CH + EDMA_MAX_RD_CH,
+	.wr_ch_cnt			= EDMA_MAX_WR_CH,
+	.rd_ch_cnt			= EDMA_MAX_RD_CH,
+};
+
 static void dw_edma_set_chan_region_offset(struct dw_edma_pcie_data *pdata,
 					   enum pci_barno bar, off_t start_off,
 					   off_t ll_off_gap, size_t ll_size,
@@ -227,6 +247,86 @@ static const struct dw_edma_plat_ops dw_edma_pcie_plat_ops = {
 	.pci_address = dw_edma_pcie_address,
 };
 
+static const struct dw_edma_plat_ops dw_edma_pcie_raw_addr_plat_ops = {
+	.irq_vector = dw_edma_pcie_irq_vector,
+};
+
+static bool dw_edma_pcie_valid_bar(enum pci_barno bar)
+{
+	return bar >= BAR_0 && bar <= BAR_5;
+}
+
+static bool dw_edma_pcie_valid_bar_range(struct pci_dev *pdev,
+					 enum pci_barno bar, u64 off,
+					 size_t sz)
+{
+	resource_size_t bar_len;
+
+	if (!dw_edma_pcie_valid_bar(bar) || !sz)
+		return false;
+
+	bar_len = pci_resource_len(pdev, bar);
+
+	return off <= bar_len && sz <= bar_len - off;
+}
+
+static bool dw_edma_pcie_valid_block(struct pci_dev *pdev,
+				     const struct dw_edma_block *block)
+{
+	return dw_edma_pcie_valid_bar_range(pdev, block->bar, block->off,
+					    block->sz);
+}
+
+static bool dw_edma_pcie_ep_dma_bar_scannable(struct pci_dev *pdev,
+					      enum pci_barno bar)
+{
+	unsigned long flags = pci_resource_flags(pdev, bar);
+
+	if (!(flags & IORESOURCE_MEM))
+		return false;
+
+	if (flags & (IORESOURCE_UNSET | IORESOURCE_DISABLED))
+		return false;
+
+	return pci_resource_len(pdev, bar) >= PCI_EP_DMA_METADATA_HDR_LEN;
+}
+
+static u32 dw_edma_pcie_ep_dma_readl(struct dw_edma_pcie_ep_dma_view *view,
+				     u16 off)
+{
+	return readl(view->base + off);
+}
+
+static void dw_edma_pcie_ep_dma_writel(struct dw_edma_pcie_ep_dma_view *view,
+				       u16 off, u32 val)
+{
+	writel(val, view->base + off);
+}
+
+static u64 dw_edma_pcie_ep_dma_read64(struct dw_edma_pcie_ep_dma_view *view,
+				      u16 lo, u16 hi)
+{
+	u64 val;
+
+	val = dw_edma_pcie_ep_dma_readl(view, hi);
+
+	return (val << 32) | dw_edma_pcie_ep_dma_readl(view, lo);
+}
+
+static int dw_edma_pcie_ep_dma_read_off(struct dw_edma_pcie_ep_dma_view *view,
+					u16 lo, u16 hi, off_t *off)
+{
+	u64 val;
+
+	val = dw_edma_pcie_ep_dma_read64(view, lo, hi);
+	if (val > type_max(*off))
+		return -EINVAL;
+
+	*off = val;
+
+	return 0;
+}
+
 static void dw_edma_pcie_get_synopsys_dma_data(struct pci_dev *pdev,
 					       struct dw_edma_pcie_data *pdata)
 {
@@ -328,6 +428,265 @@ static void dw_edma_pcie_get_xilinx_dma_data(struct pci_dev *pdev,
 	pdata->devmem_phys_off = off;
 }
 
+static int
+dw_edma_pcie_parse_ep_dma_ch_table(struct dw_edma_pcie_ep_dma_view *view,
+				   struct dw_edma_pcie_data *pdata,
+				   u16 table_off, u16 entry_size, u16 ch_cnt,
+				   bool write)
+{
+	struct dw_edma_block *desc_blocks = write ? pdata->ll_wr : pdata->ll_rd;
+	struct dw_edma_block *data_blocks = write ? pdata->dt_wr : pdata->dt_rd;
+	u32 ctrl;
+	u16 i;
+	int ret;
+
+	for (i = 0; i < ch_cnt; i++) {
+		struct dw_edma_block *desc_block = &desc_blocks[i];
+		struct dw_edma_block *data_block = &data_blocks[i];
+		u16 off = table_off + i * entry_size;
+		u16 field, lo, hi;
+
+		field = off + PCI_EP_DMA_METADATA_CH_CTRL;
+		ctrl = dw_edma_pcie_ep_dma_readl(view, field);
+		if (FIELD_GET(PCI_EP_DMA_METADATA_CH_CTRL_HW_CH, ctrl) != i)
+			return -EOPNOTSUPP;
+
+		desc_block->bar =
+			FIELD_GET(PCI_EP_DMA_METADATA_CH_CTRL_DESC_BAR, ctrl);
+		lo = off + PCI_EP_DMA_METADATA_CH_DESC_OFF_LO;
+		hi = off + PCI_EP_DMA_METADATA_CH_DESC_OFF_HI;
+		ret = dw_edma_pcie_ep_dma_read_off(view, lo, hi,
+						   &desc_block->off);
+		if (ret)
+			return ret;
+		field = off + PCI_EP_DMA_METADATA_CH_DESC_SIZE;
+		desc_block->sz = dw_edma_pcie_ep_dma_readl(view, field);
+		lo = off + PCI_EP_DMA_METADATA_CH_DESC_ADDR_LO;
+		hi = off + PCI_EP_DMA_METADATA_CH_DESC_ADDR_HI;
+		desc_block->paddr =
+			dw_edma_pcie_ep_dma_read64(view, lo, hi);
+		desc_block->paddr_valid = true;
+		if (!dw_edma_pcie_valid_block(view->pdev, desc_block))
+			return -EINVAL;
+
+		*data_block = (struct dw_edma_block) { .bar = NO_BAR };
+		if (!(ctrl & PCI_EP_DMA_METADATA_CH_CTRL_AUX_VALID))
+			continue;
+
+		data_block->bar =
+			FIELD_GET(PCI_EP_DMA_METADATA_CH_CTRL_AUX_BAR, ctrl);
+		lo = off + PCI_EP_DMA_METADATA_CH_AUX_OFF_LO;
+		hi = off + PCI_EP_DMA_METADATA_CH_AUX_OFF_HI;
+		ret = dw_edma_pcie_ep_dma_read_off(view, lo, hi,
+						   &data_block->off);
+		if (ret)
+			return ret;
+		field = off + PCI_EP_DMA_METADATA_CH_AUX_SIZE;
+		data_block->sz = dw_edma_pcie_ep_dma_readl(view, field);
+		lo = off + PCI_EP_DMA_METADATA_CH_AUX_ADDR_LO;
+		hi = off + PCI_EP_DMA_METADATA_CH_AUX_ADDR_HI;
+		data_block->paddr =
+			dw_edma_pcie_ep_dma_read64(view, lo, hi);
+		data_block->paddr_valid = true;
+		if (!dw_edma_pcie_valid_block(view->pdev, data_block))
+			return -EINVAL;
+	}
+
+	return 0;
+}
+
+static int
+dw_edma_pcie_ep_dma_wait_ready(struct dw_edma_pcie_ep_dma_view *view)
+{
+	u32 val;
+
+	return read_poll_timeout(dw_edma_pcie_ep_dma_readl, val,
+				 val & PCI_EP_DMA_METADATA_CTRL_READY,
+				 DW_PCIE_EP_DMA_READY_POLL_US,
+				 DW_PCIE_EP_DMA_READY_TIMEOUT_US, false,
+				 view, PCI_EP_DMA_METADATA_CTRL);
+}
+
+static int
+dw_edma_pcie_validate_ep_dma_metadata(struct dw_edma_pcie_ep_dma_view *view,
+				      u32 *metadata_ctrl, u8 *reg_layout_data)
+{
+	size_t table_size, table_end;
+	enum pci_barno reg_bar;
+	u16 len, entry_size;
+	u16 wr_ch_cnt, rd_ch_cnt;
+	u8 layout, layout_data;
+	u32 val;
+
+	val = dw_edma_pcie_ep_dma_readl(view, 0);
+	if (val != PCI_EP_DMA_METADATA_MAGIC)
+		return -ENODEV;
+
+	val = dw_edma_pcie_ep_dma_readl(view, PCI_EP_DMA_METADATA_HDR);
+	if (FIELD_GET(PCI_EP_DMA_METADATA_HDR_REV, val) !=
+	    PCI_EP_DMA_METADATA_REV)
+		return -EINVAL;
+
+	len = FIELD_GET(PCI_EP_DMA_METADATA_HDR_LEN_FIELD, val);
+	if (len < PCI_EP_DMA_METADATA_HDR_LEN)
+		return -EINVAL;
+	if (len > view->limit)
+		return -EINVAL;
+
+	val = dw_edma_pcie_ep_dma_readl(view, PCI_EP_DMA_METADATA_REG_LAYOUT);
+	layout = FIELD_GET(PCI_EP_DMA_METADATA_REG_LAYOUT_ID, val);
+	if (layout != PCI_EP_DMA_METADATA_REG_LAYOUT_DW_EDMA)
+		return -EOPNOTSUPP;
+
+	layout_data = FIELD_GET(PCI_EP_DMA_METADATA_REG_LAYOUT_DATA, val);
+	if (layout_data == EDMA_MF_EDMA_LEGACY)
+		return -EOPNOTSUPP;
+	if (layout_data != EDMA_MF_EDMA_UNROLL &&
+	    layout_data != EDMA_MF_HDMA_COMPAT &&
+	    layout_data != EDMA_MF_HDMA_NATIVE)
+		return -EINVAL;
+
+	val = dw_edma_pcie_ep_dma_readl(view, PCI_EP_DMA_METADATA_CTRL);
+	reg_bar = FIELD_GET(PCI_EP_DMA_METADATA_CTRL_REG_BAR, val);
+	if (!dw_edma_pcie_valid_bar(reg_bar))
+		return -EINVAL;
+
+	wr_ch_cnt = FIELD_GET(PCI_EP_DMA_METADATA_CTRL_WR_CH_COUNT, val);
+	rd_ch_cnt = FIELD_GET(PCI_EP_DMA_METADATA_CTRL_RD_CH_COUNT, val);
+	if (!wr_ch_cnt && !rd_ch_cnt)
+		return -EINVAL;
+	if (wr_ch_cnt > EDMA_MAX_WR_CH || rd_ch_cnt > EDMA_MAX_RD_CH)
+		return -EINVAL;
+
+	entry_size = FIELD_GET(PCI_EP_DMA_METADATA_CTRL_CH_ENTRY_SIZE, val);
+	if (entry_size < PCI_EP_DMA_METADATA_CH_ENTRY_SIZE ||
+	    entry_size % sizeof(u32))
+		return -EINVAL;
+
+	if (check_mul_overflow((size_t)(wr_ch_cnt + rd_ch_cnt),
+			       (size_t)entry_size, &table_size) ||
+	    check_add_overflow((size_t)PCI_EP_DMA_METADATA_HDR_LEN,
+			       table_size, &table_end) ||
+	    table_end > len)
+		return -EINVAL;
+
+	if (metadata_ctrl)
+		*metadata_ctrl = val;
+	if (reg_layout_data)
+		*reg_layout_data = layout_data;
+
+	return 0;
+}
+
+static int
+dw_edma_pcie_parse_ep_dma_data(struct dw_edma_pcie_ep_dma_view *view,
+			       struct dw_edma_pcie_data *pdata)
+{
+	u32 ctrl, reg_sz;
+	u8 reg_layout_data;
+	u64 reg_off;
+	u16 wr_table, rd_table, entry_size;
+	u16 wr_ch_cnt, rd_ch_cnt;
+	int ret;
+
+	ret = dw_edma_pcie_validate_ep_dma_metadata(view, &ctrl,
+						    &reg_layout_data);
+	if (ret)
+		return ret;
+
+	pci_dbg(view->pdev, "Detected PCI endpoint DMA BAR metadata\n");
+
+	pdata->mf = reg_layout_data;
+	pdata->rg.bar = FIELD_GET(PCI_EP_DMA_METADATA_CTRL_REG_BAR, ctrl);
+
+	wr_ch_cnt = FIELD_GET(PCI_EP_DMA_METADATA_CTRL_WR_CH_COUNT, ctrl);
+	rd_ch_cnt = FIELD_GET(PCI_EP_DMA_METADATA_CTRL_RD_CH_COUNT, ctrl);
+	pdata->wr_ch_cnt = min_t(u16, pdata->wr_ch_cnt, wr_ch_cnt);
+	pdata->rd_ch_cnt = min_t(u16, pdata->rd_ch_cnt, rd_ch_cnt);
+	pdata->irqs = pdata->wr_ch_cnt + pdata->rd_ch_cnt;
+	reg_off = dw_edma_pcie_ep_dma_read64(view,
+					     PCI_EP_DMA_METADATA_REG_OFF_LO,
+					     PCI_EP_DMA_METADATA_REG_OFF_HI);
+	reg_sz = dw_edma_pcie_ep_dma_readl(view, PCI_EP_DMA_METADATA_REG_SIZE);
+	if (reg_off > type_max(pdata->rg.off) ||
+	    !dw_edma_pcie_valid_bar_range(view->pdev, pdata->rg.bar,
+					  reg_off, reg_sz))
+		return -EINVAL;
+	pdata->rg.off = reg_off;
+	pdata->rg.sz = reg_sz;
+
+	entry_size = FIELD_GET(PCI_EP_DMA_METADATA_CTRL_CH_ENTRY_SIZE, ctrl);
+	wr_table = PCI_EP_DMA_METADATA_HDR_LEN;
+	rd_table = PCI_EP_DMA_METADATA_HDR_LEN + wr_ch_cnt * entry_size;
+
+	ret = dw_edma_pcie_parse_ep_dma_ch_table(view, pdata, wr_table,
+						 entry_size, pdata->wr_ch_cnt,
+						 true);
+	if (ret)
+		return ret;
+
+	return dw_edma_pcie_parse_ep_dma_ch_table(view, pdata, rd_table,
+						  entry_size,
+						  pdata->rd_ch_cnt, false);
+}
+
+static int
+dw_edma_pcie_parse_ep_dma_caps(struct pci_dev *pdev,
+			       struct dw_edma_pcie_data *pdata)
+{
+	struct dw_edma_pcie_ep_dma_view metadata_view;
+	void __iomem *base;
+	resource_size_t bar_len;
+	enum pci_barno bar;
+	u32 ctrl;
+	int ret;
+
+	for (bar = BAR_0; bar < PCI_STD_NUM_BARS; bar++) {
+		if (!dw_edma_pcie_ep_dma_bar_scannable(pdev, bar))
+			continue;
+
+		bar_len = pci_resource_len(pdev, bar);
+		base = pci_iomap_range(pdev, bar, 0, 0);
+		if (!base)
+			continue;
+
+		metadata_view = (struct dw_edma_pcie_ep_dma_view) {
+			.pdev = pdev,
+			.base = base,
+			.limit = bar_len,
+		};
+		ret = dw_edma_pcie_validate_ep_dma_metadata(&metadata_view,
+							    NULL, NULL);
+		if (ret == -ENODEV) {
+			pci_iounmap(metadata_view.pdev, base);
+			continue;
+		}
+		if (ret) {
+			pci_iounmap(metadata_view.pdev, base);
+			return ret;
+		}
+
+		ctrl = dw_edma_pcie_ep_dma_readl(&metadata_view,
+						 PCI_EP_DMA_METADATA_CTRL);
+		ctrl |= PCI_EP_DMA_METADATA_CTRL_HOST_REQ;
+		dw_edma_pcie_ep_dma_writel(&metadata_view,
+					   PCI_EP_DMA_METADATA_CTRL, ctrl);
+
+		ret = dw_edma_pcie_ep_dma_wait_ready(&metadata_view);
+		if (ret) {
+			pci_iounmap(metadata_view.pdev, base);
+			return ret;
+		}
+
+		ret = dw_edma_pcie_parse_ep_dma_data(&metadata_view, pdata);
+		pci_iounmap(metadata_view.pdev, base);
+
+		return ret;
+	}
+
+	return -ENODEV;
+}
+
 static int
 dw_edma_pcie_parse_synopsys_caps(struct pci_dev *pdev,
 				 struct dw_edma_pcie_data *pdata)
@@ -367,6 +726,14 @@ dw_edma_pcie_parse_xilinx_caps(struct pci_dev *pdev,
 	return 0;
 }
 
+static const struct dw_edma_pcie_match_data ep_dma_match_data = {
+	.data = &ep_dma_data,
+	.plat_ops = &dw_edma_pcie_raw_addr_plat_ops,
+	.parse_caps = dw_edma_pcie_parse_ep_dma_caps,
+	.flags = DW_EDMA_PCIE_F_REG_OFFSET,
+	.chip_flags = DW_EDMA_CHIP_PARTIAL,
+};
+
 static u64 dw_edma_get_phys_addr(struct pci_dev *pdev,
 				 const struct dw_edma_pcie_match_data *match,
 				 struct dw_edma_pcie_data *pdata,
@@ -400,8 +767,17 @@ static int dw_edma_pcie_probe(struct pci_dev *pdev,
 	int err, nr_irqs;
 	int i, mask;
 
-	if (!match)
-		return -ENODEV;
+	if (!match) {
+		/*
+		 * The endpoint DMA metadata path has no static PCI ID yet.
+		 * Accept it only for an explicit driver_override bind, not for
+		 * arbitrary dynamic IDs without driver data.
+		 */
+		if (!device_has_driver_override(&pdev->dev))
+			return -ENODEV;
+
+		match = &ep_dma_match_data;
+	}
 	pdata = match->data;
 
 	if (!pdata)
-- 
2.51.0


