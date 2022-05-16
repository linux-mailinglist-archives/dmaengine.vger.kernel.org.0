Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A8391527FF0
	for <lists+dmaengine@lfdr.de>; Mon, 16 May 2022 10:43:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241991AbiEPInH (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 16 May 2022 04:43:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241911AbiEPImn (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 16 May 2022 04:42:43 -0400
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2096.outbound.protection.outlook.com [40.107.215.96])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFC3FBE3E;
        Mon, 16 May 2022 01:42:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BmVcXp/3fNlOPIuAQO7BnmGxGurnorCq+du3GUgnZwvbzfRkycnIyLYB4SwJZrjGJRepWnB1oropTIBOy902YX4AyvhFSDCiaw/fsryepNT207n9gojoO23xP+s1xQdSjsyx4a3w8V07AudQvGss9lWUeCZSdSHWy9zUeJd6C8Xquy6EYgNbpGXqicvTOwpEPNMOHnubDs3Xm/CfBecew6R+k1GlSF3D+4rtw/k3+H+WrvmSisbAgcrcGNzKJa1eg5Jl0lj8TwZSOI5fjED9pzqp4M97Ghlk1dDgphkTzfy913msentLaZm3Rpo/J+s+6Y1NO6z/a2Q7bNbOR3NFXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eJdRUJyYLg08dI884eNAPRNvcq/zODGnc3rdagTwgDY=;
 b=J8kLpkSkz4IH0JlL7tL+s6XiKt/AWutcKHrp+OQDYpaAm2cmo7J/TJD0KXSxcQvjqMA/n1sn2B3LAJ6F3YoDyJJDaeMURUcojTjBRW7LDzYVsS997hWcitJQZ1fewbgzT22EwulwIEWyPi7L67DMGnXWj5rvHa/OKaxYcL63LPYK/QeXXiu1osDHXReN5dqdAIIkITBzDCllvyEXpNrQLpnqARRB4QpK2LT6U7eGED5/bPvUHTabV4Wr72gknIcRDerjedVt6gpJB78mnCrBydAKlY6wYpDvYadUODCRJauBzaZgxsAloYh5hzp/Is3zPgOGjGp8ttgBVVD80Jckuw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo0.onmicrosoft.com;
 s=selector2-vivo0-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eJdRUJyYLg08dI884eNAPRNvcq/zODGnc3rdagTwgDY=;
 b=Xd4md8sAwmUT6c95P391xURIangMSOR9ZdEF19Tf5nPSHV5xwDGBQEY5uXQN5B56k3l4YHUflQQtwXPIGHw8pqp+6JSHbC0gGmbtx72nT8wkGlsTOBnk5oCU4oM6dG8FWwYjWJENFoQp5svHlo/hNBLajtoea7e8xVVr9RhvUaY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SG2PR06MB3367.apcprd06.prod.outlook.com (2603:1096:4:78::19) by
 HK0PR06MB2977.apcprd06.prod.outlook.com (2603:1096:203:88::22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5250.18; Mon, 16 May 2022 08:42:32 +0000
Received: from SG2PR06MB3367.apcprd06.prod.outlook.com
 ([fe80::ccb7:f612:80b2:64d5]) by SG2PR06MB3367.apcprd06.prod.outlook.com
 ([fe80::ccb7:f612:80b2:64d5%4]) with mapi id 15.20.5250.018; Mon, 16 May 2022
 08:42:32 +0000
From:   Wan Jiabing <wanjiabing@vivo.com>
To:     Vinod Koul <vkoul@kernel.org>, Orson Zhai <orsonzhai@gmail.com>,
        Baolin Wang <baolin.wang7@gmail.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Cc:     Wan Jiabing <wanjiabing@vivo.com>
Subject: [PATCH 3/4] dmaengine: ste_dma40: Remove unneeded ERROR and NULL check in ste_dma40
Date:   Mon, 16 May 2022 16:41:38 +0800
Message-Id: <20220516084139.8864-4-wanjiabing@vivo.com>
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
X-MS-Office365-Filtering-Correlation-Id: 219dc012-4690-4794-0f67-08da37180475
X-MS-TrafficTypeDiagnostic: HK0PR06MB2977:EE_
X-Microsoft-Antispam-PRVS: <HK0PR06MB2977D92BEC481A84E921DC9DABCF9@HK0PR06MB2977.apcprd06.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: XA4+Jpye9Fa0ZLNmm5e/LcUvylhBQrOQrRuVYgw38FM3qUenMH8q0QSISFmmpTdVmNHhCgpxIOPjCScs61IOSMltcmzEka/1vTJxgwF6WP7j5HA3whQ0qkQTR+YCGyFFTHXlNJlRmW5IVFoKY+rlhOalOicemRYclYJzKdBr508MB850RasQ84ZJRuJPa+bJRuQNgtPfCcJpstbBiyns9ZYQSbRXl9YbK8mYFSLYL5dSHIlPmzXiRb0QatoragUw+GAzG0+8XpijhqD6SCvN5cRZnzNrYCwLcCrpNNde1TPVo32lhVX5FQgD9N8qkuvGP2IkKQ9gB5YVF8zLzHmwsSH7on/b0xEO8pVvC9bbZHLeOXAEskHt9OF+uOKoSfxtTB6iV+z20hojhN5CgDn5H2MYYftpXSM0baI0NzSRPdj34K9kH/3bvp9xBu40xXKvAiCgHtZAIfR6Q10W87HdKAJc+QxF3RUeJc6lEUyJiaDEHacf4ivzvLjHAvJFE1bY4kN0Y5Y5z8/lE4ZEkV852MlQCIAeVGu2Uv9nLrB4X5y2teq6yA0+R1sH+WrB6b61hg9GUYXAmCo5kdgf6Nwn+OSblChvT9UKSD3u99WccC4I6eoexRQ/md+kWsth6c1zJb7h8tRT1FYBXHmwIlmlRwFdwT545sy9cgc9yCIJq3wWzM6US0pyHNKz4wvLpOAxQ6snc07FBGfiloew02p74Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SG2PR06MB3367.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(2906002)(38350700002)(38100700002)(83380400001)(316002)(110136005)(52116002)(6512007)(66946007)(1076003)(186003)(6486002)(66556008)(66476007)(4326008)(8676002)(5660300002)(508600001)(8936002)(26005)(6506007)(86362001)(36756003)(2616005)(107886003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?DGcx2LJEOVjNSKvkIb6xoPAqS7UsbxiZFLssEhYnlsxkZR87G0fSJU1CBIqX?=
 =?us-ascii?Q?hU8LcrpmAdQfgpBzKs6bO1swbE9b7j4XAQlfMPVcgZfd+T3Ast9ASGeIc+0z?=
 =?us-ascii?Q?Z9kKlvzg00pNvdT+PIlTRKhpnh6kEcm7fWlIR1BqpLnfeLzKx2+aI6QFjLFn?=
 =?us-ascii?Q?qN2nf1dOobMzv9MH0rYYOOTulTTdN6jTknTuqgU9O9jCOsAQuHAJiNPk6Iki?=
 =?us-ascii?Q?uiNApqCcjhU3X8u+tNXPTN3lrwC7B/QuGKUeune0xJiQBdqSUvRhVCai2Jss?=
 =?us-ascii?Q?stiynkUdE2DIaWDDHbvvT5dfglIghOtKKqgEO5qJJL03LzGfOh7ASUNMfak/?=
 =?us-ascii?Q?MdU057rJwO6DlduPusce9NxmYlDW9QxrVDJVIEs8gkzxaDi/4Ro6sQ5y1fl8?=
 =?us-ascii?Q?kzMoQO24tQFJsi22Oes45ifuDM+b/PAgFZTesqh7NV3VmEDA2cR+/LyELcx+?=
 =?us-ascii?Q?V5LwuiLjV5XlTNbXZUiA2i2Owrq0/rYD0RrTLNBApfD3izyUeSiMJxwiXbWo?=
 =?us-ascii?Q?enY4xSUwmiNcxg9U5bo3E1hJuniTcin8ZBBcEPGL+d5IxfNTUKQ2gy6yHZs9?=
 =?us-ascii?Q?Epff4h2F+6fTcF8hXzmYsIAJDJMAFyQLL/OLJpH+bKY3/9idFS4M0l0utdCM?=
 =?us-ascii?Q?MBd2OHKNkJn8vlVy8Y+elsc5WO+njz1oV5eqAUwqIdhey/9X0ehLolVzFNHh?=
 =?us-ascii?Q?hgwaAJomJguDIixqMfr+aP5XeA6Yz5bU7VZyP0pf8r5qeXVzRfHz/MYctsN2?=
 =?us-ascii?Q?aiZo1rfWoSpXsudJJlsVtsFwAUtDIdOJ71qslqnsaZoZfkP/G3TkByib6W+0?=
 =?us-ascii?Q?1e4Y2zoVKqwGvmNXXiMBoANpDCImoec0xAjKBArzS/gXOmXztOxtpiJ7cNN2?=
 =?us-ascii?Q?5nURwKWTzEzlCPgw30s3fnaFvbb1YW0npyrlaYDAtpDG/tLbtzPNUJ2Rsmz0?=
 =?us-ascii?Q?AF9T19c2fB1Qik3qv9hKkad+4ntFvdHi+kgd464+d4T2iNuHL5GWLpNqaSyQ?=
 =?us-ascii?Q?xhWb0STADgSpk5M0lYI7w8kGeeTiMv5QF8FJ7VJzJ+aB9Nvo17bkhw6GscMd?=
 =?us-ascii?Q?gBe/SobbrFNPtXcMXcwBUyDViMm/2JgRq3wcW+mLFn6Mu23taJStyjQB/2HE?=
 =?us-ascii?Q?dk3WPswZDu9CzufAz3MXKJ5DiIUNadAw9Td4fiff/23TkIgpquXt1SdO6Snt?=
 =?us-ascii?Q?s4KOau4lqQvoh5cQ8b5bK+f58cgS2pT4/rzFQxkRzN38nTwuWPAprdtxkcri?=
 =?us-ascii?Q?eR3zHTy4vXi8fNXLq9YG/TGGBSVwvVXuL7ffnL+GeaOsHPzQYp0PH+ODoAZI?=
 =?us-ascii?Q?6VdYlaMmNfp06I1eP7F119ubSmgJOE3SaoYfLwZoIjFzhJSPkTYnxm66e4PC?=
 =?us-ascii?Q?If249eyDEgEl1havo2dsGv/Z4m8RcVhKQ/BOA/DZO1rtj+J6jQhG3a4jK9XT?=
 =?us-ascii?Q?7spNpPokTimlNuI3e2I10SUneH11Q8syiQblIuyHc0+Esa9ZUBKTxNjg66YY?=
 =?us-ascii?Q?FDxJeE3SQ7cSbwIXne6LdEVqxWXLt/UULLqbWzhHk6lMz04nUnsspRGh4+W/?=
 =?us-ascii?Q?N9s714OHhxugchgDTMh/EzHEtWakjrd7/FaFWqLVzsa9qWtRFimv/GG+A8Qn?=
 =?us-ascii?Q?EmBAeuZBfq8cMWdEpbhEPIupaJluYus4LDRNvDoHQ9IltCdr84hKM5OvLoje?=
 =?us-ascii?Q?Z0ojoISvf5Sw4vw7DvSJDgJuz+Tz8jEfz0dm4ag7CgmqrWFbolT2GsLUvgyg?=
 =?us-ascii?Q?cmHenZE/mQ=3D=3D?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 219dc012-4690-4794-0f67-08da37180475
X-MS-Exchange-CrossTenant-AuthSource: SG2PR06MB3367.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 May 2022 08:42:32.1900
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZivrUyBmm+lqWEf5fnjPRmPhlBWUJszsJW4fcJSxLSf7UT96hQkqByyW756a357EeIpJQvBD0NuqasmmODpUwQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HK0PR06MB2977
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

clk_put() already checks ERROR by using IS_ERR.
clk_disable_unprepare() already checks NULL by using IS_ERR_OR_NULL.
Remove unneeded NULL check for clk_ret and ERROR check for clk.

Signed-off-by: Wan Jiabing <wanjiabing@vivo.com>
---
 drivers/dma/ste_dma40.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/drivers/dma/ste_dma40.c b/drivers/dma/ste_dma40.c
index e1827393143f..7d1bf4ae4495 100644
--- a/drivers/dma/ste_dma40.c
+++ b/drivers/dma/ste_dma40.c
@@ -3119,7 +3119,7 @@ static struct d40_base * __init d40_hw_detect_init(struct platform_device *pdev)
 	clk = clk_get(&pdev->dev, NULL);
 	if (IS_ERR(clk)) {
 		d40_err(&pdev->dev, "No matching clock found\n");
-		goto check_prepare_enabled;
+		goto disable_unprepare;
 	}
 
 	clk_ret = clk_prepare_enable(clk);
@@ -3305,12 +3305,10 @@ static struct d40_base * __init d40_hw_detect_init(struct platform_device *pdev)
 	iounmap(virtbase);
  release_region:
 	release_mem_region(res->start, resource_size(res));
- check_prepare_enabled:
-	if (!clk_ret)
  disable_unprepare:
-		clk_disable_unprepare(clk);
-	if (!IS_ERR(clk))
-		clk_put(clk);
+	clk_disable_unprepare(clk);
+	clk_put(clk);
+
 	return NULL;
 }
 
-- 
2.36.1

