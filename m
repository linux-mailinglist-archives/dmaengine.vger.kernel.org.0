Return-Path: <dmaengine+bounces-12297-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id x2MaLHGtUGpB3QIAu9opvQ
	(envelope-from <dmaengine+bounces-12297-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Fri, 10 Jul 2026 10:29:37 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 06C6773879C
	for <lists+dmaengine@lfdr.de>; Fri, 10 Jul 2026 10:29:36 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=valinux.co.jp header.s=selector1 header.b=tkui2bAa;
	dmarc=pass (policy=none) header.from=valinux.co.jp;
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-12297-lists+dmaengine=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="dmaengine+bounces-12297-lists+dmaengine=lfdr.de@vger.kernel.org";
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 63A563044F3D
	for <lists+dmaengine@lfdr.de>; Fri, 10 Jul 2026 08:22:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D1B33F12DC;
	Fri, 10 Jul 2026 08:22:12 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from OS0P286CU011.outbound.protection.outlook.com (mail-japanwestazon11020086.outbound.protection.outlook.com [52.101.228.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C5493F0759;
	Fri, 10 Jul 2026 08:22:10 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783671732; cv=fail; b=e06sySWRNB1VicKj1fjB6U9/7tGh0g8Vu09kLGG89Cn9GEs/QW67neyCQ5DrUIDm0MY2GDPeZeFbAwaNyHfnI8845to++o2mW7ycVbMGSouwyZlVNsrS1rPZ9h2dmiqf0DOPDQPi/CZKFVfUOrg6j7sOuO8/QqTPWuayIRYM3kU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783671732; c=relaxed/simple;
	bh=C88OYnu5aRU9mdRl4Amy+jbp21KvWNWTIjMseB7vX9I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=JkSbCxIdAT/bmUlMwXRm2+7ho2gzHj8Ul1B3o1yf9tF/fITK+QBs0s/udaAncWq6uSoqY9ZTF/9d4iEd/wLIx9BYGjVcGmNHaNubynAZrg4wAPWvg97ubo31Rjo/1YOVvhuSkKCp7puz7zrYUVgP2ZOrGKYj4CtDc8moPeJmBXY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=tkui2bAa; arc=fail smtp.client-ip=52.101.228.86
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RtkE94FFxPaKqIhnAMVDxyuvN14TJ+GPozF9GfcrY24DC0VIG81LHKyps15ZRtg8TOQxspu+K9agJB82747yGGJ1sPQ+PBc5plKc2gGas5EItjU0jxc7Yp52aked2rFRStWoaJrptwU4ZG845/ZN2ljN0xno2JHODKPxkZ6BTl9PHXZQrWqCReYpdrejM5h7LxLQ4spWSLk31H7yEEuWN3t6kJBFKLTl0MjiVenW/0UM8bhhM5D4WTvdR1l7feIvUBbVFRuzawSkargTyKX9UTKXU2vYhua7HxH5XYnZm/NKMII8THgYtPX5wXRHCv9XKDuvl1rvZERn9HF5CYV08w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jkQqU3v+GEG1KGQzP2UPns+HROjlGtRArh0nNidCLXI=;
 b=O0Pz3KCmshwriHLn/0csabFaKkrAafsJ5TtavA0dLfy7kQt5urff6KhlPYFcZnDJUefSaJ4UpwkHdERwcmCsdExEX4qgGDyT98SfN4a6+ePdYt1q1+Idt73qx2TCRtR0Fpuy5twq8x6EOYzz4JD1Jo1sXQ5pRUUwpcoPyyimZkJCqrgh3VYv6njPSEDnjF2rTIukL+yJBAOF1xBiMpIxCdYHOt3nhjYTKKm4X2vQyoJu4jW7HJNQwUZ2Wk20UTb30iDxnHkIpMjnR+q65wIMnWuFVohEMDyzZhy5hXz65uX3F02eJz+msBHyhIZd7zIo7rHodqei96Zi482SCwGD/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jkQqU3v+GEG1KGQzP2UPns+HROjlGtRArh0nNidCLXI=;
 b=tkui2bAacnUZndjDq3hPjxsCZmidPTqjkKP9zZaDu6SrlTzaxAN+WaxPrP7rOi8TSNYMx791g+hy9DjtPDBYeGA0LZdCtSeJuAOeAP2pbS1MEQepcvvoKziQ/+YiC7i06KeEX6pXQ/Tn0LoTL6greoezDYV3bRQeiTLtMIR/Dkk=
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:38f::10)
 by OS3P286MB2742.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:1fe::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.17; Fri, 10 Jul
 2026 08:22:02 +0000
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32]) by TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32%5]) with mapi id 15.21.0181.009; Fri, 10 Jul 2026
 08:22:02 +0000
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
Subject: [PATCH v4 2/6] PCI: endpoint: Add DMA auxiliary resource metadata
Date: Fri, 10 Jul 2026 17:21:52 +0900
Message-ID: <20260710082156.2395844-3-den@valinux.co.jp>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260710082156.2395844-1-den@valinux.co.jp>
References: <20260710082156.2395844-1-den@valinux.co.jp>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCP286CA0085.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:2b3::8) To TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:38f::10)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY7P286MB7722:EE_|OS3P286MB2742:EE_
X-MS-Office365-Filtering-Correlation-Id: f88fe285-6001-4f57-d724-08dede5c51e1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|1800799024|10070799003|23010399003|366016|56012099006|6133799003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	EjNrdIrYYV8RAiaDJQ9MMmKL38KeudkNOOxXUS44GkGxTcuEnKDyzWG44jLdzNrBXGV+ppo2CR/hjlsyVm4qPX67U/zNIuGQALFn/eENdArr1xDoUPUZbtagWY50bTlsj1IUWQ4qx+TJdhRizvNIek1pMRBIS0YKSuo8Y0WjcKA5msG/pmRcU2vySiY4gT72Ptvd9AaTo0C7+UNfDW6B4XrvNk87rfWlfo/BdBwRqTYFQ3fyeL82hIAuUlWw24SZV6t+eQz0HaOVNU0K5MKRnvJTTLK7ybAZ0m4UA/M9OAaQyS+NXG6sibt+nhfGLce0MjTspepBJVSt3RmgNCBtt4NMLeJAQ3+CcFR1OT/S3Saa5npkymC1pVJWt/M/aYUqS9z4TRW21kVze6CTFYzCdXiomu2vJjlzUdzqVa5MzDnElG9uPmcE4aqR6r/9PWYtgxqW8hir3WKGdc45YBgkDARCkwFruPV/qaUSO3BP6TjQ0DHcGri4iWYufC8J2b4H6kFgtjzO2hTgXZ8olgMJ4ejnIX/tu559g6XCNc1Yp+qZxNEzzF5ICmCM14xFBT8LFg3RZ3omDVr3IeUUFUGDXCUzrZl35qtigrKc96ja/Pu9qupd9teDlNBDauSUS8SUe58SAW4ttp9qVbG7slBXB5zd+MPCso8UqabQbl+XZ/E=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(10070799003)(23010399003)(366016)(56012099006)(6133799003)(22082099003)(18002099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?uq4WoCmuza4DPRs+YAhWJlObxlABcbognBHrBZco0fwKZbWZNzZA+PfxhDAH?=
 =?us-ascii?Q?rd9/x3900qYcD/N4RHwyzNTpYIKw9j/emsKR4lPwkCi/sol+vF6Irk+FHwK0?=
 =?us-ascii?Q?Yl33kZdKnHM/PaeHREreYIGE0HGg+mvLcR+d4eYAW5V2hv6KNQNE1F0KZuvj?=
 =?us-ascii?Q?ZQQvc6qpBgqyq6R1Z17AqRA2P5cT1d51oY9UyhuayLXNCf8yhhfW/UjALYvk?=
 =?us-ascii?Q?wb35ePjfKPpRLQX/uc8EPl7NPwKkWJq0VWGogSJz9Zup+dMiS2IRz/zQwcMO?=
 =?us-ascii?Q?tSmo/zzBTlx6rI1RAy0uMSEPbkF+hpGr482rvmovwkpe40h7aTeqQfeI1pmr?=
 =?us-ascii?Q?S0C1fXTuJ6w61BfPE9knPs6XBjdeEsUxjsx7aPIPYAPgzxV3ozySV+YMxgsJ?=
 =?us-ascii?Q?XyibvcrInMFPEANwrWO6S0E6pRBSWV+2Pgkw0QgvGQf+LWVwDTKacbBvOCZV?=
 =?us-ascii?Q?gXV6mTXpAKTwzct3KB+koLrXfBLddP1Kpg1PO5senbwRlcsMGeMnxtoTv05Q?=
 =?us-ascii?Q?52xWViu6ZAnL7FX4M0xjOhXwp7HYUdSyUYLTqB2XG1sPtbShZ5/U5H8hl8UE?=
 =?us-ascii?Q?Kj+zrs65Ua32hsd/zDlDsQTLU4OsaS0JQ16rjm6oZKF2ieu0z+uJ2UX94wOK?=
 =?us-ascii?Q?QnnghdstiOT5ZwTb+RrawhqW0p0VdMkvUDB6bs6zGLeAbGgRFKdoqA1pS2Zi?=
 =?us-ascii?Q?h+C2xtQ45Ud+UpHi7uobY/GKI/FyOu8A5lSNlQ0OqUghyFEfdLqlksp+DpTh?=
 =?us-ascii?Q?qJlKhA1klKXdHAqC5rdhpLXTcX4qqpJtUdx3fPhOP65gHYNAJAdlIInIALsZ?=
 =?us-ascii?Q?yJ8UoOaqRYZ8zzvPJXFlgQVHG2qQLvCp0yGzTpkkWxvBnT+ubJRXalvDTHMW?=
 =?us-ascii?Q?MFIjzE8lQe95GSbk2Gtcl1rSxd0Kuap+IVyzM0eig0aDoKTpwQ7/8nEmsjdp?=
 =?us-ascii?Q?nqkaU+blhDS5EyGpbnC2CzhUQT2dg90P7B6RoVdl5c+FNU+gcLbldcihj4Se?=
 =?us-ascii?Q?BzNuIRVBGJ+47ZVR+Zdrx+8L2gVvGHQM68MWVcY9tYDp/gWx6DuJbfH1BHq6?=
 =?us-ascii?Q?SqDmRuUmxzLICNo7TSwutrR2SgUaB4Vw9ri/DEIJt7aCasH6RKVJMXIkgayA?=
 =?us-ascii?Q?rtRhfFUq99xMa/gqU8JtPZh3AZpOZW74vlzDStcgvFHpEUL+hoVcnPhiP+Cv?=
 =?us-ascii?Q?AL5PWhN/bhFLM0B+ogKaKheBIVsyjpHr4hZklVkthIPSmvGHp1liEiRZS+Sd?=
 =?us-ascii?Q?dI9OKf3lZ+dX4P9P9obTzJyNb92NxTo3nkBHVBybF7Ahr/jDwKKQ98UnDGFQ?=
 =?us-ascii?Q?CYeu2Xn7hcYHb3GQ2TztbAN2BLP+enHjngIccOxBBvLX0VXF1zpPcdFPZ/SR?=
 =?us-ascii?Q?+SqjwAKWpjYrsab+BZ26bcV58UcJzsTQ7CTJHVdsNnf+h99zJZPUKUgcAwXh?=
 =?us-ascii?Q?N3fikNJFgb0VKRE9cfAjYOGO/Tm49jjRMHcZg8n6094AED16gpTyqXeubl9/?=
 =?us-ascii?Q?pusoPvP3MZ1KgQcMXYhh3eA8JlRz31qp3daIUI1mvrQTpRWDK5CVCX1CFilV?=
 =?us-ascii?Q?EsoAqBTmdYxK7gUbLnzTSwxPm0LowENwyPItYQZ9MtTXlqb3ZFCVs1KMdz7I?=
 =?us-ascii?Q?7eQEhAwCwCOjz+JbwOtKArOPHarEtsDNKk1SjGEKVDip1Qol/m1mprrx7qFu?=
 =?us-ascii?Q?3PHHhtVn+6ioNq1GQ8iV6Ro6x2rC7icC2bBoPFMql0P5WSARRKTBeBV0rEzT?=
 =?us-ascii?Q?GyO7S5hxiH3/deCoRfiIpyzw9QxPcJQflMdStCsfqT0yfaezvCi4?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: f88fe285-6001-4f57-d724-08dede5c51e1
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2026 08:22:02.5742
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: v3v8nfBGOVf6WmEPCzHJOvguK1DiLs1vn1a7nyBs+ag9lJIWqE1N4PNCWmvseJqb0/BC0/zVnfNQbBgRopupyA==
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
	TAGGED_FROM(0.00)[bounces-12297-lists,dmaengine=lfdr.de];
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
X-Rspamd-Queue-Id: 06C6773879C

Extend EPC auxiliary resource metadata so endpoint functions can
discover controller-owned DMA registers, logical DMA channels, and
descriptor memory.

The DMA metadata is intentionally generic at the EPC layer. A backend
reports the register layout, channel counts, logical channel resources,
and descriptor memory resources. Logical channels carry hardware channel
numbers and refer to descriptor memory by ID; reserving or delegating
those channels is handled by separate EPC operations so resource metadata
stays independent of any backend-specific DMA provider. Descriptor memory
is identified separately so one memory resource can be shared by multiple
channels.

For DesignWare controllers, reg_layout_data carries the eDMA/HDMA map
format so a consumer can distinguish legacy, unroll, HDMA compatible,
and HDMA native register layouts without making the EPC API itself
DesignWare-specific.

Signed-off-by: Koichiro Den <den@valinux.co.jp>
---
Changes in v4:
  - No changes.

 include/linux/pci-epc.h | 46 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 46 insertions(+)

diff --git a/include/linux/pci-epc.h b/include/linux/pci-epc.h
index f247cf9bcf1a..8c89cb6d6733 100644
--- a/include/linux/pci-epc.h
+++ b/include/linux/pci-epc.h
@@ -65,6 +65,9 @@ struct pci_epc_map {
  * enum pci_epc_aux_resource_type - auxiliary resource type identifiers
  * @PCI_EPC_AUX_DOORBELL_MMIO: Doorbell MMIO, that might be outside the DMA
  *                             controller register window
+ * @PCI_EPC_AUX_DMA_CTRL_MMIO: DMA controller MMIO register window
+ * @PCI_EPC_AUX_DMA_CHAN: Logical DMA channel
+ * @PCI_EPC_AUX_DMA_DESC_MEM: DMA descriptor memory
  *
  * EPC backends may expose auxiliary blocks (e.g. DMA engines) by mapping their
  * register windows and descriptor memories into BAR space. This enum
@@ -72,6 +75,29 @@ struct pci_epc_map {
  */
 enum pci_epc_aux_resource_type {
 	PCI_EPC_AUX_DOORBELL_MMIO,
+	PCI_EPC_AUX_DMA_CTRL_MMIO,
+	PCI_EPC_AUX_DMA_CHAN,
+	PCI_EPC_AUX_DMA_DESC_MEM,
+};
+
+/**
+ * enum pci_epc_aux_dma_reg_layout - DMA controller register layout
+ * @PCI_EPC_AUX_DMA_REG_LAYOUT_UNKNOWN: unknown or uninitialized layout
+ * @PCI_EPC_AUX_DMA_REG_LAYOUT_DW_EDMA: Synopsys DesignWare eDMA/HDMA layout
+ */
+enum pci_epc_aux_dma_reg_layout {
+	PCI_EPC_AUX_DMA_REG_LAYOUT_UNKNOWN = 0,
+	PCI_EPC_AUX_DMA_REG_LAYOUT_DW_EDMA,
+};
+
+/**
+ * enum pci_epc_aux_dma_dir - DMA channel direction relative to the endpoint
+ * @PCI_EPC_AUX_DMA_EP_TO_RC: channel moves data from endpoint to root complex
+ * @PCI_EPC_AUX_DMA_RC_TO_EP: channel moves data from root complex to endpoint
+ */
+enum pci_epc_aux_dma_dir {
+	PCI_EPC_AUX_DMA_EP_TO_RC,
+	PCI_EPC_AUX_DMA_RC_TO_EP,
 };
 
 /**
@@ -99,6 +125,26 @@ struct pci_epc_aux_resource {
 			int irq; /* IRQ number for the doorbell handler */
 			u32 data; /* write value to ring the doorbell */
 		} db_mmio;
+
+		/* PCI_EPC_AUX_DMA_CTRL_MMIO */
+		struct {
+			enum pci_epc_aux_dma_reg_layout reg_layout;
+			u32 reg_layout_data;
+			u16 ep_to_rc_ch_cnt;
+			u16 rc_to_ep_ch_cnt;
+		} dma_ctrl;
+
+		/* PCI_EPC_AUX_DMA_CHAN */
+		struct {
+			enum pci_epc_aux_dma_dir dir;
+			u16 hw_ch;
+			u16 desc_mem_id;
+		} dma_chan;
+
+		/* PCI_EPC_AUX_DMA_DESC_MEM */
+		struct {
+			u16 id;
+		} dma_desc;
 	} u;
 };
 
-- 
2.51.0


