Return-Path: <dmaengine+bounces-1298-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 46574875929
	for <lists+dmaengine@lfdr.de>; Thu,  7 Mar 2024 22:21:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F141C28628C
	for <lists+dmaengine@lfdr.de>; Thu,  7 Mar 2024 21:21:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB45513AA2D;
	Thu,  7 Mar 2024 21:21:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="W/+lTlBz"
X-Original-To: dmaengine@vger.kernel.org
Received: from EUR02-AM0-obe.outbound.protection.outlook.com (mail-am0eur02on2072.outbound.protection.outlook.com [40.107.247.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF523136647;
	Thu,  7 Mar 2024 21:21:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.247.72
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709846469; cv=fail; b=R7O64knUGQIgqkogPzeeyhygIjO+zXwEYFP96KLuIr3yHSMFjr13l2lf+LPutw8HgE91Mq8JNv6q8sUW0we1/SHHtZSeeqczLV+rDFVjAV2AOWl3dD5qrI3EjWCVUQJEgujW2F7LrSbsZmSDwLoU5SacpL8ctbuCoq3lVWJedYA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709846469; c=relaxed/simple;
	bh=M8D6VP7v9cHTLZND3ljNIE8GMTXWrv8Xtwn1U6Prze0=;
	h=From:Subject:Date:Message-Id:Content-Type:To:Cc:MIME-Version; b=aAACfhjQ43MW+dsAv7V8hea5QCTaoEhogW3Kr3Hs8P2nLip375VS4Ugy0q/Sq4llcsxFNOuEamysCNzBJwHjvZLXO2X77DHaVs1vkMQngAHfkshwDsbBhViWfUfYo4pgsPuSO3foSEBscUhQv8ZPJNFMCNifUrJ/KEULVVGclb4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=W/+lTlBz; arc=fail smtp.client-ip=40.107.247.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=j4KR06crn6L7qG7ExRIMQU7awt+7V8Go5rOEBZ3Lo1NVuC/FxrBWRYzr/1fZlCpkSPvFB4mCO5BlgM/2svbs+diU4Pvn30OEWRQAhUmGscc2zCWz9LrKi3dgBspsj4jwUejVSI2l6UKcY5hrfuq3iHFaQenUuWm7TKXkGypn0ZNZRWmgudAF1MkH2bRBR1SqFJsMu6CwZfJWD6b3uYftfQEWK0safB1IK1m/3dI7ERzCVxOGL2QHsYilUxWoO6SKbtZMzcUxJjTl/Z3fT2PX88Al2MSBd3lErT6wI+l/r+9oQmXvox6PeekdSF6rjvbJIKfTsSsMSvHSHKkoHBB9XQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=b8MH23tEHI55dGijl5VmNOaeaG8rqAFNf1DvhvXzhlU=;
 b=j/2CrHg4cQcbyfgaoawUlQiEbnpVjDiJeItvg9wcaf3LCnGbbsiTp7IP/KjtCvktT8Z+i3c4bWzchvE5xl6Lylx9a6gOvBvTBOaLohYrvvN+tqmdJl0eqv/5YRpgr/5AbSD1Yi4OyL8TYFNsTjS/M7/5au8s+3sH5/kdyQEs+/4rfHfpKSGsJ+/e9bTQQD9CK+NS7717jDuhWiqlKPki829Di6sS371a/Xg1HPk705dVd5l9PiCx2/87jVKHQJFXZQEJ7k3oYtFX4kOC503QE/rSzbwo4eDgpVmg0gZzwaT+rX9j+CkwYbVPwyMmCVY4o1UqgrEqs9wAzMFK5DGvBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b8MH23tEHI55dGijl5VmNOaeaG8rqAFNf1DvhvXzhlU=;
 b=W/+lTlBzS/AJh+8CGYKmKcZlqQPvb2K+D+bVq8ywmR2y1SgGs4Eelruu6QK/CadVzCU2wZAACT5yKM3+wA8nquJMpX5f+Omm3afAZ3aMLxxbb4l556vUN0IKpm62741fP/bLqrrD9iKcE3EnWW2nAbfWdym/ud8CKpGxHkW1MyI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB7798.eurprd04.prod.outlook.com (2603:10a6:20b:2a3::11)
 by AS8PR04MB7798.eurprd04.prod.outlook.com (2603:10a6:20b:2a3::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.27; Thu, 7 Mar
 2024 21:21:01 +0000
Received: from AS8PR04MB7798.eurprd04.prod.outlook.com
 (fe80::a473:f240:d18d:3c9%5) by AS8PR04MB7798.eurprd04.prod.outlook.com
 (fe80::a473:f240:d18d:3c9%5) with TransportReplication id Version 15.20
 (Build 7362.27); Thu, 7 Mar 2024 21:21:01 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::3168:91:27c6:edf6]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::3168:91:27c6:edf6%3]) with mapi id 15.20.7362.024; Thu, 7 Mar 2024
 17:33:09 +0000
From: Frank Li <Frank.Li@nxp.com>
Subject: [PATCH v2 0/4] dmaengine: fsl-sdma: Some improvement for fsl-sdma
Date: Thu, 07 Mar 2024 12:32:40 -0500
Message-Id: <20240307-sdma_upstream-v2-0-e97305a43cf5@nxp.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIADj66WUC/3XMQQ6DIBCF4auYWZdmxKqlq96jMQ3CUFkIBiyxM
 dy91H2X/0vet0OkYCnCrdohULLReleCnypQk3QvYlaXBo78gg02LOpZPt9LXAPJmUlFo5HtKHr
 TQ/ksgYzdDu8xlJ5sXH34HHyqf+s/KdUM2bUTSmPdtSOKu9uWs/IzDDnnL5ejVAKoAAAA
To: Vinod Koul <vkoul@kernel.org>, Shawn Guo <shawnguo@kernel.org>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>, NXP Linux Team <linux-imx@nxp.com>
Cc: dmaengine@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-kernel@vger.kernel.org, imx@lists.linux.dev, 
 Frank Li <Frank.Li@nxp.com>, Nicolin Chen <b42378@freescale.com>, 
 Shengjiu Wang <shengjiu.wang@nxp.com>, Joy Zou <joy.zou@nxp.com>, 
 Daniel Baluta <daniel.baluta@nxp.com>, Vipul Kumar <vipul_kumar@mentor.com>, 
 Srikanth Krishnakar <Srikanth_Krishnakar@mentor.com>, 
 Robin Gong <yibin.gong@nxp.com>, Clark Wang <xiaoning.wang@nxp.com>
X-Mailer: b4 0.13-dev-c87ef
X-Developer-Signature: v=1; a=ed25519-sha256; t=1709832785; l=1322;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=M8D6VP7v9cHTLZND3ljNIE8GMTXWrv8Xtwn1U6Prze0=;
 b=09blFXmwEx6KRxrMBcArBZvTqdjCTomqGRRvi6I/gjSGj0g/5sx291fTmSDKCJogNh73VKhkP
 JaDdVoTkvHkC95q/caEcE59QyivBk6++D06J1QdLoj9hlRgpNFJwMzh
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
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|AS8PR04MB7798:EE_
X-MS-Office365-Filtering-Correlation-Id: 3fc24e47-5067-4963-c671-08dc3ecca838
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	p+R6jP0TiwIGBFWoLXZjsqpl6x6ZYRE627nY3vJH9kXFWKiR9Htfvj5a7x+p8P1WhSya2ubsUIhWZ78PmzgV28xir0dhK3HRQza1GKI5+gC8iaBjY8+rsDmxifrodVzYJO2zH3HqvTZCP2tkJ/vOa6oDTb9HVYERAougf/zuYZyq6qQcmnpJb3ZWAMtp65crKS4/o2UHPZGiBTPW+PCdEfBFKS4a55y5bYtaui4KmEr9aXzbii0nB6Xg9RxaNYKcpYFpH2jtKxKcAikK7NSuI4RUZE/MpFzaxq05faeI/1JPw3PSSKf6MT3fgVzEM65hABCow348NkaK0HsH9unVv2ao/GLaNYXVe8SMIfh0NxOAoNNbQT9oN6lx4A/g19jHt7p40por0/aNNWks4WAjJK8i7pxcvhfTQbCe3eemnVJdeqexfmwE07R6BiH71EuRdurVBdb2RbQg9MbwCh3Yh2adm2hWztD2m/k8vpO1q8/f/Eha/Cg/lfgO6ZXm8T0BQoa7pcy2jk47Vi5rAJ7eYu8yDCy/nV1MJLKdsF94VnRI/a6qe6P6rDxFWiN3LgO2G89bGz2qFZgdY3b/grng66d/jVRL7jvuLGhPpYJ/lZ6qxK0A4MXSmkDrUi8jNdOXqtGGxXh4+oH4ImKbIzE76E7TfUuxyb4TU8BOeNw3Bgw=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB7798.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?K1hVbjNuVXZvTHJMSGJkYmdkUE8vZG1jMU9FSlg3NkM2ZHRndWM3bTJQalpa?=
 =?utf-8?B?U3B1S0NpdGExWnpXRHk4b2I1Y2VPZ0RQTHQzZlI2WW9qV0UyaDR6Y3d5MXdu?=
 =?utf-8?B?NmpBVTloUzNaN1A5S3hiY2lhSVlBelpvVThhdFc4dGxEWXpONmZhNTdQZyto?=
 =?utf-8?B?cHZXMG43djRJUTkzd2QxNjYvZTFBVXQ5RS9qbWhOMU9BdE5qZ3hVMUJVK2g4?=
 =?utf-8?B?MFg4dGE1RGxleEx4TE5pQnhrR1NYY000N0RINjNGdHYremFGUzZtN2Rrckl2?=
 =?utf-8?B?SXoyaWRhdlovc2lzeE9odktlMkduU2hpQ0ZsT3JjeHRxMUJobW15bm1Gd0d3?=
 =?utf-8?B?WmhhWHNoL2VOTW1IL2NicDVoNWFnRXdCV3ViV0p5N0F0SExSdlBvdFFEQ3lP?=
 =?utf-8?B?OEdRZWJPN1RDRW9jc1ZjaXZ0dW9aT2p2NUMxVkhCa1VNSVBjaTYvR2JLZ00r?=
 =?utf-8?B?Kzd6VEFjVXZ1eERNL1VuTVlteVBUVW10R1Z5WjJ6eVJYUVVLbndCU1dHVEdw?=
 =?utf-8?B?S2lLbVJGN1JXa3dpRUhpbHRlVlZINzcya3JiYk43cUFtK2lIOEFFeVhlamx5?=
 =?utf-8?B?VHRWYVo0Wjg1TzhJcHJ6S29RdllQRjEwMU5BNmM2dFMwT2RVRFFxRjhxUFFv?=
 =?utf-8?B?dHF1YjkrYms1bmJibnU1Q0QySDk1MGM5WkpjUlhIMUsycWZwYlF5S21kZDAx?=
 =?utf-8?B?a3R3NWZteG5FSnJoa1Z2aGxNayt2U3FNODBlM21LRVI3WGt1aEpUUUVQVWZr?=
 =?utf-8?B?VllBbE9IWW9TSEUxemE2OG10V0hZU2JPaWd1SkR6VWF0OU9ZWDJPMWQwRGJ5?=
 =?utf-8?B?MHNYbWJkMVhidjJLSWd3TDl0dlEzOC9paEU0MHBLbjFBRFY1S1VZb3c0Tnly?=
 =?utf-8?B?NE4xS3FxWXBnN1ZNeGEzWVF4Yjl3elVjcnBtVlF4WWgwVUZ4OS9VRTBMcFRS?=
 =?utf-8?B?bWFxWDlJNHJyZ1JaOVBjYzFvR21Ea3hoTVBRMFdUQjV0RnNnaC9teDc0YlBG?=
 =?utf-8?B?ejl2K2Z2RWNPelViTXlaM2s0TzFKRTFYYmRQbHB3QkJoandURzIzRVNNQ3FT?=
 =?utf-8?B?WUFkajhJRklhd1hTVm1za3ZQS29XY1htVWRmR25raHYxbDV1b05lb2lHbDQv?=
 =?utf-8?B?c3BicWNFWVJ1b2pOSGx4RkdNelBsalNjb0tYYWNzNFR1MmtVMVkrWVRzVCtS?=
 =?utf-8?B?cWo4TjEyREFISnZ0RytxMGxZVDNjTFIwNWlVL01mUWQ1enFUZEgxWFowSHRM?=
 =?utf-8?B?dzRkNXl4cTZvcnhsOVdlT3crcXQxWmNkZlY2bktZVURYWWNlK0VqN3o5NlBq?=
 =?utf-8?B?Z0oySnY4SlZTaXpRZjgzZGprcU5LZWNUWXpJc0U5ZGdGMU1hRDBheUpZbEpY?=
 =?utf-8?B?dUNZNGFYOW54T1FHNDJuNHJBdSszS25kRExEYTNhY2ZLWXozTnZCYVFjeTZL?=
 =?utf-8?B?cDE3VVR6ZHBycStFNHI4M3RTVWZ6aW1UbmVreFk4d0ZLRDllc01laVNKZlJE?=
 =?utf-8?B?QmFkS2xsM0lRK2EvRUk0Q0FhQnltbFE1TlFVYXRNMU54OWduQm5jVUlkTE5y?=
 =?utf-8?B?VGprVDdBeGliVElsL0x6K2FJanFxTFV0NlZWTGFmc3Z3dmtDanNjYVZCeHF4?=
 =?utf-8?B?bFpwNFVaYlovUlVxalFNRXFsdnZGWi9Bais3K1FBQU12cFplbjA2U0dsbDk1?=
 =?utf-8?B?WkVncTMxZUpMT294aG1UejVQbm1VcUZqQWRDUEw0T1FkSDFwNUxmWUlacUZ6?=
 =?utf-8?B?R2tUMXlaYlFCbm41MlZleElnRWpNbmNqKzZHc25NWEt4MzFDUkpnZlhlSmVS?=
 =?utf-8?B?MWlvM3hYUUdCQ3pkWXpiRjlDenN1WnR6eHpmdm10WE5HSlV1Wkx1Y2lrTGxO?=
 =?utf-8?B?THZseHU5Q28wUm1UWlB5ZVlIak1naGt1Um44N1JTZnQ2Z1JWSXBwcWhGMWl0?=
 =?utf-8?B?dldiOHdaMlFYWGVodzlKWCtnOXJFR2J5ZU5EOEdyQVNKdTBKei9NZDVuVGxv?=
 =?utf-8?B?ZFppSHpEaDFCTEhxZklRYmV0a3NVR0pWSCtnZTZkeGc3cFg2d0d6NzRCdEZz?=
 =?utf-8?B?cHlnUCtvczEwbzk2TmFYVmoxdWZ0YlJBNFRsYzQ2QWxPY3p1MWVHVGNKcmFn?=
 =?utf-8?Q?BGcvshDsgb4oTMgbbtNtRhqVu?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3fc24e47-5067-4963-c671-08dc3ecca838
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Mar 2024 17:33:09.7692
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: et76e6myCO67rQrDYFh1uFv8/FI8kV1D+Nidf7z0US3O4Q+khg0fK9TNC3fEaSbyKWyTD4xi2ke5xvCg2DlJMg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB7798

To: Vinod Koul <vkoul@kernel.org>
To: Shawn Guo <shawnguo@kernel.org>
To: Sascha Hauer <s.hauer@pengutronix.de>
To: Pengutronix Kernel Team <kernel@pengutronix.de>
To: Fabio Estevam <festevam@gmail.com>
To: NXP Linux Team <linux-imx@nxp.com>
Cc: dmaengine@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org
Cc: imx@lists.linux.dev

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
Changes in v2:
- remove ccb_phy from struct sdma_engine
- add i2c test platform and sdma script version informaiton at commit
  message.
- Link to v1: https://lore.kernel.org/r/20240303-sdma_upstream-v1-0-869cd0165b09@nxp.com

---
Joy Zou (1):
      dmaengine: imx-sdma: Add multi fifo for DEV_TO_DEV

Nicolin Chen (1):
      dmaengine: imx-sdma: Support allocate memory from internal SRAM (iram)

Robin Gong (1):
      dmaengine: imx-sdma: Add i2c dma support

Shengjiu Wang (1):
      dmaengine: imx-sdma: Support 24bit/3bytes for sg mode

 drivers/dma/imx-sdma.c      | 64 ++++++++++++++++++++++++++++++++++++++-------
 include/linux/dma/imx-dma.h |  1 +
 2 files changed, 55 insertions(+), 10 deletions(-)
---
base-commit: af20f396b91f335f907422249285cc499fb4e0d8
change-id: 20240303-sdma_upstream-acebfa5b97f7

Best regards,
-- 
Frank Li <Frank.Li@nxp.com>


