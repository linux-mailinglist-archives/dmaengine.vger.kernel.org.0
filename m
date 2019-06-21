Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 43D064E262
	for <lists+dmaengine@lfdr.de>; Fri, 21 Jun 2019 10:53:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726260AbfFUIx4 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 21 Jun 2019 04:53:56 -0400
Received: from smtprelay-out1.synopsys.com ([198.182.61.142]:55710 "EHLO
        smtprelay-out1.synopsys.com" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726210AbfFUIx4 (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 21 Jun 2019 04:53:56 -0400
Received: from mailhost.synopsys.com (badc-mailhost2.synopsys.com [10.192.0.18])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 63BA4C0D89;
        Fri, 21 Jun 2019 08:53:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1561107235; bh=SkshD7T+935+19ME/wNE22MDrcZZLTpavN3SIlbzvjM=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=Q58Ayde+UoUyIguGWPBGOGbnzGYRwuUjnxQlHXHcwqjJjaV12zsk+1qW+ZleEMUIN
         xmvfAFVQ0u5EKHHVcIGWcUDY+V5RjVByQTiWGQQjdocqdGZzpTPHKelyeBbjPJ5bts
         w05mPpCxjZVjEVPQykPyGQ8lUX+wF+opr24QlTJ41vh7/1xu0a18GVqyOWhJKmdT8C
         2H+P2F8h8AQErZQ3AUFgRwXz+oVbhv6N0shjkUp/Xp87oiDowpT7q7ICLsgf9Jvace
         Hech6jnbcKyOskP5e4Vy0b3+T8Mr9M20HQPyHriVwkr2l9mb7Me332N4sRTBQIpVlO
         nUpO9XS6q8I3w==
Received: from US01WEHTC3.internal.synopsys.com (us01wehtc3.internal.synopsys.com [10.15.84.232])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by mailhost.synopsys.com (Postfix) with ESMTPS id 04872A006A;
        Fri, 21 Jun 2019 08:53:53 +0000 (UTC)
Received: from US01HYBRID2.internal.synopsys.com (10.15.246.24) by
 US01WEHTC3.internal.synopsys.com (10.15.84.232) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Fri, 21 Jun 2019 01:53:53 -0700
Received: from NAM01-SN1-obe.outbound.protection.outlook.com (10.13.134.195)
 by mrs.synopsys.com (10.15.246.24) with Microsoft SMTP Server (TLS) id
 14.3.408.0; Fri, 21 Jun 2019 01:53:53 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=synopsys.onmicrosoft.com; s=selector1-synopsys-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7LxFu0Kt2o7VovdqveXHXfzRWsB4xvEjJL129JKOKDw=;
 b=lCERPpJ/NBGNKGYdnWxGObE2NP0tkLdAqf9zAnYUXZbtTlzndf+WHu4Voa3gZxeey+dcTaOHM3TwY5yu2Et1Sos16X+B0cHt2tHdlYWu9YKwFCeU3BUlFDnczAok2ISsI/mJp4G9xMPSWf1WNFHz7Lxibbg0jzq84YQf2xeppWA=
Received: from DM6PR12MB4010.namprd12.prod.outlook.com (10.255.175.83) by
 DM6PR12MB3306.namprd12.prod.outlook.com (20.179.106.94) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2008.16; Fri, 21 Jun 2019 08:53:51 +0000
Received: from DM6PR12MB4010.namprd12.prod.outlook.com
 ([fe80::bdd6:53d6:a062:dc8c]) by DM6PR12MB4010.namprd12.prod.outlook.com
 ([fe80::bdd6:53d6:a062:dc8c%6]) with mapi id 15.20.1987.014; Fri, 21 Jun 2019
 08:53:51 +0000
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
Subject: RE: [PATCH] dmaengine: dw-edma: fix __iomem type confusion
Thread-Topic: [PATCH] dmaengine: dw-edma: fix __iomem type confusion
Thread-Index: AQHVJQ9kwKPy1knRjkS259Lqkv5E76al0Lgw
Date:   Fri, 21 Jun 2019 08:53:51 +0000
Message-ID: <DM6PR12MB401058325016417472CD5717DAE70@DM6PR12MB4010.namprd12.prod.outlook.com>
References: <20190617131918.2518727-1-arnd@arndb.de>
In-Reply-To: <20190617131918.2518727-1-arnd@arndb.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: =?us-ascii?Q?PG1ldGE+PGF0IG5tPSJib2R5LnR4dCIgcD0iYzpcdXNlcnNcZ3VzdGF2b1xh?=
 =?us-ascii?Q?cHBkYXRhXHJvYW1pbmdcMDlkODQ5YjYtMzJkMy00YTQwLTg1ZWUtNmI4NGJh?=
 =?us-ascii?Q?MjllMzViXG1zZ3NcbXNnLTE0ZjM3MjU5LTk0MDItMTFlOS05ODg1LWY4OTRj?=
 =?us-ascii?Q?MjczODA0MlxhbWUtdGVzdFwxNGYzNzI1YS05NDAyLTExZTktOTg4NS1mODk0?=
 =?us-ascii?Q?YzI3MzgwNDJib2R5LnR4dCIgc3o9Ijg2MzIiIHQ9IjEzMjA1NTgwODI5NzYz?=
 =?us-ascii?Q?ODQxOSIgaD0iU0hLMkxjY2ZrZWhHR0dXUzF1VitaQ2xVNjJBPSIgaWQ9IiIg?=
 =?us-ascii?Q?Ymw9IjAiIGJvPSIxIiBjaT0iY0FBQUFFUkhVMVJTUlVGTkNnVUFBQlFKQUFB?=
 =?us-ascii?Q?VG1odllEaWpWQWNGNE5PeDRGb3Jud1hnMDdIZ1dpdWNPQUFBQUFBQUFBQUFB?=
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
x-ms-office365-filtering-correlation-id: 29505d21-741c-47b1-e960-08d6f625fba0
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:DM6PR12MB3306;
x-ms-traffictypediagnostic: DM6PR12MB3306:
x-microsoft-antispam-prvs: <DM6PR12MB3306569478D6C0351EAD5857DAE70@DM6PR12MB3306.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2657;
x-forefront-prvs: 0075CB064E
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(136003)(346002)(39860400002)(396003)(366004)(376002)(199004)(189003)(76176011)(7696005)(26005)(102836004)(186003)(53546011)(6506007)(2906002)(99286004)(53936002)(476003)(55016002)(9686003)(486006)(6246003)(446003)(11346002)(478600001)(68736007)(33656002)(25786009)(66066001)(14444005)(256004)(71190400001)(4326008)(71200400001)(3846002)(5660300002)(6116002)(8936002)(52536014)(14454004)(8676002)(81166006)(81156014)(6436002)(316002)(66946007)(305945005)(66476007)(66556008)(64756008)(66446008)(7736002)(76116006)(73956011)(229853002)(86362001)(110136005)(54906003)(74316002);DIR:OUT;SFP:1102;SCL:1;SRVR:DM6PR12MB3306;H:DM6PR12MB4010.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: synopsys.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: hpzF7TKfnDiBZ8JWaFap4fN6NtI3+vMfQFt6mCfHtke48BuEiP2UuFtGBi59MM0kxynv1jB5bmPBdOuc4vs057HUZMW6zb97wIoIC/PN/UsifcMEVQ6t7yVY0b+HRzl3TgMhUTqmu+37p5hBdYfNNfo8EkWnGVVf4nwtsHlppc4YFtoiCXemM9SV4o58oFQjBcsvM7IP4zawPAOIlYacy215k1P6FxpCFN4l/qEf4KcYE5lK6zvD9eTs8N913hm0yNYARlNGk6UsTgE4xYHoB8V5v5hXrdS+etSr0M9p1BaN5SybWmp9aLSti1P7S+zlnp7J4uH/8ZKeM9e+pvTmcTx2kNde6wEF5Ql+wtC+mM74RNWxz81g30Fg7zQHPTWIVYtzoYZ5lgF92S03gdhKeyxVLnomv8lgfrOGtcMPxkw=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 29505d21-741c-47b1-e960-08d6f625fba0
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Jun 2019 08:53:51.4793
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: gustavo@synopsys.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3306
X-OriginatorOrg: synopsys.com
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Mon, Jun 17, 2019 at 14:18:43, Arnd Bergmann <arnd@arndb.de> wrote:

> The new driver mixes up dma_addr_t and __iomem pointers, which results
> in warnings on some 32-bit architectures, like:
>=20
> drivers/dma/dw-edma/dw-edma-v0-core.c: In function '__dw_regs':
> drivers/dma/dw-edma/dw-edma-v0-core.c:28:9: error: cast to pointer from i=
nteger of different size [-Werror=3Dint-to-pointer-cast]
>   return (struct dw_edma_v0_regs __iomem *)dw->rg_region.vaddr;
>=20
> Make it use __iomem pointers consistently here, and avoid using dma_addr_=
t
> for __iomem tokens altogether.
>=20
> A small complication here is the debugfs code, which passes an __iomem
> token as the private data for debugfs files, requiring the use of
> extra __force.
>=20
> Fixes: 7e4b8a4fbe2c ("dmaengine: Add Synopsys eDMA IP version 0 support")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  drivers/dma/dw-edma/dw-edma-core.h       |  2 +-
>  drivers/dma/dw-edma/dw-edma-pcie.c       | 18 ++++++++--------
>  drivers/dma/dw-edma/dw-edma-v0-core.c    | 10 ++++-----
>  drivers/dma/dw-edma/dw-edma-v0-debugfs.c | 27 ++++++++++++------------
>  4 files changed, 29 insertions(+), 28 deletions(-)
>=20
> diff --git a/drivers/dma/dw-edma/dw-edma-core.h b/drivers/dma/dw-edma/dw-=
edma-core.h
> index b6cc90cbc9dc..d03a6ad263bd 100644
> --- a/drivers/dma/dw-edma/dw-edma-core.h
> +++ b/drivers/dma/dw-edma/dw-edma-core.h
> @@ -50,7 +50,7 @@ struct dw_edma_burst {
> =20
>  struct dw_edma_region {
>  	phys_addr_t			paddr;
> -	dma_addr_t			vaddr;
> +	void __iomem *			vaddr;
>  	size_t				sz;
>  };
> =20
> diff --git a/drivers/dma/dw-edma/dw-edma-pcie.c b/drivers/dma/dw-edma/dw-=
edma-pcie.c
> index 4c96e1c948f2..dc85f55e1bb8 100644
> --- a/drivers/dma/dw-edma/dw-edma-pcie.c
> +++ b/drivers/dma/dw-edma/dw-edma-pcie.c
> @@ -130,19 +130,19 @@ static int dw_edma_pcie_probe(struct pci_dev *pdev,
>  	chip->id =3D pdev->devfn;
>  	chip->irq =3D pdev->irq;
> =20
> -	dw->rg_region.vaddr =3D (dma_addr_t)pcim_iomap_table(pdev)[pdata->rg_ba=
r];
> +	dw->rg_region.vaddr =3D pcim_iomap_table(pdev)[pdata->rg_bar];
>  	dw->rg_region.vaddr +=3D pdata->rg_off;
>  	dw->rg_region.paddr =3D pdev->resource[pdata->rg_bar].start;
>  	dw->rg_region.paddr +=3D pdata->rg_off;
>  	dw->rg_region.sz =3D pdata->rg_sz;
> =20
> -	dw->ll_region.vaddr =3D (dma_addr_t)pcim_iomap_table(pdev)[pdata->ll_ba=
r];
> +	dw->ll_region.vaddr =3D pcim_iomap_table(pdev)[pdata->ll_bar];
>  	dw->ll_region.vaddr +=3D pdata->ll_off;
>  	dw->ll_region.paddr =3D pdev->resource[pdata->ll_bar].start;
>  	dw->ll_region.paddr +=3D pdata->ll_off;
>  	dw->ll_region.sz =3D pdata->ll_sz;
> =20
> -	dw->dt_region.vaddr =3D (dma_addr_t)pcim_iomap_table(pdev)[pdata->dt_ba=
r];
> +	dw->dt_region.vaddr =3D pcim_iomap_table(pdev)[pdata->dt_bar];
>  	dw->dt_region.vaddr +=3D pdata->dt_off;
>  	dw->dt_region.paddr =3D pdev->resource[pdata->dt_bar].start;
>  	dw->dt_region.paddr +=3D pdata->dt_off;
> @@ -158,17 +158,17 @@ static int dw_edma_pcie_probe(struct pci_dev *pdev,
>  	pci_dbg(pdev, "Mode:\t%s\n",
>  		dw->mode =3D=3D EDMA_MODE_LEGACY ? "Legacy" : "Unroll");
> =20
> -	pci_dbg(pdev, "Registers:\tBAR=3D%u, off=3D0x%.8lx, sz=3D0x%zx bytes, a=
ddr(v=3D%pa, p=3D%pa)\n",
> +	pci_dbg(pdev, "Registers:\tBAR=3D%u, off=3D0x%.8lx, sz=3D0x%zx bytes, a=
ddr(v=3D%p, p=3D%pa)\n",
>  		pdata->rg_bar, pdata->rg_off, pdata->rg_sz,
> -		&dw->rg_region.vaddr, &dw->rg_region.paddr);
> +		dw->rg_region.vaddr, &dw->rg_region.paddr);
> =20
> -	pci_dbg(pdev, "L. List:\tBAR=3D%u, off=3D0x%.8lx, sz=3D0x%zx bytes, add=
r(v=3D%pa, p=3D%pa)\n",
> +	pci_dbg(pdev, "L. List:\tBAR=3D%u, off=3D0x%.8lx, sz=3D0x%zx bytes, add=
r(v=3D%p, p=3D%pa)\n",
>  		pdata->ll_bar, pdata->ll_off, pdata->ll_sz,
> -		&dw->ll_region.vaddr, &dw->ll_region.paddr);
> +		dw->ll_region.vaddr, &dw->ll_region.paddr);
> =20
> -	pci_dbg(pdev, "Data:\tBAR=3D%u, off=3D0x%.8lx, sz=3D0x%zx bytes, addr(v=
=3D%pa, p=3D%pa)\n",
> +	pci_dbg(pdev, "Data:\tBAR=3D%u, off=3D0x%.8lx, sz=3D0x%zx bytes, addr(v=
=3D%p, p=3D%pa)\n",
>  		pdata->dt_bar, pdata->dt_off, pdata->dt_sz,
> -		&dw->dt_region.vaddr, &dw->dt_region.paddr);
> +		dw->dt_region.vaddr, &dw->dt_region.paddr);
> =20
>  	pci_dbg(pdev, "Nr. IRQs:\t%u\n", dw->nr_irqs);
> =20
> diff --git a/drivers/dma/dw-edma/dw-edma-v0-core.c b/drivers/dma/dw-edma/=
dw-edma-v0-core.c
> index 8cafd51ff9ec..d670ebcc37b3 100644
> --- a/drivers/dma/dw-edma/dw-edma-v0-core.c
> +++ b/drivers/dma/dw-edma/dw-edma-v0-core.c
> @@ -25,7 +25,7 @@ enum dw_edma_control {
> =20
>  static inline struct dw_edma_v0_regs __iomem *__dw_regs(struct dw_edma *=
dw)
>  {
> -	return (struct dw_edma_v0_regs __iomem *)dw->rg_region.vaddr;
> +	return dw->rg_region.vaddr;
>  }
> =20
>  #define SET(dw, name, value)				\
> @@ -192,13 +192,13 @@ u32 dw_edma_v0_core_status_abort_int(struct dw_edma=
 *dw, enum dw_edma_dir dir)
>  static void dw_edma_v0_core_write_chunk(struct dw_edma_chunk *chunk)
>  {
>  	struct dw_edma_burst *child;
> -	struct dw_edma_v0_lli *lli;
> -	struct dw_edma_v0_llp *llp;
> +	struct dw_edma_v0_lli __iomem *lli;
> +	struct dw_edma_v0_llp __iomem *llp;
>  	u32 control =3D 0, i =3D 0;
>  	uintptr_t sar, dar, addr;
>  	int j;
> =20
> -	lli =3D (struct dw_edma_v0_lli *)chunk->ll_region.vaddr;
> +	lli =3D chunk->ll_region.vaddr;
> =20
>  	if (chunk->cb)
>  		control =3D DW_EDMA_V0_CB;
> @@ -224,7 +224,7 @@ static void dw_edma_v0_core_write_chunk(struct dw_edm=
a_chunk *chunk)
>  		i++;
>  	}
> =20
> -	llp =3D (struct dw_edma_v0_llp *)&lli[i];
> +	llp =3D (void __iomem *)&lli[i];
>  	control =3D DW_EDMA_V0_LLP | DW_EDMA_V0_TCB;
>  	if (!chunk->cb)
>  		control |=3D DW_EDMA_V0_CB;
> diff --git a/drivers/dma/dw-edma/dw-edma-v0-debugfs.c b/drivers/dma/dw-ed=
ma/dw-edma-v0-debugfs.c
> index 5728b6fe938c..42739508c0d8 100644
> --- a/drivers/dma/dw-edma/dw-edma-v0-debugfs.c
> +++ b/drivers/dma/dw-edma/dw-edma-v0-debugfs.c
> @@ -14,7 +14,7 @@
>  #include "dw-edma-core.h"
> =20
>  #define REGS_ADDR(name) \
> -	((dma_addr_t *)&regs->name)
> +	((void __force *)&regs->name)
>  #define REGISTER(name) \
>  	{ #name, REGS_ADDR(name) }
> =20
> @@ -40,11 +40,11 @@
> =20
>  static struct dentry				*base_dir;
>  static struct dw_edma				*dw;
> -static struct dw_edma_v0_regs			*regs;
> +static struct dw_edma_v0_regs			__iomem *regs;

Shouldn't the __iomem be next to dw_edma_v0_regs instead of the variable=20
name? I saw other drivers putting the __iomem next to the variable type,=20
therefore I assume it's the typical coding style.

> =20
>  static struct {
> -	void					*start;
> -	void					*end;
> +	void					__iomem *start;
> +	void					__iomem *end;

Ditto.

>  } lim[2][EDMA_V0_MAX_NR_CH];
> =20
>  struct debugfs_entries {
> @@ -54,22 +54,23 @@ struct debugfs_entries {
> =20
>  static int dw_edma_debugfs_u32_get(void *data, u64 *val)
>  {
> +	void __iomem *reg =3D (void __force __iomem *)data;
>  	if (dw->mode =3D=3D EDMA_MODE_LEGACY &&
> -	    data >=3D (void *)&regs->type.legacy.ch) {
> -		void *ptr =3D (void *)&regs->type.legacy.ch;
> +	    reg >=3D (void __iomem *)&regs->type.legacy.ch) {
> +		void __iomem *ptr =3D &regs->type.legacy.ch;
>  		u32 viewport_sel =3D 0;
>  		unsigned long flags;
>  		u16 ch;
> =20
>  		for (ch =3D 0; ch < dw->wr_ch_cnt; ch++)
> -			if (lim[0][ch].start >=3D data && data < lim[0][ch].end) {
> -				ptr +=3D (data - lim[0][ch].start);
> +			if (lim[0][ch].start >=3D reg && reg < lim[0][ch].end) {
> +				ptr +=3D (reg - lim[0][ch].start);
>  				goto legacy_sel_wr;
>  			}
> =20
>  		for (ch =3D 0; ch < dw->rd_ch_cnt; ch++)
> -			if (lim[1][ch].start >=3D data && data < lim[1][ch].end) {
> -				ptr +=3D (data - lim[1][ch].start);
> +			if (lim[1][ch].start >=3D reg && reg < lim[1][ch].end) {
> +				ptr +=3D (reg - lim[1][ch].start);
>  				goto legacy_sel_rd;
>  			}
> =20
> @@ -86,7 +87,7 @@ static int dw_edma_debugfs_u32_get(void *data, u64 *val=
)
> =20
>  		raw_spin_unlock_irqrestore(&dw->lock, flags);
>  	} else {
> -		*val =3D readl(data);
> +		*val =3D readl(reg);
>  	}
> =20
>  	return 0;
> @@ -105,7 +106,7 @@ static void dw_edma_debugfs_create_x32(const struct d=
ebugfs_entries entries[],
>  	}
>  }
> =20
> -static void dw_edma_debugfs_regs_ch(struct dw_edma_v0_ch_regs *regs,
> +static void dw_edma_debugfs_regs_ch(struct dw_edma_v0_ch_regs __iomem *r=
egs,
>  				    struct dentry *dir)
>  {
>  	int nr_entries;
> @@ -288,7 +289,7 @@ void dw_edma_v0_debugfs_on(struct dw_edma_chip *chip)
>  	if (!dw)
>  		return;
> =20
> -	regs =3D (struct dw_edma_v0_regs *)dw->rg_region.vaddr;
> +	regs =3D dw->rg_region.vaddr;
>  	if (!regs)
>  		return;
> =20
> --=20
> 2.20.0


