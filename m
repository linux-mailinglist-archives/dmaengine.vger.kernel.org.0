Return-Path: <dmaengine+bounces-6959-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 05F7EBFF9C9
	for <lists+dmaengine@lfdr.de>; Thu, 23 Oct 2025 09:31:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 441A33B19E3
	for <lists+dmaengine@lfdr.de>; Thu, 23 Oct 2025 07:26:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB1933009CC;
	Thu, 23 Oct 2025 07:20:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="FxXxRS//"
X-Original-To: dmaengine@vger.kernel.org
Received: from TY3P286CU002.outbound.protection.outlook.com (mail-japaneastazon11010001.outbound.protection.outlook.com [52.101.229.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E962B3002D1;
	Thu, 23 Oct 2025 07:20:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.229.1
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761204004; cv=fail; b=VI927eZMJ3kCLK/wNIo82Dc4+sqsdw+Z4dMqn+Zdr/2foNN6pWUmsjuo2Wxw17lhkGkiryBUMKwkwRaovpsrpTXWFlWIt4fWbLcdGdEp6LKEwN18pZCuuzjvKn82LfbpDyBUUSwDEhNrTfdtpxgUT3cqqZhscDj0kPCoKdGt7S0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761204004; c=relaxed/simple;
	bh=nZMCS9Jnw97vfcuL+WHvOSplmE+NNUz10Y7tfEnKALU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=hYFNtaz7AHNqA5eRxA4zPBP/i0Cvw5GAK++YiUrI16OC17u6/37r7oV+neqcE3gbva4kQQCfZxd83RdwKMBzBMd8ifxFJQ65iT7P7WtLvxSm4kS0/yPi2hjtK2htFD/2Cph2hvIt0k7k/FA2pFzcptR/RcnZsZiU5DDn85Q18xM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=FxXxRS//; arc=fail smtp.client-ip=52.101.229.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yQB/POwteTT7gj7bTSkf0m0C5NmHLIiJuU1YWyzwv8+XbqVJtiQhutLrL3/Y+5l2DeIh/r2+cJr0MGw0yp3/pyzzKk95a541LMh+q+0NTrGJFUh3o9udj2PGRBiqjDUGkFHWvxO6qB8QUmq/qbGclxRhWekMb5yHctSvf3gyVxP04FIeg8ssOJjBsUqAqj+bRfg98izv4JrUcvwEEqYilfw75lgVERyepJdAM24y4J+HbjdfgEDZNxfj889tp8pIHN5KwKh0hylYlZbtGWEhHQojxP3vawycK9LE2Zbpl4pwHfxKIw66a4GCh0xl4saEUviGvcXhca0tZL34XUwuVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/Xvy+8jLLmHKVtauIunrPmjfBybD+vwXf4XFjmv2Q0E=;
 b=oHMZrcjKYn4Yrbcvsug5otOFlmjE6LvV6N8Ftmcg+dNwTXdyx0d+HEThYeiZVv2txWWR3+MGROSG2B8Cb94u7+gcJxyUBITW/oQXFGe+0eh+ddW3LcQ1PdxfJ1PQF0NAIs0vWgPqPe1xBUcpP+ONHG2UjTzdwEDBpoIXAGS1YDA5RmsVFyTA7VFFyWVhW5RUthr5czI4jCCvPI5A6/30oUHv4s4Jl9D2Evdfhztq4O/nYdvCOPYpCyu205yKfvz+X1V2WnEj0VQbXtqIuiagFARRxGO1sPmd6F/WxVn9bGbIXlNzSkqkMGmIk/5eNkLauf5bwY5xkjUSCqxgDcGGzw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/Xvy+8jLLmHKVtauIunrPmjfBybD+vwXf4XFjmv2Q0E=;
 b=FxXxRS//GEhKukOlGX9hLNZuSPqPKw1zIq5cWmk784JFEIeCSNta8Edec0bguhOSHXdw7zud/0C9wuCYe7/+leq7mO0TeFWaZdL49cPB8ClbmMf/Ao9O4+dO3B14wbyrCsOl3LKDYwSbx68R7CCmueO6ZkSBPL4noHPDOeJFEd4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from OS3P286MB0979.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:10d::7)
 by TYRP286MB4555.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:1b0::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.13; Thu, 23 Oct
 2025 07:19:52 +0000
Received: from OS3P286MB0979.JPNP286.PROD.OUTLOOK.COM
 ([fe80::80f1:db56:4a11:3f7a]) by OS3P286MB0979.JPNP286.PROD.OUTLOOK.COM
 ([fe80::80f1:db56:4a11:3f7a%5]) with mapi id 15.20.9253.011; Thu, 23 Oct 2025
 07:19:52 +0000
From: Koichiro Den <den@valinux.co.jp>
To: ntb@lists.linux.dev,
	linux-pci@vger.kernel.org,
	dmaengine@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: mani@kernel.org,
	kwilczynski@kernel.org,
	kishon@kernel.org,
	bhelgaas@google.com,
	corbet@lwn.net,
	vkoul@kernel.org,
	jdmason@kudzu.us,
	dave.jiang@intel.com,
	allenbh@gmail.com,
	Basavaraj.Natikar@amd.com,
	Shyam-sundar.S-k@amd.com,
	kurt.schwemmer@microsemi.com,
	logang@deltatee.com,
	jingoohan1@gmail.com,
	lpieralisi@kernel.org,
	robh@kernel.org,
	jbrunet@baylibre.com,
	Frank.Li@nxp.com,
	fancer.lancer@gmail.com,
	arnd@arndb.de,
	pstanner@redhat.com,
	elfring@users.sourceforge.net
Subject: [RFC PATCH 24/25] NTB: epf: Add MW2 for interrupt use on Renesas R-Car
Date: Thu, 23 Oct 2025 16:19:15 +0900
Message-ID: <20251023071916.901355-25-den@valinux.co.jp>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20251023071916.901355-1-den@valinux.co.jp>
References: <20251023071916.901355-1-den@valinux.co.jp>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCP286CA0175.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:3c6::14) To OS3P286MB0979.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:604:10d::7)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: OS3P286MB0979:EE_|TYRP286MB4555:EE_
X-MS-Office365-Filtering-Correlation-Id: 3a4e57fb-0248-4821-d8a2-08de12048f0e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|10070799003|7416014|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?/xQgi0tzu9DK0YdUuO1m+r8Uj0PVDFxeWxJb7UoYdSbihTDRpvDhKo4nJH2I?=
 =?us-ascii?Q?89aztIS08rjp91r5xG3uaIePd9Oz1LsNt/F+zTyKGzqjzVULQiZ034rJ37y5?=
 =?us-ascii?Q?biuszzUCVkkP5qRGtd+4N8bXyv/x9g05+ML0wz5g9em3Kxq+kIM018IE0p5Z?=
 =?us-ascii?Q?EjDvjMHSHGacw7Eeg5pRoDCMF7EmGp85Ylfw7uN1iI01txSnBy2eTDcGUHld?=
 =?us-ascii?Q?FGXAL/d1X2IIlm+cZK0OkrJqxxLBb7kbAW+IA62T3rBNeB5/x4Vhs5R1CLYe?=
 =?us-ascii?Q?oKSRi/XTs1LY2HKjtBwFg/9udka83UnCuGqwukB8bUp0GYVLQKd37uiwqCh0?=
 =?us-ascii?Q?zpY1J5HQabRfoVdUKq21N35zGiTHoUmwGmQHWSFkgG8qEl/77yFr51aGTtBt?=
 =?us-ascii?Q?QBzyf1Gl3GJEnLgNvYUSllHSDZtCuXKNfLrQ/caYibbcyZFiarFd71w7OhJY?=
 =?us-ascii?Q?rFI3DQJd7YFdzR9FtfwmqhvJuql/je+zam5UMC5t4TGv7tHd5/GJ5ggetlr9?=
 =?us-ascii?Q?0JI9hecCB6TMhgtl65BldxHv4ADh4qPLRFbtkgd+oEjrRGl4o2rj/eVql/W8?=
 =?us-ascii?Q?/2WulRAVuJEORsZ8J2WU6l1dQbefgGSK+JUmaPB6BZeo8FtmBEbgKXOaN3vV?=
 =?us-ascii?Q?F3eKPkbu5ysKV4aXorjpRb4xztfii1+KYhITuHLPF9EXd9P1RXEaGMbcD9fS?=
 =?us-ascii?Q?iQPBI7kcHrZBa2BQSHYqsb9v2QG6l3ta/zlDQTdvAnufIHyryFPjZ1bb5Wow?=
 =?us-ascii?Q?RyVHFm0jHNq3XE/rnXeiefVofB3yYalOM/RMc+xWKAI+A/Y3c5m67DrGhAi+?=
 =?us-ascii?Q?J+OPj+3QGu/uDPwhNNFvWBy32cvAy/fJ/xjh6rZpTTOcAt4SMgK1Uo9HFh85?=
 =?us-ascii?Q?ZQV4HFdfLL+B7Yh6xEjigaaNLq0CNCKLIr10D991AI02r4wHNjnp7bDZ81hS?=
 =?us-ascii?Q?d1cN5+JqNlCIqT2G2aKEXxSmFu5EX9Ixa31fApEFdx2WFdpLLJC7jseVlaVY?=
 =?us-ascii?Q?IZ0IGm8UXSMILaAOQMOCamojey2IoMBuFECOfD7WbTj4lX9S0qikWt19dAy0?=
 =?us-ascii?Q?t379wOpSYfPG3iSnbIyqprNptye+NJTL2iG2ddL05ORf7PGUVvQxY41KoqUa?=
 =?us-ascii?Q?9+CCkflbptpiPK3Z9hGJNGAobq6oXumbDNUdZI+UDbbooN8xr96N6ifqgnRh?=
 =?us-ascii?Q?fF2DgSZKb8VZ/+49dZXaCa9gWZRjZZy0fE8LWwREVm+DV0E0V0y6E3qSXnZd?=
 =?us-ascii?Q?2ciuelIxfjEw+bVvkaQZgDaaBQvy+mKzvGl0ANMw+5zGzXb1EHNUgn9qrlSX?=
 =?us-ascii?Q?eiKK2595oHIRLrcOWyqyGYkUSwmXxCQWSln2WGFFGcGcm7icOjAa1H4pIcnw?=
 =?us-ascii?Q?FvaEY1HQovM5rbMuzfEDAeBVjikO6udNws8TccaLSS7wAD5sqePLWire9VCM?=
 =?us-ascii?Q?mPfaeEbuYE72f+U0A1mqrrsbOhisLO0Y?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS3P286MB0979.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(10070799003)(7416014)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?IEuq0tWR1zPyx1fBYaNtN04kT1Bg8ov2YeL/dyilKShFuWiIAUrHMxxtFXpl?=
 =?us-ascii?Q?UB4g9S4SnCOEHsKyZf2zeaiwu1YQ67dsz/wjTr0U6tVQk5e7zekyjC4OPlP8?=
 =?us-ascii?Q?6RUNmJHwyGGK9ArygqGhjmrBFJlScB3cTGuOszRUz5zMfw/55/sENIeA6cjR?=
 =?us-ascii?Q?1UlnTEYiytBIITXPV8olocL+ZovmcZqHEdXtqABmKBcJ04oWvmA+imjZJ816?=
 =?us-ascii?Q?bXqze1ixf9zhTdgqs6BclJR29CllIsN6cE33koU/3NWulSUnj4yaLmQWVw2i?=
 =?us-ascii?Q?a1+nEIXBgTUaimRrn1LUZHxhwLXO28WspVpLUEFuNOpwT4GaBxw6h8nHyfIz?=
 =?us-ascii?Q?2wzSlIxurbocYc7cQP0xSW7Y5zVNDri090Yjqd6LaI1/qYgYBrvfjkSWbLSY?=
 =?us-ascii?Q?R8wSLAeOP5GbZrUZ0TIZBRYFt6Qn+65SiYtH4LgG5DuCtIQC2R3P1a3EkYqB?=
 =?us-ascii?Q?AdxDrrVsKjSGFXRathtsSnt1kJluUn1HyaCKAvp8HVTT52iv+CQb6GtqxfPv?=
 =?us-ascii?Q?MDOk83cZn/LQ9fHre2Bj5x6I/Y+y2VcmncXufEaHgPCQIa7Xm1J43OHSY4OP?=
 =?us-ascii?Q?JQsmY7YD6piXT21LNWyTNb/kNVfR//AhRwqt3YHT3DmPun+9kAXviWB667ln?=
 =?us-ascii?Q?+/Vyr0Peqc/9yyghR6CKgecDZXZdFLb+eqGdaf4wik2BuBwkLIN9veFLKBlO?=
 =?us-ascii?Q?5ZYKJonKETEop/1J93mArQMlvlzu+KtFENHnbA0kwa/W77z3yl/Frv/TGJeC?=
 =?us-ascii?Q?dAba4X7qoo2M3i+fysYymCAX5gcynRlmUCxGjvGMw7jbhVihU0jnyeBP3pwb?=
 =?us-ascii?Q?nq7fw+AdU0jgu0diZmCT1LRQNjByP+Liy8nHchvrt0rqd5gee7D3ukB9siOe?=
 =?us-ascii?Q?nWcLBYMEUHKVb58p8ceuKu7oLDtUFliedxGh9zKAsC+79FHqlg8HOKlBGccr?=
 =?us-ascii?Q?g8eCoyadiy/y4fJPMLtiXJH3BwoxfKuaxjvglieBp5ImW2FqGXGt5O44cJmz?=
 =?us-ascii?Q?irBxHb6JejC/JUHT5TPyTFDolfR/I60sb4dIhLRBCBKMdvnr/rynAhzi9zCZ?=
 =?us-ascii?Q?Nv8qFarKluC2BINdOZ+HNtXTYsPjUOQ7P3n8vHSKB61fhpB+NLb4PQfYJnT7?=
 =?us-ascii?Q?iyNfkdcBGiLKHNl0YsVyGOtRbpXPxyM9vB0/GOtsdDlKYiyiojTBR1bhbQ+N?=
 =?us-ascii?Q?u+WQACj8k4lVHKGMgrERpWfffmyTTYcyLagUeOQiD7p4REEJoxGjakRDWuuA?=
 =?us-ascii?Q?AZaIKXFvcJhL/QrwtdfuyjwGqINwuxkGRYMfmsbf7J484+0kwEZYu8lRJfTy?=
 =?us-ascii?Q?1pqB/8dguoS21jsJ/uPH5Zc+8xI2BHtJ7gwjwv54X4oUXZEZhM/BJfuW5MMM?=
 =?us-ascii?Q?A5YQGXVQKwDioIducOcrymXG84YEvAw/2m4zjilD/b8xXi61R+iKDhNPniEw?=
 =?us-ascii?Q?bfLyKOVMc5JwU9hJioLRSOYq2xrNEzHiZos+tYvQ1IPdApTpzFaDMmxeTtgE?=
 =?us-ascii?Q?kaZEEHN7p+k1LcvwP5uS8B4yG5HU0V3p4e0fRLXoI8UxOJ2j/R/0CCuUpSBY?=
 =?us-ascii?Q?f663ZR+sb88HoXuMu3kvPTBdVp1ahhKGWY9LiCdik72nHzvxonIfRT+o7uGM?=
 =?us-ascii?Q?1E7pZfzUgaCVCjWkatejDJ8=3D?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: 3a4e57fb-0248-4821-d8a2-08de12048f0e
X-MS-Exchange-CrossTenant-AuthSource: OS3P286MB0979.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Oct 2025 07:19:52.3972
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8jh5+Mp7U0s+R/1it0tkkoUfRzN3LD2H4ji+n1PF56QDucREagymilVJecbwxUy4NmeOdZsdjmbCHjWsO+7+9w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYRP286MB4555

To enable interrupt support, one additional memory window is required.
Since a single BAR can now be split into multiple memory windows, add
MW2 to BAR2 on R-Car.

For pci_epf_vntb configfs settings, it may look like this:
  $ echo 2       > functions/pci_epf_vntb/func1/pci_epf_vntb.0/num_mws
  $ echo 0xF0000 > functions/pci_epf_vntb/func1/pci_epf_vntb.0/mw1
  $ echo 0x8000  > functions/pci_epf_vntb/func1/pci_epf_vntb.0/mw2
  $ echo 0xF0000 > functions/pci_epf_vntb/func1/pci_epf_vntb.0/mw2_offset
  $ echo 2       > functions/pci_epf_vntb/func1/pci_epf_vntb.0/mw1_bar
  $ echo 2       > functions/pci_epf_vntb/func1/pci_epf_vntb.0/mw2_bar

Note that users who do not use interrupts can keep their existing
configfs settings, and this changes will not affect them.

Signed-off-by: Koichiro Den <den@valinux.co.jp>
---
 drivers/ntb/hw/epf/ntb_hw_epf.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/ntb/hw/epf/ntb_hw_epf.c b/drivers/ntb/hw/epf/ntb_hw_epf.c
index d55ce6b0fad4..85165662a03b 100644
--- a/drivers/ntb/hw/epf/ntb_hw_epf.c
+++ b/drivers/ntb/hw/epf/ntb_hw_epf.c
@@ -750,7 +750,7 @@ static const enum pci_barno rcar_barno[NTB_BAR_NUM] = {
 	[BAR_PEER_SPAD]	= BAR_0,
 	[BAR_DB]	= BAR_4,
 	[BAR_MW1]	= BAR_2,
-	[BAR_MW2]	= NO_BAR,
+	[BAR_MW2]	= BAR_2,
 	[BAR_MW3]	= NO_BAR,
 	[BAR_MW4]	= NO_BAR,
 };
-- 
2.48.1


