Return-Path: <dmaengine+bounces-1294-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 06F58875546
	for <lists+dmaengine@lfdr.de>; Thu,  7 Mar 2024 18:34:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B10CD2823E6
	for <lists+dmaengine@lfdr.de>; Thu,  7 Mar 2024 17:34:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D084B13329C;
	Thu,  7 Mar 2024 17:33:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="rZuLk+kU"
X-Original-To: dmaengine@vger.kernel.org
Received: from EUR02-DB5-obe.outbound.protection.outlook.com (mail-db5eur02on2060.outbound.protection.outlook.com [40.107.249.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D50BB1E89D;
	Thu,  7 Mar 2024 17:33:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.249.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709832809; cv=fail; b=Xc60AphwR8zygKC+xTmeot2VF4+xaQ+vKBIhukd+AqPcuFGEzePdXUV3nD50QUADREr3/bv2v6CRx312Csrbyo3IIiX7ytP0QiU3cGzkx1gb9Lmh8t04B4NVY5BgBkwOsk69LCED4oE/YQUMu7ci8FyIxmNm/vrOlo15KiyyENs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709832809; c=relaxed/simple;
	bh=PAauSkVd257q5YDs50he+CnIKgSErr2vkRkT1d4FKJM=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=NOA4oPgzYQo1TzcNdcvFH6Mglh+lKeGTn5aua4DwQZ1rKtgkAANX1F69Zds+qx6onP06BS8ao/O55JY3DhsZq45H6SEMQkqVcOsyDKh+KmRU5or/C/WLB3FmdpOKS6CTe2iB+15Hm550dwuyij/tExLrZIsIIB4T6FXNheMxs9w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=rZuLk+kU; arc=fail smtp.client-ip=40.107.249.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jBtTTVLndbCQ1nywRTblYhAi7/RyhSvPUD/qk2vf5hTCgPXN1HUEzyb9wBF8lYo16+pn2ESZh/C4AWxckKSrhSzHcpc3nN0aQ/r4Buo0G5EBPzgU59CW8oD8jGrodni8z/a7K7bWXbu2WjCD+EagU9v3z+UOXKjzi0D/i2fD/Nou3kRKuKZgO9MPYO6j3o+ZZifUynf53bHKNVTa0ZUAu/PV327HH+VNeQtpJ+np1fpYiJDOWyoILjrfsX9vdhD67vrf4zDMAqLQDmFwo+e/TNPRbaZd51yXABHrqpJLvyaMu98abpivRGU8K0QvYQHuanG/nO9h/sdHehgFHroxvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fr2LO0h9CyoaMXE2T45nE8psg5Uj5g7MRpr4k8U/A9Q=;
 b=iRXHd1pyWmLhbzRNItNFl8BwcfOsQYjnc6dzqV8qkP7mDukYVbMnC03rqK/IEnN/Q3EBQfC8pwvLnZJ4VF1lvvyJVdA7bUh1IL1j5dkysVqzqyQsQ1ZFMHy/dg6touz5X4PJxGfPBK+TixqO2gomj00+1C66Xokl/99fg8QPFuGxPeNxM5qYo6lCTTFvKgBka0OEl9XofrMaIYC5d+sDH4HTmMrnvgHFRM7aXIDsz19GLat5QhvQQCV8YqYSlh4+1amio4/lM1gDCBGIU2fxh54i9M/rt0I0YzI86S/Y2/Qw9PlW+2Q3Zdyiv40TXvaLk79oF8LFVj60QDShDxlKdw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fr2LO0h9CyoaMXE2T45nE8psg5Uj5g7MRpr4k8U/A9Q=;
 b=rZuLk+kU6+A8m01UeTaqOR9kWo1JDE/RZI8htyiZD1rWx8naHiTTAZJdhoaF4wZB7K3pDEtGR7g9K53FnV0na/1Od+B0Vsg3N2Ht86EHRxv7Ua3NRgN43OP0OtzmgHgp/m9g51z5qtCpSAGASPNblKiucNtoQXvxOyPhGRxJJhM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by AM8PR04MB7794.eurprd04.prod.outlook.com (2603:10a6:20b:247::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.24; Thu, 7 Mar
 2024 17:33:25 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::3168:91:27c6:edf6]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::3168:91:27c6:edf6%3]) with mapi id 15.20.7362.024; Thu, 7 Mar 2024
 17:33:25 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Thu, 07 Mar 2024 12:32:44 -0500
Subject: [PATCH v2 4/4] dmaengine: imx-sdma: Add i2c dma support
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240307-sdma_upstream-v2-4-e97305a43cf5@nxp.com>
References: <20240307-sdma_upstream-v2-0-e97305a43cf5@nxp.com>
In-Reply-To: <20240307-sdma_upstream-v2-0-e97305a43cf5@nxp.com>
To: Vinod Koul <vkoul@kernel.org>, Shawn Guo <shawnguo@kernel.org>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>, NXP Linux Team <linux-imx@nxp.com>
Cc: dmaengine@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-kernel@vger.kernel.org, imx@lists.linux.dev, 
 Frank Li <Frank.Li@nxp.com>, Robin Gong <yibin.gong@nxp.com>, 
 Clark Wang <xiaoning.wang@nxp.com>, Joy Zou <joy.zou@nxp.com>, 
 Daniel Baluta <daniel.baluta@nxp.com>
X-Mailer: b4 0.13-dev-c87ef
X-Developer-Signature: v=1; a=ed25519-sha256; t=1709832785; l=1789;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=Z+znoASHkKmDKADwkU6SjZopn98mnwO1hpFlpJAh3Ck=;
 b=Ku4e7caUq85Jh4+K9NjD5IwJYrhG35Of3csh8qwVRO2dvgCKoLBzbN1E5FLznRxEDtzgAsyGx
 Fm0vq4z5N7CDdrsUEVC34uZLXjhaPtHVH/jp1fkT7zglOoc3GoVQPlK
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: SJ0PR13CA0065.namprd13.prod.outlook.com
 (2603:10b6:a03:2c4::10) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|AM8PR04MB7794:EE_
X-MS-Office365-Filtering-Correlation-Id: 9d647bcc-44d4-4a77-72a6-08dc3eccb195
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	YqMY75DjpBUXZYd/J8INl3kjQ/NxNBrFBPrdq47aykXdYkUAxmQ29/X1pQCev4aADLeuADuz1TFLzUGzs6xyGDUiccusdDr8mC9Hqr7kuQ95BjAZ39SMve9WXDvfOnm4kvDEknWL11dCbBLYtm8IgPFeJjqNFSclYR1zNL++fH9GzrNSBHzWchk+VufLWxf2KUeszuR5572/8+UGfYZU08nNSjtQB5DcVTWcxHW7X2VvygEgHQGQESBJq4hjPZmGHf4GBZL/SJ51/vbr0TChNJYNf+GL7OVaIZkCvTN2k2ECE3hToO9qDf7YI2SxgzOrk8eDqN3XNjWaN0wLvUlGpCkD9FN55CBV/CQA5pMty+bAJHt0JV2j91HTo9BwENMzmEYn0beVKXuYIOsRIDWuWHV65QbMWJE7Hkh24vmFuCBgdkni6JsEUKfxx4jyxHpNWYzOc2FaXtIz9H5vWsWsetsjt1J0c7hvOQvPSmWoPxAbe8DYiP8xY1kak9HCPpzICrj2j2vvmdgUAHSDDzUDa4lYnRB01nxXUeRqSz/X+/aP+H/wFA9bcCbR82kpw4SS6NM1v8hLhenxN/+jkx3VsZ9DionRNO5DxY8FSD0TWE7FOnQdEZSuDotLfVjnA/bFl2iwq3buQ6M7j5rbcIIrbd5lS1bQqGTLbmFlr+3OXwPPGPSAo+QSecUotHydfus8xwrDW3nkm8lqabozVSSLBi+JqTyPI0QNBoevpUAEzcw=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?T2RmVld4eEtqNXZ5UEQyODRnZW5ZVlVhVWFvTTlxRUszTVRNc3NuZFY0MkFu?=
 =?utf-8?B?YmJjdGRqY2JhVnpXYU9RM0EvLzV4UEZEYlpCMjVpbEF3YkF3dHM3Q2ZFT04w?=
 =?utf-8?B?eU1GTTZVT2VGRzhPVDY2RjFQN1dhQjloYXR6dS9GRTdlL1lXM2hPNFVUR1pZ?=
 =?utf-8?B?WFBmUXExbnRNUlpLU0xjQnZjL29CV3lmUzZPcHJXTE9QTE1BRmd3MWJlOVRy?=
 =?utf-8?B?b2htOUY5aUE1djhMUlNqQzhXSkNwNCt1OFA5MTRodHBQMFNaRWoxUzdrbU13?=
 =?utf-8?B?TEZrMmIxOUFnWGRYWEdSdUxBbFA5S3dqMDd6N3RHdUlFalhwQ2dsMEZjYklU?=
 =?utf-8?B?dTJzdmFtcTRpbXFvVVorM0dicHFZWU5DdlNpelZNeGs0MUNJZ2hRM3Zxemcw?=
 =?utf-8?B?bzdTMnd0SFhmL1VUQ01QWEkvSitHZlRFcTR2R0l3OU13QlNPWWRrbXVkRkpW?=
 =?utf-8?B?WTNydDNsbTRHbXJXYUhVNjFDckpxVFhibCtzNmxCRWRackFOb2dRdTVyQ2FO?=
 =?utf-8?B?bW9Sb3NHRjVnZk9IaXYycitPVDNiRzFvRWxDYVRPRFlDQmxKUEpBbEYwTlBT?=
 =?utf-8?B?cFJWNzlQSGkzM2tNcU55NllXaUhOZVh3cW5HWk5yOUNiV0FBYzJ1NFBJNjNa?=
 =?utf-8?B?L1g3Wlo0S2hKZWpwT3gxb21jTVFMZjMyR1BuRy9RR3JKQVBvWDNTQ05wdnlr?=
 =?utf-8?B?RWl6UUY0SENGQUxKWlF6SnExbnRBMWR0bE1BTFd0eWM2KzZLSG95SXg4NEcv?=
 =?utf-8?B?RlFLSVJ1Wld2NmY3d1F4a3ZwU09DbFhoUHFaYXZvQ2Vva3NBN1ZMY1oxcG01?=
 =?utf-8?B?RWxLS3V2UGFjSkZqSTJiVEtneG4zbjBoOVpRYnV3UzY0UmhnNzd3OGdmUnJK?=
 =?utf-8?B?YTNmeWE1a25BS3d2WmpVOTFXMzdFZHZCenA4VUhzbTFXL2xXZjNZc0tMaE5l?=
 =?utf-8?B?aDEvRUtJcUpDSnYybjZheUZrcmdFWHNzeExKT1UzUWdITEwrTVBpK3hoSkdV?=
 =?utf-8?B?bXN0T0o4SW5WaEJNNUNQNnluSGRGeXZRQlFod3plQ2NONncyY0RkdHJGb2Fy?=
 =?utf-8?B?aldSTWRKVEY3Z2pQcjk0alBLOUNPOGRPejd2aUZ4M3BwZzlZZGZGaW56WW5K?=
 =?utf-8?B?N2t2UXFKK3loWTdDRXBaLzBOeWJ3M0psNDY2SGFxYWptdG8zaGxlVlJCcEdO?=
 =?utf-8?B?WEh5K0t6eEdoT0JvaGtVSUU3OCtaeHppVWxRKzdOSHR5N0RuS1NDZ0NuVDQ1?=
 =?utf-8?B?MmpVdWFJL0cvTUFaYlBXeE9selg1NHBMSTRtWDFVaW1NbjFjQ1ZKNVhKeGYr?=
 =?utf-8?B?Rm9DdmdLN0hwV1N0RmRtUzZTNy9UMXVKYjJtTytzSnNzeWtLNGY1TUE2WWhV?=
 =?utf-8?B?NHRXL1RjZ3hack1TQ2FVYXpMT3E4QWRxZ04xSUhUMUdiNW5vMUlxSjZHSkZz?=
 =?utf-8?B?U0lWNGRGbkl4VGlJUEIveGxEaTZQdm1zM3VjbTJTS2NIWlRVTmhSYnFQTXJG?=
 =?utf-8?B?ZkxsUzUwU1ZxM1dEaFFRMDkyZ1dTV3hFRDZldGo5NngxZzkvd0xCZ0UzdjdR?=
 =?utf-8?B?dTc4aFliNEgvVmdXcEFkODVDaUx4eDR6Y0pHd3J5OVpHZ3czR2FmdFlkdzlR?=
 =?utf-8?B?a2FISXBiYngvaFNYeC9PM0xZVU10alVpM1dnYmhUWVk3TDBTVnYxTWE4eU5E?=
 =?utf-8?B?THF5RXJTYlFoVmRSTVdqMXVNTDJ1ckdoNzNXSGl1dVZ6SityMzVQbnk4WFZu?=
 =?utf-8?B?aEpKVWF4V1puOUt6WUtydk45d3lHdFBUN3hjK1VpVjBMSVpyRnhwaklHQXdC?=
 =?utf-8?B?YzNZT2FiOXp1OTNBcWhSZmNZMml3Q2p0bXNpMUhPSk4xVWtYaXF2MytaK1N4?=
 =?utf-8?B?V3RKVXBnc0h0K0MxcjRUcDRoN2RvbVIwQUIyd0QvbFlCQzN6eGZMKzNSYmtQ?=
 =?utf-8?B?RG81VHNXYmluTmVzQUt2ZVZXMUYrTE4vQWFpUjRsZ2c0d0VJUGxzVmJwZVZ0?=
 =?utf-8?B?S2E2c2ZDblVvQmVXNEV5TnJEdnJpL1VDc2ZRR2FBY0UyMHRXc2pGenllTDly?=
 =?utf-8?B?VmIrV0dyQ0ozN0xSdmk0U3pyOHZEQUNSSzBsd0hWbFVNVVhBRU5qNmI2cGN2?=
 =?utf-8?Q?VWn2rkX4Ezgc8hRV4u/vyPs9K?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9d647bcc-44d4-4a77-72a6-08dc3eccb195
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Mar 2024 17:33:25.4485
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: D4PPHxQe7Nekx9mGfy8g54GL7IekbC19Lq49y/sO9kGuGZdm67GCqYhWtYhni4ffy7XO/tmwSS9BkS8HY4Em0w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB7794

From: Robin Gong <yibin.gong@nxp.com>

New sdma script (sdma-6q: v3.5, sdma-7d: v4.5) support i2c at imx8mp and
imx6ull. So add I2C dma support.

Signed-off-by: Robin Gong <yibin.gong@nxp.com>
Acked-by: Clark Wang <xiaoning.wang@nxp.com>
Reviewed-by: Joy Zou <joy.zou@nxp.com>
Reviewed-by: Daniel Baluta <daniel.baluta@nxp.com>
Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 drivers/dma/imx-sdma.c      | 7 +++++++
 include/linux/dma/imx-dma.h | 1 +
 2 files changed, 8 insertions(+)

diff --git a/drivers/dma/imx-sdma.c b/drivers/dma/imx-sdma.c
index 35fb69a84a8da..5bc4419fd45f3 100644
--- a/drivers/dma/imx-sdma.c
+++ b/drivers/dma/imx-sdma.c
@@ -247,6 +247,8 @@ struct sdma_script_start_addrs {
 	s32 sai_2_mcu_addr;
 	s32 uart_2_mcu_rom_addr;
 	s32 uartsh_2_mcu_rom_addr;
+	s32 i2c_2_mcu_addr;
+	s32 mcu_2_i2c_addr;
 	/* End of v3 array */
 	s32 mcu_2_zqspi_addr;
 	/* End of v4 array */
@@ -1077,6 +1079,11 @@ static int sdma_get_pc(struct sdma_channel *sdmac,
 		per_2_emi = sdma->script_addrs->sai_2_mcu_addr;
 		emi_2_per = sdma->script_addrs->mcu_2_sai_addr;
 		break;
+	case IMX_DMATYPE_I2C:
+		per_2_emi = sdma->script_addrs->i2c_2_mcu_addr;
+		emi_2_per = sdma->script_addrs->mcu_2_i2c_addr;
+		sdmac->is_ram_script = true;
+		break;
 	case IMX_DMATYPE_HDMI:
 		emi_2_per = sdma->script_addrs->hdmi_dma_addr;
 		sdmac->is_ram_script = true;
diff --git a/include/linux/dma/imx-dma.h b/include/linux/dma/imx-dma.h
index cfec5f946e237..76a8de9ae1517 100644
--- a/include/linux/dma/imx-dma.h
+++ b/include/linux/dma/imx-dma.h
@@ -41,6 +41,7 @@ enum sdma_peripheral_type {
 	IMX_DMATYPE_SAI,	/* SAI */
 	IMX_DMATYPE_MULTI_SAI,	/* MULTI FIFOs For Audio */
 	IMX_DMATYPE_HDMI,       /* HDMI Audio */
+	IMX_DMATYPE_I2C,	/* I2C */
 };
 
 enum imx_dma_prio {

-- 
2.34.1


