Return-Path: <dmaengine+bounces-12295-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id nvJkIEStUGot3QIAu9opvQ
	(envelope-from <dmaengine+bounces-12295-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Fri, 10 Jul 2026 10:28:52 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EBF37738769
	for <lists+dmaengine@lfdr.de>; Fri, 10 Jul 2026 10:28:51 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=valinux.co.jp header.s=selector1 header.b=KGPJ9Hfw;
	dmarc=pass (policy=none) header.from=valinux.co.jp;
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-12295-lists+dmaengine=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="dmaengine+bounces-12295-lists+dmaengine=lfdr.de@vger.kernel.org";
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DBB0D3040472
	for <lists+dmaengine@lfdr.de>; Fri, 10 Jul 2026 08:22:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EEDF3F0749;
	Fri, 10 Jul 2026 08:22:10 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from OS0P286CU011.outbound.protection.outlook.com (mail-japanwestazon11020086.outbound.protection.outlook.com [52.101.228.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A0413EF0D0;
	Fri, 10 Jul 2026 08:22:08 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783671730; cv=fail; b=jTvArBEc8roUHSGwbjbTsUeATz1Uxfk/KCqW5fhXseshqGNLl7h/SRjlZQWNVW6GDc6Fu2oXQygCAxU+7bwQVX9/IEdSY8UQFKEwTolBVYCwh/Xet7GMFabrjWPr1DvKV6qa5/+uTCKIgjW5QUKX8aJi8wXAhg9gbtYn5f3HWzM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783671730; c=relaxed/simple;
	bh=1EYrRlU0eypBhfvbMcWpCKAlEBBCdgl7udIDefXtHIs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=H4BnPHL3OuArcwatyxh8FC7MzrlrUl1sCun7xX8/e5MJajq0UVv3F7hYYJ5mP80EHe2ycJXgv3t+ouAnFxkzUqKvv7gsSwUBWNEffbr1qdlYJPnWChc9Wzddk/v0VB3kpTC8GTJFMdRFHpJTgnxPx8TknFeomcBY+9i6ae0cw9Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=KGPJ9Hfw; arc=fail smtp.client-ip=52.101.228.86
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=anUN6To0NHhAKiAVjTc8OYX/woo0gK4cwY6ejtYTrwgsGRcR52uwMyYof8oIZ21oaaeCoiucZ+hh+1ZX3PEsO8DSkYT7mgc19FyQZth92n1EMroHhjwV+Dm0p1c9fMvkmoerjleKgVnPfmNGzzKVFaann53JIWUTgTEuxDfFyzRAZ/n0I/pJMM2TTiNs+3/GERSK07StilDlvTvoykMuv/JlLnpWGWtU+aGRj6BJo4UKI0RJ6PFIYKCqos08MMrK1DvJ+5FwkyboJfYz82bQccFM43EECmFIVs6sk5SYSvr4PBRKQSxqW1b+UV5YyBnUv6A7QLv0qlFahCl9xEUL3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VKomF5BQ4iFLFqQQiPmlXUz8qCqHQR9F9PU5t65N8ZE=;
 b=Fs/mnEcCEHS7P/sLBUrSU9xdnyeEeKaToGkuhhW6/82DrXym+7qzNMHtQYClckaOK0y87ONJLPCLeI3oyqvl1NRrE14ZQE7IeyerSWPIunobmYFwB/0BLCEyk43Jf/U2fs7bLZEGLuaeAG2iZsiVOqSCYuC4Z+iSBxHrOPql0gmHY2ZUDQ2XrbqLgovRclwYktb6G5zRpI5duVLxD+wuczlMqOatIymGsf8r/64ywb83LuFthadKQIlptXcyDdbr8ti5touztcHggKfx+Xaooorrq7UCg13qn15vI567hWeK+t/ThPgDhMwKdr8hSj+AMNRskupX/vIYIFz5Qk++ug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VKomF5BQ4iFLFqQQiPmlXUz8qCqHQR9F9PU5t65N8ZE=;
 b=KGPJ9HfwljBFLeuturTBMhIy1+rKHeDvSo29PxUtE+0f1UqDGZnsacdFAMnCAR4s7fH+4k2A93B7dDBFkdHUsdSy58wYqG2ttPEY3UzFYbf3QW8dAh7B8bEmyVY649VAm4VUOnr85BV8zCWmprKBJTVdUfMDe/TDJEAuq0fH76A=
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:38f::10)
 by OS3P286MB2742.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:1fe::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.17; Fri, 10 Jul
 2026 08:22:01 +0000
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32]) by TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32%5]) with mapi id 15.21.0181.009; Fri, 10 Jul 2026
 08:22:01 +0000
From: Koichiro Den <den@valinux.co.jp>
To: Manivannan Sadhasivam <mani@kernel.org>,
	Vinod Koul <vkoul@kernel.org>,
	Frank Li <Frank.Li@kernel.org>,
	Jingoo Han <jingoohan1@gmail.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Kishon Vijay Abraham I <kishon@kernel.org>
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
	Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
	linux-kernel@vger.kernel.org,
	dmaengine@vger.kernel.org,
	linux-pci@vger.kernel.org
Subject: [PATCH v4 1/6] PCI: endpoint: Define endpoint DMA BAR metadata format
Date: Fri, 10 Jul 2026 17:21:51 +0900
Message-ID: <20260710082156.2395844-2-den@valinux.co.jp>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260710082156.2395844-1-den@valinux.co.jp>
References: <20260710082156.2395844-1-den@valinux.co.jp>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TY6P286CA0012.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:3b8::19) To TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:38f::10)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY7P286MB7722:EE_|OS3P286MB2742:EE_
X-MS-Office365-Filtering-Correlation-Id: 69c30271-7eec-41c9-9f27-08dede5c514d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|1800799024|10070799003|23010399003|366016|56012099006|6133799003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	plJB/RKj23QlGR9W03GK385lG2UCxK5qifZSKsdWRsxv87NCli7+ekR3Qg//UhEYHRiHSIoTikYIW0woG05IyCHlMQveG/5GM8IMaujV2a4NFT7zRKeAQGovqDOr/rdrXiR+INnYzT+x3dPPTHzpca8aa7KJgfb4OO4zX4TqDKEADYyp9f+u/KrdxOktFWg+iVIb/SKllrL8n+tu52Zd7D1NduH7vcLxyjniTuXdWV6uCLdDRpBgFsb7CNYgDkRpFLQ0fOMFSSU/YWrULp7EK7cxukx273d4SLFNq1cHIeJqqv1pu8BRR81CzWFl14DrYcdnhWLtOVsS2M65FFmyeLBAZjxXIKvM9/2HLV8Zd12MjhomxSnBHDUqGiuLaV3pcB+4fDuaRmKNDamYCWrJhPv94egB5t651UKfbi3f/LPRLbq6sts2Yf67xpM4mMaj4IREk1Sq9fIv3VpVW+yqjLM2TtoJNUv1qezGW7rqr0iVqaSbnd7EN/DpJzikAVmetLBd8LDQUsEuFGMRhPvk72F78M8INpvekjv7QeQ09gtnJnnJwe/9ORN1ZT8xNYUI3gE2HY5FChaQeJzKyDiKPZA9ETrAYxoKgkMVLJaMkr5CNb4DkCEJ45p2F3S43MWjdIFGFw+XnRN2AE1BWqoxzdDiqdgTQRUJqxYTgZRNZHo=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(10070799003)(23010399003)(366016)(56012099006)(6133799003)(22082099003)(18002099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?OA9VofMWn7xshStT9yAXBRlz3e6EMHosgoV0VIEe15KpvLK7EmKf5tCfoGOf?=
 =?us-ascii?Q?3euTB+UPgNU3mFKFcrUS+aO2IyXa0zoqfm4FAJ6d4/iHIwfCtBHpmeZbyv/a?=
 =?us-ascii?Q?spNWAvi8vkQYusku1SwXn5D6IRJIaTe2kcSFAx1m47hAcg7kNdNgAnENAwnt?=
 =?us-ascii?Q?eneO8WzghZGW9tWQb7hkj1+q/Dp4u7yYu31yjR1vFqlBGWQfmNk5/PSYOFJq?=
 =?us-ascii?Q?vULjIgbVFMh49M41U4bmKZbXwg0XwlHErDuETJ+uxcjMVi0cxy1Txyc61QgE?=
 =?us-ascii?Q?cRkd0CnhdQ+a0bn0oR2r6KI9MGyj+5rFQBqy+di4V+BlX41wzgSXlQarfkGl?=
 =?us-ascii?Q?bjGWHw1t99ECZVYuL4mD9xX7jic8iQbsb+JnaKl5U7ov65Ta0+1vJ7BGzm9U?=
 =?us-ascii?Q?HAWF3sM8hSNd3qYdCYdK9coSom9JvvJo1HZf96YZR5fUkIn5LLsv5JXoWIPV?=
 =?us-ascii?Q?6JNCkwy68uf7CzZA9Fx/WuMiL0UXd/HwjldoS2VPlrZoqHFHzsPydu91I//a?=
 =?us-ascii?Q?KlI5ss9yPyX4r/NyGumcDsURK89GInjPCHv+rDooAi8vFdc0kHsloHCbW8SB?=
 =?us-ascii?Q?3gFqrRdxXCsQCNZugkPxBgby4GipkoRg7cH0/W2uMu2fzl5JUKyvm1TdUA0X?=
 =?us-ascii?Q?JcFG98cilWnsRpoRf8AVhR76SB9uog/IqgLHm3zlyIlLnleK4vSmVeT7RXt5?=
 =?us-ascii?Q?dh5Pfs+PNCF2NcTAODgpNyVaeY/T2QbaTsbtELPwmdpe9nB5zJ0g4Ev8v7PJ?=
 =?us-ascii?Q?tr0Xnsa7BrPxgK33XEnXHeczNjOMAAZDtY4BhmJMNYuOiBuBWBLuv9JQkSzw?=
 =?us-ascii?Q?N0D0n0cFzylO3vPlGSBlkYrXrcHjccj3rvpoE3aGonH2FrgRWezzTlWEvwLn?=
 =?us-ascii?Q?aQUGr/mHq724MKFbKxQBTnXo4/woz/5Be11xDU2ITxnKjMCVi/hJdUXw8TFE?=
 =?us-ascii?Q?PhaZkairMFbZ0pwoSPRf0Bg593qV5aXo7c0scuw2Y2FBsKWWl9XsFGHi0J0k?=
 =?us-ascii?Q?jx+TLl78PC/g+5bEpgdhTpMhJ6XLVvyMKEcduZQDrYuyfyZ1FeHkuG28AMYA?=
 =?us-ascii?Q?tJbyT48PqphqGplhavOf0sS14DkJUweviBe3K9TUh/qgexzeQPTcGcq8TdxJ?=
 =?us-ascii?Q?gWoGa2VkcxXYEjVjIvkQOMy/2/M3Orojnkk/g2suDpRenW4prKgPYxZbaF2m?=
 =?us-ascii?Q?LVP2UEqukH/UmnY5GjrjGLxREp5DXr2Kg5yzV6nKc0YvQOoKU25vBAvwFBbn?=
 =?us-ascii?Q?4INbf2lQhgZ917mAlVV2W86itcB1OKacTgJv3hJJooVfJRMcM8vU66iATz9W?=
 =?us-ascii?Q?ml/qyj1GwSbi1FMdU5OJohcP13l8gBPrxS40EYJVo0Zmnm3uIzgbIi1wEiYp?=
 =?us-ascii?Q?TcVtJbNEri/KloH+ODNf1rHEQ1kMX54umB3IvXx+n0lrWUd4805OTH14UQjs?=
 =?us-ascii?Q?pG6yiounCUGEQkykzQuOSrNonRYNjtkfE8mMUetd1WSaAzcttnMt+cWp2+tp?=
 =?us-ascii?Q?7r6Tme8dSAzYw+L+6hJmyZNl5H9DKqVnbimA/cvgYGFAqX130FZv3ob2vPWm?=
 =?us-ascii?Q?uk8mFQRlUlEf8DyCQUMlUvo3RHKLnQ1rB15WQZWFEdBLgLOtn/fNP46UkbU2?=
 =?us-ascii?Q?cR8N79HR7lmVzeBLRox4TvaUcx4d+LhXPo7gDCf0e2XFnANS98pHGLMwFWpZ?=
 =?us-ascii?Q?8t8/lrphSI0InikPOohVTyN2PHrROaUV0GAKiW9kNha96xdetG7YJbjtGMNv?=
 =?us-ascii?Q?/KgyAplPVNUv98AYqw5ey0ps0nr+59O0AI6sMpbkglED4rsjiAcv?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: 69c30271-7eec-41c9-9f27-08dede5c514d
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2026 08:22:01.6143
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XfULxZqRwWAcRzb0vKz+OBDPLFkW+8RvfBz/e7eSbKoNMYE2ydlRTmxpdwM5yT2inznxpuWSM6b3n5PR5ogV5Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS3P286MB2742
X-Rspamd-Action: no action
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[valinux.co.jp,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[valinux.co.jp:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-12295-lists,dmaengine=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[14];
	FREEMAIL_TO(0.00)[kernel.org,gmail.com,google.com];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:mani@kernel.org,m:vkoul@kernel.org,m:Frank.Li@kernel.org,m:jingoohan1@gmail.com,m:lpieralisi@kernel.org,m:kwilczynski@kernel.org,m:robh@kernel.org,m:bhelgaas@google.com,m:kishon@kernel.org,m:marek.vasut+renesas@mailbox.org,m:yoshihiro.shimoda.uh@renesas.com,m:linux-kernel@vger.kernel.org,m:dmaengine@vger.kernel.org,m:linux-pci@vger.kernel.org,m:marek.vasut@mailbox.org,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[den@valinux.co.jp,dmaengine@vger.kernel.org];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[dmaengine,renesas];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,valinux.co.jp:from_mime,valinux.co.jp:email,valinux.co.jp:mid,valinux.co.jp:dkim]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: EBF37738769

Define the BAR-resident metadata format used by endpoint functions that
expose an endpoint-integrated DMA controller to the host.

A VSEC-based discovery scheme would be a natural fit, and existing
dw-edma-pcie providers such as Synopsys EDDA and AMD (Xilinx) MDB/CPM6
already use VSECs for DMA discovery. However, some endpoint controllers
cannot provide enough writable configuration-space storage for a
complete, controller-defined payload. Keep the extensible metadata in a
BAR instead, where the endpoint function controls the layout and size.

The format describes the DMA register window, exported channel counts,
descriptor windows, optional auxiliary windows, endpoint-local descriptor
and auxiliary DMA addresses, and a ready bit that tells the host when the
described BAR windows are usable. Channel entries keep the auxiliary
window optional so layouts that need a separate data or auxiliary aperture
can describe it without a format bump.

Signed-off-by: Koichiro Den <den@valinux.co.jp>
---
Changes in v4:
  - Improve kdoc.

 MAINTAINERS                |   1 +
 include/linux/pci-ep-dma.h | 170 +++++++++++++++++++++++++++++++++++++
 2 files changed, 171 insertions(+)
 create mode 100644 include/linux/pci-ep-dma.h

diff --git a/MAINTAINERS b/MAINTAINERS
index 15011f5752a9..c8a171fa15d1 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -20801,6 +20801,7 @@ F:	Documentation/PCI/endpoint/*
 F:	Documentation/misc-devices/pci-endpoint-test.rst
 F:	drivers/misc/pci_endpoint_test.c
 F:	drivers/pci/endpoint/
+F:	include/linux/pci-ep-dma.h
 F:	tools/testing/selftests/pci_endpoint/
 
 PCI ENHANCED ERROR HANDLING (EEH) FOR POWERPC
diff --git a/include/linux/pci-ep-dma.h b/include/linux/pci-ep-dma.h
new file mode 100644
index 000000000000..73f72455843c
--- /dev/null
+++ b/include/linux/pci-ep-dma.h
@@ -0,0 +1,170 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef __LINUX_PCI_EP_DMA_H
+#define __LINUX_PCI_EP_DMA_H
+
+#include <linux/bits.h>
+
+/*
+ * BAR metadata format used by PCI endpoint functions that expose an
+ * endpoint-integrated DMA controller to a PCI host.
+ *
+ * Offsets are relative to the beginning of the metadata blob. Multi-byte
+ * fields are little-endian. The blob is normally placed at offset 0 of a
+ * function BAR selected by the endpoint function and discovered by the host
+ * driver using device-specific policy. Other data in the same BAR, such as a
+ * standard MSI-X table or PBA, is outside this metadata format.
+ *
+ *          31                                                              0
+ *          +---------------------------------------------------------------+
+ * +0x000   | metadata magic                                                |
+ *          +---------------------------------------------------------------+
+ *          31                            16 15            8 7              0
+ *          +-------------------------------+---------------+---------------+
+ * +0x004   | metadata length               | reserved      | revision      |
+ *          +-------------------------------+---------------+---------------+
+ *          31 30 29     27 26          19 18          11 10           3 2  0
+ *          +--+--+--------+--------------+--------------+--------------+---+
+ * +0x008   |R |H |reserved| ch entry size| RD count     | WR count     |BAR|
+ *          +--+--+--------+--------------+--------------+--------------+---+
+ * +0x00c   | register window offset[31:0]                                  |
+ *          +---------------------------------------------------------------+
+ * +0x010   | register window offset[63:32]                                 |
+ *          +---------------------------------------------------------------+
+ *          31                            16 15            8 7              0
+ *          +-------------------------------+---------------+---------------+
+ * +0x014   | reserved                      | layout data   | layout        |
+ *          +-------------------------------+---------------+---------------+
+ * +0x018   | register window size                                          |
+ *          +---------------------------------------------------------------+
+ * +0x01c   | write table                                                   |
+ *          | ( channel table entries #0 ~ #N )                             |
+ *          +---------------------------------------------------------------+
+ *          | read table                                                    |
+ *          | ( channel table entries #0 ~ #N )                             |
+ *          +---------------------------------------------------------------+
+ *
+ *          metadata magic: PCI_EP_DMA_METADATA_MAGIC.
+ *          metadata length: byte size of the whole metadata blob. The value
+ *                           must fit in PCI_EP_DMA_METADATA_HDR_LEN_FIELD and
+ *                           in the BAR allocation that contains the metadata.
+ *          revision: metadata format revision.
+ *          R: ready bit. Set only by the endpoint after all fields and BAR
+ *             windows described by this metadata have been programmed and can
+ *             be used by the host. The host must not consume the windows
+ *             before observing this bit.
+ *          H: host-request bit. Set only by the host driver after it has found
+ *             this metadata. The endpoint may use this as the trigger to
+ *             program DMA window BAR subrange mappings, and may clear it while
+ *             revoking R during teardown or reinitialization.
+ *          ch entry size: byte stride between consecutive channel table
+ *                         entries. Revision 1 requires at least
+ *                         PCI_EP_DMA_METADATA_CH_ENTRY_SIZE bytes.
+ *          RD count: number of exposed RC-to-endpoint DMA read channels and
+ *                    read channel-table entries.
+ *          WR count: number of exposed endpoint-to-RC DMA write channels and
+ *                    write channel-table entries.
+ *          BAR: BAR that contains the DMA controller register window.
+ *          register window offset: BAR-local byte offset of the DMA controller
+ *                                  register window in BAR.
+ *          register window size: DMA controller register window size in bytes.
+ *          layout: DMA controller register layout identifier.
+ *          layout data: layout-specific data. For
+ *                       PCI_EP_DMA_METADATA_REG_LAYOUT_DW_EDMA this is the
+ *                       DesignWare eDMA/HDMA map format.
+ *          write table: starts at PCI_EP_DMA_METADATA_HDR_LEN if write channel
+ *                       count is non-zero.
+ *          read table: starts at PCI_EP_DMA_METADATA_HDR_LEN plus the write
+ *                      table size if read channel count is non-zero.
+ *          reserved fields and bits: write zero and ignore on read.
+ *
+ *
+ * Channel table entry:
+ *
+ *          31                 17 16 15 14   12 11 10     8 7                0
+ *          +--------------------+--+--+-------+--+--------+----------------+
+ * +0x000   | reserved           |A |rs|aux BAR|rs|desc BAR|hardware channel|
+ *          +--------------------+--+--+-------+--+--------+----------------+
+ * +0x004   | descriptor window BAR offset[31:0]                            |
+ *          +---------------------------------------------------------------+
+ * +0x008   | descriptor window BAR offset[63:32]                           |
+ *          +---------------------------------------------------------------+
+ * +0x00c   | descriptor window size                                        |
+ *          +---------------------------------------------------------------+
+ * +0x010   | descriptor DMA address[31:0]                                  |
+ *          +---------------------------------------------------------------+
+ * +0x014   | descriptor DMA address[63:32]                                 |
+ *          +---------------------------------------------------------------+
+ * +0x018   | auxiliary window BAR offset[31:0]                             |
+ *          +---------------------------------------------------------------+
+ * +0x01c   | auxiliary window BAR offset[63:32]                            |
+ *          +---------------------------------------------------------------+
+ * +0x020   | auxiliary window size                                         |
+ *          +---------------------------------------------------------------+
+ * +0x024   | auxiliary DMA address[31:0]                                   |
+ *          +---------------------------------------------------------------+
+ * +0x028   | auxiliary DMA address[63:32]                                  |
+ *          +---------------------------------------------------------------+
+ *
+ *          A: auxiliary-window-valid bit. If clear, aux BAR and auxiliary
+ *             window fields are ignored.
+ *          aux BAR: BAR that contains the optional auxiliary window.
+ *          desc BAR: BAR that contains the descriptor window.
+ *          hardware channel: DMA controller's hardware channel number.
+ *                            Revision 1 entries are currently consumed in dense
+ *                            0-based order.
+ *          descriptor window BAR offset: BAR-local byte offset of the
+ *                                        descriptor window in desc BAR.
+ *          descriptor window size: descriptor window size in bytes.
+ *          descriptor DMA address: endpoint-local address used by the DMA
+ *                                  controller to fetch descriptors.
+ *          auxiliary window BAR offset: BAR-local byte offset of the auxiliary
+ *                                       window in aux BAR.
+ *          auxiliary window size: auxiliary window size in bytes.
+ *          auxiliary DMA address: endpoint-local address corresponding to the
+ *                                 auxiliary window.
+ *          reserved fields and bits: write zero and ignore on read.
+ */
+#define PCI_EP_DMA_METADATA_MAGIC		0x4d444550 /* "PEDM" */
+#define PCI_EP_DMA_METADATA_REV			0x1
+
+#define PCI_EP_DMA_METADATA_HDR_LEN		0x1c
+
+#define PCI_EP_DMA_METADATA_HDR			0x04
+#define  PCI_EP_DMA_METADATA_HDR_REV		GENMASK(7, 0)
+#define  PCI_EP_DMA_METADATA_HDR_LEN_FIELD	GENMASK(31, 16)
+
+#define PCI_EP_DMA_METADATA_CTRL		0x08
+#define  PCI_EP_DMA_METADATA_CTRL_REG_BAR	GENMASK(2, 0)
+#define  PCI_EP_DMA_METADATA_CTRL_WR_CH_COUNT	GENMASK(10, 3)
+#define  PCI_EP_DMA_METADATA_CTRL_RD_CH_COUNT	GENMASK(18, 11)
+#define  PCI_EP_DMA_METADATA_CTRL_CH_ENTRY_SIZE	GENMASK(26, 19)
+#define  PCI_EP_DMA_METADATA_CTRL_HOST_REQ	BIT(30)
+#define  PCI_EP_DMA_METADATA_CTRL_READY		BIT(31)
+
+#define PCI_EP_DMA_METADATA_REG_OFF_LO		0x0c
+#define PCI_EP_DMA_METADATA_REG_OFF_HI		0x10
+#define PCI_EP_DMA_METADATA_REG_LAYOUT		0x14
+#define  PCI_EP_DMA_METADATA_REG_LAYOUT_ID	GENMASK(7, 0)
+#define  PCI_EP_DMA_METADATA_REG_LAYOUT_DATA	GENMASK(15, 8)
+#define PCI_EP_DMA_METADATA_REG_SIZE		0x18
+
+#define PCI_EP_DMA_METADATA_REG_LAYOUT_DW_EDMA	0x1
+
+#define PCI_EP_DMA_METADATA_CH_ENTRY_SIZE	0x2c
+#define PCI_EP_DMA_METADATA_CH_CTRL		0x00
+#define  PCI_EP_DMA_METADATA_CH_CTRL_HW_CH	GENMASK(7, 0)
+#define  PCI_EP_DMA_METADATA_CH_CTRL_DESC_BAR	GENMASK(10, 8)
+#define  PCI_EP_DMA_METADATA_CH_CTRL_AUX_BAR	GENMASK(14, 12)
+#define  PCI_EP_DMA_METADATA_CH_CTRL_AUX_VALID	BIT(16)
+#define PCI_EP_DMA_METADATA_CH_DESC_OFF_LO	0x04
+#define PCI_EP_DMA_METADATA_CH_DESC_OFF_HI	0x08
+#define PCI_EP_DMA_METADATA_CH_DESC_SIZE	0x0c
+#define PCI_EP_DMA_METADATA_CH_DESC_ADDR_LO	0x10
+#define PCI_EP_DMA_METADATA_CH_DESC_ADDR_HI	0x14
+#define PCI_EP_DMA_METADATA_CH_AUX_OFF_LO	0x18
+#define PCI_EP_DMA_METADATA_CH_AUX_OFF_HI	0x1c
+#define PCI_EP_DMA_METADATA_CH_AUX_SIZE		0x20
+#define PCI_EP_DMA_METADATA_CH_AUX_ADDR_LO	0x24
+#define PCI_EP_DMA_METADATA_CH_AUX_ADDR_HI	0x28
+
+#endif /* __LINUX_PCI_EP_DMA_H */
-- 
2.51.0


