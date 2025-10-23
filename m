Return-Path: <dmaengine+bounces-6942-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 67DDBBFF8B8
	for <lists+dmaengine@lfdr.de>; Thu, 23 Oct 2025 09:25:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 76456505A36
	for <lists+dmaengine@lfdr.de>; Thu, 23 Oct 2025 07:23:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E97132EB5CD;
	Thu, 23 Oct 2025 07:19:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="LPZ8ljZh"
X-Original-To: dmaengine@vger.kernel.org
Received: from OS0P286CU010.outbound.protection.outlook.com (mail-japanwestazon11011034.outbound.protection.outlook.com [40.107.74.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 064F92E091C;
	Thu, 23 Oct 2025 07:19:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.74.34
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761203977; cv=fail; b=fCEeItaN1jaMPjMDb2g5Bd2fINmllRQc6oj9rWBI9WzPAJxBE1Ueks5I2+OgxnoxteeN18/j7PJwz8SdesRNhwWRGV0Ww/+5TR6Xt/jpKpaAITOiyFJN3OnNtQ+kyLuecTMbxvT8bIdmac2/vDBuewBRSugGKyQvUo396eacfKY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761203977; c=relaxed/simple;
	bh=vMRjcRdLL5kTQatVK1p/TBMxB28CeRsl4xhwqjSiACU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=bkyhkxokMq7kGSpFtgYr1V5q9QX4LvWcqOwgsY7POAuUGuARtK4D/SX+BwG9Qai9p8VHf7TC/1sCTgfYDfGocaE7zozxlfZod4X1T+lRQoMx3eLNFC80nL55DY8HmCzOh2Z2hMW2cRQ8P3QRw+M//PAb1P8uQe7CBRtt1ZiPO5A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=LPZ8ljZh; arc=fail smtp.client-ip=40.107.74.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MRUIizQfTrgWcxZgW0kiHxHeoXctKzoCLmT20IQ8nBa8Zf+xtbz+Dh+QeeDDn10mLaqESL4WKMi94klDnk7b94POY8DFMXz6mX9ftsGwuktVxktsmEsDdoisTdOPiNAaox5yaTPHCUdRKwoGkfB15qWsGxgs44lAHCidB15e9eRY1gAJwh2HGd4nQBpz5EapB3ZaASdDbHbXCUA+xsAgnei+688YFysSkNHmLWLQVCqkluRimiZ5Tkh9ROTE2zo0JImhPpXYfXcv98Llk0q0UJflRNTV+vnqL11gfWr4kF4Gzbu9i65ZmDTnzt0UzW2JrZrYL5LkwVFY4Eg9o/JQOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CmZNTGPYpiwoSjUlrm5cWdx8zS/I5W1C0eHjpAy30p0=;
 b=k7LCFtF8BksTfbzHFIc6T1Wm/I9PFi2/8Up0ClY+Lm+XudLJ5xQ/0jFl6PQnkY0WZNr7sSBx+pHQ0h76j2hkdomYKABlq/gd93Kka2MH4nD8RHso+qWqeTjzVARaU3KcgN8ji42F0VaVDBMe9Z/2ithWPogiH6nKSwevOdYp94Ye2ACfQGR+Ct4RxA5f11XEshi877dlgd43NxZdHKcXyyPj3wug7cd3rFhClvOkaDBwJpjEGXCARFLMv+x0PK2VSwi8m1gOyuhN8pCeG4XQLjupoycwp01bNNJwcB7XjxRvVDZGznjMI6jXFP0pLLk6s6nw/qOIT5Z4/31uA0OfRQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CmZNTGPYpiwoSjUlrm5cWdx8zS/I5W1C0eHjpAy30p0=;
 b=LPZ8ljZhwiGfLYZvqtfSImE570EEJ70fhTo2p3U6JCc3ZivgI1mRmUxIvULILiaEIaktco8EPRrtuscwxt91n3CQG6KwYNK9wfgGVxpF4xhIHSQccDQIyX+ReZXm70+j50WrByFHoUnceD3j5F7+woDANUOiwjIxBtKym6ldbWY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from OS3P286MB0979.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:10d::7)
 by OS7P286MB7183.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:456::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.13; Thu, 23 Oct
 2025 07:19:32 +0000
Received: from OS3P286MB0979.JPNP286.PROD.OUTLOOK.COM
 ([fe80::80f1:db56:4a11:3f7a]) by OS3P286MB0979.JPNP286.PROD.OUTLOOK.COM
 ([fe80::80f1:db56:4a11:3f7a%5]) with mapi id 15.20.9253.011; Thu, 23 Oct 2025
 07:19:32 +0000
From: Koichiro Den <den@valinux.co.jp>
To: ntb@lists.linux.dev,
	linux-pci@vger.kernel.org,
	dmaengine@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: mani@kernel.org,
	kwilczynski@kernel.org,
	kishon@kernel.org,
	bhelgaas@google.com,
	corbet@lwn.net,
	vkoul@kernel.org,
	jdmason@kudzu.us,
	dave.jiang@intel.com,
	allenbh@gmail.com,
	Basavaraj.Natikar@amd.com,
	Shyam-sundar.S-k@amd.com,
	kurt.schwemmer@microsemi.com,
	logang@deltatee.com,
	jingoohan1@gmail.com,
	lpieralisi@kernel.org,
	robh@kernel.org,
	jbrunet@baylibre.com,
	Frank.Li@nxp.com,
	fancer.lancer@gmail.com,
	arnd@arndb.de,
	pstanner@redhat.com,
	elfring@users.sourceforge.net
Subject: [RFC PATCH 08/25] PCI: endpoint: pci-epf-vntb: Propagate MW offset from configfs when present
Date: Thu, 23 Oct 2025 16:18:59 +0900
Message-ID: <20251023071916.901355-9-den@valinux.co.jp>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20251023071916.901355-1-den@valinux.co.jp>
References: <20251023071916.901355-1-den@valinux.co.jp>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TY4P301CA0085.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:405:37a::15) To OS3P286MB0979.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:604:10d::7)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: OS3P286MB0979:EE_|OS7P286MB7183:EE_
X-MS-Office365-Filtering-Correlation-Id: d53fb424-e457-4afb-62dd-08de12048307
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|7416014|1800799024|10070799003;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?evjLJQm41wAxc3V6TqyCJl0u/OHQkrli8ODYZwUwO303NtAxTiiWj9mWAEv+?=
 =?us-ascii?Q?mxPyl4ZXREZBOZ/YdmPvhCCLgHwR2TUeQN/iXf6xf3agCm0T/i55fAZW559n?=
 =?us-ascii?Q?AvR5HPiB2lRrwlrJwgkoG0LnoPkrNfraGBIU51Q0J3YaYyDwMQjFxMb3h1kd?=
 =?us-ascii?Q?FSrZhyfcqxKZaiBPvIuAQ7GH+SAU/WOqy1P8RxdGU8TEwh95Qu7NGUnIpB3D?=
 =?us-ascii?Q?wn0INv5xmLHhhiNIon1ArDXL4WABi4HB9qA3UCkYsuE3xVYL4+9NpuB2qkGf?=
 =?us-ascii?Q?C5ZiHsjY+LueGsY/1E+EfYf9mPwoYCcZPwSdwx3e7sQ9daGI7Rit2QDpXOfE?=
 =?us-ascii?Q?mn7JTAslGJNGjEFQJH9l0kpsf2R9wwBpOs4FWkUBVBCSZ96m2L3qP1BUOZz4?=
 =?us-ascii?Q?slb8VuAPO5tTEKmSTs1Ga4s1Ik1e2o7Cl12Hj7PUNB0KDC+aGjtPYQzAC3ng?=
 =?us-ascii?Q?E+3wkSyw+0w396tBeOhmoq2856WzgroSnMWJS95Rrx7AJrc8lQFbPjSqdQl1?=
 =?us-ascii?Q?N6iPtLWyH21CtoLQEUOg7eFtAWrWE+x9IuotXO0T8NpC+YgAIvU074/D/I03?=
 =?us-ascii?Q?Se0sp+SrN2wUfMOeP+IsISzREj3D2QO3W+PINnnVcarwmhnuRgKoifiQ7hK/?=
 =?us-ascii?Q?YUlzE++BHSUf1HLT4depkTmT0lhz35ygk4ijdgtdKfnvHh2C0NpMgNCLrg1y?=
 =?us-ascii?Q?vHDMdsE9+ed8xnrJcgLp+6EPyN6/jQf2FtXlVYMEPx35p8Y2V+h4kV7Na/U8?=
 =?us-ascii?Q?C8BFmK05OgMGqcPUmo7LnxoYd4BDqhTOKDNptAoqSg4gE8hD6VCdOCeLF8U/?=
 =?us-ascii?Q?9mvzYIYr/df7KWTOb0p2rcOIBDc6/RGrBTcf+08Ob9Pzj+MphWdoyq0sxosn?=
 =?us-ascii?Q?hUz8HMY0kqJ2BVedlfOJONdEKzEkXxS0zwut2oL34DlE2HSbCIFlZnTGjwjT?=
 =?us-ascii?Q?kKg6WcZrc3AejFMehC/MctCmM8u9DkCltWG7CpEWIozj+o6+N+zsYIVExBuR?=
 =?us-ascii?Q?aolD4yXBUFfHwDZZD7s+ITcQIm0cULDQjI5TaN46OhIjC7IUc1QdcVlRc50x?=
 =?us-ascii?Q?NLB1lbiLBq7HvZkkyJMEOLLvOM/izFs1pHLvf3zO7gE3CiSgkwlCaRsrUHu+?=
 =?us-ascii?Q?8Jey9xrj5DC5xJeHMBUF01AlFWBVXW9GcW4+PTmtvzwJbBXBrRqHqChTDAMB?=
 =?us-ascii?Q?3dp1ciG2j6o8rRlViF5DKIKRCHG5iJt3AeTtesC/kavXdHz57NJhBDpgMfnY?=
 =?us-ascii?Q?bY+1mR9QUEOtwpjotO0TYnP3ew5UI62IIL+A45NFD7riVx3lEprtJ6WIAuSF?=
 =?us-ascii?Q?UJ6M9zf275TLqBWkHsDqjtZnOMQGUgfe7om1JNr8Y8cwxMXDLkTEaeBlcgq6?=
 =?us-ascii?Q?MCr3YUdtdquFwuE731vJdHbrWof2cXf+udiPAwl2tFg1LMWBpa4YEMLHM+Iz?=
 =?us-ascii?Q?1EpPnL6HxUykXVcoYIOVYgsFVOnRL/Qh?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS3P286MB0979.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024)(10070799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ShToFt8pJTFqVMb3MpylRp6ZddO3LS6tvTmvHEVuhC9EvITKBwQKOwNAZs81?=
 =?us-ascii?Q?ukDPTOP5/OwJ2EUvXEgOJw7hfadxSM3BdUEVmo8Sw69k62QDm5PiUWqsm4cQ?=
 =?us-ascii?Q?JPeB7tP6e+20EPgvvk/KMrmU0rwAnR7asFFn0zwgpVUJy0I7VYBwmgrho7ee?=
 =?us-ascii?Q?MiMK8byrYTQKb1Hg1+ZgClo/weWmT8Mmrx7XXyXGWqVy/610R8x/xRy7KMDo?=
 =?us-ascii?Q?suDtV5NwXSLp9059F8/S/F1wpk5g/W/C2ReD9fnYNqwp/IKcTbIJ/dmY/n5p?=
 =?us-ascii?Q?dgjWUxw9JsETZTdNJyRMohwOZuMnC8IksnAj/pF2GcHEslRqRjjn8umD/NSE?=
 =?us-ascii?Q?FGTHnmRCG/t0hBdUstjpqahWOI3GtiYWtN8N7v5WX8GAI36XE8tZM7yq8svJ?=
 =?us-ascii?Q?tXGiOgUdvmpICucDfb1Lo608RPgiEZBP6f38MlGMdk11Vnwb70KfQErXwXLY?=
 =?us-ascii?Q?qVj8JpWjQlZuMI3/yPoD3q7T9xk0ErXUI7Jgdctpvu3Nc/8CLenuDzm9nPb6?=
 =?us-ascii?Q?4QcmgcaSw6HnVaSYImy2LK6em1K7XU3LyHkY5j9pM1cWWugI/u9dw5tebUwj?=
 =?us-ascii?Q?rUSFm+yZLUK5qN4zWfduUFzPKMIEeErmuxaSMzLjIwoVLjkLjU6RIH1d7ub8?=
 =?us-ascii?Q?CdBjQ+5BhgMyUh9y/mCZGfvh32zV9tqKV3l5XmLqnbYmyS8HBvumwskKhNlh?=
 =?us-ascii?Q?v2YudR4DX5ds/7Jpl0bWtk7x3U6xeo85TaRP4tUBe+deQFP44InAt9TkB2qO?=
 =?us-ascii?Q?yrizbsDO+K3DnkIf1GTwdAc22x46Gysk8DJIngjaLU2qnK6XZSG0C0JN//2U?=
 =?us-ascii?Q?67t4MNmp2uoUJUjwRaoNN/+Gqf8OVOw9KmXuDJydRuxSAofkcIt1BBP1xveU?=
 =?us-ascii?Q?EsTNJVs1cbauhmTrcXKkDwCrIbgS1a5kpQzfxcse/6MUKEIUTN/AFaA38Jim?=
 =?us-ascii?Q?LaSRt+/9bgUH9KKa39x3ZuwAr/gayJfqTHHNs86Q4K+BaRBmVYg8+844ozHQ?=
 =?us-ascii?Q?wkMRXCX5qXD56mcMI27RHtrlEM2d+GIlewp/RVrlbdGbjAs2H0SiV//ej94w?=
 =?us-ascii?Q?myIKOof8ZiE1ElcHObLy84bMiqpH+ZDK1zcCNrNdsOs5TkxK5aV9HauQN1cL?=
 =?us-ascii?Q?2syxtLtX6URE7uFA/ASH2qMbXBQ60L54IJDYIhAAN9J9RLM8ISlfRWJUbrOS?=
 =?us-ascii?Q?NuJOVOb4fU1ZH5PwdDVhwmquagYIGCrq34LhydpY75V/ouNde6RI3dJxjt/s?=
 =?us-ascii?Q?DFTDcS+Ht99A52JypV3yStkX1gQoW7g3c1o4WHBxuniLr/STStkAi3NxAjc1?=
 =?us-ascii?Q?7+SL1jHshCWCkmYrWfvu5nQmexbkv1R2GdKg2r5zHEVNjS0hEy3dytmaXqUy?=
 =?us-ascii?Q?iVTjdBOdmiJoxpaBs3YY060p1EasrMIf1zQtpfV6UffxyTsIwS1FsJUP4IQm?=
 =?us-ascii?Q?f3FY4jTng1rj7tWceCEOBN0/SlfFLfI2/XsOXYkIGeV9s995PTiBlvDnzWaE?=
 =?us-ascii?Q?LRUriNRP4jEWaNvzJvfYXuEcarpO9FM9HySCSEnBG0O7pyA5c/YrWsXHjUUP?=
 =?us-ascii?Q?ztoAVBCHSRS16y6YaYd3SRIH2ovSRI8aXxM/t1wNR6AQEi6W5BxsKmLSxLHc?=
 =?us-ascii?Q?VvbrTcvdSrcZoNxd2DtEcWI=3D?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: d53fb424-e457-4afb-62dd-08de12048307
X-MS-Exchange-CrossTenant-AuthSource: OS3P286MB0979.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Oct 2025 07:19:32.1965
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YAJ4Jtl9F3hp1SbzCa/a99YYs9HnIC4HW4EkNGEwu0QqrBRTzlj0tEVHXDFEhbQin/AbvaS+uomLvZ1jkmzd7Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS7P286MB7183

The NTB API functions ntb_mw_set_trans() and ntb_mw_get_align() now
support non-zero MW offsets. Update pci-epf-vntb to populate
mws_offset[idx] when the offset parameter is provided. Users can now get
the offset value and use it on ntb_mw_set_trans().

Signed-off-by: Koichiro Den <den@valinux.co.jp>
---
 drivers/pci/endpoint/functions/pci-epf-vntb.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/pci/endpoint/functions/pci-epf-vntb.c b/drivers/pci/endpoint/functions/pci-epf-vntb.c
index becfad483643..6495f99ffd4f 100644
--- a/drivers/pci/endpoint/functions/pci-epf-vntb.c
+++ b/drivers/pci/endpoint/functions/pci-epf-vntb.c
@@ -1413,6 +1413,9 @@ static int vntb_epf_mw_get_align(struct ntb_dev *ndev, int pidx, int idx,
 	if (size_max)
 		*size_max = ntb->mws_size[idx];
 
+	if (offset)
+		*offset = ntb->mws_offset[idx];
+
 	return 0;
 }
 
-- 
2.48.1


