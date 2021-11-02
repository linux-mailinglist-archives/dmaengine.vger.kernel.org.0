Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ECB11442BB2
	for <lists+dmaengine@lfdr.de>; Tue,  2 Nov 2021 11:33:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229778AbhKBKgJ (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 2 Nov 2021 06:36:09 -0400
Received: from mail-bn8nam08on2089.outbound.protection.outlook.com ([40.107.100.89]:46656
        "EHLO NAM04-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229577AbhKBKgI (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Tue, 2 Nov 2021 06:36:08 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=US9YjvR2T0wt9WwEbGOstgMvY8JdJ7oTDizgM/j3fdJ1Zsb7Q9o5g4H99phvYKvH8+mkwDd5N/Gr/xdiss9XshvpJX3wdgN77K9jPkP/p7MgWF8WTfC/a5/0we0KnVaWQFisQi2IDJLnOuw34DUQ0OaGcXvFcFVc3WC6V6vgAj2qhtlroj+XzfcPHeYH0Q6loNQwEZNp43pxz46HQZlJGaOuZI24NeHV913dO4XPWAyq3F/TjCwENjJ040ALj8EnOlmi8dGvUeA6Sbju2EefYCJ/LzDbXPRN9nO6tllWm60nhS8DVnqyLjDzpz2X872EGZjFvjwVLOA+C94CCWGxsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EHrTPIxPxeKDXv/S3tN8o7YQklY7eIHYv4qMrIlZ0lc=;
 b=LNnto/fhxnKNk1PbSiynZwCkEPaycGpKwzknBkBxwFYgHoAC7Zr2ThqVb3RS/aYhAsHNXpaFGXJYwApD5s9zlUZSza4vF4f18MrNRz4ct0H3z8VCBt03gEPXXYEUWUfWKbz3TiwN60NiGdGUlspfsEXiFRj8LB3KKMrv5O3jvfZHAYhJGFY+1Lgt9NGSL504OncOEyzOXGZTK+oRsiO+Z1Hy8VmbhC/OAzhja3EYps9fXKTxUQmkJuUJmjYXOPDQ4h6AWHichrRIoc9TJnS4X4Ko4RozgnDy4BiJq35yN8YKKrL0LBulpgtCC9iRb9o3UYRC28iW0QHh1b4ZGzO5DA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.62.198) smtp.rcpttodomain=alumnos.upm.es smtp.mailfrom=xilinx.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=xilinx.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EHrTPIxPxeKDXv/S3tN8o7YQklY7eIHYv4qMrIlZ0lc=;
 b=lETSZVv9FPqdnC3SfMUzmxAwYQb4vx68tWxpULgUVAnNkCor4hApdnXwOvT8VY9y1gbzKFcQUUZBxi9HwEBvYownU1rXDB8ceWsPtKB6UO07ufwdkk/Wj0iCXmL7iLU9iULi8NH5rebD+cJTOBmz0zQfzMtKEQrboPaZB5NNszk=
Received: from DM6PR17CA0024.namprd17.prod.outlook.com (2603:10b6:5:1b3::37)
 by DM6PR02MB6986.namprd02.prod.outlook.com (2603:10b6:5:22e::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4649.17; Tue, 2 Nov
 2021 10:33:32 +0000
Received: from DM3NAM02FT045.eop-nam02.prod.protection.outlook.com
 (2603:10b6:5:1b3:cafe::80) by DM6PR17CA0024.outlook.office365.com
 (2603:10b6:5:1b3::37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4649.14 via Frontend
 Transport; Tue, 2 Nov 2021 10:33:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.62.198)
 smtp.mailfrom=xilinx.com; alumnos.upm.es; dkim=none (message not signed)
 header.d=none;alumnos.upm.es; dmarc=pass action=none header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.62.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.62.198; helo=xsj-pvapexch01.xlnx.xilinx.com;
Received: from xsj-pvapexch01.xlnx.xilinx.com (149.199.62.198) by
 DM3NAM02FT045.mail.protection.outlook.com (10.13.4.189) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4649.14 via Frontend Transport; Tue, 2 Nov 2021 10:33:31 +0000
Received: from xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) by
 xsj-pvapexch01.xlnx.xilinx.com (172.19.86.40) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14; Tue, 2 Nov 2021 03:33:30 -0700
Received: from smtp.xilinx.com (172.19.127.95) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server id
 15.1.2176.14 via Frontend Transport; Tue, 2 Nov 2021 03:33:30 -0700
Envelope-to: adrianml@alumnos.upm.es,
 vkoul@kernel.org,
 dmaengine@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
Received: from [10.254.241.49] (port=41354)
        by smtp.xilinx.com with esmtp (Exim 4.90)
        (envelope-from <michal.simek@xilinx.com>)
        id 1mhr6f-0008wr-TZ; Tue, 02 Nov 2021 03:33:30 -0700
Message-ID: <e43c32d3-6f08-5b48-7bf2-a2ef660c658c@xilinx.com>
Date:   Tue, 2 Nov 2021 11:33:28 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.1
Subject: Re: [PATCH 0/3] Add support for MEMCPY_SG transfers
Content-Language: en-US
To:     Adrian Larumbe <adrianml@alumnos.upm.es>, <vkoul@kernel.org>,
        <dmaengine@vger.kernel.org>,
        Radhey Shyam Pandey <radheys@xilinx.com>
CC:     <michal.simek@xilinx.com>, <linux-arm-kernel@lists.infradead.org>
References: <20210706234338.7696-1-adrian.martinezlarumbe@imgtec.com>
 <20211101180825.241048-1-adrianml@alumnos.upm.es>
From:   Michal Simek <michal.simek@xilinx.com>
In-Reply-To: <20211101180825.241048-1-adrianml@alumnos.upm.es>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 38ee3bb2-6945-461c-8e1c-08d99dec3767
X-MS-TrafficTypeDiagnostic: DM6PR02MB6986:
X-Microsoft-Antispam-PRVS: <DM6PR02MB6986F011707AB325EF818AF4C68B9@DM6PR02MB6986.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:565;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: HMgoyJSf3WHY53gIDuTNCQ/QwhcuL1gh/seUAvEHSXVHUV0i2rSn4xb3FVFQC8IzIdVkV4GQb2Oeenlnn2+GwEzvY0+/dsq9fGf8Qs5npYwxKA1/2pj+8/FypINx0dNOW7tW9vswXZFE4GdrexwiHb6zBurgN0yeyxnUtjF4ztWOT2+BqyduFZ+VTSl4rvaAwwo0Yui/iKX3ps64dlzfEDloFWQzOfHoEVoYc9A5omK4VC5TdoQeTj1SzFvHSiJYYLzwc0ohjtMbnEV/YQrpqRTe8w2Sx/BH9/nTrN/terVBYoT6V7yfBruVHEPGDfZfidgPmX696qnTI5W1pXLrHMbrHEdPIl3kB2dYrVJIAGEQfyi9OgeDaCArZnDFRr8VjyWEANWmxhilogEFYRvwlRemnBPGtbDUEFxnKvDlnKH5QPPHQOcg4165ONIryoFiZOjZ78gdWkqMlLZNV/NkRC1buH67GZigqzqQjhmRuI5rZQOibmEL4j7WOccXDALDJyKcEotiwCRp4mDI50rXsYQY0kmRIYkuTxvEWmqUxTaXSBz3NyMga8inqjjBJgXPs92p2Z2I5nC7BRmSrZlBnGxymHVCGRqJ3fGxIwpr0gZ8bMtakFR/bSMNpX34+ZsjiNJKFGG4fRTUFBE+Atb5mzCM30DmHbWmDvzmMf3HPz+KvMgGur0FuOpSNY1kuRhtrzqX9aRXxfFsm19weDjpN5zgef+pIauVeH2+1oY3QqIlvSayywRX/c9tAnx5c9DSAxZSjFUazJ4syIvaF3TkJvUHSoq5GdNaTTWmw267ESs+BuR1rCCsmWZ3CQ4YFLbnkrSSiDrQSTeRK6OwGEHN0b5VPy6cn+Pr9kcz6hH+pPY=
X-Forefront-Antispam-Report: CIP:149.199.62.198;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapexch01.xlnx.xilinx.com;PTR:unknown-62-198.xilinx.com;CAT:NONE;SFS:(36840700001)(46966006)(36756003)(53546011)(966005)(83380400001)(2616005)(82310400003)(2906002)(36906005)(70586007)(316002)(31696002)(356005)(7636003)(4744005)(54906003)(110136005)(6636002)(5660300002)(8676002)(186003)(426003)(336012)(44832011)(70206006)(47076005)(31686004)(9786002)(508600001)(36860700001)(4326008)(26005)(8936002)(50156003)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Nov 2021 10:33:31.6112
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 38ee3bb2-6945-461c-8e1c-08d99dec3767
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.62.198];Helo=[xsj-pvapexch01.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-AuthSource: DM3NAM02FT045.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR02MB6986
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

+Radhey,


On 11/1/21 19:08, Adrian Larumbe wrote:
> Bring back dmaengine API support for scatter-gather memcpy's.
> 
> Changes in patch v2:
>    * Expanded API function documentation to elaborate on its semantics,
>      limitations and corner case behaviour.
>    * Broke the patch series into three different ones: documentation, core
>      API change and consumer driver
> 
> v1 - https://lore.kernel.org/dmaengine/20210706234338.7696-1-adrian.martinezlarumbe@imgtec.com
> 
> Adrian Larumbe (3):
>    dmaengine: Add documentation for new memcpy scatter-gather function
>    dmaengine: Add core function and capability check for DMA_MEMCPY_SG
>    dmaengine: Add consumer for the new DMA_MEMCPY_SG API function.
> 
>   .../driver-api/dmaengine/provider.rst         |  23 ++++
>   drivers/dma/dmaengine.c                       |   7 +
>   drivers/dma/xilinx/xilinx_dma.c               | 122 ++++++++++++++++++
>   include/linux/dmaengine.h                     |  20 +++
>   4 files changed, 172 insertions(+)
> 
> 
> base-commit: e0674853943287669a82d1ffe09a700944615978
> 


