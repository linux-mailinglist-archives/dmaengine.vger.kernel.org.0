Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DCDDA50FAEB
	for <lists+dmaengine@lfdr.de>; Tue, 26 Apr 2022 12:34:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349146AbiDZKg5 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 26 Apr 2022 06:36:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349235AbiDZKgo (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 26 Apr 2022 06:36:44 -0400
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam08on2070.outbound.protection.outlook.com [40.107.101.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 693C2558C;
        Tue, 26 Apr 2022 03:19:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GQ7Hkq4Sv7KBgCOeZ6cle1LKFHjFn8hxktxtW/0yS4aLCusJUQIcdSsN+bTwM9t+Xqi+BjDYtvMYMxVceHgOFzcLxtGHTqHUlTFVlcEDDdkwUJ0Yajfoeo/q1mIlRL48dT5ow+RwRXZNr0boAt1DzbmrbeNz8FTq6kOee7iIa4UDl56zpslXxe2opV4/qL6N+HhPpPauhy2uSYSYIoM98n6mUWFCGz3PNAziG9y6+QKR2hCDdPRFJSPqTaBG8PiA54oWEtahZibjT9GdDooJdajWjBmNCEKeQm2MZSlRfbddZBgZudcqOAPjJMjq+TeXSdUNxdhMgDMl6crJuZTaSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Bwp8I/ZEuoKKK9dF7ApLwGY7kYSXyoqUCM2ainJqSMI=;
 b=BQdkYsbGpdJ9sI+/j3enUeNSj6dvYoKw29arZvdliWxEuXcO0OFVRUHQZm53nYS62DYh+1vvC/wd6BKrZt0wIAu2e8NEgs1SQFBO/yTGVmTmX4R1kEw45hACMLk88Wr4i0t5iuMsb4mvppuWofCC8oE3xPvCN9/p0U0Rk4hY6Pau1DPsD+86K8wwA0t764u2DvVgjhu+sWyRSZvn/WS2cqZb13OH86kyu5nMX7LZcC5vCWOUwCAO3b+PP1Dp3KfKRHh5ejTsyhBU5vkGRjPaqAwHCRYx1ETa1vLiNAbltX27ZTx91pOILgLpYrkTHEXm+kbDuWTNftG0OQKWoHYSeA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 12.22.5.238) smtp.rcpttodomain=gmail.com smtp.mailfrom=nvidia.com; dmarc=pass
 (p=reject sp=reject pct=100) action=none header.from=nvidia.com; dkim=none
 (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Bwp8I/ZEuoKKK9dF7ApLwGY7kYSXyoqUCM2ainJqSMI=;
 b=D3xDKZGp+4nmMAtnggEbNUidqT2Bk3Xiqx1oSSncsjlVAg4F7svUgWqRc8csnw+TAelyX4U7tLMdciTRCLvlfnehlL8AyHb+7P6VJ+tLp4E3IjAT75Kbp1HQILOqiCvn/fbKNDFqhre1XUngRbAchY5WE0QPCjlZ1EQ9Exy1/fh3wZNlysVTPfGDEp1+uqW44glk3eo0vbBs8rkKKJ9az9p1MutTwNl6QXi4mlFR8yHCFFi+rckTXwoRuteJcSShG+2a4ViTT1aIFYGb9B51QxmQhVV6qW5kAevHsQobGdoEr0Uoy1eTEE3IaQCdiGeONQN2HehVOfPvxEPZBhl8HA==
Received: from BN0PR07CA0017.namprd07.prod.outlook.com (2603:10b6:408:141::31)
 by MWHPR12MB1920.namprd12.prod.outlook.com (2603:10b6:300:10e::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.18; Tue, 26 Apr
 2022 10:19:24 +0000
Received: from BN8NAM11FT012.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:141:cafe::97) by BN0PR07CA0017.outlook.office365.com
 (2603:10b6:408:141::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.13 via Frontend
 Transport; Tue, 26 Apr 2022 10:19:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 12.22.5.238)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 12.22.5.238 as permitted sender) receiver=protection.outlook.com;
 client-ip=12.22.5.238; helo=mail.nvidia.com;
Received: from mail.nvidia.com (12.22.5.238) by
 BN8NAM11FT012.mail.protection.outlook.com (10.13.177.55) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.5164.19 via Frontend Transport; Tue, 26 Apr 2022 10:19:23 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by DRHQMAIL105.nvidia.com
 (10.27.9.14) with Microsoft SMTP Server (TLS) id 15.0.1497.32; Tue, 26 Apr
 2022 10:19:22 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.22; Tue, 26 Apr
 2022 03:19:22 -0700
Received: from BUILDSERVER-IO-L4T.nvidia.com (10.127.8.14) by mail.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server id 15.2.986.22 via Frontend
 Transport; Tue, 26 Apr 2022 03:19:18 -0700
From:   Akhil R <akhilrajeev@nvidia.com>
To:     <devicetree@vger.kernel.org>, <dmaengine@vger.kernel.org>,
        <jonathanh@nvidia.com>, <kyarlagadda@nvidia.com>,
        <ldewangan@nvidia.com>, <linux-kernel@vger.kernel.org>,
        <linux-tegra@vger.kernel.org>, <p.zabel@pengutronix.de>,
        <rgumasta@nvidia.com>, <robh+dt@kernel.org>,
        <thierry.reding@gmail.com>, <nathan@kernel.org>,
        <vkoul@kernel.org>, <dan.carpenter@oracle.com>
CC:     <akhilrajeev@nvidia.com>
Subject: [PATCH v2 0/2] Fix uninitialized variable usage in Tegra GPCDMA
Date:   Tue, 26 Apr 2022 15:49:11 +0530
Message-ID: <20220426101913.43335-1-akhilrajeev@nvidia.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: bd212114-0703-4376-b37e-08da276e3c54
X-MS-TrafficTypeDiagnostic: MWHPR12MB1920:EE_
X-Microsoft-Antispam-PRVS: <MWHPR12MB1920F4163738329ABEFF0712C0FB9@MWHPR12MB1920.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: PhGThzj/OMgRFMipXGll6sZRhpXRypfRT7dfS9m/9JMXd/Jc+ZwFctNyOCx2OQPrJjyLR6eocEf/gAZU3Q1XTcGNA0s9bsVTTvD+TTw9K5WfPQXmI70q2dKTsisy/U7PtTv7Wh2s2nHRjQMN0ltclINpFZyTYQxpPEnomD5Y+Udy0GMhidc+cu+nShFp6wFVpH9wzGsuMao020n5xDGHQtMt3NXK8CeIB5U2bPXkvS5PWYTGb4Y+llBdtlyrC2642eoNV6gmzInbrFUr1KKT3UWr1jKquZkat5qkZgIxE/GRIGjszx/CixzE+E7+uaqXbncptf6i3gDkLH2V6KcJhyNiOOFY94lnfkleesTX7/MkyBmniIdca7akGnmdneUtZiPEv759IBXAKiGjEdfcMh5GrKb4r7RlGnp/f2vSIMh2nUdPvTPmD4VHjF+js7TihuSm1KBGw3jY6WfJNugdtZ2aIGVMXGS1DyE2NZFxcjJ7FkicO0qwROfxSNWX9flT5KyRcZJ0IKpd3HhtcusIbW8QYhtZPo7EaU8jLnywejKYG85/nOac12a6CkzgU0SHWJLH3PESHY2fZeqaCatb4715sVPsoUYJn1pr7iM9EFfuBx3N9ZFFUb9gjGYtjVnc4Sa9884DNP74dUktuTHx1kfhRKuA/VJwKhj+oyUbetXxCCFyQxzhR5eQlLnZIuWttnxCE0hEpyJgcH/Pdif9/VqY9+VH7rnsMBptrH910EdpVeU3V67pz/iKPOpuuJ+DmZoYgP8b7gMmiHTJiJZKyg==
X-Forefront-Antispam-Report: CIP:12.22.5.238;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:InfoNoRecords;CAT:NONE;SFS:(13230001)(4636009)(36840700001)(40470700004)(46966006)(82310400005)(70206006)(70586007)(8676002)(186003)(4326008)(336012)(426003)(5660300002)(36756003)(6666004)(26005)(7696005)(316002)(47076005)(86362001)(921005)(81166007)(356005)(2616005)(1076003)(110136005)(107886003)(7416002)(2906002)(83380400001)(36860700001)(40460700003)(4744005)(8936002)(508600001)(36900700001)(2101003)(83996005);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Apr 2022 10:19:23.6697
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bd212114-0703-4376-b37e-08da276e3c54
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[12.22.5.238];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT012.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR12MB1920
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Initialize uninitialized variable and remove unused switch case
in tegra186-gpcdma driver.

v1->v2: Split the patches to separate 'fixes'.

Akhil R (2):
  dmaengine: tegra: Fix uninitialized variable usage
  dmaengine: tegra: Remove unused switch case

 drivers/dma/tegra186-gpc-dma.c | 12 ++++--------
 1 file changed, 4 insertions(+), 8 deletions(-)

-- 
2.17.1

