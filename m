Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CF689202CBD
	for <lists+dmaengine@lfdr.de>; Sun, 21 Jun 2020 22:36:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730663AbgFUUgk (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Sun, 21 Jun 2020 16:36:40 -0400
Received: from mail-am6eur05on2068.outbound.protection.outlook.com ([40.107.22.68]:27309
        "EHLO EUR05-AM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730643AbgFUUgk (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Sun, 21 Jun 2020 16:36:40 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=l7PZmI3p8lx5jw6SbRBMZkmtzh5FTVxnWAA2JHwVjoCFXXalCsG3gAvTtglpifeRKGyXhNkqEIbztY7cSnULp4m11gmOHnDykiB3HNq3imi0QpUaWNhJQjz9apZ1PQqhmWHMmkjrAzY3ziTMTrsoUjrrJFYjUd2IHjxjjhcQcT3dgE2FOj9jn0X5PXGKNbm8HxBS5L9ode5ZngG4Z4blkA799TKWq4uahQZiFDxD/7CeoQknBZBbmWzXy0346d/8/0rpHuY0P1zSUM1bpK4wbm9M0jk+uEzLwQ1cMzvptdj7S6xUPwIjW+ijPnX1tp5ukJDcQDXwG1Kfu1oTNzO2mw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M31P/gQcyRw2TkJ3P49hVeRUT18TuA3wilj65awfFvM=;
 b=TwoCItMMz3NbU3wCE4lt9MakyvVTCon2uDvYe0/klFZY5J8WMlqTLhC3ehbNbcYtZh17zKZicZfRtnOeWFO5v+sXLjO1by2PFHgeU6JCkVBj/3A9b1EOiKgGf/aj10VhaVKxB8mmB3tCSVm8udiFk9L0a//OMzT94V6TNCfwxWts1bWemJSDNiR52vD3Z3124U6H/s13KU8EOcVKxh88RKHIVbIwF4Ur1siwLh13dEHR9UrON48F9A1PfyejhSCCGNoxgXX8MjjcfDgpj7ciGV+sH6I+aM/+qNoJT0LETabNiQIc3wvge37gxtoQulkW8JiJqZzFOPAsXDRfHo6eqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 188.184.36.46) smtp.rcpttodomain=kernel.org smtp.mailfrom=cern.ch;
 dmarc=bestguesspass action=none header.from=cern.ch; dkim=none (message not
 signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cern.onmicrosoft.com;
 s=selector2-cern-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M31P/gQcyRw2TkJ3P49hVeRUT18TuA3wilj65awfFvM=;
 b=bwOA0HD330jjPX1yBvU5deXrcpLqWANQshY0o8U5f7QctjcJrutJlczv9msUsuYUaMa10XFcxI50Qc6gcPvMEYOZy9Bd7FnMbijn/bN+kseddS713aJM/6iZ/S+Tm4tRgoWBih2cdzTjPWbSHxomxXLzTtsXzVT3dpCbPOb5GTg=
Received: from MR2P264CA0045.FRAP264.PROD.OUTLOOK.COM (2603:10a6:500::33) by
 DB6PR0601MB2455.eurprd06.prod.outlook.com (2603:10a6:4:20::21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3109.21; Sun, 21 Jun 2020 20:36:36 +0000
Received: from VE1EUR02FT061.eop-EUR02.prod.protection.outlook.com
 (2603:10a6:500:0:cafe::bc) by MR2P264CA0045.outlook.office365.com
 (2603:10a6:500::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3109.22 via Frontend
 Transport; Sun, 21 Jun 2020 20:36:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 188.184.36.46)
 smtp.mailfrom=cern.ch; kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=bestguesspass action=none
 header.from=cern.ch;
Received-SPF: Pass (protection.outlook.com: domain of cern.ch designates
 188.184.36.46 as permitted sender) receiver=protection.outlook.com;
 client-ip=188.184.36.46; helo=cernmxgwlb4.cern.ch;
Received: from cernmxgwlb4.cern.ch (188.184.36.46) by
 VE1EUR02FT061.mail.protection.outlook.com (10.152.13.238) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.3109.22 via Frontend Transport; Sun, 21 Jun 2020 20:36:36 +0000
Received: from cernfe01.cern.ch (188.184.36.42) by cernmxgwlb4.cern.ch
 (188.184.36.46) with Microsoft SMTP Server (TLS) id 14.3.487.0; Sun, 21 Jun
 2020 22:36:34 +0200
Received: from cwe-513-vol689.cern.ch (2001:1458:d00:7::100:1c8) by
 smtp.cern.ch (2001:1458:201:66::100:14) with Microsoft SMTP Server (TLS) id
 14.3.487.0; Sun, 21 Jun 2020 22:36:35 +0200
Date:   Sun, 21 Jun 2020 22:36:34 +0200
From:   Federico Vaga <federico.vaga@cern.ch>
To:     Vinod Koul <vkoul@kernel.org>
CC:     Dave Jiang <dave.jiang@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        <dmaengine@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: DMA Engine: Transfer From Userspace
Message-ID: <20200621203634.y3tejmh6j4knf5iz@cwe-513-vol689.cern.ch>
References: <5614531.lOV4Wx5bFT@harkonnen>
 <fe199e18-be45-cadc-8bad-4a83ed87bfba@intel.com>
 <20200621072457.GA2324254@vkoul-mobl>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Content-Disposition: inline
In-Reply-To: <20200621072457.GA2324254@vkoul-mobl>
X-Originating-IP: [2001:1458:d00:7::100:1c8]
X-EOPAttributedMessage: 0
X-Forefront-Antispam-Report: CIP:188.184.36.46;CTRY:CH;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:cernmxgwlb4.cern.ch;PTR:cernmx13.cern.ch;CAT:NONE;SFTY:;SFS:(376002)(136003)(396003)(346002)(39860400002)(46966005)(70586007)(426003)(316002)(54906003)(336012)(16526019)(186003)(8676002)(55016002)(44832011)(4326008)(7636003)(53546011)(83380400001)(7696005)(8936002)(82310400002)(70206006)(26005)(356005)(1076003)(2906002)(47076004)(86362001)(6916009)(82740400003)(5660300002)(478600001);DIR:OUT;SFP:1101;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2ea479c0-785e-4ff9-40d2-08d81622cb00
X-MS-TrafficTypeDiagnostic: DB6PR0601MB2455:
X-Microsoft-Antispam-PRVS: <DB6PR0601MB2455CD665770712A60018D36EF960@DB6PR0601MB2455.eurprd06.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-Forefront-PRVS: 04410E544A
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: AAQ3NURIVohlwMhHRACTL0tz5VasXtpkpaoZdIP3q5VXNtSrT09HIyevIJKYVMHi49oAM5Von+bDAUoT1PpqlCfvL5BNpM7OtUhK2UVSYrna05ajhdH8clz2Kc29ogfKs7kkGmrQLAvlq/5w4gnxDxrE7/ca9AKsdOCv7BiLcmKUVCtfvipQs/OL6108e+SKhUKXop8xgPJ4sP9TUksHNL9AYTDGs2Q8ixJqNthz3rPlmhPxong2AHcDab8LTzu1xH7xL0Kgfajyvd5b26xL/LfBa2dESRIHOwsSAty9TkOHwWjDz8VwNUooX0AjEtiUknixo+Ila2b2FEVcXU11kBZIB2aAUvjVUr/kgqkwxBMiGxiyAZwGRJ3c1EiCqzj516aghvMUtNfv45kQQmtz6g==
X-OriginatorOrg: cern.ch
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jun 2020 20:36:36.0807
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2ea479c0-785e-4ff9-40d2-08d81622cb00
X-MS-Exchange-CrossTenant-Id: c80d3499-4a40-4a8c-986e-abce017d6b19
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=c80d3499-4a40-4a8c-986e-abce017d6b19;Ip=[188.184.36.46];Helo=[cernmxgwlb4.cern.ch]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR0601MB2455
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Sun, Jun 21, 2020 at 12:54:57PM +0530, Vinod Koul wrote:
>On 19-06-20, 16:31, Dave Jiang wrote:
>>
>>
>> On 6/19/2020 3:47 PM, Federico Vaga wrote:
>> > Hello,
>> >
>> > is there the possibility of using a DMA engine channel from userspace?
>> >
>> > Something like:
>> > - configure DMA using ioctl() (or whatever configuration mechanism)
>> > - read() or write() to trigger the transfer
>> >
>>
>> I may have supposedly promised Vinod to look into possibly providing
>> something like this in the future. But I have not gotten around to do that
>> yet. Currently, no such support.
>
>And I do still have serious reservations about this topic :) Opening up
>userspace access to DMA does not sound very great from security point of
>view.

I was thinking about a dedicated module, and not something that the DMA engine
offers directly. You load the module only if you need it (like the test module)

>Federico, what use case do you have in mind?

Userspace drivers

>We should keep in mind dmaengine is an in-kernel interface providing
>services to various subsystems, so you go thru the respective subsystem
>kernel interface (network, display, spi, audio etc..) which would in
>turn use dmaengine.
>
>-- 
>~Vinod
