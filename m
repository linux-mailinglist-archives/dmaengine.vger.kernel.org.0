Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C922E527FEA
	for <lists+dmaengine@lfdr.de>; Mon, 16 May 2022 10:43:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230033AbiEPImp (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 16 May 2022 04:42:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241853AbiEPImm (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 16 May 2022 04:42:42 -0400
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2096.outbound.protection.outlook.com [40.107.215.96])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DD1BBC05;
        Mon, 16 May 2022 01:42:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=m1tdQjp7qJTIIpZAsOBxjJgUxaiXxpeH9bNcB8kYxYhdqSe1jmxR+VVJIgXgWXiILqoLHc15ioXgefYCcukgXkU6EasZgpwZi1OIOLJL7TJodwkmZ9PyJ9C+mm7YpWYU8WykKOekx9ceEBKYHlTlg33ciJr7CZN7v3KzWVNraMMomZM7Ax1/aggzzkyLFpcIzO5FMU0GzQR6ZhicemugH8459CUaqjoDjVgpn1sYpS4gN09uxyzqgBoXq5DpfpJhaiKm+qE17jbNwf2vTYWemR8Ab86D+NvMg2+FgSD5U9XRhDxnwLQ9syGcH/lKfeyMNBY8UE0/BOMV6RNphFxHPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EnyYYnnPn8Ne/FL30rnVe038b9vuP9C2o08MRu9Uvmc=;
 b=bSQeq/RTcC57TxW/iaR2rKvkQI71qPB+YUcGqI8A4TxwVzvJRZwjGrF3BqzVA6rNeup5hAHWNAh+8d8YrsdQh1UI3HwXE1KmpVCH4v/MTQ89Z96JN5ng6vqTwVmRWEkYvsPmRdLHsyK0Rikzo8vFp6zWaMKgMU9b3Fz0e6CXs/VBT1VkJ29hkDtCqCY9Ph9gypkMa9KimjtBAHipIdrKX4QzJZe0kbNzrP9OHbsaOhcTdkftQJIZeUkoWE5Ar7vC1O4kW8M3cdQuRZkqh6pead0oQvGlXc0lgqP2xAIyY+wpFQDkrdv+iDSt9rj1HlfcnSX9pcFAlmU63mE2DqN+Dw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo0.onmicrosoft.com;
 s=selector2-vivo0-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EnyYYnnPn8Ne/FL30rnVe038b9vuP9C2o08MRu9Uvmc=;
 b=I90CwfE+4rHq4gFZjX4HSRk5fA2KHoUlkhkD1OB3jbMVpSXRbsRiFYH2pYyNk4fKLvWvu0rT1xNLwEPN2D1S8CK8gkb1AvnDh4e+AwEFnwwqenOx5rdBaXPa+QrqI4UZh4QOJa7O6YVH7/2QHVqgvuv3eTwEs6DfxVD+FJh+b8g=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SG2PR06MB3367.apcprd06.prod.outlook.com (2603:1096:4:78::19) by
 HK0PR06MB2977.apcprd06.prod.outlook.com (2603:1096:203:88::22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5250.18; Mon, 16 May 2022 08:42:29 +0000
Received: from SG2PR06MB3367.apcprd06.prod.outlook.com
 ([fe80::ccb7:f612:80b2:64d5]) by SG2PR06MB3367.apcprd06.prod.outlook.com
 ([fe80::ccb7:f612:80b2:64d5%4]) with mapi id 15.20.5250.018; Mon, 16 May 2022
 08:42:29 +0000
From:   Wan Jiabing <wanjiabing@vivo.com>
To:     Vinod Koul <vkoul@kernel.org>, Orson Zhai <orsonzhai@gmail.com>,
        Baolin Wang <baolin.wang7@gmail.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Cc:     Wan Jiabing <wanjiabing@vivo.com>
Subject: [PATCH 2/4] dmaengine: sprd-dma: Remove unneeded ERROR check before clk_disable_unprepare
Date:   Mon, 16 May 2022 16:41:37 +0800
Message-Id: <20220516084139.8864-3-wanjiabing@vivo.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220516084139.8864-1-wanjiabing@vivo.com>
References: <20220516084139.8864-1-wanjiabing@vivo.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: HK2PR02CA0143.apcprd02.prod.outlook.com
 (2603:1096:202:16::27) To SG2PR06MB3367.apcprd06.prod.outlook.com
 (2603:1096:4:78::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c54c36c2-f165-4437-5028-08da371802e9
X-MS-TrafficTypeDiagnostic: HK0PR06MB2977:EE_
X-Microsoft-Antispam-PRVS: <HK0PR06MB2977C83F8AC03C076508D6AFABCF9@HK0PR06MB2977.apcprd06.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: e0hxjS04R7H8YTfbxUGohwyUUlWeT4khR8nqwZR1BoP86y++sjvW6X//vX7Vu0gkrz3vORIq396tzNTdeSY4MddYxOfsZ+TSXkd3Y1y8VrZVW6YlRZG0EJTmveyuSlJJ2yDE/UaVgBuWQcPg0aR0Do/1+3ELde+K478355CkHYpSIifwsqhnEaM5NS6Mwnbtd0VqHJqBtownO0eLXEGipCwAYjIgNVCwTQt2XfeU2GKwC/c9uqKzhINSL2p2EIq5jSV3jFc+b0R7Cky4LNv7/IG+hp9kOsat5JmjtTTVouo7lDnU35E7nISwKF4QO9k1zMEal9oRVCtTvOGnnLcw20h//d9avPLG2DI+sK1RSsiydJKlQp6GETlA52KqAAXDslyuXOP0hRXO6EYYWpdM6iEWKLunU/jJv3nZXy4XIqfmkNjl5MMshF4lmNth+GtxKKsTulbMnAEH0rqdqXRIdLskjCcS6hB3nND852CSBqEHmWq/MBrlCmy2Dh+jxsj19tqWltsm/n1ul3udnTEWImNMTON0lmdhm0qMdSY3Zj5SnFKK+jEIIrenwJ772t2uAo4QsRk1st0L+uGQyHt9w/AaN6+Irihk858UGhBPYreZSwROERLobjBxuww20ckM8nQTJPg/ssjJjRkxIZxkItpvRmwwuE009T7pXDotl1b9dSh7U9n2gnVcohm/R5hqABvknoyaxYdoNRdp5HCUBQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SG2PR06MB3367.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(6666004)(2906002)(38350700002)(38100700002)(83380400001)(316002)(110136005)(52116002)(6512007)(66946007)(1076003)(186003)(6486002)(66556008)(66476007)(4326008)(8676002)(4744005)(5660300002)(508600001)(8936002)(26005)(6506007)(86362001)(36756003)(2616005)(107886003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?uj+WCdy1U/wIRlfQlN16POanJ48JXVuOTcuo5k5gEE4fbvzyNpsKe/RKGutT?=
 =?us-ascii?Q?CBS8hUg1pmIrz2x38awSU02gmfvNmYQy0O6UkCC6lxR5jdtmSCjGyGeM39N6?=
 =?us-ascii?Q?GDYXaLdN1ugR1/7iZgHUiqKCJL0hf/ukJnRyd7O96zxMlh/a/cZ/n7NaHUkG?=
 =?us-ascii?Q?uQCpFm2LNIFFb2oKvL2SgIfDM8emAINe+7JJfiT4wnuJ1hNLz/4smVCbR1Su?=
 =?us-ascii?Q?N2BMu75we2J36F/xu6N9IlliBVZYZ6MzShus3lI67D84/v5wDAi/akqpWsjP?=
 =?us-ascii?Q?j7hYKTeHuAwgQtdGCW+WVHx0S5JMIVt61pwnj1nUNX3QBM9ckRrl3qBj95T3?=
 =?us-ascii?Q?qBCwiQULOjNFenOCwrPT5+v91aSEGa25v14tR+h8+uODY3e6Kb7oLuIAos2i?=
 =?us-ascii?Q?hrEYgKBW8xeOVcTSBFsD/w+WaYz0tzVh1fPXRMlII3ize7yf1Lxp0D/ddBtw?=
 =?us-ascii?Q?rUHLW1pGoM4fIeer87om+CYbk+ffaJvOGDMJNE2DhMOBPilRtXsCIg7rtRDt?=
 =?us-ascii?Q?svHMHMVEKoGtliPWl5gR3GH9+zuOUeSnJGop/g4OSNrz3Tzll4PLmuzA8fAu?=
 =?us-ascii?Q?H4WNUFNPGx7HHA4XDAK2s2LjuKaJOPYWqFg6WGkzAxDbqrB+yTO4todQP7sq?=
 =?us-ascii?Q?r/5d6RabMvZPtCEvVCajcdBZZ7HZ2jheeMr1JtY0TES15D/aFV1eqxz+Dk0D?=
 =?us-ascii?Q?5i3jyWEIbwNGWWh8+LxDAGr1tZXVnjLiO00u1jKcf5TrYY0rcjR93B/9Iixf?=
 =?us-ascii?Q?a6+cAqJRjc2TScAIJ5XLpkBoabacPyAXiqkfes22N1S9rbIKcYfDu822ERoe?=
 =?us-ascii?Q?IHSc6zag3D+p17q9sy9cJPWr3nXM3aA3YNRnGgY94mHKgV5Bm/VDRjrg7AWg?=
 =?us-ascii?Q?hkth2c1xzh1PLQ6opJD8y0IqGKcPSvWcMwGxbcIIvdzPCTwBfQM9oTPHmY0a?=
 =?us-ascii?Q?3SKx0/pQRiRkTxB/slkjHk9LO338HTmbvsSngn9pLf91V2ylwYdzsKtx8RRo?=
 =?us-ascii?Q?7Gz0e9wp7Hfs9qlPW7YvGrzoX6YwmfzDRmhYt1jySIRtJ7Cafb1Ia81/N0S9?=
 =?us-ascii?Q?u851tYwmaM2WCgiv0hfWHXEP/23jHRWOi2jK8DCb9dK1LZi+Dtzsb/Bbds5j?=
 =?us-ascii?Q?5saqYACyalJdxymlEa71H/Kz8pa5sN+SJ1p+0qyFwslsZ4kA9nbC6WZgUFZc?=
 =?us-ascii?Q?y6T/SNYZMRBcNcjdq7kp90SzNxnLbCQAnnyGFdB4FFuZFG0Ixn7WVUCrGkl3?=
 =?us-ascii?Q?l9cUk4Y2QPJ8LnEieNvM/pstWSRTWKwr8+tgaQ66YggTQ2kEWZrFdFIQVR6g?=
 =?us-ascii?Q?MUzqAO3n3UiW63w22Va3m4Cia6CuCboKdIOBWfzNCMGWDdEcflvHHctm/yHg?=
 =?us-ascii?Q?w06UvZmAV8EUsF0GVddEnErW8GJbtNSVjA4QoR4Z7KTdEdZ3QVG0yO1hOhcZ?=
 =?us-ascii?Q?Xsu6aCUq2IkFR5ukabVSEHNfwhGtdmsTzGkhUol0+Ltrko0Agu0G/4ozpdq5?=
 =?us-ascii?Q?wc8Gp3EQ7rV0fO+3JZxdUiPxgyYhg6HQoDsHHQeoce0uHvV1qAe1by7OPvMO?=
 =?us-ascii?Q?rtedtBz8OZpgeyVd42bnfKjw2xeVPW1Q5C9HSb6qlOqbPCXwpF0sHlmF6Qvv?=
 =?us-ascii?Q?j/N5cpEI+NlOT14O2NDsPvmKZ/anV7i+dA3rWKqjcev2mVvI016zrlBId2sl?=
 =?us-ascii?Q?SrcbWa5QeiJ7GrAEuzfalAmsJkc0V4rjSfphYmbCDw0VXzmSwvNjywzbuh8n?=
 =?us-ascii?Q?v7t1/3sAjw=3D=3D?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c54c36c2-f165-4437-5028-08da371802e9
X-MS-Exchange-CrossTenant-AuthSource: SG2PR06MB3367.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 May 2022 08:42:29.7527
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: msFshjehFkNTVXYViAgbDA/6+05DK7oP6Z6gd8g50lWuXqFP+GnJgKbZcACwV4INpPm6DJXxcZ9MLjMFVyIxZA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HK0PR06MB2977
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

clk_disable_unprepare() already checks ERROR by using IS_ERR_OR_NULL.
Remove unneeded ERROR check for sdev->ashb_clk.

Signed-off-by: Wan Jiabing <wanjiabing@vivo.com>
---
 drivers/dma/sprd-dma.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/drivers/dma/sprd-dma.c b/drivers/dma/sprd-dma.c
index 7f158ef5672d..bf5ad879b5e2 100644
--- a/drivers/dma/sprd-dma.c
+++ b/drivers/dma/sprd-dma.c
@@ -279,12 +279,7 @@ static int sprd_dma_enable(struct sprd_dma_dev *sdev)
 static void sprd_dma_disable(struct sprd_dma_dev *sdev)
 {
 	clk_disable_unprepare(sdev->clk);
-
-	/*
-	 * Need to check if we need disable the optional ashb_clk for AGCP DMA.
-	 */
-	if (!IS_ERR(sdev->ashb_clk))
-		clk_disable_unprepare(sdev->ashb_clk);
+	clk_disable_unprepare(sdev->ashb_clk);
 }
 
 static void sprd_dma_set_uid(struct sprd_dma_chn *schan)
-- 
2.36.1

