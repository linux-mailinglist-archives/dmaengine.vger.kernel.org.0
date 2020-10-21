Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EED6D29465D
	for <lists+dmaengine@lfdr.de>; Wed, 21 Oct 2020 03:54:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405040AbgJUBya (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 20 Oct 2020 21:54:30 -0400
Received: from mga18.intel.com ([134.134.136.126]:25772 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2393577AbgJUBy3 (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Tue, 20 Oct 2020 21:54:29 -0400
IronPort-SDR: jk+pfnkSEZUlAyty8mbFpTH5XAkzwo0OWVFQkm6w+HU+WES4UXqU4Kx5qLAwvManxQx61B/IvX
 KQfW4fn39cwQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9780"; a="155087768"
X-IronPort-AV: E=Sophos;i="5.77,399,1596524400"; 
   d="scan'208";a="155087768"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Oct 2020 18:54:27 -0700
IronPort-SDR: jzO2Hn1HUeoyHTzBN/rMrFgevmxW87SiTCKzGls9MNlYUFE3IACGmZaZX6xgfBALbZ95+4H0G1
 y4lHVkSWApCg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,399,1596524400"; 
   d="scan'208";a="348108496"
Received: from orsmsx604.amr.corp.intel.com ([10.22.229.17])
  by fmsmga004.fm.intel.com with ESMTP; 20 Oct 2020 18:54:27 -0700
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX604.amr.corp.intel.com (10.22.229.17) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Tue, 20 Oct 2020 18:54:27 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5
 via Frontend Transport; Tue, 20 Oct 2020 18:54:27 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.106)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.1713.5; Tue, 20 Oct 2020 18:54:27 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FXi4zh1TE3yH2jP/NNpM9JwrlhKXPRPIyiMZxqc2AeZdKqR5PbyGIf/6QJ/avM0iNCOPjdRrNt8ZKB1HA1Q1Q8HSEU+ZepIxSDeNL/rjcopF19XA4Q/hX+wLz4eusdVUe6BOSUK19ShYChN2gXikoFnh2xVBRi8j21k+MdJiXPdj3QQM6783XmgY/FS2pSR0eUplSYnXqxuazxBMUjJs4IRwT3S2SXXYj80O0QA8JzXzYOzJQKvp7YRzgi2mnwDeEWSB50ziTtp3Flz9/jYWuDJeZ14VCYpNPrXNhabkf9dZiyiDbq8r0E8bXsqUkr4iLQAIMs55OabounDMzB/W3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7onvSJlM++lXFHjWEUXIaano53MSHTShnZLwE1aP43c=;
 b=YlRgbo5HXLtz/st3a9ff/hYQzlMrvOn2DjG2LOcPsA43Cf43pnBtyxITL8d4oK5peHapzx82XrD4eu4PyZvpktOPVFPEguacJHMaKMOwDGA8FeBl5o9aLs+nfSuIDGqwG7eV4stJcPs1MiVfHnKrkDedNRgNdDwNbatrldoCzwBmWDPCo86+i8pHh+5aHlO2B4ano7VuaVR/S+F+gLUTUiX+BV7WoSC/rv4ek5Q+e9DtuSvlSUUM9aWy5i9CeuLxIOWzYYnFIiwr6Y2pUCqpTcOid4wxz0AcOvi/pm3gpTfhU7tAjaQd8Id+on845leOEmOLt3duAj59dkp79o37Aw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7onvSJlM++lXFHjWEUXIaano53MSHTShnZLwE1aP43c=;
 b=Or8wiG/0khQYivp29UnoD5ph66zh4x725nZcmrgOnhxE50K7Yy43eTw0THZj0NXYXx7IcTj1KQMxTKIx08yqFhJz7+6StST3/UKLUc8YWeeKj3NfTWWxfSD5TQN4oDWi36JggpyOiZQcI8diJf26rV+QHv6I16kQ+vGWahxPob0=
Received: from DM5PR1101MB2218.namprd11.prod.outlook.com (2603:10b6:4:4f::12)
 by DM6PR11MB3164.namprd11.prod.outlook.com (2603:10b6:5:58::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.18; Wed, 21 Oct
 2020 01:54:26 +0000
Received: from DM5PR1101MB2218.namprd11.prod.outlook.com
 ([fe80::49ce:b38c:2ee:128f]) by DM5PR1101MB2218.namprd11.prod.outlook.com
 ([fe80::49ce:b38c:2ee:128f%10]) with mapi id 15.20.3477.028; Wed, 21 Oct 2020
 01:54:26 +0000
From:   "Sia, Jee Heng" <jee.heng.sia@intel.com>
To:     "andriy.shevchenko@linux.intel.com" 
        <andriy.shevchenko@linux.intel.com>
CC:     Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>,
        "dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "vkoul@kernel.org" <vkoul@kernel.org>,
        Alexey Brodkin <Alexey.Brodkin@synopsys.com>
Subject: RE: [PATCH 00/15] dmaengine: dw-axi-dmac: support Intel KeemBay
 AxiDMA
Thread-Topic: [PATCH 00/15] dmaengine: dw-axi-dmac: support Intel KeemBay
 AxiDMA
Thread-Index: AQHWo8vT4R/NJ+ZUxUWa9ym9koIG+6meI5ZQgACtxoCAAoCPgA==
Date:   Wed, 21 Oct 2020 01:54:25 +0000
Message-ID: <DM5PR1101MB2218BD33F1310EC42F3ED871DA1C0@DM5PR1101MB2218.namprd11.prod.outlook.com>
References: <20201012042200.29787-1-jee.heng.sia@intel.com>
 <MWHPR12MB18065E87CEE3FD28868EBB9BDE030@MWHPR12MB1806.namprd12.prod.outlook.com>
 <DM5PR1101MB22185FFAE24516B90B13D255DA1E0@DM5PR1101MB2218.namprd11.prod.outlook.com>
 <20201019113917.GM4077@smile.fi.intel.com>
In-Reply-To: <20201019113917.GM4077@smile.fi.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-reaction: no-action
dlp-version: 11.5.1.3
authentication-results: linux.intel.com; dkim=none (message not signed)
 header.d=none;linux.intel.com; dmarc=none action=none header.from=intel.com;
x-originating-ip: [210.186.89.31]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 64bed84a-82af-4dd6-50f2-08d875643d6b
x-ms-traffictypediagnostic: DM6PR11MB3164:
x-microsoft-antispam-prvs: <DM6PR11MB31646D5229B1D547B2DC1D73DA1C0@DM6PR11MB3164.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6108;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: TtFhHqckqntn+DO9ZsedNUVJXgaEJgCjTfmW12OiF+VJ3s3D+6h2OXsZ+r3gbSDcr/tpxTE5G0WAj/2AfMaplp+6KXR6q0apRvHdJM0VUISbWONOwjKkW/7GxCo6bVRMF43JBOK2ZeBZqkejIfugQVYRQrBEkq16fP+6bsrdzAWhZyHHRBoYTUI0yWzc9xi+r7nHIp11sVvGw3XhwabiM2fL8O95mq2jRVLbSI+z4sZRE6cLAcT+zTMoAkFu7zPSkxo82GqU6OIqhtl7JZ1X3sCUh+vwgVHnmWFyB1vMr3eE/oupZ+959OO+LfPYm9qa6J0LUyURXHvc/05FKrNLzknTs8odFsCZ7fKSPdIvKHrQrQylvyMbm4eGaMKnqRpQcEou7cN2qVXKTvjJngXJaw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR1101MB2218.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(376002)(366004)(39860400002)(396003)(136003)(64756008)(66946007)(66556008)(76116006)(54906003)(66476007)(52536014)(5660300002)(86362001)(55016002)(6916009)(316002)(4326008)(478600001)(66446008)(186003)(83380400001)(966005)(9686003)(8936002)(33656002)(6506007)(53546011)(8676002)(7696005)(71200400001)(2906002)(26005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: oFsuGBhhADpLG3Pnb6hSVClq1/+4QwHIOdQQA/o72ewf3OKR6pGsnNUDlYvCEJWP/k2MHQRmH5uNsnjiEjVv4t3gjFTZeiXyxq7PcFw5YCcvdJc40LHlw/D4O1y5aV9t4zDRyAhxUEmmFBwEEPMhcB7SEG++1aPhlfYuUzMdeMU9vde57WuIXOyO5qBhDLmEBc6N4HfzcDeDJYPdj4dUL4W/m9gwcbyHRN1NSgud1scfggF0bTNGWmh9tQ9R3JYmTmQ4nrniAxQczeSgc4+jT/+4I5O5yYdEKLEgU85zOStIbY1rXNEdjuPmozBLDtCc+fHSEGknQpi04Ijk9fgaojCEU3qK4z3SE9ldgESsess4d6M/zZJQf3j3bfCxQyqg2xhFMhJWsRrB4kMuneP2lShSL5mPgyCDFoLjdGjmH4Igqip587daXOjQRe0bpu1JwlRLwWgOL8ZF4yWBvy5itk+XpLvjD5nGht17tIVc0pGkkRckWOVGc24rb/47M1ZjF1cpqi9WhL13PTIEcFjMRTKgwVI99B7VNCgzijWIEXjCG9rpA2Nx8VV1oTs2TWnB9ophAQ7No0LGHggYYtS5VLlZDCiBu+KxLZShJuzQ4vHCLlILzjx7wCVMQoVn+svoj/tBdLPOO3erD8ikE5w1Kg==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM5PR1101MB2218.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 64bed84a-82af-4dd6-50f2-08d875643d6b
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Oct 2020 01:54:25.9428
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5MDEeGs4vTBK5Ot3QgHrP2ST1oHkNZTVOB95wSt2oLct8W7CZd2RxUZkT+M1M8ZmUuRPrlgJtOU+3PF9bjIqIw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB3164
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org



> -----Original Message-----
> From: andriy.shevchenko@linux.intel.com
> <andriy.shevchenko@linux.intel.com>
> Sent: 19 October 2020 7:39 PM
> To: Sia, Jee Heng <jee.heng.sia@intel.com>
> Cc: Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>;
> dmaengine@vger.kernel.org; linux-kernel@vger.kernel.org; vkoul@kernel.org=
;
> Alexey Brodkin <Alexey.Brodkin@synopsys.com>
> Subject: Re: [PATCH 00/15] dmaengine: dw-axi-dmac: support Intel KeemBay
> AxiDMA
>=20
> On Mon, Oct 19, 2020 at 01:22:03AM +0000, Sia, Jee Heng wrote:
> > > From: Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>
> > > Sent: 16 October 2020 10:51 PM
>=20
> > > Hi Sia,
> > >
> > > Is this patch series available in some public git repo?
> > [>>] We do not have public git repo, but the patch series are tested
> > on kernel v5.9
>=20
> Sia, can you fork a kernel repository on GitHub or GitLab and create ther=
e a
> branch with this series based on v5.9?
[>>] Thanks Andy to help to create branch at https://gitlab.com/andy-shev/n=
ext/-/tree/topic/dw-dma-axi.
Eugeniy, you can start to use this branch and I shall learn to create a pub=
lic repo. Do let me know if you need anything else.
>=20
> > > I want to test it on our HW with DW AXI DMAC.
>=20
> Eugeniy, to be honest, it's not a big deal to create one either with help=
 of
> lore.kernel.org or patchwork [1].
>=20
> For your convenience (disclaimer, I can't guarantee I haven't missed some=
thing
> here) I published it here [2]. Note, I didn't compile it.
>=20
> [1]: https://patchwork.kernel.org/project/linux-
> dmaengine/cover/20201012042200.29787-1-jee.heng.sia@intel.com/
> [2]: https://gitlab.com/andy-shev/next/-/tree/topic/dw-dma-axi
>=20
> --
> With Best Regards,
> Andy Shevchenko
>=20

