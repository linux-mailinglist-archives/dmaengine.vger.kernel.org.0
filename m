Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 98CFD74B6B2
	for <lists+dmaengine@lfdr.de>; Fri,  7 Jul 2023 21:01:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232774AbjGGTA4 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 7 Jul 2023 15:00:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232773AbjGGTAz (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 7 Jul 2023 15:00:55 -0400
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04on2051.outbound.protection.outlook.com [40.107.8.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33C9210C;
        Fri,  7 Jul 2023 12:00:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZjFuMq4MvSVxs3chFgd7uRLQgH//imWaoq5x4S4X6/yU3KaKKsCva0HEgVAC2g3HYTGDiIiNecHGRht9IDHpBbObvg9ph2qSzO+cD4Xu84HPSpTqF1TDuJ+87NpnZCeNNy3pdK5Ks5ni1DMrFNhgfGE0zbHtWu6AiLjjaEvtG5KUlnmg/kiBZh0KXHIfUPjB5xUDUmjaN2jYKgGrpqNmrzBETbJJq8AxUy1L6zuAIekDg1HC8QfIZKioD4XJ99qeLQjojx280SnCGleDaVOwY6ke8/6/7ETbXqM6we5AXh/50o71eEYQF+y4J/9hTmiTHbdXIjaRosvPQYKWLwk4gA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5ZOgPE2Dl4YD1w4FCyI7Ni+HFXQQPkwbBweq93zVzcw=;
 b=c59uVkVSRbwDHR5mSi22Tdrs75XOtRc3D5S/0U10KzRoM6J+JsL3qvDjDl1SoPRiZPGdxA7jeyCcPJWqonIXnANKojHResTJi7zIaRE0nNLyT2RYjrcFcSkKhvTtdha8jGdOKzjtf0D3GlxQXPG28eH8d3r0mqLhNlH0BeDjaMMcmAOQ1qGMU7yEv0EGBo3fAuV3Q/p01AoQObymFKwG2W+GfUxOikMF36ytstAWnnJCq1s2bBDJRmQ+PSRw0ODaarZEnlhg4R9MFoxyGBLhTWC+4E2a/T3H9IiA8X9ontsWhluXv4tKGfYu0bRLV5g0eSQNoiOLv8rR9kRyZbYnPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5ZOgPE2Dl4YD1w4FCyI7Ni+HFXQQPkwbBweq93zVzcw=;
 b=XqSRHnUMI1Bg74IFrcalpIlH8OhfRHbGgNczzzkK5qsarQDBHgYrcQJ0eKZfFlnYhjlLPAgBwJqMweOi9iT5wiNijusUQp3urahQbLjVSbAifamgtAauscHHBgcb26l6uWMHpOelOeTT0GiZq0i01kwy6KIlwvyNsC0w5lg1xYc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com (2603:10a6:20b:4::16)
 by AS8PR04MB8103.eurprd04.prod.outlook.com (2603:10a6:20b:3b3::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.26; Fri, 7 Jul
 2023 19:00:51 +0000
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::4a2a:262e:415f:e41c]) by AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::4a2a:262e:415f:e41c%7]) with mapi id 15.20.6565.016; Fri, 7 Jul 2023
 19:00:50 +0000
From:   Frank Li <Frank.Li@nxp.com>
To:     frank.li@nxp.com, vkoul@kernel.org
Cc:     devicetree@vger.kernel.org, dmaengine@vger.kernel.org,
        imx@lists.linux.dev, joy.zou@nxp.com,
        krzysztof.kozlowski+dt@linaro.org, linux-kernel@vger.kernel.org,
        peng.fan@nxp.com, robh+dt@kernel.org, shenwei.wang@nxp.com
Subject: [PATCH v10 01/12] dmaengine: fsl-edma: fix build error when arch is s390
Date:   Fri,  7 Jul 2023 15:00:18 -0400
Message-Id: <20230707190029.476005-2-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230707190029.476005-1-Frank.Li@nxp.com>
References: <20230707190029.476005-1-Frank.Li@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BYAPR11CA0067.namprd11.prod.outlook.com
 (2603:10b6:a03:80::44) To AM6PR04MB4838.eurprd04.prod.outlook.com
 (2603:10a6:20b:4::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6PR04MB4838:EE_|AS8PR04MB8103:EE_
X-MS-Office365-Filtering-Correlation-Id: 40b614a0-fafc-42cc-1509-08db7f1c7b30
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: DCRcqOBmxeVC6c3zzI3/uGapveYxcWyhNOZihSQDHnKMACnskVG5v63BA9hH3ULo7zO0dGD775buGTpuMXPLGYIFO0fN1Xpbops0as5bSC/DLg/v1uXwjpb3T2ZkAONLtwFNyYRjsHi6t868ePMEvmh/6b4ibI7GsCAYqvaP7uDRcgpOgWSrjAR6F0WiF9Riuma0pP9/KVeafKTF6vKZa7b0pMu5DBI+IhwKV3FNkUYFgDKkuLwBwnh/CuJTsqsoSKo6N1hWpYspKNQT6dpbnK8rIIkbuUe17ZzXzFAzbmrqRLYa0rgOm/tHC+QW+llQYrPh8pFEcxTBh9VWvcTdeLm0b8ACJBR6M2JZXgLc4Mc+5BboyRKnbO/s40DA4ZKBUmsqy6FYPMdoQS1alNnVe8PkMBp43fZV2Qy8WrPpUe/JMgGEwRQxVP9cZWAb8yW55LkR4NyzPwZIp2NIgPyWou8dLHdzuboFEaleREb1W02HN3rJiKYdSFKrwawQZI11zaUTSwDx1XdR4DAVKVo+jsyYtacLS7MicgWYgjn3Z1VqxNXD8dIS7AwUnhKtEpYGC7GHQYKsrPb6zDfH3ZeyLH1Y/eF+b5dVk2RVRzG2HO0=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB4838.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(396003)(366004)(39860400002)(376002)(136003)(451199021)(478600001)(52116002)(6486002)(6666004)(6506007)(1076003)(26005)(6512007)(966005)(4744005)(2906002)(186003)(41300700001)(316002)(4326008)(66946007)(8936002)(8676002)(5660300002)(38100700002)(38350700002)(66556008)(66476007)(86362001)(36756003)(2616005)(83380400001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?1ieNa3hD0vigCy4rf3QZbSC38DQmG3YhYMwUw8uL6qiU9A5imvQUcV1LjrKd?=
 =?us-ascii?Q?q2kl8T8V5KcmV2b3KxIfhJrgyUevbyvPXzWXAF9hj9XqCAEz/FOlxhzoiNpq?=
 =?us-ascii?Q?BWxuQu+e/I4Iuh1kjDU2nupTvlHdAIedAXF9UhztB69aTJIKKrNGuspB11Hv?=
 =?us-ascii?Q?FQoHkTYGDRpFVaGKBlsB6uKjRIYEV02JAzVf2VWU4A5oO+g0h/NBaCgypM5T?=
 =?us-ascii?Q?Cb7VYaKMhexEAO21S72uro10RKD6ETUVQuhrvSirxLUK9uGYxJ8kdn11t9jG?=
 =?us-ascii?Q?cADklIfCuSlFqlrZgtcGsoBwGJu8G6trEpOjcAY32brSOlUx6q+PzX9i1n7Y?=
 =?us-ascii?Q?DAUYnX2ObbgUqydUsopsEOgyPB/KlpVsoKoWQddoRY7z3mIgTDwt+qYlJmka?=
 =?us-ascii?Q?kIy9fL6BtioEskQiFtbt/6w3ZfraPMJxSRNHCKEsFGtOXTA5LRxPSHebWnBp?=
 =?us-ascii?Q?du3jfgZiVBHpN6s3vN33Hfjh4pozOTy6zkH03JCBGv3GzexGTCCgxrbFWNNE?=
 =?us-ascii?Q?BQp23aL+MJgNl666f5+7DkQrHF3hbZ5NZyggPgb7BGOuChFQ2i2ZGjoBT5r9?=
 =?us-ascii?Q?jidXfoSwhj+83nA0dGBou074w9Wx0VRCMDZZlDWqwM6hQx0tWfbnkXvsPNeu?=
 =?us-ascii?Q?3LJvw/KZ+PvZnICDnjH8LeLs3ZQHd54nJqVHmnykS91e2k6WywVr3EfGcoux?=
 =?us-ascii?Q?cbWLHCiQpfI6mxKGP4lzw0gLyOOiJkAFcs7+Ke2H/gzAF9wuaiWkFfGZM7aD?=
 =?us-ascii?Q?HEdZnm12P6sl0RBtBXrEkvrQr8BUOnxjJ26GkxVNlPNGTUZ71o9u8vgEUsiT?=
 =?us-ascii?Q?jCcrozA5jd9k4DQEk4+JBiJ6EYB4iEEJuDlq3bMk5Jq4C8qPjp7vegj3AbjF?=
 =?us-ascii?Q?zpUg2MWkWoQjbfV9cl1OrM+yrRY+xNu7N1x7747J0Jkf0ewgYyE5k/xHf5CO?=
 =?us-ascii?Q?vqkWAFaUB6pQtOV21C4qJ67idNVK2sBzu/nbqtEQo9toMOwKw/kMOnmRuEUK?=
 =?us-ascii?Q?3zVqdGJQMB0++gJ7G+4BKU8mGXou1K7h9oW/Ays+SXjNDgebuhYH0hiwb/lC?=
 =?us-ascii?Q?DpcljQxsVOF3hxWciEppPRDfEKhA4ypUWN6+PSAlbO+k9gzMcyh6PswuK25R?=
 =?us-ascii?Q?98LKPt0VGa0USK1SqnXwq5vCgCk8ZNdR9Txtis5PDqYyMJBJu9qhf6XEHmkX?=
 =?us-ascii?Q?D1rzS4NGXjwl2k/FVQ4rPj154lRSDDvUJmlBF6EyN9BRFWwJvKTzeze18Fzw?=
 =?us-ascii?Q?Y5sQK/GCDWeA815VgTHIOO610d7Wowfl+NLDcpgcR1kKM4Cfs+V9S1idr5XW?=
 =?us-ascii?Q?BjFPMhi46B2XBcIrL1W+f7gNjSAtVciFRDEKB5gEuVaKyIsUoik3TXxee+Zx?=
 =?us-ascii?Q?uTIIC6sMRiJNzLb+E1b0UzYzBd6ep+sgtUZXPfu8hAW0aEnP6T83Xrv+kLgU?=
 =?us-ascii?Q?koJJOpf/rRztANBWyXJj8KAoydl4ntrGbe4iU3xIRC3N6TvHMBu901au+UYY?=
 =?us-ascii?Q?8rbyQ4Xd9y5RHyyCsDlRYD0TjiSWhZK7l4TJ4cq79QFi8szfZWwP85ckZAQx?=
 =?us-ascii?Q?2n5dUmCU5pC8RCjull4=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 40b614a0-fafc-42cc-1509-08db7f1c7b30
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB4838.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jul 2023 19:00:50.8774
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: N/0WFBK0j7+2c/mG81Fhzr5Rz0sxvRZ7C/LegCjuNsEZvmAjxL7uWL+eeC2XumxrNE825oQ/KMoMb4Ajx/sioQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8103
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

fixed build error reported by kernel test robot.

>> s390-linux-ld: fsl-edma-main.c:(.text+0xf4c): undefined reference to `devm_platform_ioremap_resource'
   s390-linux-ld: drivers/dma/idma64.o: in function `idma64_platform_probe':

Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202306210131.zaHVasxz-lkp@intel.com/
Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 drivers/dma/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/dma/Kconfig b/drivers/dma/Kconfig
index 644c188d6a11..ac4a3fa94c3d 100644
--- a/drivers/dma/Kconfig
+++ b/drivers/dma/Kconfig
@@ -211,6 +211,7 @@ config FSL_DMA
 config FSL_EDMA
 	tristate "Freescale eDMA engine support"
 	depends on OF
+	depends on HAS_IOMEM
 	select DMA_ENGINE
 	select DMA_VIRTUAL_CHANNELS
 	help
-- 
2.34.1

