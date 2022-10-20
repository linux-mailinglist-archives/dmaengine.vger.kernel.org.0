Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 827F9605BEC
	for <lists+dmaengine@lfdr.de>; Thu, 20 Oct 2022 12:15:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229800AbiJTKPP (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 20 Oct 2022 06:15:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229556AbiJTKPO (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 20 Oct 2022 06:15:14 -0400
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2080.outbound.protection.outlook.com [40.107.104.80])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 551D21217C2;
        Thu, 20 Oct 2022 03:15:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ryy+J5TXm6htTJ/+Sxj4Y1K3luKlj7oLKcof3cV/MB6PDnkChZexc63LlUfQdUiaK60qZJ0e7ZXq/6AhEUFEqXhuuWrVSUa4kXM+6IJilhyH7oQGepebd8b+mSLnY3EvxLhRckaID16B6wqFmSGl4aTdQI+/q4NhStF2gWuv2TrjuLybNhD9RpDV91SzpI5TThJ2W6q+djPQczkKWA37HTg6XPvrVAcExuQPoGlkjL3pBGEBJh2ghrICxwQcGNjm4jNp5u60O/Dc062VFJjwrJ62Cih7gSuvUpR+U/Fa+dZc+DVVbYwIZl67cIphwk5BOu9u5uxdlz+uhuM/bqCSBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ArqouBfV6ceBP08tPwUvTP3atEGUrRLCWIQrt7IqA/g=;
 b=R1K8FhpdhSzHratWXFrmom1hZ9F4CvSb0BAI51RDKPVxgdmXC7F0bakX+Bk0O6K2GAI5+7QPZjkV96G8KeP+5jEpFTclqedC6Amf4iBn6pbasZOjiaftkp5IxMe5Gyl1nDINsEIyTc6nvyatYTIwU+ce15bUSjY9ocEd9DJe+Q7qxm4teSIiic59/vgZRKlEt++ktOycby7U6n8LaiNMk/4RINheU6WSQl4rGYtdZ+aXcHqZEAA+Ssa7KBP/Ow3J5tLNGfi8yqQExH37g4yUthCK67gQfKDzDlZ1UpJNrhNv15kkb3gI4ZtMLAym9Q+9qCXpVekFqa2iNenKKZ9b2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ArqouBfV6ceBP08tPwUvTP3atEGUrRLCWIQrt7IqA/g=;
 b=mD3isHvqBJ13QgkVRYZlKEeM7jAoBSc2SWZ6rtI3i1N6rm1HeQ2HvM/cZnKnAMvp7Y1wI4gu+dZrtoVfYcpC6nnuP2a3q9YM2U79OhS9doERGojMAIAwxr2IS0EKAgNAWotFCtNzF5ELeKiu3GmCh0XWYPSQvuBUgTboBEMmUYA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB5925.eurprd04.prod.outlook.com (2603:10a6:20b:ab::19)
 by AM7PR04MB7143.eurprd04.prod.outlook.com (2603:10a6:20b:112::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.26; Thu, 20 Oct
 2022 10:15:10 +0000
Received: from AM6PR04MB5925.eurprd04.prod.outlook.com
 ([fe80::7a34:469:fd53:922c]) by AM6PR04MB5925.eurprd04.prod.outlook.com
 ([fe80::7a34:469:fd53:922c%7]) with mapi id 15.20.5723.034; Thu, 20 Oct 2022
 10:15:09 +0000
From:   Joy Zou <joy.zou@nxp.com>
To:     vkoul@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, shawnguo@kernel.org,
        s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com
Cc:     shengjiu.wang@nxp.com, martink@posteo.de, dev@lynxeye.de,
        alexander.stein@ew.tq-group.com, peng.fan@nxp.com, david@ixit.cz,
        aford173@gmail.com, hongxing.zhu@nxp.com, linux-imx@nxp.com,
        dmaengine@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v7 0/2] dmaengine: sdma support hdmi audio
Date:   Thu, 20 Oct 2022 18:14:00 +0800
Message-Id: <20221020101402.1856818-1-joy.zou@nxp.com>
X-Mailer: git-send-email 2.37.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2P153CA0030.APCP153.PROD.OUTLOOK.COM
 (2603:1096:4:190::15) To AM6PR04MB5925.eurprd04.prod.outlook.com
 (2603:10a6:20b:ab::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6PR04MB5925:EE_|AM7PR04MB7143:EE_
X-MS-Office365-Filtering-Correlation-Id: 1348bb59-85da-443f-6b2d-08dab283f7e4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zBtA7rDNEtV1ZSFr6Fnhd7LK+bohBE+xRwidg/qxdECtVaNKJIQ9XcwYQQ0rYZzUHGTwRQKX8s4E3bL5ZJuVrAY+Ak9CBJmEqqnbSNPQj7VqsF0FO3xoMON/NlM8hKLsnb1v/QM5akzMVqthdV9V8wQHs4OzX346spVspv1LsDM6Lu7a/v9DcZ+x3mc320ddepZawn0SyXNiOF0WLcU+Wigq0s8i8epfEkIF8HUWaXvpHurDQtmpcwc1AWOfIMbTKxQsef3oEIfe1IufAMC1VFAERzU45MQH5wFTR5zD4Ofp9USyZd9nUnZ4iWJk+sJvnIZWfA4ANQ77ndPjkP/7W5O8d3vbOH/rl5pkYhxyYgsnJVP6sQvMFhyP8FwvE70DBKBkPzZmhPSRSinAe98KkxRwKXKJWkqo8sYA5sQT+MsCLKDHEUHPLTfPZ+mZtkCKv9liA3zJlRfmr8iqn0LUualXNLIXcnxFEO2wqvGrUtD9eoXXEqa7NRuTp8xCj5Qv/RTBoIIUap6kvaqv/CcLFuUh0MLkiZBXwCQ5nGDbP8waBBIC+AkXBsrUz1B1RWqAxUJCLzVN5iuYo0ZrRRiu9E6RaD6mX1rosdfRrH05rgun4BTEvt1EzlWuJSgHQhjlHwPrwfTQVf9n+DbliVBc62g58XzVzJv1w/axjRSTWMqDZkD6F8gdPTGxrT+vK6b7vrTW5Ik+LrfMlfKeGMVcqPOjuvCKbNzMPSNrU484Kgdy2awvZK0rD63VUyUl4uBQ2csgRoAQLz48EAFdLeKgLw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB5925.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(136003)(396003)(39860400002)(366004)(376002)(346002)(451199015)(186003)(2616005)(6666004)(52116002)(1076003)(6506007)(66556008)(316002)(26005)(83380400001)(44832011)(6512007)(4744005)(5660300002)(8676002)(478600001)(41300700001)(66476007)(4326008)(8936002)(2906002)(6486002)(66946007)(7416002)(86362001)(36756003)(38350700002)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?MF7/p6L5csO0DljMd+n65HdQIsnT0z07LjXGLAzqxsXmLh/oKrkuG9yEi3I0?=
 =?us-ascii?Q?T37Py4imfgDVkbkn4K8wjSpscU7GGLIHTCENpz3T4GjuFJSZIPUKADxFEiCi?=
 =?us-ascii?Q?BTMEYqLzXo9K8AoPHUTFPHReC1jbYO0f5tSQYQ0SCHxRSLFe/v8i3jzbKegr?=
 =?us-ascii?Q?/mMUBiTmvNhkUuyXCihVl8QUBCUaWbTGSHscFS7X1JMy0IiPg0iALWCumlKR?=
 =?us-ascii?Q?0zN/OlU8Y8cx+/ZP/Cvrv1lCQED+nTw6VxxH6jaDAFE/3k/JdUH0HHKYs9Bu?=
 =?us-ascii?Q?jwk+NMEYGF9BNh3yjPTH2SAVHl1i/dCDWFqFtbCSKYUbFhN8lZQ5r32ecjGM?=
 =?us-ascii?Q?Ln7CmdI+urGdrMES1QVEDRlfxKyeBkuYHSHQGDwhvU5z2w7xemA6nhNQPyBp?=
 =?us-ascii?Q?Fs+sUNEnWbn2tdOvPXKDjBt1feEAPPH7Ewc4MoLvO1LxyZVdYpXnuaDlZZ2W?=
 =?us-ascii?Q?v14c0idKqrjDdzzJGsVO8v0fXE4tPcO4/0VqC1OHpBLJSN0+DABVpJgwDzid?=
 =?us-ascii?Q?wDk8B4YU9BqR+p+G/Ti3JMQYFGPJKen9BM/0Iv6mjlhbIIblbgiF9E3lOhEU?=
 =?us-ascii?Q?Z1x7DR9vZRd0mRIkz0v177AZlPwMKdPqrZZkr15b/I0WKP6J9Q3wRrDYF9Bm?=
 =?us-ascii?Q?uz04ygccmtr7t6tqAsetG926sRRnGi9rgjdVhTre+eKikGqo7XnrR977pnKt?=
 =?us-ascii?Q?9f2ULFLyuc9XIqaG8nzRvrSVQm1o7meuLsvwadqzAIT2tTLSWMq7Vodg/9gE?=
 =?us-ascii?Q?efv8LSe5yRfgfJUJqvf3xCxVoobyeY8IeqEo3iVJUgYCgqVXYtBkNy72ed+4?=
 =?us-ascii?Q?9q5R1n9YT34Xi4HBgmyAgBTPcq/utZ4jBsSaReBkTMqrNxYsS1Isv5WfSGCx?=
 =?us-ascii?Q?x4e4zVV85Y/RNF5TNv6JsrqVbgqpA7OU8Nf1okcxNQ9Jtq/1KOQMnaBkwl6A?=
 =?us-ascii?Q?F5kbEjiUt0VtZ86aCSqdY6mcTzQQGhyf28T9+zrb2Prxm2PXj2osP1hXX54s?=
 =?us-ascii?Q?dvrTf6H20mH1MzcaAJrgxYIMJZ9YZ4TMplzFC1kdgrZFd0zzVmaKfHNntBSP?=
 =?us-ascii?Q?f420QohCQy6bSasRuqJlGqF5oeCxKeH87fpOvlTq8IgGB/+1573zdakPDeIQ?=
 =?us-ascii?Q?mDhIjItGpI7XCSJ401knb6a8usJttwi27X7FCuEKt9wkMvjc1AlSigMHVmdQ?=
 =?us-ascii?Q?4omDe3qLn79LnmpJkd2/O5Go54gFVqoVb8zrBmrQSGC5SauyPjV02LMrQoc8?=
 =?us-ascii?Q?U2dj0P0MvImoF3NIAbXey7ycnV67AdPUPOL4adC07MEKhsPepdY85lICac8r?=
 =?us-ascii?Q?fosTMdrk7qN5WaqK68OoAJ3yVP/KtN/LMMBuqSi11s5ZbgaqP7PhHK6CLgtk?=
 =?us-ascii?Q?G/NwR3gI1SC6kYB/uWOdLZSmB/mUhuwIxdHZnpkB4WhzUkzRlTl5ECOC6wIR?=
 =?us-ascii?Q?oPH3kWrVGsPAlriQR/Esl615XKcm43GLkMIbL79Wm6QNCutyTGfurY2dcKJ6?=
 =?us-ascii?Q?R07NJfcu9R3yLiZXWMJEYargyLzTjrLYa1sv7/9RK91ekj5ITBTuy27x9gFk?=
 =?us-ascii?Q?vWaii0uPWw89/Gd4B4Yk52Rrcg0Vkypcc0X4XKP0?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1348bb59-85da-443f-6b2d-08dab283f7e4
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB5925.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Oct 2022 10:15:09.8560
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AsrNLuBMyFkYmv6ne93Vpb3fvfAXiMVcjDZtSlm7QuM3BMH5+sL44UA01C/7hnzc
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR04MB7143
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
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

 .../devicetree/bindings/dma/fsl,imx-sdma.yaml | 147 ++++++++++++++++++
 .../devicetree/bindings/dma/fsl-imx-sdma.txt  | 118 --------------
 drivers/dma/imx-sdma.c                        |  38 ++++-
 include/linux/dma/imx-dma.h                   |   1 +
 4 files changed, 178 insertions(+), 126 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/dma/fsl,imx-sdma.yaml
 delete mode 100644 Documentation/devicetree/bindings/dma/fsl-imx-sdma.txt

-- 
2.37.1

