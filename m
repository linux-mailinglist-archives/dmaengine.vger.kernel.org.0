Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 66CB2747F6A
	for <lists+dmaengine@lfdr.de>; Wed,  5 Jul 2023 10:20:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232413AbjGEIUr (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 5 Jul 2023 04:20:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231594AbjGEIUY (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 5 Jul 2023 04:20:24 -0400
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2072a.outbound.protection.outlook.com [IPv6:2a01:111:f403:704b::72a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 311791FCF;
        Wed,  5 Jul 2023 01:19:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fgicCFOy68Qxtu6a0yCgJXY0+25NmuNnOmbh6o5a4+Eblkwhq1n9STCLhRILQ4jzaI68uUPqMFKIP2DsbPwbIs2g2NHTCCLhp3eHz8MG4cTDpEsE+2rTeoYyiI97jb3b5SjdfLZZF2euOCZydPS0bSwd/svNhl2BuWXQ08X5z4xpb3SUrG7kn22Qg8c7dzkRumSBjN5ILReNhBqK1x9qGE2Z1coSrJaqd5oAc7q0tmU2LATd7mzeIW3q3spTs7tH2lSrBpATWFYHzcIc4EFJspTEJYP1mwT/URmgfmgVh7E1HA5AA3JmShWBXEnsPC0YO+8mDynPXJOH9+m2/zZjpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Li11zbLzf1YFMqKUTEIvOK09mYXdHEPAbxQ9C2YqLVs=;
 b=VnmO0hQiurW3SttdCpFQk1E6XE2Tq0unDH5ZiV0XO3tZ8wU3zg2kzugPzXViYbM3hIyzfSDYxRZsioAwmV8RgKEDInkg2o4TqKDaa5KgkQmsLPQ0tucUp5KW5iGSNt1ZmcD2V8YzoEn7XvUbuV/ANnLSIuqTVxCuyO/Kp6oHdtzlofmeoEN5p1MTb8rK20Zf2P+pbrv4OIO1uNcw3CR2/1qVPv4KPzy79+u9w+v+uRYmufYgb2I18dCa8bTtQKktBH3mr0JMBWHv/c9WKOMzU12/L1RoQ0XesUHWV5+cjvGECTHJpnC0BBL6vNANgz3ABLswpgjOygJqPARPzUYCCw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Li11zbLzf1YFMqKUTEIvOK09mYXdHEPAbxQ9C2YqLVs=;
 b=BcKN6qfOoOhGBPMYeCtaRHZp9UM/RLFcmva0iK0hiIVuCJjniuAe9kNi/trD439yfIb33Bgpa11NwpYlHn8jrJ7g5s95HekK9goHrmSYjq3MxyRwMFgsgUsvkaAa9lvNYebga6OYG+/GxR74h7JG/DosCAavPWNAD+zqY2r1YREk/31UfYeCJE0VdfdUiOdCJVTeMxGxvCXo+NJqhnmb3XlUhaO5nehEjpPZleuMSsdYPimD6fb/q65jPFQma6QdrOBAM4bwMXN3+sNJ8mTo/AStKou6Zo9+Owzomr55e1sdm9mlE2b5KGIMdZvGEorockhPxnDYyHzEQFjl7yDbEQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
 by SEZPR06MB5119.apcprd06.prod.outlook.com (2603:1096:101:4e::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.17; Wed, 5 Jul
 2023 08:19:10 +0000
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::fa0e:6c06:7474:285c]) by SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::fa0e:6c06:7474:285c%5]) with mapi id 15.20.6565.016; Wed, 5 Jul 2023
 08:19:10 +0000
From:   Yangtao Li <frank.li@vivo.com>
To:     Sinan Kaya <okaya@kernel.org>, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Vinod Koul <vkoul@kernel.org>
Cc:     Yangtao Li <frank.li@vivo.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-arm-msm@vger.kernel.org, dmaengine@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/5] dmaengine: qcom_hidma: Use devm_platform_get_and_ioremap_resource()
Date:   Wed,  5 Jul 2023 16:18:53 +0800
Message-Id: <20230705081856.13734-2-frank.li@vivo.com>
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
X-MS-Office365-Filtering-Correlation-Id: 92c66c87-f94b-4557-21d2-08db7d30828f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: bgrDN9HXVdv+YQxzWlaY81zHMTqYxgE/J3GaPpOJrD9B+Q9HwZxiP/5yZ6N3kqtolJaIdmLF/RS8VrDDGXfgDpyUG8DA2zGM/ZyQgZJ0rDexuSh3Ab6x+GCeIMGPY4PqxknjfGwuv95cN0Gy12GG3z6xrBbGi3aoZoZGCE6VtENSszvXhVnkD8S3n8ThpVOgM7OC335KX5ZECJEUJM8AfNh1B51dj/4SbleqYPuRcXudvgAA+k/t6msn9j7daEcMcAqmvrFyfAqnIEnls9oCnabQREXtPbvkodGNq8vPz2oLlYhk8A+ygHGhnayGtbLcWbFU2hoYUSg1m/FXnPObmm30Vyjb5azNR9xbFsO/bWTEaQ2R3B/RmLM4Pq3F/J549280uMgBhsBa0iavqt3GmxI+FMd/UhqXpzp+sojv26aIda0tw/lxjUHFkI/Akky4Gj+ZeqYxuDKKcCdODyQi4wNk370gCXjP4ESAEwAolaABqY05WYSWHyAO9HG4aCdj8l8ducKvQ2mVa4hbhJHAaNjHZ6s4Ha6V8MGNfSogIxcF3WAXfaedKP9uRs+dlpHD/8b0kwvbrdcg1NP3/r45niiqcdHLtJwZNgVkqyBTEv9jTrpJON0gbe42/7jTqZv+
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5269.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(346002)(396003)(366004)(376002)(39860400002)(451199021)(316002)(2616005)(4326008)(66556008)(66946007)(83380400001)(8936002)(86362001)(52116002)(1076003)(2906002)(66476007)(5660300002)(8676002)(41300700001)(36756003)(6486002)(6512007)(186003)(6506007)(478600001)(26005)(6666004)(110136005)(38350700002)(38100700002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Iyvc3QKZQH8DZ7YeI6Yj31OtpWHjLDACAtxOn9tSwfo5k0hFDbL3kMW5kgAe?=
 =?us-ascii?Q?v44mVlKy0MBjF6mHmH5D8AeSkl/qzki/QlbC6TB84lyOdsZDcp1YjP7t5axv?=
 =?us-ascii?Q?dNzHMhIeyhWV9HAYi/qI6/OnA12f8LfrmT3pRBPTP0BMql5ZiyV6lwnRpGCx?=
 =?us-ascii?Q?8v5ihW7kuAO4i+qizZqAd/omPJ2QM1ae5JmfjRFqZdZiv4rwZG2ibBlYpVi+?=
 =?us-ascii?Q?y7jnTD/J7M65cyjo2JwQtwYe4YRbkIk6L0C6osGWeFSUm3okweE8ka36Zb5m?=
 =?us-ascii?Q?rpdxO5zfQx2YyEl30m1P/+u1UBDTLmxZjzhcAm3ajoQ1FT2JvNDJyvonVGTR?=
 =?us-ascii?Q?xfXSwkKrp05MVIxn/6do9BQ41jUA58YcemUFfMDw/qexy6z84BhRjk1G2Nm2?=
 =?us-ascii?Q?vhs/r3hJEz2KDY4TUYAma7AAD7Qxh92g7L8u6lNxLl6hNMYmZnhp9egjmXT/?=
 =?us-ascii?Q?FDzd1Ie//xYolsM2UKLZRwSghxs2ITrCLmNSfds+0L9vKkVdqoUFVHvDQ2kf?=
 =?us-ascii?Q?FisM+G+4gk1bwkgUHY0IST5E2RMe9PvKASKST/qq+IAV6ZEN8Q19byVBOQhj?=
 =?us-ascii?Q?qbBm6Renqr/iuJc9bCscpzDi0KwvF3/UnaXqvBcagOuamIpJD5aZBMguzpoB?=
 =?us-ascii?Q?RucJURzBKnCC5IfkuwVyQu75niT9n6TPEBeWDRPRE0dJB8sA0ec9+4qHpa6L?=
 =?us-ascii?Q?Z+6tD0Jnfb4NjIGbUhIklErDxbMJfd9P9I4UvJOIpeAS4bGsLfBI/DWPnG0y?=
 =?us-ascii?Q?GPNJD3wstdJJ1wbVBOHSBr7hUdBh/vj07QX6Woj/h+4idIb6LulWqCQMtbds?=
 =?us-ascii?Q?4078VvlY0y4+5xM+vPMPzPxhr/nZVD2eCfZEnBdVPDkPACVHHpk3weLIOAml?=
 =?us-ascii?Q?k6P7HqxbHfGDOqBQ0wjre7Ezc7CYIRcYUW0zoyosyKZU8Vd20a/nBTyXf0JC?=
 =?us-ascii?Q?DX0eaophMrG8X806Q6R4hd+xKPNy0OkrbSLrzRYOgLyVSr1rKbFUTD3eTYPA?=
 =?us-ascii?Q?hhFHC9wdFtsp1tozG/nbPYDje/mcEY7hPesgoqs497Wk1x1gj5KEqAkMBEyX?=
 =?us-ascii?Q?1qGZ+bGMAcp1uYOEU4st4A0nj1hFICIP1fu4gSw7g4DMimA6L58S5C2SVTPd?=
 =?us-ascii?Q?tFksNWbnU1FMJSFfEHGQILAFagsrlWbfz7IYMGi1d16GlK2cSyOo6dIsR3pf?=
 =?us-ascii?Q?a7abuNrXnvZWtZMMOrQK5wyQ2HbPBjqFkq47Yh+bD5WhnKNDt5D+eBGk1J7L?=
 =?us-ascii?Q?N4b85C6ggteshG0t29Mg2uHD6467Z/WY73YAUtlBitVE+wquuN9O6IJWG8Ng?=
 =?us-ascii?Q?HMY0mIZWgP9XcfNvNMrQbz3aLlH43giUUBRBX5fi9X1B+8bBh2zIbWS4AO1l?=
 =?us-ascii?Q?RnrBLsXqh/NZG0XG/PgjbuV/sMhehvAtp9AXKYthHO2eSLUSLwTbbFQ1Kyb5?=
 =?us-ascii?Q?8h3ia1vxvfSKTIQ0YcK5G3FtL9B2a13wTuXnHXfswCxzGFlEZ8N/zibJY+kz?=
 =?us-ascii?Q?vGKPvZ0Mx36OtfzlDBc0OBXtLDCJJ4dY/Mp7qJSdR6fbuD5iz3XyzYrJ+ph+?=
 =?us-ascii?Q?pEQgoJMjEe3dtnTRkaahD0FuMnofY/1ZnnbKLOxL?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 92c66c87-f94b-4557-21d2-08db7d30828f
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5269.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jul 2023 08:19:10.6690
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MU2uMU7D8aLjecxTgIZI4WFRiUV6xPdmjTuo+t4uRlX6FpeSL2QFtJTyrJ1pUp1IaDLA2Z9/VfnCszY4DTWF9w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR06MB5119
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
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
 drivers/dma/qcom/hidma.c | 12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/drivers/dma/qcom/hidma.c b/drivers/dma/qcom/hidma.c
index 344525c3a32f..b5e3633e6a5e 100644
--- a/drivers/dma/qcom/hidma.c
+++ b/drivers/dma/qcom/hidma.c
@@ -765,17 +765,15 @@ static int hidma_probe(struct platform_device *pdev)
 	pm_runtime_set_active(&pdev->dev);
 	pm_runtime_enable(&pdev->dev);
 
-	trca_resource = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	trca = devm_ioremap_resource(&pdev->dev, trca_resource);
+	trca = devm_platform_get_and_ioremap_resource(pdev, 0, &trca_resource);
 	if (IS_ERR(trca)) {
-		rc = -ENOMEM;
+		rc = PTR_ERR(trca);
 		goto bailout;
 	}
 
-	evca_resource = platform_get_resource(pdev, IORESOURCE_MEM, 1);
-	evca = devm_ioremap_resource(&pdev->dev, evca_resource);
+	evca = devm_platform_get_and_ioremap_resource(pdev, 1, &evca_resource);
 	if (IS_ERR(evca)) {
-		rc = -ENOMEM;
+		rc = PTR_ERR(evca);
 		goto bailout;
 	}
 
@@ -785,7 +783,7 @@ static int hidma_probe(struct platform_device *pdev)
 	 */
 	chirq = platform_get_irq(pdev, 0);
 	if (chirq < 0) {
-		rc = -ENODEV;
+		rc = chirq;
 		goto bailout;
 	}
 
-- 
2.39.0

