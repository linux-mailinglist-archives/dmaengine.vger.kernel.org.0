Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0CE1D3FB32C
	for <lists+dmaengine@lfdr.de>; Mon, 30 Aug 2021 11:37:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235604AbhH3JiR (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 30 Aug 2021 05:38:17 -0400
Received: from mail-mw2nam10on2074.outbound.protection.outlook.com ([40.107.94.74]:37251
        "EHLO NAM10-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S235535AbhH3JiQ (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Mon, 30 Aug 2021 05:38:16 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Dkk/31QQR4jCD2L+Y9QVAYsYuy6P7jm48CDS5AK81CtVQQADrcEGfR2YPoWU2YNgy3C0QjNoT4ruQaxx/403YB+L4wp5H0yJtn4gIGMr7PttO8lwCft2bj5zyoR5bjZleqRMX052EVog3zSHbZ9kM4TrsW3C4Ltr79vt/TF0tEoFuTmI57GwM5i6plp5xGkVlzvcUN5BoQ9RoS8fa8LYMLnIhNWK6FAchQqiAw6GwXXTsSPMNaOtMSmXnkqC7GGq0A3LVIFgGKGhYwpQxGbiQoSyb87auVhkxKGvkgoOmHU9yw6shdWBsQ8/SVGKF/Maxzf4zacxLza0MMFLUOi/vA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gSB1z2ElJ4XPqoNmncT8azt6bqnFqwzuZWI4eJ23Eek=;
 b=NHR+7sqEYyFYDqwgLBH6+rwnICtnsAeKeZ4BnniqPU9P2DmrAp01KexL8ZBXiiicRZ2ZB7Vf0yLmD4ObQRrXSxwObbppJQDge6X4HQk56BY0WULyEsFXojA1VU41nuIuMhqjU96AIE2qFrgmx6VhukvC+jNvSZYFv0D66mQApSx/WWiVdi4ntYCHr19CUPl73NfvJRXSJ7ts2LBkEDMSzIazPwZ+STUz3U8FlLWrp04mLbfSB53vh12RLVQNE2z/xp6FN6Y3RQWbAytAhd967689Bg3eOO89fD95ivWbI81MK+jXx0SKGNYapGp/SjczzXDsg/SogGlRmLeqHCWWVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.112.32) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gSB1z2ElJ4XPqoNmncT8azt6bqnFqwzuZWI4eJ23Eek=;
 b=q+MVwJlwBetvFwEdjnac9ZbFXEUeKLbvc6aI8BiGABELj43S49k/aL5713itRnIM8yiJ5k+mm1/w5u8wGqKCiAdNuyjnWTEm62fCTFq376QBUlHJ3MupRog856SNsiY2SckF7NyVSZveBRJ2x4R71os+h+6DJ0N2ZOLat3Fy6pT0namG30+M4AGqD4cetOmYXA00U1PUy9v33j2vWY3K96sjoMAFn3/xDB4r6koWJ62Jte6PJBNTQmtGN/LhAUk0xWNeYmHN+Kvk8//U5IQddtBmzjNlxW0lAbJ/fJ+fOK3rJXykYLBIABoQ+RHq/kmUeqVLdd/Cwn0YxzHX8GNHWQ==
Received: from BN6PR16CA0014.namprd16.prod.outlook.com (2603:10b6:404:f5::24)
 by BN8PR12MB2897.namprd12.prod.outlook.com (2603:10b6:408:99::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4457.24; Mon, 30 Aug
 2021 09:37:21 +0000
Received: from BN8NAM11FT036.eop-nam11.prod.protection.outlook.com
 (2603:10b6:404:f5:cafe::36) by BN6PR16CA0014.outlook.office365.com
 (2603:10b6:404:f5::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4457.18 via Frontend
 Transport; Mon, 30 Aug 2021 09:37:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.112.32)
 smtp.mailfrom=nvidia.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.112.32 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.112.32; helo=mail.nvidia.com;
Received: from mail.nvidia.com (216.228.112.32) by
 BN8NAM11FT036.mail.protection.outlook.com (10.13.177.168) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4457.17 via Frontend Transport; Mon, 30 Aug 2021 09:37:21 +0000
Received: from HQMAIL105.nvidia.com (172.20.187.12) by HQMAIL109.nvidia.com
 (172.20.187.15) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Mon, 30 Aug
 2021 02:37:20 -0700
Received: from audio.nvidia.com (172.20.187.5) by mail.nvidia.com
 (172.20.187.12) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Mon, 30 Aug 2021 09:37:18 +0000
From:   Sameer Pujar <spujar@nvidia.com>
To:     <vkoul@kernel.org>, <jonathanh@nvidia.com>, <ldewangan@nvidia.com>,
        <thierry.reding@gmail.com>
CC:     <dmaengine@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Sameer Pujar <spujar@nvidia.com>
Subject: [PATCH 0/3] Few Tegra210 ADMA fixes
Date:   Mon, 30 Aug 2021 15:06:58 +0530
Message-ID: <1630316221-9728-1-git-send-email-spujar@nvidia.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 84e2b77e-7060-453c-fd16-08d96b99c451
X-MS-TrafficTypeDiagnostic: BN8PR12MB2897:
X-Microsoft-Antispam-PRVS: <BN8PR12MB28971AE6E909208A9F2CAD55A7CB9@BN8PR12MB2897.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fMgpdP19988HF2SPDa6XArlwETXFu1l+ucktbR7i4G7p5EJAIjSeFmTpTGjMU7li2s9qoMEFeT4Xoyg350j34+t7kuTuux2mz45AOX2HeYKLx1oFrm25OawcWiZGlCfpgfe0cRpEv0OtHJSFfpL++P4o3agt+Qri8dA9HUMx8FrrJ/Pn7h9uyDiomtjOaZ6Z3mwU3BWcIkDJLHd/4pPGsNhr5llIrvSq41tiFJ/zKD6q7MMm6EHJbg3xSXYZYpY/uvVJpGhcGqjdM9cvDuya/5g1uzC8LQDoiGTdTs98Hu2tjstPCK4JHXW+c3TFi3KjXEFaw3PQYwsMNmrW7iM0vsUWrqJHHDIoeEUwstRiSVaciO3y/TINC3k8ukFHboh+R/Ht+MyV1BwsB5KqWmgoW57wAUCF4xo2yoGic835f2UKoDTEamBGpUdyN0moO3oWjqjmL3y05Q6SiMAySeTFpRpFYFgL7eVLtuLy7icnU/f81daWiYEu2DbI5D4E4qH5YEel3xB7uiy3zAJlT+06dtUCzoVNkW6XZjSKDDvDJ4Xy8KDs6EelbPz4e/m+ADuTEOFszctSh5J80kxR2+JXRptsuvFzyoNRY2mi4dFkrN+gzHt0omupExcENPzvpBy+dtAUgVnXuYoR7YW/Zi2+QDGK5AujCftTLEsmCWDSHlErp3j5P48tWjWT64Kro6PLxXoUNphT07uKpoWKt7LYQg==
X-Forefront-Antispam-Report: CIP:216.228.112.32;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:schybrid01.nvidia.com;CAT:NONE;SFS:(4636009)(36840700001)(46966006)(83380400001)(47076005)(70586007)(54906003)(2906002)(336012)(5660300002)(8936002)(110136005)(316002)(508600001)(107886003)(8676002)(426003)(4744005)(36860700001)(26005)(36756003)(6666004)(2616005)(70206006)(86362001)(186003)(4326008)(82310400003)(7636003)(7696005)(356005);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Aug 2021 09:37:21.5892
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 84e2b77e-7060-453c-fd16-08d96b99c451
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.112.32];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT036.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR12MB2897
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

