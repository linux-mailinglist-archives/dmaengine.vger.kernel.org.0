Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8D27D1F0778
	for <lists+dmaengine@lfdr.de>; Sat,  6 Jun 2020 17:22:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728974AbgFFPWS (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Sat, 6 Jun 2020 11:22:18 -0400
Received: from mail-vi1eur05on2048.outbound.protection.outlook.com ([40.107.21.48]:62060
        "EHLO EUR05-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728968AbgFFPWM (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Sat, 6 Jun 2020 11:22:12 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=c79UDeMnw6sYC4sdSW1GlcmsRNS2E0gvK8oJIOrFdjEhZIrcIPyez6DyAv4tBybWU8eOSVP6VhQbuyZJpNiQ7zTFQf906RBz+UDttVV8wIjCroiu+z6oVjacHXcs3GtIbUaSyNWAXFaFePUdma3s1BxrBioQlGDvHPRQChHu5+TAKGBVbYpX3V8k+C7jngjQQJXtue0ZZ8ZYO3qx4BcRSDrQZWRFaoRVKFW1G6I1zMPnFpmQvCrIVY33WLcOvdH5t/1j/qsgy+91WhD+BiH10zP/lVKiekb34sqlyqJmcDd1v+qzlTqzLFp0qaJwQ6KU0V5uL/tCO3niBEbVrxSwBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sZvU3VGhVcTeYxe4fB6geATT0prKN/x1vEpROhK8pVc=;
 b=UaBNo8gK6tTDP5DLYNovk91YGtKjgSKlK74fROPoYBiLjI9oCvGkSm5iU26nxRoPpN0r+oliYQBWSDC+xTpvAoL+9MDIhu+qVe0CcL5n1kpGF531/xFcNaxEIuaLLPwcdf84D3oXcRco9yzVMfBmXoxAxVeZ5t2yZ+xANegIlOYjO877jOll4XfH7H8Rk796kNS/AKhpeXwpOn9CVfMKVQdAj4+khqj1qYKg1voJyga6UCGoQyK/34QsIojtolj6LFWsNeAgaxL9oq8SxDdFigwu7nLU7wRzEl25x/VhFiYq0UchdZ/anNlnwTpAGA3AjDgTYP19qa3xfK6tdaBCNw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sZvU3VGhVcTeYxe4fB6geATT0prKN/x1vEpROhK8pVc=;
 b=eoMxN3azQXJeyXHMXVDrxy+kM41r7KbT/ZcJugM8aIVU9wsDqToqawLEuXc5UcVMHqb5vOY9p4ja0ZQCGcwKeWy5DNWRlqNnHcJGpzKDMgRNR68on1KYm2DjiaQ7EZVPnv0jIFBplywfrkICZ9S4tp39uVP4lbQ+lWrofgnWFvQ=
Authentication-Results: arm.com; dkim=none (message not signed)
 header.d=none;arm.com; dmarc=none action=none header.from=nxp.com;
Received: from VE1PR04MB6638.eurprd04.prod.outlook.com (2603:10a6:803:119::15)
 by VE1PR04MB6429.eurprd04.prod.outlook.com (2603:10a6:803:11a::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3066.18; Sat, 6 Jun
 2020 15:22:08 +0000
Received: from VE1PR04MB6638.eurprd04.prod.outlook.com
 ([fe80::5cc4:23a5:ca17:da7d]) by VE1PR04MB6638.eurprd04.prod.outlook.com
 ([fe80::5cc4:23a5:ca17:da7d%6]) with mapi id 15.20.3066.019; Sat, 6 Jun 2020
 15:22:08 +0000
From:   Robin Gong <yibin.gong@nxp.com>
To:     mark.rutland@arm.com, broonie@kernel.org, robh+dt@kernel.org,
        catalin.marinas@arm.com, vkoul@kernel.org, will.deacon@arm.com,
        shawnguo@kernel.org, festevam@gmail.com, s.hauer@pengutronix.de,
        martin.fuzzey@flowbird.group, u.kleine-koenig@pengutronix.de,
        dan.j.williams@intel.com, matthias.schiffer@ew.tq-group.com
Cc:     linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        kernel@pengutronix.de, linux-imx@nxp.com, dmaengine@vger.kernel.org
Subject: [PATCH v9 RESEND 11/13] dma: imx-sdma: add i.mx6ul compatible name
Date:   Sun,  7 Jun 2020 07:21:15 +0800
Message-Id: <1591485677-20533-12-git-send-email-yibin.gong@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1591485677-20533-1-git-send-email-yibin.gong@nxp.com>
References: <1591485677-20533-1-git-send-email-yibin.gong@nxp.com>
Content-Type: text/plain
X-ClientProxiedBy: SG2PR04CA0184.apcprd04.prod.outlook.com
 (2603:1096:4:14::22) To VE1PR04MB6638.eurprd04.prod.outlook.com
 (2603:10a6:803:119::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from robin-OptiPlex-790.ap.freescale.net (119.31.174.66) by SG2PR04CA0184.apcprd04.prod.outlook.com (2603:1096:4:14::22) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.20.3066.18 via Frontend Transport; Sat, 6 Jun 2020 15:22:03 +0000
X-Mailer: git-send-email 2.7.4
X-Originating-IP: [119.31.174.66]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: ef91cb12-216d-4d18-7c4d-08d80a2d6092
X-MS-TrafficTypeDiagnostic: VE1PR04MB6429:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <VE1PR04MB6429516C1A1D49ED63B598AD89870@VE1PR04MB6429.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:632;
X-Forefront-PRVS: 04267075BD
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: coMAB8/jnmsVkVdSnzzcvKVc1OCbOXn6XU26vcLwfLiZU5puYTZ0ZCJYrZkPCBu9jRbf5+SqPnz+Lppt5v7v4uYbq3n3ZKPFJnfsU1rlIsWnzKf6dsTB1zkvo0xQSjUeh2PTkgbmP5f6J01VTPNYPGQx9cGTRfwuRqa755giIaz9wFtLZD95/tvXqcdlKiqdmvtl/mJHsdphvRDqr2qIMt+/ztKckTkxrli+TKAV71nssxeyZAt/OPnp6+FtlDKInrkcUhKIBFptxihU6fHE8kHVFKdbrd507sR/ptziRyaBH+ZyLGxeRQqN0O5jHNF6iOps8wH+m/5YB/7194/wmxEw8TKJLUuT8OVlhNLHOuw=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VE1PR04MB6638.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(366004)(346002)(136003)(376002)(396003)(39860400002)(66946007)(52116002)(6512007)(66476007)(66556008)(6506007)(186003)(7416002)(16526019)(26005)(2906002)(86362001)(8936002)(956004)(8676002)(2616005)(6486002)(6666004)(316002)(4326008)(36756003)(4744005)(478600001)(5660300002)(921003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: /+r2qcIlty4GVYgrJ/lgjcT5L7u5L751XDek/bDvzXVQjr5PtkKHmd6IoD+FyU2zSxSPHejPhqKH6+MGiLqEEcB/nFRRKAc2+FXhjYYO26pa7fI9xtFb8fvcwoSgYlMTuNVYU4fYivzXhPgEKDBI2hz9d+5vLdBsOmN48JQHKF8WqCXEtcbjxFmD/MWLs8qzrjg1dH6x5W0dHCVhveqhfwVd1OIrHTj9g66U3fN25ayFXdSY9Szisf4Y3P9JQfWBAdxqoK9UIW9uM8PgeikkgB6KzTdlOlHVOLPUziOehyhESBhwpL39r9xTNCpPUsM993JaPKa2XVkpLZLR7raXO/r8MRmQN2DD+LupNBNIF56LKn0Xy+kOwM+a7SyO8s1IzWJZ9mhVGUU7BfdNv8WlrjAiioCZzJpGbxa9lT9a2rs9+AcFVph0jcY/qLtIIq9roKZF9oWWsBkEb6xdyzoy/mNVf4MV4rosDTZAfI6eh64=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ef91cb12-216d-4d18-7c4d-08d80a2d6092
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jun 2020 15:22:08.6282
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QOyKZY7kdyqi4aKrDTOws1ihBPiF5JbYTlr3bVJp/7RU3bZyZYUgKzUbDzpP2DurNdjjZ7x3QUgEYPToOpc2Bg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR04MB6429
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Add i.mx6ul compatible name in binding doc.

Signed-off-by: Robin Gong <yibin.gong@nxp.com>
Reviewed-by: Rob Herring <robh@kernel.org>
---
 Documentation/devicetree/bindings/dma/fsl-imx-sdma.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/dma/fsl-imx-sdma.txt b/Documentation/devicetree/bindings/dma/fsl-imx-sdma.txt
index c9e9740..12c316f 100644
--- a/Documentation/devicetree/bindings/dma/fsl-imx-sdma.txt
+++ b/Documentation/devicetree/bindings/dma/fsl-imx-sdma.txt
@@ -9,6 +9,7 @@ Required properties:
       "fsl,imx53-sdma"
       "fsl,imx6q-sdma"
       "fsl,imx7d-sdma"
+      "fsl,imx6ul-sdma"
       "fsl,imx8mq-sdma"
       "fsl,imx8mm-sdma"
       "fsl,imx8mn-sdma"
-- 
2.7.4

