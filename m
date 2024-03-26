Return-Path: <dmaengine+bounces-1486-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AAA7C88B70F
	for <lists+dmaengine@lfdr.de>; Tue, 26 Mar 2024 02:47:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CE2C61C342DF
	for <lists+dmaengine@lfdr.de>; Tue, 26 Mar 2024 01:47:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEFC25732C;
	Tue, 26 Mar 2024 01:47:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="UVv1UjJd"
X-Original-To: dmaengine@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12olkn2067.outbound.protection.outlook.com [40.92.22.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 161524E1A2;
	Tue, 26 Mar 2024 01:47:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.22.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711417635; cv=fail; b=eaCLzUStYyfzaofrkZGIVAlvUxxcT07FTa95S0DerogpnrHdP3BVmEb1myip0kP5RfCmtH3lR0WbC1toLVolAoAS3OX5OXIXZ23G732eB5k1bpfHGPerwEAk78bZcQvg21b7m4z0iQTENlpbTeoMnXsNiBY+wbqltUyEsHLAHRo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711417635; c=relaxed/simple;
	bh=8JgoSjCMgT+4YWgPAd3BpnSD8PgiKGpOWzslfEu2zi4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=TIttQrMLFNHwLMoBm/jKv81KvP8ePxESQSiA08N3zXATZ21ktEIQZePrBABs1PBt/MYgDBRJgxUQcozOW5b7WCDJUdEIwNcKtf54Y3UHCkcws8qa07ecbbjcCA0YHFTjkdM4GRMbXDnBr/mImHB4C4OZgLeM9AM8qZiv5g1yI1g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=UVv1UjJd; arc=fail smtp.client-ip=40.92.22.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RkuHgIOjxccjzqc7UxJgE1apUdlK6ghsq/9DKfSdFwx+SNV5OMrem0UP2OXaKO8L6CInwZa9InPWYRUWOe4vNf8lLDXqRpbrbQOhsknGDtTiWZ5bqp8LDttG/SpjqK8oZk6BT5r7B6t4pRbB6CctSmeCf/UBn2nvYr+wWTBcYZiFd4EfQLeKUFd6YTIXdpVm/1D23DYx0hZ51GohqH7DmzirOw5t2IcILphl+Vjrtr9KWpgo9SIiHjpejabgdQ3yeqBv5NXWjI4HHHeQXXqNyyfMWBpWH53kKAAKG0FD0MF8SU+6K4H1J1xDCii9PTDMxzn8wQUJr8b9/JwrDMn6Hg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kS0KlR6sMzZ54c2Mbq9eCPI0GiPAwbDVfnXhdu/XLI8=;
 b=AU4mVFivZlqirISEwW1ipHXNeo6mTaUP7UwpNLdvR1Z485z/x+birbRL4ggAqfZJ0oJq6+p65A7NqW8Fv088bDcZ3hp4J7zqkdLuK9KS5k4E7WhhWpBwc8o+mIuORuc7zRUw9ZaAfD9E9aLmQdBxeZj4y4MfVioXk8+fH7xRdNnb1fs3SMcUZLw7ym9Kes6BAUgyWA1dv0nt/iqdE4cyJav59K5fa+SDIe9fOHm+kpXfCF1Y+lGU8AmOEmSiaDZyiNgXXLRcOJahCiCszXWWYa2sosvC1wlJS7aiQ/qKhNVZ1IlARGvKpScTiq+Sft9lZJb+wODJqMezvpSon2oA6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kS0KlR6sMzZ54c2Mbq9eCPI0GiPAwbDVfnXhdu/XLI8=;
 b=UVv1UjJdR5hs0/Y37N2OZfi/to9sqiCLwQCQgMIbNLfJrFSJL1KmRbhRslVzjgK4HfKM+xcoz62WlSETeT+Je7bPdLVuqQtagU8aqqfOKUzNUInBzVXASCYQRxezje8cDrN+rAP04T7+4gGEha8yTAhGYgOfrkRRoMCFUBOx4zk83cdkPff677dWilLW45sn1n0D4WJH+qKgPsBEm5h/xZmMuILf6Zcuj7Z6jRF3mzqNueUa/3BdW0//g1Jr9kz7rko2QEc0yIVHyDxPFUur8tV8oykQPfZ8m1H21isdatLOdGzuNv2JjxLt36AkG6STziQb69nNRt4utC6GuD+z6g==
Received: from IA1PR20MB4953.namprd20.prod.outlook.com (2603:10b6:208:3af::19)
 by CH3PR20MB6537.namprd20.prod.outlook.com (2603:10b6:610:154::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.31; Tue, 26 Mar
 2024 01:47:12 +0000
Received: from IA1PR20MB4953.namprd20.prod.outlook.com
 ([fe80::182f:841b:6e76:b819]) by IA1PR20MB4953.namprd20.prod.outlook.com
 ([fe80::182f:841b:6e76:b819%2]) with mapi id 15.20.7409.026; Tue, 26 Mar 2024
 01:47:12 +0000
From: Inochi Amaoto <inochiama@outlook.com>
To: Vinod Koul <vkoul@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Chen Wang <unicorn_wang@outlook.com>,
	Inochi Amaoto <inochiama@outlook.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>
Cc: Jisheng Zhang <jszhang@kernel.org>,
	Liu Gui <kenneth.liu@sophgo.com>,
	Jingbao Qiu <qiujingbao.dlmu@gmail.com>,
	dlan@gentoo.org,
	dmaengine@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org
Subject: [PATCH v5 2/3] soc/sophgo: add top sysctrl layout file for CV18XX/SG200X
Date: Tue, 26 Mar 2024 09:47:04 +0800
Message-ID:
 <IA1PR20MB4953A433A046EB55B4FF482BBB352@IA1PR20MB4953.namprd20.prod.outlook.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <IA1PR20MB4953B500D7451964EE37DA4CBB352@IA1PR20MB4953.namprd20.prod.outlook.com>
References: <IA1PR20MB4953B500D7451964EE37DA4CBB352@IA1PR20MB4953.namprd20.prod.outlook.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN: [UCcD5Xwk2hFWlWc8GhsrZmJDltzohuY5XjqIF/iU4s4=]
X-ClientProxiedBy: SI2PR01CA0033.apcprd01.prod.exchangelabs.com
 (2603:1096:4:192::23) To IA1PR20MB4953.namprd20.prod.outlook.com
 (2603:10b6:208:3af::19)
X-Microsoft-Original-Message-ID:
 <20240326014707.327110-2-inochiama@outlook.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR20MB4953:EE_|CH3PR20MB6537:EE_
X-MS-Office365-Filtering-Correlation-Id: 0bb21393-9719-4b30-2a2a-08dc4d36a7b3
X-MS-Exchange-SLBlob-MailProps:
	7J/vb0KDx3ghsXKwRy/t5h7NdWkXmzB09bpkKWdpET3I3EEg8yeWPe+qGQPYshxsS+qg25nAxTfPHzccNlnV2dsnP+R+soQAIAH0HEz0Fw9lOKjelM03qzwdS/jeZN7pQ2M9C5/qv4K6bKDevPLPFlRHtc/rl19uCdVol6HDhUK8EB6u5uPXF8hjD4iq3f4UHmaj41lJO33CbMwt43T+HSb6lETKsW8Vr1f6UQxk6jpIxfSCyI6ZwD0lLpwh4Wy8LKpfaSEbc7GIGt8Dn5VC09DjhxDE042+qC3ykRjBWxSvSal74jo6xTOaIkPlnMnBWRwcNuyAY/PlK/DGT0IJ5VAtFPp1ua/gkFqs0Eu+Zl25hK/COaUFJlsDGmtRoO3ehN90Toq0m12PnU75Dw0sLQ2fj/H5bu0KeBmvE+joNMSuhFx7NMF65JthzszQtHBaIQ57K+RC/eN0EHuh6kk52FSuYbIb3ysDlhRnjf+2pRqBZB92NKvjd43AzBoe8OPfeq/0RwVD1vanpCUhNXjwvneFnyhlxWRCun0ozzPW1OIIFFpQmoss6W9Flfe58FfwSRY9rwzqqHo8Qm1QXI5KZgPiYp4RCdo7s6YHqMpdUk3bC/A8qIrE3wYFlmolo6+s4Z5xHJEWBymzmFnfRoV6S0r3bY/yApWxkXO3c3+ZCfMp7+Q3WANm7PfWKcWCKi5MG+mPt5wVEPJIYJMktC3w5LmOyIlh2SH0ZPpJpsaTFcuAKxuOfE5vXcRK0Z1TDoAR38czlak0b3j28CSACwUNIqqTqGRQ/MDN4pvWiHavAP4=
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	4OXmSBwuI5aXD3nyBTVlYLE+TJJqIQuBA/L+UE8PNy23p555ym/qsVAd+NeaimBznlvNGiJt0SBN6NiGpD5POycfGySgrwHahtw17d64kEPHFQYemGuHzMaycmvq1qcsNdv9DT2x52oyArlnxudyRiE/mCKgSQLNAm1FXic+mZKVQM9wLWEjnkmh0sQib8URSDwiqNseDJZBooVB7I1PGPEZRKAK/n5KmOn4CuOE8vmlehUe58pXdGN9+DgLUY+LZ3RWHj2kWocigD9sGM3UHwJYi/uTv70X+O/GXwoUADsJySsctAV8GYE52qMbBdnuBx7Kgufv62G8lubR/CPGb3DpPHdWB2K6DGnNWqwkXYS5VkCEOKgRakSrEF0ibQmVqdpv5AKdvAg9v+nYA6EzDk0WNdyeHRP9+mgCuFePuM5QxdlJyTBDabgQzXidPJvGY0N4WWCY/wPn99C3citG+vR/pK42a77dXj0Wvt5aOMrQWiRkJ3ISP1mgLUf/QBQ+5qZJI+uljLD391WJsGKbBJtSRI5CBeHRJN4HdBKWJFrqeLOSDkspdKwl98iAd89hu17efHC/V7nsbbA0Rzs7Bp+yM5xuw6UGuqLR43Gj+Dy3JsneZE32JaNVy1PLgRrr
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?B+OjvEdIdSS05zwf1aU4iD6B4UdoPzU/vY4aqQbv3Z2pumMS8hlGb4novyCJ?=
 =?us-ascii?Q?UaBDVZRqZ7kYQY6e+qz/S1As70X0Fkh/K7iaWify9pp4SgxXDBKu0wjPbG+q?=
 =?us-ascii?Q?DhXC1DgkplNBngJ0mV7ZilKBKeIDLo9i6icidm8MCbTGq/VI27HrVmVcoIdB?=
 =?us-ascii?Q?nZAUWB1l21Mtr87c7Wmdf0Q4Tv1Dh9RbUXU0xHShJzLI1iMm7BMS7wN04W2L?=
 =?us-ascii?Q?JaXxMu2St+RoAap1SslqS/BLKN1Gjz8al0Psfwb3h1GtReCQ97E6ekJwXI4r?=
 =?us-ascii?Q?2vBlKm74aV7kgBJCPwi3bFATHjFl1JKh+kiOyFfznRwYOiGc8ASUR4+AUr5c?=
 =?us-ascii?Q?ebT8irB21wYsLYiAHHDUNTYJWx+Kq/GPySg8MH5dN4I9eJzihoz9RWMB7/+U?=
 =?us-ascii?Q?E2DXdfjXGQkXTOJeBHXlmpYy2u3XmmlDMnfdxMcxSROwvf1bEhBTu0jLnDEW?=
 =?us-ascii?Q?LgMSqPcjqKrPMb0zLkS7Ul9wpgEy4faU6B10VellNtCm3bnHb3cbECUEcZzC?=
 =?us-ascii?Q?699TUzFHXbVXd0B7vB9SB6Tk9tT3AHpIfJuBZlcrI3k3JCLTYp6GPMsgXxOi?=
 =?us-ascii?Q?l14M1k+WnKmE25b7eHJsM6etdCGOl5qzpQZXIP/+zUSgexygtyTRsdnG4GmO?=
 =?us-ascii?Q?OSzMSnHptk/3bs9k1i9YGi3rfENZJSCCH0+g8fFRCLvt4OKnB/7VWHlbsUTc?=
 =?us-ascii?Q?4xZbkEdiDEf1AJoa6feDDdd0TSjyuvfEIv7YS8HGruuUvY25/3hiFBEGAjGP?=
 =?us-ascii?Q?MfwiBsI09OH8RHmHYEHyD/6Xa2MU6/xMb3JjTz8kSGrZeV18WTOxrotFMcNz?=
 =?us-ascii?Q?jRFbYHxzcBpxF5I8uUr3kxTtsK6W5InqnPXk7X6hjUq55uTmvWu1cmSSu0Ht?=
 =?us-ascii?Q?1O3N4ixh+ykOA6dEuXfnsiArwiKbaej0/S9MauA1qDguFBV4X63s57MUtCpG?=
 =?us-ascii?Q?4vKz9N9sD+q5IlFWZ12sW5YI4qyXIVAd96TTBnnFTwoIKdx0o5vKIq+fnCP8?=
 =?us-ascii?Q?LrkaTQjmkZHca6EUZslZMcjzO5mgGRADqwUxLd+j6kF8ftyPfC4aBezdsDJr?=
 =?us-ascii?Q?UiRqfWel2kl8OAKBux+Dotu4OJ5FkMYY+zN9P1hFX7RDLJqLGrAuQIRDWl7G?=
 =?us-ascii?Q?3CoMOj2D4GLkjg+oPbB0E7UWyjp8l+ReJnFZ/LTZC25rb7SGJ5glCuzrC83c?=
 =?us-ascii?Q?qlJUFZcq+tWt5rm7O0gFem/rzirQ+Ixi27QLADrspDtotuRRAdBJXqBJLMjT?=
 =?us-ascii?Q?Dr0g01imtQ3tlWoVCTtb?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0bb21393-9719-4b30-2a2a-08dc4d36a7b3
X-MS-Exchange-CrossTenant-AuthSource: IA1PR20MB4953.namprd20.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Mar 2024 01:47:12.1401
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR20MB6537

The "top" system controller of CV18XX/SG200X exposes control
register access for various devices. Add soc header file to
describe it.

Signed-off-by: Inochi Amaoto <inochiama@outlook.com>
---
 include/soc/sophgo/cv1800-sysctl.h | 30 ++++++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)
 create mode 100644 include/soc/sophgo/cv1800-sysctl.h

diff --git a/include/soc/sophgo/cv1800-sysctl.h b/include/soc/sophgo/cv1800-sysctl.h
new file mode 100644
index 000000000000..b9396d33e240
--- /dev/null
+++ b/include/soc/sophgo/cv1800-sysctl.h
@@ -0,0 +1,30 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/*
+ * Copyright (C) 2023 Inochi Amaoto <inochiama@outlook.com>
+ */
+
+#ifndef CV1800_SYSCTL_H
+#define CV1800_SYSCTL_H
+
+/*
+ * SOPHGO CV1800/SG2000 SoC top system controller registers offsets.
+ */
+
+#define CV1800_CONF_INFO		0x004
+#define CV1800_SYS_CTRL_REG		0x008
+#define CV1800_USB_PHY_CTRL_REG		0x048
+#define CV1800_SDMA_DMA_CHANNEL_REMAP0	0x154
+#define CV1800_SDMA_DMA_CHANNEL_REMAP1	0x158
+#define CV1800_TOP_TIMER_CLK_SEL	0x1a0
+#define CV1800_TOP_WDT_CTRL		0x1a8
+#define CV1800_DDR_AXI_URGENT_OW	0x1b8
+#define CV1800_DDR_AXI_URGENT		0x1bc
+#define CV1800_DDR_AXI_QOS_0		0x1d8
+#define CV1800_DDR_AXI_QOS_1		0x1dc
+#define CV1800_SD_PWRSW_CTRL		0x1f4
+#define CV1800_SD_PWRSW_TIME		0x1f8
+#define CV1800_DDR_AXI_QOS_OW		0x23c
+#define CV1800_SD_CTRL_OPT		0x294
+#define CV1800_SDMA_DMA_INT_MUX		0x298
+
+#endif // CV1800_SYSCTL_H
--
2.44.0


