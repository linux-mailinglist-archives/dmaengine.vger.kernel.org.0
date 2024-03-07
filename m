Return-Path: <dmaengine+bounces-1290-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EB1C87553E
	for <lists+dmaengine@lfdr.de>; Thu,  7 Mar 2024 18:33:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 90BA51C23232
	for <lists+dmaengine@lfdr.de>; Thu,  7 Mar 2024 17:33:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A70D130AFF;
	Thu,  7 Mar 2024 17:33:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="W/+lTlBz"
X-Original-To: dmaengine@vger.kernel.org
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2074.outbound.protection.outlook.com [40.107.21.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB6AE12D76A;
	Thu,  7 Mar 2024 17:33:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.74
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709832794; cv=fail; b=u1WLjDaMvvMRUQtJJtyM6ROLvYoDr15Ka9wlbDhYCGrPQA5p80JTHdOQJvj8EtEsGkPftufTrzMJdgDLm+NtuMICFf9QCfBG9sTin9YCEcvUX0swteWFSvAfpquU6ft5JW2VUFQBXRLljGAf3gEydPWUlOsFzPZWfrwIqLTHj24=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709832794; c=relaxed/simple;
	bh=M8D6VP7v9cHTLZND3ljNIE8GMTXWrv8Xtwn1U6Prze0=;
	h=From:Subject:Date:Message-Id:Content-Type:To:Cc:MIME-Version; b=kaG3Q3Dg0Clf48E7MKH0i1YTSiYG8uc1vKaVueuU+krgB2RtnCed7TUKB765GuPvOTc9/ZeHUkuhTfKEZbcQHhHO8Tbttn5FGm6d339SkgsvwkhvcMNwtuJ8AOt0DKaIoS8IAQDlJobolIgznFOS8AczSmhH7iO+ZzzI8j7Xzp0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=W/+lTlBz; arc=fail smtp.client-ip=40.107.21.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=l1ge4+grC5GlRTl4MSfevlcEJGVxjNbdaYfYPBuM/UJN9csgZrrafBt7Po2cjiWRyh30Sm+ZhWxLyI9gFMH9cRnUlVp8AAz0gIwq3qhNkThqvoCuQ5AHhUdwtNX7GZilxc3WevM7Xincax7gLhEiOGcStAjlR/70pdjXz3JoKb5FTyzYRuhUyzqEZmdHhl/Igg3jLzH6ZYa6yzWT8AcVqWBbjBJMBGOfC4EY1uzyX6sHjLBlRXnIyg6qoFtxR/7SJLaY/ULxoyWVY8OQ26Wzt5uFonu1jZwFd70EfMH1wfIDRfAKTmOJhNwCTno7/+EVjarlHJKRRY1OLpkiX2ZKkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=b8MH23tEHI55dGijl5VmNOaeaG8rqAFNf1DvhvXzhlU=;
 b=T5wrq2DUma7ofGnTGqZBPyPPYUU7/OkdqlOEEg37T2JA8YwpY/qmP0Cfx/B3b2Oy91kBUYNLR5KxPQqXl+LLIxDgWZHwHc/UHNdsl7eU/zfDS3iQv4gi4HQTMdXyOsqo8AF7h8FP7/r/IQNoZKhBSZQQFOg5C9R9zkuljIaBFRoGoFd62ERk2hEG2t3ZQ0NadWQ0IEZPWIoBbaX/02MY8/g5uCE3B1vuHm30lK47KsHK23sj716MsjaTLZ/tNmMajRJeMNOvX6WERjjM8lHlYnLIrhFp3Re4+wiEF3Vm+0qkCiQRWopROPjkUyXB5X1EuQC7PpVf80ddr4+1wjWlFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b8MH23tEHI55dGijl5VmNOaeaG8rqAFNf1DvhvXzhlU=;
 b=W/+lTlBzS/AJh+8CGYKmKcZlqQPvb2K+D+bVq8ywmR2y1SgGs4Eelruu6QK/CadVzCU2wZAACT5yKM3+wA8nquJMpX5f+Omm3afAZ3aMLxxbb4l556vUN0IKpm62741fP/bLqrrD9iKcE3EnWW2nAbfWdym/ud8CKpGxHkW1MyI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by AM8PR04MB7794.eurprd04.prod.outlook.com (2603:10a6:20b:247::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.24; Thu, 7 Mar
 2024 17:33:10 +0000
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
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|AM8PR04MB7794:EE_
X-MS-Office365-Filtering-Correlation-Id: 3fc24e47-5067-4963-c671-08dc3ecca838
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	RCkSD8lnvPbHLpnDwv5STTSDAfqqkOwsV6+uc2VjsWN46Pzhec+Sobz0ZFwbiRnhMsIbV8+cYqoNBW251bDmitYXFM4KX3pOHAHkED+zVdhj+slmFEbJlC9owtPdxAmsIlIzacHdwF6wkzQg77ZOGqzzPreq7QfnXcOFGD3QsFXJf5mTceByFqQeyTF/k3Zxvuj+tk7p+axSHerZ/ma7X0wOi9OtJ6tibhmpTEyE8fEOx+HYnpcvczCGdC6D4oiF3U1beHhI75BFu+h4GGj7IRuiDHEdCQe6vI97SeycaLOwiFhWxk6ypJaP8h9fZaylnWNONmLx56rZfhwKK3QpN7lRJnGViqs6XH/LuVxEWQSXrelnMZgljvwWuGflPbpQeNwneJbbIhdbeuW6eV4m+cnUv1GI/GVcx3FLrHa2dXtzjc0yvh1fwyb5Qt+eLI5t/SoKMxXXAgi1uQAHwhrawdEu/6b8pTBF+cskROhYjA9COG+JeQQ77Waghtr122ZpIQRNDyxIPxzPPX/ZnULWZ1n6XnHwHdK7bjTcUk1Lj55gbJQgPCj6kbrulmk3tUO9fUDF7otxlB68Y8xch0nMnbbH4h2oF258roUeKcQ4zoe95x/n0Ksky4/yu8OBeB7Rz00yVH+LgVYo7x/pIIc5zgDi8WUWrV2WZchkgLW24uk=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?djJDSzh5TUJDdUptNUwxUWxabEx3d3FNYUMvZFlpaEMvM2d2MXVwTjVZanY3?=
 =?utf-8?B?RUlGc0dkRGw3RmNHTzVycm1Wd3Jva0FGK3JVTjdRQ2RqMzh5YU1OaGluSmJI?=
 =?utf-8?B?cWFNYzhvbnFyQWFPWWdvNVlpQWFhcytaR1lPd3RSbGxHOEpJeXFuUTlNejVS?=
 =?utf-8?B?WGwwd3lQekpZL2hiMUVEYkQ0MHNFTi9aK3h2d1drUDRSazNadDVVTlJpaEVw?=
 =?utf-8?B?ZTYycjZRWkZneVBQTEVSR29MVDZnNk1hNlhPRE5ML21XWEllWW9Fc25HL2Rv?=
 =?utf-8?B?a1hNUzk5RW12R3ZJbGpzRmNhTExITERBYmFJVjY2L1NiTXMyNmhYWGdQVmpp?=
 =?utf-8?B?ejMvNHRRU3Q2YkY2VnBzaEtmVlNCcklGNlNKTmlsWk42ZDNxaWV5c1dBQm5C?=
 =?utf-8?B?WEFOWDh5R1ZnR0pKN2JpbTNtTkR2cmFRTi8wQnJKUXAwVGx2d250NzBTV3pR?=
 =?utf-8?B?TG5FTTNxdUpqMWxRVURyR2hIYUxaRkxTdWlkM3IxdXZFblc5aHJ3ZFJFT1c5?=
 =?utf-8?B?VjRsdkZwQlJ4eFJreXJrdjdRQm45cEJtRUc1b2paeFEwRm00QkU5eHgvWHZ2?=
 =?utf-8?B?dkJobzdodERnSnc4a0YvTG9VWEx6azM5RmE0SWticTRaTHg3amVtVzM3SUxR?=
 =?utf-8?B?c3hxZGxqR0ZhMStvU1RxQVdVbzErbUtEMVlOOVFiZ2EwWU1mZE9oNjVHVTd6?=
 =?utf-8?B?d05IWE4vMFl3ZkM2eTZkdit3UDJBYjFqMStDaDg2NDRyYWNqZE11eExWczA3?=
 =?utf-8?B?NmY2SDBPWkpXNFU2UDRhV1NoMENPVndNamN3c1BUcTlOUjVvN0RSQlJWV1Rn?=
 =?utf-8?B?UVVVYVhwcmd0WjdzaTU1OVZkWFFMNE9jUEpVazJFM1pud0RpSUtRdjdmanN0?=
 =?utf-8?B?QWVOcFdwQjBrLzRWWW5nTjJtd05rL2J2bUZUeC9UZnBOeEh6VUpsaDZkWml6?=
 =?utf-8?B?TFU4L1BCa01nV05FL3pVM09WT2JFZUdDaTNCc0M2TzBMaWFpVVFGN3hPOGRT?=
 =?utf-8?B?ekdXNlhqUDdNeUdmTWJkdWVKTm42QjRSMDB2OFN4bVdWV0p4MTh6djFDdmtC?=
 =?utf-8?B?RmErdXA5ZDZoUVpFNFlhWkRzaC9QM0FJNUVsTlZuREttNVVGYS9WeEFPOTRO?=
 =?utf-8?B?bnRScnk0OU1ncktwM01sMWVjUUdDZ1huRmJ2c0Rkenlub2tvc1YvU1lXNHgz?=
 =?utf-8?B?NCtrc3RzdG1qbUY1RndiT2Z4S1ZEVXR1eVg1U3R5Q0dId0FmWDQwYkQrOG5l?=
 =?utf-8?B?cnRBR0ptNitWYzNudVZoUUVaZEpiQ2lTNmZkZGk4bnhSMW1mTE15bS9mNmVR?=
 =?utf-8?B?cTA5WUcyeWlrL0tHZW9JclFOMjg1bXlxMXZGWSt1T2hXNFFXeWlZeEN3ekhI?=
 =?utf-8?B?Vm0ydGwvWWg5R21EbFI5WnRzZFVQYXFXdnl0MlZ2c0Z6M3NNcGVoTzhSSkpV?=
 =?utf-8?B?Uk9xbGgySkcwV1BVc2tKMmxXQmxCUEQzK3BQZnRwNWI2VElpdHQvUFRHRm5q?=
 =?utf-8?B?a0RCaGlKYVhPYm5HUXZuZytMYzhKK1FSZ3hxWDNNMHJsc05HcDBQZFNDSDBo?=
 =?utf-8?B?R3h2L2Z0N1paZHVrOHlyOWZBNUk0UjdHNEdjd0Z3cFpkV1NsWnJOTjVJOXZI?=
 =?utf-8?B?anp5UERxa21leG4rdE4xYVlnZW1KTElQVmZiRFN5U2ZIME9EUms3LzlRME90?=
 =?utf-8?B?d0NZcllBcVBDaHJOUHJsYndQZ004dU1VZ0hDUEVXMFZuNHowOVVzWkVLWHBz?=
 =?utf-8?B?eCtnUlRKQkpFS3BkVDI5UEhrd1JVQ2tTVGpGVmk1dUUzdmc4RTJmQTBpRTkz?=
 =?utf-8?B?TVNFWGhFOVRSdUlPb3VhaERUODJTeUNUaW1mNm8yU2xSRDAraWhjM1RzYUFy?=
 =?utf-8?B?R3ZXaE1TeEhkYkJIckFTOUJYQSsxb2ZMWHJuU0NWNEVweXJGSlJBNzV2YWVC?=
 =?utf-8?B?NWJLZEVGL0E4UVJMSXZYenpIVlpXRE1GbExxdnl3Z0g1RTNjbjNpNEFQU052?=
 =?utf-8?B?SmFteDhUVk1ZU0lpK1VveGNySzQveG16TUd1elk0OVFXTVRVT2VPS2ZwOHZH?=
 =?utf-8?B?Ym9GaUp3U1gxN1Y4MG40WXFUeTZiK0RuTU0wVHlWRmd5bSsvd3FVbi9tcTZu?=
 =?utf-8?Q?3URuhWfQqJxZyZd1QgO++0Zq2?=
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
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB7794

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


