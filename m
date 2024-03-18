Return-Path: <dmaengine+bounces-1428-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 577AF87F175
	for <lists+dmaengine@lfdr.de>; Mon, 18 Mar 2024 21:46:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8C672B22F5A
	for <lists+dmaengine@lfdr.de>; Mon, 18 Mar 2024 20:46:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5752F59171;
	Mon, 18 Mar 2024 20:45:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="EBSKJmgm"
X-Original-To: dmaengine@vger.kernel.org
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2099.outbound.protection.outlook.com [40.107.21.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7316A59159;
	Mon, 18 Mar 2024 20:45:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.99
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710794728; cv=fail; b=P2ThS7o4YirHqpW3/a0aUB1/9MNFHoLqJTH3ZNATz2P5hARMHtyc4RLYWR+5a4yscVS+N9fMOzf82SV7Nkklpd3rn4FIJZ9kuk4LM5IdVFLIEQw5GEQiDyoSkAlSEY2IJXK4HC1moiezx33toY3wExSltygOZldthpQBAwlrOxk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710794728; c=relaxed/simple;
	bh=YxPotRKKsv7AMML7UR0EJ+molezhbRr6Jj7xbU0leI8=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=VjLjPXiuz5Zl7U85BG/HrFwQWwRGTeBtsZLgVWDGiA1Ubi/VC5MZaEkmejHGbtqr8lqtPan46wBOKH97ug71bUPdy2sMqaeYE1a6m31YzL4uS0iQnvgm4yzxHroVfsPrTUmskGWmwDr6wzrWLPiy+AmYfzjnQb6Wu1ly7RZgZ7Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=EBSKJmgm; arc=fail smtp.client-ip=40.107.21.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NbdyfwNZKrMVb7XkiBoYXL/6K/4yMok6pWS8FWJEbh41afcNQE3+/m8z+WMLMSRS7VjTkyO6io9KWEPCWoMekvp8IYvRQPeSJrdnWMPzVoxjeSTiu68flZ+lcrFNB2iwJvV680VKMciLMSmgYKPYuoDuhL3dfmFvY5gL3fCmX2ebDMFB+3qI3/rog3d1X3pW7roUzCbYWnDkEsd9ODsLj2griBa4gBDxLjjS3pkRGL5+DwWahFNGGfqvHAQQEhAmKj/ss9Bm4f9t+GtFSKDACzQE1/LckSeTzLZkONPsKYighpNaPbGkEcLtpqGbWFYBNGPkAp29mjS+D6R0aZso1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HNipCopR1actSPpQ2YFnLhWfTN7OElPPaWSFF7H3oS0=;
 b=nyddvvkVegIaLFINc1XZ6I8i6N1KQEBGQSzdXTT8sg648SVN8aoQFktCLA5g/D/y9TseXoFTmE9EXjnXV1xlJfvsFlTf8rjY3guimp04dIHDZyDrFqLTbBZC0kvi6sO97qQh9cwYhC6v2pkEE2n7jbxvseTprvNhGLX5MzC3/7v4XGmnC1cFX5XZaRUVOjfApCGaUgj78Lrw5C6apMhY6iNa4iQ283Qj4Yu8wEqyeuGp4nXqTifgya6mzjQLBLSDYnNtDUQ5dCxbE566AjEPLtUFjaPx6EXvjHcIR54TJUe2crtPW5YY9Tu1C2OqqadguH3ph9xSegp9p8pq/64kPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HNipCopR1actSPpQ2YFnLhWfTN7OElPPaWSFF7H3oS0=;
 b=EBSKJmgmx1PJljPOS672tcE+FbXfp4MWYy6ggm5a0RPkvWc9qhTTPRxTIfHjaWT8AEQdauL6mM2BiTzMMF2Bpnzc8ySw5iS5bdLvA1eUYiMOxc//FsfFhd9+E4L9SuCyYaVM8w9m34WZKg7Hj4g95nosShkmGMNnWnri2fpnJOY=
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by PAXPR04MB8489.eurprd04.prod.outlook.com (2603:10a6:102:1dd::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.26; Mon, 18 Mar
 2024 20:45:23 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::3168:91:27c6:edf6]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::3168:91:27c6:edf6%3]) with mapi id 15.20.7386.025; Mon, 18 Mar 2024
 20:45:23 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Mon, 18 Mar 2024 16:44:36 -0400
Subject: [PATCH v3 3/5] dmaengine: imx-sdma: Add multi fifo for DEV_TO_DEV
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240318-sdma_upstream-v3-3-da37ddd44d49@nxp.com>
References: <20240318-sdma_upstream-v3-0-da37ddd44d49@nxp.com>
In-Reply-To: <20240318-sdma_upstream-v3-0-da37ddd44d49@nxp.com>
To: Vinod Koul <vkoul@kernel.org>, Shawn Guo <shawnguo@kernel.org>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>, NXP Linux Team <linux-imx@nxp.com>, 
 Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, Joy Zou <joy.zou@nxp.com>
Cc: dmaengine@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
 imx@lists.linux.dev, Frank Li <Frank.Li@nxp.com>, 
 Daniel Baluta <daniel.baluta@nxp.com>
X-Mailer: b4 0.13-dev-c87ef
X-Developer-Signature: v=1; a=ed25519-sha256; t=1710794703; l=1314;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=lYqK9q+URTn4zwdOYmJPQcGPKoeaMuMJQOuUDFYyhpU=;
 b=lGMlST7w/y6ohbh3HoCCrBYEBvipttomZdbpYWvFnpKPDZToJ8UHRPSGt+/ohqNJwMVNZxCpp
 H8BCnNQ4EdFDOyiXTWulWp1wz8Ok0h8JLp7WvFI7LS2BohY5AUwBT/1
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: SJ0P220CA0005.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:a03:41b::12) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|PAXPR04MB8489:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	HXit8dBumSNJCRywOUT6XllQpYiLk/8Ok4bFofR7+dkMvyHYeqpjZ3m0JrqV+tApuhKkg7ANQHNbJ5loaKCOv2c3dc/MGpNAdXOIBBYHmDppIKeOKRGxsqRkhp+6dfQtRgJKpeiSVcgXYBo6IOUsSBEOl/YXpH2RN6HMFjsY054l/8D03MMLJ8Z6KAz4LnvnSaNWZG1Yc07Ki8o6Hh/aG2cYbmLMf67UjIilo0qt+88ixrDa/DdR5tHUYJUeJYlgkxXO5hNMMkz5vjEAD6IubRjnsVb+MWCxpLzJKbJJyoHCz18rJ3Z2McXGcCgXxRS83HEvWHqlkdiJZNrbjYcZ99oqOSgOG7Wz5T1Gdi+oUV78MKtzB4IgBd9LwHiGXzjEjxD1UAZ0t5HXK+OLVEb/dK0tInypjP6vDPHpuqRGdf/Mai2mYTfE0dzpMf7c0wmhPOmzFYFFG8cOQvltQkCaYfWKS5bxRpI5mdqNgkHjM+bqmOYtuIBnneY4amlnpaRnBCo4MCqXibY+qxr2Us/uciGsINNwQ3sGbw/IY/oXb6kjFMQ8gcYFNiG++crmMnte04cGZtghOlrJa8zVpGKn+MD2f1Fw2TDYuNo8c71EkfI72hzDQPsFpz/lO+IxkaAsBAP9/F19PVvxWrFC9q7fpt1fcjWr056if3F9R20bJ9uRiCRtmjpkFgxzZeyfTZjxUKLCcMlld2MzTXV6l4kExeFILNsphXC680W0vvuEEfM=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(366007)(7416005)(52116005)(1800799015)(38350700005)(921011);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ajhWUWU3K2NVeWZsR3BBQXZ6aEN0M0E4c2VLbVdObUJVTVZxc3N0SnI5eSt6?=
 =?utf-8?B?blNVZ2kwcjNwSmxkQVZ4dytwdE1rWEpiVi9kZlpJeEUyaU1TeDZuaDZkbGFU?=
 =?utf-8?B?ZGx1NFhCZHlXWGw4UkV5WmliYVVhd0p3a3ZhKzMreTBZWmxjdGhoQjFYb1BZ?=
 =?utf-8?B?RVpNWStnZ3ZTb1lZcjF0ekU3MVV5NnVlV25mYUs3ZDdoTGFMWEFTUEZ5eFdH?=
 =?utf-8?B?a2VEbkNRZUtMVExrSFMveFRpZGFhellWT2lhQUw4eUFVdm0xeTh0M0ZMdHA4?=
 =?utf-8?B?NWNaYktuTWRDRHNKZldHaWZ6Q0wxRGZQUy9sYTVGTUkwMHhWc1QrYlVIMTFK?=
 =?utf-8?B?OUNJMGNRcWNJMHdXRWMybGd3cUFjNURSNENwZjhvY0k0L0hReG1qTXlaMGlF?=
 =?utf-8?B?eU1vRm9wRTdxL2ZXdmpCNzhWTXpFZEl1T21TU1V4TEFGRW42TlpMam5NWUFa?=
 =?utf-8?B?QjVPNEg3QkpSMU5sb3JPVGVPM1U3bDVmWG5XVE1mT0RRSHg2bXJlUlQ3WTBr?=
 =?utf-8?B?UkFjbFd4aDc0L05hNWROdnhadWhmL1ZxbjM0KzN5YlJXcHN6TmJFSDFnSys4?=
 =?utf-8?B?alVFclozVVUxbm94aEJucm41cllyZzJZQTBqM2lZR1RGbVZMeU9UVTYzTk1P?=
 =?utf-8?B?UHg1QXIveDhraXJvN1JNd3BkRWVwNitlU3lWQUV5K1ZUdHlHc1ZJS2srekZR?=
 =?utf-8?B?eGJJbThnWVVRV2ZYZFM2alAyN0FXamtQRk4vL0ZMR0hlTGFtc2ppQzQ1U25s?=
 =?utf-8?B?NlU5TGlMS2FvSVpLMENEUEQ2bEhhVGNiOFNvbXU3eTcrUmd1SFFGdmtjRTJK?=
 =?utf-8?B?VXg2d2g1WEpVYW9Ca3d3Nk9DeHVvWXpwd3BJWmN5UkY3K2xMbzVHam1jeXB6?=
 =?utf-8?B?VDkzbU51OWd5YW5aamtlNFhQNDhtM0drc0tuY3VWQ2lpSjNQdkVuT3paQzh6?=
 =?utf-8?B?eHR1ZmhsaEQ2M0Jwbk5uSGI1M2lDRlNsZVRZaVQ3eWFPM053L2d2a3VNUUtW?=
 =?utf-8?B?bktnTTR3THRUd0UzLzJRS1RxeEhscDBFMzBYSkpaeEdnbUlNUlM0K2FJQUxT?=
 =?utf-8?B?NFhkRk9uZ2lReDdsZ1l0UUdveHBkZzlYVjYzaGlucnhVeVVGeGd1SWQzZXJM?=
 =?utf-8?B?dFNMSGZicFJQenBBelpHdWRBSGFsT2tNMnQ0R3p0NHJpRHAxREhPR0xvcTdL?=
 =?utf-8?B?clFrMnFqNGpvOUtNcDZrNk02bWlDZTk0eEd2aW04NjBGNFBELzRPS3ZacmVh?=
 =?utf-8?B?bVk2UjFrT0dsaE1iRlQzRDFWYjdqc1gyWXozdXZJRDJ5ckt5ZGMzQ0RUSmRR?=
 =?utf-8?B?TjlCK0RXTTZmejFxV2JFeG1RL09SNTA5bjBvTlNkeEI1ZnhyOTQyTlBVdjJC?=
 =?utf-8?B?Sy9PZk0zNXJoVDh5NHZMSXJhTTMvM0RnTmpFd2JoTWhjR2llZUxZU3poWUsw?=
 =?utf-8?B?WitQK01JUDIrdDBRKzIyZ3pSbXZTanhSVzMwS2dmSVdBakgwT1E4YUpMdlFB?=
 =?utf-8?B?bFJrbU5vRjhZTGJIUk5yWjdUeWs5UDJYaVhqSm5zdmhIb290NzBVbmZsK2Nr?=
 =?utf-8?B?bS8ySXh0S2JpaEFjbkVhT1dyRXR1eGV5dU9kMVBkemkrRFNwUnNKd0FXNlJo?=
 =?utf-8?B?eFNQbzhhTmJwN0VzSEo5eXZWSUtGbnBOWW00dHUxZ2NrUDNDT0U4VXA4TDZW?=
 =?utf-8?B?TmJ6dTMwMWJHckFPenVMZ1lmekQ4YWxBNzlRT09FMVFOcWNlU2VZWVdsbWtT?=
 =?utf-8?B?MXBIVVZQcWRWeVJzemk5VmRzcUROMXJwK0Y1VEYyNnpmSmtzU2xCZTl1WE1C?=
 =?utf-8?B?QVU1RW9JOXRoSUpVcTlhUHJiaGcxRmJCdzNndHdFUHprZjRWenYyQit5Ylph?=
 =?utf-8?B?ZWwvN1NVWjhvMVhqM3hTRjNyZEF4MVg0T1d4UVRyT25BSXhQd3h5d3k4QXpu?=
 =?utf-8?B?Y0ZoTXFweWp1WmxGaHo0WUxzZ2pJMXFwQkpoU0twR29TYnFpenhCYWJEVmpC?=
 =?utf-8?B?ejdRUTNzcTVvQUVJSDZ2a0hVeUhxejZBMmg5cDRDTmt5aGRmRzFlMXp6MEx4?=
 =?utf-8?B?SmFvekdNMlNDVk53ZTdZaXQyZXJXZzZIVExFTnZ0L3BQVHY2TEpwSzZpVWJi?=
 =?utf-8?Q?yYzuDFmoITPKjmFQAuELF+rk3?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 723ac197-fc59-4c4a-6316-08dc478c5526
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Mar 2024 20:45:23.0533
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VgKt0nNMdNPLSa0XOW598ejCW022ehmE6eoZHekofJf53qbJMFwlzWpUie9RkeWjn1iyAaGIKH6KnEax6exYkQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8489

From: Joy Zou <joy.zou@nxp.com>

Support multi fifo for DEV_TO_DEV.

Signed-off-by: Joy Zou <joy.zou@nxp.com>
Reviewed-by: Joy Zou <joy.zou@nxp.com>
Reviewed-by: Daniel Baluta <daniel.baluta@nxp.com>
Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 drivers/dma/imx-sdma.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/dma/imx-sdma.c b/drivers/dma/imx-sdma.c
index 6be4c1e441266..35fb69a84a8da 100644
--- a/drivers/dma/imx-sdma.c
+++ b/drivers/dma/imx-sdma.c
@@ -169,6 +169,8 @@
 #define SDMA_WATERMARK_LEVEL_SPDIF	BIT(10)
 #define SDMA_WATERMARK_LEVEL_SP		BIT(11)
 #define SDMA_WATERMARK_LEVEL_DP		BIT(12)
+#define SDMA_WATERMARK_LEVEL_SD		BIT(13)
+#define SDMA_WATERMARK_LEVEL_DD		BIT(14)
 #define SDMA_WATERMARK_LEVEL_HWML	(0xFF << 16)
 #define SDMA_WATERMARK_LEVEL_LWE	BIT(28)
 #define SDMA_WATERMARK_LEVEL_HWE	BIT(29)
@@ -1258,6 +1260,11 @@ static void sdma_set_watermarklevel_for_p2p(struct sdma_channel *sdmac)
 		sdmac->watermark_level |= SDMA_WATERMARK_LEVEL_DP;
 
 	sdmac->watermark_level |= SDMA_WATERMARK_LEVEL_CONT;
+
+	if (sdmac->n_fifos_src > 1)
+		sdmac->watermark_level |= SDMA_WATERMARK_LEVEL_SD;
+	if (sdmac->n_fifos_dst > 1)
+		sdmac->watermark_level |= SDMA_WATERMARK_LEVEL_DD;
 }
 
 static void sdma_set_watermarklevel_for_sais(struct sdma_channel *sdmac)

-- 
2.34.1


