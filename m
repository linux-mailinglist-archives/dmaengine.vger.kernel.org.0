Return-Path: <dmaengine+bounces-9741-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AISKD+u6ymmj/gUAu9opvQ
	(envelope-from <dmaengine+bounces-9741-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Mon, 30 Mar 2026 20:03:23 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9415435F92A
	for <lists+dmaengine@lfdr.de>; Mon, 30 Mar 2026 20:03:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DEA6530086E1
	for <lists+dmaengine@lfdr.de>; Mon, 30 Mar 2026 18:03:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 637F036D506;
	Mon, 30 Mar 2026 18:03:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="SatvRZvs"
X-Original-To: dmaengine@vger.kernel.org
Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azon11010015.outbound.protection.outlook.com [52.101.46.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FEE128DC4;
	Mon, 30 Mar 2026 18:03:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.46.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774893795; cv=fail; b=H2PSz11MisZppdwe8X7c1v8p6zNcZozsWjBCOKTK64hsYCYBksuTQ82k5CRZTydgu1OFoqLaPXWwEZpcEKnhaUOv34FnbP4ZLY+dy/2Z5F/2wkn6Cvfvna+VH1yLIZ4s7pwCM74WbR5xCNyBTsbX6KOqVcEtw0ExoOMEzvKFf1o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774893795; c=relaxed/simple;
	bh=0l2Cl2mTmHC+EKblfMh1xEenI17S1JNVGrl4U+J3+0o=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JoOridqDD/UnNec1cfJ5N4nzFw0Qjkw8dyOfv7xQsXPitl5qtKN2TCOEnWsUAPXxlbO00xHqTGfr8p+aLm1uPsTD+F0tiqKOltwmKpA1avK9i/8qiYrNh0E7M7COlTYCE20g2oXJxLGRzJu/cIcwmZGCwz73UUFRGb4cQUOEMk8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=SatvRZvs; arc=fail smtp.client-ip=52.101.46.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UImzNPMKMn0gyltC6dmpthcbGxcJGjme+eZrbpuVs96j9RyIo/DsKthI/1lrfUq9CqdNXrOXM0zM6HeZu46FL5neLHJraykzjtkW3Edcp99h/7aFi6UBCMryPeNEAsftRXCNIoPOu3DUFXFCmhO7cJANVLilduiWFPtM8EHLvgcCJZ1OhfIhdnxjbuIYExBcnuTTBaI7auZcJAoAgqOYt2FHhfse4kRO8SvRkS5YZadR62b6mx+gjoshNloDk1DPinCwChRk3UAymcL7KQ2SQRrQ9vdHvW9olV5OgpcqGWVDrG4eNVfrDwVvT4/FHUT1NLQemhtsM53hOuO110G/gA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RlhNYAbQpdDTOL7/zKHG116ztudFUSr1BvPgTplTxYU=;
 b=Fury4cEaJhOoo4BN0GDXhOx40hPzcQvVUno2E1o6FiNpkJyDxvAq+mMUAcc0wCVcpA42L5w5+nr359Em+xXuQ4tTq+Cy+lbRit+Q1lfm89LPubNfQbiE3mOZoVg6axtQ5uZwnCSRbLExz+rB58u5E1RPvGtt5Bd2KS4I5EXVX0XHnvYqqPCDPz1vYbnt6S409GeQB4zJUTqBxyC677VGSv7SVNBfZBUuDA/UrfZJ+3EGy7toyb2O2zH8IRBBY2/kaE/LtnnbWq1IIlriht6AEu74ed65QCi4bdb1h54Kyd15cghBkGpktQB9mNhCWWFeyMTe3ndtUKLW9gbOrO7tJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=nxp.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RlhNYAbQpdDTOL7/zKHG116ztudFUSr1BvPgTplTxYU=;
 b=SatvRZvsrulKKlTpVFUhM944t7v3Ma7UQS1azC4B7SlrY+jUfvHUVfpbQW0DsG9WX2VOzpGLBeNJRnGQC6ZeMsXhUITLjdK83NKo6/4qw5K00gqecHXrahLee8PAOujy4jHb5+wlzE+F4XfJf+7gs/l88Or7O+X9irv+qMoQ+pgKZpn9RoHJKHzKMwjq1gPefGNe16HSJrRgMHdn4TrFqMyatksB804Zn6lTXSjbOSJuxdmgeI20kKenk2/yk8gn/J2iQcQ8nG+j2SkDCMRdLc99V1CWsM+8dS54dkdW693AKbhbXsqTdGYif27P7rEz4+Iqg0oRum/JUb48Rdltwg==
Received: from BN8PR04CA0064.namprd04.prod.outlook.com (2603:10b6:408:d4::38)
 by PH8PR12MB6891.namprd12.prod.outlook.com (2603:10b6:510:1cb::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.15; Mon, 30 Mar
 2026 18:03:09 +0000
Received: from BN2PEPF000055E1.namprd21.prod.outlook.com
 (2603:10b6:408:d4:cafe::6e) by BN8PR04CA0064.outlook.office365.com
 (2603:10b6:408:d4::38) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9745.28 via Frontend Transport; Mon,
 30 Mar 2026 18:03:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BN2PEPF000055E1.mail.protection.outlook.com (10.167.245.11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9791.0 via Frontend Transport; Mon, 30 Mar 2026 18:03:08 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 30 Mar
 2026 11:02:46 -0700
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 30 Mar
 2026 11:02:45 -0700
Received: from BUILDSERVER-IO-L4T.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Mon, 30 Mar 2026 11:02:41 -0700
From: Akhil R <akhilrajeev@nvidia.com>
To: <frank.li@nxp.com>
CC: <Frank.Li@kernel.org>, <akhilrajeev@nvidia.com>, <conor+dt@kernel.org>,
	<devicetree@vger.kernel.org>, <dmaengine@vger.kernel.org>,
	<jonathanh@nvidia.com>, <krzk+dt@kernel.org>, <ldewangan@nvidia.com>,
	<linux-kernel@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
	<p.zabel@pengutronix.de>, <robh@kernel.org>, <thierry.reding@gmail.com>,
	<vkoul@kernel.org>
Subject: Re: [PATCH v5 08/10] dmaengine: tegra: Use iommu-map for stream ID
Date: Mon, 30 Mar 2026 23:32:40 +0530
Message-ID: <20260330180240.29906-1-akhilrajeev@nvidia.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <acqpHJM3eilwyMMy@lizhi-Precision-Tower-5810>
References: <acqpHJM3eilwyMMy@lizhi-Precision-Tower-5810>
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
X-MS-TrafficTypeDiagnostic: BN2PEPF000055E1:EE_|PH8PR12MB6891:EE_
X-MS-Office365-Filtering-Correlation-Id: fff2234b-540c-4fd9-8fa6-08de8e8699a0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700016|82310400026|7416014|376014|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	aiw3ik+6ib6i20YoNQQ/RITWz6OqUIgk80vuY3SCkfZgA+cw4FcS7sUhBwy1RjRDnTAIl7SO+WYnOamQ+5d5vJoLWE5y6qDb52CwY7HUIrKG3CAJV0/uZ4A3br9HdoE7tBNACaPm/Lhn/EEmvqU90dT2lRhtLk6Fmkbu50QLAdopqTmKY7ITQeGRyWuLlHoEfQTjCHvaEVlU1LOEfYhPd9zUaqv/eVuoAbGYPBHTYdQdifgF5/bA93+XLwf8sPrPK2SBq8tRfRaCGgNN9DmjUzXZ5E9Z/fOR7/+gomVsbaNj5bnxDGoe6IoDvL+SR2Xy9+mZ6A/L+NJIpfagAELKlruaP+xKfMVm7MuJrnqGJ4FlMjbO76p3IwPo6JYu/n3dcgUpoa6XHopXOHkgPULRUZCWCckmxoBzNGM71Xw8GNuc/jnbxBQVetQFBuAGuC8sJaSgFgYi2DVKc2RVA2M+78IqfvdAJ8hv1SQ/8wmiAJ5BdVsri+cJKTE5FZ5U/06NUDToAelMFsFpFxKtdova4FJ1bUQuzLz6Pkf3OL5v4EL/7WuDf7En35HYIN46QQ7Dq0pBYI2tptu8+a3ZDTrAcEpufBJ8SeXLtcolPP4tvJa+CcU8e6U2WdfXL/nX3nmUHr7nX6t9azRwbj3CdJ2455xbxrAoUs8ps8qoKyl7L4RUFRllW5BSlF27sqE6keLIyq7dYz4+O8089VJu/bs39Pv1PQ732Rfv+gVQjEieqknChsPq0KbXdGpoql16voh+atsIabDZedjyD3rXiMhn5w==
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(36860700016)(82310400026)(7416014)(376014)(22082099003)(18002099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	i7euuwsnoP6FAOgNSHGuB4AWxGiGUxvByidEd9Do8BxD9drc0E59XEMRg8BDJE2emhfsIlTsM5OENsMj7ugjeJlLeHHCObdx/gyRPwBqCvYB4BDMfOcpaNZ3d37mbRI8FNKcxR0+10OpD8+d2IVMd+AJbRAKC5DRRCVABrcbxNWavmqdNwYU1fTN5u8ei5cYB/aRhTNlA42ODFmD/nI4AO95KgaeyJFFjWtfaAO2cSrDelAQ7z2vow6ecwEAeiTdR1PQZK9vPH0RxIyF5zqnnB7B0q416xrNTP+tMb5vcTDVmiv0qUhMhrTBQm1lXu+gcZd8nyGueMeDG8awmjTpJFJBqcG81YPrXl0XfJX2yq+H9iA0I4aYJTawwwjnR7UgQ8+bLYbXONaSRqpe/JOjddGJpfCj3g7FShRIZtfc093zCDoHJTp4AWJc1iRtDX0G
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Mar 2026 18:03:08.5418
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fff2234b-540c-4fd9-8fa6-08de8e8699a0
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF000055E1.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6891
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,nvidia.com,vger.kernel.org,pengutronix.de,gmail.com];
	TAGGED_FROM(0.00)[bounces-9741-lists,dmaengine=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[akhilrajeev@nvidia.com,dmaengine@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	TO_DN_NONE(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	DBL_BLOCKED_OPENRESOLVER(0.00)[Nvidia.com:dkim,nvidia.com:email,nvidia.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[dmaengine,dt];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: 9415435F92A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, 30 Mar 2026 12:47:24 -0400, Frank Li wrote:
> On Mon, Mar 30, 2026 at 08:14:54PM +0530, Akhil R wrote:
>> Use 'iommu-map', when provided, to get the stream ID to be programmed
>> for each channel. Iterate over the channels registered and configure
>> each channel device separately using of_dma_configure_id() to allow
>> it to use a separate IOMMU domain for the transfer. However, do this
>> in a second loop since the first loop populates the DMA device channels
>> list and async_device_register() registers the channels. Both are
>> prerequisites for using the channel device in the next loop.
>>
>> Channels will continue to use the same global stream ID if the
>> 'iommu-map' property is not present in the device tree.
>>
>> Signed-off-by: Akhil R <akhilrajeev@nvidia.com>
>> ---
> ...
>>
>> +	/*
>> +	 * Configure stream ID for each channel from the channels registered
>> +	 * above. This is done in a separate iteration to ensure that only
>> +	 * the channels available and registered for the DMA device are used.
>> +	 */
>> +	list_for_each_entry(chan, &tdma->dma_dev.channels, device_node) {
>> +		chdev = &chan->dev->device;
>> +		tdc = to_tegra_dma_chan(chan);
>> +
>> +		if (use_iommu_map) {
>> +			chdev->bus = pdev->dev.bus;
>> +			dma_coerce_mask_and_coherent(chdev, DMA_BIT_MASK(cdata->addr_bits));
>> +
>> +			ret = of_dma_configure_id(chdev, pdev->dev.of_node,
>> +						  true, &tdc->id);
>> +			if (ret)
>> +				return dev_err_probe(chdev, ret,
>> +					   "Failed to configure IOMMU for channel %d", tdc->id);
>> +
>> +			if (!tegra_dev_iommu_get_stream_id(chdev, &stream_id)) {
>> +				dev_err(chdev, "Failed to get stream ID for channel %d\n",
>> +					tdc->id);
>> +				return -EINVAL;
> 
> Can you check similar problem before post patch, here also can use
> 	return dev_err_probe()

I did notice that, but I thought dev_err_probe is to handle -EPROBE_DEFER
and we do not use it when we return a fixed value. It returns -EINVAL here
directly.

Best Regards,
Akhil

