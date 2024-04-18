Return-Path: <dmaengine+bounces-1898-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A2618AA25B
	for <lists+dmaengine@lfdr.de>; Thu, 18 Apr 2024 20:59:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B3E0728493F
	for <lists+dmaengine@lfdr.de>; Thu, 18 Apr 2024 18:59:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D5B117AD62;
	Thu, 18 Apr 2024 18:59:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="RW/v5Wto"
X-Original-To: dmaengine@vger.kernel.org
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2042.outbound.protection.outlook.com [40.107.22.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E4D517AD71;
	Thu, 18 Apr 2024 18:59:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713466750; cv=fail; b=LFVvLc3QeVG3x6tATVt5ZL/puMOIfymgFd/VevscH/AkbQ/25YdY7X1EmhRtDqh4mOcFP/kzW6HFhLow9Z4HmdB15j5xD5fOjA8PVnEwm99D7dHk4fxct3rAcxC1SdQsUTBkPwEmXIk6QMXK7NRH4xQ4D54Ldv6G3yg9SkGk7M4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713466750; c=relaxed/simple;
	bh=yguA8Cf0jrTEisMl+XgsgWrujNKBaCZqROyOU0iZhT0=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=XU8mxBAuLpf6wEUK1AQhG2dkPQHEgWbNZ8Zdh5CA7tserlLvLhp5THb9ehn9+ysbOSe+Kl9c6xNB2r2zp+H8lc+qw/RIX9FNEwxoAk7Fkg/XSalx45Fg1D/rS7qSl5PAMB7/ePlfg7yruPzuO0EwNuyKUJWxZJVAVGzkvJ3FqFw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=RW/v5Wto; arc=fail smtp.client-ip=40.107.22.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=C4UaKrKsI2aptbDbjjrXA4Db++fb/0t7ApOhog2AtiUDC8tIrBLNzSXL2vOc9anBMeALaEQr0AUDaJYGmD485TTkCaSjmtSB9cWJOTQFL6vm+z2xelqhG+JabWHSl9LXe7QfCSMY27Vudzdk0WxbgvTF2Tz8YmHIjqVwfo+iYG5pU61vszUeP4xXoI1QemDdlH+QdnI/XZKnI3vLtGZzrhLbEXujR/yHDRsYc3obbwy4XGEoJOcijAcvUP+J2R3KEgjg7WxK0TuTFNcP+Cmx9yfMNT33X/16lVx0dd0Sl7O0PHMjX9j1SQ1i3nuEgXRWkjwdVYvGeqsM/OJxRyZu7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qNXAUljkrhvRTFyzEctKTDH8tVmcKFuxgRIKUVxMve8=;
 b=liIDST+yXZHmlCRT7UGr6UW9fumraZ8KA9OwWPs1fL8hA07VDagZghNbSV/0Ivi5Xj+FnR6m5nU32pg4TtfDHysoBUhgCogjIGKkodnE0PqSZBZM2CTjbxWMD0Gpm5EKK/oteQUr8nIGm0Jq96HCkCp5K2DVJxGTd4sgllrJp/uD73i2LZUt4dvgPvpdNXHUn/HfiioYvuZ/6DP32NjJ/kwJsnejrLFOKWjXwR/HZaeSvMFOu0+cG8LfWM9d++ZRotJe1muyxjmWcl130UxkteEmAmhyLI1lL5oKXQWA/Rd9r95uAU0RnUBSZyqMqv3m+9NHi45tn3F/2V901RR5mg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qNXAUljkrhvRTFyzEctKTDH8tVmcKFuxgRIKUVxMve8=;
 b=RW/v5Wto8agc8P0Ny/GrNbkWeUxYiK/tU6s8GWfDR1wQ5I48AU19VaHPWCyvsBSjSeAJ9ssEOnc8yvwszTUB8DOW4IDq6xoL4zVvt+inBtqVLy4OOtH1ZXYjlQCu8dqlrlkc9XzWx7+NrKfd+wMOufs+xBNxq8RJY5boJ0/Q0+s=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by DBBPR04MB7788.eurprd04.prod.outlook.com (2603:10a6:10:1e4::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.39; Thu, 18 Apr
 2024 18:59:05 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::1e67:dfc9:d0c1:fe58]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::1e67:dfc9:d0c1:fe58%7]) with mapi id 15.20.7472.037; Thu, 18 Apr 2024
 18:59:05 +0000
From: Frank Li <Frank.Li@nxp.com>
To: Vinod Koul <vkoul@kernel.org>,
	dmaengine@vger.kernel.org (open list:DMA GENERIC OFFLOAD ENGINE SUBSYSTEM),
	linux-kernel@vger.kernel.org (open list)
Cc: imx@lists.linux.dev
Subject: [PATCH 1/1] dmaengine: fsl-dpaa2-qdma: Fix kernel-doc check warning
Date: Thu, 18 Apr 2024 14:58:49 -0400
Message-Id: <20240418185851.3221726-1-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BYAPR02CA0022.namprd02.prod.outlook.com
 (2603:10b6:a02:ee::35) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|DBBPR04MB7788:EE_
X-MS-Office365-Filtering-Correlation-Id: e953cc57-8587-4380-e0a2-08dc5fd99e8c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	aYNu2duKoAnJySYTrGLjdvRN/3rGMSMIxWmIB9Si7QFH/euHMmXq44vatCaSYZxwZRQxZcAfI+xfMmLS8IR8XgdC3cVZNjCBRp9P9V5suq3dknYwdu6Xy059u7rhxRvD7bOh3MfxjDr+U8/DN7wk+RdPwHW2FE4gJciwYwZHff2ptLd6WnU2FAEanGar/+dmEDfd3gAXGi3/o+/V+ztBFvvXqv0UOOcv81jEbSuxhNU4DjDJm9elnQ8632ujhzZaR3MTpavfQSmdKYMpModPR07tekDxwTZBK57DFNLjuohtJMAa0WTu+azvFpOI9D0l50OdEv96sRKZvmZq3TZT1v0apJBRduOc1YuCNGQkfqSvScHGs6XSPunF4TfoH58QrbGZqVf5m4X/vCV8tns18EG8Xf4jUih+5riPH79l6Mrrx9Ixa8TcsK+PcgAvSxZ422HWkMsgk5gLIFLD55fl0nsQq9S4Ye1TfkHKtXETzd0a7g7bb/OBYAchkLKQYZkWDSH3aMigUgtOskuzsTDo5E98Rn4mGXwCUVMXDz40V2w+rYPo0PRh+CZ/j0SOAd090yUm5xGwiXZfnq+QLBcc0tfqCx/sQ3ebmrMeF89levC3iTbKRB/GVMwz47lvvmQ6o7UHnMDQQxJs1O2BE5FHUH1HKwCQIQkrjkkjN068d7mudVLpwlavmvGt02J2baGkiuKoKV3LcFrOxyv5uI9DS6D+6Iw/sg6wuy5Lrr0bGtI=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(52116005)(1800799015)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?y0tUHZJQeTXufA55CQknVNcHoFdB/m08TXXq9hrUh6yFFXRBCXKJVbIvdC4e?=
 =?us-ascii?Q?nNJh8RxIfI+htcACoyuuc02oxmZPFxYGzQewXaIqy2M/xegyUOhhTh61+rM1?=
 =?us-ascii?Q?FTaDdJttmLonX9CzESbJPpwux42txiQX2DzDb48jekUTalLYrDoe+Iymn7F1?=
 =?us-ascii?Q?2JbHGO1k3AafSdEOIGZVaazQVdMxQgG4v3NTmW42ldhl1bgXju31wPZlZUhA?=
 =?us-ascii?Q?CWSL4N2ho7xWn2l1AB2XW96M5KVqSh9ftU3rho3AMWosGG1eVcqeqBoMv0fH?=
 =?us-ascii?Q?wAe07Mp7jdLSOWHhii2XLkKlTWrN1DKJSsoDTpPKiLwFg6WI+dQRHSeooQnm?=
 =?us-ascii?Q?hAty9OycBTuIZPPCJY2p/khpSXA87ou/Bub7cJU5FyOdU8KCNQnVUfo0l9Hi?=
 =?us-ascii?Q?kJ8bZKyJbiiQEt9vTuqJPSY0LsdRaH9800fW+UUo0H18ziN0QurrSz4abSym?=
 =?us-ascii?Q?cyPo6HDoySNbQ0opa+uawJEWrfElmyZZ8dyhLNB3BmeP+R0bXiJIbylvk2D4?=
 =?us-ascii?Q?15XfO9YFV/g4ADPNarC0DgZJRVq/i66pEwxIu2pvOQk+L8hC2qUP849phEIv?=
 =?us-ascii?Q?PsNWsvT9ONw0FJXaOj9DUw/40tOu07e4aUn8iS7uhXFc4g9BlKGLkSoeHJgP?=
 =?us-ascii?Q?15aKuxyzecUJbX3KQrAJUdOTtcoSIEsd6u9gAig5lkNXEkjyO0sMXVHhNGjo?=
 =?us-ascii?Q?fTPsu0mdEa9+qFGrN7uHkALTCsqmNw3OD92GNWJo62O/MeTes/reVJQV/41f?=
 =?us-ascii?Q?hBGYUHaiByat72CtaJ+B1MIgrsNte0EbJtKDc0IfufMfLTZmYYpziOFclvVt?=
 =?us-ascii?Q?0WV0RHaSniNCtH/Sxh2L4XvGWHGEYkA8yz7kEepce77GY3HBIrJQFRmM4eW4?=
 =?us-ascii?Q?NzvEn95k1BHF+Y8i5Zu55MIWIsrGWCPTiFPcyXV2Gu+8Rzn2uMF/DYxZQTIA?=
 =?us-ascii?Q?T54JCsIL5XXz6gygm6MXrYEqQg7PwgK2o4FeyF8594Z9xq9joV5WkeJwSZIx?=
 =?us-ascii?Q?+Yr65ln+mpK8hDfJgw/HGgK2NEWQdivDuaqF2HHwDX4UQYYz6p5SOW78J2Hx?=
 =?us-ascii?Q?91h46yAHUGv6RiPM3VTsVw7naJqNG45ZAchnWF0VntfmsJPh2CuZ1I8RmNJ0?=
 =?us-ascii?Q?IhFB8JH7S0LAbMkBWSI8JHZg9Pk12C+CYjemA1F45wVImIsBF9M4k9y0jims?=
 =?us-ascii?Q?H5XzHUvDTAX/SruKejN2icTBk+L0ArJAuyeA+aTrykO+5co6FOQG7MH3JW4E?=
 =?us-ascii?Q?e61fUfON7Ns3NIcf2GKglSSFuVivM4Esr66fdlnvTsruolk6DIb7b+LtCln+?=
 =?us-ascii?Q?PuUczCTH4bfEnxDv0vHVPXQae2pSmswqDYtH2c8Mia+Q8JYb3zFeMvHspkOv?=
 =?us-ascii?Q?KQ44bEOFJwNxm3yqJY9r1+xyxMtSPCeXQMAmZFMnsWz/tNAX2T6ZqyLIWhGD?=
 =?us-ascii?Q?LCl0ExZVJ5bFk9hx5ZdoIMXCTkmudIeJzjAz5cJwrotfWS6zbIld9zpLGSHs?=
 =?us-ascii?Q?vNgNrJeBK7WXygC4Qb6xFReTqc6aNDGoPeVTqsF4hj2V5DuH+kdg0lz8a8p1?=
 =?us-ascii?Q?t6IRhUXxPDfqYS3NUZhb/pISd6W0MRliyEv2YYfQ?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e953cc57-8587-4380-e0a2-08dc5fd99e8c
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Apr 2024 18:59:05.3591
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IZq3cP6s1ELjY41oqi61UtfG/2x1jJ+IvOfanaeWpQpMbga5KijmJVkhs7uhHQYOUt7YY2LjR1peJi5ZgwfJ8A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB7788

Fix all kernel-doc warnings under drivers/dma/fsl-dpaa2-qdma.

./scripts/kernel-doc -v -none drivers/dma/fsl-dpaa2-qdma/*
drivers/dma/fsl-dpaa2-qdma/dpdmai.c:262: warning: Function parameter or struct member 'queue_idx' not described in 'dpdmai_set_rx_queue'
drivers/dma/fsl-dpaa2-qdma/dpdmai.c:339: warning: Excess function parameter 'fqid' description in 'dpdmai_get_tx_queue'
...

Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202404190019.t4IhmbHh-lkp@intel.com/
Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 drivers/dma/fsl-dpaa2-qdma/dpdmai.c |  5 ++++-
 drivers/dma/fsl-dpaa2-qdma/dpdmai.h | 15 +++++++--------
 2 files changed, 11 insertions(+), 9 deletions(-)

diff --git a/drivers/dma/fsl-dpaa2-qdma/dpdmai.c b/drivers/dma/fsl-dpaa2-qdma/dpdmai.c
index a824450fe19c2..36897b41ee7e5 100644
--- a/drivers/dma/fsl-dpaa2-qdma/dpdmai.c
+++ b/drivers/dma/fsl-dpaa2-qdma/dpdmai.c
@@ -251,6 +251,7 @@ EXPORT_SYMBOL_GPL(dpdmai_get_attributes);
  * @mc_io:	Pointer to MC portal's I/O object
  * @cmd_flags:	Command flags; one or more of 'MC_CMD_FLAG_'
  * @token:	Token of DPDMAI object
+ * @queue_idx:	DMA queue index
  * @priority:	Select the queue relative to number of
  *		priorities configured at DPDMAI creation
  * @cfg:	Rx queue configuration
@@ -286,6 +287,7 @@ EXPORT_SYMBOL_GPL(dpdmai_set_rx_queue);
  * @mc_io:	Pointer to MC portal's I/O object
  * @cmd_flags:	Command flags; one or more of 'MC_CMD_FLAG_'
  * @token:	Token of DPDMAI object
+ * @queue_idx:	DMA Queue index
  * @priority:	Select the queue relative to number of
  *				priorities configured at DPDMAI creation
  * @attr:	Returned Rx queue attributes
@@ -328,9 +330,10 @@ EXPORT_SYMBOL_GPL(dpdmai_get_rx_queue);
  * @mc_io:	Pointer to MC portal's I/O object
  * @cmd_flags:	Command flags; one or more of 'MC_CMD_FLAG_'
  * @token:	Token of DPDMAI object
+ * @queue_idx:	DMA queue index
  * @priority:	Select the queue relative to number of
  *			priorities configured at DPDMAI creation
- * @fqid:	Returned Tx queue
+ * @attr:	Returned DMA Tx queue attributes
  *
  * Return:	'0' on Success; Error code otherwise.
  */
diff --git a/drivers/dma/fsl-dpaa2-qdma/dpdmai.h b/drivers/dma/fsl-dpaa2-qdma/dpdmai.h
index 1efca2a305334..3fe7d8327366e 100644
--- a/drivers/dma/fsl-dpaa2-qdma/dpdmai.h
+++ b/drivers/dma/fsl-dpaa2-qdma/dpdmai.h
@@ -45,25 +45,26 @@
  * Contains initialization APIs and runtime control APIs for DPDMAI
  */
 
-/**
+/*
  * Maximum number of Tx/Rx priorities per DPDMAI object
  */
 #define DPDMAI_PRIO_NUM		2
 
 /* DPDMAI queue modification options */
 
-/**
+/*
  * Select to modify the user's context associated with the queue
  */
 #define DPDMAI_QUEUE_OPT_USER_CTX	0x1
 
-/**
+/*
  * Select to modify the queue's destination
  */
 #define DPDMAI_QUEUE_OPT_DEST		0x2
 
 /**
  * struct dpdmai_cfg - Structure representing DPDMAI configuration
+ * @num_queues:	Number of the DMA queues
  * @priorities: Priorities for the DMA hardware processing; valid priorities are
  *	configured with values 1-8; the entry following last valid entry
  *	should be configured with 0
@@ -77,15 +78,13 @@ struct dpdmai_cfg {
  * struct dpdmai_attr - Structure representing DPDMAI attributes
  * @id: DPDMAI object ID
  * @version: DPDMAI version
+ * @version.major: DPDMAI major version
+ * @version.minor: DPDMAI minor version
  * @num_of_priorities: number of priorities
+ * @num_of_queues: number of the DMA queues
  */
 struct dpdmai_attr {
 	int	id;
-	/**
-	 * struct version - DPDMAI version
-	 * @major: DPDMAI major version
-	 * @minor: DPDMAI minor version
-	 */
 	struct {
 		u16 major;
 		u16 minor;
-- 
2.34.1


