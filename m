Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 465122D3861
	for <lists+dmaengine@lfdr.de>; Wed,  9 Dec 2020 02:48:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725911AbgLIBr5 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 8 Dec 2020 20:47:57 -0500
Received: from mga03.intel.com ([134.134.136.65]:14994 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725803AbgLIBr5 (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Tue, 8 Dec 2020 20:47:57 -0500
IronPort-SDR: Jqp8EtPKcAk2dlkQTebZRSUVYzoqVOc5taWzSHTHbzsSzN/rPPVHdvhTuPPkLrdh3vgTFot46a
 Tga8hCqGnJPQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9829"; a="174121853"
X-IronPort-AV: E=Sophos;i="5.78,404,1599548400"; 
   d="scan'208";a="174121853"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Dec 2020 17:47:08 -0800
IronPort-SDR: kDv6uKP6TDvWpvby5BX2tO0h80XkP8DQAxc8hWIWJJxuGqHq6l3v4Ensprj8XtISds7iCRCaFR
 58I4DPbxBxdw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.78,404,1599548400"; 
   d="scan'208";a="332749810"
Received: from orsmsx606.amr.corp.intel.com ([10.22.229.19])
  by orsmga003.jf.intel.com with ESMTP; 08 Dec 2020 17:47:08 -0800
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX606.amr.corp.intel.com (10.22.229.19) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Tue, 8 Dec 2020 17:47:08 -0800
Received: from orsmsx602.amr.corp.intel.com (10.22.229.15) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Tue, 8 Dec 2020 17:47:08 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5
 via Frontend Transport; Tue, 8 Dec 2020 17:47:08 -0800
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.43) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.1713.5; Tue, 8 Dec 2020 17:47:07 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FV8KMDcXyjvx9uhpc32/zH9sD27oElBtMGTdkcFfX8uHZSDdbQDYKnUm03un7+WW2gdOC/kyuaIpofsfVTR8f/rVIfg02UWaqIfWUE/NTP5VJ1IjifwCLJXmberJJoC769QsYnVj264oMFSF+itge7pw4qbZ7MnyD/U3BywIrpQIqCJnxDFeVfC9UU9qKWcmeTopT579lmgHa1MwuZnHbaKOwxY0q1zQv1jIXbf+oas+ufVs6VxN8x6+0zwBoO1fE7i+y1r/OELPKst2Cm59xaEDvTdZOOhU5s9Lrvz38BeyuocDGC3Y3UcONki/OGyCZXDWaN1x/2xxQpxT/dDxHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z7Ey3xuLbQ6FVMCRMmTY8kUyusiFeMeywCZGWAo9QgA=;
 b=m/iY4h0hx3lU5nY10VXb2LlyvmRPzYShpWCjM+DyKem/oZVoLz1w61QaW7p6DSlb8x8nHwmurFnTc4iuUDt/KPKUy4fOaYiDsALMvaOH+tP7SihghuQ5qTlJTqtGGCHuUiCgIfcnNBPk8qJOoEnYTw88kkBlVjwCCi698y3zTffOh6mOsNjDl1El8RFhLll3CpGYn9taQs7LrmAYnKHnBrUmVWLsiSm1VDOrMcjsOCfVeVkMRWnpfV0NNuY5US/SlKlavUtJ4rBY3i69y2cYmrdjx0AD5vnskwfyn0YbfU6FAVR0iB0YoTvboRCxTSDuqLRWcu1pCl46cj1RBTCx5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z7Ey3xuLbQ6FVMCRMmTY8kUyusiFeMeywCZGWAo9QgA=;
 b=P8meKBPqobR8AXCG9j1JZz2TDicTnq4iXpvXbP1fF4KN4TbHQ7VijKJ9/AZHEl2bNDsu/wtyERRfctA9lD3xVLHp8EPa4F8xoTK9CZZc7QWn673xoI778naAeaTaHQfI0pWRsHUNmuCcUBY09p/aLMiDuSzVGuXM8zGwb4CP5+Q=
Received: from CO1PR11MB5026.namprd11.prod.outlook.com (2603:10b6:303:9c::13)
 by MWHPR1101MB2159.namprd11.prod.outlook.com (2603:10b6:301:53::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3654.12; Wed, 9 Dec
 2020 01:47:06 +0000
Received: from CO1PR11MB5026.namprd11.prod.outlook.com
 ([fe80::4820:6e90:3d0e:3b5f]) by CO1PR11MB5026.namprd11.prod.outlook.com
 ([fe80::4820:6e90:3d0e:3b5f%4]) with mapi id 15.20.3632.018; Wed, 9 Dec 2020
 01:47:06 +0000
From:   "Sia, Jee Heng" <jee.heng.sia@intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
CC:     "vkoul@kernel.org" <vkoul@kernel.org>,
        "Eugeniy.Paltsev@synopsys.com" <Eugeniy.Paltsev@synopsys.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Subject: RE: [PATCH v5 16/16] dmaengine: dw-axi-dmac: Virtually split the
 linked-list
Thread-Topic: [PATCH v5 16/16] dmaengine: dw-axi-dmac: Virtually split the
 linked-list
Thread-Index: AQHWwYJ+glIrRaUQ5Ui4w1NZjWNA3anuFftA
Date:   Wed, 9 Dec 2020 01:47:06 +0000
Message-ID: <CO1PR11MB5026ECF80EA76BD09B8A6A33DACC0@CO1PR11MB5026.namprd11.prod.outlook.com>
References: <20201123023452.7894-1-jee.heng.sia@intel.com>
 <20201123023452.7894-17-jee.heng.sia@intel.com>
 <20201123102256.GV4077@smile.fi.intel.com>
In-Reply-To: <20201123102256.GV4077@smile.fi.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-reaction: no-action
dlp-version: 11.5.1.3
authentication-results: linux.intel.com; dkim=none (message not signed)
 header.d=none;linux.intel.com; dmarc=none action=none header.from=intel.com;
x-originating-ip: [218.111.111.46]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 20525c49-5097-4c4a-7ad6-08d89be455d3
x-ms-traffictypediagnostic: MWHPR1101MB2159:
x-microsoft-antispam-prvs: <MWHPR1101MB215902BD0A297DFAA47521D5DACC0@MWHPR1101MB2159.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5516;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: hBrvpWWqPSh+TUIe2TRkh6cT19Vxcq4FVvaQzKSVoykLnJKq8SP4FYBriFQ+ioX/qI3onN9GpgJXCrafwMyFtpIrNdIxeJ8HjO9KamUX+Z9NiI6IfTPQPAnYNZ3LRWMyY7Ea+ISvhCABTT7Gyuc+vfHmYIoGMV+TbUsNDkBxcCcMuXM/ZwboKM0vacXoqAefm/6vSU6iBNH5uGbLyc9b8DHv05tb3xTgeprswu9P0lMPcFS+nm71tJbxoddACvWERTzQDuOLq1Z66jpGLCkb1WgMLPGtTazHSGZWMMmBAxXVZ4o1KlQgsTtQnjSbCgh4WVUrzK5jgkYJsqRXIGGFcUhP5ZTfJSyqtwccaL4kRgUBt21GtkRJsyaNsm2kkYgMazwDS+Is8Y4BJ0mCBYBhHg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5026.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(136003)(376002)(366004)(4326008)(86362001)(83380400001)(71200400001)(6506007)(53546011)(6916009)(54906003)(8936002)(9686003)(508600001)(66446008)(52536014)(45080400002)(2906002)(7696005)(66476007)(66556008)(8676002)(64756008)(66946007)(26005)(76116006)(5660300002)(33656002)(186003)(966005)(55016002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?UZv21fH2LR9azKAZgMFp3qW9k8eay3lG+DfQwe1x4+Rw3CnXq/M96boyUYsM?=
 =?us-ascii?Q?hx3bhhahCqFqueBaHl4SnzbXEGoGt7/Ui81h4rmge+LZrKHEEFky78/ScGL0?=
 =?us-ascii?Q?lpniPlHtE98zkrO5TtJSC1DF4kNoovafz+EHbH8iDGVGmY9rkKphkNba6x1y?=
 =?us-ascii?Q?ni+GiVPdBBRg8ZqQm/kT5XosMzF+QhZJ4vQ9ap4KkU+TDL+4LMCE9MM1l91n?=
 =?us-ascii?Q?E/G2+F8rm7lHu/A2QjJ1fUINb9KzDoBu9QGx51ypiFCxzGoN+psa81OLOCpC?=
 =?us-ascii?Q?gDW79/+TfkLcNwqhhOum6MHTNqo/FjJJP1+FSEGn9AeBiIAy+z6SNG7OaPy6?=
 =?us-ascii?Q?KL7Hf5eYbO1JaViDV1i19CT+wDp34lfvpzhCGCJbLXhY+bpOOoADGJ8s9RqQ?=
 =?us-ascii?Q?jQtgq2sTc2xJojyvbaO4+E3S366nvsDPHtak+pU3AdScxm7WFtWn5+I15zpr?=
 =?us-ascii?Q?xxpQRD6cHe0HS1qu5A3rP/cFFTJ1QBAjFqQqEg/ZWdtDmk75MwsOn1kp+mEJ?=
 =?us-ascii?Q?kRDgFYcTPRrX0M+ib0Et51QrfAPXx0PT1tDBrIRn/yW0+rSj4sbWAkDldQv0?=
 =?us-ascii?Q?3YLdOpZNlGtsLJtWOhfae+zeQEGN4kZwhe4A9qWqElBFITmLt8rtDlWl7nkc?=
 =?us-ascii?Q?t1cMI4F1NNCszXncMB0ag4gQKQ83YaT9JcgCwsLMm0oPM6bPMEWmp1l7P5qo?=
 =?us-ascii?Q?V6u7eSERKwDvrvGTUx+UIK+lydmrF+8ObYcTVcEpito3qK/e3xeEgD2vL25E?=
 =?us-ascii?Q?AVc2X2NOiwUZE9YJhKPP0o6QvYtLlA2/c3ZbO9Q/PXC62xFL6lk22mq/Db6T?=
 =?us-ascii?Q?a4kiE7XGLOL/0q7rwIQS/PcfRc78rjKkWQid6wJZ7kVZ1TunbaTZFBcvOLii?=
 =?us-ascii?Q?PU/9j2vQtEyaguh2BQTqQPhmVw/FfwRBQYAu3mIF3G8/m8Gx7a49A3eHyDJb?=
 =?us-ascii?Q?W1lrFy94Y1ALkyWtBbZVqjAbJ6dV/Rg00UvBFb6PabA=3D?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5026.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 20525c49-5097-4c4a-7ad6-08d89be455d3
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Dec 2020 01:47:06.6731
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7C9HyEF87MpewIpvc/hCkXf3uv48Ek5EnDkwvBbAQ79YcZUjI1kz3pqEQ7NW4p0jdYTXTSSWfb6Sp1p/frCumg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR1101MB2159
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org



> -----Original Message-----
> From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Sent: 23 November 2020 6:23 PM
> To: Sia, Jee Heng <jee.heng.sia@intel.com>
> Cc: vkoul@kernel.org; Eugeniy.Paltsev@synopsys.com;
> robh+dt@kernel.org; dmaengine@vger.kernel.org; linux-
> kernel@vger.kernel.org; devicetree@vger.kernel.org
> Subject: Re: [PATCH v5 16/16] dmaengine: dw-axi-dmac: Virtually split
> the linked-list
>=20
> On Mon, Nov 23, 2020 at 10:34:52AM +0800, Sia Jee Heng wrote:
> > AxiDMA driver exposed the dma_set_max_seg_size() to the
> DMAENGINE.
> > It shall helps the DMA clients to create size-optimized linked-list
> > for the controller.
> >
> > However, there are certain situations where DMA client might not be
> > abled to benefit from the dma_get_max_seg_size() if the segment
> size
> > can't meet the nature of the DMA client's operation.
> >
> > In the case of ALSA operation, ALSA application and driver expecting
> > to run in a period of larger than 10ms regardless of the bit depth.
> > With this large period, there is a strong request to split the
> > linked-list in the AxiDMA driver.
>=20
> I'm wondering why ASoC generic code can't use DMA channel and
> device capabilities and prepare SG list with all limitations taken into
> account.
[>>] There is no further comment to split the linked-list in DMA, I assume =
we can proceed with this patch.
[>>] The RFC patch is submitted at below link and you are in the thread.
[>>] https://lore.kernel.org/alsa-devel/CO1PR11MB5026545F07968DBC5386CF45DA=
CD0@CO1PR11MB5026.namprd11.prod.outlook.com/T/#u

>=20
>=20
> --
> With Best Regards,
> Andy Shevchenko
>=20

