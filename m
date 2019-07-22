Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 560C670124
	for <lists+dmaengine@lfdr.de>; Mon, 22 Jul 2019 15:35:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728637AbfGVNfC (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 22 Jul 2019 09:35:02 -0400
Received: from smtprelay-out1.synopsys.com ([198.182.47.102]:40172 "EHLO
        smtprelay-out1.synopsys.com" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725989AbfGVNfC (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 22 Jul 2019 09:35:02 -0400
Received: from mailhost.synopsys.com (dc8-mailhost2.synopsys.com [10.13.135.210])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 760C0C1C2A;
        Mon, 22 Jul 2019 13:35:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1563802502; bh=yko0THfxasD0az7lVWN3YRiFti/9J/1EWDeANcw1icU=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=WhLwYbw+BFszhW/Ffo30ixV8qFpnqBrcqcynf83vErBKzfqdYyphnz7XEu+8UJmib
         do1ijRQjTDN/YfhfNkzz+oWaPDrHM5dd2a8/XUKxlaJOeq7GGFW4wZVrW8mss/FSmG
         2U7JS5DShewpdV0piD3ZrS/bG50KfxednyWQwVp5kog3MxPlmwuFQtK93h5vBMou0q
         JiUNwtoLXec0Yl2a2yl6N5+tWQ/JsNce+F+CntDIdKuUiJ+G5unYGOMoj/RVACU5nU
         RP6saxdPIS4ylKWj/e12o3ytHFegX6qCDD4rZe3nILp+Lg8NNjp8ZlfICuhBJ/SVD9
         RVCHD1y3vnRhQ==
Received: from us01wehtc1.internal.synopsys.com (us01wehtc1-vip.internal.synopsys.com [10.12.239.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by mailhost.synopsys.com (Postfix) with ESMTPS id A6BA1A0067;
        Mon, 22 Jul 2019 13:35:00 +0000 (UTC)
Received: from US01HYBRID2.internal.synopsys.com (10.15.246.24) by
 us01wehtc1.internal.synopsys.com (10.12.239.235) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Mon, 22 Jul 2019 06:35:00 -0700
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (10.13.134.195)
 by mrs.synopsys.com (10.15.246.24) with Microsoft SMTP Server (TLS) id
 14.3.408.0; Mon, 22 Jul 2019 06:34:59 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=g3ycxNrxS0whPox1WtgpdTksVONTeKvyou8DIBHKqqnEwXGzWjIg31bSb07QwJsGTYIbAaw8Ku132YtJpUpHdI5/GS51NAKlTlf2jgBqTEW78eJcKz3BIDUeB4jDVqWIe8QhxyERo9mYiqjR8N2/az1hVgbF3/BeuGiyy7+jx+N7uueqVrZD6WF7G5lpSZnE1LAyrxLotkMObVJj3G89Cy1Rzedn3czVWx92Q2ZgXUSyxta5yrIH3g/pBM0yMh8cLOj+yU0ZQBddnOIiro5d1JuW2D0jTg0wAphuatQh4P8QvocPShuN7Vk0WR5Zq3UMBDQq4xTyxG/DLZZXmVukKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WgU/C2NQKjqR3g0FPOomgbM80KaZN3yyAMN5RflOOHs=;
 b=Nk+tsZ0u8Whcwl+gd+bEnU7sda+5KDKtFMWfWmaCg2wYBKj39vkxbSnG/YFrsfWEJnGgRqBp91ipdRG/2ayTpk23Y6E1SRnK+yN5m88A3zKL06Z88bm6Y3Nzy79ltP1U4oK8CnCfPLmq3R5QlRUzJqaReo1VCVHsIgrmaLLTEYV6fwYycRyjfgHAZkvIeAwF6HBoTudvKW0Z/5m8FqCfby8/kdIJUYcPHIYKfUq1P9aNNdBDpKQM/MD7gQxYGJc1pPgrC1/RbwktVuwT84PF5Nt4qBQOqmrEtpxGQJ0kSvrfCkyaqxeBmNiAQiTzRqQEt3NQ/EkceHlykkA8P87qLg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1;spf=pass
 smtp.mailfrom=synopsys.com;dmarc=pass action=none
 header.from=synopsys.com;dkim=pass header.d=synopsys.com;arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=synopsys.onmicrosoft.com; s=selector1-synopsys-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WgU/C2NQKjqR3g0FPOomgbM80KaZN3yyAMN5RflOOHs=;
 b=WVnk9DoLpYo/mRw58j/hodoYZUNcu1MRCx2upjiIFoAkuJy4RhAS9p2r/+D3a2LFDGL/TqzF2/RT5xMjbX4cl0gn0jmNIgEa9wdxT6RaIWfusyEU5Bssv91TP47PrItbhkA3Ta80fVmuOVDB7agNwdaMxEODo4pfeEnikeI0Xbs=
Received: from DM6PR12MB4010.namprd12.prod.outlook.com (10.255.175.83) by
 DM6PR12MB3963.namprd12.prod.outlook.com (10.255.174.212) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2094.16; Mon, 22 Jul 2019 13:34:58 +0000
Received: from DM6PR12MB4010.namprd12.prod.outlook.com
 ([fe80::1508:71eb:20f6:b4e6]) by DM6PR12MB4010.namprd12.prod.outlook.com
 ([fe80::1508:71eb:20f6:b4e6%6]) with mapi id 15.20.2094.013; Mon, 22 Jul 2019
 13:34:58 +0000
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
Subject: RE: [PATCH 3/3] [v2] dmaengine: dw-edma: fix endianess confusion
Thread-Topic: [PATCH 3/3] [v2] dmaengine: dw-edma: fix endianess confusion
Thread-Index: AQHVQIuWgCAsMTG+Vk++o32UVEiyqKbWo13Q
Date:   Mon, 22 Jul 2019 13:34:58 +0000
Message-ID: <DM6PR12MB4010C84C98B373343E0DDE1EDAC40@DM6PR12MB4010.namprd12.prod.outlook.com>
References: <20190722124457.1093886-1-arnd@arndb.de>
 <20190722124457.1093886-3-arnd@arndb.de>
In-Reply-To: <20190722124457.1093886-3-arnd@arndb.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: =?us-ascii?Q?PG1ldGE+PGF0IG5tPSJib2R5LnR4dCIgcD0iYzpcdXNlcnNcZ3VzdGF2b1xh?=
 =?us-ascii?Q?cHBkYXRhXHJvYW1pbmdcMDlkODQ5YjYtMzJkMy00YTQwLTg1ZWUtNmI4NGJh?=
 =?us-ascii?Q?MjllMzViXG1zZ3NcbXNnLTdkNzViZDZjLWFjODUtMTFlOS05ODhjLWY4OTRj?=
 =?us-ascii?Q?MjczODA0MlxhbWUtdGVzdFw3ZDc1YmQ2ZS1hYzg1LTExZTktOTg4Yy1mODk0?=
 =?us-ascii?Q?YzI3MzgwNDJib2R5LnR4dCIgc3o9IjQ5MjEiIHQ9IjEzMjA4Mjc2MDk1NzEz?=
 =?us-ascii?Q?NjczMCIgaD0iQllnM1hmSGJUYmFIWG53NE12ZktHekw1L1ZRPSIgaWQ9IiIg?=
 =?us-ascii?Q?Ymw9IjAiIGJvPSIxIiBjaT0iY0FBQUFFUkhVMVJTUlVGTkNnVUFBQlFKQUFC?=
 =?us-ascii?Q?YWo4MC9ra0RWQWVPa0FDa1ZrUHdCNDZRQUtSV1EvQUVPQUFBQUFBQUFBQUFB?=
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
x-ms-office365-filtering-correlation-id: 54771fa3-1ab2-46bd-3048-08d70ea963c6
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600148)(711020)(4605104)(1401327)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);SRVR:DM6PR12MB3963;
x-ms-traffictypediagnostic: DM6PR12MB3963:
x-ms-exchange-purlcount: 1
x-microsoft-antispam-prvs: <DM6PR12MB3963896A668CDE691380673BDAC40@DM6PR12MB3963.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:101;
x-forefront-prvs: 01068D0A20
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(39860400002)(396003)(366004)(376002)(136003)(199004)(189003)(54906003)(7696005)(966005)(86362001)(9686003)(316002)(110136005)(8676002)(3846002)(4326008)(5660300002)(55016002)(53936002)(66556008)(74316002)(66476007)(305945005)(256004)(64756008)(66446008)(478600001)(14444005)(6246003)(6116002)(68736007)(6306002)(76116006)(25786009)(52536014)(66946007)(7736002)(81156014)(33656002)(81166006)(99286004)(2906002)(76176011)(11346002)(476003)(8936002)(486006)(71190400001)(71200400001)(53546011)(186003)(66066001)(102836004)(26005)(6506007)(6436002)(446003)(229853002)(14454004);DIR:OUT;SFP:1102;SCL:1;SRVR:DM6PR12MB3963;H:DM6PR12MB4010.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: synopsys.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: D3nuJn57KLw02xesAYgDNRpHbwofAkpqLvgCW9HSeom1WpWA9i7NCjg7wlX0yZbeefesB7GBaBom6zuPuFdzqw+60rsnQ6Lp6NPRZWxHGcWPgooj2K6XhEsC/7gxXsnL7sngw5UG8llpudsoFnXX5N7witbqqtgOpIQtJG2PY6v8eha9jrodKO265yzuPHHxgeiJxqLpYWRFBPtatXkkCIBFTYJui7O9JsB2PmsrMQ/bsaVVCj3xFGTRwckvjGrXNnzo3alMEuTm2YzZTmW/iggABfSEuPvqc4iTMkLOz4dacpBRboE2sLR9bR79zxK39p4mD1FronwZD/VGlhnbEgRbpk/YHihx7skjcrT4BpaqfWRJXoULRLkgT15/4X1uZXW3BDTTWpsdig8i0B7Be6HSwoz9mGsoQ8dD5NYxAhs=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 54771fa3-1ab2-46bd-3048-08d70ea963c6
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Jul 2019 13:34:58.0440
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: gustavo@synopsys.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3963
X-OriginatorOrg: synopsys.com
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Mon, Jul 22, 2019 at 13:44:45, Arnd Bergmann <arnd@arndb.de> wrote:

> When building with 'make C=3D1', sparse reports an endianess bug:
>=20
> drivers/dma/dw-edma/dw-edma-v0-debugfs.c:60:30: warning: cast removes add=
ress space of expression
> drivers/dma/dw-edma/dw-edma-v0-debugfs.c:86:24: warning: incorrect type i=
n argument 1 (different address spaces)
> drivers/dma/dw-edma/dw-edma-v0-debugfs.c:86:24:    expected void const vo=
latile [noderef] <asn:2>*addr
> drivers/dma/dw-edma/dw-edma-v0-debugfs.c:86:24:    got void *[assigned] p=
tr
> drivers/dma/dw-edma/dw-edma-v0-debugfs.c:86:24: warning: incorrect type i=
n argument 1 (different address spaces)
> drivers/dma/dw-edma/dw-edma-v0-debugfs.c:86:24:    expected void const vo=
latile [noderef] <asn:2>*addr
> drivers/dma/dw-edma/dw-edma-v0-debugfs.c:86:24:    got void *[assigned] p=
tr
> drivers/dma/dw-edma/dw-edma-v0-debugfs.c:86:24: warning: incorrect type i=
n argument 1 (different address spaces)
> drivers/dma/dw-edma/dw-edma-v0-debugfs.c:86:24:    expected void const vo=
latile [noderef] <asn:2>*addr
> drivers/dma/dw-edma/dw-edma-v0-debugfs.c:86:24:    got void *[assigned] p=
tr
>=20
> The current code is clearly wrong, as it passes an endian-swapped word
> into a register function where it gets swapped again. Just pass the varia=
bles
> directly into lower_32_bits()/upper_32_bits().
>=20
> Fixes: 7e4b8a4fbe2c ("dmaengine: Add Synopsys eDMA IP version 0 support")
> Link: https://urldefense.proofpoint.com/v2/url?u=3Dhttps-3A__lore.kernel.=
org_lkml_20190617131820.2470686-2D1-2Darnd-40arndb.de_&d=3DDwIDAg&c=3DDPL6_=
X_6JkXFx7AXWqB0tg&r=3DbkWxpLoW-f-E3EdiDCCa0_h0PicsViasSlvIpzZvPxs&m=3DTzn8c=
iklqeA_SXj1k0nN9QiPfGqx8kgsSRaM6-IkOwk&s=3DnOFhosE33DqpmKyI-X7EI576wW7M2Voi=
le7t7KQpJEQ&e=3D=20
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
> v2: remove unneeded local variables
> ---
>  drivers/dma/dw-edma/dw-edma-v0-core.c | 24 ++++++++++--------------
>  1 file changed, 10 insertions(+), 14 deletions(-)
>=20
> diff --git a/drivers/dma/dw-edma/dw-edma-v0-core.c b/drivers/dma/dw-edma/=
dw-edma-v0-core.c
> index 97e3fd41c8a8..692de47b1670 100644
> --- a/drivers/dma/dw-edma/dw-edma-v0-core.c
> +++ b/drivers/dma/dw-edma/dw-edma-v0-core.c
> @@ -195,7 +195,6 @@ static void dw_edma_v0_core_write_chunk(struct dw_edm=
a_chunk *chunk)
>  	struct dw_edma_v0_lli __iomem *lli;
>  	struct dw_edma_v0_llp __iomem *llp;
>  	u32 control =3D 0, i =3D 0;
> -	u64 sar, dar, addr;
>  	int j;
> =20
>  	lli =3D chunk->ll_region.vaddr;
> @@ -214,13 +213,11 @@ static void dw_edma_v0_core_write_chunk(struct dw_e=
dma_chunk *chunk)
>  		/* Transfer size */
>  		SET_LL(&lli[i].transfer_size, child->sz);
>  		/* SAR - low, high */
> -		sar =3D cpu_to_le64(child->sar);
> -		SET_LL(&lli[i].sar_low, lower_32_bits(sar));
> -		SET_LL(&lli[i].sar_high, upper_32_bits(sar));
> +		SET_LL(&lli[i].sar_low, lower_32_bits(child->sar));
> +		SET_LL(&lli[i].sar_high, upper_32_bits(child->sar));
>  		/* DAR - low, high */
> -		dar =3D cpu_to_le64(child->dar);
> -		SET_LL(&lli[i].dar_low, lower_32_bits(dar));
> -		SET_LL(&lli[i].dar_high, upper_32_bits(dar));
> +		SET_LL(&lli[i].dar_low, lower_32_bits(child->dar));
> +		SET_LL(&lli[i].dar_high, upper_32_bits(child->dar));
>  		i++;
>  	}
> =20
> @@ -232,9 +229,8 @@ static void dw_edma_v0_core_write_chunk(struct dw_edm=
a_chunk *chunk)
>  	/* Channel control */
>  	SET_LL(&llp->control, control);
>  	/* Linked list  - low, high */
> -	addr =3D cpu_to_le64(chunk->ll_region.paddr);
> -	SET_LL(&llp->llp_low, lower_32_bits(addr));
> -	SET_LL(&llp->llp_high, upper_32_bits(addr));
> +	SET_LL(&llp->llp_low, lower_32_bits(chunk->ll_region.paddr));
> +	SET_LL(&llp->llp_high, upper_32_bits(chunk->ll_region.paddr));
>  }
> =20
>  void dw_edma_v0_core_start(struct dw_edma_chunk *chunk, bool first)
> @@ -242,7 +238,6 @@ void dw_edma_v0_core_start(struct dw_edma_chunk *chun=
k, bool first)
>  	struct dw_edma_chan *chan =3D chunk->chan;
>  	struct dw_edma *dw =3D chan->chip->dw;
>  	u32 tmp;
> -	u64 llp;
> =20
>  	dw_edma_v0_core_write_chunk(chunk);
> =20
> @@ -262,9 +257,10 @@ void dw_edma_v0_core_start(struct dw_edma_chunk *chu=
nk, bool first)
>  		SET_CH(dw, chan->dir, chan->id, ch_control1,
>  		       (DW_EDMA_V0_CCS | DW_EDMA_V0_LLE));
>  		/* Linked list - low, high */
> -		llp =3D cpu_to_le64(chunk->ll_region.paddr);
> -		SET_CH(dw, chan->dir, chan->id, llp_low, lower_32_bits(llp));
> -		SET_CH(dw, chan->dir, chan->id, llp_high, upper_32_bits(llp));
> +		SET_CH(dw, chan->dir, chan->id, llp_low,
> +		       lower_32_bits(chunk->ll_region.paddr));
> +		SET_CH(dw, chan->dir, chan->id, llp_high,
> +		       upper_32_bits(chunk->ll_region.paddr));
>  	}
>  	/* Doorbell */
>  	SET_RW(dw, chan->dir, doorbell,
> --=20
> 2.20.0


Acked-by: Gustavo Pimentel <gustavo.pimentel@synopsys.com>


