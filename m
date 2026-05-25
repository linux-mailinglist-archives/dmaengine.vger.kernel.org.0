Return-Path: <dmaengine+bounces-10819-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iMQCGkLsE2qoHQcAu9opvQ
	(envelope-from <dmaengine+bounces-10819-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Mon, 25 May 2026 08:29:22 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DC8FD5C66FF
	for <lists+dmaengine@lfdr.de>; Mon, 25 May 2026 08:29:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 3EACC3025C1A
	for <lists+dmaengine@lfdr.de>; Mon, 25 May 2026 06:25:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 318023AB48C;
	Mon, 25 May 2026 06:24:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="oeO/539j"
X-Original-To: dmaengine@vger.kernel.org
Received: from TYVP286CU001.outbound.protection.outlook.com (mail-japaneastazon11021138.outbound.protection.outlook.com [52.101.125.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B14D73AB276;
	Mon, 25 May 2026 06:24:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.125.138
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779690295; cv=fail; b=ifCcejHHdTjUfVwuRtNJuJmFRNCBP4/Ne1kiuJkhYA2TuMXAp/H1F3hvJRW3fFkNRAPSePlMtxoAYspMMgiurJVri/Zdai0kXTaGSyHvpn0BR6pYBFst8gJDAaQ3NKhR/35zMbr5nXdwobEsQJ7HM0ypLHsRU4n42RfavSMOcU0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779690295; c=relaxed/simple;
	bh=RROVMQuVKl7s3MgsegWKxvp+X/yrLCqTTu6IbK3DMhs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=tOtldIdMfOSQVYdMYYS1lOQVKD6id1u2L2QUj7cOXUmvhG1k0UsfA3Sl5cBrDmRUhElLwmUzk5QsaKPly7uqkOKWFxAJS4vsefTfhMQXCsgaxhb894Jd9Qw7Ub1X2zXk1MKZKuMHvyAfI2l2ikL6sYzIrSI8ZyEoTQL/BD49Vlg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=oeO/539j; arc=fail smtp.client-ip=52.101.125.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Tm8aJuK4CcfHAYoG84v+rH/KTU4e5hYWZq0Kpibewox9YljGlO39Zl9mv1rq96FPIOKrJS2ReQg81V46XTZh7gqamnv0IXavacYGs250RTCngJoCZfDqc2KNfD1/wuBVVfQxOVfyUzyEzWLy7+bhDekwJHrv32A/a/EAMcA9xf1M9BrHWOP0JnThqTYr+5JdywKXftet56DJY4V4kWRJVcmjxsGgZD1LGKXvyvDNN9ib0VlmmZS03BvGGxZLhiDHtBXFmJ/5dUhLIBCi3UMQNUsq0AQ9tE/vBFMluIKbr7OD4pDE+LMMjKgz9zZDCoj/i3//A+pmsbO+yQwOG6wrcw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4MVGSda3FlOa9i//RdDPt62M1NgLSFQDDNG9ZqXp5Fk=;
 b=UhmNw8a2d3ipjH/+8Tq0RxHVxQ1A37PTKohevj/hafNFa3eBFCb2OCgYadu3IIYWFT+QihoE9D59NySzuy6R3b87JG9wWCdovqZ4GnlxVpWszXdPP8vFMeuZVqepdbg3RGtOYNYDS4XZmU0oDYVQpXSUpBDuc+AJHaXoJkfUXXjZUesoUTxoWcDag9TvAxoyBu/K0ZtLSFkPLtEuj937lN8dkeblyb7RAAnxmyyfvtcVxA+ZHI+I0rrXSr3/0h1HwtDl/Y3lsPfrJI3fRoqmQFh7uudtOdRjUh2CpnuPqaPt4lhJUOA2vsShE65nCBNEpzvSnvRRLwO19jKNJCBGKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4MVGSda3FlOa9i//RdDPt62M1NgLSFQDDNG9ZqXp5Fk=;
 b=oeO/539j5FCLB7LRK3TSTaff93W8GKNCRT1JAVy9FG08fzjjBjor7qBi6fqokx1BYuvwijglzWKJPkpKnzzxU4TmdoZdr2HXFtVDE6Z8qG10e67uMng8DFPK3H+wZo+U82jul6m7uW0BZMa6XYgN7su8NzZ5+4/Wm5ZochZZ7f4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:38f::10)
 by OS7P286MB7796.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:441::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.19; Mon, 25 May
 2026 06:24:42 +0000
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32]) by TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32%5]) with mapi id 15.21.0048.016; Mon, 25 May 2026
 06:24:42 +0000
From: Koichiro Den <den@valinux.co.jp>
To: Vinod Koul <vkoul@kernel.org>,
	Frank Li <Frank.Li@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
	Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
	dmaengine@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 10/12] dmaengine: dw-edma-pcie: Factor out descriptor block address lookup
Date: Mon, 25 May 2026 15:24:18 +0900
Message-ID: <20260525062420.3315904-11-den@valinux.co.jp>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260525062420.3315904-1-den@valinux.co.jp>
References: <20260525062420.3315904-1-den@valinux.co.jp>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCP301CA0087.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:405:7b::6) To TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:38f::10)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY7P286MB7722:EE_|OS7P286MB7796:EE_
X-MS-Office365-Filtering-Correlation-Id: 1654dbbc-c3d2-4bd8-1f63-08deba264e63
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|10070799003|376014|366016|22082099003|56012099003|18002099003|3023799007;
X-Microsoft-Antispam-Message-Info:
	hFr210L9sW1hExBD2vnvUEMr7VAh5XabsEvGw/8EKhAmCrxnPybw1C5z9yVIrmMb6T/P+7mxMcGK+4J6nI1P4fVZYaNIF2oDUTaxLhlmsHxwEIoudAvpe6dJc+iisbtq0nZ9WT3OFyCeb3EsqBDzjeJTWgwfNfMVw6syRzeKKIjTNn3SMjtRED4Jyv7GqHfha6ldlZn5xbCBwszl1zXGGtXvi1b14fSbCA63PWyMOH9tBExYE5hUWy0hz8RkJ3GQJ0VrKCmy8Ftns14U3iCkYFukBYSmS3lOc3WBgXbwkK3f3kWOVSiV1veFALnCGMgNLvPVTleQAh6pDflYAGt/YQCTvMwsNWbnrsQ/DRi7PB/69wna9k+m7u/sv+9D2qyNb0kuMcr4XgyRW8hTOtGciQPkozbvBgD0JckNEyXaMRlVl2KjKRzdX0Smx7rFbD2EINV1TIsZiI0/W1XPiqdjfGwqiaiL/RQThJUyj6NgkW3JkHmIJ1q/cjvPufbwZD8L/lRAr2YVUiaYI78DYqMQtyUhHabZc/ilZ6NBMqKR5Zl6OJljvgxTozWY1AAyC3agqNbDJAiG3Lsf5YbAdlnK9dwUxyURH5GwbM0jdIVUd/QEjtQ5ip6u+FWd/ZE7tQO6XjZCm7NEEX0Ko/PFMfHw79HJx1rnHcu4FXjbZhYo4Kh5jK7D5AAczOLZUAY2Z/OK
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(10070799003)(376014)(366016)(22082099003)(56012099003)(18002099003)(3023799007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?URvNApLv/LUbRdl9Wj5s5hUMLjpFAIj7D9f3IVPDNjxIXWTCXKjmC5pX3Qfl?=
 =?us-ascii?Q?7mto68Ncwkk3b2TYcorb0MC4i3w9BxXicsr6RSwpZLRMvJrtM1xmYDpH530G?=
 =?us-ascii?Q?dwuKjf8tkdE5FU7gFXXGcsF+T2vFgfTnw9ByZZYIdcEZtSyqtob5wRIP7ONC?=
 =?us-ascii?Q?StYTa1jFmhZwkKEKa1sL4s2xfW8zUIqvrVEHDRuLIitbc0Gnd1BQHPftsTeg?=
 =?us-ascii?Q?/aRIF4WD038tMPom9yZjJOL1uDGeT8JXYPglp1jQfbEm0+Qw51nhJ/ht81c5?=
 =?us-ascii?Q?c+BZYQvZf3pbdML5MfdOjW6+p9HYEIG93i80OOtLroaif1bKpOTHiTLje+tn?=
 =?us-ascii?Q?Hw0aB5658tMo5emet1in4/cyRzIuC3IpTyg8x7n15Wc0PrW/Bt3wiRzAWBpA?=
 =?us-ascii?Q?LoJQfEK4XEARUIexOdtxksMjhuyL2NJo04hvp7/SSaCQJ1TmBTjl+V1wFAs8?=
 =?us-ascii?Q?C+kmA+TuOSViDc49p9Y9AIQSSRXcZUrk7fUC4Fo5xSuK4+jeGbaEOkpPgNHP?=
 =?us-ascii?Q?+bvESqABKiefJb6CLDv3DuSae5vxsocyKOmSPRj1KhueNkYWELOEqVkVuxGF?=
 =?us-ascii?Q?BNhoBJqc0yyiXDxlF1B6T/4A9YV5slH1Nv32qeihq9UX87Ux1RYe8L4TnCjc?=
 =?us-ascii?Q?WkKPje4AZvixtCpi8n/h/uHCSgSb0wZGiG7ZCxANfwvOdHMSdAKo45Mh28uL?=
 =?us-ascii?Q?I5qhiH++MIKYWPSUUX2yPWLt31Q6MdFvdnzHLGk0QuxSDA1JqRb16aAN4PER?=
 =?us-ascii?Q?AQPNuspDpV/kwTX4iMOXd5nE6/U5HH8/pJThjPQOnqwIY2KXVryD75DD+Zf1?=
 =?us-ascii?Q?Uj6ogak6oSdWwbycal35EzRjRyC6/gtpWtwyU3ObU7BL7cqJdmqIP9iMJq/W?=
 =?us-ascii?Q?Z+AigBQ4COGthWU17DF6WR9eNgU+bmFNWYbJUtj7Eu3Z1Wj1h0Hx0leS9Rd9?=
 =?us-ascii?Q?srx1Uo7UyzgrA9YBhcrB9I+SR4wmcLhyH6e307KAE/yLprbhmeaF0KhdfjFT?=
 =?us-ascii?Q?yZGK/6CIRf4aghJJqKKOZ1gAYXtieYxKwPz9VOsfVwNfe5WYoIs+iaMlyPSt?=
 =?us-ascii?Q?ji2RQfvLpDOSXOhzeGYR4/98mwnzTCdnOCBEcvonlR5t8j9tBzix2hIyao6A?=
 =?us-ascii?Q?MLFnH+QoxCiTvJpVX8Qrw9EG5mPuiB5Sy/W7jMeuz+z1GA7aYoTCbykrFcD3?=
 =?us-ascii?Q?KpQRe4UU9GM0PgHepbsECzXkKhjzV08VlWt997hqaWkeJ2SCKzjX1JUggn9z?=
 =?us-ascii?Q?Nds4a5Njh92wsS8p1nVAmxq5kiGUoF+kKUvCP/L0rwnzjLraUD4Ut8He0Aaa?=
 =?us-ascii?Q?d5p3I9YYA5XnYZs48hFWT0xcIzzjUVK3P8EbnBH8t26yBrg/rapjMcpYfwJr?=
 =?us-ascii?Q?+zH0ihhCoXn7Y0U2wF59jD7IoTMChR9tRYZm5xfwX4EKNhzDUTuo9NrBcT6r?=
 =?us-ascii?Q?pNAB7xGP9qbwxumClh+XROEnJREx2suEqGd//eD3lR6MLuhI5isOer57hWSc?=
 =?us-ascii?Q?fatNUnhcLviokoW4k5heQyzulI8XhrTwbUr8NiT0PPCFRvLMfApmDFnBqFAX?=
 =?us-ascii?Q?4FEWOntyKUU5UixNFaSkWgiROR1jaxaiIo+S6BLGSoJaIkmEI9MiVuCpceCU?=
 =?us-ascii?Q?pLM9Te/x885YFnTE92YXpgzvlTvFlahUnFNsfBNexYF61xEGjR7US4atH7Gp?=
 =?us-ascii?Q?zt2Fe+eE9XswEWK9C4JbMqODxUIS0eBowpFHyAto0rXKFv/ozSLNtNh0bCbv?=
 =?us-ascii?Q?CDHgMBP6fPQ3f7fLViOTVXtYUHVuZIK4u9BEwFZBhwYvrim6bqsS?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: 1654dbbc-c3d2-4bd8-1f63-08deba264e63
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 May 2026 06:24:42.0552
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ouKMcfjbcLTi3CgXyf7JQHXtONx+wqQ2tOE1C/BqgISlVXdM+yabB3iN/xAjd6v24CbY7cI80v8le6Pfkr+zIA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS7P286MB7796
X-Spamd-Result: default: False [1.34 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[valinux.co.jp,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[valinux.co.jp:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-10819-lists,dmaengine=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[valinux.co.jp:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[den@valinux.co.jp,dmaengine@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[7];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[dmaengine,renesas];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,nxp.com:email,valinux.co.jp:email,valinux.co.jp:mid,valinux.co.jp:dkim]
X-Rspamd-Queue-Id: DC8FD5C66FF
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Add an optional physical address override to struct dw_edma_block and
use a helper to compute descriptor block addresses.

No functional change intended. Existing EDDA and MDB block descriptors
leave the override unset, so the helper still returns the same
pci_bus_address() plus block offset value.

Reviewed-by: Frank Li <Frank.Li@nxp.com>
Signed-off-by: Koichiro Den <den@valinux.co.jp>
---
Changes in v2:
  - Refine the commit title.

 drivers/dma/dw-edma/dw-edma-pcie.c | 34 +++++++++++++++++++-----------
 1 file changed, 22 insertions(+), 12 deletions(-)

diff --git a/drivers/dma/dw-edma/dw-edma-pcie.c b/drivers/dma/dw-edma/dw-edma-pcie.c
index 8ba2b3917f05..c2be43170e02 100644
--- a/drivers/dma/dw-edma/dw-edma-pcie.c
+++ b/drivers/dma/dw-edma/dw-edma-pcie.c
@@ -54,6 +54,8 @@
 struct dw_edma_block {
 	enum pci_barno			bar;
 	off_t				off;
+	u64				paddr;
+	bool				paddr_valid;
 	size_t				sz;
 };
 
@@ -362,6 +364,18 @@ static u64 dw_edma_get_phys_addr(struct pci_dev *pdev,
 	return pci_bus_address(pdev, bar);
 }
 
+static u64 dw_edma_get_block_addr(struct pci_dev *pdev,
+				  const struct dw_edma_pcie_match_data *match,
+				  struct dw_edma_pcie_data *pdata,
+				  const struct dw_edma_block *block)
+{
+	if (block->paddr_valid)
+		return block->paddr;
+
+	return dw_edma_get_phys_addr(pdev, match, pdata, block->bar) +
+	       block->off;
+}
+
 static int dw_edma_pcie_probe(struct pci_dev *pdev,
 			      const struct pci_device_id *pid)
 {
@@ -460,9 +474,8 @@ static int dw_edma_pcie_probe(struct pci_dev *pdev,
 			return -ENOMEM;
 
 		ll_region->vaddr.io += ll_block->off;
-		ll_region->paddr = dw_edma_get_phys_addr(pdev, match,
-							 dma_data, ll_block->bar);
-		ll_region->paddr += ll_block->off;
+		ll_region->paddr = dw_edma_get_block_addr(pdev, match, dma_data,
+							  ll_block);
 		ll_region->sz = ll_block->sz;
 
 		dt_region->vaddr.io = pcim_iomap_table(pdev)[dt_block->bar];
@@ -470,9 +483,8 @@ static int dw_edma_pcie_probe(struct pci_dev *pdev,
 			return -ENOMEM;
 
 		dt_region->vaddr.io += dt_block->off;
-		dt_region->paddr = dw_edma_get_phys_addr(pdev, match,
-							 dma_data, dt_block->bar);
-		dt_region->paddr += dt_block->off;
+		dt_region->paddr = dw_edma_get_block_addr(pdev, match, dma_data,
+							  dt_block);
 		dt_region->sz = dt_block->sz;
 	}
 
@@ -487,9 +499,8 @@ static int dw_edma_pcie_probe(struct pci_dev *pdev,
 			return -ENOMEM;
 
 		ll_region->vaddr.io += ll_block->off;
-		ll_region->paddr = dw_edma_get_phys_addr(pdev, match,
-							 dma_data, ll_block->bar);
-		ll_region->paddr += ll_block->off;
+		ll_region->paddr = dw_edma_get_block_addr(pdev, match, dma_data,
+							  ll_block);
 		ll_region->sz = ll_block->sz;
 
 		dt_region->vaddr.io = pcim_iomap_table(pdev)[dt_block->bar];
@@ -497,9 +508,8 @@ static int dw_edma_pcie_probe(struct pci_dev *pdev,
 			return -ENOMEM;
 
 		dt_region->vaddr.io += dt_block->off;
-		dt_region->paddr = dw_edma_get_phys_addr(pdev, match,
-							 dma_data, dt_block->bar);
-		dt_region->paddr += dt_block->off;
+		dt_region->paddr = dw_edma_get_block_addr(pdev, match, dma_data,
+							  dt_block);
 		dt_region->sz = dt_block->sz;
 	}
 
-- 
2.51.0


