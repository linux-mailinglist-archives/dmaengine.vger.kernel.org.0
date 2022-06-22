Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CBC36555351
	for <lists+dmaengine@lfdr.de>; Wed, 22 Jun 2022 20:35:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359662AbiFVSfE (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 22 Jun 2022 14:35:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1359813AbiFVSfD (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 22 Jun 2022 14:35:03 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00F4523BC9;
        Wed, 22 Jun 2022 11:34:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=F/PYcaICf6zh2CBCjM6VQG5mSSceIDKGnlCDlVeFSO491M5r9Lm1+UxO5tNGsVkcbNgXGE5eIfMpx0oWq43wY60osNYh1RtnveAojiaP+YOZaOP28OfpllWugKNtRCrm8VB/two5myAnz9Ark5iL0da+wbfJ9gTeaZKxqHDQTEz260csjPL78FiPk9g3IBGD7jdQpDSOaIpj6hlj3JWIRKUObBc+QWt3omghJz56tUFs2sUs9Lbpk85+c5AssfXs8fW6JIDhGGYS0R7HTUN3SsCO8VfrTse4jYsNWC13gHlTlD8BZo/wyOpbCdS6z7OKRCbT1PIjatNjyHHK7+AiGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZsnjITyGDSk/tOXwLl/usSToM3CcxovghdEeXD1Ehcs=;
 b=kFB6zx9ERt+ekYmeliTt8mz2HBnH7KnLrH8yiiB3d2V/8ugexOYe7tWZGuLZpH6T4sKELxhiyeXqpPR81PAu+W3aXCA0wJZByIICPQg+xiPgBRWT81ESg5itxjymZIMHmAXrG7sORhPkJsi0zzKNhvJg08LG0KhGdFQpm5qNOj8xdc8qW69QTKB0q1CyWo3WwPOH5zR6Lo4b2Ulw3mlsLFgBjhYyINfityTe16VvtE6NoBLEE1fQycgYBvhq18V4BvKFnzADuJbMR4JLuBW5Q6+V1lac3jgFqWZQtDG4YStUElBXjSn6yPcL6EGLMUbzo3p2UHcMapiElUaED/aXiA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZsnjITyGDSk/tOXwLl/usSToM3CcxovghdEeXD1Ehcs=;
 b=ZnKWqrxUwoU/cczuAodhLJbUlfTbCzAGqFkiTQ2nHBhIVW2pYEfHMTv03NRcke95SOTxIhP48dfutgFn/71NELDJe8qVQFVcghwZ2jbr9SMx6KHqwBVRPVJKOSCx15h7013fOa0V6ejIm/N+us2wpda5XnBLqvyIDxXwKcvq0lg=
Received: from DS7PR12MB5958.namprd12.prod.outlook.com (2603:10b6:8:7d::20) by
 MN2PR12MB4288.namprd12.prod.outlook.com (2603:10b6:208:1d2::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5353.14; Wed, 22 Jun
 2022 18:34:57 +0000
Received: from DS7PR12MB5958.namprd12.prod.outlook.com
 ([fe80::5892:b226:d210:5334]) by DS7PR12MB5958.namprd12.prod.outlook.com
 ([fe80::5892:b226:d210:5334%9]) with mapi id 15.20.5353.022; Wed, 22 Jun 2022
 18:34:57 +0000
From:   "Pandey, Radhey Shyam" <radhey.shyam.pandey@amd.com>
To:     Vinod Koul <vkoul@kernel.org>,
        Adrian Larumbe <adrianml@alumnos.upm.es>
CC:     Christoph Hellwig <hch@lst.de>,
        "michal.simek@xilinx.com" <michal.simek@xilinx.com>,
        "dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Subject: RE: [PATCH] dmaengine: remove DMA_MEMCPY_SG once again
Thread-Topic: [PATCH] dmaengine: remove DMA_MEMCPY_SG once again
Thread-Index: AQHYhmbE8Sz/pMmzUEa+n/KlIjKAjQ==
Date:   Wed, 22 Jun 2022 18:34:57 +0000
Message-ID: <DS7PR12MB595897FAB92B785B48BF2DFFB7B29@DS7PR12MB5958.namprd12.prod.outlook.com>
References: <20220606074733.622616-1-hch@lst.de> <Yp4/JW4P12s4siRz@matsya>
 <20220606195455.qmq3yu6mc6g4rmm2@sobremesa> <Yp7OFYFp7oyjyKx1@matsya>
In-Reply-To: <Yp7OFYFp7oyjyKx1@matsya>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 62a266b1-eb56-46f0-1aa3-08da547de846
x-ms-traffictypediagnostic: MN2PR12MB4288:EE_
x-microsoft-antispam-prvs: <MN2PR12MB4288CC46CED2872269A10030B7B29@MN2PR12MB4288.namprd12.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: YEgX1KNedKkY8tzCEvu+1+YUJy1/HzxRyLZN4VIL9RyYe/sHX70xEoS4CeLaCZhEb8Rp2YOw1hfLvNKr8RQDImED5RcZ8mZXQ0V54FbZ1YGKlWM/e98vSm9CGdNNzj/wOGwUKvYIpibJhN1mhbPpIBXtxSLD+HoTXUgG7j7ICTn1MqL89okSXgXiZav4X4WFffzatk5VBMW+OvBf4orxzPBlx5UdAeE3xZ7Kg7GOOb7gZ74AXpUQeEdbt18Pp5sjC4lsFuC52DM8qfLSFnde0o+yoQXTqDVAUHKU9JoyKn3CsOza26UOEN0HNtlVgrCTceSN5OKwDUZAZrSuZMlGIkG6jGna12P1mBuCdPmChgvwXgAbu9BAg0yhp99h+tQLDtE1ru62HaoBFEF9m/vbwgA8Ze4EdD+9EcUVaWLGbzXveDf3huM9cMq4kz1jWAXcyDTNOcXS6O0UzAZW4NE+Avjn4lZKdOmUUOGqvd9M1i+aJwjhl03W5Z7svuCjkcgk3hmwSz7IsDklDxLGKf0UnOJMEyr6a7zY0JxK1RjvdbuyN9X6bkwsP92zINadQafdFKpNE7hkjT8tYCFqqAKBstYwKFozb2ftILf5jgPKwQmwzmzeSRD6rJISi/P0DNit8mfc2q08VvPdr+wWYIrmLoC0urLanqLaDJza2WMJhkRvwKwTo7gdZprZwvhHn7LJKp/1Z/gBngcZ5PvVdSvxZ3UVZGTldZeJKNE9hK6cPE0EGKE4us/oMieaCBuZR+dF+RalnlLPoU8oQBe20uniHw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB5958.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(346002)(136003)(39860400002)(396003)(376002)(366004)(26005)(38070700005)(86362001)(53546011)(66556008)(66446008)(7696005)(6506007)(66476007)(4326008)(2906002)(9686003)(8676002)(66946007)(38100700002)(64756008)(316002)(110136005)(54906003)(76116006)(122000001)(8936002)(478600001)(55016003)(5660300002)(83380400001)(33656002)(71200400001)(186003)(41300700001)(52536014);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?+h/aGlggxop1ZCmoR+wWAQf8YmdVmvWt4MKVqVCcedDwj/B/VdwOrimfoy42?=
 =?us-ascii?Q?310crN7cXFFEzD3fDLUD0oSHW72wXTPlvZE2re5/VewnPN2og4SrcdpYpTV+?=
 =?us-ascii?Q?72zBZLQth9o8YvEU1gqnIUkOOTEF17Vjo+rAhsm4aDHLZq1l/WKo4IEvrWd/?=
 =?us-ascii?Q?SVvm5Y+5j8C0HCAein1vQo5OtJmBaH0sSyQi1Lz7Aq+pqV1BwEd8tFOpD/ZO?=
 =?us-ascii?Q?LB/ymk7X6aPFu2mzU9YKJ0528P1F6+flojH/1mOCoQlcn08y7l+5Yoil9YOk?=
 =?us-ascii?Q?fhAe+hFoiLOviuiB4eACDDucvLklG1TDM4nyJBnQZvw6uOFQ/k05is8vUKaz?=
 =?us-ascii?Q?M+ky31lRuGZ81s8+dozS9Lb8ukGdvJVqXA1YVTRzG4fuFHiHUuGtAAse+VNE?=
 =?us-ascii?Q?1vjuFZDaiHnODKh89VJ+rRlb1l4NiJkv1IWU4BvxmdrGZ6L7EeAy8ozgmTCk?=
 =?us-ascii?Q?AcJef1MKiuctKWgf0LBEoHP3s1HlS0ZQu3XhMZsfl8wkwA2k79G/dnYOG3or?=
 =?us-ascii?Q?VDvrgvcgVsi6qkU7gNj3QvCQ/oicNOJP4V6XD4cVkaXUUyaXxDMGZTTcho2a?=
 =?us-ascii?Q?+hJoDsjM1dBaTWuHBmdXu8q9XNk8DnFEyMYES7W3hlO2gLBPy7mWdV2MoY1E?=
 =?us-ascii?Q?98xwAjC+bwtIF9RkEXmqwL1b1rRPfb1Mfr4zqy1I9YgpieqCsrjVI44IM23S?=
 =?us-ascii?Q?4kQ5G4ELItRrjar4/lGFwOZwzpIwYVxtGqkAtroNIxabCB95j23LJtmfPYXp?=
 =?us-ascii?Q?ePvM7NO4SEbWy9ikkx23t2y4jCU+ba8SHddtftbqRxwguQCYpPSxFiGZSkf1?=
 =?us-ascii?Q?SdEiG3PZS36hMfZpeXuPSboDgIlUJqnO+zJ5cDIUP1fir/arFqxar0rGwvFk?=
 =?us-ascii?Q?SwoV7dvoL+NJut0wlDNxFK9aOuR+4IJ6+BeCt7qPdeT7xxv5tTER8n9vnjtu?=
 =?us-ascii?Q?TuRxTVdVukvjzkgYIq4NmxRok1mldHHZU2lqPlsl5tOY0VLhZtA9kWkoup9/?=
 =?us-ascii?Q?mXQS/JUu7rKQ4Y5BUcou0Vn2hU+W15aKZJGtizZiuyX46qlEhJo2Jbtnlkop?=
 =?us-ascii?Q?C9cYp9iX0UDy4SB7gTd97bEIAlSfLL6JlV9jhBf4cN63JXLB1D46xZDwtyBH?=
 =?us-ascii?Q?unfEbx8TCwGZuwWGh3Lvm/TD0xGdFLYclSr6maP4rVULhhh9BjcCmVa9LkN1?=
 =?us-ascii?Q?8mc9wPLcZrVgTTNsP2d2hUUKZWxVkAH+n10MFZ+5dXGjLqLDuAoz7LMJBTEB?=
 =?us-ascii?Q?LHircFcVH2P0PQmSE/HNRPysmwsT/7qNx/ROdCUmoZEEpBiYEuOcnwv/1jpW?=
 =?us-ascii?Q?ctbRDWFvIGuxWkTijTvQtfp/S0GOur1cdy98RaHg4MVgUR3kcpZrHIuxSENM?=
 =?us-ascii?Q?1zfc/hPO3JHwkySt8Qb2m/XxKdV4EUJaOhF36gCWhQY18vMvY8i2Da3f6JRM?=
 =?us-ascii?Q?1PkFMIwzjGvZZdo8HYcW8adV7fSC2xq5wr1ISAGQGs9nasrrcy6I5nkNWxS/?=
 =?us-ascii?Q?pttj64raxZIvjzdk6IjSuTsPxUxZvM4RyNiD4oG92c1ZS25LH3pMQrWo+PWF?=
 =?us-ascii?Q?E14sBQHwOT6hrJXPI/c=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB5958.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 62a266b1-eb56-46f0-1aa3-08da547de846
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Jun 2022 18:34:57.0431
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Japmexo0WWNL0H32wmSqiGkdpctXUiH81pIMPi7TUhiLfoNfrhYVYpbDhqZLmxKs
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4288
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

> -----Original Message-----
> From: Vinod Koul <vkoul@kernel.org>
> Sent: Tuesday, June 7, 2022 9:34 AM
> To: Adrian Larumbe <adrianml@alumnos.upm.es>
> Cc: Christoph Hellwig <hch@lst.de>; michal.simek@xilinx.com;
> dmaengine@vger.kernel.org; linux-kernel@vger.kernel.org; linux-arm-
> kernel@lists.infradead.org
> Subject: Re: [PATCH] dmaengine: remove DMA_MEMCPY_SG once again
>=20
> On 06-06-22, 20:54, Adrian Larumbe wrote:
> > >On 06.06.2022 23:23, Vinod Koul wrote:
> > >On 06-06-22, 09:47, Christoph Hellwig wrote:
> > >> This was removed before due to the complete lack of users, but
> > >> 3218910fd585 ("dmaengine: Add core function and capability check
> > >> for
> > >> DMA_MEMCPY_SG") and 29cf37fa6dd9 ("dmaengine: Add consumer for
> the
> > >> new DMA_MEMCPY_SG API function.") added it back despite still not
> > >> having any users whatsoever.
> > >>
> > >> Fixes: 3218910fd585 ("dmaengine: Add core function and capability
> > >> check for DMA_MEMCPY_SG")
> > >> Fixes: 29cf37fa6dd9 ("dmaengine: Add consumer for the new
> > >> DMA_MEMCPY_SG API function.")
> > >
> > >This is consumer of the driver API and it was bought back with the
> > >premise that user will also come...
> >
> > It's commit 29cf37fa6dd9 ("dmaengine: Add consumer for the new
> > DMA_MEMCPY_SG API function.")
> >
> > The two previous commits add the new driver API callback and document i=
t.
> >
> > >Adrianm, Michal any reason why user is not mainline yet..?

The dma client are use case dependent and mostly on end-users=20
to upstream it. In the Xilinx tree, there is no CDMA  user apart from=20
dmatest and as of now, there is no plan to support any other client.

It should be fine to revert this support again.

> >
> > Just double checked the mainline, and all three commits are there.
>=20
> There are no clients in mainline which call this API. There is a driver w=
hich
> implements this API, but no users...
>=20
> $ git grep dmaengine_prep_dma_memcpy_sg
> include/linux/dmaengine.h:static inline struct dma_async_tx_descriptor
> *dmaengine_prep_dma_memcpy_sg(
>=20
> --
> ~Vinod
