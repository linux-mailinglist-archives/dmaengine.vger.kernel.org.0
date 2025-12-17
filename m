Return-Path: <dmaengine+bounces-7758-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B0E03CC8680
	for <lists+dmaengine@lfdr.de>; Wed, 17 Dec 2025 16:23:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4E64B30DB498
	for <lists+dmaengine@lfdr.de>; Wed, 17 Dec 2025 15:16:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 615FF339B3D;
	Wed, 17 Dec 2025 15:16:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="jgQP6t3e"
X-Original-To: dmaengine@vger.kernel.org
Received: from OS0P286CU010.outbound.protection.outlook.com (mail-japanwestazon11011052.outbound.protection.outlook.com [40.107.74.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1F4630FC04;
	Wed, 17 Dec 2025 15:16:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.74.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765984583; cv=fail; b=eZKlF4LpIpNhbjit+B0zQ8+ktzkvJwiNj4q2LE+vhfbpRrN1BqsTyItQ0J/5WMb4CKBxAc9W9mdAc0dSGD9aypjuDqX5W9FDxWJuIzmOr8MU9rR2TGeGP6+lZZgD843aQt9f34eteU7poLhq1Zt9+6xcORMkzZW0D3IQS5HHDs4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765984583; c=relaxed/simple;
	bh=ES5VNqj4y9m2z1wuiXKQyDYDTfhbeVZVHq2VTYBeHxE=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=C80InA9M+eZreuL4YI2qfVzDFRMAoVEk9OmUGfIsvwEds/d6AfTnOIkC3GDvhNSkEsmCPn5fnlRK5vKiGlLZkozvY9WQZYEovhziZkKVIZAP+EnqR8gVwuZqcELArMz4i7WUwL5X3w8kUiCb8ZMVfG4yujLWFToecyQ1+ydmAJE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=jgQP6t3e; arc=fail smtp.client-ip=40.107.74.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vQFaIyVDmQG0DlFCVrn6zTD519b+MlEPxaL9wLZF4Mnkqy4ol3XDSSrFh7z5lRo55nWgey9y9Fa92zfYjnYg4Ms7qmTvYuirrit/pCoAufIpDq2tDqpucU7YsXRr3Dr4zIJuZSexT8k1O6Ei1R25Dxwmetojg1Pm6/xnQ/2pXzzKUZ3vwIIGmN9XIXDyGyAWaHj/tlCQPuzfTeNAtWELpZ1KYmm30H7K+Sb4/QSsAV9dAUZ+7xOlstfLIhD2oT3AZHWjAXdFtzUCLB0EYmOOQsTtlb9jK2ZLLOMbRYVgVatrxdwQC/RPSNPF1vgO6wuydIxF5tveJx6auvmHL2jU2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=o+Yv3ZJsp0yBp1FNd1VCpkcIhRC1lCmig+XExZ1PAKg=;
 b=dwQondfBd6TF8gItNbNkcwi1eI0uph+7hBPpDCwp6EySpncwtGRP9z0xsrW5e7SAm6u4w40XB3nOhGww7Wq2MMAREwPo6Of4pvBkdJCjiJRds9zAvcco5zHdXNjTo7iEqkgcpVu0nXJnovUI3e3ATEzcU2bbT+SZM7IE0t8VmkqPLiCYESRN/6w98+uuIRRmfVJq7CYpcJtP2Eo+Nqm2+v+4VbqzJ4z9YmEzy/SCTprL7UYnzrJY93XIDcN/1OdxH2zxEfKA6FC5T/mggK3t7LyRSaagXUfYiMpWi6Cr8807pDKzTqe6wtW84ihiHVya9H5lDCS0F4Q+Ah+gkkuPaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o+Yv3ZJsp0yBp1FNd1VCpkcIhRC1lCmig+XExZ1PAKg=;
 b=jgQP6t3emVnq4tsjuBARsyXQOPsVfoRn6n6nK/h2sdh4Zetof319YnQy1x+NzX1p4Lr56AdEYF6FkhcwEFw4vHEdyQWuyv1uVj8VWG8QiEAyTwIimunUclYQp8G7SfH1kfSL9FWDUR5nExhTSgEsM65z8IQHuE6gSnUn4JSks/M=
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
 15:16:13 +0000
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
Subject: [RFC PATCH v3 00/35] NTB transport backed by endpoint DW eDMA
Date: Thu, 18 Dec 2025 00:15:34 +0900
Message-ID: <20251217151609.3162665-1-den@valinux.co.jp>
X-Mailer: git-send-email 2.51.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCPR01CA0127.jpnprd01.prod.outlook.com
 (2603:1096:400:26d::12) To TYWP286MB2697.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:24c::11)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYWP286MB2697:EE_|OS9P286MB4633:EE_
X-MS-Office365-Filtering-Correlation-Id: 8dc9d895-7bd6-473d-5a0c-08de3d7f3737
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|10070799003|376014|7416014|1800799024|366016|13003099007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?P38+Uwro2/KL+jif89boGEamqkMkbtYlTsAzLNDVb4nsHDA77hVvwsLdaW5y?=
 =?us-ascii?Q?FQb3vHqoykUA6rJAWwOW09Z1odoNN2RdDsD0Ij8E/PPhOOf0SkAmyDKPa0/V?=
 =?us-ascii?Q?aJrZ3emm05iv+ypeuH9Nh/9jkHN48zsyISVG+6AKuz++ySVRUeTXD8ZgseNu?=
 =?us-ascii?Q?EMAmfBvxgAMkEa5IGmi3gF1y7QPOnb+C3wgj11FyvikvG7jGX//ltXa514S0?=
 =?us-ascii?Q?lmtLYqVFLxBDP10XhGKopWnpthQONJqhGN6Jy0DljqaKNYhTpbppJMvrJDD7?=
 =?us-ascii?Q?w8AR9DYm/cdlLPITUTOoh0tLtPPVe0PvvxdUcklNiNjr8SP8Vz2+NqHg+CLq?=
 =?us-ascii?Q?e2yXv2KXuFlAPPSxe50ekUkBNyUOYfYj7CVjLI3KAXTsINsuLI9lHlkrgXuO?=
 =?us-ascii?Q?jzC1IT0erTLwjKNfWTKUJRUAV/VPlISSxVHq5PrqtUU6g0RKJ/Nec6VMPBKE?=
 =?us-ascii?Q?gbYat76HV43H/KgpowTQpqu/kv8u2JfelteDUqv+txVEJgASXWoDP8okrvPZ?=
 =?us-ascii?Q?Waf3ZB5yXMxQAonLSotN2lj0jQmwiYrWar/w1EzTjXe/cstloqgzm0+jGEQK?=
 =?us-ascii?Q?M6fjjSMDHUPBZ8OxOwmA/jGoqamnF1NHYBv4bgQi6x75CxVJwIpSOTUSkodV?=
 =?us-ascii?Q?ubvnkNbNv8DPI+of4UlEPo8pSRcWiLZlM2FBfZ5Jg8nsYfIsq7or2IXz/iJp?=
 =?us-ascii?Q?2upgZcUbdjmuB+ap3KIRB/a7hjttiI90rHT3ZIoAAHL7OfyHMDvZWg0fxfvn?=
 =?us-ascii?Q?h+0QoJfoJGivpuGacyFn8eMtCvTocxK6qJjbxp9O35URKFvr+ODzHgw5/9Bc?=
 =?us-ascii?Q?Qy0qWwB/Yo26r/ZPpozaH2hqqBRgpJ5YpdgG+dNKlkAz0w1svv3Q83U8XuzJ?=
 =?us-ascii?Q?arRHCkCp71oNaa4Wg88IniLRvlhBvrhpLGm1OfSQjD62hfEFA0JYogWphKxN?=
 =?us-ascii?Q?5u+dzhhN+p9gZ1zg1yvD4Vdi6OcgGEDKwVtF7IdwrrFjoA0tqNYV+nRGFx6Q?=
 =?us-ascii?Q?e5o9U72mYY4TMaVXycJG5VVlNLZpVkIzoPQel0RumWb11Y9SkTTp/ZoIBU2l?=
 =?us-ascii?Q?44Vhb256aLuA1qdnDZUw9KRlR4QUm//udXNRes4r0Qd9zt9F19BmpzH/FOkZ?=
 =?us-ascii?Q?c85B1r1MGrX/pF0VrttylWewvZP3962zqcqbhlU3EnnDyYptwcKZ/VYQTA8m?=
 =?us-ascii?Q?wDjQdSS0S4urH4K6y20xtS6ARuiU+A888Dtx1Nhn1GHopV7vidhgr4QLBE1f?=
 =?us-ascii?Q?eIFvIhjyzSIgpz0tbdpvpPZU+QpemAuEVrrmAdc2TfcPVFnt1Q1LylbZx2vc?=
 =?us-ascii?Q?3p24NYsooIaL74sQi7IjyUI9Lb5+pXmVr9pSySqgKCYrH4XwMfln/4p7BYEw?=
 =?us-ascii?Q?8dxg70ZBsqgXw4m3lEGsYX8Wzkz26HriCErk4Nty+cov6s9TYbHYyvJBl582?=
 =?us-ascii?Q?Oh6uqLgLi+XavbKC9nJiRsQ4UfbDtUkt?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYWP286MB2697.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(376014)(7416014)(1800799024)(366016)(13003099007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Uvv6Sd75i3CpLRwXLVlv8ia3kvd5ck3RBQ8fdqa+FHBgnxW7WJZsv/SJ7Adl?=
 =?us-ascii?Q?TblXegMghxenSI+OK9Ei+IbdcW7XGcZzY0KjqYWpQ33D+IEpBMSbXhYtQmld?=
 =?us-ascii?Q?gDnf8TssgboAAI2BlllCT+35ClhWetuP+j715zS1+FayEkuXGQL/s4KRN0iS?=
 =?us-ascii?Q?PK4vDhVtK2x8uyH55FZm7y1LFiqYJJ2lzQhfk3Oloj0kXVfEE2dSuqZbZi1Q?=
 =?us-ascii?Q?BlBjXGHahDb5R1pw5btKRtU5voZ1Yiq6oaKClKB+17r0i8Q9mTYo1UCMAPIE?=
 =?us-ascii?Q?9yshCFOroTxrdPU4CdVlkjH268j2UWgyNXKkvo7V9BCE2IDhAD7snxR3XYdr?=
 =?us-ascii?Q?weIG3O1LEIm4FykwSPcNagzy3S8h9JsOxwwza4AzSF01OTiQBAZJLmiYnBcd?=
 =?us-ascii?Q?RpwCc76u4Wop4NC2LfjZ/ZOIxUK8GL7a+lhirJumSFMN/lsQImC2c6sexXUi?=
 =?us-ascii?Q?a9lmLXB0QbibBiP6G+a+m/dvntpwNT/cD1BpVt7+NMLw/1gWKzjFF6eN+4pF?=
 =?us-ascii?Q?G339LG27Pmr9WNUR0mPuM1VD88Rds1ZGOZeEeBllXboItfugAIqPKYOT1T/g?=
 =?us-ascii?Q?jeTjIvo4LeEcvCf9f+bwlHGsf2E6otRq6zYQSI3mX9l1sMgqAokoaLoBxuAH?=
 =?us-ascii?Q?cAuats/a8OYdPrMHZdwTPGYAcp3mQ/WlimnlZVSKRUUnTtIrbj6NBDYbRMVw?=
 =?us-ascii?Q?Mw8eXFeXOYxafdRhSZE7AEol96tIF+Svb0zWK4ZVDzJUlUdXqUoLojrmx2Ay?=
 =?us-ascii?Q?HbQK+fy/yhcJl/d1mXhmD93GU+cNVUjfXX0+jnVwdmOSFUlNKVQtdQTwgZeA?=
 =?us-ascii?Q?odIO0OOZ0pJe5bS+l2KaVluu41uF6VIqsIq6/TO+OilvXB85juIosMdB66c6?=
 =?us-ascii?Q?XWXGlgftse3tcU8EowZH9pK498Qctsof7OuGQ+P4bycqjh0xTsOjU/viHn39?=
 =?us-ascii?Q?MklJY3R7TcT1jzCB/Yl6WfhcoPPDj2/VFNdBdgg1ZeZOeu+nBA43z5KcJnG/?=
 =?us-ascii?Q?VQENTJmF4efZe5XPTtm228tnltQY7rJAqSDsXdFclcsMOCt8jzdDT6zaUFDN?=
 =?us-ascii?Q?rfMKqX7huH3FkFzKvf+puLSMBFMsOhKgnC/exQtWu79ZQdrd5OleG/Ie40s2?=
 =?us-ascii?Q?BT8UDcb+0izHz7Hnj1dsa4XnzJ54ECUgT1aTZErASck/jDyMuVYyryxOf+9v?=
 =?us-ascii?Q?nDH6ONhqQXajG7YQsFNyaDZdNp7ZAUdE5IFd0j5qSTCHaJsC6zWDfV9ZnXjP?=
 =?us-ascii?Q?v41R+m3HBLLZSJTWcYvwgo0thEK3oQrIdViEO0t09MkQpUMIWeF0OzGJAeyC?=
 =?us-ascii?Q?8igBdqg1NnGMiNipdHDr3EKjYp02X0HpXZQCZiLVISNsolv505SGuTbmAmFD?=
 =?us-ascii?Q?Vg3es0SOV1LJzyymWAa5I0WL5Y7qMHbT6+2af4zEqnFVfdHtwG40Pu2hzJGA?=
 =?us-ascii?Q?/X9Zc2AU651AnOrqfXckxeTWuyNEPb1oL1Ds9tXnHn8teEv127EKLPw2SspY?=
 =?us-ascii?Q?Q7KwnJmZsWnSbKEhZKiNzDXNJh0i2kNPZWsFtx1Pfe/+EqkaZ3teUIfb0zXO?=
 =?us-ascii?Q?5LytMkt1kh5YMQy82Z/c4AKhQFWy/H8FVExaUrBYcoYPw5bS6speSCPzCnhV?=
 =?us-ascii?Q?8FPKSy8by9ULQA0bIo4og8o=3D?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: 8dc9d895-7bd6-473d-5a0c-08de3d7f3737
X-MS-Exchange-CrossTenant-AuthSource: TYWP286MB2697.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Dec 2025 15:16:13.1366
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PpPnAT22euMZdYkFSqP3ESzHvO6uXTSF4GlqaF1YrAURsYOZLCK3yJzQr3ptPjkUjcGKP2PtcjhtaQ/5tU8Q4w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS9P286MB4633

Hi,

This is RFC v3 of the NTB/PCI series that introduces NTB transport backed
by DesignWare PCIe integrated eDMA.

  RFC v2: https://lore.kernel.org/all/20251129160405.2568284-1-den@valinux.co.jp/
  RFC v1: https://lore.kernel.org/all/20251023071916.901355-1-den@valinux.co.jp/

The goal is to improve performance between a host and an endpoint over
ntb_transport (typically with ntb_netdev on top). On R-Car S4, preliminary
iperf3 results show 10~20x throughput improvement. Latency improvements are
also observed.

In this approach, payload is transferred by DMA directly between host and
endpoint address spaces, and the NTB Memory Window is primarily used as a
control/metadata window (and to expose the eDMA register/LL regions).
Compared to the memcpy-based transport, this avoids extra copies and
enables deeper rings and scales out to multiple queue pairs.

Compared to RFC v2, data plane works in a symmetric manner in both
directions (host-to-endpoint and endpoint-to-host). The host side drives
remote read channels for its TX transfer while the endpoint drives local
write channels.

Again, I recognize that this is quite a large series. Sorry for the volume,
but for the RFC stage I believe presenting the full picture in a single set
helps with reviewing the overall architecture (Of course detail feedback
would be appreciated as well). Once the direction is agreed, I will respin
it split by subsystem and topic.

Many thanks for all the reviews and feedback from multiple perspectives.


Data flow overview
==================

    Figure 1. RC->EP traffic via ntb_netdev+ntb_transport
                     backed by Remote eDMA

          EP                                   RC
       phys addr                            phys addr
         space                                space
          +-+                                  +-+
          | |                                  | |
          | |                ||                | |
          +-+-----.          ||                | |
 EDMA REG | |      \    [A]  ||                | |
          +-+----.  '---+-+  ||                | |
          | |     \     | |<---------[0-a]----------
          +-+-----------| |<----------[2]----------.
  EDMA LL | |           | |  ||                | | :
          | |           | |  ||                | | :
          +-+-----------+-+  ||  [B]           | | :
          | |                ||  ++            | | :
       ---------[0-b]----------->||----------------'
          | |            ++  ||  ||            | |
          | |            ||  ||  ++            | |
          | |            ||<----------[4]-----------
          | |            ++  ||                | |
          | |           [C]  ||                | |
       .--|#|<------------------------[3]------|#|<-.
       :  |#|                ||                |#|  :
      [5] | |                ||                | | [1]
       :  | |                ||                | |  :
       '->|#|                                  |#|--'
          |#|                                  |#|
          | |                                  | |


    Figure 2. EP->RC traffic via ntb_netdev+ntb_transport
                     backed by EP-Local eDMA

          EP                                   RC
       phys addr                            phys addr
         space                                space
          +-+                                  +-+
          | |                                  | |
          | |                ||                | |
          +-+                ||                | |
 EDMA REG | |                ||                | |
          +-+                ||                | |
^         | |                ||                | |
:         +-+                ||                | |
: EDMA LL | |                ||                | |
:         | |                ||                | |
:         +-+                ||  [C]           | |
:         | |                ||  ++            | |
:      -----------[4]----------->||            | |
:         | |            ++  ||  ||            | |
:         | |            ||  ||  ++            | |
'----------------[2]-----||<--------[0-b]-----------
          | |            ++  ||                | |
          | |           [B]  ||                | |
       .->|#|--------[3]---------------------->|#|--.
       :  |#|                ||                |#|  :
      [1] | |                ||                | | [5]
       :  | |                ||                | |  :
       '--|#|                                  |#|<-'
          |#|                                  |#|
          | |                                  | |


      0-a. configure Remote eDMA
      0-b. DMA-map and produce DAR
      1.   memcpy while building skb in ntb_netdev case
      2.   consume DAR, DMA-map SAR and kick DMA read transfer
      3.   DMA transfer
      4.   consume (commit)
      5.   memcpy to application side

      [A]: MemoryWindow that aggregates eDMA regs and LL.
           IB iATU translations (Address Match Mode).
      [B]: Control plane ring buffer (for "produce")
      [C]: Control plane ring buffer (for "consume")

  Note:
    - Figure 1 is unchanged from RFC v2.
    - Figure 2 differs from the one depicted in RFC v2 cover letter.


Changes since RFC v2
====================

RFCv2->RFCv3 changes:
  - Architecture
    - Have EP side use its local write channels, while leaving RC side to
      use remote read channels.
    - Abstraction/HW-specific stuff encapsulation improved.
  - Added control/config region versioning for the vNTB/EPF control region
    so that mismatched RC/EP kernels fail early instead of silently using an
    incompatible layout.
  - Reworked BAR subrange / multi-region mapping support:
    - Dropped the v2 approach that added new inbound mapping ops in the EPC
      core.
    - Introduced `struct pci_epf_bar.submap` and extended DesignWare EP to
      support BAR subrange inbound mapping via Address Match Mode IB iATU.
    - pci-epf-vntb now provides a subrange mapping hint to the EPC driver
      when offsets are used.
  - Changed .get_pci_epc() to .get_private_data()
  - Dropped two commits from RFC v2 that should be submitted separately:
    (1) ntb_transport debugfs seq_file conversion
    (2) DWC EP outbound iATU MSI mapping/cache fix (will be re-posted separately)
  - Added documentation updates.
  - Addressed assorted review nits from the RFC v2 thread (naming/structure).

RFCv1->RFCv2 changes:
  - Architecture
    - Drop the generic interrupt backend + DW eDMA test-interrupt backend
      approach and instead adopt the remote eDMA-backed ntb_transport mode
      proposed by Frank Li. The BAR-sharing / mwN_offset / inbound
      mapping (Address Match Mode) infrastructure from RFC v1 is largely
      kept, with only minor refinements and code motion where necessary
      to fit the new transport-mode design.
  - For Patch 01
    - Rework the array_index_nospec() conversion to address review
      comments on "[RFC PATCH 01/25]".

RFCv2: https://lore.kernel.org/all/20251129160405.2568284-1-den@valinux.co.jp/
RFCv1: https://lore.kernel.org/all/20251023071916.901355-1-den@valinux.co.jp/


Patch layout
============

  Patch 01-25 : preparation for Patch 26
                - 01-07: support multiple MWs in a BAR
		- 08-25: other misc preparations
  Patch 26    : main and most important patch, adds eDMA-backed transport
  Patch 27-28 : multi-queue use, thanks to the remote eDMA, performance
                scales
  Patch 29-33 : handle several SoC-specific issues so that remote eDMA
                mode ntb_transport works on R-Car S4
  Patch 34-35 : kernel doc updates


Tested on
=========

* 2x Renesas R-Car S4 Spider (RC<->EP connected with OcuLink cable)
* Kernel base: next-20251216 + [1] + [2] + [3]

  [1]: https://lore.kernel.org/all/20251210071358.2267494-2-cassel@kernel.org/
       (this is a spin-out patch from
        https://lore.kernel.org/linux-pci/20251129160405.2568284-20-den@valinux.co.jp/)
  [2]: https://lore.kernel.org/all/20251208-dma_prep_config-v1-0-53490c5e1e2a@nxp.com/
       (while it appears to still be under active discussion)
  [3]: https://lore.kernel.org/all/20251217081955.3137163-1-den@valinux.co.jp/
       (this is a spin-out patch from
        https://lore.kernel.org/all/20251129160405.2568284-14-den@valinux.co.jp/)


Performance measurement
=======================

No serious measurements yet, because:
  * For "before the change", even use_dma/use_msi does not work on the
    upstream kernel unless we apply some patches for R-Car S4. With some
    unmerged patch series I had posted earlier (but superseded by this RFC
    attempt), it was observed that we can achieve about 7 Gbps for the
    RC->EP direction. Pure upstream kernel can achieve around 500 Mbps
    though.
  * For "after the change", measurements are not mature because this
    RFC v3 patch series is not yet performance-optimized at this stage.

Here are the rough measurements showing the achievable performance on
the R-Car S4:

- Before this change:

  * ping
    64 bytes from 10.0.0.11: icmp_seq=1 ttl=64 time=12.3 ms
    64 bytes from 10.0.0.11: icmp_seq=2 ttl=64 time=6.58 ms
    64 bytes from 10.0.0.11: icmp_seq=3 ttl=64 time=1.26 ms
    64 bytes from 10.0.0.11: icmp_seq=4 ttl=64 time=7.43 ms
    64 bytes from 10.0.0.11: icmp_seq=5 ttl=64 time=1.39 ms
    64 bytes from 10.0.0.11: icmp_seq=6 ttl=64 time=7.38 ms
    64 bytes from 10.0.0.11: icmp_seq=7 ttl=64 time=1.42 ms
    64 bytes from 10.0.0.11: icmp_seq=8 ttl=64 time=7.41 ms

  * RC->EP (`sudo iperf3 -ub0 -l 65480 -P 2`)
    [ ID] Interval           Transfer     Bitrate         Jitter    Lost/Total Datagrams
    [  5]   0.00-10.01  sec   344 MBytes   288 Mbits/sec  3.483 ms  51/5555 (0.92%)  receiver
    [  6]   0.00-10.01  sec   342 MBytes   287 Mbits/sec  3.814 ms  38/5517 (0.69%)  receiver
    [SUM]   0.00-10.01  sec   686 MBytes   575 Mbits/sec  3.648 ms  89/11072 (0.8%)  receiver

  * EP->RC (`sudo iperf3 -ub0 -l 65480 -P 2`)
    [  5]   0.00-10.03  sec   334 MBytes   279 Mbits/sec  3.164 ms  390/5731 (6.8%)  receiver
    [  6]   0.00-10.03  sec   334 MBytes   279 Mbits/sec  2.416 ms  396/5741 (6.9%)  receiver
    [SUM]   0.00-10.03  sec   667 MBytes   558 Mbits/sec  2.790 ms  786/11472 (6.9%)  receiver

    Note: with `-P 2`, the best total bitrate (receiver side) was achieved.

- After this change (use_remote_edma=1):

  * ping
    64 bytes from 10.0.0.11: icmp_seq=1 ttl=64 time=1.42 ms
    64 bytes from 10.0.0.11: icmp_seq=2 ttl=64 time=1.38 ms
    64 bytes from 10.0.0.11: icmp_seq=3 ttl=64 time=1.21 ms
    64 bytes from 10.0.0.11: icmp_seq=4 ttl=64 time=1.02 ms
    64 bytes from 10.0.0.11: icmp_seq=5 ttl=64 time=1.06 ms
    64 bytes from 10.0.0.11: icmp_seq=6 ttl=64 time=0.995 ms
    64 bytes from 10.0.0.11: icmp_seq=7 ttl=64 time=0.964 ms
    64 bytes from 10.0.0.11: icmp_seq=8 ttl=64 time=1.49 ms

  * RC->EP (`sudo iperf3 -ub0 -l 65480 -P 4`)
    [  5]   0.00-10.02  sec  3.00 GBytes  2.58 Gbits/sec  0.437 ms  33053/82329 (40%)  receiver
    [  6]   0.00-10.02  sec  3.00 GBytes  2.58 Gbits/sec  0.174 ms  46379/95655 (48%)  receiver
    [  9]   0.00-10.02  sec  2.88 GBytes  2.47 Gbits/sec  0.106 ms  47672/94924 (50%)  receiver
    [ 11]   0.00-10.02  sec  2.87 GBytes  2.46 Gbits/sec  0.364 ms  23694/70817 (33%)  receiver
    [SUM]   0.00-10.02  sec  11.8 GBytes  10.1 Gbits/sec  0.270 ms  150798/343725 (44%)  receiver

  * EP->RC (`sudo iperf3 -ub0 -l 65480 -P 4`)
    [  5]   0.00-10.01  sec  3.28 GBytes  2.82 Gbits/sec  0.380 ms  38578/92355 (42%)  receiver
    [  6]   0.00-10.01  sec  3.24 GBytes  2.78 Gbits/sec  0.430 ms  14268/67340 (21%)  receiver
    [  9]   0.00-10.01  sec  2.92 GBytes  2.51 Gbits/sec  0.074 ms  0/47890 (0%)  receiver
    [ 11]   0.00-10.01  sec  4.76 GBytes  4.09 Gbits/sec  0.037 ms  0/78073 (0%)  receiver
    [SUM]   0.00-10.01  sec  14.2 GBytes  12.2 Gbits/sec  0.230 ms  52846/285658 (18%)  receiver

  * configfs settings:
      # modprobe pci_epf_vntb
      # cd /sys/kernel/config/pci_ep/
      # mkdir functions/pci_epf_vntb/func1
      # echo 0x1912 >   functions/pci_epf_vntb/func1/vendorid
      # echo 0x0030 >   functions/pci_epf_vntb/func1/deviceid
      # echo 32 >       functions/pci_epf_vntb/func1/msi_interrupts
      # echo 16 >       functions/pci_epf_vntb/func1/pci_epf_vntb.0/db_count
      # echo 128 >      functions/pci_epf_vntb/func1/pci_epf_vntb.0/spad_count
      # echo 2 >        functions/pci_epf_vntb/func1/pci_epf_vntb.0/num_mws
      # echo 0xe0000 >  functions/pci_epf_vntb/func1/pci_epf_vntb.0/mw1
      # echo 0x20000 >  functions/pci_epf_vntb/func1/pci_epf_vntb.0/mw2
      # echo 0xe0000 >  functions/pci_epf_vntb/func1/pci_epf_vntb.0/mw2_offset
      # echo 0x1912 >   functions/pci_epf_vntb/func1/pci_epf_vntb.0/vntb_vid
      # echo 0x0030 >   functions/pci_epf_vntb/func1/pci_epf_vntb.0/vntb_pid
      # echo 0x10 >     functions/pci_epf_vntb/func1/pci_epf_vntb.0/vbus_number
      # echo 0 >        functions/pci_epf_vntb/func1/pci_epf_vntb.0/ctrl_bar
      # echo 4 >        functions/pci_epf_vntb/func1/pci_epf_vntb.0/db_bar
      # echo 2 >        functions/pci_epf_vntb/func1/pci_epf_vntb.0/mw1_bar
      # echo 2 >        functions/pci_epf_vntb/func1/pci_epf_vntb.0/mw2_bar
      # ln -s controllers/e65d0000.pcie-ep functions/pci_epf_vntb/func1/primary/
      # echo 1 > controllers/e65d0000.pcie-ep/start



Thank you for reviewing,


Koichiro Den (35):
  PCI: endpoint: pci-epf-vntb: Use array_index_nospec() on mws_size[]
    access
  NTB: epf: Add mwN_offset support and config region versioning
  PCI: dwc: ep: Support BAR subrange inbound mapping via address match
    iATU
  NTB: Add offset parameter to MW translation APIs
  PCI: endpoint: pci-epf-vntb: Propagate MW offset from configfs when
    present
  NTB: ntb_transport: Support partial memory windows with offsets
  PCI: endpoint: pci-epf-vntb: Hint subrange mapping preference to EPC
    driver
  NTB: core: Add .get_private_data() to ntb_dev_ops
  NTB: epf: vntb: Implement .get_private_data() callback
  dmaengine: dw-edma: Fix MSI data values for multi-vector IMWr
    interrupts
  NTB: ntb_transport: Move TX memory window setup into setup_qp_mw()
  NTB: ntb_transport: Dynamically determine qp count
  NTB: ntb_transport: Introduce get_dma_dev() helper
  NTB: epf: Reserve a subset of MSI vectors for non-NTB users
  NTB: ntb_transport: Move internal types to ntb_transport_internal.h
  NTB: ntb_transport: Introduce ntb_transport_backend_ops
  dmaengine: dw-edma: Add helper func to retrieve register base and size
  dmaengine: dw-edma: Add per-channel interrupt routing mode
  dmaengine: dw-edma: Poll completion when local IRQ handling is
    disabled
  dmaengine: dw-edma: Add notify-only channels support
  dmaengine: dw-edma: Add a helper to retrieve LL (Linked List) region
  dmaengine: dw-edma: Serialize RMW on shared interrupt registers
  NTB: ntb_transport: Split core into ntb_transport_core.c
  NTB: ntb_transport: Add additional hooks for DW eDMA backend
  NTB: hw: Introduce DesignWare eDMA helper
  NTB: ntb_transport: Introduce DW eDMA backed transport mode
  NTB: epf: Provide db_vector_count/db_vector_mask callbacks
  ntb_netdev: Multi-queue support
  NTB: epf: Add per-SoC quirk to cap MRRS for DWC eDMA (128B for R-Car)
  iommu: ipmmu-vmsa: Add PCIe ch0 to devices_allowlist
  iommu: ipmmu-vmsa: Add support for reserved regions
  arm64: dts: renesas: Add Spider RC/EP DTs for NTB with remote DW PCIe
    eDMA
  NTB: epf: Add an additional memory window (MW2) barno mapping on
    Renesas R-Car
  Documentation: PCI: endpoint: pci-epf-vntb: Update and add mwN_offset
    usage
  Documentation: driver-api: ntb: Document remote eDMA transport backend

 Documentation/PCI/endpoint/pci-vntb-howto.rst |  16 +-
 Documentation/driver-api/ntb.rst              |  58 +
 arch/arm64/boot/dts/renesas/Makefile          |   2 +
 .../boot/dts/renesas/r8a779f0-spider-ep.dts   |  37 +
 .../boot/dts/renesas/r8a779f0-spider-rc.dts   |  52 +
 drivers/dma/dw-edma/dw-edma-core.c            | 233 ++++-
 drivers/dma/dw-edma/dw-edma-core.h            |  13 +-
 drivers/dma/dw-edma/dw-edma-v0-core.c         |  39 +-
 drivers/iommu/ipmmu-vmsa.c                    |   7 +-
 drivers/net/ntb_netdev.c                      | 341 ++++--
 drivers/ntb/Kconfig                           |  12 +
 drivers/ntb/Makefile                          |   4 +
 drivers/ntb/hw/amd/ntb_hw_amd.c               |   6 +-
 drivers/ntb/hw/edma/ntb_hw_edma.c             | 754 +++++++++++++
 drivers/ntb/hw/edma/ntb_hw_edma.h             |  76 ++
 drivers/ntb/hw/epf/ntb_hw_epf.c               | 187 +++-
 drivers/ntb/hw/idt/ntb_hw_idt.c               |   3 +-
 drivers/ntb/hw/intel/ntb_hw_gen1.c            |   6 +-
 drivers/ntb/hw/intel/ntb_hw_gen1.h            |   2 +-
 drivers/ntb/hw/intel/ntb_hw_gen3.c            |   3 +-
 drivers/ntb/hw/intel/ntb_hw_gen4.c            |   6 +-
 drivers/ntb/hw/mscc/ntb_hw_switchtec.c        |   6 +-
 drivers/ntb/msi.c                             |   6 +-
 .../{ntb_transport.c => ntb_transport_core.c} | 482 ++++-----
 drivers/ntb/ntb_transport_edma.c              | 987 ++++++++++++++++++
 drivers/ntb/ntb_transport_internal.h          | 220 ++++
 drivers/ntb/test/ntb_perf.c                   |   4 +-
 drivers/ntb/test/ntb_tool.c                   |   6 +-
 .../pci/controller/dwc/pcie-designware-ep.c   | 198 +++-
 drivers/pci/controller/dwc/pcie-designware.c  |  25 +
 drivers/pci/controller/dwc/pcie-designware.h  |   2 +
 drivers/pci/endpoint/functions/pci-epf-vntb.c | 246 ++++-
 drivers/pci/endpoint/pci-epc-core.c           |   2 +-
 include/linux/dma/edma.h                      | 106 ++
 include/linux/ntb.h                           |  38 +-
 include/linux/ntb_transport.h                 |   5 +
 include/linux/pci-epf.h                       |  27 +
 37 files changed, 3716 insertions(+), 501 deletions(-)
 create mode 100644 arch/arm64/boot/dts/renesas/r8a779f0-spider-ep.dts
 create mode 100644 arch/arm64/boot/dts/renesas/r8a779f0-spider-rc.dts
 create mode 100644 drivers/ntb/hw/edma/ntb_hw_edma.c
 create mode 100644 drivers/ntb/hw/edma/ntb_hw_edma.h
 rename drivers/ntb/{ntb_transport.c => ntb_transport_core.c} (91%)
 create mode 100644 drivers/ntb/ntb_transport_edma.c
 create mode 100644 drivers/ntb/ntb_transport_internal.h

-- 
2.51.0


