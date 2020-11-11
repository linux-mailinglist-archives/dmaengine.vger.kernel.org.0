Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4E78B2AE5F7
	for <lists+dmaengine@lfdr.de>; Wed, 11 Nov 2020 02:44:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731899AbgKKBo0 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 10 Nov 2020 20:44:26 -0500
Received: from mga03.intel.com ([134.134.136.65]:52277 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731610AbgKKBoZ (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Tue, 10 Nov 2020 20:44:25 -0500
IronPort-SDR: uDZlgfNU6xVsWX7t/1mOVEfez54Q1hvdAPyfBrhC8FvfuBa66iPzp1DP3Il5WhdS2/TtQrzm9R
 bvNgTsOPX1Qg==
X-IronPort-AV: E=McAfee;i="6000,8403,9801"; a="170188132"
X-IronPort-AV: E=Sophos;i="5.77,468,1596524400"; 
   d="scan'208";a="170188132"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Nov 2020 17:44:24 -0800
IronPort-SDR: J+NGmDx0DDFP2y4z+dMjJ+pjKpUTPk1apVSAnObFU4HqKD31LHi00+bVliW7tbI3hi+xby6/dp
 w2HDKPVQZIEA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,468,1596524400"; 
   d="scan'208";a="308277509"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmsmga008.fm.intel.com with ESMTP; 10 Nov 2020 17:44:24 -0800
Received: from fmsmsx601.amr.corp.intel.com (10.18.126.81) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Tue, 10 Nov 2020 17:44:24 -0800
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5
 via Frontend Transport; Tue, 10 Nov 2020 17:44:24 -0800
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.176)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.1713.5; Tue, 10 Nov 2020 17:44:23 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eOXRKU2CrLwBdH59zchbCQ5guz75JuU+GSGc5JCP70RGeKdmjLloaY3zfwQf40UDFUeKAgb0wpB4vVf9UyJMJkBowJPR6FQJuXaetLitZD2u+5ujldQz/LlvtrifHLulHc1a1mpcaRvEhvYM+grI1lzRPp2wwHkEOfS+puzsHi5vW3IfhahBLmovFaC4iQNRetSkeWyd2ZMRzUfKcpdzw+Ot9mLJDcfAu+KH9UO9EtJUwpJ/noPrc6A66Arct20GU4aANMI2sxvS5aQKoTPZ0MPei1EAAZJXAJ6UzGuN+/0rZTc5742OO3K3QTXyBk+dzr2KSwFqS601CwzReiB2IA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=e5NmVasQPUmAG9eOp/QI0RXnU49mcH98VMSDX5aeXwQ=;
 b=UADSKaKmXpGgRTYrCVfZWW/O9hMWcobwT43bJe3bIpV9cHIeohnouDEeK/CG1sYrZ1EFj+KKhm4jylGbo+hlcYGn9CvpRpbYhuXmbbHpKeWRwZc8NO2u7NoAko2LBJY5tOrAv7xrr9BRBvmB87SReE/B4caiAgX8sdbkUUsx+7Qi4+pl7zTEwsRn+Fnn3elMRMjeN5CXMxtMu2im8RfolvBXHXF4H+ZZRFr/Ov3VMga7kgSkrbDZKGFz+plp928/6T7xnPlf8WCMmN48cauPG6jksBmwyJLkzYIs6JuyzEy3li6ls/p4NSnn9hxTjbhowivLiFIZ8g44d39yd77CHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=e5NmVasQPUmAG9eOp/QI0RXnU49mcH98VMSDX5aeXwQ=;
 b=MNVE6iUA2jJAow51NWsl/BsfhGTGDqEHBpNp4PoNMJYfIHmurHNT1PHtJgqmqzkBtOvWA25R2NDbw8FGdVZnMJi7IuniS1BrBtqOuAaueIr6rjhKk6zRKjlIrgl8RdQMjzMkiomk8MmmDaxPWTjVQX4RDyi46DjytXuoBLgX8V0=
Received: from CO1PR11MB5026.namprd11.prod.outlook.com (2603:10b6:303:9c::13)
 by CO1PR11MB4994.namprd11.prod.outlook.com (2603:10b6:303:91::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3541.21; Wed, 11 Nov
 2020 01:44:23 +0000
Received: from CO1PR11MB5026.namprd11.prod.outlook.com
 ([fe80::40d9:aa4b:73e7:3d60]) by CO1PR11MB5026.namprd11.prod.outlook.com
 ([fe80::40d9:aa4b:73e7:3d60%3]) with mapi id 15.20.3499.032; Wed, 11 Nov 2020
 01:44:23 +0000
From:   "Sia, Jee Heng" <jee.heng.sia@intel.com>
To:     Vinod Koul <vkoul@kernel.org>
CC:     "Eugeniy.Paltsev@synopsys.com" <Eugeniy.Paltsev@synopsys.com>,
        "andriy.shevchenko@linux.intel.com" 
        <andriy.shevchenko@linux.intel.com>,
        "dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v2 09/15] dmaengine: dw-axi-dmac: Support burst residue
 granularity
Thread-Topic: [PATCH v2 09/15] dmaengine: dw-axi-dmac: Support burst residue
 granularity
Thread-Index: AQHWtn3mLZfDhbVLE06A4ls6x2Eq8KnCKx3g
Date:   Wed, 11 Nov 2020 01:44:23 +0000
Message-ID: <CO1PR11MB5026C04E7F8DA29F87268D3CDAE80@CO1PR11MB5026.namprd11.prod.outlook.com>
References: <20201027063858.4877-1-jee.heng.sia@intel.com>
 <20201027063858.4877-10-jee.heng.sia@intel.com>
 <20201109095115.GD3171@vkoul-mobl>
In-Reply-To: <20201109095115.GD3171@vkoul-mobl>
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
x-ms-office365-filtering-correlation-id: 149aa479-fd11-4f15-9cb5-08d885e350d9
x-ms-traffictypediagnostic: CO1PR11MB4994:
x-microsoft-antispam-prvs: <CO1PR11MB49945A2A86F14F0DF6A14670DAE80@CO1PR11MB4994.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: s3kSyyX3P5NS5HwSpLZYW9FBXFZfXyCkcS5bxm0ENJBgixvtaIXmCA5RZrSsvAu4NcYIT23n/f446EScFPHY0b7r5eGwLlbJ1DgMgaIUjeX+PZMYHEuT5+eK6bpfku3Ste9IN+yvd5mmv9euSXKMRJV//Qi/fGaLkkldQFDchZUaNZgudDKnzuLUKIqk+P/wG+pZn7EvF6/bVLGddyCkOOOG9Q8sAGBYS15EueEK0ZdCzI4OPqcVSuFzT+cD57Lzbsq5CwU6t23lLCP5hrcgBIzSAhQCv+VkC2WoesASu1P6DuKYVh9cLJYdmD8SFEaBVSfd8rre54k26iTespD3vg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5026.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(376002)(39860400002)(136003)(396003)(346002)(33656002)(478600001)(52536014)(83380400001)(7696005)(71200400001)(2906002)(186003)(8676002)(26005)(6506007)(53546011)(8936002)(64756008)(66556008)(66476007)(66446008)(4326008)(5660300002)(9686003)(66946007)(86362001)(316002)(55016002)(54906003)(76116006)(6916009);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: +dFRSxVzE6AL2QqCaO6tbCRZs49UdFfh5s27yiQfMP4pGGGdUDu27cWbxDToRNXXEx9VfROEA9ebCbEmrs1F6YY7f+lCmxFQDQj+FkpZpqw+Xci3L5S45uZKgEKM1SBw5IHVlfiEKLRJnYVhtbgexErR9OTNP4FRD8t7h7y9SXdZUCg+/SJABz3a5qGaA+mhYDp9je8elnVrL3qP4/xB9VJnREbdNDGhCKHgptmNS9i4HxqR5zdREFht/eSNv7QIST0wTJr+ro7anO23M1vn60TOUiwD40IqoSpw1ckbRi8OMrfWY1kOAFfgelZXtTMUZ2J8P1UneNTLo0xMBr+9+M5hvOUmEtNhltlqfIRPE/lf+FT4048u1YRde490+GqCFmO9ED6IJTALSd+7hMWOWc+nIii8JnZUiHv2Y2X0sTMrgt+MQo4U2rAfA0KjRAeeiKR0JWT6Q/FQ0iHOuRRzm83TdH7+1ZNellGQ6g7dnWM4g9KwdXmRe6xiSm5RVDT6udy0zqbUp+RF4hHUQBmHnU9uyHxns0o9OlL9upKdEzjvl9os/zXc4SZZCgrxBMMUbbDnYESAZmZheANCoqnVQ+ZWfEiPykSv3nbHmCjh7x/Mww3ZbNT8LGYh0GU3mGEm7klETJw69pmhWP348kPfvg==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5026.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 149aa479-fd11-4f15-9cb5-08d885e350d9
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Nov 2020 01:44:23.2139
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0jBkcMaf9PS1A8hz3y9UbPS2vGN6536f1LHpWcRfn4z3loPRk0LNq5EIB8SItn9qiVtqGXzk0wmGSK2Tay3P/Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB4994
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org



> -----Original Message-----
> From: Vinod Koul <vkoul@kernel.org>
> Sent: 09 November 2020 5:51 PM
> To: Sia, Jee Heng <jee.heng.sia@intel.com>
> Cc: Eugeniy.Paltsev@synopsys.com; andriy.shevchenko@linux.intel.com;
> dmaengine@vger.kernel.org; linux-kernel@vger.kernel.org
> Subject: Re: [PATCH v2 09/15] dmaengine: dw-axi-dmac: Support burst resid=
ue
> granularity
>=20
> On 27-10-20, 14:38, Sia Jee Heng wrote:
> > Add support for DMA_RESIDUE_GRANULARITY_BURST so that AxiDMA can
> > report DMA residue.
> >
> > Existing AxiDMA driver only support data transfer between memory to
> > memory operation, therefore reporting DMA residue to the DMA clients
> > is not supported.
> >
> > Reporting DMA residue to the DMA clients is important as DMA clients
> > shall invoke dmaengine_tx_status() to understand the number of bytes
> > been transferred so that the buffer pointer can be updated accordingly.
> >
> > Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> > Signed-off-by: Sia Jee Heng <jee.heng.sia@intel.com>
> > ---
> >  .../dma/dw-axi-dmac/dw-axi-dmac-platform.c    | 44 ++++++++++++++++---
> >  drivers/dma/dw-axi-dmac/dw-axi-dmac.h         |  2 +
> >  2 files changed, 39 insertions(+), 7 deletions(-)
> >
> > diff --git a/drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c
> > b/drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c
> > index 011cf7134f25..cd99557a716c 100644
> > --- a/drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c
> > +++ b/drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c
> > @@ -265,14 +265,36 @@ dma_chan_tx_status(struct dma_chan *dchan,
> dma_cookie_t cookie,
> >  		  struct dma_tx_state *txstate)
> >  {
> >  	struct axi_dma_chan *chan =3D dchan_to_axi_dma_chan(dchan);
> > -	enum dma_status ret;
> > +	struct virt_dma_desc *vdesc;
> > +	enum dma_status status;
> > +	u32 completed_length;
> > +	unsigned long flags;
> > +	u32 completed_blocks;
> > +	size_t bytes =3D 0;
> > +	u32 length;
> > +	u32 len;
> >
> > -	ret =3D dma_cookie_status(dchan, cookie, txstate);
> > +	status =3D dma_cookie_status(dchan, cookie, txstate);
>=20
> txstate can be null, so please check that as well in the below condition =
and
> return if that is the case
[>>] noted. Will factor in the null condition check in v3
>=20
> --
> ~Vinod
