Return-Path: <dmaengine+bounces-7389-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BD3FC94214
	for <lists+dmaengine@lfdr.de>; Sat, 29 Nov 2025 17:05:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A4CE53A7231
	for <lists+dmaengine@lfdr.de>; Sat, 29 Nov 2025 16:04:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BB4330F930;
	Sat, 29 Nov 2025 16:04:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="QOVfEPtf"
X-Original-To: dmaengine@vger.kernel.org
Received: from TYVP286CU001.outbound.protection.outlook.com (mail-japaneastazon11011006.outbound.protection.outlook.com [52.101.125.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFE9D30ACF2;
	Sat, 29 Nov 2025 16:04:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.125.6
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764432269; cv=fail; b=UYsbCiF5Jb32oD+S+zvvRRUB1JRUgbDcUQYHVsQS4l/bYWN4fwMuZEEsF6NTU02KdDNlv9CdVj9CztgDNA87a66Ko3FSSLmqSyu7SNkGYhaHUutNaSYCY7RluPRQS0R8wD+zszTqFoklTIFAAuUdUmEBQbsSy23/RgPI45cU+VY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764432269; c=relaxed/simple;
	bh=AfSPc3yS9emtbnkNJoSAjd+6NNVAsQLDanUDh+E6FUQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ET7/dACPmUdl/Y/768RPZpqJ4sLMBxnYkVkSgv2jIldiKViirgxBEtx4GJFMvaH34VW1qcFhuEb93McrziTH5qWUfWmiqi42zusf2eWd2nJIEDLN/3qbPEOtDjFd0sOSSCQyZ+xgs3Sl6ZFMMAVua68iKRXTtcP95dOw4QRhww4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=QOVfEPtf; arc=fail smtp.client-ip=52.101.125.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WtOAa2tJZ0adhNAgkO0bLauEfcK9yTvt+4IholXYEtR41sPDYjWTSKIgruzruMXum6acQx7nu8TIbRV+085468M5sutt8RUjzMcdNTBQXT0FGwoxn7uakz27pPJDWyTmoRJIO4/MOojpHhZ91EuwzVbtDrrs0Zi5OQXAh97VzMuP68XFD+OwMmnsOZg6uVuEfjywrZOeqcpNCpG513jh0OI7+UJ+5zW3PTFP8yNU0SRjy4haogdwpxFPhT2zM8vbfC5ne3+1XFp/ItYz00GZn2Rf8vaENwjyFxSFNgzxP51/O+CfveyOVFUlF39a736dyYZrLkzuT9JApiyESER8sQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2gnenupYkY5PlWslXZOMojW4YoQk3SqrA0lesD6JlE0=;
 b=TKXlx70byKy2ByMARWXPWs+tR/CGEVN09SwN2lLlZB+Bn+hA9OKULIqcvpYbkGzeI3Oq1PjGQwdvFeR82Dgzz1jo2OcaVxl04VxkytdmKB7bokGBtT1ghbu2iRoPqMv4ygQwHwXNu0Ab/pKph5fIkJhtoYNHz8V6OAZHJzF59tr4svU25Ye1+1BcVUAWs5eqO8TGwpek4BsjsUrABvnlTzQOAkmaUDkCFNKnxlUT1H+z2KPbWb7JMyuYqWoutK6lhjiA3ffKXyuoHMG6urSBO+hEJC5kRf1xvU8SUG4p5Y7cx4N+y24fTOYEnjGe1t7zeeEDqpD8zGBMQkarEgnb0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2gnenupYkY5PlWslXZOMojW4YoQk3SqrA0lesD6JlE0=;
 b=QOVfEPtfjdLATOH1MMYPr3bnyvEDoDINtcSan7wJZeOhTdPPMld2zrPJh3H+bNtkFbW3cjuCfWGDBsy7zQKT0iuDeH+OqvSJYdQejs0EzgL3djYgMNeG/n+0W3DkIJeMjpUfw36jgyeTj+K7qUh0T2PdzyEsHaoVIo6HADDxvf8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TYWP286MB2697.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:24c::11)
 by TYCP286MB2050.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:15e::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.17; Sat, 29 Nov
 2025 16:04:22 +0000
Received: from TYWP286MB2697.JPNP286.PROD.OUTLOOK.COM
 ([fe80::fb7e:f4ed:a580:9d03]) by TYWP286MB2697.JPNP286.PROD.OUTLOOK.COM
 ([fe80::fb7e:f4ed:a580:9d03%5]) with mapi id 15.20.9366.012; Sat, 29 Nov 2025
 16:04:22 +0000
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
Subject: [RFC PATCH v2 04/27] PCI: endpoint: Add inbound mapping ops to EPC core
Date: Sun, 30 Nov 2025 01:03:42 +0900
Message-ID: <20251129160405.2568284-5-den@valinux.co.jp>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20251129160405.2568284-1-den@valinux.co.jp>
References: <20251129160405.2568284-1-den@valinux.co.jp>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCP286CA0072.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:31a::20) To TYWP286MB2697.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:24c::11)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYWP286MB2697:EE_|TYCP286MB2050:EE_
X-MS-Office365-Filtering-Correlation-Id: 78072db3-f3a8-429c-1429-08de2f60f5fb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|366016|1800799024|10070799003;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?KWxjxIs3gbZPGH3UuBWBPi+W8M/s2K15Q9NUUHt7Zwl9bhFLfbwlHIlzj/S8?=
 =?us-ascii?Q?cmp/PI+x9ZNYt8h3C4vy0TQwX39r6+CjtI1G8odec7GrX32M9HOdfDNzf2fh?=
 =?us-ascii?Q?YrQg5nS5ChAyueu/I+81s6JmvrihYPaLXFzqhdMd2ITKjKviL/CWUb/FGeKJ?=
 =?us-ascii?Q?vmM6g5llOh3Ig7fVrZVenjocxBbQmTSgWhgRYXvLsMILpeBbNF88WR5pZL5U?=
 =?us-ascii?Q?NVob8IwrMqrViP3Rwhb5+yhEeIX/FAPl0rHWDAvk76dTG5TE5qJ2plY1m0to?=
 =?us-ascii?Q?aM9A8udvCxoRZTvaLJ+eCMUHSqDjpYX8eKB3VNGJlxgdNyD+i2GS53FMY4hS?=
 =?us-ascii?Q?RR84t4GH47NQi46H6ErcUp2U/yFS6WbklwxMPFVrbLqcSlHOhoyPXxbXEF1u?=
 =?us-ascii?Q?N45J0x3p+YcdZKekla6wdX/eT4CfSZiE/eb8DkBUCmcu37bwuXD9qHAkinfj?=
 =?us-ascii?Q?X86//qH5J5UMImw4bHNfYfIupUY8CNhBBOPTcjE7i/NSDHw9K72uQrIkfXz7?=
 =?us-ascii?Q?osJvfZf8M4oknPFbd+w7x3i2hlaEJ4ea2/FS1dW/SZSqIP1MfCBLhjJYP0Z2?=
 =?us-ascii?Q?g3AmycQVU2Av9UFrRr8JaHfCuQ+7rqYv5BsGHdGayz6F2WZWEa4PdBfAdzPy?=
 =?us-ascii?Q?SguFDTVL/m2Mn277YA3AmJjpPc2h6GKz5CmMrj/OXLEYvVFYwft9iv2DicfZ?=
 =?us-ascii?Q?5SNvTOtPKv10oxYH+pji2ePXDybiSexALXHyYQl6eOJqSt1AGGuaNFiV9A1A?=
 =?us-ascii?Q?HR9b/526ZqQ8y716F2SNLuArgO/DkoH3i02cW8tkKrvnJB8dCOs4Ozo3wymA?=
 =?us-ascii?Q?3zuywmW3NY8TAtSdFH0V43l5SvhzDS7rUGM/M8KfMyBqn9i/Z3skBqVCHqa5?=
 =?us-ascii?Q?zr6R3mIll993KjrfJIzpedCu8OjBYw+4AJY2ZSSTtzIV1BP9tfMlUuZ/OTfk?=
 =?us-ascii?Q?3G8vCYneB+6LbN36RbOFvEADjfo3iuNWBwYDJCMeIh3odA1WbQ79syueFor7?=
 =?us-ascii?Q?IPm4NuDXYG0Eso+/hD6CAEGoqHY9KEVtbg3DtoQYVQeMMJZ8/ujqRV7DC4R2?=
 =?us-ascii?Q?Dzjaprp3yFRTB5Km2POs80aFGR8r1+uHuPCmviiSnzv7vyPCDpcGAxnFYZqE?=
 =?us-ascii?Q?MQXR7So8N4X0k0rHxFQDE/UmG8bRyoczNEHfwcNCIgoYK1qGwy7JL+yy0OzC?=
 =?us-ascii?Q?WdJFHDbVPEywgD8zNnwegjLeuyRxn6fnYzeL9vQvjjJ11Ax91cEOFUwiesJB?=
 =?us-ascii?Q?BDHxE5XqtnAnvzSSRtAG0u5n1gdH6pdzktVpW4YXCaWIInpeAoxlR2XVdfin?=
 =?us-ascii?Q?iFKQEMPKyZbrqC3g1guXoBrL08DSDdXU7YPDNtgOpY9yiGc9LAyL6ncjfOYX?=
 =?us-ascii?Q?vYhIx/5rRVrcdkw0XpRPW8dY9c0w2acZoXBj4a0BhY9Vu+e4Xnz331Yyr88J?=
 =?us-ascii?Q?lDxlzr7Qg/Up4w+K3/rOwdd4J19o9kYi?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYWP286MB2697.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(10070799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?hI0cKtsFmzW4oW/LV6BwllBaoIyy0Rp1PtYg/1PpAz56IUeLw2NPWlrhDli5?=
 =?us-ascii?Q?Lt76XoR6PS8Wh0BdZQprx1gkpDdIT6c4s4JaezZvQhBjUtv/g4FW3EJklXPe?=
 =?us-ascii?Q?TuBnjdqHqKP9YB1fvyUSl/xZU7Ym14ZsK0Db7gZq2Np1Vb1YKadkmwgJU9BD?=
 =?us-ascii?Q?qN8VGiJFwHNZTEwE8IltvbyGPbNYWtg3mV+WB62/mtsDD/T6gDrv9h1AB9ll?=
 =?us-ascii?Q?oBpwISY33UV4Rcmqw3sGKGlpnEDiZS6iPP4l2RBTbWC0rH7S2hJcAd8MN9A+?=
 =?us-ascii?Q?yr1omZD3GLyDe+IohGQy14/8j4iO7Qau+mtrKpjUAenV0ySU3GYmrYNk7Ebf?=
 =?us-ascii?Q?PynIZ7hzTwkCmA/bWP8inqdL/9DjbczB+Ht0IopnBrlj6nd+oL+d6OjyZYFE?=
 =?us-ascii?Q?ywyxtFZZ2+g4799rNb1Ixck2wEaC9B4hRRdQZlVcaZptOioOqDnmKLy+6HMh?=
 =?us-ascii?Q?HglPeYKELK1XHcNV4QNZ3O6BEz1EvVCsCzOVo8uhAdih8zaFs6bQZLp7eYAw?=
 =?us-ascii?Q?t6K3FiqA3fLkonIK3Y5jxh9hP6zN9ZNKFGjhGEpJYJLK7AV/Ba03M28BSZ/Z?=
 =?us-ascii?Q?rRQFsK/qenaX1TQEWfK/5xTimj4KE3+2adWldmU1kvdaH1xArRzjEK+nqi9w?=
 =?us-ascii?Q?LAfKc8qjhurEiPw5c0KvrRkD1s9pAi0TqnygxjChHAt/NsvuwmLnjrSwC1UE?=
 =?us-ascii?Q?yfk/XQRN1DeW1pxA3a2cxN7k/WkNP7SvdAXoV0Nf+t1GMklKzZJNTYgEflt7?=
 =?us-ascii?Q?NYFIFNn4looxf6vW/WFdNetqxVpHelKd12y6jLrTvA9whdWt1I2Z4PwDwoml?=
 =?us-ascii?Q?JPgu8kMZUQRtL56RaDTl2vj2k4xMp5QQMJw02Nk7cRjWbZMcXeRR/xNZycIp?=
 =?us-ascii?Q?Q8hh3Q1Xdbq3HOuvhrifbvwNcXYphVfbcEtFaHCY/rOLy/XSKb+4AvJpIjqn?=
 =?us-ascii?Q?m2in6eVpw1WYKEH/Yb3FwZAiyXizE0j0ly/rlfrDQXgYz2gA+717JKFm9b8m?=
 =?us-ascii?Q?xVha//5rQMuCZZi/aCQXqv6agsMXfCxZZr7uUUVvSLxOvw4d0T00sNsB10r/?=
 =?us-ascii?Q?PckxEG8oY7+9POCvuyytJ6zcnDQB8dcsaoUF1jPkVNRqrxJ6ohsAXuIc8jGb?=
 =?us-ascii?Q?IFpkAUHyf+4xLvm73Ma8DhneKb/lWlTS6lhVpTX7XLQPAZzBIblOpYN5aAys?=
 =?us-ascii?Q?YG1BaXByinyIlkwjXjn+NhLtZBdTvXYnLOLiE6O+e2UP2kDyQXshGb9s7kYd?=
 =?us-ascii?Q?PWqyvzYjzVpii2UhxoxiP3F29iy7txDCFut32bA8h/8p+4Qr4zbKkAu/ZkL3?=
 =?us-ascii?Q?Z7X4rRrBRhZWyULTXRFjHGPGhx7tpDrVZZz6BMG303yvK/XND1AXcbgAnCOU?=
 =?us-ascii?Q?c/T2hHiE5YUuD+zT5NzmG3hT1LAUhaLza79PTDAR9UJJL6RB/K2xOM+9v6EO?=
 =?us-ascii?Q?lx98wAcYbYkBBCeKd9bYIfgXIpBPlU87I9ErtSjCzY+JQYtCdBR4xOul+NiI?=
 =?us-ascii?Q?WAxzvTH3o9bjH3Cx4vGlYwUXTPm79x4IP/qsel8Tcz+r9KEo60raBbHIpZjj?=
 =?us-ascii?Q?9ZNgHsQLUV/vCeCXJIs9/ue7FcLUnbSIosP1IqAZp9yEdf1irSVawXQ44Tgz?=
 =?us-ascii?Q?qHrDHRf++yN9UvFCUG4eJDY=3D?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: 78072db3-f3a8-429c-1429-08de2f60f5fb
X-MS-Exchange-CrossTenant-AuthSource: TYWP286MB2697.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Nov 2025 16:04:22.4131
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zLcJvnsaxIz/srMoku7x11TtvY19Idd1jqgUlIyOV+mQW0kzEfSgET8IApzDbOrEVZo+HSmT/nzMELdCTMiqaw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCP286MB2050

Add new EPC ops map_inbound() and unmap_inbound() for mapping a subrange
of a BAR into CPU space. These will be implemented by controller drivers
such as DesignWare.

Signed-off-by: Koichiro Den <den@valinux.co.jp>
---
 drivers/pci/endpoint/pci-epc-core.c | 44 +++++++++++++++++++++++++++++
 include/linux/pci-epc.h             | 11 ++++++++
 2 files changed, 55 insertions(+)

diff --git a/drivers/pci/endpoint/pci-epc-core.c b/drivers/pci/endpoint/pci-epc-core.c
index ca7f19cc973a..825109e54ba9 100644
--- a/drivers/pci/endpoint/pci-epc-core.c
+++ b/drivers/pci/endpoint/pci-epc-core.c
@@ -444,6 +444,50 @@ int pci_epc_map_addr(struct pci_epc *epc, u8 func_no, u8 vfunc_no,
 }
 EXPORT_SYMBOL_GPL(pci_epc_map_addr);
 
+/**
+ * pci_epc_map_inbound() - map a BAR subrange to the local CPU address
+ * @epc: the EPC device on which BAR has to be configured
+ * @func_no: the physical endpoint function number in the EPC device
+ * @vfunc_no: the virtual endpoint function number in the physical function
+ * @epf_bar: the struct epf_bar that contains the BAR information
+ * @offset: byte offset from the BAR base selected by the host
+ *
+ * Invoke to configure the BAR of the endpoint device and map a subrange
+ * selected by @offset to a CPU address.
+ *
+ * Returns 0 on success, -EOPNOTSUPP if unsupported, or a negative errno.
+ */
+int pci_epc_map_inbound(struct pci_epc *epc, u8 func_no, u8 vfunc_no,
+			struct pci_epf_bar *epf_bar, u64 offset)
+{
+	if (!epc || !epc->ops || !epc->ops->map_inbound)
+		return -EOPNOTSUPP;
+
+	return epc->ops->map_inbound(epc, func_no, vfunc_no, epf_bar, offset);
+}
+EXPORT_SYMBOL_GPL(pci_epc_map_inbound);
+
+/**
+ * pci_epc_unmap_inbound() - unmap a previously mapped BAR subrange
+ * @epc: the EPC device on which the inbound mapping was programmed
+ * @func_no: the physical endpoint function number in the EPC device
+ * @vfunc_no: the virtual endpoint function number in the physical function
+ * @epf_bar: the struct epf_bar used when the mapping was created
+ * @offset: byte offset from the BAR base that was mapped
+ *
+ * Invoke to remove a BAR subrange mapping created by pci_epc_map_inbound().
+ * If the controller has no support, this call is a no-op.
+ */
+void pci_epc_unmap_inbound(struct pci_epc *epc, u8 func_no, u8 vfunc_no,
+			   struct pci_epf_bar *epf_bar, u64 offset)
+{
+	if (!epc || !epc->ops || !epc->ops->unmap_inbound)
+		return;
+
+	epc->ops->unmap_inbound(epc, func_no, vfunc_no, epf_bar, offset);
+}
+EXPORT_SYMBOL_GPL(pci_epc_unmap_inbound);
+
 /**
  * pci_epc_mem_map() - allocate and map a PCI address to a CPU address
  * @epc: the EPC device on which the CPU address is to be allocated and mapped
diff --git a/include/linux/pci-epc.h b/include/linux/pci-epc.h
index 4286bfdbfdfa..a5fb91cc2982 100644
--- a/include/linux/pci-epc.h
+++ b/include/linux/pci-epc.h
@@ -71,6 +71,8 @@ struct pci_epc_map {
  *		region
  * @map_addr: ops to map CPU address to PCI address
  * @unmap_addr: ops to unmap CPU address and PCI address
+ * @map_inbound: ops to map a subrange inside a BAR to CPU address.
+ * @unmap_inbound: ops to unmap a subrange inside a BAR and CPU address.
  * @set_msi: ops to set the requested number of MSI interrupts in the MSI
  *	     capability register
  * @get_msi: ops to get the number of MSI interrupts allocated by the RC from
@@ -99,6 +101,10 @@ struct pci_epc_ops {
 			    phys_addr_t addr, u64 pci_addr, size_t size);
 	void	(*unmap_addr)(struct pci_epc *epc, u8 func_no, u8 vfunc_no,
 			      phys_addr_t addr);
+	int	(*map_inbound)(struct pci_epc *epc, u8 func_no, u8 vfunc_no,
+			       struct pci_epf_bar *epf_bar, u64 offset);
+	void	(*unmap_inbound)(struct pci_epc *epc, u8 func_no, u8 vfunc_no,
+				 struct pci_epf_bar *epf_bar, u64 offset);
 	int	(*set_msi)(struct pci_epc *epc, u8 func_no, u8 vfunc_no,
 			   u8 nr_irqs);
 	int	(*get_msi)(struct pci_epc *epc, u8 func_no, u8 vfunc_no);
@@ -286,6 +292,11 @@ int pci_epc_map_addr(struct pci_epc *epc, u8 func_no, u8 vfunc_no,
 		     u64 pci_addr, size_t size);
 void pci_epc_unmap_addr(struct pci_epc *epc, u8 func_no, u8 vfunc_no,
 			phys_addr_t phys_addr);
+
+int pci_epc_map_inbound(struct pci_epc *epc, u8 func_no, u8 vfunc_no,
+			struct pci_epf_bar *epf_bar, u64 offset);
+void pci_epc_unmap_inbound(struct pci_epc *epc, u8 func_no, u8 vfunc_no,
+			   struct pci_epf_bar *epf_bar, u64 offset);
 int pci_epc_set_msi(struct pci_epc *epc, u8 func_no, u8 vfunc_no, u8 nr_irqs);
 int pci_epc_get_msi(struct pci_epc *epc, u8 func_no, u8 vfunc_no);
 int pci_epc_set_msix(struct pci_epc *epc, u8 func_no, u8 vfunc_no, u16 nr_irqs,
-- 
2.48.1


