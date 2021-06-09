Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C374E3A1938
	for <lists+dmaengine@lfdr.de>; Wed,  9 Jun 2021 17:21:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230027AbhFIPXM (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 9 Jun 2021 11:23:12 -0400
Received: from mail-eopbgr70082.outbound.protection.outlook.com ([40.107.7.82]:16497
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S233638AbhFIPXG (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Wed, 9 Jun 2021 11:23:06 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jlHamgfy/xjMLQhQoa9sDtWef2sAGHS43INKqaFH6+jPnthyEW5CAPdVPVTQOF0pWmxiznWNsjzU3TZCdOBKQyb2jHwLBsT2xo33zzlqtHo9q8Am6FTXf9fY+xc9sXrw7P2bOMxKt+plVGV9p+tRljxlYj8NuaGXE60nj6TSVgVW5ikfr8AAa8IcI2VJcW2ZI87g3yBq+NoFgNLd49qPHw9P2wDmWRCAhABiIPwuu937907leqp/4XHi8xzkAv3ZyS85xGf8pLs0e3GHPZ0FrXrtVY6SbYZ6kQ8k3ZwgpmEQU+kuLuqfX/Mh4SKvn0OEpSEpmxswL18umJDLtVIZ4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0LBdV9aFr1rsXowp9i4gYeMj8aAXeIuWslQRNx35s/c=;
 b=g0jnQ7c5HCQqxxVihNnJ0Ne4x+cL38of9bv9DIQ7gBAVQh21yGMgOgcEZJXLEneIlt4XrFril9NPE8zPww1eUCWfMAda1/piTYYs79L1Fb6sd/yLEkHEuMnCkG7Touq2uS2ueYU/yAv1+BAFXjvhppjTP+YGv/cjnfmL9gi/zUAjNlirW7UU+7B5jbl+euk44zi7YBoU6NKEWq8Q/rl+fdgNjXDZlJbxVqoGS9Wv2w/WlTCBy3vXs5lLbMnMtQu4Smby5vnlYvSytSnmuDH6OtxTN/6mV4wpI3yqanveOjth9mbjh4PLvIlQ45Jm5sBfOljwIOWi4s7q8zkdx0DYtg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=orolia.com; dmarc=pass action=none header.from=orolia.com;
 dkim=pass header.d=orolia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=orolia.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0LBdV9aFr1rsXowp9i4gYeMj8aAXeIuWslQRNx35s/c=;
 b=Mk/n0qpd4VbxFYbCrxqZi8yeSx1fDB3zW9bToDFS5pRSZ4UDVfa6PNjbYccnkHWPDw3ws6dWFmabJetmyxAZrAKNIY9CdPGgrjtFHYO+ZelrapmYCyaIWqkQAfqvWNoUE0FG4lJMXwaPv6ruQ4OzYD9Zoh4OgfiX1kHPVJ4t6po=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=orolia.com;
Received: from PR1PR06MB4746.eurprd06.prod.outlook.com (2603:10a6:102:11::28)
 by PAXPR06MB7629.eurprd06.prod.outlook.com (2603:10a6:102:152::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4219.21; Wed, 9 Jun
 2021 15:21:08 +0000
Received: from PR1PR06MB4746.eurprd06.prod.outlook.com
 ([fe80::81ef:de90:c451:d6e3]) by PR1PR06MB4746.eurprd06.prod.outlook.com
 ([fe80::81ef:de90:c451:d6e3%5]) with mapi id 15.20.4195.030; Wed, 9 Jun 2021
 15:21:08 +0000
Date:   Wed, 9 Jun 2021 17:20:55 +0200
From:   Olivier Dautricourt <olivier.dautricourt@orolia.com>
To:     Rob Herring <robh+dt@kernel.org>, Vinod Koul <vkoul@kernel.org>,
        Stefan Roese <sr@denx.de>
Cc:     Olivier Dautricourt <olivier.dautricourt@orolia.com>,
        dmaengine@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v6 2/3] MAINTAINERS: add entry for Altera mSGDMA
Message-ID: <4258cb93e0f7ff57c4e116c3e8cd9a1a3159cec6.1623251990.git.olivier.dautricourt@orolia.com>
References: <7487a25cdb240d1be4a8593aa602c3c73d8f5acb.1623251990.git.olivier.dautricourt@orolia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7487a25cdb240d1be4a8593aa602c3c73d8f5acb.1623251990.git.olivier.dautricourt@orolia.com>
X-Originating-IP: [2a01:e34:ec42:fd70:167:681b:bc47:e8b1]
X-ClientProxiedBy: AM0PR07CA0020.eurprd07.prod.outlook.com
 (2603:10a6:208:ac::33) To PR1PR06MB4746.eurprd06.prod.outlook.com
 (2603:10a6:102:11::28)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from orolia.com (2a01:e34:ec42:fd70:167:681b:bc47:e8b1) by AM0PR07CA0020.eurprd07.prod.outlook.com (2603:10a6:208:ac::33) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.9 via Frontend Transport; Wed, 9 Jun 2021 15:21:08 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f794abac-8924-4d40-1765-08d92b5a34f8
X-MS-TrafficTypeDiagnostic: PAXPR06MB7629:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <PAXPR06MB76297AD55F280F1AD5CAF7F78F369@PAXPR06MB7629.eurprd06.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:363;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qwXMRoYcYHL7jI3LF4+rUonslmf6bcQbhCXlV6JhR8AMD8Eq1hQRoHfuWT1bINmtMgHhiz3kUS8eMoouQglsnR3VPXcnL5YGxyr9eDKXS555ED6TDkJvDj9DPAeDVvQfMYvAKBn5OQFLagS2o7Qlp7uPgxBYt4P19T9AIF1EqcTKGqeYLy+Do3mOr0BodTffj11AsKRxHwVHdSs71DJ1riO2BrQlnZJwvc0NPglV0LPZmWhum6MHWK3bZWTR5IrWXr+CwDX9X9EVsreb2tfoy4wbGyeP8rzgV6ovBrDkgYTmpHzmyrUTdgVhMisAeQufUcVcUoI/TR3PNkHy+zZntM5MtVWO9MkaFe8Q3fS3oDWSq1oCsEVCGmRbolku+aWttEkdll/RtBN2e+SMOxMIm24JuoUHq9b2v6lr/9jgPgIP1Bt6iUTXNlsLuEBNESwwy5KNGgy8+9jeBjVjUohmTjbLQloiV0EMhNE/IktMfUHqIhOzNiJaYifcJttZ0iO0kqz/EGr5WWPtHXf9u7OQmrCGnCqC6LUsSibX369Hd1y8qX/gr7JCD53S31I9+xsxsQ7Zo3F442ikv54hQw/T2+uVQkPZPrTbf4oNBSqUiII=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PR1PR06MB4746.eurprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(136003)(366004)(376002)(346002)(39850400004)(66556008)(66946007)(66476007)(8936002)(8676002)(478600001)(55016002)(6666004)(83380400001)(8886007)(2616005)(5660300002)(36756003)(7696005)(44832011)(38100700002)(110136005)(16526019)(316002)(186003)(86362001)(2906002)(4326008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?h/Xx5fsYwrcLst09joLYyazzWmtWE1HXSbc83Ri0lwf5ZE1NTBiPSVAxMJQj?=
 =?us-ascii?Q?EK5Bn+7u0s0oJNaEIWlcD+s89wwOYCnN7HpffsSTMvfiF9qn6HwyhLuuW9YC?=
 =?us-ascii?Q?XNLjZfNCmtsXCNPBSWXT0Z9/jPpO5QpOlPERJLPqd4xrPEAifrGlYQSassnD?=
 =?us-ascii?Q?3xrmki/UuOdyaT9t6su9VgAasCwlEs3iPjGo/2pnL6fvaboYamKP1IBqacCI?=
 =?us-ascii?Q?0CHn2fKE1FlnOvdPatEENWgdlNl9GiqUhnHUALORgz9SWfbO0IV8E1xZzsJB?=
 =?us-ascii?Q?+OIEd+8VIWxpqCR4qCpPdBT9dczHoMjo08oXft3UB6//rMTMQMSgmTvRl+Ph?=
 =?us-ascii?Q?wAf9vg+SJh8UhPvG+j45QdlXYb0P1QiEsbCN4nFImXxuFUu6nln+CD0jhTsV?=
 =?us-ascii?Q?6gEQ3VjF27uW1cYpnNTj6H5wAwMQroUsVqqBbcGKa/VGrMWWC23a6MjSSKEk?=
 =?us-ascii?Q?1mmV8K2HBVfln2rtGna+quK5P13b/INKWJcv3V+oCyNFdTUbBHzZvYliAHK9?=
 =?us-ascii?Q?NboGRj9SWjKNxyp+0XG/2gy+YVl412mJAGRRf9lIMqg7FbgaZkhvw9ekg9Cn?=
 =?us-ascii?Q?xzGRAEMYssAVP3KOvLIWDiy+w5GqdQi0hsDubY60Q6blYdwahpjRS/ogMu4c?=
 =?us-ascii?Q?J4qRNwh6n45uXOCeLs/4RjOnEB7TFmKGrL8Lhaf9fdQf81RckTC+OM8zZZ94?=
 =?us-ascii?Q?pqMfvQYb19GcW1vZXjLT9gbds9fDpWngkVfUNHdpdhc6cxwKsQ8/6FxgMRHI?=
 =?us-ascii?Q?rYH2v/UlWV4gsmzpWItUQzZM22aWo1URxmISu3B+ewxZICGd54o08nKpY72z?=
 =?us-ascii?Q?llSWt0z8gHYejK+A/aEfgWINRKsjIgjgpA+KX2vbIfFfeLYl/lRT83VZLw5q?=
 =?us-ascii?Q?zOjDzs7TI9rNfqGwRPJ30PQEIXM9XinMAW0YZlUmkoYFPoZZZm9WIYv0EXe9?=
 =?us-ascii?Q?Wfd45xdfCsMWJm44TVx2Q6eZCC/ig0CcM3ngyawukyc/LmisfiMadQzbwxwv?=
 =?us-ascii?Q?GaE1rlfUIGKTlwkWGikV/p3LkLYCdC/IR6lpV57+yWjHxqyyDky9lKX6dIFw?=
 =?us-ascii?Q?a+xL3QpeRvnoDysbQ1s8TvTXFwcU76TV4bois/rMD7KU990R5wX43C5tAVRL?=
 =?us-ascii?Q?J7KIlslfJpbdABmFe8wRXEQwmErSeP0mbWmcIkyFCD0ZKbqQfLRWWYBr9ajU?=
 =?us-ascii?Q?RLgUclIRQoO7IN9/Bt3zK9FRAwBYhaOSKleuzypUIlCaCkWOkRBi3Wo8JqdM?=
 =?us-ascii?Q?5bKku3Varp+zzcwjPDB2ojRtvNwLyZEcH+KdauPRKlGRJoYIekZfDThiS2pX?=
 =?us-ascii?Q?z2xVM/CvB0gwKIb9/s829b+lRClBpfX0yr2cPpwabO3ZqznUqae7ouUvn65i?=
 =?us-ascii?Q?PizBRKEy1oCh+wei2+jWkSn8eU5U?=
X-OriginatorOrg: orolia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f794abac-8924-4d40-1765-08d92b5a34f8
X-MS-Exchange-CrossTenant-AuthSource: PR1PR06MB4746.eurprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jun 2021 15:21:08.6250
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: a263030c-9c1b-421f-9471-1dec0b29c664
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KnXafrDhB1XGPuH3/zEZCO8NJ/1Oh1izqbPffQ/DcItAscc/w+qGQ0z/VifZvP8lw8YEeEsfm+jPyE8PhsP/Kj4j4f4ogMK+R124IQ6MZ50=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR06MB7629
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

This entry is for the standalone driver in drivers/dma/altera-msgdma.c
Add myself as 'Odd fixes' maintainer for this driver as i am currently
writing new code and have access to the hardware.
Add Stefan Roese as reviewer.

Signed-off-by: Olivier Dautricourt <olivier.dautricourt@orolia.com>
---

Notes:
    splitted commit, introduced in v5

    v6:
      add Stefan Roese as Reviewer (after consulting him)

 MAINTAINERS | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index b706dd20ff2b..3167d26f0718 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -783,6 +783,14 @@ M:	Ley Foon Tan <ley.foon.tan@intel.com>
 S:	Maintained
 F:	drivers/mailbox/mailbox-altera.c

+ALTERA MSGDMA IP CORE DRIVER
+M:	Olivier Dautricourt <olivier.dautricourt@orolia.com>
+R:	Stefan Roese <sr@denx.de>
+L:	dmaengine@vger.kernel.org
+S:	Odd Fixes
+F:	Documentation/devicetree/bindings/dma/altr,msgdma.yaml
+F:	drivers/dma/altera-msgdma.c
+
 ALTERA PIO DRIVER
 M:	Joyce Ooi <joyce.ooi@intel.com>
 L:	linux-gpio@vger.kernel.org
--
2.31.0.rc2


--
Olivier Dautricourt

