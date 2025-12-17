Return-Path: <dmaengine+bounces-7769-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F019CC8780
	for <lists+dmaengine@lfdr.de>; Wed, 17 Dec 2025 16:35:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 6ADB931AD2B3
	for <lists+dmaengine@lfdr.de>; Wed, 17 Dec 2025 15:21:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4431352FA3;
	Wed, 17 Dec 2025 15:16:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="Ke3yNDkx"
X-Original-To: dmaengine@vger.kernel.org
Received: from OS0P286CU010.outbound.protection.outlook.com (mail-japanwestazon11011052.outbound.protection.outlook.com [40.107.74.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B65AD337BB5;
	Wed, 17 Dec 2025 15:16:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.74.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765984605; cv=fail; b=Z2IzcCa4QN0W4ImA3pUC+g9hmuXc13rHUHvBy513c8+MdM8NlRPqx9hCtNzRbsuE49ZSWp67FqqME+KuWVeiLL3KNPqtsqaK1Bq6digWSE/xnZCSohkJPnj8thG9nxM8XGMnOuU06SxTUjKqlTrOPL/wibNIZzHsxOIJzQf0cIA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765984605; c=relaxed/simple;
	bh=XxV654qT010yfLqQ99uubGh0AZS0QtmDmNC1jlPsfts=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=YHmg+p4HYAsSX7XqWpgp3SNhy4QOdg5NDHVvuTImp/kmDbV1kRmAidGUFsasjN9K7gVb+dpI11b+4xSzQIYvtUCjv/IlQOaylyrNhbRiSSQA/YpZImMxGFpV8HpcE01fNp64kWTWU1QwX8txPPcSITiLxZMCpL7ffZPcKuuwZZE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=Ke3yNDkx; arc=fail smtp.client-ip=40.107.74.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VLxuutJ229zkLHJKcaUGfwww+oSIBSKl3dLaxFlOgVxTXDAtZ9nZ1LHr266D6WiNFWI+MzTuMMvcvG8QDo2YUh+vvI2Z9ea+H1zQdn79qHjP09OG5bD4AQSTZCNB8LiPQHspriUrvQA8WC+qSkF8yeZ9op+isHw6WIw0UU5KSEMt560whARTQt980wJodPFOdw1JfPNdhF7UIY3gDUwluK3lVH+mrSDJJr87iLKZ9dcXBwnMOcuFOx2rdblkOnkU0XL3amE6g6oP+/P4X2yvioU5ogiGenhjBOcDzVCiE2gkwGF3CGDXrsCee5oXRPBBV0ZvRoxZX2N/9wD+Adqk3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VUuYeMpUK68Hba0iinbGxC+9YEVxmqsLgGgIWoMUNxA=;
 b=wCEnSw5hdeFPy9kWjvWTTYlGsLVuFtU7GnaQWT1wK4CIGsvPead+DJpFZpMWFXvbBHb+CvqcbLwz4HzbLcAgMehdWd8dxZNAS4V3Shjg3wgX/Ju2jsW7TddfhF940EhipI1PksXZq3MYDwRL4Mn8Y2d2YwKUNRDhemx14v1CfyrQzFxv4H+6BWiBuRXNOz63ta4lwvrAhyZTiYZZQMFHSYQaEhUyu7IHd9WsTZELRg1YBQ11nx8pGtu/Fw40BGD/FrJYv3g29fcbn1iPs3RDU1krAERgwH1vCdwGnYAzZHd62UqMxXqxKl6XUlhn/T9seIpqnIu31CLcu2cPrtZLug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VUuYeMpUK68Hba0iinbGxC+9YEVxmqsLgGgIWoMUNxA=;
 b=Ke3yNDkxqHb5w3X8UuborJdgiifu7QiS9sfAE07UplI+2Hdpc/zON3kImlF9EPtQcxFNPkEcgW62pVcQlbmx8BaossG0oSABuvpU1x7+Lj1/YuyQkAhMtSEcxNXVKeRLt3MIArOHI2Isrz47EVM4Q9s0FirHY/cSLkSmbqDJ4yQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TYWP286MB2697.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:24c::11)
 by OS9P286MB4633.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:2fc::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9434.6; Wed, 17 Dec
 2025 15:16:27 +0000
Received: from TYWP286MB2697.JPNP286.PROD.OUTLOOK.COM
 ([fe80::fb7e:f4ed:a580:9d03]) by TYWP286MB2697.JPNP286.PROD.OUTLOOK.COM
 ([fe80::fb7e:f4ed:a580:9d03%5]) with mapi id 15.20.9434.001; Wed, 17 Dec 2025
 15:16:27 +0000
From: Koichiro Den <den@valinux.co.jp>
To: Frank.Li@nxp.com,
	dave.jiang@intel.com,
	ntb@lists.linux.dev,
	linux-pci@vger.kernel.org,
	dmaengine@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: mani@kernel.org,
	kwilczynski@kernel.org,
	kishon@kernel.org,
	bhelgaas@google.com,
	corbet@lwn.net,
	geert+renesas@glider.be,
	magnus.damm@gmail.com,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	vkoul@kernel.org,
	joro@8bytes.org,
	will@kernel.org,
	robin.murphy@arm.com,
	jdmason@kudzu.us,
	allenbh@gmail.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	Basavaraj.Natikar@amd.com,
	Shyam-sundar.S-k@amd.com,
	kurt.schwemmer@microsemi.com,
	logang@deltatee.com,
	jingoohan1@gmail.com,
	lpieralisi@kernel.org,
	utkarsh02t@gmail.com,
	jbrunet@baylibre.com,
	dlemoal@kernel.org,
	arnd@arndb.de,
	elfring@users.sourceforge.net,
	den@valinux.co.jp
Subject: [RFC PATCH v3 15/35] NTB: ntb_transport: Move internal types to ntb_transport_internal.h
Date: Thu, 18 Dec 2025 00:15:49 +0900
Message-ID: <20251217151609.3162665-16-den@valinux.co.jp>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251217151609.3162665-1-den@valinux.co.jp>
References: <20251217151609.3162665-1-den@valinux.co.jp>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCPR01CA0165.jpnprd01.prod.outlook.com
 (2603:1096:400:2b1::18) To TYWP286MB2697.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:24c::11)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYWP286MB2697:EE_|OS9P286MB4633:EE_
X-MS-Office365-Filtering-Correlation-Id: f6e9b233-bf32-446e-a025-08de3d7f3f8a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|10070799003|376014|7416014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Cm37kvuiBxf0gVklDrYNYKz6BAi+pxlgoejZl4kpBVBGsdwHWjAjNgiYTc5k?=
 =?us-ascii?Q?DrQWSuo+kY+YaT/olAVoOHsBDH9j237gZjcbj8K+pyoxMHycqwQq9blYQnRc?=
 =?us-ascii?Q?3Wf0cGvBYOBHUBkArHeObiJiCTbiqG5mLu48A+P0EmFK0hChqU0duIyFhKId?=
 =?us-ascii?Q?bT2IHH3ZKiRRgq26Bomze2J/joOKVOZ6yAoIdZ+pBgCOJKjp6t6zPpdFyFQo?=
 =?us-ascii?Q?kXzBImi+jinfw8xHBvLI0EFiXo3rZTGysIh432Prv/BMUKHDdCu93iPODEM1?=
 =?us-ascii?Q?7EQDau7jLrteYu2YY2Q54dKCG9VwYPF4W6LQsgsbHfCPq646VYxFNP01AKk3?=
 =?us-ascii?Q?7xYzLrxYzayRkw3CiZDdWesH7e4RKFRKkYr8wW+OcimHwe98+wjBycSLt3JV?=
 =?us-ascii?Q?XEvGnCGkdfGqglNey370e4VXm2dk2j6m/AtjMOHhH/YRJfnbY+nhkapFpq9x?=
 =?us-ascii?Q?YKDmcsw94drbQim9G4TT5jr8/c5tItXoxW7UuN+kXj/I3X1YdTZ8CSOjc2oJ?=
 =?us-ascii?Q?eaSr+8LBkhMoMmUGeKp0JCUaAfjUtrRF/P8uMLkwEh/noouZKo679sXm5z2S?=
 =?us-ascii?Q?zTsxqGb9/g2TciLgc+Xe4gLvxsnj8UQgmLQ+Xu2PDoPqaRh/2nlBL0pWdplc?=
 =?us-ascii?Q?pCCt6ItmJbyMmrTtxV/d1ckuxlWxghR29ZsQhDQjWq1cVH1TjhzL+xgyDy0I?=
 =?us-ascii?Q?ODAAJiyHAqrVS9ajv47UKiWTn4pvdkD+zVzIODREyGm7yIfZPyHxumDjssie?=
 =?us-ascii?Q?YfD0gl7JEVfWZhIoTC6+zOEK75JjZvfEmYGkmqePCoHtZCUjcFM1gvZ40VLh?=
 =?us-ascii?Q?B41wuIVypoPUylr4f4VD0o1YSTZalr+S7kPRGgCsY4ejZevPruLNuKNBmtzb?=
 =?us-ascii?Q?8lOPvDMzsWcR+8ZAwuqmNDM2LJKVTiMWbtEkyH1gwzSFzBRDDlSixKYhqBhB?=
 =?us-ascii?Q?NTkk6IgCQHQlRse6TDah6IfxGpc38pF8ROUZmy4j9ExstWaYGYERggcPnFZy?=
 =?us-ascii?Q?IUoujDXlNcUHM5w2vWe0IPRQhKegxdxCbBYPfNKbPQ6V3tGzfCSENYAyIn58?=
 =?us-ascii?Q?OmEoBp8nOX/82OzwUgXREzshw8R/Am/jF1uNgI8hcLPRzoWEJNp4+n1Vch3Y?=
 =?us-ascii?Q?kGvOZ2mmnpEbZXHzql3T1sm8ni+mCjbwjvU+F0FYIaZkmrXkbmeCo9V5LaxO?=
 =?us-ascii?Q?+n7odTqpqPzJJ7xgKDfSQ6RtW6fsAZ4KX0rLcS9E9GnMTbiV6CmZ8Rf75l6C?=
 =?us-ascii?Q?hD5He1s0103C2dSRAnLn5TsOpJeOcDkbzcbnZD5OXSC5ay9u6KGowysKSymr?=
 =?us-ascii?Q?CBsZStaXNQ8XTzsBd9ijPBJ970njYyg9AaXibWgiZS7dmFJ4bfH+bjiCH+q4?=
 =?us-ascii?Q?eY16FdGr4FnT7tcFkBELPtnGn2L1NLWbS1VbsGconutk3OBX74yWvbjGGKGw?=
 =?us-ascii?Q?ds0NW11tLcutOTiPGvz71LlJFTu5RaCG?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYWP286MB2697.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(376014)(7416014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?5dUJaeI7ZkY6yaWvukIdpgVxdKzhsb7SdoziadpsFD82uDFN3bLn1Cqx02Kn?=
 =?us-ascii?Q?4Mur+B2SHO9euPfiZg3rYSMirvD/casEx7K3czcVdFa+HqAe4//VCh38zWqU?=
 =?us-ascii?Q?aDTsDU+aPuhNNDhD6q9U8a19Tw0nxCWrbAXrImQi3OAFhsjYFTEG7P8l/nwH?=
 =?us-ascii?Q?6YA0Dq6C5wxuWCu/3CtGfhLhYr40whjKiSziIw0+ncZsLY6rb9JcBzAfJCTw?=
 =?us-ascii?Q?tBOUFJ9x+y7M673U84bcsyeQvBX886Iy/gdyclixKp/ssrbRzF5BYkRsRAfS?=
 =?us-ascii?Q?DZF+RHo6zPECtaH9mT3yczyMmFjEW6mBKzq5BDg1vdWEwQMAtLDi71sSOXyX?=
 =?us-ascii?Q?hnlaugjeRI0KF8JOS/jijud8mhWGxHS8BuIhapwpob99wRm8PUHg0KjP7nzW?=
 =?us-ascii?Q?Xj3llWkYoyPTCnlxpmSgnaUACWl9Fmj9ShpPW4vBZ7m1T00JTRUCp28wet9d?=
 =?us-ascii?Q?E8QFVXM9ou18m95TGT06rfvQ2Pp4d7O+DhNF+QpTrtNSxPpK47JaLKSQMLOG?=
 =?us-ascii?Q?Hg6J+lrazCISqww5/7xwn4BaJI9ebel53bGT/P83ibdcNWps6tBEifdIPs0G?=
 =?us-ascii?Q?AwXJZK1CP/lTiBTZ1RqID1LaQQNiEmWSqk/XzfpgXQwbtbc/NVHuwzDFo3zC?=
 =?us-ascii?Q?0lwIzoPPvdOc2ShYOKXDfS9Spssbg4170cbLZlC+mbdIu1xdK1i4QZkC8wdi?=
 =?us-ascii?Q?8pIq1EbFUqGWr9aFf+PtBiJe/h8RfHQyQftjbNDGhvchWRk3PgnoLhZWJguo?=
 =?us-ascii?Q?cXw9mzN+Zma5hJ208bKZ8n9gfkLqc9sfZf9ssJ6TFPm03V7/xmPkHWN5kXPL?=
 =?us-ascii?Q?JrHrslxaGJOqVRVbhDoUPwi3OSzT+EPD/KXd1yU9L8r5JrXYmqSrcPoFD5Ak?=
 =?us-ascii?Q?/TG4aAcFwUmqcW3sz/tjd5vltF7LuEgWxTzUjkOv1Ae0Ul2ej5rXSG/U5Mx2?=
 =?us-ascii?Q?p6kE8FHAsJJaV24rkXRcu4nrbGc/N9tQoI+4NXMsRG7cfbvkyZR3/qmdCKe+?=
 =?us-ascii?Q?llwNgONSDO2Hc/MQMSDel9Bvz7JgcWDcaKnYfnlFP4s6tecaMKmr02VDia3c?=
 =?us-ascii?Q?/GvUiW3d40dgDDGI5GFl6AzT0hqJ1aq2vwnV4yyvVbx5kvVCZB7ZnYvfwrws?=
 =?us-ascii?Q?/PybkpuOf6N7mbpQeEJibfsL1y2LcKn9WMdel3Uqv880TiSgLqk2Is/6HhJv?=
 =?us-ascii?Q?kVUqprTxQPtYZDhmVoFB2JAmUJ3TvSh7kCzkzb+M7CuISnHDSqEhUXHrvUFO?=
 =?us-ascii?Q?FSpjoriELr6EqpwNsV5AiLHAQHmNVG+VNk1OwlKkjzbZatHIEfaGCreF8jvC?=
 =?us-ascii?Q?wu6mBcRv7NsK+wb8KLzcqp5wM7RrQ+JfTkNcekmEgxrnCIKa2lcYhlNKlh3o?=
 =?us-ascii?Q?Aiy+fauT1GECGShzL9xiLDQZaCnd1u/1BI/VEJ4BNYlG3lXY1bN/WK2l0vMN?=
 =?us-ascii?Q?sS8BQC+2c5TNaqYPY95BczfJ0yLxs522vMaZm0BZ9WiTzeTXYYQR+qPNZkr/?=
 =?us-ascii?Q?9g/o/H5FBmATRgq7W8dEUkHNSvIw+98pZRz2OEHRZua64g7qeS700+TtYhYU?=
 =?us-ascii?Q?CDfN/zuPZvs9uwHHak4wV2gvCdj1zYL9ulHYhm3IVoDa8yFkp50XXzNYamfj?=
 =?us-ascii?Q?B8GP7iX7JvEu8CUEXVwVtgk=3D?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: f6e9b233-bf32-446e-a025-08de3d7f3f8a
X-MS-Exchange-CrossTenant-AuthSource: TYWP286MB2697.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Dec 2025 15:16:27.0034
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MPD2p9BXBuxg30LzoEVEZ1lQ7+3UJTgfgR+u+RUuUkL90kTUFMVAx3fQJ3NfjPQKnblYFT13Ib2Z1LRXQBp7Vg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS9P286MB4633

No functional changes intended.

Signed-off-by: Koichiro Den <den@valinux.co.jp>
---
 drivers/ntb/ntb_transport.c          | 168 ++-------------------------
 drivers/ntb/ntb_transport_internal.h | 164 ++++++++++++++++++++++++++
 include/linux/ntb_transport.h        |   5 +
 3 files changed, 181 insertions(+), 156 deletions(-)
 create mode 100644 drivers/ntb/ntb_transport_internal.h

diff --git a/drivers/ntb/ntb_transport.c b/drivers/ntb/ntb_transport.c
index 78d0469edbcc..3969fa29a5b9 100644
--- a/drivers/ntb/ntb_transport.c
+++ b/drivers/ntb/ntb_transport.c
@@ -65,6 +65,8 @@
 #include "linux/ntb_transport.h"
 #include <linux/pci-epc.h>
 
+#include "ntb_transport_internal.h"
+
 #define NTB_TRANSPORT_VERSION	4
 #define NTB_TRANSPORT_VER	"4"
 #define NTB_TRANSPORT_NAME	"ntb_transport"
@@ -76,11 +78,11 @@ MODULE_VERSION(NTB_TRANSPORT_VER);
 MODULE_LICENSE("Dual BSD/GPL");
 MODULE_AUTHOR("Intel Corporation");
 
-static unsigned long max_mw_size;
+unsigned long max_mw_size;
 module_param(max_mw_size, ulong, 0644);
 MODULE_PARM_DESC(max_mw_size, "Limit size of large memory windows");
 
-static unsigned int transport_mtu = 0x10000;
+unsigned int transport_mtu = 0x10000;
 module_param(transport_mtu, uint, 0644);
 MODULE_PARM_DESC(transport_mtu, "Maximum size of NTB transport packets");
 
@@ -96,7 +98,7 @@ static bool use_dma;
 module_param(use_dma, bool, 0644);
 MODULE_PARM_DESC(use_dma, "Use DMA engine to perform large data copy");
 
-static bool use_msi;
+bool use_msi;
 #ifdef CONFIG_NTB_MSI
 module_param(use_msi, bool, 0644);
 MODULE_PARM_DESC(use_msi, "Use MSI interrupts instead of doorbells");
@@ -107,153 +109,12 @@ static struct dentry *nt_debugfs_dir;
 /* Only two-ports NTB devices are supported */
 #define PIDX		NTB_DEF_PEER_IDX
 
-struct ntb_queue_entry {
-	/* ntb_queue list reference */
-	struct list_head entry;
-	/* pointers to data to be transferred */
-	void *cb_data;
-	void *buf;
-	unsigned int len;
-	unsigned int flags;
-	int retries;
-	int errors;
-	unsigned int tx_index;
-	unsigned int rx_index;
-
-	struct ntb_transport_qp *qp;
-	union {
-		struct ntb_payload_header __iomem *tx_hdr;
-		struct ntb_payload_header *rx_hdr;
-	};
-};
-
-struct ntb_rx_info {
-	unsigned int entry;
-};
-
-struct ntb_transport_qp {
-	struct ntb_transport_ctx *transport;
-	struct ntb_dev *ndev;
-	void *cb_data;
-	struct dma_chan *tx_dma_chan;
-	struct dma_chan *rx_dma_chan;
-
-	bool client_ready;
-	bool link_is_up;
-	bool active;
-
-	u8 qp_num;	/* Only 64 QP's are allowed.  0-63 */
-	u64 qp_bit;
-
-	struct ntb_rx_info __iomem *rx_info;
-	struct ntb_rx_info *remote_rx_info;
-
-	void (*tx_handler)(struct ntb_transport_qp *qp, void *qp_data,
-			   void *data, int len);
-	struct list_head tx_free_q;
-	spinlock_t ntb_tx_free_q_lock;
-	void __iomem *tx_mw;
-	phys_addr_t tx_mw_phys;
-	size_t tx_mw_size;
-	dma_addr_t tx_mw_dma_addr;
-	unsigned int tx_index;
-	unsigned int tx_max_entry;
-	unsigned int tx_max_frame;
-
-	void (*rx_handler)(struct ntb_transport_qp *qp, void *qp_data,
-			   void *data, int len);
-	struct list_head rx_post_q;
-	struct list_head rx_pend_q;
-	struct list_head rx_free_q;
-	/* ntb_rx_q_lock: synchronize access to rx_XXXX_q */
-	spinlock_t ntb_rx_q_lock;
-	void *rx_buff;
-	unsigned int rx_index;
-	unsigned int rx_max_entry;
-	unsigned int rx_max_frame;
-	unsigned int rx_alloc_entry;
-	dma_cookie_t last_cookie;
-	struct tasklet_struct rxc_db_work;
-
-	void (*event_handler)(void *data, int status);
-	struct delayed_work link_work;
-	struct work_struct link_cleanup;
-
-	struct dentry *debugfs_dir;
-	struct dentry *debugfs_stats;
-
-	/* Stats */
-	u64 rx_bytes;
-	u64 rx_pkts;
-	u64 rx_ring_empty;
-	u64 rx_err_no_buf;
-	u64 rx_err_oflow;
-	u64 rx_err_ver;
-	u64 rx_memcpy;
-	u64 rx_async;
-	u64 tx_bytes;
-	u64 tx_pkts;
-	u64 tx_ring_full;
-	u64 tx_err_no_buf;
-	u64 tx_memcpy;
-	u64 tx_async;
-
-	bool use_msi;
-	int msi_irq;
-	struct ntb_msi_desc msi_desc;
-	struct ntb_msi_desc peer_msi_desc;
-};
-
-struct ntb_transport_mw {
-	phys_addr_t phys_addr;
-	resource_size_t phys_size;
-	void __iomem *vbase;
-	size_t xlat_size;
-	size_t buff_size;
-	size_t alloc_size;
-	void *alloc_addr;
-	void *virt_addr;
-	dma_addr_t dma_addr;
-};
-
 struct ntb_transport_client_dev {
 	struct list_head entry;
 	struct ntb_transport_ctx *nt;
 	struct device dev;
 };
 
-struct ntb_transport_ctx {
-	struct list_head entry;
-	struct list_head client_devs;
-
-	struct ntb_dev *ndev;
-
-	struct ntb_transport_mw *mw_vec;
-	struct ntb_transport_qp *qp_vec;
-	unsigned int mw_count;
-	unsigned int qp_count;
-	u64 qp_bitmap;
-	u64 qp_bitmap_free;
-
-	bool use_msi;
-	unsigned int msi_spad_offset;
-	u64 msi_db_mask;
-
-	bool link_is_up;
-	struct delayed_work link_work;
-	struct work_struct link_cleanup;
-
-	struct dentry *debugfs_node_dir;
-
-	/* Make sure workq of link event be executed serially */
-	struct mutex link_event_lock;
-};
-
-enum {
-	DESC_DONE_FLAG = BIT(0),
-	LINK_DOWN_FLAG = BIT(1),
-};
-
 struct ntb_payload_header {
 	unsigned int ver;
 	unsigned int len;
@@ -268,7 +129,7 @@ struct ntb_payload_header {
  * DMA capabilities and IOMMU configuration are taken from the
  * controller rather than the virtual NTB PCI function.
  */
-static struct device *get_dma_dev(struct ntb_dev *ndev)
+struct device *get_dma_dev(struct ntb_dev *ndev)
 {
 	struct device *dev = &ndev->pdev->dev;
 	struct pci_epc *epc;
@@ -295,7 +156,6 @@ enum {
 #define drv_client(__drv) \
 	container_of((__drv), struct ntb_transport_client, driver)
 
-#define QP_TO_MW(nt, qp)	((qp) % nt->mw_count)
 #define NTB_QP_DEF_NUM_ENTRIES	100
 #define NTB_LINK_DOWN_TIMEOUT	10
 
@@ -532,8 +392,7 @@ static int ntb_qp_debugfs_stats_show(struct seq_file *s, void *v)
 }
 DEFINE_SHOW_ATTRIBUTE(ntb_qp_debugfs_stats);
 
-static void ntb_list_add(spinlock_t *lock, struct list_head *entry,
-			 struct list_head *list)
+void ntb_list_add(spinlock_t *lock, struct list_head *entry, struct list_head *list)
 {
 	unsigned long flags;
 
@@ -542,8 +401,7 @@ static void ntb_list_add(spinlock_t *lock, struct list_head *entry,
 	spin_unlock_irqrestore(lock, flags);
 }
 
-static struct ntb_queue_entry *ntb_list_rm(spinlock_t *lock,
-					   struct list_head *list)
+struct ntb_queue_entry *ntb_list_rm(spinlock_t *lock, struct list_head *list)
 {
 	struct ntb_queue_entry *entry;
 	unsigned long flags;
@@ -562,9 +420,8 @@ static struct ntb_queue_entry *ntb_list_rm(spinlock_t *lock,
 	return entry;
 }
 
-static struct ntb_queue_entry *ntb_list_mv(spinlock_t *lock,
-					   struct list_head *list,
-					   struct list_head *to_list)
+struct ntb_queue_entry *ntb_list_mv(spinlock_t *lock, struct list_head *list,
+				    struct list_head *to_list)
 {
 	struct ntb_queue_entry *entry;
 	unsigned long flags;
@@ -982,7 +839,7 @@ static void ntb_qp_link_cleanup_work(struct work_struct *work)
 				      msecs_to_jiffies(NTB_LINK_DOWN_TIMEOUT));
 }
 
-static void ntb_qp_link_down(struct ntb_transport_qp *qp)
+void ntb_qp_link_down(struct ntb_transport_qp *qp)
 {
 	schedule_work(&qp->link_cleanup);
 }
@@ -1194,8 +1051,7 @@ static void ntb_qp_link_work(struct work_struct *work)
 				      msecs_to_jiffies(NTB_LINK_DOWN_TIMEOUT));
 }
 
-static int ntb_transport_init_queue(struct ntb_transport_ctx *nt,
-				    unsigned int qp_num)
+int ntb_transport_init_queue(struct ntb_transport_ctx *nt, unsigned int qp_num)
 {
 	struct ntb_transport_qp *qp;
 
diff --git a/drivers/ntb/ntb_transport_internal.h b/drivers/ntb/ntb_transport_internal.h
new file mode 100644
index 000000000000..79c7dbcf6f91
--- /dev/null
+++ b/drivers/ntb/ntb_transport_internal.h
@@ -0,0 +1,164 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+
+#ifndef _NTB_TRANSPORT_INTERNAL_H_
+#define _NTB_TRANSPORT_INTERNAL_H_
+
+#include <linux/ntb_transport.h>
+
+extern unsigned long max_mw_size;
+extern unsigned int transport_mtu;
+extern bool use_msi;
+
+#define QP_TO_MW(nt, qp)	((qp) % nt->mw_count)
+
+struct ntb_queue_entry {
+	/* ntb_queue list reference */
+	struct list_head entry;
+	/* pointers to data to be transferred */
+	void *cb_data;
+	void *buf;
+	unsigned int len;
+	unsigned int flags;
+	int retries;
+	int errors;
+	unsigned int tx_index;
+	unsigned int rx_index;
+
+	struct ntb_transport_qp *qp;
+	union {
+		struct ntb_payload_header __iomem *tx_hdr;
+		struct ntb_payload_header *rx_hdr;
+	};
+};
+
+struct ntb_rx_info {
+	unsigned int entry;
+};
+
+struct ntb_transport_qp {
+	struct ntb_transport_ctx *transport;
+	struct ntb_dev *ndev;
+	void *cb_data;
+	struct dma_chan *tx_dma_chan;
+	struct dma_chan *rx_dma_chan;
+
+	bool client_ready;
+	bool link_is_up;
+	bool active;
+
+	u8 qp_num;	/* Only 64 QP's are allowed.  0-63 */
+	u64 qp_bit;
+
+	struct ntb_rx_info __iomem *rx_info;
+	struct ntb_rx_info *remote_rx_info;
+
+	void (*tx_handler)(struct ntb_transport_qp *qp, void *qp_data,
+			   void *data, int len);
+	struct list_head tx_free_q;
+	spinlock_t ntb_tx_free_q_lock;
+	void __iomem *tx_mw;
+	phys_addr_t tx_mw_phys;
+	size_t tx_mw_size;
+	dma_addr_t tx_mw_dma_addr;
+	unsigned int tx_index;
+	unsigned int tx_max_entry;
+	unsigned int tx_max_frame;
+
+	void (*rx_handler)(struct ntb_transport_qp *qp, void *qp_data,
+			   void *data, int len);
+	struct list_head rx_post_q;
+	struct list_head rx_pend_q;
+	struct list_head rx_free_q;
+	/* ntb_rx_q_lock: synchronize access to rx_XXXX_q */
+	spinlock_t ntb_rx_q_lock;
+	void *rx_buff;
+	unsigned int rx_index;
+	unsigned int rx_max_entry;
+	unsigned int rx_max_frame;
+	unsigned int rx_alloc_entry;
+	dma_cookie_t last_cookie;
+	struct tasklet_struct rxc_db_work;
+
+	void (*event_handler)(void *data, int status);
+	struct delayed_work link_work;
+	struct work_struct link_cleanup;
+
+	struct dentry *debugfs_dir;
+	struct dentry *debugfs_stats;
+
+	/* Stats */
+	u64 rx_bytes;
+	u64 rx_pkts;
+	u64 rx_ring_empty;
+	u64 rx_err_no_buf;
+	u64 rx_err_oflow;
+	u64 rx_err_ver;
+	u64 rx_memcpy;
+	u64 rx_async;
+	u64 tx_bytes;
+	u64 tx_pkts;
+	u64 tx_ring_full;
+	u64 tx_err_no_buf;
+	u64 tx_memcpy;
+	u64 tx_async;
+
+	bool use_msi;
+	int msi_irq;
+	struct ntb_msi_desc msi_desc;
+	struct ntb_msi_desc peer_msi_desc;
+};
+
+struct ntb_transport_mw {
+	phys_addr_t phys_addr;
+	resource_size_t phys_size;
+	void __iomem *vbase;
+	size_t xlat_size;
+	size_t buff_size;
+	size_t alloc_size;
+	void *alloc_addr;
+	void *virt_addr;
+	dma_addr_t dma_addr;
+};
+
+struct ntb_transport_ctx {
+	struct list_head entry;
+	struct list_head client_devs;
+
+	struct ntb_dev *ndev;
+
+	struct ntb_transport_mw *mw_vec;
+	struct ntb_transport_qp *qp_vec;
+	unsigned int mw_count;
+	unsigned int qp_count;
+	u64 qp_bitmap;
+	u64 qp_bitmap_free;
+
+	bool use_msi;
+	unsigned int msi_spad_offset;
+	u64 msi_db_mask;
+
+	bool link_is_up;
+	struct delayed_work link_work;
+	struct work_struct link_cleanup;
+
+	struct dentry *debugfs_node_dir;
+
+	/* Make sure workq of link event be executed serially */
+	struct mutex link_event_lock;
+};
+
+enum {
+	DESC_DONE_FLAG = BIT(0),
+	LINK_DOWN_FLAG = BIT(1),
+};
+
+void ntb_list_add(spinlock_t *lock, struct list_head *entry, struct list_head *list);
+struct ntb_queue_entry *ntb_list_rm(spinlock_t *lock, struct list_head *list);
+struct ntb_queue_entry *ntb_list_mv(spinlock_t *lock, struct list_head *list,
+				    struct list_head *to_list);
+void ntb_qp_link_down(struct ntb_transport_qp *qp);
+int ntb_transport_init_queue(struct ntb_transport_ctx *nt,
+			     unsigned int qp_num);
+struct device *get_dma_dev(struct ntb_dev *ndev);
+
+#endif /* _NTB_TRANSPORT_INTERNAL_H_ */
diff --git a/include/linux/ntb_transport.h b/include/linux/ntb_transport.h
index 7243eb98a722..b128ced77b39 100644
--- a/include/linux/ntb_transport.h
+++ b/include/linux/ntb_transport.h
@@ -48,6 +48,9 @@
  * Jon Mason <jon.mason@intel.com>
  */
 
+#ifndef __LINUX_NTB_TRANSPORT_H
+#define __LINUX_NTB_TRANSPORT_H
+
 struct ntb_transport_qp;
 
 struct ntb_transport_client {
@@ -84,3 +87,5 @@ void ntb_transport_link_up(struct ntb_transport_qp *qp);
 void ntb_transport_link_down(struct ntb_transport_qp *qp);
 bool ntb_transport_link_query(struct ntb_transport_qp *qp);
 unsigned int ntb_transport_tx_free_entry(struct ntb_transport_qp *qp);
+
+#endif /* __LINUX_NTB_TRANSPORT_H */
-- 
2.51.0


