Return-Path: <dmaengine+bounces-274-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 16F3A7FB271
	for <lists+dmaengine@lfdr.de>; Tue, 28 Nov 2023 08:16:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C6C78281852
	for <lists+dmaengine@lfdr.de>; Tue, 28 Nov 2023 07:16:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40E8B125D3;
	Tue, 28 Nov 2023 07:16:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="eq/PBK0d"
X-Original-To: dmaengine@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2076.outbound.protection.outlook.com [40.107.243.76])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3FECD41;
	Mon, 27 Nov 2023 23:16:32 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FmRxdm1kotJW/w0um6hMlXNtqVDhQOGptkW/l2z6ZoEZuvTpDO43i7TyhFGRX56INXqzFE5Z4ja7tNgLzP79rAinFZBb0NncDHzpTg3ftUuemqYWOoeB5ErOgOjEXnBjqcKw9ZJOO+ocvSvLdu2g9yZsDVM+z1WZzJD9HVbRqb7c3AeiH1L02v4tsuTJO227gBTgvRRUSaItQ0mSqMSeFdFQmGh/+DVtviD/TfRkriL7rWIpf3fbvY1T2SRaEV+jmgAlt3N707wHWJhxS5gBMfKEGL6HTpKanDSK0kbTsDr668eqfJmvZpJ7NU3kO0589JJkRfuvgkUYJYsEVHBdgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=t3KQXlpi54W4lYTL0TH4pmkDKa6qxHZ9Uc6hxiVOVRU=;
 b=VkUT+A9q4Imnb+4DTJtavSQhiNhDaPzLygcR+I8lu0czMtssgvZ3SUkrkHGgSkv7nGjdXLMyxrkhogTzGD2CRkrsb0MrwTlQ9tcjyHn+hy66O0V35Q7+1t49i/XIoEpeyfoBh2XuhZ1L9LjsRhrH6RW8vc24869rE1Ex3F/Gye7clQq/H8TgVrP11ixcG5HDRce8hfQPpDAA2iqxdV75sFhQuQfE5hWi9C0p0Z8YlGqqHotys8B4BI74h0ADNrR/nKIolm5bUhNQq1ZbuqVpmAYh7ypLYn1XAr2XafMWUG2IyHI2sco7p/eStBkESUVhDGjwztL7RH+SQyCC3wjHNA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=t3KQXlpi54W4lYTL0TH4pmkDKa6qxHZ9Uc6hxiVOVRU=;
 b=eq/PBK0daIlz4yOhK++SOOXI4zlZLl42LhtUgBSVZF9XcaTK92zwrbKwSrtDk/bscKigJDWuSmMLQhhxIaNa0rHiiC2xf1MtVcpsRMzOm6axclNT7jVZTiJc1oLyxNV/2ELb7DJ20waYxe/UbasN94Hcf0Q8U/gal+3LS+OKZZBRGdNCRy2cZ6AgwUQx1gp/qzlgaSszz5ptb28/cIt1WDUE2CKBHB1Ild/2UDzOYIELcFseRIExjCT7lrSfdhUkRb2yHz0K+WJ/2EE9rhrsCg8aZqh9oPY4CCuip8DDCR2CAalCOnFH7cVJk+c4/5XjM+QHzRQP0yKYUEPXoOnpfw==
Received: from MW4PR03CA0074.namprd03.prod.outlook.com (2603:10b6:303:b6::19)
 by SA0PR12MB7075.namprd12.prod.outlook.com (2603:10b6:806:2d5::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.29; Tue, 28 Nov
 2023 07:16:30 +0000
Received: from CO1PEPF000044F6.namprd21.prod.outlook.com
 (2603:10b6:303:b6:cafe::a9) by MW4PR03CA0074.outlook.office365.com
 (2603:10b6:303:b6::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.29 via Frontend
 Transport; Tue, 28 Nov 2023 07:16:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 CO1PEPF000044F6.mail.protection.outlook.com (10.167.241.196) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7068.1 via Frontend Transport; Tue, 28 Nov 2023 07:16:29 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Mon, 27 Nov
 2023 23:16:25 -0800
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.41; Mon, 27 Nov 2023 23:16:25 -0800
Received: from mkumard.nvidia.com (10.127.8.13) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server id 15.2.986.41 via Frontend
 Transport; Mon, 27 Nov 2023 23:16:22 -0800
From: Mohan Kumar <mkumard@nvidia.com>
To: <vkoul@kernel.org>, <robh+dt@kernel.org>,
	<krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>
CC: <thierry.reding@gmail.com>, <jonathanh@nvidia.com>,
	<dmaengine@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-tegra@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Mohan Kumar
	<mkumard@nvidia.com>
Subject: [RESEND PATCH V2 0/2] Support dma channel mask
Date: Tue, 28 Nov 2023 12:46:13 +0530
Message-ID: <20231128071615.31447-1-mkumard@nvidia.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000044F6:EE_|SA0PR12MB7075:EE_
X-MS-Office365-Filtering-Correlation-Id: c4c56db5-9fec-4e75-bf57-08dbefe1f168
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	OnrGHZXs/+ZWc/tRSVtSHvaqlW4AGbZfrKhEi92RQ9x1VOfa8PzkmraAVpOgpYyzjK71nlSZC/kCLv+CEDcmRmEduvs6R5mVl/mdxBcN9tCw54Cdqz9MA4ng7Dla05ouTBM3m4cHTlhc0bebT8rr6yCTqcrDiZc3GllTnsyiPlSf1ANqgGm1XHWeDyy2DOOlmSo1xctEuxyVozx/kjENUPritb7c2kwLxdNMiitYOhz4gFc7Uim4Fxei+rz2juaa7msCFGxw59X6xqJYR8+KuWeID0oDvRrMavJb5HgSmcJJs1MrgGioLSvkEkjE8Mr1VBljw+v8KcnoyMcm71FGiz7VDjLWJ6nyFyTRlvHBaZvZDNfy3Pg+WqqtPlzJidTL9O8/GnWdo28ZVxBzLlnGq9mu4TnKuosnq2oAaAP4BdeDeHYzswWBAYX+66tpeLhRn0ufz3AFvCATCHnkaTdi8aup9zGCFak/OlNwWQf2VRF0yvSs1hRWOfYwVPwdrj9QS4cIXzMVtWY9/fqyaNz2qExBcsNa0dLQ+VAyWwPPBmA1SYLxhMZ3ZWnmcYd30ANH/Zfpj5LGk9HouAJKhPsm9xQTcwpJ7Y2ZVuqAiCGLnc96T4b6PbgLfiIC6OH/bnmLVHBboivuB8DsxfFnaIVMKzD43oyzAKEeHLNRfK+r2K6DcFK/3K+VriupXtjdiIYr51TvZ4z6NbTz6OGs/J0ZssN78NaY+ndHkKdIL+OWKT1WcSWA/D3wtgHN1K1jBNn4
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(376002)(136003)(346002)(396003)(39860400002)(230922051799003)(451199024)(1800799012)(82310400011)(186009)(64100799003)(36840700001)(46966006)(40470700004)(83380400001)(40480700001)(47076005)(356005)(7636003)(336012)(4326008)(82740400003)(70206006)(8936002)(426003)(7696005)(5660300002)(54906003)(316002)(70586007)(110136005)(8676002)(36860700001)(478600001)(86362001)(41300700001)(2906002)(4744005)(36756003)(6666004)(26005)(107886003)(1076003)(2616005)(40460700003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Nov 2023 07:16:29.8973
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c4c56db5-9fec-4e75-bf57-08dbefe1f168
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000044F6.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB7075

To reserve the dma channel using dma-channel-mask property for Tegra
platforms.

Mohan Kumar (2):
  dt-bindings: dma: Add dma-channel-mask to nvidia,tegra210-adma
  dmaengine: tegra210-adma: Support dma-channel-mask property

 .../bindings/dma/nvidia,tegra210-adma.yaml    |  3 ++
 drivers/dma/tegra210-adma.c                   | 35 +++++++++++++++++--
 2 files changed, 36 insertions(+), 2 deletions(-)

-- 
2.17.1


