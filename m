Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4C99E40C9BB
	for <lists+dmaengine@lfdr.de>; Wed, 15 Sep 2021 18:07:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235322AbhIOQIg (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 15 Sep 2021 12:08:36 -0400
Received: from mail-co1nam11on2086.outbound.protection.outlook.com ([40.107.220.86]:33491
        "EHLO NAM11-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232738AbhIOQIf (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Wed, 15 Sep 2021 12:08:35 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EBxj5oJ/Zckc57DmwC+1pkpuDNbwmQvwBI/8mGLQvcjTYllLXc2e6eP26TbqzaiWnXVTF8aebMrpv9z6tvaK5eDkysDNXIAGzM2zJUuY/RpIevPGVXOBufzTvGAwTaOvngU24w7XZ1ycY+61lxEv98FTIb7/O7k/Nbi+KROBkiY0uat976kFzV9hKVP1tvm22nOXvl+E3nf4LfO2dhZ0AXR8KmB45fNAnmJ/MpWh1W8Vvcym1S648wxBHrKWyGj1gqRCE7IL/gX6qTmkeiFQEetWmyKNmmj9ZytGunBxI8LCfHKVk+fipOJMc+DIeusIBSjlyJhFq1FDzvWIfqQeKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=gSB1z2ElJ4XPqoNmncT8azt6bqnFqwzuZWI4eJ23Eek=;
 b=fiFOxUZ+mkxgIPvJ8lAaDWtZQhr71d7wDe/wR9FPn/NaDT/0CDKaEMIHqhFqsBRinSHa96LP0jPnokKzINdsoH+TspWMsweDaTP39qL7N4PN++wM4f3O74AomqgRKEoHKz8wiRwmkp+f5qshQdo0C443x05YBRxMQKEzgJW/JI8uj4+IJ0vqVhNCPXmvudeRU+Pr076tlFqC1AKQbu2g7EFFFgs8AwqZ+8AgZ5gjvdfBqXDoEj9ax6iJGRLGewv6F4ig4OMhHQGK8mDckLFRaAC87hrWhzUjIQ4PXMSsOdRm+o7nxKnCsAkeBDHm5Q2o8g8Udt9TFachexpWbMpedw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.112.36) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gSB1z2ElJ4XPqoNmncT8azt6bqnFqwzuZWI4eJ23Eek=;
 b=Hfnry126WImQHi1Ng4d/U5zQdEDt7fWlpaerVeJN+YuopehmPE6KH59i6Sk0mTmL08ynu46yTsunOI0Ahvvr3zp3IpDjGDx6zKHMYiS17B1wltlubwPi00mXLexiI8geO1U5cMd/WmxZNxh7K5H7uZ3HHtGKOVlrfLu9AYqiritnbjRK4DTTjrbImCElpkBb/6Zlm6kdz0Af4S+Fqx+RO4c6qiBpkKjaAY5UGuZF1uEyVnMA/f0V6QKWXoX4lVivX9xMNYT/UihdAuWAXuPIKue0PDDJOIblavO1uP1Kam5NEtVLUTko+o4UA//rwWpku5xP9xdMvoe7epJwJtP8nA==
Received: from MWHPR03CA0006.namprd03.prod.outlook.com (2603:10b6:300:117::16)
 by SN6PR12MB2703.namprd12.prod.outlook.com (2603:10b6:805:75::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4523.14; Wed, 15 Sep
 2021 16:07:15 +0000
Received: from CO1NAM11FT045.eop-nam11.prod.protection.outlook.com
 (2603:10b6:300:117:cafe::1e) by MWHPR03CA0006.outlook.office365.com
 (2603:10b6:300:117::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4523.14 via Frontend
 Transport; Wed, 15 Sep 2021 16:07:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.112.36)
 smtp.mailfrom=nvidia.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.112.36 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.112.36; helo=mail.nvidia.com;
Received: from mail.nvidia.com (216.228.112.36) by
 CO1NAM11FT045.mail.protection.outlook.com (10.13.175.181) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4523.14 via Frontend Transport; Wed, 15 Sep 2021 16:07:14 +0000
Received: from HQMAIL109.nvidia.com (172.20.187.15) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1497.18; Wed, 15 Sep
 2021 16:07:13 +0000
Received: from audio.nvidia.com (172.20.187.6) by mail.nvidia.com
 (172.20.187.15) with Microsoft SMTP Server id 15.0.1497.18 via Frontend
 Transport; Wed, 15 Sep 2021 09:07:11 -0700
From:   Sameer Pujar <spujar@nvidia.com>
To:     <vkoul@kernel.org>, <jonathanh@nvidia.com>, <ldewangan@nvidia.com>,
        <thierry.reding@gmail.com>
CC:     <dmaengine@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Sameer Pujar <spujar@nvidia.com>
Subject: [RESEND PATCH 0/3] Few Tegra210 ADMA fixes
Date:   Wed, 15 Sep 2021 21:37:02 +0530
Message-ID: <1631722025-19873-1-git-send-email-spujar@nvidia.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0478fd30-b3c2-4bf6-8e13-08d97862e242
X-MS-TrafficTypeDiagnostic: SN6PR12MB2703:
X-Microsoft-Antispam-PRVS: <SN6PR12MB27033D0311116A5344A46529A7DB9@SN6PR12MB2703.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Opdn7KCaVzhHtYXanq0fAsZtSp3cCfyddVx2B2cfDidH8d6AZpW9QRIhJ20hi67l8mC0Bb6yU25pphJ9/oxBWwTxk1TrbOBcT73CugN1W7VGA9jBBr+nB1QYc2rvJBQiuVbXHhZhWt/zgFXnEfHFqjbYoF658/7vgZRqTRMEwEWESxArmA7PruXNkxMuUcCCXpf+SLSLvMVIA3Luie9Xp9JgvCYZs1ntRQ324H3ttSJPIpkSd4T4Lms+5pQSYojwzUBbzSp1OuDhwH91RCPRfFMV1ErYTS8VaVlVqICM6ArZ35QZcrnFOcgBhJeBwq+W7qWFTL0iBzO18f2XWCvQZH1Ygp2s9rBAgWs4aTz7zyrtJaIwZuFiiwATwiZ6uwf32O5teh87cs6868Zf3xmB5IWHZrWAi48ub5Uv6xpbK9Haff2Cub6KmTAk8KFUhshEBd1yUc2UoB9i338SDIH6n0hSptGyytePUynFSI8Umz2KNw868Ahb69Jnmz8fkQPLxQZnD2vNvqjddk9dcsfpGuSxelw3FMImWFsv5cUyljLdaYT8ulLrF64ZlW/kboO08E6/3KcLndRRZhfFJL0T88Z7UkGXie+NrwgtR7HN1ldSPWDY7T2KTv0wEEMbYzANQOiJBc14XGw8IWg/21lJkqgneyIuhjqSNRht4bBH7t2mkvBt1ldVvwPlcroPx3IRPbpSmbldOnfzuv1pi1m1XQ==
X-Forefront-Antispam-Report: CIP:216.228.112.36;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:schybrid05.nvidia.com;CAT:NONE;SFS:(4636009)(136003)(376002)(396003)(346002)(39860400002)(46966006)(36840700001)(86362001)(7696005)(186003)(82310400003)(54906003)(107886003)(2906002)(478600001)(26005)(110136005)(336012)(83380400001)(36906005)(2616005)(47076005)(426003)(4326008)(6666004)(36860700001)(36756003)(7636003)(70206006)(5660300002)(356005)(70586007)(8676002)(8936002)(4744005)(82740400003)(316002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Sep 2021 16:07:14.6647
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0478fd30-b3c2-4bf6-8e13-08d97862e242
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.112.36];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT045.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR12MB2703
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Following are the fixes in the series:
 - Couple of minor fixes (non functional fixes)

 - ADMA FIFO size fix: The slave ADMAIF channels have different default
   FIFO sizes (ADMAIF FIFO is actually a ring buffer and it is divided
   amongst all available channels). As per HW recommendation the sizes
   should match with the corresponding ADMA channels to which ADMAIF
   channel is mapped to at runtime. Thus program ADMA channel FIFO sizes
   accordingly. Otherwise FIFO corruption is observed.

Sameer Pujar (3):
  dmaengine: tegra210-adma: Re-order 'has_outstanding_reqs' member
  dmaengine: tegra210-adma: Add description for 'adma_get_burst_config'
  dmaengine: tegra210-adma: Override ADMA FIFO size

 drivers/dma/tegra210-adma.c | 55 +++++++++++++++++++++++++++++++--------------
 1 file changed, 38 insertions(+), 17 deletions(-)

-- 
2.7.4

