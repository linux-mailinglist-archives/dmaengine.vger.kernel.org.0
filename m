Return-Path: <dmaengine+bounces-11538-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id liVRN/AdMGriNwUAu9opvQ
	(envelope-from <dmaengine+bounces-11538-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Mon, 15 Jun 2026 17:44:48 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DAD3D687D43
	for <lists+dmaengine@lfdr.de>; Mon, 15 Jun 2026 17:44:47 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=valinux.co.jp header.s=selector1 header.b=kPAS7N3o;
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-11538-lists+dmaengine=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="dmaengine+bounces-11538-lists+dmaengine=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=valinux.co.jp;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id EE151300F7B6
	for <lists+dmaengine@lfdr.de>; Mon, 15 Jun 2026 15:42:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCDAA40B37B;
	Mon, 15 Jun 2026 15:41:44 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from TY3P286CU002.outbound.protection.outlook.com (mail-japaneastazon11020093.outbound.protection.outlook.com [52.101.229.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D4DB40962E;
	Mon, 15 Jun 2026 15:41:42 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781538104; cv=fail; b=LsdKvgA2PQlcECU/zp18V6W4lDsi3cUn6gCkCV6bkXFUNdWUV+jO25uhSmqotGOm873IqZDs8+kKdnlhuGFXD3cw/Uu4rEBIH3cW+nCtl449tsVFH943BpdT6epoRJwhHs3slrE4jDst88oaQIszM3XriA4JrKo0aO/wA9Ci1tQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781538104; c=relaxed/simple;
	bh=mK4I2L7IZqFOcwjqciPeWuCcW0VjbXi2zkFocW89Uj4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=FAHZyyTYpKVhvGuvD3Bh8qizYH4Cb2jqAkRQrWbcumIhuh5QgI1BgINiDld7oJ5r1wK/+eYnp7NX7+01KBwj9aPoK03K+Ilau5AXHoXnnpr9JFTf4jbfB68wR9M/vcHomX+eQlAbb5EuT/xmc+bp1EJUZrxyC9D6Y/tY7Z9cNM8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=kPAS7N3o; arc=fail smtp.client-ip=52.101.229.93
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=in64JmsUG2tQaFMPg7wk1JwMCRXAdAHUCslz7GN05q51nnRxreBKdizAGxZYgOJhh89eCTQUDogJJDNcYdaRsn3Gd+26xh+9LKAk1ekc9R9cuIWrvQm7ux0tHSXiqG+M6MV9peZo8ZMXCcakNK2Ssie+ootmfMnQylBNunbugA+pwGOYZ7tPd8q7B58/O1Db/m++6R/vHKnmJb47nPaIiGrhZjrXkpsVRhsVf2mYbS8SoSpdSEsdk4BETnbRXz7janRvRMssPmLqsuPRSr5CtlCAV51o0v7qlN0oq54czeiLk8UVreVOY2YxvjxTUJvjMuS29R5v4jTKQyGLxHVGnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KVc7TYYhfF6V7cFciGNj3kMq7bQMKSxhHQzo7+uTWJI=;
 b=l+NfX70XJhD6xa+/mNMCCCIepRe/nmyTbpNfBpUKObyXqGikZYzmMeV3cVsKUTqT7S7FP1wOwVj+cpX9a44Gl5tU7IUxEZ+tNawNb9j6aBpAImIf98qS7yT8rPAKSFcIH/L4x//ToUVCywgxb85BLGUmS6uRb13jL45x3LlsEydbCw6dJpjF69CnHTEQF71iZz8Pswws7P+KNRYNb15DyN8GFiXQFkueiLzL3TdKf+s8vm/31Ghq530v3yjjwG44VBwAAUw+3xJYrZ2lryVUmK5utvJR//tFj53srB1ftZ0xCHWZ4rWWh/TpcVHhRwppGtKK4Q5Pwve/R8vW1rmLTw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KVc7TYYhfF6V7cFciGNj3kMq7bQMKSxhHQzo7+uTWJI=;
 b=kPAS7N3oigNtUA/EHyzPUgWZhDcO91jbtCRf//N0kaNp6USuO3WKogcQ+BapXbSJL3hzIcKzeeoK3KGgSyFgdQ5GUBFQUCcA03eJt97o60+yvEjVx4l6wRDyFVA0jLwBCMYz3DuS8KsCpFr7YBsbjy5pYw1GhsdAUMKbIiN22Y0=
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:38f::10)
 by TY6P286MB7549.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:345::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.18; Mon, 15 Jun
 2026 15:41:33 +0000
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32]) by TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32%5]) with mapi id 15.21.0113.015; Mon, 15 Jun 2026
 15:41:33 +0000
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
Subject: [PATCH 16/17] dmaengine: dw-edma: Recover stopped HDMA from tx_status
Date: Tue, 16 Jun 2026 00:41:10 +0900
Message-ID: <20260615154111.2174161-17-den@valinux.co.jp>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260615154111.2174161-1-den@valinux.co.jp>
References: <20260615154111.2174161-1-den@valinux.co.jp>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TY6PR01CA0002.jpnprd01.prod.outlook.com
 (2603:1096:405:3bc::9) To TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:38f::10)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY7P286MB7722:EE_|TY6P286MB7549:EE_
X-MS-Office365-Filtering-Correlation-Id: ed6096d6-e8d5-44a3-f328-08decaf49402
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|10070799003|366016|376014|7416014|23010399003|921020|18002099003|22082099003|56012099006;
X-Microsoft-Antispam-Message-Info:
	R76HlKutN/Ch7PFsEU4F4sN7KoQ3tkes+k2f2yKKjHwX/IOssbQ3iTzWrvRM3xrGdcRQnLwlO5wcyX6j5uTjh0M1DqPRoZWH3yIkUAq2oh58A1ptXJP6LoeONXuwY68rql6L8l2fAfkd6SQWDoqbVSEhQHuD4QjJzed5OhS/JAUoctG57Rg90/v9hEpJHLnbrIigCiJGfo46E6zyeMM20lDkO/wBQ0fxt6TYngHqge4RNSseVmFAp1DahsjpPERSGkJAghJy3WjfDxzexcq2rlLDl5HB1QMjjGYvdtuYoWwdkA/ICXK81nzY/uGoNaOKwfzD9rXNRcGLpXjkB2SHwu0hKsF0nyl+xFZR4pNpAioiho794O5//ROgpj/D/euzS3ZDdIYL8ovDKorfkRGVQEnl42pn7Ev99v/iyJIlTBUI4RUt1CCHmiXmlQIaUmkyxw0GHjq1CTJiYw+zLsNmHlzaR3e40wk1bpSFfYRcmx+MJNFHa6fRXwPPIP2dTffwVWWrzTgMnPwckTOKKO+C0BvXR8NLPPt7NDLCS3zWUDOmphROFf+0ROf2rNGOwwjhm+rv/u93nhiRv1S6DfSVL+VONYch1JMede/BnvT7xybca5sH3QBQ87/VkYFd43uiiiC8DpqfBU/8+nEP0rNTRAfJ4aWwTlVBf/RgB4tqt8ld+jGwXEzqvxmKu4s+r5zr5MpCYqlN2NRWkhxopBPG76FebMNfARImBkKe038/4oQ=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(10070799003)(366016)(376014)(7416014)(23010399003)(921020)(18002099003)(22082099003)(56012099006);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?aH/x2kL+30gxhtXPIvUfPnqd15FwcaymLM0bOL945s3pka0y0TxsMxKTCbD6?=
 =?us-ascii?Q?MHnImHRMZYHjCSN6HZfXqxubAYruTMlUd0r9Sn6xbYa6C1iuDu26p/j+a7Hx?=
 =?us-ascii?Q?QXx9pUjENiC26uO2XLFdeyUu72HyXA9B3MSx2uEBYUPRfi4/o/AgcaQgmqyJ?=
 =?us-ascii?Q?HWDaCpS9qs6f0lBLQeEQBnp1NXSNgxbaW/FkQtviUEPeVzSa5H7/g7lEzU3W?=
 =?us-ascii?Q?tkZhjQ8VDtRDL5rWZ9UByong7rbB4NFWeTQbg3yPgMPuyXQkx7L+SRFlEgaN?=
 =?us-ascii?Q?ctCYBx9xDzffqOIzzs8CSnsqqMH550Bok36INBS9h8CRq9//DLhkXmX9BClc?=
 =?us-ascii?Q?kBGa5riboHXZbhWgIcDulPzSkLde8DibUakqU0q2BYmX9ukEUsoDFGG0VnI8?=
 =?us-ascii?Q?ONFWO5pcfFG2L+1d8eYo80sKU25vzNmndZzyzcixMYijeQQ9/EaCwTOUt5cp?=
 =?us-ascii?Q?y0yDDVWijsl6xid4lUDZJqgYcYRJNnRoYpbKmXF7/h7JVSV3Xdw9u0aVC5Z5?=
 =?us-ascii?Q?I/wilfj/4BmN8zB7HhxOAzxqNKUmrPeA8CEOb7O6MH5EBhS9jkmPJKrvDA0A?=
 =?us-ascii?Q?iQ3G5xr8Dg48hfczNhf0vXlHZfSodZoQ49eKfmDa4fyO6avaUuo8TUJMyGLR?=
 =?us-ascii?Q?8Kp+uaWwlkYPhLVYj8pYAfQ0rp3jj9PkDb6px7W35M210DCkqjmeF3ID20Mq?=
 =?us-ascii?Q?1Ubw0NoOUYiHIE+4s4hn9D/ligh7W3xyuju/Kt79KraUN5AKl5+cilXfsvLz?=
 =?us-ascii?Q?vDXyquX7CU99sm0E1kXdBlOLdLVW6TmlwWkfCv2uTsgLBwbs25uZ7SFZvFOQ?=
 =?us-ascii?Q?HfpQGKKMR468DFk1Aq3qs1YnVnmfz1439l9ZYdtkeoOfdHLtGNjcqNVQ1Q4H?=
 =?us-ascii?Q?ZQ8GsZdn1yTmrRRr0gtNQQcnGo4oXOZFy9IvEGCPCLu9n4sE16byqXsfmXHR?=
 =?us-ascii?Q?MSibuM4R21q2ur8EjY8VnMeAXQ6jXJuitJOF7s94AOWT8R0mT6u1RQTA93Xe?=
 =?us-ascii?Q?QVttiy4etJ3fAiivwyxzaWy9Z3vYXR2CIiVHHtBJZenH3VNNQ5+NNl5R7MHt?=
 =?us-ascii?Q?YESD2eFOfyTIVMC2K1KJm9z+ELEUA/uAs7YmgnGP1BO4juhl8Du0bmc+aOWU?=
 =?us-ascii?Q?4uo0MbPlT4ywclVsJ9D8V9FEwiPW5lTkM0v1Oc1N3p2qyCb4PHpq4RrPippD?=
 =?us-ascii?Q?tfKlALMkcVOIP/03UIkPIh0FZK6m4fEAYor0s/G+1rhiZDt866UX5SoU5n3X?=
 =?us-ascii?Q?Zp1YGqJZxxO3zn8XfdkxMK4C0RjKJWDkKR8va0YO9ALc6mXnKsUTVW/HfBr8?=
 =?us-ascii?Q?500XqWS1Jjm6U0Xctj4NG/Gs4yB8QGqbqOHpS4K8/qcBL3wZwIFh5hjAay8Y?=
 =?us-ascii?Q?8mCGNVNsbZck2o6qWDnHxn7nYFe0OrKgzCcYwcxZTyYzU9MCGsjLhQfo/qh+?=
 =?us-ascii?Q?WvwH1dLwG5nIRwMkU1KmACaFanKpc9WnrJ+4cl3+DqkQfVzPYCihqVX6q+58?=
 =?us-ascii?Q?aKoyv5pPJrvdvXXB9/62qXWQo+3Y7ovOgtRMmLQzdAdniSB5zqEmOvgFnt6g?=
 =?us-ascii?Q?HHXfnUCRNAneAEEPBtAB4obqj++StgoLfHMlN+eAu+5+av9QMn2vtQaYVodz?=
 =?us-ascii?Q?GGnwkCLDzA/bTCGIqqUx0SkBDNW1Jbw5Vh6ihc1jKwbAEUC6/o2nksLnEo9m?=
 =?us-ascii?Q?tOP5Oip/v3T40X1wcZkkXA2NrrCtmYMHmiIkU0Oc+vId/6nbvfY3um9yXOVW?=
 =?us-ascii?Q?8Enq/Cbs+h0IU+6H3IMlb00Tr9eM5vDaMLzrVuFHLvs8xNOrWTqd?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: ed6096d6-e8d5-44a3-f328-08decaf49402
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jun 2026 15:41:33.7722
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aUd7E6l6YiB1OEH7a9PyRiQeM48izHWi8Ee+zSIYxoQPSbpbODV8WzYCpWrcbc+lrcDcitQ+d9FmB2vVeu0BqA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY6P286MB7549
X-Rspamd-Action: no action
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[valinux.co.jp,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[valinux.co.jp:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-11538-lists,dmaengine=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TAGGED_RCPT(0.00)[dmaengine];
	DBL_BLOCKED_OPENRESOLVER(0.00)[valinux.co.jp:dkim,valinux.co.jp:email,valinux.co.jp:mid,valinux.co.jp:from_mime,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: DAD3D687D43

HDMA can stop after software has appended new LL entries. If that
happens without another interrupt, synchronous users polling tx_status()
can wait until timeout even though the channel has pending work.

Let tx_status() re-doorbell when the channel is stopped with pending LL
entries. Use the same recoverable-pending guard as the interrupt path so
paused channels are not re-kicked, and issue the recovery kick under
vc.lock so it is serialized with request/status updates and LL reset.

Do not use tx_status() as the normal running-progress path for HDMA.
HDMA has watermark interrupts for that. Polling the running LLP from
every dma_sync_wait() iteration adds MMIO and list-walk overhead, and
can duplicate the IRQ progress path. Keep LL polling in tx_status() for
eDMA, which has no separate progress interrupt, and for HDMA only when
stopped-pending recovery is needed.

For cores that do poll LL progress from tx_status(), avoid a second LL
progress pass in the stopped-pending recovery path. If the channel
stopped just after the first sample, re-doorbelling is enough for this
tx_status() call; a later interrupt or poll can observe further
progress.

Signed-off-by: Koichiro Den <den@valinux.co.jp>
---
 drivers/dma/dw-edma/dw-edma-core.c    | 35 ++++++++++++++++++++++++---
 drivers/dma/dw-edma/dw-edma-core.h    |  2 ++
 drivers/dma/dw-edma/dw-edma-v0-core.c | 23 ++----------------
 3 files changed, 36 insertions(+), 24 deletions(-)

diff --git a/drivers/dma/dw-edma/dw-edma-core.c b/drivers/dma/dw-edma/dw-edma-core.c
index 477fc63e2778..acf6cc8147a6 100644
--- a/drivers/dma/dw-edma/dw-edma-core.c
+++ b/drivers/dma/dw-edma/dw-edma-core.c
@@ -495,16 +495,45 @@ dw_edma_device_tx_status(struct dma_chan *dchan, dma_cookie_t cookie,
 	struct virt_dma_desc *vd;
 	unsigned long flags;
 	enum dma_status ret;
+	bool doorbell = false;
+	bool progress_sampled = false;
 	u32 residue = 0;
-	int idx;
+	int idx = -EINVAL;
 
 	ret = dma_cookie_status(dchan, cookie, txstate);
 	if (ret == DMA_COMPLETE)
 		return ret;
 
 	spin_lock_irqsave(&chan->vc.lock, flags);
-	idx = dw_edma_core_ll_cur_idx(chan);
-	dw_edma_ll_recycle_and_refill(chan, idx);
+	/*
+	 * eDMA has no separate progress interrupt, so tx_status() polls the
+	 * running LLP. HDMA uses watermark interrupts for normal progress and
+	 * only samples LLP here for the stopped-pending recovery below.
+	 */
+	if (chan->request == EDMA_REQ_NONE &&
+	    dw_edma_core_has_flags(chan, DW_EDMA_CORE_FLAG_TX_STATUS_POLL)) {
+		idx = dw_edma_core_ll_cur_idx(chan);
+		dw_edma_ll_recycle_and_refill(chan, idx);
+		progress_sampled = true;
+	}
+
+	if (dw_edma_ll_recoverable_pending(chan)) {
+		/*
+		 * Cores without tx_status() polling, such as HDMA, need a
+		 * stopped-channel LLP sample for recovery. Polling cores already
+		 * sampled progress above, so avoid a second pass here.
+		 */
+		if (!progress_sampled) {
+			idx = dw_edma_core_ll_cur_idx(chan);
+			dw_edma_ll_recycle_and_refill(chan, idx);
+		}
+
+		if (dw_edma_ll_pending(chan)) {
+			doorbell = true;
+			chan->status = EDMA_ST_BUSY;
+		}
+	}
+	dw_edma_core_ch_doorbell_recheck(chan, doorbell);
 	spin_unlock_irqrestore(&chan->vc.lock, flags);
 
 	/* check again because dw_edma_ll_clean_pending() may update cookie */
diff --git a/drivers/dma/dw-edma/dw-edma-core.h b/drivers/dma/dw-edma/dw-edma-core.h
index 27a0521c989c..1bacefb10a3b 100644
--- a/drivers/dma/dw-edma/dw-edma-core.h
+++ b/drivers/dma/dw-edma/dw-edma-core.h
@@ -17,6 +17,8 @@
 
 /* Force a doorbell after DONE IRQ handling to recover lost starts. */
 #define DW_EDMA_CORE_FLAG_DONE_IRQ_DOORBELL		BIT(0)
+/* Poll LL progress from tx_status() for cores without progress IRQs. */
+#define DW_EDMA_CORE_FLAG_TX_STATUS_POLL		BIT(1)
 
 #define EDMA_LL_SZ					24
 
diff --git a/drivers/dma/dw-edma/dw-edma-v0-core.c b/drivers/dma/dw-edma/dw-edma-v0-core.c
index a5ffb0e77602..15e4779cbc01 100644
--- a/drivers/dma/dw-edma/dw-edma-v0-core.c
+++ b/drivers/dma/dw-edma/dw-edma-v0-core.c
@@ -533,26 +533,6 @@ static int dw_edma_v0_core_ll_cur_idx(struct dw_edma_chan *chan)
 	if (!val)
 		return -EINVAL;
 
-	/*
-	 * Doorbell will be missed if DMA engine running, so last update
-	 * descriptor have not fetched by DMA engine, so DMA engine stop.
-	 *
-	 *	Most like issue happen at
-	 *
-	 *	  DMA Engine		|	SW
-	 *        ======================================
-	 *  1     send Read req for LL
-	 *  2					update LL
-	 *  3					doorbell
-	 *  4	  *Missed doorbell*
-	 *  5     Get old LL data
-	 *  6     DMA stop
-	 *
-	 * Workaround: Push doorbell again when found DMA stop.
-	 */
-	if (dw_edma_v0_core_ch_status(chan) != DMA_IN_PROGRESS)
-		dw_edma_v0_core_ch_doorbell(chan);
-
 	return (val - (paddr & 0xFFFFFFFF)) / EDMA_LL_SZ;
 }
 
@@ -572,7 +552,8 @@ static void dw_edma_v0_core_debugfs_on(struct dw_edma *dw)
 }
 
 static const struct dw_edma_core_ops dw_edma_v0_core = {
-	.flags = DW_EDMA_CORE_FLAG_DONE_IRQ_DOORBELL,
+	.flags = DW_EDMA_CORE_FLAG_DONE_IRQ_DOORBELL |
+		 DW_EDMA_CORE_FLAG_TX_STATUS_POLL,
 	.off = dw_edma_v0_core_off,
 	.ch_count = dw_edma_v0_core_ch_count,
 	.ch_status = dw_edma_v0_core_ch_status,
-- 
2.51.0


