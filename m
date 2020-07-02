Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DAE67211C46
	for <lists+dmaengine@lfdr.de>; Thu,  2 Jul 2020 08:54:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727097AbgGBGye (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 2 Jul 2020 02:54:34 -0400
Received: from mail-eopbgr60071.outbound.protection.outlook.com ([40.107.6.71]:12347
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727860AbgGBGy2 (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Thu, 2 Jul 2020 02:54:28 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UZhf5iVOhsOEbDZUzZc6+6T7DqcleXc1wwhHKXBrmRj5mYV0pwURtbDlHKQ3BmECoU6mADo+IixXFrFBnsUdfrW4YVKMjckToHLYSroFN109HN3sq+Myqp9GxasUMRko2V6aN36O0YOiYkNJytWZKhr7OQb7Z1O8Iq5EIZ5YJJ0P2EjZ0QzvihqHhf73HiisBxgiHAvVo6IUrozFywaSSsemTLVb5vEA+tm27AErBUd3QphjJ4jf2fbRWi3bgjsDE2IkM0zLVSNjfS9SRmU8BwcaokeJ+0FIAn5ErDfWzrFBjv4CTRvBCCbejj6ozYcmgXr8WA1Ior88PSNDquXy3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A2NdxpnZ7ORXZIN0STWcEdx/uXHR9LGHSHi6z30B7x0=;
 b=T7aEvnweowQFqwHU5iHsBjrMVsnBdIz9EKzQYKDoXjmWrPbJeS0kBZmlovmMnMwoYx5DQZZXzy6oINiDGZjyUECTG9tazN8Gv5Z5xf8Xk+3iDKOoMw18t+7q2zXkujWutBHRPFNhRJiC41xzFcpuEq6FvPFuxJvSpXt3YNcPOYMKXRboGHkx2grEQY4JOdbiowtBddRisl4QShh9I6U4+RBCcpNp1Kd9ZjQTfN1V5ZIrmOzft9ct6PmCEsNzyj8og7q3Yix+yWJWAKesvCGYxqZhW7Rom/rknn/DlvxTD8W2eYexshDietybcsZJyxV/KhO12FKmzjc/A9D71pTdCA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A2NdxpnZ7ORXZIN0STWcEdx/uXHR9LGHSHi6z30B7x0=;
 b=UlPPQ4kNWquRaX55jWmgKMW3WGh7x897fsPFs2kJyjOx4sc0dr7yCk5/j5EPzj+rNCSuzetHpR6GuLgXXp1rTIeZP9TWA57sXwICox1hgKkfuuFhXkZ0CRKtktQ2zQWefBu1MHjWR584nAnDRkf6q+gcm6Vz6b0uURqk9e517ss=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=nxp.com;
Received: from VE1PR04MB6638.eurprd04.prod.outlook.com (2603:10a6:803:119::15)
 by VI1PR04MB6943.eurprd04.prod.outlook.com (2603:10a6:803:13a::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3153.22; Thu, 2 Jul
 2020 06:54:21 +0000
Received: from VE1PR04MB6638.eurprd04.prod.outlook.com
 ([fe80::5cc4:23a5:ca17:da7d]) by VE1PR04MB6638.eurprd04.prod.outlook.com
 ([fe80::5cc4:23a5:ca17:da7d%6]) with mapi id 15.20.3153.024; Thu, 2 Jul 2020
 06:54:21 +0000
From:   Robin Gong <yibin.gong@nxp.com>
To:     vkoul@kernel.org, robh+dt@kernel.org, shawnguo@kernel.org,
        s.hauer@pengutronix.de, festevam@gmail.com,
        catalin.marinas@arm.com, will@kernel.org, dan.j.williams@intel.com,
        angelo@sysam.it
Cc:     kernel@pengutronix.de, linux-imx@nxp.com,
        dmaengine@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: [PATCH v1 9/9] arm64: configs: defconfig: add CONFIG_FSL_EDMA3
Date:   Thu,  2 Jul 2020 23:08:09 +0800
Message-Id: <1593702489-21648-10-git-send-email-yibin.gong@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1593702489-21648-1-git-send-email-yibin.gong@nxp.com>
References: <1593702489-21648-1-git-send-email-yibin.gong@nxp.com>
Content-Type: text/plain
X-ClientProxiedBy: SG2PR01CA0172.apcprd01.prod.exchangelabs.com
 (2603:1096:4:28::28) To VE1PR04MB6638.eurprd04.prod.outlook.com
 (2603:10a6:803:119::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from robin-OptiPlex-790.ap.freescale.net (119.31.174.67) by SG2PR01CA0172.apcprd01.prod.exchangelabs.com (2603:1096:4:28::28) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.20.3153.24 via Frontend Transport; Thu, 2 Jul 2020 06:54:16 +0000
X-Mailer: git-send-email 2.7.4
X-Originating-IP: [119.31.174.67]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 10863af6-0982-45af-b54e-08d81e54bf20
X-MS-TrafficTypeDiagnostic: VI1PR04MB6943:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <VI1PR04MB694356E963068EAC5E4ED81E896D0@VI1PR04MB6943.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:843;
X-Forefront-PRVS: 0452022BE1
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jGFG4eB+Bu/LQgwWFM0sXqnoknm2ibsM7R8CMSWh5An1fTN+g2T+SvWzs0W1We9j4HECer0d10TmDysRaBgflD/2yKk9X49BGhtkcv6Qaq4gH1hylp3O5D3WoLFhwzyYW2cVmtpN+t9yFQSTEorTLNICBh823cvcuj7JTLRHKNyqZegzqwD4kAqB3Adp4r0+g9LY0ogzbdLSBMuqwvMVxNYnjyqrne8gX/bePyvhMoILjdFDliQB2XIRLqggZrAq7HFWhhIMIXp81MvuzHJRLOo0f9k7v4YiPX8EvRPDrxfPBdCTjQMuexSqximMyBEFbGzAoMU/iMAhEEfbcnocmw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VE1PR04MB6638.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(396003)(136003)(366004)(376002)(39860400002)(346002)(66476007)(6666004)(66946007)(66556008)(52116002)(36756003)(8936002)(2616005)(6486002)(956004)(6512007)(186003)(7416002)(4326008)(26005)(2906002)(8676002)(86362001)(16526019)(4744005)(478600001)(6506007)(5660300002)(316002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: T128/5vYyRZ6l25+y79xZWixw+CxxkwFUiVoiHB5/rXyAiOEPWIDNxQ2WQbH8P5AjvB53YxbDCq6PKLIL5gz5x9lEO4RNHvfcgrH0epn3fj6mUbgiuS75ka/OROVQSohcACSOO3AKFjwD/xaZ3f+kAA1GMRbHVRjVBVuKLbmbQnEHWrpmVhJcX0nbllQSM/eUsJ+2Oj0gRJfq5+cblv6+Q3vRQL2/sd1pQG0p9/A7NUd1Age1GrlymMULkVBi7PcX41aFdGfcIBh48rB2DVEOtYE1sh7VrW/Bg1W/tERx011+KSqgbzSR0q7ylC3415TNy2qt08IShlRw+fCHlsnoNDdVChYq+Lqe/7gFra2GTmTCpv40DB71GuVuifcoeujHpFDxksumK4/rQeFwmiHEo4BY7OUKCi1F8dAz5waGHUj7RQPBda5D+WExmeXnvZpru/tCUxVJ5ItqZmNlZfi4Jjl1nhNCh0dKjzPjjsDRzI=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 10863af6-0982-45af-b54e-08d81e54bf20
X-MS-Exchange-CrossTenant-AuthSource: VE1PR04MB6638.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jul 2020 06:54:20.8981
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9r0myXAh4MsxYhv3yceY8e7MyiEjOLQXdZpTUCX0KVedkNLnbWvzBeH7zs78dDZkSCve1kGeQH1iHCa4NcX4BA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB6943
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

