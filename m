Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A16AE203341
	for <lists+dmaengine@lfdr.de>; Mon, 22 Jun 2020 11:26:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726500AbgFVJ0O (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 22 Jun 2020 05:26:14 -0400
Received: from mail-eopbgr50082.outbound.protection.outlook.com ([40.107.5.82]:27673
        "EHLO EUR03-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726380AbgFVJ0O (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Mon, 22 Jun 2020 05:26:14 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=E1najM7azr1q+Wj2yWAxXzWfsGifLu6VB7B4S1buM3Tq4Uvmc7GE+RF+gWoFSHNlEOqDmwjjGf3REIFLJ2St/pa2QqtsWmEq0h5GLXDxy8/fV47j6qs7U5ypk3hMDUV6dFhZIHX+KzOSoOUiWfQNRlAfCgafDpbL+NBBtBcluZC5dSGntYHh0r9LhwWeL16eO6OqFVPIK4AHm9ih8GbJz+aZ9vEW4wK+7mAf9SgieGCFcIFzkERws1uvb6sGXQfdNGWOzasE/R8PRcBqzPAxR8sX8SNCEteWh5u0+snVliwQoKLldXcpCJjLsqaSbqjVQO5jHo85F2YAbCDNpA/KBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OsPqcEGFpvW34BilfsLOEyiqcpuR+4C56J9cYEjJDIo=;
 b=kP/KM5xDLJ6PbeKaXIc9m4WDGzg4wIuTI5sCkCYR+IBTXvjE3EiXJo9yHzpf9TRttFy6QgfzpGz8q5cSuS9mAcYcPSWzp9OLSl/POYkDl0ikcGW7NYPMDqndwSJrxatJMXL/L5CeCQRC+Y3HClHJg1RJrJenwjB2wFrzXogZhXsIIRCfobR/ylJBg59SSQDeLcrsZtFDfd7ZKHuqbN86ReJKo4r28o0LFhCC/FCGou8yYVmUWfkuqevYoDo7RehgjoKi7cIPJXH2cHJ/97AZPDmcMSrep+LdEEngAi2KXYRHDonBVOH9FIR06Kg523bSh/sKsaFaV4OhC0eY1QB++Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 188.184.36.50) smtp.rcpttodomain=kernel.org smtp.mailfrom=cern.ch;
 dmarc=bestguesspass action=none header.from=cern.ch; dkim=none (message not
 signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cern.onmicrosoft.com;
 s=selector2-cern-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OsPqcEGFpvW34BilfsLOEyiqcpuR+4C56J9cYEjJDIo=;
 b=tDh6E6Q9Mb2DJYOJNyyV+pNlhrJLBij5Y2YbRQzHBm6cvB0G0cXV/fYfRORlM14ZTAMmpqhx+3hYRnDg8EDaJDz0TtvBBS9qeiwKEhkunos8pFZyYaZ+suxA1mzQDYPAJ9DCVEjfzAk1dvg9ep+Veb+Ma7LbOGFs2xt8ImbRiio=
Received: from AM5PR0602CA0007.eurprd06.prod.outlook.com
 (2603:10a6:203:a3::17) by VI1PR06MB5856.eurprd06.prod.outlook.com
 (2603:10a6:803:be::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3109.22; Mon, 22 Jun
 2020 09:26:11 +0000
Received: from VE1EUR02FT032.eop-EUR02.prod.protection.outlook.com
 (2603:10a6:203:a3:cafe::b4) by AM5PR0602CA0007.outlook.office365.com
 (2603:10a6:203:a3::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3109.22 via Frontend
 Transport; Mon, 22 Jun 2020 09:26:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 188.184.36.50)
 smtp.mailfrom=cern.ch; kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=bestguesspass action=none
 header.from=cern.ch;
Received-SPF: Pass (protection.outlook.com: domain of cern.ch designates
 188.184.36.50 as permitted sender) receiver=protection.outlook.com;
 client-ip=188.184.36.50; helo=cernmxgwlb4.cern.ch;
Received: from cernmxgwlb4.cern.ch (188.184.36.50) by
 VE1EUR02FT032.mail.protection.outlook.com (10.152.12.129) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.3109.22 via Frontend Transport; Mon, 22 Jun 2020 09:26:10 +0000
Received: from cernfe01.cern.ch (188.184.36.42) by cernmxgwlb4.cern.ch
 (188.184.36.50) with Microsoft SMTP Server (TLS) id 14.3.487.0; Mon, 22 Jun
 2020 11:25:55 +0200
Received: from cwe-513-vol689.cern.ch (2001:1458:d00:7::100:1c8) by
 smtp.cern.ch (2001:1458:201:66::100:14) with Microsoft SMTP Server (TLS) id
 14.3.487.0; Mon, 22 Jun 2020 11:25:52 +0200
Date:   Mon, 22 Jun 2020 11:25:53 +0200
From:   Federico Vaga <federico.vaga@cern.ch>
To:     Vinod Koul <vkoul@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>
CC:     <dmaengine@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: DMA Engine: Transfer From Userspace
Message-ID: <20200622092553.pvspklv5suu6rm7w@cwe-513-vol689.cern.ch>
References: <5614531.lOV4Wx5bFT@harkonnen>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Content-Disposition: inline
In-Reply-To: <5614531.lOV4Wx5bFT@harkonnen>
X-Originating-IP: [2001:1458:d00:7::100:1c8]
X-EOPAttributedMessage: 0
X-Forefront-Antispam-Report: CIP:188.184.36.50;CTRY:CH;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:cernmxgwlb4.cern.ch;PTR:cernmx11.cern.ch;CAT:NONE;SFTY:;SFS:(396003)(346002)(376002)(39860400002)(136003)(46966005)(7636003)(1076003)(336012)(4744005)(316002)(2906002)(86362001)(478600001)(426003)(82310400002)(44832011)(110136005)(70586007)(54906003)(5660300002)(55016002)(70206006)(4326008)(16526019)(26005)(47076004)(8936002)(186003)(82740400003)(8676002)(7696005)(356005);DIR:OUT;SFP:1101;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2033e2bb-3712-4dca-585f-08d8168e4d47
X-MS-TrafficTypeDiagnostic: VI1PR06MB5856:
X-Microsoft-Antispam-PRVS: <VI1PR06MB5856203C0DAB801D259C87A3EF970@VI1PR06MB5856.eurprd06.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5797;
X-Forefront-PRVS: 0442E569BC
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1CMzFFy5P5WiGKpmklGIm2nlWU8GnjB6XjCkIbpPo7SPVTVO48f3HOboTtR5UH2HHJ1QWcNg8dfUdAoWqmuNVy3qJVzl3EVqfLQn+E0OvIF9/fEOJeHtBt7vFHdk/kyeQNrSdYwkGuSoG9K1EBvOeHNOK4q5RjexH+DoeMHfyaN1UVFF2NaEF712yMPzWvGQUoewqozpxDfjJZlYQblfzxyIdOI3O9WVZ9DGV1LstEcPu3nYPrODokdIVa7YRmAPujUWw0Rx2v/c8jNW6YrFNQ8mDy0kIeZXgmfoaC0Evl5Hm6t0nKKtrm9GqE/7Ef+PYuYCDYnTT4pnR8Rnw8HZ9Vk1YaMr+rD5Zqdg2C4/jK2KLejZyAf2zMrS4X0V3p5Y/yjitrleDbtgtd5ttdCzpA==
X-OriginatorOrg: cern.ch
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jun 2020 09:26:10.8084
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2033e2bb-3712-4dca-585f-08d8168e4d47
X-MS-Exchange-CrossTenant-Id: c80d3499-4a40-4a8c-986e-abce017d6b19
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=c80d3499-4a40-4a8c-986e-abce017d6b19;Ip=[188.184.36.50];Helo=[cernmxgwlb4.cern.ch]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR06MB5856
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Sat, Jun 20, 2020 at 12:47:16AM +0200, Federico Vaga wrote:
>Hello,
>
>is there the possibility of using a DMA engine channel from userspace?
>
>Something like:
>- configure DMA using ioctl() (or whatever configuration mechanism)
>- read() or write() to trigger the transfer

Let me add one more question related to my case. The dmatest module does not
perform tests on SLAVEs. why?

Thanks

>
>-- 
>Federico Vaga [CERN BE-CO-HT]
>
>
