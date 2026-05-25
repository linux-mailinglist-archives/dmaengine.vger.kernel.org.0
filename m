Return-Path: <dmaengine+bounces-10813-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WC1aL3zrE2qoHQcAu9opvQ
	(envelope-from <dmaengine+bounces-10813-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Mon, 25 May 2026 08:26:04 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 362055C6612
	for <lists+dmaengine@lfdr.de>; Mon, 25 May 2026 08:26:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 58CC03028F54
	for <lists+dmaengine@lfdr.de>; Mon, 25 May 2026 06:25:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65FC53A718C;
	Mon, 25 May 2026 06:24:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="Ea1q0cgz"
X-Original-To: dmaengine@vger.kernel.org
Received: from TYVP286CU001.outbound.protection.outlook.com (mail-japaneastazon11021139.outbound.protection.outlook.com [52.101.125.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B36CE3A3E72;
	Mon, 25 May 2026 06:24:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.125.139
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779690284; cv=fail; b=QaGrFc+FvIPNDPOEAejdtajxf2ykpghXfGjUEAoScZY6S7Hgaa0mmmGGSRGcKUKPz0KOXipo8h5ceOcW5lqa/fle48eXOkO1n963cFDofzptdK/a2r3gZ9NxTV2J7I2rRX1SVWAjRXVMI99L3TMlx5vrkhazrVOGSIFwQIvEBdY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779690284; c=relaxed/simple;
	bh=rRP+PDwvr2b+Imexx/zPXVV6xNLjpMLY3hbn/10a3k0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=sV93gge0l6tHbMHIUMW2j67ybkbDr0fx8m/DnxwS0hqSGi0y87M7yKCPgSEOXTVcFQu+8jEihW9gJvrLF4FZKEvHmEu6JomypD0jqDM1ArlbwTsV+fIlnaQ6mzLRZQJnKDHJ73t2EUutL0DS7hjVzCPZOimXAdRY8RHi4MxYS2A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=Ea1q0cgz; arc=fail smtp.client-ip=52.101.125.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eizt+Ji2sblPyWifQOU2TfD+DqUefboYu/Ij8eeDZ1zohTiT9KCS7+uZNvvODLDkrY9777Nkk7bMjI3IR8iF5jyMGwyRxB8HlMmvYGq5hOIo6vYExxz8DsludgykaFcMx5BxRX1xPT4mRdIjlnQeN3eeuXUxI9YXT9K2ufjB257J7SfDXeYMURY5xzgz8SM/YZQOwfLS/D437WpNDnmglBO6vgkPD8Awzz0DSylOJdSESl6HGc9Kxo42Hd1if3QfYy0UarxdNOD5duB0Rx57ux90h0Js+pHCHkl+O/fSXbLsOqiETxopDROri85dCqGVXgK8ulXZi3+JrsiLlUgXQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HnSfefuvb2K0iHOeUjSuQAQ8tg/8kv3LBkAyOGoPm5k=;
 b=TbO+jA7mxqKBVAnCS8BBM9Wuts6aTmzJ6Posf8A4Xh5cX4+7xlIG5rIV6/xtirYtIZ2ZW+Ynf6aTH2AjoKjYiZ8WjMVKUKjARJg+DXtRX0pxpKwwAl3ONVTi/RCswYGqBIht5Gn+4Yx+1MAC+Enxu7R7iUupnlHYJxX2EyBdSL+8q5lp99sNqrI95ym0ubv7F4FzptOhVMIsYjEE6/Zs2/B1ukMzjaYwzDQa3lESNya5fROBQvEXnbCeClkiMA37g5DoPWVKeMSdaSFmPy1RKgwCVMH/otAwjlm9T4nbm3RSjsVUaKfMNroMJkPVKcWMwKpUVmMg+RsqkCvpnHS1Uw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HnSfefuvb2K0iHOeUjSuQAQ8tg/8kv3LBkAyOGoPm5k=;
 b=Ea1q0cgzXENItt3maajUrEZvXTwZ1gHrKhEATteKZk7kQ5QxzKVm8G1cMBMqLv9dpDJmvWfTVu7WPyX5Gse07N+MAXnV5FRGbyFYp2DHNOKE2rgnDI2ZXhtVfzvNSgzPg+hPKcK9AF6XQ+socwQ/OzR4fNkMCXBGw/9GVDibrKg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:38f::10)
 by OS7P286MB7796.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:441::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.19; Mon, 25 May
 2026 06:24:38 +0000
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32]) by TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32%5]) with mapi id 15.21.0048.016; Mon, 25 May 2026
 06:24:38 +0000
From: Koichiro Den <den@valinux.co.jp>
To: Vinod Koul <vkoul@kernel.org>,
	Frank Li <Frank.Li@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
	Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
	dmaengine@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 06/12] dmaengine: dw-edma-pcie: Rename vsec_data to dma_data
Date: Mon, 25 May 2026 15:24:14 +0900
Message-ID: <20260525062420.3315904-7-den@valinux.co.jp>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260525062420.3315904-1-den@valinux.co.jp>
References: <20260525062420.3315904-1-den@valinux.co.jp>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCP286CA0068.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:31a::8) To TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:38f::10)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY7P286MB7722:EE_|OS7P286MB7796:EE_
X-MS-Office365-Filtering-Correlation-Id: 6444a021-fc54-4d97-5093-08deba264c3a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|10070799003|376014|366016|22082099003|56012099003|18002099003|3023799007|6133799003;
X-Microsoft-Antispam-Message-Info:
	3QJf25mxZYTlE4Dz4GgZJQ3n7xB+LeQ9jZUCjMhNAnx/nXbJvfWyJjQ9bMxW9T2bFOVeNT4Llg1RsLD0rcBEJ2lj5wxZE0qcDkFfm+76lwGtonf5C8SHOjn7j6YSHli4x7GVtBQ99ZLRxZb8Uc/KHYcYY5p8RhU9rbZhpnU/WyFBlHwP1OIl8/d4N/L6ttfiZ3su/41R27Oy/IM6G4BKtrKRA5DEa0pBeZpPEdb0IHu1zwn2C3XXfFzk6bqvqxEoO/n3+B3eUzoDwyNb9GN6gh6liWkfdbJc6ICw/TEBZUR9VirexlILNMiuxyDwCkMjTNWrDbGkgvkTLa3cLruIRo0c+rDDvhrWXq8lJwUGP0PyuhlcvB5OL83kq9yTLwJr/FRarsEYeBnT0nxi+UBLyWS8T97036aSwW+7DIXsrxbCZld5A+124Zyzzsk+isVp2g6TKsG5AH8Uc7YdXdboTLAaKGn3e52F1IGbvD/lLTkFKmIULvsv2gyCROqwqtnB70SZiPNWayZYp0npq+1u43rbfC4q/nbiADeMwFe6dNDcCoq8vMcR0XiMZquuoy9Q3A4kBlfXHbrDq9MOKnSb6EFvp7sn4wrGrekNGq0KPRsrk79qeL4LiVcH1gHxlIqx3MxZO7rdYWHoOCM1AnCGhTYussyfLag3mV5q12SiPQa8wi8mO5rWqBLcc7vR8nCv
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(10070799003)(376014)(366016)(22082099003)(56012099003)(18002099003)(3023799007)(6133799003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?mAK9MEpTE8ozEpnjuXRLojlch3fVIxcHhJgRjXQkdzGKHuo8diqKg4OZNgxr?=
 =?us-ascii?Q?eihlv0f9tFQufl6smiK9fCNxUKqcx0PFR7Vfs91XO2oB0g8N4aH0hb2E6auS?=
 =?us-ascii?Q?LcstF8igkvV3QHPxwBTOR33nJqEFC+TQ39iTn6MtKs9F4gSVczXJBEfYboMF?=
 =?us-ascii?Q?aeWp2HZfrfSFfYhiGMKzaOG9x5ct5usCWnbKIuq7Rsdrn9r0uiPO4dd/zZlo?=
 =?us-ascii?Q?FjrMCfNTykvvuEl4lllZJfT9VKrhuXlZYc8nldOVG90SpTXPUyWP39FG+4t1?=
 =?us-ascii?Q?SzomE4ItEceDKRROcJUsY93aYUSMVR1Jw5uTyhFEysK4E7AaMgw0z6AkZUa9?=
 =?us-ascii?Q?sCAuLNp5mA+ROSSEGr/tGfwytbbs26PHzqJc9iOGosy7KfHMVNz4vOjWcCUt?=
 =?us-ascii?Q?Mvxn/MLBQSGPszgFaEZJZ8UUP1Q/egfbrEFbFc1is3NAjNw8ONsNFosZ35JD?=
 =?us-ascii?Q?oMMNUoLPjj9PpJNsjbrpniHUn1xfNys2nTOeNroBh2rn9LO7Rn8UriDE94FI?=
 =?us-ascii?Q?cRB4rCBaTBjSMevVbFEuO7x4mnYd/D/45ImAw07ipduimrhcMIoj8NbOz/pV?=
 =?us-ascii?Q?ek3qgHWmX12xA6VYbtpyqIAk4yYiZlxAqJQ9N/gC1aIrH06SfaEEbb2dkJmy?=
 =?us-ascii?Q?ccEAnTV6wmrJMncimN1rxg05MAniP5mWwJf5isLV5+0I1M1JjG0feUX8dBP+?=
 =?us-ascii?Q?i7ibLMKIEuk9BvoMQptwkzlSw1iNXjMR6P0bonol9PGGwqLfNve6zwkp3PHD?=
 =?us-ascii?Q?iqDHvvUJBrzzSnWy/e4KQ/+Olcnqh/a3KCs8ITOA9ycniln5jWcZNulUgzVI?=
 =?us-ascii?Q?GUwWAyGdNTXU8fisTeNZJut4NbV26d0gSvG6ja7J0cwrDDUkAJ9Ral97qQOr?=
 =?us-ascii?Q?/EZh4XH+fpTiaEYx5sI8ZbqRq392JC6J6PbSvhm0NFjCU9C94GNZsg42LSvQ?=
 =?us-ascii?Q?2awyLi2iCNCqA7tMcZSojzAGSQqXvQGx+G8pVzvW/Nsgzs8fi7+uvR8qCRl1?=
 =?us-ascii?Q?maKer5QvlXMk2hQsmoo4hcyCbIeZZDCAzgf1wTYsK86oLWt0svaguP3hk8At?=
 =?us-ascii?Q?n1L9Qgb5PW4j8GwR8JZuesPz9jK6vp9E7yJZ527Zgpdp9QuaOrEAiVmPma74?=
 =?us-ascii?Q?YmyQgYMbGGbWvJTxrY/1a6Tjb7W4txjJ/o4fMB8Fd9iOlIBqizhfL2m6rCmB?=
 =?us-ascii?Q?T5YudoC5lbJ8WH2av9j1+mA5v/GvCxGXKCxLAZrHlZ0HsXZwGb61IbaF4QZx?=
 =?us-ascii?Q?VEiz64uaO6fX2Fdg3YkM+kiUWLneBoZLFG37OzF1A4oZVYiMIp+GUPUgVHEm?=
 =?us-ascii?Q?cBNEST5otB2Y/ffAgmfoxPxNlKO7bpYmOE0LMYTO6toQAnzvulpa+kAMeT0L?=
 =?us-ascii?Q?avkb8mNXMrZtwdznvQHZ6QVe+QTmY6wYPImJmOEB3nA9rvUtDhkcL1HmERu3?=
 =?us-ascii?Q?uLTqezpovLcdclZEjclNB1/CWPiDb33e+PRZKcA3H8A1b8fkxhJm6pURCXT4?=
 =?us-ascii?Q?cRol1MrGjcDRYstQm8d0OE68AlMaqOqLMQVKvbnGP7Sltj5f3J1chezJIDyt?=
 =?us-ascii?Q?k2Dm/SsZh5bPCh77nz3MBxqkWQO58/QKelY+DM/Lk7tKE4HQurHNfrGKUJ++?=
 =?us-ascii?Q?uAsOK3V1PH6v8m9GRYUCIrUWbrA29n6RaAg62irE8m221n0XD1OVI7JQ+7Zl?=
 =?us-ascii?Q?TQ2z/i2sgMKxRGqy+jLUf0cCrA6k7NZ7/f2wQlG3a8pVbI+u5qd7GNfW4hCu?=
 =?us-ascii?Q?wdd2UXagJBt1RZBCFnNKMoP8ByhWE/VHgev+VPXR7vlC4/ocMwyN?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: 6444a021-fc54-4d97-5093-08deba264c3a
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 May 2026 06:24:38.4316
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: meF8feiSHO5xAu81BMxojWRKW7DIrJ6IrL96LudrHVLoqqV6v3Pp9d8+hawaJC6i9ejfAW3ZuYAb/mXiwoslDA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS7P286MB7796
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
	TAGGED_FROM(0.00)[bounces-10813-lists,dmaengine=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,valinux.co.jp:email,valinux.co.jp:mid,valinux.co.jp:dkim]
X-Rspamd-Queue-Id: 362055C6612
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

dw_edma_pcie_probe() now obtains DMA layout data through device-specific
capability callbacks, not only from PCIe Vendor-Specific Extended
Capabilities. Rename the local data copy from vsec_data to dma_data
before adding endpoint DMA BAR metadata discovery, which does not rely
on VSEC.

No functional change intended.

Signed-off-by: Koichiro Den <den@valinux.co.jp>
---
Changes in v2:
  - Fix the commit title as Frank pointed out.

 drivers/dma/dw-edma/dw-edma-pcie.c | 76 +++++++++++++++---------------
 1 file changed, 37 insertions(+), 39 deletions(-)

diff --git a/drivers/dma/dw-edma/dw-edma-pcie.c b/drivers/dma/dw-edma/dw-edma-pcie.c
index 5a6f5af358d0..c7362f1bf80c 100644
--- a/drivers/dma/dw-edma/dw-edma-pcie.c
+++ b/drivers/dma/dw-edma/dw-edma-pcie.c
@@ -369,11 +369,6 @@ static int dw_edma_pcie_probe(struct pci_dev *pdev,
 	int err, nr_irqs;
 	int i, mask;
 
-	struct dw_edma_pcie_data *vsec_data __free(kfree) =
-		kmalloc_obj(*vsec_data);
-	if (!vsec_data)
-		return -ENOMEM;
-
 	/* Enable PCI device */
 	err = pcim_enable_device(pdev);
 	if (err) {
@@ -381,25 +376,28 @@ static int dw_edma_pcie_probe(struct pci_dev *pdev,
 		return err;
 	}
 
-	memcpy(vsec_data, pdata, sizeof(struct dw_edma_pcie_data));
+	struct dw_edma_pcie_data *dma_data __free(kfree) =
+		kmemdup(pdata, sizeof(*dma_data), GFP_KERNEL);
+	if (!dma_data)
+		return -ENOMEM;
 
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
@@ -422,7 +420,7 @@ static int dw_edma_pcie_probe(struct pci_dev *pdev,
 		return -ENOMEM;
 
 	/* IRQs allocation */
-	nr_irqs = pci_alloc_irq_vectors(pdev, 1, vsec_data->irqs,
+	nr_irqs = pci_alloc_irq_vectors(pdev, 1, dma_data->irqs,
 					PCI_IRQ_MSI | PCI_IRQ_MSIX);
 	if (nr_irqs < 1) {
 		pci_err(pdev, "fail to alloc IRQ vector (number of IRQs=%u)\n",
@@ -433,23 +431,23 @@ static int dw_edma_pcie_probe(struct pci_dev *pdev,
 	/* Data structure initialization */
 	chip->dev = dev;
 
-	chip->mf = vsec_data->mf;
+	chip->mf = dma_data->mf;
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
@@ -457,7 +455,7 @@ static int dw_edma_pcie_probe(struct pci_dev *pdev,
 
 		ll_region->vaddr.io += ll_block->off;
 		ll_region->paddr = dw_edma_get_phys_addr(pdev, match,
-							 vsec_data, ll_block->bar);
+							 dma_data, ll_block->bar);
 		ll_region->paddr += ll_block->off;
 		ll_region->sz = ll_block->sz;
 
@@ -467,16 +465,16 @@ static int dw_edma_pcie_probe(struct pci_dev *pdev,
 
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
@@ -484,7 +482,7 @@ static int dw_edma_pcie_probe(struct pci_dev *pdev,
 
 		ll_region->vaddr.io += ll_block->off;
 		ll_region->paddr = dw_edma_get_phys_addr(pdev, match,
-							 vsec_data, ll_block->bar);
+							 dma_data, ll_block->bar);
 		ll_region->paddr += ll_block->off;
 		ll_region->sz = ll_block->sz;
 
@@ -494,7 +492,7 @@ static int dw_edma_pcie_probe(struct pci_dev *pdev,
 
 		dt_region->vaddr.io += dt_block->off;
 		dt_region->paddr = dw_edma_get_phys_addr(pdev, match,
-							 vsec_data, dt_block->bar);
+							 dma_data, dt_block->bar);
 		dt_region->paddr += dt_block->off;
 		dt_region->sz = dt_block->sz;
 	}
@@ -512,31 +510,31 @@ static int dw_edma_pcie_probe(struct pci_dev *pdev,
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


