Return-Path: <dmaengine+bounces-11525-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id MbwKLnIeMGpAOAUAu9opvQ
	(envelope-from <dmaengine+bounces-11525-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Mon, 15 Jun 2026 17:46:58 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 68C91687DA8
	for <lists+dmaengine@lfdr.de>; Mon, 15 Jun 2026 17:46:58 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=valinux.co.jp header.s=selector1 header.b=MG86VBDC;
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-11525-lists+dmaengine=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="dmaengine+bounces-11525-lists+dmaengine=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=valinux.co.jp;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B9098312536E
	for <lists+dmaengine@lfdr.de>; Mon, 15 Jun 2026 15:41:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61F9F40757E;
	Mon, 15 Jun 2026 15:41:33 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from TY3P286CU002.outbound.protection.outlook.com (mail-japaneastazon11020093.outbound.protection.outlook.com [52.101.229.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 079024071E7;
	Mon, 15 Jun 2026 15:41:31 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781538093; cv=fail; b=Jv2Bp/ZtoPg5N1phSGxHAYTKi7eAl28jn6cV45G3cDG/AlQFsTZM9q2uB7kHPeg7oewXQwQdq88cwaUcnCu7a8oNHQ/UmcmYxZlc+bI85CQo/f7bXYWgNV6C9IaOZXzI86nlSvQjErplbWI+TdNEG7wm2uEPrlDeOFmJlbXUqU4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781538093; c=relaxed/simple;
	bh=0sGfzBwQ1qaT9wgPElWxtXxIs7T8Hqlvrle9pJ8RZw4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=BQNOMvVFUFhgOYbDi7kYpDQr7ftfga8Vcwy4qunEle8MWmPOxeB860LJc3h5C7csBdAy5nyf0Zs2BhigjEocSpPZc/CLTazfxTauN1OVPH67czee3jWJLDBzhDlAEbY/5D/kxaPub5O9KEbrIBEr6kkGz+YzrAqe95sO4N3lEbA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=MG86VBDC; arc=fail smtp.client-ip=52.101.229.93
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pk7QFjTZ6RE5hPlUe9Ktdz6S1BxZM6+kWCWKOzcAP3fWbt/c8N0TdzM4gfHvM346yOxZdZFUE15LoKyYEeps6uMLPy4nkiOqLNpIQL9RL30wr2epSWBFA8PdHUFAu2ytSmo84MDhgWENxO987cFlkXAHjAG9CJDErI9QQ3D7rkkdD1SrySgulmuq9djjYqtzd4R0vmrbPuZ0+oF6TRNfa9fbWFN9qAmOIOfPkevMs6RdG1AoHgZOUcz+vD4NLNGsDRCH4EHb3YAaUKnogJXgM8gn+9jHQaHkFR/nVE1/Ty8FVo+BIdaHeGUkc3XCNyd7Ywrpo1cbK6qNGbRhgRIAcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=z3HDMJ4TVAQKb0FjgocPr2OQybbJzdkDADNs59UIgC0=;
 b=EYkclzMvHOuvCcOppWgoA2AKL+1M7+q269ZG0mH0ovRnS4hciMI9j1Ga03TD8PznEPyYpr6MtjUrJBVYd2Ur5BZDevJkKkzut28WDSr9lBy9jpygPb7y9teNlWQD5azb33FICDWllPwlTJL/UsN0MQWP9XW1JT/z1Vm8HDyZvuNkrzyfrHg6yvhMo9/npIJJiKl6YcHcRUtlgSQSoIGzP7wM1jk9jDBHS+K9q3aniZoZdWrCYruWYBg8wF+KqA61fUUs3JoSM+0kmSurZyA0NSGWfbZo5XqxDheL75zQmMmlQWt4wobNlx/vQuKwCDF0LJdnOKZmh+M5efMUZX2o6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z3HDMJ4TVAQKb0FjgocPr2OQybbJzdkDADNs59UIgC0=;
 b=MG86VBDCZ5u3eXWamc8Cb/DiE9+E2gCMP+rOd187dwb16Vszh2soBgUDqxAwdnV3Brp6xjjO0+cSoAeUTHrij+jmCzz4K1+CakkDKfSU6U2H5+c5vEgUd6OMqHO3F7dcfcWzFb8WA64r+XYTqmu2XcbozshvGsTJO76M/0YE9L4=
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:38f::10)
 by TY6P286MB7549.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:345::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.18; Mon, 15 Jun
 2026 15:41:24 +0000
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32]) by TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32%5]) with mapi id 15.21.0113.015; Mon, 15 Jun 2026
 15:41:24 +0000
From: Koichiro Den <den@valinux.co.jp>
To: Manivannan Sadhasivam <mani@kernel.org>,
	Vinod Koul <vkoul@kernel.org>,
	Frank Li <Frank.Li@kernel.org>,
	Gustavo Pimentel <Gustavo.Pimentel@synopsys.com>,
	Kees Cook <kees@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Christoph Hellwig <hch@lst.de>,
	Serge Semin <fancer.lancer@gmail.com>,
	Cai Huoqing <cai.huoqing@linux.dev>,
	Niklas Cassel <cassel@kernel.org>
Cc: Devendra K Verma <devendra.verma@amd.com>,
	dmaengine@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 02/17] dmaengine: dw-edma: Fix HDMA channel status register access
Date: Tue, 16 Jun 2026 00:40:56 +0900
Message-ID: <20260615154111.2174161-3-den@valinux.co.jp>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260615154111.2174161-1-den@valinux.co.jp>
References: <20260615154111.2174161-1-den@valinux.co.jp>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCP286CA0356.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:7c::8) To TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:38f::10)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY7P286MB7722:EE_|TY6P286MB7549:EE_
X-MS-Office365-Filtering-Correlation-Id: 921eaee5-c018-4b0e-55d9-08decaf48deb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|10070799003|366016|376014|7416014|23010399003|921020|18002099003|22082099003|56012099006;
X-Microsoft-Antispam-Message-Info:
	TnvXn0Xmxlvgp4sz1mM+2oLEdNjEjNylU5Md+9VVU/Igqs7q6BNNuB2kmwo75I5OIIv1b/4aeTY9yP7AdNVsPHIM6gZIiNyeZTk3ubuA3w3fqShsfDdUtvI0XP/GgociO1YKfaQqcMUIXMUMUQ3t3zlBlj0ShSF2zR3zMFH7LYK5P74eQruK7TLjAQSEGfxpunqkedoN0fPMxi/2ccDnOl9VHPlkhGeviPkkMF8hnlIe/xU+ujcqX5MqNcBapNzpR8n6W36EXZNDUrOQR0sYHp18T1D278EkBJ0A3SwfZrc5IK2aU0HCko6BZooNArXkB4V3bRPLw24PeYeQ8D7mApyGAEdCG/oTD0hEq+cDHu76oCcGxWIl4xLiP5uJNkiQjz/wRUBd4LRIIbztrYXa9nLrFMBBymLFZp/Q+/eOEI1LCYwUuhl/BEwTG1pLKTlQHpMMOQe5jaX4QtDS3FJ7rKcJd10vA8Bsg7kbvZWrctsWUvt6zfdHGcc/fwJ08XlMPWZhW5qTl1JJqygnb5fQhyg5B2P7FagDb673D0dj/GDG5SiQg7wl1Cm/RTsFpiaxie7x4kcVaL3RTWX5QDqcysFkgfej6+xdhwM61g1g4t6yLJEo5ZR+UKnC51euQQXmtYycmfHCrCdKIH7Nj5Zi//Km+amUvRlvYQzcvEyZT4pqaohKQdiTBSl2djbmEySfBq0wPjiH+rA7Sd+571gq1+QXFbCiyG9QaES8Z5QQHik=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(10070799003)(366016)(376014)(7416014)(23010399003)(921020)(18002099003)(22082099003)(56012099006);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?kUkESnIkztqz4qSQ2hYmqKLJKqyVnFyu7I424px8MdbxSrI/Rgh76J+tF4wD?=
 =?us-ascii?Q?fC+tVmSMgeTDBfmWTlYlRrG716WUs8AAf3LBXTzVYt3SeSOFQOtXkwmVKwNQ?=
 =?us-ascii?Q?Vp/hO92leEqHy27CwriTD6trW8cWpCZSk28PeM94YK8FWautkHZj9NUgNmzM?=
 =?us-ascii?Q?zhmw+yOyGNFA2erFqPUFF2piPjJQPfKv8jI+TVO0+Kpgw7ZV2qCPCd3qctUx?=
 =?us-ascii?Q?NQEe0p5hktC7fepaDTFSJsSL9vmWeF4TaitS9ZvlkpTFqx3P7qJRBShl8/3M?=
 =?us-ascii?Q?YiD5u/uwck23sZ9SgO1hhsjGHrxexdpf/wuGJAQ/vnKXCbx8dyFOMwzf+atl?=
 =?us-ascii?Q?zWVT2mbS+b3c7zuOXA74Ep0QFec5nTxn7zYm5BKkdOfrVBj6PdXv9QwE2xyo?=
 =?us-ascii?Q?rMJDaXYEsK+tg4PAQKwBWLZ06YWXwKHEvLg8sfptLkw2JSqolSg9SibT8nSg?=
 =?us-ascii?Q?TXdb5iz4LO8MbRGONbiAVsIKlqEM1+nMFuk+GR0MnhA3f0k8eorxu/hmsriY?=
 =?us-ascii?Q?A1/2KoN3fReH0upiZMSu2OQaWoZERiOTnR6/pd4CNhXyVqBSTJUggK02QlI3?=
 =?us-ascii?Q?FY/G1cNhnIrdrXm/ttDITWfXD6odXjjjWPvMXATlhkT2T5B2ggRCCLdoeAko?=
 =?us-ascii?Q?wI53e64ck1S7IgqMzeUf4P0tTjx4PFgP3JVgwzJIZqgT0Dir6MydBoNU/OV3?=
 =?us-ascii?Q?x5Nw7qRKHIXqnZxi8wkKTIgOYbw64V9lg4Jxhp2i6SpoWswDpJV5vzl6tW6z?=
 =?us-ascii?Q?Tcr74THHR5MqGvFjAUkd5bzjiBu+EcwCOi2nLrZn0YqDSh41U08rDX6xqXcc?=
 =?us-ascii?Q?6M57u1i3AVrG+tIlRVjYAwzE+/Ekq9MmTJJH3YNbQhSB/oSpWV89BErar7AQ?=
 =?us-ascii?Q?H5S4zDHuN88FxJCN2oE1SWX5GmN0cDB/by8VoUiWmnKpGljUdsLh0avUaU99?=
 =?us-ascii?Q?DrETnWHvrEw8YvvQMLkHPLihehyXAtqP6D68KG3hkO1JP49FgsKixULmgZLS?=
 =?us-ascii?Q?r3dEEtOAXpoGBBmWrtpba4v1AZOt1ZZVUhC8fSLQFtUJn7t5OdEm/GZQwMvf?=
 =?us-ascii?Q?7jx/g6zSLM/tZ+8fikvmJV63ZgcF3hLzmvgOVtadIZQ0TnGODz+Ga+USombe?=
 =?us-ascii?Q?+MdWnmslE3klFmoVFr/kaEbtrLhI0iumxRgJZKkdabfha8OpOri19QFspyHy?=
 =?us-ascii?Q?LN/egnsiwiJyH0an238yFmquntuKGfKML+vo54S2gSMR6Uhcgm5iZ5vwjwzi?=
 =?us-ascii?Q?nQ5AsGf1sMwJgd46rJyjwxaGtz0AbAg1+r2fI/oSJ2iYvFn1K6ElvCZn6r0O?=
 =?us-ascii?Q?1boobtB7dMljopKA3UzEMhYyM1nbC3poGGbFFL3ZqEXGPOqTyZtz0K0afBCX?=
 =?us-ascii?Q?spJplfEbeudQ6xrCvYSEJ8gHXYXKr6PBAMOmx+mkVj2XaIiIuw5I1nolDnAM?=
 =?us-ascii?Q?Q7YQIUTF8tiCfFpd7CQLjI6zdspuNX2gPo7Zraeblfc/bmbXkVsVEeKA8S8R?=
 =?us-ascii?Q?l8Epo0hMlBshCtz2N48AJs8OCc0RpemXxI+kcwZsiE62XqBLa8w2Vzmk2S+X?=
 =?us-ascii?Q?3bMt/Q8B4duETGSsbjNwnhRqvFDQOdd2A0oj1bAMe/BWxiG1PZjdCjGXaBvF?=
 =?us-ascii?Q?4OdGpuEc9EEmVE9MbWn2LkdbWLqpfxM2FtlN2XNdXQKDunT3aSc+BsYI+USf?=
 =?us-ascii?Q?onH1+xNdb4IZm9ewLZczeGc0kf55tALAM8fyWggQTko0gTiP5JuSmrDgkDJ6?=
 =?us-ascii?Q?kxkSs598t9f+nFE8iGPIFp5a93sPAcWF0W+z8Cu+yUsVcz749wub?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: 921eaee5-c018-4b0e-55d9-08decaf48deb
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jun 2026 15:41:23.5434
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jLZt42frYZWVJbZhMj8O+8Pt5pKCQ2FtNQMKM4FZ76cqB+3wiof+3u/snlcpP3tg/iLA42fVAlQ7Y7wrXtq0jw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY6P286MB7549
X-Rspamd-Action: no action
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[valinux.co.jp,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[valinux.co.jp:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-11525-lists,dmaengine=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[15];
	FREEMAIL_TO(0.00)[kernel.org,synopsys.com,google.com,lst.de,gmail.com,linux.dev];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:mani@kernel.org,m:vkoul@kernel.org,m:Frank.Li@kernel.org,m:Gustavo.Pimentel@synopsys.com,m:kees@kernel.org,m:kwilczynski@kernel.org,m:kishon@kernel.org,m:bhelgaas@google.com,m:hch@lst.de,m:fancer.lancer@gmail.com,m:cai.huoqing@linux.dev,m:cassel@kernel.org,m:devendra.verma@amd.com,m:dmaengine@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:fancerlancer@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[den@valinux.co.jp,dmaengine@vger.kernel.org];
	DKIM_TRACE(0.00)[valinux.co.jp:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[den@valinux.co.jp,dmaengine@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[dmaengine];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,valinux.co.jp:dkim,valinux.co.jp:email,valinux.co.jp:mid,valinux.co.jp:from_mime,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,amd.com:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 68C91687DA8

GET_CH_32() takes the direction before the channel ID, but
dw_hdma_v0_core_ch_status() passed them in the opposite order. This can
make the status callback read another HDMA channel status register.

Use the same argument order as the other HDMA register accesses.

Fixes: e74c39573d35 ("dmaengine: dw-edma: Add support for native HDMA")
Cc: stable@vger.kernel.org
Signed-off-by: Koichiro Den <den@valinux.co.jp>
---
Given Devendra's comment on
a28adc76-044b-4666-bda0-d7f9a8d52a63@amd.com,
I expect he will soon submit a very similar patch. If so, please prefer
his patch over this one if it works. I included this fix here since the
rest of this series makes this pre-existing bug easier to hit.

 drivers/dma/dw-edma/dw-hdma-v0-core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/dma/dw-edma/dw-hdma-v0-core.c b/drivers/dma/dw-edma/dw-hdma-v0-core.c
index 7f9fe3a6edd9..862375c8e4ba 100644
--- a/drivers/dma/dw-edma/dw-hdma-v0-core.c
+++ b/drivers/dma/dw-edma/dw-hdma-v0-core.c
@@ -79,7 +79,7 @@ static enum dma_status dw_hdma_v0_core_ch_status(struct dw_edma_chan *chan)
 	u32 tmp;
 
 	tmp = FIELD_GET(HDMA_V0_CH_STATUS_MASK,
-			GET_CH_32(dw, chan->id, chan->dir, ch_stat));
+			GET_CH_32(dw, chan->dir, chan->id, ch_stat));
 
 	if (tmp == 1)
 		return DMA_IN_PROGRESS;
-- 
2.51.0


