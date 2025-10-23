Return-Path: <dmaengine+bounces-6941-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 71DECBFF849
	for <lists+dmaengine@lfdr.de>; Thu, 23 Oct 2025 09:23:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 4EA253487FA
	for <lists+dmaengine@lfdr.de>; Thu, 23 Oct 2025 07:23:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4221E2EAB78;
	Thu, 23 Oct 2025 07:19:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="veda5yPe"
X-Original-To: dmaengine@vger.kernel.org
Received: from TY3P286CU002.outbound.protection.outlook.com (mail-japaneastazon11010016.outbound.protection.outlook.com [52.101.229.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19A312DFA32;
	Thu, 23 Oct 2025 07:19:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.229.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761203976; cv=fail; b=BKKGGxZGzVDB96lSpAcvkJTCB13IxUOVZ9X1Cdvnbtr++HCORFCga0wkenqiRO0vrNbDe46fAUdBbwCZjrh1nhVWfjbQ6AJZFBw5+hFkxaFwArqO5ryrOa3ETXSMZbrlsbhzj6DxB7JP0Tw0Y70gkF1cJ2184vJXtao/A+RbM6A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761203976; c=relaxed/simple;
	bh=zj0MDBt1Q18cuJqMuhrvdnz1ZW+zdRfvoE/NEVkwimE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=PcuMnbWO9MOsY1RFwLeK0j12PYLsSzvhV+Iz5yKwBZ21HG7GQfwwtGcJQ78iCJqPxQ6NBfnmG2yAmaQz39Xm51U4lrmk+oFctgfWohuM6XuiF+4JB8B6JHjavVwd/LkQQNOcphQkZA92MKaIarEuIJwXjWN/mtvVbP/MtdGkdOY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=veda5yPe; arc=fail smtp.client-ip=52.101.229.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=I5whIAAk/QbFREX4nZNblrwenIt/oYA6+oNogdRLOOJbEuTacm54YvTQCWE4O15n8hfKyk1I2iMzHcS0csdXvgckw9Y93+83w0Qbcc/pCSplYrfB8KB0u/MzwfGwSG16HCx871of+kclvN/CNfQ+1vgFKF2PLCXHqCVVSHbhvUpFze9ChANzGijp5QCE6IMZIIw1GLHJZzdcMEEPHPfhb9lU4aVQITpkA9tx/1LThMsyJoI60lnhLGOBCHzBrwmf9LWROenzE2iZyDHnDcIuiH6O4shSXAHy05tLeP6RGhyXcn7CqmwwPpJDWGEGMywRytJc6LzxjPBchH99jvesLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1DDJ44a4/+kK7QOu8vRtPl6X9aDe7dHhQk+WGycFLuI=;
 b=pNiyH/i5tYQ6LVvbPKbHh0XLwXdTLalGKnJrle02+Zq03zdnEh7CyniLNx3wi64imSxXzPprLlT5yitJP7ZKO66L9YLoHuLqV/LOgpwPZbUY/+2Ww6HNzCJ05dj/JFEFw1KlwsDSto8xrfBPFciemQdJG8GxhXo+c/4I6DdQETWZriabjyxix1tQJkqT7UBjQiBuUl5xq6UeunmjrTi/bADQq0JQMpK3GHAa4QWTmxG3MkNruEb1N7O/znOdxB5P72V9mQbCMHiYHA/ad/+urj7Qo6V0YYF/MRAu93YyeQ0bdkje1YnwiayCWB8uLq8BPHrRwvY6mRmJKW/SvzggZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1DDJ44a4/+kK7QOu8vRtPl6X9aDe7dHhQk+WGycFLuI=;
 b=veda5yPehwjhmKW0d8vYPBUDCz7ygldrEi/6iftD2gWXpeJrtsfAczOoD8heG8oHBklLonFfPmguL1uW3S5c5LlpRpyClhDJpKPMG0Z/+wMaM6Ih0wQeIU8S6lbB2Jz4+eDPE2qImhxN3xFvV15fE/PPsUBaxm4mfhgpGBFaRSw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from OS3P286MB0979.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:10d::7)
 by TY7P286MB5387.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:1f3::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.13; Thu, 23 Oct
 2025 07:19:28 +0000
Received: from OS3P286MB0979.JPNP286.PROD.OUTLOOK.COM
 ([fe80::80f1:db56:4a11:3f7a]) by OS3P286MB0979.JPNP286.PROD.OUTLOOK.COM
 ([fe80::80f1:db56:4a11:3f7a%5]) with mapi id 15.20.9253.011; Thu, 23 Oct 2025
 07:19:28 +0000
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
Subject: [RFC PATCH 05/25] PCI: dwc: ep: Implement EPC inbound mapping support
Date: Thu, 23 Oct 2025 16:18:56 +0900
Message-ID: <20251023071916.901355-6-den@valinux.co.jp>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20251023071916.901355-1-den@valinux.co.jp>
References: <20251023071916.901355-1-den@valinux.co.jp>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCP286CA0246.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:456::12) To OS3P286MB0979.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:604:10d::7)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: OS3P286MB0979:EE_|TY7P286MB5387:EE_
X-MS-Office365-Filtering-Correlation-Id: ffa28bd4-65dc-454a-cbfb-08de120480ce
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|7416014|1800799024|10070799003;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?m2JDeseAahcmrOXOIqc2o4Levk1HKFhMR7R8BJZO0Su5CWHDF8A4FtukMr6q?=
 =?us-ascii?Q?cY3+h/hOdOefBlBu+MLkXelCbbV2tRv2MaSnqAuVZxuLG6HgeystA8KxkWTl?=
 =?us-ascii?Q?ujmQlsA6xrL10oB2wi+5+o7zANZBaiTIMtW8FvVvS2PZIY9UCg1fs7TL4e4v?=
 =?us-ascii?Q?0sI6441AEUpM2SgJkqz5r1TD5gzFi5kn+rYAVlNxA1vj0VB6jpPQ/lliZPlz?=
 =?us-ascii?Q?vrEJ+Jj/i/DWjyrvP3J4lTAWD7uTHKVa5PxCqQBwrLYaVv8uMr4ab/TxG8N1?=
 =?us-ascii?Q?FWquHYYLhVnPd2LCGf733F5qn30Kwg8kxUBZULnRqKMPSA1nIKonzBFLIURN?=
 =?us-ascii?Q?QjeOLR8lffudKEJs/TwDKTboEidnAZjbFc0keuj1F3YiSlsta8nQbOF2Mq01?=
 =?us-ascii?Q?be8tL2BD4g46oDnzT2ovMzK3YVPPcE4lAsVuXV/YTJY2GHCAGO0HbI2792tt?=
 =?us-ascii?Q?82gGm8pbQyynci0mAD6DVbFRwajWdZrt8qzo0T51Z0h00cqg3D9oom6q49uK?=
 =?us-ascii?Q?CqY0aVO0JmBSdDPFk9QtpYOshap+Z9lllbPThWC8ub2MPQH+XbKGDHR8hYUc?=
 =?us-ascii?Q?A0o5kTu4qCZJTXnCLOk3vqlECSzDGZ0fOt0w2KOmdWSIPOj5Xq8WM+wPI1Iy?=
 =?us-ascii?Q?QPaCWjRPAutlnV2euxKbRKpccd7ykLwtDNHTb+zp0HqYCX0u2lotifBBZb0g?=
 =?us-ascii?Q?WiwdnoNyOiVJVEFHOHZjdDI+c5oO6zDuIInvypMkyGnAY0FS6ML9pBmMc6gC?=
 =?us-ascii?Q?I3lCREaxcxYivm6QhOKy+LFKxLHQgUuqZcPgYlQ5wZOF/avpwTeWmU+3PU8U?=
 =?us-ascii?Q?h69x80UezgjDQxf1561yTIXJSTdxLw/azUahW7Mefxp8Z04zC3fvGVCCsDzT?=
 =?us-ascii?Q?uiV1K0pNRCYsOuaB01qJre1dG/TFItrJmerQEtD3ptiafcUisErBJUEMkNxa?=
 =?us-ascii?Q?JI5B51u/iiOhTqFxYjXHcR2JWjWU0gpbl5vcT+i7mTv2FPEsUb0TXrVmpkMa?=
 =?us-ascii?Q?hT0ovFHP5NLFZF2QbTMyB3PTDa03EZeLoXkSnxs7xds0Q648EXKjtVxnMWXm?=
 =?us-ascii?Q?rKx0ldCpnCoj9OSY/7OQlgSqHhF8Fum2h14KjNHFi/5kW+HsicEvaHBckmmH?=
 =?us-ascii?Q?K8+OYpf1zQ6+yjEDHIu7zkBaj1eLjIiJA1N4jhHD6JBCxoyB5O6fA+j4c+tp?=
 =?us-ascii?Q?oZ2cde+sSCNS62BuEBQoa1VQknFRAmcj4x5OxRdm84Eb6UgmJCsB6d/oc3CJ?=
 =?us-ascii?Q?hQo3lIA17TpBFfkeH5LZLB8A4HJzDX4+KRWSJI8B/arnEGZAp6XOJiXmw3Ni?=
 =?us-ascii?Q?TaO9oEiL7ZFmxHC/e07/HsJ8h62glicD0wcwZcwvPYe5ulaiDCTOdhncvfmT?=
 =?us-ascii?Q?NSvOewYonoFLt+fT7S1Vf1ccEqdkKQtqJ+PMbQgv0v5JXMcOe0VSXrp3m/rp?=
 =?us-ascii?Q?Y0BiWtyjasbiz3h2CjUhVnLXI245rOtb?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS3P286MB0979.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024)(10070799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?l/JyiMhH0TpCwlAfQhPMoTQAsP+mbXH+qPVKfoh3Bg9MRd2vlVdYBaqXCEXX?=
 =?us-ascii?Q?FrozHG3aVtNWVARnvHybB1ntjXTyi2W+EbRe+LLdRJZHHiZO84M/lCa23I40?=
 =?us-ascii?Q?4HPwl6HiSQ7e4sl+XfSWsYHc8ofmOg4pSqz18S25ARlq8tm3ox40aI/vOCDn?=
 =?us-ascii?Q?mg2hM7mGlKHtfp2dhFcLrc0CeNHjhxyse2up52G+c8NLjB5xO7GirWj5Obt9?=
 =?us-ascii?Q?Wq2fT6T9fSVlVyj+WSyC14bEdsdt2x++XIafGg5+3xHCNL6fYBL+oAmt0TaY?=
 =?us-ascii?Q?PfTawBfRVTiCNBaVjQrqYciRs5B/tyJlGvE/KyBQInHi+P8G+GGoa0SkOE7o?=
 =?us-ascii?Q?vA7WOXiTO2/hcxFNrbWzcLcNavQFfI4pUTDoMyLbGuwG+FopTe/R7pyAGFDi?=
 =?us-ascii?Q?KRWJAvqiXP1b1WtflVPhASeusQZGAVuTZPizzF5w1vhREfdEqNqmCx/jraQ8?=
 =?us-ascii?Q?Mrb8xKTd1g9WKlhcXffr23dEGYwdR2TXHjWTa2N6gjTC6MsHZfHxhhpOXFQI?=
 =?us-ascii?Q?8m+zyhKLHfMVjWoR4Mqxc+zCyaQHvCGLp2e9axKIF0HLYCX1aL2ucPVu5Qgc?=
 =?us-ascii?Q?3rd71q8fg9O0RxECx5ZbgK0+aTMD5cyGN3/EgY/05QqvdN2Z5iVP8vmNgLzR?=
 =?us-ascii?Q?4bGFbFN7M62Q61azoTaQ0uNDW8ObWDkq840dbShrbZoyQv/uOYiDdjjsCuEb?=
 =?us-ascii?Q?yyKVaVHCUY7H+m+r9vZg1TKVZfj2OGmfYI+Nbnt4b7hXwb0UDbGIOPiOnwbf?=
 =?us-ascii?Q?7Of+QWYTW8MktyuQPycx9IpzIXHmUeKVE6obzDtt+vq4lkMOOcr0vakRda/k?=
 =?us-ascii?Q?Lb406spCgcUfmLOxN/EEvfJOr5WuF9YjGa6BQWf4iG0Gp09TnR3+aZndgxxK?=
 =?us-ascii?Q?mp1SBQ4V6nBZgk0xgFOdmAG8+T5g8qVJOwX42i5qMpY9E9CpXVnykSYo1lVj?=
 =?us-ascii?Q?eilVG+4axkWGvh97IvwiM7YVFXZzrl8w8E6q6pFqdRfTfdENOWbZs9l6uZU9?=
 =?us-ascii?Q?1rrBZOA8h7q7jCtsnp3/sF9VbCpx0fbFrtjzoHS1VfWAdUBNLSQc5CLeKPp4?=
 =?us-ascii?Q?LXv/t/PwtvRRZjQKq//A97WOK+0k7uL/MYd7zBfdbCWvo1Sv5yXsr/PlciGC?=
 =?us-ascii?Q?Y0BKQxhWx+lJLx0KssTQIwfgMH9rDtV+75YikOLzdlAj0RK5F+xuQk2UdwSY?=
 =?us-ascii?Q?UYf6Lmel239hmjH0FvmV8DTwDqlAkwkMdyzuLeDemut1QQUtLIMCS3lQ8mqB?=
 =?us-ascii?Q?e1XGKXvPsOCAe6g/ZWKOdWQWhM/CWYmF3R4wx0n/C7y+ERKcIrbt8SIyVOre?=
 =?us-ascii?Q?UrkaetNA7G5BqjuK4iAR2KVVeWgS5Dfpa1/PcSg7cpYt8ibTX433XE4ISM/L?=
 =?us-ascii?Q?pVxZ1FqqnBAyChpFTFm4Nfi8Prw0MgCDeiMuLAsLsiCy38gFXMD/mPovIOkq?=
 =?us-ascii?Q?5+NQ3+0AtUEYxYtDMidPhrXstrw22Xi/Lg0V9ie4Mw8z3GZu29YqSxGkyqow?=
 =?us-ascii?Q?Uf6viWsc+reA7ZFlSA6C//ev0ZnOq5mvh2xt3d6Ms/OWwdFyvKUYk+14Z5IJ?=
 =?us-ascii?Q?OdV10ZRPzCFyn2OzQ3qoo9cfeXGXQ0a8zsnaj4yvta4V7LT7LTLyAYesWYPw?=
 =?us-ascii?Q?9syWDe2rrHvqhccfEvHuwgM=3D?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: ffa28bd4-65dc-454a-cbfb-08de120480ce
X-MS-Exchange-CrossTenant-AuthSource: OS3P286MB0979.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Oct 2025 07:19:28.4857
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ULVxSROm9IaclEoaZnsP2wl9uP+qr97pXlQxcU8Qfbib9MUFI+rsI1Mij2uDcMRIKefW56Nt4MGHmcFYwBSvNg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY7P286MB5387

Implement map_inbound() and unmap_inbound() for DesignWare endpoint
controllers (Address Match mode). Allows subrange mappings within a BAR,
enabling advanced endpoint functions such as NTB with offset-based
windows.

Signed-off-by: Koichiro Den <den@valinux.co.jp>
---
 .../pci/controller/dwc/pcie-designware-ep.c   | 242 +++++++++++++++---
 drivers/pci/controller/dwc/pcie-designware.h  |   2 +
 2 files changed, 215 insertions(+), 29 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-designware-ep.c b/drivers/pci/controller/dwc/pcie-designware-ep.c
index 0ae54a94809b..d7093958a916 100644
--- a/drivers/pci/controller/dwc/pcie-designware-ep.c
+++ b/drivers/pci/controller/dwc/pcie-designware-ep.c
@@ -8,13 +8,25 @@
 
 #include <linux/align.h>
 #include <linux/bitfield.h>
+#include <linux/list.h>
 #include <linux/of.h>
+#include <linux/pci_regs.h>
 #include <linux/platform_device.h>
+#include <linux/spinlock.h>
 
 #include "pcie-designware.h"
 #include <linux/pci-epc.h>
 #include <linux/pci-epf.h>
 
+struct dw_pcie_ib_map {
+	struct list_head node;
+	enum pci_barno bar;
+	u64 pci_addr;           /* BAR base + offset at map time */
+	phys_addr_t cpu_addr;   /* EP local phys */
+	u64 size;
+	u32 index;              /* iATU inbound window index */
+};
+
 /**
  * dw_pcie_ep_get_func_from_ep - Get the struct dw_pcie_ep_func corresponding to
  *				 the endpoint function
@@ -232,6 +244,7 @@ static void dw_pcie_ep_clear_bar(struct pci_epc *epc, u8 func_no, u8 vfunc_no,
 	struct dw_pcie *pci = to_dw_pcie_from_ep(ep);
 	enum pci_barno bar = epf_bar->barno;
 	u32 atu_index = ep->bar_to_atu[bar] - 1;
+	struct dw_pcie_ib_map *m, *tmp;
 
 	if (!ep->bar_to_atu[bar])
 		return;
@@ -242,6 +255,16 @@ static void dw_pcie_ep_clear_bar(struct pci_epc *epc, u8 func_no, u8 vfunc_no,
 	clear_bit(atu_index, ep->ib_window_map);
 	ep->epf_bar[bar] = NULL;
 	ep->bar_to_atu[bar] = 0;
+
+	guard(spinlock_irqsave)(&ep->ib_map_lock);
+	list_for_each_entry_safe(m, tmp, &ep->ib_map_list, node) {
+		if (m->bar != bar)
+			continue;
+		dw_pcie_disable_atu(pci, PCIE_ATU_REGION_DIR_IB, m->index);
+		clear_bit(m->index, ep->ib_window_map);
+		list_del(&m->node);
+		kfree(m);
+	}
 }
 
 static unsigned int dw_pcie_ep_get_rebar_offset(struct dw_pcie *pci,
@@ -363,14 +386,46 @@ static enum pci_epc_bar_type dw_pcie_ep_get_bar_type(struct dw_pcie_ep *ep,
 	return epc_features->bar[bar].type;
 }
 
+static int dw_pcie_ep_set_bar_init(struct pci_epc *epc, u8 func_no, u8 vfunc_no,
+				   struct pci_epf_bar *epf_bar)
+{
+	struct dw_pcie_ep *ep = epc_get_drvdata(epc);
+	struct dw_pcie *pci = to_dw_pcie_from_ep(ep);
+	enum pci_barno bar = epf_bar->barno;
+	enum pci_epc_bar_type bar_type;
+	int ret;
+
+	bar_type = dw_pcie_ep_get_bar_type(ep, bar);
+	switch (bar_type) {
+	case BAR_FIXED:
+		/*
+		 * There is no need to write a BAR mask for a fixed BAR (except
+		 * to write 1 to the LSB of the BAR mask register, to enable the
+		 * BAR). Write the BAR mask regardless. (The fixed bits in the
+		 * BAR mask register will be read-only anyway.)
+		 */
+		fallthrough;
+	case BAR_PROGRAMMABLE:
+		ret = dw_pcie_ep_set_bar_programmable(ep, func_no, epf_bar);
+		break;
+	case BAR_RESIZABLE:
+		ret = dw_pcie_ep_set_bar_resizable(ep, func_no, epf_bar);
+		break;
+	default:
+		ret = -EINVAL;
+		dev_err(pci->dev, "Invalid BAR type\n");
+		break;
+	}
+
+	return ret;
+}
+
 static int dw_pcie_ep_set_bar(struct pci_epc *epc, u8 func_no, u8 vfunc_no,
 			      struct pci_epf_bar *epf_bar)
 {
 	struct dw_pcie_ep *ep = epc_get_drvdata(epc);
-	struct dw_pcie *pci = to_dw_pcie_from_ep(ep);
 	enum pci_barno bar = epf_bar->barno;
 	size_t size = epf_bar->size;
-	enum pci_epc_bar_type bar_type;
 	int flags = epf_bar->flags;
 	int ret, type;
 
@@ -401,35 +456,12 @@ static int dw_pcie_ep_set_bar(struct pci_epc *epc, u8 func_no, u8 vfunc_no,
 		 * When dynamically changing a BAR, skip writing the BAR reg, as
 		 * that would clear the BAR's PCI address assigned by the host.
 		 */
-		goto config_atu;
-	}
-
-	bar_type = dw_pcie_ep_get_bar_type(ep, bar);
-	switch (bar_type) {
-	case BAR_FIXED:
-		/*
-		 * There is no need to write a BAR mask for a fixed BAR (except
-		 * to write 1 to the LSB of the BAR mask register, to enable the
-		 * BAR). Write the BAR mask regardless. (The fixed bits in the
-		 * BAR mask register will be read-only anyway.)
-		 */
-		fallthrough;
-	case BAR_PROGRAMMABLE:
-		ret = dw_pcie_ep_set_bar_programmable(ep, func_no, epf_bar);
-		break;
-	case BAR_RESIZABLE:
-		ret = dw_pcie_ep_set_bar_resizable(ep, func_no, epf_bar);
-		break;
-	default:
-		ret = -EINVAL;
-		dev_err(pci->dev, "Invalid BAR type\n");
-		break;
+	} else {
+		ret = dw_pcie_ep_set_bar_init(epc, func_no, vfunc_no, epf_bar);
+		if (ret)
+			return ret;
 	}
 
-	if (ret)
-		return ret;
-
-config_atu:
 	if (!(flags & PCI_BASE_ADDRESS_SPACE))
 		type = PCIE_ATU_TYPE_MEM;
 	else
@@ -515,6 +547,154 @@ static int dw_pcie_ep_map_addr(struct pci_epc *epc, u8 func_no, u8 vfunc_no,
 	return 0;
 }
 
+static inline u64 dw_pcie_ep_read_bar_assigned(struct dw_pcie_ep *ep, u8 func_no,
+					       enum pci_barno bar, bool is_io,
+					       bool is_64)
+{
+	u32 reg = PCI_BASE_ADDRESS_0 + 4 * bar;
+	u32 lo, hi = 0;
+	u64 base;
+
+	lo = dw_pcie_ep_readl_dbi(ep, func_no, reg);
+	if (is_io)
+		base = lo & PCI_BASE_ADDRESS_IO_MASK;
+	else {
+		base = lo & PCI_BASE_ADDRESS_MEM_MASK;
+		if (is_64) {
+			hi = dw_pcie_ep_readl_dbi(ep, func_no, reg + 4);
+			base |= ((u64)hi) << 32;
+		}
+	}
+	return base;
+}
+
+static int dw_pcie_ep_map_inbound(struct pci_epc *epc, u8 func_no, u8 vfunc_no,
+				  struct pci_epf_bar *epf_bar, u64 offset)
+{
+	struct dw_pcie_ep *ep = epc_get_drvdata(epc);
+	struct dw_pcie *pci = to_dw_pcie_from_ep(ep);
+	enum pci_barno bar = epf_bar->barno;
+	size_t size = epf_bar->size;
+	int flags = epf_bar->flags;
+	struct dw_pcie_ib_map *m;
+	u64 base, pci_addr;
+	int ret, type, win;
+
+	/*
+	 * DWC does not allow BAR pairs to overlap, e.g. you cannot combine BARs
+	 * 1 and 2 to form a 64-bit BAR.
+	 */
+	if ((flags & PCI_BASE_ADDRESS_MEM_TYPE_64) && (bar & 1))
+		return -EINVAL;
+
+	/*
+	 * Certain EPF drivers dynamically change the physical address of a BAR
+	 * (i.e. they call set_bar() twice, without ever calling clear_bar(), as
+	 * calling clear_bar() would clear the BAR's PCI address assigned by the
+	 * host).
+	 */
+	if (ep->epf_bar[bar]) {
+		/*
+		 * We can only dynamically add a whole or partial mapping if the
+		 * BAR flags do not differ from the existing configuration.
+		 */
+		if (ep->epf_bar[bar]->barno != bar ||
+		    ep->epf_bar[bar]->flags != flags)
+			return -EINVAL;
+
+		/*
+		 * When dynamically changing a BAR, skip writing the BAR reg, as
+		 * that would clear the BAR's PCI address assigned by the host.
+		 */
+	} else {
+		ret = dw_pcie_ep_set_bar_init(epc, func_no, vfunc_no, epf_bar);
+		if (ret)
+			return ret;
+	}
+
+	ep->epf_bar[bar] = epf_bar;
+
+	/*
+	 * Skip programming the inbound translation if phys_addr is 0.
+	 * In this case, the caller only intends to initialize the BAR.
+	 */
+	if (!epf_bar->phys_addr)
+		return 0;
+
+	base = dw_pcie_ep_read_bar_assigned(ep, func_no, bar,
+					    flags & PCI_BASE_ADDRESS_SPACE,
+					    flags & PCI_BASE_ADDRESS_MEM_TYPE_64);
+	if (!(flags & PCI_BASE_ADDRESS_SPACE))
+		type = PCIE_ATU_TYPE_MEM;
+	else
+		type = PCIE_ATU_TYPE_IO;
+	pci_addr = base + offset;
+
+	/* Allocate an inbound iATU window */
+	win = find_first_zero_bit(ep->ib_window_map, pci->num_ib_windows);
+	if (win >= pci->num_ib_windows)
+		return -ENOSPC;
+
+	/* Program address-match inbound iATU */
+	ret = dw_pcie_prog_inbound_atu(pci, win, type,
+				       epf_bar->phys_addr - pci->parent_bus_offset,
+				       pci_addr, size);
+	if (ret)
+		return ret;
+
+	m = kzalloc(sizeof(*m), GFP_KERNEL);
+	if (!m) {
+		dw_pcie_disable_atu(pci, PCIE_ATU_REGION_DIR_IB, win);
+		return -ENOMEM;
+	}
+	m->bar = bar;
+	m->pci_addr = pci_addr;
+	m->cpu_addr = epf_bar->phys_addr;
+	m->size = size;
+	m->index = win;
+
+	guard(spinlock_irqsave)(&ep->ib_map_lock);
+	set_bit(win, ep->ib_window_map);
+	list_add(&m->node, &ep->ib_map_list);
+
+	return 0;
+}
+
+static void dw_pcie_ep_unmap_inbound(struct pci_epc *epc, u8 func_no, u8 vfunc_no,
+				     struct pci_epf_bar *epf_bar, u64 offset)
+{
+	struct dw_pcie_ep *ep = epc_get_drvdata(epc);
+	struct dw_pcie *pci = to_dw_pcie_from_ep(ep);
+	enum pci_barno bar = epf_bar->barno;
+	struct dw_pcie_ib_map *m, *tmp;
+	size_t size = epf_bar->size;
+	int flags = epf_bar->flags;
+	u64 match_pci = 0;
+	u64 base;
+
+	/* If BAR base isn't assigned, there can't be any programmed sub-window */
+	base = dw_pcie_ep_read_bar_assigned(ep, func_no, bar,
+					    flags & PCI_BASE_ADDRESS_SPACE,
+					    flags & PCI_BASE_ADDRESS_MEM_TYPE_64);
+	if (base)
+		match_pci = base + offset;
+
+	guard(spinlock_irqsave)(&ep->ib_map_lock);
+	list_for_each_entry_safe(m, tmp, &ep->ib_map_list, node) {
+		if (m->bar != bar)
+			continue;
+		if (match_pci && m->pci_addr != match_pci)
+			continue;
+		if (size && m->size != size)
+			/* Partial unmap is unsupported for now */
+			continue;
+		dw_pcie_disable_atu(pci, PCIE_ATU_REGION_DIR_IB, m->index);
+		clear_bit(m->index, ep->ib_window_map);
+		list_del(&m->node);
+		kfree(m);
+	}
+}
+
 static int dw_pcie_ep_get_msi(struct pci_epc *epc, u8 func_no, u8 vfunc_no)
 {
 	struct dw_pcie_ep *ep = epc_get_drvdata(epc);
@@ -657,6 +837,8 @@ static const struct pci_epc_ops epc_ops = {
 	.align_addr		= dw_pcie_ep_align_addr,
 	.map_addr		= dw_pcie_ep_map_addr,
 	.unmap_addr		= dw_pcie_ep_unmap_addr,
+	.map_inbound		= dw_pcie_ep_map_inbound,
+	.unmap_inbound		= dw_pcie_ep_unmap_inbound,
 	.set_msi		= dw_pcie_ep_set_msi,
 	.get_msi		= dw_pcie_ep_get_msi,
 	.set_msix		= dw_pcie_ep_set_msix,
@@ -1113,6 +1295,8 @@ int dw_pcie_ep_init(struct dw_pcie_ep *ep)
 	struct device *dev = pci->dev;
 
 	INIT_LIST_HEAD(&ep->func_list);
+	INIT_LIST_HEAD(&ep->ib_map_list);
+	spin_lock_init(&ep->ib_map_lock);
 
 	epc = devm_pci_epc_create(dev, &epc_ops);
 	if (IS_ERR(epc)) {
diff --git a/drivers/pci/controller/dwc/pcie-designware.h b/drivers/pci/controller/dwc/pcie-designware.h
index 00f52d472dcd..455170e53d7e 100644
--- a/drivers/pci/controller/dwc/pcie-designware.h
+++ b/drivers/pci/controller/dwc/pcie-designware.h
@@ -462,6 +462,8 @@ struct dw_pcie_ep {
 	phys_addr_t		*outbound_addr;
 	unsigned long		*ib_window_map;
 	unsigned long		*ob_window_map;
+	struct list_head	ib_map_list;
+	spinlock_t		ib_map_lock;
 	void __iomem		*msi_mem;
 	phys_addr_t		msi_mem_phys;
 	struct pci_epf_bar	*epf_bar[PCI_STD_NUM_BARS];
-- 
2.48.1


