Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 074EF2AE60F
	for <lists+dmaengine@lfdr.de>; Wed, 11 Nov 2020 02:53:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731713AbgKKBxV (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 10 Nov 2020 20:53:21 -0500
Received: from mga03.intel.com ([134.134.136.65]:52815 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731610AbgKKBxU (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Tue, 10 Nov 2020 20:53:20 -0500
IronPort-SDR: /D9z51vc15mUr6E4DH6aXJbbfW4MwEj0TdqRVy0nVJRbIQwuPikmPLjMPe99FEgr1TMcSU59+L
 XU8MYc9raj7w==
X-IronPort-AV: E=McAfee;i="6000,8403,9801"; a="170188858"
X-IronPort-AV: E=Sophos;i="5.77,468,1596524400"; 
   d="scan'208";a="170188858"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Nov 2020 17:53:20 -0800
IronPort-SDR: +m8RZon1JT9McCEGdZ6HxOshGFDUPJ1BYe3am78HmjS7jZJNbcipgz8jFjpAh0Q2Dwfi86ugEk
 rBK8tsZc24Wg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,468,1596524400"; 
   d="scan'208";a="360357080"
Received: from orsmsx606.amr.corp.intel.com ([10.22.229.19])
  by fmsmga002.fm.intel.com with ESMTP; 10 Nov 2020 17:53:19 -0800
Received: from orsmsx609.amr.corp.intel.com (10.22.229.22) by
 ORSMSX606.amr.corp.intel.com (10.22.229.19) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Tue, 10 Nov 2020 17:53:19 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx609.amr.corp.intel.com (10.22.229.22) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5
 via Frontend Transport; Tue, 10 Nov 2020 17:53:19 -0800
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.107)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.1713.5; Tue, 10 Nov 2020 17:53:17 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=diHbdqgOzGIeS4oUV9Cskj1hWmPC20SCLhOCp03GD59rERTXYPygS4VsXhfNMEsJLImr6qzavjjqlJw8RTPBdA0ZRpvq9hcCV7d1jVTy3kisz7gmqmG+88M3sUQYlcfCofRfilt0CCQOh2YqbnbzzjvuFg7KKGoVy2BhT+iK5liHwYItRdYbReSPpnItaYKmOE1pmy9AOPCXLWjMfLmF6vql8KTutzaiQxEKoXbnb394gdyYGGIIVvKDCIYKcMO9f6dbl9ERvwQ6I0lN5H9SEPkdzUQ8wgs5jXYwPLeb6T9vZccwKJoRUWSWa+47O+PhgFCQYhk6jbnrpn8pE7lRtg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aJhIBD9is4Zn0a2CkVEmoN/iJN4ZCW0JHWWG9GQvHsc=;
 b=Fxpfgn1YCcQeQ5DUAgr0ktQqQs2rFMaSvTWRDXdvHQqM6rteaXqr84ufKwOAUWRTPC7VWJu1YXyLWore7QHx7kL47LUGRt+3G7zASjjf7XBvcupf6FJX05MHNZJJ+weKEZVE38CNYirOLLS2KcMXf4fm+RQX9V8qEI/yQ4Yk1YKFk5h+nZRm87fKV+p3tkcwN0Pqa/h99eTtvXrTGmB9NqN1xuHOaRxCBEomNItryLRqOxWI1T6+Nh9y2M6vv4UELa2y+agfuNeDgyTs9m8b8Z8EsJRcQB18AMJTrhUSUK3SkwyUtCRIrZIbN1t9ZovEjW2hgRqEgstRL2u2WK8lXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aJhIBD9is4Zn0a2CkVEmoN/iJN4ZCW0JHWWG9GQvHsc=;
 b=ODSQN4g5dBVKVX9soX6DqutVYej20JnX2HpIhyCmP6l6Yw/Bs0ZPIHHc3MjL4JC02kSakWKciYNAP6znk1MpXCtkO+anlMJg19Di84bQEw+Ym+ZCwC1IdVNvmRbJclK1/idSeyCfn7xEdcJEwNLXeFUbXhjM5Vrid93Bt2KOe8I=
Received: from CO1PR11MB5026.namprd11.prod.outlook.com (2603:10b6:303:9c::13)
 by MW3PR11MB4619.namprd11.prod.outlook.com (2603:10b6:303:5b::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3541.21; Wed, 11 Nov
 2020 01:53:16 +0000
Received: from CO1PR11MB5026.namprd11.prod.outlook.com
 ([fe80::40d9:aa4b:73e7:3d60]) by CO1PR11MB5026.namprd11.prod.outlook.com
 ([fe80::40d9:aa4b:73e7:3d60%3]) with mapi id 15.20.3499.032; Wed, 11 Nov 2020
 01:53:16 +0000
From:   "Sia, Jee Heng" <jee.heng.sia@intel.com>
To:     Vinod Koul <vkoul@kernel.org>
CC:     "Eugeniy.Paltsev@synopsys.com" <Eugeniy.Paltsev@synopsys.com>,
        "andriy.shevchenko@linux.intel.com" 
        <andriy.shevchenko@linux.intel.com>,
        "dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v2 12/15] dmaengine: dw-axi-dmac: Add Intel KeemBay DMA
 register fields
Thread-Topic: [PATCH v2 12/15] dmaengine: dw-axi-dmac: Add Intel KeemBay DMA
 register fields
Thread-Index: AQHWtn7A627rVvuT70iz+gYK/SHlmanCLRfQ
Date:   Wed, 11 Nov 2020 01:53:16 +0000
Message-ID: <CO1PR11MB50260315873FE1DA91B8E7A0DAE80@CO1PR11MB5026.namprd11.prod.outlook.com>
References: <20201027063858.4877-1-jee.heng.sia@intel.com>
 <20201027063858.4877-13-jee.heng.sia@intel.com>
 <20201109095710.GF3171@vkoul-mobl>
In-Reply-To: <20201109095710.GF3171@vkoul-mobl>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-reaction: no-action
dlp-version: 11.5.1.3
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=intel.com;
x-originating-ip: [175.142.41.19]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 7583135d-e8ce-4af7-079d-08d885e48e86
x-ms-traffictypediagnostic: MW3PR11MB4619:
x-microsoft-antispam-prvs: <MW3PR11MB46190FB1330D1803D34E7BD5DAE80@MW3PR11MB4619.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6430;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: tfSoqDbmvtmOOoJNpooQmRw/pPYIYBLVwNKS8Ze8PNZUJOHhC8FEthOiHrUcuUk4OWXecgZHlRfxbCaqo+oqWMNk4B5YiqhPdOkcgDwybnZ5csiF6PY4A7yZkn5wc+4gG1fzdXzlorkKPBb+6Q94NjBMrZD6rIXYp8lbY2xRjpAKt5TWI8URs88MsA8hc5LrjKzCrrBvO+G2MR+9hLUwBpnQFmH90UPw8ZoRNTWjGS05TZW6QrAjzUsPSHeRU/GYFr3xqRQF0s3oPUKGSY8Q8h3QYRLR8O/jTKaad4XuvcJcJKfJoTAMUTaSdCyQ/kO4
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5026.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(136003)(366004)(39860400002)(346002)(376002)(7696005)(4326008)(53546011)(316002)(9686003)(8676002)(86362001)(64756008)(66446008)(478600001)(33656002)(66946007)(54906003)(186003)(6916009)(76116006)(83380400001)(52536014)(5660300002)(6506007)(4744005)(55016002)(26005)(2906002)(66556008)(8936002)(71200400001)(66476007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: GXXLOPgVGDOHG9aqhiZsEyWPd3B2O9foK/u+mjWuMzg1HR8vMN9ecKsfKzaPbzgXB1QHhtylsh/OMga1riMqlV/tI85qmIL5/rgSWtnUdVf42YvMpMRaLCzmcRnhJ0L9t/0TnZrnGk6WUBAaJL3Ha3udrIU4/q9seh70tr/0NHP7PTusc03A1fzeXtAwdBsSKUEyDHluQ89qs0nJEan1X6MA3Jz+I6y57GqnUxwHz4LBMWZVb371RwqxiCo8HmCVFAQoATT12b0D0XUbc6B1LxGSUuBVOJdMX8kZmZCksGtuE2f6/Uhi4Y+rFbYwSrCsGlRG7sAfNDgKExtuj8nZDe+uODMMLWidQtdqHJ6xRYG0UCXY1SIMc+ko15b+23nY5QY1n0EhtwbYbUtb7VE0IVk4XKqSRy5wFT4Srjwi+5MBrMtBFC7lsVKYZ49HT4FXM8h7tceVIMHUp7Bh/M+2ZWSFNY4RFLs7GzcsWkLDX3XObIwzafhowamPi0PlVtX5ZUeo1lINM1zJJeWw+qVM0AXNtgmArwE2Ew1PwzQwnVHm2LNSohciwQ3T7P9UpliCDhzL4N1Wf/dhNRX4YFqROy8OeI3TCQqjTLLLkmC+dhAhaP5L/woZSGJJlyFislQ9ZDyqXaLs1aBrGf0aEwv75g==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5026.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7583135d-e8ce-4af7-079d-08d885e48e86
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Nov 2020 01:53:16.1219
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: WjZ5TaltgntDZ6zJjbZDkbuAj4RMaka7eXjWC5AK7sK5/FsGkGQ2K9/5v9USgDNTYiEQbEmHy6844kzcEYnqHg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR11MB4619
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org



> -----Original Message-----
> From: Vinod Koul <vkoul@kernel.org>
> Sent: 09 November 2020 5:57 PM
> To: Sia, Jee Heng <jee.heng.sia@intel.com>
> Cc: Eugeniy.Paltsev@synopsys.com; andriy.shevchenko@linux.intel.com;
> dmaengine@vger.kernel.org; linux-kernel@vger.kernel.org
> Subject: Re: [PATCH v2 12/15] dmaengine: dw-axi-dmac: Add Intel KeemBay
> DMA register fields
>=20
> On 27-10-20, 14:38, Sia Jee Heng wrote:
> > Add support for Intel KeemBay DMA registers. These registers are
> > required to run data transfer between device to memory and memory to
> > device on Intel KeemBay SoC.
>=20
> Again this should come first, you need to add all the bits required to su=
pport this
> soc and then add compatible..
[>>] Noted. Meaning that this patch should be 11th and the compatible patch=
 is 12th. Will change this order in v3.
>=20
> --
> ~Vinod
