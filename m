Return-Path: <dmaengine+bounces-9404-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yNQkNIXvsmnAQwAAu9opvQ
	(envelope-from <dmaengine+bounces-9404-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Thu, 12 Mar 2026 17:53:25 +0100
X-Original-To: lists+dmaengine@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 890C6275FF9
	for <lists+dmaengine@lfdr.de>; Thu, 12 Mar 2026 17:53:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 838983048DB1
	for <lists+dmaengine@lfdr.de>; Thu, 12 Mar 2026 16:51:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8D623FE356;
	Thu, 12 Mar 2026 16:50:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="GZyKYQp/"
X-Original-To: dmaengine@vger.kernel.org
Received: from OS0P286CU010.outbound.protection.outlook.com (mail-japanwestazon11021104.outbound.protection.outlook.com [40.107.74.104])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D11F83FB7DE;
	Thu, 12 Mar 2026 16:50:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.74.104
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773334246; cv=fail; b=Q9p5wKsFBCmOIFspM1IZT0dErUFG9FUFGzjvDRscCke9ol4266f9EEL1wOF0ED6fgowCA3sh+UhSrkvuhreomHo/gyBkMvbmr/ODx3+VLBZpJ0+dhLUePrX7LKp1ufgC+szq9vJDeU6+lL1jWyVwicxFbD31RWsMipHp9cesYqQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773334246; c=relaxed/simple;
	bh=MfgKUnhKAhij3bf9VvUQDV1DP2ghHVwM67BT8ZZgPqA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=RueV7+0gvRVJPQMIDvi5/A8NLB6fvHumjYQnWrmNV7eZ/XwBljJK278EmTA53WIvw7J9EXslnagT4eQwieM/uZUXptVxfau4PFkKRYMjoygZjfBrDs4jcKBgrFF+jxU9fmtzbJwW+tMBQdHpzrDWXLGHVBDLFsNJz5dCYaDx/zU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=GZyKYQp/; arc=fail smtp.client-ip=40.107.74.104
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cSy5kaDAKU2CENDfjctGn1tF8Al1JUT0vhzmYBUHOfwsobfOCra2AqDBkPuUvyHoq8Lu9XlIisUv4haaKvE4XH7lpcYTOYMfuvUFkdwLCTuTB3BlRedbpfCYCWf7FoVJ8rKFsKVsC7/ZngZsxFaX9e1Y+K8gMt2qis1jb68Zr+dVA0vIJoxJ67PrJAXr/LHmIqgaJ+IuDPtOTsjBpp4FFy+S+fs6v0CiV5QOqRy8zg3GtciQK6iIsyr3oNf4DJXwm3z8/Qg3vkbczcGD3GRy7q5eEGSPWMq0OWY7qE2zSypqsfyL25pBSY789lV5UTbX7q680FKWvZbC03N4dWTOsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=coU7bZmah5cDst9h6g7t/DM1ZSTJkeH+plLzjIHrbgQ=;
 b=UtfnMgt9ZCbCVgbEmOsI/CgZlpXWRPaXNSx9fsHB+2j96J3ViVC64D+ctcLTu28Ps5YEFMJoW0PoTWR/4aejpzfoplwZBty6OSTQfg5FHL3OglzcGcbVvt6DeLptMtXFSxOz6EWov0WSVhIS3MxgYa6a/1vX+qdfBIp5Rk3ZPCFFwppAGxCVHwK06APdq3MsJR8dsC1hf5rjiGQITVegZa5Y/qll1pwbx3zllw0LeJTA8Hij6bvNTarrfSq8Dr0mwr+5IvX9Rvmeo05OofMdW4+6u9NoPjVq88CxwGf9chrOcJ3pkZCaC8zwVsrm6ADTyf5W4/gF4pDrz6WOy8zcmg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=coU7bZmah5cDst9h6g7t/DM1ZSTJkeH+plLzjIHrbgQ=;
 b=GZyKYQp/1OWPvd3M3EQwNPkk9BEqiE9Iw0jaRQVWTBVsXKRYQl3TFsZDUw8dJ/Jf7ZzersLOIWgpGD1ngC76R/g+b4bgzSmC2NXK0MRM691Bi80osUwZNgQtFzeS2XRcmte63loIrV/J8ScpqS+E0ylYDKn78XnNKczpSnauAZY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:38f::10)
 by TYCP286MB2018.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:15e::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.15; Thu, 12 Mar
 2026 16:50:18 +0000
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32]) by TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32%5]) with mapi id 15.20.9700.013; Thu, 12 Mar 2026
 16:50:18 +0000
From: Koichiro Den <den@valinux.co.jp>
To: Manivannan Sadhasivam <mani@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Vinod Koul <vkoul@kernel.org>,
	Frank Li <Frank.Li@kernel.org>,
	Jon Mason <jdmason@kudzu.us>,
	Dave Jiang <dave.jiang@intel.com>,
	Allen Hubbe <allenbh@gmail.com>,
	Jingoo Han <jingoohan1@gmail.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Baruch Siach <baruch@tkos.co.il>,
	Jerome Brunet <jbrunet@baylibre.com>,
	Niklas Cassel <cassel@kernel.org>
Cc: linux-pci@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	dmaengine@vger.kernel.org,
	ntb@lists.linux.dev
Subject: [PATCH 09/15] PCI: endpoint: Add pci-ep-dma helper for exported DMA ABI v1
Date: Fri, 13 Mar 2026 01:49:59 +0900
Message-ID: <20260312165005.1148676-10-den@valinux.co.jp>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260312165005.1148676-1-den@valinux.co.jp>
References: <20260312165005.1148676-1-den@valinux.co.jp>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCP286CA0105.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:2b4::15) To TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:38f::10)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY7P286MB7722:EE_|TYCP286MB2018:EE_
X-MS-Office365-Filtering-Correlation-Id: cd0678ac-051d-457e-282f-08de80577162
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|10070799003|366016|7416014|921020|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	vAbkM90zmcVR+ItJS7/A+t6UNcOmb9uD0A4PnH9PV1xiEIUtUe86LeaFkYJ4HXyUresoVkjkQtCpuHjyu4eCG+6OAh2cnlfaF/cNid2oQehullCc9FktzDlP5yvy2wxgYdDBXpQu/J3A+RsyWeNvhTQ+Unaj0cKJ3xQjeFCU/RtmpmHJVsWbOTILPycoam7xpJwxMWQXgPHR4WxZ9pw9MZwWYyQfkX6dEm+Y+jGMBoL/YzZSzualL8bKxi4N5eIKb6DQyoPdqwVCDaK8t+zbU/DQJI5+R/tz5zxYg0GkaweRRtVQEpQ14A8QqaFmvairH61S0gWTMGi5GNZHtXnv/ZGq4ke5BmDqDsJgHXgNuy0IaSaoZ9S+NRWytUHv+T1XOZbLoWNInL6X/nc93zy7X+OZAFpvcU2F0HlrwUV+zD54xs9QvzI+TAhHkyRx9HuC29w7K2GXs1Kk64Sp9fUDCAnVfaFRVKSfLOILefMVs4Bl+95GV56GbGrNzAiJf9NkV8EWKAO5RtE629XMuhxYbo0QjbvK5Wde5Vpzt61Ky+bJnOQrQIvR94IPX22c8/ZQCMlwg9kIMk7R3A9IKOPGK8LIEUrovGsghWli9z3VWiaM1TOBFyJJP8jbFNUQL5rMfV6NotFKSwFYJ/GIZjfrWPQa1g/neFb6gl7EZJBDr5AldEkQw3BZ7s6r1WO6doS2sKgy2F+sAUS+pG6sqXJyuGI0YjoPre3ub9sH4jBKcj8AFtWIVtipQ5IXlE97qI2SaHmd7xh4P7pXq5KpyTS+HA==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(10070799003)(366016)(7416014)(921020)(56012099003)(22082099003)(18002099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?bFWCm+U6kQE4r8SgX66Gl6sYKGiRk3SlsEEpKHy8ZgSYVuCNyCRDFAZASA2W?=
 =?us-ascii?Q?Z66aO4UYtsBSSDlAD3qQhgzS9E8745TA4bB21ChFYjVGNFp1UnacicWMlYgD?=
 =?us-ascii?Q?HtjLCTlThDijX3i9ZYuxIG3QuivjACLxbk+zEReMER+GB1mTFN8x96arT98+?=
 =?us-ascii?Q?6EZA2CReHtg3oFZzrO8j71lGs8731s7xMJANeflsa6QMmpsNJXDv3KjvjB4z?=
 =?us-ascii?Q?bFQwqmgR7dFVa+9zna8B35bSx/rBN/5QBEGm/CoeSr9YPCvxRVy/YGD0QEWz?=
 =?us-ascii?Q?4OW+bvotd11yECw1D62x6vCR30sfCfaI9tjcskUpDQ3M6pMCXLYFd8tSZFim?=
 =?us-ascii?Q?RiW1u/iFt+Xgd2NncVWxC5Ygk1yGT6fr+XLHK+bqy8kVbSMGn5PO9pL+fZ70?=
 =?us-ascii?Q?N8357KFz471Lrr4IkKz5wGV1cf3cX+1U1gCEvPQERBBbYpAvdH3ZlJzKuWUY?=
 =?us-ascii?Q?6gE0qTXqptMu2e2NTf1SL9a3OCGuEweN2rE/rTVaq1YxGSBR3dX1B+7CBy6y?=
 =?us-ascii?Q?yTy4q8hgyaHxLCoxXztheVUMlJ671wxy7kCow0IQ21pxa1Rlp7qh5MUJLO17?=
 =?us-ascii?Q?u/Uv+ixAPKNVDWPwwAeemuv7ktBoThz0+isN2XW+ipyGfnLIQ5XCb1FUXu4z?=
 =?us-ascii?Q?lyNAlDapRmXJWE0DoaT7nPyx7IWEeTW8deZbyB/HxOKyJMgeW9vvrbdAjdC9?=
 =?us-ascii?Q?ZHmkEWsRhd9/oBP7TqxKX0Il4MDgiV9v/kZc7+rc3jfO/t+Ap4WxrHB3cZVN?=
 =?us-ascii?Q?ooIhBKyKoDFLgW950j4+8nqzriNjYgvdn2oLDPOxCamNaW44cggH/toGUAPv?=
 =?us-ascii?Q?hX8k7fDEvqGOoSYxqOd0ReVskTkiDX33v2tiPeTQK4XusYc7Wzz0Yk/A7utd?=
 =?us-ascii?Q?kvva6xvg1DMC2q8Kff4WxChMclAzzlLr1pDwzDPSlOm553MFDGN1eQDSNT6l?=
 =?us-ascii?Q?1rd+HLYThASDo7Kh6RqywylmMw354LLfh5DMBBX4UcXa/Ve2DX52K5dTVD7R?=
 =?us-ascii?Q?pBkphB6n2KchfgwHcj/O5OeTr+V453TqEeuHmFHk6cdrZnqzbpcp1WG2JZ0Y?=
 =?us-ascii?Q?GtIL4rlNYyhvm4/5EcO2SurV6kf337ywYRT08qtJbSR7KC+e7Gm2qPkx/U6H?=
 =?us-ascii?Q?VjsphO8uEdY5ZzvdWuDc6w5MB7Ri+tszK22BffFTOvAM1FKxEQw+h3O+ZuCV?=
 =?us-ascii?Q?663qcZFKPR/Sgs10zoRsu5MMwY1GsTq6ENx0cqanDk4GyQT1qK9mZnWnCIl9?=
 =?us-ascii?Q?OOjxe8VjTbB/3L6O6yHFkiK1ONElxL/ooKOmPoBTwEMuJ+6/GNUYo1RGjOUV?=
 =?us-ascii?Q?GuvkgZ31qo8Qy0ju2M2Od5E16N0sbv6zf5vCt+U325PA4RcN8mFDTVhcLpfT?=
 =?us-ascii?Q?1JuYcJK/ZMXH79H9f3+J4VgetI0XZjG1ayDnKVeVBOanJDRMM9/A5yYo+stx?=
 =?us-ascii?Q?QR5hTtDCqtWEDFtLwTEw3P1E+syO+ss61/gv8laxj7vDXvd9sid7sMKxAP5e?=
 =?us-ascii?Q?7bCP10kAiiebG4DUA/4DTJv7c7+IIXQdyEGYiC/ka5wqJvhSbAFB6CxajIhT?=
 =?us-ascii?Q?g9VjiogMGMuNT6v99834SlGJykK9lnbfQIXrZ8gRBr5hbzG1GBRRxwVxWEfl?=
 =?us-ascii?Q?53NI/5WFe3XYO5/53RlWGi6+0b8yqS0jKjhC2ThQKLNbSSffRdnUr67dfi9n?=
 =?us-ascii?Q?5edYKJTHu+XUatWZO6ly+X+qgEcCG4rDXddR6wFZntBhVNA/oZKzwx1WaqcO?=
 =?us-ascii?Q?+4bo/iEmja/VB7pbo7zqjF2/MC6cI/Rb3bv8TtpxebBr/3SkLBY3?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: cd0678ac-051d-457e-282f-08de80577162
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Mar 2026 16:50:18.6447
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: l020wbQ7KPNLKCWlNCj/Fgyp14iOMTYSX5h+7TVCoGHnBTnpfRVjrzw9342Uw7i6QHJN79Yk8TMMc7Pfh3zX5Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCP286MB2018
X-Spamd-Result: default: False [1.34 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[valinux.co.jp,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[valinux.co.jp:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[22];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-9404-lists,dmaengine=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[kernel.org,google.com,lwn.net,linuxfoundation.org,kudzu.us,intel.com,gmail.com,tkos.co.il,baylibre.com];
	DKIM_TRACE(0.00)[valinux.co.jp:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[den@valinux.co.jp,dmaengine@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[dmaengine];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 890C6275FF9
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Add a generic helper that packages controller-owned DMA resources into a
peer-visible BAR slice described by exported DMA ABI v1.

pci_epf_alloc_dma() queries EPC auxiliary resources, delegates the
requested DMA read channels, builds an ABI header in coherent memory,
and assembles the BAR region list covering the header, controller
register window, and per-channel descriptor windows. If the controller
control window is not already BAR-backed, map it into the exported slice
so the peer still sees a self-contained layout.

The first ABI is designed based on the DesignWare unrolled eDMA model,
but it is intended to be vendor-neutral. It exports delegated READ
channels only, which are the channels the host uses to send data from
host memory into the endpoint.

Signed-off-by: Koichiro Den <den@valinux.co.jp>
---
 drivers/pci/endpoint/Makefile     |   2 +-
 drivers/pci/endpoint/pci-ep-dma.c | 342 ++++++++++++++++++++++++++++++
 include/linux/pci-ep-dma.h        | 130 ++++++++++++
 3 files changed, 473 insertions(+), 1 deletion(-)
 create mode 100644 drivers/pci/endpoint/pci-ep-dma.c
 create mode 100644 include/linux/pci-ep-dma.h

diff --git a/drivers/pci/endpoint/Makefile b/drivers/pci/endpoint/Makefile
index b4869d52053a..94824f3ed5a1 100644
--- a/drivers/pci/endpoint/Makefile
+++ b/drivers/pci/endpoint/Makefile
@@ -5,5 +5,5 @@
 
 obj-$(CONFIG_PCI_ENDPOINT_CONFIGFS)	+= pci-ep-cfs.o
 obj-$(CONFIG_PCI_ENDPOINT)		+= pci-epc-core.o pci-epf-core.o\
-					   pci-epc-mem.o functions/
+					   pci-epc-mem.o pci-ep-dma.o functions/
 obj-$(CONFIG_PCI_ENDPOINT_MSI_DOORBELL)	+= pci-ep-msi.o
diff --git a/drivers/pci/endpoint/pci-ep-dma.c b/drivers/pci/endpoint/pci-ep-dma.c
new file mode 100644
index 000000000000..2a996f9b1424
--- /dev/null
+++ b/drivers/pci/endpoint/pci-ep-dma.c
@@ -0,0 +1,342 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Generic exported DMA helper for PCI endpoint functions
+ */
+
+#include <linux/align.h>
+#include <linux/dma-mapping.h>
+#include <linux/err.h>
+#include <linux/kernel.h>
+#include <linux/pci-ep-dma.h>
+#include <linux/pci-epc.h>
+#include <linux/slab.h>
+
+static const struct pci_epc_aux_resource *
+pci_ep_dma_find_ctrl(const struct pci_epc_aux_resource *resources, int count)
+{
+	int i;
+
+	for (i = 0; i < count; i++)
+		if (resources[i].type == PCI_EPC_AUX_DMA_CTRL_MMIO)
+			return &resources[i];
+
+	return NULL;
+}
+
+static const struct pci_epc_aux_resource *
+pci_ep_dma_find_desc(const struct pci_epc_aux_resource *resources, int count,
+		     int chan_id)
+{
+	int i;
+
+	/*
+	 * ABI v1 exports delegated READ channels only. A remote client uses
+	 * those channels to pull host memory into the endpoint, so ignore WRITE
+	 * channel descriptors here.
+	 */
+	for (i = 0; i < count; i++) {
+		if (resources[i].type != PCI_EPC_AUX_DMA_CHAN_DESC)
+			continue;
+		if (resources[i].u.dma_chan.dir != PCI_EPC_AUX_DMA_DIR_READ)
+			continue;
+		if (resources[i].u.dma_chan.chan_id != chan_id)
+			continue;
+		return &resources[i];
+	}
+
+	return NULL;
+}
+
+static int pci_ep_dma_undelegate_chans(struct pci_epf *epf, const int *chan_ids,
+				       u32 num_chans)
+{
+	if (!num_chans)
+		return 0;
+
+	return pci_epc_undelegate_dma_channels(epf->epc, epf->func_no,
+					       epf->vfunc_no,
+					       PCI_EPC_AUX_DMA_DIR_READ,
+					       chan_ids, num_chans);
+}
+
+static int pci_ep_dma_map_resource(struct device *dev, phys_addr_t phys,
+				   size_t size, size_t align,
+				   dma_addr_t *dma_addr, size_t *map_size,
+				   u32 *map_delta)
+{
+	phys_addr_t base;
+	size_t map_align;
+
+	map_align = max_t(size_t, PAGE_SIZE, align);
+	base = ALIGN_DOWN(phys, map_align);
+	*map_delta = phys - base;
+	*map_size = ALIGN(size + *map_delta, map_align);
+	*dma_addr = dma_map_resource(dev, base, *map_size,
+				     DMA_BIDIRECTIONAL, 0);
+	if (dma_mapping_error(dev, *dma_addr))
+		return -ENOMEM;
+
+	return 0;
+}
+
+struct pci_ep_dma *pci_epf_alloc_dma(struct pci_epf *epf, enum pci_barno bar,
+				     u32 offset, u32 req_chans)
+{
+	const struct pci_epc_aux_resource *descs[PCI_EP_DMA_MAX_CHANS] = { };
+	const struct pci_epc_features *epc_features;
+	int chan_ids[PCI_EP_DMA_MAX_CHANS] = { 0 };
+	int kept_chan_ids[PCI_EP_DMA_MAX_CHANS] = { 0 };
+	int rejected_chan_ids[PCI_EP_DMA_MAX_CHANS] = { 0 };
+	const struct pci_epc_aux_resource *ctrl;
+	struct pci_epc_aux_resource *res = NULL;
+	struct pci_ep_dma_hdr_v1 *hdr;
+	size_t align, hdr_sz, cur;
+	unsigned int delegated_chans = 0;
+	unsigned int rejected_chans = 0;
+	unsigned int num_chans = 0;
+	struct pci_ep_dma *dma;
+	struct device *dma_dev;
+	struct pci_epc *epc;
+	int count, ret;
+	unsigned int i;
+
+	if (!epf || !epf->epc)
+		return ERR_PTR(-EINVAL);
+
+	epc = epf->epc;
+	epc_features = pci_epc_get_features(epc, epf->func_no, epf->vfunc_no);
+	if (!epc_features)
+		return ERR_PTR(-ENODEV);
+
+	count = pci_epc_get_aux_resources(epc, epf->func_no, epf->vfunc_no,
+					  NULL, 0);
+	if (count < 0)
+		return ERR_PTR(count);
+
+	res = kcalloc(count, sizeof(*res), GFP_KERNEL);
+	if (!res)
+		return ERR_PTR(-ENOMEM);
+
+	ret = pci_epc_get_aux_resources(epc, epf->func_no, epf->vfunc_no,
+					res, count);
+	if (ret < 0)
+		goto err_free_res;
+	count = ret;
+
+	ret = pci_epc_delegate_dma_channels(epc, epf->func_no, epf->vfunc_no,
+					    PCI_EPC_AUX_DMA_DIR_READ,
+					    max_t(u32, 1, req_chans),
+					    chan_ids,
+					    ARRAY_SIZE(chan_ids));
+	if (ret < 0)
+		goto err_free_res;
+	delegated_chans = ret;
+
+	ctrl = pci_ep_dma_find_ctrl(res, count);
+	if (!ctrl) {
+		ret = -ENODEV;
+		goto err_undelegate;
+	}
+
+	for (i = 0; i < delegated_chans; i++) {
+		const struct pci_epc_aux_resource *desc;
+
+		desc = pci_ep_dma_find_desc(res, count, chan_ids[i]);
+		if (!desc) {
+			rejected_chan_ids[rejected_chans++] = chan_ids[i];
+			continue;
+		}
+
+		descs[num_chans] = desc;
+		kept_chan_ids[num_chans++] = chan_ids[i];
+	}
+
+	ret = pci_ep_dma_undelegate_chans(epf, rejected_chan_ids, rejected_chans);
+	if (ret)
+		goto err_undelegate;
+	memcpy(chan_ids, kept_chan_ids, num_chans * sizeof(chan_ids[0]));
+	delegated_chans = num_chans;
+
+	if (!num_chans) {
+		ret = -ENODEV;
+		goto err_undelegate;
+	}
+
+	if (num_chans < req_chans)
+		dev_warn(&epf->dev,
+			 "requested %u DMA channels, delegating %u\n",
+			 req_chans, num_chans);
+
+	dma = kzalloc_obj(*dma);
+	if (!dma) {
+		ret = -ENOMEM;
+		goto err_undelegate;
+	}
+
+	dma_dev = epc->dev.parent;
+	align = epc_features->align ? epc_features->align : SZ_4K;
+	hdr_sz = ALIGN(sizeof(*hdr), align);
+
+	dma->hdr_virt = dma_alloc_coherent(dma_dev, hdr_sz, &dma->hdr_phys,
+					   GFP_KERNEL);
+	if (!dma->hdr_virt) {
+		ret = -ENOMEM;
+		goto err_free_dma;
+	}
+
+	dma->epf = epf;
+	dma->bar = bar;
+	dma->hdr_alloc_size = hdr_sz;
+	dma->num_chans = num_chans;
+	dma->delegated_num_chans = delegated_chans;
+	memcpy(dma->delegated_chan_ids, chan_ids,
+	       delegated_chans * sizeof(dma->delegated_chan_ids[0]));
+
+	cur = offset;
+	dma->regions[dma->num_regions++] = (struct pci_ep_dma_region) {
+		.offset = cur,
+		.phys_addr = dma->hdr_phys,
+		.size = hdr_sz,
+	};
+	cur += hdr_sz;
+
+	hdr = dma->hdr_virt;
+	memset(hdr, 0, sizeof(*hdr));
+	hdr->magic = cpu_to_le32(PCI_EP_DMA_MAGIC);
+	hdr->version = cpu_to_le16(1);
+	hdr->hdr_size = cpu_to_le16(sizeof(*hdr));
+
+	/*
+	 * If there is a fixed mapped DMA register block, reuse it. If the
+	 * controller only reports a raw physical MMIO resource, map it into
+	 * the exported slice so the peer still sees a self-contained BAR layout.
+	 */
+	if (ctrl->bar != NO_BAR) {
+		hdr->ctrl_bar = cpu_to_le32(ctrl->bar);
+		hdr->ctrl_offset = cpu_to_le32(ctrl->bar_offset);
+		hdr->ctrl_size = cpu_to_le32(ctrl->size);
+	} else {
+		size_t map_sz;
+		u32 map_delta;
+		dma_addr_t map_addr;
+
+		ret = pci_ep_dma_map_resource(dma_dev, ctrl->phys_addr, ctrl->size,
+					      align, &map_addr, &map_sz,
+					      &map_delta);
+		if (ret)
+			goto err_free_hdr;
+
+		dma->ctrl_map_addr = map_addr;
+		dma->ctrl_map_size = map_sz;
+		dma->regions[dma->num_regions++] = (struct pci_ep_dma_region) {
+			.offset = cur,
+			.phys_addr = map_addr,
+			.size = map_sz,
+		};
+		hdr->ctrl_bar = cpu_to_le32(bar);
+		hdr->ctrl_offset = cpu_to_le32(cur + map_delta);
+		hdr->ctrl_size = cpu_to_le32(ctrl->size);
+		cur += map_sz;
+	}
+
+	hdr->irq_count = cpu_to_le32(num_chans);
+	hdr->num_chans = cpu_to_le32(num_chans);
+	/*
+	 * Preserve the delegated-channel order in @hdr->chans[]. ABI v1 currently
+	 * assumes the exported READ channels form a dense prefix of the remote
+	 * hardware READ-channel space, so dw-edma-aux consumes @chans[i] as remote
+	 * READ channel i.
+	 */
+	for (i = 0; i < num_chans; i++) {
+		size_t desc_sz = ALIGN(descs[i]->size, align);
+
+		dma->regions[dma->num_regions++] = (struct pci_ep_dma_region) {
+			.offset = cur,
+			.phys_addr = descs[i]->phys_addr,
+			.size = desc_sz,
+		};
+		hdr->chans[i].desc_bar = cpu_to_le32(bar);
+		hdr->chans[i].desc_offset = cpu_to_le32(cur);
+		hdr->chans[i].desc_size = cpu_to_le32(descs[i]->size);
+		hdr->chans[i].desc_phys_addr =
+			cpu_to_le64(descs[i]->phys_addr);
+		cur += desc_sz;
+	}
+
+	hdr->total_size = cpu_to_le32(cur - offset);
+	dma->loc.abi = PCI_EP_DMA_ABI_V1;
+	dma->loc.bar = bar;
+	dma->loc.offset = offset;
+	dma->loc.size = cur - offset;
+
+	kfree(res);
+	return dma;
+
+err_free_hdr:
+	if (dma->ctrl_map_addr)
+		dma_unmap_resource(dma_dev, dma->ctrl_map_addr,
+				   dma->ctrl_map_size,
+				   DMA_BIDIRECTIONAL, 0);
+	if (dma->hdr_virt)
+		dma_free_coherent(dma_dev, dma->hdr_alloc_size,
+				  dma->hdr_virt, dma->hdr_phys);
+err_free_dma:
+	kfree(dma);
+err_undelegate:
+	{
+		int unret;
+
+		unret = pci_ep_dma_undelegate_chans(epf, chan_ids, delegated_chans);
+		if (unret)
+			dev_warn(&epf->dev,
+				 "failed to undelegate DMA channels: %d\n",
+				 unret);
+	}
+err_free_res:
+	kfree(res);
+	return ERR_PTR(ret);
+}
+EXPORT_SYMBOL_GPL(pci_epf_alloc_dma);
+
+void pci_epf_free_dma(struct pci_ep_dma *dma)
+{
+	struct device *dma_dev;
+	int ret;
+
+	if (!dma)
+		return;
+
+	dma_dev = dma->epf->epc->dev.parent;
+	ret = pci_ep_dma_undelegate_chans(dma->epf, dma->delegated_chan_ids,
+					  dma->delegated_num_chans);
+	if (ret)
+		dev_warn(&dma->epf->dev,
+			 "failed to undelegate DMA channels: %d\n", ret);
+	if (dma->ctrl_map_addr)
+		dma_unmap_resource(dma_dev, dma->ctrl_map_addr,
+				   dma->ctrl_map_size,
+				   DMA_BIDIRECTIONAL, 0);
+	if (dma->hdr_virt)
+		dma_free_coherent(dma_dev, dma->hdr_alloc_size,
+				  dma->hdr_virt, dma->hdr_phys);
+	kfree(dma);
+}
+EXPORT_SYMBOL_GPL(pci_epf_free_dma);
+
+const struct pci_ep_dma_locator *pci_epf_get_dma_locator(const struct pci_ep_dma *dma)
+{
+	return dma ? &dma->loc : NULL;
+}
+EXPORT_SYMBOL_GPL(pci_epf_get_dma_locator);
+
+unsigned int pci_epf_get_dma_region_count(const struct pci_ep_dma *dma)
+{
+	return dma ? dma->num_regions : 0;
+}
+EXPORT_SYMBOL_GPL(pci_epf_get_dma_region_count);
+
+const struct pci_ep_dma_region *pci_epf_get_dma_regions(const struct pci_ep_dma *dma)
+{
+	return dma ? dma->regions : NULL;
+}
+EXPORT_SYMBOL_GPL(pci_epf_get_dma_regions);
diff --git a/include/linux/pci-ep-dma.h b/include/linux/pci-ep-dma.h
new file mode 100644
index 000000000000..0ef6f9eb8593
--- /dev/null
+++ b/include/linux/pci-ep-dma.h
@@ -0,0 +1,130 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Generic exported DMA helper for PCI endpoint functions
+ */
+
+#ifndef __LINUX_PCI_EP_DMA_H
+#define __LINUX_PCI_EP_DMA_H
+
+#include <linux/dma-mapping.h>
+#include <linux/pci-epf.h>
+
+#define PCI_EP_DMA_MAGIC	0x4d445045 /* "EPDM" */
+#define PCI_EP_DMA_MAX_CHANS	8
+#define PCI_EP_DMA_MAX_REGIONS	(2 + PCI_EP_DMA_MAX_CHANS)
+
+enum pci_ep_dma_abi {
+	PCI_EP_DMA_ABI_NONE = 0,
+	PCI_EP_DMA_ABI_V1 = 1,
+};
+
+/**
+ * struct pci_ep_dma_locator - peer-visible location of an exported DMA slice
+ * @abi: exported-DMA ABI identifier from &enum pci_ep_dma_abi
+ * @bar: BAR number that carries the exported slice
+ * @flags: ABI-specific locator flags, reserved for future use in v1
+ * @offset: BAR-relative start offset of the exported slice
+ * @size: total size of the exported slice in bytes
+ */
+struct pci_ep_dma_locator {
+	u8 abi;
+	u8 bar;
+	u16 flags;
+	u32 offset;
+	u32 size;
+};
+
+/**
+ * struct pci_ep_dma_region - one physical region mapped into the exported slice
+ * @offset: BAR-relative start offset of the region within the exported slice
+ * @phys_addr: DMA address to program into the EPC BAR mapping
+ * @size: mapped size in bytes
+ */
+struct pci_ep_dma_region {
+	u32 offset;
+	dma_addr_t phys_addr;
+	size_t size;
+};
+
+/**
+ * struct pci_ep_dma_chan_info - per-channel descriptor metadata in ABI v1
+ * @desc_bar: BAR number that exposes the descriptor window
+ * @desc_offset: BAR-relative start offset of the descriptor window
+ * @desc_size: descriptor window size in bytes
+ * @desc_phys_addr: physical/DMA address used for the EPC-side BAR mapping
+ */
+struct pci_ep_dma_chan_info {
+	__le32 desc_bar;
+	__le32 desc_offset;
+	__le32 desc_size;
+	__le64 desc_phys_addr;
+};
+
+/**
+ * struct pci_ep_dma_hdr_v1 - exported DMA header format, version 1
+ * @magic: fixed signature, must be %PCI_EP_DMA_MAGIC
+ * @version: header version, must be 1 for this structure
+ * @hdr_size: size of the populated header structure in bytes
+ * @total_size: total exported-slice size starting at &struct pci_ep_dma_locator.offset
+ * @ctrl_bar: BAR that exposes the live DMA control registers
+ * @ctrl_offset: BAR-relative start offset of the control-register window
+ * @ctrl_size: size of the control-register window in bytes
+ * @irq_count: number of IRQ vectors reserved for the exported DMA provider
+ * @num_chans: number of valid entries in @chans
+ * @chans: per-channel descriptor metadata
+ *
+ * Exported DMA ABI v1 lays out the peer-visible slice as:
+ *
+ *   [header][controller window?][descriptor window 0]...[descriptor window N]
+ *
+ * The controller window is optional in that slice. When the live register
+ * block is already exposed through another BAR, @ctrl_bar/@ctrl_offset point at
+ * that BAR directly and no controller subrange is embedded in the exported
+ * slice.
+ *
+ * @chans[] describes a dense prefix of the remote hardware READ-channel
+ * space, ordered by remote hardware READ-channel index starting at 0. A
+ * consumer may map @chans[i] directly to remote READ channel i.
+ */
+struct pci_ep_dma_hdr_v1 {
+	__le32 magic;
+	__le16 version;
+	__le16 hdr_size;
+	__le32 total_size;
+	__le32 ctrl_bar;
+	__le32 ctrl_offset;
+	__le32 ctrl_size;
+	__le32 irq_count;
+	__le32 num_chans;
+	struct pci_ep_dma_chan_info chans[PCI_EP_DMA_MAX_CHANS];
+};
+
+struct pci_ep_dma {
+	struct pci_epf *epf;
+	enum pci_barno bar;
+	void *hdr_virt;
+	dma_addr_t hdr_phys;
+	size_t hdr_alloc_size;
+	struct pci_ep_dma_locator loc;
+	unsigned int num_regions;
+	u32 num_chans;
+	struct pci_ep_dma_region regions[PCI_EP_DMA_MAX_REGIONS];
+	dma_addr_t ctrl_map_addr;
+	size_t ctrl_map_size;
+	int delegated_chan_ids[PCI_EP_DMA_MAX_CHANS];
+	u8 delegated_num_chans;
+};
+
+struct pci_ep_dma *pci_epf_alloc_dma(struct pci_epf *epf, enum pci_barno bar,
+				     u32 offset, u32 req_chans);
+void pci_epf_free_dma(struct pci_ep_dma *dma);
+
+const struct pci_ep_dma_locator *
+pci_epf_get_dma_locator(const struct pci_ep_dma *dma);
+
+unsigned int pci_epf_get_dma_region_count(const struct pci_ep_dma *dma);
+
+const struct pci_ep_dma_region *
+pci_epf_get_dma_regions(const struct pci_ep_dma *dma);
+
+#endif /* __LINUX_PCI_EP_DMA_H */
-- 
2.51.0


