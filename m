Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 21B0231F1BE
	for <lists+dmaengine@lfdr.de>; Thu, 18 Feb 2021 22:33:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229620AbhBRVdy (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 18 Feb 2021 16:33:54 -0500
Received: from smtprelay-out1.synopsys.com ([149.117.87.133]:44418 "EHLO
        smtprelay-out1.synopsys.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229480AbhBRVdx (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 18 Feb 2021 16:33:53 -0500
Received: from mailhost.synopsys.com (sv2-mailhost1.synopsys.com [10.205.2.133])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id EB6C5C009A;
        Thu, 18 Feb 2021 21:32:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1613683972; bh=ddIo2qun7tXuJdbw+uqPkBPoyCGYYESEeYaxnrxckOE=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=lzQuHIFwiCdGjdlio7yLAtxTqI8ykt598NRP7O1ZRKUJ+asIwFXLihQVGMLlNDRoF
         3OUCGErNO3buzyp/oRIb/T2Ym2hGXGA39JYIX8P0dyLc+Zk0Qcpmi4o3Hh19kX6eLZ
         N7N4sD2bx0pD3tAL9m7jc/471Tm8Jube4vSlPs/lrC1nbqBljEUwfVzii19lVDdkDK
         lUlCu3srqVZMiH3ofx+nBcnPoU2HzXqL8qqa/P8ScTA9+yuveTqWEsEBnzU0hLN7W+
         R7cn3pXZvEsnIh0yw06FG2IdVmDOUQ6+4150IrkeGb71k1+RJBR9Lo069opeimcU9T
         fNLXrhumt136w==
Received: from o365relay-in.synopsys.com (us03-o365relay3.synopsys.com [10.4.161.139])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by mailhost.synopsys.com (Postfix) with ESMTPS id C574EA007C;
        Thu, 18 Feb 2021 21:32:50 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2048.outbound.protection.outlook.com [104.47.66.48])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "mail.protection.outlook.com", Issuer "DigiCert Cloud Services CA-1" (verified OK))
        by o365relay-in.synopsys.com (Postfix) with ESMTPS id 5DA6D8020F;
        Thu, 18 Feb 2021 21:32:49 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=gustavo@synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
        dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.b="sHb9/cit";
        dkim-atps=neutral
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LSEaySKC6eBoArL1qoEYApaoUxCTzqGU9rj3LpTTVA+vdAcmUw4H8mYixlH/J81F8ERw0LBr+Ibl+fsfsWeEMe1xZMsHXXexUXGIi+HGhsMmOqrBGb6bk/V9uCWe3ZSrci744qHYoZPMw+J/TQ+vnPDSaPA3+MX2glX99OMTOUYrrGgp4cveyeRL/TAOcOit7RpvC54wCuPrulHJC9uXLZtLRm75BS7XJXlk6sZJ2KJpxdmPL6dQqoi/F1SbU+RuetqKyha6cjEU7kXSlyRMSEmGy/vwJY6UJ1Gmi9hnSQHKBUwR4n7hoPkc2Hn/r7BMIvXwF31bBQb/A0AaNYONNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HHvjyCYtNX/xyEq4m+xLv3FrseCRTHPB57F6J92sLOI=;
 b=Xvn/g+j0NWJ/e2Iht3AfQ7H2372wqqaCJA2uCqczVnRIXJReEYAlRcgxqC6jd2nGH3Bhoij/Tl781ctowO+HrS30HS+JurZEPXAFdTnanwCY/U/snTONk8lYhTza42pj12ThNPkujXkM/aQwBb77lswADFrGLueaiBsMl6ieACK8/w8TdPXrTDgZ8gOryMJN0fEXHs5i8S4OysryI+mKcM/M+D35k6KPSFb9RGgi1n/2aHcBkLVx67HX9XHkRFByvzWbTyaYBTvdmMpJ69aTY1OM2cjFwEah14w1nqEWEGznDPGYPwlrBIkYWkm5vRTT41JYWp6NyikNO7B/gDEMUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HHvjyCYtNX/xyEq4m+xLv3FrseCRTHPB57F6J92sLOI=;
 b=sHb9/citLc3TkbfxeRv7tsLs+34rknx+FVUCbXGCvpHSEe4fAgIVvRZLLUTiu5MM7lPkfaTtmjvOKqPgivbnLYKJA6HOrHIeofmmHrm/gC5gWLuvhUGe0XQDpzbbKIvs9WAedapvlupbxnpKR0bR3pcc0/AiGY42BFlk5TDDuUc=
Received: from DM5PR12MB1835.namprd12.prod.outlook.com (2603:10b6:3:10c::9) by
 DM6PR12MB4603.namprd12.prod.outlook.com (2603:10b6:5:166::11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3846.31; Thu, 18 Feb 2021 21:32:47 +0000
Received: from DM5PR12MB1835.namprd12.prod.outlook.com
 ([fe80::508b:bdb3:d353:9052]) by DM5PR12MB1835.namprd12.prod.outlook.com
 ([fe80::508b:bdb3:d353:9052%10]) with mapi id 15.20.3846.042; Thu, 18 Feb
 2021 21:32:47 +0000
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
Subject: RE: [PATCH v7 04/15] PCI: Add pci_find_vsec_capability() to find a
 specific VSEC
Thread-Topic: [PATCH v7 04/15] PCI: Add pci_find_vsec_capability() to find a
 specific VSEC
Thread-Index: AQHXBijd7zQo6MkWdka+0DNnEoObP6peS+AAgAAiWoA=
Date:   Thu, 18 Feb 2021 21:32:47 +0000
Message-ID: <DM5PR12MB183517EF9646E366F3F657A7DA859@DM5PR12MB1835.namprd12.prod.outlook.com>
References: <d89506834fb11c6fa0bd5d515c0dd55b13ac6958.1613674948.git.gustavo.pimentel@synopsys.com>
 <20210218192730.GA996712@bjorn-Precision-5520>
In-Reply-To: <20210218192730.GA996712@bjorn-Precision-5520>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: =?iso-8859-2?Q?PG1ldGE+PGF0IG5tPSJib2R5LnR4dCIgcD0iYzpcdXNlcnNcZ3VzdGF2b1?=
 =?iso-8859-2?Q?xhcHBkYXRhXHJvYW1pbmdcMDlkODQ5YjYtMzJkMy00YTQwLTg1ZWUtNmI4?=
 =?iso-8859-2?Q?NGJhMjllMzViXG1zZ3NcbXNnLWQ1Y2VhYWIzLTcyMzAtMTFlYi05OGU3LW?=
 =?iso-8859-2?Q?Y4OTRjMjczODA0MlxhbWUtdGVzdFxkNWNlYWFiNS03MjMwLTExZWItOThl?=
 =?iso-8859-2?Q?Ny1mODk0YzI3MzgwNDJib2R5LnR4dCIgc3o9IjM3NzEiIHQ9IjEzMjU4MT?=
 =?iso-8859-2?Q?U3NTY0NjIwOTM5NSIgaD0iZEI2ZXZTK1hwaGVyYWhTNzluQ2JlVXN2VUpF?=
 =?iso-8859-2?Q?PSIgaWQ9IiIgYmw9IjAiIGJvPSIxIiBjaT0iY0FBQUFFUkhVMVJTUlVGTk?=
 =?iso-8859-2?Q?NnVUFBQlFKQUFCelpTZVlQUWJYQWQrdDlXYjRhN2pKMzYzMVp2aHJ1TWtP?=
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
x-ms-office365-filtering-correlation-id: 33fe94a2-5269-471d-33e1-08d8d454bc64
x-ms-traffictypediagnostic: DM6PR12MB4603:
x-microsoft-antispam-prvs: <DM6PR12MB4603EBB89B549443B2A352A8DA859@DM6PR12MB4603.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 1qf8lwqpalBE8sc6VKwxqqoJhus/P6z7tUV3o6hr+FQsFbWLNmih6sM0ffkG8Wf8f96Ij1q30pcZ5Agyandhb1cxuVFIblRy19uSg7mp91/e8YHcm0WUfZzKydl7fWrKSfqsK9vBcl5+VVerIm+F3qcbPry17XB+Z+BBZPgaJyjTeTrM7a8JIMIK/ugVhXJN0GddBjZa5B0iZVAvIvlvb7gJCO2A3/UGA6hDQ4H+WmXZemqcrhJijNviV4gCVWSGxPBZU+ih9C1pUtT6zVUM7JOJKMrndBzbVgMp8CCdfs7b65wtl/MEe0WQvzP2uwHHbfMo37jXW7EzeW8RDayKxzax+MAPsvXlLo29QE6x8vBVp6Qoqr1V4LFmAGVdxNut6PmR28o73P38l2lm2Dj/iIvpV82MpMsNMgiLeLTN/qr9RKGiqSgNY3Mej17CUSvzE+unKNY1bgZznVl+QihQOC0OjnpTEKGY3hhqBDyQuNR3CoV0vncvs7atu1+Vebw+fGwd6nPaOB6+o8on0c4gk053bAWzEsmfXfRlMhRrH1rf0KGpILhL/vgyVflTbc/R
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR12MB1835.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(346002)(136003)(366004)(39860400002)(376002)(396003)(55016002)(33656002)(52536014)(8936002)(66446008)(6506007)(66476007)(86362001)(7696005)(186003)(76116006)(478600001)(4326008)(2906002)(26005)(5660300002)(8676002)(54906003)(316002)(66556008)(64756008)(53546011)(9686003)(83380400001)(66946007)(6916009)(71200400001)(37363001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?iso-8859-2?Q?AF8uDP1G0sgizKsbgh44ScOTTloC3rXv+37xxwgmAKpUxIoNexBpvtfy0G?=
 =?iso-8859-2?Q?fwbtne+fSqeHl9uQAUM/+RRisvFue3fgye78fO342VcTiYR75MyghjfFXJ?=
 =?iso-8859-2?Q?SZeANfaRw6NxE1QmtykgjHcMY1e3Wb/E/kEZ8DkOaLBi2M40deMAlu3J5w?=
 =?iso-8859-2?Q?P+lsI2hf1bQs1ME5rWk24v8OFsuTFjrM3qZ23/yhNU3c+o5ocZM1Echllh?=
 =?iso-8859-2?Q?UERg0DE1Iboj8u3/+z24IWD4stajueSZc02/f4SpRjulsl4I/Aq9/JzT1I?=
 =?iso-8859-2?Q?asHipoUzRNdNmmtk4u872bkIT5LwRBQtWJssSC5seQsJGuWAA6w04dGYJ2?=
 =?iso-8859-2?Q?8kKNu84W4o0p3/M1jTH04v34XC4MnmycRoPKdO0THjY2Hp8es4GDfqPygl?=
 =?iso-8859-2?Q?tGvAzKHmgByQ1eH9VLZEhuEGxS4keKvvd2xXVbwkbdrjFJqfccHVOdLj/r?=
 =?iso-8859-2?Q?f05+8vCjEebe3s/ANsFwkjFPFXTT1ELAKyRNS92z7eVboRiwWQ8/sh5hko?=
 =?iso-8859-2?Q?8Bab0zCJhfbsECati+gS2b9vRCo+nvaDuPPRZ6Uzx/io97PAnj/szWcugL?=
 =?iso-8859-2?Q?yHWsWIanuBxIw7WBX0j4VKPDHyOMBL7s+K4F60ZuRiK6P2X6tHO3M1lQCM?=
 =?iso-8859-2?Q?owOsASYcVQUdIay+/0DjlQN/HJ4UP+kPjd6EintWxDzloHrCkxGyUOmL1r?=
 =?iso-8859-2?Q?yF0k3gIJnzmGUgmsDhRG0+yo3PrP7Rff1OdvXdlmeFlIzQiyF/OAGWpphY?=
 =?iso-8859-2?Q?PaiyfpgVw5oCYFS9UMtjaJ6RMz/nVUiIHbWe+Xf87Q3H8pvVSwIp25qw9u?=
 =?iso-8859-2?Q?44lxnPMnk1d1ZGq3yOtrNcst9AluhM9hSDQ7tsfLt41/p5IBJ8lzKJKBHM?=
 =?iso-8859-2?Q?BnK2xzMjC2pdYffspySp/M+x+utYBdIXyXhwr3/wt85dDU15TTkZuZs+Gg?=
 =?iso-8859-2?Q?MBAImOW/XquWva1wLzQ64s7vpvgOOXnf2tqnZg0yOAIG+mkGcomsh9mPF2?=
 =?iso-8859-2?Q?ThrSxJYuTEw2AUrIlwX6g7S67tKhJk3RUSmcWO0oVbXARcPOtoVYEHok+C?=
 =?iso-8859-2?Q?Xgjn99dOLgEXoql6ksb9MbUdPfSnv9CVmA7O+yGNqMWmakdh+SyHdswUOb?=
 =?iso-8859-2?Q?2q6DlhksVSX60G/xOJeFoUMOqY0g9p2Tci0I2S2njjBRUiuUMK+Z2KJE1U?=
 =?iso-8859-2?Q?UrsBTO/Mxa4e5WCWDbQWNLicAzrFlIRzRBK3tHEcYUKbmufPS9clAu0L1I?=
 =?iso-8859-2?Q?bd4nJ40jr3tYFzYdH+nM8MA99w0rVntk8bknp/GuSS33fgm1qUxcWmPuu1?=
 =?iso-8859-2?Q?DTYk4Tdh3D4um8kmEYiGn2DcwgMu7+HBuaHRarS60wT3WkT5DSxG0fksaB?=
 =?iso-8859-2?Q?1FdKJ32nNt?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="iso-8859-2"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB1835.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 33fe94a2-5269-471d-33e1-08d8d454bc64
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Feb 2021 21:32:47.4770
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: udM5JqQt3hsR1mUPccmYckjcBYG3BnapC0TLT0YmJq4KaB1Oc0AeC0Kbb0JwMbbVN7tqGKBD92Z3jYN70x1J3Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4603
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Thu, Feb 18, 2021 at 19:27:30, Bjorn Helgaas <helgaas@kernel.org>=20
wrote:

> On Thu, Feb 18, 2021 at 08:03:58PM +0100, Gustavo Pimentel wrote:
> > Add pci_find_vsec_capability() to locate a Vendor-Specific Extended
> > Capability with the specified VSEC ID.
> >=20
> > The Vendor-Specific Extended Capability (VSEC) allows one or more
> > proprietary capabilities defined by the vendor which aren't standard
> > or shared between vendors.
> >=20
> > Signed-off-by: Gustavo Pimentel <gustavo.pimentel@synopsys.com>
>=20
> Beautiful, thanks!
>=20
> Acked-by: Bjorn Helgaas <bhelgaas@google.com>
>=20
> > ---
> >  drivers/pci/pci.c   | 30 ++++++++++++++++++++++++++++++
> >  include/linux/pci.h |  1 +
> >  2 files changed, 31 insertions(+)
> >=20
> > diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> > index b9fecc2..aef217c 100644
> > --- a/drivers/pci/pci.c
> > +++ b/drivers/pci/pci.c
> > @@ -693,6 +693,36 @@ u8 pci_find_ht_capability(struct pci_dev *dev, int=
 ht_cap)
> >  EXPORT_SYMBOL_GPL(pci_find_ht_capability);
> > =20
> >  /**
> > + * pci_find_vsec_capability - Find a vendor-specific extended capabili=
ty
> > + * @dev: PCI device to query
> > + * @vendor: Vendor ID for which capability is defined
> > + * @cap: Vendor-specific capability ID
> > + *
> > + * If @dev has Vendor ID @vendor, search for a VSEC capability with
> > + * VSEC ID @cap. If found, return the capability offset in
> > + * config space; otherwise return 0.
> > + */
> > +u16 pci_find_vsec_capability(struct pci_dev *dev, u16 vendor, int cap)
> > +{
> > +	u16 vsec =3D 0;
> > +	u32 header;
> > +
> > +	if (vendor !=3D dev->vendor)
> > +		return 0;
> > +
> > +	while ((vsec =3D pci_find_next_ext_capability(dev, vsec,
> > +						     PCI_EXT_CAP_ID_VNDR))) {
> > +		if (pci_read_config_dword(dev, vsec + PCI_VNDR_HEADER,
> > +					  &header) =3D=3D PCIBIOS_SUCCESSFUL &&
> > +		    PCI_VNDR_HEADER_ID(header) =3D=3D cap)
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
> > index b32126d..814f814 100644
> > --- a/include/linux/pci.h
> > +++ b/include/linux/pci.h
> > @@ -1077,6 +1077,7 @@ u8 pci_find_next_ht_capability(struct pci_dev *de=
v, u8 pos, int ht_cap);
> >  u16 pci_find_ext_capability(struct pci_dev *dev, int cap);
> >  u16 pci_find_next_ext_capability(struct pci_dev *dev, u16 pos, int cap=
);
> >  struct pci_bus *pci_find_next_bus(const struct pci_bus *from);
> > +u16 pci_find_vsec_capability(struct pci_dev *dev, u16 vendor, int cap)=
;
>=20
> If you do any updates for other reasons, slide this up one more line
> so we have:
>=20
>   u16 pci_find_ext_capability(struct pci_dev *dev, int cap);
>   u16 pci_find_next_ext_capability(struct pci_dev *dev, u16 pos, int cap)=
;
>   u16 pci_find_vsec_capability(struct pci_dev *dev, u16 vendor, int cap);
>=20
>   struct pci_bus *pci_find_next_bus(const struct pci_bus *from);
>=20
> I don't know why pci_find_next_bus() got stuck with the capability
> things.  It doesn't have anything to do with finding capabilities.  It
> goes more with pci_get_device(), etc.
>=20
> But don't roll the series just for that.

Thanks, Bjorn.
I can those arrangements if some request comes along.
I can also move the pci_find_next_bus() next to the pci_get_device() if=20
you like.

-Gustavo

>=20
> >  u64 pci_get_dsn(struct pci_dev *dev);
> > =20
> > --=20
> > 2.7.4
> >=20


