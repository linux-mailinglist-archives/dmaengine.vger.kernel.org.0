Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EC39817EF38
	for <lists+dmaengine@lfdr.de>; Tue, 10 Mar 2020 04:31:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726643AbgCJDbk (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 9 Mar 2020 23:31:40 -0400
Received: from mail-vi1eur05on2050.outbound.protection.outlook.com ([40.107.21.50]:21794
        "EHLO EUR05-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726199AbgCJDbj (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Mon, 9 Mar 2020 23:31:39 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jFoDJou0WFEIRHrIJw4nxIzRBRRwJqfy1b4MgdUGT6GAJQame1vLIZ9vo1jSj90vDQQzWAJ5wFXdlyZfW0jh6P6TOeltF1kwkLMgcI36A7xS0LqW3wPBijKee5mE4/oKqtNoJjxvGXXEnf69iIXbfKcI/aHNwrHs6JYdL22h3IHtUnu+Oxzz+SgBJHKeXWVLM1fi1hKBWLCLDo0KmEwE8redwjKkEkP6x+AAfuGZ+5OphYD24b4u/ZM493NvfHQe7JZW2YjAnu+PtcZw0Nmt7ojXhP5+lyuVod/e1NN3SX6fGznYKdkdcwpRfxN7McPrYqyPf3n9oq15JZACX3vXOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yMCp9+GwqV7YGtkoC/1b/rRe5bRX4B3FKVKmudre4KY=;
 b=VV0caItxS8U+0ua3+B2n92LbWH1qGe9MB2gOliiz69Hd4gcLTWslS2P2XpgZK1g+hJ/ozy9zEp3WmQmprAqgy4UxomCTsVUs55iSOnc/2xmw7pTS5camkQbO6GAuWHSCo/15Dy/Fy7AokYjKrpqondlx6vy76QP2AHZZ81azubHMN2M7X2gK9PMnM70q2yC8bv1NRn4qSqehR0QLgkhq/ffBPI2qAuOkqGHPqPaf579Ae4pPNNqSbd/Xwlue+fyixXbbKCpX7cuh9nElrgYBg69AhrND7XRC8TA/nOCUFuxPr38MXYVfMyBPJx46sjosJ8t4KBEpQMR4fjtXDTuphA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yMCp9+GwqV7YGtkoC/1b/rRe5bRX4B3FKVKmudre4KY=;
 b=VfTYe5ir5XCDa+1DKqPdVG4da2tIABijqELZ3XyBlaU6lSo34PWiE5MI5jXbwiVD8f5rFTnVs65tM/4IZ7p8sDNKOPE6MTXXNio+XX0UISQ0EzUFYM4wMn+d/NP6261WHU265WF+a72+IrXl4OGcxqHxxyqJZE2JnkWxdCPBPJU=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=yibin.gong@nxp.com; 
Received: from VE1PR04MB6638.eurprd04.prod.outlook.com (20.179.232.15) by
 VE1PR04MB6511.eurprd04.prod.outlook.com (20.179.233.161) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2793.17; Tue, 10 Mar 2020 03:31:35 +0000
Received: from VE1PR04MB6638.eurprd04.prod.outlook.com
 ([fe80::490:6caa:24b:4a31]) by VE1PR04MB6638.eurprd04.prod.outlook.com
 ([fe80::490:6caa:24b:4a31%6]) with mapi id 15.20.2793.013; Tue, 10 Mar 2020
 03:31:35 +0000
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
Subject: [RESEND v6  10/13] dma: imx-sdma: add i.mx6ul/6sx compatible name
Date:   Tue, 10 Mar 2020 19:31:59 +0800
Message-Id: <1583839922-22699-11-git-send-email-yibin.gong@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1583839922-22699-1-git-send-email-yibin.gong@nxp.com>
References: <1583839922-22699-1-git-send-email-yibin.gong@nxp.com>
Content-Type: text/plain
X-ClientProxiedBy: SG2PR06CA0241.apcprd06.prod.outlook.com
 (2603:1096:4:ac::25) To VE1PR04MB6638.eurprd04.prod.outlook.com
 (2603:10a6:803:119::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from robin-OptiPlex-790.ap.freescale.net (119.31.174.66) by SG2PR06CA0241.apcprd06.prod.outlook.com (2603:1096:4:ac::25) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.20.2793.15 via Frontend Transport; Tue, 10 Mar 2020 03:31:29 +0000
X-Mailer: git-send-email 2.7.4
X-Originating-IP: [119.31.174.66]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 6fc9190e-a9ea-49ee-1fc5-08d7c4a388b0
X-MS-TrafficTypeDiagnostic: VE1PR04MB6511:|VE1PR04MB6511:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <VE1PR04MB6511D5716A41E387E69A7D6589FF0@VE1PR04MB6511.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:632;
X-Forefront-PRVS: 033857D0BD
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(4636009)(136003)(396003)(346002)(366004)(376002)(39860400002)(189003)(199004)(4326008)(5660300002)(6506007)(52116002)(66476007)(66946007)(66556008)(316002)(6486002)(4744005)(6512007)(6666004)(36756003)(2906002)(86362001)(186003)(478600001)(956004)(2616005)(81156014)(8936002)(8676002)(81166006)(7416002)(26005)(16526019)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:VE1PR04MB6511;H:VE1PR04MB6638.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: HOx8yu8zt1drc5walYLRcYItH9WyqbHii2Is0NQZPX5JNAPJbBfDEK96P2iITNW1CdsWoTR5H2ug5dS0R84baF5kfUlE4LOIRKCE4EHRp8J5A1ZTPDmPjbMNHk9jRgYXy8Yuk5lVpT5emsKhDAChSqSE91gCU8korTykqKty0ghV+hWcLQrEsHGFfVLXb0dUvvHUHmT/GJpeDQKFKVGJiUD9ExL/7cWY7Xg3IlBhvuq/iv1wtwKhtBYwR2/DGGNhi34Q0JURl4rR3JVseDeUsxxfJw16+WU6N7OfIK2Yr8gAVrwY9RoIifKIw5P4VQyfykKCLglaNIduWoJidrXv1LjRMOUukdvTY4jjpzt0iK6NIGGMiJlfMviEho6XVmkLXGtgizlQaoOt+pPoBjMlMgYOWn8/jWcEW6fg35OHqW4EUgwW0nPVeMjTrEp6Kve0xqBQnjFYEgfvl5KU4SGf0jxXC3z5nL0TuRzyJ07RGTgtEdMwCtdeyXSUKlskBkEJ
X-MS-Exchange-AntiSpam-MessageData: eeOk07RSIJdz0v0TtF40AJNs2Pq1X/vcbFo75TmSvPASVdIGVGRdIPTCLKOlhGer6Ixmu3HziGCpoLlGNZ7GLaNv2O+ZOxkPf8vNjQUag26C/nOauMp5PEZzQfRhg18u28sB7sXdW/MtBLkJVZwRDg==
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6fc9190e-a9ea-49ee-1fc5-08d7c4a388b0
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Mar 2020 03:31:35.1489
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7qwTaY2NPhDMhVUpTsPNQbxFMJIeHKMuRa59OYqWVYmGnILnp6BxTAev6s4fv58TaMjVCauoO3Pquaj4nX5CSA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR04MB6511
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Add i.mx6ul and i.mx6sx compatible name in binding doc.

Signed-off-by: Robin Gong <yibin.gong@nxp.com>
Reviewed-by: Rob Herring <robh@kernel.org>
---
 Documentation/devicetree/bindings/dma/fsl-imx-sdma.txt | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/dma/fsl-imx-sdma.txt b/Documentation/devicetree/bindings/dma/fsl-imx-sdma.txt
index c9e9740..19c963b 100644
--- a/Documentation/devicetree/bindings/dma/fsl-imx-sdma.txt
+++ b/Documentation/devicetree/bindings/dma/fsl-imx-sdma.txt
@@ -9,6 +9,8 @@ Required properties:
       "fsl,imx53-sdma"
       "fsl,imx6q-sdma"
       "fsl,imx7d-sdma"
+      "fsl,imx6sx-sdma"
+      "fsl,imx6ul-sdma"
       "fsl,imx8mq-sdma"
       "fsl,imx8mm-sdma"
       "fsl,imx8mn-sdma"
-- 
2.7.4

