Return-Path: <dmaengine+bounces-9123-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QP1iKG7Ln2nDdwQAu9opvQ
	(envelope-from <dmaengine+bounces-9123-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Thu, 26 Feb 2026 05:26:22 +0100
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D1CE1A0D6B
	for <lists+dmaengine@lfdr.de>; Thu, 26 Feb 2026 05:26:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2626E30530FB
	for <lists+dmaengine@lfdr.de>; Thu, 26 Feb 2026 04:26:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F022B389E1D;
	Thu, 26 Feb 2026 04:26:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="riUud2EM"
X-Original-To: dmaengine@vger.kernel.org
Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazon11012023.outbound.protection.outlook.com [40.93.195.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7025F3876B9;
	Thu, 26 Feb 2026 04:26:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.195.23
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772079977; cv=fail; b=QSibykqtxrkms0jmEMcMj4D6vNlDeiCLN8WxOY3+UxWvG/5nmu5gfZ2U3guvfiJeiQkPATcEZIckcW7Kc0/YO/A+x1w7XCQRyxWBDO84db58SENd3FGmWoBuu3vUvXr7k5sSUiZN+5NFykmXXg2Zuv8nlQ2CJKhgD42mdc1mKkk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772079977; c=relaxed/simple;
	bh=eFLMKFNewOrZSZJghNHfcWamL7iDC4V5a5yNIzzerCA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SIrWSDLC1SJdSrz8ZDhLqKjjSuCvUwC5i6SK7nDDtGpSPbCUKAL+qgKnJEXFEKzuSecJ60SZLiK19SmvJsOr3vWljH7jbCvjtbGl6/JE0o/JNVsjvNiG3xWaxJlQq+RX6/Nd8haeo/LGDSHWB34u4oD8mGJNpTqdwEBBGSjs3CQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=riUud2EM; arc=fail smtp.client-ip=40.93.195.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PLUpyvSbPZPlnpWygsTGIdX7F8Rl2/XaU0Ol9A09zxskfpEaxbe7Z1lHry56SqVRg3a1mVF1Es8QR9TFP1h+UbblrQhR2r+Mp8EQywlp82m9P8T6YShfvfLwO6wq2Jfpc5j8SaVjDEWpQlH3FSgDenEZoJH18196lZuWjQdq79ThLx61mwdlZE30xVZIc9C96ftMU8djGdFP1jOIYY4qicKSK5Dezsd+oTE25LNiKt7MDYcfviDyfffWOT+L76OVVo0dqc7PEbhwdKhMTTCcJQUVDtBHN7eRiGV/qWyVy8IBxi6lgJ5AA3gOQtkd0548P4jXGYT6DBgDAdlSiHucrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Hj/YcneALDAihNyDc6HbJGPYU3niOFioRafpN17mLgw=;
 b=S8NyKLStrR8RzVRhB/0Iee/Ni//kFZ/nUWq7CkPm8w7npZQgTFsqvwwrVqtp/O3rlu0UH1+3AvwkiQJTbYcXvrUzten309Ucz7XbXA2Sdf5iExG1ddhEipALYUbQf7IiKpBdObQZlK2c/68a3smygoHwETvV4wYozf4r4CsNkVF8UARy0t/fWciGhsOfA+r05w5uu2PwL0apOplTLqyaGRD26TI9gAmrN0d3Tt3nTFKbJjnPbq4ugtMfOqajKlB/9cAQ6uFePa61+tH9wns9w561sw7uJQlNs5axpXnmiy0vZsAW6gfm5rUdY73c7R+qfsCqPM9vkBwTgS7LYzM+Sw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Hj/YcneALDAihNyDc6HbJGPYU3niOFioRafpN17mLgw=;
 b=riUud2EM72eaePb2XWJXDDyMR2ESJzFQL81JKImf8IgMnHlI3TrcGk8evxd8bxwFzLM3tiIOGwcpshPJvbHc8mF47RZnL+R2UQAbwN4MLPD1usc92RgB2NaWGkAaHzYdGBsj7THlF8+oUo08b2wFLOAuKBRz5I4xy5qkbNKzlJ+SWlgZz2mL9c921QDecZFImo5U2fnUXGpYV12OWmwREs88yCoTndDyk5udLOy14RQmXrKueXJrt6JHHzytapPNbhkCmuEAcTWG3lZpVtQ4GWM2btqOO+V7S073uNaYizkC1GqxCR6CMk6puQWw5VxdaoZ7JQmX2vCW7H8xvm/11w==
Received: from BYAPR05CA0037.namprd05.prod.outlook.com (2603:10b6:a03:74::14)
 by IA1PR12MB6602.namprd12.prod.outlook.com (2603:10b6:208:3a2::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.11; Thu, 26 Feb
 2026 04:26:09 +0000
Received: from SJ1PEPF000026C7.namprd04.prod.outlook.com
 (2603:10b6:a03:74:cafe::50) by BYAPR05CA0037.outlook.office365.com
 (2603:10b6:a03:74::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9654.0 via Frontend Transport; Thu,
 26 Feb 2026 04:26:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 SJ1PEPF000026C7.mail.protection.outlook.com (10.167.244.104) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9632.12 via Frontend Transport; Thu, 26 Feb 2026 04:26:09 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 25 Feb
 2026 20:25:58 -0800
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Wed, 25 Feb 2026 20:25:57 -0800
Received: from BUILDSERVER-IO-L4T.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Wed, 25 Feb 2026 20:25:54 -0800
From: Akhil R <akhilrajeev@nvidia.com>
To: <jonathanh@nvidia.com>
CC: <Frank.Li@kernel.org>, <akhilrajeev@nvidia.com>, <conor+dt@kernel.org>,
	<devicetree@vger.kernel.org>, <dmaengine@vger.kernel.org>,
	<frank.li@nxp.com>, <krzk+dt@kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-tegra@vger.kernel.org>, <p.zabel@pengutronix.de>, <robh@kernel.org>,
	<thierry.reding@gmail.com>, <vkoul@kernel.org>
Subject: Re: [PATCH 6/8] dmaengine: tegra: Use iommu-map for stream ID
Date: Thu, 26 Feb 2026 09:55:52 +0530
Message-ID: <20260226042553.51940-1-akhilrajeev@nvidia.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <ffbcc3e4-d116-4b23-a584-0e9fc864461f@nvidia.com>
References: <ffbcc3e4-d116-4b23-a584-0e9fc864461f@nvidia.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000026C7:EE_|IA1PR12MB6602:EE_
X-MS-Office365-Filtering-Correlation-Id: f15a7603-4a26-4927-1466-08de74ef2a8c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|36860700013|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	4J2qytndZy5a54uGX0cGwRpiqChapPaglptIIJbueWSaNGF71oB7uCB9cmMIzUlv8AzT5QAXvo6lLr4IgpRBZuTbEI7RCAZkacPJj1fKcf8ixcjCd5ovveQEYP1wn9y1jBNj39v7O6WcgX4fiCiq8BUUBitV3CAEFv7i1mFpLvc50sTQg2IO07hOLoeJG9dbmjILX4rMu1AE+FGO9M3HzNqqcihN5tzZnZ3bP6oCeUsqaW7ZGPfR/G4Z7OlGCxdUFbkJeZutg9bUMMDzsHejl6pJ2xqZ0XYp7cN/36HxHkemVpD8M1jljlMiHaxUZX/UY+mVo1VdW+6e3/xyqaugErIYCj3uT1Em5FRSys06E9BiLVwDEgFd6WtYDtcf16Vjz3lHdorZLcS5jM8ORxa60v2t8FYTNPdenmsXQ2CNbmq3CehwopJAD1+tQrDqv5Ek24XMvRjfKrWIfTORxFp3HuApXizQp+q55xP1zOTDRPXY6pSLTcPqRFBuTMo8+wXTUBE0qVRvT+5M0GM6U3xkAV1GNiX+ZDcWjBIW9D+1IG4Lc7UAQHMDQXzy8NTqt7MHdovxx+1MYsIpzd8SZMEKpzm6YhBGDqhoDTq3WEk+z744ioKspizDlmm1SsKIk3CU0OVhmzHh4ADs1w150mXmt68KZRe1H6nNW2MJcsa8DvWi/l/IGM67MeWOGVVwcJY7oVyjTskFwsuWEwsuR3jkW9SSkx6W8iEbbcicuaYwNoJSu24sH4pE4TmJwYCtQunDetSp1f/FM3qkKnnldOw2GI91L+4GpCaObAJ3JtW7kh7+wi/xIW+lMKWO3fIE4T5otla5SgXqfX/JHT/tG8W5fQ==
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(36860700013)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	InXXOpn1jTFkmqes4+0gXxPFNAn4ppiGtVwpHiG6NXPM3cM6Pf3je1QL4KZz3KehoVqQ9FZ0QMrfoV2zhf21oIWgJTJGDrVfL6CjyimEESHY805pW2RWunHgFMxtll//lED4Vury84Oy433SGTYchTxLuVXm/JENuXzNKeYTo+sWzNTr41JPYJ91Iy3uYYvQCgppu1t9HM7YfmLHEBCFHrMbz1RW4U6FVnQ7SH3+0yvX6cHtffc4k1SyRvL0MOoiPJ9Dhv8WdiearU2afRv2uOE6vFrHwy+IiTcrw+kPpZGiqelJeMSo3KpZqwfclhFVLVSYL7IwCiHvuFYSXDsXeZuIlKOXzLLzGnLNpPp6m58P39Ujx5YJ/ZNhLrt5wwaPKg/ZgsxUabUWmvNpxDBh0nMuf0OJDp2+adVv/I1OJwyicc5Dg6TAbdlIwtmUOV0l
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Feb 2026 04:26:09.2689
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f15a7603-4a26-4927-1466-08de74ef2a8c
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF000026C7.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6602
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,nvidia.com,vger.kernel.org,nxp.com,pengutronix.de,gmail.com];
	TAGGED_FROM(0.00)[bounces-9123-lists,dmaengine=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[akhilrajeev@nvidia.com,dmaengine@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	TO_DN_NONE(0.00)[];
	NEURAL_HAM(-0.00)[-0.975];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nvidia.com:mid,nvidia.com:email,Nvidia.com:dkim];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[dmaengine,dt];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: 0D1CE1A0D6B
X-Rspamd-Action: no action

On Wed, 25 Feb 2026 11:23:08 +0000 Jon Hunter wrote:
> On 25/02/2026 10:27, Akhil R wrote:
>> On Tue, 24 Feb 2026 16:59:44 -0500 Frank Li wrote:
>>> On Tue, Feb 24, 2026 at 11:55:43AM +0530, Akhil R wrote:
>>>> On Tue, 17 Feb 2026 14:52:17 -0500, Frank Li wrote:
>>>>> On Tue, Feb 17, 2026 at 11:04:55PM +0530, Akhil R wrote:
>>>>>> Use iommu-map, when provided, to get the stream ID to be programmed
>>>>>> for each channel. Register each channel separately for allowing it
>>>>>> to use a separate IOMMU domain for the transfer.
>>>>>>
>>>>>> Channels will continue to use the same global stream ID if iommu-map
>>>>>> property is not present in the device tree.
>>>>>>
>>>>>> Signed-off-by: Akhil R <akhilrajeev@nvidia.com>
>>>>>> ---
>>>>>>   drivers/dma/tegra186-gpc-dma.c | 62 +++++++++++++++++++++++++++-------
>>>>>>   1 file changed, 49 insertions(+), 13 deletions(-)
>>>>>>
>>>>>> diff --git a/drivers/dma/tegra186-gpc-dma.c b/drivers/dma/tegra186-gpc-dma.c
>>>>>> index ce3b1dd52bb3..b8ca269fa3ba 100644
>>>>>> --- a/drivers/dma/tegra186-gpc-dma.c
>>>>>> +++ b/drivers/dma/tegra186-gpc-dma.c
>>>>>> @@ -15,6 +15,7 @@
>>>>>>   #include <linux/module.h>
>>>>>>   #include <linux/of.h>
>>>>>>   #include <linux/of_dma.h>
>>>>>> +#include <linux/of_device.h>
>>>>>>   #include <linux/platform_device.h>
>>>>>>   #include <linux/reset.h>
>>>>>>   #include <linux/slab.h>
>>>>>> @@ -1403,9 +1404,12 @@ static int tegra_dma_program_sid(struct tegra_dma_channel *tdc, int stream_id)
>>>>>>   static int tegra_dma_probe(struct platform_device *pdev)
>>>>>>   {
>>>>>>   	const struct tegra_dma_chip_data *cdata = NULL;
>>>>>> +	struct tegra_dma_channel *tdc;
>>>>>> +	struct tegra_dma *tdma;
>>>>>> +	struct dma_chan *chan;
>>>>>> +	bool use_iommu_map = false;
>>>>>>   	unsigned int i;
>>>>>>   	u32 stream_id;
>>>>>> -	struct tegra_dma *tdma;
>>>>>>   	int ret;
>>>>>>
>>>>>>   	cdata = of_device_get_match_data(&pdev->dev);
>>>>>> @@ -1433,9 +1437,12 @@ static int tegra_dma_probe(struct platform_device *pdev)
>>>>>>
>>>>>>   	tdma->dma_dev.dev = &pdev->dev;
>>>>>>
>>>>>> -	if (!tegra_dev_iommu_get_stream_id(&pdev->dev, &stream_id)) {
>>>>>> -		dev_err(&pdev->dev, "Missing iommu stream-id\n");
>>>>>> -		return -EINVAL;
>>>>>> +	use_iommu_map = of_property_present(pdev->dev.of_node, "iommu-map");
>>>>>> +	if (!use_iommu_map) {
>>>>>> +		if (!tegra_dev_iommu_get_stream_id(&pdev->dev, &stream_id)) {
>>>>>> +			dev_err(&pdev->dev, "Missing iommu stream-id\n");
>>>>>> +			return -EINVAL;
>>>>>> +		}
>>>>>>   	}
>>>>>>
>>>>>>   	ret = device_property_read_u32(&pdev->dev, "dma-channel-mask",
>>>>>> @@ -1449,7 +1456,7 @@ static int tegra_dma_probe(struct platform_device *pdev)
>>>>>>
>>>>>>   	INIT_LIST_HEAD(&tdma->dma_dev.channels);
>>>>>>   	for (i = 0; i < cdata->nr_channels; i++) {
>>>>>> -		struct tegra_dma_channel *tdc = &tdma->channels[i];
>>>>>> +		tdc = &tdma->channels[i];
>>>>>>
>>>>>>   		/* Check for channel mask */
>>>>>>   		if (!(tdma->chan_mask & BIT(i)))
>>>>>> @@ -1469,10 +1476,6 @@ static int tegra_dma_probe(struct platform_device *pdev)
>>>>>>
>>>>>>   		vchan_init(&tdc->vc, &tdma->dma_dev);
>>>>>>   		tdc->vc.desc_free = tegra_dma_desc_free;
>>>>>> -
>>>>>> -		/* program stream-id for this channel */
>>>>>> -		tegra_dma_program_sid(tdc, stream_id);
>>>>>> -		tdc->stream_id = stream_id;
>>>>>>   	}
>>>>>>
>>>>>>   	ret = dma_set_mask_and_coherent(&pdev->dev, DMA_BIT_MASK(cdata->addr_bits));
>>>>>> @@ -1517,20 +1520,53 @@ static int tegra_dma_probe(struct platform_device *pdev)
>>>>>>   		return ret;
>>>>>>   	}
>>>>>>
>>>>>> +	list_for_each_entry(chan, &tdma->dma_dev.channels, device_node) {
>>>>>> +		struct device *chdev = &chan->dev->device;
>>>>>>
>>>>> why no use
>>>>> 	for (i = 0; i < cdata->nr_channels; i++) {
>>>>> 		struct tegra_dma_channel *tdc = &tdma->channels[i];
>>>>
>>>> I thought this would ensure that we try to configure only the channels
>>>> where the chan_dev and vchan are initialized. I understand that it is
>>>> not probable in the current implementation that we will have channels
>>>> which are uninitialized, but I felt this a better approach.
>>>> Do you see any disadvantage in using the channels list?
>>>
>>> not big issue, just strange, previous code use
>>> for (i = 0; i < cdata->nr_channels; i++) {
>>> }
>>>
>>> why need enumerate it again and use difference method.
>> 
>> I think we will not get to use chan->dev->device before
>> async_device_register() and thats why I added a separate loop to
>> configure the channels.
> 
> I assume that this needs to be done after the async_device_register()? 
> If so we should note that in the commit message to explain that we need 
> a 2nd loop. Unless we can move the 1st loop after the 
> async_device_register() and just have one loop?

dma_dev.channels is populated by vchan_init(). So, the first loop must
exist before async_device_register(). If we have to restrict to one loop,
we would need to use dma_async_device_channel_register() to register the
channels within this driver directly. I feel having a second loop is
better than trying to restrict it to one.

> 
>> I can add a comment on why we need this loop. Do you suggest
>> changing it to a for-loop itself? Let me know your thoughts.
> 
> If using the list avoids the following check, then probably good to keep 
> as is, but yes explain why we do it this way.
> 
>   /* Check for channel mask */
>   if (!(tdma->chan_mask & BIT(i)))
>           continue;

Yes. Using dma_dev.channels avoids the above check. I will describe this
better in the commit message and as comments.

Regards,
Akhil

