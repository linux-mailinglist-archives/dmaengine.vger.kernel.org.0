Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D51DE7482FF
	for <lists+dmaengine@lfdr.de>; Wed,  5 Jul 2023 13:39:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231218AbjGELjf (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 5 Jul 2023 07:39:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229720AbjGELje (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 5 Jul 2023 07:39:34 -0400
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2138.outbound.protection.outlook.com [40.107.117.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0172E3;
        Wed,  5 Jul 2023 04:39:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JFsOc6hEoGeLA4vfQKGJN9DjZdnIvJtlMcc0+axNoPFtzpZ8Y64Modqi7GmE2MN+/vZEosnJ5ykTGXLzTOfU04xa7v79pAcBkgheoRu0ua/DdJcr00CH9OcIh2Z9fTWjnSmLK+mgULuBK02MEuHdilgtF3xxlYJpbl2r+5sYcVubX8gcZqgoRJhoQt3ov2Zb91gmruTHc8SS+GQbgsNwxEi5sFQdL9P6v9sVZKqwBIyTWQCR5imAxdfJ8cNCOJJqQbmR9dPH7Mas+7HiVN6xd7EvymAKD0Q0k+h212ggQVOmTr1mUGOa2e84DZPSMsDZh0u2EOIH4amqsL1xGcy3Jg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SHL6TmBvJA5N/64bSa/01Uz8EUjQZ2PdntpMXiQblh4=;
 b=AieumuQg3zgcGgCaSgyEN/3rGey9azPJ4rUIh1eEtEQJex47CtgcM6Q7xbxwVA5VOaAz3X3uFNqfiakJYjdWGTmrXlHb6puxlJ7Lq3mPeYGHGRYq/o9keE29HOlaBVc+9FnJDDR8vJqNUzbeONePSLThFRkkEXqBqGtEGaOv8rtmfz3lvVvdVj8bbnkRTzV+NgekrzLgwpnclMId1SNE48LY3QMU6Wj5urwd8qET7FV5eXpCghP71LGpZwTxwvssJGdGc3YMLmfM2127t81IwmVXkcRSq2iymWd2hBJ6P8scKxjos/+zfX9LM4Ahurv6qrCN5LGYyMRSndfnpEhPBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SHL6TmBvJA5N/64bSa/01Uz8EUjQZ2PdntpMXiQblh4=;
 b=U1NyNJCQRMk5boLxnJP5ty/XKvHfGifj5bfC7nyf0RhfBF95IuwZRmXZLwEAB2/Pv8+BAdmYAIjGVFTng9UNRabRybOeA6EDA95IwAFW/4crRMmznbAJnBwtkvOTgvFAfl12cT6EujGxTCoaOvPzusBihY0l6TRQaicb9F09FvE9to8l08ke3nOzqXGSPFXNWOMUmYn8fwIWBfNWFC8KIyiHNkmnfyblTxAnZkZPpxE9DPKRBZDTYeKqVtnW8ntOv8jVXwu0ET5wTJnlxPw95iyMgBoSE5UVQVSUZLwqwEGppvdddxgEIwYmwLzJ+QK5OEIY+bmTQPrcClQi71P7Mg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SG2PR06MB5288.apcprd06.prod.outlook.com (2603:1096:4:1dc::9) by
 TYSPR06MB6504.apcprd06.prod.outlook.com (2603:1096:400:477::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6565.17; Wed, 5 Jul 2023 11:39:29 +0000
Received: from SG2PR06MB5288.apcprd06.prod.outlook.com
 ([fe80::c2b:41ab:3b14:f920]) by SG2PR06MB5288.apcprd06.prod.outlook.com
 ([fe80::c2b:41ab:3b14:f920%7]) with mapi id 15.20.6565.016; Wed, 5 Jul 2023
 11:39:29 +0000
From:   Minjie Du <duminjie@vivo.com>
To:     michal.simek@amd.com, Lizhi Hou <lizhi.hou@amd.com>,
        Brian Xu <brian.xu@amd.com>,
        Raj Kumar Rampelli <raj.kumar.rampelli@amd.com>,
        Vinod Koul <vkoul@kernel.org>,
        dmaengine@vger.kernel.org (open list:XILINX XDMA DRIVER),
        linux-arm-kernel@lists.infradead.org (moderated list:ARM/ZYNQ
        ARCHITECTURE), linux-kernel@vger.kernel.org (open list)
Cc:     opensource.kernel@vivo.com, Minjie Du <duminjie@vivo.com>
Subject: [PATCH v2] dmaengine: xilinx: xdma: Fix Judgment of the return value
Date:   Wed,  5 Jul 2023 19:39:12 +0800
Message-Id: <20230705113912.16247-1-duminjie@vivo.com>
X-Mailer: git-send-email 2.39.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SGBP274CA0016.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b0::28)
 To SG2PR06MB5288.apcprd06.prod.outlook.com (2603:1096:4:1dc::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SG2PR06MB5288:EE_|TYSPR06MB6504:EE_
X-MS-Office365-Filtering-Correlation-Id: 26ca1e91-5926-46e9-7df3-08db7d4c7e01
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Pz2cNBfJ4SoQ+ldm7QHQWN9UwTJPf2NMosGqaEMPzAYnaAW5tHbyqCopliRT9KW7+iAU51l+G3ObnzcsP/CjUjxGOT+gIBlGGEbtraKM88xKGBK9Mvn4SzdTuVv+i7v1egm2936efnTKs/Vyy817YBstjTD9EYKL7GD3grYSwcR82P4JhL+F5j84JmESlqayeZ35UMLiclUZbui+ba2Dov135c2BI5VCYAoKOUH8oPnwmUqL6fjtXZmfb0mFvK6mBw9rh/730eAaeitSm/BXtv8qiqZ8MBlM0V1+SqTtdf9VykWJlg1j4zjyPojmDhLOfImbT1pPu2zLRX8xmVH2VNng0NbWb9K3vv8d50NI5zGXnR+AFSI5yAOHkPGGup7Pci6Wcv1/MUKafZsdsy+ezJ+8uqR6l3On9kIX0pUjZ2JMqPGW4R6h8dS16hnEcY1oM82sRq7b0IdnzO1R/ogL4J+dn2//p7ve4B/RDBt/wwZrvtZR27ezKdAMahFPyXSbLz4uN1BVdu0xpDNvXmjlqoY5EqbjgVJNF2f5B2kbxCRZUMLM1dGbuhMzFHfa0wZDAvAm8Q5nDQg+HozTpYSue+aptvHgbftdTwCZ5VPmhnTqyBkaqO+jEQ9K16ZKWhJT
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SG2PR06MB5288.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(396003)(39860400002)(136003)(346002)(376002)(451199021)(2616005)(186003)(38350700002)(38100700002)(4744005)(107886003)(66556008)(66946007)(6666004)(6512007)(36756003)(2906002)(66476007)(52116002)(6486002)(86362001)(478600001)(110136005)(316002)(4326008)(26005)(6506007)(1076003)(83380400001)(41300700001)(8676002)(8936002)(5660300002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?lZppXqosjFM0N4SNcILeJ+5zj/mFjSaoxyWjHAojPEHb6/w09SptgowDJ+fo?=
 =?us-ascii?Q?HrbxKYfSVRY6odCFbKOY5pc1+4GQ+xgUKNAixwP1kfikBPmA8t9mz1AGIOB9?=
 =?us-ascii?Q?R8bPCoJ5TIHWzFw8uB4BDERC9u70P2AupecUHWhPqh8+xkDd8BTqEswY5xFv?=
 =?us-ascii?Q?zaTYeLwkTLwyCtCA360Gl2jxFrcTt9Adn2A3g4ftt2WC80f2Etc44L2BjzQA?=
 =?us-ascii?Q?WZeHxmCBD96Jly77Zc95fLULkeySknCDBwNEzO8R9+Xr7ptSzW5JuXyCGSxB?=
 =?us-ascii?Q?+KSO4dp5yn3wPnubFYfNi35OIJ+17BUanXS1E7kMZt9N6uyKV90E+qwivYYL?=
 =?us-ascii?Q?arIw20HgW/Bg6pDpHfcUJ2qB6/sqZl0ZdolFiXzBzSlY6ssIE8TCoh33A9FJ?=
 =?us-ascii?Q?QofGCXTb1t0bRyDyuiXg5x7nHn1kK6PixwAj0+Y2k/0USRP73C4V5h5wkCM3?=
 =?us-ascii?Q?s8Y1cLOhYDVId9yluD1XDqR81rzNHOmO2Pq1syctIPpRaY0u3TWGNewiO3tv?=
 =?us-ascii?Q?Z1i538rDfEZaDHUvtEz5KbzGg++oKRtQLRKAS3vOHserxT2j64QvZCjul3kJ?=
 =?us-ascii?Q?SMD4gcosifEYw3X/d1SqQ7tKAfjVNPJwDXxRxgPE+9xl8Bpkjp0/eNcDXHGe?=
 =?us-ascii?Q?RCQyyjsfZkiEuQDBj5gQgKAtLK1Xo3KTfSEBI9e8LfQjDkYmocEBC87FcCvf?=
 =?us-ascii?Q?8IVohCsORdqClcROpU1noI08+zwY/1NcCA5jsmrNGVqlxOj0Jq+3xnNAzNyc?=
 =?us-ascii?Q?vz5Ez7DlaRTfp0LBZO7/qbxfQ65vNlD8msdl88/K5J6wvXY1smmnZzY82v8m?=
 =?us-ascii?Q?0lmFzOGjrfjdzdxSz3C73Xs2g9GRDI5VsusfGnxzHDL9PBnceZxMuJsKH5nc?=
 =?us-ascii?Q?1Af9QiWk7Asw8G/xPXGKkQlcXfb/JoUdbM+w1j7hjbgL1DAfTvwo4t7/TeG+?=
 =?us-ascii?Q?feJYpnWAX5nKEgw1QWV+mX7ll6rj1nlgOPPsjP1i5OfQIq5h2DezTBlYtEo1?=
 =?us-ascii?Q?nbQnh9aGn4mZXPvvVErxBj7Iclqx+L/IwBXAZ1BF3Jlta2HMSAO35nd8aNw6?=
 =?us-ascii?Q?tf2hEKh+bEKWs+bS+tluzet0Ha4sOWZpgeB0pG+q3t3TpmuDg5H9kDYeou3b?=
 =?us-ascii?Q?yZcyzW2/+tomwm5OzAvLqbGd/yPLcEYSoKZAZPJp6k2TBKlIEhhsN3XNyVr7?=
 =?us-ascii?Q?JzyCb4vDQhfs2jIhVNAHD5s9Q0Y73ezb5XLvVSZW9Qk7a08/rOWsofebC7Jn?=
 =?us-ascii?Q?LvVAHsxkCVLWrTKtpesQFgYs+3BohqFWw8eHrAM/D45wMh5Xk7tujCd7pcZB?=
 =?us-ascii?Q?oflX0Dy89OcYbv0EkTquzSa7JZqIsMw8BFN6rtJQTgk8396uucV42GydnRq0?=
 =?us-ascii?Q?tBxj8PPfxgoU1ocw+Xqh8m5XHxQICqVrPm1r6l8/gOGS7s+QKLwceOgngQsF?=
 =?us-ascii?Q?pGcKPjbu5HPzuQuLG/yJBwo8v5GpoZ7JpBmIGymwX0k9tKdE5czf3Rf/YJs0?=
 =?us-ascii?Q?nN50g4KQ5j/WLM4x7Er6UYxLDTbHPYpsz0iLYHzWhyQ1w6+Eumpmq64LkY24?=
 =?us-ascii?Q?lZQJHpcyx3mreNCI7uEAxNxA8oPaUdRZIzH8Js3F?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 26ca1e91-5926-46e9-7df3-08db7d4c7e01
X-MS-Exchange-CrossTenant-AuthSource: SG2PR06MB5288.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jul 2023 11:39:29.0115
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ckRm8K87QdUAxREh5AyViPw4U3kz09+3O+OPF6Mzy8bozdN4tvDrk0HXo7hPIh0SiIPWwEKrEJeBXmcrQGVwCA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYSPR06MB6504
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Fix: make IS_ERR() judge the devm_ioremap_resource() function return.

Fixes: 17ce252266c7 ("dmaengine: xilinx: xdma: Add xilinx xdma driver")
Signed-off-by: Minjie Du <duminjie@vivo.com>
---
 drivers/dma/xilinx/xdma.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/dma/xilinx/xdma.c b/drivers/dma/xilinx/xdma.c
index 93ee298d5..ad5ff6335 100644
--- a/drivers/dma/xilinx/xdma.c
+++ b/drivers/dma/xilinx/xdma.c
@@ -892,7 +892,7 @@ static int xdma_probe(struct platform_device *pdev)
 	}
 
 	reg_base = devm_ioremap_resource(&pdev->dev, res);
-	if (!reg_base) {
+	if (IS_ERR(reg_base)) {
 		xdma_err(xdev, "ioremap failed");
 		goto failed;
 	}
-- 
2.39.0

