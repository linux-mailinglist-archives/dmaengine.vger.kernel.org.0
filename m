Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 61C2E7B55BD
	for <lists+dmaengine@lfdr.de>; Mon,  2 Oct 2023 17:01:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237908AbjJBO6A (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 2 Oct 2023 10:58:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237894AbjJBO57 (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 2 Oct 2023 10:57:59 -0400
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2066.outbound.protection.outlook.com [40.107.105.66])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E96969D;
        Mon,  2 Oct 2023 07:57:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AKlkUabgcq8GY3gjHDgxowAOwAHUVD+5pJa82TZhFskaSiFrG43QGsINVH1NEOE/xIzxQ4H9xfCqA5cRE+W8LZfohAjAfmkBhr98/c3Xilnx6f2BmFrmUttu4AMKVijxTtZx4+77s6Zo5mayYzRzPsOO12OtGeATJrperTYCf2hTjty0hNCWJb5csW7f9XsxcIBLYDjf6gOHP8chabZn0C1t0UKeJ7wI6DRX1EVZFuR3MOref4C9nlfbNQff0V1BVfpcmmIC0bvknh3vJFCQqeRA8L8SIU2ono6Ew50m4HIhwSgeAfWLMZsHoZ5Rs0TQCsJ4GMKEtXj05Pjo6EEv6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=agg4p5GigpgpJnC3NANg8pARD2qcBdhnIzE5/bQX57g=;
 b=gH8GTVbLhaXB4k5JiTB16DUoXtIADtUtpzHuAKE3Et3f368yJXgULv1DLBX5WvZJgfpsevEsuJOsFvce+v/JJmRA3TfCgfXoeaU1iCZWjF5dtX4lGRj0vFvihiMVn3BTXHZF0YRPV5tXDQx7/8y7j4+jGovzcmMWCfLVhUTpkRGXNnLtv0Ub0UrIadmtgs3IOPRFEKaHMYdvODi8pdrbz4dOsjTkfEAEjIr2LkeZvbHvs5orZVXthR+1kwQoTQWoPhNrhi6jtp3Pc7CO/Qo3dHBMI7lRlB1K/yjoo8yucyuCM1CefqMEBQuZBu303rbLSKolhDoYEx0SH31yyuD/eQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=agg4p5GigpgpJnC3NANg8pARD2qcBdhnIzE5/bQX57g=;
 b=GapmF/aS1DtzXGqijDe323F4zlQlL8yMtv34U8OrYz95CkwY1qKR6whp53XywDxhor4SwE+RMZzABvbUgpbgrzT85VJdOzdxyx4u605Nh9DwlPWYDBNtw8nZSjcFxgvs9AK23tZyu5dMkLxCLRyn4Wn6bgJ3yCaYqI5s1FZ2gG0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com (2603:10a6:20b:4::16)
 by AM8PR04MB7986.eurprd04.prod.outlook.com (2603:10a6:20b:245::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.28; Mon, 2 Oct
 2023 14:57:53 +0000
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::1774:e25f:f99:aca2]) by AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::1774:e25f:f99:aca2%4]) with mapi id 15.20.6813.027; Mon, 2 Oct 2023
 14:57:52 +0000
From:   Frank Li <Frank.Li@nxp.com>
To:     bhe@redhat.com
Cc:     Frank.Li@nxp.com, arnd@arndb.de, dmaengine@vger.kernel.org,
        gregkh@linuxfoundation.org, imx@lists.linux.dev,
        linux-kernel@vger.kernel.org, lkp@intel.com,
        oe-kbuild-all@lists.linux.dev, rafael@kernel.org, vkoul@kernel.org
Subject: [PATCH v2 1/1] fs: debugfs: fix build error at powerpc platform
Date:   Mon,  2 Oct 2023 10:57:37 -0400
Message-Id: <20231002145737.538934-1-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR13CA0195.namprd13.prod.outlook.com
 (2603:10b6:a03:2c3::20) To AM6PR04MB4838.eurprd04.prod.outlook.com
 (2603:10a6:20b:4::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6PR04MB4838:EE_|AM8PR04MB7986:EE_
X-MS-Office365-Filtering-Correlation-Id: d6bfdf01-00c5-4cfe-c8d4-08dbc357f400
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: HbXIUegZPy3wPr+SbMoybK5sT+yNimn4/F5JLehsfFptltuNrLIpumsuPTUDI9tYWJkzWXyRaf0efSQYg/PYRSGOrR3Bn5+fuHoAnYgVZTvIbQUoOWDmgJ7xS4QxOjKxCCTinN9GcwutzzUqYJHjdfh3UxYaVDW1QSl026H65J3nW6kaHtFL/YrP+JcQ5lm1ou0UP1rLuIRHRasYziqbQSjTnY6rJOA7qMkAgCVrPN34DhLaLKyccLn4DGdCgEHWGuopK+r28StCeM6IFRSuuotDBi9+l6TiJmPyoQD6beyQXk5qNrJhuuRIqtTUfSUtfWuTgS08WOsNmbLZ6B8HqSLfIpHRLgXpMWzsqvj669F0lA+ctudx14s/5KsS7O3SLEgz1OtUFLGPkguKm03CObXQn1dxkkqNKqupNwsBt2CL8dPbOGy7KqNQFNi3QUCEEUM4A8Lj0m/mHIuy5SmMkZHhamR7JLLiZ6hZxqVHXGtzKBP72h2UI3V7r2BWyBDszkrwPNba6PuQDK+Z9Em6CbkcOVPv7Y5sJgxw9CVemN64pqeKsWRAOdJ00qM68I4qET750LP5s9pkpWAqYqfjiujNHpJa4LTcTw8UfpZnBB0=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB4838.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(346002)(366004)(136003)(39860400002)(396003)(230922051799003)(186009)(1800799009)(451199024)(64100799003)(2906002)(7416002)(4744005)(36756003)(86362001)(6512007)(38100700002)(316002)(1076003)(26005)(2616005)(478600001)(52116002)(41300700001)(6666004)(6916009)(4326008)(966005)(6486002)(6506007)(66476007)(38350700002)(8936002)(66946007)(8676002)(83380400001)(66556008)(5660300002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?YMwfuw8fsKFyVkG4Wwmb8e32SCVuntEWBCQxzhQnuJiw2EXDlAqP2YzCY2If?=
 =?us-ascii?Q?cPVpv4BOsaeGbG9Yvt5Xwj6/tSLsnQFz7nhTERzoX/f4dKzYQ20fFxhTJiYZ?=
 =?us-ascii?Q?Smo+sMP+ELovv6oNbtoETPrnpOh2BqXnHHIjAD0TO50BB6aOTvVma8A2Y0FK?=
 =?us-ascii?Q?qT/t98Zllpn++k/h1Vj/r7kAKv5EW4Gar19WI3afmWg8JUktH1BtQygeQV7R?=
 =?us-ascii?Q?Qo56CzyCLw6YpBAEXupQNFAr/SXyXkXtdBlJhZP7VSCMxgfGzwOoBbLoYPf7?=
 =?us-ascii?Q?AkwjEB53t9eK8WqqJBoKAFxvTwgpj6SU/DjR4eBSH3MNvSZui4B3bUbl0qkc?=
 =?us-ascii?Q?lsUZZaCMrPQkNN6y7USujAsgBV1s+jkWy9ZDqdTMrPlR5o4T4HNdtcf2YEKb?=
 =?us-ascii?Q?YlCPAPYwvAMR11xAGBfMvTn5IBogSXCT2tmt5BDohvWssxdMxUVnuG2NHdXb?=
 =?us-ascii?Q?EAAm6zXvMRHIo8xNEwUNJ9HaRqB93Gvtwfh9ay7KwvA8FkCNZIlYWf7aoeMU?=
 =?us-ascii?Q?jvEuaM0EANSVHPxltT6fSgZXznKRZxVoes679v3Ybhfi7mKE6Y3x4EMFfDtZ?=
 =?us-ascii?Q?YC2S2Nk1yyWVKWWeNJwSqAWvgpGh8BfQe7WDQUoaISOWFe8ThxqZ9/t6dWuq?=
 =?us-ascii?Q?6m0BzqWdJ0MJqb19NJRAHrIIKo3nBRI2Xi2uDhMdaqsDBlDmh8pvIypa+Edu?=
 =?us-ascii?Q?MlnmvUNqRTbg/9MLaEZjdswUEgMhtcaZX+qeHnSVB2ZrFe9+UEPdCqHTECWK?=
 =?us-ascii?Q?dgYc0yvAbSx559agq2BjDFnKRlBOtIuvCCrXUgbAX4bVeOX0FCqgTV6qjBgc?=
 =?us-ascii?Q?6KBrFOw1Cx0tNkqKwiNcKYLNBNrdOuYzdzdXfzV824eVoZvGPVQbGtv33ssC?=
 =?us-ascii?Q?EESLb0U024+oimKqtUOtDmfiTKqZJ/NQquj+91KmgXleYeC2QCad6zDsH0sK?=
 =?us-ascii?Q?GNMvf1LX3QVLmBNjjkLZNIrtPcS75/k8beeQcC+OKA/WpLTrsztU+nfY78PP?=
 =?us-ascii?Q?Xs5/fDZH+D+pOlJtfUeSsOrLFJFpzHRU3JUjbz37CE0o+Ym8EOkQaENVNfa4?=
 =?us-ascii?Q?RzV6sPRGMoFD46ZzmJu1NXizrCq/+0NgcpsRclMQJMo6S5XY2Ft5ll570ok3?=
 =?us-ascii?Q?AScsc2TfNq+kYogq+hABGF+SLEEy1xHbrQx3EJOvCtqdX+NdDgmkzKy4nBZR?=
 =?us-ascii?Q?AX935CIfdENCnblJasR1zn02ByE0x4bOQeOXMZ61y0hIFIqT6cUwrC4PT0G8?=
 =?us-ascii?Q?FlQUTtUbRgtYco5aooo0pWzyNGNH7/Kf1NXVGRPABMlXHUMAfmDYpNOWWWvn?=
 =?us-ascii?Q?dXpwRzAZL/MsHSwKBn4WlFMmOqatxNPl1GM9mkykAYVxZf1a1t9SUwqj9UDc?=
 =?us-ascii?Q?KjmdUf4vsnSEsQo7gsy/ST/XAlC01RBmry9EAQ5YXsHP9SOxSbPHVRP77QRF?=
 =?us-ascii?Q?ELXE4QYr1P3rFp64WG/J0HQbmeO3PxhwJCQw0wRpdzoCBDTzS0A9s0CmZZ8/?=
 =?us-ascii?Q?ar9LsqSgkRRccxOrenhwwa3ANp3V+aGtG4zrs+dXKW++9q4/Yqs5xXXCY4hh?=
 =?us-ascii?Q?HWwfrsSYEe+x56nEVq4=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d6bfdf01-00c5-4cfe-c8d4-08dbc357f400
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB4838.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Oct 2023 14:57:52.9151
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HbRXADmWevK3rNyi8cB/yFsSL01NMJDGpQ5kioKPRIWLDOzdUOEGGbwzQJV8cc/1haaIyrdfbFAIT1H09C6t4g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB7986
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

   ld: fs/debugfs/file.o: in function `debugfs_print_regs':
   file.c:(.text+0x95a): undefined reference to `ioread64be'
>> ld: file.c:(.text+0x9dd): undefined reference to `ioread64'

Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202309291322.3pZiyosI-lkp@intel.com/
Signed-off-by: Frank Li <Frank.Li@nxp.com>
---

Notes:
    Change from v1 to v2
    - fixed it by #include <linux/io-64-nonatomic-hi-lo.h>

 fs/debugfs/file.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/debugfs/file.c b/fs/debugfs/file.c
index 5b8d4fd7c747..ca6208c49339 100644
--- a/fs/debugfs/file.c
+++ b/fs/debugfs/file.c
@@ -15,6 +15,7 @@
 #include <linux/pagemap.h>
 #include <linux/debugfs.h>
 #include <linux/io.h>
+#include <linux/io-64-nonatomic-hi-lo.h>
 #include <linux/slab.h>
 #include <linux/atomic.h>
 #include <linux/device.h>
-- 
2.34.1

