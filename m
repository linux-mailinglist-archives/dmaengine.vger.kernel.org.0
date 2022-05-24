Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D4479532D4B
	for <lists+dmaengine@lfdr.de>; Tue, 24 May 2022 17:23:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238764AbiEXPW7 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 24 May 2022 11:22:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238591AbiEXPWq (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 24 May 2022 11:22:46 -0400
Received: from EUR02-HE1-obe.outbound.protection.outlook.com (mail-eopbgr10053.outbound.protection.outlook.com [40.107.1.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A754457144;
        Tue, 24 May 2022 08:22:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DV/3kd924r1c4dwPMu3PGdFdK8gVlw39AFpIPFzwRBxP5T/HlGZYsfGRxJlvgIffiuOWgCP+r8x0yGA5b6YYs7nFUFDRWc+ax/MnKMjaoND1CMSUV9t09a4mjFkyw01mcHbdwO1yGMHsKubIUnLRNx+Hwu198fj6NdfgrOtop9YdfMG7EZoWiDk8j9I1GBez6avB/HL1SGjY0ryCqeAycuzVKQ+Nn7JAHwuortDduUuTZQQILFcgFdeGSgUcLNZVwndXSF73wtS49nOVRwUysO/DSInyGRM3B6iUjS2Fy2ulQrnzjFLLqXxPksQysyxuH+6w3bEYV6CKxPDQA0cJDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KIw15xN0ke+D1IC1C3x+mYZkY8XzwzygeUkuob4gna0=;
 b=IVvPzEpD6gK21p+FOrMUa+TuMm4vQp9BIolrcPGmB68YIBRvvr5ndVsRH+0INfkWnw4mI6EEyPLOIov/miM5tO2195NlctY0eQONvnq7yxj6PYDXAwbTTjDuxCcpgads8dDol/5Pa99jhATvfPNJjMDzz2GtMWZzpAP0TN14O3ScsVmlNv3R9CgjKR+bD+nqZbIItBG75P53EDLgXJt23jJQjzsB57UH7qL09rghNA42WyWJZOO08FvDP3+0nKyD7vkmuufBwmE4sAwOBDQIjj1hjLIvtsJ+TfEibgKb6nhheEeNMnkoEW6Lw6SMyWY2auitoOriYI3Cn+Id0nHvmQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KIw15xN0ke+D1IC1C3x+mYZkY8XzwzygeUkuob4gna0=;
 b=rjYt0G8ZK4M97lK+ZfFa5DrPlhD3L0DxIBin5ThzdxyJiYupYciyM1dfZfXchXHa5a3Cq3SFWNrpgCMemaJMbc7QpMs0do25gkfkPC4tOVWerC+gheUijt4WMvG2uw9kUmU4UlJEGfBYLqcRcpwn+6IrvK9VWIIAVPLzjDLQJN8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9186.eurprd04.prod.outlook.com (2603:10a6:102:232::18)
 by PA4PR04MB7536.eurprd04.prod.outlook.com (2603:10a6:102:e1::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5273.22; Tue, 24 May
 2022 15:22:18 +0000
Received: from PAXPR04MB9186.eurprd04.prod.outlook.com
 ([fe80::e0bf:616e:3fa0:e4ea]) by PAXPR04MB9186.eurprd04.prod.outlook.com
 ([fe80::e0bf:616e:3fa0:e4ea%5]) with mapi id 15.20.5273.022; Tue, 24 May 2022
 15:22:17 +0000
From:   Frank Li <Frank.Li@nxp.com>
To:     gustavo.pimentel@synopsys.com, hongxing.zhu@nxp.com,
        l.stach@pengutronix.de, linux-imx@nxp.com,
        linux-pci@vger.kernel.org, dmaengine@vger.kernel.org,
        fancer.lancer@gmail.com, lznuaa@gmail.com, helgaas@kernel.org,
        kishon@ti.com
Cc:     vkoul@kernel.org, lorenzo.pieralisi@arm.com, robh@kernel.org,
        kw@linux.com, bhelgaas@google.com,
        manivannan.sadhasivam@linaro.org, Sergey.Semin@baikalelectronics.ru
Subject: [PATCH v12 0/8] Enable designware PCI EP EDMA locally
Date:   Tue, 24 May 2022 10:21:51 -0500
Message-Id: <20220524152159.2370739-1-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.35.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BYAPR01CA0004.prod.exchangelabs.com (2603:10b6:a02:80::17)
 To PAXPR04MB9186.eurprd04.prod.outlook.com (2603:10a6:102:232::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 18784098-f60d-43e4-f544-08da3d993054
X-MS-TrafficTypeDiagnostic: PA4PR04MB7536:EE_
X-Microsoft-Antispam-PRVS: <PA4PR04MB7536878EE2DB427B294BED9A88D79@PA4PR04MB7536.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: VdW8bpGV6fIe3CmIQEBvUdk+d5/+XtOLILCywQlpMWIFJblMRI5kcJMmCtWjJbBuf22Yq44OCjWWWTXkHI4kvpz9+QiJ9nKijcKq/MksTOssmGwX3EqoZOuauoFNl/tb/uOx/N9RWYe0sjBPg2gxWQd/pMR/EvOLyyugD2i0xg9WdaezyGLpBTEaxTT+VufjQFCyWYFS+kB9Jxdyag9tKtlE2V5+yx6NdNDHNgtT2Kv34SrQHI6F1y7Jh/qzHG1oMx3RZu0q6jmwGx2xAV5hH1qU1oj9hba/LkYcJOWapHtIZTbOYrnLutsOuF1ZnnVtnJuSoUEXBZB3tkRGyRprDRXww9d8P9CINSujhBw0NnNQjpzBd4deOMOyIWmj3fWSGSeuO1EGQVHNvS+fyjfWp2w44TcN2DrQ5xOxi1E46bwX7rQAwCyIa6/hiGoY4fUWJdCnbImsbd9iLljo26gRYianikUx8WY0a7y3B0T5PJs4m35CqOb2FDqqtsa7GHwN1U7kFfWkOjrJu0kbWVak+l1eseQMFkvJb5tdPrQ6xuL3ikVYa8ihu//Aah1DI2lyj4GJoHK2xq47h0b4JXJaHZa+n4jA9/2PkEM0bfPAOprS8u7VHxchD9oSISvNexLjdvplkCnlY3GPssTh7r5P0UTktGYEq8qQxQA8zYiStkXdRQIzVxMOoNswzQSDzuBcKfTZWXO6Zzsbm258FnwM+rsQoR/abZLGlxWzHDc/BGqgtK50fiLlIVYq8crkB3ObH60J7oAf8YlKNhq0JHtWunHCr29TRNoM35ESOKa87NNCGL4WPeQgBhv1I4QEsPT4
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9186.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(66556008)(2906002)(26005)(6512007)(1076003)(921005)(66476007)(508600001)(316002)(2616005)(966005)(186003)(66946007)(6506007)(7416002)(36756003)(8936002)(5660300002)(52116002)(6486002)(86362001)(38100700002)(4326008)(38350700002)(8676002)(6666004)(83380400001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Zf04GTwGMO/iCfY04p3vMiSh6go76sqdtQuRAHstlTWySRBheOHcZDJqGnlR?=
 =?us-ascii?Q?mIsCY7AQVE9WLCjUlo8iMPx53ZtJKl7GUZ1P0RTbKpkOF80kVpI34T7w2JSS?=
 =?us-ascii?Q?el9IoUPa4CJ6PkUpF7Z6BU19XMtMmxPUS0TjJn8D3eKXYR67b0zYfsUm+P2N?=
 =?us-ascii?Q?X91vsk6ruEWGADV2CqhX3775mMY8dQPFThXMiVuUoNRYLosQ0TYjmtM1Q3j+?=
 =?us-ascii?Q?lMljwL1Mz0jhBIJYLtsWv+uD5DTwDWM47Mu5qWcD7xxVKVhvss5utcvRKqrv?=
 =?us-ascii?Q?8D1jZXQEBGRuHLruvqc1GFJwDiq14PTt11zIPXxVKpnT9hycL+rcRII7nyhc?=
 =?us-ascii?Q?+ACi89CRoar00Sxak0JzpSJjuk7Axh9CMyWF+xNkZ/X1HaQreHo/6CiHu9RS?=
 =?us-ascii?Q?QprL37y1hy6sNPgX+EvRWtUKSyJsQCT/kS0jPMmJQDd87pv4t56TNujDToLj?=
 =?us-ascii?Q?+eE5UMiIsNLAVAmiW+of5FI4zL/dlVCLeViAxb1T339BP5n+nRq4nFAJ+IqR?=
 =?us-ascii?Q?fkLsaNGekaJSTceloSvj1qoWnHCjmZNhlb/ZjY5PgebCRlCXrzGp5WrdzW8g?=
 =?us-ascii?Q?vZyPTaEfF62Zd4oU8MsoiyvLlyHhN42BEW5a1SdbxX2UNtA9XW/XwUKDGbYG?=
 =?us-ascii?Q?TSzAO5+kss8iYgqskeiMJsw2zMZ23OAuVSUQcxhfTGFZGjMcy6Dj1j7bYLMB?=
 =?us-ascii?Q?v1hzYPFEti7xuuPBaKH2m3/nMsend36bo91LSOnkoSADkstjaoYfrMSjhtsh?=
 =?us-ascii?Q?WRCk0cQoIKmxsl6He5WPagRkyUmDqIzX0TsWlFeip92aaR15LoeEu3FkQJNp?=
 =?us-ascii?Q?T9oAe9RAU9eBZ11EzKADAaNEWrkNiWWkKqo5pRWcfvaF499uO7DATSzn/YuL?=
 =?us-ascii?Q?WKItsneqWHzPZ9Dp+ovm36SIl3dcfN9P7ewamBGQe3fn0aIuhzHNf9uHSiLs?=
 =?us-ascii?Q?GaIy1YkQHGBLSdwP+fK40lECgkvUNvpeF66evuoRF+bxrJo2zquxIzWbj6WH?=
 =?us-ascii?Q?+V8a+ZEg6N38SEWeDNhG6nJO82nefn/EbMlbxWdY19TujJchhGQD9SYHRE6b?=
 =?us-ascii?Q?LfPBB+DIdvwLOF7lPurSC1OOYZG46N+SlRaYKcG6HliWipq9OOec2R4KRKBm?=
 =?us-ascii?Q?afUmqOEuBrEV8cgJl8MGTJaLbsr1yIq6Bqe/CCrDsOP8rbv6zRw1RjoPJbVd?=
 =?us-ascii?Q?FQL6G50kHhRXh/iHlLzs2Vy83ktfxKPp47Ga9X6kXwVdBanJuUuFGE1iNqKy?=
 =?us-ascii?Q?vtO/pXqVtXrLWYrJQ0rEXsI+wtHxhjVkmKrBc0K38UZ3QuzHfC8CHrluI7Jx?=
 =?us-ascii?Q?VZiCZsrE35UhP1keRJjEgfZFQkB/tcf4k65vernEo1RYtO9SSzQ0ObbQj+VA?=
 =?us-ascii?Q?FlZq+z6Xy4kOeHQ6nwSx1/XuCt414KUzJuWV9Tq4pW6AtaEDAKYJpOGq/s4J?=
 =?us-ascii?Q?1IJcrSiCYsuTMroooqUGkUDXBujIBUcSIdOMtL25M/huOvH6fuTqCZUYaDjb?=
 =?us-ascii?Q?TbpCiCoElHuGPVWny/cKsDAK+OG+bw63/j1t8kaISc6QsByTJVfnn+72+D36?=
 =?us-ascii?Q?d5du9/DBVAl5odfyag1XpNSA89lhHoFNQ5ht16a014CIaifpucp3dU290WQt?=
 =?us-ascii?Q?x7ahgjBLsjgEEucF5t5P8+ghdRIaxJx5CbG0rgU+EnkHCpmvLeiQfjW1l/ai?=
 =?us-ascii?Q?66oAWa7n9lkz8i0W78uhPaAunkw/E6mKKo7vtJhSnOMbIukfCco6EQ2bK7EJ?=
 =?us-ascii?Q?mJuK5Mi/XQ=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 18784098-f60d-43e4-f544-08da3d993054
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9186.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 May 2022 15:22:17.8385
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KPuKImPnK2/yxKxCCnDW0j7lzJmE0rgjAKUx+gzQa9ABLNOyXSrecNwHnejK4yDLF89CInlbZrY6GfHNJiDkFg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB7536
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
   dmaengine: dw-edma: Add DW_EDMA_CHIP_32BIT_DBI for chip specific
flags (this patch removed at v11 because dma tree already have fixed
patch)

3. Bugs fix at EDMA driver when probe eDMA at EP side
   dmaengine: dw-edma: Fix programming the source & dest addresses for
ep
   dmaengine: dw-edma: Don't rely on the deprecated "direction" member

4. change pci-epf-test to use EDMA driver to transfer data.
   PCI: endpoint: Add embedded DMA controller test

5. Using imx8dxl to do test, but some EP functions still have not
upstream yet. So below patch show how probe eDMA driver at EP
controller driver.
https://lore.kernel.org/linux-pci/20220309120149.GB134091@thinkpad/T/#m979eb506c73ab3cfca2e7a43635ecdaec18d8097

Frank Li (6):
  dmaengine: dw-edma: Remove unused field irq in struct dw_edma_chip
  dmaengine: dw-edma: Detach the private data and chip info structures
  dmaengine: dw-edma: Change rg_region to reg_base in struct
    dw_edma_chip
  dmaengine: dw-edma: Rename wr(rd)_ch_cnt to ll_wr(rd)_cnt in struct
    dw_edma_chip
  dmaengine: dw-edma: Add support for chip specific flags
  PCI: endpoint: Enable DMA tests for endpoints with DMA capabilities

Serge Semin (2):
  dmaengine: dw-edma: Drop dma_slave_config.direction field usage
  dmaengine: dw-edma: Fix eDMA Rd/Wr-channels and DMA-direction
    semantics

 drivers/dma/dw-edma/dw-edma-core.c            | 141 +++++++++++-------
 drivers/dma/dw-edma/dw-edma-core.h            |  31 +---
 drivers/dma/dw-edma/dw-edma-pcie.c            |  83 +++++------
 drivers/dma/dw-edma/dw-edma-v0-core.c         |  41 ++---
 drivers/dma/dw-edma/dw-edma-v0-core.h         |   4 +-
 drivers/dma/dw-edma/dw-edma-v0-debugfs.c      |  18 +--
 drivers/dma/dw-edma/dw-edma-v0-debugfs.h      |   8 +-
 drivers/pci/endpoint/functions/pci-epf-test.c | 112 ++++++++++++--
 include/linux/dma/edma.h                      |  59 +++++++-
 9 files changed, 317 insertions(+), 180 deletions(-)

-- 
2.35.1

