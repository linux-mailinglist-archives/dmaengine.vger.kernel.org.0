Return-Path: <dmaengine+bounces-3176-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F19497A9C4
	for <lists+dmaengine@lfdr.de>; Tue, 17 Sep 2024 01:49:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EB937283864
	for <lists+dmaengine@lfdr.de>; Mon, 16 Sep 2024 23:49:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E930114A4DE;
	Mon, 16 Sep 2024 23:49:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="At7hVpff"
X-Original-To: dmaengine@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2040.outbound.protection.outlook.com [40.107.237.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F1C85258;
	Mon, 16 Sep 2024 23:49:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726530546; cv=fail; b=Z5ZjpMZN0Qu7Rov7SlBvBJyVeex4DNZiz1O+I5vbLIk0+l0+qskT5tEG0eqA/DkBTheQB+v7+P9Z7Q9uR8631IbQ6nMediCK4jIVj7YIxSCp+/PmXTgOXY9vpKtDNJYzdfDEGUGoBcTRw9Aa/qSSDpekL8mx2qkA7ZTbBI7MRIQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726530546; c=relaxed/simple;
	bh=vE0m+699aSZ7F9NQqi5F2SecaQFyvMTmIbPnn3ongi0=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=qdM0YMJ3Rjq64F66amSMJStXLsZqvVZu1Zp/DrwsUvC1qonsL1a83W8bZylVwd6mnu/i/sNHJqrGnFPZkub10r2NxvIZx4NaNgMh2M3rJhhMhZYAWQaxjZ9qJVeZH/RIbG/bQ7kkz0+DHu05KeHBziuqjfRYG2i4Jb19Kihb6qg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=At7hVpff; arc=fail smtp.client-ip=40.107.237.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=J+mwmGSGfeY2LwXvuIka4tytLH9Mko2FsSt72egUfg/hchdi/8Pj9MWvyLyytYKEzZINRQb4TxlbMazvipwGN7orIHQkr/T6kLLdrTY0L1eV/hiWyvAMGXzL+pyOD7ZNucROO/NntYN5hW7A1P6OJelTPTfjzSD6UW0rzINXSA/pciMOqHzoUuH9YHvsF3fZOZDGU/sIwf8hrUqCxkelcqcxkcGBfO+dBz8U4rqwnW/22r34XmsfKYHuNZBsRq0Dv9z5qmfOJswC/qVu53NZW6MJF6suqQoJk674wBXrhTA42OW2hEDdIdU6g2dWv29CHqDn9CKG6mbrXY1G7Uum6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=91yM/6Sl77QB3j/70Zdh+QeoFORiHA9RLZZyoyRwwEc=;
 b=w8hA+zPllOY8PnrAyt9shvYAW6K+N68aVASrPxsY/QQppzMiTd9tHqa8E9nqJWjdjAfWDc5rXcsyyjXNZDjKrW0Qb6EuKWbWnKjAQR6Nsj2yokMEscxKF/5RmWYK4v6CHQ+RT5R1Uk8qTQQWO9CFK9uRKwFLcgUCk+lO4kbRfhSXhhq3BVExkOpQ4WopluQm9L/IjK8+ru9IF3d/S08y38M7QMQr0PnY0NHUgDNSPQRopnkj7wxRNsEph/Il4G+lW2E5FbMIHa962my7HNMj8kPxeasoeUetmanijSw49Y+k8sARPXGhaHCVc6yFiDD+qBUSGyl0rt9aunoTFqFmCQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lst.de smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=91yM/6Sl77QB3j/70Zdh+QeoFORiHA9RLZZyoyRwwEc=;
 b=At7hVpffAdB7YY/XoCM4GlvZSKzZRIWRZJvLr2/3cuJhJPA2vD5myat6cvzgNBago9KHrhGWmoTpktA/XjlDkhC5IUteZn+L2xcbDmvdYj4GDbqZ1a7z2yVgaaoPIlhmpM2KFZ1fA8hNfVzBtMzYsPOESecqfZipRZPwQBrARTE=
Received: from BN9PR03CA0269.namprd03.prod.outlook.com (2603:10b6:408:ff::34)
 by DM4PR12MB8524.namprd12.prod.outlook.com (2603:10b6:8:18d::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7962.24; Mon, 16 Sep
 2024 23:49:01 +0000
Received: from BL02EPF00029929.namprd02.prod.outlook.com
 (2603:10b6:408:ff:cafe::80) by BN9PR03CA0269.outlook.office365.com
 (2603:10b6:408:ff::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.30 via Frontend
 Transport; Mon, 16 Sep 2024 23:49:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF00029929.mail.protection.outlook.com (10.167.249.54) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7918.13 via Frontend Transport; Mon, 16 Sep 2024 23:49:00 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 16 Sep
 2024 18:49:00 -0500
Received: from [172.19.71.207] (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Mon, 16 Sep 2024 18:49:00 -0500
Message-ID: <4fe5374e-8eb2-9ff6-e2ea-e55342c59de6@amd.com>
Date: Mon, 16 Sep 2024 16:48:59 -0700
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: Please revert the addition of the AMD QDMA driver
Content-Language: en-US
To: Christoph Hellwig <hch@lst.de>, Vinod Koul <vkoul@kernel.org>, "Nishad
 Saraf" <nishads@amd.com>
CC: <dmaengine@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20240916074051.GA18902@lst.de>
From: Lizhi Hou <lizhi.hou@amd.com>
In-Reply-To: <20240916074051.GA18902@lst.de>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: None (SATLEXMB04.amd.com: lizhi.hou@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF00029929:EE_|DM4PR12MB8524:EE_
X-MS-Office365-Filtering-Correlation-Id: 9f0e2705-04cf-4dff-f7cb-08dcd6aa239d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|36860700013|1800799024|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?MVRDQ1A4QnJRc0o1Y1VhV1lKcEl1blR6NnRQcnVUbmFmWDByUjVqeitab2RR?=
 =?utf-8?B?WmltQlI4NGVYSVJJMHZJcmlzdDJtMTl4d3lDQW4wTk9tZ0Fqcm1CSHJHN2h1?=
 =?utf-8?B?UHFwYTRsd1FkOHBrQ29ZQzY0YjVyQXozb3Y3SnlIU25ISVd3TFdOMlhaaFVY?=
 =?utf-8?B?VnIzMVNzN1dPVENKc0JjSVNNYmhFeFNHYXQrcXFWeGY3RmhONmU1dkVjTHdr?=
 =?utf-8?B?cGthNXlCZEJrbDF4eEFqQytvb0JYSnFHdDFnQkNUVGx0YjREdEdvOVRybjUv?=
 =?utf-8?B?b29pMkcwSjVENHR0R1hRUW11elBuSGxkUE5weHFUWG5VMG9icjk0THhIVjVr?=
 =?utf-8?B?NXB1aDZSVlpGMW5CSTFrMVFPSS9FUVIxSG5XeFJLeDBvblJDM200K211TWI4?=
 =?utf-8?B?R1pGQUs0ZFZWSFBlL21keTJ1RWUvR1p2US9ZOEU5YlYyWDdQdjM2WWV2K3V4?=
 =?utf-8?B?YzM1K2hZQXhxdWNGTzZKTHdscVJPS2NsZ1NQODhvMjk2anZNcktERnhTNW5R?=
 =?utf-8?B?OUlxUjJLaFM2OVRXeXp0VmUyaUlONlJmYytDbGRxa1lzTzhsMFJaclk4WEty?=
 =?utf-8?B?bGhRQmJXL3FIYjdXVFZqa0FQTnNYNFozWHRDV0lLaDgvWlhSdzZ4SG54Vyti?=
 =?utf-8?B?MmtIMGpRb0gvcE93bU9KQXZjcHJBUStXQU5TNDUvV2t2Mi9Pc1JmSm5EeEQ2?=
 =?utf-8?B?a3NTSHc3VGxBQ0pYLzIvaytDNm1VQ0ZRaW1PTTB2Y0pUcmovVlpvT0xDeDFB?=
 =?utf-8?B?N0NSSW9aRk1KWEl2MDk4SkNSbEtXYm1tWm5kSWVXa2lnYjE5MDJWQzZWa3h6?=
 =?utf-8?B?YWdXZisyWlBWZEp0YXhvNlRRb2ZlYU0xanpDTStwUEd4aWU3ZEdOVmRaYVg4?=
 =?utf-8?B?eEFMeTNranlDNFdEREJCZEhBSUhyelg5d1F1T0hDSTFraEg0dTl5OU5vemd2?=
 =?utf-8?B?WUE4bmtjS2dtekl2K2hwTjN1VERnVXVrbVE5MVE0S1JyajNLN3JMSWJaeTgz?=
 =?utf-8?B?R0hUa0pBV0JMaDdYZzhNSDErYXB1WHpyQU1OM1YyMjhPQzJZRkdPYnFYQVNx?=
 =?utf-8?B?em95SDE1RE9VNzlzQy9TN0hXMUpibnFSNHZNSEc2djZvcW5qcGhBa2NEbk9I?=
 =?utf-8?B?OER1NTZiQmEvd3JCbmRWNFR4S080MUw1QVJEcCt4aW54N1diaWRWYVpXT3Fj?=
 =?utf-8?B?UXlxVGNEbXJEOTRJRHNQNHdPbmw0VGJVNjc2NFMyQlpoL0FsaFdsbVFYczlV?=
 =?utf-8?B?V1dJbEY3WmZMNVdIVXlBcXdXZTVQemtUbUU3VVpSakk3THhpUkZlTUkycEV5?=
 =?utf-8?B?aFoxS1QrUStrREZuTEd2VGJuYXR0R0ZOSmV5aXVKbGp4VW5xSXNybXJ4WE45?=
 =?utf-8?B?dm9IZTRJaDhvMWNERW04WjV3VGQzdlhlakNvdHlSR0UxeTZ1QWxCQmZubTlu?=
 =?utf-8?B?OWQza21XU1l0MEdobklER1c3b0t4dTE3a2doeXZTMEVPTFpCUm12aVpIU0Nq?=
 =?utf-8?B?a3NraUpkS2RtY2owak9BYUlKUTZCckdYNThaaDFOcmZwQWI4ZVBmdlFJRzFj?=
 =?utf-8?B?dUZRMUNIKzlCN1JOK3VIZDZzTnRqZE90WlFmTVNpYW84MGo3OTU3TDhQeTdw?=
 =?utf-8?B?c0R6T1Qrem1PRTVDSy9pV0EwaTMyK1BUY25Vd290bWFITHcva1VuVDl4WnZP?=
 =?utf-8?B?elZhbnFEY2E5Q1U2cTh4SThLQjcrN3hpeHdLNjdRdVBWOHF1Yi82UE1wOGdz?=
 =?utf-8?B?aEhoSnRoMlZYbVMwazFiVlpZQlQxN3M4T052aWJsQ3BaQmtiaksxcWV1VHhV?=
 =?utf-8?B?Wjk3Y3J6dXFzQ1hVMjVPYTZUQW1GeGRhT2RmeUt6TDhZN2hRdnBXWHNzQTBk?=
 =?utf-8?B?cGI2L0JrUDlVSVlndnd0NUhOVVk3ZHlYODZFamNiR0tab2Y4ZGswU3VObEFl?=
 =?utf-8?Q?IMBjx8jszaaw70a5aWpNHNGDYEuvyoyN?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(36860700013)(1800799024)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Sep 2024 23:49:00.9482
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9f0e2705-04cf-4dff-f7cb-08dcd6aa239d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF00029929.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB8524

Hi Christoph and Vinod,


Sorry, I did not know the limitation of get/set_dma_ops.

Instead of reverting the entire driver, is it ok to put a fix on top to 
address this issue?


Thanks,

Lizhi

On 9/16/24 00:40, Christoph Hellwig wrote:
> Hi Vinod,
>
> I just noticed you added the AMD QDMA driver for this merge window,
> which is completely broken in terms of DMA API usage by using the
> private get/set_dma_ops APIs.  These were never for driver use (
> and I've been working for years to fix the few abusers), but with the
> DMA changes in 6.12 it actually can't work at all, as the dma-iommu
> driver now also sets NULL DMA ops in addition to dma-direct.
>
> As a reminder drivers must never try to inherit dma settings from
> one device or another, instead pass the actual DMA device to whatever
> layer does the DMA mapping.  Without that you break all kinds of
> thing.
>
>

