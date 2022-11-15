Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 321E4629478
	for <lists+dmaengine@lfdr.de>; Tue, 15 Nov 2022 10:37:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232425AbiKOJhL (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 15 Nov 2022 04:37:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229681AbiKOJhK (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 15 Nov 2022 04:37:10 -0500
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-eopbgr70043.outbound.protection.outlook.com [40.107.7.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CA4B13D66;
        Tue, 15 Nov 2022 01:37:09 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WSsdjqVGNMGsIzbScxwmrAP70wBh23iZjoQh/cEksWDn4O0ZuPCGO7oNndXZRnX2NE1on2GksnNKhJWpe60dqwKoNlPw1/iCmPe/aqK6njfLsl2qapVcSFX/8ZMz2PSdCoH4cZAx8QIHaRfNXygCTTRcTiLAo4vuQ3Xyl8VJVJM2VFtnCS5eMr/ubkgn6KrXqME5TJDyYHVMiL7xSSY3sOV9v+zRlsW0rl07trkHznlRxYMYGIXOXtPTsyBIzvOqzoPV9HVo002N+BdfU3kdgS7MppJCsGryFQRm1Ig4MYguP1bW5IIInbJrBWGvBRcnCNKmza2Z1fZ4CLrAb1oJmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3VrjJy/viKtUTs/dRGwMV1X0W0tQdVKWwAITPA4U3ZA=;
 b=U4Qut9iYjDMkX3qj6eby+MpMYXu11rWqD6wq8RlEkDTVJgMh/roMs+Ho+RkrbwfoKXpSPFfuy+QRU+0gXM+wosvlQ8TobCRjVeOUyrz6iLwlLvH28P+S+1dkHsEyjYiRDPVxm+hnO9/iJ6+LpW3RIHVzBQBIS0l24d7Jo/rFoYQSIdfGrtVwyqS9iWOR/Z/eQt9RVvSOS9WKYirKmXxk/T8aeKn1AcF9jV6xYSmYczzWel0gQ7+xOxTVdVbHxGFcNgrbzYxVAa2usGk+bkVts8VQSmWT3cSsVA/qC98ozZgIk5e+DyI+GKO3KQSfWi+xkx6nCCfCWJNQQbgC1EF5/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3VrjJy/viKtUTs/dRGwMV1X0W0tQdVKWwAITPA4U3ZA=;
 b=fgM7KPuPTec238D6dJlwpUSN4d86NhdWo3k/qdGX/XWFItUdjvUBKNA2eN6FGu6ea8oSPNyVdfp/5KP3omXWgbW+/lNB9owYq5O4K5xUNWFiMm9Eo1jfomBEzliWfZboFmPbSWhiv8/m6fb0BWdpTeAq6f4KlD9bUx0D7Xwdhk8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB5925.eurprd04.prod.outlook.com (2603:10a6:20b:ab::19)
 by PA4PR04MB9462.eurprd04.prod.outlook.com (2603:10a6:102:2aa::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.17; Tue, 15 Nov
 2022 09:37:05 +0000
Received: from AM6PR04MB5925.eurprd04.prod.outlook.com
 ([fe80::7a34:469:fd53:922c]) by AM6PR04MB5925.eurprd04.prod.outlook.com
 ([fe80::7a34:469:fd53:922c%7]) with mapi id 15.20.5813.018; Tue, 15 Nov 2022
 09:37:05 +0000
From:   Joy Zou <joy.zou@nxp.com>
To:     vkoul@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, shawnguo@kernel.org,
        s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com
Cc:     shengjiu.wang@nxp.com, martink@posteo.de, dev@lynxeye.de,
        alexander.stein@ew.tq-group.com, peng.fan@nxp.com, david@ixit.cz,
        aford173@gmail.com, hongxing.zhu@nxp.com, linux-imx@nxp.com,
        dmaengine@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v10 0/2] dmaengine: sdma support hdmi audio
Date:   Tue, 15 Nov 2022 17:38:21 +0800
Message-Id: <20221115093823.2879128-1-joy.zou@nxp.com>
X-Mailer: git-send-email 2.37.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2P153CA0017.APCP153.PROD.OUTLOOK.COM (2603:1096::27) To
 AM6PR04MB5925.eurprd04.prod.outlook.com (2603:10a6:20b:ab::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6PR04MB5925:EE_|PA4PR04MB9462:EE_
X-MS-Office365-Filtering-Correlation-Id: 5968caaf-4df2-4442-b4ea-08dac6ecf4bf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: CsACllp1XHCvs+oBrBhbHltHCgDJtg5gYzv80AadNUPy0CigUZeIWN9CW16YMgqYBEKep8SZ/fS3UqSHkCZB/iWK0lfHCshSRSMPVUtW4PA/Zh/dzMEhNAX5LoN4BYCmIhLasC/kgDCSARdEr6cqJQlJstqqIWa7UGb213TQ16egU+1o1Mf34bE5EziaTXmcBFqiwl4tXrYshd8RbU+puuFeVq7XeunY57ymFaY93N2JDjd2HWT2Mi775IUjfxPcNhgkcxITEWPYBMxInERECEeuckY6Un1jtA70oXKwWkLbcZz+svZu/WmjJdxcjg05iEM7aeCBWFXpSAbQHWNUvfwSZhGgJ663edufniLQ/JKYSuhLGYObNQx0AQuAfd/YVt5JE/al2cpySySyJLYPmKb8adnazJAOkUwrm00Eiw4vIx7J9JVvS+YG3YN9ie6wfxQaxf09vpUsK+FXEPfUiYS5Ilsjr9T3JJDGWyptiQpRd5v1wr+Xe61j1zxDG1zKOYB8Yk11FwS4Wj0hPcZsJ3+30svA0WH0diHc8ievgojjiMxtgnfKalQeqhnJXhohsX4JorYGF2FA4TG8oOhF6HeC2a2Q4PYcGV6+Xt5HffNCC139hnNDFFIHUV6TpGe71hYuZ+1DMZbQP2UTYBWORZD5Pi/MR4DLyMOrk+pZwoURuA6Re/M/SMX6Lvqw9e6X0L3nEj6crCwjXyVkxkN46j9gvSPtRWh1uNDo4y91JS9u/gixgOubM3UTco+NSSFbuz4wwYnuWqfbSbALUMaPJg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB5925.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(376002)(346002)(366004)(136003)(396003)(39860400002)(451199015)(6666004)(478600001)(6486002)(5660300002)(8936002)(7416002)(4744005)(66556008)(36756003)(6506007)(41300700001)(2616005)(52116002)(44832011)(2906002)(1076003)(66476007)(316002)(6512007)(26005)(8676002)(4326008)(66946007)(186003)(83380400001)(86362001)(38100700002)(38350700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?rTvdHb+9Y781tCWR3+dytuiolVffpBiE99kuROnJ+bHH8w4m9bbTSEQMSYe+?=
 =?us-ascii?Q?lvpjqUc6zmb+CwBrtplwHPuILEphbdwZqbdR5gr+qgJf3chVssFBqFOB98eF?=
 =?us-ascii?Q?eZ0u7hb9mXurJru4HwvGi/8gZTpBtdGBD+6uGuwBvEwTZ/zd+g6UJygSIq4F?=
 =?us-ascii?Q?/auqZXLjTOemlIQg0wAYzao38AY5ipZM51NKqo/8m6IqsLDqyXh60aBCR5+K?=
 =?us-ascii?Q?gBsft95d24KA/h7+3oo9UsRiKql8JFuphXp98+ZEwXSnk4W4IDYdRsbVItP2?=
 =?us-ascii?Q?dbsxHI8UoX78Q9BU+3HMn2piWGLCLITVp/dszm+VpaZ6fRng/XkONjffYU97?=
 =?us-ascii?Q?mljiemUjiW0zUkssZKMOYsFMT/DkWRU4VF4x8OaAPzXi+rEzJm/OQJG+iUdT?=
 =?us-ascii?Q?SCtNg1A/f6cH9xEr9f7jWKUsW+O/BYEkgzCVrAWdnnRdAW5M9zlzU7ni7iV1?=
 =?us-ascii?Q?VJTNK9APQJfqaVQhsSM6QKQSmqIvfUdfD0U9STV2clUs86agWwg4RDqKCmAY?=
 =?us-ascii?Q?4dZo8J+LzzlRjCoU/nFmvlqrmVY7LFqQZqR3U/C386HMaE8T6goCRtzCm4ea?=
 =?us-ascii?Q?sxKLIgCpCwV/zSLRJHIL+lWyKb99eYtwq/OjTQtBbM20l1f5tJAgIrHR808B?=
 =?us-ascii?Q?xnRkBcUM8RXKmawT6MZMqof3WyjuRdKSGzAsUb4AUZIxkSHH20eB662Axl8H?=
 =?us-ascii?Q?G2OnoZNSx5XHGGii2oN4pMYQRMBwmNOg+5Oy1shd7LR/co1TQu+rY7tNnJZB?=
 =?us-ascii?Q?CcCB8U8x2MzGOaIH3674ZmcUn+CsicMqHk7jzodFmeSgu42AoJgiA3tNeOQ6?=
 =?us-ascii?Q?u1LAbyUfBpEIYEDWibQJz/cMacskxlxZBO2utEHR8BTmzfuPX1bYznYgzUER?=
 =?us-ascii?Q?JECbEGKhjyDidzRu3Q9DYBqjo/853ndDjsqiZ7cbp6rULVOpArH8743GxTQX?=
 =?us-ascii?Q?yfoCNq22srnaIbmamDnAP5QQqNkGO1snwQNUz9ittYedrpkJhZ/FuIdYdw+B?=
 =?us-ascii?Q?JsPYn9q3gc/lEWF/pX2dKSi0L8Lr3FZQlAeiUXE9U5MHCaDWIH63IRnbX1lV?=
 =?us-ascii?Q?PjZSWcV9iGvd9mwa3M/zfsrmXOSqMyexBPyvf0Wa9yVpEsemJ72S/sSYDBHj?=
 =?us-ascii?Q?aISvEk3H5aHMXhEGAY1eOSrbAuL7zCfT5sT0li3AuD12JtTg0rx60oOUYdiX?=
 =?us-ascii?Q?vUGepg6kxMMxcrpMGEvZVMmjmai00ee/4x2U+G9jLsifQAuDpb4bn2gX9IDc?=
 =?us-ascii?Q?RyIyuqmz+4SsNaV5iUrWFkxuKRtaoYQw8xjNiAYeYr8U8YurgzALJFLrkplZ?=
 =?us-ascii?Q?+wCsOaIiuL+1uMNcWpdMqpYaZVqETZy135mptHweGxiYVYQvRcpLVZ5CqFpZ?=
 =?us-ascii?Q?5syoMc4IxcfC30AkZoYjxy8WCchMuUNDXqLHWBVQ/oyeA6D7RniluHdL8bEx?=
 =?us-ascii?Q?aDZ7JieyHsUmjEDwWniw19kD4SrzyCfwuaXPA3bvtyqa4HtskEVppYN7M0bt?=
 =?us-ascii?Q?4BbsJgKhwh/g7Vwjxx+th6tKJGUkw4SUiUhp+waXdJUKMcO2KRvexC3XPKd/?=
 =?us-ascii?Q?Lj7gfBt5/JxB1FXipKKg871d8yp/oP2m3XH2HZZQ?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5968caaf-4df2-4442-b4ea-08dac6ecf4bf
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB5925.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Nov 2022 09:37:05.0725
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ESk7JnRIAdu2DAUhTlVzYPHMLS7BU4RPLD5eUp8x6YLkkUs3b+MFG5px6fA+Fdcf
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB9462
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

The patchset supports sdma hdmi audio.
For the details, please check the patch commit log.

Joy Zou (2):
  dt-bindings: fsl-imx-sdma: Convert imx sdma to DT schema
  dmaengine: imx-sdma: support hdmi in sdma

 .../devicetree/bindings/dma/fsl,imx-sdma.yaml | 149 ++++++++++++++++++
 .../devicetree/bindings/dma/fsl-imx-sdma.txt  | 118 --------------
 drivers/dma/imx-sdma.c                        |  38 ++++-
 include/linux/dma/imx-dma.h                   |   1 +
 4 files changed, 180 insertions(+), 126 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/dma/fsl,imx-sdma.yaml
 delete mode 100644 Documentation/devicetree/bindings/dma/fsl-imx-sdma.txt

-- 
2.37.1

