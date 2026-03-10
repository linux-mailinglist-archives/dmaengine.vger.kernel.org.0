Return-Path: <dmaengine+bounces-9361-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IO87CpobsGngfwIAu9opvQ
	(envelope-from <dmaengine+bounces-9361-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Tue, 10 Mar 2026 14:24:42 +0100
X-Original-To: lists+dmaengine@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id C2C0A2502D1
	for <lists+dmaengine@lfdr.de>; Tue, 10 Mar 2026 14:24:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id D1C563096CEF
	for <lists+dmaengine@lfdr.de>; Tue, 10 Mar 2026 13:04:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FF913D090F;
	Tue, 10 Mar 2026 12:31:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="KAL/91DC"
X-Original-To: dmaengine@vger.kernel.org
Received: from PH0PR06CU001.outbound.protection.outlook.com (mail-westus3azon11011064.outbound.protection.outlook.com [40.107.208.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE4FE3CFF52;
	Tue, 10 Mar 2026 12:31:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.208.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773145874; cv=fail; b=ZqhMZ9XszFajNbPoW+R76CvaYkg2icKNzIqwTlfjrTI7ljA5Mcju8nlq4D2RKQAl7Fv87OHZl9emGbL9yss7P+ohv2YYh9v3tPO7DMYp470ajTcEU1G+QZ7rrImrQnn65LuTKY2MmNu6RvQCQPZcdkhOhGRWkvOzw+bJnMax7I8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773145874; c=relaxed/simple;
	bh=h4CWZzOTlIAqKk8f8nHkiAtZuDeKycQG2+K4XahHlv0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UdwUoYq0CbMaPLhlXLw+VedI8aHvYBkOPKZs6blNq4IAndCn17A8QfAZhaea3mfo9dtk8tp+KQ20yUmP94lwRO/s9f2QYSHYDU+t9cznRBuLZrhhU9OxACCoaDWMQN/5WQIJ3D8nVoE+sjbFmWAh1KUlCMEVp/8cX1XHj9gV2DU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=KAL/91DC; arc=fail smtp.client-ip=40.107.208.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=V+0xoQAEX1Y6j4uqO6/LiKjn5t6arU5qA3ZrTuPpUFJVsNHR0Eg8xxPN/Qn6nhXzkK9D0isOgqgoA7dcwQ3nJTrrmSn7ITow8lCnqO8pKyWUMt8Fabr474zdlZ+qLt9HBqKN45N5V8rgRDp+XrvDk7qO88DSdw8uNwsZKJ6DMfg/2u5cSbE3uxPghQKbgyVizExTQvx8R5fQqxk9tS096oGmqvSDUcynIcuRi5t/qgVwDPydESg/2qkaraTM5RDtYpUCOO9UO6UdvoFajhvE0E3v8NZ47gu7FZiZ6bsbwethXmzUab7HVxwaTqsyWVZWH45wtFwhybcvUal9D5hriA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ayDqV5w0tfSLTiiEhnk6sc5WdPvAfwcqWi4iM5D42LA=;
 b=tslCJAcRAT+6VF8Wj28LVjx+Usbltsgpzt/BG+2I7BNEOCGGOcrm3jgGJ8qe+DfJAnkBG6MuE3IAklB0j8FmiUF/cKveMZR/LcD1Ux7lbF6f1RqVVprrMGcEDfclYEa+KX1hHIJKWg0i+gbclW5i+sLsBcXzWkav/tav5W9CI4rENXQOL7vWpuN+wIE/p5XFn8d6gtpwsp4qB/pa0e2LKtMyZsNdP0bEVa1LECYz6rh6iykFm2Qw+KT1O4BljnmJqTUUPa1SJpq9ry2iHnEuStmwrhNTucLGAOk1tJwPhvZToNRo/OgYS7bvJ05il9y6/2XywGfcSjCRBeCNt5GgQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=google.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ayDqV5w0tfSLTiiEhnk6sc5WdPvAfwcqWi4iM5D42LA=;
 b=KAL/91DChdH6vJZ8791iTY6+vQzzVTAgB4HAn+jU3eAXahinkysynM3M3nc3P6mxheZ7/+0k8YEb5+4L39IlhOyV60nT625OUsgEyZGm9Cw12iG9zEVyzdjG9i4SIzAwt6w2mk89cL3UkWaav2sbOw89cqkSeHLl0cj+vHTYZgk=
Received: from BYAPR05CA0021.namprd05.prod.outlook.com (2603:10b6:a03:c0::34)
 by DM4PR12MB6639.namprd12.prod.outlook.com (2603:10b6:8:be::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.11; Tue, 10 Mar
 2026 12:31:08 +0000
Received: from SJ1PEPF0000231D.namprd03.prod.outlook.com
 (2603:10b6:a03:c0:cafe::ca) by BYAPR05CA0021.outlook.office365.com
 (2603:10b6:a03:c0::34) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9678.22 via Frontend Transport; Tue,
 10 Mar 2026 12:31:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF0000231D.mail.protection.outlook.com (10.167.242.234) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9678.18 via Frontend Transport; Tue, 10 Mar 2026 12:31:07 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.17; Tue, 10 Mar
 2026 07:31:07 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 10 Mar
 2026 07:31:03 -0500
Received: from xhddevverma40x.xilinx.com (10.180.168.240) by
 satlexmb08.amd.com (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.17
 via Frontend Transport; Tue, 10 Mar 2026 07:31:01 -0500
From: Devendra K Verma <devendra.verma@amd.com>
To: <bhelgaas@google.com>, <mani@kernel.org>, <vkoul@kernel.org>
CC: <dmaengine@vger.kernel.org>, <linux-pci@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <michal.simek@amd.com>,
	<Devendra.Verma@amd.com>
Subject: [PATCH v12 2/2] dmaengine: dw-edma: Add non-LL mode
Date: Tue, 10 Mar 2026 18:00:55 +0530
Message-ID: <20260310123055.2863727-3-devendra.verma@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260310123055.2863727-1-devendra.verma@amd.com>
References: <20260310123055.2863727-1-devendra.verma@amd.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: devendra.verma@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF0000231D:EE_|DM4PR12MB6639:EE_
X-MS-Office365-Filtering-Correlation-Id: 72cf346a-284b-41d4-e7ce-08de7ea0e7a0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|376014|82310400026|1800799024|22082099002;
X-Microsoft-Antispam-Message-Info:
	W5/O8fQzAeNsFqM4pVm+nsaxJ+DmuAolXosioBCN3Is8jy4+KtaJD/w19UzwS4gpIPv6395XIlp93OWMoQu0zrRFgfd/JoZ6HOJ38WUzcDrxvTzuBgRPrOWhzL5tQ0i42JKiHnvC3Ku55UHWM6vKarzgUlUIbqTPuq3GXmolBzrzf/ob/8hinaEIxLVbZeYVho23RxssUYjiww8B4ittGjcGNoJ9B2bytSJN4DwJdIYVhjK5Ga4xhCNxF+ObM/m37Y5nwWQ4zUk+Z7dvwQqVhwv2IkHG6TIFkqpigbpiLWDmIjTMqha/Hw7kmn+TNr3lcjazs7PbIE/jGaLuAxTNx7GLJERxUHd4AbdURK5vP9i7aM+1GQT1c+RxgzW5mu5s8ijJ1ldYlsSrUvJcJVXbvQ6TjvfYkUTyZL2Sdb0H/02oXjErD3KifJ/8YjSeNWP7CGoas6U+hqVNb9LVlqHktNIle8muzQnV0Tg53dJdYOJcOfGxUUMEp8kqMl6p7JRay9B6XRua69MvUrX5eis+npm8dF2Q8aO36bAgjmwK6by0I3XZ3R5TLL38jLXPYTrHclnP43A8PyJmMMz6It8RiJtDmQp8vnyZLk/eYXv2v12ChYhrg27IgRh/zkFxNtWXLaVQL8e/s3ntO6zSUhGl7zK0sbgNOb7V5rq2ol7YRswQsgE1/ULfD/V42e0mFte97YW6FXd0Ohp61JhoY1jVknuIO83h0KmGaBAB3z7oI0gDDmCJsH2eAjsO76nmoMXAwxdqYDA9s1CTMXpRDYkF4w==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(376014)(82310400026)(1800799024)(22082099002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	xJITmIXawgCKMzaDwoWWTGlskaPQ0Weu3lOSxK4b+Td8s1WXDOYD/+dh0uNL12EPXtkYATW5HAglGRQoUe+ea+88wa/JRkP8F/jRDp8O/6IOifW3PmejUe4Dej15DZSE28UIzS/igwWjDf2DIhmwzzGFmeQgIagvr5yzYLFciVQkh+RZy5KhF6IwtKJvY7i9ffC3MmVyitxBGpN4Jl1we9ZRDPbgd1RbQ0BOvP+ULje+7OJaZK5gIjVgJzkyi6jT5nonj3vTMkfu0CYUAelozXRWpDsYflQibirrjYKVNczksekyClKjlp3Zjycl4/VbjdNGwrLyWcMX/s81GwDeE7pwS2HF82qtw4LYTgsHRwVYEIApCJLyNb4sLmjizJ/IGNYzbsdL0jxBYlYel4tSIo5dnyrSXNRT5abPH6L+6ye1IFyG/8+uU6NDNU9CO+pJ
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Mar 2026 12:31:07.8333
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 72cf346a-284b-41d4-e7ce-08de7ea0e7a0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF0000231D.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6639
X-Rspamd-Queue-Id: C2C0A2502D1
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[amd.com,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[amd.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[amd.com:+];
	TAGGED_FROM(0.00)[bounces-9361-lists,dmaengine=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[amd.com:dkim,amd.com:email,amd.com:mid,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[devendra.verma@amd.com,dmaengine@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TO_DN_NONE(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[dmaengine];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Action: no action

AMD MDB IP supports Linked List (LL) mode as well as non-LL mode.
The current code does not have the mechanisms to enable the
DMA transactions using the non-LL mode. The following two cases
are added with this patch:
- For the AMD (Xilinx) only, when a valid physical base address of
  the device side DDR is not configured, then the IP can still be
  used in non-LL mode. For all the channels DMA transactions will
  be using the non-LL mode only. This, the default non-LL mode,
  is not applicable for Synopsys IP with the current code addition.

- If the default mode is LL-mode, for both AMD (Xilinx) and Synosys,
  and if user wants to use non-LL mode then user can do so via
  configuring the peripheral_config param of dma_slave_config.

Signed-off-by: Devendra K Verma <devendra.verma@amd.com>
---
Changes in v12
  Simplified the logic to set the channel non_ll flag

Changes in v11
  Added error check for the following
    If user enables LL mode when non-LL is default mode.
    If config_param provided by user for eDMA
  Renamed the 'non_ll' flag in dw_edma_chip to 'cfg_non_ll'

Changes in v10
  Added the peripheral_config check only for HDMA IP in
  dw_edma_device_config().
  Replaced the loop with single entry retrieval for non-LL
  mode.
  Addressed review comments and handled the burst allocation
  by defining 'bursts_max' as per suggestions.

Changes in v9
  Fixed compilation errors related to macro name mismatch.

Changes in v8
  Cosmetic change related to comment and code.

Changes in v7
  No change

Changes in v6
  Gave definition to bits used for channel configuration.
  Removed the comment related to doorbell.

Changes in v5
  Variable name 'nollp' changed to 'non_ll'.
  In the dw_edma_device_config() WARN_ON replaced with dev_err().
  Comments follow the 80-column guideline.

Changes in v4
  No change

Changes in v3
  No change

Changes in v2
  Reverted the function return type to u64 for
  dw_edma_get_phys_addr().

Changes in v1
  Changed the function return type for dw_edma_get_phys_addr().
  Corrected the typo raised in review.
---
 drivers/dma/dw-edma/dw-edma-core.c    | 47 ++++++++++++++++++-
 drivers/dma/dw-edma/dw-edma-core.h    |  1 +
 drivers/dma/dw-edma/dw-edma-pcie.c    | 44 ++++++++++++------
 drivers/dma/dw-edma/dw-hdma-v0-core.c | 65 ++++++++++++++++++++++++++-
 drivers/dma/dw-edma/dw-hdma-v0-regs.h |  1 +
 include/linux/dma/edma.h              |  1 +
 6 files changed, 144 insertions(+), 15 deletions(-)

diff --git a/drivers/dma/dw-edma/dw-edma-core.c b/drivers/dma/dw-edma/dw-edma-core.c
index b43255f914f3..1e3266daccc8 100644
--- a/drivers/dma/dw-edma/dw-edma-core.c
+++ b/drivers/dma/dw-edma/dw-edma-core.c
@@ -223,6 +223,43 @@ static int dw_edma_device_config(struct dma_chan *dchan,
 				 struct dma_slave_config *config)
 {
 	struct dw_edma_chan *chan = dchan2dw_edma_chan(dchan);
+	bool cfg_non_ll;
+	int non_ll = 0;
+
+	chan->non_ll = false;
+	if (chan->dw->chip->mf == EDMA_MF_HDMA_NATIVE) {
+		if (config->peripheral_config &&
+		    config->peripheral_size != sizeof(int)) {
+			dev_err(dchan->device->dev,
+				"config param peripheral size mismatch\n");
+			return -EINVAL;
+		}
+
+		/*
+		 * When there is no valid LLP base address available then the
+		 * default DMA ops will use the non-LL mode.
+		 *
+		 * Cases where LL mode is enabled and client wants to use the
+		 * non-LL mode then also client can do so via providing the
+		 * peripheral_config param.
+		 */
+		cfg_non_ll = chan->dw->chip->cfg_non_ll;
+		if (config->peripheral_config) {
+			non_ll = *(int *)config->peripheral_config;
+
+			if (cfg_non_ll && !non_ll) {
+				dev_err(dchan->device->dev, "invalid configuration\n");
+				return -EINVAL;
+			}
+		}
+
+		if (cfg_non_ll || non_ll)
+			chan->non_ll = true;
+	} else if (config->peripheral_config) {
+		dev_err(dchan->device->dev,
+			"peripheral config param applicable only for HDMA\n");
+		return -EINVAL;
+	}
 
 	memcpy(&chan->config, config, sizeof(*config));
 	chan->configured = true;
@@ -358,6 +395,7 @@ dw_edma_device_transfer(struct dw_edma_transfer *xfer)
 	struct dw_edma_desc *desc;
 	u64 src_addr, dst_addr;
 	size_t fsz = 0;
+	u32 bursts_max;
 	u32 cnt = 0;
 	int i;
 
@@ -415,6 +453,13 @@ dw_edma_device_transfer(struct dw_edma_transfer *xfer)
 		return NULL;
 	}
 
+	/*
+	 * For non-LL mode, only a single burst can be handled
+	 * in a single chunk unlike LL mode where multiple bursts
+	 * can be configured in a single chunk.
+	 */
+	bursts_max = chan->non_ll ? 1 : chan->ll_max;
+
 	desc = dw_edma_alloc_desc(chan);
 	if (unlikely(!desc))
 		goto err_alloc;
@@ -450,7 +495,7 @@ dw_edma_device_transfer(struct dw_edma_transfer *xfer)
 		if (xfer->type == EDMA_XFER_SCATTER_GATHER && !sg)
 			break;
 
-		if (chunk->bursts_alloc == chan->ll_max) {
+		if (chunk->bursts_alloc == bursts_max) {
 			chunk = dw_edma_alloc_chunk(desc);
 			if (unlikely(!chunk))
 				goto err_alloc;
diff --git a/drivers/dma/dw-edma/dw-edma-core.h b/drivers/dma/dw-edma/dw-edma-core.h
index 71894b9e0b15..c8e3d196a549 100644
--- a/drivers/dma/dw-edma/dw-edma-core.h
+++ b/drivers/dma/dw-edma/dw-edma-core.h
@@ -86,6 +86,7 @@ struct dw_edma_chan {
 	u8				configured;
 
 	struct dma_slave_config		config;
+	bool				non_ll;
 };
 
 struct dw_edma_irq {
diff --git a/drivers/dma/dw-edma/dw-edma-pcie.c b/drivers/dma/dw-edma/dw-edma-pcie.c
index b8208186a250..f538d728609f 100644
--- a/drivers/dma/dw-edma/dw-edma-pcie.c
+++ b/drivers/dma/dw-edma/dw-edma-pcie.c
@@ -295,6 +295,15 @@ static void dw_edma_pcie_get_xilinx_dma_data(struct pci_dev *pdev,
 	pdata->devmem_phys_off = off;
 }
 
+static u64 dw_edma_get_phys_addr(struct pci_dev *pdev,
+				 struct dw_edma_pcie_data *pdata,
+				 enum pci_barno bar)
+{
+	if (pdev->vendor == PCI_VENDOR_ID_XILINX)
+		return pdata->devmem_phys_off;
+	return pci_bus_address(pdev, bar);
+}
+
 static int dw_edma_pcie_probe(struct pci_dev *pdev,
 			      const struct pci_device_id *pid)
 {
@@ -304,6 +313,7 @@ static int dw_edma_pcie_probe(struct pci_dev *pdev,
 	struct dw_edma_chip *chip;
 	int err, nr_irqs;
 	int i, mask;
+	bool non_ll = false;
 
 	vsec_data = kmalloc(sizeof(*vsec_data), GFP_KERNEL);
 	if (!vsec_data)
@@ -329,21 +339,24 @@ static int dw_edma_pcie_probe(struct pci_dev *pdev,
 
 		/*
 		 * There is no valid address found for the LL memory
-		 * space on the device side.
+		 * space on the device side. In the absence of LL base
+		 * address use the non-LL mode or simple mode supported by
+		 * the HDMA IP.
 		 */
 		if (vsec_data->devmem_phys_off == DW_PCIE_XILINX_MDB_INVALID_ADDR)
-			return -ENOMEM;
+			non_ll = true;
 
 		/*
 		 * Configure the channel LL and data blocks if number of
 		 * channels enabled in VSEC capability are more than the
 		 * channels configured in xilinx_mdb_data.
 		 */
-		dw_edma_set_chan_region_offset(vsec_data, BAR_2, 0,
-					       DW_PCIE_XILINX_MDB_LL_OFF_GAP,
-					       DW_PCIE_XILINX_MDB_LL_SIZE,
-					       DW_PCIE_XILINX_MDB_DT_OFF_GAP,
-					       DW_PCIE_XILINX_MDB_DT_SIZE);
+		if (!non_ll)
+			dw_edma_set_chan_region_offset(vsec_data, BAR_2, 0,
+						       DW_PCIE_XILINX_MDB_LL_OFF_GAP,
+						       DW_PCIE_XILINX_MDB_LL_SIZE,
+						       DW_PCIE_XILINX_MDB_DT_OFF_GAP,
+						       DW_PCIE_XILINX_MDB_DT_SIZE);
 	}
 
 	/* Mapping PCI BAR regions */
@@ -391,6 +404,7 @@ static int dw_edma_pcie_probe(struct pci_dev *pdev,
 	chip->mf = vsec_data->mf;
 	chip->nr_irqs = nr_irqs;
 	chip->ops = &dw_edma_pcie_plat_ops;
+	chip->cfg_non_ll = non_ll;
 
 	chip->ll_wr_cnt = vsec_data->wr_ch_cnt;
 	chip->ll_rd_cnt = vsec_data->rd_ch_cnt;
@@ -399,7 +413,7 @@ static int dw_edma_pcie_probe(struct pci_dev *pdev,
 	if (!chip->reg_base)
 		return -ENOMEM;
 
-	for (i = 0; i < chip->ll_wr_cnt; i++) {
+	for (i = 0; i < chip->ll_wr_cnt && !non_ll; i++) {
 		struct dw_edma_region *ll_region = &chip->ll_region_wr[i];
 		struct dw_edma_region *dt_region = &chip->dt_region_wr[i];
 		struct dw_edma_block *ll_block = &vsec_data->ll_wr[i];
@@ -410,7 +424,8 @@ static int dw_edma_pcie_probe(struct pci_dev *pdev,
 			return -ENOMEM;
 
 		ll_region->vaddr.io += ll_block->off;
-		ll_region->paddr = pci_bus_address(pdev, ll_block->bar);
+		ll_region->paddr = dw_edma_get_phys_addr(pdev, vsec_data,
+							 ll_block->bar);
 		ll_region->paddr += ll_block->off;
 		ll_region->sz = ll_block->sz;
 
@@ -419,12 +434,13 @@ static int dw_edma_pcie_probe(struct pci_dev *pdev,
 			return -ENOMEM;
 
 		dt_region->vaddr.io += dt_block->off;
-		dt_region->paddr = pci_bus_address(pdev, dt_block->bar);
+		dt_region->paddr = dw_edma_get_phys_addr(pdev, vsec_data,
+							 dt_block->bar);
 		dt_region->paddr += dt_block->off;
 		dt_region->sz = dt_block->sz;
 	}
 
-	for (i = 0; i < chip->ll_rd_cnt; i++) {
+	for (i = 0; i < chip->ll_rd_cnt && !non_ll; i++) {
 		struct dw_edma_region *ll_region = &chip->ll_region_rd[i];
 		struct dw_edma_region *dt_region = &chip->dt_region_rd[i];
 		struct dw_edma_block *ll_block = &vsec_data->ll_rd[i];
@@ -435,7 +451,8 @@ static int dw_edma_pcie_probe(struct pci_dev *pdev,
 			return -ENOMEM;
 
 		ll_region->vaddr.io += ll_block->off;
-		ll_region->paddr = pci_bus_address(pdev, ll_block->bar);
+		ll_region->paddr = dw_edma_get_phys_addr(pdev, vsec_data,
+							 ll_block->bar);
 		ll_region->paddr += ll_block->off;
 		ll_region->sz = ll_block->sz;
 
@@ -444,7 +461,8 @@ static int dw_edma_pcie_probe(struct pci_dev *pdev,
 			return -ENOMEM;
 
 		dt_region->vaddr.io += dt_block->off;
-		dt_region->paddr = pci_bus_address(pdev, dt_block->bar);
+		dt_region->paddr = dw_edma_get_phys_addr(pdev, vsec_data,
+							 dt_block->bar);
 		dt_region->paddr += dt_block->off;
 		dt_region->sz = dt_block->sz;
 	}
diff --git a/drivers/dma/dw-edma/dw-hdma-v0-core.c b/drivers/dma/dw-edma/dw-hdma-v0-core.c
index e3f8db4fe909..a1b04fec6310 100644
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
@@ -263,6 +263,69 @@ static void dw_hdma_v0_core_start(struct dw_edma_chunk *chunk, bool first)
 	SET_CH_32(dw, chan->dir, chan->id, doorbell, HDMA_V0_DOORBELL_START);
 }
 
+static void dw_hdma_v0_core_non_ll_start(struct dw_edma_chunk *chunk)
+{
+	struct dw_edma_chan *chan = chunk->chan;
+	struct dw_edma *dw = chan->dw;
+	struct dw_edma_burst *child;
+	u32 val;
+
+	child = list_first_entry_or_null(&chunk->burst->list,
+					 struct dw_edma_burst, list);
+	if (!child)
+		return;
+
+	SET_CH_32(dw, chan->dir, chan->id, ch_en, HDMA_V0_CH_EN);
+
+	/* Source address */
+	SET_CH_32(dw, chan->dir, chan->id, sar.lsb,
+		  lower_32_bits(child->sar));
+	SET_CH_32(dw, chan->dir, chan->id, sar.msb,
+		  upper_32_bits(child->sar));
+
+	/* Destination address */
+	SET_CH_32(dw, chan->dir, chan->id, dar.lsb,
+		  lower_32_bits(child->dar));
+	SET_CH_32(dw, chan->dir, chan->id, dar.msb,
+		  upper_32_bits(child->dar));
+
+	/* Transfer size */
+	SET_CH_32(dw, chan->dir, chan->id, transfer_size, child->sz);
+
+	/* Interrupt setup */
+	val = GET_CH_32(dw, chan->dir, chan->id, int_setup) |
+			HDMA_V0_STOP_INT_MASK |
+			HDMA_V0_ABORT_INT_MASK |
+			HDMA_V0_LOCAL_STOP_INT_EN |
+			HDMA_V0_LOCAL_ABORT_INT_EN;
+
+	if (!(dw->chip->flags & DW_EDMA_CHIP_LOCAL)) {
+		val |= HDMA_V0_REMOTE_STOP_INT_EN |
+		       HDMA_V0_REMOTE_ABORT_INT_EN;
+	}
+
+	SET_CH_32(dw, chan->dir, chan->id, int_setup, val);
+
+	/* Channel control setup */
+	val = GET_CH_32(dw, chan->dir, chan->id, control1);
+	val &= ~HDMA_V0_LINKLIST_EN;
+	SET_CH_32(dw, chan->dir, chan->id, control1, val);
+
+	SET_CH_32(dw, chan->dir, chan->id, doorbell,
+		  HDMA_V0_DOORBELL_START);
+	
+}
+
+static void dw_hdma_v0_core_start(struct dw_edma_chunk *chunk, bool first)
+{
+	struct dw_edma_chan *chan = chunk->chan;
+
+	if (chan->non_ll)
+		dw_hdma_v0_core_non_ll_start(chunk);
+	else
+		dw_hdma_v0_core_ll_start(chunk, first);
+}
+
 static void dw_hdma_v0_core_ch_config(struct dw_edma_chan *chan)
 {
 	struct dw_edma *dw = chan->dw;
diff --git a/drivers/dma/dw-edma/dw-hdma-v0-regs.h b/drivers/dma/dw-edma/dw-hdma-v0-regs.h
index eab5fd7177e5..7759ba9b4850 100644
--- a/drivers/dma/dw-edma/dw-hdma-v0-regs.h
+++ b/drivers/dma/dw-edma/dw-hdma-v0-regs.h
@@ -12,6 +12,7 @@
 #include <linux/dmaengine.h>
 
 #define HDMA_V0_MAX_NR_CH			8
+#define HDMA_V0_CH_EN				BIT(0)
 #define HDMA_V0_LOCAL_ABORT_INT_EN		BIT(6)
 #define HDMA_V0_REMOTE_ABORT_INT_EN		BIT(5)
 #define HDMA_V0_LOCAL_STOP_INT_EN		BIT(4)
diff --git a/include/linux/dma/edma.h b/include/linux/dma/edma.h
index 3080747689f6..bb88439bd091 100644
--- a/include/linux/dma/edma.h
+++ b/include/linux/dma/edma.h
@@ -99,6 +99,7 @@ struct dw_edma_chip {
 	enum dw_edma_map_format	mf;
 
 	struct dw_edma		*dw;
+	bool			cfg_non_ll;
 };
 
 /* Export to the platform drivers */
-- 
2.43.0


