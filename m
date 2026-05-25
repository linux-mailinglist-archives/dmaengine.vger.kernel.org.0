Return-Path: <dmaengine+bounces-10811-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mOX4BkLrE2qoHQcAu9opvQ
	(envelope-from <dmaengine+bounces-10811-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Mon, 25 May 2026 08:25:06 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id B0B915C65E6
	for <lists+dmaengine@lfdr.de>; Mon, 25 May 2026 08:25:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 1D19C3009F45
	for <lists+dmaengine@lfdr.de>; Mon, 25 May 2026 06:24:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97A683A3834;
	Mon, 25 May 2026 06:24:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="fWhMqAmO"
X-Original-To: dmaengine@vger.kernel.org
Received: from TYVP286CU001.outbound.protection.outlook.com (mail-japaneastazon11021139.outbound.protection.outlook.com [52.101.125.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9ACF39E171;
	Mon, 25 May 2026 06:24:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.125.139
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779690282; cv=fail; b=c/4Fu3izArzNAie6Aek9dG4cllMhNS/TlxkWP8Y/8XIpFGvqfZOWaH29f0CNsWyl2p+sFjnyJyFP2EHP62rsK8f3xpOwUW5+92eWSxbSSvzw5Bb2k2bve0v3IwfqRo2/CBgSeSOQ0AWqySobHjqHA3xIT/JBUtOziYQt1Do58NQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779690282; c=relaxed/simple;
	bh=PYT9d4FUJCKzVIb5US5Y/CXxgtaxcSPnziTIKEiEvTY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=S5GtCPqT3h5pdHvjUXRuXD94Qm3bHDZq+8zSTmSZehEpHLGhARLWyWfee2bQKKA9NVNvpoV/twQa2jBhja0erTNQ1nS61gKVyZKKmxKFyxTAck6VG//TtGDE4Fb6uw0Pj8sZbv+cdsdz8kreg0hZd1w7uq4czcAGwkuJtlEd9xc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=fWhMqAmO; arc=fail smtp.client-ip=52.101.125.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=W5BQC7dZ+exRhEjhv4JVEhhBuEc+lPEw9HoXXVyos2VudVy2lAjfHMy1cegWZCAnDoBAKGH8s6zZezt41goS3pnU3t4JwVDy6QFiA5mt/GAsRuFwwhEx6Tp3y2goWRMpuQztthCglXZNoFpcLJlOtguCNYlQtpSLGfjAw7p8cpTISHesJG8ZYKS8RR7yLopDaFzUQcmv1e3/jX+GlpLaOqmdcgt+9Rt3azz32BMFzu1QuJ8VWa/0IiCAtinIz3Eb4s1p3VlD5wr52Xmo580h4597mm+t65vjZGeIVX+N0XCzHoUuwVhPsPkKHtJksHqBTZ0hR+TQMaiLDRjhoGu88A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Yq5gshzXgKo0AWF8OcKMp2dfP46dM1LZRy2CBLjubOA=;
 b=SObQZ3iXf8axGxA8/CyPevDMGuiSEJvZ0gin5qvBKJdMdryvUUkzTAj50nlzocjjIh4v+vIGkcxZybfXZMYYobkLxMz/lO34CwOyhM80tTjun102TEqXhlqLFUncn53pAvyq0vY0BOFK8AXuYRhQgCauysuTopA3InE3znYoJvV5mHJb+XnKjS0ZmI3o5CUjclQLEaLGWV3MDwM2Xe4SfWN5EzdOe9odUPrQn6aBecNzpqFhvPuMGVqol831N9OM/zMs7aPBygbWf7Fw3uKRxI+YPtbgnTc8fDmyd0Xp39YmUSi/m44drGuykfijd7OiArdo+6GwGTF0kcKXrdKZWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Yq5gshzXgKo0AWF8OcKMp2dfP46dM1LZRy2CBLjubOA=;
 b=fWhMqAmO8PSIPb+zCHcZwzeDex8ahxKreW78AclqmXkT8g+fPabaZph1n5D/VkBtfVY6gS12Rgial2dBWtl6VvJTU3eE62mUG4CHdoz5wWRl1LM94pbMgExcOyhml6IKucWRG8+kIvMZFPl0on3t3eTy97WbnW+J8GiqDgoNgrY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:38f::10)
 by OS7P286MB7796.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:441::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.19; Mon, 25 May
 2026 06:24:37 +0000
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32]) by TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32%5]) with mapi id 15.21.0048.016; Mon, 25 May 2026
 06:24:37 +0000
From: Koichiro Den <den@valinux.co.jp>
To: Vinod Koul <vkoul@kernel.org>,
	Frank Li <Frank.Li@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
	Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
	dmaengine@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 05/12] dmaengine: dw-edma-pcie: Add capability match data
Date: Mon, 25 May 2026 15:24:13 +0900
Message-ID: <20260525062420.3315904-6-den@valinux.co.jp>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260525062420.3315904-1-den@valinux.co.jp>
References: <20260525062420.3315904-1-den@valinux.co.jp>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCP286CA0147.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:31b::10) To TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:38f::10)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY7P286MB7722:EE_|OS7P286MB7796:EE_
X-MS-Office365-Filtering-Correlation-Id: 3507db32-c583-4c37-15d0-08deba264bba
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|10070799003|376014|366016|22082099003|56012099003|18002099003|3023799007;
X-Microsoft-Antispam-Message-Info:
	VAiyBHBOV4dbGWXUo5xgpTPYmyuXoVHw5bMkVfwnIycyXUZN2vPFTpPWiIRsVymFdjgfIYNJQUkLde+kVF1vTh776IbJxCTtKV00xAPoxUOsBlA3QZ6RStNjdzJAYN9reo6MqefxwdDj85ZCUsy9Qhaa9dUzwGE5CxZE9svxzC1AN6m8Z0psLjXmh4Vi0XenRgixvjS41bqh5Zn1Yy9daw9rdrV+TKLPMfc818VoAHsNdxrAU79afJKwAzU/QGBAzOOg9UDIKVclrZyNR0fZnvHaVhVdmhvewQCSq00Ipxu1kK6jojX06mEmh0AFQGmG7gCOqAEPG/peWutwYeEbJQ8dBAxW1u7nzg/Mdm9TrQmkDOs/51YRtlbn5ibvHsuNO+NSWeR0r1kpopRhR3p6AfjGCOBtze0d9pw+oex6VDf9zngZa8vfOE9ZpuNYVdODdqoQa3hoyWXaLrgRSnSzk3xFJ4t3J0qjwxSChPk4MgxeCqBrax8OhqJhDrzFdZQaC4s8dlPqYfJ9CGrcHPrL0qR6AYoKdOJqGKnIA8A5OoAyIkhyHzGhdNzYeJD8B1CjG0YppEdljxGklRrD0ODh53iTRRON81ygnAShGocsE4C2jBzuEKOxNxSAk4bVu+PD4JrKd315FsVF3eCBuwb4wbdRvC3LDOkGOcsEGvkd+ueENo99fB54jTabdAwN+iTy
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(10070799003)(376014)(366016)(22082099003)(56012099003)(18002099003)(3023799007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?zp416oZa3TLNpjKnN3NgDul/wNGosoxnWCgFLxsG/gIWwD2w+JtlD9rFv93w?=
 =?us-ascii?Q?FxsAoCGd9hzgzXoRn4uvjpJZSlf4yX6GGNSiogZcpV5idbuI/BvuFUK13OEn?=
 =?us-ascii?Q?gEqulpddGNOSwPNZUIwJUmwT6EC+l2ktXV42HmvISY8lCbzefssGfXJgwUB5?=
 =?us-ascii?Q?wzNz2a8hrUiOgCTt/6Lrdvdqe3zVxQcKTs+CYt2oFubtKOmiY4p9oPYTMOrn?=
 =?us-ascii?Q?UIbqW87qih9Py3mkhqtcZisZY9EW//uV/aKWL/aUH8ZePqI2h1or9IVVMxtD?=
 =?us-ascii?Q?9AmR1en4ixJX/RS6WvkD2jMvnpzZaG8ZO0oQ0wSupiw6PM9IziDpO18sNbVY?=
 =?us-ascii?Q?IOZUM0+NygNkrvbn9b6Xs5ESQ4lCQDWwLjPRSly9SnxnySYGXZQJBWK/lY1F?=
 =?us-ascii?Q?GMSgivuwjuTL0t0K4dkHTvOyocoNTfH2DzgTejSMulzUngPUktUXZPVtDTsT?=
 =?us-ascii?Q?iLBt8PbVBkvEDb3pk+T3ckZZ02kcc62IltxvSZE8KwE2lv+8z0Rp8YiOeBKv?=
 =?us-ascii?Q?DWqt3WgkhvFTVVcdoqnDLSl8tFgNPwx0gC0axjYf4EAq2n2rzCmorSrSB5eT?=
 =?us-ascii?Q?CzeA1OmGzneCyJVCXxicKEW36A0e2lDIyDvXvxCdel45cUkQd49ctrQxpMOm?=
 =?us-ascii?Q?02TQAIiUvBgMSgC+5P7sXibUPFqSBS8kT/fyU9wfJAUY8ojwUwb2/oQIXLhJ?=
 =?us-ascii?Q?bZaZ+2ZLQRaym8RYAqqER2MGbuaMr+jj2nOB+U1oeHgfUJucPw+DWzM1Yog1?=
 =?us-ascii?Q?pY3P6IHqpNTygZU/4dvnKJFYfaPxxAo9Id69h3/VTE5LFW8qPdfACeU4fNDS?=
 =?us-ascii?Q?Ghod47X+mmqq/xUu077mB6g4IftKQYere2u1ENPoZvrH4b+3e9hQw4ofys4a?=
 =?us-ascii?Q?Qc6sZfKopWkTXHIqdiD4nTYuc8wT2+Yl7etu2WpFRn6FZ+a5ibt74e3mnuox?=
 =?us-ascii?Q?yEOM5vGFHkZy+gvMzzE8zvHKRcoYfxMW2XxkWmBhEmyhNcGftS7ZBa36VG2F?=
 =?us-ascii?Q?NIy7y20OYOAsdBmL2+FyCpztFg/HgJXtmwUOpknSTm4fCh4Yzq+dwfFZDm3f?=
 =?us-ascii?Q?xLGFKFstk5BaQDDkD5fij4gEfE5aWbZSPe/oFj3sRQmKW4p2pw/ZUZagkWPH?=
 =?us-ascii?Q?Dkvv6qnEPjBAHaS9F7MVdDQxfJaoFcVSXnb08X/a7rOQ9ZOnuMUfu8EBUWap?=
 =?us-ascii?Q?bAd6l6/HAv9Ozwo96vY4QNnKAlQmVmgY7wNsM5vbX9ydSGD7ie5ztrpLWrDi?=
 =?us-ascii?Q?Jz7qZVGYWlWJDL4K+CivN9HVpDrry5+FYp5U+0uNvHBe0BDi3yizo1kmtCm6?=
 =?us-ascii?Q?0lY1OR4qWf9rKUe+LJIPsIAVhd0UZKtdDEj0qJ8Yn54dq5caRtCDSkwKaxf2?=
 =?us-ascii?Q?Sl6BgZAEdt94GedNGwQDNzDKqiYtgq2KwFpsMSiLv4Ulrgs8MG1YVpl5339h?=
 =?us-ascii?Q?LHal64CZgChgd9Cnh0jIg9HgcSWKMNrqtnP+lBkCL7+E+sB7RnAhhyGNsT8K?=
 =?us-ascii?Q?184W/BhxTpEgWMsOEu9Rc17YTEbsCJStW6Sx+Brj3emzc0xY6yqkuKweyVCg?=
 =?us-ascii?Q?Ew1EZgimU77iibDWEFv4ZYifxEZ3u5Y5yNUAenWH2YAYQjJrhtpGf4qkBseK?=
 =?us-ascii?Q?RjJMXQ1MTDz2te4iRhqJntZPQ1nI1uZ8AS/D5ArWhm182sGNIQPHefF370SP?=
 =?us-ascii?Q?ODeyB0FRuPi2iUN/UWfHDGoa7/KOkv07Arfa+tAdUu3gfmDSlmpOhEkv4edX?=
 =?us-ascii?Q?DbXNvs3X1Tl9sYTfMgPQS2l3kBimgv8rRHyBqckJKenSJQddwXoi?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: 3507db32-c583-4c37-15d0-08deba264bba
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 May 2026 06:24:37.6108
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Mkau258GayQgUyvyFhiQeq+doWiAg5ZxgfzrLiZ1u5rFdehOJd3VYq33t1uOYKpqr8uIocdks5KvuEecdDl3iQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS7P286MB7796
X-Spamd-Result: default: False [1.34 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[valinux.co.jp,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[valinux.co.jp:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-10811-lists,dmaengine=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[valinux.co.jp:+];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[den@valinux.co.jp,dmaengine@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[7];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[dmaengine,renesas];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nxp.com:email,valinux.co.jp:email,valinux.co.jp:mid,valinux.co.jp:dkim,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Queue-Id: B0B915C65E6
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Move device-specific capability parsing behind per-device match data.

The existing probe path mixes two decisions: which static template a PCI
ID uses, and which device-specific capability parser adjusts that
template. Split those decisions so device-specific discovery can be
added through match data instead of adding more vendor checks to
dw_edma_pcie_probe().

No functional change is intended for the existing Synopsys EDDA and
AMD/Xilinx MDB matches. They still copy the same static template data and
run the same capability parsing logic before BAR mapping. The MDB entry
also keeps using endpoint memory physical addresses for descriptor
windows through a new match-data flag.

Suggested-by: Frank Li <Frank.Li@nxp.com>
Signed-off-by: Koichiro Den <den@valinux.co.jp>
---
Changes in v2:
  - Keep non-LL mode in dw_edma_pcie_data instead of a separate
    parse_caps() output parameter.
  - While at here, use a named .driver_data initializer for the Xilinx MDB ID
    entry, per Frank's suggestion.

 drivers/dma/dw-edma/dw-edma-pcie.c | 127 +++++++++++++++++++----------
 1 file changed, 85 insertions(+), 42 deletions(-)

diff --git a/drivers/dma/dw-edma/dw-edma-pcie.c b/drivers/dma/dw-edma/dw-edma-pcie.c
index e92ff5dc6f67..5a6f5af358d0 100644
--- a/drivers/dma/dw-edma/dw-edma-pcie.c
+++ b/drivers/dma/dw-edma/dw-edma-pcie.c
@@ -75,6 +75,19 @@ struct dw_edma_pcie_data {
 	bool				cfg_non_ll;
 };
 
+struct dw_edma_pcie_match_data {
+	const struct dw_edma_pcie_data *data;
+	/*
+	 * Mandatory callback. It may leave @pdata unchanged when the static
+	 * template already describes the device.
+	 */
+	int (*parse_caps)(struct pci_dev *pdev,
+			  struct dw_edma_pcie_data *pdata);
+	unsigned long flags;
+};
+
+#define DW_EDMA_PCIE_F_DEVMEM_PHYS_OFF	BIT(0)
+
 static const struct dw_edma_pcie_data snps_edda_data = {
 	/* eDMA registers location */
 	.rg.bar				= BAR_0,
@@ -296,19 +309,61 @@ static void dw_edma_pcie_get_xilinx_dma_data(struct pci_dev *pdev,
 	pdata->devmem_phys_off = off;
 }
 
+static int
+dw_edma_pcie_parse_synopsys_caps(struct pci_dev *pdev,
+				 struct dw_edma_pcie_data *pdata)
+{
+	dw_edma_pcie_get_synopsys_dma_data(pdev, pdata);
+
+	return 0;
+}
+
+static int
+dw_edma_pcie_parse_xilinx_caps(struct pci_dev *pdev,
+			       struct dw_edma_pcie_data *pdata)
+{
+	dw_edma_pcie_get_xilinx_dma_data(pdev, pdata);
+
+	/*
+	 * There is no valid address found for the LL memory space on the
+	 * device side. In the absence of LL base address use the non-LL mode or
+	 * simple mode supported by the HDMA IP.
+	 */
+	if (pdata->devmem_phys_off == DW_PCIE_XILINX_MDB_INVALID_ADDR) {
+		pdata->cfg_non_ll = true;
+		return 0;
+	}
+
+	/*
+	 * Configure the channel LL and data blocks if number of channels
+	 * enabled in VSEC capability are more than the channels configured in
+	 * xilinx_mdb_data.
+	 */
+	dw_edma_set_chan_region_offset(pdata, BAR_2, 0,
+				       DW_PCIE_XILINX_MDB_LL_OFF_GAP,
+				       DW_PCIE_XILINX_MDB_LL_SIZE,
+				       DW_PCIE_XILINX_MDB_DT_OFF_GAP,
+				       DW_PCIE_XILINX_MDB_DT_SIZE);
+
+	return 0;
+}
+
 static u64 dw_edma_get_phys_addr(struct pci_dev *pdev,
+				 const struct dw_edma_pcie_match_data *match,
 				 struct dw_edma_pcie_data *pdata,
 				 enum pci_barno bar)
 {
-	if (pdev->vendor == PCI_VENDOR_ID_XILINX)
+	if (match->flags & DW_EDMA_PCIE_F_DEVMEM_PHYS_OFF)
 		return pdata->devmem_phys_off;
+
 	return pci_bus_address(pdev, bar);
 }
 
 static int dw_edma_pcie_probe(struct pci_dev *pdev,
 			      const struct pci_device_id *pid)
 {
-	struct dw_edma_pcie_data *pdata = (void *)pid->driver_data;
+	const struct dw_edma_pcie_match_data *match = (void *)pid->driver_data;
+	const struct dw_edma_pcie_data *pdata = match->data;
 	struct device *dev = &pdev->dev;
 	struct dw_edma_chip *chip;
 	int err, nr_irqs;
@@ -328,36 +383,13 @@ static int dw_edma_pcie_probe(struct pci_dev *pdev,
 
 	memcpy(vsec_data, pdata, sizeof(struct dw_edma_pcie_data));
 
-	/*
-	 * Tries to find if exists a PCIe Vendor-Specific Extended Capability
-	 * for the DMA, if one exists, then reconfigures it.
-	 */
-	dw_edma_pcie_get_synopsys_dma_data(pdev, vsec_data);
-
-	if (pdev->vendor == PCI_VENDOR_ID_XILINX) {
-		dw_edma_pcie_get_xilinx_dma_data(pdev, vsec_data);
-
-		/*
-		 * There is no valid address found for the LL memory
-		 * space on the device side. In the absence of LL base
-		 * address use the non-LL mode or simple mode supported by
-		 * the HDMA IP.
-		 */
-		if (vsec_data->devmem_phys_off == DW_PCIE_XILINX_MDB_INVALID_ADDR)
-			vsec_data->cfg_non_ll = true;
-
-		/*
-		 * Configure the channel LL and data blocks if number of
-		 * channels enabled in VSEC capability are more than the
-		 * channels configured in xilinx_mdb_data.
-		 */
-		if (!vsec_data->cfg_non_ll)
-			dw_edma_set_chan_region_offset(vsec_data, BAR_2, 0,
-						       DW_PCIE_XILINX_MDB_LL_OFF_GAP,
-						       DW_PCIE_XILINX_MDB_LL_SIZE,
-						       DW_PCIE_XILINX_MDB_DT_OFF_GAP,
-						       DW_PCIE_XILINX_MDB_DT_SIZE);
-	}
+	/* Let device-specific discovery override the static template data. */
+	if (!match->parse_caps)
+		return -EINVAL;
+
+	err = match->parse_caps(pdev, vsec_data);
+	if (err)
+		return err;
 
 	/* Mapping PCI BAR regions */
 	mask = BIT(vsec_data->rg.bar);
@@ -424,8 +456,8 @@ static int dw_edma_pcie_probe(struct pci_dev *pdev,
 			return -ENOMEM;
 
 		ll_region->vaddr.io += ll_block->off;
-		ll_region->paddr = dw_edma_get_phys_addr(pdev, vsec_data,
-							 ll_block->bar);
+		ll_region->paddr = dw_edma_get_phys_addr(pdev, match,
+							 vsec_data, ll_block->bar);
 		ll_region->paddr += ll_block->off;
 		ll_region->sz = ll_block->sz;
 
@@ -434,8 +466,8 @@ static int dw_edma_pcie_probe(struct pci_dev *pdev,
 			return -ENOMEM;
 
 		dt_region->vaddr.io += dt_block->off;
-		dt_region->paddr = dw_edma_get_phys_addr(pdev, vsec_data,
-							 dt_block->bar);
+		dt_region->paddr = dw_edma_get_phys_addr(pdev, match,
+							 vsec_data, dt_block->bar);
 		dt_region->paddr += dt_block->off;
 		dt_region->sz = dt_block->sz;
 	}
@@ -451,8 +483,8 @@ static int dw_edma_pcie_probe(struct pci_dev *pdev,
 			return -ENOMEM;
 
 		ll_region->vaddr.io += ll_block->off;
-		ll_region->paddr = dw_edma_get_phys_addr(pdev, vsec_data,
-							 ll_block->bar);
+		ll_region->paddr = dw_edma_get_phys_addr(pdev, match,
+							 vsec_data, ll_block->bar);
 		ll_region->paddr += ll_block->off;
 		ll_region->sz = ll_block->sz;
 
@@ -461,8 +493,8 @@ static int dw_edma_pcie_probe(struct pci_dev *pdev,
 			return -ENOMEM;
 
 		dt_region->vaddr.io += dt_block->off;
-		dt_region->paddr = dw_edma_get_phys_addr(pdev, vsec_data,
-							 dt_block->bar);
+		dt_region->paddr = dw_edma_get_phys_addr(pdev, match,
+							 vsec_data, dt_block->bar);
 		dt_region->paddr += dt_block->off;
 		dt_region->sz = dt_block->sz;
 	}
@@ -543,10 +575,21 @@ static void dw_edma_pcie_remove(struct pci_dev *pdev)
 	pci_free_irq_vectors(pdev);
 }
 
+static const struct dw_edma_pcie_match_data snps_edda_match_data = {
+	.data = &snps_edda_data,
+	.parse_caps = dw_edma_pcie_parse_synopsys_caps,
+};
+
+static const struct dw_edma_pcie_match_data xilinx_mdb_match_data = {
+	.data = &xilinx_mdb_data,
+	.parse_caps = dw_edma_pcie_parse_xilinx_caps,
+	.flags = DW_EDMA_PCIE_F_DEVMEM_PHYS_OFF,
+};
+
 static const struct pci_device_id dw_edma_pcie_id_table[] = {
-	{ PCI_DEVICE_DATA(SYNOPSYS, EDDA, &snps_edda_data) },
+	{ PCI_DEVICE_DATA(SYNOPSYS, EDDA, &snps_edda_match_data) },
 	{ PCI_VDEVICE(XILINX, PCI_DEVICE_ID_XILINX_B054),
-	  (kernel_ulong_t)&xilinx_mdb_data },
+	  .driver_data = (kernel_ulong_t)&xilinx_mdb_match_data },
 	{ }
 };
 MODULE_DEVICE_TABLE(pci, dw_edma_pcie_id_table);
-- 
2.51.0


