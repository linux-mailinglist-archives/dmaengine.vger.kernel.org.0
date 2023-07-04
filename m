Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 095DE747063
	for <lists+dmaengine@lfdr.de>; Tue,  4 Jul 2023 14:05:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231213AbjGDMFX (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 4 Jul 2023 08:05:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231398AbjGDMFU (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 4 Jul 2023 08:05:20 -0400
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2113.outbound.protection.outlook.com [40.107.117.113])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1724EE7E;
        Tue,  4 Jul 2023 05:05:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=a8CCqTenTaLxhc40DnRxzypEaBHVMYHO0ezqlfthnk8HdYCMGtZr8AY/H+3RofC3FYDt4a3gyVFOoHuTCRbdeNSvYXeDoGd902+3OQFeyngMURQ5XQ/DZqu8CmbYIVfans7I2465icLcqgFSjKdePLHH/cy9bvyGOmQXErT7bKNWpVYirENUNFHOc+16WegZdDt2jCdxijhEKIyH39jpUhYuvj8zvrLqPbFSlj8836u0H5ine4gECZ+u42JevbDlh7Ag7nLxsiNtEQx1+TZ8NicEeYcCEhGxUUIosddRN8Vw/waPE2xrDGKsUgKbD4vnj3GC02QYXg3rl4zos/qgUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=p4d0tcwYrv5GgGAUd/6L2Co9SEbi/PAPzN9VrjkRb1o=;
 b=AclTDQ/1zK1RoinnfuXsbL+1m0Sf3nldqW9DZD2P9Tl6+gibnvHYIbsaf0zM6jithsJiUI5JsMibqO34x+UiOOJmF9WgKX6V1RNoocI8PNIZjuowO9X3WJkKLD9T22Nllb96dT9ZN4O/8psF2AZZwvTq6FUKnMWEnbgaEFQI1n69BzR+TCMRU1QaZV2t6iXuuc7FJh6o13eJeybKXsxkrI3gxzg8r18XIjSmy7DJ1GOnmmKc3CxH5onZEryGr5ECarfNtjfSmPQoJa06wLY8M3Hw2Xm4u52DwKpAq88/xCNeYKgDfcWgo92hTZXo/+uGhhkXbjdVgY6lzbMVhXa3YA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p4d0tcwYrv5GgGAUd/6L2Co9SEbi/PAPzN9VrjkRb1o=;
 b=S2BpF4p6JAjleeINFP2wEyyZrbzDgQCF/cTOzC/f6Py/V0vBn7cxlksSu5sjXw6j4b6FlHOg7I020gkOcWK9ClapRoeRZR036XmjtFXwM6TlPkAhrCpEM1XgPetywQdoW5zTNz4uY3p/mshGaXLIHQYikaeagGADTP+5mTocOq9N+BrviJxLM0pUpBwhWi4E5EQBMpz9Tzdst7vgBgopO/9uGGOqHbqDJz+fKCOZrVix1nx6JEctTfU0SPdIGdXDVvX35FEcjPIiHsmAya/0LQ+O7lfkfCW1jfJIccBVU3kAZHR8c8a8+fvXc2vqkoW/EIEsd/SNWYrFQTq9lyIM1Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SG2PR06MB5288.apcprd06.prod.outlook.com (2603:1096:4:1dc::9) by
 JH0PR06MB6653.apcprd06.prod.outlook.com (2603:1096:990:31::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6544.24; Tue, 4 Jul 2023 12:05:10 +0000
Received: from SG2PR06MB5288.apcprd06.prod.outlook.com
 ([fe80::c2b:41ab:3b14:f920]) by SG2PR06MB5288.apcprd06.prod.outlook.com
 ([fe80::c2b:41ab:3b14:f920%6]) with mapi id 15.20.6544.024; Tue, 4 Jul 2023
 12:05:10 +0000
From:   Minjie Du <duminjie@vivo.com>
To:     Lizhi Hou <lizhi.hou@amd.com>, Brian Xu <brian.xu@amd.com>,
        Raj Kumar Rampelli <raj.kumar.rampelli@amd.com>,
        Vinod Koul <vkoul@kernel.org>,
        Michal Simek <michal.simek@amd.com>,
        dmaengine@vger.kernel.org (open list:XILINX XDMA DRIVER),
        linux-arm-kernel@lists.infradead.org (moderated list:ARM/ZYNQ
        ARCHITECTURE), linux-kernel@vger.kernel.org (open list)
Cc:     opensource.kernel@vivo.com, Minjie Du <duminjie@vivo.com>
Subject: [PATCH v1] drivers: xilinx: Fix Judgment of the return value of the devm_ioremap_resource function
Date:   Tue,  4 Jul 2023 20:04:58 +0800
Message-Id: <20230704120458.11125-1-duminjie@vivo.com>
X-Mailer: git-send-email 2.39.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYAPR04CA0012.apcprd04.prod.outlook.com
 (2603:1096:404:15::24) To SG2PR06MB5288.apcprd06.prod.outlook.com
 (2603:1096:4:1dc::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SG2PR06MB5288:EE_|JH0PR06MB6653:EE_
X-MS-Office365-Filtering-Correlation-Id: 620ec6c3-8821-45ad-7ce0-08db7c86ea42
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: W4SWH8aj0dX1ClIek7HwWAHlYeyCv58sCx6zpZvqzchK9XPaqTtQJbMOP54vueIEz5SzEfFbYLmAFOAnJbg1i3SqT+03kpgG9JJbcNrsIFhNXEzod8bTTnI4HCL+LnvoEMeIn3/9twL3DsfxvCrZiBAJud8+H4M22yiENlKUX4jVHgP9+4osq+FGIZ0N53R4nFyAIqOn+1+munUcIqcVGDvhLm6f1MhZZtHqRBMIsnHBWxJiiKQcJ6CEVQTJCu6wIESK9rPUehSc/NHkr199UxXIfRb7qbxh8SYJmnsGQmNPANSnc123GBx7023Iq/kP3xMr8rglifLNMk2t+GH8vsaIWCzm2Tyc2ht5VeBDjAsU+BmswPF4FyrMMZWBU1wmv68zZmzYrVMDnkmTDE/089wPQw02G7QLVGjG54zYZjIvQWF0PdF4BHHzysxx4FCCu2JP+jNTPRbbCPAW+34FJTBbVYD4Byx1afz8gttE0jsLltnCwpI6QkSuT1SE3xHpXnXoGyqy2n7IEFL1/NIu+J/e78vEfMJUP+Yk78GvGGfMaxU7Sz2IuDB7hybjriQFhBp6p4cccDVhc344T5mfckVuBzZNKBpqeG0FQAaAqNfIqouGfSnapAG+X+Zr5Aof
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SG2PR06MB5288.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(346002)(366004)(376002)(39860400002)(136003)(451199021)(110136005)(4744005)(2906002)(478600001)(26005)(6486002)(6666004)(86362001)(41300700001)(52116002)(8936002)(8676002)(5660300002)(36756003)(316002)(6512007)(66556008)(66476007)(66946007)(4326008)(38100700002)(38350700002)(6506007)(1076003)(2616005)(186003)(83380400001)(107886003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?DR26hOmZDfnG58AjHjNzpynGaD67DgJHX+woodbBxbR+nFLQ/JwmmOst/u60?=
 =?us-ascii?Q?4ibsmsMKaNr743T/86KTT33YJq5QEyCA5jDFFiBaL/gzbNdPo3Lmf4CjTRyC?=
 =?us-ascii?Q?QN97zzNa45fKCUG5Sv2qremjEBFobCjYKyrcCU3Nr8UU5QOTRKaH4j5vPrwk?=
 =?us-ascii?Q?RGy2KNogdbxm5SFldLDOmaBGXk3RK2rH5BKAlsofToIjSe2g0GlA8Mq3NXYY?=
 =?us-ascii?Q?NZ7WoDNsr1hWB0qcs3T4QxGdEe3gP60Np3Q3l/R/NbrV52ZZbTpK/rt8bfmx?=
 =?us-ascii?Q?k/xO/otqrwkNwLDBBX+3wW3XaRSqZOTBi6g30t0DDlOFUKjYJM4VOPmJdqtL?=
 =?us-ascii?Q?gbtTY8MUj57FdkAvoKhz+1CO5sz/0EibxVQIx7wqMjSJMie3Qze21o1DJRgK?=
 =?us-ascii?Q?9u06Ww0VN+YclRdTiPjNPPwuCZKfrr3d7FocHLBCiL571zTt2/c7NwVIGrNe?=
 =?us-ascii?Q?9kHU1NC8Jc5vc0kQweayBQhAtoBNBYz1zQRdNoNX8+e8J4uud6jvWr/FuyvP?=
 =?us-ascii?Q?5B9kFv1fzfjJIq0PaB/6QMbZIRKSDn4rAaoSiO0sZiL3dA64fE4OoMRawkEe?=
 =?us-ascii?Q?l31Xe/0sVrlzdO5iVrUWLjcE+L7Ja47W1WQwWvvUUwDSucXzY30xIN/PPzRg?=
 =?us-ascii?Q?4CVb+fgGZv2zQumBz9GUXQs2voGaEnb2xQngQPTfKvTpD32zD7F6n1f4tgXy?=
 =?us-ascii?Q?9yvzquvF7bXlfe+7glvozARlYuQmKVXWbV5JBcmzvUcihOycj4gHq2xro/vJ?=
 =?us-ascii?Q?b63bW/OHfo+tAqob4qxqsjbxtj5CVTQ6LGTazAuPudMoDUgs394RQeCaPoID?=
 =?us-ascii?Q?VGAJKwSLWYbWgscxzZf/YkbFDOVZxiJB4oENUz7C6YMNp6CgByuA0Suhx4UB?=
 =?us-ascii?Q?9+W34pIMlwLYonWeUop4QyrbdtmJrgi51hQIp/EgS/lPkjlHzlY6mh/oTC8Y?=
 =?us-ascii?Q?//ni4j0RQjY3aM4Slm2rLjl5MOTsk3/JSF06/ccmMebqktQKAwU0rKH+c/2P?=
 =?us-ascii?Q?AunN2uASf3g/44LdyeC/KVQZmjajw+Y76KbuFTovQFBk8p4AiTIHHFLZ+whV?=
 =?us-ascii?Q?3/oZ4qptvhj0BilI4p6U60qEqrC9vFKlwaLEdCNFc9s+w5aX4tGwoqyhG/in?=
 =?us-ascii?Q?s6tLsDduY1u+dN0xFrPYBqrBkS2IBUaEOVXLRY48cdv5d/nIGmOl2kOCrEUv?=
 =?us-ascii?Q?wsx1zCrd8Ps13AKA7mGweUu+340XyXXjprIhWqc9Gb57AYn2Yt553CY495Pc?=
 =?us-ascii?Q?Z0KKN6wFxT6NLR9LWPKRumsj23MTtSfDxxDt/3z4gnM2b/WU8OHUi/CjbjjV?=
 =?us-ascii?Q?19H9p2gj+lMxHu0HyVMgEATo+VeRDsQde3qa3CL4wr8TA6C0XUVWQRl/dmh6?=
 =?us-ascii?Q?IgWLqmLCsteKJAqfeMz6tdxxkWg5tDmm17/husXGRiEzOO3TsoQFcwjiN4F1?=
 =?us-ascii?Q?z6d7g+MEqDDZxcFPvkXNeWqdqJ9W5qU9b1JtskZ4Zp9ZbQdZnV0/OaEJyBBE?=
 =?us-ascii?Q?SVWyG1PAI0ilx625B2QbiMN35gmTsvyCYSpzvpw3Rf92QdMFD5Dq612EtiDO?=
 =?us-ascii?Q?okkOSasgqAPvx++ogBpPraAQv9zP69A9uOzaCpJD?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 620ec6c3-8821-45ad-7ce0-08db7c86ea42
X-MS-Exchange-CrossTenant-AuthSource: SG2PR06MB5288.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jul 2023 12:05:10.3107
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: diSqHNYMkETvBb9xiGI2mjAz/KjjkbzlOB009AEBAlb23YgsxIICk1w4vhjXTTe4AqWtf6uULezk9IlZ8w82dw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: JH0PR06MB6653
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

IS_ERR() fix devm_ioremap_resource function return judge.
Could you help check it out?
Thank you!

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

