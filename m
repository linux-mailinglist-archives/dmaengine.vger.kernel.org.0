Return-Path: <dmaengine+bounces-11650-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 3rAgCo7HNmodEwcAu9opvQ
	(envelope-from <dmaengine+bounces-11650-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Sat, 20 Jun 2026 19:02:06 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 917176A9468
	for <lists+dmaengine@lfdr.de>; Sat, 20 Jun 2026 19:02:05 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=valinux.co.jp header.s=selector1 header.b=RUAEELN9;
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-11650-lists+dmaengine=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="dmaengine+bounces-11650-lists+dmaengine=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=valinux.co.jp;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BA465302DB58
	for <lists+dmaengine@lfdr.de>; Sat, 20 Jun 2026 17:01:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7340325782A;
	Sat, 20 Jun 2026 17:01:03 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from TY3P286CU002.outbound.protection.outlook.com (mail-japaneastazon11020101.outbound.protection.outlook.com [52.101.229.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5A93259CB9;
	Sat, 20 Jun 2026 17:01:01 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781974863; cv=fail; b=EOmnDkxfQOtSBubZ8vKXmCv4Tvzi1nWHtgNV+/5NZEMSnYVCLFEwlhUH4c/lCz1Ep4AEyBlThfSNhuQZpbWBzPALofDvHbYaYSKliMeC/ZieZO6Z43b9anRXJBnwcKQIX3Rx+lMLqBh5HdWeEhryMfvmorcu3YhME5S96LFAWD8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781974863; c=relaxed/simple;
	bh=2sypaG68Grn61miyaa5jKn2CIoB3XqJeKqb0u/mchbg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=DCwIdq8pQmb6P0TRTSm7qV1mU+iaTaMy195OFhB0BMWdWhbPBukv6UlYbb39asox1IjyMIfzrYHOFIE5w8qeY+dzS1bqoqjN6VFd3F/KVN7/rZ7LjZnKLfGPJmpAk9guAaIKo3nih32Xmpq8L2u+5i9ZsFATeZk84e4Jy9DrSlo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=RUAEELN9; arc=fail smtp.client-ip=52.101.229.101
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lTkbwxko5hOkePf69AQHefZBqBXlS23jfD0z+yvK3ovJYLXjpkCA6Sg7VmdRw4lNrnZpdWtlkFYACnr4DLWccYEs7PWjvLBE43hWvLsgd2MBy+aq4dGyTFdbxAVpOCaYQwst+G3erFPAnA3Yc181ePqDB7BzX4kkrxUHSsaeacCoVFkvQT8ZDYuDjbhBdBdLlMSWhgrIsQyf2pqviasawQ5UkBRczfVtUCnBaC3KEJxpKJevxIqYbBnxJtuL9DDleefIElaao+uVrqoREHPSLjxesNQPCB7+zqzHHMP2ITbPTzK7LJZcQd0qSE8A89uVL5LNjGJkr/WGmMdysq04sw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mu0jYbIHEE0CJt/2UJA+tVSFDYnUu2uvYj5GDZ7QOLQ=;
 b=qoGN0u2JBd+qGg6ha/fNFY8jQPMD0D9fvS3CdFmo1DxF0hqGUCkrZIeoTNZIdtQtmXwAKKN7XBN0fB65ihwekhBXZkzOAjL4fCZXUQHyrDv3er0tkzqnOezJPvPoHSQk+OIYp/TPCD64Z7abGqhmeSeW9yPx/7O4lj1pUI2G8x6sKBb8PGCcgeSKRKaijx6yY9fN6//5IMdXriHHPPdESSNeMqqbePJ84KQ2IXemhdxFx3jtvahxV8ImLzeXWKfvI19ut+1/tHkMiTjB/M8Tf3xnZhRQJweVT1RNGd9L4J5HYPzsNj4KjrW3tuXSGa3mudAhjdRaI6dKg4EuKcUa+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mu0jYbIHEE0CJt/2UJA+tVSFDYnUu2uvYj5GDZ7QOLQ=;
 b=RUAEELN9KDxbVwB4HuQy7gvF2DzH72nF7iHpVK44AH5hrk7vFpLcVly9K0RVe6+aG6jJHutfKATNJTqvAa3IxmcB0jt4ctOonfW/GmQn2j8PqnkAtlHY9d3Mw/4IpvZ1aPlEBMPW+W100Mhu4ky97c9zZyS8vKIQj+sBJ7ut01w=
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
Subject: [PATCH v3 03/13] dmaengine: dw-edma: Add delegated channel request helpers
Date: Sun, 21 Jun 2026 02:00:30 +0900
Message-ID: <20260620170040.3756043-4-den@valinux.co.jp>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260620170040.3756043-1-den@valinux.co.jp>
References: <20260620170040.3756043-1-den@valinux.co.jp>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCP286CA0065.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:31a::6) To TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:38f::10)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY7P286MB7722:EE_|TY3P286MB2673:EE_
X-MS-Office365-Filtering-Correlation-Id: c37c8a88-d51b-42b2-00e8-08deceed7eaa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|23010399003|366016|10070799003|56012099006|6133799003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	Yz1Z8vZgjxpo6koBMzd3+uYdaMyQ9foM5xgbs4biYrfJ5idVh0mPflSrpUCSukXPrFjV5iTLw7Xu8xrAmGvq8tgT4WzIhd142ugNl9IXHglxMdYdSKFXMYgmNanLj0I0xYwj47C237MjJY3+Pvo1gL+3uBxKK/IZEUUsxvw6URRvMNjVwJ9DTxX7An5vtX2mT4wdfSnhmh16snh7SfCmO2kn5HAZAHn7q8thlVY9JwhFIORohLg0or+wP3ORrASg0w+vc7xQsisCIhObV3tJXczBVpFJRrzteai+Y3o1UXt8b7+jT/XsXjc2BUPVBU0flM7M2hmfZTZhO0GJTvfGO8sxcjo1kz0Yfug930Um5LB9N8EIsCeGizM8QgrsG33eKzMCJ9mx7nukoQBpC/Ywo0DCJxxGqk+utSj1DebM76OTQ6iwejBcwSS1zBDIbhb57zCQjq3BXidHcSD/2u6uyrihhaZIebpWsvhX+6681a95cWnwSka3lIKGFJCwnB6kPoibIuCaOAlET/3u5Tphz3TE2b34tyVox6Zdv8MTD9D1p+5oYmYcjnavKuG1yGA27WCE4473+1HWS+JMMIwndIhWUVjCRonPKKiL+9WZ9m4HWsgwPhDshSvbrXzELnYk7VMJ7V6IKMsvsFcyJ+GzmBbaUAdyGGFYu5YrLE5RKhk=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(23010399003)(366016)(10070799003)(56012099006)(6133799003)(18002099003)(22082099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?i/oVZgAF6tDej7O6UcUE9JNJUvtOGERxsm7iDny8G51b8RvXyicPdI99Q3fw?=
 =?us-ascii?Q?Zr6bEvAbVoZZhEuTqe3+QN+Q09kpE1lVoS1ZSVscIr/3QOTdkM0AfM2/snKv?=
 =?us-ascii?Q?5iCySZvVk0tOy/XjIEXLBPcRJrwXl8xtt5UV5hZe6C+R/Im4ySOmDRC8cigk?=
 =?us-ascii?Q?VJz0IJkmWYVbhvnHt53GPZ7sQV9pPzTtnuHHDP4sbPv84UjukHcAPWNqusGY?=
 =?us-ascii?Q?axCvVGH1WMDnkg0aKxOJBmtlTXDzrrAydleDFgYD6DqxwOtk8DqABYqCJsd5?=
 =?us-ascii?Q?/4vxy1IzFfclRnPOdehw/q9e/errH5equAzc8e2KdyHfRMx0lKGmiAOGOcN2?=
 =?us-ascii?Q?sGDV80RbGF2+gERxhEzbUsvT/LMbzJ1tee6DdggWrWtXGxPbH8muWfkGxEbP?=
 =?us-ascii?Q?JL+zG57ZlOeKnBeSIXeUvTUN1Hcbchw9lR7NENtskejsGubZe/DWRGoBKgSx?=
 =?us-ascii?Q?aj6QuxWYbTPCYzSHQ3k2R44IVcCv9zQOEN0wVfqVgktTLOP1gJEHSq9kjlGu?=
 =?us-ascii?Q?mernaeeSBGVoZFSXEJGqx7UDAbvmZ2R7ScjbV9IpdDoA7oXPKMcoWr9Mw2ym?=
 =?us-ascii?Q?zRZZU3bWsZ2TuM495IO3owCtS5cCZYVUGsVZMqyj8+ts6ua6VtGb8cwCFz3e?=
 =?us-ascii?Q?+q5dmKU7H1up6DOIFG2qSK2r11l0IZufI3WR7CSS5li5swFMtG+Wdo9gOzx1?=
 =?us-ascii?Q?AUrDiSkVFSLonwIM18UJHiMCN8oZN8ECnnULZ9aiQHEOCvwU9Kir7+IRJ6eE?=
 =?us-ascii?Q?9J1/gDzfrAA2sbJX9FD1biKi1nRAZOsY7SHcIG9p+oKL3CsyvZcdudpZxnuC?=
 =?us-ascii?Q?Soz9UFjX2NFxSCpXvySWDTgNQ5Og1GeoXxpFk5Ken4YYJPeaQCpboPvTjpwG?=
 =?us-ascii?Q?9EOK1Vwrmm9G2JRDY4qwb9dosaVwTo/IQPqUR6VXeVIMpZugdo8k2D2ZYGsy?=
 =?us-ascii?Q?y1KyEPfSLlCEfpc4ZYuLPPY13aBCtoaoE00cxuIUg/Cbg5SAYu3/OQ6fIi3j?=
 =?us-ascii?Q?+eKKkJ6btgk9yg3Y17hgJ9vfVqUqAWbyN+gcWRg9PrLEYZk8bJbZQDacys1K?=
 =?us-ascii?Q?wvVRts1XR2yKlSUxd0bYdcSosyb/FNZu0OsSUt/BqfbY+sQF4iE4uzE7enb6?=
 =?us-ascii?Q?+Q17JhGSCYzJzyoE/WGqv2UQAxkOqJM4nhQivfkY/q55ny2B/Vd1DyxPlxG0?=
 =?us-ascii?Q?rf7rS3k4oMd/+vrIVpDj2kK2lk51KatqE7W4lCjVUE0zbQZFPqGtHyAiyOfI?=
 =?us-ascii?Q?UkpUrxJLGLkKvftwbsZOeddftu914jCOL9y+ybUmshHUlhoEe4+pzQYk9k0I?=
 =?us-ascii?Q?hPC5x3jRH5gB8OAAQNU3n4vuWYZkhG6TxaUlORYyF8kMqO6qrwzxyNEHknBM?=
 =?us-ascii?Q?pasQIumE3s/URNpCVpJjac9HWb1q2a8WHa78gV302sEjPGHPcCS1QXkwbY5B?=
 =?us-ascii?Q?IgOxNSxH3hDsYfXTfyf2vIz3yhT/QMOm1dgstyakYzND8XRzd/6BAU7ZW6Ks?=
 =?us-ascii?Q?HexqWeqrYctt4otQE2pJE3J/xrrJgEtoAL263izV2qCT1GWtW8H5/TlNJMid?=
 =?us-ascii?Q?GHF/kEq5+ZYLWgkfF9GmZ7qZCrbNuEl99FitPds5uQsjeyQZmCc8JFomKoeA?=
 =?us-ascii?Q?tVhX/xfr5zwmhTumN5iUruRJcTlJTyd18WjYxj7+qn4g1NghPLMIKFscAjiH?=
 =?us-ascii?Q?0A6iJKBkE6Gaj4bxruXQmWdI41hoRiahVPqSZ0zQnvMuM43RPtRkvi7A24c2?=
 =?us-ascii?Q?OE57HXdGMyN0TDktPFjC01JMkdXsat0JILKxhWIEHmYbjf322aJd?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: c37c8a88-d51b-42b2-00e8-08deceed7eaa
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jun 2026 17:00:56.1241
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VpjKQabZuWyqvytPXqIBzEtpRE2WnuBUDzWzork/cQnmDl+5qoftvLxc0zt8JCW0su811tXbHy5yjTUa6xFJSQ==
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
	TAGGED_FROM(0.00)[bounces-11650-lists,dmaengine=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,valinux.co.jp:dkim,valinux.co.jp:email,valinux.co.jp:mid,valinux.co.jp:from_mime,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,synopsys.com:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 917176A9468

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
Changes in v3:
  - New patch. Replace the public hardware-channel filter API with
    delegated channel request helpers so the filter stays private to
    dw-edma and delegated IRQ handoff is handled by dw-edma.
  - Hide the hardware-channel filter inside dw-edma instead of exposing
    it through public headers (Frank); add delegated-channel helpers
    instead.
  - Set endpoint-local delegated channels to remote IRQ routing after
    dma_request_channel().
  - Allow delegated-channel release to skip quiesce for reservations
    that were never exposed to host programming.

 drivers/dma/dw-edma/dw-edma-core.c | 81 ++++++++++++++++++++++++++++++
 include/linux/dma/edma.h           | 14 ++++++
 2 files changed, 95 insertions(+)

diff --git a/drivers/dma/dw-edma/dw-edma-core.c b/drivers/dma/dw-edma/dw-edma-core.c
index 7a24248b84e9..ca0504eac1fc 100644
--- a/drivers/dma/dw-edma/dw-edma-core.c
+++ b/drivers/dma/dw-edma/dw-edma-core.c
@@ -1192,6 +1192,87 @@ int dw_edma_remove(struct dw_edma_chip *chip)
 }
 EXPORT_SYMBOL_GPL(dw_edma_remove);
 
+struct dw_edma_delegated_chan_filter {
+	struct device *dma_dev;
+	bool write;
+	u16 id;
+};
+
+static bool dw_edma_delegated_chan_filter(struct dma_chan *dchan, void *param)
+{
+	struct dw_edma_delegated_chan_filter *filter = param;
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
+
+	if (!(chan->dw->chip->flags & DW_EDMA_CHIP_LOCAL))
+		return -EINVAL;
+	if (chan->configured || chan->status != EDMA_ST_IDLE ||
+	    chan->request != EDMA_REQ_NONE)
+		return -EBUSY;
+
+	chan->irq_mode = DW_EDMA_CH_IRQ_REMOTE;
+
+	return 0;
+}
+
+struct dma_chan *dw_edma_request_delegated_chan(struct device *dma_dev,
+						bool write, u16 id)
+{
+	struct dw_edma_delegated_chan_filter filter = {
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
+	chan->irq_mode = dw_edma_get_irq_mode(chan);
+	dma_release_channel(dchan);
+}
+EXPORT_SYMBOL_GPL(dw_edma_release_delegated_chan);
+
 MODULE_LICENSE("GPL v2");
 MODULE_DESCRIPTION("Synopsys DesignWare eDMA controller core driver");
 MODULE_AUTHOR("Gustavo Pimentel <gustavo.pimentel@synopsys.com>");
diff --git a/include/linux/dma/edma.h b/include/linux/dma/edma.h
index c0906221a7c7..0ba8a1143fb2 100644
--- a/include/linux/dma/edma.h
+++ b/include/linux/dma/edma.h
@@ -140,6 +140,9 @@ struct dw_edma_chip {
 #if IS_REACHABLE(CONFIG_DW_EDMA)
 int dw_edma_probe(struct dw_edma_chip *chip);
 int dw_edma_remove(struct dw_edma_chip *chip);
+struct dma_chan *dw_edma_request_delegated_chan(struct device *dma_dev,
+						bool write, u16 id);
+void dw_edma_release_delegated_chan(struct dma_chan *chan, bool quiesce);
 #else
 static inline int dw_edma_probe(struct dw_edma_chip *chip)
 {
@@ -150,6 +153,17 @@ static inline int dw_edma_remove(struct dw_edma_chip *chip)
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


