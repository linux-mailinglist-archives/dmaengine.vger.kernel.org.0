Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 75F1D4DCD05
	for <lists+dmaengine@lfdr.de>; Thu, 17 Mar 2022 18:57:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236143AbiCQR6r (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 17 Mar 2022 13:58:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232658AbiCQR6q (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 17 Mar 2022 13:58:46 -0400
Received: from EUR03-AM5-obe.outbound.protection.outlook.com (mail-eopbgr30041.outbound.protection.outlook.com [40.107.3.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40FC621C04D;
        Thu, 17 Mar 2022 10:57:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dw+DEMKuCzzrMQsSH6Jv+bwDT7QgdEBvg2gMlhS3vHUAJwZ5Hi5likhLjIx+DX8njXIe4ZM+ghjnq8+65nDCk04lG1x5hyjYEiJxD62Tu6eCd5HkjsX1DqTlFrSaju4GgwV7fPL5fZdmIwElssnuF7Fh4vZ63uysnWeKvAtxWzdi6psleDU0tVfU4IYc3BREtjbP6CrnLqrHWarhX0Tn4R05HwHZ8m06u4wY2THEUJB4PnByEbff+IHJ6/MtyyjuUBr5VIdLdAMNJ7ZSTqBUio50OT4CQ+3dFg3NPeKHiZtvRLBxZ8xOxCIjLxSjvd5DVP8o6a9hIrSoILBjsdJKpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3mnJeg77szbF/dXsBZhJmY/ndOf9sj8d1RoHZuLbOVw=;
 b=CcbqQdK3WH2amqrfzpquGrZ3y3s2KPhGiX3DfSxZGdXf5oS/9Z6chI2EK2TbJDCVG+xrJQmdweLyDGYPMtDRTbkbGN/Zzj2nhbrlBlczVSsf6DL5Sk+hekWSaUqaZgk5sXLMaJpWP1UToAh5t7vadmywjWt32qlTt4X5F2P8lhpjX4kYqgtvZijprNiPYcsT4ux3KDgV7R/hkpldW/Me5hPe3z5VEPvATEe/Ta6aUY/2zCvDc848KMP0RDmhKCxVXf+7SJza3Iius+rmKWEQbHAmdBxe2Q6iuxpKRv1JgngcCoV+CKs58m1rKzu7rwzppfaonnxHe7pJHkAoDCJ6qw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=orolia.com; dmarc=pass action=none header.from=orolia.com;
 dkim=pass header.d=orolia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=orolia.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3mnJeg77szbF/dXsBZhJmY/ndOf9sj8d1RoHZuLbOVw=;
 b=A8pPvM5udFUPcp8pHsDnANkr2OWTgFy+dJ4pRT8wcKXlwZSCQ/nAcW8k3zvzL6eqNpujBVdk6ki0wpT6OPNHCX7sn3cIzX+5iqixwiZ8I+6uLgQf2cN4RcnYhTSSLWRH7+5+h+3BwSC/Y9/1W082mwBlrVd8gvxORhekBmoMZJQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=orolia.com;
Received: from DB9P251MB0306.EURP251.PROD.OUTLOOK.COM (2603:10a6:10:2c8::20)
 by DB9P251MB0171.EURP251.PROD.OUTLOOK.COM (2603:10a6:10:2c9::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5081.17; Thu, 17 Mar
 2022 17:57:26 +0000
Received: from DB9P251MB0306.EURP251.PROD.OUTLOOK.COM
 ([fe80::8c51:a5d7:5136:9930]) by DB9P251MB0306.EURP251.PROD.OUTLOOK.COM
 ([fe80::8c51:a5d7:5136:9930%9]) with mapi id 15.20.5081.017; Thu, 17 Mar 2022
 17:57:26 +0000
From:   Olivier Dautricourt <olivier.dautricourt@orolia.com>
To:     Stefan Roese <sr@denx.de>, Vinod Koul <vkoul@kernel.org>,
        Rob Herring <robh+dt@kernel.org>
Cc:     dmaengine@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Olivier Dautricourt <olivier.dautricourt@orolia.com>
Subject: [PATCH 1/2] MAINTAINERS: update my email address
Date:   Thu, 17 Mar 2022 18:56:55 +0100
Message-Id: <85c4174fa162bd946ccf3e08dcfc9b83cfe69b5c.1647539776.git.olivier.dautricourt@orolia.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PR0P264CA0096.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:100:18::36) To DB9P251MB0306.EURP251.PROD.OUTLOOK.COM
 (2603:10a6:10:2c8::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d7469381-3d82-4a49-183d-08da083f9881
X-MS-TrafficTypeDiagnostic: DB9P251MB0171:EE_
X-Microsoft-Antispam-PRVS: <DB9P251MB0171C77FC961EB2DBEA22CDA8F129@DB9P251MB0171.EURP251.PROD.OUTLOOK.COM>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +XK8qGnZs9bbDgPOuqU+yFa/n4/pwponZYnu1HmZhzfbih+Tghq8JF18pwzI1oqvGXiZCEDH5BYOnhtoFehJxU30+pLZiRUeGozllD9epu4dE66Jux6amzH8km0ObahWQdww/84HzqislhO8WDykE7+cC5WxMWRCrOTdkDwm+Dk53+VtL1s6ZoLnRJ28OcxsORTz4J8G4ak1owgm8ba/ZVXdTpnjfb7kM9sSp19kTcRuYoX/VNvbfl6SkGUOzXXCXNQxgzC0rkWTOTZLv+2ccRtns6JAFcU2bdoLMbMIUdewnKrl1eLwNKuUy24WzFGKUAsndWY66Lcds7PmlE5ZvAmDpycDdKTcQFJY2Lbb5qrGUVfxBjDkevSFRdsYfKRDwfLgEgpN3xaBCuxd+xgaklRDlnIssijpiZ+RP8pqT3BDvbODjRY3vhkxuklpQY52HX7iUllK3yb/K4Ls4rm9Rfr2B7HeCL5HI0HcS4ko6+w7sTo3XuGXuI5DLGg97D+RZQftdqTM5FyKGaWf4HAIJdkfiewntOYEI7NuztqacbY71UJWBZxVHVPnb9KakSeGrVj/pFW4F9Cop6koaXOtlCKU7EJqsFadaeCrMpU/kK5tfIkrTDLprYQPcXsp9Cgt1e1X1UZrcSm8fY1CMOG+0A==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9P251MB0306.EURP251.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(6512007)(52116002)(86362001)(15650500001)(2906002)(508600001)(6666004)(6486002)(316002)(6506007)(110136005)(186003)(107886003)(2616005)(36756003)(83380400001)(4326008)(8676002)(66476007)(66946007)(66556008)(38100700002)(44832011)(5660300002)(4744005)(8936002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?UQJHgZqXGe6LR5GWKCpfjzlVKVMP//JCJYzfaCigDb4ufWEu1Uc4/cugG2LQ?=
 =?us-ascii?Q?Jf8xVLeMp7RRdmYMowqzuNDMmWOHqAvkVsROho8NH0GU/MY/kNvzaNDBb69S?=
 =?us-ascii?Q?7Rs44ILh2fZ+flNVdJO81vXdHw3z0aVYw7w2qrVCilbRPsoYOR0MWd3h4YK0?=
 =?us-ascii?Q?sQCs6ksLlMvqflLzLABp8cn0EitsDSuNVmbCMpxBBIqWVaHaRi3oBMOgwV/Y?=
 =?us-ascii?Q?IaVNXns+HnZAgD86sv6eP+yw5H5x0IJUOjuCskxP/STwt+fjfTInO//V3J4F?=
 =?us-ascii?Q?W4++cNt7wC1W8UrUHufs10EALQTj9T3IvYdC5Jv2U3lcWj1r8xa+2BWXF3nI?=
 =?us-ascii?Q?T7fmacwjwoNh9tOvz1MLGhYn+aqpbHuw3YwFtqNRqaYiJRbODWe6zJMKBOaW?=
 =?us-ascii?Q?GWnf8Fe3sEG8rsJUHpIkKK9asifacU9IAOe51sRc27seWJGNP+mjrC45GhS3?=
 =?us-ascii?Q?BfFoKZAZWvRRxzVLlNELlZ5KmjnXWiI+UuqBxgOZFDbBCW0tzPGjCvNtEzTR?=
 =?us-ascii?Q?p27bwn4wspoKjFx2SyysjgixmH1WYn+zSNnPXkGyu0CU2nuXN/e1rAqyEGa4?=
 =?us-ascii?Q?0TNaaMUbpnBDpSaICHNLC4VZscr7eXtN8Lr734Orzck71SM8RL1dZLL1CriV?=
 =?us-ascii?Q?0st02kFIjkSysBseczYjiUuw3fhPJAJJ0Gu+O2RvRHe1pak0gopPbXdw2dwB?=
 =?us-ascii?Q?9WAoyJzIJekIaocyo/SSzmMjCEhg5x13BdDA9NisYVY9awPSNtl7IL2G/Wn1?=
 =?us-ascii?Q?nSSnqgvgjheq4fUMEqIS1+7BZnbRI60gR6d2vt2rRcHSnMhALVsYXW4NhRze?=
 =?us-ascii?Q?PvuoQ9jHc9BLT4IAGX4evbo6XBXR5YjrVcv4AWylpQ3EUXw/NLo2qqALc2xp?=
 =?us-ascii?Q?zbzc57vtWJfGsjbakAe22+JYONuPxBj5ChXsFhgp7fP3Ucy8/vQEp8sCSdTK?=
 =?us-ascii?Q?tIFzA3xfI4BUIOvMowN5+SmNbWDLdHmPUqoSw3/fAdGSC3rlqYmdPjeCTGd8?=
 =?us-ascii?Q?cBb7nJ410D9dRkJgF6byDFaxd3XNfoeEeSvXRitYBYocLyKKHEBG48m0B5kk?=
 =?us-ascii?Q?c2X65kSSzJSLmdn5vQvsM/U0vkXZOIEPl0nm5Cgx1hpzL/NFFyCCbJjicL8S?=
 =?us-ascii?Q?QMQBIO4RNLIf3Lnb/0slmtha4rQUaUcIqQDW370pPd/h949JBP0Y1JNyy3tV?=
 =?us-ascii?Q?+6Iy56bKLxAsWOI4HbPrGK4A6PtEASHZzkNY0RdSFph2PPTt+OIHFEZ2qBjh?=
 =?us-ascii?Q?te87V/sh4/F9yqE2QluJpyKOKF12+MekyXclBp1ui86D9GbAftBrsek4bDXF?=
 =?us-ascii?Q?RJl/hwxs38fZcmN2grT8ccyixYFqIvkeUj90iytLByTZl2+lS2uxVI/ePvLv?=
 =?us-ascii?Q?F+dkC8Gz/BTth0oIjq83AvOk7HjA+32uFANc8x7wjgWlggEe9fcZjuRumpzM?=
 =?us-ascii?Q?hKCFPCx8a8mPfyKy39GjbDxg41kTVwMEuiUWsD4slU7r8OKxcKHZiDXFNF61?=
 =?us-ascii?Q?LueuMjwwt3grPROoFEiD3A5t7wYGQU5tr+7JZ9FqQRhs2tI9JdXL8uioOiNC?=
 =?us-ascii?Q?8nj8/88yW3TK7Cx0Xcs=3D?=
X-OriginatorOrg: orolia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d7469381-3d82-4a49-183d-08da083f9881
X-MS-Exchange-CrossTenant-AuthSource: DB9P251MB0306.EURP251.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Mar 2022 17:57:26.2468
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: a263030c-9c1b-421f-9471-1dec0b29c664
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ktfbEfWzqOH78/z2EWLKymCCzrN9q7Kdm2QIlx83AV3NmMIP7//ccm8o9869oreKzTuAOq+mIbmu/sW4trRm0ZKiGRZUr00JTTiVtYdhZ3Y=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9P251MB0171
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

This email should now be used to contact me.

Signed-off-by: Olivier Dautricourt <olivier.dautricourt@orolia.com>
---
 MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index e127c2fb08a7..4732ca997aca 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -811,7 +811,7 @@ S:	Maintained
 F:	drivers/mailbox/mailbox-altera.c
 
 ALTERA MSGDMA IP CORE DRIVER
-M:	Olivier Dautricourt <olivier.dautricourt@orolia.com>
+M:	Olivier Dautricourt <olivierdautricourt@gmail.com>
 R:	Stefan Roese <sr@denx.de>
 L:	dmaengine@vger.kernel.org
 S:	Odd Fixes
-- 
2.25.1

