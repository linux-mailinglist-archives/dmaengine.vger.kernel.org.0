Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 75A447128B3
	for <lists+dmaengine@lfdr.de>; Fri, 26 May 2023 16:40:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244000AbjEZOkO (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 26 May 2023 10:40:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244044AbjEZOjz (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 26 May 2023 10:39:55 -0400
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on20627.outbound.protection.outlook.com [IPv6:2a01:111:f400:fe1a::627])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CEC9E52;
        Fri, 26 May 2023 07:39:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fKc+AgqRqW6jl9AY2zDLap57O4AeWQT0vNt1EQJp3b0npzMtOZjEZqvTttK7g8nBFPlEf99aCdYjALpaWVvv+TZbWGyBJ6EJp44bJy86zR9LkQ1dtl1UdOzH9prYrZxyhBwKtSf+cJLaIqxz/CmIHzeD71XNB5FPwbHCUsm3J1ejM6XrgOO4K0bh22Fy2+/b9l0908GaRcILKc6AjffirnrOMsspCRmliY4WSWdd1nUFAeIR7KZukE/8CB0NPD9N4lmySnTrKlbx24aQpprL97utguQ1OL4l7fEVG9G0/zVRcIhNISZ5HkgpKHAnMhask321HMGhN3yrscoVoXoznw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AcE5vMi7/aWPMewDcfZDH3ANpd2MIJt4V0iR3aq2iJs=;
 b=fVLRK074RIpB1jvreF3hKRKmxBJilHIQm8ShAHqXWTRemTvFvbElGev2CUU6TSPA8/v90xy5Dar699dY/Re7VRsQKFIG6B0IkWBx2z5FvzY3IGTEDLTDc85ult9ymJOvjDqPurSJjSVuDLoq2leSQxGn5EEkoLHrUbGFKxJw7j5UBSo6ZzIhVg9T6In37sVlRXEo5SFKqgS5QuLXryoYcIXE8j21+4n2wk2LWiVaPyONJHIvnH0hNhglQXvXBr0iVtebvhyi90j3IriD/NmZF+FpKCFjF0ZTWOorDbeR49x+kIYBIz8BY6ETXCt+5gPtBvM40ULGaVMQND/8zCxo4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AcE5vMi7/aWPMewDcfZDH3ANpd2MIJt4V0iR3aq2iJs=;
 b=UbbJEpw8jGupZLBjfV40V0c3cSTqQZsu3QDUuUEK5GQquBsc2I2GRr0vKn1AuVucNmQor765zwJfxw0pRFrLOgHW9+6d5gmRAK8NX+1g6/+NsjJJXdjHlAGck/4wps5kFj6RehoHTHsB/PZVN8facqzbcYk51j6eWfWT8EqwLcY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com (2603:10a6:20b:4::16)
 by AS8PR04MB8070.eurprd04.prod.outlook.com (2603:10a6:20b:3f2::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.18; Fri, 26 May
 2023 14:37:32 +0000
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::25d3:de2:ef1:3884]) by AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::25d3:de2:ef1:3884%4]) with mapi id 15.20.6411.028; Fri, 26 May 2023
 14:37:32 +0000
From:   Frank Li <Frank.Li@nxp.com>
To:     vkoul@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, dmaengine@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        peng.fan@nxp.com, joy.zou@nxp.com, shenwei.wang@nxp.com,
        imx@lists.linux.dev
Subject: [PATCH v1 12/12] dt-bindings: fsl-dma: fsl-edma: add edma3 compatible string
Date:   Fri, 26 May 2023 10:36:39 -0400
Message-Id: <20230526143639.1037099-13-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230526143639.1037099-1-Frank.Li@nxp.com>
References: <20230526143639.1037099-1-Frank.Li@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR13CA0212.namprd13.prod.outlook.com
 (2603:10b6:a03:2c1::7) To AM6PR04MB4838.eurprd04.prod.outlook.com
 (2603:10a6:20b:4::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6PR04MB4838:EE_|AS8PR04MB8070:EE_
X-MS-Office365-Filtering-Correlation-Id: ab18227a-3e6b-4720-aacb-08db5df6bd55
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: BK3m0O32PpuZxYCt/CdRhrfbvFFrwGidDqDFQwAWtPrfjDwPZgUKM//FrMoEZ9XByisX7N5iDA9OD6KblDloRnLbQ46/q9H7tTLg3ehUrd34Tqt55ENQyYK5mX+sUzbzHNk36bow3ni20t5vvrOaxGHefsQSj+/stw0RZekXHALXa/DKuXZIlLvPYltJ29T+6k1mwlR2aGdBBBSKzDSKtzw9GcdGztfm8oyYvbLmTowr8V2foiMdpcHwTUG3SmGaB9KamrIr4qIaN84iXCbZOhoPyrpmcGZ+JHp3pBi1j5+cdNZDTg+nK2yAtmUf28MuDR6stSIjhpRtBzt+4gRwKv/7Ry8U9U2s81lzF59vWx38XSBh80vqTw7iWyVdlwzKz85TqpPgAJKy4Q82D+4WRHTH8FJw8YZ4DkrytegeHne5UQzptIp2oYYxuaer6wjW+VAlnzGII8HiYE/rgDZC9WUihXXg1zTwvwEUbA+gPBddJ06RDKRZkYjqrvdJrWj8BZHrPNchd/YNIIMk3b8E24GN2MYfFHseaSSxTsL4Ud3uR3+as1U1JDC/fkytEkfoZz8TLUwZfrzZp4wAiQ9lCbzf7UOxKJ1VwqPLDBceV5hjsZtQXOQa7dvEbFv5EJaE
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB4838.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(396003)(346002)(376002)(366004)(136003)(451199021)(38350700002)(38100700002)(8936002)(8676002)(5660300002)(478600001)(6486002)(316002)(52116002)(41300700001)(921005)(66946007)(66556008)(66476007)(36756003)(2616005)(86362001)(186003)(2906002)(83380400001)(6506007)(6512007)(1076003)(26005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?W1DticNar7Vrxi4XtcNxp0PO4XrJLkJXmvnDVNA+7BZli15sc1JncllVUZca?=
 =?us-ascii?Q?Oh+f+lkKv5MP7SNbmI3yte7GglqEwUlFzXSF4YyShpRFbcnt48RWwg7Ldy8C?=
 =?us-ascii?Q?b/If5BDdZahl8WCRgDuVI3HruQuPmMygUwFVxdICE3XHFcyTYOywhoVR8+Yt?=
 =?us-ascii?Q?gwmPkAtRZvMVmDj/AlwfcTFPuweVPihi3Dp0qygcFkR2FADZS4zOxnWMPPzT?=
 =?us-ascii?Q?qBOwxNVRIe1V/+Sw+nfl7KlWFwB/7UNfZ8P6IuwmUf9XFyUliEJJkEddVqv6?=
 =?us-ascii?Q?ObEemb6g8VJdc4lCUvuJk6oHhp5ovXLe0pjv76NCdK8UyDAOQyOa0LSYIafB?=
 =?us-ascii?Q?54STBNo3OmSXTJTiiuBar7OunBUIg+shhBxP14FRBGBeyG6RLvtErTfczE+e?=
 =?us-ascii?Q?hr2bWrc1Tpj+bWvvsnYwSOj64x0VrT1CyB56VSQ9OMcSULPUYcpzyM3CjnQa?=
 =?us-ascii?Q?ExSlwVBq15WmYQvJD5k/075Nir9nCQtAlPt5Vs1gOPPbeg15C2FIxdqpZYhQ?=
 =?us-ascii?Q?coE3filuqDcatoZhGIBlBvgUxgbykPuuSN8PGVUnOgMDkmalxt0zswCaCvaS?=
 =?us-ascii?Q?x8b4nosORtWwnEXt+8bo8iYDtlZZtrbvJMayGEmS5mClU1Z/qSK3lvpfrBur?=
 =?us-ascii?Q?2dy2YdQM63LzFTS64rY0ymdlQeoZjfwBNwTUolDJ5Y4Bw+Q1MID71KPZ+5AJ?=
 =?us-ascii?Q?1cgWMazV+YNEE8kfxuMESiHaMnRZ0IChBTd+99t7SwXg3hJY1lLzmu4fJtBf?=
 =?us-ascii?Q?g8HByE+0KL1yNO+bmZDME+U5XjMO8RswSmd32x7IHMMqpXRpByOXUM3X+gzi?=
 =?us-ascii?Q?jrI98FcuY21dLNWybCsjwRakgf6VVBG5G1YSg1QbWVM2trSPaRA7G9Vp6914?=
 =?us-ascii?Q?YeClmuoONUUuIVTOWY77PlNk6w+vYLihMQNERpgyW3pRe2ACHlkEo/tJExew?=
 =?us-ascii?Q?uKVFRK7VmHF0Ee71hIglq75kmFH/aEcns8gZh6tI2t0Do4p0GHnQxszahxgW?=
 =?us-ascii?Q?VsMsOvPmYwNbaJHePU0ue5CNcRwqj+2r4lC6yfpPb59dQKR7TVzOhuk/EBUI?=
 =?us-ascii?Q?TGhK3x45BKDPWEBaJXShwrDnv+PXwxuzdegqMGXChvLJ+Lz/19wjK/LfMQwm?=
 =?us-ascii?Q?RhhZFMXC0GGB+rNgPIcJikBms5GMC8GiDER3UxnGx869CmXCaJPQq8hDTmoR?=
 =?us-ascii?Q?3n3Ud5Mifw+nLTo43ARq6ciOdgBIAOAJyzLteg00v/DaA+AasnlXiYguXS68?=
 =?us-ascii?Q?yq2RNgQCn2BU4tKX2LZ8jeKW4MrMM6Xxb6AJx8NT0w/4vFDzkn1LqHaI0QMc?=
 =?us-ascii?Q?ci9rclr9XxF8p1jI5IfQP1ac2anCfKzF1hefyH2+M+JJDc2vcyNeahDeRaDd?=
 =?us-ascii?Q?lM9cQONxOmNI8zFldGjO38GhIPlj88S3fBuNpRRcdKJgrJYzsiunu6tqh2Ph?=
 =?us-ascii?Q?swen1c8HohhZj5d1ymvYQTxnb8gn8B0zvIQHzwJUpdlgb8c134IJjJ2ZckMt?=
 =?us-ascii?Q?5JvRAXESgLkEhdf2jlIyWzXlANl07u6H6fxyH+QmXrXEoHbJDNWIHZOijGWR?=
 =?us-ascii?Q?i6m+txX/dR16QJJ1new2hh7JxUTaDC9Mau8KutCU?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ab18227a-3e6b-4720-aacb-08db5df6bd55
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB4838.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 May 2023 14:37:32.6423
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7jKHy6NKZvBHniRcPqeiYoPgStkbyb3jEn96J2+YqpGYlJXc3KSRGmXCrk2SuvYvfL+qzjEvoLins+aOp12w/w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8070
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        T_SCC_BODY_TEXT_LINE,T_SPF_PERMERROR,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Extend Freescale eDMA driver bindings to support eDMA3 IP blocks in
i.MX8QM and i.MX8QXP SoCs. In i.MX93, both eDMA3 and eDMA4 are now.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 .../devicetree/bindings/dma/fsl,edma.yaml     | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/Documentation/devicetree/bindings/dma/fsl,edma.yaml b/Documentation/devicetree/bindings/dma/fsl,edma.yaml
index 5fd8fc604261..4315f854198e 100644
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
@@ -101,6 +105,21 @@ allOf:
         reg:
           maxItems: 2
 
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: fsl,imx8qm-edma
+            const: fsl,imx8qm-adma
+            const: fsl,imx93-edma3
+            const: fsl,imx93-edma4
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

