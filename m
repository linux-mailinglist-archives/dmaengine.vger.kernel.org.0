Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1666B43B323
	for <lists+dmaengine@lfdr.de>; Tue, 26 Oct 2021 15:28:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235327AbhJZNal (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 26 Oct 2021 09:30:41 -0400
Received: from mga18.intel.com ([134.134.136.126]:10535 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236189AbhJZNak (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Tue, 26 Oct 2021 09:30:40 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10148"; a="216811430"
X-IronPort-AV: E=Sophos;i="5.87,184,1631602800"; 
   d="scan'208";a="216811430"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Oct 2021 06:22:37 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,184,1631602800"; 
   d="scan'208";a="664543131"
Received: from orsmsx606.amr.corp.intel.com ([10.22.229.19])
  by orsmga005.jf.intel.com with ESMTP; 26 Oct 2021 06:22:36 -0700
Received: from orsmsx609.amr.corp.intel.com (10.22.229.22) by
 ORSMSX606.amr.corp.intel.com (10.22.229.19) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.12; Tue, 26 Oct 2021 06:22:36 -0700
Received: from orsmsx608.amr.corp.intel.com (10.22.229.21) by
 ORSMSX609.amr.corp.intel.com (10.22.229.22) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.12; Tue, 26 Oct 2021 06:22:36 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx608.amr.corp.intel.com (10.22.229.21) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.12 via Frontend Transport; Tue, 26 Oct 2021 06:22:35 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.170)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2242.12; Tue, 26 Oct 2021 06:22:35 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Tqm4nBLG/MY82p3M6HPRSwT04skHDEinuOabixgEo56Ax80YDiNzFHsCKSSyCCP7U7kC3nuPamYnSfzOn4uI1eWVZ8j49xAoAfN+c9YgS3zYUN61JPDfxOcscDDHuwCEYZS/cLT//Sehwik8T9VEenfJvBLZzLmuzSyEWL6LjoYW/oAm9MJmiqmZGKakIwW50/EnfHvq3TB2+jz7qUz5Ji0XwNwwhxRPemlRTd5eNppBmuBKOObw4TME72HrNdLLfIrSxem05KMVL0DuMR2pyZ3+/E7ri40aLTYqC+Y5Au0BtIcTDXOeu37YW1KLb1+xz9wCrZDflXPFzTTlnqBDeQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4HqNGOvYzioWOlrZcY7ANH1fkxtaReOXMdx5AWv8Q+0=;
 b=V0WzK006O7b6LZE1uE88KF0+lAECz/d6CcSS0UDzmdrxM0+OYpeBChTxiNuvHNrokIyeTUqlhaV9IsHf/1Ke6bINtPBCYMKQFU+wzxy1Zbl7JobbUHqdjtsubqpGHiXM8DpFXZjYrPTablgcW9WCuk6wB2d6RzR+e21NgIyy5h43mB7a9wKr1C8AehSUf6q9VTenNDjYA2K7GOHRycMi/8euIeaRryFFJ/oqncZTFZyVDOH6BWy3VrdfeLJDz702XTy42f1KgvKozVthbQ1ia/LViFHRcWJbwYVWaZ1nicrCjgqfdXTIz2yWebGiqUuGqBtZp3I6/C/dPL7+aWBQHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4HqNGOvYzioWOlrZcY7ANH1fkxtaReOXMdx5AWv8Q+0=;
 b=nLIfXt3MjqOPAAiju62WhAQjZFaBgzwLOGg3iSyxn/DzaKJ6tieOWwwMfk3blmhjXQHShpurAvKJ2OWra2bX5tjRL/06Uqrp3sYG+MBlkXvCXyQt/NJoPCKHetoUtazRhajyoCyaSXvqtaAVt7MY7Z9huJ3teWSD4XNM0ECciXE=
Received: from BYAPR11MB3528.namprd11.prod.outlook.com (2603:10b6:a03:87::26)
 by BY5PR11MB4417.namprd11.prod.outlook.com (2603:10b6:a03:1c0::28) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4649.14; Tue, 26 Oct
 2021 13:22:34 +0000
Received: from BYAPR11MB3528.namprd11.prod.outlook.com
 ([fe80::a020:aef0:fadc:1ea]) by BYAPR11MB3528.namprd11.prod.outlook.com
 ([fe80::a020:aef0:fadc:1ea%3]) with mapi id 15.20.4628.020; Tue, 26 Oct 2021
 13:22:34 +0000
From:   "N, Pandith" <pandith.n@intel.com>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
CC:     Vinod <vkoul@kernel.org>,
        Eugeniy Paltsev <eugeniy.paltsev@synopsys.com>,
        dmaengine <dmaengine@vger.kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        "Sangannavar, Mallikarjunappa" 
        <mallikarjunappa.sangannavar@intel.com>,
        "Thokala, Srikanth" <srikanth.thokala@intel.com>,
        "Demakkanavar, Kenchappa" <kenchappa.demakkanavar@intel.com>,
        Emil Renner Berthing <kernel@esmil.dk>,
        Michael Zhu <michael.zhu@starfivetech.com>
Subject: RE: [PATCH V3 1/3] dmaengine: dw-axi-dmac: support DMAX_NUM_CHANNELS
 > 8
Thread-Topic: [PATCH V3 1/3] dmaengine: dw-axi-dmac: support DMAX_NUM_CHANNELS
 > 8
Thread-Index: AQHXts3OHz96r+xoRUm3pN3hM1ABHqvlVxsAgAAOUlA=
Date:   Tue, 26 Oct 2021 13:22:34 +0000
Message-ID: <BYAPR11MB35289B617207FD1B07E1A344E1849@BYAPR11MB3528.namprd11.prod.outlook.com>
References: <20211001140812.24977-1-pandith.n@intel.com>
 <20211001140812.24977-2-pandith.n@intel.com>
 <CAMuHMdUWEa+YCXKAjhz7SX7DtSf=dFW8s8vyTfvwq6AuetcMeQ@mail.gmail.com>
In-Reply-To: <CAMuHMdUWEa+YCXKAjhz7SX7DtSf=dFW8s8vyTfvwq6AuetcMeQ@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-reaction: no-action
dlp-version: 11.6.200.16
authentication-results: linux-m68k.org; dkim=none (message not signed)
 header.d=none;linux-m68k.org; dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 3d354e60-5a26-4221-ed00-08d99883abfc
x-ms-traffictypediagnostic: BY5PR11MB4417:
x-microsoft-antispam-prvs: <BY5PR11MB4417A32A234181D4697B3B96E1849@BY5PR11MB4417.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3044;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: RQjROyXHBaApRLuZPp/RjyYDhUaozb9g2j29Me/r25yhtdmag6mnQW2sNI0X1tHdRXvey0+rPeE1eVCW26dZuhiStxyoYFAOMwcva2vT7QLN5W4LEnruTNoRvyW2i33Xry0d3IwyunUOlW5TiAgr9P72oO7m1Kl5FMoS1YRnbGuQOfZgp5BBi1AbLhatJU0F5szRG8VqOa+dY6oVPPe8PrmeuIwYGwY9hKIo5/lkvkqOsQ6/7C5x/Z6nbQuND9k9Qk0E61REVq2BDUa1r9YLktlxVfYVZAXV7HVDN76kykOYrAbsuUAxJBYU63RaLILXInRk9ckl7lqrSBATYK+WPnSnYvXnzJItICRMNUJXJs0WEJKjcI1b2cdFk2xYcLK4Y/6yQjW9jgzJDMkthZ4Ne4GbJqPFnxjF2tgVmETjiICurp1wz9fGlwgtpt81JXWKep38U4/Szn7x8CBM1mC2+nh2k0lN6JlfL7Dw0PMoZqsM5GIq0FZGYBEFEsx1I3O0XqYMFlsI+fVtitDTwGAEqWX2fQuwoWXryi5wwbxbTUBhd8xYNk6yDUEXTximzXnCGCV4EBvrogY+Zk7cc4Eqk1+Ss50SnINRu2SbG2m3bwTsIK6qsKhiAGmjUVzskI6L+kxH7cBqnecZ7/vhJeffs0YgE2JGKU8mNnr21PAEDJZLKFDWoLuJ4+qAQuDdAXgekMpY6F/1YxGzjsgNBuhgxw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB3528.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(38070700005)(54906003)(186003)(53546011)(5660300002)(52536014)(508600001)(2906002)(82960400001)(8936002)(86362001)(6506007)(316002)(4326008)(7696005)(9686003)(33656002)(26005)(8676002)(71200400001)(55016002)(76116006)(64756008)(83380400001)(122000001)(66446008)(66946007)(6916009)(66476007)(66556008)(38100700002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Z3FuUmIvQkxJQUNBbldnZVlrRy9DanhUOWdCWHFlUkVSbkFDOGdmeFlyNEFS?=
 =?utf-8?B?Tk9CM0tmaDJMWm1ublZDT0VCazh3UWNTcU9CTnlyOEZJdXAzV3ljRmM3SnlI?=
 =?utf-8?B?SWVsdElhVTErK2prWVdVUmRZQnJtRkVMNE1pNnh6b3FDZU9jcUFSZWUyaC9G?=
 =?utf-8?B?M09rQ09zR3h2RzlJTlhxVTZLd3MzOS9xSUpTUVhadTA1aXo4ZjJ6Z2Rhc2Yv?=
 =?utf-8?B?WTUzMkFkUlUxQkFpRHdpZ0lmbGRKZXp6TTNFY1B5V3JYcmdRTkhWK3lYR081?=
 =?utf-8?B?MkZ6SU1oWUIxOVFQK3JiNC9LZW1RemU1L3dTakZ3YkduVmtTUk9KSW50M0x0?=
 =?utf-8?B?U0dFSlRONXRIQjVDVFY4c1VyYWo1ZU9GVlViRE1LYmhVT0pNalNzZHRDWFVh?=
 =?utf-8?B?ZFZkRHlWRnlZUHhLdGxXaCsvOEhVL0ZDY1AyTDJodFBncFlmY2tPTzZaWTF1?=
 =?utf-8?B?RDBJeEIrYXpYb0JFTnRqek9XRm5IWFFaUzJZeDNJVG82VkV5djdaNDg3TWl0?=
 =?utf-8?B?NzJLdGQ4QVpjU2tSSkdqZjZKSDNwQ1Q2U3M0aVUwU3R3UEtBdklNT1JiSnBa?=
 =?utf-8?B?MXJFVGt6SGlrT0o3SG1hd0hyTDFMZCsreWdTSzZZT29SVEE0dy9TbVZsM041?=
 =?utf-8?B?eU95b1JyRWdPaUhEbnBHdFdSRjNrMjRlV2RockNtSUE1cEczcUx1UWd3MVNq?=
 =?utf-8?B?OHRvMkJmeVlldlFNZEs5TXpEd2wybEdIZ3g5Y0pDVlh4NXdvSGxFZVcvVTBU?=
 =?utf-8?B?SnJveTBHaFQwWmNHeU9iZDJuSkFheDZwM2lBUlhyNmx0aHNGc3AwdGZBQWp6?=
 =?utf-8?B?VVIxbERWbGRHWHlJRHg4cGpnN3dubVUwQUliK0ZVZmNMSWoxdFZrYXlaS0NC?=
 =?utf-8?B?c2pYOTBTVEE5OFpTWS9ZYk9KUnh2OWdTTzV3dmRnR3orRzJwU0M1V2R5UzZn?=
 =?utf-8?B?aG44ME9kWkJhb3JPVlZVMUcwT3JXUHNreTlMRmpuaVErUHlNM3djV05ucnZO?=
 =?utf-8?B?Z1VaSkVEMTZLVGxOSUtoZ3RlZ0orWG4yKzdMWWgrMnAwZ09WemtyNWcrQ2pN?=
 =?utf-8?B?SnBzNXFyaVQyMHR1V1RIWWxFRk85YmJzQU5LL2trN3I4OURGaXJoY3gzcWY3?=
 =?utf-8?B?V3FpS2pFT3BOV0xBcWkwZDdCSjloQWQwMkFYQ09oUEV3SnZuaVNFdWVqeGVv?=
 =?utf-8?B?SGFDYWdiNVpoUEJIUDhvSkNTaGkrcFFBR1Jjd1M2Smc5NmpyU0FJZjkwcXBT?=
 =?utf-8?B?V0l3czVPL3k1dExkVUZnb1p5cjJJQ3JPdE5mUjk3Umc3QlN5TFFLeXdvbDFY?=
 =?utf-8?B?Z3RiR3RjUGsrV242dFcxZkQzVXlCUzdPTlowUmVaM2YzSkdQQWFNdXN6V0F1?=
 =?utf-8?B?ODY4aDV3aHR2a1NYb21RUkprZjEzM0NZZ2VVRG5hWCt5Yk43QW5rOWJFNmlO?=
 =?utf-8?B?bDFYTVdVd0ZOOHorN1hiSGpackl1UFl4VnJyZDB6d3N5bFBlODkvUU9hZTUy?=
 =?utf-8?B?dVdPbTVucnVoSnQzVGRrV2pRWUkrUWlzZ2g4OGUyWUxxS2tSWHZTMVp4NUFj?=
 =?utf-8?B?K0dWZ0g4QVNKUUY2Q1lLTFZFYmxTYkpINVJOQlR4ZlhHMDQ2NHFGRnNGUHBw?=
 =?utf-8?B?UXF0bkRhOXEyQTJBU2hSbm1RZ2FLQXlsZnJzVnVKTzY0cFZnVy9WRXNKcTFr?=
 =?utf-8?B?SExOZ2J6VXRhVVhBZUFyalJzUW1OVko2WVk1QzJzNXJlSHc4cnFHWlZmTUph?=
 =?utf-8?B?YW9weXlXcnkwOTd5SXBXbXpGaHBmY3ViUi84NWJpL0I1NUFSSEx3dkVzUFM5?=
 =?utf-8?B?c0RWaFpiVVAzazJRWDBLRG4vc0pmRTcrTWpSR1hucVhkcldKRVNhQSthYzl0?=
 =?utf-8?B?aWtoUGpOcUx5Q3Nab0FwU3BWaWMwSHgxZnN0S1Q0d3Z0T1lxdWN0M295NHE5?=
 =?utf-8?B?U21qNkNDQi9pM0UrR1lMbHQ4YjR4cmJPQVF4UVRxQnpWdUl2Z3pKYktZRkJL?=
 =?utf-8?B?aGpKaVRLR041MUhOVzJ0cnNZQVhzQ2VQSUZDbzMyVW5mMlptWEdnSmR2ckUy?=
 =?utf-8?B?b0Q3TFFDVzNkUnc0Z2FROWR1MmVIeWkvTVpiVmQ5L2UrcVRSOXRFL29KeGZh?=
 =?utf-8?B?Zm5UWWNoM1FuNkROL2FsUURBeVR4NEEzWmlqQVd6bUZZV1p5SnNiS2Nlelh5?=
 =?utf-8?Q?wSEzM79aDO+MvG6T1RvoeqU=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB3528.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3d354e60-5a26-4221-ed00-08d99883abfc
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Oct 2021 13:22:34.2073
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: yENcbIlJO3IbL1+jvGR/TQIhYN8H3G3W7ZvCpGu3KIpdgMZ6sjiddNz1C1CCBFAaCKzmN9Xq4pL1sbLXJYuDgw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR11MB4417
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

SGkgR2VlcnQsDQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogR2VlcnQg
VXl0dGVyaG9ldmVuIDxnZWVydEBsaW51eC1tNjhrLm9yZz4NCj4gU2VudDogVHVlc2RheSwgT2N0
b2JlciAyNiwgMjAyMSA1OjQwIFBNDQo+IFRvOiBOLCBQYW5kaXRoIDxwYW5kaXRoLm5AaW50ZWwu
Y29tPg0KPiBDYzogVmlub2QgPHZrb3VsQGtlcm5lbC5vcmc+OyBFdWdlbml5IFBhbHRzZXYNCj4g
PGV1Z2VuaXkucGFsdHNldkBzeW5vcHN5cy5jb20+OyBkbWFlbmdpbmUgPGRtYWVuZ2luZUB2Z2Vy
Lmtlcm5lbC5vcmc+Ow0KPiBBbmR5IFNoZXZjaGVua28gPGFuZHJpeS5zaGV2Y2hlbmtvQGxpbnV4
LmludGVsLmNvbT47IFNhbmdhbm5hdmFyLA0KPiBNYWxsaWthcmp1bmFwcGEgPG1hbGxpa2FyanVu
YXBwYS5zYW5nYW5uYXZhckBpbnRlbC5jb20+OyBUaG9rYWxhLCBTcmlrYW50aA0KPiA8c3Jpa2Fu
dGgudGhva2FsYUBpbnRlbC5jb20+OyBEZW1ha2thbmF2YXIsIEtlbmNoYXBwYQ0KPiA8a2VuY2hh
cHBhLmRlbWFra2FuYXZhckBpbnRlbC5jb20+OyBFbWlsIFJlbm5lciBCZXJ0aGluZw0KPiA8a2Vy
bmVsQGVzbWlsLmRrPjsgTWljaGFlbCBaaHUgPG1pY2hhZWwuemh1QHN0YXJmaXZldGVjaC5jb20+
DQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggVjMgMS8zXSBkbWFlbmdpbmU6IGR3LWF4aS1kbWFjOiBz
dXBwb3J0DQo+IERNQVhfTlVNX0NIQU5ORUxTID4gOA0KPiANCj4gSGkgUGFuZGl0aCwNCj4gDQo+
IE9uIEZyaSwgT2N0IDEsIDIwMjEgYXQgNDoxMyBQTSA8cGFuZGl0aC5uQGludGVsLmNvbT4gd3Jv
dGU6DQo+ID4gRnJvbTogUGFuZGl0aCBOIDxwYW5kaXRoLm5AaW50ZWwuY29tPg0KPiA+DQo+ID4g
QWRkZWQgc3VwcG9ydCBmb3IgRE1BIGNvbnRyb2xsZXIgd2l0aCBtb3JlIHRoYW4gOCBjaGFubmVs
cy4NCj4gPiBETUFDIHJlZ2lzdGVyIG1hcCBjaGFuZ2VzIGJhc2VkIG9uIG51bWJlciBvZiBjaGFu
bmVscy4NCj4gPg0KPiA+IEVuYWJsaW5nIERNQUMgY2hhbm5lbDoNCj4gPiBETUFDX0NIRU5SRUcg
aGFzIHRvIGJlIHVzZWQgd2hlbiBudW1iZXIgb2YgY2hhbm5lbHMgPD0gOA0KPiA+IERNQUNfQ0hF
TlJFRzIgaGFzIHRvIGJlIHVzZWQgd2hlbiBudW1iZXIgb2YgY2hhbm5lbHMgPiA4DQo+ID4NCj4g
PiBDb25maWd1cmluZyBETUEgY2hhbm5lbDoNCj4gPiBDSHhfQ0ZHIGhhcyB0byBiZSB1c2VkIHdo
ZW4gbnVtYmVyIG9mIGNoYW5uZWxzIDw9IDgNCj4gPiBDSHhfQ0ZHMiBoYXMgdG8gYmUgdXNlZCB3
aGVuIG51bWJlciBvZiBjaGFubmVscyA+IDgNCj4gPg0KPiA+IFN1c3BlbmRpbmcgYW5kIHJlc3Vt
aW5nIGNoYW5uZWw6DQo+ID4gRE1BQ19DSEVOUkVHIGhhcyB0byBiZSB1c2VkIHdoZW4gbnVtYmVy
IG9mIGNoYW5uZWxzIDw9IDgNCj4gPiBETUFDX0NIU1VTUFJFRyBoYXMgdG8gYmUgdXNlZCBmb3Ig
c3VzcGVuZGluZyBhIGNoYW5uZWwgPiA4DQo+ID4NCj4gPiBTaWduZWQtb2ZmLWJ5OiBQYW5kaXRo
IE4gPHBhbmRpdGgubkBpbnRlbC5jb20+DQo+ID4gUmV2aWV3ZWQtYnk6IEFuZHkgU2hldmNoZW5r
byA8YW5kcml5LnNoZXZjaGVua29AbGludXguaW50ZWwuY29tPg0KPiANCj4gVGhhbmtzIGZvciB5
b3VyIHBhdGNoLCB3aGljaCBpcyBub3cgY29tbWl0IDgyNDM1MTY2OGE0MTNhZjcNCj4gKCJkbWFl
bmdpbmU6IGR3LWF4aS1kbWFjOiBzdXBwb3J0IERNQVhfTlVNX0NIQU5ORUxTID4gOCIpIGluDQo+
IGRtYWVuZ2luZS9uZXh0Lg0KPiANCj4gPiAtLS0NCj4gPiBDaGFuZ2VzIFYxLS0+VjI6DQo+ID4g
SW5pdGlhbGl6ZSByZWdpc3RlciB2YWx1ZXMgaW4gY2hhbm5lbCByZXN1bWUgYW5kIHBhdXNlIFJl
bW92ZWQNCj4gPiB1bndhbnRlZCBicmFjZXMgaW4gZmxvdyBjb250cm9sIHNldHRpbmcuDQo+ID4N
Cj4gPiBDaGFuZ2VzIGZyb20gdjItPnYzDQo+ID4gY2hlY2sgaWYgY2hhbm5lbCBpcyBlbmFibGVk
LCBiZWZvcmUgc3VzcGVuZGluZy4NCj4gDQo+IEkgY291bGRuJ3QgZmluZCB0aGVzZSB2ZXJzaW9u
cyBpbiB0aGUgYXJjaGl2ZSwgc28gSSBkb24ndCBrbm93IGlmIG15IGNvbW1lbnRzDQo+IGJlbG93
IHdlcmUgbWFkZSBiZWZvcmUuLi4NCj4gDQo+ID4gLS0tIGEvZHJpdmVycy9kbWEvZHctYXhpLWRt
YWMvZHctYXhpLWRtYWMtcGxhdGZvcm0uYw0KPiA+ICsrKyBiL2RyaXZlcnMvZG1hL2R3LWF4aS1k
bWFjL2R3LWF4aS1kbWFjLXBsYXRmb3JtLmMNCj4gDQo+ID4gQEAgLTExMjAsMTAgKzExNTAsMTcg
QEAgc3RhdGljIGludCBkbWFfY2hhbl9wYXVzZShzdHJ1Y3QgZG1hX2NoYW4NCj4gPiAqZGNoYW4p
DQo+ID4NCj4gPiAgICAgICAgIHNwaW5fbG9ja19pcnFzYXZlKCZjaGFuLT52Yy5sb2NrLCBmbGFn
cyk7DQo+ID4NCj4gPiAtICAgICAgIHZhbCA9IGF4aV9kbWFfaW9yZWFkMzIoY2hhbi0+Y2hpcCwg
RE1BQ19DSEVOKTsNCj4gPiAtICAgICAgIHZhbCB8PSBCSVQoY2hhbi0+aWQpIDw8IERNQUNfQ0hB
Tl9TVVNQX1NISUZUIHwNCj4gPiAtICAgICAgICAgICAgICBCSVQoY2hhbi0+aWQpIDw8IERNQUNf
Q0hBTl9TVVNQX1dFX1NISUZUOw0KPiA+IC0gICAgICAgYXhpX2RtYV9pb3dyaXRlMzIoY2hhbi0+
Y2hpcCwgRE1BQ19DSEVOLCB2YWwpOw0KPiA+ICsgICAgICAgaWYgKGNoYW4tPmNoaXAtPmR3LT5o
ZGF0YS0+cmVnX21hcF84X2NoYW5uZWxzKSB7DQo+ID4gKyAgICAgICAgICAgICAgIHZhbCA9IGF4
aV9kbWFfaW9yZWFkMzIoY2hhbi0+Y2hpcCwgRE1BQ19DSEVOKTsNCj4gPiArICAgICAgICAgICAg
ICAgdmFsIHw9IEJJVChjaGFuLT5pZCkgPDwgRE1BQ19DSEFOX1NVU1BfU0hJRlQgfA0KPiA+ICsg
ICAgICAgICAgICAgICAgICAgICAgIEJJVChjaGFuLT5pZCkgPDwgRE1BQ19DSEFOX1NVU1BfV0Vf
U0hJRlQ7DQo+ID4gKyAgICAgICAgICAgICAgIGF4aV9kbWFfaW93cml0ZTMyKGNoYW4tPmNoaXAs
IERNQUNfQ0hFTiwgdmFsKTsNCj4gPiArICAgICAgIH0gZWxzZSB7DQo+ID4gKyAgICAgICAgICAg
ICAgIHZhbCA9IDA7DQo+IA0KPiBTbyB1bmxpa2UgZm9yIHRoZSBETUFDX0NIRU4gcmVnaXN0ZXIs
IHlvdSBkb24ndCBoYXZlIHRvIHJldGFpbiB0aGUgb2xkIHZhbHVlcw0KPiBmb3IgdGhlIERNQUNf
Q0hTVVNQUkVHIHJlZ2lzdGVyPw0KPiANCkRNQUNfQ0hTVVNQUkVHIHJlZ2lzdGVycyBoYXMgZGVm
aW5pdGlvbnMgb25seSBmb3IgY2hhbm5lbCBzdXNwZW5zaW9uLg0KQ0hfU1VTUCBpcyB3cml0dGVu
IG9ubHkgaWYgdGhlIGNvcnJlc3BvbmRpbmcgY2hhbm5lbCB3cml0ZSBlbmFibGUgYml0IGlzIHNl
dCwgaGVuY2Ugbm8gbmVlZCB0byByZXRhaW4gb2xkIHZhbHVlcy4NCg0KPiA+ICsgICAgICAgICAg
ICAgICB2YWwgfD0gQklUKGNoYW4tPmlkKSA8PCBETUFDX0NIQU5fU1VTUDJfU0hJRlQgfA0KPiA+
ICsgICAgICAgICAgICAgICAgICAgICAgIEJJVChjaGFuLT5pZCkgPDwgRE1BQ19DSEFOX1NVU1Ay
X1dFX1NISUZUOw0KPiANCj4gV2h5IG5vdCAidmFsID0gQklUKC4uLikgfCBCSVQoLi4uKSI/DQo+
IA0KWWVzLCB0aGlzIGNvdWxkIGJlICJ2YWwgPSBCSVQoLi4uKSB8IEJJVCguLi4pIg0KDQo+ID4g
KyAgICAgICAgICAgICAgIGF4aV9kbWFfaW93cml0ZTMyKGNoYW4tPmNoaXAsIERNQUNfQ0hTVVNQ
UkVHLCB2YWwpOw0KPiA+ICsgICAgICAgfQ0KPiA+DQo+ID4gICAgICAgICBkbyAgew0KPiA+ICAg
ICAgICAgICAgICAgICBpZiAoYXhpX2NoYW5faXJxX3JlYWQoY2hhbikgJiBEV0FYSURNQUNfSVJR
X1NVU1BFTkRFRCkNCj4gDQo+IEdye29ldGplLGVldGluZ31zLA0KPiANCj4gICAgICAgICAgICAg
ICAgICAgICAgICAgR2VlcnQNCj4gDQo+IC0tDQo+IEdlZXJ0IFV5dHRlcmhvZXZlbiAtLSBUaGVy
ZSdzIGxvdHMgb2YgTGludXggYmV5b25kIGlhMzIgLS0gZ2VlcnRAbGludXgtDQo+IG02OGsub3Jn
DQo+IA0KPiBJbiBwZXJzb25hbCBjb252ZXJzYXRpb25zIHdpdGggdGVjaG5pY2FsIHBlb3BsZSwg
SSBjYWxsIG15c2VsZiBhIGhhY2tlci4gQnV0IHdoZW4NCj4gSSdtIHRhbGtpbmcgdG8gam91cm5h
bGlzdHMgSSBqdXN0IHNheSAicHJvZ3JhbW1lciIgb3Igc29tZXRoaW5nIGxpa2UgdGhhdC4NCj4g
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAtLSBMaW51cyBUb3J2YWxkcw0K
