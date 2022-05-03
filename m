Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2102A517B5F
	for <lists+dmaengine@lfdr.de>; Tue,  3 May 2022 03:09:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229564AbiECBKP (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 2 May 2022 21:10:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229506AbiECBKM (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 2 May 2022 21:10:12 -0400
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-eopbgr60088.outbound.protection.outlook.com [40.107.6.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7197A4DF4F;
        Mon,  2 May 2022 18:06:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XxUBILcrifmos+8DI49KPl3QLhcmupiVyPSRk+xOC4HC2ADVTmkMMri4rF1RNWp3moj+u0VYH+gtCkcBXWlOb8cIiEA+3UdSb1CLyoOm+QxvSf5dQZVu/zdMsH4Tc+TKjTBFsw/oITRyfTk5mbY5IopHRvh1fNrjqZhajRjkmcGNq71XNexhodeSXJFgGImjtxC+tKA3OZFUuAMalC8hZDuNDd+Rw2Dg3VTahQucvQAVzskkD1QGtHgf9MZGS35bYW/TLBkuQCAUbPuAAj8RSeYfr/GqdfX135cgmPDv0x7mP+71eeCI8kgZ/W4GXJsIAI7NmSo7tuH6KLgYsKmDug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BfRQg/MgFzk63hvHAPu5+FP7P9qu3rldByaup1Qp8as=;
 b=FdIBmI2817EiN9i/APDJQwfOtxH0oPD7O4feysPYBM8/UOurYNIf0MQGo6EwVBMbIPBHU4wrq7GGcMBvhP+13doiTDotvMmfz1zVwi/WXXMT5PcZWKugtmUGZgqXrB4wvV277aYDw7PwcrprXdtKInGsxwbpL6VUPOgIrQdRmZe5C3SHS0+r6AM3pG/8OVrocRaKkHPaKy45J/qYxsK7rv/cxz925u4fmFGXcqKbmwKingY4l0DQ+hBY6fxHSU3en+6Ft04NsOq2PD4bxXporS9D3LnSZ4i8eEX1TQ6x2v8dwl6HpV8xODlvWxG6mnbfVU8Gmhnln/s6WDmNAWIKxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BfRQg/MgFzk63hvHAPu5+FP7P9qu3rldByaup1Qp8as=;
 b=XD5Y19WbiS9xgH9JIXSyn3hAnj5znxWrYZCWRV7/6XZl8ss7cOZH5RSCttJz6bpQP25TYSINXaEpnjbWVCKubwvEF9MveTfMFinLyPAuJX6ay9lxrshsocjLdC+5bxgz/5Fq/MP5cK45qP9jUZ6pARiBR5USmm7exMhd7gIKEHw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9186.eurprd04.prod.outlook.com (2603:10a6:102:232::18)
 by AM8PR04MB7364.eurprd04.prod.outlook.com (2603:10a6:20b:1db::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5206.24; Tue, 3 May
 2022 00:58:20 +0000
Received: from PAXPR04MB9186.eurprd04.prod.outlook.com
 ([fe80::adc5:45f8:fa40:1b8a]) by PAXPR04MB9186.eurprd04.prod.outlook.com
 ([fe80::adc5:45f8:fa40:1b8a%7]) with mapi id 15.20.5186.021; Tue, 3 May 2022
 00:58:20 +0000
From:   Frank Li <Frank.Li@nxp.com>
To:     gustavo.pimentel@synopsys.com, hongxing.zhu@nxp.com,
        l.stach@pengutronix.de, linux-imx@nxp.com,
        linux-pci@vger.kernel.org, dmaengine@vger.kernel.org,
        fancer.lancer@gmail.com, lznuaa@gmail.com, helgaas@kernel.org
Cc:     vkoul@kernel.org, lorenzo.pieralisi@arm.com, robh@kernel.org,
        kw@linux.com, bhelgaas@google.com,
        manivannan.sadhasivam@linaro.org, Sergey.Semin@baikalelectronics.ru
Subject: [PATCH v10 0/9] Enable designware PCI EP EDMA locally
Date:   Mon,  2 May 2022 19:57:52 -0500
Message-Id: <20220503005801.1714345-1-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.35.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0P220CA0024.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:a03:41b::32) To PAXPR04MB9186.eurprd04.prod.outlook.com
 (2603:10a6:102:232::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8a5bcc09-4aca-44ab-f83a-08da2ca0043f
X-MS-TrafficTypeDiagnostic: AM8PR04MB7364:EE_
X-Microsoft-Antispam-PRVS: <AM8PR04MB73640D0BFAEB8B009399E7DA88C09@AM8PR04MB7364.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: McyUICQMMBS/ox8y76d0YkIMxM16r5K0fQtgWjYBodF/5HUkLT9wOmzTf7FeQucfsb4sxMrJuK1ae1llNIuvr5g1ZbQX5QjYbb5SX4qzc5k7HOaCWkBsMwB2/PLsEPwDfYunzxt0gs8e3ajZGPal6EqJEX0BzAKtlP5biUCtCE3UfwqSH/ZnK+M8HOFt3AvgKH7hqKNV01pGdjERnhQZ4ekx7fcphK5KPz5ggTdADjpK875b1sHnG5Xq5HZGXcDHwh2GbP3qwes4sbkU3Cr1iXEvPUWhA99zQCo1nMp+HeCNful2V65sKsNo4SYoKY7hUa36+f7py7Frf5mGuJyAhK/kssAHzbFJnrE7pAG85BBiYfK8ow0du+6DJimiC+ubGOjOX8nXgvT5LqsmXNqqtUHBrtTz8OikJwmvaU9kBsdP/Ojkf8fMheEhmlkiYW52tenHf+Xlw1R48VSOjNN/EeJDTdEmwc2u65NRhETlUN0GipAuwYObvDbKruYc3cnssD5PuVJrwdufSpDh+Pyava6NS6NrvKRq4bD77TOg+BWF7FELIo35PaSJ4GUrBgR7IN9yvtQGlufz3c4rLxm0GzTTWtHwFUYECG1zJpLkpVtljE/QQuCykW3aUC4GYcDCBkz3K9Bijxm3WTOTcK4gSzcQWGOWcTK0Eh1dyl+cLZboN/PVjZ3kBJGFXz1s4t5/ASHUoJY6zlyIOVzUMcs9FR8iko1N8jCHZ21kI4fjMyVxeSevhm7TxlTxRVU3RuY0/DNPcYDJho3nHkcga1mfMRsCg9c0l+DadbEGR4Y2F4s=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9186.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(8676002)(66556008)(66946007)(4326008)(2906002)(36756003)(66476007)(6512007)(6666004)(316002)(6506007)(26005)(83380400001)(1076003)(86362001)(186003)(966005)(38100700002)(7416002)(8936002)(38350700002)(508600001)(5660300002)(2616005)(52116002)(6486002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?k7xqpO/UPrDdfGIdwH+LwChbgPRsVbjZCYEqQuwerX5AXEJZBvWBmBoqSpxc?=
 =?us-ascii?Q?W4ScYO47YCJRosW9t/JkBhAWd5SiqH5JTn5F7PVcnKo799ZfcZ6sSZ3J17Jf?=
 =?us-ascii?Q?hAfyJ6y5/8I8RI1noK5jFD4RtV3wGruSADg9DNkvIqOT0EP5vwGxbYc6a/Z1?=
 =?us-ascii?Q?jadybR+wYWhq9lbPvy/DQI8B6RseS/aEaOL+Tkt1pi1JfOvRzDnrTqlQ8mki?=
 =?us-ascii?Q?q7uMHGUjr+AgRHdQFqawQ8m+x4YinL/azZtbHalQnHR3vxO0m7eqBG6MfQwP?=
 =?us-ascii?Q?MZcAPghB4wophzIcQiNbtxliX3Cf7chR0oKrjSCV/alqQAUocmu3hIvoVsez?=
 =?us-ascii?Q?n+FXgKQmkPy2KMn6h3+eb4/jj1IYWozF/YQPlXaFZQ1XkTqNwcgrHeYyWxnz?=
 =?us-ascii?Q?Un23muNYp1h+eQ3lNfaUEOunWKeBzaPyJmR7mDuGfo3x5NpUEpn7mMHmYUdn?=
 =?us-ascii?Q?S1ZM+Vz2Zr5kJNUwwZYqkxmUmmcYxchlvzUeQ+eafSEHwX5oiW9/qUVOfbMW?=
 =?us-ascii?Q?eAMEc8mtTghXQFYK535iNXCjZsrwiLoAe0impV6Z7+FrPN9dZgIShBA7Fj0d?=
 =?us-ascii?Q?1uITZmoA8/KG/+6SaR2GWInbW/mpfglfNxhZ26uppxzsGp4aVtn0L7dsthzS?=
 =?us-ascii?Q?bA3QN0sz6JZXZyDAnAN5drawNkSTf0joZBqXTuserXnWi7FMNKuLTsO+aiTf?=
 =?us-ascii?Q?sIMl4C8H1VJu8SY1yd4BcIxxBQm6zK6GluB2pqsL/Uq6PQWm+FdQSic1FKJl?=
 =?us-ascii?Q?8WXZHViuESXb+p+klzADSI8BqX701neVufS5z1Nuvaxt0skadBH8bDA0Tpnb?=
 =?us-ascii?Q?6hHXmF4Nx2CdAaY6m9qV4IFzfTbYhHpjZvqVx5S4MDL5oFiJMZax50TjoEsD?=
 =?us-ascii?Q?/EcXI6DlTN9c+n6bmpoU0s1BTf5UVA7mwUEUaBlAqdaRp3DUO1Xqxe/rizDZ?=
 =?us-ascii?Q?0ilvL2mrDob8MPUuzsN+6ZYW18FyFJBVgevLsCioyaPuHSjxDcMSPJBVPxaB?=
 =?us-ascii?Q?zmNZHIM6ZgKwf5t7mUiIDtNAX38OARkJfhAscNyUnPn0YzNJYSiF1vqkXQRy?=
 =?us-ascii?Q?wvRih53S+J5jrC3Y2rgKttLWEiraU08xOq/H75wHegv9PhiMaWmrK7PRYobA?=
 =?us-ascii?Q?1v62XAwCFHYSx1KX8G96uWJHKQgkXqKO5SGr3OFePb29B+/Oo5++5BMk4GwX?=
 =?us-ascii?Q?lJvZAIZKya3uTdmZbMJetnXuXL6EcaVVVl5vgVfDlJEUOn77gQ8V3DcP/o3C?=
 =?us-ascii?Q?xq+2epPS4eTKM4U8kfhNm8HwNPjb6UN3X+BDWqEmKY3mt5+JOElf6qUcDnQJ?=
 =?us-ascii?Q?9BVMoxpeDWZeN7rdSI7WKfQssvlFCNYfGHuTKFEwfkD+pmMYq1hMiW4p6r/D?=
 =?us-ascii?Q?mX4bl85aR1dyPOPWk7DDytsaCgt4PHn2hQFnme3h7iC4hAOJH/4JkvJB+c/Z?=
 =?us-ascii?Q?DS0E9TBA8VkZZkZLCJWqJ9+SjtXKG0ftFF6VOnnLqS7WIUYPogD8AmFbYC2y?=
 =?us-ascii?Q?fJwm6OwOi4v2vFZqHnDU8+54isixLJAVsx2cpj8BUlNhycyz5MaZHyWtyA7S?=
 =?us-ascii?Q?FEQdGG6T3nUgcwQ50pnILcmQMEHhtU85JLnZ3WA4dKyQPJHjmww2EfKDy+sR?=
 =?us-ascii?Q?bVpEZq+v1LahH2MtDd8pTnwozCjOheHvgkg+8NQLxWuAjrXt9V2oaiodHmXK?=
 =?us-ascii?Q?9aNlTAD+A5Y0r0JCUx0EP1GrS6xQWv/SZe3GJOogzgPbxJGPKIWc4XeZ+DtU?=
 =?us-ascii?Q?sdhnJhA0DA=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8a5bcc09-4aca-44ab-f83a-08da2ca0043f
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9186.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 May 2022 00:58:20.6692
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: S2RS9u//JfZrUK0Lk+UY1cqconbbukplTbiKMRYOal94MoTChGJ2RHQyZme5WbHaTBacwjKo6xSHrDUNnb+zcA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB7364
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
  PCI: endpoint: Enable DMA controller tests for endpoints with DMA
    capabilities

Serge Semin (2):
  dmaengine: dw-edma: Drop dma_slave_config.direction field usage
  dmaengine: dw-edma: Fix eDMA Rd/Wr-channels and DMA-direction
    semantics

 drivers/dma/dw-edma/dw-edma-core.c            | 141 +++++++++++-------
 drivers/dma/dw-edma/dw-edma-core.h            |  31 +---
 drivers/dma/dw-edma/dw-edma-pcie.c            |  83 +++++------
 drivers/dma/dw-edma/dw-edma-v0-core.c         |  54 ++++---
 drivers/dma/dw-edma/dw-edma-v0-core.h         |   4 +-
 drivers/dma/dw-edma/dw-edma-v0-debugfs.c      |  18 +--
 drivers/dma/dw-edma/dw-edma-v0-debugfs.h      |   8 +-
 drivers/pci/endpoint/functions/pci-epf-test.c | 108 ++++++++++++--
 include/linux/dma/edma.h                      |  61 +++++++-
 9 files changed, 323 insertions(+), 185 deletions(-)

-- 
2.35.1

