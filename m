Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8E8523C6E8D
	for <lists+dmaengine@lfdr.de>; Tue, 13 Jul 2021 12:26:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235753AbhGMK30 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 13 Jul 2021 06:29:26 -0400
Received: from mail-db8eur05on2073.outbound.protection.outlook.com ([40.107.20.73]:3041
        "EHLO EUR05-DB8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S235760AbhGMK3Y (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Tue, 13 Jul 2021 06:29:24 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UAFrVqhyEJWRvIRTtjl5D7DS1D6EhgUmYjmAGobLLXrfCyCKJeYJMDqxz0xuN3Chu/Xi+p4+DEfiANBRDG4xbSzGp8+K92BKBbZp95ezv80bZXixLYAMQI3zIzpCnzf7ynhTaRD32jBVSKf48RibIICtG1Bdm4yfUzNHWleNbgNe841Yw5080m5WCbRewEDXKlUt1cp/dEOFECY4bzauTMOwB2ktKfVq8+Y9pvUt2X70bBIXVKTLf72BVMwXXtuY80cJ5YrLZPKFo3w/IEgMz5qvu0yJB9yo2Arfy71ldrF2qecD23C3tc2AG+zNqLnAKEjn9JbZBpL9lzWpXN8nuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sZvU3VGhVcTeYxe4fB6geATT0prKN/x1vEpROhK8pVc=;
 b=Rl09HtVaoHD5Ykvw51b7L+xLoPdSzbQUHCBjN+8N6iFUldaNh0SO2bra5F+rQskFjMrP9LRov5ea0ElYMEejsRJapxYxkeajGhtZxMNgQjJOaczaveQglpJJwqrzUUSWHDgfh7pKsSwMyMEc5tvqIQtqQDcTO9b3XF5Pap2Ql6lajsM1Lxk5HiRi/iR0QG6IruJgVvKSYeM9rpdMgypc3USVvsgls6ohs9QbP3oGdTZuEJ42bcyXqQoQqKmigSx+qNGGB0lcCt9Hr1eX7J4+RIUt+hmaJtu1NO0Dwq29NQ9D7QiagYcXrQTTiPX3N+/hxdlQQvaVPIil8KgtJygOPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sZvU3VGhVcTeYxe4fB6geATT0prKN/x1vEpROhK8pVc=;
 b=QGbG4dHQsefA1DtcvAVWTztuhyzihxji6CIt8wsXrw1Phhw++itAFPFqjAZHqlhqGgRJ1k68I7F/FPpTwLUJWtKmr60Jp3N2HPPgCNxdYniPRPrTWG3B6Cm53f58HABbdGiZa4kDNefiuSUiKIa51A+YjjRoM8fWrXAC/g7kfB8=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=nxp.com;
Received: from VE1PR04MB6688.eurprd04.prod.outlook.com (2603:10a6:803:127::25)
 by VI1PR0402MB3344.eurprd04.prod.outlook.com (2603:10a6:803:10::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4287.23; Tue, 13 Jul
 2021 10:26:31 +0000
Received: from VE1PR04MB6688.eurprd04.prod.outlook.com
 ([fe80::a978:6f38:2bce:9076]) by VE1PR04MB6688.eurprd04.prod.outlook.com
 ([fe80::a978:6f38:2bce:9076%5]) with mapi id 15.20.4308.027; Tue, 13 Jul 2021
 10:26:31 +0000
From:   Robin Gong <yibin.gong@nxp.com>
To:     vkoul@kernel.org, mark.rutland@arm.com, broonie@kernel.org,
        robh+dt@kernel.org, catalin.marinas@arm.com, will.deacon@arm.com,
        shawnguo@kernel.org, festevam@gmail.com, s.hauer@pengutronix.de,
        martin.fuzzey@flowbird.group, u.kleine-koenig@pengutronix.de,
        dan.j.williams@intel.com, matthias.schiffer@ew.tq-group.com,
        frieder.schrempf@kontron.de, m.felsch@pengutronix.de,
        l.stach@pengutronix.de, xiaoning.wang@nxp.com
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-spi@vger.kernel.org, linux-imx@nxp.com,
        kernel@pengutronix.de, dmaengine@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH v15 10/12] dma: imx-sdma: add i.mx6ul compatible name
Date:   Wed, 14 Jul 2021 02:41:47 +0800
Message-Id: <1626201709-19643-11-git-send-email-yibin.gong@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1626201709-19643-1-git-send-email-yibin.gong@nxp.com>
References: <1626201709-19643-1-git-send-email-yibin.gong@nxp.com>
Content-Type: text/plain
X-ClientProxiedBy: SG2PR06CA0198.apcprd06.prod.outlook.com (2603:1096:4:1::30)
 To VE1PR04MB6688.eurprd04.prod.outlook.com (2603:10a6:803:127::25)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from robin-OptiPlex-790.ap.freescale.net (119.31.174.66) by SG2PR06CA0198.apcprd06.prod.outlook.com (2603:1096:4:1::30) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.20.4308.20 via Frontend Transport; Tue, 13 Jul 2021 10:26:25 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f0cc3677-d14e-42fd-b2ea-08d945e8ae88
X-MS-TrafficTypeDiagnostic: VI1PR0402MB3344:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <VI1PR0402MB3344885D986C376AA33A0CC889149@VI1PR0402MB3344.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:632;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: aiUi93zxXB2e0GuoD27lnL/Up2eSrS4K5USoYaPqn0nsi60vktOaF3fNQO7UpKW2jD7DYHTDgRfFZMHr72LeUwBTYHIckJnFnZQd9SaCpWdJ6rZWOLojyRgb7q7Wxs20r7mSt+kDz7fz2ZNSA44ygfUcXSXw2YfOvQRMNETvz0P48Nb+XrMjmVcHNZ+1svgshruTZlhKLn0TEflJRTg7+gCrR7YAt6AoMfMz4kHrI2Ur6TJNvLl6gNgUj7UuraxIQxA1QBgIPYoAbmSqLokXJIYVGXrdBAISo11LMhQrlzLKh+9GySDsPAngJEuGF5/nhYe6eqnDUetxVsHz1gyyQVKJqHNiS1/X604z3fmqXXseDSNcjp4jUQvD/5+TUZMNjZtdVgplvcRiFXisKbCBImz/pTNyu/uzVbhf6WlVpRFuHwZ8SLACU8L2FQlQQf362R1vk7sYp9yyazJVD/I315abyIbBi1DO3jGjzpGVC4k0hzVyd5dftqKByUfvw9XfPMnVxulUSVtre5CTQr5IjyMkbl7wG81Kzz0+MZbWaK4QeGrJWLWe1eDhIgSzSLnwSGDb1yx4tbk5GjoumIgvVQXFaYs2pxNA1ruScsyBkgcTttYo5nTD6l8bFU5kRxBDJ4IococzMICxjSxNGVscjpSBuwfRC+uCcsLdkOFS2S1lT9CwI6qP2u6lUqBQWOp40DJg3DDaYB3rHvy+wPK8cARI8yVLzybswpXbJGRmBZQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VE1PR04MB6688.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(396003)(366004)(346002)(376002)(39840400004)(4326008)(4744005)(26005)(66476007)(956004)(36756003)(8936002)(6486002)(478600001)(5660300002)(6512007)(86362001)(7416002)(2616005)(6666004)(66946007)(8676002)(66556008)(316002)(38100700002)(38350700002)(6636002)(2906002)(921005)(6506007)(186003)(52116002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?1ClTsWv/nVMdlyEe39bbdaNc+g50NfBaa0HyskYlKy+QhdP76SEKTaUG6P8s?=
 =?us-ascii?Q?NiYYVaFnoT0cFJSJzoBsth1ETXc+pR1ShWr8soCR+usMAdX0XDVhU2mx1eS9?=
 =?us-ascii?Q?q5v6IooyJ0hNRt8UAN3IB8meEbYPdRvTgAp0LF6CL7pcX63CptJ97SxsAgJB?=
 =?us-ascii?Q?wiGO/TXrx4uRcJi32uP4255GtMSafPwmr8neDqFlyot+AFjEECwNiOvmk2Eb?=
 =?us-ascii?Q?MOrKCHveLYKJNcRya0/c0SYcLEkzKfLlnuX3UUVI9tUKdatpB0HnYD+QioFJ?=
 =?us-ascii?Q?162LpYAT6VlPBa7kg9X2Scg3nroR1Yuxeq3SOM6V4oDVhM9VFHIAJi2q3VUF?=
 =?us-ascii?Q?xgFbzXZ1IYJl37ECy+qqlwuGf9O0kqiz2B5sKEB0EdUR3og5RCln89sl3B76?=
 =?us-ascii?Q?5jyFsBs0pE+27bibwI3heYcJMZYPzBb2KFX4dSvMmHhbygUvrTNuEEo7JO4e?=
 =?us-ascii?Q?zMfNTnKz2+0B7UNOBGxOrEws+6K0osDuhOXWKJD7JX/ObH9LzHiyLFyBiA+g?=
 =?us-ascii?Q?wecJ+GjpZKkXbv/KBgJl2iaoODlSu4N8i7URAJIhxsFVWZsGEXLB0bOjp5Hq?=
 =?us-ascii?Q?75/rEVghVSRWdCh4jnJKmJ933Bh5u5KKXxEmhtIPNr8s6mbZgcBsrpLnq4hK?=
 =?us-ascii?Q?E9hAuGl79rXeHFOw8I4/ZuhVmpTjtLLFPh4qfzfgDZZHEFXfEsUj7BvBwIXu?=
 =?us-ascii?Q?xevzgqjDTNyLhw98rs+/UWDvwdQ8o5Ci3/WFJLCJBQNahXad1LCUM8JWnSyU?=
 =?us-ascii?Q?EPPFy9vFjGcMo5uViRvEQ8jfb5/J+//UkTkjt3L5tEDjACOFTlMdwPnov0XI?=
 =?us-ascii?Q?n430vu7yToF7M5Kkj4qMun+ESTaaseB3XVmU2P019JGE+is1ERpNJHuFIFnu?=
 =?us-ascii?Q?D1GX81CCGRnfxoJ0C3X3TT5QYr5VF92ux4okK9rQFZb6yGyfsovbPxabGsjK?=
 =?us-ascii?Q?OHFFXbQftHJ8sALmLn3p6icv0JmsQfFIX4Gl+lqC9JyoU4U7uKjiqyT6QW2j?=
 =?us-ascii?Q?NCVxhJ4OZRSvVn4hLWezjIMRBVw+HG/Iia2kXLi+NeEsKKCUJ9BQEJO3drAl?=
 =?us-ascii?Q?WZ/k6V4UZRPztFqRDaJV1+aJPWui/Lq8baGr206y6BG0NNrNKuc1fXYVk4KN?=
 =?us-ascii?Q?q8bdjxtjmkZtZMgyrkwcI0wGE143BnbUCry+Pa6BelpB0szISntDREFqGc6n?=
 =?us-ascii?Q?uhHY+1R3Y88jMYeYciEL0ymS/gyRb3dHuDjl2ycRKFx+Y4CBD53fQagWa8fJ?=
 =?us-ascii?Q?DBMQYaHnHNFfYEb6P/YXW+pX8oUg7XKxTTHAaTTGbvDxufWIVhDuEtFJJs8g?=
 =?us-ascii?Q?+cg2eGy66+FEKsjLm8eiHvWw?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f0cc3677-d14e-42fd-b2ea-08d945e8ae88
X-MS-Exchange-CrossTenant-AuthSource: VE1PR04MB6688.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jul 2021 10:26:31.6457
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SlK2v8ZpXpoUcE5Muo5PjzX8iYa99EqUG24pNti1qFRqfQKP7D3kAxNbZLZL6MZD8E1dKjY+AlQbD76oOn9IbQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0402MB3344
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

