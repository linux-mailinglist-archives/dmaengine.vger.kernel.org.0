Return-Path: <dmaengine+bounces-10612-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CA4FCPyoDmpGBAYAu9opvQ
	(envelope-from <dmaengine+bounces-10612-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Thu, 21 May 2026 08:41:00 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0494C59F8B2
	for <lists+dmaengine@lfdr.de>; Thu, 21 May 2026 08:40:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 02987302A556
	for <lists+dmaengine@lfdr.de>; Thu, 21 May 2026 06:37:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 331A2395AC0;
	Thu, 21 May 2026 06:36:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="RHVFk94y"
X-Original-To: dmaengine@vger.kernel.org
Received: from TYVP286CU001.outbound.protection.outlook.com (mail-japaneastazon11021086.outbound.protection.outlook.com [52.101.125.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE042395273;
	Thu, 21 May 2026 06:36:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.125.86
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779345417; cv=fail; b=ux4OGK0mW5pG29NOhQHQB07w9iEZOR16YxnF0tFOzNpoi6NHqpya9RU8itrYDp/m0j/nwxP1BzvZvrncdJSBmNdPZ9Y7cZXjTk7PaXd8PQ2K1a5pCCs9fvPSwnXp4A9SXYyVo+RtXCtJyBT7L5zJtScpAwFwzOsbGT+mv+mSPO8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779345417; c=relaxed/simple;
	bh=xupSMoh7sJH84KOQ9LPKMbX2M5FVkLAxsVYm9kAjFnY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=MfLYvF9/UrGgdrtp8oJls0dGNpoTHWBtrTM+0rQnAG5e/dDcQndfBAEnCn6+TdYYCyQYP7Qy8dTlv+ajpDT5iFvRpGsOya6w5WYB3vG0rnGM7HTbjzoZAwHDQtkzciJAPYNMHr3hDQVsLpDaIcmqKDJTUVttICPIlxCtvFr1n7U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=RHVFk94y; arc=fail smtp.client-ip=52.101.125.86
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OQMqovipy871YuovvkEZLCG9//WwhEzlqHAuaBM6rIBOEZgYTMODJKfDi2OdcLuLNUkFKmPpyAcuATneMTub+NyzdHoLQsd0lVpPKiP8zMNZ4ZiJXDWPDAq+2ODo/p6vQjpAli0+xpT3RwR8gw/CKy9a4zSOeteWyW8kirLoHnsN9VhEAAgPLEQU7tq0G2WCxj9XR74eKCWaIqeEqUOzFDp9FTtAZS0bd9y8ndEQpSHTiDy/4d5+XWPZl2DXljrOuy96XR6AIDLCj1dEV29klwrfpEtTs6WUovUqfmXw05feCL7re9Dczs1jTV4O0Gh8PbuPsPDfhiAGIdolU/fBzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=h8Kd5PMKJ1p9ZX2WiTOp3478oz/MWFzaycfRVmo/Rio=;
 b=IAOGlt58JmTHm1wNnJpeB7tgbhsXNOR/vWJq2Z4QjDgiaTYQqjyVOZ/O2mdFIRlYnwgI3xI3vkBsBM/I2vMz9W0rFE5bl6RyM3QrAzS+d4cOP06/U6GRXx/V05sFzZttsyByUDFXNDMN8pRKkeu7u1Co8CXQPbaxaCeICnATvZLaDX5NAOS94mYl/xdvdMlqGV7F9XzMkYkV05p0BERDCUNkdMIvWiJgMkvoKP4F/2rlRSMTXgWYPSIPQbBbmJEXWi1Ec3F+jBHI70gRGs6B0Oc9sWORBFJEdZREN0ZkyjmW0RXPvokFO8UU8uqxyuf+DRpl4ZcRhqLK3Mk1rggngw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h8Kd5PMKJ1p9ZX2WiTOp3478oz/MWFzaycfRVmo/Rio=;
 b=RHVFk94yrgvYB65/0whM/zenD23DBtuJ9XKLPeQy3zI8qeehM2Nv1MMhHK2f+J6a3N5JxCBwjX16L5/ZBPSTtFPdL6aiedKGPjd3+uPigAwywEzV1aiAIUfxugPV+pu7JyEY1l8Rw3QRvxrGqY3Wf+p9dhueXkNlF82gUf36+pI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:38f::10)
 by TY6P286MB7399.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:35c::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.16; Thu, 21 May
 2026 06:36:46 +0000
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32]) by TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32%5]) with mapi id 15.21.0048.016; Thu, 21 May 2026
 06:36:46 +0000
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
Subject: [PATCH 3/3] Documentation: PCI: Add PCI DMA endpoint function documentation
Date: Thu, 21 May 2026 15:36:38 +0900
Message-ID: <20260521063638.2843021-4-den@valinux.co.jp>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260521063638.2843021-1-den@valinux.co.jp>
References: <20260521063638.2843021-1-den@valinux.co.jp>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TY4P286CA0015.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:2b0::15) To TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:38f::10)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY7P286MB7722:EE_|TY6P286MB7399:EE_
X-MS-Office365-Filtering-Correlation-Id: 5e31fd08-46b3-4b0f-07b4-08deb70354aa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|10070799003|376014|7416014|366016|921020|18002099003|56012099003|22082099003|6133799003|3023799007;
X-Microsoft-Antispam-Message-Info:
	JlYtWlACdsLM7vNclF9RvY60nmFIfJ7zWnzk83G1u7eEifTd11wfHnoaO98NJhiLtULIceohQFVv2Arti3orSCPP2Dmkbaxyh7oVxwrNxAxd2wqENfIrdSW0SkyWKSipCi2dQtZtyjeZcGgovvWkKBUn4MdeLL1AdlCwlrpBgcbG4YMruYYWhcVznufDRE+HwK+eQO78eGmgTDydrjvJ37XQF6VNc13TDjw/KCz0hZkEkwQb7lvelV8njfqpDf7n41UwXLoDZiRr+Ra8JOObgee+uBvk4wXOexqj86q6HHJrzN74x9da8PXXCAC/h+NwsnjAUFoeH0y7DfZOyZQaokz3ZKlLP15iXLo+3yRe+qkztI0uPEXG0ca+MixDJRBAoH/orANL9+gUYkl3uAfl8E7wheBd68747Gk0vJsTQTyVHb8dBt0YkZHRQkmW+N+9SPBcH6/cWPoL8vKgTvzyfy7xI1hbgw7Tp03LqrYokh5NjyqcUUQkPy4PLGPPG6MlSKQiBaVDwqzB+0KK06DzDtH07oxvfjdRLPCHEnQ7qY/NP+ZsrQRvXEDlA1i7ULEugyTbSenIebGCbSMP+/BJ6l22ATiWZBw/f/Mq9u5v8+hzZYSXfaRC8Vok7Y4BnMKONoIuNFu83YuTDcHLzh/4mVRIKXgYqSbc+jOmwlqyn+j68CH9Pgzc7j+yCGuEZci+sdjrcrQ6VcQbcZTYEkJ9pVMCu70BHObDffVVu0JVhos=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(10070799003)(376014)(7416014)(366016)(921020)(18002099003)(56012099003)(22082099003)(6133799003)(3023799007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?FCUJjeyp6T0yJTLQYGW+0z5/+s7J7wX+QQz8Glhy3Jg59PVSGl6ruCqo/Q1V?=
 =?us-ascii?Q?UXSce9AaCEcDu6FTkMJeDLMG4pbmIHjBPlTi6hqThW5k7lkV1OkoCPv1KLiz?=
 =?us-ascii?Q?smzny15l8LnH2dMPzSZAh0ZLZR3uJzNDJYC0OEmUQVMmVo9NjHbfNeIMhqEf?=
 =?us-ascii?Q?CetinTx9HoYIcmXFX4Tqs7EXaaLsx6a3pcnFX0f7USBsH+S+uyz+7FrnpsSo?=
 =?us-ascii?Q?cHgnn0qE+E+uNn7qedvt0mkaMz0gsEtu68J32C4+l6GiTaINpVrkVCjBh9lg?=
 =?us-ascii?Q?HbRP3N4P5TkzAbdgPhS8y1GSp913WgFZAeEnznjzlV55tsg7kqvDjZx2M3a+?=
 =?us-ascii?Q?gXsJ6bOohpFYcMFwgfGxkg+19CtzwHl8n8yjdK7+RueDCpDSFcefC/Za0qIX?=
 =?us-ascii?Q?jbPPASMJNfn5dR6MqH2hi9Mmg5a9VTNdVp5KfQmi3H58x9L31tkB1E0GvJmV?=
 =?us-ascii?Q?z1LOzjnh/kQOcC+IG9LnRJhIoa7R/8wOj9ifsuSo9dDibWUgwRm9h7g79p8B?=
 =?us-ascii?Q?2TbKYxxbCGBATiOIPkYm75p5GrtOvxup8ByO1V+n6AyPMnoOJhkbQxPPsb5t?=
 =?us-ascii?Q?8W8PoLMNqu9JKlGI+9GSlnCdazInSZdpUhGyPGSm9nXalj7VAeDpwy9VyWxJ?=
 =?us-ascii?Q?BGRaNS9+Rq929C6uZ016e/hjeBwXrvamjzsJiuoqxWOE296zn4MJzWpbhQh7?=
 =?us-ascii?Q?FeX2ruA66Bx7HBvK9ADnDiUTlNQ/+5WtGygyWCjYeYwAlCHHLWIsWDK9lWiR?=
 =?us-ascii?Q?WPQUmsEDOEHOt8OUYt4QQqRGHgX3J+5rdMVlzGuLXT5axkVAAfmCkyk7wLzz?=
 =?us-ascii?Q?mhDBX5YcSV9fBDn5iRCWlp+cfOLuEPMP8994vnkaolxlRaYNEXy45CqYUKmJ?=
 =?us-ascii?Q?kJzb7pgXY2QP53SNj8M9R7DkpzK4u2gb3qqALnWG+HyTB1VfnF0+MaqkWCgM?=
 =?us-ascii?Q?VNCPwWz/qensggEZL8k2OxxFwwr+Y2WgFaVCOYHqdoXGMkQrdUAnFK4u1ZEA?=
 =?us-ascii?Q?185b7GaaDSvXXd1/hl/ykKd1bofwdVtKfVaIS4Lbbp7OTTvnTSspMKzrWbul?=
 =?us-ascii?Q?jvGThtscLXpgtNbVrHG/qVZeOFyjfDj84XGAy+o2e4eDuxSj8wgSUZOGS/sH?=
 =?us-ascii?Q?9sgDWFcL+a5jOarxfLmSE+SMv2/SVRsx3UfULQz7qnZBQ/jWyOGZ4brSI5fl?=
 =?us-ascii?Q?EvFqMwz05pq7ESf9+eTK4wpyt6o8Rm5FZixtNHUnanbSs8y1ZsOSvsjddpS9?=
 =?us-ascii?Q?PnEXIq8BkdOEMThyRiaVxFGnh2B8mzPDwdPyLVbgqAmPc1Uu3DbnXQDU8Gmd?=
 =?us-ascii?Q?9wOMp+uu2GCt2nRofBxMWgrbzerbQt3tbWkjP+hxjCEN0IceWT7icYHnAndH?=
 =?us-ascii?Q?CVXJj0BJQ+UUMbrKUAZrP0r7XRR36OqS7xhJUt6he9cNqAVEdy1VlRPabLdm?=
 =?us-ascii?Q?7y2Bnzs8qm1ieJNdKCrbtVsftQls15cYq9mcMys8cK3r3l3AMx4LSXyjVzLw?=
 =?us-ascii?Q?V6bMPI5u5w9Dp8w74D5oNmCy3QSlOTya4xhiOi07FOia7zLBPfqcw/kw6oe6?=
 =?us-ascii?Q?6n9RuhucWSeoWIrXutH992xO4FCBKEhJf18nHyWqnjbDV6idrGX3BP21Zz5j?=
 =?us-ascii?Q?P/lakmNZ/FCLx1gcdTRPp9K943oGDkc17fHCDhoTiixCX0DNU14a8nE+zNBd?=
 =?us-ascii?Q?mqHOjEkN197dRA4KbpTcJFH32Vnx6qmlVwm0vbrgrjn/Yj4hVKfHM6TLMfCK?=
 =?us-ascii?Q?T25FAE1YGdLZlT5muPaQ9z6uVBaUmhkegoVW18xf/h3OchdpLNNU?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: 5e31fd08-46b3-4b0f-07b4-08deb70354aa
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 May 2026 06:36:46.7806
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ME6igPkbXQDl2gC9wgWxd9spLuQ1ECLxH1vfDPH1nDoQITOXpdVxtoRt+cVySutF83uvNQ00prUxRHEU3Cu+VQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY6P286MB7399
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[valinux.co.jp,none];
	R_DKIM_ALLOW(-0.20)[valinux.co.jp:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[17];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-10612-lists,dmaengine=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[den@valinux.co.jp,dmaengine@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[valinux.co.jp:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[dmaengine,renesas];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,valinux.co.jp:email,valinux.co.jp:mid,valinux.co.jp:dkim]
X-Rspamd-Queue-Id: 0494C59F8B2
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Add a function description and a user guide for pci-epf-dma. Describe
the BAR-resident metadata consumed by dw-edma-pcie, the configfs
attributes, endpoint controller requirements and the host-side DMAengine
usage model.

Signed-off-by: Koichiro Den <den@valinux.co.jp>
---
 Documentation/PCI/endpoint/index.rst          |   2 +
 .../PCI/endpoint/pci-dma-function.rst         | 182 ++++++++++++++++
 Documentation/PCI/endpoint/pci-dma-howto.rst  | 200 ++++++++++++++++++
 3 files changed, 384 insertions(+)
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
index 000000000000..54caf4fafe00
--- /dev/null
+++ b/Documentation/PCI/endpoint/pci-dma-function.rst
@@ -0,0 +1,182 @@
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
+DMA Controller Register Window:
+-------------------------------
+
+It contains the DMA controller registers programmed by the host-side driver
+to submit transfers, control channels and handle DMA interrupts.
+
+DMA Descriptor Memory:
+----------------------
+
+It contains the descriptor memory used by the DMA controller.  The PCI DMA
+function exposes descriptor memory for the delegated endpoint-to-RC and
+RC-to-endpoint channels.
+
+MSI/MSI-X Interrupt Vectors:
+----------------------------
+
+They are used by the delegated DMA channels to signal completion and error
+conditions to the host-side driver.
+
+Metadata BAR:
+-------------
+
+It is the endpoint BAR used to publish the endpoint DMA metadata and handshake
+bits.  The BAR remains stable while the endpoint function programs the DMA
+windows.
+
+DMA Window BAR:
+---------------
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
+The current DesignWare eDMA unroll and HDMA compatible support also requires
+each exposed direction to be delegated as a whole.  For example, on a controller
+with two write channels, ``wr_chans`` must be either 0 or 2.
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
+If any DMA resource is not already host-visible through a fixed BAR, the
+endpoint controller must also support BAR subrange mapping and dynamic inbound
+mapping, because the DMA window BAR is assembled from those resources.
+
+Current Support
+===============
+
+The current host-side support is implemented in ``dw-edma-pcie`` for
+DesignWare eDMA unroll and HDMA compatible layouts.  Other PCIe controller
+DMA implementations need corresponding host-side DMAengine driver support.
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
index 000000000000..84f322881aa7
--- /dev/null
+++ b/Documentation/PCI/endpoint/pci-dma-howto.rst
@@ -0,0 +1,200 @@
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
+Current DesignWare eDMA unroll and HDMA compatible support requires each
+exposed direction to be delegated as a whole, so set a direction to either 0 or
+the number of hardware channels in that direction.  If ``dma_window_bar`` is
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


