Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3178428C85B
	for <lists+dmaengine@lfdr.de>; Tue, 13 Oct 2020 07:49:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732519AbgJMFte (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 13 Oct 2020 01:49:34 -0400
Received: from mga01.intel.com ([192.55.52.88]:27518 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732494AbgJMFte (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Tue, 13 Oct 2020 01:49:34 -0400
IronPort-SDR: vMW+NIPUXyP+ePHXHnQ4krSNuHYpl30QEhtU3y6LwDTvjBY7GA/KZF/d459ohUpxWfbcX8bUxC
 ca1KgEUKqJzQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9772"; a="183329204"
X-IronPort-AV: E=Sophos;i="5.77,369,1596524400"; 
   d="scan'208";a="183329204"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Oct 2020 22:49:34 -0700
IronPort-SDR: Ygd31HGsTZ+kiALbtzWTwKBF22hEE9po2i1uy63oiJC1rNpX2svmtmPbZiWBukGjnWZoj6Nsbn
 QY0+9TCVZ+Sw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,369,1596524400"; 
   d="scan'208";a="390166774"
Received: from orsmsx606.amr.corp.intel.com ([10.22.229.19])
  by orsmga001.jf.intel.com with ESMTP; 12 Oct 2020 22:49:33 -0700
Received: from orsmsx608.amr.corp.intel.com (10.22.229.21) by
 ORSMSX606.amr.corp.intel.com (10.22.229.19) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Mon, 12 Oct 2020 22:49:33 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx608.amr.corp.intel.com (10.22.229.21) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5
 via Frontend Transport; Mon, 12 Oct 2020 22:49:33 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.44) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.1713.5; Mon, 12 Oct 2020 22:49:33 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hEJFRMSRGPFLgSqhoLiEmduBziFP8eW/NZG2kzccQXfciKsoJOx9j3G55eZ23fAjpQf3btmZD18BrB+IuoWTOYyPbdClWiO6zu1jAjJz4qwoBzXz/vprZP0m3PItugCJ0MXJGkko8OEApPj7366URBg2qA7ZAQQihoJ8WSZSBXZhgNNzW78oGuD50cQwYpOUowg8xmy4uw1KACLlIdXlLeCYT77VMNky0aWyCwQQHubpEticbfkpeONOfvnvvOtGxA/59plMQzoCym/fLJSSoKL7/psrLYi7hPOVuPoX/tJg8udz7jiA4Gjy8i75O1Ab4DH87YyKIR43hcEaubRsig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=elqlAV5k8mqPf0USBpo5M8ab4k2ZpEin3dD2helFfBs=;
 b=IVf/Q9v6v3Q+ePQIyJQ1X/rl1KH+UnwUyhH4rJNRhQUk2k1H0SWBeOahRffeSLJAvPZaXerfcvkcA8UusQYtjwxZ8A1g7Gt6bk/JnWK853CPJ8jifqOH9me1fmsBj80h6SfNC48yr3UcERU5V470kFsbW/BLSRDqGLKs9RHo6IpBaBxLQXQRXNEXOjGeGl1cvScy/N0/n73E7fR53WZKehW2HVGX4+JR/TM8QM0fLc/MdqQdtXaB0PWM3mpcmUoKHRECYH1qa4+1flzCjSze0l9RQO+C11LbwYZN46U2Lq8U+FBTaYrjVyQ1efobQKYWwcDKtTBlbn6aFu8x8OZnXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=elqlAV5k8mqPf0USBpo5M8ab4k2ZpEin3dD2helFfBs=;
 b=W6Trtw3dRTT0rCyPRkQy/2XIcM7kLkvj7XDrHGzhv452ovg7W3UkNQecll7dwGYaK9RBVy88VNPTToQXaiwr41sUW5mLv7AwQNVCmpue/k9RtMWtsU1HxqMv4Mhz0Sfymc+MiFZAocpvuupBjRjLnvzXE+UMa+KhvQBdcrOwlbI=
Received: from BL0PR11MB3362.namprd11.prod.outlook.com (2603:10b6:208:61::29)
 by BL0PR11MB3249.namprd11.prod.outlook.com (2603:10b6:208:6b::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3455.27; Tue, 13 Oct
 2020 05:49:32 +0000
Received: from BL0PR11MB3362.namprd11.prod.outlook.com
 ([fe80::3d7f:2b02:b856:9604]) by BL0PR11MB3362.namprd11.prod.outlook.com
 ([fe80::3d7f:2b02:b856:9604%7]) with mapi id 15.20.3455.030; Tue, 13 Oct 2020
 05:49:32 +0000
From:   "Sia, Jee Heng" <jee.heng.sia@intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
CC:     "vkoul@kernel.org" <vkoul@kernel.org>,
        "Eugeniy.Paltsev@synopsys.com" <Eugeniy.Paltsev@synopsys.com>,
        "dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 00/15] dmaengine: dw-axi-dmac: support Intel KeemBay
 AxiDMA
Thread-Topic: [PATCH 00/15] dmaengine: dw-axi-dmac: support Intel KeemBay
 AxiDMA
Thread-Index: AQHWoJ+64R/NJ+ZUxUWa9ym9koIG+6mVB4mg
Date:   Tue, 13 Oct 2020 05:49:32 +0000
Message-ID: <BL0PR11MB3362A202A1D3BDC8C1CA41DBDA040@BL0PR11MB3362.namprd11.prod.outlook.com>
References: <20201012042200.29787-1-jee.heng.sia@intel.com>
 <20201012135905.GX4077@smile.fi.intel.com>
In-Reply-To: <20201012135905.GX4077@smile.fi.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-reaction: no-action
dlp-version: 11.5.1.3
authentication-results: linux.intel.com; dkim=none (message not signed)
 header.d=none;linux.intel.com; dmarc=none action=none header.from=intel.com;
x-originating-ip: [60.52.88.216]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 9af41afe-e0ad-4ee6-3ee4-08d86f3bc228
x-ms-traffictypediagnostic: BL0PR11MB3249:
x-microsoft-antispam-prvs: <BL0PR11MB3249B6B96EC5EE219FD38DC1DA040@BL0PR11MB3249.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: qrTBwFM7bw0LNcHyIbJ0vxyfgwrI16SVbvGkzXoqWCjSpC8B+X5/R0XLSSkfUSWLlwR6D3iE4QeNl28oDu5f6siYjV6ZYOS1toQBUVl7ointUsrnacg06MKGZ/buKBrRPjQ/0EmYkkO3BSVhu5NMHSMfgU/EDSpU0wXIsrFZXZI2NH9IIMU1bO/OkagWxd+TLCFGJZ++HypEy8IKqH1rlqBzSM3e0JxfnbXPycLciidnGC+tRxFqJ1NHMXZjMGO7oRErHOEDEr5rryWyG7SUM0lt7a4mDeoUQMC14NKXU/rHSqbDD71+3l7b/rkroyQ7dYRmyDhR4MWtPB++h6Orok2yFBa21PgKq7opsWM1QWgOhRkYecOoJEtzdDITbx+zVVABOukv+nCeTGxqZMn5Mw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR11MB3362.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(376002)(39860400002)(136003)(366004)(396003)(966005)(186003)(26005)(316002)(54906003)(8676002)(9686003)(6916009)(8936002)(4326008)(2906002)(53546011)(55016002)(7696005)(478600001)(55236004)(6506007)(86362001)(83080400001)(71200400001)(83380400001)(66946007)(76116006)(52536014)(66476007)(64756008)(66556008)(66446008)(5660300002)(33656002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: 7s9K1d+Sdbku9D3CtlCwPg5oGWs32OVpEsC7qNC8HfYOwtVYAeWD3cqoWfeS2EEHaFsxlxyCU0+3myM//TMnxkFTgKOWCSF/AEJkmIKmc5cDrZOSsNo5ve9oceg0wa277xMBBQhbc8RlHHiUjzJSn5nbupCW3KZXpQK2KOxi5WqK1PAVkV+D7YfolM/ZADC9n4FWExBaDQE6/Gg1Ksbozki5NW4/GoRKyUT8p5QfQBSgMproqLKG6dRFc0VU5SLdPe9xe6ZQwmOuTwGOs8TYYw2F7NVb6dQLfl8UTM9rqDtz+SXqM2ywxW7JIQsog7K0hhe/aC6fmjLyFG4dkiYP/z2cQLQ1nzHi+U8KHk1XOsmEA8jvD5cUp5EuAduLFk4aPNaztcnAuHoIULDnpiycHuMWzlbXBcxwX//dDwrZvyknUsbxYJ3rQWAlh4Vh6qYuU1JBf0/JJeAl3Xl5dCzzs9l9jXXfLgcdxHdwiCvbFVNC3Ys0uN+B9LDpBh2f3FVkrO74X0tXRIP81SPfDbqHL0X1mKUKxoH+JphAVzFPSrPrSZ2KM7OPjDhDn5HtecnZY1lxwN/ur4fr4v67AG6Ns8RpbjXy0a7fyNfVkFq+fvNKun9Q2Hhz3yHEfdAwxzlSZ1M7gcRIhXVPWWXxRrGX+A==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL0PR11MB3362.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9af41afe-e0ad-4ee6-3ee4-08d86f3bc228
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Oct 2020 05:49:32.3456
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: K3Jr6Hk9sD5kt3UUO3Cqnwt05SLF4Dv8FCVf0dkiCVqcM+QUJP5/J+jeaKVPT+IxvxItzO2V6bdrlrqmciHLoA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR11MB3249
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org



> -----Original Message-----
> From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Sent: 12 October 2020 9:59 PM
> To: Sia, Jee Heng <jee.heng.sia@intel.com>
> Cc: vkoul@kernel.org; Eugeniy.Paltsev@synopsys.com;
> dmaengine@vger.kernel.org; linux-kernel@vger.kernel.org
> Subject: Re: [PATCH 00/15] dmaengine: dw-axi-dmac: support Intel KeemBay
> AxiDMA
>=20
> On Mon, Oct 12, 2020 at 12:21:45PM +0800, Sia Jee Heng wrote:
> > The below patch series are to support AxiDMA running on Intel KeemBay S=
oC.
> > The base driver is dw-axi-dmac but code refactoring is needed, for exam=
ple:
> > - Support YAML Schemas DT binding.
> > - Replacing Linked List with virtual descriptor management.
> > - Remove unrelated hw desc stuff from dma memory pool.
> > - Manage dma memory pool alloc/destroy based on channel activity.
> > - Support dmaengine device_sync() callback.
> > - Support dmaengine device_config().
> > - Support dmaegnine device_prep_slave_sg().
> > - Support dmaengine device_prep_dma_cyclic().
> > - Support of_dma_controller_register().
> > - Support burst residue granularity.
> > - Support Intel KeemBay AxiDMA registers.
> > - Support Intel KeemBay AxiDMA device handshake.
> > - Support Intel KeemBay AxiDMA BYTE and HALFWORD device operation.
> > - Add constraint to Max segment size.
> >
> > This patch set is to replace the patch series submitted at:
> > https://lore.kernel.org/dmaengine/1599213094-30144-1-git-send-email-je
> > e.heng.sia@intel.com/
>=20
> And it means effectively the bumped version, besides the fact that you do=
uble
> sent this one...
>=20
>=20
> Please fix and resend. Note, now is merge window is open. Depends on
> maintainer's flow it may be good or bad time to resend with properly form=
ed
> changelog and version of the series.
[>>] Thanks. Will resend the patch set with v1 in the header.
>=20
> > This patch series are tested on Intel KeemBay platform.
> >
> >
> > Sia Jee Heng (15):
> >   dt-bindings: dma: Add YAML schemas for dw-axi-dmac
> >   dmaengine: dw-axi-dmac: simplify descriptor management
> >   dmaengine: dw-axi-dmac: move dma_pool_create() to
> >     alloc_chan_resources()
> >   dmaengine: dw-axi-dmac: Add device_synchronize() callback
> >   dmaengine: dw-axi-dmac: Add device_config operation
> >   dmaengine: dw-axi-dmac: Support device_prep_slave_sg
> >   dmaegine: dw-axi-dmac: Support device_prep_dma_cyclic()
> >   dmaengine: dw-axi-dmac: Support of_dma_controller_register()
> >   dmaengine: dw-axi-dmac: Support burst residue granularity
> >   dmaengine: dw-axi-dmac: Add Intel KeemBay AxiDMA support
> >   dt-binding: dma: dw-axi-dmac: Add support for Intel KeemBay AxiDMA
> >   dmaengine: dw-axi-dmac: Add Intel KeemBay DMA register fields
> >   dmaengine: dw-axi-dmac: Add Intel KeemBay AxiDMA handshake
> >   dmaengine: dw-axi-dmac: Add Intel KeemBay AxiDMA BYTE and HALFWORD
> >     registers
> >   dmaengine: dw-axi-dmac: Set constraint to the Max segment size
> >
> >  .../bindings/dma/snps,dw-axi-dmac.txt         |  39 -
> >  .../bindings/dma/snps,dw-axi-dmac.yaml        | 149 ++++
> >  .../dma/dw-axi-dmac/dw-axi-dmac-platform.c    | 696 +++++++++++++++---
> >  drivers/dma/dw-axi-dmac/dw-axi-dmac.h         |  33 +-
> >  4 files changed, 783 insertions(+), 134 deletions(-)  delete mode
> > 100644 Documentation/devicetree/bindings/dma/snps,dw-axi-dmac.txt
> >  create mode 100644
> > Documentation/devicetree/bindings/dma/snps,dw-axi-dmac.yaml
> >
> > --
> > 2.18.0
> >
>=20
> --
> With Best Regards,
> Andy Shevchenko
>=20

