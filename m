Return-Path: <dmaengine+bounces-12189-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id MiQ5H5GsT2opmgIAu9opvQ
	(envelope-from <dmaengine+bounces-12189-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Thu, 09 Jul 2026 16:13:37 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 3619C7320DF
	for <lists+dmaengine@lfdr.de>; Thu, 09 Jul 2026 16:13:37 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=vivo.com header.s=selector2 header.b=KM3pOrjc;
	dmarc=pass (policy=quarantine) header.from=vivo.com;
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-12189-lists+dmaengine=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="dmaengine+bounces-12189-lists+dmaengine=lfdr.de@vger.kernel.org";
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id AEE1C305A4B9
	for <lists+dmaengine@lfdr.de>; Thu,  9 Jul 2026 14:03:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27A684302EA;
	Thu,  9 Jul 2026 13:59:25 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from TYPPR03CU001.outbound.protection.outlook.com (mail-japaneastazon11012065.outbound.protection.outlook.com [52.101.126.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5ABF842DFEF;
	Thu,  9 Jul 2026 13:59:23 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783605565; cv=fail; b=I3ki4bZIBs6kMQRD9GHhQK5BT6tP7/LmY0YvBGsJrBfXaa4nJPDtEB6f0DzppyFAidqMCwgnS30Ys6Mxdg1HW5u6eSnTt/0FVDA2yav/9F3lqZMpUSlNVZ5XA+WBDEj1wMvt4J+V5ZmC4U46gO7ByLtHgKppHbLTJPZ9zsqLreI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783605565; c=relaxed/simple;
	bh=ROQj0/oWC9ntpA2PeWn7G2oTZ9BNkkceOoSiJpUHnqk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=RvOV9v7PdpY7oXJKFoaHSRKX9iYuAlFxksMLyndaCao0fgmhi3piYWZnVDpNn0nqGrA96pUuqOUS7ZNlP+tburBINkOZBiC4ZD6x1lg+3yhefZI3MszJguPppTC7r+BSw1RRuu54D9VOBd4KR/4SfU1Q1wQssDNi4djpbFMm7k0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=KM3pOrjc; arc=fail smtp.client-ip=52.101.126.65
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GtQzmpMrDTl2pilOTjGDBhPfFU0yLiWfY3XlMQRwijyKhINIpMDMj93zK59fNBLHQdTEjd9CCFKgBTz/b52OZiwYQjWp7yodzc93kQLHJ0P2bu8GoIlN/C0kfmSvcVvaGg1pJuwCpi05Ahaldle341rDFSQ1LJ/NBlgMT+rVuZRkOw5x0/A4VYn9N5K/JyoRBvEmSKdB+aeTETkl/QB3h/6rCd3iGuOw32diNvLHrH5iIi/P6Kj1KjHbmZtdaXkiZpPmU3uiGUu8fD4vW97fTBRiKzHXBWu+CPxoPO2MZG01+kwxGEfAxQWuO9/FBsQ1R/N/iKMha3gI7LNRsE7GFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=u4QxYqPU5q5nOslPWoY39WyLymKSQMRvm1rIoPjECac=;
 b=wpONRZlDFFbgjpeHjDQ5mRv/i1o+AwMoCwxcoizctlWGk2K/x7HkFIuordxoYzGUNXx4CsuGU3hT8uGS9NWo559nW2+pTQZM8cOo6FeEGVUIrcvEbiUUwWVZUO16navSINy6rp4U+CukBcl40IkqpzFhgtWg+fZbPbsaSBLtiaUUoPELIdyxJGqvFCdGwv3/rsJDnnKIN6qULFM21wFMX1NKhAvMMmtuLuXdyR3qT4qsOEQ/ZqNh8aUG/ZT4DHHt7hnX6y/YthEkQJveSDpvv4HfiDxqj+2KIUYx5hIGtTMaxPDmWDWKR7RMzC4UQmYakl7s1t2wEWKH0c4O11x/hw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=u4QxYqPU5q5nOslPWoY39WyLymKSQMRvm1rIoPjECac=;
 b=KM3pOrjcSpaE/sIldNbkJodJYwt1YRi+85XpuOZkb1Ae/856eBY8GDtBZhO+5g6G6fvbP4clvglZ761JuBjcDfK1ZNLXlKK/7RA3YF0mai+wBA21n6I/DFsNuYrD7UK0AdXlrFC7n5lIJDgQ8CeCpyJ5aER3UZZIr1BYw/Wn+uR38IrIL4b2Evj0382ss1fhziRTQAusUJM9qrDDGjbzKUSAWSyCkhVkBax7lpuDzcf+GrUj/ZHlTw+/O1Bgw8eIVrV0l7tnSwKVetdDMYBfPxAOSdi5kOZ1v48QrbIXY6bA08TupGBsXkCpO/HfC6870+20onWGIFF4gVaiMy3aaQ==
Received: from SEZPR06MB5832.apcprd06.prod.outlook.com (2603:1096:101:c8::12)
 by SETPR06MB9093.apcprd06.prod.outlook.com (2603:1096:101:318::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.15; Thu, 9 Jul
 2026 13:59:20 +0000
Received: from SEZPR06MB5832.apcprd06.prod.outlook.com
 ([fe80::f98:5e32:4ccb:d07b]) by SEZPR06MB5832.apcprd06.prod.outlook.com
 ([fe80::f98:5e32:4ccb:d07b%6]) with mapi id 15.21.0181.014; Thu, 9 Jul 2026
 13:59:20 +0000
From: Pan Chuang <panchuang@vivo.com>
To: Paul Walmsley <pjw@kernel.org>,
	Samuel Holland <samuel.holland@sifive.com>,
	Vinod Koul <vkoul@kernel.org>,
	Frank Li <Frank.Li@kernel.org>,
	linux-riscv@lists.infradead.org (open list:SIFIVE DRIVERS),
	dmaengine@vger.kernel.org (open list:DMA GENERIC OFFLOAD ENGINE SUBSYSTEM),
	linux-kernel@vger.kernel.org (open list)
Cc: Pan Chuang <panchuang@vivo.com>
Subject: [PATCH 11/26] dmaengine: sf-pdma-sf-pdma: Remove redundant dev_err()/dev_err_probe()
Date: Thu,  9 Jul 2026 21:58:15 +0800
Message-Id: <20260709135846.97972-12-panchuang@vivo.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260709135846.97972-1-panchuang@vivo.com>
References: <20260709135846.97972-1-panchuang@vivo.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCP301CA0073.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:405:7d::11) To SEZPR06MB5832.apcprd06.prod.outlook.com
 (2603:1096:101:c8::12)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR06MB5832:EE_|SETPR06MB9093:EE_
X-MS-Office365-Filtering-Correlation-Id: 1cc263d3-e6c3-4dd7-e509-08deddc24604
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|366016|1800799024|376014|52116014|38350700014|22082099003|18002099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info:
	lBk7nWUSov4K1PWb6qRAV4XVfprzZovJqxpvnTpCgVs2Mqf661FRHtkAxVAq7lZrlefTqrS7g0loa8TJxK9UFPzZ6/OP1B6iDL20qmYQLgsZXX0qmU7wHkWLwF7pk+0U5Aw046zjUYcg8WHVH+/zs7kLrZXAYWGRkiSttCxS90nX0v4fgLNryH3e9Nu3oHIEIQiwsPT0n/YtpeM/zIWWBw2ImtPrBNd5u43DoBrZs+ucnS7R5flYhaUt+R7NDBIP4UoxVH1rDaZ+yxu1PuXa9iTN2qCTtlRA5ArIA87vFRd4IeQK3VbhzCuQ+HdckWfhGvt4IrQomLDQAvpaNnwkWGTlR+bFwdzbBXfqwWRfTSkkOIAOv0NcnwTsNhPZ5cyna9+UqRUSKWr4CabsYaLkacU48xtdYIK0/bnRG8GeYqzctKf9MPfnULzas/m+NkUUjT4EddK8KDNc4J5Ou/4rWgN2/YJfSJV6drH9n+iH24FUnAmPuzSmMQrk0zOLydFpfAWS4e+Ezkkb5b7gaAzBroUklkSGCifYfvM5sC4INEGuFVC4zPAzfqy4wMSXR+WobTOmXggNzjJRo7tGIQZ1BvuYaTlUGsIa5fW2LGo2+srz94MC6QP3MJ8yE05pF2evPnOzbYxSzW0bTDl3itS8agU0gpG7YscFpp9IPnjZTeZnuB4JQnJ8YqaMtR9N//7L/JvmfzMGX/H2PfXA8lh4Nn0a0d1qoWrYpoVGkHh/xZ0=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5832.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(1800799024)(376014)(52116014)(38350700014)(22082099003)(18002099003)(11063799006)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?BZ3Fm8unYBySXCd6zoRJ/EoZHOoSJ8HFcfrrr2JRmqlxHWMYksy6AObt9Sgg?=
 =?us-ascii?Q?kdZFb3gbtxGvAWAV41AhG4kwvtfLwI8oVlR9cfaS+VJhwW4z93IgNBsO6qK2?=
 =?us-ascii?Q?2f/Ph+tX6/AS1zqZIXz+hqC2leamq6fToIRc3o2g1GhnRVfDrZ1iqLd0VVDX?=
 =?us-ascii?Q?WqLu618/UVdL6waY49rKtxdcy3GBivAlgCFun88kVp3f6JamjVPzuFrD+4kk?=
 =?us-ascii?Q?9iy8D4V36r3XW4a1l7JSTLkvPNFaPFaFmXRv/U4eCs89eNSY/3MyEKDMxmlT?=
 =?us-ascii?Q?TWcJc313T8zAfeY7bXOEzuIybhozTEcIL0wYToiaDeP04MvJGGmikf6D2Rkr?=
 =?us-ascii?Q?+Rps4dZ8MIUjPkbQDI12sxk8tRnN6F574fU9ZRp280LcUjWUq6Bh4vV2/dzt?=
 =?us-ascii?Q?Jc6Bl5vxAUFFn8PNozqqldlboY3k4yIeNEFLWo9neIzowA0gLLjpcGJ+p3nH?=
 =?us-ascii?Q?NS6cFhAWjtT3+MAa6IgmasLACuUtumgQQJ1+X4txpq9BLjIvCOIF6RH1gwfR?=
 =?us-ascii?Q?zng3Xj0lJ74hBVgcut2hTNaUzsqvSw2lwP/RmHZpQQGhr+CizPDjjVP7k/lr?=
 =?us-ascii?Q?7x7yda5trnmQmLnYV0CCXN4hZwM9R5cCMaiDvavcUPnMhH+EXAhwvjIkmNd9?=
 =?us-ascii?Q?B2Zzj4p7dKua/UcT7yDcwoJYlHCCQOV78ndf/Ncwezpod4jgi3Nrgk+owsOb?=
 =?us-ascii?Q?t7PxjuPUwxKPf9amXEeyG4tGs4nVgHOQ7ip2EmPHVYU/jW0ESZGPdegBqUxf?=
 =?us-ascii?Q?g7NkyIM+diCPHSwCJ79lkaBEmIiRCdmpyldagtP+qgMLQKn3CNglQzLt0pUh?=
 =?us-ascii?Q?gojLX3bWz/Y31rK7VVLDqTdDd3L/lzdjV70pOXi/+cdjWmAvQ+LsJVrcDqtN?=
 =?us-ascii?Q?ioTU/xG16JRJ73rcY658+46dv6dWvceo/RVnAuwbWrP+KZ/aaYkjrZDu3Rqx?=
 =?us-ascii?Q?qiHQVe6sNW/hwyiahSn1olGJyHdnnTFd4a18+83XubzRlgWEkU1FrKlap2OH?=
 =?us-ascii?Q?Q/ooaw3+rnc+yGvzs2BjwG1msNF2gKFJNAFA4GT31/2kE19KIF7f67ybo55U?=
 =?us-ascii?Q?yxB5+UclAhw1Tktz2KjAqWQG+8652LNbG2UamUjmnQPu30Odwkp5AJ5lK8Jr?=
 =?us-ascii?Q?VencfMEw9V0byGbvkcWHIqAZWoMjQ1ShWbE1bZ6E4eb2f/icgF7L49RtWoc5?=
 =?us-ascii?Q?YR371MJ8Qo6THYgbflWD6aSEgQPpD9IZbxIDFNZCrc4v3o21QRNEZjKV3J/e?=
 =?us-ascii?Q?1tdufG2TxrSsI39fR3IZaMRhzzUZQQWtzPemnZIcdkQ93N6VuXnJWNNK6sU4?=
 =?us-ascii?Q?aSwmJ+LFhRy7b5IhV90aV16wFeORHn5vHbFFJyOV5Xq8bUovJ1y/KBa7CkjS?=
 =?us-ascii?Q?KOv/qYACPwLwuM710POKQ5y9F4U24viy1fCtYTnR+48nHXD4+ZkpYgW4pB5Y?=
 =?us-ascii?Q?S1M7mcbagD6sKR3ypLFjy18LG6f21bLbKYg0GUQBEmlFdW47vEFXwWUr73UN?=
 =?us-ascii?Q?V9Ij8bUO+vjAbcJTEcYvSPlwOUYccm3R2G5cQQCgcjcoYlGVeLoj1dTVmwFF?=
 =?us-ascii?Q?2P1aoYHXdmUbA95gdZorijEqFeC5JzO3s2npP7e+mN6gdCt085jnh7cK2WTw?=
 =?us-ascii?Q?i3Ljie+shdoZ7FVyTs2F8FNUjZaMTA0v0q1duEkZXpGcfYzlEcUhNgCK8iwu?=
 =?us-ascii?Q?TRBWz8ECf57qESL25UpDXYAmtkfZOcX4p5Ai43GXkYWsjKiszVX/rENbv1uo?=
 =?us-ascii?Q?+jCsdteB4g=3D=3D?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1cc263d3-e6c3-4dd7-e509-08deddc24604
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5832.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jul 2026 13:59:20.2828
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /Q5jWaqjAuJRMAYbnSSUPRVZ5ySKtfru3GW/Yc0gP08ctKSYe0DS5lGaGNrMXmYqk9HTjwKA+QZ9POKbNYd/tw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SETPR06MB9093
X-Rspamd-Action: no action
X-Spamd-Result: default: False [1.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[vivo.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[vivo.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-12189-lists,dmaengine=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:pjw@kernel.org,m:samuel.holland@sifive.com,m:vkoul@kernel.org,m:Frank.Li@kernel.org,m:linux-riscv@lists.infradead.org,m:dmaengine@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:panchuang@vivo.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[panchuang@vivo.com,dmaengine@vger.kernel.org];
	DKIM_TRACE(0.00)[vivo.com:+];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[panchuang@vivo.com,dmaengine@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[8];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[dmaengine];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vivo.com:from_mime,vivo.com:email,vivo.com:mid,vivo.com:dkim,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 3619C7320DF

The devm_request_irq() now automatically logs detailed error messages on
failure. This eliminates the need for driver-specific dev_err() and
dev_err_probe() calls that previously printed generic messages.

Signed-off-by: Pan Chuang <panchuang@vivo.com>
---
 drivers/dma/sf-pdma/sf-pdma.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/drivers/dma/sf-pdma/sf-pdma.c b/drivers/dma/sf-pdma/sf-pdma.c
index 6f79cc28703e..5e5694750c57 100644
--- a/drivers/dma/sf-pdma/sf-pdma.c
+++ b/drivers/dma/sf-pdma/sf-pdma.c
@@ -411,10 +411,8 @@ static int sf_pdma_irq_init(struct platform_device *pdev, struct sf_pdma *pdma)
 
 		r = devm_request_irq(&pdev->dev, irq, sf_pdma_done_isr, 0,
 				     dev_name(&pdev->dev), (void *)chan);
-		if (r) {
-			dev_err(&pdev->dev, "Fail to attach done ISR: %d\n", r);
+		if (r)
 			return -EINVAL;
-		}
 
 		chan->txirq = irq;
 
@@ -424,10 +422,8 @@ static int sf_pdma_irq_init(struct platform_device *pdev, struct sf_pdma *pdma)
 
 		r = devm_request_irq(&pdev->dev, irq, sf_pdma_err_isr, 0,
 				     dev_name(&pdev->dev), (void *)chan);
-		if (r) {
-			dev_err(&pdev->dev, "Fail to attach err ISR: %d\n", r);
+		if (r)
 			return -EINVAL;
-		}
 
 		chan->errirq = irq;
 	}
-- 
2.34.1


