Return-Path: <dmaengine+bounces-1143-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 72CB886A78A
	for <lists+dmaengine@lfdr.de>; Wed, 28 Feb 2024 05:22:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A8C05B24DA1
	for <lists+dmaengine@lfdr.de>; Wed, 28 Feb 2024 04:22:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C9572033B;
	Wed, 28 Feb 2024 04:21:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="qAFGkoTv"
X-Original-To: dmaengine@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2052.outbound.protection.outlook.com [40.107.237.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EE0D2032E;
	Wed, 28 Feb 2024 04:21:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709094116; cv=fail; b=SSs7oehpw8Mvj09G4V96HPxAV8PxvH2H3Y7JgNE5OyAWkTzPMqScImt5qnrwSiyni9v1KCFRo8mPdp9uprfeN7ZE6JCr2ov5Ug614PjOodDW3GeTzWnc0yXseYnkYR3iXPPPNMhzZ+XnyrNmj3aQeXyOn9HtPbG3VoGgVAAZUzA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709094116; c=relaxed/simple;
	bh=Jjl6bUZyZM9HAWc2HdScR5HmX6RPbCymM/Gtn7djzU4=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=BIaOsqXO5w7l9EQxqdBrRSx2kP7OFG1GU0fDuL1vEqGDJRrSVol+gtgKb0UYB9GLHI5rVjU9Ff4YwadSYbz416W1GIWSjim0oiDDbiscsgSlcRUpXxW1zlfIeriN26JpGoOqVDL5CkUOvpKoeXf0Q/cSBESJAcUtb64I4oBjexU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=qAFGkoTv; arc=fail smtp.client-ip=40.107.237.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TfOjSenBdbFH0y8epjQSEJgiuW2RfGQl9T+/IwLWw7q7mci1+0+lUk1OepmxNhxaTL94qptV/wp4H/iL0xXYaaq2lGaH1zkjv/hYxfevvu0eF5InDLK0qoq8U7aj4j3f1A2J0/AVWmC5NSrEavNBl8c/7qVu4QaE9J7GpomdbCdaXG16ggMs5WC01cSVMkoatpx13pCbWFYoXaiKlbqezPVSXVBTn79ZugGSF6KjkynpvuloV016oZQa94DEh6RxJiyyHN67dEtkoRHjxJfevlmveWwyCSW6a5aFQI9QgSaT8rElLLf0ubLtnV2TY2JkXPMSNoGdyrb18hFYJZKg2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XI3i+5WFBbnJhsIbY4/SMJxA3KKTWSBkM8vQTbI+s0w=;
 b=da74ZpDScz4Pwfx7YWFjZhGtU1pImwH4fJ7om4ywkHnhe9eW8FLDsBIRDlL7x0Z1uglHaUmtIBg/nqKT4sp7iwqWnN1vX1gmOw5KWFShHhuhgcbVx0vxx1eOCTVyJE7uEnuImCoEh2wt0EufXB9X/3nzWky+4V55lLKuNfb6B8c/Sdu4NYC5FHDuVaJtgdsg0Jf0tH0kvxaP8Tzsm9BrxNW6bKXzkBcrXnW6X2O+ho74tuyoRn6QaVxZvDSuqJqONVgW/xBEMIAuq0nz9nL7Sd9joPHRmEHCxQ9+QN5Tp02bGuUEU/N041W/3XHUzyNapefwCDbpBGUkoXXZfccnfg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=ideasonboard.com smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XI3i+5WFBbnJhsIbY4/SMJxA3KKTWSBkM8vQTbI+s0w=;
 b=qAFGkoTvCbqZCQVENfxZyRAK/85a92cU2Cvwl7KYPns//wyF/3+O5Y3Bc1XsFyi9Y/OzrsZ1O88CqA0tYkLoBZFJdFWQOoSjYlVmfFdPwZo30OzHBLLuUt4dvxZgpLldBFNfuCruA+iipqIUMxCOrrFKWDNGHwTKoV165QlVGx4=
Received: from BL1PR13CA0340.namprd13.prod.outlook.com (2603:10b6:208:2c6::15)
 by PH0PR12MB7908.namprd12.prod.outlook.com (2603:10b6:510:28e::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.34; Wed, 28 Feb
 2024 04:21:51 +0000
Received: from BL02EPF0001A101.namprd05.prod.outlook.com
 (2603:10b6:208:2c6:cafe::1a) by BL1PR13CA0340.outlook.office365.com
 (2603:10b6:208:2c6::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7339.27 via Frontend
 Transport; Wed, 28 Feb 2024 04:21:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BL02EPF0001A101.mail.protection.outlook.com (10.167.241.132) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7292.25 via Frontend Transport; Wed, 28 Feb 2024 04:21:51 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Tue, 27 Feb
 2024 22:21:50 -0600
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Tue, 27 Feb
 2024 22:21:25 -0600
Received: from xsjssw-mmedia3.xilinx.com (10.180.168.240) by
 SATLEXMB03.amd.com (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.35
 via Frontend Transport; Tue, 27 Feb 2024 22:21:25 -0600
From: Vishal Sagar <vishal.sagar@amd.com>
To: <laurent.pinchart@ideasonboard.com>, <vkoul@kernel.org>
CC: <michal.simek@amd.com>, <dmaengine@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	<varunkumar.allagadapa@amd.com>
Subject: [PATCH v2 0/2] Xilinx DPDMA fixes and cyclic dma mode support
Date: Tue, 27 Feb 2024 20:21:22 -0800
Message-ID: <20240228042124.3074044-1-vishal.sagar@amd.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB05.amd.com: vishal.sagar@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A101:EE_|PH0PR12MB7908:EE_
X-MS-Office365-Filtering-Correlation-Id: 581400dd-a331-420a-5fba-08dc3814c9b8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	tEWF/ZBkbCV1hWf+7K47BYhI0trj7vjd8hnpGoU3edwlW9SbbZFdwHYGSB8ZKFnaiMcbitg2OUsgtdnjIg9W2UI/CXeFA/nFJrwGjHWxcPleHs3y3EliPb5hZN09TdQ6ApO48Azqdel1i7qDgGJpnXH4jjWbHiJ4m/m+DXwVcSuPOmYYtjDJ3ibM9P5wKopO07oM2rBW6xwXvgfLIKPP+wk+3C8uaJ4T0zPKLrmI9nhmkF8GJUTQOpLGvlFfLxRHBxR3on+zNwPkAnfdSmWImwQxWHrmiuPd/vmyi7hVc7pg5NdjzpgpwR+10ZqfN3Vakferqi9t+UUaGQfnlAd4JWvaLLhb+2DOJdUWkiKEefSMKO1cB/kIXEMLKsee73D9XgyZrhwqSkPi/gYYECIX/d5hC7qKROkP01QoUnG9vAAXq9XgGqIlKZnVuXZIiGXm9XhzVVKqhNLd9RZnWaBfg6Ua0bEMKT16MUrh+bCFsvD1O/9JoiKc8CRI4uiKqCCFKWUpCBYBAtW1KwInPpZkJPfQKI/pqr8CKms0fbXtymNkAMjIiH+v+42Yhs2u1lDdtqDUrAqzM0K/+8W72r30E7+92vvvzssd0Eq1atjBv5cIgtP2omIgUA4BIOqjN6dw91vzlC1wJ+ZT5XOX48e39eT8cjNtxCNfYwx5yvPRqTC/StYsDvQ3hQIsLP9mFEHHWdPBcj7rikYNi7uQQYZeSMjNUKaXmmDOrGXlQ1fx/VM=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(82310400014)(36860700004);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Feb 2024 04:21:51.4103
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 581400dd-a331-420a-5fba-08dc3814c9b8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF0001A101.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7908

This patch series fixes the race condition in vsync IRQ and also adds
the support for cyclic dma mode. The cyclic dma mode is added as part of
preparation for adding audio streaming support.

v2
- 1/2
  - Fix as per Laurent's comment in
    https://lore.kernel.org/lkml/YftWeLCpAfN%2FJnFj@pendragon.ideasonboard.com/
  - Add taking lock in another place

Neel Gandhi (1):
  dmaengine: xilinx: dpdma: Fix race condition in vsync IRQ

Rohit Visavalia (1):
  dmaengine: xilinx: dpdma: Add support for cyclic dma mode

 drivers/dma/xilinx/xilinx_dpdma.c | 107 +++++++++++++++++++++++++++++-
 1 file changed, 105 insertions(+), 2 deletions(-)

-- 
2.25.1


