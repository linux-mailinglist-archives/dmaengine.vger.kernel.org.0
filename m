Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7781C1A9F84
	for <lists+dmaengine@lfdr.de>; Wed, 15 Apr 2020 14:14:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2898119AbgDOMNd (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 15 Apr 2020 08:13:33 -0400
Received: from smtprelay-out1.synopsys.com ([149.117.87.133]:46992 "EHLO
        smtprelay-out1.synopsys.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S368630AbgDOMNS (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 15 Apr 2020 08:13:18 -0400
Received: from mailhost.synopsys.com (badc-mailhost1.synopsys.com [10.192.0.17])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id D9221C0088;
        Wed, 15 Apr 2020 12:13:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1586952797; bh=+XIg6yoMbUM9RXYaVwiqvwRjDOeauFE2ssoLDI9i9Vw=;
        h=From:To:Subject:Date:References:In-Reply-To:From;
        b=fdRb7EsmFV3nXHQAgXCbQYuQn8K1dlsWJkna5i+o4FurRMIPAZ0mu17JGKoe4pea0
         TK2SEToxIe3BClScnhstLyYbgVDvsDhu/p4oeK3I8VczC5nlBxcLQNgmLysVpLwMJO
         zjViDKr9/Ot+efFOgRKd4sBXIfy9YsNN2xoEdD/acsOMeQb9WQRkT8HpVqRwyLg2aO
         01KD6Ro7ZmMUN4z+BbgYN7511Lz0noeHiZyIp7bj/TWBcZWfalLKP8tJjLwPPWhlfZ
         oxI+RIqqPwMa8c4J9Iq5E1WmUQnpCobLrZnHe7TDL8x4yCgWurQDMZ5Avjm+OtZw6N
         jC1Ql80+H45OQ==
Received: from US01WEHTC3.internal.synopsys.com (us01wehtc3.internal.synopsys.com [10.15.84.232])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by mailhost.synopsys.com (Postfix) with ESMTPS id D1A29A0083;
        Wed, 15 Apr 2020 12:13:15 +0000 (UTC)
Received: from us01hybrid1.internal.synopsys.com (10.200.27.51) by
 US01WEHTC3.internal.synopsys.com (10.15.84.232) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Wed, 15 Apr 2020 05:13:15 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (10.202.3.67) by
 mrs.synopsys.com (10.200.27.51) with Microsoft SMTP Server (TLS) id
 14.3.408.0; Wed, 15 Apr 2020 05:13:14 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FlmF/xLtMgRJo85rZwczVjPvwo1KM4oOOQj2+YOIkxz1otKcDhE+72C3lNasTnqBzRqNwIUXOqw9MuyGU2YIfDc5lhiRLdU6ALQV3KzN+0CrgQPf4N1hgM8txfVBwsveyYUpYjo196LWDN+eSF5KaTTG/WdunV7Y45mvcDyOohzh+tA9epp5Q2uKvDSojbdc/lblOGro8TX0Wd8LqaHEYiu4D0CAw/eknhOWXRzQT7g8/pCj0EV4MwpKTzvJwII1CKwvwnhVW/kzjbfemfVUx8IqedTCHBawk41fWL/JHGSVntN4yuHCM0v9PNvp3VwmLqQR7U2l3kNKVqOwx1aPqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MnZDPIfaDURoA0FEBzs5uTcInZAn7EhYc/CYaCs85+4=;
 b=KjgD/ZIJiudNx92BtbNWQ0RZf3UGxWuhgGciNDvu07xNP38789ujHn8KcN+cPT+sf+9I+gRT8pXGmxokNODCE1Pb09HExS4ODlPWtKZ/ru1UTPZTID8WJK7UULmMJnMGH6h7j55knJIrG1d7/SIbFtiNNtw/fchQzl+ObLKfrBMwt3La6l3eb5QHYgv7ZXqFz8VhthAbVmqyHoYM3Sc7gaMXuQdBGLXuy26PIewb93WAe/xuyAc9VZwZkMb+QA1Cqm1A7+mn89xxH4JSWkGyrNAF2sMfs9jlZFojA04HPGcTeYMrOD5Gg0md/qQXyUc2FFE9bQHSVx9D8r1AHrlmyw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MnZDPIfaDURoA0FEBzs5uTcInZAn7EhYc/CYaCs85+4=;
 b=Mt7/BmAIb0nXR4dwIltTT4TDL/chjrSRA28Umet9YbwYNmi3BfluhVfzA0I6ptkp/1W46GTkLN2qqB7rlV6xwkzE0/qtZyVz05o9idF8H/hNOIxPHYNtOBw0FIxSHeQcxmQydKTYTDEGOe74hJgG/QD1rUYQj07tBRmzv2Ov8ys=
Received: from DM5PR12MB1276.namprd12.prod.outlook.com (2603:10b6:3:79::18) by
 DM5PR12MB2389.namprd12.prod.outlook.com (2603:10b6:4:b4::18) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2900.18; Wed, 15 Apr 2020 12:13:13 +0000
Received: from DM5PR12MB1276.namprd12.prod.outlook.com
 ([fe80::cd06:6b04:8f2c:157e]) by DM5PR12MB1276.namprd12.prod.outlook.com
 ([fe80::cd06:6b04:8f2c:157e%10]) with mapi id 15.20.2900.028; Wed, 15 Apr
 2020 12:13:13 +0000
From:   Gustavo Pimentel <Gustavo.Pimentel@synopsys.com>
To:     Alan Mikhak <alan.mikhak@sifive.com>,
        "dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "dan.j.williams@intel.com" <dan.j.williams@intel.com>,
        "vkoul@kernel.org" <vkoul@kernel.org>,
        "kishon@ti.com" <kishon@ti.com>,
        "paul.walmsley@sifive.com" <paul.walmsley@sifive.com>
Subject: RE: [PATCH RFC] dmaengine: dw-edma: Decouple dw-edma-core.c from
 struct pci_dev
Thread-Topic: [PATCH RFC] dmaengine: dw-edma: Decouple dw-edma-core.c from
 struct pci_dev
Thread-Index: AQHWEsrRt1OuNWp8Y0WOATK/ErlmDqh6DhYA
Date:   Wed, 15 Apr 2020 12:13:13 +0000
Message-ID: <DM5PR12MB1276CB8FA4457D4CDCE3137EDADB0@DM5PR12MB1276.namprd12.prod.outlook.com>
References: <1586916464-27727-1-git-send-email-alan.mikhak@sifive.com>
In-Reply-To: <1586916464-27727-1-git-send-email-alan.mikhak@sifive.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: =?us-ascii?Q?PG1ldGE+PGF0IG5tPSJib2R5LnR4dCIgcD0iYzpcdXNlcnNcZ3VzdGF2b1xh?=
 =?us-ascii?Q?cHBkYXRhXHJvYW1pbmdcMDlkODQ5YjYtMzJkMy00YTQwLTg1ZWUtNmI4NGJh?=
 =?us-ascii?Q?MjllMzViXG1zZ3NcbXNnLTc3YjU0NTJlLTdmMTItMTFlYS05OGE3LWY4OTRj?=
 =?us-ascii?Q?MjczODA0MlxhbWUtdGVzdFw3N2I1NDUyZi03ZjEyLTExZWEtOThhNy1mODk0?=
 =?us-ascii?Q?YzI3MzgwNDJib2R5LnR4dCIgc3o9IjgxNzQiIHQ9IjEzMjMxNDI2MzkwNTQ2?=
 =?us-ascii?Q?MTk2MSIgaD0iL2x2Vk4rL0lpR05hWTNQaUNCenI4VDc3QnFFPSIgaWQ9IiIg?=
 =?us-ascii?Q?Ymw9IjAiIGJvPSIxIiBjaT0iY0FBQUFFUkhVMVJTUlVGTkNnVUFBQlFKQUFE?=
 =?us-ascii?Q?SlpzMDZIeFBXQVVJbmNJanlBc1dpUWlkd2lQSUN4YUlPQUFBQUFBQUFBQUFB?=
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
x-ms-office365-filtering-correlation-id: 8b62488d-c6b1-4e18-06c9-08d7e1365efe
x-ms-traffictypediagnostic: DM5PR12MB2389:
x-microsoft-antispam-prvs: <DM5PR12MB2389D0FE74DAF2F8EB25545CDADB0@DM5PR12MB2389.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-forefront-prvs: 0374433C81
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR12MB1276.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(10019020)(346002)(366004)(396003)(376002)(136003)(39860400002)(8936002)(8676002)(478600001)(71200400001)(52536014)(81156014)(2906002)(86362001)(6506007)(76116006)(66446008)(64756008)(66476007)(9686003)(186003)(316002)(55016002)(53546011)(66556008)(33656002)(7696005)(5660300002)(26005)(66946007)(110136005);DIR:OUT;SFP:1102;
received-spf: None (protection.outlook.com: synopsys.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: nqqsGKxFDPLFpdy/5KOSDHsGmUB6GdqR2ZEY2pjdolXwmeupd62+Rbjcci8lOe0tkpjoTbBBlQu9yMtCb127x/d7MQ4+745HODvDXTcrRgE2QlOrgXOKlEz/3VDG4t8nQj1FncvQ8i1HxXzIJzmBfYJqAm+w4fGBbg+Rn2mIytp5Ps+d4d4Dt5WbijLomUrTX1OM/XJcneKJ3s7OQuTKNrUgtC1VBJw/kwxi9Ufo8a/h8GTN8NxtTdDHZJoVc7vA/GBvEOS9OidHQ6iObDo+5gfoWtWmIqFmO660ZsUuB//DQCC981ZxZmqGXtFplVoC7LnCF8VWNWfxpxx25MNvVuSESBcfp6eEpPvy4O/10gy5UVlZRwjBmo/VBi1pUsAjhD6WKGGN9xZbQusKh01L4/bqkIlqA6nzX7tUQMXXQTLb67uCcGrKINYczWcZQEO7
x-ms-exchange-antispam-messagedata: bP2RBaax4m5ch/F4Rw1kalzTtDa69ksa2vUHikwOcq5vDCEMs5sVzWytQXsCmtK/dKJeBY1cedoCjgUC8vxMrP6rkPN40CYFrvOcl/p9gMxxgOBakMirnYYJGvc2kuxGWKbG4KCsVU57Z9L22nBtPA==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 8b62488d-c6b1-4e18-06c9-08d7e1365efe
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Apr 2020 12:13:13.1375
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: q7Y5WixYDe10JfWCjhVzA1exbVjR5aPqgwZO09/eU64PIm7xGX2MRp1sY7PIyuFrD9mZMqtKzylfLEWPnfocUg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB2389
X-OriginatorOrg: synopsys.com
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Hi Alan,

On Wed, Apr 15, 2020 at 3:7:44, Alan Mikhak <alan.mikhak@sifive.com>=20
wrote:

> From: Alan Mikhak <alan.mikhak@sifive.com>
>=20
> While reviewing the Synopsys Designware eDMA PCIe driver, I came across

s/Designware/DesignWare

> the following field of struct dw_edma in dw-edma-core.h:
>=20
> const struct dw_edma_core_ops	*ops;
>=20
> I was unable to find a definition for struct dw_edma_core_ops. It was
> surprising that the kernel would build without failure even though the
> dw-edma driver was enabled with what seems to be an undefined struct.

Initially, that struct was aimed to have a set of function callbacks that=20
would allow being set differently according to the eDMA version. At the=20
time it was expected to have multiple cores that would need to execute=20
different code sequences.

However, this approach was requested to be postponed on the patch review=20
because at that time and even now there isn't an extra core that would=20
justify this.

You caught some residue of that initial approach.

> The reason I was reviewing the dw-edma driver was to see if I could
> integrate it with pcitest to initiate dma operations from endpoint side.

Great! That task was on my backlog for a very long time that I wasn't=20
able to develop due the lack of time.

> As I understand from reviewing the dw-edma code, it is designed to run
> on the host side of PCIe link to initiate DMA operations remotely using
> eDMA channels of PCIe controller on the endpoint side. I am not sure if
> my understanding is correct. I infer this from seeing that dw-edma uses
> struct pci_dev and accesses hardware registers of dma channels across the
> bus using BAR0 and BAR2.

You're correct.

> I was exploring what would need to change in dw-edma to integrate it with
> pci-epf-test to initiate dma operations locally from the endpoint side.
> One barrier I see is dw_edma_probe() and other functions in dw-edma-core.=
c
> depend on struct pci_dev. Hence, instead of posting a patch to remove the
> undefined and unused ops field, I would like to define the struct and use
> it to decouple dw-edma-core.c from struct pci_dev.
>=20
> To my surprise, the kernel still builds without error even after defining
> struct dw_edma_core_ops in dw-edma-core.h and using it as in this patch.
>=20
> I would appreciate any comments on my observations about the 'ops' field,
> decoupling dw-edma-core.c from struct pci_dev, and how best to use
> dw-edma with pcitest.

I like your approach, it separates the PCIe glue logic from the eDMA=20
itself.
I would suggest that pcitest would have multiple options that could be=20
triggered, for instance:
 1 - Execute Endpoint DMA (read/write) remotely with Linked List feature=20
(from the Root Complex side)
 2 - Execute Endpoint DMA (read/write) remotely without Linked List=20
feature (from the Root Complex side)
 3 - Execute Endpoint DMA (read/write) locally with Linked List feature
 4 - Execute Endpoint DMA (read/write) locally without Linked List=20
feature

Also, don't forget the DMA has of having multiple channels for reading=20
and writing (depending on the design) that can be triggered=20
simultaneously.

Relative to the implementation of the options 3 and 4, I wonder if the=20
linked list memory space and size could be set through the DT or by the=20
configfs available on the pci-epf-test driver.

>=20
> Signed-off-by: Alan Mikhak <alan.mikhak@sifive.com>
> ---
>  drivers/dma/dw-edma/dw-edma-core.c | 17 ++++++++++-------
>  drivers/dma/dw-edma/dw-edma-core.h |  4 ++++
>  drivers/dma/dw-edma/dw-edma-pcie.c | 10 ++++++++++
>  3 files changed, 24 insertions(+), 7 deletions(-)
>=20
> diff --git a/drivers/dma/dw-edma/dw-edma-core.c b/drivers/dma/dw-edma/dw-=
edma-core.c
> index ff392c01bad1..9417a5feabbf 100644
> --- a/drivers/dma/dw-edma/dw-edma-core.c
> +++ b/drivers/dma/dw-edma/dw-edma-core.c
> @@ -14,7 +14,7 @@
>  #include <linux/err.h>
>  #include <linux/interrupt.h>
>  #include <linux/dma/edma.h>
> -#include <linux/pci.h>
> +#include <linux/dma-mapping.h>
> =20
>  #include "dw-edma-core.h"
>  #include "dw-edma-v0-core.h"
> @@ -781,7 +781,7 @@ static int dw_edma_irq_request(struct dw_edma_chip *c=
hip,
> =20
>  	if (dw->nr_irqs =3D=3D 1) {
>  		/* Common IRQ shared among all channels */
> -		err =3D request_irq(pci_irq_vector(to_pci_dev(dev), 0),
> +		err =3D request_irq(dw->ops->irq_vector(dev, 0),
>  				  dw_edma_interrupt_common,
>  				  IRQF_SHARED, dw->name, &dw->irq[0]);
>  		if (err) {
> @@ -789,7 +789,7 @@ static int dw_edma_irq_request(struct dw_edma_chip *c=
hip,
>  			return err;
>  		}
> =20
> -		get_cached_msi_msg(pci_irq_vector(to_pci_dev(dev), 0),
> +		get_cached_msi_msg(dw->ops->irq_vector(dev, 0),
>  				   &dw->irq[0].msi);
>  	} else {
>  		/* Distribute IRQs equally among all channels */
> @@ -804,7 +804,7 @@ static int dw_edma_irq_request(struct dw_edma_chip *c=
hip,
>  		dw_edma_add_irq_mask(&rd_mask, *rd_alloc, dw->rd_ch_cnt);
> =20
>  		for (i =3D 0; i < (*wr_alloc + *rd_alloc); i++) {
> -			err =3D request_irq(pci_irq_vector(to_pci_dev(dev), i),
> +			err =3D request_irq(dw->ops->irq_vector(dev, i),
>  					  i < *wr_alloc ?
>  						dw_edma_interrupt_write :
>  						dw_edma_interrupt_read,
> @@ -815,7 +815,7 @@ static int dw_edma_irq_request(struct dw_edma_chip *c=
hip,
>  				return err;
>  			}
> =20
> -			get_cached_msi_msg(pci_irq_vector(to_pci_dev(dev), i),
> +			get_cached_msi_msg(dw->ops->irq_vector(dev, i),
>  					   &dw->irq[i].msi);
>  		}
> =20
> @@ -833,6 +833,9 @@ int dw_edma_probe(struct dw_edma_chip *chip)
>  	u32 rd_alloc =3D 0;
>  	int i, err;
> =20
> +	if (!dw->ops || !dw->ops->irq_vector)
> +		return -EINVAL;
> +

I would suggest adding dw pointer check as well.

>  	raw_spin_lock_init(&dw->lock);
> =20
>  	/* Find out how many write channels are supported by hardware */
> @@ -884,7 +887,7 @@ int dw_edma_probe(struct dw_edma_chip *chip)
> =20
>  err_irq_free:
>  	for (i =3D (dw->nr_irqs - 1); i >=3D 0; i--)
> -		free_irq(pci_irq_vector(to_pci_dev(dev), i), &dw->irq[i]);
> +		free_irq(dw->ops->irq_vector(dev, i), &dw->irq[i]);
> =20
>  	dw->nr_irqs =3D 0;
> =20
> @@ -904,7 +907,7 @@ int dw_edma_remove(struct dw_edma_chip *chip)
> =20
>  	/* Free irqs */
>  	for (i =3D (dw->nr_irqs - 1); i >=3D 0; i--)
> -		free_irq(pci_irq_vector(to_pci_dev(dev), i), &dw->irq[i]);
> +		free_irq(dw->ops->irq_vector(dev, i), &dw->irq[i]);
> =20
>  	/* Power management */
>  	pm_runtime_disable(dev);
> diff --git a/drivers/dma/dw-edma/dw-edma-core.h b/drivers/dma/dw-edma/dw-=
edma-core.h
> index 4e5f9f6e901b..31fc50d31792 100644
> --- a/drivers/dma/dw-edma/dw-edma-core.h
> +++ b/drivers/dma/dw-edma/dw-edma-core.h
> @@ -103,6 +103,10 @@ struct dw_edma_irq {
>  	struct dw_edma			*dw;
>  };
> =20
> +struct dw_edma_core_ops {
> +	int	(*irq_vector)(struct device *dev, unsigned int nr);
> +};
> +
>  struct dw_edma {
>  	char				name[20];
> =20
> diff --git a/drivers/dma/dw-edma/dw-edma-pcie.c b/drivers/dma/dw-edma/dw-=
edma-pcie.c
> index dc85f55e1bb8..1eafc602e17e 100644
> --- a/drivers/dma/dw-edma/dw-edma-pcie.c
> +++ b/drivers/dma/dw-edma/dw-edma-pcie.c
> @@ -54,6 +54,15 @@ static const struct dw_edma_pcie_data snps_edda_data =
=3D {
>  	.irqs				=3D 1,
>  };
> =20
> +static int dw_edma_pcie_irq_vector(struct device *dev, unsigned int nr)
> +{
> +	return pci_irq_vector(to_pci_dev(dev), nr);
> +}
> +
> +static const struct dw_edma_core_ops dw_edma_pcie_core_ops =3D {
> +	.irq_vector =3D dw_edma_pcie_irq_vector,
> +};
> +
>  static int dw_edma_pcie_probe(struct pci_dev *pdev,
>  			      const struct pci_device_id *pid)
>  {
> @@ -151,6 +160,7 @@ static int dw_edma_pcie_probe(struct pci_dev *pdev,
>  	dw->version =3D pdata->version;
>  	dw->mode =3D pdata->mode;
>  	dw->nr_irqs =3D nr_irqs;
> +	dw->ops =3D &dw_edma_pcie_core_ops;
> =20
>  	/* Debug info */
>  	pci_dbg(pdev, "Version:\t%u\n", dw->version);
> --=20
> 2.7.4

In overall, nice patch, please fix that detail and I'll give my ACK.

Regards,
Gustavo
