Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5BA394A30BB
	for <lists+dmaengine@lfdr.de>; Sat, 29 Jan 2022 17:42:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352790AbiA2Qml (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Sat, 29 Jan 2022 11:42:41 -0500
Received: from mail-mw2nam12on2088.outbound.protection.outlook.com ([40.107.244.88]:3648
        "EHLO NAM12-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1352794AbiA2Qm0 (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Sat, 29 Jan 2022 11:42:26 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NXS4gLbwClC2sdts6/lQ4OVAfU2k6XbgJqVqIFhpSbmbT3XC6WdcQoPjlegHcGwdwvvqw/LgA/UGXFJ2xlxeohNJyglcGCk8Nl2soHAQ3h4JpRAar4dR7VLXspw/Y/N+Fp2iLciXCNJOZFXUY65qNXl60SGEa2lFZ3dVIqSvpdlh7tOyKcsOG7Kf/XWSdYfptlkj1BJDIPvFedzpAbVPlRhYHMJirkh6NiG0VaFQfeeePKv9D189QiVZBzhnsbKP/EH0s7WR2rQ012YikVXMynXokKf2GF22XIsNWj6uFrYyfy/dLgNWFu0tJuGKALFOMqgKmB+VplaJA55YzO7RAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BKFa6OiohdYASq+oTTIEjbVRDI9TAxJQnDuk0f/hbZo=;
 b=IdXCSTk1bpahdk0P7eR3AZPNSZRKKGG7g1jCPD42V5Zli7FiFZlCJrBr41stgNNiQ6e6P94jx5+loWoNyG7n+QNhXTjJPszjXRoSWqr1ramrdn76kJR6/RxrJqNPB/vj0UFWu9onZwQlvKgTPvBIBvxiMbCM6aTCUjQsaOM6xYOsVeLW4J4ZklI44sSrQgcZ0ik1RKL28i6nXX2ysC7doNs929m74QjqFXslPO2/dgFeCeBBhUngBV/3XtdRaH1rVZ5/LtWeFaFt4vWighkLwqPTuS8kthVSSU/qXfF/xo5k7dIFBOXoX/QchldJ/msS+n2YgdRfsW6KEn4baQeBOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 12.22.5.235) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BKFa6OiohdYASq+oTTIEjbVRDI9TAxJQnDuk0f/hbZo=;
 b=fO8rrqeA1eYvpVg6SB8iIvpvuXIo9Oc0Slp1e9B1sK8kMkxOEdn6gH0sCrXgOLxcNzqG6gpLbZc7UGegv26LjvM+RFZU7oHmQ058oIALqjM0yWp2FdnG/fX+0Nb3aHj5yyVvfHVMLjNj93PSWv3ogwiLd2h5Yq3H4HcyCK6rWN/qO8NQqNQYhI3+iiF8RIKfqcS6tlGlfxoAaIhQI1z9CiemiwKd0szwL4mLdrY6zndtkBvRWot05gMtZIrHmSCIzSKY7HrfdbRFbJqZDsFXfZvi/zbGmPUExGAcauxU2oNy/A7G2KCmaPBH2anHpkZovYzIflUkaQsdJ865uK0SJg==
Received: from BN9PR03CA0415.namprd03.prod.outlook.com (2603:10b6:408:111::30)
 by BYAPR12MB2806.namprd12.prod.outlook.com (2603:10b6:a03:70::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4930.17; Sat, 29 Jan
 2022 16:42:22 +0000
Received: from BN8NAM11FT065.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:111:cafe::12) by BN9PR03CA0415.outlook.office365.com
 (2603:10b6:408:111::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4930.15 via Frontend
 Transport; Sat, 29 Jan 2022 16:42:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 12.22.5.235)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 12.22.5.235 as permitted sender) receiver=protection.outlook.com;
 client-ip=12.22.5.235; helo=mail.nvidia.com;
Received: from mail.nvidia.com (12.22.5.235) by
 BN8NAM11FT065.mail.protection.outlook.com (10.13.177.63) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4930.15 via Frontend Transport; Sat, 29 Jan 2022 16:42:21 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 DRHQMAIL107.nvidia.com (10.27.9.16) with Microsoft SMTP Server (TLS) id
 15.0.1497.18; Sat, 29 Jan 2022 16:42:20 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.9;
 Sat, 29 Jan 2022 08:42:19 -0800
Received: from kyarlagadda-linux.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server id 15.2.986.9 via Frontend
 Transport; Sat, 29 Jan 2022 08:42:16 -0800
From:   Akhil R <akhilrajeev@nvidia.com>
To:     <devicetree@vger.kernel.org>, <dmaengine@vger.kernel.org>,
        <jonathanh@nvidia.com>, <kyarlagadda@nvidia.com>,
        <ldewangan@nvidia.com>, <linux-kernel@vger.kernel.org>,
        <linux-tegra@vger.kernel.org>, <p.zabel@pengutronix.de>,
        <rgumasta@nvidia.com>, <robh+dt@kernel.org>,
        <thierry.reding@gmail.com>, <vkoul@kernel.org>
CC:     <akhilrajeev@nvidia.com>
Subject: [PATCH v17 3/4] arm64: defconfig: tegra: Enable GPCDMA
Date:   Sat, 29 Jan 2022 22:10:52 +0530
Message-ID: <1643474453-32619-4-git-send-email-akhilrajeev@nvidia.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1643474453-32619-1-git-send-email-akhilrajeev@nvidia.com>
References: <1643474453-32619-1-git-send-email-akhilrajeev@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5d755114-24c2-4683-646f-08d9e346523a
X-MS-TrafficTypeDiagnostic: BYAPR12MB2806:EE_
X-Microsoft-Antispam-PRVS: <BYAPR12MB28067051EAFD54A8100CBC0BC0239@BYAPR12MB2806.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1079;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: LbwkWxvabIHcrdOSqcJIE++sNDaUfbSgoabtDVcaGfLPwllePD9YTWe5c+lh4n2ErYXKb5MjZJQtO5I1FgpvC1Jl5a3owtlhVpktUh3sT4986v1FN1VPpp7VRzpXqF6GOm/BxWxj5eCRGVRd33dXt4G5UiTJ8RnDjG+ADFn/vq3grFDYyTcWhK7jIUWbsy06EAyjnYtVF5MzQMiohTKBw9dEWwjOKa6yrXRTc8vr1EDfnaIf9Kqi9bNx+9pI8Xgdq2rnGPpdEGxqnTyaGVrryXnaboXUAmLUMfhKR6CO6yks4M5bjD6WCDtKO9uZUhKzY70LHPhPo7Xv7tTrK1NfaD3S4zJC87twotNw/eSopHpbji85BtmQ+aFdA0mo0aKEZCWlUmDVjOSK5m2IbQf0W8HMI0iBZJZOn+ekiNWuLYwr6HyVjP0qs49BkA7e9qNdTtBLxj4N4rrXqecoPxhxZiqYSEJVetTL5uBl32sh4nw/tJHU8w4I2c503Ro9pbYKyxP0VVAfiqA2KaVyQdRgq9lkIQ3lW7tLCd0kiskI7R9XHO/ZXiEfbYlL24E+dWWj7nbAUyKOyyfg8qo3/uisUEpljMObrez5W55x07KsE7V5YDpN1DKpoOky01BUhu9gaz/D5IHydmTS+BNFQKWuROZPNGhlrIo7vVTe0w2+2Fjvlt7VHYtLeBSbY7QMZ6zj46Wywoi8UReg6bCu3v8UwNuHfEysghiYlQNiDZeK1Zy9ng0thvI01plrn7x0g2hcMyk3fb+CUgLRmPKkJEFEAw==
X-Forefront-Antispam-Report: CIP:12.22.5.235;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:mail.nvidia.com;PTR:InfoNoRecords;CAT:NONE;SFS:(13230001)(4636009)(36840700001)(46966006)(40470700004)(82310400004)(2906002)(86362001)(508600001)(107886003)(8936002)(8676002)(4326008)(2616005)(70206006)(70586007)(4744005)(5660300002)(6666004)(40460700003)(26005)(186003)(7696005)(426003)(316002)(36756003)(36860700001)(921005)(356005)(81166007)(47076005)(110136005)(336012)(2101003)(36900700001)(83996005)(20210929001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jan 2022 16:42:21.4535
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5d755114-24c2-4683-646f-08d9e346523a
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[12.22.5.235];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT065.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB2806
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

