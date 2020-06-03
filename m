Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 74FA01ECF1A
	for <lists+dmaengine@lfdr.de>; Wed,  3 Jun 2020 13:54:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725920AbgFCLyn (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 3 Jun 2020 07:54:43 -0400
Received: from smtprelay-out1.synopsys.com ([149.117.73.133]:36606 "EHLO
        smtprelay-out1.synopsys.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725855AbgFCLyn (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 3 Jun 2020 07:54:43 -0400
Received: from mailhost.synopsys.com (badc-mailhost1.synopsys.com [10.192.0.17])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id C8970408FF;
        Wed,  3 Jun 2020 11:54:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1591185282; bh=ZPmvIx9v6A75QbssjM3GOZt4rawASRcRDqXedcOE4RU=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=c5LOvOfoLJtV8uyVNc8C4eeZVRMwDDPN5X687QdMClxu0nuHrx/to9OJu+44eH6mI
         Ohr5ZRTeab8amVZ7YxLuugvSyBotwzBKHeO6yffAZTleWZ3pB3V4I39Xm4WFrFly5h
         /Zevi1gaENr5mAN0mmFIZXJmT0TXuoS1Ac82FElh6F41ZhckM5zABHoaZdcYOenAmi
         4dOy1dEEQLLov3vNDPv1SubtnBVkbwfBmunZvxqyM0Eu0B0S7LP5xeeOEZm6MzrJYi
         1TZJjZBtVweO36il7iI/agJIMOeT1AWkWD5HBFBBOg7FsfpZA+IOzzZDUAwzKqpN23
         yLFJOxoj5WjOQ==
Received: from US01WEHTC3.internal.synopsys.com (us01wehtc3.internal.synopsys.com [10.15.84.232])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by mailhost.synopsys.com (Postfix) with ESMTPS id 57432A0079;
        Wed,  3 Jun 2020 11:54:41 +0000 (UTC)
Received: from US01HYBRID2.internal.synopsys.com (10.15.246.24) by
 US01WEHTC3.internal.synopsys.com (10.15.84.232) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Wed, 3 Jun 2020 04:54:41 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (10.202.3.67) by
 mrs.synopsys.com (10.15.246.24) with Microsoft SMTP Server (TLS) id
 14.3.487.0; Wed, 3 Jun 2020 04:54:41 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=l+zmVrGhKA7maahiIzL/mX2XaIONKCtSXxEm5LJ3dgDBsY7VoNTPuyJrWBk1JcwKlHHz2oTM8pFwTOtyG99fJ22NCFvls1RTgc60FnJ5A0US316iDX1x3sXi3JSpPnhXeVP9qfZjxPQlOB9NGUbqmPXAeeqr1OOfNoMjviqj8X89Maz3pouOz42OE+twPD+Vwf/B9WYFUyDRdqqFcFJ8uvQ1R8lX7rAuWiKDyun+jlnIQqRuCzyAZvVh0DpL6e4OPON64Nxjc1DwmsANCQRo0u3UHEDMAKWfXv8MwwyNCDpGij69UgAbzX56lkFDGIjZeXfQgANS2/EkZqll4aSV8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=skiyuEg0DCN6XGA/lZgEHxOdu3jMemA5+EssKCcVFJg=;
 b=cert90zNCRdCoC1eKNQ2wMQsu/DSwu6nItxqDomDN6jAYlmoTlxpmIJw6JAh8xrYWLkx3hBqYjXHhz1L+py8ruhnJDQZXIyITwgdMbO+pa5pBC8eEHwNLV+U2WP5QvyChd2viPN62OLZSmbZBp2SVtloQCrX6/EMRdDXh5ILNwxsRle0VucF8+CYXMtciKzf7/iWqUDQIRs6zE12YU5ak87EjW45Iq4vGYhL2AIknpwMg2VQ0gEtWpmTmdO/LKeN5i8wzEMLv4gq5k0BmGJQy6/h8kmWGsxdD2VON2MlZiASQ14takt6t3IraFqzwqohy0Xx4dNQH1WY3LH1R7AgEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=skiyuEg0DCN6XGA/lZgEHxOdu3jMemA5+EssKCcVFJg=;
 b=F/CMZHqa+ZwvbwNrxBZYap2M5MzkH0kz9OfvT7h9CDbhbsuFr/u4GO4G1LFI4PB1lNF40DA56SCuk8jMl2mkBIeRTyJ62F5JLRKZTpOHGNk4ePcSz3UbcTAKC6rqBN9vj/XRFBnEbGgWX+YvPErfrCbD5yUsa6XxUUTKegOq+mE=
Received: from DM5PR12MB1276.namprd12.prod.outlook.com (2603:10b6:3:79::18) by
 DM5PR12MB2344.namprd12.prod.outlook.com (2603:10b6:4:b2::24) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3045.21; Wed, 3 Jun 2020 11:54:39 +0000
Received: from DM5PR12MB1276.namprd12.prod.outlook.com
 ([fe80::f533:4c74:1224:cd32]) by DM5PR12MB1276.namprd12.prod.outlook.com
 ([fe80::f533:4c74:1224:cd32%5]) with mapi id 15.20.3045.024; Wed, 3 Jun 2020
 11:54:39 +0000
X-SNPS-Relay: synopsys.com
From:   Gustavo Pimentel <Gustavo.Pimentel@synopsys.com>
To:     Piotr Stankiewicz <piotr.stankiewicz@intel.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
CC:     Vinod Koul <vkoul@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Andy Shevchenko <andriy.shevchenko@intel.com>,
        Arnd Bergmann <arnd@arndb.de>,
        "dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v2 06/15] dmaengine: dw-edma: Use PCI_IRQ_MSI_TYPES  where
 appropriate
Thread-Topic: [PATCH v2 06/15] dmaengine: dw-edma: Use PCI_IRQ_MSI_TYPES
  where appropriate
Thread-Index: AQHWOZzgUwEOIvFVrEadc9ugjRq/mqjGyD6g
Date:   Wed, 3 Jun 2020 11:54:39 +0000
Message-ID: <DM5PR12MB1276930635BA97CE92B2126FDA880@DM5PR12MB1276.namprd12.prod.outlook.com>
References: <20200603114212.12525-1-piotr.stankiewicz@intel.com>
 <20200603114745.13212-1-piotr.stankiewicz@intel.com>
In-Reply-To: <20200603114745.13212-1-piotr.stankiewicz@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: =?us-ascii?Q?PG1ldGE+PGF0IG5tPSJib2R5LnR4dCIgcD0iYzpcdXNlcnNcZ3VzdGF2b1xh?=
 =?us-ascii?Q?cHBkYXRhXHJvYW1pbmdcMDlkODQ5YjYtMzJkMy00YTQwLTg1ZWUtNmI4NGJh?=
 =?us-ascii?Q?MjllMzViXG1zZ3NcbXNnLWZmNjg1MDA3LWE1OTAtMTFlYS05OGI4LWY4OTRj?=
 =?us-ascii?Q?MjczODA0MlxhbWUtdGVzdFxmZjY4NTAwOS1hNTkwLTExZWEtOThiOC1mODk0?=
 =?us-ascii?Q?YzI3MzgwNDJib2R5LnR4dCIgc3o9IjEyMzciIHQ9IjEzMjM1NjU4ODc3NzI3?=
 =?us-ascii?Q?MDIyMyIgaD0iVVBLKzg1c0VFZTNZQWt3UDRTTGRBcmFra0ZFPSIgaWQ9IiIg?=
 =?us-ascii?Q?Ymw9IjAiIGJvPSIxIiBjaT0iY0FBQUFFUkhVMVJTUlVGTkNnVUFBQlFKQUFE?=
 =?us-ascii?Q?UGE4REJuVG5XQWNleVlYRGJ2Y3gxeDdKaGNOdTl6SFVPQUFBQUFBQUFBQUFB?=
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
authentication-results: intel.com; dkim=none (message not signed)
 header.d=none;intel.com; dmarc=none action=none header.from=synopsys.com;
x-originating-ip: [83.174.63.141]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a7057dcc-8859-4152-7811-08d807b4e56f
x-ms-traffictypediagnostic: DM5PR12MB2344:
x-microsoft-antispam-prvs: <DM5PR12MB2344F23134336F04CEFBEC8FDA880@DM5PR12MB2344.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1923;
x-forefront-prvs: 04238CD941
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: g/33/k/6WeW79I7efADiU2vOlaf34oY+F0LZwee+hidV49PfnHTkGUc1aNRiSeiDnP+bAjjObnY/X8vKC9oYlLIC1gowZoAs3UulufhziMssTedKeQNIe5cFJjzTebiWejF1C/IyF/KMWVxXb7UVwU+d7nB/fforvlypoWhkeVeu+YguCIBIAGgyTL7H6a3x31SoGcdbQFKS3MU/vrlsfdRawA7ZO4tXNG6ouBeNVu4BRUe8nA/QuHPhyDvTLvVgTDoZ0PP1bxUEmrZL5NXBVt9rG8+0KgFqeVcGiwScURmpEaQGk76ocubP+ByZaGryy8Es/3AyiopSXRiBQ1qeaQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR12MB1276.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(376002)(39860400002)(346002)(366004)(136003)(396003)(6506007)(4326008)(26005)(71200400001)(86362001)(33656002)(8676002)(55016002)(8936002)(83380400001)(110136005)(54906003)(53546011)(316002)(478600001)(2906002)(66946007)(4744005)(186003)(5660300002)(7696005)(66446008)(9686003)(52536014)(76116006)(66556008)(64756008)(66476007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: YG5JXipYnD44flPM3U+jMGxviJi4lyyIenjoPxTh1KQXk4LQcGJNTFQUcSaQBFz/Coica7fdonkJ4gASSB8Jtsc5Ai1sDkyMa744ljAdV719eL6C5Z+iMcXGDaSJKAjd3nc9OHbe+SdoZMA8H5zY9jaOlaLUNEUfhYIwDBesRdpCexLBROWpX3xFSmc0C//nY30mLDx/8dI+914nooJg5c+ErEJKznTHL2UpvUwgjAyM4Kg+lPYuJK/GZtM6A3euUoUcan6rYEXlmYuYucSbYYeV76a2POUzo8Za5uqfHi57XCyld7XnVsclm3alk2DrwjwRpUH8j5AVYYDE+VPUftjw6NeH/WsBDErGVm9A7iTmgqYLvo0OC/M57suIW9phCzuK+vM3euHIKbZHAa7CrX0vXdLudyjSxdqBmOZzSSay+6TiYfixUC8JH+rhkKCgPui7jqOq6lc0ZzDjOVgOVmTDZ3AK/eNONCIoxKk9oMtLcG/smPUnJjtid9GienY8
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: a7057dcc-8859-4152-7811-08d807b4e56f
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Jun 2020 11:54:39.6461
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: GPDJyWZLL701GO+ZaoTepZ2iNviHg4fHgqxq8Kj0vtdSUz1YeWa+6qDe66LyIeFaQ4leRCl2suqex34xOuAMRQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB2344
X-OriginatorOrg: synopsys.com
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Wed, Jun 3, 2020 at 12:47:42, Piotr Stankiewicz=20
<piotr.stankiewicz@intel.com> wrote:

> Seeing as there is shorthand available to use when asking for any type
> of interrupt, or any type of message signalled interrupt, leverage it.
>=20
> Signed-off-by: Piotr Stankiewicz <piotr.stankiewicz@intel.com>
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>
> ---
>  drivers/dma/dw-edma/dw-edma-pcie.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/dma/dw-edma/dw-edma-pcie.c b/drivers/dma/dw-edma/dw-=
edma-pcie.c
> index dc85f55e1bb8..46defe30ac25 100644
> --- a/drivers/dma/dw-edma/dw-edma-pcie.c
> +++ b/drivers/dma/dw-edma/dw-edma-pcie.c
> @@ -117,7 +117,7 @@ static int dw_edma_pcie_probe(struct pci_dev *pdev,
> =20
>  	/* IRQs allocation */
>  	nr_irqs =3D pci_alloc_irq_vectors(pdev, 1, pdata->irqs,
> -					PCI_IRQ_MSI | PCI_IRQ_MSIX);
> +					PCI_IRQ_MSI_TYPES);
>  	if (nr_irqs < 1) {
>  		pci_err(pdev, "fail to alloc IRQ vector (number of IRQs=3D%u)\n",
>  			nr_irqs);
> --=20
> 2.17.2


Acked-by: Gustavo Pimentel <gustavo.pimentel@synopsys.com>


