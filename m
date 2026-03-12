Return-Path: <dmaengine+bounces-9406-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qK5ZMVvwsmlaRAAAu9opvQ
	(envelope-from <dmaengine+bounces-9406-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Thu, 12 Mar 2026 17:56:59 +0100
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E7842761E2
	for <lists+dmaengine@lfdr.de>; Thu, 12 Mar 2026 17:56:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3C8753221FF3
	for <lists+dmaengine@lfdr.de>; Thu, 12 Mar 2026 16:52:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D81163DC4B6;
	Thu, 12 Mar 2026 16:50:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="mk0J9MQs"
X-Original-To: dmaengine@vger.kernel.org
Received: from OS0P286CU010.outbound.protection.outlook.com (mail-japanwestazon11021104.outbound.protection.outlook.com [40.107.74.104])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A99F63FE351;
	Thu, 12 Mar 2026 16:50:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.74.104
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773334250; cv=fail; b=Fuw9Gla0HNBZTC9rcAokzj+r0xs5BRMzvAGH1GFqlTSE1kGb6GbTzv1ymgY0dyG6NgPDtc40BSH4+VY3wIoxwFqhRizNPDwDvkCmpZAO0q1Dq/FqNz/JghWloc4UgN5+0gDxgiql8bNzzvRCXLAc6Y3LTAKHOFZ1kHfhQ2SLfqI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773334250; c=relaxed/simple;
	bh=V2Nio+tk7C+Ip1W1L3lPVjFzQ2JvE1K96yHOI8ARy2w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Eil/wJP6a6cRPTo+wy+E2odJbZrfZd27t5SAgXlMA1SA78mFVSQabbGa3a4ZKbpTC2sPtmXCK76cCYim93bD2WDX51gNJdAcRd4k2gGESKx4W3hEuOobOK2yCAbu7NX6Mmdq9yT48uxp430BuaXK+He3yYuGkauLr2MPSuIKNn0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=mk0J9MQs; arc=fail smtp.client-ip=40.107.74.104
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eDQ7ofTlT00FUtbl2oXANfk8VuHI43mAQ3wtIdrh+RQeMFkpvDWOAWYl2eidSXMr9mo1noVcBF+Ox8AjfAnduXjjJaPZw1nscFRjSQE0kZnx1lcQZTRzbDUYNrlyzHAEHqYPnpNxf25GlEHkQxHOxnQvw2y1Z2mLbugZTZcF2fQzExISK2du+HEbZJ37Js8UA+oqFjrlYNCp9j7cE7Ob5uGPRfwywOaZxzYUfwL+lYkqdeHWj8bahXYAqzyZCjhjTpcFLOQSTK+Oj1nPG62c35SfiKwO3kNv05UBbke1m6+3AQbWP5c2RjNMnxQQh3gGtOPPJPXZWvSELncWDKO5xw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HrNylQ73qJHo8o7tCZACDmP8uq2iRpovq+rNm9L5xsM=;
 b=LDMZdpwK4j0S8ruSTrZReRHx4gTexflC3uxvliLoP1bn9IPnCoCrlWLWtRroLi3JAGcR1r8dGrN+escQXo6NtjD8eVr4j0j9G90LYdLXgzSx/CjnRvSSmyZPGytHxbtUbwjXf+wd7yWI1UP0QZeXs7n1Rs9Ggqy3F95AW4er/OaFOMxC8e1k+c864GyB2yjdwuBzSZypmZI2TTh1oif76I6KvKvIaDUOoGUHW4cCLCNdCTM6/UgVCQ4B7EChIpEVM6td/xx2/gzPOie+3uyHJNEFGYvPYN+9lApqC3GbEmkVZD9EWZmx1PC7fMOqfRUa3KPUFv++T6ewbRIxeS7EcA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HrNylQ73qJHo8o7tCZACDmP8uq2iRpovq+rNm9L5xsM=;
 b=mk0J9MQsQgcGnCMyx0SQUNFiOwvfFYCJdJBXEuqDuACPpv2MhD8xCj4x1u2Kw4mv70jGSibpIl81w4iWclo2RtqkccQpLNzovvtwRI1J73r6m1toynjFEA6gTu0ZPrsdR9lOj2rwf+wvwK6x24BiaKODFJPAM+oJxcE+rdYSay8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:38f::10)
 by TYCP286MB2018.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:15e::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.15; Thu, 12 Mar
 2026 16:50:20 +0000
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32]) by TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32%5]) with mapi id 15.20.9700.013; Thu, 12 Mar 2026
 16:50:20 +0000
From: Koichiro Den <den@valinux.co.jp>
To: Manivannan Sadhasivam <mani@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Vinod Koul <vkoul@kernel.org>,
	Frank Li <Frank.Li@kernel.org>,
	Jon Mason <jdmason@kudzu.us>,
	Dave Jiang <dave.jiang@intel.com>,
	Allen Hubbe <allenbh@gmail.com>,
	Jingoo Han <jingoohan1@gmail.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Baruch Siach <baruch@tkos.co.il>,
	Jerome Brunet <jbrunet@baylibre.com>,
	Niklas Cassel <cassel@kernel.org>
Cc: linux-pci@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	dmaengine@vger.kernel.org,
	ntb@lists.linux.dev
Subject: [PATCH 12/15] NTB: hw: epf: Enumerate auxiliary child for DMA ABI v1
Date: Fri, 13 Mar 2026 01:50:02 +0900
Message-ID: <20260312165005.1148676-13-den@valinux.co.jp>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260312165005.1148676-1-den@valinux.co.jp>
References: <20260312165005.1148676-1-den@valinux.co.jp>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCP286CA0103.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:2b4::16) To TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:38f::10)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY7P286MB7722:EE_|TYCP286MB2018:EE_
X-MS-Office365-Filtering-Correlation-Id: c868d4c2-2e11-486b-732f-08de805772b2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|10070799003|366016|7416014|921020|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	8uX8rxa5x4UhC8xHcSH3FdG9xPRXLxIsNkQF/pfPa2rlwAgQtnamK299SSE7kOOcrJb56heUclxl+558OdvUx+phIazXWMhUU11jBjuHvaKhaAR31wxPqaPnABC0liYxdhw04sXZcE1+SO4NbZge+62ZUfvG0/Za22yUmKdSKlJbUJdrj3lfYdEMRs8joISBDoRWYCQJQ0L29J8UiEmeWGFYaR4h+YDu9K848MPaEm2KIB3jUz4wgYPOX6N17ga9YUFjGVS5RGKLcifT5B0/LOfxiW73itPJw51YjstbRleaYBavf22dd4DYHfgzNqShntQwhyrraJHPWIsAxE3V8sVerZ2C4htsjwEZlFEC62WIXnfAkqvhCbqVHKmjli8Vcq7G0APObBLqIOCtoC7NWwQwFXaAeMuJ/t80PiA0EbsObS24V+XpqqKlrbFayQ8UF7rZBXIF5P8jaHB99G+V0Z7VUH+5q8p2VfX8j4fY8alcFeOKnncamzX5ZE5nltThA+vMUp2HuTHJl3NnC2ojiygiKNVoBvAgVlvWjb/fDMxpUt9x2L594Co3OQbJEbv7ZF69Yds3TqMmLJJ8hN3QAjkTbmbxhtDM90q8h5z6uEtVglVra/lhIhUI73zluzeT0GuRT929ZC39nvNdvdCvfXBzZzbQp39mopP3eNjlhgHYQB//uSQg0w3VAy3kAZRqSIC7v9d+hOGCQ99JSDngmXz4MupnVUqKqQrqluykv3z0Ng10v6HC6NgfEqh4ZdwnmIERO+7L+/XbhGkwfuJ3jw==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(10070799003)(366016)(7416014)(921020)(56012099003)(22082099003)(18002099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?CFdW/XO9PZiVhx+RT0sbN5i1KqXZn7hlsFdCz9VZj7ytNexgUQrX4QmMHIlG?=
 =?us-ascii?Q?6aeYhhw4Juk40kXm6udtaXw+iI5WOPfxBTHV3zNSO9ve1Vk8NxtPsjlYggyM?=
 =?us-ascii?Q?Nra62NaJ6192cXACS18ndNVLiWszYmK4urBK9ZMAhKQVlcos9gaUlccsNWB/?=
 =?us-ascii?Q?cijl/kWweApzhxYt58atchl/UGCUq5lZ21LtAg+ERsyag2HktI9/JsEgAT/p?=
 =?us-ascii?Q?NTiBQWycPfBtWtbB/CaSPiao1sFcT0XFylatvYb8+RsnDk3+XVq/gxpVQla7?=
 =?us-ascii?Q?sadZ8cqStvC5nwYYaY8n5D754m5zjpYXDhjC18i0r1nV3Jyb/PlXVFZc31Is?=
 =?us-ascii?Q?S3YKWpMgTOYSWF1PDuvT7t4oezCPjNnVB98JFYZu/rEbEOeNykDT4VuiX6ZU?=
 =?us-ascii?Q?x/Rmow6QrksywdnJtXETCSTP6vdechPyGI0kaY3+e8GmfXXmf/tcaSA9/1nD?=
 =?us-ascii?Q?N9M+f7yao20BSiySLlggy59Uc2OMPt+TldSDf+JCGKNvOHpyAB22p3bRMzV4?=
 =?us-ascii?Q?jeE8xsxxHZlwvsTIF7AKzerOrDEzoN46sSiMt4ewi4Jx9gKvpuoq2e9lXYVh?=
 =?us-ascii?Q?Ho3JMXv6XflCbCPL/HGiSC11fJ//0UaBdfjP6N35CLiFtWIYqKk7qiqPK9Hv?=
 =?us-ascii?Q?05IonspWDcsJAHS01x960U7iVzFJH749Hd60eiMPQ0zuiJHNUPah/K9/CwUO?=
 =?us-ascii?Q?RFU+mTh0b+nJLloEk4tDJ6sjgr/Dg5Pqyqi82V+q6oJnIV28BaxcOYyrQSID?=
 =?us-ascii?Q?g9fowiEnOr3Lc9t5IoyaGxmgpR5VMx3N9efeB221wkgMozYVUpe+L7RShjvp?=
 =?us-ascii?Q?I4a4oxUzQi8xf1WR/LGQBcaNnQvRrH/uf8WpM85iu11wsvkDwdzmEK2lOYME?=
 =?us-ascii?Q?Ql5CxZNdCGpsMmUlF0F/q8QdnXhI9Oofqzh8dI+mUI9fo+vxGTZYYU6Lu227?=
 =?us-ascii?Q?QiTjqhdbVXq2E7Buh9pU/8N5JuHIgYokeRXOGSAtL7A6fnRqIkCLf4NO00zV?=
 =?us-ascii?Q?ayLPZpWpZRVUwrVdah01m1FBScMiZRYggm/7ZmFKr8jYQiBfdmhM4JDTuAbk?=
 =?us-ascii?Q?8cuuM0eHUGtnUQnaKI7W90RgnEolwHtbUccavEJlk39DLZxB9y46cvAQjWmy?=
 =?us-ascii?Q?MyVWg5fMREao2dyC74CI27PTitPSuCRB0U34KE99xirjzhz3AfthTsAgSFBk?=
 =?us-ascii?Q?h2tPGvnnDUqyZ0fyOHDhT09bEV0Qk0hQ9hxCaVD8EyEoTmyZfzxW6OJJDbMg?=
 =?us-ascii?Q?XR9VRr7s3usPyBvApUH8Q0LUlSmL7QU/9kxw+35nwxukr0arvui4ZqehPHYI?=
 =?us-ascii?Q?uMMDMZe41e5NqhmIzCbv7wbg1jZwSV3l9mZTOGi9gHLHJmy9QQ6Qe1Cyjg03?=
 =?us-ascii?Q?uyz92oGMqm/QlBAWJgoh0UmO9IyPf2NYFYNHJXc9rRmXaPlQ7pCRMc8p6T+7?=
 =?us-ascii?Q?MNNLB7raLdS0OS9mNxJVVcDjcQ9e0TakmcEffNjC5ALa8yxGRJ0aESqfH+Ba?=
 =?us-ascii?Q?FXW2rumlXjKmZHWy1D10FdPZDYo1QyvSeLg4SPIuXODkkz1EWEgyXdXf8ptw?=
 =?us-ascii?Q?H37/AYmnU3bvjGc0cs5SoUreXuO16lQhw4QVEHpzEX+N8LsBEY1CZHiPmM/U?=
 =?us-ascii?Q?wV0K77RgRULzo8gBuNddTqHulJKaGRpe1q6XMOINp1Qk164Yt9zn2ujnms2o?=
 =?us-ascii?Q?c6/CvrNaMOI9sgcmtyN5Kt0YjFZwnuLLcxASBAci8u5+LDctZcx8SybNDsQC?=
 =?us-ascii?Q?m5Z4PDcKbCdU4VB/XjcHhiD4/D1k3SjXKL+bh2hNRYkBpmbUGf3a?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: c868d4c2-2e11-486b-732f-08de805772b2
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Mar 2026 16:50:20.8559
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: F6iNIs3fk2Xv9qAQQ8kb9y50O6htAG8hPki2bjnap4wKKUTtoXvl4T/CwcmSLeT25LkW/t5fxMe4vnZSGc8KZg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCP286MB2018
X-Spamd-Result: default: False [1.34 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[valinux.co.jp,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[valinux.co.jp:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-9406-lists,dmaengine=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[22];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[kernel.org,google.com,lwn.net,linuxfoundation.org,kudzu.us,intel.com,gmail.com,tkos.co.il,baylibre.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[den@valinux.co.jp,dmaengine@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[valinux.co.jp:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[dmaengine];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,valinux.co.jp:dkim,valinux.co.jp:email,valinux.co.jp:mid]
X-Rspamd-Queue-Id: 2E7842761E2
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

When the peer advertises exported DMA ABI v1, create an auxiliary child
device named "ep_dma_v1" and pass the parsed locator and IRQ information
via a software node.

Register the child only after LINK_UP succeeds so the provider is not
probed before the remote BAR layout is live, and tear it down again on
link down or device removal.

This gives controller-specific frontends a clean attachment point
without teaching ntb_hw_epf about any particular DMA engine.

Signed-off-by: Koichiro Den <den@valinux.co.jp>
---
 drivers/ntb/hw/epf/Kconfig      |  1 +
 drivers/ntb/hw/epf/ntb_hw_epf.c | 87 +++++++++++++++++++++++++++++++++
 2 files changed, 88 insertions(+)

diff --git a/drivers/ntb/hw/epf/Kconfig b/drivers/ntb/hw/epf/Kconfig
index 314485574bf8..03139d6eddc8 100644
--- a/drivers/ntb/hw/epf/Kconfig
+++ b/drivers/ntb/hw/epf/Kconfig
@@ -1,5 +1,6 @@
 config NTB_EPF
 	tristate "Generic EPF Non-Transparent Bridge support"
+	select AUXILIARY_BUS
 	help
 	  This driver supports EPF NTB on configurable endpoint.
 	  If unsure, say N.
diff --git a/drivers/ntb/hw/epf/ntb_hw_epf.c b/drivers/ntb/hw/epf/ntb_hw_epf.c
index 6b427577b1bd..31f1d3bdffc9 100644
--- a/drivers/ntb/hw/epf/ntb_hw_epf.c
+++ b/drivers/ntb/hw/epf/ntb_hw_epf.c
@@ -7,9 +7,13 @@
  */
 
 #include <linux/atomic.h>
+#include <linux/auxiliary_bus.h>
+#include <linux/cleanup.h>
 #include <linux/delay.h>
+#include <linux/idr.h>
 #include <linux/module.h>
 #include <linux/pci.h>
+#include <linux/property.h>
 #include <linux/slab.h>
 #include <linux/ntb.h>
 
@@ -75,6 +79,8 @@
 
 #define NTB_EPF_COMMAND_TIMEOUT	1000 /* 1 Sec */
 
+static DEFINE_IDA(dma_aux_ids);
+
 enum pci_barno {
 	NO_BAR = -1,
 	BAR_0,
@@ -124,6 +130,8 @@ struct ntb_epf_dev {
 	u32 dma_irq_count;
 	enum pci_barno dma_bar;
 	bool dma_aux_avail;
+	bool dma_aux_added;
+	struct auxiliary_device *dma_auxdev;
 
 	void __iomem *ctrl_reg;
 	void __iomem *db_reg;
@@ -138,6 +146,78 @@ struct ntb_epf_dev {
 
 #define ntb_ndev(__ntb) container_of(__ntb, struct ntb_epf_dev, ntb)
 
+static void ntb_epf_dma_aux_release(struct device *dev)
+{
+	struct auxiliary_device *auxdev = to_auxiliary_dev(dev);
+
+	kfree(auxdev);
+}
+
+static int ntb_epf_register_dma_auxdev(struct ntb_epf_dev *ndev)
+{
+	const struct property_entry props[] = {
+		PROPERTY_ENTRY_U32("dma-abi", ndev->dma_abi),
+		PROPERTY_ENTRY_U32("dma-bar", ndev->dma_bar),
+		PROPERTY_ENTRY_U32("dma-offset", ndev->dma_offset),
+		PROPERTY_ENTRY_U32("dma-size", ndev->dma_size),
+		PROPERTY_ENTRY_U32("dma-num-chans", ndev->dma_num_chans),
+		PROPERTY_ENTRY_U32("dma-irq-base", ndev->dma_irq_base),
+		PROPERTY_ENTRY_U32("dma-irq-count", ndev->dma_irq_count),
+		{ }
+	};
+	int ret;
+
+	if (!ndev->dma_aux_avail || ndev->dma_abi != 1 || ndev->dma_aux_added)
+		return 0;
+
+	struct auxiliary_device *auxdev __free(kfree) = kzalloc_obj(*auxdev);
+	if (!auxdev)
+		return -ENOMEM;
+
+	ret = ida_alloc(&dma_aux_ids, GFP_KERNEL);
+	if (ret < 0)
+		return ret;
+
+	auxdev->name = "ep_dma_v1";
+	auxdev->id = ret;
+	auxdev->dev.parent = ndev->dev;
+	auxdev->dev.release = ntb_epf_dma_aux_release;
+
+	ret = auxiliary_device_init(auxdev);
+	if (ret)
+		goto err_free_id;
+
+	auxdev->dev.dma_parms = ndev->dev->dma_parms;
+
+	ret = device_create_managed_software_node(&auxdev->dev, props, NULL);
+	if (ret)
+		goto err_uninit;
+
+	ret = auxiliary_device_add(auxdev);
+	if (ret)
+		goto err_uninit;
+
+	ndev->dma_aux_added = true;
+	ndev->dma_auxdev = no_free_ptr(auxdev);
+	return 0;
+
+err_uninit:
+	auxiliary_device_uninit(auxdev);
+err_free_id:
+	ida_free(&dma_aux_ids, auxdev->id);
+	return ret;
+}
+
+static void ntb_epf_unregister_dma_auxdev(struct ntb_epf_dev *ndev)
+{
+	if (!ndev->dma_aux_added)
+		return;
+
+	auxiliary_device_delete(ndev->dma_auxdev);
+	auxiliary_device_uninit(ndev->dma_auxdev);
+	ndev->dma_aux_added = false;
+}
+
 static int ntb_epf_send_command(struct ntb_epf_dev *ndev, u32 command,
 				u32 argument)
 {
@@ -337,6 +417,10 @@ static int ntb_epf_link_enable(struct ntb_dev *ntb,
 		return ret;
 	}
 
+	ret = ntb_epf_register_dma_auxdev(ndev);
+	if (ret)
+		dev_warn(dev, "Failed to register DMA auxiliary device\n");
+
 	return 0;
 }
 
@@ -346,6 +430,8 @@ static int ntb_epf_link_disable(struct ntb_dev *ntb)
 	struct device *dev = ndev->dev;
 	int ret;
 
+	ntb_epf_unregister_dma_auxdev(ndev);
+
 	ret = ntb_epf_send_command(ndev, CMD_LINK_DOWN, 0);
 	if (ret) {
 		dev_err(dev, "Fail to disable link\n");
@@ -891,6 +977,7 @@ static void ntb_epf_pci_remove(struct pci_dev *pdev)
 {
 	struct ntb_epf_dev *ndev = pci_get_drvdata(pdev);
 
+	ntb_epf_unregister_dma_auxdev(ndev);
 	ntb_unregister_device(&ndev->ntb);
 	ntb_epf_cleanup_isr(ndev);
 	ntb_epf_deinit_pci(ndev);
-- 
2.51.0


