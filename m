Return-Path: <dmaengine+bounces-283-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1111C7FC9CB
	for <lists+dmaengine@lfdr.de>; Tue, 28 Nov 2023 23:44:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 33B041C20F29
	for <lists+dmaengine@lfdr.de>; Tue, 28 Nov 2023 22:44:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C8C0481B6;
	Tue, 28 Nov 2023 22:44:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="De8DGcHT"
X-Original-To: dmaengine@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2043.outbound.protection.outlook.com [40.107.223.43])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B111E83
	for <dmaengine@vger.kernel.org>; Tue, 28 Nov 2023 14:44:39 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DmiR9/sjiHdG/LMmXK9zCkhLsqgC2JqGbXSWS3RmxqnZ90bkddrsvQQtlZ5bkiYY6oWj9AGgvmJa9kCGFy/tfle2GTGcsKjA5R9EsUlxp7TR7mGyYAEavzh2jgZFajGsSap1Kt2UPwQtxQ6CCPiCikTrFPbqWmIqofGVW4YSVGoz0LacCgxliU/fXmNkXak9AXZNZ4fvMAoeI++keUduH3AATeCJTGG7hfUD6l8tM3Cyd7FB7RnBpySHy09fImsn63pONvJKlbsRf5REt9AYBeewB6fkRMHOws4MER/mHGPp/givwt8q+otN8FTXZM9zFnrRaVawsvTkF+UMn8AAXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0h7QYU6JFuhBZwYai+WYBI0hN4O9OJj2FC6Anx5rxLY=;
 b=e+5ltEi7jbTGAb3kE7+eINB6W9jlmikq1CmKdDL63ZCyF+zvejYcnr6lV4yEBVqPWvMszmKYe2wlM95hPxu+09ETAAundIL66dv1+WFSHNENKtFju1eOCR78dHAYuSn8JZkjoWWEX4iLAV8l7wHe5PddCq9zykQr4JtcbC3RU6spmDirtoDJSeuXLtnvwq36H2ozsl+kzg68q/3tHUCarK5630ZJCdf39tmscTYEu28Wqf8+LBsSzVAuqS7yPbNUCogTU7uZ5Xg2lNOZgRUm7NGeeN9pQ0Q+erpspZcySD/wHPeQIUjjSb//NeetlWpxBX14USExvvnGNiax3GtqGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=bootlin.com smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0h7QYU6JFuhBZwYai+WYBI0hN4O9OJj2FC6Anx5rxLY=;
 b=De8DGcHTQ/B9xdKn/ZZgqdSJTGRXxqvug9MUt6dE/BZGrwhrFb0DLHiY+1nxgqYqlW+rF1IrLq1QCaE2WpY4tZloMD3hHwmkn5cx0qYTFucegAp5RpMXyOq6k2bVliZRgYTGPyipjy2dNVLMpTKaP3BPZQEGjyPBlxcTPBvyF/s=
Received: from MW4PR04CA0083.namprd04.prod.outlook.com (2603:10b6:303:6b::28)
 by BL1PR12MB5352.namprd12.prod.outlook.com (2603:10b6:208:314::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.28; Tue, 28 Nov
 2023 22:44:37 +0000
Received: from CO1PEPF000044FD.namprd21.prod.outlook.com
 (2603:10b6:303:6b:cafe::dc) by MW4PR04CA0083.outlook.office365.com
 (2603:10b6:303:6b::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.27 via Frontend
 Transport; Tue, 28 Nov 2023 22:44:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CO1PEPF000044FD.mail.protection.outlook.com (10.167.241.203) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7068.1 via Frontend Transport; Tue, 28 Nov 2023 22:44:36 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Tue, 28 Nov
 2023 16:44:36 -0600
Received: from [172.19.74.144] (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.34 via Frontend
 Transport; Tue, 28 Nov 2023 16:44:35 -0600
Message-ID: <3403ac76-db69-d2c2-0bd1-03e8210d309e@amd.com>
Date: Tue, 28 Nov 2023 14:44:35 -0800
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH 1/3] dmaengine: xilinx: xdma: Fix the count of elapsed
 periods in cyclic mode
Content-Language: en-US
To: Miquel Raynal <miquel.raynal@bootlin.com>, Vinod Koul <vkoul@kernel.org>,
	Brian Xu <brian.xu@amd.com>, Raj Kumar Rampelli <raj.kumar.rampelli@amd.com>,
	<dmaengine@vger.kernel.org>
CC: Michal Simek <monstr@monstr.eu>, Thomas Petazzoni
	<thomas.petazzoni@bootlin.com>
References: <20231124150923.257687-1-miquel.raynal@bootlin.com>
 <20231124150923.257687-2-miquel.raynal@bootlin.com>
From: Lizhi Hou <lizhi.hou@amd.com>
In-Reply-To: <20231124150923.257687-2-miquel.raynal@bootlin.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000044FD:EE_|BL1PR12MB5352:EE_
X-MS-Office365-Filtering-Correlation-Id: a19920cc-4315-4b02-fc16-08dbf0639939
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	HMjHjoCdEsm6eLLO3z3NFVOvs1MlMkKI1lPKqop+DZRBTbCRTgZP1vSIQ5BsLB2mDg3sMFJspghwmS4XM+cmNUEoChml+e0LDVtn1/8l5DcPq3JvXbEW7cth1yLSXBkqK12SJqhW8eR3tARXl7a4cy+kiJtvfV2OsOc2boq+eNTPPYCyHghYE+junepvE+JXqdvwE1sTyMjnmmIShWCr3yzcPiJl4lznxOzGRCMHrNWzZkxW/bzAPOY+5UMiBPdHMqcrZors1pdNSgyaE66YaZznatZ65fxCkNAVmBXF2+/vt/uaWXPYKJ5HZQFz/S9v5FEJq/RdMOPWDMZeUv4xi1lvUAQst+PO89uPrjlOBTPq0jpXw4AWnZtN+4+jY1sTLqzxOpELhm2ssnD0dAuOfYFd/HNIxu+osNPzmyeQNYVj0ELiSWqDjAM9tlLP4eXKStxXgUwS+3YgiN5QNuoC92ipnVcRnJfCOaDfLzi9imj8jjPHby3pu1ZIPjwkhgwC0TieNOFmvtqmJC9dokUBgD0QSuNoNMixb2fjoYrhODBoh9uX+t7zzRg/aCOdMlvfy+izXPbv/LQyO/rqxcFmhNtATYEbyBGj71qaU1nT0VJhYjlmCoOCF6uIyeK9dEGx5mEI4yOwT8gCYCjq4N36zOM1rkojY6JxBR2+Ge9gfbblxxBVs6OUFTORUKFUwRvX0hBtheCtQi1PO4J5SLU3xfZtQ41pYbHN0oTjCdFK6EFljR41cVrcMxCpx/iWNu20IzH08MckHOhGoWPvI0y8KokLEMpiZoSb8bHbAliXMIDsF64PZnfxuiXqH6jNJnTW
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(346002)(39860400002)(136003)(376002)(396003)(230922051799003)(451199024)(186009)(64100799003)(1800799012)(82310400011)(40470700004)(46966006)(36840700001)(4326008)(31696002)(8936002)(8676002)(53546011)(16576012)(110136005)(54906003)(316002)(40460700003)(478600001)(81166007)(356005)(47076005)(40480700001)(41300700001)(36756003)(31686004)(86362001)(336012)(44832011)(26005)(36860700001)(70586007)(2906002)(2616005)(426003)(83380400001)(70206006)(82740400003)(5660300002)(43740500002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Nov 2023 22:44:36.4793
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a19920cc-4315-4b02-fc16-08dbf0639939
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000044FD.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5352


On 11/24/23 07:09, Miquel Raynal wrote:
> Xilinx DMA engine is capable of keeping track of the number of elapsed
> periods and this is an increasing 32-bit counter which is only reset
> when turning off the engine. No need to add this value to our local
> counter.
>
> Fixes: cd8c732ce1a5 ("dmaengine: xilinx: xdma: Support cyclic transfers")
> Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
> ---
>
> Hello, so far all my testing was performed by looping the playback
> output to the recording input and comparing the files using
> FFTs. Unfortunately, when the DMA engine suffers from the same issue on
> both sides, some issues may appear un-noticed, which is likely what
> happened here as the tooling did not report any issue while analyzing
> the output until I actually listened to real audio now that I have in my
> hands the relevant hardware/connectors to do so.
> ---
>   drivers/dma/xilinx/xdma.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/dma/xilinx/xdma.c b/drivers/dma/xilinx/xdma.c
> index 84a88029226f..75533e787414 100644
> --- a/drivers/dma/xilinx/xdma.c
> +++ b/drivers/dma/xilinx/xdma.c
> @@ -754,7 +754,7 @@ static irqreturn_t xdma_channel_isr(int irq, void *dev_id)
>   	if (ret)
>   		goto out;
>   
> -	desc->completed_desc_num += complete_desc_num;
> +	desc->completed_desc_num = complete_desc_num;

Based on PG195, completed descriptor count will be reset to 0 on rising 
edge of Control register Run bit. That means it resets to zero for each 
transaction.

This change breaks our long sg list test.


Lizhi

>   
>   	if (desc->cyclic) {
>   		ret = regmap_read(xdev->rmap, xchan->base + XDMA_CHAN_STATUS,

