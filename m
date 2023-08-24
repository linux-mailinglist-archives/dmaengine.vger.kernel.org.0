Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 039AC7865AF
	for <lists+dmaengine@lfdr.de>; Thu, 24 Aug 2023 05:06:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239342AbjHXDF3 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 23 Aug 2023 23:05:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239443AbjHXDFX (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 23 Aug 2023 23:05:23 -0400
Received: from EUR01-DB5-obe.outbound.protection.outlook.com (mail-db5eur01on2045.outbound.protection.outlook.com [40.107.15.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A97010DF;
        Wed, 23 Aug 2023 20:05:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NuAzQAU7QyLoOA9+Awx+InM7uA9xwlp4t0WsrXwliELN3CNQ0wZUga9oSKz1KyXOdmNgpTZEBDvEWzixhR8euyiFGu2z+oDRVLnVVXJkL3khPTY/ql7DAEdtnah79XrQtLWKMRVSc6QUN9xncE/UOhqry9NJtoGEzJkOIhlV40CJzALaci4HLm+n2vKv/cZ/PO5YMxYBoLSVP/SzoCL/+BNf8Tng6Fa+kwBubDdkx2deXaprUVkM9W96lS6NcgYApoR6EsZXiFh1rEyj4vTJnhiPoa39WLb1ITZ0rwMKkbQLpgz0rgiJpK/pZ1u3CsZ2M+r/uurCu1XGk6ZwUT+hDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WdO29vcj4UUvd/mRUCuve8rhgnj3GkKsf4D2sgwQFkY=;
 b=CTNBT/mhxaTDEzA1rBVpo6egZabsMyI0tS3dbAvCHOCpFfLzmEL0j16DppSEG6wGnEvP69AV0J+qviwtkx48lV8YxRFsLRB7AM+vXr72hUOt1NA/c+/yD7bweu05BcSaoPTcXNsO2Hvx0si0T8VaU5ctBSL0rrDMcRoBFIBuQnrx4WVOsmUZknaZSTcO6W7ib0rXqInqPkbPtZO8x4UCAp/aVDddhP5jHWhswy1/vpEgSknMO+3C1EB+ROL7PCmIPIel8iozfk8WCmVSqc9hW4IgyZbP7SNhElkxEOzY3UHYNaMUOCYnVeQk+Ry+bUn0HTXZ4G/++Et1GSmHAIPT6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WdO29vcj4UUvd/mRUCuve8rhgnj3GkKsf4D2sgwQFkY=;
 b=sWuZrOmb7zJc9fmT/kfQWpgXTA4a6KUgFGxBcpGpjZYVD0JJvmnHLBFffux3mPwuz9p/9dd9s4+bqu/YhHk2uOnYAjvDRx1ORHDk34EQNhch+wAi3OhkiNMAPvQ0mrH7hweAwt1QSHq5+0I/K8w6sC9jLqXy2yXroBprZlcyqXY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from VI1PR04MB4845.eurprd04.prod.outlook.com (2603:10a6:803:51::30)
 by DB9PR04MB8429.eurprd04.prod.outlook.com (2603:10a6:10:242::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.27; Thu, 24 Aug
 2023 03:05:16 +0000
Received: from VI1PR04MB4845.eurprd04.prod.outlook.com
 ([fe80::f70b:a2f2:d9ae:ce58]) by VI1PR04MB4845.eurprd04.prod.outlook.com
 ([fe80::f70b:a2f2:d9ae:ce58%5]) with mapi id 15.20.6699.026; Thu, 24 Aug 2023
 03:05:15 +0000
From:   Frank Li <Frank.Li@nxp.com>
To:     rdunlap@infradead.org
Cc:     Frank.Li@nxp.com, devicetree@vger.kernel.org,
        dmaengine@vger.kernel.org, imx@lists.linux.dev, joy.zou@nxp.com,
        linux-kernel@vger.kernel.org, peng.fan@nxp.com,
        shenwei.wang@nxp.com, vkoul@kernel.org
Subject: [PATCH v2 1/1] MAINTAINERS: Add entries for NXP(Freescale) eDMA drivers
Date:   Wed, 23 Aug 2023 23:04:54 -0400
Message-Id: <20230824030454.2807336-1-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0085.namprd03.prod.outlook.com
 (2603:10b6:a03:331::30) To VI1PR04MB4845.eurprd04.prod.outlook.com
 (2603:10a6:803:51::30)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI1PR04MB4845:EE_|DB9PR04MB8429:EE_
X-MS-Office365-Filtering-Correlation-Id: a43f63c4-c643-44a0-d805-08dba44ef02e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xeuOjvRe9rXUNHXCI6S3ZLSkFM6xRW1XcmZi91mEyZYPsbHWwqUgwCwunnU4F5Hn8aokPYTP44UU6HQP3yd950giVw/iOkTK+liGZozPAxmzB9mnMWJ0CiukJkqSTu+j0X9AAconmquV1RoRDd7s0SGUQbNgnbq4hAUI/b7cEGlB9ht/DvmGnLTljRonFiE8dJI2zmEJ3TBc+4vRhnHzVqc+xs0ddFYB0Kj1hewJ6tlo1OTlcPiWeJWIgsX32oOPQjgTN8A0ORR+xkyjqZ9NINmX82b4BRnd1NOsWeOlFCwC1xESOyalXeHNne3GB2XJKLRQjhui3Sl7jdjVo4y8iCh/BaaV25X+j3MvUEi4UjtPU/4ftR5n5e4E/T9XRoTNb5R1JK75Bo8HfaSw6s5OcCY+7p1tWKctvY+rz8LMzukLgWLwYqYg8X7mz2UbfBQ6KgIQTRYgyczTqqgRKH2wbHgwv+1RvnimT93/ITHUZ5A0sk8BQcKe2qJoPoC2s645JhBBObATZK0Au6KYwwy2WAiSWOviSgQgDG86Q+ygm8LAz75vToxIY+SWILQ6iCNuAU4UbyCs16YT1tvGOWEdbIw5pfbMWWgyTVuoMDAFY1VHT96w2m9Tkz5GVOvasMj/
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB4845.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(396003)(39860400002)(346002)(366004)(136003)(186009)(1800799009)(451199024)(1076003)(2616005)(5660300002)(4326008)(8676002)(8936002)(36756003)(4744005)(83380400001)(26005)(38350700002)(6666004)(38100700002)(66946007)(66556008)(66476007)(316002)(6916009)(478600001)(41300700001)(6512007)(2906002)(6506007)(86362001)(52116002)(6486002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?waSg378HY8bP+ZRdhcmGUAoEhwCOVqfABSmZaz9C4aoWfKSZ2tXgZEI6bwq1?=
 =?us-ascii?Q?fN99f8+7/e/wOkEGYWyzknF/cJxYf749S4Kpkl9kjUeSHMPxlCZyuEZcC/Fz?=
 =?us-ascii?Q?e1nkpEJiSO9C+0DlHl49A0xpOotSNqOu3tp6pIRVW+ecDVY58Ux36HWiPDA3?=
 =?us-ascii?Q?LRv+C2EjsGoNGYPHigKdTKsE14mqvMQbb1Mg9KwcWK6dkuPluZUoHYurpP3M?=
 =?us-ascii?Q?mtpZ0IOIZvRuqDkB9NQ8lKA5RwixK0kigeBkSZmm5GwlfAdHKYGjnKD+ZKGS?=
 =?us-ascii?Q?zBMVCH+BneRjNpSeLjqAGK1EMTtAiGxqlHR+5bNrrQYJU6A6PesxApR0L/wB?=
 =?us-ascii?Q?mocwipalVy6FN5g57FF2iC8DFTt9v/TtXy9JNeA2O5nwmO5Wkc5wRBswh4jM?=
 =?us-ascii?Q?VdZED6uzmiJY64s46cyDqjofnsAd9Tx0PiXEBrg1gRIZcX3jVJ+FL/vscsVx?=
 =?us-ascii?Q?vr5Ea2dlyDPfK1nEV2hoFr2GSN5tnz3hwnJZQ30+panl7e3YKTrvqv9If5PM?=
 =?us-ascii?Q?uCLgROQmJlp+jef1CGF1d697RkuxYxmqOI3ObvlktkvGP6gHwso1B8djzQwd?=
 =?us-ascii?Q?IuZUln/Z91w8gJ+sPkcli43GS4AyYAvFnjSMl+Ph0mbrhXq6S+PehiZdhqW0?=
 =?us-ascii?Q?Cc22ZckpgTSbC+Pw2Jym6Yse12gyW5OY5pu/pWSoavOCkRZXjsC37BfKQXF6?=
 =?us-ascii?Q?zbl7DbbYcuGdGAEuBg9nRbwQZEyDhnCsUKbnZT3cXVuufmIY1mbP4xLGuDBI?=
 =?us-ascii?Q?z78X5QfwWSQrb1s5Pkd3a5bcQBWLsnx180RgYMgp2+9H00UjfSqtr66Medsa?=
 =?us-ascii?Q?6JnEj/eTNPNGlIMQNwK/M8tULO3lvTfkI3oaPUWbkMaq2KMjkVNGLLA8y1mJ?=
 =?us-ascii?Q?EE9B+Vgm8vMYBG8o1zYSLTJfFkebj5rD4eIGkhaB7qmj8JXWpwo172tU6WX3?=
 =?us-ascii?Q?um7Duvn1H0+rQ1kmmL6vHCSatRuF3kNQHZEQm4u/CBIB6DV9zjnkFWPbvTZw?=
 =?us-ascii?Q?d3SSFzYhFhvzyKFsDHD5YA2EbylOsXbPoQ1jBLW/xTZulyj7P3rxwkoWPVwe?=
 =?us-ascii?Q?ZSmAB10NQIt+JEpV1qBnGSDUtZcmrgyv23jvWBTX4k4JzoNmJ9aQXLZfzsQW?=
 =?us-ascii?Q?SQioTIG/cFGr4D+7KOl3OxVrYHq2J83C4Cu/QdUcAcJ+Fi/Au+kKqOfJfgmR?=
 =?us-ascii?Q?LnQ8mU0f7Dd+/1WCJdGFWFxq0Q1+cW0wvblVNlxv2EOVObdBsYDH2BXJJWdf?=
 =?us-ascii?Q?/idhIjImXQiA79m56nZTfJm3V92SD7fjs5kKJYRobDsNv6bFVvjLdMeanM1H?=
 =?us-ascii?Q?M05yf+KvLCUbFJF0ncl4A2zXDB2WKb/FLTzX7Ob6hCcv4EBLbtRbT9RERw1L?=
 =?us-ascii?Q?x+3bvH95Nk/ODlk8CG+LqHy/qxT4HSUoxw9o1WEVZNuPR9zDS3rx9tTMafPi?=
 =?us-ascii?Q?WosZLqP3Y6xX4lQWsv8JjZOnNUv7yFrpwYbQIJXJluIUCLgJgz0jHT9iEZTz?=
 =?us-ascii?Q?gC6PSd5ckU6yqtTEYCG6gLcQXeJ6YSdB4uTqAvFiwq1YnnFDFLFNye/b/L/3?=
 =?us-ascii?Q?IHQVptCMzSvztJBiV8A=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a43f63c4-c643-44a0-d805-08dba44ef02e
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB4845.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Aug 2023 03:05:15.2531
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: izHMRRXW1PfzVPIKJGc4ZMnFEOQEjD7YzNFamDfgdVme5X2Eu4jR/xHHA+kMllP2rg/XBSQXUB3qdwZSEZpXwQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB8429
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Add the MAINTAINERS entries for NXP(Freescale) eDMA drivers

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---

Notes:
    Change from v1 to v2
    - alphabetical order

 MAINTAINERS | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 23eafda02056..fbab3c404eb9 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -8215,6 +8215,14 @@ S:	Maintained
 F:	drivers/mmc/host/sdhci-esdhc-mcf.c
 F:	include/linux/platform_data/mmc-esdhc-mcf.h
 
+FREESCALE eDMA DRIVER
+M:	Frank Li <Frank.Li@nxp.com>
+L:	imx@lists.linux.dev
+L:	dmaengine@vger.kernel.org
+S:	Maintained
+F:	Documentation/devicetree/bindings/dma/fsl,edma.yaml
+F:	drivers/dma/fsl-edma*.*
+
 FREESCALE DIU FRAMEBUFFER DRIVER
 M:	Timur Tabi <timur@kernel.org>
 L:	linux-fbdev@vger.kernel.org
-- 
2.34.1

