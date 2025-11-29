Return-Path: <dmaengine+bounces-7403-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D2454C942E6
	for <lists+dmaengine@lfdr.de>; Sat, 29 Nov 2025 17:10:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9288F3ACFC8
	for <lists+dmaengine@lfdr.de>; Sat, 29 Nov 2025 16:07:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 905A8315D39;
	Sat, 29 Nov 2025 16:04:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="GIxLgv+2"
X-Original-To: dmaengine@vger.kernel.org
Received: from TY3P286CU002.outbound.protection.outlook.com (mail-japaneastazon11010018.outbound.protection.outlook.com [52.101.229.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B438314D11;
	Sat, 29 Nov 2025 16:04:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.229.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764432287; cv=fail; b=ixhcd4qz8yHNV1Q81WQDNj5DKfP+tRln3paQtMl34Rx13459DC/4wo16MmsPBXAd7cRIt2F0vWsGc8UTIx+6mAUrP9+7LzE31lST83L9YMgh8+WmqZvyV4Uv77Tancc+4fYu+1hkEjZNhrTT8xF5uEaEdGjfafJqu2ur2BsPNTM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764432287; c=relaxed/simple;
	bh=bvus/BBImr3OfC1fWlVTiXXWH/vUeMM8tbvZIkWb3dM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=sNpCFw0EXInbr8hFVeR91kOGRA8yNp12mXGVmbXvd4AgkEbh/Z0ZsBfe286Nuetk/RV1cME6GqMXQ6A+gIJlWPcZprnJxIiF7zLNeGgSjkXEGxuN5xB+YrYpEe8TI/nt2AKNdIRlmLBYsXXLx0mVIA4uXWEusOEEjrOinZFJwDg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=GIxLgv+2; arc=fail smtp.client-ip=52.101.229.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MUFMj4AeImEtD05qBcmhaF5TSm4y15Z2o/zflUi6EVXEJSRwBkGLA4BdIqZHn+Wwp7BSRucU70lpd18T/gtbGss/Pq72Z0goKxdIem4WiyHdV83WJgYrdWHGq0fbpLaiDHfPWMqtkEaULnzDP35iZ46i61fzL+DdgnEDhzOzbyoPqvkPfZAeD9YslQbrF5JESjCr5qK7YXepKz9bjVpV7GKBAJPQOxzf9YkZnzBim41DnlAsxv11kRT7w/H65ouH39AxHwS88NH7xhY3oWtwtpuLaAp2BOQSM4ZTlOCyyRn07Q49e6dRtFr+RTlt1bOpFeZhf0fwF+pHCzTD+vUHUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TtMo5KNeQujYRPlY8vNusKK6qwhUuIeAE5QtnFZ8CeE=;
 b=dpkpWl65RVKJFZe1mdqM8fzOhUHAizb+p32EEY6CHmV7ox+ZoviqgytXUdLCB+nsbSIgIC86Qz2CKG3l85KHBplkiWXKypWl83IFQIKwD+813axWlhtpHDb2hAB66Jb2CoZNZRK1j8TOMS7TGlX/Xwyx8ryVLzHIe7fytNZr2UiwHciAnWQaubA63Gp2tfxJGB36BmvP680dJZbpbN/l4hf9s8kXVccBgzwVgcCUlyKWn9KsKAtW/Ibr5mggzFs5cGyKHkEMyXNCP7gOWC8NGvFncovx8nWRKudka9msUWqB2OgIdGGWLW8OB9q7GK4SGRIvIC319B9CWkjYZVTBkQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TtMo5KNeQujYRPlY8vNusKK6qwhUuIeAE5QtnFZ8CeE=;
 b=GIxLgv+2OK2DncH12+G1GcghlfxpPwgTkEXfpg1/B3AQe5ZFjRoNjMdOYWRovyGpHhfLRxjw7sYqHQ4Js31+n4s5plDTYCjC7PDMOHsnRs+Sxu/G4GvPhKWc4zV7glpuvu1oTK+aYc8Re0sAo1p1y1s8TnXKb6cjfgKWwxQLejg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TYWP286MB2697.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:24c::11)
 by OS9P286MB4684.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:2fa::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.17; Sat, 29 Nov
 2025 16:04:38 +0000
Received: from TYWP286MB2697.JPNP286.PROD.OUTLOOK.COM
 ([fe80::fb7e:f4ed:a580:9d03]) by TYWP286MB2697.JPNP286.PROD.OUTLOOK.COM
 ([fe80::fb7e:f4ed:a580:9d03%5]) with mapi id 15.20.9366.012; Sat, 29 Nov 2025
 16:04:38 +0000
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
Subject: [RFC PATCH v2 19/27] PCI: dwc: ep: Cache MSI outbound iATU mapping
Date: Sun, 30 Nov 2025 01:03:57 +0900
Message-ID: <20251129160405.2568284-20-den@valinux.co.jp>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20251129160405.2568284-1-den@valinux.co.jp>
References: <20251129160405.2568284-1-den@valinux.co.jp>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCP286CA0098.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:2b4::19) To TYWP286MB2697.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:24c::11)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYWP286MB2697:EE_|OS9P286MB4684:EE_
X-MS-Office365-Filtering-Correlation-Id: 84139169-70ac-4086-e09a-08de2f60ff7a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|366016|10070799003|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?5KidNLWwLWqbNVENaGa4IMl9MX4Jg8Y8whOe8VoQa6VJtSCBzgKaOyEnaIfn?=
 =?us-ascii?Q?drEWpEfu0bdzX86jIa4tUNxkKXKrbJSf99GnReR2qGLa8e19xelxRv8m5nlw?=
 =?us-ascii?Q?1F1gEJKhwqfjuRfB8moNdLFwDAf+LKvhGIwrf3EOPay2UOXr7UtAlv0q2ylo?=
 =?us-ascii?Q?vjg+bPV3HheV2r/QfwOi83p5WJ0SirXDplevUB6auo7I4jkMB/DjZ/fXQyQO?=
 =?us-ascii?Q?fa17YimErsd9FIh2OVtKP8Hkk6VLzXcGgPaGbABnXgze7pcS4IZl0j+Euogm?=
 =?us-ascii?Q?hHqGgoAzUxEvc3e/I4jIXyFTA+ZAN09+oqojmE67WjW0hL/EA7pu7QDH5Q47?=
 =?us-ascii?Q?eM1YdV5I78uinxscPvPLVjjtGkyp6gr2bU7DjphWgT39xJdclJsYlMjhFVZe?=
 =?us-ascii?Q?scFAoiQ57/eLhVzaHcXxG7cLhVZ3eDI2qegejwIQV2+8vR0EglL+bQUPaEtD?=
 =?us-ascii?Q?+3cCNKnRXISjBiB5tsMviHpqnQAcqH/vzF2zk87osfmWXaqT2UEp+mxfzPu6?=
 =?us-ascii?Q?UrfajZLr4U63YPLoPc9ngC6s+4Yk+InERAivQSoyXISE3XFtj4filcNNN2Jj?=
 =?us-ascii?Q?F5JwaXc0GPl6A9BcJN4LdGDigEQiKOOxxxDUbCCCItiHxdmXJQrk3vCOCqg7?=
 =?us-ascii?Q?tRhuiV1/I/s3zw0VMnnjEKkMiRi06SXpvTA20K+OQeH7nl8ryedBjeKHWtDZ?=
 =?us-ascii?Q?YGEPr5X5LfuTV7p2PL+YmxJTNO4WDwBxDb4RrbcCA+djkVm9UCiUDrEOpkAw?=
 =?us-ascii?Q?m7LR9kWGlTw9ebKTBdKtpXt9ZkCdCDAcZiijaEhpBJ57vp16Ofq9rmm577nT?=
 =?us-ascii?Q?QqcU7XwWME92PEq+DDhq2j/HDDBP/DnAVUTPWK20+fiPcSKKAeGtVYA324oK?=
 =?us-ascii?Q?dbPoh4lh6LLLwje9736y2QReFPOUtbq6f+t0SBwbeSWw5Wuwlw3CG9Sr3I4N?=
 =?us-ascii?Q?lgWjLEPA8ZzaENTDLg2YwIq63OydnRgQEn/Lg6tK5cLVxAEGYFtPMdrQ7Xzl?=
 =?us-ascii?Q?ZDlgYcm6YNeADgWOylul/k2URFJPEFFpXsW0gdJLObVnBtPwIxOVdMEP6WD+?=
 =?us-ascii?Q?AV7MwLzz7/DnXzHn/AEzP7SLsPythFW77tjn9Ai03YOlVH+HahtVeanPyWdl?=
 =?us-ascii?Q?OeWpkCg86fmkqgDQJXRS1qw4mnxqeSVhhZrTvRit+VneSMoLl5rux5uDfQT/?=
 =?us-ascii?Q?Xba0Jh+NHLcdv0Vbe9YKnPpVO9A8WvTl0WB//O6DdZ6tXeLTVSD2koOL7ju/?=
 =?us-ascii?Q?UEaxLpvnwMpbgcpcniMD33xnvUx/XXBH4HUEg7xZ7zzu1an7ZtZIrjgz+Jml?=
 =?us-ascii?Q?cgLbX3bgwnG2zsP9f4xZH412fqWiRzP5RaZFDY1n0z3sYYx37nr+2kjMHafa?=
 =?us-ascii?Q?DlkBi9FfgPAAx1RnHohxBlbnRivDUcDe17yMgASrttvv7z0wwoQaW57Ft6ch?=
 =?us-ascii?Q?a8/tb3ZTuB4CaLmIkHNJ9m6Q1FAm2W3k?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYWP286MB2697.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(10070799003)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?BPCPdm56q6rtpf7xq/mg8yq9kxHaX5vDTWcaKPT5w+khV9hz/vJArEDXEDoE?=
 =?us-ascii?Q?FvC4A/okQ7BtZgBViWhsuDedAW0h6z+AdIdqMk8WiGePpR+kJu57EGvzstdd?=
 =?us-ascii?Q?aE8zx0EY7VurV7uLhSoAxnkl1wXd5L5LeCxdSL/KMlTbC7yDBRs/9gAGXbv3?=
 =?us-ascii?Q?hf+IVTfaggO/6bTq1rovv+UxOHjVRYMO2W3IBHSPpOImZ3xvvquxiZwGeSeO?=
 =?us-ascii?Q?SxrsTuIrf0CvCxJtFCOf0yWp+daBAoLB/98dHIly792w3VUGsw22juJ8oUxR?=
 =?us-ascii?Q?FAPPEFGVeEkmOzzguzX/xkir6xPIbtY0K6g3FSFP30lDT3TyclAh7pEJsAbf?=
 =?us-ascii?Q?EBqCKXKDtnY8z0RiNYBtSM9Lo9AL1hNqIrmHVQjdsJuDTb0vVD6XAgbz/yiA?=
 =?us-ascii?Q?ymOILxa0qtt2RCMRKKHczcm6Sd6RHNgwB/4+BtQ3vhVgAmidtp8QVHglmXlC?=
 =?us-ascii?Q?5g6vm/i7Xi6UDRvBYsQfaLpCDWrp2lmcHw1snKKnE2F7Nz7J6i4IpL4LO5j1?=
 =?us-ascii?Q?afAd2oRuNnRIKuZZY17legslILuPPjZsvbVcnfYKccEa05uwIMtx1kt3RaKj?=
 =?us-ascii?Q?qwfn1iWZ9F3tcbkqB3GTYoTdggrbFs12oJR/HYrv2lkBKnD1xsTgXrD7Gacd?=
 =?us-ascii?Q?L9d68iJVJoBt29QXl+ZoWQuiIPdgPkeXt5Bd7RoFSiuDfUvjLsDgEhXSRreg?=
 =?us-ascii?Q?a46fkSSupF2rgxcTv/lE2ytyPMpvCJnaa691ubn+qVhBWMXb9qwQdxCpYBKP?=
 =?us-ascii?Q?+wWjUc4it2woB6w98KiV+nI0wgqz4z2gtOpnIEGFTvmHSBc6PomaPsvQpuEO?=
 =?us-ascii?Q?EAosekrjBRMi/JrZA1al6a7A3wqmCg+CJem+B5/t1+qXY6hN8zTBa67A3Ywq?=
 =?us-ascii?Q?PSoW1HseY+e025DAB03uQfkmoqLSxLEio9Trf7gsGNenIF5wjXFy5iP6v5/6?=
 =?us-ascii?Q?0UjKX6MYG6Bo3w6w6c7ibH0wQ26QZf3qNdOAuZC18UEPQsEgNI3Ma7bdZiQ/?=
 =?us-ascii?Q?lLKyrKW+U0c2T73xtJRuTnaT04mlLyxBlCzA0a/0f5xMarrzGoYu4yg6Xi2c?=
 =?us-ascii?Q?3/UBMeM40a7ZyVuOwoKGt4EKZrQXkp6+ThKc0EmiNwgmCNu3foMm2GTz6Ada?=
 =?us-ascii?Q?RsL7WUru065cNZPVIy/SCyyDZ9K4Ff5ZVociLs8O38ZbyaC+iIQeTYZYpO+d?=
 =?us-ascii?Q?QyjlU6/NvLVn1RmniQegbZm2btSWZkK45Mw/cglsoa4NgU4S+qpUf7Ux9+jx?=
 =?us-ascii?Q?gdqpcWNRRlFVKzurtRrVQyy7FGMdptr37/P2C/vzu78bsN/S/wV505uqbbKi?=
 =?us-ascii?Q?Q9+fgbXLwVfXEoGiGLCS/nFT9mMypbrk8IMc7ggOebmVTxvR3/6DoVxgmIiD?=
 =?us-ascii?Q?oecTo4cc7GJ0XpjMHm2IlpRqftPj4CWGaiOA8G+PwbRZzQ7hkn4MlTUnv//m?=
 =?us-ascii?Q?EazGeE4KrJrriPEkaW3EM9Mr1aWeBzwSpRH6r5e4lJOtaoI8WKbEM3j1n9o8?=
 =?us-ascii?Q?pGqik2XLVSxc6cPruipxS4qc4zX+om9O4lZoFfA4oJjaC9XD0bv5/rPECfcv?=
 =?us-ascii?Q?SrG8WF5K7Mnl0TcqkKnaj1LXAgY9iUMKkyya6umTZLo/f6PJpqzxmqHcf8p9?=
 =?us-ascii?Q?+16Ddd5z5UMw3dMQLPttpLQ=3D?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: 84139169-70ac-4086-e09a-08de2f60ff7a
X-MS-Exchange-CrossTenant-AuthSource: TYWP286MB2697.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Nov 2025 16:04:38.3688
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: g7VuM4PVxCV7S5TSZ073DxqK2EVLHF+VL2vL6eNCsXVZK8sfIfg9nDYhH+z3vRqTSLBI/QjrwTzYQqqcInQRuQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS9P286MB4684

dw_pcie_ep_raise_msi_irq() currently programs an outbound iATU window
for the MSI target address on every interrupt and tears it down again
via dw_pcie_ep_unmap_addr().

On systems that heavily use the AXI bridge interface (for example when
the integrated eDMA engine is active), this means the outbound iATU
registers are updated while traffic is in flight. The DesignWare
endpoint spec warns that updating iATU registers in this situation is
not supported, and the behavior is undefined.

Under high MSI and eDMA load this pattern results in occasional bogus
outbound transactions and IOMMU faults such as:

  ipmmu-vmsa eed40000.iommu: Unhandled fault: status 0x00001502 iova 0xfe000000

followed by the system becoming unresponsive. This is the actual output
observed on Renesas R-Car S4, with its ipmmu_hc used with PCIe ch0.

There is no need to reprogram the iATU region used for MSI on every
interrupt. The host-provided MSI address is stable while MSI is enabled,
and the endpoint driver already dedicates a scratch buffer for MSI
generation.

Cache the aligned MSI address and map size, program the outbound iATU
once, and keep the window enabled. Subsequent interrupts only perform a
write to the MSI scratch buffer, avoiding dynamic iATU reprogramming in
the hot path and fixing the lockups seen under load.

Signed-off-by: Koichiro Den <den@valinux.co.jp>
---
 .../pci/controller/dwc/pcie-designware-ep.c   | 48 ++++++++++++++++---
 drivers/pci/controller/dwc/pcie-designware.h  |  5 ++
 2 files changed, 47 insertions(+), 6 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-designware-ep.c b/drivers/pci/controller/dwc/pcie-designware-ep.c
index 3780a9bd6f79..ef8ded34d9ab 100644
--- a/drivers/pci/controller/dwc/pcie-designware-ep.c
+++ b/drivers/pci/controller/dwc/pcie-designware-ep.c
@@ -778,6 +778,16 @@ static void dw_pcie_ep_stop(struct pci_epc *epc)
 	struct dw_pcie_ep *ep = epc_get_drvdata(epc);
 	struct dw_pcie *pci = to_dw_pcie_from_ep(ep);
 
+	/*
+	 * Tear down the dedicated outbound window used for MSI
+	 * generation. This avoids leaking an iATU window across
+	 * endpoint stop/start cycles.
+	 */
+	if (ep->msi_iatu_mapped) {
+		dw_pcie_ep_unmap_addr(epc, 0, 0, ep->msi_mem_phys);
+		ep->msi_iatu_mapped = false;
+	}
+
 	dw_pcie_stop_link(pci);
 }
 
@@ -881,14 +891,37 @@ int dw_pcie_ep_raise_msi_irq(struct dw_pcie_ep *ep, u8 func_no,
 	msg_addr = ((u64)msg_addr_upper) << 32 | msg_addr_lower;
 
 	msg_addr = dw_pcie_ep_align_addr(epc, msg_addr, &map_size, &offset);
-	ret = dw_pcie_ep_map_addr(epc, func_no, 0, ep->msi_mem_phys, msg_addr,
-				  map_size);
-	if (ret)
-		return ret;
 
-	writel(msg_data | (interrupt_num - 1), ep->msi_mem + offset);
+	/*
+	 * Program the outbound iATU once and keep it enabled.
+	 *
+	 * The spec warns that updating iATU registers while there are
+	 * operations in flight on the AXI bridge interface is not
+	 * supported, so we avoid reprogramming the region on every MSI,
+	 * specifically unmapping immediately after writel().
+	 */
+	if (!ep->msi_iatu_mapped) {
+		ret = dw_pcie_ep_map_addr(epc, func_no, 0,
+					  ep->msi_mem_phys, msg_addr,
+					  map_size);
+		if (ret)
+			return ret;
 
-	dw_pcie_ep_unmap_addr(epc, func_no, 0, ep->msi_mem_phys);
+		ep->msi_iatu_mapped = true;
+		ep->msi_msg_addr = msg_addr;
+		ep->msi_map_size = map_size;
+	} else if (WARN_ON_ONCE(ep->msi_msg_addr != msg_addr ||
+				ep->msi_map_size != map_size)) {
+		/*
+		 * The host changed the MSI target address or the required
+		 * mapping size. Reprogramming the iATU at runtime is unsafe
+		 * on this controller, so bail out instead of trying to update
+		 * the existing region.
+		 */
+		return -EINVAL;
+	}
+
+	writel(msg_data | (interrupt_num - 1), ep->msi_mem + offset);
 
 	return 0;
 }
@@ -1268,6 +1301,9 @@ int dw_pcie_ep_init(struct dw_pcie_ep *ep)
 	INIT_LIST_HEAD(&ep->func_list);
 	INIT_LIST_HEAD(&ep->ib_map_list);
 	spin_lock_init(&ep->ib_map_lock);
+	ep->msi_iatu_mapped = false;
+	ep->msi_msg_addr = 0;
+	ep->msi_map_size = 0;
 
 	epc = devm_pci_epc_create(dev, &epc_ops);
 	if (IS_ERR(epc)) {
diff --git a/drivers/pci/controller/dwc/pcie-designware.h b/drivers/pci/controller/dwc/pcie-designware.h
index 269a9fe0501f..1770a2318557 100644
--- a/drivers/pci/controller/dwc/pcie-designware.h
+++ b/drivers/pci/controller/dwc/pcie-designware.h
@@ -481,6 +481,11 @@ struct dw_pcie_ep {
 	void __iomem		*msi_mem;
 	phys_addr_t		msi_mem_phys;
 	struct pci_epf_bar	*epf_bar[PCI_STD_NUM_BARS];
+
+	/* MSI outbound iATU state */
+	bool			msi_iatu_mapped;
+	u64			msi_msg_addr;
+	size_t			msi_map_size;
 };
 
 struct dw_pcie_ops {
-- 
2.48.1


