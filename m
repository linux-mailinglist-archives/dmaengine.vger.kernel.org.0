Return-Path: <dmaengine+bounces-11654-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id dcd8EujHNmovEwcAu9opvQ
	(envelope-from <dmaengine+bounces-11654-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Sat, 20 Jun 2026 19:03:36 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id AF0AB6A9499
	for <lists+dmaengine@lfdr.de>; Sat, 20 Jun 2026 19:03:35 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=valinux.co.jp header.s=selector1 header.b=ndhPsFgd;
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-11654-lists+dmaengine=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="dmaengine+bounces-11654-lists+dmaengine=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=valinux.co.jp;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 58956304549D
	for <lists+dmaengine@lfdr.de>; Sat, 20 Jun 2026 17:01:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A88A525A359;
	Sat, 20 Jun 2026 17:01:07 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from TY3P286CU002.outbound.protection.outlook.com (mail-japaneastazon11020101.outbound.protection.outlook.com [52.101.229.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD3BA25A645;
	Sat, 20 Jun 2026 17:01:05 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781974867; cv=fail; b=H8Lc3B2E0jlOU1oe1wUNWo8rbOpjsD4hlru1TALVklu1ubaP4Qt6ItdGMMVPy3BaNTiBLDVFTlybL0YwYLI8B+7pMqhlyklYlAz0opyNF5MqejIejM2dk0a8cOU8dEbsL+/fV4B/BkPkGKcfMna7Sne5iMdyPxQ0SKwituWduSI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781974867; c=relaxed/simple;
	bh=Ar8XP0VY4o0zKj2Fgb6g7GSuqFz/sxooCwgxlKitLQY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=i2bEGnvVJK++S+TAzEwPPnEEyoraValcFicsljMWuWfTcZR6d/2AXOd+uBnMvKgkeZFaReoXbEbqSXUWegqYAgfpRI7ayp/6HLS++bzLPbKiVZkycL1VkC1Xlb3az1kuGABiREb7kplLEg9Dp+knFKyE2ch6zRE1mmWSBxU42Qo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=ndhPsFgd; arc=fail smtp.client-ip=52.101.229.101
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HpX+ZaflV6Ykuolle8BfsghmsJqWQtdxdIEjKRBIdD7qYm1tMKhXwPu9+3wh0qVEk/Yse+CeFSQuUEppgjDZpxlHk+zlXL0eIv2KTxul/itXO9BTgTGBrnNC1o76p9BSprTO7IeN3j0Vdf9yn2AAEsnjXk01elviI+elJHykFIYZvIx8InhPK6EGMIxB3cT7oG9fo/zC6OYjvECEUkfUVOvxjbpQ5mUaICTX3J2dbiIzuPmGxi/HnLCmFQjVoS5uPYObXn5DvmZEVCSSNHEAMMr6CfulbWe6z3Rlwp0RoNUPxkrBJrDmPMjy96t0Wp4ZXMWee+A/ORKKzPP1oqDOjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=m0rLXiZmLiU9YPwfiaNKxtakLHHVessYKtzhd/u25XA=;
 b=o6/W5HbgQo0+uzBdJ6NMSbtPCshJkrZHbNpMAdbwk5X1yK4DFa8suQcU00ci921W1mBeTtEWktzzd5ivjZrhbBcEsrza+x5V6pB8uk8ylCBIQz2an4xn0NDCWeVGhCodB5xBMTNdM0qg8W8LjHeSJ7Ob57KoYdwbSvvAZkGVbvp3UQbCP0VD4SCRlDJwdJnGlFMyIY6K/CmDoFBIDQopmFu2LoIb6kCiOiTqTkNVHgCgoWBsBFuEX9Ci4wu4skKtOEMHWLNOdMFOStwNSPHCXEoyDclF44GyZi7q+pAH5GZ/0fkRcYybmL9h75Zhj3VE9IjWmS+AkwphHYl3CW9m+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=m0rLXiZmLiU9YPwfiaNKxtakLHHVessYKtzhd/u25XA=;
 b=ndhPsFgdZnFx1i36JK4BOJXLwxNbobXIt/dBAdEMaFdpGauTvAzJv2EuyoMf8Glo+/dl4Hc+1UTZsUyxw98UN9RlE1VsVf7RTPq90kPuRUj7DSsSAWg0jVxcMYEq0QmI0SzQc+b7v/Z9JyAVXqRpT0fpPAiDgCITXlVkN4uQYhk=
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:38f::10)
 by TY3P286MB2673.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:254::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.13; Sat, 20 Jun
 2026 17:00:58 +0000
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32]) by TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32%5]) with mapi id 15.21.0139.009; Sat, 20 Jun 2026
 17:00:58 +0000
From: Koichiro Den <den@valinux.co.jp>
To: Vinod Koul <vkoul@kernel.org>,
	Frank Li <Frank.Li@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
	Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
	dmaengine@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 06/13] dmaengine: dw-edma-pcie: Track non-LL mode in DMA data
Date: Sun, 21 Jun 2026 02:00:33 +0900
Message-ID: <20260620170040.3756043-7-den@valinux.co.jp>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260620170040.3756043-1-den@valinux.co.jp>
References: <20260620170040.3756043-1-den@valinux.co.jp>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TY4PR01CA0032.jpnprd01.prod.outlook.com
 (2603:1096:405:2bd::13) To TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:38f::10)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY7P286MB7722:EE_|TY3P286MB2673:EE_
X-MS-Office365-Filtering-Correlation-Id: 03b24e1d-1a4f-4ceb-7ec5-08deceed7fe7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|23010399003|366016|10070799003|3023799007|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	4aHGAT48q5q552eFz/MZ6XAd/9ak2Pb43oI8UBzf7QULargbxXKNepmDHPyDctygDWnZL/BRUkj31ZA0shOCUh3hR+LijAqSffKmVlFzEohUK1KW2mWIBoEgR+MlQTdkiVK3WkJ9M0mealX4f3M+qAM8Yo/nu6oBKdY/BRJyOYJAPipu72acMxP3YAfBxRy0ETMKx9KEKE6F9IHTBzNaJZQH0IHCBKLMv+s8j8oiXui8Vi9oFAZXEmtvwD83kjXdur1M9vtxtoDeeSfLhEXueX+ehKlQjhXOMK7o0VyHkGKw4D1NCZoMP6jm/RA0qpeAYTsvA+JqAyscm2sTQhqpfamMJ3LSCTr1ePJ5xcZhhS7b+RO5INx3AxldOoG7brSCn9h+lF6UGIeBKkPzW7jNbU/U4clrOQzXuuTgZa11vOp1Vu7yvhJ0ht8iG5PyfhX/Z1IudABsAacoSQezl/y3aUoiCXHQa0I6/OSAsBdTmwuWwB+PHyWNKYfUqkFx3OVinood8dfLLdYSzNRcYKklWDkcLzhXCS3hAsecFwQiWL2EiZ2qX3+/NeUKCpNfxGXfvRFpUbZwtMDqLuHVrEizZrqTyheOeym4BfrYWjfFch2vXiY6PHh5fZhHycrBav6gyiVQXGTsxi8C6eYAKEASF/PjxSVSEIfwdmLHnmjN6+0=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(23010399003)(366016)(10070799003)(3023799007)(56012099006)(18002099003)(22082099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?rq0DXcm3umyOMW4WyZKA/8XjNVleyaIt88qSXp94/yCneDf5vWYzxVKJGZM3?=
 =?us-ascii?Q?NGYTdoDxbtdwWe1QD6ASBvpgigtMVQEO27dZDz+LReqxQd834KkicfAo6LwP?=
 =?us-ascii?Q?9Eh09FZ3nUT8p0q/T6ZagJY92EDo1VcKCCOhfEUUg08CSVsuo/f+V+AmcyV8?=
 =?us-ascii?Q?cDpwkl9Q2uQz3Obb+2/nzj2lE+r5Kbt+qSH3Ti6HMpPZXpa7S5QjcR21nX1y?=
 =?us-ascii?Q?0Brmad1C3Goi3/B0TqQ7ENYpBxSaFa2q2Mt0ZacaFeCcRWlXUCEJLKWiUyzN?=
 =?us-ascii?Q?+ifdwW96wjUNRq1SCCzNkiZFOE3hdv/EsEAlWEEae+H9tS239gWq1DfJGbDn?=
 =?us-ascii?Q?9BFVyQSY0G/oGidky1roqTGo62dKdiDqZ9UhdDz/s/erl45NsXcGiUoDtDJj?=
 =?us-ascii?Q?qu1RexlXPZ+lKnMxfczfBgqksg7zXtid+ZWGOIC48WHycAD4HidkJGkqzPrq?=
 =?us-ascii?Q?onMFTc4jBCKQDYGtvZNYV27igyx497CWa204J31qdS30r85cobrY3zqlWHSw?=
 =?us-ascii?Q?vq2cRzJStIjLko9nx1p7SMZmgIFliZnMXLBY2FF74jXGpp8Qfi4l27IvjOYC?=
 =?us-ascii?Q?YMBlV0xjaV3VjT05ZRrKKbzM51jX1OJlTxE+//tVSIgjVYpW8hq76XaTTRi8?=
 =?us-ascii?Q?KmNQ1mjdJJBdYNCGnQnsjrDz1/aRoRN0EDvi9V5tnxdwiahv7BVlCmSG9Ocn?=
 =?us-ascii?Q?fIwqQxT5xp/M7RzGsZM+nnnS+7Rzsim9U/FL0Q4ADX3YiDln/HjhlgiNJ9mO?=
 =?us-ascii?Q?EtOWNNAi8oBG8dPjZ3EqF0vsQ5WpFKdg1EC/wNWQJ/RjgdmcGa94HyYq69lG?=
 =?us-ascii?Q?geet0B+uFkslnqKoI3vmtJh0PWdmIilKKQGK76nppX5oPEa7Xt3I41lAuQtg?=
 =?us-ascii?Q?zMTtJWGvNVfiNevyupuyrGmccni6cuBma0dmiTGwXy/K9VkFbRQeN+kyB+sL?=
 =?us-ascii?Q?CUdbVmO8Dpkx32aJCWnSNFQ7KjNQRTccOmlX6tkx92b7at7s4V859lFRTiat?=
 =?us-ascii?Q?nIeiAvGzS/Pnjgb1UkDZE9gz/p9aSW47+8RJWE7JjBF2INH07S6JXQ/GPbO/?=
 =?us-ascii?Q?uVdLI1nPs2LOLFn31VsW4HLqbaywnSVq8VFozOqoEpcq5y4VKDSytk1gjfQX?=
 =?us-ascii?Q?AcK/S8UVFAxGLn158yvD5vZHPjCtfZBQDHR2i5rhH0RG0HUPhR+b+S1ej28E?=
 =?us-ascii?Q?GOaQ7Q6KTQFm1ovknPkHiDjNRUyXiDsVCSLja8McVyBNQUJoGtdyi/RIDidZ?=
 =?us-ascii?Q?NOJTP7YZ0X7+oGQjWaPVBK5eyFUYFFogOS3iklAjKCd8mIv2qJu47xy5EOgr?=
 =?us-ascii?Q?xCyNTYHGpIqcWQKVQEwAQ1gu4WLpnV8bxc8mhv5pqzb4rWKNorKut2Vka8zH?=
 =?us-ascii?Q?wyDw72WTBHLh+D56KYgSGwRNkjsP592w2P/GRC1c6G+p4PxU6/vVuYKA5cXN?=
 =?us-ascii?Q?vlD7glG8PUfQpUaQ/hZ5iIFEPcX/LjniSnWuM9o/cpPxQhuc53b6LyLMOjW1?=
 =?us-ascii?Q?iQNnMYYOGZCUpxHVTHNWB3i/O9kYcq8ExUHJX06BMfh6RKApMQOJ7XqL1+fK?=
 =?us-ascii?Q?mNoYMtkf0jWRbN9gd8EldIXEhWXHlHnmnbQhOL8ldZ5mz/58xmv2KC5JMnxb?=
 =?us-ascii?Q?hnHPxcj6XD0xtGTEZKFly6xbg4vQ4+qcTOuIiSTJRP4zqu79z30XZt9c68yv?=
 =?us-ascii?Q?SEoqX9mDr3MQcGFq3kAC64/595iaiL2nQNyQTYtJmhEeNynWqBRZbKHkdkfs?=
 =?us-ascii?Q?Cb3DHk/l5RK+nFkHwkRPL2eWKs4jr1H0Nq0d44FSrN1XP73feH8F?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: 03b24e1d-1a4f-4ceb-7ec5-08deceed7fe7
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jun 2026 17:00:58.2046
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jCejSFB4rNwMCoP8Ty29DIPH7yYurlXf4k0Tyb7kkvw/Y+6VMJyHkMog83RiHyfN1imDTdOh5Lv0xiG5rkxNqg==
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
	TAGGED_FROM(0.00)[bounces-11654-lists,dmaengine=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[nxp.com:email,valinux.co.jp:dkim,valinux.co.jp:email,valinux.co.jp:mid,valinux.co.jp:from_mime,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: AF0AB6A9499

The dw-edma-pcie driver copies static template data into a mutable
dw_edma_pcie_data instance before applying capability-derived updates.
Keep the derived non-LL mode in that copy as well, instead of only
tracking it in a local variable in dw_edma_pcie_probe().

This prepares for keeping capability parsing behind match data without a
separate non-LL output parameter.

No functional change intended.

Suggested-by: Frank Li <Frank.Li@nxp.com>
Reviewed-by: Frank Li <Frank.Li@nxp.com>
Signed-off-by: Koichiro Den <den@valinux.co.jp>
---
Changes in v3:
  - No changes since v2.

 drivers/dma/dw-edma/dw-edma-pcie.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/dma/dw-edma/dw-edma-pcie.c b/drivers/dma/dw-edma/dw-edma-pcie.c
index 70ea031147d1..0ea8d59782b4 100644
--- a/drivers/dma/dw-edma/dw-edma-pcie.c
+++ b/drivers/dma/dw-edma/dw-edma-pcie.c
@@ -73,6 +73,7 @@ struct dw_edma_pcie_data {
 	u16				wr_ch_cnt;
 	u16				rd_ch_cnt;
 	u64				devmem_phys_off;
+	bool				cfg_non_ll;
 };
 
 static const struct dw_edma_pcie_data snps_edda_data = {
@@ -326,7 +327,6 @@ static int dw_edma_pcie_probe(struct pci_dev *pdev,
 	struct dw_edma_chip *chip;
 	int err, nr_irqs;
 	int i, mask;
-	bool non_ll = false;
 
 	if (!pdata)
 		return -ENODEV;
@@ -361,14 +361,14 @@ static int dw_edma_pcie_probe(struct pci_dev *pdev,
 		 * the HDMA IP.
 		 */
 		if (vsec_data->devmem_phys_off == DW_PCIE_XILINX_MDB_INVALID_ADDR)
-			non_ll = true;
+			vsec_data->cfg_non_ll = true;
 
 		/*
 		 * Configure the channel LL and data blocks if number of
 		 * channels enabled in VSEC capability are more than the
 		 * channels configured in xilinx_mdb_data.
 		 */
-		if (!non_ll)
+		if (!vsec_data->cfg_non_ll)
 			dw_edma_set_chan_region_offset(vsec_data, BAR_2, 0,
 						       DW_PCIE_XILINX_MDB_LL_OFF_GAP,
 						       DW_PCIE_XILINX_MDB_LL_SIZE,
@@ -422,7 +422,7 @@ static int dw_edma_pcie_probe(struct pci_dev *pdev,
 	chip->irq_mode = DW_EDMA_CH_IRQ_REMOTE;
 	chip->nr_irqs = nr_irqs;
 	chip->ops = &dw_edma_pcie_plat_ops;
-	chip->cfg_non_ll = non_ll;
+	chip->cfg_non_ll = vsec_data->cfg_non_ll;
 
 	chip->ll_wr_cnt = vsec_data->wr_ch_cnt;
 	chip->ll_rd_cnt = vsec_data->rd_ch_cnt;
@@ -431,7 +431,7 @@ static int dw_edma_pcie_probe(struct pci_dev *pdev,
 	if (!chip->reg_base)
 		return -ENOMEM;
 
-	for (i = 0; i < chip->ll_wr_cnt && !non_ll; i++) {
+	for (i = 0; i < chip->ll_wr_cnt && !vsec_data->cfg_non_ll; i++) {
 		struct dw_edma_region *ll_region = &chip->ll_region_wr[i];
 		struct dw_edma_region *dt_region = &chip->dt_region_wr[i];
 		struct dw_edma_block *ll_block = &vsec_data->ll_wr[i];
@@ -458,7 +458,7 @@ static int dw_edma_pcie_probe(struct pci_dev *pdev,
 		dt_region->sz = dt_block->sz;
 	}
 
-	for (i = 0; i < chip->ll_rd_cnt && !non_ll; i++) {
+	for (i = 0; i < chip->ll_rd_cnt && !vsec_data->cfg_non_ll; i++) {
 		struct dw_edma_region *ll_region = &chip->ll_region_rd[i];
 		struct dw_edma_region *dt_region = &chip->dt_region_rd[i];
 		struct dw_edma_block *ll_block = &vsec_data->ll_rd[i];
-- 
2.51.0


