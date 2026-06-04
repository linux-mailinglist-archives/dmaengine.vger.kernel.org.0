Return-Path: <dmaengine+bounces-11171-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id Y+QbNBTgIWpXQAEAu9opvQ
	(envelope-from <dmaengine+bounces-11171-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Thu, 04 Jun 2026 22:29:08 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id F2EAE643569
	for <lists+dmaengine@lfdr.de>; Thu, 04 Jun 2026 22:29:07 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=nxp.com header.s=selector1 header.b=P2odiVdS;
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-11171-lists+dmaengine=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="dmaengine+bounces-11171-lists+dmaengine=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=nxp.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 964A53011A69
	for <lists+dmaengine@lfdr.de>; Thu,  4 Jun 2026 20:26:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42D7B3C76B9;
	Thu,  4 Jun 2026 20:26:22 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013037.outbound.protection.outlook.com [40.107.162.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB0E33D9684;
	Thu,  4 Jun 2026 20:26:20 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780604782; cv=fail; b=LBrpzqfVzVJogWLSAPGZW8NbGY+T2aUgFb50Pjmxg7Fnp9Q53i9GecAq82zDnsRWZRnYgFKwqOZgbB0mLva+A5Gg4EdLPF/td4CJzARvPmVwNLFk+1RDsl1MmxNw48dF09uqSUudqzS+wU4VLFqUietNIlftb6qv5pbDpjy1HfE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780604782; c=relaxed/simple;
	bh=UrmhqNYlPyGU2xuEBb36NpcBRFLA+bzswnZPqCMs1+U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=GhWZWZg4UMgNMytAqx/gz9YT1M82+N872lGMotv9q5WPKJVyiLYLmk3KMLD8/ndMCr241iKkpPfVBw9USlUp7f14mF08/sRGmj53whG36YthEne/W+pK5llMWyP/dk+gIzqHqX21Za5y7mlGy/kOZcgIwOPH4PFdU1ZAMQfd07c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=P2odiVdS; arc=fail smtp.client-ip=40.107.162.37
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=L3ow2nyMciTz8QuPwWanUTbFuGnT3I+hHA4sATXhmiQz05fZ/+l409O0tZByu0vf0iXw3hy0vYzBFl0w2rp91mMVr79Hyh14/WCuHw/WhAVxnMuOIMRlomUe11zd0/a8416IE5s1seVgeK1lHUfHx1lJzDzYUhVSmjat4HqWW4+4yyP7uqJrG8dvUczYI9V0TnIw7cnMi1EQFiZsRygG3GjG60FtkbrG6xzqLxKKaVCUvh5DQddIc8BI7b2pPJxK3gJFH4oSfXW+ZB4V6v2CXZ+wwjWhQO4KaGmgimF5vs+raDIunpQ1WUxPOL1eLuuoudm/1wojLGc2YXXfS1CFDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EQ2CbzQ43OhmF1+cxYFY41gkrdSs6/xaBf82g3kC1uI=;
 b=OpZ5RAuCNY1CxA3HOEFgRrOHJscrtWHQQTQw5E2wlPCC6GfUlQagsd7AISQl7CX2Tv82L1iouhwPnecNrxaqBhLJfl1diciaws7FUQD5UEeYtRSudEl1kh3eU1AtO2Mw4m2efHdpDnEy2WRV/Ozl8hILx7ueVBsvxKJfUQ7qsf/AzUOlaLU45O1d9IhvFl3OCMXGlrU7Fynz3rq0LSlkqa3aqAFEiv7mPFUGPU4mDJFDvjFIhtGbQWp3t6/fzxvpmjNEmUy9fIdvt9xSVHaMU33rBgW+uWJOaC6MWqUjbhnsjSseq1O1VBEdben6sK05gvCCHHk/FbgQZ3R35kJvhQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EQ2CbzQ43OhmF1+cxYFY41gkrdSs6/xaBf82g3kC1uI=;
 b=P2odiVdSjR2v50DAYonyCCljDHUEyuhjTVJrR3Z/GRGy6rhOVCQtWmpRqtJEbvi7Iv5aWJNHSa6i//680iAEX15Ewp0fo0kZTiJQCQOat2/SHep7AR0lp3HEsSJPvxgPYQPHkVicmAUFGLoZJrp3k8EvjS1jI5WKyC0qimHJVb+zVDwOp8PCzwcgmn8UrLk3MpzjvQsiCjH3uFNkJ7OoWIq4O5QQdn6CHkJjQTv0p67wcCtE0lU0WRl9Z2oHEsp0gs+4cGxm5cX92vCW+yyV8vndDBQ8M9rY+pzR9ASYup7ntwwb2fxyFtqHdskcFQBGZoNrazsP73r2m+fIzLIfYQ==
Received: from PA4PR04MB9366.eurprd04.prod.outlook.com (2603:10a6:102:2a9::8)
 by PAXPR04MB8973.eurprd04.prod.outlook.com (2603:10a6:102:20c::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.25; Thu, 4 Jun
 2026 20:26:18 +0000
Received: from PA4PR04MB9366.eurprd04.prod.outlook.com
 ([fe80::75e4:8143:ddbc:6588]) by PA4PR04MB9366.eurprd04.prod.outlook.com
 ([fe80::75e4:8143:ddbc:6588%3]) with mapi id 15.21.0092.006; Thu, 4 Jun 2026
 20:26:18 +0000
Date: Thu, 4 Jun 2026 16:26:11 -0400
From: Frank Li <Frank.li@nxp.com>
To: Koichiro Den <den@valinux.co.jp>
Cc: Vinod Koul <vkoul@kernel.org>, Frank Li <Frank.Li@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Marek Vasut <marek.vasut+renesas@mailbox.org>,
	Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
	dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 04/12] dmaengine: dw-edma-pcie: Track non-LL mode in
 DMA data
Message-ID: <aiHfY2lojacQir4l@lizhi-Precision-Tower-5810>
References: <20260525062420.3315904-1-den@valinux.co.jp>
 <20260525062420.3315904-5-den@valinux.co.jp>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260525062420.3315904-5-den@valinux.co.jp>
X-ClientProxiedBy: PH7P220CA0114.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:510:32d::8) To PA4PR04MB9366.eurprd04.prod.outlook.com
 (2603:10a6:102:2a9::8)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR04MB9366:EE_|PAXPR04MB8973:EE_
X-MS-Office365-Filtering-Correlation-Id: 0770bf48-9364-4aa3-cb41-08dec2778892
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|376014|1800799024|366016|52116014|22082099003|38350700014|56012099006|18002099003|3023799007|11063799006|4143699003;
X-Microsoft-Antispam-Message-Info:
	KQ73NegGfdFMHP40nFz/rKT049NF5Biy4LnJe5kjkNaRpgunsIK5BBHRc7h4xVI3ZfyncQZr4+9Dak8J24WpQ1eRmRexFCQjfcDVHzXYVRg1W6VRx30O0LWFKK0SZJNbpIBX6V1dhc8jK5ghDqVf0WSjIl5DzXgQnlieloRKSPzJEfOlKqjN5/K9/kV+ThNhn7pTL7gdADQI9pAV/ZADvnwrFsf3DU1KanlD3HmFDRUI1at6RG2j9SKSXdDORbr3WophesXc1Xi2273089qdsqcU8+wssBAsJQDsB4BD5eOhXesRX8bF33LWqjzAzZ6UhIl8cn7ZQkGgZ9GRp1s718/AthahkH0DCkwom2i6h2MVC8wpFbywJfG9Wz1CCzk7EmzrDPLcit/0VMW8aqE9p+SJjPtJstgoIDyWr0lSo/Ac5kc0IAgfc2jUE/UDlAEKMOJ78pakRWw0MuSXQvwU2LI+hvoA247DTYyxrOiyzNaN+EmH5hNDbUO4URRBUzCdgn9ubKpT5uyRypTdxCMu/Aw1XYIG+jvSwR4XONanXUci1s8D5CySXjPPZi/nLSUwmTiNV/+g12bh+Fy7k3FrGl7Fm22mlIg2BiUaNOyVSQalBkLaYoVZ/F5Alf7IPIudVbZQ04p3aebdNrCsg5syGx0/gQq0ikk6C4NOjNnojdr8bwpojCq1wnwL5y9FZ5X9udAM3zhwueW/R1unlHjQBcb37suUtMSpB5gtRnwP/Yv9kIasQvklS8PsZKgWla2P
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB9366.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(376014)(1800799024)(366016)(52116014)(22082099003)(38350700014)(56012099006)(18002099003)(3023799007)(11063799006)(4143699003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?zcHeNtlOwN1LtsOujVNkl6WJuyShh+2TuCT8rJ3m0wOi2ZaMmx+hr2ExM5aI?=
 =?us-ascii?Q?rr4FJfwQS+WNhjvgcYGe17JdM5Kdri8b7ICR1RkFVEt6anvfeWU/RM9NTQAq?=
 =?us-ascii?Q?AAANIU69SPRXSUBoLGUZbW3yKCoLY9xgx/Ynn5tHmj4s6bKjBE3UfZ3KKfIH?=
 =?us-ascii?Q?pmALVJVaMhbrZN7ibZAmDCyLc+kA0WFFxLm2LRH0M2BS9t6os76+gKwXnKFf?=
 =?us-ascii?Q?D+0G/o7QI8SroUZ1mxPOex5Foqxy9v8vBXggj7HZIEri+02obJeEkP36NkLS?=
 =?us-ascii?Q?Bw6D1kdUNukIHP6TRzY9T6MVmRVmpWsQxFQrpMijOylgF7flonAEWnKWsNou?=
 =?us-ascii?Q?mWf63n7wQ32Gvf/CkZ5J03uZ4Ntjxs0YPm7mKXmHGfxWV89xTnaRE7H+v3Lj?=
 =?us-ascii?Q?Ui5wT4LQL8QbkJu6Jt5ipID1oCVhalToEBCZsxOi/5Y++WyqS0cEnPdeUZnz?=
 =?us-ascii?Q?o7wLCo8+bCQNO02bvMXGUBM8n0YArKGOyZwcBmwyGYJK3lVz+lzcuEbDdHUE?=
 =?us-ascii?Q?ZRZBDbAnumyiSLpBI0gGk/zA2+zfLqcwTP9WDLMcecGIjdq3dwclTpqUoEOD?=
 =?us-ascii?Q?SoN3WoCiCc49Cx8jAHNahlR+YDsQMWEVwLHRFp/cCG2wXBesEyCetodR0sKy?=
 =?us-ascii?Q?bW6DzU19doQfBdzqyYzHmeS4pqx14Y6QhJl3CMBxhyvsCm7hI0Nidc1qAI/A?=
 =?us-ascii?Q?jFg8kJkQG9Vd3Ek50JoBbgPP9lh+37n2y/Y9ePEHJcqEA0b/JZyvF1v2iV0u?=
 =?us-ascii?Q?Ql9KYKQYzsQLGDdJAAp6hSKTIbi4T+XaTumEFPQ70en2ub4qmk71b1Lib1hi?=
 =?us-ascii?Q?A+FHnWbWxTVR2cVFl6R3WDr3iXLZC6QdJeG5r0T4oITt/9rswh4KqO+C+Xak?=
 =?us-ascii?Q?nCb3oG/xKy6J7tru1ucL5WXaX3f97XBs3cUSHcD6T4tOwLnskpPfUeZL7scH?=
 =?us-ascii?Q?iPuAAgXdpeghPF7Ws7Vu5ZH/NFa66D8DcOEHJ2aM45X9izxS6rJnxkB/VgwE?=
 =?us-ascii?Q?Oa/RPsoy+KwHbmmuGr8gx3M+zcmxVTZoqg2GdgLGXqkk8dStGHsV9DUfqxB0?=
 =?us-ascii?Q?hhQipgpTwCibv5qTm9uapXFDrlXkZ3jN9AHU8S2ZBMCwPAzz9gVX+6MdeBpC?=
 =?us-ascii?Q?LMeJCsY/XUqnYkqCBHm6KP9zQRC2PgtTni8Mi6JA9ewtRlpVyPzQ91Qz4rOW?=
 =?us-ascii?Q?+eFCAFeFwqfBzZJtc1uVL4LLnIP+oQ1dAtmk5o7n6VT59jiZKoMskflSEDjA?=
 =?us-ascii?Q?VvQJB/DoWAYJFJq6OTuQlCMfbDa7vcjPwXjDDPy06Vu90HzJLlTEird2qEPc?=
 =?us-ascii?Q?CyioAQkT92pCNTWFbKRHHLr91/LkKmQBUoaoGSNQC5gsLMA+xagUCaZdOb0o?=
 =?us-ascii?Q?4m1LI7t1e9EZRAyV1urq6H7P1zg2ZeE7Sd7fxTxQdyXttd5d+0mhw/Xd2rYT?=
 =?us-ascii?Q?mUF7X4qdSL0lKVUGnczJTve6sKRSAkVXWJl2L8GUrl1aulv07gwVsanQevXE?=
 =?us-ascii?Q?h4C8h4B8oAgwJ0QKXqIdsIewMoSSVqy4S4JahRL7FV4jmQJlD3Ou/MUMkJfj?=
 =?us-ascii?Q?Km0JCaimP1TitfaC3oEoZtd1vZiQTtjYJks3jDgyErtmotkG/WdD/M6834vh?=
 =?us-ascii?Q?lWZA8BYnuCybIoPsSAzoB/NHwVEGXa4dihbOCHYccFVw2S2V9t1IYIAvVwK/?=
 =?us-ascii?Q?U93AMPdDdqJwtRNZYjE7DhOR5+I0v/g/i0WDL/wqFl2DlnvlYhXXpNrWGc5u?=
 =?us-ascii?Q?EpKagDz1qg=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0770bf48-9364-4aa3-cb41-08dec2778892
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB9366.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jun 2026 20:26:18.2783
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dS6uXiR31qW0sLSrcp56YME+r4Jgbx5RJf0xmgrKjFXE9BWpgGs++FlODuOuW6TcR9E3UXq37Iped04FHDbaxA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8973
X-Rspamd-Action: no action
X-Spamd-Result: default: False [1.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nxp.com,none];
	R_DKIM_ALLOW(-0.20)[nxp.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:den@valinux.co.jp,m:vkoul@kernel.org,m:Frank.Li@kernel.org,m:mani@kernel.org,m:marek.vasut+renesas@mailbox.org,m:yoshihiro.shimoda.uh@renesas.com,m:dmaengine@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:marek.vasut@mailbox.org,s:lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-11171-lists,dmaengine=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER(0.00)[Frank.li@nxp.com,dmaengine@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[Frank.li@nxp.com,dmaengine@vger.kernel.org];
	DKIM_TRACE(0.00)[nxp.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[dmaengine,renesas];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,nxp.com:dkim,nxp.com:from_mime,nxp.com:email,valinux.co.jp:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,lizhi-Precision-Tower-5810:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: F2EAE643569

On Mon, May 25, 2026 at 03:24:12PM +0900, Koichiro Den wrote:
> The dw-edma-pcie driver copies static template data into a mutable
> dw_edma_pcie_data instance before applying capability-derived updates.
> Keep the derived non-LL mode in that copy as well, instead of only
> tracking it in a local variable in dw_edma_pcie_probe().
>
> This prepares for keeping capability parsing behind match data without a
> separate non-LL output parameter.
>
> No functional change intended.
>
> Suggested-by: Frank Li <Frank.Li@nxp.com>
> Signed-off-by: Koichiro Den <den@valinux.co.jp>
> ---

Reviewed-by: Frank Li <Frank.Li@nxp.com>

> Changes in v2:
>   - New patch, per Frank's feedback.
>
>  drivers/dma/dw-edma/dw-edma-pcie.c | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/dma/dw-edma/dw-edma-pcie.c b/drivers/dma/dw-edma/dw-edma-pcie.c
> index 0b30ce138503..e92ff5dc6f67 100644
> --- a/drivers/dma/dw-edma/dw-edma-pcie.c
> +++ b/drivers/dma/dw-edma/dw-edma-pcie.c
> @@ -72,6 +72,7 @@ struct dw_edma_pcie_data {
>  	u16				wr_ch_cnt;
>  	u16				rd_ch_cnt;
>  	u64				devmem_phys_off;
> +	bool				cfg_non_ll;
>  };
>
>  static const struct dw_edma_pcie_data snps_edda_data = {
> @@ -312,7 +313,6 @@ static int dw_edma_pcie_probe(struct pci_dev *pdev,
>  	struct dw_edma_chip *chip;
>  	int err, nr_irqs;
>  	int i, mask;
> -	bool non_ll = false;
>
>  	struct dw_edma_pcie_data *vsec_data __free(kfree) =
>  		kmalloc_obj(*vsec_data);
> @@ -344,14 +344,14 @@ static int dw_edma_pcie_probe(struct pci_dev *pdev,
>  		 * the HDMA IP.
>  		 */
>  		if (vsec_data->devmem_phys_off == DW_PCIE_XILINX_MDB_INVALID_ADDR)
> -			non_ll = true;
> +			vsec_data->cfg_non_ll = true;
>
>  		/*
>  		 * Configure the channel LL and data blocks if number of
>  		 * channels enabled in VSEC capability are more than the
>  		 * channels configured in xilinx_mdb_data.
>  		 */
> -		if (!non_ll)
> +		if (!vsec_data->cfg_non_ll)
>  			dw_edma_set_chan_region_offset(vsec_data, BAR_2, 0,
>  						       DW_PCIE_XILINX_MDB_LL_OFF_GAP,
>  						       DW_PCIE_XILINX_MDB_LL_SIZE,
> @@ -404,7 +404,7 @@ static int dw_edma_pcie_probe(struct pci_dev *pdev,
>  	chip->mf = vsec_data->mf;
>  	chip->nr_irqs = nr_irqs;
>  	chip->ops = &dw_edma_pcie_plat_ops;
> -	chip->cfg_non_ll = non_ll;
> +	chip->cfg_non_ll = vsec_data->cfg_non_ll;
>
>  	chip->ll_wr_cnt = vsec_data->wr_ch_cnt;
>  	chip->ll_rd_cnt = vsec_data->rd_ch_cnt;
> @@ -413,7 +413,7 @@ static int dw_edma_pcie_probe(struct pci_dev *pdev,
>  	if (!chip->reg_base)
>  		return -ENOMEM;
>
> -	for (i = 0; i < chip->ll_wr_cnt && !non_ll; i++) {
> +	for (i = 0; i < chip->ll_wr_cnt && !vsec_data->cfg_non_ll; i++) {
>  		struct dw_edma_region *ll_region = &chip->ll_region_wr[i];
>  		struct dw_edma_region *dt_region = &chip->dt_region_wr[i];
>  		struct dw_edma_block *ll_block = &vsec_data->ll_wr[i];
> @@ -440,7 +440,7 @@ static int dw_edma_pcie_probe(struct pci_dev *pdev,
>  		dt_region->sz = dt_block->sz;
>  	}
>
> -	for (i = 0; i < chip->ll_rd_cnt && !non_ll; i++) {
> +	for (i = 0; i < chip->ll_rd_cnt && !vsec_data->cfg_non_ll; i++) {
>  		struct dw_edma_region *ll_region = &chip->ll_region_rd[i];
>  		struct dw_edma_region *dt_region = &chip->dt_region_rd[i];
>  		struct dw_edma_block *ll_block = &vsec_data->ll_rd[i];
> --
> 2.51.0
>

