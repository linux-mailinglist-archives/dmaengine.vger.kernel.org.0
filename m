Return-Path: <dmaengine+bounces-5210-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DDF8ABCA60
	for <lists+dmaengine@lfdr.de>; Mon, 19 May 2025 23:52:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8D465188BE45
	for <lists+dmaengine@lfdr.de>; Mon, 19 May 2025 21:53:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42069211A07;
	Mon, 19 May 2025 21:52:52 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from CHN02-SH0-obe.outbound.protection.partner.outlook.cn (mail-sh0chn02on2126.outbound.protection.partner.outlook.cn [139.219.146.126])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 964B9225D6;
	Mon, 19 May 2025 21:52:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=139.219.146.126
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747691572; cv=fail; b=BPTVDweeFFOH41GVKRvpDhT2mp6CoR7vUSv3+u3YuREhPif17H/XwbiMJGpCuDarWNdltN5qVcqUFevqu830JfClobRpRHJtpbG06Ulx9wqeMrOecbmkxJYFabqIquqAeDUcr38xykRDO2sxqiAXM0G6midh0AIS9fptSnPAQ80=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747691572; c=relaxed/simple;
	bh=xpFrrVau2dE5/yQ4o8IxgO9jCOw2sn+3J9ej8RU0Grg=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=IEHmJZSuOhUu409o8ApYLzTZJTuRJ/U1bhEeOQw3SMTk0nKBvqxXy7NgIWvIHGlZkxirmJFuuH0bAA8FaCifO71cr5134o2GaFd9l8yLVvGu5otrA9djaYQ/7B82EUDhLxJTAJ7qOV1urRYCsJt4bvr4oSKOWW9QhwN2womIpR8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com; spf=pass smtp.mailfrom=starfivetech.com; arc=fail smtp.client-ip=139.219.146.126
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starfivetech.com
Received: from ZQ0PR01MB0949.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550::5) by NTZPR01MB0954.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c510:b::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.40; Mon, 19 May
 2025 17:15:41 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MtROLElZpeFzaMy99pUXr3sujl5jXmLTd4fmX3S9TsJXbnWZARgCH4R+nCt8hahJrNCNrZksj/L1VvspKiFLUl8DeZtDwGxitrAzz8NzzgJUnZCklyqu+zoXcxdzAYt2FhfrkllTPDlAl2ktAQ71vo6jM+3FfLeCRCpVx7xxsLkYvb0o5DMObNk/kRxmNhP4jKne84APnoNfkiUlkxML6TRjwPszwyFvXdwW4YurQt9WxYETALsW/F88IfI5h6+o6+pVQlyfxHoYfHrZkuxcSjzYmiKCOYyn4sm3Emjp//rgnZA6YHETODfz+yADJ8jYYZwov9/VQ7rY2SMbwAUxuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ADqH1ZtIIfOusG6NH2u3/ZQeJxZV+5xH5FVhwcRJMvk=;
 b=MP9pHu9R7/wfL+a6o+ZPX7ahZ8eU9mIIa6WckBWWaOvK53C0FRTkxDn24JDpQ3E0C5B5OoXkxbUIo2fpyv9GgRZ9JtR2ieYP2tQv+JmWAVGS4ilIndpaVXXPlFEgVq4qZV6/p3g+cchNyOfVfZyfVq5ZudLDljse2QCwo2edRaPSYUlOaInSF6eVR7WpmoGYuzLOzy5JhT3IGAoxy3c8nwkPEylL1muZDOFnh/Y8wDlfDuSnzj7USKjVR4RsbUj8B9iP3gJYMWLQmJhXDyG22iRDBHe9q/7Y+MJZrYdjzEIB7/HKV0nyZkQ4Pfu5eG2hNcydRdkpN3qb2ujcsCADyA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
Received: from ZQ0PR01MB1302.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:1b::9) by ZQ0PR01MB0949.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550::5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.40; Mon, 19 May
 2025 06:07:30 +0000
Received: from ZQ0PR01MB1302.CHNPR01.prod.partner.outlook.cn
 ([fe80::64c5:50d8:4f2c:59aa]) by
 ZQ0PR01MB1302.CHNPR01.prod.partner.outlook.cn ([fe80::64c5:50d8:4f2c:59aa%5])
 with mapi id 15.20.8699.040; Mon, 19 May 2025 06:07:30 +0000
From: Changhuang Liang <changhuang.liang@starfivetech.com>
To: Vinod Koul <vkoul@kernel.org>,
	Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Pandith N <pandith.n@intel.com>,
	dmaengine@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Changhuang Liang <changhuang.liang@starfivetech.com>
Subject: [PATCH] dmaengine: dw-axi-dmac: Fix CH_CFG2_H_PRIORITY_POS shift macro
Date: Sun, 18 May 2025 23:07:22 -0700
Message-Id: <20250519060722.307285-1-changhuang.liang@starfivetech.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: ZQ0PR01CA0031.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:2::16) To ZQ0PR01MB1302.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:1b::9)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic:
	ZQ0PR01MB1302:EE_|ZQ0PR01MB0949:EE_|NTZPR01MB0954:EE_
X-MS-Office365-Filtering-Correlation-Id: 8fe3432a-85f3-45ba-2644-08dd969b6ff3
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|1800799024|366016|41320700013|52116014|38350700014;
X-Microsoft-Antispam-Message-Info:
 vLyJK6pwNJsfYsho3cGXg0Jwab7FhhJWU7vrQVhwHjIU1mYC6lcSnCt2B4vOInNM0D/hbNO47r1I2c5uWVZ3oY8v0gtLjTbouLUQWHOmlrgHDiEL8NDAPrXsp4NZkyIdtpzF2PCSj5u81butG1Ew9lmivEVYhO1VSvwGP5lmR+DlLnaogsbgkgXAsunROhG9XJQ0fp1FnqQYv2McIhh0LGBMQKommKoDXdJPvTJO45eP9jmBoittnUZnadt0mQe8ocVfJC6w9csEsvmGuRPrA+1QLSfjHSJGq89a8lrGQMXLQ+S3/ZJqsv4IxQSxHHi0btAm/sfXdrvmAgR8xKfqQQ2HV0QIJgNSFY3rYQGAS1CUqEEldshf2QOWU6GJ+c3lVkm6TXrrdepXXWHdkXewu2j9HoVO/aV7EoGfNbr3p4x1wQKazE9v25Qwg74J7mL74MrmGL1DLdwgeMII/v4KSsKEIl1vG47jq4hN9HY2NyNNKr6avV+VDh5UYg0W0p3UlFsBAh3SUzQeLfFRPVO7TTjY6T27pd/UcZlIXt8qLxcNAtG66TSDayRaWcOSTOTUuEWr3mqtiBSuoqqeFYhGoPfv9hyYQc9o9Bqb0I8hs+Y=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ZQ0PR01MB1302.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(41320700013)(52116014)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?us-ascii?Q?I83qPhIglNT8H00pupSy8syYeZifCYBBVTvgrSGFpBHD6EYWRlisTylxBFxd?=
 =?us-ascii?Q?dZ7ywTtMkyMS95OIImzhPmzCqKZHiOHWs9qgBP8hrvM35NZKtRsZnU8NEoHg?=
 =?us-ascii?Q?uMq5YkOXYMSPEVwnIqwnzER4Jja5/gS+ZAE1g/6WoEHmNM99fTC/3Lh30iaQ?=
 =?us-ascii?Q?v5Gy12fAqZGcstpWtD05nRwXgDPknoNYvwlU4/m3lUfDywIs2Lbq7om7t9qg?=
 =?us-ascii?Q?vcwAu4HJ3AqaM8z/W/DOvIXsX6N12duZ57jm8pywHD51YEgkE2cZ61SO+tkI?=
 =?us-ascii?Q?btKzEQW511K/ourVAu/wxWcuMA8hoSYpV4eJoybB1o0gEbeZZi0qUug6hEKu?=
 =?us-ascii?Q?tIZMxzDsf9VTVdCqPkfK7ViYe6EIHtMk/T+XaJDudCY+NEUV7kLBdY2oGO7f?=
 =?us-ascii?Q?vEWVPSul8yxxlbs/+90p6mAUOZdYh4pEQBcVKsCBtjhcdyayYiuyBwPXy6FU?=
 =?us-ascii?Q?ZtP3p/lyUeAqW42xN5A03PmXBbz7ZfNGyjg3ZuNNJNg35sQpEiYEU0gkixHh?=
 =?us-ascii?Q?QsWf2GQ6e0kL/GRd9u5xjm4z72iIv+xQFFLKcqPa9pcksfUabaJwr3SAGnzv?=
 =?us-ascii?Q?SmtaZwrPqJYo36KKdAFIXlZcffyeiNV1JF6fN50OKhFDbvlprJns+3J6xRte?=
 =?us-ascii?Q?YDjwzSz8PAyhEomhQ5XfO4bszccxkEokvnri0J/bGcykaKhwb3sof1ozdT1e?=
 =?us-ascii?Q?QcuUz2c4YVgz6Qkq0tFUER7b2teFdch3isG35KEaTMfNA7y3kxe3CfpQ+TR/?=
 =?us-ascii?Q?eho7hdan3D5txopKuvbeUItePJN+mJc6yrsKjrvnBIkG4Aj7Gg/PxucaY3t1?=
 =?us-ascii?Q?hRmTwi4b/fRnQ2tr/lRxDkwait9NuI4Ujl5948jzsRBM4q8QLI5HZSUgI6JS?=
 =?us-ascii?Q?cUh2fT4n0AU7pcdjpzrd9p7eHW536WiRBneYCAj5vnuu41w/TxWcEXPp2isI?=
 =?us-ascii?Q?onqs5JXQS/uejOtUnn7lnd3uTWL8S97GGbdDdOWXq0Wq+8Uo619olUAZ8KWv?=
 =?us-ascii?Q?qZOPR1Gzpq9wBs5utehDg0rK4vBkqckpJ8slIGxTRzc0f2lORQ6GT7N9qz3N?=
 =?us-ascii?Q?8Cn4lbGl6CnV5Ynpz1bIkmZ8nGjqXWwDL6Z8TwIp35yyrcFOIajPA7iVCAIG?=
 =?us-ascii?Q?Tav8Bu6+KDd3xyJCItSfLfnsSdxcGhCbB7a8idoyOoGTEyksNJIyxoxYmvGg?=
 =?us-ascii?Q?vdrz9kOCWXqIzw5Eg9FhPf7tBFUPdKsqx/mggArCVgjGDvXxq7oKcAxNOox0?=
 =?us-ascii?Q?qiHJws1GEHMNYA19k4Pbu8I6eUY4Pje0PvHJqEo8J6JNcUmMo7hsjvJ1ciE0?=
 =?us-ascii?Q?8v4sNVS5JiZ0hpkIt2hcTumyjnDPsiGn3b0p3i8dLR5lIiU+I123FMBe1Bd3?=
 =?us-ascii?Q?t8N2YDrXeik8YWECPORCJ3wRsG1Rt35+nkpXymSfdZnHNUVNJVBnKlBbR898?=
 =?us-ascii?Q?MuY4q3TBMUaOKszQhVBf7tlYsGsrPTrNUW05zSkXa3WSB1wzGvV4RDS5tnPL?=
 =?us-ascii?Q?XWSSUDdLbu96dFS2LpWHoyKiNKrRUhiYmCn2g5ErgYXLcTmvWNvmXTu+P+LX?=
 =?us-ascii?Q?VfFAtnlgrgy1lvQ9ZS5HZAvy8KTDtFQ76bKKS9cv5CjkS2BEWfwjIrEY2vDP?=
 =?us-ascii?Q?f1jXovA9V1FxHICdhYVfK4Q=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 8fe3432a-85f3-45ba-2644-08dd969b6ff3
X-MS-Exchange-CrossTenant-AuthSource: ZQ0PR01MB1302.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 May 2025 06:07:30.1019
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GtMBdkwF12nEb5NUdY/y+dHUvjbQj1DFXKlwa7P21hrcvX7rgzFq5UMcRqDUA5GxRiT1BqZaLjw/0Fd+AqiMysgVXGkUo60nsnhJqcJMzqyZQmElI3PNWbc83bgYaogH
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZQ0PR01MB0949
X-OriginatorOrg: starfivetech.com

CH_PRIOR field is located in CH_CFG2 bits [51:47]. So its shift in
CH_CFG2_H_ is 15. Correct it.

Fixes: 824351668a41 ("dmaengine: dw-axi-dmac: support DMAX_NUM_CHANNELS > 8")
Cc: Pandith N <pandith.n@intel.com>
Signed-off-by: Changhuang Liang <changhuang.liang@starfivetech.com>
---
 drivers/dma/dw-axi-dmac/dw-axi-dmac.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/dma/dw-axi-dmac/dw-axi-dmac.h b/drivers/dma/dw-axi-dmac/dw-axi-dmac.h
index b842e6a8d90d..facdfb453ffc 100644
--- a/drivers/dma/dw-axi-dmac/dw-axi-dmac.h
+++ b/drivers/dma/dw-axi-dmac/dw-axi-dmac.h
@@ -326,7 +326,7 @@ enum {
 #define CH_CFG2_H_TT_FC_POS		0
 #define CH_CFG2_H_HS_SEL_SRC_POS	3
 #define CH_CFG2_H_HS_SEL_DST_POS	4
-#define CH_CFG2_H_PRIORITY_POS		20
+#define CH_CFG2_H_PRIORITY_POS		15

 /**
  * DW AXI DMA channel interrupts
--
2.25.1

