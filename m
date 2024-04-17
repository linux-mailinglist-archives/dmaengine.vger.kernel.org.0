Return-Path: <dmaengine+bounces-1856-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F05F8A7B03
	for <lists+dmaengine@lfdr.de>; Wed, 17 Apr 2024 05:19:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 74F2F1F23DB7
	for <lists+dmaengine@lfdr.de>; Wed, 17 Apr 2024 03:19:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAFEF849C;
	Wed, 17 Apr 2024 03:18:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="jihPOh2O"
X-Original-To: dmaengine@vger.kernel.org
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04on2079.outbound.protection.outlook.com [40.107.6.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BE49747F;
	Wed, 17 Apr 2024 03:18:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.6.79
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713323935; cv=fail; b=BlVa6e8TC7VHs5FzlZiSY24ckgsax2l/nhF++9W2gUYkpWzrC5Iij2cfE/sraqCOiSwEIZiVyu7ZNBTGjcgy4tYk9PTfHjiQDYelgccpKRITey1iqth8quAt16lCneUU0FB2qYZ8Ok0aQBQQEJCWC/WJe9C8gevAceI0Xix/gcI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713323935; c=relaxed/simple;
	bh=y8+Do5P1D5INCOB/voZUICQ2CcxHQq5sX/kMRKj5b1k=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=o/iCVVfAUL8rnOi82Z1H7kXf0JXHaXpFqjVGRtxRcIX3rA8dEoHI3c6B1Ime7dN7hbmwP4kWGUss6jee5SznpjLelQ7Jd9J1EZgZtyAO4BrsSeIptGj/4j+X6is/tDQjrvn395JHy6XBMJHrQe91XCIqxin2qL0CKsuyGWPjwxY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=jihPOh2O; arc=fail smtp.client-ip=40.107.6.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=l5ACHRKIkxWKHn96Llfhn3TgVfPpGb97913apls7Rgz7auKVOgeSt6FociDOBYvlOToMuFzAc8xahKh/shheFj4os4f15sPjgA8ow0z9VptNnzbiaG7XWFBmZgAZYLoSifTsYo3Jpi3vUzKddqYCBTeHGl8A7DUKrmJ8ke8PxR9DPorkJFcJYynXQuwiQ00Im6Ps+hfIRwTkHpUooUhxVUSjGvnaTRivxcI9AfjajYpbtXbbpu+tOzDfKs3ZW+i7LdaewSqgh3accRyP0iVvg7SXrisEQSbEDLp25yoY+LI+RZOeNdvtR6Ov57rHw2HmTbXHWVzGyOzr3nplw1C4Kg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+OYZwskJ+c6jHmyeIosIR2i4t/FbpD7EMcQ8iKChAW8=;
 b=c75gqP++GGXk76hpV7mcHmRFMmSNw0ci7aDeHqigJ7FntGwa+Ac/LPYSuZL4mm0Dh1pOVpTmpleGY/b8ZwvxU+G8bUvuHsmlFucfGwhx5sfXOKRYnGqrhUL/A3NxC/3RWy2TcgopEvXHpAlbWPgp/r2gvTQLXUQmrlWwke/ZYSzbS5yWlcGyTTOTfSISK/no+cXnEqdmW3yuIW+KnhPxjPiuIFcW+NBOtDgOgCsyLXYQCmmpJDLItRVxyFefoW1Gj6qYUEWyqdUOYjNgxZ9QGdWgx9cIGfxP7SdQdKpN6X09DjH3en7ca7wS+/cyl5lTM/NJNuTAlHM4QwrATkZgXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+OYZwskJ+c6jHmyeIosIR2i4t/FbpD7EMcQ8iKChAW8=;
 b=jihPOh2Or7IRsX3qpJvm1Qf/i7/E5TJlY3klrF1481xdVI1wkFr5ftGnBBaHGQ9hmFJQotrYA5oKlKDoddAfJFgKqEwwLGOLExOBta9gg1UJo+3NuHW9ssx8WXJbLsy9DjkbaRd7CSDx+l0zlxOWuB4rstrc965M7WVppUlPYWo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS4PR04MB9386.eurprd04.prod.outlook.com (2603:10a6:20b:4e9::8)
 by DB9PR04MB9305.eurprd04.prod.outlook.com (2603:10a6:10:36f::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.43; Wed, 17 Apr
 2024 03:18:51 +0000
Received: from AS4PR04MB9386.eurprd04.prod.outlook.com
 ([fe80::4f24:3f44:d5b1:70ba]) by AS4PR04MB9386.eurprd04.prod.outlook.com
 ([fe80::4f24:3f44:d5b1:70ba%7]) with mapi id 15.20.7452.049; Wed, 17 Apr 2024
 03:18:51 +0000
From: Joy Zou <joy.zou@nxp.com>
To: frank.li@nxp.com,
	peng.fan@nxp.com,
	vkoul@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org
Cc: imx@lists.linux.dev,
	dmaengine@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: [PATCH v4 0/2] clean up unused "fsl,imx8qm-adma" compatible string
Date: Wed, 17 Apr 2024 11:26:40 +0800
Message-Id: <20240417032642.3178669-1-joy.zou@nxp.com>
X-Mailer: git-send-email 2.37.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR02CA0004.apcprd02.prod.outlook.com
 (2603:1096:4:194::14) To AS4PR04MB9386.eurprd04.prod.outlook.com
 (2603:10a6:20b:4e9::8)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR04MB9386:EE_|DB9PR04MB9305:EE_
X-MS-Office365-Filtering-Correlation-Id: 3890795e-6747-4202-a9f8-08dc5e8d1ae7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	aIQ9qQzzJ0oEtEv2ySd7Q5vf9OGe3tWgII2rPHMsW9ss36lurpvQHYCRUnkp5Ct7XMEyG/f9YE3693sb4ZAampJZQJlTwC/dCnj/VUICNAGGxPzpYshwufxcd0AfXqzw5YtyRieTMHXd4FtZyXop3mbeEpFJWe/otjUT2shaZzLOwDqiL2iRu0Ck9E3Qj4JdQKfzHgAGGa2Ct6IgOEQmCE2FuOOnR3UKSBBg/FKslJ8ewnp3q/BaUGKuEhAVyaHBrTLLX/t7SfoVyXK0U9RdJB0Wad5zYwzNdxKd1CwkFr9tHGfnH+HQAze5x9JRhCtrMvF+OCTxaeKrXec1YnUjdFfDS/L3PsgT9lgjBdAfMo6LE/zOLzRenGUCMo4jeHNNnonbpgoIbRx203a1A2+1cX7URiiWyYvnv9s1TM4uGTTA8dvYvMJBzaZUWSyWZdrOFZGzsl9aWPabFDpENM/aP2DzhKFvOtHdyLD9JcFluXZ3xyrgnG6kGeksuNzPt2K1AlBOscnXCWYW6PvzvCNmSp8+d/ZJb//vduR4wGSTrMsEVWMwuuEasZd7hVdBSO2vN34w+8lk7xMI/rpt/yX1V8hbcAuuzPTRN0+3ZSMro7eEEKRKcS7EJ8x8hxPJraDpD552B/aDxJp1B7adHqLZKmQJvBSI3OvCjj+k56NkxIrY7kp4iFr4a+v2cMNKUJ7bCX52yH1gbKUSn8RuPotaZw==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR04MB9386.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(52116005)(366007)(1800799015)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ryOADU5HBuyEozz1ZOoaeAy68a+BLLaLUroAnLOIP5Eh1xIvvNOt5z0N9oH4?=
 =?us-ascii?Q?yJQfpnKRW1DzzpxbNnSbs0GLFxB8PqJjLS7RXVZk63X9XilsPFi0iUcbmxEz?=
 =?us-ascii?Q?RnO78mGDE9or+ROL9S/VltNhSAYjK8TBQRJgXam9qKSMme5Gd0YVx+GnA8DW?=
 =?us-ascii?Q?r2NCB/PtB6urq8R4g9r0OCDIn3CQi1bu4d3p8vojiSOFAoL/5l7zgM61AEMV?=
 =?us-ascii?Q?j7D1JqXiJkqnsWBUvV0AXF9z8vs0CCzuf8hhU+sJBEY4chWhWPjwVaGTFKDJ?=
 =?us-ascii?Q?VGQr+cfvNYFWKQ5LjH+532qdyO7s7svMgexhkZSFe38SrfSZeWAqe4GIMBLv?=
 =?us-ascii?Q?Z1BgHZg6Dvad/4UaLoHbtBuJ4h3jhr+0/YUzkSSWre0lIlAxsATF8em1f479?=
 =?us-ascii?Q?kHRYA6a3vtYaxtXnGYrVmt1/7wrbRwlhR6MeiBZOKCLGDJKAYrZBahNCF72v?=
 =?us-ascii?Q?4i8xE42y9dd8u8jXSetCFpk2RsH0AAMk9pgWXNrw18ApRxIzsBuzaWvGpvQo?=
 =?us-ascii?Q?Ub7aa5Ef80NrnyI4Q1snxvyYSLwsrkmOa/AdvaRYX3UdkLmINwr139pk+/CW?=
 =?us-ascii?Q?fewA+reRHfGZcHc+KhMLpapIXnWvIom5xkw1qFCTQeq88TBqjBAjc0ZyvGai?=
 =?us-ascii?Q?GYL1y5eidGQ9Ob1/Zkk30bgAGFbT+0N8jPurCL+SXf3ZJGDrKu6x3BuTFt3O?=
 =?us-ascii?Q?/daQUxYaPyJ4vDmgBaOPiXKfQ9hqo7umxi0Le+booIMjp39bwhIFbQabxjIa?=
 =?us-ascii?Q?IgyA/O58ZI/ViOmMgNPmZk/8t7Nx6Z6ZC+hovKBtWYfT/w/0Om+GKg+vx6eN?=
 =?us-ascii?Q?+zqRO/g7RpF4yOEuPlNzLUstoyh9+e1V7D6/lYFBjINRlrA5x82EpG2z0tOZ?=
 =?us-ascii?Q?KgqIHEnwMaXps+ZwrSraYu5+qetrHSVa9Q9QL1aGaudiyqSPHXcmsaoX2FcY?=
 =?us-ascii?Q?jGrX+8jqUfBqiK5L4LIRIgjsgseEhb10KMDYx5NWZnmUPvYxcMwB0A9Km3eB?=
 =?us-ascii?Q?0G+1x8ibGw9cm3O60ZrfynmFxmU1VfF4B5tWkP6tLiZly4WZ38HcJNqp3F5I?=
 =?us-ascii?Q?t6fqjXdf/PZH4gRq5VYnikMypvzDrVIXcbsX0aqZSAa8jE3YPFUCJmWWbqve?=
 =?us-ascii?Q?p012CZfp7VRyV4KMAcuxP5gYsFJTcq4j9wMN3HLZZXxe3QM1XgC3FaX/pR7x?=
 =?us-ascii?Q?9Mx2tqZRsSGZdx8Fiwr5RL82estqyTty+66F6jQo+g4RgPKi11s6R3aoZFgM?=
 =?us-ascii?Q?xuRDCtCtJcNAStgUk1VsYf3em76acg1+mzIjCxxbWVmPwarJNQy9tYbsx8nZ?=
 =?us-ascii?Q?5++Z9/9g1pGQuzUghAdBbnr7sWfF6+GxlsJrl4jrRxyW8lPtelcusSatY8FI?=
 =?us-ascii?Q?kruf8hlVI8NUfa8Bs9quGpvISTahnE4DdepKxKU1QqS94SfsNTy5A+7zDpFm?=
 =?us-ascii?Q?Jp/D+MPEU5DR31PWpsxH9AYZVU3zZNjBZr8mdu7XAZ1L9urIYFGW94UMKvcl?=
 =?us-ascii?Q?WCWl4KjYzlfNEvQt7E0ydN5ILTNPCXiGUTD5FDnZktYQotIzylCIRm39q54c?=
 =?us-ascii?Q?RcUKgwEi4BHPLtD6vraH5X1qXJwsKzd8ugsQgfRz?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3890795e-6747-4202-a9f8-08dc5e8d1ae7
X-MS-Exchange-CrossTenant-AuthSource: AS4PR04MB9386.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Apr 2024 03:18:51.7193
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: a6sAB2ZcSJ9CXYq5ScfQvCyOPZqRbo93N54M0i4upfb/rOOA5b+NY8RcDBCmdS9a
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB9305

The patchset clean up "fsl,imx8qm-adma" compatible string.
For the details, please check the patch commit log.

---
Changes for v4:
1. change patch subject.

Changes for v3:
1. add more description for dt-bindings patch commit message.
2. remove the unused compatible string "fsl,imx8qm-adma" from allOf property.

Changes for v2:
1. Change the patchset subject.
2. Add bindings update.

Joy Zou (2):
  dmaengine: fsl-edma: clean up unused "fsl,imx8qm-adma" compatible
    string
  dt-bindings: fsl-dma: fsl-edma: clean up unused "fsl,imx8qm-adma"
    compatible string

 .../devicetree/bindings/dma/fsl,edma.yaml        |  2 --
 drivers/dma/fsl-edma-common.c                    | 16 ++++------------
 drivers/dma/fsl-edma-main.c                      |  8 --------
 3 files changed, 4 insertions(+), 22 deletions(-)

-- 
2.37.1


