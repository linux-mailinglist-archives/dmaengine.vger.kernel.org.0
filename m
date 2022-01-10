Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 50A61489D10
	for <lists+dmaengine@lfdr.de>; Mon, 10 Jan 2022 17:05:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236925AbiAJQFw (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 10 Jan 2022 11:05:52 -0500
Received: from mail-bn8nam11on2049.outbound.protection.outlook.com ([40.107.236.49]:59360
        "EHLO NAM11-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S236654AbiAJQFw (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Mon, 10 Jan 2022 11:05:52 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jCa8ffmW//3yx/Aknbh5/VWez3KZNnIJIHQwubskgw7BwaADiqLp6+XjVC032t5G4iAENbgTjp6jA7AuAoZPa+2pO4Z4xrpezRTF1UwEVvxIe6j3+Dlwd9D7irrGFoMVWx3YZfmAR24phwekNGK4BBZf7QA1nD04lyTxKMpalMZiBqZIapQeJzHigbiyl0NMFctM4XYZaV5vcj3Qt2ckGSoK2h/9KJx3ZE4BTDuu/o4q5Alj5BI7CzicSgZOw8ShzOl2mOauLk7lr1MAilSeapaQP/L77ObClfrvkDDW+gaNTcxBmSivLoaSse+fyZ4w393y0xE3cWnVwJoyovqTyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kJJWPm9bNJArnMndhKep3T8z6NESKmamZWLojV7y1Uk=;
 b=mGmfmiBeXl28esHtkwNwRQVOt5hZsAJ3HlXPlkNYBJi2L0A/SfxBrtj1MA6a0mfJjDXwpW1ytLJTDgvF3D69gBnxH2qkJp11u8aiN+HE1uIYIBHNshcZDokLmMyWiLJzn8MPaY7tFImO1KGIMsXVwfEN0IhhDGxlZF//HbXKLNluoma/jvOHiYWY8VMswAndx1J5IL9o5o3OCgkkD/RWBAkhim0cMc5+rha4YiKgDUr9zUNBCsNOXUWjNayAguS7h0/nH1siclDbSkV9iQuUcaZmGon8s42mdL2pfl/MiKLPGXymHxN+PqyWSdIIYLwsDlGeQoku+ldiuswrZ3tXGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 12.22.5.235) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kJJWPm9bNJArnMndhKep3T8z6NESKmamZWLojV7y1Uk=;
 b=KrsaAyWrL53sbIeaSbAHc5z7CfGDV78RdTHNJhza5HbF8GcowQdVje5NmTsYdQcS8lgV1KXcVw08TNmaohr6gKdu31fyL3JSd3FOWvELd46tFrmg7CNzKqPfK8OJItCX7e9BT4dUhmMLjWM/tOsW11FTW5lW57DatmZIoM6YfIdXDvo382cTsZtZHhEY12GaU330C0pwOTE7zQeCLxPD2AF/HCYKjA9HPrDayVP4LE77Tab/jV7ZtCj+JSMjJ6GBjZlYhSFT8Vk0GkDpaOscV6KdwGaWOGD0ttNYIVX+0daEjfNQuUKueUeo/OZifVJHpEk7aoducCJk8gvtRT9Y2A==
Received: from DS7PR03CA0152.namprd03.prod.outlook.com (2603:10b6:5:3b2::7) by
 DM4PR12MB5056.namprd12.prod.outlook.com (2603:10b6:5:38b::15) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4867.7; Mon, 10 Jan 2022 16:05:49 +0000
Received: from DM6NAM11FT005.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:3b2:cafe::f) by DS7PR03CA0152.outlook.office365.com
 (2603:10b6:5:3b2::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4867.10 via Frontend
 Transport; Mon, 10 Jan 2022 16:05:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 12.22.5.235)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 12.22.5.235 as permitted sender) receiver=protection.outlook.com;
 client-ip=12.22.5.235; helo=mail.nvidia.com;
Received: from mail.nvidia.com (12.22.5.235) by
 DM6NAM11FT005.mail.protection.outlook.com (10.13.172.238) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4867.7 via Frontend Transport; Mon, 10 Jan 2022 16:05:49 +0000
Received: from HQMAIL109.nvidia.com (172.20.187.15) by DRHQMAIL107.nvidia.com
 (10.27.9.16) with Microsoft SMTP Server (TLS) id 15.0.1497.18; Mon, 10 Jan
 2022 16:05:49 +0000
Received: from HQMAIL111.nvidia.com (172.20.187.18) by HQMAIL109.nvidia.com
 (172.20.187.15) with Microsoft SMTP Server (TLS) id 15.0.1497.18; Mon, 10 Jan
 2022 08:05:48 -0800
Received: from kyarlagadda-linux.nvidia.com (10.127.8.10) by mail.nvidia.com
 (172.20.187.18) with Microsoft SMTP Server id 15.0.1497.18 via Frontend
 Transport; Mon, 10 Jan 2022 16:05:45 +0000
From:   Akhil R <akhilrajeev@nvidia.com>
To:     <dan.j.williams@intel.com>, <devicetree@vger.kernel.org>,
        <dmaengine@vger.kernel.org>, <jonathanh@nvidia.com>,
        <kyarlagadda@nvidia.com>, <ldewangan@nvidia.com>,
        <linux-kernel@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
        <p.zabel@pengutronix.de>, <rgumasta@nvidia.com>,
        <robh+dt@kernel.org>, <thierry.reding@gmail.com>,
        <vkoul@kernel.org>
CC:     <akhilrajeev@nvidia.com>
Subject: [PATCH v16 0/4] Add NVIDIA Tegra GPC-DMA driver
Date:   Mon, 10 Jan 2022 21:35:14 +0530
Message-ID: <1641830718-23650-1-git-send-email-akhilrajeev@nvidia.com>
X-Mailer: git-send-email 2.7.4
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: aa03c537-efd4-445b-cf8a-08d9d45311ef
X-MS-TrafficTypeDiagnostic: DM4PR12MB5056:EE_
X-Microsoft-Antispam-PRVS: <DM4PR12MB5056577DE996DD91BBE38446C0509@DM4PR12MB5056.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mkJz1tgE3gTEkGttmudJRNW/sIrFWGISjLLbrU161luLaPiR4NW9ymWdcKTHWQwnyBvXqjMgfPOIfzrmJTOB2fuo3alOjayGoz1O9Jg0o2/L6QnO1e7ukBorKra7+UpWx4WD8BapH2g8se8zfU+GuATf4Bq2ZdSPGUKunhWC6NMLrcGg2i5LAD2bnfYP86px3fON/hQziDnPrVKfBvtuiBL2Odx/1uG+04lnzN5tp8hHZrAhffs+ZgMWsJal1uobxir5ws7RVziezu8/BIPjrv5e2Uss7DW6yA/vSAkX/0/uRA6p++Fkr9IuLI09si56CcGvgaUoThulzA4yoVSYZMMTMb6BgBbJpDNQKrxkZoUpG/Y8N3VfasDh3Qjfasaal6CXsbw+nUQggq9wtJ/zxXDK9Xym0gC9Rb1KPQOwHB70OPzScvvq9dwIdoEO4Bq+e5TeUCNyNWnpBhTHixcYZ35xx8W5MLwAs9xPaNinRJ4O1XAvItNCJhxO5yeOCyKaR+6I3xSmorNY/cPwVr3eHHxsLMWgcNM0eOYvkGjd7WgJWaoLO/KjkUiTsy4GBMS8L1o2KJZGEKCxtixP+SwT4FGq4+7Cz0hmIRkj6WOEVC9Ws9SS2Wvr58IB2naG6tbPnIhqj/iVTvfE3+FukKNTApPlGLsosSiZzLYsYlcCZeYmfRq7HMFbvwfhZcBvupKlrB5t5XoMX9Ur0YCV6Sl4EP9lwUJtgvbfutLthFD3cFyVrGCqleUFyN7MEbhSLse8Ut7RC8C9AvgEgak5dpwry/wdzinRHsaur6SfNPE0QjnQwC60XwjC8altao+66spzIAdRVYvwnAFq0OmoDSuGX06zO+5ZaMbg0WxeTiUstE/eaLlI4r7eLKPauHT7T+fvPVwJi1enJLaQwTJgiuY3lSubHHoI1KRzxO01E7kZCPp6RDItAZcvXyxBVrvsRTT6
X-Forefront-Antispam-Report: CIP:12.22.5.235;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:mail.nvidia.com;PTR:InfoNoRecords;CAT:NONE;SFS:(4636009)(46966006)(36840700001)(40470700002)(86362001)(316002)(426003)(5660300002)(966005)(921005)(7696005)(26005)(8676002)(40460700001)(336012)(186003)(2616005)(508600001)(6666004)(2906002)(81166007)(82310400004)(110136005)(70586007)(70206006)(4326008)(107886003)(356005)(47076005)(8936002)(83380400001)(36756003)(36860700001)(36900700001)(83996005)(2101003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jan 2022 16:05:49.5751
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: aa03c537-efd4-445b-cf8a-08d9d45311ef
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[12.22.5.235];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT005.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5056
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Add support for NVIDIA Tegra general purpose DMA driver for
Tegra186 and Tegra194 platform.

v15 -> v16:
  * Added cyclic mode support
  * Added device pause and resume
  * Added sg_req array to handle multiple sgs
  * Request irq only when a dma chan is allocated
  * Removed locks and busy flag
  * Updates in terminate_all callback

v15 - https://lkml.org/lkml/2021/12/16/905

The additional changes were added to align with the features that got
added in the interim.
Keeping "Reviewed-by: Jon Hunter <jonathanh@nvidia.com>" as the changes
were reviewed internally.

Akhil R (4):
  dt-bindings: dmaengine: Add doc for tegra gpcdma
  dmaengine: tegra: Add tegra gpcdma driver
  arm64: defconfig: tegra: Enable GPCDMA
  arm64: tegra: Add GPCDMA node for tegra186 and tegra194

 .../bindings/dma/nvidia,tegra186-gpc-dma.yaml      |  110 ++
 arch/arm64/boot/dts/nvidia/tegra186.dtsi           |   42 +
 arch/arm64/boot/dts/nvidia/tegra194.dtsi           |   43 +
 arch/arm64/configs/defconfig                       |    1 +
 drivers/dma/Kconfig                                |   11 +
 drivers/dma/Makefile                               |    1 +
 drivers/dma/tegra186-gpc-dma.c                     | 1464 ++++++++++++++++++++
 7 files changed, 1672 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/dma/nvidia,tegra186-gpc-dma.yaml
 create mode 100644 drivers/dma/tegra186-gpc-dma.c

-- 
2.7.4

