Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7713F715059
	for <lists+dmaengine@lfdr.de>; Mon, 29 May 2023 22:08:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229925AbjE2UIH (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 29 May 2023 16:08:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229755AbjE2UIB (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 29 May 2023 16:08:01 -0400
Received: from EUR01-HE1-obe.outbound.protection.outlook.com (mail-he1eur01on0626.outbound.protection.outlook.com [IPv6:2a01:111:f400:fe1e::626])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46D7CE4D;
        Mon, 29 May 2023 13:07:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CYvi4RmRyv9qyxM51udxVgsIyftrBVHLM9wKJa+WhgtDgMkO2YYp2UzhRtozbamwQcBb6PVKpQlOP3//DsCeepOxdGyEK6zznawlMIZ3P1s8cqWoFStjaKKo0Zp/BX/cBSw828JeFHfoMQP/iMB3eI4wFWSN5sCSQffq3k0odkLfmlUuznMEaQTmt21+zaruBIa8FhSGfX4wiVPyDNaj0W68qKe8PY/QfUBgdpP7laS2u6UJ0IjsYj7362xCscbyCA8Q/2h/Qw+2fygXalJYBIdZlWGujJSmlSN9sIyT1bucfRATIEzevLeeUFewehkaoXPvmYHdmNJmYwbjo/LRUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dgetTr4ykw1iDiXNNcefnB4/26WvmVRYD6yME8KkHrA=;
 b=Jzsd/WiYA7K9urAfN1EvUIJ4M8W/Fh/xHST1hrvxygoa+mtwWFdwRbkagsG1oRepGjyMQ5PPj9p9ydKnj9CbgHhhKdYst3czSJKhUfhWBhgztgyIfZcAE9vohQu/1aspmQKI0suVxxZqQfAudzDiNge0Q/J1jpDSnXRk1Ie+kdKhodMk2jXlTY30IhFcoG9btdZScLuvD8oU9jW2fEaIb64oRJQx0pZVrtb1Wr0EVxNkVPq6VTZ3sLq7cc/HGVxV/QQGXuu6RuoJi+lF4NpmV7AczjD5anCx46JVdIkgFIy//9/b/bZYyP9euCBsd/1TAbXbOsOLA0HPsEz03I1j5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dgetTr4ykw1iDiXNNcefnB4/26WvmVRYD6yME8KkHrA=;
 b=i7SabrIN7DyS8dBMXUiK2ooGQveiGNkJ0Cay5nCRy5ciba/53AzowOeO1NCxITw+XQT/1empvzcQMBz4xlWNXFrwHGkfMteOgm1KCFWY6zneXs9tCaMNUP//eY/vdoZEQvru0MPHtHZatHOtpFXOCXi4d4HRoMTrEUr4/qaHXpU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com (2603:10a6:20b:4::16)
 by DB9PR04MB9820.eurprd04.prod.outlook.com (2603:10a6:10:4c3::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.22; Mon, 29 May
 2023 20:05:48 +0000
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::4a2a:262e:415f:e41c]) by AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::4a2a:262e:415f:e41c%7]) with mapi id 15.20.6433.022; Mon, 29 May 2023
 20:05:48 +0000
From:   Frank Li <Frank.Li@nxp.com>
To:     frank.li@nxp.com, krzysztof.kozlowski+dt@linaro.org,
        peng.fan@nxp.com, vkoul@kernel.org
Cc:     devicetree@vger.kernel.org, dmaengine@vger.kernel.org,
        imx@lists.linux.dev, joy.zou@nxp.com, linux-kernel@vger.kernel.org,
        robh+dt@kernel.org, shenwei.wang@nxp.com
Subject: [PATCH v2 12/12] dt-bindings: fsl-dma: fsl-edma: add edma3 compatible string
Date:   Mon, 29 May 2023 16:04:53 -0400
Message-Id: <20230529200453.1423796-13-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230529200453.1423796-1-Frank.Li@nxp.com>
References: <20230529200453.1423796-1-Frank.Li@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0161.namprd03.prod.outlook.com
 (2603:10b6:a03:338::16) To AM6PR04MB4838.eurprd04.prod.outlook.com
 (2603:10a6:20b:4::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6PR04MB4838:EE_|DB9PR04MB9820:EE_
X-MS-Office365-Filtering-Correlation-Id: 9fac67c1-b041-4573-210c-08db6080186d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 882cygeA9s6Tgfyn7XkUVvfotpTcH8BStM6/p05QNbGISGP/614upcrtnmwKeMQHHghezrGl0apEDNy+XkDNzdjnm1/+5QPIFpjqnRFS4fgg9P68FNznBCQsA2hyeAbn2fHFoovT75eQlRAvd0hD4o5/bznjCXjU9FXrxGB14aTWLXCLuaW8xGkHC05vBPlbpD1/VBbduUIV95oDx1u1Ny8ZgN/4gmXWxSqhB46IeR2NkQksxb9HVjEMUPL2maHe9zNs/TxvA6RLVSEYKA3/8CRNDZaBgt3jCjkuMhZqvLB8JRr1Nc7YvWUMfiUhbbHuqKn2DiElxOa/dEA/NHu7wqOnEMwKuk84KmkYxcb5q8nerwivpP872V7xRZh6cezQRe4asoFtaLOqSCxBpiR97lumQibNe1q/e1B7eikEI+uL1lN+3BNBXSC8W+jYzDK44ix45qPDhdKgM3gZ1smOdjBVmoc6S9688NJ6s0d+e2btE4g0LOt/JVWqFzYYgE1gTbnbJIpOM0oMHUMYaYwreG61fQvvpda4AomQRCCYm6CHmP0L6B/RlfyDWR62tmOepSuy22W/xpDZP+i2WNM1wG8rUrVK+/hPz5lVCGn6ZrVdQEwwlApoz39bsusYXNIe
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB4838.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(376002)(136003)(39860400002)(366004)(396003)(451199021)(83380400001)(52116002)(6666004)(5660300002)(66946007)(316002)(36756003)(66476007)(66556008)(4326008)(8676002)(38100700002)(41300700001)(6486002)(38350700002)(8936002)(86362001)(2906002)(2616005)(6512007)(6506007)(186003)(478600001)(26005)(1076003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?HBUfip0C/JKmyL7voESzLnFuoAl/gZN7a8pyuEoKPF65NxIN1KGH+qOgBR+f?=
 =?us-ascii?Q?YIf2CrCU+TWVJ3E/+rabmjJX80jbGU6l8OowBxf7AK4D8FDjTKSs2pQgT0p3?=
 =?us-ascii?Q?p7wFInKPPHDNTxFkLOaZPUT93345BscQQWzV8Ob4s5C/AVJmc+a7zQlTTFQT?=
 =?us-ascii?Q?0oQvMMRUVzJjZjnO2Qm38VSPlpFOnWpOAIQMbE0k3KRoCnv2r8oGobINjZ2K?=
 =?us-ascii?Q?WwA5Q+3TG+FADYA3KmgjUfrqINd4BTJeivGR59gSotymEcQBrIINi/6TgDlk?=
 =?us-ascii?Q?CbjB87psOUYz7KBX7iDiCS399mOiW2YHZSwALaUoIHlQWYxt5EdETC+QvnHD?=
 =?us-ascii?Q?gqXmtajkeEHZpwpkeTWcxRLcGKAisAt2cn0FEaND1Fw7Y7thmsvYTPmrHynS?=
 =?us-ascii?Q?YxerRELY01CrXMdvi2LZjn7snpXAYIEVCEk/uSyx0wnod42Q1PR+82AZn/V3?=
 =?us-ascii?Q?RndYmAxbxregmsm1+LOl4Gw3CFi/Rr+8F5ulcEdiIZZp6FN6XFjQV66wwXMb?=
 =?us-ascii?Q?CLT04jT3zbghAWt/+MkYFiUo6t4shzNs+JREomfTqIh/Banj8CH/iG7hmWKD?=
 =?us-ascii?Q?7LHVSRxU0+5e9BjWRuny61j/p1kla2ACLobOq1KPFYZIMwlfICIjGBvsA60B?=
 =?us-ascii?Q?G1dn7Gw1OoAWDZkAPvWi011ru/G8/VC4iGZIrjo3A4SwTqVmu3OCM96nJuJv?=
 =?us-ascii?Q?80RILeiO4vTYjFaf1mns31qazHj06n5wps7jqW5posDaI/3/lk7Andxq/Uow?=
 =?us-ascii?Q?YwzGN6qJ1knR0BZT0lNKcwECEmc0UslXDeLnU2KZBU9aZUqpb19KDY6qOnYy?=
 =?us-ascii?Q?oUCEijC9RB3RUvHBSnBt7b4knmoXFU5eir0D5QmRXMpkhuTjOcdG2fDOZj8x?=
 =?us-ascii?Q?qM84YL15DTilvTC+0vML3AWs3Rdh3lsQ9t8xHUf0yGnqqr9XLXye98arVUoh?=
 =?us-ascii?Q?4lvB+k7P6pPPBxvn4IVSr95Xv4ir/2amZ8wLYgU3WilV0h7Njm2fYuBwGOMs?=
 =?us-ascii?Q?BduklMdNxTVm+uGBRhmvsuIBEds4sd4CnC/P2T7pnpxeefsTWsc1arBgBB0t?=
 =?us-ascii?Q?hqt8SgMdswDis24LiqCRKZz0gy6c0ZMLRmcYuwFyf3q8Je1MWVQRXX+QCh1v?=
 =?us-ascii?Q?3B0K21QepUYRWRxps1q4U7iA7nuyChkpkqowo41Suj//TP7fpyT9FSCRgZZw?=
 =?us-ascii?Q?mXGL17KB7etlk9GMwK/FExxqr59PhsLh71AMGNl+wL68OBFTuFzVCjzSOv6t?=
 =?us-ascii?Q?4W8/dSvuW5TRm90cfnmRgT09HfejUX+zuxWOGdWx6R87kB0rkx95y4gBCFD/?=
 =?us-ascii?Q?c5xUg3xUSfO5b0+R4sXYNQVbKsXBr6BCnVXo/tCXKbKJJWZn+2ZDXK7DNr40?=
 =?us-ascii?Q?SG9pBxNZbWojk6t6RFMH72Isb2+q4ZBMdNy2yJ/CuNIaUPRSNdDSlzkwcvVb?=
 =?us-ascii?Q?qRueJk9WA8Cx+GluJCM34U+VZecfBEaVyEgMpV3IdOoB2OSTVoFr0RjhPxKm?=
 =?us-ascii?Q?xRdVPri5pcPpLQoPfN8Em9zzRlVa7gcnCTVLETdZK58WZY/GF8VAbijTGQvz?=
 =?us-ascii?Q?fEh5eOJCHnO/UyZiZCFTg2bbOK8xQ0lgDTz27bKJ?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9fac67c1-b041-4573-210c-08db6080186d
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB4838.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 May 2023 20:05:48.6682
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: c/q4SVP2d0ZwpncMtSNX0iHzTvnI4yRhFtlnz+NDPukjnk+dvDZuAAdeXA6bsdsdiDt339XvWVJymduQR1SJ7A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB9820
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,SPF_HELO_PASS,
        T_SCC_BODY_TEXT_LINE,T_SPF_PERMERROR autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Extend Freescale eDMA driver bindings to support eDMA3 IP blocks in
i.MX8QM and i.MX8QXP SoCs. In i.MX93, both eDMA3 and eDMA4 are now.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 .../devicetree/bindings/dma/fsl,edma.yaml     | 20 +++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/Documentation/devicetree/bindings/dma/fsl,edma.yaml b/Documentation/devicetree/bindings/dma/fsl,edma.yaml
index 5fd8fc604261..eed12687b0c9 100644
--- a/Documentation/devicetree/bindings/dma/fsl,edma.yaml
+++ b/Documentation/devicetree/bindings/dma/fsl,edma.yaml
@@ -21,6 +21,10 @@ properties:
       - enum:
           - fsl,vf610-edma
           - fsl,imx7ulp-edma
+          - fsl,imx8qm-edma
+          - fsl,imx8qm-adma
+          - fsl,imx93-edma3
+          - fsl,imx93-edma4
       - items:
           - const: fsl,ls1028a-edma
           - const: fsl,vf610-edma
@@ -101,6 +105,22 @@ allOf:
         reg:
           maxItems: 2
 
+  - if:
+      properties:
+        compatible:
+          contains:
+            anyOf:
+              - const: fsl,imx8qm-edma
+              - const: fsl,imx8qm-adma
+              - const: fsl,imx93-edma3
+              - const: fsl,imx93-edma4
+    then:
+      properties:
+        reg:
+          maxItems: 1
+        interrupts:
+          maxItems: 64
+
 unevaluatedProperties: false
 
 examples:
-- 
2.34.1

