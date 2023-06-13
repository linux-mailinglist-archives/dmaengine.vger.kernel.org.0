Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A1F672EDFC
	for <lists+dmaengine@lfdr.de>; Tue, 13 Jun 2023 23:32:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229559AbjFMVci (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 13 Jun 2023 17:32:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240543AbjFMVcc (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 13 Jun 2023 17:32:32 -0400
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2045.outbound.protection.outlook.com [40.107.22.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 803131BDA;
        Tue, 13 Jun 2023 14:32:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aCy2tEHFLj+40uHRvdyPPIih71WIBv6MjNaxhSyGn//WqlhChloCDCfZ2yufghezPgl1a5epfm6nJcb2kGC2SrI5rJtaD+M79WrZ8QbcSxlewCjXOrWY4P3ZST8NwJTERQmThGqRyMbtyGD6ga0irdiXPXiHzt67nNeLPEHzRpwasXpTE7z0NzOAqKyk/nsQThGKeqfJ4qntWWuitzORnXYVlzrFBUvVZsF4ozrRnG5yAkx9pZlo27Pt3dZ/XCbAOIXhcNcyvXYWH74BybmRNqGl3ffZvE5xLBJO2aB4Z/acWsjlXrCLSqjwPe0C1Rjqc0ukp4uif2IOYfBTkMoJZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=s1+6nOaISVZ89Qy4+Cr3cnXLzqMpnDganBMJUwxpjWY=;
 b=k/SLl93AyEpw0Zk7npZXBqPedscSpXs8oQvKlldYrEYamUiiySRsKNzwdffk609gp1K8HD2heBDVOP7PY5JNCvlJ1G/3YAzg6RO07yE4/lBIeSa6/99uuYNx1He83zN3GXkCfkg6M9YtxsISm9bLaf20fNM3ySpqwm198Z2sQa97/PIA5r/jDR0gfg2vtfPOsdBmlPuBrmYWbAzD62dEfo2pKOVUlYB3fdJ65jaOiMyc8BcV+ZVN+mLDgO6XgLk59lWw4PdWkc3o5Z1/CivqMbpvYLu1wARI/qErkda4+TpzT+IF9tRP1K0gkccB3pxxZe6GZSG7yx6RePuUoX5U5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s1+6nOaISVZ89Qy4+Cr3cnXLzqMpnDganBMJUwxpjWY=;
 b=JIgA5PXicYADmHeKOhGiLCcHdrfgqI2plzTxfdJoyocTng7hRkJIVVHtHp35uFk4QZdh6pjpTQLKqTYjPJrMmk/XZ3JfoqokIyoHWO0bGtb+XR+JJlCcIPGF8zZFTXiS6kCBp0aQ/Dq+v87dCce1Zks/jR2xSf/hTD5BmDCFesw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com (2603:10a6:20b:4::16)
 by AS1PR04MB9479.eurprd04.prod.outlook.com (2603:10a6:20b:4d7::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.32; Tue, 13 Jun
 2023 21:32:23 +0000
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::4a2a:262e:415f:e41c]) by AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::4a2a:262e:415f:e41c%7]) with mapi id 15.20.6477.035; Tue, 13 Jun 2023
 21:32:23 +0000
From:   Frank Li <Frank.Li@nxp.com>
To:     vkoul@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, dmaengine@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        peng.fan@nxp.com, joy.zou@nxp.com, shenwei.wang@nxp.com,
        imx@lists.linux.dev
Subject: [PATCH v5 06/12] dmaengine: fsl-edma: simply ATTR_DSIZE and ATTR_SSIZE by using ffs()
Date:   Tue, 13 Jun 2023 17:31:43 -0400
Message-Id: <20230613213149.2076358-7-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230613213149.2076358-1-Frank.Li@nxp.com>
References: <20230613213149.2076358-1-Frank.Li@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BY3PR04CA0003.namprd04.prod.outlook.com
 (2603:10b6:a03:217::8) To AM6PR04MB4838.eurprd04.prod.outlook.com
 (2603:10a6:20b:4::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6PR04MB4838:EE_|AS1PR04MB9479:EE_
X-MS-Office365-Filtering-Correlation-Id: d1f709bf-0787-47e5-2a0f-08db6c55ad37
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: cFMz0K7jMGVoTDP55L4l2G45vmlO5fTUmSEzVkwno+Gd+avXSGEnG+dDAmFOG3FSZxhutc1z/3sQm8J7G+mdEiH/7PBeBKoGTJ4rbEbvkOHFsG1Z62rWXfGvF/nSFEXvIXQDFXE9GI2T2ui1IoBFhyTMtCfvQJpU/0kPtZ4yKfqbKwkFE73DmswPR0qTQQHeQIRUAgsIy/g/L+WQoXbiW95R4rXbqKn17wW6RmQxcPGlZFeCMA53DzB7f4LO5IaPSG3QGhvliJBxv9oDm/qPU8vVwcLdNZgKcoPK+KwlwkX5f7mFzJD8Is85/XJyvDVh5M9L0lIArCXy+BBLpZxm1NzRLu474WRwaMEPY82dCs8yMIaZFIZPXILbZz2o6VmZ/fpzb+8KznDLcl9X2k/1XzQaTGA7LW722SNLA4KwqgNV3AjBufurieBlDhZIKT+5ZPH5sz8W3vL6FOsWNyd/Y3f7iGUYVFQQpK3yY1NeZCwAJskCAociqsjwV2vn2i5m4vyYJSUAqwBF07py+nTAFfOtO2VNZKEjNPC2rheZktdRuBCbZaXPa2T8iPkJAcxlNgAiob9dUK9VmQjCsk+WkctRN5On0rhys/ohV9r97AnPmPW9Otn/tA/pN23nExce
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB4838.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(136003)(366004)(346002)(376002)(396003)(451199021)(2616005)(36756003)(86362001)(66556008)(478600001)(66946007)(6666004)(66476007)(316002)(6486002)(52116002)(8676002)(41300700001)(2906002)(8936002)(5660300002)(921005)(38100700002)(38350700002)(186003)(83380400001)(26005)(1076003)(6506007)(6512007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?rIDKMIKIlGWH9S4kvPvvrrfq+Tlh1Kuk+L4gOh9SPAcsYiUfwN51GbRXeiSj?=
 =?us-ascii?Q?KLAx+xIUwvYO6hFJBUbi20DB6syBXzruGWHO0k+iA8OTtAIZnnLuQkYGiuqN?=
 =?us-ascii?Q?kO11Ozc/sQmhlJaek6VxZqIzJkaagHShkA0DOQWvNkbNK39eHJxoTiJAAiPw?=
 =?us-ascii?Q?zbEev+lnEicYh2wnbB6QcIVpljZb248psc2EPdrJ+HF8pFSP5gnCuOUSjzzM?=
 =?us-ascii?Q?xPe7bV0WrmT0b8Fdn5gNav4do03+zHsM5gvCNQ4OLlnF9ccZ6vEHrhfqxHQ5?=
 =?us-ascii?Q?ZPUFyV5hXXEC6riTwBpJoCqjwgomWEQCPkbe3loIWk5+z7APPEBP0JLnJOD7?=
 =?us-ascii?Q?kJNIxgwHBj8KFAnG6tiUy4ykL1btFuZ+OFnQ8DhQtaIc3gb8q6FQLYedrhWq?=
 =?us-ascii?Q?sSHEv6xH+TysKB/mPapazGvio7pfmtcv6zqLhmboLuUPExakdvUTfbcolRAm?=
 =?us-ascii?Q?iLbiFYeaKQth3117Vss1qsb/oR93zuH8hBQ+n6yxUcYtoECWCV1nmTsOgA0o?=
 =?us-ascii?Q?njQ9K1mEenzj8CgNuDUrr8PS4J8oOpJ5/jpvYqPLb3H6K4J0USkRl0RqHERv?=
 =?us-ascii?Q?gZ5cQuMRySsNQUtwhBjc2TAxXl+MPRXl9TfuWkyvWvqjGUv2AwL5S+lI0t82?=
 =?us-ascii?Q?zI12eMplAYnm2IqTrlMkzSeQIRkWNy9DZJ3vitN0MOibnkBWDm6BYMFEB0x4?=
 =?us-ascii?Q?4a9B6Z2PjOXQmV7r3IiMahmdV9Qvx5JLNOo6RzkYqWz8iMQbSKRNHo3qGfS+?=
 =?us-ascii?Q?IfPvuo0JLH3yVnxPlA7xLvA8lAF1IeB1kuXh/XJdpJg9pEKD33paMdSTiU8f?=
 =?us-ascii?Q?0dgHvzxCld1hnAqkwrVVgMts/eJE+oXZFMGPeu1fcBRplo+63xoXLLZwWmXT?=
 =?us-ascii?Q?pqysHr142FPcdQD5K+8EZhwmUC2/21j9n0dmFZ5v8F2dn7NH+LRe+/SWyFgn?=
 =?us-ascii?Q?dL8dadzO5QKEemRedGbL83kQgF9uKlYAdL+aa9hEvjCOnBu+ZFdrjFEOmfmD?=
 =?us-ascii?Q?QBTV542IX/JIrxNcNBVd8LEpsr0j6XBw3oWbYLGyqQE44IHSceI26kkGa6nc?=
 =?us-ascii?Q?JtNhNbj6wHyzjxNhZJasAKqW/U4ehcjzWGM+MzcSUN3tgp9R/qiRGz6KqFK7?=
 =?us-ascii?Q?2q3AGbKoRUFUpFLiIbZ3Cn/g5M/YkTG6BfoMT+PO5Vu7TYAKFJOIGa5SBPED?=
 =?us-ascii?Q?sdY3cXrJNvGbQfHJWK4GRJ4+JcctVZoTDpwuSsxTBLilenD8NUhrPDB5VZ8P?=
 =?us-ascii?Q?XFScToY6IyE4sUKaXrpAeixI/48RRPQPezU7KPKFc5InXQl7xQfkhGt2QQfv?=
 =?us-ascii?Q?b9fLj6sDY0pgC5ndZhyXr1acFWt86hk1WkPf4zRf+m+MfagG1jFSHpWLB5J+?=
 =?us-ascii?Q?bAtK92wUpiejoRUvWqiyWaPkb+f8szoDgJZq9YnHc9C4/54zTLfzS0uOhWi4?=
 =?us-ascii?Q?k8RDnMmjlFGLyJfYx0XoE9Hb0AM/2jEiKfzgA8c70qxjomJwoqmoqMq8fEcB?=
 =?us-ascii?Q?DVebIP2+h7nEtxBHjt/w+k9M9d7sX3Y5QyhV+wKhsR7Yn124vVCz+Q07kGJH?=
 =?us-ascii?Q?UdI6/aPvRjfLoW2661MZFNG3RuHXYkPQZnIVgtJ0?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d1f709bf-0787-47e5-2a0f-08db6c55ad37
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB4838.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jun 2023 21:32:23.8442
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wAqWH6VmpRbU/EHhKoQo/tVGPvyQMuqF4s1t/BU9rW6rzsEkRl8IZfe+Eyp2i0+DhKoqvV++eTsC6ol/XLxLoQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS1PR04MB9479
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
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
index a9d17cf142fc..51fbd7531c74 100644
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

