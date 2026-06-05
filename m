Return-Path: <dmaengine+bounces-11179-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id vxArEqE4ImrsTwEAu9opvQ
	(envelope-from <dmaengine+bounces-11179-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Fri, 05 Jun 2026 04:46:57 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id B1136644BCA
	for <lists+dmaengine@lfdr.de>; Fri, 05 Jun 2026 04:46:56 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=valinux.co.jp header.s=selector1 header.b=cw+vMKW4;
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-11179-lists+dmaengine=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="dmaengine+bounces-11179-lists+dmaengine=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=valinux.co.jp;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 9B21D30AA4AE
	for <lists+dmaengine@lfdr.de>; Fri,  5 Jun 2026 02:41:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3A873E7BCA;
	Fri,  5 Jun 2026 02:40:34 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from TY3P286CU002.outbound.protection.outlook.com (mail-japaneastazon11020106.outbound.protection.outlook.com [52.101.229.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 339DE3A6B6D;
	Fri,  5 Jun 2026 02:40:26 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780627234; cv=fail; b=Wk7tKNl0W0MnyPaqm6/JK2DqBppjwannXmA6RiofA80pA1Wgl5JWo1kRfv1RtQAWXjgonrCEmJd9Tza4XxWhcnhKN53svO2xlojnqH7no0E/g3OzhYkNIkqi/mKbNX/1BLgPKLTEj78D2TC20XIoYg0B9vgb+CFgH/loq7U6pik=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780627234; c=relaxed/simple;
	bh=aRAVeTw+v5Fr18bIDrzjep3q8JQ5tA2oW2nHj8jsya8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=E2bxWLIL83w4prywkCeCOuAsFkg0Rqwta9f40l+DWSv1joOwivbGCMg43cHqwSJK8JcvxGM41s9XuNgnj55/4FMi4MjrZDgnn8+dYdcY+8fA7gHpmcgvbQrsuVEB/tTrd6Z9NaD6xPnnNolMVKhb6CY+0twFuZgR1uYKdVGTZRY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=cw+vMKW4; arc=fail smtp.client-ip=52.101.229.106
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ISW9Zg1BDPuPuP8iNHJ/KD55lrMbjDtRXdo0qUQ8sTnQQ53O3WmBMsuGKZ3YqDx4R1qCz3HofNwWw+K4mRgI25YvrbGHkuHn4UQ6LOnF5VMSvWcCmDNg/rA0Hq07I70t+4ZK6koS/pRsmn/pJx1pppLuWRHU6AhEfiy41vIj92mSLK9PJNlfPnGkyghQglpPNrDbnhr1vvHqP5lGO0LHlepUI+Mx+EDChdecIbQL39dxii1oTtNGeTJDBin0780rGiWfVvAM9onrtxl6S7DBPKviz75jzK5E+lLvg518xVgmcmykUCUPx06/NRNsH+9ytq9aGUao5tEX8a3AmI5vfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yHkiFJEIkqkcT3Obnl7V2/6gl7B7074hbv7Q7Lg0ECo=;
 b=QTqtE9sxp5T+PxBL0cCzXL0/yDBZxn9Uk0+u3t8f/W6heH5Ao3HwPzMQBoQ1kIG+iWL8kegYS3Cr80/WZ8ZIIbBCGhoOt1rOxMl9RVubJ+jmwSj06ZbI9gX0hrDUWaG1sYWOLQbzvCofQeu8JeN3s9rCih5O6KvV2hr7gFhvNDdKCbbByStBnfUoLKzsXCDjSS/9g0FP/oudk6GcmDqXUbs4Krsfid8tQmED/AOjME71bzV3TO0+WC/psPJhx5YK+7RWobDU70JX+/JfqMkoBPbEUpFc0+e3vt5KqJexUW2VmRxTWyw4egyqxN8PoDn3FQEgSt18kzC6TvyugncOLA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yHkiFJEIkqkcT3Obnl7V2/6gl7B7074hbv7Q7Lg0ECo=;
 b=cw+vMKW4XWz/4eY6XGY0DCrwxK7DicMsSXYhNbNqC99ONRkJBjSAupzFyW+8U3A6+TtGpL9YwXqwXwWnIrS3OO2pjQcmk3S2TtBzGSyS2KwCQp4XAovs36yufTbFoR0Dr8Dydsn0vSuF09l7kH0IKsYoltzmwUzB9uzpPF53NrE=
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:38f::10)
 by OSCP286MB4727.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:323::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.8; Fri, 5 Jun 2026
 02:40:23 +0000
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32]) by TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32%5]) with mapi id 15.21.0092.007; Fri, 5 Jun 2026
 02:40:22 +0000
Date: Fri, 5 Jun 2026 11:40:20 +0900
From: Koichiro Den <den@valinux.co.jp>
To: Frank Li <Frank.li@nxp.com>
Cc: Vinod Koul <vkoul@kernel.org>, Frank Li <Frank.Li@kernel.org>, 
	Manivannan Sadhasivam <mani@kernel.org>, Marek Vasut <marek.vasut+renesas@mailbox.org>, 
	Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>, dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 03/12] dmaengine: dw-edma: Add partial channel
 ownership mode
Message-ID: <eokvhxr5hgqhhqg6y2zbhk57zx7wkrka2wg2ofplc3zcjqep6e@mez3dl4ywleg>
References: <20260525062420.3315904-1-den@valinux.co.jp>
 <20260525062420.3315904-4-den@valinux.co.jp>
 <aiHe9UG3FwIACC8B@lizhi-Precision-Tower-5810>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aiHe9UG3FwIACC8B@lizhi-Precision-Tower-5810>
X-ClientProxiedBy: TYCP286CA0284.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:3c9::15) To TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:38f::10)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY7P286MB7722:EE_|OSCP286MB4727:EE_
X-MS-Office365-Filtering-Correlation-Id: 570157c5-4497-4ea4-6629-08dec2abca8e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|10070799003|366016|376014|1800799024|18002099003|22082099003|6133799003|3023799007|56012099006|4143699003;
X-Microsoft-Antispam-Message-Info:
	nY4V06EBsUxWaurVM8qfWrugHJEpIsnVrR7kwfG+rgnjyxRflJuRK6/HMn7jHamUKSd5Lf0HxAMN2MbhEBMpB3UIMFrqNAyaNHoMGNmqRSh+E/5qWYCFsYpfHgtlMJL6/4bTYfqyADGWzSPjqH9jm138RelFTeQKdMIl//vcBHIRJRByqPI3R1NdTtznfvXM7Lc1noQ8Y4zNbfq2qBhXzj+oA/R5CKdfTZe+k6N7218tZwQqM27DlXdLoTfhs9jlesrd0zIjbgaUrHKEPvUbaTIV2Nw98tv1U8L1DPlU72gLWdpw+IT4nY9218PAgSbEIekJHso9TI9fUHmaCr1j1vi8zQrFZDJivAeRQRuEIp+MKpN09B2MYPQdNi6Rx8DEaHbQX4pCeHtqE1zx0aftq3yhF+PeDJOjEKV76Wxiy0OH1hCGYSzJ4bgolQXp+vHSgxItGtY3aJySnTCNES2EsfCTZ9DXIMG6A5suKalKrpcohq5TsN/ugMqUIJheY4Kfmb9YtwWZl1hvKgagEG2Isaxq/KRubZmhV1u/kG5dL45BGMJ5EZUwYruorDr356hAsPElQk0y0dtvGS6qCi0r8UbojZOzOxNUDRT6xIgl5prGVCD7fFLo3xBtgSHYA8I6IBAHDWz5a51U+TgZXkCvlaQIDbjwlazwoxJEXqo36qgK+trB956SlmuTsAALMfLm
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(366016)(376014)(1800799024)(18002099003)(22082099003)(6133799003)(3023799007)(56012099006)(4143699003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?6T/sPY2p+B++bQzhqILO7WOQmCutW3S6MvesCEWxOVB1xCZX2oTYMzidlgvZ?=
 =?us-ascii?Q?KEcxl47vFCBzQm9+3vKbTPQTPIUAsG7ziLSU0xMnOLR8xF1QlTZH/X3MQ9aE?=
 =?us-ascii?Q?tNSiwbRJHqq9AqaKwpG9KjcwlX4lxI6+3O9FjVernlqz7iY3SCwWyS6NSvWN?=
 =?us-ascii?Q?HW9tcKFFivgRfcQwy4Fcg0PZjP+aJaO1ZrNQhNkGOg0jW+7MwNV3G9H4xoeI?=
 =?us-ascii?Q?D6rfqb+/v3dTjcbiwYaXaumAVsZ4g6s64dMe4Kz3Ie/XAD+3cTD0IRrBMe72?=
 =?us-ascii?Q?CQfpvRvwiPk1SzDdi/8uqG692ch+noT/qOq3LnI15NNflWPeq86/fM9Km9CW?=
 =?us-ascii?Q?sXLzmmxRPnj4KnMq/cT38LLfQBQPadtrBo2MQz7I5xxJBnYSWTiYmKng5Bmd?=
 =?us-ascii?Q?vBOS2HYZcdJy3A6P5TiV3AltGqRf9bLFYUFD4gvmAzMIrlP7h7n3j52EgLnJ?=
 =?us-ascii?Q?m2MVS0VVic2xpQgJz5jTlReKAZywhkHrgYHoHtrtKzuTxYyEA9POCRe7z8/c?=
 =?us-ascii?Q?B8OHu0DtB3E3OxHKr+BeNsDvmLc+tJJ4rcBqHhRg5dXyoF8FhRD/suKK1lsW?=
 =?us-ascii?Q?Ez3vCTq96/jljT3BTK1+frPur8SCVkc8BFGU2TLRawprAI9O4I9GyeoifryY?=
 =?us-ascii?Q?naLp1ufhOxMBYRLNL0Xd7vgnshyNj4RhMKqZcYidHv98YEfOuI7V5DbFMfem?=
 =?us-ascii?Q?fkPchUiwF+BquQhDKVhfBdcJ9eIZnK2NcXpR1cY+uNyiZeQ/F4b/r6QFyhIn?=
 =?us-ascii?Q?3F/A6LxdGEDUjwluxnTSz7lFgb/GGAplJ3jbfNLkb9JTj0J01OoxmgyZfitd?=
 =?us-ascii?Q?71Why0FndZFS9MD/FHYntL3pxN073h+s2S58cetTaYhZqFGFJbgs5VUAwcir?=
 =?us-ascii?Q?25+a2Poc0qmgOjobGwVf5k4C4f07CtFWvnjuTRSVLa2jb/qS460v905LwyA9?=
 =?us-ascii?Q?/FZkx2oqrlT0lNxx5cb5RAanf0W3IY+PTmiWDmfy7B90ZZbNQINNsa1RrKLJ?=
 =?us-ascii?Q?BsTNMoJxMoOrFvRIQm8t4zjj8vlSuXGPFl05BUh9GyqIhPiGm5y7BMZDTPI9?=
 =?us-ascii?Q?XjDu1/QACngkNS3A1+Jrle6qwUiV7f2UmiX++4iZIp0E6baGsRyNwkvvhMLF?=
 =?us-ascii?Q?hyvXHfKgmgGVvBs0u9DaiKBHybcHbwRRRIvKZ2kYe+dPXfnu2NesEtsk2M5k?=
 =?us-ascii?Q?MW6tyghm2RbqMu2QOsfurWBeZXVPaLADIj3mM1kyClUfKQS6vrMyEL4HfsfO?=
 =?us-ascii?Q?sI3urL9NBG0qOzTZYuMfZO+cIkoSEv6O9W28fusFyFTsfvUT7ubCHjCGVH2w?=
 =?us-ascii?Q?3hE2CptJzkbJ8X5mrF1Nx9XJiXOjlYwSpGhKP2JJ2XMyfD7NdgJjcf6iwKW2?=
 =?us-ascii?Q?67ZnT9VQ6EM8mrWx67m/NzCXUOcDWmeIXhGNaLL9r65xEhgS53/NAt7hA16z?=
 =?us-ascii?Q?Yx1nSxA1Sjt92q79k1Q6zydNCCKFsjl84oxctd7a1o+4dq8ZrgyR2qUEtr3Q?=
 =?us-ascii?Q?LELVOHPGVH9Ir+rmJkUqcNvAqlUdDk28AgsKC9RwIMA/dHq7yo4PBF/CQq1/?=
 =?us-ascii?Q?9KtRbWmx0BE3MzxfYQM3yUnXr8Pp/3EHsrronYL7CFY441s+n5P+ljnbTK5u?=
 =?us-ascii?Q?J+Oc7NRcJnmjBZPzNmni8SOODqNdrDfNo0qaGxOin5DjMac1i8UbKi2OuK9y?=
 =?us-ascii?Q?VD8lHiG48wMo+lDog+LJCDzAsC16hjmbi5oi1ABDJe6+IAJmf1l1DcXFd5eF?=
 =?us-ascii?Q?KmhiCOLHahhVXeszaAF4P7s5v0Mcq6zqT4uNRJ8M5Lk06AJX+7P4?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: 570157c5-4497-4ea4-6629-08dec2abca8e
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jun 2026 02:40:22.7629
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /Jbf5h8+VFilxsOP5paZER0n9SUUv5hjRoE5a2a1y76DkM+nC9H3f+0jswMz06ZLZjwS7SN/8lniFo4VJc/ooQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSCP286MB4727
X-Rspamd-Action: no action
X-Spamd-Result: default: False [1.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[valinux.co.jp,none];
	R_DKIM_ALLOW(-0.20)[valinux.co.jp:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:Frank.li@nxp.com,m:vkoul@kernel.org,m:Frank.Li@kernel.org,m:mani@kernel.org,m:marek.vasut+renesas@mailbox.org,m:yoshihiro.shimoda.uh@renesas.com,m:dmaengine@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:marek.vasut@mailbox.org,s:lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-11179-lists,dmaengine=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER(0.00)[den@valinux.co.jp,dmaengine@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[den@valinux.co.jp,dmaengine@vger.kernel.org];
	DKIM_TRACE(0.00)[valinux.co.jp:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[dmaengine,renesas];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,valinux.co.jp:dkim,valinux.co.jp:from_mime,valinux.co.jp:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: B1136644BCA

On Thu, Jun 04, 2026 at 04:24:21PM -0400, Frank Li wrote:
> On Mon, May 25, 2026 at 03:24:11PM +0900, Koichiro Den wrote:
> > Some endpoint DMA frontends expose only a subset of a controller that is
> > also initialized by the endpoint-side OS. Add a partial ownership flag
> > so dw-edma does not reset controller-wide state in probe() or remove().
> >
> > Keep the mode conservative. Do not enable interrupt-emulation doorbells,
> > and reject partial instances for map formats that this driver cannot safely
> > share. For EDMA_MF_EDMA_UNROLL and EDMA_MF_HDMA_COMPAT, require ownership
> > of all channels in each exposed direction. The driver updates registers
> > shared by all channels in a direction, such as interrupt masks and
> > linked-list error enables, so two independent OS instances cannot safely
> > split one direction without a shared locking protocol, which is
> > unrealistic.
> >
> > The frontend must still quiesce delegated channels before removing a
> > partial instance. The flag only keeps probe() and remove() from
> > resetting controller-wide state that may belong to a peer OS instance.
> >
> > Signed-off-by: Koichiro Den <den@valinux.co.jp>
> > ---
> > Changes in v2:
> >   - Reject partial ownership for unsupported map formats up front,
> >     keep direction-granularity validation limited to supported formats.
> >   - Revise the commit message accordingly.
> >
> >  drivers/dma/dw-edma/dw-edma-core.c | 47 +++++++++++++++++++++++-------
> >  include/linux/dma/edma.h           |  6 ++++
> >  2 files changed, 43 insertions(+), 10 deletions(-)
> >
> > diff --git a/drivers/dma/dw-edma/dw-edma-core.c b/drivers/dma/dw-edma/dw-edma-core.c
> > index a70e0640d082..fcef9a27b6ce 100644
> > --- a/drivers/dma/dw-edma/dw-edma-core.c
> > +++ b/drivers/dma/dw-edma/dw-edma-core.c
> > @@ -794,6 +794,9 @@ static int dw_edma_emul_irq_alloc(struct dw_edma *dw)
> >  	chip->db_irq = 0;
> >  	chip->db_offset = ~0;
> >
> > +	if (chip->flags & DW_EDMA_CHIP_PARTIAL)
> > +		return 0;
> > +
> >  	/*
> >  	 * Only meaningful when the core provides the deassert sequence
> >  	 * for interrupt emulation.
> > @@ -1135,6 +1138,8 @@ int dw_edma_probe(struct dw_edma_chip *chip)
> >  {
> >  	struct device *dev;
> >  	struct dw_edma *dw;
> > +	u16 hw_wr_ch_cnt;
> > +	u16 hw_rd_ch_cnt;
> >  	u32 wr_alloc = 0;
> >  	u32 rd_alloc = 0;
> >  	int i, err;
> > @@ -1146,6 +1151,16 @@ int dw_edma_probe(struct dw_edma_chip *chip)
> >  	if (!dev || !chip->ops)
> >  		return -EINVAL;
> >
> > +	if (chip->flags & DW_EDMA_CHIP_PARTIAL) {
> > +		switch (chip->mf) {
> > +		case EDMA_MF_EDMA_UNROLL:
> > +		case EDMA_MF_HDMA_COMPAT:
> > +			break;
> > +		default:
> > +			return -EOPNOTSUPP;
> > +		}
> > +	}
> > +
> >  	dw = devm_kzalloc(dev, sizeof(*dw), GFP_KERNEL);
> >  	if (!dw)
> >  		return -ENOMEM;
> > @@ -1159,13 +1174,23 @@ int dw_edma_probe(struct dw_edma_chip *chip)
> >
> >  	raw_spin_lock_init(&dw->lock);
> >
> > -	dw->wr_ch_cnt = min_t(u16, chip->ll_wr_cnt,
> > -			      dw_edma_core_ch_count(dw, EDMA_DIR_WRITE));
> > -	dw->wr_ch_cnt = min_t(u16, dw->wr_ch_cnt, EDMA_MAX_WR_CH);
> > +	hw_wr_ch_cnt = min_t(u16, dw_edma_core_ch_count(dw, EDMA_DIR_WRITE),
> > +			     EDMA_MAX_WR_CH);
> > +	hw_rd_ch_cnt = min_t(u16, dw_edma_core_ch_count(dw, EDMA_DIR_READ),
> > +			     EDMA_MAX_RD_CH);
> > +
> > +	if (chip->flags & DW_EDMA_CHIP_PARTIAL) {
> > +		/*
> > +		 * Direction-wide registers are shared by all channels in that
> > +		 * direction, so a direction must have a single owner.
> > +		 */
> > +		if ((chip->ll_wr_cnt && chip->ll_wr_cnt != hw_wr_ch_cnt) ||
> > +		    (chip->ll_rd_cnt && chip->ll_rd_cnt != hw_rd_ch_cnt))
> > +			return -EOPNOTSUPP;
> > +	}
> >
> > -	dw->rd_ch_cnt = min_t(u16, chip->ll_rd_cnt,
> > -			      dw_edma_core_ch_count(dw, EDMA_DIR_READ));
> > -	dw->rd_ch_cnt = min_t(u16, dw->rd_ch_cnt, EDMA_MAX_RD_CH);
> > +	dw->wr_ch_cnt = min_t(u16, chip->ll_wr_cnt, hw_wr_ch_cnt);
> > +	dw->rd_ch_cnt = min_t(u16, chip->ll_rd_cnt, hw_rd_ch_cnt);
> >
> >  	if (!dw->wr_ch_cnt && !dw->rd_ch_cnt)
> >  		return -EINVAL;
> > @@ -1182,8 +1207,10 @@ int dw_edma_probe(struct dw_edma_chip *chip)
> >  	snprintf(dw->name, sizeof(dw->name), "dw-edma-core:%s",
> >  		 dev_name(chip->dev));
> >
> > -	/* Disable eDMA, only to establish the ideal initial conditions */
> > -	dw_edma_core_off(dw);
> > +	if (!(chip->flags & DW_EDMA_CHIP_PARTIAL)) {
> > +		/* Disable eDMA only when this instance owns the controller. */
> > +		dw_edma_core_off(dw);
> > +	}
> >
> >  	/* Request IRQs */
> >  	err = dw_edma_irq_request(dw, &wr_alloc, &rd_alloc);
> > @@ -1227,8 +1254,8 @@ int dw_edma_remove(struct dw_edma_chip *chip)
> >  	if (!dw)
> >  		return -ENODEV;
> >
> > -	/* Disable eDMA */
> > -	dw_edma_core_off(dw);
> > +	if (!(chip->flags & DW_EDMA_CHIP_PARTIAL))
> > +		dw_edma_core_off(dw);
> 
> Can we simplely prevent dma driver remove? If attached to pci host,
> remove edma driver always be risk because RC may write data at any time.
> 
> And it doesn't make sense to remove EP and EDMA driver after linkup.

Do you mean preventing driver unbind/remove itself regardless of chip->flags,
rather than only avoiding dw_edma_core_off()?

That might be a better direction, but it sounds a broader policy change and I'm
not sure it would not affect existing use cases.

Best regards,
Koichiro

> 
> Frank
> 
> >
> >  	/* Free irqs */
> >  	for (i = (dw->nr_irqs - 1); i >= 0; i--)
> > diff --git a/include/linux/dma/edma.h b/include/linux/dma/edma.h
> > index 2bf2298711e1..84f0e728d300 100644
> > --- a/include/linux/dma/edma.h
> > +++ b/include/linux/dma/edma.h
> > @@ -55,9 +55,15 @@ enum dw_edma_map_format {
> >  /**
> >   * enum dw_edma_chip_flags - Flags specific to an eDMA chip
> >   * @DW_EDMA_CHIP_LOCAL:		eDMA is used locally by an endpoint
> > + * @DW_EDMA_CHIP_PARTIAL:	Only channels described by this instance are
> > + *				owned by this driver. Controller-wide state
> > + *				must be preserved, and layouts with shared
> > + *				direction-wide registers must only be shared at
> > + *				direction granularity.
> >   */
> >  enum dw_edma_chip_flags {
> >  	DW_EDMA_CHIP_LOCAL	= BIT(0),
> > +	DW_EDMA_CHIP_PARTIAL	= BIT(1),
> >  };
> >
> >  /**
> > --
> > 2.51.0
> >

