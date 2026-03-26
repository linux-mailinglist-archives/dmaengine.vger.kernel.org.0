Return-Path: <dmaengine+bounces-9671-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uJF2NVcVxWnr6QQAu9opvQ
	(envelope-from <dmaengine+bounces-9671-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Thu, 26 Mar 2026 12:15:35 +0100
X-Original-To: lists+dmaengine@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F4713343A4
	for <lists+dmaengine@lfdr.de>; Thu, 26 Mar 2026 12:15:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 95AD5309B8C8
	for <lists+dmaengine@lfdr.de>; Thu, 26 Mar 2026 11:12:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA3D83E4C6E;
	Thu, 26 Mar 2026 11:11:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="qLGLE9Dz"
X-Original-To: dmaengine@vger.kernel.org
Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azon11012056.outbound.protection.outlook.com [40.107.209.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F7163DD51C;
	Thu, 26 Mar 2026 11:11:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.209.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774523501; cv=fail; b=YCdwVwDjXyuiqPWKHZVO1yUIRHosSy2T2HCJ3Bv57gTQU9qonzbr7x4/mJ6He4QijfAOdjPS1rjTjl0E4U+ASgQiaR5Fteq92E2l63g6h2WlZdE4BELkdel2eWdNAde7XNGpUXMItcAFrpz0oPPJXF/TbmbLPnW/GafIz6sMhWE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774523501; c=relaxed/simple;
	bh=vKfFT1YFEoKsG2GaJe44jH426z5cDH1KrQkccOXsMtI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gNPoBvOb1QKMDrwktZyEgsA4/LmVMTMSRBmudcbdGXJVDIzU7CmKXeuADCIUpGobobMpplYoz2bQpULH0z47BSYCPpSJzCd+Z0eq7mU91oT889xgjpTmBfPb/YIy7eLvcsAiORb/3Gfp6W3a1dh2qq6NsWJMOj+pV3GKYufKdsg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=qLGLE9Dz; arc=fail smtp.client-ip=40.107.209.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QK/egrNIZtkcmpfhHb+ojFjjHB1C5ZOEMaj7CtjBF7YKCgFG788zm6uY1nfWDXhJSL5UW24z4rMQZ53drykMcpg6auQ39T8R9me/lQHFF3ea/JU8A//QX14SHCC9d9NdfT4mfh8OIjIcx+rUapQkDtr47lRwaJNtoulhHYwZ60a505v3t5Kflq6k59F/K4qa19oHmz9GKlgc6ZBtZoC34bNTnJSD0TezYCglyis5Rdx43q4mWsJ3QLur8BlWmLzkv5WkRMdFGb6YW4G6L90NA79IumO4St0VNAsoBRhOy9yO2ikT3FYEy241d66X3fWVhDg3rj70A18B2kDLupKw6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zZMuVbfilvUkdYQ1T4/7OLMPVPQWnFNeX9D7L4R/Cbo=;
 b=gnGrpd1Uf7bKdYAJB30mQnV3XLyYbjJlKOVLbhIK1HMIrbjg6ewp0YQd1EDi/WbJZToFw6Lwe7faTUiC8HU4cvTWG+jar/P+FZQf5TEDd/qyGCdT6qXbJBBjbDRIsn+QBwsEFGa2uWr3k6y5ghwu16UdTRsk96E2l7dIfBJg1+OLX9HwCtBtkO1w6DeUHX7jS2sqW5f7bHYD76MdUa6JWZzWJ8vuiJqVRMs8nSsaXBEDIEeS3Ijdf1sDvbE6bFf9vVRihFtnPVTKQ1i0WFbfw7qsdMUSAsxkNtZrFER4tz3YV38k18PB71nHO1lsZ6+P9Rbx6x9qBnP9hZFTkPfYJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zZMuVbfilvUkdYQ1T4/7OLMPVPQWnFNeX9D7L4R/Cbo=;
 b=qLGLE9Dzcmd8gIVqPwwS1i6LiusBsuS9Q6mvAaU/Io7IMgVAHFfswIGZRoVTtUBH4aU6CjMtaJGGmnRUM2z5uTlW9L6Szz+8n6q+xNwx8mYdJRZlHdBynh9L6YMzQU2VUdX67wGPz1QhvlLSm25HggQhH+cNa6z0pWOIGEi3tCL1RpnoLKOXrAzWM2u3f9wW6rpGRXSo3sgjKS2iBGQWYlASwmtwbeNCiOs/fTnpoo46GPfMSAgTl+gd77d8HwBSlAE3uaTuSW0C2aL+NxDm2Y3Hd+wmy739eyfbJjoiwtmuT068bzQYAsHtCzuakP/vam5W9DAhmN2ADEelu4p62Q==
Received: from PH7P221CA0076.NAMP221.PROD.OUTLOOK.COM (2603:10b6:510:328::32)
 by CH1PPF12253E83C.namprd12.prod.outlook.com (2603:10b6:61f:fc00::606) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.8; Thu, 26 Mar
 2026 11:11:35 +0000
Received: from SN1PEPF000397B5.namprd05.prod.outlook.com
 (2603:10b6:510:328:cafe::4b) by PH7P221CA0076.outlook.office365.com
 (2603:10b6:510:328::32) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9745.22 via Frontend Transport; Thu,
 26 Mar 2026 11:11:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 SN1PEPF000397B5.mail.protection.outlook.com (10.167.248.59) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9745.21 via Frontend Transport; Thu, 26 Mar 2026 11:11:34 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 26 Mar
 2026 04:11:23 -0700
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Thu, 26 Mar 2026 04:11:23 -0700
Received: from BUILDSERVER-IO-L4T.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Thu, 26 Mar 2026 04:11:19 -0700
From: Akhil R <akhilrajeev@nvidia.com>
To: Vinod Koul <vkoul@kernel.org>, Frank Li <Frank.Li@kernel.org>, Rob Herring
	<robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
	<conor+dt@kernel.org>, Thierry Reding <thierry.reding@gmail.com>, "Jonathan
 Hunter" <jonathanh@nvidia.com>, Laxman Dewangan <ldewangan@nvidia.com>,
	Philipp Zabel <p.zabel@pengutronix.de>, <dmaengine@vger.kernel.org>,
	<devicetree@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
CC: Akhil R <akhilrajeev@nvidia.com>
Subject: [PATCH v4 08/10] dmaengine: tegra: Use iommu-map for stream ID
Date: Thu, 26 Mar 2026 16:39:45 +0530
Message-ID: <20260326110948.68908-9-akhilrajeev@nvidia.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260326110948.68908-1-akhilrajeev@nvidia.com>
References: <20260326110948.68908-1-akhilrajeev@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF000397B5:EE_|CH1PPF12253E83C:EE_
X-MS-Office365-Filtering-Correlation-Id: 51e97dcc-ca22-47ae-e307-08de8b28715a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|36860700016|7416014|376014|921020|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	Hg9mFpEDe1EgdbFgFT3s4h7Rjj1vSfzKXofl7yxMySC3Fs17n8ZO5cu0qwA9iDXvdc+emF1TuKh0OmK+kJvfxZOi1aP7DuRUKC7xL2poUP58ZZkt9G+lvaG3tV5DLlJlL1wuTLxEbQ3FnTHhOCGXfXYi8Kniyw7d3kZMbKyDkmlCTxBI6N3Mz/MsyOhRsUAr2JDBkhsNEG2gtWlV6esRr5BzH+yL2iEA6K0N9IajmyyrGBAHfLgZelQbrRDoZ+akaxse8MS65QZ2fOmAqrYHlW7gulbOufiWtEumvm16OV3NKFG0RbGYcKO8z21zs93EXVHPWWpDwW213P0HZ6420aSShgw9aT0EaNiXw6YOFFwKIzOnDR9WOsubQ8imWxaljLnIc6TMPRySQAdmo7qWr5fOiIVdKO+e6ePQkxg3YEcs4Q1OLnKPQj7ao/IrOO64rwYmQuA73lBewORUrgV0nXr+fi8B4RbqdFWCKXAtYYUFo6ytjm/ujrssqCybKDaidXsgytH81atvME9hxu1GPwxkY3H24lNI8LufGqo2mfvNkYrjRFWfk5oLoYDil5WWyLmFfNn+TD/xAQzV1nOKO9cKHDyRAKZuhkGDzNO7LvXH2R4QZVsOjOtucVXMnUJTIMW4iaesqVe+M1bYLBfYaxIVbGTj3+OaNrwe5E8n0ox7YBvuyuePVDVvCUqDDa+OavomhnN817W1ZRjTXRHEQAqEPLYyNRHiCPj472UpJkqc/gcM7DYXseOWg2TqFqnXYzjOI2gLZF1nXmay/mwN0asLcKi0MNtCciBr+qoRQ7oZatfX/nYervEtP7kAR1yt
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(36860700016)(7416014)(376014)(921020)(18002099003)(22082099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	xuwUoo0ui0CVViUZozaRDV9gZ/T/JD9tvhyaCWdKNlOjOWOcwDD7Ws7wiX4XXYn57pWsyhDWTJXWCdOt2VaYJhtzro4c4oUzkbqFZRkgRd7JZh0Ns09DjjGbD2v+nQC2KtyxRtvGKsc83Rzsr+7X/xcpM5GiGQtzocD2WmKr4pFx3ZULr4WxbOd3o8nLknnhBgWVNFUbogK6WG5Q8k4TQ2Thl2d5/c9ORVsM2k84PAGJgjcwxcUpIqkeMcd3yxBQY9Vx7Tho8uazSIVY3Ucslg/Os9darahcVnF3Q8xbaLcdrcLfziIjR4K0dQX3eYMXmAv6halxEC/6Mdy8FWMoGsdSii2QpKMTwv8KQUE8uJIMaqfm7dF6eFixyqosQ6GmyxToDNyrEqa4/nr4DUTGLF/7m+ehKty/2VNrHQSpxNvAfCttfnEK0v/Rc+1KfU91
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Mar 2026 11:11:34.8830
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 51e97dcc-ca22-47ae-e307-08de8b28715a
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF000397B5.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH1PPF12253E83C
X-Spamd-Result: default: False [1.34 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-9671-lists,dmaengine=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[Nvidia.com:dkim,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,nvidia.com:email,nvidia.com:mid];
	TAGGED_RCPT(0.00)[dmaengine,dt];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: 9F4713343A4
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


