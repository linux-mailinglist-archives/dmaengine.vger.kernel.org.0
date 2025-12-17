Return-Path: <dmaengine+bounces-7785-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id CE52ACC8764
	for <lists+dmaengine@lfdr.de>; Wed, 17 Dec 2025 16:33:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3954E3039995
	for <lists+dmaengine@lfdr.de>; Wed, 17 Dec 2025 15:32:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7A4638E16A;
	Wed, 17 Dec 2025 15:32:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="GGJfGgtx"
X-Original-To: dmaengine@vger.kernel.org
Received: from TY3P286CU002.outbound.protection.outlook.com (mail-japaneastazon11010002.outbound.protection.outlook.com [52.101.229.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D233238E164;
	Wed, 17 Dec 2025 15:32:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.229.2
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765985543; cv=fail; b=OWgw1T8j5hLjyDgjDGT5tQRps5zHLVhGmIiuCxsp/f+ACCFK+tHJlPPphnac6xIgu+ggwDPz9QgQgnkEmHmjJ4XbuO+It9Q2OWU36RdMy9GV4mher5djO6ApCf+40k3Q3sRZiCHMWq0mYcKGDsRHajNPLRH/JMP4NrYlF64DqoM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765985543; c=relaxed/simple;
	bh=BvupNUTbsnnqQ2iQSCv4G38j+cojMx+Gkuivh3+BAwY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=kAhYY3yTlrheYQDgPLLq49UUszESuYIZe29qMNHOSr81eTCjbBJnO8AJ/breLGwxIYdVn7ExnHXaVRTq7M8UqtyI0zRUj8VXhXUoLBc8bhvTrtzYJID6dXofSR/Uo4gCGS2UQzx+5//SJEC0CqHI6yTHl/nf5UrhnCA1hruBrrM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=GGJfGgtx; arc=fail smtp.client-ip=52.101.229.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qIedRf90351VZ/we5tuQSb7Q1Hfc7cUVWakfqagiQJmnGxkIzCTTJye8YmZr4jDcFRz+IE5Goi2f8RW6f3+M6y7XDPkzXQBVvGuJMeZ4kRhRbX5Uwc/9CwM8s5V9Khh4ANKGoGDycqd30QETDUO5PQMGXyB6qn6Lfy4y4LSOiMufoewi5VTOuc2MpRsVS1ePMw5oYg6BCJ9P+YdqSxCY4CVrbmTRQT/18AV5CUz/WmyWLFgSbh81momAOHUQHcTtCInh9Qs3Pq0coPC96AMmxbske91NRL5YKYj5ahBbHD55QHcFY4iZLAmqAxZtSbNX4672SW7NxVxREH1xUBpIag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bi06V0x6tmNQAvQ9aQlAgF6/LuakztYZpjDQre4adTY=;
 b=i7EEjZRl1RieGAeGVdvHv7glgdfmgMqaNKnck5m8+OxI4bRDSDle5vTwKDg5FIc46iaP3PthklrXT+ap4E6qEG2CX1Um6ut55wHrh2kYMl072v81ZqIwmqezt7cQN6sP+odqWY5FmQ0wKVws8IIFHoW3eK1kmDs1ER8+GwQFW7TZuDk79VUXqOfrqIPhu+yFIdsDCxtMW+QsksyKuwhJcmIpao5f4DBi2mLUk8Jn7Bf6pW6WfWdWqvRcJsgSr5lZQA2FOWoXd+sOWju5WywbOE4JjT41wWYF8SstExBhuhzfH70Ot3LWlsZPxoKv9lZHLSgKoL+9uhVzw+ZJJebCNA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bi06V0x6tmNQAvQ9aQlAgF6/LuakztYZpjDQre4adTY=;
 b=GGJfGgtxm/XMg/oy3toTu3SAQuNE9ege1UQceoAjFW7H7GLFQfN1YAmBjY66I1xSlDtNhXOpPv9ri8A5dFEBFQ5ju1eyY1Wkq5g2WX4w1l/K9FYVkkjegozBT5tGzpNi3U+QWqJyMaEMWq3EugqXK2OVTUHjPwi7KS03HX0FI8k=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TYWP286MB2697.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:24c::11)
 by OS9P286MB4633.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:2fc::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9434.6; Wed, 17 Dec
 2025 15:16:15 +0000
Received: from TYWP286MB2697.JPNP286.PROD.OUTLOOK.COM
 ([fe80::fb7e:f4ed:a580:9d03]) by TYWP286MB2697.JPNP286.PROD.OUTLOOK.COM
 ([fe80::fb7e:f4ed:a580:9d03%5]) with mapi id 15.20.9434.001; Wed, 17 Dec 2025
 15:16:15 +0000
From: Koichiro Den <den@valinux.co.jp>
To: Frank.Li@nxp.com,
	dave.jiang@intel.com,
	ntb@lists.linux.dev,
	linux-pci@vger.kernel.org,
	dmaengine@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: mani@kernel.org,
	kwilczynski@kernel.org,
	kishon@kernel.org,
	bhelgaas@google.com,
	corbet@lwn.net,
	geert+renesas@glider.be,
	magnus.damm@gmail.com,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	vkoul@kernel.org,
	joro@8bytes.org,
	will@kernel.org,
	robin.murphy@arm.com,
	jdmason@kudzu.us,
	allenbh@gmail.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	Basavaraj.Natikar@amd.com,
	Shyam-sundar.S-k@amd.com,
	kurt.schwemmer@microsemi.com,
	logang@deltatee.com,
	jingoohan1@gmail.com,
	lpieralisi@kernel.org,
	utkarsh02t@gmail.com,
	jbrunet@baylibre.com,
	dlemoal@kernel.org,
	arnd@arndb.de,
	elfring@users.sourceforge.net,
	den@valinux.co.jp
Subject: [RFC PATCH v3 01/35] PCI: endpoint: pci-epf-vntb: Use array_index_nospec() on mws_size[] access
Date: Thu, 18 Dec 2025 00:15:35 +0900
Message-ID: <20251217151609.3162665-2-den@valinux.co.jp>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251217151609.3162665-1-den@valinux.co.jp>
References: <20251217151609.3162665-1-den@valinux.co.jp>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYWPR01CA0025.jpnprd01.prod.outlook.com
 (2603:1096:400:aa::12) To TYWP286MB2697.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:24c::11)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYWP286MB2697:EE_|OS9P286MB4633:EE_
X-MS-Office365-Filtering-Correlation-Id: af1af3ef-3ee7-4224-f7c7-08de3d7f3800
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|10070799003|376014|7416014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?0mEH1/u9yQspFsxoSvG0ubg85PAP/BvpqZ1QdYKrHbysmsZ/sF708c0k6RPy?=
 =?us-ascii?Q?Okk2P4DOaiOCC5QjrHrv0C54bKtusNUCucis1rV2nTMh2EaCa/6AedCLwkEn?=
 =?us-ascii?Q?DgZ9R7OpDBT6LD8RC6isPMuTlm/nT04yC7ZlB6U7jMlZ/tD2NkpDhZoRx7ss?=
 =?us-ascii?Q?OFxuVWzY3o7LIjEAgwx+Juh8F6g8teBzsbtj/WbvwBSFMreSJxcuREvP8jbO?=
 =?us-ascii?Q?8UcJDIf+MTHWseWWw1lElj8wBdnsu3c5vwN88VzqdS2zXIF8xYfFlcxQPaIA?=
 =?us-ascii?Q?bV8thGE3tsIEkUmVQJ+5vkApQfivxAuD6ElfmjagpDnFsARgikvYpiBi9tXS?=
 =?us-ascii?Q?z+SRcJ4vvq/nUgxd2Hs+EoPI81mPkZjKwJq6n2vR7NAoX7YbtIF/MwUaVwFe?=
 =?us-ascii?Q?8mymmsg6/myAgod2OhzOxGoFVJV0EwLOdtaC8Mek1Fu3onWkOBHtafljrNdp?=
 =?us-ascii?Q?o1CyrN75ycJGxiTsjd5Dp6QqE1qicklNDICcQ11Bk5IVBu8OQJMGOekzvzXh?=
 =?us-ascii?Q?ZF2ovh2X6Qfc62U26m4qy6Q23XFZe0Ro/odsRJicS8lxdpqD5SDoiW6BJYCq?=
 =?us-ascii?Q?W015yvWKXBBEmDdl8iyZbsGEbcAgM5nP+I0QP697/gPkQyr8/nZJ0MfQS4pD?=
 =?us-ascii?Q?SIZtlma1B4DYX3isajWyM04xOimuJ0/oFvAsfnmfQr5d3VGIU8caChRvhJQq?=
 =?us-ascii?Q?dgU5crN+25hAOPMtMA0Y6skLjqldJb5oCLfqdyZe6bck/yLvR8FReyeUG5Hw?=
 =?us-ascii?Q?Wy9pGjHLahyX2fX8p2mwjQRuP7168djPbB8I0wBRWdl21X0CZg/ekfoYkRlw?=
 =?us-ascii?Q?pMxoiYYhvZDe/XqoPXDqbANmYk76m37v8tY9XeGTt5hAc1ymkYwixX1cQMdB?=
 =?us-ascii?Q?VCCEey7fXt/QPjQpFGdmvUzah0gDJ+Ci2m6D1grbMjkGatJcw8mBzaznoJxK?=
 =?us-ascii?Q?kg3lubbEJacJj/uA9L5ud2XBW6aq3vyOe6H+Ce556/K3BErwmv2o1xzEAqcw?=
 =?us-ascii?Q?X8zhitKcvO04sTuy2VTRZeQ9VsPTnZs5ogiUZFgRrUJx7VChWQh35VpaJbk8?=
 =?us-ascii?Q?QdNdVqJv8ZfNK3WZl39mQJoZr9EBpXXczBykPdNUPkmbdGL0wNrDkSOBnkoh?=
 =?us-ascii?Q?t417Ijr/ocJy5Ml0Ex85wDfA893/8onJwicgQ/NIQs1KQHboNAawyC6WuHLy?=
 =?us-ascii?Q?96MRrjslsN4Q3LPYx3F0ik0g/CkqXtrKJqdBtB3dZ6c6pfpyYnWcYFXYWteE?=
 =?us-ascii?Q?DUZrLWWpDxHfqMuajWfl9UdJsiAVuPYt/d5fJNCbrWSmfUHsIWJLKhDE1HBe?=
 =?us-ascii?Q?zzBx1NM3DYSm068Z6DYCPxORH/BQFTdkuai2hNsPfut3WxIDCz8GY4ZDr6gD?=
 =?us-ascii?Q?hMOEozpGRbjoH0COGm9w9u1rL95KjN5XNMq6zbjbjfXjyTvA8G/WNr9jWIia?=
 =?us-ascii?Q?7F/EwEd86GC87WAdnTDNvBYIsoF67yJn?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYWP286MB2697.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(376014)(7416014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?YvJoAQoclkYQ6XMoz/5ldm2A3QGUHM3HjnRJUTZI9mHNi9gYmFN83KB8LX2Y?=
 =?us-ascii?Q?0lQP+59OqqfHsrrnx1UUQeeR7hIGoMEtdRlIlBsPdzrho9+O9NwGfMXowDjY?=
 =?us-ascii?Q?PhwBSu/nqgqtb6anYG5jiuD20xTA/47QcfLSR2SVqMd+HqoDmqkrjccboBnl?=
 =?us-ascii?Q?MAAn+Awg0yw8rplQori1jEGjYOGVSrqSZ2YlxkcpsAx8XraEUJjc6rvr61+s?=
 =?us-ascii?Q?KBFvv61bb8sb/ECZjgnVsNOMK1CMLS2CmnaVtXlsUn6ecKBVYf3HNAXXFkI8?=
 =?us-ascii?Q?rFjH41hK8VOe2ARH8uNtvfFpAnaebgKULmZ3qvyhVZxh6n7hhIXQzfwF5jUu?=
 =?us-ascii?Q?YPy8iFxHSTDY3E/sNrSoV1IWAMsKcViAZoIO68SNPNlhaflBtNaoYj+DOQbs?=
 =?us-ascii?Q?PyMnHdYAFtZITO3jT1wh5qAyU+Z3PbErqLntbUVUTs5nuFxRzCUo2OsiYlxs?=
 =?us-ascii?Q?kpDFOFE7bA4JXTPNE6SUMxgGTTEo0E/m59HcAhb4OLqVMnZC1fjpjwYAMec3?=
 =?us-ascii?Q?mQp/40k8+CaNPKO7GmFa9OsFRK3Eul7nthD1geEXkGU2chsPX6n/cL/Pq5ll?=
 =?us-ascii?Q?rIDJXON2boFDAt43bwhAPFyJUu/IF/seVA09kQkD1STduL/McyY6eWyfcOef?=
 =?us-ascii?Q?I9MMdSQUByCiQlfrJpw4kJrv0E5cwlApdLiMOC9YYssbYdNyONx+o2yd2r1M?=
 =?us-ascii?Q?E70/Aw6WYZzXa2XMq3yglVQOVfcgEgocvRU6yGy+2Cj91OgF1V2YmEDPPmmc?=
 =?us-ascii?Q?cOHgZLA+/vmo7rJtCe+8/KAoAA/qkdxGlug9RM0DsRlpI4jqFhLRxEKkqAig?=
 =?us-ascii?Q?0dwrRJnD4NJCjyAqjY7wK9d8+8aUDpZhMXLaYqIynoGXmsejTHk0RgMlbRAP?=
 =?us-ascii?Q?gHvHXDo7C+Xec1+7zp6J3LMODHg2xJxnAxC2ssJUDuHWbWiYGWqhr5NuvGoV?=
 =?us-ascii?Q?ZsEx+HMbXBPtbyW9U8NIWWrz8LCrA1vEwrJ7Kc+K9Ai1CjkoRK3O+b5YqKex?=
 =?us-ascii?Q?vm4eRtbKACs44U9CSYblgCq3TNAcYxd3uivG93/p9xHJQanDfI8XHKskTxOM?=
 =?us-ascii?Q?qH9P+bGtODCNdr6S0pdLUb+LovangcRl9csGBpi/DnV1RisZ8WQ52xJeIsGP?=
 =?us-ascii?Q?3maKPZes+BSqWmWPVPpdG4NB/zloDjRn6A3lQK9BhgfBVk1TpURMegRWhLUf?=
 =?us-ascii?Q?L470D1aTzx3u9ufWWF4MBAQkPU/izwfnVsZ5TK2yabuSjb32hiMsD2eUyao3?=
 =?us-ascii?Q?1SKEQHEZNIfU/oW4B45oHsfYaDE5XudGebmjyQFdbWpaA8CSj0CYNYSJXHGk?=
 =?us-ascii?Q?z9qHqWMdUqx9wex+nj6m/cxICTAnpGCH3TWG6geVMLE9qFG+keQzDVjV1RHq?=
 =?us-ascii?Q?lIKri7Ce3FXLhBsfVnxwiQtnAv5yMrgGDGP1Wg1TIdU6ByW7j2ow1+nQGLh8?=
 =?us-ascii?Q?0nBNtNJLuviISJKD+69PV2PD4YRUhn0Lv/exsCkgaqDFzoa01Mht3WCuPE5L?=
 =?us-ascii?Q?OxxQEVBnFAfBj5Mmu9X6K8CBhrsylTZ3PoqSgVRAOQ3AGTUmcJ3QhCWuNc/c?=
 =?us-ascii?Q?40n2JK/pPtFP6QQMoCZ0sF4ywninxjvxgHQrJTJ1WxX85shRCdqvFCmPmtFg?=
 =?us-ascii?Q?3k5zuBuKkU6+TrcELeRkUN4=3D?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: af1af3ef-3ee7-4224-f7c7-08de3d7f3800
X-MS-Exchange-CrossTenant-AuthSource: TYWP286MB2697.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Dec 2025 15:16:14.3598
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: U0F4BC1xbvNd/XZtFsOlTca6bB/g03hbKLnqCqm6HFC9yM9eYDE9l2e8eC5ByOCO3Z5WKdrkY/iTd+f2SwOCVA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS9P286MB4633

Follow common kernel idioms for indices derived from configfs attributes
and suppress Smatch warnings:

  epf_ntb_mw1_show() warn: potential spectre issue 'ntb->mws_size' [r]
  epf_ntb_mw1_store() warn: potential spectre issue 'ntb->mws_size' [w]

Also fix the error message for out-of-range MW indices and %lld format
for unsigned values.

Signed-off-by: Koichiro Den <den@valinux.co.jp>
---
Note: I noticed [RFC PATCH v2 01/27] resurrected the Smatch warnings
https://lore.kernel.org/all/20251129160405.2568284-2-den@valinux.co.jp/
This RFC v3 version therefore reverts to the RFC v1 style, with one
additional fix to correct the sprintf format specifier (%lld->%llu).
---
 drivers/pci/endpoint/functions/pci-epf-vntb.c | 24 +++++++++++--------
 1 file changed, 14 insertions(+), 10 deletions(-)

diff --git a/drivers/pci/endpoint/functions/pci-epf-vntb.c b/drivers/pci/endpoint/functions/pci-epf-vntb.c
index 3ecc5059f92b..56aab5d354d6 100644
--- a/drivers/pci/endpoint/functions/pci-epf-vntb.c
+++ b/drivers/pci/endpoint/functions/pci-epf-vntb.c
@@ -995,17 +995,19 @@ static ssize_t epf_ntb_##_name##_show(struct config_item *item,		\
 	struct config_group *group = to_config_group(item);		\
 	struct epf_ntb *ntb = to_epf_ntb(group);			\
 	struct device *dev = &ntb->epf->dev;				\
-	int win_no;							\
+	int win_no, idx;						\
 									\
 	if (sscanf(#_name, "mw%d", &win_no) != 1)			\
 		return -EINVAL;						\
 									\
-	if (win_no <= 0 || win_no > ntb->num_mws) {			\
-		dev_err(dev, "Invalid num_nws: %d value\n", ntb->num_mws); \
+	idx = win_no - 1;						\
+	if (idx < 0 || idx >= ntb->num_mws) {				\
+		dev_err(dev, "MW%d out of range (num_mws=%d)\n",	\
+			win_no, ntb->num_mws);				\
 		return -EINVAL;						\
 	}								\
-									\
-	return sprintf(page, "%lld\n", ntb->mws_size[win_no - 1]);	\
+	idx = array_index_nospec(idx, ntb->num_mws);			\
+	return sprintf(page, "%llu\n", ntb->mws_size[idx]);		\
 }
 
 #define EPF_NTB_MW_W(_name)						\
@@ -1015,7 +1017,7 @@ static ssize_t epf_ntb_##_name##_store(struct config_item *item,	\
 	struct config_group *group = to_config_group(item);		\
 	struct epf_ntb *ntb = to_epf_ntb(group);			\
 	struct device *dev = &ntb->epf->dev;				\
-	int win_no;							\
+	int win_no, idx;						\
 	u64 val;							\
 	int ret;							\
 									\
@@ -1026,12 +1028,14 @@ static ssize_t epf_ntb_##_name##_store(struct config_item *item,	\
 	if (sscanf(#_name, "mw%d", &win_no) != 1)			\
 		return -EINVAL;						\
 									\
-	if (win_no <= 0 || win_no > ntb->num_mws) {			\
-		dev_err(dev, "Invalid num_nws: %d value\n", ntb->num_mws); \
+	idx = win_no - 1;						\
+	if (idx < 0 || idx >= ntb->num_mws) {				\
+		dev_err(dev, "MW%d out of range (num_mws=%d)\n",	\
+			win_no, ntb->num_mws);				\
 		return -EINVAL;						\
 	}								\
-									\
-	ntb->mws_size[win_no - 1] = val;				\
+	idx = array_index_nospec(idx, ntb->num_mws);			\
+	ntb->mws_size[idx] = val;					\
 									\
 	return len;							\
 }
-- 
2.51.0


