Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 492E95AE4A9
	for <lists+dmaengine@lfdr.de>; Tue,  6 Sep 2022 11:48:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238340AbiIFJsI (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 6 Sep 2022 05:48:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232318AbiIFJsH (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 6 Sep 2022 05:48:07 -0400
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2063.outbound.protection.outlook.com [40.107.104.63])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C0A576773;
        Tue,  6 Sep 2022 02:48:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=U4Pq6UjQvwoCI55bqbEv2JaTG3schU8Q/l73RvEH/0zs1LLpZiiWcrJUajZzU+O8+5A1Mu5TFOc+iEUKqoloSV5RuSlu4NtgrjsP/1QVvzYIlVEJHptqxjmEIl0Ffo063OQaEEUhlyNfk/XW+5l5ZqjDyYHy2r6xfb+FWR/UBjWyqrKYZiDGpPbv1gs989Owmhdll70m/k2Zy4XUTjpBhBfI7LYkqdgQtQm5XROzs1aEd8Xf6DLNM3wJIkSb90RbtmMF9/12z7ncMnwppI24zO9Qwx7IArdEfiW5GR9XJ4HObBUoECb/XCcJVr4PC6wS/LOdBb6C2PylhYBSYEY/TQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9TQ/F0MAL9Sz6RR2p+qmhk8j3MyqJNfdja+lpjjZArc=;
 b=bZNQ2nA/AwpuYS3uqv9k21vmpLpzaCiFv50P349SXtFJ4tMyVeGDg/zUqw3koDrxLab7owfodt0qnQSMcJBCGZs3JqCqWgjBJjY+HxHwjRiSRK8VCZ9oQce9H+WQMWaeJvrypjEqX18/c6VSXWIdX5KzpBG+yHrVa1yRuTR0wxUbkZHQG/92xiVMPIwW7sUgXyHazLTEkoM6c4f9TpWL4TzxpPLN+KDNCggcLhMLRmznJYJOWT2SQojmhh9QFrSPjS/I30hdeMfkHZzKnX2yZmiNAHOd8WaXUnMjdpEGDlmbwFp6JdXHehKnbrEhyaegpC564jZxxkm2vtktIl1QWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9TQ/F0MAL9Sz6RR2p+qmhk8j3MyqJNfdja+lpjjZArc=;
 b=YV/MybqcIOyJi73peInqJtAzLISxE/JJBCfsKJjkOu0/Eeg10t06DQQFlAD1VT5AFTlufjgzzw61OFGMGCcHw50N0waVi4DlggLC6tFM8fA9emqqTGXezmoSRveVOFpKIzDXt+D9mXOi/n1y6Y+hxXYozzYcHIxdbOQA2jWkdbk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB5925.eurprd04.prod.outlook.com (2603:10a6:20b:ab::19)
 by PR3PR04MB7305.eurprd04.prod.outlook.com (2603:10a6:102:83::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.12; Tue, 6 Sep
 2022 09:48:03 +0000
Received: from AM6PR04MB5925.eurprd04.prod.outlook.com
 ([fe80::704a:fa82:a28e:d198]) by AM6PR04MB5925.eurprd04.prod.outlook.com
 ([fe80::704a:fa82:a28e:d198%6]) with mapi id 15.20.5588.017; Tue, 6 Sep 2022
 09:48:03 +0000
From:   Joy Zou <joy.zou@nxp.com>
To:     vkoul@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, shawnguo@kernel.org,
        s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com
Cc:     shengjiu.wang@nxp.com, martink@posteo.de, dev@lynxeye.de,
        alexander.stein@ew.tq-group.com, peng.fan@nxp.com, david@ixit.cz,
        aford173@gmail.com, hongxing.zhu@nxp.com, linux-imx@nxp.com,
        dmaengine@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v6 0/4] dmaengine: sdma support hdmi audio
Date:   Tue,  6 Sep 2022 17:42:52 +0800
Message-Id: <20220906094256.3787384-1-joy.zou@nxp.com>
X-Mailer: git-send-email 2.37.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR03CA0128.apcprd03.prod.outlook.com
 (2603:1096:4:91::32) To AM6PR04MB5925.eurprd04.prod.outlook.com
 (2603:10a6:20b:ab::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0938e15c-cefe-4780-f879-08da8fece41a
X-MS-TrafficTypeDiagnostic: PR3PR04MB7305:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: cBU9ncKKvwzStCGjIt+2SBlvnmzo71zoUTbcc9uxY1KCpoK9sFDckVJ+TH/55So36o/jDdRW0pg2YysKOL5xbhxp9rCDZ00zoTiCBAxWmDKPMONcRqF5QlgW99gfPObT3cZlK37yTEGa/adf47lqrSLDu945EtD0+k6Tpg9dszMHvyAIdcaO3eEJHX7chCNqYLZH5dqaCyv0IMygnrmJbyrKHnzUuQDkGK4ZNZQX5KqDZyfr3SHbPG0wdunjYZYvzvb1p7x5y5vWMHB6at/RBWP/p+peJhvQ1sPuMRDEnecZM0KZiWSAS3B7NmPSR9wMW8FUeEEQN89MtVew4p/8o9qqPxVrtZqG7yUdWuEg2dOUShJOr3TDCVPEF+VXNKFaNDY8ogz2Tk9tabImwdb5++qTH09Et+HSDGiGPK9MDKOP5+xaaT6c8ASUFFIaHobYagkVhFSdWyBWdiTlT4asK7FG7JTYvHPGTPTbxRAQemMlArK5fzxAuK8TgvCsnLTDqsP2Afq0+MeAr+JFSrMTihLEpDBww6pkxooiO1j931nBSljJWE8Q4ApjzckDyZ/pitBpuMPlJCrIKcMm7j1/lZDVIek3bLiwpnFIp3rnFKhYs40MZiegYZjViwZpDIwBUYdqP/bLapcqHJWB8b0NDqSNaZsBYaxzDGSHHlvU1LyM04EvCffLB6Ns50KBjP+l3pi9qfoGQQiakbKzfzZaQNHZ//Qdoa9peAR+g0ECXtdmClno9nCCYrQxN5wUXYLb
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB5925.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(366004)(39860400002)(376002)(136003)(346002)(396003)(7416002)(8936002)(5660300002)(44832011)(2906002)(83380400001)(38350700002)(66476007)(36756003)(8676002)(38100700002)(66946007)(4326008)(66556008)(316002)(6666004)(86362001)(2616005)(6506007)(26005)(1076003)(186003)(41300700001)(6486002)(52116002)(478600001)(6512007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?BQrVeyIS8Y1m6ZwgAs2Xm4KnxPFXjX9XiGWb+CrWU053S0n0Qz1bEWq0HTwI?=
 =?us-ascii?Q?vJ7dp5cHKOjU9iKzNorx/fPJmM7h0Hj9Jza1xZIve/FTVzHJjyMtcy+6YdhE?=
 =?us-ascii?Q?5w5KGq8/fOt/dLWsvFDuYJhGAJe5fcTyDUQLaBgQxmyP29pwUQVY1xd+EdCD?=
 =?us-ascii?Q?FD19U/U/e6y/j1ZsHzWC0An4/kc1CLPd0mQiplX9IeAig3jv/1A/PTwJYTVI?=
 =?us-ascii?Q?Je9DOOqMhBk3DjYiAkzTngCxUQnKxSOi7V1IHEAlrbb2NPC8gQRqREI+zkka?=
 =?us-ascii?Q?Ulq4SlyHGxGeEgQacyAm+IQP9u8cn9AKlkmHHfaYCVtYTEC5aXVfDXa9xNoH?=
 =?us-ascii?Q?UfLI7a5idpYyiIZwyQYI8zqsAxCx7RptPzbhUw1852QjvqPshaCA97Tz3HY/?=
 =?us-ascii?Q?KwqXu7IK8bpAYZlFLc4b3MppkMQzeUjefnRl3bAe+vorJxQjo94LR73RbBjs?=
 =?us-ascii?Q?XejENAcQWE18kRla1exIZeHDrDCZj7sPM6W14ITw+y33zpQKqGUuBC25X2R0?=
 =?us-ascii?Q?luHnn9sUwIT0sDWXhwFjnpkZY6lsF8ZPxEmKHYWDPk1h1/ZeIVHZgzoWdJNN?=
 =?us-ascii?Q?ZX+y8Kgb9MFINAl+tVv6mcGGnYlhZcO9raBKZILAGTDvoJ5reGP+x36N0z6o?=
 =?us-ascii?Q?9xp5YOIkAWlwTWdLSv5JLh7qiRsje3lo/mFm7QkAUrgosbFkTtgD5TI31TXX?=
 =?us-ascii?Q?pgvqv7IUdiLGRoEDaPqgPtiTZSslHwcgwoLBhsOoO3HnnSlCpDbIufPUzDkR?=
 =?us-ascii?Q?TLZFSMxW1okJnokp4Iycwx/4/73cK69flk+N76Nyx2XqvJtv5m1czLE7qWWP?=
 =?us-ascii?Q?HKvLXThNjwPQZ2A14U2eYblZmpL7vovo1RFD6e38YaX2m0oEsrlEVNG94QTR?=
 =?us-ascii?Q?oeeG6Zi5bCy+MDdV+TUvR2+ajhQaQjb7f4iCvKHvvA01sLi/nUHgvWG9t+/J?=
 =?us-ascii?Q?mnhCaFI5/HU+QZZOR1oSnOEanbHmU8p4uUZUHsII86YFjMYaYUjLPoy6TI+t?=
 =?us-ascii?Q?COD3OHj+kQkXt0o7Ikz12sAq0WkWAJfxJX/I9bpUhZ+L2IZiQtMNs7t7dEzC?=
 =?us-ascii?Q?twgn7ylFUlQYBmFjmh0WoSSQYL1yksSx/U5anPf9X6R/ehXs8U2VJgof0w0I?=
 =?us-ascii?Q?g6kl2m07FXW87412ndICOdcCv6mgCil2af1OQcxzxQZ+7Kp4cUmgtroLo+Iz?=
 =?us-ascii?Q?n92vCZBSaDGdiVKggWwctLJG7Je/DHpOZNqk0JM1DL3qQS9rGjuNEnxBxrJh?=
 =?us-ascii?Q?Mqy0k2sBvxey46DU/jzT15k38GOFN2+FzdypUGqPeDTrlh+OR1yaMvJmeYCN?=
 =?us-ascii?Q?PSDO48atoF63p/uS5zkjVph2MttytfoKumPOXUQnVLi5WT2fm+ddIX/Q1d7l?=
 =?us-ascii?Q?u4J0759ufwSZ8lxtVQ/ROyRlWHQgApoZgqRypVapsSirFV1rVlGwBCWNwsEx?=
 =?us-ascii?Q?jBSAdMKrGID5U6mebDz9COBg49gCdfKiF9dYmc8oTEZLMO/oguPXlEfYustO?=
 =?us-ascii?Q?1/gilKPeGWP/wHz2P0w21un13jGnUdNJPyQ2n3jT4gM6B0d6MzlRwMZHVByb?=
 =?us-ascii?Q?bHuVqFvsxMbd47BBezSilUwcOFiaGM22gQmnW73A?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0938e15c-cefe-4780-f879-08da8fece41a
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB5925.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Sep 2022 09:48:03.0716
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xFuReed5EZqlFWf0ca3FVKndBRq0GmHmOGYWu82vjthxclnUkk+nmbjdXOvBdEk3
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR04MB7305
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

The patchset supports sdma hdmi audio.
For the details, please check the patch commit log.

Joy Zou (4):
  dt-bindings: fsl-imx-sdma: Convert imx sdma to DT schema
  dmaengine: imx-sdma: support hdmi audio
  ARM: dts: imx: update sdma node name format
  arm64: dts: imx8mq: update sdma node name format

 .../devicetree/bindings/dma/fsl,imx-sdma.yaml | 147 ++++++++++++++++++
 .../devicetree/bindings/dma/fsl-imx-sdma.txt  | 118 --------------
 arch/arm/boot/dts/imx25.dtsi                  |   2 +-
 arch/arm/boot/dts/imx31.dtsi                  |   2 +-
 arch/arm/boot/dts/imx35.dtsi                  |   2 +-
 arch/arm/boot/dts/imx50.dtsi                  |   2 +-
 arch/arm/boot/dts/imx51.dtsi                  |   2 +-
 arch/arm/boot/dts/imx53.dtsi                  |   2 +-
 arch/arm/boot/dts/imx6qdl.dtsi                |   2 +-
 arch/arm/boot/dts/imx6sl.dtsi                 |   2 +-
 arch/arm/boot/dts/imx6sx.dtsi                 |   2 +-
 arch/arm/boot/dts/imx6ul.dtsi                 |   2 +-
 arch/arm/boot/dts/imx7s.dtsi                  |   2 +-
 arch/arm64/boot/dts/freescale/imx8mq.dtsi     |   4 +-
 drivers/dma/imx-sdma.c                        |  38 ++++-
 include/linux/dma/imx-dma.h                   |   1 +
 16 files changed, 191 insertions(+), 139 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/dma/fsl,imx-sdma.yaml
 delete mode 100644 Documentation/devicetree/bindings/dma/fsl-imx-sdma.txt

-- 
2.37.1

