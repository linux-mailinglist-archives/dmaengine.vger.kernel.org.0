Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 64DF24E237
	for <lists+dmaengine@lfdr.de>; Fri, 21 Jun 2019 10:44:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726733AbfFUInI (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 21 Jun 2019 04:43:08 -0400
Received: from smtprelay-out1.synopsys.com ([198.182.47.102]:46574 "EHLO
        smtprelay-out1.synopsys.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726727AbfFUInH (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 21 Jun 2019 04:43:07 -0400
Received: from mailhost.synopsys.com (dc8-mailhost1.synopsys.com [10.13.135.209])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 2DE73C1DA2;
        Fri, 21 Jun 2019 08:43:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1561106587; bh=vCdqNyn7oYQdjM3Paj/jqO3kIcef+KSQXOboBKOS/To=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=g2kjiOl7hMd6HLwM2zBg0LdGJaRk8VO4b1Ed61zcX2VQ40VJCggfA0YxI9hOvT2yJ
         tD8fOEfvk0kmbZuGi6oKUXikzVKejZ8JGzpBbxCox9hHlb2AMPVvIO970j719zHBKi
         c9FHr6fm+yMwuWf4senMPRn9klqRo28Avy+ROJULD19gEULGba8OkRjAmJLBrgsE1k
         7TNYTsiw7jN3KZS3catkOowivGlnVJmhrWfGLCxe5gvk3l5ct4m54w6hB2jcNGaY5k
         vnaF7n+c2cR09gzIiVN+ZP8kDSPdrEsv0N7VKJH2yACUthEAPC+4c1P7ghZi67BX2A
         /z4jc3AeFpHvw==
Received: from US01WEHTC2.internal.synopsys.com (us01wehtc2.internal.synopsys.com [10.12.239.237])
        (using TLSv1.2 with cipher AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        by mailhost.synopsys.com (Postfix) with ESMTPS id A3C2FA0072;
        Fri, 21 Jun 2019 08:43:06 +0000 (UTC)
Received: from US01HYBRID2.internal.synopsys.com (10.15.246.24) by
 US01WEHTC2.internal.synopsys.com (10.12.239.237) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Fri, 21 Jun 2019 01:43:06 -0700
Received: from NAM04-CO1-obe.outbound.protection.outlook.com (10.13.134.195)
 by mrs.synopsys.com (10.15.246.24) with Microsoft SMTP Server (TLS) id
 14.3.408.0; Fri, 21 Jun 2019 01:43:06 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=synopsys.onmicrosoft.com; s=selector1-synopsys-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=57O2kd5Nl87NNqNAA35Z958kmJ1Tok/IB5r3n/SWOO0=;
 b=rVHzeO3nZODRS1a+vnAWfGH4mtvBhLriM7AKYgsaJCEpKjmOpGV1hXwbv5TKQMWRLv1T/oG8+DJgMvQM9DJ91DmtZfliyxYWCubrjfbc/42Kx+xz6+BrdwHEjBsOqsNeLTnxXBfnVh3YWIqcV2QO93OJPChRbEd7bB5h7yvCvIU=
Received: from DM6PR12MB4010.namprd12.prod.outlook.com (10.255.175.83) by
 DM6PR12MB3609.namprd12.prod.outlook.com (20.178.30.32) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1987.11; Fri, 21 Jun 2019 08:43:05 +0000
Received: from DM6PR12MB4010.namprd12.prod.outlook.com
 ([fe80::bdd6:53d6:a062:dc8c]) by DM6PR12MB4010.namprd12.prod.outlook.com
 ([fe80::bdd6:53d6:a062:dc8c%6]) with mapi id 15.20.1987.014; Fri, 21 Jun 2019
 08:43:05 +0000
From:   Gustavo Pimentel <Gustavo.Pimentel@synopsys.com>
To:     kbuild test robot <lkp@intel.com>,
        Gustavo Pimentel <Gustavo.Pimentel@synopsys.com>
CC:     "kbuild-all@01.org" <kbuild-all@01.org>,
        Vinod Koul <vkoul@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        "dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] dmaengine: fix semicolon.cocci warnings
Thread-Topic: [PATCH] dmaengine: fix semicolon.cocci warnings
Thread-Index: AQHVI5RlXo1DhOZkrEeRBwsv7koL0qal03RA
Date:   Fri, 21 Jun 2019 08:43:04 +0000
Message-ID: <DM6PR12MB401071E67478154538C45EBDDAE70@DM6PR12MB4010.namprd12.prod.outlook.com>
References: <201906160043.LzDXUsKd%lkp@intel.com>
 <20190615160550.GA59533@lkp-kbuild03>
In-Reply-To: <20190615160550.GA59533@lkp-kbuild03>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: =?us-ascii?Q?PG1ldGE+PGF0IG5tPSJib2R5LnR4dCIgcD0iYzpcdXNlcnNcZ3VzdGF2b1xh?=
 =?us-ascii?Q?cHBkYXRhXHJvYW1pbmdcMDlkODQ5YjYtMzJkMy00YTQwLTg1ZWUtNmI4NGJh?=
 =?us-ascii?Q?MjllMzViXG1zZ3NcbXNnLTk0NTc5NTk4LTk0MDAtMTFlOS05ODg1LWY4OTRj?=
 =?us-ascii?Q?MjczODA0MlxhbWUtdGVzdFw5NDU3OTU5YS05NDAwLTExZTktOTg4NS1mODk0?=
 =?us-ascii?Q?YzI3MzgwNDJib2R5LnR4dCIgc3o9IjE0NDQiIHQ9IjEzMjA1NTgwMTgzMTQz?=
 =?us-ascii?Q?MjUyNCIgaD0idUM1cHBjVWE5ajhRU1kzUDRVaVZ6UlZzNlF3PSIgaWQ9IiIg?=
 =?us-ascii?Q?Ymw9IjAiIGJvPSIxIiBjaT0iY0FBQUFFUkhVMVJTUlVGTkNnVUFBQlFKQUFC?=
 =?us-ascii?Q?TUliRldEU2pWQVFCdHZwK09jdnMrQUcyK240NXkrejRPQUFBQUFBQUFBQUFB?=
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
x-ms-office365-filtering-correlation-id: 0ad83861-2082-4468-4098-08d6f6247a4b
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:DM6PR12MB3609;
x-ms-traffictypediagnostic: DM6PR12MB3609:
x-ms-exchange-purlcount: 1
x-microsoft-antispam-prvs: <DM6PR12MB36092CF228C849AD081390B7DAE70@DM6PR12MB3609.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:16;
x-forefront-prvs: 0075CB064E
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(346002)(366004)(39860400002)(376002)(136003)(189003)(199004)(64756008)(76176011)(66446008)(76116006)(66066001)(486006)(8676002)(33656002)(478600001)(81166006)(66946007)(73956011)(6506007)(316002)(102836004)(6436002)(54906003)(86362001)(2906002)(55016002)(53546011)(81156014)(446003)(9686003)(14454004)(11346002)(256004)(99286004)(3846002)(966005)(5660300002)(6636002)(6306002)(6116002)(7696005)(74316002)(26005)(66556008)(66476007)(7736002)(14444005)(25786009)(110136005)(8936002)(53936002)(68736007)(71200400001)(6246003)(305945005)(186003)(71190400001)(52536014)(4326008)(476003)(229853002);DIR:OUT;SFP:1102;SCL:1;SRVR:DM6PR12MB3609;H:DM6PR12MB4010.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: synopsys.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: CjTMxwH62of7dBJmj5I/vCoaCCO6o3oLOQkkBgzeXb5j3i5HAf8FAHwCbSeucfG4sJcROJfxZenucHMqwikvJMvsObcVL8M+qIWLwX0V42LjiNy6V0MSecKho66p1aA9Cqjez+lTjkq8UAtbGtotg6ML4EJmXMZE178Fti5UxTBTq4sSSm4ZBPO9M9mIQvCrG/wJhHR+C3IBCQ1o1r9lSPW9Fq2BI9AZGrbp0mobn5mwah1LQg3BtlS9DE7Jtk4ROA5PwmTe1AaWjDICy9QSVZ5nc0XKhT8qYBAOdkxvFeDU9t2JqL8q+DimkKjIQNyqdYnMqqnwI5hH0rt6/yge/RWTBvn4ex1t5pSAsfizUJA+gxyHjLwDdArSOIie9baFMFV1P3f+DsW0Q6+5P0tkiH4BsU8w0c6mupUCl+116GE=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 0ad83861-2082-4468-4098-08d6f6247a4b
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Jun 2019 08:43:04.9442
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: gustavo@synopsys.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3609
X-OriginatorOrg: synopsys.com
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Sat, Jun 15, 2019 at 17:5:50, kbuild test robot <lkp@intel.com> wrote:

> From: kbuild test robot <lkp@intel.com>
>=20
> drivers/dma/dw-edma/dw-edma-core.c:617:2-3: Unneeded semicolon
>=20
>=20
>  Remove unneeded semicolon.
>=20
> Generated by: scripts/coccinelle/misc/semicolon.cocci
>=20
> Fixes: e63d79d1ffcd ("dmaengine: Add Synopsys eDMA IP core driver")
> CC: Gustavo Pimentel <Gustavo.Pimentel@synopsys.com>
> Signed-off-by: kbuild test robot <lkp@intel.com>
> ---
>=20
> tree:   https://urldefense.proofpoint.com/v2/url?u=3Dhttps-3A__git.kernel=
.org_pub_scm_linux_kernel_git_next_linux-2Dnext.git&d=3DDwIBAg&c=3DDPL6_X_6=
JkXFx7AXWqB0tg&r=3DbkWxpLoW-f-E3EdiDCCa0_h0PicsViasSlvIpzZvPxs&m=3DfwNy8N2S=
rvgwC_SywHKiMch_69kqMm3ayOJIdvjOUyY&s=3DHaa6kbRbugrkJmfXID5NzII5oLi2PDpn2TJ=
Ji4u2BRg&e=3D  master
> head:   f4788d37bc84e27ac9370be252afb451bf6ef718
> commit: e63d79d1ffcd2201a2dbff1d7a1184b8f3ec74cf [5032/6646] dmaengine: A=
dd Synopsys eDMA IP core driver
>=20
>  dw-edma-core.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> --- a/drivers/dma/dw-edma/dw-edma-core.c
> +++ b/drivers/dma/dw-edma/dw-edma-core.c
> @@ -614,7 +614,7 @@ static void dw_edma_free_chan_resources(
>  			return;
> =20
>  		cpu_relax();
> -	};
> +	}
> =20
>  	pm_runtime_put(chan->chip->dev);
>  }


Acked-by: Gustavo Pimentel <gustavo.pimentel@synopsys.com>


