Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D94F97011D
	for <lists+dmaengine@lfdr.de>; Mon, 22 Jul 2019 15:34:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730047AbfGVNdL (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 22 Jul 2019 09:33:11 -0400
Received: from smtprelay-out1.synopsys.com ([198.182.61.142]:59106 "EHLO
        smtprelay-out1.synopsys.com" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728343AbfGVNdK (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 22 Jul 2019 09:33:10 -0400
Received: from mailhost.synopsys.com (dc8-mailhost1.synopsys.com [10.13.135.209])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 129F7C1D2B;
        Mon, 22 Jul 2019 13:33:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1563802389; bh=GyiIghw1ImCcnG2NT3Jt2fVOpLzrGh9QQUzKn6E6qko=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=lb0q+hf1H9pd/gbGDcbmlXBijDUY4bte3q17yO4VleHIa5FFtsLMFn4Z9q9clB9h1
         6p0El6hJWoW4u0VNQ4+VCzvEnO7DGh/Yil4tlm4Oa96c1/Af7v7kFNYcm55g0CrfMP
         vbaZVNRa+YXZBVb6TMy3DyBJbW7JLODLUb7sMl7t4M6DZcCfjSiJlxGzdZxZEf1lcM
         Llu1Wu7mWvmhccTOEfWemoDVYUq14DmXXUuj/268vGhWL/v7sJPK8gxUQWE1XVCPG1
         kR+AmFcyoOm7BPfZIcKHHErb7kqxX8H7CeFg/puC30dNSA477Pepm8Gx53NMMLTvas
         z8ECbMEuXGq1Q==
Received: from US01WEHTC2.internal.synopsys.com (us01wehtc2.internal.synopsys.com [10.12.239.237])
        (using TLSv1.2 with cipher AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        by mailhost.synopsys.com (Postfix) with ESMTPS id EAD20A023C;
        Mon, 22 Jul 2019 13:33:07 +0000 (UTC)
Received: from US01HYBRID2.internal.synopsys.com (10.15.246.24) by
 US01WEHTC2.internal.synopsys.com (10.12.239.237) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Mon, 22 Jul 2019 06:33:07 -0700
Received: from NAM04-SN1-obe.outbound.protection.outlook.com (10.13.134.195)
 by mrs.synopsys.com (10.15.246.24) with Microsoft SMTP Server (TLS) id
 14.3.408.0; Mon, 22 Jul 2019 06:33:07 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=U9kDfKpqSa07fqtf0kFBL4SpMspovxZZWng6x0Kn12hUkVEWf8Irv35RUbIh3C0YgnSkhlDjCIFb15AfuKJnzCghMeVuLm/7Nd2B+Zzmbi/mVMglqeGTeGieFdquunFqYwJcdzFgExZlx7CKIwf/WehbYMyYlp8q8q8IFcS4ftgJbzFhj+DBT3DMp6ICkJk9CjSipo9loCNRBorLGJ7fPAPl+j5KcP6plcrCu5Dpov3V8No8lj3l3rgiYkTE2WvmgFm61UAE/MUhgP15Fy0O6J4zJmBDPrwrZnwDKeMFPdNm7g21NWbpaC2DCH3nilWy/B105xuXMWK6ApErk8f6nQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bMTKoyvF6m10AbnI5tzVYW5as07qHK9MxoJ0uhwT7bw=;
 b=fqQTLeB7NmFX5uIcCba0VX+aKOf5lPtzhZspzWjeaUIuFWhZ74ucsH0G2y3a7wXFcnXSzRyyUml+jpBLR9TbOv/DkzPTaUrSDVvXi4PvBqt+YttjFsU1Khcg4THBqneSyysYkL5YTjma/pQb7OeXufYb5GVVIcC2uyIIPECA45uSLrkmIIzQGWUybqYf0JqGixPGSpG+80KwueYKX7zA86aldCyyfCoCtKDtqqIvWjbCss80c5N56qcayjtqLYigVT/M/VvvuKuusb8Icg2sm9sajMHt5057beMwvZhjIhdO9wej/Ee2opoZF1irGkIntZ9ztX4GAJeIb0V0orXy+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1;spf=pass
 smtp.mailfrom=synopsys.com;dmarc=pass action=none
 header.from=synopsys.com;dkim=pass header.d=synopsys.com;arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=synopsys.onmicrosoft.com; s=selector1-synopsys-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bMTKoyvF6m10AbnI5tzVYW5as07qHK9MxoJ0uhwT7bw=;
 b=Z/2jrmzIE+gnsWah3ze/qd8sSllJsB975WJSdJjLdqKIa/SMPFre1CPRVFIUqh0coPgBP5BOI1kCVoNX+yhsvxwubMnyPp62QQspJWLjK+RFr1aHiQlFwJZwuSz/NnTrHr9NcrZzabfrTXgeFweP+NXaXzdZNP4eQivVhnk2VvA=
Received: from DM6PR12MB4010.namprd12.prod.outlook.com (10.255.175.83) by
 DM6PR12MB2666.namprd12.prod.outlook.com (20.176.116.27) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2094.16; Mon, 22 Jul 2019 13:33:05 +0000
Received: from DM6PR12MB4010.namprd12.prod.outlook.com
 ([fe80::1508:71eb:20f6:b4e6]) by DM6PR12MB4010.namprd12.prod.outlook.com
 ([fe80::1508:71eb:20f6:b4e6%6]) with mapi id 15.20.2094.013; Mon, 22 Jul 2019
 13:33:05 +0000
From:   Gustavo Pimentel <Gustavo.Pimentel@synopsys.com>
To:     Arnd Bergmann <arnd@arndb.de>,
        Gustavo Pimentel <Gustavo.Pimentel@synopsys.com>,
        Vinod Koul <vkoul@kernel.org>
CC:     Dan Williams <dan.j.williams@intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Russell King <rmk+kernel@armlinux.org.uk>,
        Joao Pinto <Joao.Pinto@synopsys.com>,
        "dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 1/3] [v2] dmaengine: dw-edma: fix unnecessary stack usage
Thread-Topic: [PATCH 1/3] [v2] dmaengine: dw-edma: fix unnecessary stack usage
Thread-Index: AQHVQItq2Fyi7Wm2WUKRvn5haPwUB6bWotVw
Date:   Mon, 22 Jul 2019 13:33:05 +0000
Message-ID: <DM6PR12MB4010F8ADBA3F9E92E8762279DAC40@DM6PR12MB4010.namprd12.prod.outlook.com>
References: <20190722124457.1093886-1-arnd@arndb.de>
In-Reply-To: <20190722124457.1093886-1-arnd@arndb.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: =?us-ascii?Q?PG1ldGE+PGF0IG5tPSJib2R5LnR4dCIgcD0iYzpcdXNlcnNcZ3VzdGF2b1xh?=
 =?us-ascii?Q?cHBkYXRhXHJvYW1pbmdcMDlkODQ5YjYtMzJkMy00YTQwLTg1ZWUtNmI4NGJh?=
 =?us-ascii?Q?MjllMzViXG1zZ3NcbXNnLTNhNWJiZWZiLWFjODUtMTFlOS05ODhjLWY4OTRj?=
 =?us-ascii?Q?MjczODA0MlxhbWUtdGVzdFwzYTViYmVmZC1hYzg1LTExZTktOTg4Yy1mODk0?=
 =?us-ascii?Q?YzI3MzgwNDJib2R5LnR4dCIgc3o9IjEzNTAiIHQ9IjEzMjA4Mjc1OTgzMTM2?=
 =?us-ascii?Q?OTEzOSIgaD0ibjVRTEptUlRhZFBNWVhoa3hPUldZTWlNSzRrPSIgaWQ9IiIg?=
 =?us-ascii?Q?Ymw9IjAiIGJvPSIxIiBjaT0iY0FBQUFFUkhVMVJTUlVGTkNnVUFBQlFKQUFD?=
 =?us-ascii?Q?enRiUDhrVURWQWQrbXloVXN5TnpSMzZiS0ZTekkzTkVPQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUhBQUFBQ2tDQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUVBQVFBQkFBQUFGdGJCcHdBQUFBQUFBQUFBQUFBQUFKNEFBQUJtQUdrQWJn?=
 =?us-ascii?Q?QmhBRzRBWXdCbEFGOEFjQUJzQUdFQWJnQnVBR2tBYmdCbkFGOEFkd0JoQUhR?=
 =?us-ascii?Q?QVpRQnlBRzBBWVFCeUFHc0FBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?RUFBQUFBQUFBQUFnQUFBQUFBbmdBQUFHWUFid0IxQUc0QVpBQnlBSGtBWHdC?=
 =?us-ascii?Q?d0FHRUFjZ0IwQUc0QVpRQnlBSE1BWHdCbkFHWUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQVFBQUFBQUFBQUFDQUFB?=
 =?us-ascii?Q?QUFBQ2VBQUFBWmdCdkFIVUFiZ0JrQUhJQWVRQmZBSEFBWVFCeUFIUUFiZ0Js?=
 =?us-ascii?Q?QUhJQWN3QmZBSE1BWVFCdEFITUFkUUJ1QUdjQVh3QmpBRzhBYmdCbUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUJBQUFBQUFBQUFBSUFBQUFBQUo0QUFBQm1BRzhB?=
 =?us-ascii?Q?ZFFCdUFHUUFjZ0I1QUY4QWNBQmhBSElBZEFCdUFHVUFjZ0J6QUY4QWN3QmhB?=
 =?us-ascii?Q?RzBBY3dCMUFHNEFad0JmQUhJQVpRQnpBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFFQUFBQUFBQUFBQWdBQUFBQUFuZ0FBQUdZQWJ3QjFBRzRBWkFCeUFIa0FY?=
 =?us-ascii?Q?d0J3QUdFQWNnQjBBRzRBWlFCeUFITUFYd0J6QUcwQWFRQmpBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBUUFBQUFBQUFBQUNB?=
 =?us-ascii?Q?QUFBQUFDZUFBQUFaZ0J2QUhVQWJnQmtBSElBZVFCZkFIQUFZUUJ5QUhRQWJn?=
 =?us-ascii?Q?QmxBSElBY3dCZkFITUFkQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQkFBQUFBQUFBQUFJQUFBQUFBSjRBQUFCbUFH?=
 =?us-ascii?Q?OEFkUUJ1QUdRQWNnQjVBRjhBY0FCaEFISUFkQUJ1QUdVQWNnQnpBRjhBZEFC?=
 =?us-ascii?Q?ekFHMEFZd0FBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUVBQUFBQUFBQUFBZ0FBQUFBQW5nQUFBR1lBYndCMUFHNEFaQUJ5QUhr?=
 =?us-ascii?Q?QVh3QndBR0VBY2dCMEFHNEFaUUJ5QUhNQVh3QjFBRzBBWXdBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFRQUFBQUFBQUFB?=
 =?us-ascii?Q?Q0FBQUFBQUNlQUFBQVp3QjBBSE1BWHdCd0FISUFid0JrQUhVQVl3QjBBRjhB?=
 =?us-ascii?Q?ZEFCeUFHRUFhUUJ1QUdrQWJnQm5BQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFCQUFBQUFBQUFBQUlBQUFBQUFKNEFBQUJ6?=
 =?us-ascii?Q?QUdFQWJBQmxBSE1BWHdCaEFHTUFZd0J2QUhVQWJnQjBBRjhBY0FCc0FHRUFi?=
 =?us-ascii?Q?Z0FBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBRUFBQUFBQUFBQUFnQUFBQUFBbmdBQUFITUFZUUJzQUdVQWN3QmZB?=
 =?us-ascii?Q?SEVBZFFCdkFIUUFaUUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQVFBQUFBQUFB?=
 =?us-ascii?Q?QUFDQUFBQUFBQ2VBQUFBY3dCdUFIQUFjd0JmQUd3QWFRQmpBR1VBYmdCekFH?=
 =?us-ascii?Q?VUFYd0IwQUdVQWNnQnRBRjhBTVFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUJBQUFBQUFBQUFBSUFBQUFBQUo0QUFB?=
 =?us-ascii?Q?QnpBRzRBY0FCekFGOEFiQUJwQUdNQVpRQnVBSE1BWlFCZkFIUUFaUUJ5QUcw?=
 =?us-ascii?Q?QVh3QnpBSFFBZFFCa0FHVUFiZ0IwQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFFQUFBQUFBQUFBQWdBQUFBQUFuZ0FBQUhZQVp3QmZBR3NBWlFC?=
 =?us-ascii?Q?NUFIY0Fid0J5QUdRQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBUUFBQUFB?=
 =?us-ascii?Q?QUFBQUNBQUFBQUFBPSIvPjwvbWV0YT4=3D?=
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=gustavo@synopsys.com; 
x-originating-ip: [83.174.63.141]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 6a0e578e-03d6-4f8b-8a26-08d70ea92080
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:DM6PR12MB2666;
x-ms-traffictypediagnostic: DM6PR12MB2666:
x-microsoft-antispam-prvs: <DM6PR12MB266617026C0464337597A667DAC40@DM6PR12MB2666.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6790;
x-forefront-prvs: 01068D0A20
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(136003)(376002)(396003)(366004)(346002)(39860400002)(189003)(199004)(76176011)(66066001)(4326008)(3846002)(7696005)(5660300002)(14454004)(6436002)(6116002)(25786009)(52536014)(316002)(33656002)(81156014)(81166006)(8936002)(53936002)(76116006)(6246003)(7736002)(305945005)(66446008)(74316002)(446003)(66476007)(66556008)(64756008)(55016002)(9686003)(66946007)(476003)(11346002)(71200400001)(71190400001)(86362001)(6506007)(102836004)(53546011)(229853002)(26005)(486006)(186003)(99286004)(110136005)(8676002)(54906003)(2906002)(256004)(14444005)(68736007)(478600001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM6PR12MB2666;H:DM6PR12MB4010.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: synopsys.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 48MVfPfml+/+C3Ar6N97LckrOZ09ZtO/4A80a2cPqk5GS6m+LX4yu6m3m57XgsB+lMzEQTeV9K/yNN2tpe5p9Xh0XG8+TRsb6jPSs6tMK5KzMZ0iFrSJf1ZETb0N/1tCF6cnkneq8rupzzFOyF77Kj2RbH16PoAVHXWRpQTsWJSbw1uN5Xmr2b9s9WqslW1JOv7IEw4qW9KWA8U2Trx0+x/rn3XZiA3lvhuA2VQiu9VCuN6kOeSghPLHObWw6Goo/CrHQ2jhyQVmEZF4cEPDZp5R3rDTMiCPnCIZxTuOm6pZ3SYfNYmuE4675LumAgejKxUL2k/n8Pik/XwkHcCCFIy6NnHZ06rwHpjzXgYvJOc4miy6rWyItIIIapB15mbb8BtVKoNBSth1lpo6k3J8aDRxFZDVUdmeeqrGwZsJAaQ=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 6a0e578e-03d6-4f8b-8a26-08d70ea92080
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Jul 2019 13:33:05.2621
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: gustavo@synopsys.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB2666
X-OriginatorOrg: synopsys.com
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Mon, Jul 22, 2019 at 13:44:43, Arnd Bergmann <arnd@arndb.de> wrote:

> Putting large constant data on the stack causes unnecessary overhead
> and stack usage:
>=20
> drivers/dma/dw-edma/dw-edma-v0-debugfs.c:285:6: error: stack frame size o=
f 1376 bytes in function 'dw_edma_v0_debugfs_on' [-Werror,-Wframe-larger-th=
an=3D]
>=20
> Mark the variable 'static const' in order for the compiler to move it
> into the .rodata section where it does no such harm.
>=20
> Fixes: 305aebeff879 ("dmaengine: Add Synopsys eDMA IP version 0 debugfs s=
upport")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
> v2: unchanged
> ---
>  drivers/dma/dw-edma/dw-edma-v0-debugfs.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/dma/dw-edma/dw-edma-v0-debugfs.c b/drivers/dma/dw-ed=
ma/dw-edma-v0-debugfs.c
> index 3226f528cc11..5728b6fe938c 100644
> --- a/drivers/dma/dw-edma/dw-edma-v0-debugfs.c
> +++ b/drivers/dma/dw-edma/dw-edma-v0-debugfs.c
> @@ -48,7 +48,7 @@ static struct {
>  } lim[2][EDMA_V0_MAX_NR_CH];
> =20
>  struct debugfs_entries {
> -	char					name[24];
> +	const char				*name;
>  	dma_addr_t				*reg;
>  };
> =20
> --=20
> 2.20.0


Acked-by: Gustavo Pimentel <gustavo.pimentel@synopsys.com>


