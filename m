Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D81D27375C5
	for <lists+dmaengine@lfdr.de>; Tue, 20 Jun 2023 22:14:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229725AbjFTUOE (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 20 Jun 2023 16:14:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230202AbjFTUNl (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 20 Jun 2023 16:13:41 -0400
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2056.outbound.protection.outlook.com [40.107.104.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B73021981;
        Tue, 20 Jun 2023 13:13:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=c+RrcQAN2RPr8AYHCdbMi6vwFOtGQZYrduxDKkFdUzm+kw9aoTRIZ+Dw/zbl3w40Dg9AW+DOPOxcgikHQMI1thop5jXSQZffCeSBNIyZcerNNf7yh2zNnhacpOvId1lDidJkYOZnOLS2qmwAFrAT046cBv0D1pBtae5WgAncq7Nf5BKGeFkxilBJ9VCctLqbz4whpYkBk5HpjyIFrycAMKYm+AKVkULIOx8kcOPKJ7cYd8DGPTMZO0mRB6UUxFtDn3e42ecEga+1fWQkBz33tbQ0dTezYl5BQOeJhhGoYSJi8VrisWToYtcOLUlnSMc6Mq5bkmxpTtAEAcyXLzbE3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=s1+6nOaISVZ89Qy4+Cr3cnXLzqMpnDganBMJUwxpjWY=;
 b=RHiiNjN24j1qN3BOWszw/RHm4McCKeMkldkY9VwTnY7Qi00qpwjwwmy6z2K0qUVj07gdPaI9RJl+29O4aFfxXBzF9b9BcPqvIz59R1ezyy1kgZY8Jl/JEy/e9qtSGutt2ix9Im1BAIdbrFmXs25btQ0RMkMy5CBAQ+mYYaY5pdjBN7O1oxbApFdKts3WMS+RXqljLF1Pdgr8oPR3Nnu+xlirP9JSmKYnOAD4bq0hBwn1bH/gcjaEsbI2Sf3MtGESm9y7kSaRUkNCxEvJfoHgAjU2YVqkOSGjl3WBcPhR8flkIC5TEt4KY3iyO81tWr6zXDQlb5TlfIYaAH0oAoiFhQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s1+6nOaISVZ89Qy4+Cr3cnXLzqMpnDganBMJUwxpjWY=;
 b=lJ/OpBVpjdfrAoyViAHRja7g7Ug/CGR3j7a/FaTrbB+oL4PdowY8SAzK1wGAj8cvR1C29M68KbqTPBIjiJ38X8J8BE117/+dd7Hvx9o0Qswv3E0F5D4nyWhTB+Yd2ge1cPAsd1I6Cd9Lgos0Co+/ox9/dEnl2Mgt1LJgxn4kHpY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com (2603:10a6:20b:4::16)
 by DU2PR04MB8903.eurprd04.prod.outlook.com (2603:10a6:10:2e2::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6500.37; Tue, 20 Jun
 2023 20:12:56 +0000
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::4a2a:262e:415f:e41c]) by AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::4a2a:262e:415f:e41c%7]) with mapi id 15.20.6500.036; Tue, 20 Jun 2023
 20:12:56 +0000
From:   Frank Li <Frank.Li@nxp.com>
To:     vkoul@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, dmaengine@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        peng.fan@nxp.com, joy.zou@nxp.com, shenwei.wang@nxp.com,
        imx@lists.linux.dev
Subject: [PATCH v9 07/13] dmaengine: fsl-edma: simply ATTR_DSIZE and ATTR_SSIZE by using ffs()
Date:   Tue, 20 Jun 2023 16:12:15 -0400
Message-Id: <20230620201221.2580428-8-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230620201221.2580428-1-Frank.Li@nxp.com>
References: <20230620201221.2580428-1-Frank.Li@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR13CA0086.namprd13.prod.outlook.com
 (2603:10b6:a03:2c4::31) To AM6PR04MB4838.eurprd04.prod.outlook.com
 (2603:10a6:20b:4::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6PR04MB4838:EE_|DU2PR04MB8903:EE_
X-MS-Office365-Filtering-Correlation-Id: 881b9c56-9c36-48fd-7fd8-08db71cabcab
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: eifTkMABSGLHxzgmL9iByqj0Ueh3tlq+rsaNTrrah8zcbrlv5uY0XVzyeR6HCepr5jVcPAag1L8OFy1hkv92itJX6806KpJ06QaUgXPYZjgEoNnArpN+ysao5AHOWazk14G33Q1PP3Z+N1lywoyJePaBcZj9Ve2rejD0qAzsnD/qYI12NQF7F/eyEAhYst1lE5J3q2hkSK5HukW4eJa189YeRo9GxqSYvI9wwkVD0Kk+Y5Tst9vzjn9AwQpD/bRTueWkdHbXwk6W7lXmBoiDIrao9PgtguCzWtV3eWgeCMDg0dB9wYYRy3oC6vsImFpsFOlsRrjq+9M0RBrvTtl6kUgmGKMu3y7K8Emhb9k9bPdCEM1xlaZLE7x9udJsaJf+PCo3Q9NF4kZzgKZsDs6e72Ocsg1hRBUGluo5WuMIGUhmCa4T+xG6SiocbKBmm1hF8wAR/99976YiuOve0EazRVlNepTMDdjqjk2rF8vhFRLSOcmP6Ke9sG3DNI7F06KAp5w/5sIiUgytdLdERLTe9iXF6hoC6BrTV6Ss9AuOr7syhZBpd9D/duDclyoSdQ2wM2E5gyH0kREQ33qvWuKiR1Rvc6MRfkpiVIsDVFg+DzV96Gent5Uzx8Au63WBBjMz
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB4838.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(39860400002)(136003)(376002)(396003)(366004)(451199021)(83380400001)(66556008)(316002)(41300700001)(66946007)(66476007)(36756003)(1076003)(6506007)(2906002)(8676002)(8936002)(5660300002)(86362001)(38100700002)(38350700002)(921005)(2616005)(6666004)(478600001)(6512007)(26005)(186003)(52116002)(6486002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?D8Qh5pYVXJsr9FMiomLue7XNYgeY54UJItw2W1FGqq3GF7HKgNBznD7dN7uy?=
 =?us-ascii?Q?sOO+FWjAcVRnBG6X0uG+sAEKneF/nnCa3GR5+vd0H7eg2k22RdaXztU48XqX?=
 =?us-ascii?Q?h//iOgZBGCaQCV1aCX59iX26NwIvWyaH8nekV6QFGobpB9fgXl23CLqM4UPL?=
 =?us-ascii?Q?87ZGG+QIFxx8ttqJKhktonNjDAr6LGRtETAEeb2MM//x6SXcjDZf2LQPu1d2?=
 =?us-ascii?Q?RC3/rXnJqE9WUK2kNikUCetFCwOZyX708UVZrJplpHs2saPip3QBZ/JA/ycD?=
 =?us-ascii?Q?Tk5Jp0NfJPJ5U3w3C6GkSLadFnqBrrWBoaaujBYltCqsuXSDVVMv+8bgVd/X?=
 =?us-ascii?Q?PxkE//UViQTyD3P/XVcLdBv9ph9J2VB4NEcLDDcixykfw/kDOSVSyrDzKWyS?=
 =?us-ascii?Q?oYjL0rM2nyjqqcaYC1hml8inp5ZZ8wLyzBt9/0F4JkHJLGxDTPFi78u/7+5i?=
 =?us-ascii?Q?g5MliJM/0DX8u1JnugDz6+RIJdmqqRno4lWD2yTo30ESvLcsxRfFTqrwppIo?=
 =?us-ascii?Q?+bLGomvghp+0lwmWFm/6lxQvOFWxPFqRw1kzgof30Gc5HizgaJsC7jhijpUA?=
 =?us-ascii?Q?q0RnyTrK54HWcXgHvpzhlcYN/k57msI9ulBzi+YbKYfLjpMrbT/MCAEMi/iz?=
 =?us-ascii?Q?gTAcZgJqP7dt6uqoOivIref0VW8pKh7xom4T/j9yxtPEGniFCS8CqPC2xUDX?=
 =?us-ascii?Q?Prd8E6DXAmlbIxLxnG1HH+lmtLf246cVLN8dsj648peRWOQj2k+SCaLQD1+c?=
 =?us-ascii?Q?JsQ3gQz68z4NuwWjgTE/QWF9vInMcCzOKeyxZ0+ZpUa9aEch+F98KCDfk7SS?=
 =?us-ascii?Q?Ns8qHqvIf0Xd8Tr05MCyc6FfMKKo7z2qDNf9NOIXlwgsigKEvJ5o3Sxe3H50?=
 =?us-ascii?Q?yukYv6kG6HfDkqoubg8MOpgopmC7TVTuvMXdg8pHcWmBdzW4A4Q04w6jRL6/?=
 =?us-ascii?Q?3uMxCbkRwjdnpq/rxG2BdkdV1ePAsqPbVcfFrznI2FK1Ar+lEhNgMMZhICwU?=
 =?us-ascii?Q?fIfujQcg/O3r0FYrWj6BhJArqjogVf6riV5xlAHQYNBKALyYe+wVa5vR8lzh?=
 =?us-ascii?Q?dSXkNfJ5ZNLhTj88fD7N4C5ajp8SORjtWvO2SVn7oDpLBJ6R2EArIrC7V+C0?=
 =?us-ascii?Q?n53Ynsu3B7+8WpOTdvGXDr0fsrz0bsfLBMhy2HqIRfFroNRTdIMqmtILE7V4?=
 =?us-ascii?Q?wCynt2Zr77QFLjaYRtdhKXdyU7lPqIMf72PJamZ7U3eoyDsvECxfbHTOg8xS?=
 =?us-ascii?Q?2o05mRIxCArGPZTi0WPGgKEelWyQ4aC1yzjKcTuiKZ2iKUU9QDfy+n2CQ8fU?=
 =?us-ascii?Q?psIfl+dyUJ5OVYAH1/TXOI0cinJyYs1GVJpFHzGLt9MwQSURNW2ULhZ/nCmU?=
 =?us-ascii?Q?q0UnAV7alp/W6DbWfH9sAgj63JyyLxbdLHXoUJO9nMUjYklwoXqSwhSLEEiK?=
 =?us-ascii?Q?JGZGUe7x8EkbUo/Jmv8gfyagjaPUO0jXg3n79aqYNqJOPwCAB1xIiywGeM2D?=
 =?us-ascii?Q?gzRQZ7w+tfN8F92sIQAGqc7OvjvzwivCMp6diN3Rnzr8XpZsP3CTVJyae76X?=
 =?us-ascii?Q?/q2rc4tYt0hjHNafctpLETSja0zXQhGzynFDGgj4?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 881b9c56-9c36-48fd-7fd8-08db71cabcab
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB4838.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jun 2023 20:12:56.7369
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Rw8jccQU1hEdwnsVvxXGPiEhmutJ889hJ9Aot+NOGMbFmeFeazb8hVxiVBAsQ3LYaLMjUznMz6vvGY578uYlFA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB8903
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

