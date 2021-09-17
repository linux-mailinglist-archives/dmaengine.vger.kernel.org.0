Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1D95840F527
	for <lists+dmaengine@lfdr.de>; Fri, 17 Sep 2021 11:47:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241042AbhIQJtE (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 17 Sep 2021 05:49:04 -0400
Received: from mail-bn1nam07on2086.outbound.protection.outlook.com ([40.107.212.86]:52999
        "EHLO NAM02-BN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S241007AbhIQJtC (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Fri, 17 Sep 2021 05:49:02 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Eaqonl43s5Y8wmH7woW33uBq7djJElfmUMgS+tCMMLODbzmPdIgxirmpooe78G538JhfDfE16jrKr/V75VFvmMpwobdhfJ6CYxsJgmkeF7T4h7sZ3rQh/LaU1ckfFfjijWl6v9LU0T9tTMxwSNiFusUValxOXHPllgSwTjxYk9d5O5VZIbFsyuGgnmpfZy9Ei+yRdO5IE9qafpOU279D2WCVjKIb5Rs62oYjZsv/7Y20F1jwD1pFGUZQXAjXllWXonDyeGnFpiuQ1s4vaGvK1SiaR1xRwTA7t8JU+6vSDqkUKWsFwU+ZnxQEG2wPk8hFHMiMAC98Xz2cW5pJX7BK4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=9ukr/o1CrJAjnuw0ykmX1A3GLvkfr7MW51uhWY225QU=;
 b=HuBEDk7WeeTqIjf5Z45tpHB2cUVItx/TnsSv6sAo6Pf4JlupBZoQ1XLGo9TUcs0zhzRN/8nR3tibPChusOBwD3taGE5ks7yVnQVCewqBaZmpr6VtA8cKL40+3q7DpALFriq6lh/a2lK2WeROtehLsfnvI5P3yaAZA15tTiPiQSfyjo2wNeZlFuJjk2utaB4b+n13AUO1kfH3cFl/i0QuAusdwsx0YYivrVLkl0JSmBt/sm2i5ko/0pdqpX/M4Csk4sMJkF2AKUAdsLqRY/10olYuaMRN2mit6qM2W3Hzj0Z8aT7eDzE9+sg1xryaCxtXICoymnKh1lnx2xCAjs3qEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.112.32) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9ukr/o1CrJAjnuw0ykmX1A3GLvkfr7MW51uhWY225QU=;
 b=iJrzWVBt0dRqUGrGEEMN1Iyvgi7SoCIyqyVuyGSU/K3MgS4zffU2N/mEfb/0jlXVU8vnySvsZWA5MHO7MogTJKj7hkhTJeCHWSDgbyd+dPu1WYUMGlxb51tlYRQk0x134wIFVZbxfGHRxQXDtRwiKN7Y3vMHFtksRVOoScyJLh3q2DjI2Xb3dMa3a8WMHhmOWv0akSoKsNNTIucedtc2BmuHT8WweW4aA3A08EtQgbcb5bc5eAjGxH1V7h/9XKOiN6bD5zeK7xT30R3Yds+U++doR0bXb+rzREGbgI/ywdKem33a09Ip20/W/1EpPyLP8d4bxQKCXsl+hTvc84x2+w==
Received: from DM5PR2001CA0007.namprd20.prod.outlook.com (2603:10b6:4:16::17)
 by MN2PR12MB4519.namprd12.prod.outlook.com (2603:10b6:208:262::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4523.14; Fri, 17 Sep
 2021 09:47:38 +0000
Received: from DM6NAM11FT058.eop-nam11.prod.protection.outlook.com
 (2603:10b6:4:16:cafe::b6) by DM5PR2001CA0007.outlook.office365.com
 (2603:10b6:4:16::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4523.14 via Frontend
 Transport; Fri, 17 Sep 2021 09:47:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.112.32)
 smtp.mailfrom=nvidia.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.112.32 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.112.32; helo=mail.nvidia.com;
Received: from mail.nvidia.com (216.228.112.32) by
 DM6NAM11FT058.mail.protection.outlook.com (10.13.172.216) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4523.14 via Frontend Transport; Fri, 17 Sep 2021 09:47:37 +0000
Received: from DRHQMAIL107.nvidia.com (10.27.9.16) by HQMAIL109.nvidia.com
 (172.20.187.15) with Microsoft SMTP Server (TLS) id 15.0.1497.18; Fri, 17 Sep
 2021 02:47:37 -0700
Received: from [10.26.49.12] (172.20.187.6) by DRHQMAIL107.nvidia.com
 (10.27.9.16) with Microsoft SMTP Server (TLS) id 15.0.1497.18; Fri, 17 Sep
 2021 09:47:35 +0000
Subject: Re: [RESEND PATCH 2/3] dmaengine: tegra210-adma: Add description for
 'adma_get_burst_config'
To:     Sameer Pujar <spujar@nvidia.com>, <vkoul@kernel.org>,
        <ldewangan@nvidia.com>, <thierry.reding@gmail.com>
CC:     <dmaengine@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <1631722025-19873-1-git-send-email-spujar@nvidia.com>
 <1631722025-19873-3-git-send-email-spujar@nvidia.com>
From:   Jon Hunter <jonathanh@nvidia.com>
Message-ID: <5eb80e74-f147-42ec-e757-d29008a4e796@nvidia.com>
Date:   Fri, 17 Sep 2021 10:47:33 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <1631722025-19873-3-git-send-email-spujar@nvidia.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [172.20.187.6]
X-ClientProxiedBy: HQMAIL101.nvidia.com (172.20.187.10) To
 DRHQMAIL107.nvidia.com (10.27.9.16)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9a9b12ab-4376-4a82-3215-08d979c02f2c
X-MS-TrafficTypeDiagnostic: MN2PR12MB4519:
X-Microsoft-Antispam-PRVS: <MN2PR12MB45196CD095D6BB9BF15472B2D9DD9@MN2PR12MB4519.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2089;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /EfhKT9XM057o3fHotU6+9xzPt/jZGx4QeDi1xMsZS8ZPhzxLZ2TzslCkcOSWChYe2RCIsFKa6pauDJX1rgiAH7/ORhDmtlxYbGNw9XXzz1FKttxKbqnPQ3k7e4EwxVLy0I7Rg1XGY2s6G8nNs5DpXtd44M4JYkHDN3VB2gKgRRFiuHXkYvxXmc6CkJ3u0pNA4qCQ/fc6OAaRnlCBlRBm+hPLnNcNDN3Wg+X16QRxbD1DO2+wV7dyWk1ZScpXnkzWyC34Fl2mwf3LFG4RTZv5tMfT9OUIX4qI2C8Q6WIs13G98LGmx/MRrr1zwV2h3evYONMtYL7J8LO+vzWp+2cFi1Q9bnT+vuzgq8DuVuhFq8PqAOBHN5YX+tMcEMp2lei9gpIXsQMY+3RTdykUJ8KvMXLCHDtthVq/Q7KPKqp6SeyTKTt9BNJY7l7OcBxPR9j1iA/DuAAF9ok2GmYoGdRKQ9ts3hL6ji3jQV4eTfsWT+250V88MSrz1VNA+jvnKgwZzG/J41nERWL+28JFpd+ETsUmEhcPk57cu44/5iCb1IIZbBc2PDH8DYJG/PcIUPyo31iL6Aw3sSV8n/kl7aQXcJmWiXg5LtQ4sk2qTx3EweHOwe+ojj4EOJhalSd+6kYaJFc/mCNyKcWL0AlpQzMbPDzjBsIdLkR30B/AhNXY2fRukrL5DIRCOoPwprJ0Uk5K9KRNzUJFASfzji+d3tafdQBOqiCXsatKwMoMlxp17o=
X-Forefront-Antispam-Report: CIP:216.228.112.32;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:schybrid01.nvidia.com;CAT:NONE;SFS:(4636009)(36840700001)(46966006)(47076005)(7636003)(426003)(82310400003)(36860700001)(31686004)(316002)(16576012)(2906002)(8936002)(31696002)(5660300002)(54906003)(4744005)(110136005)(4326008)(16526019)(186003)(70586007)(26005)(70206006)(86362001)(8676002)(356005)(508600001)(36756003)(53546011)(336012)(2616005)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Sep 2021 09:47:37.9234
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9a9b12ab-4376-4a82-3215-08d979c02f2c
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.112.32];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT058.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4519
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org


On 15/09/2021 17:07, Sameer Pujar wrote:
> Trivial change to add description for 'adma_get_burst_config' in chip
> data structure.
> 
> Fixes: 433de642a76c ("dmaengine: tegra210-adma: add support for Tegra186/Tegra194")
> Signed-off-by: Sameer Pujar <spujar@nvidia.com>
> ---
>   drivers/dma/tegra210-adma.c | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/dma/tegra210-adma.c b/drivers/dma/tegra210-adma.c
> index caf200e..03f9776 100644
> --- a/drivers/dma/tegra210-adma.c
> +++ b/drivers/dma/tegra210-adma.c
> @@ -73,6 +73,7 @@ struct tegra_adma;
>   
>   /*
>    * struct tegra_adma_chip_data - Tegra chip specific data
> + * @adma_get_burst_config: Function callback used to set DMA burst size.
>    * @global_reg_offset: Register offset of DMA global register.
>    * @global_int_clear: Register offset of DMA global interrupt clear.
>    * @ch_req_tx_shift: Register offset for AHUB transmit channel select.
> 

Reviewed-by: Jon Hunter <jonathanh@nvidia.com>

Cheers
Jon

-- 
nvpublic
