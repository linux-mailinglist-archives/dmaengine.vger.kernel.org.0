Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A8E9D358355
	for <lists+dmaengine@lfdr.de>; Thu,  8 Apr 2021 14:33:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229964AbhDHMdS (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 8 Apr 2021 08:33:18 -0400
Received: from mail-dm6nam11on2077.outbound.protection.outlook.com ([40.107.223.77]:7072
        "EHLO NAM11-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229837AbhDHMdS (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Thu, 8 Apr 2021 08:33:18 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gYGLSwUQ5qAOPstZ4M4kAP3q5FD61O/7CA8mfNaodz8jqn93o2DGAr0OsrsonUGsO7/QsSXiSG5wZMH+JAYThzZA3o3pvUUgXiNbQwd1DLRwMXjDdT827nBprG6IspdEMEeyzmSIn8jd7Hja3Sgs9YkW6SbqaaWJj3yAeHGtZihOzfIYZcUcXDEUgqouRrBwk36LB81c+pikbhCG8qCbvPkBXrejbNQdO4so9MKhbTiBfssITeaawdFRkle1yy1/M529/GiKaHkBMPfvlliqZcPBjxmi/K1h7kWe5y9ZRWrvfy+sA5YskcimGzGEDlVldkbGctEzi4nsP2JV0MJ90g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Yfuvbvqk2Df9Vx4KTvZ5+oDgZvpC2qoRM9LFPZVVDDU=;
 b=H2X+H2b9iTFyrhqolcfv2blLTr/z+uJfd1PG3NULuWQ1lOo9O5DQDqQiuHKhbcHiMqellYWkCnOTo5Z6cRT68WrV2iiDpucHYZsEhjqv/P/os7TVsj3x70yptkfDXVQgxy04oGLr90bDKBkh+sicW3RVTvs5fsnli9DX2xXbR+IyUjIuYFHl6u9d7tqGm/0GjsjbDe3MqsaOm0rzMU+eTy9z2VJMrULFr6eHlmxbhtH2pdE2md3gk8U16KDiFHXFyc3Bz2nYkRxcSFIUF2EO2UIeJQcZ2rptz8mb3efEbSnfbWfqmCvYAx8tYH3ZfXfXccvLiVnNqwJTQ5pcIaaHGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.112.34) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Yfuvbvqk2Df9Vx4KTvZ5+oDgZvpC2qoRM9LFPZVVDDU=;
 b=f0b8TYcywv2Bp7LP6To2E3pivfa6r/+t+fPd5dB3SgqWxDOIpYw2qJjSp+wPP2YZRcVnSxSEB8m5qWxOTjU0d2yhSEFF7mys5wE2jOL3BksCjqQMPU3ovWKQRT1WEpr+g/Ye9dNj9dfBTXGB/EIFydo9RkJAKXi/sOM2UQlAmgjMx0UEj+YYvaA3rrMLXCs31LQsQ3QQShW6Wele/0QhsmAigBl7HMYmZ8FP6zJfDlpu43gS8UEzM/7ChSUMfdJ6DvtWCJIVRFNjZ5Y1lTYyiH6UjBmCZ/rh95f2+4+wUB6RoiuMX4mh00/saz7rGlZmId8Bo9K42R3rnwU7wSdllw==
Received: from BN6PR16CA0010.namprd16.prod.outlook.com (2603:10b6:404:f5::20)
 by CH2PR12MB4309.namprd12.prod.outlook.com (2603:10b6:610:a4::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3999.27; Thu, 8 Apr
 2021 12:33:05 +0000
Received: from BN8NAM11FT005.eop-nam11.prod.protection.outlook.com
 (2603:10b6:404:f5:cafe::c1) by BN6PR16CA0010.outlook.office365.com
 (2603:10b6:404:f5::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4020.16 via Frontend
 Transport; Thu, 8 Apr 2021 12:33:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.112.34)
 smtp.mailfrom=nvidia.com; kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.112.34 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.112.34; helo=mail.nvidia.com;
Received: from mail.nvidia.com (216.228.112.34) by
 BN8NAM11FT005.mail.protection.outlook.com (10.13.176.69) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4020.17 via Frontend Transport; Thu, 8 Apr 2021 12:33:05 +0000
Received: from [10.26.49.14] (172.20.145.6) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Thu, 8 Apr
 2021 12:33:02 +0000
Subject: Re: [PATCH] dmaengine: tegra20: Fix runtime PM imbalance in
 tegra_dma_issue_pending
To:     Dinghao Liu <dinghao.liu@zju.edu.cn>, <kjlu@umn.edu>
CC:     Laxman Dewangan <ldewangan@nvidia.com>,
        Vinod Koul <vkoul@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        <dmaengine@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <20210408071158.12565-1-dinghao.liu@zju.edu.cn>
From:   Jon Hunter <jonathanh@nvidia.com>
Message-ID: <5699d0e9-968c-c8b0-3b0b-0416b5b48aa0@nvidia.com>
Date:   Thu, 8 Apr 2021 13:33:00 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <20210408071158.12565-1-dinghao.liu@zju.edu.cn>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [172.20.145.6]
X-ClientProxiedBy: HQMAIL107.nvidia.com (172.20.187.13) To
 HQMAIL107.nvidia.com (172.20.187.13)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9846f973-2fee-4543-5255-08d8fa8a758c
X-MS-TrafficTypeDiagnostic: CH2PR12MB4309:
X-Microsoft-Antispam-PRVS: <CH2PR12MB4309F0CE309AC93863985373D9749@CH2PR12MB4309.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5236;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 59k4wV/DALWn/VjJZFAQFJ2n0nU5JuZ8HrNqjkXRWRSRH6I37obxXuP85feI8u+coLwWD83xvLVbyFG+7trDMKEqrOTZY/dCLuEwKKLFZd6ogPYl3plhBtb+JxQlGj6EMVXyaBHHCOz8waGDngU18n/MhFfC9OlwvWLcUmHyeTuPIHPlwxSGN+xiYcSWA9uQ8UKS86x7f8oKKbbAMetaaS8ulqV9PmdbXC6I73zvZTDP7GW86GMizeQMU0on4qo0UVva450MyP39QoSpgDXhGChAJOcC5dn1awlWM+nNOewoehyReKxVwkdXtxu/wgBhGBqWgcXGI03n378AjL2XwB3ZTcaw+I9r4EeI0U9KdHRDXuDrJYkh1FcT5VpjDYxUFQmTX0K+X7URt7YI16tP2Bi0cVa5VoSBAAfQCPVdI71l85tEYzt92xT+yYESpHfbI95pFt0mg6LiZv5xuVAaEbzPXGIlUNzt+pN4biE2QcoZnpC3iX/e7j/lFq99eI77OS/OeL3TVMVFgJ1NNG/E4vBrMlZORlu0AYgBkzgpzcM4AVI/YKnyTffKgcZBjcdcZwDTtyFnBZA9L+XwRf7NaU3i7u4jb+DhUOT0xVIjTEhm4bjX5jGOG/WU1bjjWLBd418GMNLd5UHBJoM0GJfOtW0ghVkpVPX8/bZ/ltBySoZUeQHHS2y5ZLMN4UspAed/
X-Forefront-Antispam-Report: CIP:216.228.112.34;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:schybrid03.nvidia.com;CAT:NONE;SFS:(4636009)(376002)(136003)(39860400002)(396003)(346002)(36840700001)(46966006)(47076005)(2616005)(8936002)(8676002)(86362001)(478600001)(82740400003)(2906002)(53546011)(36906005)(5660300002)(316002)(31696002)(16576012)(54906003)(110136005)(36860700001)(70586007)(26005)(83380400001)(31686004)(82310400003)(186003)(16526019)(4326008)(36756003)(336012)(70206006)(7636003)(356005)(426003)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Apr 2021 12:33:05.5597
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9846f973-2fee-4543-5255-08d8fa8a758c
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.112.34];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT005.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4309
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org


On 08/04/2021 08:11, Dinghao Liu wrote:
> pm_runtime_get_sync() will increase the rumtime PM counter
> even it returns an error. Thus a pairing decrement is needed
> to prevent refcount leak. Fix this by replacing this API with
> pm_runtime_resume_and_get(), which will not change the runtime
> PM counter on error.
> 
> Signed-off-by: Dinghao Liu <dinghao.liu@zju.edu.cn>
> ---
>  drivers/dma/tegra20-apb-dma.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/dma/tegra20-apb-dma.c b/drivers/dma/tegra20-apb-dma.c
> index 71827d9b0aa1..73178afaf4c2 100644
> --- a/drivers/dma/tegra20-apb-dma.c
> +++ b/drivers/dma/tegra20-apb-dma.c
> @@ -723,7 +723,7 @@ static void tegra_dma_issue_pending(struct dma_chan *dc)
>  		goto end;
>  	}
>  	if (!tdc->busy) {
> -		err = pm_runtime_get_sync(tdc->tdma->dev);
> +		err = pm_runtime_resume_and_get(tdc->tdma->dev);
>  		if (err < 0) {
>  			dev_err(tdc2dev(tdc), "Failed to enable DMA\n");
>  			goto end;
> 


Thanks! Looks like there are two instances of this that need fixing.

Cheers
Jon

-- 
nvpublic
