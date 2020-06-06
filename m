Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 93DD41F076C
	for <lists+dmaengine@lfdr.de>; Sat,  6 Jun 2020 17:22:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728943AbgFFPWF (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Sat, 6 Jun 2020 11:22:05 -0400
Received: from mail-eopbgr80053.outbound.protection.outlook.com ([40.107.8.53]:14305
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728931AbgFFPWB (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Sat, 6 Jun 2020 11:22:01 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nRive39exi3DNqD0lI1gU+GVrnOMlKZ7taTlUkHLxBM7d0xdF8qE8B7n7qzLTVK+V84HeQaHqqYVwkOkUmC7Shmx54+iKHlaujOePA+yDOX9M9soTJ5zimTVXtJBh8envVWMWQiJph3Ph7InTO/x1wY3LykDCYCnlTN6/2U2/QEL48Ktx3vobS3eGW25nG9hnYQ5ZcTfQaRrD7jD+hOMvj2c8cbv9va1xtYaBqA6BmPoci5ojmfcwjsED5KspbEtwy0y82VgaTW4qfY8KVw8Dd8g95qJ1JRjnh2BW5q327ZH17V3VLZI3Mu1zk7VI61ShsKa5TowiL/b7sTX+1Bdzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5jxJdGqHBF995O2koMhPVubVtg1S3gV8z8tbdE75gTs=;
 b=bcTspyPhkio+fc43HE7IGWAG8B1u10hhY2HovpZJwqvHDzX+A/9yLJ2osHVhvSjWAx9QxSP3KNoFILzUe1vlXxk74T9lATLVtIuFH+3xXl1mx9PNlGmMbJX2tf3uHJ9Ho1q7v9NaM9DYw9GVU+cQ5j3MxlR4GTOg1BbVYcgmDCLjb+WOSCbPj+HjP1HKN2yA7nhdMmE51eBbUcofKWiKz0jDES1JNj3lh3k/fzkvKe4fi2usB/CYP0YbQjVmXeF08Lq3hBSxBYgBXg5aLw0dXM7To6h1kOEP8q9o2n/FTfVO7plZPxtTGJ6DOEJyLZBjPsSwWjWrm4DiLg8yXUIPRw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5jxJdGqHBF995O2koMhPVubVtg1S3gV8z8tbdE75gTs=;
 b=XvMG291fNMcJOFJhqU1fUzADPcyCYc/aeGlI2LC6/ZWSDzgsfz94KoVtRCZE5FEuxyC65rDBN9KqfgUbEQF+7ysnNgE47NHZLHE1yAhYn3fMDNXXcgt+xbf8Gn3LiHrEikeSPRq0TaGSQwFd0Kwz6VgDclFesrFBMBx4C1U16w8=
Authentication-Results: arm.com; dkim=none (message not signed)
 header.d=none;arm.com; dmarc=none action=none header.from=nxp.com;
Received: from VE1PR04MB6638.eurprd04.prod.outlook.com (2603:10a6:803:119::15)
 by VE1PR04MB6429.eurprd04.prod.outlook.com (2603:10a6:803:11a::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3066.18; Sat, 6 Jun
 2020 15:21:57 +0000
Received: from VE1PR04MB6638.eurprd04.prod.outlook.com
 ([fe80::5cc4:23a5:ca17:da7d]) by VE1PR04MB6638.eurprd04.prod.outlook.com
 ([fe80::5cc4:23a5:ca17:da7d%6]) with mapi id 15.20.3066.019; Sat, 6 Jun 2020
 15:21:57 +0000
From:   Robin Gong <yibin.gong@nxp.com>
To:     mark.rutland@arm.com, broonie@kernel.org, robh+dt@kernel.org,
        catalin.marinas@arm.com, vkoul@kernel.org, will.deacon@arm.com,
        shawnguo@kernel.org, festevam@gmail.com, s.hauer@pengutronix.de,
        martin.fuzzey@flowbird.group, u.kleine-koenig@pengutronix.de,
        dan.j.williams@intel.com, matthias.schiffer@ew.tq-group.com
Cc:     linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        kernel@pengutronix.de, linux-imx@nxp.com, dmaengine@vger.kernel.org
Subject: [PATCH v9 RESEND 09/13] spi: imx: add new i.mx6ul compatible name in binding doc
Date:   Sun,  7 Jun 2020 07:21:13 +0800
Message-Id: <1591485677-20533-10-git-send-email-yibin.gong@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1591485677-20533-1-git-send-email-yibin.gong@nxp.com>
References: <1591485677-20533-1-git-send-email-yibin.gong@nxp.com>
Content-Type: text/plain
X-ClientProxiedBy: SG2PR04CA0184.apcprd04.prod.outlook.com
 (2603:1096:4:14::22) To VE1PR04MB6638.eurprd04.prod.outlook.com
 (2603:10a6:803:119::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from robin-OptiPlex-790.ap.freescale.net (119.31.174.66) by SG2PR04CA0184.apcprd04.prod.outlook.com (2603:1096:4:14::22) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.20.3066.18 via Frontend Transport; Sat, 6 Jun 2020 15:21:51 +0000
X-Mailer: git-send-email 2.7.4
X-Originating-IP: [119.31.174.66]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 65f0362d-a0b1-493d-661b-08d80a2d59be
X-MS-TrafficTypeDiagnostic: VE1PR04MB6429:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <VE1PR04MB6429349E15AD3E005E574A6589870@VE1PR04MB6429.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3276;
X-Forefront-PRVS: 04267075BD
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: i7BVn1rkWizCuvL1nmTF1brDK7eMsvpfBEQAkOY2RJ/2GUkplh+QrN6kx5voC7iANWS2lRJcBuKXTdWYeiDBr0k5C5frUqoUXym8zirvxQPxUfRJ5ZTQvAA0R9SKAXe3KZsrEqmqsDhMotnJuJGtBl/YAcjBaAdHCSDkOJBN7WJ6qJySIg1NMJm3WnU8dkdqzohkcvBe+Ug+t4yk+/p0l7VhdxdW2kigCINrPlrp0DyIcX3it0UmQ6v1B6q0AxhjbeYNIkikVGU4Afkp2ClfRbQGYRX5YEwN5X3BIJ5f2VeWjZmPTUDW7eK7ziEC2Wl7D2CLaeaaPQ/toA97A/jmGVfU0Ru9J2nN7+Y/QOMT0tsOzvlNZwGBeWZmNLnF2tJn
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VE1PR04MB6638.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(366004)(346002)(136003)(376002)(396003)(39860400002)(66946007)(52116002)(6512007)(66476007)(66556008)(6506007)(186003)(7416002)(16526019)(26005)(2906002)(86362001)(8936002)(956004)(8676002)(2616005)(6486002)(6666004)(316002)(4326008)(36756003)(478600001)(5660300002)(921003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: P1F1V/A8yP+FLkfJio612spREaNZeADwYYLLfgR4+CCIxldkKipXuGbRXGeQ2pIxUaayy3oH2O+qg8R2lHHIk10KjUMH8OsHhF7Qpxhda4UYYUDjJIuhSx3FpVFiUnQHVShexpnyeQCwtT40JecbnwhO41AlIyTeFbpuNEq86+Wsz0OsCML8tS/kvdxYKZNJJAXs8C4a3HBWcuwcMw9hVlHhUaAviawvZhV2UsLCdseEAyxs3JVSQ5e3/Ld5uEpTN4w63Ar4BxA7zoxHPJLbfmVHKpG50kGvoN4FyZminn9PAjLqZbkEVEW2fW+uTaOLpiUFScqrqm0J45ycW4ouL9axB71NoVsHruU2PNCb7LrJoeDCtK4yrPz9EAP+MsCtSORi3JOjqBoOlST3gtMiN0FONSWB7Zf3na2wezy1CF3GGzAEDUU4eBap1QzdTLSI9xSZwrt43OBoAdsh8yuh5BOlU35iNn0EsVRZmLOgeIw=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 65f0362d-a0b1-493d-661b-08d80a2d59be
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jun 2020 15:21:57.1829
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WMW4ipcjwkdeFTTE3dNelobgJaYRYALH9uApFLofhnjh7WYt9unxVA0PpWKkn+zRk0LWPz8WI1Vau26Gm/tCIA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR04MB6429
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

