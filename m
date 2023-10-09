Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5FC5B7BD380
	for <lists+dmaengine@lfdr.de>; Mon,  9 Oct 2023 08:35:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232537AbjJIGfg (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 9 Oct 2023 02:35:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232035AbjJIGfg (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 9 Oct 2023 02:35:36 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2047.outbound.protection.outlook.com [40.107.237.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52624A4;
        Sun,  8 Oct 2023 23:35:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=J+vgW6qg8wgTr2IO6EMzK+Igo5bcyx4OvHvkXwmlDLeiZ+O4C5jPvOMlWIo0Fft1JPpwPX+RoEvOqQyVCPjDbPsU5JqnQlU8xKUPcAQy5a81hR7Nao1S74xyD4KRGgoRm423czmFZmQ4DCzIgQEl+nt/5t8rUwjfBKd9v5fBOAcQpOYl4N4Oc5BFra9P6IMRwLu4Kmi3YLFalg49U3vicR4FrtjpK2LGF0Luo0mnOfEart9IXefuQ0b1G/Jr5ObfmZjPjd+9gnmnZiJS5G/9+fEvR0ogxpp+i63dFrCFHn8WChVzBSoUQBzjkEyoEpYHzJNO5lMxxuCWxeZHaomyTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OaGrMCCLuelAOXP4B7WTHuoDOE6vFuCrM5OMz9lJRFk=;
 b=kVdmJ9mKevnwFBu0UoX1yIxH4/wM+mkkwb73A4eK1SH6xT8c0LhxEHMwFXyCTDkV/2v183PEBcHhuUKNbhY+LnZOWoOmmBZYXhEVCSgvmuvEDswf6OwwOjGhLKtAAMK9vcH4wIhdtqbe1Sfzw+udxJxBzwhz0mepDVoyFOuxg4TqCUr+jDocJEHDCaN2eWLk8e0cqqaYkAnAeDiQLB3ksnj4UcdV7Neas1D7407dB102B2evywzeKwzoQT2a4jtlyNOPlbwNIm2f/nA/NW3xGL6wZ2DMZre1x/cMNYP7dSjMOjmYY0UOBJ0lYiwtfmEVdQOvRlBlSZYONrRzWTl3FA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OaGrMCCLuelAOXP4B7WTHuoDOE6vFuCrM5OMz9lJRFk=;
 b=NI+HcO9vtRrcmsGo7PIcTvQKfc6UEOQ4llTrKQQ9OBBvyfJzzhZDstk/w8H4RAcqKMM6tmsco5Xi+dY/AnIu+1HBMlNINQoFFTrjIWT+RPY2vLcQNMFZRR67bEhG/SGP2f4fD0y6cePFXRS57gXUKq19SberDs8sXDSv8QXRAuWVUPi/lgJaX8dKT2ODE1ve4R61EQ8mQh0Z9jZQ4A0XsFhXrTqDV4UrcazCVVZ9vRao27ikZSKL26fqQpIfaDJJfOe9xUQq8IKOBSKXm+Pb5D8JagGNREZGvioo1C4nuj/TWT2B+k/dB5y0XxGod2ez20Fv8TT+b2v82UyLqg/Hlw==
Received: from DS7PR03CA0357.namprd03.prod.outlook.com (2603:10b6:8:55::10) by
 CH2PR12MB4040.namprd12.prod.outlook.com (2603:10b6:610:ac::20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6863.37; Mon, 9 Oct 2023 06:35:31 +0000
Received: from CY4PEPF0000EE3C.namprd03.prod.outlook.com
 (2603:10b6:8:55:cafe::f) by DS7PR03CA0357.outlook.office365.com
 (2603:10b6:8:55::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.36 via Frontend
 Transport; Mon, 9 Oct 2023 06:35:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 CY4PEPF0000EE3C.mail.protection.outlook.com (10.167.242.16) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6838.22 via Frontend Transport; Mon, 9 Oct 2023 06:35:31 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Sun, 8 Oct 2023
 23:35:26 -0700
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.41; Sun, 8 Oct 2023 23:35:26 -0700
Received: from mkumard.nvidia.com (10.127.8.13) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server id 15.2.986.41 via Frontend
 Transport; Sun, 8 Oct 2023 23:35:23 -0700
From:   Mohan Kumar <mkumard@nvidia.com>
To:     <vkoul@kernel.org>, <robh+dt@kernel.org>,
        <thierry.reding@gmail.com>, <jonathanh@nvidia.com>,
        <ldewangan@nvidia.com>, <krzysztof.kozlowski+dt@linaro.org>
CC:     <dmaengine@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
        <devicetree@vger.kernel.org>, Mohan Kumar <mkumard@nvidia.com>
Subject: [PATCH V1 0/2] Support dma channel mask
Date:   Mon, 9 Oct 2023 12:05:07 +0530
Message-ID: <20231009063509.2269-1-mkumard@nvidia.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE3C:EE_|CH2PR12MB4040:EE_
X-MS-Office365-Filtering-Correlation-Id: 0572c84d-2925-4619-2970-08dbc891ef82
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: nLOTu0Xl9xxcbHEC5f3pT3V03oFqE0HFXQXgqpDqZjLEChv4D64z9tzeUvikIuDmQohzyAaY71jjw37l8qycB1czuAYsEf/U/f+BDphTcMgFvp9L/CKNhwvyvwTWDIIV3UWU2f3dms0R5wzMZ6g+6e3haXhZ3KJR7DMKrvicszkvmfJ2pWakepwLDabXsyDy3Pb75wImnFN03LAA1Loi0/yRcwNCG+r4vbaofV+fFdSTjpa6juGsjWK4d2VPN1tSTjmodY7fsGJmZZ/ezOy00FTnGppcyIOxKlzQ1Az65uxyf8Fjr18kRFkDcUrCrcHQtA6TpibAkfHBXOPy6zNKuXo+3xO4iDgKbl9tOxPni6eXdB++V5NHBSe0gfeW10CNjupGmc8fdwOPJK3QfnqNtP9GjItX/sYyL1xLS0C/ooS//HZlB1odsHg5aFSjAlS5e1SaP46M2ILWcH/EKfQFnlTpKRL1uMK+rgpJX7yGTpKQer/1ARNdSK7mCvgekwQPHraF/ouHUSODhOrFMEQl+iOIVNCnGQgwIhIQttURpg2g92KDCQN2idLloYKRojgSbY+riVY1q2LKk3VntpsOtQNYIdfp35wVRm4h7MZO/ukjDvtGInIuHPr12jk/RQxnObnHVJIJ8EbiHLyeQJ5IEmiSPGzFwyxpBKKrcVHdvb4dvXUHaB+w1D40lq/EjLFFNFdD0CRDo2EwKT60eXDvQ4zP1s//2WkLKEJrRU7CHeaXdyjrdpQSOLdOuNaWVWtw
X-Forefront-Antispam-Report: CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(346002)(396003)(136003)(39860400002)(376002)(230922051799003)(451199024)(186009)(64100799003)(1800799009)(82310400011)(46966006)(36840700001)(40470700004)(1076003)(107886003)(2616005)(7696005)(40460700003)(36756003)(86362001)(7636003)(40480700001)(82740400003)(356005)(36860700001)(26005)(83380400001)(47076005)(426003)(336012)(4744005)(2906002)(41300700001)(6666004)(478600001)(8676002)(4326008)(8936002)(316002)(5660300002)(70586007)(110136005)(54906003)(70206006);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Oct 2023 06:35:31.6217
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0572c84d-2925-4619-2970-08dbc891ef82
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE3C.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4040
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

To reserve the dma channel using dma-channel-mask property
for Tegra platforms.

Mohan Kumar (2):
  dt-bindings: dma: Add dma-channel-mask to nvidia,tegra210-adma
  dmaengine: tegra210-adma: Support dma-channel-mask property

 .../bindings/dma/nvidia,tegra210-adma.yaml    |  3 ++
 drivers/dma/tegra210-adma.c                   | 35 +++++++++++++++++--
 2 files changed, 36 insertions(+), 2 deletions(-)

-- 
2.17.1

