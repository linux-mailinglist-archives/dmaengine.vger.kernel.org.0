Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E7304D3BD2
	for <lists+dmaengine@lfdr.de>; Wed,  9 Mar 2022 22:12:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238383AbiCIVNz (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 9 Mar 2022 16:13:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238381AbiCIVNy (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 9 Mar 2022 16:13:54 -0500
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2054.outbound.protection.outlook.com [40.107.22.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A502E1705F;
        Wed,  9 Mar 2022 13:12:54 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RXw6TLsLkh+Xj79RKNAd1iywWKKwQNbWXDtDvLbmZ2DEC3YnH2+38DtDd+sYmYGJrbIY4eh3ASH7fyof/xZ7nAvbLXu/wQc2xKl/Vwon3/tH4uiMxwbQ0OvQa0YYVS+uozO0nu1a1mraZg7EKvxnl0ayW9AXBHc68I5HzBcmPuSnxwfI+/hkz5lFptjgk8Y0XrDxQTwVf4l8SyMSFXrz0WmhmY0rUrDLyBhiTm3rQuu6uhXZVyzNtMSHl+amG2OHOIzykplLKLqqGfzTFA3Wm6rdkBIfatO9VprbmOxlHE3IjQ/aGo+dcw3mgVhYxRJfGFU1lo9s9qduCECPtK5ZJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Jyi7o8htoSZtFfaUUVXb4rw6J+dz5BzcJ7SUvPklTFU=;
 b=CMq8v8ddMszf6FV/cxcJ/0hpqotUwL2QBjXJNiL4ssI5P3QXcyvHDFTBQ1etxwfl+k8FqKv9C9CWrnhDtYVuOinKF7UAVAsZ4SQEDt6eN9rGf6b27TSf9ShJtoxlduRhu4Sidnb/swdltm0RKLOYMDUeuBAVbJnDZSRUdAxvMn4Ky2fksy6ueBec/wssor66OpmyZC1buXvCQJI3XidHSXkgOwRlmRn56lRVeW7T/6w0T+UQJUA4DgRu3VZrcb9TNs/IDl4pSnnJRTGjvUtgaIwtEJ6dQk3NVbYRmu3pdLfMMkpTIURzXft3/L8gLN4AnnfJZ9vdDVvzlGuc1Nvnvw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Jyi7o8htoSZtFfaUUVXb4rw6J+dz5BzcJ7SUvPklTFU=;
 b=e/Ewv91TXLYascTc/5a28CAQ+NPwNWEZhmw4q2kQKdT7/1+YrYFyMOboQ+ucAGFNR8+nj41o1l8unSu1pC+sv/XiMCJ5UkXCF8O9B7EHNkmGft2HRaeGCfEPiZkXhmYw2VlWrxpBFi57/5AmrqSmYD4tj/lOtmxda8frmPgOqZk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9186.eurprd04.prod.outlook.com (2603:10a6:102:232::18)
 by AS8PR04MB8358.eurprd04.prod.outlook.com (2603:10a6:20b:3fa::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.14; Wed, 9 Mar
 2022 21:12:53 +0000
Received: from PAXPR04MB9186.eurprd04.prod.outlook.com
 ([fe80::c897:1bdf:e643:aef8]) by PAXPR04MB9186.eurprd04.prod.outlook.com
 ([fe80::c897:1bdf:e643:aef8%7]) with mapi id 15.20.5038.027; Wed, 9 Mar 2022
 21:12:53 +0000
From:   Frank Li <Frank.Li@nxp.com>
To:     gustavo.pimentel@synopsys.com, hongxing.zhu@nxp.com,
        l.stach@pengutronix.de, linux-imx@nxp.com,
        linux-pci@vger.kernel.org, dmaengine@vger.kernel.org,
        fancer.lancer@gmail.com, lznuaa@gmail.com
Cc:     vkoul@kernel.org, lorenzo.pieralisi@arm.com, robh@kernel.org,
        kw@linux.com, bhelgaas@google.com, shawnguo@kernel.org,
        manivannan.sadhasivam@linaro.org
Subject: [PATCH v4 6/8] dmaengine: dw-edma: Don't rely on the deprecated "direction" member
Date:   Wed,  9 Mar 2022 15:12:02 -0600
Message-Id: <20220309211204.26050-7-Frank.Li@nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: bb6afece-a6fe-46f9-114b-08da02119307
X-MS-TrafficTypeDiagnostic: AS8PR04MB8358:EE_
X-Microsoft-Antispam-PRVS: <AS8PR04MB8358DD67C239D2FD9DEC8245880A9@AS8PR04MB8358.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: S2gUi9AeaUGz4rcF3Bh5nrfgh8abdOdddtrkkEKorO/H/YtsA6s6xVzscueEptg0ySv0u5gSWQghA/gA9vsf7/OcAzVhYAPR9c54qkqIzrxsKg24jq9wa9hxoO5DQ8XROanUcBc6bTAXoN5r0+1sBqX9Mw5iHODue7qcq5NKybNu3bzJGul6Zz/JlVqtNCOHglHDfLexRh/rMaAW+RYs64KO2NezwlaoewPvEyc0GTFk8K+fwC/uFa8PzPsi4vB7xMddlky1SlPHkmYNv5+9RzZRJduBtn/sRJAb23cB8AhZMuAJ6WXZCmreSu6ZHTTXZzZO9Ba1o8nDQATorBFuzvvCSZ7FyTpPBeqeoCPTGRAMcotMdBscKp+xJEWHNMPaQ0/SJOJUJGkZuuaSxai94Bq2Ri13O3XdEGMGO/L/93VYynVCuaaAM4rw/jLzI/QGlJswEapApZLwkJSv99S0Yah2zVZKKMqJN0qkL50lOz6u83jxnVDHCwfPLTViMpLPBwCfLLnyrCFkyDgcXzRnBMQAIR2Z6FzIivYfrF9xirf3Ap+1nfpjyIVqsG+XVN7p0sKRcctC4pBTZcisXlOydFx1kTwn1IxHSVOccAWpYL/IcyQBpnkugSBHiDQG6lsnCuriOte7FDuqyxKIOjCsA+BKHfDE3vwoBVH994YmLK5jqVHzWVisK2NEzcgGY4RzRctbHnIe6u4qPA5u5Js4mg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9186.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(26005)(186003)(508600001)(2616005)(1076003)(316002)(83380400001)(6512007)(66946007)(86362001)(66556008)(52116002)(66476007)(8676002)(6506007)(4326008)(36756003)(2906002)(38350700002)(38100700002)(6486002)(5660300002)(6666004)(8936002)(7416002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?me5PMSfW/yVj4KEHuhWsg8LUTx4paVzf0Fxx0Yt1XVQQU7VU+3Fd3oXdFTGj?=
 =?us-ascii?Q?0u2wmNqnTpvyyhJGK+G/QsApzaTdvrFvyTiF1Ei9g0AXXNfreSVpsBIL6m/s?=
 =?us-ascii?Q?dvLVLs+R3XGSYB2NtRltS79lMztKRQ+/u8CiyIbkDfT4bpY7EeIJkm1j5iir?=
 =?us-ascii?Q?d1tfURT1q2AtqF3DEr7UvxcbRfHuYooU8hfCGyUBchwf7/e5AnuzYV6QYwCJ?=
 =?us-ascii?Q?xA4t/W6Z27fi+MD3CR5QkcEqz3pb46J4NeeLnJ+cQqFwzBZfuYlKRv3UodhM?=
 =?us-ascii?Q?vPvlTPMNmfFgdPSMnOgclis2svee+qkMN8uCuqhBBb/GsAjLuML2B6R+syML?=
 =?us-ascii?Q?dAYDkuLZ9JSMEQ/kptIkNhySSZr/LMjDRK8JiPmVgWlh0jhjOkJNM2FcKFxT?=
 =?us-ascii?Q?y8Jz/o3OQFJLJKQWaun0zZDZMHzQv616m2yc0TndWVUFAI7bOL8eu5EicONZ?=
 =?us-ascii?Q?/+AsimVbaGmaxvem7KeweiJ+FlYljOVU5gsIXhZO1OpNVOasZdNVd2sihTdk?=
 =?us-ascii?Q?rUD0weJNHJXzh/NDir3OZtYotWm3+KcOgBcR4A0Ck8ZnmAClkzf1FZTVFMYu?=
 =?us-ascii?Q?vu5eDYFz+z7adLQ7avSLWMjzf460mi92HSPvpuoJOtIZcneQw3p5eDeckHeM?=
 =?us-ascii?Q?Wko9LXmeWvS8l80iKYnsgyNWs0mT6WGy5TT7C0SLlONvtMAVrwOJ2ZYiTqkS?=
 =?us-ascii?Q?dtCv8nJ1FrGkgy0kUq5Nr0UapQMT8r8VWWa8zLLf3mRNC0grje6Fp3JTrdsq?=
 =?us-ascii?Q?YA3Qm04S24BidQVI31YwBrAyAzxcjxVZq2525xABCGKvIjygjYlw87zINTbg?=
 =?us-ascii?Q?4jCUg09Q/unPwszmTodfQtHnGA5zCx8AGMX6YqSieA8rFEkt5T8JEtawpH/o?=
 =?us-ascii?Q?Ds/mt2gCPKeG0QmD/bMEttlcckCZH24wyhvy2WvPncR4GidTVitIRutfA/Th?=
 =?us-ascii?Q?oTIWmBLzRjt+XjiUNAiZsxkMswEOfOBlaTm/kxNSEXMvBAkQdDGgIsPjCnA4?=
 =?us-ascii?Q?JwuqgO/LwHrP4+5A+ekH6/iVWxysLzmuTTsFO9l+eH6sF1+cGfp85X7qYb4j?=
 =?us-ascii?Q?EClfBNJ42RBKw1RszJYk3eg4kYRNPwtP5nRDdChVAN2t0f7fhu02U6rp+pDB?=
 =?us-ascii?Q?NiwqDjn+2Zp0eCQrEwjCvOyRgPjvwJLo76ImYmOuZjgjw4Z2p+gbV5+dsi5h?=
 =?us-ascii?Q?JtULcW/lz4XnbH6wDqgRFe4umS/tTNtM78TiaHk2/CB+xtCcuITx9eAKAaMy?=
 =?us-ascii?Q?2XPmA91B6AmxiQuELNq3QTL3a0pQCCcvOOg6Te1tHnqbfEjAJjWqXsJFi1lx?=
 =?us-ascii?Q?b5s0Y1zKFNGwHfz/IzZ8gmxG1EgTmeRwpJHBp0Q8mXFEjTkQrjMb1Yw6ext3?=
 =?us-ascii?Q?2+b9eX7DXr4xVWAZBizjlgZDepfqpzGvjL5UNniuvGwIxiEvLCVl8WPeMThh?=
 =?us-ascii?Q?SacbfrrbzyiD8H/IcJw42xTIo7ywXeIug2iJyfbOC/4AvSZnP8/e1jzszuB/?=
 =?us-ascii?Q?imtxB4ObFvMi0XHkisKswIfSQMI7ut23FEAzEcxnSSAPEBO3Hun2njM5AfcH?=
 =?us-ascii?Q?q4vEwPDzKhG742SakXmrXc552gKteoHmPF7RmdjrwwZecVT++854ckd/5ZKd?=
 =?us-ascii?Q?PQzSB/SLUTO0/iwBLxrc8/4=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bb6afece-a6fe-46f9-114b-08da02119307
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9186.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Mar 2022 21:12:53.2322
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hHUgItYdsUkuQr9U7Qd/29Y+XIY6mdsHhJfBDqwV0JPiluSF6HYWRd7aVAo2T/GwKkSYsoaSvf5xhHRdcpA9vw==
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
no chang between v1 to v4
 drivers/dma/dw-edma/dw-edma-core.c | 17 ++---------------
 1 file changed, 2 insertions(+), 15 deletions(-)

diff --git a/drivers/dma/dw-edma/dw-edma-core.c b/drivers/dma/dw-edma/dw-edma-core.c
index 507f08db1aad3..47c6a52929fcd 100644
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

