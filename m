Return-Path: <dmaengine+bounces-2922-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BA258958B53
	for <lists+dmaengine@lfdr.de>; Tue, 20 Aug 2024 17:30:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6E692282501
	for <lists+dmaengine@lfdr.de>; Tue, 20 Aug 2024 15:30:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 234051946A7;
	Tue, 20 Aug 2024 15:29:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="oQXOccGC"
X-Original-To: dmaengine@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2044.outbound.protection.outlook.com [40.107.220.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9679B1946A1;
	Tue, 20 Aug 2024 15:29:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724167774; cv=fail; b=C2X9c9wKxxGNGv9ksnWg2+wZkW7X4p0JEZZds+jCOJ/RwFbANObI2LZ5a/w0PRs2W4CSdLpuQ1oGpsB6/9bwH9aGn4dSdFtd7hwzuNZsBk5CQh96y8vdTaXTsnolcAKs9NcjrKngfVhMpB7NZAtuQQxvlRJiW5uh74/fcDSO0T0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724167774; c=relaxed/simple;
	bh=6KIYD8Jc473isz/yyPOIoiaO4+zfx1QYSi7w2wupDu8=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=TDY1+8MV3EOvRA4YgFGPGDkuvQd/x8RYJQcyivZdszRhC9lYO5zldweOAwGvPPbaSJxMJkhfkU2vxdwlbztYE5v96QAfQfWPYXCBDTH45DyXf8vwQLrwU93El1JfvYn1IzEzirriXV9C7UDMS3lt80ELS8V+ptk7V5eZTHIfwbk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=oQXOccGC; arc=fail smtp.client-ip=40.107.220.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sblR+zfrXMesTamrgEKoMrQFXxbLs16fQ/kS254w9yzFmSbh3xspHBAj6pimS9ri6L5xpc7BPGifY08pk5gwK/Kbu/qUF+nJZ951PVLI5bYRbz/7+c2ubBMrCtJ1sPHohS4UEZhOtMFDnrkTfKBmkP3isl5lMAWpuu3X2qelnRvpE2pTv76Kg+/2AHaaSXaR/t51T1YBu624Gw4q4y2HPQjxIHMZ7mvMrn2fF2gYq9OkzOR+oTYivSjQ+k9jbuSHBfdGF5VK9i11H5hh240lhZGZTSB4WMhmE26ImHx5/YLzupC8qyZdENGsLHfTVZlyJtGkz7AOP1xPbLTrjhW3jQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VGPLVjUb+jT1a1PFXQPjYicRF5k4xnMz0EsuU/cI4+Y=;
 b=rx/wtBU4HW1vFk5oanInR+9TnUWY3ogcQ3GGiSRlXOCOP5INFjsf8h8vodhdihlUenZSTP3IP998Igij967MIeY4F8lGAumzQvPR+1fXUXMloJSGsCALq65gmSPPmBM41oDvo+f9gC/xst+ysYbzoLS2uvqhmkiBdNeQoiaT33NyXKnTZc8/wDg4AuYP8OOerr3UbBVXW/1m5lR03MET9MDMHLfyIPXcfGDn+u9l7eFLFKyI0asPVcCIE9nPRcPx17KKnd73Z9+0Xsq/ESnQ1+GDincq9lsf9dv5YlNB3QuVnTgUxZpulX64id2RHxJist+kVWe3UPcRdj6nG/B2BQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=huawei.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VGPLVjUb+jT1a1PFXQPjYicRF5k4xnMz0EsuU/cI4+Y=;
 b=oQXOccGCTCnxeS1Ed/wDP26utI4FPyx0sQ2/jd1X+rX9nG4zU6FhLbk8M9pYgng1Wre0A+3w2kxwXattwcugj0S6DOoG+Kg3cbw8m2JATjpHsOAqWKvS/TA8EHvHCPPM/pNxm2aBxuDsOhElL2Z/axoZGuBv+PiHslOCJh4wMJQ=
Received: from PH7P220CA0064.NAMP220.PROD.OUTLOOK.COM (2603:10b6:510:32c::8)
 by SJ2PR12MB8184.namprd12.prod.outlook.com (2603:10b6:a03:4f2::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.21; Tue, 20 Aug
 2024 15:29:27 +0000
Received: from CY4PEPF0000FCC0.namprd03.prod.outlook.com
 (2603:10b6:510:32c:cafe::96) by PH7P220CA0064.outlook.office365.com
 (2603:10b6:510:32c::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.21 via Frontend
 Transport; Tue, 20 Aug 2024 15:29:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CY4PEPF0000FCC0.mail.protection.outlook.com (10.167.242.102) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7897.11 via Frontend Transport; Tue, 20 Aug 2024 15:29:26 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 20 Aug
 2024 10:29:24 -0500
Received: from [172.19.71.207] (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Tue, 20 Aug 2024 10:29:23 -0500
Message-ID: <d28a5f5c-9430-11a7-2330-84e1e781fd1d@amd.com>
Date: Tue, 20 Aug 2024 08:29:22 -0700
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH -next] dmaengine: xilinx: xdma: Fix NULL vs IS_ERR() bug
Content-Language: en-US
To: Yue Haibing <yuehaibing@huawei.com>, <brian.xu@amd.com>,
	<raj.kumar.rampelli@amd.com>, <vkoul@kernel.org>, <michal.simek@amd.com>,
	<sonal.santan@amd.com>, <max.zhen@amd.com>
CC: <dmaengine@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>
References: <20240820132827.52108-1-yuehaibing@huawei.com>
From: Lizhi Hou <lizhi.hou@amd.com>
In-Reply-To: <20240820132827.52108-1-yuehaibing@huawei.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: None (SATLEXMB03.amd.com: lizhi.hou@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000FCC0:EE_|SJ2PR12MB8184:EE_
X-MS-Office365-Filtering-Correlation-Id: 810f214a-78bd-4338-eff5-08dcc12ce021
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|82310400026|1800799024|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?SHdoNXJjeEcvRzNnV2ZzQ0NMZDZ4a1lBa3N0SEZtbnlvc09nT3ZXQnBPdnZQ?=
 =?utf-8?B?Z0xacEpCRkQ3Y1ZtUUtDUmliRGQxSWVITjZBUzNaK09PT1orcVVmOThsb3JB?=
 =?utf-8?B?OU1OMjc3WE5SWHJtY3cxb0VYS3dsalJ5OEpTT0loV3RPSkFpcHJ6MUlwZXlt?=
 =?utf-8?B?RGplTnlSM0dvWDJ1NjIybEdaK1NuTWU5cTJLV1RMUFZ2dGk2ZHlqcGg5dXNt?=
 =?utf-8?B?YW1OWGRaOUZvV0FVVGp5ZDVPQXE1R0lJZnQrS3pHemVrdE1KV051RllpaUVR?=
 =?utf-8?B?L2xKZHFkaVRKSmRnekFueUlQVDFNTHNJcFhzZTBtNWJNRC9Da1g3WkJtekl6?=
 =?utf-8?B?R0FpY29EeG1aN1AwK1lweW1DMzU3ck4xVEhsOTVwMUZZek1kb0l5bkdOclBP?=
 =?utf-8?B?N2ZBSUpHRFQxRDdrR2E3elJVbmpOb01FUmV5cmh3cWpCdTV6cFVoL3FDVG1y?=
 =?utf-8?B?SHoxVms2amlkTHQ3TE5mM1BkczhERlhoMWNpbjlGU0lRWGExNmo2NVMrb2h3?=
 =?utf-8?B?djVxZ2xmUlNYMi9uSytNd3JPZWlkZ2hwdFQ5SURFZU9aS3BDdmpPVkVmdndn?=
 =?utf-8?B?WVByZHBiZHM4ZkdYNzhZYnRrTE5abWZTWlEvM296ZXBpWDVCSHFCTEhxUVZu?=
 =?utf-8?B?OHVCbjluYjZvZ2pueVFWUHVHUnhuYjM5RzRCQjY4TTMvb2lQR0xJMjNpQ24y?=
 =?utf-8?B?SWtVekJTWDZISHcwV29pNkkwWXpHYlMvZW9MR2NZU2pLc2FVYyt5d2VXUDdR?=
 =?utf-8?B?YVJpdnFKWXpuMDk1VkxwbmNyWmJmbXhvaUROS0k4U1dGbmJaOUxRMHo4TlNi?=
 =?utf-8?B?d0FVdVZZTFNNL3V5L0c4dHNTMjR5UlNld2lzKzBjTi9zajQ4aEEwTi9qRWg2?=
 =?utf-8?B?dFFIV3Ftb1MwTmo1L0dVU1lCUzR6ODFISVhqT1pMQTNXcjNHQ1MrNWlPRnVT?=
 =?utf-8?B?Y3RYZlFScWZtekxTQ2V4YllYc3pVd2ZSbExwekdITGVCL2Y0eWRWemR0VmZh?=
 =?utf-8?B?cTAvc3Vma1Y4S216MFA3MUxZd1JVMmJ2ZjlTTUhGQVg1UEdiZ2ZnQ0EvVXlC?=
 =?utf-8?B?WEdrSFhkb1ovc3FEcWVhMFZlM1A5bHVYT3FhVzh1NmtOb0ZseWRWWEI2TjBh?=
 =?utf-8?B?ZzRiOVA4MHVFcWM2dU0xYW1TRVp3OVI0aGxldVM5WU5xaE1lYXhKN3lRb29a?=
 =?utf-8?B?SVJUV1NtL3p5cVY3NENCWUhicWM2OU5NQUNkeVRHOHdLcEhUT2FrMUpURVdp?=
 =?utf-8?B?ejBPN2twc2hHWStNdk9rYnhwc0VQN1IrczEwK0tnTlhGWUxZc1ZRcksvaG5h?=
 =?utf-8?B?cmxRbElpL2NCcFh1VkNWQ2VWWWQ1WmdRMmxPektFUUl5NjZzZzVQUGdDTHlt?=
 =?utf-8?B?cGZCMzU0VTk4UnRZaHV0QmtUaGpNc2dEbXo3ek84WUNKV1dHZXN2Z1hOcDJ3?=
 =?utf-8?B?aUdJNEFvRmZ2ZzY5SVh3QUFMUEZ4QSs1L2RxeWVLNHM2NXlTRVRFUW9WL3Nv?=
 =?utf-8?B?R2t3V0MxVWZZTU1ZOTVWSmdLNU4zRk80TlN1VC9OT2g3MUNuRU1TUEF6ZG1x?=
 =?utf-8?B?MDVUdVJEUndTaW9KS2ZJaUY2aHRTaEFDMUhjQ1RBWGplekxUbmVzMnkrRkYr?=
 =?utf-8?B?N3luRVBqSUg1NmlrcE1LR0ovWnFTUjY3by9uVjNGQklMWjdqeTJoM0tzc3FU?=
 =?utf-8?B?b3Q1a1Flc2lrY3FGNGExdzgvNS9wZTVOQkVBdlVKankzU2ZDWHhscVVaUU9r?=
 =?utf-8?B?R25TYm55Yzhzd2R5T0pRejFocCtoUWxCRHFOa3g5akROd2xzRmY5UW1JQUhy?=
 =?utf-8?B?cHNEVFYzT2lmNmR5bjAwSnQzNlo4VWVxQVppQW5yQjFSWmZuTlJQUFRmM1Ji?=
 =?utf-8?Q?pYRmWPba+qsMt?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(82310400026)(1800799024)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Aug 2024 15:29:26.1560
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 810f214a-78bd-4338-eff5-08dcc12ce021
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000FCC0.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8184

Please see: 
https://lore.kernel.org/dmaengine/20240819193641.600176-1-harshit.m.mogalapalli@oracle.com/


Thanks,

Lizhi

On 8/20/24 06:28, Yue Haibing wrote:
> devm_regmap_init_mmio() never returns NULL pointer, it will
> return ERR_PTR() when it fails, so check it with IS_ERR().
>
> Fixes: 17ce252266c7 ("dmaengine: xilinx: xdma: Add xilinx xdma driver")
> Signed-off-by: Yue Haibing <yuehaibing@huawei.com>
> ---
>   drivers/dma/xilinx/xdma.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/dma/xilinx/xdma.c b/drivers/dma/xilinx/xdma.c
> index 718842fdaf98..44fae351f0a0 100644
> --- a/drivers/dma/xilinx/xdma.c
> +++ b/drivers/dma/xilinx/xdma.c
> @@ -1240,7 +1240,8 @@ static int xdma_probe(struct platform_device *pdev)
>   
>   	xdev->rmap = devm_regmap_init_mmio(&pdev->dev, reg_base,
>   					   &xdma_regmap_config);
> -	if (!xdev->rmap) {
> +	if (IS_ERR(xdev->rmap)) {
> +		ret = PTR_ERR(xdev->rmap);
>   		xdma_err(xdev, "config regmap failed: %d", ret);
>   		goto failed;
>   	}

