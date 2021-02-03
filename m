Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2CBC230D6E9
	for <lists+dmaengine@lfdr.de>; Wed,  3 Feb 2021 11:00:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233620AbhBCKAI (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 3 Feb 2021 05:00:08 -0500
Received: from smtprelay-out1.synopsys.com ([149.117.87.133]:49094 "EHLO
        smtprelay-out1.synopsys.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233090AbhBCKAA (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 3 Feb 2021 05:00:00 -0500
Received: from mailhost.synopsys.com (sv1-mailhost1.synopsys.com [10.205.2.131])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id CBCAFC00C5;
        Wed,  3 Feb 2021 09:58:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1612346339; bh=J3sMmNaj9dnLWZMEosWg5wI/ow4E//uSLHp5foGmAA4=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=C7JPpJuYrJRNAl8GHMc68SMHvsxFZRUSP6u162q4xSnNT1kvpzNlEYAYUWh3UqkVW
         5aZsHn6yaFdYxHvt0qGJOxPKwnyhcKTIr531SKFYCFEvBF/+5Zjoe+DdszpKdVSjwI
         pPSiT8/AcOVsLqit1TcvB8p2iP4C+6NSqiTiLGFKduXmBbuYZ9OC5zLa6B3MEAaCG2
         D6vfGFSag71Wp4huwiu/Tdpnd3LxjNvkULPXHn0vcpbgwN5m9Zy0/3qdcHfIPcU6Ae
         TLS6rqgIUP90e9Xyky2iVLC489QXrEDivVseXdt9SIlLW2c0flMYIXG02JfvtjZ4eD
         2y5bk/0Ia1qpw==
Received: from o365relay-in.synopsys.com (us03-o365relay1.synopsys.com [10.4.161.137])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by mailhost.synopsys.com (Postfix) with ESMTPS id 64D00A0068;
        Wed,  3 Feb 2021 09:58:58 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2170.outbound.protection.outlook.com [104.47.58.170])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "mail.protection.outlook.com", Issuer "GlobalSign Organization Validation CA - SHA256 - G3" (verified OK))
        by o365relay-in.synopsys.com (Postfix) with ESMTPS id 70532800C6;
        Wed,  3 Feb 2021 09:58:56 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=gustavo@synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
        dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.b="Cig3/iC8";
        dkim-atps=neutral
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YRitMYx3X6AoBHsvphTNiyff7m5RGxDeWSB1ROGDFfMbvGV8Sh5hW3gfXgiYlrVAm9r+WYmBJvmMUKXzMFou6MS2/YWfmhLUR1jP5mvE8mk/S9PMtUD5fP7zAqxHCAKlmvnzxcQAgGN9NWkO7C4gp17T7lP5jRigWC4mdpo3pzwGusCvqNDWV3MroiPCFQjevEXoaiTto6YuK4powfPfnWgCXpYMCPXVyVYfK99RfpQxDt1yAyw3sQuuh1HHDbu43+4QkvncvUDi+Cbl+2l41eNZpHUZRJl3tdMl1U0rUlF6ss9qoPUzi+ECskMqRQaPWcd6iStksNfkpcZhbuKaow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6JfXiZi4nJZFSu0nr7XEEiHCpcTKoTw50Owm7agCa5c=;
 b=PBIFoELAJz0oqXdicwxn2FRNrt4cE0TDVlBM+sUJlMHGxMXWaqJWqAG/TTGGd1IHkNQWxTH2YQkZ4oNx3z64kXgiqCC2kTm8OABmZhvy6d4uZ1va6z0opaT8bkPSUXzButZfQYcOnGLpLnMy6QLm7rC1pAC+t6KOTzbZVUE2YUveOZoxW2DBXYUK+C7KiAU2v1g4R9yA7Hzc481zFW/4wgCHNaghToKMrX61OKfQ6JnoUZr9i4bPQPdqqFIqfVq1VkemyZGKYE/pNHDY85GsmebaabKHIq4ejLW9w1dIevUmqnhCwtWkErA3DqOQjoGagP67SFc4vPafO0Fb28HTRA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6JfXiZi4nJZFSu0nr7XEEiHCpcTKoTw50Owm7agCa5c=;
 b=Cig3/iC81CGKVHaYtF8UpWzU/QZUJ6CCwz7QHADg2FIb7t1v7n3mZHVK1hUSy690NMOja51V4yWB8LApz+MUo5N2J6fBGUzLZI2OMIzH85Mam3TOFtFYTCpIcPrB+dZHVQZkNst7LhkE+Xn+EngxDbks1zVAzeUSAkhKpf2P0pc=
Received: from DM5PR12MB1835.namprd12.prod.outlook.com (2603:10b6:3:10c::9) by
 DM6PR12MB4941.namprd12.prod.outlook.com (2603:10b6:5:1b8::17) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3805.19; Wed, 3 Feb 2021 09:58:54 +0000
Received: from DM5PR12MB1835.namprd12.prod.outlook.com
 ([fe80::508b:bdb3:d353:9052]) by DM5PR12MB1835.namprd12.prod.outlook.com
 ([fe80::508b:bdb3:d353:9052%10]) with mapi id 15.20.3805.028; Wed, 3 Feb 2021
 09:58:54 +0000
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
Thread-Index: AQHW+WCk8KFoXO5U70eM77z8tv2kyapFKi6AgAB9hHCAAGgwgIAAFE4QgAAJRQCAAAMEkA==
Date:   Wed, 3 Feb 2021 09:58:54 +0000
Message-ID: <DM5PR12MB1835224A170AAF195EDDF88BDAB49@DM5PR12MB1835.namprd12.prod.outlook.com>
References: <cover.1612269536.git.gustavo.pimentel@synopsys.com>
 <2ecb33dfee5dc05efc05de0731b0cb77bc246f54.1612269537.git.gustavo.pimentel@synopsys.com>
 <20210202180855.GA3571@wunner.de>
 <DM5PR12MB18351689BA7312BF9DFDD6FEDAB49@DM5PR12MB1835.namprd12.prod.outlook.com>
 <20210203075103.GA18742@wunner.de>
 <DM5PR12MB183576159AF458EE007149D1DAB49@DM5PR12MB1835.namprd12.prod.outlook.com>
 <20210203093654.GA14315@wunner.de>
In-Reply-To: <20210203093654.GA14315@wunner.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: =?us-ascii?Q?PG1ldGE+PGF0IG5tPSJib2R5LnR4dCIgcD0iYzpcdXNlcnNcZ3VzdGF2b1xh?=
 =?us-ascii?Q?cHBkYXRhXHJvYW1pbmdcMDlkODQ5YjYtMzJkMy00YTQwLTg1ZWUtNmI4NGJh?=
 =?us-ascii?Q?MjllMzViXG1zZ3NcbXNnLTZhZGE4MzJmLTY2MDYtMTFlYi05OGU2LWY4OTRj?=
 =?us-ascii?Q?MjczODA0MlxhbWUtdGVzdFw2YWRhODMzMC02NjA2LTExZWItOThlNi1mODk0?=
 =?us-ascii?Q?YzI3MzgwNDJib2R5LnR4dCIgc3o9IjIyMjciIHQ9IjEzMjU2ODE5OTMyNTcz?=
 =?us-ascii?Q?NTk0NCIgaD0id2F4NmJ3QTRyZnZYZ1dNWVBOYXZXdEQyZmNZPSIgaWQ9IiIg?=
 =?us-ascii?Q?Ymw9IjAiIGJvPSIxIiBjaT0iY0FBQUFFUkhVMVJTUlVGTkNnVUFBQlFKQUFB?=
 =?us-ascii?Q?STNGSXRFL3JXQWNoMFlOMkJwZzd5eUhSZzNZR21EdklPQUFBQUFBQUFBQUFB?=
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
x-ms-office365-filtering-correlation-id: bf5c9fb9-5073-4414-8c0e-08d8c82a50f1
x-ms-traffictypediagnostic: DM6PR12MB4941:
x-microsoft-antispam-prvs: <DM6PR12MB4941F0028F5C0BC8588334D7DAB49@DM6PR12MB4941.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: q2bUZ8j7DXSU2mfu+Oq1mULmIguGel1EzRpnKlOosxDVGjSuUwzvfhZWS+sGl6E0lf0HIIKhPWikqaYbOotnHl8AEw3dn6Q4L9PB+qOURZBRx9FArkKGSKQDVt9iar8W5FXbQLccdDOMJjtYFJ4lCrcMYvfBgoixA7WxcrLvCdAZ42xwzkiEBh7c+LAw/Fs0XIbrVXJyFR+C7VONwezwzh9nVJEk/OQa0O2pArw6FWzk8wiRWdqfIo0rgi4R4qunwyMamNpHC7iRkzSYtdiqj5UtSxMkOGFdbGHK4/DM3j1bibRwosXoAj+SOtXb1wiiqpIKcJFXUKmVtMeFwYUQkofa8i37RdjvE4EvCKcf5efbdMZYnNtKt9BiUROEngrbIMNIRZA2hIfxom7s5ekqS/5hLfYc/RQHMWlAu1sZmmIQuu2Gt52lAGRecZ1g6pla/PjF4/GfPVflWCilqvnPzJubRBmLOXe0D6+XCG86vvXS7F3EO30VFkJ3LkXYZFUz+aH5DXipRxd5I0aXLt1j5Vb2+3X3QN4Oyu81rpRYGh+2KaYhD3htPFAwuRaLApiY
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR12MB1835.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(346002)(39850400004)(396003)(366004)(136003)(376002)(64756008)(55016002)(478600001)(66476007)(316002)(71200400001)(9686003)(66946007)(6916009)(66446008)(52536014)(2906002)(66556008)(54906003)(7696005)(8936002)(6506007)(5660300002)(4326008)(53546011)(33656002)(26005)(186003)(86362001)(76116006)(8676002)(37363001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?mLFfjYVVoXKBQoxWWvdFDRvylxDQoVRzCcvKxgJRhUjS6djm0e2a1rP15GBK?=
 =?us-ascii?Q?7kv44uElb0nbOE/95o+Fyyi0FlM65LRaS5Mb8vmbI6N6KiL3pMGgsmNXqDJu?=
 =?us-ascii?Q?D7sE+lM/X85PEkHsSKfy3N4NmuzH/bkzX6dnoRODNYklu0L9rX8ym9oeGQGk?=
 =?us-ascii?Q?7r9Tzu0L5ym+8al4YskgUttIdik05mzaHEGGAzpVtzI4n0Mj7G8AQ5pBatk/?=
 =?us-ascii?Q?ViHn99YC8jHc9aFo7+Vt8/jctuRU6iQRGA3q0ahnyG9zl915eDBOCM+0FXvn?=
 =?us-ascii?Q?uSSLjJKbWWsGymKGkl2B0rz2PxarV2JzwOqNsi7SiGegEuvra7VT47g/6EEb?=
 =?us-ascii?Q?cViz803mq3Tan/H1+kBgp3z17T79ti6vR8BjqzKDWH3QgcRx3hO2Jy7/wEkV?=
 =?us-ascii?Q?IW8v1mV7a2oWMxnvf/PLS8E7Xe/SfnmFGNirGHJFB/fqEvv4HpKBWG8i4c5Y?=
 =?us-ascii?Q?qc+2EcA11mk+xhZdXkJLvACvEi1XguuU+EgLt+pvL5d5gHER0Ko5vqdBzd54?=
 =?us-ascii?Q?XT+ZP27CdUA0D/zIvEFi91C7oCPO9V7ambX6jpyAF8ZVwsrF2a7EnAiMa8zv?=
 =?us-ascii?Q?iaiilqX2Y41QBsw1i83Do26FMp/Qn0srq/4+5Luw4PnZn5atry2NT21sCRCd?=
 =?us-ascii?Q?hL70sVfJ14RExIguFaNlZfIJoThzvEgNcw2vF1OXpNVI5msLJamKTvVUnTt4?=
 =?us-ascii?Q?FsH2bna3Qdfq+GU2bBAqt6efa/RiuhmBPtVek0f1rRlaIgB67T2ngaXfhc5n?=
 =?us-ascii?Q?IJsWfsvNpqqGLVDN0LBYJooLBkr8yO3euv/KdVP/d07YmTxDgCPJ9Ggv9win?=
 =?us-ascii?Q?OJEDJMJzGA2jJM/6whw0AFoBAFo7Yul1bp3YWZIzUryJalvfSPtV1bYudGZD?=
 =?us-ascii?Q?BtsqbrzTulHTwlg8aSDjAdsY4kdELNsy31B/h6iSfAjFr5vAf9rDt81ZmCuW?=
 =?us-ascii?Q?5Z5zqIzGNZXkSAqIrc5UuT9I2FU3CH0VD5fyYCuAtK9eO9wXjZX0gdcrPSyO?=
 =?us-ascii?Q?RXJKFv1L3nHn7Jz+/V+e2e4vPUvQpViMBLFz4sMRt3uYUxQ58GACWHbKRHqy?=
 =?us-ascii?Q?lgbXqk4L?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB1835.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bf5c9fb9-5073-4414-8c0e-08d8c82a50f1
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Feb 2021 09:58:54.4274
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hwqB2tJpoyoJc1mHgSf2KZ/M1zAczjNPCNEcwLFc84cvvDxzdJ0loBC7a0+hTcNfhppAIE8D4dAepfor0TI72A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4941
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Wed, Feb 3, 2021 at 9:36:54, Lukas Wunner <lukas@wunner.de> wrote:

> On Wed, Feb 03, 2021 at 09:11:03AM +0000, Gustavo Pimentel wrote:
> > On Wed, Feb 3, 2021 at 7:51:3, Lukas Wunner <lukas@wunner.de> wrote:
> > > On Wed, Feb 03, 2021 at 01:54:49AM +0000, Gustavo Pimentel wrote:
> > > > On Tue, Feb 2, 2021 at 18:8:55, Lukas Wunner <lukas@wunner.de> wrot=
e:
> > > > > As the name implies, the capability is "vendor-specific", so it i=
s
> > > > > perfectly possible that two vendors use the same VSEC ID for diff=
erent
> > > > > things.
> > > > >=20
> > > > > To make sure you're looking for the right capability, you need to=
 pass
> > > > > a u16 vendor into this function and bail out if dev->vendor is
> > > > > different.
> > > >=20
> > > > This function will be called by the driver that will pass the corre=
ct=20
> > > > device which will be already pointing to the config space associate=
d with
> > > > the endpoint for instance. Because the driver is already attached t=
o the=20
> > > > endpoint through the vendor ID and device ID specified, there is no=
 need=20
> > > > to do that validation, it will be redundant.
> > >=20
> > > Okay.  Please amend the kernel-doc to make it explicit that it's the
> > > caller's responsibility to check the vendor ID.
> >=20
> > I don't think that would be necessary, as I said, the 'struct pci_dev *=
'=20
> > already points exclusively for the device' config space, which contains=
=20
> > all the capabilities for that particular device by his turn will be=20
> > attached to a specific driver by the Vendor and Device IDs to a specifi=
c=20
> > driver, that will know, firstly search for the specific device vendor I=
D,=20
> >  and then secondly how to decode it, and thirdly to do something with i=
t.
>=20
> The helper you're adding may not only be called from drivers but also
> from generic PCI code (such as set_pcie_thunderbolt()).  In that case
> the vendor ID is arbitrary.  Also, it doesn't *hurt* documenting this
> requirement, does it?

I understand now your PoV. In that case, I can add that info to the=20
function comment.

>=20
> Thanks,
>=20
> Lukas


