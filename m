Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9AB83501F2F
	for <lists+dmaengine@lfdr.de>; Fri, 15 Apr 2022 01:38:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245240AbiDNXkA (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 14 Apr 2022 19:40:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234563AbiDNXj7 (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 14 Apr 2022 19:39:59 -0400
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-eopbgr60084.outbound.protection.outlook.com [40.107.6.84])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8339EBB912;
        Thu, 14 Apr 2022 16:37:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HC+kMrWO20lWVos+Z3J+Ed72cnuYi96FYewu/d0R7seD+mHKUn6LlVI+f0UO9LuzsmNRtW/pVx2JhG5tTqM+rPKr5qYfdbFaS/JJQBZuEn3iLAxkmEecP+8+jG+IxzKLjBtEDzuSyfXSkizl3YAJrD7mu852F2SOkDx8LVlt3AEmdy4wTujcJUV6gFovMlGmgF4owj8iLflKGJlxrmEGnyEtb3EfASEBnfXsccAABugYUL0IMP3qQnQy7wCawvK8ZjPQfRSk+kWu6aUnQSEw4jSPuZv5ZMBHZ79YQu5wSNEn7GDv6ZENki/QLUeRgrNNfzvJGKFIkBkiNYWFT4anag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9H/7xYM/rKpdCsna6cwr9fmXA8doZRq71tAbpP5CJKU=;
 b=HB2z7A5uIZi0T3QQDIJeHMmvxs5NsK4JCqTfdjVfOJPNxz82xqWFgpz8BmMDYpSRGKBLTZxoHgp1A/EB7Tew3IstvNJwkQlsugwtodmoCN03t8wwQ3lB18TNdaOPbTPz536/E+jZK1z8q78JxWTVUSMEsgAUHQo3991hdLCv0iVs145L1HpC8ftFrrmJRaHK9ov3vNa6IE1k7TVl4yBrXmBYRvE9Zguo8gPS5Gjo24fIkBervoSNfrJUyJCgISqHj7ZnxszBqw1+1zDKujq1YiwKN7CaYDFiicSJfDuQi/X9Z2u2BcjjENk3lOPttbnNp4tqRWr55WtoGUV3C2p+UQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9H/7xYM/rKpdCsna6cwr9fmXA8doZRq71tAbpP5CJKU=;
 b=sa+5wQbrRnU3OwxnpFeFjWaftDezRB8Qkg9S9vaOnci5j8h4Ggw5NpzDEsye+sdGttEF10fSaDHgOEs99C/cLFwNYHGqmmXG2TdPrcAR9qEVWe7Jtim+PRhPmnggXBrS0E74ZDuXU5QtWd+Lkuj/WukM9j9QmJa+r9RgKkj3jSg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9186.eurprd04.prod.outlook.com (2603:10a6:102:232::18)
 by DBBPR04MB6043.eurprd04.prod.outlook.com (2603:10a6:10:c5::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5164.20; Thu, 14 Apr
 2022 23:37:30 +0000
Received: from PAXPR04MB9186.eurprd04.prod.outlook.com
 ([fe80::e13c:6fb1:ca92:d11b]) by PAXPR04MB9186.eurprd04.prod.outlook.com
 ([fe80::e13c:6fb1:ca92:d11b%9]) with mapi id 15.20.5164.020; Thu, 14 Apr 2022
 23:37:30 +0000
From:   Frank Li <Frank.Li@nxp.com>
To:     gustavo.pimentel@synopsys.com, hongxing.zhu@nxp.com,
        l.stach@pengutronix.de, linux-imx@nxp.com,
        linux-pci@vger.kernel.org, dmaengine@vger.kernel.org,
        fancer.lancer@gmail.com, lznuaa@gmail.com, helgaas@kernel.org
Cc:     vkoul@kernel.org, lorenzo.pieralisi@arm.com, robh@kernel.org,
        kw@linux.com, bhelgaas@google.com,
        manivannan.sadhasivam@linaro.org, Sergey.Semin@baikalelectronics.ru
Subject: [PATCH v7 0/9] Enable designware PCI EP EDMA locally
Date:   Thu, 14 Apr 2022 18:37:00 -0500
Message-Id: <20220414233709.412275-1-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.35.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BYAPR06CA0045.namprd06.prod.outlook.com
 (2603:10b6:a03:14b::22) To PAXPR04MB9186.eurprd04.prod.outlook.com
 (2603:10a6:102:232::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2b059209-8d03-4803-6894-08da1e6fbdbb
X-MS-TrafficTypeDiagnostic: DBBPR04MB6043:EE_
X-Microsoft-Antispam-PRVS: <DBBPR04MB60435428F9BB7569EE82AF7488EF9@DBBPR04MB6043.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /gTIx4sxNxoWOBrhEKk0UwyqRhmp8fUHgsXvbvyRCT83RA7FiuWOWFebUht+VNGvzRDgsOJdMKMixBsDQFb7Ho2n4vxm0zLeJ0THp9bhpk2i4G+x0UHHgBXLFuSLCN87cmIbkPJCYDc6NSaB5MEDjkCB6DX5yUluS6i3C4IOS7TAKW0WOnDEAYhEgwNHFC4q2Uf4fqGKO/A66TFMbPJhKQThxkitcjPr6xRM/VRcDomkNJhNx2isCqMrWFUiF9n5zamG7yiCKDBvvjwj7Jxi19d6LYChTbFYvAcwLrzG4bhPXktEq/ZdL0xG9ILElZGVRilrX8ZM9aqUXJuz0Xo7hmw3n5aQ8XKlcOoRuOofnq4uKyWWsxw1JvPEBbDpfUT1bS57w6iZIdS1PQLQY5sXnkB1E1GVG1uMf0T7otMB7sPb+6in3JAQdhkWbipIQN6piYlhgVLy57OR2mTfgW43yhx7+EwNxXK2kK8bseB8NSWpK4GkagXZ+nXtiikjE9Q+eXxXBDLXtZxjsxsYsZC0IUkoyiTMafxPbDmTh5bvMA5cLBlP7nD5tIL+BnJVS6dSMxkpVOFHRSnjtV5UNqtfgQcGA1xzumFdrKV4CtMqhs1XfUsnc/t4nKL1PAz5sZZHk4KuN2jwJP7X5gPNdZecV6345Z6JPp5RLb+LraU1dg1elCTtK+Vi83eGC7vbCkTDXV/U7+8JkB0fW3mZtt2c2Hvnwy8ZILAG/EyN/NScztpYx2QRY8NK32raUj9mSgUDjNLW/Zrij4fd7yU7713PIyiIO5NzKZjzeYF6WGWwnnc=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9186.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(5660300002)(6506007)(8936002)(38350700002)(83380400001)(36756003)(38100700002)(966005)(508600001)(6486002)(2906002)(6512007)(6666004)(4326008)(8676002)(186003)(316002)(86362001)(7416002)(1076003)(52116002)(66556008)(26005)(66476007)(66946007)(2616005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?68qvwjU6fpU6wU9Iwu93VODFsWSyE5VkTMkUYs4aPC3JZJWUUgqO2mUjDbJs?=
 =?us-ascii?Q?h04vuJF6cK2EPYED0BVn72ajbuMtILL99OaqL0puJLvJBwp6Qwkx5lLFQAEJ?=
 =?us-ascii?Q?wZWeOtgNqP0H1zMmyeEhZW22YVIV9ZHO3aYe+n0Lvm3juOUj8Yt4p60VrRaC?=
 =?us-ascii?Q?zd20Tg0UYKAq2cuRyUAzXuQE8cazyKcUeDrycxv08Se9jKQsdSjqAte7tmms?=
 =?us-ascii?Q?7O0lY+wIM0p2fyv9Yky2lLk0PtSV/FpT/mw7A1Lw5sha4pidLfcBjkVA9yPk?=
 =?us-ascii?Q?ApxKfMOg5tTrHGDcWw3xtaa/DS2YcfjEn+yxGIFU42gCumDIHISVljOl3QeD?=
 =?us-ascii?Q?aZw/PG7aSDg4WQObTpDQjUUnLESb7PkvhtNdf9Y5U7AO+OnzjYJObmbwboyj?=
 =?us-ascii?Q?ScT4blgR+W9tQ7tvEgnqkX77x7KYioZXRmDrZoRM8fPtbv3+9/3q3Hu7ovu7?=
 =?us-ascii?Q?JeRRzT8MeVUS1RbDGpxFBEOVy5C1/V5KpTCTCfm9l5M5eZPUs08MecFWRl6N?=
 =?us-ascii?Q?W87pt1bepPLO9QNHav/Qt7ODL3xBAw20Y7D9C8Cf29PVd1wK7sCG6K5Oux6q?=
 =?us-ascii?Q?b2PGSYO1vcF4j+QI0VtSd9bIhVOiCZImRB3YYzfCctZ0bjf7gL2D8z/XGRRi?=
 =?us-ascii?Q?GBFecYTkUWvweYbnimwgVOz9it2ry3cBvbBE9uSCj+FwmU3eJWH3SZ/VfY9m?=
 =?us-ascii?Q?X6IDuYbkqf9etKuwRYSP/Ssf97DlnTADXBc+brNnbWZT+bpudFT1mkID3eS9?=
 =?us-ascii?Q?JiTzR7cHgHJgjZ8T8Kk/Kv+ITIe/tGdnChyHTIGtkp2WtoA8XUTOp8cWimiR?=
 =?us-ascii?Q?pOHrmogWRZaSqeISP3GEc4zxZjvwfaH1wOMytb63p517itli2RtgvIoOVVQ4?=
 =?us-ascii?Q?7DqvL+J9jvp4IL8N1CrUaEK8GZECLf5iS1o5noyMVhtRwAtzAgM24wVlKPVv?=
 =?us-ascii?Q?+WhzLMST1J5sHFaYQwzJl4nPE8BMnzik8Fxvjz4veIMnwDx9A3lDLi59ZLEq?=
 =?us-ascii?Q?0bourT64rnPMtW+/m9VztWE1D+IX/UTmmzFP84mASwUJFcMzpfrn1Aw+QSab?=
 =?us-ascii?Q?OzID0pRuHb5dnUrv4zKo/9b2ocyQdZCBQp3Dm47KsvJGvQk0VAYmRawtc8Mx?=
 =?us-ascii?Q?1m027vBcjajnI+g/F0bDYZNwiSXv6YIXZ2AtAb1LVX3VuJ0xrzAeXUh77MIk?=
 =?us-ascii?Q?keKGPHRzySEdXl4ZZLCEqZbJEuczoS3AO5LP/39lVsEnncFM72ui0j0l+scN?=
 =?us-ascii?Q?umn2147I6vXXS8rkXfvYV/cDSctlM4nNy/U7Toty1zsy3pX2lj4/1a/uoCTp?=
 =?us-ascii?Q?Z+M1a8GmxfSJ3yshtiweTjgRc4JxhfLw96PIHb1L9R4srnr4jVDHf8WLl0hj?=
 =?us-ascii?Q?wZALN72oqktYwNSASkHVjxEbFdoB1TUjxQbLJgJs55On6PuJyZZOMgFha4N6?=
 =?us-ascii?Q?rioombKecKuR0zXKUjjFjFzYx8PjuyaJNXL+B4oVLPamg6ZrTaVA45eegfka?=
 =?us-ascii?Q?+ar1cyyf4xwHBrawMuWal+Xq0shCKbVw5m+r6DabQRTXnfJsH41S79rNH6fs?=
 =?us-ascii?Q?YwsGQ65m4lHo5Y9e0vF7je8dneBNCBOmarwzhf79GydgfE5kFp03WjZo8sBt?=
 =?us-ascii?Q?vXvkFxYEMWDv6T0a+k6iZ9BXIOIvBZYTlk6WVqNmwEa0JUapkodwCDrWVvUc?=
 =?us-ascii?Q?iVBeUlgzVh8JFueQl6a4p5JQYzP2zXLIN4hBft/vomzQUlEBFKeo0UkIhIv5?=
 =?us-ascii?Q?bCpCQd1TKQ=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2b059209-8d03-4803-6894-08da1e6fbdbb
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9186.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Apr 2022 23:37:30.1443
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nfCirToj3nOB38R5TxSMtByZ6EztQeTZd6DRraAs2M9arev59R31+BvzFGJAMOMoHAWszWBIXCbBCLI2vI+jNw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB6043
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Default Designware EDMA just probe remotely at host side.
This patch allow EDMA driver can probe at EP side.

1. Clean up patch
   dmaengine: dw-edma: Detach the private data and chip info structures
   dmaengine: dw-edma: Remove unused field irq in struct dw_edma_chip
   dmaengine: dw-edma: Change rg_region to reg_base in struct
   dmaengine: dw-edma: rename wr(rd)_ch_cnt to ll_wr(rd)_cnt in struct

2. Enhance EDMA driver to allow prode eDMA at EP side
   dmaengine: dw-edma: Add support for chip specific flags
   dmaengine: dw-edma: Add DW_EDMA_CHIP_32BIT_DBI for chip specific flags

3. Bugs fix at EDMA driver when probe eDMA at EP side
   dmaengine: dw-edma: Fix programming the source & dest addresses for ep
   dmaengine: dw-edma: Don't rely on the deprecated "direction" member

4. change pci-epf-test to use EDMA driver to transfer data.
   PCI: endpoint: Add embedded DMA controller test

5. Using imx8dxl to do test, but some EP functions still have not
upstream yet. So below patch show how probe eDMA driver at EP
controller driver.
https://lore.kernel.org/linux-pci/20220309120149.GB134091@thinkpad/T/#m979eb506c73ab3cfca2e7a43635ecdaec18d8097

Frank Li (7):
  dmaengine: dw-edma: Remove unused field irq in struct dw_edma_chip
  dmaengine: dw-edma: Detach the private data and chip info structures
  dmaengine: dw-edma: Change rg_region to reg_base in struct
    dw_edma_chip
  dmaengine: dw-edma: Rename wr(rd)_ch_cnt to ll_wr(rd)_cnt in struct
    dw_edma_chip
  dmaengine: dw-edma: Add support for chip specific flags
  dmaengine: dw-edma: Add DW_EDMA_CHIP_32BIT_DBI for chip specific flags
  PCI: endpoint: Add embedded DMA controller test

Serge Semin (2):
  dmaengine: dw-edma: Drop dma_slave_config.direction field usage
  dmaengine: dw-edma: Fix eDMA Rd/Wr-channels and DMA-direction
    semantics

 drivers/dma/dw-edma/dw-edma-core.c            | 139 +++++++++++-------
 drivers/dma/dw-edma/dw-edma-core.h            |  31 +---
 drivers/dma/dw-edma/dw-edma-pcie.c            |  83 +++++------
 drivers/dma/dw-edma/dw-edma-v0-core.c         |  54 ++++---
 drivers/dma/dw-edma/dw-edma-v0-core.h         |   4 +-
 drivers/dma/dw-edma/dw-edma-v0-debugfs.c      |  10 +-
 drivers/pci/endpoint/functions/pci-epf-test.c | 108 ++++++++++++--
 include/linux/dma/edma.h                      |  59 +++++++-
 8 files changed, 312 insertions(+), 176 deletions(-)

-- 
2.35.1

