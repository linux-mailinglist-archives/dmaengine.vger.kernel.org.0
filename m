Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C458B4F67AA
	for <lists+dmaengine@lfdr.de>; Wed,  6 Apr 2022 19:39:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238973AbiDFRZn (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 6 Apr 2022 13:25:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238883AbiDFRZg (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 6 Apr 2022 13:25:36 -0400
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2066.outbound.protection.outlook.com [40.107.20.66])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 784144B75A0;
        Wed,  6 Apr 2022 08:24:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IoXfTyIgIL3oZi9g2aNvvbC1C1iXphc/HMqkp5/Kl4Gbotw4b4JiOnJxC/lOn9A/wui+xNh5E0S46tZe+Q2q5Xffc/sBC9fVuhHjM869WGhhpr5DgZAunBDTInpLcyu61gHL67T93ZIKQ9Duh35WKIkarcSZF2ik7su7rSU/ROzllXBQXyk9xxXj5XfMnDl9EmghPcZuYR7q8nWVacYwLBpJvV3Ao+Glg9fa/KHtqXtlO8t8EydtGFys9+FIgZuw0NgUQ/FItLQyGFKo6R0/Bdx0xEM41kBnOCvOUtRJKDCOz+wYtqOfIV5AAm/nyGebVXRn+WbaVdqg50QYCu1wqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XvWqMA9Fh+L27kw3wJYb6ONpAd4/NiB7Xov+3L1mw1A=;
 b=EBkkq4nTkTjnSJRGfRunjCOySuYMkHb4FkRXdb9aczKOH2+i4GvGqI1qwA3Wr34QQzW5LVNg6c6XeOh/vn23uF3+ZuCINKadq4dAGIBMc13maZIoFJZnXY17QlnN2UIgIyH1woL/V/T1ijCvgB//Z4oZpnZpkPlcBnyEKt7cpqLxRIaxUqWyOFUfZdKkg6TWXC6+nPkJw4luoR2aYIVG8jvlzhPm9Q1Fg2JFQrlmhHCxWpnWe1KhMrSYVJ1zlVMiemWqCFVUAhtjxrkLro+9LxJhi2S4DaoKNa4wIkXQHwYJIusYMXp5mg16ohQe6slTLa+VlMrDKb57MY4PR1FLcw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XvWqMA9Fh+L27kw3wJYb6ONpAd4/NiB7Xov+3L1mw1A=;
 b=AlXTWBF6xRLHvap0/++cOq8DdPb6liP35sms/bkS9Q8HbtlPuY88Ek3i6mzNK0mljluir/dGQL+v/iFk67+TMVU98BKJ0rYxV2A9DYbDue+9JRc4cbNRv+nNP23+syAAlDuCqZT2NU9gnHMwJpS230sJh48lUmrmHOQ0oQREw/8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9186.eurprd04.prod.outlook.com (2603:10a6:102:232::18)
 by VE1PR04MB7343.eurprd04.prod.outlook.com (2603:10a6:800:1a2::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5123.31; Wed, 6 Apr
 2022 15:24:28 +0000
Received: from PAXPR04MB9186.eurprd04.prod.outlook.com
 ([fe80::ade4:ad15:823b:7e2b]) by PAXPR04MB9186.eurprd04.prod.outlook.com
 ([fe80::ade4:ad15:823b:7e2b%7]) with mapi id 15.20.5123.031; Wed, 6 Apr 2022
 15:24:28 +0000
From:   Frank Li <Frank.Li@nxp.com>
To:     gustavo.pimentel@synopsys.com, hongxing.zhu@nxp.com,
        l.stach@pengutronix.de, linux-imx@nxp.com,
        linux-pci@vger.kernel.org, dmaengine@vger.kernel.org,
        fancer.lancer@gmail.com, lznuaa@gmail.com, helgaas@kernel.org
Cc:     vkoul@kernel.org, lorenzo.pieralisi@arm.com, robh@kernel.org,
        kw@linux.com, bhelgaas@google.com,
        manivannan.sadhasivam@linaro.org, Sergey.Semin@baikalelectronics.ru
Subject: [PATCH v6 2/9] dmaengine: dw-edma: Remove unused field irq in struct dw_edma_chip
Date:   Wed,  6 Apr 2022 10:23:40 -0500
Message-Id: <20220406152347.85908-3-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220406152347.85908-1-Frank.Li@nxp.com>
References: <20220406152347.85908-1-Frank.Li@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BYAPR11CA0046.namprd11.prod.outlook.com
 (2603:10b6:a03:80::23) To PAXPR04MB9186.eurprd04.prod.outlook.com
 (2603:10a6:102:232::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3637e0b5-fb37-4be3-7fd7-08da17e18a28
X-MS-TrafficTypeDiagnostic: VE1PR04MB7343:EE_
X-Microsoft-Antispam-PRVS: <VE1PR04MB7343BD8A38C5560A6B1A394788E79@VE1PR04MB7343.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: a1Zt5Sa3QAXS1CRabj4/p2vVIEAAaejKGhCqRHYRjhvOq49pQnVwOLva28zSXRDu82uWvNZJyYW48yNmUT+FXqH+Nhd6RyQ/lLq74XguP6GM7hb5InMqjVXiAd0efhSlIDiveQRTUaOlPNyCLh3W783FfjPmsCIJc/bJ2tAkLCsc79wCkSeT2mw7Pjb3WDNzrJivwXapU/OWrcxsrs139SKv5Z5iAWeLkt0w3Lx1YsR11rX2kODHG/F3r/VC0LZD3Qq2Sqik677v3ljDbLe+Dcc8tlFxvYahA7WvQ8egV0AtddLFPU/f0J9dj6TGyQ5pbMF8vl4su6PQYQcbeP6jkIeHRVZXVQYGwOzAjquJRocUF+hhVF9UY0CUGkGrC096ue4HMOMW6g/gqmcpj40SbNPHlhT/ZAKkjSNLh3bWELLLszHn7Fs3zlBpBn3QiZz3uyN5NJnjvCxa2eih4c+nDhRD244a8RXOj17cBtphAcZwjd/avy/LPnsT2IbhXYfkDTBSYe4rMZYqt9+gpLcHx/dGwfIot8jnL7r5bKwwJevnA0Ny1s7iqQTDP5AMXJTuXF6KaYKtpnHdRGusSaXJuOAOIh9kQ9dy6Zjb/py6DvMG9UcVz+/+1ongAoufAe9Nes8wDoaoctx2CUZiRyRMwfpHXJp7KXmLagAwjmdSj1PCqyfDVC1KnTcxboo2xKrRQZ8JHf8Ec8wurOpOynO3uw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9186.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(508600001)(6512007)(7416002)(6666004)(36756003)(66476007)(66946007)(66556008)(8676002)(86362001)(83380400001)(4326008)(52116002)(8936002)(26005)(5660300002)(186003)(2906002)(316002)(38350700002)(2616005)(38100700002)(1076003)(6486002)(6506007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?1IbTtz5PlqMMvXSRFqATS/97zPDimTZFu6oNjh567JIgQHEQOgD2TlR2ylVp?=
 =?us-ascii?Q?H+X+0825NdP38muvzEK9xfQkQbhBJ9rHq4KdZtWYOpYcXAzRyK9xngGsS2ss?=
 =?us-ascii?Q?Fyi55zSURYI4X8Rac6OTfXxEDHCQ1z4ZSXkNEk0q1ZxReiBEg234iOASCGWh?=
 =?us-ascii?Q?IycXaUj+CRmNYqyhSIMzEjSEZMfWu5VtbH/ryamJx65VCbZfLw4ncX0yy9hs?=
 =?us-ascii?Q?1ycItZ/sk1q8Go/+7pNYFPk+3f5XOrRP2pIZU9+EnNIM6QZcpWJRhjKFcdiH?=
 =?us-ascii?Q?220LIHGSFiqn7dfloo1tSXsDxue9QJpiRasjSlhwOOFpcDxmHpnZLB3t+dwX?=
 =?us-ascii?Q?EjysQm5jv4NCjOJ6+ct35LIx7Lj0qNKXE0GP8nDx5XV3qI3ucXnrkkkkH53G?=
 =?us-ascii?Q?kE5Gt80M1WRFkWoTrRfjFNFa0rl26UbXjZwhEQlUwO3eb7R3Rsu7+uDdjX+R?=
 =?us-ascii?Q?JnEoveXVDiD6C52RAa082FO6nGYqCBOByn12lriPACqe4A5r951PWbTYc/Ih?=
 =?us-ascii?Q?/0oqTbfpyXZPUXwq9EG0cBu/pp2PdDtRZJrzSbkdq8qJ9Vhis6f2PGc9pYCv?=
 =?us-ascii?Q?DMleVLpEyQVAjADClzdsOjhiMz/0qBI7Rb7uotkJSFA9MLubHmbpM8zzEQE5?=
 =?us-ascii?Q?yrG1XjonCjX8DqqiJb5qqdCTzs8ThrnIfCHhUQIl5bbNgYmn6Hy3tE3sbJey?=
 =?us-ascii?Q?GV/IbnU1AEA+dSYfn6YFT7RnupSsodGlrA/Cwzjh6x38OjGDVHz71Ihj92rf?=
 =?us-ascii?Q?Ethn1fV10Dex92/Jxi5kJIDVa3KGXnBnjlMV1kE7vqA8ON1sjZdQG9eNMQXt?=
 =?us-ascii?Q?rT7mwYwp0usTXZWBxK4VNVy+LEFlchd+qY3tEnAS2SZPyhTxxkGym+FOs5kp?=
 =?us-ascii?Q?kfaZm/BD+Jy2iS+5+zI+nJMbOF3LdLiTjoXArJt2F0Gm0qxQoJDWPxjKbXtX?=
 =?us-ascii?Q?xs2R1Ltl8and1rI0/aEqrzsV2fAkXYEFDMzBULd0hJ74exz5p6x0GnW3+RQI?=
 =?us-ascii?Q?1J6HAkleX3V1dhaxEbNxe2F0k+B5D6nU6C03VgPmWT3gbfLKV4FJ/eaOUKPB?=
 =?us-ascii?Q?1L6mpb0+SnCoiZJhCCJDenbTzHgCnr8cEpJW8tJ4aLPaH2l5ntR8tBQ8Qs3s?=
 =?us-ascii?Q?K4ZTS0KWUdu6n0qEyFyvtty+Ys3vLWkQbjI8Df9qPTxHRozKeOFiKOr769Z7?=
 =?us-ascii?Q?GU/IfLx1r0zFS5xsKzOPDnJCgbcUW2pgpXz0sNuznb3wwQoHXpVtzQrAVLwx?=
 =?us-ascii?Q?VLJXSjYofsSbqLFhMqTJ1bosGH5cvIwKErRQInSmeWG410Hfziy1CzEf5+oR?=
 =?us-ascii?Q?lDppYrYd7ARRRdTHeOIRUfoBd96ghbnUO0CQKpaHxGhUnhBdQpFZxqufQaAE?=
 =?us-ascii?Q?JDdqjgqz61efyTLoQ6NkNco2MmqmvMjveSZNgSeQjfEt/GotkDE9HXIbpF7d?=
 =?us-ascii?Q?a5hxhMZdnqViwizn1U+yf7TxLv9VmIBNeFAbJz+o8XE7Qq8qboD37pr0OxXq?=
 =?us-ascii?Q?BCo8LcMYRCyT0N3I0Ci1FJoHe3jiWaVg5MjYDDDgt1uCxPq/meLp4/RsTeRJ?=
 =?us-ascii?Q?HCVebeWCXgcAL1zKzjVE2TIEgwMU6DTXvJ/5BZZTShBVyZwo0t3nt8vLKO3W?=
 =?us-ascii?Q?UzVU8SBZMJLQcjZVSxKuR+sFQ2NrTBy6D7USsrBLwhGzqzgViqdb4FsgNCq9?=
 =?us-ascii?Q?MaK3pKatpTdASmu3YCNuhar6lAsmqHRwhnHZaVVL2ZvRD0+3VQtEsPVFXCNw?=
 =?us-ascii?Q?W0PjdwyjDA=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3637e0b5-fb37-4be3-7fd7-08da17e18a28
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9186.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Apr 2022 15:24:28.0586
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0TSnGEJSf6E3sUl+cdSFWx6siIQ4wVtRztAFwbTjzjeiuhmZkexCyf4h81LXSABsx3ERoXZvHWLqfLr+0+3tTQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR04MB7343
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

irq of struct dw_edma_chip was never used.
It can be removed safely.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
Change from v5 to v6
 - s/remove/Remove/ at subject
Change from v4 to v5
 - none
new patch at v4

 drivers/dma/dw-edma/dw-edma-pcie.c | 1 -
 include/linux/dma/edma.h           | 2 --
 2 files changed, 3 deletions(-)

diff --git a/drivers/dma/dw-edma/dw-edma-pcie.c b/drivers/dma/dw-edma/dw-edma-pcie.c
index 21c8c59e09c23..2c1c5fa4e9f28 100644
--- a/drivers/dma/dw-edma/dw-edma-pcie.c
+++ b/drivers/dma/dw-edma/dw-edma-pcie.c
@@ -225,7 +225,6 @@ static int dw_edma_pcie_probe(struct pci_dev *pdev,
 	/* Data structure initialization */
 	chip->dev = dev;
 	chip->id = pdev->devfn;
-	chip->irq = pdev->irq;
 
 	chip->mf = vsec_data.mf;
 	chip->nr_irqs = nr_irqs;
diff --git a/include/linux/dma/edma.h b/include/linux/dma/edma.h
index a9bee4aeb2eee..6fd374cc72c8e 100644
--- a/include/linux/dma/edma.h
+++ b/include/linux/dma/edma.h
@@ -37,7 +37,6 @@ enum dw_edma_map_format {
  * struct dw_edma_chip - representation of DesignWare eDMA controller hardware
  * @dev:		 struct device of the eDMA controller
  * @id:			 instance ID
- * @irq:		 irq line
  * @nr_irqs:		 total dma irq number
  * @ops			 DMA channel to IRQ number mapping
  * @wr_ch_cnt		 DMA write channel number
@@ -51,7 +50,6 @@ enum dw_edma_map_format {
 struct dw_edma_chip {
 	struct device		*dev;
 	int			id;
-	int			irq;
 	int			nr_irqs;
 	const struct dw_edma_core_ops   *ops;
 
-- 
2.35.1

