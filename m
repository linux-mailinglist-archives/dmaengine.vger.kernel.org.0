Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8E07C489D1E
	for <lists+dmaengine@lfdr.de>; Mon, 10 Jan 2022 17:06:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237001AbiAJQGW (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 10 Jan 2022 11:06:22 -0500
Received: from mail-co1nam11on2084.outbound.protection.outlook.com ([40.107.220.84]:36832
        "EHLO NAM11-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S236937AbiAJQGO (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Mon, 10 Jan 2022 11:06:14 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nWTjtOUjR5QxKM5roQjEH1jyjSRLDiayrV9dzcdJcyDewFAcVg/yhOZNMze22XsB+l5uotytSZF+8q2ATSI0dBeGKIRU2BZpEqeTHn69fpSL4i6KOZ4qSr2IW3OJlm3JxIdAeUzsuLjje50dKaCHvVt9dYmWio7UxJBFrfEYcCGAHp1By0N1UaENXlJgYZxs7W2BXGecIghQT3c/3a81bhzOZtTVrAdsuZUF6T/9V205bKO25nc5/Vgl/7YlKu/VagZW0FcMcjmr89hg1OXCsi4xKa7IOV1E3lkWoDEO4/GTzoquBSCNWUipVP6n+tyZzCMIcq1usJK218AIUvH3+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BKFa6OiohdYASq+oTTIEjbVRDI9TAxJQnDuk0f/hbZo=;
 b=cKHMNuny+N6UkTYr0DevhQRTW6Tz1BtfsulCrvrakbKT8gGycEPo1buR8lJPpFb9neofvuMRoul9zbzoHUw9itOmNufxifAaVfDC4j9rV941oVuMWK58ls/KhVSB9ji/VmXXFVHxTeGClyPeyFKKaK2Yh7dB8T3USgzH3Ik6aC81LP9SjEzWVK+xsDj6VmDRMNItUgcwAg5HoiUdekDUfWrv5nCL6nd1MTstAPmXMzjP8517i8LgUkQHmmv1Q2N+qyK18wcfiDI9Ua0Ia7FVBpa/e/Ch6qttPR10QA2jrC6uxF8qefw5vUA+x6EqboXmA/LvpJxQhFwrTL4wnuZV0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 12.22.5.235) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BKFa6OiohdYASq+oTTIEjbVRDI9TAxJQnDuk0f/hbZo=;
 b=n/obqj765atO9HpshxMd57JSKHEEmTNpD5dRbRoAQfqmFPnresVnYkgKkqYLCnTL1uP0bDRwGPRkLoBUihkiT2Vp5Qbakhp0+4Dt+RYac+Dj4q5FP/2QgtQZmbuFnnvH54ZsxCOEvr6AkRU3bZMEgBXUNPS1qZTe8BqHOUQj3n0pl3C51WDFjZ3oy2xOhtzSDTsh4lh81q/kkFHPWjGiQ/z5fmkzjmuWTB47jZuOKPkBRdZN1pm9+G35WMIKkGAndyYL1JLuJARgAHUR/CCJcIDTVhazONbjUtAVwSA6e6GLrptOIw/CL2OOc//JBXlWx505falsEA2WnP4NdU0Q8w==
Received: from DM5PR21CA0066.namprd21.prod.outlook.com (2603:10b6:3:129::28)
 by MWHPR12MB1648.namprd12.prod.outlook.com (2603:10b6:301:11::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4867.9; Mon, 10 Jan
 2022 16:06:11 +0000
Received: from DM6NAM11FT068.eop-nam11.prod.protection.outlook.com
 (2603:10b6:3:129:cafe::d7) by DM5PR21CA0066.outlook.office365.com
 (2603:10b6:3:129::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4909.1 via Frontend
 Transport; Mon, 10 Jan 2022 16:06:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 12.22.5.235)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 12.22.5.235 as permitted sender) receiver=protection.outlook.com;
 client-ip=12.22.5.235; helo=mail.nvidia.com;
Received: from mail.nvidia.com (12.22.5.235) by
 DM6NAM11FT068.mail.protection.outlook.com (10.13.173.67) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4867.9 via Frontend Transport; Mon, 10 Jan 2022 16:06:11 +0000
Received: from HQMAIL107.nvidia.com (172.20.187.13) by DRHQMAIL107.nvidia.com
 (10.27.9.16) with Microsoft SMTP Server (TLS) id 15.0.1497.18; Mon, 10 Jan
 2022 16:06:11 +0000
Received: from HQMAIL111.nvidia.com (172.20.187.18) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1497.18; Mon, 10 Jan
 2022 16:06:10 +0000
Received: from kyarlagadda-linux.nvidia.com (10.127.8.10) by mail.nvidia.com
 (172.20.187.18) with Microsoft SMTP Server id 15.0.1497.18 via Frontend
 Transport; Mon, 10 Jan 2022 16:06:07 +0000
From:   Akhil R <akhilrajeev@nvidia.com>
To:     <dan.j.williams@intel.com>, <devicetree@vger.kernel.org>,
        <dmaengine@vger.kernel.org>, <jonathanh@nvidia.com>,
        <kyarlagadda@nvidia.com>, <ldewangan@nvidia.com>,
        <linux-kernel@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
        <p.zabel@pengutronix.de>, <rgumasta@nvidia.com>,
        <robh+dt@kernel.org>, <thierry.reding@gmail.com>,
        <vkoul@kernel.org>
CC:     <akhilrajeev@nvidia.com>
Subject: [PATCH v16 3/4] arm64: defconfig: tegra: Enable GPCDMA
Date:   Mon, 10 Jan 2022 21:35:17 +0530
Message-ID: <1641830718-23650-4-git-send-email-akhilrajeev@nvidia.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1641830718-23650-1-git-send-email-akhilrajeev@nvidia.com>
References: <1641830718-23650-1-git-send-email-akhilrajeev@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5a3ddd2e-52fd-46ea-e163-08d9d4531f0b
X-MS-TrafficTypeDiagnostic: MWHPR12MB1648:EE_
X-Microsoft-Antispam-PRVS: <MWHPR12MB1648D209E6F12F06E1839459C0509@MWHPR12MB1648.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1079;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5GbkfeZwVMp+v7uz033SkoHIrVy9bwHdnQkAJsu32DFZ2Ggl55K2QO2u2Wa1bY7YdxOvTIsjQoGrSaeeSC2LQSVwDLTsy2WllTt9b9O7uBHOyqp7YAOt5adQNX9hb5oHmDy4oVDqqPG0/UnOu6E4MQEiv7fhNZe78xvN7gUKNX5Q4VI8B16YxJkYLyB2j6hVxNqrdJu+VKz9GUHchyh+MQ9WBnkWSYFQYZoDd1DGCQWCeyly0I0COGdQEz75lEsnG2gkk2W7wIfPDfdtSf0jVSHOCqaDzz2HBhcZhR6/PF440u6bSNST3NpK3FBv39BgAQgguHl+p/iJ9LMLeqe6hjopMMIYgB8PbH0nVGMThV/3icsgFGtV7LylUwcwrlI20YisxWNzkcTS6NvQj51Dfz5Vn7+Tj8pqvSRkJ71rZ5vdxAJzKWoTwBgaGMjCwP7/KDVDM/5WIREEcrhWoe87XtC2r8ttPPSqjYOqblv46WmWRZeVvCb71HPIgVhbulYv4544hjdLSJuE1/PFqcH89erpBBg/+d2RhltU1nNhr/MIniEDhm1BjXRMXZ3KhOONL7thtGPsFqjTbOKssrOu96OYKqz4yvmyiepepsbeXNCuhiiywxMzjikdkToOlxIxxoitOr4xDiqDUUj9YpWUrBYPBfrvHOhGNuhpThyENUT+xDnKEssh+EJFzFSrWCuUa7iIfhiOD3nvqYOdGQIa8MxkK/+Oc+2EATAg00PMFKgLZS8r1xXV9bPXaR9asJQ8QJlKxj2qtMb1Xya7Qx/aS3GzxE4WyCa6QG3BBTiK89taD4mW7MzcbXOTgCSiRa/VlzpeV/x/EeZZySg1pgO4faEj3cPoSX5Qcwt4NRVPuWs=
X-Forefront-Antispam-Report: CIP:12.22.5.235;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:mail.nvidia.com;PTR:InfoNoRecords;CAT:NONE;SFS:(4636009)(40470700002)(46966006)(36840700001)(110136005)(107886003)(4326008)(6666004)(47076005)(508600001)(86362001)(2906002)(36756003)(82310400004)(40460700001)(5660300002)(921005)(8676002)(356005)(426003)(336012)(8936002)(316002)(2616005)(36860700001)(70206006)(70586007)(26005)(7696005)(186003)(4744005)(81166007)(2101003)(83996005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jan 2022 16:06:11.6476
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5a3ddd2e-52fd-46ea-e163-08d9d4531f0b
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[12.22.5.235];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT068.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR12MB1648
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Enable TEGRA_GPC_DMA in defconfig for Tegra186 and Tegra196 gpc
dma controller driver

Signed-off-by: Rajesh Gumasta <rgumasta@nvidia.com>
Signed-off-by: Akhil R <akhilrajeev@nvidia.com>
Reviewed-by: Jon Hunter <jonathanh@nvidia.com>
---
 arch/arm64/configs/defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index ee4bd77..96a796d 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -956,6 +956,7 @@ CONFIG_MV_XOR=y
 CONFIG_MV_XOR_V2=y
 CONFIG_OWL_DMA=y
 CONFIG_PL330_DMA=y
+CONFIG_TEGRA186_GPC_DMA=m
 CONFIG_TEGRA20_APB_DMA=y
 CONFIG_TEGRA210_ADMA=m
 CONFIG_QCOM_BAM_DMA=y
-- 
2.7.4

