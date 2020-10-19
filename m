Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8438A2920D9
	for <lists+dmaengine@lfdr.de>; Mon, 19 Oct 2020 03:22:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728088AbgJSBWK (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Sun, 18 Oct 2020 21:22:10 -0400
Received: from mga12.intel.com ([192.55.52.136]:34863 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728042AbgJSBWK (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Sun, 18 Oct 2020 21:22:10 -0400
IronPort-SDR: 5TYCE2gRfXfJkDtGrJT0G/CBgQwBqpuDiydBcVl3VJTqQP07Hj3Y9njyC54AQhFMIwdpn4PeL/
 WMpeBRrmhXcw==
X-IronPort-AV: E=McAfee;i="6000,8403,9778"; a="146246680"
X-IronPort-AV: E=Sophos;i="5.77,392,1596524400"; 
   d="scan'208";a="146246680"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Oct 2020 18:22:09 -0700
IronPort-SDR: HN6T/3Q4riA3MvQKcENmKJwBp/Wig4oAe2+MV4tJ4RKpcZWHEB6xQfozASvroL+0SpALhaacOE
 4WVFQBkm8yTA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,392,1596524400"; 
   d="scan'208";a="532442759"
Received: from fmsmsx604.amr.corp.intel.com ([10.18.126.84])
  by orsmga005.jf.intel.com with ESMTP; 18 Oct 2020 18:22:08 -0700
Received: from fmsmsx607.amr.corp.intel.com (10.18.126.87) by
 fmsmsx604.amr.corp.intel.com (10.18.126.84) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Sun, 18 Oct 2020 18:22:07 -0700
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx607.amr.corp.intel.com (10.18.126.87) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Sun, 18 Oct 2020 18:22:07 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5
 via Frontend Transport; Sun, 18 Oct 2020 18:22:07 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.170)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.1713.5; Sun, 18 Oct 2020 18:22:05 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kvOfYM9LJFtHD/q49BYo0YkG6FFJTfv8KT0ooEMsVtqyWMF28TX2L3eNC9zxqTRQEoHajFemYCKEeRFqhjWPuskQOTyGO3lif5ZMU+p+m4tQduuIMqClbHYzSAwXS9PUwKgDK0tCgbXaw+MJYwdNfBBRYYCX9huWpJX+AuRrJYuh7hIDaQ6K6jcm9pY0kSpy6zWUfVcCmtmO5zg4sh22zmHz7fsHrhyy4Zr5KhXy0P7pg+dCvyULqytYeGrWRXsxcvNuRZE5Xj9qopyL1HN/74k0Z4m3ElbtFr3IE5Voh3/CdaO4AXAaVMve5XHUl5kMmXguuxi0Vd0MFobIYMJVPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kWoU+sKGZhkE8Ce+F5lOyyyK3pbCmXTMy/QyBPmq/bg=;
 b=YgP56nv9ih5yDbiNPmRdx5qQjmqMI4fG0t6uRbQ5q7zBBGjZbi0duXnyvxS6loOre5mwjL9tYhu2Z2+QhEVXYCdhjcuisl3fODLLGlSMuYCrZ62LYdmEpX6XVZcuwZGqHRu/K1a9ODsdfDUsuhhrhFl2mICBY1H3muvkswCRdnINI5xXQQQzlubG7jRnLPqugiaBYWLIFY/WBvnX9UDf4Cjrt2R5EGYyx4YIWZLU25KzdJ36Usfv6R6CK+cq6tfBd19wTZ62pxIjwTJBA7yDDpB6ZJuISBVohpm7S1K+qITQMNaDn8WOre5qs/MWv8aXE2f9SsEkMo5Y8sgX1f+XVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kWoU+sKGZhkE8Ce+F5lOyyyK3pbCmXTMy/QyBPmq/bg=;
 b=tzu0jX2Op3ZqeMCkkEcLYDYMmLXP+nJlO/i6SWWA84UPeD0DR4JHt1mTr1e6/q+UbEx1qRliL6YSrhJYNlOdh5iT7BTovqHPVN30Zr+Fgz6godZOeB+46OU3G7zcjfHCM7fHmEvZ0BZmtoSCkfAChKTg2O/U9xIZpqk+R4BVH2M=
Received: from DM5PR1101MB2218.namprd11.prod.outlook.com (2603:10b6:4:4f::12)
 by DM6PR11MB2587.namprd11.prod.outlook.com (2603:10b6:5:c3::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3455.21; Mon, 19 Oct
 2020 01:22:04 +0000
Received: from DM5PR1101MB2218.namprd11.prod.outlook.com
 ([fe80::49ce:b38c:2ee:128f]) by DM5PR1101MB2218.namprd11.prod.outlook.com
 ([fe80::49ce:b38c:2ee:128f%10]) with mapi id 15.20.3477.028; Mon, 19 Oct 2020
 01:22:04 +0000
From:   "Sia, Jee Heng" <jee.heng.sia@intel.com>
To:     Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>
CC:     "andriy.shevchenko@linux.intel.com" 
        <andriy.shevchenko@linux.intel.com>,
        "dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "vkoul@kernel.org" <vkoul@kernel.org>,
        Alexey Brodkin <Alexey.Brodkin@synopsys.com>
Subject: RE: [PATCH 00/15] dmaengine: dw-axi-dmac: support Intel KeemBay
 AxiDMA
Thread-Topic: [PATCH 00/15] dmaengine: dw-axi-dmac: support Intel KeemBay
 AxiDMA
Thread-Index: AQHWo8vT4R/NJ+ZUxUWa9ym9koIG+6meI5ZQ
Date:   Mon, 19 Oct 2020 01:22:03 +0000
Message-ID: <DM5PR1101MB22185FFAE24516B90B13D255DA1E0@DM5PR1101MB2218.namprd11.prod.outlook.com>
References: <20201012042200.29787-1-jee.heng.sia@intel.com>
 <MWHPR12MB18065E87CEE3FD28868EBB9BDE030@MWHPR12MB1806.namprd12.prod.outlook.com>
In-Reply-To: <MWHPR12MB18065E87CEE3FD28868EBB9BDE030@MWHPR12MB1806.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-reaction: no-action
dlp-version: 11.5.1.3
authentication-results: synopsys.com; dkim=none (message not signed)
 header.d=none;synopsys.com; dmarc=none action=none header.from=intel.com;
x-originating-ip: [210.186.89.31]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a6532835-3b0d-4b25-2121-08d873cd631d
x-ms-traffictypediagnostic: DM6PR11MB2587:
x-microsoft-antispam-prvs: <DM6PR11MB2587CC61E77182AAA38505E8DA1E0@DM6PR11MB2587.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: AjPeyxr5qevKw+23Yo8fH19bgQaK/+EEfeSRhxiH+RTtBhIMRHscR6OnAVA9CuU74Lhrsx3vQjh8ANFswBlZfYsowCB2PCItFMBNdjr5I9Fl5Vp6LqmyBJNoEnO7kHDaatIDNAoCtULzwXWUuPf7sFIPs7q8Cy/7GneENr74FOvBaaEI3Md7hIZm+UPlgRG0beS6Eieb603tNkVGdulmazxBssogjQiYBw0P42wqIWTLJwWWloarIJ78tLE6n2M7x8hRussxY0aPt+sWgy1exij5OdPoPNGi2YIOjsYIOQNrNhJ63iu0urSDYh4PpKWyrBDcDqSiY05CqORipotNsmlb0aVdElI8ZIpnydeGE46r11XDZwqt/y7G5d7xOMFfFCsXThsZyjZTE/kFLvRajw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR1101MB2218.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(366004)(136003)(376002)(396003)(346002)(26005)(5660300002)(86362001)(54906003)(186003)(71200400001)(478600001)(33656002)(64756008)(66556008)(66476007)(66946007)(76116006)(66446008)(53546011)(6506007)(52536014)(55016002)(966005)(7696005)(6916009)(4326008)(2906002)(83380400001)(8676002)(8936002)(9686003)(316002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: cpE91d0XdYXWJA40KS4R7Qe2q7lEyRiIsk3LfVGvmX/nct5qgLZ09M0faLPcQZuKY12U1YuRItZAmk54j8Oo6UO4TNM0S5sdGYlC4ZFsMVWpfvn54P4mb5JuGygEO5nh/AlFDKCzNKq+5wQZ240iAzUN+nM4a5+gYaMpKy+TU5PMXxwzatacvNeu68iz4cbw9m/Rvz1CAnjyWcsvJjnB+oY2y9vkfHByCyomsciJRTJZggOMNwasGMS7b0vgkQ7P2ZFQp0oPMF7wsLf7+Li6zmnFnHbdA4ss2SffEbKDFvoGkaGtOKshpyeix5dQti/ZJeu5bDS2QsJow9uIh6yi7ZJUSUO174Qckniq8L3ZF0j+rG1w4gzsu3efmg4h0Er+rjgrPcHVRdNaOI9UTmHN8MQoCf1fBC+jFJmbhVNo0XixScA4GjomJmxpXKPECMKQYBjUhwJuUs9vRl6osfGTCBA5KIs6LwQ7ZZ4YH2rz0GxcTNFitDPdJ+Ia+btx6XredVucc54M7Jogjz+ez9gGezBBDOFDTjVw4vqe0YMMsvDRMcGG6VJXGeBTtaadBHh440yAV6Myp4XxutFTS647ciLOvsC6q9iUHGEq8TYsCKhkwrjmyuABCBDe64ej92lam+FIRuB9tqNanWHnQ+0W+A==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM5PR1101MB2218.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a6532835-3b0d-4b25-2121-08d873cd631d
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Oct 2020 01:22:03.9339
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7MIb1Yiyt6l7FX071OYL2zwO2fMa0Jrtm9WHFBbji/PcNis3T+AkU2kKXpP2xfYGHcodsABsWn2QGC/JZY+J3g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB2587
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org



> -----Original Message-----
> From: Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>
> Sent: 16 October 2020 10:51 PM
> To: Sia, Jee Heng <jee.heng.sia@intel.com>
> Cc: andriy.shevchenko@linux.intel.com; dmaengine@vger.kernel.org; linux-
> kernel@vger.kernel.org; vkoul@kernel.org; Alexey Brodkin
> <Alexey.Brodkin@synopsys.com>
> Subject: Re: [PATCH 00/15] dmaengine: dw-axi-dmac: support Intel KeemBay
> AxiDMA
>=20
> Hi Sia,
>=20
> Is this patch series available in some public git repo?
[>>] We do not have public git repo, but the patch series are tested on ker=
nel v5.9
> I want to test it on our HW with DW AXI DMAC.
>=20
> Thanks.
> ---
>  Eugeniy Paltsev
>=20
>=20
> ________________________________________
> From: Sia Jee Heng <jee.heng.sia@intel.com>
> Sent: Monday, October 12, 2020 07:21
> To: vkoul@kernel.org; Eugeniy Paltsev
> Cc: andriy.shevchenko@linux.intel.com; dmaengine@vger.kernel.org; linux-
> kernel@vger.kernel.org
> Subject: [PATCH 00/15] dmaengine: dw-axi-dmac: support Intel KeemBay
> AxiDMA
>=20
> The below patch series are to support AxiDMA running on Intel KeemBay SoC=
.
> The base driver is dw-axi-dmac but code refactoring is needed, for exampl=
e:
> - Support YAML Schemas DT binding.
> - Replacing Linked List with virtual descriptor management.
> - Remove unrelated hw desc stuff from dma memory pool.
> - Manage dma memory pool alloc/destroy based on channel activity.
> - Support dmaengine device_sync() callback.
> - Support dmaengine device_config().
> - Support dmaegnine device_prep_slave_sg().
> - Support dmaengine device_prep_dma_cyclic().
> - Support of_dma_controller_register().
> - Support burst residue granularity.
> - Support Intel KeemBay AxiDMA registers.
> - Support Intel KeemBay AxiDMA device handshake.
> - Support Intel KeemBay AxiDMA BYTE and HALFWORD device operation.
> - Add constraint to Max segment size.
>=20
> This patch set is to replace the patch series submitted at:
> https://urldefense.com/v3/__https://lore.kernel.org/dmaengine/1599213094-
> 30144-1-git-send-email-
> jee.heng.sia@intel.com/__;!!A4F2R9G_pg!Nemc1rSHID2X4d8pr0LNF0nD9Odrn4
> 25GRV8MSTPDvPwE6a3iWPeylAJSaxwqXjfPapMO4U$
>=20
> This patch series are tested on Intel KeemBay platform.
>=20
>=20
> Sia Jee Heng (15):
>   dt-bindings: dma: Add YAML schemas for dw-axi-dmac
>   dmaengine: dw-axi-dmac: simplify descriptor management
>   dmaengine: dw-axi-dmac: move dma_pool_create() to
>     alloc_chan_resources()
>   dmaengine: dw-axi-dmac: Add device_synchronize() callback
>   dmaengine: dw-axi-dmac: Add device_config operation
>   dmaengine: dw-axi-dmac: Support device_prep_slave_sg
>   dmaegine: dw-axi-dmac: Support device_prep_dma_cyclic()
>   dmaengine: dw-axi-dmac: Support of_dma_controller_register()
>   dmaengine: dw-axi-dmac: Support burst residue granularity
>   dmaengine: dw-axi-dmac: Add Intel KeemBay AxiDMA support
>   dt-binding: dma: dw-axi-dmac: Add support for Intel KeemBay AxiDMA
>   dmaengine: dw-axi-dmac: Add Intel KeemBay DMA register fields
>   dmaengine: dw-axi-dmac: Add Intel KeemBay AxiDMA handshake
>   dmaengine: dw-axi-dmac: Add Intel KeemBay AxiDMA BYTE and HALFWORD
>     registers
>   dmaengine: dw-axi-dmac: Set constraint to the Max segment size
>=20
>  .../bindings/dma/snps,dw-axi-dmac.txt         |  39 -
>  .../bindings/dma/snps,dw-axi-dmac.yaml        | 149 ++++
>  .../dma/dw-axi-dmac/dw-axi-dmac-platform.c    | 696 +++++++++++++++---
>  drivers/dma/dw-axi-dmac/dw-axi-dmac.h         |  33 +-
>  4 files changed, 783 insertions(+), 134 deletions(-)  delete mode 100644
> Documentation/devicetree/bindings/dma/snps,dw-axi-dmac.txt
>  create mode 100644 Documentation/devicetree/bindings/dma/snps,dw-axi-
> dmac.yaml
>=20
> --
> 2.18.0

