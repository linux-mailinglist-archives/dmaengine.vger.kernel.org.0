Return-Path: <dmaengine+bounces-12305-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id jbD2BQutUGoc3QIAu9opvQ
	(envelope-from <dmaengine+bounces-12305-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Fri, 10 Jul 2026 10:27:55 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E53B738723
	for <lists+dmaengine@lfdr.de>; Fri, 10 Jul 2026 10:27:54 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=valinux.co.jp header.s=selector1 header.b="LRM/mjEs";
	dmarc=pass (policy=none) header.from=valinux.co.jp;
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-12305-lists+dmaengine=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="dmaengine+bounces-12305-lists+dmaengine=lfdr.de@vger.kernel.org";
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 9368C300B460
	for <lists+dmaengine@lfdr.de>; Fri, 10 Jul 2026 08:27:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98C563EFFDB;
	Fri, 10 Jul 2026 08:27:37 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from TY3P286CU002.outbound.protection.outlook.com (mail-japaneastazon11020121.outbound.protection.outlook.com [52.101.229.121])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BC923EF650;
	Fri, 10 Jul 2026 08:27:34 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783672057; cv=fail; b=AWl9qzveqiZVvIlcDosunNZgHP/Kj6s9gNZf8IRxST4/F/R9CmRIPM04cq5/j2bU5PERqu61ix/1kzeUTqVw6z8ZKMXFqrE2jWbNEnt9U0YDgAPLQi4Ju2k4QD6B1wwfg05GaNMUUK2zU/qyh/Oz40MtdI73V4rV2YN5gqEPkFs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783672057; c=relaxed/simple;
	bh=wwd6JvYllptAuhuKADzUOuc16kn2wl8Vz8IE61WIaV8=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=QiSRiGXhhT6+4Lz6UB07AN7SEYODVkGzCzBH3YeWS+pUZcg/wSBb0fZNfIab4ksSuqmaannxYijWhxUB8dUvfT8OE3b9WhiUCimg+mJjSJxuQBrMAUjrAkfvosxvxR5GcLQDYIvOeCcfRXwEzOnekleozec/3aj4Ef0YCLWJz0E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=LRM/mjEs; arc=fail smtp.client-ip=52.101.229.121
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PR84gwic0J9k7mEsZjI42fSp6PA7dGbl2JFSGks3L7mpEjWQXJj1ldK0SkJXhMH4Ia9+cH9gAhIaVgj17U53CZue/cBTuDPmVIn13j0SfKR6/6W+H9tDownejj6fkQXT/2pvW9XWf5pS2We5i3cDP8K2VImQX1QcU5VG20s2b11SvmzY6o4Ze1BYfbZsIgu61BxqDtj0sBsAGJ16QdpEZFl99hlt+6LgTaUk5D4S5NzHHHNB0f/217NM9XjDE27/9tTp0jonDUBP1YUz4pIdx7cVbNqbO1wtEbd/Q2BlCKqNo1Z1oJxaqbv3kYlDCehSA+173Zs2+e6Lvu3nNP5uNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SpVMOSARVRuqNg6PamIi2/slBBeU9WIA3lC5EZ426Ds=;
 b=rqqPij/bzu0gZeo5Qbz9G9Mftjcg7EaX0E54kd0eXsz41VwdZH9I4vXbmxZU0DH0hsz1JxzLPpUdpDK8uHVhzYlHnDHr/aMKRFYmpWXzJD3W4mySj76KPT5ct4DGpBHVYi0Z5iak77xY4y3tzN/Y13V+UgoMcFxOdANt36EX7q2gTBDk942oRf/IFk0nk3saf4AkCnU1e3biCc0pcHHyU10o5p0biXMveLYxTavM2Rw84ht8OZUXlRcNb1bWaeUk5bVWXonBuYxtwI4x8Lf4stV193cilXZ+pjt9Cj7Bai59Qt1t1eBooXV1HLI1qwuUB89clSJP1xi+jVhwSriAOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SpVMOSARVRuqNg6PamIi2/slBBeU9WIA3lC5EZ426Ds=;
 b=LRM/mjEsUxKYxufC9Y2LeMxmZrl4zMDtJ6Kocy2K271PfvnbOsaZyRGHCYoUaEYrK5v2ekrSZ9cU/3SjrX0F84iSyJ+V279UGCW2icFDhCuUs788yxe9t3HU8jjaPvYILgRx6FdUm1nvYVT1YeeHTZJdFy/9YoAuIgXNYgfuLKc=
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:38f::10)
 by OS7P286MB7001.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:433::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.16; Fri, 10 Jul
 2026 08:27:31 +0000
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32]) by TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32%5]) with mapi id 15.21.0181.009; Fri, 10 Jul 2026
 08:27:31 +0000
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
Subject: [PATCH v4 0/3] PCI: endpoint: Add PCI DMA endpoint function (part 3/3)
Date: Fri, 10 Jul 2026 17:27:24 +0900
Message-ID: <20260710082727.2397253-1-den@valinux.co.jp>
X-Mailer: git-send-email 2.51.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TY4PR01CA0052.jpnprd01.prod.outlook.com
 (2603:1096:405:372::10) To TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:38f::10)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY7P286MB7722:EE_|OS7P286MB7001:EE_
X-MS-Office365-Filtering-Correlation-Id: 0502bf11-a760-4756-b4b9-08dede5d1609
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|10070799003|376014|7416014|23010399003|18002099003|3023799007|6133799003|56012099006|921020;
X-Microsoft-Antispam-Message-Info:
	GsEu+svXJv5hZLjn2+z1MnKVbm2hCG98jVcOl3xCEO2PQOlrg7s3kr5CBu5BiT3ta7z7SzuQZL5tVz5fU00zf9JbzrjCoVYm4ofpLf5rTp/h7vI4uIOUQbrdmzClgYd6TTz5uksf9vdId7kJikYWUUypW1T+/kw/UJZ+5MNl9yngNBZJfywyz+HimmR7Wj2/IJoiCWV5ktaHR2ufAouVFCKJgDxBi35JRBdLNpvZTkBWiNXXGT3CLyIuAE8lfU/UNavSHDBF9CJoIv6a6h0WmCagSgKZHi5tstbl63Sum5Tmp6bj8z9/voxaxhLuXvCRfxrGOvr9e0+2/+CR6kDupS0TjrCLDk2fWotaTLqDsMsahBW1UCOFYOnk2yrMdQQGRZs7Y4IJE/eu+Xn8Cv5sB7I3bOqIWKbisyi2CQVO2AoCY8ZLVKAyUqkb6cjin+r6IkN8z3kzce5hWGP620NmT+AYz5HE6PykHtedOR04akPJON7wZ7/nzPR3SH6x58GNN4G+E6Oclu3B5jRzVvli73eL9gGY9BaT4Cz2QRFwr1sbX4r6YaOTNbcsv9n3AXf++bQC+K762rxwvG1SEbnElHYb105jLfVsfsUftOfCNlDJK7IywWNFZ7q6Bz6aUo6W8zqi1LHQtGQ4CSvSoWtFH1lR2ekUr9cwKNFeg2+PJd6EI78xbkUntY7VuAdolgX4Aiw7inRCcJs0nEck5CrJ1w==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(10070799003)(376014)(7416014)(23010399003)(18002099003)(3023799007)(6133799003)(56012099006)(921020);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?g+85+U1cJs4HKFSZoR+fJeecrUwIrszE+LFDGm4iCOdAwKOvcjQ34iq9MaLO?=
 =?us-ascii?Q?7tI7DHaT6GuZrjMkEGbiFmdJDJ/6axThcZrK3xiEvc+ocEN9XsWPC3qvWAQ3?=
 =?us-ascii?Q?fVkKgwrS8jTf9oP1JRHGvI7zszPjZ40HuuvgfqOhKB782ktachq6o3SLRv6R?=
 =?us-ascii?Q?9VyFZXkAyVLL/4C9BktHAzlycaJDRTfHfJf/2+Zq0ode0EanZ2WhInlVypYK?=
 =?us-ascii?Q?o0w/mtkOFQH2/0ZFhQfgLjs//jzaqiLRGQL31Z1c3PktGSZ8pIfQ7jDhaFUQ?=
 =?us-ascii?Q?mjSBSGJo2PlMyffga6O9Nm9/s1GMYSZOEnhepLu338smj2+SFyhBDWNSyffj?=
 =?us-ascii?Q?SkIRAJD8Jumq21kh941D5PZRMv0JdG/ZwMCRHh5yKjrPfhPTN54wQItAMCO0?=
 =?us-ascii?Q?ySNPVD09fB+M+QswtdkouWQE98M52PiePj3p0mQ0sygXHh4Ccpke48u2yXsj?=
 =?us-ascii?Q?opEpgNq5JK4e4fU3vr5+oidMyw37MFq66Ga3SDQbOb1Mkhj6QqrOJEvinkNb?=
 =?us-ascii?Q?dozwcKACtgvjyDme6pgs4EfBpXk4NBbrfC/gaThZeV2n3G4lrMGZEOaCP010?=
 =?us-ascii?Q?QF3QLy+6eTLuZB1P3gXAfcq0+Qb607wm4/cY3C7A0RapbMqT4Rwc7vSPx+AK?=
 =?us-ascii?Q?EZ4wwxyhRkRbLdJuLLQ7n1Y3BxuUnsrpF6qGhp3B9CebDvM3aibalp2Qi0Dg?=
 =?us-ascii?Q?SKwoYHMLjCi7g0wzSzslF/MpFzJOcYyWapT7AErDGrSxrSNHPmwH2HFJLTo4?=
 =?us-ascii?Q?yTr3160aHYwXraKaC6G/2EUZHppXg2wQNUfgvzmwiNs2O+is8iuzkiYG1cKb?=
 =?us-ascii?Q?pIOBT+7S6ez6RviJHPwz+lrncN54vOf7tnAFHjsged/5PCCgNvcE6nmb0oyP?=
 =?us-ascii?Q?iwbcDiUQinF+Ic73uXeIsnUg4qXHRxoR79iQNY7opY1992TYuNbb5w/E/BoE?=
 =?us-ascii?Q?ksHM8dtZWzPamBkP8vk0+gv/aAc5aVhD2TqyE8knLohbuP6caoh3aWmNuphR?=
 =?us-ascii?Q?eXYUI/tAVd6pcHhsA/AQKdn6EwiDsixONTeBJqNwXS3Uc2mJqiWddZoLgwbX?=
 =?us-ascii?Q?2pEEE6Yt8hpyFPMFCcvs8LzUv2o49hIOAsdhZXsWpnp10PjJlOZkgqqJ/2hE?=
 =?us-ascii?Q?53u23va7JR1xo77Cu7gdKJx7DiIMH0ePvQYT9EZD5c0mKUmds2VBgXn+mSQf?=
 =?us-ascii?Q?tc0fNgBbn7OPqhxUpB4i6nMmfflbPheHhp2kHYAEnhTLab0/3o1+aOgOi5L2?=
 =?us-ascii?Q?HqntPNQqbNmat+TSgD5uG8zFLrkYWiyyR2HiVjqRMZ82DEnQaB/xPURvk8ja?=
 =?us-ascii?Q?RK0wgiB/bCJweqchbC2BlRN2pXjAcH70cyS7FsATSW3R9QRAiIOFs0S4GYf1?=
 =?us-ascii?Q?SZVzzE418sA/kZPXDoQ9+AjoKn14hx80TwrsVGMkrMRsTo/w6EaX62qy99hn?=
 =?us-ascii?Q?BQiijGpFMWlEUBq18j0AHgcWP8/vDLOqD2sywbwzp67NuuSIsumUdd7GCnfh?=
 =?us-ascii?Q?FGG0sxez/crMSzTkt4bJkjUFiiozzlTUod2nrjwsali9L4QQD9bqv6Mfotwn?=
 =?us-ascii?Q?u6HiC+RKSAQNrUizVahkspjUfkILzd3Y3xWlnVRF5CUjIkXrl1N1XsllXVQz?=
 =?us-ascii?Q?fegYeNJq20Ms7Xp8R4LgBhMCFtqwDWjhWmbDOfK/yAigEsjv8IffGr9m/8t0?=
 =?us-ascii?Q?KVBJlxRgef54Fmwrlcvc4kGtFQwnGrA/1GrvWQ1FMPtukAqGkSJj+LS4AD26?=
 =?us-ascii?Q?ijU45x6nN3WfH+ocz22lo+wZ0NfsYgOIjN/8fZLePsX8x/MgKmQv?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: 0502bf11-a760-4756-b4b9-08dede5d1609
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2026 08:27:31.6810
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fO1XbXy8Tfi7w4Jw8F4VngufIf5TUNx9OzeSEoB8D0nc6R6mfBdythoGT2p6+FrdFW/vVT50bqgxl7AWBu2cLw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS7P286MB7001
X-Rspamd-Action: no action
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[valinux.co.jp,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[valinux.co.jp:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER(0.00)[den@valinux.co.jp,dmaengine@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[17];
	TAGGED_FROM(0.00)[bounces-12305-lists,dmaengine=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TAGGED_RCPT(0.00)[dmaengine,renesas];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,valinux.co.jp:from_mime,valinux.co.jp:dkim,valinux.co.jp:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 9E53B738723

Hi,

This is v4, part 3 of three series for PCI endpoint DMA.

The three series are:

  * part 1: dmaengine: dw-edma: Prepare for PCI EP DMA
  * part 2: PCI: endpoint: Expose endpoint DMA resources
  * part 3: PCI: endpoint: Add PCI DMA endpoint function

This series adds the host-side metadata parser, the pci-epf-dma endpoint
function driver, and documentation.

The endpoint function exposes selected endpoint-integrated DMA channels as
a separate PCI DMA controller function. The host-side dw-edma-pcie driver
discovers the BAR metadata, requests the final layout, and registers the
exposed channels with DMAengine. Host clients then submit transfers through
the regular DMAengine API. The endpoint function keeps the metadata BAR
stable and uses a separate DMA window BAR for resources that need dynamic
subrange mappings.

No fixed PCI ID is assigned by this series. Users provide the PCI
vendor/device ID through configfs and bind dw-edma-pcie explicitly, for
example with driver_override.

Dependencies
============

This series is based on v7.2-rc1 and depends on the dw-edma
fixes/groundwork series and parts 1 and 2:

  [PATCH v4 00/14] dmaengine: dw-edma: Prepare for PCI EP DMA (part 1/3)
  https://lore.kernel.org/dmaengine/20260710081518.2394357-1-den@valinux.co.jp/

  [PATCH v4 0/6] PCI: endpoint: Expose endpoint DMA resources (part 2/3)
  https://lore.kernel.org/linux-pci/20260710082156.2395844-1-den@valinux.co.jp/

Open question for the full series
=================================

One remaining design question is how to support endpoint controllers that
can expose only one PF. One option is to keep pci-epf-dma as a separate
function and require multi-function endpoint support. Another is to fold
the DMA functionality into vNTB for such platforms, similar to the earlier,
likely superseded, separate series:

  [PATCH 00/15] PCI: endpoint: Remote DMA support via vNTB
  https://lore.kernel.org/linux-pci/20260312165005.1148676-1-den@valinux.co.jp/

My intention is for the first real consumer to be an NTB netdev/transport
over vNTB, using this DMA path to accelerate data transfers. Embedding DMA
support in vNTB would make that acceleration available even on endpoint
controllers that do not support multiple functions. However, it would also
make the vNTB code significantly more complex. The separate PCI DMA EPF
model in this series keeps the design cleaner and more modular.

Note
====

This series touches both dmaengine and PCI endpoint code. I kept the
dw-edma-pcie metadata parser together with the endpoint function so the
metadata producer and consumer can be reviewed in one place.

If the general direction looks acceptable, the dw-edma-pcie patch may need
a dmaengine Ack if this series is routed through the PCI endpoint tree.

Tested on
=========

The RC-to-EP data path was tested with a small out-of-tree DMAengine
client. The host submits a DMA_MEM_TO_DEV transfer through dw-edma-pcie,
which uses a DesignWare eDMA read channel to copy host memory into
endpoint memory.

Tested with these endpoint/root-complex pairs:

  * R-Car S4 EP + R-Car S4 RC:
    eDMA unroll; DMA register window mapped through a BAR subrange
  * RK3588 EP + CD8180 RC:
    eDMA unroll; DMA register window fixed in BAR space
  * SpacemiT K3 EP + CD8180 RC:
    HDMA native linked-list; DMA register window fixed in BAR space

Note: The SpacemiT K3 test used the vendor Ubuntu kernel
(6.18.3-5-spacemit-generic), which includes pcie-spacemit-ep.c, with the
required prerequisite series backported.

---
Changelog
=========

Changes in v4:
  - Rebased onto the new parts 1/2 series.
  - Support IOMMU-backed EPCs by DMA-mapping the dynamic DMA-control
    MMIO BAR submaps for the EPC parent, keeping descriptor DMA
    addresses unchanged.

Changes in v3:
  - Select endpoint DMA match data before copying DMA data and require
    driver_override for the generic endpoint DMA fallback. (Sashiko)
  - Accept HDMA native linked-list endpoint DMA metadata.
  - Consume logical DMA channels separately from descriptor memory
    resources.
    (Sashiko)
  - Delegate channels through the EPC DMA channel delegation API instead of
    v2's EPC-provided DMAengine filter callbacks.
  - Allow HDMA native linked-list channels to be delegated at channel
    granularity.
  - Preserve HOST_REQ across link-down and retry DMA window submaps on the
    next link-up.
  - Drop trailing colons from documentation subsection headings. (Randy)
  - Document HDMA native linked-list mode support and the current non-LL
    limitation.

Changes in v2:
  - Follow the part 1/3 and part 2/3 v2 channel-claim model: pci-epf-dma
    now claims delegated channels through DMAengine filter information from
    EPC auxiliary resources.
  - Select raw-address dw-edma-pcie platform ops from the endpoint DMA
    match entry instead of using a match flag.

v3: https://lore.kernel.org/all/20260620170844.3757241-1-den@valinux.co.jp/
v2: https://lore.kernel.org/linux-pci/20260525063456.3317509-1-den@valinux.co.jp/
v1: https://lore.kernel.org/linux-pci/20260521063638.2843021-1-den@valinux.co.jp/

Best regards,
Koichiro


Koichiro Den (3):
  dmaengine: dw-edma-pcie: Discover endpoint DMA metadata
  PCI: endpoint: Add DMA endpoint function
  Documentation: PCI: Add PCI DMA endpoint function documentation

 Documentation/PCI/endpoint/index.rst          |    2 +
 .../PCI/endpoint/pci-dma-function.rst         |  188 ++
 Documentation/PCI/endpoint/pci-dma-howto.rst  |  201 +++
 drivers/dma/dw-edma/dw-edma-pcie.c            |  401 ++++-
 drivers/pci/endpoint/functions/Kconfig        |   13 +
 drivers/pci/endpoint/functions/Makefile       |    1 +
 drivers/pci/endpoint/functions/pci-epf-dma.c  | 1511 +++++++++++++++++
 7 files changed, 2315 insertions(+), 2 deletions(-)
 create mode 100644 Documentation/PCI/endpoint/pci-dma-function.rst
 create mode 100644 Documentation/PCI/endpoint/pci-dma-howto.rst
 create mode 100644 drivers/pci/endpoint/functions/pci-epf-dma.c

-- 
2.51.0


