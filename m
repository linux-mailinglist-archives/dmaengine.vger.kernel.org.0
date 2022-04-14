Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B0EA1501F43
	for <lists+dmaengine@lfdr.de>; Fri, 15 Apr 2022 01:38:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243965AbiDNXkD (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 14 Apr 2022 19:40:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234563AbiDNXkC (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 14 Apr 2022 19:40:02 -0400
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-eopbgr60085.outbound.protection.outlook.com [40.107.6.85])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3462FBB912;
        Thu, 14 Apr 2022 16:37:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lxxN4d6rvutUJEntIUgEzUezqx603zgloXU3jeVJd1tGgs+kw0OfwwltiHX47YrHlVu/bQ4y1ka6SngTB9XsMlVKzqMGtvtm93S9JacdJ3N7oUybu9F6Dfgy/zhfpjLlGcmLCM0L3gHYSQ7Hmd/P3skKQVKfWEASjgrEFNtk5UxdqcilbJ+Yq1p3xoeIfl8Ww7ZY/VI8RAxNjsGJEvbLjR+mtxDnaLKQAHe0N1Vv3BR4Xap9Izkg7ttNFvClQuEoyXw0h+D7lKHuA+N11AMX+79XalPBFEk82xcXM8U8SOPmQZvxN5UKCK7l2ksSEtbCUXLjzX44lQ1TdWP4d2dP1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IY639MmIbGsFEoxOX54Szwhv9JhLysX57Dj8g8fV2tM=;
 b=JSq3VqVvvJylkmm1MuLr+60T3uTFct0YlQoiTO25+IMdyBNTmDFgAbFMkC66CARDmcLc6syKuXa6Znwo5ApRi5EMesLIEV8v0G+NZ1rkMwJfEGHeecaRTUVbyHzvVw/IrMDTNfsH2qsOeOmt9ObTtk9dGvY0VmZv7KuXCEGaubY/2mEw5pOhBkJMP12+zL4G6rc6dGtsppjnDqKZFmfi04Hda/C62fS1WX53/ctAi0LYeovkkNiFvxqQ+tpwfTOMneAbv92cBz71+qWKEEUK+rEPRVCmXFzMOIREZw6eF7UGCJ9hxzrPpi8YQ6e9ZYgR416bskjHDN9tLatzSZeksQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IY639MmIbGsFEoxOX54Szwhv9JhLysX57Dj8g8fV2tM=;
 b=MZz2rznmhmsAHkjpscGnvI0l+lcNuCXiBKHKHqXcLHCpxzZlwwyAiZBHmQ1119NTvv9hxcD+8iKvri0kjIur90ZAYYfWpYiF37qSEzmqN5zmLDMNIr8H/m9fPB2NhjBUZS/fXudTAoEW2yXkEvUzbhZzOlKd8me/jZrjGUrgDsI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9186.eurprd04.prod.outlook.com (2603:10a6:102:232::18)
 by DBBPR04MB6043.eurprd04.prod.outlook.com (2603:10a6:10:c5::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5164.20; Thu, 14 Apr
 2022 23:37:34 +0000
Received: from PAXPR04MB9186.eurprd04.prod.outlook.com
 ([fe80::e13c:6fb1:ca92:d11b]) by PAXPR04MB9186.eurprd04.prod.outlook.com
 ([fe80::e13c:6fb1:ca92:d11b%9]) with mapi id 15.20.5164.020; Thu, 14 Apr 2022
 23:37:34 +0000
From:   Frank Li <Frank.Li@nxp.com>
To:     gustavo.pimentel@synopsys.com, hongxing.zhu@nxp.com,
        l.stach@pengutronix.de, linux-imx@nxp.com,
        linux-pci@vger.kernel.org, dmaengine@vger.kernel.org,
        fancer.lancer@gmail.com, lznuaa@gmail.com, helgaas@kernel.org
Cc:     vkoul@kernel.org, lorenzo.pieralisi@arm.com, robh@kernel.org,
        kw@linux.com, bhelgaas@google.com,
        manivannan.sadhasivam@linaro.org, Sergey.Semin@baikalelectronics.ru
Subject: [PATCH v7 1/9] dmaengine: dw-edma: Remove unused field irq in struct dw_edma_chip
Date:   Thu, 14 Apr 2022 18:37:01 -0500
Message-Id: <20220414233709.412275-2-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220414233709.412275-1-Frank.Li@nxp.com>
References: <20220414233709.412275-1-Frank.Li@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BYAPR06CA0045.namprd06.prod.outlook.com
 (2603:10b6:a03:14b::22) To PAXPR04MB9186.eurprd04.prod.outlook.com
 (2603:10a6:102:232::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 43ec1908-cf7a-4b08-2bfe-08da1e6fc00d
X-MS-TrafficTypeDiagnostic: DBBPR04MB6043:EE_
X-Microsoft-Antispam-PRVS: <DBBPR04MB60439F710C1E544B2974B08088EF9@DBBPR04MB6043.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: a6avdAg1H5YRkmysLBaKb8dgfBAR0xDRItr/lDx2DO0/Ej9XUZhM7Y2lFPT1wTwFu8fuyZWu9kI+MbNjfecHsbSYex0g9ir5VIn7m0UzoBl14aJKXIAiTiLXC7SlvBVOw2LaHzVS0WMlal1SDFG8cEeBA/z7XnuNc4pU2TqMotRWDaw6M4mMQ5VpdU0+JkeDl2b9+UY7i2RIYixlJwJ1lYajTUL1Rrg+Ae5U0fKXW8gS7xGqLoOQl9yldxDnJYC0QHamo80EBgzK5FBo59l7rDdL4DtNNkDpWUyA5HtnA+pIob1bTaxXlEfFkjI9US0CLT2JDTsVGBlkiC7PiHNQ3htSWCR/rdoKF7JOF/NFioatUOoXMVS1XbYphOZqJl3NIAXAU9ehvTjXLINFOeTBTf+CWPemNifUMTO9CtvuWFkSoNR003CuxfN4sAkqPSyN53rpqQ84PTfxLooksoYarW7ZAYKuNIIGDHahukbPLgDWut0tny3+P8PMslJtZrEFoMaiG/sFg293yMHiKzPi11Kvh6xubhy8W3E9DUxMMBjj2150ywjdwBSt2vWUvN+7CHFu0TYeKB2+6y1EBQ98WzDBJDKkOvLw3nG/WIrh3Qk9Bw2Re24dQvnx4zfzM2A18BgbzWoe9o6C/j12x9BaTI5qUhYUFyp+4EXbp9l3Wqp/kKkVt13/NcZOPGhiWM65nqptJiELHS++/j38casmsA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9186.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(5660300002)(6506007)(8936002)(38350700002)(83380400001)(36756003)(38100700002)(508600001)(6486002)(2906002)(6512007)(6666004)(4326008)(8676002)(186003)(316002)(86362001)(7416002)(1076003)(52116002)(66556008)(26005)(66476007)(66946007)(2616005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Xm3U2f9nNOvS+uvhofRiqZI4CBFuNO5e8s5fIQYNcy/BIZnMAh3eRxR9HCvH?=
 =?us-ascii?Q?4kBbpsa5l0DrfnSE2RU6JOrdoPncG6//u7BXRkQ+TsSG2t3YMtxcaVeXfH9V?=
 =?us-ascii?Q?kNrjlLacPV1mnPTTQH5nrgg5yJYEmoCr/as0EEA+DD2clEw1SaokhMHG1ryL?=
 =?us-ascii?Q?4/Cry1LQQPn3UoocBQP07kRCKSYfXb8zGYq5/RZ4+j+FcsvtqgDukyUewy/2?=
 =?us-ascii?Q?KMAeuysNSm0v1ROroqWnDgyFHQnMhc5E0bsQrZYix0ceYz7L9unGCURam3SX?=
 =?us-ascii?Q?vaYuEUclwWlVn7ZIxZr2aWll67rM/lWSLI4YlSclFfJ/g698vQahVw9pE9fi?=
 =?us-ascii?Q?AYkDDyhrB3RpNJ/VY3RXfXBSDVXS/kcmuYed/ToHwdC+yVkpay52YVGYCYNS?=
 =?us-ascii?Q?LqX8F0fMjn6IgJhOqsHq3t1fCOFBNnhgZ2/5T6AsXgZlVqWkjjQHMPLQMyJO?=
 =?us-ascii?Q?u9lkgAsPanS+dbkov23yGiyZLcgwE88+FxFnow95I9ixVFcKEQLPt9AUTXKa?=
 =?us-ascii?Q?W0lc29tcOGgyyzC66U7X9w5YDMj7ayQtEOXPagPJTejMuqjJJRVaki4KtqHt?=
 =?us-ascii?Q?n/eL5COyrWHfrvTn7nDMSPfFBEz8qK4MVv4U/SGo+rZSAvTV0fgCaxAz+iQx?=
 =?us-ascii?Q?iHXSu+yXblqWS2x2bqTsiY3DR38BogDhzbyL6AatMe45H6C5zgwSEG7sYjsD?=
 =?us-ascii?Q?etNlfLO193T4VapqVcrvpHNnc0A8GAxVOhdv99kElxhGKwM23Pok7rNpQZSk?=
 =?us-ascii?Q?OpfxHsanGT4o3qJ0gjGKEK3kmHWs/g6Xq+bbdd/Lev/5xrb4Teb45AogjvE4?=
 =?us-ascii?Q?SwEa6Ua2H2FrGaEjZjJAP4Iv0Tul7136l+5Pq0hCi40Yn5UEFOBVD34ZR+Rx?=
 =?us-ascii?Q?/CiavuYIyDq1sh8+C2inNsFOhY6c57JMt7G7NY9URGFaxWDCWsm2OUr6fGKN?=
 =?us-ascii?Q?MWbzn/53CwfkMIUvHc7W7RbNTbJ4AtTo4l171nGnokQ/9y5rCl3iVYY/BX2t?=
 =?us-ascii?Q?F990+ZziMYtSTxLVoN7zb6nqBZ1j5OvJ8xL8I0I0X4rbx84R17kxdsYF5Gqn?=
 =?us-ascii?Q?/+/4OqTd8KN6LkPWUuLQ9lEYo5/YrzOokIohSgipIItefaySThGKsErT4Gew?=
 =?us-ascii?Q?ykQ5XGKqvdoAtme9Vlchg62lv6Ei5DW2JDh7mHDmWbio6zgSuNFhcckUN2zW?=
 =?us-ascii?Q?XfCzNv1SxVYlhVnjrcHYlN17YjN7g/nl5NezOuucLy4ayh6id5wT4LxZJTWU?=
 =?us-ascii?Q?s5jkm+InaPKciI3HxS3L+yRSEAP3iHzCpy9jQpTbqJ8vyxxoyb75Ve0xxXbf?=
 =?us-ascii?Q?HvMmTsA0oaTgrtUJJjSQUFXTtojkUuoUA3NYICZMNYL9kpEDS2Rkzk4Rqf2a?=
 =?us-ascii?Q?7suzgg8kqIWNfpVWars0ZYlKDxHysQVDzRmhLYFKzzwxvVFS2g5qhpD8reV7?=
 =?us-ascii?Q?XVAtKW3x27c/+obC5gASOHHLh//pvvIrT82eOzob8l1YUm7zzuMzcPdc5og+?=
 =?us-ascii?Q?rWgfHIGZ9LnallNDFaFzqZPiy00soQ5SYKQu0YQxSWkbserv616TnwrAOAsV?=
 =?us-ascii?Q?T4tXR0Bx47UcdPPa5tiH7SAKvf3pDaSx9T5M/tAzJZ50veFslBPdg0pXOlP8?=
 =?us-ascii?Q?pw03pc2v1kzYz7X9Q6muCRKTxIuKGV868SfR6G1wmxkQ0roQX+754RO0Mm/I?=
 =?us-ascii?Q?NrKUgtKg/t/INrQsvHTPgLHQVw+gv2Xyth68c/vOabGFG0LY/fYB0kBcY5qV?=
 =?us-ascii?Q?A7/MGkPfpw=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 43ec1908-cf7a-4b08-2bfe-08da1e6fc00d
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9186.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Apr 2022 23:37:34.1762
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JkJWzQIbnmHYlUHUZMaAVQl3JpuIHacw7Cpwqo5VwcYH0ZTYHhRpWvPNJR8t2iXao/Zr+62llnrmtJCEEDUF1w==
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

irq of struct dw_edma_chip was never used.
It can be removed safely.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
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

