Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ABE571AF18A
	for <lists+dmaengine@lfdr.de>; Sat, 18 Apr 2020 17:20:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726069AbgDRPUb (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Sat, 18 Apr 2020 11:20:31 -0400
Received: from smtprelay-out1.synopsys.com ([149.117.87.133]:55968 "EHLO
        smtprelay-out1.synopsys.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725903AbgDRPUa (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Sat, 18 Apr 2020 11:20:30 -0400
Received: from mailhost.synopsys.com (badc-mailhost2.synopsys.com [10.192.0.18])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id D848BC00CA;
        Sat, 18 Apr 2020 15:20:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1587223229; bh=yjqs4L7VPY8W1zKgM132IyhUZvH00hKvz7/SSobGo+o=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=KPGOm3X97eeo/PbMbmi+wpd47BpukXP2DuQ6VJ2ZzD3CNADl+57XTvYiEt2c9BndH
         k587vxHe5gP+jJeSGaxqBiu7SdhBbWOWLiWJ9jlaBMpLJ1wwX35rhbsQ6+mUM8R9dI
         MAYDfsdtXQff88P6v+eeMl20Wzix/jWdPYbZupkNOIDoazXNr/7v9Or5TV6SBeFDEy
         H7Hd6HeYObQMFScduFIMyOKd3jB6xImy5m5XMq4TcJjCjx2C+rX537tcdeGKPZoh1l
         aMDa5Nklb1X00QaTdVHlf7dRi72Vd0xVRSi4jg9aDdICGlog9j2cedymhYJpMPt3cW
         wtOr8ylRv/VoQ==
Received: from US01WEHTC3.internal.synopsys.com (us01wehtc3.internal.synopsys.com [10.15.84.232])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by mailhost.synopsys.com (Postfix) with ESMTPS id 0C654A0067;
        Sat, 18 Apr 2020 15:20:17 +0000 (UTC)
Received: from us01hybrid1.internal.synopsys.com (10.200.27.51) by
 US01WEHTC3.internal.synopsys.com (10.15.84.232) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Sat, 18 Apr 2020 08:19:43 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (10.202.3.67) by
 mrs.synopsys.com (10.200.27.51) with Microsoft SMTP Server (TLS) id
 14.3.487.0; Sat, 18 Apr 2020 08:19:42 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=T4UfYyLlGvuw/hpG4dGl2SZ0VAGrXUAZ/t8r6Qp7SunH7iu/ivXcZVI3y3YCd+zN9kFcoGFrFKnTeTceEm98Jx4UIiPsfmYZiZVqw7nh6nTs1gARrtpHkEzbiYisEmUd9WU79mkWbODHQmIA5xoMgMSqXRhI7RPs+E/5Zw3+0HyOZvkhX1RP7BbUi0YH3nLbxga7+IvhgwF4QKfKJndO4qfZ1xV4X6QDPwhvx++fP4BEs8FXOHbFJ4DwHB4FGMg+OB+h7FytBvAGLo7xfwsSUYi75vLqKp5TH8mJ8ViQZqTUo4J4RAAqUYqk7bn0XlqFglwUu7Tch/K5fuYc0+SFFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yjqs4L7VPY8W1zKgM132IyhUZvH00hKvz7/SSobGo+o=;
 b=NAdjaNy3+8nAWPNA4IiJPp9TeL/2NhXM4v/Q48pP9y5lMeftiOBHGy+T3dpBfxyg1qmXbXOxT0hEUjcCWm3mG3XR9eJLK6vHgqm0G17ttBGeGSHsuy6K06BgSvYXcR/ULynuhcflu9B9hl8ofz2gIlXUC2OyUhVb7iywUcUJstvAIAN+2EtOxVnHjSgKZkRL3gSSD/IgzskxhjwlAI52hkPrKeQQmHNSHZmgWj4WgDPEAlDUyJv9ce6JRPTaUtFpxYNsZBiW3k0W7HWkYFUqneTq3s5/xIYdL9DL79H/9qKbbm9iT3jb4mpDWJ5TtAraiBHdQ1j73HbXRn+QQMr65A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yjqs4L7VPY8W1zKgM132IyhUZvH00hKvz7/SSobGo+o=;
 b=j5Vqtv9H3Cd/kptzbc6dENj5xSrsPbqfvAiGhpi3PBCd669pc1FasVixx5CD24EO8R6M8IKfCI7K2eenndbk5n7E61Jpf8oTl/X6rxUkG7Ia1UQ2e9dmiVsITUXXKJegNRaCUoDiMak4MoM2gGswVbKdMJ+pCOUpN5uoO0fAS0w=
Received: from CY4PR12MB1271.namprd12.prod.outlook.com (2603:10b6:903:3d::22)
 by CY4PR12MB1237.namprd12.prod.outlook.com (2603:10b6:903:3e::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2900.26; Sat, 18 Apr
 2020 15:19:42 +0000
Received: from CY4PR12MB1271.namprd12.prod.outlook.com
 ([fe80::99c:b980:181f:7a31]) by CY4PR12MB1271.namprd12.prod.outlook.com
 ([fe80::99c:b980:181f:7a31%11]) with mapi id 15.20.2921.027; Sat, 18 Apr 2020
 15:19:42 +0000
From:   Gustavo Pimentel <Gustavo.Pimentel@synopsys.com>
To:     Marc Zyngier <maz@kernel.org>, Alan Mikhak <alan.mikhak@sifive.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "kishon@ti.com" <kishon@ti.com>,
        "paul.walmsley@sifive.com" <paul.walmsley@sifive.com>
Subject: RE: [PATCH] genirq/msi: Check null pointer before copying struct
 msi_msg
Thread-Topic: [PATCH] genirq/msi: Check null pointer before copying struct
 msi_msg
Thread-Index: AQHWFOj2GuwhmqAbhkeOnSBUbwf1lqh+vSmAgAA2tGA=
Date:   Sat, 18 Apr 2020 15:19:41 +0000
Message-ID: <CY4PR12MB1271277CEE4F1FE06B71DDE8DAD60@CY4PR12MB1271.namprd12.prod.outlook.com>
References: <1587149322-28104-1-git-send-email-alan.mikhak@sifive.com>
 <20200418122123.10157ddd@why>
In-Reply-To: <20200418122123.10157ddd@why>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: =?us-ascii?Q?PG1ldGE+PGF0IG5tPSJib2R5LnR4dCIgcD0iYzpcdXNlcnNcZ3VzdGF2b1xh?=
 =?us-ascii?Q?cHBkYXRhXHJvYW1pbmdcMDlkODQ5YjYtMzJkMy00YTQwLTg1ZWUtNmI4NGJh?=
 =?us-ascii?Q?MjllMzViXG1zZ3NcbXNnLTA0MzIwNjdhLTgxODgtMTFlYS05OGE3LWY4OTRj?=
 =?us-ascii?Q?MjczODA0MlxhbWUtdGVzdFwwNDMyMDY3Yi04MTg4LTExZWEtOThhNy1mODk0?=
 =?us-ascii?Q?YzI3MzgwNDJib2R5LnR4dCIgc3o9IjIwMTAiIHQ9IjEzMjMxNjk2Nzc4OTY1?=
 =?us-ascii?Q?NjU0MiIgaD0icXpOeXpIQmZYSFZhOTVFKzJLMWl2UEY3RUVzPSIgaWQ9IiIg?=
 =?us-ascii?Q?Ymw9IjAiIGJvPSIxIiBjaT0iY0FBQUFFUkhVMVJTUlVGTkNnVUFBQlFKQUFE?=
 =?us-ascii?Q?ZStkdkdsQlhXQVlMWXpOdVVyQlA4Z3RqTTI1U3NFL3dPQUFBQUFBQUFBQUFB?=
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
x-ms-office365-filtering-correlation-id: 1af31d65-e2bc-4ec1-7d7b-08d7e3abeb2f
x-ms-traffictypediagnostic: CY4PR12MB1237:
x-microsoft-antispam-prvs: <CY4PR12MB1237042482CD36B4FBABC73CDAD60@CY4PR12MB1237.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3276;
x-forefront-prvs: 0377802854
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR12MB1271.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(10019020)(366004)(346002)(39850400004)(376002)(396003)(136003)(52536014)(66446008)(7696005)(66476007)(64756008)(66556008)(26005)(81156014)(6506007)(8676002)(8936002)(66946007)(478600001)(33656002)(5660300002)(71200400001)(2906002)(4326008)(9686003)(110136005)(54906003)(55016002)(86362001)(316002)(186003)(76116006);DIR:OUT;SFP:1102;
received-spf: None (protection.outlook.com: synopsys.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: wxD9l4hS128nuaD3Fpme+2y8jBTHiC8fBTCoFNzTx5YoiGwrKDF6s04ovp4McXKfEAnpdmi7/LYH271encY1Bn5h5E8XS/2+3vX9JLI+FCidl7usKnEBu9Y9ET2tnr5NI4RW/QDYG2v5SGtJ6XV7sWEBQrZYwXUHau1D1u6gk6CLB9PFjEO1hKSL71Yd7zIPOVkIYJptRgUQpyKz34JyS7DVJzbju2k7Bb+1iyKz2gHWI49NG73Zblr2c7mHWly5UJ9Pqr/TTixcbZTn8/q5QTekLbfBUYxpe4n3dMnv8gn5fxuTZCCoQBLB3p1Ede9mOi3ezHC7IlET3XjOK+4YIlMRgkLV2PQcxQLkiEFqTYAFbuIpuuqIGG0gIihw8YSJPrDOxStMLlCFhAfd5UafXSXVq429b/YE1wylddQtI8lo1EYgfcWqY5JXIQeUJsen
x-ms-exchange-antispam-messagedata: Yl1H8PBbAGflHVbBuu0JrUY4orpMtjR06xqtBaQ6e8TTzSHd1VGp1xMzo5opKGZAKqBCBhpzg2RETg4wEEEMAWDDzfkwVewtejaaDgdslUQJZOXEbplej3XvCdMqq+G7531Pr5+qAy2UF/X1yXsj5A==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 1af31d65-e2bc-4ec1-7d7b-08d7e3abeb2f
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Apr 2020 15:19:41.9775
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9x7reueSoHCKQOsyZKQIVPxQcRr1L1U1f1VowI/rxF4F49fFQN3j2PGIwa/hLlgCfJiJI0+EUKMQrpTpe8wZMg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1237
X-OriginatorOrg: synopsys.com
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Hi Marc and Alan,

> I'm not convinced by this. If you know that, by construction, these
> interrupts are not associated with an underlying MSI, why calling
> get_cached_msi_msg() the first place?
>=20
> There seem to be some assumptions in the DW EDMA driver that the
> signaling would be MSI based, so maybe someone from Synopsys (Gustavo?)
> could clarify that. From my own perspective, running on an endpoint
> device means that it is *generating* interrupts, and I'm not sure what
> the MSIs represent here.

Giving a little context to this topic.

The eDMA IP present on the Synopsys DesignWare PCIe Endpoints can be=20
configured and triggered *remotely* as well *locally*.
For the sake of simplicity let's assume for now the eDMA was implemented=20
on the EP and that is the IP that we want to configure and use.

When I say *remotely* I mean that this IP can be configurable through the=20
RC/CPU side, however, for that, it requires the eDMA registers to be=20
exposed through a PCIe BAR on the EP. This will allow setting the SAR,=20
DAR and other settings, also need(s) the interrupt(s) address(es) to be=20
set as well (MSI or MSI-X only) so that it can signal through PCIe (to=20
the RC and consecutively the associated EP driver) if the data transfer=20
has been completed, aborted or if the Linked List consumer algorithm has=20
passed in some linked element marked with a watermark.
=20
It was based on this case that the eDMA driver was exclusively developed.

However, Alan, wants to expand a little more this, by being able to use=20
this driver on the EP side (through=20
pcitest/pci_endpoint_test/pci_epf_test) so that he can configure this IP=20
*locally*.
In fact, when doing this, he doesn't need to configure the interrupt=20
address (MSI or MSI-X), because this IP provides a local interrupt line=20
so that be connected to other blocks on the EP side.

Regards,
Gustavo

