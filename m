Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9E18E1AB2FB
	for <lists+dmaengine@lfdr.de>; Wed, 15 Apr 2020 23:00:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2438455AbgDOU6T (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 15 Apr 2020 16:58:19 -0400
Received: from smtprelay-out1.synopsys.com ([149.117.73.133]:43630 "EHLO
        smtprelay-out1.synopsys.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2438334AbgDOU6R (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 15 Apr 2020 16:58:17 -0400
Received: from mailhost.synopsys.com (badc-mailhost2.synopsys.com [10.192.0.18])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 69EFD405CB;
        Wed, 15 Apr 2020 20:58:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1586984296; bh=zjXXLw1AQV69lu2dtV78y411LM/P3TjqtPKZK5Vv/8g=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=F+e+Kn/EKZXwuhFkr5iZnyqJgkDMTgZ3wd8bEIzchbpI8SwpMYiKF+GKlFwz4OorU
         ilPKufnbB0KLAaI7XZ2GDgG1Z/46LJn5wqRzfNfloWRIYO+OXeRLSbP367Y6OKVQ3x
         G3GZo8IiwYf8topHydiENM0phS8X6LfCu8+PnJakVZ2KFAk5r2oF3M5tyX0Uz0ttPZ
         c51vN8BxiyuYWfh17mQw3Wgm1AmbYiI5daWFUJv/oQVvQE7j9Skbor6tRdKhBPotNE
         C/uebF8hf8EE75ScgRoAxasYh8+MGRxxO2GxKg96XF2O2IHg0IqxIOQvF+uC2Efrf5
         jQTrjzC1p+NiQ==
Received: from US01WEHTC3.internal.synopsys.com (us01wehtc3.internal.synopsys.com [10.15.84.232])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by mailhost.synopsys.com (Postfix) with ESMTPS id 35ECAA006D;
        Wed, 15 Apr 2020 20:58:16 +0000 (UTC)
Received: from US01HYBRID2.internal.synopsys.com (10.15.246.24) by
 US01WEHTC3.internal.synopsys.com (10.15.84.232) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Wed, 15 Apr 2020 13:57:56 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (10.202.3.67) by
 mrs.synopsys.com (10.15.246.24) with Microsoft SMTP Server (TLS) id
 14.3.408.0; Wed, 15 Apr 2020 13:57:55 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UnbvbVJhmaC/7mZT6TSm2TGLlZ+F9nCvjVPOrf/0jpxeC4fkbKL4Vg90+HvceJaC8gtqp85d3qn6umf7DOwpc/lMfAcwIi1iOqe3GfZVdDGTcDGL95riRF+AYKp9tq7+1Ip1lSCFcGcBKXj4OWvC88jIzak8Ba+nMHhymtJ7u/PC3TEBD5QFunPikzbPmJqO3Do90CtGCXUtNig2WgCMDl+y4qHK88IqkVvR8Y17HEAS5KtKRlKn1UmutKZCiKSHQk8hulKTO2Rtdsm1+SlChz7SwfRyNQcn4UFjBaSCmmDyDoUWwDj5xqhdwgLOyFeQeEzRxEVhirSSD+XTyx6Icg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zjXXLw1AQV69lu2dtV78y411LM/P3TjqtPKZK5Vv/8g=;
 b=X8BZw1HN1Ox9REfnpuWk0dvK/ZGyVyneMTsgljmTBQmY1BIXzzMmzjoRsDzZDf36v+SrDeqWgu+7W6HcaXixIxV2yIuXh4QJtxKG8psVgVgBYL+CJzaLQPrxtAoCgZg8Q0yKBIgDMy5JuhyS/PPyk4nf33nHu0KExoWTEl8KDywgh3d49MUj6Y+pk3vaQ3Y7KkZFwtPi7gKVYP33p6A2VBi83sNQr0tr5e7ldwEofJ20ERTsJnY6dzGI1+PZnbXJVEVU/Jt4QR0Ev4aR0iZYxzHL5CsasLpcu45eoYEWMpf22sqLYLPEOBWlUIFGIaO4tCgNV8N26WzYzMaZu0A/Xw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zjXXLw1AQV69lu2dtV78y411LM/P3TjqtPKZK5Vv/8g=;
 b=PQw+aa9ycQp8kuDnKbYtAaMUzo0U07noKXQ4E3D6KyzUHg1+fujj2XM6+wZsR04uOHotrDsvHTaFd0zat/5FOIHXRYzZ0ED6Xu/DFgoiGapehyAuAk1tIaS3Qv1TYyV3VCrD5/Kk7WpVJ25manyi9vxZymMjTUNFAgZRHAoRvnM=
Received: from DM5PR12MB1276.namprd12.prod.outlook.com (2603:10b6:3:79::18) by
 DM5PR12MB1881.namprd12.prod.outlook.com (2603:10b6:3:10f::10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2900.15; Wed, 15 Apr 2020 20:57:54 +0000
Received: from DM5PR12MB1276.namprd12.prod.outlook.com
 ([fe80::cd06:6b04:8f2c:157e]) by DM5PR12MB1276.namprd12.prod.outlook.com
 ([fe80::cd06:6b04:8f2c:157e%10]) with mapi id 15.20.2900.028; Wed, 15 Apr
 2020 20:57:53 +0000
From:   Gustavo Pimentel <Gustavo.Pimentel@synopsys.com>
To:     Alan Mikhak <alan.mikhak@sifive.com>
CC:     "dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "dan.j.williams@intel.com" <dan.j.williams@intel.com>,
        "vkoul@kernel.org" <vkoul@kernel.org>,
        "kishon@ti.com" <kishon@ti.com>,
        "paul.walmsley@sifive.com" <paul.walmsley@sifive.com>
Subject: RE: [PATCH RFC] dmaengine: dw-edma: Decouple dw-edma-core.c from
 struct pci_dev
Thread-Topic: [PATCH RFC] dmaengine: dw-edma: Decouple dw-edma-core.c from
 struct pci_dev
Thread-Index: AQHWEsrRt1OuNWp8Y0WOATK/ErlmDqh6DhYAgABhvACAAALi8IAAFpYAgAAaMCA=
Date:   Wed, 15 Apr 2020 20:57:53 +0000
Message-ID: <DM5PR12MB127673CFDCA38A47E6F6F4DBDADB0@DM5PR12MB1276.namprd12.prod.outlook.com>
References: <1586916464-27727-1-git-send-email-alan.mikhak@sifive.com>
 <DM5PR12MB1276CB8FA4457D4CDCE3137EDADB0@DM5PR12MB1276.namprd12.prod.outlook.com>
 <CABEDWGwYmO52g6cqvQdWb6HXWEHaMA1rcf96aUqv0f32tJZT-g@mail.gmail.com>
 <DM5PR12MB1276E09460BD4DB7E70EAF91DADB0@DM5PR12MB1276.namprd12.prod.outlook.com>
 <CABEDWGw0OyQNppLpDaNgMedfB0Ci=kZVKm+h4T-LJoZYmbSgqA@mail.gmail.com>
In-Reply-To: <CABEDWGw0OyQNppLpDaNgMedfB0Ci=kZVKm+h4T-LJoZYmbSgqA@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: =?utf-8?B?UEcxbGRHRStQR0YwSUc1dFBTSmliMlI1TG5SNGRDSWdjRDBpWXpwY2RYTmxj?=
 =?utf-8?B?bk5jWjNWemRHRjJiMXhoY0hCa1lYUmhYSEp2WVcxcGJtZGNNRGxrT0RRNVlq?=
 =?utf-8?B?WXRNekprTXkwMFlUUXdMVGcxWldVdE5tSTROR0poTWpsbE16VmlYRzF6WjNO?=
 =?utf-8?B?Y2JYTm5MV00wTjJNeE9XTTRMVGRtTldJdE1URmxZUzA1T0dFM0xXWTRPVFJq?=
 =?utf-8?B?TWpjek9EQTBNbHhoYldVdGRHVnpkRnhqTkRkak1UbGpPUzAzWmpWaUxURXha?=
 =?utf-8?B?V0V0T1RoaE55MW1PRGswWXpJM016Z3dOREppYjJSNUxuUjRkQ0lnYzNvOUlq?=
 =?utf-8?B?STVPVGNpSUhROUlqRXpNak14TkRVM09EY3hPVFV5TnpNNE5DSWdhRDBpTm1r?=
 =?utf-8?B?NVJtWm9ZbVozVW1OaFNGZFNlR1JDYldJeE5ESnBTRUpqUFNJZ2FXUTlJaUln?=
 =?utf-8?B?WW13OUlqQWlJR0p2UFNJeElpQmphVDBpWTBGQlFVRkZVa2hWTVZKVFVsVkdU?=
 =?utf-8?B?a05uVlVGQlFsRktRVUZFV1RCVE5raGhRbEJYUVdSQ1RXZFNlSGRsZW5kWk1F?=
 =?utf-8?B?VjVRa2hJUWpkUVFtZFBRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVG?=
 =?utf-8?B?QlFVaEJRVUZCUTJ0RFFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZC?=
 =?utf-8?B?UVVWQlFWRkJRa0ZCUVVGRmJVMWxhM2RCUVVGQlFVRkJRVUZCUVVGQlFVRktO?=
 =?utf-8?B?RUZCUVVKdFFVZHJRV0puUW1oQlJ6UkJXWGRDYkVGR09FRmpRVUp6UVVkRlFX?=
 =?utf-8?B?Sm5RblZCUjJ0QlltZENia0ZHT0VGa2QwSm9RVWhSUVZwUlFubEJSekJCV1ZG?=
 =?utf-8?B?Q2VVRkhjMEZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZC?=
 =?utf-8?B?UVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJR?=
 =?utf-8?B?VUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFV?=
 =?utf-8?B?RkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUlVGQlFVRkJRVUZCUVVG?=
 =?utf-8?B?blFVRkJRVUZCYm1kQlFVRkhXVUZpZDBJeFFVYzBRVnBCUW5sQlNHdEJXSGRD?=
 =?utf-8?B?ZDBGSFJVRmpaMEl3UVVjMFFWcFJRbmxCU0UxQldIZENia0ZIV1VGQlFVRkJR?=
 =?utf-8?B?VUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFV?=
 =?utf-8?B?RkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVG?=
 =?utf-8?B?QlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZC?=
 =?utf-8?B?UVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFWRkJR?=
 =?utf-8?B?VUZCUVVGQlFVRkRRVUZCUVVGQlEyVkJRVUZCV21kQ2RrRklWVUZpWjBKclFV?=
 =?utf-8?B?aEpRV1ZSUW1aQlNFRkJXVkZDZVVGSVVVRmlaMEpzUVVoSlFXTjNRbVpCU0Ux?=
 =?utf-8?B?QldWRkNkRUZJVFVGa1VVSjFRVWRqUVZoM1FtcEJSemhCWW1kQ2JVRkJRVUZC?=
 =?utf-8?B?UVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJR?=
 =?utf-8?B?VUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFV?=
 =?utf-8?B?RkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVG?=
 =?utf-8?B?QlFVRkJRVUpCUVVGQlFVRkJRVUZCU1VGQlFVRkJRVW8wUVVGQlFtMUJSemhC?=
 =?utf-8?B?WkZGQ2RVRkhVVUZqWjBJMVFVWTRRV05CUW1oQlNFbEJaRUZDZFVGSFZVRmpa?=
 =?utf-8?B?MEo2UVVZNFFXTjNRbWhCUnpCQlkzZENNVUZITkVGYWQwSm1RVWhKUVZwUlFu?=
 =?utf-8?B?cEJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVG?=
 =?utf-8?B?QlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZC?=
 =?utf-8?B?UVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJR?=
 =?utf-8?B?VUZCUVVGQlFVRkJRVUZCUVVGRlFVRkJRVUZCUVVGQlFXZEJRVUZCUVVGdVow?=
 =?utf-8?B?RkJRVWRaUVdKM1FqRkJSelJCV2tGQ2VVRklhMEZZZDBKM1FVZEZRV05uUWpC?=
 =?utf-8?B?QlJ6UkJXbEZDZVVGSVRVRllkMEo2UVVjd1FXRlJRbXBCUVVGQlFVRkJRVUZC?=
 =?utf-8?B?UVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJR?=
 =?utf-8?B?VUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFV?=
 =?utf-8?B?RkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVG?=
 =?utf-8?B?QlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJVVUZCUVVGQlFVRkJRVU5C?=
 =?utf-8?B?UVVGQlFVRkRaVUZCUVVGYVowSjJRVWhWUVdKblFtdEJTRWxCWlZGQ1prRklR?=
 =?utf-8?B?VUZaVVVKNVFVaFJRV0puUW14QlNFbEJZM2RDWmtGSVRVRmtRVUZCUVVGQlFV?=
 =?utf-8?B?RkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVG?=
 =?utf-8?B?QlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZC?=
 =?utf-8?B?UVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJR?=
 =?utf-8?B?VUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUWtGQlFV?=
 =?utf-8?B?RkJRVUZCUVVGSlFVRkJRVUZCU2pSQlFVRkNiVUZIT0VGa1VVSjFRVWRSUVdO?=
 =?utf-8?B?blFqVkJSamhCWTBGQ2FFRklTVUZrUVVKMVFVZFZRV05uUW5wQlJqaEJaRUZD?=
 =?utf-8?B?ZWtGSE1FRlpkMEZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJR?=
 =?utf-8?B?VUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFV?=
 =?utf-8?B?RkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVG?=
 =?utf-8?B?QlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZC?=
 =?utf-8?B?UVVGQlFVVkJRVUZCUVVGQlFVRkJaMEZCUVVGQlFXNW5RVUZCUjFsQlluZENN?=
 =?utf-8?B?VUZITkVGYVFVSjVRVWhyUVZoM1FuZEJSMFZCWTJkQ01FRkhORUZhVVVKNVFV?=
 =?utf-8?B?aE5RVmgzUWpGQlJ6QkJXWGRCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVG?=
 =?utf-8?B?QlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZC?=
 =?utf-8?B?UVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJR?=
 =?utf-8?B?VUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFV?=
 =?utf-8?B?RkJRVUZCUVVGQlFVRkJRVUZSUVVGQlFVRkJRVUZCUTBGQlFVRkJRVU5sUVVG?=
 =?utf-8?B?QlFWcDNRakJCU0UxQldIZENkMEZJU1VGaWQwSnJRVWhWUVZsM1FqQkJSamhC?=
 =?utf-8?B?WkVGQ2VVRkhSVUZoVVVKMVFVZHJRV0puUW01QlFVRkJRVUZCUVVGQlFVRkJR?=
 =?utf-8?B?VUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFV?=
 =?utf-8?B?RkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVG?=
 =?utf-8?B?QlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZC?=
 =?utf-8?B?UVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQ1FVRkJRVUZCUVVGQlFVbEJR?=
 =?utf-8?B?VUZCUVVGS05FRkJRVUo2UVVkRlFXSkJRbXhCU0UxQldIZENhRUZIVFVGWmQw?=
 =?utf-8?B?SjJRVWhWUVdKblFqQkJSamhCWTBGQ2MwRkhSVUZpWjBGQlFVRkJRVUZCUVVG?=
 =?utf-8?B?QlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZC?=
 =?utf-8?B?UVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJR?=
 =?utf-8?B?VUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFV?=
 =?utf-8?B?RkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJSVUZCUVVG?=
 =?utf-8?B?QlFVRkJRVUZuUVVGQlFVRkJibWRCUVVGSVRVRlpVVUp6UVVkVlFXTjNRbVpC?=
 =?utf-8?B?U0VWQlpGRkNka0ZJVVVGYVVVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJR?=
 =?utf-8?B?VUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFV?=
 =?utf-8?B?RkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVG?=
 =?utf-8?B?QlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZC?=
 =?utf-8?B?UVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJR?=
 =?utf-8?B?VUZCUVZGQlFVRkJRVUZCUVVGRFFVRkJRVUZCUTJWQlFVRkJZM2RDZFVGSVFV?=
 =?utf-8?B?RmpkMEptUVVkM1FXRlJRbXBCUjFWQlltZENla0ZIVlVGWWQwSXdRVWRWUVdO?=
 =?utf-8?B?blFuUkJSamhCVFZGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZC?=
 =?utf-8?B?UVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJR?=
 =?utf-8?B?VUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFV?=
 =?utf-8?B?RkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVG?=
 =?utf-8?B?QlFVRkJRVUZCUVVGQlFVSkJRVUZCUVVGQlFVRkJTVUZCUVVGQlFVbzBRVUZC?=
 =?utf-8?B?UW5wQlJ6UkJZMEZDZWtGR09FRmlRVUp3UVVkTlFWcFJRblZCU0UxQldsRkNa?=
 =?utf-8?B?a0ZJVVVGYVVVSjVRVWN3UVZoM1FucEJTRkZCWkZGQ2EwRkhWVUZpWjBJd1FV?=
 =?utf-8?B?RkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVG?=
 =?utf-8?B?QlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZC?=
 =?utf-8?B?UVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJR?=
 =?utf-8?B?VUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZGUVVGQlFVRkJRVUZCUVdkQlFV?=
 =?utf-8?B?RkJRVUZ1WjBGQlFVaFpRVnAzUW1aQlIzTkJXbEZDTlVGSVkwRmlkMEo1UVVk?=
 =?utf-8?B?UlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZC?=
 =?utf-8?B?UVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJR?=
 =?utf-8?B?VUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFV?=
 =?utf-8?B?RkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVG?=
 =?utf-8?B?QlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlVVRkJRVUZC?=
 =?utf-8?Q?QUFBQUNBQUFBQUFBPSIvPjwvbWV0YT4=3D?=
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=gustavo@synopsys.com; 
x-originating-ip: [198.182.37.200]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 8adf2a97-80f5-4d3e-6e4a-08d7e17faad4
x-ms-traffictypediagnostic: DM5PR12MB1881:
x-microsoft-antispam-prvs: <DM5PR12MB188127C02A705A9A5F39052CDADB0@DM5PR12MB1881.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 0374433C81
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR12MB1276.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(10019020)(396003)(366004)(136003)(39860400002)(376002)(346002)(66446008)(316002)(9686003)(64756008)(66946007)(66556008)(5660300002)(6916009)(76116006)(66476007)(4326008)(8936002)(7696005)(966005)(478600001)(71200400001)(2906002)(33656002)(186003)(6506007)(54906003)(8676002)(86362001)(81156014)(55016002)(52536014)(26005);DIR:OUT;SFP:1102;
received-spf: None (protection.outlook.com: synopsys.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: UOVVMpntNqEmkg8U9+9B1o/qkS4T0pMtcI3EJI+xmHRm5PiTxVAcvzp/rVU3BOGTnpORlPi9eBI/vC4gfY6hZuP8JKw+IKmbWSxy3ICkQy4/uyf3hUvH3891X8ntQSgs/n06Y8qgwidcVhQ6LKFLzWglSlIPzm3Y6qIcXvXnAJdSe8efOqc/x82NYxcClKSv2/8+aH6cro/qrGXH3BzC//8UV+s0LuUW0XKRLNz9kCPi94MdWOB9xV0w3J5+Jqn++hL+24SALCIjffMQQuNxqY3tsYAdLZBBWVGzcOhsKZ93SQmQeel9qEPqj4r/y7NitSIBWWQT+kEkc53+ZQsL6iF4rlNXcKeDq7w7sqeU86O49ZqsZZN2736tYOzIXYqfLFbuoEhOcS/k924CP2Cf4hG5R+rHMr/ak2jH/itvJDty4OoZLf10k8MJrGl7xseAJRetQIwV2XwI1LdzYuN1teR0VUqenEO1H5EiOtD7PYACIsZ+ygFmoHyqcudqEi/gJ/8mlxKAYD9THEik+lqoTA==
x-ms-exchange-antispam-messagedata: RVMEahmf413dXSIxx1cbB282fQskbB4Af+nxS24jk+HZ1xmlUYFi+QrQvjtsI97WJAIxZuBbxFpxOq/IwrRUowx6zdY63zrSyN2Uz7NMNW9doyyBs43Vcip5uhRwVH5HZ/GH34utwqxZ8SZ8Htquxw==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 8adf2a97-80f5-4d3e-6e4a-08d7e17faad4
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Apr 2020 20:57:53.8179
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Lv49lTH1Lbzkim4m1bOuyAtXb4hESbf+SHodauphk+TilrodlAqSG3ne5RS6sMDulHJFlm8q4cZaQBJEPMS8Mw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1881
X-OriginatorOrg: synopsys.com
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

SGkgQWxhbiwNCg0KPiA+ID4gQXQgdGhlIG1vbWVudCwgcGNpLWVwZi10ZXN0IGdyYWJzIHRoZSBm
aXJzdCBhdmFpbGFibGUgZG1hIGNoYW5uZWwgb24gdGhlDQo+ID4gPiBlbmRwb2ludCBzaWRlIGFu
ZCB1c2VzIGl0IGZvciBlaXRoZXIgcmVhZCwgd3JpdGUsIG9yIGNvcHkgb3BlcmF0aW9uLiBpdCBp
cyBub3QNCj4gPiA+IHBvc3NpYmxlIGF0IHRoZSBtb21lbnQgdG8gc3BlY2lmeSB3aGljaCBkbWEg
Y2hhbm5lbCB0byB1c2Ugb24gdGhlIHBjaXRlc3QNCj4gPiA+IGNvbW1hbmQgbGluZS4gVGhpcyBt
YXkgYmUgcG9zc2libGUgYnkgbW9kaWZ5aW5nIHRoZSBjb21tYW5kIGxpbmUgb3B0aW9uDQo+ID4g
PiAtRCB0byBhbHNvIHNwZWNpZnkgdGhlIG5hbWUgb2Ygb25lIG9yIG1vcmUgZG1hIGNoYW5uZWxz
Lg0KPiA+DQo+ID4gSSdtIGFzc3VtaW5nIHRoYXQgYmVoYXZpb3IgaXMgZHVlIHRvIHlvdXIgY29k
ZSwgcmlnaHQ/IEknbSBub3Qgc2VlbiB0aGF0DQo+ID4gYmVoYXZpb3Igb24gdGhlIEtlcm5lbCB0
cmVlLg0KPiA+IENoZWNrIG15IHByZXZpb3VzIHN1Z2dlc3Rpb24sIGl0IHNob3VsZCBiZSBzb21l
dGhpbmcgc2ltaWxhciB0byB3aGF0IGlzDQo+ID4gYmVlbiBkb25lIHdoaWxlIHlvdSBzZWxlY3Qg
dGhlIE1TSS9NU0ktWCBpbnRlcnJ1cHQgdG8gdHJpZ2dlci4NCj4gDQo+IEkgYmVsaWV2ZSB0aGlz
IGJlaGF2aW9yIGV4aXN0cyBpbiB0aGUga2VybmVsIHRyZWUgYmVjYXVzZSB0aGUgY2FsbCB0bw0K
PiBkbWFfcmVxdWVzdF9jaGFuX2J5X21hc2soKSBhbHdheXMgc3BlY2lmaWVzIGNoYW5uZWwgemVy
by4gVGhlIHVzZXINCj4gb2YgcGNpdGVzdCBoYXMgbm8gd2F5IG9mIHNwZWNpZnlpbmcgd2hpY2gg
b25lIG9mIHRoZSBhdmFpbGFibGUgZG1hIGNoYW5uZWxzDQo+IHRvIHVzZS4NCg0KSSB0aGluayB3
ZSB3ZXJlIGRpc2N1c3NpbmcgZGlmZmVyZW50IHRoaW5ncy4gSSB3YXMgcmVmZXJyaW5nIHRvIHRo
ZSANCnBjaS1lcGYtdGVzdCBjb2RlLCB0aGF0IEkgd2Fzbid0IGJlaW5nIGFibGUgdG8gZmluZCBh
bnkgaW5zdHJ1Y3Rpb24gdG8gDQpjYWxsIHRoZSBETUEgZHJpdmVyIHdoaWNoIGhhZCB0aGUgZGVz
Y3JpYmVkIGJlaGF2aW9yLg0KDQpJIHRoaW5rIHlvdSBjYW4gZG8gaXQgYnkgZG9pbmcgdGhpczoN
Cg0KUHNldWRvIGNvZGU6DQoNCiNkZWZpbmUgRURNQV9URVNUX0NIQU5ORUxfTkFNRQkJCSJkbWEl
dWNoYW4ldSINCg0Kc3RhdGljIGJvb2wgZHdfZWRtYV90ZXN0X2ZpbHRlcihzdHJ1Y3QgZG1hX2No
YW4gKmNoYW4sIHZvaWQgKmZpbHRlcikNCnsNCglpZiAoc3RyY21wKGRldl9uYW1lKGNoYW4tPmRl
dmljZS0+ZGV2KSwgRURNQV9URVNUX0RFVklDRV9OQU1FKSB8fCANCnN0cmNtcChkbWFfY2hhbl9u
YW1lKGNoYW4pLCBmaWx0ZXIpKQ0KCQlyZXR1cm4gZmFsc2U7DQoNCglyZXR1cm4gdHJ1ZTsNCn0N
Cg0Kc3RhdGljIHZvaWQgZHdfZWRtYV90ZXN0X3RocmVhZF9jcmVhdGUoaW50IGlkLCBpbnQgY2hh
bm5lbCkNCnsNCglzdHJ1Y3QgZG1hX2NoYW4gKmNoYW47DQoJZG1hX2NhcF9tYXNrX3QgbWFzazsN
CgljaGFyIGZpbHRlclsyMF07DQoNCglkbWFfY2FwX3plcm8obWFzayk7DQoJZG1hX2NhcF9zZXQo
RE1BX1NMQVZFLCBtYXNrKTsNCglkbWFfY2FwX3NldChETUFfQ1lDTElDLCBtYXNrKTsNCg0KCXNu
cHJpbnRmKGZpbHRlciwgc2l6ZW9mKGZpbHRlciksIEVETUFfVEVTVF9DSEFOTkVMX05BTUUsIGlk
LCANCmNoYW5uZWwpOw0KCWNoYW4gPSBkbWFfcmVxdWVzdF9jaGFubmVsKG1hc2ssIGR3X2VkbWFf
dGVzdF9maWx0ZXIsIGZpbHRlcik7DQoNCglbLi5dDQp9DQoNCj4gSSBiZWxpZXZlIHRoaXMgYmVo
YXZpb3IgZXhpc3RzIGluIHRoZSBrZXJuZWwgdHJlZSBiZWNhdXNlIHRoZSBjYWxsIHRvDQo+IGRt
YV9yZXF1ZXN0X2NoYW5fYnlfbWFzaygpIGhhcHBlbnMgZHVyaW5nIHRoZSBleGVjdXRpb24gb2YN
Cj4gcGNpX2VwZl90ZXN0X2JpbmQoKSBhbmQgdGhlIGNhbGwgdG8gZG1hX3JlbGVhc2VfY2hhbm5l
bCgpIGhhcHBlbnMNCj4gZHVyaW5nIHRoZSBleGVjdXRpb24gb2YgcGNpX2VwZl90ZXN0X3VuYmlu
ZCgpLiBBcyBsb25nIGFzIHBjaS1lcGYtdGVzdA0KPiBpcyBib3VuZCwgSSBjYW5ub3QgdXNlIGFu
b3RoZXIgcHJvZ3JhbSBzdWNoIGFzIGRtYXRlc3QgZnJvbSB0aGUNCj4gZW5kcG9pbnQtc2lkZSBj
b21tYW5kIHByb21wdCB0byBleGVyY2lzZSB0aGUgc2FtZSBjaGFubmVsLg0KDQpPaywgSSB1bmRl
cnN0b29kIGl0IG5vdy4gUmlnaHQsIHlvdSBjYW4ndCB1c2UgdGhlIGRtYXRlc3QgaGVyZSwgZXZl
biANCmJlY2F1c2UsIGFzIGZhciBhcyBJIGtub3csIGl0IGlzIG9ubHkgTUVNIFRPIE1FTSBvcGVy
YXRpb25zIGFuZCB3ZSBuZWVkIA0KREVWSUNFX1RPX01FTSBhbmQgdmljZS12ZXJzYS4NCg0KPiAN
Cj4gV2hhdCBJIHdhcyBzdWdnZXN0aW5nIGlzIHBlcmhhcHMgcGNpLWVwZi10ZXN0IGNhbiBiZSBt
b2RpZmllZCB0bw0KPiBhY3F1aXJlIGFuZCByZWxlYXNlIHRoZSBjaGFubmVsIG9uIGVhY2ggY2Fs
bCB0byBwY2lfZXBmX3Rlc3RfcmVhZCgpLA0KPiAuLi53cml0ZSgpLCBvciAuLi5jb3B5KCkgd2hl
biB0aGUgcGNpdGVzdCB1c2VyIHNwZWNpZmllcyAtRCBvcHRpb24uDQoNClJpZ2h0LCB5b3UgYXJl
IG9uIHRoZSByaWdodCB0cmFjay4NClBlcmhhcHMgeW91IGNvdWxkIHRha2UgYSBsb29rIGF0IHBh
dGNoIFsxXSB0aGF0IEkgaGF2ZSBkb25lIHNvbWUgdGltZSBhZ28gDQpmb3IgdGVzdGluZyB0aGUg
ZURNQSwgSSB0aGluayB5b3UgaGF2ZSBhbGwgdGhlIHRvb2xzL2d1aWRlbGluZSB0aGVyZSB0byAN
CmRvIHRoaXMgYWRhcHRpb24uDQpBbm90aGVyIHRoaW5nLCANCg0KWzFdIGh0dHBzOi8vcGF0Y2h3
b3JrLmtlcm5lbC5vcmcvcGF0Y2gvMTA3NjA1MjEvDQoNCg0KDQo=
