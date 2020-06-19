Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5272E201E33
	for <lists+dmaengine@lfdr.de>; Sat, 20 Jun 2020 00:47:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729619AbgFSWrW (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 19 Jun 2020 18:47:22 -0400
Received: from mail-db8eur05on2063.outbound.protection.outlook.com ([40.107.20.63]:32173
        "EHLO EUR05-DB8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729616AbgFSWrW (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Fri, 19 Jun 2020 18:47:22 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Xn3uxZIMZpJVFIyUqGrtUYl+a2HiGMxmOKCc0pBDGKuDjje9OAvDO/i7G8PSiNOBqRfUUKMVObfsyBiuLPR14rYLrGSM46SCKTobUi8BE0ZfxFpJMTxu8uRuibbLsYOTx2qWavgsIQiF5eKEbhypXzxYyVGShwFCImsU/4l6hHZEkh+7OwGu6cpDwJFJW8LAZ54WqoOGgVgzjHhiXWPrHog9rEma75DFSerTX759F5dv2GeOSLzX7ZCyqXXY9TeYPTUIq5HOA7gtRkiWNF1fj9akAl/JwEd3qaos7dVusgp7rxur+pbtfAVFvCiWUZRYGedtMuyQDZu+SAb1TUC1mg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=N3imS6TzLI0Je+WASE+I6/cvV7eqKmdKwa80JxICE78=;
 b=EA5JbCpRx/dC55wBW7jctm7G7/cxZuZEDLpCFoW51E6CYel1CmrqslUU1mmxXhx87e1T0pQncv5tHre6wPFjA5YsBqMCYV4UUpJoFmj/XmhcuFPIHCazYHlJ8L/vuOMoEhgQebefnR9wsXUiM7pJZUmite2GgGzJkSCo2sB4RcJ1gb7S4ugq66WtxxaYsxnMK99LB1mefLbl53O04iO8phv1Bzuspyrofqi+qlKKLUdCzc+dYa3b9VLOIGuAKatk5p+4YSmqsfZ7Oki4eyTTz6ZaNxfZFNVrmJ0X6CfzgtX+PxKRjGrOxVp16oJU84NMKl+t5VqHjHnWvprMGERVRg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 188.184.36.50) smtp.rcpttodomain=kernel.org smtp.mailfrom=cern.ch;
 dmarc=bestguesspass action=none header.from=cern.ch; dkim=none (message not
 signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cern.onmicrosoft.com;
 s=selector2-cern-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=N3imS6TzLI0Je+WASE+I6/cvV7eqKmdKwa80JxICE78=;
 b=Mg/pNWVq52cwNCmUEKKVG1UP+tfxdoZ1ZO5nj34oKaXPz1gAvucmYvMD+tbAtlPFVfNUDHr431jXyfaP1zDsasfKbwTIu0WkV9jBarQiqk5d5l6KAJKJfH7vGAxdR2FVHys5EptGCheizd7BQtbO15uVezbwfHeH2TcNoCMCbRQ=
Received: from AM5PR0502CA0017.eurprd05.prod.outlook.com
 (2603:10a6:203:91::27) by VI1PR06MB4480.eurprd06.prod.outlook.com
 (2603:10a6:803:5e::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3088.24; Fri, 19 Jun
 2020 22:47:19 +0000
Received: from VE1EUR02FT014.eop-EUR02.prod.protection.outlook.com
 (2603:10a6:203:91:cafe::3c) by AM5PR0502CA0017.outlook.office365.com
 (2603:10a6:203:91::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3109.21 via Frontend
 Transport; Fri, 19 Jun 2020 22:47:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 188.184.36.50)
 smtp.mailfrom=cern.ch; kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=bestguesspass action=none
 header.from=cern.ch;
Received-SPF: Pass (protection.outlook.com: domain of cern.ch designates
 188.184.36.50 as permitted sender) receiver=protection.outlook.com;
 client-ip=188.184.36.50; helo=cernmxgwlb4.cern.ch;
Received: from cernmxgwlb4.cern.ch (188.184.36.50) by
 VE1EUR02FT014.mail.protection.outlook.com (10.152.12.148) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.3109.22 via Frontend Transport; Fri, 19 Jun 2020 22:47:18 +0000
Received: from cernfe01.cern.ch (188.184.36.42) by cernmxgwlb4.cern.ch
 (188.184.36.50) with Microsoft SMTP Server (TLS) id 14.3.487.0; Sat, 20 Jun
 2020 00:47:17 +0200
Received: from harkonnen.localnet (2a04:ee41:86:7004:224:1dff:fe7e:2981) by
 smtp.cern.ch (2001:1458:201:66::100:14) with Microsoft SMTP Server (TLS) id
 14.3.487.0; Sat, 20 Jun 2020 00:47:16 +0200
From:   Federico Vaga <federico.vaga@cern.ch>
To:     Vinod Koul <vkoul@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>
CC:     <dmaengine@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: DMA Engine: Transfer From Userspace
Date:   Sat, 20 Jun 2020 00:47:16 +0200
Message-ID: <5614531.lOV4Wx5bFT@harkonnen>
Organization: CERN
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Originating-IP: [2a04:ee41:86:7004:224:1dff:fe7e:2981]
X-EOPAttributedMessage: 0
X-Forefront-Antispam-Report: CIP:188.184.36.50;CTRY:CH;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:cernmxgwlb4.cern.ch;PTR:cernmx11.cern.ch;CAT:NONE;SFTY:;SFS:(136003)(346002)(376002)(396003)(39860400002)(46966005)(36916002)(478600001)(33716001)(336012)(54906003)(9686003)(26005)(2906002)(558084003)(86362001)(8936002)(70586007)(7636003)(70206006)(47076004)(44832011)(82740400003)(426003)(316002)(82310400002)(186003)(356005)(8676002)(5660300002)(110136005)(4326008)(9576002)(16526019)(39026012);DIR:OUT;SFP:1101;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f1a543f7-65d7-4ee3-9d47-08d814a2b8a1
X-MS-TrafficTypeDiagnostic: VI1PR06MB4480:
X-Microsoft-Antispam-PRVS: <VI1PR06MB4480C8818BCDAC97C5002CA4EF980@VI1PR06MB4480.eurprd06.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5797;
X-Forefront-PRVS: 0439571D1D
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xlEqNwvyIzju3Yk2TOmSSXmIvbE83VvsFeT/LhBN2DcPbUYAlQ5KQzTLDYeFEwpKYYk9Xo9uZUKcimAktyPT1plinpuRLPomIsNqtz7a6+kic6h3jrKF86wXxMNNzRNd4waPcdw8jtuOA+dmIdjY83s4doNvo0WT+ymUep/0r4fUkGAm2xacBNo1L3T7b6iGxlMXevOHzajzl4ovd6MfYAI/zWqMcs0UuVOTTKU892Z92CXgVEqfpqGVJETUKNGq1IpWJ+/Mp15jEt/MsDQ4R1jcv1QcvzIONIuBkeNtXwSE4dmXu0uO2PoAt1mBGxV8qoDocg4qIA5NQNTTfr5DTO10EIBYU2tU1Xfguyfq0UuIqnBMMDFCfhnp0ZhwMxykyWJl/0JxgIjupbXnSgyf3hchEn0FAmhkXq6S2HDTzpo=
X-OriginatorOrg: cern.ch
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jun 2020 22:47:18.4522
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f1a543f7-65d7-4ee3-9d47-08d814a2b8a1
X-MS-Exchange-CrossTenant-Id: c80d3499-4a40-4a8c-986e-abce017d6b19
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=c80d3499-4a40-4a8c-986e-abce017d6b19;Ip=[188.184.36.50];Helo=[cernmxgwlb4.cern.ch]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR06MB4480
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Hello,

is there the possibility of using a DMA engine channel from userspace?

Something like:
- configure DMA using ioctl() (or whatever configuration mechanism)
- read() or write() to trigger the transfer

-- 
Federico Vaga [CERN BE-CO-HT]


