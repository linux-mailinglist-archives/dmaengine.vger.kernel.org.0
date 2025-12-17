Return-Path: <dmaengine+bounces-7767-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A7AE0CC8758
	for <lists+dmaengine@lfdr.de>; Wed, 17 Dec 2025 16:32:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 73FC831732EF
	for <lists+dmaengine@lfdr.de>; Wed, 17 Dec 2025 15:20:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F31D334E75A;
	Wed, 17 Dec 2025 15:16:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="jQ4YC731"
X-Original-To: dmaengine@vger.kernel.org
Received: from OS0P286CU010.outbound.protection.outlook.com (mail-japanwestazon11011052.outbound.protection.outlook.com [40.107.74.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E675B34D4F1;
	Wed, 17 Dec 2025 15:16:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.74.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765984601; cv=fail; b=ibc6HzLaYLsWhNK6Uq0DzkL2IC2zS5A1BVhhL+c+y8K1EkJSnH3q5U4rm7Xo5ivVIIYDClZ1mzckuBMVXxI5rY/x/Vu/yqA39etFE/PzbsJdZZhyoMYA46wa5WQtZweHXFDoPjbH+u3NyRQEqCOD7PSRil5jpvE0f/ik3DCw724=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765984601; c=relaxed/simple;
	bh=5zqyBJOpEKSXnGAGV2M8EAE84LUa4/L6yLnivtqfkCc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=kU+ohEH1o5TL4ASQY9L1vO5rqFTCEzLllvAHxiUdytVVRdGbQyYFPRQ/hY6wR/OfQCLxeVc/Vd+JCbYO3921CxX7S6xQc31KgTHXhOPJ3i0U8uPfu7CML3nycISBTPbNGuQK7X2tDjgNPnCdsTCHDxOk2NcuAfkSLiDzgE/hCqo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=jQ4YC731; arc=fail smtp.client-ip=40.107.74.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Dt6W/q1T90F9ncxsskAp1q74JgmwRTKmdO8GYVRfVKlEbHYgJOKLF356aiv1DHgcIuW6lhOYnYiv21u9/D4qROiBgNW51/GCOSW9sxSWkRJEPMtsgVJvB9cyW0ggqKm7eaGStaloJ9Pw/wt+qnvyIinl0quSUht4XPzPIbtnu9vHlp47zclI765lC9pw4f0Xo6JRhc/z1KFErWSi0A8vT7TrAYFLt6RZq4NGi5CPRXOcfSVuCN5cU0PPIO5zrVbVVUfpYbtL47xg6J2wFnXgxDeNa546V5TolIiAsPyopJ91ygCeceqPxUfhUYzDFW0oGovq3oM9jsyKj+FDifgPAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bLzUNjy/oXeER3ILFYYjuUL7EuoIyktAk5SU4q8+TmI=;
 b=abI2IsBsN9/1z03XOFUHBImZn7L1tiVigT42/4/JfQITlwgrvG9fpai6z4Z8sTCMvEdTsu4rk3i5m18SRr13aycYT2tzUz8OvoGPj9n+YuLUO4idg8Fvtox86Mosod/UGck/2D34FKBhedwQdk5RD6jhRWa7mWJP+z8bM/Q3ufEFRTwudaup+BnNG0f6yORHYonwU6rwYqgcxMM0+eEeaJr0Uw+MR04Zhq26Jjj6zLftCDn4ek84RvZBNFAGL2ctcPKyOWTkjOK0yXBjeNS4gGdHDM/xiVgQ4DLsyQycuuHvuzd45TzZv058oMn2OB/M2g/RSMEyAoZIZ/o+2AWc7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bLzUNjy/oXeER3ILFYYjuUL7EuoIyktAk5SU4q8+TmI=;
 b=jQ4YC731qZbJapXsGOPoGGUr0xm+PJYz7l2ufcFXQIDnyMjj/2Zu+t10+yoUoeu6WdyXRkrTUv2i0dZEqzysBsl5XZVaZ7TH/WRIbTERHtZbjUhJkTO7oj0sztsWcGDQVO9IAQBzCzuvjd4JFrwGDCBqRbwnIbPJH40BqXsItKY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TYWP286MB2697.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:24c::11)
 by TYCP286MB2863.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:306::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9434.6; Wed, 17 Dec
 2025 15:16:30 +0000
Received: from TYWP286MB2697.JPNP286.PROD.OUTLOOK.COM
 ([fe80::fb7e:f4ed:a580:9d03]) by TYWP286MB2697.JPNP286.PROD.OUTLOOK.COM
 ([fe80::fb7e:f4ed:a580:9d03%5]) with mapi id 15.20.9434.001; Wed, 17 Dec 2025
 15:16:30 +0000
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
Subject: [RFC PATCH v3 19/35] dmaengine: dw-edma: Poll completion when local IRQ handling is disabled
Date: Thu, 18 Dec 2025 00:15:53 +0900
Message-ID: <20251217151609.3162665-20-den@valinux.co.jp>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251217151609.3162665-1-den@valinux.co.jp>
References: <20251217151609.3162665-1-den@valinux.co.jp>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCP286CA0036.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:29d::20) To TYWP286MB2697.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:24c::11)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYWP286MB2697:EE_|TYCP286MB2863:EE_
X-MS-Office365-Filtering-Correlation-Id: 6d74163c-de22-4c25-c9ac-08de3d7f419b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|10070799003|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?1yQnKvRZzomHKbZLBV87yPo6/Aq/w5KzaDJU11N5iYn9RqgsGAXlwcnChCxK?=
 =?us-ascii?Q?atXSuPuh8L2Df7rSYxOn62EHLZwE+dt0Pf3GBSptFOwUbmItLlpIvztn8uSg?=
 =?us-ascii?Q?rOhgVpgoGaI4P0KW0yXWPedlnVeLPwgdNF4EwWSlSWhSumhu9yUaMYK5LQ1c?=
 =?us-ascii?Q?ntq1VkvbHYOvQxxaol+QSz2n7SH1hagtrb8c56IXhlKIpU0MtGpib+djHuBS?=
 =?us-ascii?Q?+VaAMu+tfyutqWz2oamSyAuugUJraOdGqPSzYkedbC8SYHqgK0buBLlzxAaM?=
 =?us-ascii?Q?IsQpZ0tcUixlwju3cF6imaHr1FXJWftwWopj4SK7PZyt3Ss2jBnOGxoH1/1u?=
 =?us-ascii?Q?ajkUtcWsrNYIfFZ9XXiZV28HBVzOeWc3ef7Ahw02hJrNeKyOaNVU09DZOvyO?=
 =?us-ascii?Q?hHepFeS9+HZEd1oMwQOS4Exbz5W1okYYzhWbS7LRCXc9I9UmyGFY1Nuq/MsK?=
 =?us-ascii?Q?+/6R0CJyWyC8nkZ6VVtr/3hq/BuZtupWiw9DzML08k3i9BZMGWVVCVAt/qCC?=
 =?us-ascii?Q?tRVW2aNz75yaISXueJmARq5w6cMGcpEGajgZw0bgKndamG5NM35k8x791UKi?=
 =?us-ascii?Q?ZRZVuyTXEPPBiv9HODIl4gtrHJfq5WD1K9GSlvg/0gMdan+DwXIFk6L37oLw?=
 =?us-ascii?Q?Q1YhoJo7NCKYsn2XCbvBZUkiL87Ar0bvALBe1Y/BBr+aEsvluWAHQf6xdbuy?=
 =?us-ascii?Q?AelfGU3JXYTdvaJ7VcascvfBWGfa1NndOUNlpqklI2LKM1BCyv7wuBsBmS12?=
 =?us-ascii?Q?yiLfwB9mbjUmMYu/VATufmLt2nK57UBDmTiCD6dZf/tzh75uQJ6VeQV665Fu?=
 =?us-ascii?Q?GH23gU9iwyV1lpJ1iHxU5uosEhR1RPh9kjS8PDtU4Y8K3SnJ0e9/tWxzY1cc?=
 =?us-ascii?Q?08mbwUdDFjJInpUa0k/tAnTf+R4Y6OorvjgVcFpn25p33dW7Gp0rEC/gsqsU?=
 =?us-ascii?Q?EPLRX7SG/o/RobGnipLVajRzClbKUPEcm37rQhv7MBMH7fmqaGBWIEoMAT0s?=
 =?us-ascii?Q?Kk4UzOVGTjhPa5c0GqrMEWsozi9PnNUFBb2Gj1WirmlLH+Y0k2RNnLXIUC5/?=
 =?us-ascii?Q?cgsPmDlqJ0CjdeX2FR5Or3IsyF7QCB/BM4TMXtvg0OHb8Ta4eaSP3q1ua+to?=
 =?us-ascii?Q?GK14GMkHnz1LiZf3yj4dMaq+qgrwnhXqtWUOKWIYL1i5uTztcwMXJFDxn/rw?=
 =?us-ascii?Q?I3j7fcJ7dRg5mtc75wQwra99XFWzkdTYURENHSR+0LKv9iJpt2VfRa9GsDpf?=
 =?us-ascii?Q?KWTK96Un8czgBn+n/iTH8mOt0zBctKvxdcIWD+qCRbs4zqiFhYdOPhCtAagp?=
 =?us-ascii?Q?dlFF048LAy+HKGM/6rwqaHO2L8QtUMTNRNsX5gKTkRLLcXTyfUKSnGeH6jdD?=
 =?us-ascii?Q?JmzRDBWl0Lzaenp9KlQP4j2KpgqIu6XC+EpBkIHNi9boiOBEjxEAmDJETl0v?=
 =?us-ascii?Q?s9oUpQKbtcxtr4ThW+Gn9R1Hqo8q27VE?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYWP286MB2697.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(10070799003)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?U9NFYJCjWNQE2pTI/arGeY8s5DR+oIdo/7JjowRy9s0MTZ1SeCfJDMS88w//?=
 =?us-ascii?Q?fiJoUw2AG0yPJlYipu48J7gYu4fL1hjV05ZafDMOVMsBF1qisSBG37pP4OcP?=
 =?us-ascii?Q?tFP3Vp3kcc/NcbDb09wcHjopi2NX8w5DsIzzofJCOqbjp2lUUPdCmgGbW/KA?=
 =?us-ascii?Q?bBJu0dcDHWe5xNOteozjGHQi0FU2+9JczcKoNSkHo+Kd1vPIGJSgFsoViPn7?=
 =?us-ascii?Q?erL7bfO74QZDueN292Za4UBD0IOuZBWck1+c1vJsZHTtJY+5IuqDAxLa7HAD?=
 =?us-ascii?Q?pSEvUhaRI6QS599qbMahqGIkvKqfMqONmeiam1ofArmwYis95FWPKt0B/U3s?=
 =?us-ascii?Q?WAz61Jr8emtmTRHppmWx4elFBNNtojpUI1C6mACPGxIj1dKxSCpTBeTAH0v4?=
 =?us-ascii?Q?vW2R3YyQz93ZYVU/3bAx9F2oGIhWTPcKrqrp25CeviOuMKxjM9JbTL24tBto?=
 =?us-ascii?Q?IArPanIjy5S/CHZ+L24spH0c/y65lAG5zKBAcOkge2HUo+S7sFwAH/zQDW2n?=
 =?us-ascii?Q?l1crjvfygyGVaCX0P4YNJiUw6/+xKDR4pdMcIHTjGQlg2SI4IIWzfM4/7/Os?=
 =?us-ascii?Q?hJ2Hrpp/7CGeZfn/QxDedrfaoYnbZ0vPPj5oRDXC4gFjUiTUzniJObnTenWI?=
 =?us-ascii?Q?kMUsaDbpVVYFSN8BjF7DhX9kKiwHqr+Cpr3e5EUyB0u5PdRyOS1HQrTDot5F?=
 =?us-ascii?Q?bstHg6Hj0Y5twzh+Vv5xMs/6y2n895gMFBmVk8oJlJw6HsoIiq1xh3mnnNG9?=
 =?us-ascii?Q?0EZGoM0V1f2S0R+wW5ncuIjFVA/Sqt0HGgzy6NHt7stze3GcPss5myomuTYw?=
 =?us-ascii?Q?0UXkYl86baLnOjPIUpTWnMhyBJniBk2r/MDlIBGG/aTW/YKurmd83sQiLkDD?=
 =?us-ascii?Q?SB/KRRzwhlOkYP1NWPMk6cmJDNCAgMsQ7Nwk3NQbpnPe2iFEwalE4pAHSEkR?=
 =?us-ascii?Q?XqQY1MppYjjM0ha29QCOv13iazoANw8DfIsd8VTVfwSkMXskDpwQ/NEFYzHN?=
 =?us-ascii?Q?kbfjuRwqaSyEPzsUdailAbSBlVLQqMKKT0t7GhGPcJ2OHfMaii9fbda8HG30?=
 =?us-ascii?Q?f4JOZ9Gu/3/IrktEuDhotUI5G5Nf07owEFG4bkX2YFh3Fd2ZdPyc5rqIpPdY?=
 =?us-ascii?Q?ZqtKw+Gtt1trelhJICuNuqTXY7pb0D2EVJgGs9xZFcWzQ3/rLIkcuNNyPNcn?=
 =?us-ascii?Q?eOQJKmFrKXejx4xChcx6A3gIzLv9HuM5AK5HlEKcKQbL7//hebDwaxmPOXhZ?=
 =?us-ascii?Q?wvECBC5LAGASt4LNqpvtKkXYCtqPQyqbzstW1Y019vvHxZxVRx9LwS00DX7b?=
 =?us-ascii?Q?juRtNeFiXgVJV6luJ4ZvMCH60hjOZds3fLCK8yoKWnS9wdDssntzy2SCyjxD?=
 =?us-ascii?Q?lzzDRz/vEiJxBbPbVEej1z54j1N7l/0Dd37k2KWiV03g/pfoNrsRKTh3BugX?=
 =?us-ascii?Q?KLQ/emLNYjejhphbwdBBn6MI+hZKwCYCkUOPuzllMJH/tkeiyXsJXHqEDiqb?=
 =?us-ascii?Q?CGj/xWjSUOUpCvIqFrnmJ0a8P5I5fbK8cu9iCUQ5gNeuSsZQ3hHB/HhFI3iY?=
 =?us-ascii?Q?rm9VABr82X580gHcC9j2Ofl+QXrX0gzP/biMl4yBat4napxSRpqz+zW3z5CQ?=
 =?us-ascii?Q?0GsN+wsziVjLC3679VYrUsw=3D?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: 6d74163c-de22-4c25-c9ac-08de3d7f419b
X-MS-Exchange-CrossTenant-AuthSource: TYWP286MB2697.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Dec 2025 15:16:30.4752
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +x7B5+xRqtBusGu5r7rTgBc6gaxBmwECwu9v2b+5DsS8NZnV//+pdv0LVZz0e5uzG9kPAnuLo8JqGW8LVmITkA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCP286MB2863

When a channel is configured to suppress host side interruption (RIE=0),
the host side driver cannot rely on IRQ-driven progress. Add an optional
polling path for such channels. Polling is only enabled for channels where
dw_edma_chan_ignore_irq() is true.

Signed-off-by: Koichiro Den <den@valinux.co.jp>
---
 drivers/dma/dw-edma/dw-edma-core.c | 97 ++++++++++++++++++++++++------
 drivers/dma/dw-edma/dw-edma-core.h |  4 ++
 2 files changed, 84 insertions(+), 17 deletions(-)

diff --git a/drivers/dma/dw-edma/dw-edma-core.c b/drivers/dma/dw-edma/dw-edma-core.c
index 0bceca2d56c5..09b10ad1f38a 100644
--- a/drivers/dma/dw-edma/dw-edma-core.c
+++ b/drivers/dma/dw-edma/dw-edma-core.c
@@ -303,23 +303,6 @@ static int dw_edma_device_terminate_all(struct dma_chan *dchan)
 	return err;
 }
 
-static void dw_edma_device_issue_pending(struct dma_chan *dchan)
-{
-	struct dw_edma_chan *chan = dchan2dw_edma_chan(dchan);
-	unsigned long flags;
-
-	if (!chan->configured)
-		return;
-
-	spin_lock_irqsave(&chan->vc.lock, flags);
-	if (vchan_issue_pending(&chan->vc) && chan->request == EDMA_REQ_NONE &&
-	    chan->status == EDMA_ST_IDLE) {
-		chan->status = EDMA_ST_BUSY;
-		dw_edma_start_transfer(chan);
-	}
-	spin_unlock_irqrestore(&chan->vc.lock, flags);
-}
-
 static enum dma_status
 dw_edma_device_tx_status(struct dma_chan *dchan, dma_cookie_t cookie,
 			 struct dma_tx_state *txstate)
@@ -707,6 +690,68 @@ static irqreturn_t dw_edma_interrupt_common(int irq, void *data)
 	return ret;
 }
 
+static void dw_edma_done_arm(struct dw_edma_chan *chan)
+{
+	if (!dw_edma_chan_ignore_irq(&chan->vc.chan))
+		/* no need to arm since it's not to be ignored */
+		return;
+
+	queue_delayed_work(system_wq, &chan->poll_work, 1);
+}
+
+static void dw_edma_chan_poll_done(struct dma_chan *dchan)
+{
+	struct dw_edma_chan *chan = dchan2dw_edma_chan(dchan);
+	enum dma_status st;
+
+	if (!dw_edma_chan_ignore_irq(dchan))
+		/* no need to poll since it's not to be ignored */
+		return;
+
+	guard(spinlock_irqsave)(&chan->poll_lock);
+
+	if (chan->status != EDMA_ST_BUSY)
+		return;
+
+	st = dw_edma_core_ch_status(chan);
+
+	switch (st) {
+	case DMA_COMPLETE:
+		dw_edma_done_interrupt(chan);
+		if (chan->status == EDMA_ST_BUSY)
+			dw_edma_done_arm(chan);
+		break;
+	case DMA_IN_PROGRESS:
+		dw_edma_done_arm(chan);
+		break;
+	case DMA_ERROR:
+		dw_edma_abort_interrupt(chan);
+		break;
+	default:
+		break;
+	}
+}
+
+static void dw_edma_device_issue_pending(struct dma_chan *dchan)
+{
+	struct dw_edma_chan *chan = dchan2dw_edma_chan(dchan);
+	unsigned long flags;
+
+	if (!chan->configured)
+		return;
+
+	dw_edma_chan_poll_done(dchan);
+
+	spin_lock_irqsave(&chan->vc.lock, flags);
+	if (vchan_issue_pending(&chan->vc) && chan->request == EDMA_REQ_NONE &&
+	    chan->status == EDMA_ST_IDLE) {
+		chan->status = EDMA_ST_BUSY;
+		dw_edma_start_transfer(chan);
+	} else
+		dw_edma_done_arm(chan);
+	spin_unlock_irqrestore(&chan->vc.lock, flags);
+}
+
 static int dw_edma_alloc_chan_resources(struct dma_chan *dchan)
 {
 	struct dw_edma_chan *chan = dchan2dw_edma_chan(dchan);
@@ -1060,6 +1105,19 @@ int dw_edma_remove(struct dw_edma_chip *chip)
 }
 EXPORT_SYMBOL_GPL(dw_edma_remove);
 
+static void dw_edma_poll_work(struct work_struct *work)
+{
+	struct delayed_work *dwork = to_delayed_work(work);
+	struct dw_edma_chan *chan =
+		container_of(dwork, struct dw_edma_chan, poll_work);
+	struct dma_chan *dchan = &chan->vc.chan;
+
+	if (!chan->configured)
+		return;
+
+	dw_edma_chan_poll_done(dchan);
+}
+
 int dw_edma_chan_irq_config(struct dma_chan *dchan,
 			    enum dw_edma_ch_irq_mode mode)
 {
@@ -1083,6 +1141,11 @@ int dw_edma_chan_irq_config(struct dma_chan *dchan,
 		 str_write_read(chan->dir == EDMA_DIR_WRITE),
 		 chan->id, mode);
 
+	if (dw_edma_chan_ignore_irq(&chan->vc.chan)) {
+		spin_lock_init(&chan->poll_lock);
+		INIT_DELAYED_WORK(&chan->poll_work, dw_edma_poll_work);
+	}
+
 	return 0;
 }
 EXPORT_SYMBOL_GPL(dw_edma_chan_irq_config);
diff --git a/drivers/dma/dw-edma/dw-edma-core.h b/drivers/dma/dw-edma/dw-edma-core.h
index 8458d676551a..11fe4532f0bf 100644
--- a/drivers/dma/dw-edma/dw-edma-core.h
+++ b/drivers/dma/dw-edma/dw-edma-core.h
@@ -11,6 +11,7 @@
 
 #include <linux/msi.h>
 #include <linux/dma/edma.h>
+#include <linux/workqueue.h>
 
 #include "../virt-dma.h"
 
@@ -83,6 +84,9 @@ struct dw_edma_chan {
 
 	enum dw_edma_ch_irq_mode	irq_mode;
 
+	struct delayed_work		poll_work;
+	spinlock_t			poll_lock;
+
 	enum dw_edma_request		request;
 	enum dw_edma_status		status;
 	u8				configured;
-- 
2.51.0


