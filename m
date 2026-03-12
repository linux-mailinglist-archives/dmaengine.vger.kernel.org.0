Return-Path: <dmaengine+bounces-9399-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OMxaHhXwsmnAQwAAu9opvQ
	(envelope-from <dmaengine+bounces-9399-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Thu, 12 Mar 2026 17:55:49 +0100
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CFCBA276124
	for <lists+dmaengine@lfdr.de>; Thu, 12 Mar 2026 17:55:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9C65831EBA5B
	for <lists+dmaengine@lfdr.de>; Thu, 12 Mar 2026 16:51:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FE4F3FB06E;
	Thu, 12 Mar 2026 16:50:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="domo2wg6"
X-Original-To: dmaengine@vger.kernel.org
Received: from TYVP286CU001.outbound.protection.outlook.com (mail-japaneastazon11021077.outbound.protection.outlook.com [52.101.125.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36D853F99CD;
	Thu, 12 Mar 2026 16:50:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.125.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773334233; cv=fail; b=SDfxYNZeNVLv03MrhGvjns7D8EUO7yxwcALPy26/7avaAVAUoV/Eh0MQBamI6fhsgvDQiNQzV6zcv4JG3R/JR6OtNGv5srxQSvTdJ0qZ4c0IvVPrWI1lF3ohbVkRRIbR/dCPYFgh/+5NpZSGa+7ywESw6B9THIbFxnh0e6/zLuY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773334233; c=relaxed/simple;
	bh=oRUMZpESv5oi0855aEpTxIMyfVP3VRH4ZXPvy6X+meQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=HN60Wbs8Lt3QreWoUhwQtOiS1TVxWuJ6osYFdS+HXIqwwddACdsRTd6E99PtsvcjnscnO4LxegfOEVz7yQyfRgoyAXHK15uz/sbAntKK55WflEZCXnEzPhhoITSFoiETJg9xC8aPKT/vTTR9LvkfHkQb50hkVFN6+iDlO3Z9NyE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=domo2wg6; arc=fail smtp.client-ip=52.101.125.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UlOmUJaJZMqMuQ9P4aHPpr1kF3nP7rEyvLDrbSINVnsIXCeHszsjyaK2FGSD9jrwGg1stPOJxGR4STQXGpcT/6dUtcax17SSWYwrIkr1z1uj1TBuFHhTkKlwi8XgVnSFARnIL2DwaIFuVoCFaowPb3l4GXP3JGG9N0kGTwzZE4xBJkPC7DT18DctmrTYK7yel2VRDdVWirVfgJ90MzDH5OHxtaXNAvGW5qYhWLntoZYVQ/sIUfgYXBGi+Pfqis1k3mP1sEJWtpAU2bogR+wnk5oJt1ucyYRVHkLrS8Io5bqCZ4fOLgkIZBVH8bm42GGQBDE/W8j6GOuYQoF/oljbGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FRO+618z3BHigGP64C/HftyhRPlhNFbo9rfEE4nmA+A=;
 b=qSsP8H1rymVzhfFFCwRMYDo2gt/Ef5Hu55tTqRzKXv5RYdzadqCOYE7ong5aIFdhzEAhVKvZHO0mD4jHhFyuyfMe6O/A9vs2WNktlif2YCFK/kTSlU2KCA20Mm8vBYLZl90OIyYPTwYLrRKCEaXGadpdNLnVaGHFlRr17y7fNYb8YjJwIRtdyNiKK2RnXsJiEQng/n+xp6Xha83vsh1t+yt15vzNl1lhqWQ5Nsh021H6ur/L/HyOuc+pPd86oD06YXej4BO4hdbhBPADrloiEScfWX4T88UalHhC0nkSAw6snXf1CRSjWGkIVckWvZcurPAebq6mjfCKhdQS76rmMA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FRO+618z3BHigGP64C/HftyhRPlhNFbo9rfEE4nmA+A=;
 b=domo2wg6E63Z96xluzHQ20hzyDK++CoiHUYkhfTKf7qMvR8J2vRl47lcEmSY/htvfwjThdVFKGjFQs+kc9PsmGkxE1awJNg5+lCsRmW7jsEUBogYopBmmiBoe5GihLW8EWygcy8TdgCLIIzxGIk5m69nAX2AtNodKb9nlWmFc0E=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:38f::10)
 by TYCP286MB2018.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:15e::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.15; Thu, 12 Mar
 2026 16:50:14 +0000
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32]) by TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32%5]) with mapi id 15.20.9700.013; Thu, 12 Mar 2026
 16:50:14 +0000
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
Subject: [PATCH 04/15] dmaengine: dw-edma: Add per-channel interrupt routing control
Date: Fri, 13 Mar 2026 01:49:54 +0900
Message-ID: <20260312165005.1148676-5-den@valinux.co.jp>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260312165005.1148676-1-den@valinux.co.jp>
References: <20260312165005.1148676-1-den@valinux.co.jp>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TY4P301CA0114.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:405:37e::12) To TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:38f::10)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY7P286MB7722:EE_|TYCP286MB2018:EE_
X-MS-Office365-Filtering-Correlation-Id: 1d35edbe-17d7-41ee-85f1-08de80576ebf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|10070799003|366016|7416014|921020|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	KvYGCjVI9X+X04W/MhGY/Dd95sdp8BrKw+hCVl6dJKSRYZDT5K8WQD+85/1fNhGaFTht13EcgkY3Ey+cihrLSJ7FpEQUkvFt5TN4TsDH16wQ62FVFu8G2psIvoT89dK26D1l8FQQOmf59qDEQ9mwlRea+S0uvroDdQh1XWIrUpQfSytopceUHQUNf5qpALP3BWl0s/dq5WV6i0XF/ZGEeMtZLE9XQUTElFOuFwBVMkL0Y1oYdSpYL89lTzAz6VyG1TXXK4enakfioud+MBBrEwpxMKQDXvoQMOnOE+Kc1MEoOkp1wYEN6m42FCEzJF9xvPWLWMAjKDPBF5GSKmU2Pn3tMuMHZoqTOKZOfmTxPhdMlcwL2IlLHY2/qZJUcPz+mRxzMwk3stFkP3i2uLztnTMd9BhrgZpiqnwrn1wCqq1uBQPSIjavN2EygRQUU/hRcehS/umYlLohVig3v023LVMiJSF0qYS2MLbvbCAUllQyroNbOn+Vovl9nzlYjqFggT/9ejlWBNyDE8h7lqMk60f0cVBCXLSFpW6PhQX6LHPZXMEvUyJXfxfAz4p4GXgQkchBc1M/hCpEwlMCvL97KfflzEfOlUoutUFOrI5AEGMP0a9jnGIiyPo1J7FEC9OFCCCHB1cXWhrvpbojqlmZdCBETdook3PuTCUd0IK5NbL6xnjYk0pP6hVdcFyvDhbXg4+9PBtWWdzbsL/fJ08N20B9JHhuMOC6DSrBCCW+0SI1ufRJlBLpMmOE+NeI4yKUpTZDQMkWmgHdaRHYG5CWbQ==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(10070799003)(366016)(7416014)(921020)(56012099003)(22082099003)(18002099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?99fb95flrqzB/+4AZomEptKCa7ohe8OhS9fnFJ/PuI0a5LOPIWJS8xZr4WcU?=
 =?us-ascii?Q?zIzXOPzGYTiY4ATy9zlWyaN7dKbEsBXv2cByyx+g8JWs5qK1PjPYvETQOob8?=
 =?us-ascii?Q?dyL6I6GfbyRbccWhGJk1it9VbNcCsuPE/t69Ecpky0kVeUwtUUD5BIef6bvT?=
 =?us-ascii?Q?WQr1BnYG7pVgtayWWMWbdqcpyGAwDW7uRPIScycTJCETAH8/6c9Rm9UEUB6I?=
 =?us-ascii?Q?sIMaLxKEvmQr78GClIdzde2RvdIkLdvilEBoaNVSPbI5GcyUmghzGA/oWbUb?=
 =?us-ascii?Q?4d2tqMf0DEP77BQ8vFBUxSzXJsljLRFPmKPvJAj9hBLy4mz27OKZFqqadc91?=
 =?us-ascii?Q?ddpot+1yWjiNq79jA56zAf7SxLamHt/2HOc8zfPQ35PetAFCZpvjvpSvMbac?=
 =?us-ascii?Q?+dGtiu/feOz6wSk6GhF/6wZBWehF29cxd5rmFNbrLmlyOd2XBh1JEXzjoXvC?=
 =?us-ascii?Q?9l7T66tBGLwGuJdFtGemnA7Qpz3e/tZShkGDMxHvjQwxRBZe5rNeHu5UDND8?=
 =?us-ascii?Q?cEnG5OLEF094Bs9Fj1m0p3DwR9S0NFEUrgFGKK03KZvdBDy+5+Hb1UVqulKP?=
 =?us-ascii?Q?8abwEQHAeZyGX81uv+S+AIYIpBAD3eh09QGLRGnjzLidpk0DBfW4UMcDsADc?=
 =?us-ascii?Q?rSVSdcQpwKcc/Q67rnMdVNcCMgof6KXMPIvfbBScdMRV0bW3VOKXhOV4aIig?=
 =?us-ascii?Q?RKj/HqOm5p0IyE9QXC8FmPFv4Qt9ft+gQcVtwPNjwedF09nCU7A5hvfea0GE?=
 =?us-ascii?Q?uSrc6i20pMjE+TdSfhQWYRzYNgHwPT0l+AGalnonzXRkeVHTNldyx0ZKPe+D?=
 =?us-ascii?Q?QTcbnsqED1pz2EV4YMRKv6L1vSoyLAFOPhdtb8IjnfqsClhse5dNMyA/HnvM?=
 =?us-ascii?Q?Rr7WgsE2ewTQvWOirT82AXswq/MfLBALNSpiJAUpSzCMLOElhouPxt7PfYnx?=
 =?us-ascii?Q?25pF86jvd333jdVGorcpe6rsEtL5H+ElNHkAUzOBSIuwL5S1b6NKD0TFVIuj?=
 =?us-ascii?Q?gSgISnVL+v7d3BAQNj0TjBRvbuYEmr/o97ez1TuPDuEnKyPJ0JwiJ1ZDUvew?=
 =?us-ascii?Q?iZBp333+ob4zr770cZXzoWcQ5VgJTAy7ZPtP15D5DDcnbVZHAuo0Vg+HOLrt?=
 =?us-ascii?Q?CXjJXvtkNleeRaEi/m6wu1prjQV4XHfCUcgLnREwrH6ETVuA65Q85F1Mu71L?=
 =?us-ascii?Q?MK/YK1Ozx8U4bm65I2lKyNn4IHxbJAtVGmWUhMogM78pKimaHGZdVZ5wf8Qs?=
 =?us-ascii?Q?jxQf7I7i3IvkXlwGLLvF80jxebZrFQvl1PDpw3H2TXLMxBrOgeK5Oi0oOjH8?=
 =?us-ascii?Q?+3uHxxeGvSM6ov5QQGr/BoSV8dkY4uT3skM4yrYjP5C3h7e6fkceDXquPU71?=
 =?us-ascii?Q?GY3noRDBs7ijduFbWE0krZpw0x3Y4YrfYpfMJmYr2gK24KqlzKi5L18oTY8p?=
 =?us-ascii?Q?AyZ1Hi9t1gO1Zx743WDVH/M4PjbW+CoItkZU6XDE2z0FAMGuhTt5zdhPsoPG?=
 =?us-ascii?Q?6n4LhOuZy8eBgKxHhTq0dPyMJNkbjnYEtPJzdKZ5RiyyyGFK4SYTpTzZZiMy?=
 =?us-ascii?Q?VOfV0JsILpRDjp90GtPDEWjAxZItgncy8a1t6/HB/nP43pLSPnZMfcPWVJk7?=
 =?us-ascii?Q?vq3Q524SK0fdCB34I/f5RYiHKP9C+mktNm3XSTFA7tYS6/QC7Wiywp2I7ayN?=
 =?us-ascii?Q?x8eSwQkI2weIXjOg2JyBjJtpYfRvV5PYLUs3NLRDnIbmRN27GNSJ7HfQhM0B?=
 =?us-ascii?Q?V2CFXU/YIfEU+my9xz9n9MsRJFLq8mU0n2YE9bJXuFBIrcI+7KF2?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: 1d35edbe-17d7-41ee-85f1-08de80576ebf
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Mar 2026 16:50:14.2168
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pXTjo69+1RbtFdkLt4Pf1rC/35Jc4EayJArBPBhNqPrqwLfBNHPObFboGsq+aE449EYCw9u0Q8B3Vb0ed8GK4Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCP286MB2018
X-Spamd-Result: default: False [1.34 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[valinux.co.jp,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[valinux.co.jp:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[22];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-9399-lists,dmaengine=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: CFCBA276124
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

DesignWare endpoint eDMA can signal completion both locally and
remotely through LIE/RIE. A remotely controlled channel needs a
per-channel policy for whether completions are handled locally,
remotely, or both; otherwise the endpoint and host can race to
acknowledge the interrupt.

Add dw_edma_peripheral_config, carried through dma_slave_config, to let
a frontend select the interrupt routing mode for each channel. Update
the v0 programming path so linked-list interrupt generation and
DONE/ABORT masking follow the selected mode. If a frontend does nothing,
the default keeps the existing behavior.

For now reject the new peripheral_config on HDMA, where the routing
model has not been implemented or validated yet, instead of silently
misprogramming interrupts.

Signed-off-by: Koichiro Den <den@valinux.co.jp>
---
 drivers/dma/dw-edma/dw-edma-core.c    | 55 +++++++++++++++++++++++++++
 drivers/dma/dw-edma/dw-edma-core.h    | 13 +++++++
 drivers/dma/dw-edma/dw-edma-v0-core.c | 26 +++++++++----
 include/linux/dma/edma.h              | 38 ++++++++++++++++++
 4 files changed, 124 insertions(+), 8 deletions(-)

diff --git a/drivers/dma/dw-edma/dw-edma-core.c b/drivers/dma/dw-edma/dw-edma-core.c
index a13beacce2e7..6341bda4c303 100644
--- a/drivers/dma/dw-edma/dw-edma-core.c
+++ b/drivers/dma/dw-edma/dw-edma-core.c
@@ -219,11 +219,60 @@ static void dw_edma_device_caps(struct dma_chan *dchan,
 	}
 }
 
+static enum dw_edma_ch_irq_mode
+dw_edma_get_default_irq_mode(struct dw_edma_chan *chan)
+{
+	switch (chan->dw->chip->default_irq_mode) {
+	case DW_EDMA_CH_IRQ_DEFAULT:
+	case DW_EDMA_CH_IRQ_LOCAL:
+	case DW_EDMA_CH_IRQ_REMOTE:
+		return chan->dw->chip->default_irq_mode;
+	default:
+		return DW_EDMA_CH_IRQ_DEFAULT;
+	}
+}
+
+static int dw_edma_parse_irq_mode(struct dw_edma_chan *chan,
+				  const struct dma_slave_config *config,
+				  enum dw_edma_ch_irq_mode *mode)
+{
+	const struct dw_edma_peripheral_config *pcfg;
+
+	/* peripheral_config is optional, fall back to the frontend default. */
+	*mode = dw_edma_get_default_irq_mode(chan);
+	if (!config || !config->peripheral_config)
+		return 0;
+
+	if (chan->dw->chip->mf == EDMA_MF_HDMA_NATIVE)
+		return -EOPNOTSUPP;
+
+	if (config->peripheral_size < sizeof(*pcfg))
+		return -EINVAL;
+
+	pcfg = config->peripheral_config;
+	switch (pcfg->irq_mode) {
+	case DW_EDMA_CH_IRQ_DEFAULT:
+	case DW_EDMA_CH_IRQ_LOCAL:
+	case DW_EDMA_CH_IRQ_REMOTE:
+		*mode = pcfg->irq_mode;
+		return 0;
+	default:
+		return -EINVAL;
+	}
+}
+
 static int dw_edma_device_config(struct dma_chan *dchan,
 				 struct dma_slave_config *config)
 {
 	struct dw_edma_chan *chan = dchan2dw_edma_chan(dchan);
+	enum dw_edma_ch_irq_mode mode;
+	int ret;
 
+	ret = dw_edma_parse_irq_mode(chan, config, &mode);
+	if (ret)
+		return ret;
+
+	chan->irq_mode = mode;
 	memcpy(&chan->config, config, sizeof(*config));
 	chan->configured = true;
 
@@ -808,11 +857,14 @@ static int dw_edma_alloc_chan_resources(struct dma_chan *dchan)
 	if (chan->status != EDMA_ST_IDLE)
 		return -EBUSY;
 
+	chan->irq_mode = dw_edma_get_default_irq_mode(chan);
+
 	return 0;
 }
 
 static void dw_edma_free_chan_resources(struct dma_chan *dchan)
 {
+	struct dw_edma_chan *chan = dchan2dw_edma_chan(dchan);
 	unsigned long timeout = jiffies + msecs_to_jiffies(5000);
 	int ret;
 
@@ -826,6 +878,8 @@ static void dw_edma_free_chan_resources(struct dma_chan *dchan)
 
 		cpu_relax();
 	}
+
+	chan->irq_mode = dw_edma_get_default_irq_mode(chan);
 }
 
 static int dw_edma_channel_setup(struct dw_edma *dw, u32 wr_alloc, u32 rd_alloc)
@@ -860,6 +914,7 @@ static int dw_edma_channel_setup(struct dw_edma *dw, u32 wr_alloc, u32 rd_alloc)
 		chan->configured = false;
 		chan->request = EDMA_REQ_NONE;
 		chan->status = EDMA_ST_IDLE;
+		chan->irq_mode = dw_edma_get_default_irq_mode(chan);
 
 		if (chan->dir == EDMA_DIR_WRITE)
 			chan->ll_max = (chip->ll_region_wr[chan->id].sz / EDMA_LL_SZ);
diff --git a/drivers/dma/dw-edma/dw-edma-core.h b/drivers/dma/dw-edma/dw-edma-core.h
index 59b24973fa7d..e021551b0b9f 100644
--- a/drivers/dma/dw-edma/dw-edma-core.h
+++ b/drivers/dma/dw-edma/dw-edma-core.h
@@ -81,6 +81,8 @@ struct dw_edma_chan {
 
 	struct msi_msg			msi;
 
+	enum dw_edma_ch_irq_mode	irq_mode;
+
 	enum dw_edma_request		request;
 	enum dw_edma_status		status;
 	u8				configured;
@@ -223,4 +225,15 @@ dw_edma_core_db_offset(struct dw_edma *dw)
 	return dw->core->db_offset(dw);
 }
 
+static inline bool
+dw_edma_core_ch_ignore_irq(struct dw_edma_chan *chan)
+{
+	struct dw_edma *dw = chan->dw;
+
+	if (dw->chip->flags & DW_EDMA_CHIP_LOCAL)
+		return chan->irq_mode == DW_EDMA_CH_IRQ_REMOTE;
+	else
+		return chan->irq_mode == DW_EDMA_CH_IRQ_LOCAL;
+}
+
 #endif /* _DW_EDMA_CORE_H */
diff --git a/drivers/dma/dw-edma/dw-edma-v0-core.c b/drivers/dma/dw-edma/dw-edma-v0-core.c
index 69e8279adec8..2e95da0d6fc2 100644
--- a/drivers/dma/dw-edma/dw-edma-v0-core.c
+++ b/drivers/dma/dw-edma/dw-edma-v0-core.c
@@ -256,8 +256,10 @@ dw_edma_v0_core_handle_int(struct dw_edma_irq *dw_irq, enum dw_edma_dir dir,
 	for_each_set_bit(pos, &val, total) {
 		chan = &dw->chan[pos + off];
 
-		dw_edma_v0_core_clear_done_int(chan);
-		done(chan);
+		if (!dw_edma_core_ch_ignore_irq(chan)) {
+			dw_edma_v0_core_clear_done_int(chan);
+			done(chan);
+		}
 
 		ret = IRQ_HANDLED;
 	}
@@ -267,8 +269,10 @@ dw_edma_v0_core_handle_int(struct dw_edma_irq *dw_irq, enum dw_edma_dir dir,
 	for_each_set_bit(pos, &val, total) {
 		chan = &dw->chan[pos + off];
 
-		dw_edma_v0_core_clear_abort_int(chan);
-		abort(chan);
+		if (!dw_edma_core_ch_ignore_irq(chan)) {
+			dw_edma_v0_core_clear_abort_int(chan);
+			abort(chan);
+		}
 
 		ret = IRQ_HANDLED;
 	}
@@ -331,7 +335,8 @@ static void dw_edma_v0_core_write_chunk(struct dw_edma_chunk *chunk)
 		j--;
 		if (!j) {
 			control |= DW_EDMA_V0_LIE;
-			if (!(chan->dw->chip->flags & DW_EDMA_CHIP_LOCAL))
+			if (!(chan->dw->chip->flags & DW_EDMA_CHIP_LOCAL) &&
+			    chan->irq_mode != DW_EDMA_CH_IRQ_LOCAL)
 				control |= DW_EDMA_V0_RIE;
 		}
 
@@ -407,10 +412,15 @@ static void dw_edma_v0_core_start(struct dw_edma_chunk *chunk, bool first)
 				break;
 			}
 		}
-		/* Interrupt unmask - done, abort */
+		/* Interrupt mask/unmask - done, abort */
 		tmp = GET_RW_32(dw, chan->dir, int_mask);
-		tmp &= ~FIELD_PREP(EDMA_V0_DONE_INT_MASK, BIT(chan->id));
-		tmp &= ~FIELD_PREP(EDMA_V0_ABORT_INT_MASK, BIT(chan->id));
+		if (chan->irq_mode == DW_EDMA_CH_IRQ_REMOTE) {
+			tmp |= FIELD_PREP(EDMA_V0_DONE_INT_MASK, BIT(chan->id));
+			tmp |= FIELD_PREP(EDMA_V0_ABORT_INT_MASK, BIT(chan->id));
+		} else {
+			tmp &= ~FIELD_PREP(EDMA_V0_DONE_INT_MASK, BIT(chan->id));
+			tmp &= ~FIELD_PREP(EDMA_V0_ABORT_INT_MASK, BIT(chan->id));
+		}
 		SET_RW_32(dw, chan->dir, int_mask, tmp);
 		/* Linked list error */
 		tmp = GET_RW_32(dw, chan->dir, linked_list_err_en);
diff --git a/include/linux/dma/edma.h b/include/linux/dma/edma.h
index 0b861e8d305e..e4a6302bd04c 100644
--- a/include/linux/dma/edma.h
+++ b/include/linux/dma/edma.h
@@ -60,6 +60,41 @@ enum dw_edma_chip_flags {
 	DW_EDMA_CHIP_LOCAL	= BIT(0),
 };
 
+/**
+ * enum dw_edma_ch_irq_mode - per-channel interrupt routing control
+ * @DW_EDMA_CH_IRQ_DEFAULT:   keep legacy behavior
+ * @DW_EDMA_CH_IRQ_LOCAL:     local interrupt only (edma_int[])
+ * @DW_EDMA_CH_IRQ_REMOTE:    remote interrupt only (IMWr/MSI),
+ *                            while masking local DONE/ABORT output.
+ *
+ * DesignWare EP eDMA can signal interrupts locally through the edma_int[]
+ * bus, and remotely using posted memory writes (IMWr) that may be
+ * interpreted as MSI/MSI-X by the RC.
+ *
+ * DMA_*_INT_MASK gates the local edma_int[] assertion, while there is no
+ * dedicated per-channel mask for IMWr generation. To request a remote-only
+ * interrupt, Synopsys recommends setting both LIE and RIE, and masking the
+ * local interrupt in DMA_*_INT_MASK (rather than relying on LIE=0/RIE=1).
+ * See the DesignWare endpoint databook 5.40a, Non Linked List Mode
+ * interrupt handling ("Hint").
+ */
+enum dw_edma_ch_irq_mode {
+	DW_EDMA_CH_IRQ_DEFAULT	= 0,
+	DW_EDMA_CH_IRQ_LOCAL,
+	DW_EDMA_CH_IRQ_REMOTE,
+};
+
+/**
+ * struct dw_edma_peripheral_config - dw-edma specific slave configuration
+ * @irq_mode: per-channel interrupt routing control.
+ *
+ * Pass this structure via dma_slave_config.peripheral_config and
+ * dma_slave_config.peripheral_size.
+ */
+struct dw_edma_peripheral_config {
+	enum dw_edma_ch_irq_mode irq_mode;
+};
+
 /**
  * struct dw_edma_chip - representation of DesignWare eDMA controller hardware
  * @dev:		 struct device of the eDMA controller
@@ -76,6 +111,8 @@ enum dw_edma_chip_flags {
  * @db_irq:		 Virtual IRQ dedicated to interrupt emulation
  * @db_offset:		 Offset from DMA register base
  * @mf:			 DMA register map format
+ * @default_irq_mode:	 default per-channel interrupt routing when client
+ *			 does not supply dw_edma_peripheral_config
  * @dw:			 struct dw_edma that is filled by dw_edma_probe()
  */
 struct dw_edma_chip {
@@ -105,6 +142,7 @@ struct dw_edma_chip {
 	int			chan_ids_rd[EDMA_MAX_RD_CH];
 
 	enum dw_edma_map_format	mf;
+	enum dw_edma_ch_irq_mode	default_irq_mode;
 
 	struct dw_edma		*dw;
 };
-- 
2.51.0


