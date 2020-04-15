Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 111761AB0F7
	for <lists+dmaengine@lfdr.de>; Wed, 15 Apr 2020 21:10:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2411746AbgDOTHl (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 15 Apr 2020 15:07:41 -0400
Received: from smtprelay-out1.synopsys.com ([149.117.73.133]:38886 "EHLO
        smtprelay-out1.synopsys.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1416837AbgDOSi1 (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 15 Apr 2020 14:38:27 -0400
Received: from mailhost.synopsys.com (badc-mailhost1.synopsys.com [10.192.0.17])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 9C38C4056E;
        Wed, 15 Apr 2020 18:38:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1586975906; bh=xXvUp06h8vueQjE4wUW9eKwAh2h7Cg383r4qVkh0xJo=;
        h=From:To:Subject:Date:References:In-Reply-To:From;
        b=c52geOp171TzAMtD4CQR582paIqR3ok31eJ8eCPQUDhTaoaWOlb1VttVftGjmhnnA
         vgxr5iNOEPMpwTu1x4qVL4dDzmitR+mhjZQ0KgVPjS3B3CvUBK7aI56ksU4RWvC2Ze
         QHUC5djZZCCzWW88I4EAECCPhhxHU+UYM2TXG+Z08ndvUsB1yXUCfqw61SxkaPpQY4
         X5NzYDdGWMz7bNEVSnmE9AK4G+OPJWTFyBIkd2MlMId/w0iqFSYXeg4n30/2mLH6wB
         MkY8KxAQr/56/iFW0iIUpaW0Urj7cnEge72GzcWQ91ICcf8GPhWrqaumyNY4yd5shf
         NWXDWHXh7OPKQ==
Received: from US01WEHTC3.internal.synopsys.com (us01wehtc3.internal.synopsys.com [10.15.84.232])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by mailhost.synopsys.com (Postfix) with ESMTPS id E3EE9A0091;
        Wed, 15 Apr 2020 18:38:25 +0000 (UTC)
Received: from US01HYBRID2.internal.synopsys.com (10.15.246.24) by
 US01WEHTC3.internal.synopsys.com (10.15.84.232) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Wed, 15 Apr 2020 11:38:25 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (10.202.3.67) by
 mrs.synopsys.com (10.15.246.24) with Microsoft SMTP Server (TLS) id
 14.3.408.0; Wed, 15 Apr 2020 11:38:25 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kDpdwGxV54JzJsiyV5kEfoYrZ8xkfViF7N41Ph2L6IyLV8feibN9CbxCVyrd3UElSGLEG9TPnDWS/wD+8p0MigsEioWdqKUT9vNVTWjmfkWUDY6lDB4oQ8e9kYF2WBg5+EdKWCVLqElQN6Ti9qT3WoODqShdbJAEa1RIe/bj7tRGN1TEPyUV+R30Cnl2vRW3NtRWMhCZANnyaU7wBDdlhbD195XJUhR0wyaAbWwgF987UvyzEIS6WhrIbQGbI3o8QOsyt/9Fi9x2voJQ+M7YMvziWO53/97mB5w8m17v8NNsD+7MtiFbA36s8F6TcScQr1cGlw4yjE/QDoDpwNjPSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TJA6n1LvNVbCfXajAQ/9ndloCamww6aG5jBjDI8ifaI=;
 b=OrIwngewVxrFBbVuVamw5cBPKMIt4N6G4CTBIHvUYC9Np2N0M7VqbzIN1HEt/Ke4vnZ1rsAK2QVpxP4EeqxmZcblGQd+mWkVzlZPQLJdKDG9mPvQcCH85j8TSWmeRxBD8yyDsATP+5DahopX7t9PQx6w6oocBVG42FGByfCc9vVXrWGPdJoSi5Uov8WlBb20nWVeAhr1kUfJH2fE0p7x80SB21b8sl3nAvzv620ctPtTgmEAxb2nYdXF3y0YWjunjvc39TGGbcvfvBEhTn9srn6rj+n2itRxRo7AGZagboYcCXgCxbsrkVMhyNF9HYfIP5ohNTYq4CeDbSNcrgHqNA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TJA6n1LvNVbCfXajAQ/9ndloCamww6aG5jBjDI8ifaI=;
 b=mxMn9qDgNChxfuBlAeeuHGCzL/SH/fLo5UlTColOwqesnWrk3dmQyLfCEew2zk0cPGozj27U2zBTXlnn1HuMUGCl+zcVogTFJDV3d3/cmdwOR3Akggdw5nhYSGTEB/ynN/cUyh5GdwZqTXc1lBl5TIZ4STi3YxnDp1hoQRKiBZo=
Received: from DM5PR12MB1276.namprd12.prod.outlook.com (2603:10b6:3:79::18) by
 DM5PR12MB1642.namprd12.prod.outlook.com (2603:10b6:4:7::15) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2900.15; Wed, 15 Apr 2020 18:38:24 +0000
Received: from DM5PR12MB1276.namprd12.prod.outlook.com
 ([fe80::cd06:6b04:8f2c:157e]) by DM5PR12MB1276.namprd12.prod.outlook.com
 ([fe80::cd06:6b04:8f2c:157e%10]) with mapi id 15.20.2900.028; Wed, 15 Apr
 2020 18:38:24 +0000
From:   Gustavo Pimentel <Gustavo.Pimentel@synopsys.com>
To:     Alan Mikhak <alan.mikhak@sifive.com>,
        "dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "dan.j.williams@intel.com" <dan.j.williams@intel.com>,
        "vkoul@kernel.org" <vkoul@kernel.org>,
        "kishon@ti.com" <kishon@ti.com>,
        "paul.walmsley@sifive.com" <paul.walmsley@sifive.com>
Subject: RE: [PATCH v2] dmaengine: dw-edma: Decouple dw-edma-core.c from
 struct pci_dev
Thread-Topic: [PATCH v2] dmaengine: dw-edma: Decouple dw-edma-core.c from
 struct pci_dev
Thread-Index: AQHWE0sygCutMVZpvUOHmfmKj/MAvah6g1/Q
Date:   Wed, 15 Apr 2020 18:38:24 +0000
Message-ID: <DM5PR12MB1276AB2E9CC1DAF2869B23EDDADB0@DM5PR12MB1276.namprd12.prod.outlook.com>
References: <1586971629-30196-1-git-send-email-alan.mikhak@sifive.com>
In-Reply-To: <1586971629-30196-1-git-send-email-alan.mikhak@sifive.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: =?us-ascii?Q?PG1ldGE+PGF0IG5tPSJib2R5LnR4dCIgcD0iYzpcdXNlcnNcZ3VzdGF2b1xh?=
 =?us-ascii?Q?cHBkYXRhXHJvYW1pbmdcMDlkODQ5YjYtMzJkMy00YTQwLTg1ZWUtNmI4NGJh?=
 =?us-ascii?Q?MjllMzViXG1zZ3NcbXNnLTQ3Yzc3MGU5LTdmNDgtMTFlYS05OGE3LWY4OTRj?=
 =?us-ascii?Q?MjczODA0MlxhbWUtdGVzdFw0N2M3NzBlYi03ZjQ4LTExZWEtOThhNy1mODk0?=
 =?us-ascii?Q?YzI3MzgwNDJib2R5LnR4dCIgc3o9IjYyNTQiIHQ9IjEzMjMxNDQ5NTAxNjk4?=
 =?us-ascii?Q?Njg0NiIgaD0ibHNROE1NU1czRkFVVG1RVWxpVE0yalg2Y2d3PSIgaWQ9IiIg?=
 =?us-ascii?Q?Ymw9IjAiIGJvPSIxIiBjaT0iY0FBQUFFUkhVMVJTUlVGTkNnVUFBQlFKQUFE?=
 =?us-ascii?Q?ZWFCOEtWUlBXQWJhcVpzTXFTQ2trdHFwbXd5cElLU1FPQUFBQUFBQUFBQUFB?=
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
x-ms-office365-filtering-correlation-id: 591c5830-3f18-46b8-5076-08d7e16c2e26
x-ms-traffictypediagnostic: DM5PR12MB1642:
x-microsoft-antispam-prvs: <DM5PR12MB1642DF861FB60A365368D962DADB0@DM5PR12MB1642.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6430;
x-forefront-prvs: 0374433C81
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR12MB1276.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(10019020)(346002)(376002)(366004)(136003)(396003)(39860400002)(6506007)(8936002)(9686003)(66446008)(64756008)(53546011)(8676002)(66476007)(55016002)(66946007)(52536014)(478600001)(66556008)(110136005)(81156014)(2906002)(316002)(71200400001)(5660300002)(86362001)(186003)(33656002)(76116006)(26005)(7696005);DIR:OUT;SFP:1102;
received-spf: None (protection.outlook.com: synopsys.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: RI7wqY55bOfFzj89MXK4pOmA9MzHoRnaj3cCjFXuse55aFQCd5tePJaqKI67sLjzCVjVwu0GVec3I2xhRCRYfbiUCEox7bwVEr9tSQxZMbGMgZHxSE4jCz3/w8BGVoqrt59Z5wsLnOcUOkWzRrEAaSjN8nkwz0MfaFJrTPA1VFIidCKeXPKkUmsKalVMgkmBj1cH88cW/ePPqnPQ5Qm8oXmuWDJ6f/JK7uTqAf4mXVS6OtGTeP8MQ5w+exbEnFuVBm6xDPA43hRjEWIZfOuKl2CXZCBoSk14vt6JxSBy8zYJXHLjq3bRNsZAD0dfUFKuvPa4MXCvKYjJihZqHyEOc+kcsp63HfF7Vvu3BCt7AvhX7QRRPnt0+Se8VkNQWOvjLMwRhaAspOWgCtHspWeiUD2y7iatjTn2zOdTDyFME8c080IL+r+KoaXINAlJLCLR
x-ms-exchange-antispam-messagedata: seCBHpc3osZjKi+pQ7AQbD7HahFd7t49KJroT2pz/ytESum46RFCjQQMJ9DQMg6OE3s0Q6AE0qulosEz2pWcuqIIRiTbD0JjYqbLMIN4bVzrJJlB2hiAofh/mWjIvlykr2qqISxJ5RdidjFMYJLKvw==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 591c5830-3f18-46b8-5076-08d7e16c2e26
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Apr 2020 18:38:24.1705
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4bji8NdAtkF+O606dxVV12qZrQUwfR6E+P9qvGEkw3z82Q1XN5bkntIa6x0R3+rdSbwraRI9dbXyLAIIgnkbTg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1642
X-OriginatorOrg: synopsys.com
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Wed, Apr 15, 2020 at 18:27:9, Alan Mikhak <alan.mikhak@sifive.com>=20
wrote:

> From: Alan Mikhak <alan.mikhak@sifive.com>
>=20
> Decouple dw-edma-core.c from struct pci_dev as a step toward integration
> of dw-edma with pci-epf-test so the latter can initiate dma operations
> locally from the endpoint side. A barrier to such integration is the
> dependency of dw_edma_probe() and other functions in dw-edma-core.c on
> struct pci_dev.
>=20
> The Synopsys DesignWare dw-edma driver was designed to run on host side
> of PCIe link to initiate DMA operations remotely using eDMA channels of
> PCIe controller on the endpoint side. This can be inferred from seeing
> that dw-edma uses struct pci_dev and accesses hardware registers of dma
> channels across the bus using BAR0 and BAR2.
>=20
> The ops field of struct dw_edma in dw-edma-core.h is currenty undefined:
>=20
> const struct dw_edma_core_ops   *ops;
>=20
> However, the kernel builds without failure even when dw-edma driver is
> enabled. Instead of removing the currently undefined and usued ops field,
> define struct dw_edma_core_ops and use the ops field to decouple
> dw-edma-core.c from struct pci_dev.
>=20
> Signed-off-by: Alan Mikhak <alan.mikhak@sifive.com>
> ---
>  drivers/dma/dw-edma/dw-edma-core.c | 29 ++++++++++++++++++++---------
>  drivers/dma/dw-edma/dw-edma-core.h |  4 ++++
>  drivers/dma/dw-edma/dw-edma-pcie.c | 10 ++++++++++
>  3 files changed, 34 insertions(+), 9 deletions(-)
>=20
> diff --git a/drivers/dma/dw-edma/dw-edma-core.c b/drivers/dma/dw-edma/dw-=
edma-core.c
> index ff392c01bad1..db401eb11322 100644
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
> @@ -827,12 +827,23 @@ static int dw_edma_irq_request(struct dw_edma_chip =
*chip,
> =20
>  int dw_edma_probe(struct dw_edma_chip *chip)
>  {
> -	struct device *dev =3D chip->dev;
> -	struct dw_edma *dw =3D chip->dw;
> +	struct device *dev;
> +	struct dw_edma *dw;
>  	u32 wr_alloc =3D 0;
>  	u32 rd_alloc =3D 0;
>  	int i, err;
> =20
> +	if (!chip)
> +		return -EINVAL;
> +
> +	dev =3D chip->dev;
> +	if (!dev)
> +		return -EINVAL;
> +
> +	dw =3D chip->dw;
> +	if (!dw || !dw->irq || !dw->ops || !dw->ops->irq_vector)
> +		return -EINVAL;
> +
>  	raw_spin_lock_init(&dw->lock);
> =20
>  	/* Find out how many write channels are supported by hardware */
> @@ -884,7 +895,7 @@ int dw_edma_probe(struct dw_edma_chip *chip)
> =20
>  err_irq_free:
>  	for (i =3D (dw->nr_irqs - 1); i >=3D 0; i--)
> -		free_irq(pci_irq_vector(to_pci_dev(dev), i), &dw->irq[i]);
> +		free_irq(dw->ops->irq_vector(dev, i), &dw->irq[i]);
> =20
>  	dw->nr_irqs =3D 0;
> =20
> @@ -904,7 +915,7 @@ int dw_edma_remove(struct dw_edma_chip *chip)
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


Acked-by: Gustavo Pimentel <gustavo.pimentel@synopsys.com>


