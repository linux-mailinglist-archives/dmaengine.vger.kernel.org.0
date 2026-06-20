Return-Path: <dmaengine+bounces-11656-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id FwipDonHNmocEwcAu9opvQ
	(envelope-from <dmaengine+bounces-11656-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Sat, 20 Jun 2026 19:02:01 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C4EA96A9463
	for <lists+dmaengine@lfdr.de>; Sat, 20 Jun 2026 19:02:00 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=valinux.co.jp header.s=selector1 header.b=hzShbPmu;
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-11656-lists+dmaengine=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="dmaengine+bounces-11656-lists+dmaengine=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=valinux.co.jp;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id EE9A1301C128
	for <lists+dmaengine@lfdr.de>; Sat, 20 Jun 2026 17:01:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E958E274652;
	Sat, 20 Jun 2026 17:01:09 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from TY3P286CU002.outbound.protection.outlook.com (mail-japaneastazon11020101.outbound.protection.outlook.com [52.101.229.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B949A26ED3A;
	Sat, 20 Jun 2026 17:01:07 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781974869; cv=fail; b=uLGI//ButolmMrhzBOoVt1AS4RAqEAR77EX8YF2zljSIyJ5nYsIhFxcA83mQCU2eNdk7sra5je6gEEMzKk3V6R4cNgsKjikXialu0yi/S9pB8fNX8kaXvEfQ/Fx+cvG6JS0kLeRi5zADsdXHIxkjlf0fbFjNUn1iVEi5ys0bbIE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781974869; c=relaxed/simple;
	bh=4/VM+mHhdt5/ixiR3B8iOUoRY2hXXganbIVXWjzzLyg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=uIndn5rk6S00NGjASE1sNkTbid/WhDGJALP8bO4zQHccVPAkH5xE03NbUghFwhXtjia/cU3RYtLQdtCXTfOGLKfLZ7jAAhZfl02D6EjwElu6ZotfpQCBeS4TYqdDX5e0WrjeXzuJxTcodEAZW12lOWjZthaYbVLCV9uhGylWUwc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=hzShbPmu; arc=fail smtp.client-ip=52.101.229.101
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BMYiD2BFFibAMlmrIY1BhTeL66nDIikzpFOHx/mAMAj4gOzUjdxhnC6WVu2L7Xir10PYpd4EMMa3O14IRvFYEE+Z+g30Wck3DlO6ZZ6ugjIaR1yMJFh/8U0WcoBXQwqVDuG2fOJgZaV2x6KNjO2ojF/fufPyhD9Yq/MC5sKG+6yAtTCvnnDzCl02IXru4M3kXAITv6PDAExAcprZRPEFZnb1XwpRhLP+IHiTU6tkVtTt7fs89rWcZRNT4ysmwPGA/vciJczwlldajRo5tbW1pcpUSkRv+NXlkIQaFg+5fSZ3V7sL/49BmjL2vivqkRFFiTTRbPYvqWI2QoHxdNO6mg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eJ39piU8Pm5wWgyS8N/H5xdkMud00Y2RCaLfrf8doJ8=;
 b=qQpYlTR9HbWgnNsemSdtTJtUKzO3A20C6PlvoB05A9sCfWn8PhUFEnqidysJrN0V9RtTdUiWN4uKmeQSQzepEenyUBDu0eE2Pq30wbbp8Im8Nb+vtScl+3RU/RF2PEHcxMkcJWskkrdHVgSFwoKvwAmw5guePATkimKKN2dqFbGOkAH/BbG4RCPtvGsfv0bhnFQCMdUl46Xkh2aZ39rH1yKJw3HAy0weEiArbLN4cZ4LFLViS6jqKt3nQuCR3O1SXXF1rlfnfxZzCdlJuu3yUTc80Il+es1FlIVUBw8gwHY56M9b0heGZcJdE3kENvcJReB3qnCl3hZOXWH+CPUdwQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eJ39piU8Pm5wWgyS8N/H5xdkMud00Y2RCaLfrf8doJ8=;
 b=hzShbPmuMGZe2GY4b/UN7PwubSM8ypViTNJso6Je0ExdumbEAGuNWTlP0zP1WZbeLEKv90IUzt/0LbIjj6VHSFj+NCs48yuPcC6SVtveNfr+kWASKS9mv7LrrW7rGrAJ2UqxkdbJSrkUz0cPZD/PwpaSrMwkyIr46NSjC7Qb3Zo=
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:38f::10)
 by TY3P286MB2673.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:254::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.13; Sat, 20 Jun
 2026 17:00:59 +0000
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32]) by TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32%5]) with mapi id 15.21.0139.009; Sat, 20 Jun 2026
 17:00:59 +0000
From: Koichiro Den <den@valinux.co.jp>
To: Vinod Koul <vkoul@kernel.org>,
	Frank Li <Frank.Li@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
	Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
	dmaengine@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 08/13] dmaengine: dw-edma-pcie: Rename vsec_data to dma_data
Date: Sun, 21 Jun 2026 02:00:35 +0900
Message-ID: <20260620170040.3756043-9-den@valinux.co.jp>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260620170040.3756043-1-den@valinux.co.jp>
References: <20260620170040.3756043-1-den@valinux.co.jp>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCP286CA0160.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:383::7) To TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:38f::10)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY7P286MB7722:EE_|TY3P286MB2673:EE_
X-MS-Office365-Filtering-Correlation-Id: 5d7cb113-bbeb-4719-6294-08deceed80bf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|23010399003|366016|10070799003|3023799007|56012099006|6133799003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	iOJnDRF5DOmYW9dr68b98gpWSRMtk/tkuMRAyUAfRN5wIddITNNGKQ5g2zaLSoRUfQZ0TUe2HKriNi33y0WrevORLOPH4pZlAvtFofvzspW+W0K220tuLurOiFFb+HYntwwVeOzbifJzxURJmkTXq/r8T9WiWuQP5GW0gg5eGfYodsLffiNypYFmsQ6qZVj/JFBOxsK5Y/6Xts3V2ImRxOsdK51N+4c+3MDGnEOaq/+clcfbqE8sNybP25B5s2oXeG9Wx+oE0MtyJvjVEiBp3jkgoqHNy7QSvjlLX77aKFnK4snpJ46g32MPtnmgqnxKvlxIOrcHY9SrKJMYaaH/8WQWOywYRmjYtmcNZDs6i4W0H/pOR8+pjKL9/5VDtaHNIXSGT9IC5UoqdbdaFLNTEv3KN2ywtY7dIJ3cMUU/FjOgcNx48tIB5EvKFbAgK93Qb6LQevICq5J2B94fCCXoS7J4lWf6pnf4Guzjb78F+WfQTkY9XGcXtM9wS/sjqnDd+vMPbnh9FEt/L2p0YkRZn6/kDbC0qkhgIkIxJhdkMhFibuMoWj/koQRi9qpTwU9erHiH/EbJHEmUFFEP/3s5yx4ChapS2waAvVvxPfUORsXtMhkZGtsl0DfTOnqs3y2n7S94jjXe/IYbvROV85NoKmo9Kxn7S+h7mHsPPwruao4=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(23010399003)(366016)(10070799003)(3023799007)(56012099006)(6133799003)(18002099003)(22082099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?2Lumj2c0o6JqmZna+xbomHNWlu9cqlR8jfy06H/QuRyzWb5tApGlj2jkKI+Z?=
 =?us-ascii?Q?igy897f+VFpdgUVy99Km2Qy2/mHvLryxxb+4QYp21nfKxB0+TRHam3/hURyh?=
 =?us-ascii?Q?aXpMelEVuDB+nxH8DsQdh2Xpb/LtzIEMIU7JuBOw1+q0Z1pfd4FSHrJwXP3Z?=
 =?us-ascii?Q?Js44V6XU4PLj7Ns5oBp4T6FIRBrJj6FN/i+iE/K8WpLMaafmDWJ0IJoouS2o?=
 =?us-ascii?Q?NNYdbiDSrbCOKS9zqjZh0dqxUjANo+w/8pfSLTTuSueZfeSf3HVwnURnkaSo?=
 =?us-ascii?Q?ioQ5AYcDX06jV+JH3LUJ2QyfcZ4nplAo6t1OqMYM37LZ6ZKVxTr0qK7zSz+Y?=
 =?us-ascii?Q?XnzQwy8qKu4gobJlKXcHnkCPXpyuB5qtM0/XJDI27E6/adcnwH/EXPIwPeNu?=
 =?us-ascii?Q?MXt4lV20IpejqkPAFa2iYI8209i3wGXRDwU9BioUO6gwkufWvRGEt2ueuxAJ?=
 =?us-ascii?Q?7sK0ia402ZO7FyTQE0HS3Yrc/6cBub7nb0m86HyA0/erVLqia8YGFmhMP8Gy?=
 =?us-ascii?Q?mojAhxzecASOmYBoA+SJcHIVWiqmtekuFDwmx2RPR1ots25AdvB2MDHMW+a/?=
 =?us-ascii?Q?2TISKLjk0Y4An2wiF+wLvBJMliTKmKYKQjbmnsNLBfPQSGf18WKKxutiQZiP?=
 =?us-ascii?Q?VxoUTyws2h/hZEHzEq/ssu0Wwd87NRonggFa49jujHogBYHQsN9zeFL1ZCFa?=
 =?us-ascii?Q?GUWNffEGy6OGnc5dtP9+CntXl8iEKnoHWUjLiYeXovvCDksYxU1nh7DdB1QP?=
 =?us-ascii?Q?Uzb7N10J/ok5O9BK/wO4mxdB9OxuSqxA3qZGVJ/0DPbgS6k4YXnm2QRzIY5j?=
 =?us-ascii?Q?Xu3uiiRW0zRUCuFPgcKfdnqp2EmJ0ztm1YPzPU4HszbuYmH2c5293xBO5UE2?=
 =?us-ascii?Q?u8dwwOxDFYKQ46rorYlfzvQbTD4t7UbRWbp2hCmM0EqNTMMyVkUW9ihXjCZ1?=
 =?us-ascii?Q?yK3d9cMSa678JkA8kMLWnvwVB+YYsw88H7RjKZzDDmtf+ai0k5Qx8AP2wDe1?=
 =?us-ascii?Q?GuGk69rBD8W+DLY+F/VsIoxnIWtqdIHSpkiui10Q6GmnK6CD//Pn29jP3S5Q?=
 =?us-ascii?Q?rmbF71jB/Gz/M2c3LGNp2KuFGa4tc0aJ84KeNmp7zGb54aCw1XjT1l6b24eh?=
 =?us-ascii?Q?3FPoVSXgQ/Z8iusrvztYqHjtFe+4ZWVxpWJvvOsFc73PbCjWo++EJb+QbywN?=
 =?us-ascii?Q?ZD5CZm+lnEnALh/j84ixiXgC8DtZjghdYfxhLVqC5zJpRaUvubobPsHNdCRW?=
 =?us-ascii?Q?tlMvMqkPHBUKRN+dpYUYoqGSC6OxZhqP2wJn+b2OYssqV9EbZeOUY3guPBAB?=
 =?us-ascii?Q?QHjIP3y4l50TolPr3AhbpXZRohlnWkLr9Y7QRXkIjzOcLOn2+6yPtnRObn4B?=
 =?us-ascii?Q?oDVaYOBpUz/kUDBjyn1UA0TKZqzO0xol+S70tthh89k9VW/fv107s58zf9Ed?=
 =?us-ascii?Q?wKODACk6LpKYEuahzHmYM+TYcZIiv9BDO1wQ3eHi0ubjuGq2XpKbHC9cq97C?=
 =?us-ascii?Q?ehwlRrkD7jRrK0Mv70Lz5XRWeDv88RT+ZimOEzoaXGPURrTdbo7M6LbFK2lS?=
 =?us-ascii?Q?kdFtZLXDeOmB80sBr6zFwypIgQqs1vqa/3h8tPVNrqddul2otKhCi4hpbv5P?=
 =?us-ascii?Q?hg+wNvB5KfMjkRmHPjd1dL0kwOVLNTQ08/o8ksp9sHEmlcBuZwslkG+gjf8F?=
 =?us-ascii?Q?tNxD/c28vs+/SnrFQ3tanj511LvohdsH6QE1AUMm2x1QpoEGxEzCnP2yrpeJ?=
 =?us-ascii?Q?DRVg7oJCz4TOzAJCnIxtxi3btwKjwSi/shSIkP2LY5DviqqPVnRP?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: 5d7cb113-bbeb-4719-6294-08deceed80bf
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jun 2026 17:00:59.6257
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5N5pcr4PK2zpj1FTvRYwF+le+52NY+ZoF2WeH2N1R5xDLtBBoj93KSw70G0cPxQPNXPE5DZ6DNcciGxb7ZBICg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY3P286MB2673
X-Rspamd-Action: no action
X-Spamd-Result: default: False [1.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[valinux.co.jp,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[valinux.co.jp:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-11656-lists,dmaengine=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:vkoul@kernel.org,m:Frank.Li@kernel.org,m:mani@kernel.org,m:marek.vasut+renesas@mailbox.org,m:yoshihiro.shimoda.uh@renesas.com,m:dmaengine@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:marek.vasut@mailbox.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[den@valinux.co.jp,dmaengine@vger.kernel.org];
	DKIM_TRACE(0.00)[valinux.co.jp:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[den@valinux.co.jp,dmaengine@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[7];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[dmaengine,renesas];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,valinux.co.jp:dkim,valinux.co.jp:email,valinux.co.jp:mid,valinux.co.jp:from_mime,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: C4EA96A9463

dw_edma_pcie_probe() now obtains DMA layout data through device-specific
capability callbacks, not only from PCIe Vendor-Specific Extended
Capabilities. Rename the local data copy from vsec_data to dma_data
before adding endpoint DMA BAR metadata discovery, which does not rely
on VSEC.

No functional change intended.

Reviewed-by: Frank Li <Frank.Li@nxp.com>
Signed-off-by: Koichiro Den <den@valinux.co.jp>
---
Changes in v3:
  - Keep dma_data allocation before pcim_enable_device() (Frank).

 drivers/dma/dw-edma/dw-edma-pcie.c | 74 +++++++++++++++---------------
 1 file changed, 36 insertions(+), 38 deletions(-)

diff --git a/drivers/dma/dw-edma/dw-edma-pcie.c b/drivers/dma/dw-edma/dw-edma-pcie.c
index c08a77c0e508..5249324ad6bf 100644
--- a/drivers/dma/dw-edma/dw-edma-pcie.c
+++ b/drivers/dma/dw-edma/dw-edma-pcie.c
@@ -390,9 +390,9 @@ static int dw_edma_pcie_probe(struct pci_dev *pdev,
 	if (!pdata)
 		return -ENODEV;
 
-	struct dw_edma_pcie_data *vsec_data __free(kfree) =
-		kmalloc_obj(*vsec_data);
-	if (!vsec_data)
+	struct dw_edma_pcie_data *dma_data __free(kfree) =
+		kmemdup(pdata, sizeof(*dma_data), GFP_KERNEL);
+	if (!dma_data)
 		return -ENOMEM;
 
 	/* Enable PCI device */
@@ -402,25 +402,23 @@ static int dw_edma_pcie_probe(struct pci_dev *pdev,
 		return err;
 	}
 
-	memcpy(vsec_data, pdata, sizeof(struct dw_edma_pcie_data));
-
 	/* Let device-specific discovery override the static template data. */
 	if (!match->parse_caps)
 		return -EINVAL;
 
-	err = match->parse_caps(pdev, vsec_data);
+	err = match->parse_caps(pdev, dma_data);
 	if (err)
 		return err;
 
 	/* Mapping PCI BAR regions */
-	mask = BIT(vsec_data->rg.bar);
-	for (i = 0; i < vsec_data->wr_ch_cnt; i++) {
-		mask |= BIT(vsec_data->ll_wr[i].bar);
-		mask |= BIT(vsec_data->dt_wr[i].bar);
+	mask = BIT(dma_data->rg.bar);
+	for (i = 0; i < dma_data->wr_ch_cnt; i++) {
+		mask |= BIT(dma_data->ll_wr[i].bar);
+		mask |= BIT(dma_data->dt_wr[i].bar);
 	}
-	for (i = 0; i < vsec_data->rd_ch_cnt; i++) {
-		mask |= BIT(vsec_data->ll_rd[i].bar);
-		mask |= BIT(vsec_data->dt_rd[i].bar);
+	for (i = 0; i < dma_data->rd_ch_cnt; i++) {
+		mask |= BIT(dma_data->ll_rd[i].bar);
+		mask |= BIT(dma_data->dt_rd[i].bar);
 	}
 	err = pcim_iomap_regions(pdev, mask, pci_name(pdev));
 	if (err) {
@@ -443,7 +441,7 @@ static int dw_edma_pcie_probe(struct pci_dev *pdev,
 		return -ENOMEM;
 
 	/* IRQs allocation */
-	nr_irqs = pci_alloc_irq_vectors(pdev, 1, vsec_data->irqs,
+	nr_irqs = pci_alloc_irq_vectors(pdev, 1, dma_data->irqs,
 					PCI_IRQ_MSI | PCI_IRQ_MSIX);
 	if (nr_irqs < 1) {
 		pci_err(pdev, "fail to alloc IRQ vector (number of IRQs=%u)\n",
@@ -454,24 +452,24 @@ static int dw_edma_pcie_probe(struct pci_dev *pdev,
 	/* Data structure initialization */
 	chip->dev = dev;
 
-	chip->mf = vsec_data->mf;
+	chip->mf = dma_data->mf;
 	chip->irq_mode = DW_EDMA_CH_IRQ_REMOTE;
 	chip->nr_irqs = nr_irqs;
 	chip->ops = &dw_edma_pcie_plat_ops;
-	chip->cfg_non_ll = vsec_data->cfg_non_ll;
+	chip->cfg_non_ll = dma_data->cfg_non_ll;
 
-	chip->ll_wr_cnt = vsec_data->wr_ch_cnt;
-	chip->ll_rd_cnt = vsec_data->rd_ch_cnt;
+	chip->ll_wr_cnt = dma_data->wr_ch_cnt;
+	chip->ll_rd_cnt = dma_data->rd_ch_cnt;
 
-	chip->reg_base = pcim_iomap_table(pdev)[vsec_data->rg.bar];
+	chip->reg_base = pcim_iomap_table(pdev)[dma_data->rg.bar];
 	if (!chip->reg_base)
 		return -ENOMEM;
 
-	for (i = 0; i < chip->ll_wr_cnt && !vsec_data->cfg_non_ll; i++) {
+	for (i = 0; i < chip->ll_wr_cnt && !dma_data->cfg_non_ll; i++) {
 		struct dw_edma_region *ll_region = &chip->ll_region_wr[i];
 		struct dw_edma_region *dt_region = &chip->dt_region_wr[i];
-		struct dw_edma_block *ll_block = &vsec_data->ll_wr[i];
-		struct dw_edma_block *dt_block = &vsec_data->dt_wr[i];
+		struct dw_edma_block *ll_block = &dma_data->ll_wr[i];
+		struct dw_edma_block *dt_block = &dma_data->dt_wr[i];
 
 		ll_region->vaddr.io = pcim_iomap_table(pdev)[ll_block->bar];
 		if (!ll_region->vaddr.io)
@@ -479,7 +477,7 @@ static int dw_edma_pcie_probe(struct pci_dev *pdev,
 
 		ll_region->vaddr.io += ll_block->off;
 		ll_region->paddr = dw_edma_get_phys_addr(pdev, match,
-							 vsec_data, ll_block->bar);
+							 dma_data, ll_block->bar);
 		ll_region->paddr += ll_block->off;
 		ll_region->sz = ll_block->sz;
 
@@ -489,16 +487,16 @@ static int dw_edma_pcie_probe(struct pci_dev *pdev,
 
 		dt_region->vaddr.io += dt_block->off;
 		dt_region->paddr = dw_edma_get_phys_addr(pdev, match,
-							 vsec_data, dt_block->bar);
+							 dma_data, dt_block->bar);
 		dt_region->paddr += dt_block->off;
 		dt_region->sz = dt_block->sz;
 	}
 
-	for (i = 0; i < chip->ll_rd_cnt && !vsec_data->cfg_non_ll; i++) {
+	for (i = 0; i < chip->ll_rd_cnt && !dma_data->cfg_non_ll; i++) {
 		struct dw_edma_region *ll_region = &chip->ll_region_rd[i];
 		struct dw_edma_region *dt_region = &chip->dt_region_rd[i];
-		struct dw_edma_block *ll_block = &vsec_data->ll_rd[i];
-		struct dw_edma_block *dt_block = &vsec_data->dt_rd[i];
+		struct dw_edma_block *ll_block = &dma_data->ll_rd[i];
+		struct dw_edma_block *dt_block = &dma_data->dt_rd[i];
 
 		ll_region->vaddr.io = pcim_iomap_table(pdev)[ll_block->bar];
 		if (!ll_region->vaddr.io)
@@ -506,7 +504,7 @@ static int dw_edma_pcie_probe(struct pci_dev *pdev,
 
 		ll_region->vaddr.io += ll_block->off;
 		ll_region->paddr = dw_edma_get_phys_addr(pdev, match,
-							 vsec_data, ll_block->bar);
+							 dma_data, ll_block->bar);
 		ll_region->paddr += ll_block->off;
 		ll_region->sz = ll_block->sz;
 
@@ -516,7 +514,7 @@ static int dw_edma_pcie_probe(struct pci_dev *pdev,
 
 		dt_region->vaddr.io += dt_block->off;
 		dt_region->paddr = dw_edma_get_phys_addr(pdev, match,
-							 vsec_data, dt_block->bar);
+							 dma_data, dt_block->bar);
 		dt_region->paddr += dt_block->off;
 		dt_region->sz = dt_block->sz;
 	}
@@ -534,31 +532,31 @@ static int dw_edma_pcie_probe(struct pci_dev *pdev,
 		pci_dbg(pdev, "Version:\tUnknown (0x%x)\n", chip->mf);
 
 	pci_dbg(pdev, "Registers:\tBAR=%u, off=0x%.8lx, sz=0x%zx bytes, addr(v=%p)\n",
-		vsec_data->rg.bar, vsec_data->rg.off, vsec_data->rg.sz,
+		dma_data->rg.bar, dma_data->rg.off, dma_data->rg.sz,
 		chip->reg_base);
 
 
 	for (i = 0; i < chip->ll_wr_cnt; i++) {
 		pci_dbg(pdev, "L. List:\tWRITE CH%.2u, BAR=%u, off=0x%.8lx, sz=0x%zx bytes, addr(v=%p, p=%pa)\n",
-			i, vsec_data->ll_wr[i].bar,
-			vsec_data->ll_wr[i].off, chip->ll_region_wr[i].sz,
+			i, dma_data->ll_wr[i].bar,
+			dma_data->ll_wr[i].off, chip->ll_region_wr[i].sz,
 			chip->ll_region_wr[i].vaddr.io, &chip->ll_region_wr[i].paddr);
 
 		pci_dbg(pdev, "Data:\tWRITE CH%.2u, BAR=%u, off=0x%.8lx, sz=0x%zx bytes, addr(v=%p, p=%pa)\n",
-			i, vsec_data->dt_wr[i].bar,
-			vsec_data->dt_wr[i].off, chip->dt_region_wr[i].sz,
+			i, dma_data->dt_wr[i].bar,
+			dma_data->dt_wr[i].off, chip->dt_region_wr[i].sz,
 			chip->dt_region_wr[i].vaddr.io, &chip->dt_region_wr[i].paddr);
 	}
 
 	for (i = 0; i < chip->ll_rd_cnt; i++) {
 		pci_dbg(pdev, "L. List:\tREAD CH%.2u, BAR=%u, off=0x%.8lx, sz=0x%zx bytes, addr(v=%p, p=%pa)\n",
-			i, vsec_data->ll_rd[i].bar,
-			vsec_data->ll_rd[i].off, chip->ll_region_rd[i].sz,
+			i, dma_data->ll_rd[i].bar,
+			dma_data->ll_rd[i].off, chip->ll_region_rd[i].sz,
 			chip->ll_region_rd[i].vaddr.io, &chip->ll_region_rd[i].paddr);
 
 		pci_dbg(pdev, "Data:\tREAD CH%.2u, BAR=%u, off=0x%.8lx, sz=0x%zx bytes, addr(v=%p, p=%pa)\n",
-			i, vsec_data->dt_rd[i].bar,
-			vsec_data->dt_rd[i].off, chip->dt_region_rd[i].sz,
+			i, dma_data->dt_rd[i].bar,
+			dma_data->dt_rd[i].off, chip->dt_region_rd[i].sz,
 			chip->dt_region_rd[i].vaddr.io, &chip->dt_region_rd[i].paddr);
 	}
 
-- 
2.51.0


