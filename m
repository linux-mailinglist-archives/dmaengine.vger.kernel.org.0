Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F6904D523F
	for <lists+dmaengine@lfdr.de>; Thu, 10 Mar 2022 20:44:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343558AbiCJT0q (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 10 Mar 2022 14:26:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343549AbiCJT0n (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 10 Mar 2022 14:26:43 -0500
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2073.outbound.protection.outlook.com [40.107.22.73])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0176136EEB;
        Thu, 10 Mar 2022 11:25:42 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Jri4Nh2WkUlAmtUQId5S1jatGT/PuCUQs6VuGjge/YfqR5RlxvKK/B22q50u2iiv0OWkEV+YKdxj4oGBKAdHEF31U/K/5UYrSrfv4gZd0FqL9/5kBfEZv76VV2ViyS4luOsYg3yjzaUYj9TXJn+SaJO8/Frynp55sSZDgC+4thzlir2STPYMUG9jir5IWr4qh8hUdHYkK3Emq4LjX6w67tla4LEy1SGDTxFN3DfhXHBhGFIDA8LZTlqq9/v+/6q2DKOWWdL9yZv18q2itz3KvXG+PiEdnHAT3biOX8dAzjwN/bAHu5ep8tfH2g2y/qfjL2m/zfMxaNn2Bpje5IdLCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Hx76ESifDLtWBd/iZGEWlZtG4L9DEgCYhYL0APpe8PQ=;
 b=iQ/VFouLBjsLEWAfu0LSENwN5FrH5V79hnSykYLV2Xy3WFS1x3LTLSOX3wuC4HteGFOJrcW3JFXi2minffOOdNEmLjks3D9xDBxvHvHsP+ljlgfmMAL8dgq4HYRR/6bX+zBzR/vS43fGY3AkIcK8+VTIhdLXM5HI4s4mxoUZcu0MWTJC1c3nGWNywLSUF6ppiR3yhcRBPLttQIAQcEeF/pIc9huNSv2de3Dt0kSK40vfkBaLCg9+PDuLDOg7x6DI7gEipPEgj6vw9LpqrPSjUl4QDrQB9sOpAzdpiIlbgDWgdKaNEdVZ+FRVZM6gwUwre9yRaIGkYOc5TrSiJfLHXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Hx76ESifDLtWBd/iZGEWlZtG4L9DEgCYhYL0APpe8PQ=;
 b=DLDn7pYwyVmHKV21CMI8ja3dPKKAkRMO0CvOb+eovrkd62Jz5D5zEJz4bGSHwkxzjK8yt3BmU7iE8MDieHDh9REzm7HToPBRQAOmaO0oqLCgr097+bMqwXXtBD5aAjC7z6ET7P16EEoyAnSXuXxFg+kbeTwmV51Pw6GvjOBsouc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9186.eurprd04.prod.outlook.com (2603:10a6:102:232::18)
 by DB7PR04MB4858.eurprd04.prod.outlook.com (2603:10a6:10:1b::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5061.22; Thu, 10 Mar
 2022 19:25:40 +0000
Received: from PAXPR04MB9186.eurprd04.prod.outlook.com
 ([fe80::c897:1bdf:e643:aef8]) by PAXPR04MB9186.eurprd04.prod.outlook.com
 ([fe80::c897:1bdf:e643:aef8%7]) with mapi id 15.20.5038.027; Thu, 10 Mar 2022
 19:25:40 +0000
From:   Frank Li <Frank.Li@nxp.com>
To:     gustavo.pimentel@synopsys.com, hongxing.zhu@nxp.com,
        l.stach@pengutronix.de, linux-imx@nxp.com,
        linux-pci@vger.kernel.org, dmaengine@vger.kernel.org,
        fancer.lancer@gmail.com, lznuaa@gmail.com
Cc:     vkoul@kernel.org, lorenzo.pieralisi@arm.com, robh@kernel.org,
        kw@linux.com, bhelgaas@google.com, shawnguo@kernel.org,
        manivannan.sadhasivam@linaro.org
Subject: [PATCH v5 6/9] dmaengine: dw-edma: Don't rely on the deprecated "direction" member
Date:   Thu, 10 Mar 2022 13:24:54 -0600
Message-Id: <20220310192457.3090-7-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.24.0.rc1
In-Reply-To: <20220310192457.3090-1-Frank.Li@nxp.com>
References: <20220310192457.3090-1-Frank.Li@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR05CA0051.namprd05.prod.outlook.com
 (2603:10b6:a03:33f::26) To PAXPR04MB9186.eurprd04.prod.outlook.com
 (2603:10a6:102:232::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 363b8a28-1320-4cf1-14aa-08da02cbc30e
X-MS-TrafficTypeDiagnostic: DB7PR04MB4858:EE_
X-Microsoft-Antispam-PRVS: <DB7PR04MB4858EC8FFC5D4E427F0E3FDE880B9@DB7PR04MB4858.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Vf+29wNXrLaZ52zpWQLRArfsTPcsXPTKBwOPH+nKHmO/P1JhTKAMawzudBVw6sv3Bc/8QJIbdo1n+/Hckm2MVLv6wTT+GJRPGhOf5Ug6dTxDnyYuafsi2fgr7QzUbdujVqQqJXNaAQ0HbS/5MFXvb5pQD2XmMqR96qYibX8LJ+vdYZUgp/sQs4nqlAMZPodu7bC27W6nZaRhsL3xXq3FN5V5bcjX2JGPowvq5+nd+mlzSDs3CNazyDNHG15f45we9HVZaRyWvO4+kI59UQK65j4V60rKuaomGcxpxWn1/hiyp+adgCacrm694KEus4jWvGB9u/A5sqFM8rUbDKsl7ytV33tN3tR8aYnyQkDG5H9/IDqdJz/IMQwwbArT8+5GVqNjrIUULsQO/lOsCez9L9zKnw98VDnqIK4oIUaS4mB0S8tNGvJJ5YfF7r3kOFNMBuXhuWac3fGZAxqrX0pBvY6TpyNPZn2WrwEZTcKAyXfHXUq+ZmnRtLMO8oIBO6kJTFgxydpeTTBxU5F0oShhROkLUmj8U4hOfM/11OaHATixl4jbH9LlEdQ4xg9U6+Ufww1iwm9QwQuxUWum+GVQRuwX00j9zfRoB7a6sYAwlSE1mTUAva6gpY/jwtnsCI2EimLsB3NKdPdE8YG2PWbdHajEHxAQ/T6eF6jpGxyx6iCBTLM3jAj8/K1LOQQ4QcV2j9ECOXry21V+SlIQCpBM4g==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9186.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(1076003)(7416002)(6506007)(6512007)(36756003)(186003)(5660300002)(66476007)(52116002)(6666004)(2906002)(2616005)(86362001)(4326008)(8676002)(66556008)(83380400001)(26005)(66946007)(8936002)(38350700002)(6486002)(498600001)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?/rsn9yJBVIi1Ae23TUijrMkUYF2hapG6ZwPRHSKpP6uPkWXiv/ukzIuKX+AZ?=
 =?us-ascii?Q?loe9jJn6Y0ehKkj7iu5oD0aK2mHi16c1Jt1UgQQFdq3t1ligxbQSdJYFt2AH?=
 =?us-ascii?Q?n/3t+ImmEKL2tqsQ2+ydDcBmifBqfz4rh/wOLeWbzH+FfzEw5slid+2ztNgm?=
 =?us-ascii?Q?Vcos7Hu5GckXIJhlzMYFwwJv65ZCqCUieGRanOj/QR+i6TUx09mNFgEMlOrD?=
 =?us-ascii?Q?c+Csol6zOQ427DuH7QUzU73Q4dQ4XynQCZ/GNWw9ImU6PP+D9vamTIuKORmj?=
 =?us-ascii?Q?RrWxzAgEWhXaXwUC4jniN1kl8KP3Kgdgo5K+F6Ph55Ie9aRHfagHSFuCjtqM?=
 =?us-ascii?Q?Zh3rj9ZxLqJBvynLjmi63od8g+/rPRkuMMVnDt1XypaUvAJ1dkkmXDh8O1bH?=
 =?us-ascii?Q?5FlwxJZtILuguumrU12uITvvAAIugntk/YyhWahE9WQBabdRWAco5twHrWv7?=
 =?us-ascii?Q?p4oVANYBg/kywCmwkKvyqvQy2clfntKu0gvcl0HPnD8VipFXK6XL//fGvP6V?=
 =?us-ascii?Q?XDjoIMMaplme6Ur/Wxypy3jg6naAH7RyVGFK1P3CAWaPqAOy6JjxhgSaaZvz?=
 =?us-ascii?Q?BvpOU4NGLrtt7xm2+obRaVYhXOmVAeWc0QQSFGAqvwQ/P2f5wSynR6rwNR9d?=
 =?us-ascii?Q?x4hFyQfnPaHcQeR2AiH62FwlexlaDBZTJhwZUh4jO4kDAKB5+FZAh/Kqdt3B?=
 =?us-ascii?Q?+SYaVjWMLSxXGrqa/djppXUvom2ZpLSLVhTumS9EFuea8HVYVNtP07BPFQuc?=
 =?us-ascii?Q?KhYW/H0QZFQbsVC1qQzKG/IIQ6fhBJaJNQSvV1hXtaa9rNhIixyodm1Gw7mm?=
 =?us-ascii?Q?+Q75rmZ4a6TiQ0hjdQxii3Ebyse6YTu/gLrht8XePYWD9mULOaRwqMpYfh/D?=
 =?us-ascii?Q?mOdM86EvZQOn0oDcR3IB4cZiky5Xj6HaKF82vyZyBr4W7T5IvrTG8ixuWYf6?=
 =?us-ascii?Q?HgPMLLcfBVK8YKL8mLAApQrw4eT1tNC6L7u+73oThhb++4+FTVlZHRmqo71Y?=
 =?us-ascii?Q?8EQl6uD3nCahVTTtjsILfqPLGTpRBlJ/v2An294/rD+833bgzbVPqyHOGi/2?=
 =?us-ascii?Q?flAeg9fydodJKCNbJYfQQHMRNTMql7Aee/JI6xtcrBYvaueJf9czg2X7HcFw?=
 =?us-ascii?Q?jFeIijz3T1WjwBhvvmxvgldpDrcJECABOnBI9CZ++QcpuB0+P2DSHflaXWst?=
 =?us-ascii?Q?VlmoDz+gnQ2cNgcCC+jtXONDjRRtHgFyMJwbKxv3zZZLeWvFfQbG6VctgALL?=
 =?us-ascii?Q?P071aHd3ZQal7ifZ5jmqUwUXhxQ9BJUZLLWV+1O2DNtg8Ozd0omYynTFPTNc?=
 =?us-ascii?Q?NQ4+N3obNF71fLZw30fPx+uHNmJeyZOkDgErrkHi8nLXnzzbPemH0fV+7DEr?=
 =?us-ascii?Q?BQokGw5c0/wbW4Z4RJiL3/gALh5pHs66kkIlm44ujh9x9X1UEbm+WOsVkvxA?=
 =?us-ascii?Q?URL48Y7cbp+032NkXWhY3vkTY4c3mY5K?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 363b8a28-1320-4cf1-14aa-08da02cbc30e
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9186.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Mar 2022 19:25:40.2787
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BX5AydNa0lkDHHT9mozZ1Z1/yhg0NHTCYnj6fBFY/WSryen+GeOGOhxuDR4gWsEMau14FcGjyQl7UpazWROTgg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR04MB4858
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

The "direction" member of the "dma_slave_config" structure is deprecated.
The clients no longer use this field to specify the direction of the slave
channel. But in the eDMA core, this field is used to differentiate between the
Root complex (remote) and Endpoint (local) DMA accesses.

Nevertheless, we can't differentiate between local and remote accesses without
a dedicated flag. So let's get rid of the old check and add a new check for
verifying the DMA operation between local and remote memory instead.

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 drivers/dma/dw-edma/dw-edma-core.c | 17 ++---------------
 1 file changed, 2 insertions(+), 15 deletions(-)

diff --git a/drivers/dma/dw-edma/dw-edma-core.c b/drivers/dma/dw-edma/dw-edma-core.c
index 924f220007362..156255ce7744e 100644
--- a/drivers/dma/dw-edma/dw-edma-core.c
+++ b/drivers/dma/dw-edma/dw-edma-core.c
@@ -341,22 +341,9 @@ dw_edma_device_transfer(struct dw_edma_transfer *xfer)
 	if (!chan->configured)
 		return NULL;
 
-	switch (chan->config.direction) {
-	case DMA_DEV_TO_MEM: /* local DMA */
-		if (dir == DMA_DEV_TO_MEM && chan->dir == EDMA_DIR_READ)
-			break;
-		return NULL;
-	case DMA_MEM_TO_DEV: /* local DMA */
-		if (dir == DMA_MEM_TO_DEV && chan->dir == EDMA_DIR_WRITE)
-			break;
+	/* eDMA supports only read and write between local and remote memory */
+	if (dir != DMA_DEV_TO_MEM && dir != DMA_MEM_TO_DEV)
 		return NULL;
-	default: /* remote DMA */
-		if (dir == DMA_MEM_TO_DEV && chan->dir == EDMA_DIR_READ)
-			break;
-		if (dir == DMA_DEV_TO_MEM && chan->dir == EDMA_DIR_WRITE)
-			break;
-		return NULL;
-	}
 
 	if (xfer->type == EDMA_XFER_CYCLIC) {
 		if (!xfer->xfer.cyclic.len || !xfer->xfer.cyclic.cnt)
-- 
2.24.0.rc1

