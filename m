Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8643F21ECD3
	for <lists+dmaengine@lfdr.de>; Tue, 14 Jul 2020 11:28:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727790AbgGNJ2H (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 14 Jul 2020 05:28:07 -0400
Received: from mail-vi1eur05on2067.outbound.protection.outlook.com ([40.107.21.67]:28736
        "EHLO EUR05-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727108AbgGNJ2D (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Tue, 14 Jul 2020 05:28:03 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nHNseIFayM8nJbHGX+fB3d/AzMmU7MKVf8RoDJ9SwBcdwn7EjTKNfHQ4lEtpbvhQiCZ1BS0iVbCWcf7wO2Ry9VxvBtxym8yhqoSohgNXah5Dx7w7TnDB2atmk/XIj7CeLEc7poWoRD7+M48OHhWiyHwJrqTXMXgN+ciHstEbw+BXimur/KMUo09OLyrz8jZyzYxGNXS3cq+m2bXV93/FuWZe7Ea3uMuFAaXRb8a8LJPVYYvJNzPNm7SpRo27OFwEq/ne8HFuh8P6qe7Pjl8R/l8BzNRU365X+k7KH8Wb70dGPW4H91PnJ2wtkkBcdVeB9sREHfyeQR54xP3PHjVbRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A2NdxpnZ7ORXZIN0STWcEdx/uXHR9LGHSHi6z30B7x0=;
 b=G4fGXGLwYDyaD4JjLI4tKii9Ae0EQUzDAtu2rdkTbRkcNIvB+VwQSwCo7bZsLOFquLI/P17qxIrZBGah7IMRiCLksvjyKSz07U0RlzyRz2bpAZ18DUztjKBKCe8Mb1F5aL0eUjiV5VSPAFxQdos/MBcQyK1ZPmTBzq+hRKGJoGtq7Pyheg8xy4qnCwheQPi4ZREL/KelpeNPusNl5a/6ZDbf6vDSfxcU12qTyO9fIv4sRjerWO0vM5+Zpuq2uwhVoIbupK4QyKneK74+SxDBqacKW3xMUiGswNdAJQshDhsHPxGFMSEFOEnb6aLbwj3/frL30ff+8no+gAXaItiZzA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A2NdxpnZ7ORXZIN0STWcEdx/uXHR9LGHSHi6z30B7x0=;
 b=H91ilHOeG46NgwDCD/tqljUYKzNgsqUPWt6I0nTt66mIFhyxvlXhgbYgel0+d8Xg5un1PvChe8ofQwj5Ir4kdIKppANNGPmoabexagS2/HVCdbciKr01TsNfR2ASLigGgfL0XxxSd/x4XJKL0n8lHhecVGakvUN24YVEJ4wTz8c=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=nxp.com;
Received: from VE1PR04MB6638.eurprd04.prod.outlook.com (2603:10a6:803:119::15)
 by VI1PR04MB5294.eurprd04.prod.outlook.com (2603:10a6:803:5a::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3174.20; Tue, 14 Jul
 2020 09:27:59 +0000
Received: from VE1PR04MB6638.eurprd04.prod.outlook.com
 ([fe80::5cc4:23a5:ca17:da7d]) by VE1PR04MB6638.eurprd04.prod.outlook.com
 ([fe80::5cc4:23a5:ca17:da7d%6]) with mapi id 15.20.3174.025; Tue, 14 Jul 2020
 09:27:59 +0000
From:   Robin Gong <yibin.gong@nxp.com>
To:     vkoul@kernel.org, robh+dt@kernel.org, shawnguo@kernel.org,
        s.hauer@pengutronix.de, festevam@gmail.com,
        catalin.marinas@arm.com, will@kernel.org, dan.j.williams@intel.com,
        angelo@sysam.it
Cc:     kernel@pengutronix.de, linux-imx@nxp.com,
        dmaengine@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: [PATCH v2 9/9] arm64: defconfig: add CONFIG_FSL_EDMA3
Date:   Wed, 15 Jul 2020 01:41:48 +0800
Message-Id: <1594748508-22179-10-git-send-email-yibin.gong@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1594748508-22179-1-git-send-email-yibin.gong@nxp.com>
References: <1594748508-22179-1-git-send-email-yibin.gong@nxp.com>
Content-Type: text/plain
X-ClientProxiedBy: SG2PR01CA0092.apcprd01.prod.exchangelabs.com
 (2603:1096:3:15::18) To VE1PR04MB6638.eurprd04.prod.outlook.com
 (2603:10a6:803:119::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from robin-OptiPlex-790.ap.freescale.net (119.31.174.67) by SG2PR01CA0092.apcprd01.prod.exchangelabs.com (2603:1096:3:15::18) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.20.3195.17 via Frontend Transport; Tue, 14 Jul 2020 09:27:55 +0000
X-Mailer: git-send-email 2.7.4
X-Originating-IP: [119.31.174.67]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 9462c6d3-4389-4caa-25de-08d827d832c0
X-MS-TrafficTypeDiagnostic: VI1PR04MB5294:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <VI1PR04MB5294D8226713198BD7471B0289610@VI1PR04MB5294.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:843;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3Y4THoceFZQYY2vKBYqq/DK3G6HRQZK+C2UQC+kbSRTjshnKy9NBHlepouzX2s4OeJuMlf8UClEJQhlwaxPCyjslwhjOhpwIezaARdvi627dgD+4WCPj2to7rXCNg/NvmwvHJsfOUE5vU7p2TiU2jNfvna+bEwXHTH92Okznc7BxEVPcB+6wECp45g0iLdRqofSqWnjKn3eEm10IOuQ8lTuwh/5/hOtYQiF96P9XP53akmGbEaHKYCa/DEPv5sQHLuZ9/VKcOX0lNwuJp2vVVupFjR3tNdgcJ/Rnah8FdEZBt9mC5pKHHctgSQecO0QgsjIu5/r3z7EFSsheaYhJ7g==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VE1PR04MB6638.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(136003)(39860400002)(396003)(346002)(376002)(366004)(478600001)(16526019)(2906002)(186003)(6506007)(26005)(2616005)(4326008)(5660300002)(316002)(956004)(8936002)(6486002)(36756003)(7416002)(52116002)(6666004)(66476007)(86362001)(4744005)(6512007)(8676002)(66946007)(66556008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: masRN3oFD8XbIzh21iniBc/ZT+GmA819FN+o4JnuzpSoXx8osm3t7CM7nP8GonlDmomJmIj3JhF8pRCXkmUoQXT1u2EA5DEz4GmV6HexNnQrHL61Z08ThalgmOj8FNdspGCcGX+9Iu/mc9FllPoZlwvhckfVEQ4Vl5nMvlgUUtvPa+xdzpASXVt0RWa78T+hv5UtH/ZwKlhN3Cm5de2H/lAtmOJTE44fiPT+preY112LGfon1n2wOamlc6k8YoPqQ/uD1Ur3XYDLgiT1vnxXVo6F8b8UgPD4QL/C777YZ6zpnCQSQTWR7JSgp3s7EDHyMHYmSzP/FCqQ5H1CfEhA+wbASsRi3PzttVa28vt0TilswXtGk3/RiWRWKW0nb+ZgcrTNM0fNc9ddE3c3mZQkaeJFTPAcHtg9cj+aXge4zTN4vLsgZAA2kFyIVST973hkDKIYpdn3BR/fXUDN80wlZBMrh00Kz4PmWvsjzzvQ0Ik=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9462c6d3-4389-4caa-25de-08d827d832c0
X-MS-Exchange-CrossTenant-AuthSource: VE1PR04MB6638.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jul 2020 09:27:59.4575
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vESfhv3JQu+liPZYcgxaGW44iYCzlfP8m5wq9AuFq33D+U0g0+7Y2fGvU8tIHd5bgWvLsI7vjAgjKZeC8/flww==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB5294
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Add CONFIG_FSL_EDMA3 for i.mx8qxp/i.mx8qm.

Signed-off-by: Robin Gong <yibin.gong@nxp.com>
---
 arch/arm64/configs/defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index ae76fae..d786bd9 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -770,6 +770,7 @@ CONFIG_DMADEVICES=y
 CONFIG_DMA_BCM2835=y
 CONFIG_DMA_SUN6I=m
 CONFIG_FSL_EDMA=y
+CONFIG_FSL_EDMA3=y
 CONFIG_IMX_SDMA=y
 CONFIG_K3_DMA=y
 CONFIG_MV_XOR=y
-- 
2.7.4

