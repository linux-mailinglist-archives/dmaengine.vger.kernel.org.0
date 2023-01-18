Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 23086671C31
	for <lists+dmaengine@lfdr.de>; Wed, 18 Jan 2023 13:35:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230184AbjARMfZ (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 18 Jan 2023 07:35:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230500AbjARMe7 (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 18 Jan 2023 07:34:59 -0500
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2061d.outbound.protection.outlook.com [IPv6:2a01:111:f400:7e8d::61d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 812B241B56;
        Wed, 18 Jan 2023 03:58:23 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jgonAsIU9CSzV0TlETtT70HRiSYpR49irjfRw5w9Rf5Ssic3fNrMHN8RLEJrTO+c464oBSfuRddbEH6i5PDf+OP4W3rCJlvrK0dIBQ6zQiDhk5BsOPWzd5+5zHwTyL+aZgubgdFpuAjCyZ8TeJw8ALUIbhHhawTv+D3FcWYK70UVRf5AOb1K019NPhSWf29ke+bY/CF6uSL72+s4NM4eB1NvuhZGm0qyGDqGehD3ONNvkP0hPmHdmpTCJ/mf52Rr5a8OVvo6j/71BrwXm/jlZeCJ0FQg9nfQ15uSVqTFn8JrJ/qihn7XCsxY9c15V4NuNa0GRgMynSbwJQvVRF1U2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KBZx2EpcCn2Z+gHcq04DcVg9Uw3JU7K3xInL7Jl9cBs=;
 b=G5QkbHqXTjcmrPH5FB+CXzk4qETvq9Cloxc07ODPIr9lhlSOu1cTFbfRz0TdeHuEdwcc/ywVB0rMkzRWNhCoQafBXnjLQkhnZ6hxWwbrHBN8VdIceY+bJ7yiy1kzSeXmT5MdIt+T8pvzVX4dXEIpIyEuHQavgTHVCDXqD2zJhle/3X44qdAHvMiB1YJue+jqaQu+ESROsJoFUvUy1oK+1/mIbM5LWDNJG72W9m1JHHWxV09mXJka3gknC3T8jwPJ4T6zRgu/3IB0YnmASc0dOf9xjQj+Pz3fDnrLlVBVmzmexrpF+7SdyoVyaeJ4JLXQ2FyjRmWdCODe+CezpcdwXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KBZx2EpcCn2Z+gHcq04DcVg9Uw3JU7K3xInL7Jl9cBs=;
 b=orOGLTR0v57QCGLwHd3mQ+T5JPGI8BsZ40+vkc1yutSdrqehp9p/Ruy9ajP9CAl493KF6P+aGuev1HTw62ox6XEI0ualIXauSney1IP8xVASErW0Vmv/ZwVAbLD2Utj3uor1aaY1Bf1jT9Wc9lA/7ZxJ+GoMZmmq8gFeglmBSzQigBGsAEQ6gFf1tt8j0BkTmIcI8MD9rQlrW2G8cCIWQt73C2PozRRA1hTxVA4cqdPQqoW6NpXdbQtZfrZRia7RtzpWmm4Jrh4w162yiP5qtt5phE3X4ikyCTxdX8hSjyx8s8DN72NITVseOpz+TdAZu5Xs3D65dfZVI7vT5v0EKw==
Received: from DS7PR05CA0069.namprd05.prod.outlook.com (2603:10b6:8:57::21) by
 MW4PR12MB7167.namprd12.prod.outlook.com (2603:10b6:303:225::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5986.23; Wed, 18 Jan
 2023 11:58:18 +0000
Received: from DM6NAM11FT033.eop-nam11.prod.protection.outlook.com
 (2603:10b6:8:57:cafe::1a) by DS7PR05CA0069.outlook.office365.com
 (2603:10b6:8:57::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6023.12 via Frontend
 Transport; Wed, 18 Jan 2023 11:58:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 DM6NAM11FT033.mail.protection.outlook.com (10.13.172.221) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6002.13 via Frontend Transport; Wed, 18 Jan 2023 11:58:17 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Wed, 18 Jan
 2023 03:58:09 -0800
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Wed, 18 Jan
 2023 03:58:08 -0800
Received: from BUILDSERVER-IO-L4T.nvidia.com (10.127.8.14) by mail.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server id 15.2.986.36 via Frontend
 Transport; Wed, 18 Jan 2023 03:58:06 -0800
From:   Akhil R <akhilrajeev@nvidia.com>
To:     <ldewangan@nvidia.com>, <jonathanh@nvidia.com>, <vkoul@kernel.org>,
        <thierry.reding@gmail.com>, <p.zabel@pengutronix.de>,
        <dmaengine@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     <akhilrajeev@nvidia.com>
Subject: [PATCH] dmaengine: tegra: Fix memory leak in terminate_all()
Date:   Wed, 18 Jan 2023 17:28:01 +0530
Message-ID: <20230118115801.15210-1-akhilrajeev@nvidia.com>
X-Mailer: git-send-email 2.17.1
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT033:EE_|MW4PR12MB7167:EE_
X-MS-Office365-Filtering-Correlation-Id: af9a03b2-6368-4c34-1cb0-08daf94b499b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: x3NrsvVH+0WeyPeNdBxbxc5s3Bi23po84LTvxGd5U+8CvRSmVYDZ+VSQDZ/q1sJuLwA8+lFBv10c2OlbsmEptP+zPU58PAaj1krRVFDlhZtQBbwqsyHBZKQdvKUujPjKbz74H8pA41HXQs/ISsjxLCo2NKljWy8DzkW6/AjQAm0WGAYYKSg/gey5XQmy3mGO5ByN5hM5T2oNEgZVibtEKm8E7rxQP+FookH7igIhuy5VnM6PW9x/0RxFXLwIvm46dbEbPTHkSQZgKgkJ6cNSOj7AwBPmc9A/nkCVIh8NJMZQI5YRHGluAkPEO4RF+mTBWpgcqiZY6W9sFIi+cEaaH3zupFk4tGEw7WXEtP1xngcjLg/MtGO7MJSNHCwEIyI/GEtNCUEoUPsWhEKhO3njhw/XVfgpdL8kJy8igcTg8gzVUZ+7U6dKmmmxJYnWgVkt2UZNexPTOjOu4dB6dhLl3s7SMd10wbNtvo58RH5H7Rw5EjY3PUFGwDgrNVe2UWoluqjq0EQW1pru/oi+EXxUXuj4Ftdn1DmiOPaktf5HdMLP472gvJWzvxziGkKwicQjii3gAaZA6TAa18U+erXI/ZgVUkhkk3GcuvwhdJeXyCAGhLEGJb5p71HdXX51tJrZnlnHJKmoEIlcR8yHrxDawTDZlfwf1mdYSfskM2RyQNcyq03KeITr/8pLPD4OMF1CCqX07vTYvTCo3HDk5yErXQ==
X-Forefront-Antispam-Report: CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230022)(4636009)(136003)(346002)(39860400002)(376002)(396003)(451199015)(36840700001)(46966006)(40470700004)(82740400003)(7636003)(36860700001)(356005)(8676002)(86362001)(4744005)(2906002)(8936002)(5660300002)(4326008)(70206006)(70586007)(41300700001)(82310400005)(26005)(426003)(107886003)(336012)(40480700001)(2616005)(1076003)(47076005)(186003)(478600001)(316002)(7696005)(40460700003)(6666004)(110136005)(36756003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jan 2023 11:58:17.7705
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: af9a03b2-6368-4c34-1cb0-08daf94b499b
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT033.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7167
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        SPF_HELO_PASS,SPF_NONE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Terminate vdesc when terminating an ongoing transfer.
This will ensure that the vdesc is present in the desc_terminated list
The descriptor will be freed later in desc_free_list().

This fixes the memory leaks which can happen when terminating an
ongoing transfer.

Fixes: ee17028009d4 ("dmaengine: tegra: Add tegra gpcdma driver")
Signed-off-by: Akhil R <akhilrajeev@nvidia.com>
---
 drivers/dma/tegra186-gpc-dma.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/dma/tegra186-gpc-dma.c b/drivers/dma/tegra186-gpc-dma.c
index 1d1180db6d4e..8f67f453a492 100644
--- a/drivers/dma/tegra186-gpc-dma.c
+++ b/drivers/dma/tegra186-gpc-dma.c
@@ -711,6 +711,7 @@ static int tegra_dma_terminate_all(struct dma_chan *dc)
 			return err;
 		}
 
+		vchan_terminate_vdesc(&tdc->dma_desc->vd);
 		tegra_dma_disable(tdc);
 		tdc->dma_desc = NULL;
 	}
-- 
2.17.1

