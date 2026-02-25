Return-Path: <dmaengine+bounces-9059-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oIyaEE7PnmnwXQQAu9opvQ
	(envelope-from <dmaengine+bounces-9059-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Wed, 25 Feb 2026 11:30:38 +0100
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D7285195C6D
	for <lists+dmaengine@lfdr.de>; Wed, 25 Feb 2026 11:30:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AB0D83012E8F
	for <lists+dmaengine@lfdr.de>; Wed, 25 Feb 2026 10:28:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0CE8392830;
	Wed, 25 Feb 2026 10:28:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="hLD8MOUU"
X-Original-To: dmaengine@vger.kernel.org
Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazon11013013.outbound.protection.outlook.com [40.107.201.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D91B314B82;
	Wed, 25 Feb 2026 10:28:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.201.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772015293; cv=fail; b=Y4Vdx9lTfg0eRlGHfHDx2RlZJH36fg5AMn58E+vefzi3aq1k06dgpAXnRtSNjveK18C0Mwom/noKxZZEQYzp9j4JDeiWgIOJ5jDP8/TYLaOcMAsjblw4+0hEr3Vfsi6b6MBQ1BETjUaM4/ALxFmzQ68xcJZtDibTFxKEObNGsvg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772015293; c=relaxed/simple;
	bh=DKgx4mz1rDksxrnoDA+FL4iZTVu3sAEnVZ+bjt/HxdI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=D6ocfOemE4MQY/UZ27GN7tmKSqVbzP4SvQZhf8CyCO4afJ9UuJM5VxnnEhknKa2FTfc45IfIj3eMy8dKnLjSTuOWARfBRMmdX5XR9wS/u/DRFcyaFcdMjvSfg4hRY8Y1Ad8qfSxNcl3EUu3sm24b/nzWgC4bx5aznvvWzwJHAfM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=hLD8MOUU; arc=fail smtp.client-ip=40.107.201.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=T7e1/4AA4n4nUz7TOedUUq0+dHgrxeGvn2La/EXIGyelWDZdALPcuvB+iqhNXtU6zVEJs7hFQ8TgIchm5WEmH5XRLQqFBderKjld2yW8Y4XPhwQtQTnEAubyV6OT9S3DKKcTdFzg6XMsat4li5haZf590xuoQU+XnWBCnwNRziPKN8dFcCW6FDfQ1fhVFa/+wrqFUpdoUpmwGU902FQkRHdxj14BF8mnQWg/EsT7TTFIx1MnsoLVDRNb7DzuGvrLwFfd1tbtyjzjPLlMBabjeFmc1BhF9Z6dh2TSTr+qN0llK6vkYd7Wnb18GjV/Sb39bHOAM2n+PFnx7EyNil4mBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+RlnZ0khLHdYz6kRmIrGnk9PEznkXzCh8eOOQpvq/1w=;
 b=SQ5u0WLp9jl+XzvThYmCzWoMQNfWNaJe0+fPyFpRdOvXXbwVl/7XfxM1rsUyQS/Oos2btlFlSAsYDeeEb27WHjtQ09EJdQwNXxzFQcDgnATmXqT3bxwQhSmWaI3dSr8pG9sZzeJLwXWldt5+5bEm+0Z5jxCVgM6KRHDknWtQqVD3cNJjN1tk+8JuJEf/nM7EkjD4HvzBVF9X3+Tv+iSMyahoyvS4Uu7o7tPu3mqGDNeVrWPQEKUhnUO5nMDB63feCoftCM1FIvKJ2yWjDgxAJ+scMhJYfwUYcdG1RdOlPJHBwauoCM1yquxzV2qBTcbaao4JvQqZ0qt2O4wkuvaQWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=nxp.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+RlnZ0khLHdYz6kRmIrGnk9PEznkXzCh8eOOQpvq/1w=;
 b=hLD8MOUUnbnOEn1fvPLB/Rx7iBUpzt3oNFHBVSyqKnw++wIiH8Cla0pXw+UgKXtvyW0vKgoD/HPLc7aEuBEx6hqWYpfa2WPqseym2BnP6WGCKCM6dVvV4uatHUqTrOUgpGy9OX9uC9qfCcsOeBy5O+ByuN1zVInQw0YIeNkroh+sSyTHq2nDrprB9wclkvok2RojTA1/AvE59e09LnXMLLHbvlre5N2FcwWJk2uELMtTjX16e4p0ag7UIB5A5W8A/oGzj5lqoDVMz8UV3+YlMIQyLVcIRw7oTnUbzBOcYvEQc8jEjsC0EKgIuC65EdaTy0Rv9xcNUWwJ9UqQKs78ug==
Received: from SJ2PR07CA0014.namprd07.prod.outlook.com (2603:10b6:a03:505::7)
 by BL3PR12MB6428.namprd12.prod.outlook.com (2603:10b6:208:3b7::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.22; Wed, 25 Feb
 2026 10:28:06 +0000
Received: from SJ1PEPF00001CE5.namprd03.prod.outlook.com
 (2603:10b6:a03:505:cafe::16) by SJ2PR07CA0014.outlook.office365.com
 (2603:10b6:a03:505::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9632.23 via Frontend Transport; Wed,
 25 Feb 2026 10:28:02 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SJ1PEPF00001CE5.mail.protection.outlook.com (10.167.242.21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9632.12 via Frontend Transport; Wed, 25 Feb 2026 10:28:06 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 25 Feb
 2026 02:27:51 -0800
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 25 Feb
 2026 02:27:50 -0800
Received: from BUILDSERVER-IO-L4T.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Wed, 25 Feb 2026 02:27:46 -0800
From: Akhil R <akhilrajeev@nvidia.com>
To: <frank.li@nxp.com>
CC: <Frank.Li@kernel.org>, <akhilrajeev@nvidia.com>, <conor+dt@kernel.org>,
	<devicetree@vger.kernel.org>, <dmaengine@vger.kernel.org>,
	<jonathanh@nvidia.com>, <krzk+dt@kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-tegra@vger.kernel.org>, <p.zabel@pengutronix.de>, <robh@kernel.org>,
	<thierry.reding@gmail.com>, <vkoul@kernel.org>
Subject: Re: [PATCH 6/8] dmaengine: tegra: Use iommu-map for stream ID
Date: Wed, 25 Feb 2026 15:57:45 +0530
Message-ID: <20260225102745.47876-1-akhilrajeev@nvidia.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <aZ4fUGYouVOlYdL7@lizhi-Precision-Tower-5810>
References: <aZ4fUGYouVOlYdL7@lizhi-Precision-Tower-5810>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CE5:EE_|BL3PR12MB6428:EE_
X-MS-Office365-Filtering-Correlation-Id: ac51ce40-5eed-497d-306b-08de745890a7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|36860700013|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	fnYKPf28Bmcj+ngPKjTum+wUAo7QCTv4AXusPC6wUQlnNdNBohPR5P9eLQhlIzb4JTmM9RAqKmi7oakI4PZsWFUWavpBhvlTCH2ItbPHkU+0GRIJuW84LWi0rB6RzEHE4IGYIt1HsBPub2+2ArvaG9t3CUmNYJdeSBMncOnj+eXBjCnIX9FwrHAq840NSUIhKYTC+/cjiiRsQNlwlIcLYH7g/GO1NRXJ5oQxQckNONzWh0MeefZ6ALKukIttggd3zpGFJfWmqdrgizKcIgmfURlPtjMedCYtumr3otkalJJepWchKwxpgwRnj/eoYImsUGMG7elG9jST1JZFFTKm4L7YnMh7Ghodl+1Tc9VcXZseFZSQ/hMpk3PXiK8N8AFLkLzcbFlxs66bNlsqam9bkTFz0II5gMo98M5B37WOC5A2ADDs9oeLbRNDixO2FqvYL1DmAHdabsjnN8JELG2smpAFY2I+VUo5/o8TxidD4ePP6FERZF4c+DHXOX/G9PMyxCWnxltxmPqwQtJej2pzETiJoGRiykL0HwvkQ7HuREfQ1POCYRSxmTnXYRkegOsyZKORBK5QxkCnhCY5rVhP8fOY9i0WdjsczaI5DI+Y7/rn06IgLHRcPoyCpGNnp/og0LoePgm8PyRlrF0KboZQ1XDWuRIaGfCI2EQW80PsCqfDBsTM8rKQR2WgZnwOB6CXi+cUjP54SOUXzIVbpmSnys/K//ubMGN0/+Ii9Re0TXqg49d14bZ2q5a3wuXxSMwK0gAdfynnvcUQd5e+NmYXTcthREy9aUZgJJiIgBMAWMhdHdlamquYyjX4HIycTF2Zwcie7iBUX3oBxzCLHloT+A==
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(36860700013)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	Ux2YsNC4N3kcieEj2ObepBSS8z4nab9izKRFkqbO1NtTQFBm1qb4IhR+9US8UF3LA0m5y59q9PnRjFfbIulr3cBytBT7K28SXgzYhmKbNKrBA3UHxKRT2WGLkruAV6ODvaKCuUinLrGKcrFfslnch8LoNQhvhV9V27fxQscqi6WpAVu/1J2S38dkJCWMLm2s/vl1BmEXlVUv1ev0bbFFzRI6NO3K+XMW9Ov2hls5D5gc0wck68crWbcAf6/wVY3cyvryb1iL7cRKOZ51/9CrRELD2Iex0g1ECz6qTiZJIkwF+nvsrVzQPREDQ3sAW55cVth2fb3OBW5sYFTERgNVjDUN5a4i5v/X9mVwfsGHcmqfYttiUrl1I0VbrjDmc1W7ytQ6pLlvvvRK3CfC+TCvt7Gc0zsfyfr8Vl5CWCaXnzML+baCQ/pp+sLXzWokSniO
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Feb 2026 10:28:06.5702
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ac51ce40-5eed-497d-306b-08de745890a7
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00001CE5.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB6428
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
	FREEMAIL_CC(0.00)[kernel.org,nvidia.com,vger.kernel.org,pengutronix.de,gmail.com];
	TAGGED_FROM(0.00)[bounces-9059-lists,dmaengine=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[akhilrajeev@nvidia.com,dmaengine@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	TO_DN_NONE(0.00)[];
	NEURAL_HAM(-0.00)[-0.976];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,nvidia.com:mid,nvidia.com:email,Nvidia.com:dkim];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[dmaengine,dt];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: D7285195C6D
X-Rspamd-Action: no action

On Tue, 24 Feb 2026 16:59:44 -0500 Frank Li wrote:
> On Tue, Feb 24, 2026 at 11:55:43AM +0530, Akhil R wrote:
>> On Tue, 17 Feb 2026 14:52:17 -0500, Frank Li wrote:
>>> On Tue, Feb 17, 2026 at 11:04:55PM +0530, Akhil R wrote:
>>>> Use iommu-map, when provided, to get the stream ID to be programmed
>>>> for each channel. Register each channel separately for allowing it
>>>> to use a separate IOMMU domain for the transfer.
>>>>
>>>> Channels will continue to use the same global stream ID if iommu-map
>>>> property is not present in the device tree.
>>>>
>>>> Signed-off-by: Akhil R <akhilrajeev@nvidia.com>
>>>> ---
>>>>  drivers/dma/tegra186-gpc-dma.c | 62 +++++++++++++++++++++++++++-------
>>>>  1 file changed, 49 insertions(+), 13 deletions(-)
>>>>
>>>> diff --git a/drivers/dma/tegra186-gpc-dma.c b/drivers/dma/tegra186-gpc-dma.c
>>>> index ce3b1dd52bb3..b8ca269fa3ba 100644
>>>> --- a/drivers/dma/tegra186-gpc-dma.c
>>>> +++ b/drivers/dma/tegra186-gpc-dma.c
>>>> @@ -15,6 +15,7 @@
>>>>  #include <linux/module.h>
>>>>  #include <linux/of.h>
>>>>  #include <linux/of_dma.h>
>>>> +#include <linux/of_device.h>
>>>>  #include <linux/platform_device.h>
>>>>  #include <linux/reset.h>
>>>>  #include <linux/slab.h>
>>>> @@ -1403,9 +1404,12 @@ static int tegra_dma_program_sid(struct tegra_dma_channel *tdc, int stream_id)
>>>>  static int tegra_dma_probe(struct platform_device *pdev)
>>>>  {
>>>>  	const struct tegra_dma_chip_data *cdata = NULL;
>>>> +	struct tegra_dma_channel *tdc;
>>>> +	struct tegra_dma *tdma;
>>>> +	struct dma_chan *chan;
>>>> +	bool use_iommu_map = false;
>>>>  	unsigned int i;
>>>>  	u32 stream_id;
>>>> -	struct tegra_dma *tdma;
>>>>  	int ret;
>>>>
>>>>  	cdata = of_device_get_match_data(&pdev->dev);
>>>> @@ -1433,9 +1437,12 @@ static int tegra_dma_probe(struct platform_device *pdev)
>>>>
>>>>  	tdma->dma_dev.dev = &pdev->dev;
>>>>
>>>> -	if (!tegra_dev_iommu_get_stream_id(&pdev->dev, &stream_id)) {
>>>> -		dev_err(&pdev->dev, "Missing iommu stream-id\n");
>>>> -		return -EINVAL;
>>>> +	use_iommu_map = of_property_present(pdev->dev.of_node, "iommu-map");
>>>> +	if (!use_iommu_map) {
>>>> +		if (!tegra_dev_iommu_get_stream_id(&pdev->dev, &stream_id)) {
>>>> +			dev_err(&pdev->dev, "Missing iommu stream-id\n");
>>>> +			return -EINVAL;
>>>> +		}
>>>>  	}
>>>>
>>>>  	ret = device_property_read_u32(&pdev->dev, "dma-channel-mask",
>>>> @@ -1449,7 +1456,7 @@ static int tegra_dma_probe(struct platform_device *pdev)
>>>>
>>>>  	INIT_LIST_HEAD(&tdma->dma_dev.channels);
>>>>  	for (i = 0; i < cdata->nr_channels; i++) {
>>>> -		struct tegra_dma_channel *tdc = &tdma->channels[i];
>>>> +		tdc = &tdma->channels[i];
>>>>
>>>>  		/* Check for channel mask */
>>>>  		if (!(tdma->chan_mask & BIT(i)))
>>>> @@ -1469,10 +1476,6 @@ static int tegra_dma_probe(struct platform_device *pdev)
>>>>
>>>>  		vchan_init(&tdc->vc, &tdma->dma_dev);
>>>>  		tdc->vc.desc_free = tegra_dma_desc_free;
>>>> -
>>>> -		/* program stream-id for this channel */
>>>> -		tegra_dma_program_sid(tdc, stream_id);
>>>> -		tdc->stream_id = stream_id;
>>>>  	}
>>>>
>>>>  	ret = dma_set_mask_and_coherent(&pdev->dev, DMA_BIT_MASK(cdata->addr_bits));
>>>> @@ -1517,20 +1520,53 @@ static int tegra_dma_probe(struct platform_device *pdev)
>>>>  		return ret;
>>>>  	}
>>>>
>>>> +	list_for_each_entry(chan, &tdma->dma_dev.channels, device_node) {
>>>> +		struct device *chdev = &chan->dev->device;
>>>>
>>> why no use
>>> 	for (i = 0; i < cdata->nr_channels; i++) {
>>> 		struct tegra_dma_channel *tdc = &tdma->channels[i];
>>
>> I thought this would ensure that we try to configure only the channels
>> where the chan_dev and vchan are initialized. I understand that it is
>> not probable in the current implementation that we will have channels
>> which are uninitialized, but I felt this a better approach.
>> Do you see any disadvantage in using the channels list?
> 
> not big issue, just strange, previous code use
> for (i = 0; i < cdata->nr_channels; i++) {
> }
> 
> why need enumerate it again and use difference method.

I think we will not get to use chan->dev->device before
async_device_register() and thats why I added a separate loop to
configure the channels.

I can add a comment on why we need this loop. Do you suggest
changing it to a for-loop itself? Let me know your thoughts.

Regards,
Akhil

