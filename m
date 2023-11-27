Return-Path: <dmaengine+bounces-245-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AA6D7FA6B4
	for <lists+dmaengine@lfdr.de>; Mon, 27 Nov 2023 17:43:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1EA781F20EE8
	for <lists+dmaengine@lfdr.de>; Mon, 27 Nov 2023 16:43:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F56A35888;
	Mon, 27 Nov 2023 16:43:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="r407ULE2"
X-Original-To: dmaengine@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2066.outbound.protection.outlook.com [40.107.243.66])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D5521A3;
	Mon, 27 Nov 2023 08:43:50 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YJyUAbJIx3cVFSImyMD4gGGl92GXFW03Rd+rFpdQUJJq9RV7hFQRFO9LZoHgQWtqO/rpd9RmsOoRpOcZMeYABOpxAfH97PfZrR10uCvsL2oWOj6Mpg57PbfOmhjhK0l1MNUCdflhsTONvikhG0Ppz0XGzquji4J5vjIHLDtkcIqSkJQ1NoH3uKPnpQg/9El+iJSm/7j2bZhc2WCRuUKuzvZjIR5eVvkBUe+49znhw3ZmgV2R8nJfah9BeUTr7ry8PPQi2SFlwMIzhaF0o55tq6bsCsgIi8+T+bFcFXUa2rAleddioWhwOnbdBPXhUM31SpEiPHPTWKSDsj2Oi3QhJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MasThqGt5D++0XMOHAjqPr/LMlDmaITjQnrL6ejt/H8=;
 b=MEYeMEfPJXXD2Qd3qp90PX10dCK5ACcM6FNlRMTlmv7nBZPIMzFrx+Km0SUS6gHkySb9G/6mNZKnpneGtHd6Zkbe4ORUo6Rv6zcSp5pgWOn1dUEgo5eURy/o2iqe3jb2qSIC/Ivv11CfaKYSE5Wlo1gWY+WIpkp4qilHpqHSBeECYcUwU0PP+koP4//RlEezO2OZCY9Kh4khJ3QmlJ+aush7S9l7o5TEX9MevCpyegKF8Qws/r1Zh2Tq7dYTz7thR+82dkIwm+xib9IyCGLY/+W2h+LNW7SnHicVCRcDsBXEMOetUlcag5aY3xb+rfDUyXtKhDTXip3giKx/9zPSfA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=alatek.krakow.pl smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MasThqGt5D++0XMOHAjqPr/LMlDmaITjQnrL6ejt/H8=;
 b=r407ULE26wcTxgT0VF+k4P6eWFv+pOMaEFwWMRVp+bOUXUeoNcMcPzCjDenUyKv1RgxHUlhnM6XdXcCZjVm8Ny0QRXBHp1xPj3o+73MMEjxrzozGWuMUFvRC2JhQcoMl28LpnCEBpj+d2YBYITotzDM8ONwwyPMScDb3/QWEKNU=
Received: from SJ0PR03CA0346.namprd03.prod.outlook.com (2603:10b6:a03:39c::21)
 by SJ2PR12MB9191.namprd12.prod.outlook.com (2603:10b6:a03:55a::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.27; Mon, 27 Nov
 2023 16:43:46 +0000
Received: from CO1PEPF000042AD.namprd03.prod.outlook.com
 (2603:10b6:a03:39c:cafe::6d) by SJ0PR03CA0346.outlook.office365.com
 (2603:10b6:a03:39c::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.28 via Frontend
 Transport; Mon, 27 Nov 2023 16:43:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CO1PEPF000042AD.mail.protection.outlook.com (10.167.243.42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7046.17 via Frontend Transport; Mon, 27 Nov 2023 16:43:45 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Mon, 27 Nov
 2023 10:43:45 -0600
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Mon, 27 Nov
 2023 10:43:44 -0600
Received: from [172.19.74.144] (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.34 via Frontend
 Transport; Mon, 27 Nov 2023 10:43:44 -0600
Message-ID: <401bc91f-f558-8185-8f14-dd1ef41aef17@amd.com>
Date: Mon, 27 Nov 2023 08:43:44 -0800
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v3 5/5] dmaengine: xilinx: xdma: Ease dma_pool alignment
 requirements
Content-Language: en-US
To: Jan Kuliga <jankul@alatek.krakow.pl>, <brian.xu@amd.com>,
	<raj.kumar.rampelli@amd.com>, <vkoul@kernel.org>, <michal.simek@amd.com>,
	<dmaengine@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<runtimeca39d@amd.com>
References: <20231124192524.134989-1-jankul@alatek.krakow.pl>
 <20231124192558.135004-6-jankul@alatek.krakow.pl>
From: Lizhi Hou <lizhi.hou@amd.com>
In-Reply-To: <20231124192558.135004-6-jankul@alatek.krakow.pl>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000042AD:EE_|SJ2PR12MB9191:EE_
X-MS-Office365-Filtering-Correlation-Id: 0de92afe-1fa6-4583-a588-08dbef680618
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	PVhWfiJTRzEiikLj+CILRLb6SOJRLuB1TztsksV1SF4V1IPzTVFOclKG6MXSvWfG7zh4QhNZqiVkIMx80Ph3VUaLewrmJ6d6TvwIeC8Wefgn7p6dhMeTpOAD0EOh02MFXLN/hfIZAMEkFP1Gnlv102rRIe0DoM8JQJ6JUDoSb+Ki26N58VBqD7g5N7VmLkW/PgtXrmOROtOYjT94u0HOI+Brciwbpqamfe82Lyh8m1LTunZOSrQRbUYqFC1STnaPgHn+WbdFakQibNGnUhmFFSSX18awJAsFKzIp/wGQ6X33jX+q/8/bZIpScEnpEKmav/AiwLjtjm6OyJA7KbXD6ekn542Mz8THNojImemiCMygJ7rIEovy+plOEKuQ1jlbzBzyrepWBS2a22XwM598VuvewqoIo/vEj78oCJllq5nLtR16IDPj8bGVW1Tv/59tkfRwHT0Wc8B9ug3hMZsc4gfgXlYgGE9Z1df9yiEam2+SKqWZ92BM8a4bVJDi2SaQgVPrR4VFcty1lvhB6OAh6b32OuIkKdbrLDqKd1akjjLrjcQFSY/o0yeeEDObAFWGaDMyGnqxKj+6gDdcsKrKJw5HmIKHsZSIQm0z+WCtl5Br1UIgs2Bxhpqcs1LYTsmwYdWUPITsfm2m09nwtAzTgocksoZHX7jXsoTKn6OpB8vJBXZmv3FI3xYYNgajWrRXY3NMQo89NpXFBo2d0FkR9ZlMnlPSPRmXHwWEJXbkANhqjnlTNJFlnnhj4S+emiol+dFHRBCeypMDW8ij8G/+usFk0/26Msf3cJLbVy3hjqJcOGwPWTYvrMLFlJxeZCKf
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(346002)(136003)(376002)(396003)(39860400002)(230922051799003)(1800799012)(82310400011)(64100799003)(186009)(451199024)(36840700001)(40470700004)(46966006)(40480700001)(41300700001)(36756003)(31686004)(81166007)(47076005)(356005)(36860700001)(336012)(83380400001)(426003)(5660300002)(82740400003)(70206006)(26005)(44832011)(86362001)(2616005)(2906002)(70586007)(53546011)(8676002)(8936002)(31696002)(478600001)(40460700003)(16576012)(6636002)(110136005)(316002)(43740500002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Nov 2023 16:43:45.9410
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0de92afe-1fa6-4583-a588-08dbef680618
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000042AD.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB9191


On 11/24/23 11:25, Jan Kuliga wrote:
> According to the XDMA datasheet (PG195), the address of any descriptor
> must be 32 byte aligned. The datasheet also states that a contiguous
> block of descriptors must not cross a 4k address boundary. Therefore,
> it is possible to ease the pressure put on the dma_pool allocator
> just by requiring sufficient alignment and boundary values. Add proper
> macro definition and change the values passed into the
> dma_pool_create().
>
> Signed-off-by: Jan Kuliga <jankul@alatek.krakow.pl>
> ---
>   drivers/dma/xilinx/xdma-regs.h | 7 ++++---
>   drivers/dma/xilinx/xdma.c      | 6 +++---
>   2 files changed, 7 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/dma/xilinx/xdma-regs.h b/drivers/dma/xilinx/xdma-regs.h
> index 6bf7ae84e452..d5cb12e6b8d4 100644
> --- a/drivers/dma/xilinx/xdma-regs.h
> +++ b/drivers/dma/xilinx/xdma-regs.h
> @@ -64,9 +64,10 @@ struct xdma_hw_desc {
>   	__le64		next_desc;
>   };
>   
> -#define XDMA_DESC_SIZE		sizeof(struct xdma_hw_desc)
> -#define XDMA_DESC_BLOCK_SIZE	(XDMA_DESC_SIZE * XDMA_DESC_ADJACENT)
> -#define XDMA_DESC_BLOCK_ALIGN	4096
> +#define XDMA_DESC_SIZE			sizeof(struct xdma_hw_desc)
> +#define XDMA_DESC_BLOCK_SIZE		(XDMA_DESC_SIZE * XDMA_DESC_ADJACENT)
> +#define XDMA_DESC_BLOCK_ALIGN		32
> +#define XDMA_DESC_BLOCK_BOUNDARY	4096
>   
>   /*
>    * Channel registers
> diff --git a/drivers/dma/xilinx/xdma.c b/drivers/dma/xilinx/xdma.c
> index de4615bd4ee5..d32ae93e18b6 100644
> --- a/drivers/dma/xilinx/xdma.c
> +++ b/drivers/dma/xilinx/xdma.c
> @@ -735,9 +735,9 @@ static int xdma_alloc_chan_resources(struct dma_chan *chan)
>   		return -EINVAL;
>   	}
>   
> -	xdma_chan->desc_pool = dma_pool_create(dma_chan_name(chan),
> -					       dev, XDMA_DESC_BLOCK_SIZE,
> -					       XDMA_DESC_BLOCK_ALIGN, 0);
> +	xdma_chan->desc_pool = dma_pool_create(dma_chan_name(chan), dev,
> +				XDMA_DESC_BLOCK_SIZE, XDMA_DESC_BLOCK_ALIGN,
> +						XDMA_DESC_BLOCK_BOUNDARY);
>   	if (!xdma_chan->desc_pool) {
>   		xdma_err(xdev, "unable to allocate descriptor pool");
>   		return -ENOMEM;

This is probably not needed. The 32 adjacent descriptors here is 1024 
bytes. Defining 4k alignment should be good enough.

Thanks,

Lizhi



