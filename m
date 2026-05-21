Return-Path: <dmaengine+bounces-10661-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cM9iMBIjD2rPGAYAu9opvQ
	(envelope-from <dmaengine+bounces-10661-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Thu, 21 May 2026 17:21:54 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id CF00E5A8332
	for <lists+dmaengine@lfdr.de>; Thu, 21 May 2026 17:21:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 02BF53205DAF
	for <lists+dmaengine@lfdr.de>; Thu, 21 May 2026 14:22:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF1373D7D7B;
	Thu, 21 May 2026 14:22:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="b+GpMC7z"
X-Original-To: dmaengine@vger.kernel.org
Received: from OS0P286CU011.outbound.protection.outlook.com (mail-japanwestazon11020089.outbound.protection.outlook.com [52.101.228.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E1103C583A;
	Thu, 21 May 2026 14:22:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.228.89
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779373328; cv=fail; b=Escp4hfZ+Z/uAqbZ7bE8KYKJwfN9xzu/luwHrPl2MeGu22XSUY4MB2OtJGIEZ6TMV4TBKUe/4UnAkr+IOrB/RDSc/GhHzjdk4sxYyZE49xYCJvRnQGN2wohFX6ASsT/2kI/g2WeLK6UrIzH2lQKh8cm9BstYLYAZlMz6ad/sXf8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779373328; c=relaxed/simple;
	bh=qjtk5WgK9XIBW4jlbb+Ed92akwt1Zc2W2rwqGxwtGeI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=lKZa4jyu4mB9tE6mMNm8+it7DjbPrlEMxmtpRC5ftGb0HkqWmiDkH9JZFzQ7F+gmoD34SKLz7OYyeKY81cKVevZWQrngwULMDCRq+3VVaVftERBd2f7wJ+9gyfzmeLfyVQGpr91Swr8p8TTGHoUd/2/hMgLxCLGgUAAVr5PcoCk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=b+GpMC7z; arc=fail smtp.client-ip=52.101.228.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=idi1lU1cxJz7xRhbbJ2BC5PMXKEX3tALPwLZ+mcy1BqRsTMbpHsXZ/wbWnjFFleMYMA+59T3QdzD/LVPMjApkesf4owTg7YzGPEZ43tZTi55GJ/FfF03Lic6a1oeT9JaFvRUnbgX0oU05i4V6tVHmJvrvkhbBPUDTdnctlxnjY3seTI+7BVaVIb8Rn7x0MRDjWhAhZ+cEFkoxds7L8N3zD473UOvg1ici7ZjgkPECLU+PUaMTrVAor0LIn/lJc/T4GA4jCQK/jyCvqndysRQYtGrN9+zfjq0am6Ok6LWstuqUC3XSO0SgxBPjy9fzFn6HHgoVlUFouPU61BXYQQk4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Pgi2f5L8ZKKxotxELzSGmd3CYUw5kc/8blGTzKAO0+0=;
 b=dA/brlHYK83KRdM2qOrbwsaS4ldT/itlQQf2Eeb4CJJfmW5tygo1prD1bStZ30s3jTPdekHIhDbE/bgl5W7av0CFPaGUu54WU5J95fPR/F6WL5D7rLgkLmd1BicopdExhE0WbPXdpdSShQEiyljsA2FCqI8K93CqG2iNEAqUTxocYG/P0OYxK3JpYf13IgcqiFzhLSfQV99I/EB6HXn3YdamB4OxmbTsbADBHq0ba59fC9o4Yhkr60DVyJMKlKbwI/oYiB1iCsybIAQWeSlbOskv60eVKDH2L4v4c90SRaihG90AWnpPcGQgemwlu7R/dG8KyY8VEynQ2w0aX5dfEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Pgi2f5L8ZKKxotxELzSGmd3CYUw5kc/8blGTzKAO0+0=;
 b=b+GpMC7zcyaO1rNlSfB63XfuxzOEA2u3TWO2tmMf3+zau6uYeeM7l6/zFLL4O3/GtqBebw/RZRhPpncOShTRRVO1hyi1NkBfc4s5kyrVdnDjZa7Tn7IsvJrBAvrvgqwVjBYpjphx1EK1yDNVhWUvCGQAE8aujuwkrkTcVDkPZX8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:38f::10)
 by TY7P286MB6259.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:32c::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.14; Thu, 21 May
 2026 14:22:01 +0000
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32]) by TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32%5]) with mapi id 15.21.0048.016; Thu, 21 May 2026
 14:22:01 +0000
From: Koichiro Den <den@valinux.co.jp>
To: Manivannan Sadhasivam <mani@kernel.org>,
	Vinod Koul <vkoul@kernel.org>,
	Frank Li <Frank.Li@kernel.org>,
	Gustavo Pimentel <Gustavo.Pimentel@synopsys.com>
Cc: dmaengine@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 2/4] dmaengine: dw-edma-pcie: Reject devices without driver data
Date: Thu, 21 May 2026 23:21:51 +0900
Message-ID: <20260521142153.2957432-3-den@valinux.co.jp>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260521142153.2957432-1-den@valinux.co.jp>
References: <20260521142153.2957432-1-den@valinux.co.jp>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TY6P286CA0010.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:3b8::10) To TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:38f::10)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY7P286MB7722:EE_|TY7P286MB6259:EE_
X-MS-Office365-Filtering-Correlation-Id: 04592c05-183c-4e71-9b44-08deb74452e1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|10070799003|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	qlVlGGnj2YHxack/2b9dSxxvhljarvYEKDzs6IFHmszRJF/HGSfovZr+otixdtETkf/Q6ZamjI5VGZHQ7PwLRsRB/72oB+WV6kYz8fdurQUCXWZj+LCjBh5Zy4ib/kvchfrXT46InhTdl3TcJkB9Ck+KkAFPXkKmCZo5j/mpT/miY4o3cLPPGzJr4KdMAKtVn09TJKGXC7hDpIj2jH7wtiz5pIXdYqfkL0TF2oPsPXjq97q/hWFxKnVpFcHKEVd3J3hWDqk+iRyIoNVHp/9RTA5dH+jPXm/obY1heATRQUM+uHpc4ghqk3cafEO01cls7JcXIRwc+IxU4u/fOkyU6uByQgmaSX2wyeskkJG60CzkWYbV86cZbKMwl7LestfgJ8Lj+fOPQivgwkH2gdQiuzo2ODGEreilswzgeXuWqx8LXurrQO3+sPCdApMJ+Cw7exzgeIgEZ+RbxwlSyDGeQE993UHPpXOrCLuX/lUoYmoszmeYrRgKsRkx9Av0X7GO/pt2qJ3ARHt7MmEkgJpSs7inN4zdRAH5LcOIP0webRCrZJTwacV5dZO7zhr04Tgs/YMp/1NXgD8E6yOm9oAMid/HbfXS+9+/P5yCJ95C41ovjLH9K5IqOYmJ1roMLwi1jXFBmsMIPzcXkTTgGlJov1rhhmLhdkWTBRXFUqsvGYK1Ji035A6KhKSSBK5EB73u
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(10070799003)(56012099003)(18002099003)(22082099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?OHt71pOZK9kPBbaS+Xy3hcCiAg1RDN6enWFUs4OLb8q+rXij7deA/dAkpfnP?=
 =?us-ascii?Q?RkdtyZHJ5oH9UFvYWSupyIXlPY8hZliWH4YJ3vvS0qX6n2rcvPgk6TAnbt/3?=
 =?us-ascii?Q?llL/+LD/muEmggu2/cYy5hzWEA6GKg/ecGUm7bHn/3sfTe7ip6ZzKVwGMbU3?=
 =?us-ascii?Q?ikH6zz06/iGFaJVbGRuLYRxHG23CL/+oriWdTxmEvKzisXCuoEbUMX7UiybR?=
 =?us-ascii?Q?HDdnmazKvKq8Hwh1r1RLrufCjE7k2ksy9t5h6dyv0lCze3L1o271g6EQC8ay?=
 =?us-ascii?Q?ZXgKNAS9L522bd1FbByTwEtTMr8QYncWcPKFGYUfT2TOrbs5lQLFzMYiopiK?=
 =?us-ascii?Q?COJSUdBec6saufpbydmwjsm55dlHMjDxcoiy99jx1NGwA8B5WleRkUv/1SzD?=
 =?us-ascii?Q?lnT6Y1Ple3RdsgAWpYB19+j50DkRkrLfW7/DvqXGWGkA0Ltn1hOWrIpxAO9o?=
 =?us-ascii?Q?ONsEj+Rtu/Vfu0nJyGr1ttWXOMMFFhxImCmoY+Mc1B/39yvOqKJ5Siw4k5c9?=
 =?us-ascii?Q?i9rUMreMNeqJR/ZuamIdOAKHC4DS8IxCnET7vVuCr3U4geMaW0n3qvyp16la?=
 =?us-ascii?Q?1L6Cw7+oM0sLGgDTvpLbA8EHbRhDGY7eN9u+yk17BpoVWsX14EdRoUJh+Vso?=
 =?us-ascii?Q?4WF0MASZOHWWXF7TiM5BiGvx+5AqzQZlqRfNewfT7ImdyExlBYsHKubDHqFp?=
 =?us-ascii?Q?5pk0sZB1BJuaAFZOoA26cO8v0U8XaJoXZrMWQnPqchV60W0Hb+SO9BGSloI5?=
 =?us-ascii?Q?U3vufj3Q9NGMU2geNI5Mc+FIKL8QUjJ2LLKorqUI+KfkdIJQD2XxFOwQ3bRs?=
 =?us-ascii?Q?Yft9tkuYI+Dx6l5KRYnJzjox8Xh96eUt+Kyv4USAO7sZti0omq1GPk6jRkmJ?=
 =?us-ascii?Q?frASU60uoPtftuS5xekuIceG0sI9gvC1heZT+1VihDvIBwC8Xa5/wZ/5kbXi?=
 =?us-ascii?Q?+iayH7J94LYHDeEqyGP9QhI92qGPOQ9LuFGU78ZCyOpvOM4ceFM2Zg46hFpZ?=
 =?us-ascii?Q?1wT/0MCz3xoebKXEi2tv2tAvL1I4AEAmyujjRw9mwtmYhiGubIMCIxeGpNfi?=
 =?us-ascii?Q?iTHa/XsfOvmJqhq+Zz1ckJH9MggI1kuf9lAjaCBCfM0FJM4e18Vqf3p9k72y?=
 =?us-ascii?Q?Y5VyqKg4Jq5PUFvPrdzf3RXSbtbK4zYr9gd/tru81FN6nFTNXmbZwAAB3FqM?=
 =?us-ascii?Q?/4y8o3U/XJyFLV441cC8ulFQMUeyUyRK8Xw8NGDvBbzIu79fA/yT00jgfIeB?=
 =?us-ascii?Q?Ultq1TJdZhajIYYWPunhs4Ow9LrU1XmWplp107tyF36SpFw3IlSaQLYnd4CS?=
 =?us-ascii?Q?3QBEYYKvu4Gdy9z1NVG/NH5z7/IEnBSo2HYg4N0keHjsdybN/T4tcxB6okA2?=
 =?us-ascii?Q?TRvcs+q5tZva9HAhZg49Pe0Sn7dEb2Cpq31zCxUqZP4tFEI3rY27hcVWaASm?=
 =?us-ascii?Q?Og6kmfyFWNCjBhKprqAmNGbCumEH45TgyGlvQb5Z6ujERO8g3c8NUAUCYhSY?=
 =?us-ascii?Q?SR5xGMbz+lXNmFqdwoG2mXOncMYWvhkOm85ZiyjA/1TtHZ64nGWmiq8UMLiB?=
 =?us-ascii?Q?0m9k74++bxErE2xIkdVVKw7vJY9WIBpaijanu9esSO/hr1UscQsuOcOeT9l4?=
 =?us-ascii?Q?7zBCWCGstCt5x431yRn77j5cyAc/pgOnNo6BQ81/8rbw4l3jvmdOVSFv+RZx?=
 =?us-ascii?Q?+zZIw0Q0BEUr0KhS8w1EhebqXdZ15QNN6lHQb8HCaRPqjZatDy9nRBqWgfaa?=
 =?us-ascii?Q?s92breDx4RnTc0PnjKWilXxjPSd2fazHhpMRf68mAHMXCbtgV1JD?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: 04592c05-183c-4e71-9b44-08deb74452e1
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 May 2026 14:22:00.9893
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ccH0P+vndvu9KAnwKDlUloEdWFRGQmTbb74mAQ21gFgcy55gBlSfWsYXlvjer5uD8Uqqw2f5X5dnG7La7LOrdA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY7P286MB6259
X-Spamd-Result: default: False [1.34 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[valinux.co.jp,none];
	R_DKIM_ALLOW(-0.20)[valinux.co.jp:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-10661-lists,dmaengine=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[den@valinux.co.jp,dmaengine@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[valinux.co.jp:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[dmaengine];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,valinux.co.jp:email,valinux.co.jp:mid,valinux.co.jp:dkim]
X-Rspamd-Queue-Id: CF00E5A8332
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

dw_edma_pcie_probe() treats the PCI device ID driver_data as the
template for the controller layout and copies it unconditionally. A
device bound dynamically via sysfs can match the driver without that
data, which leads to a NULL pointer dereference.

Reject such matches before enabling the device.

Fixes: 41aaff2a2ac0 ("dmaengine: Add Synopsys eDMA IP PCIe glue-logic")
Cc: stable@vger.kernel.org
Signed-off-by: Koichiro Den <den@valinux.co.jp>
---
 drivers/dma/dw-edma/dw-edma-pcie.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/dma/dw-edma/dw-edma-pcie.c b/drivers/dma/dw-edma/dw-edma-pcie.c
index 87c31d01fb10..c2024fa824e0 100644
--- a/drivers/dma/dw-edma/dw-edma-pcie.c
+++ b/drivers/dma/dw-edma/dw-edma-pcie.c
@@ -314,6 +314,9 @@ static int dw_edma_pcie_probe(struct pci_dev *pdev,
 	int i, mask;
 	bool non_ll = false;
 
+	if (!pdata)
+		return -ENODEV;
+
 	struct dw_edma_pcie_data *vsec_data __free(kfree) =
 		kmalloc_obj(*vsec_data);
 	if (!vsec_data)
-- 
2.51.0


