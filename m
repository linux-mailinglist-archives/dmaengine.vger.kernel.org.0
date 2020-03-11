Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0829318132E
	for <lists+dmaengine@lfdr.de>; Wed, 11 Mar 2020 09:36:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728732AbgCKIfy (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 11 Mar 2020 04:35:54 -0400
Received: from mail-vi1eur05on2057.outbound.protection.outlook.com ([40.107.21.57]:5249
        "EHLO EUR05-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728731AbgCKIfx (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Wed, 11 Mar 2020 04:35:53 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=b5SUwrKOIPVwSVKG2i1CXVHir2GUdoO9MFxme9ymTpL9hbks+sPOSQqTib5Yjuyl6ux+kWva+RpjievK8UqvgRC9wkedFQUG+4Y9EiPyvmwaENC7fN1fSFxnkBbgRIsatFUgYe/WdT+7Bxjvm8+uyj2u++M4/RJgK0ouotWy+sjtkrlGv8FiEh4gx/1E4Q5Igpz0fLe4DUAcXSa/v+903ECf8fqLSOwkiC7WU/zpwAThwQOpWxxfRp3AZjIG7yddEW7+WaMINhPlZ1fSc/8XJ1byoRbaybFI56f+yma6Tra2SY/+i9RV6CSXE7vhvDbLU0+kyjP3sJJ9xfdjAg4TAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DZVGY7HSfJlKI0KpbP6KFaPYGNl35gy4W2Hb3NamZjY=;
 b=nWEoqZ8hct8MlBSBrrphyLMrzmu+clZSs049tz57NiDaBZJ5u0ka09tAa4u39TGykIpPeJxrqfIQsrlalncj8qkl5ZrqGDFLMsVh3/dpImLpNby4HtXxfHLQCv8o/t4Im13OAv1TZRtv3luHjOBlZpxelrsfG6phPe2xmMNlhprK86YddZxraLEBSv7amXpS9zQa7FIxZJMnP3k5v7OaEbRITdTrklYPtAjQLI8V/lprqgLqPpqr+EuW/i1VB0VP7p5XbFQ5d1ZMPGqwS3ohjtd25LANpnYqsZwycX5fNjSkPC9hRuFS6NQOgI4p+6sxYAdBa0KjFjQYh6Ci/iqksA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DZVGY7HSfJlKI0KpbP6KFaPYGNl35gy4W2Hb3NamZjY=;
 b=fCxRMYUmpi9ZwM/ahsQLJptAHv/PcUo8kbkdmMNtproVCbfMEPZd3guyjQdVSz1/Z9Exz89w1PTn3ffl+/+KEhsDlg1XUp4MmFpz4Z8/jQNdqS+hMprw5xMhfBSbELMcRDKOt/vcw31Y0KF4xrmY9BL23I5DsC9KP9ZE5AdROdw=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=yibin.gong@nxp.com; 
Received: from VE1PR04MB6638.eurprd04.prod.outlook.com (20.179.232.15) by
 VE1PR04MB6462.eurprd04.prod.outlook.com (20.179.232.205) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2793.15; Wed, 11 Mar 2020 08:35:49 +0000
Received: from VE1PR04MB6638.eurprd04.prod.outlook.com
 ([fe80::490:6caa:24b:4a31]) by VE1PR04MB6638.eurprd04.prod.outlook.com
 ([fe80::490:6caa:24b:4a31%6]) with mapi id 15.20.2793.018; Wed, 11 Mar 2020
 08:35:49 +0000
From:   Robin Gong <yibin.gong@nxp.com>
To:     s.hauer@pengutronix.de, vkoul@kernel.org, shawnguo@kernel.org,
        u.kleine-koenig@pengutronix.de, broonie@kernel.org,
        robh+dt@kernel.org, festevam@gmail.com, dan.j.williams@intel.com,
        mark.rutland@arm.com, catalin.marinas@arm.com, will.deacon@arm.com,
        l.stach@pengutronix.de, martin.fuzzey@flowbird.group
Cc:     kernel@pengutronix.de, linux-spi@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-imx@nxp.com, dmaengine@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: [PATCH v7 06/13] dmaengine: imx-sdma: add mcu_2_ecspi script
Date:   Thu, 12 Mar 2020 00:36:29 +0800
Message-Id: <1583944596-23410-7-git-send-email-yibin.gong@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1583944596-23410-1-git-send-email-yibin.gong@nxp.com>
References: <1583944596-23410-1-git-send-email-yibin.gong@nxp.com>
Content-Type: text/plain
X-ClientProxiedBy: SG2PR04CA0158.apcprd04.prod.outlook.com (2603:1096:4::20)
 To VE1PR04MB6638.eurprd04.prod.outlook.com (2603:10a6:803:119::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from robin-OptiPlex-790.ap.freescale.net (119.31.174.66) by SG2PR04CA0158.apcprd04.prod.outlook.com (2603:1096:4::20) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.20.2793.15 via Frontend Transport; Wed, 11 Mar 2020 08:35:43 +0000
X-Mailer: git-send-email 2.7.4
X-Originating-IP: [119.31.174.66]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: ff8cc8b6-5f86-4de6-600c-08d7c5973382
X-MS-TrafficTypeDiagnostic: VE1PR04MB6462:|VE1PR04MB6462:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <VE1PR04MB64629A59833729EF66D77D1D89FC0@VE1PR04MB6462.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:361;
X-Forefront-PRVS: 0339F89554
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(4636009)(366004)(39860400002)(376002)(346002)(136003)(396003)(199004)(52116002)(7416002)(36756003)(5660300002)(6506007)(8936002)(478600001)(66556008)(66476007)(66946007)(6666004)(316002)(2906002)(86362001)(2616005)(956004)(4744005)(6486002)(81166006)(16526019)(186003)(81156014)(8676002)(6512007)(26005)(4326008)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:VE1PR04MB6462;H:VE1PR04MB6638.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;
Received-SPF: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +XWEZpbpTpIcvNoNPoNCa/sQIkngmk7ZCVP/gX0yCKshauRfWrz+tl+RKAybnD3r8/3QsiI6zYjuMfGJDnKtYGc+A+pJuVFIUMJgqb6JwxRJGJObCDjfeM9WwlaL7xJxRG5u6wjYpITJdN+jqK2NaUw+9DuAbg0nFnyCFPoji6cOTJiyOYJJe+ybtBmfqmnZrTpfo92PgCGi/Yy7bbyzFm6kme6ls19dFOMu4W11YZBQ2ZT01M2CtPfUNhiuVhrc8TmdaonR6qijdvDtaamRdqUQtG6JJWSFLER0C8l0EmMY8uRPoYPgjLd7LoNyfEEZPO1Et2FkTDd6yYlJFEOyCgs3o9Mk2ROXuXI40k7lFwLuR1yZlNLYg5GmeZV48ma3FASC4VFtkW2lEE+Na64EyY8zzJVWjBN/9YQY9VjwC1YFnRi3zJwny46wMHcmtrMlrdIhtv64DOP4Kwx8/07hbBI+xRkZZjZxbfN/zGTCKhczSP87GHgpYn49MBBqzpVF
X-MS-Exchange-AntiSpam-MessageData: rzpRji5kb7Z2NGAMpq2fqesrr0CCKTIBw1mUq3093mqMHlJ7+ysoElxnWyyL/1GyW1gjJXBkBiUsmtliTcibRsIpslWCdYUxz6Ct2ZuPmWFSBkOH/69dgu8tF5VRkBFf2oh83iPJIkD/kELB46mbww==
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ff8cc8b6-5f86-4de6-600c-08d7c5973382
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Mar 2020 08:35:49.4248
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AGS5K2NIOcCLORJNI7VWwRsix+DdhNi9Mx1NPScd9YUfAwpKsPGfw4EOh5WQtfCoZD86a/hHzlkEdPltGYrZKg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR04MB6462
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Add mcu_2_ecspi script to fix ecspi errata ERR009165.

Signed-off-by: Robin Gong <yibin.gong@nxp.com>
Acked-by: Vinod Koul <vkoul@kernel.org>
---
 drivers/dma/imx-sdma.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/dma/imx-sdma.c b/drivers/dma/imx-sdma.c
index 69ea44d..e034375 100644
--- a/drivers/dma/imx-sdma.c
+++ b/drivers/dma/imx-sdma.c
@@ -920,6 +920,9 @@ static void sdma_get_pc(struct sdma_channel *sdmac,
 		emi_2_per = sdma->script_addrs->mcu_2_ata_addr;
 		break;
 	case IMX_DMATYPE_CSPI:
+		per_2_emi = sdma->script_addrs->app_2_mcu_addr;
+		emi_2_per = sdma->script_addrs->mcu_2_ecspi_addr;
+		break;
 	case IMX_DMATYPE_EXT:
 	case IMX_DMATYPE_SSI:
 	case IMX_DMATYPE_SAI:
-- 
2.7.4

