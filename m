Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 70298312CC8
	for <lists+dmaengine@lfdr.de>; Mon,  8 Feb 2021 10:08:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230422AbhBHJIf (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 8 Feb 2021 04:08:35 -0500
Received: from smtprelay-out1.synopsys.com ([149.117.87.133]:49590 "EHLO
        smtprelay-out1.synopsys.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231391AbhBHJEA (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 8 Feb 2021 04:04:00 -0500
Received: from mailhost.synopsys.com (badc-mailhost1.synopsys.com [10.192.0.17])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 43C2DC00AA;
        Mon,  8 Feb 2021 09:02:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1612774959; bh=fD60HcuRa9SaRB6iuoF1HAYKIk7KKRRPpxKJsR1dmA0=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=eKH6/o5X81tpa+0qpY5zGAIKa5D5t4QQP+tkHwZzzvnmWOE5K9uJm1ZmCax+HxRZz
         Qx3HtvPAFed652QFeakZyCXuUbAbba6r20OUsHVUv5XLnKLdYYEdnJZHIC2uPMh5aL
         h3K19qxGqAEiq41Ndk467VEtKbFDdRtb2lPxB3dFiSQkX3y3Jbaq2h9ugeE2P1EHy1
         S+PFbolzFwhJ+lNilDQeSxIXHrdMG4ZtbBgsWX6SMGAX0IESf736ByFT0Kc7RDN6iB
         Ve9JmzvWu52lQNvmNoPak60JuHgiXKetilHzJR5VaA0QM3l7789UyUjtLidP9dSqG2
         7gT4tIZcM3+Sw==
Received: from o365relay-in.synopsys.com (us03-o365relay3.synopsys.com [10.4.161.139])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by mailhost.synopsys.com (Postfix) with ESMTPS id A4F6EA0083;
        Mon,  8 Feb 2021 09:02:37 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11lp2175.outbound.protection.outlook.com [104.47.56.175])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "mail.protection.outlook.com", Issuer "GlobalSign Organization Validation CA - SHA256 - G3" (verified OK))
        by o365relay-in.synopsys.com (Postfix) with ESMTPS id A0AF58020F;
        Mon,  8 Feb 2021 09:02:35 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=gustavo@synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
        dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.b="pM2aeUZn";
        dkim-atps=neutral
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=E161IAAf8+wrJFNABIEmnU2lYdYQNqEiHtShMBlC3eRhHx4BBubLexdNNgu+UG4vXDOSXCsfLYk/e/F8D9bCI5EotjBo+Ex5D5J88Cb1E9ezS8efepwJRfi5Ftpy+ieLP5vh2ItaCBcjcpHNyaWHbS8Er8jg8mHET6pYO1MSvz00pDLZ69KnBHTk9BU5a4EFHnPTAGUZIyvOSPAH1z4zophvxwqL1eplxOrNm2jOuWTgMyb52Wm8H9RLD0peOnxYQCpWzsYdGOn0lzWRoHEKfKx1rvhfP1o46lfmF+YOxE7f5seuxQDPMsTtpR8ntOanSyxJxg376QjxCIqUzv0u3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=j+OOXKPgEiJfOH3cAGpx4nYcq7lCNY6m8XwQzPGSI2k=;
 b=aA0teT+GuhJ4yHixJphwFOkVSWajf1fIBLkTtiSJSovKrkrl2piQUvklMxGyBH/mr5/H7ywecxqErVNU0q0OhwoUgz/wkAgSmihoS09C7h6BZ8cgY6K5wdP5Y6zeAXYzHiEgKvC4E1tzMQMcaPFuizXdirZTW2l+3iXlDCSekHyns5LldV7kVecvPOa8QW0pKSnwI4YG6DfZJ+mMrQlQ2abmISJbVo/YTGIWnohBrVTG0tuNMWDErLk80kkOX3+1uRQDSErfmfRQH3zhmut9gi+Bh20X27euLtem/DlCCdL4fNfp6AH7VvhRJnsPiQLtr1JMelZAqkpFpWFr3eHsag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=j+OOXKPgEiJfOH3cAGpx4nYcq7lCNY6m8XwQzPGSI2k=;
 b=pM2aeUZntGFgqvWYW7cxZaaZE6ROMWCZ9GKoZT8gwGj6LwnLRXcNAADbf3wrZmzd+xBKnco1WGNcYxzl9HodyVCxsINzdE+EE69hAwRvGIV1ywEpAzFEUO5e4M+hZGyyZu4QnOdH1uBdjMtBr5BS5LOPLnVro3ZQ5TCl9gBF/fQ=
Received: from DM5PR12MB1835.namprd12.prod.outlook.com (2603:10b6:3:10c::9) by
 DM6PR12MB4124.namprd12.prod.outlook.com (2603:10b6:5:221::20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3825.27; Mon, 8 Feb 2021 09:02:33 +0000
Received: from DM5PR12MB1835.namprd12.prod.outlook.com
 ([fe80::508b:bdb3:d353:9052]) by DM5PR12MB1835.namprd12.prod.outlook.com
 ([fe80::508b:bdb3:d353:9052%10]) with mapi id 15.20.3825.030; Mon, 8 Feb 2021
 09:02:33 +0000
X-SNPS-Relay: synopsys.com
From:   Gustavo Pimentel <Gustavo.Pimentel@synopsys.com>
To:     Leon Romanovsky <leon@kernel.org>
CC:     "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>,
        Derek Kiernan <derek.kiernan@xilinx.com>,
        Dragan Cvetic <dragan.cvetic@xilinx.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jonathan Corbet <corbet@lwn.net>
Subject: RE: [RESEND PATCH v3 3/5] misc: Add Synopsys DesignWare xData IP
 driver to Kconfig
Thread-Topic: [RESEND PATCH v3 3/5] misc: Add Synopsys DesignWare xData IP
 driver to Kconfig
Thread-Index: AQHW+YRmGBnxvsJypEizlZ4KoFWTsKpN5okAgAAYmxA=
Date:   Mon, 8 Feb 2021 09:02:33 +0000
Message-ID: <DM5PR12MB183571E6A6B1A8F23E6DE1E4DA8F9@DM5PR12MB1835.namprd12.prod.outlook.com>
References: <cover.1612284945.git.gustavo.pimentel@synopsys.com>
 <850ba8b075a65f753bbb802b9af23839624908bd.1612284945.git.gustavo.pimentel@synopsys.com>
 <20210208073408.GC4656@unreal>
In-Reply-To: <20210208073408.GC4656@unreal>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: =?us-ascii?Q?PG1ldGE+PGF0IG5tPSJib2R5LnR4dCIgcD0iYzpcdXNlcnNcZ3VzdGF2b1xh?=
 =?us-ascii?Q?cHBkYXRhXHJvYW1pbmdcMDlkODQ5YjYtMzJkMy00YTQwLTg1ZWUtNmI4NGJh?=
 =?us-ascii?Q?MjllMzViXG1zZ3NcbXNnLTVlMjRiZjFiLTY5ZWMtMTFlYi05OGU2LWY4OTRj?=
 =?us-ascii?Q?MjczODA0MlxhbWUtdGVzdFw1ZTI0YmYxZC02OWVjLTExZWItOThlNi1mODk0?=
 =?us-ascii?Q?YzI3MzgwNDJib2R5LnR4dCIgc3o9IjEwOTQiIHQ9IjEzMjU3MjQ4NTQ4Nzgw?=
 =?us-ascii?Q?NzA5NSIgaD0iR1RpN2NLVWhkRW1MMDdhNlh3ZXdHVzZnQlpVPSIgaWQ9IiIg?=
 =?us-ascii?Q?Ymw9IjAiIGJvPSIxIiBjaT0iY0FBQUFFUkhVMVJTUlVGTkNnVUFBQlFKQUFC?=
 =?us-ascii?Q?M3luMGcrZjNXQVVjTXZJL2hwcVQ4Und5OGorR21wUHdPQUFBQUFBQUFBQUFB?=
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
x-ms-office365-filtering-correlation-id: e316b34c-9b53-4be9-46da-08d8cc1045bc
x-ms-traffictypediagnostic: DM6PR12MB4124:
x-microsoft-antispam-prvs: <DM6PR12MB412412719995DF6E030BBDECDA8F9@DM6PR12MB4124.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4714;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: KRHrbMo6C8TfZgG5t8+3+InzAuVXqs8g8b15B+J37orgVy6p2tvtZePL7a/0x80eWgXStaohV6RQhrBZtgT9FAaRVFbjIPcYrFjkPNR4UXzIXJu4X1olOxEK0kC9diZHGp2kz5hHu79t+sz5ZF7uyNdRpC+BmfiVcSAjPPF8KdOXidFgw4ob1IlnfTH7NsV/XNykKhAeF/kvqu8Xy3T9tkTOL7S7GB2J7KzOTTYiL1lakEeS1iS8c91Z0oQ2NHTg9csUjXaMTfNPPJBhCVHurU7FcI9FUVF0RJx+m6zTKJx61HTZ1VcRNKvCmR9iPKCE7F5xyKktSOSyveq3j4grgHe+kTxIVUUBJGiufFskxrWzFxgm5put9eEmm9CL73SKi2jY46ggi0rRMTJLnZlzzA5MXNcL1oim5lQKHZZL1k1rUbctabTz4gryNfnEBaGXrhXpKkD86+LqhE7EreuEHTJYzeIs1WTK01HsNluOCM10MC2Mclexmf1wzDXSAeeQ9xmKSnbk217p/5g3HvxSCQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR12MB1835.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(376002)(346002)(39860400002)(396003)(366004)(136003)(186003)(54906003)(26005)(64756008)(316002)(33656002)(66946007)(76116006)(53546011)(7416002)(66556008)(71200400001)(6506007)(9686003)(4744005)(55016002)(8936002)(6916009)(7696005)(86362001)(2906002)(5660300002)(52536014)(66476007)(8676002)(66446008)(478600001)(4326008);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?G0/ieCqApZ2S1bpxOSVEqW1PzNXnq4AY3sp77gp7fxKK2edTafuaSCfGTpTY?=
 =?us-ascii?Q?DN7o7UZ/DXOJ5VkltuQjgNFVIt9CUyuE+6Nio/7134B3TexAMoBFfP99956X?=
 =?us-ascii?Q?JoVI1lklxLm/6q7nuY8mJ9H99upX89iBIcqKGwVuS+RMKvGSg3pECyid+cge?=
 =?us-ascii?Q?jQoY5JRzEKrZxICrEZjlNRSfEDFDl6gXxhp3e2v/voWTnovtT00+c3czKy+Y?=
 =?us-ascii?Q?TUjOz9jK7ZUiFTQ1opx1hFxD0wX6/i9cqmmuMLakyigVuwk5FSZ0Ic2ygS5H?=
 =?us-ascii?Q?aLD0uRrDz17SqgOkQFYwHdl2FhmqbOXH4u3z9j3Yty4AmKn3IRGQPZu2jYBF?=
 =?us-ascii?Q?veU1U47DdpL4q4k9DxLSqSjqGBWgHYLoDI3aSocROQTSTq/LJLnsTk0PLJ1g?=
 =?us-ascii?Q?FWLlZfTDdhkQsuxhFxPd94iyVhpHvW2WVwR3X8FI9pTRk7/utYGPnx1wkXTB?=
 =?us-ascii?Q?bNalz2uZ0D/mf0it8fi9C7ytuIF6J6sVcbio8vBYaaBcNJVCbLgtNrD5nUGL?=
 =?us-ascii?Q?PriCCJQo7XgFYRxIY7fHKASQ5/WHWhvkekxzbjcazlFLKp7OIsT1RY+e16A0?=
 =?us-ascii?Q?CdngkV7dg0pe8U/FQczvguY1MUJC2MDgDx2B2uRa87u5RQ6vBJtyHQHpO392?=
 =?us-ascii?Q?b3FQymmQw3KE5Bs6YH/jTGho17IhFJoz4zy3fj8VE9A8g3O/n/xM92w0/fXb?=
 =?us-ascii?Q?lgIdsan4Hry3uM7Cm/wpI48ktgFMd7eQlIsu+yrFbtL9Tsr20Hvezq6Opyan?=
 =?us-ascii?Q?GRd6iqRCwxOp7Cg2dAZBwaSABzD7Ahwxs+KpnEZh4CX42f9XXYx1MGT5YpYg?=
 =?us-ascii?Q?qKGG2jWLA0syVa/FZya2H0+uRS/htHpkn0F9cUuiTmqcfaO83K9TGSESc3Q3?=
 =?us-ascii?Q?+VzjkTGFEkSVbAR1RIw/Htf0yDONK6rxFhuBM9S0Zr8YJIa48LYsZuXxYP7B?=
 =?us-ascii?Q?znwE58WnQntYGDHBukPHTaETDrnZDoxtwYy/1JUxBlNv4+84sAKjAUtLa240?=
 =?us-ascii?Q?AfjHIKD/Kfwd5BKL2SWSPJWaM8Ld/KZnULjveU3cVJCdRWWxhs5fDJuqXkT6?=
 =?us-ascii?Q?TF7VWukzkGytPMQrmwrhrX30TwIPmt4a9GTUGp1oL06ZRS4D7U4ufbc/4zB2?=
 =?us-ascii?Q?EMHu/UADmygKeCLxKHu2ilNnhLdsl4eryzrawukVlK0K+StuHkDdMqERJgpQ?=
 =?us-ascii?Q?Ap7h/TPwB5Br4ggsQoDDP+slLiQLEUjj4QYEulIslyoR45Lpefba4GwfgShE?=
 =?us-ascii?Q?jL1EtlzwD2GKcQRPPsDFAiRjSA2w9bIdQehTE6yLszlIIlKyKmOA5a5Ay1UO?=
 =?us-ascii?Q?fQI=3D?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB1835.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e316b34c-9b53-4be9-46da-08d8cc1045bc
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Feb 2021 09:02:33.3625
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6KdOPQ2/avdijPXmu7LwAzbNpQoh6/CYUBGBrts38Z1r04WXwFCdmNvG1sRkJfdy4T7TiC+B665M9wnOmB0lWw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4124
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Mon, Feb 8, 2021 at 7:34:8, Leon Romanovsky <leon@kernel.org> wrote:

> On Tue, Feb 02, 2021 at 05:56:36PM +0100, Gustavo Pimentel wrote:
> > Add Synopsys DesignWare xData IP driver to Kconfig.
> >
> > This driver enables/disables the PCIe traffic generator module
> > pertain to the Synopsys DesignWare prototype.
> >
> > Signed-off-by: Gustavo Pimentel <gustavo.pimentel@synopsys.com>
> > ---
> >  drivers/misc/Kconfig | 11 +++++++++++
> >  1 file changed, 11 insertions(+)
> >
> > diff --git a/drivers/misc/Kconfig b/drivers/misc/Kconfig
> > index fafa8b0..6d5783f 100644
> > --- a/drivers/misc/Kconfig
> > +++ b/drivers/misc/Kconfig
> > @@ -423,6 +423,17 @@ config SRAM
> >  config SRAM_EXEC
> >  	bool
> >
> > +config DW_XDATA_PCIE
> > +	depends on PCI
> > +	tristate "Synopsys DesignWare xData PCIe driver"
> > +	default	n
>=20
> "N" is a default option and not needed to be stated explicitly.

Ok, I will remove it.
Thanks.

>=20
> Thanks


