Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 22AF03ABD26
	for <lists+dmaengine@lfdr.de>; Thu, 17 Jun 2021 21:53:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230161AbhFQTzn (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 17 Jun 2021 15:55:43 -0400
Received: from mail-eopbgr10087.outbound.protection.outlook.com ([40.107.1.87]:34791
        "EHLO EUR02-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230039AbhFQTzm (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Thu, 17 Jun 2021 15:55:42 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Dfo4Zodf9VtU0bVKAcMuwnLTHWEvQU9Hq1xrudbhi8KJ26KEx1TelEHCvrRIyvQK2U4yPeaIq49xeBcDpUvJZd83KCpXp/GYJkPVqvSpT3XhGzCqx2KH30C9fp377LUskapza1Y1L/UTDCp9oi/FG5/W3cnhnKCSGQuU/lTVtrO1M4NXDRJec869pPmwQTrqoTUNtGN21yZVs0aUk2PYzw6YYqvHlnriToAvBk2jzkXtuTUQKYHtMMLfJowYBLCSPDBH6HttqFSRcGk3v7DOTdFtSdYxjc5xKWUKrefK50V+u8f4nC3Nj0mgvBBDeYeTHfmS7uvozxf6lbIe3Lqh0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FZu5JboXnL6ZHX4tMUTk82zb6sV47V19ykSVOezA0dw=;
 b=Xtlu1+gdJHZ2jMiTWxKHQaMsKAYhaT4VC3JdHvnyMEVW3QjSs3CWYcHQUlGqmGwQT/hBIgr+c2NJ1GhDaA9HjFfvo6nToUjTPEYGqbHsnYfkDu7blqQfxZKfHagOddlenSAIw4YtLOuIDRs400kK1S1e6maRD+Z2Btz9yy+UBTi/Qm/ayG1jsHnv9eEurpSvQMvWwbxYm/53OF62eX5jR7V7b5ol5w6YpKZDPoiegc1EZ4qd9zCXDtNgIsJ9UE4bPHVP4oncKuSnztiNTP72hD244uKgBOdNZo6H7/VNQ6zDtCDBJ6kQN8AmmWZIvDmR8wRLxOGbAfLAURNa0Ldupg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=orolia.com; dmarc=pass action=none header.from=orolia.com;
 dkim=pass header.d=orolia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=orolia.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FZu5JboXnL6ZHX4tMUTk82zb6sV47V19ykSVOezA0dw=;
 b=pB3HQbnSqggcjwG6Y4bI35pAr1KiE+k1GgDgSKd2YbLuT1btJqGqdPt0h4OlHDzAcTWFshSjdxszti70xvtrJw+njHQ+kYM1Wu3apqS7WMdSeY6rdoNPyMAMWphZ8iaX7z5lpx2XlKMYXrafJjtPIUdkkl4Q2gYikjNSt08KdJM=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=orolia.com;
Received: from PR1PR06MB4746.eurprd06.prod.outlook.com (2603:10a6:102:11::28)
 by PAXPR06MB7710.eurprd06.prod.outlook.com (2603:10a6:102:de::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.15; Thu, 17 Jun
 2021 19:53:32 +0000
Received: from PR1PR06MB4746.eurprd06.prod.outlook.com
 ([fe80::81ef:de90:c451:d6e3]) by PR1PR06MB4746.eurprd06.prod.outlook.com
 ([fe80::81ef:de90:c451:d6e3%5]) with mapi id 15.20.4195.030; Thu, 17 Jun 2021
 19:53:32 +0000
Date:   Thu, 17 Jun 2021 21:53:18 +0200
From:   Olivier Dautricourt <olivier.dautricourt@orolia.com>
To:     Rob Herring <robh+dt@kernel.org>, Vinod Koul <vkoul@kernel.org>,
        Stefan Roese <sr@denx.de>
Cc:     Olivier Dautricourt <olivier.dautricourt@orolia.com>,
        dmaengine@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] dmaengine: altera-msgdma: make response port optional
Message-ID: <8220756f2191ca08cb21702252d1f2d4f753a7f5.1623898678.git.olivier.dautricourt@orolia.com>
References: <cover.1623898678.git.olivier.dautricourt@orolia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1623898678.git.olivier.dautricourt@orolia.com>
X-Originating-IP: [2a01:e34:ec42:fd70:167:681b:bc47:e8b1]
X-ClientProxiedBy: LO4P123CA0070.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:153::21) To PR1PR06MB4746.eurprd06.prod.outlook.com
 (2603:10a6:102:11::28)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from orolia.com (2a01:e34:ec42:fd70:167:681b:bc47:e8b1) by LO4P123CA0070.GBRP123.PROD.OUTLOOK.COM (2603:10a6:600:153::21) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.19 via Frontend Transport; Thu, 17 Jun 2021 19:53:31 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8840a06c-8f5c-4a41-4bb5-08d931c995ee
X-MS-TrafficTypeDiagnostic: PAXPR06MB7710:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <PAXPR06MB771064D59BEEE05F7F5FAF5C8F0E9@PAXPR06MB7710.eurprd06.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2887;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4NEw81uPR9r4JG5j4yHPgjuQ0BiEf9PgvR3aqRdpaEn07En3nZEHNzb4iZrJjuOQYkP380zeKhCDEy0tIIPvEZE9/4Y2sL58NzyFQrWLeMpRM/uCMxJQh8Jokp1Pj0zZnjKxEDNlBhiqVQ1HBKBwPqBjQgYOmiy2mZ2Ahe4vmtagKB/XfzBeCK3svtLT6eo01Adzqg3QOkUCN6mnjEHpzagmIZNfuwSZYB7+zvl5oGp1aggybwMar7hLC+wGWqalL07dlvtO+eI+8eeMXVl9n57IpsHv197BXd3wVzv7i6U/xe6Lh5pGhhjruqt+q0Q4iNV9DgjleSBU+ve9pE0y9qAiLBxybby+j4BpZRnK5F3LjInk1v/cO2nCQf5WxArEShc2sX/GUagCCYKOLEbtwFqw27Bl6AD5rHyYWN13KMHSFSFS/9a7jp0pmheUzrwkBstDX1mos0vCjliDUR9euDxv7ow7FszwWP+szRnV6/NYpeaDqidgIcIiN5e/JRJ+Ml2KwgdjJJCuldZR+CQ1cRdhkEvO+zJS1Ev26gtqSz4BrSTAswf+SgH5gjt/RIIYX3NI+ANjmdSDOVLFIr2urn5wYtw9r2QgmxoKmctRF5Wu7mMWxFkHBnT/IQBTIKjbGrQjpanBvQDJQfXBBSxR0mZUGLWYl+msurd8pAx4GQvMyWKHGyGrqHLMbgqBkvO2QB6KeAuaPjNAXidWDavPYDP63PWoYmvpXAN6zGOSlcQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PR1PR06MB4746.eurprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(346002)(39840400004)(376002)(136003)(396003)(83380400001)(8676002)(86362001)(8886007)(2616005)(478600001)(55016002)(36756003)(966005)(38100700002)(186003)(4326008)(44832011)(16526019)(66476007)(66556008)(6666004)(66946007)(316002)(110136005)(5660300002)(8936002)(7696005)(2906002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?uEXusXrf5gYGsh/OgPBOoLe6CljjVr7k7ITm64stmpM5lZRI+kInIsHr0nU5?=
 =?us-ascii?Q?Tm9jMjfcH1kYZ91ROzb1hCdlUbxDLZU2qu9f/GRK+I3ncfnyMAqFjOoaAwM0?=
 =?us-ascii?Q?e5uzghUUJ7i2os9A407awMRrFDl9JsthtMEV0quwR4gdOcvT6MebO4424M0l?=
 =?us-ascii?Q?GgCnANK8m93sWKQy8AUnIV0DA47K92MH3R7QWXXK0HWtLmz3x+kaxJ1DxHK3?=
 =?us-ascii?Q?EgMwYtOFZQMYO7lybmqYA8dDqWbfpMBa50S0ibcncYLjD0H/MvzdNQ/zCH6M?=
 =?us-ascii?Q?YOdYpejqwdMmyCSTxhZwdl7zd0K++eNhQc/UM8LTx8vLfjJNIaCn6xMDW1DI?=
 =?us-ascii?Q?+T+rPImBNsszw3Z+Ap/cfactb/4Q7F7yRevT8MXf6Jbr4RPXTcMxEEiD/xY4?=
 =?us-ascii?Q?7+yoM8VO41oZSu+MPShCDat/7wPsVYbCT7qYCCNp0dWBIyHzMsHu5EA6rPeU?=
 =?us-ascii?Q?O+pDu7ujBwEUBhaJRXCrPsEJceRDbjH2QqTFXcuW3pu0nX4pz4m4+3T3JOHv?=
 =?us-ascii?Q?qdMoaIn2JanMUna0X7tZcSGf2wcdOBdHFq6ywmatysFcrHuYy2McuYrX+0jo?=
 =?us-ascii?Q?8J0APCHhgR4YBf3YXfjoBJW8PMnYqRpGkcemT6xkTNDc5lX5gyYKP6UW+mj4?=
 =?us-ascii?Q?Vomqp4H1ABp6lOMpw9dUxzhI75IycUQhbnleCuoaaYluxWptDvcn7Y6XZg6Z?=
 =?us-ascii?Q?9tRHIgvEOkHsO1vjuqRPM7iNFleLVke8aLmVEgmNbATKPuV128CjCtRr2qz7?=
 =?us-ascii?Q?8w8MQt1Y+pwcnm9racjZhqyJyBOIWAKds3HCErs2B1xOrZ+ttObP9XH+CwwV?=
 =?us-ascii?Q?QO+NlsRE2+y2ik0+fw6llVBu+DxdKVI/rxnrU6cXCoqa6xhL9JFdXSfGxYzn?=
 =?us-ascii?Q?rjxebYgoQCtQMM48gPO7d864qJGYSCZnTnTzIQmpgtlPNDDh16KIDVbjw5/H?=
 =?us-ascii?Q?C9S7cWjNL3FfbZDADMIkiusk1jgyQ0A4/j2yoHngOD56Fa6DL4nk0DisxvIA?=
 =?us-ascii?Q?JdJDIn/49CTf362qt0joWfU4KppIuwl9Ypxk2Gtg9pFBG3+gxnivKFulSq4g?=
 =?us-ascii?Q?Th2fnBnk7hTzSs31KZoSJVhGVhLzUuD3V+28C77ZU1hdfVgXM4eTzS8spcDz?=
 =?us-ascii?Q?OHdoGdyGHiIiAzkOlOnvrToBKtITJf+II8dJ83QgVRHMz74Y/5esKstgPpKO?=
 =?us-ascii?Q?OONNiR0ofde74fL7Klrm5DmmdOoFeVlecdNNVSb8Wz83YBUcQcRTIB7fG8VT?=
 =?us-ascii?Q?VK2n65RlpSDRt2Wa4eNLqguPSv7m8VqUoFDnrxltMhoqgZKy6xENznQOyD6e?=
 =?us-ascii?Q?ECInIsiI2cUX4CEA/UtUaEknpKRa0I//GJhk2RWCbEjqu/ep+qsTmYK9Mslh?=
 =?us-ascii?Q?RjtfKsHUjby3Zj0plrzEkvfypFsD?=
X-OriginatorOrg: orolia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8840a06c-8f5c-4a41-4bb5-08d931c995ee
X-MS-Exchange-CrossTenant-AuthSource: PR1PR06MB4746.eurprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2021 19:53:32.4714
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: a263030c-9c1b-421f-9471-1dec0b29c664
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qF5KuoeLDaiYy90deb5DUdec6yQLUcLOnkcCrGx/UiCNnJG1cKYyKaiOcq4q+whXg/WnNCeriBq6r845D/8mz4j9I3vsGMjP0b1lJh0XaYg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR06MB7710
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

The response slave port can be disabled in some configuration [1] and
csr + MSGDMA_CSR_RESP_FILL_LEVEL will be 0 even if transfer has suceeded.
We have to only rely on the interrupts in that scenario.
This was tested on cyclone V with the controller resp port disabled.

[1] https://www.intel.com/content/www/us/en/programmable/documentation/sfo1400787952932.html
30.3.1.2
30.3.1.3
30.5.5

Fixes:
https://forum.rocketboards.org/t/ip-msgdma-linux-driver/1919
Signed-off-by: Olivier Dautricourt <olivier.dautricourt@orolia.com>
---
 drivers/dma/altera-msgdma.c | 37 ++++++++++++++++++++++++++-----------
 1 file changed, 26 insertions(+), 11 deletions(-)

diff --git a/drivers/dma/altera-msgdma.c b/drivers/dma/altera-msgdma.c
index 0fe0676f8e1d..5a2c7573b692 100644
--- a/drivers/dma/altera-msgdma.c
+++ b/drivers/dma/altera-msgdma.c
@@ -691,10 +691,14 @@ static void msgdma_tasklet(struct tasklet_struct *t)

 	spin_lock_irqsave(&mdev->lock, flags);

-	/* Read number of responses that are available */
-	count = ioread32(mdev->csr + MSGDMA_CSR_RESP_FILL_LEVEL);
-	dev_dbg(mdev->dev, "%s (%d): response count=%d\n",
-		__func__, __LINE__, count);
+	if (mdev->resp) {
+		/* Read number of responses that are available */
+		count = ioread32(mdev->csr + MSGDMA_CSR_RESP_FILL_LEVEL);
+		dev_dbg(mdev->dev, "%s (%d): response count=%d\n",
+			__func__, __LINE__, count);
+	} else {
+		count = 1;
+	}

 	while (count--) {
 		/*
@@ -703,8 +707,12 @@ static void msgdma_tasklet(struct tasklet_struct *t)
 		 * have any real values, like transferred bytes or error
 		 * bits. So we need to just drop these values.
 		 */
-		size = ioread32(mdev->resp + MSGDMA_RESP_BYTES_TRANSFERRED);
-		status = ioread32(mdev->resp + MSGDMA_RESP_STATUS);
+		if (mdev->resp) {
+			size = ioread32(mdev->resp +
+					MSGDMA_RESP_BYTES_TRANSFERRED);
+			status = ioread32(mdev->resp +
+					MSGDMA_RESP_STATUS);
+		}

 		msgdma_complete_descriptor(mdev);
 		msgdma_chan_desc_cleanup(mdev);
@@ -757,14 +765,21 @@ static void msgdma_dev_remove(struct msgdma_device *mdev)
 }

 static int request_and_map(struct platform_device *pdev, const char *name,
-			   struct resource **res, void __iomem **ptr)
+			   struct resource **res, void __iomem **ptr,
+			   bool optional)
 {
 	struct resource *region;
 	struct device *device = &pdev->dev;

 	*res = platform_get_resource_byname(pdev, IORESOURCE_MEM, name);
 	if (*res == NULL) {
-		dev_err(device, "resource %s not defined\n", name);
+		if (optional) {
+			*ptr = NULL;
+			dev_info(device, "optional resource %s not defined\n",
+				 name);
+			return 0;
+		}
+		dev_err(device, "mandatory resource %s not defined\n", name);
 		return -ENODEV;
 	}

@@ -805,17 +820,17 @@ static int msgdma_probe(struct platform_device *pdev)
 	mdev->dev = &pdev->dev;

 	/* Map CSR space */
-	ret = request_and_map(pdev, "csr", &dma_res, &mdev->csr);
+	ret = request_and_map(pdev, "csr", &dma_res, &mdev->csr, false);
 	if (ret)
 		return ret;

 	/* Map (extended) descriptor space */
-	ret = request_and_map(pdev, "desc", &dma_res, &mdev->desc);
+	ret = request_and_map(pdev, "desc", &dma_res, &mdev->desc, false);
 	if (ret)
 		return ret;

 	/* Map response space */
-	ret = request_and_map(pdev, "resp", &dma_res, &mdev->resp);
+	ret = request_and_map(pdev, "resp", &dma_res, &mdev->resp, true);
 	if (ret)
 		return ret;

--
2.31.0.rc2

