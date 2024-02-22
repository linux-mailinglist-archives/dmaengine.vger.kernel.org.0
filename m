Return-Path: <dmaengine+bounces-1062-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3222585F2F3
	for <lists+dmaengine@lfdr.de>; Thu, 22 Feb 2024 09:30:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B12011F2548A
	for <lists+dmaengine@lfdr.de>; Thu, 22 Feb 2024 08:30:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDF2E24A0D;
	Thu, 22 Feb 2024 08:30:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="fFr4A/Jj"
X-Original-To: dmaengine@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2044.outbound.protection.outlook.com [40.107.244.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2300024211;
	Thu, 22 Feb 2024 08:30:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708590628; cv=fail; b=RD4wKNyLAXU3k+SOUhbhr9c8oaT5bY1nsVG2gK4XebToh/5zuJjXB5ycwFg8JKfuXvOlJz4/v1F8uMNqE7xqAFL262ltHH1QTRX6wY5w7uz90SqBpfdy1apv8006bx5JEe1IUlbc1CIEn8ubZTJi5Nlfb7gM1YtWIINGxQLD7FI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708590628; c=relaxed/simple;
	bh=worhjI5lpsVYsGaaT9Pz/26UBmS23q+Q39jKXKfrCNM=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ct3Iu+roYX/vvilxPOWJa3MUBhu93GVEkDR74Ik1UVML7YGM3sEVjsyZfuIW3ITFSXFlw9BDLTXfCrQ2EpesaTuu6Vtp7CFkB4cpYnWbkG6Y4zay+/Z72aRQu8xfHkhIXQos38hB767Wpb/z32jY1q6D3cxT6EEB9wjFzHgqNIU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=fFr4A/Jj; arc=fail smtp.client-ip=40.107.244.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AQPlpK7iEUkvOHtu+AYCOW7+hwXMFs1C7pxuVe5fNWqQnnfIeaFCsm1Bf1uRYbPrajvDskZ9PQOmLR9k1fZIpk/D2aep71rIwsKqBcmcB0OcxFMYmlrlpKtjb1qPbgTY4/CFvvS33wiTLxd9y5atvf7b8X156XHL5imVRrhy0SPdT+iDQeYcHwm0n/lfIXDHHsqESXURRkhulYyiI2bCQqgYg5aaROPi0Xdwmw6LbojfsOYVwBtJYKf8DpCBTG+hpM8Py7RizzWB4Nc2kBKbx7Pd4ju4kAm30DeJ15QfW9J6R5X3cAwTG8lvttOjOMzAvViLosC6GAU0ePPUgkXSTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NwTnlJSdT3NuMUL6WQgNIS9T7kle4T0c7j8VJNnb0OA=;
 b=hxua96sdvSzrHIavsVCXsKTcBJeHo/4QQT9JkpmeuqwBwamToAyEHuMuQ2DnII7+oUsCV9gkSx5asNO0CBEEgj/u4njiGQqmoKlKJOGc5wVNtEGeVhhzSizvVzj8JpJS3K1qIiZT8SAQ/4VFhKka4YMuRo4OXIuwvwhrPEN6virq0W1bFxSzT7opn58R2p81HuRPukpZ4ZBFnjfe3b5sYSUKZaiS6j8GCXqfmbpGrfsFIcXMt8JzpkZdeMOUE/HiXNjEwM3TKbRxdsGzgYdJhUAMNquDY0xtUDYxexM+yEnNfIRMJ9as5pXjXmoHheyqED+DTZAKFVeb6BX+jastiA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NwTnlJSdT3NuMUL6WQgNIS9T7kle4T0c7j8VJNnb0OA=;
 b=fFr4A/JjTG4e7Htc2DtdI+7M8vzW88tcADPuNq0XBPALwovfEVAJbVCpebgfKhgpMe48IAHSTUBAInx8kplMVDCiagLjUbt2Kjj0XTyukIjdadUFiKoi5T2RXPEQR8NpbcsJhItV0HJv+EYa7gN5x3zkFJ9km07D0pVVYn7Jk9o=
Received: from DS7PR03CA0194.namprd03.prod.outlook.com (2603:10b6:5:3b6::19)
 by BL1PR12MB5160.namprd12.prod.outlook.com (2603:10b6:208:311::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.20; Thu, 22 Feb
 2024 08:30:25 +0000
Received: from DS1PEPF0001709C.namprd05.prod.outlook.com
 (2603:10b6:5:3b6:cafe::d6) by DS7PR03CA0194.outlook.office365.com
 (2603:10b6:5:3b6::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.43 via Frontend
 Transport; Thu, 22 Feb 2024 08:30:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS1PEPF0001709C.mail.protection.outlook.com (10.167.18.106) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7292.25 via Frontend Transport; Thu, 22 Feb 2024 08:30:25 +0000
Received: from jatayu.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Thu, 22 Feb
 2024 02:30:23 -0600
From: Basavaraj Natikar <Basavaraj.Natikar@amd.com>
To: <vkoul@kernel.org>, <dmaengine@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
CC: Basavaraj Natikar <Basavaraj.Natikar@amd.com>
Subject: [PATCH] MAINTAINERS: change in AMD ptdma maintainer
Date: Thu, 22 Feb 2024 14:00:04 +0530
Message-ID: <20240222083004.1907070-1-Basavaraj.Natikar@amd.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF0001709C:EE_|BL1PR12MB5160:EE_
X-MS-Office365-Filtering-Correlation-Id: 7d70a8aa-5648-4b16-14ec-08dc3380849a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	ComnwHHvuRRIPCKo+Bm3rGQSkKcdj243N9Y5u6rpLsb5tDMlO8z8tNruYDxJ61aZ/ABomu//Y0PiFt/9AOW7+//xujqYdBVAy3SJDUxSu18thYAwN1ZYZbuUkZGZgj1CKgvF4D3z7vyeYKYQQ+RZvj40fWl54u2BO08MAT/zAtzO+k/p43RQwysqhFOKOGUu9n7nqwP57ii2sOUMKzzrgdwm+xq1O8Qd37Rr2FtCIsuB/x/XH1uafuX2HspfTlEosZJgSy1+pebNFmhOLZIllKbHYavhcVQzo1i0hbMgeBz3csMtsubSLpU1ArOqqQ5gcvt4fWG2CJfZlf912mTvma+Z6J9ySpOSUwq48kA+p1QNXIggDkdBLE2wEJcav8/09ntJ2P/CqD9DSKAXiYsgL/q9Q5Oq+r/pRfTAPiIPhvbxiUYffE75dPR+UJfXQaFYpntPFt3cF3Cjw1xNzt5SqEnAaBItbsvDy44oUrJZG5q7s7o7shKr5jxTkTFy06hXVEIuB5+Hx55LPoyHqb8mInsnWLYOAbRy3FzBfKxCMnMYqT2zwwqBTYehD1IaMsiIJDuIwRk5eGze9k7/dz5Zk2w+x5U6VQwGXLbwoKKi9l6G3EaPhVaAOdBGk4fAuoAMUsXvWBawOwFrHAgFvKJY1w==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(36860700004)(46966006)(40470700004);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Feb 2024 08:30:25.2507
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7d70a8aa-5648-4b16-14ec-08dc3380849a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS1PEPF0001709C.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5160

As 'Sanjay R Mehta' stepped down from the role of ptdma maintainer, I
request to be added as the new maintainer of AMD PTDMA.

Signed-off-by: Basavaraj Natikar <Basavaraj.Natikar@amd.com>
---
 MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index e2c6187a3ac8..becd09410b8c 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1034,7 +1034,7 @@ F:	include/linux/amd-pstate.h
 F:	tools/power/x86/amd_pstate_tracer/amd_pstate_trace.py
 
 AMD PTDMA DRIVER
-M:	Sanjay R Mehta <sanju.mehta@amd.com>
+M:	Basavaraj Natikar <Basavaraj.Natikar@amd.com>
 L:	dmaengine@vger.kernel.org
 S:	Maintained
 F:	drivers/dma/ptdma/
-- 
2.25.1


