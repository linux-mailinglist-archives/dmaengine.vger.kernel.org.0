Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E639E78600E
	for <lists+dmaengine@lfdr.de>; Wed, 23 Aug 2023 20:45:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238228AbjHWSpD (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 23 Aug 2023 14:45:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233104AbjHWSpC (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 23 Aug 2023 14:45:02 -0400
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2088.outbound.protection.outlook.com [40.107.21.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81E8AE6A;
        Wed, 23 Aug 2023 11:45:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YcDObnbM1BhHu0j4NMAbcz4ke4AL1FA6XAh0xKFJkpVh+hfPM6c7FDA5BlSG9kMHfLt4FXOTQBFgyXXQE2t+RbkqedoKfWd7T4TSW9KAaDBq/zz/fmcYFxRl30IVkyKhYRyPFj5FVZmVgDsSOhXG6yBnoTIz2rp4pfm2Sa1657EZBt6CeYhAqodEgpRbEHWvnaSxAJwRowGfKedfVK81EskYHgT800FMe2gwJ/nJt9DXHx0Vbex4v6aoNFRaA9SPYfmWL5lBY90Tp73goAP7EOBH9kKFtq9YuB7s1rjUjKSUmZpHhY9IBHlKOIYzAjgtWAYznAOmhDlGi9SUHGFTZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4NctRdFxVJt1OdOk6FYRDsIOTxxul5wldQ/I/JxfJhQ=;
 b=GOcp/GBa6z1U6CavOzL1Efml2TP8+JesJwUatZ0dZF0yCUk+k8qcWqs8wI9apj71HX0sB7rHoJ7JYmRqEAf/uuoVxJn92oLFW99BMr4NtRzefVpOSjphbVDlgelScBzX7wFbUajTFSftX9pMxgLDulwxhA9iegXuVZZYAn3LyKBPct7xhUOmU+x1XmWZR/a7r5sZJKRISZF90Hu0BvdaDYs5bXU2NQxyKe/006b+zepg7BNzoVyseHH7BuH9SHzkQ7FSh/Yo3j35+SB2UpP8Z3rJAU02xXRf70a8eRsCJ41O5ZglaIsxsXh3FIyoduAgMG1L/Q20k7dnynGXKmqg5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4NctRdFxVJt1OdOk6FYRDsIOTxxul5wldQ/I/JxfJhQ=;
 b=JWga2Oj1VfEiHOe5ozynNY6xWu4pTyb6VBc8VL8EB3FjqxYcdG1oxTIonFODIEPVzX9Zc7X9BL798VxJeP2EV1X3366KccQlEcaiBs3LV/8ijGmqURg/nrg4dXvS1xhYZiky2j6vI1dP9n64iXTS8x4ogXdRtU/VBUqrk0Qr9tk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com (2603:10a6:20b:4::16)
 by DBBPR04MB7708.eurprd04.prod.outlook.com (2603:10a6:10:20d::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.25; Wed, 23 Aug
 2023 18:44:58 +0000
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::a680:2943:82d1:6aa8]) by AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::a680:2943:82d1:6aa8%3]) with mapi id 15.20.6699.022; Wed, 23 Aug 2023
 18:44:57 +0000
From:   Frank Li <Frank.Li@nxp.com>
To:     vkoul@kernel.org
Cc:     devicetree@vger.kernel.org, dmaengine@vger.kernel.org,
        frank.li@nxp.com, imx@lists.linux.dev, joy.zou@nxp.com,
        linux-kernel@vger.kernel.org, peng.fan@nxp.com,
        shenwei.wang@nxp.com
Subject: [PATCH 1/1] MAINTAINERS: Add entries for NXP(Freescale) eDMA drivers
Date:   Wed, 23 Aug 2023 14:44:39 -0400
Message-Id: <20230823184439.2618694-1-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BY5PR17CA0039.namprd17.prod.outlook.com
 (2603:10b6:a03:167::16) To AM6PR04MB4838.eurprd04.prod.outlook.com
 (2603:10a6:20b:4::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6PR04MB4838:EE_|DBBPR04MB7708:EE_
X-MS-Office365-Filtering-Correlation-Id: 77ebbb74-773f-4af2-3662-08dba4090c80
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: tN/JQTtj3lLzceTYotLERsia8W8EySKRtWYhfx+4e4R7maAuPkWdBhC+c8oYiIGOJGBCGnxz0r2vm3+xYHWLs0i+WETJRO4C4b6SJ3F0GPhj89nzuNy6HUpnpwkWMqL27xKT/XJ8SdS3BHHBRIqCptm8VhldmwyJVsPcsf3/Y79gEO+pES4FBHu5Y7QOWnuYmVQb5eLxpQAyCEXu9DhHoOsndsIzPpxGtcDmTL8Nyt348ZEHENsyaTpXxtscqibiqEcmquB7VuAA37fLk56LVpPNgXlTNOaG9F2atV2VMEAluNc9o9aiIVjeo+4oUXs4Kq08hKm8LhbnEwZpCJaIoEUzyLd0r/gLIL6AOvWwxdrrTH0OBO4j3au7tcam0C7bgGL/lFbgBnD/G5jNwA71PtptQmougddq6cXFT6QeDQo/j1lYuKZbhR3cij71jIMtyFnhBRDwKV7HQqJeRWrbbe1M3o3W2SX5JRtWSM5KK5Q1ms7DT3SmYy2bxYnkh0wrwOnuKahy+Z1FFmaqOjPDfx2UHk9rwlLA6BYtKCiSyM5jf1VpwtyucRwHvim66T3sBMGp3pduRIqXxbv+pxp3dJYW2iq0y3PCt29doVxVCcj3J98yuIjagtB9UO7Cs59Tr558b1jn964b3BaZUgT7iWAyKc+nGtWSHuzAjSv84Fo=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB4838.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(136003)(366004)(396003)(376002)(39860400002)(451199024)(186009)(1800799009)(36756003)(52116002)(478600001)(86362001)(66946007)(316002)(6486002)(6506007)(66556008)(66476007)(6916009)(6666004)(41300700001)(6512007)(38350700002)(38100700002)(4326008)(8936002)(1076003)(5660300002)(26005)(8676002)(2616005)(4744005)(2906002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?CakdMWcmGW61dW72N4t/lin3HLO8ZraYGRHJfxcF1sXnh8zvWwlOVCmqhHCT?=
 =?us-ascii?Q?hOoGdBjUd6rDwTPs9NoP42VupYMef661+CeYE9ZNcBZgV2niuPEpRB2vcBLP?=
 =?us-ascii?Q?BbdQUx/seFcs/AvZNqq+x9iH00a8biHGitmpGEOA/YTse7l/+LpZfLV7h+kO?=
 =?us-ascii?Q?Vv5OPhq1I+eYIrBIN4QNY4wNhCRje5s6G87jubHmKVVFJgZ/vpv2pWPYdUW2?=
 =?us-ascii?Q?VkrZmVffGMSuGVptPW0iJqOqWaD7R9IGIsybIf1e4BtYLFt3sMyxG+Cl5JMu?=
 =?us-ascii?Q?Q/jutkuekYVX3tFzQESviMSjm45yQ7m18yxNzv+JzM8XyLBhGFJeCllZElXz?=
 =?us-ascii?Q?y7PQy6k+PE3igPAMVs4rGzDoH5+ThQBE7BRC9VzGqydXCOr+rjo/wLw0DlUZ?=
 =?us-ascii?Q?CZf7zwlOSCcYNfzDUuWC8zHkkz0HVt5R8pwmNE/orCn1kZ55dNpa2ijE2T8c?=
 =?us-ascii?Q?BJbbfwR1QDp4tJCyUy7XFcFwAG8pehnDTkMqlZkPMuiNfG2nmUDYQiW9/0SZ?=
 =?us-ascii?Q?xTDfbB4gHJDUiET4BU5eNII7dWQrcu7Xpap1lcEE0G/KKY9aAcsY2HLOWTmv?=
 =?us-ascii?Q?MeznDbBeEIuCi6Ilrj7tj6Ob8sM4y3rjZ6xWBMo9OhcE4EJOGV6MCHR69IQF?=
 =?us-ascii?Q?m9OceROERYbM8KGgC17QGB1qD+lNQuyHfEwnYVQMefsttKF6A/sZ6rYcATlX?=
 =?us-ascii?Q?t0wu2D/tHii/feptRcaAKdVq5cPQm0J2x740IfPIWTRIu4HrAHQGo5mDiv68?=
 =?us-ascii?Q?cYavbl9RXnEVbmZSfBShE63Tw4Bt4BAdzD+dcOx0EpPHHnndzV2p+uwQ5E46?=
 =?us-ascii?Q?0hnoa3GoZQwqaN08ld7mqY1ZUmPI7cV8w3dlkqR6ftN9xYaMUj3Zq/hcCkz6?=
 =?us-ascii?Q?in7qVtC6fI+ny55m/dL0BLy1LeHuh+NtPFFFh7fHqdPIaQ/XpEOX4r+sQE58?=
 =?us-ascii?Q?nGNuzBk36m5FdNiwuXFxtAeQfpDy7FnjbQ3NW1XgAuEnU6rmQciYPLpETlDe?=
 =?us-ascii?Q?sQsNt8PicTH5TsLpPyneOWxktFkZTMu/4NElkB3/p129NxBTT3WUVhaNoCQs?=
 =?us-ascii?Q?1MAIfvzNCckaEOklAnrK7tnbrHMBq9KulBRLny/TBTPgVJzJs+ZEE5iJsPn/?=
 =?us-ascii?Q?NQztyvQT5kbbqZgz8F3FlmtU3YakHTv4jLv5dKvUpIhpt6Ja3q/94+LKMTze?=
 =?us-ascii?Q?EsiiMeGFplX1D9mxuVh/NRW7ZonEq9TI7aO3U6jKp3TxcAECBJ8z9Gt/tO6Z?=
 =?us-ascii?Q?goMqrb4NWbc2/SAzIXCeb7xAjsIRtPs+oKb6e0ZTO4G5I8wZWXdvfT+Eax1r?=
 =?us-ascii?Q?/T4sWtD8GETW1BEioEwXyf253SIDQv9F7/FihDQC/QJbs2Y3/XRMqUXzYO+D?=
 =?us-ascii?Q?hmdAztxD3FEvOU7cyqeZnakGUk857tPPONhqhw+e93Uh/Jx4rW6GifuLoZe7?=
 =?us-ascii?Q?4eSPVP/CAFYKSWqF6KGHyLiRwQTil7fEZyqPSxVNRYs+wv2gKw0B+yw2PKuu?=
 =?us-ascii?Q?x9kdwse5NQHLAx1ZZ6mt62RESXeuNJCr7Wf2WBF7vQ5MpyICbvortICK21Hm?=
 =?us-ascii?Q?x2TjUOQklcsJdoTN91YPAaoxkdTNpzrVR+U//Ibk?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 77ebbb74-773f-4af2-3662-08dba4090c80
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB4838.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Aug 2023 18:44:57.7690
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AkhrACGoU9Up2aSJaCULRucx5C37KQ0DKQLs/uAIShXIB6KoLIDBUZ2gY+on/Kpnv7dG+rauKEmh75F6SjJ5sA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB7708
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Add the MAINTAINERS entries for NXP(Freescale) eDMA drivers

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 MAINTAINERS | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 23eafda02056..eba417bb5ffb 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -8228,6 +8228,14 @@ L:	linuxppc-dev@lists.ozlabs.org
 S:	Maintained
 F:	drivers/dma/fsldma.*
 
+FREESCALE eDMA DRIVER
+M:	Frank Li <Frank.Li@nxp.com>
+L:	imx@lists.linux.dev
+L:	dmaengine@vger.kernel.org
+S:	Maintained
+F:	Documentation/devicetree/bindings/dma/fsl,edma.yaml
+F:	drivers/dma/fsl-edma*.*
+
 FREESCALE DSPI DRIVER
 M:	Vladimir Oltean <olteanv@gmail.com>
 L:	linux-spi@vger.kernel.org
-- 
2.34.1

