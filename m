Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E8FE0C33B5
	for <lists+dmaengine@lfdr.de>; Tue,  1 Oct 2019 14:03:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726184AbfJAMDw (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 1 Oct 2019 08:03:52 -0400
Received: from mail-eopbgr810080.outbound.protection.outlook.com ([40.107.81.80]:22958
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725821AbfJAMDw (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Tue, 1 Oct 2019 08:03:52 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HKtLvINmp/cadYGnbWDFSNLous+S+yFvuwD6uRPWmxdOK89J0HOP6Oo9uBDIPY6BY2vsyg1gXeLzAxzNZdaSHggtjZSwxiAcWayMKz7ZuCi+Eva1JnNPW04OwJYLwr8kXr6wOg/RhxHFNJVNE6VahlJakMVw8rBl3lNivQ3qdQUuvGhPqpf1bJpCgiieUh3kIhswyr96d4dkcTuEUjOOaTnc4Sjwn9Sl9ncDCvdB+mY7UcIy5SnoWFm611xVby2/9GcjSeTKa5bEfcQZe7N/gcDLjEslh9ys20dCVz7SexETlttguRNw9J5I3XHAg3aW68MlHcuNsiuYlNGxeA//LQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YKh6HApMV0FiQZQT6Y+tm+TGxTtGB6hkOK0wPc7p58o=;
 b=WQmYknfqkE7QuueIG2IJ/ntaNzEwdp22duvO5/I1G72EeaGg+wmcRry0kPnjUi9S0Nh8LII1I7AZeINInwJRKeBYTg+IN96SFoHsiOWh9v0kKZamQcpM9N4wZSwallGZJom4pf9HkniKTes+GWvMHb9boIJbnc9SGbx6mo9DnV8YSyV2n7ZnACeHlHo1upgkt8mGDTIIBGrqZRS0OZXO3/2hlEF4JlTAGGoWUdOsw1ztqo0YqBn4sB8iKhklvIjuxek7nrFQ+bdmpSe5Jd+cwZAYJZyRv9a4u9YpckWv14qlE487GJjGYoap5K7xqCEzp7Rbw/ktJfhcaq4AYbbGHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=xilinx.com; dmarc=pass action=none header.from=xilinx.com;
 dkim=pass header.d=xilinx.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YKh6HApMV0FiQZQT6Y+tm+TGxTtGB6hkOK0wPc7p58o=;
 b=ZdsV2KMEUauVdjWMN1KsnTBJIPap3f/2hu8If6nQ930NWurvUIjSBK0ecWgJ4kP8uT9g9D1+jJVDdE9/TLWEpwAIjz3PyM1yLjPRINv2ZIMpXVu5Vi+GKfxeoiqheZXLs/EgDK3t50LatMi7iEoNklac6EohkDnt1t5fQ2dsbco=
Received: from CH2PR02MB7000.namprd02.prod.outlook.com (20.180.9.216) by
 CH2PR02MB6789.namprd02.prod.outlook.com (20.180.17.142) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2305.17; Tue, 1 Oct 2019 12:03:48 +0000
Received: from CH2PR02MB7000.namprd02.prod.outlook.com
 ([fe80::3515:e3a7:8799:73bd]) by CH2PR02MB7000.namprd02.prod.outlook.com
 ([fe80::3515:e3a7:8799:73bd%2]) with mapi id 15.20.2305.022; Tue, 1 Oct 2019
 12:03:48 +0000
From:   Radhey Shyam Pandey <radheys@xilinx.com>
To:     Vinod Koul <vkoul@kernel.org>
CC:     "dan.j.williams@intel.com" <dan.j.williams@intel.com>,
        Michal Simek <michals@xilinx.com>,
        "nick.graumann@gmail.com" <nick.graumann@gmail.com>,
        "andrea.merello@gmail.com" <andrea.merello@gmail.com>,
        Appana Durga Kedareswara Rao <appanad@xilinx.com>,
        "mcgrof@kernel.org" <mcgrof@kernel.org>,
        "dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH -next 3/8] dmaengine: xilinx_dma: Introduce
 xilinx_dma_get_residue
Thread-Topic: [PATCH -next 3/8] dmaengine: xilinx_dma: Introduce
 xilinx_dma_get_residue
Thread-Index: AQHVZAhKDg4F4xU8mE+kGY5hxnspoac9ALWAgACRLOCAAMLBgIAAyItAgAa2VkA=
Date:   Tue, 1 Oct 2019 12:03:48 +0000
Message-ID: <CH2PR02MB7000539B4F841BABC31AA07AC79D0@CH2PR02MB7000.namprd02.prod.outlook.com>
References: <1567701424-25658-1-git-send-email-radhey.shyam.pandey@xilinx.com>
 <1567701424-25658-4-git-send-email-radhey.shyam.pandey@xilinx.com>
 <20190925210123.GL3824@vkoul-mobl>
 <CH2PR02MB70008CE8600D98753BE1CC97C7860@CH2PR02MB7000.namprd02.prod.outlook.com>
 <20190926171801.GM3824@vkoul-mobl>
 <CH2PR02MB700025E26BBC12DA8B7DB6D2C7810@CH2PR02MB7000.namprd02.prod.outlook.com>
In-Reply-To: <CH2PR02MB700025E26BBC12DA8B7DB6D2C7810@CH2PR02MB7000.namprd02.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=radheys@xilinx.com; 
x-originating-ip: [149.199.50.133]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e2ba55d5-64b0-4895-7340-08d746676afb
x-ms-office365-filtering-ht: Tenant
x-ms-traffictypediagnostic: CH2PR02MB6789:|CH2PR02MB6789:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CH2PR02MB6789A13780930A90D504A18EC79D0@CH2PR02MB6789.namprd02.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-forefront-prvs: 0177904E6B
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(376002)(396003)(366004)(39860400002)(136003)(346002)(13464003)(76094002)(199004)(189003)(9686003)(305945005)(316002)(55016002)(76116006)(64756008)(66446008)(66556008)(54906003)(66946007)(66476007)(6246003)(4326008)(33656002)(486006)(6436002)(476003)(86362001)(478600001)(7736002)(74316002)(229853002)(446003)(66066001)(11346002)(99286004)(6116002)(3846002)(8936002)(8676002)(81156014)(81166006)(102836004)(71190400001)(53546011)(6506007)(2906002)(7696005)(6916009)(25786009)(71200400001)(76176011)(52536014)(26005)(256004)(186003)(5660300002)(14454004);DIR:OUT;SFP:1101;SCL:1;SRVR:CH2PR02MB6789;H:CH2PR02MB7000.namprd02.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: xilinx.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: BKEB1T0tFY++7rCOnpaBGZ//AhH3yDAXt+0/khZGpKsnTQyBNzAsK5S4Z9lENzlkBF1xm4ovuV+2VK0xcchSdhIZnjxsXAmyuWTCICbJcRPRcd8FY7+LsvgxNmZwHDpICV9tm7h3hOifl1gMZBXhrzREJ2qyGzI7wJ3xyIf16MiML1FQIzRlj4dhYRp6nqlXcGgXq9TDGb1KBomOn5/7amOwLeZEAg2h3qqPCDQfE9PlIjZlibndUuJzuTNUTmATXum86fIsdzcId3s7Z95iCplusV6gUkY/D3bcBQSEmBDo0jop4gt6+dQ6NZBer9kJAPeVltOkQV/+rLTvaAIBlBRi5d8ocWdEprXkmiBFt0acQ/6VxAj5ku5d0AvNYQoBjGHHjxNefLfsWU0M4uAkbrXGvy69bCfBLzuG62jO1/Q=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e2ba55d5-64b0-4895-7340-08d746676afb
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Oct 2019 12:03:48.5083
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xellDJf+yh7XuOldCf4Tn305YtrDgnWJmyFIkL1t03AcvCgKjVXd6d6YLLJ9JywuUdiRPcgjuNFoWbU+wfiDxw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR02MB6789
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

> -----Original Message-----
> From: Radhey Shyam Pandey
> Sent: Friday, September 27, 2019 10:46 AM
> To: Vinod Koul <vkoul@kernel.org>
> Cc: dan.j.williams@intel.com; Michal Simek <michals@xilinx.com>;
> nick.graumann@gmail.com; andrea.merello@gmail.com; Appana Durga
> Kedareswara Rao <appanad@xilinx.com>; mcgrof@kernel.org;
> dmaengine@vger.kernel.org; linux-kernel@vger.kernel.org
> Subject: RE: [PATCH -next 3/8] dmaengine: xilinx_dma: Introduce
> xilinx_dma_get_residue
>=20
> > -----Original Message-----
> > From: Vinod Koul <vkoul@kernel.org>
> > Sent: Thursday, September 26, 2019 10:48 PM
> > To: Radhey Shyam Pandey <radheys@xilinx.com>
> > Cc: dan.j.williams@intel.com; Michal Simek <michals@xilinx.com>;
> > nick.graumann@gmail.com; andrea.merello@gmail.com; Appana Durga
> > Kedareswara Rao <appanad@xilinx.com>; mcgrof@kernel.org;
> > dmaengine@vger.kernel.org; linux-kernel@vger.kernel.org
> > Subject: Re: [PATCH -next 3/8] dmaengine: xilinx_dma: Introduce
> > xilinx_dma_get_residue
> >
> > On 26-09-19, 05:52, Radhey Shyam Pandey wrote:
> >
> > > > > +	 * VDMA and simple mode do not support residue reporting,
> so the
> > > > > +	 * residue field will always be 0.
> > > > > +	 */
> > > > > +	if (chan->xdev->dma_config->dmatype =3D=3D
> XDMA_TYPE_VDMA ||
> > > > !chan->has_sg)
> > > > > +		return residue;
> > > >
> > > > why not check this in status callback?
> > > Assuming we mean to move vdma and non-sg check to
> > xilinx_dma_tx_status.
> > > Just a thought- Keeping this check in xilinx_dma_get_residue
> > > provides an abstraction and caller can simply call this func with
> > > knowing about IP config specific residue calculation. Considering
> > > this point does it looks ok ?
> >
> > well you are checking either way, so calling the lower level function
> > only when you need it makes more sense!
>=20
> Sure, will do it in v2.

Just noticed that xilinx_dma_get_residue() is called at the multiple
places i.e one in device_tx_status and other in _complete_descriptor.
To avoid code duplication, I will create a helper function to check
if residue calculation is supported.

> >
> > --
> > ~Vinod
