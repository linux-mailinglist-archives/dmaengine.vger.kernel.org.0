Return-Path: <dmaengine+bounces-1502-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 73A4E88BE88
	for <lists+dmaengine@lfdr.de>; Tue, 26 Mar 2024 10:56:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 27B251F62FE6
	for <lists+dmaengine@lfdr.de>; Tue, 26 Mar 2024 09:56:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F3A76BB4C;
	Tue, 26 Mar 2024 09:55:22 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from CHN02-BJS-obe.outbound.protection.partner.outlook.cn (mail-bjschn02on2095.outbound.protection.partner.outlook.cn [139.219.17.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65BB167750;
	Tue, 26 Mar 2024 09:55:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=139.219.17.95
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711446922; cv=fail; b=cOFy08dhQeNrPLM/eWDMrOsdnR1IxgpDVgi885kqviUZuXdz7tYPCE+fDMTtJlJS0u4oip8dFXoB9J4mSd5yie5Aegv9qVb3VowEedq0o2d41b26hpq5cnPMER/enoxK9hySQOnNmsxyPFJrEvbojM/6y3KzzEBfR2m/EfZP3xc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711446922; c=relaxed/simple;
	bh=4EfzZ+J3LtUadzufIba+d9vEgSQTSbnen8UI4pvu0qk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=UpAYlFiSC3o4lHwyk7StWaLJ5FiunZcUfY2dLZH/wEe9iNKQzEAUA/pqOpo6q7x0+ZWXy8QcWLVbTBkCJn8Oe2G3EQeSpD/+bUb9AEaiR9iuAwnMvs1yFAMZH/WXM48h3v0vAfYzws16PjIHd2RivZJVG3g+YQ2M0/AwNw3u5P4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com; spf=pass smtp.mailfrom=starfivetech.com; arc=fail smtp.client-ip=139.219.17.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bqBInlEXkSF2MTqY5mFcpeszaDKIcJb5e2H7vmURcIWHHFhG4utXtcqOuLuePYebLU26KUcGfCcxbM3H52q3d2E/+b/jloIaTNyyVZsNsyrV60qVBhCFc/Y00iUdIEr2d0W4V1/mmz++4dzJYEvG4jwgQuqY8nBveaTrrgrr74HY56gvsPVIMDfcsWBZ5u+tZ6q5NNrKjAcCMZ6NJ2Cnb2JBrwCEGXwjSL1ySHnAjBzdx/0G1lU1nlO4OkMfsqZfAeDReekci+3foIAiz8IctKXbNzvRakJY77Ebh/Vnk7+/E+er4yt3hryXmmifadlwNYaYkB7FLuQZdCDqSd1x6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EGFwBRqR0Ubnr6Qww0efT6ERK3Tj0upKezJN+tJoDus=;
 b=e92OtRKgOnCgXBfAdGYdtUjpKd6wag+ZhkU2hpLyrklOpAaW4A2DqKPgaVsGbFtqdsg5DA3HOk1EVxfrD0W2tqevOiTaGuaBy2FBrF14Xfm0U/QT5z9Jqp0E6aK4VsVyZ1LYCeP0CFF8TVSHElRN+jbYIisg+gRNKzhsVIaQ5W7sAXwygBhCUd+2SbQLgMe1IgHQR+EHEzD7KHbZsoY9xj5VT099jRCZrmZbXUOHxOX1v1wNNdi0JE7BBUdfT8ZCMbxlflMPueB3qCjy/eHV5CT1EjZjrk7Lsu9DuL3ipE3tJDS/AUSWHMxomRYOjlEmIRziaKZFcV/F3IE+BQil+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
Received: from BJSPR01MB0595.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c211:e::20) by BJSPR01MB0660.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c211:1f::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.31; Tue, 26 Mar
 2024 09:55:13 +0000
Received: from BJSPR01MB0595.CHNPR01.prod.partner.outlook.cn
 ([fe80::d0cf:5e2e:fd40:4aef]) by
 BJSPR01MB0595.CHNPR01.prod.partner.outlook.cn ([fe80::d0cf:5e2e:fd40:4aef%4])
 with mapi id 15.20.7409.031; Tue, 26 Mar 2024 09:55:13 +0000
From: Tan Chun Hau <chunhau.tan@starfivetech.com>
To: Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>,
	Vinod Koul <vkoul@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: Ley Foon Tan <leyfoon.tan@starfivetech.com>,
	Jee Heng Sia <jeeheng.sia@starfivetech.com>,
	dmaengine@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] dmaengine: dw-axi-dmac: Add support for StarFive JH8100 DMA
Date: Tue, 26 Mar 2024 02:54:57 -0700
Message-Id: <20240326095457.201572-3-chunhau.tan@starfivetech.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240326095457.201572-1-chunhau.tan@starfivetech.com>
References: <20240326095457.201572-1-chunhau.tan@starfivetech.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SHXPR01CA0027.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:1b::36) To BJSPR01MB0595.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c211:e::20)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BJSPR01MB0595:EE_|BJSPR01MB0660:EE_
X-MS-Office365-Filtering-Correlation-Id: 493c743d-c083-4a55-a003-08dc4d7ad4d9
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	st+lkL/wL0d8wLqRIZkM4OyeySqPiurrnjmBFyH7oqbdBe665GB7x04hNrTMCihkDCVqKamw65jaoqiSrn1JLi+Crn40QzZyI4O0Z8LGizsU0sSYJrfzpibWF2NlMFVhcsU7vlCVZgLLj7393FhD6STUELoVPhcZQKVBvhQjEbfCdmRFnfZycWgp7j3W9TNcMgyJl334ZKhLjsI1tBDs1+QSH8Y0DgSIJWVfznwUMaKouOys5iozucNIbZEzQ3ZuoH5dQPM5KOqYHsGZrCWAmQwV0RbiPZaQT0I7sRuLQ2XYuACg3ItEVfj2Jvo7q0bT2lHJzgUvt2HPb1r9ILY4LI+mc4WZav6KOIUPnqC5u5cn4oZVkRp1nkH6rp1hXHSDaEI5jLqghFqT75xozkxZgc7AiMbP2igDXnyULRJwEHaHED1swRPR/5I3L7R8a0fcIlzz33LvEnzyJlHLMLSfX1ENew8l7hNndBep6khB+sONx4yc2TnXzKXLDU3DR6B7P7fPM8n+dC6kGofpyL8WQrJFmjmJYLXgBmMeu2UdMVmoBlgxpwvh2fSyN8+l1IQ9O6Nqjutye8cEsi/ieokJDd3mo74NhL/BIGk5/ij+SRm3SpNF4R/vosBWOEWaI9Yh
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BJSPR01MB0595.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(52116005)(41320700004)(366007)(38350700005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?a+oKd29jg1arpfzk8glzTDfExs5zjuR+pUCBQgN6tsrCc2jwVXGyPEs/Pba2?=
 =?us-ascii?Q?Z8DLBgpxZHX8Dsfdf+a2r3tX7gCci5YEg5DnTceICklhPmZLUEaeSRfa+7Kr?=
 =?us-ascii?Q?wBYQgBNSTPnxHUGNCvKzeOjGo4NqlmCoVK0wcYDkNJjMpy6CivAAujvmpYQu?=
 =?us-ascii?Q?53jDHhhmS7xiRFm803flEaeJX9XT67UtAb1cALFzUirS5Gn15/57qD529cJR?=
 =?us-ascii?Q?XHrcWv18dX4XxS6EdpNl+LWnswEbyZwh5m1ia1vFa2gP7Qz6nn+z/E5IJAA2?=
 =?us-ascii?Q?NWBAh6Ts+C7gvm2MzLgGzWKoWYtBXZNo0JVYxCf4nKVhe0FBsUG9QPCRD1VM?=
 =?us-ascii?Q?vXfiBJToy9+9KehGqURkofzJ8WhEbDzIg1z0xS0hOZ7AzXnlYfWZfXNPHUrf?=
 =?us-ascii?Q?Z8iYXPJuADcmKY5rrxkSDfLWPrdB18r9qeMvLSd8VXI3o3Sxg1TVv0KPRTHe?=
 =?us-ascii?Q?dOj0qF8RfeJxz10uCD/zRdRnYrZd2kxF64D1sNiKIIandV0xHSNRIlfe1bso?=
 =?us-ascii?Q?ivAmnLjmMVHlPpovwxQdraNZndg/fV2AqTW8wzRqQxM0KLYIfCOuS61n1xwl?=
 =?us-ascii?Q?V6k/ubNfz890T+PVz4jsEaEnkjousf/D7MJN8Q+00ddPTUjCRo96fYw1zJCs?=
 =?us-ascii?Q?qPItQSRxs+Mr4wtedf4oRw95uZTMJh2m+Oz+RdRTEejtcRRgY7eMZPtbflU+?=
 =?us-ascii?Q?eO1Cai6uE6bac2wSH8yZvszj4sYWJSW3klTmQiHMOeDz3ZQlhasFxLR99u2O?=
 =?us-ascii?Q?HeVDwFEJwepOy89WDsFvMXLWoPu1t0fCwNOPNqUyxJUntIWDDnkWTymfmc3R?=
 =?us-ascii?Q?naQKEmMOQ+DeRXODeGaaR9yTajwb1PenFKlnNGbxEOcvwisfqT92EoPckAPR?=
 =?us-ascii?Q?LAdpuk/uC3AFsgWNhlnlYmZ9lHjxVN1ZAHvukFSuFYNwqb15VNj0ftgvD8Vc?=
 =?us-ascii?Q?3X6W5wYFzj/QULDPFEWnRd71W8rFjkdaC6egd0EgnWcs5okVYgmhzQq/3imn?=
 =?us-ascii?Q?NE3i4oBb3sqFghnJ3kDeb7xcFRWYOI81NsuVcizH2Ky/ZceXnLQghxoV4LV+?=
 =?us-ascii?Q?Hg7sv//SeNy18kSc8IZxX+q19NCnNjRbSAx6p8vA3nnYqJlW417qGqN/O74g?=
 =?us-ascii?Q?luGTbwvYDqVaPBwwjVb9XUH4oCDvLZLXAd3jAbFhUjRzlmUgiD5x17tOePDL?=
 =?us-ascii?Q?m9TXd+tKQPE04g2pSAscjP4uwK1zmovlcqn8rf7XeYWpCxr+q4ibGmrsSR++?=
 =?us-ascii?Q?nXtzuqaVbZMyI3YZFBnJhRQHv/4Wl/Yh2dHC+Iwoj/M2cz7ezAMm8U+MyI7i?=
 =?us-ascii?Q?pEZOSv6yPWLH68D0CAlJcxSl/107ztFY7Ju3wCcU4x8rNgL3x7GyqWcvw5lE?=
 =?us-ascii?Q?6dgkP1Xu8T/aHUvREvteaOahD9Qq2MQJYY/3zQj6do09P2C+A8HS6nBks9n/?=
 =?us-ascii?Q?dbAfALHQXr49tSXlXjN0107RDN30wL2PfuJOaoj6gVN43qlr58riyz/hl/5s?=
 =?us-ascii?Q?9Ngql0dQmbJnTAoRqMA6MsRImqQw90UzJ8OBFLeLB7fw6BpvVamqi4MbELvV?=
 =?us-ascii?Q?JCXTGUfKLBlkXSjeqPCtCFxejWx9yn3Yvbmb56GdJYQFCn61ol1EkWjYjbpl?=
 =?us-ascii?Q?Lg=3D=3D?=
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 493c743d-c083-4a55-a003-08dc4d7ad4d9
X-MS-Exchange-CrossTenant-AuthSource: BJSPR01MB0595.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Mar 2024 09:55:13.4047
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1rUdCtR5kjnvM9y1/zjXFhwH39+xaUV/DeI1kSnSIrakgMyPFsKDkvAFbJo1uPRN5qqLI5q5mu4zaW++z8NMciWoZcdZAgoX4SMO3Cj8qgs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BJSPR01MB0660

JH8100 requires reset operation only in device probe.

Signed-off-by: Tan Chun Hau <chunhau.tan@starfivetech.com>
---
 drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c b/drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c
index a86a81ff0caa..abb3523ba8ab 100644
--- a/drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c
+++ b/drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c
@@ -1653,6 +1653,9 @@ static const struct of_device_id dw_dma_of_id_table[] = {
 	}, {
 		.compatible = "starfive,jh7110-axi-dma",
 		.data = (void *)(AXI_DMA_FLAG_HAS_RESETS | AXI_DMA_FLAG_USE_CFG2),
+	}, {
+		.compatible = "starfive,jh8100-axi-dma",
+		.data = (void *)AXI_DMA_FLAG_HAS_RESETS,
 	},
 	{}
 };
-- 
2.25.1


