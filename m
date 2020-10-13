Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6A08028C8FE
	for <lists+dmaengine@lfdr.de>; Tue, 13 Oct 2020 09:12:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732594AbgJMHMy (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 13 Oct 2020 03:12:54 -0400
Received: from mga02.intel.com ([134.134.136.20]:53730 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730003AbgJMHMy (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Tue, 13 Oct 2020 03:12:54 -0400
IronPort-SDR: iX4bKxRi933sm5nmt34wSWaNU4XypseFIcKYz0oY2SfoM3ke7g+vM6fd4c35vILP5tGy058aah
 dx52KmOFxlNQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9772"; a="152795404"
X-IronPort-AV: E=Sophos;i="5.77,369,1596524400"; 
   d="scan'208";a="152795404"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Oct 2020 00:12:53 -0700
IronPort-SDR: V++T+H87DzyE7l5RWZ7RPwnlxXgDxtfXMZff7JGw6gCRkBNoMpgJHD1KGjtCr5+6gudDePt7TS
 XMqO0iHCR/TQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,369,1596524400"; 
   d="scan'208";a="313707538"
Received: from orsmsx605.amr.corp.intel.com ([10.22.229.18])
  by orsmga003.jf.intel.com with ESMTP; 13 Oct 2020 00:12:53 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX605.amr.corp.intel.com (10.22.229.18) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Tue, 13 Oct 2020 00:12:53 -0700
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Tue, 13 Oct 2020 00:12:52 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5
 via Frontend Transport; Tue, 13 Oct 2020 00:12:52 -0700
Received: from NAM04-BN3-obe.outbound.protection.outlook.com (104.47.46.59) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.1713.5; Tue, 13 Oct 2020 00:12:51 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Mba83CodkttTTlNk1rztqICeatipbOplF3cBbgEjxBdE53juUVykmhQBO3kIUfh/BX2aVSSiGL6//uTGbIKbVt525HA0W7eRUs6+/ZDcOHYd/35XdtYc39kQLbtSP7HEuCKVoJlM4jkCgaaFnrlhbRlP8lMaeqsXqDwPx9eqn9fz+byY8aMpzt6dic3McQd6RLr+QJr6rGR8vPI9mHiAbFKN1QSL5HpFhHSN8EddjNX5ygO/LxR5yIRCNt7lOeYvWA5I4jrCmcsnOvSwCCngj01sVEMjqn9fMoFUVcNtUmv2TWLZlIR8YhGQUjmanDKuZJsMq7T+2AX5uH0Y5MYigA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=L9DmnUj/CJ5Lnd13zlJlk+CsDtvKU7m6SzcmuhPjX/s=;
 b=K7YYtYz2e2fzr9OiknO/WS2XeVveaN2QRdVV2wQamLuzfZiSVmre74CJIEzbfd/6gWr3zMAmyQuA51/vF9O69vopDCVE2OZKMi7Pw5jRwZqVBss6sm3qIsnsvYgxgRKKbVR1KeQDBbt1CC7f42HIknHC77Inqf0PpGfu0aqTTKRD0QJEMPIb01Z3yyvhfVaQEQCgl7C4msbZHVCmB82pu4CQCR/jH/zH1eZfEdqymQ2idGtIJXXlIun3zMDBGIguNqnkl9EiljwWapT0DP9LwYzYqNS2YNaiGZRtaz+/pXtLnX2wV3Vy+ES7E9m0mrH2P1zuSPe8nPRsA3iMrO/2xQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=L9DmnUj/CJ5Lnd13zlJlk+CsDtvKU7m6SzcmuhPjX/s=;
 b=Q3WUawtROYxLRopaCJcnJAu4JfdW79gzNvDzz1Rvh3jLdIbwlGjGhi1Zje5fpLWpAnozljFi9m3wdlFSHTCufTjJZ2auz+0Q/fmnvaSDykRR9VVMDQaAcinwTPLXk9hKqBeavOdbhYv+hbOwvBnL9mRg2n1e5bYAAzUK4yugqRQ=
Received: from BL0PR11MB3362.namprd11.prod.outlook.com (2603:10b6:208:61::29)
 by BL0PR11MB3105.namprd11.prod.outlook.com (2603:10b6:208:33::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3455.22; Tue, 13 Oct
 2020 07:12:50 +0000
Received: from BL0PR11MB3362.namprd11.prod.outlook.com
 ([fe80::3d7f:2b02:b856:9604]) by BL0PR11MB3362.namprd11.prod.outlook.com
 ([fe80::3d7f:2b02:b856:9604%7]) with mapi id 15.20.3455.030; Tue, 13 Oct 2020
 07:12:50 +0000
From:   "Sia, Jee Heng" <jee.heng.sia@intel.com>
To:     Vinod Koul <vkoul@kernel.org>
CC:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        "Eugeniy.Paltsev@synopsys.com" <Eugeniy.Paltsev@synopsys.com>,
        "dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 00/15] dmaengine: dw-axi-dmac: support Intel KeemBay
 AxiDMA
Thread-Topic: [PATCH 00/15] dmaengine: dw-axi-dmac: support Intel KeemBay
 AxiDMA
Thread-Index: AQHWoJ+64R/NJ+ZUxUWa9ym9koIG+6mVB4mggAAUgwCAAAIbsA==
Date:   Tue, 13 Oct 2020 07:12:50 +0000
Message-ID: <BL0PR11MB336251229FB2A626D7178DB8DA040@BL0PR11MB3362.namprd11.prod.outlook.com>
References: <20201012042200.29787-1-jee.heng.sia@intel.com>
 <20201012135905.GX4077@smile.fi.intel.com>
 <BL0PR11MB3362A202A1D3BDC8C1CA41DBDA040@BL0PR11MB3362.namprd11.prod.outlook.com>
 <20201013070118.GN2968@vkoul-mobl>
In-Reply-To: <20201013070118.GN2968@vkoul-mobl>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-reaction: no-action
dlp-version: 11.5.1.3
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=intel.com;
x-originating-ip: [60.52.88.216]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a778c983-e956-492c-03d3-08d86f47655e
x-ms-traffictypediagnostic: BL0PR11MB3105:
x-microsoft-antispam-prvs: <BL0PR11MB3105F84F427502D808AF0145DA040@BL0PR11MB3105.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ITiONftLNAZo2puSKDQs4JrL9s/tJk87izvcrpXB4wDCb2MeUxQfi6mH2SDo2YEkT14FCq2uc5MvVf/pk6lj/eF/vFucJ6YI5OK7J4c3HVf3nOhTj/MY3Sji56Z74Xdyqn47MTEmpiuYU3VvrIvgTVV9OeDXB4O9aRsapQdAB+jYPMF1OMEsNbl7q8RBRzLNItDA7OcqPzQlz1FAIjL/WIxU3qf6G6No8z1/9bBBufRQN2OhkHtVNvrpEuiwA9H/qXnlJj+sa3mQHDJC4u9RisEj52Gx34Ymfih5EHWS/xB60iPgqHUt4J+z9ZrN3yqwRpPk2ho29GCj68WpgFmJPfW9/Piyn6/O4VLWG8ytNaZyt3knzQwu4u3H/vCNj1Ujg6vjls5RIJ6jAHhx+c3fjQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR11MB3362.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(39860400002)(396003)(136003)(346002)(366004)(2906002)(8676002)(76116006)(64756008)(66446008)(66556008)(66476007)(66946007)(6916009)(83380400001)(186003)(9686003)(8936002)(33656002)(53546011)(6506007)(55236004)(54906003)(316002)(5660300002)(71200400001)(83080400001)(55016002)(478600001)(86362001)(52536014)(7696005)(26005)(966005)(4326008);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: 69cVJ1ibsL70Lj3oTZqAbfRLI7HPoI7Mc8YTYWI1crm/BfWLu4X1KAzPav+2ZG8arare/FfWjTiAoS4DK8DQAx/NlvuCVQvnMg2oEr8LpSgNyd7dUSys6iYFsJ0mbNdta/+JfPXqMgv2HVS5H/wrF0ddF73JsOBgQVD3HAExx2eCHm5yQ1MEYcCfWZRflBMBhk19LGnbdatnqzp2uQgLtz4C3Xhgtgwxp+Y9bQVaPDGt/59Yb2OLJMvqf9NAR2kvyeymEIl/DkpcJfdhJaPT/htQq7yQ5+Bf9Pk+XsJL16zWcvuyx1Y6ZHrMZyJw5Ktnd/zTdIjIytRjIQ6LVIrglqezXzawTu0WfHznNZWim++HzAcSEbxOEv89t705KYpSrBDYlxmyMF31VgwQvDdillIyXvvNfINhv8PpgpuKmV/gKs2va7z8+RWeUSbi9eKg4y29zo7pV7retET9sCJS2lK425egP2OOr5V4jjkut0vZcolY0Phe2nV30fgTj4X4yovqc7JUH0q5jTnPL0n1V66EQY/XoMgIGyR12bAaiCzzqwJjtbb62fvj10spxkKhWI7UBcXnL7hrPf+rHgUm1NdBBv/dvaoVMojoNQ6BS+UJq6V0qcC1FfTDMvdohmVBS8Ppf1bReyUWykKJOVCExg==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL0PR11MB3362.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a778c983-e956-492c-03d3-08d86f47655e
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Oct 2020 07:12:50.4987
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9xfT2l65pEHw/JNxbfQv73YY+b9GhDxYtFrZ7vbNZPyoLge/KZMxafJ2WoRzpsUWfXHuf2wwOyr2DkUvTDVfrA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR11MB3105
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org



> -----Original Message-----
> From: Vinod Koul <vkoul@kernel.org>
> Sent: 13 October 2020 3:01 PM
> To: Sia, Jee Heng <jee.heng.sia@intel.com>
> Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>;
> Eugeniy.Paltsev@synopsys.com; dmaengine@vger.kernel.org; linux-
> kernel@vger.kernel.org
> Subject: Re: [PATCH 00/15] dmaengine: dw-axi-dmac: support Intel KeemBay
> AxiDMA
>=20
> On 13-10-20, 05:49, Sia, Jee Heng wrote:
> > > >
> > > > This patch set is to replace the patch series submitted at:
> > > > https://lore.kernel.org/dmaengine/1599213094-30144-1-git-send-emai
> > > > l-je
> > > > e.heng.sia@intel.com/
> > >
> > > And it means effectively the bumped version, besides the fact that
> > > you double sent this one...
> > >
> > >
> > > Please fix and resend. Note, now is merge window is open. Depends on
> > > maintainer's flow it may be good or bad time to resend with properly
> > > formed changelog and version of the series.
>=20
> yeah sorry I wont look at it till merge window closes
[>>] Sorry.
>=20
> > [>>] Thanks. Will resend the patch set with v1 in the header.
>=20
> Should this be v1, v1 was the first post, this would be v2!
>=20
[>>] Thanks for the correction. I meant v2.
> Please use git format-patch -v2 to autogenerate version headers in patche=
s..
>=20
> I thought Intel folks had internal review list to take care of these thin=
gs, is it no
> longer used..?
[>>] We are, but I am confuse on what should I do to the existing patch set=
 sent in=20
https://lore.kernel.org/dmaengine/1599213094-30144-1-git-send-email-jee.hen=
g.sia@intel.com/. There is no response from anyone.
>=20
> --
> ~Vinod
