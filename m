Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 351E630D11B
	for <lists+dmaengine@lfdr.de>; Wed,  3 Feb 2021 02:56:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230083AbhBCBz5 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 2 Feb 2021 20:55:57 -0500
Received: from smtprelay-out1.synopsys.com ([149.117.73.133]:44636 "EHLO
        smtprelay-out1.synopsys.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229696AbhBCBz4 (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 2 Feb 2021 20:55:56 -0500
Received: from mailhost.synopsys.com (badc-mailhost4.synopsys.com [10.192.0.82])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id C3FC6400E6;
        Wed,  3 Feb 2021 01:54:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1612317295; bh=tIS4xwqj2Ua+iS73M+HCWfU6zZlhKz7aA0KcQ66Ip6E=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=iI+hBgV9fC7yBlmhNTEOhF4mxbLs9l/Qr9xhm6tBEV5IUImggYyNYCZX7dGlMrAYs
         9W688y+3SBbAgV5BaeFzarB8l37aP0rKC4/MJ21jBhPl7PEV4FnNVTjnlHYA2uxcqs
         plY7CFi8sasB+8ffxDqriTrpElKLdevhRjpzLC9xheaPUEAiTWm1CEL5Rrxq9eoKsF
         x0WqD82gtWMa9tvn99AfhtBM5TzhEMK3pyI/ZUL0gt7gmPuiVQjiI3fkiqe+yHaQV/
         WInjDbeX2AP8JoT10KKhhePQH6omLLcW0KSvpz7GTZCCTFu7qRpdVGXoplQ48jSAnZ
         b4JMJTyu3CEVg==
Received: from o365relay-in.synopsys.com (sv2-o365relay1.synopsys.com [10.202.1.137])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by mailhost.synopsys.com (Postfix) with ESMTPS id AD751A005E;
        Wed,  3 Feb 2021 01:54:53 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2042.outbound.protection.outlook.com [104.47.66.42])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "mail.protection.outlook.com", Issuer "GlobalSign Organization Validation CA - SHA256 - G3" (verified OK))
        by o365relay-in.synopsys.com (Postfix) with ESMTPS id 1A578400E7;
        Wed,  3 Feb 2021 01:54:52 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=gustavo@synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
        dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.b="dC7vxXyI";
        dkim-atps=neutral
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BaSdKF1JCJEUxUy+WF6oON+KYNi6U81sg9PIYIGBvch6VQUx2PVv/GZw34PuYLQw5uSZlwHciI5dAWf3QTSS3AiTF/RJqH+7zvz8hGU5B2y3NYhhtO7pdndq9V9BxXx9oXenQcI4RoL5yssvm+dUexkVSNjOG68kQYeNT64dtbZSfTw9YD00gYXWUmfvHLglSZsl7EHKrjw4pnaCQZvDLcWfQ4+v0zxvnMcN4+ybalgpspo2egOIkvDt7FHLz+HptZl17Ot3Ec9seDi9VEYJMPWhyeiwfg7Mowwkw64RfzZ1fNCy1UbJO++e2XNOQR6cRncTMZLnQM10wbJqJPgAMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=U0lWd9ozdJuPnR0iysZaXTi+x5wfPm7sESs1IcwfT4Y=;
 b=Mq13fawROoz01N6gpXtJ6GWz2fpBDj0BXB69ANWx7MdW5AlqqMf6In+1laPj350yEINfYT/QWeBNjCRYYXOeDDemi+M6MrTXvpbXcE1KqyY/L2P2Ehf7D/WAG4m0xP8fVx7Ax5RWE6lFiJeyCkWg46ztmzFE0rj5tMJhMwOlmwYj1hHB8tr1JHu6fdQAxnioemd5bTJxG/xUm7Y+OU5m7glh+5xu4i+rqBVlvdEb/woS2yhvQtbcCKS7tCOWm3GUXymOUIoNHFLL3LIyjGA8v1AL5qNbZnCGFBysEQKfisFJQe9ZHl64B+lJyaKqb1MxCcO6y6Nvd53ZV1L1G5uQ2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=U0lWd9ozdJuPnR0iysZaXTi+x5wfPm7sESs1IcwfT4Y=;
 b=dC7vxXyIuJmoxPzByNsARYJYRpl7Cccma2azpRQbqS8W/sZYZHYSXJDl2MQlUkHv83OoJ5WENIKUuO4VeL9/thbKbQCWgpFlCrQyhAoowLkWk8SE67cLwh3BVSRve6kI6oiZGWJRx89OWzX+d7+TEmX8jsNMLbdhS161PGQlVVU=
Received: from DM5PR12MB1835.namprd12.prod.outlook.com (2603:10b6:3:10c::9) by
 DM6PR12MB4958.namprd12.prod.outlook.com (2603:10b6:5:20a::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3784.12; Wed, 3 Feb 2021 01:54:49 +0000
Received: from DM5PR12MB1835.namprd12.prod.outlook.com
 ([fe80::508b:bdb3:d353:9052]) by DM5PR12MB1835.namprd12.prod.outlook.com
 ([fe80::508b:bdb3:d353:9052%10]) with mapi id 15.20.3805.028; Wed, 3 Feb 2021
 01:54:49 +0000
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
Thread-Index: AQHW+WCk8KFoXO5U70eM77z8tv2kyapFKi6AgAB9hHA=
Date:   Wed, 3 Feb 2021 01:54:49 +0000
Message-ID: <DM5PR12MB18351689BA7312BF9DFDD6FEDAB49@DM5PR12MB1835.namprd12.prod.outlook.com>
References: <cover.1612269536.git.gustavo.pimentel@synopsys.com>
 <2ecb33dfee5dc05efc05de0731b0cb77bc246f54.1612269537.git.gustavo.pimentel@synopsys.com>
 <20210202180855.GA3571@wunner.de>
In-Reply-To: <20210202180855.GA3571@wunner.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: =?us-ascii?Q?PG1ldGE+PGF0IG5tPSJib2R5LnR4dCIgcD0iYzpcdXNlcnNcZ3VzdGF2b1xh?=
 =?us-ascii?Q?cHBkYXRhXHJvYW1pbmdcMDlkODQ5YjYtMzJkMy00YTQwLTg1ZWUtNmI4NGJh?=
 =?us-ascii?Q?MjllMzViXG1zZ3NcbXNnLWNhMDRhZTUwLTY1YzItMTFlYi05OGU2LWY4OTRj?=
 =?us-ascii?Q?MjczODA0MlxhbWUtdGVzdFxjYTA0YWU1MS02NWMyLTExZWItOThlNi1mODk0?=
 =?us-ascii?Q?YzI3MzgwNDJib2R5LnR4dCIgc3o9IjIxNzUiIHQ9IjEzMjU2NzkwODg2NTY3?=
 =?us-ascii?Q?MzUxNyIgaD0iUElUS1dxMXRmWDVQd0RaS1RpTnZzMGJDUktVPSIgaWQ9IiIg?=
 =?us-ascii?Q?Ymw9IjAiIGJvPSIxIiBjaT0iY0FBQUFFUkhVMVJTUlVGTkNnVUFBQlFKQUFB?=
 =?us-ascii?Q?dENZNk16L25XQWF5RHFNSVhsS01vcklPb3doZVVveWdPQUFBQUFBQUFBQUFB?=
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
x-originating-ip: [198.182.37.200]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: be918cc4-0f41-44e9-ae27-08d8c7e6b0b3
x-ms-traffictypediagnostic: DM6PR12MB4958:
x-microsoft-antispam-prvs: <DM6PR12MB495881D77F9A4B2E6BD2F044DAB49@DM6PR12MB4958.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 1elaiNJZtjSpcAb4s+Qc49dAHeDdp5iBDUyw0hminuBWgdRWvomg/W9vqgmMxIInQV67P26pY/T0DRAape+jHkN0M5vNAMmy8j6xqFmZveA2KDoRO17Sx731BKLW+sTyWF/G9jdD84xwGTgx6SoIIZJ28SaZEp3iqgLDNBAvcUx55q3rv48a5LOi3Mj4lJORa8euP/zu9IMo8cbtGgpSfzHJdeuvgW3ATg+fk/ABTb+LGfHb++OfCrHOcmLtNfIzDD5LHbBlDaxgTQALqMq/Eab5Ka5kooKpdVq3t4tv/xGKwCJEIKO29Yi6HnYIcRe3LdtTahMkWqWy1rAEyRJjAEe/1WgZz5Cl5hqf+1oeqhNM+9qK5wB2aLnS+Gg02cygU+dR+zdnpRYtnbMyJ8vaHUoPh4LJgZpx85upwl5FqXVpRcRxIbky9DrRehcTFPZ9/R/+S4gGnLyQg3i4TEjfy481L5+gfzoa6Z7Iz2gNu520ELhOZ1MqqPzq9xrUatiWP2X2oIB6GCJ1iDUKNWJHrflG5zFpSMXYrdLiaAEu8ngvrcZnxskU1ukZaEkxzXv3
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR12MB1835.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(39860400002)(396003)(136003)(376002)(346002)(366004)(55016002)(6916009)(7696005)(9686003)(71200400001)(86362001)(186003)(8936002)(76116006)(54906003)(316002)(33656002)(66476007)(8676002)(83380400001)(6506007)(66446008)(64756008)(66946007)(66556008)(4326008)(5660300002)(53546011)(26005)(52536014)(478600001)(2906002)(37363001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?fek66dbql69clGOoZ2Z1FWqBIH+998Qvch+JCZgLI+qgY+e+pz8YsIaaBqWy?=
 =?us-ascii?Q?IBIKIG3uZLnG0QUu/X2e0bjZ5yUbEOhmRjPtYqehX5B6dHsx8P+Wb63UfXT5?=
 =?us-ascii?Q?nDz9Asxck1m+pBMdVkLCywbYepJ64jdulUgqrGkFk3fwe+0FoHh4gL4GOujg?=
 =?us-ascii?Q?O9mWOEaJpsfosldH1iQsjV0lAPvv8/Fx5fjQVV9vUnA4CoDFrs/CNG4Hwe+p?=
 =?us-ascii?Q?TNSWfV45WGowv2h1HoWFw71pVzTSqK6SDG3sLL1StyFZvaqhUd4KWhuR1VSo?=
 =?us-ascii?Q?1Shv+xZjNr61dIgNkM9vayIMMMmB4NZWfxhBajv20mDacpXfLYl3dsFqjs3X?=
 =?us-ascii?Q?VfCZwonaA0XzOqIzFkhqSQTIT6CFblUgAX0nKW9RMp/D7UIKrualVtFkPjQD?=
 =?us-ascii?Q?V3xGy4MdZnVfrHxDuIzRO+c4cc9YtPESWQe9LDYqOoOIVAbK4JJDYjCv6Xb7?=
 =?us-ascii?Q?nT1LT8LcNU1P4QUob5rpJnhmRzCGifGXWLtCdFu5ZC6xWSUDKjJuh4VwMidZ?=
 =?us-ascii?Q?Fzala6PhBFLDTVfJhwijqjY1QoAZe1/UAuYqDzhJGkGC12I3P26KWG4eCDib?=
 =?us-ascii?Q?i45cUcaiLCQqEeLIOsuTu9w7q9rnHrSe5kF7m54JmmtPYXGzpaKLTGrZP9Vm?=
 =?us-ascii?Q?jKPwBAxTYC30pCTGNSD8jWBe0lmCvySZf2Z3OjoEOmPZP6Bq5AePDILSNFMB?=
 =?us-ascii?Q?1LSb1r7jmnsOrQyNh3HDLZ+XaoIA9ZMYPpIwUtO0HARTredPPd02MWEg+q/O?=
 =?us-ascii?Q?KOpty4z8qLp5DYZPJ2GENlIEpPgvZwMjdsdZKT9JpqlTZYh2flzxgsD+ZrGI?=
 =?us-ascii?Q?y/Xc4uqr8UpnOMbRLJS/ToGlGnnLCytF4kmWwZDHq4+bmK5IQtiDOIkTw7Q4?=
 =?us-ascii?Q?4f2PJ/xkokalPVETqgQShPs2mdOc01Gh2dhmsc5qJPPglziMkYQjb0to9+ks?=
 =?us-ascii?Q?QL/KfKvjwLJJyd2xI/MQ98Az5knzkKj6xBFyuzWHybaJwp/YmasKAEG7L+gD?=
 =?us-ascii?Q?9VNLOTzro9cULL5GKgWkQX1hXwE1Itzq8qSUgMA4zuQb58LBcHEH297EBIuh?=
 =?us-ascii?Q?ZRnj/uRu?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB1835.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: be918cc4-0f41-44e9-ae27-08d8c7e6b0b3
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Feb 2021 01:54:49.2976
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: m23ntKw5siVxsDRdlK2DI8uzmQ/lIBImMmSHJl0rI7yGNBqZx8tYF1knU8b3eYShVWzNdoxvaBEjcjikFYc09A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4958
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Hi Lukas,

On Tue, Feb 2, 2021 at 18:8:55, Lukas Wunner <lukas@wunner.de> wrote:

> On Tue, Feb 02, 2021 at 01:40:18PM +0100, Gustavo Pimentel wrote:
> >  /**
> > + * pci_find_vsec_capability - Find a vendor-specific extended capabili=
ty
> > + * @dev: PCI device to query
> > + * @cap: vendor-specific capability ID code
> > + *
> > + * Returns the address of the vendor-specific structure that matches t=
he
> > + * requested capability ID code within the device's PCI configuration =
space
> > + * or 0 if it does not find a match.
> > + */
> > +u16 pci_find_vsec_capability(struct pci_dev *dev, int vsec_cap_id)
> > +{
>=20
> As the name implies, the capability is "vendor-specific", so it is perfec=
tly
> possible that two vendors use the same VSEC ID for different things.
>=20
> To make sure you're looking for the right capability, you need to pass
> a u16 vendor into this function and bail out if dev->vendor is different.

This function will be called by the driver that will pass the correct=20
device which will be already pointing to the config space associated with=20
the endpoint for instance. Because the driver is already attached to the=20
endpoint through the vendor ID and device ID specified, there is no need=20
to do that validation, it will be redundant.

>=20
>=20
> > +	u16 vsec;
> > +	u32 header;
> > +
> > +	vsec =3D pci_find_ext_capability(dev, PCI_EXT_CAP_ID_VNDR);
> > +	while (vsec) {
> > +		if (pci_read_config_dword(dev, vsec + PCI_VSEC_HDR,
> > +					  &header) =3D=3D PCIBIOS_SUCCESSFUL &&
> > +		    PCI_VSEC_CAP_ID(header) =3D=3D vsec_cap_id)
> > +			return vsec;
> > +
> > +		vsec =3D pci_find_next_ext_capability(dev, vsec,
> > +						    PCI_EXT_CAP_ID_VNDR);
> > +	}
>=20
> FWIW, a more succinct implementation would be:
>=20
> 	while ((vsec =3D pci_find_next_ext_capability(...))) { ... }
>=20
> See set_pcie_thunderbolt() in drivers/pci/probe.c for an example.
> Please consider refactoring that function to use your new helper.

That looks more clean. I will do it. Thanks!

>=20
> Thanks,
>=20
> Lukas


