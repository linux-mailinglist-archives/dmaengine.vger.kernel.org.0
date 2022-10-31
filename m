Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BDB7A6133E6
	for <lists+dmaengine@lfdr.de>; Mon, 31 Oct 2022 11:49:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230020AbiJaKtM (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 31 Oct 2022 06:49:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230177AbiJaKtK (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 31 Oct 2022 06:49:10 -0400
Received: from EUR02-DB5-obe.outbound.protection.outlook.com (mail-db5eur02on2086.outbound.protection.outlook.com [40.107.249.86])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2797F25D0;
        Mon, 31 Oct 2022 03:49:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GZJcB48uNCCQkshlI4pcy7/GK1+pl1ybZuXPf/tbFycgv5lZTgGsEbMxZ2mS8pz6vYAQGZqlGLHlJqtdwBfN0NLi56rXpANudeC7+LpU0mFlQyix0VElSf6hNuG9V9DRvtpX7KO2vC97F4sosRV5HwcZfQWhTrUWHARKpRrd+7yjdM+tSM0z/gdXPSk/S9iIYtf9pcH8uimFvAArmA5y7QFlAppoS1BbbXtLdnvbHU5tWhXS4ShPWqLrfeScoW1uANyL/E9ULXFw9FiCBdC5V1CvjKqux66padqp2+a5dRcOH4tjp5hHd3knzYFMIeZfy8eQTemW6/jgZCnf/VatbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3VrjJy/viKtUTs/dRGwMV1X0W0tQdVKWwAITPA4U3ZA=;
 b=Yajxg3+htdauLOA2QRb6xzxXgF1TvnHWmE/FaOG9Xzsp/B3lLF1NT1XSDrxlanQvauJlUPkcTJ0TQ62yFIUJRUX2IrlkUyky0TcN0VUaxL82Se5cyfKlFZb0C3FK5a+j4W8uQTE5KoE4Wux1RvAgPlZ0eJNSr1kqn83hQ9G1dnciAVKJHTZBt2k2xZCCN4Y5qUeI3m1Z135ejaqr/zRyP2/5bijEcENRmXitru3VB2bMQ0QV+qkbRTQ2f3pGlkq6biC/SL+4UXanX/vncXsPRywbAuiBrf4f2S30+ShJd+hrb8E/za/ZIk0qjm5BdI/hB4xkttRQ4D9rRETKOcdV6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3VrjJy/viKtUTs/dRGwMV1X0W0tQdVKWwAITPA4U3ZA=;
 b=CnDMV+/f1gxf/lZ0zARfB0M8Lw39O/VqZ5rtjWSwZ4gp6flthXmrJu78wnQTbMJMN9gTWl2keBYCrvYgNtTB7NRNZHPHrdmfmotAx/ojOnZ35GCsgZBzMIVw0D9i963p5HDGP0NKkcBoirxlslijdLUDUiu9TNF5tintRAAcUTE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB5925.eurprd04.prod.outlook.com (2603:10a6:20b:ab::19)
 by AM9PR04MB8793.eurprd04.prod.outlook.com (2603:10a6:20b:408::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5769.16; Mon, 31 Oct
 2022 10:49:05 +0000
Received: from AM6PR04MB5925.eurprd04.prod.outlook.com
 ([fe80::7a34:469:fd53:922c]) by AM6PR04MB5925.eurprd04.prod.outlook.com
 ([fe80::7a34:469:fd53:922c%7]) with mapi id 15.20.5769.019; Mon, 31 Oct 2022
 10:49:05 +0000
From:   Joy Zou <joy.zou@nxp.com>
To:     vkoul@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, shawnguo@kernel.org,
        s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com
Cc:     shengjiu.wang@nxp.com, martink@posteo.de, dev@lynxeye.de,
        alexander.stein@ew.tq-group.com, peng.fan@nxp.com, david@ixit.cz,
        aford173@gmail.com, hongxing.zhu@nxp.com, linux-imx@nxp.com,
        dmaengine@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v9 0/2] dmaengine: sdma support hdmi audio
Date:   Mon, 31 Oct 2022 18:50:26 +0800
Message-Id: <20221031105028.598502-1-joy.zou@nxp.com>
X-Mailer: git-send-email 2.37.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR06CA0006.apcprd06.prod.outlook.com
 (2603:1096:4:186::19) To AM6PR04MB5925.eurprd04.prod.outlook.com
 (2603:10a6:20b:ab::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6PR04MB5925:EE_|AM9PR04MB8793:EE_
X-MS-Office365-Filtering-Correlation-Id: 9465336e-ebfe-46e8-c21b-08dabb2d87c9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: G1pH3Lapx/M98Q6NKRTqyCNMIwPIO/l7FRRM8YWM1M3Nd6o9dXtQZmVjQxUC1et6FZSasXfvXnqZTvmdU8OqgNFfLnfHwWvA18hlmzZGHytxnhKZvWk8LuJG0yKiegG4/wDh/1KDp2tnZ9QlBpZl9bX4GYo5oQt7rIC08Cnb5DStVWDxuKoNIYGG7h0FKMhv9xzbn5CczUygYkmwedS1xQvLYPxuRfa/+Bkc5zyh9GRordb8N6Ft9NsDbissLfozmy50oLYKeeA6fesfwcT90c8wPbWR6BOehPmDP3JO8LPaEwT++RzXF5jJrgzfR3gGjFzsKdaYr3bi/OU6HLR3OSM+neLxtlMmpGxenoRrOlhFFI8cf6c1nJosWTnrF1/YeLl2HYoQ+58VSqQjSA3nEFWagd7jMzyYmWPmARW1lHzFH8V21h3bwDv+3NoWPY4PucV6fEssZ52aobrTaOnxpN/XqjGb80zS1ULD2NwTaYHJWU+J61vc/qMWMZFOIsSNgE90rYKKOUkGFPyWSvgMFy1f5TqL3TUyuEqOU+Td9+CUbMOTrkEi58SiCEncpDH92xcIyuXYj/ypYygoeem24r/PtM/U6bZ2E343pPfmvE1GMZJZX8wgl1/YA3JVHFsCZaWxBQ/4RZhhzODHWT30kqncXYylp7rxLaCAervm+mlf414T+NGd1FbgVHa9/A37ZxJSNjKDsvuYbqj/3fNqC/VDA+meS0NKc+O0rnLcUH1aM000wJAZTcxwbthGQvu512Kfv4OSBRvspwK4aJEY1w==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB5925.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(346002)(396003)(366004)(39860400002)(376002)(136003)(451199015)(38100700002)(44832011)(38350700002)(36756003)(86362001)(4744005)(2906002)(6486002)(6666004)(8676002)(478600001)(41300700001)(316002)(4326008)(66946007)(66476007)(8936002)(7416002)(5660300002)(66556008)(186003)(2616005)(1076003)(6506007)(52116002)(6512007)(26005)(83380400001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?tIHs3h35n0tawFwWazd0QCJStCBdv8UZcwt5LdMTi1N3Jb/jlQIaTNOLuFoE?=
 =?us-ascii?Q?CkmpwACbtwgbS6PvemclaZ6hqcu7IzoVfIo+s62GOwO6aIguvUEWCtP2Fgb3?=
 =?us-ascii?Q?2eY+BBvRtWt+5IyN8aW4bnOlCCVIqfphoMpiyZPB5PCJuy0f0jqs+RUqiFpg?=
 =?us-ascii?Q?fxFwz3sFNf4V7HytmgkTriZyu1YG1fvQ0PdJ/FpblZNv1rJzzWGWCqgg4NyR?=
 =?us-ascii?Q?lkwPDMsgeNq/vbl0Tc/FKU60T+vXbzozMB4o+z/WQw1GeeqcjBV2+tf+cm0z?=
 =?us-ascii?Q?WkIjv20iji8Z6hebrp8NOQhKAMTH0noul6o4P1kPesF9vo8drEchmnoKGMjq?=
 =?us-ascii?Q?nMSWb3eckuNpM1K42cFpNsPDPF4pA4pkqQkFHlaUCjAsjNt4tKN6D1xIlRjT?=
 =?us-ascii?Q?G4YSzO94WWLyE3CWOnPk6PSt8EYz7/gc4MdMWagscyU6ULnAo0pgAJzgUsro?=
 =?us-ascii?Q?xFgYfhQ9z6IUwWMzihAtbAXqu0keqxA8RLM7cPsDLSi07X2bGO7NGkHgw8R4?=
 =?us-ascii?Q?d3X9OLoMzYcUV2/yxHlYpUHcWok+B4JGj5YEchWEdtwTmhCla0PuLhuoqV5z?=
 =?us-ascii?Q?duCpygnRvK2xF0l9mcGJubMe3FYeATjZgxRZFwcm/5hQlboOXgbRHyGgMmXi?=
 =?us-ascii?Q?1V7XgRo5oNoxsPj0teS2laUtNwk9brZDZRs+ALX01zSVsGiPK4dFzuSoAewo?=
 =?us-ascii?Q?2Qzs9QRkv7YRexyq+2YQbVjQF95IiVV4fCAnat5zrhiUHMYIie8yl8/dW8zT?=
 =?us-ascii?Q?JKYal+EYe3kxkwl5jClb6Ec9W+LO8KhF9WuKp7S26232F7doIXPs7fY00uZS?=
 =?us-ascii?Q?bRbKRYnEdzT4fYZC3t/eFbpS8fWkYljdByff6jnDx6r/JlvHYUz1xIofwyk1?=
 =?us-ascii?Q?4s/JnYnf4uEZNRSAJzuRvvoeivIURAuILVIgP0iOi0hrOY+Yw0bt+f0q+ar7?=
 =?us-ascii?Q?hTxdUQYuwVbCanMXa1ZMWoB2fx/28bbjQYdlxdGxKj3AI9LEJLzO169mtzyX?=
 =?us-ascii?Q?zHiWQUnCptXcDeNBSKjZgAM5f5QqUPtEckNhe8vNz8KBRm5MScBeak7uLzvP?=
 =?us-ascii?Q?9HO211z1JU11eFhl95AT8VXFmStE8S3YVwDbNTGPMhGz2zWpWumM0bJidDFG?=
 =?us-ascii?Q?xHQ1R1XANSyD1kU3Lzx6LCqYT5kXvTD5qEoIbS6UxlcgTw1aMVWq3Q5yM/Qw?=
 =?us-ascii?Q?BOC7KaU+34BB93L6Hwiwx4dB+4dnyGuP7w255RrNnK225Z36oEBgobP8Pp/r?=
 =?us-ascii?Q?ts5LXMcEol9smWTwgHL4JHofwSDl2p7jorSWa1NDtUa2KPqvzR47sNJ31dhw?=
 =?us-ascii?Q?bQ0JHBtkQOpOL7RD6HiB7DqgtF+uvyL2RHDYWgw/ZIiP/pZwFODxZpsTlkcH?=
 =?us-ascii?Q?x33lRucacs4J+uH19phvKy/SFoRQnlX1KMmrLEmiA/A29elSMcaoiVj13w1w?=
 =?us-ascii?Q?vNg1WL2o8Y2cAT+GiGvV1P7o4GF96C7HjS20cu+8Wz/gzbhF+zt00nZQW/sv?=
 =?us-ascii?Q?dqubsCJtyMhBpeYv2zADL9Rdu4TWr8q69AkPcxaTsmSSKCiLglSK0KbAbZgl?=
 =?us-ascii?Q?E8Yg2+onN8sP7FlAdBJjNUhJmrAv/yxQWlU8UyWm?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9465336e-ebfe-46e8-c21b-08dabb2d87c9
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB5925.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Oct 2022 10:49:05.6009
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Sm9cuVBaiFEKQYYg3z7+jDuDp2Ubf9oS5lF+0sgWgPyhvBRQ73gUMRURwaBnysWJ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8793
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

