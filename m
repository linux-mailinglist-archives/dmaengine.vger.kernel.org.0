Return-Path: <dmaengine+bounces-12308-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id AdnCLqOuUGqO3QIAu9opvQ
	(envelope-from <dmaengine+bounces-12308-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Fri, 10 Jul 2026 10:34:43 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 14ED9738881
	for <lists+dmaengine@lfdr.de>; Fri, 10 Jul 2026 10:34:43 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=valinux.co.jp header.s=selector1 header.b=DYQq9OEO;
	dmarc=pass (policy=none) header.from=valinux.co.jp;
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-12308-lists+dmaengine=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="dmaengine+bounces-12308-lists+dmaengine=lfdr.de@vger.kernel.org";
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 84D57303D131
	for <lists+dmaengine@lfdr.de>; Fri, 10 Jul 2026 08:28:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2C0B3F1AA3;
	Fri, 10 Jul 2026 08:27:45 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from TY3P286CU002.outbound.protection.outlook.com (mail-japaneastazon11020121.outbound.protection.outlook.com [52.101.229.121])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 908D23F1654;
	Fri, 10 Jul 2026 08:27:43 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783672065; cv=fail; b=Z5gfkpPEzO6CrhPoSue7L1JdwlYjl9YCZ6JePZCXLPgYT6g91X2UTnljDuZQlz6bRq3pQ2Vd3ycj7L8I1Y6555Xt2X6q/XLag9NKZhet1eXs6C+mwE380+XBZpEHUpQdlBtFUKrUnFgwiEdIAHd1fxbwQHv3cTJJDVgpsFszqL8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783672065; c=relaxed/simple;
	bh=hSua+bIkcQIVCITMgRrSJEeJBTX+glAySxWt1R+wN2A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=rqvkqOjcBQ2vtFQUq+H8jW0C0AZajGRJWN3HELvyjTckQcxzl5nl9NaOdyrG4zcgc40KOIpR4uvqjG/tgF/yHUO9gVjt6KrIoEonrsnEcbh3wBiiSAuwIFO4lisIm7820ccUVYbShNTA+Bt9XEz93MdsU+WkaAtp6HS5u3pW95Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=DYQq9OEO; arc=fail smtp.client-ip=52.101.229.121
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qhlTbiW4IxzBgD7Qs+sZwHW+X0ShzlOP1Z9axkhYyYPQR0v4kKhd+9ojAs7EAyeQWgiaJm6FrDQ8TSckfKw80CGCcV81fK/StWphDklBoQXX7cnnM6BPZ4O7sqJclcoyvRq5TR34rnVSM8P4rutNsVaM/AE0IdiCn3YVmDeFh6obpOeDXkhLT5VYdaRdlzpDV3HoU/rLxkhvulnVBijaog0rTegxqpLF7Jr90QJxtm+EpMl6DnOoQI43bQ0fUdJMeuTUxx/5hfGjJ0f3t7SYkKRRWZ//Vb6fz6mHc9LegPXhKW+47y6e6QzHX1xUHtRYRaUm+zJrwXTeWUMe+BC27g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QlPkesWF1mK+xSzSrZiHr0qIs3rTBH0N9ggHj++GwYg=;
 b=TrCmFlGd7cEISr9LPBfJri+BjQ3NVItKtq9tDaXsOct0KSgbITJW5Wt/Z8GYl52sSvLElTQjkM2J99wSt8NEOj0aOVXW6VaGpQwR2Ehn4DVslxqqJOKLM+iY8akAuih59B/C00E2V1fDfME/dre72EVnEr3CrDV3bXamiJCPoLTzWzj0jhz2Y47khJoAAPIw+6kLOris76N70s5s+5H4hyqUaDsan3M3VOtpg/WAWKRDN7MN2waxpTTWECtcDItezR/+2nA0dtDvjDfSjeEtrE1TNIcN/rfkmy7vfsOoPkWVBmR3Xb9s/gaRQtZ7vfpyIjXuUS7Biom7TPU5wAmH9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QlPkesWF1mK+xSzSrZiHr0qIs3rTBH0N9ggHj++GwYg=;
 b=DYQq9OEOsuwE67HCVT6d5KxTAvO05In8ysbHwch9gJmjzEHYzeu+aFPHIacw3y9vcHywqJcK/oPJYqhocHVDI6+jj+YXHJUz9Ylojw/6ZTfEMKUHfF6qJgWIsJ2dX6bGL4Uf5+ozOSAzLVOQa8ZLnp8vYv5iFSYejaKD7EJcyoA=
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:38f::10)
 by OS7P286MB7001.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:433::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.16; Fri, 10 Jul
 2026 08:27:34 +0000
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32]) by TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32%5]) with mapi id 15.21.0181.009; Fri, 10 Jul 2026
 08:27:34 +0000
From: Koichiro Den <den@valinux.co.jp>
To: Manivannan Sadhasivam <mani@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Vinod Koul <vkoul@kernel.org>,
	Frank Li <Frank.Li@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Damien Le Moal <dlemoal@kernel.org>,
	Niklas Cassel <cassel@kernel.org>
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
	Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
	linux-pci@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	dmaengine@vger.kernel.org
Subject: [PATCH v4 3/3] Documentation: PCI: Add PCI DMA endpoint function documentation
Date: Fri, 10 Jul 2026 17:27:27 +0900
Message-ID: <20260710082727.2397253-4-den@valinux.co.jp>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260710082727.2397253-1-den@valinux.co.jp>
References: <20260710082727.2397253-1-den@valinux.co.jp>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCP286CA0172.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:3c6::10) To TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:38f::10)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY7P286MB7722:EE_|OS7P286MB7001:EE_
X-MS-Office365-Filtering-Correlation-Id: aaa9987f-cdea-472f-8cc2-08dede5d1783
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|10070799003|376014|7416014|23010399003|22082099003|18002099003|3023799007|6133799003|56012099006|921020;
X-Microsoft-Antispam-Message-Info:
	rVXW53cNlPr+v/f0HRuxq2zxkTUkFBEyvsrGQmTao7Mao+exxSCpOW0ntEIS+Q/1bzputJ9JEothTawyyjPZ+/QgDFOElV572V/9kcf1ooh99Uy/7JB/50HunoyvOH0LmhUVhc20Xr+frpCBArh/2+n1JZy0azkXTOwY/713ESV3lgNjEFKdOo6di/YR8wQmhE9acuozLiBykdga7RJ9rDIXMj0an+VXbOCsedZvFquCFQLfemWnAXx2f70QDpn3jQiqOsOM4e2XEHuCIlaSX+e7d6KQVzctx6M1cnrbwpVamy9/lQ/YtITxBcV1fhyPsWz8tdPGVZG0xYs+en7CZMyRxJzjganOmot9D0BEI7mXW1FuQJVeY5XSAqNq6LvQpJYT6wt3FPJ82+IntBHQAVNt4YpOeFT7dcZg8meqLGwVmcXKOfXiYGsC7eQgt8nSvwUlFl7gzHw6RHIxrsAO6Xgi+qgVRadVgUXw3LsqBiP2xJl9DrwNIr3pJjEMn4imXq1qYqs3/mQR9DzpDmsIfzpndTP6oGg7EkCyXVpecQWrD9AzyyxRRJOQwj9Uw/TJUh06wbdlaCqOdlAtNw8ZlIoEtbN5SOccMkBPhkA3TOfsnQgwq28ZNSXCiD8XdsMAkVZyae3MesRcreEDMDyl4f094eSlbwkd4RHj2Db2vrrkKV0wedctGSQ4tmCuQMoYq4NVTFcTEr55ZtYxvCyOTw==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(10070799003)(376014)(7416014)(23010399003)(22082099003)(18002099003)(3023799007)(6133799003)(56012099006)(921020);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Oa5skHwmT17NeC5wIaye9k7Z4/CY1F1pvLULWVexGtL93pE1gw0P4PDmkhGp?=
 =?us-ascii?Q?VmYdez/s8Gm1uhRbR8thDaHl7jCv/+WRPjPsntapm/PuNZdzSm8ArK+8fmfK?=
 =?us-ascii?Q?yiOXIbkdvF7c33aTopKI0wGQohGxrJ4FYq1ww25qK7GshLwvQ5/51nnzBkqP?=
 =?us-ascii?Q?UQD6e9bzicaMO5KQesAFeYNXhHqPzV0yzxi9lJokHF8G7O74dItYmADokHYA?=
 =?us-ascii?Q?zUXH3nXrRUiaewy/g3a7iXRo/FcSLV2ldbxiYNGLS2A/Jdxh0H1nycz7aot1?=
 =?us-ascii?Q?nw4rhfuts+6Y3jd3Cxky2+6eyDtDDJb56ZkhAJe/1/NVSkooX+gdU1S5IssS?=
 =?us-ascii?Q?wWpz1sO9l9XNduG8Pzd7vzWJ9h2SHHbcfeF8oP/qdPeAn3j+ohkYRkFpT9Jz?=
 =?us-ascii?Q?2Ny6fdSYG13q4+SJ4kjda7LItjs9hIH4/nd6/+LRmVacZ4sFEvcJLzxo7nhW?=
 =?us-ascii?Q?aP2FQPhELlRUX8JkXNwQvw9XAOh4MxvRNee0DebqLyRv8JGrzGl+GFbrq02h?=
 =?us-ascii?Q?BLxumYGTsPBFT7ZNc2QShVmVttw+Bzu4k40M9nxn8ePSzXUH/ZNbI71F2BcN?=
 =?us-ascii?Q?Z/14jCEUxIGMnXOUeY+wBSVtYaQ0Q2aKmKPqKpc5NXgVxgOkM5JTrqwrpSpU?=
 =?us-ascii?Q?OSP7riEjZJNCO8TsyOkDl8Ute/dsLxi92wjMloyiQ4pHwcj7qvqNrTk0n5pu?=
 =?us-ascii?Q?BX/Xir3IS5sGW3kTl5QPydImfrqemu7pGYycKwn3LeWfv0afdmMWPhcAowFR?=
 =?us-ascii?Q?kuBfjfVBeKKuE1ofoQ2I29jKIYb9jdNWHZT0Y4HiqnN1JYELo3AT0P5BzT4z?=
 =?us-ascii?Q?gU2YrNPESbg7V9/fLrEb0TQpDIXEcYi8Fz9DKPG+MpTA1XZIkKCT0xNcQesS?=
 =?us-ascii?Q?xtCyEbZg7i/Dut3fhAWOlhl6+cf7yFgfZL27omkeHnuu0lzYN1iasWvISiKz?=
 =?us-ascii?Q?rOkIKXCEJxVeXscUPkZiBFmCQCX3By4xlevUBOCcl3IYa4iMtg1OjTHhTi5V?=
 =?us-ascii?Q?wJIjvlBXpdmjBt6juTc6mI65DZN3tDIwljTWagKQwLeRX5lzcUki4/G6EmRI?=
 =?us-ascii?Q?PpmvDEEJJxN4YPv5gntXpaTTNRAxoj1GhM3v0lTddwJzCz00uhUo9A1+7KgW?=
 =?us-ascii?Q?avK7re3FS+SCD9blIZMQSHOOut7Pbjt6f6KWkFKLXytcSGNAPV0FpQrY3SWf?=
 =?us-ascii?Q?XewVvCh5ogRFho0lISEBUeKtnnikhHrD9sfHmHwyFs14R9BqWxv1pls9TtXj?=
 =?us-ascii?Q?OeKccPH/wT89gj2H1USvuPiTO58D+CAud8w8eqMnwm5BSJcbZt3kHCxMKS+J?=
 =?us-ascii?Q?7df8Ds/7QUfVComu6Tek3u4qXuRrtBT6I6a015TckPcQ9QJjwqsv0Tka5m7Q?=
 =?us-ascii?Q?JQs0V3TIqasVOJtzcTeaGN9t9MJaAV5XENDqAmpjNYfrjEcDK/mFGGFy2zv3?=
 =?us-ascii?Q?RFXuvJ4Uu2uVZpPA+Wzj5KtRT9GgItKtcylcHwS0zdyUbT46nk7c/thwRava?=
 =?us-ascii?Q?0BvPtRU4ohvy+RBP1tprYn99AZNbzitOA0/4PGZFf/s1nXrlG01qT+dK+F9V?=
 =?us-ascii?Q?XT0xd6xn1eyE4kFbcn24Ygd2su4ie3ycdYRbK9YfafyXg7Lj6cHazbyq6NPX?=
 =?us-ascii?Q?WrBSf2L2/hYgzIyJdTE4MALjQBamXwjuiiBwJu1/B4nmmAkSUOS+gcmY+N58?=
 =?us-ascii?Q?ZXXLAAFlDcHbyAaLJhgF2wWeBTjDLRlamGsCwuLAjCwEuacCysx/8JO1Qe+6?=
 =?us-ascii?Q?SlPpre1jwKNexKczFnSnvyBGGfE6S9JOfR0Yi1C8w4yTKcYPQ0Ft?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: aaa9987f-cdea-472f-8cc2-08dede5d1783
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2026 08:27:34.1672
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: N7nZzdsJDvTPnpmTTXNq2LDts5VAWXmduotDquxtQ3IPYJH59Y5skCwsgpix1nDaSrpaqakulgDMWm5w6Du/lQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS7P286MB7001
X-Rspamd-Action: no action
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[valinux.co.jp,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[valinux.co.jp:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER(0.00)[den@valinux.co.jp,dmaengine@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[17];
	TAGGED_FROM(0.00)[bounces-12308-lists,dmaengine=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:mani@kernel.org,m:kwilczynski@kernel.org,m:kishon@kernel.org,m:bhelgaas@google.com,m:corbet@lwn.net,m:skhan@linuxfoundation.org,m:vkoul@kernel.org,m:Frank.Li@kernel.org,m:arnd@arndb.de,m:dlemoal@kernel.org,m:cassel@kernel.org,m:marek.vasut+renesas@mailbox.org,m:yoshihiro.shimoda.uh@renesas.com,m:linux-pci@vger.kernel.org,m:linux-doc@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:dmaengine@vger.kernel.org,m:marek.vasut@mailbox.org,s:lists@lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[dmaengine,renesas];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,infradead.org:email,valinux.co.jp:from_mime,valinux.co.jp:email,valinux.co.jp:mid,valinux.co.jp:dkim]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 14ED9738881

Add a function description and a user guide for pci-epf-dma. Describe
the BAR-resident metadata consumed by dw-edma-pcie, the configfs
attributes, endpoint controller requirements and the host-side DMAengine
usage model.

Suggested-by: Randy Dunlap <rdunlap@infradead.org>
Signed-off-by: Koichiro Den <den@valinux.co.jp>
---
Changes in v4:
  - No changes.

 Documentation/PCI/endpoint/index.rst          |   2 +
 .../PCI/endpoint/pci-dma-function.rst         | 188 ++++++++++++++++
 Documentation/PCI/endpoint/pci-dma-howto.rst  | 201 ++++++++++++++++++
 3 files changed, 391 insertions(+)
 create mode 100644 Documentation/PCI/endpoint/pci-dma-function.rst
 create mode 100644 Documentation/PCI/endpoint/pci-dma-howto.rst

diff --git a/Documentation/PCI/endpoint/index.rst b/Documentation/PCI/endpoint/index.rst
index dd1f62e731c9..cd4107e02ec2 100644
--- a/Documentation/PCI/endpoint/index.rst
+++ b/Documentation/PCI/endpoint/index.rst
@@ -15,6 +15,8 @@ PCI Endpoint Framework
    pci-ntb-howto
    pci-vntb-function
    pci-vntb-howto
+   pci-dma-function
+   pci-dma-howto
    pci-nvme-function
 
    function/binding/pci-test
diff --git a/Documentation/PCI/endpoint/pci-dma-function.rst b/Documentation/PCI/endpoint/pci-dma-function.rst
new file mode 100644
index 000000000000..4de02553f5ff
--- /dev/null
+++ b/Documentation/PCI/endpoint/pci-dma-function.rst
@@ -0,0 +1,188 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+================
+PCI DMA Function
+================
+
+:Author: Koichiro Den <den@valinux.co.jp>
+
+The PCI DMA endpoint function exposes an endpoint-integrated DMA controller
+to the PCI host as a PCI DMA controller.  A matching host-side driver
+discovers the endpoint DMA metadata and registers the delegated channels with
+the Linux DMAengine framework, so host DMAengine clients can submit
+transfers.
+
+An endpoint Linux system can already use an endpoint-integrated DMA
+controller locally through the normal DMAengine API, for example to transfer
+data between endpoint memory and host addresses reachable over PCI.  The PCI
+DMA function provides a different ownership model: it delegates selected
+local DMA channels to the host, so a host DMAengine client can request and
+program those endpoint-side channels through the host's DMAengine API.
+
+To make that possible, the endpoint function publishes the DMA controller
+register window and descriptor memory layout to the host, reserves the
+selected local DMA channels on the endpoint side, and lets the host program
+those channels directly.
+
+Constructs Used for Implementing DMA
+====================================
+
+The PCI DMA function uses the following endpoint-side resources and
+configuration:
+
+	1) DMA controller register window
+	2) DMA descriptor memory for endpoint-to-RC channels
+	3) DMA descriptor memory for RC-to-endpoint channels
+	4) MSI or MSI-X interrupt vectors selected through configfs
+	5) One endpoint BAR used to publish metadata
+	6) If needed, one endpoint BAR used for dynamically mapped DMA windows
+
+The endpoint controller reports the DMA controller register and descriptor
+resources through the endpoint auxiliary resource interface.  The PCI DMA
+function uses those descriptions to build the host-visible metadata and to map
+resources that are not already visible to the host.
+
+DMA Controller Register Window
+------------------------------
+
+It contains the DMA controller registers programmed by the host-side driver
+to submit transfers, control channels and handle DMA interrupts.
+
+DMA Descriptor Memory
+---------------------
+
+It contains the descriptor memory used by the DMA controller.  The PCI DMA
+function exposes descriptor memory for the delegated endpoint-to-RC and
+RC-to-endpoint channels.
+
+MSI/MSI-X Interrupt Vectors
+---------------------------
+
+They are used by the delegated DMA channels to signal completion and error
+conditions to the host-side driver.
+
+Metadata BAR
+------------
+
+It is the endpoint BAR used to publish the endpoint DMA metadata and handshake
+bits.  The BAR remains stable while the endpoint function programs the DMA
+windows.
+
+DMA Window BAR
+--------------
+
+It is the endpoint BAR used for DMA resources that are not already visible
+through a fixed BAR.  The endpoint function may switch this BAR to subrange
+mapping after the host-side driver has found the metadata BAR.
+
+BAR Metadata
+============
+
+The endpoint function places a small metadata block at the beginning of the
+selected metadata BAR.  The format is defined in
+``include/linux/pci-ep-dma.h``.
+
+The host-side driver scans the function's assigned memory BARs, looks for the
+endpoint DMA metadata magic, requests DMA window programming, waits for the
+READY bit, and then parses the metadata to find the DMA register window and
+descriptor windows.
+
+::
+
+	+----------------------+ metadata BAR offset 0
+	| endpoint DMA metadata|
+	+----------------------+
+	| optional padding     |
+	+----------------------+
+
+	+----------------------+ DMA window BAR offset 0
+	| mapped DMA resources |
+	+----------------------+
+	| optional padding     |
+	+----------------------+
+
+The metadata can also reference resources that are already host-visible
+through fixed BARs.  For example, an endpoint controller may expose the DMA
+controller register window at a fixed BAR offset while descriptor memories
+are mapped into the DMA window BAR by the endpoint function.
+
+The metadata is BAR-resident instead of a self-contained PCI Vendor-Specific
+Extended Capability (VSEC).  Some endpoint controllers do not provide writable
+configuration-space backing storage large enough for a new VSEC payload, while
+they can map endpoint memory and controller resources into a BAR.
+
+Channel Ownership
+=================
+
+The ``wr_chans`` attribute exposes endpoint-to-RC DMA write channels.  The
+``rd_chans`` attribute exposes RC-to-endpoint DMA read channels.  The function
+reserves the selected endpoint-side DMAengine channels so that endpoint-side
+DMAengine clients cannot allocate and use the same hardware channels while
+they are delegated to the host.
+
+The current metadata revision describes channels in dense, zero-based order.
+For example, ``wr_chans = 2`` exposes write channels 0 and 1.  Skipping a
+hardware channel in the middle of the exposed range is not supported.
+
+DesignWare eDMA unroll and HDMA compatible layouts require each exposed
+direction to be delegated as a whole.  For example, on a controller with two
+write channels, ``wr_chans`` must be either 0 or 2.  DesignWare HDMA native
+linked-list mode uses per-channel registers, so a smaller dense prefix can be
+delegated.
+
+Interrupts
+==========
+
+The PCI DMA function exposes DMA interrupts through MSI or MSI-X.  The common
+endpoint function ``msi_interrupts`` and ``msix_interrupts`` configfs attributes
+select the interrupt vector counts programmed into endpoint config space.  At
+least one MSI or MSI-X vector must be configured before the function is bound
+to an endpoint controller.
+
+Transfer Addressing
+===================
+
+The host-side DMAengine client supplies the endpoint memory address as the
+DMA slave address.  For example, the ``dw-edma-pcie`` endpoint DMA metadata
+parser passes that slave address to the DMA controller as a raw endpoint-side
+address instead of translating it through a host PCI BAR resource.
+
+The host memory buffer used as the other side of the transfer is still mapped
+using the normal DMA mapping API on the host.
+
+Endpoint Controller Requirements
+================================
+
+The endpoint controller driver must expose the DMA controller register
+window and per-channel descriptor memories through the endpoint auxiliary
+resource API.  Endpoint controllers with other DMA register layouts also need
+matching metadata and host-side DMAengine driver support.
+
+Current DesignWare endpoint DMA support exposes only channels with descriptor
+memory; HDMA native non-linked-list mode is not supported yet.
+
+If any DMA resource is not already host-visible through a fixed BAR, the
+endpoint controller must also support BAR subrange mapping and dynamic inbound
+mapping, because the DMA window BAR is assembled from those resources.
+
+Current Support
+===============
+
+The current host-side support is implemented in ``dw-edma-pcie`` for
+DesignWare eDMA unroll, HDMA compatible and HDMA native linked-list layouts.
+Other PCIe controller DMA implementations need corresponding host-side
+DMAengine driver support.
+
+The ``dw-edma-pcie`` PCI ID table does not contain a generic endpoint DMA PCI
+ID entry.  Users need to bind the host-side driver explicitly using
+``driver_override``.
+
+The current metadata revision requires the exposed channels to be a dense
+prefix of the hardware channel numbers.
+
+Security Model
+==============
+
+The interface is intended for trusted endpoint/host deployments.  A delegated
+DMA channel can access endpoint memory addresses supplied by a host DMAengine
+client.
diff --git a/Documentation/PCI/endpoint/pci-dma-howto.rst b/Documentation/PCI/endpoint/pci-dma-howto.rst
new file mode 100644
index 000000000000..4bdce63c6f7f
--- /dev/null
+++ b/Documentation/PCI/endpoint/pci-dma-howto.rst
@@ -0,0 +1,201 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+==========================================
+PCI DMA Endpoint Function (EPF) User Guide
+==========================================
+
+:Author: Koichiro Den <den@valinux.co.jp>
+
+This guide shows how to configure the ``pci-epf-dma`` endpoint function driver.
+It uses ``dw-edma-pcie`` as the currently available host-side driver.  For the
+hardware model and layout see Documentation/PCI/endpoint/pci-dma-function.rst.
+
+Endpoint Device
+===============
+
+Endpoint Controller Devices
+---------------------------
+
+To find the list of endpoint controller devices in the system::
+
+	# ls /sys/class/pci_epc/
+	e65d0000.pcie-ep
+
+If ``PCI_ENDPOINT_CONFIGFS`` is enabled::
+
+	# ls /sys/kernel/config/pci_ep/controllers
+	e65d0000.pcie-ep
+
+Endpoint Function Drivers
+-------------------------
+
+To find the list of endpoint function drivers in the system::
+
+	# ls /sys/bus/pci-epf/drivers
+	pci_epf_dma  pci_epf_test
+
+If ``PCI_ENDPOINT_CONFIGFS`` is enabled::
+
+	# ls /sys/kernel/config/pci_ep/functions
+	pci_epf_dma  pci_epf_test
+
+Creating pci-epf-dma Device
+---------------------------
+
+Create a ``pci-epf-dma`` device with configfs::
+
+	# mount -t configfs none /sys/kernel/config
+	# cd /sys/kernel/config/pci_ep/
+	# mkdir functions/pci_epf_dma/dma0
+
+The "mkdir dma0" above creates the ``pci-epf-dma`` function device that will
+be probed by the ``pci_epf_dma`` driver.
+
+The PCI endpoint framework populates the directory with the common
+configurable fields::
+
+	# ls functions/pci_epf_dma/dma0
+	baseclass_code   msi_interrupts   progif_code    subsys_id
+	cache_line_size  msix_interrupts  revid          subsys_vendor_id
+	deviceid         pci_epf_dma.0    secondary      vendorid
+	interrupt_pin    primary          subclass_code
+
+The PCI DMA function driver also creates a function-specific sub-directory.
+The numeric suffix depends on the endpoint function instance number::
+
+	# ls functions/pci_epf_dma/dma0/pci_epf_dma.0/
+	dma_window_bar  metadata_bar  rd_chans  wr_chans
+
+Configuring pci-epf-dma Device
+------------------------------
+
+The host-side ``dw-edma-pcie`` PCI ID table does not contain a generic
+endpoint DMA PCI ID entry.  Choose a PCI vendor/device ID for the endpoint
+device::
+
+	# echo <vendor-id> > functions/pci_epf_dma/dma0/vendorid
+	# echo <device-id> > functions/pci_epf_dma/dma0/deviceid
+	# echo 1 > functions/pci_epf_dma/dma0/msi_interrupts
+
+The PCI class defaults to ``PCI_BASE_CLASS_SYSTEM`` and
+``PCI_CLASS_SYSTEM_DMA``.
+
+The function-specific attributes are:
+
+============== ============================================================
+Attribute      Description
+============== ============================================================
+metadata_bar   BAR used to publish the endpoint DMA metadata and handshake
+               bits.  It is kept as a stable BAR while the DMA windows are
+               programmed.  If this is left unset, the first usable BAR that
+               does not already contain a fixed DMA resource is used.
+dma_window_bar BAR used for DMA resources that are not already host-visible,
+               such as the DMA register window or descriptor windows.  This
+               BAR may be switched to subrange mapping after the host driver
+               has found the metadata.  If this is left unset and a DMA
+               window is needed, the first usable BAR different from
+               ``metadata_bar`` and not already occupied by a fixed DMA
+               resource is used.
+wr_chans       Number of endpoint-to-RC DMA write channels to expose.
+rd_chans       Number of RC-to-endpoint DMA read channels to expose.
+============== ============================================================
+
+A sample configuration for a DesignWare eDMA/HDMA compatible controller with
+two write channels and two read channels is given below::
+
+	# echo 0 > functions/pci_epf_dma/dma0/pci_epf_dma.0/metadata_bar
+	# echo 2 > functions/pci_epf_dma/dma0/pci_epf_dma.0/dma_window_bar
+	# echo 2 > functions/pci_epf_dma/dma0/pci_epf_dma.0/wr_chans
+	# echo 2 > functions/pci_epf_dma/dma0/pci_epf_dma.0/rd_chans
+
+``wr_chans`` and ``rd_chans`` default to 0.  At least one channel direction
+must be configured.  The selected channels are exposed in dense, zero-based
+order; for example, ``wr_chans = 2`` exposes write channels 0 and 1.
+DesignWare eDMA unroll and HDMA compatible layouts require each exposed
+direction to be delegated as a whole, so set a direction to either 0 or the
+number of hardware channels in that direction.  DesignWare HDMA native
+linked-list mode allows a smaller dense prefix.  If ``dma_window_bar`` is
+configured, it must be different from ``metadata_bar``.
+
+The common ``msi_interrupts`` and ``msix_interrupts`` attributes select the
+number of MSI and MSI-X vectors exposed to the host.  At least one MSI or
+MSI-X vector must be configured.
+
+The function-specific attributes can only be changed before the endpoint
+function is bound to an endpoint controller.
+
+Binding pci-epf-dma Device to EP Controller
+-------------------------------------------
+
+The DMA function device should be attached to a PCI endpoint controller
+connected to the host::
+
+	# ln -s controllers/e65d0000.pcie-ep \
+		functions/pci_epf_dma/dma0/primary/
+
+Once the above step is completed, the PCI endpoint controller is ready to
+establish a link with the host.
+
+Start the Link
+--------------
+
+Start the endpoint controller by writing 1 to ``start``::
+
+	# echo 1 > controllers/e65d0000.pcie-ep/start
+
+Root Complex Device
+===================
+
+lspci Output
+------------
+
+Note that the device listed here corresponds to the values populated in the
+endpoint configuration above::
+
+	# lspci -nk
+	01:00.1 0801: <vendor-id>:<device-id>
+
+If the host was already running while the endpoint function was configured,
+rescan the PCI bus after the endpoint side has completed the configfs setup
+and started the endpoint controller, if the platform supports it.
+
+Bind the endpoint DMA function to ``dw-edma-pcie`` explicitly with
+``driver_override``::
+
+	# modprobe dw_edma_pcie
+	# echo dw-edma-pcie > /sys/bus/pci/devices/0000:01:00.1/driver_override
+	# echo 0000:01:00.1 > /sys/bus/pci/drivers_probe
+
+The device should then be bound to ``dw-edma-pcie``::
+
+	# lspci -nk -s 01:00.1
+	01:00.1 0801: <vendor-id>:<device-id>
+		Kernel driver in use: dw-edma-pcie
+
+Using pci-epf-dma Device
+------------------------
+
+The host side software uses the standard Linux DMAengine API.  A DMAengine
+client driver running on the host must request one of the channels provided by
+``dw-edma-pcie`` and submit a transfer.
+
+For an endpoint-to-RC write transfer, the DMAengine client uses a host DMA
+buffer as the destination and an endpoint-side address as the slave source
+address.  For an RC-to-endpoint read transfer, the DMAengine client uses a
+host DMA buffer as the source and an endpoint-side address as the slave
+destination address.
+
+Troubleshooting
+===============
+
+``pci-epf-dma`` requires endpoint controller support for DMA auxiliary
+resources and MSI or MSI-X.  If any DMA resource must be mapped dynamically,
+the endpoint controller must also support BAR subrange mapping and dynamic
+inbound mapping.  Binding the function to an endpoint controller fails if the
+required capabilities are not available, or if both ``msi_interrupts`` and
+``msix_interrupts`` are zero.
+
+If ``dw-edma-pcie`` fails to probe on the host, check that the endpoint was
+bound to the host driver, that the endpoint BARs were assigned by PCI
+enumeration, and that the endpoint DMA metadata READY bit was set after any
+DMA window BAR submaps were programmed.
-- 
2.51.0


