Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C5C9C4E21A
	for <lists+dmaengine@lfdr.de>; Fri, 21 Jun 2019 10:44:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726430AbfFUImj (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 21 Jun 2019 04:42:39 -0400
Received: from smtprelay-out1.synopsys.com ([198.182.61.142]:55208 "EHLO
        smtprelay-out1.synopsys.com" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726390AbfFUImi (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 21 Jun 2019 04:42:38 -0400
Received: from mailhost.synopsys.com (dc2-mailhost1.synopsys.com [10.12.135.161])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 7F245C0D91;
        Fri, 21 Jun 2019 08:42:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1561106557; bh=Tm+PWLBjvz/g8EzOiYPZ7nZdG4QlIX3sFYPy9DY4hYk=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=mUD6z5XKUZ8XUNn48YkZnzf1DBIgcBzL72HGrzebPIcMVUD5Xy8HfuDpkbL1jkIZG
         9MA5y3BBFx+Wn+1TOTQ32PJTpL97jKBWJLrCW4+X2IeRc8x36bjVUdkhsJYTlomYa7
         us7fuAqoUTc70SQyl7jmocLhUVyPk2c/osjnrk5wunH96hKp4VbS8xZcvrtwJM+Fkn
         fIQ0E4EYquXsRJJDU5ngGZ29exSidfwWeElNhIu45A7FM+Qd/3h18VewePgfuZsobm
         UGYie5OleG2e0hFBqGgAnjJ3Jq+UfnyMlycWq3i9y1jdz9nib51VgX3SevAEZGdkqm
         hM7b7QxT0fKqw==
Received: from us01wehtc1.internal.synopsys.com (us01wehtc1-vip.internal.synopsys.com [10.12.239.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by mailhost.synopsys.com (Postfix) with ESMTPS id 6368AA008B;
        Fri, 21 Jun 2019 08:42:34 +0000 (UTC)
Received: from US01HYBRID2.internal.synopsys.com (10.15.246.24) by
 us01wehtc1.internal.synopsys.com (10.12.239.231) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Fri, 21 Jun 2019 01:42:34 -0700
Received: from NAM04-CO1-obe.outbound.protection.outlook.com (10.13.134.195)
 by mrs.synopsys.com (10.15.246.24) with Microsoft SMTP Server (TLS) id
 14.3.408.0; Fri, 21 Jun 2019 01:42:34 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=synopsys.onmicrosoft.com; s=selector1-synopsys-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uKfz0jFrAiKvuz4/MntPxIWFVwdcM5a0aVzFbZgV8fw=;
 b=X65LDPH3IZXYeOIbbHzXmWC5OgKuJLsDeclM2Z1eq+pxsL2OfDY20hPhNJ3h6kLGkuSscMbQDjwa4uUmKqzeANHazhk38sv2IjeUnMbiJQ/zL0Dr7E/aaP8tLb0QZdsmPbyPyUmC/lxAYcY50JLuqFVJVojdiEJMd0D/TJ7Gabk=
Received: from DM6PR12MB4010.namprd12.prod.outlook.com (10.255.175.83) by
 DM6PR12MB3609.namprd12.prod.outlook.com (20.178.30.32) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1987.11; Fri, 21 Jun 2019 08:42:32 +0000
Received: from DM6PR12MB4010.namprd12.prod.outlook.com
 ([fe80::bdd6:53d6:a062:dc8c]) by DM6PR12MB4010.namprd12.prod.outlook.com
 ([fe80::bdd6:53d6:a062:dc8c%6]) with mapi id 15.20.1987.014; Fri, 21 Jun 2019
 08:42:32 +0000
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
Subject: RE: [PATCH] dmaengine: dw-edma: fix endianess confusion
Thread-Topic: [PATCH] dmaengine: dw-edma: fix endianess confusion
Thread-Index: AQHVJQ89RjU0Q02eek2npY11LTCshKalytvg
Date:   Fri, 21 Jun 2019 08:42:32 +0000
Message-ID: <DM6PR12MB40101798EDD46EF4B8E0E0E1DAE70@DM6PR12MB4010.namprd12.prod.outlook.com>
References: <20190617131820.2470686-1-arnd@arndb.de>
In-Reply-To: <20190617131820.2470686-1-arnd@arndb.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: =?us-ascii?Q?PG1ldGE+PGF0IG5tPSJib2R5LnR4dCIgcD0iYzpcdXNlcnNcZ3VzdGF2b1xh?=
 =?us-ascii?Q?cHBkYXRhXHJvYW1pbmdcMDlkODQ5YjYtMzJkMy00YTQwLTg1ZWUtNmI4NGJh?=
 =?us-ascii?Q?MjllMzViXG1zZ3NcbXNnLTgwMmM4YjI1LTk0MDAtMTFlOS05ODg1LWY4OTRj?=
 =?us-ascii?Q?MjczODA0MlxhbWUtdGVzdFw4MDJjOGIyNi05NDAwLTExZTktOTg4NS1mODk0?=
 =?us-ascii?Q?YzI3MzgwNDJib2R5LnR4dCIgc3o9IjQyOTYiIHQ9IjEzMjA1NTgwMTUwMzIz?=
 =?us-ascii?Q?ODIxOCIgaD0iVmxRbXBQOCtOelVEMkdOYVFnSHV3UEM2SWFJPSIgaWQ9IiIg?=
 =?us-ascii?Q?Ymw9IjAiIGJvPSIxIiBjaT0iY0FBQUFFUkhVMVJTUlVGTkNnVUFBQlFKQUFC?=
 =?us-ascii?Q?S1NDRkREU2pWQWQ3bXErZVpmcHpzM3VhcjU1bCtuT3dPQUFBQUFBQUFBQUFB?=
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
x-ms-office365-filtering-correlation-id: dd612427-85fe-40ea-a7ba-08d6f6246709
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:DM6PR12MB3609;
x-ms-traffictypediagnostic: DM6PR12MB3609:
x-microsoft-antispam-prvs: <DM6PR12MB36093868683B4F553438B6EFDAE70@DM6PR12MB3609.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:341;
x-forefront-prvs: 0075CB064E
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(346002)(366004)(39860400002)(376002)(136003)(189003)(199004)(64756008)(76176011)(66446008)(76116006)(66066001)(486006)(8676002)(33656002)(478600001)(81166006)(66946007)(73956011)(6506007)(316002)(102836004)(6436002)(54906003)(86362001)(2906002)(55016002)(53546011)(81156014)(446003)(9686003)(14454004)(11346002)(256004)(99286004)(3846002)(5660300002)(6116002)(7696005)(74316002)(26005)(66556008)(66476007)(7736002)(14444005)(25786009)(110136005)(8936002)(53936002)(68736007)(71200400001)(6246003)(305945005)(186003)(71190400001)(52536014)(4326008)(476003)(229853002);DIR:OUT;SFP:1102;SCL:1;SRVR:DM6PR12MB3609;H:DM6PR12MB4010.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: synopsys.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 7jChZD6jc6NKYoSXDncLtUzFqV0txje6uDpd1N8kGvZ6RcANNU4ArTWTEdme4WaBu+PIp2YbLtcSJflXP+T/wk4V3uOB3/OUDjCr3HwT2g28j8ShhvOxE4JRWiyUtcseFRYVqb4bOdBfv8hsgmGmHA7tKJ/gTDXmaIqvk94/Qsy0QAvuih/aGpxy97V2C/O9q6K/keRO3dKX/VbZsGN6icgPekUxNfkO2tabecOqbM+yame15jcIwfqKi80bkN9iSxWDiI7OM/E3pXyepiJiZc3GmNKJOoPwvglv7dsfRcKh8Wi6gzCMu+Vv4haqnG1R7i+noqfTYjMhCtDPbU1MOiPk2VnBWRCZZ2gz+5wCnFBijGWpE89VT4qqbQN776pqDSJwWH3VCW7T//lMvQTlQlkGgXiTnu+ny3pFEr7YPtY=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: dd612427-85fe-40ea-a7ba-08d6f6246709
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Jun 2019 08:42:32.6465
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

Hi,

On Mon, Jun 17, 2019 at 14:17:47, Arnd Bergmann <arnd@arndb.de> wrote:

> When building with 'make C=3D1', sparse reports an endianess bug:

I didn't know that option.

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
> into a register function where it gets swapped again. I assume that this

Sorry I didn't catch this, endianness-swapped word into a register=20
function where it gets swapped again?
Where?

> was simply ported from a non-Linux OS, and the swap was done incorrectly.
> Replace it with a cast to uintptr_t.
>=20
> Fixes: 7e4b8a4fbe2c ("dmaengine: Add Synopsys eDMA IP version 0 support")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  drivers/dma/dw-edma/dw-edma-v0-core.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
>=20
> diff --git a/drivers/dma/dw-edma/dw-edma-v0-core.c b/drivers/dma/dw-edma/=
dw-edma-v0-core.c
> index 97e3fd41c8a8..d670ebcc37b3 100644
> --- a/drivers/dma/dw-edma/dw-edma-v0-core.c
> +++ b/drivers/dma/dw-edma/dw-edma-v0-core.c
> @@ -195,7 +195,7 @@ static void dw_edma_v0_core_write_chunk(struct dw_edm=
a_chunk *chunk)
>  	struct dw_edma_v0_lli __iomem *lli;
>  	struct dw_edma_v0_llp __iomem *llp;
>  	u32 control =3D 0, i =3D 0;
> -	u64 sar, dar, addr;
> +	uintptr_t sar, dar, addr;

Will this type assure variables sar, dar and addr are 64 bits?

>  	int j;
> =20
>  	lli =3D chunk->ll_region.vaddr;
> @@ -214,11 +214,11 @@ static void dw_edma_v0_core_write_chunk(struct dw_e=
dma_chunk *chunk)
>  		/* Transfer size */
>  		SET_LL(&lli[i].transfer_size, child->sz);
>  		/* SAR - low, high */
> -		sar =3D cpu_to_le64(child->sar);
> +		sar =3D (uintptr_t)child->sar;

Assuming the host is a big-endian machine and the eDMA on the endpoint=20
strictly requires the address to be little endian.
By not using cpu_to_le64(), the address to be written on the eDMA will be=20
in big-endian format, right? If so, that will break the driver.

>  		SET_LL(&lli[i].sar_low, lower_32_bits(sar));
>  		SET_LL(&lli[i].sar_high, upper_32_bits(sar));
>  		/* DAR - low, high */
> -		dar =3D cpu_to_le64(child->dar);
> +		dar =3D (uintptr_t)child->dar;

Ditto.

>  		SET_LL(&lli[i].dar_low, lower_32_bits(dar));
>  		SET_LL(&lli[i].dar_high, upper_32_bits(dar));
>  		i++;
> @@ -232,7 +232,7 @@ static void dw_edma_v0_core_write_chunk(struct dw_edm=
a_chunk *chunk)
>  	/* Channel control */
>  	SET_LL(&llp->control, control);
>  	/* Linked list  - low, high */
> -	addr =3D cpu_to_le64(chunk->ll_region.paddr);
> +	addr =3D (uintptr_t)chunk->ll_region.paddr;

Ditto.

>  	SET_LL(&llp->llp_low, lower_32_bits(addr));
>  	SET_LL(&llp->llp_high, upper_32_bits(addr));
>  }
> @@ -262,7 +262,7 @@ void dw_edma_v0_core_start(struct dw_edma_chunk *chun=
k, bool first)
>  		SET_CH(dw, chan->dir, chan->id, ch_control1,
>  		       (DW_EDMA_V0_CCS | DW_EDMA_V0_LLE));
>  		/* Linked list - low, high */
> -		llp =3D cpu_to_le64(chunk->ll_region.paddr);
> +		llp =3D (uintptr_t)chunk->ll_region.paddr;

Ditto.

>  		SET_CH(dw, chan->dir, chan->id, llp_low, lower_32_bits(llp));
>  		SET_CH(dw, chan->dir, chan->id, llp_high, upper_32_bits(llp));
>  	}
> --=20
> 2.20.0


