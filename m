Return-Path: <dmaengine+bounces-675-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ACE17823194
	for <lists+dmaengine@lfdr.de>; Wed,  3 Jan 2024 17:52:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 692401C2074F
	for <lists+dmaengine@lfdr.de>; Wed,  3 Jan 2024 16:52:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BAB71C282;
	Wed,  3 Jan 2024 16:52:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="YmBLx75w"
X-Original-To: dmaengine@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2086.outbound.protection.outlook.com [40.107.244.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C7C61C281
	for <dmaengine@vger.kernel.org>; Wed,  3 Jan 2024 16:52:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OISZ3mgbDHVd2NBzDdELNqPHuxyPfvRcqNR0fn7AHJ9q5IUxqdCXN/1fGAfBKdrnInQRvFxsXMZ/AEVwD7rzUIRvojaUWPhpS5Qw4kPJyngVivMk1dJosucntWzKNkGn6JKVer3G5C9O98VM0MMVcqoyO/MEDpBit/ky1acBkzfzFzT1mnaqFprm4UMw1alcJy2nXkuh+r6FRICKMjrRhh/I556PXCiIoPjcO89ZOw7YTbORZ1ntsTP+XVR+n7tZJ7LmZuM0HPwPnFjIv/jpzMaPRjmGeqD42QL8KxJO9AW4IWaztisUKNuW88MhBTTR6dWUWSsoUGwECU8G/I0G8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qemyxWshljlF3C2FErPN3b8tXTIpeDk+0OgPg9g96L4=;
 b=kI1wi7dgyfqNW4fK6ee2ZSltGCEAnGRWCV/5/towwj/KNuf7/aec7x7M8E1aEq5XwQNNje8Kw9L7LvmYdoQaAvv2mfP6LMlzKqZS9mTAPqmnmUATtxdWP8HGn7HVioX/5n2LIgNRUTbtsquZCPgpaMiw0qh8XRjHAOyque4yvHTKrLgkCC86MoZaH2wk47vYA7SKpwbeNtTQ4HIkOJcj4H1urLSMPH4p9WuLOxfcvQmxFzr87gH3QeaaUd097aDiZp/J9VNHTpqFe6Oh3JoL5BN6Ebjzxcke5C03odUH8vpZXxCVnFCEYlkymnExzL7uOg+goFY3jo4BfINPNKwzXg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qemyxWshljlF3C2FErPN3b8tXTIpeDk+0OgPg9g96L4=;
 b=YmBLx75wSXQlNIOzfbBfeJpr40GW4agtxmdCJELvbuD2cm+yLNvXnzWL6rK1VyDUsBIAEBXr5rX91NGKIOxP8vB6/Pbj+PA803P7mj3x3lER4xnNLR9FJdccSsOZ0s2DC7g+8MW1ShEWM6OUFW+dLaSfB+/HXfUbXvsRM/711w4=
Received: from PH8PR21CA0012.namprd21.prod.outlook.com (2603:10b6:510:2ce::6)
 by DS7PR12MB8346.namprd12.prod.outlook.com (2603:10b6:8:e5::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7135.25; Wed, 3 Jan
 2024 16:52:19 +0000
Received: from SN1PEPF0002BA50.namprd03.prod.outlook.com
 (2603:10b6:510:2ce:cafe::e7) by PH8PR21CA0012.outlook.office365.com
 (2603:10b6:510:2ce::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7181.4 via Frontend
 Transport; Wed, 3 Jan 2024 16:52:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF0002BA50.mail.protection.outlook.com (10.167.242.73) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7159.9 via Frontend Transport; Wed, 3 Jan 2024 16:52:18 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Wed, 3 Jan
 2024 10:52:18 -0600
Received: from [172.19.74.144] (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.34 via Frontend
 Transport; Wed, 3 Jan 2024 10:52:17 -0600
Message-ID: <e86f5dec-8de0-a6ba-50aa-fc6900bad241@amd.com>
Date: Wed, 3 Jan 2024 08:52:17 -0800
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH] dmaengine: xilinx: xdma: Workaround truncation
 compilation error
Content-Language: en-US
To: Vinod Koul <vkoul@kernel.org>, <dmaengine@vger.kernel.org>, Brian Xu
	<brian.xu@amd.com>, Raj Kumar Rampelli <raj.kumar.rampelli@amd.com>, "Michal
 Simek" <michal.simek@amd.com>
References: <20231222094017.731917-1-vkoul@kernel.org>
From: Lizhi Hou <lizhi.hou@amd.com>
In-Reply-To: <20231222094017.731917-1-vkoul@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002BA50:EE_|DS7PR12MB8346:EE_
X-MS-Office365-Filtering-Correlation-Id: e1bd3cb2-5775-4c4e-abb1-08dc0c7c58f6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	4Nt2iN3twfPH/gykdxR2582zGDHAaXfyDMeOiF0YoJMfDZoviTCtHKYDIo2EHAzBKDEocQ1FvcRcV/XbRraKop2iD46z4ehVkjKcfdfbFX75ur7b1UmFy1M8zBnj18LuztTjM8tVghBJ0Sa34f7lLXaJ0+2m0605Zi+Xydl+c03MQsCyg7VJEGm0yA01dDoaekvTq26JEMPoQUHXhHXdB2P4nNu0aOVESXWm2SCIEua3VtfTqzQjy+ASveXkUv4tGaPRX9FrgJ/H7oLN8TDA0BY/xXveezScWnPuRzI8jNpEl4yFIdeyWiAtzKrpp8/Ts9D0WNZOWXQjmMYvxQPeH+glf/y7a17lsp4eZ9bfnMCk5zxMTlEGxc8708MvR6Q2Vpw9+6UnOX0UtvaAOW+mshoht9mnr3tyn31CHJ/t2SaatbWMViByApSnOzyaFMVJs+qI8DhZqB6f3qiUPIgqY3fviEQW0bkHuaVyMwnjBn7+/LM+IEsRv2GpmRlfGfFbh3X2K+DZoy5OE9kTswUgF+9ZpYjwBMRiBUoRXegmmKY3rEs0ybXPvV8ijVWPL9hSbjHTWaHkIrWMtb4fuJPFwfH+QyzR82d1vdAYivd0tN1wAqmGWwYsgY7h/cUYbWtRW+w2ZSuPsB/iOVyWMzb59I9DIfhRvwtLhu8EvzeG1LGAUVu2hX/0G9l5PE73qdS8sCuct2QLQcgnlOfyaheXgjbhlRHELwShzY7bVySjjYZO3QUpUYLe8UB6sSWqE9ajux5s+zRVklKa3zjSg2GrLubp17YmzE0Ees5iX8GQt2De8w/sWy4w6VzIy6/fX9dH
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(376002)(346002)(396003)(136003)(39860400002)(230922051799003)(1800799012)(451199024)(186009)(64100799003)(82310400011)(36840700001)(46966006)(40470700004)(5660300002)(2906002)(31696002)(44832011)(41300700001)(478600001)(81166007)(86362001)(82740400003)(83380400001)(426003)(336012)(356005)(26005)(2616005)(36756003)(47076005)(53546011)(36860700001)(8936002)(16576012)(316002)(8676002)(70206006)(110136005)(6636002)(70586007)(40480700001)(31686004)(40460700003)(36900700001)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jan 2024 16:52:18.7181
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e1bd3cb2-5775-4c4e-abb1-08dc0c7c58f6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF0002BA50.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB8346

Hi Vinod,

This fix should be xilinx_dpdma driver. (dmaengine: xilinx: xilinx_dpdma)

Thanks,

Lizhi

On 12/22/23 01:40, Vinod Koul wrote:
> Increase length to be copied to be large enough to overcome the
> following compilation error. The buf is large enough for this purpose.
>
> drivers/dma/xilinx/xilinx_dpdma.c: In function ‘xilinx_dpdma_debugfs_desc_done_irq_read’:
> drivers/dma/xilinx/xilinx_dpdma.c:313:39: error: ‘snprintf’ output may be truncated before the last format character [-Werror=format-truncation=]
>    313 |         snprintf(buf, out_str_len, "%d",
>        |                                       ^
> drivers/dma/xilinx/xilinx_dpdma.c:313:9: note: ‘snprintf’ output between 2 and 6 bytes into a destination of size 5
>    313 |         snprintf(buf, out_str_len, "%d",
>        |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>    314 |                  dpdma_debugfs.xilinx_dpdma_irq_done_count);
>        |                  ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>
> Signed-off-by: Vinod Koul <vkoul@kernel.org>
> ---
>   drivers/dma/xilinx/xilinx_dpdma.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/dma/xilinx/xilinx_dpdma.c b/drivers/dma/xilinx/xilinx_dpdma.c
> index 69587d85a7cd..b82815e64d24 100644
> --- a/drivers/dma/xilinx/xilinx_dpdma.c
> +++ b/drivers/dma/xilinx/xilinx_dpdma.c
> @@ -309,7 +309,7 @@ static ssize_t xilinx_dpdma_debugfs_desc_done_irq_read(char *buf)
>   
>   	out_str_len = strlen(XILINX_DPDMA_DEBUGFS_UINT16_MAX_STR);
>   	out_str_len = min_t(size_t, XILINX_DPDMA_DEBUGFS_READ_MAX_SIZE,
> -			    out_str_len);
> +			    out_str_len + 1);
>   	snprintf(buf, out_str_len, "%d",
>   		 dpdma_debugfs.xilinx_dpdma_irq_done_count);
>   

