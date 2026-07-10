Return-Path: <dmaengine+bounces-12273-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id rWKqF3epUGo73AIAu9opvQ
	(envelope-from <dmaengine+bounces-12273-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Fri, 10 Jul 2026 10:12:39 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 577DD738520
	for <lists+dmaengine@lfdr.de>; Fri, 10 Jul 2026 10:12:38 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=valinux.co.jp header.s=selector1 header.b=otAkkPtE;
	dmarc=pass (policy=none) header.from=valinux.co.jp;
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-12273-lists+dmaengine=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="dmaengine+bounces-12273-lists+dmaengine=lfdr.de@vger.kernel.org";
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 5D128301BD54
	for <lists+dmaengine@lfdr.de>; Fri, 10 Jul 2026 08:09:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0BD63EEACB;
	Fri, 10 Jul 2026 08:09:25 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from TY3P286CU002.outbound.protection.outlook.com (mail-japaneastazon11020075.outbound.protection.outlook.com [52.101.229.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E5B13ED3A6;
	Fri, 10 Jul 2026 08:09:21 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783670965; cv=fail; b=EEP4daUHftnFeusm1twGvuX5z6v9FsdiVGV3oxqXDeH8HmHOYDUujb6+cboDLHuXTGJESk5DTuzeZC+j9RqXgYCSH6xq7SKAG4RW8SGVR+bNT2L8tuB5q5DxHFovBb2+K5GBiSQj6651kJvRY7WV8ec1+55VHGA0BNHLor9z2M0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783670965; c=relaxed/simple;
	bh=+woOPqlh2Kwk2JOzgBZJtEqm8GJUk8rkR7Xi/ujAcTE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=PjLJjOj0vNVQtTlYrSURSNlKb3FMQvcgysTS9dS5EJKvcyX+tK62qwE4INDVR/ALpCagIaGk4wYGCit4MAvGgZmMxm7q2NZ/GCVSY8Dqn6IPqmlEEs/DepOXUYd3lUJZ9eCPaRtFYl/3GAnpfLHo406e5Jvzz+zMw789ouia+sM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=otAkkPtE; arc=fail smtp.client-ip=52.101.229.75
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XDBuHrFVFEapCLOyCtjmX2j0Xf5zrr8h9jjr/ffyWTZcYcBs/PQjOBUgoFF4b5bQmBIg8GzfTNuH7F2q2xf4qv1d2w1PMkWKgdOjz663U3e51W7yVtz8vY+LtyaKNfTZGXLIXUDjAAvShovClGBNkxENbbAIAhuVn+DeH4Fl3ic5L9T1sBT+WG9Rjpi/4SAEF8f9fpZ6Z3ScueSuQHi/0lUmOF1JyceJ9ety5N03GiFhoZuMgr+uAPRey5/OaypXvC0G/xwVxUg3eJPzUePfI9O0rOaDobyNMsK8m3xx4lxHG9H8I2FdU0lZVAIbySUURlXeftF7KFbr9G5mJ6TSLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4ozA9/2x5A2p2x+EiHrXATEbsNtUjWCtMtt3b5UAATA=;
 b=v+S8rk4qt0qjSOlpYM7YtHhF8UlOtPQpGwg0Qwx1/s+H2Sb6COxTpGNTlOCdxQKS62kq4JdF/zLNgzFyuT/qUCp30oyIlMRCSUP1ZPmv6rQKCGeTSxFAO9jKxTIzXtKEEvPnol+gFXQp2noPjbF6BWRY6php5zezholjSydYgeT96kfP8iMNgW37uXP/O4I0De55zPGahIFmBH+sjeywh14Y7+mJvCD7P8QV/TRFZ0IbiMlfcyMrNGKNRIf6o0oEqVmPkSiRgLqQOvIMV3b/Np5n0iiqrfGh2vBWXj1WQs3LGmTBEJHTazP2aJ+ek31JokqaBZPOorELlBWtn9/J3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4ozA9/2x5A2p2x+EiHrXATEbsNtUjWCtMtt3b5UAATA=;
 b=otAkkPtEY1GftuQFldzrwAoLonH2ZLSGVxuaWb8+V/8EoYKuGbFxZwQmU/hxAM/jVa/+4VN/xQbCugsemrmb8fzXpKj2qcvoXnUYP+kgYUt9nBbH4URPxQZSeiyP7feISGnUkWPuvS6+7saUsiNEo7FLWWxsisJUOG8ONx4qspM=
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:38f::10)
 by TY7P286MB6374.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:32e::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.17; Fri, 10 Jul
 2026 08:09:13 +0000
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32]) by TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32%5]) with mapi id 15.21.0181.009; Fri, 10 Jul 2026
 08:09:13 +0000
From: Koichiro Den <den@valinux.co.jp>
To: Manivannan Sadhasivam <mani@kernel.org>,
	Vinod Koul <vkoul@kernel.org>,
	Frank Li <Frank.Li@kernel.org>,
	Cai Huoqing <cai.huoqing@linux.dev>,
	Serge Semin <fancer.lancer@gmail.com>,
	Gustavo Pimentel <Gustavo.Pimentel@synopsys.com>
Cc: Devendra K Verma <devendra.verma@amd.com>,
	dmaengine@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 4/7] dmaengine: dw-edma: Serialize channel state checks
Date: Fri, 10 Jul 2026 17:09:00 +0900
Message-ID: <20260710080903.2392888-5-den@valinux.co.jp>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260710080903.2392888-1-den@valinux.co.jp>
References: <20260710080903.2392888-1-den@valinux.co.jp>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCP286CA0115.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:29c::19) To TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:38f::10)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY7P286MB7722:EE_|TY7P286MB6374:EE_
X-MS-Office365-Filtering-Correlation-Id: 49bf44c4-5b47-4b41-8f72-08dede5a8741
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|23010399003|10070799003|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	STuwUA4k/9cdYdOKFJv2CD4203xxFskL8lSEYOOkpB/0CIIIx5zAlLlAONPiTMTU2WIYuLYIFuGOil9x1gNVyRiYTIKK1FZe8I8BD38Jhhc7FsEyDTCcpedKRl2AvZVkjZ7CKwHWP/4EwdTwIlucCnL3MvylDTLGiLbNBVSeAK8cOBzx7VpfhfzoWNigbfR39DZhMY3E1Hs+tyG+Qha9/UfrAPqXiOLfzKgnoZA9Np+l8zcgUrG78OOLUMiIjDhbSIZ9epfSBekZZ3E4F/9sjDWfSiliQBIkKcgDZYap4tbmXSd9XS+a+vmCgXU70cbjdQEtFxTehTLrMr84B2edmgSjG09Tw4IyRxqzTzyPV/laZnbWFBs/5uIBDOYhGagxzEdjPrpID/0oLN2ELO7wdDpch1GdIBSlahY+0i08DJ8/hH/Q/uzTSdzJA+NRIqsrdPU1vRDqoMSBlV58GifPXjjdFAJPjfKe57JfU64ZqLG01farCh4C6iPTsb3W97U6vhsvRRDa90ojUZQ6eM2sjNP5ChMrk7uldI17FCMjOEHG3SV424HAjtsOQi9Z5CpcSDAU3AQXIYv/OsQsfBFYqkmNthjIHni+0yX0xcx1MdCBeIoq2WS/67QJI22yXL8jIaKFgxdhlN1IEopS2jkXo/wvg0r751cQdVJ4oHxT/lk=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(23010399003)(10070799003)(56012099006)(18002099003)(22082099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?e/HujuEXqLMLPuBi+k1482LIu/WLdOyqr2oTA2G4JfLJ8GV4sDj99Qy1st1S?=
 =?us-ascii?Q?hhtMTYdNM2e8GpI9uxP+pJY184Rj9a2EUb7EL8AxHGUnpwYt01biVuZmXdWD?=
 =?us-ascii?Q?RKQl5hGI+kQlt6vKWqR04KC09u/C8lH0Bv8PHceELuPuFy8iP32bvzUUOGmE?=
 =?us-ascii?Q?3cIsntpmeGttnmgrKHMr+oZRSIUeI1uhAzxSnPSQGO+xdjpYu0pDJzimMycw?=
 =?us-ascii?Q?6aVXcIJG7xPifew+GtVuFaORq6KAnpI5arrcmrVo7QMaZqH2rcZp7Azg7ZIi?=
 =?us-ascii?Q?x49/nak1Otj/Moo1E+7RR5PE2NBh9OM42V5sV8E7G5Wr8qABAIWxzYYrYswt?=
 =?us-ascii?Q?G0HMWkrBh7KGzF+75Fm4+cMZ+ZgLIDhymuaWofIyG5B5UIWoqYmyXbVnoz+e?=
 =?us-ascii?Q?VLGi8FXtamNCspTAODlOQUJLY5U050s/ekecAi3/QmSp7r3uXqwxB2KsK8Kh?=
 =?us-ascii?Q?imyEI4DtK5BUPvjSSbQQzI2HYWkmxQ4owqlI+Bh6oSo0+KDtYhrGZ/quqzFf?=
 =?us-ascii?Q?f2sfG1EH89kutfnqR3WtAI5bP6hCgeN0S98Z/wFsdRxYCmLe41n6pC8QiAfV?=
 =?us-ascii?Q?SKkUrk44dA9t4fqW7zLZdRa6iooHWsQ06TYIn2BXAoDosXx5wHRFkaD+ANDn?=
 =?us-ascii?Q?j2Y6Kcw6JP+tNkdxWf9YrvuocgegiQfF8QmaURdh7juNlrqeoHmHweEtBCdd?=
 =?us-ascii?Q?ypPxbQ8POK4S7g6t50tyQR6G7A8Mx1NXaxmyaSOuuwkoJ9vpHWuXw70jwpen?=
 =?us-ascii?Q?jwKB2BEoe9LMzN39MmuvOcYsxKBUWylplAz4HXVuyExzV9NPK40Jw3Xsoou1?=
 =?us-ascii?Q?zfeRcd99C5zN7ooKoKUOAK8IBhaCXSMXHXggBFO0o6c/RO6depf2ICIE3bVT?=
 =?us-ascii?Q?UKWD++gfHt6TNk6EUgo+2iryTm4AUsxZCUuRUReK6wvlM9/YR4BjdD9pS2FO?=
 =?us-ascii?Q?ZqfsG6wN8cpiAKuyS8ZjCdA5KcG2fO5A99gbCrqoL6GELlQjcKPotIKeOhD+?=
 =?us-ascii?Q?2mzF9Uxsyxc3Cwi2GlR0Tz357KQRF+rdwxhg52AMaULofDKgk2iiofGFo8Gz?=
 =?us-ascii?Q?P7uuCo1l9nDhkxoHPim/24WRGaKzXCSp5m9AJ9BXJ1iqbZpAQV8CgaagNtbL?=
 =?us-ascii?Q?gTWEuS8ZkXH3A+BTdlxR63hz7jOP5eaHihZQnmpzJXzWdavEeea34s1AyRBE?=
 =?us-ascii?Q?kariqz6N9i8yPd/7gVzNKfBSsMSm5jPXWydY2OYtxwH8LnCvAN+jkSVMBJTH?=
 =?us-ascii?Q?MOGULKXOz80DhaCN5xwL6KM0/ALpWx04F0JX+l21r/QhEDg9qRIsRBR+AicR?=
 =?us-ascii?Q?ffkxfgR1o7Kd3qrFePfilSY2nNMgStU/LckXxwQ26zZYkXUXteFTVTuzkw+Y?=
 =?us-ascii?Q?329nVPM+aCyksOoX4OB3J2hJtuEOB3i+c5XEnHk+d3iQzYWgrnVUlCemblt5?=
 =?us-ascii?Q?jijx9upxrWCnLd93J50rm2+RDa2ui2qreU4GAK8QV+P4gLNZWBylQHATIABh?=
 =?us-ascii?Q?nG9SATCO6NAtex7ZVlMmud/kXRn4PYaYoWc/oKSvZk2wnprd/FIYC7LbBk2L?=
 =?us-ascii?Q?aupaJJ5YcJg5bq6GSr/YLC8BZYZCavCccL5S4X8AHDXYgp6UPn5y1XHgFMFE?=
 =?us-ascii?Q?JUO8omXwgAoy5rAbc0z9lPe3KQVh1bJxf7UwoFXhhpiIekaPIQOy0vGY6iLU?=
 =?us-ascii?Q?qSPibKSwPhV3X9f1iR915iXC78KLRZvfTnDBdxS70uGL4OeWVfZ3fD06CJJO?=
 =?us-ascii?Q?BoZIx6upF8DR+as8ibeYIdVfH9C7W31IetNNJLnFpHtIiFVqLsv9?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: 49bf44c4-5b47-4b41-8f72-08dede5a8741
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2026 08:09:13.1370
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XK67rardSI9HocxbENUK4FEdYLlwEYeJ9xQVKDnGv0MMXe6JJDN+NTdMyn2IcRLFpSe+brwWdVBbl3VGgsXP0Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY7P286MB6374
X-Rspamd-Action: no action
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[valinux.co.jp,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[valinux.co.jp:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_TO(0.00)[kernel.org,linux.dev,gmail.com,synopsys.com];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER(0.00)[den@valinux.co.jp,dmaengine@vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-12273-lists,dmaengine=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:mani@kernel.org,m:vkoul@kernel.org,m:Frank.Li@kernel.org,m:cai.huoqing@linux.dev,m:fancer.lancer@gmail.com,m:Gustavo.Pimentel@synopsys.com,m:devendra.verma@amd.com,m:dmaengine@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:fancerlancer@gmail.com,s:lists@lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[den@valinux.co.jp,dmaengine@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[valinux.co.jp:+];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[9];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[dmaengine];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nxp.com:email,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,valinux.co.jp:from_mime,valinux.co.jp:email,valinux.co.jp:mid,valinux.co.jp:dkim]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 577DD738520

pause() and resume() read and update channel state without holding vc.lock,
while the interrupt handlers update the same state under it. Take the same
lock around those state checks so that request, status, and configured stay
consistent.

For example, pause() can observe EDMA_ST_BUSY right before the interrupt
handler completes the final descriptor and moves the channel to
EDMA_ST_IDLE, and then record EDMA_REQ_PAUSE on an already idle channel. No
further interrupt will acknowledge the request, and since issue_pending()
requires EDMA_REQ_NONE, the channel is wedged for good: terminate_all()
leaves the stale request behind, so even reconfiguring the channel does not
recover it.

issue_pending() already runs under vc.lock, but it tests configured before
taking it. Move that test under the lock as well, so that the decision to
start work is made against the current value rather than one observed
before a concurrent terminate_all() deconfigured the channel.

Fixes: e63d79d1ffcd ("dmaengine: Add Synopsys eDMA IP core driver")
Reviewed-by: Frank Li <Frank.Li@nxp.com>
Signed-off-by: Koichiro Den <den@valinux.co.jp>
---
Changes in v2:
  - Split out into this preparation series (was patch 05/17 of
    the dynamic LL appends v1).
  - Collect Frank's Reviewed-by.

 drivers/dma/dw-edma/dw-edma-core.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/drivers/dma/dw-edma/dw-edma-core.c b/drivers/dma/dw-edma/dw-edma-core.c
index 1b493c104a5b..5664421c6f15 100644
--- a/drivers/dma/dw-edma/dw-edma-core.c
+++ b/drivers/dma/dw-edma/dw-edma-core.c
@@ -301,8 +301,10 @@ static int dw_edma_device_config(struct dma_chan *dchan,
 static int dw_edma_device_pause(struct dma_chan *dchan)
 {
 	struct dw_edma_chan *chan = dchan2dw_edma_chan(dchan);
+	unsigned long flags;
 	int err = 0;
 
+	spin_lock_irqsave(&chan->vc.lock, flags);
 	if (!chan->configured)
 		err = -EPERM;
 	else if (chan->status != EDMA_ST_BUSY)
@@ -311,6 +313,7 @@ static int dw_edma_device_pause(struct dma_chan *dchan)
 		err = -EPERM;
 	else
 		chan->request = EDMA_REQ_PAUSE;
+	spin_unlock_irqrestore(&chan->vc.lock, flags);
 
 	return err;
 }
@@ -318,8 +321,10 @@ static int dw_edma_device_pause(struct dma_chan *dchan)
 static int dw_edma_device_resume(struct dma_chan *dchan)
 {
 	struct dw_edma_chan *chan = dchan2dw_edma_chan(dchan);
+	unsigned long flags;
 	int err = 0;
 
+	spin_lock_irqsave(&chan->vc.lock, flags);
 	if (!chan->configured) {
 		err = -EPERM;
 	} else if (chan->status != EDMA_ST_PAUSE) {
@@ -330,6 +335,7 @@ static int dw_edma_device_resume(struct dma_chan *dchan)
 		chan->status = EDMA_ST_BUSY;
 		dw_edma_start_transfer(chan);
 	}
+	spin_unlock_irqrestore(&chan->vc.lock, flags);
 
 	return err;
 }
@@ -373,11 +379,9 @@ static void dw_edma_device_issue_pending(struct dma_chan *dchan)
 	struct dw_edma_chan *chan = dchan2dw_edma_chan(dchan);
 	unsigned long flags;
 
-	if (!chan->configured)
-		return;
-
 	spin_lock_irqsave(&chan->vc.lock, flags);
-	if (vchan_issue_pending(&chan->vc) && chan->request == EDMA_REQ_NONE &&
+	if (chan->configured && vchan_issue_pending(&chan->vc) &&
+	    chan->request == EDMA_REQ_NONE &&
 	    chan->status == EDMA_ST_IDLE) {
 		chan->status = EDMA_ST_BUSY;
 		dw_edma_start_transfer(chan);
-- 
2.51.0


