Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 97B274D3BCA
	for <lists+dmaengine@lfdr.de>; Wed,  9 Mar 2022 22:12:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236791AbiCIVNk (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 9 Mar 2022 16:13:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237777AbiCIVNj (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 9 Mar 2022 16:13:39 -0500
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2082.outbound.protection.outlook.com [40.107.22.82])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B54FF2F3;
        Wed,  9 Mar 2022 13:12:38 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GcGFcim5IVLsxx4pFK62TU6UkmF+5qVe4Y0IqtUkovv20ngLr4EMcnElSr5M3twS+OeaFUlWrZJtREM9qERxgyQY77ZHXKlL2FouirlemIf794XXSrxAROBjzTfyVnw0c6kPpxa+YbpUKvS4oYvKkGD3+r6TljYh5Czh536qCSkqeLZGsbjsYh0bVweAijgd0dmRGMtZ/YirSJqRITbLr0RqYgC1aSLCe/Ue4pxF7hlTpFSoAZ2oDirXjwIuMS6ZOMxbHMq4MVniZM3RNACmdHmrUXZnFnGzLkIG48ZAGuzQOzo3QaIBITzxRwxQE816Yyw4thuqOfVaZq+JEgltcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9y1Tg0vJDQBj7Ogdx+zhHJvKV2s6HQMNCw/wrEqsK64=;
 b=g4F9Cejl79UjwmBZIlDVl0PZ9Q+bALJMVWyS2X/2eP610fOSMHouy7ApwNcmJEJhd3OxYjyi0CYHCVsoB9mA7WBzGgN/Pc1+xkOoHAYLt6kcykLPPrWqi17XWi/HS3Ydbd6shj2INVIQuMLnBlFb7c8e0PtzqJjJEC4XKE085VbQFSki1PGKbNKTpC/74n7PBe5qjR2+/dx95u6piXRfLcTyNU172P+46J6JsCyWcbd4fZth7WoOgBLNYj+z5gWUiVDTmMggGb9WhoirrsM7RMF5skCq1NiEOrQYSXutEmpZ3clDWWAdoYSt3zGSnQDHSwq2138kd8lyZvJjZEBfBA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9y1Tg0vJDQBj7Ogdx+zhHJvKV2s6HQMNCw/wrEqsK64=;
 b=K3mGewUA0QB2aD2xiJh4hLSR47P/CLRt/RZvAHkcFAlcJpNqZpWcLQT6CSi/1fJDO+RwCGngkU9R7RUQ1USbfdEU1dIiQ2ru/PLKzwfOwwUMGmLNnc4/fZtZxyOSRyi2GMGya+M8ivKAOcVJc0hWq2R9J8pkXfJEoTkvUeqSnVM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9186.eurprd04.prod.outlook.com (2603:10a6:102:232::18)
 by AS8PR04MB8358.eurprd04.prod.outlook.com (2603:10a6:20b:3fa::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.14; Wed, 9 Mar
 2022 21:12:36 +0000
Received: from PAXPR04MB9186.eurprd04.prod.outlook.com
 ([fe80::c897:1bdf:e643:aef8]) by PAXPR04MB9186.eurprd04.prod.outlook.com
 ([fe80::c897:1bdf:e643:aef8%7]) with mapi id 15.20.5038.027; Wed, 9 Mar 2022
 21:12:36 +0000
From:   Frank Li <Frank.Li@nxp.com>
To:     gustavo.pimentel@synopsys.com, hongxing.zhu@nxp.com,
        l.stach@pengutronix.de, linux-imx@nxp.com,
        linux-pci@vger.kernel.org, dmaengine@vger.kernel.org,
        fancer.lancer@gmail.com, lznuaa@gmail.com
Cc:     vkoul@kernel.org, lorenzo.pieralisi@arm.com, robh@kernel.org,
        kw@linux.com, bhelgaas@google.com, shawnguo@kernel.org,
        manivannan.sadhasivam@linaro.org
Subject: [PATCH v4 2/8] dmaengine: dw-edma: remove unused field irq in struct dw_edma_chip
Date:   Wed,  9 Mar 2022 15:11:58 -0600
Message-Id: <20220309211204.26050-3-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.24.0.rc1
In-Reply-To: <20220309211204.26050-1-Frank.Li@nxp.com>
References: <20220309211204.26050-1-Frank.Li@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR05CA0170.namprd05.prod.outlook.com
 (2603:10b6:a03:339::25) To PAXPR04MB9186.eurprd04.prod.outlook.com
 (2603:10a6:102:232::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6610720e-9ce9-49fa-d0cc-08da021188a7
X-MS-TrafficTypeDiagnostic: AS8PR04MB8358:EE_
X-Microsoft-Antispam-PRVS: <AS8PR04MB8358315A55A09210671F70AC880A9@AS8PR04MB8358.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5O/FxI+Oh4hLxBBbKsv09EbPlHfE/5pj0AGRIarQXzVRAapZn8nx43r7WNF4KgUNEaCQ+hMFq/g8vU/3HmTSjoVCsM/8Yr9X70Ov3zBhVkhXtA79xwZpMFbnRI9/NzJyKMfRCWZYk/N1nxoT+13BoTzExLIOBBazTQutHM0+DZGAUiRKnn7tZycFSJzy8ynMhYvRTtKihVC/AdA3+q9WTlzX08YXr0YUF+wo6V0rMumRkUnZhRDrvSQueJZDusS4X5tVwo8bRm+8/9MTuK0T/iVAd6816os0GxEjqP0JiWYhaRKUc4xhYB99O21Y0bQRlC9BQF/bIItc+wNF5ztka3eMpAP6EVa3oZN01cywfoIpHI7ZfYSPplYjb+ANGD6xjQ5gRWBBgZzSKijgloqxpnZ0Q9utwKbtfMJINhaYA20sbpf8zd1ZHllVKxL/M8HuQfSEqYUE86SxTYc88pWzlJeGLAGRS4He14op9OXlq/DR+huKvTgur53q93CTqsphVpozxO/sSZ9ejgo6EA4TNQ0QNyZm7ZLik4dt85MFxG3UBt2Qnjx/yj0NK36swjkjpe/eS3StSPHXvtXY+SbP1nA2anJ55EFXm50VLSHuzpQPjufsa5Og9MYghA6LA+XeOw7sX31FmqInnV3Ay3OCBhnXtrkPqPD3k2NQy1H/+FINEUGuYVv/OkzeqfZhIyh1CLnBg9P7yGguA7/Vl/eiyw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9186.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(26005)(186003)(508600001)(2616005)(1076003)(316002)(83380400001)(6512007)(66946007)(86362001)(4744005)(66556008)(52116002)(66476007)(8676002)(6506007)(4326008)(36756003)(2906002)(38350700002)(38100700002)(6486002)(5660300002)(6666004)(8936002)(7416002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?uBtg9Zelk8iD1XL7YdezaKnib0tCcwv6zcwhayYMJgYR7uhFLouX2/sC99Rs?=
 =?us-ascii?Q?wBUWvqRJnnC/WETY1BQ6tr72IysKhLbf+4ilvwH+ws4ZfLqAxW8McRfziOcK?=
 =?us-ascii?Q?mP1Sb5CqNdPy9mTqCPdbO3KhvGxnJzcRtT6xUs6jIxZanePbnlXwyv5l4JhK?=
 =?us-ascii?Q?52kU7qYNVj/v2qSGMhjKqalnZm/wLyY32POytdFHGJENRK+h+Naz8t+hzy5Q?=
 =?us-ascii?Q?s+R2/n/ZM3no/IBor5HVD+g8DU4sejdO0fvXTqsU5gDc50SX6fupkvnZPDhI?=
 =?us-ascii?Q?y9QZ2WVA0NWFi/4YJ5IH5HIUNcYhnKlyYqz0RI7CIF/zfEXyc0yvQSHKmX2Y?=
 =?us-ascii?Q?uugloNsekBmEtNgtV/amP7oEdubJlzFLv5Rsn9p6C5XlFvDzVHDOR14N+qXO?=
 =?us-ascii?Q?APPbcSZHEAA8OuewsgexM3uebhl0hai10u2+ZfeZSvPSCclkyup2Ms2UErtQ?=
 =?us-ascii?Q?BspoxVAVz39dxpp4u5to0NWfh5eOyPdu4aT2tDW19dL91EbhVHMLvhzu8ttw?=
 =?us-ascii?Q?TcY8/qsGV6/h3TY8KXPD2TlqJ47mMo12LxZ7gqEQ1HpmmgiNxJOwzkMsdhyI?=
 =?us-ascii?Q?yage4nVj2HstWx6F8iAQpqxsKU0MJFmp9ME/U/xPj+S3FRERe7j+pwb2K/ps?=
 =?us-ascii?Q?ojm2JBtoy34UMAuBAxYjjvxpdem67e+thzn7GAlNwfEo9om47PlF99K3PpAN?=
 =?us-ascii?Q?ebq+g2rgn0q6QmfdijIaqfRId6D28mnTLxYEt15xKCgnYC4atmPpKDL7BNvV?=
 =?us-ascii?Q?9uZY2MggBiZYqUevrA4QXghetyRTG9YmxPzOM6QJFS6NgVDmCoBUc87IGcKp?=
 =?us-ascii?Q?ipNvTqJut1DudNJwedbs2P7N5X5Y6P75L9IV5XUluPQ8zpH3VIGQsCWKEKO8?=
 =?us-ascii?Q?qYnRAOn0CYvZWbt71V5eHeBvPzPZoG2p/QfxOGieFIDQ2ZaY3NLcUMK363xz?=
 =?us-ascii?Q?pU21l0ghuZLv2kq3APyNNo7wekizN6yTaA9SRQbp4VfxRxfT0QyBDw0RqZA+?=
 =?us-ascii?Q?KRcnAkryAH1ExxIWWAL2Q8CcCqbHPwawNj+mJAkCs1ZnSl978xyGtGYoUIgy?=
 =?us-ascii?Q?kooF8m1R5MVaybYvISF5GgFnezQqDjNOYD0qoV1AumTUr1S0NC5S8yoqlXeN?=
 =?us-ascii?Q?92NSQkkYJH/sdxowCCAi3Vz23NcLeLNt4SaELFBlNb9PCCECj67nQi+dv183?=
 =?us-ascii?Q?acaZKBIBW+RD2Not33t6FmOcsilcyA13RAuAKyzkDNgvsVKowayUPmMgtNWE?=
 =?us-ascii?Q?a+SChmHdkP7CHtPrjHtleu/fCmr5nQ1Kkglnr6p6Z1N5wFndrQIBulebffj8?=
 =?us-ascii?Q?+Q6qCea2fmpRQ2cxH3vz4Y7sRD3ZrbsKwU6xR+BRoq1cerOVLKv5o2qiS6lb?=
 =?us-ascii?Q?ZXhyr8AoOw8CGroyT3El/fUiimyj90MlF01ExhrwWs9mwzT6SuOhOaiHVf2X?=
 =?us-ascii?Q?lV23viZbGAlHg47H9xxKm9Ep2HKQs4wReuxSShN6mdzy7sTaI4QXXMQsUzEB?=
 =?us-ascii?Q?C9FyCQa4TbfqNbmhq7OnPJTuZeaVND/tCUXVkfsXkXTuI6lgYLZ7/4UT4q7B?=
 =?us-ascii?Q?NmFIC2T+NO/oP6YSO/FwwmmKNyabmG3UBcUjZnIjOS0lPTOJdy8vthUW9zVe?=
 =?us-ascii?Q?07mQ6lyXbhJl+x7X24gDG+w=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6610720e-9ce9-49fa-d0cc-08da021188a7
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9186.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Mar 2022 21:12:36.0026
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1qyC7pnKYv2/DB0ldj40dqaIQz9AvekD9tR6XcGL7bJ+VlRNVX+2EMSmXCcqJwb+OS/1rbdeCyH7pyjcbALfnA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8358
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

irq of struct dw_edma_chip was never used.
It can be removed safely.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
new patch at v4

 include/linux/dma/edma.h | 2 --
 1 file changed, 2 deletions(-)

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
2.24.0.rc1

