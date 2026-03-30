Return-Path: <dmaengine+bounces-9743-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MKINByu/ymk//wUAu9opvQ
	(envelope-from <dmaengine+bounces-9743-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Mon, 30 Mar 2026 20:21:31 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id BB32635FB38
	for <lists+dmaengine@lfdr.de>; Mon, 30 Mar 2026 20:21:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id C2D403015137
	for <lists+dmaengine@lfdr.de>; Mon, 30 Mar 2026 18:21:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70C8E3914E4;
	Mon, 30 Mar 2026 18:21:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="NhwhXCGH"
X-Original-To: dmaengine@vger.kernel.org
Received: from CH5PR02CU005.outbound.protection.outlook.com (mail-northcentralusazon11012067.outbound.protection.outlook.com [40.107.200.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F2F1366056;
	Mon, 30 Mar 2026 18:21:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.200.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774894888; cv=fail; b=DtYX/1YLGB3OHQ6MSG+GoiQHfY56uOlKKeqYwx/5qjIW9SZu+H1cnzOKCIXRCI56w8jzELJDqYlyXpFjumDNKv6eQcvEAgBNgoX2WAashAE6DuGloNJ2nkGNZsZNWLasOlbQFK1c5wIGUs0pPG+UtWp3pTIfGo/3blVSTLopAjQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774894888; c=relaxed/simple;
	bh=9HU86VXCIrZZYcJNmKJlW+8/PuzBuRlJHww4XljRRHc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FczZmY5gmKmHBxMoqmEzI1mchs7SDDlDJBp8d4jMz1oG+p1lkEoOpmdQzaCzK0xfcsItS50H6YcW9ywubfk8j5m5AJjjNV2BjmStoNrJcen+K1a+W8FNu3Pd36g2weRiQQwHPmROTZSQKh2eRfUlHEyeC5JFLNAfzFC6jla0uR8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=NhwhXCGH; arc=fail smtp.client-ip=40.107.200.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fy26l5du4ngPPoT/piofaCzhvh5NDTS8/LN9FwnVCsPKoGvxI/gtAsWn5JApkQkOXiGZxn5HOsTk5Jx/kyQ2/tshFGmO5yyvI/UDR91Brras1EM5y2X8lOxkYN6kWo3ht5Elb1TzXBPjnNcQsIwAO3JDFL3MbCW68EylyZLGz7vhbB4DmA8UEbJOHcGgKH5OrAoLWBfVhB7nA37k1ifvBQrZdK9A1s2PjRMn/LigDatElJmZLqhDgefYa+lemVbBFfYH5ZHHUOlj1R24l7uNVU7NEsPsmVsoViHrcvzzd28+CnhKO3Z8n5mCVbFsRqPOMf6F4ukmI4a4ukrJpo5doQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xSf4ih6uJJe8xsQ/3BQ81A+mUFgv0ZjeoNwigjL6FgA=;
 b=KnkUTx13DmM87IqsJMaMsUrQAE3lfZq/Asx0tTE1q1wXy038XHIItK9/9KwEzd/rSUmYoQ1hSPOzcV48V/8hQ6g4XgcVgbpMKy12RetESfbgb3yt/Hd74yC+kfeLglDmVifyON2p+CgJF4TOEYDXzT3g/Nl4kAjXddx6el+KTysyjPy6DVyUVx0pa8kFW7VEwA9dHwuSGC5bADfSSbpgOX2XH9vdNpWtj5nxYPgPP+gBvM2+RyazgcAkLIlt+ukFqiyTlt0MxEHUILbQJl3gypYqM3XtQlDo8yCKzYW/jdy9eeCYSUBLqiXEkrpjlVJqhBPuXyuMuznxrGQGAio8hQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=nxp.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xSf4ih6uJJe8xsQ/3BQ81A+mUFgv0ZjeoNwigjL6FgA=;
 b=NhwhXCGHxxxPMqI+YS8tR+Bj3FhKLk6AO+ncZoXm15iS3XPCfJvdnbwx0L0jolN8IBAliHqbEdTZzIgB5C1dJUwmoc046vVA7rMxWPTVrEm0krOmax6CQ8RHoUWTfi6Sa0mxhLST/LAkP7ppFBpkRCb0Z615r5ZkY+bfj9It3Ts77n5FwtBIW4NO/jX9wq0mI7wSb1g9awVEHkAreiJi2P0LpcDm/UL5KGflupBJb7m5FnTrocXisrAiO3upXBG77y5q/DX90ZKGFZGSi3qqg5NGcJOkHqelyP4+fjnQ80mw1Qbc60Qm5T9IJ2OKjnRly42Lf/HQTwaYNue22JMV5g==
Received: from MW4PR04CA0150.namprd04.prod.outlook.com (2603:10b6:303:84::35)
 by SN7PR12MB6791.namprd12.prod.outlook.com (2603:10b6:806:268::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.14; Mon, 30 Mar
 2026 18:21:13 +0000
Received: from CO1PEPF00012E83.namprd03.prod.outlook.com
 (2603:10b6:303:84:cafe::28) by MW4PR04CA0150.outlook.office365.com
 (2603:10b6:303:84::35) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9745.28 via Frontend Transport; Mon,
 30 Mar 2026 18:21:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 CO1PEPF00012E83.mail.protection.outlook.com (10.167.249.58) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9745.21 via Frontend Transport; Mon, 30 Mar 2026 18:21:13 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 30 Mar
 2026 11:20:45 -0700
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Mon, 30 Mar 2026 11:20:44 -0700
Received: from BUILDSERVER-IO-L4T.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Mon, 30 Mar 2026 11:20:41 -0700
From: Akhil R <akhilrajeev@nvidia.com>
To: <frank.li@nxp.com>
CC: <Frank.Li@kernel.org>, <akhilrajeev@nvidia.com>, <conor+dt@kernel.org>,
	<devicetree@vger.kernel.org>, <dmaengine@vger.kernel.org>,
	<jonathanh@nvidia.com>, <krzk+dt@kernel.org>, <ldewangan@nvidia.com>,
	<linux-kernel@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
	<p.zabel@pengutronix.de>, <robh@kernel.org>, <thierry.reding@gmail.com>,
	<vkoul@kernel.org>
Subject: Re: [PATCH v5 08/10] dmaengine: tegra: Use iommu-map for stream ID
Date: Mon, 30 Mar 2026 23:50:40 +0530
Message-ID: <20260330182040.33366-1-akhilrajeev@nvidia.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <acq9z3-lqBHY78v3@lizhi-Precision-Tower-5810>
References: <acq9z3-lqBHY78v3@lizhi-Precision-Tower-5810>
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
X-MS-TrafficTypeDiagnostic: CO1PEPF00012E83:EE_|SN7PR12MB6791:EE_
X-MS-Office365-Filtering-Correlation-Id: 345156b4-d240-4401-0549-08de8e892016
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|7416014|376014|36860700016|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	oJr4hDHHTg+BJyROjJ6FY769M1N6BQ7stXFRPIQA9szynx9GSnklmfv4P5TEuMsx+5gb5kuBW5jcfSQaKL6P3rWuBkJV/1S17F+zXIJXQhoHJu7mf30HIBzH2+t1xHdxaJYQIH6K/mo5kFE3jxZAOBrGUk0i+phbLGGNTm2Tt4VvnbFOqyYF7J52udFy08eKf8oDQV9qxbBNBlKALNp51tgyGnWyTySE5iMk71XTrzMncieklXl2OrJjpSQm5OfHfKqbKo1RfRfNQKs8wCjrP7SKHHsKdSl2n1lBsZGrByiGryDOKJdZEJLzLTwFO3zsrb73ygTqCxBshX9Z5WEdb0tnIM1tHd0wg5+FgEDcBFNRP+OoNURGPpnsCaBwlmdclwIDddXwOHfhLuHMzBaN9TcVlXt3RxuvjVLanvFix0HBdkYwBTPZr4OWUB+k0MJ+bwTtZKX8dLRx46+SnHha86OLZndXX0naiHddDgK76fTbSQD2JY6yr8O95Dd3eAiaYvLrLGEaT17kWuRDJF3SMiL5wKQmmLG2pumZRbBzJdV9mBhm/rq/Jh4Gr6YoV3wX7HXG+Vi8jWfGOC7YzO9Fi/p55QUVdyTTpWOE24ixbhJTIYL8SGFv9eSz/LhFvGIrO0NIlTi0VTVTyn1PrJkA2c49BFW2f3DhRRUyTqUZZ52sTsbrevbfnRRMmFKndawfsBRPgR7uvoWajGdwrOefMjFeIumpP9nP3UzY4UCZJT6kneX8bsaTdDsWBt45TH3QuXVH3c/x3usyW+O2WhwRoQ==
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(7416014)(376014)(36860700016)(56012099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	EprBGZxbzY1qKFJvc3Y3Krqh8/SGBIHdy0lTCeX+8BxSqVyxw42o8C3VnAz1OynzhJLM4k+Ij38ibxOKPDVB6834es4SaBmFoliZaycu/HlGE/o4ZvaViK/rt4redAP0HJkxQU/bc1KfDpSDglamgGL2fvQqYcC0QsZBYIau9vg4ICwDOrzbtrgdJ2KFflOv7rauVGGB9RJ+ePcwwPTCzPPhdEsM4dv+TKtAJii3g5uca4ibznVEFEiljkE2hcvPcHrydB0pq7OnOMVJJdAeN4mXxVvMbMgrQQGVjRYQIMoKSZJpG0jkMbRhFjrTsEkqKZFLek82JH4ql5PO8AUUEBMJFuWUb5EWiten6K4nof/sxy5CNRcCS9WUUn23YZoTv/f0IFvwe/+cqJkaVOFBKPyebr5YRzVVyv/eyVLCSAfVDgPzN0BQu9obvrsyxhqQ
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Mar 2026 18:21:13.2239
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 345156b4-d240-4401-0549-08de8e892016
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF00012E83.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6791
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,nvidia.com,vger.kernel.org,pengutronix.de,gmail.com];
	TAGGED_FROM(0.00)[bounces-9743-lists,dmaengine=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[akhilrajeev@nvidia.com,dmaengine@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	TO_DN_NONE(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TAGGED_RCPT(0.00)[dmaengine,dt];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: BB32635FB38
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, 30 Mar 2026 14:15:43 -0400, Frank Li wrote:
> On Mon, Mar 30, 2026 at 11:32:40PM +0530, Akhil R wrote:
>> On Mon, 30 Mar 2026 12:47:24 -0400, Frank Li wrote:
>> > On Mon, Mar 30, 2026 at 08:14:54PM +0530, Akhil R wrote:
>> >> Use 'iommu-map', when provided, to get the stream ID to be programmed
>> >> for each channel. Iterate over the channels registered and configure
>> >> each channel device separately using of_dma_configure_id() to allow
>> >> it to use a separate IOMMU domain for the transfer. However, do this
>> >> in a second loop since the first loop populates the DMA device channels
>> >> list and async_device_register() registers the channels. Both are
>> >> prerequisites for using the channel device in the next loop.
>> >>
>> >> Channels will continue to use the same global stream ID if the
>> >> 'iommu-map' property is not present in the device tree.
>> >>
>> >> Signed-off-by: Akhil R <akhilrajeev@nvidia.com>
>> >> ---
>> > ...
>> >>
>> >> +	/*
>> >> +	 * Configure stream ID for each channel from the channels registered
>> >> +	 * above. This is done in a separate iteration to ensure that only
>> >> +	 * the channels available and registered for the DMA device are used.
>> >> +	 */
>> >> +	list_for_each_entry(chan, &tdma->dma_dev.channels, device_node) {
>> >> +		chdev = &chan->dev->device;
>> >> +		tdc = to_tegra_dma_chan(chan);
>> >> +
>> >> +		if (use_iommu_map) {
>> >> +			chdev->bus = pdev->dev.bus;
>> >> +			dma_coerce_mask_and_coherent(chdev, DMA_BIT_MASK(cdata->addr_bits));
>> >> +
>> >> +			ret = of_dma_configure_id(chdev, pdev->dev.of_node,
>> >> +						  true, &tdc->id);
>> >> +			if (ret)
>> >> +				return dev_err_probe(chdev, ret,
>> >> +					   "Failed to configure IOMMU for channel %d", tdc->id);
>> >> +
>> >> +			if (!tegra_dev_iommu_get_stream_id(chdev, &stream_id)) {
>> >> +				dev_err(chdev, "Failed to get stream ID for channel %d\n",
>> >> +					tdc->id);
>> >> +				return -EINVAL;
>> >
>> > Can you check similar problem before post patch, here also can use
>> > 	return dev_err_probe()
>>
>> I did notice that, but I thought dev_err_probe is to handle -EPROBE_DEFER
>> and we do not use it when we return a fixed value. It returns -EINVAL here
>> directly.
> 
> even that, still can use return dev_err_probe(chddev, -EINVAL, ...) to
> short your code.

I just saw in the dev_err_probe() description that it is not limited to
-EPROBE_DEFER. Thanks for pointing. I will update the patch.
 
Best Regards,
Akhil

