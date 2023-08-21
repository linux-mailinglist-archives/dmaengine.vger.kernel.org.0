Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4ADA0782E22
	for <lists+dmaengine@lfdr.de>; Mon, 21 Aug 2023 18:17:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235211AbjHUQRu (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 21 Aug 2023 12:17:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233507AbjHUQRt (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 21 Aug 2023 12:17:49 -0400
Received: from EUR02-VI1-obe.outbound.protection.outlook.com (mail-vi1eur02on2055.outbound.protection.outlook.com [40.107.241.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9C5419A;
        Mon, 21 Aug 2023 09:17:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=A7YTUTgfRuvbm4p0iFF/Rtr7Oht9o5pxRociwb/yMuJ87cU9CRtcJ1P7BXJ+pp4g5IzIv+XJPY09rU9HkwCkl5gAUsivdaxGUTxYNTcxh+oFVLEaQ0lAyeu6639+Z6lDlfb3wFmyt2Wg2a3ptFTzmcL11YnsM8A4FgOAwwHiNpURItueoEn4nRSmQP8x2zAeKmu9gGbbjPNJ434zGNFas+5QyFfEaau2kBnoVvQokWKRoOeL39JPI78UrvmTni0u7Aofh4FpsTnu93dA0JOc3M7ltLtGZ6uMQjCdwmKPfL0zMR3qnMNUzI3aMdm/Hzm2ls11lhFOJZElzR3TRxcWng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IRLdjM1Tp42zPEUNnoAANp7r+uXPEoASlSMhumKXYtc=;
 b=PeVS+xrtELhP3Yxg7wLuIej9QWkwG4jAplm7GtZgZSiA6Fp3fAcpQ0PHMfnKufAZ4+yTCD8s//U0SDH5OsyT4YU3ohcxEnOTuX8IVQjWowQAkeBFc4TIgvv0qyx1yHixNtB+niWtdI236hHKqEZ87mfkN+jkGWUXGWhkmssnmRUNNUQ3uqQLBkbxrxFTEi3nAiMkAzdfvNFa9txjzYL9RjcqdFQN60ciNxCHcLRaDI9VtcItViDJuAmjRf6NSYgcdxkqX46Mc1ZwKXBqZVDUWXc6Q+bLJHfEaetSoue0rDNcP21SAeiCM0dLTd7T1MgTkBtIEtN/U4w1BdeFz3bPmg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IRLdjM1Tp42zPEUNnoAANp7r+uXPEoASlSMhumKXYtc=;
 b=o8oxDGOzIfzQ1IvSIotVPZDlEDnOjWcDVrqBp3gHCC5jbI0UD7gyodFz9oUytzEjJuiTSwO3YEV2fKDaRhlxWRP8WcX4eraVrUkeWPTCw5tPVskt+MB8FtuGLBkdOn0wld/F/hyGr0xoI+tWVFfAdnSFNZK03CECIm4rqAdBZT4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com (2603:10a6:20b:4::16)
 by AS5PR04MB10042.eurprd04.prod.outlook.com (2603:10a6:20b:67e::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.24; Mon, 21 Aug
 2023 16:16:54 +0000
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::a680:2943:82d1:6aa8]) by AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::a680:2943:82d1:6aa8%3]) with mapi id 15.20.6699.022; Mon, 21 Aug 2023
 16:16:54 +0000
From:   Frank Li <Frank.Li@nxp.com>
To:     frank.li@nxp.com, vkoul@kernel.org
Cc:     devicetree@vger.kernel.org, dmaengine@vger.kernel.org,
        imx@lists.linux.dev, joy.zou@nxp.com,
        krzysztof.kozlowski+dt@linaro.org, linux-kernel@vger.kernel.org,
        peng.fan@nxp.com, robh+dt@kernel.org, shenwei.wang@nxp.com
Subject: [PATCH v11 06/12] dmaengine: fsl-edma: simply ATTR_DSIZE and ATTR_SSIZE by using ffs()
Date:   Mon, 21 Aug 2023 12:16:11 -0400
Message-Id: <20230821161617.2142561-7-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230821161617.2142561-1-Frank.Li@nxp.com>
References: <20230821161617.2142561-1-Frank.Li@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BYAPR05CA0053.namprd05.prod.outlook.com
 (2603:10b6:a03:74::30) To AM6PR04MB4838.eurprd04.prod.outlook.com
 (2603:10a6:20b:4::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6PR04MB4838:EE_|AS5PR04MB10042:EE_
X-MS-Office365-Filtering-Correlation-Id: e5a26eba-8334-44f3-c2ed-08dba26208b3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: WPZDRum6Q//NMq8LoyCzHMCRAi8AYmM/8wQJZ/wkNcYjbQprv1y3bh9BtTufyFqwnGufCRr3WaAaRtSZmhrJTK0ss4otPAwmPIeqthgJk4i1LseOCVVY8CFAEoug2IJ1tHdKKkhxiInOhCE7FWuJ5EeE8JRlOHPyQ2TJPv+O4ZPIfxyX6EbDwSiZzQIzIn/HkF25OG+4nq3Tv0h4SQgJfoCKJ85Mmo9pct0Y8qbb2TNPZxDdupnd0shrwUzTGar2g+JXmB3g8Cna1vru5WhUnvU220NwIt5thBaG1EkNmaKZQfv9AfOwgM358yHzaM0PIxhub4dLwQNsagTGxTLY5GtL8xUmZ8JOve/DLcfPzCsKusjr5FcVC8XRF6+7YFi1A5O1I7BbMSOvuJ0KK3aQ+/tU/CS6wKZ9rqlf3NHNFhJoEH4mEj+4331osORnrSHVv5Swc9xZnJm1QVDoyOAChWdrM7TOEMUrDcZZKE3lZV859DrutXkLVFDkuneOvCOANKnIosgL9UlxBLgBgSatf8+F+soCoeyU2u1VpnBX64O7c1OFDa14mKm+GGMDE3GRe8YXV3d8zD5VHA6hbp0DMN+iUL5FSRTgJknC34Nvb1PCLmigryGDU21bWmZ3I0Yc
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB4838.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(39860400002)(346002)(396003)(136003)(376002)(451199024)(1800799009)(186009)(2906002)(52116002)(38350700002)(38100700002)(6486002)(6506007)(83380400001)(5660300002)(26005)(86362001)(8676002)(2616005)(8936002)(4326008)(316002)(6512007)(66946007)(66556008)(66476007)(478600001)(6666004)(36756003)(41300700001)(1076003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?9Jnr+8L+5ebf/7F9uEIJnK3MlII2VRStKo65iNjG6scx2kB0vi+qPla/6Y1l?=
 =?us-ascii?Q?LZA/7bg8NjiFuhC7yBw2ju8sgQeYZATL76rJ4P0DxDLLDzJsTMdDNQKOIe1m?=
 =?us-ascii?Q?jKOe9DJZKwySimz8qYd/9PwfPt3bTZQN9Db45wzRIkQmsZJgOWmaBiwt3ZJU?=
 =?us-ascii?Q?NeY+9g1890sw1jlHqY9qchem32mC+zc84vCC88rHAeFyb4i3ItCeYLLX6G/T?=
 =?us-ascii?Q?ZThtTVyTlmOEn4aVoemPftn2QvXm9L5iwUCmX+ogjXrY6poj4R9EVgcGAu4q?=
 =?us-ascii?Q?Okf2G9u8b2XbN8cR+bm2xD6YaQq4rghTVfzLbN3L0IDaIg73ui9kp5NCwvQR?=
 =?us-ascii?Q?WbA3m+5K+jttHliTODPQ7tu2ur1D/VXTNl7l8ol+2FCAdziaF0Q+s4KtF+pr?=
 =?us-ascii?Q?aBYSHheuk1uCIL/O5ylylz2t2JXGx3Zo64mY/7X1vjeTQhRgeaD7n7jDHvUz?=
 =?us-ascii?Q?SG2izpsH7bSPppDjS0lv/PaohM5pofNPTb5xDozxqxUcfAqa4RJqqzHpPHNZ?=
 =?us-ascii?Q?4uTlEITSb6OG3UE3qyzDH9bWuF8UqkQaan1AUHlgsvnCc5axjEhbsZNtpQdb?=
 =?us-ascii?Q?xiZLBjX6N7ZitwueYFRJcW9mwMz/pUhW6zjrBn5HgBdJPhzaG7vHT9Fx/IyA?=
 =?us-ascii?Q?vfuSdpeJJj6JjTwSgJVWByiN3LFQB+PaWLsmor23tuoc4helwMh4r+SUI9dj?=
 =?us-ascii?Q?FP22UvNy+5yhTOfriFBF6vSRHikLTpxB4siY1f9fGHaLkw0Ju4IG5/ZGeAtB?=
 =?us-ascii?Q?dM/SJfZt8rxt7ap3PCxTq3uo34dz31sNkLiQg10NGFgBGUufrAkRScDnioYu?=
 =?us-ascii?Q?kbMTPTHvBsn4s+5VjC2NLv9vujT/XAOFK2P7SEmE4MJ9jDIiuQQbdxrj9zv+?=
 =?us-ascii?Q?fWC6+QygekNRAg1iZZrk5mXS9aYm+4MxFvEqPp2TrpVW6E+MiGQtEBXNUnG8?=
 =?us-ascii?Q?wl8kDifQHDaUVxQSyylVAOtma1ntMQullx3MqRjY4BSIuv/J3KX23BpcmHSt?=
 =?us-ascii?Q?+XEZokHLw5arNkFklmQ+pvxGFJZNtiZhBLLiH5srvG6f1lDx2SE4uCLQwtx8?=
 =?us-ascii?Q?5lzO1JHRk/uf7FKxc5t0usfUHr7mSXqVsZ4G0T4UMaHGRLLqfmQHQqfyLax5?=
 =?us-ascii?Q?YhaFoXhZfIJxMiS1l2Z26pITKdVy7mqDmyWut4nHkf2nJJq/wcycJ5i4UYHk?=
 =?us-ascii?Q?6RP/eSsGBHGRMFTRBVGbDGwItVE9nt+XjSAHUBVlcPAoM2DnKQEvHaZVizkW?=
 =?us-ascii?Q?rpcyzkAqajuQoQnicbJtc308KJA/O+rTU7NB3wIcjaTXEKci4JXyBwfT88/h?=
 =?us-ascii?Q?080pRTxXBpKwd7UGYuipCf+v22C0CyxPWw9Iq952WNH/L1pnMjIWfdcCM+On?=
 =?us-ascii?Q?iw7ABcSTD8V3pV/8R19dx+9aSI7B+lMPqxNHr9xGk1oxczX135nja9x4uzmX?=
 =?us-ascii?Q?WN7ssqa4An5M/ZPj82ZFpUP4niW2k71ZZgKHDQkyQPxlcAP/NZV6WsBAjwOK?=
 =?us-ascii?Q?YxOF2zUVp+PPzcraWbiESBC7aAqVh1VEO12pJIgKO0YDKTI9CFOUMdvL97Tr?=
 =?us-ascii?Q?+Q3OjbHTFcCnyq35gf0=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e5a26eba-8334-44f3-c2ed-08dba26208b3
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB4838.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2023 16:16:54.1061
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0ENRVnQS+BcVNSwc4Q5AYU3uUdDnU+qGvCp07LdDQN2bKel3CTBYJRUHIj1qQWwBua+QlGDyn/YOdLJAzHhwPA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS5PR04MB10042
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Removes all ATTR_DSIZE_*BIT(BYTE) and ATTR_SSIZE_*BIT(BYTE) definitions
in edma. Uses ffs() instead, as it gives identical results. This simplifies
the code and avoids adding more similar definitions in future V3 version.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 drivers/dma/fsl-edma-common.c | 21 ++++++++-------------
 drivers/dma/fsl-edma-common.h | 10 ----------
 2 files changed, 8 insertions(+), 23 deletions(-)

diff --git a/drivers/dma/fsl-edma-common.c b/drivers/dma/fsl-edma-common.c
index 2b91863502d4..e0f914616c5f 100644
--- a/drivers/dma/fsl-edma-common.c
+++ b/drivers/dma/fsl-edma-common.c
@@ -154,18 +154,13 @@ void fsl_edma_chan_mux(struct fsl_edma_chan *fsl_chan,
 
 static unsigned int fsl_edma_get_tcd_attr(enum dma_slave_buswidth addr_width)
 {
-	switch (addr_width) {
-	case 1:
-		return EDMA_TCD_ATTR_SSIZE_8BIT | EDMA_TCD_ATTR_DSIZE_8BIT;
-	case 2:
-		return EDMA_TCD_ATTR_SSIZE_16BIT | EDMA_TCD_ATTR_DSIZE_16BIT;
-	case 4:
-		return EDMA_TCD_ATTR_SSIZE_32BIT | EDMA_TCD_ATTR_DSIZE_32BIT;
-	case 8:
-		return EDMA_TCD_ATTR_SSIZE_64BIT | EDMA_TCD_ATTR_DSIZE_64BIT;
-	default:
-		return EDMA_TCD_ATTR_SSIZE_32BIT | EDMA_TCD_ATTR_DSIZE_32BIT;
-	}
+	u32 val;
+
+	if (addr_width == DMA_SLAVE_BUSWIDTH_UNDEFINED)
+		addr_width = DMA_SLAVE_BUSWIDTH_4_BYTES;
+
+	val = ffs(addr_width) - 1;
+	return val | (val << 8);
 }
 
 void fsl_edma_free_desc(struct virt_dma_desc *vdesc)
@@ -623,7 +618,7 @@ struct dma_async_tx_descriptor *fsl_edma_prep_memcpy(struct dma_chan *chan,
 
 	/* To match with copy_align and max_seg_size so 1 tcd is enough */
 	fsl_edma_fill_tcd(fsl_desc->tcd[0].vtcd, dma_src, dma_dst,
-			EDMA_TCD_ATTR_SSIZE_32BYTE | EDMA_TCD_ATTR_DSIZE_32BYTE,
+			fsl_edma_get_tcd_attr(DMA_SLAVE_BUSWIDTH_32_BYTES),
 			32, len, 0, 1, 1, 32, 0, true, true, false);
 
 	return vchan_tx_prep(&fsl_chan->vchan, &fsl_desc->vdesc, flags);
diff --git a/drivers/dma/fsl-edma-common.h b/drivers/dma/fsl-edma-common.h
index 242ab7df8993..521b79fc3828 100644
--- a/drivers/dma/fsl-edma-common.h
+++ b/drivers/dma/fsl-edma-common.h
@@ -29,16 +29,6 @@
 #define EDMA_TCD_ATTR_DMOD(x)		(((x) & GENMASK(4, 0)) << 3)
 #define EDMA_TCD_ATTR_SSIZE(x)		(((x) & GENMASK(2, 0)) << 8)
 #define EDMA_TCD_ATTR_SMOD(x)		(((x) & GENMASK(4, 0)) << 11)
-#define EDMA_TCD_ATTR_DSIZE_8BIT	0
-#define EDMA_TCD_ATTR_DSIZE_16BIT	BIT(0)
-#define EDMA_TCD_ATTR_DSIZE_32BIT	BIT(1)
-#define EDMA_TCD_ATTR_DSIZE_64BIT	(BIT(0) | BIT(1))
-#define EDMA_TCD_ATTR_DSIZE_32BYTE	(BIT(2) | BIT(0))
-#define EDMA_TCD_ATTR_SSIZE_8BIT	0
-#define EDMA_TCD_ATTR_SSIZE_16BIT	(EDMA_TCD_ATTR_DSIZE_16BIT << 8)
-#define EDMA_TCD_ATTR_SSIZE_32BIT	(EDMA_TCD_ATTR_DSIZE_32BIT << 8)
-#define EDMA_TCD_ATTR_SSIZE_64BIT	(EDMA_TCD_ATTR_DSIZE_64BIT << 8)
-#define EDMA_TCD_ATTR_SSIZE_32BYTE	(EDMA_TCD_ATTR_DSIZE_32BYTE << 8)
 
 #define EDMA_TCD_CITER_CITER(x)		((x) & GENMASK(14, 0))
 #define EDMA_TCD_BITER_BITER(x)		((x) & GENMASK(14, 0))
-- 
2.34.1

