Return-Path: <dmaengine+bounces-12296-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id zfZCMUytUGoy3QIAu9opvQ
	(envelope-from <dmaengine+bounces-12296-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Fri, 10 Jul 2026 10:29:00 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DAD373877A
	for <lists+dmaengine@lfdr.de>; Fri, 10 Jul 2026 10:29:00 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=valinux.co.jp header.s=selector1 header.b=PJ9DLbaa;
	dmarc=pass (policy=none) header.from=valinux.co.jp;
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-12296-lists+dmaengine=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="dmaengine+bounces-12296-lists+dmaengine=lfdr.de@vger.kernel.org";
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B52CE30416E2
	for <lists+dmaengine@lfdr.de>; Fri, 10 Jul 2026 08:22:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8071A3F0762;
	Fri, 10 Jul 2026 08:22:10 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from TYVP286CU001.outbound.protection.outlook.com (mail-japaneastazon11021110.outbound.protection.outlook.com [52.101.125.110])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C5F33EFD14;
	Fri, 10 Jul 2026 08:22:08 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783671730; cv=fail; b=OiQzVYJRMmh+35ATGhu2wpSaWT1Is1u/+xb+PrrUNjCB7VN0qQZdcqIETGB4js5masp8eECrC9UKZuaS2poNKV/kibrl8rOVK/02v1hoqkqeMz2VEBR480jnJ2f2xUyqOsHG5A3MWIyiV5EOJbTAVKbOoXsgHRzavMJffUgTGkE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783671730; c=relaxed/simple;
	bh=v5z855h+98vBtf8bpxG1vkRRZl0ZKVJdPvUXXxtGQAM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=LkNFwSbMl3h9t3nm0g6oXEoYjY4DH+In9eiD1ztM24T9lqAK1SBb5HGg4EPETMbPHdaXbljnsXTLpRx+o8q2fPjQfDRttvso6BE18O+f8yp9TQ2HaK2jw8Y6TzcN62McKIDIJOk3WEtbPkp/DRt9PkOIEE1EsgeK2VRGmegzoWw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=PJ9DLbaa; arc=fail smtp.client-ip=52.101.125.110
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZSYoaPEmb6DFG/1Y99xZM+DaX0JFMsvD2fBAB7hkGBGgmndC6LnDpiP1VNfo0LqYX/Ns3OKlvx7d/taNZdaHsaTsB4S1/GHwvlmUhM1UT5DWoVWD5JjTP+MJRikRvgj0r78/PYPoAKmfBmb5Ao63Qk5YhFxzng4ux7jz1P0JeDBi0d1WyHpqeD7dHIhfC+r1gQ+nqra627gBQj2vECNd9V14A5YY2e9m79Hfv4XUfCULHW74jh+HAaNS0Mrl447m8v9SszZC4ceS3xUFn9HpsmHQWUkS1Qr5T6ZmxprEhMxQOP0FvBJGe+wAYgfg89nKhDTEa5ZnsVY54zoAFS+CIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LmsIf88Il3Lwm5ooT87ERkd7Xyblumj9sAcrkgtzVps=;
 b=xi5XxAVQFc+zd82LQ7v4qmbUZBPCmFYaXefh9GAY630nb4gOKxrkXDTQDpbs7A2aFfdj3C+1NGh48UX0krxLFZSHziJ+SZ0Wvcmhg+yw45mJIOJio8f65b5TnWpyB7Qxob1q10zOose2Yc5RO1ySNfED99H6BCOmlznPcctyzAXhS9ihWQ9aJkHIJvuxMe7HPtcYa5nAJqQtUDB9ItfBt2ArICSXqm9WNpDWdNzn1x0HBJBrb5q7niWDqdpb7urQCUI8sZjKLFDXS0uRfiJ+vQTkGP+gnhxjbyqJnTVXOraUGZhqx8Z9lQXu3VG01uJOzQ8dA5zF2tL0x6+s7lrEAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LmsIf88Il3Lwm5ooT87ERkd7Xyblumj9sAcrkgtzVps=;
 b=PJ9DLbaa+oz85sxql2v8ZhiJnYYTZmsjvo7Fj6t+83izzVG0rHLwgZ0EJGJv7Y/DCgClgsT5k4z38PGI9VCO0VHg9cDX24MmGu1qOH2kzSZfi/LYm+Li3DsBCqDelML2rnF024hmsNWgKgC8OE+2iuAO6JqmROklQw+6E4oZZzo=
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:38f::10)
 by TY7P286MB6531.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:323::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.17; Fri, 10 Jul
 2026 08:22:05 +0000
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32]) by TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32%5]) with mapi id 15.21.0181.009; Fri, 10 Jul 2026
 08:22:05 +0000
From: Koichiro Den <den@valinux.co.jp>
To: Manivannan Sadhasivam <mani@kernel.org>,
	Vinod Koul <vkoul@kernel.org>,
	Frank Li <Frank.Li@kernel.org>,
	Jingoo Han <jingoohan1@gmail.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Kishon Vijay Abraham I <kishon@kernel.org>
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
	Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
	linux-kernel@vger.kernel.org,
	dmaengine@vger.kernel.org,
	linux-pci@vger.kernel.org
Subject: [PATCH v4 5/6] dmaengine: dw-edma: Add delegated channel request helpers
Date: Fri, 10 Jul 2026 17:21:55 +0900
Message-ID: <20260710082156.2395844-6-den@valinux.co.jp>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260710082156.2395844-1-den@valinux.co.jp>
References: <20260710082156.2395844-1-den@valinux.co.jp>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCP286CA0044.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:29d::17) To TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:38f::10)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY7P286MB7722:EE_|TY7P286MB6531:EE_
X-MS-Office365-Filtering-Correlation-Id: 67df2df8-145f-4056-7a3e-08dede5c534d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|376014|7416014|10070799003|1800799024|366016|56012099006|6133799003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	J1RCa5hrASl+drVnsGihzhxz/zn9rsftzYaaGt5RDLE5KVKbOGpTB+9Mf3k1Sm5TChGj5s4gNPpj7IVHxvQGvPlQWysZVWEYoQz5otzsAQdmuEvbl4LrL2PjezhQCbwxBTx2NfwqJJ4tCYavYFw0xVutvCOiZzD7DkBPKiuqEHF2GuZPdCtgp2Npi1ys1hykgiWoejgXqWUgQaV/mlZMr+XFtMtrq0ckToQO3nxHn5rPApDpNJVJfzfN2rR831Di4fiz4p71QTWiXKOTlWXYoOps1lS4NxQRi9n21pk8QTObgWoyQtHUD3od+XlqTSIHnUL4Zw5oBOrMPzP7mhcEHyCayMJA7XqbkVoymI8mWu/8OTem8C5afVQGOckbf59HWv0UtWqujrDL2RiQ/bNNS1h/7MhC1v997hTvf2xFZ73jGLa0squiarlan7QQ5mrEAjCebLBA1Cc0TE1t5EyC8K5SLeyThyPEqabb8WBXwHtITSBBkUAlJnv+IgevyV6NGn+LzvE1IQTln3iLct6P02LhdcbONTHn+VPFExUZOXXsMkgsGbF1b4JNwiPjePeljaEyZ8n9eE7TMDjjEBBK5Dg5XtBfehhLR8yUiNYeU0GrECihwGaUzKYYk4QTWB2XmeWUsTu5ovgbW/7+CGo/ssq+E8uLIGjIhVel2bvctFU=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(7416014)(10070799003)(1800799024)(366016)(56012099006)(6133799003)(22082099003)(18002099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?yWZCtHIga0v0QKPd9Z+E3ye/nni6uWIUZBmxz4Kn5VKuqutPZhBO2HH+d9gp?=
 =?us-ascii?Q?kV+aFq55Ay1J14IMOVKwfPDmpHLjaqzaHUpkSu/vvofkbRfnY2Ie8PzxjXmv?=
 =?us-ascii?Q?GJ74gsDITkvcxUdyACNYQatP3eGcXBlWu9nEEzqLK0Yp01W4f6kBoc8R54zj?=
 =?us-ascii?Q?n/sLT0Nw/c9lzGbh3xP0SyJMrticpvAbae+GvI0ZJ7AJd+zI5TeHys5Fhey0?=
 =?us-ascii?Q?JjC6ZGq4SYlqPjaoEU0VfhTnlczYFQiWgb2DIWZoLY6sDAtenusNKutyx4Lr?=
 =?us-ascii?Q?eVQzdLEwv3/BGrHqoYq/7BYpQX7I3ObG9AXCEZIK0vUX0OZFw/dFGAqnEB/T?=
 =?us-ascii?Q?OYYyWKkRPchKxyhnMxQaGUf1Gm5ZdIWG6AiYut4RW1cCf1xLzNSuiQEQ1T6h?=
 =?us-ascii?Q?eiPjJf25oeMczthbQYVJiORxQ8J3CbghIONK+uc39MYLv5S4RzS8FgBnaa+F?=
 =?us-ascii?Q?CMIkmGZw2keLMdTBvR10cL/gav9e0t3bHzYsmqZILMCjtgumpaPqYgtMW3Ja?=
 =?us-ascii?Q?uufWNPJ9ZwI9Qx87vp4FMEHefRmW6FSg0GUe++W/zem2bD0kbWMN2Nb4Znlh?=
 =?us-ascii?Q?9W++PQhsVhdOvgSiFtrRpZtzOlqt3onNbBZKJ8Ou5MlBRPrvKuY84vehx3Kd?=
 =?us-ascii?Q?L/kOfqVcSXVHg8itpAT0/ox/A3f7047t0bVEANjecIlsPLdHxfdryfJOBI5c?=
 =?us-ascii?Q?59m969oLN0PhLFGL3dVUjfQa4l4E3RByPQwQ4qLJzfnBYwAZgKHh8yMxcq2s?=
 =?us-ascii?Q?TLlttGbEjDbK+Z+/HGylW7RrV1rvhGu2YfWYmUKWjyTGCBCr8fjrFQL5Ijfo?=
 =?us-ascii?Q?IVeKiLYhgLPp9ddUFnZOZs0iuXk6rUXT904ywspl1cOzrz4jbpEI7j7XI0V1?=
 =?us-ascii?Q?1MVbQ/iIqEmfLZS7lteSDSyCiwa38yP0ErSwBru7LXZedIaGMg+LszoldFwR?=
 =?us-ascii?Q?xjDSfRd5djU/z13NdgKsBWuIfWnkmy7pXzYrofwFTHu1Y3tSyCZdGdA7W5ZG?=
 =?us-ascii?Q?mdzj8G8XNrezP1BPwM9ZmDMkga6Fz/6CVgAfv3c0JiHVUs77Y1Zr4RPEMqN4?=
 =?us-ascii?Q?fJLvDvcu4MH7sywA9iLXiNlNnpbrdp4d4GRvWUIOZ/UQzuMrg7A4/Teakpha?=
 =?us-ascii?Q?jFW8Wci58Sqv/tUn2+typ/sRpBjxWlMiSvkx4ZBRxbcEQ49gTvFY82JRegh+?=
 =?us-ascii?Q?+uVWwGUXeaTqZRbg0GLRrXS+ivOCHzl+PDpHEha5EEz4OEABrh6kLW1d4G5A?=
 =?us-ascii?Q?YRvVV3Pcak1ygMY4aJpw8G/Oepg22GGFTxE0FOdhdkIrxgHQJ1C8xK8knwIw?=
 =?us-ascii?Q?Cnqg9BY4FEahUsBBgxJh4Zh8ZF8g/ouraMP5yeP/5rCjcz5qDOr2phgpCziW?=
 =?us-ascii?Q?cQUEyndh5n0wD/2CLNi0/WQR7xV0/KB6/p3IB6Wz+8qMiaLuU+Yxv+o4sNk3?=
 =?us-ascii?Q?i9QuZz7eq7B6sRrUoPr5cIc/+fAZOQORJuSmxqnjx+jPCGAts58MvynTitdT?=
 =?us-ascii?Q?Dc37/gdG3iOCxT5Xop/ESdB0rP6CS/VuPrVsF/ROLYv1vRJXdATP81aWG1VS?=
 =?us-ascii?Q?OheZG1uIlSgBRNVBXJkOj1JLSs+u+i3W6NNs9J5nS5vWTZ2LzsuFFxgzy8vV?=
 =?us-ascii?Q?ZBRQDlpgsp7h0zcS/+V14Aco7vLnM8MG9JrURqE1a9hJe2XUYq/t8W1czm4M?=
 =?us-ascii?Q?4lTv6iHTSYFxLjvk7MpQREF8DDu6ezr4AJG7XfsJFx4oAt/KQfidAwi1xYX3?=
 =?us-ascii?Q?KzCNV7KsoBnMlgQEFz1qCDrf0llmEr+r6TPH1PXRzpEWey4P+nNp?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: 67df2df8-145f-4056-7a3e-08dede5c534d
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2026 08:22:04.9846
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9GHTaa1NdCu5i90z4I34xMtl8QV06vZpjZQyDKOvI2uNtF25IuBXJyC2HAfYmziAdoZpgOVyDI+n77zEoHESDQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY7P286MB6531
X-Rspamd-Action: no action
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[valinux.co.jp,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[valinux.co.jp:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-12296-lists,dmaengine=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[14];
	FREEMAIL_TO(0.00)[kernel.org,gmail.com,google.com];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:mani@kernel.org,m:vkoul@kernel.org,m:Frank.Li@kernel.org,m:jingoohan1@gmail.com,m:lpieralisi@kernel.org,m:kwilczynski@kernel.org,m:robh@kernel.org,m:bhelgaas@google.com,m:kishon@kernel.org,m:marek.vasut+renesas@mailbox.org,m:yoshihiro.shimoda.uh@renesas.com,m:linux-kernel@vger.kernel.org,m:dmaengine@vger.kernel.org,m:linux-pci@vger.kernel.org,m:marek.vasut@mailbox.org,s:lists@lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[dmaengine,renesas];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp,valinux.co.jp:from_mime,valinux.co.jp:email,valinux.co.jp:mid,valinux.co.jp:dkim]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 3DAD373877A

Endpoint functions that expose endpoint-local DesignWare eDMA channels
to a remote host need to reserve exact hardware channels and hand
interrupt ownership to the remote side before publishing the channels.

Add DW eDMA-specific helpers that request a write/read hardware channel
through DMAengine, keep the hardware-channel filter private to dw-edma,
and switch the selected endpoint-local channel to remote interrupt
routing after the channel has been successfully reserved. The matching
release helper can quiesce the channel while it is still remote-routed,
then restores the channel's default routing before releasing the
DMAengine reservation. This lets callers skip quiesce when unwinding a
reservation that was never exposed to host programming.

Signed-off-by: Koichiro Den <den@valinux.co.jp>
---
Changes in v4:
  - Moved from part 1 series into this endpoint DMA resource series.
    (Sashiko)

 drivers/dma/dw-edma/dw-edma-core.c | 86 ++++++++++++++++++++++++++++++
 include/linux/dma/edma.h           | 14 +++++
 2 files changed, 100 insertions(+)

diff --git a/drivers/dma/dw-edma/dw-edma-core.c b/drivers/dma/dw-edma/dw-edma-core.c
index d1af44124075..3560630f3b94 100644
--- a/drivers/dma/dw-edma/dw-edma-core.c
+++ b/drivers/dma/dw-edma/dw-edma-core.c
@@ -1377,6 +1377,92 @@ int dw_edma_remove(struct dw_edma_chip *chip)
 }
 EXPORT_SYMBOL_GPL(dw_edma_remove);
 
+struct dw_edma_delegated_chan_filter_args {
+	struct device *dma_dev;
+	bool write;
+	u16 id;
+};
+
+static bool dw_edma_delegated_chan_filter(struct dma_chan *dchan, void *param)
+{
+	struct dw_edma_delegated_chan_filter_args *filter = param;
+	struct dw_edma_chan *chan;
+
+	if (!filter || dchan->device->dev != filter->dma_dev)
+		return false;
+
+	chan = dchan2dw_edma_chan(dchan);
+
+	return chan->dir == (filter->write ? EDMA_DIR_WRITE : EDMA_DIR_READ) &&
+	       chan->id == filter->id;
+}
+
+static int dw_edma_delegate_chan(struct dma_chan *dchan)
+{
+	struct dw_edma_chan *chan = dchan2dw_edma_chan(dchan);
+	unsigned long flags;
+	int ret = 0;
+
+	if (!(chan->dw->chip->flags & DW_EDMA_CHIP_LOCAL))
+		return -EINVAL;
+
+	spin_lock_irqsave(&chan->vc.lock, flags);
+	if (chan->configured || chan->status != EDMA_ST_IDLE ||
+	    chan->request != EDMA_REQ_NONE)
+		ret = -EBUSY;
+	else
+		chan->irq_mode = DW_EDMA_CH_IRQ_REMOTE;
+	spin_unlock_irqrestore(&chan->vc.lock, flags);
+
+	return ret;
+}
+
+struct dma_chan *dw_edma_request_delegated_chan(struct device *dma_dev,
+						bool write, u16 id)
+{
+	struct dw_edma_delegated_chan_filter_args filter = {
+		.dma_dev = dma_dev,
+		.write = write,
+		.id = id,
+	};
+	struct dma_chan *dchan;
+	dma_cap_mask_t mask;
+
+	if (!dma_dev)
+		return NULL;
+
+	dma_cap_zero(mask);
+	dma_cap_set(DMA_SLAVE, mask);
+
+	dchan = dma_request_channel(mask, dw_edma_delegated_chan_filter,
+				    &filter);
+	if (!dchan)
+		return NULL;
+
+	if (dw_edma_delegate_chan(dchan)) {
+		dma_release_channel(dchan);
+		return NULL;
+	}
+
+	return dchan;
+}
+EXPORT_SYMBOL_GPL(dw_edma_request_delegated_chan);
+
+void dw_edma_release_delegated_chan(struct dma_chan *dchan, bool quiesce)
+{
+	struct dw_edma_chan *chan;
+
+	if (!dchan)
+		return;
+
+	chan = dchan2dw_edma_chan(dchan);
+	if (quiesce)
+		dw_edma_core_ch_quiesce(chan);
+	chan->irq_mode = dw_edma_get_default_irq_mode(chan);
+	dma_release_channel(dchan);
+}
+EXPORT_SYMBOL_GPL(dw_edma_release_delegated_chan);
+
 MODULE_LICENSE("GPL v2");
 MODULE_DESCRIPTION("Synopsys DesignWare eDMA controller core driver");
 MODULE_AUTHOR("Gustavo Pimentel <gustavo.pimentel@synopsys.com>");
diff --git a/include/linux/dma/edma.h b/include/linux/dma/edma.h
index 64044451d182..0e29db0450bf 100644
--- a/include/linux/dma/edma.h
+++ b/include/linux/dma/edma.h
@@ -152,6 +152,9 @@ struct dw_edma_chip {
 #if IS_REACHABLE(CONFIG_DW_EDMA)
 int dw_edma_probe(struct dw_edma_chip *chip);
 int dw_edma_remove(struct dw_edma_chip *chip);
+struct dma_chan *dw_edma_request_delegated_chan(struct device *dma_dev,
+						bool write, u16 id);
+void dw_edma_release_delegated_chan(struct dma_chan *chan, bool quiesce);
 #else
 static inline int dw_edma_probe(struct dw_edma_chip *chip)
 {
@@ -162,6 +165,17 @@ static inline int dw_edma_remove(struct dw_edma_chip *chip)
 {
 	return 0;
 }
+
+static inline struct dma_chan *
+dw_edma_request_delegated_chan(struct device *dma_dev, bool write, u16 id)
+{
+	return NULL;
+}
+
+static inline void dw_edma_release_delegated_chan(struct dma_chan *chan,
+						  bool quiesce)
+{
+}
 #endif /* CONFIG_DW_EDMA */
 
 #endif /* _DW_EDMA_H */
-- 
2.51.0


