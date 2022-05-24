Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2BFE3532D4C
	for <lists+dmaengine@lfdr.de>; Tue, 24 May 2022 17:23:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238791AbiEXPXC (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 24 May 2022 11:23:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238401AbiEXPW6 (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 24 May 2022 11:22:58 -0400
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2084.outbound.protection.outlook.com [40.107.22.84])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB43F5AA43;
        Tue, 24 May 2022 08:22:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=a/HAkCgQ5XXqsHlrkVW2aFeZjr/iOKJda+3a/dzLIpzSE6vgidKBq0DxP2zXGCFcoRhjM8FYRX+eUaEyeEui+tl2PrDojFRta/JNHYf00XNxWCPnhgupMNmhWEDnOCtOTs8vIQSQQwipITbS6oNiQR9xKbRCEsGE1Kdrm53aY7lGUqqzL1bv49MUjH6xGTPZlthiqJ+pFm5Ap4D+llqRGxhFjoSd3V1o5qcGoKW3ubl+gG9jtdzT51O1ZiXEDR8FjodLYcquaeESo8Od4e314t/60XIAVFs7xT8jqTf6y/y2Uxa8/J2UUWOpvL3LDSvVCEUoHGOjzJjVqBgJtyY6ng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AwXmdq2w0NVc5W3YT9hEL/ylCcNXeWjpsutKo270JGM=;
 b=UyntTlDSUawt2LVLNMyOuiwC5MJicaONzfBdej4Ba+M5GtT39/u4AC2MwnmJjEajIv8Ck6/NynOlaDpzAd3v7WY7Xh3UyQ5hcl3FWThMz1Zpd9qThNeKM8AMjpojWjpGrdB+owu00mmYj0cWjTX1YCZUwey7NZESkNDqEB2TxkqiNF0qgZM8vHLjpXZm5U3KYhoDiYcVFVzqDEdLKQivzQmFm5zLhQiK/h8e5zNrPjWMUlnubrkhRHV+gfDfWLja9rtBkduVXeNRhkM7HQ4VjCK4M2EgOYrTlt9j7WBCfrOg9lnW+UMWkXqwPoImmLTSbhAXGe1OpHJfgOESPQwpmQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AwXmdq2w0NVc5W3YT9hEL/ylCcNXeWjpsutKo270JGM=;
 b=UHZXBdAszu/8O3G7sKt8RsBEZL8HCoLqNYWOVlcOX2r7pBSj+TmLAWIX3dWu4YIhx8mlRR8T2WuA36E6FQEUNmDFDpszK2in3Vu56mj8z8AzfdwPStf8GVqJAFWZerPuKbyvVSrGy7uuBa2CSuPEyoaNT4x9k5fXB7koKodPbN0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9186.eurprd04.prod.outlook.com (2603:10a6:102:232::18)
 by AM6PR04MB5672.eurprd04.prod.outlook.com (2603:10a6:20b:ae::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5273.22; Tue, 24 May
 2022 15:22:22 +0000
Received: from PAXPR04MB9186.eurprd04.prod.outlook.com
 ([fe80::e0bf:616e:3fa0:e4ea]) by PAXPR04MB9186.eurprd04.prod.outlook.com
 ([fe80::e0bf:616e:3fa0:e4ea%5]) with mapi id 15.20.5273.022; Tue, 24 May 2022
 15:22:22 +0000
From:   Frank Li <Frank.Li@nxp.com>
To:     gustavo.pimentel@synopsys.com, hongxing.zhu@nxp.com,
        l.stach@pengutronix.de, linux-imx@nxp.com,
        linux-pci@vger.kernel.org, dmaengine@vger.kernel.org,
        fancer.lancer@gmail.com, lznuaa@gmail.com, helgaas@kernel.org,
        kishon@ti.com
Cc:     vkoul@kernel.org, lorenzo.pieralisi@arm.com, robh@kernel.org,
        kw@linux.com, bhelgaas@google.com,
        manivannan.sadhasivam@linaro.org, Sergey.Semin@baikalelectronics.ru
Subject: [PATCH v12 1/8] dmaengine: dw-edma: Remove unused field irq in struct dw_edma_chip
Date:   Tue, 24 May 2022 10:21:52 -0500
Message-Id: <20220524152159.2370739-2-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220524152159.2370739-1-Frank.Li@nxp.com>
References: <20220524152159.2370739-1-Frank.Li@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BYAPR01CA0004.prod.exchangelabs.com (2603:10b6:a02:80::17)
 To PAXPR04MB9186.eurprd04.prod.outlook.com (2603:10a6:102:232::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4b16238f-a462-4bcf-1db5-08da3d9932ec
X-MS-TrafficTypeDiagnostic: AM6PR04MB5672:EE_
X-Microsoft-Antispam-PRVS: <AM6PR04MB5672071CB9A4DABD1933F43388D79@AM6PR04MB5672.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +Pm1QH4XRWXbDP8MalMgx69i7NX9kO6e77mtgrF2agh/Epc0kGSEQZpPfghprC67pgIrpMLWGuW3U3X8vuuO7/Yl7kZfLfN21c3rz49s2KDMoS97eEvJudWAhedJ+Do3mIUoLQTZGsLAXrMFVBUc08fPIk9DCB/lznkAisM7tghyA7keAWmAZ19Ri8PHvwJS1Qj3N3erVNmfuQrt4aOE1c0ywao0dvo5dzysWYdppGtxx5FTjwyWkf9Nfy189IslTrkmcC1pLMQRFQGTGY0XHaRJpM9N8k/oaVl4rcfMB+Cs2FSkpy2uxkb0rBzpWOdOPV1YLyfsEs3jehkPx6XJ7vYHedUuBgev+Z6QLSncdO8RTg70nbQnPdAinowjF2+m9AbVAh61jkEoQY1nYWvaGH5zhxRMdDG7demXHlmZLdFmTstjojrDZVipJkXpm79IunCKwuRv6ou/MOS6kCdpcZElBeCOya1ayMeckyNuAud1KWIDZajhtnIQ8wGRcT04lP3jk11ghbKqojYJ+wQbsu0K5zB6a8eAwH8+XAjMB4dHKfEZYp63vECo20k07nJTiQOVeLpFPzdZ+5AyOcnxz2I1nPxQ2dcr8hbaQ8BVg6oaBZTuvLtL3nYjyhSNBZq93SzbD7k/GiCFUm0i0bNvDZUyNlbVwXYSis0uU54qL9wM0rDaWbHp5ul2akFrzEze5CWzU9A40RgN+LCDNFhVS4/wiTgOHrWOX+X8Z13SuHA=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9186.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(86362001)(66476007)(8676002)(7416002)(316002)(38100700002)(38350700002)(6506007)(6486002)(66556008)(26005)(66946007)(508600001)(8936002)(2906002)(5660300002)(186003)(4326008)(6512007)(921005)(1076003)(83380400001)(52116002)(2616005)(6666004)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?liaDHevGCxZRMhSEoxn9YFzn/E7SuTg6gz53Uwf+E2X44J/eFU025r3obKLn?=
 =?us-ascii?Q?bSBkRQS9rbs6OTZNdyPppIfw7g3AUfe/QpUJE2cTnjy8eMHhwiKegGEh2k5T?=
 =?us-ascii?Q?sxWhbDDIzRWtPquyBiEIvnjTkVtNy6d1oNvXawGmB0YpVCWwhJwSn7ihw0Pv?=
 =?us-ascii?Q?2vRJeG8B/je2wC5w7MfaECjEwcY0vAWK114yE/ommzokt/Gs94WU/kHB3Awp?=
 =?us-ascii?Q?VwfyJZa5wjD2kJdfPQ2T4LsDc4ijbJiHZtEjBSk+cM9z0hH7c9RUaNe/8WT1?=
 =?us-ascii?Q?NL/KoDi1OVdo6WRH+N31vNY96WI1kmhQursoC8nfvJmnsf6XaS4jKVz4tKVR?=
 =?us-ascii?Q?+ts+YSV2s3dCVjinE2WoLlmn77pvPjGpvC29n93B6EqrOssuEowGPQqzL2wY?=
 =?us-ascii?Q?8p6JRIxItV8ctQPh/FW1BIv13k8fVfAHBt4ByJDloAf3LmNPrtkTSQaWBs9g?=
 =?us-ascii?Q?mAEMl96kRj68sLR4Vt5rJ5gqbDJlsYNXqclhlYs08H6FeLZiU0qghC2R2P0w?=
 =?us-ascii?Q?f38oIs43H+WunWBC6vXB+anomklNicW6LqS1ypgV442Rk9K2qIbiamXoJdJo?=
 =?us-ascii?Q?9BwTFj0lAZJ8NLVovYUbaz+pCcMZO7G2BaCAXUhSEiGIQ+nG0UqLoudCRCxs?=
 =?us-ascii?Q?1mi9dNNa6N1EQqI0DYoG4an/zEUK0ogmlbDuLAU1QwnoYeTTnGfSbDNnrtd+?=
 =?us-ascii?Q?8btFvfADMMsws0dNXGm80CrodDTo4t2ql7Yn62eTwdcea9Na6Cf3JFM6OJPC?=
 =?us-ascii?Q?lKpOwtIK/DxbktbvjB0rzm6VxrBQYZstKvy8zrJqTWKidATmdnfMdFOj9NpU?=
 =?us-ascii?Q?TyRAQP95Yg3hxMiR19IR/xqs8nA2uj/DYlDgtWNaayleNTNOiHCTNETiiPS9?=
 =?us-ascii?Q?1C/J3uzX8CdxSk1buUezVrgKTDtQ8kBv5Pqm0m0WdMoUXOWX1m6nAzrBq7UM?=
 =?us-ascii?Q?Ld/o8tMHmmAEPtmQvCD68hsMKb+LSgYn5CNiYOjrWzheP9DoOClbg1FN7ni3?=
 =?us-ascii?Q?aJsxNv1ZS+9eakfxgoeIQm03CUqd9/RLAxvgRjtQACqBSJphi1bP6em77S8Y?=
 =?us-ascii?Q?CB2ENZXy6dHDFcMnJNHKhsksEMPB+CJhVeRvGrLl/VRNUboX5OxeOLYVHLi+?=
 =?us-ascii?Q?jtm4GIlvt1EypVhSdcs3dndEm7qtuOCuOlkY4Nb8f9UhUxacF2iX2UskGdeB?=
 =?us-ascii?Q?E6RL3qxVKt0fdkpSLXLJbjKgWMdDJotRRu2Mstppg1GkW68fCY5UUMM7PR1s?=
 =?us-ascii?Q?wQHKQsOiDooVLb2qDkAgc4C+0c63n9gDa7wvGEqNODClrGromt63NuqIB64Q?=
 =?us-ascii?Q?6A/FTqwRL04qKKURQZafwr2cJd3KqJ17odgqO4SGin46e1HKEXWAInQHwGve?=
 =?us-ascii?Q?kA2Nm74MtM62Kn3fzdSYrqB7gFzCxxYoaarTCPpiUvgCct96b36lItFV7exa?=
 =?us-ascii?Q?CKJHTegYdmzzczoaIksXEANf/20zepkm1vcQ2ejhH4kLm3f1HO+T1jF9UfWh?=
 =?us-ascii?Q?ZZXLDE/FoFIe5CxEyZbrodXIRKbd0/dAt2YBlWF6oi9SMgJ4VIM1priYu8Tf?=
 =?us-ascii?Q?rQDlLtlSAbOo997N1TIzn4rdT1yjg3o8NaYdJkEbB99NT7c1tOuvjMfy7n/0?=
 =?us-ascii?Q?uzexxX5HPKrXzmGNoxlDQz/L2vVE/RJyBGXqUuKphmK801D+VzFCc4XZQbVZ?=
 =?us-ascii?Q?Skz4FIEEI80ZOW/a/kKy6gsZd97Q4bx/L0kU9g2zK8O16tvkYxLOlk283neV?=
 =?us-ascii?Q?WbNdb5QgxA=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4b16238f-a462-4bcf-1db5-08da3d9932ec
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9186.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 May 2022 15:22:22.2002
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 303Wuo+l5tbiUDSlaY0k4m+LNDgsainjoplHkcxkZBgRFpEMT/XXAlK1/GGkhqNnfJZVqucOWgCrWNM/UIsFsw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR04MB5672
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
Reviewed-by: Serge Semin <fancer.lancer@gmail.com>
Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Tested-by: Serge Semin <fancer.lancer@gmail.com>
Tested-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
Change from v7 to v12
 - None
Change from v6 to v7
 - move to 1st patch
Change from v5 to v6
 - s/remove/Remove/ at subject
Change from v4 to v5
 - none
new patch at v4

 drivers/dma/dw-edma/dw-edma-pcie.c | 1 -
 include/linux/dma/edma.h           | 2 --
 2 files changed, 3 deletions(-)

diff --git a/drivers/dma/dw-edma/dw-edma-pcie.c b/drivers/dma/dw-edma/dw-edma-pcie.c
index 44f6e09bdb531..b8f52ca10fa91 100644
--- a/drivers/dma/dw-edma/dw-edma-pcie.c
+++ b/drivers/dma/dw-edma/dw-edma-pcie.c
@@ -231,7 +231,6 @@ static int dw_edma_pcie_probe(struct pci_dev *pdev,
 	chip->dw = dw;
 	chip->dev = dev;
 	chip->id = pdev->devfn;
-	chip->irq = pdev->irq;
 
 	dw->mf = vsec_data.mf;
 	dw->nr_irqs = nr_irqs;
diff --git a/include/linux/dma/edma.h b/include/linux/dma/edma.h
index cab6e18773dad..d4333e721588d 100644
--- a/include/linux/dma/edma.h
+++ b/include/linux/dma/edma.h
@@ -18,13 +18,11 @@ struct dw_edma;
  * struct dw_edma_chip - representation of DesignWare eDMA controller hardware
  * @dev:		 struct device of the eDMA controller
  * @id:			 instance ID
- * @irq:		 irq line
  * @dw:			 struct dw_edma that is filed by dw_edma_probe()
  */
 struct dw_edma_chip {
 	struct device		*dev;
 	int			id;
-	int			irq;
 	struct dw_edma		*dw;
 };
 
-- 
2.35.1

