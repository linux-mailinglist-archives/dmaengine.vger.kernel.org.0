Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E010D1EF949
	for <lists+dmaengine@lfdr.de>; Fri,  5 Jun 2020 15:33:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727952AbgFENdo (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 5 Jun 2020 09:33:44 -0400
Received: from mail-db8eur05on2073.outbound.protection.outlook.com ([40.107.20.73]:9153
        "EHLO EUR05-DB8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727787AbgFENdn (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Fri, 5 Jun 2020 09:33:43 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=J951Hl5a7RYMsEyCKFoA09lDY5uCNL+nRzJx7AnG548xlO4SfBjaxAEB+Q5yUdcsXCb2epjEjBIL8/SgQ+vI5G9RjT9VkWslH26qVZ5OpaUjxpPAu8wBUgTWDS4fJEmgGHDaqHZPOMhoJCfGOy2bUIR9cRMxAYHsyh5uHbzI5cbR9F6XD8dKg0k2axLP5FNdfQBmjdxa4ume0viTiPCxTeT/WTYw9uNvOYy3kRIoz9hwf+Ui82cR7/tOKSYOMWUYn1zG4TYBzn3wDRNaFkjBApJGUeW9MV4HiJTBhxMZg/SCQaI1PwQ4ru7wJdY4cWYUP4BI+T3PuKozoJXk8lA4og==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sZvU3VGhVcTeYxe4fB6geATT0prKN/x1vEpROhK8pVc=;
 b=b/F1ul/ImScl8Pz52QNi6WKrBONu1eayQa+uId0wS8k43ipRKk2OJZUBrklH8XoIQcSJgVQJ/ou2BwP95NSyQwgTIbnIiSmkbDYWyhfizE4pXjwVnwhRbFMD+oKNJM8qByfpINOD6Szx6BxPtTDP0F0y1UlVmaY6vSO/pMTNhHzn+5LdcO5bzK/ykXF7yOqiLCubqcEatXnwHafid+g3KjerFMQovvEzXMRzfOUoSOPX9Ei9cGQWc5dmNZS4Fw4NKYi3Yxf4qKAUg8/UytLv59HRSp2qm4lpu4weN1BjQ3ia6fynQxA4CLf3Wckm9eh+PamxDRbvPTiIBxPEheWkOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sZvU3VGhVcTeYxe4fB6geATT0prKN/x1vEpROhK8pVc=;
 b=sGaeKmBSySTEZ8Hsjz0xegJHiGBSXNP5DqFBzkuWfTAyp/x+/WoMOC+qOqjYE6P2XF6WmXJqPQAhxEtZHaaYiZIE9OjQF9INJTPGh2WytqAkIhsJJXIn0m5rCBPJGk7O0wzTZ0iTYq6WQCdpP9l43o+vHd/Am7JlHxRwDgpjJOE=
Authentication-Results: arm.com; dkim=none (message not signed)
 header.d=none;arm.com; dmarc=none action=none header.from=nxp.com;
Received: from VE1PR04MB6638.eurprd04.prod.outlook.com (2603:10a6:803:119::15)
 by VE1PR04MB6702.eurprd04.prod.outlook.com (2603:10a6:803:123::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3066.20; Fri, 5 Jun
 2020 13:33:37 +0000
Received: from VE1PR04MB6638.eurprd04.prod.outlook.com
 ([fe80::5cc4:23a5:ca17:da7d]) by VE1PR04MB6638.eurprd04.prod.outlook.com
 ([fe80::5cc4:23a5:ca17:da7d%6]) with mapi id 15.20.3066.019; Fri, 5 Jun 2020
 13:33:37 +0000
From:   Robin Gong <yibin.gong@nxp.com>
To:     mark.rutland@arm.com, broonie@kernel.org, robh+dt@kernel.org,
        catalin.marinas@arm.com, vkoul@kernel.org, will.deacon@arm.com,
        shawnguo@kernel.org, festevam@gmail.com, s.hauer@pengutronix.de,
        martin.fuzzey@flowbird.group, u.kleine-koenig@pengutronix.de,
        dan.j.williams@intel.com, matthias.schiffer@ew.tq-group.com
Cc:     linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        kernel@pengutronix.de, linux-imx@nxp.com, dmaengine@vger.kernel.org
Subject: [PATCH v9 12/14] dma: imx-sdma: add i.mx6ul compatible name
Date:   Sat,  6 Jun 2020 05:32:33 +0800
Message-Id: <1591392755-19136-13-git-send-email-yibin.gong@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1591392755-19136-1-git-send-email-yibin.gong@nxp.com>
References: <1591392755-19136-1-git-send-email-yibin.gong@nxp.com>
Content-Type: text/plain
X-ClientProxiedBy: SG2PR02CA0048.apcprd02.prod.outlook.com
 (2603:1096:3:18::36) To VE1PR04MB6638.eurprd04.prod.outlook.com
 (2603:10a6:803:119::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from robin-OptiPlex-790.ap.freescale.net (119.31.174.66) by SG2PR02CA0048.apcprd02.prod.outlook.com (2603:1096:3:18::36) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.20.3066.20 via Frontend Transport; Fri, 5 Jun 2020 13:33:31 +0000
X-Mailer: git-send-email 2.7.4
X-Originating-IP: [119.31.174.66]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 2d976aaa-fc0a-4e32-4b29-08d809550ce7
X-MS-TrafficTypeDiagnostic: VE1PR04MB6702:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <VE1PR04MB67026C02F4CA39770B95014189860@VE1PR04MB6702.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:632;
X-Forefront-PRVS: 0425A67DEF
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: WYupjjCT/Gvj0QzY2soJ+taTFRGuSxe2NPhvqG39YQlWtBYm2nVqNq8UQQIsPVUgGenBieAJDeCEpCvbxkmKIJfXBgnRq9wRGHpMEa+1XpG/ScayBKv5T3M2XgEX6qmP02d2/08tG6vZWpQUDp8Y/OcsxSo00wALfoZJ6ovzPDPfFxmnQEDQI6iasdOxcBkpkFzgxzERc8ZAaxxrhXCJXKaDx8iK2vn+yv0Tta/uO9qdhsfQqX1AoieHGeFzeYqRs1w0GMjeWSTrr+8e4VE75OKjm8aOfQHOH5q67D7M6W2tk8OdX04AW7wktTmQxfvzO25hND8SsPsGKoeeaJjDsuYlHOMxBV4erdrGlX46N8E=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VE1PR04MB6638.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(39860400002)(346002)(376002)(396003)(136003)(366004)(6486002)(52116002)(2906002)(316002)(4326008)(6506007)(5660300002)(26005)(66946007)(2616005)(956004)(478600001)(66556008)(186003)(8676002)(16526019)(7416002)(6512007)(36756003)(8936002)(4744005)(86362001)(66476007)(921003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: ZesHDUctftUhK5BDxTcHVAZ6wRdB6MiwkkanWON1BDXqDoj9/vOjsgz/g0LjajtAIkmQgyS8hQOQ7b3vpcVcpQOfB0CiHCa8OCBdsMM5iCPnG6qJhAeipHl8W0VYtxLLxKdx3dP53J73mYWalGsNWdVRjzTshtV/SlgM40SfqHk36tzwDGGCDGh56gjloiOjWgkRuVjlYlzzn1qLvggLJypJwJ4FOPh7Agm1ak1gwKBu+Dl5etETbm19zh27IZletF/vx+C73FZDYpgOCX3g+T9uSdM87SU2B6j+KBW1+mNb7V/SxRKrDeLHZkH4gGtVkEYvsjZUwMGr5SQP2Dul/+dQ+h5MocX0EJn87ewx4YRmE31p4rcVeCREVAB3GA7tosxglWqLC94tGZKZQ4qg8BbXTyc40PKYwbiLFuwQZsLNdze+mTPFBD48didUYZv184/+Igr3uq48EYs4Zsqr31p4GB2bv9458FLWIKX2yjo=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2d976aaa-fc0a-4e32-4b29-08d809550ce7
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jun 2020 13:33:37.0087
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LAz48s4sQJD9QfNU1D8Xcb2j5rr0+e8tWBuTrh8gIf52Tw/v2tJbAJTO0UuCecQ63zFy/MInmEXZV9dvhyNovw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR04MB6702
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

