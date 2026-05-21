Return-Path: <dmaengine+bounces-10605-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UCM2M3anDmr6AwYAu9opvQ
	(envelope-from <dmaengine+bounces-10605-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Thu, 21 May 2026 08:34:30 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 5034359F780
	for <lists+dmaengine@lfdr.de>; Thu, 21 May 2026 08:34:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 9C5513049E11
	for <lists+dmaengine@lfdr.de>; Thu, 21 May 2026 06:31:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D26563955E2;
	Thu, 21 May 2026 06:31:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="fVy+YdKG"
X-Original-To: dmaengine@vger.kernel.org
Received: from OS0P286CU011.outbound.protection.outlook.com (mail-japanwestazon11020112.outbound.protection.outlook.com [52.101.228.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20B0F395AF3;
	Thu, 21 May 2026 06:31:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.228.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779345093; cv=fail; b=YMmzeOeP8e7NpXIBR9HBaQFa4ArOV0tvUSK88fSNzuNI4L08PkuNSMgWiP71aF9HWjHFaqe65WZeJMljRhfw1TYdoPV3nd2/j9jNsRCTs5U8+XoNGfHUaZS5RRgc1VketZfZyXOxgKOAl4jG4mmFnx0rZenXWFaWqc+HG8l9a2U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779345093; c=relaxed/simple;
	bh=wCEdtgYVRZH1n9kUTC7kKjwQbgFrrenJ7qIOlsIn7BI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=X80ztqgusopVYhCb6vLIH3WYTgha8RUJKwriLS1RMjtkXfVJNuWnqwHpFAL7KUSPKmsrQQtthfeE0a6/v3OSUca61TRIePwUMwfvrHxMgu4GBcvLkDT1XpJY5BtZgWQTXHolpxk5JxdNf5Bv8aaNd5aQ2JefSs+n1aJfytk0JTM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=fVy+YdKG; arc=fail smtp.client-ip=52.101.228.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=W4eyfrMZFdoh6+Qok67bTnEyHZEqpDnc5B98QpqC70M8h//dUz0xHzbOTnPpRtO1VAgNWO8zlAPxCf2EcJ129+/k0L52eAglByEw2pSZ+5onAytymcE0XrMIbHpHxD1QC7MxKNWGCA8IWgIOyRpJEbAmdCtYfCu1aB9rilByR4AV7oYF0FB4bsfgvlAG151HmL+WisoWhGw3enRhAw4pLx1iEeMk0O24b2bLMxv0HrdjApgtb5OKYTgxc676TVzCyihwmfF2Ss2Z00fTN6jsa0IVxS0+9ZuPfh5uyKbVl8ZiFvP18vsiAJeYzgkrb9s1WbVu9Sd1kHNyVdIoPl8lXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Rks/I3ijRT9Db+GBXHgTSrfQkZEUXwvUxRYznxxeTCU=;
 b=TvxibBtD4Axnat8HaD2NQKmHOEDFE2dMDNJtNx7CwU1GTQz9yxUsDqG9+KShZpOq4Eovq3qDvDqvj4sWekjzGpRmkB/muGnkxHyu+3W5/Ve19JF/ahsCVgGGiijESNTk3IlFYoZ7KLfLssh2XsWiCP+Fjnzy8uNM8p22qmu81+OiI5IxoRw70LhurSm+bMEVBHAl5oCkKruriYAyOJHVeyujInWcrifGn9qFYNUFDtj9TmZPw6raKzOyGeKxRwJGvdJFx+GUmxKpV3UhkFHSYfOybAWE5SPGd7OA4VgxR9ndRssU4TJhlHtgoqnGsCnIQ/PubhbkdWwInQaO+Fyr3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Rks/I3ijRT9Db+GBXHgTSrfQkZEUXwvUxRYznxxeTCU=;
 b=fVy+YdKGpSTTbZOjy8F6a6a+kkHn1Ge15u4XlGQ1L/E+oj7pOgJ0Ox/GtjeSJ2glzTLd+2CPdtfJRYZHEaFIvocZo9sx1jLjly8v55qOfTnwFvHS60a6xLJAgdjKvrm9FLOvjbMwSJAZS+JWV4hB9U89gC+ljlSjO96BzWGuX8k=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:38f::10)
 by OS9P286MB7818.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:473::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.17; Thu, 21 May
 2026 06:31:26 +0000
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32]) by TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32%5]) with mapi id 15.21.0048.016; Thu, 21 May 2026
 06:31:26 +0000
From: Koichiro Den <den@valinux.co.jp>
To: Vinod Koul <vkoul@kernel.org>,
	Frank Li <Frank.Li@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
	Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
	dmaengine@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 08/12] dmaengine: dw-edma-pcie: Add raw slave address match flag
Date: Thu, 21 May 2026 15:31:11 +0900
Message-ID: <20260521063115.2842238-9-den@valinux.co.jp>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260521063115.2842238-1-den@valinux.co.jp>
References: <20260521063115.2842238-1-den@valinux.co.jp>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCP286CA0066.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:31a::10) To TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:38f::10)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY7P286MB7722:EE_|OS9P286MB7818:EE_
X-MS-Office365-Filtering-Correlation-Id: 02b38a7b-eb9e-45b3-9091-08deb702959a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|10070799003|376014|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	j6fuWSC4dXURjbz9ArYQQpLrIuaL8XLpxyOn+1Emyk/ikSBStHwjCNqm3dOZqnRHREfOEHl2zACyHgIzGsg97osOq9fapV9eLkH5S8WcZ3PTbfBvBt/U1Py5PdKxaLSRKDSFWY3/VYBbXj1r3jwP7VMjTQS/iraIzpn6KPk/p/s3vNCGFEJpmf95oCXvdTEuQqcqlfS+S71F7sVzIJAfFpVb+zx4HFJV0ubx3UzI0xyUwDH6MHayy6AbkM269jCl8rW1nNZZ+li2ithLbIyxM4R6Go44R2j/6W/X0cBnLvIeN/fSxiojVJdGRtphfC81t9DrxL31RNz1GKnMqi8/FTKM67cdm9QHGUZn6iHnS+vwSji+oMj5mb9n/uFwby8MMpV76bKHeSTyKvyFNek3JBS4QhSvDu8AJljxTC965bw5sOUVOICq61mFtITGnRRSFjlz9Nosuy3Lb+hfZ8P0TvBFmQ9j3qqg50AEImHoi1l1GjjkSt+cS/gzwos3DkYXuIJycVJ0zsXI4tTlc1+mtj7IR5jx+dXnnMA0Rkfd6UngZTHreX46zgmZFFzzqs+IILZDcOdvAPQ1KrTY3yFWzCnMLbOX6hpYuOg3iZbfSEmQ8N6VyipX9OC28zgC0oD3OX0hPZkrR8T8nZ0wd7UgOxqJTSSXqT70KH/bFjaD9HKF4LsrisvV/b3yHAp55ntp
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(10070799003)(376014)(18002099003)(22082099003)(56012099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?fEJbZdp/Y6b53v4qhyAlUR96SRkGOZeQ3mrIha2JCbGr74ziTOhYk2j+p2+/?=
 =?us-ascii?Q?G/mmdUNGEpznpoEWrzMhU39acz7HIqRzYHgok8IdVX58yQIwVgmkIdtn8oH3?=
 =?us-ascii?Q?Xk4d7m6XC++v4KpeWpCRxaF1d8WB8Pvi6hzQPyqGE0XQS+2+xFPLgScw+HIg?=
 =?us-ascii?Q?Bu7z9GFMjpSYGYct9IpzS65bzfYyaAEhUYLF6o2wLHMqMYDWSJbCD5fTPI5/?=
 =?us-ascii?Q?ghIo9ZbKxvtWnSzFqcCwaEiC8RCA+2XUoQQ+ryipHtF8w4ZvSWt9JJ2dZlEO?=
 =?us-ascii?Q?6333r7l4ul1A+QWIgUy8aaRJV2CthtDriBTM/a0W/5gUtTCUUwofLAuX+yf8?=
 =?us-ascii?Q?09ePLEwP3W6VlSbfeKS2wkb6gx9sjz1D3R3rTmsCCZbeXEsg3+08Qy+Gh+Rk?=
 =?us-ascii?Q?kF23lByOCAVJgFB5fCUl9z0NeLxMP7TUWMczycp70REhg4tKlncW9Z9iGJh8?=
 =?us-ascii?Q?hpsI60G5qJ6aQAwWTvE2LUDBEWaHFNvwKtk51rpWxhhbNusaNljlwQgr/Ci/?=
 =?us-ascii?Q?yzZjPrfUxFn/I7giCX15CorrSpxk1C9ubBCz3ankOsQQZFf5vqaTWZnMPrLz?=
 =?us-ascii?Q?zxif4zUfYLQ3oF3UBOa6uPi+VUdRvvxkbFRTPUGO4zoOShlMhD1mxGsq5ayS?=
 =?us-ascii?Q?xivtdyraDpheHv+OJupB4RxzV+e6JtZ7DqZoTwELDMDrm3JgH1GBhq485n9v?=
 =?us-ascii?Q?WYsFknAw34lJZV5oI8/jfpRVk1OjmQWW5OsDj7mD9Zf4jkJcXNzKwNRsclMz?=
 =?us-ascii?Q?Q8cIq2kLiVnuU3Sed3+pttYYy5sHa8N8yj0PgKiQXGhnQjLmRy5Aw0NW3Pfz?=
 =?us-ascii?Q?HRmvf7f3p/sCAL/9LKfqipQfgQcHAqVDzX2G11j5ebavy2ALcwPmKV573UuT?=
 =?us-ascii?Q?xo1svq932pTsZ1K1npvqn3Qfz6iEo2YTHhB0MmR3ZQgRCxRG3dL+nBorTn81?=
 =?us-ascii?Q?7ut+CpJbDtXE0j7/BVXoZwoL/lO6aYKE9T0vD1Jy2YQAoVLk6xJO4K7SuVH4?=
 =?us-ascii?Q?rT2yhDhuw5JcOfFTJIQ8cOWKnuelvuRiZL6cicTfpjb6HANFmQ0PNyXCZjxr?=
 =?us-ascii?Q?4LmkpuBQqjgj3jsdOuF5nwkMa3IoDNIVbvKsTweFRWkZT5hT+ymrgAfP6SG0?=
 =?us-ascii?Q?W7yBHbiMLCfgR2zzrPYS2EsQTCukYzhU1uhxfpBfeXB01LolBwFqZR/Hl65B?=
 =?us-ascii?Q?OxDNxZJ6RDWLIAsaMejgg07AbruHZrqmL3FGSnctJNfCYT/Pnl6mVv3RGjyt?=
 =?us-ascii?Q?qOd1JMoXca/v1RNM4dglpdDqIu8btaUiQbIs9Y/+l8mwRUG7vKK6kqj4DHfJ?=
 =?us-ascii?Q?llGjaGSAXZ1vOQkwbzuvgVDOJAbxuIYYDlBVdiLo3GZtoHhhzQxYQQ+Vimdy?=
 =?us-ascii?Q?yXN8+53ef2Jg8m6pHADBeNluh9ae4qynPn75yNjF2kVkIy7fz6+pAkBxWncH?=
 =?us-ascii?Q?5cPiw3otHKFkWD8kU2b48LUaTUUfpxTHPVrnqUfZv7ZG1o/1sakUbPEj7roy?=
 =?us-ascii?Q?2bm349ts9psjkdO8YcbWIqZOmPLH09FD7CErBNmvN/QgoD3TFnty/tgd1s6T?=
 =?us-ascii?Q?Lwx6uXbM5Y5gV1vJirvMtURz11rdxnL6+X/4vasmYhZALrHe10pjJ3TEeRw4?=
 =?us-ascii?Q?gJCLf0sAT12AoRaaGJtg0SHIfZUHVd2X6Laoyi7RUoPrIrjwZyOw1spaT9yY?=
 =?us-ascii?Q?J2Jzb5CbAufwQsd3CWuYgf/PrNIGqBT7JoSfC1y1I6c1aHEhEZMzdUa2gOxT?=
 =?us-ascii?Q?bAaWANMiV5I02yGIn3wAswzy/aZHPV/56uXsQI3DiJ35bV0rSUyP?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: 02b38a7b-eb9e-45b3-9091-08deb702959a
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 May 2026 06:31:26.1589
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9bt2b7nVEC/vAQXdn2WMvw7rUFYbKSgRNM9KJUkWAOieAFfxiV6IQWCRApqQu4za2msDb7QXJgNieEIsIoNR+A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS9P286MB7818
X-Spamd-Result: default: False [1.34 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[valinux.co.jp,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[valinux.co.jp:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-10605-lists,dmaengine=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[valinux.co.jp:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[den@valinux.co.jp,dmaengine@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[7];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[dmaengine,renesas];
	DBL_BLOCKED_OPENRESOLVER(0.00)[valinux.co.jp:email,valinux.co.jp:mid,valinux.co.jp:dkim,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 5034359F780
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Add a match-data flag for devices whose DMA slave address is already in
the DMA controller address domain. Such devices do not need the
dw-edma-pcie pci_address callback, which translates a CPU MMIO address
back to a PCI bus address.

When the flag is set, select platform ops without a pci_address callback
so dw-edma core passes the slave address through unchanged.

No functional change intended. Existing matches do not set the new flag
and continue to use dw_edma_pcie_address().

Signed-off-by: Koichiro Den <den@valinux.co.jp>
---
 drivers/dma/dw-edma/dw-edma-pcie.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/dma/dw-edma/dw-edma-pcie.c b/drivers/dma/dw-edma/dw-edma-pcie.c
index cf2f09f1891c..651269708cc5 100644
--- a/drivers/dma/dw-edma/dw-edma-pcie.c
+++ b/drivers/dma/dw-edma/dw-edma-pcie.c
@@ -87,6 +87,7 @@ struct dw_edma_pcie_match_data {
 };
 
 #define DW_EDMA_PCIE_F_DEVMEM_PHYS_OFF	BIT(0)
+#define DW_EDMA_PCIE_F_RAW_SLAVE_ADDR	BIT(1)
 
 static const struct dw_edma_pcie_data snps_edda_data = {
 	/* eDMA registers location */
@@ -208,6 +209,10 @@ static const struct dw_edma_plat_ops dw_edma_pcie_plat_ops = {
 	.pci_address = dw_edma_pcie_address,
 };
 
+static const struct dw_edma_plat_ops dw_edma_pcie_raw_addr_plat_ops = {
+	.irq_vector = dw_edma_pcie_irq_vector,
+};
+
 static void dw_edma_pcie_get_synopsys_dma_data(struct pci_dev *pdev,
 					       struct dw_edma_pcie_data *pdata)
 {
@@ -435,7 +440,8 @@ static int dw_edma_pcie_probe(struct pci_dev *pdev,
 	chip->mf = dma_data->mf;
 	chip->default_irq_mode = match->default_irq_mode;
 	chip->nr_irqs = nr_irqs;
-	chip->ops = &dw_edma_pcie_plat_ops;
+	chip->ops = match->flags & DW_EDMA_PCIE_F_RAW_SLAVE_ADDR ?
+		    &dw_edma_pcie_raw_addr_plat_ops : &dw_edma_pcie_plat_ops;
 	chip->cfg_non_ll = non_ll;
 
 	chip->ll_wr_cnt = dma_data->wr_ch_cnt;
-- 
2.51.0


