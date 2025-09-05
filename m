Return-Path: <dmaengine+bounces-6396-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A9847B45ACC
	for <lists+dmaengine@lfdr.de>; Fri,  5 Sep 2025 16:45:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ECA957C2409
	for <lists+dmaengine@lfdr.de>; Fri,  5 Sep 2025 14:45:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADCC437289C;
	Fri,  5 Sep 2025 14:45:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b="r9T3Jddi"
X-Original-To: dmaengine@vger.kernel.org
Received: from TY3P286CU002.outbound.protection.outlook.com (mail-japaneastazon11010017.outbound.protection.outlook.com [52.101.229.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68A11371EB2;
	Fri,  5 Sep 2025 14:45:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.229.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757083505; cv=fail; b=nEzlAkbaIextIZ3Cs/1Jkw6WXGKGh8ZWQpIlBNjoenjqTrskhMlFvTme8gfbiZsmgqWbXVXoQyUMp7XHkeJ9fyG/F1MDH7w7IabSmx6RzeAuHfq98S/3TwYQsGwwrPBc780Zlc6ziNQfx0QJQOE82A/LjuVgMBRbRCErg816IIo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757083505; c=relaxed/simple;
	bh=s83hlkdGruIIIZoiMepUksl/2AHe6DlQTrzcjuLYbto=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=GwrRMm0RWefS+/p1/145MbGwxhRr5z7NYPgYueqclmCdob5oi3qhL0zN5b7JqY2e/Xy6fcNF2qBkCJBaTChUMRSMZR/JDEsj9hxqZgUxaPj+RNz9ZWe5v9af195e0Us8ISUWdOdUEvWcC+PkHuDtMSgMZrCTG/IL9QOf1gMByx8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com; spf=pass smtp.mailfrom=bp.renesas.com; dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b=r9T3Jddi; arc=fail smtp.client-ip=52.101.229.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bp.renesas.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KG8MlUrkdNBWmvWyXkn/uTpNthIvLrDjysaJxoGJYLu4LZYZJL4zksRFTDAlKZ+hVc++rb4+lxXq+eMqT1jG6/o/3u7Z9MIK5d64gxqqLbZvX7R48i8GTh+zW7ebjSJQK5QKZf69bjzZ3A/Z8B+3wM6Mbd5pSPXCvElTgrd8+wkDS4JMI8s9Pb5yx7a99E3/ByM6nhPqKXLhE4cfzqlsVcku1w1ig4xa5Gz0JLIkMe4XpaK3xRKQpLyZmadUNc1W7ZFU0sLEm2A3Bu9RwS0q9Xd0Ujj0ziy5LwstB0RBFlOdGuLKbWJCLqYmctvASZIfwqJNCb6FbKVt/+/PMg2Khw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MrPKFRMVxvxYMQE+KegB2gxLRRyD9H2Uxsh+5WgW4ps=;
 b=ahqZMYQoOXvBKAvXbBmtJ5S0djjtwhwJWliZsm/Sz0kRKFjJs+wOOw2q/BMrK9pBe+ge/nZYZ/0DOenJGHcxpXlptr4JxIGzzbLiq7DrL3k6ch4W3vNbuomHt9+6vmaZ4hJ2mnEHCWwmylIciis2H0JwLUp9l0wqWkWqbTZpauWHOSxzJ/2j2cwZOZ2+HI+PxYGSnMKN63AuMtuGhbXsrEvByPcDQNt4TyXFHdtXfEu3UplREeD02cVX/q1VyHG3Qsras8YTUoC3K18Hn10Ike7sG7OMCXctLI+2DaWyp8WSbDs56MtN8zzUiE2Oj3kqmaWayab9CBtDrkisC+7Ecw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MrPKFRMVxvxYMQE+KegB2gxLRRyD9H2Uxsh+5WgW4ps=;
 b=r9T3Jddilr1qTnKNeu7BGkpOqUXzsU97e+zAUnNl8mggiClkqwwa5ZWUrccOQti0j46RheCsVkQ11iLSDuV7/Pb9aUlOxNCYXkHVCSp6VFKWfdljiQJjVcd/if9GTijeZpjS4Ck7bWsV/cP8iv/GZhX4LIRVo3b4yF78g6fhbZs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
Received: from TYCPR01MB11947.jpnprd01.prod.outlook.com (2603:1096:400:3e1::6)
 by OS9PR01MB14067.jpnprd01.prod.outlook.com (2603:1096:604:364::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.19; Fri, 5 Sep
 2025 14:45:00 +0000
Received: from TYCPR01MB11947.jpnprd01.prod.outlook.com
 ([fe80::63d8:fff3:8390:8d31]) by TYCPR01MB11947.jpnprd01.prod.outlook.com
 ([fe80::63d8:fff3:8390:8d31%5]) with mapi id 15.20.9094.016; Fri, 5 Sep 2025
 14:44:55 +0000
From: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
To: tomm.merciai@gmail.com
Cc: linux-renesas-soc@vger.kernel.org,
	biju.das.jz@bp.renesas.com,
	Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>,
	Vinod Koul <vkoul@kernel.org>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Wolfram Sang <wsa+renesas@sang-engineering.com>,
	Fabrizio Castro <fabrizio.castro.jz@renesas.com>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>,
	dmaengine@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 0/4] dmaengine: sh: rz-dmac: Add system sleep PM support
Date: Fri,  5 Sep 2025 16:44:16 +0200
Message-ID: <20250905144427.1840684-1-tommaso.merciai.xr@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR4P281CA0420.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:d0::17) To TYCPR01MB11947.jpnprd01.prod.outlook.com
 (2603:1096:400:3e1::6)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYCPR01MB11947:EE_|OS9PR01MB14067:EE_
X-MS-Office365-Filtering-Correlation-Id: 7f8b82c7-eb07-4a2d-4d73-08ddec8ac71e
X-LD-Processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|52116014|376014|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?eul+8vQSmhoMVPyQX7lMieR8Hj1nZn+MGbA8onG6U/HoL5ngX3eovPCg3XI1?=
 =?us-ascii?Q?d15kLrWI1pqhYFh1haUZJV97er4thOMdvRDHl+9G61jM1+1zAZgD5rOY7rr0?=
 =?us-ascii?Q?PHmR/yqUJiAh+a4r8kNuqjzcd2RVPaMQNCrtQbroeosoNCN2RcHZITHFTaRZ?=
 =?us-ascii?Q?tZRKjOkK+nNvXK6EPtDsloyYa8Jp1BmCfKav3ut9uwgzEtPqgFPYz24GfAmF?=
 =?us-ascii?Q?NbG6VlIAjGIbiK9SRA9emD/zs8EOYmyPIeyKOTYG9Vr/BekINk8RpfvNU6f5?=
 =?us-ascii?Q?q1TN6tiOvCwSjA6xHIL+DTbwuLvsg618DLtGgQLHFSKS5Nv2HBdnw5qhWWq+?=
 =?us-ascii?Q?eNnOveK5VFZYeSUqcRaj/7XhQ7KHoEPskpdFgcFTaEWzam1OWHDje1CCH/J2?=
 =?us-ascii?Q?vLH7/tk4DbpdiCmlewJ7WiHhyVxIfmax6CQ/xMJYHLXRhWy0ascpF16qXNbS?=
 =?us-ascii?Q?PobiI6zFjcwlQjmIHxBW8Rf7FUrOYXy7QZbrxePCJgtkidrsdxTOFE5PSE6W?=
 =?us-ascii?Q?6cn/7UwePge5xs8Sm/t0mjDOnr1m06/QYe6EHeuNWvAQrcsxOZ3ZePSEE1Mv?=
 =?us-ascii?Q?YAh82Ru6BS/RtC+FodaB1D+9QUKUnoHZlxBu/XtxV5ObNSoe8S2nk59BeCTF?=
 =?us-ascii?Q?NXvAVuHNXpE1xRHsOJ4H7CqulOTawY/x/tvI/xmBK1Mrr6PP96yzxrxqlNkT?=
 =?us-ascii?Q?K7Yf4Yyw7mFk5lg0S4UXHYAFmWnfOS2+5x+MfyzI3VzAJrVWFeg/fNYOo9Yd?=
 =?us-ascii?Q?EdZAi7QrZFIQQ3Wzs3cSlut4QOMmKr9t9230IPX3gD+fLkDqwk4pHw5J9KM5?=
 =?us-ascii?Q?JoV29KhoEG++9uORXf1MwvP4YdkwOXuE46E8YayWzQI4XJbLWZ5oSk9rcdZH?=
 =?us-ascii?Q?K3OicLxQpMMhWcdQUS4CgBQJBSHc6fhImx2juEZNMKKT8G6OsvdeEJfKlMrl?=
 =?us-ascii?Q?W+GilgDLPDiRiYznSnkI6f2TfywSdcmNwuaNX+C57wRq27OO54i+kNDoJDx0?=
 =?us-ascii?Q?4W0DLwK81Ek9zx0aLAU1aMY5SKQ0E3mYvVNrR8RMZGz++CKO8FLl01L6yoeM?=
 =?us-ascii?Q?Mnwe1jKS0/GM+4fCU7C7PSAcJV37/ZfG2bLggp+fPReR2BldmkNdl4MnNHVa?=
 =?us-ascii?Q?ENMRxP/a9l+dl/PTbOiFBMDOPBIEIINmO9umlmcwe03POMl42Pw3Bkxrvv90?=
 =?us-ascii?Q?39804pKCmcsDCivDs+Q4xo2u9XEPdRzDCOhaHMmJlBClQLoAYEqtgmg0B5bn?=
 =?us-ascii?Q?xKREKPS/1OSUlNiFr7cw70E3a15XI06YTsBOGZiGzP0lmzIvhZCI7U2cmuXk?=
 =?us-ascii?Q?sT9bzeYa0tOkI9yId9lNSgUj/0yOTTYMiYXpAfECugY7MVOU0794hkpcy1C1?=
 =?us-ascii?Q?G5cCF1YcgKPHP4/lMd9I4jfOJg2/pLX2ox8wcfF003weWlA3Nkv2/d9ldtxd?=
 =?us-ascii?Q?6mxXpXpmwMHO3vuf5O48Zw544Ww4Ve/+wruRK/vnZFnduKJ8aMDOrg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYCPR01MB11947.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(52116014)(376014)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?RsbTlHdk4uvBqOutQjAnfEdzdq33FWNFi383schdzNiSiOkIMX90aZbiRsFv?=
 =?us-ascii?Q?0UMEH7r7u4rn4PENWmHnNOUYnAf1QgSBbPFqU0JEIxmLr3QXx8IzGqbDpSkn?=
 =?us-ascii?Q?kDBCx84dv1ClTiUc1pyhQtz+EKJWg9VgqqbzPnfFSjBQxWGfbHr4cxk+hsDu?=
 =?us-ascii?Q?H1tdh9CeZIf3nEpapkTD7bJjeT9vv7nIzpOg5RBJ9yyn610dTzoFLDixrRLh?=
 =?us-ascii?Q?8TugzNGqEr3n3JGjsjDxr3MCPih9VKeg2K6kxkmqYJslN6Qu0om3pQONEZrt?=
 =?us-ascii?Q?cOtNxiVlq5yeSpNd39LkKgDqwJHpw2YmxX4WDUdqewi1Y2TW/LhbX63gxnKl?=
 =?us-ascii?Q?mKzw/DGFDAuok4Sn0EtVTeKa4ByAYePlzbCYCrB1gCKRtapbF0nYM1SKIjLf?=
 =?us-ascii?Q?ANTnvkd9buBd77QXdo8sPE0j3U4m+JFTkEXRgiz4qOzpDe03vVePeVEbXpoM?=
 =?us-ascii?Q?+DpNHNdV4zpLvsIw4uAssmSA6xMuliiEEwz2vpuFPjHEWAx5OD/6jqtPOhy+?=
 =?us-ascii?Q?kV4QHb4UeIbcak28ZzyQdqBNlTowK1ioVIC8Js/P53ZDndnuyhG/0IJ7wkog?=
 =?us-ascii?Q?6SVEww6DtqZ0V1q+NNWX/WM0XOfViAjSg1ImZFTqzoc5Asmh2e/ggno1vLL/?=
 =?us-ascii?Q?1A69O4jUOYzKbN5J2f0juPf4gBvI+xGf0GvfwaeXn4imwDf33o4N743Lp3B5?=
 =?us-ascii?Q?z6+Pps9v9Zh7IGHfdZRn9AiHeX8E1mizJBfgjnl4tRXQIqm0nP3TjCu60j6a?=
 =?us-ascii?Q?eQuHy/JY5+t1ICdTJqcF2PP34gSoTMxG0a/7f6t3WXvEpwPSqtmYOLOXRpZ4?=
 =?us-ascii?Q?+ONwlPvhmOiDuTdWVu9HZbCLfc9KJSuwv4l2HcGPWbAJ94CxBjIwHXi8WR2b?=
 =?us-ascii?Q?rJUedPfkI1GGdrCKmAjix0zRdGbzTy+yG0vhRFn6ihjEP8CLRj7Txu8A8gHf?=
 =?us-ascii?Q?wC4InLS3ON9QcYIEAaHDB2qBWuBNfYzrL06Wjl0wv+eZRAHhQB99LIJY8lG3?=
 =?us-ascii?Q?3ssQ8FTLPTX9pPLp4Bg3LysTfx1MhINPQoCXuOCYivgw2HYmTSX5xYwSUkkA?=
 =?us-ascii?Q?akPivCN1LAuyjf+1nmRgDLAR3oLRFvm7xg74qb4QACvf5zfFKUJ+WKX9vQzK?=
 =?us-ascii?Q?IoD3O9ksFnwUApbu1/rNqzf3ZmiixKLrmOMEiaeTHgKA09VI2/hyaxg3ASKh?=
 =?us-ascii?Q?w3036mCR7PwR8xD4mqa3ebB1IKTlEveUUUhlUdvzuH5IlYOmsmTQjVVd+A1f?=
 =?us-ascii?Q?eSu8yrL/OFsFEPOr9hYlqggLvJRYUxzld3rlgejajbZXl9xGQ8kQdWTDwOpT?=
 =?us-ascii?Q?K1a4Dzi7IN3+8Rvj9UxoEG+3QY2y6mYt811WJuX/wi7dO2cLXP3GGYv556AX?=
 =?us-ascii?Q?h6OypQVdvXsdKJxOyAvm9YvzRGYzK52DtIQgNtkD8Dp4f7x8tLRi3DJ9tPEg?=
 =?us-ascii?Q?LbcDWBhNezBsbJGxHwU72giSx7TbDR4q9Y8LAVEtAJMLMQdhaEUhzENEfh0g?=
 =?us-ascii?Q?eRI/nzhygZdMHxdsTOpCq3Gt1jkwzP+/ruokya1nSYx/mQZ/203rf8U75s4J?=
 =?us-ascii?Q?3qm/byPHQ4T60b5bUbE/Mkvi8VJL16OTx7p7QAYXkdjzfAFnG8UUYtVyiQDH?=
 =?us-ascii?Q?oXEyxJ2XR9GidWN3IMBYCeM=3D?=
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7f8b82c7-eb07-4a2d-4d73-08ddec8ac71e
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB11947.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Sep 2025 14:44:55.0558
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Nn+YcRBWqBnilYKVuh+7pL6kQ+yV9OeVq3cQ0MWUM0NIM5zdbLahohlWIAJ6Jz7ArL5zKIvwuExxlPfJrq+ipwzpoaplyfL3gn3lyx0AFcP4sLczinlCA3/t8IYUYLCu
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS9PR01MB14067

Dear All,

This patch series improves runtime PM support and adds system sleep PM ops for
supporting deep sleep in the rz-dmac driver.

It also refactors the driver to use the newly added devm_pm_runtime_enable()
and rz_dmac_reset_control_assert() functions for reset cleanup handling.

Thanks & Regards,
Tommaso

Tommaso Merciai (4):
  dmaengine: sh: rz-dmac: Use devm_pm_runtime_enable()
  dmaengine: sh: rz-dmac: Use devm_add_action_or_reset()
  dmaengine: sh: rz-dmac: Refactor runtime PM handling
  dmaengine: sh: rz-dmac: Add system sleep power management

 drivers/dma/sh/rz-dmac.c | 82 ++++++++++++++++++++++++++++++++++------
 1 file changed, 70 insertions(+), 12 deletions(-)

-- 
2.43.0


