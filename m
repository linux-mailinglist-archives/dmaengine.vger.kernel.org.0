Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E95DA20ED77
	for <lists+dmaengine@lfdr.de>; Tue, 30 Jun 2020 07:25:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729768AbgF3FZ0 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 30 Jun 2020 01:25:26 -0400
Received: from mail-am6eur05on2040.outbound.protection.outlook.com ([40.107.22.40]:63552
        "EHLO EUR05-AM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729771AbgF3FZ0 (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Tue, 30 Jun 2020 01:25:26 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dgloDc/kq/Nhgm73zaBMo2C3aQaeAQ6JV+8ejrb6QnGDY40QqTWiOErdPaNe3t1bfwvCZCpeL6TxpM965piJMV6bh1m6ZU0G/JW7aydEds2WfUwf2BXMZX89mdoykQwCoAd1Jbbs9oSo2hYnpEYpBdsESnijBDkDPYs+rh64err6a4YzyyQZgYxv7XIIs+gNL6rKWl98auk0gIpFh8ETLiFT7nS80TzUU0lek/peBCfeWCfM/TJfmMyBlPxwtUprkxHUxDBwoDI2oQRgpjKuCxidlF7oigv1HbCuI91JFB1CRKbFVs59VWotxweYk19MlWEsowZh/sNH5EIE6QRo8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5jxJdGqHBF995O2koMhPVubVtg1S3gV8z8tbdE75gTs=;
 b=nkIItSGmeFEDpLhng4zanv8M5F4+vJb5T99swQ+qG+bmvHsukIFsV4xBNXJJTAdHsZn7K4DUhVGzX7mqs3DpAMEVmK38D6dr2UvlE3Vkf+xd2SDCbNKjK/1nLzjKMLu7//D5fuUW4zb0VeP8lMaUh+LjTXFOtZYyY/YBVsrgPdScNVYf1FpT4An6eXuNxPAKA0oU7a7Lk1/R7QFohGaST9qBtz1NUAsJrm0yRhp8/m16ORzh40fspaj2kOPFmkUMF4zlSoNY+HHRBOUSfs05ba6WFnehh3uPlrax6vrkNPFbCunRppuWSWNn+juRqx3HuCs0sPazxeYdf4Qh1n5Wbw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5jxJdGqHBF995O2koMhPVubVtg1S3gV8z8tbdE75gTs=;
 b=aKluv4vO4GY8xGloBrfADifCbiKC7EVnI/Eg3HnKNDVmITz9aP9xgajbHNv5bSWvj60ke7Tyik7LDNanMxpGwBYiVgysRKI5RORnHe52jcRZWtDUO9kSGhyyZbj5CbdbR6/IdnDrt9Q3ZWH+ZHD3c5xEW/YYK9R7DR71S5oKE5k=
Authentication-Results: arm.com; dkim=none (message not signed)
 header.d=none;arm.com; dmarc=none action=none header.from=nxp.com;
Received: from VE1PR04MB6638.eurprd04.prod.outlook.com (2603:10a6:803:119::15)
 by VE1PR04MB6640.eurprd04.prod.outlook.com (2603:10a6:803:122::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3131.26; Tue, 30 Jun
 2020 05:25:19 +0000
Received: from VE1PR04MB6638.eurprd04.prod.outlook.com
 ([fe80::5cc4:23a5:ca17:da7d]) by VE1PR04MB6638.eurprd04.prod.outlook.com
 ([fe80::5cc4:23a5:ca17:da7d%6]) with mapi id 15.20.3131.028; Tue, 30 Jun 2020
 05:25:19 +0000
From:   Robin Gong <yibin.gong@nxp.com>
To:     mark.rutland@arm.com, broonie@kernel.org, robh+dt@kernel.org,
        catalin.marinas@arm.com, vkoul@kernel.org, will.deacon@arm.com,
        shawnguo@kernel.org, festevam@gmail.com, s.hauer@pengutronix.de,
        martin.fuzzey@flowbird.group, u.kleine-koenig@pengutronix.de,
        dan.j.williams@intel.com, matthias.schiffer@ew.tq-group.com
Cc:     linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        kernel@pengutronix.de, dmaengine@vger.kernel.org, linux-imx@nxp.com
Subject: [PATCH v10 09/12] spi: imx: add new i.mx6ul compatible name in binding doc
Date:   Tue, 30 Jun 2020 21:31:13 +0800
Message-Id: <1593523876-22387-10-git-send-email-yibin.gong@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1593523876-22387-1-git-send-email-yibin.gong@nxp.com>
References: <1593523876-22387-1-git-send-email-yibin.gong@nxp.com>
Content-Type: text/plain
X-ClientProxiedBy: SG2PR06CA0132.apcprd06.prod.outlook.com
 (2603:1096:1:1d::34) To VE1PR04MB6638.eurprd04.prod.outlook.com
 (2603:10a6:803:119::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from robin-OptiPlex-790.ap.freescale.net (119.31.174.67) by SG2PR06CA0132.apcprd06.prod.outlook.com (2603:1096:1:1d::34) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.20.3131.21 via Frontend Transport; Tue, 30 Jun 2020 05:25:12 +0000
X-Mailer: git-send-email 2.7.4
X-Originating-IP: [119.31.174.67]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: fd94ad4e-177f-49c8-6f92-08d81cb5fa41
X-MS-TrafficTypeDiagnostic: VE1PR04MB6640:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <VE1PR04MB6640442FE16155013F7DD54C896F0@VE1PR04MB6640.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3276;
X-Forefront-PRVS: 0450A714CB
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rS71ymX8QOnF1zx6mit8v81MTQJH8rVTVomB+J9DonwiZlUkvlcsq0w3Jd3wHhYrHjtGurcMuAvVDRQIuuocnraiWSOu1tCUMIXb4DDegH6PK9fTBULDE9UxoS2hmusjx9950RjuYS6nbh7br7i6xoq8xhN/AQ/L4AyBWBtOBquzfHNNEo8fKfc+TXsGh6EltVrhVXAKx3nQ753PS9zXxCCOcducsJ+5tCkwSK3EKN5f2F6xGRwP0wNk6bYCOiEWg2THkcURiYaN1ytFEz8BgIfhyqI2Ui+7eWpnndWQpMenHsCF/kI3oU5Vf007+5cVcQ9LItrpv1YHknPM3kDN6u5o47GYvcNJa0q9HZBiNeBjcaJxzoAem1wPYz8vXAEv
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VE1PR04MB6638.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(376002)(346002)(136003)(39860400002)(366004)(396003)(86362001)(956004)(2616005)(52116002)(7416002)(4326008)(6506007)(6486002)(2906002)(5660300002)(186003)(26005)(36756003)(16526019)(8676002)(478600001)(316002)(66946007)(66476007)(6512007)(8936002)(66556008)(921003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: bMaIAet3i8cL0cMNpLJGJ9dV0jK0bX1446ylf3q5vTeH0dZWQUqjRlitIrZh+H27cCTQ6PbqAUWHDs8HOkDcbpzMPG2JWa1xQmOVr2FR5GDjeGGggf3K2C7TQIteaSqrh+6hcaGSbRTScx6H1NBUnbvikavOlQ3c/pZsKRRpJLFB9IAKint8AFn1brD83gwxgVn/3ooQcXhfs7ulHPVMnX3I6g1nNogDThxavAJ2eBYisI9BJ21DlxPPRHWozm+LY/GBK8BCw8SxGuXf/G29PwWTvV7PFGtzf6+MGA35rNitxWhGhPkGWe00vT+E/JgGGM2CvMHDq8WIEjCJW5Uthv4xK1wST5e+tkLQlD3FbILcgCTQwtm6u1mHuGaA1aB796WKuwPNbvWvIRNj5eB3Pz33k5Sh7ET3eBWdAVGdE2239AQEhlZzQhWJt6eliuEKq+Nxe5qCaruM4xPQnMyjZMRpSauekfXSsivc3HGeO90=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fd94ad4e-177f-49c8-6f92-08d81cb5fa41
X-MS-Exchange-CrossTenant-AuthSource: VE1PR04MB6638.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jun 2020 05:25:18.9583
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uUjbvqnqvoamJLLtCgo2Zvy1JsMJNQqZ5/3UUjMp6YJh0DfoTpZ6Kl5u+MEU9Rvg7E4Bj3qJqoHgwYgxUYnJyA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR04MB6640
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

ERR009165 fixed from i.mx6ul, add its compatible name in binding doc.

Signed-off-by: Robin Gong <yibin.gong@nxp.com>
Acked-by: Mark Brown <broonie@kernel.org>
Reviewed-by: Rob Herring <robh@kernel.org>
---
 Documentation/devicetree/bindings/spi/fsl-imx-cspi.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/spi/fsl-imx-cspi.txt b/Documentation/devicetree/bindings/spi/fsl-imx-cspi.txt
index 33bc58f..0a529ba 100644
--- a/Documentation/devicetree/bindings/spi/fsl-imx-cspi.txt
+++ b/Documentation/devicetree/bindings/spi/fsl-imx-cspi.txt
@@ -10,6 +10,7 @@ Required properties:
   - "fsl,imx35-cspi" for SPI compatible with the one integrated on i.MX35
   - "fsl,imx51-ecspi" for SPI compatible with the one integrated on i.MX51
   - "fsl,imx53-ecspi" for SPI compatible with the one integrated on i.MX53 and later Soc
+  - "fsl,imx6ul-ecspi" for SPI compatible with the one integrated on i.MX6UL and later Soc
   - "fsl,imx8mq-ecspi" for SPI compatible with the one integrated on i.MX8MQ
   - "fsl,imx8mm-ecspi" for SPI compatible with the one integrated on i.MX8MM
   - "fsl,imx8mn-ecspi" for SPI compatible with the one integrated on i.MX8MN
-- 
2.7.4

