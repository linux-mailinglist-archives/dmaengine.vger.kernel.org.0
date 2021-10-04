Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0130142130A
	for <lists+dmaengine@lfdr.de>; Mon,  4 Oct 2021 17:49:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235947AbhJDPv1 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 4 Oct 2021 11:51:27 -0400
Received: from mail-mw2nam12on2043.outbound.protection.outlook.com ([40.107.244.43]:21856
        "EHLO NAM12-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S235939AbhJDPv1 (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Mon, 4 Oct 2021 11:51:27 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WVDLK9M1pbNT0UKmsEXVuS0D/OxcznkcZeJ+mz3Mjo15dix3BUVYHJ0BBApbbzV6A6UCd5K5CYoZQVZQU0vlN/aLj/RHgcitKx0wpcNG7iasiGEKPD4g/B9OCx1SKqlHmMRQYEt/Xsxouj3zAZ3WNpAdnwqx6JFljESxz8A6Abtmo04Y6eaLvvMejhdsLY5rpzsIdp48L9dlEwXUN/rd1dFGuBaZqJybVwsFOYHMMq7fmfL+BNh57y2MDHgQgqC19rB7XtD1+2Hx1r85oUNAwK2wPi+D1/7UjMbyebEKp8cd2h0ZUOiO5qXCkiuF4GJVYsb22jxSVg2TqBvHC/loEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wvuqEEEFhAIpM9DBF66wPf7HEtK0T4X9wVibFeqtS7E=;
 b=nkNNlT5XJFh9POs1yY/LOgpFjbgm+M8ljC6b9Jci2HbXV+Qnp7nU85htvGJ06DgUrJSNm8CuumjJ9SeHQmJVGDSTXXuUWtW03NUT6XlXY+z/pZQCeMbCrQQ6Wtmh1vIzJ5HJ7UX3UZpwsaug3OBoW2TvAlWWwhAJTow8bHshu3dDk/HZFEfyrhVTMqzVBxy73KShGjgE4ZBOwgxcEi392WOGQfGzEa00GOiUxmS7f0mMCHO4PI7agoeIYXdNgG7OBGOVHy2+n7MkxXzMY7k1FUFHr0u6bgqg9V0XZygIluiweFr3bwB4TFTW6WBu1HOeXS5Q5mDR4Ouv4OtgK5JKWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.112.34) smtp.rcpttodomain=gmail.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wvuqEEEFhAIpM9DBF66wPf7HEtK0T4X9wVibFeqtS7E=;
 b=odDUhjJksovGPxuYE9jeqFBYFRBzH8w50l3oCLVU9+RUl4Nk2Kiv6vw243+nHDc2ClwD51YkOtfedUZF446svOYXpLh9H5lgmJ4qcTGoQO29P1e1fRt+ZZzypIX7qKPYKd+/1iWbqXEf4FJ553eBsDnbnY922EyuzILF9N6Vutb5DDb2VXxxUcKpufFUKiA4IP3MPctCrHPyyFh24JVY/x/DGUUbs7F+zjEYBc/tLqsp7VehbI+SbzuTpKz+4MpmH3N91KUhYCH9jbJT0eXzn6sURGZlvef8ITb/WEqnhL1bVPgHobPr9Os6VEKlw3YFfqvUWkQwDaVl0GMLSKgevw==
Received: from BN9PR03CA0049.namprd03.prod.outlook.com (2603:10b6:408:fb::24)
 by DM6PR12MB3787.namprd12.prod.outlook.com (2603:10b6:5:1c1::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4544.13; Mon, 4 Oct
 2021 15:49:36 +0000
Received: from BN8NAM11FT017.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:fb:cafe::18) by BN9PR03CA0049.outlook.office365.com
 (2603:10b6:408:fb::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4566.22 via Frontend
 Transport; Mon, 4 Oct 2021 15:49:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.112.34)
 smtp.mailfrom=nvidia.com; gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.112.34 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.112.34; helo=mail.nvidia.com;
Received: from mail.nvidia.com (216.228.112.34) by
 BN8NAM11FT017.mail.protection.outlook.com (10.13.177.93) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4566.14 via Frontend Transport; Mon, 4 Oct 2021 15:49:35 +0000
Received: from [10.25.98.154] (172.20.187.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1497.18; Mon, 4 Oct
 2021 15:49:33 +0000
Subject: Re: [RESEND PATCH 0/3] Few Tegra210 ADMA fixes
To:     <vkoul@kernel.org>, <jonathanh@nvidia.com>, <ldewangan@nvidia.com>,
        <thierry.reding@gmail.com>
CC:     <dmaengine@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <1631722025-19873-1-git-send-email-spujar@nvidia.com>
From:   Sameer Pujar <spujar@nvidia.com>
Message-ID: <564a850a-41e4-31fc-9ebe-51ac6b859f62@nvidia.com>
Date:   Mon, 4 Oct 2021 21:19:30 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <1631722025-19873-1-git-send-email-spujar@nvidia.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-GB
X-Originating-IP: [172.20.187.5]
X-ClientProxiedBy: HQMAIL111.nvidia.com (172.20.187.18) To
 HQMAIL107.nvidia.com (172.20.187.13)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5eb9d467-6f76-4ef8-6bfc-08d9874e9119
X-MS-TrafficTypeDiagnostic: DM6PR12MB3787:
X-Microsoft-Antispam-PRVS: <DM6PR12MB37875D9A008CCCD335A0D199A7AE9@DM6PR12MB3787.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: v4C7yuG7/0vqsR2+QPmqY7jT9JvHcGlgEMsS3//fzi6LvA1iL1kc2gf6HHVHp6hV8qYkxHnn39ykHroTpubwXzKk4CPwmJiUT4fK/BFJ6MaToFSyqsi7IAysDSHzLR1VUY39dJgbo8gR7J3xhIYvgkbGEuRdtXxDNwPoALjQlG4QCn+86ldEHkfbh1I4DX7ZjsF8Q2cWj+GaF5cTGu/BKY/DgpmxNVDJEhvyky+oH+OZKrZhEe81uH+lCplWT8MSxI+AV36dTiv2oOz9JFaghSHMOAOal8RHjRg7y3VF0mHqh9h/pLRICqckoedFg0TUizCGThUwFsM4rQ2md2Lb2PoO86gZnLUCVy4Br4snuXTqtEPxxWptnuTOvY9rOOpxauri86SCUjlbVoZuCKTZBV5JJiQBWYGSZvapEqtYlbzOL0+RSqDucpZu/BNhpktCxJeKfC2rpiKVaOV5f/eR1zBvhOTlK/DDjgkqAHpyHy51l48+Etpf35Oi8J7oaGzvPz0H0BsMD6z9MAWQ1Yc/zmxy7WmcsoRp4T9bWGoTdLgtF9yuyZYP51PgT+DHVLmhzpheotdJzj2+H0T0xq6DDG8rAgeiLX1wStSaFAZ4ozr/CsUhUV0RHgYs0D2pzQPRGkv0f9aBrAZoQcve9Y+bvawQri97UGpO/5oXdBAJWR5OT9CaTsWKq2b9Oe3HWtCHt1MuGBRpi8geFb9EpFCdCQTMf5pzgZldIJfDGy3GReQ=
X-Forefront-Antispam-Report: CIP:216.228.112.34;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:schybrid03.nvidia.com;CAT:NONE;SFS:(4636009)(46966006)(36840700001)(8936002)(4326008)(47076005)(336012)(36860700001)(83380400001)(31696002)(4744005)(5660300002)(16576012)(356005)(2616005)(70586007)(31686004)(426003)(82310400003)(86362001)(70206006)(36756003)(16526019)(508600001)(110136005)(36906005)(316002)(2906002)(7636003)(26005)(186003)(8676002)(54906003)(53546011)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Oct 2021 15:49:35.8861
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5eb9d467-6f76-4ef8-6bfc-08d9874e9119
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.112.34];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT017.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3787
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Hi Vinod,

On 9/15/2021 9:37 PM, Sameer Pujar wrote:
> Following are the fixes in the series:
>   - Couple of minor fixes (non functional fixes)
>
>   - ADMA FIFO size fix: The slave ADMAIF channels have different default
>     FIFO sizes (ADMAIF FIFO is actually a ring buffer and it is divided
>     amongst all available channels). As per HW recommendation the sizes
>     should match with the corresponding ADMA channels to which ADMAIF
>     channel is mapped to at runtime. Thus program ADMA channel FIFO sizes
>     accordingly. Otherwise FIFO corruption is observed.
>
> Sameer Pujar (3):
>    dmaengine: tegra210-adma: Re-order 'has_outstanding_reqs' member
>    dmaengine: tegra210-adma: Add description for 'adma_get_burst_config'
>    dmaengine: tegra210-adma: Override ADMA FIFO size
>
>   drivers/dma/tegra210-adma.c | 55 +++++++++++++++++++++++++++++++--------------
>   1 file changed, 38 insertions(+), 17 deletions(-)
>

Are these patches good to be picked up? or I need to resend these?


Thanks,
Sameer.
