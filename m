Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E490747F6E
	for <lists+dmaengine@lfdr.de>; Wed,  5 Jul 2023 10:21:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229577AbjGEIVK (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 5 Jul 2023 04:21:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231655AbjGEIUp (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 5 Jul 2023 04:20:45 -0400
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2117.outbound.protection.outlook.com [40.107.117.117])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEDBD2114;
        Wed,  5 Jul 2023 01:20:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=A2QQS8kp+Bjnwv/sJhPFRWkdsCCLpkBbjq9M2Z6SywmjYSMqA7P6Yl2Oh8W1yJzCycgfHroB4BF1pHP6x0NYsyIC1hpOWTiOzZ5R2QujwsUsGgwr1Xb9JnJ4rgl1OZ8hfHBD4xvSQ+R/hQAjNsRdt1a1WdD0Vm0RRMQ6Wi81usRDN8GEN8rKN090IcShG1EGc+2cv1Ahne1hMXjcOFpbumqxs7zAKjr0YU8Gb/NNybFIKlPFAALxJBabqcZvea/yxd+M7Il3G6J6PGgPe0beaSXZNTMQWAlLmd9zyQJWK0EaSQJcl7eFPXfAysSABEaR6RC10gsuZqBGXsPlFGG2vw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=76HHWfAn0UPLhznGgQZoqZ4lINl84wG3zs0odGWeQTU=;
 b=DovGn/axYzKTc+8z+QbrggETcPNpgKWmXR0Kg9gwOcObDZXrn1oSQMO2o0rkoOAqlS2PU8qTeCFpCWcyOzSlDuhg6tIpsffsMzxturZROwhz+kNbvxZiZDsNv1CxKdAcq7DSlC1fJNOet+gziO7WXc8dcYrlhpkYLSfQCQW4QrV/Is212g8QuiJwcJ9XlZd7xv2Bh1JURIHjH9Vq5gvWc0362aoRrXecZrBrlPCOmycA4I7SOMY86SJnQt+tjqKLNCBPJd665Vy8I+BCB+rbEWkLCOpCSwkOD93sgAP7hHmagwlauMcr+7degv8C1iKntqBhsCZL6NW1tEpTEf9dzA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=76HHWfAn0UPLhznGgQZoqZ4lINl84wG3zs0odGWeQTU=;
 b=ba7pl1/TMqRfYDzDAm6br9mi6NrC0iuXvglJwnOS+YVFmBg7Ebc6bOd81/25wBQanzee9LZV4mMgtpCAAO4VAZvbZlPqUqlLyeEbPUfsYZjBWNr+Zs4paCYB0RZojjb5kQa/quiFr/yUut8ksH1QT/7h+UXWMhc5wnKFJuMzJbLij9fwt890n4D6BOjztmdhTdylyPc+WdiMRHxgNe/ogijoC/ojIHN5vhAQtarDUb90xJD8TYiq8ohoqq6WWccdAhrdPHw1waaAK3XFjT4sqV+gOcVzYmo2VzzGW5Cx+fyM2KAuv4cVU5fBf81TXq1zH3ZwilKSCvnAIjBYS7T6KQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
 by SEZPR06MB5119.apcprd06.prod.outlook.com (2603:1096:101:4e::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.17; Wed, 5 Jul
 2023 08:19:13 +0000
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::fa0e:6c06:7474:285c]) by SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::fa0e:6c06:7474:285c%5]) with mapi id 15.20.6565.016; Wed, 5 Jul 2023
 08:19:13 +0000
From:   Yangtao Li <frank.li@vivo.com>
To:     Sinan Kaya <okaya@kernel.org>, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Vinod Koul <vkoul@kernel.org>
Cc:     Yangtao Li <frank.li@vivo.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-arm-msm@vger.kernel.org, dmaengine@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 3/5] dmaengine: qcom: hidma_mgmt: Use devm_platform_get_and_ioremap_resource()
Date:   Wed,  5 Jul 2023 16:18:54 +0800
Message-Id: <20230705081856.13734-3-frank.li@vivo.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230705081856.13734-1-frank.li@vivo.com>
References: <20230705081856.13734-1-frank.li@vivo.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2P153CA0044.APCP153.PROD.OUTLOOK.COM (2603:1096:4:c6::13)
 To SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR06MB5269:EE_|SEZPR06MB5119:EE_
X-MS-Office365-Filtering-Correlation-Id: 4be2ff57-0d4b-4ba5-2848-08db7d3083eb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5X94WmCg3BGPy1ti/LsCuCCQuwfMuhicnPlIVQQvOxz3wQot+Ml6oJtuO/s4DePgj6ehLQsuAFQaezALR3F283/3FFJ7ftkp223akdbDX4y6T6XFj1zISoQT9TQwnOa3OBGlXSFqENO62HSDkdhOH4w95BiKcjcXX2t+OXBY4hekS7w2AMu4IL4X/Pw7TD6TMFU9HfB/fYGd3JQSo6Uu8Do+cADpLFlzhTSKuPdEmqyBDHoOVue//Ksj0wr8Gve0iGByj0F0tiqgrhcJ52+Q77QJvhh8ygwdjWMTa6iUUxAUH4OPbKCb0TRDSU1P9DPbpuQR1ci/607i+OMcN37lIUy6JalA+M8/xOM69UtUn1+tk/MZ1308VQBfS92TLnsnw9cWO3pyIzWGEUUHp1aWTGOTP4L9J0y1n8eOAKk78vZV8E8zo8nuEY9tUvDJapOaMOQF8YbVMiAUObNA+AGQ3WI5hZOCwi/WG28cGbzQO+XryqGwjNN6uqPLKofMwm9YFUCI0kDV5Hvf1sZdpLLiRHaeaaonI8CaTlM8ACgBaI3vW1xZGuMt6nCam9b7ZZrA3QvfkpJXjNA4fTsc9M3oE345f39NKsoqO58IYyBzHa5Mhdvgp/llw8joIq8Mi1/R
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5269.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(346002)(396003)(366004)(376002)(39860400002)(451199021)(316002)(2616005)(4326008)(4744005)(66556008)(66946007)(83380400001)(8936002)(86362001)(52116002)(1076003)(2906002)(66476007)(5660300002)(8676002)(41300700001)(36756003)(6486002)(6512007)(186003)(6506007)(478600001)(26005)(6666004)(110136005)(38350700002)(38100700002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?y5lyQ0VF2AUPUh1vpWI5GTPhfEbb4RMhoPXOlL4EFqHNWDwBPwGLXo+EMiBt?=
 =?us-ascii?Q?CYHvae/L6J+KDBLQDTFPz/e1kMa0CD28bWvvZW6OK6l4/KQnW78C9afSNk/V?=
 =?us-ascii?Q?2KA6f0uAOstkvdpFJsHJ+kB4ksF76olozLEf0xFT2dpMuCpkOmpYQ1EUKDdS?=
 =?us-ascii?Q?ncjywhVU/VAkUNXzkS1VLWY+sdHmanCzn6hWunnmkz7wzeFpFZmjXLDn/8zr?=
 =?us-ascii?Q?lwldT2RAZnWkVOkpU8xlrb7Co+yfW97fdNsb3YonTtEXeuAzgJg4CEviynte?=
 =?us-ascii?Q?0UgzF0IuLnB9vj4uFfO+i3j8KWYDx47xGqH5OuK03HiX5b60gOQZ3/O3CWRc?=
 =?us-ascii?Q?h4Yh/QoKEOu4zW2WHLMJxAaG9EQj8rlU9vjq8xUyev+WZGLagm6JQ/xPOWAH?=
 =?us-ascii?Q?aTGcpBaRMDu8xHAi7x0vJ1vOn4Pkr1tqAQUPzeHo4EbW35OhYwWOiBsNO7J9?=
 =?us-ascii?Q?o8dNO0lBCRQ8wUHEcLP+cglGmGeEWwrIxxdcm+PClZBKShWDkam5ECvLFlv+?=
 =?us-ascii?Q?z3O6AhM38b7AJCC9ygGKenrZq2BVOiVrKsYUphQZZEF2A22eIwnE8N9TGr2t?=
 =?us-ascii?Q?e0dyIP2xOuBR092WMbgAPy6+Wen2UoznM/sXr1Cb+e3QakTJVzR+x/0poGBy?=
 =?us-ascii?Q?Wkx29rh9Ep3O+/3t4Ze4rw/9lPxXf6XsgRsXGqU0FoJB43AiK7+d9tW//LIJ?=
 =?us-ascii?Q?2q0r9Cu8J3SqCnrXCNQs/LoFkVOzI/VeG810Tcmm+vXjeS9xGv4Zg7vZkFbl?=
 =?us-ascii?Q?Ba8oKLznkgMy934+nZS12oL3O95oA7x4RHmAVk3/GbSMX9xE+Eu4KGjIHPsI?=
 =?us-ascii?Q?m/Bhx/emId+xcRNPnn2p6669v+fbKnsOLlVwMKbcflR7ez6upZjXgfItCwwT?=
 =?us-ascii?Q?2cpDzdBcJNAr0McJCy8EGln5UbrkxezBwuoDK1xNu5k7ELr7vMDz7+lFLfaU?=
 =?us-ascii?Q?npzk/oFbwc3uSCaZ6pbORyJuupHx6ayz1pQ+EE304cye+fOGweOMm6hVA/9s?=
 =?us-ascii?Q?b8/9SHERe3xD6NeUcUwilv8yCfNHt5Vu+xvY/dw6Z61dp0ZKIjpD9lfWbuBq?=
 =?us-ascii?Q?SP3QFwi4yslq9PeRqMzBnfjSMJFnsVQr/R9twALqVSQr+7Lo0lgUw67LBQ+G?=
 =?us-ascii?Q?7e/NIy/H4ag3lCrIL4CwZ/JA814LpFNoFtOfHxc1tN1euGdMntLTP0Jl9F4o?=
 =?us-ascii?Q?PYwjwETHrdKoDaEQnBXdRDwXtmkgREZ5YFPfVpsZbIGpR24pOzgAJzx/4UsM?=
 =?us-ascii?Q?GMUpXPUoPVF/W6F/pv7hWZq9t+jlEV+9TGvaFE5eOnd0kzN5oJFE1ZzCNy3Y?=
 =?us-ascii?Q?cSmFPCsFo7BMBVCMMn3kUsVKE2Xsw9OpGd4xYDYLeZViaMs5c0bovIM1SyVD?=
 =?us-ascii?Q?6KrORGPAhupuIXBetFhGnbgzcJer2rsITpxUMuK8XoerkYSltZodcAD3PYfM?=
 =?us-ascii?Q?Hf2kYhegmcEPcFm3f5PXBuProKrH2hcUfVxEnji3A7ACZm5fdhO09XsWDJmw?=
 =?us-ascii?Q?88EpdvkAHyCtYSe9e3vy1TMwO8zwKmIhXELGU+SB2nEkiY5fJMI/IIV9gBCY?=
 =?us-ascii?Q?HyudlRLpj3KCojAiJheu0ohHpRN/ZEpETr5y2Quy?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4be2ff57-0d4b-4ba5-2848-08db7d3083eb
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5269.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jul 2023 08:19:13.0315
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: x9nk/Po4A01JL0TDxD5aIKBxxFVGyYTSCWEft4PYIP8RGC/dHS+ykGAVcbsApx27UteP006LLn+vz2NOIeM69w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR06MB5119
X-Spam-Status: No, score=-0.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,RCVD_IN_VALIDITY_RPBL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Convert platform_get_resource(), devm_ioremap_resource() to a single
call to devm_platform_get_and_ioremap_resource(), as this is exactly
what this function does.

Signed-off-by: Yangtao Li <frank.li@vivo.com>
---
 drivers/dma/qcom/hidma_mgmt.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/dma/qcom/hidma_mgmt.c b/drivers/dma/qcom/hidma_mgmt.c
index 05e96b31d871..1d675f31252b 100644
--- a/drivers/dma/qcom/hidma_mgmt.c
+++ b/drivers/dma/qcom/hidma_mgmt.c
@@ -176,10 +176,9 @@ static int hidma_mgmt_probe(struct platform_device *pdev)
 	pm_runtime_enable(&pdev->dev);
 	pm_runtime_get_sync(&pdev->dev);
 
-	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	virtaddr = devm_ioremap_resource(&pdev->dev, res);
+	virtaddr = devm_platform_get_and_ioremap_resource(pdev, 0, &res);
 	if (IS_ERR(virtaddr)) {
-		rc = -ENOMEM;
+		rc = PTR_ERR(virtaddr);
 		goto out;
 	}
 
-- 
2.39.0

