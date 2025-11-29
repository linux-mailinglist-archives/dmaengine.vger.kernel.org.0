Return-Path: <dmaengine+bounces-7410-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 59174C94325
	for <lists+dmaengine@lfdr.de>; Sat, 29 Nov 2025 17:13:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4D05D3AF8FE
	for <lists+dmaengine@lfdr.de>; Sat, 29 Nov 2025 16:08:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18F4431B818;
	Sat, 29 Nov 2025 16:04:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="ebMiBeuU"
X-Original-To: dmaengine@vger.kernel.org
Received: from TY3P286CU002.outbound.protection.outlook.com (mail-japaneastazon11010018.outbound.protection.outlook.com [52.101.229.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD77930F814;
	Sat, 29 Nov 2025 16:04:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.229.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764432297; cv=fail; b=V/SzKQ1Ek6K89BdQYScDqueIC0eiNXTcKCqqcE4V/IeouVpqfi0Ugp/uojxBuxuhtlGKiBvzAOSwUJ/DWGG2EhW9AcqaLFwVt585G+BZ1ysTyBNK2Dcb6K/LuplR788wIybx9tTy5GNTIkEql9v2K3Sg+S5VQQ8WXJ4Jg8MIMSM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764432297; c=relaxed/simple;
	bh=HXi+L4mAtx1PpF8d1RROstR3YBGyv2hsqckShOyGt+E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Xes2/gUOEse0P43/0sMZ7rSPVPPkFPJmWzcChQfGicZsTA55lqO2/J4RZzdv6A9SSNA00EZS+8i+evKNyPpMeOd4F32zGNnMnrcodpGHef5ykNnEsnGkfIZQUOMeunYo2GU1KZntAzftZC9nAGH5piPGEcChP84ZepGVZpGenPk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=ebMiBeuU; arc=fail smtp.client-ip=52.101.229.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oVJxJr79x9nDsB+zpBBvy6wStMTOkq3CpsPVLwuiOCIhWSKRzbNdXeNxo1mlphQzwXXctUxRuBGJx8rMvo+Sn/XXcY9rZTogJYUtSOWlOPm5i8udYcebOAvOJXbfB0ab+BkjkhA3E/y9WYzP6Ya2UGHa/Rq15reI+l92cooro42NwR9xi9lpIvXgMvB7NHHoNnICoyuBlnkV6SLBNjCiQjUbsryNm84Mrd+TP5hiyyRrYc049IGR3VXdxD+zH6JUhN/YQ8TUQXrWz7YBONwqpjHRPXTDgnmY3k8fxEroqmXVxujoABYFP4jjbuccg7Vl+2LNZdwjvzi4hw0GtEK6eA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=K73zT6e2cLOkOXZ+8ISSn9J7GVdnjpO5HkNV65AINuA=;
 b=yn96g7/JQi4LNjXzOHmrV5EHNwO58axiqqq6SSHg5CuHtIYpfgtswYsu0jSKgSxHlVCMJuN+mV0D0Bxvm4ZFc97oFGaPRhh2dY2BUktCnoQ9c4AVwJBoXpFfjrK/l/4rP/BGTdQTVAZhKo/XX9k7yj6dltKtLdmiz1XzfM6qg9l2isfr6WOv2yzxh+pSaJvnXrAf+DaDyWY8z169GS9aZbAj1/2ZsnfLAV5ove0Tv0dIVg+GgbIztm1oGZKO2vJwWlHV+5xBVvrQlP9SmjJSYoBAGyrgfpeaRjjKGCofeYVGzArgvqaschwD/knJL7lKd7yebZkqpLt949J4jzCRZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K73zT6e2cLOkOXZ+8ISSn9J7GVdnjpO5HkNV65AINuA=;
 b=ebMiBeuUXkM7GYeZafcce+TB02y0lQ0oLY3q4sGFcsDMlCXGuCu5b47IBtEAwn/VzIPsSLfwAG+O+JRAvyZtDkZQkl842g513180G06Sq5AgU2dedBPBtCXY7YKD8UywSzTed4gTPCh2N6EZAfhQNDRmuwBxrfhnuHNxmhSWVg8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TYWP286MB2697.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:24c::11)
 by OS9P286MB4684.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:2fa::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.17; Sat, 29 Nov
 2025 16:04:44 +0000
Received: from TYWP286MB2697.JPNP286.PROD.OUTLOOK.COM
 ([fe80::fb7e:f4ed:a580:9d03]) by TYWP286MB2697.JPNP286.PROD.OUTLOOK.COM
 ([fe80::fb7e:f4ed:a580:9d03%5]) with mapi id 15.20.9366.012; Sat, 29 Nov 2025
 16:04:44 +0000
From: Koichiro Den <den@valinux.co.jp>
To: ntb@lists.linux.dev,
	linux-pci@vger.kernel.org,
	dmaengine@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Frank.Li@nxp.com
Cc: mani@kernel.org,
	kwilczynski@kernel.org,
	kishon@kernel.org,
	bhelgaas@google.com,
	corbet@lwn.net,
	vkoul@kernel.org,
	jdmason@kudzu.us,
	dave.jiang@intel.com,
	allenbh@gmail.com,
	Basavaraj.Natikar@amd.com,
	Shyam-sundar.S-k@amd.com,
	kurt.schwemmer@microsemi.com,
	logang@deltatee.com,
	jingoohan1@gmail.com,
	lpieralisi@kernel.org,
	robh@kernel.org,
	jbrunet@baylibre.com,
	fancer.lancer@gmail.com,
	arnd@arndb.de,
	pstanner@redhat.com,
	elfring@users.sourceforge.net
Subject: [RFC PATCH v2 25/27] iommu: ipmmu-vmsa: Add support for reserved regions
Date: Sun, 30 Nov 2025 01:04:03 +0900
Message-ID: <20251129160405.2568284-26-den@valinux.co.jp>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20251129160405.2568284-1-den@valinux.co.jp>
References: <20251129160405.2568284-1-den@valinux.co.jp>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCPR01CA0149.jpnprd01.prod.outlook.com
 (2603:1096:400:2b7::9) To TYWP286MB2697.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:24c::11)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYWP286MB2697:EE_|OS9P286MB4684:EE_
X-MS-Office365-Filtering-Correlation-Id: 1c678b03-8557-4efb-c6ce-08de2f610319
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|366016|10070799003|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Cg7JUxwZZdmapYc2oUTgFDz321kbYI8NVyVb5+rslUJXRv+0YEvn9VjvDz1u?=
 =?us-ascii?Q?WZut0CK/0Y0AExpAx4Q2GO6UNujgAnLZmPGZMv71ySjbLZOwpb/5YNxl7wD4?=
 =?us-ascii?Q?JZY6vs3qDKa3ac2QjB+sl+uP2YcjD7+0ZGrjCxZbliBfSnPuh3zPnKd3G09h?=
 =?us-ascii?Q?X1If1gRAHiWH5jiJxk/jjXdkpS2mQ2KztuVTkKmNk/ddsiIZGEUmsz5SolqT?=
 =?us-ascii?Q?z7bVmgaWEUg6C1Dl8qivjVPqXuJnWCd6dpWOAasNQV30CC922hUIasoR5HBH?=
 =?us-ascii?Q?+loYSd5DcpY2UyWYYknE1AyYlGkIx8rGHfOv9ITxJ0GEKeDoLIsaKMLH+1G5?=
 =?us-ascii?Q?c7JzuDAcuDXCDjAdK+iAUHwCF42cf5niUp/HcahyY9xX3M2mT6AgoRV2uIMQ?=
 =?us-ascii?Q?FxSI8Z63xRR7WYA/Gwkol52hDCdg6gmm8Sb4rX5Xmt82yUkPhk1dGSjLX6Dw?=
 =?us-ascii?Q?amJitC0FuKycnciimVUrjpURpx23HC0SwpIQQ5v1CkiaM1cMpiVtIgpvF1uL?=
 =?us-ascii?Q?fxTGeDZKbAI8uLXivNwa74wsf4/LqxPZQ86VQvRARJ77fRTonhp/n8MBJWVn?=
 =?us-ascii?Q?sFlTktBYAvsijPDnOGKX1xHkMa7mZxodJQQQVy6bi1IZ00kopdXhkxxsG1bE?=
 =?us-ascii?Q?nRZ238FTmUggQii28OIaxF9UdUMLG9KK9c+iLsku53uead5gBcBRjwzYJccI?=
 =?us-ascii?Q?GkVqsVC3c1bBaF8ik+xO7XZ6hKRG237RKcY8GBz3PgHMiKZEW9iKo90PMYJT?=
 =?us-ascii?Q?w7EDeCYD/0pHc59vrHxfLPUBDWwk6eal5/+2XFoeE6npxzEOOqm+OhUpMSID?=
 =?us-ascii?Q?LQk+uvPWR9k5JnijU7cUMpYO+AhbVlg2QZ0If1Ec9kQ2NDSBxNniNh1ECpqA?=
 =?us-ascii?Q?Q3bcHYx1hm863rarhKHbqyUiDMYWeHC8G1Zr+nIvLGUqPmESC5knTME/Pg5/?=
 =?us-ascii?Q?CTfDnipk+7NytlFPDrAOYlrJvxRGkApsGb/B0Amuty9QeQAOpLl8q9YtxMb/?=
 =?us-ascii?Q?jaHbFzs0U7PxzSIsID3rHlJlxt1Trt0XtR1zxg2GGBt3QSCuuco+d8tXVEvG?=
 =?us-ascii?Q?dsfU7YxS0MhE/ih5CcvPlYXn7kdukmqMXGMc/RisylzeP2gegSVlsMieLdkJ?=
 =?us-ascii?Q?2151YKjgdn00FwEqy1h+a8BgwzVJjLtmyABX3xiHfYOV+EZ9rkwldhko7GxD?=
 =?us-ascii?Q?qH6y0RrkxcfPSZ744OxezyJT3a2KhdBDly/wmsuqHzd57E7wOSy/w05gPQrw?=
 =?us-ascii?Q?52Gll0G953cozEE/bkotLrUVC/oJv/3N17jLsYvlY345ijFSzzCSfnAYHWvp?=
 =?us-ascii?Q?u3PJI7/3KCxaM2spGMTIdcUjS6YJFsnH/1xkQi3zs48Ew9xubUf4XTitIZTT?=
 =?us-ascii?Q?jhbqacCdKQeTbiisRtvuKowompkpIIjn9nU2BKio4u+n054Gz/bz3AFWvJn1?=
 =?us-ascii?Q?f9boeBAFB7Q0T/aKpDs627J0sCNCeo3i?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYWP286MB2697.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(10070799003)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?xEt/dWre3P17t2L60MHHf/8sAHM8adhqJ4x5hZ90JhQ0hWtGHUu7LsPRv0xm?=
 =?us-ascii?Q?5v/w2odZ+V19OXcxpvx/lutXh1nwkobyFkyUJotWe+d5ipePYvaTojy7WKGS?=
 =?us-ascii?Q?acTjVSIQQrsDq/TR9wfbCm8DPN/aHy5xd2FSorVKsW3BaKyK4diNKYC9wqCi?=
 =?us-ascii?Q?uIkIos7nt3gSw/VVZ153GCze3KZNCNBculnwgqIBZtIhLLfTX9y5uIsXu6QB?=
 =?us-ascii?Q?kQnFvzQvHp0hE/juQPAPX1V6LICMvIAB2PiMaDtWVJ7G8Za9eWhYZQj+xWxt?=
 =?us-ascii?Q?6gGomF8PTUcKI88IgmFL635kjA3lzHIvWH/CdyqWvVS2+asvLJLeLxJ0YR7g?=
 =?us-ascii?Q?u57OyxmgIY/Rcq/UN7NDwczjcUM+3UpnswMeI9xLyxicWWC0+GtW8zPSmatp?=
 =?us-ascii?Q?Py9OfnfHS3MjtbLEbvSk05y2HcA3EQRYdxDFUTH0QUopqGZhiD0FpCZc4B0h?=
 =?us-ascii?Q?54O/RPnCvN852DD8VOnmZgblPlrn31ejYJNYPcnzy8SuCAAPCG+CxfKog81X?=
 =?us-ascii?Q?lSrw0DFbAzgGUqop/A1X+A45LhPbHeh5opxouoUD2TNcsTB0QXqlc9O95+/i?=
 =?us-ascii?Q?7YkA9cIo9kMo7/5KDKPvOrkMtwPE7v7vLnCi71I5Bow6PXpeCXroXHcWL8ln?=
 =?us-ascii?Q?cbEk4yfwV8inqrkQQTqCkhmTtU5YZvill7yPjoR6Yzh18dbvnhZhFjdRKYli?=
 =?us-ascii?Q?u77MonsEwN81RR5w81UASTlUcAc4EoUT3f4GTspMX35YIRJA7J6rh2H223jR?=
 =?us-ascii?Q?7bD4C0PG2XAFDLQzTYZzCKMJCahuq1hbe3eHinpRhEK3uNtG9eYBcNtDPqMt?=
 =?us-ascii?Q?rCZac8VkJ95ZADJkze2oag2UnHRobIddodJiLQk1+cfx51/Pi38T8NaHt8dO?=
 =?us-ascii?Q?aodqHHPqfqweGDqjY6PfKOUADWPiTVSUepmKpfjIkTYWd3v0ztzaPTuj75lW?=
 =?us-ascii?Q?c3nPCe2Bd8n4ASOun+gWuCIq4Bzclpm+JClUVIe0NEnMXCiUa/h6t7NFvZ/t?=
 =?us-ascii?Q?FBa0mx0bg635b2tdJVlDO7GxgOPtWPtVb/UlQS2aQCX0D7Apzmx04Ajvr1/T?=
 =?us-ascii?Q?nZioIk/9AU9WvT+KYv8XtpeeCgvOnfJdhSvaDtVIYY2PtMmkDKZ7AULn65F3?=
 =?us-ascii?Q?hlUVcS+xLKTppf/JoWsspleLoW0oGjzNK5BFd5+M5A8KjfasdSInQWsOt+vW?=
 =?us-ascii?Q?986qsjijrCDI08b1duIgRp15HDQ3HpeShx9DCeM3IiicAtAnH5XPQO7MJD9y?=
 =?us-ascii?Q?h1EYIdPv8rWkXGHG6KtBrq925ZRRHWCSH3m8JkwzzEr+GDfNfx8nKb+RxqJ0?=
 =?us-ascii?Q?bVa8EBpktKdkW7cadEV5F2XR4b5AyehUwkfGiN7VHZCVPuj9xIAt/IrB9UDC?=
 =?us-ascii?Q?bDFCp93ngyCQG2PVF/LTU2wHcSjSZfAvnr0chFmSDf+wkVk68H+Zgrsdrwha?=
 =?us-ascii?Q?FzTYHyubQiywpafvrxbaDUtdrWtgkrWdXtbRclGf5pf1V0HBAvCyGpUgd/nJ?=
 =?us-ascii?Q?f/CvButogHAgnXG69VOhl4s423YzRlpmdViDNprH56Aqaa8XD8/Rtb6qKWmn?=
 =?us-ascii?Q?xz8uytYYf7P8ebzImsi8Dznwa/z5yC3qtsvYNJ2ejMl9Eknf3++Jo/c6G5bZ?=
 =?us-ascii?Q?rBJGhpm/O3dEFLzpzqr5lYc=3D?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: 1c678b03-8557-4efb-c6ce-08de2f610319
X-MS-Exchange-CrossTenant-AuthSource: TYWP286MB2697.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Nov 2025 16:04:44.4176
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TsSU1g937rlTkq7nTOb1s14h25nH3HddTYtszKj3ZDIUszAF9ARR30K99IjJQSLjeTHWCc80hpFtmkJVCbGb2g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS9P286MB4684

Add support for reserved regions using iommu_dma_get_resv_regions().

Signed-off-by: Koichiro Den <den@valinux.co.jp>
---
 drivers/iommu/ipmmu-vmsa.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/iommu/ipmmu-vmsa.c b/drivers/iommu/ipmmu-vmsa.c
index 724d67ad5ef2..4a89d95db0f8 100644
--- a/drivers/iommu/ipmmu-vmsa.c
+++ b/drivers/iommu/ipmmu-vmsa.c
@@ -25,6 +25,8 @@
 #include <linux/slab.h>
 #include <linux/sys_soc.h>
 
+#include "dma-iommu.h"
+
 #if defined(CONFIG_ARM) && !defined(CONFIG_IOMMU_DMA)
 #include <asm/dma-iommu.h>
 #else
@@ -888,6 +890,7 @@ static const struct iommu_ops ipmmu_ops = {
 	.device_group = IS_ENABLED(CONFIG_ARM) && !IS_ENABLED(CONFIG_IOMMU_DMA)
 			? generic_device_group : generic_single_device_group,
 	.of_xlate = ipmmu_of_xlate,
+	.get_resv_regions = iommu_dma_get_resv_regions,
 	.default_domain_ops = &(const struct iommu_domain_ops) {
 		.attach_dev	= ipmmu_attach_device,
 		.map_pages	= ipmmu_map,
-- 
2.48.1


