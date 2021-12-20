Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9DD4F47B014
	for <lists+dmaengine@lfdr.de>; Mon, 20 Dec 2021 16:25:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235484AbhLTPYz (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 20 Dec 2021 10:24:55 -0500
Received: from mail-bn7nam10on2045.outbound.protection.outlook.com ([40.107.92.45]:9056
        "EHLO NAM10-BN7-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S239977AbhLTPXe (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Mon, 20 Dec 2021 10:23:34 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=l05UkGmCieZAgPQOXi0lwDZRCSqd1MdKqitpO6lvrNoNwmT93K/MGUyM2v7hnxQTliAjGirIQQK/TtoxJCuIH485LPZKfpIgBEDJXtaqxRnqQBh3lLNMBRzP+N+1OU6SbwE85m5oYTrL4qCnNv4VvUHqxPL1GwkRnepZeIEdoIFhFiL6AGy4JwusORoko+P8PpVGfZwjk8DRrFe1rqiFa6ss0n9l9zLvX5/Hioo+sICXPXBmJ7yMdFX0muX4nXEoOTyZ7az5cCmICu6fsPA4gFtQwi9DyIts9G/QIhO2JyOBismGInSZK01hqimoCuDNuuoFN19vnBH2x2VSMbSOLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hLtTDwR4l1KK3uCtpJ/Tso6X22XlWvjjzWZhRWvkuHY=;
 b=nycoNB0pJcW8Y03ft8nAxOZ0VcXDH2QZTT/pztuvVXO9GHXUQDNiy11VGNzPCx0Iz26IUDXdwQHFoKbujvyvjZxiPbAdic/y+c9+t8cwum7N5C65CXMXvgA0omcu568YtP37U+HeMtM9WB0ITTdV7Mklm7H28FJowNDS6uGcE0mbmVCTgc6bmrliBrgWxoscSQsgUbJaqbo42PPaEarzZAykFFTmqyyT+/O62Bi1/kvJpzQNNVT8vRIy7WOMdcOxx9bWDECmJjKJJPKoOR9t0gqdf9lF3j+TjdiQlMX0LUWPn3CXdN1D9KpeZFCf42mZ/Ni/o0N+kUcmOgpRUQG7dw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hLtTDwR4l1KK3uCtpJ/Tso6X22XlWvjjzWZhRWvkuHY=;
 b=QZdcjpt75ReZ+PGgVOgwv9frRJxbs/wsB0W3KP0o+9UuRo33W7VSTs2BFFh/kZ5VgDdgYQd2RQvI1MmcNlZKZC7AXa4TQF1m/B8tUi30/B6XUOZ7aq5rvPb6H13as4irf8GdrfN+vyfwtrdoXznnoiu5Hrc1pKaZTflRpxmJCnvcc3ZLIZo2NpW/5nOee3SzN0Q/TzocfK9V7JdyO9FbKsqTrp4zBCkIYD+rQ35wwe2+xn740USdOmAT26eAeOiPBPucyTXTBxJp/LF6ShJn2g/DGukCrNiJkHI200Vm2A0/CsaIuc2/S6gPYU4rExzFLdM4ld5GSpzkC4BsHwtsdg==
Received: from BN9PR12MB5273.namprd12.prod.outlook.com (2603:10b6:408:11e::22)
 by BN9PR12MB5228.namprd12.prod.outlook.com (2603:10b6:408:101::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4801.20; Mon, 20 Dec
 2021 15:23:32 +0000
Received: from BN9PR12MB5273.namprd12.prod.outlook.com
 ([fe80::6867:d54e:5040:2167]) by BN9PR12MB5273.namprd12.prod.outlook.com
 ([fe80::6867:d54e:5040:2167%5]) with mapi id 15.20.4801.020; Mon, 20 Dec 2021
 15:23:32 +0000
From:   Akhil R <akhilrajeev@nvidia.com>
To:     Dmitry Osipenko <digetx@gmail.com>,
        "dan.j.williams@intel.com" <dan.j.williams@intel.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Krishna Yarlagadda <kyarlagadda@nvidia.com>,
        Laxman Dewangan <ldewangan@nvidia.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>,
        "p.zabel@pengutronix.de" <p.zabel@pengutronix.de>,
        Rajesh Gumasta <rgumasta@nvidia.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "thierry.reding@gmail.com" <thierry.reding@gmail.com>,
        "vkoul@kernel.org" <vkoul@kernel.org>
CC:     Pavan Kunapuli <pkunapuli@nvidia.com>
Subject: RE: [PATCH v15 2/4] dmaengine: tegra: Add tegra gpcdma driver
Thread-Topic: [PATCH v15 2/4] dmaengine: tegra: Add tegra gpcdma driver
Thread-Index: AQHX8qAe1UN3/N1l0EeiZPTfHL7S8qw1Y1YAgAC790A=
Date:   Mon, 20 Dec 2021 15:23:31 +0000
Message-ID: <BN9PR12MB52730121B2B01739DA52020EC07B9@BN9PR12MB5273.namprd12.prod.outlook.com>
References: <1639674720-18930-1-git-send-email-akhilrajeev@nvidia.com>
 <1639674720-18930-3-git-send-email-akhilrajeev@nvidia.com>
 <45ba3abe-5e7e-4917-2b23-0616a758c4eb@gmail.com>
In-Reply-To: <45ba3abe-5e7e-4917-2b23-0616a758c4eb@gmail.com>
Accept-Language: en-IN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b8db4ae4-0326-41f2-4a92-08d9c3ccaeb0
x-ms-traffictypediagnostic: BN9PR12MB5228:EE_
x-microsoft-antispam-prvs: <BN9PR12MB522887AFADFDFD546DE9D90AC07B9@BN9PR12MB5228.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5516;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Xf/hyXxkDprATOZgzwUUDUOcRp+TTWKVhRaG745iliSIHa3cBdpXok1ga4fFByWurNpWam2M0CaWWWl46aPsRqYGu3Ojol6kgBYMZQBPZdQ2ofjTLmZFSNZ5laGX9Zjbx/GyrUZDgPOsjg8aDRranjjA5CGkfRfImfoYGVI59SYHbUdlsqCTyB97FB+OKJQAS1mgaE71XPLFwGt3NILWezlcyquA2z4UZKnvVgEqBNXJhbaxhMccFcx4rk6Z4LHhCQU4wmHAqfSZnpGq8aA/b6CpRKhi7RumbbfS6Adq47h5XVH2LJHZAKoJzqGlFb09WR2HlfM6rQ7oxio4Crs01Dmr2zVc0rU1XP8qmH/AJcO6PlAp0dNz4SWEeWQNXVjm362qCd7jEdur/OIpeDBIZfV3Voub43MIPigk6dNnHX3M6kbGfp/XABuVPNg8goCTXN50zXa1suuM3ybV6dMA0M7Hi5M2En/07aeEWqGgYVJ9Sipzi/60kt31W8CKKNMqTdoxs6fWT/3Q6ypSL8o58yBex7GNNEtWGUaeruLhmIOzfnBTvQmQMshgPqua05PFBQVm3mX9jIYt/X4oWlibzVdCKO57xC2bXUpWhQnihKwvvGhiXFVu29pXOG+2F7jdJcUH9BVcNX7kvkf+uf81IAEpX4ATbhvAavyOtVWo+HnTkxxYIdGs8J3bQsiHE6Z2Ln2ceUK/nGEtINU1ifUn/Q7mlSOXmOsQaD9+/pz6D+kIzl+ZDPCp5skHriJpXrgEBCNr152IOf/+CFaAOVJvJrDEwM/NhbQ02s05fJbdKqtWKEdH03WjCDbHgTclY0Jo
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR12MB5273.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(2906002)(33656002)(7696005)(966005)(8676002)(5660300002)(55016003)(71200400001)(508600001)(7416002)(38070700005)(83380400001)(52536014)(4326008)(316002)(107886003)(9686003)(76116006)(8936002)(86362001)(6506007)(921005)(64756008)(55236004)(66446008)(66476007)(66556008)(66946007)(122000001)(26005)(38100700002)(186003)(110136005);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?koi8-r?Q?sVAkcoUw4KAebSmV/eHQrKFoY6CGNg1jAf/D1qrhpMb2zSQxHA5MnbCQrX/vhe?=
 =?koi8-r?Q?gmA5NZSqjVp+XlhinZVq+Nh2gUUf8VFPp0S1hn8+a75xDhnHtbP8IiPfONXngl?=
 =?koi8-r?Q?vPAuOlu6AET/hq2bP7TOqIoxnsaHrkJkZLlmKmRetgfkCoFhEJBk38gBbsR+t1?=
 =?koi8-r?Q?7FTkpUhlSxyVEvTzoeoQl1E8pHy51Ln7SWKWhxqvuONhy3/I40OQfy1Tzduk5n?=
 =?koi8-r?Q?ue5TFPFsUsVOd5NvMrSDwhR4yDpnIzXnAI9xoNoC4m6/sxR6U7cG6oS/lPnpp/?=
 =?koi8-r?Q?RZvXjHNpUg9EoZpnry7MQHAsvz60gr+MqfsvmMrN2fY7rhMdLsW7UPQs3u9gVc?=
 =?koi8-r?Q?Mtu4HI7U64U6GdnHJciCMrqjEjQsV9t2Fv+i+IA5u8KBohmavl2u7y2VECOZMT?=
 =?koi8-r?Q?0HxY/XpHegxJWOp/leUy67HlpljLrN416StukbBsf9SmbmtF1h/thwJ1r8pPtb?=
 =?koi8-r?Q?1l4/qlk17J3zo/w69B0WspOvpmCeiiWuocunOx89EFmCef31YdoJz1Ufb4P5Bk?=
 =?koi8-r?Q?9Nfh0s8IL+Z8LcIkmV/J1xii92L01Rv5SwAnMMURV5T61OOj1fgJSTfjx+G1dY?=
 =?koi8-r?Q?kUl73yxhtFcUfK9Z4wPfed/Gx/Ad9YsYmLbTCi9iHX9CsPdNwzBafdTc0O13Va?=
 =?koi8-r?Q?AY74pw1Ike3fPMC2rM4ZTvDM+d+xtz2Y15MJEclDe4csrY5hJB1swhtrSLIwSx?=
 =?koi8-r?Q?519nUOTO78A0L+d2Xe8qZ4EfBWVmZEKByuY1eyRXcOd7whzPlq7wBDaZDUUbyk?=
 =?koi8-r?Q?aQvARuUQZRMr4E/tDUGoawvAq3tV/E+KmOUkBrypiSQKmkmfshtSgIF77Qt8Uj?=
 =?koi8-r?Q?GTl4zoElZP4g07KGPlmxXh9wI4EcBqTcgUn44ZcYKOh5ERfnfA6G/5OfemUt6w?=
 =?koi8-r?Q?22gq5RkTpkR1VrmCK0sWBcSrjmGaU2FY/0VduxWVVppLO+61KSh+xXbr16rkI0?=
 =?koi8-r?Q?zC0hsgvkNV184IrP3ZUcFMzoS40Gdc5UyS0BX4ua25dOT/pdrXRCltr1an6HJV?=
 =?koi8-r?Q?lGlEI9+Qp7zIi7dv3K1DzmWjZ8su2ssysS/M0TRlptY6tqoKW43T4tIYnLLMv9?=
 =?koi8-r?Q?EuwzTwPPhscjJs3T9SgkGTG9DSQ38zClxdzfRvyoWUXzGqgBJqnyflbAL6htct?=
 =?koi8-r?Q?V4EG9CL/GlFARdUxeOw9EZPj1JBzu9Om7OJOfxhjotF2+BWoLCFEM43yYJcAgP?=
 =?koi8-r?Q?zihXFpHDFX146TKpr7Osx9720xsR14TE2QJ9RLk+Jcwec4Pte75z+89Cmf+r+p?=
 =?koi8-r?Q?qJHtJ6FdNnaGr6VlzIRDvPD+89l/rz+YIXhs6JXeAp3X/PG+LiBAnZcvVXzosO?=
 =?koi8-r?Q?Kgyul38vusnVYahTr2EnV7aYIvozc/SJ5cKwxV2sDUOPP+JcHwoLgnk7wAtXWR?=
 =?koi8-r?Q?xtfssvo+WCAAXoaikhTSeteaSGT2UAfWmyzMNdHaReb+7jkkO8I9YXuGZjtRzT?=
 =?koi8-r?Q?WqYYZD+DwIhm8IQQY8bA+lxRFXxIYwTWo+SJt2TAS935KpAHdI8fJDUk6xjfY7?=
 =?koi8-r?Q?YRtO7oVzdkUlXC93KeIlZ2b/Fo81W6KDcrWTRbM8by7tg6euFZYFLnbhlRgrgh?=
 =?koi8-r?Q?ilcGNm3r4lUmSO/4rwkGt9OwPr4M4m4=3D?=
Content-Type: text/plain; charset="koi8-r"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5273.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b8db4ae4-0326-41f2-4a92-08d9c3ccaeb0
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Dec 2021 15:23:31.9907
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4mxgX0ZQvH0iauALGlOo+j1DDG2JphwBor/6/8psEQE9WYV7OiG9rAc9KoPJrK5CwrcKgtcpRnEvrVueIiMobQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5228
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

> 16.12.2021 20:11, Akhil R =D0=C9=DB=C5=D4:
> > +static int tegra_dma_terminate_all(struct dma_chan *dc) {
> > +     struct tegra_dma_channel *tdc =3D to_tegra_dma_chan(dc);
> > +     unsigned long wcount =3D 0;
> > +     unsigned long status;
> > +     unsigned long flags;
> > +     int err;
> > +
> > +     raw_spin_lock_irqsave(&tdc->lock, flags);
> > +
> > +     if (!tdc->dma_desc) {
> > +             raw_spin_unlock_irqrestore(&tdc->lock, flags);
> > +             return 0;
> > +     }
> > +
> > +     if (!tdc->busy)
> > +             goto skip_dma_stop;
> > +
> > +     if (tdc->tdma->chip_data->hw_support_pause)
> > +             err =3D tegra_dma_pause(tdc);
> > +     else
> > +             err =3D tegra_dma_stop_client(tdc);
> > +
> > +     if (err) {
> > +             raw_spin_unlock_irqrestore(&tdc->lock, flags);
> > +             return err;
> > +     }
> > +
> > +     status =3D tdc_read(tdc, TEGRA_GPCDMA_CHAN_STATUS);
> > +     if (status & TEGRA_GPCDMA_STATUS_ISE_EOC) {
> > +             dev_dbg(tdc2dev(tdc), "%s():handling isr\n", __func__);
> > +             tegra_dma_xfer_complete(tdc);
> > +             status =3D tdc_read(tdc, TEGRA_GPCDMA_CHAN_STATUS);
> > +     }
> > +
> > +     wcount =3D tdc_read(tdc, TEGRA_GPCDMA_CHAN_XFER_COUNT);
> > +     tegra_dma_stop(tdc);
> > +
> > +     tdc->dma_desc->bytes_transferred +=3D
> > +                     tdc->dma_desc->bytes_requested - (wcount * 4);
> > +
> > +skip_dma_stop:
> > +     tegra_dma_sid_free(tdc);
> > +     vchan_free_chan_resources(&tdc->vc);
> > +     kfree(&tdc->vc);
>=20
> You really going to kfree the head of tegra_dma_channel here? Once again,=
 this
> code was 100% untested :/
I did validate this using DMATEST which did not show any error.
https://www.kernel.org/doc/html/latest/driver-api/dmaengine/dmatest.html
Do you suggest something better?

> You're not allowed to free channel from the dma_terminate_all() callback.=
 This
> callback terminates submitted descs, that's it.
>=20
Sorry, I am relatively new to DMA framework (probably you get it from the p=
atch=20
version no. :)). I read your previous comment as to use tdc->vc instead of =
dma_desc.
I would learn a bit more and update with a change. Thanks for the inputs.

Thanks,
Akhil

--
nvpublic
