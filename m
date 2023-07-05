Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF4A5747F71
	for <lists+dmaengine@lfdr.de>; Wed,  5 Jul 2023 10:21:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229906AbjGEIVQ (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 5 Jul 2023 04:21:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232415AbjGEIU7 (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 5 Jul 2023 04:20:59 -0400
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2117.outbound.protection.outlook.com [40.107.117.117])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50209171C;
        Wed,  5 Jul 2023 01:20:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oWGNPELUWRnYFbI0Hh5Qf+GWV8rtx07ongSKhTfTozOs+inps4dNt350jon8bkhROHyP971rtTOYix/ZIc5/4X4V/yo9DazNj5HGIIXTfdjhJvbT8RCebmjW0UKAUF9F0MKKRJ96bOr0PQ+LFEJOp021+jsLU4AjRWrbXrWMb1rsTSZ5KLhfd/QTdUoxEHN9RJMODmlMn8id/t8PhK0q0uCOR8VtR8ILDzPK3Zd1IyJdLEIVeCGuCZxQbIpKVno3egIZuGYGnXCzy5CR1kUk25er+ESQ+8XngIq5Z6jVDaVvfDpRWxKfhCZLHE1lzheDmzD5c95j6k/LUo0kN6ymMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=T7Vww+uljA+7/ozUpZTG9yhuuIePwV2weGLL55fyFuI=;
 b=WLWAaISfieyx38+6Ks4ET4IzK48sxjNfsSQy2hp8SHjNikTEqgAkahXKihrDlJTuTSfF3uNZ9cPLPUngjdrxuqlyLMIkC+psn2e8C7iM55InbdFQMeaqsJVn++E5VeXxa1xG5e8uH/zmF7f7wueAByQbdYAHvfphmE9XFndF2T/rCu6SzTWihSu46+DcN334VEpl+Ro+r9kmgxXUP7CBOuuzQPyCYxck/Fdqpm1gV2nc/MyvXU1ietLBwNB+XxdnM4Wf2KMB0/U6DVqU68aRXOGZ1ZPvw9myEJ+xp6mnlMYihg3yP3QDYdt4jWJWijNLIglE3PPFDxZ/MKllrXNH0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T7Vww+uljA+7/ozUpZTG9yhuuIePwV2weGLL55fyFuI=;
 b=LnT5muO/pcB3Ho1b95IJSPg5/0pKFv++XttDEC0zm82uX1mlg7EZeldBdNVrf0xAPnAeaqKUQoVqXKNsYyTYOQlQebIsGxtkeAf1esN1Kx/+hPHcubOIxvQWx7tgRxQ7QG4uKHij2uGbSrs4uHEx1Zp6byLkhj8auYSqscP0KwpZOtqAhqlXrlhcz1VW6zIhbCCQt4izHvmWN1vPhi+sXjr1Ab+a66wWXGrDzQ7M6vkY0vJ2QIOCv3Qb3XSdxr156dbDlV+HGe4VXzDBzv3mnnx902KjhDfsE/vtUoRNI3ShpwfO5h+kc7vlCxOs8SBSBLMIBsgLc29o6doPOnJ17A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
 by SEZPR06MB5119.apcprd06.prod.outlook.com (2603:1096:101:4e::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.17; Wed, 5 Jul
 2023 08:19:08 +0000
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::fa0e:6c06:7474:285c]) by SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::fa0e:6c06:7474:285c%5]) with mapi id 15.20.6565.016; Wed, 5 Jul 2023
 08:19:08 +0000
From:   Yangtao Li <frank.li@vivo.com>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Vinod Koul <vkoul@kernel.org>
Cc:     Yangtao Li <frank.li@vivo.com>, linux-arm-msm@vger.kernel.org,
        dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/5] dmaengine: qcom: gpi: Use devm_platform_get_and_ioremap_resource()
Date:   Wed,  5 Jul 2023 16:18:52 +0800
Message-Id: <20230705081856.13734-1-frank.li@vivo.com>
X-Mailer: git-send-email 2.39.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2P153CA0044.APCP153.PROD.OUTLOOK.COM (2603:1096:4:c6::13)
 To SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR06MB5269:EE_|SEZPR06MB5119:EE_
X-MS-Office365-Filtering-Correlation-Id: 6814a75e-4730-4f75-fa7e-08db7d3080ed
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: KD4XhruT3EKhq4/oyb84A6mIwc9wuTm6QAOYojnoNHWEPFMiO+m/aVm0CW4w2U/FKef6+SAYG2ABAhBan7Lzdn5IgnvdLLJozaGxC3UEuIdVWGsEZsnD/a1B6x1woBMAYxmo/+MTCusweu4CAICLA1LidXm1cJR43I+gnKkWBkNW84pRa9jPV4zS1JlEmPjSEhodsTNNLBPFOuTh1QnzxgDTP/ZjjynY/fuTTjaLY/TJTL96kCPN1CzktXFLanxNeDlOjDDoIaRElFRbYb/71GhYebvfscCNFrLrEryQxpKXUWn/ZqiGehpYtMPXzupskhyGrKIIArR72r60tl660CnJhpCPXYOZgbxVhMMCrTS2BGfFSLrlAmcuz+3zxGsYf9KCsXIneZrmROo9SfamVREL6CKYtdgC5wlJTFbMs+LubncwCsIm7lKoRavdKdX25+GbeIuFGcexrj3MeD0sI/EoCR1epb4y5Zlc3XSSG1I9poYk2LngRhg+IC2KIEGo0bLWShpU1gBQ+BDap/QNvdDgVQl5YV3Mms3BrznHuh0NUQf5M3pMY6V9Ai4ZcrjBArI1UddopGqsC5pmzWNuMvEnGaPD8bN3reOOoElVepX28tx1UnpH4RLSZCuf9vyE
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5269.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(346002)(396003)(366004)(376002)(39860400002)(451199021)(316002)(2616005)(4326008)(4744005)(66556008)(66946007)(83380400001)(8936002)(86362001)(52116002)(1076003)(2906002)(66476007)(5660300002)(8676002)(41300700001)(36756003)(6486002)(6512007)(186003)(6506007)(478600001)(26005)(6666004)(110136005)(38350700002)(38100700002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?t6xN5XHeq3cwmmEjsfguWT61DI5lvyWlROZOZJTZrpeH3cL2gGmz1GBZ4C/9?=
 =?us-ascii?Q?+Z6MCB7tXju20GTNWtkh3OdPjtPTjxpDyR3Of113oFb8yJ5fYwSXpgzekSst?=
 =?us-ascii?Q?D548d+V7g+o1htkafDVV1uI7dEQ1ZVtL/VpiX4/ZCX/M+/vK5VtrXuSI1Ut1?=
 =?us-ascii?Q?XX0wWMEGN+IsMn+cMfiay03nmeKP+VdfWnBQp1HedAeROqiabgODl8+Uyh2B?=
 =?us-ascii?Q?sHtFU+d8Y5JAkd6u2jPN+iC0QbE0/Q4w8VSriAhHVe7UQd5sAsNUd5+VgQLc?=
 =?us-ascii?Q?C6kUSfkeVbfhiwatWc+TCP5DaQDRB0KhM/zTWOyipoChx6Syd130Xb8XEuf4?=
 =?us-ascii?Q?O5ijMPx24olHPkZOreZ6cRo83xr+oMAqaIDmBNA3gKoVvA/w44SzEGicmpMN?=
 =?us-ascii?Q?62nh2qsaUWhqGYAUDAIzpjKEkuYPeZ4rRTGjVAbJ2zAhhQeE9yUxyWH6DIZb?=
 =?us-ascii?Q?ILR67b1ZonXMoiQj5ctlWioJpuCS9s2L0kXdsdhfqm7CpQ8vEiiE/Tz8t/N7?=
 =?us-ascii?Q?DyH/kCDGUr7mZAjC2QZf0i3R+kMLVVLC6jKFACox4JA/k61h0hbGksviakJK?=
 =?us-ascii?Q?PrhLWqePD3LCqiqCDLZ1F0x5E0eDf5lzbnS1s1y6vttG5GiD5LoxBuntIz1u?=
 =?us-ascii?Q?8jqdVD+A6+GHO6BagtgsppP5IbKLHfUGoLFLprU1c4Qcifv6fGWs6yw/JxgY?=
 =?us-ascii?Q?H/r54uRVyy/yytzw/6w2OsZXITBLEwUpORtAVGCzRwNzHd2NSB17FCrUE31d?=
 =?us-ascii?Q?1J5bEwQKp8OR2CenVr306gyPqftkdrfbyAzhRQwTgq+ldaJwyyqyVh8oQCZB?=
 =?us-ascii?Q?W+J/oGxxD/d7m8CoqC4n7ioIBIyPF/e2McySsxcb2SDb6PaqPdvnWNQHySbf?=
 =?us-ascii?Q?oTGqyZRXBc49UJ/KpZbo5VJpEeaeLlUammCQMCZtVVMHiQxCQH0sXTsSH72U?=
 =?us-ascii?Q?USa7ZEd8NElfAJ7QN5I7jK7qP/lbnikIFgKWRfJk9YTSZNL4AYm5XkMETxID?=
 =?us-ascii?Q?1JrbFOpy3dumulviDC+eH3gsWN4lLG9gnLNyPv2JDbKq0EjH5k72SP0/2/2M?=
 =?us-ascii?Q?mmmU4TwUx4eNwehoE+YxMMBCHdFTLmhauLA71oXKGiuPfFcKBROEWSHUbAR6?=
 =?us-ascii?Q?2mJFI4Wadj0T+yS+CY2qdajFPkwn/3WMUt9QiHxvZMIiC9GuwYiBV3SUbEwV?=
 =?us-ascii?Q?imthd3HgVFvElFkPr7uKN8c7N9mfyyUgTfA184k+sHbPHBBFsOrEKX8zHAQF?=
 =?us-ascii?Q?VWyhRqcBSvoNvtlfyhw1/HOa+ShvIk4FZWFE0dyGrC6giAru0r2aiWiZcZh5?=
 =?us-ascii?Q?6NSjCB9GwwEYbr44ySPdlE5QFrsu21fIn2dGhIuRf1eyilsa0wq+nDdNNkBS?=
 =?us-ascii?Q?Zi7G2kR1ZkfJugz2M6DQtxkOmyHMdAMaJwNh/oh42p/u+j4pZPJAHt715knc?=
 =?us-ascii?Q?Kki8x4ZgofCoTHrgqICxQ9VWTIhD4/pwh1t+s0ZLjUOzfnD1mBXBEWHYEn3V?=
 =?us-ascii?Q?mEoUzHExq5PG44f8cZdFBRENubxPpoUdajkTU5rAfIdBtBYLCe4wBQFYAanR?=
 =?us-ascii?Q?mCCdEyzroV3RHbR8+0P6njyOB+imomZJGDECwqFf?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6814a75e-4730-4f75-fa7e-08db7d3080ed
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5269.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jul 2023 08:19:08.0263
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: S3TMobqVYtLS899Y8Uo+WlcCrkVLShsdX0v9mj9c/yjFTD4spHm2RpamA5kf/BLFkj9KxNgtR8eHXO7I7rUN/g==
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
 drivers/dma/qcom/gpi.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/dma/qcom/gpi.c b/drivers/dma/qcom/gpi.c
index 932628b319c8..1c93864e0e4d 100644
--- a/drivers/dma/qcom/gpi.c
+++ b/drivers/dma/qcom/gpi.c
@@ -2160,8 +2160,7 @@ static int gpi_probe(struct platform_device *pdev)
 		return -ENOMEM;
 
 	gpi_dev->dev = &pdev->dev;
-	gpi_dev->res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	gpi_dev->regs = devm_ioremap_resource(gpi_dev->dev, gpi_dev->res);
+	gpi_dev->regs = devm_platform_get_and_ioremap_resource(pdev, 0, &gpi_dev->res);
 	if (IS_ERR(gpi_dev->regs))
 		return PTR_ERR(gpi_dev->regs);
 	gpi_dev->ee_base = gpi_dev->regs;
-- 
2.39.0

