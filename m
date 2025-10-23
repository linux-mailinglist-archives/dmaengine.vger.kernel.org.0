Return-Path: <dmaengine+bounces-6954-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id F1C15BFF969
	for <lists+dmaengine@lfdr.de>; Thu, 23 Oct 2025 09:29:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 1DDE2504D81
	for <lists+dmaengine@lfdr.de>; Thu, 23 Oct 2025 07:25:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7FB82FE04C;
	Thu, 23 Oct 2025 07:19:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="L+BDCzpX"
X-Original-To: dmaengine@vger.kernel.org
Received: from TYVP286CU001.outbound.protection.outlook.com (mail-japaneastazon11011003.outbound.protection.outlook.com [52.101.125.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAC572FCC04;
	Thu, 23 Oct 2025 07:19:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.125.3
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761203994; cv=fail; b=NJMRFA/9vMLM6pf3xNZeNxIYJU9jSlo1V/irOrwf7idyHcSsJQyQoMmPtlfIAvVZwp1qtESk4ae4ny5iYIcwIpUgTpUgV+oErB1FhD13OyVmMee7XQnxkmpilaXwOJBf1qtWUgP8Y0aVIzsvnQu/td23tR0brxGfCJn+Yi8ElJY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761203994; c=relaxed/simple;
	bh=5wPpbTVhuuvQ8x68E3FE3zT5J7V9NhSuy5vAXiL0vrA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=n2iHoJVFVTQ/7CpIaXYevBtJgmYQ1KbeTktlnZzM6kYzs7SCW34D3tjkMuEi/SNxwP3RhI/eQVw5aEZaqthZfyiPS+nwPJRRA4LYLQYCLlScI6LwTI8QNgz+Is9m1IWUnq+0J4B30c2SfQFtPb6BaOCBybmguz+a9TJM7YCcs2A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=L+BDCzpX; arc=fail smtp.client-ip=52.101.125.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wm/ptE7nGIge5x/Mnv/BjWxilWirm2hsoQM/m0+edplXTiu0fWVCDM5P58m1dLPgIZO7SYg5EDKA2VA0gs6UAC+lEUNt6I+uU+W680pzJG4DY3cqeBZrkxs8e87HDvMGUjy0yYsueNQqqwvrkzDxmLar2c/2Qlj0q1JE+u7l2Y+2XoOHGNvMSGVYB2RBEo3Oxzdr6iRSLlV+FS1gdopDsor3Qz+V7Abe0Y8UDkqRsY9pZ+83xALtbW133xra04AoYZ433J8i66yYaHGbKoUYfqEQyP9to+eDW1Wg8pL9Yy+q8A9twp1W3m8zc6jW9It8oeeOjVmtFV4bMP9aQGwvhw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vLAUp4WET7hRSLjxhkwYZVQZ1yL7mW6B4jmZnjtcnpM=;
 b=sUrkgGlPOQTy53w41z+ho0+LrykCFjQbm2vIDyATV3qxM5JTXPHPmgEYNk2nCOkALrfOE7VcAv0Wn78BEkcJLGEXcDb6JjlpoZaVaxAFQ1EMaMjrMrvXx5Zaw0ia+5tXLZs60avV1RRFnBWz4opu6qUB2owetbQpApvPybd1KwijrM0N3fn55yP+OEbTocf8Ky0UfxNFr5PUqIYSzEqDxt4cRymIM9HLDKKuskVaCK9y3PNpcMf6XaJSRYNrUpe21hB6IF1gbWRe607hRZs9M+eiuOWF3fW33gtFhKPb1wPLYFngeLDv13a43gkFE51cSJlOVx2x2GzTjzSLHh1UHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vLAUp4WET7hRSLjxhkwYZVQZ1yL7mW6B4jmZnjtcnpM=;
 b=L+BDCzpX9k8UV2JK6OmckOs/5fSW7HsapQxAb77mrvKBWaO+sL3ji86+nVtocd7HjFgsMDEyF6effFzE+L4Zn1AvjDpe/LqJTqNyY7/sQlA085uXqIlAIlWohjDcVTJiK+TjWSEbCYaT/IyeoffKNYdyYsZ0NKDcoiPxY37ZrHo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from OS3P286MB0979.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:10d::7)
 by OS7P286MB7183.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:456::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.13; Thu, 23 Oct
 2025 07:19:45 +0000
Received: from OS3P286MB0979.JPNP286.PROD.OUTLOOK.COM
 ([fe80::80f1:db56:4a11:3f7a]) by OS3P286MB0979.JPNP286.PROD.OUTLOOK.COM
 ([fe80::80f1:db56:4a11:3f7a%5]) with mapi id 15.20.9253.011; Thu, 23 Oct 2025
 07:19:45 +0000
From: Koichiro Den <den@valinux.co.jp>
To: ntb@lists.linux.dev,
	linux-pci@vger.kernel.org,
	dmaengine@vger.kernel.org,
	linux-kernel@vger.kernel.org
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
	Frank.Li@nxp.com,
	fancer.lancer@gmail.com,
	arnd@arndb.de,
	pstanner@redhat.com,
	elfring@users.sourceforge.net
Subject: [RFC PATCH 18/25] NTB: core: Add .get_pci_epc() to ntb_dev_ops
Date: Thu, 23 Oct 2025 16:19:09 +0900
Message-ID: <20251023071916.901355-19-den@valinux.co.jp>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20251023071916.901355-1-den@valinux.co.jp>
References: <20251023071916.901355-1-den@valinux.co.jp>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCP286CA0249.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:456::7) To OS3P286MB0979.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:604:10d::7)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: OS3P286MB0979:EE_|OS7P286MB7183:EE_
X-MS-Office365-Filtering-Correlation-Id: fa59d1b1-7b6c-4ec1-f2ac-08de12048ac5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|7416014|1800799024|10070799003;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?HTLTdXUnknkd+c5X/1Ldonz6auRMnTq7pweBq9/TbrgvRM9yG0zSTjC9Yop3?=
 =?us-ascii?Q?fP/XzUMLin0QjEi7UjSls/kERo4XSl45gJCRe9EXzHjCACj9c3ar3z71LL+U?=
 =?us-ascii?Q?jO3r/Ruu6GQ5EczysoLelOIW+YtG9guZtl5dU4JcjdLO3IAn7pByFdPNzBaw?=
 =?us-ascii?Q?/H6qYtgs2V3NRRlJSp3oRZXmbDiKKP+7yRg41Jk7lc8NySljx92l2IAYiY/n?=
 =?us-ascii?Q?L4qvHp5nVvelanIS5GtkJamc9Auo6RlPoiDNybgrq6CCGM/lEaye3Sjuxzd4?=
 =?us-ascii?Q?jBqAJd4k2wwIUfkWQLH05dvASxR+6r+TAJd/wuSiCxIQHZOJ9MwHZl6gyxKf?=
 =?us-ascii?Q?KROBBXn3jyg11EPkfbWpBtYq2dmUUvBwiZwpZ3xU1x9ek5hikqbMaq1jrfc4?=
 =?us-ascii?Q?kBm/DEXMYwwH+cjnVUBImpxGRjwW5k2rs9HweV27d7TwavMFQTGandXiSFqb?=
 =?us-ascii?Q?CHL3iKzMUKjSQB2WzmdqHNx6Oe0INiG6n05kig+XRRk7ODTyju8HqgzcATaE?=
 =?us-ascii?Q?bm/b8KuZqY7DgbVlO0+MCQ0esVSIfEYu8LU6JySgcDfu00YJtKf3L9ZPDqHQ?=
 =?us-ascii?Q?RUMKo0Bfykav9NiqgMrvqekSq4CSN44T9UposaT27ocacOtSMU3DJEWovdDq?=
 =?us-ascii?Q?82TpZO+kpIstWtqGn4CddeuSk2PbnegpkSIQFu+F1QtC8uLrLiLCelbKbI1K?=
 =?us-ascii?Q?cIOh3ZTHtAvyrWEUFliqz1m8LZ0Jc3p2Ba8/1353aVzZ9aSQ+DIjkQ7BFmm2?=
 =?us-ascii?Q?AjWxBnVaRZDRGKUK7/lk/OFOKNUL6yVf6+MhecY1DFvOHFuTtY/TEXlDJl6H?=
 =?us-ascii?Q?jbSbc9sO9zjos6Mvbp3qJ46myzC+g1LLps3cboQL6sEmFDkjnTsF8OzVkew/?=
 =?us-ascii?Q?4Ay2Yia7JDcxsqLQoLuALSnie0TTOACpbV8v26Dq08m0yfRJGLh4PGeF4IxK?=
 =?us-ascii?Q?L9Jwln3D0nFGH9KhhgVYj720WPMyDCwfYK0iQ0bqBnwb1LmQJF9AALQuAvR6?=
 =?us-ascii?Q?M9g+7N4i2PaBwlv40NI4s2vxiLmBZLoJmaBfY2TdgTbO+HacY5wOWhEROjtT?=
 =?us-ascii?Q?hu26quyztSxprFYAw6UcvOVff7sxKmMoHb99JFvn6dbNkjmjyzBVIizr7XcQ?=
 =?us-ascii?Q?vPZQq4kC6tNNML+WT8EaziDCzVhrrPkTueXFxdgUWHIbu/bmLyrdc2AR/+vd?=
 =?us-ascii?Q?7SWhWhkzPynW8w+72LTYVDz+zLQXOlPfMVR3f3PZHYqE6Yy3UL18c4WtvkXV?=
 =?us-ascii?Q?qBNaWpP8jzElQmEHvyKfRu7hK2gloifi/rSJuYl6a9ZGBDrSvm6kjJBOyEsa?=
 =?us-ascii?Q?uzl6MB0/2SdcUrp1kOnB+zkRxw0e8FDsPHgviXQUoK3HPR3UPj5I+1WwoE9A?=
 =?us-ascii?Q?AjI7m2czlakGbQif9+wxOuqZINPYZKBXe23QVxyWHS1CvVyqkWaM4qHUKcwI?=
 =?us-ascii?Q?bSZm1LV0N9aiSFIx/0RugY6z0mELkyj/?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS3P286MB0979.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024)(10070799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?7e0AiRySZ9SFnXtFz64JZniXyhIiNt2FTffJu7/0OhYcMwMfuA8+Cv456Vx0?=
 =?us-ascii?Q?+sMzRhENNmRUcKKgJkL46fI61h3l0+WEV4x0830fDQxd6Kz8sGymDAT1uefI?=
 =?us-ascii?Q?z7igjFQft2tWtzl0MtYhoxdyZdCiWLSYKdYq+Yh1ro7VNdiMO4FXizAtVPPH?=
 =?us-ascii?Q?B17iOBASq83An7VRvxj8rl4B1Fh5UmpYT/f2t9cNDLm0HobmEEsEudkgaiMX?=
 =?us-ascii?Q?CXia/R4UqSqJwo1dI45x63zdBjmz4d+gq3arrXTc2m2zrVGXkGwVuV1Hn/DT?=
 =?us-ascii?Q?GwQRgHNNcacShhhs7XIvK83DcmJxw53p597KAnunMzzJuy+ar1YXFIjeQhkL?=
 =?us-ascii?Q?JUNbwo2GTht67te3qqqie1ClOZFB5l12Z3Xgrx5dyxzhfJu6woW3o9y6gOQd?=
 =?us-ascii?Q?FW+sOM6vIJiILCuLrW+4kW9EofCGIvcR+B9b7md/DwfpfBlEDS5kx6NQAWnm?=
 =?us-ascii?Q?HG7lS9TDV/3h1mhcFNwuo8Z/xcQveR3+7LEm0v4uT6g8q0wm08dX8grrq1lb?=
 =?us-ascii?Q?RjX3iTz7g2PcSJBm0bjzpbDi8SQac44y151iRcOUUO7nbWrUBArEu6q+BGC1?=
 =?us-ascii?Q?zrl+bOzLzyRW56rle1TaKCE/Cy6m43TEQtQqTPbFW0ght9gs7aHyPTG28g3D?=
 =?us-ascii?Q?ZXWaRI4a+5TUst46IGSRFvSX56XzIUJjnW4h3Gr/7z+UKHPc0ToK26LCRSxO?=
 =?us-ascii?Q?7PAbN8rRiTMG+W22EpSKmd/luiF4Hm7xbROxnhU706VOz65haeu4rJV/P5P5?=
 =?us-ascii?Q?2aBuik7i08EifL4tTq5qpeL0RmnBmoyWhmXABf5HBG6rFuTjgm2BOB7Yg22r?=
 =?us-ascii?Q?n46vXxmacNaQHzFO8rmuDiI59nx29cubSmN1qgLLEnUZGnWvHyYIC+J8W9LD?=
 =?us-ascii?Q?yvoJhSG4GNWwSWnNXS0J4owBRaQyg4MTx5S4zq1ea7Rz89EcYniF5mTdG4Yc?=
 =?us-ascii?Q?fesEXBc2EC7Mh5VsOmDLsyslgmdQi2+iVrjOYez9kTDAB/qkW94sy+0X288p?=
 =?us-ascii?Q?Uk+mRQRG4STVeoN4Efi34snXnkoV1nAlgBD99Rjgoou6wAwlxpef7VGY0tBB?=
 =?us-ascii?Q?LAB4RA/qa6KUrgNgHHJfb/vH4SYIfxOLGa1Bvw3e5BDEdGYCtSVobA601xyI?=
 =?us-ascii?Q?3kg+3qcI7JBg1fTRP+yguWqKLXAKaNfOQ6U+OTtWyIeINKxOcgELAm2+nFZa?=
 =?us-ascii?Q?9h9BZjJqc/tzi3V2NZzlMMoLO9VqF6obvPirbvYvP4gU9rK6bmMkAFL14hXY?=
 =?us-ascii?Q?q01AY/4LwzsWjWPybJt8Lbbfrg4KUJ4kxv1iakX2szVZV5bXTaFpUVYT9khv?=
 =?us-ascii?Q?6CTuoqODANtox+5g8vHfs7urX7XxUq/UROKCYlSmZNzxKzf7XbdIqlfpUZ8N?=
 =?us-ascii?Q?Q/EIkK/MIxtXKdgFUHH1PkWD+LJFx3+tMjldxcLtlXZe9Kqcongs0tQUzmmu?=
 =?us-ascii?Q?OhBcLOMPHgNjda+4KRy+mkDt5WzrMOfjHp+VTg/kjW5PtN3ThnC6GUzzZqVo?=
 =?us-ascii?Q?YKvB3+o8K4yQUOe12zAAahXrK+mWyAv/kJNwWJD2ooW+XK0hHWrygXPgIwM1?=
 =?us-ascii?Q?0YgTCNSnCHL/8oMsPXYa9wg6MCFTQZmH4QYvhYCfbW1hHcSZT3olT8Zz3h8+?=
 =?us-ascii?Q?JiSBuUNz9PksgPva7wuORUQ=3D?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: fa59d1b1-7b6c-4ec1-f2ac-08de12048ac5
X-MS-Exchange-CrossTenant-AuthSource: OS3P286MB0979.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Oct 2025 07:19:45.1573
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EKQSkP+0inSdJyKCig6W3ZB2MD4pv9Kb+FbTq8fL0Zck+F6CQmUkKji99Jt3/+Dxz5uHk036aOPxZz3eA4pk0A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS7P286MB7183

Add an optional get_pci_epc() callback to retrieve the underlying
pci_epc device associated with the NTB implementation.

Signed-off-by: Koichiro Den <den@valinux.co.jp>
---
 drivers/ntb/hw/epf/ntb_hw_epf.c | 11 +----------
 include/linux/ntb.h             | 22 ++++++++++++++++++++++
 2 files changed, 23 insertions(+), 10 deletions(-)

diff --git a/drivers/ntb/hw/epf/ntb_hw_epf.c b/drivers/ntb/hw/epf/ntb_hw_epf.c
index a3ec411bfe49..d55ce6b0fad4 100644
--- a/drivers/ntb/hw/epf/ntb_hw_epf.c
+++ b/drivers/ntb/hw/epf/ntb_hw_epf.c
@@ -9,6 +9,7 @@
 #include <linux/delay.h>
 #include <linux/module.h>
 #include <linux/pci.h>
+#include <linux/pci-epf.h>
 #include <linux/slab.h>
 #include <linux/ntb.h>
 
@@ -49,16 +50,6 @@
 
 #define NTB_EPF_COMMAND_TIMEOUT	1000 /* 1 Sec */
 
-enum pci_barno {
-	NO_BAR = -1,
-	BAR_0,
-	BAR_1,
-	BAR_2,
-	BAR_3,
-	BAR_4,
-	BAR_5,
-};
-
 enum epf_ntb_bar {
 	BAR_CONFIG,
 	BAR_PEER_SPAD,
diff --git a/include/linux/ntb.h b/include/linux/ntb.h
index dc5aab43abc2..9f819c7383a3 100644
--- a/include/linux/ntb.h
+++ b/include/linux/ntb.h
@@ -59,11 +59,13 @@
 #include <linux/completion.h>
 #include <linux/device.h>
 #include <linux/interrupt.h>
+#include <linux/pci-epc.h>
 
 struct ntb_client;
 struct ntb_dev;
 struct ntb_msi;
 struct pci_dev;
+struct pci_epc;
 
 /**
  * enum ntb_topo - NTB connection topology
@@ -256,6 +258,7 @@ static inline int ntb_ctx_ops_is_valid(const struct ntb_ctx_ops *ops)
  * @msg_clear_mask:	See ntb_msg_clear_mask().
  * @msg_read:		See ntb_msg_read().
  * @peer_msg_write:	See ntb_peer_msg_write().
+ * @get_pci_epc:	See ntb_get_pci_epc().
  */
 struct ntb_dev_ops {
 	int (*port_number)(struct ntb_dev *ntb);
@@ -331,6 +334,7 @@ struct ntb_dev_ops {
 	int (*msg_clear_mask)(struct ntb_dev *ntb, u64 mask_bits);
 	u32 (*msg_read)(struct ntb_dev *ntb, int *pidx, int midx);
 	int (*peer_msg_write)(struct ntb_dev *ntb, int pidx, int midx, u32 msg);
+	struct pci_epc *(*get_pci_epc)(struct ntb_dev *ntb);
 };
 
 static inline int ntb_dev_ops_is_valid(const struct ntb_dev_ops *ops)
@@ -393,6 +397,9 @@ static inline int ntb_dev_ops_is_valid(const struct ntb_dev_ops *ops)
 		/* !ops->msg_clear_mask == !ops->msg_count	&& */
 		!ops->msg_read == !ops->msg_count		&&
 		!ops->peer_msg_write == !ops->msg_count		&&
+
+		/* Miscellaneous optional callbacks */
+		/* ops->get_pci_epc			&& */
 		1;
 }
 
@@ -1567,6 +1574,21 @@ static inline int ntb_peer_msg_write(struct ntb_dev *ntb, int pidx, int midx,
 	return ntb->ops->peer_msg_write(ntb, pidx, midx, msg);
 }
 
+/**
+ * ntb_get_pci_epc() - get backing PCI endpoint controller if possible.
+ * @ntb:	NTB device context.
+ *
+ * Get the backing PCI endpoint controller representation.
+ *
+ * Return: The pointer of pci_epc instance if possible. or %NULL if not.
+ */
+static inline struct pci_epc __maybe_unused *ntb_get_pci_epc(struct ntb_dev *ntb)
+{
+	if (!ntb->ops->get_pci_epc)
+		return NULL;
+	return ntb->ops->get_pci_epc(ntb);
+}
+
 /**
  * ntb_peer_resource_idx() - get a resource index for a given peer idx
  * @ntb:	NTB device context.
-- 
2.48.1


