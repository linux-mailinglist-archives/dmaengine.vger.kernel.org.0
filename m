Return-Path: <dmaengine+bounces-6394-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A199B45451
	for <lists+dmaengine@lfdr.de>; Fri,  5 Sep 2025 12:17:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 578CF584C3A
	for <lists+dmaengine@lfdr.de>; Fri,  5 Sep 2025 10:17:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5847A2D542B;
	Fri,  5 Sep 2025 10:17:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="keSpYex2"
X-Original-To: dmaengine@vger.kernel.org
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2051.outbound.protection.outlook.com [40.107.96.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47AD42D5C76;
	Fri,  5 Sep 2025 10:17:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.96.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757067436; cv=fail; b=FAiaL9PpflWlrgXYxhQorr6xUXuZ2LJEsO1Z9EhfTQIy83RbgqJfg1Ff+S3bH6EdnqSFOSJ4jzq/SRseHFJvGnvYuS1JYhX3E+zPU8P1W1XceRG839HxM3lMslxdI0XuzB5fcdV3NuHFtJTccOvJlXxfmtg3Ysbj6fvZu0hBrnk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757067436; c=relaxed/simple;
	bh=wWD+mnRV6mCK+dcuqaiPHeA9ISGamCu3I1trsibU49s=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=e0jUWflYREVKo6Zm7DT4UX2fi9pYIvXBrFhVZCpVztQysR93TQvNN+QLNkPLII2EjFLFXp+LVQ67Mzm6byEd45zGlUNGptwWntwbifZjasZvsoAeDKK0J9ZSLTs3e2dWT9gRsPcNVoPQ9bEMH3BKrBWGGe0diXhSZbf2NK1FJdw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=keSpYex2; arc=fail smtp.client-ip=40.107.96.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jIsBwVs6iwQrvo6Wuzq0Wy8Isn824Tcz+gJ/SbnqllPH2TnBhTBZnz8adyBTZgykMmIEf0Q0GgHnwJCaVKHhkQCEQf09aRgKiMfhlnRmmyCQp8mPgXmg0Kj03Qd08EiWw05JVvEaraQlHMiYmytM5f+2XPFQbHBNYVo58y9vCo5129vKeu+g+Y3Vw8FWFlAvgQv8r7hQpbgWYWpro++Myw2THhlh2fXB5oUnbPd1VMp2LBegi8fzMqInEKk0hyGpQ9ZfM3nhZOY03sizSleiYaV6e9EaCRDyU1//0DRa0Iy7K+JWR9EOuHvdBGAAOjOm5b4NfZekWNIVF50i1CoqNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mTxcuQTZa2pfIUImq8GnsmsgUJbHX0hjUyjdSGih3jI=;
 b=poZzFD0iacNkKjzlt6Hb7OnmXZ55gGNyoLmnZLQKShqrqhjeZ0prgQLtSJ7FTh9k8CRtr1uSqXNUQSeLZsZA4cEUD2+UXEkkn/DXf09fKU8J1G8HObirQDOZCjo8vO4HSvqwnyxZPBO7oSds5A2CoBuYlL3+OXDmSq+ZYlkHIgaW/caVR98ZUzBhFOVRw0mVHAGakPJniYpmSlDhFUwmMltS8tOULawBe7e26qNV6rqHH4h4/cTEUKxDbdvolI4lj46kmrvan1zJLc69m1e7GWMxtRWJTQCEUxtyIV2CAN1yn/csZnJIbeOeKWbee1JWHRuQAjZhX9ouOCEkZfpLCw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=google.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mTxcuQTZa2pfIUImq8GnsmsgUJbHX0hjUyjdSGih3jI=;
 b=keSpYex23YpoTDL0veAsFD4Yg6VOoyHdKXePsdhBNF+TNL90ytQoSHlWa9EMdH1UZNkN9iPxW6DLkD28bB/2EPUDE4JPs9A+zfZls4t56AGxzSsNcAmUgsdjZ1q80Dhs39OEwDPWyZcGqgKHAVOzJ11cn6+Tfswxijj60fcJ/kw=
Received: from MW4PR03CA0334.namprd03.prod.outlook.com (2603:10b6:303:dc::9)
 by MW4PR12MB6706.namprd12.prod.outlook.com (2603:10b6:303:1e2::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.16; Fri, 5 Sep
 2025 10:17:08 +0000
Received: from CY4PEPF0000E9D7.namprd05.prod.outlook.com
 (2603:10b6:303:dc:cafe::6c) by MW4PR03CA0334.outlook.office365.com
 (2603:10b6:303:dc::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9094.18 via Frontend Transport; Fri,
 5 Sep 2025 10:16:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CY4PEPF0000E9D7.mail.protection.outlook.com (10.167.241.70) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9094.14 via Frontend Transport; Fri, 5 Sep 2025 10:17:08 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 5 Sep
 2025 05:17:07 -0500
Received: from xhdapps-pcie2.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Fri, 5 Sep 2025 05:17:05 -0500
From: Devendra K Verma <devendra.verma@amd.com>
To: <bhelgaas@google.com>, <mani@kernel.org>, <vkoul@kernel.org>
CC: <dmaengine@vger.kernel.org>, <linux-pci@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <michal.simek@amd.com>
Subject: [PATCH 2/2] dmaengine: dw-edma: Add non-LL mode
Date: Fri, 5 Sep 2025 15:46:59 +0530
Message-ID: <20250905101659.95700-3-devendra.verma@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250905101659.95700-1-devendra.verma@amd.com>
References: <20250905101659.95700-1-devendra.verma@amd.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB03.amd.com: devendra.verma@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D7:EE_|MW4PR12MB6706:EE_
X-MS-Office365-Filtering-Correlation-Id: f51d3bc5-db34-4779-ae8e-08ddec655eca
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|36860700013|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?aI8MmjegsmrpKuvHHIwxpInrCXQgBacmHOqn53PKaY5XHGpNOXdO1XTiy1RN?=
 =?us-ascii?Q?WuxDHSdGT/1/1d3mfMO27WRNCkrxZhjh+H9Qwmh51y0J2hQGfkxo+edQAsXV?=
 =?us-ascii?Q?m+iiVQwrkkfHTX6NAZVt24Okl/2J5cUgLNwcTgIe2sIEubcUsN3CpSzJMP2O?=
 =?us-ascii?Q?AtX7gW/yZJ17XLlZh8dMRgnKC/GnCQQWNx2julCzsmh+Z30xWElUA2VavFtR?=
 =?us-ascii?Q?t8hVNh4ak+2Xtwim8mQ6/ugYXkGzQ7CKRYx3FGMypQhJQKvjcSaixD/0tMUm?=
 =?us-ascii?Q?mc3Z5LAY/SjqDFVsChsGRkIxakY1MhrD7fxVrva9IDoyBi9LuUUtm/KM7CUQ?=
 =?us-ascii?Q?f5TYRJlL5iVskTvgYjcuRmVoeephJkymqrZGMi2rh/4lnpf2A9081bIGrYgX?=
 =?us-ascii?Q?6xv8j8/e4dmx42AiVb8bzUQJnys45Zd9TnJB+0cEiLUhHxRolUA5GT+3+hq4?=
 =?us-ascii?Q?yWCBWGynnBsTZCTh6WrEGeGUVmyUE/7CZToXjBfdLukgpIfaY3m3gKP9hSa4?=
 =?us-ascii?Q?swoh4n1mUGNuClJpao6CFlA13cXzxfaJUE7/DmDgliAemhlEWaqgpT0ouquP?=
 =?us-ascii?Q?WukE3T+LpNOIoPjrjdzKpVDPG6rjjOKfi2FZFmGHoM5c8NFVJ+fZWVIbLnYq?=
 =?us-ascii?Q?EXDFqQxLgtRI9+drqoM1lsHrXRE0/AWYTk1F9yZ6tsOO7IpF5v6Axk1zlNSl?=
 =?us-ascii?Q?TiG7LkDN0qWD3rXZtZ8Q97qslC7Eqy/3Gi7sb7f6Je3knme7Rx/rzKivY557?=
 =?us-ascii?Q?TtG1wWgDv9MNDlcCHn6aDR+rkpOHWZ86NAJZaDavBL8GGuAA9f343aW6CovF?=
 =?us-ascii?Q?mG6JClrlutFjIT7+MWSIqnaMzD7GDKXJbfAHQ2hwlACZi5KacmVvejL6iKj/?=
 =?us-ascii?Q?z2nETUC+Vy1Yj9w7Wl0sktEjdBmIye/bvoiSGKwQWosXfehlaDohO3KSWc3G?=
 =?us-ascii?Q?ywN3OItJwY0GHeI8etV5mItrqw9XlhSB9CrEutkzibXnTEqx18Nxw2thEQSz?=
 =?us-ascii?Q?54PoceondG9I0nd9cdVfnjCm/yCN6TiawZ74yKmCTIW/5VrpSxld5M2kqAJU?=
 =?us-ascii?Q?xm7zeOoyuTQ2qmSK4cw3fTEPowQsgBsx5luyYFld/EVIqNnDy9dRMntcmiun?=
 =?us-ascii?Q?Zhk8LGuW1xMte4XIKuizTTKmjL3Pm8SOUK7TD+7nw6zWkfaJVZOoJVGS1BVY?=
 =?us-ascii?Q?qrGeymwMEml27GqnsmNPnLqU9Zvz3TxFHrmmYKGdivsDMyKgdWk1oinjUe0G?=
 =?us-ascii?Q?roOOZehtncp6nnS6quRUkYjNZvRL1Kq3z9pbv8l9DylTwCcBasWKJc57Wksy?=
 =?us-ascii?Q?C7+vmODr2PTMekFA9TlRI9hsHF9/Gi5jfI6jA45TPgpIEtqLZO8xJVr5OE3n?=
 =?us-ascii?Q?mBBLowX4DrSgT37LVcoVPJwgI7FYL/QTHK387fwkALRx4CYWZNyRtLcGuh0i?=
 =?us-ascii?Q?GTZGmcalJbnWtMUF8OZQjYzUpml6c9d8aCu7ez/oHwGjn2IKpgdXBV/iS57c?=
 =?us-ascii?Q?vlwQugB7NLBawK26/EWzpUG+1VvghNQnzKu1?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(36860700013)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Sep 2025 10:17:08.1769
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f51d3bc5-db34-4779-ae8e-08ddec655eca
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000E9D7.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6706

AMD MDB IP supports Linked List (LL) mode as well as non-LL mode.
The current code does not have the mechanisms to enable the
DMA transactions using the non-LL mode. The following two cases
are added with this patch:
- When a valid physical base address is not configured via the
  Xilinx VSEC capability then the IP can still be used in non-LL
  mode. The default mode for all the DMA transactions and for all
  the DMA channels then is non-LL mode.
- When a valid physical base address is configured but the client
  wants to use the non-LL mode for DMA transactions then also the
  flexibility is provided via the peripheral_config struct member of
  dma_slave_config. In this case the channels can be individually
  configured in non-LL mode. This use case is desirable for single
  DMA transfer of a chunk, this saves the effort of preparing the
  Link List.

Signed-off-by: Devendra K Verma <devendra.verma@amd.com>
---
 drivers/dma/dw-edma/dw-edma-core.c    | 38 ++++++++++++++++++---
 drivers/dma/dw-edma/dw-edma-core.h    |  1 +
 drivers/dma/dw-edma/dw-edma-pcie.c    | 33 ++++++++++++++-----
 drivers/dma/dw-edma/dw-hdma-v0-core.c | 62 ++++++++++++++++++++++++++++++++++-
 include/linux/dma/edma.h              |  1 +
 5 files changed, 121 insertions(+), 14 deletions(-)

diff --git a/drivers/dma/dw-edma/dw-edma-core.c b/drivers/dma/dw-edma/dw-edma-core.c
index b43255f..dbef571 100644
--- a/drivers/dma/dw-edma/dw-edma-core.c
+++ b/drivers/dma/dw-edma/dw-edma-core.c
@@ -223,8 +223,28 @@ static int dw_edma_device_config(struct dma_chan *dchan,
 				 struct dma_slave_config *config)
 {
 	struct dw_edma_chan *chan = dchan2dw_edma_chan(dchan);
+	int nollp = 0;
+
+	if (WARN_ON(config->peripheral_config &&
+		    config->peripheral_size != sizeof(int)))
+		return -EINVAL;
 
 	memcpy(&chan->config, config, sizeof(*config));
+
+	/*
+	 * When there is no valid LLP base address available
+	 * then the default DMA ops will use the non-LL mode.
+	 * Cases where LL mode is enabled and client wants
+	 * to use the non-LL mode then also client can do
+	 * so via the providing the peripheral_config param.
+	 */
+	if (config->peripheral_config)
+		nollp = *(int *)config->peripheral_config;
+
+	chan->nollp = false;
+	if (chan->dw->chip->nollp || (!chan->dw->chip->nollp && nollp))
+		chan->nollp = true;
+
 	chan->configured = true;
 
 	return 0;
@@ -353,7 +373,7 @@ static void dw_edma_device_issue_pending(struct dma_chan *dchan)
 	struct dw_edma_chan *chan = dchan2dw_edma_chan(xfer->dchan);
 	enum dma_transfer_direction dir = xfer->direction;
 	struct scatterlist *sg = NULL;
-	struct dw_edma_chunk *chunk;
+	struct dw_edma_chunk *chunk = NULL;
 	struct dw_edma_burst *burst;
 	struct dw_edma_desc *desc;
 	u64 src_addr, dst_addr;
@@ -419,9 +439,11 @@ static void dw_edma_device_issue_pending(struct dma_chan *dchan)
 	if (unlikely(!desc))
 		goto err_alloc;
 
-	chunk = dw_edma_alloc_chunk(desc);
-	if (unlikely(!chunk))
-		goto err_alloc;
+	if (!chan->nollp) {
+		chunk = dw_edma_alloc_chunk(desc);
+		if (unlikely(!chunk))
+			goto err_alloc;
+	}
 
 	if (xfer->type == EDMA_XFER_INTERLEAVED) {
 		src_addr = xfer->xfer.il->src_start;
@@ -450,7 +472,13 @@ static void dw_edma_device_issue_pending(struct dma_chan *dchan)
 		if (xfer->type == EDMA_XFER_SCATTER_GATHER && !sg)
 			break;
 
-		if (chunk->bursts_alloc == chan->ll_max) {
+		/*
+		 * For non-LL mode, only a single burst can be handled
+		 * in a single chunk unlike LL mode where multiple bursts
+		 * can be configured in a single chunk.
+		 */
+		if ((chunk && chunk->bursts_alloc == chan->ll_max) ||
+		    chan->nollp) {
 			chunk = dw_edma_alloc_chunk(desc);
 			if (unlikely(!chunk))
 				goto err_alloc;
diff --git a/drivers/dma/dw-edma/dw-edma-core.h b/drivers/dma/dw-edma/dw-edma-core.h
index 71894b9..2a4ad45 100644
--- a/drivers/dma/dw-edma/dw-edma-core.h
+++ b/drivers/dma/dw-edma/dw-edma-core.h
@@ -86,6 +86,7 @@ struct dw_edma_chan {
 	u8				configured;
 
 	struct dma_slave_config		config;
+	bool				nollp;
 };
 
 struct dw_edma_irq {
diff --git a/drivers/dma/dw-edma/dw-edma-pcie.c b/drivers/dma/dw-edma/dw-edma-pcie.c
index 749067b..0d6254f 100644
--- a/drivers/dma/dw-edma/dw-edma-pcie.c
+++ b/drivers/dma/dw-edma/dw-edma-pcie.c
@@ -224,6 +224,15 @@ static void dw_edma_pcie_get_vsec_dma_data(struct pci_dev *pdev,
 	pdata->phys_addr = off;
 }
 
+static u64 dw_edma_get_phys_addr(struct pci_dev *pdev,
+				 struct dw_edma_pcie_data *pdata,
+				 enum pci_barno bar)
+{
+	if (pdev->vendor == PCI_VENDOR_ID_XILINX)
+		return pdata->phys_addr;
+	return pci_bus_address(pdev, bar);
+}
+
 static int dw_edma_pcie_probe(struct pci_dev *pdev,
 			      const struct pci_device_id *pid)
 {
@@ -233,6 +242,7 @@ static int dw_edma_pcie_probe(struct pci_dev *pdev,
 	struct dw_edma_chip *chip;
 	int err, nr_irqs;
 	int i, mask;
+	bool nollp = false;
 
 	vsec_data = kmalloc(sizeof(*vsec_data), GFP_KERNEL);
 	if (!vsec_data)
@@ -257,10 +267,12 @@ static int dw_edma_pcie_probe(struct pci_dev *pdev,
 	if (pdev->vendor == PCI_VENDOR_ID_XILINX) {
 		/*
 		 * There is no valid address found for the LL memory
-		 * space on the device side.
+		 * space on the device side. In the absence of LL base
+		 * address use the non-LL mode or simple mode supported by
+		 * the HDMA IP.
 		 */
 		if (vsec_data->phys_addr == DW_PCIE_AMD_MDB_INVALID_ADDR)
-			return -EINVAL;
+			nollp = true;
 	}
 
 	/* Mapping PCI BAR regions */
@@ -308,6 +320,7 @@ static int dw_edma_pcie_probe(struct pci_dev *pdev,
 	chip->mf = vsec_data->mf;
 	chip->nr_irqs = nr_irqs;
 	chip->ops = &dw_edma_pcie_plat_ops;
+	chip->nollp = nollp;
 
 	chip->ll_wr_cnt = vsec_data->wr_ch_cnt;
 	chip->ll_rd_cnt = vsec_data->rd_ch_cnt;
@@ -316,7 +329,7 @@ static int dw_edma_pcie_probe(struct pci_dev *pdev,
 	if (!chip->reg_base)
 		return -ENOMEM;
 
-	for (i = 0; i < chip->ll_wr_cnt; i++) {
+	for (i = 0; i < chip->ll_wr_cnt && !nollp; i++) {
 		struct dw_edma_region *ll_region = &chip->ll_region_wr[i];
 		struct dw_edma_region *dt_region = &chip->dt_region_wr[i];
 		struct dw_edma_block *ll_block = &vsec_data->ll_wr[i];
@@ -327,7 +340,8 @@ static int dw_edma_pcie_probe(struct pci_dev *pdev,
 			return -ENOMEM;
 
 		ll_region->vaddr.io += ll_block->off;
-		ll_region->paddr = pci_bus_address(pdev, ll_block->bar);
+		ll_region->paddr = dw_edma_get_phys_addr(pdev, vsec_data,
+							 ll_block->bar);
 		ll_region->paddr += ll_block->off;
 		ll_region->sz = ll_block->sz;
 
@@ -336,12 +350,13 @@ static int dw_edma_pcie_probe(struct pci_dev *pdev,
 			return -ENOMEM;
 
 		dt_region->vaddr.io += dt_block->off;
-		dt_region->paddr = pci_bus_address(pdev, dt_block->bar);
+		dt_region->paddr = dw_edma_get_phys_addr(pdev, vsec_data,
+							 dt_block->bar);
 		dt_region->paddr += dt_block->off;
 		dt_region->sz = dt_block->sz;
 	}
 
-	for (i = 0; i < chip->ll_rd_cnt; i++) {
+	for (i = 0; i < chip->ll_rd_cnt && !nollp; i++) {
 		struct dw_edma_region *ll_region = &chip->ll_region_rd[i];
 		struct dw_edma_region *dt_region = &chip->dt_region_rd[i];
 		struct dw_edma_block *ll_block = &vsec_data->ll_rd[i];
@@ -352,7 +367,8 @@ static int dw_edma_pcie_probe(struct pci_dev *pdev,
 			return -ENOMEM;
 
 		ll_region->vaddr.io += ll_block->off;
-		ll_region->paddr = pci_bus_address(pdev, ll_block->bar);
+		ll_region->paddr = dw_edma_get_phys_addr(pdev, vsec_data,
+							 ll_block->bar);
 		ll_region->paddr += ll_block->off;
 		ll_region->sz = ll_block->sz;
 
@@ -361,7 +377,8 @@ static int dw_edma_pcie_probe(struct pci_dev *pdev,
 			return -ENOMEM;
 
 		dt_region->vaddr.io += dt_block->off;
-		dt_region->paddr = pci_bus_address(pdev, dt_block->bar);
+		dt_region->paddr = dw_edma_get_phys_addr(pdev, vsec_data,
+							 dt_block->bar);
 		dt_region->paddr += dt_block->off;
 		dt_region->sz = dt_block->sz;
 	}
diff --git a/drivers/dma/dw-edma/dw-hdma-v0-core.c b/drivers/dma/dw-edma/dw-hdma-v0-core.c
index e3f8db4..befb9e0 100644
--- a/drivers/dma/dw-edma/dw-hdma-v0-core.c
+++ b/drivers/dma/dw-edma/dw-hdma-v0-core.c
@@ -225,7 +225,7 @@ static void dw_hdma_v0_sync_ll_data(struct dw_edma_chunk *chunk)
 		readl(chunk->ll_region.vaddr.io);
 }
 
-static void dw_hdma_v0_core_start(struct dw_edma_chunk *chunk, bool first)
+static void dw_hdma_v0_core_ll_start(struct dw_edma_chunk *chunk, bool first)
 {
 	struct dw_edma_chan *chan = chunk->chan;
 	struct dw_edma *dw = chan->dw;
@@ -263,6 +263,66 @@ static void dw_hdma_v0_core_start(struct dw_edma_chunk *chunk, bool first)
 	SET_CH_32(dw, chan->dir, chan->id, doorbell, HDMA_V0_DOORBELL_START);
 }
 
+static void dw_hdma_v0_core_non_ll_start(struct dw_edma_chunk *chunk)
+{
+	struct dw_edma_chan *chan = chunk->chan;
+	struct dw_edma *dw = chan->dw;
+	struct dw_edma_burst *child;
+	u32 val;
+
+	list_for_each_entry(child, &chunk->burst->list, list) {
+		SET_CH_32(dw, chan->dir, chan->id, ch_en, BIT(0));
+
+		/* Source address */
+		SET_CH_32(dw, chan->dir, chan->id, sar.lsb,
+			  lower_32_bits(child->sar));
+		SET_CH_32(dw, chan->dir, chan->id, sar.msb,
+			  upper_32_bits(child->sar));
+
+		/* Destination address */
+		SET_CH_32(dw, chan->dir, chan->id, dar.lsb,
+			  lower_32_bits(child->dar));
+		SET_CH_32(dw, chan->dir, chan->id, dar.msb,
+			  upper_32_bits(child->dar));
+
+		/* Transfer size */
+		SET_CH_32(dw, chan->dir, chan->id, transfer_size, child->sz);
+
+		/* Interrupt setup */
+		val = GET_CH_32(dw, chan->dir, chan->id, int_setup) |
+				HDMA_V0_STOP_INT_MASK |
+				HDMA_V0_ABORT_INT_MASK |
+				HDMA_V0_LOCAL_STOP_INT_EN |
+				HDMA_V0_LOCAL_ABORT_INT_EN;
+
+		if (!(dw->chip->flags & DW_EDMA_CHIP_LOCAL)) {
+			val |= HDMA_V0_REMOTE_STOP_INT_EN |
+			       HDMA_V0_REMOTE_ABORT_INT_EN;
+		}
+
+		SET_CH_32(dw, chan->dir, chan->id, int_setup, val);
+
+		/* Channel control setup */
+		val = GET_CH_32(dw, chan->dir, chan->id, control1);
+		val &= ~HDMA_V0_LINKLIST_EN;
+		SET_CH_32(dw, chan->dir, chan->id, control1, val);
+
+		/* Ring the doorbell */
+		SET_CH_32(dw, chan->dir, chan->id, doorbell,
+			  HDMA_V0_DOORBELL_START);
+	}
+}
+
+static void dw_hdma_v0_core_start(struct dw_edma_chunk *chunk, bool first)
+{
+	struct dw_edma_chan *chan = chunk->chan;
+
+	if (!chan->nollp)
+		dw_hdma_v0_core_ll_start(chunk, first);
+	else
+		dw_hdma_v0_core_non_ll_start(chunk);
+}
+
 static void dw_hdma_v0_core_ch_config(struct dw_edma_chan *chan)
 {
 	struct dw_edma *dw = chan->dw;
diff --git a/include/linux/dma/edma.h b/include/linux/dma/edma.h
index 3080747..e14e16f 100644
--- a/include/linux/dma/edma.h
+++ b/include/linux/dma/edma.h
@@ -99,6 +99,7 @@ struct dw_edma_chip {
 	enum dw_edma_map_format	mf;
 
 	struct dw_edma		*dw;
+	bool			nollp;
 };
 
 /* Export to the platform drivers */
-- 
1.8.3.1


