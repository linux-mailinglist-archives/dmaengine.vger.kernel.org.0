Return-Path: <dmaengine+bounces-12290-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id CdDiBW2rUGq33AIAu9opvQ
	(envelope-from <dmaengine+bounces-12290-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Fri, 10 Jul 2026 10:21:01 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 247C373860E
	for <lists+dmaengine@lfdr.de>; Fri, 10 Jul 2026 10:21:00 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=valinux.co.jp header.s=selector1 header.b=Z4r6snkU;
	dmarc=pass (policy=none) header.from=valinux.co.jp;
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-12290-lists+dmaengine=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="dmaengine+bounces-12290-lists+dmaengine=lfdr.de@vger.kernel.org";
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 7457D30357A8
	for <lists+dmaengine@lfdr.de>; Fri, 10 Jul 2026 08:16:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02CF63F39EF;
	Fri, 10 Jul 2026 08:15:43 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from TY3P286CU002.outbound.protection.outlook.com (mail-japaneastazon11020111.outbound.protection.outlook.com [52.101.229.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62DEC3F1AC6;
	Fri, 10 Jul 2026 08:15:41 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783671342; cv=fail; b=fQeUwPuqDi1dhNCyFYkiR2YYkmu4jbKEvd35tILP8jKuUl7nD+0TsmkGPPzSO9KjuKgZdu415JZl5MCMX2ul4dxe3MmeSQ8wSHYZidQNP0t6Hn0yBuhCBDyTjCsSqreNtFQr4aa1JydcdK1hyywygNn8+3a2yMztjvM1DatS984=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783671342; c=relaxed/simple;
	bh=svzBUK4SWZ1YQfHZcUORpl7kMD9bFJCDH8o3NmD474s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=tm9Udp95ASime85DdoZ7tPuqzZT1b5AYZG9tzeY0PCNrBwikNQu9j2s+JeCThrVCmWvAC0wJCWzcXOB6WQULjajoSn7S8O3VimREJ7TC9ZjkwVCuOGOSKZn3at2hCGkJGdXNWq7eU6UugUv/3qAf96VSdFUuYiyxtz5CyRuBlvE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=Z4r6snkU; arc=fail smtp.client-ip=52.101.229.111
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=u8zka7s3+HK9FVaKQ//wFf5uyt570gPn0yEtiLHRIZPUpvqNqNUuFSWFojzltW2+3eT95BvtaIMaqQPiDkEILIKe4lmqqmOw1p+gwXbnaFN9ONaKD3L3+04agMl6lTsVK9N3Z4q3rLpfzXxf4PHI41JlqWywMU13nvEBbN3ab2wT6gliA5TcB8C4Ck2Y6J7dpaOPyckPsg6wURoa192zs4wjrsPn/js62XJcaEJEeSk7O8TfWYBnFt+thUW8E66yt0C30TNKSASSfDE0UsA9Lcb7hp7ej8x6zAZOATPY+fxiaR1w2LvUhFV4Z43coW8PG5f9Jkscg3KS28WoXcauBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XF6dcmyUlKXXZ/5H+1koITrjHHfh8NP1BsDVXDdzpdA=;
 b=RerGhLgjMggCs8ES0ux2NPOHIulZyvPYSeiJY92lgaP/G7bQmZtg3dsE/S208eVx6ICZ+bGktHRFdsoKUIPN8CsEo7Bo7pFVFN5J8luHwC1C+Kd7Q6shZaOp+4BCRoUYTbdfgiiBcPEhqpY9itFHrDGfJK/deNDJZB92eK1XeSQ58p9fxceqJSwYASwdHZdKxsVyeDwE2oQCvrNQuJzvbxqgsOEWrZWpcxVu4uUz3Z+Ulkv6kMW8HvpcK895Bo/ddAoOo20rYwRY9D6iFduX2mK5N3w/BU2gaA5ngULppJX7POPKoYa5xp1sZWl+aprbwRNqFJK/VtW/oFhc3Nlxjg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XF6dcmyUlKXXZ/5H+1koITrjHHfh8NP1BsDVXDdzpdA=;
 b=Z4r6snkUdq+F/VZULHbDOSRDEVxbxs4sj2pEf+K5iGY/QaJ9X2j+TIRQ0GBwwiPkeB0nE+vuOs75cV4eM1Hrdi23/Hv9W5+rsgkhOhNevrElz1qhiNstmsPYMDhvp+9b2+y9Xnz2TQFwkayoDjHmj+0X8IijQXYuLgAaSXsyCeE=
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:38f::10)
 by OS9P286MB6307.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:409::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.15; Fri, 10 Jul
 2026 08:15:28 +0000
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32]) by TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32%5]) with mapi id 15.21.0181.009; Fri, 10 Jul 2026
 08:15:28 +0000
From: Koichiro Den <den@valinux.co.jp>
To: Vinod Koul <vkoul@kernel.org>,
	Frank Li <Frank.Li@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
	Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
	dmaengine@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v4 09/14] dmaengine: dw-edma-pcie: Add platform ops to match data
Date: Fri, 10 Jul 2026 17:15:13 +0900
Message-ID: <20260710081518.2394357-10-den@valinux.co.jp>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260710081518.2394357-1-den@valinux.co.jp>
References: <20260710081518.2394357-1-den@valinux.co.jp>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCPR01CA0138.jpnprd01.prod.outlook.com
 (2603:1096:400:2b7::17) To TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:38f::10)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY7P286MB7722:EE_|OS9P286MB6307:EE_
X-MS-Office365-Filtering-Correlation-Id: 11640edd-c1cc-4336-237d-08dede5b66e7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|10070799003|23010399003|376014|18002099003|22082099003|3023799007|56012099006;
X-Microsoft-Antispam-Message-Info:
	QzLoxglVvsyhL1esauohaZQxQx6eTHB3IwgTtJZ38Yo2CohS/CczfgeGEYw8s06iGmhwOHQhYhWE90DzT+R13gjOwDJ/o0WHWqNwwLRM5nM6JPfGEHVhy5PhxCoUKP6SrAaRXlSdAs0io7ZPUwJyOSRwi1uiAiLwepc1z54pdCYKmQE2wZ3wpEtL1X+mkzR9hdAXqZZU6T6yZKitxtRxhd8pH1WHp1Z8OxAF+jR+fk2RYLY44aQUHDgMfybdBBhDCtvXI2Sqyv8nKH39Eu2VJ1CRVst/grXwYhP7q/ulfrlSkwxjScDXxbjg2Knwtv+NU95KSRGEbkkqYTcYoj4Lst+rlioXlUYTjB5WuzZnkTYqkwJdp3miGnn8Zxl4n84UwG6L74+sv1mSXt+a7xFRQKkA42EBZcLSA+vfhz5M8d2P1s4d/pKj3gTYpjDyvlnQsDUtzoZhHlrdgMQkIAnOwsHPHLLd9yFbQN6Q5G28GNMhWImkvWoVQCWuQQt6llR7D9GO/4xnxJl/xQi53zyToWeqlg2Kzn8Ig2ndb/bmxd2cNJf1nylKPh6sqVVSBYqJJ95mK/Ipvdyz1hQ6WDszdBVfno8Jb8SpUzguL8xD6Bf+fVA83PrXKb/L631Qq8+ymaSsQpPEa0EOTQmDcRk239Xt4ZKwGzjRXEmySHzdJcw=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(10070799003)(23010399003)(376014)(18002099003)(22082099003)(3023799007)(56012099006);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?+OWvdARS5XEF5JYjeLkLUl5FDxBch8RdOiaVyNZT3qcaRHj/0/YTKDaijq1l?=
 =?us-ascii?Q?sjwsoX2BIKW9JsESfVVkfKplmNGJ7im3tpqYyks+5e8WCjKHs5WugRgd9Opf?=
 =?us-ascii?Q?ljuHML1ws2PkDYjj4vDY1qsM6jgz0LSBzUBS9ZqrobU0ndtkexereFJzd7IA?=
 =?us-ascii?Q?gAMWXIMtpvXdek9TYWVMSr6ja4BJlfk/l2j+ari/aipQfutGcX3lsa+OHG3L?=
 =?us-ascii?Q?WduSUoDAsOJqRs1rTWBcaIBgrOeXIrPJpU8xvBXjV+nvsH46SDkPd25U9Czf?=
 =?us-ascii?Q?fVSTw3XGXZGG4flu0SUyY6YDP0mEXAUqu9xCJ0GvDG0a4h1yb0g3Q+WxSkcH?=
 =?us-ascii?Q?Z7gbipJZe1bMaz7lZ/bxgZXPZ62k0WeRCSGUx02qGK92j4vW25d7Qod5ZD9n?=
 =?us-ascii?Q?xyjl6RKWcrBhKP4vAD84Lkd251qpmTvcXrxFUPqUapl9yCZwqsj6Z7+1t6N8?=
 =?us-ascii?Q?l/gHzRR+TrIcQ8+6IOW9MXmJlF//ooKXkjg1h0APDlBh8VoHFlLXwSwVQzJZ?=
 =?us-ascii?Q?ELACZeNF4gd/DpVJnPe8Wl42nk/8ngRKi+JfI4aXBTd2Gd5wQSq25a7fdd7/?=
 =?us-ascii?Q?GSHVF4F6aNhepDGiPAey83Au+XM9TDmQu1/kLpCiI8r4TqWbz5rbaO0lGnxp?=
 =?us-ascii?Q?DkihHPgiP2dkI6PDiXyiFx8mVjHjPf/miyEtvrnSTn/Ktf+1gqwtRNJGyH+a?=
 =?us-ascii?Q?p6X5ua0nmgDZiX8z8x6Eh+bd7YWuRHdg0PAi8NMAcXHFlOPv4kDK0Q0Pkck0?=
 =?us-ascii?Q?MoO6T9zLWctrP2hwWov7SHr4JcfqvcQS278fZugBEz/3FmSxB+TR8rFreAUM?=
 =?us-ascii?Q?/jRtEKJ6u29/z8qBo8wELQ4b/Faw0hKszxWHaVzXE4riawHcPfT4rFPJvd1d?=
 =?us-ascii?Q?0ikgi4cg/B4hwtAuIEwrmB10nwcIvH/d5EibvoYFefvHxfnk1Bwj43lvuS1X?=
 =?us-ascii?Q?o4I61CA/B2RFO+Dxim3xdeRFVUCgEr8YMaXxiIGFbUVPZ1XKhK8HYD2tloWS?=
 =?us-ascii?Q?jNP+Z16jh/U0uY260zIcNHEWLR/7pvoln3Oflrp64vYxPw7Da30WSt2tAPO/?=
 =?us-ascii?Q?l4EnbHmtCzgxKQXIO0T0Rvk9px9ZLWLtQlSXsZuF8Nz9jB/hw1t5sw2lHpY2?=
 =?us-ascii?Q?ukp6xGWTq7oP7ySjWiSdMUs4Sh+fEVUcT0dwsSX8raEJL30BzMoZmAIGILfk?=
 =?us-ascii?Q?J+Pa+rXcSIhOBki/GadDjwQ3SN/vVMq8POMgmKLtD891aOb463t35KtpSakp?=
 =?us-ascii?Q?9MfKu0qeM6J/h8N7Y3VukJAP9xJpLLRkD6znduNIZfaC4io4hX+IaDObkSST?=
 =?us-ascii?Q?VVsESr7Z/G+pQ3VIy4CzFtPvotF8h1Avm9kJr80QuA5qQC5ZT+SN/DgGlc0S?=
 =?us-ascii?Q?bZoEJftIbBvBn8Uezct2bdbaFI8qFmpk21UFYV5npyLY6GXoVMxGLLXXdOh9?=
 =?us-ascii?Q?f9lwCfb1mQXyQWQ/PaMZKA86nd3Nmjo9LXNOkCgRG1UaFJmQvKe4X+/al6Vk?=
 =?us-ascii?Q?6UDYpVVPqlZdKgK36dU15upxq6WLEbBMI4CTYVypWiLeb/KoxGSAbIgoEJHd?=
 =?us-ascii?Q?ChOg+KSCdU+jtmSqDWZIOC5nvpknYS1gIp7bFXNkRRSUzt/yuIab2psc4hQI?=
 =?us-ascii?Q?gzGrMnJ3ZSPG2/swKXeA5O8rkAxeD5Sp2LZohIJ08fTW69oh7T3teqRXNCF7?=
 =?us-ascii?Q?0yqOVT82gERtNmWmjEE8b2ZdEKnpWt2d4GArj7a7kko42GgXGdm0MQ0wfErh?=
 =?us-ascii?Q?dCJnzYyung95+EMQnxYVFoHupdKG1HwOL2Vi6dXyNjB0XfkqoNIb?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: 11640edd-c1cc-4336-237d-08dede5b66e7
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2026 08:15:28.3586
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wBY0CcAZQTwMq3SQMIT6pz0CayrpUJLVzKuKCre/T9GySV/JlEtfYWklLy49rKNOGvO/qz9bQN44cE0WDjqFqw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS9P286MB6307
X-Rspamd-Action: no action
X-Spamd-Result: default: False [1.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[valinux.co.jp,none];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[valinux.co.jp:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-12290-lists,dmaengine=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:vkoul@kernel.org,m:Frank.Li@kernel.org,m:mani@kernel.org,m:marek.vasut+renesas@mailbox.org,m:yoshihiro.shimoda.uh@renesas.com,m:dmaengine@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:marek.vasut@mailbox.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[den@valinux.co.jp,dmaengine@vger.kernel.org];
	DKIM_TRACE(0.00)[valinux.co.jp:+];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,valinux.co.jp:from_mime,valinux.co.jp:email,valinux.co.jp:mid,valinux.co.jp:dkim,nxp.com:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 247C373860E

Move the platform ops pointer into match data. Existing EDDA/MDB/CPM6
matches keep using dw_edma_pcie_plat_ops.

No functional changes intended.

Suggested-by: Frank Li <Frank.Li@nxp.com>
Reviewed-by: Frank Li <Frank.Li@nxp.com>
Signed-off-by: Koichiro Den <den@valinux.co.jp>
---
Changes in v4:
  - No changes.

 drivers/dma/dw-edma/dw-edma-pcie.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/dma/dw-edma/dw-edma-pcie.c b/drivers/dma/dw-edma/dw-edma-pcie.c
index 41ebe96ed31a..36b18032c835 100644
--- a/drivers/dma/dw-edma/dw-edma-pcie.c
+++ b/drivers/dma/dw-edma/dw-edma-pcie.c
@@ -78,6 +78,7 @@ struct dw_edma_pcie_data {
 
 struct dw_edma_pcie_match_data {
 	const struct dw_edma_pcie_data *data;
+	const struct dw_edma_plat_ops *plat_ops;
 	/*
 	 * Mandatory callback. It may leave @pdata unchanged when the static
 	 * template already describes the device.
@@ -403,7 +404,7 @@ static int dw_edma_pcie_probe(struct pci_dev *pdev,
 	}
 
 	/* Let device-specific discovery override the static template data. */
-	if (!match->parse_caps)
+	if (!match->parse_caps || !match->plat_ops)
 		return -EINVAL;
 
 	err = match->parse_caps(pdev, dma_data);
@@ -454,7 +455,7 @@ static int dw_edma_pcie_probe(struct pci_dev *pdev,
 
 	chip->mf = dma_data->mf;
 	chip->nr_irqs = nr_irqs;
-	chip->ops = &dw_edma_pcie_plat_ops;
+	chip->ops = match->plat_ops;
 	chip->cfg_non_ll = dma_data->cfg_non_ll;
 
 	chip->ll_wr_cnt = dma_data->wr_ch_cnt;
@@ -593,17 +594,20 @@ static void dw_edma_pcie_remove(struct pci_dev *pdev)
 
 static const struct dw_edma_pcie_match_data snps_edda_match_data = {
 	.data = &snps_edda_data,
+	.plat_ops = &dw_edma_pcie_plat_ops,
 	.parse_caps = dw_edma_pcie_parse_synopsys_caps,
 };
 
 static const struct dw_edma_pcie_match_data xilinx_mdb_match_data = {
 	.data = &xilinx_mdb_data,
+	.plat_ops = &dw_edma_pcie_plat_ops,
 	.parse_caps = dw_edma_pcie_parse_xilinx_caps,
 	.flags = DW_EDMA_PCIE_F_DEVMEM_PHYS_OFF,
 };
 
 static const struct dw_edma_pcie_match_data xilinx_cpm6_dma_match_data = {
 	.data = &xilinx_cpm6_dma_data,
+	.plat_ops = &dw_edma_pcie_plat_ops,
 	.parse_caps = dw_edma_pcie_parse_xilinx_caps,
 	.flags = DW_EDMA_PCIE_F_DEVMEM_PHYS_OFF,
 };
-- 
2.51.0


