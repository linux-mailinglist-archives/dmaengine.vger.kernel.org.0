Return-Path: <dmaengine+bounces-10053-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EIuzEEL75WmgpwEAu9opvQ
	(envelope-from <dmaengine+bounces-10053-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Mon, 20 Apr 2026 12:09:06 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 6655542936A
	for <lists+dmaengine@lfdr.de>; Mon, 20 Apr 2026 12:09:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2825F307BD45
	for <lists+dmaengine@lfdr.de>; Mon, 20 Apr 2026 10:06:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5E2A3932FC;
	Mon, 20 Apr 2026 10:06:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="NaBBUZDz"
X-Original-To: dmaengine@vger.kernel.org
Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazon11013026.outbound.protection.outlook.com [52.101.83.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AB95391E58;
	Mon, 20 Apr 2026 10:06:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.83.26
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776679615; cv=fail; b=JbJ5ZXnI+FvX93IlwvSUeJt/v7/aNvW0+dyUh2EwoP/8j6MEfokdoaN5b7NBBrfHL3PzaRjbtowPbbNKuJQafjxRWtCAeFbpv2LAFWtoXwa9pmx7TK94d320rOI55ebjXkutr8AH7jhyn1aUrPRpiGZuNeA2Wt3hpSrq6vGibjs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776679615; c=relaxed/simple;
	bh=8BkvjFi+GqFIB8r7J3YVILiJ36gx9jEwKI/qgNR160s=;
	h=From:To:Subject:Date:Message-Id:Content-Type:MIME-Version; b=VICPZTTm1OwAdlrTMz4rMdLUGJhA6Kw/KmCTEx0vkVjtzjE4XaoB5NVkwQaAt3Kx2Qve8XzB1cxKcuY/yeKYJh0pnQJfP5VpTEO3l0B7+KFK4gC7JDosSkk0VUaKIvNSRoSPa9Y75iVBi60IG86kLqlMdgaCnFKLLSAMs4wT//o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=NaBBUZDz; arc=fail smtp.client-ip=52.101.83.26
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=X65iScHUxDBzn6EAKR/nXwQ+j81HOZw6f2tvfSXocTCm/Dco3bP6Y1IjG8Ve7h19rFTvZBqLJ6Tn7mzEwKGV3UBsF4MnmVGzxhiHCvDbW0jtigHBhP9XvkI7cuos9qtmkZ8RrMsQeqX4Zo+5d1BbVvPqeh55pUcO1QytfUkhzNmPg2n0JNfHxluOWfc/jlxATWCpa4CgqCnG4Saf8pFUWTg337//fHTGLLsAOdsdGkcNFLVhhCn/ATbsI3Xzi5xyujZ2YJ4c02Erq6ZW1Ppg4KrQ/IsbGK+J10EVglgFuD4erfInZyi8nu8B5zWggT4Q85uq2WISEaBHeTelM9GyXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=X/iwnJVv3reJAXHirXo2xeiDddwF6fPZuxAT5DajGXY=;
 b=Iww0vZx5DiVjU225bRpt2bo6NCTSiyhxwqAOPKIi/XO7jph1mCNV7QCEEkdPTi4qREUepxqJ03fXs8T9/5pBEaIeukrInRvbPKmyciOqWmprltzyUwVAMOTcSsp2CoOhB9KGAJuN+YHvXo1icaZhOhTa65lg8xvVBChpkY63mowHKa4mEtFqQPhi5ETQEtMKF4LSoof/3AskWNIiPfrzxk8iM/rQLuqWMJF2ECgnv0HsV2c5r+qDYPCD+oyOBSIdGllIMRZWBfSBT5VmFWPqG7gxQXGgWbXizSZvO9ia0RoqSg+p/7UEjflP1UoHRQZIXDerCr2HLBSk8EaBju6CcQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=X/iwnJVv3reJAXHirXo2xeiDddwF6fPZuxAT5DajGXY=;
 b=NaBBUZDzzPaF0lVzKXdDuxyD0wwDnaqDJ0c4Kjehx+Jgz6LvnWEflCxCOMOrRnAXsYMi+t+1HAXr62MoKxKxBQgJVW/gx7VvCrfE8PIEyBZjnvE3AxFtsDMhmCjUVehG98KGBgNyC/Q+HDyN0Qzi5yJl58rJPzwaVIFaQCxzXdO9pfsEp+cBiI3+lcsppPK085c6oZCAzwTGqUg2KRkfWulfzYX1XYDAiDcpmnT9XsGNSTiQIRHi9dplp5ZDzGPkWz7K8On5E8YELvsUryrCVIt70XCQxuDpmQOCebts+lPuVS2IQaA26k7BeDDHZ8sg6kP3nASMGpTLmxJD8T+A/w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM0PR04MB7044.eurprd04.prod.outlook.com (2603:10a6:208:191::20)
 by VI2PR04MB11170.eurprd04.prod.outlook.com (2603:10a6:800:299::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9818.32; Mon, 20 Apr
 2026 10:06:49 +0000
Received: from AM0PR04MB7044.eurprd04.prod.outlook.com
 ([fe80::bab2:d15c:fcf8:ef2b]) by AM0PR04MB7044.eurprd04.prod.outlook.com
 ([fe80::bab2:d15c:fcf8:ef2b%4]) with mapi id 15.20.9818.032; Mon, 20 Apr 2026
 10:06:49 +0000
From: Shengjiu Wang <shengjiu.wang@nxp.com>
To: vkoul@kernel.org,
	Frank.Li@kernel.org,
	s.hauer@pengutronix.de,
	kernel@pengutronix.de,
	festevam@gmail.com,
	dmaengine@vger.kernel.org,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH V3] dmaengine: imx-sdma: Fix SPBA bus detection on multi-SPBA platforms
Date: Mon, 20 Apr 2026 18:08:54 +0800
Message-Id: <20260420100854.2095549-1-shengjiu.wang@nxp.com>
X-Mailer: git-send-email 2.37.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MAXP287CA0015.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a00:49::27) To AM0PR04MB7044.eurprd04.prod.outlook.com
 (2603:10a6:208:191::20)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM0PR04MB7044:EE_|VI2PR04MB11170:EE_
X-MS-Office365-Filtering-Correlation-Id: 4884be95-ed86-459a-c688-08de9ec48951
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|52116014|19092799006|366016|1800799024|38350700014|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	yjNW/IRMMOQsx10VHLHQ3MMzycq+I5uJi95oNMbrLXJJuAiNfWQxwRH4PUKF2e0pMUgYndc90Mw7Vlwq8NNLtRE3ap8XJ3L4g+OPLQ1Q56PRP+zdV0Bar+OiPbh3rDAhdR9wD0o/YOz3SVf59iSZJXDv/3uX/LuLXxOtoLu1xBb1PwI5ShaCxSq++8CDLdlUraDxe5ncvhW1lIPtJq1qVVrxvRrmYgTMVXI1rIYy3wCyLsc5DNE45BG8tJmwIsD7/f/6JLP08VWFno5gRP9UJZawppBkHhdrKIaoqdXRsa1QHkb0/PbSnLPdRmNhp2VZgx3GgLPcGiJhD2/OVXOtfC0v6tJIQUMc3RQXvBKe2mQv99DXbJg+wGAxXR7Jd3i9BV8QBzIlLysaqyaLVEXzYEJ6k5FgpqbO3E1CXYOIbfUonShtvGu6oDyZpLxpZpxJUixhdRu6/sHXw4I6sZrnsIc3hsUEb50s9uiC1G9aYiLhVkzMSzCxX+6bpw9gxTU8f7uVQbTG5ij3qq9v5mYq6dCcb53LcCTc45z0+ZzqVE4KEI3BddebeKf1amdoa2shxL5amLbWiNfkA7P0yYvFb027hWQN5ipRcSLzmxbsNo4U2/jKXFYPMta/sVIFcLutq6X9LD+68a1oH88x4O+aCBa8AfBzTDnUYvGqqLaSx9Mt6hUsk5bdqgmHkw6xD+hYbDAyKQCDPZff8xmcZp6OxRjd8Fb5GHcYnvNDngsaxdOVjgyXnVK4p+VKX8+XgfA45SyDf6QACeVbRqaCkYCkCpXcnZLsg7/rvHFCtEGvlX4=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR04MB7044.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(52116014)(19092799006)(366016)(1800799024)(38350700014)(18002099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?pquazhtG9UDFULrodZfwsqV/btmd9dsklhDCG7S99pxot/grnha5j6qF+HFx?=
 =?us-ascii?Q?jna4kVlW3hgWXw6a65136tTBwueM/78nJ3ACc8+l+ECr/C9JKrjzt4p1c9vM?=
 =?us-ascii?Q?CQ5C8e/NLxorMKlWGg8qHJAn1deXG3F49F+wvzRBCW6YOsphEK/dDiKDRGTp?=
 =?us-ascii?Q?CZ6fRX81c0w/kAkqW4ldDojIC8h49jIICq5H7LN1viOq6U4qnLRtnxaKNdyD?=
 =?us-ascii?Q?KLQPWMovDVPwcetXo1IGQRK83QJFA83ZOAjz9B/SsdF7WWusVDighIIvFUyd?=
 =?us-ascii?Q?9ylO8TG9pHHqi87UHl0Kx5/yqZbYKqUOsZidOz8WTq0nzSNWTCK3n5JwOYKu?=
 =?us-ascii?Q?vGtl7BlogqB7e/lkG4dtLpTE/EDfUMzIE6mMXMvUOwY3PIGqppwMFKy63G++?=
 =?us-ascii?Q?tp8iIryIxZMTgbTHN8wNNmY4q3EMdyLD4OvHTRZmOx43dJGCSoc2ND80o6sJ?=
 =?us-ascii?Q?iYSofKAc5MS+/imZEYlygiqXRUgq22kIWq/igOICKZbAQk3YbtGowB+u+P2x?=
 =?us-ascii?Q?SjrhyxB4qpPVvXEf2VDIRnS3T9CNNNDXCpQKZLep6GOytQtKtoZJiYPxOeKo?=
 =?us-ascii?Q?zK+9vnu9CCwbYSszpPPoX2uUHrKi+Nt4IV5Hhfkzl888MTNMvRWeZBqacGBd?=
 =?us-ascii?Q?nrMHrXgwbON60EcpHz2xrPk399wmgOzxs8fJmLDabOJCzCzEbWzus+/XHW7E?=
 =?us-ascii?Q?H374GD8JlrVZzkEvvIJscCirrc9zgV1MlzjbqM20/IVRh/fZqZvvJwg/eWWv?=
 =?us-ascii?Q?q7MsO/uxszRotPKigUW0YUB/+lF81563ZuLg8Xk3CMfozAM0PUoDIkab4lp9?=
 =?us-ascii?Q?nu6x2XKG3hYrVUh54aL//nkATYUveIeJAb7a5OLGVzvY3zz9qq+hMDTbpHoW?=
 =?us-ascii?Q?Ajse3Sr8gTqZlJbtdGxVTx5Txf8mvm576q9WGUntTJ/hv/nXArXUSjwMdR0j?=
 =?us-ascii?Q?/QG6SR5Ls+lHEvFpJ1XZaGnmb9XDmRZK1mQvjukVel5tBOqljE4b4vqd+7Dg?=
 =?us-ascii?Q?534xwHO35q1L2Omtk1XYwAYsqCHn60fcJ7fo9fC+Fo0Ij49trx4ViKHy6FFZ?=
 =?us-ascii?Q?LwhigYVb8079n5UB6p9STAdu9BJ5A/iMXRkGx2kmfYN/thnNvdEQ/Xs8UCKd?=
 =?us-ascii?Q?hc2K7P/oDpX2MLqo6ob5i+cZ3TRoyKf+3ZUOv5Bt2FoO4XlxsKXEm8+VZdeL?=
 =?us-ascii?Q?imkfnSNU7z9lhkXaAdf7f/K6US/++h/7L8r3iaj9IkS3vWJhCnQjqRI03wg7?=
 =?us-ascii?Q?tL6GyAVoHCRhWZoknpWpbiytXSd1iPLVaw3eEg8CV8t614TIICsZQn5H8Bgq?=
 =?us-ascii?Q?GIDyGwNsEhN4tV7r//O/AwdgYdIXuA3oxcKzwPBWg1fL1HY8rVzaQWWcVfjT?=
 =?us-ascii?Q?0njdx+v2P+JoYI2HudCvCcaoAtuh9Al1popB6b8xOIRxUPZR6Q9B4WjEzDj5?=
 =?us-ascii?Q?bJYI2XE4W9Y/NRGnf7r1My5Mqbt6SCi8/cFLvbcXcaRsbWatMsjt1jaS4Sc3?=
 =?us-ascii?Q?+luTavZMX3IghU3ZFR8E/dPUPhLpl0b8q8NNK9nRPUDrcYuaLViw+4L3VRnt?=
 =?us-ascii?Q?op08+ehqqzbLb1h6kjaVRbxWmc7oVK9ik6WNPWCbHupu0WcODMotOkLPwHUK?=
 =?us-ascii?Q?fZ0sz8V7lQwfIeC3nDelJurNTMOiLfAE45XkXLSVkzvlrTSB2KJvv7x0oAG+?=
 =?us-ascii?Q?eqrHXfIlTaF+DFxoE0dFb4vZAeZ23/pPq4USlBS+XGEc4Btb6IBsi7L6Nk3F?=
 =?us-ascii?Q?DM6ywAwQOA=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4884be95-ed86-459a-c688-08de9ec48951
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB7044.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Apr 2026 10:06:49.0172
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: X2tTA7R/QaRzm4iYi9VnPmKqTCT0skT5sNJmLzGPak/vNYZpn1P+nR5PDMkAqRo61TbfZ9s7JY8EFL+TTqPpHQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI2PR04MB11170
X-Spamd-Result: default: False [1.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nxp.com,none];
	R_DKIM_ALLOW(-0.20)[nxp.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_NEQ_ENVFROM(0.00)[shengjiu.wang@nxp.com,dmaengine@vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-10053-lists,dmaengine=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[kernel.org,pengutronix.de,gmail.com,vger.kernel.org,lists.linux.dev,lists.infradead.org];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	DKIM_TRACE(0.00)[nxp.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[dmaengine];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,sashiko.dev:url,nxp.com:email,nxp.com:dkim,nxp.com:mid]
X-Rspamd-Queue-Id: 6655542936A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

i.MX8M platforms have multiple SPBA buses under different AIPS buses.
The current code searches the entire device tree and returns the first
SPBA bus found, which may not be under the same AIPS bus as the SDMA
controller.

This breaks SDMA P2P transfers because the SDMA script needs to know
if peripherals are on SPBA or AIPS to configure watermark levels
correctly. Using the wrong SPBA bus causes DMA timeouts and transfer
failures.

Fix by searching for the SPBA bus under the SDMA's parent node (AIPS)
first, then falling back to a global search for backward compatibility.

Example device tree showing the issue:
  aips1 {
    spba1 { sai@...; };      /* Correct SPBA for sdma1 */
    sdma1@...;
  };
  aips2 {
    spba2 { uart@...; };     /* Wrong SPBA - found first by old code */
  };

Fixes: 8391ecf465ec ("dmaengine: imx-sdma: Add device to device support")
Cc: stable@vger.kernel.org
Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
---
changs in v3:
- add fallback to a global search for backward compatibility, which is
  to address comments from sashiko.dev
- update commit subject and commit message
- add comments in code.
- add Cc stable tag
- Don't add Frank's RB on v2 as there are several other changes.

changes in v2:
- add fixes tag
- use __free(device_node) for auto release. 

 drivers/dma/imx-sdma.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/drivers/dma/imx-sdma.c b/drivers/dma/imx-sdma.c
index 3d527883776b..592705af2319 100644
--- a/drivers/dma/imx-sdma.c
+++ b/drivers/dma/imx-sdma.c
@@ -2364,7 +2364,18 @@ static int sdma_probe(struct platform_device *pdev)
 			return dev_err_probe(&pdev->dev, ret,
 					     "failed to register controller\n");
 
-		spba_bus = of_find_compatible_node(NULL, NULL, "fsl,spba-bus");
+		/*
+		 * On i.MX8M platforms with multiple SPBA buses, we need to find
+		 * the SPBA bus that's under the same AIPS bus as this SDMA controller.
+		 * First check the SDMA's parent (AIPS bus) for a child SPBA bus.
+		 * If not found, fall back to searching the entire device tree for
+		 * backward compatibility with older platforms.
+		 */
+		struct device_node *sdma_parent_np __free(device_node) = of_get_parent(np);
+
+		spba_bus = of_get_compatible_child(sdma_parent_np, "fsl,spba-bus");
+		if (!spba_bus)
+			spba_bus = of_find_compatible_node(NULL, NULL, "fsl,spba-bus");
 		ret = of_address_to_resource(spba_bus, 0, &spba_res);
 		if (!ret) {
 			sdma->spba_start_addr = spba_res.start;
-- 
2.34.1


