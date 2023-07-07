Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4315A74B6C2
	for <lists+dmaengine@lfdr.de>; Fri,  7 Jul 2023 21:01:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232847AbjGGTBd (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 7 Jul 2023 15:01:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232577AbjGGTB3 (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 7 Jul 2023 15:01:29 -0400
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2049.outbound.protection.outlook.com [40.107.104.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E841E2709;
        Fri,  7 Jul 2023 12:01:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nlAIhfWmaeb9mLTRsXjM9swH8IBi/s5m8pHahT67Diynzt+VRLtI6lDmUuk2d5UgQEcqIUp1Ft+XI9uH8OlurYyGXNUssA7AUUAwz6n3eRCk13YAykotd+IT17em0HL0B5EA0BmbDv2IIas+VCRNRvkq2cWahSIFnCeM7ORJF8a0FzMKAG/hxR3sZxivHgx2+c2JWGmS8sOZaomoNWa+OkkrUKTJMWpjf5drBizUTP/3Aj1DzIRY1kkWYxpynSRIpPCJlHBH0K5KCF9Js5HRdV/qIPYNIxv2ZIF5JmwBEz3k2wz5EoXPalrjumbWeEBS7CgZbIrxhvlVzPOuHiushA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IRLdjM1Tp42zPEUNnoAANp7r+uXPEoASlSMhumKXYtc=;
 b=Qvn6arQaMW3mCL2tCr7th8H3Dun7jHqAXMWMtCzC99Bg5hLnwCLhddK168XXSwNHobyFR1HMs6c6NIABR4LJv4/hRSt7cXj1XZoF18dSNYht7pukjAoAKv9Saev4KgxszV5/KXdiKbGSbaBd/xmcYutdduPLCmgXumm/UJx9jvV9S/xCjLI0mvp28CRKjM4uhwQNHm/Gswc/qW49+lSGXi9LzznqXC1TBScKmRO3mjsAw9FkcFLX79WMRyeP5HVL5QTkaCDh4Ixea9/ngTv4u85Aoh5XZqyMicJ6+mD/thluuqYKLB/HSKSso7E1oa/j11EVmd1qFrHyqdHryH6EiA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IRLdjM1Tp42zPEUNnoAANp7r+uXPEoASlSMhumKXYtc=;
 b=ClYDRqFsDqklSd7aG8blf2svL0HuUSgtP7YvmzQTsrGmNbItxFCWT9k+OlAbDO4FSoTKX63FsWpyo1WqZSfaeTyI2ZsIdJvMnxcfIlhQD1ma0KMF6abewG/5gpLzaqjUz8U5A9sFRigQ87flo8fTfQgZDnKFSH8HP77Vg4yEDS0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com (2603:10a6:20b:4::16)
 by AS8PR04MB8612.eurprd04.prod.outlook.com (2603:10a6:20b:427::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.17; Fri, 7 Jul
 2023 19:01:05 +0000
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::4a2a:262e:415f:e41c]) by AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::4a2a:262e:415f:e41c%7]) with mapi id 15.20.6565.016; Fri, 7 Jul 2023
 19:01:05 +0000
From:   Frank Li <Frank.Li@nxp.com>
To:     frank.li@nxp.com, vkoul@kernel.org
Cc:     devicetree@vger.kernel.org, dmaengine@vger.kernel.org,
        imx@lists.linux.dev, joy.zou@nxp.com,
        krzysztof.kozlowski+dt@linaro.org, linux-kernel@vger.kernel.org,
        peng.fan@nxp.com, robh+dt@kernel.org, shenwei.wang@nxp.com
Subject: [PATCH v10 06/12] dmaengine: fsl-edma: simply ATTR_DSIZE and ATTR_SSIZE by using ffs()
Date:   Fri,  7 Jul 2023 15:00:23 -0400
Message-Id: <20230707190029.476005-7-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230707190029.476005-1-Frank.Li@nxp.com>
References: <20230707190029.476005-1-Frank.Li@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BYAPR11CA0067.namprd11.prod.outlook.com
 (2603:10b6:a03:80::44) To AM6PR04MB4838.eurprd04.prod.outlook.com
 (2603:10a6:20b:4::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6PR04MB4838:EE_|AS8PR04MB8612:EE_
X-MS-Office365-Filtering-Correlation-Id: f79c4080-b55c-43b9-0f27-08db7f1c83f1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: an/tM294jri15ajAlVNTvV2D+D9nWU9km5rzpTgEUOCmKB9N7uDbRtkmWMpfIe2g1VPP6ewodDthfTms7m+VPog1jqxV/iLpGm3UcXiS1lJ02QyGR75u5XpMxM3Ly43RWMsJrhR5UogOwqgsFxmAj51CLh3M1rMZSyxSY7UZYT2rOLJ34xJwdQDAPk3C5PQClnTWR/S3HHW/qfRQnBt4bgAxZXM98N5xNQR4+PXp1IRbtmOb+Yu+GHRW7C8mfFaueXycBIqQuSCDwW+T1AyqHcR4lQlEHD4CKdArl8r3AjZsAMTdSCU9S1JR4fLiTX1OoywrsC1ryK4IrpgAcp6tKr6/Pous3gYw9vCam6zGOSCY7UkPvMRDF0/pRu594ZnDdeUcYcOW7xXWs8CmD7bjdEI1oPtWJxtfGrnUt0Jr+vPTbVYBS98fhh2ZatKhbgmpySiD5qqZL9FUVbrTYx3c0j/bdXnb+41wh86vR9L0/odJV730AYvGpwMb0dlIoPBJozd9N59P3fKmPeSmngk9SS5+Ywy+D0dFd64gWS2EaYKx8a8nXgr61m1xvF/7CtDbfUuL/5nC0UVDiiS+0yJbt6xA7y+NFUr4W9DNxw/7RzsHWH4YyH13DXtciAy3RbW9
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB4838.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(376002)(346002)(396003)(366004)(136003)(451199021)(2906002)(5660300002)(2616005)(86362001)(66946007)(8676002)(8936002)(66556008)(6666004)(26005)(1076003)(478600001)(52116002)(186003)(6512007)(38100700002)(38350700002)(83380400001)(4326008)(316002)(66476007)(6506007)(36756003)(6486002)(41300700001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ga/XsqM02IG/dhKuryVd4tbKTagvTint63vVNji+mWEt15EPvDsdGGEgarP1?=
 =?us-ascii?Q?w0OeLGY1nMCm7eo+iCctsvSEio77/HBTD/5xX/GMtUUVAckQxfOv5lgyHKR6?=
 =?us-ascii?Q?jwvqIKrvZe3fA6bzu7AMSgXDCcHcO345aVXfQ9vQZmE24POO3EG2lVxITOwr?=
 =?us-ascii?Q?UAGuuwOhcYGuDPuBHMPFMlVblxLsgbQTiyE0aH9L8n1P5ZpYP4rciCqmLU7f?=
 =?us-ascii?Q?zZs4ZY+K0z9n81m0jLgCAqKVHg70erbproyESVsBQ63wmwEEJ2qwWtpQufPM?=
 =?us-ascii?Q?AVaAgaabdnH45KRoAPmrQ73AHfN2lnCfejWJOpH82/gWkLDmzIVkbftfHElc?=
 =?us-ascii?Q?tCiOKHG1/oYw6i77aZ19HbVfAleVRqv/+dNTnrpWK939MhSr1gZ5SfKdDMI3?=
 =?us-ascii?Q?rsXVGvil0yqfM7yi1s6UPWBOIL/MLlhCSF4uB6dbzF2PbUelLV50uUOYj3Dk?=
 =?us-ascii?Q?6o1Vj/FWth58iqCL5qJzw0Jf3mavb/BdyBPyakpxnv6ktXbUmrChdim6JmCQ?=
 =?us-ascii?Q?qFzpOT2R8gchpgv2wcDZZpgcfH9wr0rOqKBJ9zNVENaZdxWBcm5sq6RrUwaV?=
 =?us-ascii?Q?rmmbuY3q2+gt/3nqhvAJc0MziHDIS2A8j/3+Ts+/Ubi0qVk0ijoRefbKAMDZ?=
 =?us-ascii?Q?aCKZF/AXYwOAEqOoSCqXelzwkMSAbHK/SfXWngOgR9URTbrCaea35H5KGESn?=
 =?us-ascii?Q?5VgtrE+S4xAAxqu6GPfnBtOmA+9oBMFYrdqesWQArVw14qaNWFDTTycbb8+M?=
 =?us-ascii?Q?dwuNxX6dJablEvGyRUYNR3Mn3mRn2c8kHySGg5l9Yb2Cfs2NQh5A16pWGRqu?=
 =?us-ascii?Q?v0ieA6HFz6cXsapPEJwAOPjmgSugsjJF1hsPz8xqwoRHwM0nYfALuIuwqgHd?=
 =?us-ascii?Q?L/11M7wp7S2ui8VeItUWX4CnpVNdxqGuVMBMefYin8nfL2hXnHkD6OQuUI+4?=
 =?us-ascii?Q?LF0jLFKLY+0OFihB5zN03j02bnAql2TiOV0xc0zT2WUW584g1k5D+0SzRFDQ?=
 =?us-ascii?Q?tLXt9z6ue6iNf0nn2kyJctIHZRPcVK5GR/0CEhMuV5JzJLAJ+dR50HkC9NPT?=
 =?us-ascii?Q?fFZK2Q7KB4eWXtuZXiEeqENKtpHCdq0ZGs3nU9etuN8gHnchwaojsy1AC8bu?=
 =?us-ascii?Q?2RKo7pWhKsr+K1kVzh3thI2mzh7gNQeM01+QtRdKxKsyBc3BqjNsDUaW7Ora?=
 =?us-ascii?Q?/ThmtwtSjwdQjU/Po+LRmKE4l71a/JCaN2BOiVxTCTYWTmvFSbMidb/MO6JL?=
 =?us-ascii?Q?IcYaDr5h+lolr3F2/KWRoOi5C66HB8LNl5Ur5C8M2lhsBxFGC4o6/+E2ILat?=
 =?us-ascii?Q?lsbfGZwPyHyX37jXFCLmCyBkzo9mNwSNFBcNJMMVHJcqfA938Ct0Z2wNyQmI?=
 =?us-ascii?Q?suc7Ypf6kvO6dr2Ub860khgqLOlCPW22Ag4r5Bhrc8XODFgoZTnk0mvDp1q4?=
 =?us-ascii?Q?ufZnz277XSqSPohG8FqBi5xK/UP+0SmVICxXdqd/3l+VlL9iS8kCd12M1hSa?=
 =?us-ascii?Q?Ikmj6DBlndo63o19O7soaAc45BnIJyd7vCfLyHln40vbAbFDiBVmfa6wWADt?=
 =?us-ascii?Q?n+TIAEgyfrf4FaF/0UE=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f79c4080-b55c-43b9-0f27-08db7f1c83f1
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB4838.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jul 2023 19:01:05.4397
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DYTC1E3AVcU2f0RNkSl43y1Iy9L9GbgPIgtrSuQyxeTjslDTXLpcVxEvtkiRfj/pUdbwYD5q3V6MUx+pO7nOKg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8612
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
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

