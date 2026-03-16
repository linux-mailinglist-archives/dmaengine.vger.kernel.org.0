Return-Path: <dmaengine+bounces-9448-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OCb/FfA9uGmpagEAu9opvQ
	(envelope-from <dmaengine+bounces-9448-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Mon, 16 Mar 2026 18:29:20 +0100
X-Original-To: lists+dmaengine@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BDCDF29E3A3
	for <lists+dmaengine@lfdr.de>; Mon, 16 Mar 2026 18:29:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id BD75630B2A0D
	for <lists+dmaengine@lfdr.de>; Mon, 16 Mar 2026 17:21:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 391C63D3D04;
	Mon, 16 Mar 2026 17:20:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="dEF7pcd0"
X-Original-To: dmaengine@vger.kernel.org
Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11013017.outbound.protection.outlook.com [40.93.196.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C224D3D091C;
	Mon, 16 Mar 2026 17:20:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.196.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773681641; cv=fail; b=nJAG+hCnH5Afh0sf3AjBC+6SW4/dGzacH3eyuJmjGeOt7H3/+8gohVW6YN/WlWyrrdH8JLEd9lUEAvDsuqoPnkv0/vUDPqrwxCDe5gzl8gER2eZGMiBy7/DQVSfPLJEm8kZWsMREVjcQJEi2YPZ4ImRvrMmFPGMRJFP8cQkXPxI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773681641; c=relaxed/simple;
	bh=vKfFT1YFEoKsG2GaJe44jH426z5cDH1KrQkccOXsMtI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Uk3N5VCH22sYthoHvm4pgI5NUoJRSdY/z/2chR36ArkPT0QUMXYidI2E8BQy9f7FMIwmBm/G1us+5/s5Djd3n6L8lkABXLSWh+JNXKooQwwL4da0cicqhQyEdK+31ZUDj1+jF4p+oTEg8BXtVpTxXpT2+Z1bpFEUoH5IKcEVJRw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=dEF7pcd0; arc=fail smtp.client-ip=40.93.196.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iAQBLl73K7A3/MhyfWvJWEmmr2eaKThUK34Hbo0E2lt289jirK2280bfM5XltyNWE8K9tYxzxt0tz/EBf0EtQfT73YZ4MUi0E5pyknruaylwE0leV9Rn2rApBM8SpohUPoq8ZE+/S2trevuV2XszLAgB+iCgf7fa2U7AYGHv1xi4cYibhr6Dv5iiBkA2j2zSPfGsgNlhfPLqxlVwIHbNvo75YR/ZlE70oJS40bW6o0dIm9FCvK68QVDUArIGlIhUxpFuNFJoZtc+hKqp+MjqbkpDoqynYkoFxBDiBRGqBtDtd5rvbdZjVQcZJFuisWCsK6wzC5P5YzoBPAFRQMVf0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zZMuVbfilvUkdYQ1T4/7OLMPVPQWnFNeX9D7L4R/Cbo=;
 b=b5X3Lx+xSy10UQuzCi07WVNse9pd1eApQ2O081Q7oDlP4hchi68t43tyo0/OJGmLUGhJLqYiTNuQlw6yUvZaByk3kT1eWA1e+SrqDAFhsbP60UK2PwamSDe8WLxk4omXHL/rrybv7I9/Y9wD2ZQp3KGXgsine0v6o+OzAD0rkr+ms8aTKEnIUytV65Rw50nRh1R3XCP2IQTTXwbFCXd+zKiNmXLp1fYDkUlzoL848HAMVvvZjqhni6ONvGzKQteXyGn09uqaLxEvfJIS8MqakzV8kYj3FLFnGHmj3cZbanOsjmIvcwHQ26B0XxYwCh3wvnVAB43A3WF6IhGPHz8kHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zZMuVbfilvUkdYQ1T4/7OLMPVPQWnFNeX9D7L4R/Cbo=;
 b=dEF7pcd0vmhVRo35kuI+T3sbjkWgvZaOavM/VprIjbeFEiMPMuPpljq6eNbqJ7jJIGmdrx8soPc15HnA3IsEUzGMOceXjYpdR1Zj6yb56MX5IVwf+sxfhoEe1uiN3By6Azb2H8XCwb0HWrxpUFV5JtfjjXXTga7qPTp/pd8YHo3FFiYgVJPYJbP8edaUWiJBaqjgGTmh+QPpoXFAYo33PB6P3pC60r4Sg2sVn7TjhGtY/HGjTgNbUoJIlmr8LpcBAC0a0DnP02zipmqXCusXgW2Bq1uoq/cZCRAuO5lbDmhVJ7l8XGvXE58qIbiucfFL11X7U9bLjM6SsphWHIw7Dw==
Received: from SN7PR04CA0206.namprd04.prod.outlook.com (2603:10b6:806:126::31)
 by IA0PR12MB7650.namprd12.prod.outlook.com (2603:10b6:208:436::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.17; Mon, 16 Mar
 2026 17:20:33 +0000
Received: from SN1PEPF0002636D.namprd02.prod.outlook.com
 (2603:10b6:806:126:cafe::b9) by SN7PR04CA0206.outlook.office365.com
 (2603:10b6:806:126::31) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9700.24 via Frontend Transport; Mon,
 16 Mar 2026 17:20:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 SN1PEPF0002636D.mail.protection.outlook.com (10.167.241.138) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9700.17 via Frontend Transport; Mon, 16 Mar 2026 17:20:33 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 16 Mar
 2026 10:20:16 -0700
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Mon, 16 Mar 2026 10:20:16 -0700
Received: from BUILDSERVER-IO-L4T.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Mon, 16 Mar 2026 10:20:12 -0700
From: Akhil R <akhilrajeev@nvidia.com>
To: Vinod Koul <vkoul@kernel.org>, Frank Li <Frank.Li@kernel.org>, Rob Herring
	<robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
	<conor+dt@kernel.org>, Thierry Reding <thierry.reding@kernel.org>, "Jonathan
 Hunter" <jonathanh@nvidia.com>, Laxman Dewangan <ldewangan@nvidia.com>,
	Philipp Zabel <p.zabel@pengutronix.de>, <dmaengine@vger.kernel.org>,
	<devicetree@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
CC: Akhil R <akhilrajeev@nvidia.com>
Subject: [PATCH v3 7/9] dmaengine: tegra: Use iommu-map for stream ID
Date: Mon, 16 Mar 2026 22:48:21 +0530
Message-ID: <20260316171823.61800-8-akhilrajeev@nvidia.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260316171823.61800-1-akhilrajeev@nvidia.com>
References: <20260316171823.61800-1-akhilrajeev@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF0002636D:EE_|IA0PR12MB7650:EE_
X-MS-Office365-Filtering-Correlation-Id: 46ead033-f376-45af-7262-08de838054ac
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|1800799024|82310400026|36860700016|921020|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	qD/IFNsJZiE5H7bmADBsqwNFpsCr12jnEBOWjxNYiy01MKLBR7eQISR98/MgVL7goy560p1WseaB5EtJvD2M+nxvsteUyHJxFUCgFUoeBeUU/pMDME7Sd9sDk8094LLBZkO5Z1t53cNdKVxG1Qmi1sBpURijsYPGwGGV5mwhqzQRXYMhHpjO84JeNIjZNZPDQqU6iP6TqKyksfw5z79nakjucN6W152vGaaT9Lj3c2mgGj37NEVFCpy3HkPrgxkphizdcYXzQyyZ7s5nH5BRvpWlT6kfS3XvoHHNfYZi30/CVG4LMx2u24psmijyz4GjPAeA96l+zBkb5hxqneJhKFEwvK9U/8QRDYVvjxz2P5pI4WaL9mn6J77Jtj6qtFJYSa77gyrLR4Ss4fcUJNoJlFcSmGIiwpRsGO3/QWwrv8cwI3cd6NFN6DrWttUJCrysTRtQiS6bOEau/JEKJ23CD3vIXUDycOYU0a2HIlwVTDB+EBuaYmjwfuWLS9U0fPJLhjqoNcf/X1dx5pNUVwwDZaCNGE7jfLpVn6yNFYtmuE7yjPUCeQ7d7WAlIMwjtTJU4tbCfLo+ADGGu/TSOEdePZQUmB5+knT1/mvrZDe8nCUJDuweOrzAcmi7zvzVc02tyOamOtADzWAW9byOX2oHu9UCyWU9QM8csdZnsunOV5jYIhOEQFnuBVu7bS4UDTwZwZPefymKZYI5dMyZzmJBZphG01FaS9ts7DJjHyYIM+a2nC1ebb+EX43RR6LDdgLnZu3iQMMB0kE6FVBIJaSWxJ++sQoFGtotsgU6w21PdImpXFZ7i/EBrkrR+lK25bJ2
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(82310400026)(36860700016)(921020)(22082099003)(18002099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	J4sE+3HIAqtNM2oDy/qGcjfs3JTi95zWzCJfSPPJefDyPAMk9gby1VH9Q++J0pk+tIVmeSvZuacwYFmUBv6gxrXb9Q+N3bCFr7BPKZEJJno0+SC/+bQvw4Hg8f8xvcLNkBugM/CxgzK29z4J0jyKLfeljndznTHQ7H43YtobmFyKtV+HY7C4mFUqoWxwo+/7Gsx9u66F1qXDvcCju0tF61GCGyq6VF9yvAh8tNcRsbR4gY5wBQcOMqA5iTNRJQPwfOf9NkuT9Y7CGgOO9QJSDdKWTR4d7+aKiFnxq/WESA9qZBhU+vLdltugpyYP4DI0+x0qu8QqnvT9z17zO5c3+4a8CJ3wQ0OxDlA0AkcwC6a1lRioZD5pJcq7cLuhzg5DFSXGAyoea1jsulYBemV4YXiUkX193usOd9B9LrN/Fif9sbTDXakQaaahB/G2Fmpn
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Mar 2026 17:20:33.1509
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 46ead033-f376-45af-7262-08de838054ac
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF0002636D.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7650
X-Spamd-Result: default: False [1.34 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	TAGGED_FROM(0.00)[bounces-9448-lists,dmaengine=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[akhilrajeev@nvidia.com,dmaengine@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[dmaengine,dt];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: BDCDF29E3A3
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Use 'iommu-map', when provided, to get the stream ID to be programmed
for each channel. Iterate over the channels registered and configure
each channel device separately using of_dma_configure_id() to allow
it to use a separate IOMMU domain for the transfer. But do this
in a second loop since the first loop populates the DMA device channels
list and async_device_register() registers the channels. Both are
prerequisites for using the channel device in the next loop.

Channels will continue to use the same global stream ID if the
'iommu-map' property is not present in the device tree.

Signed-off-by: Akhil R <akhilrajeev@nvidia.com>
---
 drivers/dma/tegra186-gpc-dma.c | 59 ++++++++++++++++++++++++++++------
 1 file changed, 50 insertions(+), 9 deletions(-)

diff --git a/drivers/dma/tegra186-gpc-dma.c b/drivers/dma/tegra186-gpc-dma.c
index 9bea2ffb3b9e..3b377f34be58 100644
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
@@ -1490,6 +1496,41 @@ static int tegra_dma_probe(struct platform_device *pdev)
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
+			if (ret) {
+				dev_err(chdev, "Failed to configure IOMMU for channel %d: %d\n",
+					tdc->id, ret);
+				return ret;
+			}
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


