Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4F96E31EA11
	for <lists+dmaengine@lfdr.de>; Thu, 18 Feb 2021 13:58:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231185AbhBRMyZ (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 18 Feb 2021 07:54:25 -0500
Received: from smtprelay-out1.synopsys.com ([149.117.73.133]:39332 "EHLO
        smtprelay-out1.synopsys.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232093AbhBRKVr (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 18 Feb 2021 05:21:47 -0500
Received: from mailhost.synopsys.com (us03-mailhost1.synopsys.com [10.4.17.17])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 3E1A84049B;
        Thu, 18 Feb 2021 10:20:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1613643623; bh=tuKmFBPE9COqvGfXPm67y6URdumzSdQePn3aaeDwCQA=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=ZXcn167FG1v7WaNvTnUWiE5mITeKgNX060w4r46NxWYSGbcXQFe0xgGbOZGLKws1D
         hU53MvYp7eJUui8oqkV3BL/TR0MQtp5cP/yVmZt+R/g9Xx8gxWiOY6d5Kuw9sDJg1z
         8XwRWZpie2JaC43oF/pSIYvVVP/kS7dHIbJnRUjWbYKuPMScZldEL1Waxk/Qxn2i1x
         vXx8Qr8x/jRpYuRQRY8sjhIuDbt6fXiqfY1cuuaFgQdcCXI3P0/Ht4ke6HZsUlvcIr
         DoxqnOhq3gWSZncIbyqmJ/LCdFXq3n0gLYE83OGq5nFKxMB1JCQ+qwrEOI9iDdRJPC
         P8K47KMICLxzg==
Received: from o365relay-in.synopsys.com (us03-o365relay1.synopsys.com [10.4.161.137])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by mailhost.synopsys.com (Postfix) with ESMTPS id ECBDDA0082;
        Thu, 18 Feb 2021 10:20:21 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2101.outbound.protection.outlook.com [104.47.58.101])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "mail.protection.outlook.com", Issuer "GlobalSign Organization Validation CA - SHA256 - G3" (verified OK))
        by o365relay-in.synopsys.com (Postfix) with ESMTPS id D086D800C6;
        Thu, 18 Feb 2021 10:20:18 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=gustavo@synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
        dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.b="VOrrqEU7";
        dkim-atps=neutral
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Zdy7uyO++8YzM3qAJ72TEo390y9WYMZC9EZT31M6L3746HlI8CEi4eNRBmxjuWgNFkyX/C+MKntUqDq+wp8RMirqT9cwM39W1/xvRDecK2VzSe2wWGiRdXnwdxivJKpsPc3u6uTJNlfS8aNQmLSejbeHo191oArqrvLOGRg96wz/CtMzUZ5lBrSsU+N9Xk4gSJX/KKiS/x7nTUyywUpr2R8hs/jXt8c/VOBiy/dQfU2Z8/lPA+sbxlFDWJmAzGaGbOExvPGVvKv+V/isKVstdwGQYOOP2WCtx5FQL184umzB9YYp6Rb8+3DvRrFsAxpV+2QF0bCxyvchzkdHI8UFSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xH2QNZPdciVc9GpiHInmov32Ptnoy6g1dVNlW0uTjlc=;
 b=KKdd38/WrEimFSCiNRa3UywC6zuVZP9mLjzm4TSQoL21p6R8DsFzCbikuEYAr3yg+lCOFbpiG7zcQpvYbQUkPHNK1I5S6an+hy1hAeT9B8XHS9879lw0L49HG0aM4yth3Ms9pVmKgNmGhFjOHBkS7nQ86R38fx8wshrCfyt3c+fBPFLtTgXrBWa7jQxNqhEc41lVcBIGjySpvc2vsmh4LEuMGx2MWFEhLXScHoU5hBIvUJD6ruRqu3V7+OP6eGfaUEiFiMBWTYz1touwzrXIb9YB36cZZQcn2PAFvYwx1z+lCEznhSQ/ukZzQLLfTv90H9hAibNbH/4P9liGwxaKCQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xH2QNZPdciVc9GpiHInmov32Ptnoy6g1dVNlW0uTjlc=;
 b=VOrrqEU71imEL8qzYawe66ciNfw8P77dcKpcaB3Z0N9KoN9ilQl+TiLmlxLmHIClIAUzsUKabHA2oy4oh/xT2grotp8HwrE3RYYBNO3tCedVzxet7PwmeqoujWdDT5Vye8GAsYimw/Ap9/zSIfW0nkvzxkqrzNxmla1pRfcxHfY=
Received: from DM5PR12MB1835.namprd12.prod.outlook.com (2603:10b6:3:10c::9) by
 DM6PR12MB3468.namprd12.prod.outlook.com (2603:10b6:5:38::33) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3846.38; Thu, 18 Feb 2021 10:20:17 +0000
Received: from DM5PR12MB1835.namprd12.prod.outlook.com
 ([fe80::508b:bdb3:d353:9052]) by DM5PR12MB1835.namprd12.prod.outlook.com
 ([fe80::508b:bdb3:d353:9052%10]) with mapi id 15.20.3846.042; Thu, 18 Feb
 2021 10:20:16 +0000
X-SNPS-Relay: synopsys.com
From:   Gustavo Pimentel <Gustavo.Pimentel@synopsys.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
CC:     "dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Vinod Koul <vkoul@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        =?iso-8859-2?Q?Krzysztof_Wilczy=F1ski?= <kw@linux.com>,
        Lukas Wunner <lukas@wunner.de>
Subject: RE: [PATCH v6 04/15] PCI: Add pci_find_vsec_capability() to find a
 specific VSEC
Thread-Topic: [PATCH v6 04/15] PCI: Add pci_find_vsec_capability() to find a
 specific VSEC
Thread-Index: AQHXAWXQaWLKFc3HCkuwap1YzgouV6pc9WUAgADGI8A=
Date:   Thu, 18 Feb 2021 10:20:16 +0000
Message-ID: <DM5PR12MB1835BCA54E44A71C3D1D808CDA859@DM5PR12MB1835.namprd12.prod.outlook.com>
References: <145b54b2a6feabcfa913ec8c44c9dee92deedf11.1613151392.git.gustavo.pimentel@synopsys.com>
 <20210217222738.GA915397@bjorn-Precision-5520>
In-Reply-To: <20210217222738.GA915397@bjorn-Precision-5520>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: =?iso-8859-2?Q?PG1ldGE+PGF0IG5tPSJib2R5LnR4dCIgcD0iYzpcdXNlcnNcZ3VzdGF2b1?=
 =?iso-8859-2?Q?xhcHBkYXRhXHJvYW1pbmdcMDlkODQ5YjYtMzJkMy00YTQwLTg1ZWUtNmI4?=
 =?iso-8859-2?Q?NGJhMjllMzViXG1zZ3NcbXNnLWUzM2E0MTNhLTcxZDItMTFlYi05OGU3LW?=
 =?iso-8859-2?Q?Y4OTRjMjczODA0MlxhbWUtdGVzdFxlMzNhNDEzYi03MWQyLTExZWItOThl?=
 =?iso-8859-2?Q?Ny1mODk0YzI3MzgwNDJib2R5LnR4dCIgc3o9IjczNzkiIHQ9IjEzMjU4MT?=
 =?iso-8859-2?Q?E3MjE0ODkyNTkxMiIgaD0ibXJyQk16ODlUNDU5NnZpQU9YMktlZFBnZWtZ?=
 =?iso-8859-2?Q?PSIgaWQ9IiIgYmw9IjAiIGJvPSIxIiBjaT0iY0FBQUFFUkhVMVJTUlVGTk?=
 =?iso-8859-2?Q?NnVUFBQlFKQUFEWWRkZWwzd1hYQWFxcXBFR0VPR1ZMcXFxa1FZUTRaVXNP?=
 =?iso-8859-2?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUhBQUFBQ2tDQUFBQUFBQUFBQU?=
 =?iso-8859-2?Q?FBQUFBQUFBQUFBQUFBQUVBQVFBQkFBQUFOclNWM2dBQUFBQUFBQUFBQUFB?=
 =?iso-8859-2?Q?QUFKNEFBQUJtQUdrQWJnQmhBRzRBWXdCbEFGOEFjQUJzQUdFQWJnQnVBR2?=
 =?iso-8859-2?Q?tBYmdCbkFGOEFkd0JoQUhRQVpRQnlBRzBBWVFCeUFHc0FBQUFBQUFBQUFB?=
 =?iso-8859-2?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQU?=
 =?iso-8859-2?Q?FBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?iso-8859-2?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBRUFBQUFBQUFBQUFnQUFBQUFBbmdBQU?=
 =?iso-8859-2?Q?FHWUFid0IxQUc0QVpBQnlBSGtBWHdCd0FHRUFjZ0IwQUc0QVpRQnlBSE1B?=
 =?iso-8859-2?Q?WHdCbkFHWUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQU?=
 =?iso-8859-2?Q?FBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?iso-8859-2?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQU?=
 =?iso-8859-2?Q?FBQUFBQUFBQUFBQUFBQVFBQUFBQUFBQUFDQUFBQUFBQ2VBQUFBWmdCdkFI?=
 =?iso-8859-2?Q?VUFiZ0JrQUhJQWVRQmZBSEFBWVFCeUFIUUFiZ0JsQUhJQWN3QmZBSE1BWV?=
 =?iso-8859-2?Q?FCdEFITUFkUUJ1QUdjQVh3QmpBRzhBYmdCbUFBQUFBQUFBQUFBQUFBQUFB?=
 =?iso-8859-2?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQU?=
 =?iso-8859-2?Q?FBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?iso-8859-2?Q?QUFBQUFBQUJBQUFBQUFBQUFBSUFBQUFBQUo0QUFBQm1BRzhBZFFCdUFHUU?=
 =?iso-8859-2?Q?FjZ0I1QUY4QWNBQmhBSElBZEFCdUFHVUFjZ0J6QUY4QWN3QmhBRzBBY3dC?=
 =?iso-8859-2?Q?MUFHNEFad0JmQUhJQVpRQnpBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQU?=
 =?iso-8859-2?Q?FBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?iso-8859-2?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQU?=
 =?iso-8859-2?Q?FFQUFBQUFBQUFBQWdBQUFBQUFuZ0FBQUdZQWJ3QjFBRzRBWkFCeUFIa0FY?=
 =?iso-8859-2?Q?d0J3QUdFQWNnQjBBRzRBWlFCeUFITUFYd0J6QUcwQWFRQmpBQUFBQUFBQU?=
 =?iso-8859-2?Q?FBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?iso-8859-2?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQU?=
 =?iso-8859-2?Q?FBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBUUFBQUFB?=
 =?iso-8859-2?Q?QUFBQUNBQUFBQUFDZUFBQUFaZ0J2QUhVQWJnQmtBSElBZVFCZkFIQUFZUU?=
 =?iso-8859-2?Q?J5QUhRQWJnQmxBSElBY3dCZkFITUFkQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?iso-8859-2?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQU?=
 =?iso-8859-2?Q?FBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?iso-8859-2?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQkFBQUFBQUFBQUFJQU?=
 =?iso-8859-2?Q?FBQUFBSjRBQUFCbUFHOEFkUUJ1QUdRQWNnQjVBRjhBY0FCaEFISUFkQUJ1?=
 =?iso-8859-2?Q?QUdVQWNnQnpBRjhBZEFCekFHMEFZd0FBQUFBQUFBQUFBQUFBQUFBQUFBQU?=
 =?iso-8859-2?Q?FBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?iso-8859-2?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQU?=
 =?iso-8859-2?Q?FBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUVBQUFBQUFBQUFBZ0FBQUFBQW5n?=
 =?iso-8859-2?Q?QUFBR1lBYndCMUFHNEFaQUJ5QUhrQVh3QndBR0VBY2dCMEFHNEFaUUJ5QU?=
 =?iso-8859-2?Q?hNQVh3QjFBRzBBWXdBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?iso-8859-2?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQU?=
 =?iso-8859-2?Q?FBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?iso-8859-2?Q?QUFBQUFBQUFBQUFBQUFBQUFRQUFBQUFBQUFBQ0FBQUFBQUNlQUFBQVp3Qj?=
 =?iso-8859-2?Q?BBSE1BWHdCd0FISUFid0JrQUhVQVl3QjBBRjhBZEFCeUFHRUFhUUJ1QUdr?=
 =?iso-8859-2?Q?QWJnQm5BQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQU?=
 =?iso-8859-2?Q?FBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?iso-8859-2?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQU?=
 =?iso-8859-2?Q?FBQUFBQUFBQUFCQUFBQUFBQUFBQUlBQUFBQUFKNEFBQUJ6QUdFQWJBQmxB?=
 =?iso-8859-2?Q?SE1BWHdCaEFHTUFZd0J2QUhVQWJnQjBBRjhBY0FCc0FHRUFiZ0FBQUFBQU?=
 =?iso-8859-2?Q?FBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?iso-8859-2?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQU?=
 =?iso-8859-2?Q?FBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?iso-8859-2?Q?QUFBRUFBQUFBQUFBQUFnQUFBQUFBbmdBQUFITUFZUUJzQUdVQWN3QmZBSE?=
 =?iso-8859-2?Q?VBZFFCdkFIUUFaUUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?iso-8859-2?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQU?=
 =?iso-8859-2?Q?FBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?iso-8859-2?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQVFBQU?=
 =?iso-8859-2?Q?FBQUFBQUFDQUFBQUFBQ2VBQUFBY3dCdUFIQUFjd0JmQUd3QWFRQmpBR1VB?=
 =?iso-8859-2?Q?YmdCekFHVUFYd0IwQUdVQWNnQnRBRjhBTVFBQUFBQUFBQUFBQUFBQUFBQU?=
 =?iso-8859-2?Q?FBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?iso-8859-2?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQU?=
 =?iso-8859-2?Q?FBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUJBQUFBQUFBQUFB?=
 =?iso-8859-2?Q?SUFBQUFBQUo0QUFBQnpBRzRBY0FCekFGOEFiQUJwQUdNQVpRQnVBSE1BWl?=
 =?iso-8859-2?Q?FCZkFIUUFaUUJ5QUcwQVh3QnpBSFFBZFFCa0FHVUFiZ0IwQUFBQUFBQUFB?=
 =?iso-8859-2?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQU?=
 =?iso-8859-2?Q?FBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?iso-8859-2?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFFQUFBQUFBQUFBQWdBQUFBQU?=
 =?iso-8859-2?Q?FuZ0FBQUhZQVp3QmZBR3NBWlFCNUFIY0Fid0J5QUdRQUFBQUFBQUFBQUFB?=
 =?iso-8859-2?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQU?=
 =?iso-8859-2?Q?FBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?iso-8859-2?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQU?=
 =?iso-8859-2?Q?FBQUFBQUFBQUFBQUFBQUFBQUFBUUFBQUFBQUFBQUNBQUFBQUFBPSIvPjwv?=
 =?iso-8859-2?Q?bWV0YT4=3D?=
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=synopsys.com;
x-originating-ip: [89.155.14.32]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a0f1f404-b033-4a3a-b2aa-08d8d3f6c983
x-ms-traffictypediagnostic: DM6PR12MB3468:
x-microsoft-antispam-prvs: <DM6PR12MB34682C932FB145C7F2F7BDFEDA859@DM6PR12MB3468.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: epGtCZqwZIZ2CkkcmeBkx/jylQ7XL4B0ZC51YDTQb56Wb8Wkr+dXQXiivA+RDy8Cmn9qvz1hK/FO7O5MO27jcYfcOoph3e/0SXM8+3EiEPYpbYvyT5TnosAq3ZYYvuArQGYIdhEhO2J28UlBj/v55YR1KfDv1pjvRXW71uhoslXbAZgXksQBuOmi+A8TQOd1KBOqoPtxp4b4zo+9tq9dTUkBAEKRy5XpspdMjO5HMY4++WQxCRFlU1CmQetxYq+2wF/ngyGpdn6K8NvMd9oDKt89FXfflB4aXjggBUMeOU/zBIoQ/WTp46TxxLKoa8dMKP+C7pkAXQUBRT4fEevD+Kq0jr5qnOQrWoEIrInLBGnNs8wYS1J7AFZdovSipPKXf2rx2NiTXSmVx75cbDfGHwY+9UsrowhDYMERR6fITE5qacjDoh6GvG9+JG85EHHnv6cDwTZXSOfGHxceCRkUTbq3qlU1U9SM8gmtUYjv5kVJQqLmR3DjGj+UKh1zDMdAXqZw4jB66Ww4TZTiOjcm2+6gLd2cjd6pPq9mEFJytkBe1QoGoVn9+3/sSaaJWsTF
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR12MB1835.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(396003)(376002)(39860400002)(346002)(366004)(136003)(66556008)(66446008)(186003)(64756008)(66946007)(6506007)(66476007)(76116006)(26005)(53546011)(86362001)(54906003)(4326008)(5660300002)(52536014)(8676002)(6916009)(9686003)(83380400001)(8936002)(33656002)(7696005)(2906002)(55016002)(478600001)(316002)(71200400001)(37363001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?iso-8859-2?Q?7mpzfXtWpL+pHY48WI/JEYMSHNg5sd7BtIZw77CGJKgc9zHY9SFhU9o5x7?=
 =?iso-8859-2?Q?r9/uasm8qLSir/iTztIVYyC36oAOcWGLJQyelEoJx5ltiyW+tKDV/xT12I?=
 =?iso-8859-2?Q?bedJ1mMtyhe51wAQFZ8+sIFGjYie7oT75r2TQxIfYrSwfZYsEG5j2Vd06w?=
 =?iso-8859-2?Q?NCU2QHBXBxO34HuBQiRZbl9gbwCpUup23c/NFq7NM0Q+j3mAhXQw/gHlyY?=
 =?iso-8859-2?Q?iNV2O53+Eeg1A5hbULgMKAOWViEMiVsi4YJZbAztl7Q5klYT6kA70BNzNT?=
 =?iso-8859-2?Q?u9McKWJr05yjMRd6rgXMZYTfwmbj7XQnjZUAmKhpQlMV8NS69CZDPHOD20?=
 =?iso-8859-2?Q?WqPDggrl+ty7Mneh1EyhD3l3SkGyg3Lob0QQqiizavdD8zvRmHllM1JT5Y?=
 =?iso-8859-2?Q?8O97de+drPwQHsJKC/61IPd+CMOjV1Wy6rjWUrNHWGy3TvWH5nkjtfOJ0Z?=
 =?iso-8859-2?Q?Cd07B7wGfFRHgXpJsomCW4gSIc8X+Ccy9Pu0eFp6ONXu8/XDuWNWn0aYO2?=
 =?iso-8859-2?Q?FsCKPHPosxrq+4oe+xRqIa1ZAuGGf8B1TGQtKRLVpfQSK3gIVsqtIXH2Mf?=
 =?iso-8859-2?Q?Q08UlPACMPsJm+wIHgKAm4/q9IgyDWrgeMpw9Q50bvRlhDSX5IeDjBYwU3?=
 =?iso-8859-2?Q?2iB6IJqtmu2gzV8o62UHhJOA2Nwp2yRkUWRmSTTiZaztcBaSVMLC7W4ESK?=
 =?iso-8859-2?Q?/4W777Ck6HGWAK4orDnqMfY0grpk31i7XaDePiQSs5Ww+jDDyvf5WFZV63?=
 =?iso-8859-2?Q?R7eecZoaxcEP3TKrS7AFV2KJZom5fDBQP3ka9bWbldKr3iaa9IS+df299D?=
 =?iso-8859-2?Q?sbdg9upGkjDdJu4jkiPlvRIg2oJzQRhk6PKMfgQ/NWgn088Mjv3T9VCrLT?=
 =?iso-8859-2?Q?8XNilH3PoS/zIC7+0NG0+C/4lw23wjX+XrmLAIzboebVGtmDkHPEF9/lTC?=
 =?iso-8859-2?Q?6RY1Lh6muJD6SQdHzGpYeDUhjWrsXk2SFHijGaYpLhRQi0JYkp+samhJeK?=
 =?iso-8859-2?Q?9q/9s3QNRVb/I7l8/sNilwYmvPUrD7E+vjZbkq2K84ovoHNIKJYEPaGFcN?=
 =?iso-8859-2?Q?EwkGezWMfzB4EBYtc4e2zRoOJkNIxcxkXQKtdzf8ExvveLrCN0pU3V+rvk?=
 =?iso-8859-2?Q?Jt6jRpckSmJBT3PZ67D4yriPApapHpoG9hVZePcY/CeLhj1g+50JuSkeTV?=
 =?iso-8859-2?Q?cHwpy+KM1SpKvP6QOxmW7yGEe7HBm2YHSaxELYXxJCK3FJ9eMoNEkhVOBp?=
 =?iso-8859-2?Q?vVgNeBWC9ug7KMSw9kV4Jr3vWqEMrG7s2CqsQTy12Zq1zu2530AbuM4l/V?=
 =?iso-8859-2?Q?fSFMafMzwljJlFMB8nzOwkdM9pIPLfiSLx345DsziVVBWvrHpunNQc4FCw?=
 =?iso-8859-2?Q?l4IEMkCsxG?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="iso-8859-2"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB1835.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a0f1f404-b033-4a3a-b2aa-08d8d3f6c983
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Feb 2021 10:20:16.8592
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: l1F9zLa4EUBv4FDtUGVXdJzBBHS59wCBDhUbZbwFjJbmT/M1vIDzBzib+JyaqcmAFgWfOqwRkP6dw30PyGbbLw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3468
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Wed, Feb 17, 2021 at 22:27:38, Bjorn Helgaas <helgaas@kernel.org>=20
wrote:

> [+cc Krzysztof, since he commented on a previous version]
> [+cc Lukas, who previously proposed exactly what I suggest below,
> sorry for repeating.  I think Lukas was right to propose passing in
> the vendor ID because it makes it easier to read the caller.]
>=20
> When you post new versions of a series, please cc people who commented
> on previous versions.

Noted.

>=20
> On Fri, Feb 12, 2021 at 06:37:39PM +0100, Gustavo Pimentel wrote:
> > Adds another helper to ones that already exist called
> > pci_find_vsec_capability. This helper crawls through the device PCI
> > config space searching for a specific ID on the Vendor-Specific Extende=
d
> > Capabilities section.
>=20
>   Add pci_find_vsec_capability() to locate a Vendor-Specific Extended
>   Capability with the specified VSEC ID.
> >=20
> > The Vendor-Specific Extended Capability (VSEC) is a special PCI
> > capability (acts like container) defined by PCI-SIG that allows the one
> > or more proprietary capabilities defined by the vendor which aren't
> > standard or shared between the manufactures.
>=20
> s/is a special ... by PCI-SIG that//
> s/allows the one/allows one/
> s/the manufactures/manufacturers/ (or maybe "vendors" to match previous u=
se)

Ok, I'll include those changes.

>=20
> > Signed-off-by: Gustavo Pimentel <gustavo.pimentel@synopsys.com>
> > ---
> >  drivers/pci/pci.c             | 34 ++++++++++++++++++++++++++++++++++
> >  include/linux/pci.h           |  2 ++
> >  include/uapi/linux/pci_regs.h |  6 ++++++
> >  3 files changed, 42 insertions(+)
> >=20
> > diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> > index b9fecc2..628aa9f 100644
> > --- a/drivers/pci/pci.c
> > +++ b/drivers/pci/pci.c
> > @@ -693,6 +693,40 @@ u8 pci_find_ht_capability(struct pci_dev *dev, int=
 ht_cap)
> >  EXPORT_SYMBOL_GPL(pci_find_ht_capability);
> > =20
> >  /**
> > + * pci_find_vsec_capability - Find a vendor-specific extended capabili=
ty
> > + * @dev: PCI device to query
> > + * @cap: vendor-specific capability ID code
> > + *
> > + * Typically this function will be called by the PCI driver, which pas=
ses
> > + * through argument the 'struct pci_dev *' already pointing for the de=
vice
> > + * config space that is associated with the vendor and device ID which=
 will
> > + * know which ID to search and what to do with it, however, there migh=
t be
> > + * cases that this function could be called outside of this scope and
> > + * therefore is the caller responsibility to check the vendor and/or
> > + * device ID first.
>=20
> This is important because it's a bit subtle.  IIUC, each vendor
> (identified by Vendor ID at 0x00 in config space) can define its own
> VSEC IDs, so it can define up to 2^16 =3D=3D 64K VSEC structures.
>=20
> Of course there's not room for that many in config space; but the
> point is that the vendor chooses its own VSEC IDs and doesn't need to
> coordinate with anybody.
>=20
> So a VSEC ID 0x0006 in a Synopsys device (Vendor ID 0x16c3) has
> nothing to do with a VSEC ID 0x0006 in an Intel device (Vendor ID
> 0x8086), and it's up to the caller to make sure it's using the correct
> one.
>=20
> I wonder if it would help avoid mistakes if we made the interface look
> like this:
>=20
>   u16 pci_find_vsec_capability(struct pci_dev *dev, u16 vendor, int vsec_=
cap_id)
>   {
>     if (vendor !=3D dev->vendor)
>       return 0;
>=20
>     while ((vsec =3D ...))
>       ...
>   }
>=20
> so calls would look like this:
>=20
>   vsec =3D pci_find_vsec_capability(dev, PCI_VENDOR_ID_SYNOPSYS, DW_PCIE_=
VSEC_DMA_ID);
>=20
> which would make it more obvious that DW_PCIE_VSEC_DMA_ID is only
> valid in a Synopsys device.
>=20
> The function comment could be something like this:
>=20
>   pci_find_vsec_capability - Find a vendor-specific extended capability
>   @dev: PCI device to query
>   @vendor: Vendor ID for which capability is defined
>   @vsec_cap_id: Vendor-specific capability ID
>=20
>   If @dev has Vendor ID @vendor, search for a VSEC capability with
>   VSEC ID @vsec_cap_id.  If found, return the capability offset in
>   config space; otherwise return 0.
>=20
> Or maybe it's even more subtle than I thought, and I'm missing
> something :)

Okay, seems reasonable.

>=20
> > + * Returns the address of the vendor-specific structure that matches t=
he
> > + * requested capability ID code within the device's PCI configuration =
space
> > + * or 0 if it does not find a match.
> > + */
> > +u16 pci_find_vsec_capability(struct pci_dev *dev, int vsec_cap_id)
> > +{
> > +	u16 vsec =3D 0;
> > +	u32 header;
> > +
> > +	while ((vsec =3D pci_find_next_ext_capability(dev, vsec,
> > +						     PCI_EXT_CAP_ID_VNDR))) {
> > +		if (pci_read_config_dword(dev, vsec + PCI_VSEC_HDR,
> > +					  &header) =3D=3D PCIBIOS_SUCCESSFUL &&
> > +		    PCI_VSEC_CAP_ID(header) =3D=3D vsec_cap_id)
> > +			return vsec;
> > +	}
> > +
> > +	return 0;
> > +}
> > +EXPORT_SYMBOL_GPL(pci_find_vsec_capability);
> > +
> > +/**
> >   * pci_find_parent_resource - return resource region of parent bus of =
given
> >   *			      region
> >   * @dev: PCI device structure contains resources to be searched
> > diff --git a/include/linux/pci.h b/include/linux/pci.h
> > index b32126d..da6ab6a 100644
> > --- a/include/linux/pci.h
> > +++ b/include/linux/pci.h
> > @@ -1080,6 +1080,8 @@ struct pci_bus *pci_find_next_bus(const struct pc=
i_bus *from);
> > =20
> >  u64 pci_get_dsn(struct pci_dev *dev);
> > =20
> > +u16 pci_find_vsec_capability(struct pci_dev *dev, int vsec_cap_id);
>=20
> Can you put this declaration up with the other "find_capability"
> declarations just a few lines up?

Sure.

>=20
> >  struct pci_dev *pci_get_device(unsigned int vendor, unsigned int devic=
e,
> >  			       struct pci_dev *from);
> >  struct pci_dev *pci_get_subsys(unsigned int vendor, unsigned int devic=
e,
> > diff --git a/include/uapi/linux/pci_regs.h b/include/uapi/linux/pci_reg=
s.h
> > index e709ae8..deae275 100644
> > --- a/include/uapi/linux/pci_regs.h
> > +++ b/include/uapi/linux/pci_regs.h
> > @@ -983,6 +983,12 @@
> >  #define PCI_VSEC_HDR		4	/* extended cap - vendor-specific */
> >  #define  PCI_VSEC_HDR_LEN_SHIFT	20	/* shift for length field */
> > =20
> > +/* Vendor-Specific Extended Capabilities */
> > +#define PCI_VSEC_HEADER		4	/* Vendor-Specific Header */
> > +#define  PCI_VSEC_CAP_ID(x)	((x) & 0xffff)
> > +#define  PCI_VSEC_CAP_REV(x)	(((x) >> 16) & 0xf)
> > +#define  PCI_VSEC_CAP_LEN(x)	(((x) >> 20) & 0xfff)
>=20
> The VSEC #defines are a mess.  We have already have some duplication
> and inconsistent names.  But I think what you need is already there:
>=20
>   /* Vendor-Specific (VSEC, PCI_EXT_CAP_ID_VNDR) */
>   #define PCI_VNDR_HEADER         4       /* Vendor-Specific Header */
>   #define  PCI_VNDR_HEADER_ID(x)  ((x) & 0xffff)
>   #define  PCI_VNDR_HEADER_REV(x) (((x) >> 16) & 0xf)
>   #define  PCI_VNDR_HEADER_LEN(x) (((x) >> 20) & 0xfff)

Indeed, I'll use this instead.

>=20
> >  /* SATA capability */
> >  #define PCI_SATA_REGS		4	/* SATA REGs specifier */
> >  #define  PCI_SATA_REGS_MASK	0xF	/* location - BAR#/inline */
> > --=20
> > 2.7.4
> >=20

-Gustavo

