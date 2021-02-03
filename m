Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BA7FE30D5F7
	for <lists+dmaengine@lfdr.de>; Wed,  3 Feb 2021 10:13:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232931AbhBCJMv (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 3 Feb 2021 04:12:51 -0500
Received: from smtprelay-out1.synopsys.com ([149.117.87.133]:47182 "EHLO
        smtprelay-out1.synopsys.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233265AbhBCJMQ (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 3 Feb 2021 04:12:16 -0500
Received: from mailhost.synopsys.com (us03-mailhost2.synopsys.com [10.4.17.18])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 6AA12C00C6;
        Wed,  3 Feb 2021 09:11:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1612343468; bh=cryPro2kc+CfDydnT+68iql2m4SLvavHqrkK0PR9r9E=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=ZtBuK8JvnK2dMobY8ZwJJBvO2YVDiJnvNYMs/Ip3LPjyJUg0zIhy96eB26+tjhhev
         tuGIBZ2KnKK4Ih0uaRiIhk8yYYla/sB7/UMf8qNU/TqlFFFvAmh3XdM/cGkDMa5rVK
         fyITz9YWYMl00ZikSrVYAe2g/dAVen52Qsfepd1DwkZL4WgdQlzVhoGcD5VvV7ADBG
         bn0jKfdVo5KfEakXflTOIhDetExTTesGIKAV9G2K1T6G5kUD/U3FiYqJkY5WvrUnTb
         jiQ5A8O8nUcjHCMDrtdVrELiIxiOljtR/PB/HaYJIRuhtYJKLi+ZM9U6CnVcaGOkdg
         j3HRuwyxlCEoA==
Received: from o365relay-in.synopsys.com (sv2-o365relay1.synopsys.com [10.202.1.137])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by mailhost.synopsys.com (Postfix) with ESMTPS id 68CE4A0084;
        Wed,  3 Feb 2021 09:11:06 +0000 (UTC)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02lp2059.outbound.protection.outlook.com [104.47.36.59])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "mail.protection.outlook.com", Issuer "GlobalSign Organization Validation CA - SHA256 - G3" (verified OK))
        by o365relay-in.synopsys.com (Postfix) with ESMTPS id 06091400E7;
        Wed,  3 Feb 2021 09:11:05 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=gustavo@synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
        dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.b="knMEHIP1";
        dkim-atps=neutral
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FuXpNPcDu79c5TrPJYPzdETavmYguIXXhRtaX5uEAGKzThcepvIiUsQmaI98tw5AcVRdsIHfr2S1wMefRiaMvUqPOnw4T28LkhQL+QueFX9mHYP6aDmTPXK6G3FQ6UJxplL/fhAwZZ8CwQ1shJ3mu99nX20s1H/zrn2FKKvzMazwca51uyhnPWBxwG2SLt0QqEYJe1TdURUHq6ekA2jtuok+5KpC0lilfEdMjoqIwGx4/mtx1MCA2U7ETbXBJa+H1UVi6eKhOwzjg6Pe8BXCGPel+iGoewAMvKKnRLnfSL0zEH8l+NgBPvvmbgOJ5bYuEFHvdSDMN0WzlGK/mN3WEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rZIuAPyVOJE1Do/7ClKRyAK0snh/bnw3l8/yUmxelF4=;
 b=MxCDB0UteO6ywOV95Cy0/QPK3PGdBg4V9pJs2yC0Aww8g3C0v0oeWFVhlzGktjHDMSdCODTgERTl3v2f8Ffu/oE4r1k8Fr/j0If4QdE1rGDfoMPN36ssrVsKGrHP2JAU8sC0Sh6s3UdUaazfieqhXkRL0BrbT57dotScPJ52oQH9U/thEOo+tuwwpEwnzZlZI35BB+AiSh2eMpMvOSBw8FmbEV6csXkcWdZWTZYDva9AChWhYofv11UP/GOrYDfukYTvjtudY8FXvg1aGP4gsOTet+jFHAT2VXKCV8Pr77Ylgb4eRf4/uCzoJsSJXQ5ZLWXX52qUtAE+CGVjC/9V+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rZIuAPyVOJE1Do/7ClKRyAK0snh/bnw3l8/yUmxelF4=;
 b=knMEHIP1TbuWlbDsCVezz7/pyXycLUY8ylDuCprFB+f2MwmjXGZSlE0Hr4hcdI/wuS7jdZ5Sxo+p5yO3rWFgPPzZ2tgrzDFcrbGfNNzGJfn50OBeGSgI5oVjiqtv1ybACynXb1iP5JPd5vLLB6sPzH1reRBUeY5AP0W68GIg3+s=
Received: from DM5PR12MB1835.namprd12.prod.outlook.com (2603:10b6:3:10c::9) by
 DM6PR12MB2985.namprd12.prod.outlook.com (2603:10b6:5:116::18) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3805.22; Wed, 3 Feb 2021 09:11:03 +0000
Received: from DM5PR12MB1835.namprd12.prod.outlook.com
 ([fe80::508b:bdb3:d353:9052]) by DM5PR12MB1835.namprd12.prod.outlook.com
 ([fe80::508b:bdb3:d353:9052%10]) with mapi id 15.20.3805.028; Wed, 3 Feb 2021
 09:11:03 +0000
X-SNPS-Relay: synopsys.com
From:   Gustavo Pimentel <Gustavo.Pimentel@synopsys.com>
To:     Lukas Wunner <lukas@wunner.de>
CC:     "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>
Subject: RE: [PATCH v2 04/15] PCI: Add pci_find_vsec_capability() to find a
 specific VSEC
Thread-Topic: [PATCH v2 04/15] PCI: Add pci_find_vsec_capability() to find a
 specific VSEC
Thread-Index: AQHW+WCk8KFoXO5U70eM77z8tv2kyapFKi6AgAB9hHCAAGgwgIAAFE4Q
Date:   Wed, 3 Feb 2021 09:11:03 +0000
Message-ID: <DM5PR12MB183576159AF458EE007149D1DAB49@DM5PR12MB1835.namprd12.prod.outlook.com>
References: <cover.1612269536.git.gustavo.pimentel@synopsys.com>
 <2ecb33dfee5dc05efc05de0731b0cb77bc246f54.1612269537.git.gustavo.pimentel@synopsys.com>
 <20210202180855.GA3571@wunner.de>
 <DM5PR12MB18351689BA7312BF9DFDD6FEDAB49@DM5PR12MB1835.namprd12.prod.outlook.com>
 <20210203075103.GA18742@wunner.de>
In-Reply-To: <20210203075103.GA18742@wunner.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: =?us-ascii?Q?PG1ldGE+PGF0IG5tPSJib2R5LnR4dCIgcD0iYzpcdXNlcnNcZ3VzdGF2b1xh?=
 =?us-ascii?Q?cHBkYXRhXHJvYW1pbmdcMDlkODQ5YjYtMzJkMy00YTQwLTg1ZWUtNmI4NGJh?=
 =?us-ascii?Q?MjllMzViXG1zZ3NcbXNnLWJiMTQ3N2EyLTY1ZmYtMTFlYi05OGU2LWY4OTRj?=
 =?us-ascii?Q?MjczODA0MlxhbWUtdGVzdFxiYjE0NzdhMy02NWZmLTExZWItOThlNi1mODk0?=
 =?us-ascii?Q?YzI3MzgwNDJib2R5LnR4dCIgc3o9IjE2MzgiIHQ9IjEzMjU2ODE3MDYwNzUy?=
 =?us-ascii?Q?Nzk0MyIgaD0iSXovOVVmYXFvalQ3TzE2ZEl2UmVaVkdDVFk0PSIgaWQ9IiIg?=
 =?us-ascii?Q?Ymw9IjAiIGJvPSIxIiBjaT0iY0FBQUFFUkhVMVJTUlVGTkNnVUFBQlFKQUFB?=
 =?us-ascii?Q?SHlKVjlEUHJXQWF4N3B3NHY1OHdCckh1bkRpL256QUVPQUFBQUFBQUFBQUFB?=
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
authentication-results: wunner.de; dkim=none (message not signed)
 header.d=none;wunner.de; dmarc=none action=none header.from=synopsys.com;
x-originating-ip: [89.155.14.32]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a0f03034-497f-4eda-179f-08d8c823a18d
x-ms-traffictypediagnostic: DM6PR12MB2985:
x-microsoft-antispam-prvs: <DM6PR12MB29850068316DB5F164C41915DAB49@DM6PR12MB2985.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: S4v9qi2Ffy0dRk22IEF02a4phfTcXTp7PAZQHiJXjJKUt6X/XjKNvQOP2oa9xUDl9W+n7Qcgsw9j/8eqj00+nj4UqQv3DnCG4OXiDk32ItqKxopx9go3HibHeZBeSiO+J8EUmz2TDaD7zXkFSd/BDJ054oYlQUrQ2J9KHLgSFBwk9QLhRto3GfJpKRNK+PzhWpBPA/f1Hm6J8EdZAfpT+A3WcuYt6iFtNxxte6PbN5Vxzzytw8Gs8JGj0ryqxG3lvZovjhKmC/1jXpoukFxI5YTu4D3EUw1aQSuj2O2pylwQ8QQHsCN8mDhDqKbBDXVIyin/DGkuqrw6U4CRU2xb0rRBoyZfQNy3n8XeQ5sjlkEO43I0ESxN9AabQ6Syj5gX1iBqu6YyvI45dQpaKCSDDqkgJMLoJtKIwjWutV7OlAXnQW+/o8uiuYq+BBKtoZdXqts7lgDyOACNFoPxpM1grzEwJasyUuG0bhLAzhUdLkH0hONG/JDdG+gwKG/HmtlFmk9gd3N40XHwc3ugRyDLcSDW1PLf8jLjVSsndUxnpEcdimzyoDYT9cDhms4ABvtN
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR12MB1835.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(39850400004)(396003)(366004)(376002)(346002)(136003)(66946007)(64756008)(186003)(2906002)(71200400001)(66556008)(9686003)(26005)(55016002)(478600001)(86362001)(4326008)(6506007)(7696005)(52536014)(54906003)(33656002)(316002)(66476007)(5660300002)(76116006)(8676002)(6916009)(53546011)(8936002)(66446008)(37363001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?eCoxeYLvs70Hb8LlwAfvcjYMx8WAW2Qu0xb9+U8srAYLHqTEKmVl6wtIXrPs?=
 =?us-ascii?Q?ZbNjXDsG5C4ix238KVafMNMkW35+j9OSGW0nb7HELydXsJ72c3TxlcquJit7?=
 =?us-ascii?Q?JQKhcVuRh/xYZJ3rqAaZZXXf/syt4QnDZc3UnlPYtrFSKvf4KxWRw0tfKta5?=
 =?us-ascii?Q?JxUIY62AcnDlQIfLoJwxkkvuaeZcIlwHOIUCrwygfZgl6EJuFWudujGqafBQ?=
 =?us-ascii?Q?Se6iEgpBUzh/MHJwYubpfK974l0kpLKuM2ruZdnf1o/RZBAJ5F3IL77fFeuh?=
 =?us-ascii?Q?j8uqQcUTj4YhJfELXOL/Bn5V6tI0qh0MQGADn9HZumyz3Q8RaPVwFQN6GAr9?=
 =?us-ascii?Q?DnpZP8lWLSZK8EWSY6On5xMruh8euBTr6fRPHEJqBVyviM5F7zCMq4bUps3P?=
 =?us-ascii?Q?xq7MEJUrE8a99P6ps18+rgHoyRWSIchp7sYDsVATaxPaMtA69I10uNGE3kA6?=
 =?us-ascii?Q?U0ysX8NASFJYAQIB4PT2nEIlcKnP5ZE61hKyBtgIojPPzTQjL86ya+WUslC+?=
 =?us-ascii?Q?oHjMJNxf60BJPc0ryQKds3ps6+sFa5MNUFVXwVtF/cPpaj/VuQqmZxIY4t4S?=
 =?us-ascii?Q?2icPRoxihFOTq7fxcqBeiRIAmIBN/EKT/nVYg+Cm/VAcFuJBdS/jnAWqEx+n?=
 =?us-ascii?Q?obs45jcXpKpLeRLst0vtKGBkmcA/2JLpdd5hN5jJ/uy+kAdV7ZTvtKGgnQEn?=
 =?us-ascii?Q?I1ow1hLPx3B/rgNnAoN9adX+iNzzWth3NA315I7DxvgalAwb4xyTTTTdjONO?=
 =?us-ascii?Q?gvbyb8ujDBOzBij/D6EAy24Ra4BTGOorSIG13H3H08CqoJfJyQ+CpYjbU/5G?=
 =?us-ascii?Q?2bGZcogOSspVwmYMpqpL6IzJ8pjyJMNymjQ1zxQ5Y9wIoUJn5eUg08qPCYDb?=
 =?us-ascii?Q?8kBWnhLtFPUzGXeXjScur3Pos74r6uDafSs0RnHH5SYlFC0jqawoyOIzmLy9?=
 =?us-ascii?Q?LuJ/hUDZPr/oKNBYNi7JrTPOPT/NB/BBqqiOZM0E+bvjdrulQsN6/7aDwBhU?=
 =?us-ascii?Q?nIPuiiyjtLPc7FkQ3e59kB54yXnQDRpEFZ/GzzppGoCi5uCtqjKcfCjIjuou?=
 =?us-ascii?Q?nA0W+YIk?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB1835.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a0f03034-497f-4eda-179f-08d8c823a18d
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Feb 2021 09:11:03.1374
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: I5ec4qmJHOfMpG0A62pXZSS3ek7suIuEvW8ByTPXjIKyW3GsvkMHUlarTWmaDPtaPKTCgysF/4Dpir1C4mDE8Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB2985
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Wed, Feb 3, 2021 at 7:51:3, Lukas Wunner <lukas@wunner.de> wrote:

> On Wed, Feb 03, 2021 at 01:54:49AM +0000, Gustavo Pimentel wrote:
> > On Tue, Feb 2, 2021 at 18:8:55, Lukas Wunner <lukas@wunner.de> wrote:
> > > As the name implies, the capability is "vendor-specific", so it is
> > > perfectly possible that two vendors use the same VSEC ID for differen=
t
> > > things.
> > >=20
> > > To make sure you're looking for the right capability, you need to pas=
s
> > > a u16 vendor into this function and bail out if dev->vendor is differ=
ent.
> >=20
> > This function will be called by the driver that will pass the correct=20
> > device which will be already pointing to the config space associated wi=
th=20
> > the endpoint for instance. Because the driver is already attached to th=
e=20
> > endpoint through the vendor ID and device ID specified, there is no nee=
d=20
> > to do that validation, it will be redundant.
>=20
> Okay.  Please amend the kernel-doc to make it explicit that it's the
> caller's responsibility to check the vendor ID.

I don't think that would be necessary, as I said, the 'struct pci_dev *'=20
already points exclusively for the device' config space, which contains=20
all the capabilities for that particular device by his turn will be=20
attached to a specific driver by the Vendor and Device IDs to a specific=20
driver, that will know, firstly search for the specific device vendor ID,=20
 and then secondly how to decode it, and thirdly to do something with it.

>=20
> Thanks,
>=20
> Lukas


