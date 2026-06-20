Return-Path: <dmaengine+bounces-11665-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id xQM5AcPJNmqYEwcAu9opvQ
	(envelope-from <dmaengine+bounces-11665-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Sat, 20 Jun 2026 19:11:31 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 4811A6A952B
	for <lists+dmaengine@lfdr.de>; Sat, 20 Jun 2026 19:11:30 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=valinux.co.jp header.s=selector1 header.b=YdogssyQ;
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-11665-lists+dmaengine=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="dmaengine+bounces-11665-lists+dmaengine=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=valinux.co.jp;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3169D3032CF9
	for <lists+dmaengine@lfdr.de>; Sat, 20 Jun 2026 17:09:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED3172DC783;
	Sat, 20 Jun 2026 17:09:03 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from TY3P286CU002.outbound.protection.outlook.com (mail-japaneastazon11020102.outbound.protection.outlook.com [52.101.229.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83F0023F40D;
	Sat, 20 Jun 2026 17:09:01 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781975343; cv=fail; b=Om5UQBP9BAkGouOXNZiQHKckTDMzbXbG2tS4Ox+FXXtAUKAi63raBDeWzWvl1GYl9vHjF2/m2N/Y1pYj+J5nhrGHRc2QpM1ZOYTfuROv6URhBtLSVaCl87yvHU7+d9WxWALBBsLH8UaAjoPlWYmJ8r1x+yla91CHjaFxBh2Ilac=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781975343; c=relaxed/simple;
	bh=gc9PkTyasA+JRd5aB5t2EarAxZofLXezoMKbgmDqI0w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=FrRm98kKGxSNCLDBMdQcg9ANZmxF2RU5L/KNxjg3G5+fganrMgYh4ysHJ5cfDBLUVzBwsO5TJ5zsRTzBVwFyLE3DMN4j5s+apwhWqzehvGHQq1NPKL2MuWBLgZcQ02FFFNEV+0VtEV2alxn8Y6sWng/f34LpZqiARKUyraUT4dQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=YdogssyQ; arc=fail smtp.client-ip=52.101.229.102
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ElG5ceWwAaPil5nAkWYwDYCo92hH+0YYcNOR6DSGs32edc/6bI2AiY48LTdxFJhSeXbxl/Oxr+vO/3PYas+KxcgL69FbX32NLGn0gloTN8jH5LsGwKTf3Pjd+9Mz9+xyDawrjsSKSOzYan463RZr7bMVn450dCdhZY/VXKiWuGJLbeIlxXlvgwZJtPu+sTCbOeS/EAG9xOTN/6PpnYJEjz5+E87NcXyStiseFZPV36gvuowOSDdWK78K9TsO7eM9SzTmR0PBsBEdsa5/WPEeh7/o/FmeGMl64m6WHTiieQuKRUkkcg+uJBzTHz6eIfJfuqJOV6ieOeQX9RnyK7show==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=15Vix0NdaASSkW44RFUVcpBpPZubW3vl53WMzGc2kcc=;
 b=a4NP/8p9yxWgT6FGfmYSVDDeinXPKV992Nv53xqU22fy3VvRhDMqmbp/+BpVQDv/rjY8DgTC1Psm/PDUgj1a+s5aCGUwnmhdwFYSBpO4u4GGI+KUgNR01t6umuoFzjQhe/yfkvSENMQJwcCMg9Mt2yrEX7k2ng3PLhpdmRWEc5Sa3htbIX7CcpgsPXYeryq35SeIGWDrxuhfgEf9hXPFqVhSqhB05tOQtkqB531zZ8Astdg25T1S+bjr4s0Ihcr1s6JNhSCLBItKWH6McM79mmvINML5IVL2vHy8PB9riRz/o6xDSI6CeqyhD8QviLaF25018u+7Tb+2IUlBPDQjgA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=15Vix0NdaASSkW44RFUVcpBpPZubW3vl53WMzGc2kcc=;
 b=YdogssyQj7WlYJcYrjMBnQR79XkjPAr1Q9KceP5t96Amy8Q5bDGFRQJzX6cKy1LP/Wk1SFloPCz3l2rRIKg5NFqT4o1U6VJ59+VvBP/cuhkppm/6t62mjQJUE4jUbhVskxBUV8ldnqjUIrFIrEgezOksx3zAC+M3RFn0bOPia0I=
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:38f::10)
 by OS9P286MB4352.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:2c6::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.18; Sat, 20 Jun
 2026 17:08:53 +0000
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32]) by TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32%5]) with mapi id 15.21.0139.009; Sat, 20 Jun 2026
 17:08:53 +0000
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
Subject: [PATCH v3 3/3] Documentation: PCI: Add PCI DMA endpoint function documentation
Date: Sun, 21 Jun 2026 02:08:44 +0900
Message-ID: <20260620170844.3757241-4-den@valinux.co.jp>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260620170844.3757241-1-den@valinux.co.jp>
References: <20260620170844.3757241-1-den@valinux.co.jp>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TY4P286CA0036.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:2b2::17) To TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:38f::10)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY7P286MB7722:EE_|OS9P286MB4352:EE_
X-MS-Office365-Filtering-Correlation-Id: 8a106ef2-c4a2-4b7a-c783-08deceee9b63
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|7416014|1800799024|10070799003|23010399003|22082099003|18002099003|56012099006|921020|6133799003|3023799007;
X-Microsoft-Antispam-Message-Info:
	T57hxt+qS9M8a6VbnaTdC4j8yd+8qi4McTf1J0IbNN9js7G6UFRdAnonMUswr8XUwXLLafwQWyKpamz9O7VGtrAGMF60a9HHR5GAzgGkDQhMqu+VTJxogqse9RUFtkgQrDqdwChojUgk3FovsRm2+6YDoGcNNHcy9VBBGpHkZUnwkLZI8LouGKDYyi5sT0qRTlBt8Sy9A94MfpSOaH6dv9Iadw2j2yOG0OgjGAEBPR123q1a1bk2BYsgf2/a9hMqzK3FAUPeFhIKGbrfvBgjgJ2xxRE7hdI6bPjCGvCq2ztUpmTTQaZmkIqVLocfpg7MDaVTGcK/1L+Lr4DvmQdyCWzzifMc8Ou549A05rhUmrdu7jkXpzvax90HhTNTR6gStOwIatx4TCDAMx28fNdAo4n6VEeI89dl8ZzxJKtBHwRHZASLQVNHxOTxdAORhKtLrIxSUuYGGNm3lsTP0kvqsPcKjUGckPAhtEhWeaOV8CGlYBqjQOlyhwK547X9Kc+4PZYCirpNpdx91TFD2XdVD/13R4Wiw9lZK7SlVkjw98sEZ3kyYW3l0kT2b7I/e5uDkkLtnKZ8pF8xQmKACPA0TPbcETFTPjegRmUh7zf/N8MgM82nMPfiaUVDuCfmaIMDL74XKOEGiJrP0wm6+5qF+2/NlZQKvndRCvh8QA5VDHbUQ9H8UeIRGW47z6AW4UnP+aAT5GH18JqAMGfQj4zV8w==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024)(10070799003)(23010399003)(22082099003)(18002099003)(56012099006)(921020)(6133799003)(3023799007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?duOSIikZ26I1wTj6ybrLDL1RcXMMzRJatkQ+lZ6aBK6bD/dnQtyXqKXzT5wf?=
 =?us-ascii?Q?ki+sl4tDnFwLU0ywFheh5oGohPMySSSioswCXrTnItzvsHBHhxwikIMfe5ki?=
 =?us-ascii?Q?CXsi+Crd2h6xYSO+fgcuDR7z0DPuqp2+IQ0uJnD38rWvHORNTRNtLV4NAMv2?=
 =?us-ascii?Q?eVIEl2cpQU9OEyawwUbFzZlqowiX9mzCLZJRHPFkbQixV4QSHvMBFREmJHdx?=
 =?us-ascii?Q?FydmlMoOMvIxCgLGO4hZ8/0r8jUFK1K4YXjTRqi0XIytwuw0r7q7vm6z8++F?=
 =?us-ascii?Q?+7P3PwM69e6Kw95mGLS2+5WbigNLfpKzzMxgZmmUJTCa7CKFrtN2H/ZYDEYx?=
 =?us-ascii?Q?f33vfOLD8a2+g8OsUWBJDumSk5f48gcP4H+nKtSdslbEVRw2cExJ349nLlGN?=
 =?us-ascii?Q?eABcMkws45rt0UjW2TpZj8c+pPnConsF6CtmGENGJr8DqqHxdqiASn//D4nA?=
 =?us-ascii?Q?r/R+ibdB1kFblZMd5nv+h50JAKN/qR2C5Nh7Sh2TrytKrDfYkRTG9K1DkJL1?=
 =?us-ascii?Q?XZMREJgw1qhWp59utgxk694CTyQAZh6Uf3s8S15+qR5SkIW1gFsY0YyrISN5?=
 =?us-ascii?Q?k57gae0UaeJBliV6MtYenHFLBEQmu0OJXUYt4h6irRvyXDIKYMKLUeYQMQUV?=
 =?us-ascii?Q?pxDjz7NOuaiYShKjzRRzh2FK/ccSACQsPnF05vRk9GSreif/f+WE65lxdxdB?=
 =?us-ascii?Q?RWGZlcPrOU8kCgn3nFE3PQgoO0gSGsM4B+uLvI5eLPnEJuBz7X+82KBWLYmj?=
 =?us-ascii?Q?U2jV5S9y6B8qpIF5+XUYlWmyX+VfsCFiO39YmXYlI6MD+fXN4ylZPerktfsT?=
 =?us-ascii?Q?rzOQH/TohjaGA+OJ0ms1hcNnRNNu4GAUGgbIRm7Wd/KxuR1kn36uOkJ/sCVB?=
 =?us-ascii?Q?MC6zgeeldFopHpVu3czv/AD4lLcnVEndBoFjEJjFI/EQmkfEDtwcHs4uZKdS?=
 =?us-ascii?Q?d3wKxEynwk9vzBtIN83XhRuZhK6O2ZhUKq4M6Qng+O4zPdM4xPvKrm/vZVO3?=
 =?us-ascii?Q?PYEh5qpME4JBzWnyyKRs2OB+GUF9gL0l8eI4tY/mVgHhUwXx/D7FQ7IPTbys?=
 =?us-ascii?Q?gr6BTb2oApBuTpHTT6+M1xbCnCRmb+KdxHzj4wvTQ+D7UKsMEUFGb1xYcAmx?=
 =?us-ascii?Q?qdXoVFfL844969UNXXVyil62oAvJkwKFA3l3LwfyNYySFIKNxjMdluBOTEFx?=
 =?us-ascii?Q?C+X0k2yWcjr5MOXXcHlL9SjH5aYWX0THiqV86Cpl3Bb87myoTimWT8vAVJdg?=
 =?us-ascii?Q?G0lFNrWYS/8pFobVl9DUJ8z6XM8bBFlJn2snkp9GbgB2+Dv4KOBnR4Fbkt/m?=
 =?us-ascii?Q?vUdTqQfr9uA9F5NxPmns8d1qDDt0xjV7cMSvleWhAtxb/DkxPUkDtstlc9Gq?=
 =?us-ascii?Q?Vzan3Lq2fVUvG7x+M7eaF+tbqBcAhpRHm9wZo+052Ly7C2xLBLkb2spBcqwq?=
 =?us-ascii?Q?QTrGRDTwUumjXNGI0T5EdBYEaB32h22ibpEjbCghCsvR5yd2oOFz+4A3DCn6?=
 =?us-ascii?Q?JSHr4xoOnG6zmhod79FNVHSj9N5ZyQP7bbJOhqJEe0GiHua9AWTSILphKD06?=
 =?us-ascii?Q?0GzIC91b28wP8at3U4cDZ+g3u5JfoQHm+QGASlEgtpMw7Jdt86tOqVMAUwJd?=
 =?us-ascii?Q?ERieribyGRJG54DG7KXIle2gsJ20llekkceCPKH34pGDWFV/mqQK19eM7LkT?=
 =?us-ascii?Q?fykqA40orC+rCNJR7TPw8RXJidW/jGQ16oZSG3svlUjHHS7KS5z5r7TJOq77?=
 =?us-ascii?Q?xKpG25F3KcVpbSc5DBRqiqdWrx2MkYdejDO31VF/fGGE509ZJRwk?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: 8a106ef2-c4a2-4b7a-c783-08deceee9b63
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jun 2026 17:08:53.8172
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yCmX1/RLJ4L5RaDJcpo+Q7uHBhyO6gCo0tT6vALLs0o/SpRmzs4QF0nxufQWVhi1ab4mPwspih+LTPKH6eq/og==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS9P286MB4352
X-Rspamd-Action: no action
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[valinux.co.jp,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[valinux.co.jp:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER(0.00)[den@valinux.co.jp,dmaengine@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[17];
	TAGGED_FROM(0.00)[bounces-11665-lists,dmaengine=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,valinux.co.jp:dkim,valinux.co.jp:email,valinux.co.jp:mid,valinux.co.jp:from_mime,vger.kernel.org:from_smtp,infradead.org:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 4811A6A952B

Add a function description and a user guide for pci-epf-dma. Describe
the BAR-resident metadata consumed by dw-edma-pcie, the configfs
attributes, endpoint controller requirements and the host-side DMAengine
usage model.

Suggested-by: Randy Dunlap <rdunlap@infradead.org>
Signed-off-by: Koichiro Den <den@valinux.co.jp>
---
Changes in v3:
  - Drop trailing colons from subsection headings (Randy).
  - Update docs for HDMA native linked-list mode support.

 Documentation/PCI/endpoint/index.rst          |   2 +
 .../PCI/endpoint/pci-dma-function.rst         | 188 ++++++++++++++++
 Documentation/PCI/endpoint/pci-dma-howto.rst  | 201 ++++++++++++++++++
 3 files changed, 391 insertions(+)
 create mode 100644 Documentation/PCI/endpoint/pci-dma-function.rst
 create mode 100644 Documentation/PCI/endpoint/pci-dma-howto.rst

diff --git a/Documentation/PCI/endpoint/index.rst b/Documentation/PCI/endpoint/index.rst
index dd1f62e731c9..cd4107e02ec2 100644
--- a/Documentation/PCI/endpoint/index.rst
+++ b/Documentation/PCI/endpoint/index.rst
@@ -15,6 +15,8 @@ PCI Endpoint Framework
    pci-ntb-howto
    pci-vntb-function
    pci-vntb-howto
+   pci-dma-function
+   pci-dma-howto
    pci-nvme-function
 
    function/binding/pci-test
diff --git a/Documentation/PCI/endpoint/pci-dma-function.rst b/Documentation/PCI/endpoint/pci-dma-function.rst
new file mode 100644
index 000000000000..4de02553f5ff
--- /dev/null
+++ b/Documentation/PCI/endpoint/pci-dma-function.rst
@@ -0,0 +1,188 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+================
+PCI DMA Function
+================
+
+:Author: Koichiro Den <den@valinux.co.jp>
+
+The PCI DMA endpoint function exposes an endpoint-integrated DMA controller
+to the PCI host as a PCI DMA controller.  A matching host-side driver
+discovers the endpoint DMA metadata and registers the delegated channels with
+the Linux DMAengine framework, so host DMAengine clients can submit
+transfers.
+
+An endpoint Linux system can already use an endpoint-integrated DMA
+controller locally through the normal DMAengine API, for example to transfer
+data between endpoint memory and host addresses reachable over PCI.  The PCI
+DMA function provides a different ownership model: it delegates selected
+local DMA channels to the host, so a host DMAengine client can request and
+program those endpoint-side channels through the host's DMAengine API.
+
+To make that possible, the endpoint function publishes the DMA controller
+register window and descriptor memory layout to the host, reserves the
+selected local DMA channels on the endpoint side, and lets the host program
+those channels directly.
+
+Constructs Used for Implementing DMA
+====================================
+
+The PCI DMA function uses the following endpoint-side resources and
+configuration:
+
+	1) DMA controller register window
+	2) DMA descriptor memory for endpoint-to-RC channels
+	3) DMA descriptor memory for RC-to-endpoint channels
+	4) MSI or MSI-X interrupt vectors selected through configfs
+	5) One endpoint BAR used to publish metadata
+	6) If needed, one endpoint BAR used for dynamically mapped DMA windows
+
+The endpoint controller reports the DMA controller register and descriptor
+resources through the endpoint auxiliary resource interface.  The PCI DMA
+function uses those descriptions to build the host-visible metadata and to map
+resources that are not already visible to the host.
+
+DMA Controller Register Window
+------------------------------
+
+It contains the DMA controller registers programmed by the host-side driver
+to submit transfers, control channels and handle DMA interrupts.
+
+DMA Descriptor Memory
+---------------------
+
+It contains the descriptor memory used by the DMA controller.  The PCI DMA
+function exposes descriptor memory for the delegated endpoint-to-RC and
+RC-to-endpoint channels.
+
+MSI/MSI-X Interrupt Vectors
+---------------------------
+
+They are used by the delegated DMA channels to signal completion and error
+conditions to the host-side driver.
+
+Metadata BAR
+------------
+
+It is the endpoint BAR used to publish the endpoint DMA metadata and handshake
+bits.  The BAR remains stable while the endpoint function programs the DMA
+windows.
+
+DMA Window BAR
+--------------
+
+It is the endpoint BAR used for DMA resources that are not already visible
+through a fixed BAR.  The endpoint function may switch this BAR to subrange
+mapping after the host-side driver has found the metadata BAR.
+
+BAR Metadata
+============
+
+The endpoint function places a small metadata block at the beginning of the
+selected metadata BAR.  The format is defined in
+``include/linux/pci-ep-dma.h``.
+
+The host-side driver scans the function's assigned memory BARs, looks for the
+endpoint DMA metadata magic, requests DMA window programming, waits for the
+READY bit, and then parses the metadata to find the DMA register window and
+descriptor windows.
+
+::
+
+	+----------------------+ metadata BAR offset 0
+	| endpoint DMA metadata|
+	+----------------------+
+	| optional padding     |
+	+----------------------+
+
+	+----------------------+ DMA window BAR offset 0
+	| mapped DMA resources |
+	+----------------------+
+	| optional padding     |
+	+----------------------+
+
+The metadata can also reference resources that are already host-visible
+through fixed BARs.  For example, an endpoint controller may expose the DMA
+controller register window at a fixed BAR offset while descriptor memories
+are mapped into the DMA window BAR by the endpoint function.
+
+The metadata is BAR-resident instead of a self-contained PCI Vendor-Specific
+Extended Capability (VSEC).  Some endpoint controllers do not provide writable
+configuration-space backing storage large enough for a new VSEC payload, while
+they can map endpoint memory and controller resources into a BAR.
+
+Channel Ownership
+=================
+
+The ``wr_chans`` attribute exposes endpoint-to-RC DMA write channels.  The
+``rd_chans`` attribute exposes RC-to-endpoint DMA read channels.  The function
+reserves the selected endpoint-side DMAengine channels so that endpoint-side
+DMAengine clients cannot allocate and use the same hardware channels while
+they are delegated to the host.
+
+The current metadata revision describes channels in dense, zero-based order.
+For example, ``wr_chans = 2`` exposes write channels 0 and 1.  Skipping a
+hardware channel in the middle of the exposed range is not supported.
+
+DesignWare eDMA unroll and HDMA compatible layouts require each exposed
+direction to be delegated as a whole.  For example, on a controller with two
+write channels, ``wr_chans`` must be either 0 or 2.  DesignWare HDMA native
+linked-list mode uses per-channel registers, so a smaller dense prefix can be
+delegated.
+
+Interrupts
+==========
+
+The PCI DMA function exposes DMA interrupts through MSI or MSI-X.  The common
+endpoint function ``msi_interrupts`` and ``msix_interrupts`` configfs attributes
+select the interrupt vector counts programmed into endpoint config space.  At
+least one MSI or MSI-X vector must be configured before the function is bound
+to an endpoint controller.
+
+Transfer Addressing
+===================
+
+The host-side DMAengine client supplies the endpoint memory address as the
+DMA slave address.  For example, the ``dw-edma-pcie`` endpoint DMA metadata
+parser passes that slave address to the DMA controller as a raw endpoint-side
+address instead of translating it through a host PCI BAR resource.
+
+The host memory buffer used as the other side of the transfer is still mapped
+using the normal DMA mapping API on the host.
+
+Endpoint Controller Requirements
+================================
+
+The endpoint controller driver must expose the DMA controller register
+window and per-channel descriptor memories through the endpoint auxiliary
+resource API.  Endpoint controllers with other DMA register layouts also need
+matching metadata and host-side DMAengine driver support.
+
+Current DesignWare endpoint DMA support exposes only channels with descriptor
+memory; HDMA native non-linked-list mode is not supported yet.
+
+If any DMA resource is not already host-visible through a fixed BAR, the
+endpoint controller must also support BAR subrange mapping and dynamic inbound
+mapping, because the DMA window BAR is assembled from those resources.
+
+Current Support
+===============
+
+The current host-side support is implemented in ``dw-edma-pcie`` for
+DesignWare eDMA unroll, HDMA compatible and HDMA native linked-list layouts.
+Other PCIe controller DMA implementations need corresponding host-side
+DMAengine driver support.
+
+The ``dw-edma-pcie`` PCI ID table does not contain a generic endpoint DMA PCI
+ID entry.  Users need to bind the host-side driver explicitly using
+``driver_override``.
+
+The current metadata revision requires the exposed channels to be a dense
+prefix of the hardware channel numbers.
+
+Security Model
+==============
+
+The interface is intended for trusted endpoint/host deployments.  A delegated
+DMA channel can access endpoint memory addresses supplied by a host DMAengine
+client.
diff --git a/Documentation/PCI/endpoint/pci-dma-howto.rst b/Documentation/PCI/endpoint/pci-dma-howto.rst
new file mode 100644
index 000000000000..4bdce63c6f7f
--- /dev/null
+++ b/Documentation/PCI/endpoint/pci-dma-howto.rst
@@ -0,0 +1,201 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+==========================================
+PCI DMA Endpoint Function (EPF) User Guide
+==========================================
+
+:Author: Koichiro Den <den@valinux.co.jp>
+
+This guide shows how to configure the ``pci-epf-dma`` endpoint function driver.
+It uses ``dw-edma-pcie`` as the currently available host-side driver.  For the
+hardware model and layout see Documentation/PCI/endpoint/pci-dma-function.rst.
+
+Endpoint Device
+===============
+
+Endpoint Controller Devices
+---------------------------
+
+To find the list of endpoint controller devices in the system::
+
+	# ls /sys/class/pci_epc/
+	e65d0000.pcie-ep
+
+If ``PCI_ENDPOINT_CONFIGFS`` is enabled::
+
+	# ls /sys/kernel/config/pci_ep/controllers
+	e65d0000.pcie-ep
+
+Endpoint Function Drivers
+-------------------------
+
+To find the list of endpoint function drivers in the system::
+
+	# ls /sys/bus/pci-epf/drivers
+	pci_epf_dma  pci_epf_test
+
+If ``PCI_ENDPOINT_CONFIGFS`` is enabled::
+
+	# ls /sys/kernel/config/pci_ep/functions
+	pci_epf_dma  pci_epf_test
+
+Creating pci-epf-dma Device
+---------------------------
+
+Create a ``pci-epf-dma`` device with configfs::
+
+	# mount -t configfs none /sys/kernel/config
+	# cd /sys/kernel/config/pci_ep/
+	# mkdir functions/pci_epf_dma/dma0
+
+The "mkdir dma0" above creates the ``pci-epf-dma`` function device that will
+be probed by the ``pci_epf_dma`` driver.
+
+The PCI endpoint framework populates the directory with the common
+configurable fields::
+
+	# ls functions/pci_epf_dma/dma0
+	baseclass_code   msi_interrupts   progif_code    subsys_id
+	cache_line_size  msix_interrupts  revid          subsys_vendor_id
+	deviceid         pci_epf_dma.0    secondary      vendorid
+	interrupt_pin    primary          subclass_code
+
+The PCI DMA function driver also creates a function-specific sub-directory.
+The numeric suffix depends on the endpoint function instance number::
+
+	# ls functions/pci_epf_dma/dma0/pci_epf_dma.0/
+	dma_window_bar  metadata_bar  rd_chans  wr_chans
+
+Configuring pci-epf-dma Device
+------------------------------
+
+The host-side ``dw-edma-pcie`` PCI ID table does not contain a generic
+endpoint DMA PCI ID entry.  Choose a PCI vendor/device ID for the endpoint
+device::
+
+	# echo <vendor-id> > functions/pci_epf_dma/dma0/vendorid
+	# echo <device-id> > functions/pci_epf_dma/dma0/deviceid
+	# echo 1 > functions/pci_epf_dma/dma0/msi_interrupts
+
+The PCI class defaults to ``PCI_BASE_CLASS_SYSTEM`` and
+``PCI_CLASS_SYSTEM_DMA``.
+
+The function-specific attributes are:
+
+============== ============================================================
+Attribute      Description
+============== ============================================================
+metadata_bar   BAR used to publish the endpoint DMA metadata and handshake
+               bits.  It is kept as a stable BAR while the DMA windows are
+               programmed.  If this is left unset, the first usable BAR that
+               does not already contain a fixed DMA resource is used.
+dma_window_bar BAR used for DMA resources that are not already host-visible,
+               such as the DMA register window or descriptor windows.  This
+               BAR may be switched to subrange mapping after the host driver
+               has found the metadata.  If this is left unset and a DMA
+               window is needed, the first usable BAR different from
+               ``metadata_bar`` and not already occupied by a fixed DMA
+               resource is used.
+wr_chans       Number of endpoint-to-RC DMA write channels to expose.
+rd_chans       Number of RC-to-endpoint DMA read channels to expose.
+============== ============================================================
+
+A sample configuration for a DesignWare eDMA/HDMA compatible controller with
+two write channels and two read channels is given below::
+
+	# echo 0 > functions/pci_epf_dma/dma0/pci_epf_dma.0/metadata_bar
+	# echo 2 > functions/pci_epf_dma/dma0/pci_epf_dma.0/dma_window_bar
+	# echo 2 > functions/pci_epf_dma/dma0/pci_epf_dma.0/wr_chans
+	# echo 2 > functions/pci_epf_dma/dma0/pci_epf_dma.0/rd_chans
+
+``wr_chans`` and ``rd_chans`` default to 0.  At least one channel direction
+must be configured.  The selected channels are exposed in dense, zero-based
+order; for example, ``wr_chans = 2`` exposes write channels 0 and 1.
+DesignWare eDMA unroll and HDMA compatible layouts require each exposed
+direction to be delegated as a whole, so set a direction to either 0 or the
+number of hardware channels in that direction.  DesignWare HDMA native
+linked-list mode allows a smaller dense prefix.  If ``dma_window_bar`` is
+configured, it must be different from ``metadata_bar``.
+
+The common ``msi_interrupts`` and ``msix_interrupts`` attributes select the
+number of MSI and MSI-X vectors exposed to the host.  At least one MSI or
+MSI-X vector must be configured.
+
+The function-specific attributes can only be changed before the endpoint
+function is bound to an endpoint controller.
+
+Binding pci-epf-dma Device to EP Controller
+-------------------------------------------
+
+The DMA function device should be attached to a PCI endpoint controller
+connected to the host::
+
+	# ln -s controllers/e65d0000.pcie-ep \
+		functions/pci_epf_dma/dma0/primary/
+
+Once the above step is completed, the PCI endpoint controller is ready to
+establish a link with the host.
+
+Start the Link
+--------------
+
+Start the endpoint controller by writing 1 to ``start``::
+
+	# echo 1 > controllers/e65d0000.pcie-ep/start
+
+Root Complex Device
+===================
+
+lspci Output
+------------
+
+Note that the device listed here corresponds to the values populated in the
+endpoint configuration above::
+
+	# lspci -nk
+	01:00.1 0801: <vendor-id>:<device-id>
+
+If the host was already running while the endpoint function was configured,
+rescan the PCI bus after the endpoint side has completed the configfs setup
+and started the endpoint controller, if the platform supports it.
+
+Bind the endpoint DMA function to ``dw-edma-pcie`` explicitly with
+``driver_override``::
+
+	# modprobe dw_edma_pcie
+	# echo dw-edma-pcie > /sys/bus/pci/devices/0000:01:00.1/driver_override
+	# echo 0000:01:00.1 > /sys/bus/pci/drivers_probe
+
+The device should then be bound to ``dw-edma-pcie``::
+
+	# lspci -nk -s 01:00.1
+	01:00.1 0801: <vendor-id>:<device-id>
+		Kernel driver in use: dw-edma-pcie
+
+Using pci-epf-dma Device
+------------------------
+
+The host side software uses the standard Linux DMAengine API.  A DMAengine
+client driver running on the host must request one of the channels provided by
+``dw-edma-pcie`` and submit a transfer.
+
+For an endpoint-to-RC write transfer, the DMAengine client uses a host DMA
+buffer as the destination and an endpoint-side address as the slave source
+address.  For an RC-to-endpoint read transfer, the DMAengine client uses a
+host DMA buffer as the source and an endpoint-side address as the slave
+destination address.
+
+Troubleshooting
+===============
+
+``pci-epf-dma`` requires endpoint controller support for DMA auxiliary
+resources and MSI or MSI-X.  If any DMA resource must be mapped dynamically,
+the endpoint controller must also support BAR subrange mapping and dynamic
+inbound mapping.  Binding the function to an endpoint controller fails if the
+required capabilities are not available, or if both ``msi_interrupts`` and
+``msix_interrupts`` are zero.
+
+If ``dw-edma-pcie`` fails to probe on the host, check that the endpoint was
+bound to the host driver, that the endpoint BARs were assigned by PCI
+enumeration, and that the endpoint DMA metadata READY bit was set after any
+DMA window BAR submaps were programmed.
-- 
2.51.0


