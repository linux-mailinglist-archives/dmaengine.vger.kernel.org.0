Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 163D630BE23
	for <lists+dmaengine@lfdr.de>; Tue,  2 Feb 2021 13:27:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230229AbhBBM0q (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 2 Feb 2021 07:26:46 -0500
Received: from smtprelay-out1.synopsys.com ([149.117.73.133]:43628 "EHLO
        smtprelay-out1.synopsys.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229894AbhBBM0o (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 2 Feb 2021 07:26:44 -0500
Received: from mailhost.synopsys.com (badc-mailhost1.synopsys.com [10.192.0.17])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id A15DE400DF;
        Tue,  2 Feb 2021 12:25:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1612268743; bh=HW9wy6PngnK7sRbaLoIZV4zWgtGAt0U5y3bew6HwPsE=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=DM7vXb4T7i3R3rzfGXZzraLytMgYTnj3d8AtksJcx1kH9Taln3UeP/BIZtM9wLS6Y
         TUngwjnshRPNSWSWXUXzWsf4yXG22iHkwihLhDkQoDSkxZ7Yqj0/T2g/GYKrycg+3P
         AZwvn2ixIia8I/wP+d3EWpIaT3TD+p7iq6BezKbQo3y/mGqzOlLtUxel7nQhlZH5Xu
         d3sw6SmQfGxzADZ68I1sPFb7Q3VOL7Q/CHeTzaFvCaNDfxAI6hQ82O60k82gWZBQPs
         m8xgzmV4mxYa8UQxJSjXA74MX0C2u6Lm4efsU6JMJb1LmITtR6IY5hnx/oVa0nW/K+
         PREoHTqserpCA==
Received: from o365relay-in.synopsys.com (us03-o365relay3.synopsys.com [10.4.161.139])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by mailhost.synopsys.com (Postfix) with ESMTPS id 3F165A0071;
        Tue,  2 Feb 2021 12:25:43 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2049.outbound.protection.outlook.com [104.47.66.49])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "mail.protection.outlook.com", Issuer "GlobalSign Organization Validation CA - SHA256 - G3" (verified OK))
        by o365relay-in.synopsys.com (Postfix) with ESMTPS id BD86480064;
        Tue,  2 Feb 2021 12:25:42 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=gustavo@synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
        dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.b="Lzr4+jQI";
        dkim-atps=neutral
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gXUI2xfOqYpgYQVmZhuqJopvyxz88IjB6fBHCrj2lrnZfz7bn2vhZTAv/UKnL/7LTuV1t2rLqK3aLtMUthua9fpX7PD9+WdVceA6fq9HdGc5hzVtf8X6yjYyTZB7og8q+sd/znIWrmN5N9O7S/qcVsAFBWQQGoieNoQaZlAyVANcL32wLeApfwMJH0ud/bC42qa79Qd8MpBi0TdakhzbQhBr+ktzg/brLdFero1A/Fb483sS8WP3G91F5rKQpJt8GgI1U06U1hIuAadAhf7cMbfEH2RIN4SWNGhfjoNvousHn2dkYUdRjBFHu0l+6NssePZV1nrnK+8SeZFZcTpLhA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oU7R9p2MDjjcNkkbYonaoKRIhO1ONkOZ3tXAnqkmlu4=;
 b=FI+gBDsk+joUBPHFCRs/UpYAsFhosm6Yz1zg/hIOBpjkt2PPO0Iy3z9RhIs4aK0rOWQFi6dX8eAKzkGYMKkmQ7CaUKTPuHGFwgcYSRtzyOEPrL9HLCjJ0E3OH4cv3k7CbYebJxrpQpfIwnf3/1MZtRs6798Nws/1CJQb4eE1623xC5HMedNueSj+7otXsbC/vV4ZZw4YNdGRVJi5W6Rc83n5NQRodSnDHKHWruJIhPJl8L6iSahDvjDhrr+QWEP+O4sXCa7M6XcMtfMiYy2MzPVkulKgpaR9QEuXgR7CNtqip6RaYpmeXss2dWdXwumdXOz0jd6oARV0TSAXgEHm0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oU7R9p2MDjjcNkkbYonaoKRIhO1ONkOZ3tXAnqkmlu4=;
 b=Lzr4+jQIlVS0ZbURDkEEVQu2pBIvcbp+gfePh3TalZy7JaFmLN7URWCxZmPMGS/QVWNhvL+BcMR8jzhPGSEXBftX9dXfqPkwjmy4dnpmBCOuuIad9sSxQZvIB7SBqZBPv0k+egqu1raPkyurB248zK8A4OIUz3d/r8WHFYeYnJM=
Received: from DM5PR12MB1835.namprd12.prod.outlook.com (2603:10b6:3:10c::9) by
 DM6PR12MB4959.namprd12.prod.outlook.com (2603:10b6:5:208::16) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3784.12; Tue, 2 Feb 2021 12:25:41 +0000
Received: from DM5PR12MB1835.namprd12.prod.outlook.com
 ([fe80::508b:bdb3:d353:9052]) by DM5PR12MB1835.namprd12.prod.outlook.com
 ([fe80::508b:bdb3:d353:9052%10]) with mapi id 15.20.3805.028; Tue, 2 Feb 2021
 12:25:40 +0000
X-SNPS-Relay: synopsys.com
From:   Gustavo Pimentel <Gustavo.Pimentel@synopsys.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
CC:     Bjorn Helgaas <bhelgaas@google.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Vinod Koul <vkoul@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        "dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>
Subject: RE: [PATCH 04/15] PCI: Add pci_find_vsec_capability() to find a
 specific VSEC
Thread-Topic: [PATCH 04/15] PCI: Add pci_find_vsec_capability() to find a
 specific VSEC
Thread-Index: AQHW0wgCezpmojE5/EuR7ILcRACll6pEMBkAgADkX9A=
Date:   Tue, 2 Feb 2021 12:25:40 +0000
Message-ID: <DM5PR12MB1835338C40DE5FF470EBD839DAB59@DM5PR12MB1835.namprd12.prod.outlook.com>
References: <cc4b62f333342df8e029b175079203cfe2bd095c.1608053262.git.gustavo.pimentel@synopsys.com>
 <20210201223920.GA46282@bjorn-Precision-5520>
In-Reply-To: <20210201223920.GA46282@bjorn-Precision-5520>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: =?us-ascii?Q?PG1ldGE+PGF0IG5tPSJib2R5LnR4dCIgcD0iYzpcdXNlcnNcZ3VzdGF2b1xh?=
 =?us-ascii?Q?cHBkYXRhXHJvYW1pbmdcMDlkODQ5YjYtMzJkMy00YTQwLTg1ZWUtNmI4NGJh?=
 =?us-ascii?Q?MjllMzViXG1zZ3NcbXNnLWMxMjAwNzljLTY1NTEtMTFlYi05OGU2LWY4OTRj?=
 =?us-ascii?Q?MjczODA0MlxhbWUtdGVzdFxjMTIwMDc5ZC02NTUxLTExZWItOThlNi1mODk0?=
 =?us-ascii?Q?YzI3MzgwNDJib2R5LnR4dCIgc3o9IjEwNDYiIHQ9IjEzMjU2NzQyMzM4MzY1?=
 =?us-ascii?Q?NTc2NyIgaD0iREJ1NXpsNEJzMlZrRS9NMG12S3NjeGdPaXE4PSIgaWQ9IiIg?=
 =?us-ascii?Q?Ymw9IjAiIGJvPSIxIiBjaT0iY0FBQUFFUkhVMVJTUlVGTkNnVUFBQlFKQUFC?=
 =?us-ascii?Q?WFZaS0RYdm5XQVRZTFpUOSs5U2dsTmd0bFAzNzFLQ1VPQUFBQUFBQUFBQUFB?=
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
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=synopsys.com;
x-originating-ip: [89.155.14.32]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 6c9e02d6-ed47-4bd5-b27f-08d8c775a779
x-ms-traffictypediagnostic: DM6PR12MB4959:
x-microsoft-antispam-prvs: <DM6PR12MB49591B77F1071940DBFB8DEADAB59@DM6PR12MB4959.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: weGy/3dUULA2iVhv0uIQKneMZumE0Z7fAKOXOStQCwPIwKI7a01yqWKhyG74kRCHeQAMneOt9kmwSF/gl1UegaCZTybMm5aIN6HuHATPu3VphuJiE1UMJ16sKZHArYsLxYgclAH/kBid5hKoLBx1wxC2DZLAfZofN088PQBkO/QC/GeD3Zct+BOcPLljOertHBtyLAbZS8uc/+ZOBZrZeKR6mH2ub8i9FSfW9oqkRg3Kfa4OCPRu4k0p8cvsHINv6ZIQCEcY3gRP6+vmJhXthjv0vnrFPsa+hpMxpQ7N0me5nkpiVBrU16fj1MvdKynds+pfXFqXDBfnuJo3QKdoA+0XZsxL3d6bpVHR856aB70GOkkL6eLrApUc/KWcu/Bg1ai8oaMHg7UuO+gi+rgFr0hfHbPOs+D/+kLRa8WVSH7dHqjuPBmgC2KXPg8kOiJCpOhbhUX+P7vTNLRP+wFiL2W9XM/F7KZS36hWvOk0Mya4TwnJ6Pt8Y/ExZrgVhfNaPbfvOOKrGnVwa88rv6AvblIlIIsjypP6eh14SftML6K3Ef/09FB/Obj/7Mdp8t7F
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR12MB1835.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(39860400002)(396003)(346002)(376002)(136003)(366004)(66476007)(76116006)(64756008)(66946007)(66556008)(66446008)(26005)(6506007)(52536014)(316002)(53546011)(2906002)(86362001)(8936002)(4744005)(33656002)(478600001)(186003)(7696005)(55016002)(6916009)(71200400001)(8676002)(54906003)(4326008)(83380400001)(9686003)(5660300002)(37363001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?G5a/qoWkXGcDkmnUzK+HcZQFUs3fiM1oIUOOjV0MypEW6eLyRMeGj4l2tG/z?=
 =?us-ascii?Q?LmLF9LgfVGP53Cf2G7seFi3v4ux95e5QXgvGcutTlvjzrWOw5f3fgl2zpCpk?=
 =?us-ascii?Q?sIOqNX2JW7a5dhcui3cYko6k5sXJw/2JPKEzDOnlZNofRb0lBwbxjsc93kxN?=
 =?us-ascii?Q?aiJ1wRYXZTTwfYF5yj8F6f/b9ixb0uYFM+0cZDRI4X8EG/KpyI8FqSPwzfAW?=
 =?us-ascii?Q?kg32VOdK4pCgy4yufXVhw2BJwU8ybPlS5izG/pbo6yIzwS1Xshh0Txh9sq0H?=
 =?us-ascii?Q?BWrjrf79YubldaQiQFe9x8N688Ta/+9MDNkvj5Kw78B1PqJGOfkieo3fZNGp?=
 =?us-ascii?Q?NDtFIvOE7kVRXZMgOuSGWdTCUe51ocl5TtlDDc0C3zQxum71xQ39KP0Elj9y?=
 =?us-ascii?Q?OFdJbU4fYQV2S2wZ+1+E2qr9Hxkj99S3LH+/mKMxqbR9AMD4jTBop152/1+d?=
 =?us-ascii?Q?uPdHT3smKFXqAzokrmPuNGKvJtsFeKJBnIX5xosbWTQpgE/sZjxDtHJWz1yU?=
 =?us-ascii?Q?aq3w3jOtCBjFMdlQjilatL+/FPyoT6zIHbLguygHELY4l+FO2VftmYliux5V?=
 =?us-ascii?Q?1qiNji200CxHLFxm753P3Fuj2jm0/eQspkpsXia1zPa8LY1MfeSQ95YXn4cp?=
 =?us-ascii?Q?ts8ACmobyfKVj1HQICBOiBVYaxx71hloSxjVQnc21OX1MdNKgiUYP5+rhjor?=
 =?us-ascii?Q?E9lK2KuWTthPbdhatTlebYZz5fLJryQTojLrVkurgUrgsQd/r2EUfpi9uk7P?=
 =?us-ascii?Q?SQ0IP73uJ+oNrONivBKmhJiyQm5SroXTA76qA1maZDMjl0iwmfYxuA9rbFkQ?=
 =?us-ascii?Q?KeUvzM3iEecLUKXsIiEHkMM4B2WoRLmFUAhYhySRVrCtkXBbqWSC/T2QMsYm?=
 =?us-ascii?Q?1QR4p4pc7e4eKXISteV3BE/R12WyVWq0QwAiVbDgZ4aO+0qyrBUg2YEdaLeb?=
 =?us-ascii?Q?dkXazp89wRwQR1tFK/IEG4teFkEVbpGu4tgVW6sen53e4CpscC2quh+2AXB1?=
 =?us-ascii?Q?7G2iBuPRc0fL90gKRrDfCmFQ4RiPHT5z3D03dW/z0F3cLt/T9N6vYIKzzmDy?=
 =?us-ascii?Q?IyLY5Xg7?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB1835.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6c9e02d6-ed47-4bd5-b27f-08d8c775a779
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Feb 2021 12:25:40.6637
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: QqDxk1VR5JvCC+7AFes6IVwFvlU3eYwg5MKL77lUvXyqSCNyAMDUJlp6lJjEvYthRhuueGIFGj2N0oKi4NDS/A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4959
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Mon, Feb 1, 2021 at 22:39:20, Bjorn Helgaas <helgaas@kernel.org>=20
wrote:

Hi Bjorn,

> > +/**
> > + * pci_find_vsec_capability - Find a vendor-specific extended capabili=
ty
> > + * @dev: PCI device to query
> > + * @cap: vendor-specific capability id code
>=20
> s/id/ID/

I will do it for all the requested changes.

> > =20
> > +/* Vendor-Specific Extended Capabilities */
> > +#define PCI_VSEC_CAP_ID(header)		(header & 0x0000ffff)
> > +#define PCI_VSEC_CAP_REV(header)	((header >> 16) & 0xf)
> > +#define PCI_VSEC_CAP_LEN(header)	((header >> 20) & 0xffc)
>=20
> Please put these next to the existing PCI_VSEC_HDR.

I will move it next to HDR. The 0xffc was a typo, thanks for noticing it.
About the PCI_VSEC_CAP_REV and PCI_VSEC_CAP_LEN macros, I will be using=20
on dw_edma_pcie_get_vsec_dma_data() from dw-edma-pcie.c has a validation=20
of the right DVSEC.

I will send a version 2 with those fixes.

-Gustavo
