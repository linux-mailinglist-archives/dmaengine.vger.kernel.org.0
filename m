Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9218560C689
	for <lists+dmaengine@lfdr.de>; Tue, 25 Oct 2022 10:35:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232299AbiJYIe6 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 25 Oct 2022 04:34:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231888AbiJYIez (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 25 Oct 2022 04:34:55 -0400
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2054.outbound.protection.outlook.com [40.107.20.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7349EA8CEF;
        Tue, 25 Oct 2022 01:34:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GAVZ1DcRiRT94B0X7pfJzi2xUrdcZlx619CP9BaJ45AJwYp9cf2uhACAumbXb+ZKVOXexEn+q169ZxsfdvHkQOBLmKVbBgRmvyT3YN5yQc33+cSXlqMno7uIib6Sg4cDTUlLRN1UpbOCg9OwtV1Wh4+Ch8w9Hqdy+3Z22acreYnoHhW8UKHCF9jBe6zbKCAWprcZLVO7zXrBa7k2A6lrMn7gAenNI8FLolQHntPmgm4mPA3S0inoyifNxT06SUk2+VmXLNCXdg/JSdAs1m/t5UGrFevWPFEKEKu+/2LNu5proJ+Ox9FiqppiPqmGc8xgFIy9GLkAYI1rSzmGwbLumA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3VrjJy/viKtUTs/dRGwMV1X0W0tQdVKWwAITPA4U3ZA=;
 b=jwdoWFWHtvJ9cCOL/OEBvHMzmqCGDkzk0cgtCySxYgvIRUIsEY2XES9qDfLTqieKnmZCstc5HgIO9ayVn+80OvUeX2olPTH2YM5ZSdUzDr0Y56/LDheFj0Yzl6Q4ZCv+hVwIF7P9qLAeN1hPaByVxJpXQAFsTsne87qJTgtenPK6/90dAhjDBy+8CsnW+kqKKsAkyXLORoWxwvunTVfE74yVqd1xcifhoF9JtPQm+8m0TLUqNc2YLk469+yXdOiXRhdRpu+dtiz/mWXgNyW6CMc1Tr9v7PMUWM62FD20LTXFWGzTPxzVJ/p8/3nAjnicekQzmN8c2jmLPjV24hLW9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3VrjJy/viKtUTs/dRGwMV1X0W0tQdVKWwAITPA4U3ZA=;
 b=PIaWtuOq4FRfntViChhgV6Cg1zHruxNPeOTMDWaDY6OUR9n9flpBpKWOo2SLMRoNE79TpeCpTnQewA9htFwffr7OKVjhqQacHeqDQYKH6QvHof5R/QcSeflVVWoDWL9XbMxxoZA/tTqbua2DHTonfF5MR7lu0k51qKDvoEjoiOU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB5925.eurprd04.prod.outlook.com (2603:10a6:20b:ab::19)
 by AS8PR04MB8053.eurprd04.prod.outlook.com (2603:10a6:20b:2ad::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5746.21; Tue, 25 Oct
 2022 08:34:52 +0000
Received: from AM6PR04MB5925.eurprd04.prod.outlook.com
 ([fe80::7a34:469:fd53:922c]) by AM6PR04MB5925.eurprd04.prod.outlook.com
 ([fe80::7a34:469:fd53:922c%7]) with mapi id 15.20.5746.021; Tue, 25 Oct 2022
 08:34:52 +0000
From:   Joy Zou <joy.zou@nxp.com>
To:     vkoul@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, shawnguo@kernel.org,
        s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com
Cc:     shengjiu.wang@nxp.com, martink@posteo.de, dev@lynxeye.de,
        alexander.stein@ew.tq-group.com, peng.fan@nxp.com, david@ixit.cz,
        aford173@gmail.com, hongxing.zhu@nxp.com, linux-imx@nxp.com,
        dmaengine@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v8 0/2] dmaengine: sdma support hdmi audio
Date:   Tue, 25 Oct 2022 16:36:07 +0800
Message-Id: <20221025083609.2129260-1-joy.zou@nxp.com>
X-Mailer: git-send-email 2.37.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR02CA0061.apcprd02.prod.outlook.com
 (2603:1096:4:54::25) To AM6PR04MB5925.eurprd04.prod.outlook.com
 (2603:10a6:20b:ab::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6PR04MB5925:EE_|AS8PR04MB8053:EE_
X-MS-Office365-Filtering-Correlation-Id: 9fd8c991-2ad6-47b1-298d-08dab663c910
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: nX6iVzVEYkspTsYUzE5vpAenu/MjOyN+BhaVhWfjbMUSLHbUbz/0xFohIa/02JipRdyXt+WlUHPVT/pwlPHmb/lq3AT80DKiuz9IDU+rxlLXNiCrPGegq1dUnRWCYG2ueEKAGLlg4Os/cKshB1EB0WVKI8b7ZcTkyMSL5DUIH4k11V/5cuz0yzOkhwpClxK84O70gfvIK0JznulIAtAOPRBqshjsEz8LpL+djJNQgYHIoS8S7sHwzpGF+hsd3a3DwXXrSTIHxXYhBdQ7mjSnspJsqoweHAWfqkT+zsRRCazChaTu6GJbo3c21oZ7XFirK1qFcXnByHyX3E85Mj3t0W77RTGW4l5ds6xsMVABPCI04PUlo8faYLH8fnB5Ez1XBG3XyBa9S/udrX1wxCMcGaGr9+q4UUVuKlqjc0Y3QfbuC9Xw7VNXc0GI3sppBEWGO2Ul3613KTlhlAP8kKhuaq3yu1hUyM388Ff9HIT2h63kOmyZsrVfXJ96cEP7vUvLP510eGNNo11btpVuSSWhnZXk6DK++UvFgICD0/sNiDfx4tI4DcwKGYp3Wsu+KcojeZ/6VPHa6HFBUpOQ2cdfz8YLCZoXgCzJKqWHH3w252M1VddrAy/Jw1qYmexbW867ArAc+zLE4blK2HjgCag+oSZq8Zn0AXzhpGnWPyCs6vPKW8H3Mgei8t8ShEksiyQvl0KxQ8WVWqHtbhQIJ7a011fczrg9Mn/Gu8toaGFhX807RfEbNQjaSEf2DkLNm5mX
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB5925.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(376002)(136003)(366004)(346002)(39860400002)(396003)(451199015)(6506007)(2906002)(316002)(52116002)(36756003)(1076003)(8936002)(5660300002)(6666004)(6512007)(41300700001)(66946007)(186003)(7416002)(66476007)(66556008)(2616005)(4326008)(44832011)(8676002)(4744005)(38350700002)(38100700002)(86362001)(26005)(83380400001)(478600001)(6486002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?zPFJ6xcbiHLm4LK3Tw9XJgFE1GmiSMvBeIfvsl4WuvaLdxmvXTt8bKUljwVk?=
 =?us-ascii?Q?7NeH4Y/rf+0r2iXqiHY2tKGgwY8uJbymeCrQL4PMZZJNKKrp72kD0XwcMRjQ?=
 =?us-ascii?Q?V0bvyDUADdWpQ7ZfrlnFW3HtkyQDYRpMfpzovM3Ur8vrNn3/C7AzRH8fwXu0?=
 =?us-ascii?Q?+czBHAW2KOJJzsAEbLk86WsLyUHMV0nzAncggmXvbz322LANpOqZEFNPFstl?=
 =?us-ascii?Q?4F35MEF3xZLRnoBU69wuX6vTvUypQq6R1eKW38pQU5RDAqS2YaAIs9Ccd9EW?=
 =?us-ascii?Q?l8nPqge+p070yBZmt2zbOPWuWCDBccQSbLLiLaMEUNOGtemT/2j9LcsTvKvz?=
 =?us-ascii?Q?9+9LRlHQNqllTFU4ffT/8CDRjEQzGACRJUarNPAKRTRa7FOZiEvcLRmfdWmf?=
 =?us-ascii?Q?Wt16YUgZpnF0wCVYZC79N3Ta2AYj+g0EvZHxrv9iByZQ0BVmgVrXm0FqLr+y?=
 =?us-ascii?Q?fZ2pcBjs5xdhlIVYE/avWxvNN3RoytQQ7Gt3nnT8uK3bia+s52zoKmavW1nk?=
 =?us-ascii?Q?jZLHuWAy+3YxJ1HNli/VMxxrJwMxKUsQOuk83i81LQ/GvioDBughgXFnWFh3?=
 =?us-ascii?Q?hrWdjLvM2cVoegRxsVdqmIDClKnlLZeRkpO4UJ2uXkJoE5990h+j2R+LWvrp?=
 =?us-ascii?Q?7iGsQ8zNmlS5Wp8E0MFvdKX8nuJ4Ms7p3q7KG5fZTi+npKVW+kZVcdSxZTUc?=
 =?us-ascii?Q?ljqMCFIZpD37mvK4hIorB++Al1R4NLyFLcTWKvWhbBLsPJ0Qf/IVEUtgngze?=
 =?us-ascii?Q?1LCf2zmYw4atgl06DdW1P71dy7uDa2aP8BcBXf07jHZDU7BRbyucuXc3ymvl?=
 =?us-ascii?Q?XZ62PqWdlMCGJ1L2AQCRJiBkfAeU3jpYzl5CsBarMygTYR8Aw+FaDUpmClkO?=
 =?us-ascii?Q?c1HBvfNdTgduiOiDRdrekESoHJR6PV9XHW+582x8U7JcvD6aJzJOwRczZC6W?=
 =?us-ascii?Q?0Lr5WkU+MQrMjJtXmtnTwgnUDjPH/OzwwjW4VfiErgLcltl2Z3Rkl4JA0mbX?=
 =?us-ascii?Q?fadtVgVt1fUaQk1+VAE3GXO7Etb5sutkbx3cIbsPS1YBl8FtvZd+TdCd0ndz?=
 =?us-ascii?Q?oe3bMGsro7aNNQ6TEBxjXLr641bNr7V/86wY9QNkmqEmIhGlfygcDd8KwkND?=
 =?us-ascii?Q?t5HGmrlM9b9do71SYh9+jSjlb/AiQVoZvZ6WyXbFKn2ucwGT6tuTq6Y00/EB?=
 =?us-ascii?Q?S+KGcBFkc8MKqiKIagYwKHfmjghkMlB2i0+JQlLfvBYt0hthiVhusuQNxrWE?=
 =?us-ascii?Q?L8uVvJpn3LjsLTKVe7hYNl3SghuNcjftzaH2axvcEp27E5sn+nK8g9RFX69d?=
 =?us-ascii?Q?RCgj2tRICK+7MQH4iwA4zuPmBVy7RlJ6h/yTwJ/moD4UBV3x/JhapAwrBXDq?=
 =?us-ascii?Q?vNbAyY9ZljsMjIKVqPrBuqqwyjtDEVWmd2qsaNpM86X8jspgn3dbaj/+7NXa?=
 =?us-ascii?Q?OTCgu9qohSBUAv6TjawIY4xn7LR6eoHS+HoH5Jt9tiTA4Wz1WrSpPprbuIwe?=
 =?us-ascii?Q?C7BZAVJzJ6a9wGcdnoBusyAH7eegdCj3OgaKmG80lGJCPDjF2Lw8IVbAqPvk?=
 =?us-ascii?Q?2gqIe27+dsR/d9uGMvWicDSC4QOGIiKQShvzG/sY?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9fd8c991-2ad6-47b1-298d-08dab663c910
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB5925.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Oct 2022 08:34:52.0924
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 03udGjYEsUboF2JxOY/cSMQzCbHCoGMB0mceDyPFLkDw3nVNzM6Oqdx8qYG2j3lv
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8053
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham
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

