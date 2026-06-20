Return-Path: <dmaengine+bounces-11652-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id QLcEE7THNmojEwcAu9opvQ
	(envelope-from <dmaengine+bounces-11652-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Sat, 20 Jun 2026 19:02:44 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A8F5E6A9473
	for <lists+dmaengine@lfdr.de>; Sat, 20 Jun 2026 19:02:43 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=valinux.co.jp header.s=selector1 header.b=fyMaOsPu;
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-11652-lists+dmaengine=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="dmaengine+bounces-11652-lists+dmaengine=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=valinux.co.jp;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 474783037E69
	for <lists+dmaengine@lfdr.de>; Sat, 20 Jun 2026 17:01:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FD0425B086;
	Sat, 20 Jun 2026 17:01:05 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from TY3P286CU002.outbound.protection.outlook.com (mail-japaneastazon11020101.outbound.protection.outlook.com [52.101.229.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C0B918A92F;
	Sat, 20 Jun 2026 17:01:03 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781974865; cv=fail; b=YpuhCbB5Xc/shFtYolNnsTrRi/GrOR6g7zIwwn4RlxiShE2+sD4UA6k3HWToACdvYxTGkhF7qupXB/zJOyvyP2o4pUowWhSn67gtXdweYyW2fITfuGGGdbccoBotq5ksJW6BPBjBDTcjCvrv+uMRDA7VmcJmLwDBZhzEoeGAp4w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781974865; c=relaxed/simple;
	bh=ORKMZCHPZe62yFdUKSiLEfTPEa6tu54o4HTp98PdUNY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=R/i0BFadVYhQMFpuWO2phZTo8rbCSZsOM9/j5i6rDah/k1N7uHNN2QUUdjHOC54xq2/+zk1/loDCi7HbmR2Yh0p/H9g2uhGviSU5FwfvyqubHAZJYAzdzYjGxIbIf6ef6wI94p2ii37GvLrMQBPn+mZxy/6xFpF4D3//Qwqylxg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=fyMaOsPu; arc=fail smtp.client-ip=52.101.229.101
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OYhdFG5jYF5k6NBYluzOngwTAxwcucyYBsyGFUV05aU/FqBURIETwhts/a3U9SD9y8xwygavfYzBnKohS5ngSXUFAh0Uscdodr+R4b5CYazk3y3i3HjIwRKW5fb5QMI5/NbxGZ0ipLjSobIErifWHlLpYOqYh2LP+CeZ4gyWfvSuetz6368jevaOE7X7oXUnp6oxwRZDUvf2LUPJQjlDW15XkYvq+a5ihUKjfYVcR7X/GUmFZnJrOt3OFFKfZIhSoSCEUvq5C5kf7B7+tGvaQtPYnSQ76pcX99G4fpLgm2IMHI8EvhFfaxjoAY+I1994Ovk8QjhnXgf2na4+GBLgtA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8biCTpVzkfz/iF/Z/Xbdk7bc+O3CC1TrsQafh12nMSo=;
 b=A501Psa23gYVhb86x6uz7yXz5EVqZrocUIZBvN5YSBvqBVFcAqMSLZeaQHszifwh4txF0GHGKTAnYCaT+Oo+SGbCtGPExC8d+pU5N9vyb73WtX1DscQTFLtD+3WZoZlcNCUFm7VC2rOmyx71RyaSe1zz6PSZbxM01ZaaS7sO/K3X7lpgnniCQFoKwBsW1oU2U3xGsPsiJw45najf1kIj5tjVeTevMKT2DWeJWlAAi7U3/TdY7EC+MGoExwiBGWEZFRr8/WdNwTfnvOd2s2kGyiz8XMsbmkhl1NxmzYKnY2CRz2xnQon9SAJnf3g1t4WbW8K9F8XC7cNconMM4mA3bA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8biCTpVzkfz/iF/Z/Xbdk7bc+O3CC1TrsQafh12nMSo=;
 b=fyMaOsPuj0T8po9YjPZy2mxtwSgndJgAxRFNp4VaHVfZ9ce//Ocs+Ctuu1MsYsL5w86WTXWqLMe03gmvnpscQ1PSE24BM37mqn54wJgp1903E0smgoHtnihbPKQP1C9pAVgHIAMW/YyV7Vb5996v+BZMfCUTF+sO5xGEFREbOyc=
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:38f::10)
 by TY3P286MB2673.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:254::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.13; Sat, 20 Jun
 2026 17:00:56 +0000
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32]) by TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32%5]) with mapi id 15.21.0139.009; Sat, 20 Jun 2026
 17:00:56 +0000
From: Koichiro Den <den@valinux.co.jp>
To: Vinod Koul <vkoul@kernel.org>,
	Frank Li <Frank.Li@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
	Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
	dmaengine@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 04/13] dmaengine: dw-edma: Initialize IRQ data before requesting IRQs
Date: Sun, 21 Jun 2026 02:00:31 +0900
Message-ID: <20260620170040.3756043-5-den@valinux.co.jp>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260620170040.3756043-1-den@valinux.co.jp>
References: <20260620170040.3756043-1-den@valinux.co.jp>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCP286CA0055.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:2b5::10) To TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:38f::10)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY7P286MB7722:EE_|TY3P286MB2673:EE_
X-MS-Office365-Filtering-Correlation-Id: 0e1e5b58-7948-4522-8012-08deceed7f0f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|23010399003|366016|10070799003|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	x1TyLUrhv/PP8ARdW3DeT0+vxGhviy0v+yKMsIoS4XD9Ncu8FiaMEwOw75zwWCqMqoEx+5Do32wlBjq7qAr17uepuOCJRnyO0RYVvfmqm5BLL4a1e4PQUi0Xl4XMEo+wyf524UkvRKlgDR+qIQp07MUz/gl1lGW7/HhEPYAGX8Ox2aaISao2P7YqDTQwOszKy3e/DcpQGtMBFvgrbHL0+K91JTO4HD5hAjlIyvPZ7ZLQVCw24/SfH0dV0vXBRtMtS5A4Rcr8/iEEV+oiyQdFvcLPuwz60tstGgLPXSylWTUjWLsyL5LqRsbDqdzLlfZxS1JR4UKMfI9+qWLUh3v+fwwFdW9A8WD/WJMX9uVZm9bYQRZ/n0w/BQCZLoHZefj/Vfo2cJ7vzsclDmdUoVM9X1ilSCjy+zJwR3ECcc5OsesRf5lq1g2CyDPPK5Y+ncWU3IKZ9Ou31SVZsBZgJY7+rHj1DoaGLP3Q0BCiVSHxxuoz9AeJXXEi6I7UZGZY9xAB9Dfe1VfgdeRLV2/2vq+gLTGVtXRadyWNguvIF/Qji8d8e62NdXcVQzgYX8XpP7Uc4gJ13d19Q9Dxfqcj7CeNn9YNcQYzhBi6QJGXmvhahOmGjQp/pGF4sePLCfzluxYPnwerLm+y5OYAGPrvyw1EUhY+mQyEJlVkv2xToPGsNpw=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(23010399003)(366016)(10070799003)(56012099006)(18002099003)(22082099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?QNGk0r17LZcEW3BP09AlCM9eX9wGDsOyxHV8ORzY46XwTcfvpxtF2aISq/Fd?=
 =?us-ascii?Q?gd1drl8px8BbVZmHL3lv+x3q8JOfzYBwavNKS/687bgfa4HTGYpflUtRybbW?=
 =?us-ascii?Q?LS5gMOpT0H+MRP8qbm5KsoeJEuQA5zhmk05Gs7gnqjBYxetubuR3rQ5vIIDp?=
 =?us-ascii?Q?zSxwRG/3b9kz981CgoOcu5RwBu64DE/MVFqPYmGH1XhMJ6RTEBvV+HUyFQXa?=
 =?us-ascii?Q?fyT4S9+7UCxqE2GnZqU4ynm+A4kgSCqPTtZSKz8G07Z/V+S5QabD/QWY/LV5?=
 =?us-ascii?Q?bVmll8VodMglgrqGpPMSqOphfRFJCV2fQ3lId9r7M1akCUP6tpkmEMFAnVmd?=
 =?us-ascii?Q?H4fPSghopsNYQZuVczmgHRr06MA/CsYhFFRRgC/vB7nobj+XVDJ9+NBJM5o8?=
 =?us-ascii?Q?yyXwD63Tnk8VETP9b8xZ8WREZ++mnBceLhpXL+L02rCaPdTO8pGufXbcZmND?=
 =?us-ascii?Q?SNz/Y79VqZ68owEFFKUdxqlIobt7loDKuvpNjw+x6YIdCHkJCXg0d3/r66S/?=
 =?us-ascii?Q?98gqJLZ/dkF64GRGTvhyaRnrjG+OsYoE0xp1pbsw2IBGmLOY00OueVejnWur?=
 =?us-ascii?Q?OHhAZGqlNWv8Xp3huj8a6FmO+qvK/ZeA6MWLZDb4+XvmCjz6EcIixXE9cjGq?=
 =?us-ascii?Q?6oL2G86YXGBN5XXvGM5Xak0YA+l5A9nNf17QjbW29bdRYOCfePYpjP79M7Yq?=
 =?us-ascii?Q?Y2icohqiA1kza6IU0T1vfR1SCkVPgNMaFWCAEbtQ8cdZ0H1cTu42dqJtDe2M?=
 =?us-ascii?Q?kHAsu3otT8GtqKxVj1qOcEZZeqiKSMKS1DxDA8p1Xf9d5zlIk+/nKFBE4mVE?=
 =?us-ascii?Q?HjMyQ9NxYkhDVvAN9yZMBZN/gCUQRMt+lC7XH774w7FB8c0qbq2X5j5ie53C?=
 =?us-ascii?Q?wDMkzHb6+oMxgnsoSoQ9H4WShxVBJ+7DDT8EOo8NInOXkMvkSQYpNL6ckH++?=
 =?us-ascii?Q?iNJOI2HtppKKg3sI8ORbLrR/Ey3AGNBno1apD3MEriOvbu4MrENfQ9km30A8?=
 =?us-ascii?Q?lYFtu9mbsQhGtehO8qMwz757GrNBCAPb0krrCeNy3Tdayrl4S658FWGRMNoB?=
 =?us-ascii?Q?qYRmYSQzZFm1vp2GTZlH+aivIqa86Q7VfMCiiw+A2gFf7hxhoApzUwKsPvML?=
 =?us-ascii?Q?/mUKUI8N3GvoEC6EsYocS4HkYP3tpXQbOzx7Pq+/wNkFkeafSWOi3U8LhHSW?=
 =?us-ascii?Q?RdbbK3bfum4FWSPosToFvLBx0DdiykdNJLq4wonzZaTpBu/6ZeOYrnOU4DFf?=
 =?us-ascii?Q?QFbXkMIihtGJ+oWYERJTM174b19Ck7tH1wlkfu9Y/WiqF8v8R7Dk57UgKUq/?=
 =?us-ascii?Q?YtN/qLDASRsdDUhghXH//txNaEYUOWPITDZ+z7kDIYDtCrQlEgfILb8FXtup?=
 =?us-ascii?Q?xIvpsy+YGpvuiJykh+obAC7KgnSM4TpR/VcBLfZJvAa1bl/INkk9C6vnmp7+?=
 =?us-ascii?Q?WZE/LLyiEIOo5wBowFb2aGGn9TtZjoRjBvoJ8KJflDPVNTzZTCjCt5HDK1zO?=
 =?us-ascii?Q?DeKxbysZLPvsNChQuVzGP7ZBGK51iKB3zloj1yGCJiDh3OTdMvKGAFkEOgby?=
 =?us-ascii?Q?vbIbS3EnPXGWAbv/dZW0CAXEjUMIm3pCHbbd4S5lcKACNy93xyyqUZxKjebr?=
 =?us-ascii?Q?dX5uXoT7ibs64ErJsHk7H3aZ00BvPI9dGGwChO29eSdmgjrghDWrUcg2chXd?=
 =?us-ascii?Q?BF2J7xeSIg5Mh9ox0d9suTmOD9EAxEfbyGv4sffrwBH8Zfox820Ivdbb8S+Q?=
 =?us-ascii?Q?lgtBgSCnkHpKm9R0HenQQ3w1ApD5W7lPuzyn8hpcQC1iN//YjTua?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: 0e1e5b58-7948-4522-8012-08deceed7f0f
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jun 2026 17:00:56.7894
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YaiWK2oDOnjtlCTy3kJgiTIDtTHaBIhXsivp68Rwl2rwZ0Vqdf0ztwvtVfbinoRCM9tQEzNg4VjPaZdTEmaDQQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY3P286MB2673
X-Rspamd-Action: no action
X-Spamd-Result: default: False [1.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[valinux.co.jp,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[valinux.co.jp:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-11652-lists,dmaengine=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:vkoul@kernel.org,m:Frank.Li@kernel.org,m:mani@kernel.org,m:marek.vasut+renesas@mailbox.org,m:yoshihiro.shimoda.uh@renesas.com,m:dmaengine@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:marek.vasut@mailbox.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[den@valinux.co.jp,dmaengine@vger.kernel.org];
	DKIM_TRACE(0.00)[valinux.co.jp:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[valinux.co.jp:dkim,valinux.co.jp:email,valinux.co.jp:mid,valinux.co.jp:from_mime,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: A8F5E6A9473

dw_edma_irq_request() passes struct dw_edma_irq to request_irq()
before dw_edma_channel_setup() fills the back pointer. A shared
interrupt can therefore enter the handler with dw_irq->dw still NULL,
leading to a NULL pointer dereference.

Set the back pointer before installing each handler.

Fixes: e63d79d1ffcd ("dmaengine: Add Synopsys eDMA IP core driver")
Cc: stable@vger.kernel.org
Reviewed-by: Frank Li <Frank.Li@nxp.com>
Signed-off-by: Koichiro Den <den@valinux.co.jp>
---
Changes in v3:
  - Reintroduce 20260521142153.2957432-4-den@valinux.co.jp as a
    prerequisite for partial-owned probe, which skips the core_off()
    reset that previously made the early-IRQ window unlikely.

 drivers/dma/dw-edma/dw-edma-core.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/dma/dw-edma/dw-edma-core.c b/drivers/dma/dw-edma/dw-edma-core.c
index ca0504eac1fc..c782eaa12021 100644
--- a/drivers/dma/dw-edma/dw-edma-core.c
+++ b/drivers/dma/dw-edma/dw-edma-core.c
@@ -943,7 +943,6 @@ static int dw_edma_channel_setup(struct dw_edma *dw, u32 wr_alloc, u32 rd_alloc)
 		else
 			irq->rd_mask |= BIT(chan->id);
 
-		irq->dw = dw;
 		memcpy(&chan->msi, &irq->msi, sizeof(chan->msi));
 
 		dev_vdbg(dev, "MSI:\t\tChannel %s[%u] addr=0x%.8x%.8x, data=0x%.8x\n",
@@ -1024,6 +1023,7 @@ static int dw_edma_irq_request(struct dw_edma *dw,
 	if (chip->nr_irqs == 1) {
 		/* Common IRQ shared among all channels */
 		irq = chip->ops->irq_vector(dev, 0);
+		dw->irq[0].dw = dw;
 		err = request_irq(irq, dw_edma_interrupt_common,
 				  IRQF_SHARED, dw->name, &dw->irq[0]);
 		if (err) {
@@ -1046,6 +1046,7 @@ static int dw_edma_irq_request(struct dw_edma *dw,
 
 		for (i = 0; i < (*wr_alloc + *rd_alloc); i++) {
 			irq = chip->ops->irq_vector(dev, i);
+			dw->irq[i].dw = dw;
 			err = request_irq(irq,
 					  i < *wr_alloc ?
 						dw_edma_interrupt_write :
-- 
2.51.0


