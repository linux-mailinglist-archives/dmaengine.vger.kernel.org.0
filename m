Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EAD6731B6A1
	for <lists+dmaengine@lfdr.de>; Mon, 15 Feb 2021 10:47:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230268AbhBOJqT (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 15 Feb 2021 04:46:19 -0500
Received: from smtprelay-out1.synopsys.com ([149.117.73.133]:57906 "EHLO
        smtprelay-out1.synopsys.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230226AbhBOJqQ (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 15 Feb 2021 04:46:16 -0500
Received: from mailhost.synopsys.com (badc-mailhost2.synopsys.com [10.192.0.18])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 7F7BF40131;
        Mon, 15 Feb 2021 09:45:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1613382313; bh=mMZzVbsih+ZdwgRmcOP/9M1nI8SNpGIEWiCjkf90jds=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=b8998uqxsjovohsbglXYU76FvbexT83aNqANf+eMy2+SjojAbw7Pqlzcp+F5HW31z
         bjtRUJcwqBaJWVnL9YVH7f3rkaHk9nWkIKVhqUTszH9My+qY/yjn+MT5u5MX77gRbS
         ZZzKPigPgXTWq3vKOir+3gSqMMIFbwCCAd8cfR9NI4yNDu9Uam+uj/DvaYve3Rdgzq
         ulq7OAf/D9rAHlWs2ewwVHibllJJnbhNAtYlr25B/iF3bKyXbJX4dY4WmT2aysfink
         6R9cj60rLyQ926lf6KbgJ78zz2sgu+nx7AqGXsSq/X/yc0wrwzCd6aXIB7T3L8x+qz
         7CdO3qKvwgZCQ==
Received: from o365relay-in.synopsys.com (us03-o365relay3.synopsys.com [10.4.161.139])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by mailhost.synopsys.com (Postfix) with ESMTPS id 32237A0069;
        Mon, 15 Feb 2021 09:45:11 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2173.outbound.protection.outlook.com [104.47.59.173])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "mail.protection.outlook.com", Issuer "GlobalSign Organization Validation CA - SHA256 - G3" (verified OK))
        by o365relay-in.synopsys.com (Postfix) with ESMTPS id 0B825800BF;
        Mon, 15 Feb 2021 09:45:10 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=gustavo@synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
        dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.b="NzZewc2M";
        dkim-atps=neutral
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=h20U8aAF6uFT5Y4l/X02VcRufhmF6dKOcDrTo69tl7R38u/TRSlw5XZrCA88BR+FceHqOYtit35lVe4sN6ve8IMlt1cc0dffOtI346M49W7XV7jCddEhltBoF0G0rUJbhWYMkE6bJmUOmuJGYPXXOQ45Sp4qn/ilQyGK5oA9U3ifs7BDda8sjcmQORdys+0CncOSp2wNi23W5W6NuMy8UWW0HwAfVso8Cn2QfCsfOUvquNQnRNIL+18bcXuq7iXe92UCLxyzgCyy2ovmT6MHQx7QafsssbNuwAqJx9whYoj6usf0QORwDvYK1FC6VA/EkzLcPyokUu4Qn9uzEp91Qw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=38dY00U0IQMqhuNFv9CHOCikdEF0TTrSoY4TCKC8a1w=;
 b=LvKrP8Kr3bFtD0DgjWY/oYG2QvrMN+ODT399Bb0LKKr1S9RxuxwAnsxb0PBNdKu8imSr5mfDawynx9JeJAd8bGepY8BsL5LLO+q9mLeixjhznd5jMHNATvNe7Umha4HVLi73+jpehZtH04F/VzUm3aTt5i1txmjnLzgtzIlkyWrrPNtxveAA7AcCyGUHP1/uXoP7RQ8c6E0ZS+8qgVMfbq0igcYAIKspKgi+NSEMIG/2Dz36FYR5kmT+RrzOh72YlSBewA4g5XizLyUIpq44JJLmm+0ZwsppuAViXHcA2rcv7xWY2GFJbtaGJwTjNLDs7MApVDa8yPju41P8221i+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=38dY00U0IQMqhuNFv9CHOCikdEF0TTrSoY4TCKC8a1w=;
 b=NzZewc2MnKTPnaA+w/WIn7o2evg12Wvg3Jt2K7W4C9R642dss+UyfD1HOy5Ox85YETQCH+D0kEMUoUOgAh7FQ0vtaE+M9LN4eiudz8+XIP6YwGGYsq0bOUAiM9JZ6uT6sHo7oqslRQ0zpcqDwE2qGOv94hFVJ2DtGdlzy0Twz6Q=
Received: from DM5PR12MB1835.namprd12.prod.outlook.com (2603:10b6:3:10c::9) by
 DM6PR12MB4484.namprd12.prod.outlook.com (2603:10b6:5:28f::24) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3846.26; Mon, 15 Feb 2021 09:45:08 +0000
Received: from DM5PR12MB1835.namprd12.prod.outlook.com
 ([fe80::508b:bdb3:d353:9052]) by DM5PR12MB1835.namprd12.prod.outlook.com
 ([fe80::508b:bdb3:d353:9052%10]) with mapi id 15.20.3846.039; Mon, 15 Feb
 2021 09:45:08 +0000
X-SNPS-Relay: synopsys.com
From:   Gustavo Pimentel <Gustavo.Pimentel@synopsys.com>
To:     Dejin Zheng <zhengdejin5@gmail.com>,
        "vkoul@kernel.org" <vkoul@kernel.org>,
        "wangzhou1@hisilicon.com" <wangzhou1@hisilicon.com>,
        "ftoth@exalondelft.nl" <ftoth@exalondelft.nl>,
        "andy.shevchenko@gmail.com" <andy.shevchenko@gmail.com>,
        "qiuzhenfa@hisilicon.com" <qiuzhenfa@hisilicon.com>,
        "dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 2/3] dmaengine: dw-edma: Add missing call to
 'pci_free_irq_vectors()' in probe function
Thread-Topic: [PATCH 2/3] dmaengine: dw-edma: Add missing call to
 'pci_free_irq_vectors()' in probe function
Thread-Index: AQHXAtRksckgD5i8WEiw8EdykNKVE6pY+qVw
Date:   Mon, 15 Feb 2021 09:45:07 +0000
Message-ID: <DM5PR12MB18357590D1A8C22A1E7287BCDA889@DM5PR12MB1835.namprd12.prod.outlook.com>
References: <20210214132153.575350-1-zhengdejin5@gmail.com>
 <20210214132153.575350-3-zhengdejin5@gmail.com>
In-Reply-To: <20210214132153.575350-3-zhengdejin5@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: =?us-ascii?Q?PG1ldGE+PGF0IG5tPSJib2R5LnR4dCIgcD0iYzpcdXNlcnNcZ3VzdGF2b1xh?=
 =?us-ascii?Q?cHBkYXRhXHJvYW1pbmdcMDlkODQ5YjYtMzJkMy00YTQwLTg1ZWUtNmI4NGJh?=
 =?us-ascii?Q?MjllMzViXG1zZ3NcbXNnLTc2MjdjMjUzLTZmNzMtMTFlYi05OGU2LWY4OTRj?=
 =?us-ascii?Q?MjczODA0MlxhbWUtdGVzdFw3NjI3YzI1NS02ZjczLTExZWItOThlNi1mODk0?=
 =?us-ascii?Q?YzI3MzgwNDJib2R5LnR4dCIgc3o9IjE3ODkiIHQ9IjEzMjU3ODU2MzI2OTQx?=
 =?us-ascii?Q?MDc2NCIgaD0iUmpxZHZOSzhZU2tWa29vMTVpTW5adE1Gck5ZPSIgaWQ9IiIg?=
 =?us-ascii?Q?Ymw9IjAiIGJvPSIxIiBjaT0iY0FBQUFFUkhVMVJTUlVGTkNnVUFBQlFKQUFE?=
 =?us-ascii?Q?TVA0RTRnQVBYQWIrRGQyMTBZS0dBdjROM2JYUmdvWUFPQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUhBQUFBQ2tDQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUVBQVFBQkFBQUFOclNWM2dBQUFBQUFBQUFBQUFBQUFKNEFBQUJtQUdrQWJn?=
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
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=synopsys.com;
x-originating-ip: [89.155.14.32]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 9d93fd70-857a-4ebc-579d-08d8d196614f
x-ms-traffictypediagnostic: DM6PR12MB4484:
x-microsoft-antispam-prvs: <DM6PR12MB44846726077550FADA92CB79DA889@DM6PR12MB4484.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6430;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: O2cK316Xo9lvIGWHnER4YUw9soAqAE+PEGZtWUKN704M8tYTEJWd1cWJjkkCtTqYInZAP+TIEDT+XXvmtDgtmnym30rE8eCzyaZwCDFXr0rAph4zkJl1Zd9MIjwk/jO1jg2ljNRHh75A7rBaoFnQfrAhW85NMNJD8mrnVsNQr1f0rLYjiWiTeiN8YGR3oOhlgs8qxUhLjn/X0UrQPkhl5HmQhQTkz3JceAsu5qrN2cBYiXV0rF4NDq1XHKhsCQztp2b3W1Q1iyKp4sGrTvJfXYSZS7T1VSGiLM3nRK6h8i1fuyePsZ3jZq6/gPPL1cz70h5X/QSks2kLZSNFOig04nHI9HScFZlPujOzruMUlt0mOipsDe4GXjxlYjTX91c6zHYtgNAohzvC+V5EoCJsbi029VcEIS/ugBTkKMJ8xDorY81a7cWzbc+T7vcytedAO8nf41wD4cKGnih95X3UXv3WwtCvY+1ldouut3cxS+XaVGhPZRag1EigdGK6qbUEn58a/7btyNOa+gGUZR5hKg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR12MB1835.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(396003)(366004)(376002)(346002)(136003)(39850400004)(71200400001)(9686003)(33656002)(55016002)(316002)(478600001)(53546011)(8676002)(83380400001)(6506007)(2906002)(8936002)(186003)(4326008)(76116006)(66946007)(66476007)(66556008)(64756008)(66446008)(52536014)(110136005)(26005)(7696005)(5660300002)(86362001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?kusue432z2mfMSU7BBYrxJtT57jTC85nBgPdEj3zjeQn3DrtN9SVbqvXWBZq?=
 =?us-ascii?Q?18Q0/Ox5gUwcGlA0HSntrfTHMZUcWKgkeZSrmOKGqa5LCB7UkGVQzF5xCC2l?=
 =?us-ascii?Q?Qv28+A8WSeXeI4Axogzgd0wulnXh91zjvdSmenZO4qUbn3tKfD/hTUAdkWZG?=
 =?us-ascii?Q?Cz6Ky9A399Cqz10iv4i16kJjr3PKcBE1w2gYPibE9GC4btuEilinA1o+T4PP?=
 =?us-ascii?Q?B5+Z1iT3LICGn8WNiwSnSUr0cElbbSbEa+I4WFZH6yiyWECAFOTBwxOS3VHF?=
 =?us-ascii?Q?LD3H2R6kYoBjpWg2cR3ftSuNVOBp92bmzhJk3qSt2b7inrWch3SadGrYoIAj?=
 =?us-ascii?Q?mtuLNpxZjzeLxFVBYMxYqV9pCsoF9GeRzRu6FF3jt5fTqROR70iBN58yD4FV?=
 =?us-ascii?Q?EEE7qY030jmZA5UmIAmJk8fD6vRQnio/KC2eEgiWXa2VfUxGmQ3ULnGxdPTE?=
 =?us-ascii?Q?tuPjzbxLeqwsPWHSVjClfbE2BZTtW1Gv1uVMFXEsGpkMFJAI0egSYgxd4eBv?=
 =?us-ascii?Q?7Lesif3OYu8uebGyLzevTA0mi9W5H/EXpPUFkA11CWbVcfB/yypMxZlIRcLb?=
 =?us-ascii?Q?gVhCmFpKfeNeKKcTgYaa+bYyIQHj1frNsh7AffvyfMXvu64J9Jb7xtFW0gUw?=
 =?us-ascii?Q?QhNObsGim3UedR+la6ZOcOgwoYy//H6t4rXOGiXgZylmERn1WeCDPkn9bAG3?=
 =?us-ascii?Q?t24QjELPRB7jjwJvKw+q6C6tBy3R7DSOcRtHKPiSzNJG6AS79mwpTHQjCctx?=
 =?us-ascii?Q?aWnzN5kqj2bYsIMuxg8IvX8K4qCfRzg94McaITVQ0C2oLAEZY8I7EtseY3KT?=
 =?us-ascii?Q?S8kLJ+IrUW/8xesKUhlSeWAmyr9d6TCA6rXI9D+qX6UBBqzaKKaR/HHxwTUJ?=
 =?us-ascii?Q?bixRhsWxeVOLvdBLM+oPo7nvHci5ZiW/DJx3sKh2V/MxNPmNJAOBiDib/XUb?=
 =?us-ascii?Q?zF89gFRrdQadYdJ6coJ1f1JE0Rb8R/T+0C0nfUmgR3yMIqN7uFJWazQ570RV?=
 =?us-ascii?Q?pxpHUDFWl3j/tCxBPOJ/cd5Om+e6i505Nt1J4CFske1HeNJvwsfZDRx2iSUn?=
 =?us-ascii?Q?/7/qSBW3WuXBopmeClT9VrIYre+o2sfCvtvnC7ahris8BpvYRwqmu+bPdrEB?=
 =?us-ascii?Q?c3CsuQmlYcjtScUJ15lnxFiA9SxZTEO+SVHC+BZtZU1Ilq2P+VmEYkNGAnzT?=
 =?us-ascii?Q?7x2DaCmQS25pkYFGpoEOEEeZtNaJvtC5wr9RpB+bvv0RV4C0U3iHMkW5W5Ih?=
 =?us-ascii?Q?w5E2SJ7vapUEyF+Zl2SEwkCFtnuaegNnH/N240/WeTvimB5DRuTclVc4dA1l?=
 =?us-ascii?Q?nJw=3D?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB1835.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9d93fd70-857a-4ebc-579d-08d8d196614f
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Feb 2021 09:45:07.9954
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: clQ4pO5Yf5Kw1Hcy74eTXBEeretxH4+di1jf/GjPNwBpMQfusNSJmR9upbNSQNtQH9FluLh8vkw4LD15otPZog==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4484
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Sun, Feb 14, 2021 at 13:21:52, Dejin Zheng <zhengdejin5@gmail.com>=20
wrote:

> Call to 'pci_free_irq_vectors()' is missing in the error handling path
> of the probe function, So add it.
>=20
> Fixes: 41aaff2a2ac01c5 ("dmaengine: Add Synopsys eDMA IP PCIe glue-logic"=
)
> Signed-off-by: Dejin Zheng <zhengdejin5@gmail.com>
> ---
>  drivers/dma/dw-edma/dw-edma-pcie.c | 15 +++++++++++----
>  1 file changed, 11 insertions(+), 4 deletions(-)
>=20
> diff --git a/drivers/dma/dw-edma/dw-edma-pcie.c b/drivers/dma/dw-edma/dw-=
edma-pcie.c
> index 1eafc602e17e..c1e796bd3ee9 100644
> --- a/drivers/dma/dw-edma/dw-edma-pcie.c
> +++ b/drivers/dma/dw-edma/dw-edma-pcie.c
> @@ -185,24 +185,31 @@ static int dw_edma_pcie_probe(struct pci_dev *pdev,
>  	/* Validating if PCI interrupts were enabled */
>  	if (!pci_dev_msi_enabled(pdev)) {
>  		pci_err(pdev, "enable interrupt failed\n");
> -		return -EPERM;
> +		err =3D -EPERM;
> +		goto err_free_irq;
>  	}
> =20
>  	dw->irq =3D devm_kcalloc(dev, nr_irqs, sizeof(*dw->irq), GFP_KERNEL);
> -	if (!dw->irq)
> -		return -ENOMEM;
> +	if (!dw->irq) {
> +		err =3D -ENOMEM;
> +		goto err_free_irq;
> +	}
> =20
>  	/* Starting eDMA driver */
>  	err =3D dw_edma_probe(chip);
>  	if (err) {
>  		pci_err(pdev, "eDMA probe failed\n");
> -		return err;
> +		goto err_free_irq;
>  	}
> =20
>  	/* Saving data structure reference */
>  	pci_set_drvdata(pdev, chip);
> =20
>  	return 0;
> +
> +err_free_irq:
> +	pci_free_irq_vectors(pdev);
> +	return err;
>  }
> =20
>  static void dw_edma_pcie_remove(struct pci_dev *pdev)
> --=20
> 2.25.0

Acked-by: Gustavo Pimentel <gustavo.pimentel@synopsys.com>


