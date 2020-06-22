Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1C4342036C4
	for <lists+dmaengine@lfdr.de>; Mon, 22 Jun 2020 14:30:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728096AbgFVMa2 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 22 Jun 2020 08:30:28 -0400
Received: from mail-db8eur05on2071.outbound.protection.outlook.com ([40.107.20.71]:6059
        "EHLO EUR05-DB8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728080AbgFVMa1 (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Mon, 22 Jun 2020 08:30:27 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YHaJ/OaPvU71lBW9cgrAokY21m0fViFqXsBKtPPAian3k4VKgTzPDocUlkszUPv2PGv3SBW6lyI95GWcDFGESJct6JDacqjCwr4+RriVyCShLBtLedvGK8YevlNgfm6xao+5MbFXyby0o7miaxCNHlyUWeMnZtxr89VT8xFizA5Mu/qe5xUqQbWWpOzaPUomVkOQK30PnamRqfsISDwMlHYAq5REGn/HGBEGcmZ5rOXNRvNbGpuR6Su5qhsB86qhkDOmu7kup+ByYv7f0qjPQ870H1hiHipl84vMZNQY5Yy3ez935bSseDII/AWkNKbBaMI8OmhFUyMEmGAX6gQ2Qg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+mrNxag+aM6d+H+SmeGYQ2I40p+ijE+pmDL2G+y9KIk=;
 b=jqmuvDKwXqgzeXk/fTJt0UQ6sebjaJ1kS2waoMo0mgnj95J5pvQa/o1nxtFQlg3Nee6X1JpKV4K3rZUjRlSkBSUsnr+fbDVaBJs3wpZj6XZkyIhnVV3A4mqk27iX6B5UsXS3eHa4ow+f/xy/6yVKELx1GspgSyQefL+iZQ8ux+5XwBzzpi0yjOpAjDjS6pYNfzVdhhwmzdg8WxaigXxgUz3leqwNzVeARVgQXPKvbwOke+hO6vknBJcL1uyf10QzoaM0no+avc9BNmPzDfFbK/R1SzrvCbDwEOLX0eW/1mc7BMg1tRQKPoTAw/Fp32M7/e7Y+i8KBtKCiJVnA8xONA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 188.184.36.46) smtp.rcpttodomain=rufusul.de smtp.mailfrom=cern.ch;
 dmarc=bestguesspass action=none header.from=cern.ch; dkim=none (message not
 signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cern.onmicrosoft.com;
 s=selector2-cern-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+mrNxag+aM6d+H+SmeGYQ2I40p+ijE+pmDL2G+y9KIk=;
 b=rRD4t4kZT/SYOhjAHXE1us2slTschgisHZRPUjJ401GGmH31PFZkgO5MJ9WNiQPcSskZD0wA8bEfxPjA/bZ4kek9NEEQvdlmuFGMrTJ8CqS3oYScXJjNUgJXQ/IM+xr5rsE53RJm/Rs2MZYX6rMlYZboGmTHncD8Q7F2fden2v8=
Received: from AM3PR07CA0065.eurprd07.prod.outlook.com (2603:10a6:207:4::23)
 by VI1PR0601MB2189.eurprd06.prod.outlook.com (2603:10a6:800:2e::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3109.22; Mon, 22 Jun
 2020 12:30:22 +0000
Received: from HE1EUR02FT056.eop-EUR02.prod.protection.outlook.com
 (2603:10a6:207:4:cafe::be) by AM3PR07CA0065.outlook.office365.com
 (2603:10a6:207:4::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3131.10 via Frontend
 Transport; Mon, 22 Jun 2020 12:30:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 188.184.36.46)
 smtp.mailfrom=cern.ch; rufusul.de; dkim=none (message not signed)
 header.d=none;rufusul.de; dmarc=bestguesspass action=none
 header.from=cern.ch;
Received-SPF: Pass (protection.outlook.com: domain of cern.ch designates
 188.184.36.46 as permitted sender) receiver=protection.outlook.com;
 client-ip=188.184.36.46; helo=cernmxgwlb4.cern.ch;
Received: from cernmxgwlb4.cern.ch (188.184.36.46) by
 HE1EUR02FT056.mail.protection.outlook.com (10.152.11.21) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.3109.22 via Frontend Transport; Mon, 22 Jun 2020 12:30:22 +0000
Received: from cernfe01.cern.ch (188.184.36.42) by cernmxgwlb4.cern.ch
 (188.184.36.46) with Microsoft SMTP Server (TLS) id 14.3.487.0; Mon, 22 Jun
 2020 14:30:21 +0200
Received: from cwe-513-vol689.cern.ch (2001:1458:d00:7::100:1c8) by
 smtp.cern.ch (2001:1458:201:66::100:14) with Microsoft SMTP Server (TLS) id
 14.3.487.0; Mon, 22 Jun 2020 14:30:20 +0200
Date:   Mon, 22 Jun 2020 14:30:19 +0200
From:   Federico Vaga <federico.vaga@cern.ch>
To:     Thomas Ruf <freelancer@rufusul.de>
CC:     Vinod Koul <vkoul@kernel.org>, Dave Jiang <dave.jiang@intel.com>,
        "Dan Williams" <dan.j.williams@intel.com>,
        <dmaengine@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: DMA Engine: Transfer From Userspace
Message-ID: <20200622123019.z3i2tjcfliwkbzkx@cwe-513-vol689.cern.ch>
References: <5614531.lOV4Wx5bFT@harkonnen>
 <fe199e18-be45-cadc-8bad-4a83ed87bfba@intel.com>
 <20200621072457.GA2324254@vkoul-mobl>
 <20200621203634.y3tejmh6j4knf5iz@cwe-513-vol689.cern.ch>
 <20200622044733.GB2324254@vkoul-mobl>
 <419762761.402939.1592827272368@mailbusiness.ionos.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Content-Disposition: inline
In-Reply-To: <419762761.402939.1592827272368@mailbusiness.ionos.de>
X-Originating-IP: [2001:1458:d00:7::100:1c8]
X-EOPAttributedMessage: 0
X-Forefront-Antispam-Report: CIP:188.184.36.46;CTRY:CH;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:cernmxgwlb4.cern.ch;PTR:cernmx13.cern.ch;CAT:NONE;SFTY:;SFS:(39860400002)(136003)(376002)(396003)(346002)(46966005)(356005)(2906002)(82310400002)(7636003)(478600001)(316002)(336012)(426003)(82740400003)(4326008)(16526019)(26005)(186003)(47076004)(44832011)(1076003)(55016002)(5660300002)(8936002)(8676002)(83380400001)(70206006)(86362001)(70586007)(53546011)(6916009)(7696005)(54906003);DIR:OUT;SFP:1101;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: fb9a5a5a-fc29-43bf-83f2-08d816a80861
X-MS-TrafficTypeDiagnostic: VI1PR0601MB2189:
X-Microsoft-Antispam-PRVS: <VI1PR0601MB2189FD7442914252A2289F84EF970@VI1PR0601MB2189.eurprd06.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-Forefront-PRVS: 0442E569BC
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ZozLUaX25dkac3wfXg7TkO204JpvfSNe1zVbM3HWbEpdBakodAL7y+8rzz8AYmj8+g8EFCByzM6QnypGxsQr4B0Tt78WItYmz56XZ3SN1sasLkeJjZd62F7CcMd+rynbBDpUYsagbPJ+0LMU3iRUjCsAnTdBOht9KVa8dnr0qUl6TVabXFHjJ07F5kkDJYb+UOdan2WbxHFMK8jWmAdvnSRNuy1xnfX4K+cRAVfwwGBafEe2y2W8yNYKf5j70MhpNvkBHR2CUsti5V8j3GjBKvoUNnbfdanuEedbkBle5SmGgM+CK3Da8bx2MBKhVxSbk7v2KUB6DnHgke1XZrxzz73cv7bY8z6IcHY7OCbqZcHcawtXIAwkJ3yxufo9Tig9GoSghx5TqC/EM2X2VZ9IYA==
X-OriginatorOrg: cern.ch
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jun 2020 12:30:22.1041
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fb9a5a5a-fc29-43bf-83f2-08d816a80861
X-MS-Exchange-CrossTenant-Id: c80d3499-4a40-4a8c-986e-abce017d6b19
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=c80d3499-4a40-4a8c-986e-abce017d6b19;Ip=[188.184.36.46];Helo=[cernmxgwlb4.cern.ch]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0601MB2189
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Mon, Jun 22, 2020 at 02:01:12PM +0200, Thomas Ruf wrote:
>> On 22 June 2020 at 06:47 Vinod Koul <vkoul@kernel.org> wrote:
>>
>> On 21-06-20, 22:36, Federico Vaga wrote:
>> > On Sun, Jun 21, 2020 at 12:54:57PM +0530, Vinod Koul wrote:
>> > > On 19-06-20, 16:31, Dave Jiang wrote:
>> > > >
>> > > >
>> > > > On 6/19/2020 3:47 PM, Federico Vaga wrote:
>> > > > > Hello,
>> > > > >
>> > > > > is there the possibility of using a DMA engine channel from userspace?
>> > > > >
>> > > > > Something like:
>> > > > > - configure DMA using ioctl() (or whatever configuration mechanism)
>> > > > > - read() or write() to trigger the transfer
>> > > > >
>> > > >
>> > > > I may have supposedly promised Vinod to look into possibly providing
>> > > > something like this in the future. But I have not gotten around to do that
>> > > > yet. Currently, no such support.
>> > >
>> > > And I do still have serious reservations about this topic :) Opening up
>> > > userspace access to DMA does not sound very great from security point of
>> > > view.
>> >
>> > I was thinking about a dedicated module, and not something that the DMA engine
>> > offers directly. You load the module only if you need it (like the test module)
>>
>> But loading that module would expose dma to userspace.
>> >
>> > > Federico, what use case do you have in mind?
>> >
>> > Userspace drivers
>>
>> more the reason not do do so, why cant a kernel driver be added for your
>> usage?
>
>by chance i have written a driver allowing dma from user space using a memcpy like interface ;-)
>now i am trying to get this code upstream but was hit by the fact that DMA_SG is gone since Aug 2017 :-(

Not sure to get what you mean by "DMA_SG is gone". Can I have a reference?

>
>just let me introduce myself and the project:
>- coding in C since '91
>- coding in C++ since '98
>- a lot of stuff not relevant for this ;-)
>- working as a freelancer since Nov '19
>- implemented a "dma-sg-proxy" driver for my client in Mar/Apr '20 to copy camera frames from uncached memory to cached memory using a second dma on a Zynq platform
>- last week we figured out that we can not upgrade from "Xilinx 2019.2" (kernel 4.19.x) to "2020.1" (kernel 5.4.x) because the DMA_SG interface is gone
>- subscribed to dmaengine on friday, saw the start of this discussion on saturday
>- talked to my client today if it is ok to try to revive DMA_SG and get our driver upstream to avoid such problems in future
>
>here the struct for the ioctl:
>
>typedef struct {
>  unsigned int struct_size;
>  const void *src_user_ptr;
>  void *dst_user_ptr;
>  unsigned long length;
>  unsigned int timeout_in_ms;
>} dma_sg_proxy_arg_t;

Yes, roughly this is what I was thinking about

>best regards,
>Thomas
