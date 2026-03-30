Return-Path: <dmaengine+bounces-9723-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wBdNA9aOymn09gUAu9opvQ
	(envelope-from <dmaengine+bounces-9723-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Mon, 30 Mar 2026 16:55:18 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id C754C35D3ED
	for <lists+dmaengine@lfdr.de>; Mon, 30 Mar 2026 16:55:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 1C5CE302F561
	for <lists+dmaengine@lfdr.de>; Mon, 30 Mar 2026 14:47:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B92ED328255;
	Mon, 30 Mar 2026 14:46:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="PuJ0FRBd"
X-Original-To: dmaengine@vger.kernel.org
Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11010067.outbound.protection.outlook.com [52.101.56.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B00D3242B3;
	Mon, 30 Mar 2026 14:46:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.56.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774882016; cv=fail; b=sBF9Z/UfL6w491B9+PlfXlQW9OLCXeQW4O34QxWmGJpZGlURn3ib2SRbCyURaZfc87KTsgy4olmhcmZYRi0xJ3mMe3Tbk1W/kUWsC+Xyihm0KVPr+/46Uvj3Yvm/cx1HN/lFK2VM0y8gplijHnewJx16vRMm7SWX/o4/DPx3FUk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774882016; c=relaxed/simple;
	bh=WG2+Bly3nyEIt6xuS+A7xFFZDoAAshRJ/VdCkiTYHWI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=j90+7U5guuk3f52NtwbCnpUZwUBGatoaLaRUyt/n8yB64PjlhxGqYtyaoBZeTw95eh6B0zzz0ypGaBKVmBbsnEq4+tlYrzdnhubnEZYiSmU8U75vRW/+BelfnidYqrZcqozv5HS+debOYAzH8Ikz9lZdEgaq/nUVBtS4HSb9PlA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=PuJ0FRBd; arc=fail smtp.client-ip=52.101.56.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Zswzz5c11P4sdgyTY2jBTxYbt3kWr0n7RuiBjNc+GDVfH8N0W5jHSc4GH3pYadxGO5XfeMr+ekHzkisAAiTmMoP+YvthIMLRM+utW9DtFQ+qGkUMFFgnovuK9Ndma0TRqzhAGiLwJowRleN/+ccmWoOVzDp/yk4OpYnIWXOIOKpAiXYi2CDGpr8/bgLpHXfVfXuk7J5L+wnyxBm7E+57YzaYrPSP8B2PQUlrTDabuJSJafBI9qarDF0pLu7gN6H/bpHIegib73qpM7yl7pRmrn0Oj6SVA9DF0RR6MER6SO3Yx/cqze7gWm2MR8K466OUNlrEH/sYEk9jnImJfxManQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SrXw7TLEzYi+XLbUY+YehQJUOxk7EBo+aozC4F5LChg=;
 b=cmw51kaB/E0uwEAP4ZdqhGWft/KqHU39cBtferz1Ou2vQMGxdAydJfGfga0uh8HZI7czL3w3MxxMpQpY9pHv9CXoMhPvZPr/+I/yMoqdwebfdAlS6GoAR7DEG1h3ro+srdNw/fjjDP+LX+q3LeiwpN4TWDcOLvVEkTLRp4iuHfNF5XvtnGhyZ7pMCCjKBo7F+penpiozT9ve4PsEXwigwD+XVpawKh4+nWnukV5kfcrSedrjVhf4QWU2LPpBM56lZqaNEnzw0Jt1yNxLU+cn/YZsRJEmkHKH/ARNi7qK59S6ujyf5kEmmeGfSa9L9qxty3iVKj3mDm1PGOKNhtrKgA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SrXw7TLEzYi+XLbUY+YehQJUOxk7EBo+aozC4F5LChg=;
 b=PuJ0FRBdeUv/CzEuAuUyzj+tg8ajKguSHJVVru6uUBIZSEc2KBWMN1yNAk0U0GQl5zK9oQuJPnz5u959wM+3lp/aOKs8b5r5/1dLfVdaLj8bXetjhYnpkNaKJfEm91KsTA1PWoGcjCTklfWt564JBU6QtpDL/heXA0ad/0rDNI5BoQnoP7YlwppPqtxbZJ/LGOv1gfpkToo64KBJdER8C3jmVQPt38OWcmd0w2FLwMamYrlR1aGdf4Ln7/yHtGPKp/B37DLhg7pwmQHCaSN5EE3i0XHaIpV2zjs/YHVXocG+J+fWd9HzOvM3NtAVRfzE+iCv4avoIvfTGhqY8BMnbA==
Received: from DS7PR03CA0024.namprd03.prod.outlook.com (2603:10b6:5:3b8::29)
 by CH3PR12MB9023.namprd12.prod.outlook.com (2603:10b6:610:17b::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.20; Mon, 30 Mar
 2026 14:46:44 +0000
Received: from CY4PEPF0000EE3D.namprd03.prod.outlook.com
 (2603:10b6:5:3b8:cafe::11) by DS7PR03CA0024.outlook.office365.com
 (2603:10b6:5:3b8::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9745.28 via Frontend Transport; Mon,
 30 Mar 2026 14:46:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CY4PEPF0000EE3D.mail.protection.outlook.com (10.167.242.15) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9745.21 via Frontend Transport; Mon, 30 Mar 2026 14:46:43 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 30 Mar
 2026 07:46:27 -0700
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 30 Mar
 2026 07:46:26 -0700
Received: from BUILDSERVER-IO-L4T.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Mon, 30 Mar 2026 07:46:22 -0700
From: Akhil R <akhilrajeev@nvidia.com>
To: Vinod Koul <vkoul@kernel.org>, Frank Li <Frank.Li@kernel.org>, Rob Herring
	<robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
	<conor+dt@kernel.org>, Thierry Reding <thierry.reding@gmail.com>, "Jonathan
 Hunter" <jonathanh@nvidia.com>, Laxman Dewangan <ldewangan@nvidia.com>,
	Philipp Zabel <p.zabel@pengutronix.de>, <dmaengine@vger.kernel.org>,
	<devicetree@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
CC: Akhil R <akhilrajeev@nvidia.com>
Subject: [PATCH v5 08/10] dmaengine: tegra: Use iommu-map for stream ID
Date: Mon, 30 Mar 2026 20:14:54 +0530
Message-ID: <20260330144456.13551-9-akhilrajeev@nvidia.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260330144456.13551-1-akhilrajeev@nvidia.com>
References: <20260330144456.13551-1-akhilrajeev@nvidia.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-NVConfidentiality: public
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE3D:EE_|CH3PR12MB9023:EE_
X-MS-Office365-Filtering-Correlation-Id: 459522b5-d1cc-4d65-e93b-08de8e6b2964
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|82310400026|1800799024|36860700016|376014|921020|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	lZBssmX4Xs0aPc039KQ9+J2eYy7RlnvqRnln0ICiFe2/WWcHeTgBT0JvD9GJAMqHzbe74C8GNmjfdLaJkAlON9shYMTPwH9DoUuFh0CoQmD/SmUxgFmhuSeHLovNMD0+4rD6f7k5xD+O8rSnpWIC5NYBs2jLNZ4jZLDoRz9xgbBsaDgE97TwnL2LT8ta0hjUFqpQPmMJ6Oi/qq1zAbXdilR9yvL9MVHkvzo2FI9hufdLctg0U8ke6iqsv3Vy0b4gRZvQ16uK3TYoQNz3ElJBpjCurWnwoFINkRrJmQcVPr8NbQqkHurLpJ85pg57Xn8OkUa1LCi2tQfhp77USwOe2dw8LKFmS0adswcYXdI6ed7DBDoc76uQiGM8d7QvsrCR4eCGBOyx++nX3NURcw2p5taZHyaa4gbc980g+DnUcYFD0rtpo4KYpZd/1oK497S+LuynXh5Y2mbJdOljZGFEtQCTrewtI8I9aUgoohRihrL1U+ZrWIQWQJc6LlDrbP9Mx9HiS6DDbuSkxMQSVv8AXijISGVeh/EsPc1q9FO9RjscAyEwYh2228GSIDcmsRHZQUNt5miPbMkGST95V7YtJN5d0PDomHD2JoDWAJ4l3iHb4T/I9fqtrhrtX+xlS8+A9S0U2D7Fk54kr0JP34RZ1K4NIBYQPk5txTsHbaH3IR4RdaQvfSwPi6T2OoR0QaiRD67SQc4N0gI7lMX1ALZRnjaSorAqrPv/nNwUgSGEiNLejjX8zf6Q1VBnI4fUwEbHdREwotzSodKp/mvv4omEQrmR+g5juZ7ocLXwagjAZ8gIlbPZnUdJxbJdnZTB3NU9
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(7416014)(82310400026)(1800799024)(36860700016)(376014)(921020)(22082099003)(18002099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	E5WNI2N6yqjTysDanMnPiHWMD2c48agkwoYXawezrasJl9Fv7jZ1PkVUxy9lmkDIl2pdDgarn1VcgCRrE5l7vIY3SmaXDogJ698nElBctrchuE/azC3dSix6x1S2/304KnY9Y0cxN26mhZoB9zZC/EgPLxPxipnYszQiO/eAuwJR7h/cCj0YjeIdkjQcfIea1Jc57WAWtVZduWUGzKoW5WLrbIL3eyVDcnUDqOrY6DbITkTTD48c+1H9c4p005EvFYHLbMG/OwfzUsHHgCUkq3t6rvjmLNE5C4SFPgAuGIC5TemSBkNK6WwSSD3/kITavM5iCIgSgjzLHrYJ3Xv+KIOg4ZxLxo3CybmRn6cEbbk5uW4fB3Yvd/BW8ByIlU97GQ6JYaOKwsWKCzfBH9Jqer8aoA2lXqNuO0D3lVJb296fhR7CkvDA/uBgi/fAiq+q
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Mar 2026 14:46:43.8427
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 459522b5-d1cc-4d65-e93b-08de8e6b2964
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000EE3D.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9023
X-Spamd-Result: default: False [1.34 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-9723-lists,dmaengine=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[14];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[kernel.org,gmail.com,nvidia.com,pengutronix.de,vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[akhilrajeev@nvidia.com,dmaengine@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[Nvidia.com:dkim,nvidia.com:email,nvidia.com:mid,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns];
	TAGGED_RCPT(0.00)[dmaengine,dt];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: C754C35D3ED
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Use 'iommu-map', when provided, to get the stream ID to be programmed
for each channel. Iterate over the channels registered and configure
each channel device separately using of_dma_configure_id() to allow
it to use a separate IOMMU domain for the transfer. However, do this
in a second loop since the first loop populates the DMA device channels
list and async_device_register() registers the channels. Both are
prerequisites for using the channel device in the next loop.

Channels will continue to use the same global stream ID if the
'iommu-map' property is not present in the device tree.

Signed-off-by: Akhil R <akhilrajeev@nvidia.com>
---
 drivers/dma/tegra186-gpc-dma.c | 57 ++++++++++++++++++++++++++++------
 1 file changed, 48 insertions(+), 9 deletions(-)

diff --git a/drivers/dma/tegra186-gpc-dma.c b/drivers/dma/tegra186-gpc-dma.c
index 9bea2ffb3b9e..64743d852dda 100644
--- a/drivers/dma/tegra186-gpc-dma.c
+++ b/drivers/dma/tegra186-gpc-dma.c
@@ -15,6 +15,7 @@
 #include <linux/module.h>
 #include <linux/of.h>
 #include <linux/of_dma.h>
+#include <linux/of_device.h>
 #include <linux/platform_device.h>
 #include <linux/reset.h>
 #include <linux/slab.h>
@@ -1380,9 +1381,13 @@ static int tegra_dma_program_sid(struct tegra_dma_channel *tdc, int stream_id)
 static int tegra_dma_probe(struct platform_device *pdev)
 {
 	const struct tegra_dma_chip_data *cdata = NULL;
+	struct tegra_dma_channel *tdc;
+	struct tegra_dma *tdma;
+	struct dma_chan *chan;
+	struct device *chdev;
+	bool use_iommu_map = false;
 	unsigned int i;
 	u32 stream_id;
-	struct tegra_dma *tdma;
 	int ret;
 
 	cdata = of_device_get_match_data(&pdev->dev);
@@ -1410,9 +1415,12 @@ static int tegra_dma_probe(struct platform_device *pdev)
 
 	tdma->dma_dev.dev = &pdev->dev;
 
-	if (!tegra_dev_iommu_get_stream_id(&pdev->dev, &stream_id)) {
-		dev_err(&pdev->dev, "Missing iommu stream-id\n");
-		return -EINVAL;
+	use_iommu_map = of_property_present(pdev->dev.of_node, "iommu-map");
+	if (!use_iommu_map) {
+		if (!tegra_dev_iommu_get_stream_id(&pdev->dev, &stream_id)) {
+			dev_err(&pdev->dev, "Missing iommu stream-id\n");
+			return -EINVAL;
+		}
 	}
 
 	ret = device_property_read_u32(&pdev->dev, "dma-channel-mask",
@@ -1424,9 +1432,10 @@ static int tegra_dma_probe(struct platform_device *pdev)
 		tdma->chan_mask = TEGRA_GPCDMA_DEFAULT_CHANNEL_MASK;
 	}
 
+	/* Initialize vchan for each channel and populate the channels list */
 	INIT_LIST_HEAD(&tdma->dma_dev.channels);
 	for (i = 0; i < cdata->nr_channels; i++) {
-		struct tegra_dma_channel *tdc = &tdma->channels[i];
+		tdc = &tdma->channels[i];
 
 		/* Check for channel mask */
 		if (!(tdma->chan_mask & BIT(i)))
@@ -1446,10 +1455,6 @@ static int tegra_dma_probe(struct platform_device *pdev)
 
 		vchan_init(&tdc->vc, &tdma->dma_dev);
 		tdc->vc.desc_free = tegra_dma_desc_free;
-
-		/* program stream-id for this channel */
-		tegra_dma_program_sid(tdc, stream_id);
-		tdc->stream_id = stream_id;
 	}
 
 	dma_set_mask_and_coherent(&pdev->dev, DMA_BIT_MASK(cdata->addr_bits));
@@ -1483,6 +1488,7 @@ static int tegra_dma_probe(struct platform_device *pdev)
 	tdma->dma_dev.device_synchronize = tegra_dma_chan_synchronize;
 	tdma->dma_dev.residue_granularity = DMA_RESIDUE_GRANULARITY_BURST;
 
+	/* Register the DMA device and the channels */
 	ret = dmaenginem_async_device_register(&tdma->dma_dev);
 	if (ret < 0) {
 		dev_err_probe(&pdev->dev, ret,
@@ -1490,6 +1496,39 @@ static int tegra_dma_probe(struct platform_device *pdev)
 		return ret;
 	}
 
+	/*
+	 * Configure stream ID for each channel from the channels registered
+	 * above. This is done in a separate iteration to ensure that only
+	 * the channels available and registered for the DMA device are used.
+	 */
+	list_for_each_entry(chan, &tdma->dma_dev.channels, device_node) {
+		chdev = &chan->dev->device;
+		tdc = to_tegra_dma_chan(chan);
+
+		if (use_iommu_map) {
+			chdev->bus = pdev->dev.bus;
+			dma_coerce_mask_and_coherent(chdev, DMA_BIT_MASK(cdata->addr_bits));
+
+			ret = of_dma_configure_id(chdev, pdev->dev.of_node,
+						  true, &tdc->id);
+			if (ret)
+				return dev_err_probe(chdev, ret,
+					   "Failed to configure IOMMU for channel %d", tdc->id);
+
+			if (!tegra_dev_iommu_get_stream_id(chdev, &stream_id)) {
+				dev_err(chdev, "Failed to get stream ID for channel %d\n",
+					tdc->id);
+				return -EINVAL;
+			}
+
+			chan->dev->chan_dma_dev = true;
+		}
+
+		/* program stream-id for this channel */
+		tegra_dma_program_sid(tdc, stream_id);
+		tdc->stream_id = stream_id;
+	}
+
 	ret = devm_of_dma_controller_register(&pdev->dev, pdev->dev.of_node,
 					      tegra_dma_of_xlate, tdma);
 	if (ret < 0) {
-- 
2.50.1


