Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C0E574B6D5
	for <lists+dmaengine@lfdr.de>; Fri,  7 Jul 2023 21:03:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232896AbjGGTDt (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 7 Jul 2023 15:03:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231249AbjGGTDr (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 7 Jul 2023 15:03:47 -0400
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2053.outbound.protection.outlook.com [40.107.104.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A69842700;
        Fri,  7 Jul 2023 12:03:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oCi8IyIa9m2PnQ0/InWK/1JVCtUCsxl/XINBzlwOEUP0hiuel+LLy5T4mDPgA6LBsNemIKqgKHiGpRRYkfHQym8m7V70abhOCOTP9KbkdsPVKPoFODbgA96jrFxo4/ZdpTFYjGEbp56wb3wafQ/P/CrBHtWPZjJK2v/IVAU99FvCT7T2Sb2as/QiP4C59kVrJ7USqdCyq56f3bbeD3HPZINidCB9+vNa5+EtR/sdOK8owRbjIalYRz+NyBwboP2XUvonN9ayCM5dwg0uA62taULRHgF6oP5RwJkvZV0eJlrQApR/JcATioC01tBIboQyjD+KGCZpc4nPzNWHuEWDLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jCLhli8qcAeGElZvjPy3NGr1NAlNJ0LntWyYiGQJbsE=;
 b=bXpRrilLs3+gc4df7Jp3MDjqY3Z9iX9MvjTxEv9iVXqNBEM5rfRJ+oAw/ntWGfTY2M6JvyBc/Ka9QxDY7EPMwdmdbi/tZJE/39Vwr3Gp+8Y+huEs5G/TPbPiBOYazpWrdGAqlJJeZ+QOvBABPMPv9Bm50H9sMlbCNxjDzn5pUowkHKnSjUKMa9B+Ch3H3JfUX9XKF8zGBo93B8XHAsDs41bdb3+CJsbx4n8RrntgNY4/Omg68vWlvuxUgVf3e4agEvfpQ2EbrvQvzbHHz138qIS99AtO4VYoic8Nhx97L/sNpRXZdSdlve1+a46hbS1UiPqk/OgfSNfgDCImwy8u6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jCLhli8qcAeGElZvjPy3NGr1NAlNJ0LntWyYiGQJbsE=;
 b=SY6nBPBlJhgSULEexRdYFbV/7h/UN1jo5rG8o4K0kAa+8dCCOJIXcdyRr3dqYRSzh1+f/l8ICMIXYKXrtFKxgw5oXHQanKle6vYr/Mj1PubSs9BKxzZMvGasQ4ExQMToPPHF4k+O53oUs2YYiK+R2JI6hW5TlQgUWppZXrsGclA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com (2603:10a6:20b:4::16)
 by AS8PR04MB8612.eurprd04.prod.outlook.com (2603:10a6:20b:427::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.17; Fri, 7 Jul
 2023 19:01:14 +0000
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::4a2a:262e:415f:e41c]) by AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::4a2a:262e:415f:e41c%7]) with mapi id 15.20.6565.016; Fri, 7 Jul 2023
 19:01:14 +0000
From:   Frank Li <Frank.Li@nxp.com>
To:     frank.li@nxp.com, vkoul@kernel.org
Cc:     devicetree@vger.kernel.org, dmaengine@vger.kernel.org,
        imx@lists.linux.dev, joy.zou@nxp.com,
        krzysztof.kozlowski+dt@linaro.org, linux-kernel@vger.kernel.org,
        peng.fan@nxp.com, robh+dt@kernel.org, shenwei.wang@nxp.com
Subject: [PATCH v10 09/12] dmaengine: fsl-edma: refactor chan_name setup and safety
Date:   Fri,  7 Jul 2023 15:00:26 -0400
Message-Id: <20230707190029.476005-10-Frank.Li@nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: 43d8f2b8-95b7-4e5c-e092-08db7f1c892c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: HXamXaiN4YCATpoaDYnT87SQTOw6FrXEzAfN+FNs1tHRS0r10nnk9fIspNVpeubDEWR04hBscWzyxoMkRcNasekUDc4AJ2F8YQM6+LbdejtzDHHN1h63QHJAgaqT4YXx4wR0Ot5sbuX79yj64OowyYf3sk29gjXi0fseivqPWKDdIu2tuNwi+/JN2Ao4Bce/L23vmJ3SC4CkGS3ZIg81mkAIJfTcgbksExi6GjSDZrEv6WIY5cpTyvsn1FenYNJHGOOyHjc4U0b+sG9I2L94rIE6/ErVG9LFFAh+7SlKrd4Scv4Oo8656vDd2vn+Y6Ig8ljqW8okVywhUMD2wxPzoqLNxAjbjp0hlW82+BLpB8ftG3BXoy28LPZhFOFVtbeMq1Z8zcQFguQDqHZN8Xx2VCC9sMVzBMUv+eZDFe7WTVnRUKKTxYkNzFjN8xz1yAXZ4Jj9n6wHVwC2CnMyhf3KQ5z7EhyyL2Jxsjsqvam2N9BvgU2BgCJIj58khmultTUNMJ5VZWgJhE6mmI8nhnZPvES7AC6KrF9NtL9l3l+vaopvd0jYEC8D0I60zmYCcMPEVONd4SVjFBvT5QgC2vbMu4xb6nYP+IilcjNWsKN+3VpwrDHS/hOKGOYk9yOYEUcQ
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB4838.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(376002)(346002)(396003)(366004)(136003)(451199021)(2906002)(5660300002)(2616005)(86362001)(66946007)(8676002)(8936002)(66556008)(6666004)(26005)(1076003)(478600001)(52116002)(186003)(6512007)(38100700002)(38350700002)(83380400001)(4326008)(316002)(66476007)(6506007)(36756003)(6486002)(41300700001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?fpapAFCiIBGWNIUUhrqNc0jfk7YJSKZcgsng0BQWiKN+wZAous6Dp8+FGoIF?=
 =?us-ascii?Q?zE04dSTqaJ+r9XfznHCFp2N8rUPmdPuvM8rUU61Zezhca4MPSkpjp03kOoVe?=
 =?us-ascii?Q?gq26P9dEDbHxo1POAp5LOd2F2Wfyvd71gFjRij2dx+P3Q5kc2mefoAn86p4l?=
 =?us-ascii?Q?BSmhGz1ms0309d3QV4hmpEwM5a6ZgOR301aRJcjgVRG2PFfDvWi2cCzsE1TH?=
 =?us-ascii?Q?pNsdc00mRM+wFC9ebqXF+Ug/eOFaaP/olOut6cOMXR9UL7HhY2T7U5BLMA/V?=
 =?us-ascii?Q?0xiYz7f5DoaBr/C+yzu814m+CAqLC6Ipe6SAEHMZeBfubSCZpBY7T02ahJS9?=
 =?us-ascii?Q?YFS1bykjhyyLe8G3FsefJ9De7Wl8nRgg9qEN1Q4ACoV8jog+tiE4aY4AeOiP?=
 =?us-ascii?Q?VNwe7X7QNiGDRRN8ED9N/3zyfkGyd4KXIZvFIMkV3u8TvTltEnE6p9mcVVhN?=
 =?us-ascii?Q?530bVEuykoBaP+xoZxURK98qO8oST9h8KCwPHEIZVIH5Z2yKbMtAx+mZgllQ?=
 =?us-ascii?Q?qtXvx4QlQsAx2f5Fa0pUkejg01b5AMcCNNiRfErY787FtBOHxliSME2t/St0?=
 =?us-ascii?Q?C3cVASU5F81RACTT39FMk8loeEhKhmN3OzXk5++Feswpiq+wokn3cgTxh/XN?=
 =?us-ascii?Q?jzkX0LPTBhbFEdiOwN2cZv/Xu3/3QWT0KovnrInsFOGtUZrUsVg8IoXJinii?=
 =?us-ascii?Q?8bhQOGVMs5kQR9B6/3EqJHjhUTjsBtBZ2LDYCLCaHWXUUvXIHskKInNdWs3I?=
 =?us-ascii?Q?Fo8oG1KefRWWSDYg5NW8sRDtJ5Wq83lCHv0361UeZDH3nmFQsm+GDDjuq99O?=
 =?us-ascii?Q?lg3+mVzBE+8cuzoFZfleX7AEg/HnY1D4as0mGDn5BN9fM2pkttXZmNfGqmft?=
 =?us-ascii?Q?SJE8mpIarheMZEeYjdIOWTes8SETHqa+ZQAEDaYVZZ7XpuNCYPEf2Q8WIS66?=
 =?us-ascii?Q?AeK2xBAIceZASovSLrUYl8nkNAfeoG5rCxLYF/bmk3YS3p3M6IccJVDSPoX4?=
 =?us-ascii?Q?Rq2652vSLxOZC6fjImBpRnaPe+gHHuu1QSXsEY1QF630GXBIaDLcDvygQu3i?=
 =?us-ascii?Q?uCymjie8o9kcxP9qG6EKEDRz0wyc4pbaVg+MWFVapnS/tptorCqQQrBBxUyF?=
 =?us-ascii?Q?oUJX1GpTikOp0O3bcOQdkLsCGPluecf5NlL3OQyOTVm7VSmjRRTp5Jb1q9HR?=
 =?us-ascii?Q?V4jaKG14suNxxHk3oZtPKBGXF3IK9Z7iStXzG//GOihHm6pnjTkrO8bNYu/3?=
 =?us-ascii?Q?GzFTK/RqDeLT+t0qeiF8JsJpQimsR8+HBnA+LfzIoCrSNBz0Hhjv7K9w/R7z?=
 =?us-ascii?Q?0VjypckOodpSPNdAdw4fFXe8SGNA0rYLAFNEIbTwB6LNeWvLipD+YbCeZHd3?=
 =?us-ascii?Q?b2MUFG6Nt8VKr0zQkWoTvl3a6+7c6PHUxrFC9TPhqZ7sXTzAqtMP3ys5Kqw6?=
 =?us-ascii?Q?qNWwP2thl88OB4vp6BZLB0Vxn2vOVOfXPKm4sbfgG+QITu77nz2nLktcqH9k?=
 =?us-ascii?Q?TdXdZ6M+ANCMFEv0s6XDfpAb4qk7bDjV66n8ZTgFiZFA3FnRTuAEUMxeqE9a?=
 =?us-ascii?Q?FvDBKlbz1nPjP72Hh8Q=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 43d8f2b8-95b7-4e5c-e092-08db7f1c892c
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB4838.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jul 2023 19:01:14.1669
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LdSjKDKDVDJg6AknfHGC76t/29o+ASib6PuxGW8ep6UFalbehzBTes2a6w4QmLAkuAieyTBI+qxzW5LVJipQXw==
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

Relocated the setup of chan_name from setup_irq() to fsl_chan init. This
change anticipates its future use in various locations.

For increased safety, sprintf has been replaced with snprintf. In addition,
The size of the fsl_chan->name[] array was expanded from 16 to 32.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 drivers/dma/fsl-edma-common.h | 2 +-
 drivers/dma/fsl-edma-main.c   | 5 +++--
 2 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/dma/fsl-edma-common.h b/drivers/dma/fsl-edma-common.h
index 521b79fc3828..316df42ae5cb 100644
--- a/drivers/dma/fsl-edma-common.h
+++ b/drivers/dma/fsl-edma-common.h
@@ -116,7 +116,7 @@ struct fsl_edma_chan {
 	dma_addr_t			dma_dev_addr;
 	u32				dma_dev_size;
 	enum dma_data_direction		dma_dir;
-	char				chan_name[16];
+	char				chan_name[32];
 };
 
 struct fsl_edma_desc {
diff --git a/drivers/dma/fsl-edma-main.c b/drivers/dma/fsl-edma-main.c
index 04c07e9f45ca..d39bda95600e 100644
--- a/drivers/dma/fsl-edma-main.c
+++ b/drivers/dma/fsl-edma-main.c
@@ -175,8 +175,6 @@ fsl_edma2_irq_init(struct platform_device *pdev,
 		if (irq < 0)
 			return -ENXIO;
 
-		sprintf(fsl_edma->chans[i].chan_name, "eDMA2-CH%02d", i);
-
 		/* The last IRQ is for eDMA err */
 		if (i == count - 1)
 			ret = devm_request_irq(&pdev->dev, irq,
@@ -314,6 +312,9 @@ static int fsl_edma_probe(struct platform_device *pdev)
 	for (i = 0; i < fsl_edma->n_chans; i++) {
 		struct fsl_edma_chan *fsl_chan = &fsl_edma->chans[i];
 
+		snprintf(fsl_chan->chan_name, sizeof(fsl_chan->chan_name), "%s-CH%02d",
+							   dev_name(&pdev->dev), i);
+
 		fsl_chan->edma = fsl_edma;
 		fsl_chan->pm_state = RUNNING;
 		fsl_chan->slave_id = 0;
-- 
2.34.1

