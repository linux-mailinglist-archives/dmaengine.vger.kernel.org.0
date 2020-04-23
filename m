Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 145831B5826
	for <lists+dmaengine@lfdr.de>; Thu, 23 Apr 2020 11:28:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725884AbgDWJ2m (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 23 Apr 2020 05:28:42 -0400
Received: from smtprelay-out1.synopsys.com ([149.117.73.133]:48342 "EHLO
        smtprelay-out1.synopsys.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725854AbgDWJ2l (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 23 Apr 2020 05:28:41 -0400
Received: from mailhost.synopsys.com (badc-mailhost2.synopsys.com [10.192.0.18])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 550EA40143;
        Thu, 23 Apr 2020 09:28:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1587634121; bh=8pSn0Oq9GDrYjqPFHFZ3jpoKGUVVs/0l2zkgqntgrkg=;
        h=From:To:Subject:Date:References:In-Reply-To:From;
        b=IPxlYL3GKAxM4BQykuXh6LF4Ii5UkHbSjYsC7Id2TJnilssS2XmX3/8sc2t1LHdvj
         pmnF7lqB9+NJi/0ergxNtL8FSyF7Jg0YAmgDkMHYdrKVrNnFkA2x5U2bn/5SHR6RRC
         dimXw9mM4WVghXHsvGpwKsQaceQtItg3lG36yIZUXEOQBwmVAqzMIkn+07adIv1H3y
         RQr5ZBHLXVa6C431XPTGs/3Ou1fPcrvJqu6pyUak+X166VhIzslW5/KjEWV9RPvtLi
         xH9I5ttXXEeoy/sEYRWle5x3bmqYPfet3gVobneiH16MaiGw/4YOCWQYf2riueJCSx
         Hm67sunB+evaQ==
Received: from US01WEHTC3.internal.synopsys.com (us01wehtc3.internal.synopsys.com [10.15.84.232])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by mailhost.synopsys.com (Postfix) with ESMTPS id EC3ECA006B;
        Thu, 23 Apr 2020 09:28:40 +0000 (UTC)
Received: from us01hybrid1.internal.synopsys.com (10.200.27.51) by
 US01WEHTC3.internal.synopsys.com (10.15.84.232) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Thu, 23 Apr 2020 02:28:30 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (10.202.3.67) by
 mrs.synopsys.com (10.200.27.51) with Microsoft SMTP Server (TLS) id
 14.3.487.0; Thu, 23 Apr 2020 02:28:30 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=i3WiitZ6zczFMunoqTIVSvWgdY7sMNh0T70XClZgHxtEp0H59I0tHC+yDmHaTcy9Wq/dTCGTv/1tOo+9jH4nz3om61u51eSQJ5KFPAT+p81DdfeGxArzeW/HHpT6wCjLnoZ9Qhm6gFO7MJGw4GIURG5iYeNIZcqV7qp5JgHId6rFDVK3eGt7j0qgZH1WuPvlokTEr6hNNyus6ME2NDXc3F9uRIGT7L8BiiunLKD7MBYPMfb1CN/UwENX8mwSO7glfSIZyziuNJyivmBmGeSGjN8rHP70xVMXv6rtoC1H/uoRKObnctCMfqQnYPxGqcYLEN6AKVxdH+ZZnZy1vaWCtA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O/AsBqsWYswlLeJShCprAPXe80bPLSwrBDj/ewTY110=;
 b=JJ3t8ADYByhGX8F1ap3tacDcxIY0HVbgPcPgeyqAv9ekXAuvfeC5Bq93v41xU8N5YpqAzNql81xfOxn3W/0bIfB61rUpfIM9Z66+Sr8W+nocPAvgXcrnssIVnLr5rMxW3qNaPQBwD5/B5MB6hRyDVSlU/ZZocv2oULunZULG1/nCJakJzpA5dmiKhjooGb+vtNQ4VUeHA+t4O82GkGG2oaSzBjTqD2ZhWwH4UL7AcI6xad0UXZ6n5K32I9yIVAySrRVnpkrvhdSGICHfnp3Nrm5lG7eQ8bLrLinK6MxOtOJHTv/EMgMTQD6VGwcHCPYfSr/aXVDr5b/H41bNz5qw5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O/AsBqsWYswlLeJShCprAPXe80bPLSwrBDj/ewTY110=;
 b=bHxxNcToKGqfIK0QbZ8wZIXG1csKp1DX8jGp0umETjj2QUyukhWebJWxlMxKpEDYaqga+wce2obwtwEt+fR0vjj1lAHkxauMnpWvTbXsMWDgqUjYIjkXmbEtAkE0LngJpdye2HCKt99I6Hp254kXQiWR43AL7SddefoyNF0mNcs=
Received: from DM5PR12MB1276.namprd12.prod.outlook.com (2603:10b6:3:79::18) by
 DM5PR12MB1612.namprd12.prod.outlook.com (2603:10b6:4:a::11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2937.13; Thu, 23 Apr 2020 09:28:28 +0000
Received: from DM5PR12MB1276.namprd12.prod.outlook.com
 ([fe80::2062:f350:1cd1:1023]) by DM5PR12MB1276.namprd12.prod.outlook.com
 ([fe80::2062:f350:1cd1:1023%12]) with mapi id 15.20.2921.030; Thu, 23 Apr
 2020 09:28:28 +0000
From:   Gustavo Pimentel <Gustavo.Pimentel@synopsys.com>
To:     Alan Mikhak <alan.mikhak@sifive.com>,
        "dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "dan.j.williams@intel.com" <dan.j.williams@intel.com>,
        "vkoul@kernel.org" <vkoul@kernel.org>,
        "kishon@ti.com" <kishon@ti.com>, "maz@kernel.org" <maz@kernel.org>,
        "paul.walmsley@sifive.com" <paul.walmsley@sifive.com>
Subject: RE: [PATCH v2][next] dmaengine: dw-edma: Check MSI descriptor before
 copying
Thread-Topic: [PATCH v2][next] dmaengine: dw-edma: Check MSI descriptor before
 copying
Thread-Index: AQHWGRLFZJySbqPiH0S3r+K2E1djb6iGcOIA
Date:   Thu, 23 Apr 2020 09:28:28 +0000
Message-ID: <DM5PR12MB1276642553DDD5AF85B65E01DAD30@DM5PR12MB1276.namprd12.prod.outlook.com>
References: <1587607101-31914-1-git-send-email-alan.mikhak@sifive.com>
In-Reply-To: <1587607101-31914-1-git-send-email-alan.mikhak@sifive.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: =?us-ascii?Q?PG1ldGE+PGF0IG5tPSJib2R5LnR4dCIgcD0iYzpcdXNlcnNcZ3VzdGF2b1xh?=
 =?us-ascii?Q?cHBkYXRhXHJvYW1pbmdcMDlkODQ5YjYtMzJkMy00YTQwLTg1ZWUtNmI4NGJh?=
 =?us-ascii?Q?MjllMzViXG1zZ3NcbXNnLWM4MzdiMWFhLTg1NDQtMTFlYS05OGE3LWY4OTRj?=
 =?us-ascii?Q?MjczODA0MlxhbWUtdGVzdFxjODM3YjFhYy04NTQ0LTExZWEtOThhNy1mODk0?=
 =?us-ascii?Q?YzI3MzgwNDJib2R5LnR4dCIgc3o9IjM1OTEiIHQ9IjEzMjMyMTA3NzA2MTc3?=
 =?us-ascii?Q?NDQyMiIgaD0ibllpdURRSGNDbWkwL0ExLzd3c2FxMjNydCtnPSIgaWQ9IiIg?=
 =?us-ascii?Q?Ymw9IjAiIGJvPSIxIiBjaT0iY0FBQUFFUkhVMVJTUlVGTkNnVUFBQlFKQUFC?=
 =?us-ascii?Q?V2JKQ0tVUm5XQVl1b1hMeGhYSldSaTZoY3ZHRmNsWkVPQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUhBQUFBQ2tDQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUVBQVFBQkFBQUFFbU1la3dBQUFBQUFBQUFBQUFBQUFKNEFBQUJtQUdrQWJn?=
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
x-originating-ip: [198.182.37.200]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 3403df88-a781-44d9-0095-08d7e768ae98
x-ms-traffictypediagnostic: DM5PR12MB1612:
x-microsoft-antispam-prvs: <DM5PR12MB1612B29DECDA8D4DB9A8C11BDAD30@DM5PR12MB1612.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-forefront-prvs: 03827AF76E
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR12MB1276.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(136003)(346002)(396003)(376002)(39860400002)(366004)(186003)(26005)(7696005)(316002)(8676002)(81156014)(6506007)(2906002)(55016002)(110136005)(53546011)(33656002)(9686003)(66476007)(71200400001)(52536014)(66556008)(478600001)(966005)(76116006)(66446008)(64756008)(8936002)(5660300002)(86362001)(66946007);DIR:OUT;SFP:1102;
received-spf: None (protection.outlook.com: synopsys.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: WurKFP+ZOHbGRJ3ApUc6UUxPhP7xzrlXo0YGw+TZC0RETzH/DxhTp1XbmsLelB740mLSjgxdDjOA+57XmSGwOThydjTtKQDAx3bPhscdD+n+rdtyWZK3PKEfhoijiDUneMshktdSJFwpH05S2hkT8WhI720hN899Up+EeI2ELNGailAB5uDbIisHF4Bje/YUhwwl8C8xUBvd5gbPvUV1QjvAdsXA5q3bGlOIQijEIhXeC+nWPXxqN46EP4PsgpyMZW1m1HF/gwqCJ7SD2Rk+AALIYmI34AFfuyobQxFXwsawjSGi8rowptHptDkwoXSFISkLNphnK6vBtB1XAiMkEExmwV88UB/whYDtW2y5HhBQ3K5Fj2lzTrKRFxz+1ZZRGT33bAYT2iQuIrWFbqo+/NynAecKrGUgbmTc/aGZK1J+2LYqbMZ/faYhtmAAZWzMJZvf1IRqRietQ67F8gYoboUQkw+oA0g3Yqa4RcOIpJOVTVNydsFHR8zWW4aeGfXH70CgMq+C6dzBELjjmdYwRQ==
x-ms-exchange-antispam-messagedata: nueUM3aMZFzg+WSZTvhKh6AQkkt9nq5gjBS7oJ+6aQ07Kx1Dk+BeWGvyL6zPwygTsoU1wTN0trX2lQFUHudtHBxgqj2HCLoZjKy9cjyYJqdu3WIEPoNEJ1K30ZRFlVNYRrvJnJ0tfJaPK1B37vHcZw==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 3403df88-a781-44d9-0095-08d7e768ae98
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Apr 2020 09:28:28.6952
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: CejrEqwIW4y9f70Scb4kp6JPTT9b/fRNBsu+h+anQwEcKYZQvO+a7yKDuQEgFoj4BrAsvirOQZeX9NYTUeTfGg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1612
X-OriginatorOrg: synopsys.com
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Thu, Apr 23, 2020 at 2:58:21, Alan Mikhak <alan.mikhak@sifive.com>=20
wrote:

> From: Alan Mikhak <alan.mikhak@sifive.com>
>=20
> Modify dw_edma_irq_request() to check if a struct msi_desc entry exists
> before copying the contents of its struct msi_msg pointer.
>=20
> Without this sanity check, __get_cached_msi_msg() crashes when invoked by
> dw_edma_irq_request() running on a Linux-based PCIe endpoint device. MSI
> interrupt are not received by PCIe endpoint devices. If irq_get_msi_desc(=
)
> returns null, then there is no cached struct msi_msg to be copied.
>=20
> This patch depends on the following patch:
> [PATCH v2] dmaengine: dw-edma: Decouple dw-edma-core.c from struct pci_de=
v
> https://urldefense.com/v3/__https://patchwork.kernel.org/patch/11491757/_=
_;!!A4F2R9G_pg!L_vf_Tml7Ca4sWVvZp5crRCp7YsMj6B93G9cMAO8Dj3w9I0MArjwuwNKtDz9=
rr0RlpXiqPg$=20
>=20
> Rebased on linux-next which has above patch applied.
>=20
> Fixes: Build error with config x86_64-randconfig-f003-20200422
> Fixes: Build error with config s390-allmodconfig
> Reported-by: kbuild test robot <lkp@intel.com>
> Signed-off-by: Alan Mikhak <alan.mikhak@sifive.com>
> ---
>  drivers/dma/dw-edma/dw-edma-core.c | 17 ++++++++++-------
>  1 file changed, 10 insertions(+), 7 deletions(-)
>=20
> diff --git a/drivers/dma/dw-edma/dw-edma-core.c b/drivers/dma/dw-edma/dw-=
edma-core.c
> index db401eb11322..306ab50462be 100644
> --- a/drivers/dma/dw-edma/dw-edma-core.c
> +++ b/drivers/dma/dw-edma/dw-edma-core.c
> @@ -13,6 +13,7 @@
>  #include <linux/dmaengine.h>
>  #include <linux/err.h>
>  #include <linux/interrupt.h>
> +#include <linux/irq.h>
>  #include <linux/dma/edma.h>
>  #include <linux/dma-mapping.h>
> =20
> @@ -773,6 +774,7 @@ static int dw_edma_irq_request(struct dw_edma_chip *c=
hip,
>  	u32 rd_mask =3D 1;
>  	int i, err =3D 0;
>  	u32 ch_cnt;
> +	int irq;
> =20
>  	ch_cnt =3D dw->wr_ch_cnt + dw->rd_ch_cnt;
> =20
> @@ -781,16 +783,16 @@ static int dw_edma_irq_request(struct dw_edma_chip =
*chip,
> =20
>  	if (dw->nr_irqs =3D=3D 1) {
>  		/* Common IRQ shared among all channels */
> -		err =3D request_irq(dw->ops->irq_vector(dev, 0),
> -				  dw_edma_interrupt_common,
> +		irq =3D dw->ops->irq_vector(dev, 0);
> +		err =3D request_irq(irq, dw_edma_interrupt_common,
>  				  IRQF_SHARED, dw->name, &dw->irq[0]);
>  		if (err) {
>  			dw->nr_irqs =3D 0;
>  			return err;
>  		}
> =20
> -		get_cached_msi_msg(dw->ops->irq_vector(dev, 0),
> -				   &dw->irq[0].msi);
> +		if (irq_get_msi_desc(irq))
> +			get_cached_msi_msg(irq, &dw->irq[0].msi);
>  	} else {
>  		/* Distribute IRQs equally among all channels */
>  		int tmp =3D dw->nr_irqs;
> @@ -804,7 +806,8 @@ static int dw_edma_irq_request(struct dw_edma_chip *c=
hip,
>  		dw_edma_add_irq_mask(&rd_mask, *rd_alloc, dw->rd_ch_cnt);
> =20
>  		for (i =3D 0; i < (*wr_alloc + *rd_alloc); i++) {
> -			err =3D request_irq(dw->ops->irq_vector(dev, i),
> +			irq =3D dw->ops->irq_vector(dev, i);
> +			err =3D request_irq(irq,
>  					  i < *wr_alloc ?
>  						dw_edma_interrupt_write :
>  						dw_edma_interrupt_read,
> @@ -815,8 +818,8 @@ static int dw_edma_irq_request(struct dw_edma_chip *c=
hip,
>  				return err;
>  			}
> =20
> -			get_cached_msi_msg(dw->ops->irq_vector(dev, i),
> -					   &dw->irq[i].msi);
> +			if (irq_get_msi_desc(irq))
> +				get_cached_msi_msg(irq, &dw->irq[i].msi);
>  		}
> =20
>  		dw->nr_irqs =3D i;
> --=20
> 2.7.4


Acked-by: Gustavo Pimentel <gustavo.pimentel@synopsys.com>


