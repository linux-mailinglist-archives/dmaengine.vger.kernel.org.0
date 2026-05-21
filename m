Return-Path: <dmaengine+bounces-10602-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GEVsJ+emDmr6AwYAu9opvQ
	(envelope-from <dmaengine+bounces-10602-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Thu, 21 May 2026 08:32:07 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 4599C59F6E9
	for <lists+dmaengine@lfdr.de>; Thu, 21 May 2026 08:32:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 408A83032525
	for <lists+dmaengine@lfdr.de>; Thu, 21 May 2026 06:31:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B5533955C5;
	Thu, 21 May 2026 06:31:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="w3VLvbef"
X-Original-To: dmaengine@vger.kernel.org
Received: from OS0P286CU011.outbound.protection.outlook.com (mail-japanwestazon11020112.outbound.protection.outlook.com [52.101.228.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54D37395AD9;
	Thu, 21 May 2026 06:31:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.228.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779345091; cv=fail; b=TtzS9XEoFD/dRJ5KEtYN7EX/rNPSd35nK35H59/1QBHKuuvHVwNfEu0Ixb4eRTS891UUXJvb7WcMpOpXGXDyw89OAjri4lkYJwIQTvNfonQ6GrV6W6SrVXICu/X/iITt62e+IIOR+F+lM196RBgsKjGiS13Zr4TNARr80whTdr0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779345091; c=relaxed/simple;
	bh=0KIawX3aRrJQzeecinO/V7Ffn6FsJ8P9do+EdIt4tUo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=N5/AkkrBc6SdxHyIvgOlg9hvikp9opu9Vnlf0ImU6Fkh7Xp1iQ1vaE1DQQVr2hx5t068jTELOQoGRLXqa4u/AlwUS1L3qOip7wVdk1FiMEPxq/TB27GWu47QDR0zHkhC7LB3SvsoHK7tUqrfSIXwS5TJVxt+2S7xG5ujIOLfXxM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=w3VLvbef; arc=fail smtp.client-ip=52.101.228.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VUgqgmebTrYg8jIrm0456DkH56Nmr27RrffDMtZIFn4Dbz/9TTFfldKo6qlqJwyUiUl6NPRp0oFMfKTkZ0KwTbf27pJWyxWk8n65mScH65Sem70wvyT0dytzrrwlrTxEelnYlpafVJZINDNOlaYRApoFBdGopAOUJ/PgltlovMd1ZQth9i+m0Fkx4tPly4tCqr9918UzFYmFOdGpxKrRbcSR9KYEYQZS6wjL0F1eg/eCUPgUJONtaPRYGNi2tjRbULCGqoFu2sh2BcFh8RTREUe+pw8TMxdIVoEPmeWY/ZVELjMq2gRkyqs+b3GaJkVUclc3k7kHs1YtOT/c9hfc3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8HcgQ6IRqg/kLgZJ5/4TPbqATlmJ9iRfIBWA4i3AyPM=;
 b=fIYSoIZF0wBbADIeZ7q5bQI9q4GYiVXKEBLXR+ortIrH8aQ6U/RRA4KyrubErIHNDHugcEQE+Y1VVGc0Qz9uKmxopi0ieE3l0N5gbOFRj4LbMRL9KDCwLAfRcE7s7UDGdo6SD78BvYAuyQM7voI+3KbOcT4lLS4He5tmKKDYLdsobjxBAlO4JaSu8gAIDOtMzhfGtdAY1rRtif8iPgcrzDGMQJQ2c0m1c9zUte5nfZuA1rP6vTVJiv7uNvgBETCHXHKeMXaQCqH30FhDshdlf+4BYjLzzBoGHXZ9uVKS3xG7ClT9LAFFvBq0x7KjH/6roO3bAdNCEsUPa/3nIEGxDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8HcgQ6IRqg/kLgZJ5/4TPbqATlmJ9iRfIBWA4i3AyPM=;
 b=w3VLvbefym5L6QvSYqCfcIRJgKMUzemY1we1fTgECvzNflA/cweLagAsFMh+sGxSeg2uXGJ2Bp5764yQjb8bhgtpUS8hLawoa3wUiLCGCKUIRYVwU6mtnr1XrO5KUuNLykuEwQDsSgEr+s9kjbIdaS8ipNia7EfnuoGXu3VXip0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:38f::10)
 by OS9P286MB7818.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:473::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.17; Thu, 21 May
 2026 06:31:24 +0000
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32]) by TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32%5]) with mapi id 15.21.0048.016; Thu, 21 May 2026
 06:31:24 +0000
From: Koichiro Den <den@valinux.co.jp>
To: Vinod Koul <vkoul@kernel.org>,
	Frank Li <Frank.Li@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
	Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
	dmaengine@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 06/12] dmaengine: dw-edma-pcie: Rename DMA data copy
Date: Thu, 21 May 2026 15:31:09 +0900
Message-ID: <20260521063115.2842238-7-den@valinux.co.jp>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260521063115.2842238-1-den@valinux.co.jp>
References: <20260521063115.2842238-1-den@valinux.co.jp>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TY4P301CA0022.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:405:2b1::14) To TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:38f::10)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY7P286MB7722:EE_|OS9P286MB7818:EE_
X-MS-Office365-Filtering-Correlation-Id: c0e76ca8-828d-4611-590d-08deb70294a1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|10070799003|376014|18002099003|22082099003|56012099003|6133799003|3023799007;
X-Microsoft-Antispam-Message-Info:
	KHV0JbIqSz46qdlkHIPWm4dxoXVjpXaoTUpaYjNPbOOx6FwOyoV4nRRg9kN9OIeNKuz73dXlPKThWsBZ+UKb63tgoG3JJcxbzOvoRPIK49/W6VQTaplP/BEZG6qt8/STTtVZbk9IkglBUc5Wx/5wM0+e2rNT+SyTca/WB4i2Ccb+gOx85vlMmp0T+iRfD8yCPvdSaPiabsPoMo6tosMB/3ZjkkS5tyRI5D0pkm04hmgLL6/7dROXh1EsBU7w7HBIduGzgFJYOdxQIC6rKBXrJz3gb5Lv5Wjec1l3hiJFLn8Rs6ygFKB42gWSXPXmLY9iInkBnRojjqTQxnIt55d0JeSzLxI9qVDqvck3USgtdWJf7UE+/W3cZEqjeBJWtVtkiKjcrIQOYS7iDF/uh17T7PwJ8UZk0n/STPgHupRV/GkBeWuHv8BLUTFs2ZoCCjXZT5KxjKsVwlWOHMEb+DQeFsYK2IPwUlr50SsSkL/bD0eTdfR03dsstao+PhJU1zFddXx8wg9B0u9PmIJlJG6yL1cA5lRR2jx/hLlIMA093Z8bZOqZX2+ocXDdfmWSSs/Y8YPsBINStDwzmDBquV86xuWN/FPQz1XEcsGCyCw9mD7XicmzA4ZmJcdLrPboG6vf8knK84ykRNoQqyprq3N0EqOyXtYcv0VX+a6dJ+zcYgtiRzufbraNPI/3JazlkOTY
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(10070799003)(376014)(18002099003)(22082099003)(56012099003)(6133799003)(3023799007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?aI62eT1LuMjvO+osfopqGZ63qKub6rAbO/wnDt23UE2dzfypSbz8GJ1XIP3y?=
 =?us-ascii?Q?QcSIk6LcXvPxZ5eAiBktJQ1rmFow818l/p2uCkfN5MOOarj7I9Jx8BZUy/XU?=
 =?us-ascii?Q?GY36DccxMX87ihomzWEk9jnq9vuhunnkfO5VcPWYqY4uAoRjUWl0YSE/YR5l?=
 =?us-ascii?Q?a/TeFVyH8j/PiCReoR4z+wGMdUq1aG999TZKxk5kOoVPqNmJQNeVlUHn5La0?=
 =?us-ascii?Q?RcVaEE7AyWiBv4xWJyZBcychkHgkrL+EuEOfn4ytPUDvtW5Wq4JD5uRPFe3C?=
 =?us-ascii?Q?nf2JJBKfvw0fpoL3BEhO0ymWi/ggelbIfh7ziNwcU+dTAOpQVV9kDA4VPf62?=
 =?us-ascii?Q?jn6EpLT3JdRrcj/84n19X1FzegQ79kuuV0nf/qjOp6XXZW6piT6+/dDqFS6Y?=
 =?us-ascii?Q?4sMZaa8us3d2uQrxDue/36I4h2WGLhjVR/yi7sQ+Ehwi7B4X2TN3+laqbTPo?=
 =?us-ascii?Q?moXKE/EB0pTqC0exjGbcNTTOxiMMjQ9NW5OLfgS8QKuPvBGZCXa1xH+iplvs?=
 =?us-ascii?Q?TGL0uHx6TSLhs2I+z1+N2BclkLjw07C5jQ9LhyrpZ/lkMllbNwu6xsExdAFa?=
 =?us-ascii?Q?QcLjTOmqYzfUi8pOvAkoelKIusK/WHHBHJ3sJYPhHNKAp9RYAmdSEFlVanaK?=
 =?us-ascii?Q?DP3so21MVkWpGLYwXpNhSIe3IKfh6LiL7lG8mYcXFnklhniOY8vCDRZJmteb?=
 =?us-ascii?Q?xrF3H+fTOyI4wMJq98EOPBqCMINVV5gFwQt+JxNnGqE1fDZndspUj5bJkYlY?=
 =?us-ascii?Q?g3zIzpcWBw+Ws8QMG9dRVW4jwVa/vAW8E0QTWOHDPYWxNGMRIv+xCns8IJ+c?=
 =?us-ascii?Q?AQdxDedKo7sVGqL2hsUhfqO2y7xaWjeupyYI/BibHBG1Exn5XMv6V+pS11qq?=
 =?us-ascii?Q?RF69hoadqBD4aqni4/uKcAMxdnsKak13fwfwv6Jw+hpd7SumNMfuFMw7MYpw?=
 =?us-ascii?Q?w5+VDGCoZu2T0mpOG492IoNroNPU4fFBBh/UOlp0HjWF1/SceZ99KSo025bH?=
 =?us-ascii?Q?g96BBYruN/k0HwX5N7jtf/vytgfLlkOBWiiDMx13y/dL8ql+HHOL6jU46VlO?=
 =?us-ascii?Q?EVlN+pCNqpzbjBZSneuzMb0mAcmUlDcR65RQgEgJ4oabhUkd9pIrQsya17OP?=
 =?us-ascii?Q?jCiCwTGy/FiCFLdBPeHZHG9N2Wn4PAK4p9eO3PHdiMWPZ9cRpSDcHBsDybix?=
 =?us-ascii?Q?jOs5ziZWH6q31QlvhzW6X9MNiM2zfZiHzOW1cJqb2ecrErBldbImBYFtr4hu?=
 =?us-ascii?Q?wt3ElNqg85TZcVJbZ0kLyiFgomeq6rZNP2CMym63VzXObwXy44iYjB849NG+?=
 =?us-ascii?Q?unU5zKyd11ipd5mNBK0D7PyK8WUM/M4XRe6oK729q9y6Z5i3G+1xqH0erCXJ?=
 =?us-ascii?Q?b5bOazJ87Lflumom4A8WdVeDgyJ9/DnxomaTpRd354R01YlThoxCspz4VvwI?=
 =?us-ascii?Q?O7oQso5B2+a4B9ty47tehtXc4e0LhfPY4nbe+rs5Vt5vPpqgN6etJws6rORj?=
 =?us-ascii?Q?mHaTstaCXCRk/I1qckoUAysQzJBs0ooz4H2WHExFggpghMCYqQsaY868BMR2?=
 =?us-ascii?Q?VYKVca4dxra44ysv29FaC3eCkveP3CUsNtUYNoxwsqyhCVjIQUaS6rvFmpz0?=
 =?us-ascii?Q?q93VfsSoYJw5FsqdctZ26u8DS0DCqUXrOa1YMGbS7wPjJYYRMaLu/+KildMc?=
 =?us-ascii?Q?LlONr5jXqQMcTMInT3wYSKK4beAlpGRViEyGxy3xGKgmohpcEsqBkLFrKpZR?=
 =?us-ascii?Q?RYwsYvR2WgmRbg7/fRMGZRih85NdOuR3eZIOyFHkqLIW9qSjm7+R?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: c0e76ca8-828d-4611-590d-08deb70294a1
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 May 2026 06:31:24.5276
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1iMotH1rHNHJ04Ge5axuUaJUxH1w2ymcsMh65rVO5Gewd1M+MtHj7u72xrXj420QobTvmbddjnSLVj3ZjWH8tw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS9P286MB7818
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
	TAGGED_FROM(0.00)[bounces-10602-lists,dmaengine=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,valinux.co.jp:email,valinux.co.jp:mid,valinux.co.jp:dkim]
X-Rspamd-Queue-Id: 4599C59F6E9
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
 drivers/dma/dw-edma/dw-edma-pcie.c | 70 +++++++++++++++---------------
 1 file changed, 34 insertions(+), 36 deletions(-)

diff --git a/drivers/dma/dw-edma/dw-edma-pcie.c b/drivers/dma/dw-edma/dw-edma-pcie.c
index 043a7f73bf79..8ae164169c7e 100644
--- a/drivers/dma/dw-edma/dw-edma-pcie.c
+++ b/drivers/dma/dw-edma/dw-edma-pcie.c
@@ -369,11 +369,6 @@ static int dw_edma_pcie_probe(struct pci_dev *pdev,
 	int i, mask;
 	bool non_ll = false;
 
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
 
-	err = match->parse_caps(pdev, vsec_data, &non_ll);
+	err = match->parse_caps(pdev, dma_data, &non_ll);
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
 	chip->cfg_non_ll = non_ll;
 
-	chip->ll_wr_cnt = vsec_data->wr_ch_cnt;
-	chip->ll_rd_cnt = vsec_data->rd_ch_cnt;
+	chip->ll_wr_cnt = dma_data->wr_ch_cnt;
+	chip->ll_rd_cnt = dma_data->rd_ch_cnt;
 
-	chip->reg_base = pcim_iomap_table(pdev)[vsec_data->rg.bar];
+	chip->reg_base = pcim_iomap_table(pdev)[dma_data->rg.bar];
 	if (!chip->reg_base)
 		return -ENOMEM;
 
 	for (i = 0; i < chip->ll_wr_cnt && !non_ll; i++) {
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
 
@@ -467,7 +465,7 @@ static int dw_edma_pcie_probe(struct pci_dev *pdev,
 
 		dt_region->vaddr.io += dt_block->off;
 		dt_region->paddr = dw_edma_get_phys_addr(pdev, match,
-							 vsec_data, dt_block->bar);
+							 dma_data, dt_block->bar);
 		dt_region->paddr += dt_block->off;
 		dt_region->sz = dt_block->sz;
 	}
@@ -475,8 +473,8 @@ static int dw_edma_pcie_probe(struct pci_dev *pdev,
 	for (i = 0; i < chip->ll_rd_cnt && !non_ll; i++) {
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


