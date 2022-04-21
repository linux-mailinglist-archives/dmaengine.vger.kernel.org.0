Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 903DC50A2FB
	for <lists+dmaengine@lfdr.de>; Thu, 21 Apr 2022 16:45:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1389593AbiDUOrM (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 21 Apr 2022 10:47:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1389179AbiDUOrF (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 21 Apr 2022 10:47:05 -0400
Received: from EUR02-HE1-obe.outbound.protection.outlook.com (mail-eopbgr10048.outbound.protection.outlook.com [40.107.1.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDEC24092D;
        Thu, 21 Apr 2022 07:44:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ckqi2BU4+RWGOYDcm/kNFpqgwDeJo9Gq3MDITTb7/penJ5LByFUJqHKPEHFLRLpQvzGkBng9rEB8ZrbbiBLjLbtUgI0Gp7NNzTqhSo6gxLAKLKd5c2kA7yo1ebr58dUaTMKw8+LPwdc08tcXJdLREPdVs0xZFWEJoJRinKLL7V50zL3FItnMz/8gm0AnDSrgnoAF0czoIupivcNGuZV/A/3E+udl4Ng+kjWT9yqM8DXrtN37AE2vekQJOqlX4/qNlQZwYe85B6+SLyL1C1cX4wDiMoKp9yVlI8iP8xMhkwdOkdJi96ib5NP8l6z0PcgMXOvfRFUiVbeACAPjj6Jv3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9H/7xYM/rKpdCsna6cwr9fmXA8doZRq71tAbpP5CJKU=;
 b=JWRMa942RAMIyJBH6JtMwUBrRolIKoC9FxIZjFiAERRGLLbF0sMHoYZtBbdiIULZCJ2LZR54wOaCR/Zo1/oJwGj256k+EWFNa9bPh+OzLXa/mEdRlIDb7bZ4VlkeEo5qlmHhx4/v6elgl4IXfm4I+hw1NiNIqRGFU9x5Fs/duLlrXtEBahEpYoFvdH60SnS4EaLo5+8KgoBfGHnXxs2vUuk7qhITMGehIG/wwGCPRQ7AmLq38WpWi8cAlCJz2sWXC6A4+3p6RaIcXUJlP+G8o8tnrd56j0X00eGN8cOVWJZXTjlBCdR1LUIF10EAS6ZhRzZN65VNBOnOzNRTsIpqRQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9H/7xYM/rKpdCsna6cwr9fmXA8doZRq71tAbpP5CJKU=;
 b=s5TE4lavfoXdxzXIbz5zCFZ6QrYRlcq9Dj1bIX39lGCph1fQ8TsawQ6+pwME3cSsqJ/J7sumuU+CqkHOpSFgUSPx/zaNQxUyJDV/VdnA8NqFGshURcMufiYXYmuJhkeRNgXiT+PTopc5y6loNjyi9lJsVBUaV7pMQm+EEgvUod0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9186.eurprd04.prod.outlook.com (2603:10a6:102:232::18)
 by AS8PR04MB8689.eurprd04.prod.outlook.com (2603:10a6:20b:428::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.13; Thu, 21 Apr
 2022 14:44:13 +0000
Received: from PAXPR04MB9186.eurprd04.prod.outlook.com
 ([fe80::adc5:45f8:fa40:1b8a]) by PAXPR04MB9186.eurprd04.prod.outlook.com
 ([fe80::adc5:45f8:fa40:1b8a%7]) with mapi id 15.20.5186.014; Thu, 21 Apr 2022
 14:44:13 +0000
From:   Frank Li <Frank.Li@nxp.com>
To:     gustavo.pimentel@synopsys.com, hongxing.zhu@nxp.com,
        l.stach@pengutronix.de, linux-imx@nxp.com,
        linux-pci@vger.kernel.org, dmaengine@vger.kernel.org,
        fancer.lancer@gmail.com, lznuaa@gmail.com, helgaas@kernel.org
Cc:     vkoul@kernel.org, lorenzo.pieralisi@arm.com, robh@kernel.org,
        kw@linux.com, bhelgaas@google.com,
        manivannan.sadhasivam@linaro.org, Sergey.Semin@baikalelectronics.ru
Subject: [PATCH v8 0/9] Enable designware PCI EP EDMA locally
Date:   Thu, 21 Apr 2022 09:43:40 -0500
Message-Id: <20220421144349.690115-1-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.35.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR13CA0048.namprd13.prod.outlook.com
 (2603:10b6:a03:2c2::23) To PAXPR04MB9186.eurprd04.prod.outlook.com
 (2603:10a6:102:232::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f1c9bd10-4b0b-46fd-8604-08da23a566da
X-MS-TrafficTypeDiagnostic: AS8PR04MB8689:EE_
X-Microsoft-Antispam-PRVS: <AS8PR04MB8689C37B09C377E5193E39EB88F49@AS8PR04MB8689.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xvjx4Hg/4jN9ToxeWc/TrC8y8LBl71+9DqIp+PC48iZ0PjIJt0eKWBbcKU3QjqBO3GyqfJkljG+cfAJPi9BRGkc5+UBozU3g/VkUsChqsm5TJhWcRgQlB/6ti/zYXMaSFAXI+rRh60rlLUUb55+759KcxA7F86DMnc6PPbrV4/+upcU9si0h8xKOkiN/ZvUVq20weSZzYGpIQzkLoeXpDAOQf8TT9f8oGdFSSONsdmbmRVN1aypU5TuZffGRuVj7S/1crveoNseTFUZcg8c74CUbI8TZU3c2qPUuZZXwoU+EVeLse7L/PZZaMpzl6AFHh58iuZvGQIIS+TnDb5UU9NHsjs0nWo01HQrZffI3DeUjPTuyQO7NQqHq6PXCtyCoSlPF0py3IWe+1hn1hVO6SIpCBiRGmovCQ9y7SbndiLSGYX4fAAXLAhGnV/7DHgYevTEN0cDy/TIXMgkznpWbiu2ZJGhHGpNYo6Wzg+qTh23BOlZU5Vg/6JnOE4KbVd4p2PT17B1cT/Lcb2bGAiVFa/Dp5bjOFVFhxoVh+Stb3dQamS0lcSYebrssVr34x05NIqyZFAKk2/K8KJKDJRc3/zhcijB1uVxI0uvpUm5ykirjUuiqg32uBJvQePAdFmwbMnxdnZpAA8sftFEJs+3SXDmANySsXGx7HSIVCOu589hegtNLwsDKXO3YoOSoYuYNrwYwcqeQVWj0PFEPjevVbRaDQDpYG6iAGmvEDCUHm8tw+6pPACeHglJxYH6zR/8UDigicPAIMxHGIn6v4/dpBgGEyLoGBh5LYWaRuKPVpEo=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9186.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(66476007)(66946007)(6512007)(508600001)(4326008)(316002)(26005)(66556008)(8676002)(52116002)(6666004)(6506007)(6486002)(83380400001)(86362001)(38350700002)(38100700002)(186003)(966005)(8936002)(2906002)(2616005)(7416002)(36756003)(5660300002)(1076003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?hlgOFE7IN2HtdJHK00BvXMZB8AF8eKtfFW8iX6QACnWBPPCEvKYu74ay/meW?=
 =?us-ascii?Q?LTP0H+9I1UNsNF3Tq7cX0G6qH19KmCsrU5ch8XU1PPgP/Z6rPS3bE/WjWa41?=
 =?us-ascii?Q?3Ft0AJ3KAULlwqZE7byVJs7I1/R1F4oVLcYVnT14O5ARTZeV9Z3Eb/yb7yYY?=
 =?us-ascii?Q?ZRin261Y8mI+EKYnkyhGJtckN+Q999V31BX1Xp1UdK4zigtEyxsiKmW9r73Y?=
 =?us-ascii?Q?X1DubT7Fp1n3oScy6NOQ1S4c/S6HIL3JxXWcFJ/igJXhnITiLKnJq0h4NmIC?=
 =?us-ascii?Q?neEEdXEeJeAkLJfoxaCg4qu/N89xnC853Zwc9e+5qfQsG0ap+Drc5Czz021D?=
 =?us-ascii?Q?TCh973oW6XJ3MGK6BV6HRrDuq6oh4fb2OUotKrCyp7gFlWyUPeQFuwi9oaar?=
 =?us-ascii?Q?dFHUZabUW0rdM6Fg/cY0DuRNhyGHH6YNKBoU8ggRGR8G0awEElwpHmazVBff?=
 =?us-ascii?Q?Qi5iqWYY/w96aqmN/czQzJ4fcImy/Ar4pTpM5tWXPfi7fjAbMrAGxHFUzhxY?=
 =?us-ascii?Q?jB+ekO7bocZRy6c2IPZmxRIHzDjy6hTGDn8AF0NMzfDVImTUnQdVWOmFbKGJ?=
 =?us-ascii?Q?fHURWrT45uMStBfUM1peMmZx9jDpFQcy1PNcUWxYEqIItPCIotQxOZjxlkeh?=
 =?us-ascii?Q?9PpTC4ryUwpnR8TfdIMmP4A/bOJmmRLbo+PNgka3wvRRht6nL8cfN0KuYz+g?=
 =?us-ascii?Q?cyK03v7BVdY6htCGLQ2P2VnLudnI5fTi41nC50YHEjqAIID+lQKGCWny718h?=
 =?us-ascii?Q?lzobQyKW3/ATpzlZbqMuwTJweNYKkJLJuA6/pRvERqakg7DQYe6+iKHCusUS?=
 =?us-ascii?Q?zgvovxQWkAVDX9Prxcd2O5WsaGrFGV99KeXGzNSdvSeAXPyFbpBjyYc0fVrS?=
 =?us-ascii?Q?QxOIX/GYrzeuM5RPsu0y7/zDlKg/N4TOKnkcO9YlJR1Zv8ppCJCrq4mdmByA?=
 =?us-ascii?Q?MMsb9finmLlm5qpQZ/hI7WKMrjqIYMoV2++Vcv8X4CRadVvureSlKPC2ILj2?=
 =?us-ascii?Q?f4XvmPbjj7BAinB4xYjFj/gbfmYvcnHH7QjdOSxkxGqNomQjtYqolYNfqNJI?=
 =?us-ascii?Q?HyZBViYK/sbJSJ1H0hCaNdsXkXYDp289TpYQjB+F95Q7HmLDo5EjBosj6Qoy?=
 =?us-ascii?Q?5MPiWrgr8c7dobXn9wIE9KiJ79/A/u24aRHkg2JiGOutQdspouOmGyFf72hr?=
 =?us-ascii?Q?IwDX3CgxrUbxOBrZEQ5QWLRhmbjJ2cMDcobMQSeRkvl/I5cMHqjbguVqjuUZ?=
 =?us-ascii?Q?6aeMuslaikk0WYjPMY45uPKNRu3YFN196hnett7W0ltyPTkzDDq5KXWxcUzn?=
 =?us-ascii?Q?Bg9KOjTxZ1ooyDIe1Xz5riupWNXgM2yE7e5QDN0zp2Tvkl8HIHTRtCfY8aqB?=
 =?us-ascii?Q?d7XBRxjj0j5cZytC/UeEKR9L8miI0f2nndWi0uNemnos6blsXgqYnZVQ7toe?=
 =?us-ascii?Q?q/WGh3ixeDqrbe0p3aLNkhU5pEyW/d1kn0hy8Z5I95hvqtL/8eOVtwLOpku3?=
 =?us-ascii?Q?4nMnTEndkYMnCQpvwWqlIcOydpvadoDecI/vlomaMH+sQJRYXJTLvpidROAQ?=
 =?us-ascii?Q?LbiE2IF+HB2T0M5LPBpkmxtR6DSfybVVdxtVXCNUE7/uRjISGXspt0w5GweJ?=
 =?us-ascii?Q?d2F1z4xrm66uNW7JBTPASxEFkNvPUoRiNkrQm6QZ1zZkmt7rdc5eMq9Qp4Ae?=
 =?us-ascii?Q?h4BtWvEnPRTdtDmyu6B/vk6PoduVj2B2hk9IN3M7RYZXuEuh152jbhcV05kS?=
 =?us-ascii?Q?aasw38rmVw=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f1c9bd10-4b0b-46fd-8604-08da23a566da
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9186.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Apr 2022 14:44:13.0720
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 11iKNrKF9nTCtj8l2B2nx1cZHREjirVswbCKDiFZfREAHlK8rW4KmnVBtCqQMmU+C9smkCaXXcRDzkxpnV7abA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8689
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
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

