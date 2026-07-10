Return-Path: <dmaengine+bounces-12299-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id np7eISusUGrb3AIAu9opvQ
	(envelope-from <dmaengine+bounces-12299-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Fri, 10 Jul 2026 10:24:11 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AD5D73866F
	for <lists+dmaengine@lfdr.de>; Fri, 10 Jul 2026 10:24:11 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=valinux.co.jp header.s=selector1 header.b=uzR0i7pG;
	dmarc=pass (policy=none) header.from=valinux.co.jp;
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-12299-lists+dmaengine=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="dmaengine+bounces-12299-lists+dmaengine=lfdr.de@vger.kernel.org";
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D1411301104A
	for <lists+dmaengine@lfdr.de>; Fri, 10 Jul 2026 08:22:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A9213F1ABB;
	Fri, 10 Jul 2026 08:22:14 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from OS0P286CU011.outbound.protection.outlook.com (mail-japanwestazon11020086.outbound.protection.outlook.com [52.101.228.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64A3E3F12E3;
	Fri, 10 Jul 2026 08:22:12 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783671734; cv=fail; b=adeZ3rngs4OjJ/CKy51ankPUOEEgcvK7HpTNEbht4bLNDwfFdsWixzjsXWfaY4pMnRjU+p5XAwX6CQgMpy3fsQgk+ZYASFdpNOYJpzLlftLqbsktXd82L5qnIYBau8OVH2mBVTgkklxby188Ro8i20FowwGrrii3r3/dmcA1jh4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783671734; c=relaxed/simple;
	bh=cs90lAGk7gXM+maRpy7gHlIbbdbFs1vuqgCmyE86SHI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=n11HLkFKDVu0nYVAfCZ2hgy1z+mDXJuHZozVYwkdMNCWBt49ey4VvQMjXhoVG2L0JMSR2vWUGEz2luFCH8RDJoCWNjqQb/5FAWzg//HI596H2smD+fpapgN6RThpNU2lF2bbgrYD6+twqDwH5zlFQfX3AZvhaErUBS5VixF3v6w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=uzR0i7pG; arc=fail smtp.client-ip=52.101.228.86
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AXzOwWh275+FCChVV2iGHH9Sd2+my6xvSYev2mmTyyvUlbryMVpKIUmW3IfLvltn885MDzjFpseBdXLOHRqN50SHuOQlK9vs7wFAJw0R48b8w3/7Gons0HI4fa0i6fPemHKQmSw19HmS/FBGaYsZo+Tnm6g1N2lukc1GuHdVkKUJJoA1v943fGwadzLlkHFGAjRoEXNNA5HSxDVrTLqWE6IYzpDS/lEjwzgwk5/X6m9nqcA4jZi/koke+6Kylt866CmgZmNCDTljaQb2ywSQVMlM353TjTCPSS1NsjeZ4r3zRt70bFSCUWHayVvq3kG7HVLI6LUTqcQi5uZ/VvSESg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=k9O80eur0lBogsFVl+XwH+lFjtkXIQx0ZYzrKAYujhI=;
 b=YxwVfOyxdiaY6QEKMt1fyqdCXvkQmfL0eTV0JqwpW7Vj4HTGZn7BOiJwU0ypJrIqynJqGY5nm1B6/ITlkubjAk+9/BtRea8Tcpu/SnNwttiCuqrGcgp0JTfouU2ivcGyMSGbNTqyF57hUQibKvQ5VH5N0SbEHE4KJBsNIcGY0RKxT1C+RUfbWaNCY0iiz7szfaSYK/+4k+I5/GbCS+8NcImbGuRH2R3KGZDl2nCEpklp7RNs7eG3peSkV5np60qT1+9LXOwJgb+shrIcUJCYhymBUt/i4VBlUJbzyAAx7vLUaPDy9Hwy0/DcsT0eYpB2a3jXrcrAQRe+STGt67mYaw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k9O80eur0lBogsFVl+XwH+lFjtkXIQx0ZYzrKAYujhI=;
 b=uzR0i7pG7OS2q+GdAPrCjltpDlWV1Jl384ANZqXnXRkYj1oFD1nzzr5yjs6XyUDJ2stGsGh0Wy+WOC9bkuDDudJ8FCC47/duHTbGpJpmKU/+x4j0pUZ2s6lKvi2Zg0QO8Vm56XOZvVDg1GjA/qOvMlimnjCNfgS7KUmQG/JBX9Y=
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:38f::10)
 by OS3P286MB2742.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:1fe::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.17; Fri, 10 Jul
 2026 08:22:03 +0000
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32]) by TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32%5]) with mapi id 15.21.0181.009; Fri, 10 Jul 2026
 08:22:03 +0000
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
Subject: [PATCH v4 3/6] PCI: endpoint: Add API to delegate EPC DMA channels to the host
Date: Fri, 10 Jul 2026 17:21:53 +0900
Message-ID: <20260710082156.2395844-4-den@valinux.co.jp>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260710082156.2395844-1-den@valinux.co.jp>
References: <20260710082156.2395844-1-den@valinux.co.jp>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCP286CA0040.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:29d::15) To TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:38f::10)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY7P286MB7722:EE_|OS3P286MB2742:EE_
X-MS-Office365-Filtering-Correlation-Id: ad60de98-8d7e-446f-e006-08dede5c525f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|1800799024|10070799003|23010399003|366016|3023799007|56012099006|6133799003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	z2PxdV7Eh0HeovQ1B2zz/NmXXc0LfdtJbKcxbgbfnsoDvx8mvk6wAA1zqnaSNhtjWfRKh/EgWMBVZQcuzBdPuvKTS9c/W4eJLxj6iORq978GInfE5qU3tir6Q4DOOQnmtR2VNv9xjSJXz2OFRUA5BqxZdXUGO3WDOtR0IbgGAyjAf3EgIgSNd7D8Cxzvm7REm3Fy4HSIHrzlu2104PwOY9TCVKzdYv8igxxnQJ3+WFQQNHszA+QVZhOJxyXoGAecAgMySLvJdeCPLFFcNecbNjJ6bwIVeJ4ibW8/vyzg9R1RrL9FjtqKSuqThBhwXR9ch8/zTNNI9aMlncI3O3Fb9ZzpTSqXdYuu5f5lYIWPnVD3Tj+k7WPWkFH5y+4qh/KUmBle6FsbPT+LvF5Ib+npoEI2mvsMVOrrtTiQUpjAC+x19e51hZk2hQ0v1PfSS34AH1bnHmQhWMK61Ualace5bkh+/9tsS95HvuVuyTOUXMkTbacVionZNOq0iO+wTC4oxdX96DPgxtLqFTakPweYCJaj2vrEJTfImhk3iMsNiYFpEELAk4TrrEGXgsrSiNBrH1gL/lP4hWvUQmohLXb2DjyIogVZy1ZJivUMbpRxuAbNIRUEU8UuD0y8KYtHnjfMw0zZQ8KdgFw+hnhdtk22Pj9/2r0rvVUEiSIp+FTbzZo=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(10070799003)(23010399003)(366016)(3023799007)(56012099006)(6133799003)(22082099003)(18002099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?uCZfY4Lj+nXt74b58Of9IQHP4rcyaudYGcEKUfMMR6uqcCExddQ/PD/nVzcG?=
 =?us-ascii?Q?JEU5ejoHNGJjLcVfhjfpNYLka8mfv2mBQF414szum8jxH9zd82Q0KGb+u/H1?=
 =?us-ascii?Q?KZEsMgpzAHaerdi39lyJCTmoNl4WcoAI2lS9rvteATjaiy1Kr90ZWSkFLX2p?=
 =?us-ascii?Q?F45RlM7iKF9SwcMQQ8O8O0QafG7zMyVDhbAcoEn+iTJnieU5TvAgYOD8IK7a?=
 =?us-ascii?Q?jiBOBvt/SnniPHZZuCgj+yClzLIGfuaPXWXEoVok9fkeYj1NstedQfqyX2w1?=
 =?us-ascii?Q?R5mY6hzFyRvbgRcQMYtFEhvt0Q05LMjJsNlLmiXRqKwqwlJUZNCOVSizBwMk?=
 =?us-ascii?Q?duOUkqKzNt6qmVntr76sXdrb3cMkR1cidlsbdtXcw00Sbt5d+yFgfJhekUhf?=
 =?us-ascii?Q?kRTjdV1Lrsny5F71r6Y6jEOOwbLhKaZ9bK8F45uNsPbbGth4x0FJrxaPrnJt?=
 =?us-ascii?Q?uPFOApH9Ia6pkg+T1VLM+FTBgiytLiyE6SUqIzca3ezkS9iCsq/QSQONnSEF?=
 =?us-ascii?Q?iUcdaQdEr7NW8o2EXFdsPRNp9frY42/62FBNrZ0OPnEEPIPpgZQgW9pmRYaI?=
 =?us-ascii?Q?OohZfR8ZC0+twxs42h+JUZRY29ShUO+H7yHlfWigUPjcaXhW3kPOR5XH3gbJ?=
 =?us-ascii?Q?+REmjaDrw8/pQ/5znTLHn30Qy1U4GsMxHXSR+utabhaS3HZrjnZsg6At0oyD?=
 =?us-ascii?Q?SZrUM8gX0rXvj+3zqXdnjS3VLEYcszbanQC0Vju+HCLJ4TdUpU++fHVoxIdz?=
 =?us-ascii?Q?QKI9DQzPuXDzj8GNjAPq0pES2z7aARYcQPd7KaXmlZZjW3SMOvHSiMec8cvr?=
 =?us-ascii?Q?UPUnOvYKbWPXxGiOHIpEmcAH3KAknOsGLTjm11q1TKocxwQM1AkMCjOyBklv?=
 =?us-ascii?Q?BMc87YbK3Ru7l29eKY0XMewyUYiOCx+H0Xi3X6mu+Q+/Gt4yg0wfXiXfTcDb?=
 =?us-ascii?Q?noozycW86UTTDGSASt4rV96ucK95rd6vIj+ndNupbVmYFZxka+uyrcGomjF1?=
 =?us-ascii?Q?PV2rXsz4uBoXXKmdss6Hfx/Rk9pnzrcvyy7ZW3fJOyYcxM88Du/nwNmc0AbG?=
 =?us-ascii?Q?AlFtzVNTvcmz7815Is7eEiOAXvwdZDQR6RGFVF/kDWqiZz4CGznC+VpAtDfn?=
 =?us-ascii?Q?ghWQJO3Y5pYrVk60WSStsQ1aGUTB0tWUBfJkXCTlEKtjrP2dWR69mULQP1+l?=
 =?us-ascii?Q?rpwINC+PedTR8yhR3FSOmoS7eVd+I7N7HxjtALDqQaDBuXdwV3rmTUHS+cwQ?=
 =?us-ascii?Q?wLdRAhk3Fj0hx0PubLMJRYv71GEzoSMGpwMHBSjLscT2uxht9eovXy+YFGSb?=
 =?us-ascii?Q?XlkrZdd1Zo5mN4Dd8fRkQgrEXWiRemIaozSME1ayMjdKhWefZqXcyuUp6a4v?=
 =?us-ascii?Q?ATvCte0s1BZDFp2R3w6/DcddcfbJq29+WYh+X5b4opi7cRM8wqAVDl8Oe0sO?=
 =?us-ascii?Q?wi2S3ymlJtzmYPCU3Kvys3Tn+Qbg/kdZ42uuxYKig8fyevKzFrYMiQEer5pe?=
 =?us-ascii?Q?Frd92BJo6iQZ2y6aBTMPOW/hPWab7exBjwT9bQIJoyv6hzOJVAaInICeEGqY?=
 =?us-ascii?Q?oRjP5azUf49THlFV4HwDKGR0qGVsyr6Z7+iXEwVcC/ofTH0FUoYlAWyDELag?=
 =?us-ascii?Q?+HUPwEOyU9B1LiZZ6bkKyD5vBrvqePtjrMuLeGPq/V1KWJ36WqRe+Lwl4cqZ?=
 =?us-ascii?Q?Tswr5J9DrAKinxefzxjhmk+Dr6kYOWPZKkj5rLhBQkjOBnHdYlTBrh9anDCG?=
 =?us-ascii?Q?o0WKo3VmVSLna85rjuxI/sEwgLD7lxab5it3CLpztjf0K41dXqFB?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: ad60de98-8d7e-446f-e006-08dede5c525f
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2026 08:22:03.4118
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VifGAOMpfrBsFeHNePuGUuHDN8C2Iam8bUGKADurRTzM3KsazFU+w6jJuS8EfsSKvqLY3IoZPsFAd//BQe8rfg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS3P286MB2742
X-Rspamd-Action: no action
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[valinux.co.jp,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[valinux.co.jp:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-12299-lists,dmaengine=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[dmaengine,renesas];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,valinux.co.jp:from_mime,valinux.co.jp:email,valinux.co.jp:mid,valinux.co.jp:dkim,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 3AD5D73866F

Some endpoint functions expose an EPC-integrated DMA controller to the
host. The endpoint function should not need to know the backend-specific
mechanism used to reserve a channel locally and hand its programming
interface to the host.

Add pci_epc_delegate_dma_chan() and pci_epc_reclaim_dma_chan().
Add matching EPC operations. The public API returns an opaque handle, while
the EPC backend keeps any private channel state. This lets generic endpoint
functions delegate channels without depending on a specific DMAengine
provider.

Let reclaim callers tell the backend whether the channel may have been
exposed to host programming and therefore needs to be quiesced before local
ownership is restored. Bind failure paths that only unwind local
reservations can skip that backend quiesce step.

Signed-off-by: Koichiro Den <den@valinux.co.jp>
---
Changes in v4:
  - Move pci_epc_function_is_valid() upwards to avoid potential
    dereference of error pointer. (Sashiko)

 drivers/pci/endpoint/pci-epc-core.c | 102 ++++++++++++++++++++++++++++
 include/linux/pci-epc.h             |  15 ++++
 2 files changed, 117 insertions(+)

diff --git a/drivers/pci/endpoint/pci-epc-core.c b/drivers/pci/endpoint/pci-epc-core.c
index 831b40458dcd..9c908051aa23 100644
--- a/drivers/pci/endpoint/pci-epc-core.c
+++ b/drivers/pci/endpoint/pci-epc-core.c
@@ -18,6 +18,13 @@ static const struct class pci_epc_class = {
 	.name = "pci_epc",
 };
 
+struct pci_epc_dma_chan {
+	struct pci_epc *epc;
+	u8 func_no;
+	u8 vfunc_no;
+	void *data;
+};
+
 static void devm_pci_epc_release(struct device *dev, void *res)
 {
 	struct pci_epc *epc = *(struct pci_epc **)res;
@@ -236,6 +243,101 @@ int pci_epc_get_aux_resources(struct pci_epc *epc, u8 func_no, u8 vfunc_no,
 }
 EXPORT_SYMBOL_GPL(pci_epc_get_aux_resources);
 
+/**
+ * pci_epc_delegate_dma_chan() - delegate an EPC-owned DMA channel to the host
+ * @epc: EPC device
+ * @func_no: function number
+ * @vfunc_no: virtual function number
+ * @dir: DMA channel direction relative to the endpoint
+ * @hw_ch: hardware channel number
+ * @chan: output delegated-channel handle
+ *
+ * Some EPC backends integrate DMA channels that can be exposed to the host.
+ * This helper asks the backend to reserve the specified channel locally and
+ * place it in a state where the host driver may program it through the exposed
+ * register window.
+ *
+ * Return: 0 on success, -EOPNOTSUPP if the backend does not support DMA channel
+ * delegation, or another -errno on failure.
+ */
+int pci_epc_delegate_dma_chan(struct pci_epc *epc, u8 func_no, u8 vfunc_no,
+			      enum pci_epc_aux_dma_dir dir, u16 hw_ch,
+			      struct pci_epc_dma_chan **chan)
+{
+	struct pci_epc_dma_chan *epc_chan;
+	void *data = NULL;
+	int ret;
+
+	if (!pci_epc_function_is_valid(epc, func_no, vfunc_no))
+		return -EINVAL;
+
+	if (!chan)
+		return -EINVAL;
+	*chan = NULL;
+
+	if (dir != PCI_EPC_AUX_DMA_EP_TO_RC &&
+	    dir != PCI_EPC_AUX_DMA_RC_TO_EP)
+		return -EINVAL;
+
+	if (!epc->ops->delegate_dma_chan || !epc->ops->reclaim_dma_chan)
+		return -EOPNOTSUPP;
+
+	epc_chan = kzalloc_obj(*epc_chan, GFP_KERNEL);
+	if (!epc_chan)
+		return -ENOMEM;
+
+	mutex_lock(&epc->lock);
+	ret = epc->ops->delegate_dma_chan(epc, func_no, vfunc_no, dir, hw_ch,
+					  &data);
+	mutex_unlock(&epc->lock);
+	if (ret) {
+		kfree(epc_chan);
+		return ret;
+	}
+
+	epc_chan->epc = epc;
+	epc_chan->func_no = func_no;
+	epc_chan->vfunc_no = vfunc_no;
+	epc_chan->data = data;
+	*chan = epc_chan;
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(pci_epc_delegate_dma_chan);
+
+/**
+ * pci_epc_reclaim_dma_chan() - reclaim a delegated EPC-owned DMA channel
+ * @chan: delegated-channel handle returned by pci_epc_delegate_dma_chan()
+ * @quiesce: quiesce the channel before reclaiming it
+ *
+ * Reclaim a channel previously delegated to the host. Set @quiesce for channels
+ * that may have been exposed to host programming. Bind failure paths that are
+ * unwinding local reservations before exposure may leave it clear.
+ *
+ * Reclaim is best-effort by design: it runs on unbind and bind-failure paths
+ * that cannot act on a failed quiesce, so no error is reported and the handle
+ * is released regardless. The backend must leave a channel it failed to
+ * quiesce unusable rather than hand it back live.
+ */
+void pci_epc_reclaim_dma_chan(struct pci_epc_dma_chan *chan, bool quiesce)
+{
+	struct pci_epc *epc;
+
+	if (!chan)
+		return;
+
+	epc = chan->epc;
+	if (epc && epc->ops && epc->ops->reclaim_dma_chan) {
+		mutex_lock(&epc->lock);
+		epc->ops->reclaim_dma_chan(epc, chan->func_no, chan->vfunc_no,
+					    chan->data, quiesce);
+		mutex_unlock(&epc->lock);
+	}
+
+	kfree(chan);
+}
+EXPORT_SYMBOL_GPL(pci_epc_reclaim_dma_chan);
+
 /**
  * pci_epc_stop() - stop the PCI link
  * @epc: the link of the EPC device that has to be stopped
diff --git a/include/linux/pci-epc.h b/include/linux/pci-epc.h
index 8c89cb6d6733..84b37d7eb124 100644
--- a/include/linux/pci-epc.h
+++ b/include/linux/pci-epc.h
@@ -11,7 +11,9 @@
 
 #include <linux/pci-epf.h>
 
+struct device;
 struct pci_epc;
+struct pci_epc_dma_chan;
 
 enum pci_epc_interface_type {
 	UNKNOWN_INTERFACE = -1,
@@ -174,6 +176,10 @@ struct pci_epc_aux_resource {
  * @get_aux_resources_count: ops to get the number of controller-owned
  *                           auxiliary resources
  * @get_aux_resources: ops to retrieve controller-owned auxiliary resources
+ * @delegate_dma_chan: ops to delegate a controller-owned DMA channel to the
+ *                     host
+ * @reclaim_dma_chan: ops to reclaim a previously delegated DMA channel.
+ *		      The callback quiesces the channel when requested.
  * @owner: the module owner containing the ops
  */
 struct pci_epc_ops {
@@ -210,6 +216,11 @@ struct pci_epc_ops {
 	int	(*get_aux_resources)(struct pci_epc *epc, u8 func_no, u8 vfunc_no,
 				     struct pci_epc_aux_resource *resources,
 				     int num_resources);
+	int	(*delegate_dma_chan)(struct pci_epc *epc, u8 func_no, u8 vfunc_no,
+				     enum pci_epc_aux_dma_dir dir, u16 hw_ch,
+				     void **data);
+	void	(*reclaim_dma_chan)(struct pci_epc *epc, u8 func_no, u8 vfunc_no,
+				    void *data, bool quiesce);
 	struct module *owner;
 };
 
@@ -443,6 +454,10 @@ int pci_epc_get_aux_resources_count(struct pci_epc *epc, u8 func_no,
 int pci_epc_get_aux_resources(struct pci_epc *epc, u8 func_no, u8 vfunc_no,
 			      struct pci_epc_aux_resource *resources,
 			      int num_resources);
+int pci_epc_delegate_dma_chan(struct pci_epc *epc, u8 func_no, u8 vfunc_no,
+			      enum pci_epc_aux_dma_dir dir, u16 hw_ch,
+			      struct pci_epc_dma_chan **chan);
+void pci_epc_reclaim_dma_chan(struct pci_epc_dma_chan *chan, bool quiesce);
 enum pci_barno
 pci_epc_get_first_free_bar(const struct pci_epc_features *epc_features);
 enum pci_barno pci_epc_get_next_free_bar(const struct pci_epc_features
-- 
2.51.0


