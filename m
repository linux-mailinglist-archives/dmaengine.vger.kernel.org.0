Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BFBE7241767
	for <lists+dmaengine@lfdr.de>; Tue, 11 Aug 2020 09:40:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728399AbgHKHkv (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 11 Aug 2020 03:40:51 -0400
Received: from mail-eopbgr00073.outbound.protection.outlook.com ([40.107.0.73]:25216
        "EHLO EUR02-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728382AbgHKHku (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Tue, 11 Aug 2020 03:40:50 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gEjOrJVBVnOZSzUxRKve2ZEYQzWJiUdtUKy/X8Cc9mNqVSxrfjYRHkrtKAnda+fpRr4IrG1bD8qKiMpiYKSH8G9lfJ7L6MfxPhSFb+kTVT473R1qPvZtW/MJd0jyWJBKdKBwPjsTQ9WymC8T8CY/GELviBK5lm15Tf/Qaw5uCtz72A4k7ZjzFRg4IhRwk0/5XovNIHuiih/Lvzw5MlK8ZwA1gqcl2X2Air9HGgiAKqjhNjtilh/NkLgS9Ch4PjvyQF5T2FCdkVaPw9XjzAi9mPQfn+TK8ZqBv7DyD/IW1EUfqfmkl7VdhrdfEuhedRLZU/t53OPreuhCZoSt9/P3Mg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5jxJdGqHBF995O2koMhPVubVtg1S3gV8z8tbdE75gTs=;
 b=FxLEpxrD+yBPQi6jARTv3COtjSvTTCdE/dRe+A91XNGH/mcdm/aiAeSyCLmlmJMpMVxXgoZQJRQT3xs/fJXPK7GXkHNEdlYz56HY2qJgpwlSt0mm2XBG6YdJI41pU6t9jfaGEUKLorbLsktNNJtj/qMqdIgVMa6bfKqSHV6FS3WeTrjq+vzMG2KWCXhdMS8wHbCaPmApPu8Oet/TvG9hO15Qhs2T3s4kQxJ+3djNx26dhu7IiUnDi+n02lIRw8XWtOmRr4Ugz2qfiQPnW/tYrSLCq1sPHwHAjz2lO7DqBHJ7FaSBHiMa6feM7lX5S9MnuTqwHlPjA/CQZ9B52qGKxw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5jxJdGqHBF995O2koMhPVubVtg1S3gV8z8tbdE75gTs=;
 b=UmHJHpI0/nRYK1KvGuRuJsjpBv4dGOmra+97XBxgDED/h5D3abFKZ8FoH1fbk+PF78uOFUx8JmRfQig8BoR6pE/EoPnOLI89Em84fnKTxUSp48mFGuRZARfHIaXiGF4EKer5Z5/gYJwkkIsgQt4USO0tZYSRfOHZkAM17wHbbNM=
Authentication-Results: arm.com; dkim=none (message not signed)
 header.d=none;arm.com; dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB6630.eurprd04.prod.outlook.com (2603:10a6:20b:f4::33)
 by AM6PR0402MB3464.eurprd04.prod.outlook.com (2603:10a6:209:12::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3261.16; Tue, 11 Aug
 2020 07:40:44 +0000
Received: from AM6PR04MB6630.eurprd04.prod.outlook.com
 ([fe80::c9b8:4020:7705:e3dd]) by AM6PR04MB6630.eurprd04.prod.outlook.com
 ([fe80::c9b8:4020:7705:e3dd%7]) with mapi id 15.20.3261.025; Tue, 11 Aug 2020
 07:40:44 +0000
From:   Robin Gong <yibin.gong@nxp.com>
To:     mark.rutland@arm.com, broonie@kernel.org, robh+dt@kernel.org,
        catalin.marinas@arm.com, vkoul@kernel.org, will.deacon@arm.com,
        shawnguo@kernel.org, festevam@gmail.com, s.hauer@pengutronix.de,
        martin.fuzzey@flowbird.group, u.kleine-koenig@pengutronix.de,
        dan.j.williams@intel.com, matthias.schiffer@ew.tq-group.com,
        frieder.schrempf@kontron.de, r.schwebel@pengutronix.de
Cc:     linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        kernel@pengutronix.de, dmaengine@vger.kernel.org, linux-imx@nxp.com
Subject: [PATCH v12 09/12] spi: imx: add new i.mx6ul compatible name in binding doc
Date:   Tue, 11 Aug 2020 23:53:48 +0800
Message-Id: <1597161231-32303-10-git-send-email-yibin.gong@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1597161231-32303-1-git-send-email-yibin.gong@nxp.com>
References: <1597161231-32303-1-git-send-email-yibin.gong@nxp.com>
Content-Type: text/plain
X-ClientProxiedBy: SG2P153CA0014.APCP153.PROD.OUTLOOK.COM (2603:1096::24) To
 AM6PR04MB6630.eurprd04.prod.outlook.com (2603:10a6:20b:f4::33)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from robin-OptiPlex-790.ap.freescale.net (119.31.174.67) by SG2P153CA0014.APCP153.PROD.OUTLOOK.COM (2603:1096::24) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.20.3305.2 via Frontend Transport; Tue, 11 Aug 2020 07:40:37 +0000
X-Mailer: git-send-email 2.7.4
X-Originating-IP: [119.31.174.67]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 40d7cae5-b522-4986-1ca0-08d83dc9da6b
X-MS-TrafficTypeDiagnostic: AM6PR0402MB3464:
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM6PR0402MB34649BDC68C8D40B796D50D189450@AM6PR0402MB3464.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3276;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4LvQqk7FsdSGDJFMxtuNB8P/EByKMvhUTZVO+4VjJLx9tn4ouv3/nMX8ErR9zLty7AJkL24xHDJGU1mnOMTOigKmrZDCCHNUxy4m79UHLo7K+PG+OjdrCXce7dmtUhM7ZVUhZvoUDqyDTlq5J5tqWEznpQVpO9pVJBN/F9wGFAwR0EJzelkLtFE1yo+7MnOROmQ6GfVyHLEfIXlF0AA2057BG5jV8e3S5Tl1Rkd6EMVK9PuE/v33D1PHCkmjRrN3QqdsyZOvN9P8HjbvLZH7ORtBb1TYIWhIP5HzTUIXZVQ5nnBrEa4BXrFBNHgxElkdifIzmUu2gD3RAMmmFzHHXkej0TjZq24jXTtwn1fUjPydgBeTRGAeg4o101Gjf51t
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB6630.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(376002)(396003)(136003)(366004)(39860400002)(346002)(4326008)(5660300002)(52116002)(66476007)(66556008)(86362001)(956004)(66946007)(6486002)(2616005)(7416002)(316002)(36756003)(186003)(2906002)(8676002)(6506007)(6666004)(6512007)(8936002)(26005)(478600001)(16526019)(921003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: qsEkQ5ItCA6qZDsVI3njo/t+tFIG9D4kNwK8XttBZmfoENOLLB+MjTiRf7KNl62WRKe2dIK0a5cu75UpVegb6DZXJi504fqK9pBIknoqJkbIQrlFAde6Z9h12isaORnxbBNYs8ZVy77JXenN5SmWpar2ea1PlVcekZh4gzbifwh+oq6N/hRnfAPF6p8LHlEf582aVWAMLgGndavk8pge0EPmf0SFl6iw7YrxbRjdvNUbwVCsjK7wsQmKYttMgn2YVKEZe985DBG8+QnrjwcpB55/7o/NKRDLcsHGmJu/MprKggA/CXt4R3cOI38LLFg09qcClUBWnimtJurjquX9DKBCggTIvxN0521bn4t0omt8ELc+Ryo6PNL7om0kj1TGZx4qvlG8p9cLPZUxsDZ2NeZSV8najUZLvimE73vKSB/c8TsE2fd+TGmK7FlkENh7NHeydlQaGEnwuxd2F68LQGiUMMHz/ch3QQwqnDqb5BV9Urhlj1omntG7Y44gIJS4EJTFnOxrN3PhZbMqCWSRSbWle5oDCsxmrfrZchtZ0jZGezv8vF+u3vjfs4HV+aJxo9q1ujgX4s35XFj3y7o3JR7w9+g/h2BgvmmQYqxnqvf+GVPHECAEwhcoC3Vo4QwEIuUXuSu5dLnejDywaf2jNw==
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 40d7cae5-b522-4986-1ca0-08d83dc9da6b
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB6630.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Aug 2020 07:40:43.9466
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mmAXfZ+MiI0c0CLoudizylwBy+GmJjPjhjAxPuZSw90Yt+p1D8ZmrMBUEEu5SK4/TWpHydTGy92cYqgmg4z9zA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR0402MB3464
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

