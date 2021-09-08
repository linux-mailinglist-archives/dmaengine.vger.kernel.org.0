Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B7F9A403DC2
	for <lists+dmaengine@lfdr.de>; Wed,  8 Sep 2021 18:44:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349992AbhIHQqA (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 8 Sep 2021 12:46:00 -0400
Received: from mail-dm6nam12on2048.outbound.protection.outlook.com ([40.107.243.48]:8928
        "EHLO NAM12-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1349994AbhIHQp7 (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Wed, 8 Sep 2021 12:45:59 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hhmz/I0RtmGaJCjkQxS+xzb1g5Uy7jMktiOfrkuYjNospkZnyvn8Fm4h5Sl1RK0LsTpnZMGx1tp16CCXcBLtTYdlGGyxN0zr4/hQvOXJKgvkkCC5nOJvC7aQ1SN5Fsv7vdIBiIKU7dMqIJBkWey8Rrtexc+8Bu6RZ4az2iowtl+sgCSSuSSFmXFKAd9HTxcARBpOAJExUxSq4VfumVzkj7mxWXNwe7bS76eszZ1/oR3t+ErQx4Qb6X2TzTRb71RAoG9+BrvDxu1pxUDsPypSFdbzlWeRKpxlLXid3uP2uw3/qXelSeU3VVYsbadKUuZh1fiQvLTW/85kOsa+O4JQhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=tuhVJOMPu+sK3oZX8JZEROArkNk5MOcJDM4UZiD7ji0=;
 b=gI8InLX9gqjexl6ObqsNvu8wsW8lcqE7FoeMS/xA0Cr22As6YZkEl9c+DuIOsqSiQtV0noogQ7wgMo4w20wgLeitRLSY1NrWRr0KKD25N/y7J/BOJc4xOjOxg7ccS4uQ8lQGc2zx5a29fc1CKtj7G1fwxn0If4Dp/3LERyncTWdPk1qZWpTS2b5RLn70WBfxUtllQwPdOw5WGSaYs2qsupui/hsMLWvaaj9CdaJgcNxgPUB0TTHILS7cDElwt/RHEs7FZmyUUuVfp4rtkM4vy5dihMEH5cRHn0hWEcxQEDFZnRsF7vrSBjiLdL8zCvrQcL3o/9zxyFfVUB2BM6rg1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.112.35) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tuhVJOMPu+sK3oZX8JZEROArkNk5MOcJDM4UZiD7ji0=;
 b=A7XlL2ntnRywDhmHPK6qGS3rwSk26jlrCro4LL9wA63T1faWBeffzCmOLpFmq0HXp5mt76SRibuInSl3EXl2mhBWlmL+ObaPZaY31SAi8VRLPvuZnp4EYa8u8A2eknwOcnPSRgOaL/vyjzhdGqE2hf+rX4y5HlG/lrX6QNtG5nc5UAon/H+uLU31GUbYC9BxZBUMBoVNQz7oGzyg8XyW0RytsuE0cxumpfPHTs81YWtPLHmko81s6f6K40kpMN5gbDArLf7PgXiwcd4m7CO/w2OZwQ08fxZhcBKs6J29AshAb2agkQCl2bDcVSSD3jSJvO1rKrg1LyflnP1ugGVa4A==
Received: from BN6PR19CA0119.namprd19.prod.outlook.com (2603:10b6:404:a0::33)
 by DM6PR12MB4401.namprd12.prod.outlook.com (2603:10b6:5:2a9::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4478.21; Wed, 8 Sep
 2021 16:44:49 +0000
Received: from BN8NAM11FT026.eop-nam11.prod.protection.outlook.com
 (2603:10b6:404:a0:cafe::de) by BN6PR19CA0119.outlook.office365.com
 (2603:10b6:404:a0::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4500.14 via Frontend
 Transport; Wed, 8 Sep 2021 16:44:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.112.35)
 smtp.mailfrom=nvidia.com; kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.112.35 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.112.35; helo=mail.nvidia.com;
Received: from mail.nvidia.com (216.228.112.35) by
 BN8NAM11FT026.mail.protection.outlook.com (10.13.177.51) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4500.14 via Frontend Transport; Wed, 8 Sep 2021 16:44:48 +0000
Received: from DRHQMAIL107.nvidia.com (10.27.9.16) by HQMAIL111.nvidia.com
 (172.20.187.18) with Microsoft SMTP Server (TLS) id 15.0.1497.18; Wed, 8 Sep
 2021 16:44:48 +0000
Received: from [10.26.49.12] (172.20.187.5) by DRHQMAIL107.nvidia.com
 (10.27.9.16) with Microsoft SMTP Server (TLS) id 15.0.1497.18; Wed, 8 Sep
 2021 16:44:45 +0000
Subject: Re: [PATCH v4 0/4] Add Nvidia Tegra GPC-DMA driver
To:     Akhil R <akhilrajeev@nvidia.com>
CC:     <dan.j.williams@intel.com>, <dmaengine@vger.kernel.org>,
        <kyarlagadda@nvidia.com>, <ldewangan@nvidia.com>,
        <linux-kernel@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
        <p.zabel@pengutronix.de>, <rgumasta@nvidia.com>,
        <thierry.reding@gmail.com>, <vkoul@kernel.org>
References: <1630044294-21169-1-git-send-email-akhilrajeev@nvidia.com>
 <1631111538-31467-1-git-send-email-akhilrajeev@nvidia.com>
From:   Jon Hunter <jonathanh@nvidia.com>
Message-ID: <8525e868-30c2-017d-0feb-fc0e8f344da9@nvidia.com>
Date:   Wed, 8 Sep 2021 17:44:43 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <1631111538-31467-1-git-send-email-akhilrajeev@nvidia.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [172.20.187.5]
X-ClientProxiedBy: HQMAIL111.nvidia.com (172.20.187.18) To
 DRHQMAIL107.nvidia.com (10.27.9.16)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: bd90936f-1c75-4e71-45a3-08d972e7f8f2
X-MS-TrafficTypeDiagnostic: DM6PR12MB4401:
X-Microsoft-Antispam-PRVS: <DM6PR12MB4401F08AD153DAD1BD8F717DD9D49@DM6PR12MB4401.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5eUtxQF5abpKH0iN1ECpA9xLHd5yJYRDCeA7+EhM2WiqHFXXySR00mEi6FHa3MvjJ7s5h6Gx2REf3DIodhp3KiLDRNZIxtgb1JUncuug6bfDDOISlrzhDfD1rGaJLTj02zwpQBTgiQaLvVc6xQAYStfw9CT1muJnadUTs8buIJAQd2wxsuvB3kfQ9m4qQCGZJvbYgU5gj7aQOIYKUasO4voM0TLI/ApI2rgpGhb48gNk6ocrVS9aZR57K72TQFRKNQfFD6HjFXdyxgN46uzZe6W7ZZe2bSBdJJYYenrj0kSgLUTxEsamAJr35Ea7USU3pSm3twzwa5SzCF5S18Dl0mJCWz0VH/5lbdnERPaj0Ut1p8/RnH/NqWQlHyreXckXnCa7RjKR5NI+sWCwD+Mv+ksSuP0Fk91Rz/hSCQ3uOOG2Axck/iH7SU8xKyPUYH/lIS1rtcHIdb8myrf+Qiyf+vg3XgKmT3hK6E/CWRDxdlzuLwVzOlcAHQLdQ97cwsItvm++K8t145ZxA9PUT8t1RntVKyWGuaOrwhAxubA0I792d/udgnZHMrVIZmHp/AMPDovOpV4RScj1j98ZmwLbf0lcpE9PJRwqrlHyGsKiEzs073hxXyi+giLQz/hsZppLW9lVHJU8//gph7DNaLm0kGy7EcflNDSBCZd126Grz1nrKalXlrYXvDqBQoGpKgKn587kcDPKZO1EohECyM2TNBnKJy/tlNoUy+9cSo8ALq8=
X-Forefront-Antispam-Report: CIP:216.228.112.35;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:schybrid02.nvidia.com;CAT:NONE;SFS:(4636009)(46966006)(36840700001)(4744005)(8936002)(36756003)(336012)(26005)(31686004)(47076005)(4326008)(31696002)(82310400003)(86362001)(36906005)(6862004)(5660300002)(316002)(16576012)(37006003)(508600001)(6636002)(36860700001)(70586007)(7636003)(53546011)(16526019)(356005)(2616005)(2906002)(426003)(54906003)(70206006)(186003)(8676002)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2021 16:44:48.7585
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bd90936f-1c75-4e71-45a3-08d972e7f8f2
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.112.35];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT026.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4401
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org


On 08/09/2021 15:32, Akhil R wrote:
> Add support for Nvida Tegra general purpose DMA driver for
> Tegra186 and Tegra194 platform.
> 
> Changes in patch v4:
> 	Addressed review comments in patch v3

Would be good to be specific, because not all the comments from V3 have 
been addressed :-)

Jon

-- 
nvpublic
