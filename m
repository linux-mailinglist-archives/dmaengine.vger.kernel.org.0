Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A8C7E202FFD
	for <lists+dmaengine@lfdr.de>; Mon, 22 Jun 2020 08:57:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726829AbgFVG5e (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 22 Jun 2020 02:57:34 -0400
Received: from mail-eopbgr40060.outbound.protection.outlook.com ([40.107.4.60]:43009
        "EHLO EUR03-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725933AbgFVG5e (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Mon, 22 Jun 2020 02:57:34 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oVtVANfUGUM1DXekbnILFGjFPvQRAevc53ZM9+oPjZP+j8oHIa28Exdrp5Rmw67dTtGO5CQW0WKBvHAswa5KMHXDNoU0OjpxlMuNL94edpCviA1bcH61Rzkt6dVnzRDGOwBUS0zYdFE0ocGKZcy+gZIfi0UIx9i3pUvE3nwn/mjyO9KOqPH/vC0t1s0gkdBYcnIhK9QtLihSVqK2rQhsk54F7qEOPeFtxScmyK33iKXtGG4L06jZD4l3t3Gop9QSYzHzBmmr6BB/9X7icbx68Si26FIWzszLnrJLnNP3HFEEs8ZpQmJuXvh2EbEfjCncXeGeJVGAEcgNOr/BML4JBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8o8WnYrRJ0FRx/PYGL6CjeX+EfrSOVGiBzSpmXKg0dM=;
 b=aY3RxWjmSjt4tO3GGdFdXtDNDit73Q5gFoqhazioFcWlLtEW2/6/DnFsMi6fkxKr1ecJ7q+n3jkZPGy+yfJeFs51Ra3K2/YrPQUoLm/zfNOWLROFn7+wTMA9M5ZvyKVWTWAD6B0TgQAXa2o42y1ODpNompFmDTWLA+XITkERC26M+FuaPnVgh1UzKGMa4ymB3ChYXSeGVSkcwhON8HzeX9dmAcdF0gaRUUNWUdg2jwI4vyegXh6gn7LxnV48gB8FvEO4ElikcIvn8+dfzrcTWYRPCY0+y/OqIE6h11+d+DPNqdy9YVF+GIRfcYeCG209GHod//SzWEHU+PmQJos5sg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 188.184.36.50) smtp.rcpttodomain=kernel.org smtp.mailfrom=cern.ch;
 dmarc=bestguesspass action=none header.from=cern.ch; dkim=none (message not
 signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cern.onmicrosoft.com;
 s=selector2-cern-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8o8WnYrRJ0FRx/PYGL6CjeX+EfrSOVGiBzSpmXKg0dM=;
 b=pSo3jmYTv7wSlTLYLTVo0zqm6XK1JkSilKbXjjRCKQNexXlDnu0Fx3xgEKwUjorX8Wxjad12V+GTU0krYldwQ6F41dYAJhjZ8fcCtuW1bvbrzbMz7VYQtuSTXamiIE8X7lT1kOzR2/T63cZjNzXIgxGh8ssFLJWo38fklBjE488=
Received: from AM5PR1001CA0003.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:206:2::16)
 by HE1PR0601MB2075.eurprd06.prod.outlook.com (2603:10a6:3:2b::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3109.23; Mon, 22 Jun
 2020 06:57:30 +0000
Received: from HE1EUR02FT048.eop-EUR02.prod.protection.outlook.com
 (2603:10a6:206:2:cafe::d6) by AM5PR1001CA0003.outlook.office365.com
 (2603:10a6:206:2::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3109.21 via Frontend
 Transport; Mon, 22 Jun 2020 06:57:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 188.184.36.50)
 smtp.mailfrom=cern.ch; kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=bestguesspass action=none
 header.from=cern.ch;
Received-SPF: Pass (protection.outlook.com: domain of cern.ch designates
 188.184.36.50 as permitted sender) receiver=protection.outlook.com;
 client-ip=188.184.36.50; helo=cernmxgwlb4.cern.ch;
Received: from cernmxgwlb4.cern.ch (188.184.36.50) by
 HE1EUR02FT048.mail.protection.outlook.com (10.152.10.243) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.3109.22 via Frontend Transport; Mon, 22 Jun 2020 06:57:29 +0000
Received: from cernfe01.cern.ch (188.184.36.42) by cernmxgwlb4.cern.ch
 (188.184.36.50) with Microsoft SMTP Server (TLS) id 14.3.487.0; Mon, 22 Jun
 2020 08:57:30 +0200
Received: from cwe-513-vol689.cern.ch (2001:1458:d00:7::100:1c8) by
 smtp.cern.ch (2001:1458:201:66::100:14) with Microsoft SMTP Server (TLS) id
 14.3.487.0; Mon, 22 Jun 2020 08:57:27 +0200
Date:   Mon, 22 Jun 2020 08:57:27 +0200
From:   Federico Vaga <federico.vaga@cern.ch>
To:     Vinod Koul <vkoul@kernel.org>
CC:     Dave Jiang <dave.jiang@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        <dmaengine@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: DMA Engine: Transfer From Userspace
Message-ID: <20200622065727.ywbnevdhjs7kizfc@cwe-513-vol689.cern.ch>
References: <5614531.lOV4Wx5bFT@harkonnen>
 <fe199e18-be45-cadc-8bad-4a83ed87bfba@intel.com>
 <20200621072457.GA2324254@vkoul-mobl>
 <20200621203634.y3tejmh6j4knf5iz@cwe-513-vol689.cern.ch>
 <20200622044733.GB2324254@vkoul-mobl>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Content-Disposition: inline
In-Reply-To: <20200622044733.GB2324254@vkoul-mobl>
X-Originating-IP: [2001:1458:d00:7::100:1c8]
X-EOPAttributedMessage: 0
X-Forefront-Antispam-Report: CIP:188.184.36.50;CTRY:CH;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:cernmxgwlb4.cern.ch;PTR:cernmx11.cern.ch;CAT:NONE;SFTY:;SFS:(396003)(376002)(136003)(346002)(39860400002)(46966005)(53546011)(316002)(82310400002)(54906003)(83380400001)(426003)(336012)(478600001)(6916009)(44832011)(7636003)(82740400003)(356005)(47076004)(8936002)(70206006)(16526019)(186003)(26005)(86362001)(5660300002)(8676002)(4326008)(1076003)(70586007)(7696005)(2906002)(55016002);DIR:OUT;SFP:1101;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: dbaf38d3-bf89-4b4f-a0f9-08d8167987fa
X-MS-TrafficTypeDiagnostic: HE1PR0601MB2075:
X-Microsoft-Antispam-PRVS: <HE1PR0601MB2075E8A562563C43FA699E5BEF970@HE1PR0601MB2075.eurprd06.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-Forefront-PRVS: 0442E569BC
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1QqERMWt1hd2PzJRjiJSUOeJ9W0zzH6c+tyUowPBy+esUOZjsaB30nWiUdx04R80ADg/cjXAv9eroc+ble15kFVIuXWYlBeTa2PujtmJHhjSH5dRuoyFVuKyadHq/+in/I6A4GPJfLHDPqY/+GZ8bSK+OxgAAORRexJLRbrUxQgNatRMyqKW2+pflkxbSuI+VigXN3fAHBOcy3ONZZ7xmlQiq3Q8Ne7g8ZplYbHywZ2TFGtvZ+Yatg2CFMm5ckMkDMzh2f2mC8/FzMtDf7GZX+qmJIyqPmg+sirXuXIFVA2cA7EqHyIA9O6gmLSBLQEwi2zKPK65672OvAv8QqxW3PViSPYCEPTVNKERKYzf6+kU65GM75GU7Sxljv+YOhp/ycnW9kzNkQCdUdc/em3s9g==
X-OriginatorOrg: cern.ch
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jun 2020 06:57:29.8359
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: dbaf38d3-bf89-4b4f-a0f9-08d8167987fa
X-MS-Exchange-CrossTenant-Id: c80d3499-4a40-4a8c-986e-abce017d6b19
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=c80d3499-4a40-4a8c-986e-abce017d6b19;Ip=[188.184.36.50];Helo=[cernmxgwlb4.cern.ch]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0601MB2075
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Mon, Jun 22, 2020 at 10:17:33AM +0530, Vinod Koul wrote:
>On 21-06-20, 22:36, Federico Vaga wrote:
>> On Sun, Jun 21, 2020 at 12:54:57PM +0530, Vinod Koul wrote:
>> > On 19-06-20, 16:31, Dave Jiang wrote:
>> > >
>> > >
>> > > On 6/19/2020 3:47 PM, Federico Vaga wrote:
>> > > > Hello,
>> > > >
>> > > > is there the possibility of using a DMA engine channel from userspace?
>> > > >
>> > > > Something like:
>> > > > - configure DMA using ioctl() (or whatever configuration mechanism)
>> > > > - read() or write() to trigger the transfer
>> > > >
>> > >
>> > > I may have supposedly promised Vinod to look into possibly providing
>> > > something like this in the future. But I have not gotten around to do that
>> > > yet. Currently, no such support.
>> >
>> > And I do still have serious reservations about this topic :) Opening up
>> > userspace access to DMA does not sound very great from security point of
>> > view.
>>
>> I was thinking about a dedicated module, and not something that the DMA engine
>> offers directly. You load the module only if you need it (like the test module)
>
>But loading that module would expose dma to userspace.

Of course, but users *should* know what they are doing ... right? ^_^'

>>
>> > Federico, what use case do you have in mind?
>>
>> Userspace drivers
>
>more the reason not do do so, why cant a kernel driver be added for your
>usage?

Yes of course, I was just wandering if there was a kernel API.

>-- 
>~Vinod
